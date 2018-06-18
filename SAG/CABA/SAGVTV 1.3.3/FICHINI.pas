unit FichIni;
{ Unidad encargada de Generar Ficheros INI
  Ultima fecha de modificacion 26/08/2006}

{
  Ultima Traza: 14
  Ultima Incidencia:
  Ultima Anomalia: 7
}


interface
  uses SQLExpr, dbClient, Provider, Classes;

  function PasarDe_TablaTREVISOR_FicheroINI (Terminal, sDirecCISA: string): boolean;
  function PasarDe_TablaTCAPITULOS_TAPARTADOS_TDEFECTOS_FicheroINI (Terminal, sDirecCISA: string{; TCapitulos_Auxi, TApartados_Auxi, TDefectos_Auxi: ttable}): boolean;
  procedure Mostrar_Mensaje_Salida_FicherosINI (FicheroINIDe, Mensaje_Salida: string);

implementation

uses
   SysUtils,
   IniFiles,
   ULOGS,
   UCDIALGS,
   Forms,
   FileCtrl,
   Windows,
   GLOBALS,
   UVERSION,
   USAGVARIOS,
   UUTILS;


const
    {$IFNDEF INTEVE}
    NUMERO_DEFECTOS_TIPOOTROS = 1; { Nº de defectos de tipo OTROS que puede haber }
    {$ELSE}
    NUMERO_DEFECTOS_TIPOOTROS = 4;
    {$ENDIF}
    
    PRIMER_ELEMENTO_TDEFECTOS = 1;
    ULT_DEFVISUAL = 49;
    CODIGO_DEFECTO_OTROS = 1;


resourcestring
    { INTERCOUMNICACION CON MAHA }
     SECCION_FIN = 'ENDOFFILE';
     FINALIZADO = '999999';
     FINAL_FICHERO = 'END OF FILE';

     ES_SUPERUSUARIO = 'S';     


    CABECERA_MENSAJES_INI = 'Generación Ficheros INI';
    INI_TEMPORALES = 'temporal\';
    { Las constantes OTROS_DEFECTOS e INDICACION_OTROS_DEFECTOS se utilizan en
      el caso de que la abreviatura del defecto sea "otros", ya que en este
      caso, hay que indicar a MAHA que es otro tipo de defectos poniendo al
      final del valor de una entrada la letra "M" }
    {OTROS_DEFECTOS = 'OTROS';}
    INDICACION_OTROS_DEFECTOS = 'M';
    COMA = ',';
    { CABECERA_MENSAJES_FICHINI es la cabecera del fichero FichIni que se
      muestra en los mensajes enviados al usuario }
    CABECERA_MENSAJES_FICHINI = 'Generación Ficheros INI';
    FICHERO_ACTUAL = 'FichIni'; { Nombre del fichero actual }

    { Descripción del fichero INI de inspectores }
    CABECERA_FICHTXT_INSPECTORES = '[INSPECTORS]';
    NOMBRE_FICHEROINI_INSPECTORES = 'INSPECT.TXT';
    NOMBRE_SECCION_INSPECTORES = 'INSPECTOR';
    NOMBRE_ENTRADA_NUMREVISOR = '99100';
    NOMBRE_ENTRADA_NOMREVISOR = '99103';
    NOMBRE_ENTRADA_PALCLAVE = '99102';
    NOMBRE_ENTRADA_APPREVISOR = '99101';
    NOMBRE_ENTRADA_APPSUPER = '99104';


    NOMBRE_ENTRADA_NUMSUPERVISOR = '99200';
    NOMBRE_ENTRADA_NOMSUPERVISOR = '99203';
    NOMBRE_ENTRADA_PALCLAVESUPERVISOR = '99202';
    NOMBRE_ENTRADA_APPSUPERVISOR = '99201';

    NOMBREENTRADA_FINFICHERO_FICHTXT_INSPECTORES = '[ENDOFFILE]';
    LINEA_FINFICHERO_FICHTXT_INSPECTORES = '999999=END OF FILE';


    { Descripción del fichero INI de defectos }
    NOMBRE_FICHEROINI_DEFECTOS = 'DEFECT.INI';
    NOMBRE_SECCION_CLASE = 'HEADING';
    NOMBRE_SECCION_CAPITULO = 'ESTACIONSBT';
    NOMBRE_SECCION_APARTADO = 'DESCRIPTION_';
    NOMBRE_SECCION_DEFECTO = 'SPECIFICATION_';


