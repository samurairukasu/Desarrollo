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
    FUNCTION ENVIAR_FACT_A_MSSQL(CODFACTU:longint;plantapasa:longint):BOOLEAN;
    FUNCTION ENVIAR_NC_A_MSSQL(NC:longint;plantapasa:longint):BOOLEAN;
    FUNCTION ENVIAR_TURNO_A_MSSQL(turno:longint;plantapasa:longint):BOOLEAN;
    FUNCTION ENVIAR_INSPECCION_A_MSSQL(CODINSPE:longint;plantapasa:longint):BOOLEAN;
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

procedure TForm1.EJECUTAR;
VAR
BASE,alias,userbd,password,link,FE:STRING;
archivo,LOG:textfile;
TURNOID,CODINSPE,CODFACTU,NC,planta,PLANTATURNO:longint;

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

       IF planta = 31 THEN BEGIN planta:=2; PLANTATURNO:=3 END;
       IF planta = 41 THEN BEGIN planta:=3; PLANTATURNO:=4 END;

       {Busco el ultimo Turno}
        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;
        modulo.QUERY_WEB.SQL.Add('SELECT MAX(TURNOID) FROM TDATOSTURNO WHERE PLANTA='+inttostr(PLANTATURNO));
        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.open;
        TURNOID:=modulo.QUERY_WEB.Fields[0].AsInteger;

        {Busco la ultima inspeccion}
        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;
        modulo.QUERY_WEB.SQL.Add('SELECT CASE WHEN MAX(TINS.CODINSPE) IS NULL THEN 0 ELSE MAX(TINS.CODINSPE) END '+
                                 'FROM TINSPECCION TINS LEFT OUTER JOIN TDATOSTURNO TDAT '+
                                 'ON TINS.CODINSPE = TDAT.CODINSPE WHERE TDAT.PLANTA='+inttostr(PLANTATURNO)+
                                 ' AND TINS.PLANTA = '+inttostr(PLANTATURNO));
        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.open;
        CODINSPE:=modulo.QUERY_WEB.Fields[0].AsInteger;

        {Busco la ultima factura}
        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;
        modulo.QUERY_WEB.SQL.Add('SELECT MAX(TFAC.CODFACTU) FROM TFACTURAS TFAC INNER JOIN TFACT_ADICION ADI '+
                                 'ON TFAC.CODFACTU = ADI.CODFACT WHERE ADI.PTOVENT='+inttostr(Planta));
        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.open;
        CODFACTU:=modulo.QUERY_WEB.Fields[0].AsInteger;

        {Busco la ultima NC}
        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;
        modulo.QUERY_WEB.SQL.Add('SELECT MAX(CODCOFAC) FROM TCONTRAFACT WHERE PLANTA ='+inttostr(Planta));
        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.open;
        NC:=modulo.QUERY_WEB.Fields[0].AsInteger;

        {Envia variables a Funciones}
        ENVIAR_FACT_A_MSSQL(CODFACTU,Planta);
        ENVIAR_NC_A_MSSQL(NC,Planta);
        ENVIAR_TURNO_A_MSSQL(TURNOID,Planta);
        ENVIAR_INSPECCION_A_MSSQL(CODINSPE,Planta);
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
QUERY_MSSQL,
QUERY_MSSQL2:string;

CODCLIEN,PTOVENT,IDUSUARI,codfact,Existe:longint;
FECHAFAC,TIPOFACTU,TIPTRIBU,FORMPAGO,IVA,IMPORTE,
NUMFACTU,IDDETALLESPAGO,CODCOFAC,TIPOFAC:STRING;

