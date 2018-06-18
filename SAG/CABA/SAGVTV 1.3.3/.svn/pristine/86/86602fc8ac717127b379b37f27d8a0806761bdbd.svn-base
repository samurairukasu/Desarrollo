unit uListadoCambioZonaToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, quickrpt, Qrctrls,qrexport, FMTBcd,
  DBClient, Provider, SqlExpr;

type
  TFListadoCambioZonaToPrint = class(TForm)
    SD: TSaveDialog;
    sdsQTTMPLISTCAMBZONA: TSQLDataSet;
    dspQTTMPLISTCAMBZONA: TDataSetProvider;
    QTTMPLISTCAMBZONA: TClientDataSet;
    QRImprimirCaja: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel13: TQRLabel;
    QRLblNumeroEstacion: TQRLabel;
    QRLblIntervaloFechas: TQRLabel;
    QRBand2: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel3: TQRLabel;
    QRBand3: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText2: TQRDBText;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRBand5: TQRBand;
    QRLabel15: TQRLabel;
    QRLblTotal: TQRLabel;
    QRLabel4: TQRLabel;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(const cFechaIni, cFechaFin, sTotal, NombreEstacion, NumeroEstacion: string);
    procedure ExportaAscii(const cFechaIni, cFechaFin, sTotal, NombreEstacion, NumeroEstacion: string);
  end;

var
  FListadoCambioZonaToPrint: TFListadoCambioZonaToPrint;

implementation

{$R *.DFM}

uses
   QREXTRA,
   QRPRNTR,
   ULOGS,
   GLOBALS,
   USAGESTACION;


const
    FICHERO_ACTUAL = 'UListadoCambioZona';

procedure TFListadoCambioZonaToPrint.Execute(const cFechaIni, cFechaFin, sTotal, NombreEstacion, NumeroEstacion: string);
var
  fSQL : TStringList;
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);
    QRLblTotal.Caption := sTotal;
    fSQL := TStringList.Create;

    with QTTMPLISTCAMBZONA do
    begin
        Close;
        sdsQTTMPLISTCAMBZONA.SQLConnection := MyBD;
        fSQL.Clear;
            fSQL.Add('SELECT TO_CHAR(FECHALTA,''DD/MM/YYYY'') FECHALTA, ');
            fsql.add('NUMINFORME, DOMINIO, MARCAMODELO, NOMBRECLIENTE, ZONAPROC, TO_CHAR(FECHALTA,''YYYY/MM/DD'') FO ');
            fsql.add('FROM TTMPLISTCAMBIOZONA ORDER BY FO, NUMINFORME ');
            commandtext := fsql.text;
        {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTCAMBZONA);
        {$ENDIF}
        Open
    end;
    QRImprimirCaja.PrinterSetup;
    QRImprimirCaja.Print;
end;



procedure TFListadoCambioZonaToPrint.ExportaAscii(const cFechaIni, cFechaFin, sTotal, NombreEstacion, NumeroEstacion: string);
var
  aExportFilter : TQRAsciiExportFilter;
  fSQL : TStringList;
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);
    QRLblTotal.Caption := sTotal;

    fSQL := TStringList.Create;
    with QTTMPLISTCAMBZONA do
    begin
        Close;
        sdsQTTMPLISTCAMBZONA.SQLConnection := MyBD;
        fSQL.Clear;
            fSQL.Add('SELECT TO_CHAR(FECHALTA,''DD/MM/YYYY'') FECHALTA, ');
            fsql.add('NUMINFORME, DOMINIO, MARCAMODELO, NOMBRECLIENTE, ZONAPROC, TO_CHAR(FECHALTA,''YYYY/MM/DD'') FO ');
            fsql.add('FROM TTMPLISTCAMBIOZONA ORDER BY FO, NUMINFORME ');
        CommandText := fSQL.Text;
        {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTCAMBZONA);
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


procedure TFListadoCambioZonaToPrint.FormDestroy(Sender: TObject);
begin
    QTTMPLISTCAMBZONA.Close;
end;








end.
