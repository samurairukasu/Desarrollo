unit UFPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, SpeedBar, ExtCtrls, RxMenus, RxLookup,DBCtrls,Menus,
  StdCtrls, Mask, uversion, globals, ucdialgs,
  ActnList, XPStyleActnCtrls, ActnMan, ToolWin, ActnCtrls, uStockEstacion,
  FMTBcd, ExcelXP, OleServer, RxMemDS, Provider, SqlExpr, DBClient;


type
  TFrmPrincipal = class(TForm)
    SpeedBar1: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    BtnRecepObleasGNC: TSpeedItem;
    ActionManager1: TActionManager;
    actRecepObleasGNC: TAction;
    btnSalir: TSpeedItem;
    btnMovObleasGNC: TSpeedItem;
    actMovObleasGNC: TAction;
    actListadosGNC: TAction;
    btnListados: TSpeedItem;
    btnTablas: TSpeedItem;
    ActionToolBar1: TActionToolBar;
    actDevolDepoGNC: TAction;
    SpeedItem1: TSpeedItem;
    actRecepObleasVTV: TAction;
    actMovObleasVTV: TAction;
    actListadosVTV: TAction;
    actTransferVTV: TAction;
    actTransferExtraVTV: TAction;
    actDevolObleasVTV: TAction;
    pmrecep: TRxPopupMenu;
    RecepcindeObleasGNC1: TMenuItem;
    RecepcindeObleasVTV1: TMenuItem;
    pmmovimiento: TRxPopupMenu;
    MovimientodeObleasGNC1: TMenuItem;
    MovimientodeObleasVTV1: TMenuItem;
    RecepcindeObleasVTV2: TMenuItem;
    ransferenciadeObleasVTV1: TMenuItem;
    pmdevolucion: TRxPopupMenu;
    DevolucinObleasaDepsitoGNC1: TMenuItem;
    DevolucinObleasVTV1: TMenuItem;
    pmlistados: TRxPopupMenu;
    ListadosGNC1: TMenuItem;
    ListadosVTV1: TMenuItem;
    EntradadeObleasGlobal1: TMenuItem;
    EntradadeObleasporEmpresa1: TMenuItem;
    RecepcindeObleasGlobal1: TMenuItem;
    RecepcindeObleasporPlanta1: TMenuItem;
    ReimpresindeEntregadeObleas1: TMenuItem;
    StockdeObleasporPlanta1: TMenuItem;
    Consumodeobleas1: TMenuItem;
    EnvosdeCDGNC1: TMenuItem;
    StockdeObleasGlobal1: TMenuItem;
    EnvodeObleasGlobal1: TMenuItem;
    EnvodeObleasporPlanta1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    EntradadeObleasGlobal2: TMenuItem;
    EntradadeObleasporEmpresa2: TMenuItem;
    MovimintosGlobal1: TMenuItem;
    MovimientosporPlanta1: TMenuItem;
    RempresindeEntregadeObleas1: TMenuItem;
    StockdeObleasporPlanta2: TMenuItem;
    ConsumodeObleas2: TMenuItem;
    EnvosdeCDVTV1: TMenuItem;
    StockdeObleasGlobal2: TMenuItem;
    ReimpresindeTransferenciadeZonas1: TMenuItem;
    ReimpresindeTransferenciaExtraZonas1: TMenuItem;
    ReimpresindeDevolucindeObleas1: TMenuItem;
    ConsumodeObleasporAodeOblea1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    PlanillaControlArqueoObleas1: TMenuItem;
    ListadoControlRecepcinObleas1: TMenuItem;
    actControlArqObleas: TAction;
    actControlMinimosVTV: TAction;
    ControlMnimosVTV1: TMenuItem;
    actControlMinimosGNC: TAction;
    ControlMnimosGNC1: TMenuItem;
    StockaFecha1: TMenuItem;
    actMovInformeinsp: TAction;
    MovimientodeInformedeInspeccin1: TMenuItem;
    RecepciondeCertificadoseInformes1: TMenuItem;
    ActRecepCertifeInfor: TAction;
    N9: TMenuItem;
    StockdeCertificadoseInformes1: TMenuItem;
    ConsumodeCertificadoseInformes1: TMenuItem;
    EntradasdeCertificados1: TMenuItem;
    EntradadeInformes1: TMenuItem;
    ProveedoresdeObleas1: TMenuItem;
    ReimpresindeEntregadeInformes1: TMenuItem;
    StockaFecha2: TMenuItem;
    DoConsumoObleasxAnio_Excel: TMenuItem;
    MovimintosGlobal_PDF: TMenuItem;
    MovimintosGlobal_Excel: TMenuItem;
    Entrada_Obleas_Global_PDF: TMenuItem;
    Excel1: TMenuItem;
    Stock_Obleas_x_Planta_PDF: TMenuItem;
    Stock_Obleas_x_Planta_Excel: TMenuItem;
    PDF1: TMenuItem;
    Excel2: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure btnsalirClick(Sender: TObject); 
    procedure BtnRecepObleasGNCClick(Sender: TObject);
    procedure SpeedItem1Click(Sender: TObject);
    procedure EntradadeObleasGlobal1Click(Sender: TObject);
    procedure EntradadeObleasporEmpresa1Click(Sender: TObject);
    procedure RecepcindeObleasGlobal1Click(Sender: TObject);
    procedure MovimintosGlobal1Click(Sender: TObject);
    procedure DoStockAFecha(Fecha : string);
    procedure DoConsumoObleasxAnio_PDFClick(Sender: TObject);
    procedure DoConsumoObleasxAnio_ExcelClick(Sender: TObject);
    procedure MovimintosGlobal_ExcelClick(Sender: TObject);
    procedure MovimintosGlobal_PDFClick(Sender: TObject);
    procedure Entrada_Obleas_Global_PDFClick(Sender: TObject);
    procedure Excel1Click(Sender: TObject);
    procedure Stock_Obleas_x_Planta_PDFClick(Sender: TObject);
    procedure Stock_Obleas_x_Planta_ExcelClick(Sender: TObject);
    procedure Excel2Click(Sender: TObject);
  private
    { Private declarations }
    fi,ff, NomEmpresa, NomPlanta,
    Taller, Numero: string;
    idEmpresa, IdPlanta : integer;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

