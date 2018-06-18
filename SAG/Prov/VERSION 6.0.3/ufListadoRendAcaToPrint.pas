unit ufListadoRendAcaToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, quickrpt, Qrctrls, qrexport, FMTBcd, DBClient,
  Provider, SqlExpr;

type
  tFrmListadoRendAcaToPrint = class(TForm)
    SD: TSaveDialog;
    sdsTTMPARQCAJA: TSQLDataSet;
    DataSetProvider1: TDataSetProvider;
    QTTMPRENDICIONACA: TClientDataSet;
    QRImprimirCaja: TQuickRep;
    QRBand1: TQRBand;
    QRLlbTitulo: TQRLabel;
    QRLabel13: TQRLabel;
    QRLblNumeroEstacion: TQRLabel;
    QRLblIntervaloFechas: TQRLabel;
    QRLabel5: TQRLabel;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRBand5: TQRBand;
    QRShape2: TQRShape;
    QRLabel17: TQRLabel;
    QRLblTotalImporte: TQRLabel;
    QRLblTotalAca: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRShape23: TQRShape;
    QRBand2: TQRBand;
    QRLabel18: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel7: TQRLabel;
    QRShape14: TQRShape;
    QRShape13: TQRShape;
    QRShape12: TQRShape;
    QRShape11: TQRShape;
    QRShape10: TQRShape;
    QRShape9: TQRShape;
    QRBand3: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText4: TQRDBText;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;

    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(const cFechaIni, cFechaFin, sTotalImporte, sTotalAca, NombreEstacion, NumeroEstacion: string);
    procedure ExportaAscii(const cFechaIni, cFechaFin, sTotalImporte, sTotalAca, NombreEstacion, NumeroEstacion: string);
  end;

var
  FrmListadoRendAcaToPrint: tFrmListadoRendAcaToPrint;

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

procedure tFrmListadoRendAcaToPrint.Execute(const cFechaIni, cFechaFin, sTotalImporte, sTotalAca, NombreEstacion, NumeroEstacion: string);
begin

    QRLblNumeroEstacion.Caption := ' '+NumeroEstacion + ' - ' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format(' Desde: %s                    | Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);

    QRLblTotalImporte.Caption := floattostrf(strtofloat(sTotalImporte),fffixed,8,2);
    QRLblTotalAca.Caption := floattostrf(strtofloat(sTotalAca),fffixed,8,2);

    with QTTMPRENDICIONACA do
    begin
        Close;
        sdsTTMPARQCAJA.SQLConnection := MyBD;
        commandtext := 'SELECT TIPOFACTURA||'' ''||NUMFACTURA NUMFACTURA, TO_CHAR(FECHALTA,''DD/MM/YYYY'') FECHALTA,  NOMBRECLIENTE, TOTAL, TOTALACA, NROCUPON FROM TTMPRENDICIONACA ORDER BY FECHALTA, NUMFACTURA ';
        {$IFDEF TRAZAS}
          FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPRENDICIONACA);
        {$ENDIF}
        Open
    end;
    QRImprimirCaja.PrinterSetup;
    QRImprimirCaja.Print;
end;



procedure tFrmListadoRendAcaToPrint.ExportaAscii(const cFechaIni, cFechaFin, sTotalImporte, sTotalAca, NombreEstacion, NumeroEstacion: string);
var
    aExportFilter : TQRAsciiExportFilter;
begin

    QRLblNumeroEstacion.Caption := ' '+NumeroEstacion + ' - ' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format(' Desde: %s          |   Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);

    QRLblTotalImporte.Caption := floattostrf(strtofloat(sTotalImporte),fffixed,8,2);
    QRLblTotalAca.Caption := floattostrf(strtofloat(sTotalAca),fffixed,8,2);

    with QTTMPRENDICIONACA do
    begin
        Close;
        sdsTTMPARQCAJA.SQLConnection := MyBD;
        CommandText := 'SELECT TIPOFACTURA||'' ''||NUMFACTURA NUMFACTURA, TO_CHAR(FECHALTA,''DD/MM/YYYY'') FECHALTA,  NOMBRECLIENTE, TOTAL, TOTALACA, NROCUPON FROM TTMPRENDICIONACA ORDER BY FECHALTA, NUMFACTURA ';
        {$IFDEF TRAZAS}
        FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPRENDICIONACA);
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

procedure tFrmListadoRendAcaToPrint.FormDestroy(Sender: TObject);
begin
    QTTMPRENDICIONACA.Close;
end;























end.
