unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls,inifiles, DB, ADODB, FMTBcd, SqlExpr, USuperRegistry,
   DBXpress, Provider, dbclient, DBCtrls, ExtCtrls, RXShell, Menus,
  InvokeRegistry, Rio, SOAPHTTPClient, ActiveX, MSXML, XMLIntf, XMLDoc;

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
        //APPLICATION_KEY = '\SOFTWARE\'+COMPANY_NAME+'\'+APPLICATION_NAME;
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
    //HTTPRIO1: THTTPRIO;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Ocultar1Click(Sender: TObject);
    procedure Mostrar1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  //Globales, usados por varias tablas
  Planta,Fechalta,Fecha,
  Codvehic,Codinspe,Codclien,
  Numejes,Cola,Largo,
  Alto,Ancho,Tara,
  Numchasis,Error,
  Codpais,Codfactu,
  Ejercici,Numrevis:STRING;
  //TINSPECCION
  Codclpro,
  Codclcon,Codclten,Inspfina,
  Tipo,Codfrecu,FecVenci,
  Numoblea,HorFinal,
  HorentZ1,HorsalZ1,HorentZ2,
  HorSalZ2,HorentZ3,HorSalZ3,
  OBSERVAC,Resultad,Waspre,
  NumrevS1,NumlinS1,NumrevS2,
  NumlinS2,NumrevS3,NumlinS3,
  Codservicio,Enviado:STRING;
  //TVEHICULOS
  Fechamatri,Aniofabr,
  Codmarca,Codmodel,Tipoespe,
  Tipodest,AnyoChasis,
  Nummotor,PatenteN,
  PatenteA,Codtipocombustible,
  Codmarcachasis,Codmodelochasis,
  Tiporegistradoreventos,
  Codtiposuspension,
  Internacional,Tacografo,CodpadClien,
  Codpavehic,NroRegistro:STRING;
  //Ejedistancia
  DPE,Disejes12,Disejes23,Disejes34,
  Disejes45,Disejes56,
  Disejes67,Disejes78,Disejes89:STRING;
  //Tdatinspevi
  Secudefe,Numlinea,Numzona,
  Caddefec,Califdef,OtrosDef,
  Ubicadef:STRING;
  //Dimensiones_Vehiculos
  PesoBruto:STRING;
  //Vehicomnibus
  Cantasientos,Banio,Cantpuertas,
  Aireacondicionado,Codtiposientos,
  Codtipobodega,Codcategoriaservicio,
  Accesibilidad,Codmarcacarroceria,
  CodTipoServicio,CodTipoSubServicio:STRING;
  //Tinspdefect
  Secdefec,Localiza,Valormed,Calidef:STRING;
  //Vehiccarga
  Longitudenganche,Codtipocajacarga,
  Codtipocabina,Codtipocarga,
  Codtipoaditamento:STRING;
  //Tclientes
  Tipodocu,Document,TipoclienteID,
  Nombre,Apellid1,Tiptribu,
  Creditcl,Telefono,Localida,
  Direccio,Nrocalle,Depto,
  Idlocalidad,Mail,Idpais,
  Iddepartamento,Dvdocument,Profesional,
  Codparti,Apellid2,CodArea,Celular,
  Coddocu,Codposta,Piso:STRING;
  //Ejerodado
  Eje,Cantidad,Codtiponeumatico:STRING;
  //tfacturas
  Impresa,Tipfactu,Formpago,Ivainscr,
  Impoiva,Imponeto,Numfactu,Importemoneda,
  Codmoneda,Idcancelacion,Cae,Estado,codcofac:STRING;
  //Tdatosturno
  TurnoID,Tipoturno,Fechaturno,Horaturno,
  Fecharegistro,Ttulartipodocumento,Titularnombre,
  Titularapellido,Contactotipodocumento,Contactonombre,
  Contactoapellido,Contactotelefono,Contactoemail,
  Dvdomino,DvmarcaID,Dvmarca,Dvmodelo,DvmodeloID,
  Dftipodocumento,Dfnrodocumento,Dfnombre,Dfapellido,
  Ausente,Facturado,Reviso,InformadoWS,
  Tipoinspe,EstadoID,Estadodesc,Fechanovedad:String;

 function limpiar_variables:boolean;
  public
    { Public declarations }
    se_conector:BOOLEAN;
    BASE,centro:STRING;
    CITAS_CONECT:BOOLEAN;
    NOMPLANTA:STRING;
    ARCHIVO_LOG:STRING;
    Archivo_XML:STRING;
    Archivo_XML_PRO:STRING;
    Archivo_XML_MER:STRING;
    Tabla:STRING;
    //oFilesList : TStringList;
    PROCEDURE TestOfBD(Alias, UserName, Password: String; Ageva: boolean);
    function conexion_virtual(base:string):boolean;
    function GUARDA_LOG(MENSAJE:STRING):BOOLEAN;
    PROCEDURE EJECUTAR;
    PROCEDURE GUARDARDATOS_TINSPECCION (Planta,Fecha,Ejercici,Codinspe,Codvehic,Codclpro,Codclcon,Codclten,Inspfina,Tipo,Fechalta,Codfrecu,FecVenci,
                                        Numoblea,Codfactu,HorFinal,HorentZ1,HorsalZ1,HorentZ2,HorSalZ2,HorentZ3,HorSalZ3,OBSERVAC,Resultad,Waspre,
                                        NumrevS1,NumlinS1,NumrevS2,NumlinS2,NumrevS3,NumlinS3,Codservicio,Enviado,Profesional:STRING);
    PROCEDURE GUARDARDATOS_TVEHICULOS (Fechamatri,Aniofabr,Codmarca,Codmodel,Tipoespe,Tipodest,Numchasis,AnyoChasis,Numejes,Nummotor,PatenteN,PatenteA,
                                       Cola,Largo,Alto,Ancho,Tara,Codpais,Error,Internacional,Tacografo,Codpavehic,CodpadClien,NroRegistro,Codtipocombustible,
                                       Codmarcachasis,Codmodelochasis,Tiporegistradoreventos,Codtiposuspension,Fechalta,PesoBruto:STRING);
    PROCEDURE GUARDARDATOS_EJEDISTANCIA (Planta,Codinspe,Codvehic,Numejes,Cola,DPE,Numchasis,Disejes12,Disejes23,Disejes34,Disejes45,Disejes56,
                                         Numrevis,Fechalta,Disejes67,Disejes78,Disejes89,Alto,Ancho,Largo:STRING);
    PROCEDURE GUARDARDATOS_TDATINSPEVI (Planta,Ejercici,Codinspe,Secudefe,Numrevis,Numlinea,Numzona,Caddefec,Califdef,Ubicadef,OtrosDef,Fechalta:STRING);
    PROCEDURE GUARDARDATOS_DIMENSIONES_VEHICULOS (Planta,Ejercici,Codinspe,Codvehic,Largo,Alto,Ancho,Tara,PesoBruto,Fecha:STRING);
    PROCEDURE GUARDARDATOS_VEHICOMNIBUS (Planta,Codvehic,Cantasientos,Banio,Cantpuertas,Aireacondicionado,Codtiposientos,Codtipobodega,
                                         Codcategoriaservicio,Accesibilidad,Codmarcacarroceria,CodTipoServicio,CodTipoSubServicio:STRING);
    PROCEDURE GUARDARDATOS_TINSPDEFECT (Planta,Ejercici,Codinspe,Secdefec,Localiza,Caddefec,Calidef,Valormed,Fechalta:STRING);
    PROCEDURE GUARDARDATOS_VEHICCARGA (Planta,Codvehic,Longitudenganche,Codtipocajacarga,Codtipocabina,Codtipocarga,Codtipoaditamento:STRING);
    PROCEDURE GUARDARDATOS_TCLIENTES (Planta,Codclien,Tipodocu,Document,TipoclienteID,Fechalta,Nombre,Apellid1,Codparti,Tiptribu,
                                      Creditcl,Codposta,Telefono,Apellid2,Localida,Direccio,Nrocalle,Piso,Depto,Idlocalidad,CodArea,
                                      Celular,Mail,Idpais,Coddocu,Iddepartamento,Dvdocument,Profesional:STRING);
    PROCEDURE GUARDARDATOS_EJERODADO (Planta,Codinspe,Codvehic,Eje,Cantidad,Codtiponeumatico:STRING);
    PROCEDURE GUARDARDATOS_TFACTURAS (Planta,Codfactu,Impresa,Fechalta,Tipfactu,Tiptribu,Formpago,Ivainscr,Codclien,Impoiva,
                                      Imponeto,Numfactu,codcofac,Importemoneda,Codmoneda,Idcancelacion,Error,Cae,Estado:STRING);
    PROCEDURE GUARDARDATOS_TDATOSTURNO (Planta,TurnoID,Tipoturno,Fechaturno,Horaturno,Fecharegistro,Ttulartipodocumento,Titularnombre,Titularapellido,
                                        Contactotipodocumento,Contactonombre,Contactoapellido,Contactotelefono,Contactoemail,Dvdomino,DvmarcaID,Dvmarca,
                                        Dvmodelo,DvmodeloID,Dftipodocumento,Dfnrodocumento,Dfnombre,Dfapellido,Codvehic,Ausente,Facturado,Reviso,InformadoWS,
                                        Fechalta,Tipoinspe,EstadoID,Estadodesc,Fechanovedad:STRING);
    PROCEDURE CARGAXMLS(Archivo_XML:String);
    PROCEDURE GetFileList(aFiles : TStringList; sPath : string; sMask : string = '*.*');
    PROCEDURE GetFileListPRO(aFiles : TStringList; sPath : string; sMask : string = '*.*');
    PROCEDURE GetFileListMER(aFiles : TStringList; sPath : string; sMask : string = '*.*');
    procedure DoListadoMergeTurnos;
    procedure CopiarArchivosPRO(Archivo_XML_PRO:String);
    procedure CopiarArchivosMER(Archivo_XML_MER:String);
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
  GUARDA_LOG(DATETOSTR(DATE)+'-'+TIMETOSTR(TIME)+'-NO DE PUSO CONECTAR A LA BASE MTOP');
  CITAS_CONECT:=FALSE;
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
alias,userbd,password:STRING;
link:string;
LOG:textfile;
FE:STRING;
oFilesList : TStringList;

