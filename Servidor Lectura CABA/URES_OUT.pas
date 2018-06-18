unit UrES_OUT;

interface
uses
  Forms,  DB,  SysUtils,  UCDialgs,  uutils,  sqlExpr,  provider,  DbClient, variants, StrUtils, DateUtil;


  function ConvierteComaEnPuntoGral (const s: string): string;
  function IsStandBy(aEjercicio,aCodInspeccion: Integer; aDataBase: TSQLConnection):Boolean;
  procedure InterpretarFichero (const EsteFichero : string; var CodError, iEjercicio, iCodigoInspeccion  : Integer; var IsSBy: boolean);

  Var
  Resultado, NumBinario,patente: String;


implementation

uses
  IniFiles,
  UModDat,
  Globals,
  ULogs;

const

    FICHERO_ACTUAL  = 'UrES_OUT.pas';   { CONTROL SOBRE EL FICHERO QUE SE LEE DE MAHA }

    CAMPOS_VISUALES = 7; {0..7}

    PRIMER_CODIGO_OUT_HEAD = 1;
    ULTIMO_CODIGO_OUT_HEAD = 8;

    PRIMER_CODIGO_OUT_DATA = 1;
    ULTIMO_CODIGO_OUT_DATA = 75;

    PRIMER_CODIGO_OUT_DATA_EURO318= 1;
    ULTIMO_CODIGO_OUT_DATA_EURO318= 75;

    PRIMER_CODIGO_OUT_DATA_AUXIL = 1;
    ULTIMO_CODIGO_OUT_DATA_AUXIL = 30;

    TCODIGOS_OUT_DATA : array [1..75] of string =
    (
     '30000', '30001', '30002', '30003',
     '50100', '50101',
     '51100', '51101',
     '52100', '52101',
     '53100', '53101',
     '50250', '50251',
     '51250', '51251',
     {'59250' pasa a ser el 16-1-97 a} '59260',
     '50000', '50001',
     '51000', '51001',
     '52000', '52001',
     '53000', '53001',
     {'59000' pasa a ser el 16-1-97 a} '59010',
     '50050', '50051',
     '51050', '51051',
     '52050', '52051',
     '53050', '53051',
     '50010',
     '51010',
     '52010',
     '53010',
     '50020', '50021',
     '51020', '51021',
     '52020', '52021',
     '53020', '53021',
     '50030', '50031',
     '51030', '51031',
     '52030', '52031',
     '53030', '53031',
     '31000', '31001',
     '31100', '31101',
     '31002',
     '31102',
     '31010', '31011',
     '31110', '31111',
     '39000', '39001', '39002', '39003',
     '38000',
     '15010', '15011',
     '15110', '15111',
     '15210', '15211');


    TCODIGOS_OUT_DATA_EURO318 : array [1..75] of string =
    (
     '30000', '30001', '30002', '30003',
     '50100', '50101',
     '51100', '51101',
     '52100', '52101',
     '53100', '53101',
     '50250', '50251',
     '51250', '51251',
     {'59250' pasa a ser el 16-1-97 a} '59260',
     '50000', '50001',
     '51000', '51001',
     '52000', '52001',
     '53000', '53001',
     {'59000' pasa a ser el 16-1-97 a} '59010',
     '50050', '50051',
     '51050', '51051',
     '52050', '52051',
     '53050', '53051',
     '50010',
     '51010',
     '52010',
     '53010',
     '50020', '50021',
     '51020', '51021',
     '52020', '52021',
     '53020', '53021',
     '50030', '50031',
     '51030', '51031',
     '52030', '52031',
     '53030', '53031',
     '31000', '31001',
     '31100', '31101',
     '31002',
     '31102',
     '31010', '31011',
     '31110', '31111',
     '39000', '39001', '39002', '39003',
     '38500',
     '15010', '15011',
     '15110', '15111',
     '15210', '15211');
  //   '15310', '15311',
  //   '15410', '15411',
  //   '15460', '15461');



  TCODIGOS_OUT_DATA_EUROAUXIL : array [1..30] of string =
    (
     '32000',
     '32100',
     '32101',
     '32102',
     '32103',
     '32104',
     '32105',
     '32106',
     '32200',
     '32201',
     '32202',
     '32203',
     '32204',
     '32205',
     '32206',
     '32207',
     '32300',
     '32301',
     '32302',
     '32303',
     '32304',
     '32400',
     '32401',
     '32402',
     '32403',
     '32404',
     '32500',
     '32504',
     '32600',
     '32990') ;


     { ACERCA DE LA HORA DE ENTRADA EN LAS ZONAS, LEIDAS DE ES_OUT }

     ANIO_O = 367;

     PRIMERA_ZONA = 1;
     ULTIMA_ZONA = 3;

     HORAS_ENTRADA_ZONA : array [PRIMERA_ZONA..ULTIMA_ZONA] of string = ('15000', '15100', '15200');
     HORAS_SALIDA_ZONA : array [PRIMERA_ZONA..ULTIMA_ZONA] of string = ('15001', '15101', '15201');

   //  HORAS_ENTRADA_ZONA : array [PRIMERA_ZONA..ULTIMA_ZONA] of string = ('15300','15400','15450' );
   //  HORAS_SALIDA_ZONA : array [PRIMERA_ZONA..ULTIMA_ZONA] of string = ('15301', '15401', '15451');

     HORAS_INICIO_ZONA : array [PRIMERA_ZONA..ULTIMA_ZONA] of tDateTime = (ANIO_O, ANIO_O, ANIO_O);
     HORAS_FINAL_ZONA  :  array [PRIMERA_ZONA..ULTIMA_ZONA] of tDateTime = (ANIO_O, ANIO_O, ANIO_O);

     PARAMETROS_ENTRADA_ZONA : array [PRIMERA_ZONA..ULTIMA_ZONA] of string = ( 'HoraEntrada_Z1', 'HoraEntrada_Z2', 'HoraEntrada_Z3');
     PARAMETROS_SALIDA_ZONA : array [PRIMERA_ZONA..ULTIMA_ZONA] of string = ( 'HoraSalida_Z1', 'HoraSalida_Z2', 'HoraSalida_Z3');

    { ACERCA DE LA REVISION }
    PRIMER_CAMPO_REVISION = 1;
    ULTIMO_CAMPO_REVISION = 23;

    PARAMETROS_DE_VERIFICACION : array [PRIMER_CAMPO_REVISION..ULTIMO_CAMPO_REVISION] of integer =
    (  2,  3,  4,  5, 18, 27, 36, 37, 38, 39, 60, 61, 56, 57, 58, 59, 56, 57, 58, 59, 66, 67, 70 );

    PARAMETROS_DE_COMPROBACION : array [PRIMER_CAMPO_REVISION..ULTIMO_CAMPO_REVISION] of integer =
    ( 10, 13, 13, 13, 16, 19, 22, 25, 25, 25, 28, 28, 31, 31, 31, 31, 34, 34, 34, 34, 37, 40, 43 );


    NOMBRE_CAMPOS_DE_REVISION : array [PRIMER_CAMPO_REVISION..ULTIMO_CAMPO_REVISION] of string =
    ( '03.10.050',
      '03.10.051', '03.10.051', '03.10.051',
      '04.03.050',
      '04.04.050',
      '04.05.050',
      '04.06.050', '04.06.050', '04.06.050',
      '05.01.050',
      '05.01.051',
      '05.01.052', '05.01.052',
      '05.01.053', '05.01.053',
      '05.01.054', '05.01.054',
      '05.01.055', '05.01.055',
      '10.01.050',
      '10.01.051',
      '10.02.050' );

      { INTERCOUMNICACION CON MAHA }

      SECCION_FIN = 'ENDOFFILE';
      FINALIZADO = '999999';
      FINAL_FICHERO = 'END OF FILE';
      CADENA_VACIA='';
      CADENA_ERRONEA1='-.-';
      CADENA_ERRONEA2='--';
      CADENA_ERRONEA3='----';
      CADENA_ERRONEA4='-----';
      CADENA_ERRONEA5='---';

      CABECERA = 'HEADER';
      DATOS_OUT = 'DATAOUT';
      DATOS_IN = 'DATAIN';

 { LITERALES DE LOCALIZACIONES FAX 27-08-96}
    EJES_1_3 = ' EN EL %der EJE';
    EJES_OTROS = ' EN EL %d� EJE';
    SUPERIOR_IZQUIERDA = ' EN PARTE DELANTERA IZQUIERDA';
    SUPERIOR_DERECHA = ' EN PARTE DELANTERA DERECHA';
    SUPERIOR_CENTRAL = ' EN PARTE DELANTERA CENTRAL';
    CENTRAL = ' EN PARTE CENTRAL MEDIA';
    CENTRAL_IZQUIERDA = ' EN PARTE CENTRAL IZQUIERDA';
    CENTRAL_DERECHA = ' EN PARTE CENTRAL DERECHA';
    INFERIOR_IZQUIERDA = ' EN PARTE TRASERA IZQUIERDA';
    INFERIOR_DERECHA = ' EN PARTE TRASERA DERECHA';
    INFERIOR_CENTRAL = ' EN PARTE TRASERA CENTRAL';
    PARTE_COMODIN = '';

  { CODIGOS DE ERROR POSIBLES CUANDO SE LEE EL FICHERO INI DE MAHA }
    NO_HAY_ERROR = 0;
    ERR_FICHERO_INI_NO_COMPLETO = 1;
    ERR_FICHERO_INI_NOMBRE_MATRICULA_DISTINTO = 2;
    ERR_FICHERO_INI_CODIGOS_ERRONEOS = 3;
    ERR_TINSPECCION_NO_ACTUALIZADA = 4;
    ERR_REGISTRO_DATOSINSPECCION_NO_INSERTADO = 5;
    ERR_REGISTRO_DATOSINSPECCION_VISUAL_NO_INSERTADO = 7;
    ERR_TESTADOINSP_NO_ACTUALIZADO = 8;

    { CODIGOS DE LOCALIZACIONES FAX 27-08-96}
    SUP_IZQ = 10;
    SUP_CEN = 11;
    SUP_DER = 12;
    CEN_IZQ = 13;
        CEN = 14;
    CEN_DER = 15;
    INF_IZQ = 16;
    INF_CEN = 17;
    INF_DER = 18;

     { CODIGOS DE LOCALIZACIONES EURO 3.18}
    LOCALIZACION_DEFECTOS_318 : Array [1..18] of String =
    (' EN PARTE TRASERA DERECHA',
     ' EN PARTE TRASERA CENTRAL',
     ' EN PARTE TRASERA IZQUIERDA',
     ' EN PARTE CENTRAL DERECHA',
     ' EN PARTE CENTRAL CENTRO',
     ' EN PARTE CENTRAL IZQUIERDA',
     ' EN PARTE DELANTERA DERECHA',
     ' EN PARTE DELANTERA CENTRAL',
     ' EN PARTE DELANTERA IZQUIERDA',
     ' EJE 9',
     ' EJE 8',
     ' EJE 7',
     ' EJE 6',
     ' EJE 5',
     ' EJE 4',
     ' EJE 3',
     ' EJE 2',
     ' EJE 1');

    SUP_IZQ_N = 512;  // antes 4 por error
    SUP_CEN_N = 1024;
    SUP_DER_N = 2048;
    CEN_IZQ_N = 4096;
        CEN_N = 8192;
    CEN_DER_N = 16384;
    INF_IZQ_N = 32768;
    INF_CEN_N = 65536;
    INF_DER_N = 131072;

    ResourceString
        MSJ_ERR_FICHERO_INI_NO_COMPLETO = 'Fichero .Ini Incompleto ';
        MSJ_ERR_FICHERO_INI_NOMBRE_MATRICULA_DISTINTO = 'Fichero Ini y N�mero de Matr�cula Distinto';
        MSJ_ERR_FICHERO_INI_CODIGOS_ERRONEOS = 'C�digos de Fichero Ini Erroneos';
        MSJ_ERR_TINSPECCION_NO_ACTUALIZADA = 'Tabla de Inspecciones No Actualizada';
        MSJ_ERR_REGISTRO_DATOSINSPECCION_NO_INSERTADO = 'Registro Datos Inpecci�n no Insertados';
        MSJ_ERR_REGISTRO_DATOSINSPECCION_VISUAL_NO_INSERTADO = 'Registro Datos Inspecciones Visuales No Insertados';


