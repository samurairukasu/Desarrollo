 unit UConfgOT;

interface

uses
  SysUtils,
  Classes,
  IniFiles,
  Forms,
  Ulogs,
  Globals,
  ComCtrls;


function CreadoFicheroControlOk(UnaBarra: TProgressBar) : boolean;

implementation
             

const
    FICHERO_ACTUAL = 'uConfgOt.pas';
    
function CreadoFicheroControlOk(UnaBarra: TProgressBar) : boolean;
var
  aFileIni : TIniFile;
begin
  result := True;
  try
    aFileIni := TIniFile.Create(DirectorioIn+'CONTROL');
    aFileIni.WriteString('ENDOFFILE'{'DATAOUT'},'999999','*');
    aFileIni.Free;
  except
    on E : Exception do
    begin
      result := False;
      fTrazas.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL,'ERROR AL CREAR EL FICHERO DE CONTROL POR: ' + E.message);
    end;
  end;
end;



end.
