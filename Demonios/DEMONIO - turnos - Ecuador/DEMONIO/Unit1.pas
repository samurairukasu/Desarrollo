unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls,inifiles, DB, ADODB, FMTBcd, SqlExpr, USuperRegistry,
  DBXpress, Provider, dbclient, DBCtrls, ExtCtrls, RXShell, Menus,
  ExcelXP, OleServer, ComObj, UCDialgs;

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
        PAIS = 'Ecuador';
        {$ENDIF}

        SO_WINNT = '4.0';
        SO_WIN2000 = '5.0';
        SO_WINXP = '5.1';
        SO_WIN2003 = '5.2';

        VERSION_KEY = 'SOFTWARE\Microsoft\Windows NT\CurrentVersion\';

        //APPLICATION_KEY = '\SOFTWARE\WOW6432Node\'+COMPANY_NAME+'\'+APPLICATION_NAME;
        APPLICATION_KEY = '\SOFTWARE\WOW6432Node\'+PAIS;
        APPLICATION_KEY_turno = '\SOFTWARE\WOW6432Node\'+PAIS;
        BD_KEY = APPLICATION_KEY;

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
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Ocultar1Click(Sender: TObject);
    procedure Mostrar1Click(Sender: TObject);
    procedure ImportarClick(Sender: TObject);
  private
    { Private declarations }
    function KillTask(ExeFileName: string): Integer;
  public
    { Public declarations }
    se_conector:BOOLEAN;
    CITAS_CONECT:BOOLEAN;
    NOMPALNTA:STRING;
    ARCHIVO_LOG:STRING;
    fConsulta: TClientDataSet;
    sdsfConsulta: TSQLDataSet;
    dspfConsulta: TDataSetProvider;
    procedure DoImportacionExlsOracle;
    Procedure DoFacturacion;
    procedure TestOfBD(Alias, UserName, Password: String; Ageva: boolean);
    function conexion_virtual(base:string):boolean;
    function ENVIAR_A_WEB_TURNOS(turnoidhasta:longint;plantapasa:longint):BOOLEAN;
    function GUARDA_LOG(MENSAJE:STRING):BOOLEAN;
    procedure EJECUTAR;
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
                        DBAlias := ReadString('AliasOra')
                    Else
                        DBAlias:=Alias;

                    If UserName=''
                    then
                        DBUserName := ReadString('UserOra')
                    else
                        DBUserName:=UserName;

                    If Password=''
                    then
                        DBPassword := ReadString('PasswordOra')
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

conexion_virtual('db_web_ecuador');
IF CITAS_CONECT=TRUE THEN
BEGIN

   begin
     MEMO1.Clear;
     //readln(archivo,alias);
     NOMPALNTA:=ALIAS;
     userbd:='CABASM';
     password:='02lusabaqui03';
     TestOfBD(alias,userbd,password,false);

     if se_conector=true then

      BEGIN
        form1.Caption:='CONECTADO A '+ ALIAS;
        memo1.Lines.Add('CONECTADO A: '+ ALIAS);
        FORM1.HiNT:='CONECTADO A '+ ALIAS;
        RxTrayIcon1.HiNT:='CONECTADO A '+ ALIAS;
        APPLICATION.ProcessMessages;

        {busco en la base oracle el ultimo TURNOID}
        with tsqlQuery.Create(nil) do
        try
          SQLConnection:= MYBD;
          SQL.Add('SELECT DISTINCT MAX(TURNOID) FROM TDATOSTURNO WHERE TURNOID NOT LIKE ''%-%'' ');
          Open;
          TURNOID:=fields[0].AsInteger;

       finally
         close;
         free;
       end;

       {busco en la base oracle el id de planta(centro)}
       with tsqlQuery.Create(nil) do
        try
          SQLConnection:= MYBD;
          SQL.Add('select (zona||estacion) centro from tvarios');
          Open;
          planta:=fields[0].AsInteger;

       finally
         close;
         free;
       end;

        ENVIAR_A_WEB_TURNOS(TURNOID,Planta);
        END else
        begin
        
        end;

   mybd.Close;
end;

modulo.conexion.Close;

END;

end;

FUNCTION TFORM1.ENVIAR_A_WEB_TURNOS(turnoidhasta:longint;plantapasa:longint):BOOLEAN;
var sqloracle:string;

CENTRO:string;
TURNOID,ESTADOID:longint;
PATENTE,ESTADODESC:string;
TITULARNOMBRE,TITULARAPELLIDO,TELEFONO,EMAIL,TIPO_DOCUMENTO:string;
TIPOINSPE,FECHATURNO,HORATURNO,FECHANOVEDAD,FECHALTA,NRO_DOCUMENTO:string;
Existe:Longint;

BEGIN

