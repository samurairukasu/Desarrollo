unit UARQUEOCAJAEXTENDEDGNC;


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, USagClasses, comObj, Dialogs, FMTBcd, SqlExpr, Provider,
  DBClient, DB;

type
  TFArqueoCajaGNC = class(TForm)
    lblTotalFacturas: TLabel;
    lblTotalNotasCredito: TLabel;
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
    Label7: TLabel;
    OpenDialog: TOpenDialog;
    qCajeros: TClientDataSet;
    DataSetProvider2: TDataSetProvider;
    dsQCajeros: TSQLDataSet;
    QTTMPARQCAJAEXTEN: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    sdsTTMPARQCAJA: TSQLDataSet;
    edtTotalFacturas: TEdit;
    edtTotalNotasCredito: TEdit;
    edtTotalImporte: TEdit;
    edtTotalIVA: TEdit;
    edtTotalIVANOInscripto: TEdit;
    edtTotalIIBB: TEdit;
    edtTotalTotal: TEdit;
    Panel1: TPanel;
    DBGridArqueoCaja: TDBGrid;
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
    procedure ExportacionExcelGeneral;
  public
    { Public declarations }
    bErrorCreando : boolean;
    NombreEstacion, NumeroEstacion,
    TipoPago,
    DateIni, DateFin,
    TotalImporte,
    TotalIva, TotalIIBB,
    TotalIvaNoInscripto,
    Total,
    NumeroFacturas,
    NumeroNotasCredito, aTipoCliente : string;
    function PutTipoPago(const aTP : string): string;
    function PutEstacion : string;
  end;

  procedure GenerateArqueoCajaGNC (const TipoArqueo: string);
  procedure DoArqueoCajaGNC(const FI,FF,sTipoArqueo: string;
                         var sTotFact, sTotNC, sTotImp, sTotIVAIns, sTotIVANoIns, sTotTot, sTotIIBB: string; sTipoCliente:string);

var
  FArqueoCajaGNC: TFArqueoCajaGNC;
  sTipo_Auxi: string;
  
implementation

{$R *.DFM}


uses
   UCDIALGS,
   UUTILS,
   UGETDATES,
   ULOGS,
   GLOBALS,
   UARQUEOCAJAGNCTOPRINT,
   UFTMP,
   USAGESTACION,
   UFPorTipo;


resourcestring
    FICHERO_ACTUAL = 'UArqueoCajaExtendedGNC.PAS';

    TIPO_ARQUEO_AMBOS = 'A';
    TIPO_ARQUEO_TARJETA = 'T';
    TIPO_ARQUEO_CLIENTES = 'L';
    CADENA_ARQUEO_AMBOS = 'Global';


procedure DoArqueoCajaGNC(const FI,FF,sTipoArqueo: string;
                       var sTotFact, sTotNC, sTotImp, sTotIVAIns, sTotIVANoIns, sTotTot, sTotIIBB: string; sTipoCliente: string);

begin
    DeleteTable(MyBD, 'TTMPARQCAJAEXTENCAJGNC');
    {El listado por tipo de clientes utiliza la tabla TTMPARQCAJAEXTEN}
    if sTipoArqueo =  TIPO_ARQUEO_CLIENTES then
        DeleteTable(MyBD, 'TTMPARQCAJAEXTENCAJGNC');
    with TSQLStoredProc.Create(application) do
    try
        SQLConnection := MyBD;

        if sTipoArqueo = TIPO_ARQUEO_AMBOS then
           StoredProcName := 'PQ_ARQUEO_GNC.DOARQUEOCAJAGLOBAL_GNC'
        else if (sTipoArqueo = V_FORMA_PAGO[tfpTarjeta]) then
        begin
              if sTipoCliente <> '' then
                StoredProcName := 'PQ_ARQUEO_GNC.DOARQUEOCAJATARJETAFGNC'
              else
                StoredProcName := 'PQ_ARQUEO_GNC.DOARQUEOCAJAFXPAGO_GNC'
        end
        else
           StoredProcName := 'PQ_ARQUEO_GNC.DOARQUEOCAJAFXPAGO_GNC';

        Prepared := true;
        ParamByName('FECHAINI').Value := FI;
        ParamByName('FECHAFIN').Value := FF;

        if StoredProcName = 'PQ_ARQUEO_GNC.DOARQUEOCAJATARJETAFGNC' then
          ParamByName('CodigoTarjeta').Value := sTipoCliente;
        if StoredProcName = 'PQ_ARQUEO_GNC.DOARQUEOCAJAFXPAGO_GNC' then
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


