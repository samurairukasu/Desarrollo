unit UFEstadisticasEncSatisToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, UFEstadisticasEncSatis,
  quickrpt, ExtCtrls, Qrctrls;

type
  TFrmEstadisticasEncSatisToPrint = class(TForm)
    RepValores: TQuickRep;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    dbtSUM3y4: TQRDBText;
    lblTitulo: TQRLabel;
    QRLabel7: TQRLabel;
    QRBand4: TQRBand;
    QRLabel8: TQRLabel;
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEstadisticasEncSatisToPrint: TFrmEstadisticasEncSatisToPrint;

implementation

{$R *.DFM}

uses
   GLOBALS;

   
procedure TFrmEstadisticasEncSatisToPrint.QRBand2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if dbtSUM3y4.dataset.FieldByName('sum3y4').value >= fVarios.LimiteEncuestas then
    dbtSUM3y4.Font.Color:=clred
  else
    dbtSUM3y4.Font.Color:=clWindowText;
end;

end.
