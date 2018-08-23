unit Uplantillas;
interface
uses Umodulo, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, Buttons, ExtCtrls,UGLOBAL,Registry,RxMemDS,DateUtils,ufunciones,uconst,usuperregistry;

 type
ttemplate = class
  protected
  sql:string;
  public

    function GetNumero_plantilla:longint;
    function crear_plantilla(empresa,centro,desde,hasta:string;diferencia:integer;dias,tp:string;tabla:TRxMemoryData;hi,hf,hdi,hdf:string):boolean;
    function modificar_plantilla(numero:longint;empresa,centro,desde,hasta:string;diferencia:integer;dias,tp:string;tabla:TRxMemoryData;hi,hf,hdi,hdf:string):boolean;
    function chequea_si_hay_reservas(fecha_desde,fecha_hasta:string):boolean;
    function chequea_si_es_feriado_o_domingo(fecha:string):boolean;
    function es_sabado(fecha:string):boolean;
    function crear_plantilla_sabados(empresa,centro,desde,hasta:string;diferencia:integer;dias,tp:string;tabla:TRxMemoryData;hi,hf,hdi,hdf:string):boolean;
    function modificar_plantilla_sabados(numero:longint;empresa,centro,desde,hasta:string;diferencia:integer;dias,tp:string;tabla:TRxMemoryData;hi,hf,hdi,hdf:string):boolean;
    function es_lunes_a_viernes(fecha:string):boolean;
    function genera_el_desde_para_sabado(desde,dias:string):string;
    function genera_el_hasta_para_sabado(hasta,dias:string):string;
    function comprara_fecha_con_selecciona_sabado(fd,dias:string):boolean;
  end;

implementation
 function ttemplate.comprara_fecha_con_selecciona_sabado(fd,dias:string):boolean;
  var int_dias,i:longint;
  fe:tdate;
 begin
 comprara_fecha_con_selecciona_sabado:=false;
     int_dias:=strtoint(dias);
   for i:=0 to int_dias do
   begin


           if es_sabado(fd)= true then
              begin
              fd:=fd;
              comprara_fecha_con_selecciona_sabado:=true;
              break;
              end;

     fe:=strtodate(fd);
     fe:=fe + 1;
     fd:=datetostr(fe);

  end;

 end;



function ttemplate.genera_el_desde_para_sabado(desde,dias:string):string;
var i,int_dias:longint;
fe:tdate;
begin
  int_dias:=strtoint(dias);
   for i:=0 to int_dias do
   begin


           if es_sabado(desde)= true then
              begin
              desde:=desde;
              break;
              end;

     fe:=strtodate(desde);
     fe:=fe + 1;
     desde:=datetostr(fe);

  end;

 genera_el_desde_para_sabado:=desde;
end;

function ttemplate.genera_el_hasta_para_sabado(hasta,dias:string):string;
var i,int_dias:longint;
fe:tdate;
begin
int_dias:=strtoint(dias);
 for i:=int_dias  downto 0 do
   begin


           if es_sabado(hasta)= true then
              begin
              hasta:=hasta;
              break;
              end;

     fe:=strtodate(hasta);
     fe:=fe - 1;
     hasta:=datetostr(fe);

  end;
genera_el_hasta_para_sabado:=hasta;
end;

function ttemplate.es_sabado(fecha:string):boolean;
var   DiasASumar:longint ;
fecha1:tdate;
begin
Fecha1 := strtodate(fecha);
DiasASumar:=0;
//while (DiasASumar <= strtoint(dias)) do
//begin
    es_sabado:=false;
   //if ((DayOfTheWeek(Fecha) > 1) and (DayOfTheWeek(Fecha) < 5)) then {1 lunes, 5 viernes, 6 sabado, 7 domingo}

  // showmessage(inttostr(DayOfTheWeek(Fecha)));
    if ((DayOfTheWeek(Fecha1)) = 6) then
   begin
           es_sabado:=true;
         //showmessage('si'+'   '+datetostr(fecha));
   end;
//  fecha:=fecha + 1;
 // DiasASumar:=DiasASumar + 1;
//end

end;


function ttemplate.es_lunes_a_viernes(fecha:string):boolean;
var   DiasASumar:longint ;
fecha1:tdate;
begin
Fecha1 := strtodate(fecha);
DiasASumar:=0;
//while (DiasASumar <= strtoint(dias)) do
//begin
    es_lunes_a_viernes:=false;
   //if ((DayOfTheWeek(Fecha) > 1) and (DayOfTheWeek(Fecha) < 5)) then {1 lunes, 5 viernes, 6 sabado, 7 domingo}

  // showmessage(inttostr(DayOfTheWeek(Fecha)));
    if ((DayOfTheWeek(Fecha1)) in [1,2,3,4,5]) then
   begin
           es_lunes_a_viernes:=true;
         //showmessage('si'+'   '+datetostr(fecha));
   end;
//  fecha:=fecha + 1;
 // DiasASumar:=DiasASumar + 1;
//end

end;



function ttemplate.chequea_si_es_feriado_o_domingo(fecha:string):boolean;
var empresa:string;
begin
 with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(APPLICATION_KEY) then
      Begin
      empresa:=ReadString('Empresa');

      end;
  Finally
    free;
  end;
   chequea_si_es_feriado_o_domingo:=false;

   // fecha:=copy(trim(fecha),1,5);
   

    sql:='select idferiado from feriados  where  fecha='+#39+trim(fecha)+#39+' and empresa='+#39+trim(empresa)+#39;
   modulo.sql_global.Close;
   modulo.sql_global.SQL.Clear;
   modulo.sql_global.SQL.Add(sql);
   modulo.sql_global.ExecSQL;
   modulo.sql_global.Open;
   if modulo.sql_global.RecordCount > 0 then
      chequea_si_es_feriado_o_domingo:=true;

end;

function ttemplate.chequea_si_hay_reservas(fecha_desde,fecha_hasta:string):boolean;
var tf:tfuncion;
i:longint;
begin
tf:=tfuncion.Create;

with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(APPLICATION_KEY) then
      Begin
      uglobal.ID_EMPRESA:=ReadString('Empresa');
      uglobal.ID_PLANTA:=ReadString('Planta');
      //actual:=ReadString('Conex_actual');
      end;
  Finally
    free;
  end;


 if es_sabado(fecha_desde)=false then
 begin

   sql:='select count(*) as cant from reserva  where empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and centro='+#39+trim(uglobal.ID_PLANTA)+#39+' and fecha between CONVERT(DATETIME,'+#39+fecha_desde+#39+',103) and CONVERT(DATETIME,'+#39+fecha_hasta+#39+',103)';
   modulo.sql_global.Close;
   modulo.sql_global.SQL.Clear;
   modulo.sql_global.SQL.Add(sql);
   modulo.sql_global.ExecSQL;
   modulo.sql_global.Open;
   if modulo.sql_global.Fields[0].AsInteger = 0 then
      chequea_si_hay_reservas:=false
      else
      chequea_si_hay_reservas:=true;

 end else
 begin


   sql:='select numero, fecha from reserva  where empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and centro='+#39+trim(uglobal.ID_PLANTA)+#39+' and fecha between CONVERT(DATETIME,'+#39+fecha_desde+#39+',103) and CONVERT(DATETIME,'+#39+fecha_hasta+#39+',103)';
   chequea_si_hay_reservas:=false;
   modulo.sql_global.Close;
   modulo.sql_global.SQL.Clear;
   modulo.sql_global.SQL.Add(sql);
   modulo.sql_global.ExecSQL;
   modulo.sql_global.Open;
   if modulo.sql_global.RecordCount > 0 then
      begin

          for i:=1 to modulo.sql_global.RecordCount do
           begin
                  if es_sabado(modulo.sql_global.Fields[0].asstring)=true then
                       chequea_si_hay_reservas:=true;





               modulo.sql_global.Next;
           end;





      end;


end;//no es sabado







 tf.Free;
end;


  function ttemplate.GetNumero_plantilla:longint;
  var sql:string;
  begin
   sql:='select max(numero) from plantilla';
   modulo.sql_global.Close;
   modulo.sql_global.SQL.Clear;
   modulo.sql_global.SQL.Add(sql);
   modulo.sql_global.ExecSQL;
   modulo.sql_global.Open;
   GetNumero_plantilla:=modulo.sql_global.Fields[0].AsInteger;


  end;

    function ttemplate.modificar_plantilla(numero:longint;empresa,centro,desde,hasta:string;diferencia:integer;dias,tp:string;tabla:TRxMemoryData;hi,hf,hdi,hdf:string):boolean;
var numero_plantilla:longint;
tf:tfuncion;
sql:string;
i:longint;
fe:tdate;
int_dias:longint;
d600,d615,d630,d645,d700,d715,d730,d745,d800,d815,d830,d845,d900,d915,d930,d945:integer;
d1000,d1015,d1030,d1045,d1100,d1115,d1130,d1145,d1200,d1215,d1230,d1245,d1300:integer;
d1315,d1330,d1345,d1400,d1415,d1430,d1445,d1500,d1510,d1515,d1530,d1545,d1600:integer;
d1615,d1630,d1645,d1700,d1715,d1730,d1745,d1800,d1815,d1830,d1845,d1900:integer;
d1915,d1930,d1945,d2000,d2015,d2030,d2045,d2100,d2115,d2130,d2145,d2200:integer;
d2215,d2230,d2245,d2300,d2315,d2345,vacio:integer;
begin

tf:=tfuncion.Create;
//uglobal.ID_EMPRESA:=tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Empresa');
//uglobal.ID_PLANTA:=tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');


with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(APPLICATION_KEY) then
      Begin
      uglobal.ID_EMPRESA:=ReadString('Empresa');
      uglobal.ID_PLANTA:=ReadString('Planta');
      //actual:=ReadString('Conex_actual');
      end;
  Finally
    free;
  end;
 tf.Free;