resourcestring
  FILE_NAME = 'UfPrincipal';

implementation
{$R *.dfm}

uses ulogs,
  UfInicioAplicacion,
  ufRecepObleasGNC,
  ufMovObleasGNC,
  uListadosGNC,
  ufDevolObleas,
  ufRecepObleasVTV,
  ufMovObleasVTV,
  uListadosVTV,
  ufTransObleasVTV,
  ufTransObleasExtraVTV,
  ufDevolObleasVTV,
  uGetDates,
  urListEntObleasGNC,
  urListEntObleasGNC_Excel,
  uGetEmpresa,
  urListMovObleasGNC,
  urListMovObleasGNC_Excel,
  urListStockenPlanta,
  urListStockenPlanta_Excel,
  urMovObleasVTV,
  urListConsumosVTV,
  urListEnviosCD,
  urListStockGlobal,
  urListConsumosGNC,
  urListEnvObleasGNC,
  urListStockAFechaVtv,
  uGetPlanta,
  uGetNumero,
  urMovObleasGNC,
  urListEnviosCDVTV,
  urListStockGlobalVTV,
  urListStockObleasGlobalExcel,
  urTransObleasVTV,
  urTransObleasExtraVTV,
  urDevolObleasVTV,
  urListConsumosVTVxAno,
  urListConsumosVTVxAnio_Excel,
  urListControlRecepOblVTV,
  ufPlanillaControlObleas,
  uftmp,
  ufControlMinimosVTV,
  urStockAFecha,
  ufMovInformes,
  ufRecepCertifeInformes,
  urListStockCertificados,
  urListConsCertificados,
  urListProveedoresObleas,
  urListEntCertificados,
  urListEntInformes,
  urListMovInformes,
  urListMovCertificados,
  urMovInformes;


var
    bActivandose : boolean = TRUE;

procedure InitError(Msg: String);
begin
        MessageDlg('Error en la Inicialización',Msg,mtError,[mbOK],mbOK,0);
        if Assigned(fAnomalias)
        then fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FILE_NAME,Msg);
        InitializationError := TRUE;
        Application.Terminate;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
var
        Ahora : tDateTime;
begin

        if bActivandose
        then begin

            Top := -7000;

            if (FindWindow(Pchar('TFInicioAplicacion'), PChar(NOMBRE_PROYECTO)) <> 0) or (FindWindow(Pchar('TFrmPrincipal'), PChar('Sistema de Gestión de Stock de Applus Argentina S.A.')) <> 0)
            then InitError('Ya existe una copia del programa en ejecución')
            else
              InitLogs;

            if InitializationError
            then exit;
            Caption := 'Sistema de Gestión de Stock de Applus Argentina S.A. 2010';

            bActivandose := FALSE;

            with TFInicioAplicacion.Create(Application) do
            try
                {$IFDEF TRAZAS}
                fTrazas.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'%S', [LITERAL_VERSION]);
                {$ENDIF}

                Status.Caption := Format('%S (Comprobando su sistema)', [LITERAL_VERSION]);
                Show;

                Application.ProcessMessages;
                {!!!!!!!!!!!}

                if InitializationError
                then exit;
                Status.Caption := Format('%S (Comprobando su estructura)', [LITERAL_VERSION]);
                Application.ProcessMessages;