type

  T_CODIGOS_OUT_DATA = array [PRIMER_CODIGO_OUT_DATA..ULTIMO_CODIGO_OUT_DATA] of string;
  T_CODIGOS_OUT_DATA_EURO318 = array [PRIMER_CODIGO_OUT_DATA_EURO318..ULTIMO_CODIGO_OUT_DATA_EURO318] of string;
  T_CODIGOS_OUT_HEAD = array [PRIMER_CODIGO_OUT_HEAD..ULTIMO_CODIGO_OUT_HEAD] of integer;
  T_CODIGOS_OUT_DATA_EUROAUXIL = array [PRIMER_CODIGO_OUT_DATA_AUXIL..ULTIMO_CODIGO_OUT_DATA_AUXIL] of string;

  EReadingES_OUT = class(Exception);


////////////////////////////////////////////////////////////////////////////////////////////////////
function ConvertirToBin(valor,digitos:integer):String;
var
i:integer;
begin
  if (digitos > 32) then
  digitos:=32;
  Resultado:='';
  i:=0;
  while (I < digitos) do
  begin
   if ((1 shl I) AND valor)>0 then
    Resultado:='1'+ resultado
   else
    Resultado:='0'+ resultado;
   inc(i);
  end;
  Result:=(resultado);
end;


Function Cantidad_Defectos(Binario: String): Boolean;
var
a: Integer;
Begin
Result:=false;
for A:=0 to length(Binario) do
  If (Binario[A] = '1') then
    Begin
    Result:= true;
    Break;
    end;
end;


Function MaxSecuDef(aEjercicio,aCodInspeccion: Integer): Integer;
begin
  with TSQLQuery.Create(nil) do
    try
      SQLConnection:=MyBD;
      SQL.Text:='SELECT MAX(SECUDEFE) FROM TDATINSPEVI WHERE EJERCICI=:aEjercicio  AND CODINSPE = :aCodInspeccion';
      Params[0].Value:=aEjercicio;
      Params[1].Value:=aCodInspeccion;
      open;
      Result:=Fields[0].AsInteger;
    finally
      free;
    end;
end;


////////////////////////////////////////////////////////////////////////////////////////////////////
//                        Agregado por el Pendientes a facturar fantasmas                         //
////////////////////////////////////////////////////////////////////////////////////////////////////

function PendienteFacturar(Patente:String):Boolean;
var
aQ: TClientDataset;
dsp: TDataSetProvider;
sds: TSQLDataSet;
begin
Result:=False;
sds:=TSQLDataSet.Create(application);
sds.SQLConnection := MyBD;
sds.CommandType := ctQuery;
sds.GetMetadata := false;
sds.NoMetadata := true;
sds.ParamCheck := false;
dsp := TDataSetProvider.Create(application);
dsp.DataSet := sds;
dsp.Options := [poIncFieldProps,poAllowCommandText];
aq:=TClientdataset.Create (application);
  with aq do
    try
      SetProvider(dsp);
      CommandText:='SELECT ESTADO FROM TESTADOINSP WHERE MATRICUL = :Patente';
      Params[0].Value:=Patente;
      open;
      if Fields[0].AsString = 'H' then
        result:=true;
    finally
      free;
      dsp.free;
      sds.Free;
    end;
end;


////////////////////////////////////////////////////////////////////////////////////////////////////
//                        Agregado por el comentado Nro. 131206                                   //
////////////////////////////////////////////////////////////////////////////////////////////////////
Function InspeccionEnLineaPorPatente(Patente:String): Integer;

//function InspeccionEnLinea (const iEjercicio, iCodigo:integer):boolean;  //Comentado Nro. 131206
var
    aQ: TClientDataset;
    dsp: TDataSetProvider;
    sds: TSQLDataSet;
begin
    //Determina si se trata de una inspeccion que proviene de StandBy
    //Result:=False;
    sds:=TSQLDataSet.Create(application);
    sds.SQLConnection := MyBD;
    sds.CommandType := ctQuery;
    sds.GetMetadata := false;
    sds.NoMetadata := true;
    sds.ParamCheck := false;
    dsp := TDataSetProvider.Create(application);
    dsp.DataSet := sds;
    dsp.Options := [poIncFieldProps,poAllowCommandText];
    aq:=TClientdataset.Create (application);
  with aq do
    try
      SetProvider(dsp);
      // Comentado Nro. 131206
      //CommandText := format('SELECT * FROM TESTADOINSP WHERE EJERCICI = %D AND CODINSPE = %D',[iEjercicio, iCodigo]);
      CommandText:='SELECT CODINSPE FROM TESTADOINSP WHERE MATRICUL = :Patente';
      Params[0].Value:=Patente;
      open;
      //result := recordcount > 0; Comentado Nro. 131206
      Result:=Fields[0].AsInteger;
    finally
      free;
      dsp.free;
      sds.Free;
    end;
end;

Function BusquedaPatente(CodRevision:Integer): String;
//function InspeccionEnLinea (const iEjercicio, iCodigo:integer):boolean;  //Comentado Nro. 131206
begin
  with TSQLQuery.Create(nil) do
    try
      SQLConnection:=MyBD;
      SQL.Text:='SELECT MATRICUL FROM tESTADOINSP WHERE Codinspe = :CodRevision';
      Params[0].Value:=CodRevision;
      open;
      Result:=Fields[0].AsString;
    finally
      free;
    end;
end;

Function EjercicioEnLineaPorPatente(Patente:String): Integer;
//function InspeccionEnLinea (const iEjercicio, iCodigo:integer):boolean;  //Comentado Nro. 131206
begin
  with TSQLQuery.Create(nil) do
    try
      SQLConnection:=MyBD;
      SQL.Text:='SELECT EJERCICI FROM TESTADOINSP WHERE MATRICUL = :Patente';
      Params[0].Value:=Patente;
      open;
      Result:=Fields[0].AsInteger;
    finally
      free;
    end;
end;


function EstaEnStandBy(aEjercicio,aCodInspeccion: Integer; aDataBase: TSQLConnection):Boolean;
var
aQ: TClientDataset;
dsp: TDataSetProvider;
sds: TSQLDataSet;
begin
//Determina si se trata de una inspeccion que proviene de StandBy
Result:=False;
sds:=TSQLDataSet.Create(application);
sds.SQLConnection := MyBD;
sds.CommandType := ctQuery;
sds.GetMetadata := false;
sds.NoMetadata := true;
sds.ParamCheck := false;
dsp := TDataSetProvider.Create(application);
dsp.DataSet := sds;
dsp.Options := [poIncFieldProps,poAllowCommandText];
aq:=TClientdataset.Create (application);
With aQ do
  Try
    SetProvider(dsp);
    CommandText := format('Select * From TAUDITORIAINSPECCIONES Where CODINSPE = %D And EJERCICI = %D',[aCodInspeccion,aEjercicio]);
    Open;
    If RecordCount>0 Then
      Result:=True;
  Finally
    Close;
    Free;
    dsp.Free;
    sds.Free;
  end;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////

function IsStandBy(aEjercicio,aCodInspeccion: Integer; aDataBase: TSQLConnection):Boolean;
var
aQ: TClientDataset;
dsp: TDataSetProvider;
sds: TSQLDataSet;
begin
//Determina si se trata de una inspeccion que proviene de StandBy
Result:=False;
sds:=TSQLDataSet.Create(application);
sds.SQLConnection := MyBD;
sds.CommandType := ctQuery;
sds.GetMetadata := false;
sds.NoMetadata := true;
sds.ParamCheck := false;
dsp := TDataSetProvider.Create(application);
dsp.DataSet := sds;
dsp.Options := [poIncFieldProps,poAllowCommandText];
aq:=TClientdataset.Create (application);
With aQ do
  Try
    SetProvider(dsp);
    CommandText := format('Select * From RESULTADO_INSPECCION Where CODINSPE = %D And EJERCICI = %D',[aCodInspeccion,aEjercicio]);
    Open;
    If RecordCount>0 Then
      Result:=True;
  Finally
    Close;
    Free;
    dsp.Free;
    sds.Free;
  end;
end;

function InsertaResultadoRevision(codrevision,ejercici:integer;codigoeuro,valor,codtipoprueba:string;codsbt:integer):boolean;
var {codsbt:integer;} codprueba:string;
 valor_medida:real;  NUMREVISION:LONGINT;
 K_REENVIOS,inserta,insertaREENVIOLINEA,insertaRESULTADOREVISION:integer;
begin
codprueba:=codtipoprueba;
inserta:=0;

               with TSQLQuery.Create(nil) do
               try
                SQLConnection:=MyBD;
                SQL.Text:='SELECT  CASE WHEN TIPO=''A'' then 1 else 2 end as numrevision  FROM TINSPECCION  WHERE CODINSPE =:codrevision';
                Params[0].Value:=codrevision;
                open;
                NUMREVISION:=Fields[0].AsInteger;
               finally
                free;
               end;

               {*
               with TSQLQuery.Create(nil) do
               try
               SQLConnection:=MyBD;
               SQL.Text:='SELECT  COUNT(*) FROM TINSPDEFECT WHERE codinspe=:codrevision' ;
               Params[0].Value:=codrevision;
               open;
               insertaRESULTADOREVISION:=Fields[0].AsInteger;
               finally
               free;
               end;
               if (insertaRESULTADOREVISION>0)   THEN
               begin
                    with TSQLQuery.Create(nil) do
                    try
                      SQLConnection:=MyBD;
                      SQL.Text:='delete  FROM TINSPDEFECT WHERE codinspe=:codrevision';
                      Params[0].Value:=codrevision;
                      execsql;
                    finally
                      free;
                    end;
               END;
               *} 
               with TSQLQuery.Create(nil) do
               try
               SQLConnection:=MyBD;
               SQL.Text:='SELECT  COUNT(*) FROM RESULTADO_INSPECCION WHERE trim(CODPRUEBA)=:codprueba and  CODESTACIONSBT=:codsbt and codinspe=:codrevision' ;
               Params[0].Value:=trim(codprueba);
               Params[1].Value:=codsbt;
               Params[2].Value:=codrevision;
               open;
               insertaRESULTADOREVISION:=Fields[0].AsInteger;
               finally
               free;
               end;
               if (insertaRESULTADOREVISION>0)   THEN
               begin
                    with TSQLQuery.Create(nil) do
                    try
                      SQLConnection:=MyBD;
                      SQL.Text:='delete  FROM  RESULTADO_INSPECCION  where CODinspe=:codinspe  AND TRIM(CODPRUEBA)=:codprueba';
                      Params[0].Value:=codrevision;
                      Params[1].Value:=trim(codprueba);
                      execsql;
                    finally
                      free;
                    end;
               END;

               with TSQLQuery.Create(nil) do
               try
                      SQLConnection:=MyBD;
                      SQL.Text:='INSERT INTO RESULTADO_INSPECCION (CODINSPE,EJERCICI,CODESTACIONSBT,CODPRUEBA,VALORMEDIDA) VALUES (:codrevision,:ejercici,:codsbt,:codprueba,:valormedida)';
                      Params[0].Value:=codrevision;
                      Params[1].Value:=ejercici;
                      Params[2].Value:=codsbt;
                      Params[3].Value:=trim(codprueba);
                      if trim(codprueba)='0401'  then
                        if (Pos('-', trim(valor)) > 0)  then  valor:=copy(trim(valor),2,length(trim(valor)));
                      if copy(trim(codprueba),1,2)='03'  then
                        if (Pos('-', trim(valor)) > 0)  then   valor:=copy(trim(valor),2,length(trim(valor)));


                      if (Pos('.', trim(valor)) = 0)  then  Params[4].Value:=trim(valor)
                      else Params[4].Value:= conviertepuntoencoma(trim(valor));
                      execsql;
               finally
                 free;
               end;

