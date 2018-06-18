unit UFListadoDecJuradas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, UDDEExcelObject, SqlExpr, FMTBcd, Provider, DBClient, Dialogs, ComObj;

type
  TfrmListadoDecJuradas = class(TForm)
    Label6: TLabel;
    ti: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    Print: TSpeedItem;
    Excel: TSpeedItem;
    SBBusqueda: TSpeedItem;
    SBSalir: TSpeedItem;
    DSourceArqueoCaja: TDataSource;
    DBGridArqueoCaja: TDBGrid;
    sdsQTTMPRENDICIONACA: TSQLDataSet;
    QTTMPRENDICIONACA: TClientDataSet;
    dspQTTMPRENDICIONACA: TDataSetProvider;
    OpenDialog: TOpenDialog;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PutSumaryResults;
    procedure PrintClick(Sender: TObject);
    procedure SBBusquedaClick(Sender: TObject);
    procedure SBSalirClick(Sender: TObject);
    procedure ExcelClick(Sender: TObject);
    procedure OnOpen (Sender: TObject);
    procedure OnClose (Sender: TObject);
    Procedure ExportacionExcelGeneral;
  public
    { Public declarations }
    bErrorCreando : boolean;
    NombreEstacion, NumeroEstacion,
    TipoPago,
    DateIni, DateFin,
    TotalDec : string;
    function PutTipoPago(const aTP : string): string;
    function PutEstacion : string;
  end;

  procedure GenerateListadoDecJuradas;
  procedure DoListadoDecJuradas(const FI,FF: string; var sTotDec: string);

var
  frmListadoDecJuradas: TfrmListadoDecJuradas;

implementation

{$R *.DFM}


uses
   UCDIALGS,
   UUTILS,
   UGETDATES,
   ULOGS,
   GLOBALS,
   UFTMP,
   USAGESTACION,
   UListadoDecJuradasToPrint;

resourcestring
    FICHERO_ACTUAL = 'UFListadoDecJuradas.PAS';


procedure DoListadoDecJuradas(const FI,FF: string; var sTotDec: string);
begin
    DeleteTable(MyBD, 'TTMPDJURADA');

    with TSQLStoredProc.Create(application) do
    try
       SQLConnection:= MyBD;
       StoredProcName := 'PQ_LIST_VARIOS.DOLISTADECJURADA';
       ParamByName('FECHAINI').Value := FI;
       ParamByName('FECHAFIN').Value := FF;
       ExecProc;

        sTotDec := ParamByName('NumJuradas').AsString;
        Close;
    finally
        Free
    end
end;

procedure GenerateListadoDecJuradas;
begin

        with TfrmListadoDecJuradas.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                TotalDec := '0';

                If not GetDates(DateIni,DateFin) then Exit;

                Caption := Format('Listado de Declaraciones Juradas. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                FTmp.Temporizar(TRUE,FALSE,'Listado de Declaraciones Juradas', 'Generando el informe Listado de Declaraciones Juradas.');
                Application.ProcessMessages;

                DoListadoDecJuradas(DateIni, DateFin, TotalDec);

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


procedure TfrmListadoDecJuradas.FormCreate(Sender: TObject);
begin
    bErrorCreando := False;

    if (not MyBD.InTransaction) then MyBD.StartTransaction(td);

    try
        LoockAndDeleteTable(MyBD, 'TTMPRENDICIONACA')
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
            MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
            bErrorCreando := True
        end
    end
end;

procedure TfrmListadoDecJuradas.FormDestroy(Sender: TObject);
begin
    QTTMPRENDICIONACA.Close;

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

function TfrmListadoDecJuradas.PutEstacion : string;
begin
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
    Result := NumeroEstacion + ' ' + NombreEstacion;
end;


function TfrmListadoDecJuradas.PutTipoPago(const aTP : string) : string;
begin
            result := S_FORMA_PAGO[tfpCheque];
            TipoPago := V_FORMA_PAGO[tfpCheque];
end;

procedure TfrmListadoDecJuradas.PutSumaryResults;
begin
    try

        with QTTMPRENDICIONACA do
        begin
            Close;
            sdsQTTMPRENDICIONACA.SQLConnection := MyBD;
            sdsQTTMPRENDICIONACA.CommandText :='SELECT TO_CHAR(FECHA,''DD/MM/YYYY'') FECHA,  NUMERO, PATENTE, NOMBRES, NUMINSPE FROM TTMPDJURADA ORDER BY FECHA ';
            {$IFDEF TRAZAS}
            FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPRENDICIONACA);
            {$ENDIF}

            Open;
        end
    finally
        Application.ProcessMessages;
    end;
