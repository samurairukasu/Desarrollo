unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls,inifiles, DB, ADODB, FMTBcd, SqlExpr, USuperRegistry,
   DBXpress, Provider, dbclient, DBCtrls, ExtCtrls, RXShell, Menus;

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
        APPLICATION_NAME = 'ReporteGLOBAL';
        ORACLE = 'Oracle';
        MSSQL = 'MSSQL';
        {$ENDIF}

        SO_WINNT = '4.0';
        SO_WIN2000 = '5.0';
        SO_WINXP = '5.1';
        SO_WIN2003 = '5.2';

        VERSION_KEY = 'SOFTWARE\Microsoft\Windows NT\CurrentVersion\';

        APPLICATION_KEY = '\SOFTWARE\WOW6432Node\'+APPLICATION_NAME;
        SERVER_SQL = APPLICATION_KEY+'\'+MSSQL;
        SERVER_ORACLE = APPLICATION_KEY+'\'+ORACLE;

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
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Ocultar1Click(Sender: TObject);
    procedure Mostrar1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    se_conector:BOOLEAN;
    CITAS_CONECT:BOOLEAN;
    NOMPALNTA:STRING;
    ARCHIVO_LOG:STRING;
    procedure TestOfBD(Alias, UserName, Password: String; Ageva: boolean);
    function conexion_virtual(base:string):boolean;
    FUNCTION ENVIAR_A_MSSQL(turnoidhasta:longint;CODINSPE:longint;CODFACTU:longint;plantapasa:longint):BOOLEAN;
    FUNCTION GUARDA_LOG(MENSAJE:STRING):BOOLEAN;
    procedure EJECUTAR;
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

                if not OpenKeyRead(SERVER_ORACLE)
            then
            BEGIN  Application.MessageBox( pchar('No se pudo conectar con la base de datos por: Error de Registro'),
         'Acceso denegado', MB_ICONSTOP );
          END else begin
                try

                    //If Alias=''
                    //then
                        DBAlias := ReadString('Alias');
                    //Else
                    //    DBAlias:=Alias;

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
link:= ExtractFilePath( Application.ExeName ) + ARCHIVO_LOG;
assignfile(LOG,link);

if fileexists(link)=false then
rewrite(LOG);
 append(LOG);
 WRITELN(LOG,MENSAJE);
 CLOSEFILE(LOG);
END;

procedure TForm1.EJECUTAR;
VAR
//BASE,alias,userbd,password:STRING;
BASE,alias,userbd,password,linea:STRING;
con,link:string;
archivo,LOG:textfile;
FE:STRING;
TURNOID,CODFACTU,CODINSPE,planta:longint;

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
    if OpenKeyRead(SERVER_SQL) then
      Begin
        BASE:=ReadString('DB');
      end;
  Finally
    free;
  end;

conexion_virtual('MASTERDB');

IF CITAS_CONECT=TRUE THEN

BEGIN
   link:= ExtractFilePath( Application.ExeName ) + 'plantas.txt';
   assignfile(archivo,link);
   reset(archivo);
   while not eof(archivo) do

   begin
     MEMO1.Clear;
     readln(archivo,alias);
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

        {with tsqlQuery.Create(nil) do
        try
          SQLConnection:= MYBD;
          SQL.Add('select codunicoplanta from planta');
          Open;
          planta:=fields[0].AsInteger;

       finally
         close;
         free;
       end; }

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
       IF (NOMPALNTA <> 'CABASM') or (NOMPALNTA <> 'CABAVS') THEN
       BEGIN
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
       END;

       IF NOMPALNTA = 'CABASM' THEN BEGIN planta:=4 END;
       IF NOMPALNTA = 'CABAVS' THEN BEGIN planta:=3 END;

       {Busco el ultimo Turno}
        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;
        modulo.QUERY_WEB.SQL.Add('SELECT MAX(TURNOID) FROM TDATOSTURNO WHERE PLANTA='+inttostr(planta));
        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.open;
        TURNOID:=modulo.QUERY_WEB.Fields[0].AsInteger;

        {Busco la ultima inspeccion}
        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;
        modulo.QUERY_WEB.SQL.Add('SELECT MAX(CODINSPE) FROM TINSPECCION');
        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.open;
        CODINSPE:=modulo.QUERY_WEB.Fields[0].AsInteger;

        {Busco la ultima factura}
        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;
        modulo.QUERY_WEB.SQL.Add('SELECT MAX(TFAC.CODFACTU) FROM TFACTURAS TFAC INNER JOIN TFACT_ADICION ADI '+
                                 'ON TFAC.CODFACTU = ADI.CODFACT WHERE ADI.PTOVENT='+inttostr(planta));
        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.open;
        CODFACTU:=modulo.QUERY_WEB.Fields[0].AsInteger;

        ENVIAR_A_MSSQL(TURNOID,CODINSPE,CODFACTU,Planta);
        END else
        begin

        end;

   mybd.Close;
