unit UARQUEOCAJAEXTENDED;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, USagClasses, Dialogs, comobj, FMTBcd, SqlExpr, Provider,
  DBClient, DB;

type
  TFArqueoCajaExt = class(TForm)
    Panel1: TPanel;
    DBGridArqueoCaja: TDBGrid;
    lblTotalFacturas: TLabel;
    lblTotalNotasCredito: TLabel;
    edtTotalImporte: TEdit;
    edtTotalTotal: TEdit;
    edtTotalFacturas: TEdit;
    edtTotalNotasCredito: TEdit;
    DSourceArqueoCaja: TDataSource;
    edtTotalIVANOInscripto: TEdit;
    edtTotalIVA: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    Bevel2: TBevel;
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
    Resumen: TSpeedItem;
    EdTotalIIBB: TEdit;
    Label7: TLabel;
    OpenDialog: TOpenDialog;
    sdsTTMPARQCAJA: TSQLDataSet;
    QTTMPARQCAJAEXTEN: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    dsQCajeros: TSQLDataSet;
    DataSetProvider2: TDataSetProvider;
    qCajeros: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PutSumaryResults;
    procedure PrintClick(Sender: TObject);
    procedure SBBusquedaClick(Sender: TObject);
    procedure SBSalirClick(Sender: TObject);
    procedure ResumenClick(Sender: TObject);
    procedure AscciClick(Sender: TObject);
    procedure ExcelClick(Sender: TObject);
    procedure ExportacionExcelResumen;
    procedure ExportacionExcelGeneral;
  public
    { Public declarations }
    bErrorCreando : boolean;
    NombreEstacion, NumeroEstacion,
    TipoPago,
    DateIni, DateFin,
    TotalImporte,
    TotalIva,
    TotalIvaNoInscripto,
    Total, TotalIIBB,
    NumeroFacturas,
    NumeroNotasCredito, aTipoCliente : string;
    function PutTipoPago(const aTP : string): string;
    function PutEstacion : string;
  end;

  procedure GenerateArqueoCajaExtended (const TipoArqueo: string);
  procedure DoArqueoCaja(const FI,FF,sTipoArqueo: string;
                         var sTotFact, sTotNC, sTotImp, sTotIVAIns, sTotIVANoIns, sTotTot, sTotIIBB: string; sTipoCliente:string);

var
  FArqueoCajaExt: TFArqueoCajaExt;
  sTipo_Auxi: string;
  
implementation

{$R *.DFM}


uses
   UCDIALGS,
   UUTILS,
   UGETDATES,
   ULOGS,
   GLOBALS,
   UARQUEOCAJAEXTENDEDTOPRINT,
   UARQUEOCAJASUMARYPRINT,
   UARQUEOCAJASUMARY,
   UFINFORMESDIALOGPRINT,
   UFINFORMESDIALOGASCII,
   UFINFORMESDIALOGEXCEL,
   UFTMP,
   USAGESTACION,
   USAGVARIOS,
   UFPorTipo;


resourcestring
    FICHERO_ACTUAL = 'UArqueoCajaExtended.PAS';

    TIPO_ARQUEO_AMBOS = 'A';
    TIPO_ARQUEO_TARJETA = 'T';
    TIPO_ARQUEO_CLIENTES = 'L';
    CADENA_ARQUEO_AMBOS = 'Global';


procedure DoArqueoCaja(const FI,FF,sTipoArqueo: string;
                       var sTotFact, sTotNC, sTotImp, sTotIVAIns, sTotIVANoIns, sTotTot, sTotIIBB: string; sTipoCliente: string);

