unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls,inifiles, DB, ADODB, FMTBcd, SqlExpr, USuperRegistry,
   DBXpress, Provider, dbclient, DBCtrls, ExtCtrls, RXShell, Menus,
  InvokeRegistry, Rio, SOAPHTTPClient;

   Threadvar
       MyBD : TSqlConnection;
       MyBD_test:TSqlConnection;
       BDAG: TSQLConnection;
       TD: TTransactionDesc;
       BDPADRON : TSqlConnection;

        const

        {$IFDEF INTEVE}
        APPLICATION_NAME = 'SATELITE';
        COMPANY_NAME = 'DHRMA';
        {$ELSE}
        APPLICATION_NAME = 'SAGVTV';
        COMPANY_NAME = 'SAGURUGUAY';
        {$ENDIF}

        SO_WINNT = '4.0';
        SO_WIN2000 = '5.0';
        SO_WINXP = '5.1';
        SO_WIN2003 = '5.2';

        VERSION_KEY = 'SOFTWARE\Microsoft\Windows NT\CurrentVersion\';

        APPLICATION_KEY = '\SOFTWARE\WOW6432Node\'+COMPANY_NAME+'\'+APPLICATION_NAME;
        APPLICATION_KEY_SQL = APPLICATION_KEY+'\BD_SQL';
        APPLICATION_KEY_turno = APPLICATION_KEY+'\BD_SQL';
        BD_KEY = APPLICATION_KEY+'\BD';

       HORA_EEJCUTAR='07:00:00';
type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    Button1: TButton;
    Proc: TADOStoredProc;
    ADOCommand1: TADOCommand;
    Timer1: TTimer;
    PopupMenu1: TPopupMenu;
    Ocultar1: TMenuItem;
    Mostrar1: TMenuItem;
    RxTrayIcon1: TRxTrayIcon;
    Button2: TButton;
    BuscarPatente: TEdit;
    Buscar: TButton;
    Label1: TLabel;
    //HTTPRIO1: THTTPRIO;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Ocultar1Click(Sender: TObject);
    procedure Mostrar1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BuscarClick(Sender: TObject);
  private
    { Private declarations }
     PaisISO:string;
Registro:string;
Matricula:string;
TipoVehiculoId:string;
TipoFlota:string;
Padron :string;
AnioFiscal:string;
MarcaMotorId:string;
ModeloMotorId:string;
NumeroMotor :string;
TipoCombustibleId:string;
MarcaChasisId:string;
ModeloChasisId:string;
NumeroChasis:string;
CantidadEjes:string;
Largoveh:string;
Alto:string;
Ancho:string;
Tara :string;
TipoSuspensionId:string;
TipoITVId :string;
ExpedicionITV:string;
VencimientoITV :string;
TipoInspeccionITVId :string;
NumeroITV :string;
NumeroObleaITV  :string;
TipoPNCId  :string;
VencimientoPNC :string;
CodigoUsuario :string;
RUTUsuario :string;
NombreUsuario :string;
LonguitudEnganche,Profesional:string;
MercanciaPeligrosa :string;
TipoCabinaId :string;
TipoCajaCargaId:string;
TipoAditamentoId :string;
CabinaMejorada :string;
MarcaCarroceriaId:string;
ModeloCarroceriaId:string;
CantidadAsientos:string;
TipoAsientoId :string;
TieneBano  :string;
CantidadPuertas :string;
TipoRegistradorEventosId :string;
TipoBodegaId :string;
TipoServicioId :string;
TipoSubServicioId :string;
TieneAire :string;
 function limpiar_variables:boolean;
  public
    { Public declarations }
    se_conector:BOOLEAN;
    centro:STRING;
    CITAS_CONECT:BOOLEAN;
    NOMPLANTA:STRING;
    ARCHIVO_LOG:STRING;
    procedure TestOfBD(Alias, UserName, Password: String; Ageva: boolean);
    function conexion_virtual(base:string):boolean;
    function ENVIAR_A_WEB_TURNOS(turnoidhasta:longint;plantapasa:longint):BOOLEAN;
    function GUARDA_LOG(MENSAJE:STRING):BOOLEAN;
    procedure EJECUTAR;
    Procedure DoCompletarDatos(PATENTE:String);
    Procedure DoCompletarDatosTURNO(PATENTE:STRING;TURNOID:Longint);
    Procedure WSDATOSPADRON(PaisISO,Registro,Matricula,TipoVehiculoId,TipoFlota,Padron,AnioFiscal,MarcaMotorId,ModeloMotorId,NumeroMotor,
                            TipoCombustibleId,MarcaChasisId,ModeloChasisId,NumeroChasis,CantidadEjes,Largoveh,Alto,Ancho,Tara,TipoSuspensionId,TipoITVId,
                            ExpedicionITV,VencimientoITV,TipoInspeccionITVId,NumeroITV,NumeroObleaITV,TipoPNCId,VencimientoPNC,CodigoUsuario,
                            RUTUsuario,NombreUsuario,LonguitudEnganche,MercanciaPeligrosa,TipoCabinaId,TipoCajaCargaId,TipoAditamentoId,CabinaMejorada,
                            MarcaCarroceriaId,ModeloCarroceriaId,CantidadAsientos,TipoAsientoId,TieneBano,CantidadPuertas,TipoRegistradorEventosId,
                            TipoBodegaId,TipoServicioId,TipoSubServicioId,TieneAire,Profesional:STRING);
    Function WEBSERVICES_EMTO(PATENTE:String):boolean;
    FUNCTION LEER_XML_CONSULTA(ARCHIVO:STRING):BOOLEAN;
    FUNCTION ACTUALIZAR_CAMPO_IMPORTADO(IDTURNO:LONGINT):boolean;
    Procedure InsertaVehiculoNoMTOP(PATENTE:STRING;TIPO_VEHICULO:LONGINT);
  end;

var
  Form1: TForm1;

implementation

uses Umodulo;

{$R *.dfm}

procedure TForm1.TestOfBD(Alias, UserName, Password: String; Ageva: boolean);
    var
        DBAlias, DBUserName, DBPassword,
        DBDriverName, DBLibraryName, DBVendorLib, DBGetDriverFunc: String;
    const
  coEnableBCD = TSQLConnectionOption(102); // boolean
    begin
    se_conector:=false;
        with TSuperRegistry.Create do
        try
            RootKey := HKEY_LOCAL_MACHINE;

                if not OpenKeyRead(BD_KEY)
            then
            BEGIN  Application.MessageBox( pchar('No se pudo conectar con la base de datos por: Error de REgistro'),
         'Acceso denegado', MB_ICONSTOP );
          END  else begin
                try

                    If Alias=''
                    then
                        DBAlias := ReadString('Alias')
                    Else
                        DBAlias:=Alias;

                    If UserName=''
                    then
                        DBUserName := ReadString('User')
                    else
                        DBUserName:=UserName;

                    If Password=''
                    then
                        DBPassword:= ReadString('Password')
                    else
                        DBPassword:=Password;


                    DBDriverName := ReadString('DriverName');
                    DBLibraryName := ReadString('LibraryName');
                    DBVendorLib := ReadString('VendorLib');
                    DBGetDriverFunc := ReadString('GetDriverFunc');

                except
                       // FORM1.memo1.Lines.Add('No se encontró en el registro algún parámetro necesario para la conexión a la base de datos');
                       APPLICATION.ProcessMessages;

                    //mensaje:='No se encontró en el registro algún parámetro necesario para la conexión a la base de datos';
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
                   se_conector:=true;
                except
                      on E: Exception do
                      BEGIN
                        se_conector:=false;
                         GUARDA_LOG(DATETOSTR(DATE)+'-'+TIMETOSTR(TIME)+'-No se pudo conectar con la base DE DATOS ORACLE '+ALIAS+'  por: ' + E.message)

                      END;
                end;
           END;
          
        finally
            Free;
        end;

    end;

