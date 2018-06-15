unit Uempresas;

interface

uses Umodulo, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, Buttons, ExtCtrls,UGLOBAL;

 type
tempresas = class
  protected
  sql:string;
  public

    function cargar_empresa_en_grilla:boolean;
    function crear_empresa(nombre:string):boolean;
    function Getidempresas:string;
    function modifica_empresa(empre,nombre:string):boolean;
    function eliminar_empresa(empre:string):boolean;
  end;


implementation

function tempresas.eliminar_empresa(empre:string):boolean;
begin
modulo.conexion.BeginTrans;
try



  sql:='delete from  empresas  where empresa='+#39+trim(empre)+#39;
  modulo.sql_global.Close;
  modulo.sql_global.SQL.Clear;
  modulo.sql_global.SQL.Add(sql);
  modulo.sql_global.ExecSQL;

modulo.conexion.CommitTrans;
eliminar_empresa:=true;
showmessage('Se ha eliminado la empresa.');
except
modulo.conexion.RollbackTrans;
showmessage('Se produjo un error al intentar eliminar la empresa.');
eliminar_empresa:=false;
end;
end;

function tempresas.Getidempresas:string;
var sql:string;
codigo:longint;
begin

  sql:='select  max(empresa) as maximo from empresas ';
  modulo.sql_global.Close;
  modulo.sql_global.SQL.Clear;
  modulo.sql_global.SQL.Add(sql);
  modulo.sql_global.ExecSQL;
  modulo.sql_global.Open;
  codigo:=modulo.sql_global.Fields[0].AsInteger + 1;

  if length(inttostr(codigo))=1 then
      Getidempresas:='000'+inttostr(codigo);

 if length(inttostr(codigo))=2 then
      Getidempresas:='00'+inttostr(codigo);


 if length(inttostr(codigo))=3 then
      Getidempresas:='0'+inttostr(codigo);

  if length(inttostr(codigo))=4 then
      Getidempresas:=inttostr(codigo);
end;


function tempresas.modifica_empresa(empre,nombre:string):boolean;
begin

modulo.conexion.BeginTrans;
try



  sql:='update   empresas  set nombre='+#39+trim(nombre)+#39+'  where empresa='+#39+trim(empre)+#39;
  modulo.sql_global.Close;
  modulo.sql_global.SQL.Clear;
  modulo.sql_global.SQL.Add(sql);
  modulo.sql_global.ExecSQL;

modulo.conexion.CommitTrans;
modifica_empresa:=true;
showmessage('Se ha modificado  la empresa.');
except
modulo.conexion.RollbackTrans;
showmessage('Se produjo un error al intentar modificar la empresa.');
modifica_empresa:=false;
end;

end;



function tempresas.crear_empresa(nombre:string):boolean;
var empre:string;
begin

modulo.conexion.BeginTrans;
try

  empre:=Getidempresas;

  sql:='insert into  empresas (empresa, nombre)  values ('+#39+trim(empre)+#39+','+#39+trim(nombre)+#39+')';
  modulo.sql_global.Close;
  modulo.sql_global.SQL.Clear;
  modulo.sql_global.SQL.Add(sql);
  modulo.sql_global.ExecSQL;

modulo.conexion.CommitTrans;
crear_empresa:=true;
showmessage('Se ha creado la empresa.');
except
modulo.conexion.RollbackTrans;
showmessage('Se produjo un error al intentar crear la empresa.');
crear_empresa:=false;
end;

end;



function tempresas.cargar_empresa_en_grilla:boolean;
var sql:string;
begin
  sql:='select * from empresas order by empresa asc';
 modulo.sql_empresa.Close;
 modulo.sql_empresa.SQL.Clear;
 modulo.sql_empresa.SQL.Add(sql);
 modulo.sql_empresa.ExecSQL;
 modulo.sql_empresa.Open;

 end;


end.
