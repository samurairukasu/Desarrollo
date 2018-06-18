unit Ufunciones;

interface

uses  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, s_0011,Inifiles,XSBuiltIns, globals,
  Dialogs, StdCtrls, Grids, DBGrids, DB, Buttons, ExtCtrls,ActiveX, ComObj,Registry,ComCtrls,   RxMemDS,
   SQLEXPR, DBXpress, Provider, dbclient,  ADODB,USuperRegistry,uversion,InvokeRegistry, Rio, SOAPHTTPClient;

   Threadvar
       MyBDWS : TSqlConnection;
       BDAGWS: TSQLConnection;
       TDWS: TTransactionDesc;
       BDPADRONWS : TSqlConnection;
type
tConsulta_turnos=record
   cconsultaturnoID:longint;
   Consultaestado :string[10];
   //twst.turnos[i].datosTurno.tipoTurno;
   consultafechaturno:string[20];
   consultafecharegistro:string[20];
   //twst.turnos[i].datosTurno.turnosRelacionados;
   //  twst.turnos[i].datosTitular.genero;
   consultatipoDocumento:longint;
   consultanumeroDocumento:longint;
   consultanombre:string[40];
   consultaapellido:string[40];
   consultatelefonoCelular:string[40];
   consultaemail:string[50];
   consultadominio:string[20];
   consultamarca:string[40];
   consultamodelo:string[40];
   consultamarcaID:string[10];
   consultamodeloID:string[10];
   consultatipoID:string[10];
   consultatipo:string[40];
    // numeroChasis:=twst.turnos[i].datosVehiculo.numeroChasis;
   consultaanio:longint;
   consultajurisdiccion:string[20];
   // twst.turnos[i].datosFacturacion
   consultapagoID:longint;
   consultagatewayID:string[40];
   consultaentidadID:string[10];
   consultaentidadNombre:string[50];
   consultafechaPago:string[20];
   consultaimporte:single;
end;

type
TFunciones = class
  protected
      sql:string;
       GENERA_XML:STRING;

      {variables para property}
          rTURNOID:int64;
          RestadoID:int64;
          restado:string;
          rfechaTurno:string;
          rhoraTurno:string;
          rfechaRegistro:string;
          rnumeroDocumento:string;
          rnombretitular:string;
          rapellidotitular:string;
          cnumeroDocumento:string;
          cnombre:string;
          capellido:string;
          ctelefonoCelular:string;
          cfechaNacimiento:string;
          cemail:string;
          vdominio:string;
          vjurisdiccion:string;
          vjurisdiccionID:string;
          vanio:string;
          chasisnumero:string;
          chasismarca:string;
          modelo:string;
          tipo:string;
          tipoID:string;
          VNROCALLEFACTURACION, VNROPISOFACTURACION:STRING;
          VNOMBREFACTURACION:STRING;
          VAPELLIDOFACTURACION:STRING;
          VDOMICILIOFACTURACION:STRING;
          VDEPARTAMENTOFACTURACION:STRING;
          VLOCALIDADFACTURACION:STRING;
          VPROVINCIAFACTURACION:STRING;
          VCODIGOPOSTALFACTURACION:STRING;
          VNRODOCUMENTOFACTURACION:STRING;
          vmarca:string;
          vmarcaID :string;
          VIDGEWWAYFACTURACION:LONGINT;

          VFECHAPAGOFACTURACION,VENTIDADFACTURACION,VIMPORTEFACTURACION:STRING;
       MENSAJE:STRING;
     PLANTA:int64;
    USUARIO:int64;
    PASSWORD:STRING;
    HASH:STRING;
    DESDE,HASTA:STRING;
    TESTING_CONEX:BOOLEAN;
    HORA_CIERRE:STRING;
    TramiteNumero:int64;
    TWS:suvtvPortType;
    INGID:STRING;
    TWA:respuestaAbrirSesion;
    TWE:respuestaEco;
    TWST:respuestaSolicitarTurnos;
    TWSTR:turnosSolicitados;
    NOMBRE_PLANTA:STRING;
    TIF:respuestaInformarVerificacion;
    IDINGRESO_SESSION:INT64;
    cantidad_turnos_lista:longint;
    tconsultatur:tConsulta_turnos;
  public


    {procedimientos}
      Procedure CargarINI;
      Procedure TestOfBD(Alias, UserName, Password: String; Ageva: boolean);
      Function Cerrar_seccion(HTTPRIO1: THTTPRIO):boolean;
    {FIN PROCEDURES}


     {funciones de base de datos}
     // function Conexion(TESTING: Boolean): boolean;
     
      Function Llena_tabla_turnos_sag(CODTURNO:longint;ESTADO,FECHATURNO,FECHALTA,CONCESIONARIO,TIPO,FLAGJ,PATENTE,
                                            NUMMOTOR_CARROC,TIPOVEHIC,MARCA,MODELO:string;
                                            ANIOFABR:longint;DOCUMENT,NOMBRE,APELLIDO,TELEFONO,CORREO,horaTurno,
                                            VNOMBREFACTURACIONX,
                                            VAPELLIDOFACTURACIONX,
                                            VDOMICILIOFACTURACIONX,
                                            VDEPARTAMENTOFACTURACIONX,
                                            VLOCALIDADFACTURACIONX,
                                            VPROVINCIAFACTURACIONX,
                                            VCODIGOPOSTALFACTURACIONX,VFECHAPAGOFACTURACIONX,VENTIDADFACTURACION,
                                            VIMPORTEFACTURACIONX:string;VIDGEWWAYFACTURACIONX:LONGINT;VNRODOCUMENTOFACTURACIONX,VNROCALLEFACTURACIONX,VNROPISOFACTURACIONX:STRING):boolean;

       FUNCTION EXISTE_EN_TABLA_SAG_LA_PATENTE(idturno:longint):BOOLEAN;
     {fin funciones de base datos}


     {funciones varias}
      FUNCTION ARMA_FECHA(FECHA:TDATE):STRING;
      Function Devuelve_tipo_consulta(tipo:char):tipoConsultaTurno;
      Function Devuelve_GENERO_PERSOSNAS(GENE:string):genero;
      Function Devuelve_Resultado_Inspeccion(codinspe:longint):verificacionResultado;
      Function Transforma_Resultado(resultado:string):verificacionResultado;
      Function Transforma_fecha_date_atsdate(TDAFECHA:TDATE):TXSDATE;
      Function Transforma_fecha_datetime_a_tsxdatetime(TDAFECHA:TDATEtime):TXSDATEtime;
      Function Devuelve_codclien( adocument,anombre ,aapellido ,adomicilio ,adepartamento,alocalidad , aprovincia  ,  acodigopostal :string):longint;
      Function Devuelve_codvehiculo( apatente,
                        anummotor_carroc ,
                        atipovehic,
                        amarca ,
                        amodelo: string;
                        aaniofabr :longint):longint;
     {fin funciones varias}


     {funcion del webservices}
      Function ControlServidor(HTTPRIO1: THTTPRIO):boolean;
      Function Abrir_Seccion(HTTPRIO1: THTTPRIO):boolean;
    // Function SolicitarTurnoReverificacion(turnoID: Int64; dominio: WideString):boolean;
      Function Solicitar_Listado_Turnos(HTTPRIO1: THTTPRIO;FDesde, fHasta: TDATE):boolean;
      Function Consultar_Turnos(HTTPRIO1: THTTPRIO;idturno:Int64;dominio:string):boolean;
      Function Informar_Inspeccion(codinspe:longint):boolean;
     //Function
     {FIN FUNCIONES webservices}


     {PROPERTYS}
     Property  ver_NOMBRE_PLANTA:string read NOMBRE_PLANTA;
     Property  ver_PLANTA:int64 read PLANTA;
     Property  ver_USUARIO:int64 read USUARIO;
     Property  ver_PASSWORD:string read PASSWORD;
     Property  ver_HASH:string read HASH;
     Property  ver_TESTING_CONEX:boolean read TESTING_CONEX;
     Property  ver_mensaje_ws:string read MENSAJE;
     Property  ver_IDINGRESO_SESSION:int64 read IDINGRESO_SESSION;
     Property ver_GENERA_XML:string read GENERA_XML;
     property ver_cantidad_turnos_lista:longint read cantidad_turnos_lista;
     Property ver_consulta_turno:tConsulta_turnos read tconsultatur;
    {  Property ver_OturnoID: int64 read OturnoID;
      Property ver_Oestado:string read Oestado;
      Property ver_OfechaTurno:TXSDateTime read OfechaTurno;
      Property ver_Odominio:string read Odominio;
      Property ver_Omarca:string read  Omarca;
      Property ver_Omodelo:string read Omodelo;
      Property ver_OmarcaID:integer read  OmarcaID;
      Property ver_OmodeloID:integer read OmodeloID;
      Property ver_OtipoID:integer read OtipoID;
      Property ver_Otipo:string read  Otipo;
      Property ver_OnumeroChasis:string read  OnumeroChasis;
      Property ver_Oanio:integer read  Oanio;
      Property ver_Ojurisdiccion:integer read Ojurisdiccion;
      Property ver_OtipoDocumento:integer read OtipoDocumento;
      Property ver_OnumeroDocumento:integer read OnumeroDocumento;
      Property ver_Onombre:string read Onombre;
      Property ver_Oapellido:string read  Oapellido;
      Property ver_OtelefonoCelular:string read OtelefonoCelular;
      Property ver_Oemail:string read Oemail;
      Property ver_OpagoID:integer read OpagoID;
      Property ver_OgatewayID:integer read OgatewayID;
      Property ver_OentidadID:integer  read OentidadID;
      Property ver_OentidadNombre:string read  OentidadNombre;
       }







  end;

