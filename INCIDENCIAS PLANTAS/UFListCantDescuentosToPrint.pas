unit UFListCantDescuentosToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, quickrpt, Qrctrls, FMTBcd, SqlExpr,
  Provider, DBClient, qrexport;

type
  TFrmListCantDescuentosToPrint = class(TForm)
    SD: TSaveDialog;
    QTTMPLISTCANTDESCUENTOS: TClientDataSet;
    dspQTTMPLISTCANTDESCUENTOS: TDataSetProvider;
    sdsQTTMPLISTCANTDESCUENTOS: TSQLDataSet;
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
    QRLabel6: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRBand3: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
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
  FrmListCantDescuentosToPrint: TFrmListCantDescuentosToPrint;

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

procedure TFrmListCantDescuentosToPrint.Execute(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion: string);
begin
    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);
    QRLlbTitulo.caption:='Listado Resumen de Descuentos';
        with QTTMPLISTCANTDESCUENTOS do
        begin
            Close;
            sdsQTTMPLISTCANTDESCUENTOS.SQLConnection := MyBD;
            CommandText := 'SELECT DESCUENTO, CANTNORM,IMPONORM,DIFNORM, CANTMAY20,IMPOMAY20,DIFMAY20, ' +
                    'CANTVTVIG, IMPOVTVIG,DIFVTVIG '+
                    'FROM TTMPRESDESCUENT ORDER BY CODDESCU ';
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTCANTDESCUENTOS);
            {$ENDIF}
            Open;
        end;
    QRImprimirCaja.PrinterSetup;
    QRImprimirCaja.Print;
end;



procedure TFrmListCantDescuentosToPrint.ExportaAscii(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion: string);
var
    aExportFilter : TQRAsciiExportFilter;
begin
    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);
    QRLlbTitulo.caption:='Listado Resumen de Descuentos';
        with QTTMPLISTCANTDESCUENTOS do
        begin
            Close;
            sdsQTTMPLISTCANTDESCUENTOS.SQLConnection := MyBD;
            CommandText := 'SELECT DESCUENTO, CANTNORM,IMPONORM,DIFNORM, CANTMAY20,IMPOMAY20,DIFMAY20, ' +
                    'CANTVTVIG, IMPOVTVIG,DIFVTVIG '+
                    'FROM TTMPRESDESCUENT ORDER BY CODDESCU ';
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

procedure TFrmListCantDescuentosToPrint.FormDestroy(Sender: TObject);
begin
    QTTMPLISTCANTDESCUENTOS.Close;
end;







end.
