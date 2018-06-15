unit Ufunciones;
interface
uses Umodulo, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,DateUtils,
  Dialogs, StdCtrls, Grids, DBGrids, DB, Buttons, ExtCtrls,UGLOBAL,Registry,USuperRegistry,uconst;

 type
tfuncion = class
  protected
  sql:string;
  public
    function conexion_virtual(base:string):boolean;
    function GetRegistryData(RootKey: HKEY; Key, Value: string): variant;
    function busca_nombr_empresa(empre:string):string;
    function busca_nombr_centro(planta:string):string;
    function busca_turnos_por_fecha_seleccionada(fecha_se:string):boolean;
    function busca_turnos_patene(dominio:string):boolean;
    function modifica_estado(idreserva,idestado:longint):boolean;
    function genera_reporte_de_turnos(fecha_se:string):boolean;
    function devuelve_cantidad_turnos_fecha(fecha:string):longint;
    function existe_fecha(fecha_se,fe_de:string;numero:longint;tipo:string):boolean;
    function exite_plantilla(fechad,fechah:string;numero:longint):boolean;
    function extrae_hora_centro(idcentro:string):boolean;
    function carga_plantillas_para_copia:boolean;
    function carga_canti_plantillas_para_copia(nume:longint):boolean;
    function copiar_plantilla(numero_plantilla:longint):boolean;
    function muestra_grilla_para_modificar(numero:longint):boolean;
    function muestra_grilla_para_ver(numero:longint):boolean;
    function muestra_grilla_acucistas_ver(numero:longint):boolean;
    procedure SetRegistryData(RootKey: HKEY; Key, Value: string; RegDataType: TRegDataType; Data: variant);
      function busca_por_codigo_reserva(codigo:string):boolean;
  end;

implementation
uses Ucrear_plantilla,uprincipal,Umodificar_plantillas,uver_plantillas, uplantillas;

  function tfuncion.busca_por_codigo_reserva(codigo:string):boolean;
var sql:string;
begin
//uglobal.ID_EMPRESA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Empresa');
//uglobal.ID_PLANTA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');


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



busca_por_codigo_reserva:=false;

if (uglobal.TIPO_USUARIO_CONECTADO=4)or (uglobal.TIPO_USUARIO_CONECTADO=0)  then
begin

{
sql:='select r.patente as rpatente, r.nombre +'' ''+ r.apellido as rnombre, r.telefono as rtelefono, r.hora as rhora, r.fecha as rfecha, e.estado as eestado, r.numero as rnumero, '+
      ' r.codigo as codigoreserva, c.nombre as cnombre, r.celu_carac +'' ''+ r.celu_numero as celular from reserva r, estados e , centros c where r.empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+
     ' and  r.patente='+#39+trim(dominio)+#39+'  and r.codestado = e.codestado  and r.centro = c.centro   group by  r.hora , r.fecha , r.patente , r.nombre , r.apellido , r.telefono , e.estado , r.numero , '+
      ' r.codigo , c.nombre  r.celu_carac , r.celu_numero  order by r.hora asc';
 }
sql:='SELECT     r.patente AS rpatente, r.hora AS rhora, r.fecha AS rfecha, c.Nombre AS cnombre, r.Empresa AS rempresa, r.nombre + ''  '' + r.apellido AS rnombre, r.codigo as codigoreserva, '+
       ' r.telefono AS rtelefono, r.telefono as rtelefono, e.estado AS eestado, r.numero as rnumero  '+
' FROM         reserva r INNER JOIN   '+
                 '     estados e ON r.codestado = e.codestado INNER JOIN   '+
                  '    Centros c ON r.centro = c.Centro     '+
' WHERE      (r.codigo='+#39+trim(codigo)+#39+') '+
 ' order by r.hora asc';
end else
begin
sql:='SELECT     r.patente AS rpatente, r.hora AS rhora, r.fecha AS rfecha, c.Nombre AS cnombre, r.Empresa AS rempresa, r.nombre + ''  '' + r.apellido AS rnombre, r.codigo as codigoreserva, '+
       ' r.telefono AS rtelefono,r.telefono as rtelefono, e.estado AS eestado, r.numero as rnumero   '+
' FROM         reserva r INNER JOIN   '+
                 '     estados e ON r.codestado = e.codestado INNER JOIN   '+
                  '    Centros c ON r.centro = c.Centro     '+
' WHERE     (c.Centro = '+#39+trim(uglobal.ID_PLANTA)+#39+')and  (r.codigo='+#39+trim(codigo)+#39+')  AND (r.Empresa = '+#39+trim(uglobal.ID_EMPRESA)+#39+' )  '+
 ' order by r.hora asc';


end;

modulo.sql_buscA_por_fecha.Close;
modulo.sql_buscA_por_fecha.SQL.Clear;
modulo.sql_buscA_por_fecha.SQL.Add(sql);
modulo.sql_buscA_por_fecha.ExecSQL;
modulo.sql_buscA_por_fecha.Open;
if modulo.sql_buscA_por_fecha.RecordCount > 0 then
   busca_por_codigo_reserva:=true;
end;




procedure tfuncion.SetRegistryData(RootKey: HKEY; Key, Value: string; RegDataType: TRegDataType; Data: variant);
var
  Reg: TRegistry;
  s: string;
