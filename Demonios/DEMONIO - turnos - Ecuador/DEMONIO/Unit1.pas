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
    function KillTask(ExeFileName: string): Integer;
    Procedure SubirArchivo( sArchivo: String );
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
    PROCEDURE DoFacturacion;
    PROCEDURE TestOfBD(Alias, UserName, Password: String; Ageva: boolean);
    FUNCTION conexion_virtual(base:string):boolean;
    FUNCTION ENVIAR_A_WEB_TURNOS(IDPAGOhasta:longint;plantapasa:longint):BOOLEAN;
    FUNCTION GUARDA_LOG(MENSAJE:STRING):BOOLEAN;
    FUNCTION ACTUALIZAR_CAMPO_IMPORTADO(IDTURNO:LONGINT):boolean;
    PROCEDURE EJECUTAR;
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
                       // FORM1.memo1.Lines.Add('No se encontr� en el registro alg�n par�metro necesario para la conexi�n a la base de datos');
                       APPLICATION.ProcessMessages;

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
     userbd:='CABASM';
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

       {busco en la base oracle el id de planta(centro)} {
       with tsqlQuery.Create(nil) do
        try
          SQLConnection:= MYBD;
          SQL.Add('select (zona||estacion) centro from tvarios');
          Open;
          planta:=fields[0].AsInteger;

       finally
         close;
         free;
       end;}

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
PATENTE,IMPORTE,FECHAMATRI,NUMCHASIS,DIRECCION:string;
NOMBRE,APELLIDO,RAZONSOCIAL,TELEFONO,EMAIL:string;
FECHATURNO,HORATURNO,FECHALTA,NRO_DOCUMENTO,TIPOPERSONA:string;
Existe,ExisteVeh,ExisteCli:Longint;

