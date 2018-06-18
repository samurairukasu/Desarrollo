program Incidencias;

uses
  Forms,
  Acceso1 in 'Acceso1.pas',
  Acceso in 'ACCESO.pas',
  UFRecepcion in 'UFRECEPCION.pas' {FRecepcion},
  UFinVeri in 'UFinVeri.pas' {FrmFinal},
  UProtect in 'UPROTECT.pas',
  UFHistoricoInspecciones in 'UFHISTORICOINSPECCIONES.pas' {FHistoricoInspecciones},
  UVERSION_old in 'UVERSION_old.pas',
  UFMainSag98 in 'UFMainSag98.pas' {FMainSag98},
  UFDominios in 'UFDOMINIOS.pas' {FDominios},
  Ulistadocierrez in 'Ulistadocierrez.pas' {listadocierrez},
  UfimprimeinformeZ in 'UfimprimeinformeZ.pas' {UimprimeinformeZ},
  Ubuscar_inspeccion_por_patente in 'Ubuscar_inspeccion_por_patente.pas' {buscar_inspeccion_por_patente},
  Unitrestaura_obleas in 'Unitrestaura_obleas.pas' {restaura_obleas},
  Umodulo in '..\INCIDENCIAS\Umodulo.pas' {modulo: TDataModule},
  Unitmensaje in '..\INCIDENCIAS\Unitmensaje.pas' {mensaje},
  Unit1cambiar_oblea_a_inspec in 'Unit1cambiar_oblea_a_inspec.pas' {cambiar_oblea_a_inspec},
  Unitcambio_de_pantentes in 'Unitcambio_de_pantentes.pas' {cambio_de_pantentes},
  Unitcambio_de_dni in 'Unitcambio_de_dni.pas' {cambio_de_dni},
  Uncambiar_cliente_a_inspeccion in 'Uncambiar_cliente_a_inspeccion.pas' {cambiar_cliente_a_inspeccion};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Incidencias';
  Application.CreateForm(TFMainSag98, FMainSag98);
  Application.CreateForm(TFDominios, FDominios);
  Application.CreateForm(Tbuscar_inspeccion_por_patente, buscar_inspeccion_por_patente);
  Application.CreateForm(Trestaura_obleas, restaura_obleas);
  Application.CreateForm(Tmodulo, modulo);
  Application.CreateForm(Tmensaje, mensaje);
  Application.CreateForm(Tcambiar_oblea_a_inspec, cambiar_oblea_a_inspec);
  Application.CreateForm(Tcambio_de_pantentes, cambio_de_pantentes);
  Application.CreateForm(Tcambio_de_dni, cambio_de_dni);
  Application.CreateForm(Tcambiar_cliente_a_inspeccion, cambiar_cliente_a_inspeccion);
  Application.Run;
end.
