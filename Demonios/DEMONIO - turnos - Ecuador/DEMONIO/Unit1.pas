unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls,inifiles, DB, ADODB, FMTBcd, SqlExpr, USuperRegistry,
  DBXpress, Provider, dbclient, DBCtrls, ExtCtrls, RXShell, Menus,
  ExcelXP, OleServer, ComObj, UCDialgs, IdFTP, IdComponent;

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
        COMPANY_NAME = 'SAGECUADOR';
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

       HORA_EEJCUTAR='20:30:00';
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
    OpenExcel: TOpenDialog;
    Importar: TButton;
    ExcelApplication1: TExcelApplication;
    ExcelQueryTable1: TExcelQueryTable;
    OpenTXT: TOpenDialog;
    Exportar: TButton;
    GroupBox1: TGroupBox;
    EnviarFTP: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Ocultar1Click(Sender: TObject);
    procedure Mostrar1Click(Sender: TObject);
    procedure ImportarClick(Sender: TObject);
    procedure ExportarClick(Sender: TObject);
    procedure EnviarFTPClick(Sender: TObject);
  private
    { Private declarations }
    FUNCTION KillTask(ExeFileName: string): Integer;
    PROCEDURE SubirArchivo( sArchivo: String );
  public
    { Public declarations }
    sArchivo: string;
    centro:STRING;
    se_conector:BOOLEAN;
    CITAS_CONECT:BOOLEAN;
    NOMPLANTA:STRING;
    ARCHIVO_LOG:STRING;
    fConsulta: TClientDataSet;
    sdsfConsulta: TSQLDataSet;
    dspfConsulta: TDataSetProvider;
    PROCEDURE DoImportacionExlsOracle;
    PROCEDURE DoExportacionTXT;
    PROCEDURE ActualizaEstadoReserva;
    PROCEDURE INFORMARTURNOS;
    PROCEDURE ACTUALIZARAUSENTES;
    PROCEDURE ACTUALIZARCANCELADOS;
    PROCEDURE DoFacturacion(CODCLIEN,CODVEHIC,IDPAGO,NROORDEN:longint;IMPORTEFAC:STRING);
    PROCEDURE TestOfBD(Alias, UserName, Password: String; Ageva: boolean);
    FUNCTION conexion_virtual(base:string):boolean;
    FUNCTION ENVIAR_A_WEB_TURNOS(IDPAGOhasta:longint;plantapasa:longint):BOOLEAN;
    FUNCTION GUARDA_LOG(MENSAJE:STRING):BOOLEAN;
    FUNCTION ACTUALIZAR_CAMPO_IMPORTADO(IDTURNO:LONGINT):boolean;
    PROCEDURE EJECUTAR;
    PROCEDURE CONEXION;
  end;

var
  Form1: TForm1;
  f: integer;
  ExcelApp, ExcelLibro, ExcelHoja: Variant;

implementation

uses Umodulo, Tlhelp32;

{$R *.dfm}

