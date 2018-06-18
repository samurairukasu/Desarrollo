unit UFListadoPrimInspecToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, quickrpt, Qrctrls, qrexport, TeEngine,
  Series, TeeProcs, Chart, DbChart, QRTEE, jpeg, FMTBcd, SqlExpr, Provider,
  DBClient, DBXpress;

type
  TFListadoPrimInspecToPrint = class(TForm)
    CompGraf: TQRCompositeReport;
    QTTMPPRIMVER: TClientDataSet;
    dspQTTMPPRIMVER: TDataSetProvider;
    sdsQTTMPPRIMVER: TSQLDataSet;
    QRImprimirFidel: TQuickRep;
    QRBand1: TQRBand;
    QRLlbTitulo: TQRLabel;
    QRLblIntervaloFechas: TQRLabel;
    qrlFormulario: TQRLabel;
    qriapplus: TQRImage;
    SUM: TQRBand;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr6: TQRExpr;
    QRBand3: TQRBand;
    QRDBText5: TQRDBText;
    QRDBText12: TQRDBText;
    QRExpr4: TQRExpr;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRGroup1: TQRGroup;
    QRLAnterior: TQRLabel;
    QRLActual: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel1: TQRLabel;
    QRExpr5: TQRExpr;
    ChildBand1: TQRChildBand;
    QRBand5: TQRBand;
    QRLfecha: TQRLabel;
    QRBand8: TQRBand;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRLabel7: TQRLabel;
    QrGraficoPorc: TQuickRep;
    QRBand4: TQRBand;
    QRChart2: TQRChart;
    QRDBChart2: TQRDBChart;
    BarSeries1: TBarSeries;
    QRLabel4: TQRLabel;
    QRBand6: TQRBand;
    QRLFecha2: TQRLabel;
    QRChart1: TQRChart;
    QRDBChart1: TQRDBChart;
    Series1: TBarSeries;
    Series2: TBarSeries;
    procedure FormDestroy(Sender: TObject);
    procedure CompGrafAddReports(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(const cFechaIni, cFechaFin: string);
  end;

var
  FListadoPrimInspecToPrint: TFListadoPrimInspecToPrint;

implementation

{$R *.DFM}

uses
   QREXTRA,
   QRPRNTR,
   GLOBALS,
   USAGESTACION,
   USAGCLASSES,
   uUtils;


const
    FICHERO_ACTUAL = 'UArqueoCajaExtendedToPrint';


procedure TFListadoPrimInspecToPrint.Execute(const cFechaIni, cFechaFin: string);
begin
    Screen.Cursor:=crhourGlass;
    QRLblIntervaloFechas.Caption := PoneFecha(copy(cFechaIni,1,10),copy(cFechaFin,1,10),0);
    QRLAnterior.Caption := PoneFecha(copy(cFechaIni,1,10),copy(cFechaFin,1,10),1);
    QRLActual.Caption := PoneFecha(copy(cFechaIni,1,10),copy(cFechaFin,1,10),0);
    Series1.Title := PoneFecha(copy(cFechaIni,1,10),copy(cFechaFin,1,10),1);
    Series2.Title := PoneFecha(copy(cFechaIni,1,10),copy(cFechaFin,1,10),0);
    QRChart2.Chart.Title.Text.Add(QRLblIntervaloFechas.Caption);
    QRChart2.Chart.Title.Text.Add('');
    QRChart2.Chart.Title.Text.Add('');
    QRChart1.Chart.Title.Text.Add(QRLblIntervaloFechas.Caption);
    QRChart1.Chart.Title.Text.Add('');
    QRChart1.Chart.Title.Text.Add('');
    QRLfecha.Caption := copy(cFechaIni,1,10)+' al '+copy(cFechaFin,1,10);
    QRLfecha2.Caption := copy(cFechaIni,1,10)+' al '+copy(cFechaFin,1,10);
    with QTTMPPRIMVER do
    begin
        Close;
        sdsQTTMPPRIMVER.SQLConnection := BDAG;
        commandtext := 'SELECT CODIGO_ZONA, NOMBREPLANTA(TO_NUMBER(CODIGO_ZONA||ESTACION)) ESTACION, ESTACION EST, ANTERIOR, ' +
                    'ACTUAL, PORCENTAJE, NUMPLANTA ' +
                    'FROM TTMP_PRIMERAS_INSP ORDER BY CODIGO_ZONA, EST ';
        {$IFDEF TRAZAS}
          FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPARQCAJAEXTEN);
        {$ENDIF}
        Open
    end;
     Screen.Cursor:=crDefault;
     CompGraf.Preview;
end;


procedure TFListadoPrimInspecToPrint.FormDestroy(Sender: TObject);
begin
    QTTMPPRIMVER.Close;
end;

procedure TFListadoPrimInspecToPrint.CompGrafAddReports(Sender: TObject);
begin
  with CompGraf do
  begin
    Reports.Add(QRImprimirFidel);
//   Reports.Add(QrGraficoCant);
    Reports.Add(QrGraficoPorc);
  end;
end;

end.