end;

modulo.conexion.Close;

END;

end;

FUNCTION TFORM1.ENVIAR_A_MSSQL(turnoidhasta:longint;CODINSPE:longint;CODFACTU:longint;plantapasa:longint):BOOLEAN;
var sqloracle,SQL_WEB,SQL_WEB2:string;

CENTRO:string;
TURNOID,ESTADOID,CODCLIEN,codfact,PTOVENT,IDUSUARI:longint;
PATENTE,TIPOINSPE,FECHATURNO,FECHALTA,TIPOFAC:string;
FECHAFAC,TIPOFACTU,TIPTRIBU,FORMPAGO,IVA,IMPORTE,
NUMFACTU,IDDETALLESPAGO,CODCOFAC:STRING;
Existe:Longint;

BEGIN

 {Tomar los datos de la tabla reservas del SQL} {
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

        {Consulto si las reservas web existen en tdatosturno} {
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

       {Fecha que se inserta el turno a la tabla}  {
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

         {Insertar los datos de la tabla reserva del SQL a la tabla tdatosturnos del Oracle} {
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
        }

{Busco facturas nuevas}
with tsqlQuery.Create(nil) do
    try
        SQLConnection:= MYBD;
        SQL.Add('SELECT '+
                'TFAC.CODFACTU AS CODFACTU '+
                ',TFAC.fechalta AS fechalta '+
                ',TFAC.tipfactu AS tipofactu '+
                ',TFAC.tiptribu AS tiptribu '+
                ',TFAC.formpago AS formpago '+
                ',TFAC.ivainscr AS ivainscr '+
                ',TFAC.codclien AS codclien '+
                ',TFAC.imponeto AS imponeto '+
                ',TFAC.numfactu AS numfactu '+
                ',TFAC.codcofac AS codcofac '+
                ',TFAC.iddetallespago AS iddetallespago '+
                ',ADI.codfact AS codfact '+
                ',ADI.TIPOFAC AS TIPOFAC '+
                ',ADI.PTOVENT AS PTOVENT '+
                ',ADI.IDUSUARI AS IDUSUARI '+
                'FROM TFACTURAS TFAC INNER JOIN TFACT_ADICION ADI '+
                'ON TFAC.CODFACTU = ADI.CODFACT '+
                'WHERE CODFACTU >' +inttostr(CODFACTU));
        Open;

        WHILE NOT EOF DO

        BEGIN
        CODFACTU:=FIELDBYNAME('CODFACTU').ASINTEGER;
        FECHAFAC:=TRIM(FIELDBYNAME('fechalta').ASSTRING);
        TIPOFACTU:=TRIM(FIELDBYNAME('tipofactu').ASSTRING);
        TIPTRIBU:=TRIM(FIELDBYNAME('tiptribu').ASSTRING);
        FORMPAGO:=TRIM(FIELDBYNAME('formpago').ASSTRING);
        IVA:=TRIM(FIELDBYNAME('ivainscr').ASSTRING);
        CODCLIEN:=FIELDBYNAME('codclien').ASINTEGER;
        IMPORTE:=TRIM(FIELDBYNAME('imponeto').ASSTRING);
        NUMFACTU:=TRIM(FIELDBYNAME('numfactu').ASSTRING);
        CODCOFAC:=TRIM(FIELDBYNAME('codcofac').ASSTRING);
        IDDETALLESPAGO:=TRIM(FIELDBYNAME('iddetallespago').ASSTRING);

        codfact:=FIELDBYNAME('codfact').ASINTEGER;
        TIPOFAC:=TRIM(FIELDBYNAME('TIPOFAC').ASSTRING);
        PTOVENT:=FIELDBYNAME('PTOVENT').ASINTEGER;
        IDUSUARI:=FIELDBYNAME('IDUSUARI').ASINTEGER;

        {aqolicklist:=tsqlQuery.Create(nil);
        aqolicklist.SQLConnection:= MYBD;
        aqolicklist.SQL.Add('select PICKLISTDESC from TPICKLIST where CODCLIEN='+inttostr(acodclien));
        aqolicklist.Open;
        PICKLISTDESC:=TRIM(aqolicklist.FIELDBYNAME('PICKLISTDESC').ASSTRING);

        aqolicklist.Close;
        aqolicklist.free;
        }

         modulo.QUERY_WEB.Close;
         modulo.QUERY_WEB.SQL.Clear;
         modulo.QUERY_WEB.SQL.Add('SELECT * FROM TFACTURAS WHERE CODFACTU='+inttostr(CODFACTU));
         modulo.QUERY_WEB.ExecSQL;
         modulo.QUERY_WEB.Open;

        if modulo.QUERY_WEB.IsEmpty=true then
           begin

             if (CODFACTU <> 0) then
                begin
                   SQL_WEB:='INSERT INTO TFACTURAS (codfactu,fechalta,tipfactu,tiptribu,formpago,ivainscr,codclien,imponeto,numfactu,codcofac,iddetallespago) '+
                            ' VALUES ('+INTTOSTR(CODFACTU)+','+#39+TRIM(FECHAFAC)+#39+','+#39+TRIM(TIPOFACTU)+#39+','+#39+TRIM(TIPTRIBU)+#39+
                            ','+#39+TRIM(FORMPAGO)+#39+','+#39+TRIM(IVA)+#39+','+INTTOSTR(CODCLIEN)+
                            ','+#39+TRIM(IMPORTE)+#39+','+#39+TRIM(NUMFACTU)+#39+','+#39+TRIM(NUMFACTU)+#39+','+#39+TRIM(IDDETALLESPAGO)+#39+')';

                   SQL_WEB2:='INSERT INTO TFACT_ADICION (codfact,TIPOFAC,ptovent,idusuari) '+
                             ' VALUES ('+INTTOSTR(codfact)+','+#39+TRIM(TIPOFAC)+#39+','+INTTOSTR(ptovent)+','+INTTOSTR(idusuari)+')';

               end else begin
               end;

             modulo.CONEXION.BeginTrans;
               TRY
                MEMO1.Lines.Add('ACTUALIZANDO CODFACTU: '+INTTOSTR(CODFACTU));
                RxTrayIcon1.HiNT:='ACTUALIZANDO CODFACTU: '+INTTOSTR(CODFACTU);
                APPLICATION.ProcessMessages;
                modulo.QUERY_WEB.Close;
                modulo.QUERY_WEB.SQL.Clear;
                modulo.QUERY_WEB.SQL.Add(SQL_WEB);
                modulo.QUERY_WEB.SQL.Add(SQL_WEB2);
                modulo.QUERY_WEB.ExecSQL;
                modulo.CONEXION.CommitTrans;
                MEMO1.Lines.Add('TRANSACCION: OK');
                APPLICATION.ProcessMessages;


           EXCEPT
             on E: Exception do
                      BEGIN
                        MEMO1.Lines.Add('TRANSACCION: ERROR');
                         APPLICATION.ProcessMessages;
                         modulo.CONEXION.RollbackTrans;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| PLANTA '+INTTOSTR(plantapasa)+' NO SE INSERTO FACTURA '+INTTOSTR(CODFACTU)+' POR :'+ E.message);
                      END;
          END;

       end;

        NEXT;
        END;

  finally
        Close;
        Free;
  end;

 //Application.MessageBox( 'PROCESO TERMINADO.', 'Atención',
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
    if OpenKeyRead(SERVER_SQL) then
      Begin
      servidor:=ReadString('Server');
      user:=ReadString('User');
      pass:=ReadString('Password');
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

end.
