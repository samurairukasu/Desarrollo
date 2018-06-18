unit UFResumenDescuentosToPrintGNC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, quickrpt, Qrctrls,qrexport, FMTBcd, DBClient,
  Provider, SqlExpr;

type
  TFrmResumenDescuentosToPrintGNC = class(TForm)
    SD: TSaveDialog;
    sdsQTTMPLISTCANTDESCUENTOS: TSQLDataSet;
    dspQTTMPLISTCANTDESCUENTOS: TDataSetProvider;
    QTTMPLISTCANTDESCUENTOS: TClientDataSet;
    QRImprimirCaja: TQuickRep;
    QRBand1: TQRBand;
    QRLlbTitulo: TQRLabel;
    QRLabel13: TQRLabel;
    QRLblNumeroEstacion: TQRLabel;
    QRLblIntervaloFechas: TQRLabel;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRBand2: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRBand3: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel9: TQRLabel;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion: string);
    procedure ExportaAscii(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion: string);
  end;

var
  FrmResumenDescuentosToPrintGNC: TFrmResumenDescuentosToPrintGNC;

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
    FICHERO_ACTUAL = 'UFResumenDescuentosToPrintGNC';

procedure TFrmResumenDescuentosToPrintGNC.Execute(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion: string);
begin
    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s - Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);
    QRLlbTitulo.caption:='Listado Resumen de Descuentos GNC';
        with QTTMPLISTCANTDESCUENTOS do
        begin
            Close;
            sdsQTTMPLISTCANTDESCUENTOS.SQLConnection := MyBD;
            CommandText := 'SELECT DESCUENTO, CANTIDAD,IMPORTES FROM TTMPRESDESCUENTGNC ORDER BY CODDESCU ';
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTCANTDESCUENTOS);
            {$ENDIF}
            Open;
        end;
    QRImprimirCaja.PrinterSetup;
    QRImprimirCaja.Print;
end;



procedure TFrmResumenDescuentosToPrintGNC.ExportaAscii(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion: string);
var
    aExportFilter : TQRAsciiExportFilter;
begin
    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);
    QRLlbTitulo.caption:='Listado Resumen de Descuentos GNC';
        with QTTMPLISTCANTDESCUENTOS do
        begin
            Close;
            sdsQTTMPLISTCANTDESCUENTOS.SQLConnection := MyBD;
            CommandText := 'SELECT DESCUENTO, CANTIDAD,IMPORTES FROM TTMPRESDESCUENTGNC ORDER BY CODDESCU ';
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTCANTDESCUENTOS);
            {$ENDIF}
            Open;
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

procedure TFrmResumenDescuentosToPrintGNC.FormDestroy(Sender: TObject);
begin
    QTTMPLISTCANTDESCUENTOS.Close;
end;



end.
