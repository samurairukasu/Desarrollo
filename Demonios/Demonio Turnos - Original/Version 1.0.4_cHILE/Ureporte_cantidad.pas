unit Ureporte_cantidad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Umodulo, DB, ADODB, QuickRpt, QRCtrls, jpeg, ExtCtrls,
  DataExport, DataToXLS, QRExport;

type
  Treporte_cantidad = class(TForm)
    repConsumosGNCxAno: TQuickRep;
    QRBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    qrlComprob: TQRLabel;
    qrlTaller: TQRLabel;
    QRLabel5: TQRLabel;
    QRBDetalle: TQRBand;
    qretaller: TQRExpr;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    qrbTotal: TQRBand;
    QRExpr1: TQRExpr;
    QRLabel3: TQRLabel;
    QRGroup1: TQRGroup;
    QRExpr4: TQRExpr;
    QRBand4: TQRBand;
    QRLabel6: TQRLabel;
    QRExpr9: TQRExpr;
    ADOQuery1: TADOQuery;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel7: TQRLabel;
    QRExcelFilter1: TQRExcelFilter;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  reporte_cantidad: Treporte_cantidad;

implementation

{$R *.dfm}

end.
