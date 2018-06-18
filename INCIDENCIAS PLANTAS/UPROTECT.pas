unit UProtect;

interface
  uses
    Windows,
    SysUtils;

CONST

    {Formato de presentación de las licencias}
    FORMATOLICENCIA='00-000-0000-000-000000-00000-000000-000-00';

type
    tLicencia = (lDesconocida,lServidor, lCentral, lAplicacion, lLicencias);
    TTipoCodigo=(tcDesconocido,tcPrelicencia,tcLicencia,tcDesinstalacion);

function DateBios : TDateTime;
function VolHD : DWORD;
function VolHD_HardWay : DWORD;
Function DateValue(fecha,Formato:string):Integer;

function ObtenerNumeroSecreto:Integer;
procedure BorrarNumeroSecreto;
procedure CambiarNumeroSecreto(n:Integer);

procedure ObtenerDatosControl(var lNSerie, lDateBios, lSecreto : Longint);

Function ObtenerVersion:Integer;

FUNCTION EncriptaPreregistro (Vol,Fech,secr:longint) : string;
{$IFDEF GESTOR_LICENCIAS}
PROCEDURE DesencriptaPreregistro(cadena:string;VAR Vol,Fech,secr:longint);
{$ENDIF}

Function EncriptaDesinstalacion(Vol,Fech,secreto:longint):string;
{$IFDEF GESTOR_LICENCIAS}
procedure DesencriptaDesinstalacion(cadena:string; VAR vol,fech,secreto:longint);
{$ENDIF}

{$IFDEF GESTOR_LICENCIAS}
Function EncriptaLicencia(Vol,Fech,secreto,NumLic,Concedido,quien,Version:longint;tipo:tLicencia;iIndice:integer):string;
Function ObtenerIndice:Integer;
{$ENDIF}
procedure DesencriptaLicencia(cadena:string; VAR vol,fech,secreto,NumLic,Concedido,Quien,Version:longint;tipo:tLicencia);

Function TipoCodigo(s:string):TTipoCodigo;
Function TipoLicencia(s:string):TLicencia;
Function FormateaCodigo(codigo,formato:string):string;
function QuitaSimbolos (const  s: string) : string;

function HayLicencia(const sLicencia:string;const lTipo:tLicencia):Boolean;

implementation

uses
    Forms,
    UCDIALGS,
    USUPERREGISTRY,
    UVERSION;

TYPE
  tMediaType = (
    Unknown,                // Format is unknown
    F5_1Pt2_512,            // 5.25", 1.2MB,  512 bytes/sector
    F3_1Pt44_512,           // 3.5",  1.44MB, 512 bytes/sector
    F3_2Pt88_512,           // 3.5",  2.88MB, 512 bytes/sector
    F3_20Pt8_512,           // 3.5",  20.8MB, 512 bytes/sector
    F3_720_512,             // 3.5",  720KB,  512 bytes/sector
    F5_360_512,             // 5.25", 360KB,  512 bytes/sector
    F5_320_512,             // 5.25", 320KB,  512 bytes/sector
    F5_320_1024,            // 5.25", 320KB,  1024 bytes/sector
    F5_180_512,             // 5.25", 180KB,  512 bytes/sector
    F5_160_512,             // 5.25", 160KB,  512 bytes/sector
    RemovableMedia,         // Removable media other than floppy
    FixedMedia,             // Fixed hard disk media
    F3_120M_512             // 3.5", 120M Floppy
    );

  TDISK_GEOMETRY = PACKED RECORD
                                Cylinders : LongInt;
                                MediaType : tMediaType;
                                TracksPerCylinder : Dword;
                                SectorsPerTrack : DWord;
                                BytesPerSector : DWord;
                   END;

  PDISK_GEOMETRY = ^TDISK_GEOMETRY;

  CONST
       TOPE_CLAVE = 13;

       FILE_DEVICE_DISK =        $00000007;
       FILE_DEVICE_FILE_SYSTEM = $00000009;
       IOCTL_DISK_BASE = FILE_DEVICE_DISK;
       METHOD_BUFFERED = 0;
       FILE_ANY_ACCESS = 0;

       IOCTL_DISK_GET_DRIVE_GEOMETRY = (IOCTL_DISK_BASE SHL 16) OR (FILE_ANY_ACCESS SHL 14) OR (6 SHL 0) OR (METHOD_BUFFERED);
       FSCTL_LOCK_VOLUME = (FILE_DEVICE_FILE_SYSTEM SHL 16) OR (FILE_ANY_ACCESS SHL 14) OR (6 SHL 2) OR (METHOD_BUFFERED);
       FSCTL_UNLOCK_VOLUME = (FILE_DEVICE_FILE_SYSTEM SHL 16) OR (FILE_ANY_ACCESS SHL 14) OR (7 SHL 2) OR (METHOD_BUFFERED);

