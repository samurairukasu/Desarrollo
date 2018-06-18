unit UMensCts;
{ Aquí se incluyen las constantes que se dan al usuario }

interface
   const

  { Captions de mensajes }
    ERROR_SISTEMA = 'Error del sistema';


      { Literales de Error obtenidos por el servidor de Impresion }
      LITERAL_ERROR_SERVIDOR_IMPRESION_OBTENIENDO_PRIMERO_COLA = 'Error al buscar la primera peticion de la cola. Contacte con su Administrador. ';
      LITERAL_ERROR_SERVIDOR_IMPRESION_TRABAJOS_EN_COLA = 'Error contado los trabajos pendientes en las colas de impresion. Contacte con su Administrador. ';
      LITERAL_ERROR_SERVIDOR_IMPRESION_TRABAJO_BORRADO = 'Atención un cliente ha cancelado una solicitud de impresion. ';
      LITERAL_ERROR_SERVIDOR_IMPRESION_TRABAJO_MODIFICADO = 'Atención un cliente está modificando o ha modificado, el estado de una solicitud. ';
      LITERAL_ERROR_SERVIDOR_IMPRESION_ERROR_BD = 'Atencion se ha perdido comunicacion con la BASE DE DATOS';
      LITERAL_ERROR_SERVIDOR_IMPRESION_ERROR_GENERAL = 'Error se grave, Fallo del Sistema, contacte con su administrador';
      LITERAL_ERROR_SERVIDOR_IMPRESION_SOLICITUD_BORRADA = 'Atencion la solicitud si no termino de imprimirse ha sido cancelada por el cliente.';
      LITERAL_ERROR_SERVIDOR_IMPRESION_SOLICITUD_BLOQUEADA = 'El servidor esta Ocupado, intente de nuevo la cancelacion en unos segundos';
      LITERAL_ERROR_SERVIDOR_IMPRESION_PROBLEMAS_BD = 'Se han detectado problemas en la comunicacion con la Base De Datos, contacte con su Administrador';
      LITERAL_ERROR_SERVIDOR_IMPRESION_PROBLEMAS_RAROS = 'Se han dtedtado problemas, desconociéndose la causa, contancte con su Administrador';
      LITERAL_ERROR_SERVIDOR_IMPRESION_OBTENIENDO_PRIMERO_PREPARADO = 'Error al buscar la primera solicitud preparada de la cola. Contacte con su Administrador. ';
      LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE = 'Error, no se ha completado con exito la tarea de impresión asociada al trabajo : ';
      LITERAL_MENSAJE_ANULACION =  'Por favor, antes de anular un trabajo pare el servidor de Impresión. ';
      LITERAL_MENSAJE_CONFIGURACION = 'Por favor, antes de configurar las impresoras pare el servidor de Impresión. ';
      LITERAL_MENSAJE_CAMBIO_NUMERO = 'Por favor, antes de modificar los números de facturas o notas de credito, pare el servidor de Imresión. ';
      LITERAL_ERROR_ACTUALIZANDO_NUMEROS = 'La actualización no se ha llevado a cabo. Intentelo de nuevo más tarde y si el error persiste contacte con su distribuidor';

      LITERAL_ERROR_USUARIO_CAMBIA_IMPRESORAS =
         'El Servidor de Impresión ha detectado un cambio en la configuración de su sistema. Compruebe si la configuración elegida para sus impresiones sigue siendo la correcta.';

      LITERAL_ERROR_USUARIO_CAMBIA_IMPRESORAS_ =
         'El Servidor de Impresión ha detectado un cambio en la configuración de su sistema. Para poder continuar debe "Aceptar" una combinación válida.';

      LITERAL_ERROR_ENTRADA_SALIDA = 'Ocurriro un error al intentar guardar en disco la configuración elegida';
      LITERAL_CONJUNTO_IMPRESORAS_NO_VALIDO = 'El conjunto de impresoras que escogió no es valido. Realice el test para averigüar las impresoras que están disponibles';
      LITERAL_CONJUNTO_IMPRESORAS_NO_DISPONIBLE = 'Existen impresoras no disponibles en el conjunto que escogió. Realice el test para averigüar las impresoras que están disponibles';

 { Mensajes enviados por la unidad Logs }
  MSJ_NO_CREADOS_LOGS = 'Se ha producido un error grave: EL SISTEMA NO RESPONDE Y NO SE PUEDEN ABRIR LOS ARCHIVOS NECESARIOS. Reinicie el programa y si el error persiste contacte con su distribuidor';
  MSJ_NO_SE_PUEDE_INICIAR_EL_SERVIDOR = 'Se ha producido un error grave: El sistema no responde y se detendrá. COPRUEBE SI TIENE IMPRESORAS INSTALADAS.'; 
implementation

end.
