unit Unitrestaura_obleas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,globals;

type
  Trestaura_obleas = class(TForm)
    SpeedButton1: TSpeedButton;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  restaura_obleas: Trestaura_obleas;

implementation

uses Unitmensaje, Umodulo;

{$R *.dfm}

procedure Trestaura_obleas.SpeedButton1Click(Sender: TObject);
var oblea,sql,texto:string;

begin

 if trim(edit1.Text)='' then
 begin
   showmessage('Debe Ingresar la Oblea.');
  exit;
 end;



 mensaje.Show;
 APPLICATION.ProcessMessages;

 oblea:=trim(edit1.Text);


// globals.Conectar('CISA');


 modulo.sql_global.SQLConnection:=MyBD;

 modulo.sql_global.Close;
 modulo.sql_global.SQL.Clear;
 modulo.sql_global.SQL.Add(format(' SELECT COUNT(*)  as cantidad FROM TINSPECCION I , TFACTURAS  F    WHERE F.CODFACTU=I.CODFACTU   AND CODCOFAC IS NULL   AND  I.NUMOBLEA=''%S ''',[oblea]));
 modulo.sql_global.ExecSQL;
 modulo.sql_global.open;

 if modulo.sql_global.FieldByName('cantidad').asinteger <> 0 then
  begin
      mensaje.CLOSE;
      APPLICATION.ProcessMessages;
      showmessage('Esta oblea ya existe.');
      exit;
  end;


   mensaje.Show;
 APPLICATION.ProcessMessages;

 modulo.sql_global.Close;
 modulo.sql_global.SQL.Clear;
 modulo.sql_global.SQL.Add(format('SELECT COUNT(*) AS cantidad FROM  T_ERVTV_ANULAC WHERE NUMOBLEA=''%S ''',[oblea]));
 modulo.sql_global.ExecSQL;
 modulo.sql_global.open;

 if modulo.sql_global.FieldByName('cantidad').asinteger <> 0 then
  begin
      mensaje.CLOSE;
      APPLICATION.ProcessMessages;
      showmessage('La Oblea '+trim(oblea)+' se encuentra anulada.');
      exit;
  end;



   mensaje.Show;
 APPLICATION.ProcessMessages;

 modulo.sql_global.Close;
 modulo.sql_global.SQL.Clear;
 modulo.sql_global.SQL.Add(format('SELECT COUNT(*) as cantidad FROM T_ERVTV_INUTILIZ  I WHERE  I.OBLEAANT=''%S ''',[oblea]));
 modulo.sql_global.ExecSQL;
 modulo.sql_global.open;

 if modulo.sql_global.FieldByName('cantidad').asinteger <> 0 then
  begin
      mensaje.CLOSE;
      APPLICATION.ProcessMessages;
      showmessage('La Oblea '+trim(oblea)+' se encuentra inutilizada.');
      exit;
  end;





  mensaje.Show;
 APPLICATION.ProcessMessages;


 try
 modulo.sql_global.Close;
 modulo.sql_global.SQL.Clear;
 modulo.sql_global.SQL.Add(format('UPDATE  TOBLEAS  SET ESTADO=''S'', FECHA_CONSUMIDA=NULL, CODINSPE=NULL WHERE NUMOBLEA=''%S ''',[oblea]));
 modulo.sql_global.ExecSQL;
 mensaje.close;
 APPLICATION.ProcessMessages;
 texto:='Restaurar Oblea '+oblea;
 modulo.guardar_incidencia(texto);
  showmessage('Proceso Terminado.');
  EDIT1.Clear;
 Except
   mensaje.close;
   APPLICATION.ProcessMessages;
   showmessage('Se produjo un error.');
  end;

 CLOSE;
end;



end.
