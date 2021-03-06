unit Unit2borrar_turno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  Tborrar_turno = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    DateTimePicker1: TDateTimePicker;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  borrar_turno: Tborrar_turno;

implementation

uses Umodulo;

{$R *.dfm}

procedure Tborrar_turno.BitBtn2Click(Sender: TObject);
begin
close;
end;

procedure Tborrar_turno.FormActivate(Sender: TObject);
begin
edit1.Clear;
datetimepicker1.DateTime:=now;
end;

procedure Tborrar_turno.BitBtn1Click(Sender: TObject);
var patente,fecha,hora,h1,h2,DP,centro,sql:string;
numero,posi,idplantilla:longint;
begin

if trim(edit1.Text)=''  then
begin
showmessage('Debe ingresar la patente.');
exit;

end;
 patente:=trim(edit1.Text);
 fecha:=datetostr(datetimepicker1.DateTime);

modulo.sql_global.Close;
modulo.sql_global.SQL.Clear;
modulo.sql_global.SQL.Add('select numero, hora, centro  from reserva where patente='+#39+trim(patente)+#39+' and fecha = CONVERT(DATETIME,'+#39+trim(fecha)+#39+',103)');
modulo.sql_global.ExecSQL;
modulo.sql_global.Open;
if modulo.sql_global.RecordCount > 0 then
begin

numero:=modulo.sql_global.fields[0].AsInteger;
hora:=trim(modulo.sql_global.fields[1].Asstring);
centro:=trim(modulo.sql_global.fields[2].Asstring);


posi:=pos(':',hora);
h1:=trim(copy(hora,0,posi-1));
h2:=trim(copy(hora,posi+1,length(hora)));
hora:=h1+h2;

dp:='DP'+HORA;


modulo.sql_global.Close;
modulo.sql_global.SQL.Clear;
modulo.sql_global.SQL.Add('select idplantilla  from acucitas where centro='+#39+trim(centro)+#39+' and fecha = CONVERT(DATETIME,'+#39+trim(fecha)+#39+',103)');
modulo.sql_global.ExecSQL;
modulo.sql_global.Open;
if modulo.sql_global.RecordCount = 0 then
begin
showmessage('No se ecnontr� la hora del turno para la patente: '+trim(patente));
exit;

end;

idplantilla:=modulo.sql_global.fields[0].AsInteger;

modulo.conexion.BeginTrans;
try

 // actualiza en acucitas sumando uno mas al campo hora.
 //*****************************************************
sql:='update acucitas  set '+dp+'='+dp+' + 1  where idplantilla ='+inttostr(idplantilla) ;
modulo.sql_global.Close;
modulo.sql_global.SQL.Clear;
modulo.sql_global.SQL.Add(sql);
modulo.sql_global.ExecSQL;
 //****************************************************


modulo.sql_global.Close;
modulo.sql_global.SQL.Clear;
modulo.sql_global.SQL.Add('delete  from reserva where numero='+inttostr(numero));
modulo.sql_global.ExecSQL;


modulo.conexion.CommitTrans;
showmessage('Se ha eliminado correntamente el turno para la patente: '+trim(patente));
exit;


except
 modulo.conexion.RollbackTrans;
 showmessage('Se produjo un error al intentar borrar el turno para la patente: '+trim(patente));
end;

end else
begin
    showmessage('La Patente : '+trim(patente)+' no tiene una reserva realizada para la fecha : '+trim(fecha));
    edit1.SetFocus;
end;

end;

end.
