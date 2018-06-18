unit ufListadoSociosAca;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, ComObj, RxGIF, FMTBcd, DBClient, Provider, SqlExpr, Dialogs;

type
  TfrmListadoSociosAca = class(TForm)
    Bevel1: TBevel;
    lblTotalFacturas: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Image2: TImage;
    edtTotalTotal: TEdit;
    edtTotalFacturas: TEdit;
    ti: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    Print: TSpeedItem;
    Ascci: TSpeedItem;
    Excel: TSpeedItem;
    SBBusqueda: TSpeedItem;
    SBSalir: TSpeedItem;
    Bevel2: TBevel;
    edtTotalACA: TEdit;
    Label1: TLabel;
    sdsTTMPARQCAJA: TSQLDataSet;
    DataSetProvider1: TDataSetProvider;
    QTTMPRENDICIONACA: TClientDataSet;
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
    Total, TotalAcaCaja, NumeroFacturas, aTipoCliente : string;
    function PutTipoPago(const aTP : string): string;
    function PutEstacion : string;
  end;

  procedure GenerateListadoSociosAca;
  procedure DoListadoSociosAca(const FI,FF,aCodDescuento: string;
                       var sTotFact, sTotTot, sTotCajaAca: string);

var
  frmListadoSociosAca: TfrmListadoSociosAca;

implementation

{$R *.DFM}


uses
   UCDIALGS,
   UUTILS,
   UGETDATES,
   ULOGS,
   GLOBALS,
   UFLISTADODESCUENTOSTOPRINT,
   UFTMP,
   USAGESTACION,
   UFPORTIPO,
   ufListadoRendAcaToPrint,
   USAGCLASSES;


resourcestring
    FICHERO_ACTUAL = 'UFListadoSociosACA.PAS';

    CADENA_ARQUEO_AMBOS = 'Global';
    TIPO_ARQUEO_SOCIOS = 'S';


procedure DoListadoSociosAca(const FI,FF,aCodDescuento: string;
                       var sTotFact, sTotTot, sTotCajaAca: string);

begin
    DeleteTable(MyBD, 'TTMPRENDICIONACA');

    with TsqlStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_LIST_VARIOS.DORENDICIONACA';

        Prepared := true;
        ParamByName('FECHAINI').Value := FI;
        ParamByName('FECHAFIN').Value := FF;
        ParamByName('aDescuento').Value := aCodDescuento;

        ExecProc;

        sTotFact := ParamByName('NumFacturas').AsString;
        sTotTot := floattostrf(strtofloat(ParamByName('TotalEnCaja').AsString),fffixed,8,2);
        sTotCajaAca := ParamByName('TotalCajaAca').AsString;

        Close;
    finally
        Free
    end
end;

procedure GenerateListadoSociosAca;
begin

        with TfrmListadoSociosAca.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                Total := '0'; NumeroFacturas := '0'; TotalAcaCaja := '0';

                If not GetDates(DateIni,DateFin) then Exit;

                If not PorTipo(TIPO_ARQUEO_SOCIOS, aTipoCliente, DateIni, DateFin) then Exit;

                Caption := Format('Listado de Rendición al ACA. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                FTmp.Temporizar(TRUE,FALSE,'Listado de Rendición al ACA', 'Generando el informe Listado de Rendición al ACA.');
                Application.ProcessMessages;

                DoListadoSociosAca(DateIni, DateFin, aTipoCliente, NumeroFacturas, Total, TotalAcaCaja);

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


procedure TfrmListadoSociosAca.FormCreate(Sender: TObject);
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

procedure TfrmListadoSociosAca.FormDestroy(Sender: TObject);
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

function TfrmListadoSociosAca.PutEstacion : string;
begin
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
    Result := NumeroEstacion + ' ' + NombreEstacion;
end;


function TfrmListadoSociosAca.PutTipoPago(const aTP : string) : string;
begin
            result := S_FORMA_PAGO[tfpCheque];
            TipoPago := V_FORMA_PAGO[tfpCheque];
end;

procedure TfrmListadoSociosAca.PutSumaryResults;
begin
    try

        Total := ConviertePuntoEnComa(Total);
        TotalAcaCaja := ConviertePuntoEnComa(TotalAcaCaja);

        EdtTotalTotal.Text := Total;
        EdtTotalFacturas.Text := NumeroFacturas;
        EdtTotalAca.text := TotalAcaCaja;



        with QTTMPRENDICIONACA do
        begin
            Close;
            sdsTTMPARQCAJA.SQLConnection := MyBD;
            CommandText := 'SELECT TIPOFACTURA||'' ''||NUMFACTURA NUMFACTURA, TO_CHAR(FECHALTA,''DD/MM/YYYY'') FECHALTA,  NOMBRECLIENTE, TOTAL, TOTALACA, NROCUPON FROM TTMPRENDICIONACA ORDER BY FECHALTA, NUMFACTURA ';
            {$IFDEF TRAZAS}
            FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPRENDICIONACA);
            {$ENDIF}

            Open;
        end
    finally
        Application.ProcessMessages;
    end;