implementation
//uSES Unit1;
Function TFunciones.Consultar_Turnos(HTTPRIO1: THTTPRIO;idturno:Int64;dominio:string):boolean;
var tt:turnosSolicitados;
     a:longint;
     turnoID:longint;
      TWST:respuestaSolicitarTurnos;
     
begin

try


 GENERA_XML:='listadoturnos';
 TWST := (HTTPRIO1 as suvtvPortType).solicitarTurno(USUARIO,IDINGRESO_SESSION,PLANTA,idturno,trim(dominio));





  IF TWST.respuestaID <> 1 THEN
    BEGIN
    MENSAJE:=TWST.respuestaMensaje;
    Consultar_Turnos:=FALSE;
    END
    else
     begin
         for a:= 0 to length(twst.turnos)-1 do
         begin
                tconsultatur.cconsultaturnoID:= twst.turnos[a].datosTurno.turnoID;
                tconsultatur.Consultaestado := twst.turnos[a].datosTurno.estado;
                //twst.turnos[i].datosTurno.tipoTurno;
                tconsultatur.consultafechaturno:=twst.turnos[a].datosTurno.fechaTurno.NativeToXS;

                tconsultatur.consultafecharegistro:=twst.turnos[a].datosTurno.fechaRegistro.NativeToXS;
                //twst.turnos[i].datosTurno.turnosRelacionados;

             //  twst.turnos[i].datosTitular.genero;
               tconsultatur.consultatipoDocumento:=twst.turnos[a].datosTitular.tipoDocumento;
               tconsultatur.consultanumeroDocumento:=twst.turnos[a].datosTitular.numeroDocumento;
               tconsultatur.consultanombre:=twst.turnos[a].datosTitular.nombre;
               tconsultatur.consultaapellido:=twst.turnos[a].datosTitular.apellido;

               tconsultatur.consultatelefonoCelular:=twst.turnos[a].datosContacto.contactoTurno.telefonoCelular;
               tconsultatur.consultaemail:=twst.turnos[a].datosContacto.contactoTurno.email;

               tconsultatur.consultadominio:=twst.turnos[a].datosVehiculo.dominio;
               tconsultatur.consultamarca:=twst.turnos[a].datosVehiculo.marca;
               tconsultatur.consultamodelo:=twst.turnos[a].datosVehiculo.modelo;
               tconsultatur.consultamarcaID:=twst.turnos[a].datosVehiculo.marcaID;
               tconsultatur.consultamodeloID:=twst.turnos[a].datosVehiculo.modeloID;
               tconsultatur.consultatipoID:=twst.turnos[a].datosVehiculo.tipoID;
               tconsultatur.consultatipo:=twst.turnos[a].datosVehiculo.tipo;
              // numeroChasis:=twst.turnos[i].datosVehiculo.numeroChasis;
               tconsultatur.consultaanio:=twst.turnos[a].datosVehiculo.anio;
               tconsultatur.consultajurisdiccion:=twst.turnos[a].datosVehiculo.jurisdiccion;

              // twst.turnos[i].datosFacturacion

              tconsultatur.consultapagoID:=twst.turnos[a].datosPago.pagoID;
             // tconsultatur.consultagatewayID:=twst.turnos[a].datosPago.gatewayID;
             // tconsultatur.consultaentidadID:=twst.turnos[a].datosPago.entidadID;
              tconsultatur.consultaentidadNombre:=twst.turnos[a].datosPago.entidadNombre;
              tconsultatur.consultafechaPago:=twst.turnos[a].datosPago.fechaPago.NativeToXS;
              tconsultatur.consultaimporte:=twst.turnos[a].datosPago.importe;



         end;

     end;

      mensaje:=TWST.respuestaMensaje;
  Consultar_Turnos:=true;
