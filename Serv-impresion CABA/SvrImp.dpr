program SvrImp;

uses
  Forms,
  UPrinter in 'UPrinter.pas' {FrmPrinters},
  ULimpiezaVarEntorno in 'ULimpiezaVarEntorno.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrinters, FrmPrinters);
  Application.Run;
end.