// borrar plantilla

sql:='delete  from  acucitas where empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and centro='+#39+trim(uglobal.ID_PLANTA)+#39+' and idplantilla='+inttostr(numero);
modulo.sql_global.Close;
modulo.sql_global.SQL.Clear;
modulo.sql_global.SQL.Add(sql);
modulo.sql_global.ExecSQL;


sql:='delete  from  plantilla where  empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and centro='+#39+trim(uglobal.ID_PLANTA)+#39+' and numero='+inttostr(numero);
modulo.sql_global.Close;
modulo.sql_global.SQL.Clear;
modulo.sql_global.SQL.Add(sql);
modulo.sql_global.ExecSQL;




vacio:=0;
d600:=0;
d615:=0;
d630:=0;
d645:=0;
d700:=0;
d715:=0;
d730:=0;
d745:=0;
d800:=0;
d815:=0;
d830:=0;
d845:=0;
d900:=0;
d915:=0;
d930:=0;
d945:=0;
d1000:=0;
d1015:=0;
d1030:=0;
d1045:=0;
d1100:=0;
d1115:=0;
d1130:=0;
d1145:=0;
d1200:=0;
d1215:=0;
d1230:=0;
d1245:=0;
d1300:=0;
d1315:=0;
d1330:=0;
d1345:=0;
d1400:=0;
d1415:=0;
d1430:=0;
d1445:=0;
d1500:=0;
d1510:=0;
d1515:=0;
d1530:=0;
d1545:=0;
d1600:=0;
d1615:=0;
d1630:=0;
d1645:=0;
d1700:=0;
d1715:=0;
d1730:=0;
d1745:=0;
d1800:=0;
d1815:=0;
d1830:=0;
d1845:=0;
d1900:=0;
d1915:=0;
d1930:=0;
d1945:=0;
d2000:=0;
d2015:=0;
d2030:=0;
d2045:=0;
d2100:=0;
d2115:=0;
d2130:=0;
d2145:=0;
d2200:=0;
d2215:=0;
d2230:=0;
d2245:=0;
d2300:=0;
d2315:=0;
d2345:=0;
modificar_plantilla:=false;


 i:=0;
 tabla.Open;
 tabla.First;
  while not (tabla.Eof)  do
    begin

             if tabla.Fields[0].AsString='600' then
              begin
               d600:=tabla.Fields[1].Asinteger;
              end;

             if tabla.Fields[0].AsString='615' then
              begin
               d615:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='630' then
              begin
               d630:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='645' then
              begin
               d645:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='700' then
              begin
               d700:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='715' then
              begin
               d715:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='730' then
              begin
               d730:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='745' then
              begin
               d745:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='800' then
              begin
               d800:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='815' then
              begin
               d815:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='830' then
              begin
               d830:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='845' then
              begin
               d845:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='900' then
              begin
               d900:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='915' then
              begin
               d915:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='930' then
              begin
               d930:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='945' then
              begin
               d945:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1000' then
              begin
               d1000:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1015' then
              begin
               d1015:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1030' then
              begin
               d1030:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1045' then
              begin
               d1045:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1100' then
              begin
               d1100:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1115' then
              begin
               d1115:=tabla.Fields[1].Asinteger;
              end;


           if tabla.Fields[0].AsString='1130' then
              begin
               d1130:=tabla.Fields[1].Asinteger;
              end;

              if tabla.Fields[0].AsString='1145' then
              begin
               d1145:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1200' then
              begin
               d1200:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1215' then
              begin
               d1215:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1230' then
              begin
               d1230:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1245' then
              begin
               d1245:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1300' then
              begin
               d1300:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1315' then
              begin
               d1315:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1330' then
              begin
               d1330:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1345' then
              begin
               d1345:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1400' then
              begin
               d1400:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1415' then
              begin
               d1415:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1430' then
              begin
               d1430:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1445' then
              begin
               d1445:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1500' then
              begin
               d1500:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1515' then
              begin
               d1515:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1530' then
              begin
               d1530:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1545' then
              begin
               d1545:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1600' then
              begin
               d1600:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1615' then
              begin
               d1615:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1630' then
              begin
               d1630:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1645' then
              begin
               d1645:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1700' then
              begin
               d1700:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1715' then
              begin
               d1715:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1730' then
              begin
               d1730:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1745' then
              begin
               d1745:=tabla.Fields[1].Asinteger;
              end;

             if tabla.Fields[0].AsString='1800' then
              begin
               d1800:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1815' then
              begin
               d1815:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1830' then
              begin
               d1830:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1845' then
              begin
               d1845:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1900' then
              begin
               d1900:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1915' then
              begin
               d1915:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1930' then
              begin
               d1930:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1945' then
              begin
               d1945:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2000' then
              begin
               d2000:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2015' then
              begin
               d2015:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2030' then
              begin
               d2030:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2045' then
              begin
               d2045:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2100' then
              begin
               d2100:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2115' then
              begin
               d2115:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2130' then
              begin
               d2130:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2145' then
              begin
               d2145:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2200' then
              begin
               d2200:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2215' then
              begin
               d2215:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2230' then
              begin
               d2230:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2245' then
              begin
               d2245:=tabla.Fields[1].Asinteger;
              end;


     tabla.Next;
    end;


  modulo.conexion.BeginTrans;
  try


   sql:=' insert into plantilla (empresa, centro, desde, hasta, diferencia, dias, tp,'+
                                 'd0600,d0615,d0630,d0645,d0700,d0715,d0730,'+
                                 'd0745,d0800,d0815,d0830,d0845,d0900,d0915,'+
                                 'd0930,d0945,d1000,d1015,d1030,d1045,d1100,'+
                                 'd1115,d1130,d1145,d1200,d1215,d1230,d1245,d1300,'+
                                 'd1315,d1330,d1345,d1400,d1415,d1430,d1445,d1500,'+
                                 'd1515,d1530,d1545,d1600,d1615,d1630,d1645,d1700,'+
                                 'd1715,d1730,d1745,d1800,d1815,d1830,d1845,d1900,'+
                                 'd1915,d1930,d1945,d2000,d2015,d2030,d2045,d2100,'+
                                 'd2115,d2130,d2145,d2200,d2215,d2230,d2245,hora_inicio, hora_fin, hora_i_desca, hora_f_desca, idusuarios) '+
                                 '  values ('+#39+trim(empresa)+#39+
                                 ','+#39+trim(centro)+#39+
                                 ', CONVERT(DATETIME,'+#39+desde+#39+',103)'+
                                 ', CONVERT(DATETIME,'+#39+hasta+#39+',103)'+
                                 ','+inttostr(diferencia)+
                                 ','+#39+trim(dias)+#39+
                                 ','+#39+trim(tp)+#39+
                                 ','+inttostr(d600)+
                                 ','+inttostr(d615)+
                                 ','+inttostr(d630)+
                                 ','+inttostr(d645)+
                                 ','+inttostr(d700)+
                                 ','+inttostr(d715)+
                                 ','+inttostr(d730)+
                                 ','+inttostr(d745)+
                                 ','+inttostr(d800)+
                                 ','+inttostr(d815)+
                                 ','+inttostr(d830)+
                                 ','+inttostr(d845)+
                                 ','+inttostr(d900)+
                                 ','+inttostr(d915)+
                                 ','+inttostr(d930)+
                                 ','+inttostr(d945)+
                                 ','+inttostr(d1000)+
                                 ','+inttostr(d1015)+
                                 ','+inttostr(d1030)+
                                 ','+inttostr(d1045)+
                                 ','+inttostr(d1100)+
                                 ','+inttostr(d1115)+
                                 ','+inttostr(d1130)+
                                 ','+inttostr(d1145)+
                                 ','+inttostr(d1200)+
                                 ','+inttostr(d1215)+
                                 ','+inttostr(d1230)+
                                 ','+inttostr(d1245)+
                                 ','+inttostr(d1300)+
                                 ','+inttostr(d1315)+
                                 ','+inttostr(d1330)+
                                 ','+inttostr(d1345)+
                                 ','+inttostr(d1400)+
                                 ','+inttostr(d1415)+
                                 ','+inttostr(d1430)+
                                 ','+inttostr(d1445)+
                                 ','+inttostr(d1500)+
                                 ','+inttostr(d1515)+
                                 ','+inttostr(d1530)+
                                 ','+inttostr(d1545)+
                                 ','+inttostr(d1600)+
                                 ','+inttostr(d1615)+
                                 ','+inttostr(d1630)+
                                 ','+inttostr(d1645)+
                                 ','+inttostr(d1700)+
                                 ','+inttostr(d1715)+
                                 ','+inttostr(d1730)+
                                 ','+inttostr(d1745)+
                                 ','+inttostr(d1800)+
                                 ','+inttostr(d1815)+
                                 ','+inttostr(d1830)+
                                 ','+inttostr(d1845)+
                                 ','+inttostr(d1900)+
                                 ','+inttostr(d1915)+
                                 ','+inttostr(d1930)+
                                 ','+inttostr(d1945)+
                                 ','+inttostr(d2000)+
                                 ','+inttostr(d2015)+
                                 ','+inttostr(d2030)+
                                 ','+inttostr(d2045)+
                                 ','+inttostr(d2100)+
                                 ','+inttostr(d2115)+
                                 ','+inttostr(d2130)+
                                 ','+inttostr(d2145)+
                                 ','+inttostr(d2200)+
                                 ','+inttostr(d2215)+
                                 ','+inttostr(d2230)+
                                 ','+inttostr(d2245)+','+#39+trim(hi)+#39+','+#39+trim(hf)+#39+','+#39+trim(hdi)+#39+','+#39+trim(hdf)+#39+','+inttostr(uglobal.ID_USUARIO_CONECTADO)+')';



                                 modulo.sql_global.Close;
                                 modulo.sql_global.SQL.Clear;
                                 modulo.sql_global.SQL.Add(sql);
                                 modulo.sql_global.ExecSQL;

                                 numero_plantilla:=Getnumero_plantilla;
                                 uglobal.NUMERO_PLANILLA_MODIFICA:=numero_plantilla;


  // guarda en acucitas
  {
  '+#39+trim(empresa)+#39+
                                 ','+#39+trim(centro)+#39+
                                 ', CONVERT(DATETIME,'+#39+desde+#39+',103)'+
                                 ', CONVERT(DATETIME,'+#39+hasta+#39+',103)'+
                                 ','+inttostr(diferencia)+
                                 ','+#39+trim(dias)+#39+
                                 ','+#39+trim(tp)+#39+
  }
  int_dias:=strtoint(dias);

  //if  int_dias=0 then

   for i:=0 to int_dias do
   begin
     if chequea_si_es_feriado_o_domingo(desde)=false then
     begin
      if es_lunes_a_viernes(desde)=true  then
      begin

     sql:=' insert into acucitas (dp0600,dp0615,dp0630,dp0645,dp0700,dp0715,dp0730,'+
                                 'dp0745,dp0800,dp0815,dp0830,dp0845,dp0900,dp0915,'+
                                 'dp0930,dp0945,dp1000,dp1015,dp1030,dp1045,dp1100,'+
                                 'dp1115,dp1130,dp1145,dp1200,dp1215,dp1230,dp1245,dp1300,'+
                                 'dp1315,dp1330,dp1345,dp1400,dp1415,dp1430,dp1445,dp1500,'+
                                 'dp1515,dp1530,dp1545,dp1600,dp1615,dp1630,dp1645,dp1700,'+
                                 'dp1715,dp1730,dp1745,dp1800,dp1815,dp1830,dp1845,dp1900,'+
                                 'dp1915,dp1930,dp1945,dp2000,dp2015,dp2030,dp2045,dp2100,'+
                                 'dp2115,dp2130,dp2145,dp2200,dp2215,dp2230,dp2245,'+
                                 'dr0600,dr0615,dr0630,dr0645,dr0700,dr0715,dr0730,'+
                                 'dr0745,dr0800,dr0815,dr0830,dr0845,dr0900,dr0915,'+
                                 'dr0930,dr0945,dr1000,dr1015,dr1030,dr1045,dr1100,'+
                                 'dr1115,dr1130,dr1145,dr1200,dr1215,dr1230,dr1245,dr1300,'+
                                 'dr1315,dr1330,dr1345,dr1400,dr1415,dr1430,dr1445,dr1500,'+
                                 'dr1515,dr1530,dr1545,dr1600,dr1615,dr1630,dr1645,dr1700,'+
                                 'dr1715,dr1730,dr1745,dr1800,dr1815,dr1830,dr1845,dr1900,'+
                                 'dr1915,dr1930,dr1945,dr2000,dr2015,dr2030,dr2045,dr2100,'+
                                 'dr2115,dr2130,dr2145,dr2200,dr2215,dr2230,dr2245,empresa,centro,'+
                                 'fecha,tp, idplantilla)'+
                                 '  values ('+inttostr(d600)+
                                 ','+inttostr(d615)+
                                 ','+inttostr(d630)+
                                 ','+inttostr(d645)+
                                 ','+inttostr(d700)+
                                 ','+inttostr(d715)+
                                 ','+inttostr(d730)+
                                 ','+inttostr(d745)+
                                 ','+inttostr(d800)+
                                 ','+inttostr(d815)+
                                 ','+inttostr(d830)+
                                 ','+inttostr(d845)+
                                 ','+inttostr(d900)+
                                 ','+inttostr(d915)+
                                 ','+inttostr(d930)+
                                 ','+inttostr(d945)+
                                 ','+inttostr(d1000)+
                                 ','+inttostr(d1015)+
                                 ','+inttostr(d1030)+
                                 ','+inttostr(d1045)+
                                 ','+inttostr(d1100)+
                                 ','+inttostr(d1115)+
                                 ','+inttostr(d1130)+
                                 ','+inttostr(d1145)+
                                 ','+inttostr(d1200)+
                                 ','+inttostr(d1215)+
                                 ','+inttostr(d1230)+
                                 ','+inttostr(d1245)+
                                 ','+inttostr(d1300)+
                                 ','+inttostr(d1315)+
                                 ','+inttostr(d1330)+
                                 ','+inttostr(d1345)+
                                 ','+inttostr(d1400)+
                                 ','+inttostr(d1415)+
                                 ','+inttostr(d1430)+
                                 ','+inttostr(d1445)+
                                 ','+inttostr(d1500)+
                                 ','+inttostr(d1515)+
                                 ','+inttostr(d1530)+
                                 ','+inttostr(d1545)+
                                 ','+inttostr(d1600)+
                                 ','+inttostr(d1615)+
                                 ','+inttostr(d1630)+
                                 ','+inttostr(d1645)+
                                 ','+inttostr(d1700)+
                                 ','+inttostr(d1715)+
                                 ','+inttostr(d1730)+
                                 ','+inttostr(d1745)+
                                 ','+inttostr(d1800)+
                                 ','+inttostr(d1815)+
                                 ','+inttostr(d1830)+
                                 ','+inttostr(d1845)+
                                 ','+inttostr(d1900)+
                                 ','+inttostr(d1915)+
                                 ','+inttostr(d1930)+
                                 ','+inttostr(d1945)+
                                 ','+inttostr(d2000)+
                                 ','+inttostr(d2015)+
                                 ','+inttostr(d2030)+
                                 ','+inttostr(d2045)+
                                 ','+inttostr(d2100)+
                                 ','+inttostr(d2115)+
                                 ','+inttostr(d2130)+
                                 ','+inttostr(d2145)+
                                 ','+inttostr(d2200)+
                                 ','+inttostr(d2215)+
                                 ','+inttostr(d2230)+
                                 ','+inttostr(d2245)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+#39+trim(empresa)+#39+
                                 ','+#39+trim(centro)+#39+
                                 ', CONVERT(DATETIME,'+#39+desde+#39+',103)'+
                                 ','+inttostr(numero_plantilla)+','+inttostr(numero_plantilla)+')';



                                modulo.sql_global.Close;
                                modulo.sql_global.SQL.Clear;
                                modulo.sql_global.SQL.Add(sql);
                                modulo.sql_global.ExecSQL;
                                  end;//sabado
                                 end; //feriados
                               //armo fecha por dia
                               fe:=strtodate(desde);
                               fe:=fe + 1;
                               desde:=datetostr(fe);
                               ///------------------------




   end;


  //--------------------------


 modulo.conexion.CommitTrans;
 modificar_plantilla:=true;
 except
 modulo.conexion.RollbackTrans;
 modificar_plantilla:=false;
 end;




