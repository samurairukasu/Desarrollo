unit UVERSION;

interface

    const

        APPLICATION_NAME = 'SAGVTV';
        COMPANY_NAME = 'CISA';

        APPLICATION_KEY = '\SOFTWARE\'+COMPANY_NAME+'\'+APPLICATION_NAME;
        BD_KEY = APPLICATION_KEY+'\BD';

        ALIAS_ = 'Alias';
        USER_  = 'User';
        PASSWORD_ = 'Password';
        ALIAS2_ = 'Alias2';
        USER2_  = 'User2';
        PASSWORD2_ = 'Password2';
        ALIAS3_ = 'Alias3';
        USER3_  = 'User3';
        PASSWORD3_ = 'Password3';
        ALIASchile_ = 'AliasChile';
        USERchile_  = 'UserChile';
        PASSWORDchile_ = 'PasswordChile';

        USERPROV_  = 'UserProv';
        PASSWORDPROV_ = 'PasswordProv';
        LICENCIA_APP = 'NUMAPP';
        LICENCIA_SERV = 'NUMSER';
        TIPO_ = 'TIPO';
        DRIVERNAME_ = 'Drivername';
        LIBRARYNAME_ = 'Libraryname';
        VENDORLIB_ = 'vendorlib';
        GETDRIVERFUNC_ = 'GetDriverFunc';

        NOMBRE_PROYECTO = 'ISOStat ® 2012';
        VERSION_PROYECTO = ' v. 6';
        ESTADO = ' ';
        VERSION_ENTREGA = ' 6.00 ' ;
        FECHA_VERSION = '16/04/2013';
        LITERAL_VERSION = NOMBRE_PROYECTO + VERSION_PROYECTO + ESTADO + FECHA_VERSION;

    var
        InitializationError : boolean = FALSE;

implementation

end.
