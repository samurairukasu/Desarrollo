unit UListadoCambioFechaToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, SQLExpr, quickrpt, Qrctrls,qrexport,Provider, DBClient, FMTBcd;

type
  TFListadoCambioFechaToPrint = class(TForm)                                      
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    QRImprimirCaja: TQuickRep;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRSysData1: TQRSysData;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRBand5: TQRBand;
    QRDBText2: TQRDBText;
    QRLabel13: TQRLabel;
    QRLblNumeroEstacion: TQRLabel;
    QRLblIntervaloFechas: TQRLabel;
    QRLabel14: TQRLabel;
    QRDBText12: TQRDBText;
    SD: TSaveDialog;
    QTTMPLISTCAMBIO: TClientDataSet;
    dspListCambio: TDataSetProvider;
    sdslistCambio: TSQLDataSet;
    QRLabel8: TQRLabel;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion: string);
    procedure ExportaAscii(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion: string);
  end;

var
  FListadoCambioFechaToPrint: TFListadoCambioFechaToPrint;

implementation

{$R *.DFM}

uses
   QREXTRA,
   QRPRNTR,
   ULOGS,
   GLOBALS,
   USAGESTACION;


const
    FICHERO_ACTUAL = 'UListadoCambioFechaToPrint';

procedure TFListadoCambioFechaToPrint.Execute(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion: string);
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);

    with QTTMPLISTCAMBIO do
    begin
        Close;
        sdslistcambio.SQLConnection:=MyBD;
        CommandText:='SELECT TO_CHAR(FECHALTA,''DD/MM/YYYY'') FECHALTA, NUMINFORME,DOMINIO,TO_CHAR(FECHA_VENC_OLD,''DD/MM/YYYY'') FECHA_VENC_OLD,TO_CHAR(FECHA_VENC_NEW,''DD/MM/YYYY'') FECHA_VENC_NEW,DESCMOTIVO,NRONOTA,USUARIO FROM  TTMPLISTCAMBIO ORDER BY FECHALTA, NRONOTA ';
        {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTCAMBIO);
        {$ENDIF}
        Open
    end;
    QRImprimirCaja.PrinterSetup;
    QRImprimirCaja.Print;
end;



procedure TFListadoCambioFechaToPrint.ExportaAscii(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion: string);
var
    aExportFilter : TQRAsciiExportFilter;
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);

    with QTTMPLISTCAMBIO do
    begin
        Close;
        sdslistcambio.SQLConnection:=MyBD;
        CommandText :='SELECT TO_CHAR(FECHALTA,''DD/MM/YYYY'') FECHALTA, NUMINFORME,DOMINIO,TO_CHAR(FECHA_VENC_OLD,''DD/MM/YYYY'') FECHA_VENC_OLD,TO_CHAR(FECHA_VENC_NEW,''DD/MM/YYYY'') FECHA_VENC_NEW,DESCMOTIVO,NRONOTA,USUARIO FROM  TTMPLISTCAMBIO ORDER BY FECHALTA, NRONOTA ';
        {$IFDEF TRAZAS}
        FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTCAMBIO);
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


procedure TFListadoCambioFechaToPrint.FormDestroy(Sender: TObject);
begin
    QTTMPLISTCAMBIO.Close;
end;

end.
