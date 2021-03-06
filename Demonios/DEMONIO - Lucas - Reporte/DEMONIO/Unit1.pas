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
    PROCEDURE TestOfBD(Alias, UserName, Password: String; Ageva: boolean);
    FUNCTION conexion_virtual(base:string):boolean;
    FUNCTION ENVIAR_FACT_A_MSSQL(CODFACTU:longint;plantapasa:longint):BOOLEAN;
    FUNCTION ENVIAR_FACTADI_A_MSSQL(CODFACTU_ADI:longint;plantapasa:longint):BOOLEAN;
    FUNCTION ENVIAR_NC_A_MSSQL(NC:longint;plantapasa:longint):BOOLEAN;
    FUNCTION ENVIAR_TURNO_A_MSSQL(turno:longint;plantapasa:longint):BOOLEAN;
    FUNCTION ENVIAR_INSPECCION_A_MSSQL(CODINSPE:longint;plantapasa:longint):BOOLEAN;
    FUNCTION ENVIAR_CLIENTE_A_MSSQL(CODCLIEN:longint;plantapasa:longint):BOOLEAN;
    FUNCTION ENVIAR_VEHICULO_A_MSSQL(CODVEHIC:longint;plantapasa:longint):BOOLEAN;
    FUNCTION GUARDA_LOG(MENSAJE:STRING):BOOLEAN;
    PROCEDURE SHRINK_LOG;
    PROCEDURE EJECUTAR;
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
link:= ExtractFilePath( Application.ExeName ) + ARCHIVO_LOG;
assignfile(LOG,link);

if fileexists(link)=false then
rewrite(LOG);
 append(LOG);
 WRITELN(LOG,MENSAJE);
 CLOSEFILE(LOG);
END;

PROCEDURE TForm1.SHRINK_LOG;
BEGIN
       {SHRINK LOG}
        modulo.CONEXION.BeginTrans;
          TRY
             MEMO1.Lines.Add('MASTERDB SHRINK LOG');
             RxTrayIcon1.HiNT:='MASTERDB SHRINK LOG';
             APPLICATION.ProcessMessages;
             modulo.QUERY_WEB.Close;
             modulo.QUERY_WEB.SQL.Clear;
             modulo.QUERY_WEB.SQL.Add('DBCC SHRINKFILE (MASTERDB_Log, 1)');
             modulo.QUERY_WEB.ExecSQL;
             modulo.CONEXION.CommitTrans;
             MEMO1.Lines.Add('MASTERDB SHRINK LOG OK');
             APPLICATION.ProcessMessages;

           EXCEPT
             on E: Exception do
                      BEGIN
                         MEMO1.Lines.Add('MASTERDB SHRINK LOG: ERROR');
                         APPLICATION.ProcessMessages;
                         modulo.CONEXION.RollbackTrans;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| MASTERDB SHRINK LOG NO SE PUDO REALIZAR POR :'+ E.message);
                      END;
           END;
END;

procedure TForm1.EJECUTAR;
VAR
BASE,alias,userbd,password,link,FE:STRING;
archivo,LOG:textfile;
TURNOID,CODINSPE,CODFACTU,CODCLIEN,
CODFACTU_ADI,NC,CODVEHIC,planta:longint;

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
     userbd:=ALIAS;//'CABASM';
     password:='02lusabaqui03';
     TestOfBD(alias,userbd,password,false);

     if se_conector=true then

      BEGIN
        form1.Caption:='CONECTADO A '+ ALIAS;
        memo1.Lines.Add('CONECTADO A: '+ ALIAS);
        FORM1.HiNT:='CONECTADO A '+ ALIAS;
        RxTrayIcon1.HiNT:='CONECTADO A '+ ALIAS;
        APPLICATION.ProcessMessages;

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

       IF planta = 31 THEN BEGIN planta:=2; END;
       IF planta = 41 THEN BEGIN planta:=3; END;

       ////{Busco turnos para CABA}
       IF (planta = 2) or (planta = 3) THEN BEGIN

        {Busco el ultimo Turno}
         modulo.QUERY_WEB.Close;
         modulo.QUERY_WEB.SQL.Clear;
         modulo.QUERY_WEB.SQL.Add('SELECT MAX(TURNOID) FROM TDATOSTURNO WHERE PLANTA='+inttostr(planta));
         modulo.QUERY_WEB.ExecSQL;
         modulo.QUERY_WEB.open;
         TURNOID:=modulo.QUERY_WEB.Fields[0].AsInteger;

        ENVIAR_TURNO_A_MSSQL(TURNOID,Planta);
        {relativamente ok, trae menos debido al filtro.
         Esto se debe a turnosid repetidos, la base de prueba es vieja.}

       END;
       ////{FIN turnos para CABA}
       
        {Busco la ultima inspeccion}
        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;
        modulo.QUERY_WEB.SQL.Add('SELECT CASE WHEN MAX(CODINSPE) IS NULL THEN 0 ELSE  MAX(CODINSPE) END '+
                                 'FROM TINSPECCION TINS '+
                                 'WHERE TINS.PLANTA='+inttostr(planta));
        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.open;
        CODINSPE:=modulo.QUERY_WEB.Fields[0].AsInteger;

        {Busco la ultima factura}
        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;
        modulo.QUERY_WEB.SQL.Add('SELECT MAX(TFAC.CODFACTU) FROM TFACTURAS TFAC '+
                                 ' WHERE TFAC.PLANTA='+inttostr(Planta));
        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.open;
        CODFACTU:=modulo.QUERY_WEB.Fields[0].AsInteger;

        {Busco el ultimo Cliente}
        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;
        modulo.QUERY_WEB.SQL.Add('SELECT MAX(TCLI.CODCLIEN) FROM TCLIENTES TCLI '+
                                 ' WHERE TCLI.PLANTA='+inttostr(Planta));
        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.open;
        CODCLIEN:=modulo.QUERY_WEB.Fields[0].AsInteger;

        {Busco el ultimo Vehiculo}
        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;
        modulo.QUERY_WEB.SQL.Add('SELECT MAX(TVE.CODVEHIC) FROM TVEHICULOS TVE '+
                                 ' WHERE TVE.PLANTA='+inttostr(Planta));
        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.open;
        CODVEHIC:=modulo.QUERY_WEB.Fields[0].AsInteger;

        {Busco la ultima factura ADICION}
        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;
        modulo.QUERY_WEB.SQL.Add('SELECT MAX(ADI.CODFACT) FROM TFACT_ADICION ADI '+
                                 'WHERE ADI.PTOVENT='+inttostr(Planta));
        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.open;
        CODFACTU_ADI:=modulo.QUERY_WEB.Fields[0].AsInteger;

        {Busco la ultima NC}
        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;
        modulo.QUERY_WEB.SQL.Add('SELECT MAX(CODCOFAC) FROM TCONTRAFACT WHERE PLANTA ='+inttostr(Planta));
        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.open;
        NC:=modulo.QUERY_WEB.Fields[0].AsInteger;

        {Envia variables a Funciones}
        //ENVIAR_FACT_A_MSSQL(CODFACTU,Planta); //OK
        //ENVIAR_FACTADI_A_MSSQL(CODFACTU_ADI,Planta); //Relativamente OK
        //ENVIAR_NC_A_MSSQL(NC,Planta); //OK
        //ENVIAR_INSPECCION_A_MSSQL(CODINSPE,Planta); //OK
        ENVIAR_CLIENTE_A_MSSQL(CODCLIEN,Planta); //OK
        ENVIAR_VEHICULO_A_MSSQL(CODVEHIC,Planta);
        END else
        begin

        end;

   mybd.Close;
end;

modulo.conexion.Close;

END;

end;

FUNCTION TFORM1.ENVIAR_FACT_A_MSSQL(CODFACTU:longint;plantapasa:longint):BOOLEAN;
var
QUERY_MSSQL:string;

CODCLIEN,NUMFACTU,Existe
{,codfact,PTOVENT,IDUSUARI}:longint;
FECHAFAC,TIPOFACTU,TIPTRIBU,FORMPAGO,IVA,IMPORTE,
IDDETALLESPAGO,CODCOFAC{,TIPOFAC}:STRING;

BEGIN

