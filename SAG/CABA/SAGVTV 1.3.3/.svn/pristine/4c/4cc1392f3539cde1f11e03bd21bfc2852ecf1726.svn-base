unit ULISTADOCHEQUETOPRINT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls,  quickrpt, Qrctrls, qrexport, FMTBcd, DBClient,
  Provider, SqlExpr;

type
  TFListadoChequeToPrint = class(TForm)
    SD: TSaveDialog;
    sdslistcheques: TSQLDataSet;
    dspListCheques: TDataSetProvider;
    QTTMPLISTCHEQUES: TClientDataSet;
    QRImprimirCaja: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel13: TQRLabel;
    QRLblNumeroEstacion: TQRLabel;
    QRLblIntervaloFechas: TQRLabel;
    QRBand2: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel14: TQRLabel;
    QRBand3: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText12: TQRDBText;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRBand5: TQRBand;
    QRLabel15: TQRLabel;
    QRLblTotalFacturas: TQRLabel;
    QRLabel17: TQRLabel;
    QRLblTotalTotal: TQRLabel;
    QRLabel7: TQRLabel;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, sTipoPago, NombreEstacion, NumeroEstacion: string);
    procedure ExportaAscii(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, sTipoPago, NombreEstacion, NumeroEstacion: string);
  end;

var
  FListadoChequeToPrint: TFListadoChequeToPrint;

implementation

{$R *.DFM}

uses
   QREXTRA,
   QRPRNTR,
   ULOGS,
   GLOBALS,
   USAGESTACION;


const
    FICHERO_ACTUAL = 'UListadoChequeToPrint';

procedure TFListadoChequeToPrint.Execute(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, sTipoPago, NombreEstacion, NumeroEstacion: string);
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);
    QRLblTotalTotal.Caption := sTotalTotal;
    QRLblTotalFacturas.Caption := sNumFact;

    with QTTMPLISTCHEQUES do
    begin
        sdslistcheques.SQLConnection := MyBD;
        CommandText := 'SELECT NOMBANCO, NOMSUCURSAL, TO_CHAR(FECHPAGO,''DD/MM/YYYY'') FECHPAGO, TO_CHAR(FECHALTA,''DD/MM/YYYY'') FECHALTA, NUMEROCHEQUE, NOMBRETIT, MONEDA, IMPORTE, NUMFACTU FROM TTMPLISTCHEQUES ORDER BY NOMBANCO, NOMSUCURSAL, NUMEROCHEQUE ';
        {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTCHEQUES);
        {$ENDIF}
        Open
    end;
    QRImprimirCaja.PrinterSetup;
    QRImprimirCaja.Print;
end;



procedure TFListadoChequeToPrint.ExportaAscii(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, sTipoPago, NombreEstacion, NumeroEstacion: string);
var
    aExportFilter : TQRAsciiExportFilter;
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);
    QRLblTotalTotal.Caption := sTotalTotal;
    QRLblTotalFacturas.Caption := sNumFact;

    with QTTMPLISTCHEQUES do
    begin
        sdslistcheques.SQLConnection := MyBD;
        CommandText := 'SELECT NOMBANCO, NOMSUCURSAL, TO_CHAR(FECHPAGO,''DD/MM/YYYY'') FECHPAGO, TO_CHAR(FECHALTA,''DD/MM/YYYY'') FECHALTA, NUMEROCHEQUE, NOMBRETIT, MONEDA, IMPORTE, NUMFACTU FROM TTMPLISTCHEQUES ORDER BY NOMBANCO, NOMSUCURSAL, NUMEROCHEQUE ';
        {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTCHEQUES);
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


procedure TFListadoChequeToPrint.FormDestroy(Sender: TObject);
begin
    QTTMPLISTCHEQUES.Close;
end;






end.
