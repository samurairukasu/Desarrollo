unit ufUsuarioCambios;

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
    ExtCtrls;

type
  TfrmUsuarioCambios = class(TForm)
    lblNombreUsuario: TLabel;
    edtNombreUsuario: TEdit;
    Label2: TLabel;
    edtPassword: TEdit;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    Bevel1: TBevel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnAceptarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUsuarioCambios: TfrmUsuarioCambios;

implementation

{$R *.DFM}

uses
  Messages;


procedure TfrmUsuarioCambios.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if (Key = #13) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TfrmUsuarioCambios.btnAceptarClick(Sender: TObject);
begin
    ModalResult := mrOk;
end;

end.