FUNCTION TForm1.GUARDA_LOG(MENSAJE:STRING):BOOLEAN;
VAR LOG:TEXTFILE;LINK:STRING;

BEGIN
link:= ExtractFilePath( Application.ExeName )  + ARCHIVO_LOG;
assignfile(LOG,link);

if fileexists(link)=false then
rewrite(LOG);
 append(LOG);
 WRITELN(LOG,MENSAJE);
 CLOSEFILE(LOG);
END;

procedure TForm1.EJECUTAR;
VAR
BASE,alias,userbd,password:STRING;
link:string;
LOG:textfile;
FE:STRING;
TURNOID,planta:longint;

begin
FE:=COPY(DATETOSTR(DATE),1,2)+COPY(DATETOSTR(DATE),4,2)+COPY(DATETOSTR(DATE),7,4);
ARCHIVO_LOG:='LOG_'+FE+'.txt';
link:= ExtractFilePath( Application.ExeName ) + ARCHIVO_LOG;
assignfile(LOG,link);
REWRITE(LOG);
closefile(log);

with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(APPLICATION_KEY) then
      Begin
        BASE:=ReadString('Base_Centro');
      end;
  Finally
    free;
  end;

conexion_virtual('db_web_uruguay');
IF CITAS_CONECT=TRUE THEN
BEGIN

   begin
     MEMO1.Clear;
     NOMPLANTA:=IntToStr(Planta);
     userbd:='SAGURUGUAY';
     password:='02lusabaqui03';
     TestOfBD(alias,userbd,password,false);

     if se_conector=true then

      BEGIN
        form1.Caption:='CONECTADO A '+ userbd;
        memo1.Lines.Add('CONECTADO A: '+ userbd);
        FORM1.HiNT:='CONECTADO A '+ userbd;
        RxTrayIcon1.HiNT:='CONECTADO A '+ userbd;
        APPLICATION.ProcessMessages;

        {busco en la base oracle el ultimo TURNOID}
        with tsqlQuery.Create(nil) do
        try
          SQLConnection:= MYBD;
          SQL.Add('SELECT DISTINCT MAX(TURNOID) FROM TDATOSTURNO WHERE TURNOID NOT LIKE ''%-%'' and planta ='+inttostr(planta));
          Open;
          TURNOID:=fields[0].AsInteger;

       finally
         close;
         free;
       end;

        planta:=STRTOINT(centro);
        ENVIAR_A_WEB_TURNOS(TURNOID,Planta);
        END else
        begin
        
        end;

   mybd.Close;
end;

modulo.conexion.Close;

END;

end;
FUNCTION TFORM1.ACTUALIZAR_CAMPO_IMPORTADO(IDTURNO:LONGINT):boolean;
BEGIN
modulo.conexion.BeginTrans;
try
modulo.query_actualiza.Close;
modulo.query_actualiza.SQL.Clear;
modulo.query_actualiza.SQL.Add('update reserva set importado=''S'' where numero='+inttostr(IDTURNO));
modulo.query_actualiza.ExecSQL;
modulo.conexion.CommitTrans;
except
modulo.conexion.RollbackTrans;
end;

END;

FUNCTION TFORM1.ENVIAR_A_WEB_TURNOS(turnoidhasta:longint;plantapasa:longint):BOOLEAN;
var sqloracle,sqloracle2,sqloracle3:string;

CENTRO:string;
TURNOID,ESTADOID,DEPARTAMENTAL,TIPO_VEHICULO:longint;
PATENTE,ESTADODESC,TIPOTURNO,vDEPARTAMENTAL:string;
TITULARNOMBRE,TITULARAPELLIDO,TELEFONO,EMAIL,TIPO_DOCUMENTO:string;
TIPOINSPE,FECHATURNO,HORATURNO,FECHANOVEDAD,FECHALTA,NRO_DOCUMENTO:string;
DOMICILIO_CALLE,DOMICILIO_NUMERO,DOMICILIO_CIUDAD,DOMICILIO_DEPARTAMENTO:STRING;
Existe,ExisteClienPadron,ExisteVehicPadron:Longint;

BEGIN

