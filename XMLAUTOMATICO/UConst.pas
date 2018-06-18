unit UConst;

interface

  const

  { CONSTANTES DE CODIGOS Y LITERALES ACERCA DE LAS LOCALIZACIONES DE ERRORES
  LEIDOS DEL FICHERO DE LECTURA DE MAHA, UTILIZADAS POR EL SERVIDOR DE LECTURA }

   INICIO_REVISIONES_CON_D1 =  1;
   FINAL_REVISIONES_CON_D1 = 20;

   INICIO_REVISIONES_CON_D2 = 21;
   FINAL_REVISIONES_CON_D2 = 22;

   INICIO_REVISIONES_CON_D3 = 23;
   FINAL_REVISIONES_CON_D3 = 23;



  { CONTROL SOBRE EL FICHERO QUE SE LEE DE MAHA }

    CAMPOS_VISUALES = 7; {0..7}

    PRIMER_CODIGO_OUT_HEAD = 1;
    ULTIMO_CODIGO_OUT_HEAD = 8;

    PRIMER_CODIGO_OUT_DATA = 1;
    ULTIMO_CODIGO_OUT_DATA = 75;

    TCODIGOS_OUT_DATA : array [1..75] of string =
    (
     '30000', '30001', '30002', '30003',
     '50100', '50101',
     '51100', '51101',
     '52100', '52101',
     '53100', '53101',
     '50250', '50251',
     '51250', '51251',
     {'59250' pasa a ser el 16-1-97 a} '59260',
     '50000', '50001',
     '51000', '51001',
     '52000', '52001',
     '53000', '53001',
     {'59000' pasa a ser el 16-1-97 a} '59010',
     '50050', '50051',
     '51050', '51051',
     '52050', '52051',
     '53050', '53051',
     '50010',
     '51010',
     '52010',
     '53010',
     '50020', '50021',
     '51020', '51021',
     '52020', '52021',
     '53020', '53021',
     '50030', '50031',
     '51030', '51031',
     '52030', '52031',
     '53030', '53031',
     '31000', '31001',
     '31100', '31101',
     '31002',
     '31102',
     '31010', '31011',
     '31110', '31111',
     '39000', '39001', '39002', '39003',
     '38000',
     '15010', '15011',
     '15110', '15111',
     '15210', '15211');

     { ACERCA DE LA HORA DE ENTRADA EN LAS ZONAS, LEIDAS DE ES_OUT }

     ANIO_O = 367;

     PRIMERA_ZONA = 1;
     ULTIMA_ZONA = 3;

     HORAS_ENTRADA_ZONA : array [PRIMERA_ZONA..ULTIMA_ZONA] of string = ('15000', '15100', '15200');
     HORAS_SALIDA_ZONA : array [PRIMERA_ZONA..ULTIMA_ZONA] of string = ('15001', '15101', '15201');

     HORAS_INICIO_ZONA : array [PRIMERA_ZONA..ULTIMA_ZONA] of tDateTime = (ANIO_O, ANIO_O, ANIO_O);
     HORAS_FINAL_ZONA  :  array [PRIMERA_ZONA..ULTIMA_ZONA] of tDateTime = (ANIO_O, ANIO_O, ANIO_O);

     PARAMETROS_ENTRADA_ZONA : array [PRIMERA_ZONA..ULTIMA_ZONA] of string = ( 'HoraEntrada_Z1', 'HoraEntrada_Z2', 'HoraEntrada_Z3');
     PARAMETROS_SALIDA_ZONA : array [PRIMERA_ZONA..ULTIMA_ZONA] of string = ( 'HoraSalida_Z1', 'HoraSalida_Z2', 'HoraSalida_Z3');

    { ACERCA DE LA REVISION }
    PRIMER_CAMPO_REVISION = 1;
    ULTIMO_CAMPO_REVISION = 23;

    PARAMETROS_DE_VERIFICACION : array [PRIMER_CAMPO_REVISION..ULTIMO_CAMPO_REVISION] of integer =
    (  2,  3,  4,  5, 18, 27, 36, 37, 38, 39, 60, 61, 56, 57, 58, 59, 56, 57, 58, 59, 66, 67, 70 );

    PARAMETROS_DE_COMPROBACION : array [PRIMER_CAMPO_REVISION..ULTIMO_CAMPO_REVISION] of integer =
    ( 10, 13, 13, 13, 16, 19, 22, 25, 25, 25, 28, 28, 31, 31, 31, 31, 34, 34, 34, 34, 37, 40, 43 );


    NOMBRE_CAMPOS_DE_REVISION : array [PRIMER_CAMPO_REVISION..ULTIMO_CAMPO_REVISION] of string =
    ( '03.10.050',
      '03.10.051', '03.10.051', '03.10.051',
      '04.03.050',
      '04.04.050',
      '04.05.050',
      '04.06.050', '04.06.050', '04.06.050',
      '05.01.050',
      '05.01.051',
      '05.01.052', '05.01.052',
      '05.01.053', '05.01.053',
      '05.01.054', '05.01.054',
      '05.01.055', '05.01.055',
      '10.01.050',
      '10.01.051',
      '10.02.050' );



  {    '30000 Deslizamiento excesivo 1er eje',
      '30001 Deslizamiento excesivo  2o eje',
      '30002 Deslizamiento excesivo 3er eje',
      '30003 Deslizamiento excesivo  4o eje',

      '59250 Eficacia freno de estacionamiento insuficiente',

      '59000 Eficacia freno de servicio insuficiente',

      '50010 Desequilibrio excesivo de frenos 1er eje',
      '51010 Desequilibrio excesivo de frenos  2o eje',
      '52010 Desequilibrio excesivo de frenos 3er eje',
      '53010 Desequilibrio excesivo de frenos  4o eje',

      '31002 Desequilibrio entre amortiguadores 1er eje',
      '31102 Desequilibrio entre amortiguadores  2o eje',

      '31000 Falta de Eficacia en amortiguador rueda izq y 1er eje',
      '31001 Falta de Eficacia en amortiguador rueda der y 1er eje',

      '31100 Falta de Eficacia en amortiguador rueda izq y  2o eje',
      '31101 Falta de Eficacia en amortiguador rueda der y  2o eje',

      '31000 Amortiguador Agarrotado rueda izq y 1er eje',
      '31001 Amortiguador Agarrotado rueda der y 1er eje',

      '31100 Amortiguador Agarrotado rueda izq y  2o eje',
      '31101 Amortiguador Agarrotado rueda der y  2o eje',

      '39000 Nivel de Contaminacion excesivo CO',
      '39001 Nivel de Contaminacion excesio HC',
      '38000 Nivel de Contaminacion excesivo de Humos'); }


      { CONSTANTES PARA EL PASO DE LAS REVISIONES }
       OKEY = 0;
       OBS= 1;
       DL = 2;
       DG = 3;
       IMP = 4;

  { CODIGOS DE LOCALIZACIONES FAX 27-08-96}
    SUP_IZQ = 10;
    SUP_CEN = 11;
    SUP_DER = 12;
    CEN_IZQ = 13;
        CEN = 14;
    CEN_DER = 15;
    INF_IZQ = 16;
    INF_CEN = 17;
    INF_DER = 18;

 { LITERALES DE LOCALIZACIONES FAX 27-08-96}
    EJES_1_3 = ' EN EL %der EJE';
    EJES_OTROS = ' EN EL %dº EJE';
    SUPERIOR_IZQUIERDA = ' EN PARTE DELANTERA IZQUIERDA';
    SUPERIOR_DERECHA = ' EN PARTE DELANTERA DERECHA';
    SUPERIOR_CENTRAL = ' EN PARTE DELANTERA CENTRAL';
    CENTRAL = ' EN PARTE CENTRAL MEDIA';
    CENTRAL_IZQUIERDA = ' EN PARTE CENTRAL IZQUIERDA';
    CENTRAL_DERECHA = ' EN PARTE CENTRAL DERECHA';
    INFERIOR_IZQUIERDA = ' EN PARTE TRASERA IZQUIERDA';
    INFERIOR_DERECHA = ' EN PARTE TRASERA DERECHA';
    INFERIOR_CENTRAL = ' EN PARTE TRASERA CENTRAL';
    PARTE_COMODIN = '';

  { CODIGOS DE ERROR POSIBLES CUANDO SE LEE EL FICHERO INI DE MAHA }
    NO_HAY_ERROR = 0;
    ERR_FICHERO_INI_NO_COMPLETO = 1;
    ERR_FICHERO_INI_NOMBRE_MATRICULA_DISTINTO = 2;
    ERR_FICHERO_INI_CODIGOS_ERRONEOS = 3;
    ERR_TINSPECCION_NO_ACTUALIZADA = 4;
    ERR_REGISTRO_DATOSINSPECCION_NO_INSERTADO = 5;
    ERR_REGISTRO_DATOSINSPECCION_VISUAL_NO_INSERTADO = 7;
    ERR_TESTADOINSP_NO_ACTUALIZADO = 8;