{Funcion para matar procesos del sistema, ejemplo: KillTask('EXCEL.exe');}
function TForm1.KillTask(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(
                        OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

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
                        DBPassword := ReadString('Password')
                    else
                        DBPassword:=Password;

                    //Librerias Oracle
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
IDPAGO,planta:longint;

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
    if OpenKeyRead(APPLICATION_KEY_SQL) then
      Begin
        BASE:=ReadString('Base_Centro');
      end;
  Finally
    free;
  end;

conexion_virtual('db_web_ecuador');
IF CITAS_CONECT=TRUE THEN
BEGIN

   begin
     MEMO1.Clear;
     //readln(archivo,alias);
     NOMPLANTA:=userbd; //ALIAS
     userbd:='SAGECUADOR';
     password:='02lusabaqui03';
     TestOfBD(alias,userbd,password,false);

     if se_conector=true then

      BEGIN
        form1.Caption:='CONECTADO A '+ userbd; //ALIAS
        memo1.Lines.Add('CONECTADO A: '+ userbd);  //ALIAS
        FORM1.HiNT:='CONECTADO A '+ userbd;  //ALIAS
        RxTrayIcon1.HiNT:='CONECTADO A '+ userbd;  //ALIAS
        APPLICATION.ProcessMessages;

        {busco en la base oracle el ultimo TURNOID}
        with tsqlQuery.Create(nil) do
        try
          SQLConnection:= MYBD;
          SQL.Add('SELECT DISTINCT MAX(IDPAGO) FROM TDATOSTURNO WHERE IDPAGO NOT LIKE ''%-%'' ');
          Open;
          IDPAGO:=fields[0].AsInteger;

       finally
         close;
         free;
       end;

        planta:=STRTOINT(centro);
        ENVIAR_A_WEB_TURNOS(IDPAGO,Planta);
        END else
        begin

        end;

   mybd.Close;
end;

modulo.conexion.Close;

END;

end;

procedure TForm1.ExportarClick(Sender: TObject);
begin
   DoExportacionTXT;
end;

procedure TForm1.EnviarFTPClick(Sender: TObject);
begin
    SubirArchivo(sArchivo);
end;

procedure TForm1.ImportarClick(Sender: TObject);
begin
  DoImportacionExlsOracle;
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

FUNCTION TFORM1.ENVIAR_A_WEB_TURNOS(IDPAGOhasta:longint;plantapasa:longint):BOOLEAN;
var sqloracle:string;

CENTRO:string;
CODTURNO,CODCLIEN,CODVEHIC,IDPAGO,NROORDEN,ESTADO,TIPO_DOCUMENTO,NUMINSPEC:longint;
CODMARCA,CODMODEL,AnioFabr,tipo_vehiculo,tipo_destino,TIPOESPE,CIUDAD,CANTON:longint;
PATENTE,IMPORTE,IMPORTEFAC,FECHAMATRI,NUMCHASIS,DIRECCION:string;
NOMBRE,APELLIDO,RAZONSOCIAL,TELEFONO,EMAIL:string;
FECHATURNO,HORATURNO,FECHALTA,NRO_DOCUMENTO,TIPOPERSONA:string;
Existe,ExisteVeh,ExisteCli,GRUPOVEHICULO,TIPOVEHICULO:Longint;

BEGIN
 {Busco los turnos cancelados y actualizo primero en tdatosturno}
 ACTUALIZARCANCELADOS;

{Ingreso la Reserva como turno en tdatosturno} 
 {Tomar los datos de la tabla reservas del SQL}
        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;
                                 
         modulo.QUERY_WEB.SQL.Add('SELECT '+
                                  //'--Tdatosturno '+
                                  're.numero AS IDPAGO '+
                                  ',re.numero_orden AS NROORDEN '+
                                  ',re.patente '+
                                  ',re.centro AS PLANTA '+
                                  ',re.fecha AS FECHATURNO '+
                                  ',re.hora AS HORATURNO '+
                                  ',dcob.valor AS IMPORTE '+
                                  ',REPLACE(CONVERT(NUMERIC(10, 2),dcob.valor)/100,'','',''.'') AS IMPORTEFAC '+
                                  ',re.codestado AS ESTADO '+
                                  ',dre.nro_repeticion AS NUMINSPEC '+
                                  //'--tvehiculos '+
                                  ',dre.vin AS NUMCHASIS '+
                                  //',dre.MARCA AS CODMARCA '+
                                  //',dre.MODELO AS CODMODEL '+
                                  ',CONCAT(''01/01/'',dre.año) AS FECHAMATRI '+
                                  ',dre.año AS AnioFabr '+
                                  ',dre.tipo_espe AS TIPOESPE '+
                                  ',dre.tipo_destino AS tipo_destino'+
                                  ',dre.tipo_vehiculo AS tipo_vehiculo'+
                                  //'--tclientes '+
                                  ',re.nombre '+
                                  ',re.apellido '+
                                  ',CASE WHEN re.TIPO_DOCUMENTO = ''R'' THEN 2 '+
                                  '      WHEN re.TIPO_DOCUMENTO = ''C'' THEN 1 '+
                                  '      ELSE 0 END AS CODDOCUMENTO '+
                                  ',re.NRO_DOCUMENTO AS DOCUMENTO '+
                                  ',re.email '+
                                  ',re.telefono '+
                                  ',dcob.direccion_cliente AS Direccion '+
                                  ',dcob.localidad_cobro AS Localidad '+
                                  ',dcob.ciudad_cliente AS CIUDAD '+
                                  ',dcob.canton_cliente AS CANTON '+
                                  'FROM reserva re inner join detalles_reserva dre '+
                                  'on re.numero = dre.nro_reserva '+
                                  'inner join detalles_cobros dcob '+
                                  'on dcob.contrapartida = re.numero '+
                                  'WHERE re.IMPORTADO = ''N'' '+
                                  ' AND (re.codestado = 1) '+
                                  ' AND re.CENTRO = '+inttostr(plantapasa)+
                                  ' ORDER BY re.fechalta');

        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.Open;

        WHILE NOT modulo.QUERY_WEB.Eof DO

        BEGIN
        CENTRO:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('PLANTA').ASSTRING);

        //Tdatosturno
        PATENTE:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('PATENTE').ASSTRING);
        FECHATURNO:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('FECHATURNO').ASSTRING);
        HORATURNO:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('HORATURNO').ASSTRING);
        ESTADO:=modulo.QUERY_WEB.FIELDBYNAME('ESTADO').ASInteger;
        IDPAGO:=modulo.QUERY_WEB.FIELDBYNAME('IDPAGO').ASInteger;
        IMPORTE:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('IMPORTE').ASSTRING);
        IMPORTEFAC:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('IMPORTEFAC').ASSTRING);
        NUMINSPEC:=modulo.QUERY_WEB.FIELDBYNAME('NUMINSPEC').ASInteger;
        NROORDEN:=modulo.QUERY_WEB.FIELDBYNAME('NROORDEN').ASInteger;

        //Tclientes
        TIPO_DOCUMENTO:=modulo.QUERY_WEB.FIELDBYNAME('CODDOCUMENTO').ASInteger;
        NRO_DOCUMENTO:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('DOCUMENTO').ASSTRING);
        NOMBRE:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('NOMBRE').ASSTRING);
        APELLIDO:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('APELLIDO').ASSTRING);
        EMAIL:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('EMAIL').ASSTRING);
        TELEFONO:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('TELEFONO').ASSTRING);
        DIRECCION:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('DIRECCION').ASSTRING);
        //CIUDAD:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('CIUDAD').ASSTRING);
        CANTON:=modulo.QUERY_WEB.FIELDBYNAME('CANTON').ASInteger;

        //Tvehiculos
        NUMCHASIS:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('NUMCHASIS').ASSTRING);
        //CODMARCA:=modulo.QUERY_WEB.FIELDBYNAME('CODMARCA').ASInteger;
        //CODMODEL:=modulo.QUERY_WEB.FIELDBYNAME('CODMODEL').ASInteger;
        CODMARCA:=999;
        CODMODEL:=1;
        FECHAMATRI:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('FECHAMATRI').ASSTRING);
        AnioFabr:=modulo.QUERY_WEB.FIELDBYNAME('AnioFabr').ASInteger;
        //tipo_vehiculo:=modulo.QUERY_WEB.FIELDBYNAME('tipo_vehiculo').ASInteger;
        tipo_destino:=modulo.QUERY_WEB.FIELDBYNAME('tipo_destino').ASInteger;
        TIPOESPE:=modulo.QUERY_WEB.FIELDBYNAME('TIPOESPE').ASInteger;

          //Solo para pruebas
          with tsqlQuery.Create(nil) do
            try
            SQLConnection:= MYBD;
            SQL.Add('alter session set nls_date_format = ''dd/mm/yyyy''');
            ExecSQL;
          finally
            close;
            free;
          end;

        IF TIPO_DOCUMENTO = 2 THEN
          BEGIN
            RAZONSOCIAL := NOMBRE;
            TIPOPERSONA := 'J'
        END ELSE BEGIN
          RAZONSOCIAL := 'NULL';
          TIPOPERSONA := 'N'
        END;

        IF (APELLIDO = '') THEN BEGIN APELLIDO := '.'; END;
        IF (NOMBRE = '') THEN BEGIN NOMBRE := '.'; END; 

        //Temporal hasta tener los valores del banco
        { IF IMPORTE = '0000000000000' THEN BEGIN
            IMPORTE:='0'; //Importe REVE
         END ELSE BEGIN
            //Busco el importe desde la web
            TRY
            modulo.QUERY_WEB2.Close;
            modulo.QUERY_WEB2.SQL.Clear;
            modulo.QUERY_WEB2.SQL.Add('SELECT REPLACE(MONTOTARIFA1, '','', ''.'') '+
                                      'FROM TARIFA T INNER JOIN TTIPOESPVEH TT '+
                                      'ON T.CODTARIFA = TT.CODTARIFA '+
                                      'WHERE TT.TIPOESPE ='+IntToStr(TIPOESPE));
            modulo.QUERY_WEB2.ExecSQL;
            modulo.QUERY_WEB2.Open;
            IMPORTE:=modulo.QUERY_WEB2.fields[0].AsString;
            EXCEPT
             on E: Exception do
                      BEGIN
                        MEMO1.Lines.Add('TRANSACCION: ERROR');
                        APPLICATION.ProcessMessages;
                        GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| NO SE OBTUVO EL IMPORTE POR :'+ E.message);
                      END;
            END;
         END; }

         {Si es reve, el estado tiene que ser 1 en tdatosturno}
         IF IMPORTE = '0000000000000' THEN BEGIN IMPORTE:='0'; END;  //Importe REVE
         IF (IMPORTE = '0') THEN BEGIN ESTADO:=1; END;

        {OBTENGO CODPROVINCIA SEGUN EL CANTON}
        with tsqlQuery.Create(nil) do
        try
          SQLConnection:= MYBD;
          SQL.Add('select CODPROVINCIA from CANTON where CODCANTON='+inttostr(CANTON));
          Open;
          CIUDAD:=fields[0].ASInteger;
       finally
         close;
         free;
       end;

       {OBTENGO GRUPOVEHICULO SEGUN EL TIPOESPE}
        with tsqlQuery.Create(nil) do
        try
          SQLConnection:= MYBD;
          SQL.Add('select distinct grupotip from ttipoespveh where tipoespe ='+inttostr(TIPOESPE));
          Open;
          GRUPOVEHICULO:=fields[0].ASInteger;
       finally
         close;
         free;
       end;

        {Consulto si las reservas web existen en tdatosturno}
        with tsqlQuery.Create(nil) do
        try
          SQLConnection:= MYBD;
          SQL.Add('select count(*) from TDATOSTURNO where IDPAGO='+inttostr(IDPAGO));
          Open;
          Existe:=fields[0].ASInteger;
       finally
         close;
         free;
       end;

       {Consulto si existe el vehiculo en tvehiculos}
        with tsqlQuery.Create(nil) do
        try
          SQLConnection:= MYBD;
          SQL.Add('select count(*) from TVEHICULOS where PATENTEN='+#39+TRIM(PATENTE)+#39);
          Open;
          ExisteVeh:=fields[0].ASInteger;
       finally
         close;
         free;
       end;

       IF (ExisteVeh <> 0) THEN //Si el vehiculo ya existe obtengo el codvehic
        BEGIN
          with tsqlQuery.Create(nil) do
          try
            SQLConnection:= MYBD;
            SQL.Add('select CODVEHIC from TVEHICULOS where PATENTEN='+#39+TRIM(PATENTE)+#39);
            Open;
            CODVEHIC:=fields[0].ASInteger;
          finally
            close;
            free;
          end;
        END;

       {Consulto si existe el Cliente en tclientes}
        with tsqlQuery.Create(nil) do
        try
          SQLConnection:= MYBD;
          SQL.Add('select count(*) from TCLIENTES where CODDOCUMENTO='+INTTOSTR(TIPO_DOCUMENTO)+' and documento ='+#39+TRIM(NRO_DOCUMENTO)+#39);
          Open;
          ExisteCli:=fields[0].ASInteger;
       finally
         close;
         free;
       end;

       IF (ExisteCli <> 0) THEN //Si el cliente ya existe obtengo el codclien
        BEGIN
          with tsqlQuery.Create(nil) do
          try
            SQLConnection:= MYBD;
            SQL.Add('select CODCLIEN from TCLIENTES where CODDOCUMENTO='+INTTOSTR(TIPO_DOCUMENTO)+' and documento ='+#39+TRIM(NRO_DOCUMENTO)+#39);
            Open;
            CODCLIEN:=fields[0].ASInteger;
          finally
            close;
            free;
          end;
        END;

       {Fecha que se inserta el turno a la tabla}
       with tsqlQuery.Create(nil) do
        try
          SQLConnection:= MYBD;
          SQL.Add('select TO_DATE(SYSDATE,''DD/MM/YYYY'') from DUAL');
          Open;
          FECHALTA:=fields[0].AsString;
       finally
         close;
         free;
       end;

           //CREAR EL VEHICULO
           if ExisteVeh=0 then
           begin

          //GENERO EL CODIGO DE VEHICULO si no existe
           with tsqlQuery.Create(nil) do
             try
            SQLConnection:= MYBD;
            SQL.Add('select SQ_TVEHICULOS_CODVEHIC.NEXTVAL from DUAL');
            Open;
            CODVEHIC:=fields[0].ASInteger;
           finally
            close;
            free;
           end;

                //inserto en TVEHICULOS
                sqloracle:='INSERT INTO TVEHICULOS (CODVEHIC,FECMATRI,ANIOFABR,CODMARCA,CODMODEL,'+
                            'TIPOESPE,TIPODEST,CODCLASEVEHICULO,NUMCHASIS,NUMMOTOR,NUMEJES,PATENTEN,ERROR) ' +
                            ' VALUES ( '+
                            ' '+INTTOSTR(CODVEHIC)+' '+
                            ','+#39+TRIM(FECHAMATRI)+#39+' '+
                            ','+INTTOSTR(AnioFabr)+' '+
                            ','+INTTOSTR(CODMARCA)+' '+
                            ','+INTTOSTR(CODMODEL)+' '+
                            ','+INTTOSTR(TIPOESPE)+' '+
                            ','+INTTOSTR(tipo_destino)+' '+
                            ','+INTTOSTR(GRUPOVEHICULO)+' '+
                            ','+#39+TRIM(NUMCHASIS)+#39+' '+
                            ',''000'' '+
                            ',''2'' '+
                            ','+#39+TRIM(PATENTE)+#39+' '+
                            ',''N'' '+
                            ')';
                end else begin
                  MEMO1.Lines.Add('Ya existe el Vehiculo: '+INTTOSTR(CODVEHIC));
                  RxTrayIcon1.HiNT:='Ya existe el Vehiculo: '+INTTOSTR(CODVEHIC);
                  APPLICATION.ProcessMessages;
                end;

          if ExisteVeh=0 then
           with tsqlQuery.Create(nil) do
            try
              SQLConnection:= MYBD;
                MEMO1.Lines.Add('CREANDO VEHICULO: '+INTTOSTR(CODVEHIC));
                RxTrayIcon1.HiNT:='CREANDO VEHICULO: '+INTTOSTR(CODVEHIC);
                APPLICATION.ProcessMessages;
                SQL.Clear;
                SQL.Add(sqloracle);
                ExecSQL;
                MEMO1.Lines.Add('TRANSACCION: OK');
                APPLICATION.ProcessMessages;

           EXCEPT
             on E: Exception do
                      BEGIN
                        MEMO1.Lines.Add('TRANSACCION: ERROR');
                        APPLICATION.ProcessMessages;
                        GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| PLANTA '+NOMPLANTA+'. NO SE INSERTO VEHICULO '+INTTOSTR(CODVEHIC)+'. POR :'+ E.message);
                      END;
           END;

           //CREAR EL CLIENTE
           if ExisteCli=0 then
           begin

          //GENERO EL CODIGO DE CLIENTE si no existe
           with tsqlQuery.Create(nil) do
             try
            SQLConnection:= MYBD;
            SQL.Add('select SQ_TCLIENTES_CODCLIEN.NEXTVAL from DUAL');
            Open;
            CODCLIEN:=fields[0].ASInteger;
           finally
            close;
            free;
           end;

                //inserto en TCLIENTES
                sqloracle:='INSERT INTO TCLIENTES (CODCLIEN,CODDOCUMENTO,DVDOCUMENTO,DOCUMENTO, '+
                            'TIPOCLIENTE_ID,TIPOPERSONA,NOMBRE,RAZONSOCIAL,APELLID1,TIPTRIBU, '+
                            'CREDITCL,TELEFONO,MAIL,DIRECCIO,IDPAIS,CODPROVINCIA,CODCANTON) ' +
                            ' VALUES ( '+
                            ' '+INTTOSTR(CODCLIEN)+' '+
                            ','+INTTOSTR(TIPO_DOCUMENTO)+' '+
                            ','+INTTOSTR(TIPO_DOCUMENTO)+' '+
                            ','+#39+TRIM(NRO_DOCUMENTO)+#39+' '+
                            ',''1'' '+
                            ','+#39+TRIM(TIPOPERSONA)+#39+' '+
                            ','+#39+TRIM(NOMBRE)+#39+' '+
                            ','+#39+TRIM(RAZONSOCIAL)+#39+' '+
                            ','+#39+TRIM(APELLIDO)+#39+' '+
                            ',''C'' '+ //no definido
                            ',''N'' '+
                            ','+#39+TRIM(TELEFONO)+#39+' '+
                            ','+#39+TRIM(EMAIL)+#39+' '+
                            ','+#39+TRIM(DIRECCION)+#39+' '+
                            ',''1'' '+
                            ','+INTTOSTR(CIUDAD)+' '+
                            ','+INTTOSTR(CANTON)+' '+
                            ')';
                end else begin
                  MEMO1.Lines.Add('Ya existe el Cliente: '+INTTOSTR(CODCLIEN));
                  RxTrayIcon1.HiNT:='Ya existe el Cliente: '+INTTOSTR(CODCLIEN);
                  APPLICATION.ProcessMessages;
                end;

          if ExisteCli=0 then
           with tsqlQuery.Create(nil) do
            try
              SQLConnection:= MYBD;
                MEMO1.Lines.Add('CREANDO CLIENTE: '+INTTOSTR(CODCLIEN));
                RxTrayIcon1.HiNT:='CREANDO CLIENTE: '+INTTOSTR(CODCLIEN);
                APPLICATION.ProcessMessages;
                SQL.Clear;
                SQL.Add(sqloracle);
                ExecSQL;
                MEMO1.Lines.Add('TRANSACCION: OK');
                APPLICATION.ProcessMessages;

           EXCEPT
             on E: Exception do
                      BEGIN
                        MEMO1.Lines.Add('TRANSACCION: ERROR');
                        APPLICATION.ProcessMessages;
                        GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| PLANTA '+NOMPLANTA+'. NO SE INSERTO CLIENTE '+INTTOSTR(CODCLIEN)+'. POR :'+ E.message);
                      END;
           END;

        {Insertar los datos de la tabla reserva del SQL a la tabla tdatosturnos del Oracle}
         if (Existe=0) then
           begin

          {GENERO EL CODIGO DE TURNO si no existe}
          with tsqlQuery.Create(nil) do
            try
            SQLConnection:= MYBD;
            SQL.Add('select SQ_TDATOSTURNO_CODTURNO.NEXTVAL from DUAL');
            Open;
            CODTURNO:=fields[0].ASInteger;
          finally
            close;
            free;
          end;

                {inserto en tdatosturno}
                sqloracle:='INSERT INTO TDATOSTURNO (CODTURNO,FECHATURNO,HORATURNO,FECHAALTA,PATENTE,'+
                            'NROORDEN,IMPORTE,CODVEHIC,CODCLIEN,ESTADO,IDPAGO,NUMINSPEC,MOTIVO )'+
                            ' VALUES ( '+
                            ' '+INTTOSTR(CODTURNO)+' '+
                            //',''TO_DATE('+#39+TRIM(FECHATURNO)+#39+',''DD/MM/YYYY'')'+
                            ','+#39+TRIM(FECHATURNO)+#39+' '+
                            ','+#39+TRIM(HORATURNO)+#39+' '+
                            //',''TO_DATE('+#39+TRIM(FECHALTA)+#39+',''DD/MM/YYYY'')'+
                            ','+#39+TRIM(FECHALTA)+#39+' '+
                            ','+#39+TRIM(PATENTE)+#39+' '+
                            ','+INTTOSTR(NROORDEN)+' '+
                            ','+#39+TRIM(IMPORTEFAC)+#39+' '+
                            ','+INTTOSTR(CODVEHIC)+' '+
                            ','+INTTOSTR(CODCLIEN)+' '+
                            ','+INTTOSTR(ESTADO)+' '+
                            ','+INTTOSTR(IDPAGO)+' '+
                            ','+INTTOSTR(NUMINSPEC)+' '+
                            ',''RESERVA'' '+
                            ')';
                end else begin
                  MEMO1.Lines.Add('Ya existe el Turno: '+INTTOSTR(IDPAGO));
                  RxTrayIcon1.HiNT:='Ya existe el Turno: '+INTTOSTR(IDPAGO);
                  APPLICATION.ProcessMessages;
                end;

          if Existe=0 then
           with tsqlQuery.Create(nil) do
            try
              SQLConnection:= MYBD;
                MEMO1.Lines.Add('AGREGANDO TURNO: '+INTTOSTR(CODTURNO));
                RxTrayIcon1.HiNT:='AGREGANDO TURNO: '+INTTOSTR(CODTURNO);
                APPLICATION.ProcessMessages;
                SQL.Clear;
                SQL.Add(sqloracle);
                ExecSQL;
                MEMO1.Lines.Add('TRANSACCION: OK');
                APPLICATION.ProcessMessages;
                ACTUALIZAR_CAMPO_IMPORTADO(IDPAGO);
                DoFacturacion(CODCLIEN,CODVEHIC,IDPAGO,NROORDEN,IMPORTEFAC);{Inserto en tfacturas los pagos cobrados}

           EXCEPT
             on E: Exception do
                      BEGIN
                         MEMO1.Lines.Add('TRANSACCION: ERROR');
                         APPLICATION.ProcessMessages;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| PLANTA '+NOMPLANTA+'. NO SE INSERTO TURNO '+INTTOSTR(CODTURNO)+'. POR :'+ E.message);
                      END;
           END;
           modulo.QUERY_WEB.NEXT;
        END;
      ACTUALIZARAUSENTES;
      INFORMARTURNOS; {Informo a la web los turnos inspeccionados}
 //Application.MessageBox( 'PROCESO TERMINADO.', 'Atención', // MB_ICONINFORMATION );
END;

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

//IF TRIM(TIMETOSTR(TIME))=TRIM(HORA_EEJCUTAR) THEN
//BEGIN
HINT:='EXPOTANDO...';
timer1.Enabled:=falsE;
MYBD.Close;
 SELF.EJECUTAR;
 timer1.Interval:=60000; //Chequea cada 1 min
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
MYBD.Close;
end;

procedure TForm1.Ocultar1Click(Sender: TObject);
begin
  HIDE;
end;

procedure TForm1.Mostrar1Click(Sender: TObject);
begin
  SHOW;
end;

{function CreateOleObject(const ClassName: string): IDispatch;
var
  ClassID: TCLSID;
begin
  ClassID := ProgIDToClassID(ClassName);
  OleCheck(CoCreateInstance(ClassID, nil, CLSCTX_INPROC_SERVER or
    CLSCTX_LOCAL_SERVER, IDispatch, Result));
end; }

//Importa los datos del banco para facurar.
procedure TForm1.DoImportacionExlsOracle;

const
//Datos
F_DAT = 13; //Produbanco
F_FAC = 2;  //Facilito

var
  si: String;
  sqloracle,archivo: String;
  Existe:INTEGER;

  VARIABLE1,VARIABLE2,VARIABLE3,
  VARIABLE4,VARIABLE5,VARIABLE6,
  VARIABLE7 :STRING;

begin
self.CONEXION;
  try
    OpenExcel.Title := 'Seleccione el fichero que desea Importar los Datos a Oracle';
    if OpenExcel.Execute then
      begin
        Try
          ExcelApp := CreateOleObject('Excel.Application');
        except
          ExcelApp := CreateOleObject('Excel.Application');
        end;

        ExcelLibro := ExcelApp.Workbooks.open(OpenExcel.FileName);
        ExcelHoja := ExcelLibro.Worksheets[1];

        ExcelApp.DisplayAlerts := False;
        ExcelApp.Visible := False;

       //copiar los datos a los campos en la tabla de Oracle
       archivo:= extractfilename(OpenExcel.FileName);

       if archivo = 'ReporteMovimientos.xlsx' then begin
          f:= F_DAT;
       end else begin
          f:= F_FAC;
       end;

       si := IntToStr( f );

       repeat

       {Asigno a las variables los valores de las columnas que se van a exportar}
       begin
          if ExcelHoja.Range['C'+si,'C'+si].Value2 = 'EMOT DURAN' then begin
             VARIABLE1 := ExcelHoja.Range['G'+si,'G'+si].Value2; // Reserva/REFERENCIA ADICIONAL
             VARIABLE2 := ExcelHoja.Range['F'+si,'F'+si].Value2; // PATENTE
             VARIABLE3 := ExcelHoja.Range['I'+si,'I'+si].Value2; // Importe
             VARIABLE4 := ExcelHoja.Range['I'+si,'I'+si].Value2; // Importe Pro
             VARIABLE5 := ExcelHoja.Range['E'+si,'E'+si].Value2; // nombre cliente/Razonsocial
             VARIABLE6 := ExcelHoja.Range['A'+si,'A'+si].Value2; // fechaCobro
             VARIABLE7 := 'PROCESO OK'; //estado
          end else if ExcelHoja.Range['F'+si,'F'+si].Value2 = 'EC' then begin
             VARIABLE1 := stringreplace(ExcelHoja.Range['V'+si,'V'+si].Value2,'|','',[rfReplaceAll, rfIgnoreCase]); // Reserva/REFERENCIA ADICIONAL
             VARIABLE2 := ExcelHoja.Range['J'+si,'J'+si].Value2; // PATENTE
             VARIABLE3 := ExcelHoja.Range['L'+si,'L'+si].Value2; // Importe
             VARIABLE4 := ExcelHoja.Range['M'+si,'M'+si].Value2; // Importe Pro
             VARIABLE5 := ExcelHoja.Range['K'+si,'K'+si].Value2; // nombre cliente/Razonsocial
             VARIABLE6 := FormatdateTime('DD/MM/YYYY',ExcelHoja.Range['E'+si,'E'+si].Value2); // fechaCobro
             VARIABLE7 := ExcelHoja.Range['Q'+si,'Q'+si].Value2; //estado
          end;
       end;

          sdsfConsulta := TSQLDataSet.Create(application);
          sdsfConsulta.SQLConnection := MyBD;
          sdsfConsulta.CommandType := ctQuery;

          dspfConsulta := TDataSetProvider.Create(application);
          dspfConsulta.DataSet := sdsfConsulta;
          dspfConsulta.Options := [poIncFieldProps,poAllowCommandText];
          fConsulta := TClientDataSet.Create(Application);

          fConsulta.SetProvider(dspfConsulta);

          with fConsulta do
          BEGIN
            Screen.Cursor := crHourglass;
            ////Guardar los datos en la tablaOracle
            {Seteo el formato de fecha en el Oracle}
            commandtext := 'alter session set nls_date_format = ''dd/mm/yyyy''';
            Execute;
            close;

           {Realizo el insert de los datos del Excel a la tabla} //tabla de TESTING
           SetProvider(dspfConsulta);

           {Realizo el insert de los datos del Excel a la tabla}
           IF TRIM(VARIABLE7) = 'PROCESO OK' THEN BEGIN //Si la reserva fue cobrada, inserto.

           {Consulto si existe el cobro en COBROSBANCO} {
           with tsqlQuery.Create(nil) do
            try
             SQLConnection:= MYBD;
             SQL.Add('select count(*) from COBROSBANCO where RESERVA='+VARIABLE1);
             Open;
             Existe:=fields[0].ASInteger;
           finally
             close;
             free;
           end; }

           //IF (Existe = 0) THEN BEGIN
           sqloracle:='INSERT INTO COBROSBANCO (RESERVA,PATENTE,VALOR,VALORPRO,CLIENTE,FECHACOBRO,ESTADO) '+
                      ' VALUES ( '+
                      ' TO_NUMBER('+#39+TRIM(VARIABLE1)+#39+') '+ //numero_orden/IDPAGO
                      ','+#39+TRIM(VARIABLE2)+#39+' '+ //PATENTE
                      ','+#39+TRIM(VARIABLE3)+#39+' '+ //Importe
                      ','+#39+TRIM(VARIABLE4)+#39+' '+ //Importe pro
                      ','+#39+TRIM(VARIABLE5)+#39+' '+ //nombre cliente/Razonsocial
                      ','+#39+TRIM(VARIABLE6)+#39+' '+ //fechaCobro
                      ','+#39+TRIM(VARIABLE7)+#39+' '+ //Estado
                      ')';
          { end else begin
               MEMO1.Lines.Add('Ya existe el Cobro: '+VARIABLE1);
               RxTrayIcon1.HiNT:='Ya existe el Cobro: '+VARIABLE1;
               APPLICATION.ProcessMessages;
           end;}

            with tsqlQuery.Create(nil) do
            try
             SQLConnection:= MYBD;
              MEMO1.Lines.Add('AGREGANDO COBRO: '+VARIABLE1);
              RxTrayIcon1.HiNT:='AGREGANDO COBRO: '+VARIABLE1;
              APPLICATION.ProcessMessages;
              SQL.Clear;
              SQL.Add(sqloracle);
              ExecSQL;

             EXCEPT
             on E: Exception do
                      BEGIN
                         MEMO1.Lines.Add('TRANSACCION: ERROR');
                         APPLICATION.ProcessMessages;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| NO SE INSERTO COBRO '+VARIABLE1+'. POR :'+ E.message);
                      END;
             END;
           END;

            Inc( f );
            si := IntToStr( f );

            if ( VarType( ExcelHoja.Range['F'+si,'F'+si].Value2 ) = VarEmpty ) then
              begin
                  ShowMessage('Terminado','Ha finalizado la transferencia de Datos con Exito.' );
                  Screen.Cursor := crdefault;
              end;
            end;

          until ( VarType( ExcelHoja.Range['F'+si,'F'+si].Value2 ) = VarEmpty );

      try
          ExcelApp.Workbooks.Close;
          ExcelApp.Quit;
          ExcelApp:=Unassigned;
          ExcelLibro:=Unassigned;
      except
            ShowMessage('Error','La aplicación Excel no se pudo finalizar automaticamente.');
            ExcelApp.Visible := True;
      end;
   end;

   except
      ShowMessage('Error','No se pudo Migrar los datos.');
   end;
   
      //Mata el proceso de excel.
      KillTask('EXCEL.exe');

     //Actualizo el estado de la reserva luego de importar.
     //ActualizaEstadoReserva;

end;

Procedure TForm1.ActualizaEstadoReserva;

VAR
IDPAGO,Existe:LONGINT;
QUERY_MSSQL:string;

BEGIN

{Busco los pagos acreditados por el banco}
with tsqlQuery.Create(nil) do
    try
        SQLConnection:= MYBD;
        SQL.Add('SELECT DISTINCT '+
                'CB.RESERVA '+
                //'CB.RESACTUALIZADA '+
                'FROM COBROSBANCO CB '+
                'WHERE CB.RESACTUALIZADA = ''N'' '+
                '  AND CB.ESTADO = ''PROCESO OK'' ');
        Open;

        WHILE NOT EOF DO

        BEGIN
        IDPAGO:=FIELDBYNAME('RESERVA').ASINTEGER;

        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;
        modulo.QUERY_WEB.SQL.Add('SELECT COUNT(*) FROM RESERVA R '+
                                 'WHERE R.NUMERO = '+inttostr(IDPAGO)+
                                 '  AND R.CODESTADO = 0 ');
        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.Open;
        Existe:=modulo.QUERY_WEB.Fields[0].AsInteger;

        IF (Existe > 0) THEN
          BEGIN
                QUERY_MSSQL:='UPDATE RESERVA SET CODESTADO = 1 '+
                             ' WHERE CODESTADO = 0 '+
                             '   AND NUMERO = '+inttostr(IDPAGO);


          IF (Existe > 0) THEN
             modulo.CONEXION.BeginTrans;
               TRY
                MEMO1.Lines.Add('ACTUALIZANDO ESTADO RESERVA: '+INTTOSTR(IDPAGO));
                RxTrayIcon1.HiNT:='ACTUALIZANDO ESTADO RESERVA: '+INTTOSTR(IDPAGO);
                APPLICATION.ProcessMessages;
                modulo.QUERY_WEB.Close;
                modulo.QUERY_WEB.SQL.Clear;
                modulo.QUERY_WEB.SQL.Add(QUERY_MSSQL);
                modulo.QUERY_WEB.ExecSQL;
                modulo.CONEXION.CommitTrans;
                MEMO1.Lines.Add('ESTADO RESERVA ACTUALIZADO');
                APPLICATION.ProcessMessages;

          with tsqlQuery.Create(nil) do
           try
             SQLConnection:= MYBD;
             SQL.Add('UPDATE COBROSBANCO '+
                     'SET RESACTUALIZADA = ''S'' '+
                     'WHERE RESACTUALIZADA = ''N'' '+
                     '  AND RESERVA = '+inttostr(IDPAGO));
             ExecSQL;
            finally
              Close;
              Free;
            end;

           EXCEPT
             on E: Exception do
                      BEGIN
                         MEMO1.Lines.Add('TRANSACCION: ERROR');
                         APPLICATION.ProcessMessages;
                         modulo.CONEXION.RollbackTrans;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| RESERVA: '+INTTOSTR(IDPAGO)+' NO SE PUDO ACTUALIZAR POR :'+ E.message);
                      END;
           END;

         END ELSE
           BEGIN
               MEMO1.Lines.Add('RESERVA: '+INTTOSTR(IDPAGO)+ ' YA FUE ACTUALIZADA ANTERIORMENTE o FUE CANCELADA' );
               RxTrayIcon1.HiNT:='RESERVA: '+INTTOSTR(IDPAGO)+ ' YA FUE ACTUALIZADA ANTERIORMENTE o FUE CANCELADA' ;
               APPLICATION.ProcessMessages;
               modulo.QUERY_WEB.Close;
               modulo.QUERY_WEB.SQL.Clear;
           END;
        NEXT;
       END;

  finally
        Close;
        Free;
  end;
END;

Procedure TForm1.DoFacturacion(CODCLIEN,CODVEHIC,IDPAGO,NROORDEN:longint;IMPORTEFAC:STRING);

//var
//CODFACTU,Existe:LONGINT;
//sqloracle:string;
//IMPORTEBANCO,NUMFACTU:string;

BEGIN

 with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PR_GENERAFACTURAS ';
        Prepared := true;
        ParamByName('CODCLIEN').Value := IntToStr(CODCLIEN);
        ParamByName('CODVEHIC').Value := IntToStr(CODVEHIC);
        ParamByName('IDPAGO').Value := IntToStr(IDPAGO);
        ParamByName('NROORDEN').Value := IntToStr(NROORDEN);
        ParamByName('IMPORTE').Value := TRIM(IMPORTEFAC);
        ExecProc;
        Close;
        finally
          Free;
        end;

{Controlo que la reserva no haya sido facturada antes}  {
with tsqlQuery.Create(nil) do
  try
     SQLConnection:= MYBD;
     SQL.Add('SELECT COUNT(IDPAGO) FROM TFACTURAS WHERE IDPAGO ='+IntToSTR(IDPAGO) );
     Open;
     Existe:=fields[0].ASInteger;
  finally
    close;
    free;
  end;

IF (Existe = 0) THEN BEGIN
{GENERO EL CODIGO DE FACTURA}    {
with tsqlQuery.Create(nil) do
  try
     SQLConnection:= MYBD;
     SQL.Add('SELECT SQ_TFACTURAS_CODFACTU.NEXTVAL FROM DUAL');
     Open;
     CODFACTU:=fields[0].ASInteger;
  finally
    close;
    free;
  end;
{
with tsqlQuery.Create(nil) do
  try
     SQLConnection:= MYBD;
     SQL.Add('SELECT ''25,58'' AS IMPORTE, ''1'' AS NUMFACTU FROM COBROSBANCO '+
             'WHERE NROORDEN = '+inttostr(IDPAGO)+
             '');
     Open;
     IMPORTEBANCO:=fields[0].AsString;
     NUMFACTU:=fields[1].AsString;
  finally
    close;
    free;
  end;
 }         {
 NUMFACTU:='1'; //Temporal
 IF IMPORTE = '0' THEN BEGIN
    IMPORTEBANCO:='0';
 END ELSE BEGIN
    IMPORTEBANCO:=IMPORTE;
 END;

          sqloracle:='INSERT INTO TFACTURAS (CODFACTU, IMPRESA, TIPFACTU, TIPTRIBU, FORMPAGO, IVAINSCR, CODCLIEN, IVANOINS, '+
                     'ERROR, IMPONETO, NUMFACTU, TIPOCLIENTE_ID, IIBB, IDPAGO, NROORDEN, CODVEHIC, IDCANCELACION)'+
                     ' VALUES ( '+
                     ' '+INTTOSTR(CODFACTU)+' '+
                     ',''S'' '+
                     ',''C'' '+
                     ',''C'' '+
                     ',''M'' '+
                     ',''0'' '+
                     ','+INTTOSTR(CODCLIEN)+' '+
                     ',''0'' '+
                     ',''N'' '+
                     ','+#39+TRIM(IMPORTEBANCO)+#39+' '+
                     ','+#39+TRIM(NUMFACTU)+#39+' '+  //??
                     ',''1'' '+
                     ',''0'' '+
                     ','+INTTOSTR(IDPAGO)+' '+
                     ','+INTTOSTR(NROORDEN)+' '+
                     ','+INTTOSTR(CODVEHIC)+' '+
                     ',''1'' '+
                     ')';

           with tsqlQuery.Create(nil) do
            try
              SQLConnection:= MYBD;
                MEMO1.Lines.Add('AGREGANDO FACTURA: '+INTTOSTR(CODFACTU));
                RxTrayIcon1.HiNT:='AGREGANDO FACTURA: '+INTTOSTR(CODFACTU);
                APPLICATION.ProcessMessages;
                SQL.Clear;
                SQL.Add(sqloracle);
                ExecSQL;
                MEMO1.Lines.Add('FACTURA '+INTTOSTR(CODFACTU)+' INGRESADA');
                APPLICATION.ProcessMessages;

           EXCEPT
             on E: Exception do
                      BEGIN
                         MEMO1.Lines.Add('TRANSACCION: ERROR');
                         APPLICATION.ProcessMessages;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| NO SE CREO LA FACTURA PARA EL TURNO '+INTTOSTR(CODTURNO)+'. POR :'+ E.message);
                      END;
           END;

          sqloracle:='INSERT INTO TFACT_ADICION (CODFACT,TIPOFAC,PTOVENT,IDUSUARI)'+
                     ' VALUES ( '+
                     ' '+INTTOSTR(CODFACTU)+' '+
                     ',''C'' '+
                     ',''1'' '+
                     ',''0'' '+
                     ')';

           with tsqlQuery.Create(nil) do
            try
              SQLConnection:= MYBD;
                MEMO1.Lines.Add('AGREGANDO ADICION FACTURA: '+INTTOSTR(CODFACTU));
                RxTrayIcon1.HiNT:='AGREGANDO ADICION FACTURA: '+INTTOSTR(CODFACTU);
                APPLICATION.ProcessMessages;
                SQL.Clear;
                SQL.Add(sqloracle);
                ExecSQL;
                MEMO1.Lines.Add('ADICION FACTURA '+INTTOSTR(CODFACTU)+' INGRESADA');
                APPLICATION.ProcessMessages;

           EXCEPT
             on E: Exception do
                      BEGIN
                         MEMO1.Lines.Add('TRANSACCION: ERROR');
                         APPLICATION.ProcessMessages;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| NO SE CREO LA ADICION DE FACTURA PARA EL TURNO '+INTTOSTR(CODTURNO)+'. POR :'+ E.message);
                      END;
           END;
  END; }
END;

{Exporto los datos a txt para el banco}
Procedure TForm1.DoExportacionTXT;

var
F : TextFile;
QUERY_MSSQL:STRING;
//sArchivo: string;

CodigoOrientacion,CuentaEmpresa,SecuencialCobro,
ComprobanteDeCobro,ContraPartida,MONEDA,VALOR,
FormaPago,BANCO,NroDeCuenta,TipoIdClienteDeudor,
NroIdClienteDeudor,NombreClienteDeudor,DireccionDeudor,
CiudadDeudor,TelefonoDeudor,LocalidadCobro,Referencia,
ReferenciaAdicional,BaseImponibleRentaServ,CodigoRetencionRentaServ,
BaseImponibleRentaBienes,CodigoRetencionRentaBienes,BaseRetencionIVAservicios,
CodigoRetencionIVAservicios,BaseRetencionIVABienes,CodigoRetencionIVABienes,
BaseIVA0,BaseICE,canton_cliente,TipoDeCuenta,IDPAGO:STRING;

FECHA:TDateTime;
NOMBREEMBRESA,CODIGOSERVICIO,IDCONTRATO:STRING;

begin
self.CONEXION;

NOMBREEMBRESA:='APPLUS';
CODIGOSERVICIO:='CSC';
IDCONTRATO:='000';
FECHA:=Now;

  {Consulto los pagos a facturar}
         modulo.QUERY_WEB.Close;
         modulo.QUERY_WEB.SQL.Clear;
         modulo.QUERY_WEB.SQL.Add('SELECT '+
                                  're.numero AS IDPAGO '+
                                  ',dcob.cod_orientacion '+
                                  ',dcob.contrapartida AS NROORDEN '+
                                  ',dcob.cuenta_empresa '+
                                  ',re.patente '+
                                  ',dcob.valor AS IMPORTE '+
                                  ',dcob.secuencial_cobro '+
                                  ',dcob.comprobante_cobro '+
                                  ',dcob.cod_banco '+
                                  ',dcob.forma_de_pago '+
                                  ',dcob.moneda '+
                                  //',dcob.referencia '+  //re.patente
                                  ',dcob.referencia_adicional '+
                                  ',re.codestado AS ESTADO '+
                                  ',dre.nro_repeticion AS NUMINSPEC '+
                                  ',dcob.nombre_cliente '+
                                  ',re.TIPO_DOCUMENTO AS CODDOCUMENTO '+
                                  ',re.NRO_DOCUMENTO AS DOCUMENTO '+
                                  //',re.email '+
                                  //',re.telefono '+
                                  //',dcob.tipo_de_cuenta '+
                                  //',dcob.numero_de_cuenta '+
                                  //',dcob.localidad_cobro '+
                                  ',dcob.direccion_cliente AS Direccion '+
                                  ',dcob.localidad_cobro AS Localidad '+
                                  ',dcob.ciudad_cliente AS CIUDAD '+
                                  ',dcob.canton_cliente AS CANTON '+
                                  ',dcob.base_imp_renta_serv '+
                                  ',dcob.cod_retencion_renta_serv '+
                                  ',dcob.base_imp_renta_bienes '+
                                  ',dcob.cod_retencion_renta_bienes '+
                                  ',dcob.base_retencion_IVA_serv '+
                                  ',dcob.cod_retencion_IVA_serv '+
                                  ',dcob.base_retencion_IVA_bienes '+
                                  ',dcob.codigo_retencion_IVA_bienes '+
                                  //',dcob.base_IVA_0 '+
                                  //',dcob.base_ICE '+
                                  'FROM reserva re inner join detalles_reserva dre '+
                                  'on re.numero = dre.nro_reserva '+
                                  'inner join detalles_cobros dcob '+
                                  'on dcob.contrapartida = re.numero '+
                                  'WHERE re.codestado not like ''-%'' '+
                                  //' AND re.IMPORTADO = ''N'' '+
                                  ' AND re.codestado = 0 '+
                                  ' AND dcob.valor <> ''0000000000000'' '+
                                  ' ORDER BY re.fechalta');

        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.Open;

        MEMO1.Lines.Add('Iniciando Exportacion De Pagos a TXT...');
        RxTrayIcon1.HiNT:='Iniciando Exportacion De Pagos a TXT...';
        APPLICATION.ProcessMessages;

        WHILE NOT modulo.QUERY_WEB.Eof DO

        BEGIN

        //Datos Facturacion Cliente
        IDPAGO:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('IDPAGO').ASSTRING);
        CodigoOrientacion:=modulo.QUERY_WEB.FIELDBYNAME('cod_orientacion').ASSTRING; //'CO'; //char 2 OBLIGATORIO 'CO' = PAGO CAMPO FIJO
        CuentaEmpresa:=modulo.QUERY_WEB.FIELDBYNAME('cuenta_empresa').ASSTRING; //num 11 OBLIGATORIO CAMPO FIJO
        SecuencialCobro:=modulo.QUERY_WEB.FIELDBYNAME('secuencial_cobro').ASSTRING; //'00000001'; //num 7 OBLIGATORIO
        ComprobanteDeCobro:=modulo.QUERY_WEB.FIELDBYNAME('comprobante_cobro').ASSTRING; //'0'; // char 20 OPCIONAL CAMPO FIJO
        ContraPartida:=modulo.QUERY_WEB.FIELDBYNAME('NROORDEN').ASSTRING; //'00000000000000000000'; // char 20 OBLIGATORIO
        MONEDA:=modulo.QUERY_WEB.FIELDBYNAME('MONEDA').ASSTRING;  //'USD'; // char 3 OBLIGATORIO USD = dólares CAMPO FIJO
        VALOR:=modulo.QUERY_WEB.FIELDBYNAME('IMPORTE').ASSTRING; //'0000000003000'; // num 13 OBLIGATORIO 11 enteros y 2 decimales
        FormaPago:= modulo.QUERY_WEB.FIELDBYNAME('forma_de_pago').ASSTRING; //'REC'; // char 3 OBLIGATORIO USAR 'REC' = Recaudación CAMPO FIJO
        BANCO:=modulo.QUERY_WEB.FIELDBYNAME('cod_banco').ASSTRING; //'0036'; //char 4 OBLIGATORIO '0036' corresponde a produbanco CAMPO FIJO
        //TipoDeCuenta:=modulo.QUERY_WEB.FIELDBYNAME('tipo_de_cuenta').ASSTRING;
        //NroDeCuenta:=modulo.QUERY_WEB.FIELDBYNAME('numero_de_cuenta').ASSTRING; // num 11 OBLIGATORIO CAMPO FIJO
        TipoDeCuenta:=' ';
        NroDeCuenta:=' '; // num 11 OBLIGATORIO CAMPO FIJO
        TipoIdClienteDeudor:=modulo.QUERY_WEB.FIELDBYNAME('CODDOCUMENTO').ASSTRING; //char 1 OBLIGATORIO C = Cédula, R = RUC, P = Pasaporte
        NroIdClienteDeudor:=modulo.QUERY_WEB.FIELDBYNAME('DOCUMENTO').ASSTRING; // char 13 si es RUC char 10 si es CI OBLIGATORIO completar ceros a la izquierda
        NombreClienteDeudor:=modulo.QUERY_WEB.FIELDBYNAME('nombre_cliente').ASSTRING; //(NOMBRE+' '+APELLIDO); // char 40 OBLIGATORIO
        DireccionDeudor:=modulo.QUERY_WEB.FIELDBYNAME('DIRECCION').ASSTRING; // char 40 OPCIONAL
        CiudadDeudor:=modulo.QUERY_WEB.FIELDBYNAME('CIUDAD').ASSTRING; // char 20 OPCIONAL
        //TelefonoDeudor:=modulo.QUERY_WEB.FIELDBYNAME('TELEFONO').ASSTRING;// char 20 OPCIONAL
        //LocalidadCobro:=modulo.QUERY_WEB.FIELDBYNAME('localidad_cobro').ASSTRING; // char 20 opcional (en blanco todas)
        TelefonoDeudor:=' ';// char 20 OPCIONAL 
        LocalidadCobro:=' ';// char 20 opcional (en blanco todas)
        Referencia:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('patente').ASSTRING); // char 200 OBLIGATORIO facturas o comporbantes de referencia para el cobro //Referencia
        ReferenciaAdicional:=modulo.QUERY_WEB.FIELDBYNAME('referencia_adicional').ASSTRING; // char 100 OPCIONAL datos adicionales que quieran enviarse (Aquí podemos enviar la demás información)
        BaseImponibleRentaServ:=modulo.QUERY_WEB.FIELDBYNAME('base_imp_renta_serv').ASSTRING; //'0'; // num 13 OBLIGATORIO? 0 cuando no corresponde
        CodigoRetencionRentaServ:=modulo.QUERY_WEB.FIELDBYNAME('cod_retencion_renta_serv').ASSTRING;//'NA'; // char 20 OBLIGATORIO? NA cuando no corresponde
        BaseImponibleRentaBienes:=modulo.QUERY_WEB.FIELDBYNAME('base_imp_renta_bienes').ASSTRING;//'0'; // num 13 OBLIGATORIO?
        CodigoRetencionRentaBienes:=modulo.QUERY_WEB.FIELDBYNAME('cod_retencion_renta_bienes').ASSTRING;//'NA'; // char 20 OBLIGATORIO? NA cuando no corresponde
        BaseRetencionIVAservicios:=modulo.QUERY_WEB.FIELDBYNAME('base_retencion_IVA_serv').ASSTRING; //'0'; // num 13 OBLIGATORIO?
        CodigoRetencionIVAservicios:=modulo.QUERY_WEB.FIELDBYNAME('cod_retencion_IVA_serv').ASSTRING; //'NA'; // char 20 OBLIGATORIO? NA cuando no corresponde
        BaseRetencionIVABienes:=modulo.QUERY_WEB.FIELDBYNAME('base_retencion_IVA_bienes').ASSTRING; //'0'; // num 13 OBLIGATORIO?
        CodigoRetencionIVABienes:=modulo.QUERY_WEB.FIELDBYNAME('codigo_retencion_IVA_bienes').ASSTRING;//'NA'; // char 20 OBLIGATORIO? NA cuando no corresponde
        //BaseIVA0:=modulo.QUERY_WEB.FIELDBYNAME('base_IVA_0').ASSTRING; // num 13 OBIGATORIO?
        //BaseICE:=modulo.QUERY_WEB.FIELDBYNAME('base_ICE').ASSTRING; // num 13 OPCIONAL
        BaseIVA0:=' '; // num 13 OBIGATORIO?
        BaseICE:=' '; // num 13 OPCIONAL
        canton_cliente:=modulo.QUERY_WEB.FIELDBYNAME('CANTON').ASSTRING;

        sArchivo := ExtractFilePath( 'F:\PRODUBANCO\' ) + NOMBREEMBRESA+'_'+CODIGOSERVICIO+'_'+IDCONTRATO+'_'+formatdatetime('yyyymmdd',FECHA)+'_IN_'+Referencia+'_'+IDPAGO+'.txt';
        //sArchivo := ExtractFilePath( 'C:\Argentin\SagVTV\Cobros\' ) + NOMBREEMBRESA+'_'+CODIGOSERVICIO+'_'+IDCONTRATO+'_'+formatdatetime('yyyymmdd',FECHA)+'_IN_'+Referencia+'_'+IDPAGO+'.txt'; //TESTING
        AssignFile( F, sArchivo );

         //WriteLn Inserta registrons linea a linea
         //Write Inserta registros continuamente en 1 linea
         Rewrite(F);
           Write(F,CodigoOrientacion+
                ''#9+CuentaEmpresa+
                ''#9+SecuencialCobro+
                ''#9+ComprobanteDeCobro+
                ''#9+Referencia+ //''#9+ContraPartida+
                ''#9+MONEDA+
                ''#9+VALOR+
                ''#9+FormaPago+
                ''#9+BANCO+
                ''#9+TipoDeCuenta+
                ''#9+NroDeCuenta+
                ''#9+TipoIdClienteDeudor+
                ''#9+NroIdClienteDeudor+
                ''#9+NombreClienteDeudor+
                ''#9+DireccionDeudor+
                ''#9+CiudadDeudor+
                ''#9+TelefonoDeudor+
                ''#9+LocalidadCobro+
                ''#9+ReferenciaAdicional+
                ''#9+ContraPartida+ //''#9+Referencia+
                ''#9+BaseImponibleRentaServ+
                ''#9+CodigoRetencionRentaServ+
                ''#9+BaseImponibleRentaBienes+
                ''#9+CodigoRetencionRentaBienes+
                ''#9+BaseRetencionIVAservicios+
                ''#9+CodigoRetencionIVAservicios+
                ''#9+BaseRetencionIVABienes+
                ''#9+CodigoRetencionIVABienes+
                ''#9+BaseIVA0+
                ''#9+BaseICE+#9
                //''#9+canton_cliente
                );
                {
                QUERY_MSSQL:='UPDATE RESERVA SET '+
                             ' CODESTADO = 1 '+
                             ' WHERE CODESTADO = 0 '+
                             '   AND NUMERO = '+TRIM(IDPAGO);
                             //'   AND PATENTE = '+TRIM(Referencia);

             modulo.CONEXION.BeginTrans;
               TRY
                MEMO1.Lines.Add('ACTUALIZANDO RESERVA: '+TRIM(IDPAGO));
                RxTrayIcon1.HiNT:='ACTUALIZANDO RESERVA: '+TRIM(IDPAGO);
                APPLICATION.ProcessMessages;
                modulo.QUERY_WEB2.Close;
                modulo.QUERY_WEB2.SQL.Clear;
                modulo.QUERY_WEB2.SQL.Add(QUERY_MSSQL);
                modulo.QUERY_WEB2.ExecSQL;
                modulo.CONEXION.CommitTrans;
                MEMO1.Lines.Add('ESTADO RESERVA ACTUALIZADO');
                APPLICATION.ProcessMessages;

            EXCEPT
             on E: Exception do
                      BEGIN
                         MEMO1.Lines.Add('TRANSACCION: ERROR');
                         APPLICATION.ProcessMessages;
                         modulo.CONEXION.RollbackTrans;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| RESERVA: '+TRIM(IDPAGO)+' NO SE PUDO ACTUALIZAR POR :'+ E.message);
                      END;
           END;
           }
      modulo.QUERY_WEB.NEXT;
      CloseFile(F);
    end;
    //CloseFile(F);
    modulo.QUERY_WEB.Close;
    MEMO1.Lines.Add('Exportacion De Pagos a TXT Terminada');
    RxTrayIcon1.HiNT:='Exportacion De Pagos TXT Terminada';
    APPLICATION.ProcessMessages;
    //MEMO1.Lines.Add('Subiendo archivo al FTP...');
    //RxTrayIcon1.HiNT:='Subiendo archivo al FTP...';
    //SubirArchivo(sArchivo);
end;

Procedure TForm1.SubirArchivo( sArchivo: String );
var
  FTP: TIdFTP;
begin
  FTP := TIdFTP.Create( nil );
  FTP.Username := 'vtv\ftp';
  FTP.Password := '#ERVTV-2005-inspecciones#';
  FTP.Host := '10.100.10.4'; //o IP
  FTP.Port := 21;
  //FTP.passive := True;

  try
    FTP.Connect;

  EXCEPT
  on E: Exception do
    BEGIN
      MEMO1.Lines.Add('FTP: ERROR DE CONEXION');
      RxTrayIcon1.HiNT:='FTP: ERROR DE CONEXION';
      APPLICATION.ProcessMessages;
      GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+' No se ha podido conectar con el servidor FTP '+ E.message);
      raise Exception.Create('No se ha podido conectar con el servidor ' + FTP.Host );
    END;
  END;

  FTP.ChangeDir( '/FTP_DESCARGAS/' );   // con esto entras al directorio donde tenemos q poner el archivo
  FTP.Put( sArchivo, ExtractFileName( sArchivo ), False ); //sube archivo
  MEMO1.Lines.Add('Archivo enviado al FTP');
  RxTrayIcon1.HiNT:='Archivo enviado al FTP';
  APPLICATION.ProcessMessages;
  FTP.Disconnect;
  FTP.Free;
end;

procedure TForm1.ACTUALIZARAUSENTES;

begin

   with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'ACTUALIZAAUSENTES ';
        Prepared := true;
        ExecProc;
        Close;
    finally
      Free;
    end;

end;

procedure TForm1.ACTUALIZARCANCELADOS;

var
PATENTE,sqloracle,
FECHATURNO,HORATURNO:string;
ESTADO,IDPAGO,Existe:longint;

begin
        modulo.QUERY_WEB3.Close;
        modulo.QUERY_WEB3.SQL.Clear;
        modulo.QUERY_WEB3.SQL.Add('SELECT '+
                                 ' re.numero AS IDPAGO '+
                                 ',re.patente '+
                                 ',re.centro AS PLANTA '+
                                 ',re.fecha AS FECHATURNO '+
                                 ',re.hora AS HORATURNO '+
                                 ',re.codestado AS ESTADO '+
                                 ' FROM reserva re '+
                                 ' WHERE re.codestado = 2 '+
                                 '   AND re.importado = ''S'' '+
                                 '   AND re.INFORMADO = ''N'' '+
                                 '   AND re.fecha BETWEEN GETDATE()-10 AND GETDATE()+1 '+
                                 ' ORDER BY re.fecha');

        modulo.QUERY_WEB3.ExecSQL;
        modulo.QUERY_WEB3.Open;

        WHILE NOT modulo.QUERY_WEB3.Eof DO

        BEGIN
        //Tdatosturno
        PATENTE:=TRIM(modulo.QUERY_WEB3.FIELDBYNAME('PATENTE').ASSTRING);
        FECHATURNO:=TRIM(modulo.QUERY_WEB3.FIELDBYNAME('FECHATURNO').ASSTRING);
        HORATURNO:=TRIM(modulo.QUERY_WEB3.FIELDBYNAME('HORATURNO').ASSTRING);
        ESTADO:=modulo.QUERY_WEB3.FIELDBYNAME('ESTADO').ASInteger;
        IDPAGO:=modulo.QUERY_WEB3.FIELDBYNAME('IDPAGO').ASInteger;

        
        {Consulto si las reservas web existen en tdatosturno}
        with tsqlQuery.Create(nil) do
        try
          SQLConnection:= MYBD;
          SQL.Add('select count(*) from TDATOSTURNO where ESTADO in (1,7) AND IDPAGO='+inttostr(IDPAGO));
          Open;
          Existe:=fields[0].ASInteger;
        finally
         close;
         free;
        end;

		    if (Existe<>0) then
           begin
                {inserto en tdatosturno}
                sqloracle:='UPDATE TDATOSTURNO SET '+
                            ' ESTADO = '+INTTOSTR(ESTADO)+
                            ' WHERE IDPAGO = '+INTTOSTR(IDPAGO)+
                            '   AND ESTADO in (1,7) '+
                            '   AND ROWNUM = 1 '+
                            ')';
                end else begin
                  MEMO1.Lines.Add('EL TURNO YA FUE ACTUALIZADO: '+INTTOSTR(IDPAGO));
                  RxTrayIcon1.HiNT:='EL TURNO YA FUE ACTUALIZADO: '+INTTOSTR(IDPAGO);
                  APPLICATION.ProcessMessages;
                end;

          if (Existe<>0) then
           with tsqlQuery.Create(nil) do
            try
              SQLConnection:= MYBD;
                MEMO1.Lines.Add('ACTUALIZANDO TURNO: '+INTTOSTR(IDPAGO));
                RxTrayIcon1.HiNT:='ACTUALIZANDO TURNO: '+INTTOSTR(IDPAGO);
                APPLICATION.ProcessMessages;
                SQL.Clear;
                SQL.Add(sqloracle);
                ExecSQL;
                MEMO1.Lines.Add('TRANSACCION: OK');
                APPLICATION.ProcessMessages;

           EXCEPT
             on E: Exception do
                      BEGIN
                         MEMO1.Lines.Add('TRANSACCION: ERROR');
                         APPLICATION.ProcessMessages;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| PLANTA '+NOMPLANTA+'. NO SE ACTUALIZO EL TURNO '+INTTOSTR(IDPAGO)+'. POR :'+ E.message);
                      END;
           END;
           modulo.QUERY_WEB3.NEXT;
        END;
end;

procedure TForm1.INFORMARTURNOS;

var
Existe,NUMERO:LONGINT;
INFORMADO,INFORMADOWEB,QUERY_MSSQL,RESERVA,ESTADO:STRING;

begin

with tsqlQuery.Create(nil) do
    try
        SQLConnection:= MYBD;
        SQL.Add('SELECT DISTINCT COUNT(*) '+
                'FROM TDATOSTURNO '+
                'WHERE ESTADO <> 1 '+
                //'AND codinspe IS NOT NULL '+
                'AND INFORMADO = ''N'' '+
                'AND FECHATURNO BETWEEN SYSDATE -10 '+
                'AND SYSDATE +1 '+
                'ORDER BY IDPAGO');
        Open;
        Existe:=fields[0].ASInteger;
        finally
          Close;
          Free;
        end;

IF (Existe <> 0) THEN BEGIN

with tsqlQuery.Create(nil) do
    try
        SQLConnection:= MYBD;
        SQL.Add('SELECT DISTINCT IDPAGO AS RESERVA, ESTADO, INFORMADO '+
                'FROM TDATOSTURNO '+
                'WHERE ESTADO <> 1 '+
                //'AND codinspe IS NOT NULL '+
                'AND INFORMADO = ''N'' '+
                'AND FECHATURNO BETWEEN SYSDATE -10 '+
                'AND SYSDATE +1 '+
                'ORDER BY IDPAGO');
        Open;

        WHILE NOT EOF DO

        BEGIN
        RESERVA:=TRIM(FIELDBYNAME('RESERVA').ASSTRING);
        ESTADO:=TRIM(FIELDBYNAME('ESTADO').ASSTRING);
        INFORMADO:=TRIM(FIELDBYNAME('ESTADO').ASSTRING);

        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;
        modulo.QUERY_WEB.SQL.Add('SELECT NUMERO, INFORMADO FROM RESERVA '+
                                 ' WHERE NUMERO = '+TRIM(RESERVA)+
                                 '  AND CODESTADO = 1 '+
                                 '  AND INFORMADO = ''N'' ');
        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.Open;
        NUMERO:=modulo.QUERY_WEB.FIELDBYNAME('NUMERO').ASINTEGER;
        INFORMADOWEB:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('INFORMADO').ASSTRING);

        //IF (NUMERO = RESERVA) AND (INFORMADOWEB = INFORMADO)
        IF (NUMERO > 0) AND (INFORMADOWEB = 'N')
        THEN
          BEGIN
                QUERY_MSSQL:='UPDATE RESERVA SET '+
                             ' CODESTADO = '+TRIM(ESTADO)+
                             ',INFORMADO = ''S'' '+
                             ' WHERE CODESTADO = 1 '+
                             '   AND NUMERO = '+TRIM(RESERVA)+
                             '   AND INFORMADO = ''N'' ';

             modulo.CONEXION.BeginTrans;
               TRY
                MEMO1.Lines.Add('INFORMANDO TURNO: '+TRIM(RESERVA));
                RxTrayIcon1.HiNT:='INFORMANDO TURNO: '+TRIM(RESERVA);
                APPLICATION.ProcessMessages;
                modulo.QUERY_WEB.Close;
                modulo.QUERY_WEB.SQL.Clear;
                modulo.QUERY_WEB.SQL.Add(QUERY_MSSQL);
                modulo.QUERY_WEB.ExecSQL;
                modulo.CONEXION.CommitTrans;
                MEMO1.Lines.Add('ESTADO RESERVA ACTUALIZADO');
                APPLICATION.ProcessMessages;

          with tsqlQuery.Create(nil) do
           try
             SQLConnection:= MYBD;
             SQL.Add('UPDATE TDATOSTURNO '+
                     'SET INFORMADO = ''S'' '+
                     'WHERE INFORMADO = ''N'' '+
                     '  AND IDPAGO = '+TRIM(RESERVA));
             ExecSQL;
            finally
              Close;
              Free;
            end;

           EXCEPT
             on E: Exception do
                      BEGIN
                         MEMO1.Lines.Add('TRANSACCION: ERROR');
                         APPLICATION.ProcessMessages;
                         modulo.CONEXION.RollbackTrans;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| RESERVA: '+TRIM(RESERVA)+' NO SE PUDO ACTUALIZAR POR :'+ E.message);
                      END;
           END;

         END ELSE
           BEGIN
               MEMO1.Lines.Add('RESERVA: '+TRIM(RESERVA)+ ' YA FUE ACTUALIZADA ANTERIORMENTE' );
               RxTrayIcon1.HiNT:='RESERVA: '+TRIM(RESERVA)+ ' YA FUE ACTUALIZADA ANTERIORMENTE' ;
               APPLICATION.ProcessMessages;
               modulo.QUERY_WEB.Close;
               modulo.QUERY_WEB.SQL.Clear;
           END;
        NEXT;
       END;

  finally
        Close;
        Free;
  end;

  END ELSE
           BEGIN
               MEMO1.Lines.Add('NO HAY TURNOS PARA INFORMAR' );
               RxTrayIcon1.HiNT:='NO HAY TURNOS PARA INFORMAR' ;
               APPLICATION.ProcessMessages;
               modulo.QUERY_WEB.Close;
               modulo.QUERY_WEB.SQL.Clear;
           END;


END;

procedure TForm1.CONEXION; {PARA LA EXPORTACION A TXT SIN TENER QUE EJECUTAR TODO}
VAR
BASE,alias,userbd,password:STRING;
link:string;
LOG:textfile;
FE:STRING;

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
    if OpenKeyRead(APPLICATION_KEY_SQL) then
      Begin
        BASE:=ReadString('Base_Centro');
      end;
  Finally
    free;
  end;

conexion_virtual('db_web_ecuador');
IF CITAS_CONECT=TRUE THEN
BEGIN

   begin
     MEMO1.Clear;
     NOMPLANTA:=userbd; //ALIAS
     userbd:='SAGECUADOR';
     password:='02lusabaqui03';
     TestOfBD(alias,userbd,password,false);

     if se_conector=true then

      BEGIN
        form1.Caption:='CONECTADO A '+ userbd; //ALIAS
        memo1.Lines.Add('CONECTADO A: '+ userbd);  //ALIAS
        FORM1.HiNT:='CONECTADO A '+ userbd;  //ALIAS
        RxTrayIcon1.HiNT:='CONECTADO A '+ userbd;  //ALIAS
        APPLICATION.ProcessMessages;
        END else begin  end;
   mybd.Close;
end;

END;

end; 

END.
