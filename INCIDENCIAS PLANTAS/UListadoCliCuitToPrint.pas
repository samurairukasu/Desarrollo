unit UListadoCliCuitToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, quickrpt, Qrctrls;

type
  TFListadoCliCuitToPrint = class(TForm)
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    QRImprimirCaja: TQuickRep;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel13: TQRLabel;
    QRLblNumeroEstacion: TQRLabel;
    SD: TSaveDialog;
    QRSysData2: TQRSysData;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRImage1: TQRImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FListadoCliCuitToPrint: TFListadoCliCuitToPrint;

implementation

{$R *.DFM}


end.