except
  mensaje:=TWST.respuestaMensaje;
  Consultar_Turnos:=false;
end;

end;

Function  TFunciones.Devuelve_Resultado_Inspeccion(codinspe:longint):verificacionResultado;
var resultado:string;
    aQ:TsqlQuery;
begin
     aQ := TsqlQuery.Create(nil);
           try
               aQ.SQLConnection := MyBDWS;
               aQ.SQL.Add('select resultad from tinspeccion where codinspe='+inttostr(codinspe));
               aQ.Open;
               resultado:=trim(aq.fieldbyname('resultad').asstring);


            finally
                aQ.close;
                aQ.Free;
            end;




        if TRIM(resultado)='A' THEN
          Devuelve_Resultado_Inspeccion:=A;

        if TRIM(resultado)='B' THEN
          Devuelve_Resultado_Inspeccion:=R;

        if TRIM(resultado)='C' THEN
          Devuelve_Resultado_Inspeccion:=C;


end;

Function  TFunciones.Transforma_Resultado(resultado:string):verificacionResultado;
begin

        if TRIM(resultado)='A' THEN
          Transforma_Resultado:=A;

        if TRIM(resultado)='B' THEN
          Transforma_Resultado:=R;

        if TRIM(resultado)='C' THEN
          Transforma_Resultado:=C;


end;
Function TFunciones.Devuelve_GENERO_PERSOSNAS(GENE:string):genero;
begin
{T	Solicita los turnos teniendo en cuenta la fecha del turno
N	Solicita los turnos teniendo en cuenta la fecha de novedad del turno }

    if trim(GENE)='M' then
       Devuelve_GENERO_PERSOSNAS:=M;

    if trim(GENE)='F' then
       Devuelve_GENERO_PERSOSNAS:=F;


end;

Function TFunciones.Transforma_fecha_date_atsdate(TDAFECHA:TDATE):TXSDATE;
var   TXXFECHA: TXSDATE;
begin
 TXXFECHA:=TXXFECHA.Create;
 TXXFECHA.AsDate:=TDAFECHA;
 Transforma_fecha_date_atsdate:=TXXFECHA;
end;

Function TFunciones.Transforma_fecha_datetime_a_tsxdatetime(TDAFECHA:TDATEtime):TXSDATEtime;
var   TXXFECHA: TXSDATEtime;
begin
 TXXFECHA:=TXXFECHA.Create;
 TXXFECHA.AsDateTime:=TDAFECHA;
 Transforma_fecha_datetime_a_tsxdatetime:=TXXFECHA;
end;

Function TFunciones.Informar_Inspeccion(codinspe:longint):boolean;
var  aQ :TsqlQuery;
{para informar}
 GENERO:string;
 CODDOCU:string;
 DOCUMENT:string;
 NOMBRE:string;
 APELLID1:string;
 CELULAR:string;
 MAIL:string;
 DIRECCIO:string;
 NROCALLE:string;
 PISO:string;
 DEPTO:string;
 LOCALIDAD:string;
 CODPROVI:string;
 CODIGOPOSTAL:string;
 FECHAVENCIMIENTO:string;
 FECHAVIGENCIA:string;
 FECHAINICIO:string;
 FECHASALIDA:string;
 MOTORVERIFICACION:string;
 LUCESVERIFICACION:string;
 DIRECCIONVERIFICACION:string;
 FRENOSVERIFICACION:string;
 SUSPENSIONVERIFICACION:string;
 CHASISVERIFICACION:string;
 LLANTASVERIFICACION:string;
 NUEMATICOSVERIFICACION:string;
 GENERALVERIFICACION:string;
 CONTAMINACIONVERIFICACION:string;
 SEGURIDADVERIFICACION:string;
 OBSERVAC:string;
 formularioid:longint;
 Formu: formularios;
 Datosverif:datosVerificacion;
 datosPresenta: datosPresentante;
 tramitenumero:longint;
 turnoID:longint;
  HTTPRIO1: THTTPRIO;

  NUMEROINFORME:LONGINT;
begin
  try
