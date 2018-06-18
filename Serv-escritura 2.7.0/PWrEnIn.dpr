program PWrEnIn;

uses
  ULogs,
  Windows,
  Forms,UCDialgs,
  UWraMaha in 'UWraMaha.pas' {FrmES_IN},
  UWrEs_In in 'UWrEs_In.pas',
  UInicio in 'UInicio.pas' {FrmInicio},
  USucesos in 'USucesos.pas' {FrmSucesos},
  UModDat in 'umoddat.pas' {DataDiccionario: TDataModule};


{$R *.RES}
var
    aHandle: THandle;

begin
Application.Initialize;
Application.CreateForm(TFrmES_IN, FrmES_IN);
Application.Title := 'Servidor de Escritura';
Application.Run;
end.

