unit Unitcambiar_centro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,ufunciones,usuperregistry,Registry,uglobal;

type
  Tcambiar_centro = class(TForm)
    ComboBox1: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cambiar_centro: Tcambiar_centro;

implementation

uses Umodulo, UPRINCIPAL;

{$R *.dfm}

procedure Tcambiar_centro.BitBtn2Click(Sender: TObject);
begin
close;
end;

procedure Tcambiar_centro.FormActivate(Sender: TObject);
var i:longint;
begin
modulo.sql_global.Close;
modulo.sql_global.SQL.Clear;
modulo.sql_global.SQL.Add('select centro, nombre from centros order by nombre');
modulo.sql_global.ExecSQL;
modulo.sql_global.Open;
combobox1.Clear;
for i:=1 to modulo.sql_global.RecordCount do
begin

    combobox1.Items.Add(trim(modulo.sql_global.Fields[0].asstring)+' - '+trim(modulo.sql_global.Fields[1].asstring)) ;

    modulo.sql_global.Next;
end;


end;

procedure Tcambiar_centro.BitBtn1Click(Sender: TObject);
var codigo:string;
posi:longint;
tf:tfuncion;
begin
posi:=pos('-',trim(combobox1.Text));
codigo:=trim(copy(trim(combobox1.Text),0,posi-1));

 tf:=tfuncion.Create;




tf.SetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas','Planta', rdString, codigo);
tf.SetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas','Planta_Liviano', rdString, codigo);
tf.SetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas','Planta_Pesado', rdString, codigo);



uglobal.ID_PLANTA:=tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');
form1.caption:='Administración de Reservas de Turnos OnLine.  [ '+trim(tf.busca_nombr_centro(uglobal.ID_PLANTA))+' ]';
form1.label4.Caption:=inttostr(tf.devuelve_cantidad_turnos_fecha(datetostr(date)));


tf.Free;
end;

end.
