program EXPORTAR;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Umodulo in '..\Version 1.0.4_cHILE\Umodulo.pas' {modulo: TDataModule},
  USuperRegistry in '..\Version 1.0.4_cHILE\USuperRegistry.pas',
  UGLOBAL in '..\Version 1.0.4_cHILE\UGLOBAL.pas',
  Uconst in '..\Version 1.0.4_cHILE\Uconst.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tmodulo, modulo);

  Application.Run;
end.
