unit USAGESTACION;

interface

    uses
        DBTables,
        Graphics,
        USAGDATA;
    var
        BaudRate,PortNumber: string;

    const

        // NOMBRES DE COLUMNAS DE TABLAS DEL SISTEMA

        // TABLAS DEL SISTEMA
        DATOS_VARIOS = 'TVARIOS';
        DATOS_TPLANTAS = 'TPLANTAS';
        DATOS_PLANTAS = 'PLANTAS';        
        DATOS_ZONAS = 'TZONAS';
        DATOS_DESCUENTOS = 'TDESCUENTOS';
        DATOS_SERIES_ENCUESTAS = 'TSERIES_ENCUESTAS';
        DATOS_PREGUNTAS_ENCUESTAS = 'TPREGUNTAS_ENCUESTAS';
        DATOS_CD_GNC = 'DATOS_CD';
        DATOS_ANULADAS = 'ANULADAS';
        DATOS_INSP_PROVINCIA = 'INSP_PROVINCIA';
        DATOS_CD_VTV = 'VTV_DATOS_CD';
        DATOS_OBLEAS_VTV = 'VTV_OBLEAS';
        DATOS_OBLEAS_GNC = 'OBLEAS';
        DATOS_REPORTE_MENSUAL = 'REPORTE_MENSUAL';    


        // CAMPOS
        FIELD_CARRY = 'CARRY';
        FIELD_ESTACION = 'ESTACION';
        FIELD_ZONA = 'ZONA';
        FIELD_IDENCONC = 'IDENCONC';
        FIELD_NOMRESPO = 'NOMRESPO';
        FIELD_PORCREVI = 'PORCREVI';
        FIELD_IVAINSCR = 'IVAINSCR';
        FIELD_IVANOINS = 'IVANOINS';
        FIELD_CUIT_CON = 'CUIT_CON';
        FIELD_TELFCONC = 'TELFCONC';
        FIELD_FAXCONCE = 'FAXCONCE';
        FIELD_DIRCONCE = 'DIRCONCE';
        FIELD_CODPOSTA = 'CODPOSTA';
        FIELD_LOCALIDA = 'LOCALIDA';
        FIELD_CODPROVI = 'CODPROVI';
        FIELD_HOINITRA = 'HOINITRA';
        FIELD_HOFINTRA = 'HOFINTRA';
        FIELD_TARIBASI = 'TARIBASI';
        FIELD_CANON    = 'CANON';
        FIELD_ENA_VOL  = 'ENA_VOL';
        FIELD_ENA_FRE  = 'ENA_FRE';
        FIELD_ENA_PRE  = 'ENA_PRE';
        FIELD_ENA_DES  = 'ENA_DES';
        FIELD_ENA_SAV  = 'ENA_SAV';
        FIELD_ENA_REI  = 'ENA_REI';
        FIELD_NUMOBLEA = 'NUMOBLEA';
        FIELD_NUMOBLEAB= 'NUMOBLEAB';
        FIELD_LIMITE_ENCUESTA = 'LIMITE_ENCUESTA';
        FIELD_USUARIO = 'USUARIO';
        FIELD_PASSWORD = 'PASSWORD';
        FIELD_NOMBRE = 'NOMBRE';
        FIELD_CODDESCU = 'CODDESCU';
        FIELD_CONCEPTO = 'CONCEPTO';

        FIELD_SERIE = 'SERIE';
        FIELD_FECHA_INICIO = 'FECHA_INICIO';
        FIELD_FECHA_FIN = 'FECHA_FIN';
        FIELD_NOM_F_PREG = 'NOM_F_PREG';
        FIELD_NOM_F_IMPR = 'NOM_F_IMPR';
        FIELD_NROPREGUNTA = 'NROPREGUNTA';
        FIELD_PREGUNTA = 'PREGUNTA';
        FIELD_ABREVIA = 'ABREVIA';

        FIELD_PLANTA = 'PLANTA';
        FIELD_FECHA = 'FECHA';
        FIELD_CANTAPTAS = 'CANTAPTAS';
        FIELD_CANTRECHAZADAS = 'CANTRECHAZADAS';
        FIELD_CANTACTUAL = 'CANTACTUAL';
        FIELD_PRACTUAL = 'PRACTUAL';
        FIELD_ULACTUAL = 'ULACTUAL';
        FIELD_CANTPROX = 'CANTPROX';
        FIELD_PRPROX = 'PRPROX';
        FIELD_ULPROX = 'ULPROX';
        FIELD_CANTANULADAS = 'CANTANULADAS';
        FIELD_FECHMODI = 'FECHMODI';
        FIELD_MOTIVO = 'MOTIVO';

        FIELD_CODINSPE = 'CODINSPE';
        FIELD_PATENTE = 'PATENTE';
        FIELD_MOTOR = 'MOTOR';
        FIELD_CHASIS = 'CHASIS';
        FIELD_ANO = 'ANO';
        FIELD_MARCA = 'MARCA';
        FIELD_MODELO = 'MODELO';
        FIELD_POLIZA = 'POLIZA';
        FIELD_CERTIFICADO = 'CERTIFICADO';
        FIELD_ASEGURADO = 'ASEGURADO';
        FIELD_TIPODOC = 'TIPODOC';
        FIELD_NRODOC = 'NRODOC';
        FIELD_TIPOVENTA = 'TIPOVENTA';
        FIELD_FECHA_ARCHIVO = 'FECHA_ARCHIVO';
        FIELD_TIPFACTU = 'TIPFACTU';
        FIELD_IMPONETO = 'IMPONETO';
        FIELD_NUMFACTU = 'NUMFACTU';
        FIELD_FECHALTA = 'FECHALTA';
        FIELD_IDEMPRESA = 'IDEMPRESA';

        FIELD_CANTAPRV ='CANTAPRV';
        FIELD_CANTCONV ='CANTCONV';
        FIELD_CANTRECV ='CANTRECV';
        FIELD_CANTAPRR ='CANTAPRR';
        FIELD_CANTCONR ='CANTCONR';
        FIELD_CANTRECR ='CANTRECR';
        FIELD_CANTINUTIL ='CANTINUTIL';
        FIELD_RECAUDACION ='RECAUDACION';
        FIELD_TIPO ='TIPO';
        FIELD_NUMERO = 'NUMERO';
        FIELD_ESTADO = 'ESTADO';
        FIELD_FECHCONS = 'FECHCONS';
        FIELD_IDPLANTA = 'IDPLANTA';
        FIELD_EJERCICI = 'EJERCICI';
        FIELD_IDZONA = 'IDZONA';
        FIELD_NROPLANTA = 'NROPLANTA';
        FIELD_FECHINUT = 'FECHINUT';

        PREVISUALIZAR = 'PREVIEW';
        IMPRIMIR = 'PRINT';

        //Tipos de importación
        TIPO_AUTOMATICA = 'A';
        TIPO_MANUAL = 'M';

        //Estados de las Obleas
        ESTADO_STOCK = 'S';
        ESTADO_CONSUMIDA = 'C';
        ESTADO_ANULADA = 'A';
        ESTADO_INUTILIZADA = 'I';
        ESTADO_CONS_INUTIL = 'K'; //Para las que fueron consumidas en lugar de una inutilizada

        //clave para zip
        clavezip = 'FlashE60&MX!pci';

    type
        tfVerificacion = (fvNormal, fvPreverificacion, fvGratuita, fvVoluntaria, fvReverificacion, fvStandBy, fvPreverificacionOk, fvMantenimiento, fvVoluntariaReverificacion);
        tTipoDocumento = (ttdDNI, ttdNIF, ttdCIF, ttdNull);




implementation


end.