{
  ***************************************************************************
  ***************************************************************************
  ***************************************************************************
  ***************************************************************************
}

  VERSION_ENTREGA = 1.39;
  // version 1.32, con los parametros correcto en las dependencias
  //  VERSION_LECTOR = ' (v.1.17)';
  FECHA_VERSION =  ' 10/10/97';

  DIRECTORIO_TRAZAS = 'logs\Lector';

  NOMBRE_FICHERO_TRAZAS =   'Trazas.txt';
  NOMBRE_FICHERO_ANOMALIAS =  'Anomalias.txt';
  NOMBRE_FICHERO_INCIDENCIAS =  'Incidencias.txt';

  NOMBRE_FICHERO_INICIALIZACION = 'SerVTV.ini'; // Fichero de inicializacion en el directorio c:\windows por defecto

  //  MODIF RAN
  //  Constantes para Mensajes de Error del Status del Controlador e Impresora

  TMENS_STATUS_FISCAL : array [0..15] of string =
  (
   'Error de comprobación de Memoria Fiscal',
   'Error de comprobación de Memoria de Trabajo',
   'Poca Batería',
   'Comando no reconocido',
   'Campo de datos inválido',
   'Comando no válido para estado fiscal',
   'Desbordamiento de totales',
   'Memoria Fiscal llena',
   'Memoria Fiscal casi llena',
   'Impresor fiscal Certificado',
   'Impresor fiscal Fiscalizado',
   'Es necesario un cierre de Jornada (Cierre Z)',
   'Documento Fiscal abierto',
   'Documento abierto',
   'Factura inicializada',
   'ERROR');


  TMENS_STATUS_IMPRE : array [0..15] of string =
  (
   #127,
   #127,
   'Error/Falla de impresora',
   'Impresora fuera de línea',
   '',
   'Poco papel para comprobantes o tickets.  Para continuar cambie el rollo.',
   'Buffer de impresora lleno',
   'Buffer de impresora vacío',
   'Toma de hojas sueltas frontal preparada',
   'Hoja suelta frontal preparada',
   'Toma de hojas para validación preparada',
   'Papel de validación presente',
   'Cajón de dinero uno ó dos abierto',
   #127,
   'Impresora sin papel',
   '');




implementation

end.
