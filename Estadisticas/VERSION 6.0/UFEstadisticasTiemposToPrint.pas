unit UFEstadisticasTiemposToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, UFEstadisticasTiempos,
  quickrpt, ExtCtrls, Qrctrls;

type
  TFrmEstadisticasTiemposToPrint = class(TForm)
    RepValores: TQuickRep;
    QRBand1: TQRBand;
    QRBtresplantas: TQRBand;
    QRBch3: TQRBand;
    QRLabel1: TQRLabel;
    qrlplanta1: TQRLabel;
    qrlplanta2: TQRLabel;
    qrlplanta3: TQRLabel;
    QRDBText1: TQRDBText;
    bdtplanta1: TQRDBText;
    bdtplanta2: TQRDBText;
    bdtplanta3: TQRDBText;
    lblTitulo: TQRLabel;
    QRLabel7: TQRLabel;
    QRGpunto: TQRGroup;
    QRBand4: TQRBand;
    RepValoresz6: TQuickRep;
    QRBand2: TQRBand;
    lblTituloz6: TQRLabel;
    QRLabel14: TQRLabel;
    QRGpuntoz6: TQRGroup;
    QRBand6: TQRBand;
    QRBand7: TQRBand;
    QRDBText18: TQRDBText;
    QRDBText19: TQRDBText;
    QRDBText20: TQRDBText;
    QRDBText21: TQRDBText;
    QRDBText23: TQRDBText;
    QRDBText24: TQRDBText;
    QRDBText25: TQRDBText;
    QRDBText26: TQRDBText;
    QRBand8: TQRBand;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    qrlplanta4: TQRLabel;
    bdtplanta4: TQRDBText;
    qrlplanta5: TQRLabel;
    bdtplanta5: TQRDBText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEstadisticasTiemposToPrint: TFrmEstadisticasTiemposToPrint;

implementation

{$R *.DFM}

uses
   GLOBALS;






end.
