unit UListadoTotalTarjetasToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, SqlExpr, quickrpt, Qrctrls,qrexport,Provider, DBClient,
  FMTBcd;

type
  TFListadoTotalTarjetasToPrint = class(TForm)
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    QRImprimirCaja: TQuickRep;
    lblTitulo: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRSysData1: TQRSysData;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel13: TQRLabel;
    QRLblNumeroEstacion: TQRLabel;
    QRLblIntervaloFechas: TQRLabel;
    SD: TSaveDialog;
    QRDBText6: TQRDBText;
    QRLabel1: TQRLabel;
    QTTMPTOTALTARJETA: TClientDataSet;
    dspListTarjeta: TDataSetProvider;
    sdslistTarjeta: TSQLDataSet;
    QRLabel7: TQRLabel;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion: string);
    procedure ExportaAscii(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion: string);
  end;

var
  FListadoTotalTarjetasToPrint: TFListadoTotalTarjetasToPrint;

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

procedure TFListadoTotalTarjetasToPrint.Execute(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion: string);
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s - Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);

    with QTTMPTOTALTARJETA do
    begin
        Close;
        sdslistTarjeta.SQLConnection:=MyBD;
        CommandText := 'SELECT CODTARJETA, TARJETA, SUBTOTAL, IVACAJA, IVANOINSC, TOTALCAJA, IIBB FROM TTMPTOTALTARJETA ORDER BY CODTARJETA ';
        {$IFDEF TRAZAS}
        FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPTOTALTARJETA);
        {$ENDIF}
        Open
    end;
    QRImprimirCaja.PrinterSetup;
    QRImprimirCaja.Print;
end;



procedure TFListadoTotalTarjetasToPrint.ExportaAscii(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion: string);
var
    aExportFilter : TQRAsciiExportFilter;
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);

    with QTTMPTOTALTARJETA do
    begin
        Close;
        sdslisttarjeta.SQLConnection:=MyBD;
        CommandText :='SELECT CODTARJETA, TARJETA, SUBTOTAL, IVACAJA, IVANOINSC, TOTALCAJA, IIBB FROM TTMPTOTALTARJETA ORDER BY CODTARJETA ';
        {$IFDEF TRAZAS}
        FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPTOTALTARJETA);
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


procedure TFListadoTotalTarjetasToPrint.FormDestroy(Sender: TObject);
begin
    QTTMPTOTALTARJETA.Close;
end;



end.
