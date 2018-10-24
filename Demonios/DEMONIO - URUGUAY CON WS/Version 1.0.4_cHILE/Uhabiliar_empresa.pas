unit Uhabiliar_empresa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, DBCtrls, Uregistro_window,umodulo,Registry;

type
  Thabiliar_empresa = class(TForm)
    DBLookupComboBox1: TDBLookupComboBox;
    SpeedButton1: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  habiliar_empresa: Thabiliar_empresa;

implementation

uses UPRINCIPAL;

{$R *.dfm}

procedure Thabiliar_empresa.FormActivate(Sender: TObject);
begin
modulo.sql_habilita_empresa.ExecSQL;
modulo.sql_habilita_empresa.Open;
end;

procedure Thabiliar_empresa.SpeedButton1Click(Sender: TObject);
var empresa,nombre:string;

cr:tregistro;
begin
empresa:=trim(DBLookupComboBox1.KeyValue);
nombre:=trim(DBLookupComboBox1.Text);
form1.StatusBar1.Panels[3].Text:=nombre;
cr:=tregistro.Create;


cr.SetRegistryData(HKEY_LOCAL_MACHINE,'\Software\TurnosOnline','codigo_empresa',rdString,empresa);
cr.SetRegistryData(HKEY_LOCAL_MACHINE,'\Software\TurnosOnline','empresa',rdString,nombre);

cr.Free;


end;

end.
