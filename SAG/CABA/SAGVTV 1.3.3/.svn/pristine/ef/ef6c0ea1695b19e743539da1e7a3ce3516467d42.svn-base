unit USAGESTACION;

interface

    uses
        Graphics,
        USAGDATA;
    var
        BaudRate,PortNumber: string;

    const

        G_ = #71;
        N_ = #78;
        R_ = #82;
        B_ = #66;
        D_ = #68;
        M_ = #77;

        //Tipos de Obela
        DISPONIBLE = 'S';
        CONSUMIDA = 'C';
        CONSUMIDA_K = 'K';
        TOMADA = 'T';
        ANULADA = 'A';
        INUTILIZADA = 'I';

        // VALORES DE INTERNOS DE COLUMNAS


        // Tipos de Iva (Tributacion)
        IVA_INSCRIPTO    = 'I';
        IVA_NO_INSCRIPTO = 'N';
        IVA_EXENTO       = 'E';
        IVA_CONSUM_FINAL = 'C';
        //MODIFICACION RAN
        IVA_NO_RESPONSABLE = 'R';
        IVA_MONOTRIBUTO    = 'M';

        // Formas de Pago
        FORMA_PAGO_METALICO = 'M';
        FORMA_PAGO_CREDITO  = 'C';
        FORMA_PAGO_TARJETA  = 'T';   //
        FORMA_PAGO_CHEQUE   = 'H';
        SIN_DATOS_CLIENTE   = 'S';

        // Tipos de factura
        FACTURA_NO_IMPRESA = 'N';
        FACTURA_IMPRESA    = 'S';
        FACTURA_REIMPRESA  = 'R';
        FACTURA_TIPO_A     = 'A';
        FACTURA_TIPO_B     = 'B';
        FACTURA_ERRONEA    = 'S';
        FACTURA_NO_ERRONEA = 'N';
        FACTURA_TIPO_C     = 'C';
        FACTURA_NO_FISCAL  = 'N';


        { ESTADO DE LA TABLA TESTADOINSP }
        E_FACTURADO = 'A';
        E_VERIFICANDOSE = 'B';
        E_RECIBIDO_OK = 'C';
        E_RECIBIDO_NOK = 'D';
        E_ANULADO = 'E';
        E_FINALIZADO = 'F';
        E_STANDBY = 'G';
        E_PENDIENTE_FACTURAR = 'H';
        E_PENDIENTE_SIC = 'I';
        E_MODIFICADO = 'J';

        {Tipos de Inspecciones }
        T_NORMAL = 'A';
        T_PREVERIFICACION = 'B';
        T_GRATUITA = 'C';
        T_VOLUNTARIA = 'D';
        T_REVERIFICACION = 'E';
        T_STANDBY = 'F';
        T_PREVERIFICACIONOk = 'G';
        T_MANTENIMIENTO = 'H';
        T_VOLUNTARIAREVERIFICACION = 'I';
        T_GNCRPA = 'J';
        T_GNCRC = 'K';
        T_GNCRPAOK = 'L';


        C_NORMAL = 'Periódica';
        C_PREVERIFICACION = 'Preverificación';
        C_REVERIFICACION = 'Reverificación';
        C_GRATUITA = 'Gratuita';
        C_PREVERIFICACIONOk = 'Prev. Facturada';
        C_MANTENIMIENTO = 'Mantenimiento';
        C_STANDBY = 'Ins. Stand-By';
        C_VOLUNTARIA = 'Voluntaria';
        C_VOLUNTARIAREVERIFICACION = 'Rev. Voluntaria';
        C_GNCRPA = 'Verificación GNC - RPA';
        C_GNCRC = 'Verificación GNC - RC';
        C_GNCRPAOK = 'Verificación GNC-RPA OK';
        C_REVERIFICACION_EXT = 'Reve. Externa';
        C_EXTERNA = 'Otra Planta';

        INTERVALO_DIAS_PERIODO = 60; { Si el resultado de una inspección NO es APTO,
        es el nº de días máximos que deben transcurrir para volver a pasar la
        próxima verificación del vehículo }

        INTERVALO_DIEZ_DIAS_PERIODO = 10; { Si el resultado de una inspección NO es APTO,
        es el nº de días máximos que deben transcurrir para volver a pasar la
        próxima verificación del vehículo, en Transporte Publico > 10 años }


        INTERVALO_DIAS_PREVERIFICACION = 30;
        DIAS_VALIDO_COMBO = 90;

        { Valores que puede tomar una inspección }
        INSPECCION_APTA = 'A';
        INSPECCION_CONDICIONAL = 'C';
        INSPECCION_RECHAZADO = 'R';
        INSPECCION_BAJA = 'B';
        INSPECCION_FINALIZADA = 'S';
        INSPECCION_FUE_PREVERIFICACION = 'S';
        INSPECCION_NO_FINALIZADA = 'N';


        (* Valores para los campos del Pto de Venta *)      //

        TIPO_CF      = 'C';
        TIPO_MANUAL  = 'M';
        VIGENTE      = 'S';
        NO_VIGENTE   = 'N';

        // VALORES PARA LOS CONTROLADORES FISCALES          //

        TIQUEFACTURA    = 'T';
        SLIP            = 'S';
        BIENUSO_NO      = 'N';
        FARMACIA_NO     = 'C';
        SUMA_ITEM       = 'M';
        ANULA_ITEM      = 'm';
        BONIFICACION    = 'R';
        ANULA_BONIFICA  = 'r';
        INF_NUMERADORES = 'A';
        INF_CONTRIBUYENTE = 'C';
        INF_ENCURSO     = 'D';
        INF_IMPRESOR    = 'P';
        INF_NORMAL      = 'N';
        TIPO_FACTURA    = 'F';
        TIPO_FACTURAGNC = 'G';
        TIPO_NC         = 'N';
        TIPO_DNF        = 'D';
        TIPO_NCD        = 'D';
        TIPO_NCGNC      = 'C';
        LINEA_DNF       = '----------------------------------------';
        ENCA_FANTASIA   = '1';
        ENCA_RSOCIAL    = '2';
        ENCA_L3         = '4';
        ENCA_L4         = '5';
        ENCA_L5         = '6';
        ENCA_L6         = '7';
        ENCA_L7         = '8';
        ENCA_L8         = '9';
        ENCA_L9         = '10';
        ENCA_IB_1       = '57';
        ENCA_DOMIC_1    = '50';
        ENCA_DOMIC_2    = '51';
        ENCA_DOMIC_3    = '52';
        ENCA_TELEFONO   = '53';
        ENCA_FECINI     = '62';
        COLA_FORPAGO_1  = '11';
        COLA_FORPAGO_2  = '12';
        COLA_CAJERO_1   = '13';
        COLA_FORPAGO_3  = '14';

        CABECERA_63     = '63';
        CABECERA_64     = '64';
        CABECERA_65     = '65';

        cVACIO =' ';
        cLEY_13987_1    = '  ORIENTACION AL CONSUMIDOR PROVINCIA';
        cLEY_13987_2    = '     DE BUENOS AIRES 0800-222-9042';

        TIPO_DOC_CUIT   = 'CUIT';

        //Tipo de creación de formularios GNC
        TIPO_EDIT       = 'E';
        TIPO_NEW        = 'N';

        TIPO_VTV        = 'V';
        TIPO_GNC        = 'G';


        // Para registrar usuarios publicos
        TIPO_USUARIO_PUBLICO = 7;
        TIPO_USUARIO_PUBLICO_VIG= 13;
        DESCUENTO_USUARIO_PUBLICO = '47' ;
        DESCUENTO_ACA_VTV = '4' ;        

        //Declaraciones Juradas, indica si se debe guardar o es una reimpresion
        DJ_NUEVA = 'N';
        DJ_REIMPRESION = 'R';

        //Tipo de Reimpresion
        REIMP_DEC_JURADAS = 'D';
        REIMP_REEMP_OBLEAS = 'O';

         //Tipos de Clientes
        TIPO_CLIENTE_NORM_MOTO_VIG = '14';
        TIPO_CLIENTE_NORMAL        = '1';
        TIPO_CLIENTE_NORMAL_VIG    = '10';
        TIPO_CLIENTE_MAY20         = '11';
        TIPO_CLIENTE_TPP           = '12';
        TIPO_CLIENTE_MUNICIPAL     = '4';
        TIPO_CLIENTE_BOMBERO       = '6';
        TIPO_CLIENTE_DISCAPACITADO = '5';


        // NOMBRES DE COLUMNAS DE TABLAS DEL SISTEMA
        FIELD_FINALIZADA = 'FINALIZADA';
        FIELD_NOMBRE_Y_APELLIDOS = 'NombreYApellidos';
        FIELD_TIPODOCU = 'TIPODOCU';
        FIELD_DIRECCIO = 'DIRECCIO';
        FIELD_CODPARTI = 'CODPARTI';
        FIELD_CODPOSTA = 'CODPOSTA';
        FIELD_LOCALIDA = 'LOCALIDA';
        FIELD_CUIT_CLI = 'CUIT_CLI';
        FIELD_DOCUMENT = 'DOCUMENT';
        FIELD_ZONA     = 'ZONA';
        FIELD_ESTACION = 'ESTACION';
        FIELD_NCERTGNC = 'NCERTGNC';
        FIELD_ANIOFABR = 'ANIOFABR';
        FIELD_EJERCICI = 'EJERCICI';
        FIELD_CODINSPE = 'CODINSPE';
        FIELD_TIPO     = 'TIPO';
        FIELD_OFICIAL = 'OFICIAL';
        FIELD_PATENTEN = 'PATENTEN';
        FIELD_PATENTEA = 'PATENTEA';
        FIELD_NUMBASTI = 'NUMBASTI';
        FIELD_TIPOMOTORDIESEL = 'TIPOMOTORDIESEL';
        FIELD_NUMMOTOR = 'NUMMOTOR';
        FIELD_FECVENCI = 'FECVENCI';
        FIELD_ABRCLASI = 'ABRCLASI';
        FIELD_CODFRECU = 'CODFRECU';
        FIELD_TIPOESPE = 'TIPOESPE';
        FIELD_TIPODEST = 'TIPODEST';
        FIELD_CODMARCA = 'CODMARCA';
        FIELD_CODMODEL = 'CODMODEL';
        FIELD_RESULTAD = 'RESULTAD';
        FIELD_NOMTIPVE = 'NOMTIPVE';
        FIELD_NOMMARCA = 'NOMMARCA';
        FIELD_NOMMODEL = 'NOMMODEL';
        FIELD_TIPOVEHI = 'TIPOVEHI';
        FIELD_FECHALTA = 'FECHALTA';
        FIELD_HORFINAL = 'HORFINAL';
        FIELD_HORFINA = 'HORAFINA';
        FIELD_HORENTZ1 = 'HORENTZ1';
        FIELD_HORENTZ2 = 'HORENTZ2';
        FIELD_HORENTZ3 = 'HORENTZ3';
        FIELD_HORSALZ1 = 'HORSALZ1';
        FIELD_HORSALZ2 = 'HORSALZ2';
        FIELD_HORSALZ3 = 'HORSALZ3';
        FIELD_ID_GRUPO = 'ID_GRUPO';
        FIELD_DES_GRUPO = 'DES_GRUPO';
        FIELD_IDENCONC = 'IDENCONC';
        FIELD_NOMRESPO = 'NOMRESPO';
        FIELD_NUMREVZ1 = 'NUMREVZ1';
        FIELD_NUMREVZ2 = 'NUMREVZ2';
        FIELD_NUMREVZ3 = 'NUMREVZ3';
        FIELD_NUMLINZ1 = 'NUMLINZ1';
        FIELD_NUMLINZ2 = 'NUMLINZ2';
        FIELD_NUMLINZ3 = 'NUMLINZ3';
        FIELD_MATRICUL = 'MATRICUL';
        FIELD_NUMEJES  = 'NUMEJES';
        FIELD_FECMATRI = 'FECMATRI';
        FIELD_ERROR    = 'ERROR';
        FIELD_TIPOGAS  = 'TIPOGAS';
        FIELD_TIPFACTU = 'TIPFACTU';
        FIELD_TIPTRIBU = 'TIPTRIBU';
        FIELD_CREDITCL = 'CREDITCL';
        FIELD_SINDATOS = 'SINDATOS';
        FIELD_CODCLIEN = 'CODCLIEN';
        FIELD_FORMPAGO = 'FORMPAGO';
        FIELD_IVAINSCR = 'IVAINSCR';
        FIELD_IVA      = 'IVA';
        FIELD_IVANOINS = 'IVANOINS';
        FIELD_IMPONETO = 'IMPONETO';
        FIELD_NUMFACTU = 'NUMFACTU';
        FIELD_CODVEHIC = 'CODVEHIC';
        FIELD_CODCLPRO = 'CODCLPRO';
        FIELD_CODCLCON = 'CODCLCON';
        FIELD_CODCLTEN = 'CODCLTEN';
        FIELD_INSPFINA = 'INSPFINA';
        FIELD_IMPRESA  = 'IMPRESA';
        FIELD_CODFACTU = 'CODFACTU';
        FIELD_TARIBASI = 'TARIBASI';
        FIELD_PORCREVI = 'PORCREVI';
        FIELD_ESTADO   = 'ESTADO';
        FIELD_HORAINIC = 'HORAINIC';
        FIELD_PRECIOUNITARIO = 'PRECIOUNITARIO';
        FIELD_CODCOFAC = 'CODCOFAC';
        FIELD_ROWID    = 'ROWID';
        FIELD_REVERIFI = 'REVERIFI';
        FIELD_APELLIDOS_Y_NOMBRE = 'ApellidosYNombre';
        FIELD_APELLID2 = 'APELLID2';
        FIELD_APELLID1 = 'APELLID1';
        FIELD_NOMBRE   = 'NOMBRE';
        FIELD_FECMOROS = 'FECMOROS';
        FIELD_TARIFAVE = 'TARIFAVE';
        FIELD_CADDEFEC = 'CADDEFEC';
        FIELD_CALIFDEF = 'CALIFDEF';
        FIELD_LITDEFEC = 'LITDEFEC';
        FIELD_LOCALIZA =  'LOCALIZA';
        FIELD_ESPECIE = 'TIPOESPE';
        FIELD_DESTINO = 'TIPODEST';
        FIELD_CARRY = 'CARRY';
        FIELD_VENCE = 'VENCE';
        FIELD_CUIT_CON = 'CUIT_CON';
        FIELD_TELFCONC = 'TELFCONC';
        FIELD_FAXCONCE = 'FAXCONCE';
        FIELD_DIRCONCE = 'DIRCONCE';
        FIELD_CODPROVI = 'CODPROVI';
        FIELD_HOINITRA = 'HOINITRA';
        FIELD_HOFINTRA = 'HOFINTRA';
        FIELD_CANON = 'CANON';
        FIELD_ENA_VOL = 'ENA_VOL';
        FIELD_ENA_FRE = 'ENA_FRE';
        FIELD_ENA_PRE = 'ENA_PRE';
        FIELD_ENA_SAV = 'ENA_SAV';
        FIELD_ENA_REI = 'ENA_REI';
        FIELD_ENA_DES = 'ENA_DES';
        FIELD_ENA_IME = 'ENA_IME';
        FIELD_ENA_CERTI = 'ENA_CERTI';
        FIELD_ENA_GNC = 'ENA_GNC';
        FIELD_ENA_GNC_RC = 'ENA_GNC_RC';                
        FIELD_NUMOBLEA = 'NUMOBLEA';
        FIELD_NUMOBLEAB = 'NUMOBLEAB';
        FIELD_ULTIMOID = 'ULTIMOID';
        FIELD_UBICADEF = 'UBICADEF';
        FIELD_SECDEFEC = 'SECDEFEC';
        FIELD_SECUDEFE = 'SECUDEFE';
        FIELD_TELEFONO = 'TELEFONO';
        FIELD_NUMREVIS = 'NUMREVIS';
        FIELD_WASPRE   = 'WASPRE';
        FIELD_TIPOCLIENTE_ID = 'TIPOCLIENTE_ID';
        FIELD_PORNORMAL= 'PORNORMAL';
        FIELD_PORREVERIFICACION = 'PORREVERIFICACION';
        FIELD_DESCRIPCION = 'DESCRIPCION';
        FIELD_TIEMPMAX = 'TIEMPMAX';
        FIELD_L1       = 'L1';
        FIELD_L2       = 'L2';
        FIELD_P1       = 'P1';
        FIELD_P2       = 'P2';
        FIELD_CLASIFIC = 'CLASIFIC';
        FIELD_DESCRIPC = 'DESCRIPC';
        FIELD_NOMESPEC = 'NOMESPEC';
        FIELD_GRUPOTIP = 'GRUPOTIP';
        FIELD_NOMDESTI = 'NOMDESTI';
        FIELD_NOMREVIS = 'NOMREVIS';
        FIELD_ESSUPERV = 'ESSUPERV';
        FIELD_PALCLAVE = 'PALCLAVE';
        FIELD_LITDEFC  = 'LITDEFC';
        FIELD_NUMZONAP = 'NUMZONAP';
        FIELD_DESPROVI = 'DESPROVI';
        FIELD_PTOVENTA = 'PTOVENTA';   //   LOS FIELD DE ACA EN ADELANTE
        FIELD_NC = 'NC';
        FIELD_VIGENTE  = 'VIGENTE';
        FIELD_CAJA     = 'CAJA';
        FIELD_IDUSUARIO = 'IDUSUARIO';
        FIELD_NROULTIM = 'NROULTIM';
        FIELD_FECHORPRIM = 'FECHORPRIM';
        FIELD_AUDIPARC = 'AUDIPARC';
        FIELD_AUDITOTA = 'AUDITOTA';
        FIELD_CODIMPRE = 'CODIMPRE';
        FIELD_TEXTAUDI = 'TEXTAUDI';
        FIELD_NROBCOK  = 'NROBCOK';
        FIELD_NROBCIMP = 'NROBCIMP';
        FIELD_NROAOK   = 'NROAOK';
        FIELD_NROAIMPR = 'NROAIMPR';
        FIELD_NRODNF   = 'NRODNF';
        FIELD_NRODNFH  = 'NRODNFH';
        FIELD_NROREFNF = 'NROREFNF';
        FIELD_PVENTA   = 'CAJA';

        FIELD_CODFACT   ='CODFACT';
        FIELD_PTOVENT   ='PTOVENT';
        FIELD_CODTARJET ='CODTARJET';
        FIELD_NUMTARJET ='NUMTARJET';
        FIELD_FECHAVEN  ='FECHAVEN';
        FIELD_CANTCUOT  ='CANTCUOT';
        FIELD_IDUSUARI  ='IDUSUARI';
        FIELD_TIPOFAC   ='TIPOFAC';
        FIELD_IMPSINDES ='IMPSINDES';
        FIELD_DESCUENT  ='DESCUENT';

        FIELD_RSOCIAL   ='RSOCIAL';
        FIELD_CUIT      ='CUIT';
        FIELD_INSINGBRUT='INSINGBRUT';
        FIELD_CALLECOM  ='CALLECOM';
        FIELD_CODPOSTALCF  ='CODPOSTA';
        FIELD_LOCALIDAD ='LOCALIDAD';
        FIELD_FECHINIACT='FECHINIACT';
        FIELD_RESPIVA   ='RESPIVA';
        FIELD_TELEFONOS ='TELEFONOS';
        FIELD_CODCOMER  ='CODCOMER';
        FIELD_NOMTARJET ='NOMTARJET';
        FIELD_CODAUTO   ='CODAUTO';
        FIELD_ABREVIA   ='ABREVIA';
        FIELD_NOMFANTASIA ='NOMFANTASIA';
        FIELD_RELCODFAC ='RELCODFAC';
        FIELD_CODDESCU ='CODDESCU';
        FIELD_PORCENTA ='PORCENTA';
        FIELD_CONCEPTO ='CONCEPTO';
        FIELD_FECVIGINI ='FECVIGINI';
        FIELD_FECVIGFIN ='FECVIGFIN';
        FIELD_NUMCHEQUE ='NUMCHEQUE';
        FIELD_CODCHEQUE ='CODCHEQUE';
        FIELD_FECHPAGO ='FECHPAGO';
        FIELD_IMPORTE ='IMPORTE';
        FIELD_CODBANCO ='CODBANCO';
        FIELD_CODSUCURSAL ='CODSUCURSAL';
        FIELD_CODMONEDA ='CODMONEDA';
        FIELD_SIMBOLO ='SIMBOLO';
        FIELD_NROBANCO = 'NROBANCO';

        FIELD_EMITENC = 'EMITENC';
        FIELD_PRESCOMPROB = 'PRESCOMPROB';
        FIELD_DISCRIMCD = 'DISCRIMCD';
        FIELD_NROCUPON ='NROCUPON';

        FIELD_P1MS = 'P1MS';
        FIELD_P1SA = 'P1SA';
        FIELD_P1AI = 'P1AI';
        FIELD_P1IN = 'P1IN';
        FIELD_P2MS = 'P2MS';
        FIELD_P2SA = 'P2SA';
        FIELD_P2AI = 'P2AI';
        FIELD_P2IN = 'P2IN';
        FIELD_P3MS = 'P3MS';
        FIELD_P3SA = 'P3SA';
        FIELD_P3AI = 'P3AI';
        FIELD_P3IN = 'P3IN';
        FIELD_P4MS = 'P4MS';
        FIELD_P4SA = 'P4SA';
        FIELD_P4AI = 'P4AI';
        FIELD_P4IN = 'P4IN';
        FIELD_P5MS = 'P5MS';
        FIELD_P5SA = 'P5SA';
        FIELD_P5AI = 'P5AI';
        FIELD_P5IN = 'P5IN';
        FIELD_P6MS = 'P6MS';
        FIELD_P6SA = 'P6SA';
        FIELD_P6AI = 'P6AI';
        FIELD_P6IN = 'P6IN';
        FIELD_P7MS = 'P7MS';
        FIELD_P7SA = 'P7SA';
        FIELD_P7AI = 'P7AI';
        FIELD_P7IN = 'P7IN';
        FIELD_TOTENCU = 'TOTENCU';
        FIELD_ENVIADO = 'ENVIADO';
        FIELD_FECHA = 'FECHA';
        FIELD_LIMITE_ENCUESTA = 'LIMITE_ENCUESTA';
        FIELD_FECHA_V_OLD     = 'FECHA_V_OLD';
        FIELD_FECHA_V_NEW     = 'FECHA_V_NEW';
        FIELD_USUARIO = 'USUARIO';
        FIELD_PASSWORD = 'PASSWORD';
        FIELD_FECHAPC = 'FECHAPC';

        FIELD_EFFRSERV = 'EFFRSERV';
        FIELD_EFFRESTA = 'EFFRESTA';
        FIELD_DESE1EJE = 'DESE1EJE';
        FIELD_DESE2EJE = 'DESE2EJE';
        FIELD_DESL1EJE = 'DESL1EJE';
        FIELD_PORCENCO = 'PORCENCO';
        FIELD_PORCECO2 = 'PORCECO2';
        FIELD_VALORKME = 'VALORKME';
        FIELD_CODMOTIVO = 'CODMOTIVO';
        FIELD_SERIE = 'SERIE';
        FIELD_FECHA_INICIO = 'FECHA_INICIO';
        FIELD_FECHA_FIN = 'FECHA_FIN';
        FIELD_NOM_F_PREG = 'NOM_F_PREG';
        FIELD_NOM_F_IMPR = 'NOM_F_IMPR';
        FIELD_NROPREGUNTA = 'NROPREGUNTA';
        FIELD_PREGUNTA = 'PREGUNTA';
        FIELD_ADICIONAL = 'ADICIONAL';
        FIELD_CODINSPGNC = 'CODINSPGNC';
        FIELD_FECHVENCI = 'FECHVENCI';
        FEILD_OBLEANUEVA = 'OBLEANUEVA';
        FIELD_OBLEAANT = 'OBLEAANT';
        FIELD_RESULTADO = 'RESULTADO';
        FIELD_CODEQUIGNC = 'CODEQUIGNC';
        FIELD_TIPOOPERACION = 'TIPOOPERACION';
        FIELD_CODREGULADOR = 'CODREGULADOR';
        FIELD_CODCILINDRO = 'CODCILINDRO';
        FIELD_IDCILINDRO = 'IDCILINDRO';
        FIELD_NROSERIE   = 'NROSERIE';
        FIELD_IDREGULADOR = 'IDREGULADOR';
        FIELD_NUEVOREG = 'NUEVOREG';
        FIELD_FECHVENC = 'FECHVENC';
        FIELD_NROSERIEVALV = 'NROSERIEVALV';
        FIELD_IDVALVULA = 'IDVALVULA';
        FIELD_CANTCILINDROS = 'CANTCILINDROS';
        FIELD_HORAFINA = 'HORAFINA';
        FIELD_HORENTFOSA = 'HORENTFOSA';
        FIELD_HORSALFOSA = 'HORSALFOSA';
        FIELD_CODDEFEC = 'CODDEFEC';
        FIELD_INYECCION = 'INYECCION';
        FIELD_OBLEANUEVA = 'OBLEANUEVA';
        FIELD_NUMOBLEAGNC = 'NUMOBLEAGNC';
        FIELD_NUMOBLEAGNCB = 'NUMOBLEAGNCB';
        FIELD_NUEVO = 'NUEVO';
        FIELD_FECHFABRI = 'FECHFABRI';
        FIELD_FECHREVI = 'FECHREVI';
        FIELD_IDCRPC = 'IDCRPC';
        FIELD_CODIGO = 'CODIGO';
        FIELD_CODTALLER = 'CODTALLER';
        FIELD_RTECNICO = 'RTECNICO';
        FIELD_MATRICULART = 'MATRICULART';
        FIELD_OBLEAVIEJA = 'OBLEAVIEJA';
        FIELD_PATENTE = 'PATENTE';
        FIELD_MOTOR = 'MOTOR';
        FIELD_CHASIS = 'CHASIS';
        FIELD_ANO = 'ANO';
        FIELD_MARCA = 'MARCA';
        FIELD_MODELO = 'MODELO';
        FIELD_POLIZA = 'POLIZA';
        FIELD_NROPOLIZA = 'NROPOLIZA';
        FIELD_CERTIFICADO = 'CERTIFICADO';
        FIELD_ASEGURADO = 'ASEGURADO';
        FIELD_TIPODOC = 'TIPODOC';
        FIELD_NRODOC = 'NRODOC';
        FIELD_CERTIFICAD = 'CERTIFICAD';
        FIELD_NROCALLE = 'NROCALLE';
        FIELD_PISO = 'PISO';
        FIELD_DEPTO = 'DEPTO';
        FIELD_IDCODPOSTA = 'IDCODPOSTA';
        FIELD_IDLOCALIDAD = 'IDLOCALIDAD';
        FIELD_IIBB = 'IIBB';
        FIELD_ENA_PIB = 'ENA_PIB';
        FIELD_EXENTO_IIBB = 'EXENTO_IIBB';
        FIELD_IMP_IIBB = 'IMP_IIBB';
        FIELD_NRODECLARACION = 'NRODECLARACION';
        FIELD_MOTIVO = 'MOTIVO';
        FIELD_AUTORIZO = 'AUTORIZO';
        FIELD_CANTAPTAS = 'CANTAPTAS';
        FIELD_CANTRECH = 'CANTRECH';
        FIELD_COBLEASACT = 'COBLEASACT';
        FIELD_MINOBLEACT = 'MINOBLEACT';
        FIELD_MAXOBLEACT = 'MAXOBLEACT';
        FIELD_COBLEASIG = 'COBLEASIG';
        FIELD_MINOBLEASIG = 'MINOBLEASIG';
        FIELD_MAXOBLEASIG = 'MAXOBLEASIG';
        FIELD_ANIO = 'ANIO';
        FIELD_TIPOVENTA = 'TIPOVENTA';
        FIELD_FECHA_ARCHIVO = 'FECHA_ARCHIVO';
        FIELD_CODLIQUIDACION = 'CODLIQUIDACION';
        FIELD_NROCOMPROB = 'NROCOMPROB';
        FIELD_TRANSPORTE = 'TRANSPORTE';
        FIELD_CAMBIO = 'CAMBIO';
        FIELD_COBCTACTE= 'COBCTACTE';
        FIELD_TOTALXARQ = 'TOTALXARQ';
        FIELD_TOTALXARQCHE= 'TOTALXARQCHE';
        FIELD_OBSERVACIONES = 'OBSERVACIONES';
        FIELD_FECHMODI = 'FECHMODI';
        FIELD_CANTAPRV ='CANTAPRV';
        FIELD_CANTCONV ='CANTCONV';
        FIELD_CANTRECV ='CANTRECV';
        FIELD_CANTAPRR ='CANTAPRR';
        FIELD_CANTCONR ='CANTCONR';
        FIELD_CANTRECR ='CANTRECR';
        FIELD_CANTANULADAS ='CANTANULADAS';
        FIELD_CANTINUTIL ='CANTINUTIL';
        FIELD_PROCEDENCIA = 'PROCEDENCIA';
        FIELD_FMXFSRD1 = 'FMXFSRD1';
        FIELD_FMXFSRI1 = 'FMXFSRI1';
        FIELD_FMXFSRD2 = 'FMXFSRD2';
        FIELD_FMXFSRI2 = 'FMXFSRI2';
        FIELD_PLANTA = 'PLANTA';
        FIELD_DOMICILIO = 'DOMICILIO';

        FIELD_USER = 'USUARIO';

        FIELD_NUMERO_OB = 'NUMOBLEA';
        FIELD_ANIO_OB   = 'ANIO';
        FIELD_ESTADO_OB ='ESTADO';
        FIELD_FECHA_AL_OB   = 'FECHA_ALTA';
        FIELD_FECHA_CON_OB  = 'FECHA_CONSUMIDA';
        FIELD_FECHA_INU_OB  = 'FECHA_INUTILIZADA';
        FIELD_FECHA_ANUL_OB = 'FECHA_ANULADA';
        FIELD_CODINSP_OB    = 'CODINSPE';
        FIELD_EJERCICIO_OB  = 'EJERCICI';
        FIELD_VERSION       = 'VERSION';
        FIELD_IDCANCELACION = 'IDCANCELACION';

        FIELD_FECVERIFICACION = 'FECHAVERI';
        FIELD_INSP_ANT = 'NRO_INSP_ANT';

        // TABLAS DEL SISTEMA
        DATOS_GRUPOSVEHICULOS = 'TGRUPOVEHICULOS';
        DATOS_PROVINCIAS = 'TPROVINCIAS';
        DATOS_PARTIDOS = 'TPARTIDOS';
        DATOS_INSPECCIONES = 'TINSPECCION';
        DATOS_VEHICULOS = 'TVEHICULOS';
        DATOS_FACTURAS = 'TFACTURAS';
        DATOS_CONTRAFACTURAS = 'TCONTRAFACT';
        DATOS_ESTADOINSPECCION = 'TESTADOINSP';
        DATOS_CLIENTES = 'TCLIENTES';
        DATOS_MARCAS = 'TMARCAS';
        DATOS_MODELOS = 'TMODELOS';
        DATOS_VARIOS = 'TVARIOS';
        DATOS_TDATINSPECC = 'TEMP_DATINSPECC';
        DATOS_TDATINSPEVI = 'TDATINSPEVI';
        DATOS_TINSPDEFECT = 'TINSPDEFECT';
        DATOS_GRUPOS_DE_VEHICULOS = 'TGRUPOTIPOS';
        DATOS_TIPOS_DE_VEHICULOS = 'TTIPOVEHICU';
        DATOS_FRECUENCIA = 'TFRECUENCIA';
        DATOS_TIPOS_DE_ESPECIE = 'TTIPOESPVEH';
        DATOS_TIPOS_DE_DESTINO = 'TTIPODESVEH';
        DATOS_TIPOS_DE_CLIENTE = 'TTIPOSCLIENTE';
        DATOS_TREVISOR         = 'TREVISOR';
        DATOS_PTOVENTA         = 'TPTOVENTA';  //
        DATOS_CIERREZ          = 'TCIERREZ';
        DATOS_FACT_ADICIONALES = 'TFACT_ADICION';
        DATOS_ESTACION         = 'TDATOS_ESTACION';
        DATOS_USUARIO          = 'TUSUARIO';
        DATOS_TARJETA          = 'TTARJETAS';
        DATOS_DESCUENTOS       = 'TDESCUENTOS';
        DATOS_CHEQUES          = 'TCHEQUES';
        DATOS_BANCOS           = 'TBANCOS';
        DATOS_SUCURSALES       = 'TSUCURSALES';
        DATOS_MONEDAS          = 'TMONEDAS';
        DATOS_PROMOCION        = 'TDATOS_PROMOCIONES';
        DATOS_ENCUESTAS_SATISFACCION = 'TENCUESTAS_SATISFACCION';
        DATOS_DATINSPECC       = 'TEMP_DATINSPECC';
        DATOS_CAMBIOSFECHA     = 'TCAMBIOSFECHA';
        DATOS_MOTIVOS_CAMBIOS  = 'TMOTIVOS_CAMBIOS';
        DATOS_SERIES_ENCUESTAS = 'TSERIES_ENCUESTAS';
        DATOS_PREGUNTAS_ENCUESTAS = 'TPREGUNTAS_ENCUESTAS';
        DATOS_INSPGNC          = 'INSPGNC';
        DATOS_CENTROSRPC       = 'CENTROSRPC';
        DATOS_EQUIPOSGNC       = 'EQUIPOSGNC';
        DATOS_CILINDROS        = 'CILINDROS';
        DATOS_ADICIONALESGNC   = 'ADICIONALESGNC';
        DATOS_VALVULASENARGAS  = 'VALVULASENARGAS';
        DATOS_CILINDROSENARGAS = 'CILINDROSENARGAS';
        DATOS_MARCASENARGAS    = 'MARCASENARGAS';
        DATOS_REGULADORESENARGAS = 'REGULADORESENARGAS';
        DATOS_EQUIGNC_CILINDRO = 'EQUIGNC_CILINDRO';
        DATOS_REGULADORES      = 'REGULADORES';
        DATOS_ESTADOINSPGNC    = 'ESTADOINSPGNC';
        DATOS_DEFECTOSGNC      = 'DEFECTOSGNC';
        DATOS_INSPGNC_DEFECTOS = 'INSPGNC_DEFECTOS';
        DATOS_REGULADOR_MODI   = 'REGULADORES_MODI';
        DATOS_CILINDRO_MODI    = 'CILINDROS_MODI';
        DATOS_DESCUENTOSGNC    = 'DESCUENTOSGNC';
        DATOS_OBLEAS_REEMPL_GNC = 'OBLEAS_REEMPL_GNC';
        DATOS_PROV_SEGUROS      = 'DATOS_PROV_SEGUROS';
        DATOS_CODPOSTA_CAPITAL = 'CODPOSTA_CAPITAL';
        DATOS_CODPOSTA_INTERIOR = 'CODPOSTA_INTERIOR';
        DATOS_LOCALIDAD_INTERIOR = 'LOCALIDAD_INTERIOR';
        DATOS_DEC_JURADA = 'DEC_JURADA';
        DATOS_ANULADAS_GNC    = 'ANULADAS_GNC';
        DATOS_DATOS_PROVINCIA = 'DATOS_PROVINCIA';
        DATOS_BANCOS_DEPOSITO = 'BANCOS_DEPOSITO';
        DATOS_DEPOSITOS_LIQ   = 'DEPOSITOS_LIQ';
        DATOS_LIQUIDACION     = 'LIQUIDACION';
        DATOS_SOCIOS_ACAVTV   = 'SOCIOS_ACAVTV';
        DATOS_CAMBIOSFECHA_GNC = 'CAMBIOSFECHA_GNC';
        DATOS_MOTIVOS_CAMBIOS_GNC  = 'MOTIVOS_CAMBIOS_GNC';
        DATOS_VEHICULOS_GNC   = 'VEHICULOS_GNC';
        DATOS_INSP_VIGENTE    = 'INSP_VIGENTES';
        DATOS_OBLEAS          = 'TOBLEAS';
        DATOS_SAG_INSTALADO   = 'TSAG_INSTALADO';
        DATOS_REVES_EXTERNA   = 'TINSPECCIONEXTERNA';
        

        // SELECTS SOBRE TABLAS

        FORMATO_EJERCICIO = 'LTRIM(TO_CHAR(MOD (' + FIELD_EJERCICI + ', 100), ''00'')) || '' '' || ';

        FORMATO_ZONA = 'LTRIM(TO_CHAR(%D,''0000'')) || ';

        FORMATO_ESTACION = 'LTRIM(TO_CHAR(%D,''0000'')) ||';

        FORMATO_NUMERO = 'Formato_codinspe('+FIELD_CODINSPE+') || ';
        //FORMATO_NUMERO = 'LTRIM(TO_CHAR(' + FIELD_CODINSPE + ', ''000000'')) || ';
        FORMATO_NUMERO_GNC = 'LTRIM(TO_CHAR(' + FIELD_CODINSPGNC + ', ''000000'')) || ';

        FORMATO_REVERIFICACION = 'DECODE(' + FIELD_TIPO + ', ''' + T_REVERIFICACION + ''', '' R'', ''' + T_VOLUNTARIAREVERIFICACION + ''', '' R'', '' '')';

        NUMERO_INFORME = FORMATO_EJERCICIO + FORMATO_ZONA + FORMATO_ESTACION + FORMATO_NUMERO + FORMATO_REVERIFICACION + ' NUMERO, ';
        NUMERO_INFORME_GNC = FORMATO_EJERCICIO + FORMATO_ZONA + FORMATO_ESTACION + FORMATO_NUMERO_GNC + FORMATO_REVERIFICACION + ' NUMERO, ';

        TIPO_INSPECCION = 'DECODE (' + FIELD_TIPO + ', ''' + T_REVERIFICACION + ''',''' + C_REVERIFICACION + ''', ''' + T_PREVERIFICACION + ''', ''' + C_PREVERIFICACION + ''', ''' + T_VOLUNTARIA + ''', ''' + C_VOLUNTARIA + ''', ''' + T_GRATUITA + ''', ''' + C_GRATUITA + ''', ''' + T_VOLUNTARIAREVERIFICACION + ''', ''' + C_VOLUNTARIAREVERIFICACION + ''', ''' + C_NORMAL + ''') TIPO, ';
        FINALIZADA = 'DECODE (' + FIELD_INSPFINA + ', ''S'', ''Sí'', ''No'') FINALIZADA, ';
        RESULTADO = 'DECODE (' + FIELD_RESULTAD + ',  ''A'', ''Apta'', ''C'', ''Condicional'', ''R'', ''Rechazada'', ''B'', ''Baja'', '''') RESULTADO, ';
        FECHA = 'TO_CHAR(' + FIELD_FECHALTA + ',''DD/MM/YYYY HH24:MI'') FECHA, ';
        FECHA_II = 'TO_CHAR(' + FIELD_FECHALTA + ',''DD/MM/YYYY'') FECHA, ';
        VENCE = 'DECODE(NVL(TO_CHAR(' + FIELD_FECVENCI + ',''DD/MM/YYYY''),''01/01/1500''), ''01/01/1500'', '' '', TO_CHAR(' +FIELD_FECVENCI + ',''DD/MM/YYYY'')) VENCE';
        {$IFNDEF SAT98}
        CONSULTA_HISTORICO = FIELD_CODINSPE+', ' +FIELD_EJERCICI+ ', '+FIELD_CODCLPRO + ', ' + FIELD_CODCLCON + ', ' + FIELD_CODCLTEN + ', ' + NUMERO_INFORME + TIPO_INSPECCION + FINALIZADA + RESULTADO + FECHA_II + VENCE+', ' + FIELD_NUMOBLEA;
        {$ELSE}
        CONSULTA_HISTORICO = FIELD_CODINSPE+', ' +FIELD_EJERCICI+ ', '+FIELD_CODCLPRO + ', ' + FIELD_CODCLTEN + ', ' + NUMERO_INFORME + TIPO_INSPECCION + FINALIZADA + RESULTADO + FECHA + VENCE+', ' + FIELD_NUMOBLEA;
        {$ENDIF}

        CONSULTA_HISTORICO_GNC = FIELD_CODINSPGNC+', '+FIELD_EJERCICI+', '+FIELD_CODCLIEN+', '+NUMERO_INFORME_GNC+FIELD_TIPO+', '+FIELD_TIPOOPERACION+', '+FIELD_INSPFINA+', '+FIELD_RESULTADO+', '+FIELD_FECHALTA+', '+FIELD_FECHVENCI;

        // cambiado 05/01/2011
        {
        LAST_VENCIMIENTO_INSPECCIONES =
        'SELECT TO_CHAR('+ FIELD_FECVENCI + ', ''DD/MM/YYYY'') VENCE, ' + FIELD_RESULTAD + ' FROM %S ' +
        'WHERE ' +
        FIELD_INSPFINA + ' = ''' + INSPECCION_FINALIZADA + ''' AND ' +
        //FIELD_RESULTAD + ' IN ( ''' + INSPECCION_RECHAZADO + ''', ''' + INSPECCION_CONDICIONAL + ''') AND ' +
        FIELD_TIPO + ' IN ( %S ) AND ' +
        FIELD_ROWID + ' IN (%S) ORDER BY ' + FIELD_FECHALTA + ' DESC'; }


         LAST_VENCIMIENTO_INSPECCIONES =
        'SELECT TO_CHAR('+ FIELD_FECVENCI + ', ''DD/MM/YYYY'') VENCE, ' + FIELD_RESULTAD + ' FROM %S  I,TFACTURAS F ' +
        'WHERE  I.CODFACTU=F.CODFACTU AND CODCOFAC IS NULL AND  ' +
        FIELD_INSPFINA + ' = ''' + INSPECCION_FINALIZADA + ''' AND ' +
        //FIELD_RESULTAD + ' IN ( ''' + INSPECCION_RECHAZADO + ''', ''' + INSPECCION_CONDICIONAL + ''') AND ' +
        FIELD_TIPO + ' IN ( %S ) AND I.' +
        FIELD_ROWID + ' IN (%S) ORDER BY I.' + FIELD_FECHALTA + ' DESC';



    var
        // RESTRICCIONES POR PROGRAMA, SOBRE ALGUNAS COLUMNAS
        EJES_MAXIMOS: Integer = 9;
        EJES_MINIMOS: Integer = 2;

    type
        tfVerificacion = (fvNormal, fvPreverificacion, fvGratuita, fvVoluntaria, fvReverificacion, fvStandBy, fvPreverificacionOk, fvMantenimiento, fvVoluntariaReverificacion, fvGNCRPA, fvGNCRC, fvGNCRPAOK, fvReverificacionExterna);
        tEstados = (teFacturado,teVerificandose,teRecibido_Ok,teRecibido_NOk,teAnulado,teFinalizado,teStandBy,tePendienteFacturar,tePendienteSIC,teModificado);
        tTipoDominio = (ttdmAntiguo, ttdmAutos, ttdmMotos, ttdmTractor, ttdmEmbajada, ttdmDiplomatica,ttdmMercosur, ttdmVacio,  ttdmNull, ttdmSpanish);    //mb
        {$IFNDEF INTEVE}
        tTipoDocumento = (ttdDNI, ttdCI, ttdLC, ttdLE, ttdCUIT, ttdNull);
        {$ELSE}
        tTipoDocumento = (ttdDNI, ttdNIF, ttdCIF, ttdNull);
        {$ENDIF}
        tTipoCredito = (ttcNormal, ttcCredito, ttcNull);
        tTipoFormulario = (ttfAusente, ttfInscripto, ttfNoInscripto,ttfNull);
        tTipoFactura = (ttfaA, ttfaB, ttfaNull);
//      tTipoTributacion = (tttIvaInscripto, tttIvaNoInscripto, tttIvaExento, tttConsumidorFinal, tttNull); MODIF RAN
        tTipoTributacion = (tttIvaInscripto, tttIvaNoInscripto, tttIvaExento, tttConsumidorFinal,
                            tttIvaNoResponsable, tttIvaMonotributo, tttNull);
        tFormaPago = (tfpMetalico,tfpCredito,tfpTarjeta,tfpCheque,tfpOficial,tfpNull);
        tSinDatosCli = (tsdSinDatos, tsdConDatos, tsdNull);
        tFacturaImpresa = (tfiNoImpresa, tfiImpresa);
        tFacturaErronea = (tfeConErrorFac, tfeSinErrorFac, tfeNull);
        tTipoCombustible = (ttcbGNC, ttcbNafta, ttcbGasoil, ttcbMezcla, ttcbOtros, ttcbNull);
        tTipoOperacionGNC = (ttoRevisionAnual, ttoConversion, ttoModificacion, ttoDesmontaje, ttoBaja, ttoOtro);

        tSumaryCD = record
            iACodeUser,
            iPOblea1,
            iPOblea2,
            iSubPubUsers,
            iSalesWOPubUsers,
            iOCreditSales,
            iContSales,
            iIvaContSales,
            iTtlContSales,
            iTtlArqueoCaja,
            iNAC,
            iNR,
            iNACR,
            iNOblCYP1,
            iNOblCYP2,
            iNOblNYP1,
            iNOblNYP2,
            FOblCYearP1,
            LOblCYearP1,
            FOblCYearP2,
            LOblCYearP2,
            FOblNYearP1,
            LOblNYearP1,
            FOblNYearP2,
            LOblNYearP2,

            iTtlDifConvCredito,
            iTtlDifNcxDesc,
            iTtlDifxConvenio,
            iTtlDifxNcxDescCred,
            iOblAnula,
            iOblInutil,

            Observaciones : string
        end;

        tSumaryLD = record
            iTransporte,
            iCambioRec,
            iCobranzasCtaCte,
            iTotalDep,
            iTotalCaja,
            iTotalXArqueo,
            iTotalXArqueoChe,
            iTotalContado,
            iDiferencia : string
        end;


        TTagSet = set of 1..10;
    const
        S_TIPOS_COLORES: array[fvNormal..fvGNCRPAOK] of LongInt = (clblue,clSilver,clGreen,clNavy,clRed,clTeal,clGray,clOlive,clMaroon,clBlue,clTeal,clGreen);
        S_TIPOS_FUENTES_COLORES: array[fvNormal..fvGNCRPAOK] of LongInt = (clWhite,clBlack,clWhite,clWhite,clWhite,clWhite,clBlack,clWhite,clWhite,clWhite,clWhite,clWhite);
//        S_TIPO_VERIFICACION: array[fvNormal..fvVoluntariaReverificacion] of string = (C_NORMAL, C_PREVERIFICACION, C_GRATUITA, C_VOLUNTARIA, C_REVERIFICACION, C_STANDBY, C_PREVERIFICACIONOK, C_MANTENIMIENTO, C_VOLUNTARIAREVERIFICACION);  MODI RAN GNC
        S_TIPO_VERIFICACION: array[fvNormal..fvGNCRPAOK] of string = (C_NORMAL, C_PREVERIFICACION, C_GRATUITA, C_VOLUNTARIA, C_REVERIFICACION, C_STANDBY, C_PREVERIFICACIONOK, C_MANTENIMIENTO, C_VOLUNTARIAREVERIFICACION, C_GNCRPA, C_GNCRC, C_GNCRPAOK);
        S_ESTADOS_COLORES: array[teFacturado..teModificado] of LongInt = (clSilver,clNavy,clBlue,clTeal,clMaroon,clGreen,clRed,clWhite,clRed,clYellow);
        S_ESTADOS_FUENTES_COLORES: array[teFacturado..teModificado] of LongInt = (clBlack,clWhite,clWhite,clWhite,clWhite,clBlack,clWhite,clblack,clWhite,clBlack);
        S_ESTADO_INSPECCION: array[teFacturado..teModificado] of string = ('Facturado','Verificándose','Recibido_Ok','Recibido_NOk','Anulado','Finalizado','StandBy','Pendiente Facturar','Pendiente SIC','Datos Modificados');
        S_TIPO_CREDITO: array [ttcNormal .. ttcCredito] of string = ('Cliente Normal','Cliente de Crédito');
        S_TIPO_FORMULARIO: array [ttfAusente .. ttfNoInscripto] of string = ('No tiene formulario', 'Formulario Inscripto', 'Formulario No Inscripto');
//      S_TIPO_TRIBUTACION: array [tttIvaInscripto .. tttIvaMonotributo] of string = ('IVA Inscripto', 'IVA No Inscripto', 'IVA Exento', 'Consumidor Final');  MODIF RAN
        S_TIPO_TRIBUTACION: array [tttIvaInscripto .. tttIvaMonotributo] of string = ('IVA Inscripto', 'IVA No Inscripto', 'IVA Exento', 'Consumidor Final', 'Iva No Responsable', 'Iva Resp. Monotributo');
        {$IFNDEF INTEVE}
        S_TIPO_DOCUMENTO: array [ttdDNI .. ttDCUIT] of string = ('DNI', 'CI', 'LC', 'LE', 'CUIT');
        {$ELSE}
        S_TIPO_DOCUMENTO: array [ttdDNI .. ttdCIF] of string = ('DNI', 'NIF', 'CIF');
        {$ENDIF}
        S_TIPO_FACTURA: array [ttfaA .. ttfaB] of string = ('A','B');
        S_FORMA_PAGO: array [tfpMetalico .. tfpOficial] of string = ('Contado', 'Cuenta Corriente', 'Tarjeta de Credito','Cheque','Cuenta Corriente');
        S_TIPO_SINDATOSCLI : array [tsdSinDatos.. tsdConDatos] of string = ('Cliente sin datos en factura', 'Cliente con datos en factura');

        TCB_DB_TO_SAG: array [G_..N_] of tTipoCombustible = (ttcbGNC, ttcbOtros, ttcbOtros, ttcbOtros, ttcbOtros, ttcbGasoil, ttcbMezcla, ttcbNafta);
        TCB_SAG_TO_SCREEN: array [ttcbGNC .. ttcbOtros] of string = ('GNC','Nafta','Gasoil','Mezcla','Otros');
        TCB_SAG_TO_DB: array [ttcbGNC .. ttcbOtros] of string = ('G','N','L','M','');

        TTO_DB_TO_SAG: array [B_..R_] of tTipoOperacionGNC = (ttoBaja, ttoConversion, ttoDesmontaje, ttoOtro,ttoOtro,ttoOtro,ttoOtro,ttoOtro,ttoOtro,ttoOtro,ttoOtro,ttoModificacion,ttoOtro,ttoOtro,ttoOtro,ttoOtro, ttoRevisionAnual);
        TTO_SAG_TO_SCREEN: array [ttoRevisionAnual .. ttoOtro] of string = ('Revisión Anual','Conversión','Modificación','Desmontaje','Baja','Otros');
        TTO_SAG_TO_DB: array [ttoRevisionAnual .. ttoOtro] of string = ('R','C','M','D','B','');

        V_ESTADOS_INSP: array [teFacturado..teModificado] of string = (E_FACTURADO,E_VERIFICANDOSE,E_RECIBIDO_OK,E_RECIBIDO_NOK,E_ANULADO,E_FINALIZADO,E_STANDBY,E_PENDIENTE_FACTURAR,E_PENDIENTE_SIC,E_MODIFICADO);
        V_TIPO_CREDITO: array [ttcNormal .. ttcCredito] of string = ('NULL','S');
        V_TIPO_FORMULARIO: array [ttfAusente .. ttfNoInscripto] of string = ('NULL','I','N');
//      V_TIPO_TRIBUTACION: array [tttIvaInscripto .. tttIvaMonotributo] of string = (IVA_INSCRIPTO, IVA_NO_INSCRIPTO, IVA_EXENTO, IVA_CONSUM_FINAL);  MODIF RAN
        V_TIPO_TRIBUTACION: array [tttIvaInscripto .. tttIvaMonotributo] of string = (IVA_INSCRIPTO, IVA_NO_INSCRIPTO, IVA_EXENTO, IVA_CONSUM_FINAL, IVA_NO_RESPONSABLE, IVA_MONOTRIBUTO);

        {$IFNDEF INTEVE}
        V_TIPO_DOCUMENTO: array [ttdDNI .. ttDCUIT] of string = ('DNI', 'CI', 'LC', 'LE', 'CUIT');
        {$ELSE}
        V_TIPO_DOCUMENTO: array [ttdDNI .. ttDCIF] of string = ('DNI', 'NIF', 'CIF');
        {$ENDIF}

        V_TIPO_FACTURA: array [ttfaA .. ttfaB] of string = ('A','B');
        V_FORMA_PAGO: array [tfpMetalico..tfpOficial] of string = (FORMA_PAGO_METALICO,FORMA_PAGO_CREDITO,FORMA_PAGO_TARJETA,FORMA_PAGO_CHEQUE,'O');
        V_TIPO_SINDATOSCLI: array [tsdSinDatos .. tsdConDatos] of string = (SIN_DATOS_CLIENTE, 'NULL');
        V_FACT_IMPRESA: array[tfiNoImpresa..tfiImpresa] of string = ('N','S');
        V_FACT_ERROR: array [tfeConErrorFac .. tfeSinErrorFac] of string = ('S', 'NULL');
//      TTIPOSIVA : array [0..3] of char = ('I', 'N', 'C', 'E');  MODIF RAN
        TTIPOSIVA : array [0..4] of char = ('I', 'C', 'E', 'R', 'M');
       {
       TABLA_COMBINACIONES_OK : array [ttdmAntiguo..ttdmVacio, ttdmAntiguo..ttdmVacio] of boolean =
       ((FALSE, TRUE, TRUE, TRUE), (FALSE, FALSE, FALSE, FALSE),
        (FALSE, FALSE, FALSE, FALSE), (FALSE, TRUE, TRUE, FALSE));   }

        TABLA_COMBINACIONES_OK : array [ttdmAntiguo..ttdmVacio, ttdmAntiguo..ttdmVacio] of boolean=
  //        ((FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE), (FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE),(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE), (FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE),(FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE), (FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE), (FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE));
       (
        (FALSE, TRUE,   TRUE,   TRUE,   TRUE,   TRUE,   TRUE, TRUE),
        (FALSE, FALSE,  FALSE,  FALSE,  FALSE,  FALSE,  FALSE, FALSE),
        (FALSE, FALSE,  FALSE,  FALSE,  FALSE,  FALSE,  FALSE,FALSE),
        (FALSE, TRUE,   TRUE,   TRUE,   TRUE,   TRUE,   TRUE, FALSE),
        (FALSE, TRUE,   TRUE,   TRUE,   TRUE,   TRUE,   TRUE, FALSE),
        (FALSE, TRUE,   TRUE,   TRUE,   TRUE,   TRUE,   TRUE, FALSE),
        (FALSE, TRUE,   TRUE,   TRUE,   TRUE,   TRUE,   TRUE, FALSE),
        (FALSE, TRUE,   TRUE,   TRUE,   TRUE,   TRUE,   TRUE, FALSE)
        );

{    ANTIGUA	 NUEVA	    CORRECTA

     ANTIGUO    ANTIGUO	       NO
     ANTIGUO    AUTOS	       SI
     ANTIGUO    MOTOS	       SI
     ANTIGUO    NULL           SI

     AUTOS	    ANTIGUO	       NO
     AUTOS	    AUTOS	       NO
     AUTOS	    MOTOS          NO
     AUTOS      NULL           NO

     MOTOS	    ANTIGUO	       NO
     MOTOS      AUTOS	       NO
     MOTOS      MOTOS          NO
     MOTOS      NULL           NO

     NULL       ANTIGUO        NO
     NULL       AUTOS          SI
     NULL       MOTOS          SI
     NULL       NULL           NO

 }

// Valores para exportación a Excel
    xlLeft = -4131;
    xlRight = -4152; 

implementation


end.
