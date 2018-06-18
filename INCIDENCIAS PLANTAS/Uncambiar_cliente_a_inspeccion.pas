unit Uncambiar_cliente_a_inspeccion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,globals, StdCtrls, Buttons;

type
  Tcambiar_cliente_a_inspeccion = class(TForm)
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
  cambiar_cliente_a_inspeccion: Tcambiar_cliente_a_inspeccion;

implementation

uses Unitmensaje, Umodulo;

{$R *.dfm}

procedure Tcambiar_cliente_a_inspeccion.SpeedButton1Click(Sender: TObject);
var dni,texto:string;
codinspe,codcliente:longint;

existe:longint;
begin
 if trim(edit1.Text)='' then
 begin
   showmessage('Debe Ingresar el DNI.');
  exit;
 end;

  if trim(edit2.Text)='' then
 begin
   showmessage('Debe Ingresar el Cod Inspección.');
  exit;
 end;



 mensaje.Show;
 APPLICATION.ProcessMessages;

 dni:=trim(edit1.Text);
 codinspe:=strtoint(edit2.Text);



 //globals.Conectar('CISA');



 modulo.sql_global.SQLConnection:=MyBD;




  mensaje.Show;
 APPLICATION.ProcessMessages;


   try
 modulo.sql_global.Close;
 modulo.sql_global.SQL.Clear;
 modulo.sql_global.SQL.Add(format('SELECT COUNT(*) as cantidad FROM tclientes   WHERE document=''%S''',[dni]));
 modulo.sql_global.ExecSQL;
 modulo.sql_global.open;
 existe:=modulo.sql_global.FieldByName('cantidad').asinteger;


IF existe > 0 THEN
begin

 modulo.sql_global.Close;
 modulo.sql_global.SQL.Clear;
 modulo.sql_global.SQL.Add(format('SELECT codclien as codigo FROM tclientes   WHERE document=''%S''',[dni]));
 modulo.sql_global.ExecSQL;
 modulo.sql_global.open;
 codcliente:=modulo.sql_global.fieldbyname('codigo').AsInteger;



 modulo.sql_global.Close;
 modulo.sql_global.SQL.Clear;
 modulo.sql_global.SQL.Add('UPDATE tinspeccion  SET  CODCLCON='+inttostr(codcliente)+', CODCLPRO='+inttostr(codcliente)+',  CODCLTEN='+inttostr(codcliente)+'   WHERE codinspe='+inttostr(codinspe) );
 modulo.sql_global.ExecSQL;



  modulo.sql_global.Close;
 modulo.sql_global.SQL.Clear;
 modulo.sql_global.SQL.Add('UPDATE tfacturas  SET codclien='+inttostr(codcliente)+' WHERE codfactu= ( SELECT codfactu FROM  tinspeccion WHERE codinspe='+inttostr(codinspe)+')');
 modulo.sql_global.ExecSQL;


     mensaje.close;
 APPLICATION.ProcessMessages;

    texto:='Cambia  el Cliente a la Inspeccion.  DNI Nuevo Cliente  '+dni+'  Cod Client nuevo: '+inttostr(codcliente)+' codinspe='+inttostr(codinspe) ;
  modulo.guardar_incidencia(texto);



  showmessage('Proceso Terminado.');
  EDIT1.Clear;
  EDIT2.Clear;

END else
begin
     mensaje.close;
 APPLICATION.ProcessMessages;
  showmessage('No exsiste ningún cliente con el nro de documento: '+trim(dni));

end;










 Except
   mensaje.close;
   APPLICATION.ProcessMessages;
   showmessage('Se produjo un error.');
  end;


  CLOSE


end;

end.
