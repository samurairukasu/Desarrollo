// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://testing.suvtv.com.ar/service/s_001.php?wsdl
// Encoding : ISO-8859-1
// Version  : 1.0
// (27/06/2016 16:30:40 - 1.33.2.5)
// ************************************************************************ //

unit s_0011;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:int             - "http://www.w3.org/2001/XMLSchema"
  // !:string          - "http://www.w3.org/2001/XMLSchema"
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"
  // !:unsignedLong    - "http://www.w3.org/2001/XMLSchema"
  // !:token           - "http://www.w3.org/2001/XMLSchema"
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"
  // !:date            - "http://www.w3.org/2001/XMLSchema"
  // !:time            - "http://www.w3.org/2001/XMLSchema"
  // !:float           - "http://www.w3.org/2001/XMLSchema"

  respuestaEco         = class;                 { "urn:suvtv" }
  respuestaAbrirSesion = class;                 { "urn:suvtv" }
  respuestaCerrarSesion = class;                { "urn:suvtv" }
  datosPersonales      = class;                 { "urn:suvtv" }
  domicilio            = class;                 { "urn:suvtv" }
  datosContactoPresentante = class;             { "urn:suvtv" }
  datosPresentante     = class;                 { "urn:suvtv" }
  datosContacto        = class;                 { "urn:suvtv" }
  resultadoVerificacion = class;                { "urn:suvtv" }
  detallesVerificacion = class;                 { "urn:suvtv" }
  datosVerificacion    = class;                 { "urn:suvtv" }
  respuestaInformarVerificacion = class;        { "urn:suvtv" }
  datosContactoTurno   = class;                 { "urn:suvtv" }
  datosFacturacion     = class;                 { "urn:suvtv" }
  turnosRelacionadosDatos = class;              { "urn:suvtv" }
  datosTurno           = class;                 { "urn:suvtv" }
  chasis               = class;                 { "urn:suvtv" }
  datosVehiculo        = class;                 { "urn:suvtv" }
  datosPago            = class;                 { "urn:suvtv" }
  turnosSolicitados    = class;                 { "urn:suvtv" }
  respuestaSolicitarTurnos = class;             { "urn:suvtv" }
  turnosAusentes       = class;                 { "urn:suvtv" }
  rtaInformarAusentes  = class;                 { "urn:suvtv" }
  respuestaInformarAusentes = class;            { "urn:suvtv" }

  { "urn:suvtv" }
  genero = (M, F);

  { "urn:suvtv" }
  verificacionResultado = (A, R, C);

  { "urn:suvtv" }
  tipoConsultaTurno = (T, N);

  { "urn:suvtv" }
  tipoTurno = (O, P);

  { "urn:suvtv" }
  condicionIva = (R2, C2, E, M2);

  { "urn:suvtv" }
  estadoLiquidacion = (N2, A2);



  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  respuestaEco = class(TRemotable)
  private
    FrespuestaID: Integer;
    FrespuestaMensaje: WideString;
    Fdisponible: Boolean;
    FversionWS: WideString;
  published
    property respuestaID: Integer read FrespuestaID write FrespuestaID;
    property respuestaMensaje: WideString read FrespuestaMensaje write FrespuestaMensaje;
    property disponible: Boolean read Fdisponible write Fdisponible;
    property versionWS: WideString read FversionWS write FversionWS;
  end;



  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  respuestaAbrirSesion = class(TRemotable)
  private
    FrespuestaID: Integer;
    FrespuestaMensaje: WideString;
    FingresoID: Int64;
    FsesionID: WideString;
  published
    property respuestaID: Integer read FrespuestaID write FrespuestaID;
    property respuestaMensaje: WideString read FrespuestaMensaje write FrespuestaMensaje;
    property ingresoID: Int64 read FingresoID write FingresoID;
    property sesionID: WideString read FsesionID write FsesionID;
  end;



  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  respuestaCerrarSesion = class(TRemotable)
  private
    FrespuestaID: Integer;
    FrespuestaMensaje: WideString;
    FingresoID: Int64;
    FcierreSesionFecha: TXSDateTime;
  public
    destructor Destroy; override;
  published
    property respuestaID: Integer read FrespuestaID write FrespuestaID;
    property respuestaMensaje: WideString read FrespuestaMensaje write FrespuestaMensaje;
    property ingresoID: Int64 read FingresoID write FingresoID;
    property cierreSesionFecha: TXSDateTime read FcierreSesionFecha write FcierreSesionFecha;
  end;

  formularios = array of Int64;                 { "urn:suvtv" }


  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  datosPersonales = class(TRemotable)
  private
    Fgenero: genero;
    FtipoDocumento: Integer;
    FnumeroDocumento: Int64;
    Fnombre: WideString;
    Fapellido: WideString;
  published
    property genero: genero read Fgenero write Fgenero;
    property tipoDocumento: Integer read FtipoDocumento write FtipoDocumento;
    property numeroDocumento: Int64 read FnumeroDocumento write FnumeroDocumento;
    property nombre: WideString read Fnombre write Fnombre;
    property apellido: WideString read Fapellido write Fapellido;
  end;



  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  domicilio = class(TRemotable)
  private
    Fcalle: WideString;
    Fnumero: WideString;
    Fpiso: WideString;
    Fdepartamento: WideString;
    Flocalidad: WideString;
    FprovinciaID: Integer;
    Fprovincia: WideString;
    FcodigoPostal: WideString;
  published
    property calle: WideString read Fcalle write Fcalle;
    property numero: WideString read Fnumero write Fnumero;
    property piso: WideString read Fpiso write Fpiso;
    property departamento: WideString read Fdepartamento write Fdepartamento;
    property localidad: WideString read Flocalidad write Flocalidad;
    property provinciaID: Integer read FprovinciaID write FprovinciaID;
    property provincia: WideString read Fprovincia write Fprovincia;
    property codigoPostal: WideString read FcodigoPostal write FcodigoPostal;
  end;



  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  datosContactoPresentante = class(TRemotable)
  private
    FtelefonoCelular: WideString;
    Femail: WideString;
  published
    property telefonoCelular: WideString read FtelefonoCelular write FtelefonoCelular;
    property email: WideString read Femail write Femail;
  end;



  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  datosPresentante = class(TRemotable)
  private
    FdatosPersonales: datosPersonales;
    Fdomicilio: domicilio;
    FdatosContacto: datosContactoPresentante;
  public
    destructor Destroy; override;
  published
    property datosPersonales: datosPersonales read FdatosPersonales write FdatosPersonales;
    property domicilio: domicilio read Fdomicilio write Fdomicilio;
    property datosContacto: datosContactoPresentante read FdatosContacto write FdatosContacto;
  end;



  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  datosContacto = class(TRemotable)
  private
    FtelefonoCelular: WideString;
    Femail: WideString;
    FfechaNacimiento: TXSDate;
  public
    destructor Destroy; override;
  published
    property telefonoCelular: WideString read FtelefonoCelular write FtelefonoCelular;
    property email: WideString read Femail write Femail;
    property fechaNacimiento: TXSDate read FfechaNacimiento write FfechaNacimiento;
  end;



  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  resultadoVerificacion = class(TRemotable)
  private
    Fresultado: verificacionResultado;
    Fobservaciones: WideString;
  published
    property resultado: verificacionResultado read Fresultado write Fresultado;
    property observaciones: WideString read Fobservaciones write Fobservaciones;
  end;



  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  detallesVerificacion = class(TRemotable)
  private
    FmotorVerificacion: resultadoVerificacion;
    FlucesVerificacion: resultadoVerificacion;
    FdireccionVerificacion: resultadoVerificacion;
    FfrenosVerificacion: resultadoVerificacion;
    FsuspensionVerificacion: resultadoVerificacion;
    FchasisVerificacion: resultadoVerificacion;
    FllantasVerificacion: resultadoVerificacion;
    FneumaticosVerificacion: resultadoVerificacion;
    FgeneralVerificacion: resultadoVerificacion;
    FcontaminacionVerificacion: resultadoVerificacion;
    FseguridadVerificacion: resultadoVerificacion;
  public
    destructor Destroy; override;
  published
    property motorVerificacion: resultadoVerificacion read FmotorVerificacion write FmotorVerificacion;
    property lucesVerificacion: resultadoVerificacion read FlucesVerificacion write FlucesVerificacion;
    property direccionVerificacion: resultadoVerificacion read FdireccionVerificacion write FdireccionVerificacion;
    property frenosVerificacion: resultadoVerificacion read FfrenosVerificacion write FfrenosVerificacion;
    property suspensionVerificacion: resultadoVerificacion read FsuspensionVerificacion write FsuspensionVerificacion;
    property chasisVerificacion: resultadoVerificacion read FchasisVerificacion write FchasisVerificacion;
    property llantasVerificacion: resultadoVerificacion read FllantasVerificacion write FllantasVerificacion;
    property neumaticosVerificacion: resultadoVerificacion read FneumaticosVerificacion write FneumaticosVerificacion;
    property generalVerificacion: resultadoVerificacion read FgeneralVerificacion write FgeneralVerificacion;
    property contaminacionVerificacion: resultadoVerificacion read FcontaminacionVerificacion write FcontaminacionVerificacion;
    property seguridadVerificacion: resultadoVerificacion read FseguridadVerificacion write FseguridadVerificacion;
  end;



  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  datosVerificacion = class(TRemotable)
  private
    Fresultado: verificacionResultado;
    FfechaVencimiento: TXSDate;
    FfechaVigencia: TXSDate;
    FfechaEntrada: TXSDateTime;
    FfechaSalida: TXSDateTime;
    FdetallesVerificacion: detallesVerificacion;
    Fobservaciones: WideString;
  public
    destructor Destroy; override;
  published
    property resultado: verificacionResultado read Fresultado write Fresultado;
    property fechaVencimiento: TXSDate read FfechaVencimiento write FfechaVencimiento;
    property fechaVigencia: TXSDate read FfechaVigencia write FfechaVigencia;
    property fechaEntrada: TXSDateTime read FfechaEntrada write FfechaEntrada;
    property fechaSalida: TXSDateTime read FfechaSalida write FfechaSalida;
    property detallesVerificacion: detallesVerificacion read FdetallesVerificacion write FdetallesVerificacion;
    property observaciones: WideString read Fobservaciones write Fobservaciones;
  end;



  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  respuestaInformarVerificacion = class(TRemotable)
  private
    FrespuestaID: Integer;
    FrespuestaMensaje: WideString;
    FverificacionID: Int64;
  published
    property respuestaID: Integer read FrespuestaID write FrespuestaID;
    property respuestaMensaje: WideString read FrespuestaMensaje write FrespuestaMensaje;
    property verificacionID: Int64 read FverificacionID write FverificacionID;
  end;



  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  datosContactoTurno = class(TRemotable)
  private
    FdatosPersonalesTurno: datosPersonales;
    FcontactoTurno: datosContacto;
  public
    destructor Destroy; override;
  published
    property datosPersonalesTurno: datosPersonales read FdatosPersonalesTurno write FdatosPersonalesTurno;
    property contactoTurno: datosContacto read FcontactoTurno write FcontactoTurno;
  end;



  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  datosFacturacion = class(TRemotable)
  private
    FdatosPersonales: datosPersonales;
    Fdomicilio: domicilio;
    FcondicionIva: condicionIva;
    FnumeroIibb: Int64;
  public
    destructor Destroy; override;
  published
    property datosPersonales: datosPersonales read FdatosPersonales write FdatosPersonales;
    property domicilio: domicilio read Fdomicilio write Fdomicilio;
    property condicionIva: condicionIva read FcondicionIva write FcondicionIva;
    property numeroIibb: Int64 read FnumeroIibb write FnumeroIibb;
  end;



  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  turnosRelacionadosDatos = class(TRemotable)
  private
    FturnoID: Int64;
    Festado: WideString;
    FfechaNovedad: TXSDateTime;
  public
    destructor Destroy; override;
  published
    property turnoID: Int64 read FturnoID write FturnoID;
    property estado: WideString read Festado write Festado;
    property fechaNovedad: TXSDateTime read FfechaNovedad write FfechaNovedad;
  end;

  turnosRelacionados = array of turnosRelacionadosDatos;   { "urn:suvtv" }


  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  datosTurno = class(TRemotable)
  private
    FturnoID: Int64;
    FestadoID: Integer;
    Festado: WideString;
    FtipoTurno: tipoTurno;
    FfechaTurno: TXSDate;
    FhoraTurno: TXSTime;
    FfechaRegistro: TXSDateTime;
    FturnosRelacionados: turnosRelacionados;
  public
    destructor Destroy; override;
  published
    property turnoID: Int64 read FturnoID write FturnoID;
    property estadoID: Integer read FestadoID write FestadoID;
    property estado: WideString read Festado write Festado;
    property tipoTurno: tipoTurno read FtipoTurno write FtipoTurno;
    property fechaTurno: TXSDate read FfechaTurno write FfechaTurno;
    property horaTurno: TXSTime read FhoraTurno write FhoraTurno;
    property fechaRegistro: TXSDateTime read FfechaRegistro write FfechaRegistro;
    property turnosRelacionados: turnosRelacionados read FturnosRelacionados write FturnosRelacionados;
  end;



  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  chasis = class(TRemotable)
  private
    Fmarca: WideString;
    Fnumero: WideString;
  published
    property marca: WideString read Fmarca write Fmarca;
    property numero: WideString read Fnumero write Fnumero;
  end;



  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  datosVehiculo = class(TRemotable)
  private
    Fdominio: WideString;
    FmarcaID: WideString;
    Fmarca: WideString;
    FtipoID: WideString;
    Ftipo: WideString;
    FmodeloID: WideString;
    Fmodelo: WideString;
    FnumeroChasis: chasis;
    Fanio: Integer;
    FjurisdiccionID: Integer;
    Fjurisdiccion: WideString;
    Fmtm: WideString;
  public
    destructor Destroy; override;
  published
    property dominio: WideString read Fdominio write Fdominio;
    property marcaID: WideString read FmarcaID write FmarcaID;
    property marca: WideString read Fmarca write Fmarca;
    property tipoID: WideString read FtipoID write FtipoID;
    property tipo: WideString read Ftipo write Ftipo;
    property modeloID: WideString read FmodeloID write FmodeloID;
    property modelo: WideString read Fmodelo write Fmodelo;
    property numeroChasis: chasis read FnumeroChasis write FnumeroChasis;
    property anio: Integer read Fanio write Fanio;
    property jurisdiccionID: Integer read FjurisdiccionID write FjurisdiccionID;
    property jurisdiccion: WideString read Fjurisdiccion write Fjurisdiccion;
    property mtm: WideString read Fmtm write Fmtm;
  end;



  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  datosPago = class(TRemotable)
  private
    FpagoID: Int64;
    FgatewayID: Int64;
    FentidadID: Integer;
    FentidadNombre: WideString;
    FfechaPago: TXSDateTime;
    Fimporte: Single;
    FestadoLiquidacion: estadoLiquidacion;
  public
    destructor Destroy; override;
  published
    property pagoID: Int64 read FpagoID write FpagoID;
    property gatewayID: Int64 read FgatewayID write FgatewayID;
    property entidadID: Integer read FentidadID write FentidadID;
    property entidadNombre: WideString read FentidadNombre write FentidadNombre;
    property fechaPago: TXSDateTime read FfechaPago write FfechaPago;
    property importe: Single read Fimporte write Fimporte;
    property estadoLiquidacion: estadoLiquidacion read FestadoLiquidacion write FestadoLiquidacion;
  end;



  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  turnosSolicitados = class(TRemotable)
  private
    FdatosTurno: datosTurno;
    FdatosTitular: datosPersonales;
    FdatosContacto: datosContactoTurno;
    FdatosVehiculo: datosVehiculo;
    FdatosFacturacion: datosFacturacion;
    FdatosPago: datosPago;
  public
    destructor Destroy; override;
  published
    property datosTurno: datosTurno read FdatosTurno write FdatosTurno;
    property datosTitular: datosPersonales read FdatosTitular write FdatosTitular;
    property datosContacto: datosContactoTurno read FdatosContacto write FdatosContacto;
    property datosVehiculo: datosVehiculo read FdatosVehiculo write FdatosVehiculo;
    property datosFacturacion: datosFacturacion read FdatosFacturacion write FdatosFacturacion;
    property datosPago: datosPago read FdatosPago write FdatosPago;
  end;

  turnosSolicitadosLista = array of turnosSolicitados;   { "urn:suvtv" }


  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  respuestaSolicitarTurnos = class(TRemotable)
  private
    FrespuestaID: Integer;
    FrespuestaMensaje: WideString;
    Fturnos: turnosSolicitadosLista;
  public
    destructor Destroy; override;
  published
    property respuestaID: Integer read FrespuestaID write FrespuestaID;
    property respuestaMensaje: WideString read FrespuestaMensaje write FrespuestaMensaje;
    property turnos: turnosSolicitadosLista read Fturnos write Fturnos;
  end;



  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  turnosAusentes = class(TRemotable)
  private
    FturnoID: Int64;
    Fdominio: WideString;
  published
    property turnoID: Int64 read FturnoID write FturnoID;
    property dominio: WideString read Fdominio write Fdominio;
  end;



  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  rtaInformarAusentes = class(TRemotable)
  private
    FturnoID: Int64;
    FrespuestaID: Integer;
    FrespuestaMensaje: WideString;
  published
    property turnoID: Int64 read FturnoID write FturnoID;
    property respuestaID: Integer read FrespuestaID write FrespuestaID;
    property respuestaMensaje: WideString read FrespuestaMensaje write FrespuestaMensaje;
  end;

  turnosAusentesListaRta = array of rtaInformarAusentes;   { "urn:suvtv" }


  // ************************************************************************ //
  // Namespace : urn:suvtv
  // ************************************************************************ //
  respuestaInformarAusentes = class(TRemotable)
  private
    FrespuestaID: Integer;
    FrespuestaMensaje: WideString;
    FturnosAusentes: turnosAusentesListaRta;
  public
    destructor Destroy; override;
  published
    property respuestaID: Integer read FrespuestaID write FrespuestaID;
    property respuestaMensaje: WideString read FrespuestaMensaje write FrespuestaMensaje;
    property turnosAusentes: turnosAusentesListaRta read FturnosAusentes write FturnosAusentes;
  end;

  turnosAusentesLista = array of turnosAusentes;   { "urn:suvtv" }

  // ************************************************************************ //
  // Namespace : urn:suvtv
  // soapAction: urn:suvtv#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : suvtvBinding
  // service   : suvtv
  // port      : suvtvPort
  // URL       : http://testing.suvtv.com.ar/service/s_001.php
  // ************************************************************************ //
  suvtvPortType = interface(IInvokable)
  ['{0AF00A44-AA14-CAB7-58F5-FAF68B4E1171}']
    function  eco: respuestaEco; stdcall;
    function  abrirSesion(const usuarioID: Int64; const pantaID: Int64; const usuarioToken: WideString; const usuarioHash: WideString): respuestaAbrirSesion; stdcall;
    function  cerrarSesion(const usuarioID: Int64; const pantaID: Int64; const ingresoID: Int64): respuestaCerrarSesion; stdcall;
    function  informarVerificacion(const usuarioID: Int64; const ingresoID: Int64; const pantaID: Int64; const turnoID: Int64; const formularios: formularios; const tramiteNumero: Int64; const datosPresentante: datosPresentante; const datosVerificacion: datosVerificacion): respuestaInformarVerificacion; stdcall;
    function  solicitarTurnos(const usuarioID: Int64; const ingresoID: Int64; const pantaID: Int64; const tipoConsulta: tipoConsultaTurno; const fechaDesde: String; const fechaHasta: String): respuestaSolicitarTurnos; stdcall;
    function  solicitarTurno(const usuarioID: Int64; const ingresoID: Int64; const pantaID: Int64; const turnoID: Int64; const dominio: WideString): respuestaSolicitarTurnos; stdcall;
    function  informarAusentes(const usuarioID: Int64; const ingresoID: Int64; const pantaID: Int64; const fecha: TXSDate; const turnos: turnosAusentesLista): respuestaInformarAusentes; stdcall;
    function  solicitarTurnoReverificacion(const usuarioID: Int64; const ingresoID: Int64; const pantaID: Int64; const turnoID: Int64; const dominio: WideString): respuestaSolicitarTurnos; stdcall;
  end;

function GetsuvtvPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): suvtvPortType;


implementation

function GetsuvtvPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): suvtvPortType;
const
  defWSDL = 'http://testing.suvtv.com.ar/service/s_001.php?wsdl';
  defURL  = 'http://testing.suvtv.com.ar/service/s_001.php';
  defSvc  = 'suvtv';
  defPrt  = 'suvtvPort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as suvtvPortType);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


destructor respuestaCerrarSesion.Destroy;
begin
  if Assigned(FcierreSesionFecha) then
    FcierreSesionFecha.Free;
  inherited Destroy;
end;

destructor datosPresentante.Destroy;
begin
  if Assigned(FdatosPersonales) then
    FdatosPersonales.Free;
  if Assigned(Fdomicilio) then
    Fdomicilio.Free;
  if Assigned(FdatosContacto) then
    FdatosContacto.Free;
  inherited Destroy;
end;

destructor datosContacto.Destroy;
begin
  if Assigned(FfechaNacimiento) then
    FfechaNacimiento.Free;
  inherited Destroy;
end;

destructor detallesVerificacion.Destroy;
begin
  if Assigned(FmotorVerificacion) then
    FmotorVerificacion.Free;
  if Assigned(FlucesVerificacion) then
    FlucesVerificacion.Free;
  if Assigned(FdireccionVerificacion) then
    FdireccionVerificacion.Free;
  if Assigned(FfrenosVerificacion) then
    FfrenosVerificacion.Free;
  if Assigned(FsuspensionVerificacion) then
    FsuspensionVerificacion.Free;
  if Assigned(FchasisVerificacion) then
    FchasisVerificacion.Free;
  if Assigned(FllantasVerificacion) then
    FllantasVerificacion.Free;
  if Assigned(FneumaticosVerificacion) then
    FneumaticosVerificacion.Free;
  if Assigned(FgeneralVerificacion) then
    FgeneralVerificacion.Free;
  if Assigned(FcontaminacionVerificacion) then
    FcontaminacionVerificacion.Free;
  if Assigned(FseguridadVerificacion) then
    FseguridadVerificacion.Free;
  inherited Destroy;
