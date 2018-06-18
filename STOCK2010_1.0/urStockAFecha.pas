unit urStockAFecha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, jpeg, globals,SqlExpr;

type
  TfrmRepStockAFecha = class(TForm)
    repfrmRepStockAFecha: TQuickRep;
    QRBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    qrlFecha: TQRLabel;
    QRLabel2: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  procedure DoRepStockAFecha(aDateIni : string);

var
  frmRepStockAFecha: TfrmRepStockAFecha;

implementation

{$R *.dfm}
procedure DoRepStockAFecha(aDateIni : string);
begin
  with tfrmRepStockAFecha.Create(application) do
  try
    with tsqlquery.create (application) do
    try
      sqlconnection:=Mybd;
      sql.Add(format('SELECT DO_STOCKAFECHA_GNC(''%S'') FROM DUAL',[aDateIni]));
      open;
      qrlFecha.Caption := copy(aDateIni,1,10)+': '+fields[0].AsString;
    finally
      free
    end;
    repfrmRepStockAFecha.Preview;
  finally
    free;
  end;
end;

end.
 