unit UWrES_IN;

interface
uses
  IniFiles, Classes, SysUtils, UCDialgs, SQLExpr;

const

    FICHERO_ACTUAL = 'UWrES_IN.pas';


    function GeneradoFicheroINOkde (const EsteEjercicio, EstaInspeccion : integer;
                                 const EstaMatricula : string) : boolean;

type

  EInconsitencaSGBD = class(Exception);
  ENOCreadoIni = class(Exception);


Const
    {TOPES DE LOS PARAMETROS PARA LA SECCION CABECERA DE LOS FICHEROS ES_IN}
    INICIO_DE_CABECERA = 1;
    FINAL_DE_CABECERA = 17; //MODI MLA

    {TOPES DE LOS PARAMETROS PARA LA SECCION DATAIN DE LOS FICHEROS ES_IN PARA LA 1� DEPENDENCIA}
    INICIO_DATOS_X_TVEHICULO = 10;
    FINAL_DATOS_X_TVEHICULO = 36;

    {TOPES DE LOS PARAMETROS PARA LA SECCION DATAIN DE LOS FICHEROS ES_IN PARA LA 2� DEPENDENCIA}
    INICIO_DATOS_X_ANTIGUEDAD_1 = 37;
    FINAL_DATOS_X_ANTIGUEDAD_1 = 42;

    {TOPES DE LOS PARAMETROS PARA LA SECCION DATAIN DE LOS FICHEROS ES_IN PARA LA 3� DEPENDENCIA}
    INICIO_DATOS_X_ANTIGUEDAD_2 = 43;
    FINAL_DATOS_X_ANTIGUEDAD_2 = 45;

    { INTERCOUMNICACION CON MAHA }

    SECCION_FIN = 'ENDOFFILE';
    FINALIZADO = '999999';
    FINAL_FICHERO = 'END OF FILE';

    CABECERA = 'HEADER';
    DATOS_OUT = 'DATAOUT';
    DATOS_IN = 'DATAIN';

    CARACTER_REVERIFICACION = 'E';
    BLANCO = ' ';
    CADENA_VACIA = '';
    //DIRECTORIO_TRAZAS = 'C:\logs\';
    {NOMBRES DE LOS 10/11 PARAMETROS DE LA SECCION CABECERA}

  PARAMETROS_DE_CABECERA : array [INICIO_DE_CABECERA..FINAL_DE_CABECERA] of string =
    (
     {1} '10100',  // Matricula
     {2} '10303',  // Numero de informe de inspeccion
     {3} '10102',  // Numero de bastidor
     {4} '10104',  // Numero de motor
     {5} '10107',  // fecha matriculacion   AGRE MLA
     {6} '10110',  // combustible           AGRE MLA
     {7} '10190',  // Numero de ejes
     {8} '10191',  // Ejes especiales
     {9} '10304',  // Numero de certificado GNC
     {10} '10200',  // Marca
     {11} '10201',  // Modelo
     {12} '10204',  // Tipo de Vehiculo en especie
     {13} '10205',  // Tipo de Vehiculo en destino
     {14} '10251',  // A�o de Fabricacion
     {15} '10002',  // AGRE MLA// Reverificaci�n
     {16} '10122',   // combustible NOMBRE
     {17} '10111'  );     // combustible   CODIGO


  {NOMBRES DE LOS 36 PARAMETROS DE LA SECCION DATAIN}
  PARAMETROS_DE_DATOS  : array [INICIO_DATOS_X_TVEHICULO..FINAL_DATOS_X_ANTIGUEDAD_2] of string =
  (
    '20000', '20001', '20002',
    '20100', '20101', '20102',
    '25500', '25501', '25502',
    '26500', '26501', '26502',
    '26000', '26001', '26002',
    '26100', '26101', '26102',
    '21000', '21001', '21002',
    '21100', '21101', '21102',
    '21200', '21201', '21202',
    '29000', '29001', '29002',
    '29100', '29101', '29102',
    '28000', '28001', '28002'
    );

    DATOS_INSPECCIONES = 'TINSPECCION';

    VALOR_REVERIFIC_10002 = '104'; //MLA REVERIFICACION 3.18
Type
  tCabecera = array [INICIO_DE_CABECERA..FINAL_DE_CABECERA] of string;

var
TraeDatos:TSQLQuery;


implementation

uses
  ULogs,
  Globals,
  UModDat,
  USAGCLASSES,
  USAGVARIOS,
  USAGFABRICANTE,
  USAGCLASIFICACION,
  UGESTIONCAMPOS,
  Windows,
  USucesos,
  UUtils;