type
   tNumRevis = longint; { NUMBER(4) }
   tNomRevis = string[50]; { Varchar2(50) }
   tPalClave = string[4]; { Varchar2(4) }
   tEsSuperUsuario = string[1]; { VarChar(1) }
   { Tipo de datos de un revisor }
   tRevisor = record
          NumRevis: tNumRevis; { Nº revisor }
          NomRevis: tNomRevis; { Nombre revisor }
          AppRevis: String;
          PalClave: tPalClave; { Palabra clave del revisor }
          EsSuper: tEsSuperUsuario; { Indica si se trata de un superusuario (S)
                                      o no (N) }
   end;

   tCodCapitApartDefec = byte; { NUMBER(2) }
   tAbrCapitApartDefec = string[100]; { Varchar2(15) }
   tLitCapitApartDefec = string[150]; { Varchar2(50) }
   { Tipo de datos de un capítulo }
   tDatos_Capitulo = record
          CodCapit: tCodCapitApartDefec; { Código de capítulo }
          AbrCapit: tAbrCapitApartDefec; { Abreviatura de capítulo }
          LitCapit: tLitCapitApartDefec; { Literal de capítulo }
   end;
   { Tipo de datos de un apartado }
   tDatos_Apartado = record
          CodApart: tCodCapitApartDefec; { Código de apartado }
          CodCapit: tCodCapitApartDefec; { Código de capítulo }
          AbrApart: tAbrCapitApartDefec; { Abreviatura de apartado }
          LitApart: tLitCapitApartDefec; { Literal de apartado }
   end;
   tNumDefec = longint; { NUMBER(6) }
   tActivo = string[1]; { Varchar(1) }
   { Tipo de datos de un defecto }
   tDatos_Defecto = record
          CodCapit: tCodCapitApartDefec; { Código de capítulo }
          CodApart: tCodCapitApartDefec; { Código de apartado }
          CodDefec: tCodCapitApartDefec; { Código de defecto }
          AbrDefec: tAbrCapitApartDefec; { Abreviatura de defecto }
          LitDefec: tLitCapitApartDefec; { Literal de defecto }
          Activo  : tActivo; { Indica si el defecto está activo (CADENA_VACIA) o
                               no (N) }
   end;

var
   Datos_Revisor: tRevisor; { contiene datos de un revisor }
   Datos_Capitulo: tDatos_Capitulo; { contiene datos de un capítulo }
   Datos_Apartado: tDatos_Apartado; { contiene datos de un apartado }
   Datos_Defecto: tDatos_Defecto; { contiene datos de un defecto }


////////////////////////////////////////////////////////////////////////////////////////////////////

Function Desencriptar(Clave: String; Planta:Integer): String;
Const
Max = 4;
var
VECT1, VECT2, VECT3: Array[1..4] of longint;
CFinal: String;
A,B,C,V: Integer;
Begin
Result:='';
  For A:=1 To Max Do
    VECT1[A]:= ord(Clave[A]);
  For B:=1 To Max Do
    VECT2[B]:= ( B + PLANTA MOD 32);
  For C:=1 to Max do
    Begin
    V:=(VECT1[C] XOR VECT2[C]);
    Result:=Result+chr(V);
    end;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////



procedure Mostrar_Mensaje_Salida_FicherosINI (FicheroINIDe, Mensaje_Salida: string);
{ Mensaje que se mostrará al operador para indicar si la generación del fichero
  es correcta o incorrecta }
begin
    MessageDlg (CABECERA_MENSAJES_FICHINI, 'El fichero INI de ' + FicheroINIDe + ' ha sido generado ' + Mensaje_Salida, mtInformation, [mbOk], mbOk, 0);
end;



procedure Borrar_FicheroINI (Nom_Fich: string);

{ Borra el fichero Nom_Fich }
{var
   F: File;} { variable temporal }

begin { de Borrar_FicheroINI }
(*
    try
        {AssignFile (F, Nom_Fich);}
       {$IFDEF TRAZAS}
          FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'Se va a borrar el fichero' + Nom_Fich);
       {$ENDIF}
       {Reset (F);
       CloseFile (F);
       Erase (F);}
       if FileExists (Nom_Fich) then
          DeleteFile(Nom_Fich);
       {$IFDEF TRAZAS}
          FTrazas.PonAnotacion (1,2, FICHERO_ACTUAL, 'Se ha borrado el fichero' + Nom_Fich);
       {$ENDIF}
    except
       on E:Exception do
          FAnomalias.PonAnotacion (1,1,FICHERO_ACTUAL,'Error en Borrar_FicheroINI: ' + E.Message);
    end;
    *)
end; { de Borrar_FicheroINI }



function Devolver_Abreviatura_Capitulo (Abreviatura_Capitulo: tAbrCapitApartDefec): string;
{ Devuelve la abreviatura del capítulo }
begin { de Devolver_Abreviatura_Capitulo }
    Result := Format (' "%s",', [Abreviatura_Capitulo]);
end; { de Devolver_Abreviatura_Capitulo }


function Devolver_Literal_Capitulo (Literal_Capitulo: tLitCapitApartDefec): string;
{ Devuelve el literal del capítulo }
begin { de Devolver_Literal_Capitulo }
    Result := Format ('"%s","",""', [Literal_Capitulo]);
