unit UARQUEOCAJAEXTENDEDTOPRINTXCAJERO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, quickrpt, Qrctrls,qrexport, FMTBcd,
  SqlExpr, Provider, DBClient;

type
  TFArqueoCajaExtendedToPrintxCajero = class(TForm)
    QRBand4: TQRBand;
    QRImprimirCaja: TQuickRep;
    QRSysData1: TQRSysData;
    SD: TSaveDialog;
    QRBand2: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLblInspeccion: TQRLabel;
    QRLbldominio: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLblpago: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel5: TQRLabel;
    QRBand5: TQRBand;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    QRDBText16: TQRDBText;
    QRDBTinspeccion: TQRDBText;
    QRDBText18: TQRDBText;
    QRDBText19: TQRDBText;
    QRDBTDominio: TQRDBText;
    QRDBText21: TQRDBText;
    QRDBText22: TQRDBText;
    QRDBTtipopago: TQRDBText;
    QRDBText24: TQRDBText;
    QRBand6: TQRBand;
    QRLblTotalIVANoInscripto: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLblTotalFacturas: TQRLabel;
    QRLblTotalNotasCredito: TQRLabel;
    QRLabel17: TQRLabel;
    QRLblTotalImporte: TQRLabel;
    QRLblTotalIVAInscripto: TQRLabel;
    QRLblTotalTotal: TQRLabel;
    qrlblTotalIIBB: TQRLabel;
    QTTMPARQCAJAEXTEN: TClientDataSet;
    dspListCAJAEXTEN: TDataSetProvider;
    sdslistCAJAEXTEN: TSQLDataSet;
    QRBand1: TQRBand;
    QRLlbTitulo: TQRLabel;
    QRLabel13: TQRLabel;
    QRLblNumeroEstacion: TQRLabel;
    QRLblTipoPago: TQRLabel;
    QRLblIntervaloFechas: TQRLabel;
    QRLabel4: TQRLabel;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, sTipoPago, NombreEstacion, NumeroEstacion, aTipoCliente, sTotalIIBB: string);
    procedure ExportaAscii(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, sTipoPago, NombreEstacion, NumeroEstacion, aTipoCliente,sTotalIIBB: string);
  end;

var
  FArqueoCajaExtendedToPrintxCajero: TFArqueoCajaExtendedToPrintxCajero;

implementation

{$R *.DFM}

uses
   QREXTRA,
   QRPRNTR,
   ULOGS,
   GLOBALS,
   USAGESTACION,
   USAGCLASSES;


const
    FICHERO_ACTUAL = 'UArqueoCajaExtendedToPrintxCajero';

procedure TFArqueoCajaExtendedToPrintxCajero.Execute(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, sTipoPago, NombreEstacion, NumeroEstacion, aTipoCliente,sTotalIIBB: string);
var fTiposCliente: TTiposCliente;
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);

    QRLblTipoPago.Caption := Format('TIPO DE PAGO: %S',[UpperCase(sTipoPago)]);

    if copy(sTipoPago,1,18) = S_FORMA_PAGO[tfpTarjeta] then
    begin
      if length(sTipoPago) > 19 then
      begin
         QRLblpago.Caption := 'Nº Tarjeta';
         QRLblInspeccion.Caption := 'Autorización';
         QRLblpago.left := 246;
         QRLblInspeccion.left := 364;
         QRLblDominio.left := 185;
         QRDBTDominio.left:= 185;
         QRDBTTipopago.Left:= 246;
         QRDBTInspeccion.left:= 364;
      end
      else
      begin
         QRLblpago.Caption := 'Tarjeta';
      end;
    end;
    QRLblTotalImporte.Caption := sTotalImporte;
    QRLblTotalIVAInscripto.Caption := sIVAIns;
    QRLblTotalIVANOInscripto.Caption := sIVANoIns;
    QRLblTotalTotal.Caption := sTotalTotal;
    QRLblTotalFacturas.Caption := sNumFact;
    QrLblTotalNotasCredito.Caption := sNumNotas;
    qrlblTotalIIBB.caption := sTotalIIBB;    

    if sTipoPago = 'Tipo Cliente' then
    begin
      QRLlbTitulo.caption:='Arqueo de Caja por Tipo de Cliente';
      fTiposCliente := TTiposCliente.CreateFromDatabase(MyBD,DATOS_TIPOS_DE_CLIENTE,FORMAT('WHERE TIPOCLIENTE_ID = ''%S''',[aTipoCliente]));
      fTiposCliente.open;
      QRLblTipoPago.caption:='TIPO DE CLIENTE: '+fTiposCliente.ValueByName[FIELD_DESCRIPCION];
      fTiposCliente.close;
      fTiposCliente.free;
    end;

    with QTTMPARQCAJAEXTEN do
    begin
        Close;
        sdslistCAJAEXTEN.SQLConnection := MyBD;
        CommandText :=  'SELECT PTOVENTA, NUMFACTURA, TIPOCLIENTE, TO_CHAR(FECHALTA,''YYYY/DD/MM'') FO, ' +
                    'TO_CHAR(FECHALTA,''DD/MM/YY'') FECHALTA, TIPOFACTURA, NUMINFORME, ' +
                    'DOMINIO, TIPOPAGO, TIPOCLIENTE, NOMBRECLIENTE, IMPORTE, IVA, IVANOINSCRIPTO, '+
                    'TOTAL, CONCEPTO, IIBB FROM TTMPARQCAJAEXTEN ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ';
        {$IFDEF TRAZAS}
          FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPARQCAJAEXTEN);
        {$ENDIF}
        Open
    end;
    QRImprimirCaja.PrinterSetup;
    QRImprimirCaja.Print;
