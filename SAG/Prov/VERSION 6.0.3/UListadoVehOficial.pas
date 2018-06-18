unit UListadoVehOficial;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, UDDEExcelObject, FMTBcd, DBClient, Provider, SqlExpr, Dialogs, ComObj;

type
  TFrmListadoVehOficial = class(TForm)
    lblTotalFacturas: TLabel;
    edtTotalTotal: TEdit;
    edtTotalFacturas: TEdit;
    Label3: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    ti: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    Print: TSpeedItem;
    SBBusqueda: TSpeedItem;
    SBSalir: TSpeedItem;
    Ascci: TSpeedItem;
    Excel: TSpeedItem;
    Label6: TLabel;
    sdsQTTMPVehOficial: TSQLDataSet;
    dspQTTMPVehOficial: TDataSetProvider;
    QTTMPVehOficial: TClientDataSet;
    DBGridArqueoCaja: TDBGrid;
    DSourceArqueoCaja: TDataSource;
    OpenDialog: TOpenDialog;
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
    procedure ExportacionExcelGeneral;
  public
    { Public declarations }
    bErrorCreando : boolean;
    NombreEstacion, NumeroEstacion,
    TipoPago,
    DateIni, DateFin,
    Total, NumeroFacturas,
    aTipoCliente : string;
    function PutEstacion : string;
  end;

  procedure GenerateListadoVehOficial (const TipoArqueo: string);
  procedure DoListadoVehOficial(const FI,FF,sTipoArqueo: string;
                       var sTotFact, sTotTot: string);

var
  FrmListadoVehOficial: TFrmListadoVehOficial;

implementation

{$R *.DFM}


uses
   UCDIALGS,
   UUTILS,
   UGETDATES,
   ULOGS,
   GLOBALS,
   UListadoVehOficialToPrint,
   UFTMP,
   USAGESTACION,
   USAGVARIOS,
   UFINFORMESDIALOGEXCEL;


resourcestring
    FICHERO_ACTUAL = 'UListadoVehOficial.PAS';


procedure DoListadoVehOficial(const FI,FF,sTipoArqueo: string; var sTotFact, sTotTot: string);
begin
  DeleteTable(MyBD, 'TTMPLISTPUBLICO');
  with TSQLStoredProc.Create(Application) do
    try
      SQLConnection := MyBD;
      StoredProcName := 'PQ_LIST_VARIOS.DOLISTADOUSUPUBLICO';
      Prepared := true;
      ParamByName('FECHAINI').Value := FI;
      ParamByName('FECHAFIN').Value := FF;
      ParamByName('ATIPOCLIENTE').Value := strtoint(sTipoArqueo);
      ExecProc;
      sTotFact := ParamByName('numFacturas').AsString;
      sTotTot := ParamByName('totalencaja').AsString;
      Close;
    finally
      Free
    end
end;


procedure GenerateListadoVehOficial (const TipoArqueo: string);
begin
with TFrmListadoVehOficial.Create(Application) do
  try
    try
      if bErrorCreando then
        exit;
      Total := '0';
      NumeroFacturas := '0';
      If not GetDates(DateIni,DateFin) then
        Exit;
      Caption := Format('Listado de Vehículos Oficiales. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
      FTmp.Temporizar(TRUE,FALSE,'Listado de Vehículos', 'Generando el informe listado de Vehículos Oficiales.');
      Application.ProcessMessages;
      DoListadoVehOficial(DateIni, DateFin, TipoArqueo, NumeroFacturas, Total);
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


procedure TFrmListadoVehOficial.FormCreate(Sender: TObject);
begin
bErrorCreando := False;
  if (not MyBD.InTransaction) then MyBD.StartTransaction(td);
    try
      LoockAndDeleteTable(MyBD, 'TTMPLISTPUBLICO')
    except
      on E:Exception do
        begin
          FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
          MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
          bErrorCreando := True
        end
    end
end;

procedure TFrmListadoVehOficial.FormDestroy(Sender: TObject);
begin
QTTMPVehOficial.Close;
  try
    try
      if MyBD.InTransaction then
        Begin
          MyBD.Rollback(td); // MyBD.Commit
        end
      else
        raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del listado de Vehículos Oficiales')
    except
      on E: Exception do
        begin
          FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'Error cerrando la ficha de UListadoVehOficial: %s', [E.message]);
          MessageDlg('Generación de Informes.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
        end
    end
  finally
    FTmp.Temporizar(FALSE,FALSE,'','');
  end
end;


function TFrmListadoVehOficial.PutEstacion : string;
begin
NombreEstacion := fVarios.NombreEstacion;
NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
Result := NumeroEstacion + ' ' + NombreEstacion;
end;


procedure TFrmListadoVehOficial.PutSumaryResults;
var fSQL : TStringList;
begin
  try
    Total := ConviertePuntoEnComa(Total);
    EdtTotalTotal.Text := Total;
    EdtTotalFacturas.Text := NumeroFacturas;
    fSQL := TStringList.Create;
    with QTTMPVehOficial do
      begin
        Close;
        sdsQTTMPVehOficial.SQLConnection := MyBD;
        fSQL.Clear;
        fSQL.Add('SELECT TIPOFACTURA, NUMFACTURA, TO_CHAR(FECHALTA,''DD/MM/YYYY'') FECHALTA, SOLICREG, ');
        fsql.add('NUMINFORME, DOMINIO, MARCAMODELO, TIPOPAGO, NOMBRECLIENTE, TOTAL, TO_CHAR(FECHALTA,''YYYY/MM/DD'') FO ');
        fsql.add('FROM TTMPLISTPUBLICO ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ');
        CommandText := fSQL.Text;
        {$IFDEF TRAZAS}
        FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPVehOficial);
        {$ENDIF}
        Open;
      end
  finally
    Application.ProcessMessages;
  end;