//                TestOfTerminal;

                if InitializationError
                then exit;

                TestOfDirectories;

                Status.Caption := Format('%S (Conectándose al servidor)', [LITERAL_VERSION]);
                Application.ProcessMessages;
                If ParamCount=0
                then
                    TestOfBD('','','')
                else begin
                    If ParamCount=1
                    Then begin
                        TestOfBD(ParamStr(1),'','');
                    end
                    else begin
                        If ParamCount=3
                        Then begin
                            TestOfBD(ParamStr(1),ParamStr(2),ParamStr(3));
                        end
                        else begin
                            TestOfBD('','','');
                        end;

                    end;
                end;
                if InitializationError
                then exit;
//                TestOfAcceso;
//                Status.Caption := Format('%S (Iniciando Configuración Base)', [LITERAL_VERSION]);
                Application.ProcessMessages;
                InitAplicationGlobalTables;
                if InitializationError
                then exit;

                Ahora := Now;
                while Now <= (Ahora + EncodeTime(0,0,3,0)) do Application.ProcessMessages;
            finally
              free;
            end;
            Top := Top + 7000;
            Application.ProcessMessages;
        end;

end;

procedure TFrmPrincipal.btnsalirClick(Sender: TObject);
begin
  application.Terminate;
end;


procedure TFrmPrincipal.BtnRecepObleasGNCClick(Sender: TObject);
var aServicio : Integer;
begin
  aServicio := (Sender as TComponent).Tag;
  case aServicio of
    1:Begin
        DoRecepObleasGNC;
    end;
    2:Begin
        DoMovObleasGNC;
    end;
    4:begin
        DoDevObleasGNC;
    end;
    5:begin
        DoRecepObleasVTV;
    end;
    6:begin
        DoMovObleasVTV;
    end;
    8:begin
        DoTransObleasVTV;
    end;
    9:begin
        DoTransObleasExtraVTV
    end;
    10:begin
        DoDevolObleasVTV
    end;
    11:Begin
        DoMovInformes;
    end;
    12:Begin
        DoRecepCertifeInformes;
    end;


  end;
end;

procedure TFrmPrincipal.SpeedItem1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmPrincipal.EntradadeObleasGlobal1Click(Sender: TObject);
begin
      if not GetDates(fi,ff) then exit;
      DoEntradaObleasGNC(fi,ff,0);
      DoLisEntObleasGNCGlobal(fi,ff);
end;

procedure TFrmPrincipal.EntradadeObleasporEmpresa1Click(Sender: TObject);
begin
      if not GetDates(fi,ff) then exit;
      if not GetEmpresa(idempresa,NomEmpresa) then exit;
      DoEntradaObleasGNC(fi,ff,idEmpresa);
      DoLisEntObleasGNCxPlanta(fi,ff,NomEmpresa);
end;

