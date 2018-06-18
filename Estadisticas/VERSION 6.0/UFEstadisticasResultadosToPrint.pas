unit UFEstadisticasResultadosToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, UFEstadisticasResultados,
  quickrpt, ExtCtrls, Qrctrls, jpeg;

type
  TFrmEstadisticasResultadosToPrint = class(TForm)
    RepResultados: TQuickRep;
    QRBand1: TQRBand;
    QRLabel2: TQRLabel;
    lbltituloz: TQRLabel;
    lbltitulo: TQRLabel;
    QRImage4: TQRImage;
    QRBtresplantas: TQRBand;
    QRDBText1: TQRDBText;
    bdtplanta1: TQRDBText;
    bdtplanta2: TQRDBText;
    bdtplanta3: TQRDBText;
    bdtplanta4: TQRDBText;
    bdtplanta6: TQRDBText;
    bdtplanta5: TQRDBText;
    bdtplanta7: TQRDBText;
    bdtmedia: TQRDBText;
    QRBch3: TQRBand;
    QRLabel1: TQRLabel;
    qrlplanta1: TQRLabel;
    qrlplanta2: TQRLabel;
    qrlplanta3: TQRLabel;
    qrlplanta4: TQRLabel;
    qrlmedia: TQRLabel;
    qrlplanta5: TQRLabel;
    qrlplanta6: TQRLabel;
    qrlplanta7: TQRLabel;
    QRGpunto: TQRGroup;
    QRExpr1: TQRExpr;
    SummaryBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    qrlplanta8: TQRLabel;
    bdtplanta8: TQRDBText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEstadisticasResultadosToPrint: TFrmEstadisticasResultadosToPrint;

implementation

{$R *.DFM}


end.
