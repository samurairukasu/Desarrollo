unit UCtCliente;

interface

uses
   SysUtils;


const
    FICHERO_ACTUAL = 'UCTCLIENTE.PAS';

    { CODIGO DE LOS ERRORES PRODUCIDOS AL IMPRIMIR }

    { INTERVALOS DE LOS DIFERENTES TESTS EN MILISEGUNDOS }
    //INTERVALO_COMPROBACION_ESTADO_HANDLE = 1000;
    //INTERVALO_CORTESIA_BORRADO = 500;

    INTERVALO_COMPROBACION_ESTADO_HANDLE = 100;
    INTERVALO_CORTESIA_BORRADO = 50;

    REGISTRO_BLOQUEADO = 'ORA-00054';


    { SIMPLES }
    CANCELADO_POR_CLIENTE = -1;
    NO_ERROR_CLIENTE_IMPRESION = 0;                              // No hay ningun error;
    ERROR_CLIENTE_IMPRESION_CREATE = 1;                          // Error creando el cliente de Impresion;
    ERROR_CLIENTE_IMPRESION_EXECUTING = 2;                       // Error ejecutando el cliente de Impresion;
    ERROR_CLIENTE_IMPRESION_FORMANDO_SOLICITUD = 3;              // Error formando la solicitud del cliente
    ERROR_CLIENTE_IMPRESION_ENVIANDO_SOLICITUD = 4;              // Error enviando la solicitud al servidor;
    ERROR_CLIENTE_IMPRESION_COMPROBANDO_ESTADO_SOLICITUD = 5;    // Error testeando el estado de la solicitud;
    ERROR_CLIENTE_IMPRESION_CANCELANDO_BORRADA = 6;              // Error intentando cancelar un trabajo ya borrado
    ERROR_CLIENTE_IMPRESION_BORRANDO = 7;                        // Error intentando borrar una solicitud;
    ERROR_CLIENTE_IMPRESION_PROBLEMAS_CON_BD = 8;                // Error por problemas con la BD;
    ERROR_CLIENTE_IMPRESION_PROBLEMAS_RAROS = 9;                 // Error raro, desconocido
    ERROR_CLIENTE_IMPRESION_ACTUALIZANDO = 10;                   // Error Actualizando

    { COMPUESTOS }
    ERROR_CLIENTE_IMPRESION_BORRANDO_BORRADA = 607;              // Error acumulado al cancelar y borrar;
    ERROR_CLIENTE_IMPRESION_BORRANDO_ERR_BD  = 807;              // Error acumulado al cancelar y borrar;
    ERROR_CLIENTE_IMPRESION_BORRANDO_RAROS   = 907;              // Error acumulado al cancelar y borrar;
    ERROR_CLIENTE_IMPRESION_BORRANDO_NO_ACTUALIZADO = 10007;     // Error acumulado al cancelar y no poder dejar con el mismo estado el trabajo { IMPRIMIENDOSE,

    { LITERALES DEVUELTOS CUANDO SE PRODUCE UN ERROR }

    LITERAL_NO_ERROR_CLIENTE_IMPRESION = '';
    LITERAL_ERROR_CLIENTE_IMPRESION_CREATE = 'ERROR AL INTENTAR CREAR EL CLIENTE DE IMPRESIÓN: ';
    LITERAL_ERROR_CLIENTE_IMPRESION_EXECUTING = 'ERROR EN EL TRANSCURSO DE LA EJECUCION DEL CLIENTE DE IMPRESIÓN: ';
    LITERAL_ERROR_CLIENTE_IMPRESION_FORMANDO_SOLICITUD = 'ERROR FORMANDO LA SOLICITUD DEL CLIENTE DE IMPRESIÓN: ';
    LITERAL_ERROR_CLIENTE_IMPRESION_ENVIANDO_SOLICITUD = 'ERROR ENVIANDO LA SOLICITUD DEL CLIENTE AL SERVIDOR DE IMPRESIÓN: ';
    LITERAL_ERROR_CLIENTE_IMPRESION_COMPROBANDO_ESTADO_SOLICITUD = 'ERROR COMPROBANDO EL ESTADO DE LA SOLICITUD DEL CLIENTE EN EL SERVIDOR: ';
    LITERAL_ERROR_CLIENTE_IMPRESION_BLOQUEANDO_SOLICITUD = 'ERROR BLOQUEANDO LA SOLICITUD DEL CLIENTE DE IMPRESION: ';
    LITERAL_ERROR_CLIENTE_IMPRESION_BORRANDO = ' ERROR BORRANDO LA SOLICITUD DEL CLIENTE DE IMPRESION EN EL SERVIDOR DE IMPRESION: ';
    LITERAL_ERROR_CLIENTE_IMPRESION_ACTUALIZANDO = 'ERROR ACTUALIZANDO EL ESTADO DE LA SOLICITUD DEL CLIENTE DE IMPRESION:';

    { LITERALES PARA LOS DISTINTOS TIPOS DE TRABAJOS }

    LITERAL_TRABAJO_ENVIADO_FACTURA_A   = 'La Factura de tipo A, ';
    LITERAL_TRABAJO_ENVIADO_NOTA_A      = 'La Nota de Crédito de tipo A, ';
    LITERAL_TRABAJO_ENVIADO_FACTURA_B   = 'La Factura de tipo B, ';
    LITERAL_TRABAJO_ENVIADO_NOTA_B      = 'La Nota de Crédito de tipo B, ';
    LITERAL_TRABAJO_ENVIADO_CERTIFICADO = 'El Certificado de la verificación, ';
    LITERAL_TRABAJO_ENVIADO_IMFORME     = 'El Informe de la verificación, ';
    LITERAL_TRABAJO_ENVIADO_NCDESCUENTO_A = 'La Nota Descuento de Tipo A ';  //
    LITERAL_TRABAJO_ENVIADO_NCDESCUENTO_B = 'La Nota Descuento de Tipo B ';
    LITERAL_TRABAJO_ENVIADO_MEDICION = 'El Informe de Mediciones ';    // MEDI
    LITERAL_TRABAJO_ENVIADO_TAMARILLA = 'La Tarjeta Amarilla ';
    LITERAL_TRABAJO_ENVIADO_INFORMEGNC = 'La Ficha Técnica ';


  { LITERALES PARA LOS DISTINTOS ESTADOS POR LOS QUE TRANSCURRE EL TRABAJO }

    LITERAL_ESTADO_DESCONOCIDO  = ' se está alterando desde el servidor.';
    LITERAL_ESPERANDO_ATENCION  = ' se está enviando al servidor de impresión.';
    LITERAL_DESAPARECIDO        = ' se canceló desde el servidor.';
    LITERAL_INTENTANDO_CANCELACION = ' Y se está intentando cancelar.';
    LITERAL_ESPERANDO_PAPEL = ' necesitó cambiar de papel.';
    LITERAL_PREPARADO = ' está lista para imprimirse.';
    LITERAL_IMPRIMIENDOSE = ' está imprimiéndose.';
    LITERAL_TERMINADO = '  ha terminado de imprimirse.';

  { LITERALES MONSTRADOS EN FORM DE DIALOGO AL USUARIO }
    LITERAL_NO_CANCELAR_BLOQUEADO = 'En este instante, no se puede cancelar el trabajo. El Servidor de Impresión está Ocupado. Espere unos segundos si quiere intentarlo de nuevo.';
    LITERAL_NO_CANCELAR_IMPRIMIENDOSE = 'En este instante, no se puede cancelar el trabajo. El trabajo se imprimió o se está imprimiendo.';
    LITERAL_CAMBIO_PAPEL_FACTURA_A = 'Asegurese, antes de continuar, de que el papel adecuado para imprimir FACTURAS de tipo A se encuentra en la bandeja de impresion';
    LITERAL_CAMBIO_PAPEL_NOTA_A = 'Asegurese, antes de continuar, de que el papel adecuado para imprimir NOTAS DE CREDITO de tipo A se encuentra en la bandeja de impresion';
    LITERAL_CAMBIO_PAPEL_FACTURA_B = 'Asegurese, antes de continuar, de que el papel adecuado para imprimir FACTURAS de tipo B se encuentra en la bandeja de impresion';
    LITERAL_CAMBIO_PAPEL_NOTA_B = 'Asegurese, antes de continuar, de que el papel adecuado para imprimir NOTAS DE CREDITO de tipo B se encuentra en la bandeja de impresion';
    LITERAL_CAMBIO_PAPEL_INFORME = 'Asegurese, antes de continuar, de que el papel adecuado para imprimir INFORMES se encuentra en la bandeja de impresion';
    LITERAL_CAMBIO_PAPEL_CERTIFICADO = 'Asegurese, antes de continuar, de que el papel adecuado para imprimir CERTIFICADOS se encuentra en la bandeja de impresion';
    LITERAL_CAMBIO_PAPEL_NCDESCUENTO_A = 'Asegurese, antes de continuar, de que el papel adecuado para imprimir NOTAS DE CREDITO de tipo A se encuentra en la bandeja de impresion';//
    LITERAL_CAMBIO_PAPEL_NCDESCUENTO_B = 'Asegurese, antes de continuar, de que el papel adecuado para imprimir NOTAS DE CREDITO de tipo B se encuentra en la bandeja de impresion';
    LITERAL_CAMBIO_PAPEL_MEDICION = 'Asegurese, antes de continuar, de que el papel adecuado para imprimir INFORMES DE MEDICION se encuentra en la bandeja de impresion';  // MEDI
    LITERAL_CAMBIO_PAPEL_TAMARILLA = 'Asegurese, antes de continuar, de que el papel adecuado para imprimir TARJETAS AMARILLAS se encuentra en la bandeja de impresion';
    LITERAL_CAMBIO_PAPEL_INFORMEGNC = 'Asegurese, antes de continuar, de que el papel adecuado para imprimir FICHAS TECNICAS se encuentra en la bandeja de impresion';
