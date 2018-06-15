unit Uver_plantillas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, RxMemDS, StdCtrls, Buttons, Grids, DBGrids, ComCtrls,UFUNCIONES,uconst,usuperregistry,
  ExtCtrls,UGLOBAL;

type
  Tver_plantillas = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    GroupBox2: TGroupBox;
    Edit2: TEdit;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    Label20: TLabel;
    Edit7: TEdit;
    Edit8: TEdit;
    GroupBox12: TGroupBox;
    Label21: TLabel;
    Edit9: TEdit;
    Edit10: TEdit;
    GroupBox8: TGroupBox;
    GroupBox7: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    GroupBox9: TGroupBox;
    GroupBox4: TGroupBox;
    DateTimePicker2: TDateTimePicker;
    GroupBox3: TGroupBox;
    DateTimePicker1: TDateTimePicker;
    GroupBox6: TGroupBox;
    DBGrid1: TDBGrid;
    BitBtn2: TBitBtn;
    genera_grilla: TRxMemoryData;
    genera_grillaField6: TStringField;
    genera_grillaField615: TStringField;
    genera_grillaField630: TStringField;
    genera_grillaField645: TStringField;
    genera_grillaField7: TStringField;
    genera_grillaField715: TStringField;
    genera_grillaField730: TStringField;
    genera_grillaField745: TStringField;
    genera_grillaField8: TStringField;
    genera_grillaField815: TStringField;
    genera_grillaField830: TStringField;
    genera_grillaField845: TStringField;
    genera_grillaField9: TStringField;
    genera_grillaField915: TStringField;
    genera_grillaField930: TStringField;
    genera_grillaField945: TStringField;
    genera_grillaField10: TStringField;
    genera_grillaField1015: TStringField;
    genera_grillaField1030: TStringField;
    genera_grillaField1045: TStringField;
    genera_grillaField11: TStringField;
    genera_grillaField1115: TStringField;
    genera_grillaField1130: TStringField;
    genera_grillaField1145: TStringField;
    genera_grillaField12: TStringField;
    genera_grillaField1215: TStringField;
    genera_grillaField1230: TStringField;
    genera_grillaField1245: TStringField;
    genera_grillaField13: TStringField;
    genera_grillaField1315: TStringField;
    genera_grillaField1330: TStringField;
    genera_grillaField1345: TStringField;
    genera_grillaField14: TStringField;
    genera_grillaField1415: TStringField;
    genera_grillaField1430: TStringField;
    genera_grillaField1445: TStringField;
    genera_grillaField15: TStringField;
    genera_grillaField1515: TStringField;
    genera_grillaField1530: TStringField;
    genera_grillaField1545: TStringField;
    genera_grillaField16: TStringField;
    genera_grillaField1615: TStringField;
    genera_grillaField1630: TStringField;
    genera_grillaField1645: TStringField;
    genera_grillaField17: TStringField;
    genera_grillaField1715: TStringField;
    genera_grillaField1730: TStringField;
    genera_grillaField1745: TStringField;
    genera_grillaField18: TStringField;
    genera_grillaField1815: TStringField;
    genera_grillaField1830: TStringField;
    genera_grillaField1845: TStringField;
    genera_grillaField19: TStringField;
    genera_grillaField1915: TStringField;
    genera_grillaField1930: TStringField;
    genera_grillaField1945: TStringField;
    genera_grillaField20: TStringField;
    genera_grillaField2015: TStringField;
    genera_grillaField2030: TStringField;
    genera_grillaField2045: TStringField;
    genera_grillaField21: TStringField;
    genera_grillaField2115: TStringField;
    genera_grillaField2130: TStringField;
    genera_grillaField2145: TStringField;
    genera_grillaField22: TStringField;
    genera_grillaField2215: TStringField;
    genera_grillaField2230: TStringField;
    genera_grillaField2245: TStringField;
    genera_grillaField23: TStringField;
    genera_grillaField2315: TStringField;
    genera_grillaField2330: TStringField;
    genera_grillaField2345: TStringField;
    DataSource1: TDataSource;
    autos_hora: TRxMemoryData;
    autos_horahora: TStringField;
    autos_horacantidad: TIntegerField;
    GroupBox13: TGroupBox;
    DBGrid2: TDBGrid;
    grilla_acucitas: TRxMemoryData;
    grilla_acucitasStringField600: TStringField;
    grilla_acucitasStringField615: TStringField;
    grilla_acucitasStringField630: TStringField;
    grilla_acucitasStringField645: TStringField;
    grilla_acucitasStringField700: TStringField;
    grilla_acucitasStringField715: TStringField;
    grilla_acucitasStringField730: TStringField;
    grilla_acucitasStringField745: TStringField;
    grilla_acucitasStringField800: TStringField;
    grilla_acucitasStringField815: TStringField;
    grilla_acucitasStringField830: TStringField;
    grilla_acucitasStringField845: TStringField;
    grilla_acucitasStringField900: TStringField;
    grilla_acucitasStringField915: TStringField;
    grilla_acucitasStringField930: TStringField;
    grilla_acucitasStringField945: TStringField;
    grilla_acucitasStringField1000: TStringField;
    grilla_acucitasStringField1015: TStringField;
    grilla_acucitasStringField1030: TStringField;
    grilla_acucitasStringField1045: TStringField;
    grilla_acucitasStringField1100: TStringField;
    grilla_acucitasStringField1115: TStringField;
    grilla_acucitasStringField1130: TStringField;
    grilla_acucitasStringField1145: TStringField;
    grilla_acucitasStringField1200: TStringField;
    grilla_acucitasStringField1215: TStringField;
    grilla_acucitasStringField1230: TStringField;
    grilla_acucitasStringField1245: TStringField;
    grilla_acucitasStringField1300: TStringField;
    grilla_acucitasStringField1315: TStringField;
    grilla_acucitasStringField1330: TStringField;
    grilla_acucitasStringField1345: TStringField;
    grilla_acucitasStringField1400: TStringField;
    grilla_acucitasStringField1415: TStringField;
    grilla_acucitasStringField1430: TStringField;
    grilla_acucitasStringField1445: TStringField;
    grilla_acucitasStringField1500: TStringField;
    grilla_acucitasStringField1515: TStringField;
    grilla_acucitasStringField1530: TStringField;
    grilla_acucitasStringField1545: TStringField;
    grilla_acucitasStringField1600: TStringField;
    grilla_acucitasStringField1615: TStringField;
    grilla_acucitasStringField1630: TStringField;
    grilla_acucitasStringField1645: TStringField;
    grilla_acucitasStringField1700: TStringField;
    grilla_acucitasStringField1715: TStringField;
    grilla_acucitasStringField1730: TStringField;
    grilla_acucitasStringField1745: TStringField;
    grilla_acucitasStringField1800: TStringField;
    grilla_acucitasStringField1815: TStringField;
    grilla_acucitasStringField1830: TStringField;
    grilla_acucitasStringField1845: TStringField;
    grilla_acucitasStringField1900: TStringField;
    grilla_acucitasStringField1915: TStringField;
    grilla_acucitasStringField1930: TStringField;
    grilla_acucitasStringField1945: TStringField;
    grilla_acucitasStringField2000: TStringField;
    grilla_acucitasStringField2015: TStringField;
    grilla_acucitasStringField2030: TStringField;
    grilla_acucitasStringField2045: TStringField;
    grilla_acucitasStringField2100: TStringField;
    grilla_acucitasStringField2115: TStringField;
    grilla_acucitasStringField2130: TStringField;
    grilla_acucitasStringField2145: TStringField;
    grilla_acucitasStringField2200: TStringField;
    grilla_acucitasStringField2215: TStringField;
    grilla_acucitasStringField2230: TStringField;
    grilla_acucitasStringField2245: TStringField;
    grilla_acucitasStringField2300: TStringField;
    grilla_acucitasStringField2315: TStringField;
    grilla_acucitasStringField2330: TStringField;
    grilla_acucitasStringField2345: TStringField;
    dt_acucitas: TDataSource;
    grilla_acucitasfecha: TStringField;
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ver_plantillas: Tver_plantillas;

