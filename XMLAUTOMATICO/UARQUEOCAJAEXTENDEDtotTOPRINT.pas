unit UARQUEOCAJAEXTENDEDTotToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, quickrpt, Qrctrls,qrexport;

type
  TFArqueoCajaExtendedTotToPrint = class(TForm)
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
    ChildBand1: TQRChildBand;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLblTotalFacturasVTV: TQRLabel;
    QRLblTotalNotasCreditoVTV: TQRLabel;
    QRLabel17: TQRLabel;
    QRLblTotalImporteVTV: TQRLabel;
    QRLblTotalIVAInscriptoVTV: TQRLabel;
    QRLblTotalIVANoInscriptoVTV: TQRLabel;
    QRLblTotalCDVTV: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLblTotalFacturasGNC: TQRLabel;
    QRLblTotalNotasCreditoGNC: TQRLabel;
    QRLblTotalImporteGNC: TQRLabel;
    QRLblTotalIVAInscriptoGNC: TQRLabel;
    QRLblTotalIVANoInscriptoGNC: TQRLabel;
    QRLblTotalCDGNC: TQRLabel;
    QRLblTotalFacturasTT: TQRLabel;
    QRLblTotalNotasCreditoTT: TQRLabel;
    QRLblTotalImporteTT: TQRLabel;
    QRLblTotalIVAInscriptoTT: TQRLabel;
    QRLblTotalIVANoInscriptoTT: TQRLabel;
    QRLblTotalCDTT: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRLblTotalIIBBVTV: TQRLabel;
    QRLblTotalTotalVTV: TQRLabel;
    QRLblTotalIIBBGNC: TQRLabel;
    QRLblTotalTotalGNC: TQRLabel;
    QRLblTotalIIBBTT: TQRLabel;
    QRLblTotalTotal: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(const cFechaIni, cFechaFin, sTotalImporteVTV, sIVAInsVTV, sIVANoInsVTV, sTotalCDVTV, sNumFact, sNumNotas, sTipoPago, NombreEstacion, NumeroEstacion, aTipoCliente,
          sTotalImporteGNC, sIVAInsGNC, sIVANoInsGNC, sTotalCDGNC, sNumFactGNC, sNumNotasGNC, sTotIBBVTV, sTotTotVTV, sTotIBBGNC, sTotTotGNC : string);
    procedure ExportaAscii(const cFechaIni, cFechaFin, sTotalImporteVTV, sIVAInsVTV, sIVANoInsVTV, sTotalCDVTV, sNumFact, sNumNotas, sTipoPago, NombreEstacion, NumeroEstacion, aTipoCliente,
          sTotalImporteGNC, sIVAInsGNC, sIVANoInsGNC, sTotalCDGNC, sNumFactGNC, sNumNotasGNC, sTotIBBVTV, sTotTotVTV, sTotIBBGNC, sTotTotGNC : string);
  end;

var
  FArqueoCajaExtendedTotToPrint: TFArqueoCajaExtendedTotToPrint;

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

procedure TFArqueoCajaExtendedTotToPrint.Execute(const cFechaIni, cFechaFin, sTotalImporteVTV, sIVAInsVTV, sIVANoInsVTV, sTotalCDVTV, sNumFact, sNumNotas, sTipoPago, NombreEstacion, NumeroEstacion, aTipoCliente,
          sTotalImporteGNC, sIVAInsGNC, sIVANoInsGNC, sTotalCDGNC, sNumFactGNC, sNumNotasGNC, sTotIBBVTV, sTotTotVTV, sTotIBBGNC, sTotTotGNC : string);
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);

    QRLblTipoPago.Caption := Format('TIPO DE PAGO: %S',[UpperCase(sTipoPago)]);

    QRLblTotalImporteVTV.Caption := sTotalImporteVTV;
    QRLblTotalIVAInscriptoVTV.Caption := sIVAInsVTV;
    QRLblTotalIVANOInscriptoVTV.Caption := sIVANoInsVTV;
    QRLblTotalCDVTV.Caption := sTotalCDVTV;
    QRLblTotalIIBBVTV.Caption := sTotIBBVTV;
    QRLblTotalTotalVTV.Caption := sTotTotVTV;
    QRLblTotalFacturasVTV.Caption := sNumFact;
    QrLblTotalNotasCreditoVTV.Caption := sNumNotas;

    QRLblTotalImporteGNC.Caption := sTotalImporteGNC;
    QRLblTotalIVAInscriptoGNC.Caption := sIVAInsGNC;
    QRLblTotalIVANOInscriptoGNC.Caption := sIVANoInsGNC;
    QRLblTotalCDGNC.Caption := sTotalCDGNC;
    QRLblTotalIIBBGNC.Caption := sTotIBBGNC;
    QRLblTotalTotalGNC.Caption := sTotTotGNC;
    QRLblTotalFacturasGNC.Caption := sNumFactGNC;
    QrLblTotalNotasCreditoGNC.Caption := sNumNotasGNC;

    QRLblTotalImporteTT.Caption := floattostrf(strtofloat(sTotalImporteVTV)+strtofloat(sTotalImporteGNC),fffixed,8,2);
    QRLblTotalIVAInscriptoTT.Caption := floattostrf(strtofloat(sIVAInsVTV)+strtofloat(sIVAInsGNC),fffixed,8,2);
    QRLblTotalIVANOInscriptoTT.Caption := floattostrf(strtofloat(sIVANoInsVTV)+strtofloat(sIVANoInsGNC),fffixed,8,2);
    QRLblTotalCDTT.Caption := floattostrf(strtofloat(sTotalCDVTV)+strtofloat(sTotalCDGNC),fffixed,8,2);
    QRLblTotalIIBBTT.Caption := floattostrf(strtofloat(sTotIBBVTV)+strtofloat(sTotIBBGNC),fffixed,8,2);
    QRLblTotalTotal.Caption := floattostrf(strtofloat(sTotTotVTV)+strtofloat(sTotTotGNC),fffixed,8,2);
    QRLblTotalFacturasTT.Caption := floattostrf(strtofloat(sNumFact)+strtofloat(sNumFactGNC),fffixed,8,0);
    QrLblTotalNotasCreditoTT.Caption := floattostrf(strtofloat(sNumNotas)+strtofloat(sNumNotasGNC),fffixed,8,0);

    QRImprimirCaja.PrinterSetup;
    QRImprimirCaja.Print;