end; { de Devolver_Literal_Capitulo }


function Devolver_Literal_Capitulo_318 (Literal_Capitulo: tLitCapitApartDefec): string;
{ Devuelve el literal del capítulo }
begin { de Devolver_Literal_Capitulo }
    Result := Format ('"%s","","","",""', [Literal_Capitulo]);
end; { de Devolver_Literal_Capitulo }


function Devolver_Abreviatura_Apartado (Abreviatura_Apartado: tAbrCapitApartDefec): string;
{ Devuelve la abreviatura del apartado }
begin { de Devolver_Abreviatura_Apartado }
    Result := Format (' "%s",', [Abreviatura_Apartado]);
end; { de Devolver_Abreviatura_Apartado }


function Devolver_Literal_Apartado (Literal_Apartado: tLitCapitApartDefec): string;
{ Devuelve el literal del apartado }
begin { de Devolver_Literal_Apartado }
    Result := Format ('"%s","",""', [Literal_Apartado]);
end; { de Devolver_Literal_Apartado }

function Devolver_Literal_Apartado_318 (Literal_Apartado: tLitCapitApartDefec): string;
{ Devuelve el literal del apartado }
begin { de Devolver_Literal_Apartado }
    Result := Format ('"%s","","",""', [Literal_Apartado]);
end; { de Devolver_Literal_Apartado }



function Devolver_Abreviatura_Defecto (Codigo_Defecto: tCodCapitApartDefec; Abreviatura_Defecto: tAbrCapitApartDefec; iCodDef: integer): string;
{ Devuelve la abreviatura del defecto }
begin { de Devolver_Abreviatura_Defecto }
    if (Codigo_Defecto = CODIGO_DEFECTO_OTROS) then
        Result := Format (' "%1.3d %s %d",', [Codigo_Defecto, Abreviatura_Defecto, iCodDef])
    else
        Result := Format (' "%1.3d %s",', [Codigo_Defecto, Abreviatura_Defecto]);
end; { de Devolver_Abreviatura_Defecto }


function Devolver_Literal_Defecto (Codigo_Defecto: tCodCapitApartDefec; Literal_Defecto: tLitCapitApartDefec): string;
{ Devuelve el literal de un defecto }
var
  Cadena: string; { es una cadena auxiliar }

begin { de Devolver_Literal_Defecto }
    if (Codigo_Defecto = CODIGO_DEFECTO_OTROS) then
       Cadena := INDICACION_OTROS_DEFECTOS{ + NUMERO_DEFECTOS_TIPOOTROS}
    else
       Cadena := '';
    Result := Format ('"%s","","%s"', [Literal_Defecto, Cadena]);
end; { de Devolver_Literal_Defecto }

function Devolver_Literal_Defecto_318 (Codigo_Defecto: tCodCapitApartDefec; Literal_Defecto: tLitCapitApartDefec): string;
{ Devuelve el literal de un defecto }
var
  Cadena: string; { es una cadena auxiliar }

begin { de Devolver_Literal_Defecto }
    if (Codigo_Defecto = CODIGO_DEFECTO_OTROS) then
       Cadena := INDICACION_OTROS_DEFECTOS{ + NUMERO_DEFECTOS_TIPOOTROS}
    else
       Cadena := '';
    Result := Format ('"%s","","%s",""', [Literal_Defecto, Cadena]);
end; { de Devolver_Literal_Defecto }

function PasarDe_TablaTCAPITULOS_TAPARTADOS_TDEFECTOS_FicheroINI (Terminal, sDirecCISA: string{; TCapitulos_Auxi, TApartados_Auxi, TDefectos_Auxi: ttable}): boolean;
{ Pasa datos de la tabla TCAPITULOS, TAPARTADOS y TDEFECTOS a un fichero, con
  formato INI, llamado DEFECTS.INI. Devuelve True si se ha podido generar dicho
  fichero INI y false en caso contrario }
var
   Codigo_Defecto: word; { Variable auxiliar para no tener en cuenta a los
                           defectos inhabilitados }
   DefectosINI: TIniFile; { Fichero INI de defectos }
   Ruta_Origen: string; { Variable auxiliar que almacena la ruta donde estará almacenado el fichero INI }
   { Cadena_Auxiliar es una cadena auxiliar para componer la abreviatura y el
     literal del defecto }
   Cadena_Auxiliar: string;
   Nombre_capitulo: string;
   Nombre_Seccion: string; { Nombre de la sección de un apartado o defecto }
   sClase,sCodigo_Capitulo, sCodigo_Apartado: string; { Variables auxiliares para
                                  formatear los códigos de capítulo y apartado }
   Codigo_Defecto_Formateado: string; { Variable auxiliar que se utiliza para
                                        formatear el código defecto }
   iCodCapit_Anterior, iCodApart_Anterior: integer; { var. auxi. para almacenar los códigos de capítulos y apartados de defectos }
   iContador, iNumeroDefectos: integer; { var. auxi. que actúan a modo de índices }

   TCapitulos_Auxi, TApartados_Auxi, qryConsultas_Auxi,qryConsultas_Auxi318: TClientDataSet;
   dspcap, dspapa, dspCon: TDatasetProvider;
   sdsCapitulos_Auxi, sdsApartados_Auxi, sdsConsultas_Auxi: TSQLDataSet;

   fSQL,fsql2: tstringlist;
   i: Integer;