//HTTPRIO1:=form1.HTTPRIO1;
      aQ := TsqlQuery.Create(nil);
            try
               aQ.SQLConnection := MyBDWS;
               aQ.SQL.Add(' select CODINSPE, GENERO, CODDOCU, DOCUMENT, NOMBRE, APELLID1, CELULAR, MAIL,  DIRECCIO, NROCALLE,  PISO, DEPTO, LOCALIDAD, '+
                          ' CODPROVI, CODIGOPOSTAL,  FECHAVENCIMIENTO, FECHAVIGENCIA, FECHAINICIO, FECHASALIDA, MOTORVERIFICACION, LUCESVERIFICACION,  '+
                          ' DIRECCIONVERIFICACION, FRENOSVERIFICACION, SUSPENSIONVERIFICACION, CHASISVERIFICACION, LLANTASVERIFICACION, NUEMATICOSVERIFICACION, '+
                          ' GENERALVERIFICACION,  CONTAMINACIONVERIFICACION, SEGURIDADVERIFICACION, OBSERVAC  from informarverificacion where codinspe='+inttostr(codinspe));
               aQ.Open;
                if aq.RecordCount > 0 then
                  begin
                      GENERO:=aq.fieldbyname('GENERO').AsString;
                      CODDOCU:=aq.fieldbyname('CODDOCU').AsString;
                      DOCUMENT:=aq.fieldbyname('DOCUMENT').AsString;
                      NOMBRE:=aq.fieldbyname('NOMBRE').AsString;
                      APELLID1:=aq.fieldbyname('APELLID1').AsString;
                      CELULAR:=aq.fieldbyname('CELULAR').AsString;
                      MAIL:=aq.fieldbyname('MAIL').AsString;
                      DIRECCIO:=aq.fieldbyname('DIRECCIO').AsString;
                      NROCALLE:=aq.fieldbyname('NROCALLE').AsString;
                      PISO:=aq.fieldbyname('PISO').AsString;
                      DEPTO:=aq.fieldbyname('DEPTO').AsString;
                      LOCALIDAD:=aq.fieldbyname('LOCALIDAD').AsString;
                      CODPROVI:=aq.fieldbyname('CODPROVI').AsString;
                      CODIGOPOSTAL:=aq.fieldbyname('CODIGOPOSTAL').AsString;
                      FECHAVENCIMIENTO:=aq.fieldbyname('FECHAVENCIMIENTO').AsString;
                      FECHAVIGENCIA:=aq.fieldbyname('FECHAVIGENCIA').AsString;
                      FECHAINICIO:=aq.fieldbyname('FECHAINICIO').AsString;
                      FECHASALIDA:=aq.fieldbyname('FECHASALIDA').AsString;
                      MOTORVERIFICACION:=aq.fieldbyname('MOTORVERIFICACION').AsString;
                      LUCESVERIFICACION:=aq.fieldbyname('LUCESVERIFICACION').AsString;
                      DIRECCIONVERIFICACION:=aq.fieldbyname('DIRECCIONVERIFICACION').AsString;
                      FRENOSVERIFICACION:=aq.fieldbyname('FRENOSVERIFICACION').AsString;
                      SUSPENSIONVERIFICACION:=aq.fieldbyname('SUSPENSIONVERIFICACION').AsString;
                      CHASISVERIFICACION:=aq.fieldbyname('CHASISVERIFICACION').AsString;
                      LLANTASVERIFICACION:=aq.fieldbyname('LLANTASVERIFICACION').AsString;
                      NUEMATICOSVERIFICACION:=aq.fieldbyname('UEMATICOSVERIFICACION').AsString;
                      GENERALVERIFICACION:=aq.fieldbyname('GENERALVERIFICACION').AsString;
                      CONTAMINACIONVERIFICACION:=aq.fieldbyname('CONTAMINACIONVERIFICACION').AsString;
                      SEGURIDADVERIFICACION:=aq.fieldbyname('SEGURIDADVERIFICACION').AsString;
                      OBSERVAC:=aq.fieldbyname('OBSERVAC').AsString;

                     aQ.close;
                     aq.Free;


                    tramitenumero:=codinspe;





                     {datos del reprentante}

                      datosPresenta.datosPersonales.genero:=Devuelve_GENERO_PERSOSNAS(genero);
                      datosPresenta.datosPersonales.tipoDocumento:=STRTOINT(TRIM(CODDOCU));
                      datosPresenta.datosPersonales.numeroDocumento:=STRTOINT(TRIM(DOCUMENT));
                      datosPresenta.datosPersonales.nombre:=TRIM(NOMBRE);
                      datosPresenta.datosPersonales.apellido:=TRIM(APELLID1);
                      datosPresenta.domicilio.calle:=trim(DIRECCIO);
                      datosPresenta.domicilio.numero:=trim(NROCALLE);
                      datosPresenta.domicilio.piso:=trim(PISO);
                      datosPresenta.domicilio.departamento:=TRIM(DEPTO);
                      datosPresenta.domicilio.localidad:=TRIM(LOCALIDAD);
                     // datosPresenta.domicilio.provincia:=STRTOINT(TRIM(CODPROVI));
                      datosPresenta.domicilio.codigoPostal:=TRIM(CODIGOPOSTAL);
                      datosPresenta.datosContacto.telefonoCelular:=TRIM(CELULAR);
                      datosPresenta.datosContacto.email:=TRIM(MAIL);

                     {FIN datos del reprentante}


                       {datos verificacion}
                          Datosverif.resultado:=Devuelve_Resultado_Inspeccion(CODINSPE);




                          Datosverif.fechaVencimiento:=Transforma_fecha_date_atsdate(strtodate(FECHAVENCIMIENTO));
                          Datosverif.fechaVigencia:=Transforma_fecha_date_atsdate(STRTODATE(FECHAVIGENCIA));
                          Datosverif.fechaEntrada:=Transforma_fecha_datetime_a_tsxdatetime(STRTODATE(FECHAINICIO));
                          Datosverif.fechaSalida:=Transforma_fecha_datetime_a_tsxdatetime(STRTODATE(FECHASALIDA));

                          Datosverif.detallesVerificacion.motorVerificacion.resultado:=Transforma_Resultado(MOTORVERIFICACION);
                          Datosverif.detallesVerificacion.motorVerificacion.observaciones:='';

                          Datosverif.detallesVerificacion.lucesVerificacion.resultado:=Transforma_Resultado(LUCESVERIFICACION);
                          Datosverif.detallesVerificacion.lucesVerificacion.observaciones:='';

                          Datosverif.detallesVerificacion.direccionVerificacion.resultado:=Transforma_Resultado(DIRECCIONVERIFICACION);
                          Datosverif.detallesVerificacion.direccionVerificacion.observaciones:='';

                          Datosverif.detallesVerificacion.frenosVerificacion.resultado:=Transforma_Resultado(FRENOSVERIFICACION);
                          Datosverif.detallesVerificacion.frenosVerificacion.observaciones:='';

                          Datosverif.detallesVerificacion.suspensionVerificacion.resultado:=Transforma_Resultado(SUSPENSIONVERIFICACION);
                          Datosverif.detallesVerificacion.suspensionVerificacion.observaciones:='';

                          Datosverif.detallesVerificacion.chasisVerificacion.resultado:=Transforma_Resultado(CHASISVERIFICACION);
                          Datosverif.detallesVerificacion.chasisVerificacion.observaciones:='';

                          Datosverif.detallesVerificacion.llantasVerificacion.resultado:=Transforma_Resultado(LLANTASVERIFICACION);
                          Datosverif.detallesVerificacion.llantasVerificacion.observaciones:='';

                          Datosverif.detallesVerificacion.neumaticosVerificacion.resultado:=Transforma_Resultado(NUEMATICOSVERIFICACION);
                          Datosverif.detallesVerificacion.neumaticosVerificacion.observaciones:='';

                          Datosverif.detallesVerificacion.generalVerificacion.resultado:=Transforma_Resultado(GENERALVERIFICACION);
                          Datosverif.detallesVerificacion.generalVerificacion.observaciones:='';

                          Datosverif.detallesVerificacion.contaminacionVerificacion.resultado:=Transforma_Resultado(CONTAMINACIONVERIFICACION);
                          Datosverif.detallesVerificacion.contaminacionVerificacion.observaciones:='';

                          Datosverif.detallesVerificacion.seguridadVerificacion.resultado:=Transforma_Resultado(SEGURIDADVERIFICACION);
                          Datosverif.detallesVerificacion.seguridadVerificacion.observaciones:='';

                          Datosverif.observaciones:=OBSERVAC;



                       {FIN datos verificacion}



                       {Formularios}
                        FormU[0]:=1;

                       { informamos al ws la inspeccion}

                        TIF := (HTTPRIO1 as suvtvPortType).informarVerificacion(USUARIO, TWA.ingresoID, PLANTA, turnoID, Formu,tramiteNumero, datosPresenta,Datosverif);








                  end;

            finally
                aQ.Free;
            end;
 mensaje:=TIF.respuestaMensaje;
 Informar_Inspeccion:=true;
 except
  mensaje:=TIF.respuestaMensaje;
 Informar_Inspeccion:=false;
 end;



