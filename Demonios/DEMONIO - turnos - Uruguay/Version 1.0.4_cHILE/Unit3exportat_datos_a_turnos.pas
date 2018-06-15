unit Unit3exportat_datos_a_turnos;

interface


uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls,inifiles, DB, ADODB, FMTBcd, SqlExpr, USuperRegistry,
   DBXpress, Provider, dbclient, DBCtrls;

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
        APPLICATION_NAME = 'SAGCHILE';
        COMPANY_NAME = 'PRTCHILE';
        {$ENDIF}

        SO_WINNT = '4.0';
        SO_WIN2000 = '5.0';
        SO_WINXP = '5.1';
        SO_WIN2003 = '5.2';

        VERSION_KEY = 'SOFTWARE\Microsoft\Windows NT\CurrentVersion\';

        APPLICATION_KEY = '\SOFTWARE\'+COMPANY_NAME+'\'+APPLICATION_NAME;
        PRINTER_KEY = APPLICATION_KEY+'\PRINTER';
        LICENCIA_KEY = APPLICATION_KEY+'\LICENCIA';
        BD_KEY = APPLICATION_KEY+'\BD';
        IO_KEY = APPLICATION_KEY+'\IO';
        LOGS_ = APPLICATION_KEY+'\LOGS';
type
  Texportat_datos_a_turnos = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    SQLQuery1: TSQLQuery;
    Label1: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    DataSource1: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
        CODIGOPLANTAWEB:string;
        se_conector:BOOLEAN;
    function conectar_base_sql_web:boolean;
    FUNCTION ENVIAR_A_WEB_TURNOS(fd,fh:string):BOOLEAN;
    FUNCTION NRO_MAQUINA(CODREVISION:LONGINT):LONGINT;
    FUNCTION ACTUALIZA_WASPRE(CODREVISION:longint):BOOLEAN;
    procedure TestOfBD(Alias, UserName, Password: String; Ageva: boolean);

  end;

var
  exportat_datos_a_turnos: Texportat_datos_a_turnos;

implementation

uses UPRINCIPAL, Umodulo, UnitMENSAJEEXPORTA;

{$R *.dfm}


function Texportat_datos_a_turnos.conectar_base_sql_web:boolean;
 var INI: TIniFile;
HORA:LONGINT;
SERVIDORsqlweb,usuariosqlweb,passwordsqlweb,basesqlweb:string;
begin
 if not FileExists( ExtractFilePath( Application.ExeName ) + 'turno.ini' ) then
    Exit;

  // Creamos el archivo INI
  INI := TINIFile.Create( ExtractFilePath( Application.ExeName ) + 'turno.ini' );

  // Guardamos las opciones
  SERVIDORsqlweb := INI.ReadString( 'OPCIONES', 'SERVIDOR', '' );
  USUARIOsqlweb := INI.ReadString( 'OPCIONES', 'USUARIO', '' );
  PASSWORDsqlweb := INI.ReadString( 'OPCIONES', 'PASSWORD', '' );
  BASEsqlweb := INI.ReadString( 'OPCIONES', 'BASE', '' );
  CODIGOPLANTAWEB := INI.ReadString( 'OPCIONES', 'CODIGOPLANTA', '' );
  //NOMBREPLANTA := INI.ReadString( 'OPCIONES', 'NOMBREPLANTA', '' );

  // Al liberar el archivo INI se cierra el archivo opciones.ini
  INI.Free;





conectar_base_sql_web:=FALSE;
modulo.conexion.Close;


  if trim(PASSWORDsqlweb)<>'' then
  begin
    modulo.conexion.ConnectionString:='Provider=SQLOLEDB.1;Persist Security Info=False;Password='+trim(PASSWORDsqlweb)+';User ID='+trim(USUARIOsqlweb)+';Initial Catalog='+trim(BASEsqlweb)+';Data Source='+trim(SERVIDORsqlweb);
   end else
     begin
       modulo.conexion.ConnectionString:='Provider=SQLOLEDB.1;Persist Security Info=False; User ID='+trim(USUARIOsqlweb)+';Initial Catalog='+trim(BASEsqlweb)+';Data Source='+trim(SERVIDORsqlweb);
     end;
 
try
  if not (modulo.conexion.Connected) then
     begin
       modulo.conexion.Open;
       modulo.conexion.Connected:=true;
       conectar_base_sql_web:=TRUE;

      end;
except
Application.MessageBox( 'NO SE PUDO CONECTAR A LA BASE DE DATOS DE TURNOS.LA REVISION NO SERÁ ENVIADA A TURNOS.',
  'Acceso denegado', MB_ICONSTOP );


  conectar_base_sql_web:=FALSE;
end;

end;

{--------------------------------------------}

