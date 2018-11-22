unit ufMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uversion, ULogs, UCHECSM, UCDialgs, globals, UTILORACLE, uStockEstacion,
  USTOCKDATA, UFInicioAplicacion, Menus, StdCtrls, Buttons, ToolWin,
  ActnMan, ActnCtrls, ActnList, XPStyleActnCtrls, RxMenus, UGetDates;

type
  TFMain = class(TForm)
    MainMenu1: TMainMenu;
    Listados1: TMenuItem;
    Movimientos1: TMenuItem;
    RecepciondeObleasGlobal: TMenuItem;
    CambiodePlanta1: TMenuItem;
    Salir1: TMenuItem;
    RecepObleaGlobalPDF: TMenuItem;
    RecepObleaGlobalExcel: TMenuItem;
    EntradadeObleasGlobal: TMenuItem;
    EntradadeObleasGlobalPDF: TMenuItem;
    EntradadeObleasGlobalExcel: TMenuItem;
    StockdeObleasGlobal: TMenuItem;
    StockdeObleasGlobalPDF: TMenuItem;
    StockdeObleasGlobalExcel: TMenuItem;
    StockdeObleasporPlanta: TMenuItem;
    StockdeObleasporPlantaPDF: TMenuItem;
    StockdeObleasporPlantaExcel: TMenuItem;
    ConsumodeObleasporAnio: TMenuItem;
    ConsumodeObleasporAnioPDF: TMenuItem;
    ConsumodeObleasporAnioExcel: TMenuItem;
    RecepciondeObleasITV1: TMenuItem;
    RecepcindeobleasporPlanta: TMenuItem;
    ProveedoresdeObleas: TMenuItem;
    PlanillaControlArqueoObleas: TMenuItem;
    ReimpresindeEntregadeObleas: TMenuItem;
    ActualizarBD1: TMenuItem;
    ActualizarObleas1: TMenuItem;
  procedure FormShow(Sender: TObject);
    procedure BtnSalirClick(Sender: TObject);
    procedure RecepObleaGlobalPDFClick(Sender: TObject);
    procedure EntradadeObleasGlobalPDFClick(Sender: TObject);
    procedure StockdeObleasGlobalPDFClick(Sender: TObject);
    procedure StockdeObleasporPlantaPDFClick(Sender: TObject);
    procedure ConsumodeObleasporAnioPDFClick(Sender: TObject);
    procedure RecepcindeobleasporPlantaClick(Sender: TObject);
    procedure ReimpresindeEntregadeObleasClick(Sender: TObject);
    procedure ProveedoresdeObleasClick(Sender: TObject);
    procedure PlanillaControlArqueoObleasClick(Sender: TObject);
    procedure RecepciondeObleasITV1Click(Sender: TObject);
    procedure ActualizarObleas1Click(Sender: TObject);
    procedure CambiodePlanta1Click(Sender: TObject);
  private
    { Private declarations }
    fi,ff, NomEmpresa, NomPlanta,
    Taller, Numero: string;
    idEmpresa, IdPlanta : integer;
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

{$R *.dfm}

uses
uftmp,
uListadosVTV,
uGetPlanta,
uGetNumero,
urListMovObleas,
urListEntObleas,
urListStockGlobalVTV,
urListStockenPlanta,
urListConsumosVTVxAno,
urMovObleasVTV,
urListProveedoresObleas,
ufPlanillaControlObleas,
ufRecepObleasVTV,
ufMovObleasVTV;

var
    bActivandose : boolean = TRUE;

procedure InitError(Msg: String);
begin
        MessageDlg('Error en la Inicializaci�n',Msg,mtError,[mbOK],mbOK,0);
        if Assigned(fAnomalias)
        then fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FILE_NAME,Msg);
        InitializationError := TRUE;
        Application.Terminate;
end;

procedure TFMain.FormShow(Sender: TObject);
var
        Ahora : tDateTime;
begin

        if bActivandose
        then begin

            Top := -7000;

            if (FindWindow(Pchar('TFInicioAplicacion'), PChar(NOMBRE_PROYECTO)) <> 0) or (FindWindow(Pchar('TFMain'), PChar('Gesti�n de Stock Applus Uruguay')) <> 0)
            then InitError('Ya existe una copia del programa en ejecuci�n')
            else
              InitLogs;

            if InitializationError
            then exit;
            Caption := 'Gesti�n de Stock Applus Uruguay';

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

                if InitializationError
                then exit;

                TestOfDirectories;

                Status.Caption := Format('%S (Conect�ndose al servidor)', [LITERAL_VERSION]);
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

procedure TFMain.BtnSalirClick(Sender: TObject);
begin
  application.Terminate;
end;

procedure TFMain.RecepObleaGlobalPDFClick(Sender: TObject);
begin
      if not GetDates(fi,ff) then exit;
      DoMovimientoObleasVTV(fi,ff,0);
      DoLisMovObleasGlobal(fi,ff,L_TIPO_VTV);
end;

procedure TFMain.EntradadeObleasGlobalPDFClick(Sender: TObject);
begin
      if not GetDates(fi,ff) then exit;
      DoEntradaObleasVTV(fi,ff,0);
      DoLisEntObleasGNCGlobal(fi,ff);
end;

procedure TFMain.StockdeObleasGlobalPDFClick(Sender: TObject);
begin
      DoStockGlobalVTV;
      DoLisStockGlobalVTV;
end;

procedure TFMain.StockdeObleasporPlantaPDFClick(Sender: TObject);
begin
      if not GetPlanta(idplanta, nomplanta, taller) then exit;
      DoStockenPlantaVTV(idplanta);
      DoLisStockenPlanta(nomplanta,IntToStr(idplanta),L_TIPO_VTV);
end;

procedure TFMain.ConsumodeObleasporAnioPDFClick(Sender: TObject);
begin
      if not GetDates(fi,ff) then exit;
      DoConsumoObleasxAnoVTV(fi,ff);
      DoLisConsumosVTVxAno(fi,ff);
end;

procedure TFMain.RecepcindeobleasporPlantaClick(Sender: TObject);
begin
      if not GetDates(fi,ff) then exit;
      if not GetPlanta(idplanta, nomplanta, taller) then exit;
      DoMovimientoObleasvtv(fi,ff,idplanta);
      DoLisMovObleasxPlanta(fi,ff,nomplanta,L_TIPO_VTV);
end;

procedure TFMain.ReimpresindeEntregadeObleasClick(Sender: TObject);
begin
      if not GetNumero(numero) then exit;
      DoRepMovObleasVTV(numero,0);
end;

procedure TFMain.ProveedoresdeObleasClick(Sender: TObject);
begin
    DoLisProveedoresObleas;
end;

procedure TFMain.PlanillaControlArqueoObleasClick(Sender: TObject);
begin
      if not GetDates(fi,ff) then exit;
      FTmp.Temporizar(TRUE,FALSE,'Planilla Control Obleas', 'Generando la Planilla de Control de Obleas');
      Application.ProcessMessages;
      DoConsumoObleasxAnoVTV(fi,ff);
      DoStockGlobalVTV;
      FTmp.Temporizar(FALSE,FALSE,'', '');
      Application.ProcessMessages;
      GeneratePlanillaControlObleas(fi,ff);
end;

procedure TFMain.RecepciondeObleasITV1Click(Sender: TObject);
begin
      DoRecepObleasVTV;
end;

procedure TFMain.CambiodePlanta1Click(Sender: TObject);
begin
      DoMovObleasVTV;
end;

procedure TFMain.ActualizarObleas1Click(Sender: TObject);
begin
      ActualizarObleas;
end;

end.