unit Unconsultaws;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,s_0011, Controls, Forms,UGetDates,
  Dialogs, DB, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, USagClasses, globals, SQLExpr,
  RxMemDS,Ufunciones, InvokeRegistry, Rio, SOAPHTTPClient;

  const
  cadenasql='select CODTURNO, '+
' ESTADO    ,  '+
' FECHATURNO ,  '+
' FECHALTA   ,  '+
' CONCESIONARIO    ,   '+
' TIPO    ,  '+
' FLAGJ    , '+
' PATENTE    ,'+
' NUMMOTOR_CARROC    , '+
' TIPOVEHIC    ,  '+
' MARCA    ,  '+
' MODELO    , '+
' ANIOFABR    , '+
' DOCUMENT    , '+
' NOMBRE    ,  '+
' APELLIDO    ,  '+
' TELEFONO    ,  '+
' CORREO    ,  '+
' CODVEHIC    , '+
' CODCLIEN    , '+
' HORATURNO   , '+
' CARGADO    ,   '+
' NOMBREFACTURACION   , '+
' APELLIDOFACTURACION   , '+
' DOMICILIOFACTURACION    ,  '+
' DEPARTAMENTOFACTURACION   ,  '+
' LOCALIDADFACTURACION    , '+
' PROVINCIAFACTURACION    ,   '+
' CODIGOPOSTALFACTURACION    ,  '+
' FECHAPAGOFACTURACION    ,  '+
' ENTIDADPAGOFACTURACION    ,  '+
' IMPORTEFACTURACION    ,  '+
' GETWAYFACTURACION    , '+
' NRODOCUMENTOFACTURACION    ,  '+
' NROCALLEFACTURACION    ,  '+
' NROPISOFACTURACION  from tdatosturno ';

type
  Tgestionws = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    BitBtn1: TBitBtn;
    DataSource1: TDataSource;
    RxMemoryData1: TRxMemoryData;
    RxMemoryData1idturno: TStringField;
    RxMemoryData1hora: TStringField;
    RxMemoryData1patente: TStringField;
    RxMemoryData1marca: TStringField;
    RxMemoryData1modelo: TStringField;
    RxMemoryData1apeliido: TStringField;
    Label1: TLabel;
    Label2: TLabel;
    RxMemoryData1FECHATURNO: TStringField;
    HTTPRIO1: THTTPRIO;
    SpeedButton4: TSpeedButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label3: TLabel;
    mResponse: TMemo;
    mRequest: TMemo;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    RxMemoryData1nombrefactu: TStringField;
    RxMemoryData1fechafactu: TStringField;
    RxMemoryData1entidadfactu: TStringField;
    RxMemoryData1importefactu: TStringField;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure HTTPRIO1AfterExecute(const MethodName: String;
      SOAPResponse: TStream);
    procedure HTTPRIO1BeforeExecute(const MethodName: String;
      var SOAPRequest: WideString);
    procedure SpeedButton6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    tf:tfunciones;
  end;

var
  gestionws: Tgestionws;

implementation

uses Unseleccione__fecha_turnos, Uniingresar_patente, Undetalleturno,
  Unprocesando;



{$R *.dfm}

procedure Tgestionws.BitBtn1Click(Sender: TObject);
begin
close;
end;