end;

 FUNCTION TFunciones.EXISTE_EN_TABLA_SAG_LA_PATENTE(idturno:longint):BOOLEAN;
 VAR aq:tsqlquery;
    sql,dia,mes,annio:string;
    EXITE:BOOLEAN;
 BEGIN
 EXITE:=FALSE;
 {dia:=copy(trim(FECHATURNO),9,2);
 mes:=copy(trim(FECHATURNO),6,2);
 annio:=copy(trim(FECHATURNO),1,4);
 FECHATURNO:=dia+'/'+mes+'/'+annio;}

  sql:=' SELECT * FROM  tdatosturno  WHERE codturno='+inttostr(idturno);

  aq:=tsqlquery.Create(nil);
  aq.SQLConnection := MyBDWS;
  aq.sql.add(sql);
  aq.ExecSQL;
  AQ.OPEN;
  WHILE NOT AQ.EOF DO
  BEGIN
      EXITE:=TRUE;
      AQ.Next;
  END;

  aq.close;
  aq.free;

 EXISTE_EN_TABLA_SAG_LA_PATENTE:=EXITE;

 END;


 Function tFunciones.Devuelve_codvehiculo(apatente,
                        anummotor_carroc ,
                        atipovehic,
                        amarca ,
                        amodelo: string;
                        aaniofabr :longint):longint;

 var aq:tsqlquery;
 codigo:longint;
 begin
 try



 with TSQLStoredProc.Create(application) do
    try
      SQLConnection :=MyBD;
      StoredProcName :='Pq_DatosRecep.fvehiculo';  //ara clase a y b
      ParamByName('apatente').Value :=apatente;
      ParamByName('anummotor_carroc').Value :=anummotor_carroc;
      ParamByName('atipovehic').Value := atipovehic;
      ParamByName('amarca').Value :=amarca;
      ParamByName('amodelo').Value := amodelo;
      ParamByName('aaniofabr').Value := aaniofabr;


      ExecProc;
      codigo := ParamByName('codigo').AsInteger;



           // result:= aQ.Fields[0].asinteger;
        finally
           Close;
           Free;
        end;
    except
        on E: Exception do
        begin
            //fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error calculando el importe por: %S',[E.message]);
            raise
        end;
    end;

  Devuelve_codvehiculo:=codigo;



 end;



 Function tFunciones.Devuelve_codclien(adocument,
    anombre ,
    aapellido ,
    adomicilio ,
    adepartamento,
    alocalidad ,
    aprovincia  ,
    acodigopostal :string):longint;

 var aq:tsqlquery;
 existe:boolean;
 codciente:longint;
x1:longint;
           x2:longint;
           s1,cadena:string;
           s2:string;
           S3:string;
           S4:string;
           S5:string;
  codigo:longint;