{Busco facturas nuevas}
with tsqlQuery.Create(nil) do
    try
        SQLConnection:= MYBD;
        SQL.Add('SELECT DISTINCT '+
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
                //',ADI.codfact AS codfact '+
                //',ADI.TIPOFAC AS TIPOFAC '+
                //',ADI.PTOVENT AS PTOVENT '+
                //',ADI.IDUSUARI AS IDUSUARI '+
                'FROM TFACTURAS TFAC '+
                //INNER JOIN TFACT_ADICION ADI '+
                //'ON TFAC.CODFACTU = ADI.CODFACT '+
                'WHERE TFAC.CODFACTU >' +inttostr(CODFACTU)+
                //'  AND to_char(TFAC.fechalta,''yyyy'') = 2016 '+
                //'  AND ADI.PTOVENT =' +inttostr(plantapasa)+
                ' ORDER BY TFAC.CODFACTU');
        Open;

        WHILE NOT EOF DO

        BEGIN
        {Tfacturas}
        CODFACTU:=FIELDBYNAME('CODFACTU').ASINTEGER;
        FECHAFAC:=TRIM(FIELDBYNAME('fechalta').ASSTRING);
        TIPOFACTU:=TRIM(FIELDBYNAME('tipofactu').ASSTRING);
        TIPTRIBU:=TRIM(FIELDBYNAME('tiptribu').ASSTRING);
        FORMPAGO:=TRIM(FIELDBYNAME('formpago').ASSTRING);
        IVA:=TRIM(FIELDBYNAME('ivainscr').ASSTRING);
        CODCLIEN:=FIELDBYNAME('codclien').ASINTEGER;
        IMPORTE:=TRIM(FIELDBYNAME('imponeto').ASSTRING);
        NUMFACTU:=FIELDBYNAME('numfactu').ASINTEGER;
        CODCOFAC:=TRIM(FIELDBYNAME('codcofac').ASSTRING);
        IDDETALLESPAGO:=TRIM(FIELDBYNAME('iddetallespago').ASSTRING);

        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;
        modulo.QUERY_WEB.SQL.Add('SELECT COUNT(*) FROM TFACTURAS TFAC '+
                                 'WHERE TFAC.CODFACTU = '+inttostr(CODFACTU)+
                                 '  AND TFAC.PLANTA = '+inttostr(plantapasa));
        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.Open;
        Existe:=modulo.QUERY_WEB.Fields[0].AsInteger;

        IF (Existe = 0) THEN
          BEGIN
                QUERY_MSSQL:='INSERT INTO TFACTURAS (codfactu,fechalta,tipfactu,tiptribu,'+
                             'formpago,ivainscr,codclien,imponeto,numfactu,codcofac,iddetallespago, PLANTA) '+
                             ' VALUES ('+
                             ' '+INTTOSTR(CODFACTU)+' '+
                             ','+#39+TRIM(FECHAFAC)+#39+' '+
                             ','+#39+TRIM(TIPOFACTU)+#39+' '+
                             ','+#39+TRIM(TIPTRIBU)+#39+' '+
                             ','+#39+TRIM(FORMPAGO)+#39+' '+
                             ','+#39+TRIM(IVA)+#39+' '+
                             ','+INTTOSTR(CODCLIEN)+' '+
                             ','+#39+TRIM(IMPORTE)+#39+' '+
                             ','+INTTOSTR(NUMFACTU)+' '+
                             ','+#39+TRIM(CODCOFAC)+#39+' '+
                             ','+#39+TRIM(IDDETALLESPAGO)+#39+' '+
                             ','+INTTOSTR(plantapasa)+' '+
                             ')';

          //END ELSE BEGIN END;

          IF (Existe = 0) THEN
             modulo.CONEXION.BeginTrans;
               TRY
                MEMO1.Lines.Add('IMPORTANDO FAC: '+INTTOSTR(CODFACTU));
                RxTrayIcon1.HiNT:='IMPORTANDO FAC: '+INTTOSTR(CODFACTU);
                APPLICATION.ProcessMessages;
                modulo.QUERY_WEB.Close;
                modulo.QUERY_WEB.SQL.Clear;
                modulo.QUERY_WEB.SQL.Add(QUERY_MSSQL);
                //modulo.QUERY_WEB.SQL.Add(QUERY_MSSQL2);
                modulo.QUERY_WEB.ExecSQL;
                modulo.CONEXION.CommitTrans;
                //MEMO1.Lines.Add('TRANSACCION: OK');
                //APPLICATION.ProcessMessages;

           EXCEPT
             on E: Exception do
                      BEGIN
                         MEMO1.Lines.Add('TRANSACCION: ERROR');
                         APPLICATION.ProcessMessages;
                         modulo.CONEXION.RollbackTrans;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| PLANTA '+INTTOSTR(plantapasa)+' NO SE INSERTO FACTURA '+INTTOSTR(CODFACTU)+' POR :'+ E.message);
                      END;
           END;

         END ELSE
           BEGIN
               MEMO1.Lines.Add('Ya existe FAC: '+INTTOSTR(CODFACTU));
               RxTrayIcon1.HiNT:='Ya existe FAC: '+INTTOSTR(CODFACTU);
               APPLICATION.ProcessMessages;
               modulo.QUERY_WEB.Close;
               modulo.QUERY_WEB.SQL.Clear;
           END;
           //END;
        NEXT;

       END;

  finally
        Close;
        Free;
  end;

 //Application.MessageBox( 'PROCESO TERMINADO.', 'Atenci�n', MB_ICONINFORMATION );
 SHRINK_LOG;
END;

FUNCTION TFORM1.ENVIAR_FACTADI_A_MSSQL(CODFACTU_ADI:longint;plantapasa:longint):BOOLEAN;
var
TIPOFAC,QUERY_MSSQL:STRING;

PTOVENT,IDUSUARI,CODFACT,Existe:longint;

BEGIN