type
   { TIPOS USADOS POR LA UNIDAD CLIENTE, CLIENTE DE IMPRESION }

    tTrabajo = ( Nulo, Certificado , Informe, Factura_A, Factura_B, Nota_A, Nota_B, InformeDiferido, NCDescuento_A, NCDescuento_B, Medicion, TAmarilla, InformeGNC, Factura_A_GNC, Factura_B_GNC, Nota_A_GNC, Nota_B_GNC); 

    tCodErrorPrintig = -1..999;

    tEstadosCliente = ( CEsperando_x_Atencion {0}, CEsperando_x_Papel {1},
                        CEsperando_x_Terminar, {2} CFin_cn_Incidencias {n-1},
                        CFin_sn_Incidencias );
    tEstadosHandle =  ( HDesconocido {0}, HEsperando_xx_Atencion {1},
                        HEsperando_xx_Papel {2}, HPreparado {3},  HImprimiendose {4},
                        HTerminado {5}, HCancelado {6},
                        HDesaparecido {n-1}, HBloqueado {n} );


    tErrorPrinting = record
      iCodigoError : tCodErrorPrintig;
      sLiteralError : string;
    end;

    tCabecera = record
      iCodigoInspeccion : integer;
      iEjercicio : integer;
      sMatricula : string;
    end;

    tPeticionDeServicio = record
      dCabecera : tCabecera;
      iServicio : tTrabajo;
    end;

    tPaqueteDeSolicitud = record
      iHandle : integer;
      dPeticion : tPeticionDeServicio;
    end;

    EHandleIncorrecto = class(Exception);
    EBorradoElRegistro = class(Exception);
    EDuplicadoElRegistro = class(Exception);



implementation

end.
 
