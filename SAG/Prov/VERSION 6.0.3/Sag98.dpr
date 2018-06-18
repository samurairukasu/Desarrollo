program Sag98;

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
  Ufaletas_vehiculos in 'Ufaletas_vehiculos.pas' {frmalertas_vehiculos},
  Unitnueva_alerta in 'Unitnueva_alerta.pas' {nueva_alerta},
  UUcontrola_de_impresion_nc in 'UUcontrola_de_impresion_nc.pas',
  Utarjetas_nc_cf in 'Utarjetas_nc_cf.pas' {tarj_nc_cf},
  Unitsincronizacion_cf in 'Unitsincronizacion_cf.pas' {sincronizacion_cf},
  Uncambiar_calificacion_defectos_solo_reve in 'Uncambiar_calificacion_defectos_solo_reve.pas' {cambiar_calificacion_defectos_solo_reve},
  Unifinaliza in 'Unifinaliza.pas' {fin},
  Ufrmconveniorucara in 'Ufrmconveniorucara.pas' {frmconveniorucara},
  Unitmodificar_nro_oblea_rucara in 'Unitmodificar_nro_oblea_rucara.pas' {modificar_nro_oblea_rucara},
  Unitfrmodificar_oblea_rucara_inspeccion in 'Unitfrmodificar_oblea_rucara_inspeccion.pas' {frmodificar_oblea_rucara_inspeccionunit},
  ufrmodificar_oblea_en_tvarios in 'ufrmodificar_oblea_en_tvarios.pas' {frmodificar_oblea_en_tvarios},
  Unitpide_fecha in 'Unitpide_fecha.pas' {pide_fecha},
  URucara in 'URucara.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Sag. X3 (Estaciones) Ver 5.3.9';
  Application.CreateForm(TFMainSag98, FMainSag98);
  Application.CreateForm(Tnueva_alerta, nueva_alerta);
  Application.CreateForm(Tsincronizacion_cf, sincronizacion_cf);
  Application.CreateForm(Tcambiar_calificacion_defectos_solo_reve, cambiar_calificacion_defectos_solo_reve);
  Application.CreateForm(Tfin, fin);
  Application.CreateForm(Tfrmconveniorucara, frmconveniorucara);
  Application.CreateForm(Tfrmodificar_oblea_rucara_inspeccionunit, frmodificar_oblea_rucara_inspeccionunit);
  Application.CreateForm(Tmodificar_nro_oblea_rucara, modificar_nro_oblea_rucara);
  Application.CreateForm(Tfrmodificar_oblea_en_tvarios, frmodificar_oblea_en_tvarios);
  Application.CreateForm(Tpide_fecha, pide_fecha);
  Application.Run;
end.