end;

Function HasDefectNotVisual(aEjercicio,aCodInspeccion: Integer; aDataBase: TSQLConnection):Boolean;
var
aQ: TClientDataset;
dsp: TDataSetProvider;
sds: TSQLDataSet;
begin
//Determina si la inspeccion siendo StandBy tuvo defectos no visuales anteriormente
Result:=False;
sds:=TSQLDataSet.Create(application);
sds.SQLConnection := MyBD;
sds.CommandType := ctQuery;
sds.GetMetadata := false;
sds.NoMetadata := true;
sds.ParamCheck := false;
dsp := TDataSetProvider.Create(application);
dsp.DataSet := sds;
dsp.Options := [poIncFieldProps,poAllowCommandText];
aq:=TClientdataset.Create (application);
  With aQ do
    Try
      SetProvider(dsp);
      CommandText := Format('Select * From TINSPDEFECT Where CODINSPE = %D And EJERCICI = %D',[aCodInspeccion,aEjercicio]);
      Open;
        If RecordCount>0 Then
          Result:=True;
    Finally
      Close;
      Free;
      dsp.Free;
      sds.Free;
    end;
end;


Procedure SetStatToOk(aEjercicio,aCodInspeccion: Integer; aDataBase: TSQLConnection);
begin
//En una inspeccion proveniente de Standby pone todos sus defectoa a OK
MyBD.ExecuteDirect(Format('UPDATE TDATINSPEVI Set CALIFDEF = ''0'' Where CODINSPE = %D And EJERCICI = %D',[aCodInspeccion,aEjercicio]));
MyBD.ExecuteDirect(Format('UPDATE TINSPDEFECT Set CALIFDEF = ''0'' Where CODINSPE = %D And EJERCICI = %D',[aCodInspeccion,aEjercicio]));
end;



function CodigoInspeccion(s : string) : integer;
begin
 {s = 'aabzzzzeeeeiiiiiibr'}
 result := StrToInt(rightstr(leftstr(s,17),6));
end;


function Ejercicio (s : string) : integer;
{ Se supone que ejercicio sera siempre mayor a 96, por lo tanto esta funcionar�
  hasta el 20095 }
begin
//ARGETINA
{
  if StrToInt(Copy(s,1,2)) < 96 then
    result := 2000 + StrToInt(Copy(s,1,2))
  else
    result := 1900 + StrToInt(Copy(s,1,2));  }

  //CHILE
 result :=  StrToInt(Copy(s,1,4));
end;


{ **************************************************************************** }

function NombreYMatriculaIguales (const aFile : TiniFile): boolean;
const
//  CABECERA = 'HEADER';
  MATRICULA = '10100';
  NADA = '*';
begin
  try
    result := ( UpperCase(ChangeFileExt(ExtractFileName(aFile.FileName),'')) { SE SUPONE SIN EXTENSION SEGUN LUCHO}
                                   =
                UpperCase(aFile.ReadString(CABECERA, MATRICULA, NADA)))
  except
    on E : Exception do
    begin
      result := False;
      fAnomalias.PonAnotacion (TRAZA_SIEMPRE,0, FICHERO_ACTUAL, 'ERROR MUY RARO AL COMPROBAR SI EL NOMBRE DEL FICHERO Y EL CAMPO MATRICULA SON INGUALES POR: ' + E.message);
    end;
  end;
end;

function buscarPatenteTXT (const aFile : TiniFile): string;
const
//  CABECERA = 'HEADER';
  MATRICULA = '10100';
  NADA = '*';
begin
  try
    result := UpperCase(aFile.ReadString(CABECERA, MATRICULA, NADA));
  except
    on E : Exception do
    begin
      result := NULL;
      fAnomalias.PonAnotacion (TRAZA_SIEMPRE,0, FICHERO_ACTUAL, 'ERROR MUY RARO AL BUSCAR EL CAMPO MATRICULA POR: ' + E.message);
    end;
  end;
end;

{ **************************************************************************** }

function EjercicioYCodigoOk (const aFile : TIniFile;
                             var iCodigo, iEjercicio : integer) : boolean;
const
//  CABECERA = 'HEADER';
  NADA = '*';
  INFORME_INSPECCION = '10303';
var
  sNumeroInformeInspeccion : string;
begin
  result := True;
  try
    sNumeroInformeInspeccion := AFile.ReadString(CABECERA, INFORME_INSPECCION, NADA);
    iCodigo := CodigoInspeccion(sNumeroInformeInspeccion);
    iEjercicio := Ejercicio(AFile.ReadString(CABECERA, '10121', NADA));
  except
    on E: Exception do
    begin
      result := False;
      iCodigo := 0;
      iEjercicio := 0;
      fAnomalias.PonAnotacion (TRAZA_SIEMPRE,1, FICHERO_ACTUAL,'ERROR MUY RARO AL OBTENER EL EJERCICIO Y EL CODIGO DE INPSECCION POR: ' + E.message);
    end;
  end;
end;

{ **************************************************************************** }





  
function  InsercionAdicionalesOK (const aFile: TIniFile; const iEjercicio, iCodigo : integer;IsSBy: Boolean) : boolean;
const
NADA = '*';
var
I,ModInsert : Integer;

begin
result := True;
  try

    ModInsert:=0;
    with DataDiccionario.TDATA_REGLOSCOPIO do
      begin
       { INSERCION EN LA TABLA DATOS INSPECCION AL FINAL }
       {Si no viene de StdBy o Viene de StdBy y no tiene Defectosvisuales}
        If  (not IsSBy) Or ( IsSBy And HasDefectNotVisual(iEjercicio,iCodigo,MyBd) ) then
          begin
            close;
            SetProvider(DataDiccionario.dspTDATA_REGLOSCOPIO);
            CommandText := Format('Select * From TDATA_REGLOSCOPIO Where CODINSPE = %D And EJERCICI = %D',[iCodigo,iEjercicio]);
            open;
            {Si tiene al menos un registro en la tabla TDATADICIONAL entonces hace el update, sino el insert}
            If (DataDiccionario.sdsTDATA_REGLOSCOPIO.RecordCount > 0) Then
              Edit
            else
              Append; { Paso a modo insercion }

            { Atributos de la clave }
            Fields[0].AsInteger := iEjercicio;
            Fields[1].AsInteger := iCodigo;

            { Dem�s atributos }
              for I:=low(T_CODIGOS_OUT_DATA_EUROAUXIL) to high(T_CODIGOS_OUT_DATA_EUROAUXIL) do
                begin
                  If ((Trim(aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA_EUROAUXIL[I], NADA))<>CADENA_VACIA) And
                      (Pos(CADENA_ERRONEA3,aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA_EUROAUXIL[I], NADA))=0)and
                      (Pos(CADENA_ERRONEA4,aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA_EUROAUXIL[I], NADA))=0)) Then
                    Begin
                      if (Trim(aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA_EUROAUXIL[I], NADA))<>NADA) Then
                        begin
                            ModInsert:=1;
                            Fields[I+1].AsString :=  aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA_EUROAUXIL[I], NADA);
                          If copy(Fields[I+1].AsString,Length(Fields[I+1].AsString),Length(Fields[I+1].AsString))=  '.'  then
                            Fields[I+1].AsString:= copy(Fields[I+1].AsString,1,Length(Fields[I+1].AsString)-1)
                        end;
                      {$IFDEF TRAZAS}
                      fTrazas.PonAnotacion(TRAZA_REGISTRO,0, FICHERO_ACTUAL, 'INSERTADO EN EL REGISTRO : ' + IntToStr(iEjercicio) + '-' + IntToStr(iCodigo) + '-' + FieldDefs.Items[I+1].Name + ', EL CAMPO : ' + TCODIGOS_OUT_DATA_EUROAUXIL[I] + ', VALOR :' +aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA_EUROAUXIL[I], NADA));
                      {$ENDIF}
                    end
                end;
              if ModInsert=1 then
              begin
                Fields[I+1].AsDateTime := now;
                Post; { Paso a modo browse }
                ApplyUpdates(0);   {Hace el commit}
              end;
           end
        else
        //Si es StandBy No me fijo la segunda condicion del if de arriba (es StandBy y No HasDefNoVisual) entonces.
        begin
          if IsSBy then
            begin
              close;
              SetProvider(DataDiccionario.dspTDATA_REGLOSCOPIO);
              CommandText := Format('Select * From TDATA_REGLOSCOPIO Where CODINSPE = %D And EJERCICI = %D',[iCodigo,iEjercicio]);
              open;
              Edit; { Paso a modo insercion } // De momento se comporta igual que si no se pasara a STAND-BY
              { Atributos de la clave }
              Fields[0].AsInteger := iEjercicio;
              Fields[1].AsInteger := iCodigo;
              { Dem�s atributos }
                  for I:=low(T_CODIGOS_OUT_DATA_EUROAUXIL) to high(T_CODIGOS_OUT_DATA_EUROAUXIL) do
                    begin
                    if ((Trim(aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA_EUROAUXIL[I], NADA))<>CADENA_VACIA) And
                       (Pos(CADENA_ERRONEA3,aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA_EUROAUXIL[I], NADA))=0)and
                       (Pos(CADENA_ERRONEA4,aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA_EUROAUXIL[I], NADA))=0)) Then
                      Begin
                      //Modificado Lucho
                        if (Trim(aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA_EURO318[I], NADA))<>NADA) Then
                          begin
                              ModInsert:=1;
                              Fields[I+1].AsString :=  aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA_EUROAUXIL[I], NADA);
                            If copy(Fields[I+1].AsString,Length(Fields[I+1].AsString),Length(Fields[I+1].AsString))=  '.'  then
                              Fields[I+1].AsString:= copy(Fields[I+1].AsString,1,Length(Fields[I+1].AsString)-1);
                          end;
                        {$IFDEF TRAZAS}
                        fTrazas.PonAnotacion(TRAZA_REGISTRO,0, FICHERO_ACTUAL, 'INSERTADO EN EL REGISTRO : ' + IntToStr(iEjercicio) + '-' + IntToStr(iCodigo) + '-' + FieldDefs.Items[I+1].Name + ', EL CAMPO : ' + TCODIGOS_OUT_DATA_EUROAUXIL[I] + ', VALOR :' +aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA_EUROAUXIL[I], NADA));
                        {$ENDIF}
                      end;
                    end;
                  end;

                if ModInsert=1 then
                 begin
                   Fields[I+1].AsDateTime := now;
                   Post; { Paso a modo browse }
                   ApplyUpdates(0);
                 end;
            end;
        end;

  except
    on E : Exception do
    begin
      fAnomalias.PonAnotacion (TRAZA_SIEMPRE,7, FICHERO_ACTUAL,'ERROR MUY RARO AL INSERTAR EL RESGISTRO EN LA TABLA RESULTADO_INSPECCION POR: ' + E.message);
      result := False;
    end;
  end;
