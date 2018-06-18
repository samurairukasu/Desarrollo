unit Unitcambio_de_dni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls,globals;

type
  Tcambio_de_dni = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    GroupBox2: TGroupBox;
    Edit2: TEdit;
    SpeedButton1: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cambio_de_dni: Tcambio_de_dni;

implementation

uses Unitmensaje, Umodulo;

{$R *.dfm}

procedure Tcambio_de_dni.SpeedButton1Click(Sender: TObject);
var dniN,dniA,texto:string;
codinspe,codvehic:longint;

existe:longint;
begin
 if trim(edit1.Text)='' then
 begin
   showmessage('Debe Ingresar el DNI actual.');
  exit;
 end;

  if trim(edit2.Text)='' then
 begin
   showmessage('Debe Ingresar el DNI Nuevo.');
  exit;
 end;



 mensaje.Show;
 APPLICATION.ProcessMessages;

 dniA:=trim(edit1.Text);
 dniN:=trim(edit2.Text);


 
 globals.Conectar('CISA');



 modulo.sql_global.SQLConnection:=MyBD;




  mensaje.Show;
 APPLICATION.ProcessMessages;

  try
 modulo.sql_global.Close;
 modulo.sql_global.SQL.Clear;
 modulo.sql_global.SQL.Add(format('SELECT COUNT(*)  as cantidad FROM tclientes  WHERE document=''%S ''',[dniN]));
 modulo.sql_global.ExecSQL;
 modulo.sql_global.open;
 existe:=modulo.sql_global.FieldByName('cantidad').asinteger;


IF existe =0 THEN
begin

 modulo.sql_global.Close;
 modulo.sql_global.SQL.Clear;
 modulo.sql_global.SQL.Add(format('update tclientes  set document ='''+trim(dniN)+'''  WHERE document=''%S ''',[dniA]));
 modulo.sql_global.ExecSQL;
 
  mensaje.close;
 APPLICATION.ProcessMessages;
   texto:='Cambia de DNI  '+dniA+' por  el  DNI '+dniN;
  modulo.guardar_incidencia(texto);


  showmessage('Proceso Terminado.');
  EDIT1.Clear;
  EDIT2.Clear;
END else
begin
     mensaje.close;
 APPLICATION.ProcessMessages;
  showmessage('No exsiste ningún cliente con el nro de documento: '+trim(dnia));

end;






 Except
   mensaje.close;
   APPLICATION.ProcessMessages;
   showmessage('Se produjo un error.');
  end;


  CLOSE

end;

procedure Tcambio_de_dni.FormActivate(Sender: TObject);
begin
edit1.Clear;
edit2.Clear;
end;

end.