CONST
    FICHERO_ACTUAL = 'UProtect.pas';
    RUTA_SECRETA='\SOFTWARE\Borland\Database Engine';
    IDENT_SECRETO='DRJ';

    {Letras validas para una licencia}
    LETRASVALIDAS=['0'..'9','A'..'Z','a'..'z'];

    {Sistema de encriptación de licencia}
    N = ord('Z')-ord('A')+1;
    CLAVE_APLICACION = 'NERTEYNASLGXNRAX'; //'33DA5D4FCF0A97';
    CLAVE_CENTRAL    = 'BOASRUPBLWCZJDHL'; //23C7492B817F5A';
    CLAVE_SERVIDOR   = 'ORLBJYENCINDSZAE'; //'ACB96D1BE305DF';
    CLAVE_LICENCIAS  = 'IRGAAMRNIHEINAED';

    {Sistema de encriptación de prelicencia}
    C1=52845;
    C2=22719;
    CLAVE=9713;
    CLAVED=3317;
    CLAVEL=5129;

    NDIGITOS=9;
    NJUEGOS=2;
    Letras:ARRAY[0..NJUEGOS-1,0..15] OF Char=('ZACSDBFXHJRLNUYP',
                                              '9M745632G0KTE8W1');
    LETRADESINS='D';
    LETRAPRELIC='P';
    LETRAAPLICA='A';
    LETRACENTRA='C';
    LETRASERVID='S';
    LETRALICENC='L';

    {Tamaño de los códigos de licencia en caracteres}
    TAMANO_LICENCIA=18;  //Numero de caracteres de una licencia
    TAMANO_PRELICENCIA=19;  //Numero de caracteres de una prelicencia
    TAMANO_DESINSTALACION=20;  //Numero de caracteres de una desinstalación

const
     CLAVE_REFERENCIAS : packed array [0..9] of char = 'LJUIHGPMZO'; //Letras a partir de la G


function Quitar(const s: string; const c: char) : string;
var
  i : integer;
begin
     Result:='';
     FOR i:=1 TO Length(s) DO
         IF s[i]<>c THEN Result:=Result+s[i]
end;

function QuitaSimbolos (const  s: string) : string;
var
  i : integer;
begin
  Result:='';
  for i:=1 to Length(s) do
      if s[i] in LETRASVALIDAS then Result:=Result+s[i];
end;

function Ajusta (const s: string) : string;
var
   i:Integer;
begin
     result := '';
     for i := 1 to length(s) do
         if s[i] in ['0'..'9']
            then result := result + CLAVE_REFERENCIAS[StrToInt(s[i])]
            else result := result + s[i]
end;

function Desajusta (const s: string) : string;
var
   i,j : Integer;
begin
     result := '';
     for i := 1 to length(s) do
     begin
          j:=Pos(s[i],CLAVE_REFERENCIAS);
          if j>0
             then result:=result+chr(ord('0')+j-1)
             else result:=result+s[i]
     end
end;

Function LetraLicencia(aTipo:tLicencia):char;
BEGIN
     Case aTipo OF
          lServidor:Result:=LETRASERVID;
          lCentral:Result:=LETRACENTRA;
          lAplicacion:Result:=LETRAAPLICA;
          lLicencias:Result:=LETRALICENC
          ELSE Result:='X'
     END