procedure TFrmPrincipal.RecepcindeObleasGlobal1Click(Sender: TObject);
var aServicio : Integer;
begin
  aServicio := (Sender as TComponent).Tag;
  case aServicio of
    0:begin
      if not GetDates(fi,ff) then exit;
      DoMovimientoObleasGNC(fi,ff,0,MOV_TIPO_ENTRADA);
      DoLisMovObleasGNCGlobal(fi,ff,L_TIPO_GNC);
    end;
    1:begin
      if not GetDates(fi,ff) then exit;
      if not GetPlanta(idplanta, nomplanta, taller) then exit;
      DoMovimientoObleasGNC(fi,ff,idplanta,MOV_TIPO_ENTRADA);
      DoLisMovObleasGNCxPlanta(fi,ff,Taller+' - '+nomplanta,L_TIPO_GNC);
    end;
    2:begin
       if not GetNumero(numero) then exit;
       DoRepMovObleasGNC(numero,0);
    end;
    3:begin
      if not GetPlanta(idplanta, nomplanta, taller) then exit;
      DoStockenPlantaGNC(idplanta);
      DoLisStockenPlanta(taller+' - '+nomplanta,inttostr(idplanta), L_TIPO_GNC);
    end;
    4:begin
      if not GetDates(fi,ff) then exit;
      DoConsumoObleasGNC(fi,ff);
      DoLisConsumosGNC(fi,ff);
    end;
    5:begin
      if not GetDates(fi,ff) then exit;
      DoEnvioCDGNC(fi,ff);
      DoLisEnvioCDGNC('Desde: '+copy(fi,1,10)+' - Hasta: '+copy(ff,1,10));
    end;
    6:begin
      DoStockGlobalGNC;
      DoLisStockGlobal;
    end;
    7:begin
      if not GetDates(fi,ff) then exit;
      DoMovimientoObleasGNC(fi,ff,0,MOV_TIPO_MOVIMIENTO);
      DoLisEnvObleasGNCGlobal(fi,ff,L_TIPO_GNC);
    end;
    8:begin
      if not GetDates(fi,ff) then exit;
      if not GetPlanta(idplanta, nomplanta, taller) then exit;
      DoMovimientoObleasGNC(fi,ff,idplanta,MOV_TIPO_MOVIMIENTO);
      DoLisEnvObleasGNCxPlanta(fi,ff,taller+' - '+nomplanta,L_TIPO_GNC);
    end;
    9:begin
      if not GetDates(fi,ff) then exit;
      DoEntradaObleasGNC(fi,ff,0);
      DoLisEntObleasGNCGlobal(fi,ff);
    end;
    10:begin
      if not GetDates(fi,ff) then exit;
      if not GetEmpresa(idempresa,NomEmpresa) then exit;
      DoEntradaObleasGNC(fi,ff,idempresa);
      DoLisEntObleasGNCxPlanta(fi,ff,NomEmpresa);
    end;
    11:begin
      if not GetDates(fi,ff) then exit;
      DoStockAFecha(copy(fi,1,10)+'23:59:59')
    end;
  end;
end;

procedure TFrmPrincipal.MovimintosGlobal1Click(Sender: TObject);
var aServicio : integer;
begin
  aServicio := (Sender as TComponent).Tag;
  case aServicio of
    {0:begin
      if not GetDates(fi,ff) then exit;
      DoMovimientoObleasVTV(fi,ff,0);
      DoLisMovObleasGNCGlobal(fi,ff,L_TIPO_VTV);
    end;}
    1:begin
      if not GetDates(fi,ff) then exit;
      if not GetPlanta(idplanta, nomplanta, taller) then exit;
      DoMovimientoObleasvtv(fi,ff,idplanta);
      DoLisMovObleasGNCxPlanta(fi,ff,nomplanta,L_TIPO_VTV);
    end;
    2:begin
      DoStockGlobalVTV;
      DoLisStockGlobalVTV;
    end;
    {3:begin
      if not GetPlanta(idplanta, nomplanta, taller) then exit;
      DoStockenPlantaVTV(idplanta);
      DoLisStockenPlanta(nomplanta,IntToStr(idplanta),L_TIPO_VTV);
    end;}
    4:begin
      if not GetNumero(numero) then exit;
      DoRepDevolObleasVTV(numero,0)
    end;
    5:begin
      if not GetNumero(numero) then exit;
      DoRepMovObleasVTV(numero,0);
    end;
    6:begin
      if not GetNumero(numero) then exit;
      DoRepTransObleasExtraVTV(numero,0)
    end;
    7:begin
      if not GetNumero(numero) then exit;
      DoRepTransObleasVTV(numero,0)
    end;
    8:begin
      if not GetDates(fi,ff) then exit;
      DoEnvioCDVTV(fi,ff);
      DoLisEnvioCDVTV('Desde: '+copy(fi,1,10)+' - Hasta: '+copy(ff,1,10));
    end;
    9:begin
      if not GetDates(fi,ff) then exit;
      DoConsumoObleasVTV(fi,ff);
      DoLisConsumosVTV(fi,ff);
    end;
    {10:begin
      if not GetDates(fi,ff) then exit;
      DoConsumoObleasxAnoVTV(fi,ff);
      DoLisConsumosVTVxAno(fi,ff);
    end;}
    {11:begin
      if not GetDates(fi,ff) then exit;
      DoEntradaObleasVTV(fi,ff,0);
      DoLisEntObleasGNCGlobal(fi,ff);
    end;}
    12:begin
      if not GetDates(fi,ff) then exit;
      if not GetEmpresa(idempresa,NomEmpresa) then exit;
      DoEntradaObleasVTV(fi,ff,idempresa);
      DoLisEntObleasGNCxPlanta(fi,ff,NomEmpresa);
    end;
    13:begin
      if not GetDates(fi,ff) then exit;
      DoControlRecepObleasVTV(fi,ff);
      DoLisContReceObleasVTV(fi,ff);
    end;
    14:begin
      if not GetDates(fi,ff) then exit;
      FTmp.Temporizar(TRUE,FALSE,'Planilla Control Obleas', 'Generando la Planilla de Control de Obleas');
      Application.ProcessMessages;
      DoConsumoObleasxAnoVTV(fi,ff);
      DoStockGlobalVTV;
      FTmp.Temporizar(FALSE,FALSE,'', '');
      Application.ProcessMessages;
      GeneratePlanillaControlObleas(fi,ff);
    end;
    15:begin
      GenerateControMinimosVTV;
    end;
    16:begin
      GenerateControMinimosGNC;
    end;
    17:begin
      DoStockCertificados;
      DoLisStockCertificados;
    end;
    18:begin
      DoConsCertificados;
      DoLisConsCertificados;
    end;
    19:begin
     if not GetDates(fi,ff) then exit;
      DoEntradaCertificados(fi,ff,0);
      DoLisEntCertificados(fi,ff);
    end;
    20:begin
     if not GetDates(fi,ff) then exit;
      DoEntradaInformes(fi,ff,0);
      DoLisEntInformes(fi,ff);
    end;
    21:begin
     if not GetDates(fi,ff) then exit;
      DoMovCertificados(fi,ff,0);
      DoLisMovCertificados(fi,ff);
    end;
    22:begin
      DoLisProveedoresObleas;
    end;
    23:begin
      if not GetNumero(numero) then exit;
      DoRepMovInformes(numero,0);
    end;
     24:begin
       if not GetDates(fi,ff) then exit;
        DoStockGlobalVTVAfecha(ff);
        DoLisStockGlobalVTVafecha(ff);
    end;
  end;