end;



  function ttemplate.modificar_plantilla_sabados(numero:longint;empresa,centro,desde,hasta:string;diferencia:integer;dias,tp:string;tabla:TRxMemoryData;hi,hf,hdi,hdf:string):boolean;
var numero_plantilla:longint;
tf:tfuncion;
sql:string;
i:longint;
fe:tdate;
int_dias:longint;
d600,d615,d630,d645,d700,d715,d730,d745,d800,d815,d830,d845,d900,d915,d930,d945:integer;
d1000,d1015,d1030,d1045,d1100,d1115,d1130,d1145,d1200,d1215,d1230,d1245,d1300:integer;
d1315,d1330,d1345,d1400,d1415,d1430,d1445,d1500,d1510,d1515,d1530,d1545,d1600:integer;
d1615,d1630,d1645,d1700,d1715,d1730,d1745,d1800,d1815,d1830,d1845,d1900:integer;
d1915,d1930,d1945,d2000,d2015,d2030,d2045,d2100,d2115,d2130,d2145,d2200:integer;
d2215,d2230,d2245,d2300,d2315,d2345,vacio:integer;
begin

tf:=tfuncion.Create;
//uglobal.ID_EMPRESA:=tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Empresa');
//uglobal.ID_PLANTA:=tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');


with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(APPLICATION_KEY) then
      Begin
      uglobal.ID_EMPRESA:=ReadString('Empresa');
      uglobal.ID_PLANTA:=ReadString('Planta');
      //actual:=ReadString('Conex_actual');
      end;
  Finally
    free;
  end;
 tf.Free;
// borrar plantilla

sql:='delete  from  acucitas where empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and centro='+#39+trim(uglobal.ID_PLANTA)+#39+' and idplantilla='+inttostr(numero);
modulo.sql_global.Close;
modulo.sql_global.SQL.Clear;
modulo.sql_global.SQL.Add(sql);
modulo.sql_global.ExecSQL;


sql:='delete  from  plantilla where  empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and centro='+#39+trim(uglobal.ID_PLANTA)+#39+' and numero='+inttostr(numero);
modulo.sql_global.Close;
modulo.sql_global.SQL.Clear;
modulo.sql_global.SQL.Add(sql);
modulo.sql_global.ExecSQL;




