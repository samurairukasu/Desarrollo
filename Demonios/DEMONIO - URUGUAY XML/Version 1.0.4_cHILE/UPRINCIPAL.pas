unit UPRINCIPAL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, ComCtrls,ComObj, ToolWin,Registry, Buttons, ImgList,ufunciones,uglobal, uconst,usuperregistry,
  StdCtrls, DB, ADODB,
  dbclient,provider,DBXpress,DBCtrls,Grids,DBGrids,SpeedBar,RXLookup,quickrpt,RXDBCtrl,FMTBcd,
  scExcelExport;  //Juan

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Usuarios1: TMenuItem;
    GestindeUsuarios1: TMenuItem;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    GestindeEmpresas1: TMenuItem;
    ToolBar1: TToolBar;
    Plantillas1: TMenuItem;
    CrearPlantilla1: TMenuItem;
    HabilitarPlantillas1: TMenuItem;
    GestionTurnos1: TMenuItem;
    Image1: TImage;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Imagelist: TImageList;
    Image3: TImage;
    ToolButton2: TToolButton;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    N1: TMenuItem;
    VerPlantilla1: TMenuItem;
    SpeedButton3: TSpeedButton;
    Panel2: TPanel;
    Estadstica1: TMenuItem;
    DetalledeTurnosporCentros1: TMenuItem;
    CantidaddeTurnosporCentros1: TMenuItem;
    CantidadporFechadeRegistro1: TMenuItem;
    BorrarTurno1: TMenuItem;
    CambiardeCentro1: TMenuItem;
    CantidaddeTurnosglobalizadoporPlanta1: TMenuItem;
    N2: TMenuItem;
    CantidaddeTurnosasginadosporplantilla1: TMenuItem;
    Listados1: TMenuItem;
    ListadosparaMailing1: TMenuItem;
    ADOQuery1: TADOQuery;
    OpenDialog: TOpenDialog;
    SaveDialog1: TSaveDialog;
    N3: TMenuItem;
    ExportarDatos1: TMenuItem;
    N4: TMenuItem;
    Reporte1: TMenuItem;
    N5: TMenuItem;
    Loquetienenquevenir1: TMenuItem;
    scExcelExport1: TscExcelExport;
    N6: TMenuItem;
    ADOStoredProc1: TADOStoredProc;
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure GestindeUsuarios1Click(Sender: TObject);
    procedure GestindeEmpresas1Click(Sender: TObject);
    procedure HabilitarEmpresa1Click(Sender: TObject);
    procedure CrearPlantilla1Click(Sender: TObject);
    procedure GestionTurnos1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure VerPlantilla1Click(Sender: TObject);
    procedure HabilitarPlantillas1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure DetalledeTurnosporCentros1Click(Sender: TObject);
    procedure CantidaddeTurnosporCentros1Click(Sender: TObject);
    procedure CantidadporFechadeRegistro1Click(Sender: TObject);
    procedure BorrarTurno1Click(Sender: TObject);
    procedure CambiardeCentro1Click(Sender: TObject);
    procedure CantidaddeTurnosglobalizadoporPlanta1Click(Sender: TObject);
    procedure CantidaddeTurnosasginadosporplantilla1Click(Sender: TObject);
    procedure ListadosparaMailing1Click(Sender: TObject);
    procedure ExportarDatos1Click(Sender: TObject);
    procedure Reporte1Click(Sender: TObject);
    procedure Loquetienenquevenir1Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Uingreso, Ugestion_usuarios, Ugestion_de_empresa, Uhabiliar_empresa,Uregistro_window,
  Ucrear_plantilla, Uver_turnos, Unitgestion_de_turnos, Umodulo,
  Uver_plantillas, Umodificar_plantillas, Ucambiar_plantillas,
  Udetalle_de_turnos_por_centros, Udetalle_cantidad_por_centro_por_fecha,
  Unit2borrar_turno, Unitcambiar_centro,
  Unitseleccione_fecha_cantidad_turnos_globalizado,
  Unitseleccione_fecha_turnos_por_plantilla, Unit3listadoparamailing,
  Umensaje, Unit3exportat_datos_a_turnos, Unit3reporte_mailing,
  Unit3lo_que_tiene_que_venir;

{$R *.dfm}