begin { de PasarDe_TablaTCAPITULOS_TAPARTADOS_TDEFECTOS_FicheroINI }
    DefectosINI := nil;
   {TCapitulos_Auxi := nil;
   TApartados_Auxi := nil;
   qryConsultas_Auxi := nil;}



        sdsCapitulos_Auxi := TSQLDataSet.Create(Application);
        sdsApartados_Auxi := TSQLDataSet.Create(Application);
        sdsConsultas_Auxi   := TSQLDataSet.Create(Application);


        sdsCapitulos_Auxi.GetMetadata := false;
        sdsApartados_Auxi.GetMetadata := false;
        sdsConsultas_Auxi.GetMetadata := false;

        sdsCapitulos_Auxi.NoMetadata := true;
        sdsApartados_Auxi.NoMetadata := true;
        sdsConsultas_Auxi.NoMetadata := true;

        sdsCapitulos_Auxi.ParamCheck := false;
        sdsApartados_Auxi.ParamCheck := false;
        sdsConsultas_Auxi.ParamCheck := false;

        sdsCapitulos_Auxi.SQLConnection := MyBD;
        sdsApartados_Auxi.SQLConnection := MyBD;
        sdsConsultas_Auxi.SQLConnection := MyBD;


        sdsCapitulos_Auxi.CommandType := ctTable;
        sdsApartados_Auxi.CommandType := ctTable;
        sdsConsultas_Auxi.CommandType := ctQuery;

        dspcap := TDataSetProvider.Create(Application);
        dspcap.DataSet := sdsCapitulos_Auxi;
        dspcap.Options := [poIncFieldProps,poAllowCommandText];

        dspapa := TDataSetProvider.Create(Application);
        dspapa.DataSet := sdsApartados_Auxi;
        dspapa.Options := [poIncFieldProps,poAllowCommandText];

        dspCon := TDataSetProvider.Create(Application);
        dspCon.DataSet := sdsConsultas_Auxi;
        dspCon.Options := [poIncFieldProps,poAllowCommandText];

        TCapitulos_Auxi:=TClientDataSet.Create(Application);
   //     TApartados_Auxi:=TClientDataSet.Create(Application);
    //    qryConsultas_Auxi:=TClientDataSet.Create(Application);




        With TCapitulos_Auxi do
        begin
            SetProvider(dspcap);
            CommandText := ('TCAPITULOS');
            Open;
        end;               {
        With TApartados_Auxi do
        begin
            SetProvider(dspapa);
            CommandText := ('TAPARTADOS');
            Open;
        end;
        With qryConsultas_Auxi do
        begin
            SetProvider(dspCon);
        end;                              }

        fSQL := tstringlist.create;

   try
     { Componemos el nombre del directorio destino. El fichero INI se almacenará
       en el directorio ES_IN }

       if Terminal = CONSOLA_VALUE
       then begin
         result := False;
         fAnomalias.PonAnotacion(TRAZA_SIEMPRE,20,FICHERO_ACTUAL,'La función no es correcta porque el equipo es CONSOLA');
         exit;
        end
        else begin
          sDirecCISA  := PonerBackSlash(sDirecCISA);
          Ruta_Origen := sDirecCISA + NOMBRE_FICHEROINI_DEFECTOS;
          if FileExists(Ruta_Origen) then
          begin
            MessageDlg('Generación del Fichero ''DEFECTOS''', format('El fichero %s ya existe',[Ruta_Origen]), mtError, [mbOk], mbOK,0);
            result := False;
            fAnomalias.PonAnotacion(TRAZA_SIEMPRE,20,FICHERO_ACTUAL,'La función no es Correcta porque ya existe un fichero anterior que no ha sido tratado por MAHA');
            exit;
           end;
        end;

     DefectosINI := TIniFile.Create(Ruta_Origen);


     qryConsultas_Auxi318:=TClientDataSet.Create(Application);
         with qryConsultas_Auxi318 do
          begin
            SetProvider(dspCon);
            Close;
            CommandText :='SELECT SECCION,NOMBRE,VALOR FROM TDEFECTINI_PARAM' ;
            Open;
          end;
         qryConsultas_Auxi318.First;
         while (not qryConsultas_Auxi318.Eof) do
            begin
               DefectosINI.WriteString (qryConsultas_Auxi318.FieldByName ('SECCION').AsString,qryConsultas_Auxi318.FieldByName ('NOMBRE').AsString,qryConsultas_Auxi318.FieldByName ('VALOR').AsString);
               qryConsultas_Auxi318.next;
            end;
     qryConsultas_Auxi318.Close;


     DefectosINI.WriteString (NOMBRE_SECCION_CLASE, '01', '"MOTO","MOTO","","",""');
     DefectosINI.WriteString (NOMBRE_SECCION_CLASE, '02', '"AUTO","AUTO","","",""');

     for i:= 1 to 2 do
     begin
     { Volcamos los capítulos al fichero INI }
      TApartados_Auxi:=TClientDataSet.Create(Application);
        qryConsultas_Auxi:=TClientDataSet.Create(Application);
     With TApartados_Auxi do
        begin
            SetProvider(dspapa);
            CommandText := ('TAPARTADOS');
            Open;
        end;
        With qryConsultas_Auxi do
        begin
            SetProvider(dspCon);
        end;
     { Volcamos los capítulos al fichero INI }
     with TCAPITULOS_Auxi do
     begin
         try
            First;
            while (not TCAPITULOS_Auxi.Eof) do
            begin
                Datos_Capitulo.CodCapit := FieldByName ('CODCAPIT').AsInteger;
                Datos_Capitulo.AbrCapit := FieldByName ('ABRCAPIT').AsString;
                Datos_Capitulo.LitCapit := FieldByName ('LITCAPIT').AsString;

                { Componemos el valor de la nueva entrada }
                Cadena_Auxiliar := Devolver_Abreviatura_Capitulo (Datos_Capitulo.AbrCapit);
                Cadena_Auxiliar := Cadena_Auxiliar + Devolver_Literal_Capitulo_318 (Datos_Capitulo.LitCapit);
                sCodigo_Capitulo := Format ('%1.2d',[Datos_Capitulo.CodCapit]);
                nombre_capitulo:= '0'+ inttostr(i);
                  { Aniadimos la nueva entrada al fichero INI de Capítulos, Apartados y Defectos }
                 DefectosINI.WriteString (NOMBRE_CAPITULO, sCodigo_Capitulo, Cadena_Auxiliar);
                Next;
            end;

            { Volcamos los apartados al fichero INI }
            try
               {$IFDEF TRAZAS}
                 FTrazas.PonAnotacion (TRAZA_FLUJO,7, FICHERO_ACTUAL, 'Se va a acceder a TAPARTADOS');
               {$ENDIF}     {
               with TCAPITULOS_Auxi do
               begin
                   Close;
                   fSql.Clear;
                   fSql.Add ('SELECT CODCAPIT, CODAPART,  ABRAPART, LITAPART FROM TAPARTADOS ORDER BY CODCAPIT, CODAPART');
                   CommandText := fsql.Text;
                  // Params[0].AsString := sClase;
                   Open;
               end;    }
               TAPARTADOS_Auxi.First;
               while (not TAPARTADOS_Auxi.Eof) do
               begin
                   Datos_Apartado.CodApart := TAPARTADOS_Auxi.FieldByName ('CODAPART').AsInteger;
                   Datos_Apartado.CodCapit := TAPARTADOS_Auxi.FieldByName ('CODCAPIT').AsInteger;
                   Datos_Apartado.AbrApart := TAPARTADOS_Auxi.FieldByName ('ABRAPART').AsString;
                   Datos_Apartado.LitApart := TAPARTADOS_Auxi.FieldByName ('LITAPART').AsString;

                   Cadena_Auxiliar := Devolver_Abreviatura_Apartado (Datos_Apartado.AbrApart);
                   Cadena_Auxiliar := Cadena_Auxiliar + Devolver_Literal_Apartado(Datos_Apartado.LitApart);
                   Nombre_Seccion := Format ('%s%1.2d', ['',Datos_Apartado.CodCapit]);
                   sCodigo_Apartado := Format ('%1.2d', [Datos_Apartado.CodApart]);

                   { Aniadimos la nueva entrada al fichero INI de Capítulos, Apartados y Defectos }
                   DefectosINI.WriteString (nombre_capitulo+Nombre_Seccion, sCodigo_Apartado, Cadena_Auxiliar);
                   TAPARTADOS_Auxi.Next;
               end;
            except
               on E:Exception do
               begin
                   FAnomalias.PonAnotacion (TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'Error en PasarDe_TablaTCAPITULOS_TAPARTADOS_TDEFECTOS_FicheroINI: ' + E.Message);
                   Result := False;
               end;
            end;

            { Volcamos los defectos al fichero INI }
            Codigo_Defecto := 0;
            try
               {$IFDEF TRAZAS}
                 FTrazas.PonAnotacion (TRAZA_FLUJO,8, FICHERO_ACTUAL, 'Se va a acceder a TDEFECTOS');
               {$ENDIF}



               with qryConsultas_Auxi do
               begin
                   Close;
                   fSql.Clear;
                   fSql.Add ('SELECT CODCAPIT, CODAPART, CODDEFEC, ABRDEFEC, LITDEFEC');
                   fSql.Add ('  FROM TDEFECTOS WHERE CODCAPIT<=:ULT_DEFVISUAL AND CODAPART<=:ULT_DEFVISUAL AND CODDEFEC<=:ULT_DEFVISUAL');

                   if i=1 then
                   Begin
                    sClase:='1';
                    fSql.Add ('  AND TRIM(CODCLASE)=1');
                   end;
                   if i=2 then
                   Begin
                    sClase:='2';
                    fSql.Add ('  AND TRIM(CODCLASE)=2');
                   end;

                   fSql.Add ('  AND ACTIVO IS NULL');
                   fSql.Add ('  ORDER BY CODCAPIT, CODAPART, CODDEFEC');
                   CommandText := fsql.Text;
                   Params[0].AsInteger := ULT_DEFVISUAL;
                   Open;
               end;

               qryConsultas_Auxi.First;

               iCodCapit_Anterior := Datos_Defecto.CodCapit;
               iCodApart_Anterior := Datos_Defecto.CodApart;

               while (not qryConsultas_Auxi.Eof) do
               begin
                   Datos_Defecto.CodCapit := qryConsultas_Auxi.FieldByName ('CODCAPIT').AsInteger;
                   Datos_Defecto.CodApart := qryConsultas_Auxi.FieldByName ('CODAPART').AsInteger;
                   Datos_Defecto.CodDefec := qryConsultas_Auxi.FieldByName ('CODDEFEC').AsInteger;
                   Datos_Defecto.AbrDefec := qryConsultas_Auxi.FieldByName ('ABRDEFEC').AsString;
                   Datos_Defecto.LitDefec := qryConsultas_Auxi.FieldByName ('LITDEFEC').AsString;


                   { Componemos el valor de la nueva entrada }
                   {Cadena_Auxiliar := Devolver_Abreviatura_Defecto (Datos_Defecto.CodDefec, Datos_Defecto.AbrDefec, Codigo_Defecto);
                   Cadena_Auxiliar := Cadena_Auxiliar + Devolver_Literal_Defecto (Datos_Defecto.AbrDefec, Datos_Defecto.LitDefec);
                   Nombre_Seccion := Format ('%s%1.2d%1.2d', [NOMBRE_SECCION_DEFECTO, Datos_Defecto.CodCapit, Datos_Defecto.CodApart]);}

                   if ((iCodCapit_Anterior <> Datos_Defecto.CodCapit) or (iCodApart_Anterior <> Datos_Defecto.CodApart)) then
                   begin
                       iCodCapit_Anterior := Datos_Defecto.CodCapit;
                       iCodApart_Anterior := Datos_Defecto.CodApart;
                       Codigo_Defecto := 0;
                   end;

                   if (Datos_Defecto.CodDefec = 1) then
                      iNumeroDefectos := NUMERO_DEFECTOS_TIPOOTROS
                   else
                      iNumeroDefectos := 1;

                   for iContador := 1 to iNumeroDefectos do
                   begin
                       inc (Codigo_Defecto);
                          begin
                          { Componemos el valor de la nueva entrada }
                          Cadena_Auxiliar := Devolver_Abreviatura_Defecto (Datos_Defecto.CodDefec, Datos_Defecto.AbrDefec, iContador);
                          Cadena_Auxiliar := Cadena_Auxiliar + Devolver_Literal_Defecto_318 (Datos_Defecto.CodDefec, Datos_Defecto.AbrDefec{, Datos_Defecto.LitDefec});
                          Nombre_Seccion := Format ('%s%1.2d%1.2d', ['', Datos_Defecto.CodCapit, Datos_Defecto.CodApart]);

                          Codigo_Defecto_Formateado := Format ('%1.2d', [Codigo_Defecto]);
                          end;

                       { Aniadimos la nueva entrada al fichero INI de Capítulos, Apartados y Defectos }
                       DefectosINI.WriteString (nombre_capitulo+Nombre_Seccion, Codigo_Defecto_Formateado, Cadena_Auxiliar);
                   end;
                   qryConsultas_Auxi.Next;
               end;

               { Añadimos la sección ENDOFFILE }
      //          DefectosINI.WriteString (SECCION_FIN, FINALIZADO, FINAL_FICHERO);

                Result := True;
            except
               on E:Exception do
               begin
                   FAnomalias.PonAnotacion (TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Error en PasarDe_TablaTCAPITULOS_TAPARTADOS_TDEFECTOS_FicheroINI: ' + E.Message);
                   Result := False;
               end;
            end;
         except
            on E:Exception do
            begin
                FAnomalias.PonAnotacion (TRAZA_SIEMPRE,0,FICHERO_ACTUAL,'Error en PasarDe_TablaTCAPITULOS_TAPARTADOS_TDEFECTOS_FicheroINI: ' + E.Message);
                Result := False;
            end
         end;
     end;
   end;      //DEL FOR MLA
   DefectosINI.WriteString (SECCION_FIN, FINALIZADO, FINAL_FICHERO);

   finally
        if (TCapitulos_Auxi <> nil) then
        begin
           TCapitulos_Auxi.Close;
           TCapitulos_Auxi.Free;
           dspcap.free;
           sdsCapitulos_Auxi.free;
        end;

        if (TApartados_Auxi <> nil) then
        begin
            TApartados_Auxi.Close;
            TApartados_Auxi.Free;
            dspapa.Free;
            sdsApartados_Auxi.Free;
        end;

        if (qryConsultas_Auxi <> nil) then
        begin
            qryConsultas_Auxi.Close;
            qryConsultas_Auxi.Free;
            dspCon.Free;
            sdsConsultas_Auxi.Free;
        end;

        DefectosINI.Free;
   end;
end; { de PasarDe_TablaTCAPITULOS_TAPARTADOS_TDEFECTOS_FicheroINI }


function PasarDe_TablaTREVISOR_FicheroINI (Terminal, sDirecCISA: string): boolean;
{ Pasa datos de la tabla TREVISOR a un fichero, con formato INI, llamado INSPEC.TXT. Devuelve True
  si se ha podido generar dicho fichero INI y false en caso contrario }
var
   Ruta_Origen: string;
   Nombre_Seccion: string;
   sNumero_Revisor: string;
   Cadena_Auxiliar : string;

   InfoFich : TOFSTRUCT;

   Fich_Insp : tHandle;

   TRevisor: TClientDataSet;
   dspRevisor: TDatasetProvider;
   sdsRevisor: TSQLDataSet;


   procedure WriteLn (const h:tHandle; s : string);
   var
//     iEscritos : integer;  MODI MIGRA
     iEscritos : cardinal;
    begin
      iEscritos := 0;
      s := (s + #13 + #10);
      if (not WriteFile(h, s[1], length(s), iEscritos, nil)) or (iEscritos <> length(s)) then
        raise Exception.Createfmt('Error al escribir en el fichero por %d',[GetLastError]);
    end;

begin { de PasarDe_TablaTREVISOR_FicheroINI }
  //DatosVarios :=nil;

  result := false;
  sdsRevisor := TSQLDataSet.Create(Application);
  sdsRevisor.SQLConnection := MyBD;
  sdsRevisor.CommandType := ctQuery;
  sdsRevisor.GetMetadata := false;
  sdsRevisor.NoMetadata := true;
  sdsRevisor.ParamCheck := false;

  dspRevisor := TDataSetProvider.Create(Application);
  dspRevisor.DataSet := sdsRevisor;
  dspRevisor.Options := [poIncFieldProps,poAllowCommandText];
  TRevisor :=TClientDataSet.Create(Application);

  With TRevisor do
    begin
      SetProvider(dspRevisor);
      CommandText:=('SELECT * FROM TREVISOR WHERE (ACTIVO = ''S'')  ORDER BY NUMREVIS');
      Open;
    end;

  try
    {$IFDEF TRAZAS}
      FTrazas.PonAnotacion (TRAZA_FLUJO, 11, FICHERO_ACTUAL, 'Entramos en PasarDe_TablaTREVISOR_FicheroINI');
    {$ENDIF}

 (* INCLUIDO POR IBAN ****************************** *)
 (**) //if TipoTerminal=CONSOLA
 (**) if Terminal=CONSOLA_VALUE then
 (**) begin
 (**)    result := False;
 (**)    fAnomalias.PonAnotacion(TRAZA_SIEMPRE,20,FICHERO_ACTUAL,'La función es correcta pero no se podrá completar porque el equipo es CONSOLA');
 (**)    ShowMessage('Error al intentar crear','La función es correcta pero no se podrá completar porque el equipo es CONSOLA');
 (**)    exit;
 (**) end
 (**) else begin
 (**)   //DirCisa := PonerBackSlash(DirCisa);
 (**)   sDirecCISA := PonerBackSlash(sDirecCISA);
 (**)   Ruta_Origen := sDirecCISA + NOMBRE_FICHEROINI_INSPECTORES;
 (**)   if FileExists(Ruta_Origen)
 (**)   then begin
 (**)     MessageDlg('Generación del Fichero ''INSPECTORES''', format('El fichero %s ya existe',[Ruta_Origen]), mtError, [mbOk], mbOK,0);
 (**)     result := False;
 (**)     fAnomalias.PonAnotacion(TRAZA_SIEMPRE,20,FICHERO_ACTUAL,'La función no es Correcta porque ya existe un fichero anterior que no ha sido tratado por MAHA');
 (**)     exit;
 (**)   end;
 (**) end;
 (* INCLUIDO POR IBAN ****************************** *)

    Fich_Insp := OpenFile(Pchar(Ruta_Origen),InfoFich, OF_CREATE + OF_WRITE + OF_SHARE_DENY_NONE);
    if Fich_Insp = HFILE_ERROR then
      begin
        fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,20,FICHERO_ACTUAL,'La función no es Correcta porque no se pudo abrir el fichero, error: %d', [GetLastError]);
        result := False;
        exit;
      end;

    try
    //with DataDiccionario.TREVISOR do
      with TREVISOR do
        begin
          {$IFDEF TRAZAS}
            FTrazas.PonAnotacion (TRAZA_FLUJO, 12, FICHERO_ACTUAL, 'Vamos a tratar TREVISOR');
          {$ENDIF}

          Close;
          SetProvider(dspRevisor);
          Open;

          WriteLn (Fich_Insp, CABECERA_FICHTXT_INSPECTORES);
          WriteLn (Fich_Insp, '');

          //while (not DataDiccionario.TREVISOR.Eof) do
          while (not TREVISOR.Eof) do
          begin
            Datos_Revisor.NumRevis := FieldByName ('NUMREVIS').AsInteger;
            Datos_Revisor.NomRevis := FieldByName ('NOMREVIS').AsString;
            Datos_Revisor.PalClave := FieldByName ('PALCLAVE').AsString;
            Datos_Revisor.EsSuper :=  FieldByName ('ESSUPERV').AsString;
            Datos_Revisor.AppRevis:=  FieldByName ('APPEREVIS').AsString;



            Nombre_Seccion := Format ('%s%0.2d%0.4d', [NOMBRE_SECCION_INSPECTORES, fVarios.CodeEstacion, Datos_Revisor.NumRevis]);
            sNumero_Revisor := Format ('%0.2d%0.4d', [fVarios.CodeEstacion, Datos_Revisor.NumRevis]);


                Cadena_Auxiliar := ';' + Nombre_Seccion;
                WriteLn (Fich_Insp, Cadena_Auxiliar);

                Cadena_Auxiliar := NOMBRE_ENTRADA_NUMREVISOR + '=' + sNumero_Revisor;
                WriteLn (Fich_Insp, Cadena_Auxiliar);

                Cadena_Auxiliar := NOMBRE_ENTRADA_APPREVISOR + '=' + Datos_Revisor.NomRevis ;
                WriteLn (Fich_Insp, Cadena_Auxiliar);

                Cadena_Auxiliar:= NOMBRE_ENTRADA_PALCLAVE + '=' +Desencriptar(Datos_Revisor.PalClave,Datos_Revisor.NumRevis);
                WriteLn (Fich_Insp, Cadena_Auxiliar);

                Cadena_Auxiliar := NOMBRE_ENTRADA_NOMREVISOR + '=' + Datos_Revisor.AppRevis;
                WriteLn (Fich_Insp, Cadena_Auxiliar);

                if Datos_Revisor.EsSuper='S' then
                begin
                 Cadena_Auxiliar := NOMBRE_ENTRADA_APPSUPER + '=1' ;
                 WriteLn (Fich_Insp, Cadena_Auxiliar);
                end
                else
                   begin
                    Cadena_Auxiliar := NOMBRE_ENTRADA_APPSUPER + '=0' ;
                    WriteLn (Fich_Insp, Cadena_Auxiliar);
                   end;







          Next;
          end;

          {$IFDEF TRAZAS}
            FTrazas.PonAnotacion (TRAZA_FLUJO, 13, FICHERO_ACTUAL, 'Hemos tratado TREVISOR');
          {$ENDIF}
        end;

        { Al final del fichero de inspectores hay que incluir un END OF FILE }
        WriteLn (Fich_Insp, NOMBREENTRADA_FINFICHERO_FICHTXT_INSPECTORES);
        WriteLn (Fich_Insp, LINEA_FINFICHERO_FICHTXT_INSPECTORES);

        if not CloseHandle(Fich_Insp)
        then raise Exception.Createfmt('No se puedo cerrar el fichero por %d',[GetLastError])
        else result := True;

      except
        on E:Exception do
        begin
          FAnomalias.PonAnotacion (TRAZA_SIEMPRE,7,FICHERO_ACTUAL,'Error en PasarDe_TablaTREVISOR_FicheroINI: ' + E.Message);
          Result := False;
        end
      end;
  finally
     //CloseHandle(Fich_Insp);

     TRevisor.Close;
     TRevisor.Free;
     dspRevisor.Free;
     sdsRevisor.Free;


    {$IFDEF TRAZAS}
      FTrazas.PonAnotacion (TRAZA_FLUJO, 14, FICHERO_ACTUAL, 'Salimos de PasarDe_TablaTREVISOR_FicheroINI');
    {$ENDIF}
  end;
end; { de PasarDe_TablaTREVISOR_FicheroINI }


end.