BEGIN

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
                                  ',re.codestado AS ESTADO '+
                                  ',dre.nro_repeticion AS NUMINSPEC '+
                                  //'--tvehiculos '+
                                  ',dre.vin AS NUMCHASIS '+
                                  ',dre.MARCA AS CODMARCA '+
                                  ',dre.MODELO AS CODMODEL '+
                                  ',CONCAT(''01/01/'',dre.a�o) AS FECHAMATRI '+
                                  ',dre.a�o AS AnioFabr '+
                                  ',''1'' AS TIPOESPE '+
                                  ',''1'' AS tipo_destino'+
                                  ',''1'' AS tipo_vehiculo'+
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
                                  'WHERE re.codestado not like ''-%'' '+
                                  //'  AND re.NUMERO > '+inttostr(IDPAGOhasta)+
                                  ' AND re.IMPORTADO = ''N'' '+
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
        CODMARCA:=modulo.QUERY_WEB.FIELDBYNAME('CODMARCA').ASInteger;
        CODMODEL:=modulo.QUERY_WEB.FIELDBYNAME('CODMODEL').ASInteger;
        FECHAMATRI:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('FECHAMATRI').ASSTRING);
        AnioFabr:=modulo.QUERY_WEB.FIELDBYNAME('AnioFabr').ASInteger;
        tipo_vehiculo:=modulo.QUERY_WEB.FIELDBYNAME('tipo_vehiculo').ASInteger;
        tipo_destino:=modulo.QUERY_WEB.FIELDBYNAME('tipo_destino').ASInteger;
        TIPOESPE:=modulo.QUERY_WEB.FIELDBYNAME('TIPOESPE').ASInteger;


        //Tfacturas
        {codigo}

        IF TIPO_DOCUMENTO = 2 THEN
          BEGIN
            RAZONSOCIAL := NOMBRE;
            TIPOPERSONA := 'J'
        END ELSE BEGIN
          RAZONSOCIAL := 'NULL';
          TIPOPERSONA := 'N'
        END;

        {OBTENGO CODPRINVICIA SEGUN EL CANTON}
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

        {Consulto si las reservas web existen en tdatosturno}
        with tsqlQuery.Create(nil) do
        try
          SQLConnection:= MYBD;
          SQL.Add('select count(*) from TDATOSTURNO where CODTURNO='+inttostr(IDPAGO));
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
          SQL.Add('select count(*) from TCLIENTES where CODDOCUMENTO='+INTTOSTR(TIPO_DOCUMENTO)+' and documento ='+NRO_DOCUMENTO);
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
            SQL.Add('select CODCLIEN from TCLIENTES where CODDOCUMENTO='+INTTOSTR(TIPO_DOCUMENTO)+' and documento ='+NRO_DOCUMENTO);
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
                sqloracle:='INSERT INTO TVEHICULOS (CODVEHIC,FECMATRI,ANIOFABR,CODMARCA,CODMODEL,TIPOESPE,TIPODEST,NUMCHASIS,'+
                            'NUMMOTOR,NUMEJES,PATENTEN,ERROR) ' +
                            ' VALUES ( '+
                            ' '+INTTOSTR(CODVEHIC)+' '+
                            ','+#39+TRIM(FECHAMATRI)+#39+' '+
                            ','+INTTOSTR(AnioFabr)+' '+
                            ','+INTTOSTR(CODMARCA)+' '+
                            ','+INTTOSTR(CODMODEL)+' '+
                            ','+INTTOSTR(TIPOESPE)+' '+
                            ','+INTTOSTR(tipo_destino)+' '+
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
         if Existe=0 then
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
                sqloracle:='INSERT INTO TDATOSTURNO (CODTURNO,FECHATURNO,HORATURNO,FECHAALTA,PATENTE,NROORDEN,IMPORTE,CODVEHIC,CODCLIEN,ESTADO,IDPAGO,NUMINSPEC,MOTIVO )'+
                            ' VALUES ( '+
                            ' '+INTTOSTR(CODTURNO)+' '+
                            //',''TO_DATE('+#39+TRIM(FECHATURNO)+#39+',''DD/MM/YYYY'')'+
                            ','+#39+TRIM(FECHATURNO)+#39+' '+
                            ','+#39+TRIM(HORATURNO)+#39+' '+
                            //',''TO_DATE('+#39+TRIM(FECHALTA)+#39+',''DD/MM/YYYY'')'+
                            ','+#39+TRIM(FECHALTA)+#39+' '+
                            ','+#39+TRIM(PATENTE)+#39+' '+
                            ','+INTTOSTR(NROORDEN)+' '+
                            ','+#39+TRIM(IMPORTE)+#39+' '+
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

 //Application.MessageBox( 'PROCESO TERMINADO.', 'Atenci�n',
 // MB_ICONINFORMATION );
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
   //   form1.caption:='Administraci�n de Reservas de Turnos OnLine.  [ '+trim(busca_nombr_centro(uglobal.ID_PLANTA))+' ]';
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

procedure TForm1.ImportarClick(Sender: TObject);
begin
  DoImportacionExlsOracle;
end;

//Importa los datos del banco para facurar.
procedure TForm1.DoImportacionExlsOracle;

const
//Datos
F_DAT = 2;

var
  fsql : TStringList;
  si: String;

  VARIABLE1,VARIABLE2,VARIABLE3,
  VARIABLE4,VARIABLE5,VARIABLE6,
  VARIABLE7,VARIABLE8,VARIABLE9,
  VARIABLE10,VARIABLE11,VARIABLE12,
  VARIABLE13,VARIABLE14,VARIABLE15,
  VARIABLE16,VARIABLE17 :STRING;

  SARASA :STRING;

