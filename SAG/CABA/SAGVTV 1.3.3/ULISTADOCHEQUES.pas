unit UListadoCheques;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, ComObj, RxGIF, SQLExpr, FMTBcd, Provider, DBClient,
  Dialogs;

type
  TFrmListadoCheques = class(TForm)
    lblTotalFacturas: TLabel;
    edtTotalTotal: TEdit;
    edtTotalFacturas: TEdit;
    DSourceArqueoCaja: TDataSource;
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
    Image2: TImage;
    DBGridArqueoCaja: TDBGrid;
    QTTMPLISTCHEQUES: TClientDataSet;
    dspListCheques: TDataSetProvider;
    sdslistcheques: TSQLDataSet;
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
    function ExportacionExcelGeneral: Boolean;
  public
    { Public declarations }
    bErrorCreando : boolean;
    NombreEstacion, NumeroEstacion,
    TipoPago,
    DateIni, DateFin,
    TotalImporte,
    Total, TotalIva, TotalIvaNoInscripto,
    NumeroFacturas,
    NumeroNotasCredito, aTipoCliente : string;
    function PutTipoPago(const aTP : string): string;
    function PutEstacion : string;
  end;

  procedure GenerateListadoCheques (const TipoArqueo: string);
  procedure DoListadoCheque(const FI,FF,sTipoArqueo: string;
                       var sTotFact, sTotTot: string);

var
  FrmListadoCheques: TFrmListadoCheques;

implementation

{$R *.DFM}


uses
   UCDIALGS,
   UUTILS,
   UGETDATES,
   ULOGS,
   GLOBALS,
   ULISTADOCHEQUETOPRINT,
   UFTMP,
   USAGESTACION;


resourcestring
    FICHERO_ACTUAL = 'UListadoCheques.PAS';


procedure DoListadoCheque(const FI,FF,sTipoArqueo: string;
                       var sTotFact, sTotTot: string);

begin
    DeleteTable(MyBD, 'TTMPLISTCHEQUES');

    with TSQLStoredProc.Create(application) do
    try
        sqlconnection := MyBD;

        StoredProcName := 'PQ_ARQUEO_VTV.DOLISTADOCHEQUES';

        Prepared := true;
        ParamByName('FECHAINI').Value := FI;
        ParamByName('FECHAFIN').Value := FF;

        ExecProc;

        sTotFact := ParamByName('numCheques').AsString;
        sTotTot := ParamByName('totalencaja').AsString;
        Close;
    finally
        Free
    end
end;


procedure GenerateListadoCheques (const TipoArqueo: string);
begin


        with TFrmListadoCheques.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                TotalImporte := '0';
                Total := '0'; NumeroFacturas := '0'; NumeroNotasCredito := '0';
                If not GetDates(DateIni,DateFin) then Exit;


                Caption := Format('Listado de Cheques. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                FTmp.Temporizar(TRUE,FALSE,'Listado de Cheques', 'Generando el informe listado de cheques.');
                Application.ProcessMessages;

                DoListadoCheque(DateIni, DateFin, TipoPago, NumeroFacturas, Total);

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

procedure TFrmListadoCheques.FormCreate(Sender: TObject);
begin
    bErrorCreando := False;

    if (not MyBD.InTransaction) then MyBD.StartTransaction(td);

    try
        LoockAndDeleteTable(MyBD, 'TTMPLISTCHEQUES')
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
            MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
            bErrorCreando := True
        end
    end
end;

procedure TFrmListadoCheques.FormDestroy(Sender: TObject);
begin
    QTTMPLISTCHEQUES.Close;

    try
        try
            if MyBD.InTransaction then
              Begin
                MyBD.Rollback(td); // MyBD.Commit
              end
            else raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del listado de Cheques')
        except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'Error cerrando la ficha de UListadoCheques: %s', [E.message]);
                MessageDlg('Generación de Informes.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end
        end
    finally
        FTmp.Temporizar(FALSE,FALSE,'','');
    end
end;

function TFrmListadoCheques.PutEstacion : string;
begin
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
    Result := NumeroEstacion + ' ' + NombreEstacion;
end;


function TFrmListadoCheques.PutTipoPago(const aTP : string) : string;
begin
            result := S_FORMA_PAGO[tfpCheque];
            TipoPago := V_FORMA_PAGO[tfpCheque];
end;

procedure TFrmListadoCheques.PutSumaryResults;
begin
    try
        TotalImporte := ConviertePuntoEnComa(TotalImporte);
        Total := ConviertePuntoEnComa(Total);

        EdtTotalTotal.Text := Total;

        EdtTotalFacturas.Text := NumeroFacturas;


        with QTTMPLISTCHEQUES do
        begin
            Close;
            sdslistcheques.SQLConnection:=MyBD;
            CommandText:='SELECT NOMBANCO, NOMSUCURSAL, TO_CHAR(FECHPAGO,''DD/MM/YYYY'') FECHPAGO, TO_CHAR(FECHALTA,''DD/MM/YYYY'') FECHALTA, NUMEROCHEQUE, NOMBRETIT, MONEDA, IMPORTE, NUMFACTU FROM TTMPLISTCHEQUES ORDER BY NOMBANCO, NOMSUCURSAL, NUMEROCHEQUE ';
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTCHEQUES);
            {$ENDIF}

            Open;
        end
    finally
        Application.ProcessMessages;
    end;
