unit UFEstadisticasResZ7ToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, UFEstadisticasResultados,
  quickrpt, ExtCtrls, Qrctrls, QRExport, jpeg;

type
  TFrmEstadisticasResZ7ToPrint = class(TForm)
    RepResultados61: TQuickRep;
    QRBand1: TQRBand;
    QRBtresplantas: TQRBand;
    QRBch3: TQRBand;
    QRLabel7: TQRLabel;
    QRGpunto: TQRGroup;
    QRExpr1: TQRExpr;
    QRLabel2: TQRLabel;
    RepResultados62: TQuickRep;
    DetailBand1: TQRBand;
    QRImage2: TQRImage;
    QRImage3: TQRImage;
    PageFooterBand4: TQRBand;
    QRSysData4: TQRSysData;
    QRResultadosZona6: TQRCompositeReport;
    SummaryBand1: TQRBand;
    QRImage1: TQRImage;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel25: TQRLabel;
    QRDBText18: TQRDBText;
    QRDBText19: TQRDBText;
    QRDBText20: TQRDBText;
    QRDBText21: TQRDBText;
    QRDBText23: TQRDBText;
    QRDBText24: TQRDBText;
    QRDBText25: TQRDBText;
    QRDBText26: TQRDBText;
    QRDBText22: TQRDBText;
    lbltitulo: TQRLabel;
    QRExcelFilter1: TQRExcelFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRImage4: TQRImage;
    QRLabel30: TQRLabel;
    QRDBText27: TQRDBText;
    QuickRep1: TQuickRep;
    QRBand5: TQRBand;
    QRImage6: TQRImage;
    QRBand6: TQRBand;
    QRSysData2: TQRSysData;
    procedure QRResultadosZona6AddReports(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEstadisticasResZ7ToPrint: TFrmEstadisticasResZ7ToPrint;

implementation

{$R *.DFM}

uses
   GLOBALS;

procedure TFrmEstadisticasResZ7ToPrint.QRResultadosZona6AddReports(
  Sender: TObject);
begin
  with QRResultadosZona6 do
  begin
    Reports.Add(RepResultados61);
    Reports.Add(RepResultados62);
    Reports.Add(QuickRep1);

  end;
end;


end.
