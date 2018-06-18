unit uArqueoCajaXCajeroGNC;



interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, UDDEExcelObject, USagClasses, FMTBcd, SqlExpr, Provider,
  DBClient;

type
  TFArqueoCajaXCajeroGNC = class(TForm)
    lblTotalFacturas: TLabel;
    lblTotalNotasCredito: TLabel;
    edtTotalImporte: TEdit;
    edtTotalTotal: TEdit;
    edtTotalFacturas: TEdit;
    edtTotalNotasCredito: TEdit;
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
    edtTotalIibb: TEdit;
    Label7: TLabel;
    QTTMPARQCAJAEXTEN: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    sdsTTMPARQCAJA: TSQLDataSet;
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

  procedure GenerateArqueoCajaXCajeroGNC (const TipoArqueo: string);
  procedure DoArqueoCajaXCajeroGNC(const FI,FF,sTipoArqueo: string;
                         var sTotFact, sTotNC, sTotImp, sTotIVAIns, sTotIVANoIns, sTotTot, sTotIIBB: string; sTipoCliente:string);

var
  FArqueoCajaXCajeroGNC: TFArqueoCajaXCajeroGNC;
  sTipo_Auxi: string;

implementation

{$R *.DFM}


uses
   UCDIALGS,
   UUTILS,
   UGETDATES,
   ULOGS,
   GLOBALS,
   UArqueoCajaToPrintXCajeroGNC,
   UFTMP,
   USAGESTACION,
   UFPorTipo;


resourcestring
    FICHERO_ACTUAL = 'uArqueoCajaXCajeroGNC.PAS';

    TIPO_ARQUEO_AMBOS = 'A';
    TIPO_ARQUEO_TARJETA = 'T';
    CADENA_ARQUEO_AMBOS = 'Global';
    TIPO_ARQUEO_CAJEROS = 'C';


procedure DoArqueoCajaXCajeroGNC(const FI,FF,sTipoArqueo: string;
                       var sTotFact, sTotNC, sTotImp, sTotIVAIns, sTotIVANoIns, sTotTot, sTotIIBB: string; sTipoCliente: string);

begin
    DeleteTable(MyBD, 'TTMPARQCAJAEXTENCAJGNC');

    with TSQLStoredProc.Create(application) do
    try
        SQLConnection := MyBD;

        if sTipoArqueo = TIPO_ARQUEO_AMBOS then
           StoredProcName := 'PQ_ARQUEO_GNC.DOARQUEOCAJAXCAJEROGLOBAL_GNC'
        else
           StoredProcName := 'PQ_ARQUEO_GNC.DOARQUEOCAJAXCAJEROFXPAGO_GNC';

        Prepared := true;
        ParamByName('FECHAINI').Value := FI;
        ParamByName('FECHAFIN').Value := FF;
        ParamByName('IDCAJERO').Value := sTipoCliente;

        if StoredProcName = 'PQ_ARQUEO_GNC.DOARQUEOCAJAXCAJEROFXPAGO_GNC' then
          ParamByName('FORMPAGO').Value := sTipoArqueo;

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


procedure GenerateArqueoCajaXCajeroGNC (const TipoArqueo: string);
begin
    sTipo_Auxi := TipoArqueo;

    if (sTipo_Auxi = '') then
       sTipo_Auxi := TIPO_ARQUEO_AMBOS;


        with TFArqueoCajaXCajeroGNC.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                TotalImporte := '0'; TotalIva := '0';  TotalIvaNoInscripto := '0';
                Total := '0'; NumeroFacturas := '0'; NumeroNotasCredito := '0'; TotalIIBB := '0';
                If not GetDates(DateIni,DateFin) then Exit;

                If not PorTipo(TIPO_ARQUEO_CAJEROS, aTipoCliente,'','') then Exit;

                with tusuarios.CreateFromDataBase(mybd,DATOS_USUARIO,format('WHERE IDUSUARIO = %S',[aTipoCliente])) do
                 try
                   open;
                   Caption := Format('Arqueo de Caja GNC.  Cajero: '+ValueByName[FIELD_NOMBRE]+' - Planta: %S. (%S - %S) %S', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10), PutTipoPago(sTipo_Auxi)]);
                   close;
                 finally
                   free
                 end;
                FTmp.Temporizar(TRUE,FALSE,'Arqueo de Caja GNC', 'Generando el informe arqueo de caja GNC.');
                Application.ProcessMessages;


                DoArqueoCajaXCajeroGNC(DateIni, DateFin, TipoPago, NumeroFacturas, NumeroNotasCredito, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, TotalIIBB, aTipoCliente);

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

