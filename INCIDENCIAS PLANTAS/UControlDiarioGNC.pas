unit UControlDiarioGNC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, ComObj, FMTBcd, SqlExpr, Provider, DBClient, Dialogs;

type
  TfControlDiarioGNC = class(TForm)                                      
    ti: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    Print: TSpeedItem;
    Ascci: TSpeedItem;
    Excel: TSpeedItem;
    SBBusqueda: TSpeedItem;
    SBSalir: TSpeedItem;
    DSourceArqueoCaja: TDataSource;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    DBText8: TDBText;
    DBText9: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    btnExportar: TSpeedItem;
    QTTMPLISTCANTDESCUENTOS: TClientDataSet;
    dspQTTMPLISTCANTDESCUENTOS: TDataSetProvider;
    sdsQTTMPLISTCANTDESCUENTOS: TSQLDataSet;
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
    procedure btnExportarClick(Sender: TObject);
  public
    { Public declarations }
    bErrorCreando : boolean;
    NombreEstacion, NumeroEstacion,
    TipoPago,
    DateIni, DateFin : string;
    function PutEstacion : string;
  end;

  procedure GenerateControlDiarioGNC;
  procedure DoControlDiarioGNC(const FI,FF: string);

var
  fControlDiarioGNC: TfControlDiarioGNC;

implementation

{$R *.DFM}


uses
   UCDIALGS,
   UUTILS,
   UGETDATES,
   ULOGS,
   GLOBALS,
   UControlDiarioToPrintGNC,
   UFTMP,
   USAGESTACION,
   USAGVARIOS,
   UFPORTIPO,
   USAGCLASSES, UExportaciones;


resourcestring
    FICHERO_ACTUAL = 'UControlDiarioGNC.PAS';

procedure DoControlDiarioGNC(const FI,FF: string);