end;






function ActualizacionInspeccionOk (const aFile: TIniFile; const iEjercicio, iCodigo : integer): boolean;
const
  UNICO = 1;
  VACIO = '';

//  CABECERA = 'HEADER';
  NADA = '*';

var
  i : integer;
  Patente: String;
  fecha_leida,dia,mes,fecha_completa: String;
begin
  try
    result := True;
    try
      with aFile do
      begin
        for i := PRIMERA_ZONA to ULTIMA_ZONA do
        begin
          try
              if ReadString(CABECERA, HORAS_ENTRADA_ZONA[I], NADA)<>'*' then
               begin
                  fecha_leida:=ReadString(CABECERA, HORAS_ENTRADA_ZONA[I], NADA);
                  dia:=copy(fecha_leida,1,2);
                  mes:=copy(fecha_leida,4,2);
                  fecha_completa:=copy(fecha_leida,7,length(trim(fecha_leida)));
                  if HORAS_ENTRADA_ZONA[I]='15200--' then
                  begin
                     fecha_leida:=trim(mes)+'/'+trim(dia)+'/'+fecha_completa ;
                      HORAS_INICIO_ZONA[I] := StrToDateTime(fecha_leida);
                   end  else
                        HORAS_INICIO_ZONA[I] := StrToDateTime(ReadString(CABECERA, HORAS_ENTRADA_ZONA[I], NADA));
              end;
          except
            on E : Exception do
            begin
              HORAS_INICIO_ZONA[I] := ANIO_O;
              fIncidencias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'LA HORA LEIDA NO ES VALIDA Y SE TOMARA COMO NULA POR: ' + E.message);
            end;
          end;
        end;

        for i := PRIMERA_ZONA to ULTIMA_ZONA do
        begin
          try
            if ReadString(CABECERA, HORAS_SALIDA_ZONA[I], NADA)<>'*' then
             begin
              fecha_leida:=ReadString(CABECERA, HORAS_SALIDA_ZONA[I], NADA);
                  dia:=copy(fecha_leida,1,2);
                  mes:=copy(fecha_leida,4,2);
                  fecha_completa:=copy(fecha_leida,7,length(trim(fecha_leida)));

                 if HORAS_SALIDA_ZONA[I]='15101--' then
                  begin
                   HORAS_INICIO_ZONA[3]:=   StrToDateTime(ReadString(CABECERA, HORAS_SALIDA_ZONA[I], NADA));
                  end;

                  if HORAS_SALIDA_ZONA[I]='15201--' then
                  begin
                     fecha_leida:=trim(mes)+'/'+trim(dia)+'/'+fecha_completa ;
                      HORAS_FINAL_ZONA[I] := StrToDateTime(fecha_leida);
                   end  else
                        HORAS_FINAL_ZONA[I] := StrToDateTime(ReadString(CABECERA, HORAS_SALIDA_ZONA[I], NADA));

            end;
          except
            on E : Exception do
            begin
              HORAS_FINAL_ZONA[I] := ANIO_O;
              fIncidencias.PonAnotacion(TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'LA HORA LEIDA NO ES VALIDA Y SE TOMARA COMO NULA POR: ' + E.message);
            end;
          end;
        end;
      end;

      with DataDiccionario.QryUpdateInspeccion do
      begin
        Close;
        SetProvider(DataDiccionario.dspQryUpdateInspeccion);
        CommandText := 'UPDATE TINSPECCION '+
  'SET HORENTZ1= :HoraEntrada_Z1,HORENTZ2= :HoraEntrada_Z2,HORENTZ3= :HoraEntrada_Z3,'+
  'HORSALZ1= :HoraSalida_Z1,HORSALZ2= :HoraSalida_Z2,HORSALZ3= :HoraSalida_Z3 '+
  'WHERE EJERCICI= :UnEjercicio AND CODINSPE= :UnCodigo AND EXISTS ( SELECT I.EJERCICI, I.CODINSPE '+
  '  FROM TINSPECCION I, TESTADOINSP E, TVEHICULOS V WHERE '+
  '  I.CODINSPE  =  E.CODINSPE AND I.EJERCICI  =  E.EJERCICI AND I.CODVEHIC  =  V.CODVEHIC AND '+
  '             (E.MATRICUL  =  V.PATENTEN OR E.MATRICUL  =  V.PATENTEA) AND '+
  '              E.CODINSPE  =  :UnCodigo AND E.EJERCICI  =  :UnEjercicio AND '+
  '              E.MATRICUL  =  :UnaMatricula AND E.ESTADO   <>  ''E'' )';


        for i := PRIMERA_ZONA to ULTIMA_ZONA do
         {if HORAS_INICIO_ZONA[I] <> ANIO_O then
          { ParambyName(PARAMETROS_ENTRADA_ZONA[I]).Value := VACIO
         else } params.ParambyName(PARAMETROS_ENTRADA_ZONA[I]).Value := HORAS_INICIO_ZONA[I];

        for i := PRIMERA_ZONA to ULTIMA_ZONA do
         {if HORAS_FINAL_ZONA[I] <> ANIO_O then
           {ParambyName(PARAMETROS_SALIDA_ZONA[I]).Value := VACIO
         else} params.ParambyName(PARAMETROS_SALIDA_ZONA[I]).Value := HORAS_FINAL_ZONA[I];
        Patente:= UpperCase(ChangeFileExt(ExtractFileName(aFile.FileName),''));
        params.ParambyName('UnCodigo').Value := iCodigo;
        params.ParambyName('UnEjercicio').Value := iEjercicio;
        params.ParambyName('UnaMatricula').Value := Patente;
        {$IFDEF TRAZAS}
          fTrazas.PonComponente(TRAZA_SQL,1,FICHERO_ACTUAL,DataDiccionario.QryUpdateInspeccion);
        {$ENDIF}
        Execute;
        Application.ProcessMessages;
      end;

    except
      on E : Exception do
      begin
        result := False;
        fAnomalias.PonAnotacion (TRAZA_SIEMPRE,5, FICHERO_ACTUAL,'ERROR MUY RARO AL ACTUALIZAR LA TABLA TINSPECCION POR: ' + E.message);
      end;
    end;
  finally
    DataDiccionario.QryUpdateInspeccion.Close;
  end;

end;

{ **************************************************************************** }

function FicheroCompleto (const aFile : TIniFile) : boolean;
const
{  SECCION_FIN = 'ENDOFFILE';}
{  DATOS = 'DATAOUT';}
{  FINALIZADO = '999999';
{  FINAL_FICHERO = 'END OF FILE';}
  NADA = '*';
var
  Cadena: String;
begin
  try
    Cadena:=aFile.ReadString(SECCION_FIN,{DATOS,} FINALIZADO, NADA);
    result := ( Cadena = FINAL_FICHERO);
  except
    on E : Exception do
    begin
      result := False;
      fAnomalias.PonAnotacion (TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'ERROR MUY RARO AL COMPROBAR SI MAHA TERMINO DE ESCRIBIR EL FICHERO POR: ' + E.message);
    end;
  end;
end;

{ **************************************************************************** }
  function esNumero (valor : string) : boolean;
  var
    numero : integer;
  begin
    try
      if valor[1] in ['0'..'9'] then
        if valor[2] in ['0'..'9'] then
          if valor[3] in ['0'..'9'] then result := true else result := false;
      //result := true;
    except
      result := false;
    end;
  end;

  function  devuelve_codigoinspector(nombre:string):integer;
  var nom,ape:string; posi:longint;numValid: boolean;
  begin
   numvalid:=false;
   if trim(nombre)<>'' then numvalid:=esNumero(leftstr(nombre,3));
   if numvalid
   then
   devuelve_codigoinspector:=strtoint(leftstr(nombre,3))
   else
   devuelve_codigoinspector:=0 ;
  // begin
    //posi:=pos(' ',trim(nombre));
    //nom:=UpperCase(trim(copy(trim(nombre),0,posi-1)));
    //ape:=UpperCase(trim(copy(trim(nombre),posi+1,length(nombre))));

   {
    with TSQLQuery.Create(nil) do
         try
           SQLConnection:=MyBD;
           SQL.Text:='select numrevis from trevisor where trim(nomrevis)=UPPER(:NOM)';
           Params[0].Value:=nombre;
           //Params[1].Value:=TRIM(APE);
           open;
              if trim(inttostr(fields[0].ASINTEGER))<>'' then
                 devuelve_codigoinspector:=fields[0].asinteger
                 else
                 devuelve_codigoinspector:=0;
            finally
           free;
           end;
     end; }

end;

//function Actualiza_mecanicoRevision(const aFile: TIniFile;codrevision:longint; valor,codtipoprueba:string):boolean;
function Actualiza_mecanicoRevision(const aFile: TIniFile;codrevision:longint):boolean;
var {codsbt:integer;} codprueba:string;
campo:array[1..6] of string;
sql:string;  i:integer;
begin

 IF TRIM(aFile.ReadString(DATOS_OUT, '15011', ''))<>'' THEN
        campo[1]:='numlinea1='+aFile.ReadString(DATOS_OUT, '15011', '')
        else
         campo[1]:='*';


 IF TRIM(aFile.ReadString(DATOS_OUT, '15012', ''))<>'' THEN
        campo[2]:='codmecanico1='+inttostr(devuelve_codigoinspector(aFile.ReadString(DATOS_OUT, '15012', '')))
         else
         campo[2]:='*';



 IF TRIM(aFile.ReadString(DATOS_OUT, '15111', ''))<>'' THEN
        campo[3]:='numlinea2='+aFile.ReadString(DATOS_OUT, '15111', '')
         else
         campo[3]:='*';

 IF TRIM(aFile.ReadString(DATOS_OUT, '15112', ''))<>'' THEN
        campo[4]:='codmecanico2='+inttostr(devuelve_codigoinspector(aFile.ReadString(DATOS_OUT, '15112', '')))
         else
         campo[4]:='*';



  IF TRIM(aFile.ReadString(DATOS_OUT, '15211', ''))<>'' THEN
        campo[5]:='numlinea3='+aFile.ReadString(DATOS_OUT, '15211', '')
         else
         campo[5]:='*';

 IF TRIM(aFile.ReadString(DATOS_OUT, '15212', ''))<>'' THEN
        campo[6]:='codmecanico3='+inttostr(devuelve_codigoinspector(aFile.ReadString(DATOS_OUT, '15212', '')))
           else
         campo[6]:='*';

  for i:=1 to 6 do
  begin
    if trim(campo[i])<>'*' then
      begin
        with TSQLQuery.Create(nil) do
         try
           SQLConnection:=MyBD;
           SQL.Text:='update  tmecanicoinspeccion set '+trim(campo[i])+' WHERE CODINSPE=:codrevision';
            Params[0].Value:=codrevision;

            execsql;

            finally
           free;
           end;
       end;

  end;
end;

function  InsercionDatosInspeccionOK (const aFile: TIniFile; const iEjercicio, iCodigo : integer;IsSBy: Boolean) : boolean;
const
NADA = '*';
var
I : Integer;
laura: string;
laura2,codsbt:INTEGER;
//TD:  TTransactionDesc;
aqtipoorueba:TSQLQuery;
CODIGOEUROSYSTEM,codtipoprueba:STRING;
fecha_leida,dia,mes,fecha_completa: String;
begin
result := True;
  try
  ///insert  mecanicos revision
 //   with DataDiccionario.TDATINSPECC do
    with DataDiccionario.TDATRESULTREV do
      begin
       { INSERCION EN LA TABLA DATOS INSPECCION AL FINAL }
       {Si no viene de StdBy o Viene de StdBy y no tiene Defectosvisuales}
        If  (* (not IsSBy) Or *) ( IsSBy And HasDefectNotVisual(iEjercicio,iCodigo,MyBd)  OR (1=1)) then
          begin
            close;
            SetProvider(DataDiccionario.dspTDATRESULTREV);
            CommandText := Format('Select * From RESULTADO_INSPECCION Where CODINSPE = %D And EJERCICI = %D',[iCodigo,iEjercicio]);
            open;
            {Si tiene al menos un registro en la tabla TDATINSPECC entonces hace el update, sino el insert}
            If (DataDiccionario.sdsTDATIRESULREV.RecordCount > 0) Then
              Edit
            else
              Append; { Paso a modo insercion }

            { Atributos de la clave }
            Fields[0].AsInteger := iEjercicio;
            Fields[1].AsInteger := iCodigo;

            Actualiza_mecanicoRevision(aFile,iCodigo);

            { Dem�s atributos }
            if VerEurosystem = '7.5' then
              begin

                     aqtipoorueba:=TSQLQuery.Create(nil);
                     aqtipoorueba.SQLConnection:=MyBD;
                     aqtipoorueba.SQL.Add(' SELECT  TVE.CODESTACIONSBT ESTACIONSBTOBLIG, ');
                     aqtipoorueba.SQL.Add('  TP.CODPRUEBA      CODPRUEBAOBLIG,TP.DESPRUEBA       DESPRUEBA,TP.ORIGENRESULTADO ORIGENRESULTADO,  ');
                     aqtipoorueba.SQL.Add(                    '  TP.FUNCION         FUNCION,TP.CODPRUEBA       CODPRUEBAREAL,TP.CODEUROSYSTEM,TP.CONRESULTADO    CONRESULTAD ');
                     aqtipoorueba.SQL.Add(                     '  FROM TTIPOVEHICULOEVALUACION TVE,  TINSPECCION R  , TVEHICULOS V , TTIPOESPVEH TE, TIPOPRUEBA TP  ');
                        aqtipoorueba.SQL.Add(                     '  WHERE R.CODINSPE = '+inttostr(iCodigo));
                     aqtipoorueba.SQL.Add(                     '  AND V.CODVEHIC = R.CODVEHIC  ');
                     aqtipoorueba.SQL.Add(                     '  AND V.TIPOESPE = TE.TIPOESPE ');
                     aqtipoorueba.SQL.Add(                     '  AND TE.TIPOVEHI = TVE.TIPOVEHI  ');
                     aqtipoorueba.SQL.Add(                     '  AND TVE.CODESTACIONSBT=TP.CODESTACIONSBT   ');
                     aqtipoorueba.SQL.Add(                     '  AND TP.CONVALOR = ''S''  and TP.CODEUROSYSTEM is not null ');
                     aqtipoorueba.SQL.Add(                     '  ORDER BY 1');
                     aqtipoorueba.open;

                     //Si la Versi�n del Euro es 3.18 Lo va hacer desde I:=1 (30000) hasta 75 (15211)
             // for I:=low(T_CODIGOS_OUT_DATA_EURO318) to high(T_CODIGOS_OUT_DATA_EURO318) do
               //for I:=1 to aqtipoorueba.recordcount do
            while not  aqtipoorueba.Eof do
                begin

                 CODIGOEUROSYSTEM:=TRIM(aqtipoorueba.Fields[6].ASSTRING);
                  codtipoprueba:= TRIM(aqtipoorueba.Fields[5].ASSTRING);
                  codsbt:=aqtipoorueba.Fields[0].asinteger;

                {
                Primero se fija que el valor que viene no sea *, luego con el Pos se fija si la
                cadena Erronea (substring) esta dentro de la cadena que viene en la linea del archivo y si
                se encuentra me devuelve la poscision del primer caracter del substring
                }
                  If ((Trim(aFile.ReadString(DATOS_OUT, CODIGOEUROSYSTEM, NADA))<>CADENA_VACIA) And
                      (Pos(CADENA_ERRONEA3,aFile.ReadString(DATOS_OUT, CODIGOEUROSYSTEM, NADA))=0)and
                      (Pos(CADENA_ERRONEA4,aFile.ReadString(DATOS_OUT, CODIGOEUROSYSTEM, NADA))=0)) Then
                    Begin
                    {
                    Entonces si se cumplen estas condiciones si la linea del archivo no es * entonces el campo del registro I+1
                    se vuelve los datos de la linea del archo. Luego se hace algo para sacar el punto
                    }
                      if (Trim(aFile.ReadString(DATOS_OUT, CODIGOEUROSYSTEM, NADA))<>NADA) Then
                        begin

                          If (CODIGOEUROSYSTEM='15010') or  (CODIGOEUROSYSTEM='15110') or (CODIGOEUROSYSTEM='15210') or (CODIGOEUROSYSTEM='36975') or (CODIGOEUROSYSTEM='36976') or (CODIGOEUROSYSTEM='36977') or (CODIGOEUROSYSTEM='36978')  then
                           begin

                            fecha_leida:=aFile.ReadString(DATOS_OUT, CODIGOEUROSYSTEM, NADA);
                            dia:=copy(fecha_leida,1,2);
                            mes:=copy(fecha_leida,4,2);
                            fecha_completa:=copy(fecha_leida,7,length(trim(fecha_leida)));
                            InsertaResultadoRevision(iCodigo,iEjercicio,CODIGOEUROSYSTEM,trim(mes)+'/'+trim(dia)+'/'+fecha_completa,codtipoprueba,codsbt);
                           end
                          else
                          begin
                           {$IFDEF TRAZAS}

                             fTrazas.PonAnotacion(TRAZA_REGISTRO,0, FICHERO_ACTUAL, 'INSERTADO EN EL REGISTRO : ' + IntToStr(iEjercicio) + '-' + IntToStr(iCodigo) + '-  EL CAMPO : ' + CODIGOEUROSYSTEM + ', VALOR :' +aFile.ReadString(DATOS_OUT, CODIGOEUROSYSTEM, NADA));
                            {$ENDIF}
                            InsertaResultadoRevision(iCodigo,iEjercicio,CODIGOEUROSYSTEM,aFile.ReadString(DATOS_OUT, CODIGOEUROSYSTEM, NADA),codtipoprueba,codsbt);
                           end;

                        end;


                    end ;
                     aqtipoorueba.next;
                end;
              end;

            end
        else
        //Si es StandBy No me fijo la segunda condicion del if de arriba (es StandBy y No HasDefNoVisual) entonces.
        begin
          if IsSBy then
            begin
              close;
              SetProvider(DataDiccionario.dspTDATRESULTREV);
              CommandText := Format('Select * From RESULTADO_INSPECCION Where CODINSPE = %D And EJERCICI = %D',[iCodigo,iEjercicio]);
              open;
              Edit; { Paso a modo insercion } // De momento se comporta igual que si no se pasara a STAND-BY
              { Atributos de la clave }
              Fields[0].AsInteger := iEjercicio;
              Fields[1].AsInteger := iCodigo;
              { Dem�s atributos }
              if VerEurosystem = '7.5' then
                begin

                  for I:=low(T_CODIGOS_OUT_DATA) to high(T_CODIGOS_OUT_DATA) do

                    begin
                      if ((Trim(aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA[I], NADA))<>CADENA_VACIA) And
                         (Pos(CADENA_ERRONEA1,aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA[I], NADA))=0)and
                         (Pos(CADENA_ERRONEA2,aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA[I], NADA))=0)) then
                      Begin
                         Fields[I+1].asstring := aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA[I], NADA);
                        {$IFDEF TRAZAS}
                        fTrazas.PonAnotacion(TRAZA_REGISTRO,0, FICHERO_ACTUAL, 'INSERTADO EN EL REGISTRO : ' + IntToStr(iEjercicio) + '-' + IntToStr(iCodigo) + '-' + FieldDefs.Items[I+1].Name + ', EL CAMPO : ' + TCODIGOS_OUT_DATA[I] + ', VALOR :' +aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA[I], NADA));
                        {$ENDIF}
                      end;
                    end;
                end
              else
                //Version de Euro 3.18
                begin
                  for I:=low(T_CODIGOS_OUT_DATA_EURO318) to high(T_CODIGOS_OUT_DATA_EURO318) do
                    begin
                    if ((Trim(aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA_EURO318[I], NADA))<>CADENA_VACIA) And
                       (Pos(CADENA_ERRONEA3,aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA_EURO318[I], NADA))=0)and
                       (Pos(CADENA_ERRONEA4,aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA_EURO318[I], NADA))=0)) Then
                      Begin
                      //Modificado Lucho
                        if (Trim(aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA_EURO318[I], NADA))<>NADA) Then
                          begin
                            //Fields[I+1].AsString :=  aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA_EURO318[I], NADA);
                            //if copy(Fields[I+1].AsString,Length(Fields[I+1].AsString),Length(Fields[I+1].AsString))=  '.'  then
                            //  Fields[I+1].AsString:= copy(Fields[I+1].AsString,1,Length(Fields[I+1].AsString)-1)
                            If (TCODIGOS_OUT_DATA_EURO318[I]='15010') or (TCODIGOS_OUT_DATA_EURO318[I]='15110') or (TCODIGOS_OUT_DATA_EURO318[I]='15210') then
                              Fields[I+1].AsString :=  copy(aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA_EURO318[I], NADA),5,2)
                            else
                              Fields[I+1].AsString :=  aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA_EURO318[I], NADA);
                            If copy(Fields[I+1].AsString,Length(Fields[I+1].AsString),Length(Fields[I+1].AsString))=  '.'  then
                              Fields[I+1].AsString:= copy(Fields[I+1].AsString,1,Length(Fields[I+1].AsString)-1);
                          end;
                        {$IFDEF TRAZAS}
                        fTrazas.PonAnotacion(TRAZA_REGISTRO,0, FICHERO_ACTUAL, 'INSERTADO EN EL REGISTRO : ' + IntToStr(iEjercicio) + '-' + IntToStr(iCodigo) + '-' + FieldDefs.Items[I+1].Name + ', EL CAMPO : ' + TCODIGOS_OUT_DATA_EURO318[I] + ', VALOR :' +aFile.ReadString(DATOS_OUT, TCODIGOS_OUT_DATA_EURO318[I], NADA));
                        {$ENDIF}
                      end;
                    end;
                  end;
                Fields[I+1].AsDateTime := now;
                Post; { Paso a modo browse }
                ApplyUpdates(0);
            end;
        end;
      end;
  except
    on E : Exception do
    begin
      fAnomalias.PonAnotacion (TRAZA_SIEMPRE,7, FICHERO_ACTUAL,'ERROR MUY RARO AL INSERTAR EL RESGISTRO EN LA TABLA RESULTADO_INSPECCION POR: ' + E.message);
      result := False;
    end;
  end;
