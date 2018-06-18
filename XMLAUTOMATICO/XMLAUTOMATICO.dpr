program XMLAUTOMATICO;

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
  URucara in 'URucara.pas',
  Unconsultaws in 'ws\Unconsultaws.pas' {gestionws},
  Unseleccione__fecha_turnos in 'ws\Unseleccione__fecha_turnos.pas' {seleccione__fecha_turnos},
  Uniingresar_patente in 'ws\Uniingresar_patente.pas' {ingresar_patente},
  Undetalleturno in 'ws\Undetalleturno.pas' {detalleturno},
  s_0011 in 'ws\s_0011.pas',
  class_impresion in 'class_impresion.pas',
  Unprocesando in 'ws\Unprocesando.pas' {procesando},
  ufrmscanearnrooblea in 'scanner\ufrmscanearnrooblea.pas' {frmscanearnrooblea},
  UFRMSCANEOCERTIFICADO in 'scanner\UFRMSCANEOCERTIFICADO.pas' {FRMSCANEOCERTIFICADO},
  UConst in 'UConst.pas',
  UVERSION in 'UVERSION.pas',
  ULogs in 'ULogs.pas',
  UcertificadoCABA in 'UcertificadoCABA.pas' {CERTIFICADOCABA},
  Ufrmturnos in 'Ufrmturnos.pas' {frmturnos},
  Umensajews in 'Umensajews.pas' {mensajews},
  Ufrconfiguracion_impresoras in 'Ufrconfiguracion_impresoras.pas' {frconfiguracion_impresoras},
  Uuingresapatentecabacert in 'Uuingresapatentecabacert.pas' {uingresapatentecabacert},
  fureimprimecertcaba in 'fureimprimecertcaba.pas' {ureimprimecertcaba},
  UMENSAJEIMPRESION in 'UMENSAJEIMPRESION.pas' {MENSAJEIMPRESION},
  WSFEV1 in '..\FAE\WSFEV1.pas',
  UGENERA_NC_ELECTRONICA in 'UGENERA_NC_ELECTRONICA.pas' {GENERA_NC_ELECTRONICA},
  Exportar2PDF in '..\NUEVO TURNOS CABA\SynPDF\Exportar2PDF.pas',
  mORMotReport in '..\NUEVO TURNOS CABA\SynPDF\mORMotReport.pas',
  SynCommons in '..\NUEVO TURNOS CABA\SynPDF\SynCommons.pas',
  SynCrypto in '..\NUEVO TURNOS CABA\SynPDF\SynCrypto.pas',
  SynGdiPlus in '..\NUEVO TURNOS CABA\SynPDF\SynGdiPlus.pas',
  SynLZ in '..\NUEVO TURNOS CABA\SynPDF\SynLZ.pas',
  SynPdf in '..\NUEVO TURNOS CABA\SynPDF\SynPdf.pas',
  SynZip in '..\NUEVO TURNOS CABA\SynPDF\SynZip.pas',
  Unitmensaje in 'Unitmensaje.pas' {mensajerevews},
  UniCONTROLSERVICIO_SVVTV in 'UniCONTROLSERVICIO_SVVTV.pas' {CONTROLSERVICIO_SVVTV},
  Unicambiodominioturno in 'Unicambiodominioturno.pas' {cambiodominioturno},
  Unitporpatnete in '..\SAGVTV 1.3.3\Unitporpatnete.pas' {descargar_por_patente},
  UniPORIDTURNO in 'UniPORIDTURNO.pas' {informarporturnoid},
  UnitINFORMAR_INSPE_POR_ID in 'UnitINFORMAR_INSPE_POR_ID.pas' {INFORMAR_INSPE_POR_ID},
  UPIDE_TURNO_AUSENTE in '..\SAGVTV 1.3.3\UPIDE_TURNO_AUSENTE.pas' {PIDE_TURNO_AUSENTE},
  Unitinformar_por_fcha1 in 'Unitinformar_por_fcha1.pas' {informar_por_fcha};

// Unitimprimir_listadoturnos in 'Unitimprimir_listadoturnos.pas' {imprimirlistadoturnos};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Sag. X3 (Estaciones) Ver 1.0.0';
  Application.CreateForm(TFMainSag98, FMainSag98);
  Application.CreateForm(Tfrmturnos, frmturnos);
  Application.CreateForm(Tnueva_alerta, nueva_alerta);
  Application.CreateForm(Tsincronizacion_cf, sincronizacion_cf);
  Application.CreateForm(Tcambiar_calificacion_defectos_solo_reve, cambiar_calificacion_defectos_solo_reve);
  Application.CreateForm(Tfin, fin);
  Application.CreateForm(Tfrmconveniorucara, frmconveniorucara);
  Application.CreateForm(Tfrmodificar_oblea_rucara_inspeccionunit, frmodificar_oblea_rucara_inspeccionunit);
  Application.CreateForm(Tmodificar_nro_oblea_rucara, modificar_nro_oblea_rucara);
  Application.CreateForm(Tfrmodificar_oblea_en_tvarios, frmodificar_oblea_en_tvarios);
  Application.CreateForm(Tpide_fecha, pide_fecha);
  Application.CreateForm(Tseleccione__fecha_turnos, seleccione__fecha_turnos);
  Application.CreateForm(Tingresar_patente, ingresar_patente);
  Application.CreateForm(Tdetalleturno, detalleturno);
  Application.CreateForm(Tprocesando, procesando);
  Application.CreateForm(Tmensajews, mensajews);
  Application.CreateForm(TMENSAJEIMPRESION, MENSAJEIMPRESION);
  Application.CreateForm(Tmensajerevews, mensajerevews);
  Application.CreateForm(TCONTROLSERVICIO_SVVTV, CONTROLSERVICIO_SVVTV);
  Application.CreateForm(Tcambiodominioturno, cambiodominioturno);
  Application.CreateForm(Tdescargar_por_patente, descargar_por_patente);
  Application.CreateForm(Tinformarporturnoid, informarporturnoid);
  Application.CreateForm(TINFORMAR_INSPE_POR_ID, INFORMAR_INSPE_POR_ID);
  Application.CreateForm(TPIDE_TURNO_AUSENTE, PIDE_TURNO_AUSENTE);
  Application.CreateForm(Tinformar_por_fcha, informar_por_fcha);
  Application.Run;
end.
