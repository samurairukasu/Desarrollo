unit password;

interface

uses
    Windows,
    SysUtils,
    Classes,
    Graphics,
    Dialogs,
    Forms,
    Controls,
    StdCtrls,
    Buttons,
    ExtCtrls, RxGIF;

type
  TFrmPassword = class(TForm)
    lblNombreUsuario: TLabel;
    edtNombreUsuario: TEdit;
    Label2: TLabel;
    edtPassword: TEdit;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    Image1: TImage;
    Bevel2: TBevel;
    TAcceso: TTimer;
    procedure OKBtnClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure TAccesoTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  Segundos: Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPassword: TFrmPassword;

implementation

{$R *.DFM}

uses
  Messages;


procedure TFrmPassword.OKBtnClick(Sender: TObject);
begin
    showmessage ('Password: '+ edtPassword.text);
end;

procedure TFrmPassword.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if (Key = #13) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TFrmPassword.btnAceptarClick(Sender: TObject);
begin
    ModalResult := mrOk;
end;

procedure TFrmPassword.btnCancelarClick(Sender: TObject);
begin
ModalResult:= mrCancel;
end;

procedure TFrmPassword.TAccesoTimer(Sender: TObject);
begin
Inc(Segundos);
if (Segundos = 60) then
  Application.Terminate;
end;

procedure TFrmPassword.FormShow(Sender: TObject);
begin
Segundos:=0;
TAcceso.Enabled:=True;
end;

end.

