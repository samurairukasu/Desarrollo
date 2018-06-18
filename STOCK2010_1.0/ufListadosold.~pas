unit ufListadosold;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, uGetDates, RxLookup, Globals, dbTables,
  uStockClasses, DB, uStockEstacion, ucdialgs;

type
  TfrmListados = class(TForm)
    rgListados: TRadioGroup;
    btnAceptar: TBitBtn;
    btnSalir: TBitBtn;
    Bevel1: TBevel;
    edNumeros: TEdit;
    lcbEmpresa: TRxDBLookupCombo;
    lcbPlanta: TRxDBLookupCombo;
    srcEmpresas: TDataSource;
    srcPlantas: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel2: TBevel;
    lcbPlanta2: TRxDBLookupCombo;
    Label4: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure DoMovimientoObleas(FechaIni,FechaFin :string; aPlanta :integer; aTipo: string);
    procedure DoEntradaObleas(FechaIni,FechaFin :string; aEmpresa :integer);
    procedure DoStockenPlanta(aPlanta :integer);
    procedure DoStockGlobal;
    procedure DoConsumoObleas(FechaIni, Fechafin : string);
    procedure FormCreate(Sender: TObject);
    procedure rgListadosClick(Sender: TObject);
    procedure edNumerosKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure lcbPlanta2CloseUp(Sender: TObject);
    procedure lcbEmpresaCloseUp(Sender: TObject);
    procedure lcbPlantaCloseUp(Sender: TObject);
    procedure DoEnvioCDGNC(FechaIni, Fechafin : string);
  private
    { Private declarations }
    fi,ff: string;
    fPlantas : tPlantas;
    fEmpresas : tEmpresas;
  public
    { Public declarations }
  end;
  Procedure DoListadosGNC;

var
  frmListados: TfrmListados;

resourcestring
  CAPTION = 'Listados Obleas GNC';

implementation



{$R *.dfm}

uses
  urMovObleasGNC, uUtils, urListMovObleasGNC, urListEntObleasGNC, urListStockenPlanta,
  urListEnviosCD, urListStockGlobal, urListConsumosGNC, urListEnvObleasGNC ;

Procedure DoListadosGNC;
begin
  with TfrmListados.Create(application) do
    try
      showmodal;
    finally
      free;
    end;
end;

procedure TfrmListados.btnAceptarClick(Sender: TObject);
var
   ArrayVar: Variant;
