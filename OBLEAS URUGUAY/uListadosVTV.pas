unit uListadosVTV;

interface

uses
  uGetDates, RxLookup, Globals, SqlExpr, uStockClasses, uStockEstacion, ucdialgs,
  urMovObleasVTV, uUtils,
  urListStockenPlanta,
  urListStockGlobalVTV,
  urTransObleasVTV,
  urListConsumosVTVxAno;

  procedure DoEntradaObleasVTV(FechaIni,FechaFin :string; aEmpresa :integer);
  procedure DoMovimientoObleasVTV(FechaIni,FechaFin :string; aPlanta :integer);
  procedure DoStockenPlantaVTV(aPlanta :integer);
  procedure DoConsumoObleasVTV(FechaIni, Fechafin : string);
  procedure DoStockGlobalVTV;
  procedure DoConsumoObleasxAnoVTV(FechaIni, Fechafin : string);
  procedure DoControlRecepObleasVTV(FechaIni, Fechafin : string);
  procedure DoStockGlobalVTVAfecha(FechaHasta:String);
  procedure ActualizarObleas;
var
  fi,ff: string;

implementation

procedure DoEntradaObleasVTV(FechaIni, FechaFin: string;
  aEmpresa: integer);
begin
    DeleteTable(MyBD, 'TTMP_ENTRADAS');
    with TSqlStoredProc.Create(nil) do
    try
        SqlConnection := MyBD;
        if aEmpresa = 0 then
           StoredProcName := 'LIST_ENTRADAS_GLOBAL_VTV'
        else
           StoredProcName := 'LIST_ENTRADAS_VTV';

       // Prepared;
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

procedure DoMovimientoObleasVTV(FechaIni, FechaFin: string;
  aPlanta: integer);
begin
    DeleteTable(MyBD, 'TTMP_MOVIMIENTOS');
    with TSqlStoredProc.Create(nil) do
    try
        SqlConnection:= MyBD;

        if aPlanta = 0 then
           StoredProcName := 'LIST_MOVIMIENTOS_GLOBAL_VTV'
        else
           StoredProcName := 'LIST_MOVIMIENTOS_VTV';

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

procedure DoControlRecepObleasVTV(FechaIni, Fechafin : string);
begin
    DeleteTable(MyBD, 'TTMP_CONTROL_OB_RECIBIDAS');
    with TSqlStoredProc.Create(nil) do
    try
        SqlConnection := MyBD;
        StoredProcName := 'LIST_CONTROL_OBLEAS_RECIB';
        ParamByName('FECHAINI').Value := FechaIni;
        ParamByName('FECHAFIN').Value := FechaFin;
        ExecProc;
        Close;
    finally
        Free
    end
end;

procedure DoStockenPlantaVTV(aPlanta: integer);
begin
    DeleteTable(MyBD, 'TTMP_STOCKOBLEAS');
    with TSqlStoredProc.Create(nil) do
    try
        SqlConnection := MyBD;
        StoredProcName := 'STOCK_OBLEAS_VTV';
        ParamByName('aPlanta').Value := aPlanta;
        ExecProc;
        Close;
    finally
        Free
    end
end;

procedure DoConsumoObleasVTV(FechaIni, Fechafin: string);
begin
    DeleteTable(MyBD, 'TTMP_CONSUMOS_VTV');
    with TSqlStoredProc.Create(nil) do
    try
        SqlConnection := MyBD;
        StoredProcName := 'LIST_CONSUMOS_GLOBAL_VTV';
        ParamByName('FI').Value := FECHAINI;
        ParamByName('FF').Value := FECHAFIN;
        ExecProc;
        Close;
    finally
        Free
    end
end;
procedure DoStockGlobalVTVAfecha(FechaHasta:String);
begin
    DeleteTable(MyBD, 'TTMP_STOCKOBLEASVTV_AFECHA');
    with TSqlStoredProc.Create(nil) do
    try
        SqlConnection := MyBD;
        StoredProcName := 'STOCKOBLEASVTVAFECHA';
        ParamByName('AFECHAFIN').Value := COPY(FechaHasta,1,10);
        ExecProc;
        Close;
    finally
        Free
    end
end;

procedure DoStockGlobalVTV;
begin
    DeleteTable(MyBD, 'TTMP_STOCKOBLEAS_GLOBAL');
    with TSqlStoredProc.Create(nil) do
    try
        SqlConnection:= MyBD;
        StoredProcName := 'STOCK_OBLEAS_GLOBAL_VTV';
        ExecProc;
        Close;
    finally
        Free
    end
end;

procedure DoConsumoObleasxAnoVTV(FechaIni, Fechafin: string);
begin
    DeleteTable(MyBD, 'TTMP_CONSUMOSANIO_VTV');
    with TSqlStoredProc.Create(nil) do
    try
        SqlConnection := MyBD;
        StoredProcName := 'LIST_CONSUMOS_GLOBALXANO';
        ParamByName('FI').Value := FECHAINI;
        ParamByName('FF').Value := FECHAFIN;
        ExecProc;
        Close;
    finally
        Free
    end
end;

procedure ActualizarObleas;
begin
    with TSqlStoredProc.Create(nil) do
    try
        SqlConnection := MyBD;
        StoredProcName := 'pr_obleasconsumidas';
        ExecProc;
        Close;
    finally
        Free
    end
end;

end.