StoredProc: TSQLStoredProc;

 begin
 {adocument:='29334003';
 anombre:='LAURA';
 aapellido:='ACHRTTA';
 adomicilio:='SAN MARTIN 325';
 adepartamento:='1';
 alocalidad:='VILLA MARIA';
 aprovincia:='CORDOBA';
 acodigopostal:='1384';   }


 try



 with TSQLStoredProc.Create(application) do
    try
      SQLConnection :=MyBD;
      StoredProcName :='Pq_DatosRecep.fcliente';  //ara clase a y b
      ParamByName('adocument').Value :=adocument;
      ParamByName('anombre').Value :=anombre;
      ParamByName('aapellido').Value := aapellido;
      ParamByName('adomicilio').Value :=adomicilio;
      ParamByName('adepartamento').Value := adepartamento;
      ParamByName('alocalidad').Value := alocalidad;
      ParamByName('aprovincia').Value := aprovincia;
      ParamByName('acodigopostal').Value := acodigopostal;

      ExecProc;
      codigo := ParamByName('codigo').AsInteger;



           // result:= aQ.Fields[0].asinteger;
        finally
           Close;
           Free;
        end;
    except
        on E: Exception do
        begin
            //fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error calculando el importe por: %S',[E.message]);
            raise
        end;
    end;

  Devuelve_codclien:=codigo;




 end;




 Function TFunciones.Llena_tabla_turnos_sag(CODTURNO:longint;ESTADO,FECHATURNO,FECHALTA,CONCESIONARIO,TIPO,FLAGJ,PATENTE,
                                            NUMMOTOR_CARROC,TIPOVEHIC,MARCA,MODELO:string;
                                            ANIOFABR:longint;DOCUMENT,NOMBRE,APELLIDO,TELEFONO,CORREO,horaTurno,
                                            VNOMBREFACTURACIONX,
                                            VAPELLIDOFACTURACIONX,
                                            VDOMICILIOFACTURACIONX,
                                            VDEPARTAMENTOFACTURACIONX,
                                            VLOCALIDADFACTURACIONX,
                                            VPROVINCIAFACTURACIONX,
                                            VCODIGOPOSTALFACTURACIONX,VFECHAPAGOFACTURACIONX,
                                            VENTIDADFACTURACION,VIMPORTEFACTURACIONX:string;VIDGEWWAYFACTURACIONX:LONGINT;
                                            VNRODOCUMENTOFACTURACIONX,VNROCALLEFACTURACIONX, VNROPISOFACTURACIONX:STRING):boolean;
 var aq:tsqlquery;
 sql,dia,mes,annio:string;
 codcliente,CODVEHIC:LONGINT;
 begin

 dia:=copy(trim(FECHATURNO),9,2);
 mes:=copy(trim(FECHATURNO),6,2);
 annio:=copy(trim(FECHATURNO),1,4);
 FECHATURNO:=dia+'/'+mes+'/'+annio;


 dia:=copy(trim(FECHALTA),9,2);
 mes:=copy(trim(FECHALTA),6,2);
 annio:=copy(trim(FECHALTA),1,4);
 FECHALTA:=dia+'/'+mes+'/'+annio;

 
 codcliente:=Devuelve_codclien(VNRODOCUMENTOFACTURACIONX,
                               VNOMBREFACTURACIONX ,
                               VAPELLIDOFACTURACIONX ,
                               VDOMICILIOFACTURACIONX ,
                               VDEPARTAMENTOFACTURACIONX,
                               VLOCALIDADFACTURACIONX ,
                               VPROVINCIAFACTURACIONX  ,
                               VCODIGOPOSTALFACTURACIONX);









  codvehic:=Devuelve_codvehiculo(patente,
                        nummotor_carroc ,
                        tipovehic,
                        marca ,
                        modelo ,
                        aniofabr);


 sql:=' insert into tdatosturno (CODTURNO,ESTADO,FECHATURNO,FECHALTA,CONCESIONARIO,TIPO,FLAGJ,PATENTE, '+
                                                    ' NUMMOTOR_CARROC,TIPOVEHIC,MARCA,MODELO, '+
                                                    '  ANIOFABR,DOCUMENT,NOMBRE,APELLIDO,TELEFONO,CORREO,CODVEHIC,CODCLIEN,horaturno, '+
                                                     ' NOMBREFACTURACION,APELLIDOFACTURACION,DOMICILIOFACTURACION , '+
                                                      ' DEPARTAMENTOFACTURACION,LOCALIDADFACTURACION,PROVINCIAFACTURACION, '+
                                                      ' CODIGOPOSTALFACTURACION,FECHAPAGOFACTURACION,ENTIDADPAGOFACTURACION, '+
                                                      ' IMPORTEFACTURACION,GETWAYFACTURACION,NRODOCUMENTOFACTURACION,NROCALLEFACTURACION,NROPISOFACTURACION) '+
                          ' values '+
                          '('+inttostr(CODTURNO)+','+#39+trim(estado)+#39+',to_date('+#39+trim(fechaTurno)+#39+',''dd/mm/yyyy''),to_date('+#39+trim(FECHALTA)+#39+',''dd/mm/yyyy'')'+
                          ','+#39+trim(CONCESIONARIO)+#39+','+#39+trim(TIPO)+#39+','+#39+trim(flagj)+#39+',upper('+#39+trim(PATENTE)+#39+')'+
                          ','+#39+trim(NUMMOTOR_CARROC)+#39+','+#39+trim(TIPOVEHIC)+#39+','+#39+trim(MARCA)+#39+','+#39+trim(MODELO)+#39+
                          ','+INTTOSTR(ANIOFABR)+','+#39+TRIM(DOCUMENT)+#39+','+#39+TRIM(NOMBRE)+#39+
                          ','+#39+TRIM(APELLIDO)+#39+','+#39+TRIM(TELEFONO)+#39+','+#39+TRIM(CORREO)+#39+
                          ','+INTTOSTR(CODVEHIC)+','+INTTOSTR(CODCLIENTE)+
                          ','+#39+trim(rhoraTurno)+#39+
                          ','+#39+trim(VNOMBREFACTURACIONX)+#39+
                          ','+#39+trim(VAPELLIDOFACTURACIONX)+#39+
                          ','+#39+trim(VDOMICILIOFACTURACIONX)+#39+
                          ','+#39+trim(VDEPARTAMENTOFACTURACIONX)+#39+
                          ','+#39+trim(VLOCALIDADFACTURACIONX)+#39+
                          ','+#39+trim(VPROVINCIAFACTURACIONX)+#39+
                          ','+#39+trim(VCODIGOPOSTALFACTURACIONX)+#39+
                          ',to_date('+#39+trim(VFECHAPAGOFACTURACIONX)+#39+',''dd/mm/yyyy'')'+
                          ','+#39+trim(VENTIDADFACTURACION)+#39+
                          ','+#39+trim(VIMPORTEFACTURACIONX)+#39+
                          ','+INTTOSTR(VIDGEWWAYFACTURACIONX)+','+#39+TRIM(VNRODOCUMENTOFACTURACIONX)+#39+
                          ','+#39+TRIM(VNROCALLEFACTURACIONX)+#39+','+#39+TRIM(VNROPISOFACTURACIONX)+#39+')';






               aq:=tsqlquery.Create(nil);
               aq.SQLConnection := MyBDWS;
               aq.sql.add(sql);
               aq.ExecSQL;

               aq.close;
               aq.free;

 end;


 Function TFunciones.Cerrar_seccion(HTTPRIO1: THTTPRIO):boolean;
 var control :respuestaCerrarSesion;
begin
GENERA_XML:='CIE';
 control := (HTTPRIO1 as suvtvPortType).cerrarSesion(USUARIO,PLANTA,IDINGRESO_SESSION);



 end;
Function TFunciones.Devuelve_tipo_consulta(tipo:char):tipoConsultaTurno;
begin
{T	Solicita los turnos teniendo en cuenta la fecha del turno
N	Solicita los turnos teniendo en cuenta la fecha de novedad del turno }

    if trim(tipo)='T' then
       Devuelve_tipo_consulta:=T;

    if trim(tipo)='N' then
       Devuelve_tipo_consulta:=N;


end;
FUNCTION TFunciones.ARMA_FECHA(FECHA:TDATE):STRING;
VAR FE:STRING;
BEGIN
FE:=DATETOSTR(FECHA);
ARMA_FECHA:=TRIM(COPY(TRIM(FE),7,4))+'-'+TRIM(COPY(TRIM(FE),4,2))+'-'+TRIM(COPY(TRIM(FE),1,2));
END;



Function TFunciones.Solicitar_Listado_Turnos(HTTPRIO1: THTTPRIO;FDesde, fHasta: TDATE):boolean;
var tipoconsulta:tipoConsultaTurno  ;
    LISTATURNOS :respuestaSolicitarTurnos;
    i, j : integer;
    Dt : TDateTime;
    TIPOturno:string;
    FLAGJ:string;
PDXS, DtXS : TXSDateTime;
fechaDesde, fechaHasta: string ;


begin
try