end;

{ **************************************************************************** }

procedure ConfirmarCadena (var sCadena : string);
var
 sCadenaNOK: String;
const
  UNICO = 1;
begin
sCadenaNOK:=sCadena;
  try
    with DataDiccionario.QryGeneral do
    begin
      Close;
      SetProvider(DataDiccionario.dspQryGeneral);

      commandtext := 'SELECT CADDEFEC FROM TDEFECTOS WHERE CADDEFEC = SUBSTR(:UnaCadena,3,2)||''.''||SUBSTR(:UnaCadena,5,2)||''.0''||SUBSTR(:UnaCadena,7,2)'
                       + ' AND trim(codclase)=SUBSTR(:UnaCadena,2,1)'    ;
      params.ParamByName('UnaCadena').AsString := trim(sCadena);
      {$IFDEF FTRAZAS}

      fTrazas.PonComponente(TRAZA_SQL,1,FICHERO_ACTUAL, DataDiccionario.QryGeneral);
      {$ENDIF}
      Open;
      sCadena:=Fields[0].Value;
      Application.ProcessMessages;
      If RecordCount <> UNICO then
        Begin
          raise EReadingES_OUT.Create('La Cadena: ' + sCadenaNOK + ' No es Correcta');
        end;
      Close;
    end;
  except
     fAnomalias.PonAnotacion (TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'LA CADENA ->"'+ sCadenaNOK +'"<- NO ES CORRECTA!!.');
     raise;
  end;