end;

destructor datosVerificacion.Destroy;
begin
  if Assigned(FfechaVencimiento) then
    FfechaVencimiento.Free;
  if Assigned(FfechaVigencia) then
    FfechaVigencia.Free;
  if Assigned(FfechaEntrada) then
    FfechaEntrada.Free;
  if Assigned(FfechaSalida) then
    FfechaSalida.Free;
  if Assigned(FdetallesVerificacion) then
    FdetallesVerificacion.Free;
  inherited Destroy;
end;

destructor datosContactoTurno.Destroy;
begin
  if Assigned(FdatosPersonalesTurno) then
    FdatosPersonalesTurno.Free;
  if Assigned(FcontactoTurno) then
    FcontactoTurno.Free;
  inherited Destroy;
end;

destructor datosFacturacion.Destroy;
begin
  if Assigned(FdatosPersonales) then
    FdatosPersonales.Free;
  if Assigned(Fdomicilio) then
    Fdomicilio.Free;
  inherited Destroy;
end;

destructor turnosRelacionadosDatos.Destroy;
begin
  if Assigned(FfechaNovedad) then
    FfechaNovedad.Free;
  inherited Destroy;
end;

destructor datosTurno.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FturnosRelacionados)-1 do
    if Assigned(FturnosRelacionados[I]) then
      FturnosRelacionados[I].Free;
  SetLength(FturnosRelacionados, 0);
  if Assigned(FfechaTurno) then
    FfechaTurno.Free;
  if Assigned(FhoraTurno) then
    FhoraTurno.Free;
  if Assigned(FfechaRegistro) then
    FfechaRegistro.Free;
  inherited Destroy;