GENERA_XML:='listadoturnos';
fechaDesde:=ARMA_FECHA(FDesde);
fechaHasta:=ARMA_FECHA(fHasta);




      tipoconsulta:=Devuelve_tipo_consulta('T');
      LISTATURNOS := (HTTPRIO1 as suvtvPortType).solicitarTurnos(ver_USUARIO ,ver_IDINGRESO_SESSION, ver_PLANTA ,tipoconsulta,fechaDesde,fechaHasta);
       IF LISTATURNOS.respuestaID=1 THEN
        BEGIN
            mensaje:=LISTATURNOS.respuestaMensaje;
          cantidad_turnos_lista:=length(LISTATURNOS.turnos);

            FOR I:= 0 TO LENGTH(LISTATURNOS.turnos)-1 DO
            BEGIN
             rTURNOID:=LISTATURNOS.turnos[I].datosTurno.turnoID;
             RestadoID:=LISTATURNOS.turnos[I].datosTurno.estadoID;
             restado:=LISTATURNOS.turnos[I].datosTurno.estado;
           //   LISTATURNOS.turnos[I].datosTurno.tipoTurno;
             rfechaTurno:=LISTATURNOS.turnos[I].datosTurno.fechaTurno.NativeToXS;
             rhoraTurno:= LISTATURNOS.turnos[I].datosTurno.horaTurno.NativeToXS;
             rfechaRegistro:=LISTATURNOS.turnos[I].datosTurno.fechaRegistro.NativeToXS;
                       //LISTATURNOS.turnos[I].datosTurno.turnosRelacionados;


            //  LISTATURNOS.turnos[I].datosTitular.genero;
            //  LISTATURNOS.turnos[I].datosTitular.tipoDocumento;
             rnumeroDocumento:=inttostr(LISTATURNOS.turnos[I].datosTitular.numeroDocumento);
             rnombretitular:=LISTATURNOS.turnos[I].datosTitular.nombre;
             rapellidotitular:=LISTATURNOS.turnos[I].datosTitular.apellido;

             // LISTATURNOS.turnos[I].datosContacto.datosPersonalesTurno.genero;
             // LISTATURNOS.turnos[I].datosContacto.datosPersonalesTurno.tipoDocumento;
             cnumeroDocumento:=inttostr(LISTATURNOS.turnos[I].datosContacto.datosPersonalesTurno.numeroDocumento);
             cnombre:=LISTATURNOS.turnos[I].datosContacto.datosPersonalesTurno.nombre;
             capellido:=LISTATURNOS.turnos[I].datosContacto.datosPersonalesTurno.apellido;
             ctelefonoCelular:=LISTATURNOS.turnos[I].datosContacto.contactoTurno.telefonoCelular;
             cemail:=LISTATURNOS.turnos[I].datosContacto.contactoTurno.email;
             cfechaNacimiento:=LISTATURNOS.turnos[I].datosContacto.contactoTurno.fechaNacimiento.NativeToXS;


                vdominio:=LISTATURNOS.turnos[I].datosVehiculo.dominio;
                vmarcaID:=LISTATURNOS.turnos[I].datosVehiculo.marcaID;
                vmarca:=LISTATURNOS.turnos[I].datosVehiculo.marca;
                tipoID:=LISTATURNOS.turnos[I].datosVehiculo.tipoID;
                tipo:=LISTATURNOS.turnos[I].datosVehiculo.tipo;
                modelo:=LISTATURNOS.turnos[I].datosVehiculo.modelo;
                chasismarca:=LISTATURNOS.turnos[I].datosVehiculo.numeroChasis.marca;
                chasisnumero:= LISTATURNOS.turnos[I].datosVehiculo.numeroChasis.numero;
                vanio:=intToStr(LISTATURNOS.turnos[I].datosVehiculo.anio);
                vjurisdiccionID:=INTTOSTR(LISTATURNOS.turnos[I].datosVehiculo.jurisdiccionID);
                vjurisdiccion:=LISTATURNOS.turnos[I].datosVehiculo.jurisdiccion;
                VNOMBREFACTURACION:=LISTATURNOS.turnos[I].datosFacturacion.datosPersonales.nombre;
                VAPELLIDOFACTURACION:=LISTATURNOS.turnos[I].datosFacturacion.datosPersonales.apellido;
                VNRODOCUMENTOFACTURACION:=inttostr(LISTATURNOS.turnos[I].datosFacturacion.datosPersonales.numeroDocumento);


                  VDOMICILIOFACTURACION:=TRIM(LISTATURNOS.turnos[I].datosFacturacion.domicilio.calle);
                  VNROCALLEFACTURACION:=TRIM(LISTATURNOS.turnos[I].datosFacturacion.domicilio.numero);
                  VNROPISOFACTURACION:=TRIM(LISTATURNOS.turnos[I].datosFacturacion.domicilio.piso);

                 VDEPARTAMENTOFACTURACION:=TRIM(LISTATURNOS.turnos[I].datosFacturacion.domicilio.departamento);
                 VLOCALIDADFACTURACION:=TRIM(LISTATURNOS.turnos[I].datosFacturacion.domicilio.localidad);
                 VPROVINCIAFACTURACION:=TRIM(LISTATURNOS.turnos[I].datosFacturacion.domicilio.provincia);
                 VCODIGOPOSTALFACTURACION:=TRIM(LISTATURNOS.turnos[I].datosFacturacion.domicilio.codigoPostal);



                 VFECHAPAGOFACTURACION:=TRIM(LISTATURNOS.turnos[I].datosPago.fechaPago.NativeToXS);
                 VENTIDADFACTURACION:=TRIM(LISTATURNOS.turnos[I].datosPago.entidadNombre);
                 VIMPORTEFACTURACION:=FLOATTOSTR(LISTATURNOS.turnos[I].datosPago.importe);
                 VIDGEWWAYFACTURACION:=LISTATURNOS.turnos[I].datosPago.gatewayID;


             { IF Form1.RxMemoryData1.Active=FALSE THEN
               BEGIN
                    Form1.RxMemoryData1.Close;
                    Form1.RxMemoryData1.Open;
               END;
              Form1.RxMemoryData1.Append;
              Form1.RxMemoryData1IDTURNO.Value:=rTURNOID;
              Form1.RxMemoryData1HORA.Value:=rhoraTurno;
              Form1.RxMemoryData1FECHA.Value:=rfechaTurno;
              Form1.RxMemoryData1PATENTE.Value:=vdominio;
              Form1.RxMemoryData1TITULAR.Value:=rapellidotitular+', '+rnombretitular;
              Form1.RxMemoryData1MARCA.Value:=vmarca;
              Form1.RxMemoryData1MODELO.Value:=modelo;
              Form1.RxMemoryData1JURISDICCION.Value:=vjurisdiccion;
              Form1.RxMemoryData1.Post;
                 }
               TIPOturno:='1';
               FLAGJ:='2';
               if trim(restado)='' then
                  restado:='A';

              //guarda en la base

                    IF EXISTE_EN_TABLA_SAG_LA_PATENTE(rTURNOID)=FALSE THEN
                       BEGIN

                          Llena_tabla_turnos_sag(rTURNOID,restado,rfechaTurno,rfechaRegistro,inttostr(self.PLANTA),TIPOturno,FLAGJ,vdominio,
                                                chasisnumero,tipo,vmarca,modelo,strtoint(vanio),rnumeroDocumento,
                                                rnombretitular,rapellidotitular,ctelefonoCelular,cemail,rhoraTurno,
                                                VNOMBREFACTURACION,
                                                VAPELLIDOFACTURACION,
                                                VDOMICILIOFACTURACION,
                                                VDEPARTAMENTOFACTURACION,
                                                VLOCALIDADFACTURACION,
                                                VPROVINCIAFACTURACION,
                                                VCODIGOPOSTALFACTURACION,VFECHAPAGOFACTURACION,VENTIDADFACTURACION,
                                                VIMPORTEFACTURACION,VIDGEWWAYFACTURACION,VNRODOCUMENTOFACTURACION,
                                                VNROCALLEFACTURACION, VNROPISOFACTURACION);

                       END;

           END;
        END else
        begin
             mensaje:=LISTATURNOS.respuestaMensaje;
        end;


        if cantidad_turnos_lista=0 then
           Solicitar_Listado_Turnos:=FALSE
           ELSE
           Solicitar_Listado_Turnos:=TRUE;
          

