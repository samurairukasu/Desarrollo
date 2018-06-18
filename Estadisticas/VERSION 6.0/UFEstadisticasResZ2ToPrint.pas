unit UFEstadisticasResZ2ToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, UFEstadisticasResultados,
  quickrpt, ExtCtrls, Qrctrls, QRExport, jpeg;

type
  TFrmEstadisticasResZ2ToPrint = class(TForm)
    RepResultados21: TQuickRep;
    QRBand1: TQRBand;
    QRBtresplantas: TQRBand;
    QRBch3: TQRBand;
    QRLabel1: TQRLabel;
    qrlplanta1: TQRLabel;
    qrlplanta2: TQRLabel;
    qrlplanta3: TQRLabel;
    qrlplanta4: TQRLabel;
    QRDBText1: TQRDBText;
    bdtplanta1: TQRDBText;
    bdtplanta2: TQRDBText;
    bdtplanta3: TQRDBText;
    bdtplanta4: TQRDBText;
    QRLabel7: TQRLabel;
    QRGpunto: TQRGroup;
    QRExpr1: TQRExpr;
    QRLabel2: TQRLabel;
    qrlmedia: TQRLabel;
    bdtmedia: TQRDBText;
    RepResultados22: TQuickRep;
    DetailBand1: TQRBand;
    QRImage2: TQRImage;
    QRImage3: TQRImage;
    PageFooterBand4: TQRBand;
    QRSysData4: TQRSysData;
    QRResultadosZona2: TQRCompositeReport;
    SummaryBand1: TQRBand;
    QRImage1: TQRImage;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    lbltitulo: TQRLabel;
    QRRTFFilter1: TQRRTFFilter;
    QRExcelFilter1: TQRExcelFilter;
    QRImage4: TQRImage;
    qrlplanta5: TQRLabel;
    bdtplanta5: TQRDBText;
    qrlplanta6: TQRLabel;
    bdtplanta6: TQRDBText;
    bdtplanta7: TQRDBText;
    qrlplanta7: TQRLabel;
    qrlplanta8: TQRLabel;
    bdtplanta8: TQRDBText;
    procedure QRResultadosZona2AddReports(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEstadisticasResZ2ToPrint: TFrmEstadisticasResZ2ToPrint;

implementation

{$R *.DFM}

uses
   GLOBALS;

procedure TFrmEstadisticasResZ2ToPrint.QRResultadosZona2AddReports(
  Sender: TObject);
begin
  with QRResultadosZona2 do
  begin
    Reports.Add(RepResultados21);
    Reports.Add(RepResultados22);
  end;
end;

end.
