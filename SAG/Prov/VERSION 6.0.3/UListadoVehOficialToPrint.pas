unit UListadoVehOficialToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, quickrpt, Qrctrls,qrexport, FMTBcd, DBClient,
  Provider, SqlExpr;

type
  TFListadoVehOficialToPrint = class(TForm)
    SD: TSaveDialog;
    sdsQTTMPVehOficial: TSQLDataSet;
    dspQTTMPVehOficial: TDataSetProvider;
    QTTMPVehOficial: TClientDataSet;
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
    procedure Execute(const cFechaIni, cFechaFin, sTotalTotal, sNumFact, NombreEstacion, NumeroEstacion: string);
    procedure ExportaAscii(const cFechaIni, cFechaFin, sTotalTotal, sNumFact, NombreEstacion, NumeroEstacion: string);
  end;

var
  FListadoVehOficialToPrint: TFListadoVehOficialToPrint;

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

procedure TFListadoVehOficialToPrint.Execute(const cFechaIni, cFechaFin, sTotalTotal, sNumFact, NombreEstacion, NumeroEstacion: string);
var
 fSQL : tstringlist;
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);
    QRLblTotalTotal.Caption := sTotalTotal;
    QRLblTotalFacturas.Caption := sNumFact;
    fSQL := TStringList.Create;
    with QTTMPVehOficial do
    begin
        Close;
        sdsQTTMPVehOficial.SQLConnection := MyBD;
        fSQL.Clear;
        fSQL.Add('SELECT TIPOFACTURA, NUMFACTURA, TO_CHAR(FECHALTA,''DD/MM/YYYY'') FECHALTA, SOLICREG, ');
        fsql.add('NUMINFORME, DOMINIO, MARCAMODELO, TIPOPAGO, NOMBRECLIENTE, TOTAL, TO_CHAR(FECHALTA,''YYYY/MM/DD'') FO ');
        fsql.add('FROM TTMPLISTPUBLICO ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ');
        CommandText := fSQL.Text;
        {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPVehOficial);
        {$ENDIF}
        Open
    end;
    QRImprimirCaja.PrinterSetup;
    QRImprimirCaja.Print;
end;



procedure TFListadoVehOficialToPrint.ExportaAscii(const cFechaIni, cFechaFin, sTotalTotal, sNumFact, NombreEstacion, NumeroEstacion: string);
var
    aExportFilter : TQRAsciiExportFilter;
    fSQL : tstringlist;
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);
    QRLblTotalTotal.Caption := sTotalTotal;
    QRLblTotalFacturas.Caption := sNumFact;

    fSQL := TStringList.Create;
    with QTTMPVehOficial do
    begin
        Close;
        sdsQTTMPVehOficial.SQLConnection := MyBD;
        fSQL.Clear;
            fSQL.Add('SELECT TIPOFACTURA, NUMFACTURA, TO_CHAR(FECHALTA,''DD/MM/YYYY'') FECHALTA, SOLICREG, ');
            fsql.add('NUMINFORME, DOMINIO, MARCAMODELO, TIPOPAGO, NOMBRECLIENTE, TOTAL, TO_CHAR(FECHALTA,''YYYY/MM/DD'') FO ');
            fsql.add('FROM TTMPLISTPUBLICO ORDER BY FO, TIPOFACTURA, PTOVENTA, NUMFACTURA ');
        CommandText := fsql.text;
        {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPVehOficial);
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


procedure TFListadoVehOficialToPrint.FormDestroy(Sender: TObject);
begin
    QTTMPVehOficial.Close;
end;

end.