begin
  if rgListados.ItemIndex <> -1 then
  case rgListados.ItemIndex of
    0:begin
      if not GetDates(fi,ff) then exit;
      DoEntradaObleas(fi,ff,0);
      DoLisEntObleasGNCGlobal(fi,ff);
    end;
    1:begin
      if lcbEmpresa.Text = '' then
      begin
         MessageDlg(CAPTION,'Seleccione una Empresa', mtError, [mbOk], mbOk, 0);
         lcbEmpresa.SetFocus;
         exit;
      end;
      if not GetDates(fi,ff) then exit;
      DoEntradaObleas(fi,ff,strtoint(fEmpresas.ValueByName[FIELD_IDEMPRESA]));
      DoLisEntObleasGNCxPlanta(fi,ff,lcbEmpresa.Text);
    end;
    2:begin
      if not GetDates(fi,ff) then exit;
      DoMovimientoObleas(fi,ff,0,MOV_TIPO_ENTRADA);
      DoLisMovObleasGNCGlobal(fi,ff,L_TIPO_GNC);
    end;
    3:begin
      if lcbPlanta.Text = '' then
      begin
         MessageDlg(CAPTION,'Seleccione una Planta', mtError, [mbOk], mbOk, 0);
         lcbPlanta.SetFocus;
         exit;
      end;
      if not GetDates(fi,ff) then exit;
      DoMovimientoObleas(fi,ff,strtoint(fPlantas.valuebyname[FIELD_IDPLANTA]),MOV_TIPO_ENTRADA);
      ArrayVar:=VarArrayCreate([0,1],VarVariant);
      ArrayVar[0]:=fPlantas.ValueByName[FIELD_IDZONA];
      ArrayVar[1]:=fPlantas.ValueByName[FIELD_NROPLANTA];
      DoLisMovObleasGNCxPlanta(fi,ff,fPlantas.ExecuteFunction('GET_CODTALLER',ArrayVar)+' - '+lcbPlanta.Text,L_TIPO_GNC);
    end;
    4:begin
      if edNumeros.Text = '' then
      begin
         MessageDlg(CAPTION,'Ingrese un Nº de Movimiento', mtError, [mbOk], mbOk, 0);
         edNumeros.SetFocus;
         exit;
      end;
       DoRepMovObleasGNC(edNumeros.Text,0);
    end;
    5:begin
      if lcbPlanta2.Text = '' then
      begin
         MessageDlg(CAPTION,'Seleccione una Planta', mtError, [mbOk], mbOk, 0);
         lcbPlanta2.SetFocus;
         exit;
      end;
      DoStockenPlanta(strtoint(fPlantas.valuebyname[FIELD_IDPLANTA]));
      ArrayVar:=VarArrayCreate([0,1],VarVariant);
      ArrayVar[0]:=fPlantas.ValueByName[FIELD_IDZONA];
      ArrayVar[1]:=fPlantas.ValueByName[FIELD_NROPLANTA];
      DoLisStockenPlanta(fPlantas.ExecuteFunction('GET_CODTALLER',ArrayVar)+' - '+lcbPlanta2.Text, L_TIPO_GNC);
    end;
    6:begin
      if not GetDates(fi,ff) then exit;
      DoConsumoObleas(fi,ff);
      DoLisConsumosGNC(fi,ff);
    end;
    7:begin
      if not GetDates(fi,ff) then exit;
      DoEnvioCDGNC(fi,ff);
      DoLisEnvioCDGNC('Desde: '+copy(fi,1,10)+' - Hasta: '+copy(ff,1,10));
    end;
    8:
    begin
      DoStockGlobal;
      DoLisStockGlobal;
    end;

    9:
    begin
      if not GetDates(fi,ff) then exit;
      DoMovimientoObleas(fi,ff,0,MOV_TIPO_MOVIMIENTO);
      DoLisEnvObleasGNCGlobal(fi,ff,L_TIPO_GNC);
    end;
    10:
    begin
      if lcbPlanta.Text = '' then
      begin
         MessageDlg(CAPTION,'Seleccione una Planta', mtError, [mbOk], mbOk, 0);
         lcbPlanta.SetFocus;
         exit;
      end;
      if not GetDates(fi,ff) then exit;
      DoMovimientoObleas(fi,ff,strtoint(fPlantas.valuebyname[FIELD_IDPLANTA]),MOV_TIPO_MOVIMIENTO);
      ArrayVar:=VarArrayCreate([0,1],VarVariant);
      ArrayVar[0]:=fPlantas.ValueByName[FIELD_IDZONA];
      ArrayVar[1]:=fPlantas.ValueByName[FIELD_NROPLANTA];
      DoLisEnvObleasGNCxPlanta(fi,ff,fPlantas.ExecuteFunction('GET_CODTALLER',ArrayVar)+' - '+lcbPlanta.Text,L_TIPO_GNC);
    end;


  end
  else
    MessageDlg(CAPTION,'Seleccione un Informe', mtError, [mbOk], mbOk, 0);
end;

procedure TfrmListados.btnSalirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmListados.DoEntradaObleas(FechaIni, FechaFin: string;
  aEmpresa: integer);
begin
    DeleteTable(MyBD, 'TTMP_ENTRADAS');
    with TStoredProc.Create(nil) do
    try
        DataBaseName := MyBD.DataBaseName;
        SessionName := MyBD.SessionName;

        if aEmpresa = 0 then
           StoredProcName := 'LIST_ENTRADAS_GLOBAL'
        else
           StoredProcName := 'LIST_ENTRADAS';
        Prepare;
        ParamByName('FECHAINI').Value := FI;
        ParamByName('FECHAFIN').Value := FF;

        if aEmpresa <> 0 then
            ParamByName('aEmpresa').Value := aEmpresa;
        ExecProc;
        Close;
    finally
        Free
    end
end;

procedure TfrmListados.DoMovimientoObleas(FechaIni, FechaFin: string;
  aPlanta: integer; aTipo: string);