procedure TFArqueoCajaXCajeroGNC.FormCreate(Sender: TObject);
begin
    bErrorCreando := False;

    if (not MyBD.InTransaction) then MyBD.StartTransaction(td);

    try
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

procedure TFArqueoCajaXCajeroGNC.FormDestroy(Sender: TObject);
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

function TFArqueoCajaXCajeroGNC.PutEstacion : string;
begin
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
    Result := NumeroEstacion + ' ' + NombreEstacion;
end;


function TFArqueoCajaXCajeroGNC.PutTipoPago(const aTP : string) : string;
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
        else begin
            result := CADENA_ARQUEO_AMBOS;
            TipoPago := TIPO_ARQUEO_AMBOS;
        end;
end;

procedure TFArqueoCajaXCajeroGNC.PutSumaryResults;
var
  fsql : TStringList;
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
        edtTotalIibb.Text := TotalIIBB;

        EdtTotalFacturas.Text := NumeroFacturas;
        EdtTotalNotasCredito.Text := NumeroNotasCredito;

        with QTTMPARQCAJAEXTEN do
        begin
            Close;
            sdsTTMPARQCAJA.SQLConnection := MyBD;
            fSQL := TStringList.Create;
            fSQL.Clear;
            fSQL.Add('SELECT PTOVENTA, NUMFACTURA, TO_CHAR(FECHALTA,''YYYY/DD/MM'') FO, ' +
                    'TO_CHAR(FECHALTA,''DD/MM/YY'') FECHALTA, TIPOFACTURA, NUMINFORME, ' +
                    'DOMINIO, TIPOPAGO, NOMBRECLIENTE, IMPORTE, IVA, IVANOINSCRIPTO, ' +
                    'TOTAL, CONCEPTO, IIBB FROM TTMPARQCAJAEXTENCAJGNC ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ');
            commandtext := fsql.text;
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPARQCAJAEXTEN);
            {$ENDIF}

            Open;
        end
    finally
        Application.ProcessMessages;
    end;
end;


procedure TFArqueoCajaXCajeroGNC.PrintClick(Sender: TObject);
begin
                    with TFArqueoCajaToPrintxCajeroGNC.Create(Application) do
                    try
                       with tusuarios.CreateFromDataBase(mybd,DATOS_USUARIO,format('WHERE IDUSUARIO = %S',[aTipoCliente])) do
                       try
                          open;
                          QRLlbTitulo.caption := 'Arqueo de Caja GNC - Cajero: '+ValueByName[FIELD_NOMBRE];
                          close;
                       finally
                          free
                       end;
                       Execute(DateIni, DateFin, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, NumeroFacturas, NumeroNotasCredito, PutTipoPago(TipoPago), NombreEstacion, NumeroEstacion, aTipoCliente, TotalIIBB);
                    finally
                        Free;
                    end;
end;

