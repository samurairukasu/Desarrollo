unit uArqueoCajaExtendedXCajero;



interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB, SQLExpr, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, UDDEExcelObject, USagClasses, FMTBcd, Provider, comobj,
  DBClient, Dialogs;

type
  TFArqueoCajaExtXCajero = class(TForm)
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
    edtTotalIIBB: TEdit;
    Label7: TLabel;
    QTTMPARQCAJAEXTEN: TClientDataSet;
    dspListCAJAEXTEN: TDataSetProvider;
    sdslistCAJAEXTEN: TSQLDataSet;
    OpenDialog: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PutSumaryResults;
    procedure PrintClick(Sender: TObject);
    procedure SBBusquedaClick(Sender: TObject);
    procedure SBSalirClick(Sender: TObject);
    procedure ResumenClick(Sender: TObject);
    procedure AscciClick(Sender: TObject);
    procedure ExcelClick(Sender: TObject);
    procedure OnOpen (Sender: TObject);
    procedure OnClose (Sender: TObject);
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

  procedure GenerateArqueoCajaExtendedXCajero (const TipoArqueo: string);
  procedure DoArqueoCajaXCajero(const FI,FF,sTipoArqueo: string;
                         var sTotFact, sTotNC, sTotImp, sTotIVAIns, sTotIVANoIns, sTotTot, sTotIIBB: string; sTipoCliente:string);

var
  FArqueoCajaExtXCajero: TFArqueoCajaExtXCajero;
  sTipo_Auxi: string;

implementation

{$R *.DFM}


uses
   UCDIALGS,
   UUTILS,
   UGETDATES,
   ULOGS,
   GLOBALS,
   UARQUEOCAJAEXTENDEDTOPRINTXCAJERO,
   uArqueoCajaSumaryPintXCajero,
   UARQUEOCAJASUMARYxCajero,
   UFINFORMESDIALOGPRINT,
   UFINFORMESDIALOGASCII,
   UFINFORMESDIALOGEXCEL,
   UFTMP,
   USAGESTACION,
   USAGVARIOS,
   UFPorTipo;


resourcestring
    FICHERO_ACTUAL = 'UArqueoCajaExtendedXCajero.PAS';

    TIPO_ARQUEO_AMBOS = 'A';
    TIPO_ARQUEO_TARJETA = 'T';
    CADENA_ARQUEO_AMBOS = 'Global';
    TIPO_ARQUEO_CAJEROS = 'C';


procedure DoArqueoCajaXCajero(const FI,FF,sTipoArqueo: string;
                       var sTotFact, sTotNC, sTotImp, sTotIVAIns, sTotIVANoIns, sTotTot, sTotIIBB: string; sTipoCliente: string);

begin
    DeleteTable(MyBD, 'TTMPARQCAJAEXTEN');

    with TSQLStoredProc.Create(application) do
    try
        SQLConnection := MyBD;
        if (sTipoArqueo <> TIPO_ARQUEO_AMBOS) then
           StoredProcName := 'PQ_ARQUEO_VTV.DOARQUEOCAJAXCAJEROFXPAGO'
        else
           StoredProcName := 'PQ_ARQUEO_VTV.DOARQUEOCAJAXCAJEROGLOBAL';

        Prepared := true ;
        ParamByName('FECHAINI').Value := FI;
        ParamByName('FECHAFIN').Value := FF;
        ParamByName('IDCAJERO').Value := sTipoCliente;

        if StoredProcName = 'PQ_ARQUEO_VTV.DOARQUEOCAJAXCAJEROFXPAGO' then
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


procedure GenerateArqueoCajaExtendedXCajero (const TipoArqueo: string);
begin
    sTipo_Auxi := TipoArqueo;

    if (sTipo_Auxi = '') then
       sTipo_Auxi := TIPO_ARQUEO_AMBOS;


        with TFArqueoCajaExtXCajero.Create(Application) do
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
                   Caption := Format('Arqueo de Caja.  Cajero: '+ValueByName[FIELD_NOMBRE]+' - Planta: %S. (%S - %S) %S', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10), PutTipoPago(sTipo_Auxi)]);
                   close;
                 finally
                   free
                 end;
                FTmp.Temporizar(TRUE,FALSE,'Arqueo de Caja', 'Generando el informe arqueo de caja.');
                Application.ProcessMessages;