begin
    DeleteTable(MyBD, 'TTMPARQCAJAEXTENCAJ');
    {El listado por tipo de clientes utiliza la tabla TTMPARQCAJAEXTEN}
    if sTipoArqueo =  TIPO_ARQUEO_CLIENTES then
        DeleteTable(MyBD, 'TTMPARQCAJAEXTEN');
    with TSQLStoredProc.Create(application) do
    try
        SQLConnection := MyBD;

        if sTipoArqueo = TIPO_ARQUEO_AMBOS then
           StoredProcName := 'PQ_ARQUEO_VTV.DOARQUEOCAJAGLOBAL'
        else if (sTipoArqueo = V_FORMA_PAGO[tfpTarjeta]) then
        begin
              if sTipoCliente <> '' then
                // Arqueo de Tarjetas filtrado por tarjeta
                StoredProcName := 'PQ_ARQUEO_VTV.DOARQUEOCAJATARJETAEXTENDEDF'
              else
                StoredProcName := 'PQ_ARQUEO_VTV.DOARQUEOCAJAFXPAGO'
        end
        else if (sTipoArqueo = TIPO_ARQUEO_CLIENTES) then
        begin
              StoredProcName := 'PQ_ARQUEO_VTV.DOARQUEOCAJAXTIPOCLIENTE'
        end
        else
              StoredProcName := 'PQ_ARQUEO_VTV.DOARQUEOCAJAFXPAGO';

        Prepared := true;
        ParamByName('FECHAINI').Value := FI;
        ParamByName('FECHAFIN').Value := FF;

        if (sTipoArqueo = TIPO_ARQUEO_CLIENTES) then
            ParamByName('aTipoCliente').Value := sTipoCliente;
        if StoredProcName = 'PQ_ARQUEO_VTV.DOARQUEOCAJATARJETAEXTENDEDF' then
            ParamByName('CodigoTarjeta').Value := sTipoCliente;
        if StoredProcName = 'PQ_ARQUEO_VTV.DOARQUEOCAJAFXPAGO' then
            ParamByName('FormPago').value := sTipoArqueo;

        ExecProc;

        sTotFact := ParamByName('numfacturas').AsString;
        sTotNC := ParamByName('numcontrafacturas').AsString;
        sTotImp := floattostrf(strtofloat(ParamByName('debeencaja').AsString),fffixed,8,2);
        sTotIVAIns := floattostrf(strtofloat(ParamByName('ivaencaja').AsString),fffixed,8,2);
        sTotIVANoIns := floattostrf(strtofloat(ParamByName('ivanoinscriptoencaja').AsString),fffixed,8,2);
        sTotTot := floattostrf(strtofloat(ParamByName('totalencaja').AsString),fffixed,8,2);
        sTotIIBB := floattostrf(strtofloat(ParamByName('IIBBEnCaja').AsString),fffixed,8,2);
        Close;
    finally
        Free
    end
end;


procedure GenerateArqueoCajaExtended (const TipoArqueo: string);
begin
    sTipo_Auxi := TipoArqueo;

    if (sTipo_Auxi = '') then
       sTipo_Auxi := TIPO_ARQUEO_AMBOS;


        with TFArqueoCajaExt.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                TotalImporte := '0'; TotalIva := '0';  TotalIvaNoInscripto := '0';
                Total := '0'; NumeroFacturas := '0'; NumeroNotasCredito := '0';
                TotalIIBB := '0';

                If not GetDates(DateIni,DateFin) then Exit;

                if sTipo_Auxi = TIPO_ARQUEO_CLIENTES then
                begin
                   If not PorTipo(TIPO_ARQUEO_CLIENTES, aTipoCliente,'','') then Exit;
                end
                else
                if sTipo_Auxi = TIPO_ARQUEO_TARJETA then
                   If not PorTipo(TIPO_ARQUEO_TARJETA, aTipoCliente,'','') then Exit;

                Caption := Format('Arqueo de Caja. Planta: %S. (%S - %S) %S', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10), PutTipoPago(sTipo_Auxi)]);
                FTmp.Temporizar(TRUE,FALSE,'Arqueo de Caja', 'Generando el informe arqueo de caja.');
                Application.ProcessMessages;

                if (sTipo_auxi = TIPO_ARQUEO_TARJETA) and (aTipoCliente <> '') then
                begin
                  DBGridArqueoCaja.Columns[3].FieldName:='DOMINIO';
                  DBGridArqueoCaja.Columns[4].FieldName:='TIPOPAGO';
                  DBGridArqueoCaja.Columns[5].FieldName:='NUMINFORME';
                  DBGridArqueoCaja.Columns[3].Title.caption:='Dominio';
                  DBGridArqueoCaja.Columns[3].width:=71;
                  DBGridArqueoCaja.Columns[4].Title.caption:='Nº Tarjeta';
                  DBGridArqueoCaja.Columns[4].width:=134;
                  DBGridArqueoCaja.Columns[5].Title.caption:='Autorización';
                  DBGridArqueoCaja.Columns[5].width:=100;
                end;

                if (sTipo_Auxi = TIPO_ARQUEO_CLIENTES) or (sTipo_auxi = TIPO_ARQUEO_TARJETA) then
                  DoArqueoCaja(DateIni, DateFin, TipoPago, NumeroFacturas, NumeroNotasCredito, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, TotalIIBB, aTipoCliente)
                else
                  DoArqueoCaja(DateIni, DateFin, TipoPago, NumeroFacturas, NumeroNotasCredito, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, TotalIIBB,'');

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

