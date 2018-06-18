unit UFListadoDescuentos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, ComObj, FMTBcd, DBClient, Provider, SqlExpr, Dialogs,
  USagEstacion;

type
  TFrmListadoDescuentos = class(TForm)
    Bevel1: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    ti: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    Print: TSpeedItem;
    Ascci: TSpeedItem;
    Excel: TSpeedItem;
    SBBusqueda: TSpeedItem;
    SBSalir: TSpeedItem;
    lblTotalFacturas: TLabel;
    lblTotalNotasCredito: TLabel;
    edtTotalFacturas: TEdit;
    edtTotalNotasCredito: TEdit;
    Bevel2: TBevel;
    Label1: TLabel;
    edtTotalImporte: TEdit;
    Label2: TLabel;
    edtTotalIVA: TEdit;
    Label4: TLabel;
    edtTotalIVANOInscripto: TEdit;
    Label3: TLabel;
    edtTotalTotal: TEdit;
    btnDesc: TSpeedItem;
    Label7: TLabel;
    edtTotalIIBB: TEdit;
    sdsTTMPARQCAJA: TSQLDataSet;
    DataSetProvider1: TDataSetProvider;
    QTTMPLISTDESCUENTOS: TClientDataSet;
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
    procedure btnDescClick(Sender: TObject);
  public
    { Public declarations }
    bErrorCreando : boolean;
    NombreEstacion, NumeroEstacion,
    TipoPago,
    DateIni, DateFin,
    TotalImporte, TotalIIBB,
    Total, TotalIva, TotalIvaNoInscripto,
    NumeroFacturas,
    NumeroNotasCredito, aTipoCliente : string;
    function PutTipoPago(const aTP : string): string;
    function PutEstacion : string;
  end;

  procedure GenerateListadoDescuento (const TipoArqueo: string);
  procedure DoListadoDescuento(const FI,FF,aCodDescuento: string;
                       var sTotFact, sTotNC, sTotImp, sTotIVAIns, sTotIVANoIns, sTotTot, sTotIIBB: string);

var
  FrmListadoDescuentos: TFrmListadoDescuentos;
  sTipo_Auxi: string;

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
   UFPORTIPO,
   USAGCLASSES, USAGDATA;

resourcestring
    FICHERO_ACTUAL = 'UFListadoDescuentos.PAS';

const
    TIPO_ARQUEO_DESCUENTOS = 'D';


procedure DoListadoDescuento(const FI,FF,aCodDescuento: string;
                       var sTotFact, sTotNC, sTotImp, sTotIVAIns, sTotIVANoIns, sTotTot, sTotIIBB: string);

