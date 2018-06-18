unit epagos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, dateutils,
  Dialogs, StdCtrls, Grids, DBGrids, DB, Buttons, ExtCtrls,math, xmldom, XMLIntf, IniFiles,
  msxmldom, XMLDoc,  oxmldom,  ComObj, MSXML, InvokeRegistry, Rio, SOAPHTTPClient,
   SQLEXPR, DBXpress, Provider, dbclient,  ADODB,USuperRegistry,UVERSION;

   Threadvar
       MyBD : TSqlConnection;
       MyBD_test:TSqlConnection;
       BDAG: TSQLConnection;
       TD: TTransactionDesc;
       BDPADRON : TSqlConnection;

type
TePagos= class
PROTECTED
  HTTPRIO: THTTPRIO;
  XMLDocument: TXMLDocument;
  XmlNode: IXMLNode;
  NodeText: string;
  AttrNode: IXMLNode;
  id_organismo:longint;
  id_usuario:longint;
  password:string;
  hash:string;
  token:string;
  TESTING_CONEX:boolean;

  Procedure CargarINI;
  function  configura_http:boolean;
  FUNCTION CONFIGURAR:BOOLEAN;
  function Envia_y_Recibo_xml(sxml:string;archivo_formato_xml_devuelto:string):string;
  Procedure Procesar_xml(arhivo_xml:string) ;
  function EjecutarYEsperar( sPrograma: String; Visibilidad: Integer ): Integer;
public
  Constructor Create;
  function obtener_token:boolean;
  function obtener_pago:boolean;
  function obtener_entidades:boolean;
  Property ver_id_organismo:longint read id_organismo;
  Property ver_id_usuario:longint read id_usuario;
  Property ver_password:string read password;
  Property ver_hash:string read hash;
  Property ver_token:string read token;
  Property ver_TESTING_CONEX:boolean read TESTING_CONEX;

END;



implementation
Constructor TePagos.Create;
begin
CONFIGURAR;

end;

function  TePagos.Envia_y_Recibo_xml(sxml:string;archivo_formato_xml_devuelto:string):string;
var
    err, str,nombrefile: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
    MyText: TStringlist;
begin
nombrefile:=ExtractFilePath(Application.ExeName) +'Pedido_token.xml';
strings := TStringList.Create;
strings.Text := sxml;
request := TStringStream.Create(strings.GetText);
response := TStringStream.Create('');
strings.SaveToFile(nombrefile);
recieveID :=HTTPRIO.HTTPWebNode.Send(request);           //Request
HTTPRIO.HTTPWebNode.Receive(recieveID,response,false);    //Response
response.Position := 0;
MyText:= TStringlist.create;
MyText.LoadFromStream(response);
nombrefile:=ExtractFilePath(Application.ExeName) +trim(archivo_formato_xml_devuelto);
MyText.SaveToFile(ExtractFilePath(Application.ExeName)    +'archivo_xml.xml');
MyText.SaveToFile(nombrefile);
MyText.Free;
strings.Free;
request.Free;
response.Free;


Envia_y_Recibo_xml:=trim(nombrefile);

end;

function TePagos.obtener_pago:boolean;
var sxml,archivo:string;

begin

sxml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:nus="http://localhost/nusoap">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<nus:obtener_pagos soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<version xsi:type="xsd:string">?</version>'+
         '<credenciales xsi:type="nus:DatosCredencialesPago">'+
            '<id_organismo xsi:type="xsd:int">'+inttostr(self.ver_id_organismo)+'</id_organismo>'+
            '<token xsi:type="xsd:string">'+trim(self.ver_token)+'</token>'+
         '</credenciales>'+
         '<pago xsi:type="nus:DatosPago">'+
            '<CodigoUnicoTransaccion xsi:type="xsd:int">?</CodigoUnicoTransaccion>'+
            '<ExternoId xsi:type="xsd:int">?</ExternoId>'+
            '<FechaPagoDesde xsi:type="xsd:date">?</FechaPagoDesde>'+
            '<FechaPagoHasta xsi:type="xsd:date">?</FechaPagoHasta>'+
            '<FechaAcreditacionDesde xsi:type="xsd:date">?</FechaAcreditacionDesde>'+
            '<FechaAcreditacionHasta xsi:type="xsd:date">?</FechaAcreditacionHasta>'+
            '<Estado xsi:type="xsd:string">?</Estado>'+
         '</pago>'+
      '</nus:obtener_pagos>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';


archivo:=Envia_y_Recibo_xml(sxml,'E_pagos.xml');
Procesar_xml(archivo);

//LeerArchivoAbrir;

end;

function TePagos.obtener_entidades:boolean;
var sxml,archivo:string;

begin
{
sxml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:nus="http://localhost/nusoap" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<nus:obtener_entidades_pago soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
         '<version xsi:type="xsd:string">?</version>
         '<credenciales xsi:type="nus:DatosCredencialesPago">'
            '<id_organismo xsi:type="xsd:int">?</id_organismo>'
            '<token xsi:type="xsd:string">?</token>'
         '</credenciales>'
         '<fp xsi:type="nus:ArrayOfInt" soapenc:arrayType="xsd:int[]"/>'
      '</nus:obtener_entidades_pago>'
   '</soapenv:Body>'
'</soapenv:Envelope>'
   }