begin
    DeleteTable(MyBD, 'TTMPCONTROLDIARIOGNC');
    DeleteTable(MyBD, 'TTMPOBLEAS');    

    with TSQLStoredProc.Create(application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_CONTROLDIARIOGNC.DOCONTROLDIARIOGNC';
        Prepared := true;
        ParamByName('FI').Value := FI;
        ParamByName('FF').Value := FF;
        ExecProc;
        Close;
    finally
        Free
    end
end;

procedure GenerateControlDiarioGNC;
begin

        with TfControlDiarioGNC.Create(Application) do
        try
            try
                if bErrorCreando then exit;

                If not GetDates(DateIni,DateFin) then Exit;

                Caption := Format('Control Diario GNC. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                FTmp.Temporizar(TRUE,FALSE,'Listado Control Diario GNC', 'Generando el informe Control Diario GNC.');
                Application.ProcessMessages;

                DoControlDiarioGNC(DateIni, DateFin);

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

procedure TfControlDiarioGNC.FormCreate(Sender: TObject);
begin
    bErrorCreando := False;

    if (not MyBD.InTransaction) then MyBD.StartTransaction(td);

    try
        LoockAndDeleteTable(MyBD, 'TTMPCONTROLDIARIOGNC')
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
            MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
            bErrorCreando := True
        end
    end
end;

procedure TfControlDiarioGNC.FormDestroy(Sender: TObject);
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

function TfControlDiarioGNC.PutEstacion : string;
begin
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
    Result := NumeroEstacion + ' ' + NombreEstacion;
end;


procedure TfControlDiarioGNC.PutSumaryResults;
begin
    try
        with QTTMPLISTCANTDESCUENTOS do
        begin
            Close;
            sdsQTTMPLISTCANTDESCUENTOS.SQLConnection := MyBD;
            CommandText := 'SELECT CANTAPTAS, CANTRECH, TOTCAJA, COBLEASACT, MINOBLEACT, MAXOBLEACT, '+
                    ' COBLEASIG, MINOBLEASIG, MAXOBLEASIG  ' +
                    'FROM TTMPCONTROLDIARIOGNC' ;
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTCANTDESCUENTOS);
            {$ENDIF}

            Open;
        end
    finally
        Application.ProcessMessages;
    end;
end;


procedure TfControlDiarioGNC.PrintClick(Sender: TObject);
begin
                    with TFControlDiarioToPrint.Create(Application) do
                    try
                        Execute(DateIni, DateFin, NombreEstacion, NumeroEstacion);
                    finally
                        Free;
                    end;
end;

procedure TfControlDiarioGNC.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            If Not GetDates(DateIni,DateFin) Then Exit;

            Caption := Format('Control Diario GNC. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
            FTmp.Temporizar(TRUE,FALSE,'Control Diario GNC','Generando el informe Control Diario GNC.');
            Application.ProcessMessages;

            DoControlDiarioGNC(DateIni, DateFin);

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

procedure TfControlDiarioGNC.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure TfControlDiarioGNC.AscciClick(Sender: TObject);
begin
                    with TFControlDiarioToPrint.Create(Application) do
                    try
                        ExportaAscii(DateIni, DateFin, NombreEstacion, NumeroEstacion);
                    finally
                        Free;
                    end;
end;

procedure TfControlDiarioGNC.ExcelClick(Sender: TObject);
begin
  ExportacionExcelGeneral;
end;


procedure TfControlDiarioGNC.ExportacionExcelGeneral;
const
    F_TTL = 1;   C_TTL = 4;
    F_STT = 2;   C_STT = 4;

    F_CIA = 5;   C_CIA = 3;
    F_CIR = 6;   C_CIR = 3;
    F_TCC = 5;   C_TTC = 5;

    F_OBA = 10;  C_OCA = 2;
    F_CBS = 11;  C_OCS = 2;
                 C_OPA = 3;
                 C_OPS = 3;
                 C_OUA = 4;
                 C_OUS = 4;
var
    ExcelApp, ExcelLibro, ExcelHoja: Variant;

begin
  try
    try
      opendialog.Title := 'Seleccione la Planilla de Entrada';
      if OpenDialog.Execute then
      begin
        FTmp.Temporizar(TRUE,FALSE,'Control Diario GNC', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        ExcelHoja := ExcelLibro.Worksheets[1];

        ExcelHoja.Cells[F_TTL,C_TTL].value := 'Listado Control Diario GNC';
        ExcelHoja.Cells[F_STT,C_STT].value := Format('Planta Nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);

        ExcelHoja.Cells[F_CIA,C_CIA].value := QTTMPLISTCANTDESCUENTOS.fieldByName('CANTAPTAS').asstring;
        ExcelHoja.Cells[F_CIR,C_CIR].value := QTTMPLISTCANTDESCUENTOS.fieldByName('CANTRECH').asstring;
        ExcelHoja.Cells[F_TCC,C_TTC].value := QTTMPLISTCANTDESCUENTOS.fieldByName('TOTCAJA').asstring;

        ExcelHoja.Cells[F_OBA,C_OCA].value :=QTTMPLISTCANTDESCUENTOS.fieldByName('COBLEASACT').asstring;
        ExcelHoja.Cells[F_OBA,C_OPA].value :=QTTMPLISTCANTDESCUENTOS.fieldByName('MINOBLEACT').asstring;
        ExcelHoja.Cells[F_OBA,C_OUA].value :=QTTMPLISTCANTDESCUENTOS.fieldByName('MAXOBLEACT').asstring;
        ExcelHoja.Cells[F_CBS,C_OCS].value :=QTTMPLISTCANTDESCUENTOS.fieldByName('COBLEASIG').asstring;
        ExcelHoja.Cells[F_CBS,C_OPS].value :=QTTMPLISTCANTDESCUENTOS.fieldByName('MINOBLEASIG').asstring;
        ExcelHoja.Cells[F_CBS,C_OUS].value :=QTTMPLISTCANTDESCUENTOS.fieldByName('MAXOBLEASIG').asstring;
      end;
      opendialog.Title := 'Seleccione la Planilla de Salida';
      if OpenDialog.Execute then
         excellibro.saveas(opendialog.filename);
      ExcelApp.Quit;
    except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de UControlDiarioGNC: %s', [E.message]);
                MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
            end
    end;
  finally
      FTmp.Temporizar(FALSE,FALSE,'','');
      application.ProcessMessages;
  end;

end;

procedure TfControlDiarioGNC.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TfControlDiarioGNC.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;


procedure TfControlDiarioGNC.btnExportarClick(Sender: TObject);
begin
   DoExportacionCDiarioGNC(QTTMPLISTCANTDESCUENTOS, dateini, datefin);
end;

end.


