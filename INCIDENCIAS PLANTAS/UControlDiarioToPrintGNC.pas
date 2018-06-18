unit UControlDiarioToPrintGNC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, quickrpt, Qrctrls,qrexport, FMTBcd, SqlExpr,
  DBClient, Provider;

type
  TFControlDiarioToPrint = class(TForm)
    SD: TSaveDialog;
    dspQTTMPLISTCANTDESCUENTOS: TDataSetProvider;
    QTTMPLISTCANTDESCUENTOS: TClientDataSet;
    sdsQTTMPLISTCANTDESCUENTOS: TSQLDataSet;
    QRImprimirCaja: TQuickRep;
    QRBand1: TQRBand;
    QRLlbTitulo: TQRLabel;
    QRLabel13: TQRLabel;
    QRLblNumeroEstacion: TQRLabel;
    QRLblIntervaloFechas: TQRLabel;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRBand3: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion: string);
    procedure ExportaAscii(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion: string);
  end;

var
  FControlDiarioToPrint: TFControlDiarioToPrint;

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
    FICHERO_ACTUAL = 'UControlDiarioToPrintGNC';

procedure TFControlDiarioToPrint.Execute(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion: string);
begin
    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);
        with QTTMPLISTCANTDESCUENTOS do
        begin
            Close;
            sdsQTTMPLISTCANTDESCUENTOS.SQLConnection := MyBD;
            commandtext := 'SELECT CANTAPTAS, CANTRECH, TOTCAJA, COBLEASACT, MINOBLEACT, MAXOBLEACT, '+
                    ' COBLEASIG, MINOBLEASIG, MAXOBLEASIG  ' +
                    'FROM TTMPCONTROLDIARIOGNC ';
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTCANTDESCUENTOS);
            {$ENDIF}
            Open;
        end;
    QRImprimirCaja.PrinterSetup;
    QRImprimirCaja.Print;
end;



procedure TFControlDiarioToPrint.ExportaAscii(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion: string);
var
    aExportFilter : TQRAsciiExportFilter;
begin
    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);
    QRLlbTitulo.caption:='Listado Control Diario';
        with QTTMPLISTCANTDESCUENTOS do
        begin
            Close;
            sdsQTTMPLISTCANTDESCUENTOS.SQLConnection := MyBD;
            commandtext:='SELECT CANTAPTAS, CANTRECH, TOTCAJA, COBLEASACT, MINOBLEACT, MAXOBLEACT, '+
                    ' COBLEASIG, MINOBLEASIG, MAXOBLEASIG  ' +
                    'FROM TTMPCONTROLDIARIOGNC ';
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

procedure TFControlDiarioToPrint.FormDestroy(Sender: TObject);
begin
    QTTMPLISTCANTDESCUENTOS.Close;
end;













end.