begin
FE:=COPY(DATETOSTR(DATE),1,2)+COPY(DATETOSTR(DATE),4,2)+COPY(DATETOSTR(DATE),7,4);
ARCHIVO_LOG:='LOG_'+FE+'.txt';
link:= ExtractFilePath( Application.ExeName ) + ARCHIVO_LOG;
assignfile(LOG,link);
REWRITE(LOG);
closefile(log);

//SQL
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

//conexion_virtual('db_web_uruguay'); //SQL
conexion_virtual(BASE);  //SQL
IF CITAS_CONECT=TRUE THEN BEGIN  //SQL

   begin
     MEMO1.Clear;
     //NOMPLANTA:=IntToStr(Planta);
     userbd:= 'SAGMTOP';
     password:= 'M0102top';
     //userbd:= 'CABASM';
     //password:= '02lusabaqui03';
     TestOfBD(alias,userbd,password,false);

     if se_conector=true then

      BEGIN
        form1.Caption:='CONECTADO A '+ userbd;
        FORM1.HiNT:='CONECTADO A '+ userbd;
        RxTrayIcon1.HiNT:='CONECTADO A '+ userbd;
        APPLICATION.ProcessMessages;

        GetFileListPRO(oFilesList,'X:\','*.XML');
        GetFileListMER(oFilesList,'Z:\','*.XML');
        GetFileList(oFilesList,'C:\MTOP\XML\','*.XML');
          IF Archivo_XML <> '' THEN
            BEGIN
              CARGAXMLS(Archivo_XML);
            END ELSE BEGIN
               EXIT;
          END;
     END;

   mybd.Close;
end;

//modulo.conexion.Close; //SQL

END; //SQL

end;

procedure TForm1.DoListadoMergeTurnos;
VAR
CANTIDAD,DESDE,HASTA,consulta,
FECHAINI,FECHAFIN:STRING;
CENTRO:longint;

begin

    with TSQLQuery.Create(nil) do
     try
       SQLConnection:=mybd;
       SQL.Clear;
       SQL.Add('DELETE FROM TTMPTOTALOFRECIDOS');
       execsql;
      finally
         close;
         free;
      end;

          modulo.QUERY_WEB.Close;
          modulo.QUERY_WEB.SQL.Clear;
          modulo.QUERY_WEB.SQL.Add('SELECT LTRIM(RTRIM(CENTRO)) AS CENTRO, CONVERT(VARCHAR,DESDE,103) AS DESDE, CONVERT(VARCHAR,HASTA,103) AS HASTA,'+
                                   '([D0600]+[D0615]+[D0630]+[D0645]+[D0700]+[D0715]+[D0730]+[D0745]+[D0800]+[D0815]'+
                                   '+[D0830]+[D0845]+[D0900]+[D0915]+[D0930]+[D0945]+[D1000]+[D1015]+[D1030]+[D1045]'+
                                   '+[D1100]+[D1115]+[D1130]+[D1145]+[D1200]+[D1215]+[D1230]+[D1245]+[D1300]+[D1315]'+
                                   '+[D1330]+[D1345]+[D1400]+[D1415]+[D1430]+[D1445]+[D1500]+[D1515]+[D1530]+[D1545]'+
                                   '+[D1600]+[D1615]+[D1630]+[D1645]+[D1700]+[D1715]+[D1730]+[D1745]+[D1800]+[D1815]'+
                                   '+[D1830]+[D1845]+[D1900]+[D1915]+[D1930]+[D1945]+[D2000]+[D2015]+[D2030]+[D2045]'+
                                   '+[D2100]+[D2115]+[D2130]+[D2145]+[D2200]+[D2215]+[D2230]+[D2245]) AS CANTIDAD '+
                                   ' FROM [db_web_uruguay].[dbo].[Plantilla] ');
                                 //'WHERE DESDE >= '+#39+FECHAINI+#39+
                                 //'  AND HASTA <= DATEADD(DAY,10,'+#39+FECHAFIN+#39+')');
          modulo.QUERY_WEB.ExecSQL;
          modulo.QUERY_WEB.Open;

          WHILE NOT modulo.QUERY_WEB.Eof DO

          BEGIN
          CENTRO:=modulo.QUERY_WEB.FIELDBYNAME('CENTRO').ASinteger;
          DESDE:=modulo.QUERY_WEB.FIELDBYNAME('DESDE').ASSTRING;
          HASTA:=modulo.QUERY_WEB.FIELDBYNAME('HASTA').ASSTRING;
          CANTIDAD:=modulo.QUERY_WEB.FIELDBYNAME('CANTIDAD').ASSTRING;

          FECHAINI:=FormatDateTime('DD-MM-YYYY',strtodatetime(DESDE));
          FECHAFIN:=FormatDateTime('DD-MM-YYYY',strtodatetime(HASTA));

          consulta:='INSERT INTO TTMPTOTALOFRECIDOS (PLANTA,DESDE,HASTA,CANTIDAD)'+
                     ' VALUES ('+
                     ' '+inttostr(CENTRO)+' '+
                     ','+#39+TRIM(FECHAINI)+#39+' '+
                     ','+#39+TRIM(FECHAFIN)+#39+' '+
                     ','+#39+TRIM(CANTIDAD)+#39+' '+
                     ')';

           with TSQLQuery.Create(nil) do
            try
              SQLConnection:= MYBD;
              MEMO1.Lines.Add('TURNOS CENTRO: '+INTTOSTR(CENTRO)+' DESDE:'+TRIM(FECHAINI)+' HASTA:'+TRIM(FECHAFIN));
              RxTrayIcon1.HiNT:='TURNOS CENTRO: '+INTTOSTR(CENTRO)+' DESDE:'+TRIM(FECHAINI)+' HASTA:'+TRIM(FECHAFIN);
              APPLICATION.ProcessMessages;
              SQL.Clear;
              SQL.Add(consulta);
              ExecSQL;
              MEMO1.Lines.Add('TURNOS OFRECIDOS: OK');
              APPLICATION.ProcessMessages;

           except
             on E:Exception do
              begin
                GUARDA_LOG(DATETOSTR(DATE)+'-'+TIMETOSTR(TIME)+'NO SE PUDO LEER LOS DATOS por: ' + E.message)
              end;
           end;
        modulo.QUERY_WEB.NEXT;
      end;
end;

procedure TFORM1.CopiarArchivosPRO(Archivo_XML_PRO:String);

begin
{ Unidad X: Progreso }
    CopyFile(PChar('X:\'+Archivo_XML_PRO),PChar('C:\MTOP\XML\'+Archivo_XML_PRO),false);
    CopyFile(PChar('X:\'+Archivo_XML_PRO),PChar('X:\BackUp\'+Archivo_XML_PRO),false);
    CARGAXMLS(Archivo_XML_PRO);
    DeleteFile(PChar('X:\'+Archivo_XML_PRO));
end;

procedure TFORM1.CopiarArchivosMER(Archivo_XML_MER:String);

begin
{ Unidad Z: Mercedes }
    CopyFile(PChar('Z:\'+Archivo_XML_MER),PChar('C:\MTOP\XML\'+Archivo_XML_MER),false);
    CopyFile(PChar('Z:\'+Archivo_XML_MER),PChar('Z:\BackUp\'+Archivo_XML_MER),false);
    CARGAXMLS(Archivo_XML_MER);
    DeleteFile(PChar('Z:\'+Archivo_XML_MER));
end;

Procedure TFORM1.GetFileListPRO(aFiles : TStringList; sPath : string; sMask : string = '*.*');
var
SearchRec : TSearchRec;

begin

if aFiles = Nil then
aFiles := TStringList.Create;

if findfirst(sPath+sMask, faAnyFile, SearchRec) = 0 then
  begin
    repeat
    Archivo_XML_PRO:=(SearchRec.Name);
    //ShowMessage('Archivo XML PRO = '+SearchRec.Name);
    until FindNext(SearchRec) <> 0;

    // Must free up resources used by these successful finds
    FindClose(SearchRec);
  end;
    memo1.Lines.Add('Copiando Archivo '+Archivo_XML_PRO) ;
    APPLICATION.ProcessMessages;
    CopiarArchivosPRO(Archivo_XML_PRO);

end;

Procedure TFORM1.GetFileListMER(aFiles : TStringList; sPath : string; sMask : string = '*.*');
var
SearchRec : TSearchRec;

begin

if aFiles = Nil then
aFiles := TStringList.Create;

if findfirst(sPath+sMask, faAnyFile, SearchRec) = 0 then
  begin
    repeat
    Archivo_XML_MER:=(SearchRec.Name);
    //ShowMessage('Archivo XML MER = '+SearchRec.Name);
    until FindNext(SearchRec) <> 0;

    // Must free up resources used by these successful finds
    FindClose(SearchRec);
  end;
    memo1.Lines.Add('Copiando Archivo '+Archivo_XML_MER) ;
    APPLICATION.ProcessMessages;
    CopiarArchivosMER(Archivo_XML_MER);
end;

Procedure TFORM1.GetFileList(aFiles : TStringList; sPath : string; sMask : string = '*.*');
var
SearchRec : TSearchRec;

begin

if aFiles = Nil then
aFiles := TStringList.Create;

if findfirst(sPath+sMask, faAnyFile, SearchRec) = 0 then
  begin
    repeat
    Archivo_XML:=(SearchRec.Name);
      //ShowMessage('File name = '+SearchRec.Name);
    until FindNext(SearchRec) <> 0;

    // Must free up resources used by these successful finds
    FindClose(SearchRec);
  end;
end;

PROCEDURE TForm1.CARGAXMLS(Archivo_XML:String);
var
  //MEMO:TMEMO;
  Doc: IXMLDocument;
  Data: IXMLNode;
  Node: IXMLNode;
  I: Integer;
begin

TRY
memo1.Lines.Add('LEYENDO ARCHIVO....'+Archivo_XML) ;
APPLICATION.ProcessMessages;

  Doc := LoadXMLDocument('C:\MTOP\XML\'+Archivo_XML);
  Data := Doc.DocumentElement;
  for I := 0 to Data.ChildNodes.Count-1 do
  begin
    Node := Data.ChildNodes[I];
    if Node.NodeName = 'Tinspeccion' then
    begin
      Planta := Node.ChildNodes['Planta'].Text;
      Ejercici:=Node.ChildNodes['Ejercici'].Text;
      Codinspe:=Node.ChildNodes['Codinspe'].Text;
      Codvehic:=Node.ChildNodes['Codvehic'].Text;
      Codclpro:=Node.ChildNodes['Codclpro'].Text;
      Codclcon:=Node.ChildNodes['Codclcon'].Text;
      Codclten:=Node.ChildNodes['Codclten'].Text;
      Inspfina:=Node.ChildNodes['Inspfina'].Text;
      Tipo:=Node.ChildNodes['Tipo'].Text;
      Fechalta:=Node.ChildNodes['Fechalta'].Text;
      Codfrecu:=Node.ChildNodes['Codfrecu'].Text;
      FecVenci:=Node.ChildNodes['FecVenci'].Text;
      Numoblea:=Node.ChildNodes['Numoblea'].Text;
      Codfactu:=Node.ChildNodes['Codfactu'].Text;
      HorFinal:=Node.ChildNodes['HorFinal'].Text;
      HorentZ1:=Node.ChildNodes['HorentZ1'].Text;
      HorsalZ1:=Node.ChildNodes['HorsalZ1'].Text;
      HorentZ2:=Node.ChildNodes['HorentZ2'].Text;
      HorSalZ2:=Node.ChildNodes['HorSalZ2'].Text;
      HorentZ3:=Node.ChildNodes['HorentZ3'].Text;
      HorSalZ3:=Node.ChildNodes['HorSalZ3'].Text;
      OBSERVAC:=Node.ChildNodes['OBSERVAC'].Text;
      Resultad:=Node.ChildNodes['Resultad'].Text;
      Waspre:=Node.ChildNodes['Waspre'].Text;
      NumrevS1:=Node.ChildNodes['NumrevS1'].Text;
      NumlinS1:=Node.ChildNodes['NumlinS1'].Text;
      NumrevS2:=Node.ChildNodes['NumrevS2'].Text;
      NumlinS2:=Node.ChildNodes['NumlinS2'].Text;
      NumrevS3:=Node.ChildNodes['NumrevS3'].Text;
      NumlinS3:=Node.ChildNodes['NumlinS3'].Text;
      Codservicio:=Node.ChildNodes['Codservicio'].Text;
      Enviado:=Node.ChildNodes['Enviado'].Text;
      Profesional:=Node.ChildNodes['Profesional'].Text;
    end else
    if Node.NodeName = 'Tvehiculos' then
    begin
      Planta := Node.ChildNodes['Planta'].Text;
      Codvehic:=Node.ChildNodes['Codvehic'].Text;
      Fechamatri:=Node.ChildNodes['Fecmatri'].Text;
      Fechalta:=Node.ChildNodes['Fechalta'].Text;
      Aniofabr:=Node.ChildNodes['Aniofabr'].Text;
      Codmarca:=Node.ChildNodes['Codmarca'].Text;
      Codmodel:=Node.ChildNodes['Codmodel'].Text;
      Tipoespe:=Node.ChildNodes['Tipoespe'].Text;
      Tipodest:=Node.ChildNodes['TIpodest'].Text;
      Numchasis:=Node.ChildNodes['Numchasis'].Text;
      AnyoChasis:=Node.ChildNodes['Anyochasis'].Text;
      Numejes:=Node.ChildNodes['numejes'].Text;
      Nummotor:=Node.ChildNodes['Nummotor'].Text;
      PatenteN:=Node.ChildNodes['PatenteN'].Text;
      PatenteA:=Node.ChildNodes['PatenteA'].Text;
      Codtipocombustible:=Node.ChildNodes['Codtipocombustible'].Text;
      Codmarcachasis:=Node.ChildNodes['Codmarcachasis'].Text;
      Codmodelochasis:=Node.ChildNodes['Codmodelochasis'].Text;
      PesoBruto:=Node.ChildNodes['Pesobruto'].Text;
      Cola:=Node.ChildNodes['Cola'].Text;
      Largo:=Node.ChildNodes['Largo'].Text;
      Alto:=Node.ChildNodes['Alto'].Text;
      Ancho:=Node.ChildNodes['Ancho'].Text;
      Tara:=Node.ChildNodes['Tara'].Text;
      Tiporegistradoreventos:=Node.ChildNodes['Tiporegistradoreventos'].Text;
      Codtiposuspension:=Node.ChildNodes['Codtiposuspension'].Text;
      Codpais:=Node.ChildNodes['Codpais'].Text;
      Error:=Node.ChildNodes['Error'].Text;
      Internacional:=Node.ChildNodes['Internacional'].Text;
      Tacografo:=Node.ChildNodes['Tacografo'].Text;
      Codpavehic:=Node.ChildNodes['Codpavehic'].Text;
      CodpadClien:=Node.ChildNodes['CodpadClien'].Text;
      NroRegistro:=Node.ChildNodes['NroRegistro'].Text;
    end else
    if Node.NodeName = 'Ejedistancia' then
    begin
      Planta := Node.ChildNodes['Planta'].Text;
      Codinspe:= Node.ChildNodes['Codinspe'].Text;
      Codvehic:=Node.ChildNodes['Codvehic'].Text;
      Numejes:=Node.ChildNodes['Numejes'].Text;
      Cola:=Node.ChildNodes['Cola'].Text;
      DPE:=Node.ChildNodes['DPE'].Text;
      Numchasis:=Node.ChildNodes['Numchasis'].Text;
      Disejes12:=Node.ChildNodes['Disejes12'].Text;
      Disejes23:=Node.ChildNodes['Disejes23'].Text;
      Disejes34:=Node.ChildNodes['Disejes34'].Text;
      Disejes45:=Node.ChildNodes['Disejes45'].Text;
      Disejes56:=Node.ChildNodes['Disejes56'].Text;
      Numrevis:=Node.ChildNodes['Numrevis'].Text;
      Fechalta:=Node.ChildNodes['Fechalta'].Text;
      Disejes67:=Node.ChildNodes['Disejes67'].Text;
      Disejes78:=Node.ChildNodes['Disejes78'].Text;
      Disejes89:=Node.ChildNodes['Disejes89'].Text;
      Alto:=Node.ChildNodes['Alto'].Text;
      Ancho:=Node.ChildNodes['Ancho'].Text;
      Largo:=Node.ChildNodes['Largo'].Text;
    end else
    if Node.NodeName = 'Tdatinspevi' then
    begin
      Planta := Node.ChildNodes['Planta'].Text;
      Ejercici:= Node.ChildNodes['Ejercici'].Text;
      Codinspe:=Node.ChildNodes['Codinspe'].Text;
      Secudefe:=Node.ChildNodes['Secudefe'].Text;
      Numrevis:=Node.ChildNodes['Numrevis'].Text;
      Numlinea:=Node.ChildNodes['Numlinea'].Text;
      Numzona:=Node.ChildNodes['Numzona'].Text;
      Caddefec:=Node.ChildNodes['Caddefec'].Text;
      Califdef:=Node.ChildNodes['Califdef'].Text;
      Ubicadef:=Node.ChildNodes['Ubicadef'].Text;
      OtrosDef:=Node.ChildNodes['OtrosDef'].Text;
      Fechalta:=Node.ChildNodes['Fechalta'].Text;
    end else
    if Node.NodeName = 'Dimensiones_Vehiculos' then
    begin
      Planta := Node.ChildNodes['Planta'].Text;
      Ejercici:= Node.ChildNodes['Ejercici'].Text;
      Codinspe:=Node.ChildNodes['Codinspe'].Text;
      Codvehic:=Node.ChildNodes['Codvehic'].Text;
      Largo:=Node.ChildNodes['Largo'].Text;
      Alto:=Node.ChildNodes['Alto'].Text;
      Ancho:=Node.ChildNodes['Ancho'].Text;
      Tara:=Node.ChildNodes['Tara'].Text;
      PesoBruto:=Node.ChildNodes['PesoBruto'].Text;
      Fecha:=Node.ChildNodes['Fecha'].Text;
    end else
    if Node.NodeName = 'Vehicomnibus' then
    begin
      Planta := Node.ChildNodes['Planta'].Text;
      Codvehic:=Node.ChildNodes['Codvehic'].Text;
      Cantasientos:=Node.ChildNodes['Cantasientos'].Text;
      Banio:=Node.ChildNodes['Banio'].Text;
      Cantpuertas:=Node.ChildNodes['Cantpuertas'].Text;
      Aireacondicionado:=Node.ChildNodes['Aireacondicionado'].Text;
      Codtiposientos:=Node.ChildNodes['Codtiposientos'].Text;
      Codtipobodega:=Node.ChildNodes['Codtipobodega'].Text;
      Codcategoriaservicio:=Node.ChildNodes['Codcategoriaservicio'].Text;
      Accesibilidad:=Node.ChildNodes['Accesibilidad'].Text;
      Codmarcacarroceria:=Node.ChildNodes['Codmarcacarroceria'].Text;
      CodTipoServicio:=Node.ChildNodes['CodTipoServicio'].Text;
      CodTipoSubServicio:=Node.ChildNodes['CodTipoSubServicio'].Text;
    end else
    if Node.NodeName = 'Tinspdefect' then
    begin
      Planta := Node.ChildNodes['Planta'].Text;
      Ejercici:=Node.ChildNodes['Ejercici'].Text;
      Codinspe:=Node.ChildNodes['Codinspe'].Text;
      Secdefec:=Node.ChildNodes['Secdefec'].Text;
      Localiza:=Node.ChildNodes['Localiza'].Text;
      Caddefec:=Node.ChildNodes['Caddefec'].Text;
      Calidef:=Node.ChildNodes['Calidef'].Text;
      Valormed:=Node.ChildNodes['Valormed'].Text;
      Fechalta:=Node.ChildNodes['Fechalta'].Text;
    end else
    if Node.NodeName = 'Vehiccarga' then
    begin
      Planta := Node.ChildNodes['Planta'].Text;
      Codvehic:=Node.ChildNodes['Codvehic'].Text;
      Longitudenganche:=Node.ChildNodes['Longitudenganche'].Text;
      Codtipocajacarga:=Node.ChildNodes['Codtipocajacarga'].Text;
      Codtipocabina:=Node.ChildNodes['Codtipocabina'].Text;
      Codtipocarga:=Node.ChildNodes['Codtipocarga'].Text;
      Codtipoaditamento:=Node.ChildNodes['Codtipoaditamento'].Text;
    end else
    if Node.NodeName = 'TClientes' then
    begin
      Planta := Node.ChildNodes['Planta'].Text;
      Codclien:=Node.ChildNodes['Codclien'].Text;
      Tipodocu:=Node.ChildNodes['Tipodocu'].Text;
      Document:=Node.ChildNodes['Document'].Text;
      TipoclienteID:=Node.ChildNodes['TipoclienteID'].Text;
      Fechalta:=Node.ChildNodes['Fechalta'].Text;
      Nombre:=Node.ChildNodes['Nombre'].Text;
      Apellid1:=Node.ChildNodes['Apellid1'].Text;
      Codparti:=Node.ChildNodes['Codparti'].Text;
      Tiptribu:=Node.ChildNodes['Tiptribu'].Text;
      Creditcl:=Node.ChildNodes['Creditcl'].Text;
      Codposta:=Node.ChildNodes['Codposta'].Text;
      Telefono:=Node.ChildNodes['Telefono'].Text;
      Apellid2:=Node.ChildNodes['Apellid2'].Text;
      Localida:=Node.ChildNodes['Localida'].Text;
      Direccio:=Node.ChildNodes['Direccio'].Text;
      Nrocalle:=Node.ChildNodes['Nrocalle'].Text;
      Piso:=Node.ChildNodes['Piso'].Text;
      Depto:=Node.ChildNodes['Depto'].Text;
      Idlocalidad:=Node.ChildNodes['Idlocalidad'].Text;
      CodArea:=Node.ChildNodes['CodArea'].Text;
      Celular:=Node.ChildNodes['Celular'].Text;
      Mail:=Node.ChildNodes['Mail'].Text;
      Idpais:=Node.ChildNodes['Idpais'].Text;
      Coddocu:=Node.ChildNodes['Idpais'].Text;
      Iddepartamento:=Node.ChildNodes['Iddepartamento'].Text;
      Dvdocument:=Node.ChildNodes['Dvdocument'].Text;
      Profesional:=Node.ChildNodes['Profesional'].Text;
    end else
    if Node.NodeName = 'EJERODADOS' then
    begin
      Planta := Node.ChildNodes['Planta'].Text;
      Codinspe:= Node.ChildNodes['Codinspe'].Text;
      Codvehic:= Node.ChildNodes['Codvehic'].Text;
      Eje:= Node.ChildNodes['Eje'].Text;
      Cantidad:= Node.ChildNodes['Cantidad'].Text;
      Codtiponeumatico:= Node.ChildNodes['Codtiponeumatico'].Text;
    end else
    if Node.NodeName = 'TFacturas' then
    begin
      Planta := Node.ChildNodes['Planta'].Text;
      Codfactu:= Node.ChildNodes['Codfactu'].Text;
      Impresa:= Node.ChildNodes['Impresa'].Text;
      Fechalta:= Node.ChildNodes['Fechalta'].Text;
      Tipfactu:= Node.ChildNodes['Tipfactu'].Text;
      Tiptribu:= Node.ChildNodes['Tiptribu'].Text;
      Formpago:= Node.ChildNodes['Formpago'].Text;
      Ivainscr:= Node.ChildNodes['Ivainscr'].Text;
      Codclien:= Node.ChildNodes['Codclien'].Text;
      Impoiva:= Node.ChildNodes['Impoiva'].Text;
      Imponeto:= Node.ChildNodes['Imponeto'].Text;
      Numfactu:= Node.ChildNodes['Numfactu'].Text;
      codcofac:= Node.ChildNodes['codcofac'].Text;
      Importemoneda:= Node.ChildNodes['Importemoneda'].Text;
      Codmoneda:= Node.ChildNodes['Codmoneda'].Text;
      Idcancelacion:= Node.ChildNodes['Idcancelacion'].Text;
      Error:= Node.ChildNodes['Error'].Text;
      Cae:= Node.ChildNodes['Cae'].Text;
      Estado:= Node.ChildNodes['Estado'].Text;
    end else
    if Node.NodeName = 'TDatosturno' then
    begin
      Planta := Node.ChildNodes['Planta'].Text;
      TurnoID:= Node.ChildNodes['TurnoID'].Text;
      Tipoturno:= Node.ChildNodes['Tipoturno'].Text;
      Fechaturno:= Node.ChildNodes['Fechaturno'].Text;
      Horaturno:= Node.ChildNodes['Horaturno'].Text;
      Fecharegistro:= Node.ChildNodes['Fecharegistro'].Text;
      Ttulartipodocumento:= Node.ChildNodes['Ttulartipodocumento'].Text;
      Titularnombre:= Node.ChildNodes['Titularnombre'].Text;
      Titularapellido:= Node.ChildNodes['Titularapellido'].Text;
      Contactotipodocumento:= Node.ChildNodes['Contactotipodocumento'].Text;
      Contactonombre:= Node.ChildNodes['Contactonombre'].Text;
      Contactoapellido:= Node.ChildNodes['Contactoapellido'].Text;
      Contactotelefono:= Node.ChildNodes['Contactotelefono'].Text;
      Contactoemail:= Node.ChildNodes['Contactoemail'].Text;
      Dvdomino:= Node.ChildNodes['Dvdomino'].Text;
      DvmarcaID:= Node.ChildNodes['DvmarcaID'].Text;
      Dvmarca:= Node.ChildNodes['Dvmarca'].Text;
      Dvmodelo:= Node.ChildNodes['Dvmodelo'].Text;
      DvmodeloID:= Node.ChildNodes['DvmodeloID'].Text;
      Dftipodocumento:= Node.ChildNodes['Dftipodocumento'].Text;
      Dfnrodocumento:= Node.ChildNodes['Dfnrodocumento'].Text;
      Dfnombre:= Node.ChildNodes['Dfnombre'].Text;
      Dfapellido:= Node.ChildNodes['Dfapellido'].Text;
      Codvehic:= Node.ChildNodes['Codvehic'].Text;
      Ausente:= Node.ChildNodes['Ausente'].Text;
      Facturado:= Node.ChildNodes['Facturado'].Text;
      Reviso:= Node.ChildNodes['Reviso'].Text;
      InformadoWS:= Node.ChildNodes['InformadoWS'].Text;
      Fechalta:= Node.ChildNodes['Fechalta'].Text;
      Tipoinspe:= Node.ChildNodes['Tipoinspe'].Text;
      EstadoID:= Node.ChildNodes['EstadoID'].Text;
      Estadodesc:= Node.ChildNodes['Estadodesc'].Text;
      Fechanovedad:= Node.ChildNodes['Fechanovedad'].Text;
    end;

  end;

IF Node.NodeName = 'Tinspeccion' THEN BEGIN
GUARDARDATOS_TINSPECCION(Planta,Fecha,Ejercici,Codinspe,Codvehic,Codclpro,Codclcon,Codclten,Inspfina,Tipo,Fechalta,Codfrecu,FecVenci,
                        Numoblea,Codfactu,HorFinal,HorentZ1,HorsalZ1,HorentZ2,HorSalZ2,HorentZ3,HorSalZ3,OBSERVAC,Resultad,Waspre,
                        NumrevS1,NumlinS1,NumrevS2,NumlinS2,NumrevS3,NumlinS3,Codservicio,Enviado,Profesional);
CopyFile(PChar('C:\MTOP\XML\'+Archivo_XML),PChar('C:\MTOP\XML\BackUp\Tinspeccion\'+Archivo_XML),false);
DeleteFile(PChar('C:\MTOP\XML\'+Archivo_XML)); END

ELSE IF Node.NodeName = 'Tvehiculos' THEN BEGIN
GUARDARDATOS_TVEHICULOS(Fechamatri,Aniofabr,Codmarca,Codmodel,Tipoespe,Tipodest,Numchasis,AnyoChasis,Numejes,Nummotor,PatenteN,PatenteA,
                        Cola,Largo,Alto,Ancho,Tara,Codpais,Error,Internacional,Tacografo,Codpavehic,CodpadClien,NroRegistro,Codtipocombustible,
                        Codmarcachasis,Codmodelochasis,Tiporegistradoreventos,Codtiposuspension,Fechalta,PesoBruto);
CopyFile(PChar('C:\MTOP\XML\'+Archivo_XML),PChar('C:\MTOP\XML\BackUp\Tvehiculos\'+Archivo_XML),false);
DeleteFile(PChar('C:\MTOP\XML\'+Archivo_XML)); END

ELSE IF Node.NodeName = 'Ejedistancia' THEN BEGIN
GUARDARDATOS_EJEDISTANCIA (Planta,Codinspe,Codvehic,Numejes,Cola,DPE,Numchasis,Disejes12,Disejes23,Disejes34,Disejes45,Disejes56,
                           Numrevis,Fechalta,Disejes67,Disejes78,Disejes89,Alto,Ancho,Largo);
CopyFile(PChar('C:\MTOP\XML\'+Archivo_XML),PChar('C:\MTOP\XML\BackUp\Ejedistancia\'+Archivo_XML),false);
DeleteFile(PChar('C:\MTOP\XML\'+Archivo_XML)); END

ELSE IF Node.NodeName = 'Tdatinspevi' THEN BEGIN
GUARDARDATOS_TDATINSPEVI (Planta,Ejercici,Codinspe,Secudefe,Numrevis,Numlinea,Numzona,Caddefec,Califdef,Ubicadef,OtrosDef,Fechalta);
CopyFile(PChar('C:\MTOP\XML\'+Archivo_XML),PChar('C:\MTOP\XML\BackUp\Tdatinspevi\'+Archivo_XML),false);
DeleteFile(PChar('C:\MTOP\XML\'+Archivo_XML)); END

ELSE IF Node.NodeName = 'Dimensiones_Vehiculos' THEN BEGIN
GUARDARDATOS_DIMENSIONES_VEHICULOS (Planta,Ejercici,Codinspe,Codvehic,Largo,Alto,Ancho,Tara,PesoBruto,Fecha);
CopyFile(PChar('C:\MTOP\XML\'+Archivo_XML),PChar('C:\MTOP\XML\BackUp\Dimensiones_Vehiculos\'+Archivo_XML),false);
DeleteFile(PChar('C:\MTOP\XML\'+Archivo_XML)); END

ELSE IF Node.NodeName = 'Vehicomnibus' THEN BEGIN
GUARDARDATOS_VEHICOMNIBUS (Planta,Codvehic,Cantasientos,Banio,Cantpuertas,Aireacondicionado,Codtiposientos,
                           Codtipobodega,Codcategoriaservicio,Accesibilidad,Codmarcacarroceria,CodTipoServicio,
                           CodTipoSubServicio);
CopyFile(PChar('C:\MTOP\XML\'+Archivo_XML),PChar('C:\MTOP\XML\BackUp\Vehicomnibus\'+Archivo_XML),false);
DeleteFile(PChar('C:\MTOP\XML\'+Archivo_XML)); END

ELSE IF Node.NodeName = 'Tinspdefect' THEN BEGIN
GUARDARDATOS_TINSPDEFECT (Planta,Ejercici,Codinspe,Secdefec,Localiza,Caddefec,Calidef,Valormed,Fechalta);
CopyFile(PChar('C:\MTOP\XML\'+Archivo_XML),PChar('C:\MTOP\XML\BackUp\Tinspdefect\'+Archivo_XML),false);
DeleteFile(PChar('C:\MTOP\XML\'+Archivo_XML)); END

ELSE IF Node.NodeName = 'Vehiccarga' THEN BEGIN
GUARDARDATOS_VEHICCARGA (Planta,Codvehic,Longitudenganche,Codtipocajacarga,Codtipocabina,Codtipocarga,Codtipoaditamento);
CopyFile(PChar('C:\MTOP\XML\'+Archivo_XML),PChar('C:\MTOP\XML\BackUp\Vehiccarga\'+Archivo_XML),false);
DeleteFile(PChar('C:\MTOP\XML\'+Archivo_XML)); END

ELSE IF Node.NodeName = 'TClientes' THEN BEGIN
GUARDARDATOS_TCLIENTES (Planta,Codclien,Tipodocu,Document,TipoclienteID,Fechalta,Nombre,Apellid1,Codparti,Tiptribu,
                        Creditcl,Codposta,Telefono,Apellid2,Localida,Direccio,Nrocalle,Piso,Depto,Idlocalidad,CodArea,
                        Celular,Mail,Idpais,Coddocu,Iddepartamento,Dvdocument,Profesional);
CopyFile(PChar('C:\MTOP\XML\'+Archivo_XML),PChar('C:\MTOP\XML\BackUp\TClientes\'+Archivo_XML),false);
DeleteFile(PChar('C:\MTOP\XML\'+Archivo_XML)); END

ELSE IF Node.NodeName = 'EJERODADOS' THEN BEGIN
GUARDARDATOS_EJERODADO (Planta,Codinspe,Codvehic,Eje,Cantidad,Codtiponeumatico);
CopyFile(PChar('C:\MTOP\XML\'+Archivo_XML),PChar('C:\MTOP\XML\BackUp\Ejerodados\'+Archivo_XML),false);
DeleteFile(PChar('C:\MTOP\XML\'+Archivo_XML)); END

ELSE IF Node.NodeName = 'TFacturas' THEN BEGIN
GUARDARDATOS_TFACTURAS (Planta,Codfactu,Impresa,Fechalta,Tipfactu,Tiptribu,Formpago,Ivainscr,Codclien,
                        Impoiva,Imponeto,Numfactu,codcofac,Importemoneda,Codmoneda,Idcancelacion,Error,Cae,Estado);
CopyFile(PChar('C:\MTOP\XML\'+Archivo_XML),PChar('C:\MTOP\XML\BackUp\TFacturas\'+Archivo_XML),false);
DeleteFile(PChar('C:\MTOP\XML\'+Archivo_XML)); END

ELSE IF Node.NodeName = 'TDatosturno' THEN BEGIN
GUARDARDATOS_TDATOSTURNO (Planta,TurnoID,Tipoturno,Fechaturno,Horaturno,Fecharegistro,Ttulartipodocumento,Titularnombre,Titularapellido,
                          Contactotipodocumento,Contactonombre,Contactoapellido,Contactotelefono,Contactoemail,Dvdomino,DvmarcaID,Dvmarca,
                          Dvmodelo,DvmodeloID,Dftipodocumento,Dfnrodocumento,Dfnombre,Dfapellido,Codvehic,Ausente,Facturado,Reviso,InformadoWS,
                          Fechalta,Tipoinspe,EstadoID,Estadodesc,Fechanovedad);
CopyFile(PChar('C:\MTOP\XML\'+Archivo_XML),PChar('C:\MTOP\XML\BackUp\TDatosturno\'+Archivo_XML),false);
DeleteFile(PChar('C:\MTOP\XML\'+Archivo_XML));
END; 

limpiar_variables;

EXCEPT
on E: Exception do
  BEGIN
     //memo1.Lines.Add('NO SE PUDO LEER EL ARCHIVO....'+Archivo_XML) ;
     //APPLICATION.ProcessMessages;
     GUARDA_LOG(DATETOSTR(DATE)+'-'+TIMETOSTR(TIME)+'NO SE PUDO LEER EL ARCHIVO '+Archivo_XML+' por: ' + E.message)
  END;
END;

END;

function TForm1.limpiar_variables:boolean;
begin

//Globales usados en varias tablas
Planta:=''; Codvehic:=''; Codinspe:=''; Fechalta:='';
Cola:='';   Largo:='';    Alto:='';     Numchasis:='';
Ancho:='';  Tara:='';     Numejes:='';  Codpais:='';
Error:='';  Codfactu:=''; Ejercici:=''; Numrevis:='';
Fecha:='';

//Tinspeccion
Codclpro:=''; Codclcon:=''; Codclten:='';
Inspfina:=''; Tipo:='';     Codfrecu:='';
FecVenci:=''; Numoblea:=''; HorFinal:='';
HorentZ1:=''; HorsalZ1:=''; HorentZ2:=''; HorSalZ2:='';
HorentZ3:=''; HorSalZ3:=''; OBSERVAC:=''; Resultad:='';
Waspre:='';   NumrevS1:=''; NumlinS1:=''; NumrevS2:='';
NumlinS2:=''; NumrevS3:=''; NumlinS3:=''; Codservicio:='';
Enviado:='';

//Tvehiculos
Fechamatri:=''; Aniofabr:=''; Codmarca:='';
Codmodel:='';   Tipoespe:=''; Tipodest:='';
AnyoChasis:=''; Nummotor:=''; PatenteN:='';
PatenteA:='';   Internacional:='';  Tacografo:='';
Codpavehic:=''; NroRegistro:='';    Codtipocombustible:='';
Codmarcachasis:=''; Codmodelochasis:=''; 
Tiporegistradoreventos:=''; Codtiposuspension:='';

//Ejedistancia
DPE:='';  Disejes12:=''; Disejes23:='';  Disejes34:='';
Disejes45:='';  Disejes56:='';  Disejes67:='';
Disejes78:='';  Disejes89:='';

//Tdatinspevi
Secudefe:=''; Numlinea:=''; Numzona:='';
Caddefec:=''; Califdef:=''; OtrosDef:='';
Ubicadef:='';

//Dimensiones_Vehiculos
PesoBruto:='';

//Vehicomnibus
Cantasientos:=''; Banio:='';  Cantpuertas:='';
Aireacondicionado:='';  Codtiposientos:='';
Codtipobodega:='';  Codcategoriaservicio:='';
Accesibilidad:='';  Codmarcacarroceria:='';
CodTipoServicio:='';  CodTipoSubServicio:='';

//Tinspdefect
Secdefec:=''; Localiza:=''; Valormed:='';  Calidef:='';

//Vehiccarga
Longitudenganche:=''; Codtipocajacarga:='';
Codtipocabina:='';    Codtipocarga:='';
Codtipoaditamento:='';

//Tclientes
Tipodocu:=''; Document:=''; TipoclienteID:='';
Nombre:='';   Apellid1:=''; Tiptribu:='';
Creditcl:=''; Telefono:=''; Localida:='';
Direccio:=''; Nrocalle:=''; Depto:='';
Idlocalidad:='';  Mail:=''; Idpais:='';
Iddepartamento:=''; Dvdocument:=''; Profesional:='';
Codparti:='';  Apellid2:=''; CodArea:=''; Celular:='';
Coddocu:='';   Codposta:=''; Piso:='';

//Ejerodado
Eje:='';  Cantidad:=''; Codtiponeumatico:='';

//tfacturas
Impresa:='';  Tipfactu:=''; Formpago:=''; Ivainscr:='';
Impoiva:='';  Imponeto:=''; Numfactu:=''; Importemoneda:='';
Codmoneda:='';  Idcancelacion:='';  Cae:='';  Estado:='';
codcofac:='';

//Tdatosturno
TurnoID:='';  Tipoturno:='';  Fechaturno:=''; Horaturno:='';
Fecharegistro:='';  Ttulartipodocumento:='';  Titularnombre:='';
Titularapellido:='';  Contactotipodocumento:='';  Contactonombre:='';
Contactoapellido:=''; Contactotelefono:=''; Contactoemail:='';
Dvdomino:=''; DvmarcaID:='';  Dvmarca:='';  Dvmodelo:=''; DvmodeloID:='';
Dftipodocumento:='';  Dfnrodocumento:=''; Dfnombre:=''; Dfapellido:='';
Ausente:='';  Facturado:='';  Reviso:=''; InformadoWS:='';
Tipoinspe:='';  EstadoID:=''; Estadodesc:=''; Fechanovedad:='';

end;

Procedure TForm1.GUARDARDATOS_TINSPECCION;
Begin

    with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_INSERTAXML.INSPECCION';
        Prepared := true;
        ParamByName('Planta').Value := TRIM(Planta);
        ParamByName('Fecha').Value := TRIM(Fecha);
        ParamByName('Ejercici').Value := TRIM(Ejercici);
        ParamByName('Codinspe').Value := TRIM(Codinspe);
        ParamByName('Codvehic').Value := TRIM(Codvehic);
        ParamByName('Codclpro').Value := TRIM(Codclpro);
        ParamByName('Codclcon').Value := TRIM(Codclcon);
        ParamByName('Codclten').Value := TRIM(Codclten);
        ParamByName('Inspfina').Value := TRIM(Inspfina);
        ParamByName('Tipo').Value := TRIM(Tipo);
        ParamByName('Fechalta').Value := TRIM(Fechalta);
        ParamByName('Codfrecu').Value := TRIM(Codfrecu);
        ParamByName('FecVenci').Value := TRIM(FecVenci);
        ParamByName('Numoblea').Value := TRIM(Numoblea);
        ParamByName('Codfactu').Value := TRIM(Codfactu);
        ParamByName('HorFinal').Value := TRIM(HorFinal);
        ParamByName('HorentZ1').Value := TRIM(HorentZ1);
        ParamByName('HorsalZ1').Value := TRIM(HorsalZ1);
        ParamByName('HorentZ2').Value := TRIM(HorentZ2);
        ParamByName('HorSalZ2').Value := TRIM(HorSalZ2);
        ParamByName('HorentZ3').Value := TRIM(HorentZ3);
        ParamByName('OBSERVAC').Value := TRIM(OBSERVAC);
        ParamByName('Resultado').Value := TRIM(Resultad);
        ParamByName('Waspre').Value := TRIM(Waspre);
        ParamByName('NumrevS1').Value := TRIM(NumrevS1);
        ParamByName('NumlinS1').Value := TRIM(NumlinS1);
        ParamByName('NumrevS2').Value := TRIM(NumrevS2);
        ParamByName('NumlinS2').Value := TRIM(NumlinS2);
        ParamByName('NumrevS3').Value := TRIM(NumrevS3);
        ParamByName('NumlinS3').Value := TRIM(NumlinS3);
        ParamByName('Codservicio').Value := TRIM(Codservicio);
        ParamByName('Enviado').Value := TRIM(Enviado);
        ParamByName('Profesional').Value := TRIM(Profesional);
        ExecProc;
        Close;
    finally
      Free;
    end;
End;

Procedure TForm1.GUARDARDATOS_TVEHICULOS;
Begin

    with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_INSERTAXML.VEHICULOS';
        Prepared := true;
        ParamByName('Planta').Value := TRIM(Planta);
        ParamByName('Codvehic').Value := TRIM(Codvehic);
        ParamByName('Fechamatri').Value := TRIM(Fechamatri);
        ParamByName('Aniofabr').Value := TRIM(Aniofabr);
        ParamByName('Codmarca').Value := TRIM(Codmarca);
        ParamByName('Codmodel').Value := TRIM(Codmodel);
        ParamByName('Tipoespe').Value := TRIM(Tipoespe);
        ParamByName('Tipodest').Value := TRIM(Tipodest);
        ParamByName('Numchasis').Value := TRIM(Numchasis);
        ParamByName('AnyoChasis').Value := TRIM(AnyoChasis);
        ParamByName('Numejes').Value := TRIM(Numejes);
        ParamByName('Nummotor').Value := TRIM(Nummotor);
        ParamByName('PatenteN').Value := TRIM(PatenteN);
        ParamByName('PatenteA').Value := TRIM(PatenteA);
        ParamByName('Cola').Value := TRIM(Cola);
        ParamByName('Largo').Value := TRIM(Largo);
        ParamByName('Alto').Value := TRIM(Alto);
        ParamByName('Ancho').Value := TRIM(Ancho);
        ParamByName('Tara').Value := TRIM(Tara);
        ParamByName('Codpais').Value := TRIM(Codpais);
        ParamByName('Error').Value := TRIM(Error);
        ParamByName('Internacional').Value := TRIM(Internacional);
        ParamByName('Tacografo').Value := TRIM(Tacografo);
        ParamByName('Codpavehic').Value := TRIM(Codpavehic);
        ParamByName('CodpadClien').Value := TRIM(CodpadClien);
        ParamByName('NroRegistro').Value := TRIM(NroRegistro);
        ParamByName('Codtipocombustible').Value := TRIM(Codtipocombustible);
        ParamByName('Codmarcachasis').Value := TRIM(Codmarcachasis);
        ParamByName('Codmodelochasis').Value := TRIM(Codmodelochasis);
        ParamByName('Tiporegistradoreventos').Value := TRIM(Tiporegistradoreventos);
        ParamByName('Codtiposuspension').Value := TRIM(Codtiposuspension);
        ParamByName('Fechalta').Value := TRIM(Fechalta);
        ParamByName('Pesobruto').Value := TRIM(PesoBruto);
        ExecProc;
        Close;
    finally
      Free;
    end;
End;

PROCEDURE TForm1.GUARDARDATOS_EJEDISTANCIA;

Begin

    with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_INSERTAXML.EJEDISTANCIA';
        Prepared := true;
        ParamByName('Planta').Value := TRIM(Planta);
        ParamByName('Codinspe').Value := TRIM(Codinspe);
        ParamByName('Codvehic').Value := TRIM(Codvehic);
        ParamByName('Numejes').Value := TRIM(Numejes);
        ParamByName('Cola').Value := TRIM(Cola);
        ParamByName('DPE').Value := TRIM(DPE);
        ParamByName('Numchasis').Value := TRIM(Numchasis);
        ParamByName('Disejes12').Value := TRIM(Disejes12);
        ParamByName('Disejes23').Value := TRIM(Disejes23);
        ParamByName('Disejes34').Value := TRIM(Disejes34);
        ParamByName('Disejes45').Value := TRIM(Disejes45);
        ParamByName('Disejes56').Value := TRIM(Disejes56);
        ParamByName('Numrevis').Value := TRIM(Numrevis);
        ParamByName('Fechalta').Value := TRIM(Fechalta);
        ParamByName('Disejes67').Value := TRIM(Disejes67);
        ParamByName('Disejes78').Value := TRIM(Disejes78);
        ParamByName('Disejes89').Value := TRIM(Disejes89);
        ParamByName('Alto').Value := TRIM(Alto);
        ParamByName('Ancho').Value := TRIM(Ancho);
        ParamByName('Largo').Value := TRIM(Largo);
        ExecProc;
        Close;
    finally
     Free;
    end;
End;

PROCEDURE TForm1.GUARDARDATOS_TDATINSPEVI;

Begin

    with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_INSERTAXML.DATINSPEVI';
        Prepared := true;
        ParamByName('Planta').Value := TRIM(Planta);
        ParamByName('Ejercici').Value := TRIM(Ejercici);
        ParamByName('Codinspe').Value := TRIM(Codinspe);
        ParamByName('Secudefe').Value := TRIM(Secudefe);
        ParamByName('Numrevis').Value := TRIM(Numrevis);
        ParamByName('Numlinea').Value := TRIM(Numlinea);
        ParamByName('Numzona').Value := TRIM(Numzona);
        ParamByName('Caddefec').Value := TRIM(Caddefec);
        ParamByName('Califdef').Value := TRIM(Califdef);
        ParamByName('Ubicadef').Value := TRIM(Ubicadef);
        ParamByName('OtrosDef').Value := TRIM(OtrosDef);
        ParamByName('Fechalta').Value := TRIM(Fechalta);
        ExecProc;
        Close;
    finally
     Free;
    end;
End;

PROCEDURE TForm1.GUARDARDATOS_DIMENSIONES_VEHICULOS;

Begin

    with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_INSERTAXML.DIMENSIONESVEHICULOS';
        Prepared := true;
        ParamByName('Planta').Value := TRIM(Planta);
        ParamByName('Ejercici').Value := TRIM(Ejercici);
        ParamByName('Codinspe').Value := TRIM(Codinspe);
        ParamByName('Codvehic').Value := TRIM(Codvehic);
        ParamByName('Largo').Value := TRIM(Largo);
        ParamByName('Alto').Value := TRIM(Alto);
        ParamByName('Ancho').Value := TRIM(Ancho);
        ParamByName('Tara').Value := TRIM(Tara);
        ParamByName('PesoBruto').Value := TRIM(PesoBruto);
        ParamByName('Fecha').Value := TRIM(Fecha);
        ExecProc;
        Close;
    finally
     Free;
    end;
End;


PROCEDURE TForm1.GUARDARDATOS_VEHICOMNIBUS;

Begin

    with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_INSERTAXML.VEHICOMNIBUS';
        Prepared := true;
        ParamByName('Planta').Value := TRIM(Planta);
        ParamByName('Codvehic').Value := TRIM(Codvehic);
        ParamByName('Cantasientos').Value := TRIM(Cantasientos);
        ParamByName('Banio').Value := TRIM(Banio);
        ParamByName('Cantpuertas').Value := TRIM(Cantpuertas);
        ParamByName('Aireacondicionado').Value := TRIM(Aireacondicionado);
        ParamByName('Codtiposientos').Value := TRIM(Codtiposientos);
        ParamByName('Codtipobodega').Value := TRIM(Codtipobodega);
        ParamByName('Codcategoriaservicio').Value := TRIM(Codcategoriaservicio);
        ParamByName('Accesibilidad').Value := TRIM(Accesibilidad);
        ParamByName('Codmarcacarroceria').Value := TRIM(Codmarcacarroceria);
        ExecProc;
        Close;
    finally
     Free;
    end;
End;

PROCEDURE TForm1.GUARDARDATOS_TINSPDEFECT;

Begin

    with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_INSERTAXML.TINSPDEFECT';
        Prepared := true;
        ParamByName('Planta').Value := TRIM(Planta);
        ParamByName('Ejercici').Value := TRIM(Ejercici);
        ParamByName('Codinspe').Value := TRIM(Codinspe);
        ParamByName('Secdefec').Value := TRIM(Secdefec);
        ParamByName('Localiza').Value := TRIM(Localiza);
        ParamByName('Caddefec').Value := TRIM(Caddefec);
        ParamByName('Calidef').Value := TRIM(Calidef);
        ParamByName('Valormed').Value := TRIM(Valormed);
        ParamByName('Fechalta').Value := TRIM(Fechalta);
        ExecProc;
        Close;
    finally
     Free;
    end;
End;


PROCEDURE TForm1.GUARDARDATOS_VEHICCARGA;

Begin

    with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_INSERTAXML.VEHICCARGA';
        Prepared := true;
        ParamByName('Planta').Value := TRIM(Planta);
        ParamByName('Codvehic').Value := TRIM(Codvehic);
        ParamByName('Longitudenganche').Value := TRIM(Longitudenganche);
        ParamByName('Codtipocajacarga').Value := TRIM(Codtipocajacarga);
        ParamByName('Codtipocabina').Value := TRIM(Codtipocabina);
        ParamByName('Codtipocarga').Value := TRIM(Codtipocarga);
        ParamByName('Codtipoaditamento').Value := TRIM(Codtipoaditamento);
        ExecProc;
        Close;
    finally
     Free;
    end;
End;

PROCEDURE TForm1.GUARDARDATOS_TCLIENTES;

Begin

    with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_INSERTAXML.TCLIENTES';
        Prepared := true;
        ParamByName('Planta').Value := TRIM(Planta);
        ParamByName('Codclien').Value := TRIM(Codclien);
        ParamByName('Tipodocu').Value := TRIM(Tipodocu);
        ParamByName('Document').Value := TRIM(Document);
        ParamByName('TipoclienteID').Value := TRIM(TipoclienteID);
        ParamByName('Fechalta').Value := TRIM(Fechalta);
        ParamByName('Nombre').Value := TRIM(Nombre);
        ParamByName('Apellid1').Value := TRIM(Apellid1);
        ParamByName('Codparti').Value := TRIM(Codparti);
        ParamByName('Tiptribu').Value := TRIM(Tiptribu);
        ParamByName('Creditcl').Value := TRIM(Creditcl);
        ParamByName('Codposta').Value := TRIM(Codposta);
        ParamByName('Telefono').Value := TRIM(Telefono);
        ParamByName('Apellid2').Value := TRIM(Apellid2);
        ParamByName('Localida').Value := TRIM(Localida);
        ParamByName('Direccio').Value := TRIM(Direccio);
        ParamByName('Nrocalle').Value := TRIM(Nrocalle);
        ParamByName('Piso').Value := TRIM(Piso);
        ParamByName('Depto').Value := TRIM(Depto);
        ParamByName('Idlocalidad').Value := TRIM(Idlocalidad);
        ParamByName('CodArea').Value := TRIM(CodArea);
        ParamByName('Celular').Value := TRIM(Celular);
        ParamByName('Mail').Value := TRIM(Mail);
        ParamByName('Idpais').Value := TRIM(Idpais);
        ParamByName('Coddocu').Value := TRIM(Coddocu);
        ParamByName('Iddepartamento').Value := TRIM(Iddepartamento);
        ParamByName('Dvdocument').Value := TRIM(Dvdocument);
        ParamByName('Profesional').Value := TRIM(Profesional);
        ExecProc;
        Close;
    finally
     Free;
    end;
End;

PROCEDURE TForm1.GUARDARDATOS_EJERODADO;

Begin

    with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_INSERTAXML.EJERODADO';
        Prepared := true;
        ParamByName('Planta').Value := TRIM(Planta);
        ParamByName('Codinspe').Value := TRIM(Codinspe);
        ParamByName('Codvehic').Value := TRIM(Codvehic);
        ParamByName('Eje').Value := TRIM(Eje);
        ParamByName('Cantidad').Value := TRIM(Cantidad);
        ParamByName('Codtiponeumatico').Value := TRIM(Codtiponeumatico);
        ExecProc;
        Close;
    finally
     Free;
    end;
End;

PROCEDURE TForm1.GUARDARDATOS_TFACTURAS;

Begin

    with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_INSERTAXML.TFACTURAS';
        Prepared := true;
        ParamByName('Planta').Value := TRIM(Planta);
        ParamByName('Codfactu').Value := TRIM(Codfactu);
        ParamByName('Impresa').Value := TRIM(Impresa);
        ParamByName('Fechalta').Value := TRIM(Fechalta);
        ParamByName('Tipfactu').Value := TRIM(Tipfactu);
        ParamByName('Tiptribu').Value := TRIM(Tiptribu);
        ParamByName('Formpago').Value := TRIM(Formpago);
        ParamByName('Ivainscr').Value := TRIM(Ivainscr);
        ParamByName('Codclien').Value := TRIM(Codclien);
        ParamByName('Impoiva').Value := TRIM(Impoiva);
        ParamByName('Imponeto').Value := TRIM(Imponeto);
        ParamByName('Numfactu').Value := TRIM(Numfactu);
        ParamByName('codcofac').Value := TRIM(codcofac);
        ParamByName('Importemoneda').Value := TRIM(Importemoneda);
        ParamByName('Codmoneda').Value := TRIM(Codmoneda);
        ParamByName('Idcancelacion').Value := TRIM(Idcancelacion);
        ParamByName('Error').Value := TRIM(Error);
        ParamByName('Cae').Value := TRIM(Cae);
        ParamByName('Estado').Value := TRIM(Estado);
        ExecProc;
        Close;
    finally
     Free;
    end;
End;

PROCEDURE TForm1.GUARDARDATOS_TDATOSTURNO;

Begin

    with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_INSERTAXML.TDATOSTURNO';
        Prepared := true;
        ParamByName('Planta').Value := TRIM(Planta);
        ParamByName('TurnoID').Value := TRIM(TurnoID);
        ParamByName('Tipoturno').Value := TRIM(Tipoturno);
        ParamByName('Fechaturno').Value := TRIM(Fechaturno);
        ParamByName('Horaturno').Value := TRIM(Horaturno);
        ParamByName('Fecharegistro').Value := TRIM(Fecharegistro);
        ParamByName('Ttulartipodocumento').Value := TRIM(Ttulartipodocumento);
        ParamByName('Titularnombre').Value := TRIM(Titularnombre);
        ParamByName('Titularapellido').Value := TRIM(Titularapellido);
        ParamByName('Contactotipodocumento').Value := TRIM(Contactotipodocumento);
        ParamByName('Contactonombre').Value := TRIM(Contactonombre);
        ParamByName('Contactoapellido').Value := TRIM(Contactoapellido);
        ParamByName('Contactotelefono').Value := TRIM(Contactotelefono);
        ParamByName('Contactoemail').Value := TRIM(Contactoemail);
        ParamByName('Dvdomino').Value := TRIM(Dvdomino);
        ParamByName('DvmarcaID').Value := TRIM(DvmarcaID);
        ParamByName('Dvmarca').Value := TRIM(Dvmarca);
        ParamByName('Dvmodelo').Value := TRIM(Dvmodelo);
        ParamByName('DvmodeloID').Value := TRIM(DvmodeloID);
        ParamByName('Dftipodocumento').Value := TRIM(Dftipodocumento);
        ParamByName('Dfnrodocumento').Value := TRIM(Dfnrodocumento);
        ParamByName('Dfnombre').Value := TRIM(Dfnombre);
        ParamByName('Dfapellido').Value := TRIM(Dfapellido);
        ParamByName('Codvehic').Value := TRIM(Codvehic);
        ParamByName('Ausente').Value := TRIM(Ausente);
        ParamByName('Facturado').Value := TRIM(Facturado);
        ParamByName('Reviso').Value := TRIM(Reviso);
        ParamByName('InformadoWS').Value := TRIM(InformadoWS);
        ParamByName('Fechalta').Value := TRIM(Fechalta);
        ParamByName('Tipoinspe').Value := TRIM(Tipoinspe);
        ParamByName('EstadoID').Value := TRIM(EstadoID);
        ParamByName('Estadodesc').Value := TRIM(Estadodesc);
        ParamByName('Fechanovedad').Value := TRIM(Fechanovedad);
        ExecProc;
        Close;
    finally
     Free;
    end;
End;

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
 MYBD.Close;
 SELF.EJECUTAR;
 timer1.Interval:=5000; //5 segundos
 timer1.Enabled:=true;
//END;
MEMO1.Clear;
MEMO1.Lines.Add('EXPORTACION ...');
RxTrayIcon1.HiNT:='INICIADO....';
APPLICATION.ProcessMessages;
//MYBD.Close;
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

procedure TForm1.Button2Click(Sender: TObject);
begin
 DoListadoMergeTurnos;
end;

END.