end;


procedure TfrmListadoDecJuradas.PrintClick(Sender: TObject);
begin
      with TFListadoDecJuradasToPrint.Create(Application) do
      try
           Execute(DateIni, DateFin, NombreEstacion, NumeroEstacion);
      finally
           Free;
      end;
end;

procedure TfrmListadoDecJuradas.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            TotalDec := '0';

            If Not GetDates(DateIni,DateFin) Then Exit;

                Caption := Format('Listado de Declaraciones Juradas. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                FTmp.Temporizar(TRUE,FALSE,'Listado de Declaraciones Juradas', 'Generando el informe Listado de Declaraciones Juradas.');
                Application.ProcessMessages;

                DoListadoDecJuradas(DateIni, DateFin, TotalDec);

                FTmp.Temporizar(FALSE,FALSE,'', '');
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

procedure TfrmListadoDecJuradas.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure TfrmListadoDecJuradas.ExcelClick(Sender: TObject);
begin
  ExportacionExcelGeneral;
end;


Procedure TfrmListadoDecJuradas.ExportacionExcelGeneral;
const
    F_TTL = 1;   C_TTL = 1;
    F_STT = 3;   C_STT = 2;
    F_FEC = 4;   C_FEC = 2;

    F_NFA = 5;   C_NFA = 2;
    F_INI = 7;

    C_LTT = 5;
    C_TTO = 6;
    C_TAC = 4;
var
    ExcelApp, ExcelLibro, ExcelHoja: Variant;
    i,f : integer;
begin
  try
    Opendialog.Title := 'Seleccione la Planilla de Entrada';
      if OpenDialog.Execute then
      begin
        FTmp.Temporizar(TRUE,FALSE,'Listado de Declaraciones Juradas', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        
        ExcelHoja := ExcelLibro.Worksheets[1];
        f:= F_INI;
        ExcelHoja.cells[F_TTL,C_TTL].value :='Listado de Declaraciones Juradas';
        ExcelHoja.cells[F_STT,C_STT].value :=Format('Planta: %S.', [PutEstacion]);
        ExcelHoja.cells[F_FEC,C_FEC].value :=Format('Fecha:   Desde: %S  |  Hasta: %S', [Copy(DateIni,1,10), Copy(DateFin,1,10)]);

        QTTMPRENDICIONACA.First;
        while not QTTMPRENDICIONACA.EOF do
        begin
          for i := 0 to DBGridArqueoCaja.Columns.Count - 1 do
            ExcelHoja.cells[f,i+1].value:=QTTMPRENDICIONACA.FieldByName(DBGridArqueoCaja.Columns[i].FieldName).AsString;
          QTTMPRENDICIONACA.Next;
          inc(f);
        end;

        QTTMPRENDICIONACA.First;

        If OpenDialog.Execute then
          excellibro.SaveAs(Opendialog.filename);
        ExcelApp.Quit;
        MessageDlg('Archivo exportado.','La exportación se realizó con exito!', mtInformation, [mbOK],mbOK, 0);
      end;
  except
    on E: Exception do
      begin
        FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de UfListadoDecJuradas: %s', [E.message]);
        MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
      end
  end;
end;

procedure TfrmListadoDecJuradas.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TfrmListadoDecJuradas.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;


end.
