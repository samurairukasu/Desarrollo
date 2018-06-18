unit UARQUEOCAJAEXTENDEDTOPRINT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, quickrpt, Qrctrls, qrexport, FMTBcd,
  SqlExpr, DBClient, Provider, DB;

type
  TFArqueoCajaExtendedToPrint = class(TForm)
    QRBand1: TQRBand;
    QRBand4: TQRBand;
    QRImprimirCaja: TQuickRep;
    QRLlbTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel13: TQRLabel;
    QRLblNumeroEstacion: TQRLabel;
    QRLblTipoPago: TQRLabel;
    QRLblIntervaloFechas: TQRLabel;
    SD: TSaveDialog;
    QRBand5: TQRBand;
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
    QRBand3: TQRBand;
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
    sdsTTMPARQCAJA: TSQLDataSet;
    DataSetProvider1: TDataSetProvider;
    QTTMPARQCAJAEXTEN: TClientDataSet;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRDBTInspeccion: TQRExpr;
    QRDBTDominio: TQRExpr;
    QRDBTTipopago: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    QRExpr12: TQRExpr;
    QRExpr13: TQRExpr;
    QRExpr14: TQRExpr;
    QRLabel4: TQRLabel;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, sTipoPago, NombreEstacion, NumeroEstacion, aTipoCliente, sTotalIIBB,sTotalIIBB_CABA: string);
    procedure ExportaAscii(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, sTipoPago, NombreEstacion, NumeroEstacion, aTipoCliente, sTotalIIBB,sTotalIIBB_CABA: string);
  end;

var
  FArqueoCajaExtendedToPrint: TFArqueoCajaExtendedToPrint;

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
    FICHERO_ACTUAL = 'UArqueoCajaExtendedToPrint';

procedure TFArqueoCajaExtendedToPrint.Execute(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, sTipoPago, NombreEstacion, NumeroEstacion, aTipoCliente, sTotalIIBB,sTotalIIBB_CABA: string);
var fTiposCliente: TTiposCliente;
    fSQL : tStringList;
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + ' - ' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s - Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);

    QRLblTipoPago.Caption := Format('Tipo de pago: %S',[UpperCase(sTipoPago)]);

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
      QRLblTipoPago.caption:='Tipo de cliente: '+fTiposCliente.ValueByName[FIELD_DESCRIPCION];
      fTiposCliente.close;
      fTiposCliente.free;
    end;

    with QTTMPARQCAJAEXTEN do
    begin
        Close;
        sdsTTMPARQCAJA.SQLConnection := MyBD;
        fSQL := TStringList.Create;
        fSQL.Add('SELECT PTOVENTA, NUMFACTURA, TIPOCLIENTE, TO_CHAR(FECHALTA,''YYYY/MM/DD'') FO, ' +
                    'TO_CHAR(FECHALTA,''DD/MM/YY'') FECHALTA, TIPOFACTURA, NUMINFORME, ' +
                    'DOMINIO, TIPOPAGO, TIPOCLIENTE, NOMBRECLIENTE, IMPORTE, IVA, IVANOINSCRIPTO, ');
        if sTipoPago <> 'Tipo Cliente' then
            fsql.add('TOTAL, CONCEPTO, IIBB FROM TTMPARQCAJAEXTENCAJ ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ')
        else
            fsql.add('TOTAL, CONCEPTO, IIBB FROM TTMPARQCAJAEXTEN ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ');
        CommandText := fSQL.text;
        {$IFDEF TRAZAS}
          FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPARQCAJAEXTEN);
        {$ENDIF}

        Open
    end;
    QRImprimirCaja.PrinterSetup;
    QRImprimirCaja.print;
end;



procedure TFArqueoCajaExtendedToPrint.ExportaAscii(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, sTipoPago, NombreEstacion, NumeroEstacion, aTipoCliente, sTotalIIBB,sTotalIIBB_CABA: string);
var
    aExportFilter : TQRAsciiExportFilter;
    fTiposCliente: TTiposCliente;
    fSQL : tStringList;    
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + ' - ' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s - Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);

    QRLblTipoPago.Caption := Format('Tipo de pago: %S',[UpperCase(sTipoPago)]);

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
      QRLblTipoPago.caption:='Tipo de cliente: '+fTiposCliente.ValueByName[FIELD_DESCRIPCION];
      fTiposCliente.close;
      fTiposCliente.free;
    end;


    with QTTMPARQCAJAEXTEN do
    begin
        Close;
        sdsTTMPARQCAJA.SQLConnection := MyBD;
        fSQL := TStringList.Create;
        fSQL.Add('SELECT PTOVENTA, NUMFACTURA, TIPOCLIENTE, TO_CHAR(FECHALTA,''YYYY/MM/DD'') FO, ' +
                    'TO_CHAR(FECHALTA,''DD/MM/YY'') FECHALTA, TIPOFACTURA, NUMINFORME, ' +
                    'DOMINIO, TIPOPAGO, TIPOCLIENTE, NOMBRECLIENTE, IMPORTE, IVA, IVANOINSCRIPTO, ');
        if sTipoPago <> 'Tipo Cliente' then
            fsql.add('TOTAL, CONCEPTO, IIBB FROM TTMPARQCAJAEXTENCAJ ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ')
        else
            fsql.add('TOTAL, CONCEPTO, IIBB FROM TTMPARQCAJAEXTEN ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ');
        CommandText := fSQL.text;
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

procedure TFArqueoCajaExtendedToPrint.FormDestroy(Sender: TObject);
begin
    QTTMPARQCAJAEXTEN.Close;
end;

end.