end;



procedure TFArqueoCajaExtendedToPrintxCajero.ExportaAscii(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, sTipoPago, NombreEstacion, NumeroEstacion, aTipoCliente,sTotalIIBB: string);
var
    aExportFilter : TQRAsciiExportFilter;
    fTiposCliente: TTiposCliente;    
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);

    QRLblTipoPago.Caption := Format('TIPO DE PAGO: %S',[UpperCase(sTipoPago)]);

    QRLblTotalImporte.Caption := sTotalImporte;
    QRLblTotalIVAInscripto.Caption := sIVAIns;
    QRLblTotalIVANOInscripto.Caption := sIVANoIns;
    QRLblTotalTotal.Caption := sTotalTotal;
    QRLblTotalFacturas.Caption := sNumFact;
    QrLblTotalNotasCredito.Caption := sNumNotas;

    if sTipoPago = 'Tipo Cliente' then
    begin
      QRLlbTitulo.caption:='Arqueo de Caja por Tipo de Cliente';
      fTiposCliente := TTiposCliente.CreateFromDatabase(MyBD,DATOS_TIPOS_DE_CLIENTE,FORMAT('WHERE TIPOCLIENTE_ID = ''%S''',[aTipoCliente]));
      fTiposCliente.open;
      QRLblTipoPago.caption:='TIPO DE CLIENTE: '+fTiposCliente.ValueByName[FIELD_DESCRIPCION];
      fTiposCliente.close;
      fTiposCliente.free;
    end;


    with QTTMPARQCAJAEXTEN do
    begin
        Close;
        sdslistCAJAEXTEN.SQLConnection := MyBD;
        CommandText := 'SELECT PTOVENTA, NUMFACTURA, TIPOCLIENTE, TO_CHAR(FECHALTA,''YYYY/DD/MM'') FO, ' +
                       'TO_CHAR(FECHALTA,''DD/MM/YY'') FECHALTA, TIPOFACTURA, NUMINFORME, ' +
                       'DOMINIO, TIPOPAGO, TIPOCLIENTE, NOMBRECLIENTE, IMPORTE, IVA, IVANOINSCRIPTO, '+
                       'TOTAL, CONCEPTO, IIBB FROM TTMPARQCAJAEXTEN ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ';
        {$IFDEF TRAZAS}
          FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPARQCAJAEXTEN);
        {$ENDIF}
        Open
    end;

    if SD.Execute
    then begin
        aExportFilter := TQRAsciiExportFilter.Create(SD.FileName);
        try
            QRImprimirCaja.ExportToFilter(aExportFilter);
        finally
            aExportFilter.Free;
        end;
    end;
end;

procedure TFArqueoCajaExtendedToPrintxCajero.FormDestroy(Sender: TObject);
begin
    QTTMPARQCAJAEXTEN.Close;
end;






end.
