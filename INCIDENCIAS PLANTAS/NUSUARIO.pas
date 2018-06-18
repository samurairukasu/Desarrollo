unit NUsuario;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, SysUtils, ExtCtrls, Dialogs, UCEdit, Messages, Acceso1;

type
  TNUsuarioDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edNombre: TColorEdit;
    edIdentificador: TColorEdit;
    edInfo: TColorEdit;
    edClave1: TColorEdit;
    edClave2: TColorEdit;
    Label5: TLabel;
    edClCambios1: TColorEdit;
    edClCambios2: TColorEdit;
    procedure SoloNum(Sender: TObject; var Key: Char);
    procedure OKBtnClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    IDU: Integer;
    Nombre, Clave, Info, ClaveCambios: String;
    Error : Boolean;
    { Private declarations }
  public
    Constructor Create(Owner: TComponent; Op,UID:Integer; Nomb,Inf,Cla,ClaCb:String);
    Procedure ObtenerDatos(Var UID: Integer; Var Nomb,Cl,Inf,ClCambios: String);
    { Public declarations }
  end;

var
  NUsuarioDlg: TNUsuarioDlg;

implementation

{$R *.DFM}

uses
   ugacceso,
   usagctte;

Constructor TNUsuarioDlg.Create(Owner: TComponent; Op,UID: Integer; Nomb,Inf,Cla,ClaCb:String);
var aux: tPasswordInspector;
Begin
    Inherited Create(Owner);
    IDU := UID;
    Nombre := Nomb;
    Clave := Cla;
    ClaveCambios := ClaCb;
    Info := Inf;
    Error := True;
    DecodificarPassword(uid,clave,aux);
    edClave1.text := aux;
    edClave2.Text := aux;
    DecodificarPassword(uid,claveCambios,aux);
    edClCambios1.Text := aux;
    edClCambios2.Text := aux;
    edNombre.Text := Nombre;
    edIdentificador.Text := IntToStr(IDU);
    edInfo.Text := Info;
    if (Op = 1) Then edIdentificador.ReadOnly := True;
End;

Procedure TNUsuarioDlg.ObtenerDatos(Var UID: Integer; Var Nomb,Cl,Inf,ClCambios: String);  
Begin
    if not Error Then
      Begin
        UID := IDU;
        Nomb := Nombre;
        Cl := Clave;
        ClCambios := ClaveCambios; 
        Inf := Info;
      End
    Else
      UID := -1;
End;

procedure TNUsuarioDlg.SoloNum(Sender: TObject; var Key: Char);
begin
    if ((key < '0') Or (Key > '9')) And (Key <> #8) Then
        Key := #0;
end;

procedure TNUsuarioDlg.OKBtnClick(Sender: TObject);
begin
    Error := FALSE;

    If (edNombre.Text = '') or (edIdentificador.Text = '') or (edInfo.Text = '') or
       (edClave1.Text = '') or (edClave2.Text = '') Then
      Begin
       ShowMessage('Debe rellenar todos los campos');
       Error := True;
      End
    Else
      Begin
        Nombre := edNombre.Text;
        IDU := StrToInt(edIdentificador.Text);
        Info := edInfo.Text;
        if (edClave1.Text = edClave2.Text)  Then
            Clave := edClave1.Text
        Else
          Begin
            Error := True;
            edClave1.Text := '';
            edClave2.Text := '';
            ShowMessage('Clave Incorrecta');
          End;
        if (edClCambios1.Text = edClCambios2.Text)  Then
            ClaveCambios := edClCambios1.Text
        Else
          Begin
            Error := True;
            edClCambios1.Text := '';
            edClCambios2.Text := '';
            ShowMessage('Clave para Cambios Incorrecta');
          End;

        if (edClCambios1.Text = edClave1.text)  Then
        Begin
            Error := True;
            ShowMessage('Las claves para acceso al SAG y para cambios NO pueden ser iguales');
        End;

        if (length(edClAVE1.text) < 6) or ((edCLCambios1.text <> '') and (length(edCLCambios1.text) < 6)) then
        begin
            error := true;
            ShowMessage('Las claves deben tener una longitud igual o mayor a 6 caracteres');
        end;
        
      End;
   if not Error Then
      ModalResult := mrOK
   Else
      ModalResult := 0;
end;


procedure TNUsuarioDlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;

    if Key = #18 then
      if PasswordUser = MASTER_KEY then
      begin
        if edClave1.PasswordChar = '*' then
        begin
          edClave1.PasswordChar := #0;
          edClCambios1.PasswordChar := #0;
        end
        else
        begin
          edClave1.PasswordChar := '*';
          edClCambios1.PasswordChar := '*';
        end;
      end;

end;

procedure TNUsuarioDlg.FormShow(Sender: TObject);
begin
    edNombre.setfocus;

    if edIdentificador.readonly then
       edIdentificador.FondoColor := clFuchsia
    else
       edIdentificador.FondoColor := clGreen
end;


end.