end;

{ **************************************************************************** }

function InsercionDatosInspeccionVisualOK (const aFile: TIniFile; const iEjercicio, iCodigo : integer;IsSBy: Boolean) : boolean;
const
  PRIMER_CAMPO_VISUAL = 70001;
  PASO_VISUAL = 21;
  CAMPOS = 7;

  DATOS = 'DATAOUT';
  NADA = '';
  IMPOSIBLE = -1;

  FECHA_ALTA = 'FECHALTA';
  EJERCICIO_ = 'EJERCICI';
  INSPECCION = 'CODINSPE';
  SECUENCIA_DEFECTO = 'SECUDEFE';
  NUMERO_INSPECTOR = 'NUMREVIS';
  NUMERO_LINEA =  'NUMLINEA';
  NUMERO_ZONA = 'NUMZONA';
  CADENA_DEFECTO = 'CADDEFEC';
  CALIFICACION_DEFECTO = 'CALIFDEF';
  UBICACION_DEFECTO = 'UBICADEF';
  OTROS_DEFECTO = 'OTROSDEF';
  OBSERVACIONES = 'OBSERVAC';

var
  Insertar: TSQLQuery;
  buscarInspe: TSQLQuery;
  VACIO:BOOLEAN;
  iCodigoUbicacion, iCampo_Visual, iNum_Def_Visual : integer;
  iSecuDefe ,iNumRevis ,iNumLinea, iNumZona,
  iCadDefec , iCalifDef, iUbicacion, iOtrosDef, iObservacion, sAuxiliar, sAuxiliar2,estado_nok,iNomInspe,iCampo_Visual_Inspe : string;
  iCodInspe, I, D, CANT_DEFECTOS, iMaxSEC: Integer;