begin
  if aTipo = MOV_TIPO_ENTRADA then
  begin
    DeleteTable(MyBD, 'TTMP_MOVIMIENTOS');
    with TStoredProc.Create(nil) do
    try
        DataBaseName := MyBD.DataBaseName;
        SessionName := MyBD.SessionName;

        if aPlanta = 0 then
           StoredProcName := 'LIST_MOVIMIENTOS_GLOBAL'
        else
           StoredProcName := 'LIST_MOVIMIENTOS';
        Prepare;
        ParamByName('FECHAINI').Value := FI;
        ParamByName('FECHAFIN').Value := FF;

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
    with TStoredProc.Create(nil) do
    try
        DataBaseName := MyBD.DataBaseName;
        SessionName := MyBD.SessionName;

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
        Prepare;
        ParamByName('FECHAINI').Value := FI;
        ParamByName('FECHAFIN').Value := FF;

        if aPlanta <> 0 then
            ParamByName('aPlanta').Value := aPlanta;
        ExecProc;
        Close;
    finally
        Free
    end
  end;
end;

procedure TfrmListados.FormCreate(Sender: TObject);
begin
  fPlantas := nil;
  fEmpresas := nil;
  fPlantas := tPlantas.Create(mybd);
  fEmpresas := tEmpresas.Create(mybd);
  fPlantas.Open;
  fEmpresas.Open;
  srcPlantas.DataSet := fPlantas.DataSet;
  srcEmpresas.DataSet := fEmpresas.DataSet;
end;

procedure TfrmListados.rgListadosClick(Sender: TObject);
begin
  MostrarComponentes(false,self,[4,2,5,6]);
  MostrarComponentes(true,self,[rglistados.itemindex+1]);
  case rglistados.itemindex of
    10:
    begin
      MostrarComponentes(true,self,[4]);
    end;
  end;

end;

procedure TfrmListados.edNumerosKeyPress(Sender: TObject; var Key: Char);
begin
        if not (Key in ['0','1','2','3','4','5','6','7','8','9',char(VK_BACK)])
        then key := #0
end;

procedure TfrmListados.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TfrmListados.DoStockenPlanta(aPlanta: integer);
begin
    DeleteTable(MyBD, 'TTMP_STOCKOBLEAS');
    with TStoredProc.Create(nil) do
    try
        DataBaseName := MyBD.DataBaseName;
        SessionName := MyBD.SessionName;
        StoredProcName := 'STOCK_OBLEAS';
        Prepare;
        ParamByName('aPlanta').Value := aPlanta;
        ExecProc;
        Close;
    finally
        Free
    end
end;

procedure TfrmListados.lcbPlanta2CloseUp(Sender: TObject);
begin
  lcbPlanta2.Value := fPlantas.ValueByName[lcbPlanta2.LookUpField];
end;

procedure TfrmListados.lcbEmpresaCloseUp(Sender: TObject);
begin
  lcbEmpresa.Value := fEmpresas.ValueByName[lcbEmpresa.LookupField];
end;

procedure TfrmListados.lcbPlantaCloseUp(Sender: TObject);
begin
  lcbPlanta.Value := fPlantas.ValueByName[lcbPlanta.LookUpField];
end;

procedure TfrmListados.DoConsumoObleas(FechaIni, Fechafin: string);
begin
    DeleteTable(MyBD, 'TTMP_CONSUMOS');
    with TStoredProc.Create(nil) do
    try
        DataBaseName := MyBD.DataBaseName;
        SessionName := MyBD.SessionName;
        StoredProcName := 'LIST_CONSUMOS_GLOBAL';
        Prepare;
        ParamByName('FI').Value := FI;
        ParamByName('FF').Value := FF;
        ExecProc;
        Close;
    finally
        Free
    end

end;

procedure TfrmListados.DoEnvioCDGNC(FechaIni, Fechafin: string);
begin
    DeleteTable(MyBD, 'TTMP_CONTROL');
    with TStoredProc.Create(nil) do
    try
        DataBaseName := MyBD.DataBaseName;
        SessionName := MyBD.SessionName;
        StoredProcName := 'LIST_CONTROL_ENVIOS';
        Prepare;
        ParamByName('FI').Value := FI;
        ParamByName('FF').Value := FF;
        ExecProc;
        Close;
    finally
        Free
    end
end;

procedure TfrmListados.DoStockGlobal;
begin
    DeleteTable(MyBD, 'TTMP_STOCKOBLEAS_GLOBAL');
    with TStoredProc.Create(nil) do
    try
        DataBaseName := MyBD.DataBaseName;
        SessionName := MyBD.SessionName;
        StoredProcName := 'STOCK_OBLEAS_GLOBAL';
        Prepare;
        ExecProc;
        Close;
    finally
        Free
    end
end;

end.
