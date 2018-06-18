unit UInicio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, UVersion;

type
  TFrmInicio = class(TForm)
    Panel2: TPanel;
    PStatus: TLabel;
    Progreso: TProgressBar;
    Panel1: TPanel;
    Panel3: TPanel;
    Image1: TImage;
    Label2: TLabel;
    Panel4: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInicio: TFrmInicio;

implementation

{$R *.DFM}


procedure TFrmInicio.FormCreate(Sender: TObject);
begin
    Caption := LITERAL_VERSION;
end;

end.