procedure TForm1.FormActivate(Sender: TObject);
var cr:tregistro;
tf:tfuncion;
path,virtua:string;
begin
//ingreso_al_sistema.showmodal;
cr:=tregistro.Create;
with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(APPLICATION_KEY) then
      Begin
     //statusbar1.Panels[3].Text:=ReadString('Empresa');
      uglobal.ID_EMPRESA:=ReadString('Empresa');
      //actual:=ReadString('Conex_actual');
      end;
  Finally
    free;
  end;

//statusbar1.Panels[3].Text:=cr.GetRegistryData(HKEY_LOCAL_MACHINE,'\software\TurnosOnline', 'empresa');

cr.Free;
tf:=tfuncion.Create;
//uglobal.ID_EMPRESA:=tf.GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Empresa');

 with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(APPLICATION_KEY) then
      Begin
     virtua:=ReadString('virtual');

      //actual:=ReadString('Conex_actual');
      end;
  Finally
    free;
  end;



  if virtua='1' then
      SPEEDBUTTON3.Visible:=TRUE
       ELSE
       SPEEDBUTTON3.Visible:=FALSE;




 if uglobal.ID_EMPRESA='0003' then
    begin
     path := GetCurrentDir+'/BandArg.bmp' ;
    image3.Picture.LoadFromFile(path);
    end;

     if uglobal.ID_EMPRESA='0001' then
    begin
     path := GetCurrentDir+'/BandChile.bmp' ;
    image3.Picture.LoadFromFile(path);
    end;
   // label3.Caption:=datetostr(date);

 statusbar1.Panels[3].Text:=uconst.VERSION;
label3.Caption:=datetostr(date);
label4.Caption:=inttostr(tf.devuelve_cantidad_turnos_fecha(datetostr(date)));
tf.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var tf:tfuncion;
begin

statusbar1.Panels[0].Text:=datetostr(date);
statusbar1.Panels[1].Text:=TIMEtostr(TIME);
tf:=tfuncion.Create;
//tf.devuelve_cantidad_turnos_fecha(datetostr(date));

tf.Free;

end;

procedure TForm1.GestindeUsuarios1Click(Sender: TObject);
begin
gestion_usuarios.showmodal;
end;

procedure TForm1.GestindeEmpresas1Click(Sender: TObject);
begin
gestion_de_empresa.showmodal;
end;

procedure TForm1.HabilitarEmpresa1Click(Sender: TObject);
begin
habiliar_empresa.showmodal;
end;

procedure TForm1.CrearPlantilla1Click(Sender: TObject);
begin
crear_plantilla.showmodal;
end;

procedure TForm1.GestionTurnos1Click(Sender: TObject);
begin
gestion_de_turnos.porfecha.Visible:=falsE;
gestion_de_turnos.showmodal;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
CrearPlantilla1Click(Sender);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
GestionTurnos1Click(Sender);
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
modulo.conexion.Close;
end;

procedure TForm1.VerPlantilla1Click(Sender: TObject);
begin
ver_plantillas.showmodal;
end;

procedure TForm1.HabilitarPlantillas1Click(Sender: TObject);
begin
modificar_plantillas.showmodal;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
cambiar_plantillas.showmodal;
end;

procedure TForm1.DetalledeTurnosporCentros1Click(Sender: TObject);
begin
detalle_de_turnos_por_centros.showmodal;
end;

procedure TForm1.CantidaddeTurnosporCentros1Click(Sender: TObject);
begin
detalle_cantidad_por_centro_por_fecha.opcion:=1;
detalle_cantidad_por_centro_por_fecha.showmodal;
end;

procedure TForm1.CantidadporFechadeRegistro1Click(Sender: TObject);
begin
detalle_cantidad_por_centro_por_fecha.opcion:=2;
detalle_cantidad_por_centro_por_fecha.showmodal;
end;

procedure TForm1.BorrarTurno1Click(Sender: TObject);
begin
borrar_turno.showmodal;
end;

procedure TForm1.CambiardeCentro1Click(Sender: TObject);
begin
cambiar_centro.showmodal;
end;

procedure TForm1.CantidaddeTurnosglobalizadoporPlanta1Click(
  Sender: TObject);
begin
seleccione_fecha_cantidad_turnos_globalizado.DateTimePicker1.DateTime:=now;
seleccione_fecha_cantidad_turnos_globalizado.DateTimePicker2.DateTime:=now;

seleccione_fecha_cantidad_turnos_globalizado.showmodal;
end;