begin
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
       f:= F_DAT;
       si := IntToStr( f );

       repeat

       {Asigno a las variables los valores de las columnas que se van a exportar}
       begin
             //VARIABLE1 := ExcelHoja.Range['A'+si,'A'+si].Value2; // PATENTE
             //VARIABLE2 := ExcelHoja.Range['B'+si,'B'+si].Value2; // numero_orden
             //VARIABLE3 := ExcelHoja.Range['C'+si,'C'+si].Value2; // TipoFact
             //VARIABLE4 := ExcelHoja.Range['D'+si,'D'+si].Value2; // monto
             //VARIABLE5 := ExcelHoja.Range['E'+si,'E'+si].Value2; // Tipodoc
             //VARIABLE6 := ExcelHoja.Range['F'+si,'F'+si].Value2; // TipoPersona
             //VARIABLE7 := ExcelHoja.Range['G'+si,'G'+si].Value2; // documento
             //VARIABLE8 := ExcelHoja.Range['H'+si,'H'+si].Value2; // Razonsocial
             //VARIABLE9 := ExcelHoja.Range['I'+si,'I'+si].Value2; // nombre cliente
             //VARIABLE10 := ExcelHoja.Range['J'+si,'J'+si].Value2; // IMPORTE
             //VARIABLE11 := ExcelHoja.Range['K'+si,'K'+si].Value2; // direccion
             //VARIABLE12 := ExcelHoja.Range['L'+si,'L'+si].Value2; // calle
             //VARIABLE13 := ExcelHoja.Range['M'+si,'M'+si].Value2; // pais
             //VARIABLE14 := ExcelHoja.Range['N'+si,'N'+si].Value2; // provincia
             //VARIABLE15 := ExcelHoja.Range['O'+si,'O'+si].Value2; // canton
             //VARIABLE16 := FormatdateTime('DD/MM/YYYY',ExcelHoja.Range['P'+si,'P'+si].Value2); // fechaFactura
             //VARIABLE17 := FormatdateTime('DD/MM/YYYY',ExcelHoja.Range['Q'+si,'Q'+si].Value2); // fechaacredictacion

             VARIABLE1 := ExcelHoja.Range['B'+si,'B'+si].Value2; // numero_orden
             VARIABLE2 := ExcelHoja.Range['J'+si,'J'+si].Value2; // Importe
             VARIABLE3 := ExcelHoja.Range['I'+si,'I'+si].Value2; // Razonsocial
             VARIABLE4 := ExcelHoja.Range['I'+si,'I'+si].Value2; // nombre cliente
             VARIABLE5 := FormatdateTime('DD/MM/YYYY',ExcelHoja.Range['M'+si,'M'+si].Value2); // fechaFactura
       end;

          sdsfConsulta := TSQLDataSet.Create(application);
          sdsfConsulta.SQLConnection := MyBD;
          sdsfConsulta.CommandType := ctQuery;

          dspfConsulta := TDataSetProvider.Create(application);
          dspfConsulta.DataSet := sdsfConsulta;
          dspfConsulta.Options := [poIncFieldProps,poAllowCommandText];
          fConsulta := TClientDataSet.Create(Application);

          fConsulta.SetProvider(dspfConsulta);

          fsql := TStringList.Create;

          with fConsulta do
          BEGIN
            Screen.Cursor := crHourglass;
            ////Guardar los datos en la tablaOracle
            {Seteo el formato de fecha en el Oracle}
            commandtext := 'alter session set nls_date_format = ''dd/mm/yyyy''';
            Execute;
            close;

            {Realizo el insert de los datos del Excel a la tabla} //tabla de TESTING
            {SetProvider(dspfConsulta);
            fsql.Clear;
            fsql.add('INSERT INTO FACTURACIONBANCO (PATENTE,PAGOID,MONTO,Dato4,Dato5,Dato6,Dato7)');
            fsql.add('VALUES');                                        
            fsql.add('('''+VARIABLE1+''','); //PATENTE
            fsql.add(' '''+VARIABLE2+''','); //PAGOID
            fsql.add(' '''+VARIABLE3+''','); //MONTO
            fsql.add(' '''+VARIABLE4+''','); //Dato4
            fsql.add(' '''+VARIABLE5+''','); //Dato5
            fsql.add(' '''+VARIABLE6+''','); //Dato6
            fsql.add(' '''+VARIABLE7+''')'); //Dato7
            CommandText := fsql.Text;
            Execute;}

            {with TSQLStoredProc.Create(Application) do
            try
              SQLConnection := MyBD;
              StoredProcName := 'SAGECUADOR.Pq_DatosRecep.fvehiculo';
              Prepared := true;
              //ParamByName('aPATENTE').Value := TRIM(VARIABLE1);
              ParamByName('vOrden').Value := TRIM(VARIABLE1);
              ExecProc;
              Close;
            finally
              Free;
            end;

            with TSQLStoredProc.Create(Application) do
            try
              SQLConnection := MyBD;
              StoredProcName := 'SAGECUADOR.Pq_DatosRecep.fcliente';
              Prepared := true;
              //ParamByName('adocument').Value := TRIM(VARIABLE7); //pasar desde reserva
              //ParamByName('anombre').Value := TRIM(VARIABLE4);
              //ParamByName('aapellido').Value := TRIM(VARIABLE4);
              //ParamByName('adomicilio').Value := TRIM(VARIABLE11);
              //ParamByName('anrocalle').Value := TRIM(VARIABLE12);
              //ParamByName('atelefono').Value := TRIM(VARIABLE1);
              //ParamByName('vCoddocumento').Value := TRIM(VARIABLE5);
              //ParamByName('atipfactu').Value := TRIM(VARIABLE3);
              //ParamByName('atiptribu').Value := TRIM(SARASA);
              //ParamByName('vTipoPersona').Value := TRIM(VARIABLE6);
              ParamByName('vOrden').Value := TRIM(VARIABLE1);
              ExecProc;
              Close;
            finally
              Free;
            end;}


            Inc( f );
            si := IntToStr( f );

            if ( VarType( ExcelHoja.Range['B'+si,'B'+si].Value2 ) = VarEmpty ) then
              begin
                  ShowMessage('Terminado','Ha finalizado la transferencia de Datos con Exito.' );
                  Screen.Cursor := crdefault;
              end;
            end;

          until ( VarType( ExcelHoja.Range['B'+si,'B'+si].Value2 ) = VarEmpty );

      try
          ExcelApp.Workbooks.Close;
          ExcelApp.Quit;
          ExcelApp:=Unassigned;
          ExcelLibro:=Unassigned;
      except
            ShowMessage('Error','La aplicaci�n Excel no se pudo finalizar automaticamente.');
            ExcelApp.Visible := True;
      end;
   end;

   except
      ShowMessage('Error','No se pudo Migrar los datos.');
   end;
   
      //Mata el proceso de excel.
      KillTask('EXCEL.exe');

     //"Facturo" Luego de importar.
     DoFacturacion;

end;

{Exporto los datos a txt para el banco}
Procedure TForm1.DoFacturacion;

var
F : TextFile;
//sArchivo: string;

CodigoOrientacion,CuentaEmpresa,SecuencialCobro,
ComprobanteDeCobro,ContraPartida,MONEDA,VALOR,
FormaPago,BANCO,NroDeCuenta,TipoIdClienteDeudor,
NroIdClienteDeudor,NombreClienteDeudor,DireccionDeudor,
CiudadDeudor,TelefonoDeudor,LocalidadCobro,Referencia,
ReferenciaAdicional,BaseImponibleRentaServ,CodigoRetencionRentaServ,
BaseImponibleRentaBienes,CodigoRetencionRentaBienes,BaseRetencionIVAservicios,
CodigoRetencionIVAservicios,BaseRetencionIVABienes,CodigoRetencionIVABienes,
BaseIVA0,BaseICE,canton_cliente:STRING;

FECHA:TDateTime;
NOMBREEMBRESA,CODIGOSERVICIO,IDCONTRATO:STRING;

begin

NOMBREEMBRESA:='APPLUS';
CODIGOSERVICIO:='CSC';
IDCONTRATO:='000';
FECHA:=Now;

  sArchivo := ExtractFilePath( Application.ExeName ) + NOMBREEMBRESA+'_'+CODIGOSERVICIO+'_'+IDCONTRATO+'_'+formatdatetime('yyyymmdd',FECHA)+'_IN.txt';
  AssignFile( F, sArchivo );

  {Consulto los pagos a facturar}
         modulo.QUERY_WEB.Close;
         modulo.QUERY_WEB.SQL.Clear;
         modulo.QUERY_WEB.SQL.Add('SELECT '+
                                  're.numero AS IDPAGO '+
                                  //',re.numero_orden AS NROORDEN '+
                                  ',dcob.cod_orientacion '+
                                  ',dcob.contrapartida AS NROORDEN '+
                                  ',dcob.cuenta_empresa '+
                                  ',re.patente '+
                                  ',tt.DESCRIPCION AS DESCVEHICULO '+
                                  ',dcob.valor AS IMPORTE '+
                                  ',dcob.secuencial_cobro '+
                                  ',dcob.comprobante_cobro '+
                                  ',dcob.secuencial_cobro '+
                                  ',dcob.comprobante_cobro '+
                                  ',dcob.cod_banco '+
                                  ',dcob.forma_de_pago '+
                                  ',dcob.moneda '+
                                  ',dcob.referencia '+
                                  ',dcob.referencia_adicional '+
                                  ',re.codestado AS ESTADO '+
                                  ',dre.nro_repeticion AS NUMINSPEC '+
                                  ',dcob.nombre_cliente '+
                                  ',re.TIPO_DOCUMENTO AS CODDOCUMENTO '+
                                  ',re.NRO_DOCUMENTO AS DOCUMENTO '+
                                  ',re.email '+
                                  ',re.telefono '+
                                  ',dcob.numero_de_cuenta '+
                                  ',dcob.localidad_cobro '+
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
                                  ',dcob.base_IVA_0 '+
                                  ',dcob.base_ICE '+
                                  'FROM reserva re inner join detalles_reserva dre '+
                                  'on re.numero = dre.nro_reserva '+
                                  'inner join detalles_cobros dcob '+
                                  'on dcob.contrapartida = re.numero '+
                                  'LEFT JOIN TARIFA TT '+
                                  'on dre.tipo_vehiculo = TT.CODTARIFA '+
                                  'WHERE re.codestado not like ''-%'' '+
                                  ' AND re.numero >= 994 ' + //->Quitar este filtro, una vez terminadas las pruebas
                                  ' AND re.IMPORTADO = ''N'' '+
                                  ' AND re.codestado = 0 '+
                                  ' ORDER BY re.fechalta');

        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.Open;

        MEMO1.Lines.Add('Iniciando Exportacion De Pagos a TXT...');
        RxTrayIcon1.HiNT:='Iniciando Exportacion De Pagos a TXT...';
        APPLICATION.ProcessMessages;

        Rewrite(F);
        WHILE NOT modulo.QUERY_WEB.Eof DO

        BEGIN

        //Datos Facturacion Cliente
        CodigoOrientacion:=modulo.QUERY_WEB.FIELDBYNAME('cod_orientacion').ASSTRING; //'CO'; //char 2 OBLIGATORIO 'CO' = PAGO CAMPO FIJO
        CuentaEmpresa:=modulo.QUERY_WEB.FIELDBYNAME('cuenta_empresa').ASSTRING; //num 11 OBLIGATORIO CAMPO FIJO
        SecuencialCobro:=modulo.QUERY_WEB.FIELDBYNAME('secuencial_cobro').ASSTRING; //'00000001'; //num 7 OBLIGATORIO
        ComprobanteDeCobro:=modulo.QUERY_WEB.FIELDBYNAME('comprobante_cobro').ASSTRING; //'0'; // char 20 OPCIONAL CAMPO FIJO
        ContraPartida:=modulo.QUERY_WEB.FIELDBYNAME('NROORDEN').ASSTRING; //'00000000000000000000'; // char 20 OBLIGATORIO
        MONEDA:=modulo.QUERY_WEB.FIELDBYNAME('MONEDA').ASSTRING;  //'USD'; // char 3 OBLIGATORIO USD = d�lares CAMPO FIJO
        VALOR:=modulo.QUERY_WEB.FIELDBYNAME('IMPORTE').ASSTRING; //'0000000003000'; // num 13 OBLIGATORIO 11 enteros y 2 decimales
        FormaPago:= modulo.QUERY_WEB.FIELDBYNAME('forma_de_pago').ASSTRING; //'REC'; // char 3 OBLIGATORIO USAR 'REC' = Recaudaci�n CAMPO FIJO
        BANCO:=modulo.QUERY_WEB.FIELDBYNAME('cod_banco').ASSTRING;//'0036'; //char 4 OBLIGATORIO '0036' corresponde a produbanco CAMPO FIJO
        NroDeCuenta:=modulo.QUERY_WEB.FIELDBYNAME('numero_de_cuenta').ASSTRING;// ' '; // num 11 OBLIGATORIO CAMPO FIJO
        TipoIdClienteDeudor:=modulo.QUERY_WEB.FIELDBYNAME('CODDOCUMENTO').ASSTRING; //char 1 OBLIGATORIO C = C�dula, R = RUC, P = Pasaporte
        NroIdClienteDeudor:=modulo.QUERY_WEB.FIELDBYNAME('DOCUMENTO').ASSTRING; // char 13 si es RUC char 10 si es CI OBLIGATORIO completar ceros a la izquierda
        NombreClienteDeudor:=modulo.QUERY_WEB.FIELDBYNAME('nombre_cliente').ASSTRING; //(NOMBRE+' '+APELLIDO); // char 40 OBLIGATORIO
        DireccionDeudor:=modulo.QUERY_WEB.FIELDBYNAME('DIRECCION').ASSTRING; // char 40 OPCIONAL
        CiudadDeudor:=modulo.QUERY_WEB.FIELDBYNAME('CIUDAD').ASSTRING; // char 20 OPCIONAL
        TelefonoDeudor:=modulo.QUERY_WEB.FIELDBYNAME('TELEFONO').ASSTRING;// char 20 OPCIONAL
        LocalidadCobro:=modulo.QUERY_WEB.FIELDBYNAME('localidad_cobro').ASSTRING; //' ';// char 20 opcional (en blanco todas)
        Referencia:=modulo.QUERY_WEB.FIELDBYNAME('referencia').ASSTRING; // char 200 OBLIGATORIO facturas o comporbantes de referencia para el cobro
        ReferenciaAdicional:=modulo.QUERY_WEB.FIELDBYNAME('DESCVEHICULO').ASSTRING; // char 100 OPCIONAL datos adicionales que quieran enviarse (Aqu� podemos enviar la dem�s informaci�n)
        BaseImponibleRentaServ:=modulo.QUERY_WEB.FIELDBYNAME('base_imp_renta_serv').ASSTRING; //'0'; // num 13 OBLIGATORIO? 0 cuando no corresponde
        CodigoRetencionRentaServ:=modulo.QUERY_WEB.FIELDBYNAME('cod_retencion_renta_serv').ASSTRING;//'NA'; // char 20 OBLIGATORIO? NA cuando no corresponde
        BaseImponibleRentaBienes:=modulo.QUERY_WEB.FIELDBYNAME('base_imp_renta_bienes').ASSTRING;//'0'; // num 13 OBLIGATORIO?
        CodigoRetencionRentaBienes:=modulo.QUERY_WEB.FIELDBYNAME('cod_retencion_renta_bienes').ASSTRING;//'NA'; // char 20 OBLIGATORIO? NA cuando no corresponde
        BaseRetencionIVAservicios:=modulo.QUERY_WEB.FIELDBYNAME('base_retencion_IVA_serv').ASSTRING; //'0'; // num 13 OBLIGATORIO?
        CodigoRetencionIVAservicios:=modulo.QUERY_WEB.FIELDBYNAME('cod_retencion_IVA_serv').ASSTRING; //'NA'; // char 20 OBLIGATORIO? NA cuando no corresponde
        BaseRetencionIVABienes:=modulo.QUERY_WEB.FIELDBYNAME('base_retencion_IVA_bienes').ASSTRING; //'0'; // num 13 OBLIGATORIO?
        CodigoRetencionIVABienes:=modulo.QUERY_WEB.FIELDBYNAME('codigo_retencion_IVA_bienes').ASSTRING;//'NA'; // char 20 OBLIGATORIO? NA cuando no corresponde
        BaseIVA0:=modulo.QUERY_WEB.FIELDBYNAME('base_IVA_0').ASSTRING; //''; // num 13 OBIGATORIO?
        BaseICE:=modulo.QUERY_WEB.FIELDBYNAME('base_ICE').ASSTRING;//''; // num 13 OPCIONAL
        canton_cliente:=modulo.QUERY_WEB.FIELDBYNAME('CANTON').ASSTRING;

         //WriteLn Inserta registrons linea a linea
         //Write Inserta registros continuamente en 1 linea
           Write(F,CodigoOrientacion+
                ''#9+CuentaEmpresa+
                ''#9+SecuencialCobro+
                ''#9+ComprobanteDeCobro+
                ''#9+ContraPartida+
                ''#9+MONEDA+
                ''#9+VALOR+
                ''#9+FormaPago+
                ''#9+BANCO+
                ''#9+NroDeCuenta+
                ''#9+TipoIdClienteDeudor+
                ''#9+NroIdClienteDeudor+
                ''+NombreClienteDeudor+
                ''+DireccionDeudor+
                ''+CiudadDeudor+
                ''#9+TelefonoDeudor+
                ''+LocalidadCobro+
                ''#9+Referencia+
                ''#9+ReferenciaAdicional+
                ''#9+BaseImponibleRentaServ+
                ''#9+CodigoRetencionRentaServ+
                ''#9+BaseImponibleRentaBienes+
                ''#9+CodigoRetencionRentaBienes+
                ''#9+BaseRetencionIVAservicios+
                ''#9+CodigoRetencionIVAservicios+
                ''#9+BaseRetencionIVABienes+
                ''#9+CodigoRetencionIVABienes+
                ''#9+BaseIVA0+
                ''#9+BaseICE
              //''#9+canton_cliente
                );

      modulo.QUERY_WEB.NEXT;
    end;
  CloseFile(F);
    modulo.QUERY_WEB.Close;
    MEMO1.Lines.Add('Exportacion De Pagos a TXT Terminada');
    RxTrayIcon1.HiNT:='Exportacion De Pagos TXT Terminada';
    APPLICATION.ProcessMessages;
end;

procedure TForm1.ExportarClick(Sender: TObject);
begin
   DoFacturacion;
end;

procedure TForm1.EnviarFTPClick(Sender: TObject);
begin
    SubirArchivo(sArchivo);
end;

Procedure TForm1.SubirArchivo( sArchivo: String );
var
  FTP: TIdFTP;
begin
  FTP := TIdFTP.Create( nil );
  FTP.Username := 'usuario';
  FTP.Password := 'miclave';
  FTP.Host := 'miftp.midominio.com'; //o IP

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

  FTP.ChangeDir( '/misarchivos/copiaseguridad/' );   // con esto entras al directorio donde tenemos q poner el archivo
  FTP.Put( sArchivo, ExtractFileName( sArchivo ), False ); //sube archivo
  FTP.Disconnect;
  FTP.Free;
end;

end.
