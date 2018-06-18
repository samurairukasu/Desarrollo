unit xml_caba;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, dateutils,
  Dialogs, StdCtrls, Grids, DBGrids, DB, Buttons, ExtCtrls,math, xmldom, XMLIntf, IniFiles,
  msxmldom, XMLDoc,  oxmldom,  ComObj, MSXML, InvokeRegistry, Rio, SOAPHTTPClient,base64_new,
   SQLEXPR, DBXpress, Provider, dbclient,  ADODB,USuperRegistry,UVERSION;

   Threadvar
       MyBD : TSqlConnection;
       MyBD_test:TSqlConnection;
       BDAG: TSQLConnection;
       TD: TTransactionDesc;
       BDPADRON : TSqlConnection;
 type
txml_caba= class
  PROTECTED
  total_registros_pagos_insertados:longint;
  MODO_TURNO:string;
  HTTPRIO: THTTPRIO;
   sql:string;
   XMLDocument: TXMLDocument;
   Memo: TMemo;
   I: Integer;
     XmlNode: IXMLNode;
     NodeText: string;
     AttrNode: IXMLNode;
  respuestaID,respuestaMensaje:string;
 turnoID:string;
 estadoID :string;
estado:string;
tipoTurno:string;
esReveDia:STRING;
esReve:STRING;
ES_REVERIFICACION:sTRING;
fechaTurno:string;
horaTurno:string;
fechaRegistro:string;
fechaNovedad:string;
plantaID,reservaID:string;
genero:string;
tipoDocumento:string;
numeroDocumento:string;
numeroCuit:string;
nombre:string;
apellido:string;
razonSocial:string;
domicilio:string;
calle:string;
numero:string;
piso:string;
departamento:string;
localidad:string;
provinciaID:string;
provincia:string;
codigoPostal:string;
condicionIva:string;
numeroIibb:string;
ARCHIVOS_XML_PAGOS:STRING;
telefonoCelular:string;
email:string;
fechaNacimiento:string;
pagoID:String;
gatewayID:string;
entidadID:string;
entidadNombre:string;
fechaPago:string;
importeTotal:string;
importe:string;
estadoAcreditacion:string;
pagoGatewayID:string;
re_item_turnoID:string;
re_item_plantaID:string;
re_item_estado:string;
re_item_fechaNovedad:string;
re_datosPago_pagoID:string;
re_datosPago_entidadID:string;
re_datosPago_fechaPago:string;
re_datosPago_importeTotal:string;
re_detallesPagoVerificacion_pagoID:string;
re_detallesPagoVerificacion_importe:string;
re_detallesPagoVerificacion_estadoAcreditacion:string;
re_detallesPagoOblea_pagoID:string;
re_detallesPagoOblea_importe:string;
re_detallesPagoOblea_estadoAcreditacion:string;
datosTitular_genero:string;
datosTitular_tipoDocumento :string;
datosTitular_numeroDocumento:string;
datosTitular_numeroCuit:string;
datosTitular_nombre:string;
datosTitular_apellido :string;
NO_HACE_FACTURA_ELECTRONICA:BOOLEAN;
datosTitular_razonSocial:string;
datosPersonalesTurno_tipoDocumento:string;
datosPersonalesTurno_numeroDocumento:string;
datosPersonalesTurno_numeroCuit:string;
datosPersonalesTurno_nombre:string;
datosPersonalesTurno_apellido:string;
datosPersonalesTurno_razonSocial:string;
contactoTurno_telefonoCelular:string;
contactoTurno_email:string;
contactoTurno_fechaNacimiento:string;
datosPersonales_genero:string;
datosPersonales_tipoDocumento:string;
datosPersonales_numeroDocumento:string;
datosPersonales_numeroCuit:string;
datosPersonales_nombre:string;
datosPersonales_apellido:string;
datosPersonales_razonSocial:string;
datosFacturacion_domicilio:string;
domicilio_calle:string;
domicilio_numero:string;
domicilio_piso:string;
domicilio_departamento:string;
domicilio_localidad :string;
domicilio_provinciaID :string;
domicilio_provincia :string;
domicilio_codigoPostal:string;
datosFacturacion_condicionIva:string;
datosFacturacion_numeroIibb:string;
datosPago_pagoID:string;
datosPago_gatewayID:string;
datosPago_entidadID:string;
datosPago_entidadNombre:string;
datosPago_fechaPago:string;
datosPago_importeTotal:string;
detallesPagoVerificacion_plantaID:string;
detallesPagoVerificacion_pagoID:string;
detallesPagoVerificacion_importe:string;
detallesPagoVerificacion_estadoAcreditacion:string;
detallesPagoVerificacion_pagoGatewayID:string;
detallesPagoOblea_pagoID:string;
detallesPagoOblea_importe:string;
detallesPagoOblea_estadoAcreditacion:string;
datosVehiculo_dominio:string;
datosVehiculo_marcaID:string;
datosVehiculo_marca:string;
datosVehiculo_tipoID:string;
datosVehiculo_tipo:string;
datosVehiculo_modeloID:string;
datosVehiculo_modelo:string;
numeroChasis_marca:string;
numeroChasis_numero:string;
datosVehiculo_anio:string;
datosVehiculo_jurisdiccionID:string;
datosVehiculo_jurisdiccion:string;
datosVehiculo_mtm:string;
datosVehiculo_valTitular:string;
datosVehiculo_valChasis:string;
datosValidados_marcaID:string;
datosValidados_marca:string;
datosValidados_tipoID:string;
datosValidados_tipo:string;
datosValidados_modeloID:string;
datosValidados_modelo:string;
datosValidados_mtm:string;
datosValidados_numeroChasis_VALIDO:STRING;
NOMBRE_PLANTA:string;
HABILITADO_FACTURA:STRING;
FECHA_VENCE_CERTIFICADO:STRING;
PLANTA:integer;
USUARIO:integer;
PASSWORD:string;
HASH:string;
T:string;
respuestaidservidor :longint;
respuestamensajeservidor :string;
disponibilidad_servidor:string;
TESTING_CONEX:boolean;
ingresoID_Abrir:string;
respuestaid_Abrir:longint ;
respuestamensaje_Abrir:string;
sesionID_Abrir:string;
 respuestamensaje_informar_factura:string;
 respuestaid_informar_factura:string;
 respuestamensaje_factura_informar_factura:String;
 respuestaid_factura_informar_factura:String;

cantidadPagos:string;
respuestaidpago:longint ;
respuestamensajepago:string;
respuestamensajefactura:string;
respuestaidfactura:longint;
HORA_CIERRE:string;
 numeroChasis_VALIDO:STRING;
relacion:string;
ARCHIVOPROCESO:TEXTFILE;
TURNOID_RELACION:LONGINT;
Procedure Inicializa_IDCL(arhivo_xml:string) ;
 FUNCTION POR_NOVEDAD_20(horad, horah:STRING):STRING;
function extrae_valor_PAGOS(cadena:string):string;
function Procesa_archivo_xml_PAGOS(ARCHIVO:STRING):boolean;
function Procesa_archivo_xml_IDCL:boolean;
function Procesa_archivo_xml:boolean;
procedure DomToTree (XmlNode: IXMLNode);
procedure DomToTree_XML_PAGOS(XmlNode: IXMLNode);
function es_linea(cadena:string):string ;
function extrae_valor(cadena:string):string;
FUNCTION LEER_TAGS_ARCHIVO(IDCL:BOOLEAN):BOOLEAN;
FUNCTION POR_NOVEDAD_1830(horad, horah:STRING):STRING;
FUNCTION POR_FECHA_TURNO(DESDE, HASTA:STRING;IDSE:LONGINT):STRING;
FUNCTION POR_NOVEDAD(IDTURNO, PATENTE:STRING):STRING;
Procedure Inicializa_PAGOS(arhivo_xml:string) ;
Procedure Inicializa(arhivo_xml:string) ;
FUNCTION POR_TURNOID(IDTURNO, PATENTE:STRING):STRING;
function configura_http:boolean;
Procedure LeerArchivoEco;
//Function ControlServidor:boolean;
FUNCTION POR_TURNOID_CLIENTE_CERO(IDTURNO, PATENTE:STRING):STRING;
Procedure Guarda_turno_en_basedatos;
Procedure Guarda_turno_en_basedatos_IDCLIENTECERO;
Procedure LeerArchivoAbrir;
FUNCTION ARMA_FECHA(FECHA:string):STRING;
Procedure Leer_archivo_pagos_encabezado(archivo:string);
FUNCTION ARMA_FECHA1(FECHA:string):STRING;

function guarda_xml_error(pagoid,archivo:string):boolean;
  Function Devuelve_codclien(adocument,
    anombre ,
    aapellido ,
    adomicilio ,anumerocalle,
    adepartamento,
    alocalidad ,
    aprovincia  ,
    acodigopostal ,genero,tipodocu,tipofact,tipoiva:string):longint;


   Function Devuelve_codvehiculo(apatente,
                        anummotor_carroc ,
                        atipovehic,
                        amarca ,
                        amodelo: string;
                        aaniofabr :longint):longint;

   Function Devuelve_codvehiculo_v2(apatente,
                        anummotor_carroc ,
                        atipovehic,
                        amarca ,
                        amodelo: string;
                        aaniofabr :longint):longint;
FUNCTION LEER_TAGS_ARCHIVO_XML_PAGOS(ARCHIVO:STRING):BOOLEAN;

FUNCTION  BORRAR_TEMPORAL_FERIADOS(IDF:LONGINT):BOOLEAN;
FUNCTION LEER_TAGS_ARCHIVO_XML_PAGOS_ver2(ARCHIVO,ARCHIVO_XML:STRING):BOOLEAN;
FUNCTION LEER_TAGS_FERIADO(ARCHIVO:STRING):BOOLEAN;
FUNCTION GARRDAR_XML_PAGOS(detallesPago_pagoID,
                           detallesPago_plantaID,
                           detallesPago_importe,
                           detallesPago_estadoAcreditacion,
                           detallesPago_estadoAcreditacionD,
                           detallesPago_pagoGatewayID,
                           detallesPago_tipoBoleta,
                           detallesPago_fechaNovedad,
                           detallesPago_fechaPago:string;
                           datosPersonalesTurno_genero,
                           datosPersonalesTurno_tipoDocumento,
                           datosPersonalesTurno_numeroDocumento,
                           datosPersonalesTurno_numeroCuit,
                           datosPersonalesTurno_nombre,
                           datosPersonalesTurno_apellido,
                           datosPersonalesTurno_razonSocial,
                           contactoTurno_telefonoCelular,
                           contactoTurno_email,
                           contactoTurno_fechaNacimiento,
                           datosPersonales_genero,
                           datosPersonales_tipoDocumento,
                           datosPersonales_numeroDocumento,
                           datosPersonales_numeroCuit,
                           datosPersonales_nombre,
                           datosPersonales_apellido,
                           datosPersonales_razonSocial,
                           datosFacturacion_domicilio,
                           domicilio_calle,
                           domicilio_numero,
                           domicilio_piso,
                           domicilio_departamento,
                           domicilio_localidad,
                           domicilio_provinciaID,
                           domicilio_provincia,
                           domicilio_codigoPostal,
                           datosFacturacion_condicionIva,ARCHIVO_XML,detallesPago_pagoForzado,detallesPago_codigoPago:STRING):BOOLEAN;

public
pone_999:boolean;
ESSERVIDOR:STRING;
codturnoreve:LONGINT;
 Function informar_ausentes_TURNO_INDVI_faltante(IDT:LONGINT;TABLA:sTRING):boolean;
 function  procesar_xml_a_pata(archivo:string):boolean;

 function INFORMAR_FACTURA_a_suvtv(externalReference,
numeroFactura,
tipoComprobante,
Dominio,
importeTotal,
importeNeto,
importeIVA,
cae,
vencimientoCae,
tipoFactura,
fechaFactura,
comprobantehash,smd5 :string):boolean  ;
  Function Devuelve_codclienV2(adocument, anombre ,
    aapellido ,
    adomicilio ,anumerocalle,
    adepartamento,
    alocalidad ,
    aprovincia  ,
    acodigopostal ,genero,tipodocu,tipofact,tipoiva:string):longint;
    function INFORMA_INSPECCION_AL_WEBSERVICES_automatico_HISOTIRAL(IDTURNO,CODINSPE,ANIO:LONGINT;tabla:string):BOOLEAN;

Function informar_ausentes_TURNO_INDVI(IDT:LONGINT):boolean;
FUNCTION DESCARGAR_PAGOS_POR_NOVEDAD_rango_fecha(TIPO:STRING):BOOLEAN;
function CONTROL_ARCHIVO_PAGOS:boolean;
FUNCTION LEER_TAGS_ARCHIVO_TURNOS_VB(ARCHIVO:STRING):BOOLEAN;
Procedure Inicializa_vb(arhivo_xml:string) ;
function Procesa_archivo_xml_vb:boolean;
function Control_conexion_TestOfBD(Alias, UserName, Password: String; Ageva: boolean):boolean;
 FUNCTION TEST_INFORMAR_FACTURA(archivo,n:string):BOOLEAN;
 Procedure Leer_archivo_informar_facturas_encabezado(archivo:string);
FUNCTION DESCARGAR_PAGOS_POR_NOVEDAD_fecha(TIPO,desde,hasta:STRING):BOOLEAN;
function leer_respuesta_ausentes_turnoid(idt:longint;archivo,TABLA:string):boolean;
FUNCTION informar_factura_ws(pagoidverificacion,
                      NRO_COMPROBANTE,
                      tipo_cbte,
                      idetalle,
                      imp_total,
                      IMP_NETO,
                      IVA21,
                      cae,
                      fecha_vence,
                      tipofactura,
                      fechafactura,
                      b64,m5:string):BOOLEAN;

 function leer_respuesta_informar_verificacion(archivo:string;IDTURNO:LONGINT;men,TABLA:string):boolean;
function INFORMA_INSPECCION_AL_WEBSERVICES_automatico(IDTURNO,CODINSPE,ANIO:LONGINT;tabla:string):BOOLEAN;
function generar_archivo(nombrearchivo:string):boolean;
function leer_respuesta_ausentes(archivo:string):boolean;
Function informar_ausentes:boolean;
FUNCTION  BORRAR_TEMPORAL:BOOLEAN;
FUNCTION DESCARGAR_FERIADO(ANIO:STRING):BOOLEAN;

FUNCTION SELECCION_OPERACION_XML(IDPAGO:LONGINT;estado:string):STRING;

FUNCTION MODIFICA_XML_PAGOS(detallesPago_pagoID,
                           detallesPago_plantaID,
                           detallesPago_importe,
                           detallesPago_estadoAcreditacion,
                           detallesPago_estadoAcreditacionD,
                           detallesPago_pagoGatewayID,
                           detallesPago_tipoBoleta,
                           detallesPago_fechaNovedad,
                           detallesPago_fechaPago:string;
                            datosPersonalesTurno_genero,
                           datosPersonalesTurno_tipoDocumento,
                           datosPersonalesTurno_numeroDocumento,
                           datosPersonalesTurno_numeroCuit,
                           datosPersonalesTurno_nombre,
                           datosPersonalesTurno_apellido,
                           datosPersonalesTurno_razonSocial,
                           contactoTurno_telefonoCelular,
                           contactoTurno_email,
                           contactoTurno_fechaNacimiento,
                           datosPersonales_genero,
                           datosPersonales_tipoDocumento,
                           datosPersonales_numeroDocumento,
                           datosPersonales_numeroCuit,
                           datosPersonales_nombre,
                           datosPersonales_apellido,
                           datosPersonales_razonSocial,
                           datosFacturacion_domicilio,
                           domicilio_calle,
                           domicilio_numero,
                           domicilio_piso,
                           domicilio_departamento,
                           domicilio_localidad,
                           domicilio_provinciaID,
                           domicilio_provincia,
                           domicilio_codigoPostal,
                           datosFacturacion_condicionIva,ARCHIVO_XML:STRING):BOOLEAN;




 FUNCTION  GUARDA_TEMPORAL(informacionPago_pagoID,
                            informacionPago_dominio,
                            informacionPago_gatewayID,
                            informacionPago_entidadID,
                            informacionPago_entidadNombre,
                            informacionPago_fechaPago,
                            informacionPago_importeTotal:STRING;IDPAGODETALLEPAGO:LONGINT;
                            datosReserva_reservaID,
                            DatosReserva_estado,
                            datosReserva_esReve,
                            datosReserva_esReveDia ,
                            datosReserva_fechaReserva,
                            datosReserva_horaReserva,
                            datosReserva_fechaRegistro,
                            datosReserva_plantaID,
                            datosReserva_dominio,
                            datosTitular_genero,
                            DatosTitular_tipoDocumento,
                            datosTitular_numeroDocumento,
                            datosTitular_numeroCuit,
                            datosTitular_nombre,
                            datosTitular_apellido,
                            datosTitular_razonSocial,datosVehiculo_dominio,
                                                  datosVehiculo_marcaID ,
                                                  datosVehiculo_marca ,
                                                  datosVehiculo_tipoID,
                                                  datosVehiculo_tipo,
                                                  datosVehiculo_modeloID,
                                                  datosVehiculo_modelo ,
                                                  numeroChasis_marca ,
                                                  numeroChasis_numero ,
                                                  datosVehiculo_anio ,
                                                  DatosVehiculo_jurisdiccionID ,
                                                  datosVehiculo_jurisdiccion ,
                                                  datosVehiculo_mtm,
                                                  datosVehiculo_valTitular ,
                                                  datosVehiculo_valChasis ,
                                                  datosValidados_marcaID ,
                                                  datosValidados_marca ,
                                                  datosValidados_tipoID ,
                                                  datosValidados_tipo ,
                                                  datosValidados_modeloID  ,
                                                  DatosValidados_modelo ,
                                                  DATosValidados_numeroChasis,
                                                  datosValidados_mtm,datosReserva_estado_DESCRICPION,ARCHIVO_XML:STRING):BOOLEAN;

 function EjecutarYEsperar( sPrograma: String; Visibilidad: Integer ): Integer;
function TRAZAS(MENSAJE:STRING):BOOLEAN;
PROCEDURE PROCESARARCHIVOPAGOS(ARCHIVO:STRING);
FUNCTION DESCARGAR_PAGOS_POR_CODIGO_PAGO(externalReference,codigopago:longint):BOOLEAN;
FUNCTION DESCARGAR_PAGOS_POR_NOVEDAD(TIPO:STRING):BOOLEAN;
Function solicitar_reverificacion(idturno:longint;dominio:string;codinspe:longint):boolean;
Procedure CargarINI;
  FUNCTION CONFIGURAR:BOOLEAN;
  Function Abrir_Seccion:boolean;
 Function ControlServidor:boolean;
 function CONSULTA(TIPO,DATO1,DATO2:STRING;IDSE:LONGINT):BOOLEAN;
 procedure TestOfBD(Alias, UserName, Password: String; Ageva: boolean);
  Function Cerrar_seccion:boolean;
 PROPERTY VER_TURNOID_RELACION:LONGINT READ TURNOID_RELACION;
 PROPERTY VER_MODO_TURNO:STRING READ MODO_TURNO;
PROPERTY VER_esReveDia:STRING READ esReveDia;
PROPERTY VER_esReve:STRING READ esReve;
pROPERTY  VER_ES_REVERIFICACION:STRING READ ES_REVERIFICACION;
Property  ver_respuestaID:string read  respuesTaID;
Property  ver_respuestaMensaje:string  read respuestaMensaje;
Property  ver_turnoID:string  read  turnoID;
Property  ver_estadoID:string read estadoID;
Property  ver_estado:string read estado;
Property  ver_tipoTurno:string read tipoTurno;
Property  ver_fechaTurno:string read fechaTurno;
Property  ver_horaTurno:string read horaTurno;
Property  ver_fechaRegistro:string read fechaRegistro;
Property  ver_fechaNovedad:string read fechaNovedad;
Property  ver_plantaID:string read plantaID;
Property  ver_genero:string read genero;
Property  ver_tipoDocumento:string read tipoDocumento;
Property ver_numeroDocumento:string  read numeroDocumento;
Property  ver_numeroCuit:string read numeroCuit;
Property ver_nombre:string read nombre;
Property ver_apellido:string  read apellido;
Property ver_razonSocial:string  read razonSocial;
Property  ver_domicilio:string read domicilio;
Property ver_calle:string  read calle;
Property  ver_numero:string read numero;
Property ver_piso:string  read piso;
Property ver_departamento:string  read departamento;
Property ver_localidad:string  read localidad;
Property ver_provinciaID:string  read provinciaID;
Property ver_provincia:string  read provincia;
Property ver_codigoPostal:string   read codigoPostal;
Property ver_condicionIva:string read condicionIva;
Property ver_numeroIibb:string  read numeroIibb;
Property ver_telefonoCelular:string  read telefonoCelular;
Property ver_email:string  read email;
Property ver_fechaNacimiento:string  read fechaNacimiento;
Property ver_pagoID:string  read pagoID;
Property ver_gatewayID:string  read gatewayID;
Property ver_entidadID:string  read entidadID;
Property ver_entidadNombre:string  read entidadNombre;
Property ver_fechaPago:string  read fechaPago;
Property ver_importeTotal:string  read importeTotal;
Property ver_importe:string  read importe;
Property ver_estadoAcreditacion:string  read estadoAcreditacion;
Property ver_pagoGatewayID:string  read pagoGatewayID;
Property ver_re_item_turnoID:string  read re_item_turnoID;
Property ver_re_item_plantaID:string  read re_item_plantaID;
Property ver_re_item_estado:string  read re_item_estado;
Property ver_re_item_fechaNovedad:string   read re_item_fechaNovedad;
Property ver_re_datosPago_pagoID:string  read re_datosPago_pagoID;
Property ver_re_datosPago_entidadID:string  read re_datosPago_entidadID;
Property ver_re_datosPago_fechaPago:string  read re_datosPago_fechaPago;
Property ver_re_datosPago_importeTotal:string  read re_datosPago_importeTotal;
Property ver_re_detallesPagoVerificacion_pagoID:string  read re_detallesPagoVerificacion_pagoID;
Property ver_re_detallesPagoVerificacion_importe:string  read re_detallesPagoVerificacion_importe;
Property ver_re_detallesPagoVerificacion_estadoAcreditacion:string  read re_detallesPagoVerificacion_estadoAcreditacion;
Property ver_re_detallesPagoOblea_pagoID:string  read re_detallesPagoOblea_pagoID;
Property ver_re_detallesPagoOblea_importe:string  read re_detallesPagoOblea_importe;
Property ver_re_detallesPagoOblea_estadoAcreditacion:string  read re_detallesPagoOblea_estadoAcreditacion;
Property ver_datosTitular_genero:string  read datosTitular_genero;
Property ver_datosTitular_tipoDocumento:string  read datosTitular_tipoDocumento ;
Property ver_datosTitular_numeroDocumento:string  read datosTitular_numeroDocumento;
Property ver_datosTitular_numeroCuit:string  read datosTitular_numeroCuit;
Property ver_datosTitular_nombre:string  read datosTitular_nombre;
Property ver_datosTitular_apellido:string  read datosTitular_apellido ;
Property ver_datosTitular_razonSocial:string  read datosTitular_razonSocial;
Property ver_datosPersonalesTurno_tipoDocumento:string  read datosPersonalesTurno_tipoDocumento;
Property ver_datosPersonalesTurno_numeroDocumento:string  read datosPersonalesTurno_numeroDocumento;
Property ver_datosPersonalesTurno_numeroCuit :string read datosPersonalesTurno_numeroCuit;
Property ver_datosPersonalesTurno_nombre:string  read datosPersonalesTurno_nombre;
Property ver_datosPersonalesTurno_apellido :string read datosPersonalesTurno_apellido;
Property ver_datosPersonalesTurno_razonSocial :string read datosPersonalesTurno_razonSocial;
Property ver_contactoTurno_telefonoCelular :string read contactoTurno_telefonoCelular;
Property ver_contactoTurno_email :string read contactoTurno_email;
Property ver_contactoTurno_fechaNacimiento:string  read contactoTurno_fechaNacimiento;
Property ver_datosPersonales_genero:string  read datosPersonales_genero;
Property ver_datosPersonales_tipoDocumento:string  read datosPersonales_tipoDocumento;
Property ver_datosPersonales_numeroDocumento:string  read datosPersonales_numeroDocumento;
Property ver_datosPersonales_numeroCuit:string  read datosPersonales_numeroCuit;
Property ver_datosPersonales_nombre:string  read datosPersonales_nombre;
Property ver_datosPersonales_apellido :string read datosPersonales_apellido;
Property ver_datosPersonales_razonSocial:string  read datosPersonales_razonSocial;
Property ver_datosFacturacion_domicilio :string read datosFacturacion_domicilio;
Property  ver_domicilio_calle:string read domicilio_calle;
Property ver_domicilio_numero:string  read domicilio_numero;
Property  ver_domicilio_piso:string read domicilio_piso;
Property ver_domicilio_departamento:string  read domicilio_departamento;
Property ver_domicilio_localidad:string  read domicilio_localidad ;
Property ver_domicilio_provinciaID:string  read domicilio_provinciaID ;
Property ver_domicilio_provincia:string  read domicilio_provincia ;
Property ver_domicilio_codigoPostal:string  read domicilio_codigoPostal;
Property ver_datosFacturacion_condicionIva:string  read datosFacturacion_condicionIva;
Property ver_datosFacturacion_numeroIibb:string  read datosFacturacion_numeroIibb;
Property ver_datosPago_pagoID :string read datosPago_pagoID;
Property ver_datosPago_gatewayID:string   read datosPago_gatewayID;
Property ver_datosPago_entidadID :string read datosPago_entidadID;
Property ver_datosPago_entidadNombre:string  read datosPago_entidadNombre;
PROPERTY VER_HABILITADO_FACTURA:STRING READ HABILITADO_FACTURA;
PROPERTY VER_FECHA_VENCE_CERTIFICADO:STRING  READ FECHA_VENCE_CERTIFICADO;
Property ver_datosPago_fechaPago:string  read datosPago_fechaPago;
Property ver_datosPago_importeTotal :string read datosPago_importeTotal;
Property ver_detallesPagoVerificacion_pagoID:string  read detallesPagoVerificacion_pagoID;
Property ver_detallesPagoVerificacion_importe:string  read detallesPagoVerificacion_importe;
Property ver_detallesPagoVerificacion_estadoAcreditacion:string  read detallesPagoVerificacion_estadoAcreditacion;
Property ver_detallesPagoVerificacion_pagoGatewayID :string read detallesPagoVerificacion_pagoGatewayID;
Property ver_detallesPagoOblea_pagoID :string read detallesPagoOblea_pagoID;
Property ver_detallesPagoOblea_importe :string read detallesPagoOblea_importe;
Property ver_detallesPagoOblea_estadoAcreditacion :string read detallesPagoOblea_estadoAcreditacion;
Property ver_datosVehiculo_dominio:string  read datosVehiculo_dominio;
Property ver_datosVehiculo_marcaID :string read datosVehiculo_marcaID;
Property ver_datosVehiculo_marca :string read datosVehiculo_marca;
Property ver_datosVehiculo_tipoID :string read datosVehiculo_tipoID;
Property ver_datosVehiculo_tipo:string  read datosVehiculo_tipo;
Property ver_datosVehiculo_modeloID:string  read datosVehiculo_modeloID;
Property ver_datosVehiculo_modelo:string  read datosVehiculo_modelo;
Property ver_numeroChasis_marca :string read numeroChasis_marca;
Property ver_numeroChasis_numero:string  read numeroChasis_numero;
Property ver_datosVehiculo_anio:string  read datosVehiculo_anio;
Property ver_datosVehiculo_jurisdiccionID:string  read datosVehiculo_jurisdiccionID;
Property ver_datosVehiculo_jurisdiccion :string read datosVehiculo_jurisdiccion;
Property ver_datosVehiculo_mtm :string read datosVehiculo_mtm;
Property ver_datosVehiculo_valTitular:string  read datosVehiculo_valTitular;
Property ver_datosVehiculo_valChasis:string  read datosVehiculo_valChasis;
Property ver_datosValidados_marcaID :string read datosValidados_marcaID;
Property ver_datosValidados_marca :string read datosValidados_marca;
Property ver_datosValidados_tipoID :string read datosValidados_tipoID;
Property ver_datosValidados_tipo :string read datosValidados_tipo;
Property ver_datosValidados_modeloID:string  read datosValidados_modeloID;
Property ver_datosValidados_modelo :string read datosValidados_modelo;
Property ver_datosValidados_mtm :string read datosValidados_mtm;
PROPERTY VER_DATOSVALIDOS_numeroChasis:STRING READ numeroChasis_VALIDO;
Property ver_TESTING_CONEX:boolean read  TESTING_CONEX;
PROPERTY VER_reservaID:STRING READ reservaID;
Property ver_respuestaidservidor:longint read  respuestaidservidor;
Property ver_respuestamensajeservidor:string read  respuestamensajeservidor;
Property ver_disponibilidad_servidor:string read  disponibilidad_servidor;
property ver_USUARIO:longint read  USUARIO ;
property ver_ingresoID_Abrir:string read ingresoID_Abrir;
property ver_PLANTA:longint read  PLANTA;
property ver_password:string read  PASSWORD;
property ver_hash:string read  hash;

property  ver_respuestaid_Abrir:longint read  respuestaid_Abrir;
property ver_respuestamensaje_Abrir:String read  respuestamensaje_Abrir;
property  ver_sesionID_Abrir:String read  sesionID_Abrir;




property ver_respuestamensaje_informar_factura:string read respuestamensaje_informar_factura;
property ver_respuestaid_informar_factura:string read respuestaid_informar_factura;
property ver_respuestamensaje_factura_informar_factura:string read respuestamensaje_factura_informar_factura;
property ver_respuestaid_factura_informar_factura:string read respuestaid_factura_informar_factura;


property  ver_cantidadPagos:String read  cantidadPagos;
property  ver_respuestaidpago:longint read  respuestaidpago;
property  ver_respuestamensajepago:String read  respuestamensajepago;

PROPERTY VER_ARCHIVOS_XML_PAGOS:STRING READ ARCHIVOS_XML_PAGOS;


property  ver_total_registros_pagos_insertados:longint read  total_registros_pagos_insertados;
function leer_respuesta_reverificacion(archivo:string;IDTURNO:LONGINT;crea:boolean;men,tabla:string):boOLEAN;
Function Informar_Inspeccion(vturnoid,vcodinspe,vanio:longint;tabla:string):boolean;
 FUNCTION ARMA_DATOS_MEDICIONES(vturnoid,vcodinspe,vanio:longint):STRING;
Function arma_formularios(vturnoid,vcodinspe,vanio:longint):STRING;
Function arma_tramite_y_oblea(vturnoid,vcodinspe,vanio:longint):STRING;
Function arma_datos_presentante(vturnoid,vcodinspe,vanio:longint;tabla:string):STRING;
FUNCTION ARMA_DATOS_TITULAR(vturnoid,vcodinspe,vanio:longint;tabla:string):STRING;
FUNCTION ARMA_DATOS_VEHICULOS(vturnoid,vcodinspe,vanio:longint;tabla:string):STRING;
FUNCTION ARMA_DATOS_VERIFICACION(vturnoid,vcodinspe,vanio:longint):STRING;
function Reemplazar_caracteres(cadena:String):string;
Function Devuelve_resultado_revision(codinspe,anio:longint):string;
function devuelve_resultado_items(resultado:String):string;
function arma_fecha_hora(fecha:string):string;
FUNCTION DEVUELVE_OBSERVACIONES(CODINSPE, CAPITULO:LONGINT):STRING;
FUNCTION DEVUELVE_ESTADO_TURNO(IDTURNO:LONGINT):LONGINT;
function INFORMAR_TODOS_LOS_TIPO_5:BOOLEAN;
FUNCTION informar_ausentes_por_id_tipo_5(idturno:longint;tabla:String):boolean;
 Procedure PARAR_SERVICIO_FACTURACION_AFIP;
END;

implementation
   uses Unit1;

   

FUNCTION txml_caba.ARMA_DATOS_MEDICIONES(vturnoid,vcodinspe,vanio:longint):STRING;
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




  Function txml_caba.informar_ausentes_por_id_tipo_5(idturno:longint;tabla:String):boolean;
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
CONFIGURAR;


ControlServidor;

if (ver_disponibilidad_servidor='true') AND (ver_respuestaidservidor=1) THEN
begin

  //ver_respuestamensajeservidor);
  APPLICATION.ProcessMessages;

Abrir_Seccion;
    if self.ver_respuestaid_Abrir=1 then
     begin


  aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
{aq.sql.add('SELECT  TURNOID, DVDOMINO FROM tdatosturno   '+
                     ' WHERE  ausente=''S'' ');  }


aq.sql.add('SELECT  fechaturno FROM   TDATOSTURNO   WHERE turnoid='+inttostr(idturno));

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
    '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(self.ver_ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_PLANTA)+'</plantaI>'+
    '     <fecha xsi:type="xsd:date">'+trim(fecha)+'</fecha>   ';






aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
aq.sql.add('SELECT  COUNT(*) FROM  TDATOSTURNO  WHERE turnoid='+inttostr(idturno));

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


aq.sql.add('SELECT  TURNOID, DVDOMINO FROM  TDATOSTURNO  WHERE turnoid='+inttostr(idturno));

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
FORM1.Memo2.Clear;
 FORM1.Memo2.Lines.LoadFromStream(request);
 FORM1.Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'Enviadoinformarausentes.xml');

recieveID :=HTTPRIO.HTTPWebNode.Send(request);
         //Request

HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response

FORM1.Memo2.Clear;
response.Position := 0;
FORM1.Memo2.Lines.LoadFromStream(response);

FORM1.Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'informarausentes.xml');
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



   function txml_caba.INFORMAR_TODOS_LOS_TIPO_5:BOOLEAN;
VAR aqSININFORMAR5,aqSININFORMAR1:tsqlquery;
CODINSPE,idturno,ANIO:LONGINT;
BEGIN
 aqSININFORMAR5:=tsqlquery.Create(NIL);
 aqSININFORMAR5.SQLConnection:=MYBD;
 aqSININFORMAR5.Close;
 aqSININFORMAR5.SQL.Clear;
 aqSININFORMAR5.SQL.Add('SELECT TURNOID, CODINSPE, ANIO FROM TDATOSTURNO WHERE ESTADOID=5');
 aqSININFORMAR5.ExecSQL;
 aqSININFORMAR5.Open;
 WHILE NOT aqSININFORMAR5.Eof DO
 BEGIN
 idturno:=aqSININFORMAR5.FieldByName('TURNOID').ASINTEGER;

       IF TRIM(aqSININFORMAR5.FieldByName('CODINSPE').AsString)<>'' THEN
          BEGIN
             CODINSPE:=aqSININFORMAR5.FieldByName('CODINSPE').ASINTEGER;

             ANIO:=aqSININFORMAR5.FieldByName('ANIO').ASINTEGER;

             aqSININFORMAR1:=tsqlquery.create(nil);
             aqSININFORMAR1.SQLConnection := MyBD;
             aqSININFORMAR1.sql.add('select inspfina from tinspeccion where codinspe='+inttostr(CODINSPE));
             aqSININFORMAR1.ExecSQL;
             aqSININFORMAR1.open;
              IF TRIM(aqSININFORMAR1.FIELDBYNAME('inspfina').ASSTRING)='S' THEN
                  INFORMA_INSPECCION_AL_WEBSERVICES_automatico(idturno,CODINSPE,anio,'TDATOSTURNOHISTORIAL')
                  ELSE
                  informar_ausentes_por_id_tipo_5(idturno,'TDATOSTURNOHISTORIAL');


             aqSININFORMAR1.Close;
             aqSININFORMAR1.Free;


          END ELSE
          informar_ausentes_por_id_tipo_5(idturno,'TDATOSTURNOHISTORIAL');




     aqSININFORMAR5.Next;
 END;

  aqSININFORMAR5.Close;
  aqSININFORMAR5.Free;


END;



FUNCTION txml_caba.DEVUELVE_OBSERVACIONES(CODINSPE, CAPITULO:LONGINT):STRING;
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

Function txml_caba.Devuelve_resultado_revision(codinspe,anio:longint):string;
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

function txml_caba.devuelve_resultado_items(resultado:String):string;
begin
    if  trim(resultado)='A' then
       devuelve_resultado_items:='A';

    if  trim(resultado)='R' then
       devuelve_resultado_items:='R';

    if  trim(resultado)='C' then
       devuelve_resultado_items:='C';


end;



function txml_caba.Reemplazar_caracteres(cadena:String):string;
begin

  cadena:= StringReplace(cadena, '�', 'a',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, '�', 'e',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, '�', 'i',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, '�', 'o',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, '�', 'u',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, '�', 'A',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, '�', 'E',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, '�', 'I',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, '�', 'O',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, '�', 'U',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, '�', 'n',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, '�', 'N',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, '&', '',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, ';', '',[rfReplaceAll, rfIgnoreCase]);
    cadena:= StringReplace(cadena, '�', 'A',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, '�', 'E',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, '�', 'I',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, '�', 'O',[rfReplaceAll, rfIgnoreCase]) ;
  cadena:= StringReplace(cadena, '�', 'U',[rfReplaceAll, rfIgnoreCase]) ;

  cadena:= StringReplace(cadena, '�', 'a',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, '�', 'e',[rfReplaceAll, rfIgnoreCase]) ;
  cadena:= StringReplace(cadena, '�', 'i',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, '�', 'o',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, '�', 'u',[rfReplaceAll, rfIgnoreCase]);

  cadena:= StringReplace(cadena, '�', 'u',[rfReplaceAll, rfIgnoreCase]);
  cadena:= StringReplace(cadena, '�', 'U',[rfReplaceAll, rfIgnoreCase]);
   cadena:= StringReplace(cadena, '''', '',[rfReplaceAll, rfIgnoreCase]);
   cadena:= StringReplace(cadena, '�', '',[rfReplaceAll, rfIgnoreCase]);
    cadena:= StringReplace(cadena, '<', '',[rfReplaceAll, rfIgnoreCase]);
     cadena:= StringReplace(cadena, '>', '',[rfReplaceAll, rfIgnoreCase]);
       cadena:= StringReplace(cadena, '/', '',[rfReplaceAll, rfIgnoreCase]);
      cadena:= StringReplace(cadena, '�', 'nio',[rfReplaceAll, rfIgnoreCase]);
     cadena:= StringReplace(cadena, '�', '',[rfReplaceAll, rfIgnoreCase]);
     cadena:= StringReplace(cadena, '�', '',[rfReplaceAll, rfIgnoreCase]);
     cadena:= StringReplace(cadena, '�', '',[rfReplaceAll, rfIgnoreCase]);
     cadena:= StringReplace(cadena, '�', '',[rfReplaceAll, rfIgnoreCase]);
     cadena:= StringReplace(cadena, '�', '',[rfReplaceAll, rfIgnoreCase]);
     cadena:= StringReplace(cadena, '�', 'O',[rfReplaceAll, rfIgnoreCase]);
     cadena:= StringReplace(cadena, '�', 'i',[rfReplaceAll, rfIgnoreCase]);

 Reemplazar_caracteres:=TRIM(CADENA);

end;

 function txml_caba.arma_fecha_hora(fecha:string):string;
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


FUNCTION txml_caba.ARMA_DATOS_VERIFICACION(vturnoid,vcodinspe,vanio:longint):STRING;
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
                    ARMA_DATOS_MEDICIONES(vturnoid,vcodinspe,vanio)+
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
                ARMA_DATOS_MEDICIONES(vturnoid,vcodinspe,vanio)+
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



FUNCTION txml_caba.ARMA_DATOS_VEHICULOS(vturnoid,vcodinspe,vanio:longint;tabla:string):STRING;
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

   FUNCTION txml_caba.ARMA_DATOS_TITULAR(vturnoid,vcodinspe,vanio:longint;tabla:string):STRING;
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



 Function txml_caba.arma_datos_presentante(vturnoid,vcodinspe,vanio:longint;tabla:string):STRING;
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
   if aq.IsEmpty then
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


             if (trim(aq.fieldbyname('CODPOSTA').asstring)<>'') and (trim(aq.fieldbyname('CODPOSTA').asstring)<>'0') then
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




Function txml_caba.arma_tramite_y_oblea(vturnoid,vcodinspe,vanio:longint):STRING;
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



Function txml_caba.solicitar_reverificacion(idturno:longint;dominio:string;codinspe:longint):boolean;
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





fecha:=datetostr(date);
fecha:=copy(trim(fecha),7,4)+'-'+copy(trim(fecha),4,2)+'-'+copy(trim(fecha),1,2);







XML:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '+
      'xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv"> '+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:solicitarTurnoReverificacion soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
            '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(self.ver_ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_PLANTA)+'</plantaID>'+
         '<turnoID xsi:type="xsd:unsignedLong">'+INTTOSTR(IDTURNO)+'</turnoID>'+
         '<dominio xsi:type="xsd:string">'+TRIM(DOMINIO)+'</dominio>'+
     '</urn:solicitarTurnoReverificacion>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';




strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');
 FORM1.Memo2.Clear;
  FORM1.Memo2.Lines.LoadFromStream(request);
  FORM1.Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'SolicitarReve'+inttostr(codinspe)+'.xml');

recieveID :=HTTPRIO.HTTPWebNode.Send(request);
         //Request

HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response

 FORM1.Memo2.Clear;
response.Position := 0;
 FORM1.Memo2.Lines.LoadFromStream(response);

 FORM1.Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'Recibidoreve'+inttostr(codinspe)+'.xml');
strings.Free;
request.Free;
response.Free;

solicitar_reverificacion:=true;
 except
  solicitar_reverificacion:=falsE;

 end;




 end;


 function txml_caba.leer_respuesta_reverificacion(archivo:string;IDTURNO:LONGINT;crea:boolean;men,tabla:string):boolean;
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
    insertasql:=TSQLQuery.Create(NIL);
   insertasql.SQLConnection:=mybd;
  insertasql.Close;
  insertasql.SQL.Clear;

   insertasql.SQL.Add(' insert into TDATOSTURNO (TURNOID, '+
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
'PLANTA  , '+#39+trim(r)+#39+'  from TDATOSTURNO where turnoid='+inttostr(IDTURNO));
  insertasql.ExecSQL ;


  end;




 updatesql:=TSQLQuery.Create(NIL);
  updatesql.SQLConnection:=mybd;
  updatesql.Close;
  updatesql.SQL.Clear;

   updatesql.SQL.Add(' update TDATOSTURNO set turnoid='+inttostr(codturnoreve)+' where  turnoid='+inttostr(IDTURNO)+' and tipoinspe=''R'' ');

   updatesql.ExecSQL ;






  if trim(men)='S' then
   begin
   FORM1.memo1.Lines.Add('RESPUESTA DE SUIVTV: '+respuesta);
APPLICATION.ProcessMessages;

end;

end;



function txml_caba.INFORMA_INSPECCION_AL_WEBSERVICES_automatico(IDTURNO,CODINSPE,ANIO:LONGINT;tabla:string):BOOLEAN;
var patente:string;
 updatesql:TSQLQuery;
begin

CONFIGURAR;


ControlServidor;

if (ver_disponibilidad_servidor='true') AND (ver_respuestaidservidor=1) THEN
begin

  //ver_respuestamensajeservidor);
  APPLICATION.ProcessMessages;

Abrir_Seccion;
    if self.ver_respuestaid_Abrir=1 then
     begin
           if idturno < 0 then
            begin
              updatesql:=TSQLQuery.Create(NIL);
              updatesql.SQLConnection:=mybd;
              updatesql.Close;
              updatesql.SQL.Clear;
              updatesql.SQL.Add(' select dvdomino from TDATOSTURNO where turnoid='+inttostr(idturno));
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
                                             leer_respuesta_reverificacion(ExtractFilePath(Application.ExeName)+'Recibidoreve'+inttostr(codinspe)+'.txt',IDTURNO,false,'N',tabla);
                                                 if codturnoreve<>-1 then
                                                    IDTURNO:=codturnoreve;  

                                         end;  

                                   end;


                          end;  



               end;    //<0





          if SELF.Informar_Inspeccion(IDTURNO,CODINSPE,ANIO,tabla) =true then
            begin
                    while   fileexists(ExtractFilePath(Application.ExeName) +'RecibioCodinspe'+inttostr(CODINSPE)+'.xml')=false do
                       begin

                            application.ProcessMessages;
                       end;


                 if   fileexists(ExtractFilePath(Application.ExeName) +'RecibioCodinspe'+inttostr(CODINSPE)+'.xml')=true then
                      begin

                          if generar_archivo('RecibioCodinspe'+inttostr(CODINSPE))=true then
                             begin
                             

                                leer_respuesta_informar_verificacion(ExtractFilePath(Application.ExeName)+'RecibioCodinspe'+inttostr(CODINSPE)+'.txt',IDTURNO,'N','TDATOSTURNO');

                              end;

                       end;


            end else
             begin

             end;   //self.respuestamensaje_Abrir;

Cerrar_seccion;
end
else
begin

end;




end;




end;


function txml_caba.INFORMA_INSPECCION_AL_WEBSERVICES_automatico_HISOTIRAL(IDTURNO,CODINSPE,ANIO:LONGINT;tabla:string):BOOLEAN;
var patente:string;
 updatesql:TSQLQuery;
begin

CONFIGURAR;


ControlServidor;

if (ver_disponibilidad_servidor='true') AND (ver_respuestaidservidor=1) THEN
begin

  //ver_respuestamensajeservidor);
  APPLICATION.ProcessMessages;

Abrir_Seccion;
    if self.ver_respuestaid_Abrir=1 then
     begin
          //TDATOSTURNOHISTORIAL


          if SELF.Informar_Inspeccion(IDTURNO,CODINSPE,ANIO,tabla) =true then
            begin
                    while   fileexists(ExtractFilePath(Application.ExeName) +'RecibioCodinspe'+inttostr(CODINSPE)+'.xml')=false do
                       begin

                            application.ProcessMessages;
                       end;


                 if   fileexists(ExtractFilePath(Application.ExeName) +'RecibioCodinspe'+inttostr(CODINSPE)+'.xml')=true then
                      begin

                          if generar_archivo('RecibioCodinspe'+inttostr(CODINSPE))=true then
                             begin
                             

                                leer_respuesta_informar_verificacion(ExtractFilePath(Application.ExeName)+'RecibioCodinspe'+inttostr(CODINSPE)+'.txt',IDTURNO,'N','TDATOSTURNOHISTORIAL');

                              end;

                       end;


            end else
             begin

             end;   //self.respuestamensaje_Abrir;

Cerrar_seccion;
end
else
begin

end;




end;




end;


function txml_caba.leer_respuesta_informar_verificacion(archivo:string;IDTURNO:LONGINT;men,TABLA:string):boolean;
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





       respuesta:=codmensaje+' '+respuesta+'. La inspecci�n no ser� informada.';




    end;
     aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
    IF TRIM(INFORME)='SI' THEN
   aQ.SQL.Add('UPDATE '+TRIM(TABLA)+' SET INFORMADOWS='+#39+TRIM(INFORME)+#39+', MOTIVO='+#39+TRIM(respuesta)+#39+', ESTADOID='+INTTOSTR(ESTADOID)+' WHERE TURNOID='+INTTOSTR(IDTURNO))
   ELSE
   aQ.SQL.Add('UPDATE '+TRIM(TABLA)+' SET INFORMADOWS='+#39+TRIM(INFORME)+#39+', MOTIVO='+#39+TRIM(respuesta)+#39+' WHERE TURNOID='+INTTOSTR(IDTURNO));


   aq.ExecSQL;
AQ.Close;
AQ.FREE;
  if trim(men)='S' then
  begin
   FORM1.memo1.Lines.Add('RESPUESTA DE SUIVTV: '+respuesta);
APPLICATION.ProcessMessages;

   end;
end;


FUNCTION txml_caba.DEVUELVE_ESTADO_TURNO(IDTURNO:LONGINT):LONGINT;
VAR   updatesql:TSQLQuery;
CODINSPE, ANIO:LONGINT;
BEGIN
           updatesql:=TSQLQuery.Create(NIL);
           updatesql.SQLConnection:=mybd;
           updatesql.Close;
           updatesql.SQL.Clear;
           updatesql.SQL.Add(' select CODINSPE, ANIO FROM  tdatosturno where turnoid='+inttostr(idturno));
           updatesql.open ;
           CODINSPE:=updatesql.fieldbyname('CODINSPE').ASINTEGER;
           ANIO:=updatesql.fieldbyname('ANIO').ASINTEGER;
           updatesql.Close;
           updatesql.Free;



           updatesql:=TSQLQuery.Create(NIL);
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



Function txml_caba.arma_formularios(vturnoid,vcodinspe,vanio:longint):STRING;
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




Function txml_caba.Informar_Inspeccion(vturnoid,vcodinspe,vanio:longint;tabla:string):boolean;
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
FORM1.Memo3.Clear;
FORM1.Memo2.Clear;
try

xml:='<?xml version="1.0" encoding="ISO-8859-1"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" '+
     'xmlns:ns1="urn:suvtv" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '+
      'SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
     '<SOAP-ENV:Body>'+
      '<ns1:informarVerificacion>'+
      '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_USUARIO)+'</usuarioID>'+
      '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(self.ver_ingresoID_Abrir)+'</ingresoID>'+
      '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_PLANTA)+'</plantaID>'+
      '<turnoID xsi:type="xsd:unsignedLong">'+inttostr(vTURNOID)+'</turnoID>';


    COLA:='</ns1:informarVerificacion>'+
          '</SOAP-ENV:Body>'+
          '</SOAP-ENV:Envelope>';


ARCHIVO:=XML+arma_formularios(vturnoid,vcodinspe,vanio)+arma_tramite_y_oblea(vturnoid,vcodinspe,vanio)+
         arma_datos_presentante(vturnoid,vcodinspe,vanio,tabla)+ARMA_DATOS_VERIFICACION(vturnoid,vcodinspe,vanio)+
         ARMA_DATOS_TITULAR(vturnoid,vcodinspe,vanio,tabla)+
         ARMA_DATOS_VEHICULOS(vturnoid,vcodinspe,vanio,tabla)+COLA;



strings := TStringList.Create;
strings.Text := ARCHIVO;




request := TStringStream.Create(strings.GetText);



response := TStringStream.Create('');

FORM1.Memo2.Clear;
request.Position := 0;
FORM1.Memo2.Lines.LoadFromStream(request);
FORM1.Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'Envioinspeccion'+inttostr(vcodinspe)+'.xml');
FORM1.Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'Envioinspeccion'+inttostr(vcodinspe)+'.txt');

recieveID :=HTTPRIO.HTTPWebNode.Send(request);           //Request

HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response

FORM1.Memo2.Clear;
response.Position := 0;
FORM1.Memo2.Lines.LoadFromStream(response);


FORM1.Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'RecibioCodinspe'+inttostr(vcodinspe)+'.xml');
strings.Free;
request.Free;
response.Free ;
Informar_Inspeccion:=true;

except
  Informar_Inspeccion:=false;
end;

end;



Function txml_caba.ControlServidor:boolean;

var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
     TESTING:boolean;
     xml:string;
     Memoxml:tmemo;
     MyText: TStringlist;



begin
try

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



recieveID :=HTTPRIO.HTTPWebNode.Send(request);           //Request

HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response

response.Position := 0;


  MyText:= TStringlist.create;
  MyText.LoadFromStream(response);
  MyText.SaveToFile(ExtractFilePath(Application.ExeName) +'ECO.xml');
  MyText.SaveToFile(ExtractFilePath(Application.ExeName) +'ECO.txt');
  MyText.Free;

strings.Free;
request.Free;
response.Free;

LeerArchivoEco;

EXCEPT
 on E : Exception do
   BEGIN
     respuestaidservidor :=-500;

   disponibilidad_servidor:='false' ;
    TRAZAS('ERROR EN FUNCION ControlServidor. '+E.ClassName+'. error : '+E.Message);
   END;

END;


end;



Procedure txml_caba.CargarINI;
var INI: TIniFile;
T:sTRING;
begin
TRY
  if not FileExists( ExtractFilePath( Application.ExeName ) + 'config.ini' ) then
    Exit;


    INI := TINIFile.Create( ExtractFilePath( Application.ExeName ) + 'config.ini' );
    NOMBRE_PLANTA:=INI.ReadString( 'WEBSERVICES', 'NOMBRE_PLANTA', 'APPLUS' );
    PLANTA:= INI.ReadInteger( 'WEBSERVICES', 'PLANTA', 0 );
    USUARIO:= INI.ReadInteger( 'WEBSERVICES', 'USUARIO', 0 );
    PASSWORD:= INI.ReadString( 'WEBSERVICES', 'PASSWORD', '' );
    HASH:= INI.ReadString( 'WEBSERVICES', 'HASH', '' );
    T:=INI.ReadString( 'WEBSERVICES', 'TESTING', 'TRUE' );
    ESSERVIDOR:=INI.ReadString( 'WEBSERVICES', 'ES_SERVIDOR', 'N' );
    HABILITADO_FACTURA:=INI.ReadString( 'FAE', 'FACTURA', 'N' );
    FECHA_VENCE_CERTIFICADO:=INI.ReadString( 'FAE', 'FECHA_VENCE_CERTIFICADO', 'N' );
    IF TRIM(T)='TRUE' THEN
    BEGIN
     MODO_TURNO:='T';
     TESTING_CONEX:=TRUE;
     END ELSE
     BEGIN
      MODO_TURNO:='P';
      TESTING_CONEX:=FALSe;
     END;

    HORA_CIERRE:='20:00:00';


  INI.Free;
EXCEPT
 on E : Exception do
   BEGIN

    TRAZAS('ERROR AL LEER EL ARCHIVO DE CONFIGURACION CONFIG.INI. '+E.ClassName+'. error : '+E.Message);
   END;

END;


end;



Procedure txml_caba.PARAR_SERVICIO_FACTURACION_AFIP;
var INI: TIniFile;
T:sTRING;
begin
TRY
  if not FileExists( ExtractFilePath( Application.ExeName ) + 'config.ini' ) then
    Exit;


      INI := TINIFile.Create( ExtractFilePath( Application.ExeName ) + 'config.ini' );

      INI.WriteString( 'FAE', 'FACTURA', 'N');

     INI.Free;
EXCEPT
 on E : Exception do
   BEGIN

    TRAZAS('ERROR AL ESCRIBIR EL ARCHIVO DE CONFIGURACION CONFIG.INI. '+E.ClassName+'. error : '+E.Message);
   END;

END;


end;

function txml_caba.TRAZAS(MENSAJE:STRING):BOOLEAN;
VAR ARCHIVO:TEXTFILE;
DESTINO,LINEA,F,F1,F2,F3:STRING;
BEGIN
F1:=COPY(DATETOSTR(DATE),1,2);
F2:=COPY(DATETOSTR(DATE),4,2);
F3:=COPY(DATETOSTR(DATE),7,4);

F:=F1+F2+F3;
DESTINO:=ExtractFilePath( Application.ExeName ) +'TRAZAS\TRAZA_'+F+'.TXT';

ASSIGNFILE(ARCHIVO,DESTINO);

IF not FileExists(DESTINO) THEN
BEGIN
    REWRITE(ARCHIVO);
    CLOSEFILE(ARCHIVO);
END;

LINEA:=DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+':'+MENSAJE;

APPEND(ARCHIVO);
WRITELN(ARCHIVO, LINEA);
CLOSEFILE(ARCHIVO);


FORM1.EnviarMensaje_TRAZAS('martin.bien@applus.com',LINEA,inttostr(self.ver_pLanta));
FORM1.EnviarMensaje_TRAZAS('lucas.suarez@applus.com',LINEA,inttostr(self.ver_pLanta));
END;



FUNCTION txml_caba.GARRDAR_XML_PAGOS(detallesPago_pagoID,
                           detallesPago_plantaID,
                           detallesPago_importe,
                           detallesPago_estadoAcreditacion,
                           detallesPago_estadoAcreditacionD,
                           detallesPago_pagoGatewayID,
                           detallesPago_tipoBoleta,
                           detallesPago_fechaNovedad,
                           detallesPago_fechaPago:string;
                            datosPersonalesTurno_genero,
                           datosPersonalesTurno_tipoDocumento,
                           datosPersonalesTurno_numeroDocumento,
                           datosPersonalesTurno_numeroCuit,
                           datosPersonalesTurno_nombre,
                           datosPersonalesTurno_apellido,
                           datosPersonalesTurno_razonSocial,
                           contactoTurno_telefonoCelular,
                           contactoTurno_email,
                           contactoTurno_fechaNacimiento,
                           datosPersonales_genero,
                           datosPersonales_tipoDocumento,
                           datosPersonales_numeroDocumento,
                           datosPersonales_numeroCuit,
                           datosPersonales_nombre,
                           datosPersonales_apellido,
                           datosPersonales_razonSocial,
                           datosFacturacion_domicilio,
                           domicilio_calle,
                           domicilio_numero,
                           domicilio_piso,
                           domicilio_departamento,
                           domicilio_localidad,
                           domicilio_provinciaID,
                           domicilio_provincia,
                           domicilio_codigoPostal,
                           datosFacturacion_condicionIva,ARCHIVO_XML,detallesPago_pagoForzado,detallesPago_codigoPago:STRING):BOOLEAN;



var idpagoverificacionbuscar:longint ;
aq,aqinsertadetallepago,aqtfactura,aqinsertaINFORMACIONPAGO,aqinsertaDATOSRESERVAS,AQTEMPORAL,aqsecuencial,aqguardaxml:tsqlquery;
CODCLIENTECONTACTO,iddetallepagos:longint;
FACTURADO,NRODOC,NOMBRECLIENTE ,APELLIDOCLIENTE,GENERO,SSQL_INFORMACION_PAGO:STRING;
FECHANOVEDAD,DIA,MES,ANNIO,FECHAPAGO,TIPOFACT,SSQL,FECHAPAGO_INFORMACION_PAGO:STRING;
FECHARESERVA,FECHAREGISTRO_RESERVA,SSQL_DATOS_RESERVAS,informacionPago_importeTotal:STRING;
IDPLANTA:LONGINT;
TD: TTransactionDesc;

IDINFORMACIONPAGO,IDDATOSRESERVA:longint;
CODCLIENTETITULAR,CODVEHICULO,CODCLIENTEFACTURACION:LONGINT;

TMP_PAGOID,TIPOCOMPROBANTEAFIP:STRING;
TMP_DOMINIO	:STRING;
TMP_GATEWAYID	:STRING;
TMP_ENTIDADID	:STRING;
TMP_ENTIDADNOMBRE	:STRING;
TMP_FECHAPAGO	:STRING;
TMP_IMPORTETOTAL	:STRING;
TMP_RESERVAID	:STRING;
TMP_ESTADO:STRING;
TMP_ESREVE	:STRING;
TMP_ESREVEDIA	:STRING;
TMP_FECHARESERVA	:STRING;
TMP_HORARESERVA	:STRING;
TMP_FECHAREGISTRO	:STRING;
TMP_PLANTAID	:STRING;
TMP_DOMINIO_RESERVA	:STRING;
TMP_TITULAR_GENERO	:STRING;
TMP_TITULAR_TIPODOCUMENTO	:STRING;
TMP_TITULAR_NRODOCUMENTO :STRING;
TMP_TITULAR_CUIT	:STRING;
TMP_TITULAR_NOMBRE	:STRING;
TMP_TITULAR_APELLIDO	:STRING;
TMP_TITULAR_RAZONSOCIAL	:STRING;
TMP_VEHICULO_DOMINIO	:STRING;
TMP_VEHICULO_MARCAID	:STRING;
TMP_VEHICULO_MARCA	:STRING;
TMP_VEHICULO_TIPOID	:STRING;
TMP_VEHICULOO_TIPO	:STRING;
TMP_VEHICULO_MODELOID	:STRING;
TMP_VEHICULO_MODELO	:STRING;
TMP_VEHICULO_NUMEROCHASIS	:STRING;
TMP_VEHICULO_ANIO	:STRING;
TMP_VEHICULO_JURIDISCIONID	:STRING;
TMP_VEHICULO_JURIDISCION	:STRING;
TMP_VEHICULO_MTM	:STRING;
TMP_VEHICULO_VALTITULAR	:STRING;
TMP_VEHICULO_VALCHASIS	:STRING;
TMP_VALIDO_MARCAID	:STRING;
TMP_VALIDO_MARCA:STRING;
TMP_VALIDO_TIPOID	:STRING;
TMP_VALIDO_TIPO	:STRING;
TMP_VALIDO_MODELOID	:STRING;
TMP_VALIDO_MODELO:STRING;
TMP_VALIDO_NUMEROCHASIS:STRING;
TMP_VALIDO_MTM,TMP_ESTADORESERVAD:STRING;

 idseccion:longint;

BEGIN
TRY

     idpagoverificacionbuscar:=STRTOINT(detallesPago_pagoID);

   aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aq.sql.add('SELECT  * FROM tdetallespago   '+
                      ' WHERE '+
                      ' pagoid = '+INTTOSTR(idpagoverificacionbuscar)+' AND ESTADOACREDITACION='+#39+TRIM(detallesPago_estadoAcreditacion)+#39);

   aq.ExecSQL;
   aq.open;
if aq.IsEmpty then
   BEGIN

   try


       IDPLANTA:=STRTOINT(detallesPago_plantaID);

       IF SELF.ver_PLANTA<>IDPLANTA THEN
        EXIT;


        {DATOS PARA DETALLEPAGOS}

         {obtengo el secuenciador de la tabla tdetallespago}
           aqinsertadetallepago:=tsqlquery.create(nil);
           aqinsertadetallepago.SQLConnection := MyBD;
           aqinsertadetallepago.sql.add('select  SQ_DETALLESPAGO_IDDETALLEPAGO.nextval as iddetallepago from dual');
           aqinsertadetallepago.ExecSQL;
           aqinsertadetallepago.open;
           iddetallepagos:=aqinsertadetallepago.fieldbyname('iddetallepago').asinteger;

           aqinsertadetallepago.CLOSE;
           aqinsertadetallepago.Free;

           {SI EXISTE EN TFACTURAS PONEMOS FACTURADO =S SINO EXISTE FACTURADO=N}
           {para facturas electronicas}
           if trim(detallesPago_estadoAcreditacion)='A' then
            begin
              aqtfactura:=tsqlquery.create(nil);
              aqtfactura.SQLConnection := MyBD;
              aqtfactura.sql.add('select  * from tfacturas where idpago='+inttostr(idpagoverificacionbuscar));
              aqtfactura.ExecSQL;
              aqtfactura.open;
               if not aqtfactura.IsEmpty then
                  FACTURADO:='S'
                  ELSE
                  FACTURADO:='N';


              aqtfactura.CLOSE;
              aqtfactura.FREE;

           end;

              //Exeptuado de Cobro
           if trim(detallesPago_estadoAcreditacion)='E' then
               FACTURADO:='N';

           {para notas de creditos}
            if trim(detallesPago_estadoAcreditacion)='D' then
            begin
              aqtfactura:=tsqlquery.create(nil);
              aqtfactura.SQLConnection := MyBD;
              aqtfactura.sql.add('select  * from tfacturas where idpago='+inttostr(idpagoverificacionbuscar)+' and codcofac is null');
              aqtfactura.ExecSQL;
              aqtfactura.open;
               if not aqtfactura.IsEmpty then
                  FACTURADO:='N'
                  ELSE
                  FACTURADO:='X';


              aqtfactura.CLOSE;
              aqtfactura.FREE;

            end;




            {OBTENGO EL CODCLIENTECONTACTO}

           {  GENERO:=TRIM(datosPersonalesTurno_genero);




            IF TRIM(datosPersonalesTurno_tipoDocumento)='9' THEN
             BEGIN
                  IF TRIM(datosPersonalesTurno_numeroCuit)<>'' THEN
                     NRODOC:=TRIM(datosPersonalesTurno_numeroCuit)
                     ELSE
                      NRODOC:=TRIM(datosPersonalesTurno_numeroDocumento);


             END else
               NRODOC:=TRIM(datosPersonalesTurno_numeroDocumento);



              IF  (TRIM(datosPersonalesTurno_tipoDocumento)='0') AND (TRIM(GENERO)='PJ') THEN
                  NRODOC:=TRIM(datosPersonalesTurno_numeroCuit);



             IF TRIM(datosPersonalesTurno_razonSocial)<>'' THEN
             BEGIN
               NOMBRECLIENTE:=TRIM(datosPersonalesTurno_razonSocial);
                 APELLIDOCLIENTE:='.';
             END  ELSE
               BEGIN
                  NOMBRECLIENTE:=TRIM(datosPersonalesTurno_nombre);
                  APELLIDOCLIENTE:=TRIM(datosPersonalesTurno_apellido);
               END;



               IF TRIM(NOMBRECLIENTE)='' THEN
                      NOMBRECLIENTE:='.';

                 IF TRIM(APELLIDOCLIENTE)='' THEN
                      APELLIDOCLIENTE:='.';




             if (trim(datosFacturacion_condicionIva)='R') then
                BEGIN
                      IF TRIM(detallesPago_estadoAcreditacion)='A' THEN
                      BEGIN
                        tipofact:='A';
                        TIPOCOMPROBANTEAFIP:='FA';
                      END;

                      IF TRIM(detallesPago_estadoAcreditacion)='D' THEN
                      BEGIN
                        tipofact:='A';

                        TIPOCOMPROBANTEAFIP:='CA';
                      END;




               END else
               BEGIN
                  IF (TRIM(detallesPago_estadoAcreditacion)='A') OR (TRIM(detallesPago_estadoAcreditacion)='E') THEN
                     BEGIN
                        TIPOCOMPROBANTEAFIP:='FB';
                       tipofact:='B';
                     END;

                      IF TRIM(detallesPago_estadoAcreditacion)='D' THEN
                       BEGIN
                        tipofact:='B';
                        TIPOCOMPROBANTEAFIP:='CB';
                       END;

                END;


                IF TRIM(domicilio_codigoPostal)='' THEN
                 domicilio_codigoPostal:='1000';


             TRY
             CODCLIENTECONTACTO:=Devuelve_codclienV2(NRODOC,
                                     NOMBRECLIENTE ,
                                     APELLIDOCLIENTE ,
                                     domicilio_calle ,
                                     domicilio_numero,
                                     domicilio_departamento,
                                     domicilio_localidad,
                                     domicilio_provincia ,
                                     domicilio_codigoPostal,GENERO,datosPersonalesTurno_tipoDocumento,tipofact,datosFacturacion_condicionIva);
              EXCEPT

              on E : Exception do
             begin
              TRAZAS('OBTENIENDO CODCLIENTECONTACTO. '+E.ClassName+' error : IDPAGO: '+INTTOSTR(idpagoverificacionbuscar)+' '+E.Message+'. archivo: '+ARCHIVO_XML);
               CODCLIENTECONTACTO:=0;
             end;
              END;  }


              
             if (trim(datosFacturacion_condicionIva)='R') then
                BEGIN
                      IF TRIM(detallesPago_estadoAcreditacion)='A' THEN
                      BEGIN
                        tipofact:='A';
                        TIPOCOMPROBANTEAFIP:='FA';
                      END;

                      IF TRIM(detallesPago_estadoAcreditacion)='D' THEN
                      BEGIN
                        tipofact:='A';

                        TIPOCOMPROBANTEAFIP:='CA';
                      END;




               END else
               BEGIN
                  IF (TRIM(detallesPago_estadoAcreditacion)='A') OR (TRIM(detallesPago_estadoAcreditacion)='E') THEN
                     BEGIN
                        TIPOCOMPROBANTEAFIP:='FB';
                       tipofact:='B';
                     END;

                      IF TRIM(detallesPago_estadoAcreditacion)='D' THEN
                       BEGIN
                        tipofact:='B';
                        TIPOCOMPROBANTEAFIP:='CB';
                       END;

                END;


                

              dia:=copy(trim(detallesPago_fechaNovedad),9,2);
              mes:=copy(trim(detallesPago_fechaNovedad),6,2);
              annio:=copy(trim(detallesPago_fechaNovedad),1,4);
              FECHANOVEDAD:=dia+'/'+mes+'/'+annio;

               IF (TRIM(FECHANOVEDAD)='//') THEN
                  FECHANOVEDAD:=DATETOSTR(DATE);




              dia:=copy(trim(detallesPago_fechaPago),9,2);
              mes:=copy(trim(detallesPago_fechaPago),6,2);
              annio:=copy(trim(detallesPago_fechaPago),1,4);
              FECHAPAGO:=dia+'/'+mes+'/'+annio;


                IF (TRIM(FECHAPAGO)='//') THEN
                  FECHAPAGO:=DATETOSTR(DATE);





              {FIN DETALLE PAGOS}


           //****************************************************************************************

              {fin datos TDATRESERVAS}
            if (not MyBD.InTransaction) then MyBD.StartTransaction(td);
             // MyBD.StartTransaction(TD);
              TRY
                {INSERTA EN DETALLES PAGOS}

                  SSQL:=' INSERT INTO TDETALLESPAGO (IDDETALLESPAGO,PAGOID,PLANTAID,IMPORTE, ESTADOACREDITACION, '+
                                          ' ESTADOACREDITACIOND,PAGOGATEWAYID,TIPOBOLETA,FECHANOVEDAD, '+
                                          ' FECHAPAGO,FACTURADO,TIPOCOMPROBANTEAFIP,EMAIL,CODCLIENTECONTACTO,CONDICIONIVA,CODIGOPAGO,PAGOFORZADO) '+
                                          '  VALUES ('+INTTOSTR(iddetallepagos)+','+INTTOSTR(idpagoverificacionbuscar)+
                                          ','+INTTOSTR(IDPLANTA)+','+#39+TRIM(detallesPago_importe)+#39+
                                          ','+#39+TRIM(detallesPago_estadoAcreditacion)+#39+
                                          ','+#39+TRIM(detallesPago_estadoAcreditacionD)+#39+
                                          ','+#39+TRIM(detallesPago_pagoGatewayID)+#39+
                                          ','+#39+TRIM(detallesPago_tipoBoleta)+#39+
                                          ',to_date('+#39+trim(FECHANOVEDAD)+#39+',''dd/mm/yyyy'')'+
                                          ',to_date('+#39+trim(FECHAPAGO)+#39+',''dd/mm/yyyy'')'+
                                          ','+#39+TRIM(FACTURADO)+#39+','+#39+TRIM(TIPOCOMPROBANTEAFIP)+#39+','+#39+TRIM(contactoTurno_email)+#39+
                                          ','+INTTOSTR(CODCLIENTECONTACTO)+
                                          ','+#39+trim(datosFacturacion_condicionIva)+#39+
                                          ','+#39+trim(detallesPago_codigoPago)+#39+
                                          ','+#39+trim(detallesPago_pagoForzado)+#39+')';

                aqinsertadetallepago:=tsqlquery.create(nil);
                aqinsertadetallepago.SQLConnection := MyBD;
                aqinsertadetallepago.sql.add(SSQL);
                aqinsertadetallepago.ExecSQL;

                {FIN INSERTA EN DETALLES PAGOS}


                {guarda_xml}
                idseccion:=strtoint(self.ver_ingresoID_Abrir);
                aqguardaxml:=tsqlquery.create(nil);
                aqguardaxml.SQLConnection := MyBD;
                aqguardaxml.sql.add('insert  into tarchivos_xml_pagos (iddetallespago,externalreference,idseccion,fechadescarga,archivo) '+
                                    ' values ('+inttostr(iddetallepagos)+','+inttostr(idpagoverificacionbuscar)+
                                    ','+inttostr(idseccion)+',sysdate,'+#39+trim(ARCHIVO_XML)+#39+')');
                aqguardaxml.ExecSQL;

                {}


                 {INSERTA EN INFORAMCIONPAGO}
                  AQTEMPORAL:=tsqlquery.create(nil);
                  AQTEMPORAL.SQLConnection := MyBD;
                  AQTEMPORAL.sql.add('SELECT * FROM TMP_XML_INFORMACIONPAGO WHERE IDPAGODETALLEPAGO='+INTTOSTR(idpagoverificacionbuscar));
                  AQTEMPORAL.ExecSQL;
                  AQTEMPORAL.Open;
                  WHILE NOT AQTEMPORAL.Eof DO
                  BEGIN

                      TMP_PAGOID:=TRIM(AQTEMPORAL.FIELDBYNAME('PAGOID').AsString);
                      TMP_DOMINIO	:=TRIM(AQTEMPORAL.FIELDBYNAME('DOMINIO').AsString);
                      TMP_GATEWAYID	:=TRIM(AQTEMPORAL.FIELDBYNAME('GATEWAYID').AsString);
                      TMP_ENTIDADID	:=TRIM(AQTEMPORAL.FIELDBYNAME('ENTIDADID').AsString);
                      TMP_ENTIDADNOMBRE	:=TRIM(AQTEMPORAL.FIELDBYNAME('ENTIDADNOMBRE').AsString);
                      TMP_FECHAPAGO	:=TRIM(AQTEMPORAL.FIELDBYNAME('FECHAPAGO').AsString);
                      TMP_IMPORTETOTAL	:=TRIM(AQTEMPORAL.FIELDBYNAME('IMPORTETOTAL').AsString);
                      TMP_RESERVAID	:=TRIM(AQTEMPORAL.FIELDBYNAME('RESERVAID').AsString);
                      TMP_ESTADO:=TRIM(AQTEMPORAL.FIELDBYNAME('ESTADO').AsString);
                      TMP_ESREVE	:=TRIM(AQTEMPORAL.FIELDBYNAME('ESREVE').AsString);
                      TMP_ESREVEDIA  	:=TRIM(AQTEMPORAL.FIELDBYNAME('ESREVEDIA').AsString);
                      TMP_FECHARESERVA	:=TRIM(AQTEMPORAL.FIELDBYNAME('FECHARESERVA').AsString);
                      TMP_HORARESERVA	:=TRIM(AQTEMPORAL.FIELDBYNAME('HORARESERVA').AsString);
                      TMP_FECHAREGISTRO	:=TRIM(AQTEMPORAL.FIELDBYNAME('FECHAREGISTRO').AsString);
                      TMP_PLANTAID	:=TRIM(AQTEMPORAL.FIELDBYNAME('PLANTAID').AsString);
                      TMP_DOMINIO_RESERVA	:=TRIM(AQTEMPORAL.FIELDBYNAME('DOMINIO_RESERVA').AsString);
                      TMP_TITULAR_GENERO	:=TRIM(AQTEMPORAL.FIELDBYNAME('TITULAR_GENERO').AsString);
                      TMP_TITULAR_TIPODOCUMENTO	:=TRIM(AQTEMPORAL.FIELDBYNAME('TITULAR_TIPODOCUMENTO').AsString);
                      TMP_TITULAR_NRODOCUMENTO :=TRIM(AQTEMPORAL.FIELDBYNAME('TITULAR_NRODOCUMENTO').AsString);
                      TMP_TITULAR_CUIT	:=TRIM(AQTEMPORAL.FIELDBYNAME('TITULAR_CUIT').AsString);
                      TMP_TITULAR_NOMBRE	:=TRIM(AQTEMPORAL.FIELDBYNAME('TITULAR_NOMBRE').AsString);
                      TMP_TITULAR_APELLIDO	:=TRIM(AQTEMPORAL.FIELDBYNAME('TITULAR_APELLIDO').AsString);
                      TMP_TITULAR_RAZONSOCIAL	:=TRIM(AQTEMPORAL.FIELDBYNAME('TITULAR_RAZONSOCIAL').AsString);
                      TMP_VEHICULO_DOMINIO	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_DOMINIO').AsString);
                      TMP_VEHICULO_MARCAID	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_MARCAID').AsString);
                      TMP_VEHICULO_MARCA	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_MARCA').AsString);
                      TMP_VEHICULO_TIPOID	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_TIPOID').AsString);
                      TMP_VEHICULOO_TIPO	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULOO_TIPO').AsString);
                      TMP_VEHICULO_MODELOID	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_MODELOID').AsString);
                      TMP_VEHICULO_MODELO	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_MODELO').AsString);
                      TMP_VEHICULO_NUMEROCHASIS	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_NUMEROCHASIS').AsString);
                      TMP_VEHICULO_ANIO	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_ANIO').AsString);
                      TMP_VEHICULO_JURIDISCIONID	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_JURIDISCIONID').AsString);
                      TMP_VEHICULO_JURIDISCION	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_JURIDISCION').AsString);
                      TMP_VEHICULO_MTM	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_MTM').AsString);
                      TMP_VEHICULO_VALTITULAR	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_VALTITULAR').AsString);
                      TMP_VEHICULO_VALCHASIS	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_VALCHASIS').AsString);
                      TMP_VALIDO_MARCAID	:=TRIM(AQTEMPORAL.FIELDBYNAME('VALIDO_MARCAID').AsString);
                      TMP_VALIDO_MARCA:=TRIM(AQTEMPORAL.FIELDBYNAME('VALIDO_MARCA').AsString);
                      TMP_VALIDO_TIPOID	:=TRIM(AQTEMPORAL.FIELDBYNAME('VALIDO_TIPOID').AsString);
                      TMP_VALIDO_TIPO	:=TRIM(AQTEMPORAL.FIELDBYNAME('VALIDO_TIPO').AsString);
                      TMP_VALIDO_MODELOID	:=TRIM(AQTEMPORAL.FIELDBYNAME('VALIDO_MODELOID').AsString);
                      TMP_VALIDO_MODELO:=TRIM(AQTEMPORAL.FIELDBYNAME('VALIDO_MODELO').AsString);
                      TMP_VALIDO_NUMEROCHASIS:=TRIM(AQTEMPORAL.FIELDBYNAME('VALIDO_NUMEROCHASIS').AsString);
                      TMP_VALIDO_MTM:=TRIM(AQTEMPORAL.FIELDBYNAME('VALIDO_MTM').AsString);
                      TMP_ESTADORESERVAD:=TRIM(AQTEMPORAL.FIELDBYNAME('ESTADORESERVAD').AsString);


                     TMP_IMPORTETOTAL := StringReplace(TMP_IMPORTETOTAL, '.', ',',
                                                     [rfReplaceAll, rfIgnoreCase]);



                      {DATOS PARA INformacion pago}



                    aqsecuencial:=tsqlquery.create(nil);
                    aqsecuencial.SQLConnection := MyBD;
                    aqsecuencial.sql.add('select  SQ_INFOPAGO_IDINFORMACIONPAGO.nextval as IDINFORMACIONPAGO from dual');
                    aqsecuencial.ExecSQL;
                    aqsecuencial.open;
                    IDINFORMACIONPAGO:=aqsecuencial.fieldbyname('IDINFORMACIONPAGO').asinteger;

                    aqsecuencial.CLOSE;
                    aqsecuencial.Free;


                 //CLIENTE TITULAR

                  GENERO:='';
                  NRODOC:='';
                  NOMBRECLIENTE:='';
                  APELLIDOCLIENTE:='';

                  GENERO:=TRIM(TMP_TITULAR_GENERO);

                   IF TRIM(TMP_TITULAR_TIPODOCUMENTO)='9' THEN
                    BEGIN
                      IF TRIM(TMP_TITULAR_CUIT)<>'' THEN
                         NRODOC:=TRIM(TMP_TITULAR_CUIT)
                         ELSE
                         NRODOC:=TRIM(TMP_TITULAR_NRODOCUMENTO);

                    END else
                    NRODOC:=TRIM(TMP_TITULAR_NRODOCUMENTO);


              IF  (TRIM(TMP_TITULAR_TIPODOCUMENTO)='0') AND (TRIM(GENERO)='PJ') THEN
                  NRODOC:=TRIM(TMP_TITULAR_CUIT);




                     IF TRIM(TMP_TITULAR_RAZONSOCIAL)<>'' THEN
                     BEGIN
                       NOMBRECLIENTE:=TRIM(TMP_TITULAR_RAZONSOCIAL);
                       APELLIDOCLIENTE:='.';
                     END  ELSE
                     BEGIN
                       NOMBRECLIENTE:=TRIM(TMP_TITULAR_NOMBRE);
                       APELLIDOCLIENTE:=TRIM(TMP_TITULAR_APELLIDO);
                    END;


                     IF TRIM(NOMBRECLIENTE)='' THEN
                        NOMBRECLIENTE:='.';

                     IF TRIM(APELLIDOCLIENTE)='' THEN
                        APELLIDOCLIENTE:='.';


                        if (trim(datosFacturacion_condicionIva)='R') then
                            tipofact:='A'
                            else
                            tipofact:='B';


                       IF TRIM(domicilio_codigoPostal)='' THEN
                               domicilio_codigoPostal:='1000';


                        TRY
                          CODCLIENTETITULAR:=Devuelve_codclienV2(NRODOC,
                                     NOMBRECLIENTE ,
                                     APELLIDOCLIENTE ,
                                     domicilio_calle ,
                                     domicilio_numero,
                                     domicilio_departamento,
                                     domicilio_localidad,
                                     domicilio_provincia ,
                                     domicilio_codigoPostal,GENERO,TMP_TITULAR_TIPODOCUMENTO,tipofact,datosFacturacion_condicionIva);

                       EXCEPT

                           on E : Exception do
                            begin
                              TRAZAS('OBTENIENDO CODCLIENTETITULAR. '+E.ClassName+' error : IDPAGO: '+INTTOSTR(idpagoverificacionbuscar)+' '+E.Message+'. archivo: '+ARCHIVO_XML);
                              CODCLIENTETITULAR:=0;
                            end;
                      END;


                            dia:=copy(trim(TMP_FECHAPAGO),1,2);
                            mes:=copy(trim(TMP_FECHAPAGO),4,2);
                            annio:=copy(trim(TMP_FECHAPAGO),7,4);
                            FECHAPAGO_INFORMACION_PAGO:=dia+'/'+mes+'/'+annio;


                           IF (TRIM(FECHAPAGO_INFORMACION_PAGO)='//') THEN
                              FECHAPAGO_INFORMACION_PAGO:=DATETOSTR(DATE);






          //CLIENTE FACTURACION

              GENERO:='';
              NRODOC:='';
              NOMBRECLIENTE:='';
              APELLIDOCLIENTE:='';

             GENERO:=TRIM(datosPersonales_genero);




            IF TRIM(datosPersonales_tipoDocumento)='9' THEN
            BEGIN
                 IF TRIM(datosPersonales_numeroCuit)<>'' THEN
                     NRODOC:=TRIM(datosPersonales_numeroCuit)
                     ELSE
                     NRODOC:=TRIM(datosPersonales_numeroDocumento);

            END else
               NRODOC:=TRIM(datosPersonales_numeroDocumento);


                      
              IF  (TRIM(datosPersonales_tipoDocumento)='0') AND (TRIM(GENERO)='PJ') THEN
                  NRODOC:=TRIM(datosPersonales_numeroCuit);




             IF TRIM(datosPersonales_razonSocial)<>'' THEN
             BEGIN
               NOMBRECLIENTE:=TRIM(datosPersonales_razonSocial);
               APELLIDOCLIENTE:='.';
             END  ELSE
               BEGIN
                  NOMBRECLIENTE:=TRIM(datosPersonales_nombre);
                  APELLIDOCLIENTE:=TRIM(datosPersonales_apellido);
               END;


                IF TRIM(NOMBRECLIENTE)='' THEN
                      NOMBRECLIENTE:='.';

                 IF TRIM(APELLIDOCLIENTE)='' THEN
                      APELLIDOCLIENTE:='.';




             if (trim(datosFacturacion_condicionIva)='R') then
                tipofact:='FACA'
                else
                tipofact:='FACB';



              IF TRIM(domicilio_codigoPostal)='' THEN
                 domicilio_codigoPostal:='1000';


           TRY
          CODCLIENTEFACTURACION:=Devuelve_codclienV2(NRODOC,
                                     NOMBRECLIENTE ,
                                     APELLIDOCLIENTE ,
                                     domicilio_calle ,
                                     domicilio_numero,
                                     domicilio_departamento,
                                     domicilio_localidad,
                                     domicilio_provincia ,
                                     domicilio_codigoPostal,GENERO,datosPersonales_tipoDocumento,tipofact,datosFacturacion_condicionIva);


             CODCLIENTECONTACTO:=CODCLIENTEFACTURACION;

           // CODCLIENTECONTACTO

           EXCEPT
             on E : Exception do
             begin
              TRAZAS('OBTENIENDO CODCLIENTEFACTURACION. '+E.ClassName+' error : IDPAGO: '+INTTOSTR(idpagoverificacionbuscar)+' '+E.Message+'. archivo: '+ARCHIVO_XML);
               CODCLIENTEFACTURACION:=0;
             end;

           END;
                       IF TRIM(TMP_VEHICULO_NUMEROCHASIS)='' THEN
                       TMP_VEHICULO_NUMEROCHASIS:='0000000';

                        CODVEHICULO:=Devuelve_codvehiculo(uppercase(TMP_VEHICULO_DOMINIO),
                                                          uppercase(TMP_VEHICULO_NUMEROCHASIS),
                                                          uppercase(TMP_VEHICULOO_TIPO),
                                                          uppercase(TMP_VEHICULO_MARCA),
                                                          uppercase(TMP_VEHICULO_MODELO) ,
                                                           strtoint(TMP_VEHICULO_ANIO));




                 if CODCLIENTETITULAR=0 then
                    CODCLIENTETITULAR:=CODCLIENTEFACTURACION;



                      SSQL_INFORMACION_PAGO:='INSERT INTO TINFORMACIONPAGO  '+
                                       ' (IDINFORMACIONPAGO,IDDETALLESPAGO,CODCLIENTETITULAR,CODVEHICULO, '+
                                       '  CODCLIENTEFACTURACION,PAGOID,DOMINIO, '+
                                       '  GATEWAYID,ENTIDADID,ENTIDADNOMBRE,FECHAPAGO,IMPORTETOTAL,tipodocufactelec) '+
                                       ' VALUES ('+INTTOSTR(IDINFORMACIONPAGO)+','+INTTOSTR(iddetallepagos)+
                                       ','+INTTOSTR(CODCLIENTETITULAR)+','+INTTOSTR(CODVEHICULO)+
                                       ','+INTTOSTR(CODCLIENTEFACTURACION)+','+#39+TRIM(TMP_PAGOID)+#39+
                                       ','+#39+TRIM(TMP_DOMINIO)+#39+','+#39+TRIM(TMP_GATEWAYID)+#39+
                                       ','+#39+TRIM(TMP_ENTIDADID)+#39+','+#39+TRIM(TMP_ENTIDADNOMBRE)+#39+
                                       ',to_date('+#39+trim(FECHAPAGO_INFORMACION_PAGO)+#39+',''dd/mm/yyyy'')'+
                                       ','+FLOATTOSTR(STRTOFLOAT(TMP_IMPORTETOTAL))+','+inttostr(strtoint(datosPersonales_tipoDocumento))+')';


                     aqinsertaINFORMACIONPAGO:=tsqlquery.create(nil);
                     aqinsertaINFORMACIONPAGO.SQLConnection := MyBD;
                     aqinsertaINFORMACIONPAGO.sql.add(SSQL_INFORMACION_PAGO);
                     aqinsertaINFORMACIONPAGO.ExecSQL;

                   {FIN INFORMACION PAGO}



                   {datosreservas}

                   //CODIGO VEHICULO



                        aqsecuencial:=tsqlquery.create(nil);
                        aqsecuencial.SQLConnection := MyBD;
                        aqsecuencial.sql.add('select  SQ_DATOSRESERVA_IDRESERVA.nextval as IDDATOSRESERVA from dual');
                        aqsecuencial.ExecSQL;
                        aqsecuencial.open;
                        IDDATOSRESERVA:=aqsecuencial.fieldbyname('IDDATOSRESERVA').asinteger;
                        aqsecuencial.CLOSE;
                        aqsecuencial.Free;



                       dia:=copy(trim(TMP_FECHARESERVA),1,2);
                       mes:=copy(trim(TMP_FECHARESERVA),4,2);
                       annio:=copy(trim(TMP_FECHARESERVA),7,4);
                       FECHARESERVA:=dia+'/'+mes+'/'+annio;
                        IF (TRIM(FECHARESERVA)='//') THEN
                            FECHARESERVA:=DATETOSTR(DATE);



                        dia:=copy(trim(TMP_FECHAREGISTRO),1,2);
                        mes:=copy(trim(TMP_FECHAREGISTRO),4,2);
                        annio:=copy(trim(TMP_FECHAREGISTRO),7,4);
                        FECHAREGISTRO_RESERVA:=dia+'/'+mes+'/'+annio;



                           IF (TRIM(FECHAREGISTRO_RESERVA)='//') THEN
                               FECHAREGISTRO_RESERVA:=DATETOSTR(DATE);

                         {  IF TRIM(TMP_ESREVE)='' THEN
                                 TMP_ESREVE:='N'
                               ELSE
                                TMP_ESREVE:='S';


                         IF TRIM(TMP_ESREVEDIA)='' THEN
                              TMP_ESREVEDIA:='N'
                           ELSE
                               TMP_ESREVEDIA:='S'; }



                           SSQL_DATOS_RESERVAS:='INSERT INTO TDATRESERVA (IDDATOSRESERVA,IDDETALLESPAGO,RESERVAID,ESTADO,'+
                                     'ESREVE,ESREVEDIA,FECHARESERVA,HORARESERVA, '+
                                     'FECHAREGISTRO,PLANTAID,DOMINIO,ESTADORESERVAD)'+
                                     'VALUES ('+INTTOSTR(IDDATOSRESERVA)+','+INTTOSTR(iddetallepagos)+
                                     ','+INTTOSTR(STRTOINT(TMP_RESERVAID))+','+#39+TRIM(TMP_ESTADO)+#39+
                                     ','+#39+TRIM(TMP_ESREVE)+#39+','+#39+TRIM(TMP_ESREVEDIA)+#39+
                                     ',to_date('+#39+trim(FECHARESERVA)+#39+',''dd/mm/yyyy'')'+
                                     ','+#39+TRIM(TMP_HORARESERVA)+#39+
                                     ',to_date('+#39+TRIM(FECHAREGISTRO_RESERVA)+#39+',''dd/mm/yyyy'')'+
                                     ','+#39+TRIM(TMP_PLANTAID)+#39+','+#39+TRIM(TMP_DOMINIO_RESERVA)+#39+','+#39+TRIM(TMP_ESTADORESERVAD)+#39+')';



                aqinsertaDATOSRESERVAS:=tsqlquery.create(nil);
                aqinsertaDATOSRESERVAS.SQLConnection := MyBD;
                aqinsertaDATOSRESERVAS.sql.add(SSQL_DATOS_RESERVAS);
                aqinsertaDATOSRESERVAS.ExecSQL;


                   {fin datosreservas}


                      AQTEMPORAL.Next;
                  END;










              MYBD.Commit(TD);
               EXCEPT

                 on E : Exception do
                 BEGIN
                 MyBD.Rollback(TD);
                  TRAZAS('ERROR REALIZAR INSERT '+E.ClassName+' error : IDPAGO: '+INTTOSTR(idpagoverificacionbuscar)+' '+E.Message+'. archivo: '+ARCHIVO_XML);

                  END;

              END;
          aqinsertadetallepago.CLOSE;
          aqinsertadetallepago.FREE;
          aqinsertaINFORMACIONPAGO.CLOSE;
          aqinsertaINFORMACIONPAGO.FREE;
          aqinsertaDATOSRESERVAS.CLOSE;
          aqinsertaDATOSRESERVAS.FREE;
          AQGUARDAXML.Close;
          AQGUARDAXML.Free;


          AQTEMPORAL.Close;
          AQTEMPORAL.Free;


     except
          on E : Exception do
             TRAZAS('ERROR GENERAL EN FUNCION GUARDAR PAGOS. '+E.ClassName+' error : IDPAGO: '+INTTOSTR(idpagoverificacionbuscar)+' '+E.Message+'. archivo: '+ARCHIVO_XML);


     end;




      end;







  aq.close;
  aq.free;

  EXCEPT
   on E : Exception do
   BEGIN
    respuestaidpago:=-661;
    TRAZAS('ERROR EN GUARDAR EL XML EN LAS TABLAS. FUNCION:GARRDAR_XML_PAGOS IDPAGO:'+detallesPago_pagoID+'. '+E.ClassName+'. error : '+E.Message+'. archivo: '+ARCHIVO_XML);
   END;

END;

END;


FUNCTION txml_caba.SELECCION_OPERACION_XML(IDPAGO:LONGINT;estado:string):STRING;
VAR  aq,aq1:tsqlquery;
existe:boolean; iddetallespago:longint;
BEGIN
existe:=false;
   aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aq.sql.add('SELECT  iddetallespago FROM tdetallespago   '+
                      ' WHERE '+
                      ' pagoid = '+INTTOSTR(IDPAGO)+' AND  estadoacreditacion='+#39+TRIM(estado)+#39);

   aq.ExecSQL;
   aq.open;
   while not aq.Eof do
   begin
      existe:=true;
      iddetallespago:=aq.fieldbyname('iddetallespago').AsInteger;
      break;
      aq.Next;
   end;

 if existe=false then
      SELECCION_OPERACION_XML:='INSERTA'
   else
    SELECCION_OPERACION_XML:='MODIFICA';

    
   {
    if existe=true then
    begin
          aq1:=tsqlquery.create(nil);
          aq1.SQLConnection := MyBD;
          aq1.sql.add('SELECT  * FROM TINFORMACIONPAGO   '+
                      ' WHERE iddetallespago='+inttostr(iddetallespago);

          aq1.ExecSQL;
          aq1.open;
          existe:=false;
             while not aq1.Eof do
                begin
                 existe:=true;

                 break;
                 aq1.Next;
                end;

               if existe=true then
               begin
                 SELECCION_OPERACION_XML:='MODIFICA';

               end else
                  SELECCION_OPERACION_XML:='INSERTA';

         aq1.Close;
         aq1.FREE;

    end else
    begin

      SELECCION_OPERACION_XML:='INSERTA';
    end;
    }

   { if aq.RecordCount = 0 then
    begin





    end   ELSE
       SELECCION_OPERACION_XML:='MODIFICA';
       }
   aq.Close;
   aq.FREE;

    //TINFORMACIONPAGO

END;


FUNCTION txml_caba.MODIFICA_XML_PAGOS(detallesPago_pagoID,
                           detallesPago_plantaID,
                           detallesPago_importe,
                           detallesPago_estadoAcreditacion,
                           detallesPago_estadoAcreditacionD,
                           detallesPago_pagoGatewayID,
                           detallesPago_tipoBoleta,
                           detallesPago_fechaNovedad,
                           detallesPago_fechaPago:string;
                            datosPersonalesTurno_genero,
                           datosPersonalesTurno_tipoDocumento,
                           datosPersonalesTurno_numeroDocumento,
                           datosPersonalesTurno_numeroCuit,
                           datosPersonalesTurno_nombre,
                           datosPersonalesTurno_apellido,
                           datosPersonalesTurno_razonSocial,
                           contactoTurno_telefonoCelular,
                           contactoTurno_email,
                           contactoTurno_fechaNacimiento,
                           datosPersonales_genero,
                           datosPersonales_tipoDocumento,
                           datosPersonales_numeroDocumento,
                           datosPersonales_numeroCuit,
                           datosPersonales_nombre,
                           datosPersonales_apellido,
                           datosPersonales_razonSocial,
                           datosFacturacion_domicilio,
                           domicilio_calle,
                           domicilio_numero,
                           domicilio_piso,
                           domicilio_departamento,
                           domicilio_localidad,
                           domicilio_provinciaID,
                           domicilio_provincia,
                           domicilio_codigoPostal,
                           datosFacturacion_condicionIva,ARCHIVO_XML:STRING):BOOLEAN;



var idpagoverificacionbuscar:longint ;
aq,aqinsertadetallepago,aqtfactura,aqinsertaINFORMACIONPAGO,aqinsertaDATOSRESERVAS,AQTEMPORAL,aqsecuencial:tsqlquery;
CODCLIENTECONTACTO,iddetallepagos:longint;
FACTURADO,NRODOC,NOMBRECLIENTE ,APELLIDOCLIENTE,GENERO,SSQL_INFORMACION_PAGO:STRING;
FECHANOVEDAD,DIA,MES,ANNIO,FECHAPAGO,TIPOFACT,SSQL,FECHAPAGO_INFORMACION_PAGO:STRING;
FECHARESERVA,FECHAREGISTRO_RESERVA,SSQL_DATOS_RESERVAS,informacionPago_importeTotal:STRING;
IDPLANTA:LONGINT;
TD: TTransactionDesc;

IDINFORMACIONPAGO,IDDATOSRESERVA:longint;
CODCLIENTETITULAR,CODVEHICULO,CODCLIENTEFACTURACION:LONGINT;

TMP_PAGOID,TIPOCOMPROBANTEAFIP:STRING;
TMP_DOMINIO	:STRING;
TMP_GATEWAYID	:STRING;
TMP_ENTIDADID	:STRING;
TMP_ENTIDADNOMBRE	:STRING;
TMP_FECHAPAGO	:STRING;
TMP_IMPORTETOTAL	:STRING;
TMP_RESERVAID	:STRING;
TMP_ESTADO:STRING;
TMP_ESREVE	:STRING;
TMP_ESREVEDIA	:STRING;
TMP_FECHARESERVA	:STRING;
TMP_HORARESERVA	:STRING;
TMP_FECHAREGISTRO	:STRING;
TMP_PLANTAID	:STRING;
TMP_DOMINIO_RESERVA	:STRING;
TMP_TITULAR_GENERO	:STRING;
TMP_TITULAR_TIPODOCUMENTO	:STRING;
TMP_TITULAR_NRODOCUMENTO :STRING;
TMP_TITULAR_CUIT	:STRING;
TMP_TITULAR_NOMBRE	:STRING;
TMP_TITULAR_APELLIDO	:STRING;
TMP_TITULAR_RAZONSOCIAL	:STRING;
TMP_VEHICULO_DOMINIO	:STRING;
TMP_VEHICULO_MARCAID	:STRING;
TMP_VEHICULO_MARCA	:STRING;
TMP_VEHICULO_TIPOID	:STRING;
TMP_VEHICULOO_TIPO	:STRING;
TMP_VEHICULO_MODELOID	:STRING;
TMP_VEHICULO_MODELO	:STRING;
TMP_VEHICULO_NUMEROCHASIS	:STRING;
TMP_VEHICULO_ANIO	:STRING;
TMP_VEHICULO_JURIDISCIONID	:STRING;
TMP_VEHICULO_JURIDISCION	:STRING;
TMP_VEHICULO_MTM	:STRING;
TMP_VEHICULO_VALTITULAR	:STRING;
TMP_VEHICULO_VALCHASIS	:STRING;
TMP_VALIDO_MARCAID	:STRING;
TMP_VALIDO_MARCA:STRING;
TMP_VALIDO_TIPOID	:STRING;
TMP_VALIDO_TIPO	:STRING;
TMP_VALIDO_MODELOID	:STRING;
TMP_VALIDO_MODELO:STRING;
TMP_VALIDO_NUMEROCHASIS:STRING;
TMP_VALIDO_MTM,TMP_ESTADORESERVAD:STRING;

 idseccion:longint;
 aqguardaxml:tsqlquery;
BEGIN
TRY

     idpagoverificacionbuscar:=STRTOINT(detallesPago_pagoID);

   aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aq.sql.add('SELECT  iddetalleSpago FROM tdetallespago   '+
                      ' WHERE '+
                      ' pagoid = '+INTTOSTR(idpagoverificacionbuscar)+' AND ESTADOACREDITACION='+#39+TRIM(detallesPago_estadoAcreditacion)+#39);


   aq.ExecSQL;
   aq.open;
if not aq.IsEmpty then
   BEGIN

   try
       iddetallepagos:=AQ.FIELDBYNAME('iddetalleSpago').ASINTEGER;

       IDPLANTA:=STRTOINT(detallesPago_plantaID);

       IF SELF.ver_PLANTA<>IDPLANTA THEN
        EXIT;


        {DATOS PARA DETALLEPAGOS}



           {SI EXISTE EN TFACTURAS PONEMOS FACTURADO =S SINO EXISTE FACTURADO=N}
          { if trim(detallesPago_estadoAcreditacion)='A' THEN
            BEGIN
             aqtfactura:=tsqlquery.create(nil);
             aqtfactura.SQLConnection := MyBD;
             aqtfactura.sql.add('select  * from tfacturas where idpago='+inttostr(idpagoverificacionbuscar));
             aqtfactura.ExecSQL;
             aqtfactura.open;
              if aqtfactura.recordcount > 0 then
                FACTURADO:='S'
                ELSE
                 FACTURADO:='N';


             aqtfactura.CLOSE;
             aqtfactura.FREE;

            END;
            }

            {OBTENGO EL CODCLIENTECONTACTO}

             GENERO:=TRIM(datosPersonalesTurno_genero);




            IF TRIM(datosPersonalesTurno_tipoDocumento)='9' THEN
             BEGIN
                  IF TRIM(datosPersonalesTurno_numeroCuit)<>'' THEN
                     NRODOC:=TRIM(datosPersonalesTurno_numeroCuit)
                     ELSE
                      NRODOC:=TRIM(datosPersonalesTurno_numeroDocumento);


             END else
               NRODOC:=TRIM(datosPersonalesTurno_numeroDocumento);


               IF (TRIM(datosPersonalesTurno_tipoDocumento)='0') AND (TRIM(GENERO)='PJ') THEN
                  NRODOC:=TRIM(datosPersonalesTurno_numeroCuit);





             IF TRIM(datosPersonalesTurno_razonSocial)<>'' THEN
             BEGIN
               NOMBRECLIENTE:=TRIM(datosPersonalesTurno_razonSocial);
                 APELLIDOCLIENTE:='.';
             END  ELSE
               BEGIN
                  NOMBRECLIENTE:=TRIM(datosPersonalesTurno_nombre);
                  APELLIDOCLIENTE:=TRIM(datosPersonalesTurno_apellido);
               END;



               IF TRIM(NOMBRECLIENTE)='' THEN
                      NOMBRECLIENTE:='.';

                 IF TRIM(APELLIDOCLIENTE)='' THEN
                      APELLIDOCLIENTE:='.';




             if (trim(datosFacturacion_condicionIva)='R') then
                BEGIN
                      IF TRIM(detallesPago_estadoAcreditacion)='A' THEN
                      BEGIN
                        tipofact:='A';
                        TIPOCOMPROBANTEAFIP:='FA';
                      END;

                      IF TRIM(detallesPago_estadoAcreditacion)='D' THEN
                      BEGIN
                        tipofact:='A';

                        TIPOCOMPROBANTEAFIP:='CA';
                      END;




               END else
               BEGIN
                  IF TRIM(detallesPago_estadoAcreditacion)='A' THEN
                     BEGIN
                        TIPOCOMPROBANTEAFIP:='FB';
                       tipofact:='B';
                     END;

                      IF TRIM(detallesPago_estadoAcreditacion)='D' THEN
                       BEGIN
                        tipofact:='B';
                        TIPOCOMPROBANTEAFIP:='CB';
                       END;

                END;


                IF TRIM(domicilio_codigoPostal)='' THEN
                 domicilio_codigoPostal:='1000';


             TRY
             CODCLIENTECONTACTO:=Devuelve_codclienV2(NRODOC,
                                     NOMBRECLIENTE ,
                                     APELLIDOCLIENTE ,
                                     domicilio_calle ,
                                     domicilio_numero,
                                     domicilio_departamento,
                                     domicilio_localidad,
                                     domicilio_provincia ,
                                     domicilio_codigoPostal,GENERO,datosPersonalesTurno_tipoDocumento,tipofact,datosFacturacion_condicionIva);
              EXCEPT

              on E : Exception do
             begin
              TRAZAS('OBTENIENDO CODCLIENTECONTACTO. '+E.ClassName+' error : IDPAGO: '+INTTOSTR(idpagoverificacionbuscar)+' '+E.Message+'.archivo: '+ARCHIVO_XML);
               CODCLIENTECONTACTO:=0;
             end;
              END;


              dia:=copy(trim(detallesPago_fechaNovedad),9,2);
              mes:=copy(trim(detallesPago_fechaNovedad),6,2);
              annio:=copy(trim(detallesPago_fechaNovedad),1,4);
              FECHANOVEDAD:=dia+'/'+mes+'/'+annio;

               IF (TRIM(FECHANOVEDAD)='//') THEN
                  FECHANOVEDAD:=DATETOSTR(DATE);




              dia:=copy(trim(detallesPago_fechaPago),9,2);
              mes:=copy(trim(detallesPago_fechaPago),6,2);
              annio:=copy(trim(detallesPago_fechaPago),1,4);
              FECHAPAGO:=dia+'/'+mes+'/'+annio;


                IF (TRIM(FECHAPAGO)='//') THEN
                  FECHAPAGO:=DATETOSTR(DATE);














              {FIN DETALLE PAGOS}


           //****************************************************************************************

              {fin datos TDATRESERVAS}
            if (not MyBD.InTransaction) then MyBD.StartTransaction(td);
             // MyBD.StartTransaction(TD);
              TRY
                {UPDate EN DETALLES PAGOS}

                  SSQL:=' UPDATE TDETALLESPAGO  set '+
                                          '  PAGOID='+INTTOSTR(idpagoverificacionbuscar)+
                                          ', PLANTAID='+INTTOSTR(IDPLANTA)+', IMPORTE='+#39+TRIM(detallesPago_importe)+#39+
                                          ', ESTADOACREDITACION='+#39+TRIM(detallesPago_estadoAcreditacion)+#39+
                                          ', ESTADOACREDITACIOND='+#39+TRIM(detallesPago_estadoAcreditacionD)+#39+
                                          ', PAGOGATEWAYID='+#39+TRIM(detallesPago_pagoGatewayID)+#39+
                                          ', TIPOBOLETA='+#39+TRIM(detallesPago_tipoBoleta)+#39+
                                          ', FECHANOVEDAD=to_date('+#39+trim(FECHANOVEDAD)+#39+',''dd/mm/yyyy'')'+
                                         // ', FECHAPAGO=to_date('+#39+trim(FECHAPAGO)+#39+',''dd/mm/yyyy'')'+
                                          ', TIPOCOMPROBANTEAFIP='+#39+TRIM(TIPOCOMPROBANTEAFIP)+#39+
                                          ', EMAIL='+#39+TRIM(contactoTurno_email)+#39+
                                          ', CODCLIENTECONTACTO='+INTTOSTR(CODCLIENTECONTACTO)+' WHERE IDDETALLESPAGO='+INTTOSTR(iddetallepagos);

                aqinsertadetallepago:=tsqlquery.create(nil);
                aqinsertadetallepago.SQLConnection := MyBD;
                aqinsertadetallepago.sql.add(SSQL);
                aqinsertadetallepago.ExecSQL;

                {FIN UPDate EN DETALLES PAGOS}



                  






                 {INSERTA EN INFORAMCIONPAGO}
                  AQTEMPORAL:=tsqlquery.create(nil);
                  AQTEMPORAL.SQLConnection := MyBD;
                  AQTEMPORAL.sql.add('SELECT * FROM TMP_XML_INFORMACIONPAGO WHERE IDPAGODETALLEPAGO='+INTTOSTR(idpagoverificacionbuscar));
                  AQTEMPORAL.ExecSQL;
                  AQTEMPORAL.Open;
                  WHILE NOT AQTEMPORAL.Eof DO
                  BEGIN

                      TMP_PAGOID:=TRIM(AQTEMPORAL.FIELDBYNAME('PAGOID').AsString);
                      TMP_DOMINIO	:=TRIM(AQTEMPORAL.FIELDBYNAME('DOMINIO').AsString);
                      TMP_GATEWAYID	:=TRIM(AQTEMPORAL.FIELDBYNAME('GATEWAYID').AsString);
                      TMP_ENTIDADID	:=TRIM(AQTEMPORAL.FIELDBYNAME('ENTIDADID').AsString);
                      TMP_ENTIDADNOMBRE	:=TRIM(AQTEMPORAL.FIELDBYNAME('ENTIDADNOMBRE').AsString);
                      TMP_FECHAPAGO	:=TRIM(AQTEMPORAL.FIELDBYNAME('FECHAPAGO').AsString);
                      TMP_IMPORTETOTAL	:=TRIM(AQTEMPORAL.FIELDBYNAME('IMPORTETOTAL').AsString);
                      TMP_RESERVAID	:=TRIM(AQTEMPORAL.FIELDBYNAME('RESERVAID').AsString);
                      TMP_ESTADO:=TRIM(AQTEMPORAL.FIELDBYNAME('ESTADO').AsString);
                      TMP_ESREVE	:=TRIM(AQTEMPORAL.FIELDBYNAME('ESREVE').AsString);
                      TMP_ESREVEDIA  	:=TRIM(AQTEMPORAL.FIELDBYNAME('ESREVEDIA').AsString);
                      TMP_FECHARESERVA	:=TRIM(AQTEMPORAL.FIELDBYNAME('FECHARESERVA').AsString);
                      TMP_HORARESERVA	:=TRIM(AQTEMPORAL.FIELDBYNAME('HORARESERVA').AsString);
                      TMP_FECHAREGISTRO	:=TRIM(AQTEMPORAL.FIELDBYNAME('FECHAREGISTRO').AsString);
                      TMP_PLANTAID	:=TRIM(AQTEMPORAL.FIELDBYNAME('PLANTAID').AsString);
                      TMP_DOMINIO_RESERVA	:=TRIM(AQTEMPORAL.FIELDBYNAME('DOMINIO_RESERVA').AsString);
                      TMP_TITULAR_GENERO	:=TRIM(AQTEMPORAL.FIELDBYNAME('TITULAR_GENERO').AsString);
                      TMP_TITULAR_TIPODOCUMENTO	:=TRIM(AQTEMPORAL.FIELDBYNAME('TITULAR_TIPODOCUMENTO').AsString);
                      TMP_TITULAR_NRODOCUMENTO :=TRIM(AQTEMPORAL.FIELDBYNAME('TITULAR_NRODOCUMENTO').AsString);
                      TMP_TITULAR_CUIT	:=TRIM(AQTEMPORAL.FIELDBYNAME('TITULAR_CUIT').AsString);
                      TMP_TITULAR_NOMBRE	:=TRIM(AQTEMPORAL.FIELDBYNAME('TITULAR_NOMBRE').AsString);
                      TMP_TITULAR_APELLIDO	:=TRIM(AQTEMPORAL.FIELDBYNAME('TITULAR_APELLIDO').AsString);
                      TMP_TITULAR_RAZONSOCIAL	:=TRIM(AQTEMPORAL.FIELDBYNAME('TITULAR_RAZONSOCIAL').AsString);
                      TMP_VEHICULO_DOMINIO	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_DOMINIO').AsString);
                      TMP_VEHICULO_MARCAID	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_MARCAID').AsString);
                      TMP_VEHICULO_MARCA	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_MARCA').AsString);
                      TMP_VEHICULO_TIPOID	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_TIPOID').AsString);
                      TMP_VEHICULOO_TIPO	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULOO_TIPO').AsString);
                      TMP_VEHICULO_MODELOID	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_MODELOID').AsString);
                      TMP_VEHICULO_MODELO	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_MODELO').AsString);
                      TMP_VEHICULO_NUMEROCHASIS	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_NUMEROCHASIS').AsString);
                      TMP_VEHICULO_ANIO	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_ANIO').AsString);
                      TMP_VEHICULO_JURIDISCIONID	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_JURIDISCIONID').AsString);
                      TMP_VEHICULO_JURIDISCION	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_JURIDISCION').AsString);
                      TMP_VEHICULO_MTM	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_MTM').AsString);
                      TMP_VEHICULO_VALTITULAR	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_VALTITULAR').AsString);
                      TMP_VEHICULO_VALCHASIS	:=TRIM(AQTEMPORAL.FIELDBYNAME('VEHICULO_VALCHASIS').AsString);
                      TMP_VALIDO_MARCAID	:=TRIM(AQTEMPORAL.FIELDBYNAME('VALIDO_MARCAID').AsString);
                      TMP_VALIDO_MARCA:=TRIM(AQTEMPORAL.FIELDBYNAME('VALIDO_MARCA').AsString);
                      TMP_VALIDO_TIPOID	:=TRIM(AQTEMPORAL.FIELDBYNAME('VALIDO_TIPOID').AsString);
                      TMP_VALIDO_TIPO	:=TRIM(AQTEMPORAL.FIELDBYNAME('VALIDO_TIPO').AsString);
                      TMP_VALIDO_MODELOID	:=TRIM(AQTEMPORAL.FIELDBYNAME('VALIDO_MODELOID').AsString);
                      TMP_VALIDO_MODELO:=TRIM(AQTEMPORAL.FIELDBYNAME('VALIDO_MODELO').AsString);
                      TMP_VALIDO_NUMEROCHASIS:=TRIM(AQTEMPORAL.FIELDBYNAME('VALIDO_NUMEROCHASIS').AsString);
                      TMP_VALIDO_MTM:=TRIM(AQTEMPORAL.FIELDBYNAME('VALIDO_MTM').AsString);
                      TMP_ESTADORESERVAD:=TRIM(AQTEMPORAL.FIELDBYNAME('ESTADORESERVAD').AsString);
                      {INFORMACIONPAGO}
                     TMP_IMPORTETOTAL := StringReplace(TMP_IMPORTETOTAL, '.', ',',
                                                     [rfReplaceAll, rfIgnoreCase]);



                      {DATOS PARA INformacion pago}






                 //CLIENTE TITULAR

                  GENERO:='';
                  NRODOC:='';
                  NOMBRECLIENTE:='';
                  APELLIDOCLIENTE:='';

                  GENERO:=TRIM(TMP_TITULAR_GENERO);

                   IF TRIM(TMP_TITULAR_TIPODOCUMENTO)='9' THEN
                    BEGIN
                      IF TRIM(TMP_TITULAR_CUIT)<>'' THEN
                         NRODOC:=TRIM(TMP_TITULAR_CUIT)
                         ELSE
                         NRODOC:=TRIM(TMP_TITULAR_NRODOCUMENTO);

                    END else
                    NRODOC:=TRIM(TMP_TITULAR_NRODOCUMENTO);



                   IF (TRIM(TMP_TITULAR_TIPODOCUMENTO)='0') AND (TRIM(GENERO)='PJ') THEN
                     NRODOC:=TRIM(TMP_TITULAR_CUIT);



                     IF TRIM(TMP_TITULAR_RAZONSOCIAL)<>'' THEN
                     BEGIN
                       NOMBRECLIENTE:=TRIM(TMP_TITULAR_RAZONSOCIAL);
                       APELLIDOCLIENTE:='.';
                     END  ELSE
                     BEGIN
                       NOMBRECLIENTE:=TRIM(TMP_TITULAR_NOMBRE);
                       APELLIDOCLIENTE:=TRIM(TMP_TITULAR_APELLIDO);
                    END;


                     IF TRIM(NOMBRECLIENTE)='' THEN
                        NOMBRECLIENTE:='.';

                     IF TRIM(APELLIDOCLIENTE)='' THEN
                        APELLIDOCLIENTE:='.';


                        if (trim(datosFacturacion_condicionIva)='R') then
                            tipofact:='A'
                            else
                            tipofact:='B';


                       IF TRIM(domicilio_codigoPostal)='' THEN
                               domicilio_codigoPostal:='1000';


                        TRY
                          CODCLIENTETITULAR:=Devuelve_codclienV2(NRODOC,
                                     NOMBRECLIENTE ,
                                     APELLIDOCLIENTE ,
                                     domicilio_calle ,
                                     domicilio_numero,
                                     domicilio_departamento,
                                     domicilio_localidad,
                                     domicilio_provincia ,
                                     domicilio_codigoPostal,GENERO,TMP_TITULAR_TIPODOCUMENTO,tipofact,datosFacturacion_condicionIva);

                       EXCEPT

                           on E : Exception do
                            begin
                              TRAZAS('OBTENIENDO CODCLIENTETITULAR. '+E.ClassName+' error : IDPAGO: '+INTTOSTR(idpagoverificacionbuscar)+' '+E.Message+'.archivo: '+ARCHIVO_XML);
                              CODCLIENTETITULAR:=0;
                            end;
                      END;


                            dia:=copy(trim(TMP_FECHAPAGO),1,2);
                            mes:=copy(trim(TMP_FECHAPAGO),4,2);
                            annio:=copy(trim(TMP_FECHAPAGO),7,4);
                            FECHAPAGO_INFORMACION_PAGO:=dia+'/'+mes+'/'+annio;


                           IF (TRIM(FECHAPAGO_INFORMACION_PAGO)='//') THEN
                              FECHAPAGO_INFORMACION_PAGO:=DATETOSTR(DATE);






          //CLIENTE FACTURACION

              GENERO:='';
              NRODOC:='';
              NOMBRECLIENTE:='';
              APELLIDOCLIENTE:='';

             GENERO:=TRIM(datosPersonales_genero);




            IF TRIM(datosPersonales_tipoDocumento)='9' THEN
            BEGIN
                 IF TRIM(datosPersonales_numeroCuit)<>'' THEN
                     NRODOC:=TRIM(datosPersonales_numeroCuit)
                     ELSE
                     NRODOC:=TRIM(datosPersonales_numeroDocumento);

            END else
               NRODOC:=TRIM(datosPersonales_numeroDocumento);



                 IF (TRIM(datosPersonales_tipoDocumento)='0') AND (TRIM(GENERO)='PJ') THEN
                     NRODOC:=TRIM(datosPersonales_numeroCuit);



             IF TRIM(datosPersonales_razonSocial)<>'' THEN
             BEGIN
               NOMBRECLIENTE:=TRIM(datosPersonales_razonSocial);
               APELLIDOCLIENTE:='.';
             END  ELSE
               BEGIN
                  NOMBRECLIENTE:=TRIM(datosPersonales_nombre);
                  APELLIDOCLIENTE:=TRIM(datosPersonales_apellido);
               END;


                IF TRIM(NOMBRECLIENTE)='' THEN
                      NOMBRECLIENTE:='.';

                 IF TRIM(APELLIDOCLIENTE)='' THEN
                      APELLIDOCLIENTE:='.';




             if (trim(datosFacturacion_condicionIva)='R') then
                tipofact:='FACA'
                else
                tipofact:='FACB';



              IF TRIM(domicilio_codigoPostal)='' THEN
                 domicilio_codigoPostal:='1000';


           TRY
          CODCLIENTEFACTURACION:=Devuelve_codclienV2(NRODOC,
                                     NOMBRECLIENTE ,
                                     APELLIDOCLIENTE ,
                                     domicilio_calle ,
                                     domicilio_numero,
                                     domicilio_departamento,
                                     domicilio_localidad,
                                     domicilio_provincia ,
                                     domicilio_codigoPostal,GENERO,datosPersonales_tipoDocumento,tipofact,datosFacturacion_condicionIva);

           EXCEPT
             on E : Exception do
             begin
              TRAZAS('OBTENIENDO CODCLIENTEFACTURACION. '+E.ClassName+' error : IDPAGO: '+INTTOSTR(idpagoverificacionbuscar)+' '+E.Message+'.archivo: '+ARCHIVO_XML);
               CODCLIENTEFACTURACION:=0;
             end;

           END;
                       IF TRIM(TMP_VEHICULO_NUMEROCHASIS)='' THEN
                       TMP_VEHICULO_NUMEROCHASIS:='00000000';

                        CODVEHICULO:=Devuelve_codvehiculo(uppercase(TMP_VEHICULO_DOMINIO),
                                                          uppercase(TMP_VEHICULO_NUMEROCHASIS),
                                                          uppercase(TMP_VEHICULOO_TIPO),
                                                          uppercase(TMP_VEHICULO_MARCA),
                                                          uppercase(TMP_VEHICULO_MODELO) ,
                                                           strtoint(TMP_VEHICULO_ANIO));



                      SSQL_INFORMACION_PAGO:='UPDATE TINFORMACIONPAGO SET  '+
                                       '  CODCLIENTETITULAR='+INTTOSTR(CODCLIENTETITULAR)+
                                       ', CODVEHICULO='+INTTOSTR(CODVEHICULO)+
                                       ', CODCLIENTEFACTURACION='+INTTOSTR(CODCLIENTEFACTURACION)+
                                       ', DOMINIO='+#39+TRIM(TMP_DOMINIO)+#39+', GATEWAYID='+#39+TRIM(TMP_GATEWAYID)+#39+
                                       ', ENTIDADID='+#39+TRIM(TMP_ENTIDADID)+#39+', ENTIDADNOMBRE='+#39+TRIM(TMP_ENTIDADNOMBRE)+#39+
                                       ', FECHAPAGO=to_date('+#39+trim(FECHAPAGO_INFORMACION_PAGO)+#39+',''dd/mm/yyyy'')'+
                                       ', IMPORTETOTAL='+FLOATTOSTR(STRTOFLOAT(TMP_IMPORTETOTAL))+
                                       ', tipodocufactelec='+inttostr(strtoint(datosPersonales_tipoDocumento))+
                                       '  WHERE  IDDETALLESPAGO='+INTTOSTR(iddetallepagos)+' AND PAGOID='+#39+TRIM(TMP_PAGOID)+#39;


                     aqinsertaINFORMACIONPAGO:=tsqlquery.create(nil);
                     aqinsertaINFORMACIONPAGO.SQLConnection := MyBD;
                     aqinsertaINFORMACIONPAGO.sql.add(SSQL_INFORMACION_PAGO);
                     aqinsertaINFORMACIONPAGO.ExecSQL;

                   {FIN INFORMACION PAGO}



                   {datosreservas}

                   //CODIGO VEHICULO







                       dia:=copy(trim(TMP_FECHARESERVA),1,2);
                       mes:=copy(trim(TMP_FECHARESERVA),4,2);
                       annio:=copy(trim(TMP_FECHARESERVA),7,4);
                       FECHARESERVA:=dia+'/'+mes+'/'+annio;
                        IF (TRIM(FECHARESERVA)='//') THEN
                            FECHARESERVA:=DATETOSTR(DATE);



                        dia:=copy(trim(TMP_FECHAREGISTRO),1,2);
                        mes:=copy(trim(TMP_FECHAREGISTRO),4,2);
                        annio:=copy(trim(TMP_FECHAREGISTRO),7,4);
                        FECHAREGISTRO_RESERVA:=dia+'/'+mes+'/'+annio;



                           IF (TRIM(FECHAREGISTRO_RESERVA)='//') THEN
                               FECHAREGISTRO_RESERVA:=DATETOSTR(DATE);

                         {  IF TRIM(TMP_ESREVE)='' THEN
                                 TMP_ESREVE:='N'
                               ELSE
                                TMP_ESREVE:='S';


                         IF TRIM(TMP_ESREVEDIA)='' THEN
                              TMP_ESREVEDIA:='N'
                           ELSE
                               TMP_ESREVEDIA:='S'; }



                           SSQL_DATOS_RESERVAS:='UPDATE TDATRESERVA  SET  '+
                                     ' ESTADO='+#39+TRIM(TMP_ESTADO)+#39+
                                     ', ESREVE='+#39+TRIM(TMP_ESREVE)+#39+', ESREVEDIA='+#39+TRIM(TMP_ESREVEDIA)+#39+
                                     ', FECHARESERVA=to_date('+#39+trim(FECHARESERVA)+#39+',''dd/mm/yyyy'')'+
                                     ', HORARESERVA='+#39+TRIM(TMP_HORARESERVA)+#39+
                                     ', FECHAREGISTRO=to_date('+#39+TRIM(FECHAREGISTRO_RESERVA)+#39+',''dd/mm/yyyy'')'+
                                     ', PLANTAID='+#39+TRIM(TMP_PLANTAID)+#39+', DOMINIO='+#39+TRIM(TMP_DOMINIO_RESERVA)+#39+
                                     ', ESTADORESERVAD='+#39+TRIM(TMP_ESTADORESERVAD)+#39+
                                     ' WHERE IDDETALLESPAGO='+INTTOSTR(iddetallepagos)+
                                     ' AND RESERVAID='+INTTOSTR(STRTOINT(TMP_RESERVAID));



                aqinsertaDATOSRESERVAS:=tsqlquery.create(nil);
                aqinsertaDATOSRESERVAS.SQLConnection := MyBD;
                aqinsertaDATOSRESERVAS.sql.add(SSQL_DATOS_RESERVAS);
                aqinsertaDATOSRESERVAS.ExecSQL;


                   {fin datosreservas}


                      AQTEMPORAL.Next;
                  END;










              MYBD.Commit(TD);
                aqinsertaINFORMACIONPAGO.CLOSE;
                aqinsertaINFORMACIONPAGO.FREE;

                aqinsertaDATOSRESERVAS.CLOSE;
                aqinsertaDATOSRESERVAS.FREE;
               EXCEPT

                 on E : Exception do
                 BEGIN
                 MyBD.Rollback(TD);
                  TRAZAS('ERROR REALIZAR INSERT TDATRESERVA o TINFORMACIONPAGO . '+E.ClassName+' error : IDPAGO: '+INTTOSTR(idpagoverificacionbuscar)+' '+E.Message+'.archivo: '+ARCHIVO_XML);

                  END;

              END;
          aqinsertadetallepago.CLOSE;
          aqinsertadetallepago.FREE;




     except
          on E : Exception do
             TRAZAS('ERROR GENERAL EN FUNCION MODIFICA_XML_PAGOS. '+E.ClassName+' error : IDPAGO: '+INTTOSTR(idpagoverificacionbuscar)+' '+E.Message+'.archivo: '+ARCHIVO_XML);


     end;




      end;







  aq.close;
  aq.free;

   EXCEPT
   on E : Exception do
   BEGIN
    respuestaidpago:=-661;
    TRAZAS('ERROR EN MODIFICAR  XML EN LAS TABLAS. FUNCION:MODIFICA_XML_PAGOS IDPAGO:'+detallesPago_pagoID+'. '+E.ClassName+'. error : '+E.Message+'.archivo: '+ARCHIVO_XML);
   END;

END ;

END;


FUNCTION txml_caba.LEER_TAGS_ARCHIVO_XML_PAGOS(ARCHIVO:STRING):BOOLEAN;
VAR LINEA,X:STRING;
S,ENTRADAA:LONGINT;
GUARDAR:BOOLEAN;
detallesPago_pagoID:STRING;
detallesPago_plantaID:STRING;
detallesPago_importe :STRING;
detallesPago_estadoAcreditacion:STRING;
detallesPago_estadoAcreditacionD :STRING;
detallesPago_pagoGatewayID :STRING;
detallesPago_tipoBoleta :STRING;
detallesPago_fechaNovedad :STRING;
detallesPago_fechaPago :STRING;

informacionPago_pagoID:STRING;
informacionPago_dominio :STRING;
informacionPago_gatewayID :STRING;
informacionPago_entidadID :STRING;
informacionPago_entidadNombre:STRING;
informacionPago_fechaPago :STRING ;
informacionPago_importeTotal :STRING;


datosReserva_reservaID :STRING;
datosReserva_estado :STRING;
datosReserva_esReve:STRING;
datosReserva_esReveDia:STRING;
datosReserva_fechaReserva :STRING;
datosReserva_horaReserva :STRING;
datosReserva_fechaRegistro :STRING;
datosReserva_plantaID :STRING;
datosReserva_dominio :STRING;

datosTitular_genero:STRING;
datosTitular_tipoDocumento :STRING;
datosTitular_numeroDocumento :STRING;
datosTitular_numeroCuit :STRING;
datosTitular_nombre :STRING;
datosTitular_apellido :STRING;
datosTitular_razonSocial :STRING;

 datosVehiculo_dominio :STRING;
 datosVehiculo_marcaID :STRING;
 datosVehiculo_marca :STRING;
 Vehiculo_tipoID :STRING;
 datosVehiculo_tipo :STRING;
 datosVehiculo_modeloID :STRING;
 datosVehiculo_modelo :STRING;
 numeroChasis_marca:STRING;
 numeroChasis_numero :STRING;
 datosVehiculo_anio :STRING;
 datosVehiculo_jurisdiccionID :STRING;
 datosVehiculo_jurisdiccion :STRING;
 datosVehiculo_mtm :STRING;
 datosVehiculo_valTitular :STRING;
 datosVehiculo_valChasis :STRING;
 datosValidados_marcaID :STRING;
 datosValidados_marca :STRING;
 datosValidados_tipoID :STRING;
 datosValidados_tipo :STRING;
 datosValidados_modeloID :STRING;
 datosValidados_modelo :STRING;
 datosValidados_numeroChasis:STRING;
 datosValidados_mtm:STRING;

  datosPersonalesTurno_genero :STRING;
  datosPersonalesTurno_tipoDocumento :STRING;
  datosPersonalesTurno_numeroDocumento :STRING;
  datosPersonalesTurno_numeroCuit:STRING;
  datosPersonalesTurno_nombre :STRING;
  datosPersonalesTurno_apellido :STRING;
  datosPersonalesTurno_razonSocial :STRING;

  contactoTurno_telefonoCelular :STRING;
  contactoTurno_email :STRING;
  contactoTurno_fechaNacimiento :STRING;

 ii:longint;

  datosPersonales_genero :STRING;
  datosPersonales_tipoDocumento :STRING;
  datosPersonales_numeroDocumento :STRING;
  datosPersonales_numeroCuit :STRING;
  datosPersonales_nombre :STRING;
  datosPersonales_apellido:STRING;
  datosPersonales_razonSocial:STRING;
  datosFacturacion_domicilio :STRING;
  domicilio_calle :STRING;
  domicilio_numero :STRING;
  domicilio_piso :STRING;
  domicilio_departamento :STRING;
  domicilio_localidad :STRING;
  domicilio_provinciaID :STRING;
  domicilio_provincia :STRING;
  domicilio_codigoPostal :STRING;
  datosFacturacion_condicionIva :STRING;
  leyo ,continua_pago:boolean;
  item_pago,total_registro:longint;
  GUARDAR2:boolean;
  begin
  detallesPago_pagoID:='';
detallesPago_plantaID:='';
detallesPago_importe :='';
detallesPago_estadoAcreditacion:='';
detallesPago_estadoAcreditacionD :='';
detallesPago_pagoGatewayID :='';
detallesPago_tipoBoleta :='';
detallesPago_fechaNovedad :='';
detallesPago_fechaPago :='';

 informacionPago_pagoID:='';
  informacionPago_dominio :='';
  informacionPago_gatewayID :='';
  informacionPago_entidadID :='';
  informacionPago_entidadNombre:='';
  informacionPago_fechaPago :='';
  informacionPago_importeTotal :='';


 {for ii:=1 to 10 do
 begin
  informacionPago_pagoID[ii] :='';
  informacionPago_dominio[ii] :='';
  informacionPago_gatewayID[ii] :='';
  informacionPago_entidadID[ii] :='';
  informacionPago_entidadNombre[ii]:='';
  informacionPago_fechaPago[ii] :='';
  informacionPago_importeTotal[ii] :='';
 end;
 }

datosReserva_reservaID :='';
datosReserva_estado :='';
datosReserva_esReve:='';
datosReserva_esReveDia:='';
datosReserva_fechaReserva :='';
datosReserva_horaReserva :='';
datosReserva_fechaRegistro :='';
datosReserva_plantaID :='';
datosReserva_dominio :='';

datosTitular_genero:='';
datosTitular_tipoDocumento :='';
datosTitular_numeroDocumento :='';
datosTitular_numeroCuit :='';
datosTitular_nombre :='';
datosTitular_apellido :='';
datosTitular_razonSocial :='';

 datosVehiculo_dominio :='';
 datosVehiculo_marcaID :='';
 datosVehiculo_marca :='';
 Vehiculo_tipoID :='';
 datosVehiculo_tipo :='';
 datosVehiculo_modeloID :='';
 datosVehiculo_modelo :='';
 numeroChasis_marca:='';
 numeroChasis_numero :='';
 datosVehiculo_anio :='';
 datosVehiculo_jurisdiccionID :='';
 datosVehiculo_jurisdiccion :='';
 datosVehiculo_mtm :='';
 datosVehiculo_valTitular :='';
 datosVehiculo_valChasis :='';
 datosValidados_marcaID :='';
 datosValidados_marca :='';
 datosValidados_tipoID :='';
 datosValidados_tipo :='';
 datosValidados_modeloID :='';
 datosValidados_modelo :='';
 datosValidados_numeroChasis:='';
 datosValidados_mtm:='';

  datosPersonalesTurno_genero :='';
  datosPersonalesTurno_tipoDocumento :='';
  datosPersonalesTurno_numeroDocumento :='';
  datosPersonalesTurno_numeroCuit:='';
  datosPersonalesTurno_nombre :='';
  datosPersonalesTurno_apellido :='';
  datosPersonalesTurno_razonSocial :='';

  contactoTurno_telefonoCelular :='';
  contactoTurno_email :='';
  contactoTurno_fechaNacimiento :='';



  datosPersonales_genero :='';
  datosPersonales_tipoDocumento :='';
  datosPersonales_numeroDocumento :='';
  datosPersonales_numeroCuit :='';
  datosPersonales_nombre :='';
  datosPersonales_apellido:='';
  datosPersonales_razonSocial:='';
  datosFacturacion_domicilio :='';
  domicilio_calle :='';
  domicilio_numero :='';
  domicilio_piso :='';
  domicilio_departamento :='';
  domicilio_localidad :='';
  domicilio_provinciaID :='';
  domicilio_provincia :='';
  domicilio_codigoPostal :='';
  datosFacturacion_condicionIva :='';
  GUARDAR:=FALSE;
  GUARDAR2:=false;
S:=0;
ii:=0;
total_registro:=0;
leyo:=false;
continua_pago:=true;
ASSIGNFILE(ARCHIVOPROCESO,ARCHIVO);
RESET(ARCHIVOPROCESO);
while (not eof(ARCHIVOPROCESO)) or (trim(linea)='**FIN**') do
begin
//if leyo=false then
 readln(ARCHIVOPROCESO,linea);




  if trim(es_linea(linea))=trim(es_linea('datosPagoVtv_detallesPago')) then
       ENTRADAA:=1;

  if trim(es_linea(linea))=trim(es_linea('item_informacionPago')) then
       ENTRADAA:=2;

  if trim(es_linea(linea))=trim(es_linea('item_datosReserva')) then
       ENTRADAA:=3;

  if trim(es_linea(linea))=trim(es_linea('item_datosTitular')) then
       ENTRADAA:=4;


  if trim(es_linea(linea))=trim(es_linea('item_datosVehiculo')) then
       ENTRADAA:=5;

  if trim(es_linea(linea))=trim(es_linea('datosContacto_datosPersonalesTurno')) then
       ENTRADAA:=6;


  if trim(es_linea(linea))=trim(es_linea('datosContacto_contactoTurno')) then
       ENTRADAA:=7;

  if trim(es_linea(linea))=trim(es_linea('datosFacturacion_datosPersonales')) then
       ENTRADAA:=8;



  IF ENTRADAA=1 THEN
   BEGIN
         GUARDAR:=TRUE;
         if trim(es_linea(linea))=trim(es_linea('detallesPago_pagoID')) then
          detallesPago_pagoID:=trim(extrae_valor_PAGOS(trim(linea)));

         if trim(es_linea(linea))=trim(es_linea('detallesPago_plantaID')) then
            detallesPago_plantaID:=trim(extrae_valor_PAGOS(trim(linea)));

         if trim(es_linea(linea))=trim(es_linea('detallesPago_importe')) then
            detallesPago_importe:=trim(extrae_valor_PAGOS(trim(linea)));

         if trim(es_linea(linea))=trim(es_linea('detallesPago_estadoAcreditacion')) then
            detallesPago_estadoAcreditacion:=trim(extrae_valor_PAGOS(trim(linea)));

         if trim(es_linea(linea))=trim(es_linea('detallesPago_estadoAcreditacionD')) then
            detallesPago_estadoAcreditacionD:=trim(extrae_valor_PAGOS(trim(linea)));


         if trim(es_linea(linea))=trim(es_linea('detallesPago_pagoGatewayID')) then
             detallesPago_pagoGatewayID:=trim(extrae_valor_PAGOS(trim(linea)));


         if trim(es_linea(linea))=trim(es_linea('detallesPago_tipoBoleta')) then
            detallesPago_tipoBoleta:=trim(extrae_valor_PAGOS(trim(linea)));

         if trim(es_linea(linea))=trim(es_linea('detallesPago_fechaNovedad')) then
            detallesPago_fechaNovedad:=trim(extrae_valor_PAGOS(trim(linea)));

         if trim(es_linea(linea))=trim(es_linea('detallesPago_fechaPago')) then
            detallesPago_fechaPago:=trim(extrae_valor_PAGOS(trim(linea)));



   END;



   IF ENTRADAA=2 THEN
   BEGIN
   GUARDAR2:=TRUE;
 {  leyo:=false;
   continua_pago:=true;
   item_pago:=0;
       while continua_pago=true do
       begin
       item_pago:=item_pago + 1;
       if leyo=false then
       readln(ARCHIVOPROCESO,linea); }

       if trim(es_linea(linea))=trim(es_linea('informacionPago_pagoID')) then
          informacionPago_pagoID:=trim(extrae_valor_PAGOS(trim(linea)));

      // readln(ARCHIVOPROCESO,linea);
       if trim(es_linea(linea))=trim(es_linea('informacionPago_dominio')) then
          informacionPago_dominio:=trim(extrae_valor_PAGOS(trim(linea)));


      // readln(ARCHIVOPROCESO,linea);
       if trim(es_linea(linea))=trim(es_linea('informacionPago_gatewayID')) then
          informacionPago_gatewayID:=trim(extrae_valor_PAGOS(trim(linea)));

       // readln(ARCHIVOPROCESO,linea);
       if trim(es_linea(linea))=trim(es_linea('informacionPago_entidadID')) then
          informacionPago_entidadID:=trim(extrae_valor_PAGOS(trim(linea)));

         //  readln(ARCHIVOPROCESO,linea);
       if trim(es_linea(linea))=trim(es_linea('informacionPago_entidadNombre')) then
          informacionPago_entidadNombre:=trim(extrae_valor_PAGOS(trim(linea)));

          // readln(ARCHIVOPROCESO,linea);
         if trim(es_linea(linea))=trim(es_linea('informacionPago_fechaPago')) then
          informacionPago_fechaPago:=trim(extrae_valor_PAGOS(trim(linea)));

        // readln(ARCHIVOPROCESO,linea);
        if trim(es_linea(linea))=trim(es_linea('informacionPago_importeTotal')) then
          informacionPago_importeTotal:=trim(extrae_valor_PAGOS(trim(linea)));

        {  readln(ARCHIVOPROCESO,linea);
          if trim(es_linea(linea)) <> trim(es_linea('item_datosReserva')) then
          begin
          continua_pago:=true ;
          leyo:=true;
          end
          else
          begin
          continua_pago:=false;
          leyo:=true;
          end;  }
      // end;  // while

   END;

   IF ENTRADAA=3 THEN
   BEGIN
   leyo:=false;
         if trim(es_linea(linea))=trim(es_linea('datosReserva_reservaID')) then
          datosReserva_reservaID:=trim(extrae_valor_PAGOS(trim(linea)));

          if trim(es_linea(linea))=trim(es_linea('datosReserva_estado')) then
          datosReserva_estado:=trim(extrae_valor_PAGOS(trim(linea)));


          if trim(es_linea(linea))=trim(es_linea('datosReserva_esReve')) then
          datosReserva_esReve:=trim(extrae_valor_PAGOS(trim(linea)));

          if trim(es_linea(linea))=trim(es_linea('datosReserva_esReveDia')) then
          datosReserva_esReveDia:=trim(extrae_valor_PAGOS(trim(linea)));


          if trim(es_linea(linea))=trim(es_linea('datosReserva_fechaReserva')) then
          datosReserva_fechaReserva:=trim(extrae_valor_PAGOS(trim(linea)));


          if trim(es_linea(linea))=trim(es_linea('datosReserva_horaReserva')) then
          datosReserva_horaReserva:=trim(extrae_valor_PAGOS(trim(linea)));


          if trim(es_linea(linea))=trim(es_linea('datosReserva_fechaRegistro')) then
          datosReserva_fechaRegistro:=trim(extrae_valor_PAGOS(trim(linea)));


          if trim(es_linea(linea))=trim(es_linea('datosReserva_plantaID')) then
          datosReserva_plantaID:=trim(extrae_valor_PAGOS(trim(linea)));


          if trim(es_linea(linea))=trim(es_linea('datosReserva_dominio')) then
          datosReserva_dominio:=trim(extrae_valor_PAGOS(trim(linea)));

   END;

   IF ENTRADAA=4 THEN
      BEGIN
      if trim(es_linea(linea))=trim(es_linea('datosTitular_genero')) then
          datosTitular_genero:=trim(extrae_valor_PAGOS(trim(linea)));

      if trim(es_linea(linea))=trim(es_linea('datosTitular_tipoDocumento')) then
          datosTitular_tipoDocumento:=trim(extrae_valor_PAGOS(trim(linea)));

      if trim(es_linea(linea))=trim(es_linea('datosTitular_numeroDocumento')) then
          datosTitular_numeroDocumento:=trim(extrae_valor_PAGOS(trim(linea)));

      if trim(es_linea(linea))=trim(es_linea('datosTitular_numeroCuit')) then
          datosTitular_numeroCuit:=trim(extrae_valor_PAGOS(trim(linea)));

      if trim(es_linea(linea))=trim(es_linea('datosTitular_nombre')) then
          datosTitular_nombre:=trim(extrae_valor_PAGOS(trim(linea)));


      if trim(es_linea(linea))=trim(es_linea('datosTitular_apellido')) then
          datosTitular_apellido:=trim(extrae_valor_PAGOS(trim(linea)));


      if trim(es_linea(linea))=trim(es_linea('datosTitular_razonSocial')) then
          datosTitular_razonSocial:=trim(extrae_valor_PAGOS(trim(linea)));




      END;

      IF ENTRADAA=5 THEN
      BEGIN

       if trim(es_linea(linea))=trim(es_linea('datosVehiculo_dominio')) then
          datosVehiculo_dominio:=trim(extrae_valor_PAGOS(trim(linea)));


        if trim(es_linea(linea))=trim(es_linea('datosVehiculo_marcaID')) then
          datosVehiculo_marcaID:=trim(extrae_valor_PAGOS(trim(linea)));

         if trim(es_linea(linea))=trim(es_linea('datosVehiculo_marca')) then
          datosVehiculo_marca:=trim(extrae_valor_PAGOS(trim(linea)));


          if trim(es_linea(linea))=trim(es_linea('datosVehiculo_tipoID')) then
          datosVehiculo_tipoID:=trim(extrae_valor_PAGOS(trim(linea)));


           if trim(es_linea(linea))=trim(es_linea('datosVehiculo_tipo')) then
          datosVehiculo_tipo:=trim(extrae_valor_PAGOS(trim(linea)));

          if trim(es_linea(linea))=trim(es_linea('datosVehiculo_modeloID')) then
          datosVehiculo_modeloID:=trim(extrae_valor_PAGOS(trim(linea)));

          if trim(es_linea(linea))=trim(es_linea('datosVehiculo_modelo')) then
          datosVehiculo_modelo:=trim(extrae_valor_PAGOS(trim(linea)));

          if trim(es_linea(linea))=trim(es_linea('numeroChasis_marca')) then
          numeroChasis_marca:=trim(extrae_valor_PAGOS(trim(linea)));


           if trim(es_linea(linea))=trim(es_linea('numeroChasis_numero')) then
          numeroChasis_numero:=trim(extrae_valor_PAGOS(trim(linea)));


          if trim(es_linea(linea))=trim(es_linea('datosVehiculo_anio')) then
          datosVehiculo_anio:=trim(extrae_valor_PAGOS(trim(linea)));

          if trim(es_linea(linea))=trim(es_linea('datosVehiculo_jurisdiccionID')) then
          datosVehiculo_jurisdiccionID:=trim(extrae_valor_PAGOS(trim(linea)));


           if trim(es_linea(linea))=trim(es_linea('datosVehiculo_jurisdiccion')) then
          datosVehiculo_jurisdiccion:=trim(extrae_valor_PAGOS(trim(linea)));


           if trim(es_linea(linea))=trim(es_linea('datosVehiculo_mtm')) then
          datosVehiculo_mtm:=trim(extrae_valor_PAGOS(trim(linea)));

           if trim(es_linea(linea))=trim(es_linea('datosVehiculo_valTitular')) then
          datosVehiculo_valTitular:=trim(extrae_valor_PAGOS(trim(linea)));

           if trim(es_linea(linea))=trim(es_linea('datosVehiculo_valChasis')) then
          datosVehiculo_valChasis:=trim(extrae_valor_PAGOS(trim(linea)));

           if trim(es_linea(linea))=trim(es_linea('datosValidados_marcaID')) then
          datosValidados_marcaID:=trim(extrae_valor_PAGOS(trim(linea)));

            if trim(es_linea(linea))=trim(es_linea('datosValidados_marca')) then
          datosValidados_marca:=trim(extrae_valor_PAGOS(trim(linea)));

            if trim(es_linea(linea))=trim(es_linea('datosValidados_tipoID')) then
          datosValidados_tipoID:=trim(extrae_valor_PAGOS(trim(linea)));


            if trim(es_linea(linea))=trim(es_linea('datosValidados_tipo')) then
          datosValidados_tipo:=trim(extrae_valor_PAGOS(trim(linea)));

           if trim(es_linea(linea))=trim(es_linea('datosValidados_modeloID')) then
          datosValidados_modeloID:=trim(extrae_valor_PAGOS(trim(linea)));


          if trim(es_linea(linea))=trim(es_linea('datosValidados_modelo')) then
          datosValidados_modelo:=trim(extrae_valor_PAGOS(trim(linea)));


           if trim(es_linea(linea))=trim(es_linea('datosValidados_numeroChasis')) then
          datosValidados_numeroChasis:=trim(extrae_valor_PAGOS(trim(linea)));

           if trim(es_linea(linea))=trim(es_linea('datosValidados_mtm')) then
          datosValidados_mtm:=trim(extrae_valor_PAGOS(trim(linea)));


      END;

       IF ENTRADAA=6 THEN
      BEGIN
        if trim(es_linea(linea))=trim(es_linea('datosPersonalesTurno_genero')) then
          datosPersonalesTurno_genero:=trim(extrae_valor_PAGOS(trim(linea)));


          if trim(es_linea(linea))=trim(es_linea('datosPersonalesTurno_tipoDocumento')) then
          datosPersonalesTurno_tipoDocumento:=trim(extrae_valor_PAGOS(trim(linea)));

         if trim(es_linea(linea))=trim(es_linea('datosPersonalesTurno_numeroDocumento')) then
          datosPersonalesTurno_numeroDocumento:=trim(extrae_valor_PAGOS(trim(linea)));


          if trim(es_linea(linea))=trim(es_linea('datosPersonalesTurno_numeroCuit')) then
          datosPersonalesTurno_numeroCuit:=trim(extrae_valor_PAGOS(trim(linea)));


           if trim(es_linea(linea))=trim(es_linea('datosPersonalesTurno_nombre')) then
          datosPersonalesTurno_nombre:=trim(extrae_valor_PAGOS(trim(linea)));


            if trim(es_linea(linea))=trim(es_linea('datosPersonalesTurno_apellido')) then
          datosPersonalesTurno_apellido:=trim(extrae_valor_PAGOS(trim(linea)));


            if trim(es_linea(linea))=trim(es_linea('datosPersonalesTurno_razonSocial')) then
          datosPersonalesTurno_razonSocial:=trim(extrae_valor_PAGOS(trim(linea)));


      END;


       IF ENTRADAA=7 THEN
      BEGIN
        if trim(es_linea(linea))=trim(es_linea('contactoTurno_telefonoCelular')) then
          contactoTurno_telefonoCelular:=trim(extrae_valor_PAGOS(trim(linea)));

            if trim(es_linea(linea))=trim(es_linea('contactoTurno_email')) then
          contactoTurno_email:=trim(extrae_valor_PAGOS(trim(linea)));


            if trim(es_linea(linea))=trim(es_linea('contactoTurno_fechaNacimiento')) then
          contactoTurno_fechaNacimiento:=trim(extrae_valor_PAGOS(trim(linea)));


      END;


       IF ENTRADAA=8 THEN
      BEGIN
       if trim(es_linea(linea))=trim(es_linea('datosPersonales_genero')) then
          datosPersonales_genero:=trim(extrae_valor_PAGOS(trim(linea)));


          if trim(es_linea(linea))=trim(es_linea('datosPersonales_tipoDocumento')) then
          datosPersonales_tipoDocumento:=trim(extrae_valor_PAGOS(trim(linea)));

          if trim(es_linea(linea))=trim(es_linea('datosPersonales_numeroDocumento')) then
          datosPersonales_numeroDocumento:=trim(extrae_valor_PAGOS(trim(linea)));

          if trim(es_linea(linea))=trim(es_linea('datosPersonales_numeroCuit')) then
          datosPersonales_numeroCuit:=trim(extrae_valor_PAGOS(trim(linea)));

         if trim(es_linea(linea))=trim(es_linea('datosPersonales_nombre')) then
          datosPersonales_nombre:=trim(extrae_valor_PAGOS(trim(linea)));

         if trim(es_linea(linea))=trim(es_linea('datosPersonales_apellido')) then
          datosPersonales_apellido:=trim(extrae_valor_PAGOS(trim(linea)));

         if trim(es_linea(linea))=trim(es_linea('datosPersonales_razonSocial')) then
          datosPersonales_razonSocial:=trim(extrae_valor_PAGOS(trim(linea)));

        if trim(es_linea(linea))=trim(es_linea('datosFacturacion_domicilio')) then
          datosFacturacion_domicilio:=trim(extrae_valor_PAGOS(trim(linea)));

        if trim(es_linea(linea))=trim(es_linea('domicilio_calle')) then
        BEGIN
          domicilio_calle:=trim(extrae_valor_PAGOS(trim(linea)));
            IF TRIM(domicilio_calle)='' THEN
                domicilio_calle:='SIN DOMICILIO';
         END;

         if trim(es_linea(linea))=trim(es_linea('domicilio_numero')) then
         BEGIN
          domicilio_numero:=trim(extrae_valor_PAGOS(trim(linea)));
               IF TRIM(domicilio_numero)='' THEN
                 domicilio_numero:='0000';
          END;
         if trim(es_linea(linea))=trim(es_linea('domicilio_piso')) then
          domicilio_piso:=trim(extrae_valor_PAGOS(trim(linea)));

          if trim(es_linea(linea))=trim(es_linea('domicilio_departamento')) then
          BEGIN
          domicilio_departamento:=trim(extrae_valor_PAGOS(trim(linea)));
             IF TRIM(domicilio_departamento)='' THEN
                domicilio_departamento:='0';
          END;
          if trim(es_linea(linea))=trim(es_linea('domicilio_localidad')) then
          domicilio_localidad:=trim(extrae_valor_PAGOS(trim(linea)));

         if trim(es_linea(linea))=trim(es_linea('domicilio_provinciaID')) then
          domicilio_provinciaID:=trim(extrae_valor_PAGOS(trim(linea)));

         if trim(es_linea(linea))=trim(es_linea('domicilio_provincia')) then
          domicilio_provincia:=trim(extrae_valor_PAGOS(trim(linea)));

          if trim(es_linea(linea))=trim(es_linea('domicilio_codigoPostal')) then
          domicilio_codigoPostal:=trim(extrae_valor_PAGOS(trim(linea)));

          if trim(es_linea(linea))=trim(es_linea('datosFacturacion_condicionIva')) then
          datosFacturacion_condicionIva:=trim(extrae_valor_PAGOS(trim(linea)));


      END;


     //GUARDA EN BASE DATOS
    if (trim(es_linea(linea))=trim(es_linea('pagos_item'))) AND (GUARDAR=TRUE) and (GUARDAR2=TRUE) then
      BEGIN
      total_registro:= total_registro + 1;
      GUARDAR:=false;
      GUARDAR2:=false;
         GARRDAR_XML_PAGOS(detallesPago_pagoID,
                           detallesPago_plantaID,
                           detallesPago_importe,
                           detallesPago_estadoAcreditacion,
                           detallesPago_estadoAcreditacionD,
                           detallesPago_pagoGatewayID,
                           detallesPago_tipoBoleta,
                           detallesPago_fechaNovedad,
                           detallesPago_fechaPago,
                           datosPersonalesTurno_genero,
                           datosPersonalesTurno_tipoDocumento,
                           datosPersonalesTurno_numeroDocumento,
                           datosPersonalesTurno_numeroCuit,
                           datosPersonalesTurno_nombre,
                           datosPersonalesTurno_apellido,
                           datosPersonalesTurno_razonSocial,
                           contactoTurno_telefonoCelular,
                           contactoTurno_email,
                           contactoTurno_fechaNacimiento,
                           datosPersonales_genero,
                           datosPersonales_tipoDocumento,
                           datosPersonales_numeroDocumento,
                           datosPersonales_numeroCuit,
                           datosPersonales_nombre,
                           datosPersonales_apellido,
                           datosPersonales_razonSocial,
                           datosFacturacion_domicilio,
                           domicilio_calle,
                           domicilio_numero,
                           domicilio_piso,
                           domicilio_departamento,
                           domicilio_localidad,
                           domicilio_provinciaID,
                           domicilio_provincia,
                           domicilio_codigoPostal,
                           datosFacturacion_condicionIva,'','','');


          detallesPago_pagoID:='';
          detallesPago_plantaID:='';
          detallesPago_importe :='';
          detallesPago_estadoAcreditacion:='';
          detallesPago_estadoAcreditacionD :='';
          detallesPago_pagoGatewayID :='';
          detallesPago_tipoBoleta :='';
          detallesPago_fechaNovedad :='';
          detallesPago_fechaPago :='';


          informacionPago_pagoID:='';
          informacionPago_dominio :='';
          informacionPago_gatewayID :='';
          informacionPago_entidadID :='';
          informacionPago_entidadNombre:='';
          informacionPago_fechaPago :='';
          informacionPago_importeTotal :='';


          datosReserva_reservaID :='';
          datosReserva_estado :='';
          datosReserva_esReve:='';
          datosReserva_esReveDia:='';
          datosReserva_fechaReserva :='';
          datosReserva_horaReserva :='';
          datosReserva_fechaRegistro :='';
          datosReserva_plantaID :='';
          datosReserva_dominio :='';

          datosTitular_genero:='';
          datosTitular_tipoDocumento :='';
          datosTitular_numeroDocumento :='';
          datosTitular_numeroCuit :='';
          datosTitular_nombre :='';
          datosTitular_apellido :='';
          datosTitular_razonSocial :='';

          datosVehiculo_dominio :='';
          datosVehiculo_marcaID :='';
          datosVehiculo_marca :='';
          Vehiculo_tipoID :='';
          datosVehiculo_tipo :='';
          datosVehiculo_modeloID :='';
          datosVehiculo_modelo :='';
          numeroChasis_marca:='';
          numeroChasis_numero :='';
          datosVehiculo_anio :='';
          datosVehiculo_jurisdiccionID :='';
          datosVehiculo_jurisdiccion :='';
          datosVehiculo_mtm :='';
          datosVehiculo_valTitular :='';
          datosVehiculo_valChasis :='';
          datosValidados_marcaID :='';
          datosValidados_marca :='';
          datosValidados_tipoID :='';
          datosValidados_tipo :='';
          datosValidados_modeloID :='';
          datosValidados_modelo :='';
          datosValidados_numeroChasis:='';
          datosValidados_mtm:='';

          datosPersonalesTurno_genero :='';
          datosPersonalesTurno_tipoDocumento :='';
          datosPersonalesTurno_numeroDocumento :='';
          datosPersonalesTurno_numeroCuit:='';
          datosPersonalesTurno_nombre :='';
          datosPersonalesTurno_apellido :='';
          datosPersonalesTurno_razonSocial :='';

          contactoTurno_telefonoCelular :='';
          contactoTurno_email :='';
          contactoTurno_fechaNacimiento :='';



          datosPersonales_genero :='';
          datosPersonales_tipoDocumento :='';
          datosPersonales_numeroDocumento :='';
          datosPersonales_numeroCuit :='';
          datosPersonales_nombre :='';
          datosPersonales_apellido:='';
          datosPersonales_razonSocial:='';
          datosFacturacion_domicilio :='';
          domicilio_calle :='';
          domicilio_numero :='';
          domicilio_piso :='';
          domicilio_departamento :='';
          domicilio_localidad :='';
          domicilio_provinciaID :='';
          domicilio_provincia :='';
          domicilio_codigoPostal :='';
          datosFacturacion_condicionIva :='';

    END ELSE
     BEGIN
              if (trim(es_linea(linea))=trim(es_linea('pagos_item')))  and (GUARDAR2=false) then
        begin
            IF TRIM(detallesPago_pagoID)<>'' THEN
             BEGIN
             TRAZAS('IDPAGO: '+detallesPago_pagoID+': NO TIENE PAGOS RELACIONADOS. NO SE INSERTA EN LA BASE');

             GUARDAR:=false;
             GUARDAR2:=false;
             detallesPago_pagoID:='';
             detallesPago_plantaID:='';
             detallesPago_importe :='';
             detallesPago_estadoAcreditacion:='';
             detallesPago_estadoAcreditacionD :='';
             detallesPago_pagoGatewayID :='';
             detallesPago_tipoBoleta :='';
             detallesPago_fechaNovedad :='';
             detallesPago_fechaPago :='';


             informacionPago_pagoID:='';
             informacionPago_dominio :='';
             informacionPago_gatewayID :='';
             informacionPago_entidadID :='';
             informacionPago_entidadNombre:='';
             informacionPago_fechaPago :='';
             informacionPago_importeTotal :='';


             datosReserva_reservaID :='';
             datosReserva_estado :='';
             datosReserva_esReve:='';
             datosReserva_esReveDia:='';
             datosReserva_fechaReserva :='';
             datosReserva_horaReserva :='';
             datosReserva_fechaRegistro :='';
             datosReserva_plantaID :='';
             datosReserva_dominio :='';

             datosTitular_genero:='';
             datosTitular_tipoDocumento :='';
             datosTitular_numeroDocumento :='';
             datosTitular_numeroCuit :='';
             datosTitular_nombre :='';
             datosTitular_apellido :='';
            datosTitular_razonSocial :='';

          datosVehiculo_dominio :='';
          datosVehiculo_marcaID :='';
          datosVehiculo_marca :='';
          Vehiculo_tipoID :='';
          datosVehiculo_tipo :='';
          datosVehiculo_modeloID :='';
          datosVehiculo_modelo :='';
          numeroChasis_marca:='';
          numeroChasis_numero :='';
          datosVehiculo_anio :='';
          datosVehiculo_jurisdiccionID :='';
          datosVehiculo_jurisdiccion :='';
          datosVehiculo_mtm :='';
          datosVehiculo_valTitular :='';
          datosVehiculo_valChasis :='';
          datosValidados_marcaID :='';
          datosValidados_marca :='';
          datosValidados_tipoID :='';
          datosValidados_tipo :='';
          datosValidados_modeloID :='';
          datosValidados_modelo :='';
          datosValidados_numeroChasis:='';
          datosValidados_mtm:='';

          datosPersonalesTurno_genero :='';
          datosPersonalesTurno_tipoDocumento :='';
          datosPersonalesTurno_numeroDocumento :='';
          datosPersonalesTurno_numeroCuit:='';
          datosPersonalesTurno_nombre :='';
          datosPersonalesTurno_apellido :='';
          datosPersonalesTurno_razonSocial :='';

          contactoTurno_telefonoCelular :='';
          contactoTurno_email :='';
          contactoTurno_fechaNacimiento :='';



          datosPersonales_genero :='';
          datosPersonales_tipoDocumento :='';
          datosPersonales_numeroDocumento :='';
          datosPersonales_numeroCuit :='';
          datosPersonales_nombre :='';
          datosPersonales_apellido:='';
          datosPersonales_razonSocial:='';
          datosFacturacion_domicilio :='';
          domicilio_calle :='';
          domicilio_numero :='';
          domicilio_piso :='';
          domicilio_departamento :='';
          domicilio_localidad :='';
          domicilio_provinciaID :='';
          domicilio_provincia :='';
          domicilio_codigoPostal :='';
          datosFacturacion_condicionIva :='';
         END;
        end;
       END;


END;

closefile(ARCHIVOPROCESO);


total_registros_pagos_insertados:=total_registro;

end;





FUNCTION  txml_caba.GUARDA_TEMPORAL(informacionPago_pagoID,
                            informacionPago_dominio,
                            informacionPago_gatewayID,
                            informacionPago_entidadID,
                            informacionPago_entidadNombre,
                            informacionPago_fechaPago,
                            informacionPago_importeTotal:STRING;IDPAGODETALLEPAGO:LONGINT;
                            datosReserva_reservaID,
                            DatosReserva_estado,
                            datosReserva_esReve,
                            datosReserva_esReveDia ,
                            datosReserva_fechaReserva,
                            datosReserva_horaReserva,
                            datosReserva_fechaRegistro,
                            datosReserva_plantaID,
                            datosReserva_dominio,datosTitular_genero,
                            DatosTitular_tipoDocumento,
                            datosTitular_numeroDocumento,
                            datosTitular_numeroCuit,
                            datosTitular_nombre,
                            datosTitular_apellido,
                            datosTitular_razonSocial,datosVehiculo_dominio,
                                                  datosVehiculo_marcaID ,
                                                  datosVehiculo_marca ,
                                                  datosVehiculo_tipoID,
                                                  datosVehiculo_tipo,
                                                  datosVehiculo_modeloID,
                                                  datosVehiculo_modelo ,
                                                  numeroChasis_marca ,
                                                  numeroChasis_numero ,
                                                  datosVehiculo_anio ,
                                                  DatosVehiculo_jurisdiccionID ,
                                                  datosVehiculo_jurisdiccion ,
                                                  datosVehiculo_mtm,
                                                  datosVehiculo_valTitular ,
                                                  datosVehiculo_valChasis ,
                                                  datosValidados_marcaID ,
                                                  datosValidados_marca ,
                                                  datosValidados_tipoID ,
                                                  datosValidados_tipo ,
                                                  datosValidados_modeloID  ,
                                                  DatosValidados_modelo ,
                                                  DATosValidados_numeroChasis,
                                                  datosValidados_mtm,datosReserva_estado_DESCRICPION,ARCHIVO_XML:STRING):BOOLEAN;



VAR
aqinsertadetallepago:tsqlquery;
SSQL,FECHAPAGO,DIA,MES,ANNIO,FECHARESERVA,FECHAREGISTRO:STRING;

BEGIN
TRY
dia:=copy(trim(informacionPago_fechaPago),9,2);
mes:=copy(trim(informacionPago_fechaPago),6,2);
annio:=copy(trim(informacionPago_fechaPago),1,4);
FECHAPAGO:=dia+'/'+mes+'/'+annio;
IF (TRIM(FECHAPAGO)='//') THEN
    FECHAPAGO:=DATETOSTR(DATE);


dia:=copy(trim(datosReserva_fechaReserva),9,2);
mes:=copy(trim(datosReserva_fechaReserva),6,2);
annio:=copy(trim(datosReserva_fechaReserva),1,4);
FECHARESERVA:=dia+'/'+mes+'/'+annio;
IF (TRIM(FECHARESERVA)='//') THEN
   FECHARESERVA:=DATETOSTR(DATE);


dia:=copy(trim(datosReserva_fechaRegistro),9,2);
mes:=copy(trim(datosReserva_fechaRegistro),6,2);
annio:=copy(trim(datosReserva_fechaRegistro),1,4);
FECHAREGISTRO:=dia+'/'+mes+'/'+annio;
IF (TRIM(FECHAREGISTRO)='//') THEN
    FECHAREGISTRO:=DATETOSTR(DATE);



IF (TRIM(datosReserva_esReveDia)='') or (TRIM(datosReserva_esReveDia)='N') THEN
    datosReserva_esReveDia:='N'
   ELSE
    datosReserva_esReveDia:='S';


IF (TRIM(datosReserva_esReve)='') or (TRIM(datosReserva_esReve)='N') THEN
     datosReserva_esReve:='N'
    ELSE
     datosReserva_esReve:='S';


if (not MyBD.InTransaction) then MyBD.StartTransaction(td);
 TRY
   SSQL:=' INSERT INTO '+
        '  TMP_XML_INFORMACIONPAGO '+
        '  (IDPAGODETALLEPAGO,PAGOID,DOMINIO,GATEWAYID,ENTIDADID,ENTIDADNOMBRE,'+
           'FECHAPAGO ,IMPORTETOTAL,RESERVAID,ESTADO,ESREVE,ESREVEDIA,FECHARESERVA,HORARESERVA,'+
           'FECHAREGISTRO,PLANTAID,DOMINIO_RESERVA,TITULAR_GENERO,TITULAR_TIPODOCUMENTO,'+
           'TITULAR_NRODOCUMENTO,TITULAR_CUIT,TITULAR_NOMBRE,TITULAR_APELLIDO,'+
           'TITULAR_RAZONSOCIAL,VEHICULO_DOMINIO,VEHICULO_MARCAID ,VEHICULO_MARCA, '+
           'VEHICULO_TIPOID,VEHICULOO_TIPO , VEHICULO_MODELOID,VEHICULO_MODELO ,'+
           'VEHICULO_NUMEROCHASIS,VEHICULO_ANIO,VEHICULO_JURIDISCIONID,'+
           'VEHICULO_JURIDISCION ,VEHICULO_MTM  , '+
           'VEHICULO_VALTITULAR,'+
           'VEHICULO_VALCHASIS,'+
           'VALIDO_MARCAID , '+
           'VALIDO_MARCA , '+
           'VALIDO_TIPOID ,'+
           'VALIDO_TIPO ,  '+
           'VALIDO_MODELOID,'+
           'VALIDO_MODELO , '+
           'VALIDO_NUMEROCHASIS,'+
           'VALIDO_MTM,ESTADORESERVAD) '+
           '  VALUES ('+INTTOSTR(IDPAGODETALLEPAGO)+
                      ','+INTTOSTR(STRTOINT(informacionPago_pagoID))+
                      ','+#39+TRIM(Reemplazar_caracteres(informacionPago_dominio))+#39+
                      ','+INTTOSTR(STRTOINT(informacionPago_gatewayID))+
                      ','+INTTOSTR(STRTOINT(informacionPago_entidadID))+
                      ','+#39+TRIM(Reemplazar_caracteres(informacionPago_entidadNombre))+#39+
                      ',to_date('+#39+trim(FECHAPAGO)+#39+',''dd/mm/yyyy'')'+
                      ','+#39+TRIM(Reemplazar_caracteres(informacionPago_importeTotal))+#39+
                      ','+INTTOSTR(STRTOINT(datosReserva_reservaID))+
                      ','+#39+TRIM(Reemplazar_caracteres(DatosReserva_estado))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosReserva_esReve))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosReserva_esReveDia))+#39+
                      ',to_date('+#39+trim(FECHARESERVA)+#39+',''dd/mm/yyyy'')'+
                      ','+#39+TRIM(Reemplazar_caracteres(datosReserva_horaReserva))+#39+
                      ',to_date('+#39+trim(FECHAREGISTRO)+#39+',''dd/mm/yyyy'')'+
                      ','+#39+TRIM(Reemplazar_caracteres(datosReserva_plantaID))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosReserva_dominio))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosTitular_genero))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(DatosTitular_tipoDocumento))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosTitular_numeroDocumento))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosTitular_numeroCuit))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosTitular_nombre))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosTitular_apellido))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosTitular_razonSocial))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosVehiculo_dominio))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosVehiculo_marcaID))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosVehiculo_marca))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosVehiculo_tipoID))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosVehiculo_tipo))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosVehiculo_modeloID))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosVehiculo_modelo))+#39+
                      // ','+#39+TRIM(numeroChasis_marca)+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(numeroChasis_numero))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosVehiculo_anio))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(DatosVehiculo_jurisdiccionID))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosVehiculo_jurisdiccion))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosVehiculo_mtm))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosVehiculo_valTitular))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosVehiculo_valChasis))+#39+
                      ','+#39+TRIM(datosValidados_marcaID)+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosValidados_marca))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosValidados_tipoID))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosValidados_tipo))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosValidados_modeloID))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(DatosValidados_modelo))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(DATosValidados_numeroChasis))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosValidados_mtm))+#39+
                      ','+#39+TRIM(Reemplazar_caracteres(datosReserva_estado_DESCRICPION))+#39+')';


aqinsertadetallepago:=tsqlquery.create(nil);
aqinsertadetallepago.SQLConnection := MyBD;
aqinsertadetallepago.sql.add(SSQL);
aqinsertadetallepago.ExecSQL;


MYBD.Commit(TD);
EXCEPT

  on E : Exception do
   BEGIN
    MyBD.Rollback(TD);
    TRAZAS('ERROR REALIZAR INSERT EN TMP_XML_INFORMACIONPAGO '+E.ClassName+' error : IDPAGO: '+INTTOSTR(IDPAGODETALLEPAGO)+' '+E.Message+' . archivo: '+ARCHIVO_XML);
   END;

END;
aqinsertadetallepago.CLOSE;
aqinsertadetallepago.FREE;
   EXCEPT
   on E : Exception do
   BEGIN
   
    TRAZAS('ERROR REALIZAR INSERT EN TMP_XML_INFORMACIONPAGO '+E.ClassName+' error : IDPAGO: '+INTTOSTR(IDPAGODETALLEPAGO)+' '+E.Message+' . archivo: '+ARCHIVO_XML);
   END;

END ;

END;



FUNCTION  txml_caba.BORRAR_TEMPORAL:BOOLEAN;
VAR
aqinsertadetallepago:tsqlquery;
SSQL:STRING;

BEGIN


if (not MyBD.InTransaction) then MyBD.StartTransaction(td);

TRY


SSQL:='DELETE FROM TMP_XML_INFORMACIONPAGO';

aqinsertadetallepago:=tsqlquery.create(nil);
aqinsertadetallepago.SQLConnection := MyBD;
aqinsertadetallepago.sql.add(SSQL);
aqinsertadetallepago.ExecSQL;





MYBD.Commit(TD);
EXCEPT

  on E : Exception do
   BEGIN
    MyBD.Rollback(TD);
    TRAZAS('ERROR la borrar la temporar de TMP_XML_INFORMACIONPAGO');
   END;

END;
aqinsertadetallepago.CLOSE;
aqinsertadetallepago.FREE;






END;

FUNCTION  txml_caba.BORRAR_TEMPORAL_FERIADOS(IDF:LONGINT):BOOLEAN;
VAR
aqinsertadetallepago:tsqlquery;
SSQL:STRING;

BEGIN


if (not MyBD.InTransaction) then MyBD.StartTransaction(td);

TRY


SSQL:='DELETE FROM XML_FERIADOS WHERE FERIADOID='+INTTOSTR(IDF);

aqinsertadetallepago:=tsqlquery.create(nil);
aqinsertadetallepago.SQLConnection := MyBD;
aqinsertadetallepago.sql.add(SSQL);
aqinsertadetallepago.ExecSQL;





MYBD.Commit(TD);
EXCEPT

  on E : Exception do
   BEGIN
    MyBD.Rollback(TD);
    TRAZAS('ERROR la borrar la temporar de TMP_XML_INFORMACIONPAGO');
   END;

END;
aqinsertadetallepago.CLOSE;
aqinsertadetallepago.FREE;






END;


FUNCTION txml_caba.LEER_TAGS_ARCHIVO_XML_PAGOS_ver2(ARCHIVO,ARCHIVO_XML:STRING):BOOLEAN;
VAR LINEA,X:STRING;
    S,ENTRADAA:LONGINT;
    GUARDAR:BOOLEAN;

{VARIALES TAG DETALLESPAGO}
detallesPago_pagoID:STRING;
detallesPago_plantaID:STRING;
detallesPago_importe :STRING;
detallesPago_importe_total:string;
detallesPago_estadoAcreditacion:STRING;
detallesPago_estadoAcreditacionD :STRING;
detallesPago_pagoGatewayID :STRING;
detallesPago_tipoBoleta :STRING;
detallesPago_fechaNovedad :STRING;
detallesPago_fechaPago :STRING;
detallesPago_codigoPago:STRING;
detallesPago_pagoForzado:STRING;


{VARIALES TAG INFORMACIONPAGO}
informacionPago_pagoID:STRING;
informacionPago_dominio :STRING;
informacionPago_gatewayID :STRING;
informacionPago_entidadID :STRING;
informacionPago_entidadNombre:STRING;
informacionPago_fechaPago :STRING ;
informacionPago_importeTotal :STRING;

{VARIALES TAG DATOSRESERVAS}
datosReserva_reservaID :STRING;
datosReserva_estado :STRING;
datosReserva_esReve:STRING;
datosReserva_estado_DESCRICPION:string;
datosReserva_esReveDia:STRING;
datosReserva_fechaReserva :STRING;
datosReserva_horaReserva :STRING;
datosReserva_fechaRegistro :STRING;
datosReserva_plantaID :STRING;
datosReserva_dominio :STRING;

{VARIALES TAG DATOSTITULAR}
datosTitular_genero:STRING;
datosTitular_tipoDocumento :STRING;
datosTitular_numeroDocumento :STRING;
datosTitular_numeroCuit :STRING;
datosTitular_nombre :STRING;
datosTitular_apellido :STRING;
datosTitular_razonSocial :STRING;

{VARIALES TAG DATOSVEHICULOS}
datosVehiculo_dominio :STRING;
datosVehiculo_marcaID :STRING;
datosVehiculo_marca :STRING;
Vehiculo_tipoID :STRING;
datosVehiculo_tipo :STRING;
datosVehiculo_modeloID :STRING;
datosVehiculo_modelo :STRING;
numeroChasis_marca:STRING;
numeroChasis_numero :STRING;
datosVehiculo_anio :STRING;
datosVehiculo_jurisdiccionID :STRING;
datosVehiculo_jurisdiccion :STRING;
datosVehiculo_mtm :STRING;
datosVehiculo_valTitular :STRING;
datosVehiculo_valChasis :STRING;
datosValidados_marcaID :STRING;
datosValidados_marca :STRING;
datosValidados_tipoID :STRING;
datosValidados_tipo :STRING;
datosValidados_modeloID :STRING;
datosValidados_modelo :STRING;
datosValidados_numeroChasis:STRING;
datosValidados_mtm:STRING;

{VARIALES TAG DATOSPERSONALES}
datosPersonalesTurno_genero :STRING;
datosPersonalesTurno_tipoDocumento :STRING;
DatosPersonalesTurno_numeroDocumento :STRING;
datosPersonalesTurno_numeroCuit:STRING;
datosPersonalesTurno_nombre :STRING;
datosPersonalesTurno_apellido :STRING;
datosPersonalesTurno_razonSocial :STRING;

{VARIALES TAG DATOSTCONTACTOS}
contactoTurno_telefonoCelular :STRING;
contactoTurno_email :STRING;
contactoTurno_fechaNacimiento :STRING;

ii,sigue:longint;
{VARIALES TAG DATOSTFACTRUACION}
datosPersonales_genero :STRING;
datosPersonales_tipoDocumento :STRING;
datosPersonales_numeroDocumento :STRING;
datosPersonales_numeroCuit :STRING;
datosPersonales_nombre :STRING;
datosPersonales_apellido:STRING;
datosPersonales_razonSocial:STRING;
datosFacturacion_domicilio :STRING;
domicilio_calle :STRING;
domicilio_numero :STRING;
domicilio_piso :STRING;
domicilio_departamento :STRING;
domicilio_localidad :STRING;
domicilio_provinciaID :STRING;
domicilio_provincia :STRING;
domicilio_codigoPostal :STRING;
datosFacturacion_condicionIva :STRING;
cantidadPagosRelacionados:STRING;

leyo ,continua_pago:boolean;
item_pago,total_registro,po:longint;
GUARDAR2,continua:boolean;
cantidad_de_pagos:longint;
GUARDAR_EN_BASE:BOOLEAN;
ARCHIVOPROCESO1:TEXTFILE;
begin
TRY
detallesPago_pagoID:='';
detallesPago_plantaID:='';
detallesPago_importe :='';
detallesPago_importe_total:='';
detallesPago_estadoAcreditacion:='';
detallesPago_estadoAcreditacionD :='';
detallesPago_pagoGatewayID :='';
detallesPago_tipoBoleta :='';
detallesPago_fechaNovedad :='';
detallesPago_fechaPago :='';
informacionPago_pagoID:='';
InformacionPago_dominio :='';
informacionPago_gatewayID :='';
informacionPago_entidadID :='';
informacionPago_entidadNombre:='';
informacionPago_fechaPago :='';
informacionPago_importeTotal :='';
datosReserva_reservaID :='';
datosReserva_estado :='';
datosReserva_esReve:='';
datosReserva_esReveDia:='';
datosReserva_fechaReserva :='';
datosReserva_horaReserva :='';
datosReserva_fechaRegistro :='';
datosReserva_plantaID :='';
datosReserva_dominio :='';
datosTitular_genero:='';
datosTitular_tipoDocumento :='';
datosTitular_numeroDocumento :='';
datosTitular_numeroCuit :='';
datosTitular_nombre :='';
datosTitular_apellido :='';
datosTitular_razonSocial :='';
datosVehiculo_dominio :='';
datosVehiculo_marcaID :='';
datosVehiculo_marca :='';
Vehiculo_tipoID :='';
datosVehiculo_tipo :='';
datosVehiculo_modeloID :='';
datosVehiculo_modelo :='';
numeroChasis_marca:='';
numeroChasis_numero :='';
datosVehiculo_anio :='';
datosVehiculo_jurisdiccionID :='';
datosVehiculo_jurisdiccion :='';
datosVehiculo_mtm :='';
datosVehiculo_valTitular :='';
datosVehiculo_valChasis :='';
datosValidados_marcaID :='';
datosValidados_marca :='';
datosValidados_tipoID :='';
datosValidados_tipo :='';
datosValidados_modeloID :='';
datosValidados_modelo :='';
datosValidados_numeroChasis:='';
datosValidados_mtm:='';
datosPersonalesTurno_genero :='';
datosPersonalesTurno_tipoDocumento :='';
datosPersonalesTurno_numeroDocumento :='';
datosPersonalesTurno_numeroCuit:='';
datosPersonalesTurno_nombre :='';
datosPersonalesTurno_apellido :='';
datosPersonalesTurno_razonSocial :='';
contactoTurno_telefonoCelular :='';
contactoTurno_email :='';
contactoTurno_fechaNacimiento :='';
datosPersonales_genero :='';
datosPersonales_tipoDocumento :='';
datosPersonales_numeroDocumento :='';
datosPersonales_numeroCuit :='';
datosPersonales_nombre :='';
datosPersonales_apellido:='';
datosPersonales_razonSocial:='';
datosFacturacion_domicilio :='';
domicilio_calle :='';
domicilio_numero :='';
domicilio_piso :='';
domicilio_departamento :='';
domicilio_localidad :='';
domicilio_provinciaID :='';
domicilio_provincia :='';
domicilio_codigoPostal :='';
datosFacturacion_condicionIva :='';
GUARDAR:=FALSE;
GUARDAR2:=false;
S:=0;
ii:=0;
sigue:=0;
cantidad_de_pagos:=0;
total_registro:=0;
leyo:=false;
continua_pago:=true;

{ABRE ARCHIVO}
ASSIGNFILE(ARCHIVOPROCESO1,ARCHIVO);
RESET(ARCHIVOPROCESO1);
while (not eof(ARCHIVOPROCESO1)) or (trim(linea)<>'**FIN**') do
begin
TRY
 {LEE TAG}
 readln(ARCHIVOPROCESO1,linea);

 if (trim(es_linea(linea))=trim(es_linea('cantidadPagos'))) then
     cantidad_de_pagos:=strtoint(trim(extrae_valor_PAGOS(trim(linea))));



             if (trim(es_linea(linea))=trim(es_linea('DATOSPAGOVTV'))) or (sigue=1) then
             begin
             BORRAR_TEMPORAL;
                sigue:=1;
                readln(ARCHIVOPROCESO1,linea);
                while sigue = 1 do
                begin
                     readln(ARCHIVOPROCESO1,linea);
                       {TAG DETALLES PAGO}
                      if (trim(es_linea(linea))=trim(es_linea('DETALLESPAGO'))) then
                          begin
                                continua:=true;
                                while continua=true do
                                begin
                                    readln(ARCHIVOPROCESO1,linea);
                                    if trim(es_linea(linea))=trim(es_linea('externalReference')) then
                                        detallesPago_pagoID:=trim(extrae_valor_PAGOS(trim(linea)));

                                    if trim(es_linea(linea))=trim(es_linea('plantaID')) then
                                       detallesPago_plantaID:=trim(extrae_valor_PAGOS(trim(linea)));

                                  {  if trim(es_linea(linea))=trim(es_linea('importe')) then
                                        detallesPago_importe:=trim(extrae_valor_PAGOS(trim(linea)));
                                    }
                                    if trim(es_linea(linea))=trim(es_linea('importe')) then
                                      begin
                                         detallesPago_importe:=trim(extrae_valor_PAGOS(trim(linea)));


                                         po:=pos('.',trim(detallesPago_importe));
                                          if length(trim(copy(trim(detallesPago_importe),po+1,length(trim(detallesPago_importe)))))=1 then
                                             detallesPago_importe:=detallesPago_importe+'0';
                                       end;

                                      if trim(es_linea(linea))=trim(es_linea('importeVerificacion')) then
                                      begin
                                         detallesPago_importe:=trim(extrae_valor_PAGOS(trim(linea)));


                                         po:=pos('.',trim(detallesPago_importe));
                                          if length(trim(copy(trim(detallesPago_importe),po+1,length(trim(detallesPago_importe)))))=1 then
                                             detallesPago_importe:=detallesPago_importe+'0';
                                       end;

                                        if trim(es_linea(linea))=trim(es_linea('importeTotal')) then
                                      begin
                                         detallesPago_importe_total:=trim(extrae_valor_PAGOS(trim(linea)));


                                         po:=pos('.',trim(detallesPago_importe_total));
                                          if length(trim(copy(trim(detallesPago_importe_total),po+1,length(trim(detallesPago_importe_total)))))=1 then
                                             detallesPago_importe_total:=detallesPago_importe_total+'0';
                                       end;

                                    if trim(es_linea(linea))=trim(es_linea('estadoAcreditacion')) then
                                        detallesPago_estadoAcreditacion:=trim(extrae_valor_PAGOS(trim(linea)));

                                    if trim(es_linea(linea))=trim(es_linea('estadoAcreditacionD')) then
                                        detallesPago_estadoAcreditacionD:=trim(extrae_valor_PAGOS(trim(linea)));


                                    if trim(es_linea(linea))=trim(es_linea('codigoPago')) then
                                        detallesPago_codigoPago:=trim(extrae_valor_PAGOS(trim(linea)));

                                    if trim(es_linea(linea))=trim(es_linea('gatewayID')) then
                                       detallesPago_pagoGatewayID:=trim(extrae_valor_PAGOS(trim(linea)));


                                    if trim(es_linea(linea))=trim(es_linea('tipoBoleta')) then
                                       detallesPago_tipoBoleta:=trim(extrae_valor_PAGOS(trim(linea)));

                                    if trim(es_linea(linea))=trim(es_linea('fechaNovedad')) then
                                       detallesPago_fechaNovedad:=trim(extrae_valor_PAGOS(trim(linea)));

                                    if trim(es_linea(linea))=trim(es_linea('fechaPago')) then
                                        detallesPago_fechaPago:=trim(extrae_valor_PAGOS(trim(linea)));

                                      if trim(es_linea(linea))=trim(es_linea('pagoForzado')) then
                                        detallesPago_pagoForzado:=trim(extrae_valor_PAGOS(trim(linea)));

                                      if trim(es_linea(linea))=trim(es_linea('cantidadPagosRelacionados')) then
                                      BEGIN
                                        cantidadPagosRelacionados:=trim(extrae_valor_PAGOS(trim(linea)));

                                         IF TRIM(cantidadPagosRelacionados)='' THEN
                                            cantidadPagosRelacionados:='0';

                                         IF TRIM(cantidadPagosRelacionados)='0' THEN
                                           BEGIN
                                            continua:=false;
                                             SIGUE:=0;
                                           END;

                                      END;


                                    if trim(es_linea(linea))=trim(es_linea('PAGOSRELACIONADOS')) then
                                       continua:=false;

                                     if trim(es_linea(linea))=trim(es_linea('**FIN**')) then
                                        continua:=false;


                                end;


                          end;  //detalles pago


                    {******************************************************************************}
             if SIGUE=1 then
             begin




                          {TAG PAGOSRELACIOANDOS}
                        if (trim(es_linea(linea))=trim(es_linea('PAGOSRELACIONADOS'))) then
                          begin
                                ENTRADAA:=0;
                                continua:=true;
                                GUARDAR_EN_BASE:=FALSE;
                                while continua=true do
                                begin
                                     readln(ARCHIVOPROCESO1,linea);

                                     {ARMA LA ANTRADA PARA LOS SUBITEM DE PAGOSRELACIONADOS}


                                     if trim(es_linea(linea))=trim(es_linea('DATOSCONTACTO')) then
                                       continua:=false;

                                     if trim(es_linea(linea))=trim(es_linea('**FIN**')) then
                                        continua:=false;

                                      if trim(es_linea(linea))=trim(es_linea('INFORMACIONPAGO')) then
                                         ENTRADAA:=1;


                                      if trim(es_linea(linea))=trim(es_linea('DATOSRESERVA')) then
                                         ENTRADAA:=2;

                                      if trim(es_linea(linea))=trim(es_linea('DATOSTITULAR')) then
                                         ENTRADAA:=3;

                                      if trim(es_linea(linea))=trim(es_linea('DATOSVEHICULO')) then
                                         ENTRADAA:=4;


                                      if ((trim(es_linea(linea))=trim(es_linea('NUMEROCHASIS'))) AND (ENTRADAA < 5))  then
                                         ENTRADAA:=5;


                                     if trim(es_linea(linea))=trim(es_linea('DATOSVALIDADOS')) then
                                         ENTRADAA:=6;

                                       if (trim(es_linea(linea))=trim(es_linea('DATOSCONTACTO')))
                                          OR ((Trim(es_linea(linea))=trim(es_linea('ITEM'))) AND (ENTRADAA >=4)) then
                                          GUARDAR_EN_BASE:=TRUE;




                                        {GUARDAR EN LA TABLA TEMPORAL}
                                          IF GUARDAR_EN_BASE=TRUE THEN
                                           BEGIN

                                                GUARDA_TEMPORAL(informacionPago_pagoID,
                                                                informacionPago_dominio,
                                                                informacionPago_gatewayID,
                                                                informacionPago_entidadID,
                                                                informacionPago_entidadNombre,
                                                                informacionPago_fechaPago,
                                                                informacionPago_importeTotal,STRTOINT(detallesPago_pagoID),
                                                                datosReserva_reservaID,
                                                                DatosReserva_estado,
                                                                datosReserva_esReve,
                                                                datosReserva_esReveDia ,
                                                                datosReserva_fechaReserva,
                                                                datosReserva_horaReserva,
                                                                datosReserva_fechaRegistro,
                                                                datosReserva_plantaID,
                                                                datosReserva_dominio,datosTitular_genero,
                                                                DatosTitular_tipoDocumento,
                                                                datosTitular_numeroDocumento,
                                                                datosTitular_numeroCuit,
                                                                datosTitular_nombre,
                                                                datosTitular_apellido,
                                                                datosTitular_razonSocial,
                                                                datosVehiculo_dominio,
                                                                datosVehiculo_marcaID ,
                                                                datosVehiculo_marca ,
                                                                datosVehiculo_tipoID,
                                                                datosVehiculo_tipo,
                                                                datosVehiculo_modeloID,
                                                                datosVehiculo_modelo ,
                                                                numeroChasis_marca ,
                                                                 numeroChasis_numero ,
                                                               datosVehiculo_anio ,
                                                               DatosVehiculo_jurisdiccionID ,
                                                               datosVehiculo_jurisdiccion ,
                                                               datosVehiculo_mtm,
                                                               datosVehiculo_valTitular ,
                                                               datosVehiculo_valChasis ,
                                                               datosValidados_marcaID ,
                                                               datosValidados_marca ,
                                                               datosValidados_tipoID ,
                                                               datosValidados_tipo ,
                                                               datosValidados_modeloID  ,
                                                               DatosValidados_modelo ,
                                                                DATosValidados_numeroChasis,
                                                               datosValidados_mtm,datosReserva_estado_DESCRICPION,ARCHIVO_XML);

                                               GUARDAR_EN_BASE:=FALSE;
                                           END;




                                        {TAG PAGORELACIONADOS SUBITEM INFORMACIONPAGO}
                                       if ENTRADAA=1 then
                                       begin
                                             if trim(es_linea(linea))=trim(es_linea('pagoID')) then
                                                informacionPago_pagoID:=trim(extrae_valor_PAGOS(trim(linea)));


                                             if trim(es_linea(linea))=trim(es_linea('dominio')) then
                                                informacionPago_dominio:=trim(extrae_valor_PAGOS(trim(linea)));



                                             if trim(es_linea(linea))=trim(es_linea('gatewayID')) then
                                                informacionPago_gatewayID:=trim(extrae_valor_PAGOS(trim(linea)));


                                             if trim(es_linea(linea))=trim(es_linea('entidadID')) then
                                                informacionPago_entidadID:=trim(extrae_valor_PAGOS(trim(linea)));


                                             if trim(es_linea(linea))=trim(es_linea('entidadNombre')) then
                                                informacionPago_entidadNombre:=trim(extrae_valor_PAGOS(trim(linea)));


                                             if trim(es_linea(linea))=trim(es_linea('fechaPago')) then
                                                informacionPago_fechaPago:=trim(extrae_valor_PAGOS(trim(linea)));


                                             if trim(es_linea(linea))=trim(es_linea('importeTotal')) then
                                                 informacionPago_importeTotal:=trim(extrae_valor_PAGOS(trim(linea)));

                                       end;

                                         {TAG PAGORELACIONADOS SUBITEM datosreserva}
                                        if ENTRADAA=2 then
                                        begin
                                            if trim(es_linea(linea))=trim(es_linea('reservaID')) then
                                               datosReserva_reservaID:=trim(extrae_valor_PAGOS(trim(linea)));

                                            if trim(es_linea(linea))=trim(es_linea('estado')) then
                                               datosReserva_estado:=trim(extrae_valor_PAGOS(trim(linea)));

                                            if trim(es_linea(linea))=trim(es_linea('estadoNombre')) then
                                               datosReserva_estado_DESCRICPION:=trim(extrae_valor_PAGOS(trim(linea)));

                                            if trim(es_linea(linea))=trim(es_linea('esReve')) then
                                               datosReserva_esReve:=trim(extrae_valor_PAGOS(trim(linea)));

                                            if trim(es_linea(linea))=trim(es_linea('esReveDia')) then
                                               datosReserva_esReveDia:=trim(extrae_valor_PAGOS(trim(linea)));


                                            if trim(es_linea(linea))=trim(es_linea('fechaReserva')) then
                                               datosReserva_fechaReserva:=trim(extrae_valor_PAGOS(trim(linea)));


                                            if trim(es_linea(linea))=trim(es_linea('horaReserva')) then
                                               datosReserva_horaReserva:=trim(extrae_valor_PAGOS(trim(linea)));


                                            if trim(es_linea(linea))=trim(es_linea('fechaRegistro')) then
                                               datosReserva_fechaRegistro:=trim(extrae_valor_PAGOS(trim(linea)));


                                            if trim(es_linea(linea))=trim(es_linea('plantaID')) then
                                               datosReserva_plantaID:=trim(extrae_valor_PAGOS(trim(linea)));


                                            if trim(es_linea(linea))=trim(es_linea('dominio')) then
                                               datosReserva_dominio:=trim(extrae_valor_PAGOS(trim(linea)));

                                        end;

                                          {TAG PAGORELACIONADOS SUBITEM DATOSTITULAR}
                                        if  ENTRADAA=3 then
                                        begin

                                             if trim(es_linea(linea))=trim(es_linea('genero')) then
                                                datosTitular_genero:=trim(extrae_valor_PAGOS(trim(linea)));

                                            if trim(es_linea(linea))=trim(es_linea('tipoDocumento')) then
                                               datosTitular_tipoDocumento:=trim(extrae_valor_PAGOS(trim(linea)));

                                            if trim(es_linea(linea))=trim(es_linea('numeroDocumento')) then
                                               datosTitular_numeroDocumento:=trim(extrae_valor_PAGOS(trim(linea)));

                                            if trim(es_linea(linea))=trim(es_linea('numeroCuit')) then
                                               datosTitular_numeroCuit:=trim(extrae_valor_PAGOS(trim(linea)));

                                            if trim(es_linea(linea))=trim(es_linea('nombre')) then
                                               //datosTitular_nombre:=trim(extrae_valor_PAGOS(trim(linea)));
                                               datosTitular_nombre:=StringReplace(trim(extrae_valor_PAGOS(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);


                                            if trim(es_linea(linea))=trim(es_linea('apellido')) then
                                               datosTitular_apellido:=StringReplace(trim(extrae_valor_PAGOS(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);



                                            if trim(es_linea(linea))=trim(es_linea('razonSocial')) then
                                                 datosTitular_razonSocial:=StringReplace(trim(extrae_valor_PAGOS(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);




                                        end;


                                          {TAG PAGORELACIONADOS SUBITEM DATOSVEHICULO}
                                         IF ENTRADAA=4 THEN
                                            BEGIN

                                              if trim(es_linea(linea))=trim(es_linea('dominio')) then
                                                  datosVehiculo_dominio:=trim(extrae_valor_PAGOS(trim(linea)));


                                              if trim(es_linea(linea))=trim(es_linea('marcaID')) then
                                                  datosVehiculo_marcaID:=trim(extrae_valor_PAGOS(trim(linea)));

                                              if trim(es_linea(linea))=trim(es_linea('marca')) then
                                                  datosVehiculo_marca:=trim(extrae_valor_PAGOS(trim(linea)));


                                              if trim(es_linea(linea))=trim(es_linea('tipoID')) then
                                                 datosVehiculo_tipoID:=trim(extrae_valor_PAGOS(trim(linea)));


                                              if trim(es_linea(linea))=trim(es_linea('tipo')) then
                                                 datosVehiculo_tipo:=trim(extrae_valor_PAGOS(trim(linea)));

                                              if trim(es_linea(linea))=trim(es_linea('modeloID')) then
                                                 datosVehiculo_modeloID:=trim(extrae_valor_PAGOS(trim(linea)));

                                              if trim(es_linea(linea))=trim(es_linea('modelo')) then
                                                 datosVehiculo_modelo:=trim(extrae_valor_PAGOS(trim(linea)));

                                          end;

                                           {TAG PAGORELACIONADOS SUBITEM NUMEROCHASIS}
                                          if ENTRADAA=5 THEN
                                            begin

                                              if trim(es_linea(linea))=trim(es_linea('marca')) then
                                                 numeroChasis_marca:=trim(extrae_valor_PAGOS(trim(linea)));


                                              if trim(es_linea(linea))=trim(es_linea('numero')) then
                                                 numeroChasis_numero:=trim(extrae_valor_PAGOS(trim(linea)));


                                              if trim(es_linea(linea))=trim(es_linea('anio')) then
                                                 datosVehiculo_anio:=trim(extrae_valor_PAGOS(trim(linea)));

                                              if trim(es_linea(linea))=trim(es_linea('jurisdiccionID')) then
                                                   datosVehiculo_jurisdiccionID:=trim(extrae_valor_PAGOS(trim(linea)));


                                              if trim(es_linea(linea))=trim(es_linea('jurisdiccion')) then
                                                  datosVehiculo_jurisdiccion:=trim(extrae_valor_PAGOS(trim(linea)));


                                              if trim(es_linea(linea))=trim(es_linea('mtm')) then
                                                  datosVehiculo_mtm:=trim(extrae_valor_PAGOS(trim(linea)));

                                              if trim(es_linea(linea))=trim(es_linea('valTitular')) then
                                                    datosVehiculo_valTitular:=trim(extrae_valor_PAGOS(trim(linea)));

                                              if trim(es_linea(linea))=trim(es_linea('valChasis')) then
                                                  datosVehiculo_valChasis:=trim(extrae_valor_PAGOS(trim(linea)));

                                          end;

                                           {TAG PAGORELACIONADOS SUBITEM DATOSVALIDOS}
                                          if  ENTRADAA=6 THEN
                                          BEGIN
                                              if trim(es_linea(linea))=trim(es_linea('marcaID')) then
                                                  datosValidados_marcaID:=trim(extrae_valor_PAGOS(trim(linea)));

                                              if trim(es_linea(linea))=trim(es_linea('marca')) then
                                                  datosValidados_marca:=trim(extrae_valor_PAGOS(trim(linea)));

                                               if trim(es_linea(linea))=trim(es_linea('tipoID')) then
                                                datosValidados_tipoID:=trim(extrae_valor_PAGOS(trim(linea)));


                                               if trim(es_linea(linea))=trim(es_linea('tipo')) then
                                                  datosValidados_tipo:=trim(extrae_valor_PAGOS(trim(linea)));

                                               if trim(es_linea(linea))=trim(es_linea('modeloID')) then
                                                  datosValidados_modeloID:=trim(extrae_valor_PAGOS(trim(linea)));


                                               if trim(es_linea(linea))=trim(es_linea('modelo')) then
                                                   datosValidados_modelo:=trim(extrae_valor_PAGOS(trim(linea)));


                                               if trim(es_linea(linea))=trim(es_linea('numeroChasis')) then
                                                     datosValidados_numeroChasis:=trim(extrae_valor_PAGOS(trim(linea)));

                                               if trim(es_linea(linea))=trim(es_linea('mtm')) then
                                                       datosValidados_mtm:=trim(extrae_valor_PAGOS(trim(linea)));


                                            END;




                                end;


                          end;  {FIN TAG PAGORELACIONADOS  PAGOSRELACIONADOS}


                         { TAG  DATOSCONTACTO}
                        if (trim(es_linea(linea))=trim(es_linea('DATOSCONTACTO'))) then
                          begin
                                ENTRADAA:=0;
                                continua:=true;
                                while continua=true do
                                begin
                                      readln(ARCHIVOPROCESO1,linea);

                                     if trim(es_linea(linea))=trim(es_linea('DATOSFACTURACION')) then
                                       continua:=false;

                                     if trim(es_linea(linea))=trim(es_linea('**FIN**')) then
                                        continua:=false;


                                     if trim(es_linea(linea))=trim(es_linea('genero')) then
                                        datosPersonalesTurno_genero:=trim(extrae_valor_PAGOS(trim(linea)));


                                     if trim(es_linea(linea))=trim(es_linea('tipoDocumento')) then
                                        datosPersonalesTurno_tipoDocumento:=trim(extrae_valor_PAGOS(trim(linea)));

                                     if trim(es_linea(linea))=trim(es_linea('numeroDocumento')) then
                                       datosPersonalesTurno_numeroDocumento:=trim(extrae_valor_PAGOS(trim(linea)));


                                     if trim(es_linea(linea))=trim(es_linea('numeroCuit')) then
                                        datosPersonalesTurno_numeroCuit:=trim(extrae_valor_PAGOS(trim(linea)));


                                     if trim(es_linea(linea))=trim(es_linea('nombre')) then
                                       datosPersonalesTurno_nombre:=StringReplace(trim(extrae_valor_PAGOS(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);



                                     if trim(es_linea(linea))=trim(es_linea('apellido')) then
                                        datosPersonalesTurno_apellido:=StringReplace(trim(extrae_valor_PAGOS(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);



                                     if trim(es_linea(linea))=trim(es_linea('razonSocial')) then
                                        datosPersonalesTurno_razonSocial:=StringReplace(trim(extrae_valor_PAGOS(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);




                                     if trim(es_linea(linea))=trim(es_linea('telefonoCelular')) then
                                        contactoTurno_telefonoCelular:=trim(extrae_valor_PAGOS(trim(linea)));

                                      if trim(es_linea(linea))=trim(es_linea('email')) then
                                         contactoTurno_email:=trim(extrae_valor_PAGOS(trim(linea)));


                                     if trim(es_linea(linea))=trim(es_linea('fechaNacimiento')) then
                                        contactoTurno_fechaNacimiento:=trim(extrae_valor_PAGOS(trim(linea)));








                                END;

                        END;



                             { TAG  DATOSFACTURACION}
                            if (trim(es_linea(linea))=trim(es_linea('DATOSFACTURACION'))) then
                          begin
                                ENTRADAA:=0;
                                continua:=true;
                                while continua=true do
                                begin
                                      readln(ARCHIVOPROCESO1,linea);

                                     if trim(es_linea(linea))=trim(es_linea('ITEM')) then
                                       continua:=false;

                                     if trim(es_linea(linea))=trim(es_linea('**FIN**')) then
                                        continua:=false;

                                     if trim(es_linea(linea))=trim(es_linea('genero')) then
                                        datosPersonales_genero:=trim(extrae_valor_PAGOS(trim(linea)));


                                     if trim(es_linea(linea))=trim(es_linea('tipoDocumento')) then
                                         datosPersonales_tipoDocumento:=trim(extrae_valor_PAGOS(trim(linea)));

                                     if trim(es_linea(linea))=trim(es_linea('numeroDocumento')) then
                                        datosPersonales_numeroDocumento:=trim(extrae_valor_PAGOS(trim(linea)));

                                     if trim(es_linea(linea))=trim(es_linea('numeroCuit')) then
                                        datosPersonales_numeroCuit:=trim(extrae_valor_PAGOS(trim(linea)));

                                     if trim(es_linea(linea))=trim(es_linea('nombre')) then
                                        datosPersonales_nombre:=StringReplace(trim(extrae_valor_PAGOS(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);


                                     if trim(es_linea(linea))=trim(es_linea('apellido')) then
                                        datosPersonales_apellido:=StringReplace(trim(extrae_valor_PAGOS(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);


                                     if trim(es_linea(linea))=trim(es_linea('razonSocial')) then
                                        datosPersonales_razonSocial:=StringReplace(trim(extrae_valor_PAGOS(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);
;

                                     if trim(es_linea(linea))=trim(es_linea('domicilio')) then
                                        datosFacturacion_domicilio:=StringReplace(trim(extrae_valor_PAGOS(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);


                                     if trim(es_linea(linea))=trim(es_linea('calle')) then
                                        domicilio_calle:=StringReplace(trim(extrae_valor_PAGOS(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);


                                     if trim(es_linea(linea))=trim(es_linea('numero')) then
                                        domicilio_numero:=trim(extrae_valor_PAGOS(trim(linea)));

                                     if trim(es_linea(linea))=trim(es_linea('piso')) then
                                        domicilio_piso:=trim(extrae_valor_PAGOS(trim(linea)));

                                     if trim(es_linea(linea))=trim(es_linea('departamento')) then
                                        domicilio_departamento:=trim(extrae_valor_PAGOS(trim(linea)));

                                     if trim(es_linea(linea))=trim(es_linea('localidad')) then
                                        domicilio_localidad:=trim(extrae_valor_PAGOS(trim(linea)));

                                     if trim(es_linea(linea))=trim(es_linea('provinciaID')) then
                                         domicilio_provinciaID:=trim(extrae_valor_PAGOS(trim(linea)));

                                     if trim(es_linea(linea))=trim(es_linea('provincia')) then
                                        domicilio_provincia:=trim(extrae_valor_PAGOS(trim(linea)));

                                      if trim(es_linea(linea))=trim(es_linea('codigoPostal')) then
                                        domicilio_codigoPostal:=trim(extrae_valor_PAGOS(trim(linea)));

                                      if trim(es_linea(linea))=trim(es_linea('condicionIva')) then
                                         datosFacturacion_condicionIva:=trim(extrae_valor_PAGOS(trim(linea)));

                                END;

                        END;


                        {CONTROL PARA GUARDAR EN LA BASE DE DATOS}
                        if (trim(es_linea(linea))=trim(es_linea('ITEM'))) OR  (trim(es_linea(linea))=trim(es_linea('**FIN**')))  then
                          BEGIN
                          

                                {CONTROL PARA SABER SI HACER  INSERT O  UPDATE VALIDADO EL PAGOID}
                             IF TRIM(SELECCION_OPERACION_XML(STRTOINT(detallesPago_pagoID),detallesPago_estadoAcreditacion))='INSERTA' THEN
                                 BEGIN

                                  {INSERTA EL XML}
                                   GARRDAR_XML_PAGOS(detallesPago_pagoID,
                                                detallesPago_plantaID,
                                                detallesPago_importe,
                                                detallesPago_estadoAcreditacion,
                                                detallesPago_estadoAcreditacionD,
                                                detallesPago_pagoGatewayID,
                                                detallesPago_tipoBoleta,
                                                detallesPago_fechaNovedad,
                                                detallesPago_fechaPago,
                                                datosPersonalesTurno_genero,
                                                datosPersonalesTurno_tipoDocumento,
                                                datosPersonalesTurno_numeroDocumento,
                                                datosPersonalesTurno_numeroCuit,
                                                datosPersonalesTurno_nombre,
                                                datosPersonalesTurno_apellido,
                                                datosPersonalesTurno_razonSocial,
                                                contactoTurno_telefonoCelular,
                                                contactoTurno_email,
                                                contactoTurno_fechaNacimiento,
                                                datosPersonales_genero,
                                                datosPersonales_tipoDocumento,
                                                datosPersonales_numeroDocumento,
                                                datosPersonales_numeroCuit,
                                                datosPersonales_nombre,
                                                datosPersonales_apellido,
                                                datosPersonales_razonSocial,
                                                datosFacturacion_domicilio,
                                                domicilio_calle,
                                                domicilio_numero,
                                                domicilio_piso,
                                                domicilio_departamento,
                                                domicilio_localidad,
                                                domicilio_provinciaID,
                                                domicilio_provincia,
                                                domicilio_codigoPostal,
                                                datosFacturacion_condicionIva,ARCHIVO_XML,detallesPago_pagoForzado,detallesPago_codigoPago);

                                 END ELSE
                                 BEGIN
                                 {HACER UPDATE}
                                 {
                                   MODIFICA_XML_PAGOS(detallesPago_pagoID,
                                                detallesPago_plantaID,
                                                detallesPago_importe,
                                                detallesPago_estadoAcreditacion,
                                                detallesPago_estadoAcreditacionD,
                                                detallesPago_pagoGatewayID,
                                                detallesPago_tipoBoleta,
                                                detallesPago_fechaNovedad,
                                                detallesPago_fechaPago,
                                                datosPersonalesTurno_genero,
                                                datosPersonalesTurno_tipoDocumento,
                                                datosPersonalesTurno_numeroDocumento,
                                                datosPersonalesTurno_numeroCuit,
                                                datosPersonalesTurno_nombre,
                                                datosPersonalesTurno_apellido,
                                                datosPersonalesTurno_razonSocial,
                                                contactoTurno_telefonoCelular,
                                                contactoTurno_email,
                                                contactoTurno_fechaNacimiento,
                                                datosPersonales_genero,
                                                datosPersonales_tipoDocumento,
                                                datosPersonales_numeroDocumento,
                                                datosPersonales_numeroCuit,
                                                datosPersonales_nombre,
                                                datosPersonales_apellido,
                                                datosPersonales_razonSocial,
                                                datosFacturacion_domicilio,
                                                domicilio_calle,
                                                domicilio_numero,
                                                domicilio_piso,
                                                domicilio_departamento,
                                                domicilio_localidad,
                                                domicilio_provinciaID,
                                                domicilio_provincia,
                                                domicilio_codigoPostal,
                                                datosFacturacion_condicionIva,ARCHIVO_XML);
                                        }

                                 END;




          detallesPago_pagoID:='';
          detallesPago_plantaID:='';
          detallesPago_importe :='';
          detallesPago_estadoAcreditacion:='';
          detallesPago_estadoAcreditacionD :='';
          detallesPago_pagoGatewayID :='';
          detallesPago_tipoBoleta :='';
          detallesPago_fechaNovedad :='';
          detallesPago_fechaPago :='';


          informacionPago_pagoID:='';
          informacionPago_dominio :='';
          informacionPago_gatewayID :='';
          informacionPago_entidadID :='';
          informacionPago_entidadNombre:='';
          informacionPago_fechaPago :='';
          informacionPago_importeTotal :='';


          datosReserva_reservaID :='';
          datosReserva_estado :='';
          datosReserva_esReve:='';
          datosReserva_esReveDia:='';
          datosReserva_fechaReserva :='';
          datosReserva_horaReserva :='';
          datosReserva_fechaRegistro :='';
          datosReserva_plantaID :='';
          datosReserva_dominio :='';

          datosTitular_genero:='';
          datosTitular_tipoDocumento :='';
          datosTitular_numeroDocumento :='';
          datosTitular_numeroCuit :='';
          datosTitular_nombre :='';
          datosTitular_apellido :='';
          datosTitular_razonSocial :='';

          datosVehiculo_dominio :='';
          datosVehiculo_marcaID :='';
          datosVehiculo_marca :='';
          Vehiculo_tipoID :='';
          datosVehiculo_tipo :='';
          datosVehiculo_modeloID :='';
          datosVehiculo_modelo :='';
          numeroChasis_marca:='';
          numeroChasis_numero :='';
          datosVehiculo_anio :='';
          datosVehiculo_jurisdiccionID :='';
          datosVehiculo_jurisdiccion :='';
          datosVehiculo_mtm :='';
          datosVehiculo_valTitular :='';
          datosVehiculo_valChasis :='';
          datosValidados_marcaID :='';
          datosValidados_marca :='';
          datosValidados_tipoID :='';
          datosValidados_tipo :='';
          datosValidados_modeloID :='';
          datosValidados_modelo :='';
          datosValidados_numeroChasis:='';
          datosValidados_mtm:='';

          datosPersonalesTurno_genero :='';
          datosPersonalesTurno_tipoDocumento :='';
          datosPersonalesTurno_numeroDocumento :='';
          datosPersonalesTurno_numeroCuit:='';
          datosPersonalesTurno_nombre :='';
          datosPersonalesTurno_apellido :='';
          datosPersonalesTurno_razonSocial :='';

          contactoTurno_telefonoCelular :='';
          contactoTurno_email :='';
          contactoTurno_fechaNacimiento :='';



          datosPersonales_genero :='';
          datosPersonales_tipoDocumento :='';
          datosPersonales_numeroDocumento :='';
          datosPersonales_numeroCuit :='';
          datosPersonales_nombre :='';
          datosPersonales_apellido:='';
          datosPersonales_razonSocial:='';
          datosFacturacion_domicilio :='';
          domicilio_calle :='';
          domicilio_numero :='';
          domicilio_piso :='';
          domicilio_departamento :='';
          domicilio_localidad :='';
          domicilio_provinciaID :='';
          domicilio_provincia :='';
          domicilio_codigoPostal :='';
          datosFacturacion_condicionIva :='';


     SIGUE:=0;

 END;

 {********guarda xml sin datos*********************}
  end else  begin

     guarda_xml_error(detallesPago_pagoID,ARCHIVO_XML);


   end;
 {***********************************************************}




end;//while SIGUE


 end; //if item


 EXCEPT
   on E : Exception do
   BEGIN
    respuestaidpago:=-661;
    TRAZAS('ERROR EN PROCESAR EL PAGOID:'+detallesPago_pagoID+'. '+E.ClassName+'. error : '+E.Message+'. archivo: '+ARCHIVO_XML);
   END;

END;

END; //WHILE GENERAL

closefile(ARCHIVOPROCESO1);


total_registros_pagos_insertados:=total_registro;

EXCEPT
   on E : Exception do
   BEGIN
    respuestaidpago:=-661;
    TRAZAS('ERROR EN FUNCION LEER_TAGS_ARCHIVO_XML_PAGOS_ver2. '+E.ClassName+'. error : '+E.Message+'. archivo: '+ARCHIVO_XML);
   END;

END;

end;




FUNCTION txml_caba.LEER_TAGS_FERIADO(ARCHIVO:STRING):BOOLEAN;
VAR LINEA,X:STRING;
    S,ENTRADAA:LONGINT;
    GUARDAR:BOOLEAN;

{VARIALES TAG DETALLESPAGO}
detallesPago_pagoID:STRING;
detallesPago_plantaID:STRING;
detallesPago_importe :STRING;
detallesPago_estadoAcreditacion:STRING;
detallesPago_estadoAcreditacionD :STRING;
detallesPago_pagoGatewayID :STRING;
detallesPago_tipoBoleta :STRING;
detallesPago_fechaNovedad :STRING;
detallesPago_fechaPago :STRING;

{VARIALES TAG INFORMACIONPAGO}
informacionPago_pagoID:STRING;
informacionPago_dominio :STRING;
informacionPago_gatewayID :STRING;
informacionPago_entidadID :STRING;
informacionPago_entidadNombre:STRING;
informacionPago_fechaPago :STRING ;
informacionPago_importeTotal :STRING;

{VARIALES TAG DATOSRESERVAS}
datosReserva_reservaID :STRING;
datosReserva_estado :STRING;
datosReserva_esReve:STRING;
datosReserva_estado_DESCRICPION:string;
datosReserva_esReveDia:STRING;
datosReserva_fechaReserva :STRING;
datosReserva_horaReserva :STRING;
datosReserva_fechaRegistro :STRING;
datosReserva_plantaID :STRING;
datosReserva_dominio :STRING;

{VARIALES TAG DATOSTITULAR}
datosTitular_genero:STRING;
datosTitular_tipoDocumento :STRING;
datosTitular_numeroDocumento :STRING;
datosTitular_numeroCuit :STRING;
datosTitular_nombre :STRING;
datosTitular_apellido :STRING;
datosTitular_razonSocial :STRING;

{VARIALES TAG DATOSVEHICULOS}
datosVehiculo_dominio :STRING;
datosVehiculo_marcaID :STRING;
datosVehiculo_marca :STRING;
Vehiculo_tipoID :STRING;
datosVehiculo_tipo :STRING;
datosVehiculo_modeloID :STRING;
datosVehiculo_modelo :STRING;
numeroChasis_marca:STRING;
numeroChasis_numero :STRING;
datosVehiculo_anio :STRING;
datosVehiculo_jurisdiccionID :STRING;
datosVehiculo_jurisdiccion :STRING;
datosVehiculo_mtm :STRING;
datosVehiculo_valTitular :STRING;
datosVehiculo_valChasis :STRING;
datosValidados_marcaID :STRING;
datosValidados_marca :STRING;
datosValidados_tipoID :STRING;
datosValidados_tipo :STRING;
datosValidados_modeloID :STRING;
datosValidados_modelo :STRING;
datosValidados_numeroChasis:STRING;
datosValidados_mtm:STRING;

{VARIALES TAG DATOSPERSONALES}
datosPersonalesTurno_genero :STRING;
datosPersonalesTurno_tipoDocumento :STRING;
DatosPersonalesTurno_numeroDocumento :STRING;
datosPersonalesTurno_numeroCuit:STRING;
datosPersonalesTurno_nombre :STRING;
datosPersonalesTurno_apellido :STRING;
datosPersonalesTurno_razonSocial :STRING;

{VARIALES TAG DATOSTCONTACTOS}
contactoTurno_telefonoCelular :STRING;
contactoTurno_email :STRING;
contactoTurno_fechaNacimiento :STRING;

ii,sigue:longint;
{VARIALES TAG DATOSTFACTRUACION}
datosPersonales_genero :STRING;
datosPersonales_tipoDocumento :STRING;
datosPersonales_numeroDocumento :STRING;
datosPersonales_numeroCuit :STRING;
datosPersonales_nombre :STRING;
datosPersonales_apellido:STRING;
datosPersonales_razonSocial:STRING;
datosFacturacion_domicilio :STRING;
domicilio_calle :STRING;
domicilio_numero :STRING;
domicilio_piso :STRING;
domicilio_departamento :STRING;
domicilio_localidad :STRING;
domicilio_provinciaID :STRING;
domicilio_provincia :STRING;
domicilio_codigoPostal :STRING;
datosFacturacion_condicionIva :STRING;
cantidadPagosRelacionados:STRING;
 descripcionferiado:STRING;
fechaferiado:STRING;
feriadoID:STRING;
leyo ,continua_pago:boolean;
item_pago,total_registro:longint;
GUARDAR2,continua:boolean;
cantidad_de_pagos:longint;
GUARDAR_EN_BASE:BOOLEAN;
aqinsertadetallepago:tsqlquery;
SSQL:string;
begin
TRY
detallesPago_pagoID:='';
detallesPago_plantaID:='';
detallesPago_importe :='';
detallesPago_estadoAcreditacion:='';
detallesPago_estadoAcreditacionD :='';
detallesPago_pagoGatewayID :='';
detallesPago_tipoBoleta :='';
detallesPago_fechaNovedad :='';
detallesPago_fechaPago :='';
informacionPago_pagoID:='';
InformacionPago_dominio :='';
informacionPago_gatewayID :='';
informacionPago_entidadID :='';
informacionPago_entidadNombre:='';
informacionPago_fechaPago :='';
informacionPago_importeTotal :='';
datosReserva_reservaID :='';
datosReserva_estado :='';
datosReserva_esReve:='';
datosReserva_esReveDia:='';
datosReserva_fechaReserva :='';
datosReserva_horaReserva :='';
datosReserva_fechaRegistro :='';
datosReserva_plantaID :='';
datosReserva_dominio :='';
datosTitular_genero:='';
datosTitular_tipoDocumento :='';
datosTitular_numeroDocumento :='';
datosTitular_numeroCuit :='';
datosTitular_nombre :='';
datosTitular_apellido :='';
datosTitular_razonSocial :='';
datosVehiculo_dominio :='';
datosVehiculo_marcaID :='';
datosVehiculo_marca :='';
Vehiculo_tipoID :='';
datosVehiculo_tipo :='';
datosVehiculo_modeloID :='';
datosVehiculo_modelo :='';
numeroChasis_marca:='';
numeroChasis_numero :='';
datosVehiculo_anio :='';
datosVehiculo_jurisdiccionID :='';
datosVehiculo_jurisdiccion :='';
datosVehiculo_mtm :='';
datosVehiculo_valTitular :='';
datosVehiculo_valChasis :='';
datosValidados_marcaID :='';
datosValidados_marca :='';
datosValidados_tipoID :='';
datosValidados_tipo :='';
datosValidados_modeloID :='';
datosValidados_modelo :='';
datosValidados_numeroChasis:='';
datosValidados_mtm:='';
datosPersonalesTurno_genero :='';
datosPersonalesTurno_tipoDocumento :='';
datosPersonalesTurno_numeroDocumento :='';
datosPersonalesTurno_numeroCuit:='';
datosPersonalesTurno_nombre :='';
datosPersonalesTurno_apellido :='';
datosPersonalesTurno_razonSocial :='';
contactoTurno_telefonoCelular :='';
contactoTurno_email :='';
contactoTurno_fechaNacimiento :='';
datosPersonales_genero :='';
datosPersonales_tipoDocumento :='';
datosPersonales_numeroDocumento :='';
datosPersonales_numeroCuit :='';
datosPersonales_nombre :='';
datosPersonales_apellido:='';
datosPersonales_razonSocial:='';
datosFacturacion_domicilio :='';
domicilio_calle :='';
domicilio_numero :='';
domicilio_piso :='';
domicilio_departamento :='';
domicilio_localidad :='';
domicilio_provinciaID :='';
domicilio_provincia :='';
domicilio_codigoPostal :='';
datosFacturacion_condicionIva :='';
GUARDAR:=FALSE;
GUARDAR2:=false;
descripcionferiado:='';
fechaferiado:='';
feriadoID:='';
S:=0;
ii:=0;
sigue:=0;
cantidad_de_pagos:=0;
total_registro:=0;
leyo:=false;
continua_pago:=true;

{ABRE ARCHIVO}
ASSIGNFILE(ARCHIVOPROCESO,ARCHIVO);
RESET(ARCHIVOPROCESO);
while (not eof(ARCHIVOPROCESO)) or (trim(linea)<>'**FIN**') do
begin

 {LEE TAG}
 readln(ARCHIVOPROCESO,linea);






             continua:=true;
             sigue:=1;
                 while sigue = 1 do
                  begin
                  readln(ARCHIVOPROCESO,linea);
                  if (trim(es_linea(linea))=trim(es_linea('ITEM'))) then
                    begin
                    continua:=TRUE;
                           if trim(es_linea(linea))=trim(es_linea('**FIN**')) then
                                       BEGIN
                                         SIGUE:=0;
                                         continua:=FALSE;
                                        END;

                                while continua=true do
                                begin
                                    readln(ARCHIVOPROCESO,linea);
                                    if trim(es_linea(linea))=trim(es_linea('feriadoID')) then
                                        feriadoID:=trim(extrae_valor_PAGOS(trim(linea)));

                                    if trim(es_linea(linea))=trim(es_linea('fecha')) then
                                       fechaferiado:=trim(extrae_valor_PAGOS(trim(linea)));

                                    if trim(es_linea(linea))=trim(es_linea('descripcion')) then
                                       BEGIN
                                        descripcionferiado:=trim(extrae_valor_PAGOS(trim(linea)));
                                         continua:=FALSE;
                                        END;

                                      if trim(es_linea(linea))=trim(es_linea('**FIN**')) then
                                       BEGIN
                                         SIGUE:=0;
                                         continua:=FALSE;
                                        END;

                                end;


                             IF (continua=FALSE) AND (SIGUE=1) THEN
                             BEGIN
                                  BORRAR_TEMPORAL_FERIADOS(STRTOINT(feriadoID));
                              if (not MyBD.InTransaction) then MyBD.StartTransaction(td);
                                 TRY

                                   fechaferiado:=TRIM(COPY(fechaferiado,9,2))+'/'+TRIM(COPY(fechaferiado,6,2))+'/'+TRIM(COPY(fechaferiado,1,4));

                                   SSQL:=' INSERT INTO XML_FERIADOS  VALUES ('+INTTOSTR(STRTOINT(TRIM(feriadoID)))+
                                   ',TO_DATE('+#39+fechaferiado+#39+',''dd/mm/yyyy''),'+#39+TRIM(descripcionferiado)+#39+')';
                                   aqinsertadetallepago:=tsqlquery.create(nil);
                                   aqinsertadetallepago.SQLConnection := MyBD;
                                   aqinsertadetallepago.sql.add(SSQL);
                                   aqinsertadetallepago.ExecSQL;
                                   MYBD.Commit(TD);
                                   EXCEPT
                                    on E : Exception do
                                         BEGIN
                                           MyBD.Rollback(TD);
                                         END;

                                   END;
                                 aqinsertadetallepago.Close;
                                 aqinsertadetallepago.Free;
                              descripcionferiado:='';
                              fechaferiado:='';
                              feriadoID:='';


                             END;


                       END;

                        if trim(es_linea(linea))=trim(es_linea('**FIN**')) then
                        BEGIN
                        SIGUE:=0;
                        continua:=FALSE;
                        END;


                 END; //SIGUE

                    {******************************************************************************}
  




  END; //WHILE GENERAL
closefile(ARCHIVOPROCESO);


EXCEPT
   on E : Exception do
   BEGIN
    respuestaidpago:=-661;
    TRAZAS('ERROR EN FUNCION LEER_TAGS_FERIADO. '+E.ClassName+'. error : '+E.Message);
   END;

END;




end;


function txml_caba.guarda_xml_error(pagoid,archivo:string):boolean;
var aqinsertadetallepago:tsqlquery;
SSQL,FECHAPAGO,DIA,MES,ANNIO,FECHARESERVA,FECHAREGISTRO:STRING;

BEGIN
TRY



if (not MyBD.InTransaction) then MyBD.StartTransaction(td);
 TRY
   SSQL:=' INSERT INTO '+
        '  XML_PAGOS_ERROR '+
        '  (externalreference,archivo,fecha) '+
           '  VALUES ('+#39+trim(pagoid)+#39+','+#39+trim(archivo)+#39+',sysdate)';


aqinsertadetallepago:=tsqlquery.create(nil);
aqinsertadetallepago.SQLConnection := MyBD;
aqinsertadetallepago.sql.add(SSQL);
aqinsertadetallepago.ExecSQL;


MYBD.Commit(TD);

Form1.EnviarMensaje_ERROR('martin.bien@applus.com',PAGOID,ARCHIVO,inttostr(ver_planta));
Form1.EnviarMensaje_ERROR('lucas.suarez@applus.com',PAGOID,ARCHIVO,inttostr(ver_planta));
EXCEPT

  on E : Exception do
   BEGIN
    MyBD.Rollback(TD);
    END;

END;
aqinsertadetallepago.CLOSE;
aqinsertadetallepago.FREE;
EXCEPT
   on E : Exception do
   BEGIN

   END;

END ;

END;






FUNCTION txml_caba.LEER_TAGS_ARCHIVO(IDCL:BOOLEAN):BOOLEAN;
VAR LEYO,CANTIDAD:LONGINT;
LINEA,X:STRING;
ENTRO:BOOLEAN;
BEGIN
   ASSIGNFILE(ARCHIVOPROCESO,ExtractFilePath(Application.ExeName)+'archivoparseado.txt');
   RESET(ARCHIVOPROCESO);
   leyo:=0;
cantidad:=-1;
entro:=false;
linea:='';
NO_HACE_FACTURA_ELECTRONICA:=FALSE;
respuestaID:='';
respuestaMensaje:='';
cantidad:=0;
turnoID:='';
estadoID:='';
estado:='';
tipoTurno:='';
esReve:='';
esReveDia:='';
fechaTurno:='';
horaTurno:='';
fechaRegistro:='';
fechaNovedad:='';
plantaID:='';
re_item_turnoID:='';
re_item_plantaID:='';
re_item_estado:='';
re_item_fechaNovedad:='';
re_datosPago_pagoID:='';
re_datosPago_entidadID:='';
re_datosPago_fechaPago:='';
re_datosPago_importeTotal:='';
re_detallesPagoVerificacion_pagoID:='';
re_detallesPagoVerificacion_importe:='';
re_detallesPagoVerificacion_estadoAcreditacion:='';
re_detallesPagoOblea_pagoID:='';
re_detallesPagoOblea_importe:='';
re_detallesPagoOblea_estadoAcreditacion:='';
datosTitular_genero:='';
datosTitular_tipoDocumento:='';
datosTitular_numeroDocumento:='';
datosTitular_numeroCuit:='';
datosTitular_nombre:='';
datosTitular_apellido:='';
datosTitular_razonSocial:='';
datosPersonalesTurno_tipoDocumento:='';
datosPersonalesTurno_numeroCuit:='';
datosPersonalesTurno_nombre:='';
datosPersonalesTurno_apellido:='';
datosPersonalesTurno_razonSocial:='';
contactoTurno_telefonoCelular:='';
contactoTurno_email:='';
contactoTurno_fechaNacimiento:='';
datosPersonales_genero:='';
datosPersonales_tipoDocumento:='';
datosPersonales_numeroDocumento:='';
datosPersonales_numeroCuit:='';
datosPersonales_nombre:='';
datosPersonales_apellido:='';
datosPersonales_razonSocial:='';
datosFacturacion_domicilio:='';
domicilio_calle:='';
domicilio_numero:='';
domicilio_piso:='';
domicilio_departamento:='';
domicilio_localidad:='';
domicilio_provinciaID:='';
domicilio_provincia:='';
domicilio_codigoPostal:='';
datosFacturacion_condicionIva:='';
datosFacturacion_numeroIibb:='';
datosPago_pagoID:='';
datosPago_gatewayID:='';
datosPago_entidadID:='';
datosPago_entidadNombre:='';
datosPago_fechaPago:='';
datosPago_importeTotal:='';
detallesPagoVerificacion_pagoID:='';
detallesPagoVerificacion_importe:='';
detallesPagoVerificacion_estadoAcreditacion:='';
detallesPagoVerificacion_pagoGatewayID:='';
detallesPagoOblea_pagoID:='';
detallesPagoOblea_importe:='';
detallesPagoOblea_estadoAcreditacion:='';
datosVehiculo_dominio:='';
datosVehiculo_marcaID:='';
datosVehiculo_marca:='';
datosVehiculo_tipoID:='';
datosVehiculo_tipo:='';
datosVehiculo_modeloID:='';
datosVehiculo_modelo:='';
numeroChasis_marca:='';
numeroChasis_numero:='';
datosVehiculo_anio:='';
datosVehiculo_jurisdiccionID:='';
datosVehiculo_jurisdiccion:='';
datosVehiculo_mtm:='';
datosVehiculo_valTitular:='';
datosVehiculo_valChasis:='';
datosValidados_marcaID:='';
datosValidados_marca:='';
datosValidados_tipoID:='';
datosValidados_tipo:='';
datosValidados_modeloID:='';
datosValidados_modelo:='';
numeroChasis_marca:='';
numeroChasis_numero:='';
datosValidados_mtm:='';
ES_REVERIFICACION:='N';
while (not eof(ARCHIVOPROCESO)) or (trim(linea)='**FIN**') do
begin
 readln(ARCHIVOPROCESO,linea);

if  trim(linea)='****999****' then
begin
 IF  (TRIM(SELF.VER_esReveDia)='N') AND ((TRIM(SELF.VER_esReve)='N')) THEN
     ES_REVERIFICACION:='N'
     ELSE
     ES_REVERIFICACION:='S';


leyo:=leyo + 1;

IF IDCL=FALSE THEN
   Guarda_turno_en_basedatos
   ELSE
   Guarda_turno_en_basedatos_IDCLIENTECERO;


  //showmessage('guarda base '+inttostr(leyo)+'   '+self.ver_turnoID+' '+SELF.ver_datosVehiculo_dominio+' '+SELF.VER_esReve+' '+SELF.VER_esReveDia+' '+SELF.VER_ES_REVERIFICACION);
 NO_HACE_FACTURA_ELECTRONICA:=FALSE;
 respuestaID:='';
respuestaMensaje:='';
cantidad:=0;
turnoID:='';
estadoID:='';
estado:='';
tipoTurno:='';
esReve:='';
esReveDia:='';
fechaTurno:='';
horaTurno:='';
fechaRegistro:='';
fechaNovedad:='';
plantaID:='';
re_item_turnoID:='';
re_item_plantaID:='';
re_item_estado:='';
re_item_fechaNovedad:='';
re_datosPago_pagoID:='';
re_datosPago_entidadID:='';
re_datosPago_fechaPago:='';
re_datosPago_importeTotal:='';
re_detallesPagoVerificacion_pagoID:='';
re_detallesPagoVerificacion_importe:='';
re_detallesPagoVerificacion_estadoAcreditacion:='';
re_detallesPagoOblea_pagoID:='';
re_detallesPagoOblea_importe:='';
re_detallesPagoOblea_estadoAcreditacion:='';
datosTitular_genero:='';
datosTitular_tipoDocumento:='';
datosTitular_numeroDocumento:='';
datosTitular_numeroCuit:='';
datosTitular_nombre:='';
datosTitular_apellido:='';
datosTitular_razonSocial:='';
datosPersonalesTurno_tipoDocumento:='';
datosPersonalesTurno_numeroCuit:='';
datosPersonalesTurno_nombre:='';
datosPersonalesTurno_apellido:='';
datosPersonalesTurno_razonSocial:='';
contactoTurno_telefonoCelular:='';
contactoTurno_email:='';
contactoTurno_fechaNacimiento:='';
datosPersonales_genero:='';
datosPersonales_tipoDocumento:='';
datosPersonales_numeroDocumento:='';
datosPersonales_numeroCuit:='';
datosPersonales_nombre:='';
datosPersonales_apellido:='';
datosPersonales_razonSocial:='';
datosFacturacion_domicilio:='';
domicilio_calle:='';
domicilio_numero:='';
domicilio_piso:='';
domicilio_departamento:='';
domicilio_localidad:='';
domicilio_provinciaID:='';
domicilio_provincia:='';
domicilio_codigoPostal:='';
datosFacturacion_condicionIva:='';
datosFacturacion_numeroIibb:='';
datosPago_pagoID:='';
datosPago_gatewayID:='';
datosPago_entidadID:='';
datosPago_entidadNombre:='';
datosPago_fechaPago:='';
datosPago_importeTotal:='';
detallesPagoVerificacion_pagoID:='';
detallesPagoVerificacion_importe:='';
detallesPagoVerificacion_estadoAcreditacion:='';
detallesPagoVerificacion_pagoGatewayID:='';
detallesPagoOblea_pagoID:='';
detallesPagoOblea_importe:='';
detallesPagoOblea_estadoAcreditacion:='';
datosVehiculo_dominio:='';
datosVehiculo_marcaID:='';
datosVehiculo_marca:='';
datosVehiculo_tipoID:='';
datosVehiculo_tipo:='';
datosVehiculo_modeloID:='';
datosVehiculo_modelo:='';
numeroChasis_marca:='';
numeroChasis_numero:='';
datosVehiculo_anio:='';
datosVehiculo_jurisdiccionID:='';
datosVehiculo_jurisdiccion:='';
datosVehiculo_mtm:='';
datosVehiculo_valTitular:='';
datosVehiculo_valChasis:='';
datosValidados_marcaID:='';
datosValidados_marca:='';
datosValidados_tipoID:='';
datosValidados_tipo:='';
datosValidados_modeloID:='';
datosValidados_modelo:='';
numeroChasis_marca:='';
numeroChasis_numero:='';
datosValidados_mtm:='';
end;




   if trim(es_linea(linea))=trim(es_linea('return_respuestaID')) then
      respuestaID:=trim(extrae_valor(trim(linea)));



 if trim(es_linea(linea))=trim(es_linea('return_respuestaMensaje')) then
  begin
       respuestaMensaje:=trim(extrae_valor(trim(linea)));

    if trim(respuestaID)<>'1' then
       break;



  end;



     if trim(es_linea(linea))=trim(es_linea('return_cantidadTurnos')) then
         begin
            cantidad:=strtoint(trim(extrae_valor(trim(linea))));

            if cantidad = 0 then
               break;


     end;





       if trim(es_linea(linea))=trim(es_linea('datosTurno_turnoID')) then
          BEGIN
           turnoID:=trim(extrae_valor(trim(linea)));
            IF turnoID='60905' THEN
             X:='A';

             IF turnoID='60942' THEN
             X:='A';

          END;


       if trim(es_linea(linea))=trim(es_linea('datosTurno_estadoID')) then
           estadoID:=trim(extrae_valor(trim(linea)));


       if trim(es_linea(linea))=trim(es_linea('datosTurno_estado')) then
             estado:=trim(extrae_valor(trim(linea)));


       if trim(es_linea(linea))=trim(es_linea('datosTurno_tipoTurno')) then
               tipoTurno:=trim(extrae_valor(trim(linea)));



        if trim(es_linea(linea))=trim(es_linea('datosTurno_esReve')) then
        BEGIN
               esReve:=trim(extrae_valor(trim(linea)));
               IF TRIM(esReve)='S' then
                 ES_REVERIFICACION:='S';

        END;

        if trim(es_linea(linea))=trim(es_linea('datosTurno_esReveDia')) then
         begin
               esReveDia:=trim(extrae_valor(trim(linea)));
                IF TRIM(esReveDia)='S' then
                 ES_REVERIFICACION:='S';
        end;


       if trim(es_linea(linea))=trim(es_linea('datosTurno_fechaTurno')) then
           fechaTurno:=trim(extrae_valor(trim(linea)));


       if trim(es_linea(linea))=trim(es_linea('datosTurno_horaTurno')) then
           horaTurno:=trim(extrae_valor(trim(linea)));


      if trim(es_linea(linea))=trim(es_linea('datosTurno_fechaRegistro')) then
           fechaRegistro:=trim(extrae_valor(trim(linea)));


        if trim(es_linea(linea))=trim(es_linea('datosTurno_fechaNovedad')) then      //2016-11-10T09:22:26-03:00
           BEGIN
           fechaNovedad:=trim(extrae_valor(trim(linea)));

           fechaNovedad:=COPY(TRIM(fechaNovedad),9,2)+'/'+COPY(TRIM(fechaNovedad),6,2)+'/'+COPY(TRIM(fechaNovedad),1,4)+' '+COPY(TRIM(fechaNovedad),12,8);
           END;

       if trim(es_linea(linea))=trim(es_linea('datosTurno_plantaID')) then
           plantaID:=trim(extrae_valor(trim(linea)));

          if trim(es_linea(linea))=trim(es_linea('datosTurno_reservaID')) then
           reservaID:=trim(extrae_valor(trim(linea)));






         {turno relacionado}
            if trim(es_linea(linea))=trim(es_linea('datosTurno_turnosRelacionados')) then
                   begin
                   NO_HACE_FACTURA_ELECTRONICA:=TRUE;
                        readln(ARCHIVOPROCESO,linea);
                        while trim(linea)<>'****000****' do
                        begin
                             if trim(es_linea(linea))=trim(es_linea('item_turnoID')) then
                                re_item_turnoID:=trim(extrae_valor(trim(linea)));

                             if trim(es_linea(linea))=trim(es_linea('item_plantaID')) then
                                re_item_plantaID:=trim(extrae_valor(trim(linea)));

                             if trim(es_linea(linea))=trim(es_linea('item_estado')) then
                                re_item_estado:=trim(extrae_valor(trim(linea)));

                            if trim(es_linea(linea))=trim(es_linea('item_fechaNovedad')) then
                                re_item_fechaNovedad:=trim(extrae_valor(trim(linea)));

                            if trim(es_linea(linea))=trim(es_linea('datosPago_pagoID')) then
                                re_datosPago_pagoID:=trim(extrae_valor(trim(linea)));


                            if trim(es_linea(linea))=trim(es_linea('datosPago_entidadID')) then
                                re_datosPago_entidadID:=trim(extrae_valor(trim(linea)));


                             if trim(es_linea(linea))=trim(es_linea('datosPago_fechaPago')) then
                                re_datosPago_fechaPago:=trim(extrae_valor(trim(linea)));


                             if trim(es_linea(linea))=trim(es_linea('datosPago_importeTotal')) then
                                re_datosPago_importeTotal:=trim(extrae_valor(trim(linea)));


                             if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_pagoID')) then
                                re_detallesPagoVerificacion_pagoID:=trim(extrae_valor(trim(linea)));



                             if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_importe')) then
                                re_detallesPagoVerificacion_importe:=trim(extrae_valor(trim(linea)));

                               if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_estadoAcreditacion')) then
                                re_detallesPagoVerificacion_estadoAcreditacion:=trim(extrae_valor(trim(linea)));

                             if trim(es_linea(linea))=trim(es_linea('detallesPagoOblea_pagoID')) then
                                re_detallesPagoOblea_pagoID:=trim(extrae_valor(trim(linea)));

                             if trim(es_linea(linea))=trim(es_linea('detallesPagoOblea_importe')) then
                                re_detallesPagoOblea_importe:=trim(extrae_valor(trim(linea)));

                              if trim(es_linea(linea))=trim(es_linea('detallesPagoOblea_estadoAcreditacion')) then
                                re_detallesPagoOblea_estadoAcreditacion:=trim(extrae_valor(trim(linea)));




                            readln(ARCHIVOPROCESO, linea);
                        end;





                   end;


         {fin turno relacionado}


        {titulaR}
       if trim(es_linea(linea))=trim(es_linea('datosTitular_genero')) then
           datosTitular_genero:=trim(extrae_valor(trim(linea)));

        if trim(es_linea(linea))=trim(es_linea('datosTitular_tipoDocumento')) then
           datosTitular_tipoDocumento:=trim(extrae_valor(trim(linea)));

       if trim(es_linea(linea))=trim(es_linea('datosTitular_numeroDocumento')) then
           datosTitular_numeroDocumento:=trim(extrae_valor(trim(linea)));


        if trim(es_linea(linea))=trim(es_linea('datosTitular_numeroCuit')) then
           datosTitular_numeroCuit:=trim(extrae_valor(trim(linea)));

        if trim(es_linea(linea))=trim(es_linea('datosTitular_nombre')) then
           datosTitular_nombre:= StringReplace(trim(extrae_valor(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);


       if trim(es_linea(linea))=trim(es_linea('datosTitular_apellido')) then
           datosTitular_apellido:=StringReplace(trim(extrae_valor(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);


       if trim(es_linea(linea))=trim(es_linea('datosTitular_razonSocial')) then
           datosTitular_razonSocial:=StringReplace(trim(extrae_valor(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);




        {datos personales}

       if trim(es_linea(linea))=trim(es_linea('datosPersonalesTurno_tipoDocumento')) then
           datosPersonalesTurno_tipoDocumento:=trim(extrae_valor(trim(linea)));



         if trim(es_linea(linea))=trim(es_linea('datosPersonalesTurno_numeroCuit')) then
           datosPersonalesTurno_numeroCuit:=trim(extrae_valor(trim(linea)));



       if trim(es_linea(linea))=trim(es_linea('datosPersonalesTurno_nombre')) then
           datosPersonalesTurno_nombre:=StringReplace(trim(extrae_valor(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);



         if trim(es_linea(linea))=trim(es_linea('datosPersonalesTurno_apellido')) then
           datosPersonalesTurno_apellido:=StringReplace(trim(extrae_valor(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);



         if trim(es_linea(linea))=trim(es_linea('datosPersonalesTurno_razonSocial')) then
           datosPersonalesTurno_razonSocial:=StringReplace(trim(extrae_valor(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);





          {datos contactos}
        if trim(es_linea(linea))=trim(es_linea('contactoTurno_telefonoCelular')) then
           contactoTurno_telefonoCelular:=trim(extrae_valor(trim(linea)));


      if trim(es_linea(linea))=trim(es_linea('contactoTurno_email')) then
           contactoTurno_email:=trim(extrae_valor(trim(linea)));

       if trim(es_linea(linea))=trim(es_linea('contactoTurno_fechaNacimiento')) then
           contactoTurno_fechaNacimiento:=trim(extrae_valor(trim(linea)));


        {datos facturacion}
       if trim(es_linea(linea))=trim(es_linea('datosPersonales_genero')) then
           datosPersonales_genero:=trim(extrae_valor(trim(linea)));


         if trim(es_linea(linea))=trim(es_linea('datosPersonales_tipoDocumento')) then
           datosPersonales_tipoDocumento:=trim(extrae_valor(trim(linea)));


       if trim(es_linea(linea))=trim(es_linea('datosPersonales_numeroDocumento')) then
           datosPersonales_numeroDocumento:=trim(extrae_valor(trim(linea)));




   if trim(es_linea(linea))=trim(es_linea('datosPersonales_numeroCuit')) then
           datosPersonales_numeroCuit:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPersonales_nombre')) then
           datosPersonales_nombre:=StringReplace(trim(extrae_valor(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);



   if trim(es_linea(linea))=trim(es_linea('datosPersonales_apellido')) then
           datosPersonales_apellido:=StringReplace(trim(extrae_valor(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);




   if trim(es_linea(linea))=trim(es_linea('datosPersonales_razonSocial')) then
           datosPersonales_razonSocial:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosFacturacion_domicilio')) then
           datosFacturacion_domicilio:=StringReplace(trim(extrae_valor(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);




   if trim(es_linea(linea))=trim(es_linea('domicilio_calle')) then
           domicilio_calle:=StringReplace(trim(extrae_valor(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);




   if trim(es_linea(linea))=trim(es_linea('domicilio_numero')) then
           domicilio_numero:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('domicilio_piso')) then
           domicilio_piso:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('domicilio_departamento')) then
           domicilio_departamento:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('domicilio_localidad')) then
           domicilio_localidad:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('domicilio_provinciaID')) then
           domicilio_provinciaID:=trim(extrae_valor(trim(linea)));


   if trim(es_linea(linea))=trim(es_linea('domicilio_provincia')) then
           domicilio_provincia:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('domicilio_codigoPostal')) then
           domicilio_codigoPostal:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosFacturacion_condicionIva')) then
           datosFacturacion_condicionIva:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosFacturacion_numeroIibb')) then
           datosFacturacion_numeroIibb:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPago_pagoID')) then
           datosPago_pagoID:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPago_gatewayID')) then
           datosPago_gatewayID:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPago_entidadID')) then
           datosPago_entidadID:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPago_entidadNombre')) then
           datosPago_entidadNombre:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPago_fechaPago')) then
           datosPago_fechaPago:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPago_importeTotal')) then
           datosPago_importeTotal:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_pagoID')) then
           detallesPagoVerificacion_pagoID:=trim(extrae_valor(trim(linea)));



    if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_plantaID')) then
           detallesPagoVerificacion_plantaID:=trim(extrae_valor(trim(linea)));




   if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_importe')) then
           detallesPagoVerificacion_importe:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_estadoAcreditacion')) then
           detallesPagoVerificacion_estadoAcreditacion:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_pagoGatewayID')) then
           detallesPagoVerificacion_pagoGatewayID:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('detallesPagoOblea_pagoID')) then
           detallesPagoOblea_pagoID:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('detallesPagoOblea_importe')) then
           detallesPagoOblea_importe:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('detallesPagoOblea_estadoAcreditacion')) then
           detallesPagoOblea_estadoAcreditacion:=trim(extrae_valor(trim(linea)));




      {vehiculo}




  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_dominio')) then
           datosVehiculo_dominio:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_marcaID')) then
           datosVehiculo_marcaID:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_marca')) then
           datosVehiculo_marca:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_tipoID')) then
           datosVehiculo_tipoID:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_tipo')) then
           datosVehiculo_tipo:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_modeloID')) then
           datosVehiculo_modeloID:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_modelo')) then
           datosVehiculo_modelo:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('numeroChasis_marca')) then
           numeroChasis_marca:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('numeroChasis_numero')) then
           numeroChasis_numero:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_anio')) then
           datosVehiculo_anio:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_jurisdiccionID')) then
           datosVehiculo_jurisdiccionID:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_jurisdiccion')) then
           datosVehiculo_jurisdiccion:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_mtm')) then
           datosVehiculo_mtm:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_valTitular')) then
           datosVehiculo_valTitular:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_valChasis')) then
           datosVehiculo_valChasis:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosValidados_marcaID')) then
           datosValidados_marcaID:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosValidados_marca')) then
           datosValidados_marca:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosValidados_tipoID')) then
           datosValidados_tipoID:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosValidados_tipo')) then
           datosValidados_tipo:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosValidados_modeloID')) then
           datosValidados_modeloID:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosValidados_modelo')) then
           datosValidados_modelo:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('numeroChasis_marca')) then
           numeroChasis_marca:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('numeroChasis_numero')) then
           numeroChasis_numero:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosValidados_mtm')) then
           datosValidados_mtm:=trim(extrae_valor(trim(linea)));







 end;  //while

   CLOSEFILE(ARCHIVOPROCESO);
END;



FUNCTION txml_caba.LEER_TAGS_ARCHIVO_TURNOS_VB(ARCHIVO:STRING):BOOLEAN;
VAR LEYO,CANTIDAD,sigue:LONGINT;
LINEA,X:STRING;              SALE1,SALE:string;
ENTRO:BOOLEAN;    TURNOS,GUARDAR_EN_B:STRING;
BEGIN
   ASSIGNFILE(ARCHIVOPROCESO,ARCHIVO);
   RESET(ARCHIVOPROCESO);
   leyo:=0;
cantidad:=-1;
entro:=false;
linea:='';
NO_HACE_FACTURA_ELECTRONICA:=FALSE;
respuestaID:='';
respuestaMensaje:='';
cantidad:=0;
turnoID:='';
estadoID:='';
estado:='';
tipoTurno:='';
esReve:='';
esReveDia:='';
fechaTurno:='';
horaTurno:='';
fechaRegistro:='';
fechaNovedad:='';
plantaID:='';
re_item_turnoID:='';
re_item_plantaID:='';
re_item_estado:='';
re_item_fechaNovedad:='';
re_datosPago_pagoID:='';
re_datosPago_entidadID:='';
re_datosPago_fechaPago:='';
re_datosPago_importeTotal:='';
re_detallesPagoVerificacion_pagoID:='';
re_detallesPagoVerificacion_importe:='';
re_detallesPagoVerificacion_estadoAcreditacion:='';
re_detallesPagoOblea_pagoID:='';
re_detallesPagoOblea_importe:='';
re_detallesPagoOblea_estadoAcreditacion:='';
datosTitular_genero:='';
datosTitular_tipoDocumento:='';
datosTitular_numeroDocumento:='';
datosTitular_numeroCuit:='';
datosTitular_nombre:='';
datosTitular_apellido:='';
datosTitular_razonSocial:='';
datosPersonalesTurno_tipoDocumento:='';
datosPersonalesTurno_numeroCuit:='';
datosPersonalesTurno_nombre:='';
datosPersonalesTurno_apellido:='';
datosPersonalesTurno_razonSocial:='';
contactoTurno_telefonoCelular:='';
contactoTurno_email:='';
contactoTurno_fechaNacimiento:='';
datosPersonales_genero:='';
datosPersonales_tipoDocumento:='';
datosPersonales_numeroDocumento:='';
datosPersonales_numeroCuit:='';
datosPersonales_nombre:='';
datosPersonales_apellido:='';
datosPersonales_razonSocial:='';
datosFacturacion_domicilio:='';
domicilio_calle:='';
domicilio_numero:='';
domicilio_piso:='';
domicilio_departamento:='';
domicilio_localidad:='';
domicilio_provinciaID:='';
domicilio_provincia:='';
domicilio_codigoPostal:='';
datosFacturacion_condicionIva:='';
datosFacturacion_numeroIibb:='';
datosPago_pagoID:='';
datosPago_gatewayID:='';
datosPago_entidadID:='';
datosPago_entidadNombre:='';
datosPago_fechaPago:='';
datosPago_importeTotal:='';
detallesPagoVerificacion_pagoID:='';
detallesPagoVerificacion_importe:='';
detallesPagoVerificacion_estadoAcreditacion:='';
detallesPagoVerificacion_pagoGatewayID:='';
detallesPagoOblea_pagoID:='';
detallesPagoOblea_importe:='';
detallesPagoOblea_estadoAcreditacion:='';
datosVehiculo_dominio:='';
datosVehiculo_marcaID:='';
datosVehiculo_marca:='';
datosVehiculo_tipoID:='';
datosVehiculo_tipo:='';
datosVehiculo_modeloID:='';
datosVehiculo_modelo:='';
numeroChasis_marca:='';
numeroChasis_numero:='';
datosVehiculo_anio:='';
datosVehiculo_jurisdiccionID:='';
datosVehiculo_jurisdiccion:='';
datosVehiculo_mtm:='';
datosVehiculo_valTitular:='';
datosVehiculo_valChasis:='';
datosValidados_marcaID:='';
datosValidados_marca:='';
datosValidados_tipoID:='';
datosValidados_tipo:='';
datosValidados_modeloID:='';
datosValidados_modelo:='';
numeroChasis_marca:='';
numeroChasis_numero:='';
datosValidados_mtm:='';
TURNOS:='N';
GUARDAR_EN_B:='N';
sigue:=0;
while (not eof(ARCHIVOPROCESO)) or (trim(linea)='**FIN**') do
begin
 readln(ARCHIVOPROCESO,linea);


          if trim(es_linea(linea))=trim(es_linea('respuestaID')) then
             respuestaID:=trim(extrae_valor(trim(linea)));

          if trim(es_linea(linea))=trim(es_linea('respuestaMensaje')) then
             begin
                respuestaMensaje:=trim(extrae_valor(trim(linea)));
                  if trim(respuestaID)<>'1' then
                      break
                        else
                      sigue:=1;
              end;



           if trim(es_linea(linea))=trim(es_linea('cantidadTurnos')) then
              begin
                cantidad:=strtoint(trim(extrae_valor(trim(linea))));
                  if cantidad = 0 then
                     break
                      else
                       sigue:=1;
               end;


              if trim(es_linea(linea))=trim(es_linea('TURNOS')) then
                 TURNOS:='S';



       IF (cantidad > 0) AND (TURNOS='S') THEN
        BEGIN
            if trim(es_linea(linea))=trim(es_linea('DATOSTURNO'))  then
              begin
               SALE:='N' ;
                 WHILE (SALE='N') or  (eof(ARCHIVOPROCESO))  DO
                  BEGIN
                    readln(ARCHIVOPROCESO,linea);
                     if trim(es_linea(linea))=trim(es_linea('turnoID')) then
                        turnoID:=trim(extrae_valor(trim(linea)));

                     if trim(es_linea(linea))=trim(es_linea('estadoID')) then
                         estadoID:=trim(extrae_valor(trim(linea)));

                     if trim(es_linea(linea))=trim(es_linea('estado')) then
                        estado:=trim(extrae_valor(trim(linea)));

                      if trim(es_linea(linea))=trim(es_linea('tipoTurno')) then
                          tipoTurno:=trim(extrae_valor(trim(linea)));

                      if trim(es_linea(linea))=trim(es_linea('esReve')) then
                         esReve:=trim(extrae_valor(trim(linea)));

                      if trim(es_linea(linea))=trim(es_linea('esReveDia')) then
                         esReveDia:=trim(extrae_valor(trim(linea)));

                      if trim(es_linea(linea))=trim(es_linea('fechaTurno')) then
                         fechaTurno:=trim(extrae_valor(trim(linea)));

                      if trim(es_linea(linea))=trim(es_linea('horaTurno')) then
                         horaTurno:=trim(extrae_valor(trim(linea)));

                      if trim(es_linea(linea))=trim(es_linea('fechaRegistro')) then
                         fechaRegistro:=trim(extrae_valor(trim(linea)));

                      if trim(es_linea(linea))=trim(es_linea('fechaNovedad')) then      //2016-11-10T09:22:26-03:00
                        BEGIN
                         fechaNovedad:=trim(extrae_valor(trim(linea)));
                         fechaNovedad:=COPY(TRIM(fechaNovedad),9,2)+'/'+COPY(TRIM(fechaNovedad),6,2)+'/'+COPY(TRIM(fechaNovedad),1,4)+' '+COPY(TRIM(fechaNovedad),12,8);
                         END;

                      if trim(es_linea(linea))=trim(es_linea('plantaID')) then
                         plantaID:=trim(extrae_valor(trim(linea)));

                      if trim(es_linea(linea))=trim(es_linea('reservaID')) then
                         reservaID:=trim(extrae_valor(trim(linea)));


                      if trim(es_linea(linea))=trim(es_linea('DATOSTITULAR')) then
                         begin
                           SALE:='S' ;
                           sigue:=1;
                         end;
                 END; //WHILE
          end;   //DATOSTURNOS


       {turno relacionado}
      {

            if trim(es_linea(linea))=trim(es_linea('datosTurno_turnosRelacionados')) then
                   begin
                   NO_HACE_FACTURA_ELECTRONICA:=TRUE;
                        readln(ARCHIVOPROCESO,linea);
                        while trim(linea)<>'****000****' do
                        begin
                             if trim(es_linea(linea))=trim(es_linea('item_turnoID')) then
                                re_item_turnoID:=trim(extrae_valor(trim(linea)));

                             if trim(es_linea(linea))=trim(es_linea('item_plantaID')) then
                                re_item_plantaID:=trim(extrae_valor(trim(linea)));

                             if trim(es_linea(linea))=trim(es_linea('item_estado')) then
                                re_item_estado:=trim(extrae_valor(trim(linea)));

                            if trim(es_linea(linea))=trim(es_linea('item_fechaNovedad')) then
                                re_item_fechaNovedad:=trim(extrae_valor(trim(linea)));

                            if trim(es_linea(linea))=trim(es_linea('datosPago_pagoID')) then
                                re_datosPago_pagoID:=trim(extrae_valor(trim(linea)));


                            if trim(es_linea(linea))=trim(es_linea('datosPago_entidadID')) then
                                re_datosPago_entidadID:=trim(extrae_valor(trim(linea)));


                             if trim(es_linea(linea))=trim(es_linea('datosPago_fechaPago')) then
                                re_datosPago_fechaPago:=trim(extrae_valor(trim(linea)));


                             if trim(es_linea(linea))=trim(es_linea('datosPago_importeTotal')) then
                                re_datosPago_importeTotal:=trim(extrae_valor(trim(linea)));


                             if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_pagoID')) then
                                re_detallesPagoVerificacion_pagoID:=trim(extrae_valor(trim(linea)));



                             if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_importe')) then
                                re_detallesPagoVerificacion_importe:=trim(extrae_valor(trim(linea)));

                               if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_estadoAcreditacion')) then
                                re_detallesPagoVerificacion_estadoAcreditacion:=trim(extrae_valor(trim(linea)));

                             if trim(es_linea(linea))=trim(es_linea('detallesPagoOblea_pagoID')) then
                                re_detallesPagoOblea_pagoID:=trim(extrae_valor(trim(linea)));

                             if trim(es_linea(linea))=trim(es_linea('detallesPagoOblea_importe')) then
                                re_detallesPagoOblea_importe:=trim(extrae_valor(trim(linea)));

                              if trim(es_linea(linea))=trim(es_linea('detallesPagoOblea_estadoAcreditacion')) then
                                re_detallesPagoOblea_estadoAcreditacion:=trim(extrae_valor(trim(linea)));




                            readln(ARCHIVOPROCESO, linea);
                        end;





                   end;

                }
         {fin turno relacionado}

       {titulaR}
      if (trim(es_linea(linea))=trim(es_linea('DATOSTITULAR'))) and (sigue=1)  then
      begin
       SALE:='N' ;
          WHILE (SALE='N') or (eof(ARCHIVOPROCESO))  DO
          BEGIN
              readln(ARCHIVOPROCESO,linea);

                if trim(es_linea(linea))=trim(es_linea('DATOSPERSONALESTURNO')) then
                 begin
                  SALE:='S' ;
                  sigue:=1;
                  end;


                 if trim(es_linea(linea))=trim(es_linea('genero')) then
                    datosTitular_genero:=trim(extrae_valor(trim(linea)));

                 if trim(es_linea(linea))=trim(es_linea('tipoDocumento')) then
                    datosTitular_tipoDocumento:=trim(extrae_valor(trim(linea)));

                 if trim(es_linea(linea))=trim(es_linea('numeroDocumento')) then
                   datosTitular_numeroDocumento:=trim(extrae_valor(trim(linea)));


                 if trim(es_linea(linea))=trim(es_linea('numeroCuit')) then
                  datosTitular_numeroCuit:=trim(extrae_valor(trim(linea)));

                 if trim(es_linea(linea))=trim(es_linea('nombre')) then
                   datosTitular_nombre:= StringReplace(trim(extrae_valor(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);


                 if trim(es_linea(linea))=trim(es_linea('apellido')) then
                  datosTitular_apellido:=StringReplace(trim(extrae_valor(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);


               if trim(es_linea(linea))=trim(es_linea('razonSocial')) then
                  datosTitular_razonSocial:=StringReplace(trim(extrae_valor(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);


         end;

      end;


       {DATOSPERSONALESTURNO}

        if (trim(es_linea(linea))=trim(es_linea('DATOSPERSONALESTURNO'))) and (sigue=1)  then
      begin
       SALE:='N' ;
           WHILE (SALE='N') or (eof(ARCHIVOPROCESO))  DO
            BEGIN
              readln(ARCHIVOPROCESO,linea);

                if trim(es_linea(linea))=trim(es_linea('CONTACTOTURNO')) then
                 begin
                  SALE:='S' ;
                  sigue:=1;
                  end;

                 {datos personales}

                 if trim(es_linea(linea))=trim(es_linea('tipoDocumento')) then
                  datosPersonalesTurno_tipoDocumento:=trim(extrae_valor(trim(linea)));



                 if trim(es_linea(linea))=trim(es_linea('numeroCuit')) then
                  datosPersonalesTurno_numeroCuit:=trim(extrae_valor(trim(linea)));



                if trim(es_linea(linea))=trim(es_linea('nombre')) then
                datosPersonalesTurno_nombre:=StringReplace(trim(extrae_valor(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);



                 if trim(es_linea(linea))=trim(es_linea('apellido')) then
                    datosPersonalesTurno_apellido:=StringReplace(trim(extrae_valor(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);



                if trim(es_linea(linea))=trim(es_linea('razonSocial')) then
                datosPersonalesTurno_razonSocial:=StringReplace(trim(extrae_valor(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);






           end;

       end;





        if (trim(es_linea(linea))=trim(es_linea('CONTACTOTURNO'))) and (sigue=1)  then
      begin
       SALE:='N' ;
           WHILE (SALE='N') or (eof(ARCHIVOPROCESO))  DO
             BEGIN
              readln(ARCHIVOPROCESO,linea);

                if trim(es_linea(linea))=trim(es_linea('DATOSVEHICULO')) then
                 begin
                  SALE:='S' ;
                  sigue:=1;
                  end;

            
               {datos contactos}
              if trim(es_linea(linea))=trim(es_linea('telefonoCelular')) then
               contactoTurno_telefonoCelular:=trim(extrae_valor(trim(linea)));


              if trim(es_linea(linea))=trim(es_linea('email')) then
                 contactoTurno_email:=trim(extrae_valor(trim(linea)));

               if trim(es_linea(linea))=trim(es_linea('fechaNacimiento')) then
                contactoTurno_fechaNacimiento:=trim(extrae_valor(trim(linea)));


         end;

       end;





       if (trim(es_linea(linea))=trim(es_linea('DATOSVEHICULO'))) and (sigue=1)  then
      begin
       SALE:='N' ;
           WHILE (SALE='N') or (eof(ARCHIVOPROCESO))  DO
             BEGIN
              readln(ARCHIVOPROCESO,linea);

                if trim(es_linea(linea))=trim(es_linea('NUMEROCHASIS')) then
                 begin
                  SALE:='S' ;
                  sigue:=1;
                  end;

                  {vehiculo}




            if trim(es_linea(linea))=trim(es_linea('dominio')) then
           datosVehiculo_dominio:=trim(extrae_valor(trim(linea)));



           if trim(es_linea(linea))=trim(es_linea('marcaID')) then
           datosVehiculo_marcaID:=trim(extrae_valor(trim(linea)));



          if trim(es_linea(linea))=trim(es_linea('marca')) then
           datosVehiculo_marca:=trim(extrae_valor(trim(linea)));



          if trim(es_linea(linea))=trim(es_linea('tipoID')) then
           datosVehiculo_tipoID:=trim(extrae_valor(trim(linea)));



         if trim(es_linea(linea))=trim(es_linea('tipo')) then
           datosVehiculo_tipo:=trim(extrae_valor(trim(linea)));



        if trim(es_linea(linea))=trim(es_linea('modeloID')) then
           datosVehiculo_modeloID:=trim(extrae_valor(trim(linea)));



        if trim(es_linea(linea))=trim(es_linea('modelo')) then
           datosVehiculo_modelo:=trim(extrae_valor(trim(linea)));



        end;

     end;




        if (trim(es_linea(linea))=trim(es_linea('NUMEROCHASIS'))) and (sigue=1)  then
      begin
       SALE:='N' ;
         WHILE (SALE='N') or (eof(ARCHIVOPROCESO))  DO
         BEGIN
              readln(ARCHIVOPROCESO,linea);

                if trim(es_linea(linea))=trim(es_linea('DATOSVALIDADOS')) then
                 begin
                  SALE:='S' ;
                  sigue:=1;
                  end;

          
          if trim(es_linea(linea))=trim(es_linea('marca')) then
           numeroChasis_marca:=trim(extrae_valor(trim(linea)));



          if trim(es_linea(linea))=trim(es_linea('numero')) then
           numeroChasis_numero:=trim(extrae_valor(trim(linea)));



        if trim(es_linea(linea))=trim(es_linea('anio')) then
           datosVehiculo_anio:=trim(extrae_valor(trim(linea)));



          if trim(es_linea(linea))=trim(es_linea('jurisdiccionID')) then
           datosVehiculo_jurisdiccionID:=trim(extrae_valor(trim(linea)));



          if trim(es_linea(linea))=trim(es_linea('jurisdiccion')) then
           datosVehiculo_jurisdiccion:=trim(extrae_valor(trim(linea)));



          if trim(es_linea(linea))=trim(es_linea('mtm')) then
           datosVehiculo_mtm:=trim(extrae_valor(trim(linea)));



          if trim(es_linea(linea))=trim(es_linea('valTitular')) then
           datosVehiculo_valTitular:=trim(extrae_valor(trim(linea)));



          if trim(es_linea(linea))=trim(es_linea('valChasis')) then
           datosVehiculo_valChasis:=trim(extrae_valor(trim(linea)));

     end;

      end;



   

        if (trim(es_linea(linea))=trim(es_linea('DATOSVALIDADOS'))) and (sigue=1)  then
      begin
       SALE:='N' ;
           WHILE (SALE='N') or (eof(ARCHIVOPROCESO))  DO
         BEGIN
              readln(ARCHIVOPROCESO,linea);

                if trim(es_linea(linea))=trim(es_linea('DATOSFACTURACION')) then
                 begin
                  SALE:='S' ;
                  sigue:=1;
                  end;


            if trim(es_linea(linea))=trim(es_linea('marcaID')) then
           datosValidados_marcaID:=trim(extrae_valor(trim(linea)));




          if trim(es_linea(linea))=trim(es_linea('marca')) then
           datosValidados_marca:=trim(extrae_valor(trim(linea)));



          if trim(es_linea(linea))=trim(es_linea('tipoID')) then
           datosValidados_tipoID:=trim(extrae_valor(trim(linea)));



          if trim(es_linea(linea))=trim(es_linea('tipo')) then
           datosValidados_tipo:=trim(extrae_valor(trim(linea)));



          if trim(es_linea(linea))=trim(es_linea('modeloID')) then
           datosValidados_modeloID:=trim(extrae_valor(trim(linea)));



          if trim(es_linea(linea))=trim(es_linea('modelo')) then
           datosValidados_modelo:=trim(extrae_valor(trim(linea)));



          if trim(es_linea(linea))=trim(es_linea('marca')) then
           numeroChasis_marca:=trim(extrae_valor(trim(linea)));



          if trim(es_linea(linea))=trim(es_linea('numero')) then
           numeroChasis_numero:=trim(extrae_valor(trim(linea)));



          if trim(es_linea(linea))=trim(es_linea('mtm')) then
           datosValidados_mtm:=trim(extrae_valor(trim(linea)));



  end;

  end;


   if (trim(es_linea(linea))=trim(es_linea('DATOSFACTURACION'))) and (sigue=1)  then
      begin
       SALE:='N' ;
         WHILE (SALE='N') or (eof(ARCHIVOPROCESO))  DO
         BEGIN

            IF GUARDAR_EN_B='N' THEN
              readln(ARCHIVOPROCESO,linea);

                if (trim(es_linea(linea))=trim(es_linea('ITEM'))) or (trim(es_linea(linea))=trim(es_linea('**FIN**')))  then
                 begin
                  SALE:='S' ;
                  sigue:=1;
                  GUARDAR_EN_B:='S';
                  end;


                     if (trim(es_linea(linea))=trim(es_linea('DATOSPERSONALES')))  then
                     begin
                           SALE1:='N' ;
                           WHILE (SALE1='N') or (eof(ARCHIVOPROCESO))  DO
                            BEGIN
                               readln(ARCHIVOPROCESO,linea);

                               if trim(es_linea(linea))=trim(es_linea('DOMICILIO'))  then
                                    begin
                                       SALE1:='S' ;
                                       sigue:=1;
                                   end;

                                  if trim(es_linea(linea))=trim(es_linea('genero')) then
                                     datosPersonales_genero:=trim(extrae_valor(trim(linea)));


                                     if trim(es_linea(linea))=trim(es_linea('tipoDocumento')) then
                                       datosPersonales_tipoDocumento:=trim(extrae_valor(trim(linea)));


                                    if trim(es_linea(linea))=trim(es_linea('numeroDocumento')) then
                                         datosPersonales_numeroDocumento:=trim(extrae_valor(trim(linea)));




                                  if trim(es_linea(linea))=trim(es_linea('numeroCuit')) then
                                        datosPersonales_numeroCuit:=trim(extrae_valor(trim(linea)));



                                    if trim(es_linea(linea))=trim(es_linea('nombre')) then
                                       datosPersonales_nombre:=StringReplace(trim(extrae_valor(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);



                                      if trim(es_linea(linea))=trim(es_linea('apellido')) then
                                         datosPersonales_apellido:=StringReplace(trim(extrae_valor(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);




                                           if trim(es_linea(linea))=trim(es_linea('razonSocial')) then
                                      datosPersonales_razonSocial:=trim(extrae_valor(trim(linea)));



                            end;

                     end;

                   {datospersona�es}

                     {DOMICLIO}
                     if (trim(es_linea(linea))=trim(es_linea('DOMICILIO')))  then
                     begin
                           SALE1:='N' ;
                           WHILE (SALE1='N') or (eof(ARCHIVOPROCESO))  DO
                            BEGIN
                               readln(ARCHIVOPROCESO,linea);

                               if trim(es_linea(linea))=trim(es_linea('DATOSPAGO'))  then
                                    begin
                                       SALE1:='S' ;
                                       sigue:=1;
                                   end;


                     END;

                   END;



                   {DATOSPAGO}
                     if (trim(es_linea(linea))=trim(es_linea('DATOSPAGO')))  then
                     begin
                           SALE1:='N' ;
                           WHILE (SALE1='N') or (eof(ARCHIVOPROCESO))  DO
                            BEGIN
                               readln(ARCHIVOPROCESO,linea);

                               if trim(es_linea(linea))=trim(es_linea('DETALLESPAGOVERIFICACION'))  then
                                    begin
                                       SALE1:='S' ;
                                       sigue:=1;
                                   end;


                     END;

                   END;



                     {DETALLESPAGOVERIFICACION}
                     if (trim(es_linea(linea))=trim(es_linea('DETALLESPAGOVERIFICACION')))  then
                     begin
                           SALE1:='N' ;
                           WHILE (SALE1='N') or (eof(ARCHIVOPROCESO))  DO
                            BEGIN
                               readln(ARCHIVOPROCESO,linea);

                               if trim(es_linea(linea))=trim(es_linea('DETALLESPAGOOBLEA'))  then
                                    begin
                                       SALE1:='S' ;
                                       sigue:=1;
                                   end;


                     END;

                   END;

                        {DETALLESPAGOOBLEA}
                     if (trim(es_linea(linea))=trim(es_linea('DETALLESPAGOOBLEA')))  then
                     begin
                           SALE1:='N' ;
                           WHILE ((SALE1='N') or eof(ARCHIVOPROCESO) OR (GUARDAR_EN_B='N'))  DO
                            BEGIN
                               readln(ARCHIVOPROCESO,linea);

                              if (trim(es_linea(linea))=trim(es_linea('ITEM'))) OR (trim(es_linea(linea))=trim(es_linea('**FIN**')))   then
                                    begin
                                       GUARDAR_EN_B:='S';
                                       SALE1:='S';
                                   end;


                          END;

                        END;



                 {DATOSFACTURACION}
               end;

         end;

if (trim(es_linea(linea))=trim(es_linea('ITEM'))) AND (GUARDAR_EN_B='S') then
BEGIN
  IF  (TRIM(SELF.VER_esReveDia)='N') AND ((TRIM(SELF.VER_esReve)='N')) THEN
     ES_REVERIFICACION:='N'
     ELSE
     ES_REVERIFICACION:='S';

    // Guarda_turno_en_basedatos;
              {
IF IDCL=FALSE THEN
   Guarda_turno_en_basedatos
   ELSE
   Guarda_turno_en_basedatos_IDCLIENTECERO;

         }
 
  SALE:='N';
  GUARDAR_EN_B:='N';
          NO_HACE_FACTURA_ELECTRONICA:=FALSE;
 respuestaID:='';
respuestaMensaje:='';

turnoID:='';
estadoID:='';
estado:='';
tipoTurno:='';
esReve:='';
esReveDia:='';
fechaTurno:='';
horaTurno:='';
fechaRegistro:='';
fechaNovedad:='';
plantaID:='';
re_item_turnoID:='';
re_item_plantaID:='';
re_item_estado:='';
re_item_fechaNovedad:='';
re_datosPago_pagoID:='';
re_datosPago_entidadID:='';
re_datosPago_fechaPago:='';
re_datosPago_importeTotal:='';
re_detallesPagoVerificacion_pagoID:='';
re_detallesPagoVerificacion_importe:='';
re_detallesPagoVerificacion_estadoAcreditacion:='';
re_detallesPagoOblea_pagoID:='';
re_detallesPagoOblea_importe:='';
re_detallesPagoOblea_estadoAcreditacion:='';
datosTitular_genero:='';
datosTitular_tipoDocumento:='';
datosTitular_numeroDocumento:='';
datosTitular_numeroCuit:='';
datosTitular_nombre:='';
datosTitular_apellido:='';
datosTitular_razonSocial:='';
datosPersonalesTurno_tipoDocumento:='';
datosPersonalesTurno_numeroCuit:='';
datosPersonalesTurno_nombre:='';
datosPersonalesTurno_apellido:='';
datosPersonalesTurno_razonSocial:='';
contactoTurno_telefonoCelular:='';
contactoTurno_email:='';
contactoTurno_fechaNacimiento:='';
datosPersonales_genero:='';
datosPersonales_tipoDocumento:='';
datosPersonales_numeroDocumento:='';
datosPersonales_numeroCuit:='';
datosPersonales_nombre:='';
datosPersonales_apellido:='';
datosPersonales_razonSocial:='';
datosFacturacion_domicilio:='';
domicilio_calle:='';
domicilio_numero:='';
domicilio_piso:='';
domicilio_departamento:='';
domicilio_localidad:='';
domicilio_provinciaID:='';
domicilio_provincia:='';
domicilio_codigoPostal:='';
datosFacturacion_condicionIva:='';
datosFacturacion_numeroIibb:='';
datosPago_pagoID:='';
datosPago_gatewayID:='';
datosPago_entidadID:='';
datosPago_entidadNombre:='';
datosPago_fechaPago:='';
datosPago_importeTotal:='';
detallesPagoVerificacion_pagoID:='';
detallesPagoVerificacion_importe:='';
detallesPagoVerificacion_estadoAcreditacion:='';
detallesPagoVerificacion_pagoGatewayID:='';
detallesPagoOblea_pagoID:='';
detallesPagoOblea_importe:='';
detallesPagoOblea_estadoAcreditacion:='';
datosVehiculo_dominio:='';
datosVehiculo_marcaID:='';
datosVehiculo_marca:='';
datosVehiculo_tipoID:='';
datosVehiculo_tipo:='';
datosVehiculo_modeloID:='';
datosVehiculo_modelo:='';
numeroChasis_marca:='';
numeroChasis_numero:='';
datosVehiculo_anio:='';
datosVehiculo_jurisdiccionID:='';
datosVehiculo_jurisdiccion:='';
datosVehiculo_mtm:='';
datosVehiculo_valTitular:='';
datosVehiculo_valChasis:='';
datosValidados_marcaID:='';
datosValidados_marca:='';
datosValidados_tipoID:='';
datosValidados_tipo:='';
datosValidados_modeloID:='';
datosValidados_modelo:='';
numeroChasis_marca:='';
numeroChasis_numero:='';
datosValidados_mtm:='';
 END;  //BASE


END; //CANTIDAD



























        {datos facturacion}
      {

   if trim(es_linea(linea))=trim(es_linea('datosFacturacion_domicilio')) then
           datosFacturacion_domicilio:=StringReplace(trim(extrae_valor(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);




   if trim(es_linea(linea))=trim(es_linea('domicilio_calle')) then
           domicilio_calle:=StringReplace(trim(extrae_valor(trim(linea))), '''', ' ',[rfReplaceAll, rfIgnoreCase]);




   if trim(es_linea(linea))=trim(es_linea('domicilio_numero')) then
           domicilio_numero:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('domicilio_piso')) then
           domicilio_piso:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('domicilio_departamento')) then
           domicilio_departamento:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('domicilio_localidad')) then
           domicilio_localidad:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('domicilio_provinciaID')) then
           domicilio_provinciaID:=trim(extrae_valor(trim(linea)));


   if trim(es_linea(linea))=trim(es_linea('domicilio_provincia')) then
           domicilio_provincia:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('domicilio_codigoPostal')) then
           domicilio_codigoPostal:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosFacturacion_condicionIva')) then
           datosFacturacion_condicionIva:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosFacturacion_numeroIibb')) then
           datosFacturacion_numeroIibb:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPago_pagoID')) then
           datosPago_pagoID:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPago_gatewayID')) then
           datosPago_gatewayID:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPago_entidadID')) then
           datosPago_entidadID:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPago_entidadNombre')) then
           datosPago_entidadNombre:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPago_fechaPago')) then
           datosPago_fechaPago:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPago_importeTotal')) then
           datosPago_importeTotal:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_pagoID')) then
           detallesPagoVerificacion_pagoID:=trim(extrae_valor(trim(linea)));



    if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_plantaID')) then
           detallesPagoVerificacion_plantaID:=trim(extrae_valor(trim(linea)));




   if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_importe')) then
           detallesPagoVerificacion_importe:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_estadoAcreditacion')) then
           detallesPagoVerificacion_estadoAcreditacion:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_pagoGatewayID')) then
           detallesPagoVerificacion_pagoGatewayID:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('detallesPagoOblea_pagoID')) then
           detallesPagoOblea_pagoID:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('detallesPagoOblea_importe')) then
           detallesPagoOblea_importe:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('detallesPagoOblea_estadoAcreditacion')) then
           detallesPagoOblea_estadoAcreditacion:=trim(extrae_valor(trim(linea)));


  }








 end;  //while

   CLOSEFILE(ARCHIVOPROCESO);



END;

function txml_caba.extrae_valor(cadena:string):string;
var posi:longint;
begin
posi:=pos('=',cadena);
 if posi> 0 then
  begin
    extrae_valor:=trim(copy(trim(cadena),posi+1,length(trim(cadena))));
  end else
    extrae_valor:='0';

end;



function txml_caba.extrae_valor_PAGOS(cadena:string):string;
var posi:longint;
begin
posi:=pos('=',cadena);
 if posi> 0 then
  begin
    extrae_valor_PAGOS:=trim(copy(trim(cadena),posi+1,length(trim(cadena))));
  end else
    extrae_valor_PAGOS:='';

end;



function txml_caba.es_linea(cadena:string):string ;
 var posi:longint;
begin
 posi:=pos('=',trim(cadena));
 if posi <> 0 then
   es_linea:=copy(trim(cadena),0,posi-1)
   else
   es_linea:=cadena;

end;

FUNCTION txml_caba.POR_TURNOID(IDTURNO, PATENTE:STRING):STRING;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;     aq:tsqlquery ;
    request, response: TStringStream;
   xml,FECHADESDE,FECHAHASTA,spatente:string;
     MyText: TStringlist ;
begin
try
{aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
aq.sql.add('SELECT  DVDOMINO FROM tdatosturno   '+
                     ' WHERE TURNOID='+INTTOSTR(idturno));
aq.ExecSQL;
aq.open;
patente:=trim(aq.fieldbyname('DVDOMINO').asstring);
aq.close;
aq.free;}

if trim(patente)='' then
  patente:=trim(spatente);




xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:solicitarTurno soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(self.ver_ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_PLANTA)+'</plantaID>'+
         '<turnoID xsi:type="xsd:unsignedLong">'+trim(idturno)+'</turnoID>'+
         '<dominio xsi:type="xsd:string">'+trim(patente)+'</dominio>'+
      '</urn:solicitarTurno>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';






strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');

  MyText:= TStringlist.create;
  MyText.LoadFromStream(request);
  MyText.SaveToFile(ExtractFilePath(Application.ExeName) +'ENVIADACONSULTA_PORID'+ver_ingresoID_Abrir+'.xml');
  MyText.SaveToFile(ExtractFilePath(Application.ExeName) +'ENVIADACONSULTA_PORID'+ver_ingresoID_Abrir+'.txt');
  MyText.Free;




recieveID :=HTTPRIO.HTTPWebNode.Send(request);



HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response


response.Position := 0;

   MyText:= TStringlist.create;
   MyText.LoadFromStream(response);
  MyText.SaveToFile(ExtractFilePath(Application.ExeName) +'CONSULTA_PORID'+ver_ingresoID_Abrir+'.xml');
  MyText.SaveToFile(ExtractFilePath(Application.ExeName) +'CONSULTA_PORID'+ver_ingresoID_Abrir+'.txt');
  MyText.Free;





strings.Free;
request.Free;
response.Free;


POR_TURNOID:=ExtractFilePath(Application.ExeName) +'CONSULTA_PORID'+ver_ingresoID_Abrir+'.xml';
except

  POR_TURNOID:='0';
end;



END;


FUNCTION txml_caba.POR_TURNOID_CLIENTE_CERO(IDTURNO, PATENTE:STRING):STRING;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;     aq:tsqlquery ;
    request, response: TStringStream;
   xml,FECHADESDE,FECHAHASTA,spatente:string;
     MyText: TStringlist ;
begin
try
{aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
aq.sql.add('SELECT  DVDOMINO FROM tdatosturno   '+
                     ' WHERE TURNOID='+INTTOSTR(idturno));
aq.ExecSQL;
aq.open;
patente:=trim(aq.fieldbyname('DVDOMINO').asstring);
aq.close;
aq.free;}

if trim(patente)='' then
  patente:=trim(spatente);




xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:solicitarTurno soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(self.ver_ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_PLANTA)+'</plantaID>'+
         '<turnoID xsi:type="xsd:unsignedLong">'+trim(idturno)+'</turnoID>'+
         '<dominio xsi:type="xsd:string">'+trim(patente)+'</dominio>'+
      '</urn:solicitarTurno>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';






strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');

  MyText:= TStringlist.create;
  MyText.LoadFromStream(request);
  MyText.SaveToFile(ExtractFilePath(Application.ExeName) +'ENVIADACONSULTA_PORID'+ver_ingresoID_Abrir+'.xml');
  MyText.SaveToFile(ExtractFilePath(Application.ExeName) +'ENVIADACONSULTA_PORID'+ver_ingresoID_Abrir+'.txt');
  MyText.Free;




recieveID :=HTTPRIO.HTTPWebNode.Send(request);



HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response


response.Position := 0;

   MyText:= TStringlist.create;
   MyText.LoadFromStream(response);
  MyText.SaveToFile(ExtractFilePath(Application.ExeName) +'CONSULTA_PORID'+ver_ingresoID_Abrir+'.xml');
  MyText.SaveToFile(ExtractFilePath(Application.ExeName) +'CONSULTA_PORID'+ver_ingresoID_Abrir+'.txt');
  MyText.Free;





strings.Free;
request.Free;
response.Free;


POR_TURNOID_CLIENTE_CERO:=ExtractFilePath(Application.ExeName) +'CONSULTA_PORID'+ver_ingresoID_Abrir+'.xml';
except

  POR_TURNOID_CLIENTE_CERO:='0';
end;



END;



Function txml_caba.Abrir_Seccion:boolean;
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
   MyText: TStringlist;
begin
TRY
xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv"> '+
     '<soapenv:Header/> '+
    '<soapenv:Body> '+
    '<urn:abrirSesion soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"> ';
xml:=xml+'<usuarioID xsi:type="xsd:unsignedLong">'+inttostr(ver_USUARIO)+'</usuarioID> ';
xml:=xml+'<plantaID xsi:type="xsd:unsignedLong">'+inttostr(ver_PLANTA)+'</plantaID> ';
xml:=xml+'<usuarioToken xsi:type="xsd:token">'+trim(ver_PASSWORD)+'</usuarioToken> ';
xml:=xml+'<usuarioHash xsi:type="xsd:token">'+trim(ver_HASH)+'</usuarioHash> '+
      '</urn:abrirSesion> '+
   '</soapenv:Body> '+
   '</soapenv:Envelope>';




strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');



recieveID :=HTTPRIO.HTTPWebNode.Send(request);           //Request

HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response

response.Position := 0;

MyText:= TStringlist.create;
MyText.LoadFromStream(response);
MyText.SaveToFile(ExtractFilePath(Application.ExeName) +'ABRIR.xml');
MyText.Free;







strings.Free;
request.Free;
response.Free;

LeerArchivoAbrir;
EXCEPT
   on E : Exception do
   BEGIN

    TRAZAS('ERROR EN FUNCION Abrir_Seccion. '+E.ClassName+'. error : '+E.Message);
   END;

END;
end;

Procedure txml_caba.Leer_archivo_pagos_encabezado(archivo:string);
var
  ANode,ANode1,ANode2: IXMLNode;
  I,j,jj: integer;
  CadenaLibro,
  CadenaSalida,x: string;

begin

XMLDocument.FileName:=trim(archivo);
XMLDocument.Active:=true;
TRY
  for I := 0 to XMLDocument.DocumentElement.ChildNodes.Count - 1 do begin
    ANode := XMLDocument.DocumentElement.ChildNodes[I];
    x:=anode.NodeName;

      for j := 0 to anode.ChildNodes.Count - 1 do begin
        ANode1 := anode.ChildNodes[j];
        x:=anode1.NodeName;
        for jj := 0 to anode1.ChildNodes.Count - 1 do begin
        ANode2 := anode1.ChildNodes[jj];
        x:=anode2.NodeName;

           if ANode2.NodeType = ntElement then
           begin

              respuestaidpago :=strtoint(trim(ANode2.ChildNodes['respuestaID'].Text)) ;
              respuestamensajepago:=trim(ANode2.ChildNodes['respuestaMensaje'].Text) ;
              cantidadPagos :=trim(ANode2.ChildNodes['cantidadPagos'].Text) ;



             end;

    end;
    end;

  end;



EXCEPT
   on E : Exception do
   BEGIN
    respuestaidpago:=-661;
    TRAZAS('ERROR EN FUNCION Leer_archivo_pagos_encabezado. '+E.ClassName+'. error : '+E.Message+'. archivo: '+archivo);
   END;

END;

end;


Procedure txml_caba.Leer_archivo_informar_facturas_encabezado(archivo:string);
var
  ANode,ANode1,ANode2: IXMLNode;
  I,j,jj: integer;
  CadenaLibro,
  CadenaSalida,x,linea: string;
archi:textfile;
begin
assignfile(archi, archivo);
reset(archi);
while not eof(archi)do
begin
     readln(archi,linea);
     if (trim(es_linea(linea))=trim(es_linea('RETURN'))) then
      begin

            while (trim(es_linea(linea))<>trim(es_linea('FACTURASRESPUESTA'))) do
            begin
               readln(archi,linea);
                  if (trim(es_linea(linea))=trim(es_linea('respuestaID'))) then
                      respuestaid_informar_factura:=trim(extrae_valor_PAGOS(trim(linea)));

                  if (trim(es_linea(linea))=trim(es_linea('respuestaMensaje'))) then
                      respuestamensaje_informar_factura:=trim(extrae_valor_PAGOS(trim(linea)));



            end;

      end;



       if (trim(es_linea(linea))=trim(es_linea('FACTURASRESPUESTA'))) then
      begin

            while (trim(es_linea(linea))<>trim(es_linea('**FIN**'))) do
            begin
               readln(archi,linea);
                  if (trim(es_linea(linea))=trim(es_linea('respuestaID'))) then
                      respuestaid_factura_informar_factura:=trim(extrae_valor_PAGOS(trim(linea)));

                  if (trim(es_linea(linea))=trim(es_linea('respuestaMensaje'))) then
                      respuestamensaje_factura_informar_factura:=trim(extrae_valor_PAGOS(trim(linea)));



            end;

      end;



end;

closefile(archi);
end;

 Procedure txml_caba.LeerArchivoAbrir;
 var
  ANode,ANode1,ANode2: IXMLNode;
  I,j,jj: integer;
  CadenaLibro,
  CadenaSalida,x: string;

begin
TRY
XMLDocument.FileName:=ExtractFilePath(Application.ExeName) +'ABRIR.xml';
XMLDocument.Active:=true;
  for I := 0 to XMLDocument.DocumentElement.ChildNodes.Count - 1 do begin
    ANode := XMLDocument.DocumentElement.ChildNodes[I];
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

EXCEPT
   on E : Exception do
   BEGIN

    TRAZAS('ERROR EN FUNCION LeerArchivoAbrir (LEER AUTORIZACION DEL SERVIDOR). '+E.ClassName+'. error : '+E.Message);
   END;

END;

end;


FUNCTION txml_caba.ARMA_FECHA(FECHA:string):STRING;
VAR FE:STRING;
BEGIN
FE:=fecha;
//FE:=DATETOSTR(FECHA);
ARMA_FECHA:=TRIM(COPY(TRIM(FE),7,4))+'-'+TRIM(COPY(TRIM(FE),4,2))+'-'+TRIM(COPY(TRIM(FE),1,2))+' '+trim(copy(trim(fe),11,length(trim(fe))));
END;
FUNCTION txml_caba.ARMA_FECHA1(FECHA:string):STRING;
VAR FE:STRING;
BEGIN
ARMA_FECHA1:=TRIM(COPY(TRIM(FECHA),7,4))+'-'+TRIM(COPY(TRIM(FECHA),4,2))+'-'+TRIM(COPY(TRIM(FECHA),1,2))+'T'+TRIM(COPY(TRIM(FECHA),12,length(fecha)));
END;




FUNCTION txml_caba.TEST_INFORMAR_FACTURA(archivo,n:string):BOOLEAN;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
   xml,FECHADESDE,FECHAHASTA,FDesde,fHasta:string;
   MyText: TStringlist;
    fecha : string;
  Tfecha1 : TDateTime;
  Tfecha2 : TDateTime;

    ARCHIVOPROCESO:textfile;
   mdate, mdate1:tdatetime;
   hora:integer;

  Stream: TMemoryStream;
  Texto_encode,texto_md5,archi: String;

begin

  Stream:= TMemoryStream.Create;
  try
    Stream.LoadFromFile(archivo);
    Texto_encode:= base64_new.BinToStr(Stream.Memory,Stream.Size);
    //texto_md5:=base64_new.md5(archivo);
    texto_md5:=base64_new.md5_suvtv(archivo) ;
  finally
    Stream.Free;
  end;



try

 xml:='<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:ns1="urn:suvtv" xmlns:xsd="http://www.w3.org/2001/XMLSchema" '+
'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">';
 xml:=xml+  '<SOAP-ENV:Body>'+
      '<ns1:informarFacturas>'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(ver_ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_PLANTA)+'</plantaID>'+
         '<facturas SOAP-ENC:arrayType="ns1:facturas[1]" xsi:type="ns1:facturasListado">'+
            '<item xsi:type="ns1:facturas">'+
               '<externalReference xsi:type="xsd:unsignedLong">109956</externalReference>'+
               '<numeroFactura xsi:type="xsd:unsignedLong">'+n+'</numeroFactura>'+
               '<tipoComprobante xsi:type="ns1:tipoComprobante">6</tipoComprobante>'+
               '<importeTotal xsi:type="xsd:float">680</importeTotal>'+
               '<importeNeto xsi:type="xsd:float">622</importeNeto>'+
               '<importeIVA xsi:type="xsd:float">50</importeIVA>'+
               '<cae xsi:type="xsd:unsignedLong">23453453456456</cae>'+
               '<vencimientoCae xsi:type="xsd:date">2017-03-03</vencimientoCae>'+
               '<tipoFactura xsi:type="ns1:tipoFactura">FC</tipoFactura>'+
               '<fechaFactura xsi:type="xsd:date">2017-03-01</fechaFactura>'+
               '<factura xsi:type="ns1:comprobante">'+
                   '<comprobante xsi:type="xsd:string">'+trim(Texto_encode)+'</comprobante>'+
                  '<comprobanteHash xsi:type="xsd:token">'+trim(texto_md5)+'</comprobanteHash>'+
                  '</factura>'+
            '</item>'+
        '</facturas>'+
      '</ns1:informarFacturas>'+
   '</SOAP-ENV:Body>'+
'</SOAP-ENV:Envelope>';







strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');

MyText:= TStringlist.create;
MyText.LoadFromStream(request);
MyText.SaveToFile(ExtractFilePath(Application.ExeName)  +'ENVIADA_FACTURA'+ver_ingresoID_Abrir+'.xml');
MyText.Free;




recieveID :=HTTPRIO.HTTPWebNode.Send(request);           //Request

HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response


response.Position := 0;


MyText:= TStringlist.create;
MyText.LoadFromStream(response);
MyText.SaveToFile(ExtractFilePath(Application.ExeName)   +'CONSULTA_FACTURA'+ver_ingresoID_Abrir+'.xml');
MyText.SaveToFile(ExtractFilePath(Application.ExeName)    +'archivo_xml.xml');
MyText.Free;




strings.Free;
request.Free;
response.Free;


ASSIGNFILE(ARCHIVOPROCESO,ExtractFilePath(Application.ExeName)+'parseado.txt');
rewrite(ARCHIVOPROCESO);
closefile(ARCHIVOPROCESO);

{ejecuta aplicacion xml.exe desarrollada en visual basic para pasear
el xml en forma de cabecera / detalle item}
if EjecutarYEsperar( ExtractFilePath( Application.ExeName ) + 'xml.exe', SW_SHOWNORMAL ) = 0 then

{agrega al archivo parseado al final la linea **FIN**}
append(ARCHIVOPROCESO);
WRITELN(ARCHIVOPROCESO,'**FIN**');
CLOSEFILE(ARCHIVOPROCESO);


Leer_archivo_informar_facturas_encabezado(ExtractFilePath(Application.ExeName)+'parseado.txt');

  TEST_INFORMAR_FACTURA:=TRUE;
except

  TEST_INFORMAR_FACTURA:=FALSE;
end;


END;




FUNCTION txml_caba.POR_NOVEDAD(IDTURNO, PATENTE:STRING):STRING;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
   xml,FECHADESDE,FECHAHASTA,FDesde,fHasta:string;
   MyText: TStringlist;
    fecha : string;
  Tfecha1 : TDateTime;
  Tfecha2 : TDateTime;


   mdate, mdate1:tdatetime;
   hora:integer;
begin
try

 IF (TIMETOSTR(TIME) > '01:00:00')  AND (TIMETOSTR(TIME) < '01:45:00') THEN
     hora:=3
     ELSE
     hora:=2;


 mdate:=now;

 mdate1:=inchour(mdate,-abs(hora));


 FECHADESDE:=datetimetostr(mdate1);
 FECHAHASTA:=datetimetostr(mdate);

 FECHADESDE:=ARMA_FECHA1(FECHADESDE);
 FECHAHASTA:=ARMA_FECHA1(FECHAHASTA);


{fecha := datetostr(date) + ' ' +timetostr(time);

Tfecha2 := strtodatetime(fecha);
Tfecha1:= IncHour(Tfecha2, -3);

FECHADESDE:=ARMA_FECHA(datetimetostr(Tfecha1));
FECHAHASTA:=ARMA_FECHA(datetimetostr(Tfecha2)); }
{FECHADESDE:=ARMA_FECHA(DATE)+' '+timetostr(inchour(time,-3));
FECHAHASTA:=ARMA_FECHA(date)+' '+timetostr(time); }

xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:solicitarTurnos soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(ver_ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_PLANTA)+'</plantaID>'+
         '<tipoConsulta xsi:type="urn:tipoConsultaTurno">N</tipoConsulta>'+
         '<fechaDesde xsi:type="xsd:date">'+TRIM(FECHADESDE)+'</fechaDesde>'+
         '<fechaHasta xsi:type="xsd:date">'+TRIM(FECHAHASTA)+'</fechaHasta>'+
      '</urn:solicitarTurnos>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';






strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');

MyText:= TStringlist.create;
MyText.LoadFromStream(request);
MyText.SaveToFile(ExtractFilePath(Application.ExeName)  +'ENVIADACONSULTA'+ver_ingresoID_Abrir+'.xml');
MyText.Free;




recieveID :=HTTPRIO.HTTPWebNode.Send(request);           //Request

HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response


response.Position := 0;


MyText:= TStringlist.create;
MyText.LoadFromStream(response);
MyText.SaveToFile(ExtractFilePath(Application.ExeName)   +'CONSULTA'+ver_ingresoID_Abrir+'.xml');
MyText.SaveToFile(ExtractFilePath(Application.ExeName)    +'archivo_xml_turnos.xml');
MyText.Free;




strings.Free;
request.Free;
response.Free;

if fileexists(ExtractFilePath(Application.ExeName) +'CONSULTA'+ver_ingresoID_Abrir+'.xml')=true then
   POR_NOVEDAD:=ExtractFilePath(Application.ExeName) +'CONSULTA'+ver_ingresoID_Abrir+'.xml'
   else
   POR_NOVEDAD:='*';


except

  POR_NOVEDAD:='*';
end;


END;

 FUNCTION txml_caba.POR_NOVEDAD_20(horad, horah:STRING):STRING;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
   xml,FECHADESDE,FECHAHASTA,FDesde,fHasta:string;
   MyText: TStringlist;
    fecha : string;
  Tfecha1 : TDateTime;
  Tfecha2 : TDateTime;


   mdate, mdate1:tdatetime;
   hora:integer;
begin
try

 IF (TIMETOSTR(TIME) > '01:00:00')  AND (TIMETOSTR(TIME) < '01:45:00') THEN
     hora:=3
     ELSE
     hora:=2;

 mdate:=now;

 mdate1:=incminute(mdate,-abs(20));


 FECHADESDE:=datetimetostr(mdate1);
 FECHAHASTA:=datetimetostr(mdate);

 FECHADESDE:=ARMA_FECHA1(FECHADESDE);
 FECHAHASTA:=ARMA_FECHA1(FECHAHASTA);
 form1.Memo1.Lines.Add('Desde: '+FECHADESDE+'   Hasta: '+FECHAHASTA);







{fecha := datetostr(date) + ' ' +timetostr(time);

Tfecha2 := strtodatetime(fecha);
Tfecha1:= IncHour(Tfecha2, -3);

FECHADESDE:=ARMA_FECHA(datetimetostr(Tfecha1));
FECHAHASTA:=ARMA_FECHA(datetimetostr(Tfecha2)); }
{FECHADESDE:=ARMA_FECHA(DATE)+' '+timetostr(inchour(time,-3));
FECHAHASTA:=ARMA_FECHA(date)+' '+timetostr(time); }

xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:solicitarTurnos soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(ver_ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_PLANTA)+'</plantaID>'+
         '<tipoConsulta xsi:type="urn:tipoConsultaTurno">N</tipoConsulta>'+
         '<fechaDesde xsi:type="xsd:date">'+TRIM(FECHADESDE)+'</fechaDesde>'+
         '<fechaHasta xsi:type="xsd:date">'+TRIM(FECHAHASTA)+'</fechaHasta>'+
      '</urn:solicitarTurnos>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';






strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');

MyText:= TStringlist.create;
MyText.LoadFromStream(request);
MyText.SaveToFile(ExtractFilePath(Application.ExeName)  +'ENVIADACONSULTA'+ver_ingresoID_Abrir+'.xml');
MyText.Free;




recieveID :=HTTPRIO.HTTPWebNode.Send(request);           //Request

HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response


response.Position := 0;


MyText:= TStringlist.create;
MyText.LoadFromStream(response);
MyText.SaveToFile(ExtractFilePath(Application.ExeName)   +'CONSULTA'+ver_ingresoID_Abrir+'.xml');
MyText.SaveToFile(ExtractFilePath(Application.ExeName)    +'archivo_xml_turnos.xml');
MyText.Free;




strings.Free;
request.Free;
response.Free;

if fileexists(ExtractFilePath(Application.ExeName) +'CONSULTA'+ver_ingresoID_Abrir+'.xml')=true then
   POR_NOVEDAD_20:=ExtractFilePath(Application.ExeName) +'CONSULTA'+ver_ingresoID_Abrir+'.xml'
   else
   POR_NOVEDAD_20:='*';


except

  POR_NOVEDAD_20:='*';
end;


END;


FUNCTION txml_caba.POR_NOVEDAD_1830(horad, horah:STRING):STRING;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
   xml,FECHADESDE,FECHAHASTA,FDesde,fHasta:string;
   MyText: TStringlist;
    fecha : string;
  Tfecha1 : TDateTime;
  Tfecha2 : TDateTime;


   mdate, mdate1:tdatetime;
   hora:integer;
begin
try

 IF (TIMETOSTR(TIME) > '01:00:00')  AND (TIMETOSTR(TIME) < '01:45:00') THEN
     hora:=3
     ELSE
     hora:=2;

 horah:=datetostr(date)+' '+horah;
 mdate:=strtodatetime(horah);
 horad:=datetostr(date)+' '+horad;
 mdate1:=strtodatetime(horad);;


 FECHADESDE:=datetimetostr(mdate1);
 FECHAHASTA:=datetimetostr(mdate);

 FECHADESDE:=ARMA_FECHA1(FECHADESDE);
 FECHAHASTA:=ARMA_FECHA1(FECHAHASTA);


{fecha := datetostr(date) + ' ' +timetostr(time);

Tfecha2 := strtodatetime(fecha);
Tfecha1:= IncHour(Tfecha2, -3);

FECHADESDE:=ARMA_FECHA(datetimetostr(Tfecha1));
FECHAHASTA:=ARMA_FECHA(datetimetostr(Tfecha2)); }
{FECHADESDE:=ARMA_FECHA(DATE)+' '+timetostr(inchour(time,-3));
FECHAHASTA:=ARMA_FECHA(date)+' '+timetostr(time); }

xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:solicitarTurnos soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(ver_ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_PLANTA)+'</plantaID>'+
         '<tipoConsulta xsi:type="urn:tipoConsultaTurno">N</tipoConsulta>'+
         '<fechaDesde xsi:type="xsd:date">'+TRIM(FECHADESDE)+'</fechaDesde>'+
         '<fechaHasta xsi:type="xsd:date">'+TRIM(FECHAHASTA)+'</fechaHasta>'+
      '</urn:solicitarTurnos>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';






strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');

MyText:= TStringlist.create;
MyText.LoadFromStream(request);
MyText.SaveToFile(ExtractFilePath(Application.ExeName)  +'ENVIADACONSULTA'+ver_ingresoID_Abrir+'.xml');
MyText.Free;




recieveID :=HTTPRIO.HTTPWebNode.Send(request);           //Request

HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response


response.Position := 0;


MyText:= TStringlist.create;
MyText.LoadFromStream(response);
MyText.SaveToFile(ExtractFilePath(Application.ExeName)   +'CONSULTA'+ver_ingresoID_Abrir+'.xml');
MyText.SaveToFile(ExtractFilePath(Application.ExeName)    +'archivo_xml_turnos.xml');
MyText.Free;




strings.Free;
request.Free;
response.Free;

if fileexists(ExtractFilePath(Application.ExeName) +'CONSULTA'+ver_ingresoID_Abrir+'.xml')=true then
   POR_NOVEDAD_1830:=ExtractFilePath(Application.ExeName) +'CONSULTA'+ver_ingresoID_Abrir+'.xml'
   else
   POR_NOVEDAD_1830:='*';


except

  POR_NOVEDAD_1830:='*';
end;


END;

PROCEDURE txml_caba.PROCESARARCHIVOPAGOS(ARCHIVO:STRING);
BEGIN
 {incializa el archivo descargado para procesar}
 Inicializa_PAGOS(ARCHIVO) ;

END;


function txml_caba.generar_archivo(nombrearchivo:string):boolean;
Var
i,desde:longint;
 archi:textfile;   linea,linea1:string;
begin
generar_archivo:=false;
Form1.memo3.Clear;
Form1.memo2.Clear;
Form1.memo3.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + nombrearchivo+'.xml');//'CONSULTA.XML');
linea:=Form1.memo3.Lines.Text;
desde:=0;
for i:=0 to length(linea) do
begin
    if linea[i]='>' then
     begin
      Form1.memo2.Lines.Add(linea1);
      linea1:='';
      generar_archivo:=true;
     end else
     begin
      linea1:=linea1 + linea[i];

     end;


end;
  Form1.memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + nombrearchivo+'.txt');
  generar_archivo:=TRUE;
end;


function txml_caba.leer_respuesta_ausentes(archivo:string):boolean;
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



  { Application.MessageBox( PCHAR('RESPUESTA DE SUVTV: '+respuesta), 'Atenci�n',
  MB_ICONINFORMATION ); }

    end ;






end;



function txml_caba.leer_respuesta_ausentes_turnoid(idt:longint;archivo,TABLA:string):boolean;
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
   aQ.SQL.Add('UPDATE '+TRIM(TABLA)+' SET INFORMADOWS='+#39+TRIM(INFORME)+#39+', ESTADOID=4, ESTADODESC='+#39+TRIM(DESCESTADO)+#39+' WHERE turnoid='+inttostr(idt));
   aq.ExecSQL;
   AQ.Close;
   AQ.FREE;



  { Application.MessageBox( PCHAR('RESPUESTA DE SUVTV: '+respuesta), 'Atenci�n',
  MB_ICONINFORMATION ); }

    end ;






end;



Function txml_caba.informar_ausentes:boolean;
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
  '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(ver_ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_PLANTA)+'</plantaID>'+
    '     <fecha xsi:type="xsd:date">'+trim(fecha)+'</fecha>   ';






fechaturno:=datetostr(date);

aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
aq.sql.add('SELECT  COUNT(*) FROM TDATOSTURNO   '+
                     ' WHERE fechaturno=to_date('+#39+trim(fechaturno)+#39+',''dd/mm/yyyy'') and TRIM(ausente) in (''S'',''N'') and trim(reviso)=''N'' and TRIM(modo)=''P''  AND ESTADOID in(1,5,7) ');


aq.ExecSQL;
aq.open;
CANTIDAD:=AQ.FIELDS[0].ASINTEGER;

 XML:=XML +    '     <turnos SOAP-ENC:arrayType="ns1:turnosAusentes['+TRIM(AQ.FIELDS[0].ASSTRING)+']" xsi:type="ns1:turnosAusentesLista"> ';

AQ.CLOSE;
AQ.FREE;

IF CANTIDAD > 0 THEN
BEGIN
aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
{aq.sql.add('SELECT  TURNOID, DVDOMINO FROM tdatosturno   '+
                     ' WHERE  ausente=''S'' ');  }


aq.sql.add('SELECT  TURNOID, DVDOMINO FROM TDATOSTURNO   '+
                     ' WHERE fechaturno=to_date('+#39+trim(fechaturno)+#39+',''dd/mm/yyyy'') and TRIM(ausente) in (''S'',''N'') and trim(reviso)=''N'' and TRIM(modo)=''P''  AND ESTADOID in(1,5,7)  ');

aq.ExecSQL;
aq.open;
while not aq.eof do
begin



TAG:=TAG+'<item xsi:type="ns1:turnosAusentes">  '+
            '   <turnoID xsi:type="xsd:unsignedLong">'+TRIM(AQ.FIELDBYNAME('turnoid').ASSTRING)+'</turnoID>   '+
            '   <dominio xsi:type="xsd:string">'+TRIM(AQ.FIELDBYNAME('dvdomino').ASSTRING)+'</dominio> '+
            '</item>';



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

 Form1.Memo2.Clear;
 Form1.Memo2.Lines.LoadFromStream(request);
 Form1.Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'Enviadoinformarausentes.xml');

recieveID :=HTTPRIO.HTTPWebNode.Send(request);
         //Request

HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response

Form1.Memo2.Clear;
response.Position := 0;
Form1.Memo2.Lines.LoadFromStream(response);

Form1.Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'informarausentes.xml');
strings.Free;
request.Free;
response.Free

END;

informar_ausentes:=true;
except
  informar_ausentes:=falsE;
end;



 end;

  

Function txml_caba.informar_ausentes_TURNO_INDVI(IDT:LONGINT):boolean;
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
  '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(ver_ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_PLANTA)+'</plantaID>'+
    '     <fecha xsi:type="xsd:date">'+trim(fecha)+'</fecha>   ';






fechaturno:=datetostr(date);

aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
aq.sql.add('SELECT  COUNT(*) FROM TDATOSTURNO   '+
                     ' WHERE TURNOID='+INTTOSTR(IDT));


aq.ExecSQL;
aq.open;
CANTIDAD:=AQ.FIELDS[0].ASINTEGER;

 XML:=XML +    '     <turnos SOAP-ENC:arrayType="ns1:turnosAusentes['+TRIM(AQ.FIELDS[0].ASSTRING)+']" xsi:type="ns1:turnosAusentesLista"> ';

AQ.CLOSE;
AQ.FREE;

IF CANTIDAD > 0 THEN
BEGIN
aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
{aq.sql.add('SELECT  TURNOID, DVDOMINO FROM tdatosturno   '+
                     ' WHERE  ausente=''S'' ');  }


aq.sql.add('SELECT  TURNOID, DVDOMINO FROM TDATOSTURNO   '+
                     ' WHERE TURNOID='+INTTOSTR(IDT));

aq.ExecSQL;
aq.open;
while not aq.eof do
begin



TAG:=TAG+'<item xsi:type="ns1:turnosAusentes">  '+
            '   <turnoID xsi:type="xsd:unsignedLong">'+TRIM(AQ.FIELDBYNAME('turnoid').ASSTRING)+'</turnoID>   '+
            '   <dominio xsi:type="xsd:string">'+TRIM(AQ.FIELDBYNAME('dvdomino').ASSTRING)+'</dominio> '+
            '</item>';



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

 Form1.Memo2.Clear;
 Form1.Memo2.Lines.LoadFromStream(request);
 Form1.Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'Enviadoinformarausentes.xml');

recieveID :=HTTPRIO.HTTPWebNode.Send(request);
         //Request

HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response

Form1.Memo2.Clear;
response.Position := 0;
Form1.Memo2.Lines.LoadFromStream(response);

Form1.Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'informarausentes.xml');
strings.Free;
request.Free;
response.Free

END;

informar_ausentes_TURNO_INDVI:=true;
except
  informar_ausentes_TURNO_INDVI:=falsE;
end;



 end;


Function txml_caba.informar_ausentes_TURNO_INDVI_faltante(IDT:LONGINT;TABLA:sTRING):boolean;
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


fechaturno:=datetostr(date);

aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
aq.sql.add('SELECT  fechaturno FROM '+TRIM(TABLA)+
                     ' WHERE TURNOID='+INTTOSTR(IDT));


aq.ExecSQL;
aq.open;
fecha:=trim(AQ.FIELDS[0].asstring);
fecha1:=trim(AQ.FIELDS[0].asstring);
 fechaturno:=trim(AQ.FIELDS[0].asstring);

aq.close;
AQ.FREE;

fecha:=copy(trim(fecha),7,4)+'-'+copy(trim(fecha),4,2)+'-'+copy(trim(fecha),1,2);

fecharchivo:=copy(trim(fecha1),7,4)+copy(trim(fecha1),4,2)+copy(trim(fecha1),1,2);

xml:='<?xml version="1.0" encoding="UTF-8"?> '+
'<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:ns1="urn:suvtv" '+
' xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '+
' SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">  '+
   '<SOAP-ENV:Body>' +
    '  <ns1:informarAusentes>  '+
  '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(ver_ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_PLANTA)+'</plantaID>'+
    '     <fecha xsi:type="xsd:date">'+trim(fecha)+'</fecha>   ';








aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
aq.sql.add('SELECT  COUNT(*) FROM '+TRIM(TABLA)+
                     ' WHERE TURNOID='+INTTOSTR(IDT));


aq.ExecSQL;
aq.open;
CANTIDAD:=AQ.FIELDS[0].ASINTEGER;

 XML:=XML +    '     <turnos SOAP-ENC:arrayType="ns1:turnosAusentes['+TRIM(AQ.FIELDS[0].ASSTRING)+']" xsi:type="ns1:turnosAusentesLista"> ';

AQ.CLOSE;
AQ.FREE;

IF CANTIDAD > 0 THEN
BEGIN
aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
{aq.sql.add('SELECT  TURNOID, DVDOMINO FROM tdatosturno   '+
                     ' WHERE  ausente=''S'' ');  }


aq.sql.add('SELECT  TURNOID, DVDOMINO FROM '+TRIM(TABLA)+
                     ' WHERE TURNOID='+INTTOSTR(IDT));

aq.ExecSQL;
aq.open;
while not aq.eof do
begin



TAG:=TAG+'<item xsi:type="ns1:turnosAusentes">  '+
            '   <turnoID xsi:type="xsd:unsignedLong">'+TRIM(AQ.FIELDBYNAME('turnoid').ASSTRING)+'</turnoID>   '+
            '   <dominio xsi:type="xsd:string">'+TRIM(AQ.FIELDBYNAME('dvdomino').ASSTRING)+'</dominio> '+
            '</item>';



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

 Form1.Memo2.Clear;
 Form1.Memo2.Lines.LoadFromStream(request);
 Form1.Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'Enviadoinformarausentes.xml');

recieveID :=HTTPRIO.HTTPWebNode.Send(request);
         //Request

HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response

Form1.Memo2.Clear;
response.Position := 0;
Form1.Memo2.Lines.LoadFromStream(response);

Form1.Memo2.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +'informarausentes.xml');
strings.Free;
request.Free;
response.Free

END;

informar_ausentes_TURNO_INDVI_faltante:=true;
except
  informar_ausentes_TURNO_INDVI_faltante:=falsE;
end;



 end;



FUNCTION txml_caba.informar_factura_ws(pagoidverificacion,
                      NRO_COMPROBANTE,
                      tipo_cbte,
                      idetalle,
                      imp_total,
                      IMP_NETO,
                      IVA21,
                      cae,
                      fecha_vence,
                      tipofactura,
                      fechafactura,
                      b64,m5:string):BOOLEAN;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
   xml,FECHADESDE,FECHAHASTA,FDesde,fHasta:string;
   MyText: TStringlist;
    fecha : string;
  Tfecha1 : TDateTime;
  Tfecha2 : TDateTime;


   mdate, mdate1:tdatetime;
   hora:integer;
   FECHADIR,PATH_XML,DIR:string;
begin
try

xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:solicitarPagos soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(ver_ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_PLANTA)+'</plantaID>'+
         '</urn:solicitarPagos>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';






strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');

MyText:= TStringlist.create;
MyText.LoadFromStream(request);
MyText.SaveToFile(DIR  +'\envio_factura'+ver_ingresoID_Abrir+'.xml');
MyText.Free;




recieveID :=HTTPRIO.HTTPWebNode.Send(request);           //Request

HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response


response.Position := 0;


MyText:= TStringlist.create;
MyText.LoadFromStream(response);
//MyText.SaveToFile(DIR  +'\CONSULTA_PAGOS_'+ver_ingresoID_Abrir+'.xml');
//MyText.SaveToFile(ExtractFilePath(Application.ExeName)    +'archivo_xml.xml');
MyText.Free;


//ARCHIVOS_XML_PAGOS:=DIR  +'\CONSULTA_PAGOS_'+ver_ingresoID_Abrir+'.xml';

strings.Free;
request.Free;
response.Free;

//Leer_archivo_pagos_encabezado(DIR  +'\CONSULTA_PAGOS_'+ver_ingresoID_Abrir+'.xml');





EXCEPT
   on E : Exception do
   BEGIN

    TRAZAS('ERROR EN FUNCION INFORMAR FACTURA. '+E.ClassName+'. error : '+E.Message+' . archivo: '+ARCHIVOS_XML_PAGOS);
   END;

END;


END;





FUNCTION txml_caba.DESCARGAR_PAGOS_POR_NOVEDAD(TIPO:STRING):BOOLEAN;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
   xml,FECHADESDE,FECHAHASTA,FDesde,fHasta:string;
   MyText: TStringlist;
    fecha : string;
  Tfecha1 : TDateTime;
  Tfecha2 : TDateTime;


   mdate, mdate1:tdatetime;
   hora:integer;
   FECHADIR,PATH_XML,DIR:string;
begin
try
 PATH_XML:=ExtractFilePath(Application.ExeName)+'XMLPAGOS';
//CREA DIRECTORIO//
FECHADIR:=TRIM(COPY(DATETOSTR(DATE),1,2))+TRIM(COPY(DATETOSTR(DATE),4,2))+TRIM(COPY(DATETOSTR(DATE),7,4));
DIR:=PATH_XML;

If not DirectoryExists(DIR) then
CreateDir(DIR) ;


DIR:=PATH_XML+'\'+FECHADIR;

If not DirectoryExists(DIR) then
CreateDir(DIR) ;



 IF (TIMETOSTR(TIME) > '01:00:00')  AND (TIMETOSTR(TIME) < '01:45:00') THEN
     hora:=3
     ELSE
     hora:=2;


 mdate:=now;

 mdate1:=inchour(mdate,-abs(hora));


 FECHADESDE:=datetimetostr(mdate1);
 FECHAHASTA:=datetimetostr(mdate);

 FECHADESDE:=ARMA_FECHA1(FECHADESDE);
 FECHAHASTA:=ARMA_FECHA1(FECHAHASTA);

 //FECHADESDE:='2017-02-15 09:00:01';
 //FECHAHASTA:='2017-02-15 17:15:59';


{fecha := datetostr(date) + ' ' +timetostr(time);

Tfecha2 := strtodatetime(fecha);
Tfecha1:= IncHour(Tfecha2, -3);

FECHADESDE:=ARMA_FECHA(datetimetostr(Tfecha1));
FECHAHASTA:=ARMA_FECHA(datetimetostr(Tfecha2)); }
{FECHADESDE:=ARMA_FECHA(DATE)+' '+timetostr(inchour(time,-3));
FECHAHASTA:=ARMA_FECHA(date)+' '+timetostr(time); }

xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:solicitarPagos soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(ver_ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_PLANTA)+'</plantaID>'+
         '<tipoPago xsi:type="urn:tipoBoleta">'+TRIM(TIPO)+'</tipoPago>'+
         '<tipoConsulta xsi:type="urn:tipoConsultaTurno">N</tipoConsulta>'+
         '<fechaDesde xsi:type="xsd:date">'+TRIM(FECHADESDE)+'</fechaDesde>'+
         '<fechaHasta xsi:type="xsd:date">'+TRIM(FECHAHASTA)+'</fechaHasta>'+
      '</urn:solicitarPagos>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';






strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');

MyText:= TStringlist.create;
MyText.LoadFromStream(request);
MyText.SaveToFile(DIR  +'\ENVIADACONSULTA_PAGOS_'+ver_ingresoID_Abrir+'.xml');
MyText.Free;




recieveID :=HTTPRIO.HTTPWebNode.Send(request);           //Request

HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response


response.Position := 0;
                       

MyText:= TStringlist.create;
MyText.LoadFromStream(response);
MyText.SaveToFile(DIR  +'\CONSULTA_PAGOS_'+ver_ingresoID_Abrir+'.xml');
MyText.SaveToFile(ExtractFilePath(Application.ExeName)    +'archivo_xml.xml');
MyText.Free;


ARCHIVOS_XML_PAGOS:=DIR  +'\CONSULTA_PAGOS_'+ver_ingresoID_Abrir+'.xml';

strings.Free;
request.Free;
response.Free;

Leer_archivo_pagos_encabezado(DIR  +'\CONSULTA_PAGOS_'+ver_ingresoID_Abrir+'.xml');




EXCEPT
   on E : Exception do
   BEGIN
      TRAZAS('ERROR EN FUNCION DESCARGAR_PAGOS_POR_NOVEDAD. '+E.ClassName+'. error : '+E.Message+' . archivo: '+ARCHIVOS_XML_PAGOS);
   END;

END;


END;




FUNCTION txml_caba.DESCARGAR_PAGOS_POR_NOVEDAD_rango_fecha(TIPO:STRING):BOOLEAN;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
   xml,FECHADESDE,FECHAHASTA,FDesde,fHasta:string;
   MyText: TStringlist;
    fecha : string;
  Tfecha1 : TDateTime;
  Tfecha2 : TDateTime;


   mdate, mdate1:tdatetime;
   hora:integer;
   FECHADIR,PATH_XML,DIR:string;
begin
try
 PATH_XML:=ExtractFilePath(Application.ExeName)+'XMLPAGOS';
//CREA DIRECTORIO//
FECHADIR:=TRIM(COPY(DATETOSTR(DATE),1,2))+TRIM(COPY(DATETOSTR(DATE),4,2))+TRIM(COPY(DATETOSTR(DATE),7,4));
DIR:=PATH_XML;

If not DirectoryExists(DIR) then
CreateDir(DIR) ;


DIR:=PATH_XML+'\'+FECHADIR;

If not DirectoryExists(DIR) then
CreateDir(DIR) ;



 IF (TIMETOSTR(TIME) > '01:00:00')  AND (TIMETOSTR(TIME) < '01:45:00') THEN
     hora:=3
     ELSE
     hora:=2;


 mdate:=now;

 mdate1:=inchour(mdate,-abs(hora));


 FECHADESDE:=datetimetostr(mdate1);
 FECHAHASTA:=datetimetostr(mdate);

 FECHADESDE:=ARMA_FECHA1(FECHADESDE);
 FECHAHASTA:=ARMA_FECHA1(FECHAHASTA);

 //FECHADESDE:='2017-02-15 09:00:01';
 //FECHAHASTA:='2017-02-15 17:15:59';


{fecha := datetostr(date) + ' ' +timetostr(time);

Tfecha2 := strtodatetime(fecha);
Tfecha1:= IncHour(Tfecha2, -3);

FECHADESDE:=ARMA_FECHA(datetimetostr(Tfecha1));
FECHAHASTA:=ARMA_FECHA(datetimetostr(Tfecha2)); }
{FECHADESDE:=ARMA_FECHA(DATE)+' '+timetostr(inchour(time,-3));
FECHAHASTA:=ARMA_FECHA(date)+' '+timetostr(time); }

xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:solicitarPagos soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(ver_ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_PLANTA)+'</plantaID>'+
         '<tipoPago xsi:type="urn:tipoBoleta">'+TRIM(TIPO)+'</tipoPago>'+
         '<tipoConsulta xsi:type="urn:tipoConsultaTurno">N</tipoConsulta>'+
         '<fechaDesde xsi:type="xsd:date">'+TRIM(FECHADESDE)+'</fechaDesde>'+
         '<fechaHasta xsi:type="xsd:date">'+TRIM(FECHAHASTA)+'</fechaHasta>'+
      '</urn:solicitarPagos>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';






strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');

MyText:= TStringlist.create;
MyText.LoadFromStream(request);
MyText.SaveToFile(DIR  +'\ENVIADACONSULTA_PAGOS_'+ver_ingresoID_Abrir+'.xml');
MyText.Free;




recieveID :=HTTPRIO.HTTPWebNode.Send(request);           //Request

HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response


response.Position := 0;
                       

MyText:= TStringlist.create;
MyText.LoadFromStream(response);
MyText.SaveToFile(DIR  +'\CONSULTA_PAGOS_'+ver_ingresoID_Abrir+'.xml');
MyText.SaveToFile(ExtractFilePath(Application.ExeName)    +'archivo_xml.xml');
MyText.Free;


ARCHIVOS_XML_PAGOS:=DIR  +'\CONSULTA_PAGOS_'+ver_ingresoID_Abrir+'.xml';

strings.Free;
request.Free;
response.Free;

Leer_archivo_pagos_encabezado(DIR  +'\CONSULTA_PAGOS_'+ver_ingresoID_Abrir+'.xml');




EXCEPT
   on E : Exception do
   BEGIN
      TRAZAS('ERROR EN FUNCION DESCARGAR_PAGOS_POR_NOVEDAD. '+E.ClassName+'. error : '+E.Message+' . archivo: '+ARCHIVOS_XML_PAGOS);
   END;

END;


END;



FUNCTION txml_caba.DESCARGAR_PAGOS_POR_NOVEDAD_fecha(TIPO,desde,hasta:STRING):BOOLEAN;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
   xml,FECHADESDE,FECHAHASTA,FDesde,fHasta:string;
   MyText: TStringlist;
    fecha : string;
  Tfecha1 : TDateTime;
  Tfecha2 : TDateTime;


   mdate, mdate1:tdatetime;
   hora:integer;
   FECHADIR,PATH_XML,DIR:string;
begin
try
 PATH_XML:=ExtractFilePath(Application.ExeName)+'XMLPAGOS';
//CREA DIRECTORIO//
FECHADIR:=TRIM(COPY(DATETOSTR(DATE),1,2))+TRIM(COPY(DATETOSTR(DATE),4,2))+TRIM(COPY(DATETOSTR(DATE),7,4));
DIR:=PATH_XML;

If not DirectoryExists(DIR) then
CreateDir(DIR) ;


DIR:=PATH_XML+'\'+FECHADIR;

If not DirectoryExists(DIR) then
CreateDir(DIR) ;







 FECHADESDE:=trim(desde);
 FECHAHASTA:=trim(hasta);


{fecha := datetostr(date) + ' ' +timetostr(time);

Tfecha2 := strtodatetime(fecha);
Tfecha1:= IncHour(Tfecha2, -3);

FECHADESDE:=ARMA_FECHA(datetimetostr(Tfecha1));
FECHAHASTA:=ARMA_FECHA(datetimetostr(Tfecha2)); }
{FECHADESDE:=ARMA_FECHA(DATE)+' '+timetostr(inchour(time,-3));
FECHAHASTA:=ARMA_FECHA(date)+' '+timetostr(time); }

xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:solicitarPagos soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(ver_ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_PLANTA)+'</plantaID>'+
         '<tipoPago xsi:type="urn:tipoBoleta">'+TRIM(TIPO)+'</tipoPago>'+
         '<tipoConsulta xsi:type="urn:tipoConsultaTurno">N</tipoConsulta>'+
         '<fechaDesde xsi:type="xsd:date">'+TRIM(FECHADESDE)+'</fechaDesde>'+
         '<fechaHasta xsi:type="xsd:date">'+TRIM(FECHAHASTA)+'</fechaHasta>'+
      '</urn:solicitarPagos>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';






strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');

MyText:= TStringlist.create;
MyText.LoadFromStream(request);
MyText.SaveToFile(DIR  +'\ENVIADACONSULTA_PAGOS_'+ver_ingresoID_Abrir+'.xml');
MyText.Free;




recieveID :=HTTPRIO.HTTPWebNode.Send(request);           //Request

HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response


response.Position := 0;
                       

MyText:= TStringlist.create;
MyText.LoadFromStream(response);
MyText.SaveToFile(DIR  +'\CONSULTA_PAGOS_'+ver_ingresoID_Abrir+'.xml');
MyText.SaveToFile(ExtractFilePath(Application.ExeName)    +'archivo_xml.xml');
MyText.Free;


ARCHIVOS_XML_PAGOS:=DIR  +'\CONSULTA_PAGOS_'+ver_ingresoID_Abrir+'.xml';

strings.Free;
request.Free;
response.Free;

Leer_archivo_pagos_encabezado(DIR  +'\CONSULTA_PAGOS_'+ver_ingresoID_Abrir+'.xml');





EXCEPT
   on E : Exception do
   BEGIN

    TRAZAS('ERROR EN FUNCION DESCARGAR_PAGOS_POR_NOVEDAD. '+E.ClassName+'. error : '+E.Message+' . archivo: '+ARCHIVOS_XML_PAGOS);
   END;

END;


END;



FUNCTION txml_caba.DESCARGAR_FERIADO(ANIO:STRING):BOOLEAN;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
   xml,FECHADESDE,FECHAHASTA,FDesde,fHasta:string;
   MyText: TStringlist;
    fecha : string;
  Tfecha1 : TDateTime;
  Tfecha2 : TDateTime;


   mdate, mdate1:tdatetime;
   hora:integer;
   FECHADIR,PATH_XML,DIR:string;
begin
try
 PATH_XML:=ExtractFilePath(Application.ExeName);

DIR:=PATH_XML;




xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:consultarFeriados soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(ver_ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_PLANTA)+'</plantaID>'+
         '<periodo xsi:type="urn:tipoBoleta">'+TRIM(ANIO)+'</periodo>'+
      '</urn:consultarFeriados>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';






strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');

MyText:= TStringlist.create;
MyText.LoadFromStream(request);
MyText.SaveToFile(DIR  +'ENVIA_CONSULTA_FERIADO_'+ver_ingresoID_Abrir+'.xml');

MyText.Free;




recieveID :=HTTPRIO.HTTPWebNode.Send(request);           //Request

HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response


response.Position := 0;
                       

MyText:= TStringlist.create;
MyText.LoadFromStream(response);
MyText.SaveToFile(DIR  +'CONSULTA_FERIADO'+ver_ingresoID_Abrir+'.xml');
MyText.SaveToFile(ExtractFilePath(Application.ExeName)    +'archivo_xml.xml');
MyText.Free;



strings.Free;
request.Free;
response.Free;

ASSIGNFILE(ARCHIVOPROCESO,ExtractFilePath(Application.ExeName)+'parseado.txt');
rewrite(ARCHIVOPROCESO);
closefile(ARCHIVOPROCESO);

{ejecuta aplicacion xml.exe desarrollada en visual basic para pasear
el xml en forma de cabecera / detalle item}
if EjecutarYEsperar( ExtractFilePath( Application.ExeName ) + 'xml.exe', SW_SHOWNORMAL ) = 0 then

{agrega al archivo parseado al final la linea **FIN**}
append(ARCHIVOPROCESO);
WRITELN(ARCHIVOPROCESO,'**FIN**');
CLOSEFILE(ARCHIVOPROCESO);


Leer_archivo_pagos_encabezado(DIR  +'CONSULTA_FERIADO'+ver_ingresoID_Abrir+'.xml');


 LEER_TAGS_FERIADO(ExtractFilePath(Application.ExeName)+'parseado.txt');


EXCEPT
   on E : Exception do
   BEGIN

    TRAZAS('ERROR EN FUNCION FERIADOS. '+E.ClassName+'. error : '+E.Message+' . archivo: '+ARCHIVOS_XML_PAGOS);
   END;

END;


END;



function txml_caba.INFORMAR_FACTURA_a_suvtv(externalReference,
numeroFactura,
tipoComprobante,
Dominio,
importeTotal,
importeNeto,
importeIVA,
cae,
vencimientoCae,
tipoFactura,
fechaFactura,
comprobantehash,smd5 :string):boolean;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
   xml,FECHADESDE,FECHAHASTA,FDesde,fHasta:string;
   MyText: TStringlist;
    fecha : string;
  Tfecha1 : TDateTime;
  Tfecha2 : TDateTime;

    posi:longint;
   mdate, mdate1:tdatetime;
   hora:integer;
   FECHADIR,PATH_XML,DIR,nombre_Archivo_enviado,repuesta_Archivo_enviado:string;
begin
 try
 PATH_XML:=ExtractFilePath(Application.ExeName);

DIR:=PATH_XML;

 CONFIGURAR;


ControlServidor;

if (ver_disponibilidad_servidor='true') AND (ver_respuestaidservidor=1) THEN
begin

//ver_respuestamensajeservidor);
APPLICATION.ProcessMessages;

Abrir_Seccion;
if self.ver_respuestaid_Abrir=1 then
begin

 posi:=pos('-',numeroFactura);
 numeroFactura:= inttostr(strtoint(trim(copy(numeroFactura,posi+1,length(numeroFactura)))));

 vencimientoCae:=copy(vencimientoCae,1,4)+'-'+copy(vencimientoCae,5,2)+'-'+copy(vencimientoCae,7,2);

 fechaFactura:=copy(fechaFactura,7,4)+'-'+copy(fechaFactura,4,2)+'-'+copy(fechaFactura,1,2);

 nombre_Archivo_enviado:=externalReference+'_'+tipoFactura+'_'+numeroFactura+'.xml';
 repuesta_Archivo_enviado:='R_'+externalReference+'_'+tipoFactura+'_'+numeroFactura+'.xml';

  xml:='<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:ns1="urn:suvtv" xmlns:xsd="http://www.w3.org/2001/XMLSchema" '+
'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">';
 xml:=xml+  '<SOAP-ENV:Body>'+
      '<ns1:informarFacturas>'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(ver_ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_PLANTA)+'</plantaID>'+
         '<facturas SOAP-ENC:arrayType="ns1:facturas[1]" xsi:type="ns1:facturasListado">'+
            '<item xsi:type="ns1:facturas">'+
               '<externalReference xsi:type="xsd:unsignedLong">'+trim(externalReference)+'</externalReference>'+
               '<numeroFactura xsi:type="xsd:unsignedLong">'+trim(numeroFactura)+'</numeroFactura>'+
               '<tipoComprobante xsi:type="ns1:tipoComprobante">'+trim(tipoComprobante)+'</tipoComprobante>'+
               '<importeTotal xsi:type="xsd:float">'+trim(importeTotal)+'</importeTotal>'+
               '<importeNeto xsi:type="xsd:float">'+trim(importeNeto)+'</importeNeto>'+
               '<importeIVA xsi:type="xsd:float">'+trim(importeIVA)+'</importeIVA>'+
               '<cae xsi:type="xsd:unsignedLong">'+trim(cae)+'</cae>'+
               '<vencimientoCae xsi:type="xsd:date">'+trim(vencimientoCae)+'</vencimientoCae>'+
               '<tipoFactura xsi:type="ns1:tipoFactura">'+trim(tipoFactura)+'</tipoFactura>'+
               '<fechaFactura xsi:type="xsd:date">'+trim(fechaFactura)+'</fechaFactura>'+
               '<factura xsi:type="ns1:comprobante">'+
                   '<comprobante xsi:type="xsd:string">'+trim(comprobantehash)+'</comprobante>'+
                  '<comprobanteHash xsi:type="xsd:token">'+trim(smd5)+'</comprobanteHash>'+
                  '</factura>'+
            '</item>'+
        '</facturas>'+
      '</ns1:informarFacturas>'+
   '</SOAP-ENV:Body>'+
'</SOAP-ENV:Envelope>';

strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');

MyText:= TStringlist.create;

MyText.LoadFromStream(request);
MyText.SaveToFile(DIR  +nombre_Archivo_enviado);

MyText.Free;




recieveID :=HTTPRIO.HTTPWebNode.Send(request);           //Request

HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response


response.Position := 0;


MyText:= TStringlist.create;
MyText.LoadFromStream(response);
MyText.SaveToFile(DIR  +repuesta_Archivo_enviado);
MyText.SaveToFile(ExtractFilePath(Application.ExeName)    +'archivo_xml.xml');
MyText.Free;




strings.Free;
request.Free;
response.Free;


ASSIGNFILE(ARCHIVOPROCESO,ExtractFilePath(Application.ExeName)+'parseado.txt');
rewrite(ARCHIVOPROCESO);
closefile(ARCHIVOPROCESO);

{ejecuta aplicacion xml.exe desarrollada en visual basic para pasear
el xml en forma de cabecera / detalle item}
if EjecutarYEsperar( ExtractFilePath( Application.ExeName ) + 'xml.exe', SW_SHOWNORMAL ) = 0 then

{agrega al archivo parseado al final la linea **FIN**}
append(ARCHIVOPROCESO);
WRITELN(ARCHIVOPROCESO,'**FIN**');
CLOSEFILE(ARCHIVOPROCESO);


Leer_archivo_informar_facturas_encabezado(ExtractFilePath(Application.ExeName)+'parseado.txt');





INFORMAR_FACTURA_a_suvtv:=true;
 end;

 end;
EXCEPT
   on E : Exception do
   BEGIN
    INFORMAR_FACTURA_a_suvtv:=false;
    TRAZAS('ERROR EN FUNCION informar facturas. '+E.ClassName+'. error : '+E.Message+' . archivo: '+ARCHIVOS_XML_PAGOS);
   END;

END;








end;





 function txml_caba.EjecutarYEsperar( sPrograma: String; Visibilidad: Integer ): Integer;
var
  sAplicacion: array[0..512] of char;
  DirectorioActual: array[0..255] of char;
  DirectorioTrabajo: String;
  InformacionInicial: TStartupInfo;
  InformacionProceso: TProcessInformation;
  iResultado, iCodigoSalida: DWord;
begin
  StrPCopy( sAplicacion, sPrograma );
  GetDir( 0, DirectorioTrabajo );
  StrPCopy( DirectorioActual, DirectorioTrabajo );
  FillChar( InformacionInicial, Sizeof( InformacionInicial ), #0 );
  InformacionInicial.cb := Sizeof( InformacionInicial );

  InformacionInicial.dwFlags := STARTF_USESHOWWINDOW;
  InformacionInicial.wShowWindow := Visibilidad;
  CreateProcess( nil, sAplicacion, nil, nil, False,
                 CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS,
                 nil, nil, InformacionInicial, InformacionProceso );

  // Espera hasta que termina la ejecuci�n
  repeat
    iCodigoSalida := WaitForSingleObject( InformacionProceso.hProcess, 1000 );
    Application.ProcessMessages;
  until ( iCodigoSalida <> WAIT_TIMEOUT );

  GetExitCodeProcess( InformacionProceso.hProcess, iResultado );
  MessageBeep( 0 );
  CloseHandle( InformacionProceso.hProcess );
  Result := iResultado;
end;



FUNCTION txml_caba.DESCARGAR_PAGOS_POR_CODIGO_PAGO(externalReference,codigopago:longint):BOOLEAN;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
   xml,FECHADESDE,FECHAHASTA,FDesde,fHasta:string;
   MyText: TStringlist;
    fecha : string;
  Tfecha1 : TDateTime;
  Tfecha2 : TDateTime;


   mdate, mdate1:tdatetime;
   hora:integer;
begin
try

 IF (TIMETOSTR(TIME) > '01:00:00')  AND (TIMETOSTR(TIME) < '01:45:00') THEN
     hora:=3
     ELSE
     hora:=2;


 mdate:=now;

 mdate1:=inchour(mdate,-abs(hora));


 FECHADESDE:=datetimetostr(mdate1);
 FECHAHASTA:=datetimetostr(mdate);

 FECHADESDE:=ARMA_FECHA1(FECHADESDE);
 FECHAHASTA:=ARMA_FECHA1(FECHAHASTA);


{fecha := datetostr(date) + ' ' +timetostr(time);

Tfecha2 := strtodatetime(fecha);
Tfecha1:= IncHour(Tfecha2, -3);

FECHADESDE:=ARMA_FECHA(datetimetostr(Tfecha1));
FECHAHASTA:=ARMA_FECHA(datetimetostr(Tfecha2)); }
{FECHADESDE:=ARMA_FECHA(DATE)+' '+timetostr(inchour(time,-3));
FECHAHASTA:=ARMA_FECHA(date)+' '+timetostr(time); }

xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:solicitarPago soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(ver_ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_PLANTA)+'</plantaID>'+
         '<externalReference xsi:type="xsd:unsignedLong">'+inttostr(externalReference)+'</externalReference>'+
         '<codigoPago xsi:nil="true"/> '+
      '</urn:solicitarPago>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';



   // '<codigoPago xsi:type="xsd:unsignedLong">'+inttostr(codigopago)+'</codigoPago>'+


strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');

MyText:= TStringlist.create;
MyText.LoadFromStream(request);
MyText.SaveToFile(ExtractFilePath(Application.ExeName)  +'ENVIADACONSULTA_PAGOS'+ver_ingresoID_Abrir+'.xml');

MyText.Free;




recieveID :=HTTPRIO.HTTPWebNode.Send(request);           //Request

HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response


response.Position := 0;


MyText:= TStringlist.create;
MyText.LoadFromStream(response);
MyText.SaveToFile(ExtractFilePath(Application.ExeName)   +'CONSULTA_PAGOS'+ver_ingresoID_Abrir+'.xml');
MyText.SaveToFile(ExtractFilePath(Application.ExeName)  +'archivo_xml.xml');
MyText.Free;




strings.Free;
request.Free;
response.Free;

 if fileexists(ExtractFilePath(Application.ExeName)   +'CONSULTA_PAGOS'+ver_ingresoID_Abrir+'.xml')=true then
 Leer_archivo_pagos_encabezado(ExtractFilePath(Application.ExeName)   +'CONSULTA_PAGOS'+ver_ingresoID_Abrir+'.xml');

 

//  POR_NOVEDAD:=ExtractFilePath(Application.ExeName) +'CONSULTA'+ver_ingresoID_Abrir+'.xml';
except

 // POR_NOVEDAD:='0';
end;


END;



FUNCTION txml_caba.POR_FECHA_TURNO(DESDE, HASTA:STRING;IDSE:LONGINT):STRING;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
   xml,FECHADESDE,FECHAHASTA:string;
   MyText:TStringlist;

   FFFFFF:STRING;
begin
try

//FECHADESDE:=ARMA_FECHA(DESDE)+' 00:00:00';
//FECHAHASTA:=ARMA_FECHA(HASTA)+' 23:59:59';


FECHADESDE:=trim(DESDE);
FECHAHASTA:=trim(HASTA) ;


xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:solicitarTurnos soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_USUARIO)+'</usuarioID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(ver_ingresoID_Abrir)+'</ingresoID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_PLANTA)+'</plantaID>'+
         '<tipoConsulta xsi:type="urn:tipoConsultaTurno">T</tipoConsulta>'+
         '<fechaDesde xsi:type="xsd:date">'+TRIM(FECHADESDE)+'</fechaDesde>'+
         '<fechaHasta xsi:type="xsd:date">'+TRIM(FECHAHASTA)+'</fechaHasta>'+
      '</urn:solicitarTurnos>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';



FFFFFF:=TRIM(COPY(DATETOSTR(DATE),1,2))+TRIM(COPY(DATETOSTR(DATE),4,2))+TRIM(COPY(DATETOSTR(DATE),7,4));


strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');

MyText:= TStringlist.create;
MyText.LoadFromStream(request);
MyText.SaveToFile(ExtractFilePath(Application.ExeName)   +'ENVIADACONSULTA'+ver_ingresoID_Abrir+'.xml');
MyText.Free;



recieveID :=HTTPRIO.HTTPWebNode.Send(request);           //Request

HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response


response.Position := 0;

MyText:= TStringlist.create;
MyText.LoadFromStream(response);
MyText.SaveToFile(ExtractFilePath(Application.ExeName)   +'CONSULTA'+ver_ingresoID_Abrir+'.xml');
MyText.SaveToFile(ExtractFilePath(Application.ExeName)   +'CONSULTA_COMPLETA_DIA_'+INTTOSTR(IDSE)+'_'+ver_ingresoID_Abrir+'.xml');
MyText.Free;


strings.Free;
request.Free;
response.Free;


POR_FECHA_TURNO:=ExtractFilePath(Application.ExeName) +'CONSULTA'+ver_ingresoID_Abrir+'.xml';
except

  POR_FECHA_TURNO:='0';
end;


END;

function txml_caba.configura_http:boolean;
var
    TESTING:boolean;

  defWSDL:string;
  defURL :string;
  defSvc:string;
  defPrt,xml:string;
begin
TRY
IF ver_TESTING_CONEX=TRUE THEN  //suvtvBinding
 BEGIN
  defWSDL:= 'http://testing.suvtv.com.ar/service/s_001.php?wsdl';
  defURL := 'http://testing.suvtv.com.ar/service/s_001.php';
  defSvc:= 'suvtv';
  defPrt:= 'suvtvPort';
  MODO_TURNO:='T';
 END ELSE BEGIN
  defWSDL:= 'https://www.suvtv.com.ar/service/s_001.php?wsdl';
  defURL := 'https://www.suvtv.com.ar/service/s_001.php';
  defSvc:= 'suvtv';
  defPrt:= 'suvtvPort';
  MODO_TURNO:='P';
  end;

  HTTPRIO.WSDLLocation:=defWSDL;
  HTTPRIO.Service:=defSvc;
  HTTPRIO.Port:=defPrt;
  HTTPRIO.URL:=defURL;
  HTTPRIO.HTTPWebNode.SoapAction := defURL;

 EXCEPT
 on E : Exception do
   BEGIN

    TRAZAS('ERROR AL CONFIGURAR EL PROTOCOLO HTTP. '+E.ClassName+'. error : '+E.Message);
   END;

END;

end;

Procedure txml_caba.LeerArchivoEco;
var
  ANode,ANode1,ANode2: IXMLNode;
  I,j,jj: integer;
  CadenaLibro,
  CadenaSalida,x: string;

begin
try

XMLDocument.FileName:=ExtractFilePath(Application.ExeName) +'ECO.xml';
XMLDocument.Active:=true;
  for I := 0 to XMLDocument.DocumentElement.ChildNodes.Count - 1 do begin
    ANode := XMLDocument.DocumentElement.ChildNodes[I];
    x:=anode.NodeName;

      for j := 0 to anode.ChildNodes.Count - 1 do begin
        ANode1 := anode.ChildNodes[j];
        x:=anode1.NodeName;
        for jj := 0 to anode1.ChildNodes.Count - 1 do begin
        ANode2 := anode1.ChildNodes[jj];
        x:=anode2.NodeName;

           if ANode2.NodeType = ntElement then
           begin
             // if ver_TESTING_CONEX=false then
              //   begin
                   respuestaidservidor :=strtoint(trim(ANode2.ChildNodes['respuestaID'].Text)) ;
                   respuestamensajeservidor :=trim(ANode2.ChildNodes['respuestaMensaje'].Text) ;
                   disponibilidad_servidor:=trim(ANode2.ChildNodes['disponible'].Text) ;
                { end else
                 begin
                   respuestaidservidor :=strtoint(trim(ANode2.ChildNodes['rspID'].Text)) ;
                   respuestamensajeservidor :=trim(ANode2.ChildNodes['rspDescrip'].Text) ;
                    if trim(ANode2.ChildNodes['sugDisponible'].Text)='1' then
                       disponibilidad_servidor:='true'
                       else
                       disponibilidad_servidor:='false';
                 end; }
             end;

    end;
    end;

  end;

EXCEPT
   on E : Exception do
   BEGIN
     respuestaidservidor :=-500;
     respuestamensajeservidor :='SERVIDOR FUERA DE SERVICIO '+datetostr(date)+' '+timetostr(time) ;
     disponibilidad_servidor:='false' ;;
    TRAZAS('ERROR EN FUNCION LeerArchivoEco (LEER AUTORIZACION DEL SERVIDOR). '+E.ClassName+'. error : '+E.Message);
   END;

END;





end;

FUNCTION txml_caba.CONFIGURAR:BOOLEAN;
BEGIN
 XMLDocument:=TXMLDocument.Create(APPLICATION);
 CargarINI;

  HTTPRIO:=THTTPRIO.Create(application);
  configura_http;
END;


function  txml_caba.procesar_xml_a_pata(archivo:string):boolean;
begin
Inicializa(archivo) ;

end;

function txml_caba.CONSULTA(TIPO,DATO1,DATO2:STRING;IDSE:LONGINT):BOOLEAN;
VAR arhivo_xml:STRING;
BEGIN
{XMLDocument:=TXMLDocument.Create(APPLICATION);
CargarINI;

  HTTPRIO:=THTTPRIO.Create(application);
  configura_http;  }

 // ControlServidor;

if ver_respuestaidservidor=1 then
begin
 // Abrir_Seccion;

    IF trim(TIPO)='20' THEN
   BEGIN
    arhivo_xml:=POR_NOVEDAD_20(DATO1, DATO2);
    //Inicializa_vb(arhivo_xml) ;
    if trim(arhivo_xml)<>'*' then
    Inicializa(arhivo_xml) ;
   END;


  IF trim(TIPO)='N' THEN
   BEGIN
    arhivo_xml:=POR_NOVEDAD(DATO1, DATO2);
    //Inicializa_vb(arhivo_xml) ;
    if trim(arhivo_xml)<>'*' then
    Inicializa(arhivo_xml) ;
   END;

    IF trim(TIPO)='18' THEN
   BEGIN
    arhivo_xml:=POR_NOVEDAD_1830(DATO1, DATO2);
    //Inicializa_vb(arhivo_xml) ;
    if trim(arhivo_xml)<>'*' then
    Inicializa(arhivo_xml) ;
   END;


   IF trim(TIPO)='ID' THEN
   BEGIN
   arhivo_xml:=POR_TURNOID(DATO1, DATO2);
   Inicializa(arhivo_xml) ;
   END;

   IF trim(TIPO)='FT' THEN
   BEGIN
     arhivo_xml:=POR_FECHA_TURNO(DATO1, DATO2,IDSE);
     Inicializa(arhivo_xml) ;
   END;

    IF trim(TIPO)='IDCL' THEN
   BEGIN
   arhivo_xml:=POR_TURNOID_CLIENTE_CERO(DATO1, DATO2);
   Inicializa_IDCL(arhivo_xml) ;
   END;





 
end;

END;

Procedure txml_caba.Inicializa(arhivo_xml:string) ;
var
     I: Integer;
    XmlNode: IXMLNode;
   NodeText: string;
   AttrNode: IXMLNode;
  begin



 try

  XMLDocument.LoadFromFile(arhivo_xml);
except
   on E:Exception do
      showmessage(E.classname+'.  Error: '+E.Message);

end;
  Procesa_archivo_xml;
end;

Procedure txml_caba.Inicializa_vb(arhivo_xml:string) ;
var
     I: Integer;
    XmlNode: IXMLNode;
   NodeText: string;
   AttrNode: IXMLNode;
  begin





  XMLDocument.LoadFromFile(arhivo_xml);

  Procesa_archivo_xml_vb;
end;


Procedure txml_caba.Inicializa_PAGOS(arhivo_xml:string) ;
var
I: Integer;
XmlNode: IXMLNode;
nodeText: string;
AttrNode: IXMLNode;
begin
  {carga xml en el componente para realizar parseo}
  XMLDocument.LoadFromFile(arhivo_xml);

  {parsea el xml para su lectura}
  Procesa_archivo_xml_PAGOS(arhivo_xml);;
end;



Procedure txml_caba.Inicializa_IDCL(arhivo_xml:string) ;
var
     I: Integer;
    XmlNode: IXMLNode;
   NodeText: string;
   AttrNode: IXMLNode;
  begin





  XMLDocument.LoadFromFile(arhivo_xml);

  Procesa_archivo_xml_IDCL;
end;



Function txml_caba.Cerrar_seccion:boolean;
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
    MyText:TStringlist;
begin
xml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:suvtv">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<urn:cerrarSesion soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<usuarioID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_USUARIO)+'</usuarioID>'+
         '<plantaID xsi:type="xsd:unsignedLong">'+INTTOSTR(ver_PLANTA)+'</plantaID>'+
         '<ingresoID xsi:type="xsd:unsignedLong">'+TRIM(ver_ingresoID_Abrir)+'</ingresoID>'+
      '</urn:cerrarSesion>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';





strings := TStringList.Create;
strings.Text := xml;

request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');



recieveID :=HTTPRIO.HTTPWebNode.Send(request);           //Request

HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response


response.Position := 0;

  MyText:= TStringlist.create;
  MyText.LoadFromStream(response);
  MyText.SaveToFile(ExtractFilePath(Application.ExeName) +'CERRAR.xml');
  MyText.Free;

strings.Free;
request.Free;
response.Free;
HTTPRIO.Free;
 end;

function txml_caba.Procesa_archivo_xml:boolean;
begin
ASSIGNFILE(ARCHIVOPROCESO,ExtractFilePath(Application.ExeName)+'archivoparseado.txt');
REWRITE(ARCHIVOPROCESO);
DomToTree (XMLDocument.DocumentElement);

if pone_999=false then
 WRITELN(ARCHIVOPROCESO,'****999****');

WRITELN(ARCHIVOPROCESO,'**FIN**');
CLOSEFILE(ARCHIVOPROCESO);

LEER_TAGS_ARCHIVO(FALSE);

end;


function txml_caba.Procesa_archivo_xml_vb:boolean;
begin
ASSIGNFILE(ARCHIVOPROCESO,ExtractFilePath(Application.ExeName)+'parseado.txt');
rewrite(ARCHIVOPROCESO);
closefile(ARCHIVOPROCESO);

{ejecuta aplicacion xml.exe desarrollada en visual basic para pasear
el xml en forma de cabecera / detalle item}
if EjecutarYEsperar( ExtractFilePath( Application.ExeName ) + 'xml.exe', SW_SHOWNORMAL ) = 0 then

{agrega al archivo parseado al final la linea **FIN**}
append(ARCHIVOPROCESO);
WRITELN(ARCHIVOPROCESO,'**FIN**');
CLOSEFILE(ARCHIVOPROCESO);

LEER_TAGS_ARCHIVO_TURNOS_VB(ExtractFilePath(Application.ExeName)+'parseado.txt') ;

end;

function txml_caba.Procesa_archivo_xml_PAGOS(ARCHIVO:STRING):boolean;
VAR ARCHIVOPROCESO1:TEXTFILE;
begin
TRY
{crea archivo de parseo temporal}
ASSIGNFILE(ARCHIVOPROCESO1,ExtractFilePath(Application.ExeName)+'parseado.txt');
rewrite(ARCHIVOPROCESO1);
closefile(ARCHIVOPROCESO1);

{ejecuta aplicacion xml.exe desarrollada en visual basic para pasear
el xml en forma de cabecera / detalle item}
if EjecutarYEsperar( ExtractFilePath( Application.ExeName ) + 'xml.exe', SW_SHOWNORMAL ) = 0 then

{agrega al archivo parseado al final la linea **FIN**}
append(ARCHIVOPROCESO1);
WRITELN(ARCHIVOPROCESO1,'**FIN**');
CLOSEFILE(ARCHIVOPROCESO1);

 
{LEE ARCHIVO TAG PAESEADO Y GUARDA EN BD}
IF CONTROL_ARCHIVO_PAGOS=TRUE THEN
LEER_TAGS_ARCHIVO_XML_PAGOS_ver2(ExtractFilePath(Application.ExeName)+'parseado.txt',ARCHIVO);

EXCEPT
   on E : Exception do
   BEGIN
    respuestaidpago:=-661;
    TRAZAS('ERROR EN FUNCION Procesa_archivo_xml_PAGOS. '+E.ClassName+'. error : '+E.Message+'.  archivo: '+ARCHIVO);
   END;

END;

end;


function txml_caba.CONTROL_ARCHIVO_PAGOS:boolean;
VAR ARCHIVOPROCESOCONT:TEXTFILE;
LINEA:STRING;
begin
CONTROL_ARCHIVO_PAGOS:=FALSE;
ASSIGNFILE(ARCHIVOPROCESOCONT,ExtractFilePath(Application.ExeName)+'parseado.txt');
RESET(ARCHIVOPROCESOCONT);
WHILE NOT EOF(ARCHIVOPROCESOCONT)DO
BEGIN
    READLN(ARCHIVOPROCESOCONT,LINEA) ;

     IF TRIM(LINEA)='DETALLESPAGO' THEN
     BEGIN
         CONTROL_ARCHIVO_PAGOS:=TRUE;
        BREAK;
     END;


END;


CLOSEFILE(ARCHIVOPROCESOCONT);





end;


function txml_caba.Procesa_archivo_xml_IDCL:boolean;
begin
ASSIGNFILE(ARCHIVOPROCESO,ExtractFilePath(Application.ExeName)+'archivoparseado.txt');
REWRITE(ARCHIVOPROCESO);
DomToTree (XMLDocument.DocumentElement);



WRITELN(ARCHIVOPROCESO,'**FIN**');
CLOSEFILE(ARCHIVOPROCESO);

LEER_TAGS_ARCHIVO(TRUE);



end;


procedure txml_caba.DomToTree (XmlNode: IXMLNode);
var
   I: Integer;  es_relacionado:boolean;
   turnorelacionado:boolean;
   NodeText,corte,r: string;
   AttrNode: IXMLNode; entro:boolean;

begin
  entro:=false;
  pone_999:=false;


  if XmlNode.NodeType <> ntElement then
  begin
    Exit;
   end;

   NodeText := XmlNode.NodeName;
   corte:=XmlNode.ParentNode.NodeName+'_'+NodeText;


   if trim(corte)='datosTurno_turnosRelacionados' then
   begin
      relacion:='s';
   end;


  if XmlNode.IsTextElement then
    NodeText :=XmlNode.ParentNode.NodeName+'_'+NodeText + ' = ' + XmlNode.NodeValue
    else
    NodeText :=XmlNode.ParentNode.NodeName+'_'+NodeText ;



  WRITELN(ARCHIVOPROCESO,NodeText);


  if (trim(corte)='detallesPagoOblea_estadoAcreditacion') then
  begin
  entro:=true;
      if  trim(relacion)='s' then
         begin
           relacion:='n';

           WRITELN(ARCHIVOPROCESO,'****000****');
            r:='';
         end
           else
              begin
                r:='';
                relacion:='n';
                pone_999:=true;
                WRITELN(ARCHIVOPROCESO,'****999****');
             end;
  end;

  // add attributes
 { for I := 0 to xmlNode.AttributeNodes.Count - 1 do
  begin
    AttrNode := xmlNode.AttributeNodes.Nodes[I];

     memo1.Lines.Add(AttrNode.NodeName + ' = ' + AttrNode.Text);
  end; }
  // add each child node
  if XmlNode.HasChildNodes then
    for I := 0 to xmlNode.ChildNodes.Count - 1 do
      DomToTree (xmlNode.ChildNodes.Nodes [I]);



end;





procedure txml_caba.DomToTree_XML_PAGOS(XmlNode: IXMLNode);
var
   I: Integer;  es_relacionado:boolean;
   turnorelacionado:boolean;
   NodeText,corte,r: string;
   AttrNode: IXMLNode;

begin




  if XmlNode.NodeType <> ntElement then
  begin
    Exit;
   end;

   NodeText := XmlNode.NodeName;
   corte:=XmlNode.ParentNode.NodeName+'_'+NodeText;




  if XmlNode.IsTextElement then
    NodeText :=XmlNode.ParentNode.NodeName+'_'+NodeText + ' = ' + XmlNode.NodeValue
    else
    NodeText :=XmlNode.ParentNode.NodeName+'_'+NodeText ;



  WRITELN(ARCHIVOPROCESO,NodeText);




 if XmlNode.HasChildNodes then
    for I := 0 to xmlNode.ChildNodes.Count - 1 do
     DomToTree_XML_PAGOS(xmlNode.ChildNodes.Nodes[I]);  


end;



procedure txml_caba.TestOfBD(Alias, UserName, Password: String; Ageva: boolean);
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
            then// mensaje:='No se encontraron los par�metros de conexi�n a la base de datos. Verifique el registro de windows.'
           BEGIN
             Application.MessageBox( 'No se encontraron los par�metros de conexi�n a la base de datos. Verifique el registro de windows.',
                      'Acceso denegado', MB_ICONSTOP ) ;
           FORM1.CONEXION_OK:=FALSe;
           END
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

                          FORM1.memo1.Lines.Add('No se encontr� en el registro alg�n par�metro necesario para la conexi�n a la base de datos');
                       APPLICATION.ProcessMessages;
                       FORM1.CONEXION_OK:=FALSe;
                    //mensaje:='No se encontr� en el registro alg�n par�metro necesario para la conexi�n a la base de datos';
                    exit;
                end;


                MyBD := TSQLConnection.Create(nil);
                with MyBD do
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
                    MyBD.Open;
                    mybd.SQLConnection.SetOption(coEnableBCD, Integer(False));
                     FORM1.CONEXION_OK:=TRUE;
                      FORM1.memo1.Lines.Add('CONEXION  A LA BASE: OK');

                except

                    on E: Exception do
                      BEGIN
                        FORM1.CONEXION_OK:=FALSe;
                       FORM1.memo1.Lines.Add('No se pudo conectar con la base de datos por: ' + E.message);
                       END;

                end;




            end
        finally
            Free;
        end;

    end;





function txml_caba.Control_conexion_TestOfBD(Alias, UserName, Password: String; Ageva: boolean):boolean;
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
            then// mensaje:='No se encontraron los par�metros de conexi�n a la base de datos. Verifique el registro de windows.'
            Application.MessageBox( 'No se encontraron los par�metros de conexi�n a la base de datos. Verifique el registro de windows.',
                      'Acceso denegado', MB_ICONSTOP )
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

                          FORM1.memo1.Lines.Add('No se encontr� en el registro alg�n par�metro necesario para la conexi�n a la base de datos');
                       APPLICATION.ProcessMessages;

                    //mensaje:='No se encontr� en el registro alg�n par�metro necesario para la conexi�n a la base de datos';
                    exit;
                end;


                MyBD_test := TSQLConnection.Create(nil);
                with MyBD_test do
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

                    MyBD_test.Open;
                    MyBD_test.SQLConnection.SetOption(coEnableBCD, Integer(False));
                    MyBD_test.Close;
                    MyBD_test.Free;
                    Control_conexion_TestOfBD:=true;
                except
                    on E: Exception do
                     begin
                         MyBD_test.Close;
                         MyBD_test.Free;
                        Control_conexion_TestOfBD:=false;

                      end;
                end;




            end
        finally
            Free;
        end;

    end;






Function txml_caba.Devuelve_codclien(adocument,
    anombre ,
    aapellido ,
    adomicilio ,anumerocalle,
    adepartamento,
    alocalidad ,
    aprovincia  ,
    acodigopostal ,genero,tipodocu,tipofact,tipoiva:string):longint;


 var aq,aexiste:tsqlquery;
 existe:boolean;
 codciente,codigod:longint;
x1:longint;
           x2:longint;
           s1,cadena,existeCLIENTE:string;
           s2:string;
           S3,tipodocuint:string;
           S4:string;
           S5,TIPODOCU1:string;
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
 tipodocuint:=tipodocu;

 if trim(anombre)='' then
 anombre:='-';

 if (trim(tipodocu)='0') AND (TRIM(GENERO)='PJ') then
     TIPODOCU1:='P.JCA.'
     ELSE
     BEGIN
      if trim(tipodocu)='0' then
        TIPODOCU1:='P.JCA.';
     END;



  if trim(tipodocu)='1' then
     TIPODOCU1:='DNI';


  if trim(tipodocu)='2' then
     TIPODOCU1:='LE';

  if trim(tipodocu)='3' then
     TIPODOCU1:='LC';


  if trim(tipodocu)='4' then
     TIPODOCU1:='DNI.EX.';


  if trim(tipodocu)='5' then
     TIPODOCU1:='CED.EX.';

  if trim(tipodocu)='6' then
     TIPODOCU1:='PASAP.';

  if trim(tipodocu)='7' then
     TIPODOCU1:='NO CONSTA';

  if trim(tipodocu)='8' then
     TIPODOCU1:='CED';

  if trim(tipodocu)='9' then
     TIPODOCU1:='CUIT';


  if trim(tipodocu)='10' then
     TIPODOCU1:='CERT.NAC.';

  if trim(tipodocu)='11' then
     TIPODOCU1:='CERT.';


  if trim(tipodocu)='12' then
     TIPODOCU1:='CED.CIU.';

  if trim(tipodocu)='13' then
     TIPODOCU1:='EXPEDIENTE';


  
 try
   
 with TSQLStoredProc.Create(application) do
    try
      SQLConnection :=MyBD;
      StoredProcName :='Pq_DatosRecep.ExisteCliente';  //ara clase a y b
      ParamByName('NRODOCUMENTO').Value :=adocument;
      ParamByName('ATIPODOCU').Value :=TIPODOCU1;

      ExecProc;



      existeCLIENTE:=ParamByName('existe').ASSTRING;
      if trim(existeCLIENTE)='S' then
      codigo := ParamByName('codigo').AsInteger
      else
      codigo:=0;




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


if trim(existeCLIENTE)='N' then
BEGIN

 try



 with TSQLStoredProc.Create(application) do
    try
     IF TRIM(acodigopostal)='' THEN
        acodigopostal:='1000';

      SQLConnection :=MyBD;
      StoredProcName :='Pq_DatosRecep.fcliente';  //ara clase a y b
      ParamByName('adocument').Value :=adocument;
      ParamByName('anombre').Value :=anombre;
      ParamByName('aapellido').Value := aapellido;
      ParamByName('adomicilio').Value :=adomicilio;
      ParamByName('anrocalle').Value :=anumerocalle;
      ParamByName('adepartamento').Value := adepartamento;
      ParamByName('alocalidad').Value := alocalidad;
      ParamByName('aprovincia').Value := aprovincia;
      ParamByName('acodigopostal').Value := acodigopostal;
      ParamByName('agenero').Value := genero;
      ParamByName('atipodoc').Value := tipodocu;
      ParamByName('atipfactu').Value := tipofact;
      ParamByName('atiptribu').Value := tipoiva;


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
END;

  Devuelve_codclien:=codigo;






 end;


Function txml_caba.Devuelve_codclienV2(adocument, anombre ,
    aapellido ,
    adomicilio ,anumerocalle,
    adepartamento,
    alocalidad ,
    aprovincia  ,
    acodigopostal ,genero,tipodocu,tipofact,tipoiva:string):longint;


 var aq,aexiste:tsqlquery;
 existe:boolean;
 codciente,codigod:longint;
x1:longint;
           x2:longint;
           s1,cadena:string;
           s2:string;
           S3,tipodocuint:string;
           S4:string;
           S5,existeCLIENTE:string;
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

 tipodocuint:=tipodocu;

 if (trim(tipodocu)='0') AND (TRIM(GENERO)='PJ') then
     TIPODOCU:='P.JCA.'
     ELSE
     BEGIN
      if trim(tipodocu)='0' then
        TIPODOCU:='P.JCA.';
     END;



  if trim(tipodocu)='1' then
     TIPODOCU:='DNI';


  if trim(tipodocu)='2' then
     TIPODOCU:='LE';

  if trim(tipodocu)='3' then
     TIPODOCU:='LC';


  if trim(tipodocu)='4' then
     TIPODOCU:='DNI.EX.';


  if trim(tipodocu)='5' then
     TIPODOCU:='CED.EX.';

  if trim(tipodocu)='6' then
     TIPODOCU:='PASAP.';

  if trim(tipodocu)='7' then
     TIPODOCU:='NO CONSTA';

  if trim(tipodocu)='8' then
     TIPODOCU:='CED';

  if trim(tipodocu)='9' then
     TIPODOCU:='CUIT';


  if trim(tipodocu)='10' then
     TIPODOCU:='CERT.NAC.';

  if trim(tipodocu)='11' then
     TIPODOCU:='CERT.';


  if trim(tipodocu)='12' then
     TIPODOCU:='CED.CIU.';

  if trim(tipodocu)='13' then
     TIPODOCU:='EXPEDIENTE';


  {  aexiste:=tsqlquery.create(nil);
   aexiste.SQLConnection := MyBD;
   aexiste.sql.add('select  codclien from tclientes  '+
   ' where trim(DOCUMENT)='+#39+trim(adocument)+#39+' or REPLACE(TRIM (CUIT_CLI), ''-'', '''')='+#39+trim(adocument)+#39+
   ' and TIPODOCU='+#39+trim(TIPODOCU)+#39);
   aexiste.ExecSQL;
   aexiste.open;
   WHILE NOT AEXISTE.Eof DO
   BEGIN


      codigod:=aexiste.fieldbyname('codclien').AsInteger;
      existeCLIENTE:='S';
      aexiste.Next;
   END;

    aexiste.Close;
    aexiste.Free;    }

 try
   
 with TSQLStoredProc.Create(application) do
    try
      SQLConnection :=MyBD;
      StoredProcName :='Pq_DatosRecep.ExisteCliente';  //ara clase a y b
      ParamByName('NRODOCUMENTO').Value :=adocument;
      ParamByName('ATIPODOCU').Value :=TIPODOCU;

      ExecProc;



      existeCLIENTE:=ParamByName('existe').ASSTRING;
      if trim(existeCLIENTE)='S' then
      codigod := ParamByName('codigo').AsInteger
      else
      codigod:=0;




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

 // if trim(existeCLIENTE) IN ['N','S'] then
  //BEGIN
 try

     IF TRIM(tipofact)='FACA' THEN
        tipofact:='A';

     IF TRIM(tipofact)='FACB' THEN
        tipofact:='B';

if trim(existeCLIENTE)='N' then
BEGIN
 with TSQLStoredProc.Create(application) do
    try
      SQLConnection :=MyBD;
      StoredProcName :='Pq_DatosRecep.fclienteV2';  //ara clase a y b
      ParamByName('adocument').Value :=adocument;
      ParamByName('anombre').Value :=anombre;
      ParamByName('aapellido').Value := aapellido;
      ParamByName('adomicilio').Value :=adomicilio;
      ParamByName('anrocalle').Value :=anumerocalle;
      ParamByName('adepartamento').Value := adepartamento;
      ParamByName('alocalidad').Value := alocalidad;
      ParamByName('aprovincia').Value := aprovincia;
      ParamByName('acodigopostal').Value := acodigopostal;
      ParamByName('agenero').Value := genero;
      ParamByName('atipodoc').Value := tipodocuint;
      ParamByName('atipfactu').Value := tipofact;
      ParamByName('atiptribu').Value := tipoiva;
      ParamByName('ExisteCliente').Value := trim(existeCLIENTE);
      ParamByName('codigoIN').AsInteger:=codigod;

      ExecProc;


      codigod := ParamByName('codigoOUT').AsInteger;



           // result:= aQ.Fields[0].asinteger;
        finally

           Close;
           Free;
        end;
END;

    except
        on E: Exception do
        begin

            raise
        end;
    end;
//END;


  Devuelve_codclienv2:=codigod;




 end;



  Function txml_caba.Devuelve_codvehiculo(apatente,
                        anummotor_carroc ,
                        atipovehic,
                        amarca ,
                        amodelo: string;
                        aaniofabr :longint):longint;

 var aq,aexiste:tsqlquery;
 codigo:longint;
 EXISTE_VEHICULO:STRING;
 begin
  EXISTE_VEHICULO:='N';
  aexiste:=tsqlquery.create(nil);
   aexiste.SQLConnection := MyBD;
   aexiste.sql.add('SELECT CODVEHIC FROM TVEHICULOS WHERE PATENTEN='+#39+TRIM(apatente)+#39);
   aexiste.ExecSQL;
   aexiste.open;
   WHILE NOT AEXISTE.Eof DO
   BEGIN
       codigo:=aexiste.FIELDBYNAME('CODVEHIC').AsInteger;
       EXISTE_VEHICULO:='S';
       AEXISTE.NEXT;
   END;


  aexiste.Close;
  aexiste.Free;

IF TRIM(EXISTE_VEHICULO)='N' THEN
BEGIN
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

END;

  Devuelve_codvehiculo:=codigo;



 end;


  Function txml_caba.Devuelve_codvehiculo_v2(apatente,
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
      StoredProcName :='Pq_DatosRecep.fvehiculoV2';  //ara clase a y b
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

  Devuelve_codvehiculo_v2:=codigo;



 end;


Procedure txml_caba.Guarda_turno_en_basedatos;
var aq,AQELI,aqDETALLESPAGO:tsqlquery;         exite_novedad_guardada,existe_detalles_pago:boolean;
sSql, sestado,FECHATURNO,FECHALTA,sconcesionario,INFORMADOWS,CP,LOCALI,PROVIN:string;
 flagj,domicilio_factura,CODIGOPOSTAL,DIA,MES,ANNIO,numeromotor,vtipo,vmodelo,vmarca:string;
 codvehic:longint;  existe:boolean;  IDESTADOTURNO:LONGINT;
 codcliente,codclientetitular,idturnoexiste,IDTURNOBUSCAR:longint;
 cargado:longint;  aaa:longint;
 AUSENTE,FACTURADO,REVISO,NRODOC,GEN,nombrecliente,nro_doc_contacto,NOMBRE_CONTACTO:STRING;
  TD: TTransactionDesc;     SE_INSERTA:BOOLEAN;
  FECHA,tipofact,TIPOINSPE,nombrecliente_TITULAR,nombrecliente_FACT,x,apellido_fact:STRING;
   pagoID_RELACION:LONGINT;
   plantaID_RELACION,idpagoturno:LONGINT;
begin

   if trim(SELF.ver_turnoID)='' then
        exit;

   idturnoexiste:=-1;
  FECHA:=TRIM(DATETOSTR(DATE));
  IF TRIM(SELF.ver_re_item_turnoID)<>'' THEN
  TURNOID_RELACION:=STRTOINT(SELF.ver_re_item_turnoID)
  ELSE
  TURNOID_RELACION:=0;

  Form1.Memo1.Lines.Add('Procesando turno: '+SELF.ver_turnoID+' Dominio: '+SELF.ver_datosVehiculo_dominio);
  application.ProcessMessages;

   aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;

  IDTURNOBUSCAR:=STRTOINT(SELF.ver_turnoID);


    aq.sql.add('SELECT  TURNOID, FACTURADO, pagoidverificacion FROM tdatosturno   '+
                      ' WHERE '+
                      ' TURNOID = '+INTTOSTR(IDTURNOBUSCAR)+ ' and modo=''P'' ' );
                    //  '  AND DVDOMINO = '+#39+trim(SELF.ver_datosVehiculo_dominio)+#39+' and modo=''P'' ' );// and fechaturno=to_date('+#39+trim(FECHA)+#39+',''dd/mm/yyyy'')');




   aq.ExecSQL;
   aq.open;
       if aq.IsEmpty = true then
       BEGIN

       FACTURADO:='N';
       existe:=false;

                IF SELF.VER_TURNOID_RELACION <> 0 THEN      //TURNO RELACIONADO
                   BEGIN
                       AQ.SQL.CLEAR;
                       aq.sql.add('SELECT  TURNOID, FACTURADO,pagoidverificacion FROM tdatosturno   '+
                                  ' WHERE '+
                                   ' TURNOID = '+INTTOSTR(SELF.VER_TURNOID_RELACION)+ ' and modo=''P'' ' );
                                //  ' AND  DVDOMINO = '+#39+trim(SELF.ver_datosVehiculo_dominio)+#39+' and modo=''P'' ' );// and fechaturno=to_date('+#39+trim(FECHA)+#39+',''dd/mm/yyyy'')');
                        aq.ExecSQL;
                        aq.open;
                        if  aq.IsEmpty = true then
                           existe:=false
                           ELSE
                           BEGIN
                                idpagoturno:=aq.FIELDBYNAME('pagoidverificacion').ASINTEGER;
                               FACTURADO:=TRIM(aq.FIELDBYNAME('FACTURADO').ASSTRING);
                               idturnoexiste:=aq.FIELDBYNAME('TURNOID').ASINTEGER;

                                IF TRIM(FACTURADO)='S' THEN
                                   FACTURADO:='O';

                           END;


             END;

       END ELSE BEGIN

         if not aq.IsEmpty  then     //recorcound > 0
          BEGIN
        //  idpagoturno:=aq.FIELDBYNAME('pagoidverificacion').ASINTEGER;
          aq.CLOSE;
          aq.FREE;





             aq:=tsqlquery.create(nil);
               aq.SQLConnection := MyBD ;
             aq.sql.add('SELECT  TURNOID, FACTURADO,pagoidverificacion FROM tdatosturno   '+
                      ' WHERE '+
                      ' TURNOID = '+INTTOSTR(IDTURNOBUSCAR)+ ' and modo=''P'' ' );
                     // '  AND DVDOMINO = '+#39+trim(SELF.ver_datosVehiculo_dominio)+#39+' and modo=''P'' ' );// and fechaturno=to_date('+#39+trim(FECHA)+#39+',''dd/mm/yyyy'')');

            aq.ExecSQL;
            aq.OPEN ;
             
           if not aq.IsEmpty  then
              BEGIN



            existe:=true;
            if trim(aq.FIELDBYNAME('pagoidverificacion').ASstring)<>'' then
              idpagoturno:=aq.FIELDBYNAME('pagoidverificacion').ASINTEGER;


            FACTURADO:=TRIM(aq.FIELDBYNAME('FACTURADO').ASSTRING);
            idturnoexiste:=aq.FIELDBYNAME('TURNOID').ASINTEGER;
             END;


           END;


       END;

      if existe=false then
      begin

        if trim(self.ver_detallesPagoVerificacion_pagoID)<>'' then
           idpagoturno:=strtoint(self.ver_detallesPagoVerificacion_pagoID)
           else
           idpagoturno:=(strtoint(SELF.ver_turnoID)*-1);

       end;
    //********************************************************************************


    IF SELF.ver_PLANTA<>STRTOINT(SELF.ver_plantaID) THEN
        EXIT;


      AQ.CLOSE;
      AQ.FREE;



      existe:=false;
       aq:=tsqlquery.create(nil);
       aq.SQLConnection := MyBD ;
       aq.sql.add('SELECT  TURNOID, FACTURADO,pagoidverificacion FROM tdatosturno   '+
                      ' WHERE '+
                      ' TURNOID = '+INTTOSTR(IDTURNOBUSCAR) );
                     // '  AND DVDOMINO = '+#39+trim(SELF.ver_datosVehiculo_dominio)+#39+' and modo=''P'' ' );// and fechaturno=to_date('+#39+trim(FECHA)+#39+',''dd/mm/yyyy'')');

       aq.ExecSQL;
       aq.OPEN ;

       if not aq.IsEmpty   then
       BEGIN
        existe:=true;

       end;
       AQ.CLOSE;
      AQ.FREE;

      
           //si el campo planta_id en el pago es distinto al de la planta
        if trim(self.detallesPagoVerificacion_plantaID)<>'' then
        begin
        IF SELF.ver_PLANTA <> strtoint(trim(self.detallesPagoVerificacion_plantaID)) then
              FACTURADO:='O';

       end;





   IF TRIM(FACTURADO)<>'O' THEN
   BEGIN
    {controla que existea el pago}

    if idpagoturno > 0 then
    begin
       existe_detalles_pago:=false;
       aqDETALLESPAGO:=tsqlquery.create(nil);
       aqDETALLESPAGO.SQLConnection := MyBD;
       aqDETALLESPAGO.sql.add('SELECT  * from tdetallespago where pagoid='+inttostr(idpagoturno));
       aqDETALLESPAGO.ExecSQL;
       aqDETALLESPAGO.open;
       if not aqDETALLESPAGO.IsEmpty then
       begin
          existe_detalles_pago:=true;

       end;

        aqDETALLESPAGO.Close;
       aqDETALLESPAGO.Free;

    end else
    begin
      existe_detalles_pago:=true;

    end;


       if existe_detalles_pago=false then
       begin
             DESCARGAR_PAGOS_POR_CODIGO_PAGO(idpagoturno,0);       //183838

            if ver_respuestaidpago=1 then
                begin
                    IF STRTOINT(ver_cantidadPagos) > 0 THEN
                       PROCESARARCHIVOPAGOS(VER_ARCHIVOS_XML_PAGOS);
                end;

       end;

    {--------------------------------}

   END;



    IF TRIM(SELF.VER_ES_REVERIFICACION)='N' THEN
      TIPOINSPE:='P'
      ELSE
      TIPOINSPE:='R';


      sestado:='A';
      sconcesionario:=SELF.ver_plantaID;

       dia:=copy(trim(SELF.ver_fechaTurno),9,2);
       mes:=copy(trim(ver_FECHATURNO),6,2);
       annio:=copy(trim(ver_FECHATURNO),1,4);
       FECHATURNO:=dia+'/'+mes+'/'+annio;


       dia:=copy(trim(SELF.ver_fechaRegistro),9,2);
       mes:=copy(trim(ver_fechaRegistro),6,2);
       annio:=copy(trim(ver_fechaRegistro),1,4);
       FECHALTA:=dia+'/'+mes+'/'+annio;
       flagj:='1';
       codvehic:=0;
       codcliente:=0;

      ///datos factura
       try

          GEN:=TRIM(SELF.ver_datosPersonales_genero);


         IF SELF.ver_datosPersonales_tipoDocumento='9' THEN
         begin
              GEN:='PJ';

            NRODOC:=TRIM(SELF.ver_datosPersonales_numeroCuit);
         end   else
         begin
              NRODOC:=TRIM(SELF.ver_datosPersonales_numeroDocumento);
               GEN:='M';
         end;



            if (trim(SELF.ver_datosPersonales_nombre)<>'') AND (LENGTH(SELF.ver_datosPersonales_nombre) >=2) then
              nombrecliente_FACT:=trim(ver_datosPersonales_nombre)
              else
              nombrecliente_FACT:=trim(self.ver_datosPersonales_razonSocial);


              if (trim(SELF.ver_datosPersonales_apellido)='') OR  (LENGTH(SELF.ver_datosPersonales_apellido) <=2) then
                   datosPersonales_apellido:='.';

         if (trim(SELF.ver_datosFacturacion_condicionIva)='R') then
                tipofact:='A'
                else
                tipofact:='B';



          { IF TRIM(ver_DFCALLE)='' THEN
              DFCALLE:='S/D';

           if trim(ver_DFNUMEROCALLE)='' then
              DFNUMEROCALLE:='0';

           if trim(ver_DFDEPARTAMENTO)
           DFDEPARTAMENTO
           DFLOCALIDAD
           DFPROVINCIA
           DFCODIGOPOSTAL  }


            IF (TRIM(SELF.datosPersonales_genero)='PJ') AND ((TRIM(SELF.datosPersonales_numeroCuit)='') OR (TRIM(datosPersonales_numeroCuit)='0')) THEN
              BEGIN
                 NRODOC:=SELF.datosPersonales_numeroDocumento;
                nombrecliente_FACT:=SELF.ver_datosPersonales_razonSocial;
              END;




        {  if trim(ver_datosTitular_tipoDocumento)='9' then //cuit
          begin
               if ( (trim(self.ver_datosTitular_numeroDocumento)<>'0')
                  or (trim(self.ver_datosTitular_numeroDocumento)<>'')) and (length(self.ver_datosTitular_numeroDocumento)>10)  then
                    NRODOC:=self.ver_datosTitular_numeroDocumento
                    else
                    NRODOC:=trim(self.ver_datosTitular_numeroCuit);



               if (trim(self.ver_datosTitular_nombre)<>'') or (trim(self.ver_datosTitular_nombre)<>'0') then
                     begin
                        nombrecliente_FACT:=trim();

                     end;



          end else begin //dni






          end;    }



 {         0 	P.JCA.
1 	DNI
2 	LE
3 	LC
4 	DNI.EX.
5 	CED.EX.
6 	PASAP.
7 	NO CONSTA
8 	CED

10 	CERT.NAC.
11 	CERT.
12 	CED.CIU.
13 	EXPEDIENTE  }





          if (trim(SELF.ver_datosPersonales_tipoDocumento)='1') or (trim(SELF.ver_datosPersonales_tipoDocumento)='0')
            or (trim(SELF.ver_datosPersonales_tipoDocumento)='2') or (trim(SELF.ver_datosPersonales_tipoDocumento)='3')
            or (trim(SELF.ver_datosPersonales_tipoDocumento)='4') or (trim(SELF.ver_datosPersonales_tipoDocumento)='5')
            or (trim(SELF.ver_datosPersonales_tipoDocumento)='6') or (trim(SELF.ver_datosPersonales_tipoDocumento)='7')
            or (trim(SELF.ver_datosPersonales_tipoDocumento)='8') or (trim(SELF.ver_datosPersonales_tipoDocumento)='10')
            or (trim(SELF.ver_datosPersonales_tipoDocumento)='11') or (trim(SELF.ver_datosPersonales_tipoDocumento)='12')
            or (trim(SELF.ver_datosPersonales_tipoDocumento)='13')
           then
             begin
                 NRODOC:=trim(self.ver_datosPersonales_numeroDocumento);
                 nombrecliente_FACT:=trim(self.ver_datosPersonales_nombre);
                 apellido_fact:=trim(self.ver_datosPersonales_apellido);
             end;


            if trim(SELF.ver_datosPersonales_tipoDocumento)='9' then
             begin
                 NRODOC:=trim(self.ver_datosPersonales_numeroCuit);
                 nombrecliente_FACT:=trim(ver_datosPersonales_razonSocial);
                 apellido_fact:='.';
             end;

      CP:=TRIM(self.ver_domicilio_CODIGOPOSTAL);

      LOCALI:=TRIM(self.ver_domicilio_localidad);
      PROVIN:=TRIM(self.ver_domicilio_provincia);

      if TRIM(LOCALI)='' then
          LOCALI:='C.A.B.A.';

      if TRIM(PROVIN)='' then
          PROVIN:='C.A.B.A.';

    //  LOCALI:='CABA';
     // PROVIN:='CABA';
     IF TRIM(ver_domicilio_calle)='' THEN
       domicilio_calle:='SIN DOMICILIO';

     IF TRIM(ver_domicilio_numero)='' THEN
        domicilio_numero:='0000';

      IF TRIM(ver_domicilio_departamento)='' THEN
              domicilio_departamento:='0';


       codcliente:=Devuelve_codclien(NRODOC,
                                     nombrecliente_FACT ,
                                     apellido_fact ,
                                     ver_domicilio_calle ,
                                     ver_domicilio_numero,
                                     self.ver_domicilio_departamento,
                                     LOCALI,
                                     PROVIN,
                                     CP,GEN,ver_datosPersonales_tipoDocumento,tipofact, ver_datosFacturacion_condicionIva);


       except

       aq:=tsqlquery.create(nil);
       aq.SQLConnection := MyBD;
       AQ.SQL.Clear;
       aq.sql.add('SELECT  CODCLIEN FROM TCLIENTES WHERE  DOCUMENT='+#39+TRIM(NRODOC)+#39+' AND TIPODOCU=''DNI'' ');
       AQ.ExecSQL;
       AQ.Open;
       IF not aq.IsEmpty   THEN
         codcliente:=AQ.FIELDBYNAME('CODCLIEN').ASINTEGER
         ELSE
         BEGIN
            AQ.SQL.Clear;
            aq.sql.add('SELECT  CODCLIEN FROM TCLIENTES  WHERE CUIT_CLI='+#39+TRIM(NRODOC)+#39+' AND TIPODOCU=''CUIT'' ');
            AQ.ExecSQL;
            AQ.Open;
             IF not aq.IsEmpty   THEN
                 codcliente:=AQ.FIELDBYNAME('CODCLIEN').ASINTEGER
                 ELSE
                    BEGIN
                       AQ.SQL.Clear;
                       aq.sql.add('SELECT  CODCLIEN FROM TCLIENTES  WHERE DOCUMENT='+#39+TRIM(NRODOC)+#39+' AND TIPODOCU=''CUIT'' ');
                       AQ.ExecSQL;
                       AQ.Open;
                        IF not aq.IsEmpty   THEN
                          codcliente:=AQ.FIELDBYNAME('CODCLIEN').ASINTEGER

                         ELSE
                           codcliente:=0;


                    END;
         END;






       aq.CLOSE;
       aq.FREE;



       end;


      ///cliente presentante
       try


          GEN:=TRIM(SELF.ver_datosTitular_genero);


         IF SELF.ver_datosTitular_tipoDocumento='9' THEN
            NRODOC:=TRIM(SELF.ver_datosTitular_numeroCuit)
            else
             NRODOC:=TRIM(SELF.ver_datosTitular_numeroDocumento);





          IF TRIM(ver_datosTitular_tipoDocumento)='9' THEN
               BEGIN
                  IF TRIM(SELF.ver_datosTitular_numeroCuit)='' THEN
                      BEGIN
                          NRODOC:=TRIM(SELF.ver_datosTitular_numeroDocumento);
                          SELF.datosTitular_tipoDocumento:='1';

                      END;


               END;



               IF TRIM(NRODOC)='' THEN
                BEGIN
                     IF TRIM(SELF.ver_datosTitular_numeroDocumento)<>'' THEN
                        NRODOC:=ver_datosTitular_numeroDocumento
                        ELSE
                        NRODOC:=SELF.ver_datosTitular_numeroCuit;

                END;



                  if (trim(SELF.ver_datosTitular_nombre)<>'') AND (LENGTH(SELF.ver_datosTitular_nombre) >=2)  then
              nombrecliente_TITULAR:=trim(ver_datosTitular_nombre)
              else
              nombrecliente_TITULAR:=trim(self.VER_datosTitular_razonSocial);


              if (trim(SELF.ver_datosTitular_apellido)='') OR  (LENGTH(SELF.ver_datosTitular_apellido) <=2) then
                    datosTitular_apellido :='.';



          IF (TRIM(ver_datosTitular_genero)='PJ') AND ((TRIM(ver_datosTitular_numeroCuit)='') OR (TRIM(ver_datosTitular_numeroCuit)='0')) THEN
              BEGIN
                 NRODOC:=ver_datosTitular_numeroDocumento;
                nombrecliente_TITULAR:=SELF.ver_datosTitular_razonSocial;
              END;

       codclientetitular:=Devuelve_codclien(NRODOC,
                                     nombrecliente_TITULAR ,
                                     self.ver_datosTitular_apellido ,
                                     ver_domicilio_calle ,
                                     ver_domicilio_numero,
                                     self.ver_domicilio_departamento,
                                     self.ver_domicilio_localidad,
                                     self.ver_domicilio_provincia ,
                                     self.ver_domicilio_CODIGOPOSTAL,GEN,self.ver_datosTitular_tipoDocumento,tipofact,self.ver_datosFacturacion_condicionIva);   //self.ver_DFPROVINCIA
              except


           codclientetitular:=codcliente







       end;

       //---------------------------------------


        AUSENTE:='S';
        //FACTURADO:='N';
        REVISO:='N';


             //si el campo planta_id en el pago es distinto al de la planta
        if trim(self.detallesPagoVerificacion_plantaID)<>'' then
        begin
        IF SELF.ver_PLANTA <> strtoint(trim(self.detallesPagoVerificacion_plantaID)) then
              FACTURADO:='O';

       end;



        if NO_HACE_FACTURA_ELECTRONICA=true then
         begin

            IF SELF.ver_PLANTA = strtoint(trim(self.re_item_plantaID)) then
               FACTURADO:='R'
               else
               FACTURADO:='O';
         end else
         begin
            { IF (FACTURADO='R') AND  (NO_HACE_FACTURA_ELECTRONICA=FALSE) THEN
                  FACTURADO:='N';
             }



             if (FACTURADO='R') and (TIPOINSPE='P') then
               begin
                    aq:=tsqlquery.create(nil);
                    aq.SQLConnection := MyBD;
                    aq.sql.add('SELECT  * from tfacturas where idpago='+INTTOSTR(idpagoturno));
                    aq.ExecSQL;
                    aq.open;
                    if not aq.IsEmpty   then
                     begin
                        FACTURADO:='S';

                     end else begin

                          aq.sql.clear;
                          aq.sql.add('SELECT  codplanta  from tturnorelacionado where turnoid='+INTTOSTR(idturnoexiste));
                          aq.ExecSQL;
                          aq.open;
                           if not aq.IsEmpty   then
                           begin
                                if strtoint(aq.FieldByName('codplanta').AsString)=strtoint(trim(self.detallesPagoVerificacion_plantaID))  then
                                    FACTURADO:='R'
                                    else
                                   facturado:='O';
                          end;

                     end;
                    { while not aq.eof do
                       begin

                        FACTURADO:='S';
                        break;
                        aq.Next;
                      end; }

                   aq.close;
                   aq.Free;






               end;




           IF (FACTURADO='N') AND (trim(SELF.ver_tipoTurno)<>'EX') THEN
              BEGIN
                aq:=tsqlquery.create(nil);
                aq.SQLConnection := MyBD;
                aq.sql.add('SELECT  * from tfacturas where idpago='+INTTOSTR(idpagoturno));
                aq.ExecSQL;
                aq.open;
                 while not aq.eof do
                  begin

                   FACTURADO:='S';
                   break;
                   aq.Next;
                  end;


               aq.Close;
               aq.Free;
            END;
         end;







        try

         if trim(self.ver_datosVehiculo_valChasis)='V' then
            begin
             numeromotor:=self.ver_numeroChasis_numero;
            end else begin

              numeromotor:=self.ver_numeroChasis_numero ;
            end;

            if  trim(ver_datosValidados_marca)<>'' then
                 vmarca:=SELF.ver_datosValidados_marca
                 else
                 Vmarca:=ver_datosVehiculo_marca;


             if  trim(SELF.ver_datosValidados_tipo)<>'' then
                 vtipo:=ver_datosValidados_tipo
                 else
                 vtipo:=SELF.ver_datosVehiculo_tipo;



             if  trim(SELF.ver_datosValidados_modelo)<>'' then
                 vmodelo:=ver_datosValidados_modelo
                 else
                 vmodelo:=SELF.ver_datosVehiculo_modelo;



             codvehic:=Devuelve_codvehiculo(uppercase(self.ver_datosVehiculo_dominio),
                        uppercase(numeromotor),
                        uppercase(vtipo),
                        uppercase(vmarca),
                        uppercase(vmodelo) ,
                        strtoint(SELF.ver_datosVehiculo_anio));


             if trim(ver_datosPersonalesTurno_numeroDocumento)<>'' then
             nro_doc_contacto:=ver_datosPersonalesTurno_numeroDocumento
             else
             nro_doc_contacto:=ver_datosPersonalesTurno_numeroCuit;

             if trim(ver_datosPersonalesTurno_razonSocial)<>'' then
               nombre_contacto:=ver_datosPersonalesTurno_razonSocial
               else
               nombre_contacto:=ver_datosPersonalesTurno_nombre;




        except


         codvehic:=0;

        end;



       if trim(FACTURADO)<>'O' THEN
       BEGIN
          IF TIPOINSPE='R' THEN    //REVERIFICACION
             FACTURADO:='E';



        IF (trim(SELF.ver_tipoTurno)='EX') THEN
            FACTURADO:='N';

       END;


        IDESTADOTURNO:=STRTOINT(SELF.ver_estadoID);
      sSql:='';
     if existe=false then
     begin
        application.ProcessMessages;

        INFORMADOWS:='NO';
        MyBD.StartTransaction(TD);
       TRY
        aq:=tsqlquery.create(nil);
        aq.SQLConnection := MyBD;



       sSql:='INSERT INTO tdatosturno (TURNOID ,'+
                                       'TIPOTURNO ,'+
                                       'FECHATURNO ,'+
                                       'HORATURNO ,'+
                                       'FECHAREGISTRO ,'+
                                       'TITULARGENERO  ,'+
                                       'TTULARTIPODOCUMENTO ,'+
                                       'TITULARNRODOCUMENTO  ,'+
                                       'TITULARNOMBRE  ,'+
                                       'TITULARAPELLIDO ,'+
                                       'CONTACTOGENERO ,'+
                                       'CONTACTOTIPODOCUMENTO ,'+
                                       'CONTACTONRODOCUMENTO  ,'+
                                       'CONTACTONOMBRE  ,'+
                                       'CONTACTOAPELLIDO ,'+
                                       'CONTACTOTELEFONO ,'+
                                       'CONTACTOEMAIL,'+
                                       'CONTACTOFECHANAC ,'+
                                       'DVDOMINO ,'+
                                       'DVMARCAID ,'+
                                       'DVMARCA ,'+
                                       'DVTIPOID ,'+
                                       'DVTIPO ,'+
                                       'DVMODELOID  ,'+
                                       'DVMODELO ,'+
                                       'DVANIO ,'+
                                       'DVJURISDICCIONID ,'+
                                       'DVJURISDICCION ,'+
                                       'DFGENERO ,'+
                                       'DFTIPODOCUMENTO  ,'+
                                       'DFNRODOCUMENTO ,'+
                                       'DFNOMBRE  ,'+
                                       'DFAPELLIDO ,'+
                                       'DFCALLE ,'+
                                       'DFNUMEROCALLE ,'+
                                       'DFPISO ,'+
                                       'DFDEPARTAMENTO  ,'+
                                       'DFLOCALIDAD  ,'+
                                       'DFPROVINCIAID ,'+
                                       'DFPROVINCIA  ,'+
                                       'DFCODIGOPOSTAL  ,'+
                                       'DFIVA ,'+
                                       'DFIIBB ,'+
                                       'PAGOSID  ,'+
                                       'PAGOSGETWAY ,'+
                                       'PAGOSENTIDADID ,'+
                                       'PAGOSENTIDAD ,'+
                                       'PAGOSFECHA  ,'+
                                       'PAGOSIMPORTE ,'+
                                       'PAGOSESTADOLIQUIDACION , '+
                                       'CODVEHIC , '+
                                       'CODCLIEN, '+
                                       'AUSENTE , '+
                                       'FACTURADO, '+
                                       'REVISO,dvNUMERO,IMPORTEVERIFICACION,IMPORTEOBLEA,CODCLIENTEPRESENTANTE, '+
                                       'CUITTITULAR, '+
                                       'CUITCONTACTO,  '+
                                       'CUITFACTURA, '+
                                       'CONTACTORAZONSOCIAL, '+
                                       'TITULARRAZONSOCIAL, '+
                                       'FACTURARAZONSOCIAL, '+
                                       'PAGOIDVERIFICACION, '+
                                       'ESTADOACREDITACIONVERIFICACION ,'+
                                       'PAGOGESTWAYIDVERIFICACION, '+
                                       'PAGOIDOBLEA,'+
                                       'ESTADOACREDITACIONOBLEA,'+
                                       'VALTITULAR, '+
                                       'VALCHASIS,'+
                                       'DATOSVEHICULOMTM,'+
                                       'MARCAIDVAL, '+
                                       'MARCAVAL,'+
                                       'TIPOIDVAL,'+
                                       'TIPOVAL,'+
                                       'MODELOIDVAL,'+
                                        'MODELOVAL,'+
                                       'MARCACHASISVAL, '+
                                      'NUMEROCHASISVAL,'+
                                       'MTMVAL,MODO,fechalta,PLANTA,TIPOINSPE,ESTADOID,ESTADODESC,FECHANOVEDAD) '+
                                       'values ('+INTTOSTR(IDTURNOBUSCAR)+
                                                  ','+#39+trim(SELF.ver_tipoTurno)+#39+
                                                  ',to_date('+#39+trim(fechaTurno)+#39+',''dd/mm/yyyy'')'+
                                                  ','+#39+trim(SELF.ver_horaTurno)+#39+
                                                  ',to_date('+#39+trim(FECHALTA)+#39+',''dd/mm/yyyy'')'+
                                                  ','+#39+trim(SELF.ver_datosTitular_genero)+#39+
                                                  ','+#39+trim(self.ver_datosTitular_tipoDocumento)+#39+
                                                  ','+#39+trim(NRODOC)+#39+
                                                  ','+#39+uppercase(trim(nombrecliente_TITULAR))+#39+
                                                  ','+#39+uppercase(trim(self.ver_datosTitular_apellido))+#39+
                                                  ','+#39+trim(self.ver_datosPersonales_genero)+#39+
                                                  ','+#39+trim(self.ver_datosPersonales_tipoDocumento)+#39+
                                                  ','+#39+trim(nro_doc_contacto)+#39+
                                                  ','+#39+uppercase(trim(nombre_contacto))+#39+
                                                  ','+#39+uppercase(trim(self.ver_datosPersonalesTurno_apellido))+#39+
                                                  ','+#39+trim(self.ver_contactoTurno_telefonoCelular)+#39+
                                                  ','+#39+trim(self.ver_contactoTurno_email)+#39+
                                                  ','+#39+trim(self.ver_contactoTurno_fechaNacimiento)+#39+
                                                  ','+#39+trim(SELF.ver_datosVehiculo_dominio)+#39+
                                                  ','+#39+trim(SELF.ver_datosVehiculo_marcaID)+#39+
                                                  ','+#39+trim(SELF.ver_datosVehiculo_marca)+#39+
                                                  ','+#39+trim(SELF.ver_datosVehiculo_tipoID)+#39+
                                                  ','+#39+trim(SELF.ver_datosVehiculo_tipo)+#39+
                                                  ','+#39+trim(SELF.ver_datosVehiculo_modeloID)+#39+
                                                  ','+#39+trim(SELF.ver_datosVehiculo_modelo)+#39+
                                                  ','+#39+trim(SELF.ver_datosVehiculo_anio)+#39+
                                                  ','+#39+trim(SELF.ver_datosVehiculo_jurisdiccionID)+#39+
                                                  ','+#39+trim(SELF.ver_datosVehiculo_jurisdiccion)+#39+
                                                  ','+#39+trim(SELF.ver_datosPersonales_genero)+#39+
                                                  ','+#39+trim(SELF.ver_datosPersonales_tipoDocumento)+#39+
                                                  ','+#39+trim(SELF.ver_datosPersonales_numeroDocumento)+#39+
                                                  ','+#39+uppercase(trim(SELF.ver_datosPersonales_nombre))+#39+
                                                  ','+#39+uppercase(trim(SELF.ver_datosPersonales_apellido))+#39+
                                                  ','+#39+trim(SELF.ver_domicilio_calle)+#39+
                                                  ','+#39+trim(SELF.ver_domicilio_numero)+#39+
                                                  ','+#39+trim(SELF.ver_domicilio_piso)+#39+
                                                  ','+#39+trim(SELF.ver_domicilio_departamento)+#39+
                                                  ','+#39+trim(SELF.ver_domicilio_localidad)+#39+
                                                  ','+#39+trim(SELF.ver_domicilio_provinciaID)+#39+
                                                  ','+#39+trim(SELF.ver_domicilio_provincia)+#39+
                                                  ','+#39+trim(SELF.ver_domicilio_codigoPostal)+#39+
                                                  ','+#39+trim(SELF.ver_datosFacturacion_condicionIva)+#39+
                                                  ','+#39+trim(SELF.ver_datosFacturacion_numeroIibb)+#39+
                                                  ','+#39+trim(SELF.ver_datosPago_pagoID)+#39+
                                                  ','+#39+trim(SELF.ver_datosPago_gatewayID)+#39+
                                                  ','+#39+trim(SELF.ver_datosPago_entidadID)+#39+
                                                  ','+#39+trim(SELF.ver_datosPago_entidadNombre)+#39+
                                                  ','+#39+trim(SELF.ver_datosPago_fechaPago)+#39+
                                                  ','+#39+trim(SELF.ver_datosPago_importeTotal)+#39+
                                                  ','+#39+trim(SELF.ver_detallesPagoVerificacion_estadoAcreditacion)+#39+
                                                  ','+INTTOSTR(codvehic)+
                                                  ','+INTTOSTR(codcliente)+
                                                  ','+#39+trim(AUSENTE)+#39+
                                                  ','+#39+trim(FACTURADO)+#39+
                                                  ','+#39+trim(REVISO)+#39+
                                                  ','+#39+trim(SELF.ver_numeroChasis_numero)+#39+
                                                  ','+#39+trim(SELF.ver_detallesPagoVerificacion_importe)+#39+
                                                  ','+#39+trim(SELF.ver_detallesPagoOblea_importe)+#39+
                                                  ','+inttostr(codclientetitular)+
                                                  ','+#39+trim(self.ver_datosTitular_numeroCuit)+#39+
                                                  ','+#39+trim(self.ver_datosPersonalesTurno_numeroCuit)+#39+
                                                  ','+#39+trim(ver_datosPersonales_numeroCuit)+#39+
                                                  ','+#39+uppercase(trim(self.ver_datosPersonalesTurno_razonSocial))+#39+
                                                  ','+#39+uppercase(trim(self.VER_datosTitular_razonSocial))+#39+
                                                  ','+#39+uppercase(trim(self.ver_datosPersonales_razonSocial))+#39+
                                                  ','+#39+trim(self.ver_detallesPagoVerificacion_pagoID)+#39+
                                                  ','+#39+trim(self.ver_detallesPagoVerificacion_estadoAcreditacion)+#39+
                                                  ','+#39+trim(self.ver_detallesPagoVerificacion_pagoGatewayID)+#39+
                                                  ','+#39+trim(self.ver_detallesPagoOblea_pagoID)+#39+
                                                  ','+#39+trim(self.ver_detallesPagoOblea_estadoAcreditacion)+#39+
                                                  ','+#39+trim(self.ver_datosVehiculo_valTitular)+#39+
                                                  ','+#39+trim(self.ver_datosVehiculo_valChasis)+#39+
                                                  ','+#39+trim(self.ver_datosVehiculo_mtm)+#39+
                                                  ','+#39+trim(self.ver_datosValidados_marcaID)+#39+
                                                  ','+#39+trim(self.ver_datosValidados_marca)+#39+
                                                  ','+#39+trim(self.ver_datosValidados_tipoID)+#39+
                                                  ','+#39+trim(self.ver_datosValidados_tipo)+#39+
                                                  ','+#39+trim(self.ver_datosValidados_modeloID)+#39+
                                                  ','+#39+trim(self.ver_datosValidados_modelo)+#39+
                                                  ','+#39+trim(self.ver_datosVehiculo_marca)+#39+
                                                  ','+#39+trim(self.ver_numeroChasis_numero)+#39+
                                                  ','+#39+trim(self.ver_datosValidados_mtm)+#39+
                                                  ','+#39+TRIM(VER_MODO_TURNO)+#39+
                                                  ',sysdate,'+#39+TRIM(SELF.ver_plantaID)+#39+','+#39+TRIM(TIPOINSPE)+#39+
                                                  ','+INTTOSTR(IDESTADOTURNO)+','+#39+TRIM(SELF.ver_estado)+#39+',sysdate)';  //TO_DATE('+#39+trim(ver_fechaNovedad)+#39',''dd/mm/yyyy'')


                aq.sql.add(sSql);
               aq.ExecSQL;

                MYBD.Commit(TD);
               EXCEPT

               MyBD.Rollback(TD);
              END;

            AQ.CLOSE;
            AQ.FREE;


       end else
       begin
        exite_novedad_guardada:=false;
        application.ProcessMessages;



         aq:=tsqlquery.create(nil);
         aq.SQLConnection := MyBD;
         aq.sql.add('select * from tdatosturno  '+
                     '  where turnoid='+INTTOSTR(idturnoexiste)+' and fechanovedad=to_date('+#39+trim(self.ver_fechaNovedad)+#39+',''dd/mm/yyyy hh24:mi:ss'')' );// and fechaturno=to_date('+#39+trim(FECHA)+#39+',''dd/mm/yyyy'')');


         aq.ExecSQL;
         aq.open;
         if not aq.IsEmpty   then
            exite_novedad_guardada:=true;

        aq.close;
        aq.free;

        exite_novedad_guardada:=false;

        if exite_novedad_guardada=false then
        begin

         MyBD.StartTransaction(TD);
         TRY
          aq:=tsqlquery.create(nil);
          aq.SQLConnection := MyBD;



         


          sSql:='update tdatosturno   set TURNOID='+INTTOSTR(IDTURNOBUSCAR)+
                                       ',  TIPOTURNO='+#39+trim(SELF.ver_tipoTurno)+#39+
                                       ',  FECHATURNO=to_date('+#39+trim(fechaTurno)+#39+',''dd/mm/yyyy'')'+
                                       ',  HORATURNO='+#39+trim(SELF.ver_horaTurno)+#39+
                                       ',  FECHAREGISTRO=to_date('+#39+trim(FECHALTA)+#39+',''dd/mm/yyyy'')'+
                                       ',  TITULARGENERO='+#39+trim(SELF.ver_datosTitular_genero)+#39+
                                       ',  TTULARTIPODOCUMENTO='+#39+trim(self.ver_datosTitular_tipoDocumento)+#39+
                                       ',  TITULARNRODOCUMENTO='+#39+trim(NRODOC)+#39+
                                       ',  TITULARNOMBRE='+#39+uppercase(trim(nombrecliente_TITULAR))+#39+
                                       ',  TITULARAPELLIDO='+#39+uppercase(trim(self.ver_datosTitular_apellido))+#39+
                                       ',  CONTACTOGENERO='+#39+TRIM(ver_datosPersonales_genero)+#39+
                                       ',  CONTACTOTIPODOCUMENTO='+#39+trim(self.ver_datosPersonales_tipoDocumento)+#39+
                                       ',  CONTACTONRODOCUMENTO='+#39+trim(nro_doc_contacto)+#39+
                                       ',  CONTACTONOMBRE='+#39+uppercase(trim(nombre_contacto))+#39+
                                       ',  CONTACTOAPELLIDO='+#39+uppercase(trim(self.ver_datosPersonalesTurno_apellido))+#39+
                                       ',  CONTACTOTELEFONO='+#39+trim(self.ver_contactoTurno_telefonoCelular)+#39+
                                       ',  CONTACTOEMAIL='+#39+trim(self.ver_contactoTurno_email)+#39+
                                       ',  CONTACTOFECHANAC='+#39+trim(self.ver_contactoTurno_fechaNacimiento)+#39+
                                       ',  DVDOMINO='+#39+trim(SELF.ver_datosVehiculo_dominio)+#39+
                                       ',  DVMARCAID='+#39+trim(SELF.ver_datosVehiculo_marcaID)+#39+
                                       ',  DVMARCA='+#39+trim(SELF.ver_datosVehiculo_marca)+#39+
                                       ',  DVTIPOID='+#39+trim(SELF.ver_datosVehiculo_tipoID)+#39+
                                       ',  DVTIPO='+#39+trim(SELF.ver_datosVehiculo_tipo)+#39+
                                       ',  DVMODELOID='+#39+trim(SELF.ver_datosVehiculo_modeloID)+#39+
                                       ',  DVMODELO='+#39+trim(SELF.ver_datosVehiculo_modelo)+#39+
                                       ',  DVANIO='+#39+trim(SELF.ver_datosVehiculo_anio)+#39+
                                       ',  DVJURISDICCIONID='+#39+trim(SELF.ver_datosVehiculo_jurisdiccionID)+#39+
                                       ',  DVJURISDICCION='+#39+trim(SELF.ver_datosVehiculo_jurisdiccion)+#39+
                                       ',  DFGENERO='+#39+trim(SELF.ver_datosPersonales_genero)+#39+
                                       ',  DFTIPODOCUMENTO='+#39+trim(SELF.ver_datosPersonales_tipoDocumento)+#39+
                                       ',  DFNRODOCUMENTO='+#39+trim(SELF.ver_datosPersonales_numeroDocumento)+#39+
                                       ',  DFNOMBRE='+#39+uppercase(trim(SELF.ver_datosPersonales_nombre))+#39+
                                       ',  DFAPELLIDO='+#39+uppercase(trim(SELF.ver_datosPersonales_apellido))+#39+
                                       ',  DFCALLE='+#39+trim(SELF.ver_domicilio_calle)+#39+
                                       ',  DFNUMEROCALLE='+#39+trim(SELF.ver_domicilio_numero)+#39+
                                       ',  DFPISO='+#39+trim(SELF.ver_domicilio_piso)+#39+
                                       ',  DFDEPARTAMENTO='+#39+trim(SELF.ver_domicilio_departamento)+#39+
                                       ',  DFLOCALIDAD='+#39+trim(SELF.ver_domicilio_localidad)+#39+
                                       ',  DFPROVINCIAID='+#39+trim(SELF.ver_domicilio_provinciaID)+#39+
                                       ',  DFPROVINCIA='+#39+trim(SELF.ver_domicilio_provincia)+#39+
                                       ',  DFCODIGOPOSTAL='+#39+trim(SELF.ver_domicilio_codigoPostal)+#39+
                                       ',  DFIVA='+#39+trim(SELF.ver_datosFacturacion_condicionIva)+#39+
                                       ',  DFIIBB='+#39+trim(SELF.ver_datosFacturacion_numeroIibb)+#39+
                                       ',  PAGOSID='+#39+trim(SELF.ver_datosPago_pagoID)+#39+
                                       ',  PAGOSGETWAY='+#39+trim(SELF.ver_datosPago_gatewayID)+#39+
                                       ',  PAGOSENTIDADID='+#39+trim(SELF.ver_datosPago_entidadID)+#39+
                                       ',  PAGOSENTIDAD='+#39+trim(SELF.ver_datosPago_entidadNombre)+#39+
                                       ',  PAGOSFECHA='+#39+trim(SELF.ver_datosPago_fechaPago)+#39+
                                       ',  PAGOSIMPORTE='+#39+trim(SELF.ver_datosPago_importeTotal)+#39+
                                       ',  PAGOSESTADOLIQUIDACION='+#39+trim(SELF.ver_detallesPagoVerificacion_estadoAcreditacion)+#39+
                                       ',  CODVEHIC='+INTTOSTR(codvehic)+
                                       ',  CODCLIEN='+INTTOSTR(codcliente)+
                                       ',  FACTURADO='+#39+trim(FACTURADO)+#39+
                                       ',  dvNUMERO='+#39+trim(SELF.ver_numeroChasis_numero)+#39+
                                       ', CODCLIENTEPRESENTANTE='+inttostr(codclientetitular)+
                                       ',  CUITTITULAR='+#39+trim(self.ver_datosTitular_numeroCuit)+#39+
                                       ',  CUITCONTACTO='+#39+trim(self.ver_datosPersonalesTurno_numeroCuit)+#39+
                                       ',  CUITFACTURA='+#39+trim(ver_datosPersonales_numeroCuit)+#39+
                                       ',  CONTACTORAZONSOCIAL='+#39+uppercase(trim(self.ver_datosPersonalesTurno_razonSocial))+#39+
                                       ',  TITULARRAZONSOCIAL='+#39+uppercase(trim(self.VER_datosTitular_razonSocial))+#39+
                                       ',  FACTURARAZONSOCIAL='+#39+uppercase(trim(self.ver_datosPersonales_razonSocial))+#39+
                                       ',  PAGOIDVERIFICACION='+#39+trim(self.ver_detallesPagoVerificacion_pagoID)+#39+
                                       ',  ESTADOACREDITACIONVERIFICACION='+#39+trim(self.ver_detallesPagoVerificacion_estadoAcreditacion)+#39+
                                       ',  PAGOGESTWAYIDVERIFICACION='+#39+trim(self.ver_detallesPagoVerificacion_pagoGatewayID)+#39+
                                       ',  PAGOIDOBLEA='+#39+trim(self.ver_detallesPagoOblea_pagoID)+#39+
                                       ',  ESTADOACREDITACIONOBLEA='+#39+trim(self.ver_detallesPagoOblea_estadoAcreditacion)+#39+
                                       ',  VALTITULAR='+#39+trim(self.ver_datosVehiculo_valTitular)+#39+
                                       ',  VALCHASIS='+#39+trim(self.ver_datosVehiculo_valChasis)+#39+
                                       ',  DATOSVEHICULOMTM='+#39+trim(self.ver_datosVehiculo_mtm)+#39+
                                       ',  MARCAIDVAL='+#39+trim(self.ver_datosValidados_marcaID)+#39+
                                       ',  MARCAVAL='+#39+trim(self.ver_datosValidados_marca)+#39+
                                       ',  TIPOIDVAL='+#39+trim(self.ver_datosValidados_tipoID)+#39+
                                       ', TIPOVAL='+#39+trim(self.ver_datosValidados_tipo)+#39+
                                       ',  MODELOIDVAL='+#39+trim(self.ver_datosValidados_modeloID)+#39+
                                        ', MODELOVAL='+#39+trim(self.ver_datosValidados_modelo)+#39+
                                       ',  MARCACHASISVAL='+#39+trim(self.ver_datosVehiculo_marca)+#39+
                                      ',  NUMEROCHASISVAL='+#39+trim(self.ver_numeroChasis_numero)+#39+
                                       ',  MTMVAL='+#39+trim(self.ver_datosValidados_mtm)+#39+
                                       ',  MODO='+#39+TRIM(VER_MODO_TURNO)+#39+
                                       ', fechalta=TO_DATE(sysdate,''DD/MM/YYYY'') '+
                                       ', PLANTA='+#39+TRIM(SELF.ver_plantaID)+#39+
                                       ', TIPOINSPE='+#39+TRIM(TIPOINSPE)+#39+
                                       ', ESTADOID='+INTTOSTR(IDESTADOTURNO)+
                                       ', ESTADODESC='+#39+TRIM(SELF.ver_estado)+#39+
                                       ', fechanovedad=TO_DATE('+#39+TRIM(ver_fechaNovedad)+#39+',''dd/mm/yyyy hh24:mi:ss'') '+
                                        ' where   TURNOID='+INTTOSTR(idturnoexiste);

                                        



              aq.sql.add(sSql);

             aq.ExecSQL;

        MYBD.Commit(TD);
        EXCEPT
            MyBD.Rollback(TD);
        END;

          AQ.CLOSE;
          AQ.FREE;


      end;//existe_novedad

       end;





      IF (facturado='O') OR (facturado='R') THEN
      BEGIN
         IF VER_TURNOID_RELACION<> 0 THEN
          BEGIN
               MyBD.StartTransaction(TD);
                 TRY
                   aq:=tsqlquery.create(nil);
                   aq.SQLConnection := MyBD;
                   aq.sql.add('SELECT TURNOID,TURNOIDRE,PAGOSID FROM TTURNORELACIONADO  '+
                              ' WHERE TURNOID='+INTTOSTR(IDTURNOBUSCAR)+' AND TURNOIDRE='+INTTOSTR(VER_TURNOID_RELACION));
                   aq.ExecSQL;
                   AQ.Open;
                     IF aq.IsEmpty  THEN
                        BEGIN

                           IF TRIM(SELF.ver_re_detallesPagoVerificacion_pagoID)<>'' THEN
                              pagoID_RELACION:=STRTOINT(SELF.ver_re_detallesPagoVerificacion_pagoID)
                              ELSE
                              pagoID_RELACION:=0;

                          IF TRIM(ver_re_item_plantaID)<>'' THEN
                             plantaID_RELACION:=STRTOINT(SELF.ver_re_item_plantaID)
                             ELSE
                              plantaID_RELACION:=0;

                            AQ.Close;
                            AQ.SQL.Clear;
                            aq.sql.add('INSERT INTO TTURNORELACIONADO (TURNOID,TURNOIDRE,PAGOSID, CODPLANTA)  '+
                                       '  VALUES ('+INTTOSTR(IDTURNOBUSCAR)+','+INTTOSTR(VER_TURNOID_RELACION)+
                                       ','+INTTOSTR(pagoID_RELACION)+','+INTTOSTR(plantaID_RELACION)+')');
                            aq.ExecSQL;
                         END;



              MYBD.Commit(TD);
                EXCEPT
                  MyBD.Rollback(TD);
               END;



        AQ.Close;
        AQ.FREE;

       END ELSE
        BEGIN
           MyBD.StartTransaction(TD);
             TRY
               aq:=tsqlquery.create(nil);
               aq.SQLConnection := MyBD;
               aq.sql.add('SELECT TURNOID,TURNOIDRE,PAGOSID FROM TTURNORELACIONADO  '+
                     ' WHERE  PAGOSID='+#39+(TRIM(SELF.detallesPagoVerificacion_pagoID))+#39);
               aq.ExecSQL;
               AQ.Open;
                IF aq.IsEmpty   THEN
                 BEGIN

                   IF TRIM(SELF.detallesPagoVerificacion_pagoID)<>'' THEN
                      pagoID_RELACION:=STRTOINT(SELF.detallesPagoVerificacion_pagoID)
                   ELSE
                     pagoID_RELACION:=0;

                   IF TRIM(detallesPagoVerificacion_plantaID)<>'' THEN
                      plantaID_RELACION:=STRTOINT(SELF.detallesPagoVerificacion_plantaID)
                      ELSE
                       plantaID_RELACION:=0;

                      AQ.Close;
                      AQ.SQL.Clear;
                      aq.sql.add('INSERT INTO TTURNORELACIONADO (TURNOID,TURNOIDRE,PAGOSID, CODPLANTA)  '+
                                 '  VALUES ('+INTTOSTR(IDTURNOBUSCAR)+','+INTTOSTR(VER_TURNOID_RELACION)+
                                 ','+INTTOSTR(pagoID_RELACION)+','+INTTOSTR(plantaID_RELACION)+')');
                       aq.ExecSQL;
                 END;



        MYBD.Commit(TD);
        EXCEPT
            MyBD.Rollback(TD);
        END;



        AQ.Close;
        AQ.FREE;


      END;


  END;



end;


 
Procedure txml_caba.Guarda_turno_en_basedatos_IDCLIENTECERO;
var aq,AQELI:tsqlquery;         exite_novedad_guardada:boolean;
sSql, sestado,FECHATURNO,FECHALTA,sconcesionario,INFORMADOWS,CP,LOCALI,PROVIN:string;
 flagj,domicilio_factura,CODIGOPOSTAL,DIA,MES,ANNIO,numeromotor,vtipo,vmodelo,vmarca:string;
 codvehic:longint;  existe:boolean;  IDESTADOTURNO:LONGINT;
 codcliente,codclientetitular,idturnoexiste,IDTURNOBUSCAR:longint;
 cargado:longint;  aaa:longint;
 AUSENTE,FACTURADO,REVISO,NRODOC,GEN,nombrecliente,nro_doc_contacto,NOMBRE_CONTACTO:STRING;
  TD: TTransactionDesc;     SE_INSERTA:BOOLEAN;
  FECHA,tipofact,TIPOINSPE,nombrecliente_TITULAR,nombrecliente_FACT,x,apellido_fact:STRING;
   pagoID_RELACION:LONGINT;
   plantaID_RELACION:LONGINT;
begin


   idturnoexiste:=-1;
  FECHA:=TRIM(DATETOSTR(DATE));
  IF TRIM(SELF.ver_re_item_turnoID)<>'' THEN
  TURNOID_RELACION:=STRTOINT(SELF.ver_re_item_turnoID)
  ELSE
  TURNOID_RELACION:=0;

  Form1.Memo1.Lines.Add('Procesando turno: '+SELF.ver_turnoID+' Dominio: '+SELF.ver_datosVehiculo_dominio);
  application.ProcessMessages;

   aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;

  IDTURNOBUSCAR:=STRTOINT(SELF.ver_turnoID);



    IF SELF.ver_PLANTA<>STRTOINT(SELF.ver_plantaID) THEN
        EXIT;


      AQ.CLOSE;
      AQ.FREE;

    IF TRIM(SELF.VER_ES_REVERIFICACION)='N' THEN
      TIPOINSPE:='P'
      ELSE
      TIPOINSPE:='R';


      sestado:='A';
      sconcesionario:=SELF.ver_plantaID;

       dia:=copy(trim(SELF.ver_fechaTurno),9,2);
       mes:=copy(trim(ver_FECHATURNO),6,2);
       annio:=copy(trim(ver_FECHATURNO),1,4);
       FECHATURNO:=dia+'/'+mes+'/'+annio;


       dia:=copy(trim(SELF.ver_fechaRegistro),9,2);
       mes:=copy(trim(ver_fechaRegistro),6,2);
       annio:=copy(trim(ver_fechaRegistro),1,4);
       FECHALTA:=dia+'/'+mes+'/'+annio;
       flagj:='1';
       codvehic:=0;
       codcliente:=0;

      ///datos factura
       try

          GEN:=TRIM(SELF.ver_datosPersonales_genero);


         IF SELF.ver_datosPersonales_tipoDocumento='9' THEN
         begin
              GEN:='PJ';

            NRODOC:=TRIM(SELF.ver_datosPersonales_numeroCuit);
         end   else
         begin
              NRODOC:=TRIM(SELF.ver_datosPersonales_numeroDocumento);
               GEN:='M';
         end;



            if (trim(SELF.ver_datosPersonales_nombre)<>'') AND (LENGTH(SELF.ver_datosPersonales_nombre) >=2) then
              nombrecliente_FACT:=trim(ver_datosPersonales_nombre)
              else
              nombrecliente_FACT:=trim(self.ver_datosPersonales_razonSocial);


              if (trim(SELF.ver_datosPersonales_apellido)='') OR  (LENGTH(SELF.ver_datosPersonales_apellido) <=2) then
                   datosPersonales_apellido:='.';

         if (trim(SELF.ver_datosFacturacion_condicionIva)='R') then
                tipofact:='A'
                else
                tipofact:='B';



          { IF TRIM(ver_DFCALLE)='' THEN
              DFCALLE:='S/D';

           if trim(ver_DFNUMEROCALLE)='' then
              DFNUMEROCALLE:='0';

           if trim(ver_DFDEPARTAMENTO)
           DFDEPARTAMENTO
           DFLOCALIDAD
           DFPROVINCIA
           DFCODIGOPOSTAL  }


            IF (TRIM(SELF.datosPersonales_genero)='PJ') AND ((TRIM(SELF.datosPersonales_numeroCuit)='') OR (TRIM(datosPersonales_numeroCuit)='0')) THEN
              BEGIN
                 NRODOC:=SELF.datosPersonales_numeroDocumento;
                nombrecliente_FACT:=SELF.ver_datosPersonales_razonSocial;
              END;




        {  if trim(ver_datosTitular_tipoDocumento)='9' then //cuit
          begin
               if ( (trim(self.ver_datosTitular_numeroDocumento)<>'0')
                  or (trim(self.ver_datosTitular_numeroDocumento)<>'')) and (length(self.ver_datosTitular_numeroDocumento)>10)  then
                    NRODOC:=self.ver_datosTitular_numeroDocumento
                    else
                    NRODOC:=trim(self.ver_datosTitular_numeroCuit);



               if (trim(self.ver_datosTitular_nombre)<>'') or (trim(self.ver_datosTitular_nombre)<>'0') then
                     begin
                        nombrecliente_FACT:=trim();

                     end;



          end else begin //dni






          end;    }


          if (trim(SELF.ver_datosPersonales_tipoDocumento)='0') OR
              (trim(SELF.ver_datosPersonales_tipoDocumento)='1') OR
              (trim(SELF.ver_datosPersonales_tipoDocumento)='2') OR
              (trim(SELF.ver_datosPersonales_tipoDocumento)='3') OR
              (trim(SELF.ver_datosPersonales_tipoDocumento)='4') OR
              (trim(SELF.ver_datosPersonales_tipoDocumento)='5') OR
              (trim(SELF.ver_datosPersonales_tipoDocumento)='6') OR
              (trim(SELF.ver_datosPersonales_tipoDocumento)='7') OR
              (trim(SELF.ver_datosPersonales_tipoDocumento)='8') OR
              (trim(SELF.ver_datosPersonales_tipoDocumento)='10') OR
              (trim(SELF.ver_datosPersonales_tipoDocumento)='11') OR
              (trim(SELF.ver_datosPersonales_tipoDocumento)='12') OR
              (trim(SELF.ver_datosPersonales_tipoDocumento)='13') then
             begin
                 NRODOC:=trim(self.ver_datosPersonales_numeroDocumento);
                 nombrecliente_FACT:=trim(self.ver_datosPersonales_nombre);
                 apellido_fact:=trim(self.ver_datosPersonales_apellido);
             end;


            if trim(SELF.ver_datosPersonales_tipoDocumento)='9' then
             begin
                 NRODOC:=trim(self.ver_datosPersonales_numeroCuit);
                 nombrecliente_FACT:=trim(ver_datosPersonales_razonSocial);
                 apellido_fact:='.';
             end;

      CP:=TRIM(self.ver_domicilio_CODIGOPOSTAL);

      LOCALI:=TRIM(self.ver_domicilio_localidad);
      PROVIN:=TRIM(self.ver_domicilio_provincia);

    //  LOCALI:='CABA';
     // PROVIN:='CABA';



       codcliente:=Devuelve_codclien(NRODOC,
                                     nombrecliente_FACT ,
                                     apellido_fact ,
                                     ver_domicilio_calle ,
                                     ver_domicilio_numero,
                                     self.ver_domicilio_departamento,
                                     LOCALI,
                                     PROVIN,
                                     CP,GEN,ver_datosPersonales_tipoDocumento,tipofact, ver_datosFacturacion_condicionIva);


       except

       aq:=tsqlquery.create(nil);
       aq.SQLConnection := MyBD;
       AQ.SQL.Clear;
       aq.sql.add('SELECT  CODCLIEN FROM TCLIENTES WHERE  DOCUMENT='+#39+TRIM(NRODOC)+#39+' AND TIPODOCU=''DNI'' ');
       AQ.ExecSQL;
       AQ.Open;
       IF not  AQ.IsEmpty THEN
         codcliente:=AQ.FIELDBYNAME('CODCLIEN').ASINTEGER
         ELSE
         BEGIN
            AQ.SQL.Clear;
            aq.sql.add('SELECT  CODCLIEN FROM TCLIENTES  WHERE CUIT_CLI='+#39+TRIM(NRODOC)+#39+' AND TIPODOCU=''CUIT'' ');
            AQ.ExecSQL;
            AQ.Open;
             IF not AQ.IsEmpty THEN
                 codcliente:=AQ.FIELDBYNAME('CODCLIEN').ASINTEGER
                 ELSE
                    BEGIN
                       AQ.SQL.Clear;
                       aq.sql.add('SELECT  CODCLIEN FROM TCLIENTES  WHERE DOCUMENT='+#39+TRIM(NRODOC)+#39+' AND TIPODOCU=''CUIT'' ');
                       AQ.ExecSQL;
                       AQ.Open;
                        IF not AQ.IsEmpty THEN
                          codcliente:=AQ.FIELDBYNAME('CODCLIEN').ASINTEGER

                         ELSE
                           codcliente:=0;


                    END;
         END;






       aq.CLOSE;
       aq.FREE;



       end;


      ///cliente presentante
       try


          GEN:=TRIM(SELF.ver_datosTitular_genero);


         IF SELF.ver_datosTitular_tipoDocumento='9' THEN
            NRODOC:=TRIM(SELF.ver_datosTitular_numeroCuit)
            else
             NRODOC:=TRIM(SELF.ver_datosTitular_numeroDocumento);





          IF TRIM(ver_datosTitular_tipoDocumento)='9' THEN
               BEGIN
                  IF TRIM(SELF.ver_datosTitular_numeroCuit)='' THEN
                      BEGIN
                          NRODOC:=TRIM(SELF.ver_datosTitular_numeroDocumento);
                          SELF.datosTitular_tipoDocumento:='1';

                      END;


               END;



               IF TRIM(NRODOC)='' THEN
                BEGIN
                     IF TRIM(SELF.ver_datosTitular_numeroDocumento)<>'' THEN
                        NRODOC:=ver_datosTitular_numeroDocumento
                        ELSE
                        NRODOC:=SELF.ver_datosTitular_numeroCuit;

                END;



                  if (trim(SELF.ver_datosTitular_nombre)<>'') AND (LENGTH(SELF.ver_datosTitular_nombre) >=2)  then
              nombrecliente_TITULAR:=trim(ver_datosTitular_nombre)
              else
              nombrecliente_TITULAR:=trim(self.VER_datosTitular_razonSocial);


              if (trim(SELF.ver_datosTitular_apellido)='') OR  (LENGTH(SELF.ver_datosTitular_apellido) <=2) then
                    datosTitular_apellido :='.';



          IF (TRIM(ver_datosTitular_genero)='PJ') AND ((TRIM(ver_datosTitular_numeroCuit)='') OR (TRIM(ver_datosTitular_numeroCuit)='0')) THEN
              BEGIN
                 NRODOC:=ver_datosTitular_numeroDocumento;
                nombrecliente_TITULAR:=SELF.ver_datosTitular_razonSocial;
              END;

       codclientetitular:=Devuelve_codclien(NRODOC,
                                     nombrecliente_TITULAR ,
                                     self.ver_datosTitular_apellido ,
                                     ver_domicilio_calle ,
                                     ver_domicilio_numero,
                                     self.ver_domicilio_departamento,
                                     self.ver_domicilio_localidad,
                                     self.ver_domicilio_provincia ,
                                     self.ver_domicilio_CODIGOPOSTAL,GEN,self.ver_datosTitular_tipoDocumento,tipofact,self.ver_datosFacturacion_condicionIva);   //self.ver_DFPROVINCIA
              except


           codclientetitular:=codcliente







       end;

       //---------------------------------------












        try

         if trim(self.ver_datosVehiculo_valChasis)='V' then
            begin
             numeromotor:=self.ver_numeroChasis_numero;
            end else begin

              numeromotor:=self.ver_numeroChasis_numero ;
            end;

            if  trim(ver_datosValidados_marca)<>'' then
                 vmarca:=SELF.ver_datosValidados_marca
                 else
                 Vmarca:=ver_datosVehiculo_marca;


             if  trim(SELF.ver_datosValidados_tipo)<>'' then
                 vtipo:=ver_datosValidados_tipo
                 else
                 vtipo:=SELF.ver_datosVehiculo_tipo;



             if  trim(SELF.ver_datosValidados_modelo)<>'' then
                 vmodelo:=ver_datosValidados_modelo
                 else
                 vmodelo:=SELF.ver_datosVehiculo_modelo;



             codvehic:=Devuelve_codvehiculo(uppercase(self.ver_datosVehiculo_dominio),
                        uppercase(numeromotor),
                        uppercase(vtipo),
                        uppercase(vmarca),
                        uppercase(vmodelo) ,
                        strtoint(SELF.ver_datosVehiculo_anio));


             if trim(ver_datosPersonalesTurno_numeroDocumento)<>'' then
             nro_doc_contacto:=ver_datosPersonalesTurno_numeroDocumento
             else
             nro_doc_contacto:=ver_datosPersonalesTurno_numeroCuit;

             if trim(ver_datosPersonalesTurno_razonSocial)<>'' then
               nombre_contacto:=ver_datosPersonalesTurno_razonSocial
               else
               nombre_contacto:=ver_datosPersonalesTurno_nombre;




        except


         codvehic:=0;

        end;






        IDESTADOTURNO:=STRTOINT(SELF.ver_estadoID);
      sSql:='';
        exite_novedad_guardada:=false;
        application.ProcessMessages;


       TRY
          aq:=tsqlquery.create(nil);
       aq.SQLConnection := MyBD;
       AQ.SQL.Clear;
          sSql:='update tdatosturno   set  TITULARGENERO='+#39+trim(SELF.ver_datosTitular_genero)+#39+
                                       ',  TTULARTIPODOCUMENTO='+#39+trim(self.ver_datosTitular_tipoDocumento)+#39+
                                       ',  TITULARNRODOCUMENTO='+#39+trim(NRODOC)+#39+
                                       ',  TITULARNOMBRE='+#39+uppercase(trim(nombrecliente_TITULAR))+#39+
                                       ',  TITULARAPELLIDO='+#39+uppercase(trim(self.ver_datosTitular_apellido))+#39+
                                       ',  CONTACTOGENERO='+#39+TRIM(ver_datosPersonales_genero)+#39+
                                       ',  CONTACTOTIPODOCUMENTO='+#39+trim(self.ver_datosPersonales_tipoDocumento)+#39+
                                       ',  CONTACTONRODOCUMENTO='+#39+trim(nro_doc_contacto)+#39+
                                       ',  CONTACTONOMBRE='+#39+uppercase(trim(nombre_contacto))+#39+
                                       ',  CONTACTOAPELLIDO='+#39+uppercase(trim(self.ver_datosPersonalesTurno_apellido))+#39+
                                       ',  CONTACTOTELEFONO='+#39+trim(self.ver_contactoTurno_telefonoCelular)+#39+
                                       ',  CONTACTOEMAIL='+#39+trim(self.ver_contactoTurno_email)+#39+
                                       ',  CONTACTOFECHANAC='+#39+trim(self.ver_contactoTurno_fechaNacimiento)+#39+
                                       ',  DFGENERO='+#39+trim(SELF.ver_datosPersonales_genero)+#39+
                                       ',  DFTIPODOCUMENTO='+#39+trim(SELF.ver_datosPersonales_tipoDocumento)+#39+
                                       ',  DFNRODOCUMENTO='+#39+trim(SELF.ver_datosPersonales_numeroDocumento)+#39+
                                       ',  DFNOMBRE='+#39+uppercase(trim(SELF.ver_datosPersonales_nombre))+#39+
                                       ',  DFAPELLIDO='+#39+uppercase(trim(SELF.ver_datosPersonales_apellido))+#39+
                                       ',  DFCALLE='+#39+trim(SELF.ver_domicilio_calle)+#39+
                                       ',  DFNUMEROCALLE='+#39+trim(SELF.ver_domicilio_numero)+#39+
                                       ',  DFPISO='+#39+trim(SELF.ver_domicilio_piso)+#39+
                                       ',  DFDEPARTAMENTO='+#39+trim(SELF.ver_domicilio_departamento)+#39+
                                       ',  DFLOCALIDAD='+#39+trim(SELF.ver_domicilio_localidad)+#39+
                                       ',  DFPROVINCIAID='+#39+trim(SELF.ver_domicilio_provinciaID)+#39+
                                       ',  DFPROVINCIA=' +#39+trim(SELF.ver_domicilio_provincia)+#39+
                                       ',  DFCODIGOPOSTAL='+#39+trim(SELF.ver_domicilio_codigoPostal)+#39+
                                       ',  DFIVA='+#39+trim(SELF.ver_datosFacturacion_condicionIva)+#39+
                                       ',  DFIIBB='+#39+trim(SELF.ver_datosFacturacion_numeroIibb)+#39+
                                       ',  CODCLIEN='+INTTOSTR(codcliente)+
                                       ', CODCLIENTEPRESENTANTE='+inttostr(codclientetitular)+
                                       ',  CUITTITULAR='+#39+trim(self.ver_datosTitular_numeroCuit)+#39+
                                       ',  CUITCONTACTO='+#39+trim(self.ver_datosPersonalesTurno_numeroCuit)+#39+
                                       ',  CUITFACTURA='+#39+trim(ver_datosPersonales_numeroCuit)+#39+
                                       ',  CONTACTORAZONSOCIAL='+#39+uppercase(trim(self.ver_datosPersonalesTurno_razonSocial))+#39+
                                       ',  TITULARRAZONSOCIAL='+#39+uppercase(trim(self.VER_datosTitular_razonSocial))+#39+
                                       ',  FACTURARAZONSOCIAL='+#39+uppercase(trim(self.ver_datosPersonales_razonSocial))+#39+
                                       ' where   TURNOID='+INTTOSTR(IDTURNOBUSCAR);







              aq.sql.add(sSql);

             aq.ExecSQL;


        EXCEPT
         
        END;

          AQ.CLOSE;
          AQ.FREE;

























end;



end.