implementation

uses Uselecciona_plantilla;

{$R *.dfm}

procedure Tver_plantillas.SpeedButton1Click(Sender: TObject);
begin
uglobal.OPCION_FORMULARIO:='VER';
selecciona_plantilla.showmodal;
end;

procedure Tver_plantillas.BitBtn2Click(Sender: TObject);
begin
edit3.Clear;
edit4.Clear;
edit5.Clear;
edit6.Clear;
edit7.Clear;
edit8.Clear;
edit9.Clear;
edit10.Clear;


CLOSE;
end;

procedure Tver_plantillas.FormActivate(Sender: TObject);
VAR TF:TFUNCION;
empre:string;
planta:string;
begin
tf:=tfuncion.Create;
//empre:=tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Empresa');
datetimepicker1.DateTime:=now;
datetimepicker2.DateTime:=now;

with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(APPLICATION_KEY) then
      Begin
     empre:=ReadString('Empresa');
      planta:=ReadString('Planta');
      //actual:=ReadString('Conex_actual');
      end;
  Finally
    free;
  end;



edit1.Text:=trim(tf.busca_nombr_empresa(empre));

//planta:=tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');
edit2.Text:=trim(tf.busca_nombr_centro(planta));
self.genera_grilla.Close;
self.grilla_acucitas.Close;
tf.Free;
end;

procedure Tver_plantillas.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
edit3.Clear;
edit4.Clear;
edit5.Clear;
edit6.Clear;
edit7.Clear;
edit8.Clear;
edit9.Clear;
edit10.Clear;

end;

end.
