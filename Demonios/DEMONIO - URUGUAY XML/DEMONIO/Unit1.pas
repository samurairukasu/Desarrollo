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
  Codvehic,Codinspe,
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
  Internacional,Tacografo,
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

 function limpiar_variables:boolean;
  public
    { Public declarations }
    se_conector:BOOLEAN;
    BASE,centro:STRING;
    CITAS_CONECT:BOOLEAN;
    NOMPLANTA:STRING;
    ARCHIVO_LOG:STRING;
    Archivo_XML:STRING;
    Tabla:STRING;
    //oFilesList : TStringList;
    PROCEDURE TestOfBD(Alias, UserName, Password: String; Ageva: boolean);
    function conexion_virtual(base:string):boolean;
    function GUARDA_LOG(MENSAJE:STRING):BOOLEAN;
    PROCEDURE EJECUTAR;
    PROCEDURE GUARDARDATOS_TINSPECCION (Planta,Fecha,Ejercici,Codinspe,Codvehic,Codclpro,Codclcon,Codclten,Inspfina,Tipo,Fechalta,Codfrecu,FecVenci,
                                        Numoblea,Codfactu,HorFinal,HorentZ1,HorsalZ1,HorentZ2,HorSalZ2,HorentZ3,HorSalZ3,OBSERVAC,Resultad,Waspre,
                                        NumrevS1,NumlinS1,NumrevS2,NumlinS2,NumrevS3,NumlinS3,Codservicio,Enviado:STRING);
    PROCEDURE GUARDARDATOS_TVEHICULOS (Fechamatri,Aniofabr,Codmarca,Codmodel,Tipoespe,Tipodest,Numchasis,AnyoChasis,Numejes,Nummotor,PatenteN,PatenteA,
                                       Cola,Largo,Alto,Ancho,Tara,Codpais,Error,Internacional,Tacografo,Codpavehic,NroRegistro,Codtipocombustible,
                                       Codmarcachasis,Codmodelochasis,Tiporegistradoreventos,Codtiposuspension,Fechalta:STRING);
    PROCEDURE GUARDARDATOS_EJEDISTANCIA (Planta,Codinspe,Codvehic,Numejes,Cola,DPE,Numchasis,Disejes12,Disejes23,Disejes34,Disejes45,Disejes56,
                                         Numrevis,Fechalta,Disejes67,Disejes78,Disejes89,Alto,Ancho,Largo:STRING);
    PROCEDURE GUARDARDATOS_TDATINSPEVI (Planta,Ejercici,Codinspe,Secudefe,Numrevis,Numlinea,Numzona,Caddefec,Califdef,Ubicadef,OtrosDef,Fechalta:STRING);
    PROCEDURE GUARDARDATOS_DIMENSIONES_VEHICULOS (Planta,Ejercici,Codinspe,Codvehic,Largo,Alto,Ancho,Tara,PesoBruto,Fecha:STRING);
    PROCEDURE CARGAXMLS(Archivo_XML:String);
    PROCEDURE GetFileList(aFiles : TStringList; sPath : string; sMask : string = '*.*');
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