{Reserva como turno vigente al insertar en tdatosturno}
ESTADOID:=1;
ESTADODESC:='Vigente';

 {Tomar los datos de la tabla reservas del SQL}
        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;
        modulo.QUERY_WEB.SQL.Add('SELECT '+
                                 'numero AS TURNOID '+
                                 ',centro AS PLANTA '+
                                 ',fecha AS FECHATURNO '+
                                 ',patente AS DVDOMINO '+
                                 ',nombre AS TITULARNOMBRE '+
                                 ',apellido AS TITULARAPELLIDO '+
                                 ',email AS CONTACTOEMAIL '+
                                 ',tipo_insp AS TIPOINSPE '+
                                 ',telefono AS CONTACTOTELEFONO '+
                                 ',hora AS HORATURNO '+
                                 ',replace(CONVERT(DATE,FECHALTA,103),''-'',''/'') AS FECHALTA '+
                                 ',CENTRO '+
                                 ',TIPO_DOCUMENTO '+
                                 ',NRO_DOCUMENTO '+
                                 'FROM reserva '+
                                 'WHERE NUMERO > '+inttostr(turnoidhasta)+
                                 'AND CENTRO = '+inttostr(plantapasa)+
                                 ' ORDER BY fechalta');
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
        TIPOINSPE:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('TIPOINSPE').ASSTRING);
        TELEFONO:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('CONTACTOTELEFONO').ASSTRING);
        HORATURNO:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('HORATURNO').ASSTRING);
        FECHALTA:=TRIM(modulo.QUERY_WEB.FIELDBYNAME('FECHALTA').ASSTRING);

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
                            ' TITULARNOMBRE,TITULARAPELLIDO,CONTACTOTELEFONO,CONTACTOEMAIL,DVDOMINO,PLANTA,TIPOINSPE,ESTADOID,ESTADODESC,FECHANOVEDAD) '+
                            ' VALUES ('+INTTOSTR(TURNOID)+',TO_DATE('+#39+TRIM(FECHATURNO)+#39+',''DD/MM/YYYY''),'+#39+TRIM(HORATURNO)+#39+
                            ',TO_DATE('+#39+TRIM(FECHANOVEDAD)+#39+',''DD/MM/YYYY''),'+#39+TRIM(TIPO_DOCUMENTO)+#39+','+#39+TRIM(NRO_DOCUMENTO)+#39+
                            ','+#39+TRIM(TITULARNOMBRE)+#39+','+#39+TRIM(TITULARAPELLIDO)+#39+','+#39+TRIM(TELEFONO)+#39+
                            ','+#39+TRIM(EMAIL)+#39+','+#39+TRIM(PATENTE)+#39+','+#39+TRIM(CENTRO)+#39+
                            ','+#39+TRIM(TIPOINSPE)+#39+','+INTTOSTR(ESTADOID)+','+#39+TRIM(ESTADODESC)+#39 +
                            ',TO_DATE('+#39+TRIM(FECHANOVEDAD)+#39+',''DD/MM/YYYY'') )';
                end else begin
                end;

          if Existe=0 then
           with tsqlQuery.Create(nil) do
            try
              SQLConnection:= MYBD;
                MEMO1.Lines.Add('ACTUALIZANDO TURNO: '+INTTOSTR(TURNOID));
                RxTrayIcon1.HiNT:='ACTUALIZANDO TURNO: '+INTTOSTR(TURNOID);
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
                         modulo.CONEXION.RollbackTrans;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| PLANTA '+NOMPALNTA+' NO SE INSERTO TURNOID '+INTTOSTR(TURNOID)+'   POR :'+ E.message);
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
//MYBD.Close;
//MODULO.conexion.Close;
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
 timer1.Interval:=10800000;
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

  VARIABLE1,
  VARIABLE2,
  VARIABLE3,
  VARIABLE4,
  VARIABLE5,
  VARIABLE6,
  VARIABLE7 :STRING;

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

       {Vacia la tabla FACTURACIONBANCO antes de ingresar datos del excel}
       with tsqlQuery.Create(nil) do
        try
          SQLConnection:= MYBD;
          SQL.Add('truncate table FACTURACIONBANCO');
          ExecSQL;
       finally
         close;
         free;
       end;

       repeat

       {Asigno a las variables los valores de las columnas que se van a exportar}
       begin
             VARIABLE1 := ExcelHoja.Range['A'+si,'A'+si].Value2; // PATENTE
             VARIABLE2 := ExcelHoja.Range['B'+si,'B'+si].Value2; // PAGOID
             VARIABLE3 := ExcelHoja.Range['C'+si,'C'+si].Value2; // MONTO
             VARIABLE4 := ExcelHoja.Range['D'+si,'D'+si].Value2; // Dato4
             VARIABLE5 := ExcelHoja.Range['E'+si,'E'+si].Value2; // Dato5
             VARIABLE6 := FormatdateTime('DD/MM/YYYY',ExcelHoja.Range['F'+si,'F'+si].Value2); // Dato6
             VARIABLE7 := FormatdateTime('DD/MM/YYYY',ExcelHoja.Range['G'+si,'G'+si].Value2); // Dato7
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

            {Realizo el insert de los datos del Excel a la tabla}
            SetProvider(dspfConsulta);
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
            Execute; 

            Inc( f );
            si := IntToStr( f );

            if ( VarType( ExcelHoja.Range['A'+si,'A'+si].Value2 ) = VarEmpty ) then
              begin
                  ShowMessage('Terminado','Ha finalizado la transferencia de Datos con Exito.' );
                  Screen.Cursor := crdefault;
              end;
            end;

          until ( VarType( ExcelHoja.Range['A'+si,'A'+si].Value2 ) = VarEmpty );

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

//Realiza la "Facturacion" Luego de Importar los datos del banco
Procedure TForm1.DoFacturacion;

Begin
  //Codigo
End;

end.
