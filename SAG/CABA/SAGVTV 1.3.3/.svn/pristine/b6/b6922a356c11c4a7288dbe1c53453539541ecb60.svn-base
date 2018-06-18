unit UDateVenGNC;


interface
 uses
   Classes, SysUtils, Messages, Forms ,SQLExpr, uSagClasses, provider, dbclient;

 type
   EFechaInCorrecta = class(Exception);
   ENoExisteRegistro = class(Exception);

   ttFechas = record
    dFechaVencimientoApto,
    dFechaActual,
    dFechaCilindro,
    dFechaInspeccion : Integer;
    dresultado: char;
   end;


 function dNuevaFechaDeVencimiento ( const iCodigoVehiculo : integer;aDataBase:tSQLConnection;
                                     const cResultadoInspeccionActual,aTipo: char) : Integer;

implementation


uses
  ULogs, DateUtil, UTilOracle, USAGVARIOS, USAGESTACION, Globals;

const
    FICHERO_ACTUAL = 'UDateVenGNC.pas';
    NUM_DIAS_MES = 30;
    DIAS_X_MES = 30.42;
    SIN_FECHA = '01/01/1500';


function tFechasCilindro (const iCodigoEquipo : integer; const aDataBase: tSQLConnection; const aTipo : char;const cResultadoInspeccionActual:char ) : ttFechas;
const
    UNICO = 1;
var
    sFechaAntiguo : string;
    aq: TSQLDataSet;
    dsp : tDatasetprovider;
    cds : tClientDataSet;
    fsql : tstringlist;
begin
      aQ := TSQLDataSet.Create(application);
      aQ.SQLConnection := aDataBase;
      aQ.CommandType := ctQuery;
      aQ.GetMetadata := false;
      aQ.NoMetadata := true;
      aQ.ParamCheck := false;

      dsp := TDataSetProvider.Create(application);
      dsp.DataSet := aQ;
      dsp.Options := [poIncFieldProps,poAllowCommandText];

      cds:=TClientDataSet.Create(application);
    with cds do
    try
        sFechaAntiguo := ShortDateFormat;
        ShortDateFormat := 'DD/MM/YYYY';
        setprovider(dsp);
        fsql := TStringList.Create;
        fSQL.Add ('SELECT FECHVENC FROM CILINDROS C, EQUIPOSGNC E, EQUIGNC_CILINDRO M');
        fSQL.Add (Format(' WHERE E.CODEQUIGNC = %D AND E.CODEQUIGNC = M.CODEQUIGNC AND M.CODCILINDRO = C.CODCILINDRO',[iCodigoEquipo]));;
        fsql.add (' order by fechvenc');
        CommandText:= fsql.GetText;
            {$IFDEF TRAZAS}
            fTrazas.PonComponente(TRAZA_FLUJO,33,FICHERO_ACTUAL,aQ);
            {$ENDIF}

            Open;
            {$IFDEF TRAZAS}
            fTrazas.PonComponente(TRAZA_REGISTRO,34,FICHERO_ACTUAL,aQ);
            {$ENDIF}

            if not (RecordCount > 0)
            then begin
                Close;
                raise ENoExisteRegistro.Create('No existen datos de los cilindros');
            end
            else begin
               first;
               with result do
                begin
                    dFechaActual := Trunc(StrToDate(DateBD(aQ.SQLConnection)));
                    dFechaVencimientoApto := dFechaActual + Round((12 * DIAS_X_MES));
                    dFechaCilindro := Trunc(StrToDate(Fields[0].AsString));
                end;
            end;

    finally
        ShortDateFormat := sFechaAntiguo;
          cds.Free;
          dsp.Free;
          aQ.close;
          aQ.free;
    end;
end;

{ ********************************************************************** }

function dNuevaFechaDeVencimiento ( const iCodigoVehiculo : integer;aDataBase:tSQLConnection;
                                    const cResultadoInspeccionActual,aTipo: char) : Integer;

var
    tFechas : ttFechas;
begin
  try

    tFechas := tFechasCilindro(iCodigoVehiculo,aDataBase,aTipo,cResultadoInspeccionActual);

    with tFechas do
    begin
      {$IFDEF TRAZAS}   {*}
      fTrazas.PonAnotacionFmt(TRAZA_FLUJO,1,FICHERO_ACTUAL,
                                 'Se han obtenido las fechas para el vehiculo %d -> FA: %s, FV: %s, FC: %s',
                                 [iCodigoVehiculo,
                                  FormatDateTime('dd/mm/yyyy',dFechaActual),
                                  FormatDateTime('dd/mm/yyyy',dFechaVencimientoApto),
                                  FormatDateTime('dd/mm/yyyy',dFechaCilindro)]);
      {$ENDIF}
    end;
    if tFechas.dFechaCilindro > tFechas.dFechaVencimientoApto then
      result := tFechas.dFechaVencimientoApto
    else
      if tFechas.dFechaCilindro > tFechas.dFechaActual then
        result := tFechas.dFechaCilindro
      else
        result := tFechas.dFechaActual;
  except
    on E:Exception do
    begin
      FAnomalias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL, 'Error al Calcular la Fecha de Vencimiento' + E.Message);
      raise;
    end;
  end;
end;

end.//Final de la unidad
