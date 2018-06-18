unit Ufrmturnos;

interface

uses
     Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
        ExtCtrls, RXCtrls, StdCtrls, UCEdit, Mask, ToolEdit, RXSpin, IniFiles,
        Buttons, WSFEV1,  IdSMTP, IdMessage,
        UCDialgs,    SQLExpr, DATEUTILS,
        USAGDATA,
        USAGESTACION,
        USAGFABRICANTE,
        USAGVARIOS,
        USAGCLASIFICACION,    ULOGS,
        GLOBALS,
        DATEUTIL,
        USAGDOMINIOS,       Ufrmconveniorucara,
        USAGCLASSES,
        UFMANTCLIENTES,
        RXDBCtrl, RXLookup, DBCtrls, UCDBEdit, Db, Animate, GIFCtrl,
        ugacceso, ACCESO1, acceso, Uutils, UFPagoConTarjeta, Grids, DBGrids,
        uFPagoConCheque, UFDatosPromocion, ImgList, RxGIF,
        provider,
        dbclient,usuperregistry, FMTBcd, RxMemDS, InvokeRegistry, xmldom,
  XMLIntf, msxmldom, XMLDoc, Rio, SOAPHTTPClient, ComCtrls, Menus;

type
  Tfrmturnos = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DataSource1: TDataSource;
    RxMemoryData1: TRxMemoryData;
    RxMemoryData1turnoid: TIntegerField;
    RxMemoryData1hora: TStringField;
    RxMemoryData1patente: TStringField;
    RxMemoryData1estado: TStringField;
    RxMemoryData1titular: TStringField;
    RxMemoryData1telefono: TStringField;
    RxMemoryData1reviso: TStringField;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
   // HTTPRIO1: THTTPRIO;
    XMLDocument1: TXMLDocument;
    Memo1: TMemo;
    Memo2: TMemo;
    XMLDocument2: TXMLDocument;
    BitBtn4: TBitBtn;
    RxMemoryData1INFOME: TStringField;
    RxMemoryData1MOTIVO: TStringField;
    RxMemoryData1codinspe: TIntegerField;
    RxMemoryData1anio: TIntegerField;
    BitBtn5: TBitBtn;
    RxMemoryData1resultado: TStringField;
    DateTimePicker1: TDateTimePicker;
    BitBtn6: TBitBtn;
    RxMemoryData1modo: TStringField;
    BitBtn7: TBitBtn;
    RxMemoryData1marca: TStringField;
    RxMemoryData1modelo: TStringField;
    RxMemoryData1tipoisnpe: TStringField;
    PopupMenu1: TPopupMenu;
    CambiodeDominiodelTurno1: TMenuItem;
    RxMemoryData1ESTADODES: TStringField;
    RxMemoryData1ausentes: TStringField;
    BitBtn8: TBitBtn;
    Label5: TLabel;
    RxMemoryData1estadid: TStringField;
    SolicitarTurnoReverificacion1: TMenuItem;
    BitBtn9: TBitBtn;
    Edit1: TEdit;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    RxMemoryData1ES: TStringField;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure CambiodeDominiodelTurno1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure timegrillaTimer(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure BitBtn8Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure procesosauscentesTimer(Sender: TObject);
    procedure TimeractulizarTimer(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
  private
    { Private declarations }
      public
      codturnoreve:longint;
  log_ws:textfile;
   HTTPRIO1: THTTPRIO;
    NOMBRE_PLANTA:string;
    HORA_AUSENTES:string;
    PLANTA:longint;
    USUARIO:longint;
    PASSWORD:string;
    HASH: string;
    fechaturno:string;
    TESTING_CONEX:boolean;
    respuestaidservidor:longint;
     respuestamensajeservidor ,disponibilidad_servidor:string;
    ver_disponibilidad_servidor:string;
    HORA_CIERRE:string;
    respuestaid_Abrir:longint ;
    respuestamensaje_Abrir:String;
    ingresoID_Abrir:string ;
    sesionID_Abrir:string ;
     Function informar_ausentes_por_id_tipo_5(idturno:longint):boolean;
    function INFORMA_INSPECCION_AL_WEBSERVICES_POR_IDTURNO_por_fecha(IDTURNO:LONGINT):BOOLEAN;
     Function informar_ausentes_por_id(idturno:longint):boolean;
    function INFORMA_INSPECCION_AL_WEBSERVICES(IDTURNO,CODINSPE,ANIO:LONGINT):BOOLEAN;
     function cargar_turnos(fecha:string):boolean;
    function arma_fecha_hora(fecha:string):string;
     function arma_fecha(fecha:string):string;
    function leer_respuesta_informar_verificacion(archivo:string;IDTURNO:LONGINT;men:string):boolean;
    FUNCTION Reemplazar_caracteres(CADENA:sTRING):STRING;
    FUNCTION ARMA_DATOS_VEHICULOS(vturnoid,vcodinspe,vanio:longint):STRING;
    FUNCTION ARMA_DATOS_TITULAR(vturnoid,vcodinspe,vanio:longint):STRING;
    FUNCTION ARMA_DATOS_VERIFICACION(vturnoid,vcodinspe,vanio:longint):STRING;
    Function arma_datos_presentante(vturnoid,vcodinspe,vanio:longint):STRING;
    Function arma_tramite_y_oblea(vturnoid,vcodinspe,vanio:longint):STRING;
    Function arma_formularios(vturnoid,vcodinspe,vanio:longint):STRING;
    Function Inicializa:boolean;
    Procedure CargarINI;
    function INFORMA_INSPECCION_AL_WEBSERVICES_POR_IDTURNO(IDTURNO:LONGINT):BOOLEAN;
    Function  Cerrar_seccion:boolean;
    Function ControlServidor:boolean;
    Procedure LeerArchivoEco;
    Function Abrir_Seccion:boolean;
    Procedure LeerArchivoAbrir;
    function INFORMA_INSPECCION_AL_WEBSERVICES_automatico(IDTURNO,CODINSPE,ANIO:LONGINT):BOOLEAN;
    function devuelve_resultado_inspe(codinspe:longint):string;
    Function informar_ausentes:boolean;
    function generar_archivo(nombrearchivo:string):boolean;
    Function Informar_Inspeccion(vturnoid,vcodinspe,vanio:longint):boolean;
    function devuelve_resultado_items(resultado:String):string;
    FunctION Devuelve_resultado_revision(codinspe,anio:longint):string;
     Function solicitar_reverificacion(idturno:longint;dominio:string;codinspe:longint):boolean;
     function leer_respuesta_reverificacion(archivo:string;IDTURNO:LONGINT;crea:boolean;men:string):boolean;
      Function cambiar_dominio_en_turno(idturno:longint;patentevieja,patentenueva:string):boolean ;
      function leer_respuesta_ausentes(archivo:string):boolean;
      function leer_respuesta_CAMBIOPATENTE(archivo:string;IDTURNO:LONGINT;PATENTE:sTRING):boolean;
      function INFORMA_INSPECCION_AL_WEBSERVICES_poridtunro(IDTURNO:LONGINT):BOOLEAN;
      FUNCTION EnviarMensaje_control(sDestino,hora,asunto,mensajea,sAdjunto:STRING):BOOLEAN;
       FUNCTION DEVUELVE_OBSERVACIONES(CODINSPE, CAPITULO:LONGINT):STRING;
Function Solicitar_turnos_por_id(HTTPRIO1: THTTPRIO;idturno:longint;spatente:string):boolean;
function DESCARGAR_TURNO_POR_PATENTE(IDTURNO:LONGINT;PATENTE:STRING):BOOLEAN;
FUNCTION DEVUELVE_ESTADO_TURNO(IDTURNO:LONGINT):LONGINT; 
function leer_respuesta_ausentes_POR_IDTUNRO(archivo:string;IDTURNO:LONGINT):boolean;
FUNCTION ARMA_DATOS_MEDICIONES(vturnoid,vcodinspe,vanio:longint):STRING;
  end;

var
  frmturnos: Tfrmturnos;

implementation

uses Unitimprimir_listadoturnos, Unicambiodominioturno, UFMainSag98;

{$R *.dfm}


function Tfrmturnos.leer_respuesta_CAMBIOPATENTE(archivo:string;IDTURNO:LONGINT;PATENTE:sTRING):boolean;
var archi:textfile;
linea,codmensaje, respuesta,INFORME:string;
posi,estadoturno:longint;  aq:tsqlquery;
   updatesql,insertasql:TSQLQuery;
       r,CODINSPE1:string;
 CODVEHIC,CODINSPE:LONGINT;
begin

assignfile(archi,archivo);
reset(archi);
while not eof(archi) do
begin
 readln(archi,linea);

 posi:=pos('</respuestaID',trim(linea));
  if posi > 0 then
     begin
       codmensaje:=trim(copy(trim(linea),0,posi-1));

     end;

 posi:=pos('</respuestaMensaje',trim(linea));
  if posi > 0 then
     begin
       respuesta:=trim(copy(trim(linea),0,posi-1));

     end;




end;
closefile(archi);
     respuesta:=codmensaje+' '+respuesta;


    IF TRIM(codmensaje)='1' THEN
       BEGIN

        updatesql:=TSQLQuery.Create(Self);
        updatesql.SQLConnection:=mybd;
        updatesql.Close;
        updatesql.SQL.Clear;

        updatesql.SQL.Add(' update tdatosturno set DVDOMINO='+#39+TRIM(PATENTE)+#39+' where  turnoid='+inttostr(IDTURNO));

       updatesql.ExecSQL ;

       updatesql.Close;
       updatesql.Free;


        updatesql:=TSQLQuery.Create(Self);
        updatesql.SQLConnection:=mybd;
        updatesql.Close;
        updatesql.SQL.Clear;

        updatesql.SQL.Add(' SELECT CODVEHIC, CODINSPE FROM tdatosturno where  turnoid='+inttostr(IDTURNO));
         updatesql.ExecSQL ;
       updatesql.OPEN ;
       CODVEHIC:=updatesql.FIELDBYNAME('CODVEHIC').ASINTEGER;
       CODINSPE:=updatesql.FIELDBYNAME('CODINSPE').ASINTEGER;
       CODINSPE1:=TRIM(updatesql.FIELDBYNAME('CODINSPE').ASSTRING);
       updatesql.Close;
       updatesql.Free;








        updatesql:=TSQLQuery.Create(Self);
        updatesql.SQLConnection:=mybd;
        updatesql.Close;
        updatesql.SQL.Clear;

        updatesql.SQL.Add(' update TVEHICULOS set PATENTEN='+#39+TRIM(PATENTE)+#39+' where  CODVEHIC='+inttostr(CODVEHIC));

       updatesql.ExecSQL ;

       updatesql.Close;
       updatesql.Free;


         IF TRIM(CODINSPE1)<>'' THEN
         BEGIN

              updatesql:=TSQLQuery.Create(Self);
              updatesql.SQLConnection:=mybd;
              updatesql.Close;
              updatesql.SQL.Clear;

              updatesql.SQL.Add(' update TESTADOINSP set MATRICUL='+#39+TRIM(PATENTE)+#39+' where  CODINSPE='+inttostr(CODINSPE));

              updatesql.ExecSQL ;

              updatesql.Close;
              updatesql.Free;

       END;

       END;



        Application.MessageBox( PCHAR('RESPUESTA DE SUIVTV: '+respuesta), 'Atención',
      MB_ICONINFORMATION )









end;



function Tfrmturnos.generar_archivo(nombrearchivo:string):boolean;
Var
i,desde:longint;
 archi:textfile;   linea,linea1:string;
begin
generar_archivo:=false;
memo1.Clear;
memo2.Clear;
memo1.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + nombrearchivo+'.xml');//'CONSULTA.XML');
linea:=memo1.Lines.Text;
desde:=0;
for i:=0 to length(linea) do
begin
    if linea[i]='>' then
     begin
      memo2.Lines.Add(linea1);
      linea1:='';
      generar_archivo:=true;
     end else
     begin
      linea1:=linea1 + linea[i];

     end;


end;
  memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + nombrearchivo+'.txt');
  generar_archivo:=TRUE;
end;


 Function Tfrmturnos.informar_ausentes:boolean;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
     TESTING:boolean;
   CANTIDAD:LONGINT;
  defWSDL,fecharchivo,fecha1:string;
  defURL :string;
  defSvc,fechaturno:string;
  defPrt,xml,fecha,cola,TAG:string;
  aq:tsqlquery;
  begin
  try







fecha:=datetostr(date);
fecha1:=datetostr(date);
fecha:=copy(trim(fecha),7,4)+'-'+copy(trim(fecha),4,2)+'-'+copy(trim(fecha),1,2);

fecharchivo:=copy(trim(fecha1),7,4)+copy(trim(fecha1),4,2)+copy(trim(fecha1),1,2);

xml:='<?xml version="1.0" encoding="UTF-8"?> '+
'<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:ns1="urn:suvtv" '+
' xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '+
' SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">  '+
   '<SOAP-ENV:Body>' +
    '  <ns1:informarAusentes>  '+
    '     <usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(self.USUARIO)+'</usuarioID>  '+
    '     <ingresoID xsi:type="xsd:unsignedLong">'+TRIM(self.ingresoID_Abrir)+'</ingresoID> '+
    '     <plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(self.PLANTA)+'</plantaID>  '+
    '     <fecha xsi:type="xsd:date">'+trim(fecha)+'</fecha>   ';



   {
xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '+
     'xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:informarAusentes soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(self.USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(self.ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(self.PLANTA)+'</plantaID>'+
         '<fecha xsi:type="xsd:date">'+trim(fecha)+'</fecha>';

  }



fechaturno:=datetostr(date);

aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
aq.sql.add('SELECT  COUNT(*) FROM tdatosturno   '+
                     ' WHERE fechaturno < to_date('+#39+trim(fechaturno)+#39+',''dd/mm/yyyy'') and TRIM(ausente) in (''S'',''N'') and trim(reviso)=''N'' and TRIM(modo)=''P''  AND ESTADOID in(1,5,7) ');

{aq.sql.add('SELECT  COUNT(*) FROM tdatosturno   '+
                     ' WHERE  ausente=''S'' ');  }
aq.ExecSQL;
aq.open;
CANTIDAD:=AQ.FIELDS[0].ASINTEGER;

//XML:=XML +  '<turnos xsi:type="urn:turnosAusentesLista" soapenc:arrayType="urn:turnosAusentes['+TRIM(AQ.FIELDS[0].ASSTRING)+']"/>';

 XML:=XML +    '     <turnos SOAP-ENC:arrayType="ns1:turnosAusentes['+TRIM(AQ.FIELDS[0].ASSTRING)+']" xsi:type="ns1:turnosAusentesLista"> ';

AQ.CLOSE;
AQ.FREE;

IF CANTIDAD > 0 THEN
BEGIN
aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
{aq.sql.add('SELECT  TURNOID, DVDOMINO FROM tdatosturno   '+
                     ' WHERE  ausente=''S'' ');  }


aq.sql.add('SELECT  TURNOID, DVDOMINO FROM tdatosturno   '+
                     ' WHERE fechaturno < to_date('+#39+trim(fechaturno)+#39+',''dd/mm/yyyy'') and TRIM(ausente) in (''S'',''N'') and trim(reviso)=''N'' and TRIM(modo)=''P''  AND ESTADOID in(1,5,7)  ');

aq.ExecSQL;
aq.open;
while not aq.eof do
begin



TAG:=TAG+'<item xsi:type="ns1:turnosAusentes">  '+
            '   <turnoID xsi:type="xsd:unsignedLong">'+TRIM(AQ.FIELDBYNAME('turnoid').ASSTRING)+'</turnoID>   '+
            '   <dominio xsi:type="xsd:string">'+TRIM(AQ.FIELDBYNAME('dvdomino').ASSTRING)+'</dominio> '+
            '</item>';


{TAG:=TAG+'<item xsi:type="tns:turnosAusentes"> '+
         '<turnoID xsi:type="xsd:unsignedLong">'+TRIM(AQ.FIELDBYNAME('turnoid').ASSTRING)+'</turnoID>'+
         '<dominio xsi:type="xsd:string">'+TRIM(AQ.FIELDBYNAME('dvdomino').ASSTRING)+'</dominio>'+
         '</item> '; }


    aq.next;
end;

AQ.CLOSE;
AQ.FREE;

 cola:='</turnos>'+
      '</ns1:informarAusentes>'+
   '</SOAP-ENV:Body>'+
'</SOAP-ENV:Envelope> ';


XML:=xml+TAG+COLA;


strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');

 Memo2.Lines.LoadFromStream(request);
 Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'Enviadoinformarausentes.xml');

recieveID :=HTTPRIO1.HTTPWebNode.Send(request);
         //Request

HTTPRIO1.HTTPWebNode.Receive(recieveID,response,false);    //Response

Memo2.Clear;
response.Position := 0;
Memo2.Lines.LoadFromStream(response);

Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'informarausentes.xml');
strings.Free;
request.Free;
response.Free

END;

informar_ausentes:=true;
except
  informar_ausentes:=falsE;
end;



 end;



 Function Tfrmturnos.informar_ausentes_por_id(idturno:longint):boolean;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
     TESTING:boolean;
   CANTIDAD:LONGINT;
  defWSDL:string;
  defURL :string;
  defSvc,fechaturno:string;
  defPrt,xml,fecha,cola,TAG:string;
  aq:tsqlquery;
  begin
  try



  aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
{aq.sql.add('SELECT  TURNOID, DVDOMINO FROM tdatosturno   '+
                     ' WHERE  ausente=''S'' ');  }


aq.sql.add('SELECT  fechaturno FROM tdatosturno   '+
                     ' WHERE turnoid='+inttostr(idturno));

aq.ExecSQL;
aq.open;

fecha:=AQ.FIELDS[0].asstring;

aq.Close;
aq.free;




fecha:=copy(trim(fecha),7,4)+'-'+copy(trim(fecha),4,2)+'-'+copy(trim(fecha),1,2);


xml:='<?xml version="1.0" encoding="UTF-8"?> '+
'<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:ns1="urn:suvtv" '+
' xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '+
' SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">  '+
   '<SOAP-ENV:Body>' +
    '  <ns1:informarAusentes>  '+
    '     <usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(self.USUARIO)+'</usuarioID>  '+
    '     <ingresoID xsi:type="xsd:unsignedLong">'+TRIM(self.ingresoID_Abrir)+'</ingresoID> '+
    '     <plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(self.PLANTA)+'</plantaID>  '+
    '     <fecha xsi:type="xsd:date">'+trim(fecha)+'</fecha>   ';



   {
xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '+
     'xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:informarAusentes soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(self.USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(self.ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(self.PLANTA)+'</plantaID>'+
         '<fecha xsi:type="xsd:date">'+trim(fecha)+'</fecha>';

  }



aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
aq.sql.add('SELECT  COUNT(*) FROM tdatosturno   '+
                     ' WHERE turnoid='+inttostr(idturno));

{aq.sql.add('SELECT  COUNT(*) FROM tdatosturno   '+
                     ' WHERE  ausente=''S'' ');  }
aq.ExecSQL;
aq.open;
CANTIDAD:=AQ.FIELDS[0].ASINTEGER;

//XML:=XML +  '<turnos xsi:type="urn:turnosAusentesLista" soapenc:arrayType="urn:turnosAusentes['+TRIM(AQ.FIELDS[0].ASSTRING)+']"/>';

 XML:=XML +    '     <turnos SOAP-ENC:arrayType="ns1:turnosAusentes['+TRIM(AQ.FIELDS[0].ASSTRING)+']" xsi:type="ns1:turnosAusentesLista"> ';

AQ.CLOSE;
AQ.FREE;

IF CANTIDAD > 0 THEN
BEGIN
aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
{aq.sql.add('SELECT  TURNOID, DVDOMINO FROM tdatosturno   '+
                     ' WHERE  ausente=''S'' ');  }


aq.sql.add('SELECT  TURNOID, DVDOMINO FROM tdatosturno   '+
                     ' WHERE turnoid='+inttostr(idturno));

aq.ExecSQL;
aq.open;
while not aq.eof do
begin



TAG:=TAG+'<item xsi:type="ns1:turnosAusentes">  '+
            '   <turnoID xsi:type="xsd:unsignedLong">'+TRIM(AQ.FIELDBYNAME('turnoid').ASSTRING)+'</turnoID>   '+
            '   <dominio xsi:type="xsd:string">'+TRIM(AQ.FIELDBYNAME('dvdomino').ASSTRING)+'</dominio> '+
            '</item>';


{TAG:=TAG+'<item xsi:type="tns:turnosAusentes"> '+
         '<turnoID xsi:type="xsd:unsignedLong">'+TRIM(AQ.FIELDBYNAME('turnoid').ASSTRING)+'</turnoID>'+
         '<dominio xsi:type="xsd:string">'+TRIM(AQ.FIELDBYNAME('dvdomino').ASSTRING)+'</dominio>'+
         '</item> '; }


    aq.next;
end;

AQ.CLOSE;
AQ.FREE;

 cola:='</turnos>'+
      '</ns1:informarAusentes>'+
   '</SOAP-ENV:Body>'+
'</SOAP-ENV:Envelope> ';


XML:=xml+TAG+COLA;


strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');

 Memo2.Lines.LoadFromStream(request);
 Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'Enviadoinformarausentes.xml');

recieveID :=HTTPRIO1.HTTPWebNode.Send(request);
         //Request

HTTPRIO1.HTTPWebNode.Receive(recieveID,response,false);    //Response

Memo2.Clear;
response.Position := 0;
Memo2.Lines.LoadFromStream(response);

Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'informarausentes.xml');
strings.Free;
request.Free;
response.Free

END;

informar_ausentes_por_id:=true;
except
  informar_ausentes_por_id:=falsE;
end;



 end;



 
 Function Tfrmturnos.informar_ausentes_por_id_tipo_5(idturno:longint):boolean;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
     TESTING:boolean;
   CANTIDAD:LONGINT;
  defWSDL:string;
  defURL :string;
  defSvc,fechaturno:string;
  defPrt,xml,fecha,cola,TAG:string;
  aq:tsqlquery;
  begin
  try
 Inicializa;

ControlServidor;

if (disponibilidad_servidor='true') AND (self.respuestaidservidor=1) THEN
begin

  //ver_respuestamensajeservidor);
  APPLICATION.ProcessMessages;

Abrir_Seccion;
    if self.respuestaid_Abrir=1 then
     begin


  aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
{aq.sql.add('SELECT  TURNOID, DVDOMINO FROM tdatosturno   '+
                     ' WHERE  ausente=''S'' ');  }


aq.sql.add('SELECT  fechaturno FROM tdatosturno   '+
                     ' WHERE turnoid='+inttostr(idturno));

aq.ExecSQL;
aq.open;

fecha:=AQ.FIELDS[0].asstring;

aq.Close;
aq.free;




fecha:=copy(trim(fecha),7,4)+'-'+copy(trim(fecha),4,2)+'-'+copy(trim(fecha),1,2);


xml:='<?xml version="1.0" encoding="UTF-8"?> '+
'<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:ns1="urn:suvtv" '+
' xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '+
' SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">  '+
   '<SOAP-ENV:Body>' +
    '  <ns1:informarAusentes>  '+
    '     <usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(self.USUARIO)+'</usuarioID>  '+
    '     <ingresoID xsi:type="xsd:unsignedLong">'+TRIM(self.ingresoID_Abrir)+'</ingresoID> '+
    '     <plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(self.PLANTA)+'</plantaID>  '+
    '     <fecha xsi:type="xsd:date">'+trim(fecha)+'</fecha>   ';



   {
xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '+
     'xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:informarAusentes soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(self.USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(self.ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(self.PLANTA)+'</plantaID>'+
         '<fecha xsi:type="xsd:date">'+trim(fecha)+'</fecha>';

  }



aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
aq.sql.add('SELECT  COUNT(*) FROM tdatosturno   '+
                     ' WHERE turnoid='+inttostr(idturno));

{aq.sql.add('SELECT  COUNT(*) FROM tdatosturno   '+
                     ' WHERE  ausente=''S'' ');  }
aq.ExecSQL;
aq.open;
CANTIDAD:=AQ.FIELDS[0].ASINTEGER;

//XML:=XML +  '<turnos xsi:type="urn:turnosAusentesLista" soapenc:arrayType="urn:turnosAusentes['+TRIM(AQ.FIELDS[0].ASSTRING)+']"/>';

 XML:=XML +    '     <turnos SOAP-ENC:arrayType="ns1:turnosAusentes['+TRIM(AQ.FIELDS[0].ASSTRING)+']" xsi:type="ns1:turnosAusentesLista"> ';

AQ.CLOSE;
AQ.FREE;

IF CANTIDAD > 0 THEN
BEGIN
aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
{aq.sql.add('SELECT  TURNOID, DVDOMINO FROM tdatosturno   '+
                     ' WHERE  ausente=''S'' ');  }


aq.sql.add('SELECT  TURNOID, DVDOMINO FROM tdatosturno   '+
                     ' WHERE turnoid='+inttostr(idturno));

aq.ExecSQL;
aq.open;
while not aq.eof do
begin



TAG:=TAG+'<item xsi:type="ns1:turnosAusentes">  '+
            '   <turnoID xsi:type="xsd:unsignedLong">'+TRIM(AQ.FIELDBYNAME('turnoid').ASSTRING)+'</turnoID>   '+
            '   <dominio xsi:type="xsd:string">'+TRIM(AQ.FIELDBYNAME('dvdomino').ASSTRING)+'</dominio> '+
            '</item>';


{TAG:=TAG+'<item xsi:type="tns:turnosAusentes"> '+
         '<turnoID xsi:type="xsd:unsignedLong">'+TRIM(AQ.FIELDBYNAME('turnoid').ASSTRING)+'</turnoID>'+
         '<dominio xsi:type="xsd:string">'+TRIM(AQ.FIELDBYNAME('dvdomino').ASSTRING)+'</dominio>'+
         '</item> '; }


    aq.next;
end;

AQ.CLOSE;
AQ.FREE;

 cola:='</turnos>'+
      '</ns1:informarAusentes>'+
   '</SOAP-ENV:Body>'+
'</SOAP-ENV:Envelope> ';


XML:=xml+TAG+COLA;


strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');

 Memo2.Lines.LoadFromStream(request);
 Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'Enviadoinformarausentes.xml');

