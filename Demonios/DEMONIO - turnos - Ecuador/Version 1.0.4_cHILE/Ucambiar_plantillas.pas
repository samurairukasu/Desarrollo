unit Ucambiar_plantillas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,ufunciones,Registry,uconst,usuperregistry;



type
  Tcambiar_plantillas = class(TForm)
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    BitBtn1: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cambiar_plantillas: Tcambiar_plantillas;

implementation

uses UPRINCIPAL;

{$R *.dfm}

procedure Tcambiar_plantillas.FormActivate(Sender: TObject);
var tf:tfuncion;
begin
{
tf:=tfuncion.Create;
  if tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Virtual')='1' then
     begin
      combobox1.Visible:=true;
      combobox1.Clear;
      combobox1.Items.Add('LIVIANOS');
      //combobox1.Items.Add(tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Base_Centro'));
      combobox1.Items.Add(tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Nombre_Virtual'));
      combobox1.ItemIndex:=0;
     end
       else
     begin
        combobox1.Visible:=false;
     end;

tf.Free
}
end;

procedure Tcambiar_plantillas.BitBtn1Click(Sender: TObject);
VAR tf:tfuncion;
aux:string;
begin
tf:=tfuncion.Create;
IF COMBOBOX1.ItemIndex=0 THEN
BEGIN
//aux:=tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta_Liviano');
with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(APPLICATION_KEY) then
      Begin
     aux:=ReadString('Planta_Liviano');

      //actual:=ReadString('Conex_actual');
      end;
  Finally
    free;
  end;



FORM1.Panel2.Caption:='LIVIANOS';
tf.SetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas','Conex_actual', rdString, 'L');
tf.SetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas','Planta', rdString, aux);





END;


IF COMBOBOX1.ItemIndex=1 THEN
BEGIN
 FORM1.Panel2.Caption:='PESADOS';
//aux:=tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta_Pesado');

with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(APPLICATION_KEY) then
      Begin
     aux:=ReadString('Planta_Pesado');

      end;
  Finally
    free;
  end;



tf.SetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas','Conex_actual', rdString, 'P');
tf.SetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas','Planta', rdString, aux);
END;

form1.caption:='Administración de Reservas de Turnos OnLine.  [ '+trim(tf.busca_nombr_centro(aux)+' ] ');

tf.Free;
close;
end;

end.
