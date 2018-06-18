unit UFEstadisticasTiemposPromZ7ToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, UFEstadisticasResultados,
  quickrpt, ExtCtrls, Qrctrls, jpeg;

type
  TFrmEstadisticasTiempoPromZ7ToPrint = class(TForm)
    RepTiempos62: TQuickRep;
    DetailBand1: TQRBand;
    QRImage2: TQRImage;
    PageFooterBand4: TQRBand;
    QRSysData4: TQRSysData;
    QRTiemposZona6: TQRCompositeReport;
    RepTiempos61: TQuickRep;
    QRBand2: TQRBand;
    lblTituloz6: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel3: TQRLabel;
    QRGpuntoz6: TQRGroup;
    QRExpr2: TQRExpr;
    QRBand6: TQRBand;
    QRBand7: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRBand8: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    PageFooterBand2: TQRBand;
    QRImage1: TQRImage;
    QRSysData2: TQRSysData;
    QRImage4: TQRImage;
    QRLabel2: TQRLabel;
    QRDBText9: TQRDBText;
    procedure QRTiemposZona6AddReports(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEstadisticasTiempoPromZ7ToPrint: TFrmEstadisticasTiempoPromZ7ToPrint;

implementation

{$R *.DFM}

uses
   GLOBALS;

procedure TFrmEstadisticasTiempoPromZ7ToPrint.QRTiemposZona6AddReports(
  Sender: TObject);
begin
  with QRTiemposZona6 do
  begin
    Reports.Add(RepTiempos61);
    Reports.Add(RepTiempos62);
  end;
end;

end.