end;

procedure TFrmPrincipal.DoStockAFecha(Fecha: string);
begin
  DoRepStockAFecha(fecha);
end;

procedure TFrmPrincipal.DoConsumoObleasxAnio_PDFClick(Sender: TObject);
  begin
      if not GetDates(fi,ff) then exit;
      DoConsumoObleasxAnoVTV(fi,ff);
      DoLisConsumosVTVxAno(fi,ff);
  end;

procedure TFrmPrincipal.DoConsumoObleasxAnio_ExcelClick(Sender: TObject);
  begin
      if not GetDates(fi,ff) then exit;
      DoConsumoObleasxAnoVTV(fi,ff);
      urListConsumosVTVxAnio_Excel.ListaConsumosVTVxAnio_Excel.ShowModal;
  end;

procedure TFrmPrincipal.MovimintosGlobal_PDFClick(Sender: TObject);
begin
      if not GetDates(fi,ff) then exit;
      DoMovimientoObleasVTV(fi,ff,0);
      DoLisMovObleasGNCGlobal(fi,ff,L_TIPO_VTV);
end;

procedure TFrmPrincipal.MovimintosGlobal_ExcelClick(Sender: TObject);
begin
      if not GetDates(fi,ff) then exit;
      DoMovimientoObleasVTV(fi,ff,0);
      urListMovObleasGNC_Excel.ListaMovObleasGNCGlobal_Excel.ShowModal;
end;

procedure TFrmPrincipal.Entrada_Obleas_Global_PDFClick(Sender: TObject);
begin
      if not GetDates(fi,ff) then exit;
      DoEntradaObleasVTV(fi,ff,0);
      DoLisEntObleasGNCGlobal(fi,ff);
end;

procedure TFrmPrincipal.Excel1Click(Sender: TObject);
begin
      if not GetDates(fi,ff) then exit;
      DoEntradaObleasVTV(fi,ff,0);
      urListEntObleasGNC_Excel.ListaEntradaObleas_Excel.ShowModal;
end;

procedure TFrmPrincipal.Stock_Obleas_x_Planta_PDFClick(Sender: TObject);
begin
      if not GetPlanta(idplanta, nomplanta, taller) then exit;
      DoStockenPlantaVTV(idplanta);
      DoLisStockenPlanta(nomplanta,IntToStr(idplanta),L_TIPO_VTV);
end;

procedure TFrmPrincipal.Stock_Obleas_x_Planta_ExcelClick(Sender: TObject);
begin
      if not GetPlanta(idplanta, nomplanta, taller) then exit;
      DoStockenPlantaVTV(idplanta);
      urListStockenPlanta_Excel.ListaStockEnPlanta_Excel.ShowModal;
end;

procedure TFrmPrincipal.Excel2Click(Sender: TObject);
begin
      DoStockGlobalVTV;
      urListStockObleasGlobalExcel.fListStockObleaGlobalExcel.ShowModal;
end;

end.