{                if (sTipo_auxi = TIPO_ARQUEO_TARJETA) and (aTipoCliente <> '') then
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
                end;}

                  DoArqueoCajaXCajero(DateIni, DateFin, TipoPago, NumeroFacturas, NumeroNotasCredito, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, TotalIIBB, aTipoCliente);

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

procedure TFArqueoCajaExtXCajero.FormCreate(Sender: TObject);
begin
    bErrorCreando := False;

    if (not MyBD.InTransaction) then MyBD.StartTransaction(td);

    try
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

procedure TFArqueoCajaExtXCajero.FormDestroy(Sender: TObject);
begin
    QTTMPARQCAJAEXTEN.Close;

    try
        try
            if MyBD.InTransaction then MyBD.Rollback(td)// MyBD.Commit
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

function TFArqueoCajaExtXCajero.PutEstacion : string;
begin
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
    Result := NumeroEstacion + ' ' + NombreEstacion;
end;


function TFArqueoCajaExtXCajero.PutTipoPago(const aTP : string) : string;
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

procedure TFArqueoCajaExtXCajero.PutSumaryResults;
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
            sdslistCAJAEXTEN.SQLConnection := MyBD;
            CommandText := 'SELECT PTOVENTA, NUMFACTURA, TIPOCLIENTE, TO_CHAR(FECHALTA,''YYYY/DD/MM'') FO, ' +
                           'TO_CHAR(FECHALTA,''DD/MM/YY'') FECHALTA, TIPOFACTURA, NUMINFORME, ' +
                           'DOMINIO, TIPOPAGO, TIPOCLIENTE, NOMBRECLIENTE, IMPORTE, IVA, IVANOINSCRIPTO, ' +
                           'TOTAL, CONCEPTO, IIBB,IDPAGO,IDTURNO FROM TTMPARQCAJAEXTEN ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ';
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPARQCAJAEXTEN);
            {$ENDIF}

            Open;
        end
    finally
        Application.ProcessMessages;
    end;
end;


procedure TFArqueoCajaExtXCajero.PrintClick(Sender: TObject);
begin
    with TFDialogPrint.Create(Application) do
    try
       if ShowModal = mrOk
       then begin
            case Imprimir of
                tiGeneral:
                begin
                    with TFArqueoCajaExtendedToPrintxCajero.Create(Application) do
                    try
                       with tusuarios.CreateFromDataBase(mybd,DATOS_USUARIO,format('WHERE IDUSUARIO = %S',[aTipoCliente])) do
                       try
                          open;
                          QRLlbTitulo.caption := 'Arqueo de Caja - Cajero: '+ValueByName[FIELD_NOMBRE];
                          close;
                       finally
                          free
                       end;
                       Execute(DateIni, DateFin, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, NumeroFacturas, NumeroNotasCredito, PutTipoPago(TipoPago), NombreEstacion, NumeroEstacion, aTipoCliente, TotalIIBB);
                    finally
                        Free;
                    end;
                end;

               tiResumen:
               begin
                   with TFArqueoCajaSumaryxCajero.Create(Application) do
                   try


                      with tusuarios.CreateFromDataBase(mybd,DATOS_USUARIO,format('WHERE IDUSUARIO = %S',[aTipoCliente])) do
                        try
                           open;
                           qrltitulo.caption :='Resumen por Tipo de Cliente.  Cajero: '+ValueByName[FIELD_NOMBRE];
                           close;
                        finally
                           free
                        end;


                       Execute(DateIni, DateFin, PutTipoPago(TipoPago), aTipoCliente);
                   finally
                       Free;
                   end;
               end;

               else begin
                    with TFArqueoCajaExtendedToPrintxCajero.Create(Application) do
                    try
                       with tusuarios.CreateFromDataBase(mybd,DATOS_USUARIO,format('WHERE IDUSUARIO = %S',[aTipoCliente])) do
                       try
                          open;
                          QRLlbTitulo.caption := 'Arqueo de Caja - Cajero: '+ValueByName[FIELD_NOMBRE];
                          close;
                       finally
                          free
                       end;
                       Execute(DateIni, DateFin, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, NumeroFacturas, NumeroNotasCredito, PutTipoPago(TipoPago), NombreEstacion, NumeroEstacion, aTipoCliente, TotalIIBB);
                    finally
                        Free;
                    end;

                    with TFArqueoCajaSumaryxCajero.Create(Application) do
                    try
                      with tusuarios.CreateFromDataBase(mybd,DATOS_USUARIO,format('WHERE IDUSUARIO = %S',[aTipoCliente])) do
                        try
                           open;
                           qrltitulo.caption := 'Resumen por Tipo de Cliente.  Cajero: '+ValueByName[FIELD_NOMBRE];
                           close;
                        finally
                           free
                        end;

                       Execute(DateIni, DateFin, PutTipoPago(TipoPago), aTipoCliente);
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