/// AGREGUE LUCHO 18/09/2006 ///////////////////////////////////////////////////////////////////////
function ObtenerReenvio(Cod_Inspeccion: String):Boolean;
var
TraeDatos:TSQLQuery;
begin
TraeDatos:=TSQLQuery.Create(nil);
  with TraeDatos do
    begin
    SQLConnection:=mybd;
    SQL.Add('SELECT COUNT (*) FROM TREENVIOLINEA WHERE CODINSPE = :COD_INSPECCION AND ESTADO IS NULL ORDER BY FECHALTA');
    ParamByName('COD_INSPECCION').Value:=Cod_Inspeccion;
      try
        Open;
        if (Fields[0].Value <> 0) then
        Result:=true;
      finally
        Close;
        Free;
      end;
    end;
end;


Procedure ActualizarReenvio(Cod_Reenvio: Integer);
var
TraeDatos:TSQLQuery;
Begin
TraeDatos:=TSQLQuery.Create(nil);
  with TraeDatos do
    try
      begin
      SQLConnection:=mybd;
      SQL.Add('UPDATE TREENVIOLINEA SET ESTADO = ''R'' WHERE CODINSPE = :COD_INSPECCION AND ESTADO IS NULL');
      ParamByName('COD_INSPECCION').Value:=Cod_Reenvio;
      ExecSQL;
      end;
    finally
      Free;
    end;
end;




////////////////////////////////////////////////////////////////////////////////////////////////////




function DIRECTORIO_TRAZAS : String;
begin
    Result:=ExtractFilePath(fAnomalias.FileHandle)
end;


function Devolver_2UltimosDigitosAnio(iEjerc: word): byte;
{ Devuelve los dos �ltimos d�gitos de un a�o. Ej.: dado 1996 devuelve 96 }
begin
    Result := iEjerc mod 100;
end;


function Calcular_NumeroInspeccion (const Ejer:longint;
               const DatVar_Zona: integer; const DatVar_Estacion: integer;
               const CodInsp: longint; const Reverif: string): string;
var
  InspTemp: string; { Almacena de forma temporal el n� inspecci�n }

begin { de Calcular_NumeroInspeccion }
    InspTemp := Format ('%1.2d %1.4d%1.4d%1.7d', [Devolver_2UltimosDigitosAnio
                (Ejer), DatVar_Zona, DatVar_Estacion, CodInsp]);
    { Hay que comprobar si se trata de una reverificaci�n }
    if (Reverif = CARACTER_REVERIFICACION) then {'R'}
       InspTemp := InspTemp + BLANCO + CARACTER_REVERIFICACION;
    Result := InspTemp;
end; { de Calcular_NumeroInspeccion }

function CabeceraOkDe (const UnEjercicio, UnaInspeccion : integer;
                         const UnaMatricula : string;
                         var dCabecera : tCabecera) : boolean;
const
    {CAMPOS DE LA VISTA }
    FIELD_NOMDESTI = 'NOMDESTI';
    FIELD_NOMESPEC = 'NOMESPEC';
    MOTOR    = 'NUMMOTOR';
    BASTIDOR = 'NUMBASTI';
    EJES     = 'NUMEJES';
    TIPO     = 'TIPOVEHI';
    ESPECIE  = 'TIPOESPE';
    DESTINO  = 'TIPODEST';
    MARCA    = 'NOMMARCA';
    MODELO   = 'NOMMODEL';
    MATRICULADO = 'FECMATRI';
    FABRICADO   = 'ANIOFABR';
    MATRICULA   = 'MATRICUL';
    GNC = 'NCERTGNC';
    REVERIFICANDO = 'REVERIFI';
    TIPOGAS='TIPOGAS';

    PARAMETRO_INSPECCION = 'UnaInspeccion';
    PARAMETRO_EJERCICIO = 'UnEjercicio';

    EJES_DE_PESADOS = '1';
    EJES_DE_LIGEROS = '2';
    EJES_DE_MOTOS = '3';  //MODI RAN MOTOS
    EJES_DE_TRAILERS = '12';

    //AGRE MLA
    NOM_TIPOGASG = 'GAS';
    NOM_TIPOGASL = 'GASOIL';
    NOM_TIPOGASN = 'NAFTA';
    NOM_TIPOGASM = 'MEZCLA';
    NOM_TIPOGASO = 'OTROS';  //Linea Nueva LM

