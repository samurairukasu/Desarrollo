program TurnosOnline;

uses
  Forms,
  UPRINCIPAL in 'UPRINCIPAL.pas' {Form1},
  Uingreso in 'Uingreso.pas' {ingreso_al_sistema},
  Umodulo in 'Umodulo.pas' {modulo: TDataModule},
  Uconst in 'Uconst.pas',
  UGLOBAL in 'UGLOBAL.pas',
  Usuarios in 'Usuarios.pas',
  Ugestion_usuarios in 'Ugestion_usuarios.pas' {gestion_usuarios},
  Uabm_usuario in 'Uabm_usuario.pas' {abm_usuario},
  Ugestion_de_empresa in 'Ugestion_de_empresa.pas' {gestion_de_empresa},
  Uempresas in 'Uempresas.pas',
  Uabm_empresa in 'Uabm_empresa.pas' {abm_empresa},
  Uhabiliar_empresa in 'Uhabiliar_empresa.pas' {habiliar_empresa},
  Uregistro_window in 'Uregistro_window.pas',
  Ucrear_plantilla in 'Ucrear_plantilla.pas' {crear_plantilla},
  Uver_turnos in 'Uver_turnos.pas' {ver_turnos},
  Uplantillas in 'Uplantillas.pas',
  Unitgestion_de_turnos in 'Unitgestion_de_turnos.pas' {gestion_de_turnos},
  Useleccione_fecha in 'Useleccione_fecha.pas' {seleccione_fecha},
  Ubuscar_por_patente in 'Ubuscar_por_patente.pas' {buscar_por_patente},
  Uimprimir_turnos in 'Uimprimir_turnos.pas' {imprimir_turnos},
  Umodificar_estado in 'Umodificar_estado.pas' {modificar_estado},
  Useleccione_fecha_para_reporte in 'Useleccione_fecha_para_reporte.pas' {seleccione_fecha_para_reporte},
  Uselecciona_plantilla in 'Uselecciona_plantilla.pas' {selecciona_plantilla},
  Uver_plantillas in 'Uver_plantillas.pas' {ver_plantillas},
  Umodificar_plantillas in 'Umodificar_plantillas.pas' {modificar_plantillas},
  Ucambiar_plantillas in 'Ucambiar_plantillas.pas' {cambiar_plantillas},
  USuperRegistry in 'USuperRegistry.pas',
  Udetalle_de_turnos_por_centros in 'Udetalle_de_turnos_por_centros.pas' {detalle_de_turnos_por_centros},
  Uinforme_detalle_por_turnos_por_centro in 'Uinforme_detalle_por_turnos_por_centro.pas' {informe_detalle_por_turnos_por_centro},
  Udetalle_cantidad_por_centro_por_fecha in 'Udetalle_cantidad_por_centro_por_fecha.pas' {detalle_cantidad_por_centro_por_fecha},
  Uimprime_detalle_cantidad_por_centro_por_fecha in 'Uimprime_detalle_cantidad_por_centro_por_fecha.pas' {imprime_detalle_cantidad_por_centro_por_fecha},
  Umensaje in 'Umensaje.pas' {mensaje},
  Ureporte_cantidad in 'Ureporte_cantidad.pas' {reporte_cantidad},
  Unit2borrar_turno in 'Unit2borrar_turno.pas' {borrar_turno},
  Unitcambiar_centro in 'Unitcambiar_centro.pas' {cambiar_centro},
  Unit2ingresar_por_codigo in 'Unit2ingresar_por_codigo.pas' {ingresar_por_codigo},
  Unitseleccione_fecha_cantidad_turnos_globalizado in 'Unitseleccione_fecha_cantidad_turnos_globalizado.pas' {seleccione_fecha_cantidad_turnos_globalizado},
  Unitcantidad_turnos_globalizado in 'Unitcantidad_turnos_globalizado.pas' {cantidad_turnos_globalizado},
  Unit2 in 'Unit2.pas' {Form2},
  Unitseleccione_fecha_turnos_por_plantilla in 'Unitseleccione_fecha_turnos_por_plantilla.pas' {seleccione_fecha_turnos_por_plantilla},
  Unitprocesando_e in 'Unitprocesando_e.pas' {procesando_e},
  Unitimprimie_asigandovsreservado in 'Unitimprimie_asigandovsreservado.pas' {imprimie_asigandovsreservado},
  Unit3listadoparamailing in 'Unit3listadoparamailing.pas' {seleccionefechayplanta},
  Unit3exportat_datos_a_turnos in 'Unit3exportat_datos_a_turnos.pas' {exportat_datos_a_turnos},
  UnitMENSAJEEXPORTA in 'UnitMENSAJEEXPORTA.pas' {MENSAJEEXPORTAWWEB},
  Unit3reporte_mailing in 'Unit3reporte_mailing.pas' {reporte_mailing},
  Unit3lo_que_tiene_que_venir in 'Unit3lo_que_tiene_que_venir.pas' {lo_que_tiene_que_venir};