begin
    DeleteTable(MyBD, 'TTMPARQCAJAEXTENDESC');

    with TSQLStoredProc.Create(application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_ARQUEO_VTV.DOARQUEOCAJAXDESCUENTO';
        Prepared := true;
        ParamByName('FECHAINI').Value := FI;
        ParamByName('FECHAFIN').Value := FF;
        ParamByName('aDescuento').Value := aCodDescuento;

        ExecProc;

        sTotFact := ParamByName('NumFacturas').AsString;
        sTotTot := floattostrf(strtofloat(ParamByName('totalencaja').AsString),fffixed,8,2);
        sTotNC := ParamByName('numcontrafacturas').AsString;
        sTotImp := floattostrf(strtofloat(ParamByName('debeencaja').AsString),fffixed,8,2);
        sTotIVAIns := floattostrf(strtofloat(ParamByName('ivaencaja').AsString),fffixed,8,2);
        sTotIVANoIns := floattostrf(strtofloat(ParamByName('ivanoinscriptoencaja').AsString),fffixed,8,2);
        sTotIIBB := floattostrf(strtofloat(ParamByName('IIBBEnCaja').AsString),fffixed,8,2);

        Close;
    finally
        Free
    end
end;


procedure GenerateListadoDescuento (const TipoArqueo: string);
begin
    sTipo_Auxi := TipoArqueo;

    if (sTipo_Auxi = '') then
       sTipo_Auxi := TIPO_ARQUEO_DESCUENTOS;


        with TFrmListadoDescuentos.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                TotalImporte := '0';  TotalIIBB := '0';
                Total := '0'; NumeroFacturas := '0'; NumeroNotasCredito := '0';

                If not GetDates(DateIni,DateFin) then Exit;

                If not PorTipo(TIPO_ARQUEO_DESCUENTOS, aTipoCliente, DateIni, DateFin) then Exit;

                Caption := Format('Listado de Facturas con Descuentos. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                FTmp.Temporizar(TRUE,FALSE,'Listado de Facturas con Descuentos', 'Generando el informe listado de facturas con descuentos.');
                Application.ProcessMessages;

                DoListadoDescuento(DateIni, DateFin, aTipoCliente, NumeroFacturas, NumeroNotasCredito, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, TotalIIBB);

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

procedure TFrmListadoDescuentos.FormCreate(Sender: TObject);
begin
    bErrorCreando := False;

    if (not MyBD.InTransaction) then MyBD.StartTransaction(td);

    try
        LoockAndDeleteTable(MyBD, 'TTMPARQCAJAEXTENDESC')
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
            MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
            bErrorCreando := True
        end
    end
end;

procedure TFrmListadoDescuentos.FormDestroy(Sender: TObject);
begin
    QTTMPLISTDESCUENTOS.Close;

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

function TFrmListadoDescuentos.PutEstacion : string;
begin
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
    Result := NumeroEstacion + ' ' + NombreEstacion;
end;


function TFrmListadoDescuentos.PutTipoPago(const aTP : string) : string;
begin
            result := TIPO_ARQUEO_DESCUENTOS;
            TipoPago := TIPO_ARQUEO_DESCUENTOS;
end;

procedure TFrmListadoDescuentos.PutSumaryResults;
begin
    try
        TotalImporte := ConviertePuntoEnComa(TotalImporte);
        TotalIva := ConviertePuntoEnComa(TotalIva);
        TotalIvaNoInscripto := ConviertePuntoEnComa(TotalIvaNoInscripto);
        Total := ConviertePuntoEnComa(Total);
        TotalIIBB := ConviertePuntoEnComa(TotalIIBB);

        EdtTotalImporte.Text := TotalImporte;
        EdtTotalIVA.Text := TotalIva;
        EdtTotalIVANOInscripto.Text := TotalIvaNoInscripto;
        EdtTotalTotal.Text := Total;
        edtTotalIIBB.Text := TotalIIBB;

        EdtTotalFacturas.Text := NumeroFacturas;
        EdtTotalNotasCredito.Text := NumeroNotasCredito;


        with QTTMPLISTDESCUENTOS do
        begin
            Close;
            sdsTTMPARQCAJA.SQLConnection := MyBD;
            CommandText := 'SELECT PTOVENTA, NUMFACTURA, TIPOCLIENTE, TO_CHAR(FECHALTA,''YYYY/DD/MM'') FO, ' +
                    'TO_CHAR(FECHALTA,''DD/MM/YY'') FECHALTA, TIPOFACTURA, NUMINFORME, ' +
                    'DOMINIO, TIPOPAGO, TIPOCLIENTE, NOMBRECLIENTE, IMPORTE, IVA, IVANOINSCRIPTO, ' +
                    'TOTAL, CONCDESC, NROCUPON, IIBB FROM TTMPARQCAJAEXTENDESC ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ';
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTDESCUENTOS);
            {$ENDIF}
            Open;
        end
    finally
        Application.ProcessMessages;
    end;
end;


procedure TFrmListadoDescuentos.PrintClick(Sender: TObject);
begin
                    with TFListadoFacXDescuentosToPrint.Create(Application) do
                    try
                        Execute(DateIni, DateFin, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, NumeroFacturas, NumeroNotasCredito, NombreEstacion, NumeroEstacion, aTipoCliente, TotalIIBB);
                    finally
                        Free;
                    end;
end;

procedure TFrmListadoDescuentos.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            TotalImporte := '0'; TotalIva := '0';  TotalIvaNoInscripto := '0';
            Total := '0'; NumeroFacturas := '0'; NumeroNotasCredito := '0';

            If Not GetDates(DateIni,DateFin) Then Exit;
            Caption := Format('Listado de Facturas con Descuento. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
            FTmp.Temporizar(TRUE,FALSE,'Listado de Facturas con Descuento','Generando el informe Listado de Facturas con Descuento.');
            Application.ProcessMessages;

            DoListadoDescuento(DateIni, DateFin, aTipoCliente, NumeroFacturas, NumeroNotasCredito, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, TotalIIBB);

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

procedure TFrmListadoDescuentos.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure TFrmListadoDescuentos.AscciClick(Sender: TObject);
begin
                    with TFListadoFacXDescuentosToPrint.Create(Application) do
                    try
                        ExportaAscii(DateIni, DateFin, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, NumeroFacturas, NumeroNotasCredito, NombreEstacion, NumeroEstacion, aTipoCliente, TotalIIBB);
                    finally
                        Free;
                    end;
end;

procedure TFrmListadoDescuentos.ExcelClick(Sender: TObject);
const
    F_TTL = 1;   C_TTL = 4;
    F_STT = 2;   C_STT = 4;
    F_TPG = 6;   C_TPG = 2;
    F_NFA = 8;   C_NFA = 2;
    F_NAB = 9;   C_NAB = 2;
    F_INI = 11;

    C_LTT = 10;
    C_TIM = 11;
    C_IVA = 12;
    C_IVN = 13;
    C_TIB = 14;
    C_TTO = 15;
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
        FTmp.Temporizar(TRUE,FALSE,'Arqueo de Caja de Facturas con Descuento', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        ExcelHoja := ExcelLibro.Worksheets[1];

        f:= F_INI;
        ExcelHoja.cells[F_TTL,C_TTL].value := 'Arqueo de Caja de Facturas con Descuento';
        ExcelHoja.cells[F_STT,C_STT].value :=Format('Planta nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
        with tDescuento.CreateFromCoddescu(MyBD,aTipocliente) do
          try
            open;
            ExcelHoja.cells[F_TPG,C_TPG].value :=ValueByName[FIELD_CONCEPTO];

          finally
            free;
          end;
//        ExcelHoja.cells[F_TPG,C_TPG].value :='GLOBAL';
        ExcelHoja.cells[F_NFA,C_NFA].value :=EdtTotalFacturas.Text;
        ExcelHoja.cells[F_NAB,C_NAB].value :=EdtTotalNotasCredito.Text;

        QTTMPLISTDESCUENTOS.First;
        while not QTTMPLISTDESCUENTOS.EOF do
        begin
            for i := 0 to DBGridArqueoCaja.Columns.Count - 1 do
                ExcelHoja.cells[f,i+1].value :=QTTMPLISTDESCUENTOS.FieldByName(DBGridArqueoCaja.Columns[i].FieldName).AsString;
            QTTMPLISTDESCUENTOS.Next;
            inc(f);
        end;
        QTTMPLISTDESCUENTOS.First;

        if f=F_INI then f := f + 1;

        ExcelHoja.cells[f,C_LTT].value :='TOTALES';
        ExcelHoja.cells[f,C_TIM].value :=EdtTotalImporte.Text;
        ExcelHoja.cells[f,C_IVA].value :=EdtTotalIVA.Text;
        ExcelHoja.cells[f,C_IVN].value :=EdtTotalIVANOInscripto.Text;
        ExcelHoja.cells[f,C_TIB].value :=EdtTotalIIBB.Text;
        ExcelHoja.cells[f,C_TTO].value :=EdtTotalTotal.Text;
      end;
      opendialog.Title := 'Seleccione la Planilla de Salida';
      if OpenDialog.Execute then
         excellibro.saveas(opendialog.filename);
      ExcelApp.Quit;
    except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de UfListadoDescuentos: %s', [E.message]);
                MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
            end
    end;
  finally
      DBGridArqueoCaja.DataSource.DataSet.enableControls;
      FTmp.Temporizar(FALSE,FALSE,'','');
      application.ProcessMessages;
  end;

end;



procedure TFrmListadoDescuentos.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TFrmListadoDescuentos.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;


procedure TFrmListadoDescuentos.btnDescClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            TotalImporte := '0'; TotalIva := '0';  TotalIvaNoInscripto := '0';
            Total := '0'; NumeroFacturas := '0'; NumeroNotasCredito := '0';

            If not PorTipo(TIPO_ARQUEO_DESCUENTOS, aTipoCliente, DateIni, DateFin) then Exit;
            Caption := Format('Listado de Facturas con Descuento. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
            FTmp.Temporizar(TRUE,FALSE,'Arqueo de Caja','Generando el informe Listado de Facturas con Descuento.');
            Application.ProcessMessages;

            DoListadoDescuento(DateIni, DateFin, aTipoCliente, NumeroFacturas, NumeroNotasCredito, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, TotalIIBB);

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


end.