procedure TFArqueoCajaExtXCajero.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            TotalImporte := '0'; TotalIva := '0';  TotalIvaNoInscripto := '0';
            Total := '0'; NumeroFacturas := '0'; NumeroNotasCredito := '0';

            If Not GetDates(DateIni,DateFin) Then Exit;
            If not PorTipo(TIPO_ARQUEO_CAJEROS, aTipoCliente,'','') then Exit;

            with tusuarios.CreateFromDataBase(mybd,DATOS_USUARIO,format('WHERE IDUSUARIO = %S',[aTipoCliente])) do
               try
                   open;
                   Caption := Format('Arqueo de Caja.  Cajero: '+ValueByName[FIELD_NOMBRE]+' - Planta: %S. (%S - %S) %S', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10), PutTipoPago(sTipo_Auxi)]);
                   close;
               finally
                   free
               end;

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

                  DoArqueoCajaXCajero(DateIni, DateFin, TipoPago, NumeroFacturas, NumeroNotasCredito, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, TotalIIBB, aTipoCliente);

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

procedure TFArqueoCajaExtXCajero.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure TFArqueoCajaExtXCajero.ResumenClick(Sender: TObject);
begin
    with TFSumaryCajaxCajero.Create(Application) do
    try
        Caption := Format('Resumen por Tipos de Cliente. Planta: %S. (%S - %S) %S', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10), PutTipoPago(TipoPago)]);
        ShowModal;
    finally
        Free;
    end;
end;

procedure TFArqueoCajaExtXCajero.AscciClick(Sender: TObject);
begin
    with TFAsciiDialog.Create(Application) do
    try
       if ShowModal = mrOk
       then begin
            case ExportarAscii of

                teaGeneral:
                begin
                    with TFArqueoCajaExtendedToPrintxCajero.Create(Application) do
                    try
                        ExportaAscii(DateIni, DateFin, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, NumeroFacturas, NumeroNotasCredito, PutTipoPago(TipoPago), NombreEstacion, NumeroEstacion, aTipoCliente, TotalIIBB);
                    finally
                        Free;
                    end;
                end;

               teaResumen:
               begin
                    with TFArqueoCajaSumaryxCajero.Create(Application) do
                    try
                       ExportaAscii(DateIni, DateFin, PutTipoPago(TipoPago), aTipoCliente);
                    finally
                       Free;
                    end;
               end;

               else begin

                    with TFArqueoCajaExtendedToPrintxCajero.Create(Application) do
                    try
                        ExportaAscii(DateIni, DateFin, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, NumeroFacturas, NumeroNotasCredito, PutTipoPago(TipoPago), NombreEstacion, NumeroEstacion, aTipoCliente, TotalIIBB);
                    finally
                        Free;
                    end;

                    with TFArqueoCajaSumaryxCajero.Create(Application) do
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

procedure TFArqueoCajaExtXCajero.ExcelClick(Sender: TObject);

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


procedure TFArqueoCajaExtXCajero.ExportacionExcelGeneral;
const
    F_TTL = 1;   C_TTL = 4;
    F_STT = 2;   C_STT = 4;
    F_TPG = 6;   C_TPG = 2;
    F_NFA = 8;   C_NFA = 2;
    F_NAB = 9;   C_NAB = 2;
    F_INI = 11;

    C_LTT = 9;
    C_TIM = 10;
    C_IVA = 11;
    C_IVN = 12;
    C_TIB = 13;
    C_TTO = 14;

