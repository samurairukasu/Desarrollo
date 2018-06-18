program Stock2010;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  UFPrincipal in 'UFPrincipal.pas' {FrmPrincipal},
  globals in 'globals.pas',
  urListConsumosVTVxAnio_Excel in 'urListConsumosVTVxAnio_Excel.pas' {ListaConsumosVTVxAnio_Excel},
  urListMovObleasGNC_Excel in 'urListMovObleasGNC_Excel.pas' {ListaMovObleasGNCGlobal_Excel},
  urListEntObleasGNC_Excel in 'urListEntObleasGNC_Excel.pas' {ListaEntradaObleas_Excel},
  urListStockenPlanta_Excel in 'urListStockenPlanta_Excel.pas' {ListaStockEnPlanta_Excel},
  urListStockObleasGlobalExcel in 'urListStockObleasGlobalExcel.pas' {fListStockObleaGlobalExcel};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Sistema de Gestion de Stock AGEVA';
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  //Application.CreateForm(TfrmRepStockAFechavtv, frmRepStockAFechavtv);
  Application.Run;
end.