procedure TFArqueoCajaExt.FormCreate(Sender: TObject);
begin
    bErrorCreando := False;

    if (not MyBD.InTransaction) then MyBD.StartTransaction(td);

    try
    if sTipo_Auxi <>  TIPO_ARQUEO_CLIENTES then
        LoockAndDeleteTable(MyBD, 'TTMPARQCAJAEXTENCAJ')
    else
        LoockAndDeleteTable(MyBD, 'TTMPARQCAJAEXTEN')
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
            MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
            bErrorCreando := True
        end
    end
end;

procedure TFArqueoCajaExt.FormDestroy(Sender: TObject);
begin
    QTTMPARQCAJAEXTEN.Close;

    try
        try
            if MyBD.InTransaction then
              Begin
                MyBD.Rollback(td); // MyBD.Commit
              end
            else
              raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del arqueo de Caja')
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

function TFArqueoCajaExt.PutEstacion : string;
begin
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
    Result := NumeroEstacion + ' ' + NombreEstacion;
end;


function TFArqueoCajaExt.PutTipoPago(const aTP : string) : string;
var fTarjeta : tTarjeta;
begin
    if aTP = V_FORMA_PAGO[tfpMetalico]
    then begin
        result :=  S_FORMA_PAGO[tfpMetalico];
        TipoPago := V_FORMA_PAGO[tfpMetalico];
    end
    else if (aTP = V_FORMA_PAGO[tfpCredito])
        then begin
            result := S_FORMA_PAGO[tfpCredito];
            TipoPago := V_FORMA_PAGO[tfpCredito];
        end
    else if (aTP = V_FORMA_PAGO[tfptarjeta])
        then begin
            if aTipoCliente = '' then
              result := S_FORMA_PAGO[tfpTarjeta]
            else
            begin
              ftarjeta := nil;
              try
                fTarjeta := ttarjeta.CreateByCodTarjet(MyBD,aTipoCliente);
                fTarjeta.open;
                result := S_FORMA_PAGO[tfpTarjeta]+' - '+fTarjeta.valuebyname[FIELD_ABREVIA];
              finally
                fTarjeta.free;
              end;
            end;
            TipoPago := V_FORMA_PAGO[tfpTarjeta];
        end
    else if (aTP = V_FORMA_PAGO[tfpCheque])
        then begin
            result := S_FORMA_PAGO[tfpCheque];
            TipoPago := V_FORMA_PAGO[tfpCheque];
        end
    else if (aTP = TIPO_ARQUEO_CLIENTES)
        then begin
            result := 'Tipo Cliente' ;
            TipoPago := TIPO_ARQUEO_CLIENTES;
        end


        else begin
            result := CADENA_ARQUEO_AMBOS;
            TipoPago := TIPO_ARQUEO_AMBOS;
        end;
end;

procedure TFArqueoCajaExt.PutSumaryResults;
var
  fSQL : tstringList;
