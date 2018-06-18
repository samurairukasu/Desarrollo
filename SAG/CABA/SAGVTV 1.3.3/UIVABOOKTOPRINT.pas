unit UIVABookToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, ExtCtrls, StdCtrls, SqlExpr, quickrpt, Qrctrls, FMTBcd, DBClient,
  Provider;

type
  TFIVABookToPrint = class(TForm)
    sdsQTTMPIVABOOK: TSQLDataSet;
    dspQTTMPIVABOOK: TDataSetProvider;
    QTTMPIVABOOK: TClientDataSet;
    QRLibroIVA: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLblIntervaloFechas: TQRLabel;
    QRLblNumeroEstacion: TQRLabel;
    QRLabel13: TQRLabel;
    QRLblNombreEstacion: TQRLabel;
    QRBand2: TQRBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRBand3: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText9: TQRDBText;
    QRBand4: TQRBand;
    QRLabel16: TQRLabel;
    QRLblTotalFacturasA: TQRLabel;
    QRLblTotalFacturasB: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel2: TQRLabel;
    QRLblTotalNCredito: TQRLabel;
    QRLabel17: TQRLabel;
    QRLblImporteNeto: TQRLabel;
    QRLblCantidadGravada: TQRLabel;
    QRLblTotalTotal: TQRLabel;
    QRLTotalIIBB: TQRLabel;
    QRBand5: TQRBand;
    QRLabel15: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    procedure Execute(const cFechaIni, cFechaFin, cImp, cIva, cTotal, cFAs, cFBs, cNcs, NombreEstacion, NumeroEstacion, cTotalIIBB: string);
    procedure FormDestroy(Sender: TObject);
  public

  end;

var
  FIVABookToPrint: TFIVABookToPrint;

implementation

{$R *.DFM}
uses
    GLOBALS,
    ULOGS;

const
    FICHERO_ACTUAL = 'UIVABookToPrint.pas';

procedure TFIVABookToPrint.Execute(const cFechaIni, cFechaFin, cImp, cIva, cTotal, cFAs, cFBs, cNcs, NombreEstacion, NumeroEstacion, cTotalIIBB: string);
begin
    QRLblNumeroEstacion.Caption := NumeroEstacion;
    QRLblNombreEstacion.Caption := NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('(%s-%s)',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);

    QRLblTotalFacturasA.Caption := cFAs;
    QRLblTotalFacturasB.Caption := cFBs;
    QRLblTotalNCredito.Caption := cNCs;
    QRLblImporteNeto.Caption := cImp;
    QRLblCantidadGravada.Caption := cIva;
    QRLblTotalTotal.Caption := cTotal;
    QRLTotalIIBB.Caption := cTotalIIBB;

    with QTTMPIVABOOK do
    begin
        Close;
        sdsQTTMPIVABOOK.SQLConnection := MyBD;
        CommandText := 'SELECT FECHALTA FO, NFACTURA#, CONCEPTO, NOMBRE, TO_CHAR(FECHALTA,''DD/MM/YY'') FECHALTA, IMPONETO, IVA, PORIVA, TOTAL, CUIT_CLI, IIBB FROM TTMPBOOKIVA ORDER BY FO, NFACTURA#';
        {$IFDEF TRAZAS}
          FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPIVABOOK);
        {$ENDIF}
        Open
    end;
  //  QRLibroIva.PrinterSetup;
  //  QRLibroIva.Print
   QRLibroIva.Preview;
end;

procedure TFIVABookToPrint.FormDestroy(Sender: TObject);
begin
    QTTMPIVABOOK.Close;
end;




end.