var
    i,f : integer;
    fTiposCliente: TTiposCliente;
     ExcelApp, ExcelLibro, ExcelClient : Variant;
begin
    f:= F_INI;

   opendialog.Title := 'Seleccione la Planilla de Entrada';
   if OpenDialog.Execute then
      begin
      ExcelApp := CreateOleObject('Excel.Application');
      ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
      ExcelClient := ExcelLibro.Worksheets[1];
      with tusuarios.CreateFromDataBase(mybd,DATOS_USUARIO,format('WHERE IDUSUARIO = %S',[aTipoCliente])) do
         try
            open;
            ExcelClient.Cells[F_TTL,C_TTL].value:= 'Arqueo de Caja.  Cajero: '+ValueByName[FIELD_NOMBRE];
            close;
         finally
            free
         end;

      ExcelClient.Cells[F_STT,C_STT].value:=Format('Planta nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
      ExcelClient.Cells[F_TPG,C_TPG].value:=PutTipoPago(TipoPago);
      ExcelClient.Cells[F_NFA,C_NFA].value:=EdtTotalFacturas.Text;
      ExcelClient.Cells[F_NAB,C_NAB].value:=EdtTotalNotasCredito.Text;

      QTTMPARQCAJAEXTEN.First;
      while not QTTMPARQCAJAEXTEN.EOF do
      begin
          for i := 0 to DBGridArqueoCaja.Columns.Count - 1 do
            ExcelClient.Cells[f,i+1].value:=QTTMPARQCAJAEXTEN.FieldByName(DBGridArqueoCaja.Columns[i].FieldName).AsString;
          QTTMPARQCAJAEXTEN.Next;
          inc(f);
      end;
      QTTMPARQCAJAEXTEN.First;

      if f=F_INI
      then f := f + 1;

      ExcelClient.Cells[f,C_LTT].value:='TOTALES';
      ExcelClient.Cells[f,C_TIM].value:=EdtTotalImporte.Text;
      ExcelClient.Cells[f,C_IVA].value:=EdtTotalIVA.Text;
      ExcelClient.Cells[f,C_IVN].value:=EdtTotalIVANOInscripto.Text;
      ExcelClient.Cells[f,C_TIB].value:=EdtTotalTotal.Text;
      ExcelClient.Cells[f,C_TTO].value:=EdtTotalTotal.Text;

      opendialog.Title := 'Seleccione la Planilla de Salida';
      if OpenDialog.Execute then
         excellibro.saveas(opendialog.filename);
      ExcelApp.Quit;

    end;
end;

procedure TFArqueoCajaExtXCajero.ExportacionExcelResumen;
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
 ExcelApp, ExcelLibro, ExcelClient : Variant;
begin
    f:= F_INI;

      opendialog.Title := 'Seleccione la Planilla de Entrada';
   if OpenDialog.Execute then
      begin
      ExcelApp := CreateOleObject('Excel.Application');
      ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
      ExcelClient := ExcelLibro.Worksheets[1];

    with TFSumaryCajaxCajero.Create(Application) do
    try
        ExcelClient.Cells[F_STT,C_STT].value:=Format('Planta nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
        ExcelClient.Cells[F_TPG,C_TPG].value:=PutTipoPago(TipoPago);

        for i := 0 to SG.RowCount - 1 do
        begin
            ExcelClient.Cells[f,C_TPC].value:=SG.Cells[0,i];
            ExcelClient.Cells[f,C_NFA].value:=SG.Cells[1,i];
            ExcelClient.Cells[f,C_NAB].value:=SG.Cells[2,i];
            ExcelClient.Cells[f,C_IMP].value:=SG.Cells[3,i];
            ExcelClient.Cells[f,C_IVA].value:=SG.Cells[4,i];
            ExcelClient.Cells[f,C_IVN].value:=SG.Cells[5,i];
            ExcelClient.Cells[f,C_TOT].value:=SG.Cells[6,i];
            inc(f)
        end;
    finally
        Free;
    end;
     opendialog.Title := 'Seleccione la Planilla de Salida';
      if OpenDialog.Execute then
         excellibro.saveas(opendialog.filename);
      ExcelApp.Quit;

    end;
end;

procedure TFArqueoCajaExtXCajero.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TFArqueoCajaExtXCajero.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;



end.