procedure TForm1.CantidaddeTurnosasginadosporplantilla1Click(
  Sender: TObject);
begin
seleccione_fecha_turnos_por_plantilla.showmodal;
end;

procedure TForm1.ListadosparaMailing1Click(Sender: TObject);
var fd,fh,digito,mes,anio,sql:string;
ExcelApp,excellibro,ExcelHoja: Variant;
f,i:integer;
begin
seleccionefechayplanta.showmodal;
if  seleccionefechayplanta.sale =true then
exit;

fd:=seleccionefechayplanta.selecMes.Text;
//codigoplanta:=seleccionefechayplanta.DBLookupComboBox1.KeyValue;

mensaje.show;
application.ProcessMessages;

if fd='Enero' then
begin
  digito:='9';
  mes:='01';
end
else
if fd='Febrero' then
begin
  digito:='0';
  mes:='02';
end
else
if fd='Abril'  then
begin
  digito:='1';
  mes:='04';
end
else
if fd='Mayo' then
begin
  digito:='2';
  mes:='05';
end
else
if fd='Junio' then
begin
  digito:='3';
  mes:='06';
end
else
if fd='Julio' then
begin
  digito:='4';
  mes:='07';
end
else
if fd='Agosto' then
begin
  digito:='5';
  mes:='08';
end
else
if fd='Septiembre' then
begin
  digito:='6';
  mes:='09';
end
else
if fd='Octubre' then
begin
  digito:='7';
  mes:='10';
end
else
if fd='Noviembre' then
begin
  digito:='8';
  mes:='11';
end;

{anio:=FormatDateTime('yyyy',Date);}
anio:=trim(seleccionefechayplanta.edit1.text);

sql:='SELECT DISTINCT R.PATENTE,ISNULL(C.NOMBRE,'''') AS PLANTA,R.EMAIL,R.NOMBRE,APELLIDO, R.FECHA  AS FECHATURNO '+
' FROM (RESERVA R INNER JOIN (SELECT DISTINCT UPPER(REPLACE(REPLACE(REPLACE(PATENTE,''-'',''''),'' '',''''),''.'','''')) as PATENTE,'+
' MAX(NUMERO) AS NUMERO FROM RESERVA '+
' WHERE  PATENTE LIKE ''%'+digito+''' GROUP BY UPPER(REPLACE(REPLACE(REPLACE(PATENTE,''-'',''''),'' '',''''),''.'','''') )) M ON '+
' R.NUMERO=M.NUMERO) LEFT JOIN CENTROS C ON R.CENTRO=C.CENTRO LEFT JOIN REVISIONVEHICULO RV ON  '+
' UPPER(REPLACE(REPLACE(REPLACE(R.PATENTE,''-'',''''),'' '',''''),''.'',''''))= '+
' UPPER(REPLACE(REPLACE(REPLACE(RV.PATENTE,''-'',''''),'' '',''''),''.'','''')) AND FECVENCI<''01/'+mes+'/'+anio+''''+
' WHERE R.FECHA < ''01/'+mes+'/'+anio+'''';

ADOQuery1.Close;
ADOQuery1.SQL.Clear;
ADOQuery1.SQL.Add(sql);
ADOQuery1.ExecSQL;
application.ProcessMessages;
ADOQuery1.Open;
application.ProcessMessages;

seleccionefechayplanta.scExcelExport1.Dataset:=self.ADOQuery1;

seleccionefechayplanta.scExcelExport1.ExcelVisible:=true;
seleccionefechayplanta.scExcelExport1.ExportDataset;
application.ProcessMessages;
seleccionefechayplanta.scExcelExport1.Disconnect;
mensaje.close;
{
opendialog.Title :='Seleccione la Plantilla de Entrada';
if OpenDialog.Execute then
begin
  ExcelApp:=CreateOleObject('Excel.Application');
  ExcelLibro:=ExcelApp.Workbooks.open(OpenDialog.FileName);
  ExcelHoja:=ExcelLibro.Worksheets[1];

  ADOQuery1.First;

  f:=0;

  while not ADOQuery1.Eof do begin
    f:=f+1;
    i:=0;
    ExcelHoja.Cells[f,i+1].value:=ADOQuery1.Fields[i].AsString; i:=i+1;
    ExcelHoja.Cells[f,i+1].value:=ADOQuery1.Fields[i].AsString; i:=i+1;
    ExcelHoja.Cells[f,i+1].value:=ADOQuery1.Fields[i].AsString; i:=i+1;
    ExcelHoja.Cells[f,i+1].value:=ADOQuery1.Fields[i].AsString; i:=i+1;
    ExcelHoja.Cells[f,i+1].value:=ADOQuery1.Fields[i].AsString; i:=i+1;
    ExcelHoja.Cells[f,i+1].value:=ADOQuery1.Fields[i].AsString; i:=i+1;
  end;

  SaveDialog1.Title := 'Seleccione la Plantilla de Salida';
  if SaveDialog1.Execute then
    excellibro.saveas(SaveDialog1.filename);
  ExcelApp.Quit;

end;

 }