procedure Texportat_datos_a_turnos.TestOfBD(Alias, UserName, Password: String; Ageva: boolean);
    var
        DBAlias, DBUserName, DBPassword, DBAlias2, DBUserName2, DBPassword2,
        DBAlias3, DBUserName3, DBPassword3,
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
         'Acceso denegado', MB_ICONSTOP )  ;
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

                    DBDriverName := ReadString('DriverName');
                    DBLibraryName := ReadString('LibraryName');
                    DBVendorLib := ReadString('VendorLib');
                    DBGetDriverFunc := ReadString('GetDriverFunc');

                    DBAlias2:='';
                    DBUserName2:='';
                    DBPassword2:='';
                    DBAlias3:='';
                    DBUserName3:='';
                    DBPassword3:='';
                    try
                      DBAlias2 := ReadString('Alias2');
                      DBUserName2 := ReadString('User2');
                      DBPassword2 := ReadString('Password2');
                      DBAlias3 := ReadString('Alias3');
                      DBUserName3 := ReadString('User3');
                      DBPassword3 := ReadString('Password3');
                    except

                    end;

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

                          Application.MessageBox( pchar('No se pudo conectar con la base de datos por: ' + E.message),
         'Acceso denegado', MB_ICONSTOP )  ;

                end;


               
           END;

          
        finally
            Free;
        end;

    end;






FUNCTION Texportat_datos_a_turnos.NRO_MAQUINA(CODREVISION:LONGINT):LONGINT;
VAR sqloracle:STRING;
NUMMAQUINA:LONGINT;
 BEGIN

 sqloracle:='SELECT COUNT (*)      FROM PRTCH.FINREVESTACION  '+
           '  WHERE codrevision = '+inttostr(CODREVISION)+' AND TRIM(resultado) = ''DG'' and estacion in(SELECT DISTINCT CODESTACION FROM FINREVISION WHERE  codrevision ='+inttostr(CODREVISION)+
           '  AND (   VALORREF IS NULL  OR SUBSTR (VALORREF, 1, 1) IN  (''>'',''<'',''='','','',''1'', ''2'',''3'',''4'',''5'',''6'',''7'',''8'',''9'',''0'')))';

  with tsqlQuery.Create(nil) do
    try
        SQLConnection:= MYBD;
        SQL.Add(sqloracle);
        Open;
        NUMMAQUINA := Fields[0].ASINTEGER;

  finally
        Close;
        Free;
  end;

  NRO_MAQUINA:=NUMMAQUINA;
END;


procedure Texportat_datos_a_turnos.BitBtn1Click(Sender: TObject);
var codigoplanta:string;
nombre,alias, userbd,password:String;
begin


self.BitBtn2.Enabled:=false;
codigoplanta:=trim(self.DBLookupComboBox1.KeyValue);