recieveID :=HTTPRIO1.HTTPWebNode.Send(request);
         //Request

HTTPRIO1.HTTPWebNode.Receive(recieveID,response,false);    //Response

Memo2.Clear;
response.Position := 0;
Memo2.Lines.LoadFromStream(response);

Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'informarausentes.xml');
strings.Free;
request.Free;
response.Free

END;


end;
  Cerrar_seccion;
end;




informar_ausentes_por_id_tipo_5:=true;
except
  informar_ausentes_por_id_tipo_5:=falsE;
end;



 end;


 Function Tfrmturnos.cambiar_dominio_en_turno(idturno:longint;patentevieja,patentenueva:string):boolean;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
     TESTING:boolean;
   CANTIDAD:LONGINT;
  defWSDL:string;
  defURL :string;
  defSvc,fechaturno:string;
  defPrt,xml,fecha,cola,TAG:string;
  aq:tsqlquery;
  begin
  try












xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '+
     'xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:informarCambioDominioTurno soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(self.USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(self.ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(self.PLANTA)+'</plantaID>'+
          '<turnoID xsi:type="xsd:unsignedLong">'+INTTOSTR(idturno)+'</turnoID>'+
          '<dominioTurno xsi:type="xsd:string">'+TRIM(patentevieja)+'</dominioTurno>'+
          '<dominioNuevo xsi:type="xsd:string">'+TRIM(patentenueva)+'</dominioNuevo>'+
          '</urn:informarCambioDominioTurno> '+
   '</soapenv:Body>'+
'</soapenv:Envelope>';















strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');

 Memo2.Lines.LoadFromStream(request);
 Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'cambiopatente'+inttostr(idturno)+'.xml');

recieveID :=HTTPRIO1.HTTPWebNode.Send(request);
         //Request

HTTPRIO1.HTTPWebNode.Receive(recieveID,response,false);    //Response

Memo2.Clear;
response.Position := 0;
Memo2.Lines.LoadFromStream(response);

Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'cambiopatente'+inttostr(idturno)+'.xml');
strings.Free;
request.Free;
response.Free ;



cambiar_dominio_en_turno:=true;
except
  cambiar_dominio_en_turno:=falsE;
end;



 end;

 Function Tfrmturnos.solicitar_reverificacion(idturno:longint;dominio:string;codinspe:longint):boolean;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
     TESTING:boolean;
   CANTIDAD:LONGINT;
  defWSDL:string;
  defURL :string;
  defSvc,fechaturno:string;
  defPrt,xml,fecha,cola,TAG:string;
  aq:tsqlquery;
  begin
  try


 {
 aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
aq.sql.add('SELECT  codinspe FROM tdatosturno   '+
                     ' WHERE  turnoid='+inttostr(idturno));


aq.ExecSQL;
aq.open;
codinspe:=aq.fields[0].asinteger;
 }



fecha:=datetostr(date);
fecha:=copy(trim(fecha),7,4)+'-'+copy(trim(fecha),4,2)+'-'+copy(trim(fecha),1,2);







XML:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '+
      'xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv"> '+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:solicitarTurnoReverificacion soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(self.USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(self.ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(self.PLANTA)+'</plantaID>'+
         '<turnoID xsi:type="xsd:unsignedLong">'+INTTOSTR(IDTURNO)+'</turnoID>'+
         '<dominio xsi:type="xsd:string">'+TRIM(DOMINIO)+'</dominio>'+
     '</urn:solicitarTurnoReverificacion>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';




strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');

 Memo2.Lines.LoadFromStream(request);
 Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'SolicitarReve'+inttostr(codinspe)+'.xml');

recieveID :=HTTPRIO1.HTTPWebNode.Send(request);
         //Request

HTTPRIO1.HTTPWebNode.Receive(recieveID,response,false);    //Response

Memo2.Clear;
response.Position := 0;
Memo2.Lines.LoadFromStream(response);

Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'Recibidoreve'+inttostr(codinspe)+'.xml');
strings.Free;
request.Free;
response.Free;

solicitar_reverificacion:=true;
 except
  solicitar_reverificacion:=falsE;

 end;




 end;

Procedure Tfrmturnos.LeerArchivoAbrir;
var
  ANode,ANode1,ANode2: IXMLNode;
  I,j,jj: integer;
  CadenaLibro,
  CadenaSalida,x: string;

begin

XMLDocument1.FileName:=ExtractFilePath(Application.ExeName) +'ABRIR.xml';
XMLDocument1.Active:=true;
  for I := 0 to XMLDocument1.DocumentElement.ChildNodes.Count - 1 do begin
    ANode := XMLDocument1.DocumentElement.ChildNodes[I];
    x:=anode.NodeName;

      for j := 0 to anode.ChildNodes.Count - 1 do begin
        ANode1 := anode.ChildNodes[j];
        x:=anode1.NodeName;
        for jj := 0 to anode1.ChildNodes.Count - 1 do begin
        ANode2 := anode1.ChildNodes[jj];
        x:=anode2.NodeName;

           if ANode2.NodeType = ntElement then
           begin
              respuestaid_Abrir :=strtoint(trim(ANode2.ChildNodes['respuestaID'].Text)) ;
              respuestamensaje_Abrir:=trim(ANode2.ChildNodes['respuestaMensaje'].Text) ;
              ingresoID_Abrir:=trim(ANode2.ChildNodes['ingresoID'].Text) ;
              sesionID_Abrir:=trim(ANode2.ChildNodes['sesionID'].Text) ;

             end;

    end;
    end;

  end;



end;

Procedure Tfrmturnos.LeerArchivoEco;
var
  ANode,ANode1,ANode2: IXMLNode;
  I,j,jj: integer;
  CadenaLibro,
  CadenaSalida,x: string;

begin
 
XMLDocument1.FileName:=ExtractFilePath(Application.ExeName) +'ECO.xml';
XMLDocument1.Active:=true;
  for I := 0 to XMLDocument1.DocumentElement.ChildNodes.Count - 1 do begin
    ANode := XMLDocument1.DocumentElement.ChildNodes[I];
    x:=anode.NodeName;

      for j := 0 to anode.ChildNodes.Count - 1 do begin
        ANode1 := anode.ChildNodes[j];
        x:=anode1.NodeName;
        for jj := 0 to anode1.ChildNodes.Count - 1 do begin
        ANode2 := anode1.ChildNodes[jj];
        x:=anode2.NodeName;

           if ANode2.NodeType = ntElement then
           begin
              respuestaidservidor :=strtoint(trim(ANode2.ChildNodes['respuestaID'].Text)) ;
              respuestamensajeservidor :=trim(ANode2.ChildNodes['respuestaMensaje'].Text) ;
              disponibilidad_servidor:=trim(ANode2.ChildNodes['disponible'].Text) ;
             end;

    end;
    end;

  end;




end;


 Function Tfrmturnos.ControlServidor:boolean;

var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
     TESTING:boolean;
     xml:string;
     Memoxml:tmemo;
begin

xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:eco soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"/>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';




strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');



recieveID :=HTTPRIO1.HTTPWebNode.Send(request);           //Request

HTTPRIO1.HTTPWebNode.Receive(recieveID,response,false);    //Response

response.Position := 0;
 MEMO2.CLEAR;
MEMO2.Lines.LoadFromStream(response);

MEMO2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'ECO.xml');


strings.Free;
request.Free;
response.Free;


LeerArchivoEco;

end;


Function Tfrmturnos.Cerrar_seccion:boolean;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
     TESTING:boolean;

  defWSDL:string;
  defURL :string;
  defSvc:string;
  defPrt,xml:string;
begin
xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:cerrarSesion soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(self.USUARIO)+'</usuarioID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(self.PLANTA)+'</pantaID>'+
        '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(ingresoID_Abrir)+'</ingresoID>'+
      '</urn:cerrarSesion>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';





strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');



recieveID :=HTTPRIO1.HTTPWebNode.Send(request);           //Request

HTTPRIO1.HTTPWebNode.Receive(recieveID,response,false);    //Response

Memo2.Clear;
response.Position := 0;
Memo2.Lines.LoadFromStream(response);

Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'CERRAR.xml');
strings.Free;
request.Free;
response.Free;

 HTTPRIO1.Free;
 end;


procedure Tfrmturnos.BitBtn1Click(Sender: TObject);
begin
 close;
end;

Procedure Tfrmturnos.CargarINI;
var INI: TIniFile;
T:sTRING;
begin

HTTPRIO1:=THTTPRIO.Create(application);
  if not FileExists( ExtractFilePath( Application.ExeName ) + 'config.ini' ) then
    Exit;


    INI := TINIFile.Create( ExtractFilePath( Application.ExeName ) + 'config.ini' );
    NOMBRE_PLANTA:=INI.ReadString( 'WEBSERVICES', 'NOMBRE_PLANTA', 'APPLUS' );
    PLANTA:= INI.ReadInteger( 'WEBSERVICES', 'PLANTA', 0 );
    USUARIO:= INI.ReadInteger( 'WEBSERVICES', 'USUARIO', 0 );
    PASSWORD:= INI.ReadString( 'WEBSERVICES', 'PASSWORD', '' );
    HASH:= INI.ReadString( 'WEBSERVICES', 'HASH', '' );
    T:=INI.ReadString( 'WEBSERVICES', 'TESTING', 'TRUE' );
    FMainSag98.HORA_AUSENTES:=trim(INI.ReadString( 'WEBSERVICES', 'HORA_AUSENTES', '20:00:00 p.m.' ));
    IF TRIM(T)='TRUE' THEN
     TESTING_CONEX:=TRUE
     ELSE
      TESTING_CONEX:=FALSe;


    HORA_CIERRE:='20:00:00';


  INI.Free;
end;

Function Tfrmturnos.Inicializa:boolean;
var
     TESTING:boolean;

  defWSDL:string;
  defURL :string;
  defSvc:string;
  defPrt,xml:string;
begin

  CargarINI;


 IF TESTING_CONEX=TRUE THEN
 BEGIN
  defWSDL:= 'http://testing.suvtv.com.ar/service/s_001.php?wsdl';
  defURL := 'http://testing.suvtv.com.ar/service/s_001.php';
  defSvc:= 'suvtv';
  defPrt:= 'suvtvPort';
 END ELSE BEGIN


   defWSDL:= 'https://www.suvtv.com.ar/service/s_001.php?wsdl';
  defURL := 'https://www.suvtv.com.ar/service/s_001.php';
  defSvc:= 'suvtv';
  defPrt:= 'suvtvPort';
  

  end;

 
  HTTPRIO1.WSDLLocation:=defWSDL;
  HTTPRIO1.Service:=defSvc;
  HTTPRIO1.Port:=defPrt;
  HTTPRIO1.URL:=defURL;
  HTTPRIO1.HTTPWebNode.SoapAction := defURL;


END;

 Function TFRMTURNOS.Devuelve_resultado_revision(codinspe,anio:longint):string;
var   aaq:tsqlquery;
begin
   aaq:=tsqlquery.create(nil);
   aaq.SQLConnection := MyBD;
   aaq.sql.add(' select resultad from tinspeccion where codinspe='+inttostr(codinspe));

   aaq.ExecSQL;
   aaq.open;
   while not aaq.eof do
   begin
       Devuelve_resultado_revision:=trim(aaq.fields[0].asstring);

       aaq.Next;
   end;
   aaq.close;
   aaq.free;
end;

function TFRMTURNOS.devuelve_resultado_items(resultado:String):string;
begin
    if  trim(resultado)='A' then
       devuelve_resultado_items:='A';

    if  trim(resultado)='R' then
       devuelve_resultado_items:='R';

    if  trim(resultado)='C' then
       devuelve_resultado_items:='C';


end;




Function Tfrmturnos.Abrir_Seccion:boolean;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
     TESTING:boolean;

  defWSDL:string;
  defURL :string;
  defSvc:string;
  defPrt,xml:string;
begin
xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv"> '+
     '<soapenv:Header/> '+
    '<soapenv:Body> '+
    '<urn:abrirSesion soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"> ';
xml:=xml+'<usuarioID xsi:type="xsd:unsignedLong">'+inttostr(self.USUARIO)+'</usuarioID> ';
xml:=xml+'<plantaID xsi:type="xsd:unsignedLong">'+inttostr(self.PLANTA)+'</plantaID> ';
xml:=xml+'<usuarioToken xsi:type="xsd:token">'+trim(self.PASSWORD)+'</usuarioToken> ';
xml:=xml+'<usuarioHash xsi:type="xsd:token">'+trim(self.HASH)+'</usuarioHash> '+
      '</urn:abrirSesion> '+
   '</soapenv:Body> '+
   '</soapenv:Envelope>';




strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');



recieveID :=HTTPRIO1.HTTPWebNode.Send(request);           //Request

HTTPRIO1.HTTPWebNode.Receive(recieveID,response,false);    //Response
MEMO2.CLEAR;
response.Position := 0;
MEMO2.Lines.LoadFromStream(response);

MEMO2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'ABRIR.xml');
strings.Free;
request.Free;
response.Free;

LeerArchivoAbrir;

end;

Function Tfrmturnos.arma_formularios(vturnoid,vcodinspe,vanio:longint):STRING;

var cadena,formularios,nro_certi,nro_inf:string;
cantidadcertif:longint;
 aq,aqI:tsqlquery;
 estadocertif:string;
