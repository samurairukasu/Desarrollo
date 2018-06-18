unit Ngrsrv;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, SysUtils, Dialogs, UCEdit, Messages;

type
  TNGrSrvDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Edit1: TColorEdit;
    Edit2: TColorEdit;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure OKBtnClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    ID: Integer;
    Nombre: String;
    Error: Boolean;
  public
    { Public declarations }
    Constructor Create(Owner: TComponent; Op,Ident:Integer; Nomb:String);
    Procedure ObtenerDatos(Var Ident: Integer; Var Nomb: String);
  end;

var
  NGrSrvDlg: TNGrSrvDlg;

implementation

{$R *.DFM}

Constructor TNGrSrvDlg.Create(Owner: TComponent; Op,Ident: Integer; Nomb:String);
Begin
    Inherited Create(Owner);
    ID := Ident;
    Nombre := Nomb;
    Error := True;
    Edit2.Text := Nombre;
    Edit1.Text := IntToStr(ID);
    if (Op = 1) Then Edit1.ReadOnly := True;
End;

Procedure TNGrSrvDlg.ObtenerDatos(Var Ident: Integer; Var Nomb: String);
Begin
    if not Error Then
      Begin
        Ident := ID;
        Nomb := Nombre;
      End
    Else
      Ident := -1;
End;

procedure TNGrSrvDlg.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
    if ((key < '0') Or (Key > '9')) And (Key <> #8) Then
        Key := #0;
end;

procedure TNGrSrvDlg.OKBtnClick(Sender: TObject);
begin
    Error := FALSE;

    If (Edit1.Text = '') or (Edit2.Text = '')  Then
      Begin
       ShowMessage('Debe rellenar todos los campos');
       Error := True;
      End
    Else
      Begin
        Nombre := Edit2.Text;
        ID := StrToInt(Edit1.Text);
      End;
   if not Error Then
      ModalResult := mrOK
   Else
      ModalResult := 0;

end;

procedure TNGrSrvDlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TNGrSrvDlg.FormShow(Sender: TObject);
begin
    edit1.setfocus;

    if edit1.readonly then
       edit1.FondoColor := clFuchsia
    else
       edit1.FondoColor := clGreen
end;

end.