VAR
    SV,LAURA: String;
    FVehiculo: TVehiculo;
    FInspeccion: TInspeccion;
    FVarios: TVarios;
    FModelo: TModelos;
    FMarca: TMarcas;
begin
    try
        FModelo:=Nil;
        FMarca:=Nil;
        FVarios:=TVarios.Create(MyBD);
        FVarios.Open;
        FInspeccion:=TInspeccion.CreateFromDataBase(MyBd,DATOS_INSPECCIONES,Format(' WHERE EJERCICI=%D AND CODINSPE=%D',[UnEjercicio,UnaInspeccion]));
        FInspeccion.Open;
        FVehiculo:=FInspeccion.GetVehiculo;
        FVehiculo.Open;

        { COMIENZA LA SUPER CONSULTA QUE DEVUELVE TODOS LOS DATOS NECESARIOS }
        Try
            {$B-}
            if (FVehiculo.RecordCount > 0 ) and (UpperCase(FVehiculo.GetPatente) = UpperCase(UnaMatricula)) then
            begin
                 FModelo:=TModelos(FVehiculo.GetModelo);
                 FModelo.Open;

                {$IFDEF TRAZAS}
                fTrazas.PonRegistro(TRAZA_REGISTRO,0,FICHERO_ACTUAL,DataDiccionario.QryConsultas);
                {$ENDIF}

                dCabecera[1] := FVehiculo.GetPatente;

                dCabecera[2] := FInspeccion.Informe;

                dCabecera[3] := FVehiculo.ValueByName[BASTIDOR];

                dCabecera[4] := FVehiculo.ValueByName[MOTOR];

                dCabecera[5] := copy(FVehiculo.ValueByName[MATRICULADO],7,4)+copy(FVehiculo.ValueByName[MATRICULADO],4,2)+copy(FVehiculo.ValueByName[MATRICULADO],1,2);

                //AGRE MLA y LM
                if FVehiculo.ValueByName[TIPOGAS]= 'G' then
                  dCabecera[6] := NOM_TIPOGASG
                else
                if FVehiculo.ValueByName[TIPOGAS]= 'L' then
                  dCabecera[6] := NOM_TIPOGASL
                else
                if FVehiculo.ValueByName[TIPOGAS]= 'N' then
                  dCabecera[6] := NOM_TIPOGASN
                else
                if FVehiculo.ValueByName[TIPOGAS]= 'M' then
                  dCabecera[6] := NOM_TIPOGASM
                else
                if (FVehiculo.ValueByName[TIPOGAS]= '') or (FVehiculo.ValueByName[TIPOGAS]= 'O') then   //Linea Nueva
                  dCabecera[6] := NOM_TIPOGASO;                                                    //Linea Nueva

                dCabecera[7] := FVehiculo.ValueByName[EJES];

                // MODIFICACION 10000000001 DE ULTIMA HORA
                // MODIFICACION CON LOS TRAILERS

                case FVehiculo.GetTipoVehic of
                    4,5   : dCabecera[8] := EJES_DE_TRAILERS;
                    1     : dCabecera[8] := EJES_DE_MOTOS;
                    2     : dCabecera[8] := EJES_DE_LIGEROS;
                    3     : dCabecera[8] := EJES_DE_PESADOS;
                    else raise Exception.Create(format('Tipo de Vehiculo %s erroneo, n� ejes desconocido', [FVehiculo.ValueByName[ESPECIE]]));
                end;

                dCabecera[9] :=  FVehiculo.ValueByName[GNC];

                dCabecera[10] := Fvehiculo.Marca;
                dCabecera[11] := FMoDelo.ValueByName[MODELO];

                With TTEspecies(FVehiculo.GetEspecie) do
                Try
                    Open;
                    dCabecera[12] := ValueByName[FIELD_NOMESPEC];
                Finally
                    Free;
                end;

                With TTDestinos(FVehiculo.GetDestino) do
                Try
                    Open;
                    dCabecera[13] := ValueByName[FIELD_NOMDESTI];
                Finally
                    Free;
                end;

                // MODIFICACION 10000000000 DE ULTIMA HORA
                dCabecera[14] := FVehiculo.ValueByName[FABRICADO];

