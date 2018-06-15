unit Unitimprimie_asigandovsreservado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls;

type
  Timprimie_asigandovsreservado = class(TForm)
    QRMODMARCA: TQuickRep;
    QRBand8: TQRBand;
    QRLabel28: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRImage1: TQRImage;
    QRLabel2: TQRLabel;
    QRLabel6: TQRLabel;
    QRGroup2: TQRGroup;
    QRLabel19: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    DetailBand1: TQRBand;
    QRDBText3: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRLabel7: TQRLabel;
    QRDBText1: TQRDBText;
    SummaryBand1: TQRBand;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  imprimie_asigandovsreservado: Timprimie_asigandovsreservado;

implementation

uses Unitseleccione_fecha_turnos_por_plantilla;

{$R *.dfm}

end.