procedure TFArqueoCajaXCajeroGNC.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            TotalImporte := '0'; TotalIva := '0';  TotalIvaNoInscripto := '0';
            Total := '0'; NumeroFacturas := '0'; NumeroNotasCredito := '0';
            TotalIIBB := '0';

            If Not GetDates(DateIni,DateFin) Then Exit;
            If not PorTipo(TIPO_ARQUEO_CAJEROS, aTipoCliente,'','') then Exit;

            with tusuarios.CreateFromDataBase(mybd,DATOS_USUARIO,format('WHERE IDUSUARIO = %S',[aTipoCliente])) do
               try
                   open;
                   Caption := Format('Arqueo de Caja GNC.  Cajero: '+ValueByName[FIELD_NOMBRE]+' - Planta: %S. (%S - %S) %S', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10), PutTipoPago(sTipo_Auxi)]);
                   close;
               finally
                   free
               end;

            FTmp.Temporizar(TRUE,FALSE,'Arqueo de Caja GNC','Generando el informe arqueo de caja GNC.');
            Application.ProcessMessages;

                  DoArqueoCajaXCajeroGNC(DateIni, DateFin, TipoPago, NumeroFacturas, NumeroNotasCredito, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, TotalIIBB, aTipoCliente);

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

procedure TFArqueoCajaXCajeroGNC.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure TFArqueoCajaXCajeroGNC.AscciClick(Sender: TObject);
begin
                    with TFArqueoCajaToPrintxCajeroGNC.Create(Application) do
                    try
                        ExportaAscii(DateIni, DateFin, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, NumeroFacturas, NumeroNotasCredito, PutTipoPago(TipoPago), NombreEstacion, NumeroEstacion, aTipoCliente, Totaliibb);
                    finally
                        Free;
                    end;
end;


procedure TFArqueoCajaXCajeroGNC.ExcelClick(Sender: TObject);
begin
ExportacionExcelGeneral;
end;


Procedure TFArqueoCajaXCajeroGNC.ExportacionExcelGeneral;
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
ExcelApp, ExcelLibro, ExcelHoja: Variant;
begin

f:= F_INI;
with tusuarios.CreateFromDataBase(mybd,DATOS_USUARIO,format('WHERE IDUSUARIO = %S',[aTipoCliente])) do
  try
    open;
    ExcelHoja.Cells[F_TTL,C_TTL].value:='Arqueo de Caja GNC.  Cajero: '+ValueByName[FIELD_NOMBRE];
            close;
         finally
            free
         end;

    ExcelHoja.Cells[F_STT,C_STT].value:=Format('Planta nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
    ExcelHoja.Cells[F_TPG,C_TPG].value:=PutTipoPago(TipoPago);
    ExcelHoja.Cells[F_NFA,C_NFA].value:=EdtTotalFacturas.Text;
    ExcelHoja.Cells[F_NAB,C_NAB].value:=EdtTotalNotasCredito.Text;

    QTTMPARQCAJAEXTEN.First;
    while not QTTMPARQCAJAEXTEN.EOF do
    begin
        for i := 0 to DBGridArqueoCaja.Columns.Count - 1 do
          ExcelHoja.Cells[f,i+1].value:=QTTMPARQCAJAEXTEN.FieldByName(DBGridArqueoCaja.Columns[i].FieldName).AsString;
        QTTMPARQCAJAEXTEN.Next;
        inc(f);
    end;
    QTTMPARQCAJAEXTEN.First;

    if f=F_INI
    then f := f + 1;

    ExcelHoja.Cells[f,C_LTT].value:='TOTALES';
    ExcelHoja.Cells[f,C_TIM].value:=EdtTotalImporte.Text;
    ExcelHoja.Cells[f,C_IVA].value:=EdtTotalIVA.Text;
    ExcelHoja.Cells[f,C_IVN].value:=EdtTotalIVANOInscripto.Text;
    ExcelHoja.Cells[f,C_TIB].value:=EdtTotalIIBB.Text;
    ExcelHoja.Cells[f,C_TTO].value:=EdtTotalTotal.Text;
end;

procedure TFArqueoCajaXCajeroGNC.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TFArqueoCajaXCajeroGNC.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;



end.




