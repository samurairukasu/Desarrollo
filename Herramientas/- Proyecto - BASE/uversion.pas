unit UVERSION;

interface

    const

        APPLICATION_NAME = 'PROYECTO';

        APPLICATION_KEY = '\SOFTWARE\Wow6432Node\'+APPLICATION_NAME;
        BD_KEY = APPLICATION_KEY+'\BD';
        LOGS_ = APPLICATION_KEY+'\LOGS';
        LOGS_KEY = LOGS_+'\APP';

        ALIAS_ = 'Alias';
        USER_  = 'User';
        PASSWORD_ = 'Password';
        DRIVERNAME_ = 'Drivername';
        LIBRARYNAME_ = 'Libraryname';
        VENDORLIB_ = 'vendorlib';
        GETDRIVERFUNC_ = 'GetDriverFunc';
        TRAZAS_ = 'Trazas';
        MASCARA_ = 'Mascara';
        ANOMALIAS_ = 'Anomalias';
        INCIDENCIAS_ = 'Incidencias';

        NOMBRE_PROYECTO = 'PROYECTO � 2019';
        VERSION_PROYECTO = ' 1.00 ';
        ESTADO = '(C.C) ';
        VERSION_ENTREGA = 1;
        FECHA_VERSION = '28/01/2019';
        LITERAL_VERSION = NOMBRE_PROYECTO + VERSION_PROYECTO + ESTADO + FECHA_VERSION;

    var
        InitializationError : boolean = FALSE;

implementation

end.