vacio:=0;
d600:=0;
d615:=0;
d630:=0;
d645:=0;
d700:=0;
d715:=0;
d730:=0;
d745:=0;
d800:=0;
d815:=0;
d830:=0;
d845:=0;
d900:=0;
d915:=0;
d930:=0;
d945:=0;
d1000:=0;
d1015:=0;
d1030:=0;
d1045:=0;
d1100:=0;
d1115:=0;
d1130:=0;
d1145:=0;
d1200:=0;
d1215:=0;
d1230:=0;
d1245:=0;
d1300:=0;
d1315:=0;
d1330:=0;
d1345:=0;
d1400:=0;
d1415:=0;
d1430:=0;
d1445:=0;
d1500:=0;
d1510:=0;
d1515:=0;
d1530:=0;
d1545:=0;
d1600:=0;
d1615:=0;
d1630:=0;
d1645:=0;
d1700:=0;
d1715:=0;
d1730:=0;
d1745:=0;
d1800:=0;
d1815:=0;
d1830:=0;
d1845:=0;
d1900:=0;
d1915:=0;
d1930:=0;
d1945:=0;
d2000:=0;
d2015:=0;
d2030:=0;
d2045:=0;
d2100:=0;
d2115:=0;
d2130:=0;
d2145:=0;
d2200:=0;
d2215:=0;
d2230:=0;
d2245:=0;
d2300:=0;
d2315:=0;
d2345:=0;
modificar_plantilla_sabados:=false;


 i:=0;
 tabla.Open;
 tabla.First;
  while not (tabla.Eof)  do
    begin

             if tabla.Fields[0].AsString='600' then
              begin
               d600:=tabla.Fields[1].Asinteger;
              end;

             if tabla.Fields[0].AsString='615' then
              begin
               d615:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='630' then
              begin
               d630:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='645' then
              begin
               d645:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='700' then
              begin
               d700:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='715' then
              begin
               d715:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='730' then
              begin
               d730:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='745' then
              begin
               d745:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='800' then
              begin
               d800:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='815' then
              begin
               d815:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='830' then
              begin
               d830:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='845' then
              begin
               d845:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='900' then
              begin
               d900:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='915' then
              begin
               d915:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='930' then
              begin
               d930:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='945' then
              begin
               d945:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1000' then
              begin
               d1000:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1015' then
              begin
               d1015:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1030' then
              begin
               d1030:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1045' then
              begin
               d1045:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1100' then
              begin
               d1100:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1115' then
              begin
               d1115:=tabla.Fields[1].Asinteger;
              end;


           if tabla.Fields[0].AsString='1130' then
              begin
               d1130:=tabla.Fields[1].Asinteger;
              end;

              if tabla.Fields[0].AsString='1145' then
              begin
               d1145:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1200' then
              begin
               d1200:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1215' then
              begin
               d1215:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1230' then
              begin
               d1230:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1245' then
              begin
               d1245:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1300' then
              begin
               d1300:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1315' then
              begin
               d1315:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1330' then
              begin
               d1330:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1345' then
              begin
               d1345:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1400' then
              begin
               d1400:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1415' then
              begin
               d1415:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1430' then
              begin
               d1430:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1445' then
              begin
               d1445:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1500' then
              begin
               d1500:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1515' then
              begin
               d1515:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1530' then
              begin
               d1530:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1545' then
              begin
               d1545:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1600' then
              begin
               d1600:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1615' then
              begin
               d1615:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1630' then
              begin
               d1630:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1645' then
              begin
               d1645:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1700' then
              begin
               d1700:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1715' then
              begin
               d1715:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1730' then
              begin
               d1730:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1745' then
              begin
               d1745:=tabla.Fields[1].Asinteger;
              end;

             if tabla.Fields[0].AsString='1800' then
              begin
               d1800:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1815' then
              begin
               d1815:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1830' then
              begin
               d1830:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1845' then
              begin
               d1845:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1900' then
              begin
               d1900:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1915' then
              begin
               d1915:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1930' then
              begin
               d1930:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1945' then
              begin
               d1945:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2000' then
              begin
               d2000:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2015' then
              begin
               d2015:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2030' then
              begin
               d2030:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2045' then
              begin
               d2045:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2100' then
              begin
               d2100:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2115' then
              begin
               d2115:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2130' then
              begin
               d2130:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2145' then
              begin
               d2145:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2200' then
              begin
               d2200:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2215' then
              begin
               d2215:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2230' then
              begin
               d2230:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2245' then
              begin
               d2245:=tabla.Fields[1].Asinteger;
              end;


     tabla.Next;
    end;


  modulo.conexion.BeginTrans;
  try

   desde:=genera_el_desde_para_sabado(desde,dias);
   hasta:=genera_el_hasta_para_sabado(hasta,dias);

   sql:=' insert into plantilla (empresa, centro, desde, hasta, diferencia, dias, tp,'+
                                 'd0600,d0615,d0630,d0645,d0700,d0715,d0730,'+
                                 'd0745,d0800,d0815,d0830,d0845,d0900,d0915,'+
                                 'd0930,d0945,d1000,d1015,d1030,d1045,d1100,'+
                                 'd1115,d1130,d1145,d1200,d1215,d1230,d1245,d1300,'+
                                 'd1315,d1330,d1345,d1400,d1415,d1430,d1445,d1500,'+
                                 'd1515,d1530,d1545,d1600,d1615,d1630,d1645,d1700,'+
                                 'd1715,d1730,d1745,d1800,d1815,d1830,d1845,d1900,'+
                                 'd1915,d1930,d1945,d2000,d2015,d2030,d2045,d2100,'+
                                 'd2115,d2130,d2145,d2200,d2215,d2230,d2245,hora_inicio, hora_fin, hora_i_desca, hora_f_desca, idusuarios) '+
                                 '  values ('+#39+trim(empresa)+#39+
                                 ','+#39+trim(centro)+#39+
                                 ', CONVERT(DATETIME,'+#39+desde+#39+',103)'+
                                 ', CONVERT(DATETIME,'+#39+hasta+#39+',103)'+
                                 ','+inttostr(diferencia)+
                                 ','+#39+trim(dias)+#39+
                                 ','+#39+trim(tp)+#39+
                                 ','+inttostr(d600)+
                                 ','+inttostr(d615)+
                                 ','+inttostr(d630)+
                                 ','+inttostr(d645)+
                                 ','+inttostr(d700)+
                                 ','+inttostr(d715)+
                                 ','+inttostr(d730)+
                                 ','+inttostr(d745)+
                                 ','+inttostr(d800)+
                                 ','+inttostr(d815)+
                                 ','+inttostr(d830)+
                                 ','+inttostr(d845)+
                                 ','+inttostr(d900)+
                                 ','+inttostr(d915)+
                                 ','+inttostr(d930)+
                                 ','+inttostr(d945)+
                                 ','+inttostr(d1000)+
                                 ','+inttostr(d1015)+
                                 ','+inttostr(d1030)+
                                 ','+inttostr(d1045)+
                                 ','+inttostr(d1100)+
                                 ','+inttostr(d1115)+
                                 ','+inttostr(d1130)+
                                 ','+inttostr(d1145)+
                                 ','+inttostr(d1200)+
                                 ','+inttostr(d1215)+
                                 ','+inttostr(d1230)+
                                 ','+inttostr(d1245)+
                                 ','+inttostr(d1300)+
                                 ','+inttostr(d1315)+
                                 ','+inttostr(d1330)+
                                 ','+inttostr(d1345)+
                                 ','+inttostr(d1400)+
                                 ','+inttostr(d1415)+
                                 ','+inttostr(d1430)+
                                 ','+inttostr(d1445)+
                                 ','+inttostr(d1500)+
                                 ','+inttostr(d1515)+
                                 ','+inttostr(d1530)+
                                 ','+inttostr(d1545)+
                                 ','+inttostr(d1600)+
                                 ','+inttostr(d1615)+
                                 ','+inttostr(d1630)+
                                 ','+inttostr(d1645)+
                                 ','+inttostr(d1700)+
                                 ','+inttostr(d1715)+
                                 ','+inttostr(d1730)+
                                 ','+inttostr(d1745)+
                                 ','+inttostr(d1800)+
                                 ','+inttostr(d1815)+
                                 ','+inttostr(d1830)+
                                 ','+inttostr(d1845)+
                                 ','+inttostr(d1900)+
                                 ','+inttostr(d1915)+
                                 ','+inttostr(d1930)+
                                 ','+inttostr(d1945)+
                                 ','+inttostr(d2000)+
                                 ','+inttostr(d2015)+
                                 ','+inttostr(d2030)+
                                 ','+inttostr(d2045)+
                                 ','+inttostr(d2100)+
                                 ','+inttostr(d2115)+
                                 ','+inttostr(d2130)+
                                 ','+inttostr(d2145)+
                                 ','+inttostr(d2200)+
                                 ','+inttostr(d2215)+
                                 ','+inttostr(d2230)+
                                 ','+inttostr(d2245)+','+#39+trim(hi)+#39+','+#39+trim(hf)+#39+','+#39+trim(hdi)+#39+','+#39+trim(hdf)+#39+','+inttostr(uglobal.ID_USUARIO_CONECTADO)+')';



                                 modulo.sql_global.Close;
                                 modulo.sql_global.SQL.Clear;
                                 modulo.sql_global.SQL.Add(sql);
                                 modulo.sql_global.ExecSQL;

                                 numero_plantilla:=Getnumero_plantilla;
                                 uglobal.NUMERO_PLANILLA_MODIFICA:=numero_plantilla;


  // guarda en acucitas
  {
  '+#39+trim(empresa)+#39+
                                 ','+#39+trim(centro)+#39+
                                 ', CONVERT(DATETIME,'+#39+desde+#39+',103)'+
                                 ', CONVERT(DATETIME,'+#39+hasta+#39+',103)'+
                                 ','+inttostr(diferencia)+
                                 ','+#39+trim(dias)+#39+
                                 ','+#39+trim(tp)+#39+
  }
  int_dias:=strtoint(dias);

  //if  int_dias=0 then

   for i:=0 to int_dias do
   begin
     if chequea_si_es_feriado_o_domingo(desde)=false then
     begin

     if es_sabado(desde)=true then
       begin
     sql:=' insert into acucitas (dp0600,dp0615,dp0630,dp0645,dp0700,dp0715,dp0730,'+
                                 'dp0745,dp0800,dp0815,dp0830,dp0845,dp0900,dp0915,'+
                                 'dp0930,dp0945,dp1000,dp1015,dp1030,dp1045,dp1100,'+
                                 'dp1115,dp1130,dp1145,dp1200,dp1215,dp1230,dp1245,dp1300,'+
                                 'dp1315,dp1330,dp1345,dp1400,dp1415,dp1430,dp1445,dp1500,'+
                                 'dp1515,dp1530,dp1545,dp1600,dp1615,dp1630,dp1645,dp1700,'+
                                 'dp1715,dp1730,dp1745,dp1800,dp1815,dp1830,dp1845,dp1900,'+
                                 'dp1915,dp1930,dp1945,dp2000,dp2015,dp2030,dp2045,dp2100,'+
                                 'dp2115,dp2130,dp2145,dp2200,dp2215,dp2230,dp2245,'+
                                 'dr0600,dr0615,dr0630,dr0645,dr0700,dr0715,dr0730,'+
                                 'dr0745,dr0800,dr0815,dr0830,dr0845,dr0900,dr0915,'+
                                 'dr0930,dr0945,dr1000,dr1015,dr1030,dr1045,dr1100,'+
                                 'dr1115,dr1130,dr1145,dr1200,dr1215,dr1230,dr1245,dr1300,'+
                                 'dr1315,dr1330,dr1345,dr1400,dr1415,dr1430,dr1445,dr1500,'+
                                 'dr1515,dr1530,dr1545,dr1600,dr1615,dr1630,dr1645,dr1700,'+
                                 'dr1715,dr1730,dr1745,dr1800,dr1815,dr1830,dr1845,dr1900,'+
                                 'dr1915,dr1930,dr1945,dr2000,dr2015,dr2030,dr2045,dr2100,'+
                                 'dr2115,dr2130,dr2145,dr2200,dr2215,dr2230,dr2245,empresa,centro,'+
                                 'fecha,tp, idplantilla)'+
                                 '  values ('+inttostr(d600)+
                                 ','+inttostr(d615)+
                                 ','+inttostr(d630)+
                                 ','+inttostr(d645)+
                                 ','+inttostr(d700)+
                                 ','+inttostr(d715)+
                                 ','+inttostr(d730)+
                                 ','+inttostr(d745)+
                                 ','+inttostr(d800)+
                                 ','+inttostr(d815)+
                                 ','+inttostr(d830)+
                                 ','+inttostr(d845)+
                                 ','+inttostr(d900)+
                                 ','+inttostr(d915)+
                                 ','+inttostr(d930)+
                                 ','+inttostr(d945)+
                                 ','+inttostr(d1000)+
                                 ','+inttostr(d1015)+
                                 ','+inttostr(d1030)+
                                 ','+inttostr(d1045)+
                                 ','+inttostr(d1100)+
                                 ','+inttostr(d1115)+
                                 ','+inttostr(d1130)+
                                 ','+inttostr(d1145)+
                                 ','+inttostr(d1200)+
                                 ','+inttostr(d1215)+
                                 ','+inttostr(d1230)+
                                 ','+inttostr(d1245)+
                                 ','+inttostr(d1300)+
                                 ','+inttostr(d1315)+
                                 ','+inttostr(d1330)+
                                 ','+inttostr(d1345)+
                                 ','+inttostr(d1400)+
                                 ','+inttostr(d1415)+
                                 ','+inttostr(d1430)+
                                 ','+inttostr(d1445)+
                                 ','+inttostr(d1500)+
                                 ','+inttostr(d1515)+
                                 ','+inttostr(d1530)+
                                 ','+inttostr(d1545)+
                                 ','+inttostr(d1600)+
                                 ','+inttostr(d1615)+
                                 ','+inttostr(d1630)+
                                 ','+inttostr(d1645)+
                                 ','+inttostr(d1700)+
                                 ','+inttostr(d1715)+
                                 ','+inttostr(d1730)+
                                 ','+inttostr(d1745)+
                                 ','+inttostr(d1800)+
                                 ','+inttostr(d1815)+
                                 ','+inttostr(d1830)+
                                 ','+inttostr(d1845)+
                                 ','+inttostr(d1900)+
                                 ','+inttostr(d1915)+
                                 ','+inttostr(d1930)+
                                 ','+inttostr(d1945)+
                                 ','+inttostr(d2000)+
                                 ','+inttostr(d2015)+
                                 ','+inttostr(d2030)+
                                 ','+inttostr(d2045)+
                                 ','+inttostr(d2100)+
                                 ','+inttostr(d2115)+
                                 ','+inttostr(d2130)+
                                 ','+inttostr(d2145)+
                                 ','+inttostr(d2200)+
                                 ','+inttostr(d2215)+
                                 ','+inttostr(d2230)+
                                 ','+inttostr(d2245)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+#39+trim(empresa)+#39+
                                 ','+#39+trim(centro)+#39+
                                 ', CONVERT(DATETIME,'+#39+desde+#39+',103)'+
                                 ','+inttostr(numero_plantilla)+','+inttostr(numero_plantilla)+')';



                                modulo.sql_global.Close;
                                modulo.sql_global.SQL.Clear;
                                modulo.sql_global.SQL.Add(sql);
                                modulo.sql_global.ExecSQL;
                                 end;//sabado
                                 end; //feriados
                               //armo fecha por dia
                               fe:=strtodate(desde);
                               fe:=fe + 1;
                               desde:=datetostr(fe);
                               ///------------------------




   end;


  //--------------------------


 modulo.conexion.CommitTrans;
 modificar_plantilla_sabados:=true;
 except
 modulo.conexion.RollbackTrans;
 modificar_plantilla_sabados:=false;
 end;




