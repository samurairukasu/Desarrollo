unit UFInformesDialogPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, RxGIF;

type
  tImprimir = (tiGeneral,tiResumen,tiAmbos);

  TFDialogPrint = class(TForm)
    Panel1: TPanel;
    RImprimir: TRadioGroup;
    Image1: TImage;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure RImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fOpcion : tImprimir;
    { Private declarations }
  public
    { Public declarations }
    property Imprimir : tImprimir read fOpcion;
  end;

var
  FDialogPrint: TFDialogPrint;

implementation

{$R *.DFM}

procedure TFDialogPrint.RImprimirClick(Sender: TObject);
begin
    fOpcion := tImprimir((Sender as TRadioGroup).ItemIndex);
end;

procedure TFDialogPrint.FormCreate(Sender: TObject);
begin
    fOpcion := tImprimir(0);
end;

end.
