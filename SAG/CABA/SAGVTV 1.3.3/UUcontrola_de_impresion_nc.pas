unit UUcontrola_de_impresion_nc;

interface

uses  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, Buttons, ExtCtrls,Math ,SQLEXPR,usuperregistry,Globals ,uconst, uversion;


type
tcontrol_nc_cf = class
  protected
  sql:string;
  public
   puerto:string;
   velo:longint;
   tipo:string;
   cf:longint;
   function controla_cf:boolean;


  end;
implementation

function tcontrol_nc_cf.controla_cf:boolean;
var imprime:integer;
aQ : TsqlQuery;
begin
   result:=falsE;

with TSuperRegistry.Create do
     try
        RootKey := HKEY_LOCAL_MACHINE;
          if not OpenKeyRead(CAJA_) then
             result:=false
            else
             begin
               imprime := ReadInteger(NCCF_);
               if imprime=1 then
                   result:=true;

             end;

 finally
       free;
     end;




 with TSuperRegistry.Create do
try
   RootKey := HKEY_LOCAL_MACHINE;
     if  OpenKeyRead(CAJA_) then
         begin
          cf:= ReadInteger(PRINTER_);
          {
            aQ := TsqlQuery.Create(self);
            try
               aQ.SQLConnection := MyBD;
               aQ.SQL.Add('SELECT IMPRIME_NC FROM TCONTROLADORES_FISCALES  WHERE  CODIGO ='+INTTOSTR(cf));
               aQ.Open;
               if  AQ.RecordCount > 0 then
                  begin
                       if trim(aq.Fields[0].AsString)='Si' then
                         begin }
                         tipo:='TM2000';
                          puerto:= ReadString(PortNumber_);
                          velo:= strtoint(ReadString(BaudRate_));
                         // result:=true;
                        { end else
                          begin
                           result:=false;
                          end;

                  end else begin
                  result:=false;
                  end;



            finally
                aQ.Free;
            end;
           }





          end;


finally
free;
end;
//---------------fin


end;




end.
 