END;

function EncriptaLicenciaI(const sMensaje:string;aTipo:tLicencia;const iIndice:integer):string;
var
   sCifrado:string;
   Paso: integer;
begin
    case aTipo of
         lServidor   :sCifrado:=CLAVE_SERVIDOR;
         lCentral    :sCifrado:=CLAVE_CENTRAL;
         lAplicacion :sCifrado:=CLAVE_APLICACION;
         lLicencias  :sCifrado:=CLAVE_LICENCIAS;
    end;
    result := LetraLicencia(aTipo)+chr(ord('A')+iIndice);

    for Paso:=1 to length(sMensaje) do
        result:=result+chr((ord(sMensaje[Paso])+
                             ord(sCifrado[((Paso+iIndice) mod (Length(sCifrado)))+1])
                            ) mod N +ord('A'))
end;

function DesEncriptaLicenciaI (sMensaje: string; aTipo: tLicencia ) : string;
var
   sCifrado:string;
   Indice,Paso,i:integer;
   c:char;
begin
     result:='';
     IF Length(sMensaje)<3 THEN exit;
     sCifrado:='';
     sMensaje := UpperCase(QuitaSimbolos(sMensaje));
     case aTipo of
          lServidor  :sCifrado:=CLAVE_SERVIDOR;
          lCentral   :sCifrado:=CLAVE_CENTRAL;
          lAplicacion:sCifrado:=CLAVE_APLICACION;
          lLicencias:sCifrado:=CLAVE_LICENCIAS
          ELSE raise Exception.Create('Código de licencia incorrecto')
     end;

     c := sMensaje[2];
     sMensaje := copy(sMensaje,3,length(sMensaje)-2);
     Indice := ord(c) - ord('A');

     for Paso := 1 to length(sMensaje)  do
     begin
          i:=ord(sMensaje[Paso])-ord(sCifrado[((Paso+Indice) mod (Length(sCifrado)))+1]);
          if i>=0
             then result:=result+chr(i+ord('A'))
             else result:=result+chr(i+N+ord('A'));
     end
end;

function DateBios:TDateTime;
VAR
   DosVersion :  TOSVersionInfo;
   MiRegistro : TSuperRegistry;
   sAntiguoFormato:string;
begin
     Result:=0;
     sAntiguoFormato := ShortDateFormat;
     ShortDateFormat:='mm/dd/yy';
     try
        DosVersion.dwOsVersionInfoSize := SizeOf(DOSVersion);
        IF GetVersionEx(DosVersion)
           THEN CASE DosVersion.dwPlatformId OF
                     VER_PLATFORM_WIN32_WINDOWS:Result:=StrToDate(Pchar(Pointer($FFFF5)));
                     VER_PLATFORM_WIN32_NT:BEGIN
                                                MiRegistro:=TSuperRegistry.Create;
                                                try
                                                   MiRegistro.RootKey := HKEY_LOCAL_MACHINE;
                                                   IF MiRegistro.OpenKeyRead('\HARDWARE\DESCRIPTION\System')
                                                      THEN Result:=StrToDate(MiRegistro.ReadString('SystemBiosDate'))
                                                      ELSE Exception.Create('Error path registro desconocido');
                                                finally
                                                       MiRegistro.free
                                                end
                                           END
                END
           ELSE raise Exception.Create('Error version desconocida');
     finally
            ShortDateFormat:=sAntiguoFormato
     end
end;

procedure ObtenerDatosControl(var lNSerie, lDateBios, lSecreto : Longint);
begin
    lNSerie:=VolHD;
    lDateBios:=Trunc(DateBios);
    lSecreto:=ObtenerNumeroSecreto
end;

function VolHD:DWORD;
var
   dwMaximunComponentLength:DWORD;
   dwFileSystemFlags:DWORD;
   OldErrorMode:DWORD;
   nserie:DWORD;
   DirWin:string;