end;

destructor datosVehiculo.Destroy;
begin
  if Assigned(FnumeroChasis) then
    FnumeroChasis.Free;
  inherited Destroy;
end;

destructor datosPago.Destroy;
begin
  if Assigned(FfechaPago) then
    FfechaPago.Free;
  inherited Destroy;
end;

destructor turnosSolicitados.Destroy;
begin
  if Assigned(FdatosTurno) then
    FdatosTurno.Free;
  if Assigned(FdatosTitular) then
    FdatosTitular.Free;
  if Assigned(FdatosContacto) then
    FdatosContacto.Free;
  if Assigned(FdatosVehiculo) then
    FdatosVehiculo.Free;
  if Assigned(FdatosFacturacion) then
    FdatosFacturacion.Free;
  if Assigned(FdatosPago) then
    FdatosPago.Free;
  inherited Destroy;
end;

destructor respuestaSolicitarTurnos.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Fturnos)-1 do
    if Assigned(Fturnos[I]) then
      Fturnos[I].Free;
  SetLength(Fturnos, 0);
  inherited Destroy;
end;

destructor respuestaInformarAusentes.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FturnosAusentes)-1 do
    if Assigned(FturnosAusentes[I]) then
      FturnosAusentes[I].Free;
  SetLength(FturnosAusentes, 0);
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(suvtvPortType), 'urn:suvtv', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(suvtvPortType), 'urn:suvtv#%operationName%');
  RemClassRegistry.RegisterXSInfo(TypeInfo(genero), 'urn:suvtv', 'genero');
  RemClassRegistry.RegisterXSInfo(TypeInfo(verificacionResultado), 'urn:suvtv', 'verificacionResultado');
  RemClassRegistry.RegisterXSInfo(TypeInfo(tipoConsultaTurno), 'urn:suvtv', 'tipoConsultaTurno');
  RemClassRegistry.RegisterXSInfo(TypeInfo(tipoTurno), 'urn:suvtv', 'tipoTurno');
  RemClassRegistry.RegisterXSInfo(TypeInfo(condicionIva), 'urn:suvtv', 'condicionIva');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(condicionIva), 'R2', 'R');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(condicionIva), 'C2', 'C');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(condicionIva), 'M2', 'M');
  RemClassRegistry.RegisterXSInfo(TypeInfo(estadoLiquidacion), 'urn:suvtv', 'estadoLiquidacion');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(estadoLiquidacion), 'N2', 'N');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(estadoLiquidacion), 'A2', 'A');
  RemClassRegistry.RegisterXSClass(respuestaEco, 'urn:suvtv', 'respuestaEco');
  RemClassRegistry.RegisterXSClass(respuestaAbrirSesion, 'urn:suvtv', 'respuestaAbrirSesion');
  RemClassRegistry.RegisterXSClass(respuestaCerrarSesion, 'urn:suvtv', 'respuestaCerrarSesion');
  RemClassRegistry.RegisterXSInfo(TypeInfo(formularios), 'urn:suvtv', 'formularios');
  RemClassRegistry.RegisterXSClass(datosPersonales, 'urn:suvtv', 'datosPersonales');
  RemClassRegistry.RegisterXSClass(domicilio, 'urn:suvtv', 'domicilio');
  RemClassRegistry.RegisterXSClass(datosContactoPresentante, 'urn:suvtv', 'datosContactoPresentante');
  RemClassRegistry.RegisterXSClass(datosPresentante, 'urn:suvtv', 'datosPresentante');
  RemClassRegistry.RegisterXSClass(datosContacto, 'urn:suvtv', 'datosContacto');
  RemClassRegistry.RegisterXSClass(resultadoVerificacion, 'urn:suvtv', 'resultadoVerificacion');
  RemClassRegistry.RegisterXSClass(detallesVerificacion, 'urn:suvtv', 'detallesVerificacion');
  RemClassRegistry.RegisterXSClass(datosVerificacion, 'urn:suvtv', 'datosVerificacion');
  RemClassRegistry.RegisterXSClass(respuestaInformarVerificacion, 'urn:suvtv', 'respuestaInformarVerificacion');
  RemClassRegistry.RegisterXSClass(datosContactoTurno, 'urn:suvtv', 'datosContactoTurno');
  RemClassRegistry.RegisterXSClass(datosFacturacion, 'urn:suvtv', 'datosFacturacion');
  RemClassRegistry.RegisterXSClass(turnosRelacionadosDatos, 'urn:suvtv', 'turnosRelacionadosDatos');
  RemClassRegistry.RegisterXSInfo(TypeInfo(turnosRelacionados), 'urn:suvtv', 'turnosRelacionados');
  RemClassRegistry.RegisterXSClass(datosTurno, 'urn:suvtv', 'datosTurno');
  RemClassRegistry.RegisterXSClass(chasis, 'urn:suvtv', 'chasis');
  RemClassRegistry.RegisterXSClass(datosVehiculo, 'urn:suvtv', 'datosVehiculo');
  RemClassRegistry.RegisterXSClass(datosPago, 'urn:suvtv', 'datosPago');
  RemClassRegistry.RegisterXSClass(turnosSolicitados, 'urn:suvtv', 'turnosSolicitados');
  RemClassRegistry.RegisterXSInfo(TypeInfo(turnosSolicitadosLista), 'urn:suvtv', 'turnosSolicitadosLista');
  RemClassRegistry.RegisterXSClass(respuestaSolicitarTurnos, 'urn:suvtv', 'respuestaSolicitarTurnos');
  RemClassRegistry.RegisterXSClass(turnosAusentes, 'urn:suvtv', 'turnosAusentes');
  RemClassRegistry.RegisterXSClass(rtaInformarAusentes, 'urn:suvtv', 'rtaInformarAusentes');
  RemClassRegistry.RegisterXSInfo(TypeInfo(turnosAusentesListaRta), 'urn:suvtv', 'turnosAusentesListaRta');
  RemClassRegistry.RegisterXSClass(respuestaInformarAusentes, 'urn:suvtv', 'respuestaInformarAusentes');
  RemClassRegistry.RegisterXSInfo(TypeInfo(turnosAusentesLista), 'urn:suvtv', 'turnosAusentesLista');

end. 