begin
  Reg := TRegistry.Create(KEY_WRITE);
  try
    Reg.RootKey := RootKey;
    if Reg.OpenKey(Key, True) then begin
      try
        if RegDataType = rdUnknown then
          RegDataType := Reg.GetDataType(Value);
        if RegDataType = rdString then
          Reg.WriteString(Value, Data)
        else if RegDataType = rdExpandString then
          Reg.WriteExpandString(Value, Data)
        else if RegDataType = rdInteger then
          Reg.WriteInteger(Value, Data)
        else if RegDataType = rdBinary then begin
          s := Data;
          Reg.WriteBinaryData(Value, PChar(s)^, Length(s));
        end else
          raise Exception.Create(SysErrorMessage(ERROR_CANTWRITE));
      except
        Reg.CloseKey;
        raise;
      end;
      Reg.CloseKey;
    end else
      raise Exception.Create(SysErrorMessage(GetLastError));
  finally
    Reg.Free;
  end;
end;


function tfuncion.muestra_grilla_acucistas_ver(numero:longint):boolean;
var i:longint;
busca:string;
posi,intervalo,j:longint;
begin

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


//uglobal.ID_EMPRESA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Empresa');
//uglobal.ID_PLANTA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');

   modulo.sql_global.Close;
   modulo.sql_global.SQL.Clear;
   modulo.sql_global.SQL.Add(' select fecha, '+
                              ' DP0600, '+
	' DP0615 , '+
	' DP0630 , '+
	' DP0645 , '+
	' DP0700 , '+
	' DP0715 , '+
	' DP0730 , '+
	' DP0745 , '+
	' DP0800 , '+
	' DP0815 , '+
	' DP0830 , '+
	' DP0845 , '+
	' DP0900 , '+
	' DP0915 , '+
	' DP0930 , '+
	' DP0945  , '+
	' DP1000 , '+
 '	DP1015 , '+
 '	DP1030 , '+
 '	DP1045 , '+
 '	DP1100, '+
 '	DP1115 , '+
 '	DP1130 , '+
 '  DP1145 , '+
 '  DP1200 , '+
 '	DP1215 , '+
 '	DP1230 , '+
 '	DP1245 , '+
 '	DP1300 , '+
 '	DP1315, '+
 '	DP1330, '+
 '	DP1345, '+
 '	DP1400, '+
 '	DP1415, '+
 '	DP1430, '+
 '	DP1445, '+
 '	DP1500, '+
 '	DP1515, '+
 '	DP1530, '+
 '	DP1545, '+
 '	DP1600, '+
 '	DP1615, '+
 '	DP1630, '+
 '	DP1645, '+
 '	DP1700, '+
 '	DP1715, '+
 '	DP1730, '+
 '	DP1745, '+
 '	DP1800, '+
 ' DP1815, '+
 '	DP1830, '+
'	DP1845, '+
'	DP1900, '+
'	DP1915, '+
'	DP1930, '+
'	DP1945, '+
'	DP2000, '+
'	DP2015, '+
'	DP2030, '+
'	DP2045, '+
'	DP2100, '+
'	DP2115, '+
'	DP2130, '+
'	DP2145, '+
'	DP2200, '+
'	DP2215, '+
'	DP2230 , '+
' DP2245 from acucitas where  empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and centro='+#39+trim(uglobal.ID_PLANTA)+#39+' and tp ='+inttostr(numero)+' order by fecha asc');
   modulo.sql_global.ExecSQL;
   modulo.sql_global.Open;
    if modulo.sql_global.RecordCount > 0 then
     begin

 for j:=1 to modulo.sql_global.recordcount do
 begin


         ver_plantillas.grilla_acucitas.Open;
      ver_plantillas.grilla_acucitas.append;

     ver_plantillas.dbgrid2.Enabled:=true;
          for i:=0 to ver_plantillas.dbgrid2.Columns.Count - 1 do
             begin
                ver_plantillas.dbgrid2.Columns[i].Visible:=falsE;


                 if modulo.sql_global.Fields[i].AsString <>'0' then
                  begin
                    ver_plantillas.grilla_acucitas.edit;
                   ver_plantillas.dbgrid2.Columns[i].Visible:=true;

                    ver_plantillas.dbgrid2.Columns[i].ReadOnly:=false;
                    ver_plantillas.dbgrid2.Columns[i].Field.AsString :=modulo.sql_global.Fields[i].AsString;
                   ver_plantillas.grilla_acucitas.post;
                   end;

              end;





        modulo.sql_global.Next;
      end;



 end;

end;






function tfuncion.muestra_grilla_para_ver(numero:longint):boolean;
var i:longint;
busca:string;
posi,intervalo:longint;
begin
//uglobal.ID_EMPRESA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Empresa');
//uglobal.ID_PLANTA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');
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

   modulo.sql_global.Close;
   modulo.sql_global.SQL.Clear;
   modulo.sql_global.SQL.Add(' select '+
                              ' D0600, '+
	' D0615 , '+
	' D0630 , '+
	' D0645 , '+
	' D0700 , '+
	' D0715 , '+
	' D0730 , '+
	' D0745 , '+
	' D0800 , '+
	' D0815 , '+
	' D0830 , '+
	' D0845 , '+
	' D0900 , '+
	' D0915 , '+
	' D0930 , '+
	' D0945  , '+
	' D1000 , '+
 '	D1015 , '+
 '	D1030 , '+
 '	D1045 , '+
 '	D1100, '+
 '	D1115 , '+
 '	D1130 , '+
 '  D1145 , '+
 '  D1200 , '+
 '	D1215 , '+
 '	D1230 , '+
 '	D1245 , '+
 '	D1300 , '+
 '	D1315, '+
 '	D1330, '+
 '	D1345, '+
 '	D1400, '+
 '	D1415, '+
 '	D1430, '+
 '	D1445, '+
 '	D1500, '+
 '	D1515, '+
 '	D1530, '+
 '	D1545, '+
 '	D1600, '+
 '	D1615, '+
 '	D1630, '+
 '	D1645, '+
 '	D1700, '+
 '	D1715, '+
 '	D1730, '+
 '	D1745, '+
 '	D1800, '+
 ' D1815, '+
 '	D1830, '+
'	D1845, '+
'	D1900, '+
'	D1915, '+
'	D1930, '+
'	D1945, '+
'	D2000, '+
'	D2015, '+
'	D2030, '+
'	D2045, '+
'	D2100, '+
'	D2115, '+
'	D2130, '+
'	D2145, '+
'	D2200, '+
'	D2215, '+
'	D2230 , '+
' D2245 from plantilla where empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and centro='+#39+trim(uglobal.ID_PLANTA)+#39+' and numero ='+inttostr(numero));
   modulo.sql_global.ExecSQL;
   modulo.sql_global.Open;
    if modulo.sql_global.RecordCount > 0 then
     begin




         ver_plantillas.genera_grilla.Open;
      ver_plantillas.genera_grilla.Insert;

     ver_plantillas.dbgrid1.Enabled:=true;
          for i:=0 to ver_plantillas.dbgrid1.Columns.Count - 1 do
             begin
                ver_plantillas.dbgrid1.Columns[i].Visible:=falsE;


                 if modulo.sql_global.Fields[i].AsString <>'0' then
                  begin
                    ver_plantillas.genera_grilla.edit;
                   ver_plantillas.dbgrid1.Columns[i].Visible:=true;

                    ver_plantillas.dbgrid1.Columns[i].ReadOnly:=false;
                    ver_plantillas.dbgrid1.Columns[i].Field.AsString :=modulo.sql_global.Fields[i].AsString;
                   ver_plantillas.genera_grilla.post;
                   end;

              end;




      end;


end;




function tfuncion.muestra_grilla_para_modificar(numero:longint):boolean;
var i:longint;
busca:string;
posi,intervalo:longint;
descanso_i,descanso_f,desca_hora:string;
cont,por:longint;
intervalo_des:longint;
begin
//uglobal.ID_EMPRESA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Empresa');
//uglobal.ID_PLANTA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');

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
   modulo.sql_global.Close;
   modulo.sql_global.SQL.Clear;
   modulo.sql_global.SQL.Add(' select '+
                              ' D0600, '+
	' D0615 , '+
	' D0630 , '+
	' D0645 , '+
	' D0700 , '+
	' D0715 , '+
	' D0730 , '+
	' D0745 , '+
	' D0800 , '+
	' D0815 , '+
	' D0830 , '+
	' D0845 , '+
	' D0900 , '+
	' D0915 , '+
	' D0930 , '+
	' D0945  , '+
	' D1000 , '+
 '	D1015 , '+
 '	D1030 , '+
 '	D1045 , '+
 '	D1100, '+
 '	D1115 , '+
 '	D1130 , '+
 '  D1145 , '+
 '  D1200 , '+
 '	D1215 , '+
 '	D1230 , '+
 '	D1245 , '+
 '	D1300 , '+
 '	D1315, '+
 '	D1330, '+
 '	D1345, '+
 '	D1400, '+
 '	D1415, '+
 '	D1430, '+
 '	D1445, '+
 '	D1500, '+
 '	D1515, '+
 '	D1530, '+
 '	D1545, '+
 '	D1600, '+
 '	D1615, '+
 '	D1630, '+
 '	D1645, '+
 '	D1700, '+
 '	D1715, '+
 '	D1730, '+
 '	D1745, '+
 '	D1800, '+
 ' D1815, '+
 '	D1830, '+
'	D1845, '+
'	D1900, '+
'	D1915, '+
'	D1930, '+
'	D1945, '+
'	D2000, '+
'	D2015, '+
'	D2030, '+
'	D2045, '+
'	D2100, '+
'	D2115, '+
'	D2130, '+
'	D2145, '+
'	D2200, '+
'	D2215, '+
'	D2230 , '+
' D2245, hora_i_desca, hora_f_desca  from plantilla where  empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and centro='+#39+trim(uglobal.ID_PLANTA)+#39+' and numero ='+inttostr(numero));
   modulo.sql_global.ExecSQL;
   modulo.sql_global.Open;
    if modulo.sql_global.RecordCount > 0 then
     begin

     if modificar_plantillas.checkbox1.Checked then
begin
descanso_i:=trim(modificar_plantillas.edit7.Text)+trim(modificar_plantillas.edit8.Text);
descanso_f:=trim(modificar_plantillas.edit9.Text)+trim(modificar_plantillas.edit10.Text);

intervalo_des:=strtoint(descanso_i);
while intervalo_des <=(strtoint(descanso_f)-15) do
begin


   for i:=0 to modificar_plantillas.dbgrid1.Columns.Count - 1 do
    begin

          if  (modificar_plantillas.dbgrid1.Columns[i].FieldName = inttostr(intervalo_des)) then
           begin
                 modificar_plantillas.dbgrid1.Columns[i].Visible:=true ;
                 modificar_plantillas.dbgrid1.Columns[i].ReadOnly:=true ;
                 modificar_plantillas.dbgrid1.Columns[i].Color:=clred;
             break;
            end;

     end;

  cont:=cont + 15;
 if cont>45 then
   begin
   por:=por + 1;
   cont:=0;
     descanso_i:=desca_hora+'00';
    intervalo_des:=strtoint(descanso_i)+(100*por);



   end else
   begin
     intervalo_des:=intervalo_des + 15;
   end;



end;

end;






     {
                if trim(modulo.sql_global.FieldByName('hora_i_desca').AsString)<>'' then
                              begin
                posi:=pos(':',trim(modulo.sql_global.FieldByName('hora_i_desca').AsString));
                busca:=trim(copy(trim(modulo.sql_global.FieldByName('hora_i_desca').AsString),0,posi-1))+trim(copy(trim(modulo.sql_global.FieldByName('hora_i_desca').AsString),posi+1,length(modulo.sql_global.FieldByName('hora_i_desca').AsString)));
                intervalo:=strtoint(busca);

                end;
      }

         modificar_plantillas.genera_grilla.Open;
      modificar_plantillas.genera_grilla.Insert;

     modificar_plantillas.dbgrid1.Enabled:=true;
          for i:=0 to modificar_plantillas.dbgrid1.Columns.Count - 1 do
             begin
                //modificar_plantillas.dbgrid1.Columns[i].Visible:=falsE;

                {
                  if trim(modificar_plantillas.dbgrid1.Columns[i].FieldName)=busca then
                     begin

                                   modificar_plantillas.dbgrid1.Columns[i].Visible:=true;

                                     modificar_plantillas.dbgrid1.Columns[i].ReadOnly:=true;




                     end;
                    intervalo:=intervalo + 15;
                    busca:=inttostr(intervalo);
                   }

                 if modulo.sql_global.Fields[i].AsString <>'0' then
                  begin
                    modificar_plantillas.genera_grilla.edit;
                   modificar_plantillas.dbgrid1.Columns[i].Visible:=true;
                     modificar_plantillas.dbgrid1.Columns[i].Color:=clgreen;
                    modificar_plantillas.dbgrid1.Columns[i].ReadOnly:=false;
                    modificar_plantillas.dbgrid1.Columns[i].Field.AsString :=modulo.sql_global.Fields[i].AsString;
                   modificar_plantillas.genera_grilla.post;
                   end;

              end;




      end;
     {
     modificar_plantillas.DBGrid1.Enabled:=true;
      modificar_plantillas.genera_grilla.Open;
      modificar_plantillas.genera_grilla.Insert;
       if modulo.sql_global.fields[0].asstring<>'0' then
          begin
           modificar_plantillas.DBGrid1.Columns[0].Visible:=true;
           modificar_plantillas.genera_grillaField6.Value:=modulo.sql_global.fields[0].asstring;
         end;

        if modulo.sql_global.fields[1].asstring<>'0' then
          begin
           modificar_plantillas.DBGrid1.Columns[1].Visible:=true;
       modificar_plantillas.genera_grillaField615.value:=modulo.sql_global.fields[1].asstring;
       end;



       modificar_plantillas.genera_grillaField630.value:=modulo.sql_global.fields[2].asstring;
       modificar_plantillas.genera_grillaField645.value:=modulo.sql_global.fields[3].asstring;
       modificar_plantillas.genera_grillaField7.Value:=modulo.sql_global.fields[4].asstring;
       modificar_plantillas.genera_grillaField715.Value:=modulo.sql_global.fields[5].asstring;
       modificar_plantillas.genera_grillaField730.Value:=modulo.sql_global.fields[6].asstring;
       modificar_plantillas.genera_grillaField745.Value:=modulo.sql_global.fields[7].asstring;
       modificar_plantillas.genera_grillaField8.Value:=modulo.sql_global.fields[8].asstring;
       modificar_plantillas.genera_grillaField815.Value:=modulo.sql_global.fields[9].asstring;
       modificar_plantillas.genera_grillaField830.Value:=modulo.sql_global.fields[10].asstring;
       modificar_plantillas.genera_grillaField845.Value:=modulo.sql_global.fields[11].asstring;
       modificar_plantillas.genera_grillaField9.Value:=modulo.sql_global.fields[12].asstring;
       modificar_plantillas.genera_grillaField915.Value:=modulo.sql_global.fields[13].asstring;
       modificar_plantillas.genera_grillaField930.Value:=modulo.sql_global.fields[14].asstring;
       modificar_plantillas.genera_grillaField945.Value:=modulo.sql_global.fields[15].asstring;
       modificar_plantillas.genera_grillaField10.Value:=modulo.sql_global.fields[16].asstring;
       modificar_plantillas.genera_grillaField1015.Value:=modulo.sql_global.fields[17].asstring;
       modificar_plantillas.genera_grillaField1030.Value:=modulo.sql_global.fields[18].asstring;
       modificar_plantillas.genera_grillaField1045.Value:=modulo.sql_global.fields[19].asstring;
       modificar_plantillas.genera_grillaField11.Value:=modulo.sql_global.fields[20].asstring;
       modificar_plantillas.genera_grillaField1115.Value:=modulo.sql_global.fields[21].asstring;
       modificar_plantillas.genera_grillaField1130.Value:=modulo.sql_global.fields[22].asstring;
       modificar_plantillas.genera_grillaField1145.Value:=modulo.sql_global.fields[23].asstring;
       modificar_plantillas.genera_grillaField12.Value:=modulo.sql_global.fields[24].asstring;
       modificar_plantillas.genera_grillaField1215.Value:=modulo.sql_global.fields[25].asstring;
       modificar_plantillas.genera_grillaField1230.Value:=modulo.sql_global.fields[26].asstring;
       modificar_plantillas.genera_grillaField1245.Value:=modulo.sql_global.fields[27].asstring;
       modificar_plantillas.genera_grillaField13.Value:=modulo.sql_global.fields[28].asstring;
       modificar_plantillas.genera_grillaField1315.Value:=modulo.sql_global.fields[29].asstring;
       modificar_plantillas.genera_grillaField1330.Value:=modulo.sql_global.fields[30].asstring;
       modificar_plantillas.genera_grillaField1345.Value:=modulo.sql_global.fields[31].asstring;
       modificar_plantillas.genera_grillaField14.Value:=modulo.sql_global.fields[32].asstring;

      modificar_plantillas.genera_grilla.post;
     end;
  }
    modificar_plantillas.SpeedButton2.Enabled:=true;
      modificar_plantillas.BitBtn1.Enabled:=false;
      modificar_plantillas.GroupBox8.Enabled:=false;
      modificar_plantillas.GroupBox10.Enabled:=false;

end;





function tfuncion.conexion_virtual(base:string):boolean;
var servidor,pass,user:string;
begin
modulo.conexion.Close;
//servidor:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Server');
with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(APPLICATION_KEY) then
      Begin
      servidor:=ReadString('Server');
      pass:=ReadString('Password');
      user:=ReadString('User');
      //actual:=ReadString('Conex_actual');
      end;
  Finally
    free;
  end;

  if trim(pass)<>'' then
  begin
  {
  modulo.conexion.ConnectionString:='Provider=MSDASQL.1;Password='+trim(pass)+';Persist Security Info=False;'+
                                  'User ID='+trim(user)+';Data Source=cita;'+
                                  'Extended Properties="DSN=cita;Description=conexion a reservas de turnos;'+
                                  'UID=sa;APP=Enterprise;WSID='+trim(servidor)+';DATABASE='+trim(base)+';Network=DBMSSOCN";Initial Catalog='+trim(base);
  }

   modulo.conexion.ConnectionString:='Provider=SQLOLEDB.1;Persist Security Info=False;Password='+trim(pass)+';User ID='+trim(user)+';Initial Catalog='+trim(base)+';Data Source='+trim(servidor);


 end else
 begin
  {
   modulo.conexion.ConnectionString:='Provider=MSDASQL.1;Persist Security Info=False;'+
                                  'User ID='+trim(user)+';Data Source=cita;'+
                                  'Extended Properties="DSN=cita;Description=conexion a reservas de turnos;'+
                                  'UID=sa;APP=Enterprise;WSID='+trim(servidor)+';DATABASE='+trim(base)+';Network=DBMSSOCN";Initial Catalog='+trim(base);
}

    modulo.conexion.ConnectionString:='Provider=SQLOLEDB.1;Persist Security Info=False;User ID='+trim(user)+';Initial Catalog='+trim(base)+';Data Source='+trim(servidor);

 end;

 try
  if not (modulo.conexion.Connected) then
     begin
       modulo.conexion.Open;
      modulo.conexion.Connected:=true;
      uglobal.ID_PLANTA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');
      form1.caption:='Administración de Reservas de Turnos OnLine.  [ '+trim(busca_nombr_centro(uglobal.ID_PLANTA))+' ]';
     end;
 except

 end;
   

end;


function tfuncion.copiar_plantilla(numero_plantilla:longint):boolean;
var i:longint;
begin
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


//uglobal.ID_EMPRESA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Empresa');
//uglobal.ID_PLANTA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');

 modulo.sql_global.Close;
 modulo.sql_global.SQL.Clear;
 modulo.sql_global.SQL.Add('select  '+
 ' D0600, '+
	' D0615 , '+
	' D0630 , '+
	' D0645 , '+
	' D0700 , '+
	' D0715 , '+
	' D0730 , '+
	' D0745 , '+
	' D0800 , '+
	' D0815 , '+
	' D0830 , '+
	' D0845 , '+
	' D0900 , '+
	' D0915 , '+
	' D0930 , '+
	' D0945  , '+
	' D1000 , '+
 '	D1015 , '+
 '	D1030 , '+
 '	D1045 , '+
 '	D1100, '+
 '	D1115 , '+
 '	D1130 , '+
 '  D1145 , '+
 '  D1200 , '+
 '	D1215 , '+
 '	D1230 , '+
 '	D1245 , '+
 '	D1300 , '+
 '	D1315, '+
 '	D1330, '+
 '	D1345, '+
 '	D1400, '+
 '	D1415, '+
 '	D1430, '+
 '	D1445, '+
 '	D1500, '+
 '	D1515, '+
 '	D1530, '+
 '	D1545, '+
 '	D1600, '+
 '	D1615, '+
 '	D1630, '+
 '	D1645, '+
 '	D1700, '+
 '	D1715, '+
 '	D1730, '+
 '	D1745, '+
 '	D1800, '+
 ' D1815, '+
 '	D1830, '+
'	D1845, '+
'	D1900, '+
'	D1915, '+
'	D1930, '+
'	D1945, '+
'	D2000, '+
'	D2015, '+
'	D2030, '+
'	D2045, '+
'	D2100, '+
'	D2115, '+
'	D2130, '+
'	D2145, '+
'	D2200, '+
'	D2215, '+
'	D2230 , '+
' D2245 '+
' from plantilla where empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and centro='+#39+trim(uglobal.ID_PLANTA)+#39+' and  numero ='+inttostr(numero_plantilla));
 modulo.sql_global.ExecSQL;
 modulo.sql_global.Open;
 if modulo.sql_global.RecordCount >  0 then
 begin
    if crear_plantilla.dbgrid1.Enabled=true then
    begin
         for i:=0 to crear_plantilla.dbgrid1.Columns.Count - 1 do
             begin
                  if crear_plantilla.dbgrid1.Columns[i].Visible=true then
                    begin
                        if  crear_plantilla.dbgrid1.Columns[i].ReadOnly=false then
                            crear_plantilla.dbgrid1.Columns[i].Field.AsString :=modulo.sql_global.Fields[i].AsString;

                     end;
              end;
     end else
     begin
      crear_plantilla.dbgrid1.Enabled:=true;
          for i:=0 to crear_plantilla.dbgrid1.Columns.Count - 1 do
             begin
                 if modulo.sql_global.Fields[i].AsString <>'0' then
                  begin
                  crear_plantilla.dbgrid1.Columns[i].Visible:=true;

                    crear_plantilla.dbgrid1.Columns[i].ReadOnly:=false;
                    crear_plantilla.dbgrid1.Columns[i].Field.AsString :=modulo.sql_global.Fields[i].AsString;
                   end;

              end;
     end;


 end;



end;

function tfuncion.carga_canti_plantillas_para_copia(nume:longint):boolean;
begin
//uglobal.ID_EMPRESA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Empresa');
//uglobal.ID_PLANTA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');

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



 modulo.sql_canti_copia.Close;
 modulo.sql_canti_copia.SQL.Clear;
 modulo.sql_canti_copia.SQL.Add(' select * from plantilla where empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and centro='+#39+trim(uglobal.ID_PLANTA)+#39+'  and   numero ='+inttostr(nume));
 modulo.sql_canti_copia.ExecSQL;
 modulo.sql_canti_copia.Open;



end;

function tfuncion.carga_plantillas_para_copia:boolean;
begin
//uglobal.ID_EMPRESA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Empresa');
//uglobal.ID_PLANTA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');


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



 modulo.sql_copia.Close;
 modulo.sql_copia.SQL.Clear;
 modulo.sql_copia.SQL.Add('select numero, desde, hasta, tp, hora_inicio, hora_fin, hora_i_desca, hora_f_desca from plantilla  where empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and centro='+#39+trim(uglobal.ID_PLANTA)+#39+' order by numero desc');
 modulo.sql_copia.ExecSQL;
 modulo.sql_copia.Open;

end;

function tfuncion.extrae_hora_centro(idcentro:string):boolean;
var sql,hf,hi,mf,mi,hi1,hf1:string;
posi:longint;
begin
sql:='select hora_inicio,hora_final from Centros where centro='+#39+trim(idcentro)+#39;

  modulo.sql_global.Close;
  modulo.sql_global.SQL.Clear;
  modulo.sql_global.SQL.Add(sql);
  modulo.sql_global.ExecSQL;
  modulo.sql_global.Open;

   hi:=modulo.sql_global.Fields[0].AsString;
   hf:=modulo.sql_global.Fields[1].AsString;

   posi:=pos(':',hi);
   hi1:=copy(hi,0,posi-1);
   mi:=copy(hi,posi+1,length(hi));


   posi:=pos(':',hf);
   hf1:=copy(hf,0,posi-1);
   mf:=copy(hf,posi+1,length(hf));


  crear_plantilla.Edit3.Text:=hi1;
  crear_plantilla.Edit4.Text:=mi;
  crear_plantilla.Edit5.Text:= hf1;
  crear_plantilla.Edit6.Text:=mf;
end;

function tfuncion.devuelve_cantidad_turnos_fecha(fecha:string):longint;
var sql:string;
begin
//uglobal.ID_EMPRESA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Empresa');
//uglobal.ID_PLANTA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');

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




sql:='select count(*) as cantidad  from reserva  where empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and centro='+#39+trim(uglobal.ID_PLANTA)+#39+
    ' and fecha=CONVERT(DATETIME,'+#39+fecha+#39+',103)';

modulo.sql_global.Close;
modulo.sql_global.SQL.Clear;
modulo.sql_global.SQL.Add(sql);
modulo.sql_global.ExecSQL;
modulo.sql_global.Open;
devuelve_cantidad_turnos_fecha:=modulo.sql_global.Fields[0].AsInteger;

end;

 function tfuncion.genera_reporte_de_turnos(fecha_se:string):boolean;
var sql:string;
begin
//uglobal.ID_EMPRESA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Empresa');
//uglobal.ID_PLANTA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');

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


sql:='select r.patente as rpatente, r.apellido +'', ''+ r.nombre as rnombre, r.telefono as rtelefono, r.hora as rhora, r.fecha as rfecha, e.estado as eestado, r.numero as rnumero, '+
     ' r.codigo as codigoreseva from reserva r, estados e where r.empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and r.centro='+#39+trim(uglobal.ID_PLANTA)+#39+
    ' and r.fecha=CONVERT(DATETIME,'+#39+fecha_se+#39+',103) and r.codestado=e.codestado   order by r.hora asc';

modulo.sql_listado.Close;
modulo.sql_listado.SQL.Clear;
modulo.sql_listado.SQL.Add(sql);
modulo.sql_listado.ExecSQL;
modulo.sql_listado.Open;


end;




function tfuncion.modifica_estado(idreserva,idestado:longint):boolean;
var sql:string;
begin
//uglobal.ID_EMPRESA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Empresa');
//uglobal.ID_PLANTA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');

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



 modulo.conexion.BeginTrans;
 try
       sql:='update reserva set codestado='+inttostr(idestado)+'  where numero='+inttostr(idreserva)+' and empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and centro='+#39+trim(uglobal.ID_PLANTA)+#39;

       modulo.sql_global.Close;
       modulo.sql_global.SQL.Clear;
       modulo.sql_global.SQL.Add(sql);
       modulo.sql_global.ExecSQL;
 

      modulo.conexion.CommitTrans;
       modifica_estado:=true;
 except
    modulo.conexion.RollbackTrans;
    modifica_estado:=false;
 end;

end;


function tfuncion.busca_turnos_patene(dominio:string):boolean;
var sql:string;
begin
//uglobal.ID_EMPRESA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Empresa');
//uglobal.ID_PLANTA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');


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



busca_turnos_patene:=false;
sql:='select r.patente as rpatente, r.nombre +'' ''+ r.apellido as rnombre, r.telefono as rtelefono, r.hora as rhora, r.fecha as rfecha, e.estado as eestado, r.numero as rnumero, '+
      ' r.codigo as codigoreserva, c.nombre as cnombre from reserva r, estados e , centros c where r.empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and r.centro='+#39+trim(uglobal.ID_PLANTA)+#39+
     ' and  r.patente='+#39+trim(dominio)+#39+'  and r.codestado = e.codestado  and r.centro = c.centro and c.centro='+#39+uglobal.ID_PLANTA+#39+' order by r.hora asc';





modulo.sql_buscA_por_fecha.Close;
modulo.sql_buscA_por_fecha.SQL.Clear;
modulo.sql_buscA_por_fecha.SQL.Add(sql);
modulo.sql_buscA_por_fecha.ExecSQL;
modulo.sql_buscA_por_fecha.Open;
if modulo.sql_buscA_por_fecha.RecordCount > 0 then
   busca_turnos_patene:=true;
end;




function tfuncion.existe_fecha(fecha_se,fe_de:string;numero:longint;tipo:string):boolean;
var sql,fecha:string;
i:longint;
fe:tdate;
tp:ttemplate;

begin


with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(APPLICATION_KEY) then
      Begin
      uglobal.ID_EMPRESA:=ReadString('Empresa');
      uglobal.ID_PLANTA:=ReadString('Planta');
  
      end;
  Finally
    free;
  end;



//es plantilla nueva
if numero <> 0 then
begin
{
sql:='select r.fecha from acucitas r where r.empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and r.centro='+#39+trim(uglobal.ID_PLANTA)+#39+
    ' and r.fecha between CONVERT(DATETIME,'+#39+fecha_se+#39+',103) and  CONVERT(DATETIME,'+#39+fe_de+#39+',103)  and  r.tp <> '+inttostr(numero);
}

sql:='select r.fecha from acucitas r where r.empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and r.centro='+#39+trim(uglobal.ID_PLANTA)+#39+
    '  and  r.tp <> '+inttostr(numero);

end else
begin
{
 sql:='select r.fecha from acucitas r where r.empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and r.centro='+#39+trim(uglobal.ID_PLANTA)+#39+
    ' and r.fecha between CONVERT(DATETIME,'+#39+fecha_se+#39+',103) and  CONVERT(DATETIME,'+#39+fe_de+#39+',103) ';
}


    sql:='select r.fecha from acucitas r where r.empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and r.centro='+#39+trim(uglobal.ID_PLANTA)+#39;

end;



 existe_fecha:=false;

modulo.sql_buscA_por_fecha.Close;
modulo.sql_buscA_por_fecha.SQL.Clear;
modulo.sql_buscA_por_fecha.SQL.Add(sql);
modulo.sql_buscA_por_fecha.ExecSQL;
modulo.sql_buscA_por_fecha.Open;
if modulo.sql_buscA_por_fecha.RecordCount > 0 then
begin
tp:=ttemplate.Create;
    for i:=1 to   modulo.sql_buscA_por_fecha.RecordCount do
    begin
     fecha:=modulo.sql_buscA_por_fecha.Fields[0].asstring;

            if tp.chequea_si_es_feriado_o_domingo(fecha)= false  then
              begin

                  if tipo='d' then
                     begin

                         if tp.es_lunes_a_viernes(fecha)=true then
                            begin
                               if ((fecha=fecha_se)  or (fecha=fe_de)) then
                                  begin
                                   existe_fecha:=true;
                                   break;
                                  end;

                            end;

                    end;


                      if tipo='s' then
                     begin

                         if tp.es_sabado(fecha)=true then
                            begin
                               if ((fecha=fecha_se)  or (fecha=fe_de)) then
                                  begin
                                   existe_fecha:=true;
                                   break;
                                  end;

                            end;

                    end;


              end;




      modulo.sql_buscA_por_fecha.Next;
    end;

 tp.Free;



end;



 end;


function tfuncion.exite_plantilla(fechad,fechah:string;numero:longint):boolean;
var sql:string;
begin
//uglobal.ID_EMPRESA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Empresa');
//uglobal.ID_PLANTA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');

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

 if numero <> 0 then
 begin
sql:='select * from plantilla  where empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and centro='+#39+trim(uglobal.ID_PLANTA)+#39+
    ' and desde=CONVERT(DATETIME,'+#39+fechad+#39+',103) and hasta=CONVERT(DATETIME,'+#39+fechah+#39+',103) and numero <> '+inttostr(uglobal.NUMERO_PLANILLA_MODIFICA);

end else
begin
 sql:='select * from plantilla  where empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and centro='+#39+trim(uglobal.ID_PLANTA)+#39+
    ' and desde=CONVERT(DATETIME,'+#39+fechad+#39+',103) and hasta=CONVERT(DATETIME,'+#39+fechah+#39+',103)';


end;

 exite_plantilla:=false;

modulo.sql_buscA_por_fecha.Close;
modulo.sql_buscA_por_fecha.SQL.Clear;
modulo.sql_buscA_por_fecha.SQL.Add(sql);
modulo.sql_buscA_por_fecha.ExecSQL;
modulo.sql_buscA_por_fecha.Open;
if modulo.sql_buscA_por_fecha.RecordCount > 0 then
   exite_plantilla:=true;
end;


function tfuncion.busca_turnos_por_fecha_seleccionada(fecha_se:string):boolean;
var sql:string;
begin
//uglobal.ID_EMPRESA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Empresa');
//uglobal.ID_PLANTA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');

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

busca_turnos_por_fecha_seleccionada:=false;
sql:='select r.patente as rpatente, r.nombre +'' ''+ r.apellido as rnombre, r.telefono as rtelefono, r.hora as rhora, r.fecha as rfecha, e.estado as eestado, r.numero as rnumero, '+
     'r.codigo as codigoreserva, c.nombre as cnombre from reserva r, estados e, centros c where r.empresa='+#39+trim(uglobal.ID_EMPRESA)+#39+' and r.centro='+#39+trim(uglobal.ID_PLANTA)+#39+
    ' and r.fecha=CONVERT(DATETIME,'+#39+fecha_se+#39+',103) and r.codestado=e.codestado and r.centro = c.centro and  c.centro='+#39+uglobal.ID_PLANTA+#39+' order by r.hora asc';

modulo.sql_buscA_por_fecha.Close;
modulo.sql_buscA_por_fecha.SQL.Clear;
modulo.sql_buscA_por_fecha.SQL.Add(sql);
modulo.sql_buscA_por_fecha.ExecSQL;
modulo.sql_buscA_por_fecha.Open;
if modulo.sql_buscA_por_fecha.RecordCount > 0 then
   busca_turnos_por_fecha_seleccionada:=true;

end;


function tfuncion.busca_nombr_centro(planta:string):string;
var sql:string;
begin
sql:='select centro, nombre from centros where centro='+#39+trim(planta)+#39;
modulo.sql_global.Close;
modulo.sql_global.SQL.Clear;
modulo.sql_global.SQL.Add(sql);
modulo.sql_global.ExecSQL;
modulo.sql_global.Open;

if modulo.sql_global.RecordCount > 0 then
   Begin
     uglobal.ID_PLANTA:=trim(modulo.sql_global.Fields[0].AsString);
     busca_nombr_centro:=trim(modulo.sql_global.Fields[1].AsString);
   end;

end;


function tfuncion.busca_nombr_empresa(empre:string):string;
var sql:string;
begin
sql:='select empresa, nombre from empresas where empresa='+#39+trim(empre)+#39;
modulo.sql_global.Close;
modulo.sql_global.SQL.Clear;
modulo.sql_global.SQL.Add(sql);
modulo.sql_global.ExecSQL;
modulo.sql_global.Open;

if modulo.sql_global.RecordCount > 0 then
   Begin
     uglobal.ID_EMPRESA:=trim(modulo.sql_global.Fields[0].AsString);
     busca_nombr_empresa:=trim(modulo.sql_global.Fields[1].AsString);
   end;

end;


function tfuncion.GetRegistryData(RootKey: HKEY; Key, Value: string): variant;
var
  Reg: TRegistry;
  RegDataType: TRegDataType;
  DataSize, Len: integer;
  s: string;
label cantread;
begin
  Reg := nil;
  try
    Reg := TRegistry.Create(KEY_QUERY_VALUE);
    Reg.RootKey := RootKey;
    if Reg.OpenKeyReadOnly(Key) then begin
      try
        RegDataType := Reg.GetDataType(Value);
        if (RegDataType = rdString) or
           (RegDataType = rdExpandString) then
          Result := Reg.ReadString(Value)
        else if RegDataType = rdInteger then
          Result := Reg.ReadInteger(Value)
        else if RegDataType = rdBinary then begin
          DataSize := Reg.GetDataSize(Value);
          if DataSize = -1 then goto cantread;
          SetLength(s, DataSize);
          Len := Reg.ReadBinaryData(Value, PChar(s)^, DataSize);
          if Len <> DataSize then goto cantread;
          Result := s;
        end else
cantread:
          raise Exception.Create(SysErrorMessage(ERROR_CANTREAD));
      except
        s := ''; // Deallocates memory if allocated
        Reg.CloseKey;
        raise;
      end;
      Reg.CloseKey;
    end else
      raise Exception.Create(SysErrorMessage(GetLastError));
  except
    Reg.Free;
    raise;
  end;
  Reg.Free;
end;


end.