modulo.QUERY_WEB.Close;
modulo.QUERY_WEB.SQL.Clear;
modulo.QUERY_WEB.SQL.Add('select nombre,alias, userbd,password from centros where centro='+#39+trim(codigoplanta)+#39);
modulo.QUERY_WEB.ExecSQL;
modulo.QUERY_WEB.Open;
nombre:=trim(modulo.QUERY_WEB.fieldbyname('nombre').AsString);
alias:=trim(modulo.QUERY_WEB.fieldbyname('alias').AsString);
userbd:=trim(modulo.QUERY_WEB.fieldbyname('userbd').AsString);
password:=trim(modulo.QUERY_WEB.fieldbyname('password').AsString);
ALIAS:='QUILICURA';

MENSAJEEXPORTAWWEB.Label1.Caption:='CONECTANDO A LA BASE DE DATOS DE :'+ALIAS;
MENSAJEEXPORTAWWEB.Show;
APPLICATION.ProcessMessages;

application.ProcessMessages;
 TestOfBD(alias,userbd,password,false);
 if se_conector=true then
 BEGIN
   MENSAJEEXPORTAWWEB.Label1.Caption:='EXPORTANDO DATOS DE  :'+nombre;
   MENSAJEEXPORTAWWEB.Show;
   APPLICATION.ProcessMessages;
   ENVIAR_A_WEB_TURNOS(DATETOSTR(DATETIMEPICKER1.DateTime),DATETOSTR(DATETIMEPICKER2.DateTime+1))
 END  else
   begin
    MENSAJEEXPORTAWWEB.CLOSE;
   Application.MessageBox( PCHAR('NO SE PUEDE CONECTAR A LA BASE DE DATOS DE : '+nombre+'.'), 'Atención',
  MB_ICONINFORMATION )
   end;

MENSAJEEXPORTAWWEB.Close;
self.BitBtn2.Enabled:=true;

end;



FUNCTION   Texportat_datos_a_turnos.ACTUALIZA_WASPRE(CODREVISION:longint):BOOLEAN;

VAR sqloracle:STRING;
NUMMAQUINA:LONGINT;
BEGIN

 sqloracle:='UPDATE  REVISION SET WASPRE=''S''  where codrevision='+inttostr(CODREVISION);

  with tsqlQuery.Create(nil) do
    try
     MyBD.StartTransaction(TD);
        SQLConnection:= MYBD;
        SQL.Add(sqloracle);
        EXECSQL;
        If MyBD.InTransaction then
        MyBD.Commit(Td);

  finally
        Close;
        Free;
  end;

  


END;



FUNCTION Texportat_datos_a_turnos.ENVIAR_A_WEB_TURNOS(fd,fh:string):BOOLEAN;
var sqloracle,SQL_WEB:string;

CODPLANTA:string;
codrevision:longint;
CODTIPOATENCION  :longint;
CODATENCION :longint;
CODESTADOREVISION :longint;
NUMREVISION:longint;
PATENTE:string;
CODTIPOVEHICULO  :longint;
FECHALTA,PICKLISTDESC:string;
CODCLASE:string;
RESULTADO:string;
CODFRECU_UNICO :longint;
FECVENCI   :STRING;
NUMMAQUINA ,CODVEHIC ,codclien:longint;
 aqolicklist:tsqlquery;
BEGIN



 with tsqlQuery.Create(nil) do
    try
        SQLConnection:= MYBD;
        SQL.Add('SELECT (select codunicoplanta from planta) as bCODPLANTA,   '+
                ' REV.CODREVISION as REVCODREVISION,   '+
                ' REV.CODTIPOATENCION AS REVCODTIPOATENCION,  '+
                ' REV.CODATENCION AS REVCODATENCION,   '+
                ' REV.CODESTADOREVISION AS REVCODESTADOREVISION, '+
                ' REV.NUMREVISION AS REVNUMREVISION ,  '+
                ' VE.PATENTE AS VEPATENTE,   '+
                ' VE.CODTIPOVEHICULO AS VECODTIPOVEHICULO, '+
                ' REV.FECHALTA AS REVFECHALTA,   '+
                ' REV.CODCLASE AS REVCODCLASE,  '+
                ' REV.RESULTADO AS REVRESULTADO, '+
                ' REV.CODFRECU_UNICO AS REVCODFRECU_UNICO,  '+
                ' REV.FECVENCI  AS REVFECVENCI, A.CODCLIEN AS ACODCLIEN '+
                ' FROM REVISION REV,  VEHICULO VE, ATENCION A  '+
                ' WHERE REV.FECHALTA BETWEEN TO_DATE('+#39+trim(fd)+#39+',''DD/MM/YYYY'') AND TO_DATE('+#39+trim(fh)+#39+',''DD/MM/YYYY'') + 1 '+
                ' AND   REV.CODVEHIC = VE.CODVEHIC  '+
                ' AND INSPFINA=''S''  AND REV.CODATENCION=A.CODATENCION '+
                ' AND CODESTADOTRANSICION<>9 and REV.WASPRE  is null '+
                ' ORDER BY REV.FECHALTA');
        Open;

        WHILE NOT EOF DO
        BEGIN

        PATENTE:=TRIM(FIELDBYNAME('VEPATENTE').ASSTRING);
        CODREVISION :=FIELDBYNAME('REVCODREVISION').ASINTEGER;
        RESULTADO:=TRIM(FIELDBYNAME('REVRESULTADO').ASSTRING);
        CODFRECU_UNICO :=FIELDBYNAME('REVCODFRECU_UNICO').ASINTEGER;
        FECVENCI :=TRIM(FIELDBYNAME('REVFECVENCI').ASSTRING);
        CODTIPOATENCION  :=FIELDBYNAME('REVCODTIPOATENCION').ASINTEGER;
        CODESTADOREVISION :=FIELDBYNAME('REVCODESTADOREVISION').ASINTEGER;
        NUMREVISION:=FIELDBYNAME('REVNUMREVISION').ASINTEGER;
        CODATENCION :=FIELDBYNAME('REVCODATENCION').ASINTEGER;
        CODPLANTA:=TRIM(FIELDBYNAME('bCODPLANTA').ASSTRING);
        CODTIPOVEHICULO :=FIELDBYNAME('VECODTIPOVEHICULO').ASINTEGER;
        codclien:=FIELDBYNAME('ACODCLIEN').ASINTEGER;
        FECHALTA:=TRIM(FIELDBYNAME('REVFECHALTA').ASSTRING);
        CODCLASE:=TRIM(FIELDBYNAME('REVCODCLASE').ASSTRING);
        NUMMAQUINA:=NRO_MAQUINA(CODREVISION);

        aqolicklist:=tsqlQuery.Create(nil);
        aqolicklist.SQLConnection:= MYBD;
        aqolicklist.SQL.Add('select PICKLISTDESC from TPICKLIST where CODCLIEN='+inttostr(codclien));
        aqolicklist.Open;
        PICKLISTDESC:=TRIM(aqolicklist.FIELDBYNAME('PICKLISTDESC').ASSTRING);

        aqolicklist.Close;
        aqolicklist.free;




          modulo.QUERY_WEB.Close;
            modulo.QUERY_WEB.SQL.Clear;
            modulo.QUERY_WEB.SQL.Add('select * from REVISIONVEHICULO where CODPLANTA='+#39+TRIM(CODPLANTA)+#39+' and CODREVISION='+inttostr(CODREVISION));
            modulo.QUERY_WEB.ExecSQL;
            modulo.QUERY_WEB.Open;
           if  modulo.QUERY_WEB.IsEmpty=true then
           begin

             if trim(FECVENCI)='' then
                begin
                   SQL_WEB:='INSERT INTO REVISIONVEHICULO ( CODPLANTA,CODREVISION ,CODTIPOATENCION ,CODATENCION,CODESTADOREVISION ,NUMREVISION,  '+
                                             ' PATENTE,CODTIPOVEHICULO ,FECHALTA,CODCLASE,RESULTADO,CODFRECU_UNICO , NUMMAQUINA,PICKLISTDESC) '+
                                             ' VALUES ('+#39+TRIM(CODPLANTA)+#39+','+INTTOSTR(CODREVISION)+','+inttostr(CODTIPOATENCION)+','+INTTOSTR(CODATENCION)+','+INTTOSTR(CODESTADOREVISION)+
                                             ','+INTTOSTR(NUMREVISION)+','+#39+TRIM(PATENTE)+#39+','+INTTOSTR(CODTIPOVEHICULO)+',CONVERT(DATETIME,'+#39+TRIM(FECHALTA)+#39+',103) '+
                                             ','+#39+TRIM(CODCLASE)+#39+','+#39+TRIM(RESULTADO)+#39+','+INTTOSTR(CODFRECU_UNICO)+
                                             ','+INTTOSTR(NUMMAQUINA)+','+#39+trim(PICKLISTDESC)+#39+')';

               end else begin

                 SQL_WEB:='INSERT INTO REVISIONVEHICULO ( CODPLANTA,CODREVISION ,CODTIPOATENCION ,CODATENCION,CODESTADOREVISION ,NUMREVISION,  '+
                                             ' PATENTE,CODTIPOVEHICULO ,FECHALTA,CODCLASE,RESULTADO,CODFRECU_UNICO , NUMMAQUINA,FECVENCI,PICKLISTDESC) '+
                                             ' VALUES ('+#39+TRIM(CODPLANTA)+#39+','+INTTOSTR(CODREVISION)+','+inttostr(CODTIPOATENCION)+','+INTTOSTR(CODATENCION)+','+INTTOSTR(CODESTADOREVISION)+
                                             ','+INTTOSTR(NUMREVISION)+','+#39+TRIM(PATENTE)+#39+','+INTTOSTR(CODTIPOVEHICULO)+',CONVERT(DATETIME,'+#39+TRIM(FECHALTA)+#39+',103) '+
                                             ','+#39+TRIM(CODCLASE)+#39+','+#39+TRIM(RESULTADO)+#39+','+INTTOSTR(CODFRECU_UNICO)+
                                             ','+INTTOSTR(NUMMAQUINA)+',convert(datetime,'+#39+trim(FECVENCI)+#39+',103),'+#39+trim(PICKLISTDESC)+#39+')';
                end;

             modulo.CONEXION.BeginTrans;
               TRY
                 modulo.QUERY_WEB.Close;
                 modulo.QUERY_WEB.SQL.Clear;
                 modulo.QUERY_WEB.SQL.Add(SQL_WEB);
                 modulo.QUERY_WEB.ExecSQL;
                modulo.CONEXION.CommitTrans;

           ACTUALIZA_WASPRE(CODREVISION);


           EXCEPT
           modulo.CONEXION.RollbackTrans;

          END;

       end ;       

        NEXT;
        END;



  finally
        Close;
        Free;
  end;

 //Application.MessageBox( 'PROCESO TERMINADO.', 'Atención',
 // MB_ICONINFORMATION );
end;


procedure Texportat_datos_a_turnos.FormActivate(Sender: TObject);
begin
modulo.query_exportar1.Close;
modulo.query_exportar1.SQL.Clear;
modulo.query_exportar1.SQL.Add('select centro, nombre from centros order by nombre asc');
modulo.query_exportar1.ExecSQL;
modulo.query_exportar1.Open;


end;

procedure Texportat_datos_a_turnos.BitBtn2Click(Sender: TObject);
begin
close;
end;

end.