end;



procedure TFArqueoCajaExtendedTotToPrint.ExportaAscii(const cFechaIni, cFechaFin, sTotalImporteVTV, sIVAInsVTV, sIVANoInsVTV, sTotalCDVTV, sNumFact, sNumNotas, sTipoPago, NombreEstacion, NumeroEstacion, aTipoCliente,
          sTotalImporteGNC, sIVAInsGNC, sIVANoInsGNC, sTotalCDGNC, sNumFactGNC, sNumNotasGNC, sTotIBBVTV, sTotTotVTV, sTotIBBGNC, sTotTotGNC : string);
var
    aExportFilter : TQRAsciiExportFilter;
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);

    QRLblTipoPago.Caption := Format('TIPO DE PAGO: %S',[UpperCase(sTipoPago)]);

    QRLblTotalImporteVTV.Caption := sTotalImporteVTV;
    QRLblTotalIVAInscriptoVTV.Caption := sIVAInsVTV;
    QRLblTotalIVANOInscriptoVTV.Caption := sIVANoInsVTV;
    QRLblTotalCDVTV.Caption := sTotalCDVTV;
    QRLblTotalIIBBVTV.Caption := sTotIBBVTV;
    QRLblTotalTotalVTV.Caption := sTotTotVTV;
    QRLblTotalFacturasVTV.Caption := sNumFact;
    QrLblTotalNotasCreditoVTV.Caption := sNumNotas;

    QRLblTotalImporteGNC.Caption := sTotalImporteGNC;
    QRLblTotalIVAInscriptoGNC.Caption := sIVAInsGNC;
    QRLblTotalIVANOInscriptoGNC.Caption := sIVANoInsGNC;
    QRLblTotalCDGNC.Caption := sTotalCDGNC;
    QRLblTotalIIBBGNC.Caption := sTotIBBGNC;
    QRLblTotalTotalGNC.Caption := sTotTotGNC;
    QRLblTotalFacturasGNC.Caption := sNumFactGNC;
    QrLblTotalNotasCreditoGNC.Caption := sNumNotasGNC;

    QRLblTotalImporteTT.Caption := floattostrf(strtofloat(sTotalImporteVTV)+strtofloat(sTotalImporteGNC),fffixed,8,2);
    QRLblTotalIVAInscriptoTT.Caption := floattostrf(strtofloat(sIVAInsVTV)+strtofloat(sIVAInsGNC),fffixed,8,2);
    QRLblTotalIVANOInscriptoTT.Caption := floattostrf(strtofloat(sIVANoInsVTV)+strtofloat(sIVANoInsGNC),fffixed,8,2);
    QRLblTotalCDTT.Caption := floattostrf(strtofloat(sTotalCDVTV)+strtofloat(sTotalCDGNC),fffixed,8,2);
    QRLblTotalIIBBTT.Caption := floattostrf(strtofloat(sTotIBBVTV)+strtofloat(sTotIBBGNC),fffixed,8,2);
    QRLblTotalTotal.Caption := floattostrf(strtofloat(sTotTotVTV)+strtofloat(sTotTotGNC),fffixed,8,2);
    QRLblTotalFacturasTT.Caption := floattostrf(strtofloat(sNumFact)+strtofloat(sNumFactGNC),fffixed,8,0);
    QrLblTotalNotasCreditoTT.Caption := floattostrf(strtofloat(sNumNotas)+strtofloat(sNumNotasGNC),fffixed,8,0);

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









end.