end;


procedure TfrmListadoSociosAca.PrintClick(Sender: TObject);
begin
      with tFrmListadoRendAcaToPrint.Create(Application) do
      try
           Execute(DateIni, DateFin, Total, TotalAcaCaja, NombreEstacion, NumeroEstacion);
      finally
           Free;
      end;
end;

procedure TfrmListadoSociosAca.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            Total := '0'; NumeroFacturas := '0'; TotalAcaCaja := '0';

            If Not GetDates(DateIni,DateFin) Then Exit;
            Caption := Format('Listado de Rendición al ACA. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
            FTmp.Temporizar(TRUE,FALSE,'Rendición al ACA','Listado de Rendición al ACA.');
            Application.ProcessMessages;

            DoListadoSociosAca(DateIni, DateFin, aTipoCliente, NumeroFacturas, Total, TotalAcaCaja);


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

procedure TfrmListadoSociosAca.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure TfrmListadoSociosAca.AscciClick(Sender: TObject);
begin
                    with tFrmListadoRendAcaToPrint.Create(Application) do
                    try
                        ExportaAscii(DateIni, DateFin, Total, TotalAcaCaja, NombreEstacion, NumeroEstacion);
                    finally
                        Free;
                    end;

end;

procedure TfrmListadoSociosAca.ExcelClick(Sender: TObject);
begin
  ExportacionExcelGeneral;
end;


procedure TfrmListadoSociosAca.ExportacionExcelGeneral;
const
    F_TTL = 1;   C_TTL = 1;
    F_STT = 3;   C_STT = 2;
    F_FEC = 4;   C_FEC = 2;

    F_NFA = 5;   C_NFA = 2;
    F_INI = 8;

    C_LTT = 5;
    C_TTO = 6;
    C_TAC = 4;
var
    i,f : integer;
    ExcelApp, ExcelLibro, ExcelHoja: Variant;
begin
  try
    try
      opendialog.Title := 'Seleccione la Planilla de Entrada';
      if OpenDialog.Execute then
      begin
        FTmp.Temporizar(TRUE,FALSE,'Planilla de rendición Cobranzas A.C.A.', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        ExcelHoja := ExcelLibro.Worksheets[1];

        f:= F_INI;
        ExcelHoja.Cells[F_TTL,C_TTL].value := 'Planilla de rendición Cobranzas A.C.A.';
        ExcelHoja.Cells[F_STT,C_STT].value := Format('Planta: %S.', [PutEstacion]);
        ExcelHoja.Cells[F_FEC,C_FEC].value := Format('Fecha:   Desde: %S  |  Hasta: %S', [Copy(DateIni,1,10), Copy(DateFin,1,10)]);

        QTTMPRENDICIONACA.First;
        while not QTTMPRENDICIONACA.EOF do
        begin
          for i := 0 to DBGridArqueoCaja.Columns.Count - 1 do
            ExcelHoja.Cells[f,i+1].value := QTTMPRENDICIONACA.FieldByName(DBGridArqueoCaja.Columns[i].FieldName).AsString;
          QTTMPRENDICIONACA.Next;
          inc(f);
        end;
        QTTMPRENDICIONACA.First;

        if f=F_INI
        then f := f + 1;

        inc(f);
    
        ExcelHoja.Cells[f,C_LTT].value := 'TOTAL:';
        ExcelHoja.Cells[f,C_TTO].value := EdtTotalTotal.Text;

        ExcelHoja.Cells[f,C_LTT-2].value := 'TOTAL:';
        ExcelHoja.Cells[f,C_TAC].value := EdtTotalACA.Text;
      end;
      opendialog.Title := 'Seleccione la Planilla de Salida';
      if OpenDialog.Execute then
         excellibro.saveas(opendialog.filename);
      ExcelApp.Quit;
    except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de UfListadoSociosACA: %s', [E.message]);
                MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
            end
    end;
  finally
      FTmp.Temporizar(FALSE,FALSE,'','');
      application.ProcessMessages;
  end;

end;

procedure TfrmListadoSociosAca.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TfrmListadoSociosAca.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;


end.
