unit UFPrintMaximumTimes;
{ Impresión de Tarifas y Tiempos Máximos }

{
  Ultima Traza:
  Ultima Incidencia:
  Ultima Anomalia:
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DB, StdCtrls, quickrpt, Qrctrls;

type
  TfrmImprimirTiTaPer = class(TForm)
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRTarifasTM: TQuickRep;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRBand4: TQRBand;
    QRLabel5: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel6: TQRLabel;
    QRDBText4: TQRDBText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImprimirTiTaPer: TfrmImprimirTiTaPer;

implementation

{$R *.DFM}

{uses
   MTiTaPer;}


end.
