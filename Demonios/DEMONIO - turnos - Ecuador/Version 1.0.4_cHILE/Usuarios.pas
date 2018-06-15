unit Usuarios;

interface

uses Umodulo, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, Buttons, ExtCtrls,UGLOBAL,UPRINCIPAL;

 type
tusuarios = class
  protected
  sql:string;
  public
    function verificar_usuario(nombre_usuario, password:string):boolean;
    function cargar_usuarios_en_grilla:boolean ;
    function crear_usuario(nombre,usu,pass:string):boolean;
    function Getidusuarios:longint;
    function modifica_usuario(idusu:longint;nombre,usu,pass:string):boolean;
    function eliminar_usuario(idusu:longint):boolean;
    function habilitar_menu(idusuario:longint):boolean;
  end;


implementation

function tusuarios.habilitar_menu(idusuario:longint):boolean;
var sql,nom:string;
x,i,j,posi:longint;
dato:string;
begin

  sql:='select  tipo  from usuarios  where idusuario='+inttostr(idusuario);
  modulo.sql_global.Close;
  modulo.sql_global.SQL.Clear;
  modulo.sql_global.SQL.Add(sql);
  modulo.sql_global.ExecSQL;
  modulo.sql_global.Open;
  if modulo.sql_global.RecordCount > 0 then
  begin
                                                           
      //if modulo.sql_global.Fields[0].AsInteger=1 then
      //   begin
             for  j:=0 to form1.MainMenu1.Items.Count  -1 do
             begin
                  for  i:=0 to form1.MainMenu1.Items[j].Count - 1  do
                  begin
                    nom:=form1.MainMenu1.Items[j].Items[i].Caption;

                     x:=form1.MainMenu1.Items[j].Items[i].Tag;
                         if modulo.sql_global.Fields[0].AsInteger=0 then
                           begin
                             form1.MainMenu1.Items[j].Items[i].Enabled:=true
                           end else
                            begin
                                if x=1 then
                                  form1.MainMenu1.Items[j].Items[i].Enabled:=true
                                  else
                                  form1.MainMenu1.Items[j].Items[i].Enabled:=false;
                           end;
                  end;
              end;

  end;



end;

function tusuarios.eliminar_usuario(idusu:longint):boolean;
begin
modulo.conexion.BeginTrans;
try



  sql:='delete from  usuarios  where idusurio='+inttostr(idusu);
  modulo.sql_global.Close;
  modulo.sql_global.SQL.Clear;
  modulo.sql_global.SQL.Add(sql);
  modulo.sql_global.ExecSQL;

modulo.conexion.CommitTrans;
eliminar_usuario:=true;
showmessage('Se ha eliminado el usuario.');
except
modulo.conexion.RollbackTrans;
showmessage('Se produjo un error al intentar eliminar el usuario.');
eliminar_usuario:=false;
end;
end;

function tusuarios.Getidusuarios:longint;
var sql:string;
begin

  sql:='select  max(idusuario) as maximo from usuarios ';
  modulo.sql_global.Close;
  modulo.sql_global.SQL.Clear;
  modulo.sql_global.SQL.Add(sql);
  modulo.sql_global.ExecSQL;
  modulo.sql_global.Open;
  Getidusuarios:=modulo.sql_global.Fields[0].AsInteger + 1;


end;


function tusuarios.modifica_usuario(idusu:longint;nombre,usu,pass:string):boolean;
begin

modulo.conexion.BeginTrans;
try



  sql:='update   usuarios  set usuario='+#39+trim(usu)+#39+', nombre='+#39+trim(nombre)+#39+', contraseña='+#39+trim(pass)+#39+'  where idusuario='+inttostr(idusu);
  modulo.sql_global.Close;
  modulo.sql_global.SQL.Clear;
  modulo.sql_global.SQL.Add(sql);
  modulo.sql_global.ExecSQL;

modulo.conexion.CommitTrans;
modifica_usuario:=true;
showmessage('Se ha modificado el usuario.');
except
modulo.conexion.RollbackTrans;
showmessage('Se produjo un error al intentar modificar el usuario.');
modifica_usuario:=false;
end;

end;



function tusuarios.crear_usuario(nombre,usu,pass:string):boolean;
var idusu,tipo:longint;
begin

modulo.conexion.BeginTrans;
try
  tipo:=2;
  idusu:=Getidusuarios;

  sql:='insert into  usuarios (usuario, nombre, contraseña, idusuario, tipo)  values ('+#39+trim(usu)+#39+','+#39+trim(nombre)+#39+','+#39+trim(pass)+#39+','+inttostr(idusu)+','+inttostr(tipo)+')';
  modulo.sql_global.Close;
  modulo.sql_global.SQL.Clear;
  modulo.sql_global.SQL.Add(sql);
  modulo.sql_global.ExecSQL;

modulo.conexion.CommitTrans;
crear_usuario:=true;
showmessage('Se ha creado el usuario.');
except
modulo.conexion.RollbackTrans;
showmessage('Se produjo un error al intentar crear el usuario.');
crear_usuario:=false;
end;

end;



function tusuarios.cargar_usuarios_en_grilla:boolean;
var sql:string;
begin
  sql:='select * from usuarios order by idusuario asc';
 modulo.sql_usuario.Close;
 modulo.sql_usuario.SQL.Clear;
 modulo.sql_usuario.SQL.Add(sql);
 modulo.sql_usuario.ExecSQL;
 modulo.sql_usuario.Open;

 end;

function tusuarios.verificar_usuario(nombre_usuario, password:string):boolean;
var sql:string;
begin
 nombre_usuario:=trim(nombre_usuario);
 password:=trim(password);

 sql:='select NOMBRE, idusuario from usuarios where usuario='+#39+trim(nombre_usuario)+#39+' and contraseña='+#39+trim(password)+#39;
 modulo.sql_global.Close;
 modulo.sql_global.SQL.Clear;
 modulo.sql_global.SQL.Add(sql);
 modulo.sql_global.ExecSQL;
 modulo.sql_global.Open;
 if modulo.sql_global.RecordCount > 0 then
  begin
     UGLOBAL.ID_USUARIO_CONECTADO:=MODULO.sql_global.Fields[1].ASinteger;
   UGLOBAL.USUARIO_CONECTADO:=TRIM(MODULO.sql_global.Fields[0].ASSTRING);
   habilitar_menu(MODULO.sql_global.Fields[1].ASinteger);

     verificar_usuario:=true;
  end ELSE
  BEGIN
   SHOWMESSAGE('EL USUARIO O PASSWAROD SON INCORRECTOS.');
   verificar_usuario:=false;
  END;




end;











end.
