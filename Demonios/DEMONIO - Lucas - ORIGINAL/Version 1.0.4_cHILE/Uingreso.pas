unit Uingreso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons,Usuarios,uglobal, WinSkinData,ufunciones,USuperRegistry,UCONST;

type
  Tingreso_al_sistema = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    SkinData1: TSkinData;
    Image1: TImage;
    Timer1: TTimer;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ingreso_al_sistema: Tingreso_al_sistema;

implementation

uses UPRINCIPAL, Umodulo;

{$R *.dfm}

procedure Tingreso_al_sistema.BitBtn2Click(Sender: TObject);
begin
modulo.conexion.Connected:=false;
modulo.conexion.Close;
application.Terminate;
end;

procedure Tingreso_al_sistema.BitBtn1Click(Sender: TObject);
var cu:tusuarios;
tf:TFUNCION;
BASE,Virtua,actual:STRING;
con:string;
begin
tf:=TFUNCION.Create;


with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(APPLICATION_KEY) then
      Begin
      BASE:=ReadString('Base_Centro');
      virtua:=ReadString('Virtual');
      actual:=ReadString('Conex_actual');
      end;
  Finally
    free;
  end;



tf.conexion_virtual(BASE);

  {

   IF   tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Virtual')='0' then
           begin
           form1.Panel2.Caption:='LIVIANOS/PESADOS';
           end else
           begin
               IF   tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Conex_actual')='L' then
                      form1.Panel2.Caption:='LIVIANOS';

                IF   tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Conex_actual')='P' then
                      form1.Panel2.Caption:='PESADOS';

           end;

 }


    IF   virtua='0' then
           begin
           form1.Panel2.Caption:='LIVIANOS/PESADOS';
           end else
           begin
               IF   actual='L' then
                      form1.Panel2.Caption:='LIVIANOS';

                IF   actual='P' then
                      form1.Panel2.Caption:='PESADOS';

           end;

tf.Free ;





cu:=tusuarios.Create;
 if CU.verificar_usuario(EDIT1.Text,EDIT2.Text)=true then
     begin
     Form1.StatusBar1.Panels[2].Text:='Usuario: '+uglobal.USUARIO_CONECTADO;

      form1.ShowModal;
      close;
     end;
cu.Free;

end;

procedure Tingreso_al_sistema.Edit1KeyPress(Sender: TObject;
  var Key: Char);
begin
if key=#13 then
begin
  edit2.SelectAll;
  edit2.SetFocus;

end;

end;

procedure Tingreso_al_sistema.Edit2KeyPress(Sender: TObject;
  var Key: Char);
begin
if key=#13 then
bitbtn1.SetFocus;


end;

procedure Tingreso_al_sistema.FormActivate(Sender: TObject);
var tf:tfuncion;
begin
 edit1.Clear;
 edit2.Clear;
 //combobox1.Visible:=false;




end;

procedure Tingreso_al_sistema.Timer1Timer(Sender: TObject);
begin

if timer1.Interval=3000 then
begin
 timer1.Enabled:=false;
 bitbtn1.Visible:=true;
 bitbtn2.Visible:=true;
 groupbox1.Visible:=true;
 image1.Visible:=falsE;
 edit1.Clear;
 edit2.Clear;
 edit1.SetFocus;
 self.Caption:='Ingreso al Sistema';
end;



end;

end.
