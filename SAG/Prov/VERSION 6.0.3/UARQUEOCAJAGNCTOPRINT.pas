unit UARQUEOCAJAGNCTOPRINT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls,  quickrpt, Qrctrls,qrexport, FMTBcd,
  DBClient, Provider, SqlExpr;

type
  TFArqueoCajaGNCToPrint = class(TForm)
    SD: TSaveDialog;
    sdsTTMPARQCAJA: TSQLDataSet;
    DataSetProvider1: TDataSetProvider;
    QTTMPARQCAJAEXTEN: TClientDataSet;
    QRImprimirCaja: TQuickRep;
    QRBand1: TQRBand;
    QRLlbTitulo: TQRLabel;
    QRLabel13: TQRLabel;
    QRLblNumeroEstacion: TQRLabel;
    QRLblTipoPago: TQRLabel;
    QRLblIntervaloFechas: TQRLabel;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
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
    QRBand3: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBTinspeccion: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBTDominio: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBTtipopago: TQRDBText;
    QRDBText4: TQRDBText;
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
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, sTipoPago, NombreEstacion, NumeroEstacion, aTipoCliente, sTotalIIBB: string);
    procedure ExportaAscii(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, sTipoPago, NombreEstacion, NumeroEstacion, aTipoCliente, sTotalIIBB: string);
  end;

var
  FArqueoCajaGNCToPrint: TFArqueoCajaGNCToPrint;

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
    FICHERO_ACTUAL = 'UArqueoCajaGNCToPrint';

procedure TFArqueoCajaGNCToPrint.Execute(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, sTipoPago, NombreEstacion, NumeroEstacion, aTipoCliente, sTotalIIBB: string);
var fTiposCliente: TTiposCliente;
    fSQL : tStringList;
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
    qrlblTotalIIBB.caption := sTotalIIBB;
    QRLblTotalFacturas.Caption := sNumFact;
    QrLblTotalNotasCredito.Caption := sNumNotas;

    if sTipoPago = 'Tipo Cliente' then
    begin
      QRLlbTitulo.caption:='Arqueo de Caja GNC por Tipo de Cliente';
      fTiposCliente := TTiposCliente.CreateFromDatabase(MyBD,DATOS_TIPOS_DE_CLIENTE,FORMAT('WHERE TIPOCLIENTE_ID = ''%S''',[aTipoCliente]));
      fTiposCliente.open;
      QRLblTipoPago.caption:='TIPO DE CLIENTE: '+fTiposCliente.ValueByName[FIELD_DESCRIPCION];
      fTiposCliente.close;
      fTiposCliente.free;
    end;

    with QTTMPARQCAJAEXTEN do
    begin
        sdsTTMPARQCAJA.SQLConnection := MyBD;
        fSQL := TStringList.Create;

        fSQL.Add('SELECT PTOVENTA, NUMFACTURA, TO_CHAR(FECHALTA,''YYYY/DD/MM'') FO, ' +
                    'TO_CHAR(FECHALTA,''DD/MM/YY'') FECHALTA, TIPOFACTURA, NUMINFORME, ' +
                    'DOMINIO, TIPOPAGO, NOMBRECLIENTE, IMPORTE, IVA, IVANOINSCRIPTO, ');
        if sTipoPago <> 'Tipo Cliente' then
            fsql.add('TOTAL, CONCEPTO, IIBB FROM TTMPARQCAJAEXTENCAJGNC ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ')
        else
            fsql.add('TOTAL, CONCEPTO, IIBB FROM TTMPARQCAJAEXTENCAJGNC ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ');
        CommandText := fSQL.Text;
        {$IFDEF TRAZAS}
          FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPARQCAJAEXTEN);
        {$ENDIF}
        Open
    end;
    QRImprimirCaja.PrinterSetup;
    QRImprimirCaja.Print;
end;


procedure TFArqueoCajaGNCToPrint.ExportaAscii(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, sTipoPago, NombreEstacion, NumeroEstacion, aTipoCliente, sTotalIIBB: string);
var
    aExportFilter : TQRAsciiExportFilter;
    fTiposCliente: TTiposCliente;
    fSQL : tStringList;
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
    qrlblTotalIIBB.caption := sTotalIIBB;

    if sTipoPago = 'Tipo Cliente' then
    begin
      QRLlbTitulo.caption:='Arqueo de Caja GNC por Tipo de Cliente';
      fTiposCliente := TTiposCliente.CreateFromDatabase(MyBD,DATOS_TIPOS_DE_CLIENTE,FORMAT('WHERE TIPOCLIENTE_ID = ''%S''',[aTipoCliente]));
      fTiposCliente.open;
      QRLblTipoPago.caption:='TIPO DE CLIENTE: '+fTiposCliente.ValueByName[FIELD_DESCRIPCION];
      fTiposCliente.close;
      fTiposCliente.free;
    end;


    with QTTMPARQCAJAEXTEN do
    begin
        Close;
        sdsTTMPARQCAJA.SQLConnection := MyBD;
        fSQL := TStringList.Create;
        fSQL.Add('SELECT PTOVENTA, NUMFACTURA, TO_CHAR(FECHALTA,''YYYY/DD/MM'') FO, ' +
                    'TO_CHAR(FECHALTA,''DD/MM/YY'') FECHALTA, TIPOFACTURA, NUMINFORME, ' +
                    'DOMINIO, TIPOPAGO, NOMBRECLIENTE, IMPORTE, IVA, IVANOINSCRIPTO, ');
        if sTipoPago <> 'Tipo Cliente' then
            fsql.add('TOTAL, CONCEPTO, IIBB FROM TTMPARQCAJAEXTENCAJ ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ')
        else
            fsql.add('TOTAL, CONCEPTO, IIBB FROM TTMPARQCAJAEXTENCAJGNC ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ');
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

procedure TFArqueoCajaGNCToPrint.FormDestroy(Sender: TObject);
begin
    QTTMPARQCAJAEXTEN.Close;
end;

end.