begin
     Result:=0;
     OldErrorMode:=SetErrorMode(SEM_FAILCRITICALERRORS);
     try
        SetLength(DirWin,MAX_PATH);
        GetWindowsDirectory(PChar(DirWin),MAX_PATH);
        IF NOT GetVolumeInformation(Pchar(copy(DirWin,1,3)),
                               nil,0,@nSerie,dwMaximunComponentLength,
                               dwFileSystemFlags,nil,0)
           THEN raise Exception.Create('No se leyó serie');
        Result:=nSerie
    finally
           SetErrorMode(OldErrorMode)
    end
end;

function VolHD_HardWay:DWORD;
var
   hDispositivo:tHandle;
//   nLeidos:integer;   MODI MIGRA
   nLeidos : cardinal;
   NDevueltos:dword;
   GDisco:PDISK_GEOMETRY;
   nSerie:DWORD;
begin
   GDisco := nil;
   hDispositivo:=CreateFile('\\.\vwin32'{'\\.\PhysicalDrive0'}, 0, FILE_SHARE_READ  or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
   if hDispositivo =  INVALID_HANDLE_VALUE
      then raise Exception.CreateFmt('Error al Crear el dispositivo por %d',[GetLastError])
      else if DeviceIOControl(hDispositivo, 1{IOCTL_DISK_GET_DRIVE_GEOMETRY},nil,0,GDisco,sizeof(GDisco^),NDevueltos,nil)
           //if DeviceIOControl (hDispositivo,FSCTL_LOCK_VOLUME, nil,0,nil,0,dword(nil^),nil)
              then try
                      if SetFilePointer (hDispositivo,39,nil,FILE_BEGIN) = $FFFFFFFF
                         then raise Exception.CreateFmt('Error al posicionarase sobre el dispositivo por %d',[GetLastError]);
                      if not ReadFile(hDispositivo, nSerie, sizeOf(nSerie), nleidos, nil)
                         then raise Exception.CreateFmt('Error a leer del dispositivo por %d',[GetLastError]);
                   finally
                          if not DeviceIOControl(hDispositivo,FSCTL_UNLOCK_VOLUME,nil,0,nil,0,nDevueltos,nil)
                             then MessageDlg('Error','PROGRAMA INESTABLE, REINICIE WINDOWS',mtError, [mbOk], mbOk, 0);
                   end
      else raise Exception.CreateFmt('Error al bloquear el dispositivo por %d',[GetLastError]);
   Result:=nSerie
end;

function ObtenerNumeroSecreto:Integer;
VAR
    Reg:TSuperRegistry;
begin
     Reg:=TSuperRegistry.Create;
     try
        Reg.RootKey:=HKEY_LOCAL_MACHINE;
        if Reg.OpenKeyRead(RUTA_SECRETA)
           then try
                   Result:=Reg.ReadInteger(IDENT_SECRETO)
                except
                      Result:=0
                end
           ElSE Result:=0
     finally
            Reg.Free
     end
end;

procedure BorrarNumeroSecreto;
VAR
    Reg:TSuperRegistry;
begin
      Reg:=TSuperRegistry.Create;
      try
         Reg.RootKey:=HKEY_LOCAL_MACHINE;
         if Reg.OpenKeySec(RUTA_SECRETA,False,KEY_SET_VALUE)
            then Reg.DeleteValue(IDENT_SECRETO)
      finally
             Reg.Free
      end
end;

procedure CambiarNumeroSecreto(n:Integer);
VAR
    Reg:TSuperRegistry;
begin
     Reg:=TSuperRegistry.Create;
     try
        Reg.RootKey:=HKEY_LOCAL_MACHINE;
        if Reg.OpenKeySec(RUTA_SECRETA,False,KEY_SET_VALUE)
           then Reg.WriteInteger(IDENT_SECRETO,n)
           else raise Exception.Create('Registro bloqueado')
     finally
            Reg.Free
     end
end;

function NumeroSecreto(VAR nsecre:dword;Forzar:Boolean):Boolean;
VAR
    Reg:TSuperRegistry;
begin
      Result:=True;
      Reg:=TSuperRegistry.Create;
      try
         Reg.RootKey:=HKEY_LOCAL_MACHINE;
         if Reg.OpenKey(RUTA_SECRETA,False)
            then BEGIN
                      try
                         nsecre:=Reg.ReadInteger(IDENT_SECRETO)
                      except
                            Forzar:=True
                      end;
                      IF Forzar
                         THEN BEGIN
                                   nsecre:=1+Random(65535);
                                   Reg.WriteInteger(IDENT_SECRETO,nsecre)
                              END
                 END
            else Result:=False
      except
            Result:=False
      end;
      Reg.Free
end;

procedure BorraSecreto;
VAR
    Reg:TSuperRegistry;
    ns:Integer;
BEGIN
      Reg:=TSuperRegistry.Create;
      try
         Reg.RootKey:=HKEY_LOCAL_MACHINE;
         IF Reg.OpenKey(RUTA_SECRETA,False)
            THEN BEGIN
                      ns:=Reg.ReadInteger(IDENT_SECRETO);
                      IF ns>0 THEN Reg.WriteInteger(IDENT_SECRETO,-ns)
                 END
            ELSE raise Exception.Create('Registro bloqueado')
      finally
             Reg.Free
      end
END;

TYPE
    BLong=PACKED ARRAY[0..3] OF Byte;

FUNCTION ValorToLetra(v:byte;juego:Integer):char;
BEGIN
     juego:=juego MOD NJUEGOS;
     Result:=Letras[juego,v]
END;

FUNCTION LetraToValor(c:char):byte;
VAR
   i,j:integer;
BEGIN
     c:=Upcase(c);
     FOR i:=0 TO 15 DO
         FOR j:=0 TO NJUEGOS -1 DO
             IF c=Letras[j,i]
                THEN BEGIN
                          Result:=i;
                          exit
                      END;
      raise Exception.Create('Letra incorrecta en clave')
END;

FUNCTION EncriptaT(s:string;inikey,nj:word):string;
VAR
   Key:word;
   b,ob:byte;
   i:Integer;
BEGIN
     {Encripta la cadena obtenida}
     Key:=inikey;
     FOR i:=1 TO Length(S) DO
     BEGIN
          s[i]:=char(byte(s[i]) XOR (Key SHR 8));
          Key:=(byte(s[i])+Key)*C1+C2
     END;
     Result:='';
     ob:=0;
     FOR i:=1 TO Length(s) DO
     BEGIN
          b:=byte(s[i]);
          Result:=Result+ValorToLetra(b AND $0f,(ob AND $0f) MOD nj)+ValorToLetra(b SHR 4,(ob SHR 4) MOD nj);
          ob:=b
     END;
     {Añade letra de control}
     Result:=Result+ValorToLetra((Key SHR 8) AND $0F,ob MOD nj)
END;

Function DesencriptaT(cadena:string;inikey:word):string;
VAR
   Key:word;
   b:byte;
   s:string;
   i:Integer;
BEGIN
     s:='';
     FOR i:=1 TO (Length(cadena)-1) DIV 2 DO
     BEGIN
          b:=LetraToValor(cadena[2*i-1])+(LetraToValor(Cadena[2*i]) SHL 4);
          s:=s+Chr(b)
     END;
     {Desencripta la cadena}
     Key:=inikey;
     FOR i:=1 TO Length(S) DO
     BEGIN
          b:=byte(s[i]);
          s[i]:=char(b XOR (Key SHR 8));
          Key:=(b+Key)*C1+C2
     END;
 {    IF (Length(Cadena) = 0 ) OR (((Key Shr 8) AND $0f)<>LetraToValor(cadena[Length(cadena)]))
        THEN raise Exception.Create('Letra de control incorrecta')
        ELSE} Result:=s
END;

Function ExtraeValor(s:string; Tam:Integer; VAR Posic:Integer):Integer;
VAR
   i:Integer;
BEGIN
     Result:=0;
     FOR i:=0 TO Tam-1 DO
     begin
      if s<>'' then
         blong(Result)[i]:=byte(s[i+Posic]);
     end;
     Inc(Posic,Tam)
END;

Procedure IntroduceValor(VAR s:string; Tam,Valor:Integer);
VAR 
   i:Integer;
BEGIN
     FOR i:=0 TO Tam-1 DO
         s:=s+chr(blong(Valor)[i])
END;

FUNCTION EncriptaPreregistro (Vol,Fech,secr:longint) : string;
VAR
   s:string;
begin
     {Forma un string concatenando el número secreto (2 bytes) con el entero que contiene
     la etiqueta de volumen y con la fecha (tres bytes)}
     s:='';
     IntroduceValor(s,2,secr);
     IntroduceValor(s,4,vol);
     IntroduceValor(s,3,Fech);
     Result:=LETRAPRELIC+EncriptaT(s,CLAVE,NJUEGOS)
end;

{$IFDEF GESTOR_LICENCIAS}
PROCEDURE DesencriptaPreregistro(cadena:string;VAR Vol,Fech,secr:longint);
VAR
   s:string;
   i:Integer;
begin
     IF (Length(cadena)>0) AND (cadena[1]=LETRAPRELIC)
        THEN BEGIN
                  s:=DesencriptaT(Copy(cadena,2,Length(cadena)-1),CLAVE);
                  i:=1;
                  Secr:=ExtraeValor(s,2,i);
                  Vol:=ExtraeValor(s,4,i);
                  Fech:=ExtraeValor(s,3,i)
             END
        ELSE raise Exception.Create('Código de preregistro incorrecto')
end;
{$ENDIF}

Function EncriptaDesinstalacion(Vol,Fech,secreto{,NumLic,Concedido,quien,Version}:longint):string;
VAR
   s:String;
begin
     s:='';
     IntroduceValor(s,2,secreto);
     IntroduceValor(s,4,Vol);
     IntroduceValor(s,3,Fech);
     {IntroduceValor(s,2,NumLic);
     IntroduceValor(s,3,Concedido);
     IntroduceValor(s,1,Quien);
     IntroduceValor(s,1,Version);}
     Result:=LETRADESINS+EncriptaT(s,CLAVED,NJUEGOS)
end;

{$IFDEF GESTOR_LICENCIAS}
procedure DesencriptaDesinstalacion(cadena:string; VAR vol,fech,secreto{,NumLic,Concedido,Quien,Version}:longint);
VAR
   s:string;
   i:Integer;
begin
     IF (Length(cadena)>0) AND (cadena[1]=LETRADESINS)
        THEN BEGIN
                  s:=DesencriptaT(Copy(cadena,2,Length(cadena)-1),CLAVED);
                  i:=1;
                  Secreto:=ExtraeValor(s,2,i);
                  Vol:=ExtraeValor(s,4,i);
                  Fech:=ExtraeValor(s,3,i);
                  {NumLic:=ExtraeValor(s,2,i);
                  Concedido:=ExtraeValor(s,3,i);
                  Quien:=ExtraeValor(s,1,i);
                  Version:=ExtraeValor(s,1,i)}
             END
        ELSE raise Exception.Create('Código de desinstalación incorrecto')
end;
{$ENDIF}

{$IFDEF GESTOR_LICENCIAS}
Procedure IntroduceValorLicencia(VAR s:string;long,Val:Integer);
VAR
   ts:string;
BEGIN
     ts:=IntToHex(Val,Long);
     s:=s+Copy(ts,1,Long)
END;

Function EncriptaLicencia(Vol,Fech,secreto,NumLic,Concedido,quien,Version:longint;tipo:tLicencia;iIndice:integer):string;
VAR
   d:Integer;
   s:string;
begin
     Result:='';
     s:='';
     IntroduceValor(s,2,Secreto);
     IntroduceValor(s,4,Vol);
     IntroduceValor(s,2,NumLic);
     IntroduceValor(s,3,Concedido);
     IntroduceValor(s,1,Quien);
     IntroduceValor(s,1,Version);
     IntroduceValor(s,3,Fech);
     s:=EncriptaT(s,CLAVEL,1);
     Result:=EncriptaLicenciaI(s,tipo,iIndice)
end;
{$ENDIF}

Function ExtraeValorLicencia(VAR s:string;Long:Integer):Integer;
BEGIN
     IF s=''
        THEN Result:=0
        ELSE BEGIN
                  IF Long>Length(s) THEN Long:=Length(s);
                  Result:=StrToInt('$'+Copy(s,1,Long));
                  Delete(s,1,Long)
             END
END;

procedure DesencriptaLicencia(cadena:string; VAR vol,fech,secreto,NumLic,Concedido,Quien,Version:longint;tipo:tLicencia);
VAR
   s:string;
   i:Integer;
begin
     s:=DesencriptaLicenciaI(cadena,tipo);
     s:=DesencriptaT(s,CLAVEL);
     i:=1;
     Secreto:=ExtraeValor(s,2,i);
     Vol:=ExtraeValor(s,4,i);
     NumLic:=ExtraeValor(s,2,i);
     Concedido:=ExtraeValor(s,3,i);
     Quien:=ExtraeValor(s,1,i);
     Version:=ExtraeValor(s,1,i);
     Fech:=ExtraeValor(s,3,i);
end;


Function TipoCodigo(s:string):TTipoCodigo;
VAR
   c:char;
BEGIN
     s:=QuitaSimbolos(s);
     IF Length(s)>0
        THEN BEGIN
                  c:=s[1];
                  CASE c OF
                       LETRADESINS:Result:=tcDesinstalacion;
                       LETRAPRELIC:Result:=tcPrelicencia;
                       LETRAAPLICA,LETRACENTRA,LETRASERVID,LETRALICENC:Result:=tcLicencia
                       ELSE Result:=tcDesconocido
                  END
             END
        ELSE Result:=tcDesconocido
END;

Function TipoLicencia(s:string):TLicencia;
VAR
   c:char;
BEGIN
     s:=QuitaSimbolos(s);
     IF Length(s)>0
        THEN BEGIN
                  c:=s[1];
                  CASE c OF
                       LETRAAPLICA:Result:=lAplicacion;
                       LETRACENTRA:Result:=lCentral;
                       LETRASERVID:Result:=lServidor;
                       LETRALICENC:Result:=lLicencias
                       ELSE Result:=lDesconocida
                  END
             END
        ELSE Result:=lDesconocida
END;

Function FormateaCodigo(codigo,formato:string):string;
VAR
   i,j:Integer;
BEGIN
     j:=1;
     Result:='';
     Codigo:=QuitaSimbolos(Codigo);
     FOR i:=1 TO Length(codigo) DO
     BEGIN
          WHILE (j<=Length(Formato)) AND NOT (formato[j] IN LETRASVALIDAS) DO
          BEGIN
               Result:=Result+Formato[j];
               Inc(j)
          END;
          Result:=Result+Codigo[i];
          Inc(j)
     END
END;

Function DateValue(fecha,Formato:string):Integer;
VAR
   aff:string;
BEGIN
     aff:=ShortDateFormat;
     ShortDateFormat:=Formato;
     try
        Result:=Trunc(StrToDate(Fecha))
     finally
            ShortDateFormat:=aff
     end
END;

function HayLicencia(const sLicencia:string;const lTipo:tLicencia):Boolean;
var
   vol,fech,secreto,NumLic,Concedido,Quien,Version:longint;
begin
     try
        DesencriptaLicencia(sLicencia,vol,fech,secreto,NumLic,Concedido,Quien,Version,ltipo);
        Result:=(Vol=VolHD) AND (fech=DateBIOS) AND (Secreto=ObtenerNumeroSecreto) AND (Version=ObtenerVersion)
     except
           Result:=False
     end
end;

Function ObtenerVersion:Integer;
BEGIN
     Result:=Trunc(VERSION_ENTREGA*10)
END;

Function ObtenerIndice:Integer;
BEGIN
     Result:=Random(SizeOf(CLAVE_APLICACION))
END;

end.