{Busco facturas nuevas}
with tsqlQuery.Create(nil) do
    try
        SQLConnection:= MYBD;
        SQL.Add('SELECT DISTINCT '+
                'ADI.codfact AS CODFACT '+
                ',ADI.TIPOFAC AS TIPOFAC '+
                ',ADI.PTOVENT AS PTOVENT '+
                ',ADI.IDUSUARI AS IDUSUARI '+
                'FROM TFACT_ADICION ADI '+
                'WHERE ADI.CODFACT > '+inttostr(CODFACTU_ADI)+
                ' ORDER BY ADI.CODFACT');
        Open;

        WHILE NOT EOF DO

        BEGIN
        {Tfact_Adicion}
        CODFACT:=FIELDBYNAME('CODFACT').ASINTEGER;
        TIPOFAC:=TRIM(FIELDBYNAME('TIPOFAC').ASSTRING);
        PTOVENT:=FIELDBYNAME('PTOVENT').ASINTEGER;
        IDUSUARI:=FIELDBYNAME('IDUSUARI').ASINTEGER;

        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;
        modulo.QUERY_WEB.SQL.Add('SELECT COUNT(*) FROM TFACT_ADICION ADI '+
                                 'WHERE ADI.CODFACT = '+inttostr(CODFACT)+
                                 '  AND ADI.PTOVENT = '+inttostr(plantapasa)+
                                 '  AND ADI.PLANTA = '+inttostr(plantapasa)+
                                 '  AND ADI.TIPOFAC = '+#39+TRIM(TIPOFAC)+#39);
        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.Open;
        Existe:=modulo.QUERY_WEB.Fields[0].AsInteger;

        IF (Existe = 0) THEN
          BEGIN
                 QUERY_MSSQL:='INSERT INTO TFACT_ADICION (codfact,TIPOFAC,ptovent,idusuari,PLANTA) '+
                              ' VALUES ('+
                              ' '+INTTOSTR(CODFACT)+' '+
                              ','+#39+TRIM(TIPOFAC)+#39+' '+
                              ','+INTTOSTR(ptovent)+' '+
                              ','+INTTOSTR(idusuari)+' '+
                              ','+INTTOSTR(plantapasa)+' '+
                              ')';

          //END ELSE BEGIN END;

          IF (Existe = 0) THEN
             modulo.CONEXION.BeginTrans;
               TRY
                MEMO1.Lines.Add('IMPORTANDO FAC ADI: '+INTTOSTR(CODFACT));
                RxTrayIcon1.HiNT:='IMPORTANDO FAC ADI: '+INTTOSTR(CODFACT);
                APPLICATION.ProcessMessages;
                modulo.QUERY_WEB.Close;
                modulo.QUERY_WEB.SQL.Clear;
                modulo.QUERY_WEB.SQL.Add(QUERY_MSSQL);
                modulo.QUERY_WEB.ExecSQL;
                modulo.CONEXION.CommitTrans;
                //MEMO1.Lines.Add('TRANSACCION: OK');
                //APPLICATION.ProcessMessages;

           EXCEPT
             on E: Exception do
                      BEGIN
                         MEMO1.Lines.Add('TRANSACCION: ERROR');
                         APPLICATION.ProcessMessages;
                         modulo.CONEXION.RollbackTrans;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| PLANTA '+INTTOSTR(plantapasa)+' NO SE INSERTO FACTURA '+INTTOSTR(CODFACT)+' POR :'+ E.message);
                      END;
           END;

         END ELSE
           BEGIN
               MEMO1.Lines.Add('Ya existe FAC ADI: '+INTTOSTR(CODFACT));
               RxTrayIcon1.HiNT:='Ya existe FAC ADI: '+INTTOSTR(CODFACT);
               APPLICATION.ProcessMessages;
               modulo.QUERY_WEB.Close;
               modulo.QUERY_WEB.SQL.Clear;
           END;
           //END;
        NEXT;

       END;

  finally
        Close;
        Free;
  end;

 //Application.MessageBox( 'PROCESO TERMINADO.', 'Atenci�n', MB_ICONINFORMATION );
 SHRINK_LOG;
END;

FUNCTION TFORM1.ENVIAR_NC_A_MSSQL(NC:longint;plantapasa:longint):BOOLEAN;
var
QUERY_MSSQL:string;

CodCoFacNC,NumNC,Existe:longint;
FECHANC,CaeNC,VenceCaeNc:string;

BEGIN
{Busco NC nuevas}
with tsqlQuery.Create(nil) do
    try
        SQLConnection:= MYBD;
        SQL.Add('SELECT DISTINCT '+
                'TCON.CODCOFAC as CodCoFacNC '+
                ',TCON.fechalta as FECHANC '+
                ',TCON.numfactu as NumNC '+
                ',TCON.CAE as CaeNC '+
                ',TCON.FECHAVENCE as VenceCaeNc '+
                'FROM TCONTRAFACT TCON '+
                'WHERE CODCOFAC >' +inttostr(NC)+
                ' ORDER BY fechalta');
        Open;

        WHILE NOT EOF DO

        BEGIN

        {TcontraFac}
        CodCoFacNC:=FIELDBYNAME('CodCoFacNC').ASINTEGER;
        FECHANC:=TRIM(FIELDBYNAME('FECHANC').ASSTRING);
        NumNC:=FIELDBYNAME('NumNC').ASINTEGER;
        CaeNC:=TRIM(FIELDBYNAME('CaeNC').ASSTRING);
        VenceCaeNc:=TRIM(FIELDBYNAME('VenceCaeNc').ASSTRING);

         modulo.QUERY_WEB.Close;
         modulo.QUERY_WEB.SQL.Clear;
         modulo.QUERY_WEB.SQL.Add('SELECT COUNT(*) FROM TCONTRAFACT WHERE CODCOFAC='+inttostr(CodCoFacNC)+
                                  ' AND PLANTA ='+inttostr(plantapasa));
         modulo.QUERY_WEB.ExecSQL;
         modulo.QUERY_WEB.Open;
         Existe:=modulo.QUERY_WEB.Fields[0].AsInteger;
           
         IF (Existe = 0) THEN
            BEGIN
                 QUERY_MSSQL:='INSERT INTO TCONTRAFACT (CODCOFAC,FECHALTA,NUMFACTU,CAE,FECHAVENCE,PLANTA) '+
                              ' VALUES ('+
                              ' '+INTTOSTR(CodCoFacNC)+' '+
                              ','+#39+TRIM(FECHANC)+#39+' '+
                              ','+INTTOSTR(NumNC)+' '+
                              ','+#39+TRIM(CaeNC)+#39+' '+
                              ','+#39+TRIM(VenceCaeNc)+#39+' '+
                              ','+INTTOSTR(plantapasa)+' '+
                              ')';

            IF (Existe = 0) THEN
             modulo.CONEXION.BeginTrans;
               TRY
                MEMO1.Lines.Add('IMPORTANDO NC: '+INTTOSTR(CodCoFacNC));
                RxTrayIcon1.HiNT:='IMPORTANDO NC: '+INTTOSTR(CodCoFacNC);
                APPLICATION.ProcessMessages;
                modulo.QUERY_WEB.Close;
                modulo.QUERY_WEB.SQL.Clear;
                modulo.QUERY_WEB.SQL.Add(QUERY_MSSQL);
                modulo.QUERY_WEB.ExecSQL;
                modulo.CONEXION.CommitTrans;
                //MEMO1.Lines.Add('TRANSACCION: OK');
                //APPLICATION.ProcessMessages;

           EXCEPT
             on E: Exception do
                      BEGIN
                        MEMO1.Lines.Add('TRANSACCION: ERROR');
                         APPLICATION.ProcessMessages;
                         modulo.CONEXION.RollbackTrans;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| PLANTA '+INTTOSTR(plantapasa)+' NO SE INSERTO NC '+INTTOSTR(CodCoFacNC)+' POR :'+ E.message);
                      END;
          END;

      END ELSE
           BEGIN
               MEMO1.Lines.Add('Ya existe NC: '+INTTOSTR(CodCoFacNC));
               RxTrayIcon1.HiNT:='Ya existe NC: '+INTTOSTR(CodCoFacNC);
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

 //Application.MessageBox( 'PROCESO TERMINADO.', 'Atenci�n', MB_ICONINFORMATION );
 SHRINK_LOG;
END;

FUNCTION TFORM1.ENVIAR_TURNO_A_MSSQL(turno:longint;plantapasa:longint):BOOLEAN;
var
QUERY_MSSQL:string;

TURNOID,CODVEHIC,CODCLIEN,Existe:longint;
FECHATURNO,TIPOTURNO,PATENTE,AUSENTE,CODINSPE,
FACTURADO,REVISO,PAGOID,PLANTA,TIPOINSPE:String;

BEGIN
{Busco Turno Nuevos}
with tsqlQuery.Create(nil) do
    try
        SQLConnection:= MYBD;
        SQL.Add('SELECT DISTINCT '+
                'TDAT.TURNOID'+
                ',TDAT.FECHATURNO '+
                ',TDAT.TIPOTURNO '+
                ',TDAT.DVDOMINO '+
                ',TDAT.AUSENTE '+
                ',TDAT.FACTURADO '+
                ',TDAT.REVISO '+
                ',TDAT.CODINSPE '+
                ',TDAT.CODVEHIC '+
                ',TDAT.CODCLIEN '+
                ',TDAT.PAGOIDVERIFICACION '+
                ',TDAT.TIPOINSPE '+
                ',CASE WHEN TDAT.PLANTA = 3 THEN 2 '+
                '      WHEN TDAT.PLANTA = 4 THEN 3 '+
                'END AS PLANTA '+
                'FROM TDATOSTURNOHISTORIAL TDAT '+
                'WHERE TDAT.TURNOID >' +inttostr(turno)+
                '  AND CASE WHEN TDAT.PLANTA = 3 THEN 2 '+
                '           WHEN TDAT.PLANTA = 4 THEN 3 '+
                '      END = '+IntToStr(plantapasa)+
                '  AND TURNOID NOT LIKE ''-'' '+
                '  AND CODINSPE <> 0 '+
                ' ORDER BY TDAT.TURNOID');
        Open;

        WHILE NOT EOF DO

        BEGIN
        TURNOID:=FIELDBYNAME('TURNOID').ASINTEGER;
        FECHATURNO:=TRIM(FIELDBYNAME('FECHATURNO').ASSTRING);
        TIPOTURNO:=TRIM(FIELDBYNAME('TIPOTURNO').ASSTRING);
        PATENTE:=TRIM(FIELDBYNAME('DVDOMINO').ASSTRING);
        AUSENTE:=TRIM(FIELDBYNAME('AUSENTE').ASSTRING);
        FACTURADO:=TRIM(FIELDBYNAME('FACTURADO').ASSTRING);
        REVISO:=TRIM(FIELDBYNAME('REVISO').ASSTRING);
        CODINSPE:=TRIM(FIELDBYNAME('CODINSPE').ASSTRING);
        CODVEHIC:=FIELDBYNAME('CODVEHIC').ASINTEGER;
        CODCLIEN:=FIELDBYNAME('CODCLIEN').ASINTEGER;
        PAGOID:=TRIM(FIELDBYNAME('PAGOIDVERIFICACION').ASSTRING);
        PLANTA:=TRIM(FIELDBYNAME('PLANTA').ASSTRING);
        TIPOINSPE:=TRIM(FIELDBYNAME('TIPOINSPE').ASSTRING);

         modulo.QUERY_WEB.Close;
         modulo.QUERY_WEB.SQL.Clear;
         modulo.QUERY_WEB.SQL.Add('SELECT COUNT(*) FROM TDATOSTURNO '+
                                  ' WHERE TURNOID ='+inttostr(TURNOID)+
                                  '   AND CODINSPE ='+#39+TRIM(CODINSPE)+#39+
                                  '   AND PLANTA ='+inttostr(plantapasa));
         modulo.QUERY_WEB.ExecSQL;
         modulo.QUERY_WEB.Open;
         Existe:=modulo.QUERY_WEB.Fields[0].AsInteger;
           
         IF (Existe = 0) THEN
            BEGIN
                 QUERY_MSSQL:='INSERT INTO TDATOSTURNO (TURNOID,CODINSPE,CODVEHIC,CODCLIEN,FECHATURNO,TIPOTURNO, '+
                              ' PATENTE,AUSENTE,FACTURADO,REVISO,PAGOIDVERIFICACION,PLANTA,TIPOINSPE) '+
                              ' VALUES ('+
                              ' '+INTTOSTR(TURNOID)+' '+
                              ','+#39+TRIM(CODINSPE)+#39+' '+
                              ','+INTTOSTR(CODVEHIC)+' '+
                              ','+INTTOSTR(CODCLIEN)+' '+
                              ','+#39+TRIM(FECHATURNO)+#39+' '+
                              ','+#39+TRIM(TIPOTURNO)+#39+' '+
                              ','+#39+TRIM(PATENTE)+#39+' '+
                              ','+#39+TRIM(AUSENTE)+#39+' '+
                              ','+#39+TRIM(FACTURADO)+#39+' '+
                              ','+#39+TRIM(REVISO)+#39+' '+
                              ','+#39+TRIM(PAGOID)+#39+' '+
                              ','+#39+TRIM(PLANTA)+#39+' '+
                              ','+#39+TRIM(TIPOINSPE)+#39+' '+
                              ')';

            IF (Existe = 0) THEN
             modulo.CONEXION.BeginTrans;
               TRY
                MEMO1.Lines.Add('IMPORTANDO TURNO: '+INTTOSTR(TURNOID));
                RxTrayIcon1.HiNT:='IMPORTANDO TURNO: '+INTTOSTR(TURNOID);
                APPLICATION.ProcessMessages;
                modulo.QUERY_WEB.Close;
                modulo.QUERY_WEB.SQL.Clear;
                modulo.QUERY_WEB.SQL.Add(QUERY_MSSQL);
                modulo.QUERY_WEB.ExecSQL;
                modulo.CONEXION.CommitTrans;
                //MEMO1.Lines.Add('TRANSACCION: OK');
                //APPLICATION.ProcessMessages;

           EXCEPT
             on E: Exception do
                      BEGIN
                        MEMO1.Lines.Add('TRANSACCION: ERROR');
                         APPLICATION.ProcessMessages;
                         modulo.CONEXION.RollbackTrans;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| PLANTA '+INTTOSTR(plantapasa)+' NO SE INSERTO TURNO '+INTTOSTR(TURNOID)+' POR :'+ E.message);
                      END;
          END;

      END ELSE
           BEGIN
               MEMO1.Lines.Add('Ya existe TURNO: '+INTTOSTR(TURNOID));
               RxTrayIcon1.HiNT:='Ya existe TURNO: '+INTTOSTR(TURNOID);
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

 //Application.MessageBox( 'PROCESO TERMINADO.', 'Atenci�n', MB_ICONINFORMATION );
 SHRINK_LOG;
END;

FUNCTION TFORM1.ENVIAR_INSPECCION_A_MSSQL(CODINSPE:longint;plantapasa:longint):BOOLEAN;
var
QUERY_MSSQL:string;

INSPECCION,CODCLPRO,CODVEHIC,
CODCLCON,CODCLTEN,EJERCICI,
Existe:longint;
FECHAINSP,TIPO,INSPFINA,
NUMOBLEA,RESULTAD:String;

BEGIN
{Busco Inspecciones nuevas}
with tsqlQuery.Create(nil) do
    try
        SQLConnection:= MYBD;
        SQL.Add('SELECT DISTINCT '+
                'TINS.EJERCICI '+
                ',TINS.CODINSPE '+
                ',TINS.CODVEHIC '+
                ',TINS.CODCLPRO '+
                ',TINS.CODCLCON '+
                ',TINS.CODCLTEN '+
                ',TINS.INSPFINA '+
                ',TINS.TIPO '+
                ',TINS.FECHALTA '+
                ',TINS.NUMOBLEA '+
                ',TINS.RESULTAD '+
                'FROM TINSPECCION TINS '+
                'WHERE TINS.CODINSPE > '+IntToStr(CODINSPE)+
                ' ORDER BY TINS.CODINSPE');

        Open;

        WHILE NOT EOF DO

        BEGIN
        EJERCICI:=FIELDBYNAME('EJERCICI').ASINTEGER;
        INSPECCION:=FIELDBYNAME('CODINSPE').ASINTEGER;
        CODVEHIC:=FIELDBYNAME('CODVEHIC').ASINTEGER;
        CODCLPRO:=FIELDBYNAME('CODCLPRO').ASINTEGER;
        CODCLCON:=FIELDBYNAME('CODCLCON').ASINTEGER;
        CODCLTEN:=FIELDBYNAME('CODCLTEN').ASINTEGER;
        INSPFINA:=TRIM(FIELDBYNAME('INSPFINA').ASSTRING);
        TIPO:=TRIM(FIELDBYNAME('TIPO').ASSTRING);
        FECHAINSP:=TRIM(FIELDBYNAME('FECHALTA').ASSTRING);
        NUMOBLEA:=TRIM(FIELDBYNAME('NUMOBLEA').ASSTRING);
        RESULTAD:=TRIM(FIELDBYNAME('RESULTAD').ASSTRING);

         modulo.QUERY_WEB.Close;
         modulo.QUERY_WEB.SQL.Clear;
         modulo.QUERY_WEB.SQL.Add('SELECT COUNT(*) FROM TINSPECCION '+
                                  ' WHERE CODINSPE='+inttostr(INSPECCION)+
                                  ' AND EJERCICI ='+inttostr(EJERCICI)+
                                  ' AND CODVEHIC ='+inttostr(CODVEHIC)+
                                  ' AND PLANTA ='+inttostr(plantapasa));
         modulo.QUERY_WEB.ExecSQL;
         modulo.QUERY_WEB.Open;
         Existe:=modulo.QUERY_WEB.Fields[0].AsInteger;

         IF (Existe = 0) THEN
            BEGIN
                 QUERY_MSSQL:='INSERT INTO TINSPECCION (EJERCICI,CODINSPE,CODVEHIC,CODCLPRO,CODCLCON, '+
                              'CODCLTEN,INSPFINA,TIPO,FECHALTA,NUMOBLEA,RESULTAD,PLANTA )'+
                              ' VALUES ('+
                              ' '+INTTOSTR(EJERCICI)+' '+
                              ','+INTTOSTR(INSPECCION)+' '+
                              ','+INTTOSTR(CODVEHIC)+' '+
                              ','+INTTOSTR(CODCLPRO)+' '+
                              ','+INTTOSTR(CODCLCON)+' '+
                              ','+INTTOSTR(CODCLTEN)+' '+
                              ','+#39+TRIM(INSPFINA)+#39+' '+
                              ','+#39+TRIM(TIPO)+#39+' '+
                              ','+#39+TRIM(FECHAINSP)+#39+' '+
                              ','+#39+TRIM(NUMOBLEA)+#39+' '+
                              ','+#39+TRIM(RESULTAD)+#39+' '+
                              ','+INTTOSTR(plantapasa)+' '+
                              ')';

            IF (Existe = 0) THEN
             modulo.CONEXION.BeginTrans;
               TRY
                MEMO1.Lines.Add('IMPORTANDO INSPECCION: '+INTTOSTR(INSPECCION));
                RxTrayIcon1.HiNT:='IMPORTANDO INSPECCION: '+INTTOSTR(INSPECCION);
                APPLICATION.ProcessMessages;
                modulo.QUERY_WEB.Close;
                modulo.QUERY_WEB.SQL.Clear;
                modulo.QUERY_WEB.SQL.Add(QUERY_MSSQL);
                modulo.QUERY_WEB.ExecSQL;
                modulo.CONEXION.CommitTrans;
                //MEMO1.Lines.Add('TRANSACCION: OK');
                //APPLICATION.ProcessMessages;

           EXCEPT
             on E: Exception do
                      BEGIN
                        MEMO1.Lines.Add('TRANSACCION: ERROR');
                         APPLICATION.ProcessMessages;
                         modulo.CONEXION.RollbackTrans;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| PLANTA '+INTTOSTR(plantapasa)+' NO SE INSERTO INSPECCION '+INTTOSTR(INSPECCION)+' POR :'+ E.message);
                      END;
          END;

      END ELSE
           BEGIN
               MEMO1.Lines.Add('Ya existe INSPECCION: '+INTTOSTR(INSPECCION));
               RxTrayIcon1.HiNT:='Ya existe INSPECCION: '+INTTOSTR(INSPECCION);
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

 //Application.MessageBox( 'PROCESO TERMINADO.', 'Atenci�n', MB_ICONINFORMATION );
 SHRINK_LOG;
END;

FUNCTION TFORM1.ENVIAR_CLIENTE_A_MSSQL(CODCLIEN:longint;plantapasa:longint):BOOLEAN;
var
QUERY_MSSQL:string;

Existe:longint;

TIPODOCU,DOCUMENT,FECHALTA,
NOMBRE,APELLID1,APELLID2,
TIPFACTU,TIPTRIBU,CREDITCL,
FORM_576,CODPOSTA,FECMOROS,
CUIT_CLI,TELEFONO,LOCALIDA,
DIRECCIO,HABILITACION,NROCALLE,
PISO,DEPTO,EXENTO_IIBB,
NRO_IIBB,COD_AREA,CELULAR,
MAIL,GENERO:STRING;

TIPOCLIENTE_ID,CODPARTI,
IDLOCALIDAD,CODDOCU,
PROVINCIA,CLIENTE:Longint;

BEGIN

{Busco facturas nuevas}
with tsqlQuery.Create(nil) do
    try
        SQLConnection:= MYBD;
        IF (plantapasa = 2) OR (plantapasa = 3) THEN BEGIN
        SQL.Add('SELECT DISTINCT '+
                'TCLI.CODCLIEN '+
                ',REPLACE(REPLACE(TRIM(TCLI.TIPODOCU),CHR(39),''''),CHR(180),'''') AS TIPODOCU '+
                ',REPLACE(REPLACE(TRIM(TCLI.DOCUMENT),CHR(39),''''),CHR(180),'''') AS DOCUMENT '+
                ',TCLI.FECHALTA '+
                ',REPLACE(REPLACE(TRIM(TCLI.NOMBRE),CHR(39),''''),CHR(180),'''') AS NOMBRE '+
                ',REPLACE(REPLACE(TRIM(TCLI.APELLID1),CHR(39),''''),CHR(180),'''') AS APELLID1 '+
                ',REPLACE(REPLACE(TRIM(TCLI.APELLID2),CHR(39),''''),CHR(180),'''') AS APELLID2 '+
                ',REPLACE(REPLACE(TRIM(TCLI.TIPFACTU),CHR(39),''''),CHR(180),'''') AS TIPFACTU '+
                ',REPLACE(REPLACE(TRIM(TCLI.TIPTRIBU),CHR(39),''''),CHR(180),'''') AS TIPTRIBU '+
                ',REPLACE(REPLACE(TRIM(TCLI.CREDITCL),CHR(39),''''),CHR(180),'''') AS CREDITCL '+
                ',REPLACE(REPLACE(TRIM(TCLI.FORM_576),CHR(39),''''),CHR(180),'''') AS FORM_576 '+
                ',REPLACE(REPLACE(TRIM(TCLI.CODPOSTA),CHR(39),''''),CHR(180),'''') AS CODPOSTA '+
                ',REPLACE(REPLACE(TRIM(TCLI.FECMOROS),CHR(39),''''),CHR(180),'''') AS FECMOROS '+
                ',REPLACE(REPLACE(TRIM(TCLI.CUIT_CLI),CHR(39),''''),CHR(180),'''') AS CUIT_CLI '+
                ',REPLACE(REPLACE(TRIM(TCLI.TELEFONO),CHR(39),''''),CHR(180),'''') AS TELEFONO '+
                ',REPLACE(REPLACE(TRIM(TCLI.LOCALIDA),CHR(39),''''),CHR(180),'''') AS LOCALIDA '+
                ',REPLACE(REPLACE(TRIM(TCLI.DIRECCIO),CHR(39),''''),CHR(180),'''') AS DIRECCIO '+
                ',REPLACE(REPLACE(TRIM(TCLI.HABILITACION),CHR(39),''''),CHR(180),'''') AS HABILITACION '+
                ',REPLACE(REPLACE(TRIM(TCLI.NROCALLE),CHR(39),''''),CHR(180),'''') AS NROCALLE '+
                ',REPLACE(REPLACE(TRIM(TCLI.PISO),CHR(39),''''),CHR(180),'''') AS PISO '+
                ',REPLACE(REPLACE(TRIM(TCLI.DEPTO),CHR(39),''''),CHR(180),'''') AS DEPTO '+
                ',REPLACE(REPLACE(TRIM(TCLI.EXENTO_IIBB),CHR(39),''''),CHR(180),'''') AS EXENTO_IIBB '+
                ',REPLACE(REPLACE(TRIM(TCLI.NRO_IIBB),CHR(39),''''),CHR(180),'''') AS NRO_IIBB '+
                ',REPLACE(REPLACE(TRIM(TCLI.COD_AREA),CHR(39),''''),CHR(180),'''') AS COD_AREA '+
                ',REPLACE(REPLACE(TRIM(TCLI.CELULAR),CHR(39),''''),CHR(180),'''') AS CELULAR '+
                ',REPLACE(REPLACE(TRIM(TCLI.MAIL),CHR(39),''''),CHR(180),'''') AS MAIL '+
                ',REPLACE(REPLACE(TRIM(TCLI.GENERO),CHR(39),''''),CHR(180),'''') AS GENERO '+
                ',TCLI.TIPOCLIENTE_ID '+
                ',TCLI.CODPARTI '+
                ',TCLI.IDLOCALIDAD '+
                ',TCLI.CODDOCU '+
                ',TCLI.PROVINCIA '+
                'FROM TCLIENTES TCLI '+
                'WHERE TCLI.CODCLIEN >' +inttostr(CODCLIEN)+
                ' ORDER BY TCLI.CODCLIEN'
                );
         END ELSE BEGIN
         SQL.Add('SELECT DISTINCT '+
                'TCLI.CODCLIEN '+
                ',REPLACE(REPLACE(TRIM(TCLI.TIPODOCU),CHR(39),''''),CHR(180),'''') AS TIPODOCU '+
                ',REPLACE(REPLACE(TRIM(TCLI.DOCUMENT),CHR(39),''''),CHR(180),'''') AS DOCUMENT '+
                ',TCLI.FECHALTA '+
                ',REPLACE(REPLACE(TRIM(TCLI.NOMBRE),CHR(39),''''),CHR(180),'''') AS NOMBRE '+
                ',REPLACE(REPLACE(TRIM(TCLI.APELLID1),CHR(39),''''),CHR(180),'''') AS APELLID1 '+
                ',REPLACE(REPLACE(TRIM(TCLI.APELLID2),CHR(39),''''),CHR(180),'''') AS APELLID2 '+
                ',REPLACE(REPLACE(TRIM(TCLI.TIPFACTU),CHR(39),''''),CHR(180),'''') AS TIPFACTU '+
                ',REPLACE(REPLACE(TRIM(TCLI.TIPTRIBU),CHR(39),''''),CHR(180),'''') AS TIPTRIBU '+
                ',REPLACE(REPLACE(TRIM(TCLI.CREDITCL),CHR(39),''''),CHR(180),'''') AS CREDITCL '+
                ',REPLACE(REPLACE(TRIM(TCLI.FORM_576),CHR(39),''''),CHR(180),'''') AS FORM_576 '+
                ',REPLACE(REPLACE(TRIM(TCLI.CODPOSTA),CHR(39),''''),CHR(180),'''') AS CODPOSTA '+
                ',REPLACE(REPLACE(TRIM(TCLI.FECMOROS),CHR(39),''''),CHR(180),'''') AS FECMOROS '+
                ',REPLACE(REPLACE(TRIM(TCLI.CUIT_CLI),CHR(39),''''),CHR(180),'''') AS CUIT_CLI '+
                ',REPLACE(REPLACE(TRIM(TCLI.TELEFONO),CHR(39),''''),CHR(180),'''') AS TELEFONO '+
                ',REPLACE(REPLACE(TRIM(TCLI.LOCALIDA),CHR(39),''''),CHR(180),'''') AS LOCALIDA '+
                ',REPLACE(REPLACE(TRIM(TCLI.DIRECCIO),CHR(39),''''),CHR(180),'''') AS DIRECCIO '+
                ',REPLACE(REPLACE(TRIM(TCLI.HABILITACION),CHR(39),''''),CHR(180),'''') AS HABILITACION '+
                ',REPLACE(REPLACE(TRIM(TCLI.NROCALLE),CHR(39),''''),CHR(180),'''') AS NROCALLE '+
                ',REPLACE(REPLACE(TRIM(TCLI.PISO),CHR(39),''''),CHR(180),'''') AS PISO '+
                ',REPLACE(REPLACE(TRIM(TCLI.DEPTO),CHR(39),''''),CHR(180),'''') AS DEPTO '+
                ',REPLACE(REPLACE(TRIM(TCLI.EXENTO_IIBB),CHR(39),''''),CHR(180),'''') AS EXENTO_IIBB '+
                ',REPLACE(REPLACE(TRIM(TCLI.NRO_IIBB),CHR(39),''''),CHR(180),'''') AS NRO_IIBB '+
                ',REPLACE(REPLACE(TRIM(TCLI.COD_AREA),CHR(39),''''),CHR(180),'''') AS COD_AREA '+
                ',REPLACE(REPLACE(TRIM(TCLI.CELULAR),CHR(39),''''),CHR(180),'''') AS CELULAR '+
                ',TCLI.TIPOCLIENTE_ID '+
                ',TCLI.CODPARTI '+
                ',TCLI.IDLOCALIDAD '+
                'FROM TCLIENTES TCLI '+
                'WHERE TCLI.CODCLIEN >' +inttostr(CODCLIEN)+
                ' ORDER BY TCLI.CODCLIEN'
                );
           END;

        Open;

        WHILE NOT EOF DO

        BEGIN
        {TCLIENTES}
        IF (plantapasa = 2) OR (plantapasa = 3) THEN BEGIN
           CLIENTE:=FIELDBYNAME('CODCLIEN').ASINTEGER;
           TIPODOCU:=TRIM(FIELDBYNAME('TIPODOCU').ASSTRING);
           DOCUMENT:=TRIM(FIELDBYNAME('DOCUMENT').ASSTRING);
           FECHALTA:=TRIM(FIELDBYNAME('FECHALTA').ASSTRING);
           NOMBRE:=TRIM(FIELDBYNAME('NOMBRE').ASSTRING);
           APELLID1:=TRIM(FIELDBYNAME('APELLID1').ASSTRING);
           APELLID2:=TRIM(FIELDBYNAME('APELLID2').ASSTRING);
           TIPFACTU:=TRIM(FIELDBYNAME('TIPFACTU').ASSTRING);
           TIPTRIBU:=TRIM(FIELDBYNAME('TIPTRIBU').ASSTRING);
           CREDITCL:=TRIM(FIELDBYNAME('CREDITCL').ASSTRING);
           FORM_576:=TRIM(FIELDBYNAME('FORM_576').ASSTRING);
           CODPOSTA:=TRIM(FIELDBYNAME('CODPOSTA').ASSTRING);
           FECMOROS:=TRIM(FIELDBYNAME('FECMOROS').ASSTRING);
           CUIT_CLI:=TRIM(FIELDBYNAME('CUIT_CLI').ASSTRING);
           TELEFONO:=TRIM(FIELDBYNAME('TELEFONO').ASSTRING);
           LOCALIDA:=TRIM(FIELDBYNAME('LOCALIDA').ASSTRING);
           DIRECCIO:=TRIM(FIELDBYNAME('DIRECCIO').ASSTRING);
           HABILITACION:=TRIM(FIELDBYNAME('HABILITACION').ASSTRING);
           NROCALLE:=TRIM(FIELDBYNAME('NROCALLE').ASSTRING);
           PISO:=TRIM(FIELDBYNAME('PISO').ASSTRING);
           DEPTO:=TRIM(FIELDBYNAME('DEPTO').ASSTRING);
           EXENTO_IIBB:=TRIM(FIELDBYNAME('EXENTO_IIBB').ASSTRING);
           NRO_IIBB:=TRIM(FIELDBYNAME('NRO_IIBB').ASSTRING);
           COD_AREA:=TRIM(FIELDBYNAME('COD_AREA').ASSTRING);
           CELULAR:=TRIM(FIELDBYNAME('CELULAR').ASSTRING);
           MAIL:=TRIM(FIELDBYNAME('MAIL').ASSTRING);
           GENERO:=TRIM(FIELDBYNAME('GENERO').ASSTRING);
           TIPOCLIENTE_ID:=FIELDBYNAME('TIPOCLIENTE_ID').ASINTEGER;
           CODPARTI:=FIELDBYNAME('CODPARTI').ASINTEGER;
           IDLOCALIDAD:=FIELDBYNAME('IDLOCALIDAD').ASINTEGER;
           CODDOCU:=FIELDBYNAME('CODDOCU').ASINTEGER;
           PROVINCIA:=FIELDBYNAME('PROVINCIA').ASINTEGER;
        END ELSE
          BEGIN
           CLIENTE:=FIELDBYNAME('CODCLIEN').ASINTEGER;
           TIPODOCU:=TRIM(FIELDBYNAME('TIPODOCU').ASSTRING);
           DOCUMENT:=TRIM(FIELDBYNAME('DOCUMENT').ASSTRING);
           FECHALTA:=TRIM(FIELDBYNAME('FECHALTA').ASSTRING);
           NOMBRE:=TRIM(FIELDBYNAME('NOMBRE').ASSTRING);
           APELLID1:=TRIM(FIELDBYNAME('APELLID1').ASSTRING);
           APELLID2:=TRIM(FIELDBYNAME('APELLID2').ASSTRING);
           TIPFACTU:=TRIM(FIELDBYNAME('TIPFACTU').ASSTRING);
           TIPTRIBU:=TRIM(FIELDBYNAME('TIPTRIBU').ASSTRING);
           CREDITCL:=TRIM(FIELDBYNAME('CREDITCL').ASSTRING);
           FORM_576:=TRIM(FIELDBYNAME('FORM_576').ASSTRING);
           CODPOSTA:=TRIM(FIELDBYNAME('CODPOSTA').ASSTRING);
           FECMOROS:=TRIM(FIELDBYNAME('FECMOROS').ASSTRING);
           CUIT_CLI:=TRIM(FIELDBYNAME('CUIT_CLI').ASSTRING);
           TELEFONO:=TRIM(FIELDBYNAME('TELEFONO').ASSTRING);
           LOCALIDA:=TRIM(FIELDBYNAME('LOCALIDA').ASSTRING);
           DIRECCIO:=TRIM(FIELDBYNAME('DIRECCIO').ASSTRING);
           HABILITACION:=TRIM(FIELDBYNAME('HABILITACION').ASSTRING);
           NROCALLE:=TRIM(FIELDBYNAME('NROCALLE').ASSTRING);
           PISO:=TRIM(FIELDBYNAME('PISO').ASSTRING);
           DEPTO:=TRIM(FIELDBYNAME('DEPTO').ASSTRING);
           EXENTO_IIBB:=TRIM(FIELDBYNAME('EXENTO_IIBB').ASSTRING);
           NRO_IIBB:=TRIM(FIELDBYNAME('NRO_IIBB').ASSTRING);
           COD_AREA:=TRIM(FIELDBYNAME('COD_AREA').ASSTRING);
           CELULAR:=TRIM(FIELDBYNAME('CELULAR').ASSTRING);
           TIPOCLIENTE_ID:=FIELDBYNAME('TIPOCLIENTE_ID').ASINTEGER;
           CODPARTI:=FIELDBYNAME('CODPARTI').ASINTEGER;
           IDLOCALIDAD:=FIELDBYNAME('IDLOCALIDAD').ASINTEGER;
        END;
        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;

        modulo.QUERY_WEB.SQL.Add('SELECT COUNT(*) FROM TCLIENTES TCLI '+
                                 'WHERE TCLI.CODCLIEN = '+inttostr(CODCLIEN)+
                                 '  AND TCLI.TIPODOCU = '+#39+TRIM(TIPODOCU)+#39+
                                 '  AND TCLI.DOCUMENT = '+#39+TRIM(DOCUMENT)+#39+
                                 '  AND TCLI.PLANTA = '+inttostr(plantapasa));
        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.Open;
        Existe:=modulo.QUERY_WEB.Fields[0].AsInteger;

        IF (Existe = 0) THEN
          BEGIN
          IF (plantapasa = 2) OR (plantapasa = 3) THEN BEGIN
                QUERY_MSSQL:='INSERT INTO TCLIENTES (CODCLIEN,TIPODOCU,DOCUMENT,FECHALTA,NOMBRE,APELLID1,APELLID2,'+
                             'TIPFACTU,TIPTRIBU,CREDITCL,FORM_576,CODPOSTA,FECMOROS,CUIT_CLI,TELEFONO,LOCALIDA,'+
                             'DIRECCIO,HABILITACION,NROCALLE,PISO,DEPTO,EXENTO_IIBB,NRO_IIBB,COD_AREA,CELULAR,'+
                             'MAIL,GENERO,TIPOCLIENTE_ID,CODPARTI,IDLOCALIDAD,CODDOCU,PROVINCIA,PLANTA)'+
                             ' VALUES ('+
                             ' '+INTTOSTR(CLIENTE)+' '+
                             ','+#39+TRIM(TIPODOCU)+#39+' '+
                             ','+#39+TRIM(DOCUMENT)+#39+' '+
                             ','+#39+TRIM(FECHALTA)+#39+' '+
                             ','+#39+TRIM(NOMBRE)+#39+' '+
                             ','+#39+TRIM(APELLID1)+#39+' '+
                             ','+#39+TRIM(APELLID2)+#39+' '+
                             ','+#39+TRIM(TIPFACTU)+#39+' '+
                             ','+#39+TRIM(TIPTRIBU)+#39+' '+
                             ','+#39+TRIM(CREDITCL)+#39+' '+
                             ','+#39+TRIM(FORM_576)+#39+' '+
                             ','+#39+TRIM(CODPOSTA)+#39+' '+
                             ','+#39+TRIM(FECMOROS)+#39+' '+
                             ','+#39+TRIM(CUIT_CLI)+#39+' '+
                             ','+#39+TRIM(TELEFONO)+#39+' '+
                             ','+#39+TRIM(LOCALIDA)+#39+' '+
                             ','+#39+TRIM(DIRECCIO)+#39+' '+
                             ','+#39+TRIM(HABILITACION)+#39+' '+
                             ','+#39+TRIM(NROCALLE)+#39+' '+
                             ','+#39+TRIM(PISO)+#39+' '+
                             ','+#39+TRIM(DEPTO)+#39+' '+
                             ','+#39+TRIM(EXENTO_IIBB)+#39+' '+
                             ','+#39+TRIM(NRO_IIBB)+#39+' '+
                             ','+#39+TRIM(COD_AREA)+#39+' '+
                             ','+#39+TRIM(CELULAR)+#39+' '+
                             ','+#39+TRIM(MAIL)+#39+' '+
                             ','+#39+TRIM(GENERO)+#39+' '+
                             ','+INTTOSTR(TIPOCLIENTE_ID)+' '+
                             ','+INTTOSTR(CODPARTI)+' '+
                             ','+INTTOSTR(IDLOCALIDAD)+' '+
                             ','+INTTOSTR(CODDOCU)+' '+
                             ','+INTTOSTR(PROVINCIA)+' '+
                             ','+INTTOSTR(plantapasa)+' '+
                             ')';
          END ELSE BEGIN
              QUERY_MSSQL:='INSERT INTO TCLIENTES (CODCLIEN,TIPODOCU,DOCUMENT,FECHALTA,NOMBRE,APELLID1,APELLID2,'+
                             'TIPFACTU,TIPTRIBU,CREDITCL,FORM_576,CODPOSTA,FECMOROS,CUIT_CLI,TELEFONO,LOCALIDA,'+
                             'DIRECCIO,HABILITACION,NROCALLE,PISO,DEPTO,EXENTO_IIBB,NRO_IIBB,COD_AREA,CELULAR,'+
                             'TIPOCLIENTE_ID,CODPARTI,IDLOCALIDAD,PLANTA)'+
                             ' VALUES ('+
                             ' '+INTTOSTR(CLIENTE)+' '+
                             ','+#39+TRIM(TIPODOCU)+#39+' '+
                             ','+#39+TRIM(DOCUMENT)+#39+' '+
                             ','+#39+TRIM(FECHALTA)+#39+' '+
                             ','+#39+TRIM(NOMBRE)+#39+' '+
                             ','+#39+TRIM(APELLID1)+#39+' '+
                             ','+#39+TRIM(APELLID2)+#39+' '+
                             ','+#39+TRIM(TIPFACTU)+#39+' '+
                             ','+#39+TRIM(TIPTRIBU)+#39+' '+
                             ','+#39+TRIM(CREDITCL)+#39+' '+
                             ','+#39+TRIM(FORM_576)+#39+' '+
                             ','+#39+TRIM(CODPOSTA)+#39+' '+
                             ','+#39+TRIM(FECMOROS)+#39+' '+
                             ','+#39+TRIM(CUIT_CLI)+#39+' '+
                             ','+#39+TRIM(TELEFONO)+#39+' '+
                             ','+#39+TRIM(LOCALIDA)+#39+' '+
                             ','+#39+TRIM(DIRECCIO)+#39+' '+
                             ','+#39+TRIM(HABILITACION)+#39+' '+
                             ','+#39+TRIM(NROCALLE)+#39+' '+
                             ','+#39+TRIM(PISO)+#39+' '+
                             ','+#39+TRIM(DEPTO)+#39+' '+
                             ','+#39+TRIM(EXENTO_IIBB)+#39+' '+
                             ','+#39+TRIM(NRO_IIBB)+#39+' '+
                             ','+#39+TRIM(COD_AREA)+#39+' '+
                             ','+#39+TRIM(CELULAR)+#39+' '+
                             ','+INTTOSTR(TIPOCLIENTE_ID)+' '+
                             ','+INTTOSTR(CODPARTI)+' '+
                             ','+INTTOSTR(IDLOCALIDAD)+' '+
                             ','+INTTOSTR(plantapasa)+' '+
                             ')';
          END;

          IF (Existe = 0) THEN
             modulo.CONEXION.BeginTrans;
               TRY
                MEMO1.Lines.Add('IMPORTANDO CLIENTE: '+INTTOSTR(CLIENTE));
                RxTrayIcon1.HiNT:='IMPORTANDO CLIENTE: '+INTTOSTR(CLIENTE);
                APPLICATION.ProcessMessages;
                modulo.QUERY_WEB.Close;
                modulo.QUERY_WEB.SQL.Clear;
                modulo.QUERY_WEB.SQL.Add(QUERY_MSSQL);
                modulo.QUERY_WEB.ExecSQL;
                modulo.CONEXION.CommitTrans;
                //MEMO1.Lines.Add('TRANSACCION: OK');
                //APPLICATION.ProcessMessages;

           EXCEPT
             on E: Exception do
                      BEGIN
                         MEMO1.Lines.Add('TRANSACCION: ERROR');
                         APPLICATION.ProcessMessages;
                         modulo.CONEXION.RollbackTrans;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| PLANTA '+INTTOSTR(plantapasa)+' NO SE INSERTO CLIENTE '+INTTOSTR(CLIENTE)+' POR :'+ E.message);
                      END;
           END;

         END ELSE
           BEGIN
               MEMO1.Lines.Add('Ya existe CLIENTE: '+INTTOSTR(CLIENTE));
               RxTrayIcon1.HiNT:='Ya existe CLIENTE: '+INTTOSTR(CLIENTE);
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

 //Application.MessageBox( 'PROCESO TERMINADO.', 'Atenci�n', MB_ICONINFORMATION );
 SHRINK_LOG;
END;

FUNCTION TFORM1.ENVIAR_VEHICULO_A_MSSQL(CODVEHIC:longint;plantapasa:longint):BOOLEAN;
var
QUERY_MSSQL:string;

Existe:longint;

VEHICULO,ANIOFABR,CODMARCA,
CODMODEL,TIPOESPE,TIPODEST,
NUMEJES,CODEQUIGNC,TIPOMOTORDIESEL,
TIPOMOTORMOTO:Longint;

FECMATRI,FECHALTA,NUMBASTI,
NUMMOTOR,NCERTGNC,PATENTEN,
PATENTEA,TIPOGAS,ERROR,
OFICIAL,INYECCION:STRING;

BEGIN

{Busco facturas nuevas}
with tsqlQuery.Create(nil) do
    try
        SQLConnection:= MYBD;
        IF (plantapasa = 2) OR (plantapasa = 3) THEN BEGIN
        SQL.Add('SELECT DISTINCT '+
                'TVE.CODVEHIC '+
                ',TVE.FECMATRI '+
                ',TVE.FECHALTA '+
                ',TVE.ANIOFABR '+
                ',TVE.CODMARCA '+
                ',TVE.CODMODEL '+
                ',TVE.TIPOESPE '+
                ',TVE.TIPODEST '+
                ',REPLACE(REPLACE(TRIM(TVE.NUMBASTI),CHR(39),''''),CHR(180),'''') AS NUMBASTI '+
                ',REPLACE(REPLACE(TRIM(TVE.NUMMOTOR),CHR(39),''''),CHR(180),'''') AS NUMMOTOR '+
                ',TVE.NUMEJES '+
                ',REPLACE(REPLACE(TRIM(TVE.NCERTGNC),CHR(39),''''),CHR(180),'''') AS NCERTGNC '+
                ',TVE.PATENTEN '+
                ',TVE.PATENTEA '+
                ',TVE.TIPOGAS '+
                ',TVE.ERROR '+
                ',TVE.OFICIAL '+
                ',TVE.INYECCION '+
                ',TVE.CODEQUIGNC '+
                ',TVE.TIPOMOTORDIESEL '+
                ',TVE.TIPOMOTORMOTO '+
                'FROM TVEHICULOS TVE '+
                'WHERE CODVEHIC >' +INTTOSTR(CODVEHIC)+
                ' ORDER BY TVE.CODVEHIC'
                );
        END ELSE BEGIN
        SQL.Add('SELECT DISTINCT '+
                'TVE.CODVEHIC '+
                ',TVE.FECMATRI '+
                ',TVE.FECHALTA '+
                ',TVE.ANIOFABR '+
                ',TVE.CODMARCA '+
                ',TVE.CODMODEL '+
                ',TVE.TIPOESPE '+
                ',TVE.TIPODEST '+
                ',REPLACE(REPLACE(TRIM(TVE.NUMBASTI),CHR(39),''''),CHR(180),'''') AS NUMBASTI '+
                ',REPLACE(REPLACE(TRIM(TVE.NUMMOTOR),CHR(39),''''),CHR(180),'''') AS NUMMOTOR '+
                ',TVE.NUMEJES '+
                ',REPLACE(REPLACE(TRIM(TVE.NCERTGNC),CHR(39),''''),CHR(180),'''') AS NCERTGNC '+
                ',TVE.PATENTEN '+
                ',TVE.PATENTEA '+
                ',TVE.TIPOGAS '+
                ',TVE.ERROR '+
                ',TVE.OFICIAL '+
                ',TVE.INYECCION '+
                ',TVE.CODEQUIGNC '+
                'FROM TVEHICULOS TVE '+
                'WHERE CODVEHIC >' +INTTOSTR(CODVEHIC)+
                ' ORDER BY TVE.CODVEHIC'
                );
        END;
        Open;

        WHILE NOT EOF DO

        BEGIN
        {TVEHICULOS}
        IF (plantapasa = 2) OR (plantapasa = 3) THEN BEGIN
        VEHICULO:=FIELDBYNAME('CODVEHIC').ASINTEGER;
        FECMATRI:=TRIM(FIELDBYNAME('FECMATRI').ASSTRING);
        FECHALTA:=TRIM(FIELDBYNAME('FECHALTA').ASSTRING);
        ANIOFABR:=FIELDBYNAME('ANIOFABR').ASINTEGER;
        CODMARCA:=FIELDBYNAME('CODMARCA').ASINTEGER;
        CODMODEL:=FIELDBYNAME('CODMODEL').ASINTEGER;
        TIPOESPE:=FIELDBYNAME('TIPOESPE').ASINTEGER;
        TIPODEST:=FIELDBYNAME('TIPODEST').ASINTEGER;
        NUMBASTI:=TRIM(FIELDBYNAME('NUMBASTI').ASSTRING);
        NUMMOTOR:=TRIM(FIELDBYNAME('NUMMOTOR').ASSTRING);
        NUMEJES:=FIELDBYNAME('NUMEJES').ASINTEGER;
        NCERTGNC:=TRIM(FIELDBYNAME('NCERTGNC').ASSTRING);
        PATENTEN:=TRIM(FIELDBYNAME('PATENTEN').ASSTRING);
        PATENTEA:=TRIM(FIELDBYNAME('PATENTEA').ASSTRING);
        TIPOGAS:=TRIM(FIELDBYNAME('TIPOGAS').ASSTRING);
        ERROR:=TRIM(FIELDBYNAME('ERROR').ASSTRING);
        OFICIAL:=TRIM(FIELDBYNAME('OFICIAL').ASSTRING);
        INYECCION:=TRIM(FIELDBYNAME('INYECCION').ASSTRING);
        CODEQUIGNC:=FIELDBYNAME('CODEQUIGNC').ASINTEGER;
        TIPOMOTORDIESEL:=FIELDBYNAME('TIPOMOTORDIESEL').ASINTEGER;
        TIPOMOTORMOTO:=FIELDBYNAME('TIPOMOTORMOTO').ASINTEGER;
        END ELSE BEGIN
        VEHICULO:=FIELDBYNAME('CODVEHIC').ASINTEGER;
        FECMATRI:=TRIM(FIELDBYNAME('FECMATRI').ASSTRING);
        FECHALTA:=TRIM(FIELDBYNAME('FECHALTA').ASSTRING);
        ANIOFABR:=FIELDBYNAME('ANIOFABR').ASINTEGER;
        CODMARCA:=FIELDBYNAME('CODMARCA').ASINTEGER;
        CODMODEL:=FIELDBYNAME('CODMODEL').ASINTEGER;
        TIPOESPE:=FIELDBYNAME('TIPOESPE').ASINTEGER;
        TIPODEST:=FIELDBYNAME('TIPODEST').ASINTEGER;
        NUMBASTI:=TRIM(FIELDBYNAME('NUMBASTI').ASSTRING);
        NUMMOTOR:=TRIM(FIELDBYNAME('NUMMOTOR').ASSTRING);
        NUMEJES:=FIELDBYNAME('NUMEJES').ASINTEGER;
        NCERTGNC:=TRIM(FIELDBYNAME('NCERTGNC').ASSTRING);
        PATENTEN:=TRIM(FIELDBYNAME('PATENTEN').ASSTRING);
        PATENTEA:=TRIM(FIELDBYNAME('PATENTEA').ASSTRING);
        TIPOGAS:=TRIM(FIELDBYNAME('TIPOGAS').ASSTRING);
        ERROR:=TRIM(FIELDBYNAME('ERROR').ASSTRING);
        OFICIAL:=TRIM(FIELDBYNAME('OFICIAL').ASSTRING);
        INYECCION:=TRIM(FIELDBYNAME('INYECCION').ASSTRING);
        CODEQUIGNC:=FIELDBYNAME('CODEQUIGNC').ASINTEGER;
        END;
        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;

        modulo.QUERY_WEB.SQL.Add('SELECT COUNT(*) FROM TVEHICULOS TVE '+
                                 'WHERE TVE.CODVEHIC = '+inttostr(VEHICULO)+
                                 '  AND TVE.PATENTEN = '+#39+TRIM(PATENTEN)+#39+
                                 '  AND TVE.PLANTA = '+inttostr(plantapasa));
        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.Open;
        Existe:=modulo.QUERY_WEB.Fields[0].AsInteger;

        IF (Existe = 0) THEN
          BEGIN
          IF (plantapasa = 2) OR (plantapasa = 3) THEN BEGIN
                QUERY_MSSQL:='INSERT INTO TVEHICULOS (CODVEHIC,FECMATRI,FECHALTA,ANIOFABR,CODMARCA,CODMODEL,TIPOESPE,TIPODEST, '+
                             'NUMBASTI,NUMMOTOR,NUMEJES,NCERTGNC,PATENTEN,PATENTEA,TIPOGAS,ERROR,OFICIAL,INYECCION,CODEQUIGNC, '+
                             'TIPOMOTORDIESEL,TIPOMOTORMOTO,PLANTA)'+
                             ' VALUES ('+
                             ' '+INTTOSTR(VEHICULO)+' '+
                             ','+#39+TRIM(FECMATRI)+#39+' '+
                             ','+#39+TRIM(FECHALTA)+#39+' '+
                             ','+INTTOSTR(ANIOFABR)+' '+
                             ','+INTTOSTR(CODMARCA)+' '+
                             ','+INTTOSTR(CODMODEL)+' '+
                             ','+INTTOSTR(TIPOESPE)+' '+
                             ','+INTTOSTR(TIPODEST)+' '+
                             ','+#39+TRIM(NUMBASTI)+#39+' '+
                             ','+#39+TRIM(NUMMOTOR)+#39+' '+
                             ','+INTTOSTR(NUMEJES)+' '+
                             ','+#39+TRIM(NCERTGNC)+#39+' '+
                             ','+#39+TRIM(PATENTEN)+#39+' '+
                             ','+#39+TRIM(PATENTEA)+#39+' '+
                             ','+#39+TRIM(TIPOGAS)+#39+' '+
                             ','+#39+TRIM(ERROR)+#39+' '+
                             ','+#39+TRIM(OFICIAL)+#39+' '+
                             ','+#39+TRIM(INYECCION)+#39+' '+
                             ','+INTTOSTR(CODEQUIGNC)+' '+
                             ','+INTTOSTR(TIPOMOTORDIESEL)+' '+
                             ','+INTTOSTR(TIPOMOTORMOTO)+' '+
                             ','+INTTOSTR(plantapasa)+' '+
                             ')';
          END ELSE BEGIN
              QUERY_MSSQL:='INSERT INTO TVEHICULOS (CODVEHIC,FECMATRI,FECHALTA,ANIOFABR,CODMARCA,CODMODEL,TIPOESPE,TIPODEST, '+
                             'NUMBASTI,NUMMOTOR,NUMEJES,NCERTGNC,PATENTEN,PATENTEA,TIPOGAS,ERROR,OFICIAL,INYECCION,CODEQUIGNC, '+
                             'PLANTA)'+
                             ' VALUES ('+
                             ' '+INTTOSTR(VEHICULO)+' '+
                             ','+#39+TRIM(FECMATRI)+#39+' '+
                             ','+#39+TRIM(FECHALTA)+#39+' '+
                             ','+INTTOSTR(ANIOFABR)+' '+
                             ','+INTTOSTR(CODMARCA)+' '+
                             ','+INTTOSTR(CODMODEL)+' '+
                             ','+INTTOSTR(TIPOESPE)+' '+
                             ','+INTTOSTR(TIPODEST)+' '+
                             ','+#39+TRIM(NUMBASTI)+#39+' '+
                             ','+#39+TRIM(NUMMOTOR)+#39+' '+
                             ','+INTTOSTR(NUMEJES)+' '+
                             ','+#39+TRIM(NCERTGNC)+#39+' '+
                             ','+#39+TRIM(PATENTEN)+#39+' '+
                             ','+#39+TRIM(PATENTEA)+#39+' '+
                             ','+#39+TRIM(TIPOGAS)+#39+' '+
                             ','+#39+TRIM(ERROR)+#39+' '+
                             ','+#39+TRIM(OFICIAL)+#39+' '+
                             ','+#39+TRIM(INYECCION)+#39+' '+
                             ','+INTTOSTR(CODEQUIGNC)+' '+
                             ','+INTTOSTR(plantapasa)+' '+
                             ')';
          END;

          IF (Existe = 0) THEN
             modulo.CONEXION.BeginTrans;
               TRY
                MEMO1.Lines.Add('IMPORTANDO VEHICULO: '+INTTOSTR(VEHICULO));
                RxTrayIcon1.HiNT:='IMPORTANDO VEHICULO: '+INTTOSTR(VEHICULO);
                APPLICATION.ProcessMessages;
                modulo.QUERY_WEB.Close;
                modulo.QUERY_WEB.SQL.Clear;
                modulo.QUERY_WEB.SQL.Add(QUERY_MSSQL);
                modulo.QUERY_WEB.ExecSQL;
                modulo.CONEXION.CommitTrans;
                //MEMO1.Lines.Add('TRANSACCION: OK');
                //APPLICATION.ProcessMessages;

           EXCEPT
             on E: Exception do
                      BEGIN
                         MEMO1.Lines.Add('TRANSACCION: ERROR');
                         APPLICATION.ProcessMessages;
                         modulo.CONEXION.RollbackTrans;
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| PLANTA '+INTTOSTR(plantapasa)+' NO SE INSERTO VEHICULO '+INTTOSTR(VEHICULO)+' POR :'+ E.message);
                      END;
           END;

         END ELSE
           BEGIN
               MEMO1.Lines.Add('Ya existe VEHICULO: '+INTTOSTR(VEHICULO));
               RxTrayIcon1.HiNT:='Ya existe VEHICULO: '+INTTOSTR(VEHICULO);
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

 //Application.MessageBox( 'PROCESO TERMINADO.', 'Atenci�n', MB_ICONINFORMATION );
 SHRINK_LOG;
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
HINT:='EXPORTANDO...';
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
