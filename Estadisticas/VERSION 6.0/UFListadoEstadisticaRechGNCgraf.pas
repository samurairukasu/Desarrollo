unit UFListadoEstadisticaRechGNCgraf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, DBTables, quickrpt, Qrctrls, qrexport, TeEngine,
  Series, TeeProcs, Chart, DbChart, QRTEE, jpeg;

type
  TFEstadisticaREchGNCToPrint = class(TForm)
    QRImprimirFidel: TQuickRep;
    QRBand1: TQRBand;
    QRLlbTitulo: TQRLabel;
    QRLblIntervaloFechas: TQRLabel;
    SUM: TQRBand;
    QTTMPARQCAJAEXTEN: TQuery;
    QRBand3: TQRBand;
    QRDBText5: TQRDBText;
    QRDBText12: TQRDBText;
    QRGroup1: TQRGroup;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRLabel6: TQRLabel;
    qrlabel21: TQRLabel;
    qrlAnterior: TQRLabel;
    QRLabel1: TQRLabel;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    ChildBand1: TQRChildBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QrGraficoCant: TQuickRep;
    QRBand2: TQRBand;
    QRChart1: TQRChart;
    QRDBChart1: TQRDBChart;
    Series1: TBarSeries;
    Series2: TBarSeries;
    QrGraficoPorc: TQuickRep;
    QRBand4: TQRBand;
    QRChart2: TQRChart;
    QRDBChart2: TQRDBChart;
    BarSeries1: TBarSeries;
    CompGraf: TQRCompositeReport;
    qrlFormulario: TQRLabel;
    QRBand5: TQRBand;
    QRLfecha: TQRLabel;
    QRBand6: TQRBand;
    QRLFecha2: TQRLabel;
    QRBand7: TQRBand;
    QRLfecha3: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    Series3: TBarSeries;
    qrcrecimiento: TQuickRep;
    QRBand8: TQRBand;
    QRChart3: TQRChart;
    QRDBChart3: TQRDBChart;
    BarSeries2: TBarSeries;
    QRLabel5: TQRLabel;
    QRBand9: TQRBand;
    qrlFecha4: TQRLabel;
    QRBand10: TQRBand;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    QRExpr12: TQRExpr;
    QRLabel7: TQRLabel;
    QRExpr15: TQRExpr;
    qriapplus: TQRImage;
    QRImage1: TQRImage;
    QRImage2: TQRImage;
    QRImage3: TQRImage;
    procedure FormDestroy(Sender: TObject);
    procedure CompGrafAddReports(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(const cFechaIni, cFechaFin, sNumFact, NombreEstacion, NumeroEstacion, aCodDescu: string);
  end;

var
  FEstadisticaREchGNCToPrint: TFEstadisticaREchGNCToPrint;

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

procedure TFEstadisticaREchGNCToPrint.Execute(const cFechaIni, cFechaFin, sNumFact, NombreEstacion, NumeroEstacion, aCodDescu: string);
begin

    QRLblIntervaloFechas.Caption := PoneFecha(copy(cFechaIni,1,10),copy(cFechaFin,1,10),0);
    QRLAnterior.Caption :=PoneFecha(copy(cFechaIni,1,10),copy(cFechaFin,1,10),0);
//    QRLActual.Caption := PoneFecha(copy(cFechaIni,1,10),copy(cFechaFin,1,10),1);
    BarSeries1.Title := PoneFecha(copy(cFechaIni,1,10),copy(cFechaFin,1,10),0);
    Series3.Title := PoneFecha(copy(cFechaIni,1,10),copy(cFechaFin,1,10),1);
    QRChart2.Chart.Title.Text.Add(QRLblIntervaloFechas.Caption);
    QRChart2.Chart.Title.Text.Add('');
    QRChart2.Chart.Title.Text.Add('');
    QRChart1.Chart.Title.Text.Add(QRLblIntervaloFechas.Caption);
    QRChart1.Chart.Title.Text.Add('');
    QRChart1.Chart.Title.Text.Add('');
    QRChart3.Chart.Title.Text.Add(QRLblIntervaloFechas.Caption);
    QRChart3.Chart.Title.Text.Add('');
    QRChart3.Chart.Title.Text.Add('');
    QRLfecha.Caption := copy(cFechaIni,1,10)+' al '+copy(cFechaFin,1,10);
    QRLfecha2.Caption := copy(cFechaIni,1,10)+' al '+copy(cFechaFin,1,10);
    QRLfecha3.Caption := copy(cFechaIni,1,10)+' al '+copy(cFechaFin,1,10);
    QRLfecha4.Caption := copy(cFechaIni,1,10)+' al '+copy(cFechaFin,1,10);
    with QTTMPARQCAJAEXTEN do
    begin
        Close;
        DatabaseName := BDag.DataBaseName;
        SessionName := BDag.SessionName;
        SQL.Clear;
        SQL.Add('SELECT CODIGO_ZONA, NOMBREPLANTA(TO_NUMBER(CODIGO_ZONA||ESTACION)) ESTACION, ESTACION EST, CANTRECH, ' +
                    'CANTVOLV, PORCENTAJE, NUMPLANTA  ' +
                    'FROM TTMP_RECH_VUELVEN_GNC ORDER BY CODIGO_ZONA, EST ');
        {$IFDEF TRAZAS}
          FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPARQCAJAEXTEN);
        {$ENDIF}
        Open
    end;
//    QRImprimirFidel.PrinterSetup;
     QRImprimirFidel.Preview;
     CompGraf.Preview;
//     QrGraficoCant.Preview;
//     QrGraficoPorc.Preview;
end;

procedure TFEstadisticaREchGNCToPrint.FormDestroy(Sender: TObject);
begin
    QTTMPARQCAJAEXTEN.Close;
end;

procedure TFEstadisticaREchGNCToPrint.CompGrafAddReports(Sender: TObject);
begin
  with CompGraf do
  begin
//    Reports.Add(QrGraficoCant);
//    Reports.Add(QrGraficoPorc);
//    Reports.Add(qrcrecimiento);
  end;
end;

end.
