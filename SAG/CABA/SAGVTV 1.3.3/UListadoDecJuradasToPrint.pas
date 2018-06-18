unit UListadoDecJuradasToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls,  quickrpt, Qrctrls, SqlExpr, FMTBcd, Provider,
  DBClient;

type
  TFListadoDecJuradasToPrint = class(TForm)
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
    QRSysData2: TQRSysData;
    QTTMPLISTCHEQUES: TClientDataSet;
    dspquery2: TDataSetProvider;
    sdsquery2: TSQLDataSet;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion: string);
  end;

var
  FListadoDecJuradasToPrint: TFListadoDecJuradasToPrint;

implementation

{$R *.DFM}

uses
   QREXTRA,
   QRPRNTR,
   ULOGS,
   GLOBALS,
   USAGESTACION;


const
    FICHERO_ACTUAL = 'UListadoDecJuradaToPrint';

procedure TFListadoDecJuradasToPrint.Execute(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion: string);
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);

    with QTTMPLISTCHEQUES do
    begin
        Close;
        sdsquery2.SQLConnection := MyBD;
        sdsquery2.CommandText := 'SELECT TO_CHAR(FECHA,''DD/MM/YYYY'') FECHA,  NUMERO, PATENTE, NOMBRES, NUMINSPE FROM TTMPDJURADA ORDER BY FECHA ';
        {$IFDEF TRAZAS}
        FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTCHEQUES);
        {$ENDIF}
        Open
    end;
    QRImprimirCaja.PrinterSetup;
    QRImprimirCaja.Print;
end;



procedure TFListadoDecJuradasToPrint.FormDestroy(Sender: TObject);
begin
    QTTMPLISTCHEQUES.Close;
end;






end.