////////////////////////////// Si es una Reverificacion ////////////////////////////////////////////
//      CUANDO MAHA CORRIJA QUE AUNQUE NO ENCUENTRE UNA INSPECCION EN SU BASE LA TOME IGUAL     ////
//      VA A QUEDAR BIEN EL ENVIO DEL 104 PARA REVES. O CUANDO PASEN 60 DIAS EN LA 24           ////
////////////////////////////////////////////////////////////////////////////////////////////////////

                if (copy(FInspeccion.Informe,Length(FInspeccion.Informe),Length(FInspeccion.Informe)) ='R') or (ObtenerReenvio(IntToStr(UnaInspeccion)))
                    or (IsRevePreverification(FVehiculo.GetPatente))  then
                  Begin
                    ActualizarReenvio(UnaInspeccion);
                    dCabecera[15] := VALOR_REVERIFIC_10002;
                  end;

////////////////////////////////////////////////////////////////////////////////////////////////////

                //AGRE MLA y LM
                if FVehiculo.ValueByName[TIPOGAS]= 'G' then
                  dCabecera[16] := NOM_TIPOGASG
                else
                if FVehiculo.ValueByName[TIPOGAS]= 'L' then
                  dCabecera[16] := NOM_TIPOGASL
                else
                if FVehiculo.ValueByName[TIPOGAS]= 'N' then
                  dCabecera[16] := NOM_TIPOGASN
                else
                if FVehiculo.ValueByName[TIPOGAS]= 'M' then
                  dCabecera[16] := NOM_TIPOGASM
                else
                if (FVehiculo.ValueByName[TIPOGAS]= '') or (FVehiculo.ValueByName[TIPOGAS]= 'O') then   //Linea Nueva
                  dCabecera[16] := NOM_TIPOGASO;                                                    //Linea Nueva



                 //AGRE MLA y LM
                if FVehiculo.ValueByName[TIPOGAS]= 'G' then
                  dCabecera[17] := '2'
                else
                if FVehiculo.ValueByName[TIPOGAS]= 'L' then
                  dCabecera[17] := '1'
                else
                if FVehiculo.ValueByName[TIPOGAS]= 'N' then
                  dCabecera[17] := '3'
                else
                  dCabecera[17] := '3' ;





                result := True;
                {$IFDEF TRAZAS}
                fTrazas.PonAnotacion(TRAZA_FLUJO,0,FICHERO_ACTUAL,'CABECERA DEL VEHICULO ' + UnaMatricula + ' OBTENIDA CORRECTAMENTE ');
                {$ENDIF TRAZAS}
            end
            else begin
                result := False;
                fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0, FICHERO_ACTUAL,
                    'CABECERA DEL VEHICULO ' + UnaMatricula + ' NO OBTENIDA CORRECTAMENTE, comprobar que (matricula - inspeccion): ' +
                    UnaMatricula + ' ' + IntToStr(UnaInspeccion) + ' CUMPLAN LAS RESTRICCIONES CON LA TABLA VEHICULOS E INSPECCION');
            end;
        Finally
            FInspeccion.Free;
            FVehiculo.Free;
            FVarios.Free;
            If FModelo<>nil then FModelo.Free;
        end;
    except
      on E : Exception do
      begin
        fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1, FICHERO_ACTUAL, 'NO SE HA PODIDO OBTENER CORRECTAMENTE LA CABECERA PARA EL VEHIUCLO:  POR: '+ E.Message);
        result := False;
      end;
    end;
  end;



function EscritoINOkde(const EsteEjercicio, EstaInspeccion : integer;const EstaMatricula : string) : boolean;
//  const
//    CABECERA = 'HEADER';
//    DATOS = 'DATAIN';
//    SECCION_FINAL ='ENDOFFILE';
//    FINALIZADO =   '999999';
//    FIN_DE_FICHERO = 'END OF FILE';

var
   h : tdateTime;
   MiFicheroIni : TIniFile;
   I : integer;
   sAnio : string;
   LaCabecera : TCabecera;
   LasDependencias : tRDependencias;
  {$IFDEF DEPURACION}
    MiFicheroCopia : TIniFile;
  {$ENDIF}