archivo:=Envia_y_Recibo_xml(sxml,'E_pagos.xml');
Procesar_xml(archivo);

//LeerArchivoAbrir;

end;

function TePagos.obtener_token:boolean;
var sxml,archivo:string;

begin

sxml:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:nus="http://localhost/nusoap">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<nus:obtener_token soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+
         '<version xsi:type="xsd:string">?</version>'+
         '<credenciales xsi:type="nus:DatosCredenciales">'+
            '<id_organismo xsi:type="xsd:int">'+inttostr(ver_id_organismo)+'</id_organismo>'+
            '<id_usuario xsi:type="xsd:string">'+inttostr(ver_id_usuario)+'</id_usuario>'+
            '<password xsi:type="xsd:string">'+trim(ver_password)+'</password>'+
            '<hash xsi:type="xsd:string">'+trim(ver_hash)+'</hash>'+
         '</credenciales>'+
      '</nus:obtener_token>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';


archivo:=Envia_y_Recibo_xml(sxml,'E_token.xml');
Procesar_xml(archivo);

//LeerArchivoAbrir;

end;

 function TePagos.EjecutarYEsperar( sPrograma: String; Visibilidad: Integer ): Integer;
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

  // Espera hasta que termina la ejecución
  repeat
    iCodigoSalida := WaitForSingleObject( InformacionProceso.hProcess, 1000 );
    Application.ProcessMessages;
  until ( iCodigoSalida <> WAIT_TIMEOUT );

  GetExitCodeProcess( InformacionProceso.hProcess, iResultado );
  MessageBeep( 0 );
  CloseHandle( InformacionProceso.hProcess );
  Result := iResultado;
end;




 Procedure TePagos.Procesar_xml(arhivo_xml:string) ;
var
I: Integer;
XmlNode: IXMLNode;
nodeText: string;
AttrNode: IXMLNode;
ARCHIVOPROCESO1:TEXTFILE;
begin
  {carga xml en el componente para realizar parseo}
  XMLDocument.LoadFromFile(arhivo_xml);

  {parsea el xml para su lectura}
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
  //LEER_TAGS_ARCHIVO_XML_PAGOS_ver2(ExtractFilePath(Application.ExeName)+'parseado.txt',ARCHIVO);

end;




function TePagos.configura_http:boolean;
var
    TESTING:boolean;

  defWSDL:string;
  defURL :string;
  defSvc:string;
  defPrt,xml:string;
begin
TRY
IF ver_TESTING_CONEX=TRUE THEN  //epagos
 BEGIN
  defWSDL:= 'https://sandbox.epagos.com.ar/devel/api/wsdl/index.php?wsdl';
  defURL := 'https://sandbox.epagos.com.ar/devel/api/wsdl/index.php';
  defSvc:= 'EPagos';
  defPrt:= 'EPagosPort';

 END ELSE BEGIN
   defWSDL:= 'https://sandbox.epagos.com.ar/devel/api/wsdl/index.php?wsdl';
  defURL := 'https://sandbox.epagos.com.ar/devel/api/wsdl/index.php';
 { defWSDL:= 'https://sandbox.epagos.com.ar/wsdl/index.php?wsdl';
  defURL := 'https://sandbox.epagos.com.ar/wsdl/index.php'; }
  defSvc:= 'EPagos';
  defPrt:= 'EPagosPort';
  
  end;

  HTTPRIO.WSDLLocation:=defWSDL;
  HTTPRIO.Service:=defSvc;
  HTTPRIO.Port:=defPrt;
  HTTPRIO.URL:=defURL;
  HTTPRIO.HTTPWebNode.SoapAction := defURL;

 EXCEPT
 on E : Exception do
   BEGIN

    //TRAZAS('ERROR AL CONFIGURAR EL PROTOCOLO HTTP. '+E.ClassName+'. error : '+E.Message);
   END;

END;

end;


FUNCTION TePagos.CONFIGURAR:BOOLEAN;
BEGIN
 XMLDocument:=TXMLDocument.Create(APPLICATION);
 CargarINI;

  HTTPRIO:=THTTPRIO.Create(application);
  configura_http;
END;


Procedure TePagos.CargarINI;
var INI: TIniFile;
T:sTRING;
begin
TRY
  if not FileExists( ExtractFilePath( Application.ExeName ) + 'config.ini' ) then
    Exit;

    INI := TINIFile.Create( ExtractFilePath( Application.ExeName ) + 'config.ini' );

    id_organismo:=INI.ReadInteger( 'EPAGOS', 'id_organismo', 0 );
    id_usuario:=INI.ReadInteger( 'EPAGOS', 'id_usuario', 0 );
    password:=INI.ReadString( 'EPAGOS', 'password', 'APPLUS' );
    hash:=INI.ReadString( 'EPAGOS', 'hash', 'APPLUS' );
    TESTING_CONEX:=FALSe;


  INI.Free;
EXCEPT
 on E : Exception do
   BEGIN

    //TRAZAS('ERROR AL LEER EL ARCHIVO DE CONFIGURACION CONFIG.INI. '+E.ClassName+'. error : '+E.Message);
   END;

END;

end;
end.