begin
    try
        TotalImporte := ConviertePuntoEnComa(TotalImporte);
        TotalIva := ConviertePuntoEnComa(TotalIva);
        TotalIvaNoInscripto := ConviertePuntoEnComa(TotalIvaNoInscripto);
        Total := ConviertePuntoEnComa(Total);

        EdtTotalImporte.Text := TotalImporte;
        EdtTotalIVA.Text := TotalIva;
        EdtTotalIVANOInscripto.Text := TotalIvaNoInscripto;
        EdtTotalTotal.Text := Total;
        EdTotalIIBB.Text := TotalIIBB;

        EdtTotalFacturas.Text := NumeroFacturas;
        EdtTotalNotasCredito.Text := NumeroNotasCredito;

        with QTTMPARQCAJAEXTEN do
        begin
            Close;
            sdsTTMPARQCAJA.SQLConnection := MyBD;
            fSQL := TStringList.Create;
            fSQL.Add('SELECT PTOVENTA, NUMFACTURA, TIPOCLIENTE, TO_CHAR(FECHALTA,''YYYY/MM/DD'') FO, ' +
                    'TO_CHAR(FECHALTA,''DD/MM/YYYY'') FECHALTA, TIPOFACTURA, NUMINFORME, ' +
//                    'DOMINIO, TIPOPAGO, TIPOCLIENTE, NOMBRECLIENTE, IMPORTE, IVA, IVANOINSCRIPTO, ');
                    'DOMINIO, TIPOPAGO, NOMBRECLIENTE, IMPORTE, IVA, IVANOINSCRIPTO, IDPAGO, IDTURNO, ');
            if sTipo_Auxi <>  TIPO_ARQUEO_CLIENTES then
              fsql.add('TOTAL, IIBB, CONCEPTO, CODIGOPAGO, ENTIDAD FROM TTMPARQCAJAEXTENCAJ ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ')
            else
              fsql.add('TOTAL, IIBB, CONCEPTO FROM TTMPARQCAJAEXTEN ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ');
            CommandText := fSQL.text;
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPARQCAJAEXTEN);
            {$ENDIF}

            Open;
        end
    finally
        Application.ProcessMessages;
    end;
end;


procedure TFArqueoCajaExt.PrintClick(Sender: TObject);
begin
    with TFDialogPrint.Create(Application) do
    try
       if ShowModal = mrOk
       then begin
            case Imprimir of
                tiGeneral:
                begin
                    with TFArqueoCajaExtendedToPrint.Create(Application) do
                    try
                        Execute(DateIni, DateFin, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, NumeroFacturas, NumeroNotasCredito, PutTipoPago(TipoPago), NombreEstacion, NumeroEstacion, aTipoCliente, TotalIIBB);
                    finally
                        Free;
                    end;
                end;

               tiResumen:
               begin
                   with TFArqueoCajaSumary.Create(Application) do
                   try
                       dsqCajeros.SQLConnection := mybd;

                       qCajeros.CommandText := 'SELECT NVL(SUM(IMPORTE),0) INETO, NVL(SUM(IVA),0) IVA, NVL(SUM(IVANOINSCRIPTO),0) IVAN, NVL(SUM(TOTAL),0) TOT, IDUSUARIO, NOMCAJERO FROM TTMPARQCAJAEXTENCAJ GROUP BY IDUSUARIO, NOMCAJERO';

                       qCajeros.open;
                       QRPorCajero.dataset :=  qCajeros;
                       dbtCajero.DataSet := qCajeros;
                       dbtIneto.DataSet := qCajeros;
                       dbtIva.DataSet := qCajeros;
                       dbtIvan.DataSet := qCajeros;
                       dbtTot.dataset := qCajeros;
                       Execute(DateIni, DateFin, PutTipoPago(TipoPago), aTipoCliente);
                       if sTipo_Auxi <>  TIPO_ARQUEO_CLIENTES then
                         QRPorCajero.Print;
                   finally
                       Free;
                   end;
               end;

               else begin
                    with TFArqueoCajaExtendedToPrint.Create(Application) do
                    try
                        Execute(DateIni, DateFin, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, NumeroFacturas, NumeroNotasCredito, PutTipoPago(TipoPago), NombreEstacion, NumeroEstacion, aTipoCliente, TotalIIBB);
                    finally
                        Free;
                    end;

                    with TFArqueoCajaSumary.Create(Application) do
                    try
                       dsqCajeros.SQLConnection := mybd;

                       qCajeros.CommandText := 'SELECT NVL(SUM(IMPORTE),0) INETO, NVL(SUM(IVA),0) IVA, NVL(SUM(IVANOINSCRIPTO),0) IVAN, NVL(SUM(TOTAL),0) TOT, IDUSUARIO, NOMCAJERO FROM TTMPARQCAJAEXTENCAJ GROUP BY IDUSUARIO, NOMCAJERO';

                       qCajeros.open;
                       QRPorCajero.dataset :=  qCajeros;
                       dbtCajero.DataSet := qCajeros;
                       dbtIneto.DataSet := qCajeros;
                       dbtIva.DataSet := qCajeros;
                       dbtIvan.DataSet := qCajeros;
                       dbtTot.dataset := qCajeros;
                       Execute(DateIni, DateFin, PutTipoPago(TipoPago), aTipoCliente);
                       if sTipo_Auxi <>  TIPO_ARQUEO_CLIENTES then
                         QRPorCajero.Print;
                    finally
                       Free;
                    end;
               end;
            end;
       end;
    finally
        Free;
    end;