end;



function ttemplate.crear_plantilla(empresa,centro,desde,hasta:string;diferencia:integer;dias,tp:string;tabla:TRxMemoryData;hi,hf,hdi,hdf:string):boolean;
var numero_plantilla:longint;
sql:string;
i:longint;
fe:tdate;
int_dias:longint;
d600,d615,d630,d645,d700,d715,d730,d745,d800,d815,d830,d845,d900,d915,d930,d945:integer;
d1000,d1015,d1030,d1045,d1100,d1115,d1130,d1145,d1200,d1215,d1230,d1245,d1300:integer;
d1315,d1330,d1345,d1400,d1415,d1430,d1445,d1500,d1510,d1515,d1530,d1545,d1600:integer;
d1615,d1630,d1645,d1700,d1715,d1730,d1745,d1800,d1815,d1830,d1845,d1900:integer;
d1915,d1930,d1945,d2000,d2015,d2030,d2045,d2100,d2115,d2130,d2145,d2200:integer;
d2215,d2230,d2245,d2300,d2315,d2345,vacio:integer;
begin
vacio:=0;
d600:=0;
d615:=0;
d630:=0;
d645:=0;
d700:=0;
d715:=0;
d730:=0;
d745:=0;
d800:=0;
d815:=0;
d830:=0;
d845:=0;
d900:=0;
d915:=0;
d930:=0;
d945:=0;
d1000:=0;
d1015:=0;
d1030:=0;
d1045:=0;
d1100:=0;
d1115:=0;
d1130:=0;
d1145:=0;
d1200:=0;
d1215:=0;
d1230:=0;
d1245:=0;
d1300:=0;
d1315:=0;
d1330:=0;
d1345:=0;
d1400:=0;
d1415:=0;
d1430:=0;
d1445:=0;
d1500:=0;
d1510:=0;
d1515:=0;
d1530:=0;
d1545:=0;
d1600:=0;
d1615:=0;
d1630:=0;
d1645:=0;
d1700:=0;
d1715:=0;
d1730:=0;
d1745:=0;
d1800:=0;
d1815:=0;
d1830:=0;
d1845:=0;
d1900:=0;
d1915:=0;
d1930:=0;
d1945:=0;
d2000:=0;
d2015:=0;
d2030:=0;
d2045:=0;
d2100:=0;
d2115:=0;
d2130:=0;
d2145:=0;
d2200:=0;
d2215:=0;
d2230:=0;
d2245:=0;
d2300:=0;
d2315:=0;
d2345:=0;
crear_plantilla:=false;


 i:=0;
 tabla.Open;
 tabla.First;
  while not (tabla.Eof)  do
    begin

             if tabla.Fields[0].AsString='600' then
              begin
               d600:=tabla.Fields[1].Asinteger;
              end;

             if tabla.Fields[0].AsString='615' then
              begin
               d615:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='630' then
              begin
               d630:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='645' then
              begin
               d645:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='700' then
              begin
               d700:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='715' then
              begin
               d715:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='730' then
              begin
               d730:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='745' then
              begin
               d745:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='800' then
              begin
               d800:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='815' then
              begin
               d815:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='830' then
              begin
               d830:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='845' then
              begin
               d845:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='900' then
              begin
               d900:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='915' then
              begin
               d915:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='930' then
              begin
               d930:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='945' then
              begin
               d945:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1000' then
              begin
               d1000:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1015' then
              begin
               d1015:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1030' then
              begin
               d1030:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1045' then
              begin
               d1045:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1100' then
              begin
               d1100:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1115' then
              begin
               d1115:=tabla.Fields[1].Asinteger;
              end;


           if tabla.Fields[0].AsString='1130' then
              begin
               d1130:=tabla.Fields[1].Asinteger;
              end;

              if tabla.Fields[0].AsString='1145' then
              begin
               d1145:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1200' then
              begin
               d1200:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1215' then
              begin
               d1215:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1230' then
              begin
               d1230:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1245' then
              begin
               d1245:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1300' then
              begin
               d1300:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1315' then
              begin
               d1315:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1330' then
              begin
               d1330:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1345' then
              begin
               d1345:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1400' then
              begin
               d1400:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1415' then
              begin
               d1415:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1430' then
              begin
               d1430:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1445' then
              begin
               d1445:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1500' then
              begin
               d1500:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1515' then
              begin
               d1515:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1530' then
              begin
               d1530:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1545' then
              begin
               d1545:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1600' then
              begin
               d1600:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1615' then
              begin
               d1615:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1630' then
              begin
               d1630:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1645' then
              begin
               d1645:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1700' then
              begin
               d1700:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1715' then
              begin
               d1715:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1730' then
              begin
               d1730:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1745' then
              begin
               d1745:=tabla.Fields[1].Asinteger;
              end;

             if tabla.Fields[0].AsString='1800' then
              begin
               d1800:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1815' then
              begin
               d1815:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1830' then
              begin
               d1830:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1845' then
              begin
               d1845:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1900' then
              begin
               d1900:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1915' then
              begin
               d1915:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1930' then
              begin
               d1930:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1945' then
              begin
               d1945:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2000' then
              begin
               d2000:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2015' then
              begin
               d2015:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2030' then
              begin
               d2030:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2045' then
              begin
               d2045:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2100' then
              begin
               d2100:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2115' then
              begin
               d2115:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2130' then
              begin
               d2130:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2145' then
              begin
               d2145:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2200' then
              begin
               d2200:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2215' then
              begin
               d2215:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2230' then
              begin
               d2230:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2245' then
              begin
               d2245:=tabla.Fields[1].Asinteger;
              end;


     tabla.Next;
    end;


  modulo.conexion.BeginTrans;
  try


   sql:=' insert into plantilla (empresa, centro, desde, hasta, diferencia, dias, tp,'+
                                 'd0600,d0615,d0630,d0645,d0700,d0715,d0730,'+
                                 'd0745,d0800,d0815,d0830,d0845,d0900,d0915,'+
                                 'd0930,d0945,d1000,d1015,d1030,d1045,d1100,'+
                                 'd1115,d1130,d1145,d1200,d1215,d1230,d1245,d1300,'+
                                 'd1315,d1330,d1345,d1400,d1415,d1430,d1445,d1500,'+
                                 'd1515,d1530,d1545,d1600,d1615,d1630,d1645,d1700,'+
                                 'd1715,d1730,d1745,d1800,d1815,d1830,d1845,d1900,'+
                                 'd1915,d1930,d1945,d2000,d2015,d2030,d2045,d2100,'+
                                 'd2115,d2130,d2145,d2200,d2215,d2230,d2245,hora_inicio, hora_fin, hora_i_desca, hora_f_desca, idusuarios) '+
                                 '  values ('+#39+trim(empresa)+#39+
                                 ','+#39+trim(centro)+#39+
                                 ', CONVERT(DATETIME,'+#39+desde+#39+',103)'+
                                 ', CONVERT(DATETIME,'+#39+hasta+#39+',103)'+
                                 ','+inttostr(diferencia)+
                                 ','+#39+trim(dias)+#39+
                                 ','+#39+trim(tp)+#39+
                                 ','+inttostr(d600)+
                                 ','+inttostr(d615)+
                                 ','+inttostr(d630)+
                                 ','+inttostr(d645)+
                                 ','+inttostr(d700)+
                                 ','+inttostr(d715)+
                                 ','+inttostr(d730)+
                                 ','+inttostr(d745)+
                                 ','+inttostr(d800)+
                                 ','+inttostr(d815)+
                                 ','+inttostr(d830)+
                                 ','+inttostr(d845)+
                                 ','+inttostr(d900)+
                                 ','+inttostr(d915)+
                                 ','+inttostr(d930)+
                                 ','+inttostr(d945)+
                                 ','+inttostr(d1000)+
                                 ','+inttostr(d1015)+
                                 ','+inttostr(d1030)+
                                 ','+inttostr(d1045)+
                                 ','+inttostr(d1100)+
                                 ','+inttostr(d1115)+
                                 ','+inttostr(d1130)+
                                 ','+inttostr(d1145)+
                                 ','+inttostr(d1200)+
                                 ','+inttostr(d1215)+
                                 ','+inttostr(d1230)+
                                 ','+inttostr(d1245)+
                                 ','+inttostr(d1300)+
                                 ','+inttostr(d1315)+
                                 ','+inttostr(d1330)+
                                 ','+inttostr(d1345)+
                                 ','+inttostr(d1400)+
                                 ','+inttostr(d1415)+
                                 ','+inttostr(d1430)+
                                 ','+inttostr(d1445)+
                                 ','+inttostr(d1500)+
                                 ','+inttostr(d1515)+
                                 ','+inttostr(d1530)+
                                 ','+inttostr(d1545)+
                                 ','+inttostr(d1600)+
                                 ','+inttostr(d1615)+
                                 ','+inttostr(d1630)+
                                 ','+inttostr(d1645)+
                                 ','+inttostr(d1700)+
                                 ','+inttostr(d1715)+
                                 ','+inttostr(d1730)+
                                 ','+inttostr(d1745)+
                                 ','+inttostr(d1800)+
                                 ','+inttostr(d1815)+
                                 ','+inttostr(d1830)+
                                 ','+inttostr(d1845)+
                                 ','+inttostr(d1900)+
                                 ','+inttostr(d1915)+
                                 ','+inttostr(d1930)+
                                 ','+inttostr(d1945)+
                                 ','+inttostr(d2000)+
                                 ','+inttostr(d2015)+
                                 ','+inttostr(d2030)+
                                 ','+inttostr(d2045)+
                                 ','+inttostr(d2100)+
                                 ','+inttostr(d2115)+
                                 ','+inttostr(d2130)+
                                 ','+inttostr(d2145)+
                                 ','+inttostr(d2200)+
                                 ','+inttostr(d2215)+
                                 ','+inttostr(d2230)+
                                 ','+inttostr(d2245)+','+#39+trim(hi)+#39+','+#39+trim(hf)+#39+','+#39+trim(hdi)+#39+','+#39+trim(hdf)+#39+','+inttostr(uglobal.ID_USUARIO_CONECTADO)+')';



                                 modulo.sql_global.Close;
                                 modulo.sql_global.SQL.Clear;
                                 modulo.sql_global.SQL.Add(sql);
                                 modulo.sql_global.ExecSQL;

                                 numero_plantilla:=Getnumero_plantilla;


  // guarda en acucitas
  {
  '+#39+trim(empresa)+#39+
                                 ','+#39+trim(centro)+#39+
                                 ', CONVERT(DATETIME,'+#39+desde+#39+',103)'+
                                 ', CONVERT(DATETIME,'+#39+hasta+#39+',103)'+
                                 ','+inttostr(diferencia)+
                                 ','+#39+trim(dias)+#39+
                                 ','+#39+trim(tp)+#39+
  }
  int_dias:=strtoint(dias);

  //if  int_dias=0 then

   for i:=0 to int_dias do
   begin
      if chequea_si_es_feriado_o_domingo(desde)=false then
     begin
      if es_lunes_a_viernes(desde)= true then
      begin
     sql:=' insert into acucitas (dp0600,dp0615,dp0630,dp0645,dp0700,dp0715,dp0730,'+
                                 'dp0745,dp0800,dp0815,dp0830,dp0845,dp0900,dp0915,'+
                                 'dp0930,dp0945,dp1000,dp1015,dp1030,dp1045,dp1100,'+
                                 'dp1115,dp1130,dp1145,dp1200,dp1215,dp1230,dp1245,dp1300,'+
                                 'dp1315,dp1330,dp1345,dp1400,dp1415,dp1430,dp1445,dp1500,'+
                                 'dp1515,dp1530,dp1545,dp1600,dp1615,dp1630,dp1645,dp1700,'+
                                 'dp1715,dp1730,dp1745,dp1800,dp1815,dp1830,dp1845,dp1900,'+
                                 'dp1915,dp1930,dp1945,dp2000,dp2015,dp2030,dp2045,dp2100,'+
                                 'dp2115,dp2130,dp2145,dp2200,dp2215,dp2230,dp2245,'+
                                 'dr0600,dr0615,dr0630,dr0645,dr0700,dr0715,dr0730,'+
                                 'dr0745,dr0800,dr0815,dr0830,dr0845,dr0900,dr0915,'+
                                 'dr0930,dr0945,dr1000,dr1015,dr1030,dr1045,dr1100,'+
                                 'dr1115,dr1130,dr1145,dr1200,dr1215,dr1230,dr1245,dr1300,'+
                                 'dr1315,dr1330,dr1345,dr1400,dr1415,dr1430,dr1445,dr1500,'+
                                 'dr1515,dr1530,dr1545,dr1600,dr1615,dr1630,dr1645,dr1700,'+
                                 'dr1715,dr1730,dr1745,dr1800,dr1815,dr1830,dr1845,dr1900,'+
                                 'dr1915,dr1930,dr1945,dr2000,dr2015,dr2030,dr2045,dr2100,'+
                                 'dr2115,dr2130,dr2145,dr2200,dr2215,dr2230,dr2245,empresa,centro,'+
                                 'fecha,tp, idplantilla)'+
                                 '  values ('+inttostr(d600)+
                                 ','+inttostr(d615)+
                                 ','+inttostr(d630)+
                                 ','+inttostr(d645)+
                                 ','+inttostr(d700)+
                                 ','+inttostr(d715)+
                                 ','+inttostr(d730)+
                                 ','+inttostr(d745)+
                                 ','+inttostr(d800)+
                                 ','+inttostr(d815)+
                                 ','+inttostr(d830)+
                                 ','+inttostr(d845)+
                                 ','+inttostr(d900)+
                                 ','+inttostr(d915)+
                                 ','+inttostr(d930)+
                                 ','+inttostr(d945)+
                                 ','+inttostr(d1000)+
                                 ','+inttostr(d1015)+
                                 ','+inttostr(d1030)+
                                 ','+inttostr(d1045)+
                                 ','+inttostr(d1100)+
                                 ','+inttostr(d1115)+
                                 ','+inttostr(d1130)+
                                 ','+inttostr(d1145)+
                                 ','+inttostr(d1200)+
                                 ','+inttostr(d1215)+
                                 ','+inttostr(d1230)+
                                 ','+inttostr(d1245)+
                                 ','+inttostr(d1300)+
                                 ','+inttostr(d1315)+
                                 ','+inttostr(d1330)+
                                 ','+inttostr(d1345)+
                                 ','+inttostr(d1400)+
                                 ','+inttostr(d1415)+
                                 ','+inttostr(d1430)+
                                 ','+inttostr(d1445)+
                                 ','+inttostr(d1500)+
                                 ','+inttostr(d1515)+
                                 ','+inttostr(d1530)+
                                 ','+inttostr(d1545)+
                                 ','+inttostr(d1600)+
                                 ','+inttostr(d1615)+
                                 ','+inttostr(d1630)+
                                 ','+inttostr(d1645)+
                                 ','+inttostr(d1700)+
                                 ','+inttostr(d1715)+
                                 ','+inttostr(d1730)+
                                 ','+inttostr(d1745)+
                                 ','+inttostr(d1800)+
                                 ','+inttostr(d1815)+
                                 ','+inttostr(d1830)+
                                 ','+inttostr(d1845)+
                                 ','+inttostr(d1900)+
                                 ','+inttostr(d1915)+
                                 ','+inttostr(d1930)+
                                 ','+inttostr(d1945)+
                                 ','+inttostr(d2000)+
                                 ','+inttostr(d2015)+
                                 ','+inttostr(d2030)+
                                 ','+inttostr(d2045)+
                                 ','+inttostr(d2100)+
                                 ','+inttostr(d2115)+
                                 ','+inttostr(d2130)+
                                 ','+inttostr(d2145)+
                                 ','+inttostr(d2200)+
                                 ','+inttostr(d2215)+
                                 ','+inttostr(d2230)+
                                 ','+inttostr(d2245)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+#39+trim(empresa)+#39+
                                 ','+#39+trim(centro)+#39+
                                 ', CONVERT(DATETIME,'+#39+desde+#39+',103)'+
                                 ','+inttostr(numero_plantilla)+','+inttostr(numero_plantilla)+')';



                                modulo.sql_global.Close;
                                modulo.sql_global.SQL.Clear;
                                modulo.sql_global.SQL.Add(sql);
                                modulo.sql_global.ExecSQL;
           end;  //es lunes a viernes
                end;  //es feriado o domingo
                               //armo fecha por dia
                               fe:=strtodate(desde);
                               fe:=fe + 1;
                               desde:=datetostr(fe);
                               ///------------------------

   end;


  //--------------------------


 modulo.conexion.CommitTrans;
 crear_plantilla:=true;
 except
 modulo.conexion.RollbackTrans;
 crear_plantilla:=false;
 end;