begin
result := True;
  try
  If IsSBy Then

  iCampo_Visual := PRIMER_CAMPO_VISUAL;
  iCampo_Visual := PRIMER_CAMPO_VISUAL;
    //SetStatToOk(iEjercicio,iCodigo,MyBd);
  iNum_Def_Visual := 0;
  VACIO:=TRUE;


  while (aFile.ReadString(DATOS, IntToStr(ICampo_Visual), NADA) <> NADA)  do
    begin
           VACIO:=TRUE;
      with DataDiccionario.TDATINSPEVI do
        begin
          //VErifica que los valores leidos no son ni nulos ni '-.-'
          inc(iNum_Def_Visual);
          close;
          SetProvider(DataDiccionario.dspTDATINSPEVI);
          CommandText := Format('Select * From TDATINSPEVI Where EJERCICI = %D and CODINSPE = %D',[iEjercicio,iCodigo]);
          open;

          //sAuxiliar:=aFile.ReadString(DATOS, IntToStr(iCampo_Visual), NADA);

          IF (Pos(CADENA_ERRONEA4,aFile.ReadString(DATOS, IntToStr(iCampo_Visual), NADA))<>0) then
          BEGIN
          estado_nok:='D';
                  With TSQLQuery.Create(nil) do
                        Begin
                         SQLConnection:= MyBD;
                          Close;
                            SQL.Clear;
                            SQL.Add('UPDATE TESTADOINSP  SET ESTADO = :ESTAD WHERE EJERCICI = :EJERCICIO AND  CODINSPE = :CODINSPE');
                            Params[0].Value := estado_nok;
                            Params[1].Value := iEjercicio;
                            Params[2].Value := iCodigo;
                            ExecSQL;

                              result := False;
                              fAnomalias.PonAnotacion (TRAZA_SIEMPRE,8, FICHERO_ACTUAL,'POR ERROR  EN SECCION  99 - 132 - 133 ' );
                             BREAK;
                            end;

          END;


          If ((Trim(aFile.ReadString(DATOS, IntToStr(iCampo_Visual), NADA))<>CADENA_VACIA) and (Pos(CADENA_ERRONEA1,aFile.ReadString(DATOS, IntToStr(iCampo_Visual), NADA))=0)and
              (Pos(CADENA_ERRONEA2,aFile.ReadString(DATOS, IntToStr(iCampo_Visual), NADA))=0))   THEN
               ///or (Pos(CADENA_ERRONEA4,aFile.ReadString(DATOS, IntToStr(iCampo_Visual), NADA))<>0)) then
            begin

              iOtrosDef:='';
              iObservacion:='';
              iCalifDef:='';
              iCadDefec:='';
              iCodigoUbicacion :=null;

              VACIO:=FALSE;
              close;
              SetProvider(DataDiccionario.dspTDATINSPEVI);
              CommandText := Format('Select * From TDATINSPEVI Where EJERCICI = %D and CODINSPE = %D',[iEjercicio,iCodigo]);
              open;

              iNumLinea:= aFile.ReadString(DATOS, IntToStr(iCampo_Visual), NADA);
              inc(iCampo_Visual);
              iNumZona:= aFile.ReadString(DATOS, IntToStr(iCampo_Visual), NADA);
              iCampo_Visual_Inspe:='15'+inttostr(strtoint(iNumZona)-1)+'12';
              iNomInspe:=aFile.ReadString(DATOS, iCampo_Visual_Inspe, NADA);
              if iNomInspe='' then iNomInspe:=aFile.ReadString('HEADER', iCampo_Visual_Inspe, NADA);
              iCodInspe:=devuelve_codigoinspector(iNomInspe);
              {*
              buscarInspe:=TSQLQuery.Create(nil);
              With buscarInspe do
              Begin
                SQLConnection:= MyBD;
                //buscarInspe.Close;
                buscarInspe.SQL.Clear;
                buscarInspe.SQL.Add('select numrevis from trevisor where upper(trim(nomrevis))=upper(trim(:NOMREVIS))');
                buscarInspe.Params[0].Value := iNomInspe;
                buscarInspe.Open;
                iCodInspe:= buscarInspe.Fields[0].AsInteger;
              end;
              buscarInspe.Close;
              *}
              inc(iCampo_Visual);
              sAuxiliar := aFile.ReadString(DATOS, IntToStr(iCampo_Visual), NADA);
              ConfirmarCadena(sAuxiliar);
              iCadDefec:= sAuxiliar;
              inc(iCampo_Visual);
              iOtrosDef:=copy(aFile.ReadString(DATOS, IntToStr(iCampo_Visual), NADA),1,30); //-> Debido a que la max. cantidad de caract. de la tabla es 30.
              inc(iCampo_Visual);
              iObservacion:=aFile.ReadString(DATOS, IntToStr(iCampo_Visual), NADA);
              inc(iCampo_Visual);
              iCalifDef:= aFile.ReadString(DATOS, IntToStr(iCampo_Visual), NADA);
              inc(iCampo_Visual);
              inc(iCampo_Visual);
              iCodigoUbicacion := aFile.ReadInteger(DATOS, IntToStr(iCampo_Visual), IMPOSIBLE);
              Begin
                NumBinario:= ConvertirToBin(iCodigoUbicacion,18);
                //-> Si el vehiculo TIENE MEDIONES EN TDAINPSECC entra  (StdBy le llama)
                If IsSBy then
                  Begin
                    sAuxiliar2:=sAuxiliar;
                    If Locate('EJERCICI;CODINSPE;CADDEFEC',VarArrayof([iEjercicio,iCodigo,iCadDefec]),[]) then
                      With TSQLQuery.Create(nil) do
                      Begin
                        SQLConnection:= MyBD;
                        Close;
                        If Cantidad_Defectos(NumBinario) then
                        //-> Si la cadena de defectos viene con ubicaciones entra
                          Begin
                            For I:=1 to 18 do
                              If NumBinario[I] = '1' then
                                Begin
                                  SQL.Clear;
                                  SQL.Add('UPDATE TDATINSPEVI SET EJERCICI = :EJERCICI, CODINSPE = :CODINSPE, NUMREVIS = :NUMREVIS, ');
                                  SQL.Add('NUMLINEA = :NUMLINEA, NUMZONA = :NUMZONA, CADDEFEC = :CADDEFEC, CALIFDEF = :CALIFDEF, UBICADEF = :UBICADEF, ');
                                  SQL.Add('OTROSDEF = :OTROSDEF, OBSERVAC = :OBSERVAC, FECHALTA = :FECHALTA ');
                                  SQL.Add('WHERE EJERCICI = :EJERCICI AND CODINSPE = :CODINSPE AND CADDEFEC = :CADDEFEC AND UBICADEF = :UBICADEF');
                                  Params[0].Value := iEjercicio;
                                  Params[1].Value := iCodigo;
                                  Params[2].Value := iCodInspe;
                                  Params[3].Value := iNumLinea;
                                  Params[4].Value := iNumZona;
                                  Params[5].Value := iCadDefec;
                                  Params[6].Value := iCalifDef;
                                  Params[7].Value := LOCALIZACION_DEFECTOS_318[I];
                                  Params[8].Value := UpperCase(iOtrosDef);
                                  Params[9].Value := UpperCase(iObservacion);
                                  Params[10].Value :=Now;
                                  ExecSQL;
                                  {$IFDEF TRAZAS}
                                  fTrazas.PonAnotacion(TRAZA_REGISTRO,1, FICHERO_ACTUAL,'ACTUALIZADO EL REGISTRO DESDE STDBY: '+IntToStr(iEjercicio)+' - '+IntToStr(iCodigo)+' - '+ iCadDefec+' - '+LOCALIZACION_DEFECTOS_318[I]+', EN LA TABLA TDATINSPEVI');
                                  {$ENDIF}
                                end;
                          end
                        //-> Sino tiene ubicaciones en los defectos entra aqui.
                        else
                          Begin
                            SQL.Clear;
                            SQL.Add('UPDATE TDATINSPEVI SET EJERCICI = :EJERCICI, CODINSPE = :CODINSPE, NUMREVIS = :NUMREVIS, ');
                            SQL.Add('NUMLINEA = :NUMLINEA, NUMZONA = :NUMZONA, CADDEFEC = :CADDEFEC, CALIFDEF = :CALIFDEF, ');
                            SQL.Add('OTROSDEF = :OTROSDEF, OBSERVAC = :OBSERVAC, FECHALTA = :FECHALTA ');
                            SQL.Add('WHERE EJERCICI = :EJERCICI AND CODINSPE = :CODINSPE AND CADDEFEC = :CADDEFEC');
                            Params[0].Value := iEjercicio;
                            Params[1].Value := iCodigo;
                            Params[2].Value := iCodInspe;
                            Params[3].Value := iNumLinea;
                            Params[4].Value := iNumZona;
                            Params[5].Value := iCadDefec;
                            Params[6].Value := iCalifDef;
                            Params[7].Value := UpperCase(iOtrosDef);
                            Params[8].Value := UpperCase(iObservacion);
                            Params[9].Value :=Now;
                            ExecSQL;
                            {$IFDEF TRAZAS}
                            fTrazas.PonAnotacion(TRAZA_REGISTRO,1, FICHERO_ACTUAL,'ACTUALIZADO EL REGISTRO DESDE STDBY: '+IntToStr(iEjercicio)+' - '+IntToStr(iCodigo)+' - '+ iCadDefec+', EN LA TABLA TDATINSPEVI');
                            {$ENDIF}
                          end;
                      end
                    //-> Sino existe la Cadena del defecto
                    else
                    With TSQLQuery.Create(nil) do
                      Begin
                        iMaxSEC:= MaxSecuDef(iEjercicio,iCodigo)+1;
                        SQLConnection:= MyBD;
                        Close;
                        If Cantidad_Defectos(NumBinario) then
                          Begin
                          For I:=1 to 18 do
                            If NumBinario[I] = '1' then
                              Begin
                                SQL.Clear;
                                SQL.Add('INSERT INTO TDATINSPEVI (EJERCICI, CODINSPE, SECUDEFE, NUMREVIS, NUMLINEA, NUMZONA,');
                                SQL.Add('CADDEFEC,CALIFDEF, UBICADEF, OTROSDEF, OBSERVAC, FECHALTA) ');
                                SQL.Add('VALUES (:EJERCICI, :CODINSPE, :SECUDEFE, :NUMREVIS, :NUMLINEA, :NUMZONA, ');
                                SQL.Add(':CADDEFEC, :CALIFDEF, :UBICADEF, :OTROSDEF, :OBSERVAC, :FECHALTA)');
                                Params[0].Value := iEjercicio;
                                Params[1].Value := iCodigo;
                                Params[2].Value := iMaxSEC;
                                Params[3].Value := iCodInspe;
                                Params[4].Value := iNumLinea;
                                Params[5].Value := iNumZona;
                                Params[6].Value := iCadDefec;
                                Params[7].Value := iCalifDef;
                                Params[8].Value := LOCALIZACION_DEFECTOS_318[I];
                                Params[9].Value := UpperCase(iOtrosDef);
                                Params[10].Value := UpperCase(iObservacion);
                                Params[11].Value :=Now;
                                ExecSQL;
                                SQL.Clear;
                                SQL.Add('commit');
                                ExecSQL;
                                inc(iMaxSEC);
                                {$IFDEF TRAZAS}
                                fTrazas.PonAnotacion(TRAZA_REGISTRO,1, FICHERO_ACTUAL,'INSERTADO EL REGISTRO DESDE STDBY: '+IntToStr(iEjercicio)+' - '+IntToStr(iCodigo)+' - '+ iCadDefec +' - '+LOCALIZACION_DEFECTOS_318[I]+ ', EN LA TABLA TDATINSPEVI');
                                {$ENDIF}
                              end;
                          end
                        else
                          Begin
                            SQL.Clear;
                            SQL.Add('INSERT INTO TDATINSPEVI (EJERCICI, CODINSPE, SECUDEFE, NUMREVIS, NUMLINEA, NUMZONA,');
                            SQL.Add('CADDEFEC,CALIFDEF, UBICADEF, OTROSDEF, OBSERVAC, FECHALTA) ');
                            SQL.Add('VALUES (:EJERCICI, :CODINSPE, :SECUDEFE, :NUMREVIS, :NUMLINEA, :NUMZONA, ');
                            SQL.Add(':CADDEFEC, :CALIFDEF, :UBICADEF, :OTROSDEF, :OBSERVAC, :FECHALTA)');
                            Params[0].Value := iEjercicio;
                            Params[1].Value := iCodigo;
                            Params[2].Value := iMaxSEC;
                            Params[3].Value := iCodInspe;
                            Params[4].Value := iNumLinea;
                            Params[5].Value := iNumZona;
                            Params[6].Value := iCadDefec;
                            Params[7].Value := iCalifDef;
                            Params[8].Value := '';
                            Params[9].Value := UpperCase(iOtrosDef);
                            Params[10].Value := UpperCase(iObservacion);
                            Params[11].Value :=Now;
                            ExecSQL;
                            {$IFDEF TRAZAS}
                            fTrazas.PonAnotacion(TRAZA_REGISTRO,1, FICHERO_ACTUAL,'INSERTADO EL REGISTRO DESDE STDBY: '+IntToStr(iEjercicio)+' - '+IntToStr(iCodigo)+' - '+iCadDefec+', EN LA TABLA TDATINSPEVI');
                            {$ENDIF}
                          end;
                      end;
                  end
                else
                 //-> Si el Vehiculo NO TIENE MEDICONES (StandBy) hace el insert
                With TSQLQuery.Create(nil) do
		              begin
                    SQLConnection:= MyBD;
                    Close;
                   //-> Si el Defecto TIENE ubicaciones en los defectos entra aqui.
                    If Cantidad_Defectos(NumBinario) then
                      Begin
                      For I:=1 to 18 do
                       If NumBinario[I] = '1' then
                         Begin
                           SQL.Clear;
                           SQL.Add('INSERT INTO TDATINSPEVI (EJERCICI, CODINSPE, SECUDEFE, NUMREVIS, NUMLINEA, NUMZONA,');
                           SQL.Add('CADDEFEC,CALIFDEF, UBICADEF, OTROSDEF, OBSERVAC, FECHALTA) ');
                           SQL.Add('VALUES (:EJERCICI, :CODINSPE, :SECUDEFE, :NUMREVIS, :NUMLINEA, :NUMZONA, ');
                           SQL.Add(':CADDEFEC, :CALIFDEF, :UBICADEF, :OTROSDEF, :OBSERVAC, :FECHALTA)');
                           Params[0].Value := iEjercicio;
                           Params[1].Value := iCodigo;
                           Params[2].Value := iNum_Def_Visual;
                           Params[3].Value := iCodInspe;
                           Params[4].Value := iNumLinea;
                           Params[5].Value := iNumZona;
                           Params[6].Value := iCadDefec;
                           Params[7].Value := iCalifDef;
                           Params[8].Value := LOCALIZACION_DEFECTOS_318[I];
                           Params[9].Value := UpperCase(iOtrosDef);
                           Params[10].Value := UpperCase(iObservacion);
                           Params[11].Value :=Now;
                           ExecSQL;
                           inc(iNum_Def_Visual);
                           {$IFDEF TRAZAS}
                           fTrazas.PonAnotacion(TRAZA_REGISTRO,1, FICHERO_ACTUAL,'INSERTADO EL REGISTRO : '+IntToStr(iEjercicio)+' - '+IntToStr(iCodigo)+' - '+iCadDefec+' '+LOCALIZACION_DEFECTOS_318[I]+ ', EN LA TABLA TDATINSPEVI');
                           {$ENDIF}
                         end;
                      end
                     //-> Sino tiene ubicaciones en los defectos entra aqui.
                    else
                      Begin
                        SQL.Clear;
                        SQL.Add('INSERT INTO TDATINSPEVI (EJERCICI, CODINSPE, SECUDEFE, NUMREVIS, NUMLINEA, NUMZONA,');
                        SQL.Add('CADDEFEC,CALIFDEF, UBICADEF, OTROSDEF, OBSERVAC, FECHALTA) ');
                        SQL.Add('VALUES (:EJERCICI, :CODINSPE, :SECUDEFE, :NUMREVIS, :NUMLINEA, :NUMZONA, ');
                        SQL.Add(':CADDEFEC, :CALIFDEF, :UBICADEF, :OTROSDEF, :OBSERVAC, :FECHALTA)');
                        Params[0].Value := iEjercicio;
                        Params[1].Value := iCodigo;
                        Params[2].Value := iNum_Def_Visual;
                        Params[3].Value := iCodInspe;
                        Params[4].Value := iNumLinea;
                        Params[5].Value := iNumZona;
                        Params[6].Value := iCadDefec;
                        Params[7].Value := iCalifDef;
                        Params[8].Value := '';
                        Params[9].Value := UpperCase(iOtrosDef);
                        Params[10].Value := UpperCase(iObservacion);
                        Params[11].Value :=Now;
                        ExecSQL;
                        inc(iNum_Def_Visual);
                        {$IFDEF TRAZAS}
                        fTrazas.PonAnotacion(TRAZA_REGISTRO,1, FICHERO_ACTUAL,'INSERTADO EL REGISTRO : '+IntToStr(iEjercicio)+' - '+IntToStr(iCodigo)+' - '+iCadDefec+ ', EN LA TABLA TDATINSPEVI');
                        {$ENDIF}
                      end;
                  end;
               end;
              iCampo_Visual:=iCampo_Visual-1;
            end;
          iCampo_Visual := iCampo_Visual + (PASO_VISUAL - CAMPOS);
        end;

    end;
  except
    on E: Exception do
    begin
      result := False;
      fAnomalias.PonAnotacion (TRAZA_SIEMPRE,8, FICHERO_ACTUAL,'ERROR MUY RARO AL INSERTAR EL RESGISTRO EN LA TABLA TDATINSPVI POR: ' + E.message);
    end;
  end;

   {
   IF (VACIO=TRUE)  or  (aFile.ReadString(DATOS, IntToStr(ICampo_Visual), NADA) = NADA) THEN
    BEGIN
         estado_nok:='D';
                  With TSQLQuery.Create(nil) do
                        Begin
                         SQLConnection:= MyBD;
                          Close;
                            SQL.Clear;
                            SQL.Add('UPDATE TESTADOINSP  SET ESTADO = :ESTAD WHERE EJERCICI = :EJERCICIO AND  CODINSPE = :CODINSPE');
                            Params[0].Value := estado_nok;
                            Params[1].Value := iEjercicio;
                            Params[2].Value := iCodigo;
                            ExecSQL;

                              result := False;
                              fAnomalias.PonAnotacion (TRAZA_SIEMPRE,8, FICHERO_ACTUAL,'POR ERROR  EN SECCION  99 - 132 - 133 ' );

                            end;

    END;
  
  }
end;

function InsercionRevisoresInspeccion (const aFile: TIniFile; const iEjercicio, iCodigo : integer;IsSBy: Boolean) : boolean;
const

  DATOS = 'DATAOUT';
  NADA = '';
  IMPOSIBLE = -1;

  FECHA_ALTA = 'FECHALTA';
  EJERCICIO_ = 'EJERCICI';
  INSPECCION = 'CODINSPE';
  SECUENCIA_DEFECTO = 'SECUDEFE';
  NUMERO_INSPECTOR = 'NUMREVIS';
  NUMERO_LINEA =  'NUMLINEA';
  NUMERO_ZONA = 'NUMZONA';
  CADENA_DEFECTO = 'CADDEFEC';
  CALIFICACION_DEFECTO = 'CALIFDEF';
  UBICACION_DEFECTO = 'UBICADEF';
  OTROS_DEFECTO = 'OTROSDEF';
  OBSERVACIONES = 'OBSERVAC';

var
  Insertar: TSQLQuery;
  buscarInspe: TSQLQuery;
  VACIO:BOOLEAN;
  iCodigoUbicacion, iCampo_Visual, iNum_Def_Visual : integer;
  iSecuDefe ,iNumRevis ,iNumLinea, iNumZona,
  iCadDefec , iCalifDef, iUbicacion, iOtrosDef, iObservacion, sAuxiliar, sAuxiliar2,estado_nok,iNomInspe,iCampo_Visual_Inspe : string;
  iCodInspe, I, D, CANT_DEFECTOS, iMaxSEC: Integer;
