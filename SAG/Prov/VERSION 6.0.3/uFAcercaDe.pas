unit ufAcercaDe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, jpeg, Buttons, RxGIF;

type
  TfrmAcercaDe = class(TForm)
    lblVersion: TLabel;
    Label1: TLabel;
    Image1: TImage;
    sbSalir: TSpeedButton;
    Bevel1: TBevel;
    Label2: TLabel;
    procedure FormClick(Sender: TObject);
    procedure sbSalirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAcercaDe: TfrmAcercaDe;

implementation

{$R *.DFM}


procedure TfrmAcercaDe.FormClick(Sender: TObject);
begin
  close;
end;

procedure TfrmAcercaDe.sbSalirClick(Sender: TObject);
begin
Close;
end;

procedure TfrmAcercaDe.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = (VK_ESCAPE) then
  Close;
end;

end.