end;

procedure TFArqueoCajaExt.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            TotalImporte := '0';
            TotalIva := '0';
            TotalIvaNoInscripto := '0';
            Total := '0';
            NumeroFacturas := '0';
            NumeroNotasCredito := '0';

            if sTipo_Auxi = TIPO_ARQUEO_TARJETA then          
               If not PorTipo(TIPO_ARQUEO_TARJETA, aTipoCliente,'','') then Exit;

            If Not GetDates(DateIni,DateFin) Then Exit;
            Caption := Format('Arqueo de Caja. Planta: %S. (%S - %S) %S', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10), PutTipoPago(TipoPago)]);
            FTmp.Temporizar(TRUE,FALSE,'Arqueo de Caja','Generando el informe arqueo de caja.');
            Application.ProcessMessages;

                if (sTipo_auxi = TIPO_ARQUEO_TARJETA) and (aTipoCliente <> '') then
                begin
                  DBGridArqueoCaja.Columns[3].FieldName:='DOMINIO';
                  DBGridArqueoCaja.Columns[4].FieldName:='TIPOPAGO';
                  DBGridArqueoCaja.Columns[5].FieldName:='NUMINFORME';
                  DBGridArqueoCaja.Columns[3].Title.caption:='Dominio';
                  DBGridArqueoCaja.Columns[3].width:=71;
                  DBGridArqueoCaja.Columns[4].Title.caption:='Nº Tarjeta';
                  DBGridArqueoCaja.Columns[4].width:=134;
                  DBGridArqueoCaja.Columns[5].Title.caption:='Autorización';
                  DBGridArqueoCaja.Columns[5].width:=100;
                end;


            if (sTipo_Auxi = TIPO_ARQUEO_CLIENTES) or (sTipo_auxi = TIPO_ARQUEO_TARJETA) then
                  DoArqueoCaja(DateIni, DateFin, TipoPago, NumeroFacturas, NumeroNotasCredito, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, TotalIIBB, aTipoCliente)
            else
                  DoArqueoCaja(DateIni, DateFin, TipoPago, NumeroFacturas, NumeroNotasCredito, TotalImporte, TotalIva, TotalIvaNoInscripto, Total,TotalIIBB,'');

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

procedure TFArqueoCajaExt.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure TFArqueoCajaExt.ResumenClick(Sender: TObject);
begin
    with TFSumaryCaja.Create(Application) do
    try
        Caption := Format('Resumen por Tipos de Cliente. Planta: %S. (%S - %S) %S', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10), PutTipoPago(TipoPago)]);
        ShowModal;
    finally
        Free;
    end;
end;

procedure TFArqueoCajaExt.AscciClick(Sender: TObject);
begin
    with TFAsciiDialog.Create(Application) do
    try
       if ShowModal = mrOk
       then begin
            case ExportarAscii of

                teaGeneral:
                begin
                    with TFArqueoCajaExtendedToPrint.Create(Application) do
                    try
                        ExportaAscii(DateIni, DateFin, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, NumeroFacturas, NumeroNotasCredito, PutTipoPago(TipoPago), NombreEstacion, NumeroEstacion, aTipoCliente, TotalIIBB);
                    finally
                        Free;
                    end;
                end;

               teaResumen:
               begin
                    with TFArqueoCajaSumary.Create(Application) do
                    try
                       ExportaAscii(DateIni, DateFin, PutTipoPago(TipoPago), aTipoCliente);
                    finally
                       Free;
                    end;
               end;

               else begin

                    with TFArqueoCajaExtendedToPrint.Create(Application) do
                    try
                        ExportaAscii(DateIni, DateFin, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, NumeroFacturas, NumeroNotasCredito, PutTipoPago(TipoPago), NombreEstacion, NumeroEstacion, aTipoCliente, TotalIIBB);
                    finally
                        Free;
                    end;

                    with TFArqueoCajaSumary.Create(Application) do
                    try
                       ExportaAscii(DateIni, DateFin, PutTipoPago(TipoPago), aTipoCliente);
                    finally
                       Free;
                    end;
               end;
            end;
       end;
    finally
        Free;
    end;
