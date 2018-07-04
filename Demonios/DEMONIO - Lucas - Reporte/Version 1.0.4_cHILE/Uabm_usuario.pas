unit Uabm_usuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,usuarios;

type
  Tabm_usuario = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    codigo_usuario:longint;
  end;

var
  abm_usuario: Tabm_usuario;

implementation

{$R *.dfm}

procedure Tabm_usuario.BitBtn1Click(Sender: TObject);
var cu:tusuarios;
begin
cu:=tusuarios.Create;

  if trim(edit1.Text)='' then
     begin
      showmessage('Debe ingresar el Nombre y Apellido.');
      edit1.SetFocus;
      exit;
     end;


     if trim(edit2.Text)='' then
     begin
      showmessage('Debe ingresar el Nombre de Usuario.');
      edit2.SetFocus;
      exit;
     end;


     if trim(edit3.Text)='' then
     begin
      showmessage('Debe ingresar la Contraseña.');
      edit3.SetFocus;
      exit;
     end;



  if  abm_usuario.Tag=1 then
      begin
        if cu.crear_usuario(edit1.Text,edit2.Text,edit3.Text) then
       begin
          cu.cargar_usuarios_en_grilla;
          cu.Free;
          close;
          end;
      end;

  if  abm_usuario.Tag=2 then
      begin
        if cu.modifica_usuario(codigo_usuario,edit1.Text,edit2.Text,edit3.Text) then
         begin
          cu.cargar_usuarios_en_grilla;
          cu.Free;
          close;
          end;
      end;

  if  abm_usuario.Tag=3 then
      begin
       if cu.eliminar_usuario(codigo_usuario) then
          begin
          cu.cargar_usuarios_en_grilla;
          cu.Free;
          close;
          end;

      end;






end;

procedure Tabm_usuario.BitBtn2Click(Sender: TObject);
begin
close;
end;

end.
