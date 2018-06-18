program Incidencias;

uses
  Forms,
  Unitincedencias in 'Unitincedencias.pas' {principal},
  Unitcambiar_oblea in 'Unitcambiar_oblea.pas' {cambiar_oblea},
  Umodulo in 'Umodulo.pas' {modulo: TDataModule},
  Globals in 'Globals.pas',
  Unitmensaje in 'Unitmensaje.pas' {mensaje},
  Unitcambiar_oblea_a_inspec in 'Unitcambiar_oblea_a_inspec.pas' {cambiar_oblea_a_inspec},
  Unitcambio_de_pantentes in 'Unitcambio_de_pantentes.pas' {cambio_de_pantentes},
  Unitcambio_de_dni in 'Unitcambio_de_dni.pas' {cambio_de_dni},
  Unitcambiar_cliente_a_inspeccion in 'Unitcambiar_cliente_a_inspeccion.pas' {cambiar_cliente_a_inspeccion},
  Unitlogeo in 'Unitlogeo.pas' {logeo};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Incidencias';
  Application.CreateForm(Tprincipal, principal);
  Application.CreateForm(Tlogeo, logeo);
  Application.CreateForm(Tcambiar_oblea, cambiar_oblea);
  Application.CreateForm(Tmodulo, modulo);
  Application.CreateForm(Tmensaje, mensaje);
  Application.CreateForm(Tcambiar_oblea_a_inspec, cambiar_oblea_a_inspec);
  Application.CreateForm(Tcambio_de_pantentes, cambio_de_pantentes);
  Application.CreateForm(Tcambio_de_dni, cambio_de_dni);
  Application.CreateForm(Tcambiar_cliente_a_inspeccion, cambiar_cliente_a_inspeccion);
  Application.Run;
end.
