unit USuperRegistry;

interface
Uses Registry, Classes,Windows;

type
TSuperRegistry=class(TRegistry)
public
       {Abre una clave en modo sólo lectura}
       function OpenKeyRead(const Key: string): Boolean;
       {Busca un nombre a través del registro y se posiciona sobre él}
       Function FindNameValue(const Name,Value:String;const BaseKey:string):Boolean;
       {Obtiene las rutas completas de una clave dentre de una serie de claves}
       procedure RutaDe (const sclave: string; var Rutas : TStringList;  tHKEYS : array of integer);
       {Abre una clave con los permisos indicados}
       Function OpenKeySec(const Key:string;CanCreate:Boolean;samDesired:REGSAM):Boolean;
       {Lee un string devolviendo un valor por defecto si no existe}
       Function ReadStringDef(const Name,Default: string):string;
private
       procedure Ruta (sInicio : string; const sClave: string; var l : TStringList);
end;

Function HKeyToStr(RootKey:HKey):string;

implementation
Uses sysutils;

const

  HKEYS : array[0..5] of integer = (HKEY_CLASSES_ROOT,
                                    HKEY_CURRENT_USER,
                                    HKEY_LOCAL_MACHINE,
                                    HKEY_USERS,
                                    HKEY_CURRENT_CONFIG,
                                    HKEY_DYN_DATA);

  sHKEYS : array[0..5] of string = ('HKEY_CLASSES_ROOT\',
                                    'HKEY_CURRENT_USER\',
                                    'HKEY_LOCAL_MACHINE\',
                                    'HKEY_USERS\',
                                    'HKEY_CURRENT_CONFIG\',
                                    'HKEY_DYN_DATA\');

Function HKeyToStr(RootKey:HKey):string;
BEGIN
IF RootKey=HKEY_CLASSES_ROOT THEN
  Result:='HKEY_CLASSES_ROOT'
ELSE IF RootKey=HKEY_CURRENT_USER THEN
  Result:='HKEY_CURRENT_USER'
ELSE IF RootKey=HKEY_LOCAL_MACHINE THEN
  Result:='HKEY_LOCAL_MACHINE'
ELSE IF RootKey=HKEY_USERS THEN
  Result:='HKEY_USERS'
ELSE IF RootKey=HKEY_CURRENT_CONFIG THEN
  Result:='HKEY_CURRENT_CONFIG'
ELSE IF RootKey=HKEY_DYN_DATA THEN
  Result:='HKEY_DYN_DATA'
ELSE Result:=''
END;

{Abre una clave con los permisos indicados}
Function TSuperRegistry.OpenKeySec(const Key:string;CanCreate:Boolean;samDesired:REGSAM):Boolean;
var
TempKey: HKey;
S: string;
Disposition: Integer;
Relative: Boolean;
Begin
S := Key;
Relative := (s = '') or (s[1] <> '\');
if not Relative then Delete(S, 1, 1);
  TempKey := 0;
if not CanCreate or (S = '')then
  Result:=RegOpenKeyEx(GetBaseKey(Relative),PChar(S),0,samDesired,TempKey)=ERROR_SUCCESS
else
  Result:=RegCreateKeyEx(GetBaseKey(Relative),PChar(S),0,nil,REG_OPTION_NON_VOLATILE,samDesired,nil,TempKey,@Disposition)=ERROR_SUCCESS;
if Result then
  begin
    if (CurrentKey <> 0) and Relative then
      S := CurrentPath + '\' + S;
    ChangeKey(TempKey, S);
  end;
end;

{Abre una clave en modo sólo lectura}
function TSuperRegistry.OpenKeyRead(const Key: string): Boolean;
begin
  Result:=OpenKeySec(Key,False,KEY_READ)
end;

Function TSuperRegistry.ReadStringDef(const Name,Default: string):string;
BEGIN
  try
    Result:=ReadString(Name);
    IF Length(Result)=0 THEN
      Result:=Default
  except
    Result:=Default
  end
END;

{Busca un nombre a través del registro y se posiciona sobre él}
Function TSuperRegistry.FindNameValue(const Name,Value:String;const BaseKey:string):Boolean;
VAR
   sl:TStringList;
   i:Integer;
BEGIN
     Result:=False;
     IF OpenKeyRead(BaseKey)
        THEN IF ValueExists(Name)AND (Uppercase(ReadString(Name))=Uppercase(Value))
                THEN Result:=True
                ELSE IF HasSubkeys
                        THEN BEGIN
                                  sl:=TStringList.Create;
                                  try
                                     GetKeyNames(sl);
                                     FOR i:=0 TO Sl.Count-1 DO
                                     BEGIN
                                          Result:=FindNameValue(Name,Value,BaseKey+'\'+sl.Strings[i]);
                                          IF Result THEN Break
                                     END
                                  finally
                                         sl.Free
                                  end;
                             END
                        ELSE Result:=False
END;


// Obtiene todas las rutas de una clave respecto de una raiz
procedure TSuperRegistry.Ruta (sInicio : string; const sClave: string; var l : TStringList);
var
 sl : TStringList;
  i : integer;
begin
   if OpenKeyRead(sInicio)
   then begin
     if  (Pos(UpperCase(sclave),UpperCase(CurrentPath)) <> 0)
          and
           (format('%s%s', [Copy (UpperCase(sInicio),1,Pos(UpperCase(sClave),UpperCase(sInicio))-1),UpperCase(sClave)])
            = format('\%s',[UpperCase(CurrentPath)]))
     then begin
       l.Add(CurrentPath)
     end
     else begin
               sl := TStringList.Create;
               try
                  GetKeyNames(sl);
                  for i:=0 to sl.Count - 1 do
                      Ruta(sInicio+'\'+sl.Strings[i],sClave,l);
               finally
                      sl.Free;
               end;
          end;
   end
   else raise Exception.CreateFmt('No se pudo abrir la clave %s',[sInicio]);
end;

// Obtiene todas las rutas completas de una clave respecto de unaa raizes de busqueda
procedure TSuperRegistry.RutaDe (const sclave: string; var Rutas : TStringList;  tHKEYS : array of integer);
var
  Lista : TStringlist;
  i,j : integer;

       function ArrayNotOk (const tHKEYS : array of integer) : boolean;
       var
         i,a,b,c,d,e,f : integer;

       begin
         //result := False;
         if high(tHKEYS) > high(HKEYS)
         then result := True
         else begin
           a := 0; b := a; c := b; d := c;  e := d; f := e;
           for i := low(tHKEYS) to high(tHKEYS) do
             case tHKEYS[i] of
               HKEY_CLASSES_ROOT : inc(a,1);
               HKEY_CURRENT_USER : inc(b,1);
               HKEY_LOCAL_MACHINE : inc(c,1);
               HKEY_USERS : inc(d,1);
               HKEY_CURRENT_CONFIG : inc(e,1);
               HKEY_DYN_DATA : inc(f,1);
               else begin
                 //result := True;
                 break;
               end;
             end;
           result := ((a>1) or (b>1) or (c>1) or (d>1) or (e>1) or (f>1))
         end;
       end;

begin
  Lista:=NIL;
  Lista := TStringList.Create;
  try
    if (ArrayNotOk(tHKEYS))
    then raise Exception.Create('Error al buscar, claves de registro no reconocidas')
    else begin
      for i := low(tHKEYS) to high(tHKEYS) do
      begin
        RootKey := tHKEYS[i];
        Ruta('',sclave,Lista);
        for j := 0 to Lista.Count - 1 do
          Rutas.Add(sHKEYS[i]+Lista.Strings[j]);
        Lista.Clear;
      end;
    end;
  finally
    Lista.Free
  end;
end;


end.
