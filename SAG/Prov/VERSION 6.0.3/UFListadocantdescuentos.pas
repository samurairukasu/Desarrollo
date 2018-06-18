unit UFListadocantdescuentos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, comobj, Dialogs, FMTBcd, DBClient, Provider, SqlExpr;

type
  Tfrmlistadocantdescuentos = class(TForm)
    ti: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    Print: TSpeedItem;
    Ascci: TSpeedItem;
    Excel: TSpeedItem;
    SBBusqueda: TSpeedItem;
    SBSalir: TSpeedItem;
    OpenDialog: TOpenDialog;
    sdsTTMPARQCAJA: TSQLDataSet;
    DataSetProvider1: TDataSetProvider;
    QTTMPLISTCANTDESCUENTOS: TClientDataSet;
    DSourceArqueoCaja: TDataSource;
    DBGridArqueoCaja: TDBGrid;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PutSumaryResults;
    procedure PrintClick(Sender: TObject);
    procedure SBBusquedaClick(Sender: TObject);
    procedure SBSalirClick(Sender: TObject);
    procedure AscciClick(Sender: TObject);
    procedure ExcelClick(Sender: TObject);
    procedure OnOpen (Sender: TObject);
    procedure OnClose (Sender: TObject);
  public
    { Public declarations }
    bErrorCreando : boolean;
    NombreEstacion, NumeroEstacion,
    TipoPago,
    DateIni, DateFin : string;
    function PutEstacion : string;
  end;

  procedure GenerateListadoCantDescuento;
  procedure DoListadoCantDescuento(const FI,FF: string);

var
  frmlistadocantdescuentos: Tfrmlistadocantdescuentos;

implementation

{$R *.DFM}


uses
   UCDIALGS,
   UUTILS,
   UGETDATES,
   ULOGS,
   GLOBALS,
   UFListCantDescuentosToPrint,
   UFTMP,
   USAGESTACION,
   USAGVARIOS,
   UFPORTIPO,
   USAGCLASSES;


resourcestring
    FICHERO_ACTUAL = 'UFListadoDescuentos.PAS';

const
    TIPO_ARQUEO_DESCUENTOS = 'D';


procedure DoListadoCantDescuento(const FI,FF: string);

begin
    DeleteTable(MyBD, 'TTMPRESDESCUENT');

    with TSQLStoredProc.Create(nil) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_RESDESCUENTOS.DORESDESCUENTOS';

        Prepared := true;
        ParamByName('FI').Value := FI;
        ParamByName('FF').Value := FF;

        ExecProc;
        Close;
    finally
        Free
    end
end;


procedure GenerateListadoCantDescuento;
begin

        with Tfrmlistadocantdescuentos.Create(Application) do
        try
            try
                if bErrorCreando then exit;

                If not GetDates(DateIni,DateFin) then Exit;

                Caption := Format('Listado Resumen de Descuentos. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                FTmp.Temporizar(TRUE,FALSE,'Listado Resumen de Descuentos', 'Generando el informe Resumen de Descuentos.');
                Application.ProcessMessages;

                DoListadoCantDescuento(DateIni, DateFin);

                FTmp.Temporizar(FALSE,FALSE,'', '');
                Application.ProcessMessages;

                PutSumaryResults;
                ShowModal;
            except
                on E: Exception do
                begin
                    FTmp.Temporizar(FALSE,FALSE,'', '');
                    Application.ProcessMessages;
                    FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
                    MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)
                end
            end
        finally
            Free;
            Application.ProcessMessages;
        end;
end;

procedure Tfrmlistadocantdescuentos.FormCreate(Sender: TObject);
begin
    bErrorCreando := False;

    if (not MyBD.InTransaction) then MyBD.StartTransaction(td);

    try
        LoockAndDeleteTable(MyBD, 'TTMPRESDESCUENT')
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
            MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
            bErrorCreando := True
        end
    end
end;