procedure Tgestionws.FormShow(Sender: TObject);
begin
{
fecha:=datetostr(date);
self.RxMemoryData1.Close;
self.RxMemoryData1.Open;
   aV:=tsqlquery.create(self);
   aV.SQLConnection := MyBD;
   aV.sql.add('select codturno,patente,tipovehic,marca,modelo,horaturno, nombre, apellido , fechaturno '+
   ' from tdatosturno where fechaturno=to_date('+#39+TRIM(FECHA)+#39+',''dd/mm/yyyy'')');
   aV.ExecSQL;
   aV.Open;
   LABEL2.Caption:=INTTOSTR(AV.RecordCount);
   while not av.Eof do
   begin
      self.RxMemoryData1.Append;
      self.RxMemoryData1FECHATURNO.Value:=trim(aV.fieldbyname('fechaturno').asstring);
      self.RxMemoryData1idturno.Value:=trim(aV.fieldbyname('codturno').asstring);
      self.RxMemoryData1hora.Value:=trim(aV.fieldbyname('horaturno').asstring);
      self.RxMemoryData1patente.Value:=trim(aV.fieldbyname('patente').asstring);
      self.RxMemoryData1marca.Value:=trim(aV.fieldbyname('marca').asstring);
      self.RxMemoryData1modelo.Value:=trim(aV.fieldbyname('modelo').asstring);
      self.RxMemoryData1apeliido.Value:=trim(aV.fieldbyname('apellido').asstring)+', '+trim(aV.fieldbyname('nombre').asstring);
      self.RxMemoryData1.post;

       av.next;
   end;

   av.close;
   av.free;
   self.RxMemoryData1.First;
 }
end;

procedure Tgestionws.SpeedButton1Click(Sender: TObject);
var aV:tsqlquery;

forecasts :respuestaEco;
SWABRIR :respuestaAbrirSesion ;
LISTATURNOS :respuestaSolicitarTurnos;
i, j : integer;
NOMBREAPELLIDO:STRING;
tipoconsulta:tipoConsultaTurno  ;
fecha:string;
idturno:longint;
patente:string;
 CONEXIONWS:BOOLEAN;
begin
if self.RxMemoryData1.Active=false then
    exit;


if self.RxMemoryData1.RecordCount = 0 then
exit;
    


procesando.BitBtn1.Visible:=false;
procesando.LABEL1.Caption:='CONECTANDO...' ;
procesando.SHOW;
APPLICATION.ProcessMessages;



 IF tf.ControlServidor(HTTPRIO1)=false THEN
   BEGIN
    CONEXIONWS:=false;
    procesando.BitBtn1.Visible:=true;
    //showmessage('ERROR : '+tf.ver_mensaje_ws);
    procesando.LABEL1.Caption:=tf.ver_mensaje_ws ;

    APPLICATION.ProcessMessages;
   END ELSE BEGIN

    CONEXIONWS:=TRUE;

   END;


   IF CONEXIONWS=TRUE THEN
   BEGIN
      //self.mResponse.Clear;
      //self.mRequest.Clear;
     procesando.LABEL1.Caption:='INCIANDO SESION...';

     APPLICATION.ProcessMessages;

      IF tf.Abrir_Seccion(HTTPRIO1)=true THEN
       BEGIN

          edit2.Text:=inttostr(tf.ver_IDINGRESO_SESSION);
          CONEXIONWS:=TRUE;
          application.ProcessMessages;
       END ELSE BEGIN

        
             procesando.BitBtn1.Visible:=true;
            //showmessage('ERROR : '+tf.ver_mensaje_ws);
               procesando.LABEL1.Caption:=tf.ver_mensaje_ws ;

                APPLICATION.ProcessMessages;
          edit2.Text:='0';

        CONEXIONWS:=FALSE;
        application.ProcessMessages;

       END;
   END;



    IF CONEXIONWS=TRUE THEN
    BEGIN
      procesando.LABEL1.Caption:='SOLICITANDO TURNOS...';

     APPLICATION.ProcessMessages;


     idturno:=dbgrid1.Fields[0].AsInteger;
     patente:=trim(dbgrid1.Fields[3].AsString);
     if tf.Consultar_Turnos(HTTPRIO1,idturno,patente)=true then
     begin
       procesando.Close;
       detalleturno.Label2.Caption:=TRIM(PATENTE);
       detalleturno.Label15.Caption:=TRIM(TF.ver_consulta_turno.consultafechaturno);
      // detalleturno.Label16.Caption:=TRIM(TF.ver_consulta_turno.CO);

       detalleturno.Edit1.Text:=TRIM(TF.ver_consulta_turno.consultatipo);
       detalleturno.Edit2.Text:=TRIM(TF.ver_consulta_turno.consultamarca);
       detalleturno.Edit3.Text:=TRIM(TF.ver_consulta_turno.consultamodelo);
       detalleturno.Edit5.Text:=TRIM(TF.ver_consulta_turno.consultajurisdiccion);
       detalleturno.Edit4.Text:=INTTOSTR(TF.ver_consulta_turno.consultaanio);
       detalleturno.Edit6.Text:=INTTOSTR(TF.ver_consulta_turno.consultanumeroDocumento);
       detalleturno.Edit7.Text:=TRIM(TF.ver_consulta_turno.consultaapellido)+', '+TRIM(TF.ver_consulta_turno.consultanombre);
       detalleturno.Edit8.Text:=TRIM(TF.ver_consulta_turno.consultaentidadNombre);
       detalleturno.Edit9.Text:=TRIM(TF.ver_consulta_turno.consultafechaPago);
       detalleturno.Edit10.Text:=FLOATTOSTR(TF.ver_consulta_turno.consultaimporte);




     end ELSE BEGIN
         procesando.BitBtn1.Visible:=true;
         procesando.LABEL1.Caption:=tf.ver_mensaje_ws;;

         APPLICATION.ProcessMessages;
     END;




     tf.Cerrar_seccion(HTTPRIO1);
    END;





end;

procedure Tgestionws.SpeedButton2Click(Sender: TObject);
var aV,ac:tsqlquery;
DateIni, DateFin, tiempoProm, tiempototal : string;
codcliente,codvehic:longint;
NRODOCUMENTOFACTURACION, DEPARTAMENTOFACTURACION,LOCALIDADFACTURACION ,DOMICILIOFACTURACION,PROVINCIAFACTURACION,CODIGOPOSTALFACTURACION:string;
NOMBREFACTURACION, APELLIDOFACTURACION:string;
 codturno:longint;
apatente,anummotor_carroc ,atipovehic, amarca , amodelo: string;
aaniofabr :longint;
begin
seleccione__fecha_turnos.showmodal;
if seleccione__fecha_turnos.sale=true then
exit;

DateIni:=datetostr(seleccione__fecha_turnos.DateTimePicker1.datetime);
self.RxMemoryData1.Close;
self.RxMemoryData1.Open;
   aV:=tsqlquery.create(self);
   aV.SQLConnection := MyBD;
   aV.sql.add(cadenasql + ' where fechaturno=to_date('+#39+trim(DateIni)+#39+',''dd/mm/yyyy'')');
   aV.ExecSQL;
   aV.Open;
   LABEL2.Caption:=INTTOSTR(AV.RecordCount);
   while not av.Eof do
   begin
      self.RxMemoryData1.Append;
      self.RxMemoryData1FECHATURNO.Value:=trim(aV.fieldbyname('fechaturno').asstring);
      self.RxMemoryData1idturno.Value:=trim(aV.fieldbyname('codturno').asstring);
      self.RxMemoryData1hora.Value:=trim(aV.fieldbyname('horaturno').asstring);
      self.RxMemoryData1patente.Value:=trim(aV.fieldbyname('patente').asstring);
      self.RxMemoryData1marca.Value:=trim(aV.fieldbyname('marca').asstring);
      self.RxMemoryData1modelo.Value:=trim(aV.fieldbyname('modelo').asstring);
      self.RxMemoryData1apeliido.Value:=trim(aV.fieldbyname('apellido').asstring)+', '+trim(aV.fieldbyname('nombre').asstring);
      self.RxMemoryData1nombrefactu.Value:=trim(aV.fieldbyname('APELLIDOFACTURACION').asstring)+', '+trim(aV.fieldbyname('NOMBREFACTURACION').asstring);
      self.RxMemoryData1fechafactu.Value:=trim(aV.fieldbyname('fechapagofacturacion').asstring);
      self.RxMemoryData1entidadfactu.Value:=trim(aV.fieldbyname('entidadpagofacturacion').asstring);
      self.RxMemoryData1importefactu.Value:=trim(aV.fieldbyname('importefacturacion').asstring);

      codturno:=strtoint(trim(aV.fieldbyname('codturno').asstring));

      self.RxMemoryData1.post;

      apatente:=trim(aV.fieldbyname('patente').asstring);
      anummotor_carroc:=trim(aV.fieldbyname('nummotor_carroc').asstring);
      atipovehic:=trim(aV.fieldbyname('tipovehic').asstring);
      amarca:=trim(aV.fieldbyname('marca').asstring);
      amodelo:=trim(aV.fieldbyname('modelo').asstring);
      aaniofabr :=av.fieldbyname('aniofabr').asinteger;

      NRODOCUMENTOFACTURACION:=trim(aV.fieldbyname('NRODOCUMENTOFACTURACION').asstring);
      DEPARTAMENTOFACTURACION:=trim(aV.fieldbyname('DEPARTAMENTOFACTURACION').asstring);
      LOCALIDADFACTURACION:=trim(aV.fieldbyname('LOCALIDADFACTURACION').asstring);
      PROVINCIAFACTURACION:=trim(aV.fieldbyname('PROVINCIAFACTURACION').asstring);
      CODIGOPOSTALFACTURACION:=trim(aV.fieldbyname('CODIGOPOSTALFACTURACION').asstring);
      NOMBREFACTURACION:=trim(aV.fieldbyname('NOMBREFACTURACION').asstring);
      APELLIDOFACTURACION:=trim(aV.fieldbyname('APELLIDOFACTURACION').asstring);
      DOMICILIOFACTURACION:=trim(aV.fieldbyname('DOMICILIOFACTURACION').asstring);


       codcliente:=tf.Devuelve_codclien(NRODOCUMENTOFACTURACION,
                               NOMBREFACTURACION ,
                               APELLIDOFACTURACION ,
                               DOMICILIOFACTURACION ,
                               DEPARTAMENTOFACTURACION,
                               LOCALIDADFACTURACION ,
                               PROVINCIAFACTURACION  ,
                               CODIGOPOSTALFACTURACION);


     codvehic:=tf.Devuelve_codvehiculo( apatente,
                        anummotor_carroc ,
                        atipovehic,
                        amarca ,
                        amodelo ,
                        aaniofabr);


   ac:=tsqlquery.create(self);
   ac.SQLConnection := MyBD;
   ac.sql.add('update tdatosturno  set codvehic='+inttostr(codvehic)+', codclien='+inttostr(codcliente)+
              ' where codturno='+inttostr(codturno));
   ac.ExecSQL;


       av.next;
   end;

   av.close;
   av.free;
   self.RxMemoryData1.First;


end;

procedure Tgestionws.SpeedButton3Click(Sender: TObject);
var aV:tsqlquery;
DateIni, DateFin, tiempoProm, tiempototal,dominio : string;
begin
ingresar_patente.showmodal;
if ingresar_patente.sale=true then
exit;

dominio:=trim(ingresar_patente.Edit1.Text);
self.RxMemoryData1.Close;
self.RxMemoryData1.Open;
   aV:=tsqlquery.create(self);
   aV.SQLConnection := MyBD;
   aV.sql.add(cadenasql +  ' where UPPER(patente)='+#39+TRIM(DOMINIO)+#39);
   aV.ExecSQL;
   aV.Open;
   LABEL2.Caption:=INTTOSTR(AV.RecordCount);
   while not av.Eof do
   begin
      self.RxMemoryData1.Append;
      self.RxMemoryData1FECHATURNO.Value:=trim(aV.fieldbyname('fechaturno').asstring);
      self.RxMemoryData1idturno.Value:=trim(aV.fieldbyname('codturno').asstring);
      self.RxMemoryData1hora.Value:=trim(aV.fieldbyname('horaturno').asstring);
      self.RxMemoryData1patente.Value:=trim(aV.fieldbyname('patente').asstring);
      self.RxMemoryData1marca.Value:=trim(aV.fieldbyname('marca').asstring);
      self.RxMemoryData1modelo.Value:=trim(aV.fieldbyname('modelo').asstring);
      self.RxMemoryData1apeliido.Value:=trim(aV.fieldbyname('apellido').asstring)+', '+trim(aV.fieldbyname('nombre').asstring);
      self.RxMemoryData1nombrefactu.Value:=trim(aV.fieldbyname('APELLIDOFACTURACION').asstring)+', '+trim(aV.fieldbyname('NOMBREFACTURACION').asstring);
      self.RxMemoryData1fechafactu.Value:=trim(aV.fieldbyname('fechapagofacturacion').asstring);
      self.RxMemoryData1entidadfactu.Value:=trim(aV.fieldbyname('entidadpagofacturacion').asstring);
      self.RxMemoryData1importefactu.Value:=trim(aV.fieldbyname('importefacturacion').asstring);


      self.RxMemoryData1.post;

       av.next;
   end;

   av.close;
   av.free;
   self.RxMemoryData1.First;

 


end;

procedure Tgestionws.DBGrid1DblClick(Sender: TObject);
var tfwbs:tfunciones;
idturno:longint;
patente:string;
begin
SpeedButton1Click(Sender);

end;

procedure Tgestionws.FormCreate(Sender: TObject);
var testing:boolean;
  defWSDL:string;
  defURL :string;
  defSvc :string;
  defPrt :string;
begin

tf:=tfunciones.Create;
tf.CargarINI;

TESTING:=tf.ver_TESTING_CONEX;
edit1.Text:=tf.ver_NOMBRE_PLANTA;



 IF TESTING=TRUE THEN
 BEGIN
  defWSDL:= 'http://testing.suvtv.com.ar/service/s_001.php?wsdl';
  defURL := 'http://testing.suvtv.com.ar/service/s_001.php';
  defSvc:= 'suvtv';
  defPrt:= 'suvtvPort';
 END ELSE BEGIN
  defWSDL:= 'https://www.sirto.com.ar/services/s_002.php?wsdl';
  defURL := 'https://www.sirto.com.ar:443/services/s_002.php';
  defSvc := 'sirto_cni';
  defPrt := 'sirto_cniPort';
  end;
  //edit3.Text:=defURL;
  HTTPRIO1.WSDLLocation:=defWSDL;
  HTTPRIO1.Service:=defSvc;
  HTTPRIO1.Port:=defPrt;


end;

procedure Tgestionws.SpeedButton4Click(Sender: TObject);
var
forecasts :respuestaEco;
SWABRIR :respuestaAbrirSesion ;
LISTATURNOS :respuestaSolicitarTurnos;
i, j : integer;
NOMBREAPELLIDO:STRING;
tipoconsulta:tipoConsultaTurno  ;
fecha:string;
 CONEXIONWS:BOOLEAN;
  aV:tsqlquery;
begin
procesando.BitBtn1.Visible:=false;
procesando.LABEL1.Caption:='CONECTANDO...' ;
procesando.SHOW;
APPLICATION.ProcessMessages;



 IF tf.ControlServidor(HTTPRIO1)=false THEN
   BEGIN
    CONEXIONWS:=false;
    procesando.BitBtn1.Visible:=true;
    //showmessage('ERROR : '+tf.ver_mensaje_ws);
    procesando.LABEL1.Caption:=tf.ver_mensaje_ws ;

    APPLICATION.ProcessMessages;
   END ELSE BEGIN

    CONEXIONWS:=TRUE;

   END;


   IF CONEXIONWS=TRUE THEN
   BEGIN
      //self.mResponse.Clear;
      //self.mRequest.Clear;
     procesando.LABEL1.Caption:='INCIANDO SESION...';

     APPLICATION.ProcessMessages;

      IF tf.Abrir_Seccion(HTTPRIO1)=true THEN
       BEGIN

          edit2.Text:=inttostr(tf.ver_IDINGRESO_SESSION);
          CONEXIONWS:=TRUE;
          application.ProcessMessages;
       END ELSE BEGIN

        
             procesando.BitBtn1.Visible:=true;
            //showmessage('ERROR : '+tf.ver_mensaje_ws);
               procesando.LABEL1.Caption:=tf.ver_mensaje_ws ;

                APPLICATION.ProcessMessages;
          edit2.Text:='0';

        CONEXIONWS:=FALSE;
        application.ProcessMessages;

       END;
   END;



    IF CONEXIONWS=TRUE THEN
    BEGIN
      procesando.LABEL1.Caption:='SOLICITANDO TURNOS...';

     APPLICATION.ProcessMessages;

   IF  tf.Solicitar_Listado_Turnos(HTTPRIO1,NOW,NOW)=TRUE THEN
        BEGIN

            PROCESANDO.Close;
        END ELSE
        BEGIN
         procesando.BitBtn1.Visible:=true;
         procesando.LABEL1.Caption:='NO SE ENCONTRARON TURNOS PARA EL DIA:'+DATETOSTR(DATE);

         APPLICATION.ProcessMessages;
        END;



     fecha:=datetostr(date);
self.RxMemoryData1.Close;
self.RxMemoryData1.Open;
   aV:=tsqlquery.create(self);
   aV.SQLConnection := MyBD;
   aV.sql.add(cadenasql +  ' where fechaturno=to_date('+#39+TRIM(FECHA)+#39+',''dd/mm/yyyy'')');
   aV.ExecSQL;
   aV.Open;
   LABEL2.Caption:=INTTOSTR(AV.RecordCount);
   while not av.Eof do
   begin
      self.RxMemoryData1.Append;
      self.RxMemoryData1FECHATURNO.Value:=trim(aV.fieldbyname('fechaturno').asstring);
      self.RxMemoryData1idturno.Value:=trim(aV.fieldbyname('codturno').asstring);
      self.RxMemoryData1hora.Value:=trim(aV.fieldbyname('horaturno').asstring);
      self.RxMemoryData1patente.Value:=trim(aV.fieldbyname('patente').asstring);
      self.RxMemoryData1marca.Value:=trim(aV.fieldbyname('marca').asstring);
      self.RxMemoryData1modelo.Value:=trim(aV.fieldbyname('modelo').asstring);
      self.RxMemoryData1apeliido.Value:=trim(aV.fieldbyname('apellido').asstring)+', '+trim(aV.fieldbyname('nombre').asstring);
      self.RxMemoryData1nombrefactu.Value:=trim(aV.fieldbyname('APELLIDOFACTURACION').asstring)+', '+trim(aV.fieldbyname('NOMBREFACTURACION').asstring);
      self.RxMemoryData1fechafactu.Value:=trim(aV.fieldbyname('fechapagofacturacion').asstring);
      self.RxMemoryData1entidadfactu.Value:=trim(aV.fieldbyname('entidadpagofacturacion').asstring);
      self.RxMemoryData1importefactu.Value:=trim(aV.fieldbyname('importefacturacion').asstring);
      self.RxMemoryData1.post;

       av.next;
   end;

   av.close;
   av.free;
   self.RxMemoryData1.First;

     tf.Cerrar_seccion(HTTPRIO1);
    END;


end;

procedure Tgestionws.HTTPRIO1AfterExecute(const MethodName: String;
  SOAPResponse: TStream);
  VAR HORA,FECHA,nombrearchivo:STRING;
begin
mResponse.Clear;
SoapResponse.Position := 0;
FECHA:=StringReplace(DATETOSTR(DATE), '/', '',[rfReplaceAll, rfIgnoreCase]);
HORA:=StringReplace(timetostr(time), ':', '',[rfReplaceAll, rfIgnoreCase]);
IF TRIM(tf.ver_GENERA_XML)<>'CIE' THEN
BEGIN
nombrearchivo:=ExtractFilePath( Application.ExeName ) +'ws\xml\recibido\'+tf.ver_GENERA_XML+'\'+FECHA+'_'+HORA+'.xml';
mResponse.Lines.LoadFromStream(SoapResponse);
mResponse.Lines.SaveToFile(nombrearchivo);
END;

end;

procedure Tgestionws.HTTPRIO1BeforeExecute(const MethodName: String;
  var SOAPRequest: WideString);
  VAR HORA,FECHA,nombrearchivo:STRING;
begin
mRequest.Clear;
mRequest.Lines.Text := SoapRequest;
FECHA:=StringReplace(DATETOSTR(DATE), '/', '',[rfReplaceAll, rfIgnoreCase]);
HORA:=StringReplace(timetostr(time), ':', '',[rfReplaceAll, rfIgnoreCase]);

IF TRIM(tf.ver_GENERA_XML)<>'CIE' THEN
BEGIN
nombrearchivo:=ExtractFilePath( Application.ExeName ) +'ws\xml\enviado\'+tf.ver_GENERA_XML+'\'+FECHA+'_'+HORA+'.xml';

mRequest.Lines.SaveToFile(nombrearchivo);
END;

end;

procedure Tgestionws.SpeedButton6Click(Sender: TObject);
var
forecasts :respuestaEco;
SWABRIR :respuestaAbrirSesion ;
LISTATURNOS :respuestaSolicitarTurnos;
i, j : integer;
NOMBREAPELLIDO:STRING;
tipoconsulta:tipoConsultaTurno  ;
fecha,DateIni:string;
 CONEXIONWS:BOOLEAN;
  aV:tsqlquery;DateInid:tdate;
begin
seleccione__fecha_turnos.showmodal;
if seleccione__fecha_turnos.sale=true then
exit;

DateIni:=datetostr(seleccione__fecha_turnos.DateTimePicker1.datetime);

procesando.BitBtn1.Visible:=false;
procesando.LABEL1.Caption:='CONECTANDO...' ;
procesando.SHOW;
APPLICATION.ProcessMessages;


 IF tf.ControlServidor(HTTPRIO1)=false THEN
   BEGIN
    CONEXIONWS:=false;
    procesando.BitBtn1.Visible:=true;
    //showmessage('ERROR : '+tf.ver_mensaje_ws);
    procesando.LABEL1.Caption:=tf.ver_mensaje_ws ;

    APPLICATION.ProcessMessages

   END ELSE BEGIN

    CONEXIONWS:=TRUE;

   END;


   IF CONEXIONWS=TRUE THEN
   BEGIN
       procesando.LABEL1.Caption:='INCIANDO SESION...';

     APPLICATION.ProcessMessages;

      IF tf.Abrir_Seccion(HTTPRIO1)=true THEN
       BEGIN

          edit2.Text:=inttostr(tf.ver_IDINGRESO_SESSION);
          CONEXIONWS:=TRUE;
          application.ProcessMessages;
       END ELSE BEGIN

           procesando.BitBtn1.Visible:=true;
            //showmessage('ERROR : '+tf.ver_mensaje_ws);
               procesando.LABEL1.Caption:=tf.ver_mensaje_ws ;

                APPLICATION.ProcessMessages;
          edit2.Text:='0';

        CONEXIONWS:=FALSE;
        application.ProcessMessages;

       END;
   END;



    IF CONEXIONWS=TRUE THEN
    BEGIN

    DateInid:=strtodate(DateIni);
     procesando.LABEL1.Caption:='SOLICITANDO TURNOS...';

     APPLICATION.ProcessMessages;
    if  tf.Solicitar_Listado_Turnos(HTTPRIO1,DateInid,DateInid)=true then
             begin
            PROCESANDO.Close;
        END ELSE
        BEGIN
         procesando.BitBtn1.Visible:=true;
         procesando.LABEL1.Caption:='NO SE ENCONTRARON TURNOS PARA EL DIA:'+DATETOSTR(DateInid);

         APPLICATION.ProcessMessages;
        END;



self.RxMemoryData1.Close;
self.RxMemoryData1.Open;
   aV:=tsqlquery.create(self);
   aV.SQLConnection := MyBD;
   aV.sql.add(cadenasql +  'where fechaturno=to_date('+#39+TRIM(DateIni)+#39+',''dd/mm/yyyy'')');
   aV.ExecSQL;
   aV.Open;
   LABEL2.Caption:=INTTOSTR(AV.RecordCount);
   while not av.Eof do
   begin
      self.RxMemoryData1.Append;
      self.RxMemoryData1FECHATURNO.Value:=trim(aV.fieldbyname('fechaturno').asstring);
      self.RxMemoryData1idturno.Value:=trim(aV.fieldbyname('codturno').asstring);
      self.RxMemoryData1hora.Value:=trim(aV.fieldbyname('horaturno').asstring);
      self.RxMemoryData1patente.Value:=trim(aV.fieldbyname('patente').asstring);
      self.RxMemoryData1marca.Value:=trim(aV.fieldbyname('marca').asstring);
      self.RxMemoryData1modelo.Value:=trim(aV.fieldbyname('modelo').asstring);
      self.RxMemoryData1apeliido.Value:=trim(aV.fieldbyname('apellido').asstring)+', '+trim(aV.fieldbyname('nombre').asstring);
      self.RxMemoryData1nombrefactu.Value:=trim(aV.fieldbyname('APELLIDOFACTURACION').asstring)+', '+trim(aV.fieldbyname('NOMBREFACTURACION').asstring);
      self.RxMemoryData1fechafactu.Value:=trim(aV.fieldbyname('fechapagofacturacion').asstring);
      self.RxMemoryData1entidadfactu.Value:=trim(aV.fieldbyname('entidadpagofacturacion').asstring);
      self.RxMemoryData1importefactu.Value:=trim(aV.fieldbyname('importefacturacion').asstring);
      self.RxMemoryData1.post;

       av.next;
   end;

   av.close;
   av.free;
   self.RxMemoryData1.First;

     tf.Cerrar_seccion(HTTPRIO1);
    END;



end;

end.
