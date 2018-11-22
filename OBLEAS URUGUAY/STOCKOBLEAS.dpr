program STOCKOBLEAS;

uses
  Forms,
  ufMain in 'ufMain.pas' {FMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