end;


procedure TFrmListadoVehOficial.PrintClick(Sender: TObject);
begin
with TFListadoVehOficialToPrint.Create(Application) do
  try
    Execute(DateIni, DateFin, Total, NumeroFacturas, NombreEstacion, NumeroEstacion);
  finally
    Free;
  end;
end;

procedure TFrmListadoVehOficial.SBBusquedaClick(Sender: TObject);
begin
  try
    Enabled := False;
      try
        Total := '0';
        NumeroFacturas := '0';
        TipoPago:='7';
        If not GetDates(DateIni,DateFin) Then
          Exit;
        Caption := Format('Listado de Vehículos Oficiales. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
        FTmp.Temporizar(TRUE,FALSE,'Listado de Vehículos Oficiales','Generando el informe listado de Vehículos Oficiales.');
        Application.ProcessMessages;

        DoListadoVehOficial(DateIni, DateFin, TipoPago, NumeroFacturas, Total);
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


procedure TFrmListadoVehOficial.SBSalirClick(Sender: TObject);
begin
FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
ModalResult := mrOk;
end;


procedure TFrmListadoVehOficial.AscciClick(Sender: TObject);
begin
with TFListadoVehOficialToPrint.Create(Application) do
  try
    ExportaAscii(DateIni, DateFin, Total, NumeroFacturas, NombreEstacion, NumeroEstacion);
  finally
    Free;
  end;
end;


procedure TFrmListadoVehOficial.ExcelClick(Sender: TObject);
begin
with TFExcelDialog.Create(Self) do
  try
    ExportacionExcelGeneral;
  finally
    free;
  end;
end;


Procedure TFrmListadoVehOficial.ExportacionExcelGeneral;
const
F_TTL = 1;   C_TTL = 4;
F_STT = 2;   C_STT = 4;
F_NFA = 4;   C_NFA = 2;
F_INI = 7;
C_LTT = 8;
C_TTO = 9;
var
i,f : integer;
ExcelApp, ExcelLibro, ExcelHoja: Variant;
begin
  try
  DBGridArqueoCaja.DataSource.DataSet.DisableControls;
    try
      Opendialog.Title := 'Seleccione la Planilla de Entrada';
      if OpenDialog.Execute then
      begin
        FTmp.Temporizar(TRUE,FALSE,'Listado de Vehículos Oficiales', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        ExcelHoja := ExcelLibro.Worksheets[1];
        f:= F_INI;
        ExcelHoja.Cells[F_TTL,C_TTL].value := 'Listado de Vehículos Oficiales';
        ExcelHoja.Cells[F_STT,C_STT].value := Format('Planta nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
        ExcelHoja.Cells[F_NFA,C_NFA].value := EdtTotalFacturas.Text;
        QTTMPVehOficial.First;
        while not QTTMPVehOficial.EOF do
          begin
            for i := 0 to DBGridArqueoCaja.Columns.Count - 1 do
            ExcelHoja.Cells[f,i+1].value := conviertecomaenpunto(QTTMPVehOficial.FieldByName(DBGridArqueoCaja.Columns[i].FieldName).AsString);
            QTTMPVehOficial.Next;
          inc(f);
        end;
        QTTMPVehOficial.First;
        If f=F_INI then
          F:= F+1;
        ExcelHoja.Cells[F,C_LTT].value := 'TOTALES';
        ExcelHoja.Cells[F,C_TTO].value := EdtTotalTotal.Text;
        Opendialog.Title := 'Seleccione la Planilla de Salida';
        if OpenDialog.Execute then
          excellibro.SaveAs(Opendialog.filename);
        ExcelApp.Quit;
        MessageDlg('Archivo exportado.','La exportación se realizó con exito!', mtInformation, [mbOK],mbOK, 0);
      end;
    except
      on E: Exception do
        begin
        FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de UfListadoVehOficial: %s', [E.message]);
        MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
        end
    end;
  finally
      DBGridArqueoCaja.DataSource.DataSet.enableControls;
      FTmp.Temporizar(FALSE,FALSE,'','');
      application.ProcessMessages;
  end;
end;


procedure TFrmListadoVehOficial.OnClose (Sender: TObject);
begin
FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
Enabled := TRUE;
end;


procedure TFrmListadoVehOficial.OnOpen (Sender: TObject);
begin
FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
Enabled := FALSE;
end;


end.