BEGIN

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
                'WHERE CODFACTU >' +inttostr(CODFACTU)+
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
        NUMFACTU:=TRIM(FIELDBYNAME('numfactu').ASSTRING);
        CODCOFAC:=TRIM(FIELDBYNAME('codcofac').ASSTRING);
        IDDETALLESPAGO:=TRIM(FIELDBYNAME('iddetallespago').ASSTRING);

        {Tfact_Adicion}
        codfact:=FIELDBYNAME('codfact').ASINTEGER;
        TIPOFAC:=TRIM(FIELDBYNAME('TIPOFAC').ASSTRING);
        PTOVENT:=FIELDBYNAME('PTOVENT').ASINTEGER;
        IDUSUARI:=FIELDBYNAME('IDUSUARI').ASINTEGER;

        modulo.QUERY_WEB.Close;
        modulo.QUERY_WEB.SQL.Clear;
        modulo.QUERY_WEB.SQL.Add('SELECT COUNT(*) FROM TFACTURAS WHERE CODFACTU='+inttostr(CODFACTU));
        modulo.QUERY_WEB.ExecSQL;
        modulo.QUERY_WEB.Open;
        Existe:=modulo.QUERY_WEB.Fields[0].AsInteger;

        IF (Existe = 0) THEN
          BEGIN
                QUERY_MSSQL:='INSERT INTO TFACTURAS (codfactu,fechalta,tipfactu,tiptribu,formpago,ivainscr,codclien,imponeto,numfactu,codcofac,iddetallespago) '+
                             ' VALUES ('+INTTOSTR(CODFACTU)+','+#39+TRIM(FECHAFAC)+#39+','+#39+TRIM(TIPOFACTU)+#39+','+#39+TRIM(TIPTRIBU)+#39+
                             ','+#39+TRIM(FORMPAGO)+#39+','+#39+TRIM(IVA)+#39+','+INTTOSTR(CODCLIEN)+
                             ','+#39+TRIM(IMPORTE)+#39+','+#39+TRIM(NUMFACTU)+#39+','+#39+TRIM(NUMFACTU)+#39+','+#39+TRIM(IDDETALLESPAGO)+#39+')';

                QUERY_MSSQL2:='INSERT INTO TFACT_ADICION (codfact,TIPOFAC,ptovent,idusuari) '+
                              ' VALUES ('+INTTOSTR(codfact)+','+#39+TRIM(TIPOFAC)+#39+','+INTTOSTR(ptovent)+','+INTTOSTR(idusuari)+')';

          //END ELSE BEGIN END;

          IF (Existe = 0) THEN
             modulo.CONEXION.BeginTrans;
               TRY
                MEMO1.Lines.Add('ACTUALIZANDO FAC: '+INTTOSTR(CODFACTU));
                RxTrayIcon1.HiNT:='ACTUALIZANDO FAC: '+INTTOSTR(CODFACTU);
                APPLICATION.ProcessMessages;
                modulo.QUERY_WEB.Close;
                modulo.QUERY_WEB.SQL.Clear;
                modulo.QUERY_WEB.SQL.Add(QUERY_MSSQL);
                modulo.QUERY_WEB.SQL.Add(QUERY_MSSQL2);
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

         END ELSE
           BEGIN
               MEMO1.Lines.Add('Ya existe FAC: '+INTTOSTR(CODFACTU));
               RxTrayIcon1.HiNT:='Ya existe FAC: '+INTTOSTR(CODFACTU);
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

 //Application.MessageBox( 'PROCESO TERMINADO.', 'Atenci�n',
 // MB_ICONINFORMATION );

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
        SQL.Add('SELECT '+
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
                              ' VALUES ('+INTTOSTR(CodCoFacNC)+' '+
                              ','+#39+TRIM(FECHANC)+#39+' '+
                              ','+INTTOSTR(NumNC)+' '+
                              ','+#39+TRIM(CaeNC)+#39+' '+
                              ','+#39+TRIM(VenceCaeNc)+#39+' '+
                              ','+INTTOSTR(plantapasa)+' '+
                              ')';

            IF (Existe = 0) THEN
             modulo.CONEXION.BeginTrans;
               TRY
                MEMO1.Lines.Add('ACTUALIZANDO NC: '+INTTOSTR(CodCoFacNC));
                RxTrayIcon1.HiNT:='ACTUALIZANDO NC: '+INTTOSTR(CodCoFacNC);
                APPLICATION.ProcessMessages;
                modulo.QUERY_WEB.Close;
                modulo.QUERY_WEB.SQL.Clear;
                modulo.QUERY_WEB.SQL.Add(QUERY_MSSQL);
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

 //Application.MessageBox( 'PROCESO TERMINADO.', 'Atenci�n',
 // MB_ICONINFORMATION );

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
        SQL.Add('SELECT '+
                'TURNOID'+
                ',FECHATURNO '+
                ',TIPOTURNO '+
                ',DVDOMINO '+
                ',AUSENTE '+
                ',FACTURADO '+
                ',REVISO '+
                ',CODINSPE '+
                ',CODVEHIC '+
                ',CODCLIEN '+
                ',PAGOIDVERIFICACION '+
                ',TIPOINSPE '+
                ',PLANTA '+
                'FROM TDATOSTURNOHISTORIAL '+
                'WHERE TURNOID >' +inttostr(turno)+
                ' ORDER BY TURNOID');
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
         modulo.QUERY_WEB.SQL.Add('SELECT COUNT(*) FROM TDATOSTURNO WHERE TURNOID='+inttostr(TURNOID)+
                                  ' AND PLANTA ='+inttostr(plantapasa));
         modulo.QUERY_WEB.ExecSQL;
         modulo.QUERY_WEB.Open;
         Existe:=modulo.QUERY_WEB.Fields[0].AsInteger;
           
         IF (Existe = 0) THEN
            BEGIN
                 QUERY_MSSQL:='INSERT INTO TDATOSTURNO (TURNOID,CODINSPE,CODVEHIC,CODCLIEN,FECHATURNO, '+
                              ' TIPOTURNO,PATENTE,AUSENTE,FACTURADO,REVISO,PAGOIDVERIFICACION,PLANTA,TIPOINSPE) '+
                              ' VALUES ('+INTTOSTR(TURNOID)+','+#39+TRIM(CODINSPE)+#39+','+INTTOSTR(CODVEHIC)+','+INTTOSTR(CODCLIEN)+' '+
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
                MEMO1.Lines.Add('ACTUALIZANDO TURNO: '+INTTOSTR(TURNOID));
                RxTrayIcon1.HiNT:='ACTUALIZANDO TURNO: '+INTTOSTR(TURNOID);
                APPLICATION.ProcessMessages;
                modulo.QUERY_WEB.Close;
                modulo.QUERY_WEB.SQL.Clear;
                modulo.QUERY_WEB.SQL.Add(QUERY_MSSQL);
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

 //Application.MessageBox( 'PROCESO TERMINADO.', 'Atenci�n',
 // MB_ICONINFORMATION );

END;

FUNCTION TFORM1.ENVIAR_INSPECCION_A_MSSQL(CODINSPE:longint;plantapasa:longint):BOOLEAN;
var
QUERY_MSSQL:string;

Existe:longint;
FECHAINSP,TIPO,
EJERCICI,INSPECCION,CODVEHIC,
CODCLPRO,CODCLCON,CODCLTEN,
INSPFINA,NUMOBLEA,RESULTAD:String;

BEGIN
{Busco Inspecciones nuevas}
with tsqlQuery.Create(nil) do
    try
        SQLConnection:= MYBD;
        SQL.Add('SELECT '+
                'EJERCICI '+
                ',CODINSPE '+
                ',CODVEHIC '+
                ',CODCLPRO '+
                ',CODCLCON '+
                ',CODCLTEN '+
                ',INSPFINA '+
                ',TIPO '+
                ',FECHALTA '+
                ',NUMOBLEA '+
                ',RESULTAD '+
                'FROM TINSPECCION '+
                'WHERE CODINSPE > ' +IntToStr(CODINSPE)+
                ' ORDER BY CODINSPE');

        Open;

        WHILE NOT EOF DO

        BEGIN
        EJERCICI:=TRIM(FIELDBYNAME('EJERCICI').ASSTRING);
        INSPECCION:=TRIM(FIELDBYNAME('CODINSPE').ASSTRING);
        CODVEHIC:=TRIM(FIELDBYNAME('CODVEHIC').ASSTRING);
        CODCLPRO:=TRIM(FIELDBYNAME('CODCLPRO').ASSTRING);
        CODCLCON:=TRIM(FIELDBYNAME('CODCLCON').ASSTRING);
        CODCLTEN:=TRIM(FIELDBYNAME('CODCLTEN').ASSTRING);
        INSPFINA:=TRIM(FIELDBYNAME('INSPFINA').ASSTRING);
        TIPO:=TRIM(FIELDBYNAME('TIPO').ASSTRING);
        FECHAINSP:=TRIM(FIELDBYNAME('FECHALTA').ASSTRING);
        NUMOBLEA:=TRIM(FIELDBYNAME('NUMOBLEA').ASSTRING);
        RESULTAD:=TRIM(FIELDBYNAME('RESULTAD').ASSTRING);

         modulo.QUERY_WEB.Close;
         modulo.QUERY_WEB.SQL.Clear;
         modulo.QUERY_WEB.SQL.Add('SELECT COUNT(*) FROM TINSPECCION WHERE CODINSPE='+#39+TRIM(INSPECCION)+#39+
                                  ' AND PLANTA ='+inttostr(plantapasa));
         modulo.QUERY_WEB.ExecSQL;
         modulo.QUERY_WEB.Open;
         Existe:=modulo.QUERY_WEB.Fields[0].AsInteger;

         IF (Existe = 0) THEN
            BEGIN
                 QUERY_MSSQL:='INSERT INTO TINSPECCION (EJERCICI,CODINSPE,CODVEHIC,CODCLPRO,CODCLCON, '+
                              'CODCLTEN,INSPFINA,TIPO,FECHALTA,NUMOBLEA,RESULTAD,PLANTA )'+
                              ' VALUES ('+
                              ''+#39+TRIM(EJERCICI)+#39+' '+
                              ','+#39+TRIM(INSPECCION)+#39+' '+
                              ','+#39+TRIM(CODVEHIC)+#39+' '+
                              ','+#39+TRIM(CODCLPRO)+#39+' '+
                              ','+#39+TRIM(CODCLCON)+#39+' '+
                              ','+#39+TRIM(CODCLTEN)+#39+' '+
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
                MEMO1.Lines.Add('ACTUALIZANDO INSPECCION: '+TRIM(INSPECCION));
                RxTrayIcon1.HiNT:='ACTUALIZANDO INSPECCION: '+TRIM(INSPECCION);
                APPLICATION.ProcessMessages;
                modulo.QUERY_WEB.Close;
                modulo.QUERY_WEB.SQL.Clear;
                modulo.QUERY_WEB.SQL.Add(QUERY_MSSQL);
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
                         GUARDA_LOG(DATETOSTR(DATE)+'|'+TIMETOSTR(TIME)+'| PLANTA '+INTTOSTR(plantapasa)+' NO SE INSERTO INSPECCION '+TRIM(INSPECCION)+' POR :'+ E.message);
                      END;
          END;

      END ELSE
           BEGIN
               MEMO1.Lines.Add('Ya existe INSPECCION: '+TRIM(INSPECCION));
               RxTrayIcon1.HiNT:='Ya existe INSPECCION: '+TRIM(INSPECCION);
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
