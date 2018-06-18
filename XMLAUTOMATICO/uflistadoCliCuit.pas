unit uflistadoCliCuit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB,  StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, ComObj, RXDBCtrl,SqlExpr, FMTBcd, Provider, DBClient, Dialogs;

type
  TfrmListadoCliCuit = class(TForm)
    Label6: TLabel;
    ti: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    Print: TSpeedItem;
    Excel: TSpeedItem;
    SBSalir: TSpeedItem;
    DSourceArqueoCaja: TDataSource;
    DBGridListCUIT: TRxDBGrid;
    sdsQTTMPCLIENTES: TSQLDataSet;
    QTTMPCLIENTES: TClientDataSet;
    dspQTTMPCLIENTES: TDataSetProvider;
    OpenDialog: TOpenDialog;
    procedure FormDestroy(Sender: TObject);
    procedure PutSumaryResults;
    procedure SBSalirClick(Sender: TObject);
    procedure ExcelClick(Sender: TObject);
    procedure OnOpen (Sender: TObject);
    procedure OnClose (Sender: TObject);
    procedure ExportacionExcelGeneral;
    procedure PrintClick(Sender: TObject);
    procedure DBGridListCUITTitleBtnClick(Sender: TObject; ACol: Integer;
      Field: TField);
    procedure FormShow(Sender: TObject);
  public
    { Public declarations }
    bErrorCreando : boolean;
    NombreEstacion, NumeroEstacion: string;
    function PutEstacion : string;
  private
    ordenactual : integer;
  end;

  procedure GenerateListadoCliCuit;

var
  frmListadoCliCuit: TfrmListadoCliCuit;
  fsql : TStringList;
implementation

{$R *.DFM}


uses
   UCDIALGS,
   ULOGS,
   GLOBALS,
   UFTMP,
   UListadoCliCuitToPrint;

resourcestring
    FICHERO_ACTUAL = 'UFListadoCliCuit.PAS';



procedure GenerateListadoCliCuit;
begin

        with TfrmListadoCliCuit.Create(Application) do
        try
            try
                if bErrorCreando then exit;

                Caption := Format('Listado de Clientes. Planta: %S.', [PutEstacion]);
                FTmp.Temporizar(TRUE,FALSE,'Listado de Clientes', 'Generando el informe Listado de Listado de Clientes.');
                Application.ProcessMessages;
                PutSumaryResults;
                FTmp.Temporizar(FALSE,FALSE,'', '');
                Application.ProcessMessages;
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


procedure TfrmListadoCliCuit.FormDestroy(Sender: TObject);
begin
    QTTMPCLIENTES.Close;

    try
    finally
        FTmp.Temporizar(FALSE,FALSE,'','');
    end
end;

function TfrmListadoCliCuit.PutEstacion : string;
begin
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
    Result := NumeroEstacion + ' ' + NombreEstacion;
end;

procedure TfrmListadoCliCuit.PutSumaryResults;
begin
    try

        with QTTMPCLIENTES do
        begin
            Close;
            sdsQTTMPCLIENTES.SQLConnection:= MyBD;
            fsql := TStringList.Create;
            fsql. add(' SELECT CUIT_CLI, NOMBRE||'' ''||APELLID1 NOMBRE from tclientes where TIPODOCU = ''CUIT'' ');
            fsql. add(' ORDER BY NOMBRE, APELLID1');
            sdsQTTMPCLIENTES.CommandText:= fSQL.text;
            {$IFDEF TRAZAS}
            FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPCLIENTES);
            {$ENDIF}

            Open;
        end
    finally
        Application.ProcessMessages;
    end;
end;


procedure TfrmListadoCliCuit.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure TfrmListadoCliCuit.ExcelClick(Sender: TObject);
begin
  ExportacionExcelGeneral;
end;


procedure TfrmListadoCliCuit.ExportacionExcelGeneral;
const
    F_TTL = 1;   C_TTL = 1;
    F_STT = 3;   C_STT = 1;
    F_FEC = 4;   C_FEC = 2;

    F_NFA = 5;   C_NFA = 2;
    F_INI = 6;

    C_LTT = 5;
    C_TTO = 6;
    C_TAC = 4;
var
    i,F : integer;
    ExcelApp, ExcelLibro, ExcelHoja: Variant;
begin
  try
    DBGridListCUIT.DataSource.DataSet.DisableControls;
    try
      opendialog.Title := 'Seleccione la Planilla de Entrada';
      if OpenDialog.Execute then
      begin
        FTmp.Temporizar(TRUE,FALSE,'Listado de Clientes', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        ExcelHoja := ExcelLibro.Worksheets['Hoja1'];

        f:= F_INI;
        excelHoja.cells[F_TTL,C_TTL].value :='Listado de Clientes';
        excelHoja.cells[F_STT,C_STT].value :=Format('Planta: %S.', [PutEstacion]);

        QTTMPCLIENTES.First;
        while not QTTMPCLIENTES.EOF do
        begin
          for i := 0 to DBGridListCUIT.Columns.Count - 1 do
            excelHoja.cells[f,i+1].value :=QTTMPCLIENTES.FieldByName(DBGridListCUIT.Columns[i].FieldName).AsString;
          QTTMPCLIENTES.Next;
          inc(f);
        end;
        QTTMPCLIENTES.First;
      end;

      opendialog.Title := 'Seleccione la Planilla de Salida';
      if OpenDialog.Execute then
         excellibro.saveas(opendialog.filename);
      ExcelApp.Quit;
    except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de UfListadoCliCuit: %s', [E.message]);
                MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
            end
    end;
  finally
      DBGridListCUIT.DataSource.DataSet.enableControls;
      FTmp.Temporizar(FALSE,FALSE,'','');
      application.ProcessMessages;
  end;
end;

procedure TfrmListadoCliCuit.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TfrmListadoCliCuit.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;


procedure TfrmListadoCliCuit.PrintClick(Sender: TObject);
begin
  with TFListadoCliCuitToPrint.Create(application) do
  begin
    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRImprimirCaja.DataSet := QTTMPCLIENTES;
    QRImprimirCaja.Preview;
  end;
end;

procedure TfrmListadoCliCuit.DBGridListCUITTitleBtnClick(Sender: TObject;
  ACol: Integer; Field: TField);
begin
  if (Field <> nil) then begin
      if (OrdenActual <> aCol) then
      begin
        FTmp.Temporizar(TRUE,FALSE,'Listado de Clientes', 'Cambiando el orden del listado');
        Application.ProcessMessages;

        case aCol of
        0:begin
            QTTMPCLIENTES.close;
            fsql.Strings[1]:='ORDER BY CUIT_CLI';
            QTTMPCLIENTES.CommandText:= fsql.Text;
            QTTMPCLIENTES.open;
            OrdenActual:=aCol;
        end;
        else
        begin
            QTTMPCLIENTES.close;
            fsql.Strings[1]:='ORDER BY NOMBRE, APELLID1';
            QTTMPCLIENTES.CommandText:= fsql.Text;
            QTTMPCLIENTES.open;
            OrdenActual:=aCol;
        end;
        end;
        FTmp.Temporizar(FALSE,FALSE,'', '');
        Application.ProcessMessages;
      end
  end

end;

procedure TfrmListadoCliCuit.FormShow(Sender: TObject);
begin
  ordenactual := 1;
end;

end.