procedure Tfrmlistadocantdescuentos.FormDestroy(Sender: TObject);
begin
    QTTMPLISTCANTDESCUENTOS.Close;

    try
        try
            if MyBD.InTransaction then
              Begin
                MyBD.Rollback(td); // MyBD.Commit
              end
            else raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del arqueo de Caja')
        except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'Error cerrando la ficha de UArqueoCaja: %s', [E.message]);
                MessageDlg('Generación de Informes.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end
        end
    finally
        FTmp.Temporizar(FALSE,FALSE,'','');
    end
end;

function Tfrmlistadocantdescuentos.PutEstacion : string;
begin
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
    Result := NumeroEstacion + ' ' + NombreEstacion;
end;


procedure Tfrmlistadocantdescuentos.PutSumaryResults;
begin
    try
        with QTTMPLISTCANTDESCUENTOS do
        begin
            Close;
            sdsTTMPARQCAJA.SQLConnection := MyBD;
            CommandText := 'SELECT DESCUENTO, CANTNORM,IMPONORM,DIFNORM, CANTMAY20,IMPOMAY20,DIFMAY20, ' +
                    'CANTVTVIG, IMPOVTVIG,DIFVTVIG '+
                    'FROM TTMPRESDESCUENT ORDER BY CODDESCU ';
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTCANTDESCUENTOS);
            {$ENDIF}
            Open;
        end
    finally
        Application.ProcessMessages;
    end;
end;


procedure Tfrmlistadocantdescuentos.PrintClick(Sender: TObject);
begin
                    with TFrmListCantDescuentosToPrint.Create(Application) do
                    try
                        Execute(DateIni, DateFin, NombreEstacion, NumeroEstacion);
                    finally
                        Free;
                    end;
end;

procedure Tfrmlistadocantdescuentos.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            If Not GetDates(DateIni,DateFin) Then Exit;

            Caption := Format('Listado Resumen de Descuentos. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
            FTmp.Temporizar(TRUE,FALSE,'Listado Resumen de Descuentos','Generando el informe Resumen de Descuentos.');
            Application.ProcessMessages;

            DoListadoCantDescuento(DateIni, DateFin);

            FTmp.Temporizar(FALSE,FALSE,'','');
            Application.ProcessMessages;

            PutSumaryResults;

        except
            on E: Exception do
            begin
                FTmp.Temporizar(FALSE,FALSE,'','');
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
                MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo' , mtError, [mbOk], mbOk, 0);
            end
        end
    finally
        Enabled := True;
        Show;
        Application.ProcessMessages
    end
end;

procedure Tfrmlistadocantdescuentos.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure Tfrmlistadocantdescuentos.AscciClick(Sender: TObject);
begin
                    with TFrmListCantDescuentosToPrint.Create(Application) do
                    try
                        ExportaAscii(DateIni, DateFin, NombreEstacion, NumeroEstacion);
                    finally
                        Free;
                    end;
end;

procedure Tfrmlistadocantdescuentos.ExcelClick(Sender: TObject);
const
    F_TTL = 1;   C_TTL = 4;
    F_STT = 2;   C_STT = 4;
    F_INI = 7;

var
    i,f : integer;
    ExcelApp, ExcelLibro, ExcelHoja: Variant;
begin


  try
    DBGridArqueoCaja.DataSource.DataSet.DisableControls;
    try
      opendialog.Title := 'Seleccione la Planilla de Entrada';
      if OpenDialog.Execute then
      begin
        FTmp.Temporizar(TRUE,FALSE,'Resumen de descuentos', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        try  //porque en  la plantilla la hoja tiene como nombre Resumen Descuentos
          ExcelHoja := ExcelLibro.Worksheets['Resumen Descuentos'];
        except
          ExcelHoja := ExcelLibro.Worksheets['Hoja1'];
        end;

        f:= F_INI;
        excelHoja.cells[F_TTL,C_TTL].value := 'Listado Resumen de Descuentos';
        excelHoja.cells[F_STT,C_STT].value := Format('Planta Nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);

        QTTMPLISTCANTDESCUENTOS.First;
        while not QTTMPLISTCANTDESCUENTOS.EOF do
        begin
             for i := 0 to DBGridArqueoCaja.Columns.Count - 1 do
                 excelHoja.cells[f,i+1].value := conviertecomaenpunto(QTTMPLISTCANTDESCUENTOS.FieldByName(DBGridArqueoCaja.Columns[i].FieldName).AsString);
             QTTMPLISTCANTDESCUENTOS.Next;
             inc(f);
             end;
        QTTMPLISTCANTDESCUENTOS.First;
      end;

      opendialog.Title := 'Seleccione la Planilla de Salida';
      if OpenDialog.Execute then
         excellibro.saveas(opendialog.filename);
      ExcelApp.Quit;
    except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de UIVABook: %s', [E.message]);
                MessageDlg('Generación de Informes.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end
    end;
  finally
      DBGridArqueoCaja.DataSource.DataSet.enableControls;
      FTmp.Temporizar(FALSE,FALSE,'','');
      application.ProcessMessages;
  end;

end;


procedure Tfrmlistadocantdescuentos.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure Tfrmlistadocantdescuentos.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;




end.


