unit UCtInspectores;

interface

uses
   SQLEXPR;


const
    MAX_LONG_NOMBRE_INSPECTOR = 25; { Máxima longitud del nombre del inspector }
    MAX_LONG_PASSWORD_INSPECTOR = 4;{Máxima longitud del password del inspector}

     { constantes de la unidad MInsp }
     ES_SUPERUSUARIO = 'S';
     NO_ES_SUPERUSUARIO = 'N';


type
   tNumeroInspector = integer;
   tNombreInspector = string[MAX_LONG_NOMBRE_INSPECTOR];
   tPasswordInspector = string[MAX_LONG_PASSWORD_INSPECTOR];
   tPasswordCodificada = array [1..MAX_LONG_PASSWORD_INSPECTOR] of {byte}longint;
   tEsSuperUsuario = string[1]; { Almacena 'S' o 'N' dependiendo de si es o no
                                  el supervisor del sistema }
   tNuevoInspector = record
       sNombre: tNombreInspector; { Nombre del inspector }
       sApellido: tNombreInspector;
       sPassword: tPasswordInspector;
       sNumeroInspector: tNumeroInspector;
       sEsSuperUsuario: tEsSuperUsuario;
   end;


var
   bFicheroInspModificado: boolean; { True si se ha modificado el fichero de
                                      inspectores }


 // El nº de inspector está formado por el nº estación y el nº inspector
 function ComponerNumeroInspector (NumeroInsp: tNumeroInspector): string;
 // Devuelve el nombre del inspector dado su número
 function Devolver_NombreInspector (Numero_Inspector: tNumeroInspector): tNombreInspector;

implementation


uses
   USAGVARIOS,
   GLOBALS,
   SYSUTILS,
   ULOGS;

const
    FICHERO_ACTUAL = 'UCtInspectores';


    // El nº de inspector está formado por el nº estación y el nº inspector
    function ComponerNumeroInspector (NumeroInsp: tNumeroInspector): string;

    begin
        try
           Result := Format ('%0.2d%0.4d', [fVarios.CodeEstacion, NumeroInsp]);
        finally
        end;
    end;


    // Devuelve el nombre del inspector dado su número
    function Devolver_NombreInspector (Numero_Inspector: tNumeroInspector): tNombreInspector;
    var
       aQ: TSQLQuery;

    begin
        aQ := TSQLQuery.Create (nil);
        try
           AQ.sqlconnection := MyBD;

           { TODO -oran -ctransacciones : Ver tema sesion }

           try
              with aQ do
              begin
                  Close;
                  Sql.Clear;
                  Sql.Add ('SELECT (NOMREVIS||'' ''||APPEREVIS) NOMREVIS FROM TREVISOR WHERE NUMREVIS=:Numero_Inspector');
                  Params[0].AsInteger := Numero_Inspector;
                  {$IFDEF TRAZAS}
                     FTrazas.PonComponente (TRAZA_FLUJO, 7, FICHERO_ACTUAL, aQ);
                  {$ENDIF}
                  Open;
              end;
              Result := aQ.Fields[0].AsString;
          except
             on E:Exception do
             begin
                 Result := '';
                 FAnomalias.PonAnotacion (TRAZA_SIEMPRE,1, FICHERO_ACTUAL, 'Error en Devolver_NombreInspector: ' + E.Message);
             end;
          end;
        finally
             aQ.Free;
        end;
    end;


end.