procedure GenerateArqueoCajaGNC (const TipoArqueo: string);
begin
    sTipo_Auxi := TipoArqueo;

    if (sTipo_Auxi = '') then
       sTipo_Auxi := TIPO_ARQUEO_AMBOS;


        with TFArqueoCajaGNC.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                TotalImporte := '0'; TotalIva := '0';  TotalIvaNoInscripto := '0';
                Total := '0'; NumeroFacturas := '0'; NumeroNotasCredito := '0';
                TotalIIBB := '0';
                If not GetDates(DateIni,DateFin) then Exit;


                if sTipo_Auxi = TIPO_ARQUEO_TARJETA then          
                   aTipoCliente := '';

                Caption := Format('Arqueo de Caja GNC. Planta: %S. (%S - %S) %S', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10), PutTipoPago(sTipo_Auxi)]);
                FTmp.Temporizar(TRUE,FALSE,'Arqueo de Caja GNC', 'Generando el informe arqueo de caja GNC.');
                Application.ProcessMessages;

                if (sTipo_Auxi = TIPO_ARQUEO_CLIENTES) or (sTipo_auxi = TIPO_ARQUEO_TARJETA) then
                  DoArqueoCajaGNC(DateIni, DateFin, TipoPago, NumeroFacturas, NumeroNotasCredito, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, TotalIIBB, aTipoCliente)
                else
                  DoArqueoCajaGNC(DateIni, DateFin, TipoPago, NumeroFacturas, NumeroNotasCredito, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, TotalIIBB, '');

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

procedure TFArqueoCajaGNC.FormCreate(Sender: TObject);
begin
    bErrorCreando := False;

    if (not MyBD.InTransaction) then MyBD.StartTransaction(td);

    try
    if sTipo_Auxi <>  TIPO_ARQUEO_CLIENTES then
        LoockAndDeleteTable(MyBD, 'TTMPARQCAJAEXTENCAJGNC')
    else
        LoockAndDeleteTable(MyBD, 'TTMPARQCAJAEXTENCAJGNC')
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
            MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
            bErrorCreando := True
        end
    end
end;

procedure TFArqueoCajaGNC.FormDestroy(Sender: TObject);
begin
    QTTMPARQCAJAEXTEN.Close;

    try
        try
            if MyBD.InTransaction then MyBD.Rollback(td) // MyBD.Commit
            else raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del arqueo de Caja GNC')
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

function TFArqueoCajaGNC.PutEstacion : string;
begin
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
    Result := NumeroEstacion + ' ' + NombreEstacion;
end;

function TFArqueoCajaGNC.PutTipoPago(const aTP : string) : string;
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
    else if (aTP = V_FORMA_PAGO[tfptarjeta])   //
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
    else if (aTP = V_FORMA_PAGO[tfpCheque])   //
        then begin
            result := S_FORMA_PAGO[tfpCheque];
            TipoPago := V_FORMA_PAGO[tfpCheque];
        end
    else if (aTP = TIPO_ARQUEO_CLIENTES)   //
        then begin
            result := 'Tipo Cliente' ;
            TipoPago := TIPO_ARQUEO_CLIENTES;
        end


        else begin
            result := CADENA_ARQUEO_AMBOS;
            TipoPago := TIPO_ARQUEO_AMBOS;
        end;
end;

procedure TFArqueoCajaGNC.PutSumaryResults;
var
  fSQL : tstringList;
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

        with QTTMPARQCAJAEXTEN do
        begin
            Close;
            sdsTTMPARQCAJA.SQLConnection := MyBD;
            fSQL := TStringList.Create;
            fSQL.Add('SELECT PTOVENTA, NUMFACTURA, TO_CHAR(FECHALTA,''YYYY/DD/MM'') FO, ' +
                    'TO_CHAR(FECHALTA,''DD/MM/YYYY'') FECHALTA, TIPOFACTURA, NUMINFORME, ' +
                    'DOMINIO, TIPOPAGO, NOMBRECLIENTE, IMPORTE, IVA, IVANOINSCRIPTO, ');
            if sTipo_Auxi <>  TIPO_ARQUEO_CLIENTES then
              fsql.add('TOTAL, CONCEPTO, IIBB FROM TTMPARQCAJAEXTENCAJGNC ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ')
            else
              fsql.add('TOTAL, CONCEPTO, IIBB FROM TTMPARQCAJAEXTENCAJGNC ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ');
            CommandText := fSQL.Text;
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPARQCAJAEXTEN);
            {$ENDIF}
            Open;
        end
    finally
        Application.ProcessMessages;
    end;
end;

procedure TFArqueoCajaGNC.PrintClick(Sender: TObject);
begin
                    with TFArqueoCajaGNCToPrint.Create(Application) do
                    try
                        Execute(DateIni, DateFin, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, NumeroFacturas, NumeroNotasCredito, PutTipoPago(TipoPago), NombreEstacion, NumeroEstacion, aTipoCliente, TotalIIBB);
                    finally
                        Free;
                    end;
end;