end;

procedure TForm1.ExportarDatos1Click(Sender: TObject);
begin
exportat_datos_a_turnos.showmodal;
end;

procedure TForm1.Reporte1Click(Sender: TObject);
begin
reporte_mailing.showmodal;
end;

procedure TForm1.Loquetienenquevenir1Click(Sender: TObject);
var sql,fe,fh:string;
begin
lo_que_tiene_que_venir.showmodal;
if lo_que_tiene_que_venir.sale=true then
exit;

mensaje.Show;

fe:=datetostr(lo_que_tiene_que_venir.DateTimePicker1.DateTime);
fh:=datetostr(lo_que_tiene_que_venir.DateTimePicker2.DateTime);





ADOQuery1.Close;
ADOQuery1.SQL.Clear;
ADOQuery1.SQL.Add('select c.centro as Nro_Centro, c.nombre as Nombre_Centro, c.observacion as Direccion_Centro, '+
                  ' r.fecha as Fecha_Turno, r.hora as Hora_Turno, r.fechalta as Fecha_Alta_Turno,r.email as Email_Cliente, '+
                  ' r.patente as PAtente, r.nombre as Nombre_Cliente, r.apellido as Apellido_Cliente  '+
                  ' from reserva r, centros c '+
                  ' where r.centro =c.centro '+
                  ' and r.fecha between convert(datetime,'+#39+trim(fe)+#39+',103) and convert(datetime,'+#39+trim(fh)+#39+',103) '+
                  ' order by r.fecha asc');
ADOQuery1.ExecSQL;
application.ProcessMessages;
ADOQuery1.Open;
application.ProcessMessages;

mensaje.Close;
scExcelExport1.Dataset:=ADOQuery1;

scExcelExport1.ExcelVisible:=true;
scExcelExport1.ExportDataset;
application.ProcessMessages;
scExcelExport1.Disconnect;




end;

procedure TForm1.N6Click(Sender: TObject);
var sql,fe,fh:string;
begin
lo_que_tiene_que_venir.showmodal;
if lo_que_tiene_que_venir.sale=true then
exit;

mensaje.Show;
APPLICATION.ProcessMessages;

fe:=datetostr(lo_que_tiene_que_venir.DateTimePicker1.DateTime);
fh:=datetostr(lo_que_tiene_que_venir.DateTimePicker2.DateTime);


 with ADOStoredProc1 do
          begin
            ProcedureName:='REP_Asistencia_reserva';
            Parameters.CreateParameter('@FechaIni',ftDateTime,pdInput,0,0);
            Parameters.CreateParameter('@FechaFin',ftDateTime,pdInput,0,0);
            Parameters.ParamByName('@FechaIni').Value:= fe+' 00:00:00';
            Parameters.ParamByName('@FechaFin').Value:= fh+' 23:59:59';

            Prepared:= True;
            ExecProc;
          end;



ADOQuery1.Close;                                                               
ADOQuery1.SQL.Clear;
aDOQuery1.SQL.Add('select PLANTA, PATENTE,NOMBRE_CLIENTE,APELLIDO_CLIENTE,EMAIL_CLIENTE,Telefono_Cliente,PICKLISTDESC,FECHA_INSPECCION, Fecha_Reserva from reporte order by 1');
ADOQuery1.ExecSQL;
application.ProcessMessages;
ADOQuery1.Open;
application.ProcessMessages;

mensaje.Close;
scExcelExport1.Dataset:=ADOQuery1;

scExcelExport1.ExcelVisible:=true;
scExcelExport1.ExportDataset;
application.ProcessMessages;
scExcelExport1.Disconnect;





end;

end.