begin
 aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
  // aQ.SQL.Add(' select count(*) from certificadoinspeccion where codinspe='+inttostr(vcodinspe));
   aQ.SQL.Add(' select count(*) from tcertificados where codinspe='+inttostr(vcodinspe));
   aq.ExecSQL;
   aq.open;
   cantidadcertif:=aq.fields[0].AsInteger;
   aq.close;
   aq.free;



    //cantidadcertif:=0;





   if cantidadcertif > 0 then
    begin
   // formularios:='<formularios SOAP-ENC:arrayType="xsd:unsignedLong['+inttostr(cantidadcertif)+']" xsi:type="ns1:formularios">';

    formularios:='<formularios SOAP-ENC:arrayType="ns1:formulariosListado['+inttostr(cantidadcertif)+']" xsi:type="ns1:formularios">';


    //formularios:='<formularios xsi:type="urn:formularios" soapenc:arrayType="xsd:unsignedLong['+inttostr(cantidadcertif)+']"/>';

    //  formularios:='<formularios SOAP-ENC:arrayType="xsd:unsignedLong['+inttostr(cantidadcertif)+']" xsi:type="ns1:formularios">';
      aq:=tsqlquery.create(nil);
      aq.SQLConnection := MyBD;
     // aQ.SQL.Add(' select codinspe,nrocertificado from certificadoinspeccion where codinspe='+inttostr(vcodinspe));
       aQ.SQL.Add(' select numcertif,estado from tcertificados where codinspe='+inttostr(vcodinspe));

      aq.ExecSQL;
      aq.open;
      while not aq.Eof do
       begin
           if trim(aq.fieldbyname('estado').asstring)='C' then
             estadocertif:='V';
          if trim(aq.fieldbyname('estado').asstring)='A' then
             estadocertif:='C';
          // formularios:=formularios + '<item xsi:type="xsd:unsignedLong">'+trim(aq.fieldbyname('nrocertificado').asstring)+'</item>';
         formularios:=formularios + '<item xsi:type="ns1:formulariosListado">'+
                                      '<formulario xsi:type="xsd:unsignedLong">'+trim(aq.fieldbyname('numcertif').asstring)+'</formulario>'+
                                      '<estado xsi:type="ns1:estadosFormularios">'+trim(estadocertif)+'</estado>'+
                                      '</item>';
         aq.Next;
     end;

     formularios:=formularios + '</formularios>';

     aq.Close;
     aq.free;
 end else begin
     //formularios:='<formularios xsi:type="urn:formularios" soapenc:arrayType="xsd:unsignedLong[]"/>';
     formularios:='<formularios SOAP-ENC:arrayType="tns:formulariosListado" xsi:type="ns1:formularios">';
 end;

  arma_formularios:=trim(formularios);


  
{
   aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add(' select count(*) from certificadoinspeccion where codinspe='+inttostr(vcodinspe));
   aq.ExecSQL;
   aq.open;
   cantidadcertif:=aq.fields[0].AsInteger;
   aq.close;
   aq.free;

   if   cantidadcertif = 0 then
   begin
       aq:=tsqlquery.create(nil);
       aq.SQLConnection := MyBD;
       aQ.SQL.Add(' select numcertif from tcertificados where codinspe='+inttostr(vcodinspe));
       aq.ExecSQL;
       aq.open;

        while not aq.eof do
        begin
         nro_inf:=inttostr(vcodinspe);
         nro_certi:=trim(aq.FieldByName('numcertif').asstring);
             aqI:=tsqlquery.create(nil);
             aqI.SQLConnection := MyBD;
             aQI.SQL.Add(' insert into certificadoinspeccion (codinspe, nrocertificado, nro_informe) values ('+inttostr(vcodinspe)+
             ','+#39+trim(nro_certi)+#39+','+#39+trim(nro_inf)+#39+')');
             aqI.ExecSQL;

             aqI.Close;
             aqI.free;

            aq.next;
        end;

       aq.close;
       aq.free;


   end;





     aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add(' select count(*) from certificadoinspeccion where codinspe='+inttostr(vcodinspe));
   aq.ExecSQL;
   aq.open;
   cantidadcertif:=aq.fields[0].AsInteger;
   aq.close;
   aq.free;






   if cantidadcertif > 0 then
    begin
    formularios:='<formularios SOAP-ENC:arrayType="xsd:unsignedLong['+inttostr(cantidadcertif)+']" xsi:type="ns1:formularios">';

    //formularios:='<formularios xsi:type="urn:formularios" soapenc:arrayType="xsd:unsignedLong['+inttostr(cantidadcertif)+']"/>';

    //  formularios:='<formularios SOAP-ENC:arrayType="xsd:unsignedLong['+inttostr(cantidadcertif)+']" xsi:type="ns1:formularios">';
      aq:=tsqlquery.create(nil);
      aq.SQLConnection := MyBD;
      aQ.SQL.Add(' select codinspe,nrocertificado from certificadoinspeccion where codinspe='+inttostr(vcodinspe));

      aq.ExecSQL;
      aq.open;
      while not aq.Eof do
       begin
          formularios:=formularios + '<item xsi:type="xsd:unsignedLong">'+trim(aq.fieldbyname('nrocertificado').asstring)+'</item>';
         aq.Next;
     end;

     formularios:=formularios + '</formularios>';

     aq.Close;
     aq.free;
 end else begin
     formularios:='<formularios xsi:type="urn:formularios" soapenc:arrayType="xsd:unsignedLong[]"/>';

 end;

  arma_formularios:=trim(formularios);
}

end;





Function Tfrmturnos.arma_tramite_y_oblea(vturnoid,vcodinspe,vanio:longint):STRING;
var cadena,formularios,nro_oblea,NRO_INFORME,resultado:string;
cantidadcertif:longint;
 aq:tsqlquery;
begin
      aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add(' select numoblea, resultad from tinspeccion where codinspe='+inttostr(vcodinspe)+' and ejercici='+inttostr(vanio));
   aq.ExecSQL;
   aq.open;
   resultado:=trim(aq.fields[1].asstring);
   nro_oblea:=trim(aq.fields[0].asstring);
   aq.close;
   aq.free ;

 if trim(resultado)='A' then
 begin
   if  trim(nro_oblea)='' then
    begin
       aq:=tsqlquery.create(nil);
       aq.SQLConnection := MyBD;
       aQ.SQL.Add(' select numoblea from tobleas where codinspe='+inttostr(vcodinspe)+' and ejercici='+inttostr(vanio));
       aq.ExecSQL;
       aq.open;
       nro_oblea:=trim(aq.fields[0].asstring);
       aq.close;
      aq.free ;

       if trim(nro_oblea)<>'' then
       begin
          aq:=tsqlquery.create(nil);
          aq.SQLConnection := MyBD;
          aQ.SQL.Add(' update tinspeccion set numoblea='+#39+trim(nro_oblea)+#39+' where codinspe='+inttostr(vcodinspe)+' and ejercici='+inttostr(vanio));
          aq.ExecSQL;
          aq.close;
      aq.free ;
      end;

 end;



    end;

     aq:=tsqlquery.create(nil);
     aq.SQLConnection := MyBD;
     aQ.SQL.Add(' select numoblea from tinspeccion where codinspe='+inttostr(vcodinspe)+' and ejercici='+inttostr(vanio));
     aq.ExecSQL;
     aq.open;
     nro_oblea:=trim(aq.fields[0].asstring);
     aq.close;
     aq.free ;
     if trim(nro_oblea)='' then
        nro_oblea:='';


     aq:=tsqlquery.create(nil);
     aq.SQLConnection := MyBD;
     aQ.SQL.Add(' select NRO_INFORME from CERTIFICADOINSPECCION where codinspe='+inttostr(vcodinspe));

     aq.ExecSQL;
     aq.open;
     NRO_INFORME:=trim(aq.fields[0].asstring);
     aq.closE;
     AQ.FREE;


       cadena:='<tramiteNumero xsi:type="xsd:unsignedLong">'+inttostr(vcodinspe)+'</tramiteNumero>';
    //cadena:='<tramiteNumero xsi:type="xsd:unsignedLong">'+inttostr(vcodinspe)+'</tramiteNumero>';


    if trim(nro_oblea)=''  then
        cadena:=cadena+'<obleaID xsi:nil="true"/>'
        else
        cadena:=cadena+'<obleaID xsi:type="xsd:unsignedLong">'+trim(nro_oblea)+'</obleaID>';
   

  arma_tramite_y_oblea:=trim(cadena);
end;


function Tfrmturnos.Reemplazar_caracteres(cadena:String):string;
begin

  cadena:= StringReplace(cadena, 'á', 'a',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, 'é', 'e',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, 'í', 'i',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, 'ó', 'o',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, 'ú', 'u',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, 'Á', 'A',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, 'É', 'E',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, 'Í', 'I',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, 'Ó', 'O',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, 'Ú', 'U',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, 'ñ', 'n',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, 'Ñ', 'N',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, '&', '',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, ';', '',[rfReplaceAll, rfIgnoreCase]);
    cadena:= StringReplace(cadena, 'À', 'A',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, 'È', 'E',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, 'Ì', 'I',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, 'Ò', 'O',[rfReplaceAll, rfIgnoreCase]) ;
  cadena:= StringReplace(cadena, 'Ù', 'U',[rfReplaceAll, rfIgnoreCase]) ;

  cadena:= StringReplace(cadena, 'à', 'a',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, 'è', 'e',[rfReplaceAll, rfIgnoreCase]) ;
  cadena:= StringReplace(cadena, 'ì', 'i',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, 'ò', 'o',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, 'ù', 'u',[rfReplaceAll, rfIgnoreCase]);

  cadena:= StringReplace(cadena, 'ü', 'u',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, 'Ü', 'U',[rfReplaceAll, rfIgnoreCase]);
   cadena:= StringReplace(cadena, '''', '',[rfReplaceAll, rfIgnoreCase]);
   cadena:= StringReplace(cadena, '´', '',[rfReplaceAll, rfIgnoreCase]);
    cadena:= StringReplace(cadena, '<', '',[rfReplaceAll, rfIgnoreCase]);
     cadena:= StringReplace(cadena, '>', '',[rfReplaceAll, rfIgnoreCase]);
       cadena:= StringReplace(cadena, '/', '',[rfReplaceAll, rfIgnoreCase]);
      cadena:= StringReplace(cadena, '¥', 'nio',[rfReplaceAll, rfIgnoreCase]);
     cadena:= StringReplace(cadena, '¡', '',[rfReplaceAll, rfIgnoreCase]);
     cadena:= StringReplace(cadena, '°', '',[rfReplaceAll, rfIgnoreCase]);
     cadena:= StringReplace(cadena, 'Ç', '',[rfReplaceAll, rfIgnoreCase]);
     cadena:= StringReplace(cadena, 'º', '',[rfReplaceAll, rfIgnoreCase]);
     cadena:= StringReplace(cadena, 'ª', '',[rfReplaceAll, rfIgnoreCase]);
     cadena:= StringReplace(cadena, 'Ö', 'O',[rfReplaceAll, rfIgnoreCase]);
     cadena:= StringReplace(cadena, 'ï', 'i',[rfReplaceAll, rfIgnoreCase]);

 Reemplazar_caracteres:=TRIM(CADENA);

end;

Function Tfrmturnos.arma_datos_presentante(vturnoid,vcodinspe,vanio:longint):STRING;
var cadena,formularios,nro_oblea,rz,contactoemail,domicilio,datosContacto,CONTACTOTELEFONO:string;
cantidadcertif,codclcon,CODDOCU,CODLOCALIDAD,codclpro:longint;
 aq:tsqlquery;   g,dfapellido,dfnombre,nro_cuit:string;
begin

  aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add('SELECT contactoemail,CONTACTOTELEFONO,titularnombre, titularapellido FROM TDATOSTURNO WHERE turnoid='+inttostr(vturnoid));
   aq.ExecSQL;
   aq.open;
   contactoemail:=trim(aq.fields[0].asstring);
   CONTACTOTELEFONO:=trim(aq.fields[1].asstring);
   dfnombre:=trim(aq.fields[2].asstring);
   dfapellido:=trim(aq.fields[3].asstring);
   aq.close;
   aq.free ;


   aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add(' select codclcon,codclpro from tinspeccion where codinspe='+inttostr(vcodinspe)+' and ejercici='+inttostr(vanio));
   aq.ExecSQL;
   aq.open;
   codclcon:=aq.fields[0].asinteger;
   codclpro:=aq.fields[1].asinteger;
   aq.close;
   aq.free ;

   aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add('select tipodocu,document,nombre, apellid1,localida, direccio, nrocalle,piso, depto,celular,cuit_cli,CODPOSTA,IDLOCALIDAD,genero from tclientes  '+
              ' where codclien='+inttostr(codclcon));
   aq.ExecSQL;
   aq.open;
   if aq.RecordCount = 0 then
   begin
        aq:=tsqlquery.create(nil);
        aq.SQLConnection := MyBD;
        aQ.SQL.Add('select tipodocu,document,nombre, apellid1,localida, direccio, nrocalle,piso, depto,celular,cuit_cli,CODPOSTA,IDLOCALIDAD,genero from tclientes  '+
              ' where codclien='+inttostr(codclpro));
        aq.ExecSQL;
        aq.open;

   end;

   CODLOCALIDAD:=AQ.FIELDBYNAME('IDLOCALIDAD').AsInteger;
    if trim(aq.fieldbyname('tipodocu').asstring)='DNI' THEN
         CODDOCU:=1;

   if trim(aq.fieldbyname('tipodocu').asstring)='CUIT' THEN
         CODDOCU:=9;

   if trim(aq.fieldbyname('tipodocu').asstring)='CI' THEN
         CODDOCU:=8;

   if trim(aq.fieldbyname('tipodocu').asstring)='LC' THEN
         CODDOCU:=3;

   if trim(aq.fieldbyname('tipodocu').asstring)='LE' THEN
         CODDOCU:=2;



      if trim(aq.fieldbyname('genero').asstring)='' then
         g:='M'
         else
         g:=trim(aq.fieldbyname('genero').asstring);



      if  (trim(aq.fieldbyname('NOMBRE').asstring)='') or (length(aq.fieldbyname('NOMBRE').asstring)<=2) then
          rz:=dfnombre+' '+dfapellido
           else
             if  (trim(aq.fieldbyname('APELLID1').asstring)='') or (length(aq.fieldbyname('APELLID1').asstring)<=2) then
                rz:=dfnombre+' '+dfapellido
                 else
                 rz:=trim(aq.fieldbyname('NOMBRE').asstring)+' '+trim(aq.fieldbyname('APELLID1').asstring);



   cadena:= '<datosPresentante xsi:type="ns1:datosPresentante">'+
            '<datosPersonales xsi:type="ns1:datosPersonales">'+
               '<genero xsi:type="ns1:genero">'+trim(g)+'</genero>'+
               '<tipoDocumento xsi:type="xsd:int">'+INTTOSTR(CODDOCU)+'</tipoDocumento>';
              // '<numeroDocumento xsi:type="xsd:unsignedLong">'+Reemplazar_caracteres(trim(aq.fieldbyname('document').asstring))+'</numeroDocumento>'+
              // '<numeroCuit xsi:nil="true"/>'+
               //'<numeroCuit xsi:type="xsd:unsignedLong">'+Reemplazar_caracteres(trim(aq.fieldbyname('cuit_cli').asstring))+'</numeroCuit>'+



   if CODDOCU=9 then
    begin

    nro_cuit:=StringReplace(aq.fieldbyname('cuit_cli').asstring, '-', '',[rfReplaceAll, rfIgnoreCase]);

         cadena:=cadena+'<numeroDocumento xsi:type="xsd:unsignedLong">'+Reemplazar_caracteres(trim(aq.fieldbyname('document').asstring))+'</numeroDocumento>'+
                        '<numeroCuit xsi:type="xsd:unsignedLong">'+Reemplazar_caracteres(trim(nro_cuit))+'</numeroCuit>';
     {
      cadena:=cadena+'<nombre xsi:nil="true"/>'+
               '<apellido xsi:nil="true"/>'+
                '<razonSocial xsi:type="xsd:string">'+Reemplazar_caracteres(trim(rz))+'</razonSocial>'+
            '</datosPersonales>'+#13;   }



       if (Reemplazar_caracteres(trim(aq.fieldbyname('NOMBRE').asstring))='') or (Reemplazar_caracteres(trim(aq.fieldbyname('NOMBRE').asstring))='0') then
          
       begin

             if (trim(dfnombre)='') or (trim(dfnombre)='0')  then
                   cadena:=cadena+'<nombre xsi:type="xsd:string">sin datos</nombre>'
                 else
                  cadena:=cadena+'<nombre xsi:type="xsd:string">'+Reemplazar_caracteres(dfnombre)+'</nombre>';

       end
       else
                cadena:=cadena+'<nombre xsi:type="xsd:string">'+Reemplazar_caracteres(trim(aq.fieldbyname('NOMBRE').asstring))+'</nombre>';







         if (Reemplazar_caracteres(trim(aq.fieldbyname('APELLID1').asstring))='')  or (Reemplazar_caracteres(trim(aq.fieldbyname('APELLID1').asstring))='0') then
         begin
            if (trim(dfapellido)='') or (trim(dfapellido)='0')  then
                 cadena:=cadena+'<apellido xsi:type="xsd:string">sin datos</apellido>'
                 else
                 cadena:=cadena+'<apellido xsi:type="xsd:string">'+Reemplazar_caracteres(dfapellido)+'</apellido>';

         end
                 else
                 cadena:=cadena+'<apellido xsi:type="xsd:string">'+Reemplazar_caracteres(trim(aq.fieldbyname('APELLID1').asstring))+'</apellido>';

         
            cadena:=cadena+'<razonSocial xsi:type="xsd:string">'+Reemplazar_caracteres(trim(rz))+'</razonSocial>'+
            '</datosPersonales>'+#13;


    end else
    begin
      cadena:=cadena+'<numeroDocumento xsi:type="xsd:unsignedLong">'+Reemplazar_caracteres(trim(aq.fieldbyname('document').asstring))+'</numeroDocumento>'+
             '<numeroCuit xsi:nil="true"/>';



            if Reemplazar_caracteres(trim(aq.fieldbyname('NOMBRE').asstring))='' then
                cadena:=cadena+'<nombre xsi:type="xsd:string">'+Reemplazar_caracteres(dfnombre)+'</nombre>'
                else
                cadena:=cadena+'<nombre xsi:type="xsd:string">'+Reemplazar_caracteres(trim(aq.fieldbyname('NOMBRE').asstring))+'</nombre>';


              if Reemplazar_caracteres(trim(aq.fieldbyname('APELLID1').asstring))='' then
                 cadena:=cadena+'<apellido xsi:type="xsd:string">'+Reemplazar_caracteres(dfapellido)+'</apellido>'
                 else
                 cadena:=cadena+'<apellido xsi:type="xsd:string">'+Reemplazar_caracteres(trim(aq.fieldbyname('APELLID1').asstring))+'</apellido>';


                cadena:=cadena+'<razonSocial xsi:nil="true"/>'+
               // '<razonSocial xsi:type="xsd:string">'+Reemplazar_caracteres(trim(rz))+'</razonSocial>'+
            '</datosPersonales>'+#13;


    end;

 {
cadena:=cadena+'<nombre xsi:type="xsd:string">'+Reemplazar_caracteres(trim(aq.fieldbyname('NOMBRE').asstring))+'</nombre>'+
               '<apellido xsi:type="xsd:string">'+Reemplazar_caracteres(trim(aq.fieldbyname('APELLID1').asstring))+'</apellido>'+
                '<razonSocial xsi:nil="true"/>'+
               // '<razonSocial xsi:type="xsd:string">'+Reemplazar_caracteres(trim(rz))+'</razonSocial>'+
            '</datosPersonales>'+#13;
      }


          domicilio:='<domicilio xsi:type="ns1:domicilio">'+#13;

           if pos('$',trim(aq.fieldbyname('direccio').asstring)) > 0  then
           begin
               domicilio:=domicilio +  '<calle xsi:type="xsd:string">ND</calle>'+#13


           end else
           begin

           if trim(aq.fieldbyname('direccio').asstring)<>'' then
              domicilio:=domicilio +  '<calle xsi:type="xsd:string">'+Reemplazar_caracteres(trim(aq.fieldbyname('direccio').asstring))+'</calle>'+#13
              else
               domicilio:=domicilio +  '<calle xsi:type="xsd:string">ND</calle>'+#13

        end;




            if (trim(aq.fieldbyname('nrocalle').asstring)<>'') and (trim(aq.fieldbyname('nrocalle').asstring)<>'0') then
              domicilio:=domicilio +'<numero xsi:type="xsd:string">'+Reemplazar_caracteres(trim(aq.fieldbyname('nrocalle').asstring))+'</numero>'+#13
              else
               domicilio:=domicilio +'<numero xsi:type="xsd:string">1</numero>'+#13;



            if trim(aq.fieldbyname('PISO').asstring)<>'' then
              domicilio:=domicilio + '<piso xsi:type="xsd:string">'+Reemplazar_caracteres(trim(aq.fieldbyname('PISO').asstring))+'</piso>'+#13
              else
              domicilio:=domicilio + '<piso xsi:nil="true"/>';

            if trim(aq.fieldbyname('DEPTO').asstring)<>'' then
              domicilio:=domicilio +  '<departamento xsi:type="xsd:string">'+Reemplazar_caracteres(trim(aq.fieldbyname('DEPTO').asstring))+'</departamento>'+#13
              else
              domicilio:=domicilio + '<departamento xsi:nil="true"/>';


            if trim(aq.fieldbyname('localida').asstring)<>'' then
              // domicilio:=domicilio +  '<localidad xsi:type="xsd:string">?</localidad>'+#13

             domicilio:=domicilio +  '<localidad xsi:type="xsd:string">'+Reemplazar_caracteres(trim(aq.fieldbyname('localida').asstring))+'</localidad>'+#13
              else
                domicilio:=domicilio +  '<localidad xsi:type="xsd:string">NL</localidad>'+#13;




              domicilio:=domicilio +'<provinciaID xsi:type="xsd:int">01</provinciaID>'+#13;
              domicilio:=domicilio +'<provincia xsi:type="xsd:string">BUENOS AIRES</provincia>'+#13;


             if (trim(aq.fieldbyname('CODPOSTA').asstring)<>'') and (trim(aq.fieldbyname('CODPOSTA').asstring)<>'0')  then
              domicilio:=domicilio + '<codigoPostal xsi:type="xsd:string">'+Reemplazar_caracteres(trim(aq.fieldbyname('CODPOSTA').asstring))+'</codigoPostal>'+#13
              else
               domicilio:=domicilio + '<codigoPostal xsi:type="xsd:string">1000</codigoPostal>'+#13;



              domicilio:=domicilio +  '</domicilio>'+#13;



             datosContacto:='<datosContacto xsi:type="ns1:datosContactoPresentante">'+#13;

             if trim(CONTACTOTELEFONO)<>'' then
                datosContacto:=datosContacto + '<telefonoCelular xsi:type="xsd:string">'+Reemplazar_caracteres(trim(CONTACTOTELEFONO))+'</telefonoCelular>'+#13
                else
                datosContacto:=datosContacto + '<telefonoCelular xsi:type="xsd:string">000000000</telefonoCelular>'+#13 ;




             if trim(contactoemail)<>'' then
                datosContacto:=datosContacto + '<email xsi:type="xsd:string">'+Reemplazar_caracteres(trim(contactoemail))+'</email>'+#13
                else
                datosContacto:=datosContacto + '<email xsi:type="xsd:string">sin mail</email>'+#13;




               datosContacto:=datosContacto+ '</datosContacto>'+#13;
               datosContacto:=datosContacto+'</datosPresentante>'+#13;


   aq.close;
   aq.free ;

  arma_datos_presentante:=trim(cadena)+trim(domicilio)+trim(datosContacto);
end;


function Tfrmturnos.arma_fecha(fecha:string):string;
var f1,f2,f3:String;
begin
f1:=trim(copy(trim(fecha),1,2));
f2:=trim(copy(trim(fecha),4,2));
f3:=trim(copy(trim(fecha),7,4));

arma_fecha:=f3+'-'+f2+'-'+f1;

end;

function Tfrmturnos.arma_fecha_hora(fecha:string):string;
var f1,f2,f3,fe,hora:String;
begin
f1:=trim(copy(trim(fecha),1,2));
f2:=trim(copy(trim(fecha),4,2));
f3:=trim(copy(trim(fecha),7,4));
hora:=trim(copy(trim(fecha),11,length(fecha)));
hora:='T'+trim(hora)+'-03:00';
fe:=f3+'-'+f2+'-'+f1;
arma_fecha_hora:=fe+hora;


end;

  FUNCTION Tfrmturnos.DEVUELVE_OBSERVACIONES(CODINSPE, CAPITULO:LONGINT):STRING;
 VAR aq:tsqlquery;
 BEGIN
     aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;

    aQ.SQL.Add('  SELECT  GETCADENADEFECTO('+INTTOSTR(CODINSPE)+','+INTTOSTR(CAPITULO)+') FROM DUAL');

   aq.ExecSQL;
   aq.open;
   DEVUELVE_OBSERVACIONES:=trim(aq.fields[0].asstring);
   AQ.Close;
  AQ.FREE;
 END;


FUNCTION Tfrmturnos.ARMA_DATOS_VERIFICACION(vturnoid,vcodinspe,vanio:longint):STRING;
VAR aq:tsqlquery;
CADENA,OBS,nro_linea,fechaentrada,fechasalida:sTRING;
BEGIN

aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;

    aQ.SQL.Add(' select  fechalta   from tinspeccion where codinspe='+inttostr(vcodinspe));

   aq.ExecSQL;
   aq.open;
   fechaentrada:=trim(aq.fields[0].asstring);
   AQ.Close;
  AQ.FREE;


   aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;

   { aQ.SQL.Add(' select   FECHAVENCIMIENTO, FECHAVIGENCIA, FECHAINICIO, FECHASALIDA, MOTORVERIFICACION, LUCESVERIFICACION,  '+
                          ' DIRECCIONVERIFICACION, FRENOSVERIFICACION, SUSPENSIONVERIFICACION, CHASISVERIFICACION, LLANTASVERIFICACION, NUEMATICOSVERIFICACION, '+
                          ' GENERALVERIFICACION,  CONTAMINACIONVERIFICACION, SEGURIDADVERIFICACION, OBSERVAC ,NUMLINS1 from informarverificacion where codinspe='+inttostr(vcodinspe));

   }


  aQ.SQL.Add(' select i.codinspe,  '+
 ' i.fecvenci as fechavencimiento,i.fechalta  as fechavigencia,i.horentz1 as fechainicio,i.horfinal as fechasalida,i.resultad resultado,   '+
' getDetalleVerificacion(''01'',codinspe) motorVerificacion, '+
' getDetalleVerificacion(''02'',codinspe) lucesVerificacion, '+
' getDetalleVerificacion(''03'',codinspe) direccionVerificacion, '+
' getDetalleVerificacion(''04'',codinspe) frenosVerificacion,  '+
' getDetalleVerificacion(''05'',codinspe) suspensionVerificacion, '+
' getDetalleVerificacion(''06'',codinspe) chasisVerificacion,  '+
' getDetalleVerificacion(''07'',codinspe) llantasVerificacion, '+
' getDetalleVerificacion(''08'',codinspe) nuematicosVerificacion, '+
' getDetalleVerificacion(''09'',codinspe) generalVerificacion, '+
' getDetalleVerificacion(''10'',codinspe) contaminacionVerificacion, '+
' getDetalleVerificacion(''11'',codinspe) seguridadVerificacion,i.observac ,i.numlins1   '+
' from tinspeccion i where I.codinspe='+inttostr(vcodinspe));


   aq.ExecSQL;
   aq.open;
   while not aq.eof do
   begin
   if trim(aq.fieldbyname('NUMLINS1').asstring)<>'' then
     nro_linea:=trim(aq.fieldbyname('NUMLINS1').asstring)
     else
     nro_linea:='1';


       fechasalida:=trim(aq.fieldbyname('FECHASALIDA').asstring);
       fechasalida:= StringReplace(fechasalida, 'p.m.', '',[rfReplaceAll, rfIgnoreCase]);

       fechaentrada:= StringReplace(fechaentrada, 'p.m.', '',[rfReplaceAll, rfIgnoreCase]);


        fechasalida:= StringReplace(fechasalida, 'a.m.', '',[rfReplaceAll, rfIgnoreCase]);

       fechaentrada:= StringReplace(fechaentrada, 'a.m.', '',[rfReplaceAll, rfIgnoreCase]);


    obs:='';
    if trim(Devuelve_resultado_revision(vcodinspe,vanio))='A' then
          begin
        CADENA:='<datosVerificacion xsi:type="ns1:datosVerificacion">'+
             '<resultado xsi:type="ns1:verificacionResultado">'+Devuelve_resultado_revision(vcodinspe,vanio)+'</resultado>'+
            '<fechaVencimiento xsi:type="xsd:date">'+arma_fecha(trim(aq.fieldbyname('FECHAVENCIMIENTO').asstring))+'</fechaVencimiento>'+
            '<fechaVigencia xsi:type="xsd:date">'+arma_fecha(trim(aq.fieldbyname('FECHAVIGENCIA').asstring))+'</fechaVigencia>'+
            '<fechaEntrada xsi:type="xsd:dateTime">'+arma_fecha_hora(trim(fechaentrada))+'</fechaEntrada>'+
            '<fechaSalida xsi:type="xsd:dateTime">'+arma_fecha_hora(trim(fechasalida))+'</fechaSalida>'+
            '<linea  xsi:type="xsd:int">'+trim(nro_linea)+'</linea>'+
              '<detallesVerificacion xsi:type="ns1:detallesVerificacion">'+
                '<motorVerificacion xsi:type="ns1:resultadoVerificacion">'+
                   '<resultado xsi:type="ns1:verificacionResultado">A</resultado>'+
                  '<observaciones xsi:type="xsd:string">'+obs+'</observaciones>'+
               '</motorVerificacion>'+
               '<lucesVerificacion xsi:type="ns1:resultadoVerificacion"> '+
                  '<resultado xsi:type="ns1:verificacionResultado">A</resultado>'+
                  '<observaciones xsi:type="xsd:string">'+obs+'</observaciones> '+
               '</lucesVerificacion>'+
               '<direccionVerificacion xsi:type="ns1:resultadoVerificacion"> '+
                   '<resultado xsi:type="ns1:verificacionResultado">A</resultado> '+
                  '<observaciones xsi:type="xsd:string">'+obs+'</observaciones> '+
               '</direccionVerificacion>'+
               '<frenosVerificacion xsi:type="ns1:resultadoVerificacion"> '+
                   '<resultado xsi:type="ns1:verificacionResultado">A</resultado>'+
                  '<observaciones xsi:type="xsd:string">'+obs+'</observaciones>'+
               '</frenosVerificacion>'+
               '<suspensionVerificacion xsi:type="ns1:resultadoVerificacion">'+
                   '<resultado xsi:type="ns1:verificacionResultado">A</resultado>'+
                  '<observaciones xsi:type="xsd:string">'+obs+'</observaciones>'+
               '</suspensionVerificacion>'+
               '<chasisVerificacion xsi:type="ns1:resultadoVerificacion"> '+
                   '<resultado xsi:type="ns1:verificacionResultado">A</resultado>'+
                  '<observaciones xsi:type="xsd:string">'+obs+'</observaciones>'+
               '</chasisVerificacion>'+
               '<llantasVerificacion xsi:type="ns1:resultadoVerificacion">'+
                   '<resultado xsi:type="ns1:verificacionResultado">A</resultado>'+
                  '<observaciones xsi:type="xsd:string">'+obs+'</observaciones>'+
               '</llantasVerificacion>'+
               '<neumaticosVerificacion xsi:type="ns1:resultadoVerificacion">'+
                   '<resultado xsi:type="ns1:verificacionResultado">A</resultado>'+
                  '<observaciones xsi:type="xsd:string">'+obs+'</observaciones>'+
               '</neumaticosVerificacion>'+
               '<generalVerificacion xsi:type="ns1:resultadoVerificacion">'+
                   '<resultado xsi:type="ns1:verificacionResultado">A</resultado>'+
                  '<observaciones xsi:type="xsd:string">'+obs+'</observaciones>'+
               '</generalVerificacion>'+
               '<contaminacionVerificacion xsi:type="ns1:resultadoVerificacion">'+
                   '<resultado xsi:type="ns1:verificacionResultado">A</resultado>'+
                  '<observaciones xsi:type="xsd:string">'+obs+'</observaciones>'+
               '</contaminacionVerificacion>'+
               '<seguridadVerificacion xsi:type="ns1:resultadoVerificacion">'+
                  '<resultado xsi:type="ns1:verificacionResultado">A</resultado>'+
                  '<observaciones xsi:type="xsd:string">'+obs+'</observaciones>'+
               '</seguridadVerificacion>'+

            SELF.ARMA_DATOS_MEDICIONES(vturnoid,vcodinspe,vanio)+
            '</detallesVerificacion> '+
            '<observaciones xsi:type="xsd:string">'+Reemplazar_caracteres(trim(aq.fieldbyname('OBSERVAC').asstring))+'</observaciones> '+
         '</datosVerificacion>';


          end else begin
        CADENA:='<datosVerificacion xsi:type="ns1:datosVerificacion">'+
             '<resultado xsi:type="ns1:verificacionResultado">'+Devuelve_resultado_revision(vcodinspe,vanio)+'</resultado>'+
            '<fechaVencimiento xsi:type="xsd:date">'+arma_fecha(trim(aq.fieldbyname('FECHAVENCIMIENTO').asstring))+'</fechaVencimiento>'+
            '<fechaVigencia xsi:type="xsd:date">'+arma_fecha(trim(aq.fieldbyname('FECHAVIGENCIA').asstring))+'</fechaVigencia>'+
            '<fechaEntrada xsi:type="xsd:dateTime">'+arma_fecha_hora(trim(fechaentrada))+'</fechaEntrada>'+
            '<fechaSalida xsi:type="xsd:dateTime">'+arma_fecha_hora(trim(fechasalida))+'</fechaSalida>'+
            '<linea  xsi:type="xsd:int">'+trim(nro_linea)+'</linea>'+
              '<detallesVerificacion xsi:type="ns1:detallesVerificacion">'+
                '<motorVerificacion xsi:type="ns1:resultadoVerificacion">'+
                   '<resultado xsi:type="ns1:verificacionResultado">'+trim(devuelve_resultado_items(trim(aq.fieldbyname('MOTORVERIFICACION').asstring)))+'</resultado>'+
                  '<observaciones xsi:type="xsd:string">'+Reemplazar_caracteres(trim(DEVUELVE_OBSERVACIONES(vcodinspe,1)))+'</observaciones>'+
               '</motorVerificacion>'+
               '<lucesVerificacion xsi:type="ns1:resultadoVerificacion"> '+
                  '<resultado xsi:type="ns1:verificacionResultado">'+trim(devuelve_resultado_items(trim(aq.fieldbyname('LUCESVERIFICACION').asstring)))+'</resultado>'+
                  '<observaciones xsi:type="xsd:string">'+Reemplazar_caracteres(trim(DEVUELVE_OBSERVACIONES(vcodinspe,2)))+'</observaciones> '+
               '</lucesVerificacion>'+
               '<direccionVerificacion xsi:type="ns1:resultadoVerificacion"> '+
                   '<resultado xsi:type="ns1:verificacionResultado">'+trim(devuelve_resultado_items(trim(aq.fieldbyname('DIRECCIONVERIFICACION').asstring)))+'</resultado> '+
                  '<observaciones xsi:type="xsd:string">'+Reemplazar_caracteres(trim(DEVUELVE_OBSERVACIONES(vcodinspe,3)))+'</observaciones> '+
               '</direccionVerificacion>'+
               '<frenosVerificacion xsi:type="ns1:resultadoVerificacion"> '+
                   '<resultado xsi:type="ns1:verificacionResultado">'+trim(devuelve_resultado_items(trim(aq.fieldbyname('FRENOSVERIFICACION').asstring)))+'</resultado>'+
                  '<observaciones xsi:type="xsd:string">'+Reemplazar_caracteres(trim(DEVUELVE_OBSERVACIONES(vcodinspe,4)))+'</observaciones>'+
               '</frenosVerificacion>'+
               '<suspensionVerificacion xsi:type="ns1:resultadoVerificacion">'+
                   '<resultado xsi:type="ns1:verificacionResultado">'+trim(devuelve_resultado_items(trim(aq.fieldbyname('SUSPENSIONVERIFICACION').asstring)))+'</resultado>'+
                  '<observaciones xsi:type="xsd:string">'+Reemplazar_caracteres(trim(DEVUELVE_OBSERVACIONES(vcodinspe,5)))+'</observaciones>'+
               '</suspensionVerificacion>'+
               '<chasisVerificacion xsi:type="ns1:resultadoVerificacion"> '+
                   '<resultado xsi:type="ns1:verificacionResultado">'+trim(devuelve_resultado_items(trim(aq.fieldbyname('CHASISVERIFICACION').asstring)))+'</resultado>'+
                  '<observaciones xsi:type="xsd:string">'+Reemplazar_caracteres(trim(DEVUELVE_OBSERVACIONES(vcodinspe,6)))+'</observaciones>'+
               '</chasisVerificacion>'+
               '<llantasVerificacion xsi:type="ns1:resultadoVerificacion">'+
                   '<resultado xsi:type="ns1:verificacionResultado">'+trim(devuelve_resultado_items(trim(aq.fieldbyname('LLANTASVERIFICACION').asstring)))+'</resultado>'+
                  '<observaciones xsi:type="xsd:string">'+Reemplazar_caracteres(trim(DEVUELVE_OBSERVACIONES(vcodinspe,7)))+'</observaciones>'+
               '</llantasVerificacion>'+
               '<neumaticosVerificacion xsi:type="ns1:resultadoVerificacion">'+
                   '<resultado xsi:type="ns1:verificacionResultado">'+trim(devuelve_resultado_items(trim(aq.fieldbyname('NUEMATICOSVERIFICACION').asstring)))+'</resultado>'+
                  '<observaciones xsi:type="xsd:string">'+Reemplazar_caracteres(trim(DEVUELVE_OBSERVACIONES(vcodinspe,8)))+'</observaciones>'+
               '</neumaticosVerificacion>'+
               '<generalVerificacion xsi:type="ns1:resultadoVerificacion">'+
                   '<resultado xsi:type="ns1:verificacionResultado">'+trim(devuelve_resultado_items(trim(aq.fieldbyname('GENERALVERIFICACION').asstring)))+'</resultado>'+
                  '<observaciones xsi:type="xsd:string">'+Reemplazar_caracteres(trim(DEVUELVE_OBSERVACIONES(vcodinspe,9)))+'</observaciones>'+
               '</generalVerificacion>'+
               '<contaminacionVerificacion xsi:type="ns1:resultadoVerificacion">'+
                   '<resultado xsi:type="ns1:verificacionResultado">'+trim(devuelve_resultado_items(trim(aq.fieldbyname('CONTAMINACIONVERIFICACION').asstring)))+'</resultado>'+
                  '<observaciones xsi:type="xsd:string">'+Reemplazar_caracteres(trim(DEVUELVE_OBSERVACIONES(vcodinspe,10)))+'</observaciones>'+
               '</contaminacionVerificacion>'+
               '<seguridadVerificacion xsi:type="ns1:resultadoVerificacion">'+
                  '<resultado xsi:type="ns1:verificacionResultado">'+trim(devuelve_resultado_items(trim(aq.fieldbyname('SEGURIDADVERIFICACION').asstring)))+'</resultado>'+
                  '<observaciones xsi:type="xsd:string">'+Reemplazar_caracteres(trim(DEVUELVE_OBSERVACIONES(vcodinspe,11)))+'</observaciones>'+
               '</seguridadVerificacion>'+
            
             SELF.ARMA_DATOS_MEDICIONES(vturnoid,vcodinspe,vanio)+
                 '</detallesVerificacion> '+
            '<observaciones xsi:type="xsd:string">'+Reemplazar_caracteres(trim(aq.fieldbyname('OBSERVAC').asstring))+'</observaciones> '+
         '</datosVerificacion>';

         end;

      AQ.Next;

      END;

  AQ.Close;
  AQ.FREE;

 ARMA_DATOS_VERIFICACION:=TRIM(CADENA);
END;


FUNCTION Tfrmturnos.ARMA_DATOS_VEHICULOS(vturnoid,vcodinspe,vanio:longint):STRING;
var cadena,formularios,nro_oblea,rz,IDJURI,NUMEROCHASIS:string;
cantidadcertif,codclcon,CODDOCU,CODLOCALIDAD,CODVEHIC:longint;
 aq:tsqlquery;
BEGIN

  aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add('SELECT DVJURISDICCIONID FROM TDATOSTURNO WHERE TURNOID='+INTTOSTR(vturnoid));
   aq.ExecSQL;
   aq.open;
   IDJURI:=TRIM(aq.fields[0].ASSTRING);
   aq.close;
   aq.free ;

   IF TRIM(IDJURI)='0' THEN
      IDJURI:='2';



  aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add(' select CODVEHIC from tinspeccion where codinspe='+inttostr(vcodinspe)+' and ejercici='+inttostr(vanio));
   aq.ExecSQL;
   aq.open;
   CODVEHIC:=aq.fields[0].asinteger;
   aq.close;
   aq.free ;

   aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add(' select PATENTEN, ANIOFABR,NUMMOTOR from TVEHICULOS WHERE CODVEHIC='+inttostr(CODVEHIC));
   aq.ExecSQL;
   aq.open;

   if TRIM(IDJURI)='' then
       idjuri:='2';


       IF (TRIM(Reemplazar_caracteres(TRIM(AQ.FIELDBYNAME('NUMMOTOR').ASSTRING)))='') OR (TRIM(Reemplazar_caracteres(TRIM(AQ.FIELDBYNAME('NUMMOTOR').ASSTRING)))='0')  THEN
           NUMEROCHASIS:='0000000'
       ELSE
       NUMEROCHASIS:=Reemplazar_caracteres(TRIM(AQ.FIELDBYNAME('NUMMOTOR').ASSTRING));






  CADENA:='<datosVehiculo xsi:type="ns1:datosVehiculoInformar">'+
            '<dominio xsi:type="xsd:string">'+Reemplazar_caracteres(TRIM(AQ.FIELDBYNAME('PATENTEN').ASSTRING))+'</dominio>'+
            '<numeroChasis xsi:type="xsd:string">'+NUMEROCHASIS+'</numeroChasis>'+
            '<anio xsi:type="xsd:int">'+Reemplazar_caracteres(TRIM(AQ.FIELDBYNAME('ANIOFABR').ASSTRING))+'</anio>'+
            '<jurisdiccionID xsi:type="xsd:int">'+Reemplazar_caracteres(TRIM(IDJURI))+'</jurisdiccionID>'+
         '</datosVehiculo>';



ARMA_DATOS_VEHICULOS:=TRIM(CADENA);
END;

FUNCTION Tfrmturnos.ARMA_DATOS_TITULAR(vturnoid,vcodinspe,vanio:longint):STRING;
var cadena,formularios,nro_oblea,rz,g,APELLIDO,dfapellido, dfnombre,contactoemail,CONTACTOTELEFONO,nro_cuit:string;
cantidadcertif,codclcon,CODDOCU,CODLOCALIDAD,POSI_PALABRAS:longint;
 aq:tsqlquery;

begin





  aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add('SELECT contactoemail,CONTACTOTELEFONO,titularnombre, titularapellido,titulargenero '+
     '  FROM TDATOSTURNO WHERE turnoid='+inttostr(vturnoid));
   aq.ExecSQL;
   aq.open;
   contactoemail:=trim(aq.fields[0].asstring);
   CONTACTOTELEFONO:=trim(aq.fields[1].asstring);
   dfnombre:=trim(aq.fields[2].asstring);
   dfapellido:=trim(aq.fields[3].asstring);
   aq.close;
   aq.free ;


   aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add(' select CODCLPRO from tinspeccion where codinspe='+inttostr(vcodinspe)+' and ejercici='+inttostr(vanio));
   aq.ExecSQL;
   aq.open;
   codclcon:=aq.fields[0].asinteger;
   aq.close;
   aq.free ;

   aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add('select tipodocu,document,nombre, apellid1,localida, direccio, nrocalle,piso, depto,celular,cuit_cli,CODPOSTA,IDLOCALIDAD , genero from tclientes  '+
              ' where codclien='+inttostr(codclcon));
   aq.ExecSQL;
   aq.open;
   CODLOCALIDAD:=AQ.FIELDBYNAME('IDLOCALIDAD').AsInteger;
    if trim(aq.fieldbyname('tipodocu').asstring)='DNI' THEN
         CODDOCU:=1;

   if trim(aq.fieldbyname('tipodocu').asstring)='CUIT' THEN
         CODDOCU:=9;

   if trim(aq.fieldbyname('tipodocu').asstring)='CI' THEN
         CODDOCU:=8;

   if trim(aq.fieldbyname('tipodocu').asstring)='LC' THEN
         CODDOCU:=3;

   if trim(aq.fieldbyname('tipodocu').asstring)='LE' THEN
         CODDOCU:=2;


    if trim(aq.fieldbyname('genero').asstring)='' then
         g:='M'
         else
         g:=trim(aq.fieldbyname('genero').asstring);





   rz:=trim(aq.fieldbyname('NOMBRE').asstring)+' '+trim(aq.fieldbyname('APELLID1').asstring);

   CADENA:= '<datosTitular xsi:type="ns1:datosPersonales">'+
            '<genero xsi:type="ns1:genero">'+trim(g)+'</genero>'+
            '<tipoDocumento xsi:type="xsd:int">'+INTTOSTR(CODDOCU)+'</tipoDocumento>';
           // '<numeroDocumento xsi:type="xsd:unsignedLong">'+Reemplazar_caracteres(trim(aq.fieldbyname('document').asstring))+'</numeroDocumento>'+
           // '<numeroCuit xsi:type="xsd:unsignedLong">'+Reemplazar_caracteres(trim(aq.fieldbyname('cuit_cli').asstring))+'</numeroCuit>'+
           /// '<numeroCuit xsi:nil="true"/>'+





   IF CODDOCU=9 THEN
   BEGIN
     nro_cuit:=StringReplace(aq.fieldbyname('cuit_cli').asstring, '-', '',[rfReplaceAll, rfIgnoreCase]);

      CADENA:=CADENA +'<numeroDocumento xsi:nil="true"/>'+
            '<numeroCuit xsi:type="xsd:unsignedLong">'+Reemplazar_caracteres(trim(nro_cuit))+'</numeroCuit>';



   END ELSE BEGIN
      CADENA:=CADENA +'<numeroDocumento xsi:type="xsd:unsignedLong">'+Reemplazar_caracteres(trim(aq.fieldbyname('document').asstring))+'</numeroDocumento>'+
           // '<numeroCuit xsi:type="xsd:unsignedLong">'+Reemplazar_caracteres(trim(aq.fieldbyname('cuit_cli').asstring))+'</numeroCuit>'+
            '<numeroCuit xsi:nil="true"/>';



   END;





   IF  trim(aq.fieldbyname('genero').asstring)='PJ'  THEN
     BEGIN
        CADENA:=CADENA +   '<nombre xsi:nil="true"/>';
        CADENA:=CADENA + '<apellido xsi:nil="true"/>';
        CADENA:=CADENA +   '<razonSocial xsi:type="xsd:string">'+Reemplazar_caracteres(trim(rz))+'</razonSocial>'+
         '</datosTitular>';



     END ELSE
     BEGIN

     if (Reemplazar_caracteres(trim(aq.fieldbyname('NOMBRE').asstring))='') or (length(Reemplazar_caracteres(trim(aq.fieldbyname('NOMBRE').asstring))) <= 2) then
        CADENA:=CADENA +   '<nombre xsi:type="xsd:string">'+Reemplazar_caracteres(dfnombre)+'</nombre>'
        else
        CADENA:=CADENA +   '<nombre xsi:type="xsd:string">'+Reemplazar_caracteres(trim(aq.fieldbyname('NOMBRE').asstring))+'</nombre>';


      if (Reemplazar_caracteres(trim(aq.fieldbyname('APELLID1').asstring))='') or (length(Reemplazar_caracteres(trim(aq.fieldbyname('APELLID1').asstring))) <= 2) then
            CADENA:=CADENA + '<apellido xsi:type="xsd:string">'+TRIM(Reemplazar_caracteres(dfapellido))+'</apellido>'
              else
              CADENA:=CADENA + '<apellido xsi:type="xsd:string">'+TRIM(Reemplazar_caracteres(trim(aq.fieldbyname('APELLID1').asstring)))+'</apellido>';




     {
         IF TRIM(Reemplazar_caracteres(trim(aq.fieldbyname('APELLID1').asstring)))<>'' THEN
            CADENA:=CADENA + '<apellido xsi:type="xsd:string">'+TRIM(Reemplazar_caracteres(trim(aq.fieldbyname('APELLID1').asstring)))+'</apellido>'
            ELSE
            CADENA:=CADENA + '<apellido xsi:nil="true"/>';

             }


         //   '<razonSocial xsi:type="xsd:string">'+Reemplazar_caracteres(trim(rz))+'</razonSocial>'+
        CADENA:=CADENA + '<razonSocial xsi:nil="true"/>'+
         '</datosTitular>';


    END;

   aq.close;
   aq.free ;


  ARMA_DATOS_TITULAR:=trim(cadena);



END;



FUNCTION Tfrmturnos.ARMA_DATOS_MEDICIONES(vturnoid,vcodinspe,vanio:longint):STRING;
VAR aq:tsqlquery;
CADENA,OBS,nro_linea,fechaentrada:sTRING;

FRENOESERVICIO,
FRENOEMANO,
DESEQUILIBRIO1E,
DESEQUILIBRIO2E,
AMORTIGUADOR1EIZQ,
AMORTIGUADOR2EIZQ,
AMORTIGUADOR1EDERE,
AMORTIGUADOR2EDERE,
ALINEACIONDERIVA,
COMODO,COALTA,HCMODO,HCALTA,DIESELK:STRING;
BEGIN

FRENOESERVICIO:='0';
FRENOEMANO:='0';
DESEQUILIBRIO1E:='0';
DESEQUILIBRIO2E:='0';
AMORTIGUADOR1EIZQ:='0';
AMORTIGUADOR2EIZQ:='0';
AMORTIGUADOR1EDERE:='0';
AMORTIGUADOR2EDERE:='0';
ALINEACIONDERIVA:='0';
COMODO:='0';
COALTA:='0';
HCMODO:='0';
HCALTA:='0';;
DIESELK:='0';



   {freno servicio}
   aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add('SELECT VALORMEDIDA FROM RESULTADO_INSPECCION WHERE CODPRUEBA=''04010120'' AND CODINSPE='+INTTOSTR(vcodinspe));
   aq.ExecSQL;
   aq.open;
     IF NOT AQ.Eof THEN
        BEGIN
          FRENOESERVICIO:=TRIM(AQ.FIELDBYNAME('VALORMEDIDA').asstring);
        end;

  aq.close;
  aq.free;



  {frenomano}
   aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add('SELECT VALORMEDIDA FROM RESULTADO_INSPECCION WHERE CODPRUEBA=''04010201'' AND CODINSPE='+INTTOSTR(vcodinspe));
   aq.ExecSQL;
   aq.open;
     IF NOT AQ.Eof THEN
        BEGIN
          FRENOEMANO:=TRIM(AQ.FIELDBYNAME('VALORMEDIDA').asstring);
        end;

  aq.close;
  aq.free;



     {desequilibrio 1E}
   aQ:=tsqlquery.create(nil);
   aQ.SQLConnection := MyBD;
   aQ.SQL.Add('SELECT VALORMEDIDA FROM RESULTADO_INSPECCION WHERE CODPRUEBA=''04010101'' AND CODINSPE='+INTTOSTR(vcodinspe));
   aq.ExecSQL;
   aq.open;
     IF NOT AQ.Eof THEN
        BEGIN
          DESEQUILIBRIO1E:=TRIM(AQ.FIELDBYNAME('VALORMEDIDA').asstring);
        end;

  aq.close;
  aq.free;  



      {desequilibrio 2E}
   aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add('SELECT VALORMEDIDA FROM RESULTADO_INSPECCION WHERE CODPRUEBA=''04010102'' AND CODINSPE='+INTTOSTR(vcodinspe));
   aq.ExecSQL;
   aq.open;
     IF NOT AQ.Eof THEN
        BEGIN
          DESEQUILIBRIO2E:=TRIM(AQ.FIELDBYNAME('VALORMEDIDA').asstring);
        end;

  aq.close;
  aq.free;                                                                                                                                                  





 {AMORTIGUADOR 1 E IZQ}
  aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add('SELECT VALORMEDIDA FROM RESULTADO_INSPECCION WHERE CODPRUEBA=''0503'' AND CODINSPE='+INTTOSTR(vcodinspe));
   aq.ExecSQL;
   aq.open;
     IF NOT AQ.Eof THEN
        BEGIN
          AMORTIGUADOR1EIZQ:=TRIM(AQ.FIELDBYNAME('VALORMEDIDA').asstring);
        end;

  aq.close;
  aq.free;




{AMORTIGUADOR 2 E IZQ}
   aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add('SELECT VALORMEDIDA FROM RESULTADO_INSPECCION WHERE CODPRUEBA=''0506'' AND CODINSPE='+INTTOSTR(vcodinspe));
   aq.ExecSQL;
   aq.open;
     IF NOT AQ.Eof THEN
        BEGIN
          AMORTIGUADOR2EIZQ:=TRIM(AQ.FIELDBYNAME('VALORMEDIDA').asstring);
        end;

  aq.close;
  aq.free;




 {AMORTIGUADOR 1 E DERE}
     aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add('SELECT VALORMEDIDA FROM RESULTADO_INSPECCION WHERE CODPRUEBA=''0502'' AND CODINSPE='+INTTOSTR(vcodinspe));
   aq.ExecSQL;
   aq.open;
     IF NOT AQ.Eof THEN
        BEGIN
          AMORTIGUADOR1EDERE:=TRIM(AQ.FIELDBYNAME('VALORMEDIDA').asstring);
        end;

  aq.close;
  aq.free;




 {AMORTIGUADOR 2 E DERE}
     aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add('SELECT VALORMEDIDA FROM RESULTADO_INSPECCION WHERE CODPRUEBA=''0505'' AND CODINSPE='+INTTOSTR(vcodinspe));
   aq.ExecSQL;
   aq.open;
     IF NOT AQ.Eof THEN
        BEGIN
          AMORTIGUADOR2EDERE:=TRIM(AQ.FIELDBYNAME('VALORMEDIDA').asstring);
        end;

  aq.close;
  aq.free;





 {ALINEACIONDERIVA}
     aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add('SELECT VALORMEDIDA FROM RESULTADO_INSPECCION WHERE CODPRUEBA=''0310'' AND CODINSPE='+INTTOSTR(vcodinspe));
   aq.ExecSQL;
   aq.open;
     IF NOT AQ.Eof THEN
        BEGIN
          ALINEACIONDERIVA:=TRIM(AQ.FIELDBYNAME('VALORMEDIDA').asstring);
        end;

  aq.close;
  aq.free;


{co modo}
     aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add('SELECT VALORMEDIDA FROM RESULTADO_INSPECCION WHERE CODPRUEBA=''100101'' AND CODINSPE='+INTTOSTR(vcodinspe));
   aq.ExecSQL;
   aq.open;
     IF NOT AQ.Eof THEN
        BEGIN
          COMODO:=TRIM(AQ.FIELDBYNAME('VALORMEDIDA').asstring);
        end;

  aq.close;
  aq.free;

 {co ALTA}
     aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add('SELECT VALORMEDIDA FROM RESULTADO_INSPECCION WHERE CODPRUEBA=''100110'' AND CODINSPE='+INTTOSTR(vcodinspe));
   aq.ExecSQL;
   aq.open;
     IF NOT AQ.Eof THEN
        BEGIN
          COALTA:=TRIM(AQ.FIELDBYNAME('VALORMEDIDA').asstring);
        end;

  aq.close;
  aq.free;



 {HC ALTA}
     aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add('SELECT VALORMEDIDA FROM RESULTADO_INSPECCION WHERE CODPRUEBA=''100108'' AND CODINSPE='+INTTOSTR(vcodinspe));
   aq.ExecSQL;
   aq.open;
     IF NOT AQ.Eof THEN
        BEGIN
          HCALTA:=TRIM(AQ.FIELDBYNAME('VALORMEDIDA').asstring);
        end;

  aq.close;
   aq.free;

  {HC MODO}
     aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add('SELECT VALORMEDIDA FROM RESULTADO_INSPECCION WHERE CODPRUEBA=''100102'' AND CODINSPE='+INTTOSTR(vcodinspe));
   aq.ExecSQL;
   aq.open;
     IF NOT AQ.Eof THEN
        BEGIN
          HCMODO:=TRIM(AQ.FIELDBYNAME('VALORMEDIDA').asstring);
        end;

  aq.close;
  aq.free;

{K}
     aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add('SELECT VALORMEDIDA FROM RESULTADO_INSPECCION WHERE CODPRUEBA=''100103'' AND CODINSPE='+INTTOSTR(vcodinspe));
   aq.ExecSQL;
   aq.open;
     IF NOT AQ.Eof THEN
        BEGIN
          DIESELK:=TRIM(AQ.FIELDBYNAME('VALORMEDIDA').asstring);
        end;

  aq.close;
  aq.free;

 

  CADENA:='<medicionesVerificacion xsi:type="ns1:medicionesVerificacion">'+
                ' <frenosEficaciaServicio xsi:type="xsd:float">'+StringReplace(FRENOESERVICIO, ',', '.',[rfReplaceAll, rfIgnoreCase])+'</frenosEficaciaServicio>'+
                ' <frenosEficaciaMano xsi:type="xsd:float">'+StringReplace(FRENOEMANO, ',', '.',[rfReplaceAll, rfIgnoreCase])+'</frenosEficaciaMano>'+
                ' <frenosDesequilibrio1Eje xsi:type="xsd:float">'+StringReplace(DESEQUILIBRIO1E, ',', '.',[rfReplaceAll, rfIgnoreCase])+'</frenosDesequilibrio1Eje>'+
                ' <frenosDesequilibrio2Eje xsi:type="xsd:float">'+StringReplace(DESEQUILIBRIO2E, ',', '.',[rfReplaceAll, rfIgnoreCase])+'</frenosDesequilibrio2Eje>'+
                ' <amortiguadores1EjeIzq xsi:type="xsd:float">'+StringReplace(AMORTIGUADOR1EIZQ, ',', '.',[rfReplaceAll, rfIgnoreCase])+'</amortiguadores1EjeIzq>'+
                ' <amortiguadores2EjeIzq xsi:type="xsd:float">'+StringReplace(AMORTIGUADOR2EIZQ, ',', '.',[rfReplaceAll, rfIgnoreCase])+'</amortiguadores2EjeIzq>'+
                ' <amortiguadores1EjeDer xsi:type="xsd:float">'+StringReplace(AMORTIGUADOR1EDERE, ',', '.',[rfReplaceAll, rfIgnoreCase])+'</amortiguadores1EjeDer>'+
                ' <amortiguadores2EjeDer xsi:type="xsd:float">'+StringReplace(AMORTIGUADOR2EDERE, ',', '.',[rfReplaceAll, rfIgnoreCase])+'</amortiguadores2EjeDer>'+
                ' <alineacionDeriva xsi:type="xsd:float">'+StringReplace(ALINEACIONDERIVA, ',', '.',[rfReplaceAll, rfIgnoreCase])+'</alineacionDeriva>'+
                ' <contaminacionCOBaja xsi:type="xsd:float">'+StringReplace(COMODO, ',', '.',[rfReplaceAll, rfIgnoreCase])+'</contaminacionCOBaja>'+
                ' <contaminacionPpmHcBaja xsi:type="xsd:float">'+StringReplace(HCMODO, ',', '.',[rfReplaceAll, rfIgnoreCase])+'</contaminacionPpmHcBaja>'+
                ' <contaminacionCOAlta xsi:type="xsd:float">'+StringReplace(COALTA, ',', '.',[rfReplaceAll, rfIgnoreCase])+'</contaminacionCOAlta>'+
                ' <contaminacionPpmHcAlta xsi:type="xsd:float">'+StringReplace(HCALTA, ',', '.',[rfReplaceAll, rfIgnoreCase])+'</contaminacionPpmHcAlta>'+
                ' <contaminacionDieselK xsi:type="xsd:float">'+StringReplace(DIESELK, ',', '.',[rfReplaceAll, rfIgnoreCase])+'</contaminacionDieselK>'+
            '</medicionesVerificacion>';

 ARMA_DATOS_MEDICIONES:=TRIM(CADENA);
END;


 Function Tfrmturnos.Informar_Inspeccion(vturnoid,vcodinspe,vanio:longint):boolean;
var xml,cola,obs:string;
aq:tsqlquery;

err, str,xmldatos: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
     TESTING:boolean;
   CANTIDAD:LONGINT;
  defWSDL:string;
  defURL :string;
  defSvc,fechaturno,nro_oblea:string;
  defPrt,fecha,TAG:string;
  cantidadcertif:longint;
  formularios,archivo,datos:string;
begin
Memo1.Clear;
Memo2.Clear;
try

xml:='<?xml version="1.0" encoding="ISO-8859-1"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" '+
     'xmlns:ns1="urn:suvtv" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '+
      'SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
     '<SOAP-ENV:Body>'+
      '<ns1:informarVerificacion>'+
      '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(SELF.USUARIO)+'</usuarioID>'+
      '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(SELF.ingresoID_Abrir)+'</ingresoID>'+
      '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(SELF.PLANTA)+'</plantaID>'+
      '<turnoID xsi:type="xsd:unsignedLong">'+inttostr(vTURNOID)+'</turnoID>';


    COLA:='</ns1:informarVerificacion>'+
          '</SOAP-ENV:Body>'+
          '</SOAP-ENV:Envelope>';


ARCHIVO:=XML+arma_formularios(vturnoid,vcodinspe,vanio)+arma_tramite_y_oblea(vturnoid,vcodinspe,vanio)+
         arma_datos_presentante(vturnoid,vcodinspe,vanio)+ARMA_DATOS_VERIFICACION(vturnoid,vcodinspe,vanio)+
         ARMA_DATOS_TITULAR(vturnoid,vcodinspe,vanio)+
         ARMA_DATOS_VEHICULOS(vturnoid,vcodinspe,vanio)+COLA;



strings := TStringList.Create;
strings.Text := ARCHIVO;




request := TStringStream.Create(strings.GetText);



response := TStringStream.Create('');

Memo2.Clear;
request.Position := 0;
Memo2.Lines.LoadFromStream(request);
Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'Envioinspeccion'+inttostr(vcodinspe)+'.xml');
Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'Envioinspeccion'+inttostr(vcodinspe)+'.txt');

recieveID :=HTTPRIO1.HTTPWebNode.Send(request);           //Request

HTTPRIO1.HTTPWebNode.Receive(recieveID,response,false);    //Response

Memo2.Clear;
response.Position := 0;
Memo2.Lines.LoadFromStream(response);


Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'RecibioCodinspe'+inttostr(vcodinspe)+'.xml');
strings.Free;
request.Free;
response.Free ;
Informar_Inspeccion:=true;

except
  Informar_Inspeccion:=false;
end;

end;


procedure Tfrmturnos.BitBtn2Click(Sender: TObject);
begin

Inicializa;
ControlServidor;
if (disponibilidad_servidor='true') AND (self.respuestaidservidor=1) THEN
begin

  //ver_respuestamensajeservidor);
  APPLICATION.ProcessMessages;
  Abrir_Seccion;
    if self.respuestaid_Abrir=1 then
     begin
       //self.respuestamensaje_Abrir;

          if informar_ausentes=true then
                begin
                 if fileexists(ExtractFilePath(Application.ExeName) +'informarausentes.xml') then
                      begin
                       if generar_archivo('informarausentes')=true then
                         begin

                         end;

                     end;



        Cerrar_seccion;

        end else
         begin
          //error al abrir
         end;

end
else
begin
//error de servidor
//ver_respuestamensajeservidor);
end;



end;
 cargar_turnos(datetostr(date));

end;


function Tfrmturnos.leer_respuesta_reverificacion(archivo:string;IDTURNO:LONGINT;crea:boolean;men:string):boolean;
var archi:textfile;
linea,codmensaje, respuesta,INFORME:string;
posi,estadoturno:longint;  aq:tsqlquery;
   updatesql,insertasql:TSQLQuery;
       r:string;

begin
r:='R';
assignfile(archi,archivo);
reset(archi);
while not eof(archi) do
begin
 readln(archi,linea);

 posi:=pos('</respuestaID',trim(linea));
  if posi > 0 then
     begin
       codmensaje:=trim(copy(trim(linea),0,posi-1));

     end;

 posi:=pos('</respuestaMensaje',trim(linea));
  if posi > 0 then
     begin
       respuesta:=trim(copy(trim(linea),0,posi-1));

     end;

  posi:=pos('</turnoID',trim(linea));
  if posi > 0 then
     begin
       codturnoreve:=strtoint(trim(copy(trim(linea),0,posi-1)));

     end;

     posi:=pos('</estadoID',trim(linea));
  if posi > 0 then
     begin
       estadoturno:=strtoint(trim(copy(trim(linea),0,posi-1)));

     end;


end;
closefile(archi);
     respuesta:=codmensaje+' '+respuesta;

  
    IF TRIM(codmensaje)<>'1' THEN
     codturnoreve:=IDTURNO *-1;



  
   if crea=true then
   begin
         {----}
    insertasql:=TSQLQuery.Create(Self);
   insertasql.SQLConnection:=mybd;
  insertasql.Close;
  insertasql.SQL.Clear;

   insertasql.SQL.Add(' insert into tdatosturno (TURNOID, '+
'TIPOTURNO, '+
'FECHATURNO, '+
'HORATURNO , '+
'FECHAREGISTRO, '+
'TITULARGENERO , '+
'TTULARTIPODOCUMENTO, '+
'TITULARNRODOCUMENTO, '+
'TITULARNOMBRE  , '+
'TITULARAPELLIDO ,  '+
'CONTACTOGENERO ,  '+
'CONTACTOTIPODOCUMENTO , '+
'CONTACTONRODOCUMENTO , '+
'CONTACTONOMBRE , '+
'CONTACTOAPELLIDO, '+
'CONTACTOTELEFONO, '+
'CONTACTOEMAIL ,  '+
'CONTACTOFECHANAC,  '+
'DVDOMINO,  '+
'DVMARCAID, '+
'DVMARCA,   '+
'DVTIPOID,  '+
'DVTIPO ,   '+
'DVMODELOID, '+
'DVMODELO,  '+
'DVANIO ,    '+
'DVJURISDICCIONID , '+
'DVJURISDICCION  , '+
'DFGENERO   ,  '+
'DFTIPODOCUMENTO , '+
'DFNRODOCUMENTO  , '+
'DFNOMBRE  ,  '+
'DFAPELLIDO , '+
'DFCALLE  ,  '+
'DFNUMEROCALLE,'+
'DFPISO  ,   '+
'DFDEPARTAMENTO ,'+
'DFLOCALIDAD  ,'+
'DFPROVINCIAID   ,  '+
'DFPROVINCIA  , '+
'DFCODIGOPOSTAL , '+
'DFIVA    ,  '+
'DFIIBB   ,  '+
'PAGOSID   ,'+
'PAGOSGETWAY , '+
'PAGOSENTIDADID , '+
'PAGOSENTIDAD , '+
'PAGOSFECHA  ,  '+
'PAGOSIMPORTE , '+
'PAGOSESTADOLIQUIDACION, '+
'CODVEHIC  ,  '+
'CODCLIEN   ,'+
'AUSENTE     , '+
'FACTURADO   , '+
'REVISO   ,  '+
'DVNUMERO  , '+
'CODINSPE ,   '+
'ANIO    ,  '+
'IMPORTEVERIFICACION , '+
'IMPORTEOBLEA ,  '+
'CAE  ,   '+
'FECHAVENCE  ,  '+
'RESPUESTAAFIP ,'+
'APROBADA  ,   '+
'NRO_COMPROBANTE  , '+
'INFORMADOWS   , '+
'MOTIVO    ,  '+
'CODCLIENTEPRESENTANTE , '+
'TIPOCOMPROBANTEAFIP  , '+
'ENVIOMAIL  ,  '+
'ERROR_MAIL  , '+
'CUITTITULAR  , '+
'CUITCONTACTO  ,'+
'CUITFACTURA    , '+
'CONTACTORAZONSOCIAL , '+
'TITULARRAZONSOCIAL ,  '+
'FACTURARAZONSOCIAL ,  '+
'PAGOIDVERIFICACION  , '+
'ESTADOACREDITACIONVERIFICACION  , '+
'PAGOGESTWAYIDVERIFICACION  , '+
'PAGOIDOBLEA ,               '+
'ESTADOACREDITACIONOBLEA   , '+
'VALTITULAR   ,       '+
'VALCHASIS   ,       '+
'DATOSVEHICULOMTM ,  '+
'MARCAIDVAL   ,   '+
'MARCAVAL   ,   '+
'TIPOIDVAL  , '+
'TIPOVAL    , '+
'MODELOIDVAL  ,  '+
'MODELOVAL   ,  '+
'MARCACHASISVAL ,  '+
'NUMEROCHASISVAL , '+
'MTMVAL ,'+
'ARCHIVOENVIADO , '+
'MODO   , '+
'FECHALTA ,'+
'PLANTA  , '+
'TIPOINSPE ) '+
'select TURNOID, '+
'TIPOTURNO,  '+
'FECHATURNO, '+
'HORATURNO , '+
'FECHAREGISTRO, '+
'TITULARGENERO , '+
'TTULARTIPODOCUMENTO,  '+
'TITULARNRODOCUMENTO, '+
'TITULARNOMBRE  , '+
'TITULARAPELLIDO , '+
'CONTACTOGENERO ,  '+
'CONTACTOTIPODOCUMENTO , '+
'CONTACTONRODOCUMENTO , '+
'CONTACTONOMBRE ,   '+
'CONTACTOAPELLIDO, '+
'CONTACTOTELEFONO, '+
'CONTACTOEMAIL , '+
'CONTACTOFECHANAC, '+
'DVDOMINO, '+
'DVMARCAID, '+
'DVMARCA, '+
'DVTIPOID, '+
'DVTIPO ,  '+
'DVMODELOID, '+
'DVMODELO, '+
'DVANIO , '+
'DVJURISDICCIONID , '+
'DVJURISDICCION  , '+
'DFGENERO   ,  '+
'DFTIPODOCUMENTO , '+
'DFNRODOCUMENTO  , '+
'DFNOMBRE  ,  '+
'DFAPELLIDO , '+
'DFCALLE  ,   '+
'DFNUMEROCALLE, '+
'DFPISO  ,     '+
'DFDEPARTAMENTO ,'+
'DFLOCALIDAD  , '+
'DFPROVINCIAID   , '+
'DFPROVINCIA  ,  '+
'DFCODIGOPOSTAL , '+
'DFIVA    ,  '+
'DFIIBB   , '+
'PAGOSID   , '+
'PAGOSGETWAY ,'+
'PAGOSENTIDADID ,'+
'PAGOSENTIDAD ,  '+
'PAGOSFECHA  ,  '+
'PAGOSIMPORTE , '+
'PAGOSESTADOLIQUIDACION , '+
'CODVEHIC  ,   '+
'CODCLIEN   ,  '+
'AUSENTE     , '+  
'FACTURADO   , '+
'REVISO   ,   '+
'DVNUMERO  , '+
'CODINSPE ,  '+
'ANIO    ,  '+
'IMPORTEVERIFICACION , '+
'IMPORTEOBLEA , '+
'CAE  ,     '+
'FECHAVENCE  ,  '+
'RESPUESTAAFIP , '+
'APROBADA  ,  '+
'NRO_COMPROBANTE  ,'+
'INFORMADOWS   , '+
'MOTIVO    ,  '+
'CODCLIENTEPRESENTANTE ,'+
'TIPOCOMPROBANTEAFIP  , '+
'ENVIOMAIL  ,    '+
'ERROR_MAIL  ,  '+
'CUITTITULAR  , '+
'CUITCONTACTO  , '+
'CUITFACTURA    ,  '+
'CONTACTORAZONSOCIAL , '+
'TITULARRAZONSOCIAL ,  '+
'FACTURARAZONSOCIAL , '+
'PAGOIDVERIFICACION  , '+
'ESTADOACREDITACIONVERIFICACION  , '+
'PAGOGESTWAYIDVERIFICACION  , '+
'PAGOIDOBLEA ,   '+
'ESTADOACREDITACIONOBLEA   ,'+
'VALTITULAR   , '+
'VALCHASIS   ,  '+
'DATOSVEHICULOMTM , '+
'MARCAIDVAL   ,  '+
'MARCAVAL   ,  '+
'TIPOIDVAL  , '+
'TIPOVAL    , '+
'MODELOIDVAL  ,'+
'MODELOVAL   , '+
'MARCACHASISVAL , '+
'NUMEROCHASISVAL , '+
'MTMVAL ,         '+
'ARCHIVOENVIADO , '+
'MODO   ,     '+
'FECHALTA ,  '+
'PLANTA  , '+#39+trim(r)+#39+'  from tdatosturno where turnoid='+inttostr(IDTURNO));
  insertasql.ExecSQL ;


  end;




 updatesql:=TSQLQuery.Create(Self);
  updatesql.SQLConnection:=mybd;
  updatesql.Close;
  updatesql.SQL.Clear;

   updatesql.SQL.Add(' update tdatosturno set turnoid='+inttostr(codturnoreve)+' where  turnoid='+inttostr(IDTURNO)+' and tipoinspe=''R'' ');

   updatesql.ExecSQL ;




       {-------}

   {  end
    ELSE
    begin
    INFORME:='NO';
       respuesta:=respuesta+'. No se pudo obtener el turno para reverificación.';
    end; }

  if trim(men)='S' then
   begin
  Application.MessageBox( PCHAR('RESPUESTA DE SUIVTV: '+respuesta), 'Atención',
  MB_ICONINFORMATION );
end;

end;



function Tfrmturnos.leer_respuesta_ausentes(archivo:string):boolean;
var archi:textfile;
linea,codmensaje, respuesta,INFORME,DESCESTADO:string;
posi:longint;  aq:tsqlquery;
fecha:string;
begin
assignfile(archi,archivo);
reset(archi);

while not eof(archi) do
begin
 readln(archi,linea);

 posi:=pos('</respuestaID',trim(linea));
  if posi > 0 then
     begin
       codmensaje:=trim(copy(trim(linea),0,posi-1));

     end;

 posi:=pos('</respuestaMensaje',trim(linea));
  if posi > 0 then
     begin
       respuesta:=trim(copy(trim(linea),0,posi-1));
        break;
     end;

     


end;
closefile(archi);
     respuesta:=codmensaje+' '+respuesta;

  
   IF TRIM(codmensaje)='1' THEN
    begin
     INFORME:='SI';
      fecha:=datetostr(date);
     DESCESTADO:='AUSENTE';

     aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add('UPDATE TDATOSTURNO SET INFORMADOWS='+#39+TRIM(INFORME)+#39+', ESTADOID=4, ESTADODESC='+#39+TRIM(DESCESTADO)+#39+' WHERE trim(AUSENTE)=''S'' and trim(reviso)=''N'' and trim(modo)=''P''  AND FECHATURNO=TO_DATE('+#39+trim(fecha)+#39+',''DD/MM/YYYY'') and estadoid in (1,7)');
   aq.ExecSQL;
   AQ.Close;
   AQ.FREE;



  { Application.MessageBox( PCHAR('RESPUESTA DE SUVTV: '+respuesta), 'Atención',
  MB_ICONINFORMATION ); }

    end ;






end;


function Tfrmturnos.leer_respuesta_ausentes_POR_IDTUNRO(archivo:string;IDTURNO:LONGINT):boolean;
var archi:textfile;
linea,codmensaje, respuesta,INFORME,DESCESTADO:string;
posi:longint;  aq:tsqlquery;
fecha:string;
begin
assignfile(archi,archivo);
reset(archi);

while not eof(archi) do
begin
 readln(archi,linea);

 posi:=pos('</respuestaID',trim(linea));
  if posi > 0 then
     begin
       codmensaje:=trim(copy(trim(linea),0,posi-1));

     end;

 posi:=pos('</respuestaMensaje',trim(linea));
  if posi > 0 then
     begin
       respuesta:=trim(copy(trim(linea),0,posi-1));
        break;
     end;

     


end;
closefile(archi);
     respuesta:=codmensaje+' '+respuesta;

  
   IF TRIM(codmensaje)='1' THEN
    begin
     INFORME:='SI';
      fecha:=datetostr(date);
     DESCESTADO:='AUSENTE';

     aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aQ.SQL.Add('UPDATE TDATOSTURNO SET INFORMADOWS='+#39+TRIM(INFORME)+#39+', ESTADOID=4, ESTADODESC='+#39+TRIM(DESCESTADO)+#39+' WHERE TURNOID='+INTTOSTR(IDTURNO));
   aq.ExecSQL;
   AQ.Close;
   AQ.FREE;





    end ;



    Application.MessageBox( PCHAR('RESPUESTA DE SUVTV: '+respuesta), 'Atención',
  MB_ICONINFORMATION );


end;




{
function Tfrmturnos.leer_respuesta_reverificacion(archivo:string;IDTURNO:LONGINT;crea:boolean;men:string):boolean;
var archi:textfile;
linea,codmensaje, respuesta,INFORME:string;
posi,estadoturno:longint;  aq:tsqlquery;
   updatesql,insertasql:TSQLQuery;
       r:string;

begin
r:='R';
assignfile(archi,archivo);
reset(archi);
while not eof(archi) do
begin
 readln(archi,linea);

 posi:=pos('</respuestaID',trim(linea));
  if posi > 0 then
     begin
       codmensaje:=trim(copy(trim(linea),0,posi-1));

     end;

 posi:=pos('</respuestaMensaje',trim(linea));
  if posi > 0 then
     begin
       respuesta:=trim(copy(trim(linea),0,posi-1));

     end;

  posi:=pos('</turnoID',trim(linea));
  if posi > 0 then
     begin
       codturnoreve:=strtoint(trim(copy(trim(linea),0,posi-1)));

     end;

     posi:=pos('</estadoID',trim(linea));
  if posi > 0 then
     begin
       estadoturno:=strtoint(trim(copy(trim(linea),0,posi-1)));

     end;


end;
closefile(archi);
     respuesta:=codmensaje+' '+respuesta;

  
    IF TRIM(codmensaje)<>'1' THEN
     codturnoreve:=IDTURNO *-1;



  
   if crea=true then
   begin

    insertasql:=TSQLQuery.Create(Self);
   insertasql.SQLConnection:=mybd;
  insertasql.Close;
  insertasql.SQL.Clear;

   insertasql.SQL.Add(' insert into tdatosturno (TURNOID, '+
'TIPOTURNO, '+
'FECHATURNO, '+
'HORATURNO , '+
'FECHAREGISTRO, '+
'TITULARGENERO , '+
'TTULARTIPODOCUMENTO, '+
'TITULARNRODOCUMENTO, '+
'TITULARNOMBRE  , '+
'TITULARAPELLIDO ,  '+
'CONTACTOGENERO ,  '+
'CONTACTOTIPODOCUMENTO , '+
'CONTACTONRODOCUMENTO , '+
'CONTACTONOMBRE , '+
'CONTACTOAPELLIDO, '+
'CONTACTOTELEFONO, '+
'CONTACTOEMAIL ,  '+
'CONTACTOFECHANAC,  '+
'DVDOMINO,  '+
'DVMARCAID, '+
'DVMARCA,   '+
'DVTIPOID,  '+
'DVTIPO ,   '+
'DVMODELOID, '+
'DVMODELO,  '+
'DVANIO ,    '+
'DVJURISDICCIONID , '+
'DVJURISDICCION  , '+
'DFGENERO   ,  '+
'DFTIPODOCUMENTO , '+
'DFNRODOCUMENTO  , '+
'DFNOMBRE  ,  '+
'DFAPELLIDO , '+
'DFCALLE  ,  '+
'DFNUMEROCALLE,'+
'DFPISO  ,   '+
'DFDEPARTAMENTO ,'+
'DFLOCALIDAD  ,'+
'DFPROVINCIAID   ,  '+
'DFPROVINCIA  , '+
'DFCODIGOPOSTAL , '+
'DFIVA    ,  '+
'DFIIBB   ,  '+
'PAGOSID   ,'+
'PAGOSGETWAY , '+
'PAGOSENTIDADID , '+
'PAGOSENTIDAD , '+
'PAGOSFECHA  ,  '+
'PAGOSIMPORTE , '+
'PAGOSESTADOLIQUIDACION, '+
'CODVEHIC  ,  '+
'CODCLIEN   ,'+
'AUSENTE     , '+
'FACTURADO   , '+
'REVISO   ,  '+
'DVNUMERO  , '+
'CODINSPE ,   '+
'ANIO    ,  '+
'IMPORTEVERIFICACION , '+
'IMPORTEOBLEA ,  '+
'CAE  ,   '+
'FECHAVENCE  ,  '+
'RESPUESTAAFIP ,'+
'APROBADA  ,   '+
'NRO_COMPROBANTE  , '+
'INFORMADOWS   , '+
'MOTIVO    ,  '+
'CODCLIENTEPRESENTANTE , '+
'TIPOCOMPROBANTEAFIP  , '+
'ENVIOMAIL  ,  '+
'ERROR_MAIL  , '+
'CUITTITULAR  , '+
'CUITCONTACTO  ,'+
'CUITFACTURA    , '+
'CONTACTORAZONSOCIAL , '+
'TITULARRAZONSOCIAL ,  '+
'FACTURARAZONSOCIAL ,  '+
'PAGOIDVERIFICACION  , '+
'ESTADOACREDITACIONVERIFICACION  , '+
'PAGOGESTWAYIDVERIFICACION  , '+
'PAGOIDOBLEA ,               '+
'ESTADOACREDITACIONOBLEA   , '+
'VALTITULAR   ,       '+
'VALCHASIS   ,       '+
'DATOSVEHICULOMTM ,  '+
'MARCAIDVAL   ,   '+
'MARCAVAL   ,   '+
'TIPOIDVAL  , '+
'TIPOVAL    , '+
'MODELOIDVAL  ,  '+
'MODELOVAL   ,  '+
'MARCACHASISVAL ,  '+
'NUMEROCHASISVAL , '+
'MTMVAL ,'+
'ARCHIVOENVIADO , '+
'MODO   , '+
'FECHALTA ,'+
'PLANTA  , '+
'TIPOINSPE ) '+
'select TURNOID, '+
'TIPOTURNO,  '+
'FECHATURNO, '+
'HORATURNO , '+
'FECHAREGISTRO, '+
'TITULARGENERO , '+
'TTULARTIPODOCUMENTO,  '+
'TITULARNRODOCUMENTO, '+
'TITULARNOMBRE  , '+
'TITULARAPELLIDO , '+
'CONTACTOGENERO ,  '+
'CONTACTOTIPODOCUMENTO , '+
'CONTACTONRODOCUMENTO , '+
'CONTACTONOMBRE ,   '+
'CONTACTOAPELLIDO, '+
'CONTACTOTELEFONO, '+
'CONTACTOEMAIL , '+
'CONTACTOFECHANAC, '+
'DVDOMINO, '+
'DVMARCAID, '+
'DVMARCA, '+
'DVTIPOID, '+
'DVTIPO ,  '+
'DVMODELOID, '+
'DVMODELO, '+
'DVANIO , '+
'DVJURISDICCIONID , '+
'DVJURISDICCION  , '+
'DFGENERO   ,  '+
'DFTIPODOCUMENTO , '+
'DFNRODOCUMENTO  , '+
'DFNOMBRE  ,  '+
'DFAPELLIDO , '+
'DFCALLE  ,   '+
'DFNUMEROCALLE, '+
'DFPISO  ,     '+
'DFDEPARTAMENTO ,'+
'DFLOCALIDAD  , '+
'DFPROVINCIAID   , '+
'DFPROVINCIA  ,  '+
'DFCODIGOPOSTAL , '+
'DFIVA    ,  '+
'DFIIBB   , '+
'PAGOSID   , '+
'PAGOSGETWAY ,'+
'PAGOSENTIDADID ,'+
'PAGOSENTIDAD ,  '+
'PAGOSFECHA  ,  '+
'PAGOSIMPORTE , '+
'PAGOSESTADOLIQUIDACION , '+
'CODVEHIC  ,   '+
'CODCLIEN   ,  '+
'AUSENTE     , '+  
'FACTURADO   , '+
'REVISO   ,   '+
'DVNUMERO  , '+
'CODINSPE ,  '+
'ANIO    ,  '+
'IMPORTEVERIFICACION , '+
'IMPORTEOBLEA , '+
'CAE  ,     '+
'FECHAVENCE  ,  '+
'RESPUESTAAFIP , '+
'APROBADA  ,  '+
'NRO_COMPROBANTE  ,'+
'INFORMADOWS   , '+
'MOTIVO    ,  '+
'CODCLIENTEPRESENTANTE ,'+
'TIPOCOMPROBANTEAFIP  , '+
'ENVIOMAIL  ,    '+
'ERROR_MAIL  ,  '+
'CUITTITULAR  , '+
'CUITCONTACTO  , '+
'CUITFACTURA    ,  '+
'CONTACTORAZONSOCIAL , '+
'TITULARRAZONSOCIAL ,  '+
'FACTURARAZONSOCIAL , '+
'PAGOIDVERIFICACION  , '+
'ESTADOACREDITACIONVERIFICACION  , '+
'PAGOGESTWAYIDVERIFICACION  , '+
'PAGOIDOBLEA ,   '+
'ESTADOACREDITACIONOBLEA   ,'+
'VALTITULAR   , '+
'VALCHASIS   ,  '+
'DATOSVEHICULOMTM , '+
'MARCAIDVAL   ,  '+
'MARCAVAL   ,  '+
'TIPOIDVAL  , '+
'TIPOVAL    , '+
'MODELOIDVAL  ,'+
'MODELOVAL   , '+
'MARCACHASISVAL , '+
'NUMEROCHASISVAL , '+
'MTMVAL ,         '+
'ARCHIVOENVIADO , '+
'MODO   ,     '+
'FECHALTA ,  '+
'PLANTA  , '+#39+trim(r)+#39+'  from tdatosturno where turnoid='+inttostr(IDTURNO));
  insertasql.ExecSQL ;


  end;




 updatesql:=TSQLQuery.Create(Self);
  updatesql.SQLConnection:=mybd;
  updatesql.Close;
  updatesql.SQL.Clear;

   updatesql.SQL.Add(' update tdatosturno set turnoid='+inttostr(codturnoreve)+' where  turnoid='+inttostr(IDTURNO)+' and tipoinspe=''R'' ');

   updatesql.ExecSQL ;





  if trim(men)='S' then
   begin
  Application.MessageBox( PCHAR('RESPUESTA DE SUIVTV: '+respuesta), 'Atención',
  MB_ICONINFORMATION );
end;

end;  }



function Tfrmturnos.leer_respuesta_informar_verificacion(archivo:string;IDTURNO:LONGINT;men:string):boolean;
var archi:textfile;  ESTADOID:LONGINT;
linea,codmensaje, respuesta,INFORME:string;
posi:longint;  aq:tsqlquery;
begin
assignfile(archi,archivo);
reset(archi);
while not eof(archi) do
begin
 readln(archi,linea);

 posi:=pos('</respuestaID',trim(linea));
  if posi > 0 then
     begin
       codmensaje:=trim(copy(trim(linea),0,posi-1));

     end;

 posi:=pos('</respuestaMensaje',trim(linea));
  if posi > 0 then
     begin
       respuesta:=trim(copy(trim(linea),0,posi-1));

     end;




end;
closefile(archi);
     respuesta:=codmensaje+' '+respuesta;


    IF TRIM(codmensaje)='1' THEN
    BEGIN
    INFORME:='SI';
    ESTADOID:=DEVUELVE_ESTADO_TURNO(IDTURNO);
    END
    ELSE
    begin
    INFORME:='NO';





    FMainSag98.Label8.Caption:=respuesta;
    
       respuesta:=codmensaje+' '+respuesta+'. La inspección no será informada.';




    end;
     aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
    IF TRIM(INFORME)='SI' THEN
   aQ.SQL.Add('UPDATE TDATOSTURNO SET INFORMADOWS='+#39+TRIM(INFORME)+#39+', MOTIVO='+#39+TRIM(respuesta)+#39+', ESTADOID='+INTTOSTR(ESTADOID)+' WHERE TURNOID='+INTTOSTR(IDTURNO))
   ELSE
   aQ.SQL.Add('UPDATE TDATOSTURNO SET INFORMADOWS='+#39+TRIM(INFORME)+#39+', MOTIVO='+#39+TRIM(respuesta)+#39+' WHERE TURNOID='+INTTOSTR(IDTURNO));


   aq.ExecSQL;
AQ.Close;
AQ.FREE;
  if trim(men)='S' then
  begin
  Application.MessageBox( PCHAR('RESPUESTA DE SUIVTV: '+respuesta), 'Atención',
  MB_ICONINFORMATION );
   end;
end;


FUNCTION Tfrmturnos.DEVUELVE_ESTADO_TURNO(IDTURNO:LONGINT):LONGINT;
VAR   updatesql:TSQLQuery;
CODINSPE, ANIO:LONGINT;
BEGIN
           updatesql:=TSQLQuery.Create(Self);
           updatesql.SQLConnection:=mybd;
           updatesql.Close;
           updatesql.SQL.Clear;
           updatesql.SQL.Add(' select CODINSPE, ANIO FROM  tdatosturno where turnoid='+inttostr(idturno));
           updatesql.open ;
           CODINSPE:=updatesql.fieldbyname('CODINSPE').ASINTEGER;
           ANIO:=updatesql.fieldbyname('ANIO').ASINTEGER;
           updatesql.Close;
           updatesql.Free;



           updatesql:=TSQLQuery.Create(Self);
           updatesql.SQLConnection:=mybd;
           updatesql.Close;
           updatesql.SQL.Clear;
           updatesql.SQL.Add(' select RESULTAD FROM TINSPECCION where CODINSPE='+inttostr(CODINSPE)+' AND EJERCICI='+INTTOSTR(ANIO));
           updatesql.open ;

            IF TRIM(updatesql.fieldbyname('RESULTAD').ASSTRING)='A' THEN
               DEVUELVE_ESTADO_TURNO:=3;

                IF TRIM(updatesql.fieldbyname('RESULTAD').ASSTRING)='R' THEN
               DEVUELVE_ESTADO_TURNO:=7;


                IF TRIM(updatesql.fieldbyname('RESULTAD').ASSTRING)='C' THEN
               DEVUELVE_ESTADO_TURNO:=7;

           updatesql.Close;
           updatesql.Free;


END;


function Tfrmturnos.INFORMA_INSPECCION_AL_WEBSERVICES(IDTURNO,CODINSPE,ANIO:LONGINT):BOOLEAN;
var patente:string;
 updatesql:TSQLQuery;
begin

Inicializa;

ControlServidor;

if (disponibilidad_servidor='true') AND (self.respuestaidservidor=1) THEN
begin

  //ver_respuestamensajeservidor);
  APPLICATION.ProcessMessages;

  Abrir_Seccion;
    if self.respuestaid_Abrir=1 then
     begin

         if idturno < 0 then
         begin
           updatesql:=TSQLQuery.Create(Self);
           updatesql.SQLConnection:=mybd;
           updatesql.Close;
           updatesql.SQL.Clear;
           updatesql.SQL.Add(' select dvdomino FROM tdatosturno where turnoid='+inttostr(idturno));
           updatesql.open ;
           patente:=trim(updatesql.fieldbyname('dvdomino').asstring);
           updatesql.Close;
           updatesql.Free;

             if solicitar_reverificacion(idturno,patente,codinspe)=true then
                begin

                     if fileexists(ExtractFilePath(Application.ExeName) +'Recibidoreve'+inttostr(codinspe)+'.xml') then
                                            begin
                                                if generar_archivo('Recibidoreve'+inttostr(codinspe))=true then
                                                    begin

                                                      leer_respuesta_reverificacion(ExtractFilePath(Application.ExeName)+'Recibidoreve'+inttostr(codinspe)+'.txt',IDTURNO,false,'S');

                                                      if codturnoreve<>-1 then
                                                         IDTURNO:=codturnoreve;

                                                    end;

                                            end;


                end;



         end;




       //self.respuestamensaje_Abrir;
          if SELF.Informar_Inspeccion(IDTURNO,CODINSPE,ANIO) =true then
                begin
                  while   fileexists(ExtractFilePath(Application.ExeName) +'RecibioCodinspe'+inttostr(CODINSPE)+'.xml')=false do
                    begin

                        application.ProcessMessages;
                    end;


                 if   fileexists(ExtractFilePath(Application.ExeName) +'RecibioCodinspe'+inttostr(CODINSPE)+'.xml')=true then
                      begin

                       if generar_archivo('RecibioCodinspe'+inttostr(CODINSPE))=true then
                         begin
                              {leer respuesta}

                               leer_respuesta_informar_verificacion(ExtractFilePath(Application.ExeName)+'RecibioCodinspe'+inttostr(CODINSPE)+'.txt',IDTURNO,'S');
                              {---------------}
                         end;

                     end;



        Cerrar_seccion;

        end else
         begin
          //error al abrir
         end;

end
else
begin
//error de servidor
//ver_respuestamensajeservidor);
end;



end;


end;

function Tfrmturnos.INFORMA_INSPECCION_AL_WEBSERVICES_POR_IDTURNO(IDTURNO:LONGINT):BOOLEAN;
var patente:string;
 updatesql:TSQLQuery;
 CODINSPE,ANIO:LONGINT;
begin

Inicializa;

ControlServidor;

if (disponibilidad_servidor='true') AND (self.respuestaidservidor=1) THEN
begin

  updatesql:=TSQLQuery.Create(Self);
           updatesql.SQLConnection:=mybd;
           updatesql.Close;
           updatesql.SQL.Clear;
           updatesql.SQL.Add(' select dvdomino, CODINSPE,ANIO FROM tdatosturno where turnoid='+inttostr(idturno));
           updatesql.open ;
           patente:=trim(updatesql.fieldbyname('dvdomino').asstring);
           CODINSPE:=updatesql.fieldbyname('CODINSPE').ASINTEGER;
           ANIO:=updatesql.fieldbyname('ANIO').ASINTEGER;
           updatesql.Close;
           updatesql.Free;

           
  //ver_respuestamensajeservidor);
  APPLICATION.ProcessMessages;

  Abrir_Seccion;
    if self.respuestaid_Abrir=1 then
     begin

         if idturno < 0 then
         begin
           updatesql:=TSQLQuery.Create(Self);
           updatesql.SQLConnection:=mybd;
           updatesql.Close;
           updatesql.SQL.Clear;
           updatesql.SQL.Add(' select dvdomino, CODINSPE,ANIO FROM tdatosturno where turnoid='+inttostr(idturno));
           updatesql.open ;
           patente:=trim(updatesql.fieldbyname('dvdomino').asstring);
           CODINSPE:=updatesql.fieldbyname('CODINSPE').ASINTEGER;
           ANIO:=updatesql.fieldbyname('ANIO').ASINTEGER;
           updatesql.Close;
           updatesql.Free;

             if solicitar_reverificacion(idturno,patente,codinspe)=true then
                begin

                     if fileexists(ExtractFilePath(Application.ExeName) +'Recibidoreve'+inttostr(codinspe)+'.xml') then
                                            begin
                                                if generar_archivo('Recibidoreve'+inttostr(codinspe))=true then
                                                    begin

                                                      leer_respuesta_reverificacion(ExtractFilePath(Application.ExeName)+'Recibidoreve'+inttostr(codinspe)+'.txt',IDTURNO,false,'S');

                                                      if codturnoreve<>-1 then
                                                         IDTURNO:=codturnoreve;

                                                    end;

                                            end;


                end;



         end;




       //self.respuestamensaje_Abrir;
          if SELF.Informar_Inspeccion(IDTURNO,CODINSPE,ANIO) =true then
                begin
                  while   fileexists(ExtractFilePath(Application.ExeName) +'RecibioCodinspe'+inttostr(CODINSPE)+'.xml')=false do
                    begin

                        application.ProcessMessages;
                    end;


                 if   fileexists(ExtractFilePath(Application.ExeName) +'RecibioCodinspe'+inttostr(CODINSPE)+'.xml')=true then
                      begin

                       if generar_archivo('RecibioCodinspe'+inttostr(CODINSPE))=true then
                         begin
                              {leer respuesta}

                               leer_respuesta_informar_verificacion(ExtractFilePath(Application.ExeName)+'RecibioCodinspe'+inttostr(CODINSPE)+'.txt',IDTURNO,'S');
                              {---------------}
                         end;

                     end;





        end else
         begin
          //error al abrir
         end;

end
else
begin
//error de servidor
//ver_respuestamensajeservidor);
end;



end;
  Cerrar_seccion;
  

end;


function Tfrmturnos.INFORMA_INSPECCION_AL_WEBSERVICES_POR_IDTURNO_por_fecha(IDTURNO:LONGINT):BOOLEAN;
var patente:string;
 updatesql:TSQLQuery;
 CODINSPE,ANIO:LONGINT;
begin

Inicializa;

ControlServidor;

if (disponibilidad_servidor='true') AND (self.respuestaidservidor=1) THEN
begin

  updatesql:=TSQLQuery.Create(Self);
           updatesql.SQLConnection:=mybd;
           updatesql.Close;
           updatesql.SQL.Clear;
           updatesql.SQL.Add(' select dvdomino, CODINSPE,ANIO FROM tdatosturno where turnoid='+inttostr(idturno));
           updatesql.open ;
           patente:=trim(updatesql.fieldbyname('dvdomino').asstring);
           CODINSPE:=updatesql.fieldbyname('CODINSPE').ASINTEGER;
           ANIO:=updatesql.fieldbyname('ANIO').ASINTEGER;
           updatesql.Close;
           updatesql.Free;

           
  //ver_respuestamensajeservidor);
  APPLICATION.ProcessMessages;

  Abrir_Seccion;
    if self.respuestaid_Abrir=1 then
     begin

         if idturno < 0 then
         begin
           updatesql:=TSQLQuery.Create(Self);
           updatesql.SQLConnection:=mybd;
           updatesql.Close;
           updatesql.SQL.Clear;
           updatesql.SQL.Add(' select dvdomino, CODINSPE,ANIO FROM tdatosturno where turnoid='+inttostr(idturno));
           updatesql.open ;
           patente:=trim(updatesql.fieldbyname('dvdomino').asstring);
           CODINSPE:=updatesql.fieldbyname('CODINSPE').ASINTEGER;
           ANIO:=updatesql.fieldbyname('ANIO').ASINTEGER;
           updatesql.Close;
           updatesql.Free;

             if solicitar_reverificacion(idturno,patente,codinspe)=true then
                begin

                     if fileexists(ExtractFilePath(Application.ExeName) +'Recibidoreve'+inttostr(codinspe)+'.xml') then
                                            begin
                                                if generar_archivo('Recibidoreve'+inttostr(codinspe))=true then
                                                    begin

                                                      leer_respuesta_reverificacion(ExtractFilePath(Application.ExeName)+'Recibidoreve'+inttostr(codinspe)+'.txt',IDTURNO,false,'S');

                                                      if codturnoreve<>-1 then
                                                         IDTURNO:=codturnoreve;

                                                    end;

                                            end;


                end;



         end;




       //self.respuestamensaje_Abrir;
          if SELF.Informar_Inspeccion(IDTURNO,CODINSPE,ANIO) =true then
                begin
                  while   fileexists(ExtractFilePath(Application.ExeName) +'RecibioCodinspe'+inttostr(CODINSPE)+'.xml')=false do
                    begin

                        application.ProcessMessages;
                    end;


                 if   fileexists(ExtractFilePath(Application.ExeName) +'RecibioCodinspe'+inttostr(CODINSPE)+'.xml')=true then
                      begin

                       if generar_archivo('RecibioCodinspe'+inttostr(CODINSPE))=true then
                         begin
                              {leer respuesta}

                               leer_respuesta_informar_verificacion(ExtractFilePath(Application.ExeName)+'RecibioCodinspe'+inttostr(CODINSPE)+'.txt',IDTURNO,'N');
                              {---------------}
                         end;

                     end;



        Cerrar_seccion;

        end else
         begin
          //error al abrir
         Cerrar_seccion;
         end;

end
else
begin
//error de servidor
//ver_respuestamensajeservidor);
end;



end;

end;


function Tfrmturnos.INFORMA_INSPECCION_AL_WEBSERVICES_poridtunro(IDTURNO:LONGINT):BOOLEAN;
var patente:string;
 updatesql:TSQLQuery;
 codinspe, anio:longint;
begin

Inicializa;

ControlServidor;

if (disponibilidad_servidor='true') AND (self.respuestaidservidor=1) THEN
begin

  updatesql:=TSQLQuery.Create(Self);
           updatesql.SQLConnection:=mybd;
           updatesql.Close;
           updatesql.SQL.Clear;
           updatesql.SQL.Add(' select codinspe, anio from tdatosturno where turnoid='+inttostr(idturno));
           updatesql.open ;
           codinspe:=updatesql.fieldbyname('codinspe').asinteger;
           anio:=updatesql.fieldbyname('anio').asinteger;
           updatesql.Close;
           updatesql.Free;



  //ver_respuestamensajeservidor);
  APPLICATION.ProcessMessages;

  Abrir_Seccion;
    if self.respuestaid_Abrir=1 then
     begin

         if idturno < 0 then
         begin
           updatesql:=TSQLQuery.Create(Self);
           updatesql.SQLConnection:=mybd;
           updatesql.Close;
           updatesql.SQL.Clear;
           updatesql.SQL.Add(' select dvdomino tdatosturno where turnoid='+inttostr(idturno));
           updatesql.open ;
           patente:=trim(updatesql.fieldbyname('dvdomino').asstring);
           updatesql.Close;
           updatesql.Free;

             if solicitar_reverificacion(idturno,patente,codinspe)=true then
                begin

                     if fileexists(ExtractFilePath(Application.ExeName) +'Recibidoreve'+inttostr(codinspe)+'.xml') then
                                            begin
                                                if generar_archivo('Recibidoreve'+inttostr(codinspe))=true then
                                                    begin

                                                      leer_respuesta_reverificacion(ExtractFilePath(Application.ExeName)+'Recibidoreve'+inttostr(codinspe)+'.txt',IDTURNO,false,'S');

                                                      if codturnoreve<>-1 then
                                                         IDTURNO:=codturnoreve;

                                                    end;

                                            end;


                end;



         end;







       //self.respuestamensaje_Abrir;
          if SELF.Informar_Inspeccion(IDTURNO,CODINSPE,ANIO) =true then
                begin
                  while   fileexists(ExtractFilePath(Application.ExeName) +'RecibioCodinspe'+inttostr(CODINSPE)+'.xml')=false do
                    begin

                        application.ProcessMessages;
                    end;


                 if   fileexists(ExtractFilePath(Application.ExeName) +'RecibioCodinspe'+inttostr(CODINSPE)+'.xml')=true then
                      begin

                       if generar_archivo('RecibioCodinspe'+inttostr(CODINSPE))=true then
                         begin
                              {leer respuesta}

                               leer_respuesta_informar_verificacion(ExtractFilePath(Application.ExeName)+'RecibioCodinspe'+inttostr(CODINSPE)+'.txt',IDTURNO,'S');
                              {---------------}
                         end;

                     end;



        Cerrar_seccion;

        end else
         begin
          //error al abrir
         end;

end
else
begin
//error de servidor
//ver_respuestamensajeservidor);
end;



end;


end;




Function Tfrmturnos.Solicitar_turnos_por_id(HTTPRIO1: THTTPRIO;idturno:longint;spatente:string):boolean;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;     aq:tsqlquery ;
    request, response: TStringStream;
   xml,FECHADESDE,FECHAHASTA,patente:string;
begin
try
aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
aq.sql.add('SELECT  DVDOMINO FROM tdatosturno   '+
                     ' WHERE TURNOID='+INTTOSTR(idturno));
aq.ExecSQL;
aq.open;
patente:=trim(aq.fieldbyname('DVDOMINO').asstring);
aq.close;
aq.free;

if trim(patente)='' then
  patente:=trim(spatente);




xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:solicitarTurno soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(PLANTA)+'</plantaID>'+
         '<turnoID xsi:type="xsd:unsignedLong">'+inttostr(idturno)+'</turnoID>'+
         '<dominio xsi:type="xsd:string">'+trim(patente)+'</dominio>'+
      '</urn:solicitarTurno>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';




 memo2.CLEAR;
strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');
memo2.Lines.LoadFromStream(request);

memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'ENVIADACONSULTA_PORID'+ingresoID_Abrir+'.xml');


recieveID :=HTTPRIO1.HTTPWebNode.Send(request);           //Request

HTTPRIO1.HTTPWebNode.Receive(recieveID,response,false);    //Response

memo2.Clear;
response.Position := 0;

memo2.Lines.LoadFromStream(response);


memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'CONSULTA_PORID'+ingresoID_Abrir+'.xml');



strings.Free;
request.Free;
response.Free;
//LeerArchivoNOVEDADES;

Solicitar_turnos_por_id:=true;
except

  Solicitar_turnos_por_id:=false;
end;

end;


function Tfrmturnos.DESCARGAR_TURNO_POR_PATENTE(IDTURNO:LONGINT;PATENTE:STRING):BOOLEAN;
var
 updatesql:TSQLQuery;
 codinspe, anio:longint;
begin

Inicializa;

ControlServidor;

if (disponibilidad_servidor='true') AND (self.respuestaidservidor=1) THEN
begin





  //ver_respuestamensajeservidor);
  APPLICATION.ProcessMessages;

  Abrir_Seccion;
    if self.respuestaid_Abrir=1 then
     begin



            if Solicitar_turnos_por_id(self.HTTPRIO1,IDTURNO,PATENTE)=true then
            begin
                  if fileexists(ExtractFilePath(Application.ExeName) +'CONSULTA_PORID'+SELF.ingresoID_Abrir+'.xml') then
                      begin
                         { if generar_archivo_id('CONSULTA_PORID')=true then
                             begin
                                 Procesar_archivo_xml_id('CONSULTA_PORID');


                              end;  }
                       end;
            end;



    End;










        Cerrar_seccion;



end
else
begin
//error de servidor
//ver_respuestamensajeservidor);
end;



end;


function Tfrmturnos.INFORMA_INSPECCION_AL_WEBSERVICES_automatico(IDTURNO,CODINSPE,ANIO:LONGINT):BOOLEAN;
var patente:string;
 updatesql:TSQLQuery;
begin

Inicializa;

ControlServidor;

if (disponibilidad_servidor='true') AND (self.respuestaidservidor=1) THEN
begin

  //ver_respuestamensajeservidor);
  APPLICATION.ProcessMessages;

Abrir_Seccion;
    if self.respuestaid_Abrir=1 then
     begin
           if idturno < 0 then
            begin
              updatesql:=TSQLQuery.Create(Self);
              updatesql.SQLConnection:=mybd;
              updatesql.Close;
              updatesql.SQL.Clear;
              updatesql.SQL.Add(' select dvdomino from tdatosturno where turnoid='+inttostr(idturno));
              updatesql.open ;
              patente:=trim(updatesql.fieldbyname('dvdomino').asstring);
              updatesql.Close;
              updatesql.Free;
                     if solicitar_reverificacion(idturno,patente,codinspe)=true then
                         begin
                               if fileexists(ExtractFilePath(Application.ExeName) +'Recibidoreve'+inttostr(codinspe)+'.xml') then
                                  begin
                                     if generar_archivo('Recibidoreve'+inttostr(codinspe))=true then
                                        begin
                                              leer_respuesta_reverificacion(ExtractFilePath(Application.ExeName)+'Recibidoreve'+inttostr(codinspe)+'.txt',IDTURNO,false,'N');
                                                 if codturnoreve<>-1 then
                                                    IDTURNO:=codturnoreve;

                                         end;

                                   end;


                          end;



               end;    //<0




       //self.respuestamensaje_Abrir;
          if SELF.Informar_Inspeccion(IDTURNO,CODINSPE,ANIO) =true then
            begin
                    while   fileexists(ExtractFilePath(Application.ExeName) +'RecibioCodinspe'+inttostr(CODINSPE)+'.xml')=false do
                       begin

                            application.ProcessMessages;
                       end;


                 if   fileexists(ExtractFilePath(Application.ExeName) +'RecibioCodinspe'+inttostr(CODINSPE)+'.xml')=true then
                      begin

                          if generar_archivo('RecibioCodinspe'+inttostr(CODINSPE))=true then
                             begin
                              {leer respuesta}
                         
                                 leer_respuesta_informar_verificacion(ExtractFilePath(Application.ExeName)+'RecibioCodinspe'+inttostr(CODINSPE)+'.txt',IDTURNO,'N');
                              {---------------}
                              end;

                       end;


            end else
             begin

             end;    //self.respuestamensaje_Abrir;


end
else
begin

end;


Cerrar_seccion;

end;




end;

function Tfrmturnos.devuelve_resultado_inspe(codinspe:longint):string;
begin
    With TSQLQuery.Create(Self) do
  try
  Close;
  SQL.Clear;
  SQLConnection:=mybd;
 SQL.Add(' select resultad from tinspeccion where codinspe='+inttostr(codinspe));
  ExecSQL ;
  OPEN;
  devuelve_resultado_inspe:=trim(FIELDS[0].ASSTRING);
  finally
  close;
  free;
  end;

end;

function Tfrmturnos.cargar_turnos(fecha:string):boolean;

    var fechahoy,X:string;     codinspei,tunrnoid:longint;
    sqli:TSQLQuery;
begin
   FMainSag98.LABEL4.Caption:='TURNOS DEL '+fecha;
 fechahoy:=fecha;
 fechaturno:=fechahoy;
 

//ELIMINA REVES NEGATIVAS
   With TSQLQuery.Create(Self) do
  try
  Close;
  SQL.Clear;
  SQLConnection:=mybd;
  SQL.Add('DELETE  FROM TDATOSTURNO WHERE FECHATURNO=TO_date('+#39+trim(fechahoy)+#39+',''dd/mm/yyyy'') and  REVISO=''N'' and modo=''P'' and  turnoid < 0 and tipoinspe=''R'' ');
  ExecSQL;

  finally
  close;
  free;
  end;


   With TSQLQuery.Create(Self) do
  try
  Close;
  SQL.Clear;
  SQLConnection:=mybd;
  SQL.Add('select turnoid, codinspe  FROM TDATOSTURNO WHERE FECHATURNO=TO_date('+#39+trim(fechahoy)+#39+',''dd/mm/yyyy'') and modo=''P'' ');
  ExecSQL;
   open;
   while  not eof do
   begin
   codinspei:=fieldbyname('codinspe').asinteger;
   tunrnoid:=fieldbyname('turnoid').asinteger;


          sqli:=TSQLQuery.Create(Self);

                  sqli.Close;
                  sqli.SQL.Clear;
                  sqli.SQLConnection:=mybd;
                  sqli.SQL.Add('select inspfina  FROM tinspeccion WHERE codinspe='+inttostr(codinspei));
                  sqli.ExecSQL;
                  sqli.Open;

                  if  trim(sqli.fieldbyname('inspfina').asstring)='S'    then
                      begin
                        sqli.Close;
                        sqli.SQL.Clear;
                        sqli.SQLConnection:=mybd;
                        sqli.SQL.Add('update tdatosturno set reviso=''S'' WHERE turnoid='+inttostr(tunrnoid));
                        sqli.ExecSQL;


                      end;
           sqli.close;
           sqli.free;

       next;
   end;
  finally
  close;
  free;
  end;

  { With TSQLQuery.Create(Self) do
  try
  Close;
  SQL.Clear;
  SQLConnection:=mybd;
  SQL.Add('update TDATOSTURNO  set AUSENTE=''N'',  reviso=''S'' WHERE FECHATURNO=TO_date('+#39+trim(fechahoy)+#39+',''dd/mm/yyyy'') and  (codinspe is NOT null OR CODINSPE <> 0) and modo=''P'' ');
  ExecSQL;

  finally
  close;
  free;
  end; }
  


 {CANTIDAD}
  With TSQLQuery.Create(Self) do
  try
  Close;
  SQL.Clear;
  SQLConnection:=mybd;
  SQL.Add('SELECT COUNT(*) FROM TDATOSTURNO WHERE FECHATURNO=TO_date('+#39+trim(fechahoy)+#39+',''dd/mm/yyyy'') and trim(modo)=''P''   and estadoid in (1,3,7,4) ');
  ExecSQL;
  OPEN;
  FMainSag98.label5.Caption:='CANTIDAD: '+FIELDS[0].ASSTRING;
  finally
  close;
  free;
  end;

 {REVISO}

   With TSQLQuery.Create(Self) do
  try
  Close;
  SQL.Clear;
  SQLConnection:=mybd;
 SQL.Add('SELECT COUNT(*) FROM TDATOSTURNO WHERE FECHATURNO=TO_date('+#39+trim(fechahoy)+#39+',''dd/mm/yyyy'') and  trim(ausente)=''N'' and trim(reviso)=''S'' and trim(modo)=''P'' and estadoid in (1,3,7,4) ');
  ExecSQL ;
  OPEN;
  FMainSag98.label6.Caption:='REVISÓ: '+FIELDS[0].ASSTRING;
  finally
  close;
  free;
  end;

 {AUSENTES}
   With TSQLQuery.Create(Self) do
  try
  Close;
  SQL.Clear;
  SQLConnection:=mybd;
  SQL.Add('SELECT COUNT(*) FROM TDATOSTURNO WHERE FECHATURNO=TO_date('+#39+trim(fechahoy)+#39+',''dd/mm/yyyy'') and trim(ausente)=''S'' and trim(modo)=''P'' and trim(reviso)=''N'' and estadoid in (1,3,7,4) ');
  ExecSQL;
  OPEN;
  FMainSag98.label7.Caption:='AUSENTES: '+FIELDS[0].ASSTRING;
  finally
  close;
  free;
  end;

  {grilla}

     With TSQLQuery.Create(Self) do
  try
  Close;
  SQL.Clear;
  SQLConnection:=mybd;
  SQL.Add('SELECT  turnoid, horaturno, dvdomino,DECODE(AUSENTE,''S'',''AUSENTE'',''PRESENTE'') AS ESTADO, TITULARAPELLIDO,TITULARNOMBRE '+
        ', CONTACTOTELEFONO,DECODE(REVISO,''N'',''NO'',''SI''), INFORMADOWS,MOTIVO,codinspe, anio,MODO,dvmarca, dvmodelo,tipoinspe, ESTADODESC, AUSENTE, ESTADOID FROM TDATOSTURNO WHERE FECHATURNO=TO_date('+#39+trim(fechahoy)+#39+',''dd/mm/yyyy'') and modo=''P''  '+
        ' and estadoid in(1,3,7,4)   group by  turnoid, horaturno, dvdomino,  TITULARAPELLIDO,TITULARNOMBRE     '+
       ' , CONTACTOTELEFONO, INFORMADOWS,MOTIVO,codinspe,REVISO, AUSENTE,anio,MODO,dvmarca, dvmodelo,tipoinspe, ESTADOID, '+
       '  ESTADODESC, AUSENTE order by horaturno,TIPOINSPE asc');
  ExecSQL;
  OPEN;
  FMainSag98.RxMemoryData1.Close;
  FMainSag98.RxMemoryData1.Open;
  while not eof do
  begin



     FMainSag98.RxMemoryData1.Append;
     FMainSag98.RxMemoryData1turnoid.Value:=FIELDS[0].ASINTEGER;
     FMainSag98.RxMemoryData1hora.Value:=TRIM(FIELDS[1].ASSTRING);
     IF TRIM(FIELDBYNAME('ESTADOID').ASSTRING)='6' THEN
      FMainSag98.RxMemoryData1patente.Value:=TRIM(FIELDS[2].ASSTRING)+'  CANCELADO'
      ELSE
       FMainSag98.RxMemoryData1patente.Value:=TRIM(FIELDS[2].ASSTRING);


       FMainSag98.RxMemoryData1estadid.Value:=TRIM(FIELDBYNAME('ESTADOID').ASSTRING);

     FMainSag98.RxMemoryData1estado.Value:=TRIM(FIELDS[3].ASSTRING);
     FMainSag98.RxMemoryData1titular.Value:=Reemplazar_caracteres(TRIM(FIELDS[4].ASSTRING)+', '+TRIM(FIELDS[5].ASSTRING));
     FMainSag98.RxMemoryData1telefono.Value:=TRIM(FIELDS[6].ASSTRING);
     FMainSag98.RxMemoryData1reviso.Value:=TRIM(FIELDS[7].ASSTRING);
     FMainSag98.RxMemoryData1INFOME.Value:=TRIM(FIELDS[8].ASSTRING);
     FMainSag98.RxMemoryData1MOTIVO.Value:=TRIM(FIELDS[9].ASSTRING);
      FMainSag98.RxMemoryData1modo.Value:=TRIM(FIELDBYNAME('MODO').ASSTRING);
       FMainSag98.RxMemoryData1marca.Value:=TRIM(FIELDBYNAME('dvmarca').ASSTRING);
     FMainSag98.RxMemoryData1modelo.Value:=TRIM(FIELDBYNAME('dvmodelo').ASSTRING);
      FMainSag98.RxMemoryData1tipoisnpe.Value:=TRIM(FIELDBYNAME('tipoinspe').ASSTRING);
       IF TRIM(FIELDBYNAME('tipoinspe').ASSTRING)='R' THEN
        begin
        FMainSag98.RxMemoryData1tipoisnpe.Value:='R';
          FMainSag98.RxMemoryData1ES.Value:='Reverificación';
        end  else
        begin
          FMainSag98.RxMemoryData1ES.Value:='Periódica';
           FMainSag98.RxMemoryData1tipoisnpe.Value:='P';
         end;

      FMainSag98.RxMemoryData1ausentes.Value:=TRIM(FIELDBYNAME('AUSENTE').ASSTRING);
    if TRIM(FIELDS[10].ASSTRING)='' then
     FMainSag98.RxMemoryData1codinspe.Value:=0
     else
     FMainSag98.RxMemoryData1codinspe.Value:=FIELDS[10].ASINTEGER;

     if TRIM(FIELDS[11].ASSTRING)='' then
     FMainSag98.RxMemoryData1anio.Value:=0
     else
     FMainSag98.RxMemoryData1anio.Value:=FIELDS[11].ASINTEGER;

      FMainSag98.RxMemoryData1resultado.Value:=trim(devuelve_resultado_inspe(FIELDS[10].ASINTEGER));

      FMainSag98.RxMemoryData1ESTADODES.Value:=TRIM(FIELDBYNAME('ESTADODESC').ASSTRING);



     FMainSag98.RxMemoryData1.Post;


     next;
  end;
  finally
  close;
  free;
  end;

  application.ProcessMessages;
   FMainSag98.RxMemoryData1.First;









end;


procedure Tfrmturnos.BitBtn4Click(Sender: TObject);
var fechahoy:string;

begin
  //Informar_Inspeccion(214,13,2016);
  if (trim(dbgrid1.Fields[6].asstring)='NO') then
  begin
  Application.MessageBox( 'ESTA INSPECCION NO FUE REVISADA.',
  'Acceso denegado', MB_ICONSTOP );
  exit;
  end;



     INFORMA_INSPECCION_AL_WEBSERVICES(self.RxMemoryData1turnoid.Value,self.RxMemoryData1codinspe.Value,self.RxMemoryData1anio.Value);



cargar_turnos(datetostr(date));

end;

procedure Tfrmturnos.Button1Click(Sender: TObject);
var i,a:longint;
e,c:string;
begin
a:=2017;
e:='S';
   With TSQLQuery.Create(Self) do
  try
  Close;
  SQL.Clear;
  SQLConnection:=mybd;
  SQL.Add('delete from tcertificados');
  ExecSQL;

  for i:=189 to 237 do
  begin
  c:=inttostr(i);
     Close;
  SQL.Clear;
  SQLConnection:=mybd;
  SQL.Add('insert into tcertificados (numcertif,anio, estado, fecha_Alta) values ('+#39+c+#39+','+inttostr(a)+','+#39+e+#39+',to_date(''25/07/2016'',''dd/mm/yyyy'')) ');
  ExecSQL;
  end;

   except
  end;

end;

procedure Tfrmturnos.BitBtn5Click(Sender: TObject);
VAR FA:tfacturae;
TIENE_CONEXION_ELECTRONICA:BOOLEAN;
begin
FA:=tfacturae.CREATE;
FA.LEER_PARAMETROS;

if fa.Autenticar(trim(fa.MODO_FAE),trim(fa.carpeta),trim(fa.CUIT_EMPRESA))=false then
 begin


 end ELSE
 BEGIN
  FA.Control_servidores(FA.Token,FA.Sign,FA.MODO_FAE,FA.CUIT_EMPRESA);

    IF TRIM(FA.estado_servidor)='OK' THEN
     BEGIN
     //Form1.ESTADOSERVIDOR.Font.Color:=CLGREEN;
     //Form1.ESTADOSERVIDOR.Caption:=FA.estado_servidor;
     END ELSE
     BEGIN
      // Form1.ESTADOSERVIDOR.Font.Color:=CLRED;
     //Form1.ESTADOSERVIDOR.Caption:='NO OK';

     END;


   IF TRIM(FA.Estado_autentica)='OK' THEN
    BEGIN
     //Form1.ESTADOAUTENTICACION.Font.Color:=CLGREEN;
    //Form1.ESTADOAUTENTICACION.Caption:=FA.Estado_autentica;
    END ELSE
    BEGIN
    // Form1.ESTADOAUTENTICACION.Font.Color:=CLRED;
   //Form1.ESTADOAUTENTICACION.Caption:='NO OK';

    END;


   IF TRIM(FA.estado_bd)='OK' THEN
    BEGIN
    //Form1.ESTADOBASEDATOS.Font.Color:=CLGREEN;
    //Form1.ESTADOBASEDATOS.Caption:=FA.estado_bd;
    END ELSE
   BEGIN
   // Form1.ESTADOBASEDATOS.Font.Color:=CLRED;
   //Form1.ESTADOBASEDATOS.Caption:='NO OK';

   END;


   IF   (TRIM(FA.estado_bd)='OK')  AND (TRIM(FA.Estado_autentica)='OK')  AND (TRIM(FA.estado_servidor)='OK') THEN
     BEGIN
        TIENE_CONEXION_ELECTRONICA:=TRUE;

      END      ELSE
        BEGIN
          TIENE_CONEXION_ELECTRONICA:=FALSE;
        END;


END;



end;

procedure Tfrmturnos.BitBtn3Click(Sender: TObject);
var patente:string;
codinspe:longint;
turno:longint;
begin
 if trim(self.RxMemoryData1resultado.Value)='' then
 begin
   Application.MessageBox( 'la inspección no está finalizada.',
  'Atención', MB_ICONSTOP );
  exit;
 end;

 if trim(self.RxMemoryData1resultado.Value)='A' then
 begin
   Application.MessageBox( 'Solamente se permite soliciatar turnos de reverificacion a inspecciones rechazadas.',
  'Atención', MB_ICONSTOP );
  exit;
 end;
try
 self.Cursor:=crSQLWait;
 application.ProcessMessages;
Inicializa;
ControlServidor;
if (disponibilidad_servidor='true') AND (self.respuestaidservidor=1) THEN
begin

  //ver_respuestamensajeservidor);
  APPLICATION.ProcessMessages;
  Abrir_Seccion;
    if self.respuestaid_Abrir=1 then
     begin
       //self.respuestamensaje_Abrir;
          patente:=trim(self.RxMemoryData1patente.Value);
          codinspe:=self.RxMemoryData1codinspe.value;
          turno:=self.RxMemoryData1turnoid.Value;
          if solicitar_reverificacion(turno,patente,codinspe)=true then
                begin
                 if fileexists(ExtractFilePath(Application.ExeName) +'Recibidoreve'+inttostr(codinspe)+'.xml') then
                      begin
                       if generar_archivo('Recibidoreve'+inttostr(codinspe))=true then
                         begin
                           leer_respuesta_informar_verificacion(ExtractFilePath(Application.ExeName)+'Recibidoreve'+inttostr(CODINSPE)+'.txt',turno,'S');

                         end;

                     end;



        Cerrar_seccion;

        end else
         begin
          //error al abrir
         end;

end
else
begin
//error de servidor
//ver_respuestamensajeservidor);
end;



end;

  self.Cursor:=crDefault;
  application.ProcessMessages;
except
  self.Cursor:=crDefault;
  application.ProcessMessages;


end;

 cargar_turnos(datetostr(date));

end;

procedure Tfrmturnos.BitBtn6Click(Sender: TObject);
var fechahoy:string;
begin
fechahoy:=datetostr(datetimepicker1.DateTime);
cargar_turnos(fechahoy);

end;

procedure Tfrmturnos.BitBtn7Click(Sender: TObject);
begin

with Timprimirlistadoturnos.Create(Nil) do
  try
   qrlabel3.Caption:=fechaturno;
  self.RxMemoryData1.DisableControls;
    QuickRep1.Prepare;

    QuickRep1.Preview;
    self.RxMemoryData1.EnableControls;
    self.RxMemoryData1.First;
     finally
      free;
      end;



end;

procedure Tfrmturnos.CambiodeDominiodelTurno1Click(Sender: TObject);
begin
cambiodominioturno.EDIT1.TEXT:=TRIM(INTTOSTR(SELF.RxMemoryData1turnoid.Value));
cambiodominioturno.EDIT2.TEXT:=TRIM(SELF.RxMemoryData1patente.Value);

cambiodominioturno.showmodal;
end;

procedure Tfrmturnos.FormShow(Sender: TObject);
begin

self.BitBtn2.Visible:=false;
self.BitBtn3.Visible:=false;
self.BitBtn4.Visible:=false;
self.BitBtn5.Visible:=false;
self.BitBtn9.Visible:=false;
self.BitBtn10.Visible:=false;
self.BitBtn11.Visible:=false;
self.edit1.Visible:=false;

cargar_turnos(datetostr(date));
if (trim(FMainSag98.dpc.IP)='10.100.10.128') or  (trim(FMainSag98.dpc.IP)='10.54.4.4') or (trim(FMainSag98.dpc.IP)='10.54.3.4') then
begin


self.BitBtn2.Visible:=true;
self.BitBtn3.Visible:=true;
self.BitBtn4.Visible:=true;
self.BitBtn5.Visible:=true;
self.BitBtn9.Visible:=true;
self.BitBtn10.Visible:=true;
self.BitBtn11.Visible:=true;
self.edit1.Visible:=true;

end;
LABEL5.Caption:='';
end;

procedure Tfrmturnos.timegrillaTimer(Sender: TObject);
begin
cargar_turnos(datetostr(date));
application.ProcessMessages;
end;

procedure Tfrmturnos.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin


if DataCol = 2 then
// Para solamente tratar la columna 3 
begin

if trim(self.RxMemoryData1estadid.Value)='6' then
 begin
TDrawGrid(sender).canvas.Brush.Color := clred;
TDrawGrid(sender).canvas.Font.Color := clblack;
TDrawGrid(sender).canvas.Font.Style:=[fsBold];
TdbGrid(sender).DefaultDrawColumnCell(Rect, Datacol, Column, State);

end;

end;

    if DataCol = 14 then
// Para solamente tratar la columna 3
begin

if trim(self.RxMemoryData1tipoisnpe.Value)='R' then
TDrawGrid(sender).canvas.Font.Color := clred
 ELSE
TDrawGrid(sender).canvas.font.Color := clblack;



TdbGrid(sender).DefaultDrawColumnCell(Rect, Datacol, Column, State);

end;

          if DataCol = 0 then
// Para solamente tratar la columna 3
begin

if trim(self.RxMemoryData1ES.Value)='Reverificación' then
TDrawGrid(sender).canvas.Font.Color := clred
 ELSE
TDrawGrid(sender).canvas.font.Color := clblue;



TdbGrid(sender).DefaultDrawColumnCell(Rect, Datacol, Column, State);

end;

   if DataCol = 8 then
// Para solamente tratar la columna 3
begin

if trim(self.RxMemoryData1reviso.Value)='SI' then
TDrawGrid(sender).canvas.Font.Color := CLGREEN
 ELSE
TDrawGrid(sender).canvas.Font.Color := CLRED;



TdbGrid(sender).DefaultDrawColumnCell(Rect, Datacol, Column, State);

end;


  
   if DataCol = 9 then
// Para solamente tratar la columna 3
begin

if trim(self.RxMemoryData1INFOME.Value)='SI' then
TDrawGrid(sender).canvas.Font.Color := CLGREEN
 ELSE
TDrawGrid(sender).canvas.Font.Color := CLRED;




TdbGrid(sender).DefaultDrawColumnCell(Rect, Datacol, Column, State);

end;


if (Column.Index = 5)  then begin
begin
   if TRIM(self.RxMemoryData1estado.Value)='AUSENTE' THEN
   begin

   Dbgrid1.Canvas.Font.Style:=[fsBold];
   DBGrid1.Canvas.Font.Color:=CLRED;
   DBGrid1.DefaultDrawColumnCell(Rect,Datacol,Column,State);
   end ELSE BEGIN


   Dbgrid1.Canvas.Font.Style:=[fsBold];
   DBGrid1.Canvas.Font.Color:=clgreen;
   DBGrid1.DefaultDrawColumnCell(Rect,Datacol,Column,State);

   END;

end;



        if (TRIM(self.RxMemoryData1reviso.Value)='SI') AND (TRIM(SELF.RxMemoryData1INFOME.Value)='NO') then begin

         Dbgrid1.Canvas.Font.Style:=[fsBold];
         DBGrid1.Canvas.Font.Color:=CLRED;
        // Manda pintar la celda
         DBGrid1.DefaultDrawColumnCell(rect,9,column,State);
        end;

           if (TRIM(self.RxMemoryData1reviso.Value)='SI') AND (TRIM(SELF.RxMemoryData1INFOME.Value)='') then begin

         Dbgrid1.Canvas.Font.Style:=[fsBold];
         DBGrid1.Canvas.Font.Color:=CLRED;
        // Manda pintar la celda
         DBGrid1.DefaultDrawColumnCell(rect,9,column,State);
        end;
         if (TRIM(self.RxMemoryData1reviso.Value)='SI') AND (TRIM(SELF.RxMemoryData1INFOME.Value)='SI') then begin

         Dbgrid1.Canvas.Font.Style:=[fsBold];
         DBGrid1.Canvas.Font.Color:=CLGREEN;
        // Manda pintar la celda
         DBGrid1.DefaultDrawColumnCell(rect,9,column,State);
        end;






 end;
end;

procedure Tfrmturnos.BitBtn8Click(Sender: TObject);
begin
cargar_turnos(datetostr(date));
application.ProcessMessages;
end;

procedure Tfrmturnos.Timer1Timer(Sender: TObject);
var  aqlistado:TSQLQuery;
begin


LABEL5.Caption:='PROCESANDO...';
APPLICATION.ProcessMessages;
cargar_turnos(datetostr(date));
 sleep(1000);




  self.RxMemoryData1.First;
  while not self.RxMemoryData1.Eof do
  begin
       if (trim(self.RxMemoryData1INFOME.Value)='NO') and (trim(self.RxMemoryData1reviso.VALUE)='SI') and (trim(self.RxMemoryData1estadid.Value)<>'6') THEN
       BEGIN
         LABEL5.Caption:='INFORMANDO...'+TRIM(SELF.RxMemoryData1patente.Value);
         APPLICATION.ProcessMessages;
         INFORMA_INSPECCION_AL_WEBSERVICES_automatico(self.RxMemoryData1turnoid.Value,self.RxMemoryData1codinspe.Value,self.RxMemoryData1anio.Value);
       sleep(1000);
       application.ProcessMessages;
      END;
       LABEL5.Caption:='PROCESANDO...';
       APPLICATION.ProcessMessages;

      self.RxMemoryData1.Next;
  end;




cargar_turnos(datetostr(date));
  sleep(1000);
;
 LABEL5.Caption:='';
application.ProcessMessages;


end;




FUNCTION Tfrmturnos.EnviarMensaje_control(sDestino,hora,asunto,mensajea,sAdjunto:STRING):BOOLEAN;
var SMTP: TIdSMTP;
   Mensaje: TIdMessage;   SIGUE:BOOLEAN;
   Adjunto: TIdAttachment;
    sUsuario, sClave, sHost,FROM_NAME,FROM_ADDRES,  sAsunto,  sMensaje,SPUERTO: String ;
begin
EnviarMensaje_control:=TRUE;

sAsunto:=asunto;
sMensaje:=mensajea;



SIGUE:=TRUE;
sUsuario:='factura.electronica@applus.com.ar';
sClave:='Applus01$';
sHost:='mail.applus.com.ar';
SPUERTO:='25';
FROM_NAME:='CONTROL XML :'+SELF.NOMBRE_PLANTA;
FROM_ADDRES:='factura.electronica@applus.com.ar';

  // Creamos el componente de conexión con el servidor
  SMTP := TIdSMTP.Create( nil );
  SMTP.Username := sUsuario;//'factura.electronica@applus.com.ar';
  SMTP.Password := sClave;//Applus01$
  SMTP.Host := sHost;//'mail.applus.com.ar'
  SMTP.Port :=STRTOINT(SPUERTO);
  SMTP.AuthenticationType := atLogin;


  // Creamos el contenido del mensaje
  Mensaje := TIdMessage.Create( nil );
  Mensaje.Clear;
  Mensaje.From.Name := FROM_NAME;
  Mensaje.From.Address :=FROM_ADDRES;
  Mensaje.Subject := sAsunto;
  Mensaje.Body.Text := sMensaje;
  Mensaje.Recipients.Add;
  Mensaje.Recipients.Items[0].Address := sDestino;

  // Si hay que meter un archivo adjunto lo creamos y lo asignamos al mensaje
  if sAdjunto <> '' then
  begin
    if FileExists( sAdjunto ) then
      Adjunto := TIdAttachment.Create( Mensaje.MessageParts, sAdjunto );
  end
  else
    Adjunto := nil;

  // Conectamos con el servidor SMTP
  try
    SMTP.Connect;
  except
    BEGIN
    SIGUE:=FALSe;

     EnviarMensaje_control:=FALSE;
    end;
  END;

  // Si ha conectado enviamos el mensaje y desconectamos
  if SMTP.Connected then
  begin
    try
      SMTP.Send( Mensaje );
    except
        BEGIN

           SIGUE:=FALSe;
           EnviarMensaje_control:=FALSE;
        END;

    end;

    try
      SMTP.Disconnect;
    except
    BEGIN
     SIGUE:=FALSe;
     
      EnviarMensaje_control:=FALSE;
    end;
    END;
  end;

  // Liberamos los objetos creados
  if Adjunto <> nil then
    FreeAndNil( Adjunto );

  FreeAndNil( Mensaje );
  FreeAndNil( SMTP );
  IF SIGUE=TRUE THEN
   BEGIN

    EnviarMensaje_control:=TRUE;
   END;
 EnviarMensaje_control:=SIGUE;
end;



procedure Tfrmturnos.procesosauscentesTimer(Sender: TObject);
begin

application.ProcessMessages;
Inicializa;
if timetostr(time)=trim(HORA_AUSENTES)  then
begin
SELF.RxMemoryData1.Open;
IF SELF.RxMemoryData1.RecordCount > 0 THEN
BEGIN
LABEL5.Caption:='INFORMANDO AUSENTES....';
APPLICATION.ProcessMessages;

ControlServidor;
if (disponibilidad_servidor='true') AND (self.respuestaidservidor=1) THEN
begin

  //ver_respuestamensajeservidor);
  APPLICATION.ProcessMessages;
  Abrir_Seccion;
    if self.respuestaid_Abrir=1 then
     begin


         if informar_ausentes=true then
                begin
                 if fileexists(ExtractFilePath(Application.ExeName) +'informarausentes.xml') then
                      begin
                       if generar_archivo('informarausentes')=true then
                         begin
                            self.leer_respuesta_ausentes('informarausentes.txt');
                           // EnviarMensaje_control('valeria.zamorano@applus.com',TIMETOSTR(TIME),'INFORME DE AUSENTES: '+NOMBRE_PLANTA,'RESPUESTA INFORME AUSENTES',ExtractFilePath(Application.ExeName) +'informarausentes.xml');
                            EnviarMensaje_control('martin.bien@applus.com',TIMETOSTR(TIME),'INFORME DE AUSENTES: '+NOMBRE_PLANTA,'RESPUESTA INFORME AUSENTES',ExtractFilePath(Application.ExeName) +'informarausentes.xml');
                           // EnviarMensaje_control('martinbien77@gmail.com',TIMETOSTR(TIME),'INFORME DE AUSENTES: '+NOMBRE_PLANTA,'RESPUESTA INFORME AUSENTES',ExtractFilePath(Application.ExeName) +'informarausentes.xml');

                         end;

                     end;



       Cerrar_seccion;

        end else
         begin
          //error al abrir
         end;

end
else
begin
//error de servidor
//ver_respuestamensajeservidor);
end;



end;
 cargar_turnos(datetostr(date));



 LABEL5.Caption:='';
APPLICATION.ProcessMessages;

end;



END;
end;

procedure Tfrmturnos.TimeractulizarTimer(Sender: TObject);
begin


cargar_turnos(datetostr(date));
application.ProcessMessages;



END;

procedure Tfrmturnos.BitBtn9Click(Sender: TObject);
begin
cargar_turnos(datetostr(date));



  self.RxMemoryData1.First;
  while not self.RxMemoryData1.Eof do
  begin
       if (trim(self.RxMemoryData1INFOME.Value)='NO') and (trim(self.RxMemoryData1reviso.VALUE)='SI') and (trim(self.RxMemoryData1estadid.Value)<>'6') THEN
       BEGIN
         LABEL5.Caption:='INFORMANDO...'+TRIM(SELF.RxMemoryData1patente.Value);
         APPLICATION.ProcessMessages;
         INFORMA_INSPECCION_AL_WEBSERVICES_automatico(self.RxMemoryData1turnoid.Value,self.RxMemoryData1codinspe.Value,self.RxMemoryData1anio.Value);
       sleep(1000);
       application.ProcessMessages;
      END;
       LABEL5.Caption:='PROCESANDO...';
       APPLICATION.ProcessMessages;

      self.RxMemoryData1.Next;
  end;




cargar_turnos(datetostr(date));


 LABEL5.Caption:='';
application.ProcessMessages;


end;

procedure Tfrmturnos.BitBtn10Click(Sender: TObject);
begin
INFORMA_INSPECCION_AL_WEBSERVICES_poridtunro(strtoint(edit1.text));


end;

procedure Tfrmturnos.BitBtn11Click(Sender: TObject);
begin

Inicializa;
ControlServidor;
if (disponibilidad_servidor='true') AND (self.respuestaidservidor=1) THEN
begin

  //ver_respuestamensajeservidor);
  APPLICATION.ProcessMessages;
  Abrir_Seccion;
    if self.respuestaid_Abrir=1 then
     begin
       //self.respuestamensaje_Abrir;

          if informar_ausentes_por_id(strtoint(edit1.text))=true then
                begin
                 if fileexists(ExtractFilePath(Application.ExeName) +'informarausentes.xml') then
                      begin
                       if generar_archivo('informarausentes')=true then
                         begin

                         end;

                     end;



        Cerrar_seccion;

        end else
         begin
          //error al abrir
         end;

end
else
begin
//error de servidor
//ver_respuestamensajeservidor);
end;



end;

end;


END.