{$R *.res}

begin
  Application.Initialize;
  // if not (modulo.conexion.Connected) then
 //    begin
 //     modulo.conexion.Open;
 //     modulo.conexion.Connected:=true;
  //   end;
  Application.CreateForm(Tingreso_al_sistema, ingreso_al_sistema);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tgestion_usuarios, gestion_usuarios);
  Application.CreateForm(Tabm_usuario, abm_usuario);
  Application.CreateForm(Tgestion_de_empresa, gestion_de_empresa);
  Application.CreateForm(Tabm_empresa, abm_empresa);
  Application.CreateForm(Thabiliar_empresa, habiliar_empresa);
  Application.CreateForm(Tcrear_plantilla, crear_plantilla);
  Application.CreateForm(Tver_turnos, ver_turnos);
  Application.CreateForm(Tgestion_de_turnos, gestion_de_turnos);
  Application.CreateForm(Tseleccione_fecha, seleccione_fecha);
  Application.CreateForm(Tbuscar_por_patente, buscar_por_patente);
  Application.CreateForm(Timprimir_turnos, imprimir_turnos);
  Application.CreateForm(Tmodulo, modulo);
  Application.CreateForm(Tmodificar_estado, modificar_estado);
  Application.CreateForm(Tseleccione_fecha_para_reporte, seleccione_fecha_para_reporte);
  Application.CreateForm(Tselecciona_plantilla, selecciona_plantilla);
  Application.CreateForm(Tver_plantillas, ver_plantillas);
  Application.CreateForm(Tmodificar_plantillas, modificar_plantillas);
  Application.CreateForm(Tcambiar_plantillas, cambiar_plantillas);
  Application.CreateForm(Tdetalle_de_turnos_por_centros, detalle_de_turnos_por_centros);
  Application.CreateForm(Tinforme_detalle_por_turnos_por_centro, informe_detalle_por_turnos_por_centro);
  Application.CreateForm(Tdetalle_cantidad_por_centro_por_fecha, detalle_cantidad_por_centro_por_fecha);
  Application.CreateForm(Timprime_detalle_cantidad_por_centro_por_fecha, imprime_detalle_cantidad_por_centro_por_fecha);
  Application.CreateForm(Tmensaje, mensaje);
  Application.CreateForm(Treporte_cantidad, reporte_cantidad);
  Application.CreateForm(Tborrar_turno, borrar_turno);
  Application.CreateForm(Tcambiar_centro, cambiar_centro);
  Application.CreateForm(Tingresar_por_codigo, ingresar_por_codigo);
  Application.CreateForm(Tseleccione_fecha_cantidad_turnos_globalizado, seleccione_fecha_cantidad_turnos_globalizado);
  Application.CreateForm(Tcantidad_turnos_globalizado, cantidad_turnos_globalizado);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(Tseleccione_fecha_turnos_por_plantilla, seleccione_fecha_turnos_por_plantilla);
  Application.CreateForm(Tprocesando_e, procesando_e);
  Application.CreateForm(Timprimie_asigandovsreservado, imprimie_asigandovsreservado);
  Application.CreateForm(Tseleccionefechayplanta, seleccionefechayplanta);
  Application.CreateForm(Texportat_datos_a_turnos, exportat_datos_a_turnos);
  Application.CreateForm(TMENSAJEEXPORTAWWEB, MENSAJEEXPORTAWWEB);
  Application.CreateForm(Treporte_mailing, reporte_mailing);
  Application.CreateForm(Tlo_que_tiene_que_venir, lo_que_tiene_que_venir);
  Application.Run;
end.