begin
result := True;
  try
  
  //  with DataDiccionario.TDATINSPEVI do
  //  begin
      FOR I:=1 to 3 do
      BEGIN
              iNumLinea:='';
              iNomInspe:='';

 //             SetProvider(DataDiccionario.dspTDATINSPEVI);
 //             CommandText := Format('Select * From TDATINSPEVI Where EJERCICI = %D and CODINSPE = %D',[iEjercicio,iCodigo]);
  //            open;

              iCampo_Visual_Inspe:='15'+inttostr(I-1)+'11';
              iNumLinea:=aFile.ReadString(DATOS, iCampo_Visual_Inspe, NADA);
              if iNumLinea='' then iNumLinea:=aFile.ReadString('HEADER', iCampo_Visual_Inspe, NADA);
              iCampo_Visual_Inspe:='15'+inttostr(I-1)+'12';
              iNomInspe:=aFile.ReadString(DATOS, iCampo_Visual_Inspe, NADA);
              if iNomInspe='' then iNomInspe:=aFile.ReadString('HEADER', iCampo_Visual_Inspe, NADA);
              iCodInspe:=devuelve_codigoinspector(iNomInspe);
              {*
              buscarInspe:=TSQLQuery.Create(nil);
              With buscarInspe do
              Begin
                SQLConnection:= MyBD;
                //buscarInspe.Close;
                buscarInspe.SQL.Clear;
                buscarInspe.SQL.Add('select numrevis from trevisor where upper(trim(nomrevis))=upper(trim(:NOMREVIS))');
                buscarInspe.Params[0].Value := iNomInspe;
                buscarInspe.Open;
                iCodInspe:= buscarInspe.Fields[0].AsInteger;
              end;
              buscarInspe.Close;
              *}
              With TSQLQuery.Create(nil) do
		          begin
                                  SQLConnection:= MyBD;
                                  Close;

                                  SQL.Clear;
                                  SQL.Add('UPDATE TINSPECCION SET NUMREVS'+inttostr(I)+' = :NUMREVIS, ');
                                  SQL.Add('NUMLINS'+inttostr(I)+' = :NUMLINEA  ');
                                  SQL.Add('WHERE EJERCICI = :EJERCICI AND CODINSPE = :CODINSPE ');
                                  Params[0].Value := iCodInspe;
                                  Params[1].Value := iNumLinea;
                                  Params[2].Value := iEjercicio;
                                  Params[3].Value := iCodigo;
                                  ExecSQL;
                                  {$IFDEF TRAZAS}
                                  fTrazas.PonAnotacion(TRAZA_REGISTRO,1, FICHERO_ACTUAL,'ACTUALIZADO INSPECTORES EN TINSPECCION: '+IntToStr(iEjercicio)+' - '+IntToStr(iCodigo));
                                  {$ENDIF}
                                  SQL.Clear;
                                  SQL.Add('COMMIT');
                                  ExecSQL;
                                  //commit;
              end;
      end;
  //  end;
  except
  on E: Exception do
  begin
    result := False;
      fAnomalias.PonAnotacion (TRAZA_SIEMPRE,8, FICHERO_ACTUAL,'ERROR MUY RARO AL INSERTAR EL RESGISTRO EN LA TABLA TDATINSPVI POR: ' + E.message);
  end;
  end;

end;

{**************************************************************************************************}
procedure InterpretarFichero (const EsteFichero : string; var CodError,iEjercicio,iCodigoInspeccion  : Integer; var IsSBy: boolean);
var
  MiFicheroIni : TIniFile;
  EstaEnStdBy: Boolean;
  ES_OCULAR:BOOLEAN;
begin
iCodigoInspeccion := 0;
iEjercicio := 0;
CodError := NO_HAY_ERROR;
ShortDateFormat := 'dd/mm/yyyy';
MiFicheroIni := TIniFile.Create(EsteFichero);
  Try


  if not PendienteFacturar(ChangeFileExt(ExtractFileName(MiFicheroIni.FileName),'')) then
    Try
    { COMPROBACION DE QUE MAHA HAYA TERMINADO }
    if not FicheroCompleto(MiFicheroIni) then
      begin
        CodError := ERR_FICHERO_INI_NO_COMPLETO;
        raise EReadingES_OUT.Create(MSJ_ERR_FICHERO_INI_NO_COMPLETO + MiFicheroIni.FileName);
      end;
    {$IFDEF TRAZAS}
      fTrazas.PonAnotacion(TRAZA_FLUJO,2,FICHERO_ACTUAL,'MAHA HA TERMINADO DE EDITAR EL FICHERO: ' + MiFicheroIni.FileName);
    {$ENDIF}
    if not NombreYMatriculaIguales(MiFicheroIni) then
      begin
        CodError := ERR_FICHERO_INI_NOMBRE_MATRICULA_DISTINTO;
        raise EReadingES_OUT.Create(MSJ_ERR_FICHERO_INI_NOMBRE_MATRICULA_DISTINTO + MiFicheroIni.FileName);
      end;
    {$IFDEF TRAZAS}
      fTrazas.PonAnotacion(TRAZA_FLUJO,3,FICHERO_ACTUAL,'EL CAMPO MATRICULA Y EL NOMBRE DEL FICHERO COINCIDEN EN EL FICHERO: ' + MiFicheroIni.FileName);
    {$ENDIF}
    if not EjercicioYCodigoOk (MiFicheroIni, iCodigoInspeccion, iEjercicio) then
      begin
        CodError := ERR_FICHERO_INI_CODIGOS_ERRONEOS;
        raise EReadingES_OUT.Create(MSJ_ERR_FICHERO_INI_CODIGOS_ERRONEOS + MiFicheroIni.FileName);
      end;
    {$IFDEF TRAZAS}
      fTrazas.PonAnotacion(TRAZA_FLUJO,4,FICHERO_ACTUAL,'LOS CODIGOS SON CORRECTOS SINTACTICAMENTE EN EL FICHERO: ' + MiFicheroIni.FileName);
    {$ENDIF}

    //////////////////////////////////////////////////////////////////////////////////////////////////////
    //           comentado Nro. 131206                                                                  //
    //           if InspeccionEnLinea(iEjercicio, iCodigoInspeccion) then begin                         //
    //                                                                                                  //
    //////////////////////////////////////////////////////////////////////////////////////////////////////
     //patente:=  BusquedaPatente(iCodigoInspeccion);
     patente:=buscarPatenteTXT(MiFicheroIni);
     iCodigoInspeccion:= InspeccionEnLineaPorPatente(patente); // JUAN
     iEjercicio:= EjercicioEnLineaPorPatente(patente);      //JUAN
     if (iCodigoInspeccion <> 0) and (iEjercicio <> 0) then   //Agregado por el comentado Nro. 131206
       Begin
         if not ActualizacionInspeccionOK (MiFicheroIni, iEjercicio, iCodigoInspeccion) then
          begin
            CodError := ERR_TINSPECCION_NO_ACTUALIZADA;
            raise EReadingES_OUT.Create(MSJ_ERR_TINSPECCION_NO_ACTUALIZADA + MiFicheroIni.FileName + '( ' + IntToStr(iEjercicio) + '-' + IntToStr(iCodigoInspeccion) + ' )');
          end;

          {$IFDEF TRAZAS}
            fTrazas.PonAnotacion(TRAZA_FLUJO,5,FICHERO_ACTUAL,'LA ACTUALIZACION DE TINSPECCION HA SIDO CORRECTA PARA: ' + MiFicheroIni.FileName);
          {$ENDIF}
          IsSBy:=IsStandBy(iEjercicio,iCodigoInspeccion,MyBd);



          if not InsercionDatosInspeccionOK (MiFicheroIni, iEjercicio, iCodigoInspeccion, IsSBy) then
            begin
              CodError := ERR_REGISTRO_DATOSINSPECCION_NO_INSERTADO;
              raise EReadingES_OUT.Create(MSJ_ERR_REGISTRO_DATOSINSPECCION_NO_INSERTADO + MiFicheroIni.FileName + '( ' + IntToStr(iEjercicio) + '-' + IntToStr(iCodigoInspeccion) + ' )');
            end;

          if not InsercionAdicionalesOK (MiFicheroIni, iEjercicio, iCodigoInspeccion, IsSBy) then
            begin
              CodError := ERR_REGISTRO_DATOSINSPECCION_NO_INSERTADO;
              raise EReadingES_OUT.Create(MSJ_ERR_REGISTRO_DATOSINSPECCION_NO_INSERTADO + MiFicheroIni.FileName + '( ' + IntToStr(iEjercicio) + '-' + IntToStr(iCodigoInspeccion) + ' )');
            end;
          {$IFDEF TRAZAS}
            fTrazas.PonAnotacion(TRAZA_FLUJO,6,FICHERO_ACTUAL,'LA INSERCION DEL REGISTRO EN TDATOSINSP SE HA REALIZADO PARA EL FICHERO: ' + MiFicheroIni.FileName);
          {$ENDIF}
          if not InsercionDatosInspeccionVisualOK(MiFicheroIni, iEjercicio, iCodigoInspeccion, IsSBy) then
            begin
              CodError := ERR_REGISTRO_DATOSINSPECCION_VISUAL_NO_INSERTADO;
              raise EReadingES_OUT.Create(MSJ_ERR_REGISTRO_DATOSINSPECCION_VISUAL_NO_INSERTADO + MiFicheroIni.FileName + '( ' + IntToStr(iEjercicio) + '-' + IntToStr(iCodigoInspeccion) + ' )');
            end;
          {$IFDEF TRAZAS}
            fTrazas.PonAnotacion(TRAZA_FLUJO,7,FICHERO_ACTUAL,'LA INSERCION DEL REGISTRO EN TDATINSPEVI SE HA REALIZADO PARA EL FICHERO: ' + MiFicheroIni.FileName);
          {$ENDIF}
          InsercionRevisoresInspeccion(MiFicheroIni, iEjercicio, iCodigoInspeccion, IsSBy);
        end;
    except
      on E : Exception do
        begin
        {$B-}
          if not ((CodError = ERR_FICHERO_INI_NO_COMPLETO) or  (CodError = ERR_FICHERO_INI_NOMBRE_MATRICULA_DISTINTO))  then
            fAnomalias.PonAnotacion(TRAZA_SIEMPRE,9,FICHERO_ACTUAL,'ERROR GRAVE INTENTANDO LEER EL FICHERO INI: ' + E.message)
          else
            begin
              if UpperCase(ExtractFileName(EsteFichero)) <> 'CONTROL' then
                fIncidencias.PonAnotacion(TRAZA_SIEMPRE,10,FICHERO_ACTUAL, 'ERROR INTRATABLE POR: ' + E.message);
            end;
        end;
    end;
  Finally
    MiFicheroIni.Free;
  end;
end;

function ConvierteComaEnPuntoGral (const s: string): string;
const COMA='.';
      PUNTO=',';
   var
     i:integer;
   begin
       { una o dos cifras decimales }
      if (Pos(COMA, s) = 0) then { Es un n� entero }
          Result := s
      else
        begin
          for i := 1 to  Length (s)-1 do
            begin
              if (Pos(COMA, s) = Length (s)-i) then
              Result := copy (s, 1, length(s)-(i+1)) + PUNTO + copy (s, pos (COMA,s)+1, length(s))
            end;
        end;
   end;





end.//Final de la unidad
