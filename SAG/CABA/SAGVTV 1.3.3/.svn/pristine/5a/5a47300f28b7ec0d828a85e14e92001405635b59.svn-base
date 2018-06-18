unit UFInformesDialogAscii;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, RxGIF;

type
  tExportarAscii = (teaGeneral,teaResumen,teaAmbos);

  TFAsciiDialog = class(TForm)
    Panel1: TPanel;
    RImprimir: TRadioGroup;
    Image1: TImage;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure RImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fOpcion : tExportarAscii;
    { Private declarations }
  public
    { Public declarations }
    property ExportarAscii : tExportarAscii read fOpcion;
  end;

var
  FAsciiDialog: TFAsciiDialog;

implementation

{$R *.DFM}

procedure TFAsciiDialog.RImprimirClick(Sender: TObject);
begin
    fOpcion := tExportarAscii((Sender as TRadioGroup).ItemIndex);
end;

procedure TFAsciiDialog.FormCreate(Sender: TObject);
begin
    fOpcion := tExportarAscii(0);
end;

end.