end;




function ttemplate.crear_plantilla_sabados(empresa,centro,desde,hasta:string;diferencia:integer;dias,tp:string;tabla:TRxMemoryData;hi,hf,hdi,hdf:string):boolean;
var numero_plantilla:longint;
sql:string;
i:longint;
fe:tdate;
int_dias:longint;
d600,d615,d630,d645,d700,d715,d730,d745,d800,d815,d830,d845,d900,d915,d930,d945:integer;
d1000,d1015,d1030,d1045,d1100,d1115,d1130,d1145,d1200,d1215,d1230,d1245,d1300:integer;
d1315,d1330,d1345,d1400,d1415,d1430,d1445,d1500,d1510,d1515,d1530,d1545,d1600:integer;
d1615,d1630,d1645,d1700,d1715,d1730,d1745,d1800,d1815,d1830,d1845,d1900:integer;
d1915,d1930,d1945,d2000,d2015,d2030,d2045,d2100,d2115,d2130,d2145,d2200:integer;
d2215,d2230,d2245,d2300,d2315,d2345,vacio:integer;
begin
vacio:=0;
d600:=0;
d615:=0;
d630:=0;
d645:=0;
d700:=0;
d715:=0;
d730:=0;
d745:=0;
d800:=0;
d815:=0;
d830:=0;
d845:=0;
d900:=0;
d915:=0;
d930:=0;
d945:=0;
d1000:=0;
d1015:=0;
d1030:=0;
d1045:=0;
d1100:=0;
d1115:=0;
d1130:=0;
d1145:=0;
d1200:=0;
d1215:=0;
d1230:=0;
d1245:=0;
d1300:=0;
d1315:=0;
d1330:=0;
d1345:=0;
d1400:=0;
d1415:=0;
d1430:=0;
d1445:=0;
d1500:=0;
d1510:=0;
d1515:=0;
d1530:=0;
d1545:=0;
d1600:=0;
d1615:=0;
d1630:=0;
d1645:=0;
d1700:=0;
d1715:=0;
d1730:=0;
d1745:=0;
d1800:=0;
d1815:=0;
d1830:=0;
d1845:=0;
d1900:=0;
d1915:=0;
d1930:=0;
d1945:=0;
d2000:=0;
d2015:=0;
d2030:=0;
d2045:=0;
d2100:=0;
d2115:=0;
d2130:=0;
d2145:=0;
d2200:=0;
d2215:=0;
d2230:=0;
d2245:=0;
d2300:=0;
d2315:=0;
d2345:=0;
crear_plantilla_sabados:=false;


 i:=0;
 tabla.Open;
 tabla.First;
  while not (tabla.Eof)  do
    begin

             if tabla.Fields[0].AsString='600' then
              begin
               d600:=tabla.Fields[1].Asinteger;
              end;

             if tabla.Fields[0].AsString='615' then
              begin
               d615:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='630' then
              begin
               d630:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='645' then
              begin
               d645:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='700' then
              begin
               d700:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='715' then
              begin
               d715:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='730' then
              begin
               d730:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='745' then
              begin
               d745:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='800' then
              begin
               d800:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='815' then
              begin
               d815:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='830' then
              begin
               d830:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='845' then
              begin
               d845:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='900' then
              begin
               d900:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='915' then
              begin
               d915:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='930' then
              begin
               d930:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='945' then
              begin
               d945:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1000' then
              begin
               d1000:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1015' then
              begin
               d1015:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1030' then
              begin
               d1030:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1045' then
              begin
               d1045:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1100' then
              begin
               d1100:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1115' then
              begin
               d1115:=tabla.Fields[1].Asinteger;
              end;


           if tabla.Fields[0].AsString='1130' then
              begin
               d1130:=tabla.Fields[1].Asinteger;
              end;

              if tabla.Fields[0].AsString='1145' then
              begin
               d1145:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1200' then
              begin
               d1200:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1215' then
              begin
               d1215:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1230' then
              begin
               d1230:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1245' then
              begin
               d1245:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1300' then
              begin
               d1300:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1315' then
              begin
               d1315:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1330' then
              begin
               d1330:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1345' then
              begin
               d1345:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1400' then
              begin
               d1400:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1415' then
              begin
               d1415:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1430' then
              begin
               d1430:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1445' then
              begin
               d1445:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1500' then
              begin
               d1500:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1515' then
              begin
               d1515:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1530' then
              begin
               d1530:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1545' then
              begin
               d1545:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1600' then
              begin
               d1600:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1615' then
              begin
               d1615:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1630' then
              begin
               d1630:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1645' then
              begin
               d1645:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1700' then
              begin
               d1700:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1715' then
              begin
               d1715:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1730' then
              begin
               d1730:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1745' then
              begin
               d1745:=tabla.Fields[1].Asinteger;
              end;

             if tabla.Fields[0].AsString='1800' then
              begin
               d1800:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1815' then
              begin
               d1815:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1830' then
              begin
               d1830:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1845' then
              begin
               d1845:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1900' then
              begin
               d1900:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1915' then
              begin
               d1915:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1930' then
              begin
               d1930:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='1945' then
              begin
               d1945:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2000' then
              begin
               d2000:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2015' then
              begin
               d2015:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2030' then
              begin
               d2030:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2045' then
              begin
               d2045:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2100' then
              begin
               d2100:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2115' then
              begin
               d2115:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2130' then
              begin
               d2130:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2145' then
              begin
               d2145:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2200' then
              begin
               d2200:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2215' then
              begin
               d2215:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2230' then
              begin
               d2230:=tabla.Fields[1].Asinteger;
              end;
              if tabla.Fields[0].AsString='2245' then
              begin
               d2245:=tabla.Fields[1].Asinteger;
              end;


     tabla.Next;
    end;


  modulo.conexion.BeginTrans;
  try

 desde:=genera_el_desde_para_sabado(desde,dias);
 hasta:=genera_el_hasta_para_sabado(hasta,dias);



 
   sql:=' insert into plantilla (empresa, centro, desde, hasta, diferencia, dias, tp,'+
                                 'd0600,d0615,d0630,d0645,d0700,d0715,d0730,'+
                                 'd0745,d0800,d0815,d0830,d0845,d0900,d0915,'+
                                 'd0930,d0945,d1000,d1015,d1030,d1045,d1100,'+
                                 'd1115,d1130,d1145,d1200,d1215,d1230,d1245,d1300,'+
                                 'd1315,d1330,d1345,d1400,d1415,d1430,d1445,d1500,'+
                                 'd1515,d1530,d1545,d1600,d1615,d1630,d1645,d1700,'+
                                 'd1715,d1730,d1745,d1800,d1815,d1830,d1845,d1900,'+
                                 'd1915,d1930,d1945,d2000,d2015,d2030,d2045,d2100,'+
                                 'd2115,d2130,d2145,d2200,d2215,d2230,d2245,hora_inicio, hora_fin, hora_i_desca, hora_f_desca, idusuarios) '+
                                 '  values ('+#39+trim(empresa)+#39+
                                 ','+#39+trim(centro)+#39+
                                 ', CONVERT(DATETIME,'+#39+desde+#39+',103)'+
                                 ', CONVERT(DATETIME,'+#39+hasta+#39+',103)'+
                                 ','+inttostr(diferencia)+
                                 ','+#39+trim(dias)+#39+
                                 ','+#39+trim(tp)+#39+
                                 ','+inttostr(d600)+
                                 ','+inttostr(d615)+
                                 ','+inttostr(d630)+
                                 ','+inttostr(d645)+
                                 ','+inttostr(d700)+
                                 ','+inttostr(d715)+
                                 ','+inttostr(d730)+
                                 ','+inttostr(d745)+
                                 ','+inttostr(d800)+
                                 ','+inttostr(d815)+
                                 ','+inttostr(d830)+
                                 ','+inttostr(d845)+
                                 ','+inttostr(d900)+
                                 ','+inttostr(d915)+
                                 ','+inttostr(d930)+
                                 ','+inttostr(d945)+
                                 ','+inttostr(d1000)+
                                 ','+inttostr(d1015)+
                                 ','+inttostr(d1030)+
                                 ','+inttostr(d1045)+
                                 ','+inttostr(d1100)+
                                 ','+inttostr(d1115)+
                                 ','+inttostr(d1130)+
                                 ','+inttostr(d1145)+
                                 ','+inttostr(d1200)+
                                 ','+inttostr(d1215)+
                                 ','+inttostr(d1230)+
                                 ','+inttostr(d1245)+
                                 ','+inttostr(d1300)+
                                 ','+inttostr(d1315)+
                                 ','+inttostr(d1330)+
                                 ','+inttostr(d1345)+
                                 ','+inttostr(d1400)+
                                 ','+inttostr(d1415)+
                                 ','+inttostr(d1430)+
                                 ','+inttostr(d1445)+
                                 ','+inttostr(d1500)+
                                 ','+inttostr(d1515)+
                                 ','+inttostr(d1530)+
                                 ','+inttostr(d1545)+
                                 ','+inttostr(d1600)+
                                 ','+inttostr(d1615)+
                                 ','+inttostr(d1630)+
                                 ','+inttostr(d1645)+
                                 ','+inttostr(d1700)+
                                 ','+inttostr(d1715)+
                                 ','+inttostr(d1730)+
                                 ','+inttostr(d1745)+
                                 ','+inttostr(d1800)+
                                 ','+inttostr(d1815)+
                                 ','+inttostr(d1830)+
                                 ','+inttostr(d1845)+
                                 ','+inttostr(d1900)+
                                 ','+inttostr(d1915)+
                                 ','+inttostr(d1930)+
                                 ','+inttostr(d1945)+
                                 ','+inttostr(d2000)+
                                 ','+inttostr(d2015)+
                                 ','+inttostr(d2030)+
                                 ','+inttostr(d2045)+
                                 ','+inttostr(d2100)+
                                 ','+inttostr(d2115)+
                                 ','+inttostr(d2130)+
                                 ','+inttostr(d2145)+
                                 ','+inttostr(d2200)+
                                 ','+inttostr(d2215)+
                                 ','+inttostr(d2230)+
                                 ','+inttostr(d2245)+','+#39+trim(hi)+#39+','+#39+trim(hf)+#39+','+#39+trim(hdi)+#39+','+#39+trim(hdf)+#39+','+inttostr(uglobal.ID_USUARIO_CONECTADO)+')';



                                 modulo.sql_global.Close;
                                 modulo.sql_global.SQL.Clear;
                                 modulo.sql_global.SQL.Add(sql);
                                 modulo.sql_global.ExecSQL;

                                 numero_plantilla:=Getnumero_plantilla;


  // guarda en acucitas
  {
  '+#39+trim(empresa)+#39+
                                 ','+#39+trim(centro)+#39+
                                 ', CONVERT(DATETIME,'+#39+desde+#39+',103)'+
                                 ', CONVERT(DATETIME,'+#39+hasta+#39+',103)'+
                                 ','+inttostr(diferencia)+
                                 ','+#39+trim(dias)+#39+
                                 ','+#39+trim(tp)+#39+
  }
  int_dias:=strtoint(dias);

  //if  int_dias=0 then

   for i:=0 to int_dias do
   begin
      if chequea_si_es_feriado_o_domingo(desde)=false then
     begin

      if es_sabado(desde)= true then
      begin
     sql:=' insert into acucitas (dp0600,dp0615,dp0630,dp0645,dp0700,dp0715,dp0730,'+
                                 'dp0745,dp0800,dp0815,dp0830,dp0845,dp0900,dp0915,'+
                                 'dp0930,dp0945,dp1000,dp1015,dp1030,dp1045,dp1100,'+
                                 'dp1115,dp1130,dp1145,dp1200,dp1215,dp1230,dp1245,dp1300,'+
                                 'dp1315,dp1330,dp1345,dp1400,dp1415,dp1430,dp1445,dp1500,'+
                                 'dp1515,dp1530,dp1545,dp1600,dp1615,dp1630,dp1645,dp1700,'+
                                 'dp1715,dp1730,dp1745,dp1800,dp1815,dp1830,dp1845,dp1900,'+
                                 'dp1915,dp1930,dp1945,dp2000,dp2015,dp2030,dp2045,dp2100,'+
                                 'dp2115,dp2130,dp2145,dp2200,dp2215,dp2230,dp2245,'+
                                 'dr0600,dr0615,dr0630,dr0645,dr0700,dr0715,dr0730,'+
                                 'dr0745,dr0800,dr0815,dr0830,dr0845,dr0900,dr0915,'+
                                 'dr0930,dr0945,dr1000,dr1015,dr1030,dr1045,dr1100,'+
                                 'dr1115,dr1130,dr1145,dr1200,dr1215,dr1230,dr1245,dr1300,'+
                                 'dr1315,dr1330,dr1345,dr1400,dr1415,dr1430,dr1445,dr1500,'+
                                 'dr1515,dr1530,dr1545,dr1600,dr1615,dr1630,dr1645,dr1700,'+
                                 'dr1715,dr1730,dr1745,dr1800,dr1815,dr1830,dr1845,dr1900,'+
                                 'dr1915,dr1930,dr1945,dr2000,dr2015,dr2030,dr2045,dr2100,'+
                                 'dr2115,dr2130,dr2145,dr2200,dr2215,dr2230,dr2245,empresa,centro,'+
                                 'fecha,tp, idplantilla)'+
                                 '  values ('+inttostr(d600)+
                                 ','+inttostr(d615)+
                                 ','+inttostr(d630)+
                                 ','+inttostr(d645)+
                                 ','+inttostr(d700)+
                                 ','+inttostr(d715)+
                                 ','+inttostr(d730)+
                                 ','+inttostr(d745)+
                                 ','+inttostr(d800)+
                                 ','+inttostr(d815)+
                                 ','+inttostr(d830)+
                                 ','+inttostr(d845)+
                                 ','+inttostr(d900)+
                                 ','+inttostr(d915)+
                                 ','+inttostr(d930)+
                                 ','+inttostr(d945)+
                                 ','+inttostr(d1000)+
                                 ','+inttostr(d1015)+
                                 ','+inttostr(d1030)+
                                 ','+inttostr(d1045)+
                                 ','+inttostr(d1100)+
                                 ','+inttostr(d1115)+
                                 ','+inttostr(d1130)+
                                 ','+inttostr(d1145)+
                                 ','+inttostr(d1200)+
                                 ','+inttostr(d1215)+
                                 ','+inttostr(d1230)+
                                 ','+inttostr(d1245)+
                                 ','+inttostr(d1300)+
                                 ','+inttostr(d1315)+
                                 ','+inttostr(d1330)+
                                 ','+inttostr(d1345)+
                                 ','+inttostr(d1400)+
                                 ','+inttostr(d1415)+
                                 ','+inttostr(d1430)+
                                 ','+inttostr(d1445)+
                                 ','+inttostr(d1500)+
                                 ','+inttostr(d1515)+
                                 ','+inttostr(d1530)+
                                 ','+inttostr(d1545)+
                                 ','+inttostr(d1600)+
                                 ','+inttostr(d1615)+
                                 ','+inttostr(d1630)+
                                 ','+inttostr(d1645)+
                                 ','+inttostr(d1700)+
                                 ','+inttostr(d1715)+
                                 ','+inttostr(d1730)+
                                 ','+inttostr(d1745)+
                                 ','+inttostr(d1800)+
                                 ','+inttostr(d1815)+
                                 ','+inttostr(d1830)+
                                 ','+inttostr(d1845)+
                                 ','+inttostr(d1900)+
                                 ','+inttostr(d1915)+
                                 ','+inttostr(d1930)+
                                 ','+inttostr(d1945)+
                                 ','+inttostr(d2000)+
                                 ','+inttostr(d2015)+
                                 ','+inttostr(d2030)+
                                 ','+inttostr(d2045)+
                                 ','+inttostr(d2100)+
                                 ','+inttostr(d2115)+
                                 ','+inttostr(d2130)+
                                 ','+inttostr(d2145)+
                                 ','+inttostr(d2200)+
                                 ','+inttostr(d2215)+
                                 ','+inttostr(d2230)+
                                 ','+inttostr(d2245)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+inttostr(vacio)+
                                 ','+#39+trim(empresa)+#39+
                                 ','+#39+trim(centro)+#39+
                                 ', CONVERT(DATETIME,'+#39+desde+#39+',103)'+
                                 ','+inttostr(numero_plantilla)+','+inttostr(numero_plantilla)+')';



                                modulo.sql_global.Close;
                                modulo.sql_global.SQL.Clear;
                                modulo.sql_global.SQL.Add(sql);
                                modulo.sql_global.ExecSQL;
                               end; //es sabado
                               end;  //esferiado y domingos
                               //armo fecha por dia
                               fe:=strtodate(desde);
                               fe:=fe + 1;
                               desde:=datetostr(fe);
                               ///------------------------

   end;


  //--------------------------


 modulo.conexion.CommitTrans;
 crear_plantilla_sabados:=true;
 except
 modulo.conexion.RollbackTrans;
 crear_plantilla_sabados:=false;
 end;




end;





end.
