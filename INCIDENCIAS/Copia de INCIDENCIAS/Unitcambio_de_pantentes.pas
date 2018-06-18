unit Unitcambio_de_pantentes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,globals;

type
  Tcambio_de_pantentes = class(TForm)
    SpeedButton1: TSpeedButton;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    GroupBox2: TGroupBox;
    Edit2: TEdit;
    GroupBox3: TGroupBox;
    Edit3: TEdit;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cambio_de_pantentes: Tcambio_de_pantentes;

implementation

uses Unitmensaje, Umodulo;

{$R *.dfm}

procedure Tcambio_de_pantentes.SpeedButton1Click(Sender: TObject);
var patenteN, patenteA, texto:string;
codinspe,codvehic:longint;
bandera:boolean;
existe:longint;
begin
bandera:=true;
 if trim(edit1.Text)='' then
 begin
   showmessage('Debe Ingresar la Patente Actual.');
  exit;
 end;

  if trim(edit2.Text)='' then
 begin
   showmessage('Debe Ingresar la Patente Nueva.');
  exit;
 end;

   if trim(edit3.Text)='' then
 begin
   showmessage('Debe Ingresar el C�digo de Inspecci�n.');
  exit;
 end;


 mensaje.Show;
 APPLICATION.ProcessMessages;

 patenteA:=trim(edit1.Text);
 patenteN:=trim(edit2.Text);
 codinspe:=strtoint(edit3.Text);

 
 globals.Conectar('CISA');

 

 modulo.sql_global.SQLConnection:=MyBD;




  mensaje.Show;
 APPLICATION.ProcessMessages;



  try
 modulo.sql_global.Close;
 modulo.sql_global.SQL.Clear;
 modulo.sql_global.SQL.Add(('select COUNT (*) as cantidad FROM tvehiculos where patenten = '+#39+trim(patenteN)+#39));
 modulo.sql_global.ExecSQL;
 modulo.sql_global.open;
 existe:=modulo.sql_global.FieldByName('cantidad').asinteger;


 if  existe = 0 then
 begin
 bandera:=true;
   modulo.sql_global.Close;
   modulo.sql_global.SQL.Clear;
   modulo.sql_global.SQL.Add(('UPDATE tvehiculos set patenten = '''+trim(patenteN)+''' WHERE patenten = '+#39+trim(patenteA)+#39));
   modulo.sql_global.ExecSQL;

    mensaje.close;
 APPLICATION.ProcessMessages;
   texto:='Cambia la patente  '+patenteA+' por la patente '+patenteN+' a la inspecci�n '+inttostr(codinspe);
  modulo.guardar_incidencia(texto);


  showmessage('Proceso Terminado.');
  EDIT1.Clear;
  EDIT2.Clear;
  EDIT3.Clear;


 END else
 begin
     bandera:=falsE;
 end;


 if existe > 0 then
  begin
   bandera:=true;
   modulo.sql_global.Close;
   modulo.sql_global.SQL.Clear;
   modulo.sql_global.SQL.Add(('SELECT codvehic FROM tvehiculos WHERE patenten = '+#39+trim(patenteN)+#39));
   modulo.sql_global.ExecSQL;
   modulo.sql_global.open;

   codvehic:=modulo.sql_global.FieldByName('codvehic').asinteger;
   modulo.sql_global.Close;
   modulo.sql_global.SQL.Clear;
   modulo.sql_global.SQL.Add(('UPDATE tinspeccion set codvehic = '+inttostr(codvehic)+' WHERE codinspe = '+inttostr(codinspe)));
   modulo.sql_global.ExecSQL;

       mensaje.close;
 APPLICATION.ProcessMessages;
  showmessage('Proceso Terminado.');
     texto:='Cambia la patente  '+patenteA+' por la patente '+patenteN+' a la inspecci�n '+inttostr(codinspe)+' con cod vehic: '+inttostr(codvehic);
  modulo.guardar_incidencia(texto);

  EDIT1.Clear;
  EDIT2.Clear;
  EDIT3.Clear;


END else
begin
    bandera:=falsE;
end;


if bandera=false then
begin
  mensaje.close;
  APPLICATION.ProcessMessages;
  showmessage('No existen datos para modificar.');
  EDIT1.Clear;
  EDIT2.Clear;
  EDIT3.Clear;
end;



 Except
   mensaje.close;
   APPLICATION.ProcessMessages;
   showmessage('Se produjo un error.');
  end;


  CLOSE;

 


end;

procedure Tcambio_de_pantentes.FormActivate(Sender: TObject);
begin
edit1.Clear;
edit2.Clear;
edit3.Clear;
end;

end.