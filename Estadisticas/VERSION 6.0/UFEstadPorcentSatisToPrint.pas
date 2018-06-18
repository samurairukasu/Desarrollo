unit UFEstadPorcentSatisToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, quickrpt, Qrctrls, qrexport, TeEngine,
  Series, TeeProcs, Chart, DbChart, QRTEE, TeeFunci, jpeg, FMTBcd,
  DBClient, Provider, SqlExpr;

type
  TFrmEstadPorcSatisToPrint = class(TForm)
    QRCompositeReport1: TQRCompositeReport;
    sdsQTTMPARQCAJAEXTEN: TSQLDataSet;
    dspQTTMPARQCAJAEXTEN: TDataSetProvider;
    QTTMPARQCAJAEXTEN: TClientDataSet;
    sdsQGrafico: TSQLDataSet;
    dspQGrafico: TDataSetProvider;
    QGrafico: TClientDataSet;
    QrGrCant: TQuickRep;
    QRBand2: TQRBand;
    QRChart1: TQRChart;
    QRDBChart1: TQRDBChart;
    Series1: TPieSeries;
    QRBand7: TQRBand;
    QRLfecha2: TQRLabel;
    QRImprimirFidel: TQuickRep;
    QRBand1: TQRBand;
    QRLlbTitulo: TQRLabel;
    QRLblIntervaloFechas: TQRLabel;
    qrlFormulario: TQRLabel;
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
    QRBand8: TQRBand;
    QRLabel7: TQRLabel;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRImage4: TQRImage;
    procedure FormDestroy(Sender: TObject);
    procedure QRCompositeReport1AddReports(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(const cFechaIni, cFechaFin: string);
  end;

var
  FrmEstadPorcSatisToPrint: TFrmEstadPorcSatisToPrint;

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

procedure TFrmEstadPorcSatisToPrint.Execute(const cFechaIni, cFechaFin: string);
begin
    QRLblIntervaloFechas.Caption := PoneFecha(copy(cFechaIni,1,10),copy(cFechaFin,1,10),0);
//    QRLfecha.Caption := copy(cFechaIni,1,10)+' al '+copy(cFechaFin,1,10);
    QRLfecha2.Caption := copy(cFechaIni,1,10)+' al '+copy(cFechaFin,1,10);    
    with QTTMPARQCAJAEXTEN do
    begin
        sdsQTTMPARQCAJAEXTEN.SQLConnection := BDag;
        commandtext := 'SELECT CODIGO_ZONA, NOMBREPLANTA(TO_NUMBER(CODIGO_ZONA||ESTACION)) ESTACION, ESTACION EST, ' +
                    'SATISFECHOS, ENCUESTADOS, PORCENTAJE, NUMPLANTA ' +
                    'FROM TTMP_PORCENTAJE_SATIS ORDER BY CODIGO_ZONA, EST ';
        {$IFDEF TRAZAS}
          FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPARQCAJAEXTEN);
        {$ENDIF}
        Open
    end;
    with QGRAFICO do
    begin
        sdsQGrafico.SQLConnection := BDAG;
        commandtext := 'SELECT ''SATISFECHOS'', SUM(SATISFECHOS)*100/SUM(ENCUESTADOS) FROM TTMP_PORCENTAJE_SATIS '+
        'UNION SELECT ''OTROS'',100-(SUM(SATISFECHOS)*100/SUM(ENCUESTADOS)) FROM TTMP_PORCENTAJE_SATIS';
        {$IFDEF TRAZAS}
          FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPARQCAJAEXTEN);
        {$ENDIF}
        Open
    end;
     QRCompositeReport1.Preview;
end;


procedure TFrmEstadPorcSatisToPrint.FormDestroy(Sender: TObject);
begin
    QTTMPARQCAJAEXTEN.Close;
end;


procedure TFrmEstadPorcSatisToPrint.QRCompositeReport1AddReports(
  Sender: TObject);
begin
  with QRCompositeReport1 do
  begin
    Reports.Add(QRImprimirFidel);
    Reports.Add(QrGrCant);
  end;
end;

end.
