unit UFListadoDescuentosToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, quickrpt, Qrctrls, qrexport, FMTBcd,
  SqlExpr, Provider, DBClient;

type
  TFListadoFacXDescuentosToPrint = class(TForm)
    SD: TSaveDialog;
    QTTMPARQCAJAEXTEN: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    sdsTTMPARQCAJA: TSQLDataSet;
    QRImprimirCaja: TQuickRep;
    QRBand1: TQRBand;
    QRLlbTitulo: TQRLabel;
    QRLabel13: TQRLabel;
    QRLblNumeroEstacion: TQRLabel;
    QRLblTipoPago: TQRLabel;
    QRLblIntervaloFechas: TQRLabel;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRBand5: TQRBand;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLblTotalFacturas: TQRLabel;
    QRLblTotalNotasCredito: TQRLabel;
    QRLabel17: TQRLabel;
    QRLblTotalImporte: TQRLabel;
    QRLblTotalIVAInscripto: TQRLabel;
    QRLblTotalTotal: TQRLabel;
    QRLblTotalIVANoInscripto: TQRLabel;
    qrlTotalIIBB: TQRLabel;
    QRBand2: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel4: TQRLabel;
    QRBand3: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText13: TQRDBText;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, NombreEstacion, NumeroEstacion, aCodDescu, sTotalIIBB: string);
    procedure ExportaAscii(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, NombreEstacion, NumeroEstacion, aCodDescu, sTotalIIBB: string);
  end;

var
  FListadoFacXDescuentosToPrint: TFListadoFacXDescuentosToPrint;

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

procedure TFListadoFacXDescuentosToPrint.Execute(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, NombreEstacion, NumeroEstacion, aCodDescu, sTotalIIBB: string);
var fDescuentos: TDescuento;
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);

    QRLblTotalImporte.Caption := sTotalImporte;
    QRLblTotalIVAInscripto.Caption := sIVAIns;
    QRLblTotalIVANOInscripto.Caption := sIVANoIns;
    QRLblTotalTotal.Caption := sTotalTotal;
    QRLblTotalFacturas.Caption := sNumFact;
    QrLblTotalNotasCredito.Caption := sNumNotas;
    qrlTotalIIBB.Caption := sTotalIIBB;

    QRLlbTitulo.caption:='Arqueo de Caja de Facturas con Descuento';
    fDescuentos := TDescuento.CreateFromCoddescu(MyBD,aCodDescu);
    fDescuentos.open;
    QRLblTipoPago.caption:='TIPO DE DESCUENTO: '+fDescuentos.ValueByName[FIELD_CONCEPTO];
    fDescuentos.close;
    fDescuentos.free;

    with QTTMPARQCAJAEXTEN do
    begin
        Close;
        sdsTTMPARQCAJA.sqlconnection := MyBD;
        commandtext := 'SELECT PTOVENTA, NUMFACTURA, TIPOCLIENTE, TO_CHAR(FECHALTA,''YYYY/DD/MM'') FO, ' +
                    'TO_CHAR(FECHALTA,''DD/MM/YY'') FECHALTA, TIPOFACTURA, NUMINFORME, ' +
                    'DOMINIO, TIPOPAGO, TIPOCLIENTE, NOMBRECLIENTE, IMPORTE, IVA, IVANOINSCRIPTO, ' +
                    'TOTAL, CONCDESC, NROCUPON, IIBB FROM TTMPARQCAJAEXTENDESC ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ';
        {$IFDEF TRAZAS}
          FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPARQCAJAEXTEN);
        {$ENDIF}
        Open
    end;
    QRImprimirCaja.PrinterSetup;
    QRImprimirCaja.Print;
end;



procedure TFListadoFacXDescuentosToPrint.ExportaAscii(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, NombreEstacion, NumeroEstacion, aCodDescu, sTotalIIBB: string);
var
    aExportFilter : TQRAsciiExportFilter;
    fDescuentos: TDescuento;
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);

    QRLblTotalImporte.Caption := sTotalImporte;
    QRLblTotalIVAInscripto.Caption := sIVAIns;
    QRLblTotalIVANOInscripto.Caption := sIVANoIns;
    QRLblTotalTotal.Caption := sTotalTotal;
    QRLblTotalFacturas.Caption := sNumFact;
    QrLblTotalNotasCredito.Caption := sNumNotas;

    QRLlbTitulo.caption:='Arqueo de Caja de Facturas con Descuento';
    fDescuentos := TDescuento.CreateFromCoddescu(MyBD,aCodDescu);
    fDescuentos.open;
    QRLblTipoPago.caption:='TIPO DE DESCUENTO: '+fDescuentos.ValueByName[FIELD_CONCEPTO];
    fDescuentos.close;
    fDescuentos.free;

    with QTTMPARQCAJAEXTEN do
    begin
        Close;
        sdsTTMPARQCAJA.SQLConnection := MyBD;
        CommandText := 'SELECT PTOVENTA, NUMFACTURA, TIPOCLIENTE, TO_CHAR(FECHALTA,''YYYY/DD/MM'') FO, ' +
                    'TO_CHAR(FECHALTA,''DD/MM/YY'') FECHALTA, TIPOFACTURA, NUMINFORME, ' +
                    'DOMINIO, TIPOPAGO, TIPOCLIENTE, NOMBRECLIENTE, IMPORTE, IVA, IVANOINSCRIPTO, ' +
                    'TOTAL, CONCDESC, NROCUPON, IIBB FROM TTMPARQCAJAEXTENDESC ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ';
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

procedure TFListadoFacXDescuentosToPrint.FormDestroy(Sender: TObject);
begin
    QTTMPARQCAJAEXTEN.Close;
end;

end.
