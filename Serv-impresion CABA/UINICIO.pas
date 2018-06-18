unit UInicio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, UVersion, CommCtrl;

type
  TFrmInicio = class(TForm)
    Progreso: TProgressBar;
    Image1: TImage;
    Bevel1: TBevel;
    PStatus: TLabel;
    Panel1: TPanel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInicio: TFrmInicio;

implementation

{$R *.DFM}


procedure TFrmInicio.FormShow(Sender: TObject);
begin
CAPTION:= APP_TITLE;
Progreso.Perform(PBM_SETBARCOLOR, 0, ColorToRGB(clRed));
end;

end.
