unit UFResumendescuentosGNC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, ComObj, Dialogs, FMTBcd, DBClient, Provider, SqlExpr;

type
  TfrmResumenDescuentosGNC = class(TForm)
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
    sdsQTTMPLISTCANTDESCUENTOS: TSQLDataSet;
    dspQTTMPLISTCANTDESCUENTOS: TDataSetProvider;
    QTTMPLISTCANTDESCUENTOS: TClientDataSet;
    DBGridResDesc: TDBGrid;
    DSourceArqueoCaja: TDataSource;

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

  procedure GenerateResumenDescuentoGNC;
  procedure DoResumenDescuentoGNC(const FI,FF: string);

var
  frmResumenDescuentosGNC: TfrmResumenDescuentosGNC;

implementation

{$R *.DFM}


uses
   UCDIALGS,
   UUTILS,
   UGETDATES,
   ULOGS,
   GLOBALS,
   UFResumenDescuentosToPrintGNC,
   UFTMP,
   USAGESTACION,
   USAGVARIOS,
   UFPORTIPO,
   USAGCLASSES;


resourcestring
    FICHERO_ACTUAL = 'UFResumendescuentosGNC.PAS';

const
    TIPO_ARQUEO_DESCUENTOS = 'D';


procedure DoResumenDescuentoGNC(const FI,FF: string);

begin
    DeleteTable(MyBD, 'TTMPRESDESCUENTGNC');

    with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_RESDESCUENTOSGNC.DORESDESCUENTOSGNC';

        Prepared := True;
        ParamByName('FI').Value := FI;
        ParamByName('FF').Value := FF;

        ExecProc;
        Close;

    finally
        Free
    end
end;


procedure GenerateResumenDescuentoGNC;
begin

        with TfrmResumenDescuentosGNC.Create(Application) do
        try
            try
                if bErrorCreando then exit;

                If not GetDates(DateIni,DateFin) then Exit;

                Caption := Format('Resumen de Descuentos GNC. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                FTmp.Temporizar(TRUE,FALSE,'Listado Resumen de Descuentos GNC', 'Generando el informe Resumen de Descuentos GNC.');
                Application.ProcessMessages;

                DoResumenDescuentoGNC(DateIni, DateFin);

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

procedure TfrmResumenDescuentosGNC.FormCreate(Sender: TObject);
begin
    bErrorCreando := False;

    if (not MyBD.InTransaction) then MyBD.StartTransaction(td);

    try
        LoockAndDeleteTable(MyBD, 'TTMPRESDESCUENTGNC')
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
            MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
            bErrorCreando := True
        end
    end
end;

procedure TfrmResumenDescuentosGNC.FormDestroy(Sender: TObject);
begin
    QTTMPLISTCANTDESCUENTOS.Close;

    try
        try
            if MyBD.InTransaction then MyBD.Rollback(td) // MyBD.Commit
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

function TfrmResumenDescuentosGNC.PutEstacion : string;
begin
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
    Result := NumeroEstacion + ' ' + NombreEstacion;
end;


procedure TfrmResumenDescuentosGNC.PutSumaryResults;
begin
    try
        with QTTMPLISTCANTDESCUENTOS do
        begin
            Close;
            sdsQTTMPLISTCANTDESCUENTOS.SQLConnection := MyBD;
            CommandText := 'SELECT DESCUENTO, CANTIDAD,IMPORTES FROM TTMPRESDESCUENTGNC ORDER BY CODDESCU ';
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTCANTDESCUENTOS);
            {$ENDIF}

            Open;
        end
    finally
        Application.ProcessMessages;
    end;
end;


procedure TfrmResumenDescuentosGNC.PrintClick(Sender: TObject);
begin
                    with TFrmResumenDescuentosToPrintGNC.Create(Application) do
                    try
                        Execute(DateIni, DateFin, NombreEstacion, NumeroEstacion);
                    finally
                        Free;
                    end;
end;

procedure TfrmResumenDescuentosGNC.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            If Not GetDates(DateIni,DateFin) Then Exit;

            Caption := Format('Resumen de Descuentos GNC. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
            FTmp.Temporizar(TRUE,FALSE,'Listado Resumen de Descuentos GNC','Generando el informe Resumen de Descuentos GNC.');
            Application.ProcessMessages;

            DoResumenDescuentoGNC(DateIni, DateFin);

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

procedure TfrmResumenDescuentosGNC.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure TfrmResumenDescuentosGNC.AscciClick(Sender: TObject);
begin
                    with TFrmResumenDescuentosToPrintGNC.Create(Application) do
                    try
                        ExportaAscii(DateIni, DateFin, NombreEstacion, NumeroEstacion);
                    finally
                        Free;
                    end;
end;

procedure TfrmResumenDescuentosGNC.ExcelClick(Sender: TObject);
const
    F_TTL = 1;   C_TTL = 4;
    F_STT = 2;   C_STT = 4;
    F_INI = 7;
var
    ExcelApp, ExcelLibro, ExcelHoja: Variant;
    i,f : integer;
begin

  try
    DBGridResDesc.DataSource.DataSet.DisableControls;
    try
      opendialog.Title := 'Seleccione la Planilla de Entrada';
      if OpenDialog.Execute then
      begin
        FTmp.Temporizar(TRUE,FALSE,'Resumen de Descuentos GNC', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        try
          ExcelHoja := ExcelLibro.Worksheets['Hoja1'];
        except
          ExcelHoja := ExcelLibro.Worksheets['Resumen Descuentos'];
        end;

        f:= F_INI;

        excelHoja.cells[F_TTL,C_TTL].value := 'Listado Resumen de Descuentos GNC';
        excelHoja.cells[F_STT,C_STT].value := Format('Planta Nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);

        QTTMPLISTCANTDESCUENTOS.First;
        while not QTTMPLISTCANTDESCUENTOS.EOF do
        begin
             for i := 0 to DBGridResDesc.Columns.Count - 1 do
                 excelHoja.cells[f,i+1].value := conviertecomaenpunto(QTTMPLISTCANTDESCUENTOS.FieldByName(DBGridResDesc.Columns[i].FieldName).AsString);
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
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de UfResumenDescuentosGNC: %s', [E.message]);
                MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
            end
    end;
  finally
      DBGridResDesc.DataSource.DataSet.enableControls;
      FTmp.Temporizar(FALSE,FALSE,'','');
      application.ProcessMessages;
  end;

end;


procedure TfrmResumenDescuentosGNC.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TfrmResumenDescuentosGNC.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;




end.


