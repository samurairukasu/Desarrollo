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
  UnitINGREAR_CODTURNO_MANUAL in 'UnitINGREAR_CODTURNO_MANUAL.pas' {INGREAR_CODTURNO_MANUAL},
  Unit1reimprimir_factura in 'Unit1reimprimir_factura.pas' {reimprimir_factura},
  Uvisorpdf in 'Uvisorpdf.pas' {visorpdf},
  UnitPISE_MOTIVO_CAMBIO_OBLEA in 'UnitPISE_MOTIVO_CAMBIO_OBLEA.pas' {PISE_MOTIVO_CAMBIO_OBLEA},
  Unitfrmregistrar_remitos_certificados in 'Unitfrmregistrar_remitos_certificados.pas' {frmregistrar_remitos_certificados},
  UnitfrmsMOTIVO_CANCELAMIENTO in 'UnitfrmsMOTIVO_CANCELAMIENTO.pas' {frmsMOTIVO_CANCELAMIENTO},
  Unitfrmver_remitos_certificados in 'Unitfrmver_remitos_certificados.pas' {frmver_remitos_certificados},
  UniREMITO_CERTIFICADOS in 'UniREMITO_CERTIFICADOS.pas' {REMITO_CERTIFICADOS},
  Unit_borrar_defecto_patente in 'Unit_borrar_defecto_patente.pas' {borrar_defecto_patente},
  Unitcambiartipoinspeccion in 'Unitcambiartipoinspeccion.pas' {cambiartipoinspeccion},
  Insertar_Localidad_CP in 'Insertar_Localidad_CP.pas' {UFInserta_Localidad_CP},
  Ufrminformacionpago in 'Ufrminformacionpago.pas' {frminformacionpago},
  Unitsolicitar_cabio_dominio_suvtv1 in 'Unitsolicitar_cabio_dominio_suvtv1.pas' {solicitar_cabio_dominio_suvtv},
  Unit1descargar_turno_suvtv in 'Unit1descargar_turno_suvtv.pas' {descargar_turno_suvtv},
  Hashes in '..\WS XML PAGOS\Hashes.pas',
  Ucambiodocumentotitular in 'Ucambiodocumentotitular.pas' {frmcambiotitular},
  UFSERVICIOSPRESTADOS in 'UFSERVICIOSPRESTADOS.pas' {FServiciosPrestados},
  UFLISTADOPAGOS_MP in 'UFLISTADOPAGOS_MP.pas' {PagosMP},
  UFLISTADOPAGOS_EP in 'UFLISTADOPAGOS_EP.pas' {PagosEP},
  GenerateResumenDiarioADM in 'GenerateResumenDiarioADM.pas',
  UFDIGITO_VERIFICADOR in 'UFDIGITO_VERIFICADOR.pas' {FDigito_Verificador};

// Unitimprimir_listadoturnos in 'Unitimprimir_listadoturnos.pas' {imprimirlistadoturnos};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Sag. X3 (Estaciones) Ver 1.0.0';
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
  Application.CreateForm(Tseleccione__fecha_turnos, seleccione__fecha_turnos);
  Application.CreateForm(Tingresar_patente, ingresar_patente);
  Application.CreateForm(Tdetalleturno, detalleturno);
  Application.CreateForm(Tprocesando, procesando);
  Application.CreateForm(Tmensajews, mensajews);
  Application.CreateForm(Tfrmturnos, frmturnos);
  Application.CreateForm(TMENSAJEIMPRESION, MENSAJEIMPRESION);
  Application.CreateForm(Tmensajerevews, mensajerevews);
  Application.CreateForm(TCONTROLSERVICIO_SVVTV, CONTROLSERVICIO_SVVTV);
  Application.CreateForm(Tcambiodominioturno, cambiodominioturno);
  Application.CreateForm(TINGREAR_CODTURNO_MANUAL, INGREAR_CODTURNO_MANUAL);
  Application.CreateForm(Treimprimir_factura, reimprimir_factura);
  Application.CreateForm(Tvisorpdf, visorpdf);
  Application.CreateForm(TPISE_MOTIVO_CAMBIO_OBLEA, PISE_MOTIVO_CAMBIO_OBLEA);
  Application.CreateForm(Tcambiartipoinspeccion, cambiartipoinspeccion);
  Application.CreateForm(TUFInserta_Localidad_CP, UFInserta_Localidad_CP);
  Application.CreateForm(Tsolicitar_cabio_dominio_suvtv, solicitar_cabio_dominio_suvtv);
  Application.CreateForm(Tdescargar_turno_suvtv, descargar_turno_suvtv);
  Application.Run;
end.
