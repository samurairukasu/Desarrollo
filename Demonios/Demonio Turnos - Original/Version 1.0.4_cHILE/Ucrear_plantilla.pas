unit Ucrear_plantilla;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGrids, DB,
  RxMemDS, DBTables, MemTable,ufunciones,DateUtils,uplantillas,uglobal,uconst,usuperregistry;

type
  Tcrear_plantilla = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    GroupBox2: TGroupBox;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    GroupBox6: TGroupBox;
    DBGrid1: TDBGrid;
    genera_grilla: TRxMemoryData;
    DataSource1: TDataSource;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    genera_grillaField8: TStringField;
    genera_grillaField815: TStringField;
    genera_grillaField830: TStringField;
    genera_grillaField845: TStringField;
    genera_grillaField9: TStringField;
    genera_grillaField915: TStringField;
    genera_grillaField930: TStringField;
    genera_grillaField945: TStringField;
    genera_grillaField10: TStringField;
    genera_grillaField1015: TStringField;
    genera_grillaField1030: TStringField;
    genera_grillaField1045: TStringField;
    genera_grillaField11: TStringField;
    genera_grillaField1115: TStringField;
    genera_grillaField1130: TStringField;
    genera_grillaField1145: TStringField;
    genera_grillaField12: TStringField;
    genera_grillaField1215: TStringField;
    genera_grillaField1230: TStringField;
    genera_grillaField1245: TStringField;
    genera_grillaField13: TStringField;
    genera_grillaField1315: TStringField;
    genera_grillaField1330: TStringField;
    genera_grillaField1345: TStringField;
    genera_grillaField14: TStringField;
    genera_grillaField1415: TStringField;
    genera_grillaField1430: TStringField;
    genera_grillaField1445: TStringField;
    genera_grillaField15: TStringField;
    genera_grillaField1515: TStringField;
    genera_grillaField1530: TStringField;
    genera_grillaField1545: TStringField;
    genera_grillaField16: TStringField;
    genera_grillaField1615: TStringField;
    genera_grillaField1630: TStringField;
    genera_grillaField1645: TStringField;
    genera_grillaField17: TStringField;
    genera_grillaField1715: TStringField;
    genera_grillaField1730: TStringField;
    genera_grillaField1745: TStringField;
    genera_grillaField18: TStringField;
    genera_grillaField1815: TStringField;
    genera_grillaField1830: TStringField;
    genera_grillaField1845: TStringField;
    genera_grillaField19: TStringField;
    genera_grillaField1915: TStringField;
    genera_grillaField1930: TStringField;
    genera_grillaField1945: TStringField;
    genera_grillaField20: TStringField;
    genera_grillaField2015: TStringField;
    genera_grillaField2030: TStringField;
    genera_grillaField2045: TStringField;
    genera_grillaField21: TStringField;
    genera_grillaField2115: TStringField;
    genera_grillaField2130: TStringField;
    genera_grillaField2145: TStringField;
    genera_grillaField22: TStringField;
    genera_grillaField2215: TStringField;
    genera_grillaField2230: TStringField;
    genera_grillaField2245: TStringField;
    genera_grillaField23: TStringField;
    genera_grillaField2315: TStringField;
    genera_grillaField2330: TStringField;
    genera_grillaField2345: TStringField;
    genera_grillaField6: TStringField;
    genera_grillaField615: TStringField;
    genera_grillaField630: TStringField;
    genera_grillaField645: TStringField;
    genera_grillaField7: TStringField;
    genera_grillaField715: TStringField;
    genera_grillaField730: TStringField;
    genera_grillaField745: TStringField;
    autos_hora: TRxMemoryData;
    autos_horahora: TStringField;
    autos_horacantidad: TIntegerField;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    Label20: TLabel;
    GroupBox12: TGroupBox;
    Label21: TLabel;
    GroupBox8: TGroupBox;
    GroupBox7: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox9: TGroupBox;
    GroupBox4: TGroupBox;
    DateTimePicker2: TDateTimePicker;
    GroupBox3: TGroupBox;
    DateTimePicker1: TDateTimePicker;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    CheckBox1: TCheckBox;
    GroupBox13: TGroupBox;
    Edit11: TEdit;
    SpeedButton1: TSpeedButton;
    CheckBox2: TCheckBox;
    SpeedButton2: TSpeedButton;
    CheckBox3: TCheckBox;

    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Edit11KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure Edit6KeyPress(Sender: TObject; var Key: Char);
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure Edit8KeyPress(Sender: TObject; var Key: Char);
    procedure Edit9KeyPress(Sender: TObject; var Key: Char);
    procedure Edit10KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton2Click(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  crear_plantilla: Tcrear_plantilla;

implementation

uses Uselecciona_plantilla;

{$R *.dfm}

procedure Tcrear_plantilla.BitBtn1Click(Sender: TObject);
var hora_inicio,hora_final,intervalo,cont,por,intervalo_des:longint;
i:longint; hora_field_i,hora_field_f,fe_de,desde,hasta,tipo_pnatilla:string;
hora,hora_aux,dias:longint;
hora_i,minuto_i, hora_f,minuto_f,descanso_i,descanso_f,fe_se,desca_hora:string;
V_field:array[1..60] of string;
tf:tfuncion;
bandera:boolean;
tplan:ttemplate;
begin
 tf:=tfuncion.Create;



if datetimepicker1.DateTime >  datetimepicker2.DateTime  then
   begin
    showmessage('La Fecha Desde no puede ser mayor a la Fecha Hasta.');
    exit;
   end;



   dias:=(DaysBetween(DateTimePicker2.DateTime,DateTimePicker1.DateTime));


   desde:=datetostr(DateTimePicker1.DateTime);
   hasta:=datetostr(DateTimePicker2.DateTime);


   //controlo que se alla seleccionado la opcion sabado y las fechas sean sabados
       tplan:=ttemplate.Create;
      if  (tplan.comprara_fecha_con_selecciona_sabado(desde,inttostr(dias))=true) and (checkbox3.Checked=false) then
           begin
              showmessage('El rango de fecha contiene sábados. Deberá seleccionar la opción [Solo Sábados] o seleccionar un rango de fechas sin sábados.');
             exit;
         end;

      tplan.Free;

    //************************************************




   {if checkbox3.Checked then
   begin
   tplan:=ttemplate.Create;
    desde:=tplan.genera_el_desde_para_sabado(desde,inttostr(dias));
    hasta:=tplan.genera_el_hasta_para_sabado(hasta,inttostr(dias));
   tplan.Free;

   end;
   {
   if tf.exite_plantilla(desde,hasta,0)= true then
    begin
    showmessage('Ya existe una plantilla con el rango de fecha seleccionada.');
     exit;
    end;

 }




   //mefijo que no este esta fecha en acusistas
    bandera:=false;
    fe_se:=datetostr(DateTimePicker1.DateTime);
    fe_de:=datetostr(DateTimePicker2.DateTime);
   dias:=(DaysBetween(DateTimePicker2.DateTime,DateTimePicker1.DateTime));

      tipo_pnatilla:='d';
      if checkbox3.Checked then
       begin
       tipo_pnatilla:='s';
        tplan:=ttemplate.Create;
        fe_se:=tplan.genera_el_desde_para_sabado(fe_se,inttostr(dias));
        fe_de:=tplan.genera_el_hasta_para_sabado(fe_de,inttostr(dias));
        tplan.Free;

       end;


       if tf.existe_fecha(fe_se,fe_de,0,trim(tipo_pnatilla))=true then
        begin
         showmessage('Hay fecha que ya existen en otra planilla.');
         bandera:=true;

        end;





  tf.Free;

  if bandera then
     exit;


if trim(edit3.Text)='' then
  begin
   showmessage('La hora de inicio es incorrecta.');
   exit;
  end;


  if trim(edit3.Text)='0' then
  begin
   showmessage('La hora de inicio es incorrecta.');
   exit;
  end;

  if trim(edit4.Text)='' then
  begin
   showmessage('Los minutos de inicio son incorrectos.');
   exit;
  end;


  if trim(edit4.Text)='0' then
  begin
   showmessage('Los minutos de inicio son incorrectos.');
   exit;
  end;

   if trim(edit5.Text)='' then
  begin
   showmessage('La hora de finalización es incorrecta.');
   exit;
  end;


  if trim(edit5.Text)='0' then
  begin
   showmessage('La hora de finalización es incorrecta.');
   exit;
  end;

  if trim(edit6.Text)='' then
  begin
   showmessage('Los minutos de finalización son incorrectos.');
   exit;
  end;


  if trim(edit6.Text)='0' then
  begin
   showmessage('Los minutos de finalización son incorrectos.');
   exit;
  end;

if checkbox1.Checked then
begin
  if trim(edit7.Text)='' then
  begin
   showmessage('La hora de inicio de descanzo es incorrecta.');
   exit;
  end;

     if trim(edit7.Text)='0' then
  begin
   showmessage('La hora de inicio de descanzo es incorrecta.');
   exit;
  end;


    if trim(edit8.Text)='' then
  begin
   showmessage('Los minutos de inicio de descanzo son incorrectos.');
   exit;
  end;

     if trim(edit8.Text)='0' then
  begin
   showmessage('Los minutos de inicio de descanzo son incorrectos.');
   exit;
  end;


if trim(edit9.Text)='' then
  begin
   showmessage('La Hora de Fin de descanzo es incorrecta.');
   exit;
  end;

     if trim(edit9.Text)='0' then
  begin
   showmessage('La Hora de Fin de descanzo es incorrecta.');
   exit;
  end;



     if trim(edit10.Text)='' then
  begin
   showmessage('Los minutos de descanzo son incorrectos.');
   exit;
  end;

   if trim(edit10.Text)='0' then
  begin
   showmessage('Los minutos de descanzo son incorrectos.');
   exit;
  end;
end;


hora_i:=trim(edit3.Text);
minuto_i:=trim(edit4.Text);

hora_f:=trim(edit5.Text);
minuto_f:=trim(edit6.Text);

 dbgrid1.Enabled:=TRUE;
if checkbox1.Checked then
begin
descanso_i:=trim(edit7.Text)+trim(edit8.Text);
descanso_f:=trim(edit9.Text)+trim(edit10.Text);
desca_hora:=trim(edit7.Text);

intervalo_des:=strtoint(descanso_i);
while intervalo_des <=(strtoint(descanso_f)-15) do
begin


   for i:=0 to dbgrid1.Columns.Count - 1 do
    begin

          if  (dbgrid1.Columns[i].FieldName = inttostr(intervalo_des)) then
           begin
                 dbgrid1.Columns[i].Visible:=true ;
                 dbgrid1.Columns[i].ReadOnly:=true ;
                 dbgrid1.Columns[i].Color:=clred;
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

por:=0;
hora_field_i:=hora_i+minuto_i;
hora_field_f:=hora_f+minuto_f;
intervalo:=strtoint(hora_field_i);
//cont:=strtoint(minuto_i);
while   (intervalo <= strtoint(hora_field_f)) do
begin




   for i:=0 to dbgrid1.Columns.Count - 1 do
    begin

        if not (dbgrid1.Columns[i].ReadOnly)  then
             begin
                 if  (dbgrid1.Columns[i].FieldName = inttostr(intervalo)) then
                   begin
                    dbgrid1.Columns[i].Visible:=true ;
                     dbgrid1.Columns[i].Color:=clgreen;
                     dbgrid1.Columns[i].ReadOnly:=false ;
                    break;
                  end;
             end;


     end;

  cont:=cont + 15;
 if cont>45 then
   begin
   por:=por + 1;
   cont:=0;

         hora_field_i:=hora_i+'00';
         intervalo:=strtoint(hora_field_i)+(100*por);


         


   end else
   begin
     intervalo:=intervalo + 15;
   end;


end;


  genera_grilla.Open;
  genera_grilla.Edit;
   bitbtn3.Enabled:=true;
   speedbutton2.Enabled:=true;
end;

procedure Tcrear_plantilla.BitBtn2Click(Sender: TObject);
var i:longint;
tf:tfuncion;
planta:string;
begin
tf:=tfuncion.Create;
edit3.Clear;
     edit4.Clear;
     edit5.Clear;
     edit6.Clear;
     edit7.Clear;
     edit8.Clear;
     edit9.Clear;
     edit10.Clear;
      bitbtn3.Enabled:=false;
       autos_hora.Close;
       genera_grilla.Close;
       edit11.Clear;
       checkbox1.Checked:=false;
       checkbox2.Checked:=falsE;
       groupbox10.Enabled:=false;
        groupbox13.Enabled:=false;
          for i:=0 to dbgrid1.Columns.Count - 1 do
          begin
            dbgrid1.Columns[i].Visible:=falsE;
        end;
       // planta:=tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');


        with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(APPLICATION_KEY) then
      Begin
      //uglobal.ID_EMPRESA:=ReadString('Empresa');
      planta:=ReadString('Planta');
      //actual:=ReadString('Conex_actual');
      end;
  Finally
    free;
  end;




         tf.extrae_hora_centro(planta);

       dbgrid1.Enabled:=FALSE;
     tf.Free;    
close;
end;

procedure Tcrear_plantilla.BitBtn3Click(Sender: TObject);
var i,dife,dias1:longint;
dias,desde,hasta,z,planta,fe_se,fe_de,tipo_pnatilla:string;
tp:ttemplate;
tf:tfuncion;
tplan:ttemplate ;
control_cantidad,bandera:boolean;
hora_i,hora_f,hd_i,hd_F:string;
begin
if MessageBox(0, '¿ Desea Confirmar la Plantilla ?', 'Confirmación', +mb_YesNo +mb_ICONinformation) =6 then
 begin

 
if trim(edit3.Text)='' then
  begin
   showmessage('La hora de inicio es incorrecta.');
   exit;
  end;


  if trim(edit3.Text)='0' then
  begin
   showmessage('La hora de inicio es incorrecta.');
   exit;
  end;

  if trim(edit4.Text)='' then
  begin
   showmessage('Los minutos de inicio son incorrectos.');
   exit;
  end;


  if trim(edit4.Text)='0' then
  begin
   showmessage('Los minutos de inicio son incorrectos.');
   exit;
  end;

   if trim(edit5.Text)='' then
  begin
   showmessage('La hora de finalización es incorrecta.');
   exit;
  end;


  if trim(edit5.Text)='0' then
  begin
   showmessage('La hora de finalización es incorrecta.');
   exit;
  end;

  if trim(edit6.Text)='' then
  begin
   showmessage('Los minutos de finalización son incorrectos.');
   exit;
  end;


  if trim(edit6.Text)='0' then
  begin
   showmessage('Los minutos de finalización son incorrectos.');
   exit;
  end;

if checkbox1.Checked then
begin
  if trim(edit7.Text)='' then
  begin
   showmessage('La hora de inicio de descanso es incorrecta.');
   exit;
  end;

     if trim(edit7.Text)='0' then
  begin
   showmessage('La hora de inicio de descanso es incorrecta.');
   exit;
  end;


    if trim(edit8.Text)='' then
  begin
   showmessage('Los minutos de inicio de descanso son incorrectos.');
   exit;
  end;

     if trim(edit8.Text)='0' then
  begin
   showmessage('Los minutos de inicio de descanso son incorrectos.');
   exit;
  end;


if trim(edit9.Text)='' then
  begin
   showmessage('La Hora de Fin de descanso es incorrecta.');
   exit;
  end;

     if trim(edit9.Text)='0' then
  begin
   showmessage('La Hora de Fin de descanso es incorrecta.');
   exit;
  end;



     if trim(edit10.Text)='' then
  begin
   showmessage('Los minutos de descanso son incorrectos.');
   exit;
  end;

   if trim(edit10.Text)='0' then
  begin
   showmessage('Los minutos de descanso son incorrectos.');
   exit;
  end;
end;


 if datetimepicker1.DateTime >  datetimepicker2.DateTime  then
   begin
    showmessage('La Fecha Desde no puede ser mayor a la Fecha Hasta.');
    exit;
   end;

  control_cantidad:=falsE;
   for i:= 0 to dbgrid1.Columns.Count - 1 do
   begin

     if  dbgrid1.Columns[i].Visible=true then
        begin
              IF  dbgrid1.Columns[i].ReadOnly=FALSE THEN
               BEGIN
                    if  trim(dbgrid1.Columns[i].Field.Asstring)='' then
                      control_cantidad:=true;
               END;
        end;

   end;



    if control_cantidad then
     begin
         showmessage('No se ha ingresados cantidad de vehiculos en la grilla.');
        exit;
     end;


 tf:=tfuncion.Create;

 {
   if tf.exite_plantilla(datetostr(DateTimePicker1.DateTime),datetostr(DateTimePicker2.DateTime),0)= true then
    begin
    showmessage('Ya existe una plantilla con el rango de fecha seleccionada.');
     exit;
    end;

   }

     //mefijo que no este esta fecha en acusistas
   bandera:=false;
   dias1:=(DaysBetween(DateTimePicker2.DateTime,DateTimePicker1.DateTime));

    fe_se:=datetostr(DateTimePicker1.DateTime);
    fe_de:=datetostr(DateTimePicker2.DateTime);


     tplan:=ttemplate.Create;
      if  (tplan.comprara_fecha_con_selecciona_sabado(fe_se,inttostr(dias1))=true) and (checkbox3.Checked=false) then
           begin
              showmessage('El rango de fecha contiene sábados. Deberá seleccionar la opción [Solo Sábados] o seleccionar un rango de fechas sin sábados.');
             exit;
         end;

      tplan.Free;




    tipo_pnatilla:='d';
     if checkbox3.Checked then
       begin
       tipo_pnatilla:='s';
        tplan:=ttemplate.Create;
        fe_se:=tplan.genera_el_desde_para_sabado(fe_se,inttostr(dias1));
        fe_de:=tplan.genera_el_hasta_para_sabado(fe_de,inttostr(dias1));
        tplan.Free;

       end;

       if tf.existe_fecha(fe_se,fe_de,0,trim(tipo_pnatilla))=true then
        begin
         showmessage('Hay fecha que ya existen en otra planilla.');
         bandera:=true;

        end;

     if bandera then
       exit;
  TF.Free;
    
genera_grilla.Post;
dife:=1;
z:='1';

hd_i:='';
hd_f:='';

hora_i:=edit3.Text+':'+edit4.Text;
hora_f:=edit5.Text+':'+edit6.Text;

if checkbox1.Checked then
begin
  hd_i:=edit7.Text+':'+edit8.Text;
  hd_f:=edit9.Text+':'+edit10.Text;
end;

dias:= inttostr(DaysBetween(DateTimePicker2.DateTime,DateTimePicker1.DateTime));

desde:=datetostr(DateTimePicker1.DateTime);
hasta:=datetostr(DateTimePicker2.DateTime);

 //****************extrae de la grilla
 autos_hora.Close;
 autos_hora.Open;
for i:=0 to dbgrid1.Columns.Count - 1 do
    begin

        if not (dbgrid1.Columns[i].ReadOnly)  then
             begin
                  if  not (trim(dbgrid1.Columns[i].Field.AsString)='') then
                      begin
                       //crear plantilla
                          autos_hora.Append;
                          self.autos_horahora.Value:=trim(dbgrid1.Columns[i].FieldName);
                          self.autos_horacantidad.Value:=dbgrid1.Columns[i].Field.Asinteger;
                          autos_hora.Post;



                          
                          //showmessage(dbgrid1.Columns[i].FieldName+' '+dbgrid1.Columns[i].Field.AsString);
                       
                      end;


             end;


     end;



  tp:=ttemplate.Create;

  if not checkbox3.Checked then   //de lunes a viernes
  begin
    if tp.crear_plantilla(uglobal.ID_EMPRESA,uglobal.ID_PLANTA,desde,hasta,dife,dias,tipo_pnatilla,autos_hora,hora_i,hora_f,hd_i,hd_f) then
      begin
     showmessage('Se ha creado la plantilla correctamente.');

     edit3.Clear;
     edit4.Clear;
     edit5.Clear;
     edit6.Clear;
     edit7.Clear;
     edit8.Clear;
     edit9.Clear;
     edit10.Clear;
      bitbtn3.Enabled:=false;
       autos_hora.Close;
       genera_grilla.Close;
       edit11.Clear;
       checkbox1.Checked:=false;
       checkbox2.Checked:=falsE;
       groupbox10.Enabled:=false;
        groupbox13.Enabled:=false;
          for i:=0 to dbgrid1.Columns.Count - 1 do
          begin
            dbgrid1.Columns[i].Visible:=falsE;
        end;
        tf:=tfuncion.Create;
        
        // planta:=tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');

         with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(APPLICATION_KEY) then
      Begin
     //uglobal.ID_EMPRESA:=ReadString('Empresa');
      planta:=ReadString('Planta');
      //actual:=ReadString('Conex_actual');
      end;
  Finally
    free;
  end;



        tf.extrae_hora_centro(planta);
        tf.Free;
        dbgrid1.Enabled:=FALSE;
     end else
     begin
       showmessage('Se produjo un error al intentar crear la plantilla. Consulte con el Depto de Sistemas.');
       exit;

     end;

end else //sabados
begin

       if tp.crear_plantilla_sabados(uglobal.ID_EMPRESA,uglobal.ID_PLANTA,desde,hasta,dife,dias,tipo_pnatilla,autos_hora,hora_i,hora_f,hd_i,hd_f) then
      begin
     showmessage('Se ha creado la plantilla correctamente.');

     edit3.Clear;
     edit4.Clear;
     edit5.Clear;
     edit6.Clear;
     edit7.Clear;
     edit8.Clear;
     edit9.Clear;
     edit10.Clear;
      bitbtn3.Enabled:=false;
       autos_hora.Close;
       genera_grilla.Close;
       edit11.Clear;
       checkbox1.Checked:=false;
       checkbox2.Checked:=falsE;
       groupbox10.Enabled:=false;
        groupbox13.Enabled:=false;
          for i:=0 to dbgrid1.Columns.Count - 1 do
          begin
            dbgrid1.Columns[i].Visible:=falsE;
        end;
        tf:=tfuncion.Create;
        
        // planta:=tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');

         with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(APPLICATION_KEY) then
      Begin
     //uglobal.ID_EMPRESA:=ReadString('Empresa');
      planta:=ReadString('Planta');
      //actual:=ReadString('Conex_actual');
      end;
  Finally
    free;
  end;



        tf.extrae_hora_centro(planta);
        tf.Free;
        dbgrid1.Enabled:=FALSE;
     end else
     begin
       showmessage('Se produjo un error al intentar crear la plantilla. Consulte con el Depto de Sistemas.');
       exit;

     end;
end;


  tp.Free;

 ///*******************fin

 end;
end;

procedure Tcrear_plantilla.FormActivate(Sender: TObject);
var tf:tfuncion;
empre,planta:string;
begin
 genera_grilla.Close;
 autos_hora.Close;
 bitbtn3.Enabled:=false;
tf:=tfuncion.Create;
empre:=tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Empresa');

with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(APPLICATION_KEY) then
      Begin
     empre:=ReadString('Empresa');
      //uglobal.ID_PLANTA=ReadString('Planta');
      //actual:=ReadString('Conex_actual');
      end;
  Finally
    free;
  end;



edit1.Text:=trim(tf.busca_nombr_empresa(empre));

//planta:=tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');
with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(APPLICATION_KEY) then
      Begin
     //uglobal.ID_EMPRESA:=ReadString('Empresa');
     planta:=ReadString('Planta');
      //actual:=ReadString('Conex_actual');
      end;
  Finally
    free;
  end;



edit2.Text:=trim(tf.busca_nombr_centro(planta));
 tf.extrae_hora_centro(planta);
tf.Free;

datetimepicker1.DateTime:=now;
datetimepicker2.DateTime:=now;

end;

procedure Tcrear_plantilla.Button1Click(Sender: TObject);
var fecha:string;
fe:tdate;
begin
if datetimepicker1.DateTime >  datetimepicker2.DateTime  then
 showmessage('er');

end;

procedure Tcrear_plantilla.CheckBox1Click(Sender: TObject);
begin
if checkbox1.Checked then
  groupbox10.Enabled:=true
  else
  groupbox10.Enabled:=false;

end;

procedure Tcrear_plantilla.CheckBox2Click(Sender: TObject);
begin

if dbgrid1.Columns.Count = 0 then
begin
showmessage('No hay ninguna plantilla generada para poder cargar cantidades de vehículos.');
exit;
end;


if checkbox2.Checked then
   groupbox13.Enabled:=true
   else
   groupbox13.Enabled:=false;
end;

procedure Tcrear_plantilla.SpeedButton1Click(Sender: TObject);
var i:longint;
cant:string;
begin
if edit11.Text='0' then
begin
showmessage('El valor ingresado no puede ser cero');
end;
  if trim(edit11.Text)='' then
begin
showmessage('Ingrese el valor de la cantidad.');
end;

 genera_grilla.Open;
  genera_grilla.Edit;
cant:=trim(edit11.text);

for i:=0 to dbgrid1.Columns.Count - 1 do
    begin

          if  dbgrid1.Columns[i].ReadOnly=false then
           begin
              IF  dbgrid1.Columns[i].Visible=TRUE THEN
                  dbgrid1.Columns[i].Field.AsString:=cant;
             
            end;

     end;
end;

procedure Tcrear_plantilla.Edit11KeyPress(Sender: TObject; var Key: Char);
begin

if key in['1','2','3','4','5','6','7','8','9','0',#8] then
      edit11.ReadOnly:=false
       else
       edit11.ReadOnly:=true;
end;

procedure Tcrear_plantilla.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
if key in['1','2','3','4','5','6','7','8','9','0',#8] then
      edit3.ReadOnly:=false
       else
       edit3.ReadOnly:=true;
end;

procedure Tcrear_plantilla.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
if key in['1','2','3','4','5','6','7','8','9','0',#8] then
      edit4.ReadOnly:=false
       else
       edit4.ReadOnly:=true;
end;

procedure Tcrear_plantilla.Edit5KeyPress(Sender: TObject; var Key: Char);
begin
if key in['1','2','3','4','5','6','7','8','9','0',#8] then
      edit5.ReadOnly:=false
       else
       edit5.ReadOnly:=true;
end;

procedure Tcrear_plantilla.Edit6KeyPress(Sender: TObject; var Key: Char);
begin
if key in['1','2','3','4','5','6','7','8','9','0',#8] then
      edit6.ReadOnly:=false
       else
       edit6.ReadOnly:=true;
end;

procedure Tcrear_plantilla.Edit7KeyPress(Sender: TObject; var Key: Char);
begin
if key in['1','2','3','4','5','6','7','8','9','0',#8] then
      edit7.ReadOnly:=false
       else
       edit7.ReadOnly:=true;
end;

procedure Tcrear_plantilla.Edit8KeyPress(Sender: TObject; var Key: Char);
begin
if key in['1','2','3','4','5','6','7','8','9','0',#8] then
      edit8.ReadOnly:=false
       else
       edit8.ReadOnly:=true;
end;

procedure Tcrear_plantilla.Edit9KeyPress(Sender: TObject; var Key: Char);
begin
if key in['1','2','3','4','5','6','7','8','9','0',#8] then
      edit9.ReadOnly:=false
       else
       edit9.ReadOnly:=true;
end;

procedure Tcrear_plantilla.Edit10KeyPress(Sender: TObject; var Key: Char);
begin
if key in['1','2','3','4','5','6','7','8','9','0',#8] then
      edit10.ReadOnly:=false
       else
       edit10.ReadOnly:=true;
end;

procedure Tcrear_plantilla.SpeedButton2Click(Sender: TObject);
begin
  genera_grilla.Open;
  genera_grilla.Edit;
   bitbtn3.Enabled:=true;
   speedbutton2.Enabled:=true;
   UGLOBAL.OPCION_FORMULARIO:='COPIA';
selecciona_plantilla.showmodal;
end;

procedure Tcrear_plantilla.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
if key in['1','2','3','4','5','6','7','8','9','0',#8] then
      DBGrid1.ReadOnly:=false
       else
       DBGrid1.ReadOnly:=true;
end;

end.
