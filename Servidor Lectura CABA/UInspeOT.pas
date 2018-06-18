unit UInspeOT;

interface
uses
  UVerifOT,
  SysUtils;

const
   FICHERO_ACTUAL = 'UInspecc.pas';
   INICIO_REVISIONES_CON_D1 =  1;
   FINAL_REVISIONES_CON_D1 = 20;

   INICIO_REVISIONES_CON_D2 = 21;
   FINAL_REVISIONES_CON_D2 = 22;

   INICIO_REVISIONES_CON_D3 = 23;
   FINAL_REVISIONES_CON_D3 = 23;
   
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


type
  EEnInspeccion = class(Exception);

function PasadaInspeccion (const iUnEjercicio, iUnCodigo : Integer; const isSBy: boolean) : boolean;

implementation

uses
  UModDat,
  Globals,
  Forms,
  DB,
  sqlexpr,dbclient,provider,
  ULogs;


function PasadaInspeccion (const iUnEjercicio, iUnCodigo : Integer; const isSBy :boolean) : boolean;
var
  Dependencias : TRDependencias;
  iSecuenciaDefecto : integer;
  I : integer;
  SQLStoredProc1: TSQLStoredProc;
begin

  iSecuenciaDefecto := 1;

  {$IFDEF TRAZAS}
    fTrazas.PonAnotacion(TRAZA_FLUJO,0,FICHERO_ACTUAL,'LA INSPECCION ' + IntToStr(iUnCodigo) + ',' + IntToStr(iUnEjercicio) + ' COMIENZA A VERIFICARSE ');
  {$ENDIF}

  if  ObtenidasDependenciasOk (iUnEjercicio, iUnCodigo, Dependencias) then
  begin
    try
      MyBd.StartTransaction(td);

      SQLStoredProc1:=TSQLStoredProc.create(Application);
      with SQLStoredProc1 do
      begin
        SQLStoredProc1.sqlConnection:=MyBD;
        StoredProcName := 'Pq_ServLectura.borrarDefectosInspeccion';
        Params.ParamByName('pinspe').AsString := inttostr(iUnCodigo) ;
        Params.ParamByName('pEJERCICI').AsString := inttostr(iUnEjercicio) ;
        ExecProc;
      end;

      with SQLStoredProc1 do
      begin
        SQLStoredProc1.sqlConnection:=MyBD;
        StoredProcName := 'Pq_ServLectura.completarResultadosInspeccion';
        Params.ParamByName('pinspe').AsString := inttostr(iUnCodigo) ;
        Params.ParamByName('pEJERCICI').AsString := inttostr(iUnEjercicio) ;
        ExecProc;
      end;



      if not RevisionOk(    iUnEjercicio,
                            iUnCodigo, Dependencias.D1, Dependencias.D2,Dependencias.D3,Dependencias.D4,
                            iSecuenciaDefecto,
                            isSBy) then raise EEnInspeccion.Create('ERROR CORRIGIENDO LOS CAMPO: ');
      MyBd.Commit(td);
      result := True;
      {$IFDEF TRAZAS}
        fTrazas.PonAnotacion(TRAZA_FLUJO,4,FICHERO_ACTUAL,'INSPECCIONADO ' + IntToStr(iUnCodigo) + ',' + IntToStr(iUnEjercicio) + ' POR COMPLETO');
      {$ENDIF}
    except
      on E : Exception do
      begin
         MyBd.RollBack(td);
         result := False;
         fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0, FICHERO_ACTUAL, 'LA INSPECCION A: ' + IntToStr(iUnCodigo) + ',' + IntToStr(iUnEjercicio) + ' NO PUEDE REALIZARSER POR: ' + E.message);
      end;
    end;
  end
  else begin
    result := False;
    fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1, FICHERO_ACTUAL, 'LA INSPECCION A: ' + IntToStr(iUnCodigo) + ',' + IntToStr(iUnEjercicio) + ' NO PUEDE REALIZARSE PORQUE NO SE OBTUVIERON SUS DEPENDENCIAS');
  end;
end;

end.





