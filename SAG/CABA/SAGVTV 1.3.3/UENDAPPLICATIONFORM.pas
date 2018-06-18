unit UEndApplicationForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, CommCtrl;

type
  TEndApplicationForm = class(TForm)
    Timer1: TTimer;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    Bevel1: TBevel;
    Panel1: TPanel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EndApplicationForm: TEndApplicationForm;

implementation

{$R *.DFM}

Uses
   UThread;

procedure TEndApplicationForm.Timer1Timer(Sender: TObject);
begin
    ProgressBar1.Position := ProgressBar1.Position+1;
    Application.ProcessMessages;
end;



procedure TEndApplicationForm.FormShow(Sender: TObject);
begin
    ProgressBar1.Min := 0;
    ProgressBar1.Max := MAX_TIEMPOTIMEOUT ;
    ProgressBar1.Position := 0;
    Timer1.Enabled := TRUE;
    ProgressBar1.Perform(PBM_SETBARCOLOR, 0, ColorToRGB(clRed));
end;

procedure TEndApplicationForm.FormHide(Sender: TObject);
begin
     Timer1.Enabled := FALSE;
end;

end.