end;

procedure TFArqueoCajaExt.ExcelClick(Sender: TObject);

begin
    with TFExcelDialog.Create(Self) do
    try
        if ShowModal = mrOk
        then begin
            case ExportarExcel of

                teeGeneral:
                begin
                    ExportacionExcelGeneral;
                end;

                teeResumen:
                begin
                   ExportacionExcelResumen;
                end;

                else begin

                    ShowMessage('Exportación','Primero realizará la exportación General');

                    ExportacionExcelGeneral;
                    
                    ShowMessage('Exportación','Ahora exportará el Resumen');

                    ExportacionExcelResumen;

                end;
            end;
       end;
    finally
        Free;
    end;
end;


procedure TFArqueoCajaExt.ExportacionExcelGeneral;
const
    F_TTL = 1;   C_TTL = 4;
    F_STT = 2;   C_STT = 4;
    F_TPG = 6;   C_TPG = 2;
    F_NFA = 8;   C_NFA = 2;
    F_NAB = 9;   C_NAB = 2;
    F_INI = 11;  C_INI = 1;

    C_LTT = 8;
    C_TIM = 9;
    C_IVA = 10;
    C_IVN = 11;
    C_TIB = 12;
    C_TTO = 13;
var
    i,f : integer;
    fTiposCliente: TTiposCliente;
    ExcelApp, ExcelLibro, ExcelHoja: Variant;
