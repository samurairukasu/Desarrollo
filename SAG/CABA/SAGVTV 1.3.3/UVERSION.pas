unit UVERSION;

interface

    const

        {$IFDEF INTEVE}
        APPLICATION_NAME = 'SATELITE';
        COMPANY_NAME = 'DHRMA';
        {$ELSE}
        APPLICATION_NAME = 'SAGVTV';
        COMPANY_NAME = 'SAGCABA';
        {$ENDIF}

        SO_WINNT = '4.0';
        SO_WIN2000 = '5.0';
        SO_WINXP = '5.1';
        SO_WIN2003 = '5.2';

        VERSION_KEY = 'SOFTWARE\Microsoft\Windows NT\CurrentVersion\';

        APPLICATION_KEY = '\SOFTWARE\'+COMPANY_NAME+'\'+APPLICATION_NAME;
        PRINTER_KEY = APPLICATION_KEY+'\PRINTER';
        LICENCIA_KEY = APPLICATION_KEY+'\LICENCIA';
        BD_KEY = APPLICATION_KEY+'\BD';
        IO_KEY = APPLICATION_KEY+'\IO';
        LOGS_ = APPLICATION_KEY+'\LOGS';

        CAJA_ = APPLICATION_KEY+'\CAJA';
        II_ = APPLICATION_KEY+'\BD';
        SAVE_ = 'RSA';

        ALIAS_sql='AliasSQL';
        ALIAS_ = 'Alias';
        USER_  = 'User';
        PASSWORD_ = 'Password';
        ALIAS2_ = 'Alias2';
        USER2_  = 'User2';
        PASSWORD2_ = 'Password2';
        ALIAS3_ = 'Alias3';
        USER3_  = 'User3';
        PASSWORD3_ = 'Password3';
        DRIVERNAME_ = 'Drivername';
        LIBRARYNAME_ = 'Libraryname';
        VENDORLIB_ = 'vendorlib';
        GETDRIVERFUNC_ = 'GetDriverFunc';

        TRAZAS_ = 'Trazas';
        MASCARA_ = 'Mascara';
        ANOMALIAS_ = 'Anomalias';
        INCIDENCIAS_ = 'Incidencias';
        LICENCIA_APP = 'NUMAPP';
        LICENCIA_SERV = 'NUMSER';
        TIPO_ = 'TIPO';
        ES_IN_ = 'ES_IN';
        ES_OUT_ = 'ES_OUT';
        VER_EURO_ = 'VER_EURO';

        ESCAJA_ = 'EsCaja';
        NROCAJA_ = 'NroCaja';
        BAUDRATE_ = 'BaudRate';
        PORTNUMBER_ = 'PortNumber';
        PRINTER_ = 'CONTROLADOR';
        NCCF_ = 'NCCF';
        DATOSPADRON_ = 'DATOSPADRON';

        CONSOLA_VALUE  = 'CONSOLA';
        SERVIDOR_VALUE = 'SERVIDOR';
        SERVICON_VALUE = 'SERVICON';

        {$IFDEF SIMPRESION}
        NOMBRE_PROYECTO = 'SERVIDOR DE IMPRESION (Estaciones)';
        VERSION_PROYECTO = ' v. D7 ';
        ESTADO = '(C) ';
        VERSION_ENTREGA = 2.5;
        VERSION = ' Version: 5.5.2 15/05/2015';
        FECHA_VERSION = '15/05/2015';
        LITERAL_VERSION = NOMBRE_PROYECTO + VERSION_PROYECTO + ESTADO + FECHA_VERSION;
        LOGS_KEY = LOGS_ + '\IMP';
        DIRECTAS_VALUE = 'Directas';
        DIFERIDAS_VALUE = 'Diferidas';
        SUPERIOR_VALUE = 'Superior';
        IZQUIERDO_VALUE = 'Izquierdo';
        NAME_VALUE = 'Nombre';
        BANDEJA_VALUE = 'Bandeja';
        APP_TITLE = 'Servidor de Impresion';
       {$ENDIF}


        {$IFDEF SESCRITURA}
          NOMBRE_PROYECTO = 'SERVIDOR DE ESCRITURA (Estaciones)';
          VERSION_PROYECTO = ' v. D7 ';
          ESTADO = '(Operativa) ';
          VERSION_ENTREGA = 2.5;
          VERSION = ' 1.0.8';
          FECHA_VERSION = '29/09/2016';
          LITERAL_VERSION = NOMBRE_PROYECTO + VERSION_PROYECTO + ESTADO + FECHA_VERSION;
          LOGS_KEY = LOGS_ + '\WRI';
          APP_TITLE = 'Servidor de Escritura';
       {$ENDIF}

       {$IFDEF SLECTURA}
          NOMBRE_PROYECTO = 'SERVIDOR DE LECTURA (Estaciones)';
          VERSION_PROYECTO = ' v. D7 ';
          ESTADO = '(Operativa) ';
          VERSION_ENTREGA = 2.5;
          VERSION = '- Version: 5.5.2';
          FECHA_VERSION = '04/03/2013';
          LITERAL_VERSION = NOMBRE_PROYECTO + VERSION_PROYECTO + ESTADO + FECHA_VERSION;
          LOGS_KEY = LOGS_ + '\REA';
          APP_TITLE = 'Servidor de Lectura';
        {$ENDIF}

        {$IFDEF SAG98}
          NOMBRE_PROYECTO = 'SAG.® 2016 ';
          VERSION = 'Ver 1.3.3.2';
          VERSION_PROYECTO = '1.3.3';
          ESTADO = ' ';
          VERSION_ENTREGA = 3.00;

      

          FECHA_VERSION = '12/07/2017';

          LITERAL_VERSION = NOMBRE_PROYECTO + VERSION_PROYECTO + ESTADO + FECHA_VERSION;
          LOGS_KEY = LOGS_+'\APP';
        {$ENDIF}

        {$IFDEF SLG98}
        NOMBRE_PROYECTO = 'SLG.® 2004 ';
        VERSION_PROYECTO = ' 1.03 ';
        ESTADO = '(C) ';
        VERSION_ENTREGA = 1;
        FECHA_VERSION = '22/01/2004';
        LITERAL_VERSION = NOMBRE_PROYECTO + VERSION_PROYECTO + ESTADO + FECHA_VERSION;
        LOGS_KEY = LOGS_+'\SLG';
        {$ENDIF}

        {$IFDEF SAT98}
        NOMBRE_PROYECTO = 'Satelite® 98 (PVM)';
        VERSION_PROYECTO = ' v. 1.01 ';
        ESTADO = '(Alfa) ';
        VERSION_ENTREGA = 1.0;
        FECHA_VERSION = '08/09/1998';
        LITERAL_VERSION = NOMBRE_PROYECTO + VERSION_PROYECTO + ESTADO + FECHA_VERSION;
        LOGS_KEY = LOGS_+'\APP';
        {$ENDIF}

    var
        InitializationError : boolean = FALSE;

    const
        FILE_NAME = 'UVERSION.PAS';

implementation

end.