procedure TFArqueoCajaGNC.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            TotalImporte := '0'; TotalIva := '0';  TotalIvaNoInscripto := '0';
            Total := '0'; NumeroFacturas := '0'; NumeroNotasCredito := '0';
            TotalIIBB := '0';
            if sTipo_Auxi = TIPO_ARQUEO_TARJETA then          //
               aTipoCliente := '';

            If Not GetDates(DateIni,DateFin) Then Exit;
            Caption := Format('Arqueo de Caja GNC. Planta: %S. (%S - %S) %S', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10), PutTipoPago(TipoPago)]);
            FTmp.Temporizar(TRUE,FALSE,'Arqueo de Caja GNC','Generando el informe arqueo de caja GNC.');
            Application.ProcessMessages;


            if (sTipo_Auxi = TIPO_ARQUEO_CLIENTES) or (sTipo_auxi = TIPO_ARQUEO_TARJETA) then
                  DoArqueoCajaGNC(DateIni, DateFin, TipoPago, NumeroFacturas, NumeroNotasCredito, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, TotalIIBB, aTipoCliente)
            else
                  DoArqueoCajaGNC(DateIni, DateFin, TipoPago, NumeroFacturas, NumeroNotasCredito, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, TotalIIBB,'');

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

procedure TFArqueoCajaGNC.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;

procedure TFArqueoCajaGNC.AscciClick(Sender: TObject);
begin
                    with TFArqueoCajaGNCToPrint.Create(Application) do
                    try
                        ExportaAscii(DateIni, DateFin, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, NumeroFacturas, NumeroNotasCredito, PutTipoPago(TipoPago), NombreEstacion, NumeroEstacion, aTipoCliente, TotalIIBB);
                    finally
                        Free;
                    end;
end;

procedure TFArqueoCajaGNC.ExcelClick(Sender: TObject);
begin
     ExportacionExcelGeneral
end;

procedure TFArqueoCajaGNC.ExportacionExcelGeneral;
const
    F_TTL = 1;   C_TTL = 4;
    F_STT = 2;   C_STT = 4;
    F_TPG = 6;   C_TPG = 2;
    F_NFA = 8;   C_NFA = 2;
    F_NAB = 9;   C_NAB = 2;
    F_INI = 11;

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

        ExcelHoja.cells[F_TTL,C_TTL].value := 'Arqueo de Caja GNC';
        ExcelHoja.cells[F_STT,C_STT].value := Format('Planta nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
        ExcelHoja.cells[F_TPG,C_TPG].value := PutTipoPago(TipoPago);
        ExcelHoja.cells[F_NFA,C_NFA].value := EdtTotalFacturas.Text;
        ExcelHoja.cells[F_NAB,C_NAB].value := EdtTotalNotasCredito.Text;

        if tipopago = TIPO_ARQUEO_CLIENTES then
        begin
             ExcelHoja.cells[F_TTL,C_TTL].value := 'Arqueo de Caja GNC Por Tipo de Cliente';
             fTiposCliente := TTiposCliente.CreateFromDatabase(MyBD,DATOS_TIPOS_DE_CLIENTE,FORMAT('WHERE TIPOCLIENTE_ID = ''%S''',[aTipoCliente]));
             fTiposCliente.open;
             ExcelHoja.cells[F_TPG,C_TPG-1].value := 'Tipo de Cliente: ';
             ExcelHoja.cells[F_TPG,C_TPG].value := fTiposCliente.ValueByName[FIELD_DESCRIPCION];
             fTiposCliente.close;
             fTiposCliente.free;
        end;

        QTTMPARQCAJAEXTEN.First;
        while not QTTMPARQCAJAEXTEN.EOF do
        begin
             for i := 0 to DBGridArqueoCaja.Columns.Count - 1 do
                 ExcelHoja.cells[f,i+1].value := conviertecomaenpunto(QTTMPARQCAJAEXTEN.FieldByName(DBGridArqueoCaja.Columns[i].FieldName).AsString);
             QTTMPARQCAJAEXTEN.Next;
             inc(f);
        end;
        QTTMPARQCAJAEXTEN.First;

        if f=F_INI
           then f := f + 1;

        ExcelHoja.cells[f,C_LTT].value := 'TOTALES';
        ExcelHoja.cells[f,C_TIM].value := conviertecomaenpunto(EdtTotalImporte.Text);
        ExcelHoja.cells[f,C_IVA].value := conviertecomaenpunto(EdtTotalIVA.Text);
        ExcelHoja.cells[f,C_IVN].value := conviertecomaenpunto(EdtTotalIVANOInscripto.Text);
        ExcelHoja.cells[f,C_TIB].value := conviertecomaenpunto(EdtTotalIIBB.Text);
        ExcelHoja.cells[f,C_TTO].value := conviertecomaenpunto(EdtTotalTotal.Text);

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

procedure TFArqueoCajaGNC.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TFArqueoCajaGNC.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;


end.



