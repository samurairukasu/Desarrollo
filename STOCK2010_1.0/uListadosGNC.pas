unit uListadosGNC;

interface

uses
  uGetDates, RxLookup, Globals, SqlExpr,
  uStockClasses, uStockEstacion, ucdialgs, urMovObleasGNC, uUtils, urListMovObleasGNC, urListEntObleasGNC, urListStockenPlanta,
  urListEnviosCD, urListStockGlobal, urListConsumosGNC, urListEnvObleasGNC;

  procedure DoEntradaObleasGNC(FechaIni,FechaFin :string; aEmpresa :integer);
  procedure DoMovimientoObleasGNC(FechaIni,FechaFin :string; aPlanta :integer; aTipo: string);
  procedure DoStockenPlantaGNC(aPlanta :integer);
  procedure DoConsumoObleasGNC(FechaIni, Fechafin : string);
  procedure DoEnvioCDGNC(FechaIni, Fechafin : string);
  procedure DoStockGlobalGNC;

var
  fi,ff: string;

implementation

procedure DoEntradaObleasGNC(FechaIni, FechaFin: string;
  aEmpresa: integer);
begin
    DeleteTable(MyBD, 'TTMP_ENTRADAS');
    with TSqlStoredProc.Create(nil) do
    try
        SqlConnection := MyBD;

        if aEmpresa = 0 then
           StoredProcName := 'LIST_ENTRADAS_GLOBAL'
        else
           StoredProcName := 'LIST_ENTRADAS';

        ParamByName('FECHAINI').Value := FechaIni;
        ParamByName('FECHAFIN').Value := FechaFin;

        if aEmpresa <> 0 then
            ParamByName('aEmpresa').Value := aEmpresa;
        ExecProc;
        Close;
    finally
        Free
    end
end;

procedure DoMovimientoObleasGNC(FechaIni, FechaFin: string;
  aPlanta: integer; aTipo: string);
begin
  if aTipo = MOV_TIPO_ENTRADA then
  begin
    DeleteTable(MyBD, 'TTMP_MOVIMIENTOS');
    with TSqlStoredProc.Create(nil) do
    try
        SqlConnection := MyBD;
        if aPlanta = 0 then
           StoredProcName := 'LIST_MOVIMIENTOS_GLOBAL'
        else
           StoredProcName := 'LIST_MOVIMIENTOS';

        ParamByName('FECHAINI').Value := FechaIni;
        ParamByName('FECHAFIN').Value := FechaFin;

        if aPlanta <> 0 then
            ParamByName('aPlanta').Value := aPlanta;
        ExecProc;
        Close;
    finally
        Free
    end
  end
  else
  begin
    with TSqlStoredProc.Create(nil) do
    try
       SqlConnection := MyBD;

        if aPlanta = 0 then
        begin
           DeleteTable(MyBD, 'TTMP_SALIDAS');
           StoredProcName := 'LIST_SALIDAS_GLOBAL'
        end
        else
        begin
           DeleteTable(MyBD, 'TTMP_MOVIMIENTOS');
           StoredProcName := 'LIST_SALIDAS';
        end;
        ParamByName('FECHAINI').Value := FechaIni;
        ParamByName('FECHAFIN').Value := FechaFin;

        if aPlanta <> 0 then
            ParamByName('aPlanta').Value := aPlanta;
        ExecProc;
        Close;
    finally
        Free
    end
  end;
end;

procedure DoStockenPlantaGNC(aPlanta: integer);
begin
    DeleteTable(MyBD, 'TTMP_STOCKOBLEAS');
    with TSqlStoredProc.Create(nil) do
    try
        SqlConnection:= MyBD;
        StoredProcName := 'STOCK_OBLEAS';
        ParamByName('aPlanta').Value := aPlanta;
        ExecProc;
        Close;
    finally
        Free
    end
end;


procedure DoConsumoObleasGNC(FechaIni, Fechafin: string);
begin
    DeleteTable(MyBD, 'TTMP_CONSUMOS');
    with TSqlStoredProc.Create(nil) do
    try
        SqlConnection := MyBD;
        StoredProcName := 'LIST_CONSUMOS_GLOBAL';

        ParamByName('FI').Value := FechaIni;
        ParamByName('FF').Value := FechaFin;
        ExecProc;
        Close;
    finally
        Free
    end

end;

procedure DoEnvioCDGNC(FechaIni, Fechafin: string);
begin
    DeleteTable(MyBD, 'TTMP_CONTROL');
    with TSqlStoredProc.Create(nil) do
    try
        SqlConnection := MyBD;
        StoredProcName := 'LIST_CONTROL_ENVIOS';

        ParamByName('FI').Value := FechaIni;
        ParamByName('FF').Value := Fechafin;
        ExecProc;
        Close;
    finally
        Free
    end
end;

procedure DoStockGlobalGNC;
begin
    DeleteTable(MyBD, 'TTMP_STOCKOBLEAS_GLOBAL');
    with TSqlStoredProc.Create(nil) do
    try
        SqlConnection:= MyBD;
        StoredProcName := 'STOCK_OBLEAS_GLOBAL';
        ExecProc;
        Close;
    finally
        Free
    end
end;

end.
