unit Useleccione_fecha_para_reporte;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls,ufunciones,uglobal,uconst,usuperregistry;

type
  Tseleccione_fecha_para_reporte = class(TForm)
    GroupBox1: TGroupBox;
    DateTimePicker1: TDateTimePicker;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  seleccione_fecha_para_reporte: Tseleccione_fecha_para_reporte;

implementation

uses Uimprimir_turnos, Umodulo;

{$R *.dfm}

procedure Tseleccione_fecha_para_reporte.BitBtn1Click(Sender: TObject);
var tf:tfuncion;
path:string;
begin
tf:=tfuncion.Create;
//uglobal.ID_EMPRESA:=tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Empresa');
//uglobal.ID_PLANTA:=tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');


with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(APPLICATION_KEY) then
      Begin
     uglobal.ID_EMPRESA:=ReadString('Empresa');
      uglobal.ID_PLANTA:=ReadString('Planta');
      //actual:=ReadString('Conex_actual');
      end;
  Finally
    free;
  end;




imprimir_turnos.QRLabel11.Caption:=tf.busca_nombr_centro(uglobal.ID_PLANTA);

tf.genera_reporte_de_turnos(datetostr(datetimepicker1.DateTime));

imprimir_turnos.QRLabel9.Caption:=inttostr(modulo.sql_listado.RecordCount);


tf.Free;

 if uglobal.ID_EMPRESA='0003' then
    begin
    path := GetCurrentDir+'/Logo Applus Argentina.bmp' ;
    imprimir_turnos.QRImage1.Picture.LoadFromFile(path);
    end;

    if uglobal.ID_EMPRESA='0001' then
    begin
    path := GetCurrentDir+'/Logo Applus Chile-3.bmp' ;
    imprimir_turnos.QRImage1.Picture.LoadFromFile(path);
    end;

imprimir_turnos.QRLabel3.Caption:=datetostr(datetimepicker1.DateTime);

imprimir_turnos.QuickRep1.Prepare;
imprimir_turnos.QuickRep1.Preview;
end;

end.