end;


procedure TFrmListadoCheques.PrintClick(Sender: TObject);
begin
       with TFListadoChequeToPrint.Create(Application) do
       try
          Execute(DateIni, DateFin, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, NumeroFacturas, NumeroNotasCredito, PutTipoPago(TipoPago), NombreEstacion, NumeroEstacion);
       finally
          Free;
       end;
end;

procedure TFrmListadoCheques.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            TotalImporte := '0'; TotalIva := '0';  TotalIvaNoInscripto := '0';
            Total := '0'; NumeroFacturas := '0'; NumeroNotasCredito := '0';

            If Not GetDates(DateIni,DateFin) Then Exit;
            Caption := Format('Listado de Cheques. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
            FTmp.Temporizar(TRUE,FALSE,'Listado de Cheques','Generando el informe listado de cheques.');
            Application.ProcessMessages;

            DoListadoCheque(DateIni, DateFin, TipoPago, NumeroFacturas, Total);

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

procedure TFrmListadoCheques.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure TFrmListadoCheques.AscciClick(Sender: TObject);
begin
     with TFListadoChequeToPrint.Create(Application) do
     try
        ExportaAscii(DateIni, DateFin, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, NumeroFacturas, NumeroNotasCredito, PutTipoPago(TipoPago), NombreEstacion, NumeroEstacion);
     finally
        Free;
     end;
end;

procedure TFrmListadoCheques.ExcelClick(Sender: TObject);
begin
         try
            if not ExportacionExcelGeneral
            then MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
         except
            MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
         end;
end;


function TFrmListadoCheques.ExportacionExcelGeneral: Boolean;
const
    F_TTL = 1;   C_TTL = 4;
    F_STT = 2;   C_STT = 4;
    F_NFA = 4;   C_NFA = 2;
    F_INI = 7;

    C_LTT = 5;
    C_TTO = 6;
var
    i,f : integer;
    ExcelApp, ExcelLibro, ExcelHoja: Variant;
begin
  Result := False;
  try
    opendialog.Title := 'Seleccione la Planilla de Entrada';
    if OpenDialog.Execute then
    begin
      FTmp.Temporizar(TRUE,FALSE,'Arqueo de Caja Extendido', 'Exportando los datos a excel');
      ExcelApp := CreateOleObject('Excel.Application');
      ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
      ExcelHoja := ExcelLibro.Worksheets[1];

      f:= F_INI;
      ExcelHoja.Cells[F_TTL,C_TTL].value := 'Listado de Cheques';
      ExcelHoja.Cells[F_STT,C_STT].value := Format('Planta nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
      ExcelHoja.Cells[F_NFA,C_NFA].value := EdtTotalFacturas.Text;

      QTTMPLISTCHEQUES.First;
      while not QTTMPLISTCHEQUES.EOF do
      begin
        for i := 0 to DBGridArqueoCaja.Columns.Count - 1 do
            ExcelHoja.Cells[f,i+1].value := conviertecomaenpunto(QTTMPLISTCHEQUES.FieldByName(DBGridArqueoCaja.Columns[i].FieldName).AsString);
        QTTMPLISTCHEQUES.Next;
        inc(f);
      end;
      QTTMPLISTCHEQUES.First;

      if f=F_INI
      then f := f + 1;
      ExcelHoja.Cells[f,C_LTT].value := 'TOTALES';
      ExcelHoja.Cells[f,C_TTO].value := conviertecomaenpunto(EdtTotalTotal.Text);

      opendialog.Title := 'Seleccione la Planilla de Salida';
      if OpenDialog.Execute then
         excellibro.saveas(opendialog.filename);
      ExcelApp.Quit;
      result := true;
    end;
  finally
      FTmp.Temporizar(FALSE,FALSE,'','');
      application.ProcessMessages;
  end;
end;

procedure TFrmListadoCheques.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TFrmListadoCheques.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;


end.


