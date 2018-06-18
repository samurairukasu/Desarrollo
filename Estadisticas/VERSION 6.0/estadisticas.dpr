program estadisticas;

uses
  Forms,
  UFPrincipal in 'ufprincipal.pas' {frmprincipal},
  Unitespera in 'Unitespera.pas' {espera},
  UFEstadTIPO3Cumplidores in 'UFEstadTIPO3Cumplidores.pas' {fRepTIPO3Cump},
  Unitfrmmailingenviado in 'Unitfrmmailingenviado.pas' {frmmailingenviado},
  Unit1ANIOMES in 'Unit1ANIOMES.pas' {ANIOMES},
  unit_frmmailng_sms_cumplidores in 'unit_frmmailng_sms_cumplidores.pas' {frmmailing_sms_cumplidores};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrmprincipal, frmprincipal);
  Application.CreateForm(Tespera, espera);
  Application.CreateForm(TfRepTIPO3Cump, fRepTIPO3Cump);
  Application.CreateForm(Tfrmmailingenviado, frmmailingenviado);
  Application.CreateForm(TANIOMES, ANIOMES);
  Application.CreateForm(Tfrmmailing_sms_cumplidores, frmmailing_sms_cumplidores);
  Application.Run;
end.               