{Reserva como turno vigente al insertar en tdatosturno}
//ESTADOID:=1;
//ESTADODESC:='Vigente';

 {Tomar los datos de la tabla reservas del SQL}
        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;
        modulo.QUERY_WEB.SQL.Add('SELECT '+
                                 'numero AS TURNOID '+
                                 ',centro AS PLANTA '+
                                 ',fecha AS FECHATURNO '+
                                 ',RTRIM(LTRIM(patente)) AS DVDOMINO '+
                                 ',CASE WHEN RTRIM(LTRIM(nombre)) IS NULL or RTRIM(LTRIM(nombre)) = '' '' THEN ''A'' ELSE RTRIM(LTRIM(nombre)) END TITULARNOMBRE '+
                                 ',CASE WHEN RTRIM(LTRIM(apellido)) IS NULL or RTRIM(LTRIM(apellido)) = '' '' THEN ''A'' ELSE RTRIM(LTRIM(apellido)) END TITULARAPELLIDO '+
                                 ',CASE WHEN RTRIM(LTRIM(email)) IS NULL or RTRIM(LTRIM(email)) = '' '' THEN ''a@a.com'' ELSE RTRIM(LTRIM(email)) END CONTACTOEMAIL '+
                                 //',tipo_insp AS TIPOINSPE '+
                                 ',CASE WHEN RTRIM(LTRIM(telefono)) IS NULL or RTRIM(LTRIM(telefono)) = '' '' THEN ''0'' ELSE RTRIM(LTRIM(telefono)) END CONTACTOTELEFONO '+
                                 ',CASE WHEN RTRIM(LTRIM(hora)) IS NULL or RTRIM(LTRIM(hora)) = '' '' THEN ''00:00'' ELSE RTRIM(LTRIM(hora)) END HORATURNO '+
                                 ',replace(CONVERT(DATE,FECHALTA,103),''-'',''/'') AS FECHALTA '+
                                 ',CENTRO '+
                                 ',RTRIM(LTRIM(TIPO_DOCUMENTO)) TIPO_DOCUMENTO '+
                                 ',RTRIM(LTRIM(NRO_DOCUMENTO)) NRO_DOCUMENTO '+
                                 ',CASE WHEN RTRIM(LTRIM(DOMICILIO_CALLE)) IS NULL or RTRIM(LTRIM(DOMICILIO_CALLE)) = '' '' THEN ''X'' ELSE RTRIM(LTRIM(DOMICILIO_CALLE)) END DOMICILIO_CALLE '+
                                 ',CASE WHEN RTRIM(LTRIM(DOMICILIO_NUMERO)) IS NULL or RTRIM(LTRIM(DOMICILIO_NUMERO)) = '' '' THEN ''0'' ELSE RTRIM(LTRIM(DOMICILIO_NUMERO)) END DOMICILIO_NUMERO '+
                                 ',CASE WHEN RTRIM(LTRIM(DOMICILIO_CIUDAD)) IS NULL or RTRIM(LTRIM(DOMICILIO_CIUDAD)) = '' '' THEN ''X'' ELSE RTRIM(LTRIM(DOMICILIO_CIUDAD)) END DOMICILIO_CIUDAD '+
                                 ',CASE WHEN RTRIM(LTRIM(DOMICILIO_DEPARTAMENTO)) IS NULL or RTRIM(LTRIM(DOMICILIO_DEPARTAMENTO)) = '' '' THEN ''X'' ELSE RTRIM(LTRIM(DOMICILIO_DEPARTAMENTO)) END DOMICILIO_DEPARTAMENTO '+
                                 ',es_departamental '+
                                 ',TIPO_VEHICULO '+
                                 ',codestado '+
                                 'FROM RESERVA '+
                                 //'WHERE NUMERO > '+inttostr(turnoidhasta)+
                                 ' WHERE importado=''N'' '+
                                 ' AND CENTRO = '+inttostr(plantapasa)+
                                 ' ORDER BY numero');
        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.Open;

        WHILE NOT modulo.QUERY_WEB.Eof DO

        BEGIN
        CENTRO:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('CENTRO').ASSTRING); //plantapasa;
        TURNOID:=modulo.QUERY_WEB.FIELDBYNAME('TURNOID').ASINTEGER;
        PATENTE:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('DVDOMINO').ASSTRING);
        FECHATURNO:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('FECHATURNO').ASSTRING);
        TIPO_DOCUMENTO:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('TIPO_DOCUMENTO').ASSTRING);
        NRO_DOCUMENTO:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('NRO_DOCUMENTO').ASSTRING);
        TITULARNOMBRE:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('TITULARNOMBRE').ASSTRING);
        TITULARAPELLIDO:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('TITULARAPELLIDO').ASSTRING);
        EMAIL:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('CONTACTOEMAIL').ASSTRING);
        //TIPOINSPE:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('TIPOINSPE').ASSTRING);
        TELEFONO:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('CONTACTOTELEFONO').ASSTRING);
        HORATURNO:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('HORATURNO').ASSTRING);
        FECHALTA:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('FECHALTA').ASSTRING);
        DEPARTAMENTAL:=modulo.QUERY_WEB.FIELDBYNAME('es_departamental').ASINTEGER;
        TIPO_VEHICULO:=modulo.QUERY_WEB.FIELDBYNAME('TIPO_VEHICULO').ASINTEGER;
        ESTADOID:=modulo.QUERY_WEB.FIELDBYNAME('codestado').ASINTEGER;

        IF ESTADOID = 1 THEN BEGIN
           ESTADODESC:='Vigente';
        END ELSE
        IF ESTADOID = 2 THEN BEGIN
           ESTADODESC:='Cancelado';
        END;

        DOMICILIO_CALLE:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('DOMICILIO_CALLE').ASSTRING);
        DOMICILIO_NUMERO:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('DOMICILIO_NUMERO').ASSTRING);
        DOMICILIO_CIUDAD:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('DOMICILIO_CIUDAD').ASSTRING);
        DOMICILIO_DEPARTAMENTO:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('DOMICILIO_DEPARTAMENTO').ASSTRING);

        IF DEPARTAMENTAL = 0 THEN BEGIN
           vDEPARTAMENTAL := 'N';
        END ELSE BEGIN
           vDEPARTAMENTAL := 'S';
        END;
        
        {Consulto si las reservas web existen en tdatosturno}
       with tsqlQuery.Create(nil) do
        try
          SQLConnection:= MYBD;
          SQL.Add('select count(*) from TDATOSTURNO where planta='+#39+TRIM(CENTRO)+#39+' and TURNOID='+inttostr(TURNOID));
          Open;
          Existe:=fields[0].ASInteger;
       finally
         close;
         free;
       end;

       {Consulto si EXISTE EL CLIENTE EN PADRONCLIEN} {
       with tsqlQuery.Create(nil) do
        try
          SQLConnection:= MYBD;
          SQL.Add('select count(*) from padronclien where trim(rut)='+#39+TRIM(NRO_DOCUMENTO)+#39);
          Open;
          ExisteClienPadron:=fields[0].ASInteger;
       finally
         close;
         free;
       end;

       {Consulto si EXISTE EL VEHICULO EN PADRONVEHIC} {
       with tsqlQuery.Create(nil) do
        try
          SQLConnection:= MYBD;
          SQL.Add('select count(*) from padronvehic where trim(vehmat)='+#39+TRIM(PATENTE)+#39);
          Open;
          ExisteVehicPadron:=fields[0].ASInteger;
       finally
         close;
         free;
       end;

       {Fecha que se inserta el turno a la tabla}
       with tsqlQuery.Create(nil) do
        try
          SQLConnection:= MYBD;
          SQL.Add('select TO_DATE(SYSDATE,''DD/MM/YYYY'') from DUAL');
          Open;
          FECHANOVEDAD:=fields[0].AsString;
       finally
         close;
         free;
       end;

         {Insertar los datos de la tabla reserva del SQL a la tabla tdatosturnos del Oracle}
         if Existe=0 then
           begin
                 sqloracle:='INSERT INTO TDATOSTURNO (TURNOID,FECHATURNO,HORATURNO,FECHAREGISTRO,TTULARTIPODOCUMENTO,TITULARNRODOCUMENTO, '+
                            ' TITULARNOMBRE,TITULARAPELLIDO,CONTACTOTELEFONO,CONTACTOEMAIL,DVDOMINO,PLANTA,ESTADOID,ESTADODESC,FECHANOVEDAD, INFORMADOWS) '+
                            ' VALUES ('+
                            ''+INTTOSTR(TURNOID)+
                            ',TO_DATE('+#39+TRIM(FECHATURNO)+#39+',''DD/MM/YYYY'')'+
                            ','+#39+TRIM(HORATURNO)+#39+
                            ',TO_DATE('+#39+TRIM(FECHANOVEDAD)+#39+',''DD/MM/YYYY'')'+
                            ','+#39+TRIM(TIPO_DOCUMENTO)+#39+
                            ','+#39+TRIM(NRO_DOCUMENTO)+#39+
                            ','+#39+TRIM(TITULARNOMBRE)+#39+
                            ','+#39+TRIM(TITULARAPELLIDO)+#39+
                            ','+#39+TRIM(TELEFONO)+#39+
                            ','+#39+TRIM(EMAIL)+#39+
                            ','+#39+TRIM(PATENTE)+#39+
                            ','+#39+TRIM(CENTRO)+#39+
                            ','+INTTOSTR(ESTADOID)+
                            ','+#39+TRIM(ESTADODESC)+#39+
                            ',TO_DATE('+#39+TRIM(FECHANOVEDAD)+#39+',''DD/MM/YYYY'')'+
                            ','+#39+TRIM(vDEPARTAMENTAL)+#39+
                            ')';
                end else begin
                MEMO1.Lines.Add('Ya existe el Turno: '+INTTOSTR(TURNOID));
                RxTrayIcon1.HiNT:='Ya existe el Turno: '+INTTOSTR(TURNOID);
                APPLICATION.ProcessMessages;
                end;

          IF (ExisteClienPadron=0) then
             BEGIN
             sqloracle2:='INSERT INTO PADRONCLIEN (RAZONSOCIAL,RUT,DEPARTAMENTO,CIUDAD,CALLE,NUMERO,MAIL,TELEFONO) '+
                            ' VALUES ('+
                            ''+#39+TRIM(TITULARNOMBRE)+#39+
                            ','+#39+TRIM(NRO_DOCUMENTO)+#39+
                            ','+#39+TRIM(DOMICILIO_DEPARTAMENTO)+#39+
                            ','+#39+TRIM(DOMICILIO_CIUDAD)+#39+
                            ','+#39+TRIM(DOMICILIO_CALLE)+#39+
                            ','+#39+TRIM(DOMICILIO_NUMERO)+#39+
                            ','+#39+TRIM(EMAIL)+#39+
                            ','+#39+TRIM(TELEFONO)+#39+
                            ')';

             end else begin
               MEMO1.Lines.Add('Ya existe Cliente en Padron: '+TRIM(NRO_DOCUMENTO));
               RxTrayIcon1.HiNT:='Ya existe Cliente en Padron: '+TRIM(NRO_DOCUMENTO);
               APPLICATION.ProcessMessages;
             END;
          {
          IF (ExisteVehicPadron=0) then
             BEGIN
             sqloracle3:='INSERT INTO PADRONVEHIC (VEHMAT) '+
                         ' VALUES ('+#39+TRIM(PATENTE)+#39+')';

             end else begin
               MEMO1.Lines.Add('Ya existe Vehiculo en Padron: '+TRIM(PATENTE));
               RxTrayIcon1.HiNT:='Ya existe Vehiculo en Padron: '+TRIM(PATENTE);
               APPLICATION.ProcessMessages;
             END;
           }

          if Existe=0 then
           with tsqlQuery.Create(nil) do
            try
                SQLConnection:= MYBD;
                MEMO1.Lines.Add('DESCARGANDO TURNO: '+INTTOSTR(TURNOID));
                application.ProcessMessages;

                RxTrayIcon1.HiNT:='DESCARGANDO TURNO: '+INTTOSTR(TURNOID);
                APPLICATION.ProcessMessages;
                SQL.Clear;
                SQL.Add(sqloracle);
                ExecSQL;
                MEMO1.Lines.Add('TURNO DESCARGADO: OK');
                APPLICATION.ProcessMessages;
                ACTUALIZAR_CAMPO_IMPORTADO(TURNOID);
          {
          if ExisteClienPadron=0 then
           with tsqlQuery.Create(nil) do
            try
                SQLConnection:= MYBD;
                MEMO1.Lines.Add('AGREGANDO CLIENTE AL PADRON: '+TRIM(NRO_DOCUMENTO));
                application.ProcessMessages;

                RxTrayIcon1.HiNT:='AGREGANDO CLIENTE AL PADRON: '+TRIM(NRO_DOCUMENTO);
                APPLICATION.ProcessMessages;
                SQL.Clear;
                SQL.Add(sqloracle2);
                ExecSQL;
                MEMO1.Lines.Add('CLIENTE AGREDADO: OK');
                APPLICATION.ProcessMessages;
          finally
            close;
            free;
          end;
           {
          if ExisteVehicPadron=0 then
           with tsqlQuery.Create(nil) do
            try
                SQLConnection:= MYBD;
                MEMO1.Lines.Add('AGREGANDO VEHICULO AL PADRON: '+TRIM(PATENTE));
                application.ProcessMessages;

                RxTrayIcon1.HiNT:='AGREGANDO VEHICULO AL PADRON: '+TRIM(PATENTE);
                APPLICATION.ProcessMessages;
                SQL.Clear;
                SQL.Add(sqloracle3);
                ExecSQL;
                MEMO1.Lines.Add('VEHICULO AGREDADO: OK');
                APPLICATION.ProcessMessages;
          finally
            close;
            free;
          end;
           }
       {--------ws--------}
      {Si el vehiculo NO es departamental y el tipo de vehiculo NO es Camioneta, Auto o Taxi, Consulto al WS}
       IF (DEPARTAMENTAL = 0) AND NOT (TIPO_VEHICULO IN [7,8,9]) THEN BEGIN
           WEBSERVICES_EMTO(PATENTE);
       END ELSE BEGIN
      {Si el vehiculo es departamental o es Camioneta, Auto o Taxi, insertamos el vehiculo con datos basicos}
           InsertaVehiculoNoMTOP(PATENTE,TIPO_VEHICULO);
       END;

       {Si el vehiculo NO es departamental y el tipo de vehiculo NO es Camioneta, Auto o Taxi}
       IF (DEPARTAMENTAL = 0) AND NOT (TIPO_VEHICULO IN [7,8,9]) THEN BEGIN
          IF (PaisISO <> '') OR (Matricula <> '') THEN BEGIN
             try
             WSDATOSPADRON(PaisISO,Registro,Matricula,TipoVehiculoId,TipoFlota,Padron,AnioFiscal,MarcaMotorId,ModeloMotorId,NumeroMotor,
                           TipoCombustibleId,MarcaChasisId,ModeloChasisId,NumeroChasis,CantidadEjes,Largoveh,Alto,Ancho,Tara,TipoSuspensionId,TipoITVId,
                           ExpedicionITV,VencimientoITV,TipoInspeccionITVId,NumeroITV,NumeroObleaITV,TipoPNCId,VencimientoPNC,CodigoUsuario,
                           RUTUsuario,NombreUsuario,LonguitudEnganche,MercanciaPeligrosa,TipoCabinaId,TipoCajaCargaId,TipoAditamentoId,CabinaMejorada,
                           MarcaCarroceriaId,ModeloCarroceriaId,CantidadAsientos,TipoAsientoId,TieneBano,CantidadPuertas,TipoRegistradorEventosId,
                           TipoBodegaId,TipoServicioId,TipoSubServicioId,TieneAire,Profesional);
             except
               on E: Exception do
                      BEGIN
                         MEMO1.Lines.Add('ERROR AL EJECUTAR WSDATOSPADRON. GUARDANDO ERROR EN EL LOG.');
                         APPLICATION.ProcessMessages;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| PATENTE: '+Matricula+'. CLIENTE: '+RUTUsuario+'. POR: '+ E.message);
                      END;
             END;
          END;
       END ELSE BEGIN
       {Si el vehiculo es departamental o es Camioneta, Auto o Taxi, insertamos el vehiculo con datos basicos}
           InsertaVehiculoNoMTOP(PATENTE,TIPO_VEHICULO);
       END;

        {-----------------}
        try
        {Si el vehiculo no es ninguna de las opciones anteriores y el WS no devuelve datos aunque cumpla las mismas o si
         no se perdio conexion al WS, busco dicho vehiculo en la tabla padronvehic de la base}
           DoCompletarDatos(PATENTE);
           except
               on E: Exception do
                      BEGIN
                         MEMO1.Lines.Add('ERROR AL EJECUTAR DoCompletarDatos. GUARDANDO ERROR EN EL LOG.');
                         APPLICATION.ProcessMessages;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| PATENTE: '+PATENTE+'. NO SE INSERTO TURNOID '+INTTOSTR(TURNOID)+'. POR: '+ E.message);
                      END;
         END; 

           EXCEPT
             on E: Exception do
                      BEGIN
                        MEMO1.Lines.Add('TRANSACCION: ERROR. GUARDANDO ERROR EN EL LOG.');
                         APPLICATION.ProcessMessages;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| PLANTA '+NOMPLANTA+'. NO SE INSERTO TURNOID '+INTTOSTR(TURNOID)+'. POR: '+ E.message);
                      END;
           END; 
           modulo.QUERY_WEB.NEXT;
        END;

        try
        {completo los datos del cliente y del vehiculo en tdatosturno una vez que se agregaron a la base}
        DoCompletarDatosTURNO(PATENTE,TURNOID);
        except
               on E: Exception do
                      BEGIN
                         MEMO1.Lines.Add('ERROR AL EJECUTAR DoCompletarDatosTURNO. GUARDANDO ERROR EN EL LOG.');
                         APPLICATION.ProcessMessages;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| PATENTE: '+PATENTE+'. NO SE INSERTO TURNOID '+INTTOSTR(TURNOID)+'. POR: '+ E.message);

                      END;
        END;
 //Application.MessageBox( 'PROCESO TERMINADO.', 'Atención', MB_ICONINFORMATION );
END;

Function TForm1.WEBSERVICES_EMTO(PATENTE:String):boolean;
var err, str: string;
    req: TStringStream;
    strings: TStringList;
    recieveID: integer;
    request, response: TStringStream;
    MEMO:TMEMO;
    NOMBRE_XML,llega,CADENA_XML:STRING;  posi:longint;
    HTTPRIO1: THTTPRIO;
begin

TRY
{configuracion del ws}
HTTPRIO1:=THTTPRIO.Create(nil);
memo1.Lines.Add('CONECTANDO A WS....') ;
APPLICATION.ProcessMessages;
HTTPRIO1.WSDLLocation:='https://wsdnt.mtop.gub.uy/WSITV-PROD/aWSVehiculosITV.aspx?wsdl';
HTTPRIO1.Service:='WSVehiculosITV';
HTTPRIO1.Port:='WSVehiculosITVSoapPort';
HTTPRIO1.URL:='https://wsdnt.mtop.gub.uy/WSITV-PROD/aWSVehiculosITV.aspx';
HTTPRIO1.HTTPWebNode.SoapAction := 'https://wsdnt.mtop.gub.uy/WSITV-PROD/aWSVehiculosITV.aspx';
 {------}

CADENA_XML:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="WebService">'+
   '<soapenv:Header/>'+
   '<soapenv:Body>'+
      '<web:WSVehiculosITV.PORMATRICULA>'+
         '<web:Paisiso>UY</web:Paisiso>'+
         '<web:Matricula>'+TRIM(PATENTE)+'</web:Matricula>'+
      '</web:WSVehiculosITV.PORMATRICULA>'+
   '</soapenv:Body>'+
'</soapenv:Envelope>';

strings := TStringList.Create;
strings.Text := CADENA_XML;

request := TStringStream.Create(UTF8Encode(strings.GetText));
response := TStringStream.Create('');
NOMBRE_XML:='Consulta.xml';
strings.free;
strings := TStringList.Create;
strings.LoadFromStream(request);
strings.SaveToFile('C:\Argentin\XML URU\'+NOMBRE_XML);
strings.free;
application.ProcessMessages;
recieveID :=HTTPRIO1.HTTPWebNode.Send(request);
application.ProcessMessages;
HTTPRIO1.HTTPWebNode.Receive(recieveID,response,false);
application.ProcessMessages;   //Response
response.Position := 0;
strings := TStringList.Create;
strings.LoadFromStream(response);
NOMBRE_XML:='rConsulta.xml';
strings.SaveToFile('C:\Argentin\XML URU\'+NOMBRE_XML);
NOMBRE_XML:='rConsulta.txt';
strings.SaveToFile('C:\Argentin\XML URU\'+NOMBRE_XML);
strings.free;
HTTPRIO1.free;
memo1.Lines.Add('LEYENDO ARCHIVO....') ;
APPLICATION.ProcessMessages;
LEER_XML_CONSULTA('C:\Argentin\XML URU\'+NOMBRE_XML);
EXCEPT
 HTTPRIO1.free;
END;

end;
function TForm1.limpiar_variables:boolean;
begin
PaisISO:='';
Registro:='';
Matricula:='';
TipoVehiculoId:='';
TipoFlota:='';
Padron :='';
AnioFiscal:='';
MarcaMotorId:='';
ModeloMotorId:='';
NumeroMotor :='';
TipoCombustibleId:='';
MarcaChasisId:='';
ModeloChasisId:='';
NumeroChasis:='';
CantidadEjes:='';
Largoveh:='';
Alto:='';
Ancho:='';
Tara :='';
TipoSuspensionId:='';
TipoITVId :='';
ExpedicionITV:='';
VencimientoITV :='';
TipoInspeccionITVId :='';
NumeroITV :='';
NumeroObleaITV  :='';
TipoPNCId :='';
VencimientoPNC :='';
CodigoUsuario :='';
RUTUsuario :='';
NombreUsuario :='';
LonguitudEnganche:='';
MercanciaPeligrosa :='';
TipoCabinaId :='';
TipoCajaCargaId:='';
TipoAditamentoId :='';
CabinaMejorada :='';
MarcaCarroceriaId:='';
ModeloCarroceriaId:='';
CantidadAsientos:='';
TipoAsientoId :='';
TieneBano :='';
CantidadPuertas :='';
TipoRegistradorEventosId :='';
TipoBodegaId :='';
TipoServicioId :='';
TipoSubServicioId :='';
TieneAire :='';

end;

FUNCTION TForm1.LEER_XML_CONSULTA(ARCHIVO:STRING):BOOLEAN;
VAR ARCHIVOPROCESO:TEXTFILE;
archi:textfile;
linea,LINEA_NUEVA,eer:string;
posi,largo,hasta,posi1:longint;
campo6,campo5,campo4,campo3,campo2,campo1:string;
BEGIN

limpiar_variables;

LINEA_NUEVA:='';

LEER_XML_CONSULTA:=FALSE;
assignfile(archi,ARCHIVO);
reset(archi);
linea:='-';
 while NOT EOF(ARCHI) do
  begin
         readln(archi,linea);

     LINEA_NUEVA:=LINEA_NUEVA + TRIM(LINEA);

  END;
CLOSEFILE(ARCHI);

     if pos('<PaisISO>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<PaisISO>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<PaisISO>',LINEA_NUEVA);
          largo:=length('<PaisISO>');
          posi1:=pos('</PaisISO>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          PaisISO:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<Registro>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<Registro>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<Registro>',LINEA_NUEVA);
          largo:=length('<Registro>');
          posi1:=pos('</Registro>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          Registro:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<Matricula>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<Matricula>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<Matricula>',LINEA_NUEVA);
          largo:=length('<Matricula>');
          posi1:=pos('</Matricula>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          Matricula:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<TipoVehiculoId>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<TipoVehiculoId>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<TipoVehiculoId>',LINEA_NUEVA);
          largo:=length('<TipoVehiculoId>');
          posi1:=pos('</TipoVehiculoId>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          TipoVehiculoId:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<TipoFlota>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<TipoFlota>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<TipoFlota>',LINEA_NUEVA);
          largo:=length('<TipoFlota>');
          posi1:=pos('</TipoFlota>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          TipoFlota:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<Padron>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<Padron>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<Padron>',LINEA_NUEVA);
          largo:=length('<Padron>');
          posi1:=pos('</Padron>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          Padron:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<AnioFiscal>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<AnioFiscal>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<AnioFiscal>',LINEA_NUEVA);
          largo:=length('<AnioFiscal>');
          posi1:=pos('</AnioFiscal>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          AnioFiscal:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<MarcaMotorId>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<MarcaMotorId>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<MarcaMotorId>',LINEA_NUEVA);
          largo:=length('<MarcaMotorId>');
          posi1:=pos('</MarcaMotorId>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          MarcaMotorId:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<ModeloMotorId>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<ModeloMotorId>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<ModeloMotorId>',LINEA_NUEVA);
          largo:=length('<ModeloMotorId>');
          posi1:=pos('</ModeloMotorId>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          ModeloMotorId:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<NumeroMotor>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<NumeroMotor>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<NumeroMotor>',LINEA_NUEVA);
          largo:=length('<NumeroMotor>');
          posi1:=pos('</NumeroMotor>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          NumeroMotor:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<TipoCombustibleId>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<TipoCombustibleId>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<TipoCombustibleId>',LINEA_NUEVA);
          largo:=length('<TipoCombustibleId>');
          posi1:=pos('</TipoCombustibleId>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          TipoCombustibleId:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<MarcaChasisId>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<MarcaChasisId>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<MarcaChasisId>',LINEA_NUEVA);
          largo:=length('<MarcaChasisId>');
          posi1:=pos('</MarcaChasisId>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          MarcaChasisId:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<ModeloChasisId>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<ModeloChasisId>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<ModeloChasisId>',LINEA_NUEVA);
          largo:=length('<ModeloChasisId>');
          posi1:=pos('</ModeloChasisId>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          ModeloChasisId:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<NumeroChasis>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<NumeroChasis>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<NumeroChasis>',LINEA_NUEVA);
          largo:=length('<NumeroChasis>');
          posi1:=pos('</NumeroChasis>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          NumeroChasis:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<CantidadEjes>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<CantidadEjes>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<CantidadEjes>',LINEA_NUEVA);
          largo:=length('<CantidadEjes>');
          posi1:=pos('</CantidadEjes>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          CantidadEjes:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<Largo>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<Largo>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<Largo>',LINEA_NUEVA);
          largo:=length('<Largo>');
          posi1:=pos('</Largo>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          Largoveh:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<Alto>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<Alto>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<Alto>',LINEA_NUEVA);
          largo:=length('<Alto>');
          posi1:=pos('</Alto>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          Alto:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<Ancho>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<Ancho>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<Ancho>',LINEA_NUEVA);
          largo:=length('<Ancho>');
          posi1:=pos('</Ancho>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          Ancho:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<Tara>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<Tara>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<Tara>',LINEA_NUEVA);
          largo:=length('<Tara>');
          posi1:=pos('</Tara>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          Tara:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<TipoSuspensionId>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<TipoSuspensionId>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<TipoSuspensionId>',LINEA_NUEVA);
          largo:=length('<TipoSuspensionId>');
          posi1:=pos('</TipoSuspensionId>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          TipoSuspensionId:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<TipoITVId>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<TipoITVId>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<TipoITVId>',LINEA_NUEVA);
          largo:=length('<TipoITVId>');
          posi1:=pos('</TipoITVId>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          TipoITVId:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<ExpedicionITV>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<ExpedicionITV>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<ExpedicionITV>',LINEA_NUEVA);
          largo:=length('<ExpedicionITV>');
          posi1:=pos('</ExpedicionITV>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          Registro:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<VencimientoITV>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<VencimientoITV>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<VencimientoITV>',LINEA_NUEVA);
          largo:=length('<VencimientoITV>');
          posi1:=pos('</VencimientoITV>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          VencimientoITV:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<TipoInspeccionITVId>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<TipoInspeccionITVId>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<TipoInspeccionITVId>',LINEA_NUEVA);
          largo:=length('<TipoInspeccionITVId>');
          posi1:=pos('</TipoInspeccionITVId>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          TipoInspeccionITVId:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<NumeroITV>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<NumeroITV>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<NumeroITV>',LINEA_NUEVA);
          largo:=length('<NumeroITV>');
          posi1:=pos('</NumeroITV>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          NumeroITV:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<NumeroObleaITV>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<NumeroObleaITV>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<NumeroObleaITV>',LINEA_NUEVA);
          largo:=length('<NumeroObleaITV>');
          posi1:=pos('</NumeroObleaITV>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          NumeroObleaITV:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<TipoPNCId>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<TipoPNCId>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<TipoPNCId>',LINEA_NUEVA);
          largo:=length('<TipoPNCId>');
          posi1:=pos('</TipoPNCId>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          TipoPNCId:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<VencimientoPNC>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<VencimientoPNC>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<VencimientoPNC>',LINEA_NUEVA);
          largo:=length('<VencimientoPNC>');
          posi1:=pos('</VencimientoPNC>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          VencimientoPNC:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
     end;

     if pos('<CodigoUsuario>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<CodigoUsuario>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<CodigoUsuario>',LINEA_NUEVA);
          largo:=length('<CodigoUsuario>');
          posi1:=pos('</CodigoUsuario>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          CodigoUsuario:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<RUTUsuario>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<RUTUsuario>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<RUTUsuario>',LINEA_NUEVA);
          largo:=length('<RUTUsuario>');
          posi1:=pos('</RUTUsuario>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          RUTUsuario:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<NombreUsuario>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<NombreUsuario>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<NombreUsuario>',LINEA_NUEVA);
          largo:=length('<NombreUsuario>');
          posi1:=pos('</NombreUsuario>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          NombreUsuario:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;
     
     if pos('<Profesional>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<Profesional>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<Profesional>',LINEA_NUEVA);
          largo:=length('<Profesional>');
          posi1:=pos('</Profesional>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          Profesional:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

    if TipoFlota='CARGAS' then
    begin
     if pos('<LonguitudEnganche>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<LonguitudEnganche>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<LonguitudEnganche>',LINEA_NUEVA);
          largo:=length('<LonguitudEnganche>');
          posi1:=pos('</LonguitudEnganche>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          LonguitudEnganche:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<MercanciaPeligrosa>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<MercanciaPeligrosa>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<MercanciaPeligrosa>',LINEA_NUEVA);
          largo:=length('<MercanciaPeligrosa>');
          posi1:=pos('</MercanciaPeligrosa>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          MercanciaPeligrosa:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<TipoCabinaId>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<TipoCabinaId>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<TipoCabinaId>',LINEA_NUEVA);
          largo:=length('<TipoCabinaId>');
          posi1:=pos('</TipoCabinaId>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          TipoCabinaId:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<TipoCajaCargaId>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<TipoCajaCargaId>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<TipoCajaCargaId>',LINEA_NUEVA);
          largo:=length('<TipoCajaCargaId>');
          posi1:=pos('</TipoCajaCargaId>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          TipoCajaCargaId:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<TipoAditamentoId>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<TipoAditamentoId>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<TipoAditamentoId>',LINEA_NUEVA);
          largo:=length('<TipoAditamentoId>');
          posi1:=pos('</TipoAditamentoId>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          TipoAditamentoId:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<CabinaMejorada>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<CabinaMejorada>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<CabinaMejorada>',LINEA_NUEVA);
          largo:=length('<CabinaMejorada>');
          posi1:=pos('</CabinaMejorada>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          CabinaMejorada:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

    end else begin

     if pos('<MarcaCarroceriaId>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<MarcaCarroceriaId>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<MarcaCarroceriaId>',LINEA_NUEVA);
          largo:=length('<MarcaCarroceriaId>');
          posi1:=pos('</MarcaCarroceriaId>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          MarcaCarroceriaId:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<ModeloCarroceriaId>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<ModeloCarroceriaId>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<ModeloCarroceriaId>',LINEA_NUEVA);
          largo:=length('<ModeloCarroceriaId>');
          posi1:=pos('</ModeloCarroceriaId>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          ModeloCarroceriaId:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;
  
     if pos('<CantidadAsientos>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<CantidadAsientos>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<CantidadAsientos>',LINEA_NUEVA);
          largo:=length('<CantidadAsientos>');
          posi1:=pos('</CantidadAsientos>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          CantidadAsientos:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;
  
     if pos('<TipoAsientoId>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<TipoAsientoId>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<TipoAsientoId>',LINEA_NUEVA);
          largo:=length('<TipoAsientoId>');
          posi1:=pos('</TipoAsientoId>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          TipoAsientoId:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;

     if pos('<TieneBano>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<TieneBano>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<TieneBano>',LINEA_NUEVA);
          largo:=length('<TieneBano>');
          posi1:=pos('</TieneBano>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          TieneBano:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;
  
     if pos('<CantidadPuertas>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<CantidadPuertas>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<CantidadPuertas>',LINEA_NUEVA);
          largo:=length('<CantidadPuertas>');
          posi1:=pos('</CantidadPuertas>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          CantidadPuertas:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;
  
     if pos('<TipoRegistradorEventosId>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<TipoRegistradorEventosId>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<TipoRegistradorEventosId>',LINEA_NUEVA);
          largo:=length('<TipoRegistradorEventosId>');
          posi1:=pos('</TipoRegistradorEventosId>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          TipoRegistradorEventosId:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;
  
     if pos('<TipoBodegaId>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<TipoBodegaId>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<TipoBodegaId>',LINEA_NUEVA);
          largo:=length('<TipoBodegaId>');
          posi1:=pos('</TipoBodegaId>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          TipoBodegaId:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;
  
     if pos('<TipoServicioId>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<TipoServicioId>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<TipoServicioId>',LINEA_NUEVA);
          largo:=length('<TipoServicioId>');
          posi1:=pos('</TipoServicioId>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          TipoServicioId:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;
  
     if pos('<TipoSubServicioId>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<TipoSubServicioId>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<TipoSubServicioId>',LINEA_NUEVA);
          largo:=length('<TipoSubServicioId>');
          posi1:=pos('</TipoSubServicioId>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          TipoSubServicioId:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;
 
     if pos('<TieneAire>',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<TieneAire>',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<TieneAire>',LINEA_NUEVA);
          largo:=length('<TieneAire>');
          posi1:=pos('</TieneAire>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          TieneAire:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
      end;
  end;

     if pos('<Error xmlns="WebService">',LINEA_NUEVA) > 0 then
     begin
         posi:=pos('<Error xmlns="WebService">',LINEA_NUEVA);
         largo:=length(LINEA_NUEVA);
         LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

          posi:=pos('<Error xmlns="WebService">',LINEA_NUEVA);
          largo:=length('<Error xmlns="WebService">');
          posi1:=pos('</Error>',LINEA_NUEVA);
          HASTA:=posi1 - LARGO;
          eer:=trim(copy(LINEA_NUEVA,largo+1,HASTA-1));
          if trim(eer)<>'0' then
           begin
               posi:=pos('<MensajeError>',LINEA_NUEVA);
               largo:=length(LINEA_NUEVA);
               LINEA_NUEVA:=copy(LINEA_NUEVA,posi,LARGO);

               posi:=pos('<MensajeError>',LINEA_NUEVA);
               largo:=length('<MensajeError>');
               posi1:=pos('</MensajeError>',LINEA_NUEVA);
               HASTA:=posi1 - LARGO;
               memo1.Lines.Add(Matricula+' Error: '+trim(copy(LINEA_NUEVA,largo+1,HASTA-1)));
               GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| PATENTE: '+Matricula+' error ws: '+trim(copy(LINEA_NUEVA,largo+1,HASTA-1)));
           end;
      end;
  LEER_XML_CONSULTA:=TRUE;
 END;  

Procedure TForm1.DoCompletarDatos(PATENTE:String);
Begin

    with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'BUSCAINSERTAPADRON';
        Prepared := true;
        ParamByName('PATENTE').Value := TRIM(PATENTE);
        ExecProc;
        Close;
        finally
          Free;
        end;
End;

Procedure TForm1.InsertaVehiculoNoMTOP(PATENTE:STRING;TIPO_VEHICULO:LONGINT);
Begin

    with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'INSERTVEHICDEPAR';
        Prepared := true;
        ParamByName('PATENTE').Value := TRIM(PATENTE);
        ParamByName('TIPO_VEHICULO').Value := IntToStr(TIPO_VEHICULO);
        ExecProc;
        Close;
        finally
          Free;
        end;
End;

Procedure TForm1.DoCompletarDatosTURNO(PATENTE:STRING;TURNOID:Longint);
Begin

    with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'CompletaDatosTurno';
        Prepared := true;
        ParamByName('PATENTE').Value := TRIM(PATENTE);
        ParamByName('TURNOID').Value := INTTOSTR(TURNOID);
        ExecProc;
        Close;
        finally
          Free;
        end;
End;

Procedure TForm1.WSDATOSPADRON;
Begin

    with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'WSDATOSPADRON';
        Prepared := true;
        ParamByName('PaisISO').Value := TRIM(PaisISO);
        ParamByName('Registro').Value := TRIM(Registro);
        ParamByName('Matricula').Value := TRIM(Matricula);
        ParamByName('TipoVehiculoId').Value := TRIM(TipoVehiculoId);
        ParamByName('TipoFlota').Value := TRIM(TipoFlota);
        ParamByName('Padron').Value := TRIM(Padron);
        ParamByName('AnioFiscal').Value := TRIM(AnioFiscal);
        ParamByName('MarcaMotorId').Value := TRIM(MarcaMotorId);
        ParamByName('ModeloMotorId').Value := TRIM(ModeloMotorId);
        ParamByName('NumeroMotor').Value := TRIM(NumeroMotor);
        ParamByName('TipoCombustibleId').Value := TRIM(TipoCombustibleId);
        ParamByName('MarcaChasisId').Value := TRIM(MarcaChasisId);
        ParamByName('ModeloChasisId').Value := TRIM(ModeloChasisId);
        ParamByName('NumeroChasis').Value := TRIM(NumeroChasis);
        ParamByName('CantidadEjes').Value := TRIM(CantidadEjes);
        ParamByName('Largo').Value := TRIM(Largoveh);
        ParamByName('Alto').Value := TRIM(Alto);
        ParamByName('Ancho').Value := TRIM(Ancho);
        ParamByName('Tara').Value := TRIM(Tara);
        ParamByName('TipoSuspensionId').Value := TRIM(TipoSuspensionId);
        ParamByName('TipoITVId').Value := TRIM(TipoITVId);
        ParamByName('ExpedicionITV').Value := TRIM(ExpedicionITV);
        ParamByName('VencimientoITV').Value := TRIM(VencimientoITV);
        ParamByName('TipoInspeccionITVId').Value := TRIM(TipoInspeccionITVId);
        ParamByName('NumeroITV').Value := TRIM(NumeroITV);
        ParamByName('NumeroObleaITV').Value := TRIM(NumeroObleaITV);
        ParamByName('TipoPNCId').Value := TRIM(TipoPNCId);
        ParamByName('VencimientoPNC').Value := TRIM(VencimientoPNC);
        ParamByName('CodigoUsuario').Value := TRIM(CodigoUsuario);
        ParamByName('RUTUsuario').Value := TRIM(RUTUsuario);
        ParamByName('NombreUsuario').Value := TRIM(NombreUsuario);
        ParamByName('LonguitudEnganche').Value := TRIM(LonguitudEnganche);
        ParamByName('MercanciaPeligrosa').Value := TRIM(MercanciaPeligrosa);
        ParamByName('TipoCabinaId').Value := TRIM(TipoCabinaId);
        ParamByName('TipoCajaCargaId').Value := TRIM(TipoCajaCargaId);
        ParamByName('TipoAditamentoId').Value := TRIM(TipoAditamentoId);
        ParamByName('CabinaMejorada').Value := TRIM(CabinaMejorada);
        ParamByName('MarcaCarroceriaId').Value := TRIM(MarcaCarroceriaId);
        ParamByName('ModeloCarroceriaId').Value := TRIM(ModeloCarroceriaId);
        ParamByName('CantidadAsientos').Value := TRIM(CantidadAsientos);
        ParamByName('TipoAsientoId').Value := TRIM(TipoAsientoId);
        ParamByName('TieneBano').Value := TRIM(TieneBano);
        ParamByName('CantidadPuertas').Value := TRIM(CantidadPuertas);
        ParamByName('TipoRegistradorEventosId').Value := TRIM(TipoRegistradorEventosId);
        ParamByName('TipoBodegaId').Value := TRIM(TipoBodegaId);
        ParamByName('TipoServicioId').Value := TRIM(TipoServicioId);
        ParamByName('TipoSubServicioId').Value := TRIM(TipoSubServicioId);
        ParamByName('TieneAire').Value := TRIM(TieneAire);
        ParamByName('Profesional').Value := TRIM(Profesional);//Profesional
        ExecProc;
        Close;
        finally
          Free;
        end;
End;

function TForm1.conexion_virtual(base:string):boolean;
var servidor,pass,user:string;
begin
CITAS_CONECT:=FALSe;
modulo.conexion.Close;
//servidor:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Server');
with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(APPLICATION_KEY_turno) then
      Begin
      servidor:=ReadString('ServerSQL');
      user:=ReadString('UserSQL');
      pass:=ReadString('PasswordSQL');
      centro:=ReadString('CENTRO');
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
     // uglobal.ID_PLANTA:=GetRegistryData(HKEY_LOCAL_MACHINE,'\Software\Citas\', 'Planta');
   //   form1.caption:='Administración de Reservas de Turnos OnLine.  [ '+trim(busca_nombr_centro(uglobal.ID_PLANTA))+' ]';
   CITAS_CONECT:=TRUE;
     end;
 except
  GUARDA_LOG(DATETOSTR(DATE)+'-'+TIMETOSTR(TIME)+'-NO DE PUSO CONECTAR A Uruguay');
  CITAS_CONECT:=FALSE;
 end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
CAPTION:='EXPORTADOR';
memo1.Clear;
Timer1.Enabled:=FALSe;
BUTTON1.Enabled:=FALSe;
SELF.BitBtn1.Enabled:=TRUE;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
HINT:='STOP...';
Timer1.Enabled:=FALSe;
MYBD.Close;
MODULO.conexion.Close;
BUTTON1.Enabled:=FALSe;
SELF.BitBtn1.Enabled:=TRUE;
CAPTION:='EXPORTADOR';
 RxTrayIcon1.HiNT:='STOP!!!';
MEMO1.Clear;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin

//IF TRIM(TIMETOSTR(TIME)) = TRIM(HORA_EEJCUTAR) THEN
//BEGIN
HINT:='EXPOTANDO...';
 timer1.Enabled:=falsE;
 SELF.EJECUTAR;
 timer1.Interval:=60000; //10800000
 timer1.Enabled:=true;
//END;
MEMO1.Clear;
MEMO1.Lines.Add('EXPORTACION ...');
RxTrayIcon1.HiNT:='INICIADO....';
APPLICATION.ProcessMessages;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
HINT:='INICIADO...';
MEMO1.Clear;
SELF.EJECUTAR;
//MEMO1.Lines.Add('EXPORTACION A LAS '+HORA_EEJCUTAR);
MEMO1.Lines.Add('EXPORTACION ..');
RxTrayIcon1.HiNT:='INICIADO...';
APPLICATION.ProcessMessages;
BUTTON1.Enabled:=TRUE;
SELF.BitBtn1.Enabled:=FALSE;
Timer1.Enabled:=TRUE;
end;

procedure TForm1.Ocultar1Click(Sender: TObject);
begin
HIDE;
end;

procedure TForm1.Mostrar1Click(Sender: TObject);
begin
SHOW;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 SELF.EJECUTAR;
end;

procedure TForm1.BuscarClick(Sender: TObject);
var
PATENTE:STRING;
TIPO_VEHICULO:LONGINT;

begin
//SELF.EJECUTAR;
PATENTE:=BuscarPatente.Text;
TIPO_VEHICULO:=1;

          IF (PaisISO <> '') OR (Matricula <> '') THEN BEGIN
             try
             WSDATOSPADRON(PaisISO,Registro,Matricula,TipoVehiculoId,TipoFlota,Padron,AnioFiscal,MarcaMotorId,ModeloMotorId,NumeroMotor,
                           TipoCombustibleId,MarcaChasisId,ModeloChasisId,NumeroChasis,CantidadEjes,Largoveh,Alto,Ancho,Tara,TipoSuspensionId,TipoITVId,
                           ExpedicionITV,VencimientoITV,TipoInspeccionITVId,NumeroITV,NumeroObleaITV,TipoPNCId,VencimientoPNC,CodigoUsuario,
                           RUTUsuario,NombreUsuario,LonguitudEnganche,MercanciaPeligrosa,TipoCabinaId,TipoCajaCargaId,TipoAditamentoId,CabinaMejorada,
                           MarcaCarroceriaId,ModeloCarroceriaId,CantidadAsientos,TipoAsientoId,TieneBano,CantidadPuertas,TipoRegistradorEventosId,
                           TipoBodegaId,TipoServicioId,TipoSubServicioId,TieneAire,Profesional);
             except
               on E: Exception do
                      BEGIN
                         MEMO1.Lines.Add('ERROR AL EJECUTAR WSDATOSPADRON. GUARDANDO ERROR EN EL LOG.');
                         APPLICATION.ProcessMessages;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| PATENTE: '+Matricula+'. CLIENTE: '+RUTUsuario+'. POR: '+ E.message);
                      END;
             END;
          END ELSE BEGIN
              InsertaVehiculoNoMTOP(PATENTE,TIPO_VEHICULO);
          END;
END;

END.
