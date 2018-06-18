unit UFPrintPeriodicity;
{ Impresión de la periodicidad de los vehículos }

{
  Ultima Traza:
  Ultima Incidencia:
  Ultima Anomalia:
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, quickrpt, Qrctrls;

type
  TfrmPeriodicidad = class(TForm)
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    QRFrecuencia: TQuickRep;
    QRSysData1: TQRSysData;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLblL1: TQRLabel;
    QRLblP1: TQRLabel;
    QRLblL2: TQRLabel;
    QRLblP2: TQRLabel;
    QRLblClasificacion: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRLabel3: TQRLabel;
    QRDBText6: TQRDBText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPeriodicidad: TfrmPeriodicidad;

implementation

{$R *.DFM}

{uses
   mTiTaPer;}

end.
