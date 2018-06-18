unit UEndApplicationForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls;

type
  TEndApplicationForm = class(TForm)
    Timer1: TTimer;
    Panel1: TPanel;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
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

end;

procedure TEndApplicationForm.FormHide(Sender: TObject);
begin
     Timer1.Enabled := FALSE;
end;

end.