{ //SQL
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

conexion_virtual('db_web_uruguay'); //SQL
conexion_virtual(BASE);  //SQL
IF CITAS_CONECT=TRUE THEN BEGIN  //SQL
}
   begin
     MEMO1.Clear;
     //NOMPLANTA:=IntToStr(Planta);
     userbd:= 'CABASM';
     password:= '02lusabaqui03';
     TestOfBD(alias,userbd,password,false);

     if se_conector=true then

      BEGIN
        form1.Caption:='CONECTADO A '+ userbd;
        FORM1.HiNT:='CONECTADO A '+ userbd;
        RxTrayIcon1.HiNT:='CONECTADO A '+ userbd;
        APPLICATION.ProcessMessages;

        GetFileList(oFilesList,'C:\Argentin\MTOP\XML\','*.XML');
        IF Archivo_XML <> '' THEN BEGIN
           CARGAXMLS(Archivo_XML);
        END ELSE BEGIN
           EXIT;
        END;
      END;

   mybd.Close;
end;

//modulo.conexion.Close; //SQL

//END; //SQL

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

  Doc := LoadXMLDocument('C:\Argentin\MTOP\XML\'+Archivo_XML);
  Data := Doc.DocumentElement;
  for I := 0 to Data.ChildNodes.Count-1 do
  begin
    Node := Data.ChildNodes[I];
    // then this check can be removed...
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
    end else
    if Node.NodeName = 'TVehiculos' then
    begin
      Planta := Node.ChildNodes['Planta'].Text;
      Codvehic:=Node.ChildNodes['Codvehic'].Text;
      Fechamatri:=Node.ChildNodes['Fecmatri'].Text;
      Fechalta:=Node.ChildNodes['Fechalta'].Text;
      Aniofabr:=Node.ChildNodes['Aniofabr'].Text;
      Codmarca:=Node.ChildNodes['Codmarca'].Text;
      Codmodel:=Node.ChildNodes['Codmodel'].Text;
      Tipoespe:=Node.ChildNodes['Tipoespe'].Text;
      Tipodest:=Node.ChildNodes['Tipodest'].Text;
      Numchasis:=Node.ChildNodes['Numchasis'].Text;
      AnyoChasis:=Node.ChildNodes['AnyoChasis'].Text;
      Numejes:=Node.ChildNodes['Numejes'].Text;
      Nummotor:=Node.ChildNodes['Nummotor'].Text;
      PatenteN:=Node.ChildNodes['PatenteN'].Text;
      PatenteA:=Node.ChildNodes['PatenteA'].Text;
      Codtipocombustible:=Node.ChildNodes['Codtipocombustible'].Text;
      Codmarcachasis:=Node.ChildNodes['Codmarcachasis'].Text;
      Codmodelochasis:=Node.ChildNodes['Codmodelochasis'].Text;
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
    end;

  end;

IF Node.NodeName = 'Tinspeccion' THEN BEGIN
GUARDARDATOS_TINSPECCION(Planta,Fecha,Ejercici,Codinspe,Codvehic,Codclpro,Codclcon,Codclten,Inspfina,Tipo,Fechalta,Codfrecu,FecVenci,
                        Numoblea,Codfactu,HorFinal,HorentZ1,HorsalZ1,HorentZ2,HorSalZ2,HorentZ3,HorSalZ3,OBSERVAC,Resultad,Waspre,
                        NumrevS1,NumlinS1,NumrevS2,NumlinS2,NumrevS3,NumlinS3,Codservicio,Enviado);
CopyFile(PChar('C:\Argentin\MTOP\XML\'+Archivo_XML),PChar('C:\Argentin\MTOP\XML\BackUp\Tinspeccion\'+Archivo_XML),false);
DeleteFile(PChar('C:\Argentin\MTOP\XML\'+Archivo_XML));
END ELSE
IF Node.NodeName = 'TVehiculos' THEN BEGIN
GUARDARDATOS_TVEHICULOS(Fechamatri,Aniofabr,Codmarca,Codmodel,Tipoespe,Tipodest,Numchasis,AnyoChasis,Numejes,Nummotor,PatenteN,PatenteA,
                        Cola,Largo,Alto,Ancho,Tara,Codpais,Error,Internacional,Tacografo,Codpavehic,NroRegistro,Codtipocombustible,
                        Codmarcachasis,Codmodelochasis,Tiporegistradoreventos,Codtiposuspension,Fechalta);
CopyFile(PChar('C:\Argentin\MTOP\XML\'+Archivo_XML),PChar('C:\Argentin\MTOP\XML\BackUp\Tvehiculos\'+Archivo_XML),false);
DeleteFile(PChar('C:\Argentin\MTOP\XML\'+Archivo_XML));
END ELSE
IF Node.NodeName = 'Ejedistancia' THEN BEGIN
GUARDARDATOS_EJEDISTANCIA (Planta,Codinspe,Codvehic,Numejes,Cola,DPE,Numchasis,Disejes12,Disejes23,Disejes34,Disejes45,Disejes56,
                           Numrevis,Fechalta,Disejes67,Disejes78,Disejes89,Alto,Ancho,Largo);
CopyFile(PChar('C:\Argentin\MTOP\XML\'+Archivo_XML),PChar('C:\Argentin\MTOP\XML\BackUp\Ejedistancia\'+Archivo_XML),false);
DeleteFile(PChar('C:\Argentin\MTOP\XML\'+Archivo_XML));
END ELSE
IF Node.NodeName = 'Tdatinspevi' THEN BEGIN
GUARDARDATOS_TDATINSPEVI (Planta,Ejercici,Codinspe,Secudefe,Numrevis,Numlinea,Numzona,Caddefec,Califdef,Ubicadef,OtrosDef,Fechalta);
CopyFile(PChar('C:\Argentin\MTOP\XML\'+Archivo_XML),PChar('C:\Argentin\MTOP\XML\BackUp\Tdatinspevi\'+Archivo_XML),false);
DeleteFile(PChar('C:\Argentin\MTOP\XML\'+Archivo_XML));
END ELSE
IF Node.NodeName = 'Dimensiones_Vehiculos' THEN BEGIN
GUARDARDATOS_DIMENSIONES_VEHICULOS (Planta,Ejercici,Codinspe,Codvehic,Largo,Alto,Ancho,Tara,PesoBruto,Fecha);
CopyFile(PChar('C:\Argentin\MTOP\XML\'+Archivo_XML),PChar('C:\Argentin\MTOP\XML\BackUp\Dimensiones_Vehiculos\'+Archivo_XML),false);
DeleteFile(PChar('C:\Argentin\MTOP\XML\'+Archivo_XML));
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
        ParamByName('NroRegistro').Value := TRIM(NroRegistro);
        ParamByName('Codtipocombustible').Value := TRIM(Codtipocombustible);
        ParamByName('Codmarcachasis').Value := TRIM(Codmarcachasis);
        ParamByName('Codmodelochasis').Value := TRIM(Codmodelochasis);
        ParamByName('Tiporegistradoreventos').Value := TRIM(Tiporegistradoreventos);
        ParamByName('Codtiposuspension').Value := TRIM(Codtiposuspension);
        ParamByName('Fechalta').Value := TRIM(Fechalta);
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
 timer1.Interval:=5000; //5 segundos
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

END.
