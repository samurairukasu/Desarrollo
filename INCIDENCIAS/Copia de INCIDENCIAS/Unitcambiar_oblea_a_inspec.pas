unit Unitcambiar_oblea_a_inspec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,GLOBALS;

type
  Tcambiar_oblea_a_inspec = class(TForm)
    SpeedButton1: TSpeedButton;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    GroupBox2: TGroupBox;
    Edit2: TEdit;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cambiar_oblea_a_inspec: Tcambiar_oblea_a_inspec;

implementation

uses Unitmensaje, Umodulo;

{$R *.dfm}

procedure Tcambiar_oblea_a_inspec.SpeedButton1Click(Sender: TObject);
var oblea,texto:string;
codinspe:longint;
begin
 if trim(edit1.Text)='' then
 begin
   showmessage('Debe Ingresar la Oblea.');
  exit;
 end;

  if trim(edit2.Text)='' then
 begin
   showmessage('Debe Ingresar el C�digo de Inspecci�n.');
  exit;
 end;

 mensaje.Show;
 APPLICATION.ProcessMessages;

 oblea:=trim(edit1.Text);
 codinspe:=STRTOINT(edit2.Text);

 globals.Conectar('CISA');

 

 modulo.sql_global.SQLConnection:=MyBD;




  mensaje.Show;
 APPLICATION.ProcessMessages;


 try
 modulo.sql_global.Close;
 modulo.sql_global.SQL.Clear;
 modulo.sql_global.SQL.Add(format('UPDATE  TOBLEAS  SET ESTADO=''C'', FECHA_CONSUMIDA=SYSDATE, CODINSPE='+inttostr(codinspe)+', EJERCICI=to_char(SYSDATE,''YYYY'') WHERE NUMOBLEA=''%S ''',[oblea]));
 modulo.sql_global.ExecSQL;



 modulo.sql_global.Close;
 modulo.sql_global.SQL.Clear;
 modulo.sql_global.SQL.Add(format('UPDATE  TINSPECCION   SET NUMOBLEA=''%S ''  WHERE  CODINSPE='+inttostr(codinspe),[oblea]));
 modulo.sql_global.ExecSQL;

 mensaje.close;
 APPLICATION.ProcessMessages;
  texto:='Cambia o asigna la oblea '+oblea+' a la inspecci�n '+inttostr(codinspe);
  modulo.guardar_incidencia(texto);

  showmessage('Proceso Terminado.');
  EDIT1.Clear;
  EDIT2.Clear;
 Except
   mensaje.close;
   APPLICATION.ProcessMessages;
   showmessage('Se produjo un error.');
  end;


  CLOSE;
end;

end.