begin
result := True;
  try
  { Se Obtienen los datos de cabecera, devolviendo en UnaConsulatEs_IN los datso }
  {$B-}
  if CabeceraOkDe(EsteEjercicio, EstaInspeccion, EstaMatricula, LaCabecera) and
     DataDiccionario.ObtenerDependenciasOk (EsteEjercicio, EstaInspeccion, LasDependencias) then
    begin
      MiFicheroIni := TIniFile.Create(DIRECTORIO_TRAZAS + EstaMatricula);
      {$IFDEF DEPURACION}
      MiFicheroCopia := TIniFile.Create(DIRECTORIO_TRAZAS + EstaMatricula);;
      {$ENDIF}
      { ESCRITURA EN INI DE LA CABECERA }
      for I := INICIO_DE_CABECERA to FINAL_DE_CABECERA do
        begin
          MiFicheroIni.WriteString ( CABECERA,PARAMETROS_DE_CABECERA[I], LaCabecera[I]);
          {$IFDEF DEPURACION}
          MiFicheroCopia.WriteString ( CABECERA,PARAMETROS_DE_CABECERA[I], LaCabecera[I]);
          {$ENDIF}
        end;
      { ESCRITURA DE DATIN }
      With TCampos.Create(MyBd) do
        Try
        { SI LA DEPENDENCIA ES : MOTOCICLETA, VEH. LIG, VEH. PES, REMOLQUE, CUALQUIERA) }
          for I := INICIO_DATOS_X_TVEHICULO to FINAL_DATOS_X_TVEHICULO do
            begin
              MiFicheroIni.WriteString(DATOS_IN,PARAMETROS_DE_DATOS[i], SimboloDeCampoPara (I, LasDependencias.D1));
              {$IFDEF DEPURACION}
              MiFicheroCopia.WriteString(DATOS_IN,PARAMETROS_DE_DATOS[i], SimboloDeCampoPara (I, LasDependencias.D1));
              {$ENDIF}
            end;
           for I := INICIO_DATOS_X_ANTIGUEDAD_1 to FINAL_DATOS_X_ANTIGUEDAD_2 do
             begin
              MiFicheroIni.WriteString(DATOS_IN, PARAMETROS_DE_DATOS[i],  SimboloDeCampoPara (I, LasDependencias.D2));
              {$IFDEF DEPURACION}
              MiFicheroCopia.WriteString(DATOS_IN, PARAMETROS_DE_DATOS[i],  SimboloDeCampoPara (I, LasDependencias.D2));
              {$ENDIF}
             end;
           for I := INICIO_DATOS_X_ANTIGUEDAD_2 to FINAL_DATOS_X_ANTIGUEDAD_2 do
             begin
               MiFicheroIni.WriteString(DATOS_IN, PARAMETROS_DE_DATOS[i], SimboloDeCampoPara (I, LasDependencias.D3));
               {$IFDEF DEPURACION}
               MiFicheroCopia.WriteString(DATOS_IN, PARAMETROS_DE_DATOS[i],  SimboloDeCampoPara (I, LasDependencias.D3));
               {$ENDIF}
             end;
        Finally
          Free;
        End;
      MiFicheroIni.WriteString(SECCION_FIN, FINALIZADO, FINAL_FICHERO);
      {$IFDEF TRAZAS}
      fTrazas.PonAnotacion(TRAZA_FLUJO,0, FICHERO_ACTUAL, 'EL ARCHIVO '+ EstaMatricula +' SE HA CREADO EN EL DIRECTORIO '+ DIRECTORIO_TRAZAS);
      {$ENDIF}
      MiFicheroIni.Free;
      {$IFDEF DEPURACION}
      {$ENDIF}
      {$IFDEF DEPURACION}
      MiFicheroCopia.WriteString(SECCION_FIN, FINALIZADO, FINAL_FICHERO);
      MiFicheroCopia.Free;
      {$ENDIF}
      Sleep(200);
      CopyFile(pchar(DIRECTORIO_TRAZAS + EstaMatricula),pchar(DirectorioIn + EstaMatricula),TRUE);
      {$IFDEF TRAZAS}
      fTrazas.PonAnotacion(TRAZA_FLUJO,0, FICHERO_ACTUAL, 'EL ARCHIVO '+ EstaMatricula +' SE HA COPIADO EN EL DIRECTORIO '+ DirectorioIn);
      {$ENDIF}
      end
    else
      begin
        result := False;
        fAnomalias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'NO SE PUDO GENERAR EL FICHERO: ' + EstaMatricula + '.INI EN EL DIRECTORIO ES_IN POR FALTA DE CABECERA, O DEPENDENCIAS');
      end;
      LiberarMemoria;
  except
    on E: Exception do
      begin
        result := False;
        fAnomalias.PonAnotacion(TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'NO SE PUDO GENERAR EL FICHERO: ' + EstaMatricula + '.INI EN EL DIRECTORIO ES_IN POR: ' + E.Message );
      end;
  end;
end;


function GeneradoFicheroINOkde(const EsteEjercicio, EstaInspeccion : integer;
                               const EstaMatricula : string) : boolean;

{$IFDEF DEPURACION}
var
 h : tdateTime;
{$ENDIF}

begin
 result := EscritoInOkDe(EsteEjercicio, EstaInspeccion, EstaMatricula);
end;


end.