begin
  try
    DBGridArqueoCaja.DataSource.DataSet.DisableControls;
    try
      opendialog.Title := 'Seleccione la Planilla de Entrada';
      if OpenDialog.Execute then
      begin
        FTmp.Temporizar(TRUE,FALSE,'Arqueo de Caja Extendido', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        ExcelHoja := ExcelLibro.Worksheets[1];

        f:= F_INI;

        ExcelHoja.Cells[F_TTL,C_TTL].value := 'Arqueo de Caja Extendido';
        ExcelHoja.Cells[F_STT,C_STT].value := Format('Planta nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
        ExcelHoja.Cells[F_TPG,C_TPG].value := PutTipoPago(TipoPago);
        ExcelHoja.Cells[F_NFA,C_NFA].value := EdtTotalFacturas.Text;
        ExcelHoja.Cells[F_NAB,C_NAB].value := EdtTotalNotasCredito.Text;

        if tipopago = TIPO_ARQUEO_CLIENTES then
        begin
             ExcelHoja.Cells[F_TTL,C_TTL].value := 'Arqueo de Caja Por Tipo de Cliente';
             fTiposCliente := TTiposCliente.CreateFromDatabase(MyBD,DATOS_TIPOS_DE_CLIENTE,FORMAT('WHERE TIPOCLIENTE_ID = ''%S''',[aTipoCliente]));
             fTiposCliente.open;
             ExcelHoja.Cells[F_TPG,C_TPG-1].value := 'Tipo de Cliente: ';
             ExcelHoja.Cells[F_TPG,C_TPG].value := fTiposCliente.ValueByName[FIELD_DESCRIPCION];
             fTiposCliente.close;
             fTiposCliente.free;
        end;

        QTTMPARQCAJAEXTEN.First;
        while not QTTMPARQCAJAEXTEN.EOF do
        begin
             for i := 0 to DBGridArqueoCaja.Columns.Count - 1 do
              begin
                if  (i <> 3) and (i <> 14) then    //Excluimos de la exportacion Dominio y IdTurno
                 ExcelHoja.Cells[f,C_INI].value := StrToDate(QTTMPARQCAJAEXTEN.FieldByName('FECHALTA').AsString); //Corrige en la exportacion a excel el formato de fecha entre las fecha 01 al 12 del mes. - Lucas
                 ExcelHoja.Cells[f,i+1].value := conviertecomaenpunto(QTTMPARQCAJAEXTEN.FieldByName(DBGridArqueoCaja.Columns[i].FieldName).AsString);
               end;
             QTTMPARQCAJAEXTEN.Next;
             inc(f);
        end;
        QTTMPARQCAJAEXTEN.First;

        if f=F_INI
        then f := f + 1;

        ExcelHoja.Cells[f,C_LTT].value := 'TOTALES';
        ExcelHoja.Cells[f,C_TIM].value := conviertecomaenpunto(EdtTotalImporte.Text);
        ExcelHoja.Cells[f,C_IVA].value := conviertecomaenpunto(EdtTotalIVA.Text);
        ExcelHoja.Cells[f,C_IVN].value := conviertecomaenpunto(EdtTotalIVANOInscripto.Text);
        ExcelHoja.Cells[f,C_TIB].value := conviertecomaenpunto(EdTotaliibb.Text);
        ExcelHoja.Cells[f,C_TTO].value := conviertecomaenpunto(EdtTotalTotal.Text);
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
      DBGridArqueoCaja.DataSource.DataSet.enableControls;
      FTmp.Temporizar(FALSE,FALSE,'','');
      application.ProcessMessages;
  end;

end;

procedure TFArqueoCajaExt.ExportacionExcelResumen;
const
    F_TTL = 1;   C_TTL = 3;
    F_STT = 2;   C_STT = 3;
    F_TPG = 6;   C_TPG = 2;
    F_INI = 9;

    C_TPC = 1;
    C_NFA = 2;
    C_NAB = 3;
    C_IMP = 4;
    C_IVA = 5;
    C_IVN = 6;
    C_TOT = 8;
var
    i,f : integer;
    fTiposCliente: TTiposCliente;
    ExcelApp, ExcelLibro, ExcelHoja: Variant;
begin

 with TFSumaryCaja.Create(Application) do
 try
  try
    try
      opendialog.Title := 'Seleccione la Planilla de Entrada';
      if OpenDialog.Execute then
      begin
        FTmp.Temporizar(TRUE,FALSE,'Resumen Arqueo de Caja Extendido', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        ExcelHoja := ExcelLibro.Worksheets[1];

        ExcelHoja.cells[F_STT,C_STT].value := Format('Planta nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
        ExcelHoja.cells[F_TPG,C_TPG].value := PutTipoPago(TipoPago);

        if tipopago = TIPO_ARQUEO_CLIENTES then
        begin
          ExcelHoja.cells[F_TTL,C_TTL].value := 'Arqueo de Caja Por Tipo de Cliente';
          fTiposCliente := TTiposCliente.CreateFromDatabase(MyBD,DATOS_TIPOS_DE_CLIENTE,FORMAT('WHERE TIPOCLIENTE_ID = ''%S''',[aTipoCliente]));
          fTiposCliente.open;
          ExcelHoja.cells[F_TPG,C_TPG-1].value := 'Tipo de Cliente: ';
          ExcelHoja.cells[F_TPG,C_TPG].value := fTiposCliente.ValueByName[FIELD_DESCRIPCION];
          fTiposCliente.close;
          fTiposCliente.free;
        end;

        f := F_INI;
        for i := 0 to SG.RowCount - 1 do
        begin
            ExcelHoja.cells[f,C_TPC].value := SG.Cells[0,i];
            ExcelHoja.cells[f,C_NFA].value := SG.Cells[1,i];
            ExcelHoja.cells[f,C_NAB].value := SG.Cells[2,i];
            ExcelHoja.cells[f,C_IMP].value := SG.Cells[3,i];
            ExcelHoja.cells[f,C_IVA].value := SG.Cells[4,i];
            ExcelHoja.cells[f,C_IVN].value := SG.Cells[5,i];
            ExcelHoja.cells[f,C_TOT].value := SG.Cells[6,i];
            inc(f)
        end;
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
      FTmp.Temporizar(FALSE,FALSE,'','');
      application.ProcessMessages;
  end;


 finally
   Free;
 end;
end;

end.

