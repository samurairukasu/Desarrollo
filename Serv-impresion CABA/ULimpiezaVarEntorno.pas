unit ULimpiezaVarEntorno;

interface

uses
Windows, SysUtils, Forms;

  Function ObtenerVariableEntorno: Boolean;
  Function BorrarArchivosTEMP: boolean;

Const
  HENVIROMENT = 'Environment';
  HTEMP = 'TEMP';
  HTMP  = 'TMP';
  cQRP = 'QRP';
  FICHERO_ACTUAL = 'ULimpiezaVarEntorno';
var
  sTemp, sTMP: String;

implementation

uses
Globals, ULogs, USUPERREGISTRY;

function ObtenerVariableEntorno: boolean;
var
  I : Integer;
begin
result := False;
with TSuperRegistry.Create do
  try
  RootKey := HKEY_CURRENT_USER;
  if OpenKeyRead(HENVIROMENT) then
    Begin
      sTemp:=ReadString(HTEMP);
      sTMP:=ReadString(HTMP);
      result := True;
    end;
  finally
    Free;
  end;
end;


function BorrarArchivosTEMP: boolean;
var
searchResult: TSearchRec;
First3: String;
iTotal: Integer;
Begin
iTotal:=0;
if (FindFirst(sTemp+'\*.tmp', faArchive, searchResult) = 0) then
  begin
    Repeat
      if (searchResult.Name <> '.') and (searchResult.Name <> '..') then
       try
         First3:= Copy(searchResult.Name,1,3);
         if First3 = cQRP then
          Begin
            DeleteFile(sTemp+'\'+searchResult.Name);
            inc(iTotal);
            Application.ProcessMessages;
          end;
       Except
        On E: Exception Do
          {$IFDEF TRAZAS}
            fTrazas.PonAnotacion(TRAZA_USUARIO,0,FICHERO_ACTUAL, 'SE HA PRODUCIDO UN ERROR AL BORRAR LOS ARCHIVOS.');
          {$ENDIF}
       end;
    Application.ProcessMessages;
    until (FindNext(searchResult) <> 0);
  FindClose(searchResult);
  {$IFDEF TRAZAS}
  fTrazas.PonAnotacionFmt(TRAZA_USUARIO,0,FICHERO_ACTUAL, 'SE HAN BORRADO %d ARCHIVOS.',[iTotal]);
  {$ENDIF}
  end;
end;








end.
 