except
    mensaje:=LISTATURNOS.respuestaMensaje;
    Solicitar_Listado_Turnos:=false;
end;

end;



Function TFunciones.Abrir_Seccion(HTTPRIO1: THTTPRIO):boolean;
var SWABRIR :respuestaAbrirSesion ;
   tipoconsulta:tipoConsultaTurno  ;

begin
try
GENERA_XML:='varios';
  SWABRIR := (HTTPRIO1 as suvtvPortType).abrirSesion(ver_PLANTA,ver_USUARIO,ver_PASSWORD,ver_HASH);
   IF SWABRIR.respuestaID=1 THEN
   begin
        IDINGRESO_SESSION:=SWABRIR.ingresoID;
        MENSAJE:=SWABRIR.respuestaMensaje;
        Abrir_Seccion:=true;
   end else begin
        MENSAJE:=SWABRIR.respuestaMensaje;
        Abrir_Seccion:=false;
   end;
except
 MENSAJE:=SWABRIR.respuestaMensaje;
   Abrir_Seccion:=false;
end;

end;



Function TFunciones.ControlServidor(HTTPRIO1: THTTPRIO):boolean;
var control :respuestaEco;
begin
try
GENERA_XML:='varios';
 control := (HTTPRIO1 as suvtvPortType).eco;
 if control.respuestaID=0 then
    begin
      ControlServidor:=false  ;
      MENSAJE:=control.respuestaMensaje;
    end else begin
       ControlServidor:=true ;
       MENSAJE:=control.respuestaMensaje;
    end;

except
MENSAJE:=control.respuestaMensaje;
   ControlServidor:=false  ;
end;


end;


Procedure TFunciones.CargarINI;
var INI: TIniFile;
T:sTRING;
begin

  if not FileExists( ExtractFilePath( Application.ExeName ) + 'config.ini' ) then
    Exit;


    INI := TINIFile.Create( ExtractFilePath( Application.ExeName ) + 'config.ini' );
    NOMBRE_PLANTA:=INI.ReadString( 'WEBSERVICES', 'NOMBRE_PLANTA', 'APPLUS' );
    PLANTA:= INI.ReadInteger( 'WEBSERVICES', 'PLANTA', 0 );
    USUARIO:= INI.ReadInteger( 'WEBSERVICES', 'USUARIO', 0 );
    PASSWORD:= INI.ReadString( 'WEBSERVICES', 'PASSWORD', '' );
    HASH:= INI.ReadString( 'WEBSERVICES', 'HASH', '' );
    T:=INI.ReadString( 'WEBSERVICES', 'TESTING', 'TRUE' );
    IF TRIM(T)='TRUE' THEN
     TESTING_CONEX:=TRUE
     ELSE
      TESTING_CONEX:=FALSe;


    HORA_CIERRE:='20:00:00';


  INI.Free;
end;
 
procedure TFunciones.TestOfBD(Alias, UserName, Password: String; Ageva: boolean);
    var
        DBAlias, DBUserName, DBPassword, DBAlias2, DBUserName2, DBPassword2,
        DBAlias3, DBUserName3, DBPassword3,
        DBDriverName, DBLibraryName, DBVendorLib, DBGetDriverFunc: String;
    const
  coEnableBCD = TSQLConnectionOption(102); // boolean
    begin
        with TSuperRegistry.Create do
        try
            RootKey := HKEY_LOCAL_MACHINE;

            if not OpenKeyRead(BD_KEY)
            then mensaje:='No se encontraron los par�metros de conexi�n a la base de datos. Verifique el registro de windows.'
            else begin
                try
                    If Alias=''
                    then
                        DBAlias := ReadString(ALIAS_)
                    Else
                        DBAlias:=Alias;


                    If UserName=''
                    then
                        DBUserName := ReadString(USER_)
                    else
                        DBUserName:=UserName;

                    If Password=''
                    then
                        DBPassword := ReadString(PASSWORD_)
                    else
                        DBPassword:=Password;

                    DBDriverName := ReadString(DRIVERNAME_);
                    DBLibraryName := ReadString(LIBRARYNAME_);
                    DBVendorLib := ReadString(VENDORLIB_);
                    DBGetDriverFunc := ReadString(GETDRIVERFUNC_);

                    DBAlias2:='';
                    DBUserName2:='';
                    DBPassword2:='';
                    DBAlias3:='';
                    DBUserName3:='';
                    DBPassword3:='';
                    try
                      DBAlias2 := ReadString(ALIAS2_);
                      DBUserName2 := ReadString(USER2_);
                      DBPassword2 := ReadString(PASSWORD2_);
                      DBAlias3 := ReadString(ALIAS3_);
                      DBUserName3 := ReadString(USER3_);
                      DBPassword3 := ReadString(PASSWORD3_);
                    except

                    end;

                except
                    mensaje:='No se encontr� en el registro alg�n par�metro necesario para la conexi�n a la base de datos';
                    exit;
                end;


                MyBDWS := TSQLConnection.Create(nil);
                with MyBDWS do
                begin
                   DriverName := DBDriverName;
                   LibraryName := DBLibraryName;
                   VendorLib := DBVendorLib;
                   GetDriverFunc := DBGetDriverFunc;

                   Params.Values['DataBase'] := DBAlias;
                   Params.Values['EnableBCD'] := 'True';
                   Params.Values['User_Name'] := DBUserName;
                   Params.Values['Password'] := DBPassword;
                   LoginPrompt := false;
                   KeepConnection := true;
                end;
                try
                    MyBDWS.Open;
                    MyBDWS.SQLConnection.SetOption(coEnableBCD, Integer(False));
                except
                    on E: Exception do
                        mensaje:='No se pudo conectar con la base de datos por: ' + E.message;
                end;




            end
        finally
            Free;
        end;
    end;

end.
