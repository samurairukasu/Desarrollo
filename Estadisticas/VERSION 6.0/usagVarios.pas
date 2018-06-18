unit USagVarios;

interface

    uses
        sqlexpr,
        USAGDATA,
        Classes;

    type

        TVarios = class(TSagData)
        private
            function GetCarry : integer;
            function GetCodeEstacion: integer;
            function GetZona: integer;
            function GetNombreEstacion: string;
            function GetResponsable: string;
            function GetPorcentaje: double;
            function GetIVAInscripto: double;
            function GetIVANoInscripto: double;
            function GetCUIT: string;
            function GetTelefono: string;
            function GetFax: string;
            function GetDireccion: string;
            function GetCodigoPostal: string;
            function GetLocalidad: string;
            function GetCodProvi: integer;
            function GetHoraInicio: tDateTime;
            function GetHoraFin: tDateTime;
            procedure SetHoraInicio (aFecha: tDateTime);
            procedure SetHoraFin (aFecha: tDateTime);
            function GetTarifaBasica: double;
            function GetCanon: double;
            function GetActivarVoluntarias: string;
            function GetActivarGratuitas: string;
            function GetActivarPreverificaciones: string;
            function GetActivarDescuentos: string;  //AGRE RAN
            function GetGuardarInspecciones: string;
            function GetPermitirStandBy: string;
            function GetNumOblea: integer;
            function GetNumObleaB: integer;
            function GetHorasCorrectas: boolean;
            function GetLimiteEncuestas: string; //AGRE RAN
        public
            constructor Create(const aBD : tSQLConnection);
            property Carry: integer read GetCarry;
            property CodeEstacion: integer read GetCodeEstacion;
            property Zona: integer read GetZona;

            property NombreEstacion: string read GetNombreEstacion;
            property Responsable: string read GetResponsable;
            property Porcentaje: double read GetPorcentaje;
            property IVAInscripto: double read GetIVAInscripto;
            property IVANoInscripto: double read GetIVANoInscripto;
            //property UltimoCierre: tDateTime read GetUlimoCierre;
            property CUIT: string read GetCUIT;
            property Telefono: string read GetTelefono;
            property Fax: string read GetFax;
            property Direccion: string read GetDireccion;
            property CodigoPostal: string read GetCodigoPostal;
            property Localidad: string read GetLocalidad;
            property CodProvi: integer read GetCodProvi;
            property HoraInicio: tDateTime read GetHoraInicio write SetHoraInicio;
            property HoraFin: tDateTime read GetHoraFin write SetHoraFin;
            property TarifaBasica: double read GetTarifaBasica;
            property Canon: double read GetCanon;
            property ActivarVoluntarias: string read GetActivarVoluntarias;
            property ActivarGratuitas: string read GetActivarGratuitas;
            property ActivarPreverificaciones: string read GetActivarPreverificaciones;
            property ActivarDescuentos: string read GetActivarDescuentos;   //AGRE RAN
            property GuardarInspecciones: string read GetGuardarInspecciones;
            property PermitirStandBy: string read GetPermitirStandBy;
            property NumOblea: integer read GetNumOblea;
            property NumObleaB: integer read GetNumObleaB;
            // True si HoraFin es >= HoraInicio
            property HorasCorrectas: boolean read GetHorasCorrectas;
            property LimiteEncuestas: string read GetLimiteEncuestas; //AGRE RAN
        end;

    ResourceString
    
        OP_ACTIVA = 'S';
        OP_INACTIVA = 'F';
        OP_INACTIVA_N = 'N'; //AGRE RAN, PARA USAR CON S/N EN LUGAR DE S/F


implementation

    uses
        USAGESTACION,
        SysUtils;

    resourcestring

        FILE_NAME = 'USAGVARIOS.PAS';


    constructor TVarios.Create(const aBD : tSQLConnection);
    begin
        inherited CreateFromDataBase(aBD, DATOS_VARIOS ,'');
    end;


    function TVarios.GetCarry : integer;
    begin
        if not Active
        then Open;
        result := StrToInt(ValueByName[FIELD_CARRY])
    end;

    function TVarios.GetCodeEstacion: integer;
    begin
        if not Active
        then Open;
        result := StrToInt(ValueByName[FIELD_ESTACION])
    end;

    function TVarios.GetZona: integer;
    begin
        if not Active
        then Open;
        result := StrToInt(ValueByName[FIELD_ZONA])
    end;

    function TVarios.GetNombreEstacion: string;
    begin
        if not Active
        then Open;
        result := ValueByName[FIELD_IDENCONC]
    end;

    function TVarios.GetResponsable: string;
    begin
        if not Active
        then Open;
        result := ValueByName[FIELD_NOMRESPO]
    end;

    function TVarios.GetPorcentaje: double;
    begin
        if not Active
        then Open;
        result := StrToFloat(ValueByName[FIELD_PORCREVI])
    end;

    function TVarios.GetIVAInscripto: double;
    begin
        if not Active
        then Open;
        result := StrToFloat(ValueByName[FIELD_IVAINSCR])
    end;

    function TVarios.GetIVANoInscripto: double;
    begin
        if not Active
        then Open;
        result := StrToFloat(ValueByName[FIELD_IVANOINS])
    end;

    function TVarios.GetCUIT: string;
    begin
        if not Active
        then Open;
        result := ValueByName[FIELD_CUIT_CON]
    end;

    function TVarios.GetTelefono: string;
    begin
        if not Active
        then Open;
        result := ValueByName[FIELD_TELFCONC]
    end;

    function TVarios.GetFax: string;
    begin
        if not Active
        then Open;
        result := ValueByName[FIELD_FAXCONCE]
    end;

    function TVarios.GetDireccion: string;
    begin
        if not Active
        then Open;
        result := ValueByName[FIELD_DIRCONCE]
    end;

    function TVarios.GetCodigoPostal: string;
    begin
        if not Active
        then Open;
        result := ValueByName[FIELD_CODPOSTA]
    end;

    function TVarios.GetLocalidad: string;
    begin
        if not Active
        then Open;
        result := ValueByName[FIELD_LOCALIDA]
    end;

    function TVarios.GetCodProvi: integer;
    begin
        if not Active
        then Open;
        result := StrToInt(ValueByName[FIELD_CODPROVI])
    end;

    function TVarios.GetHoraInicio: tDateTime;
    begin
        if not Active
        then Open;
        result := StrToDateTime(ValueByName[FIELD_HOINITRA])
    end;

    function TVarios.GetHoraFin: tDateTime;
    begin
        if not Active
        then Open;
        result := StrToDateTime(ValueByName[FIELD_HOFINTRA])
    end;

    procedure TVarios.SetHoraInicio (aFecha: tDateTime);
    begin
        SetValueByName(FIELD_HOINITRA,DateTimeToStr(aFecha))
    end;

    procedure TVarios.SetHoraFin (aFecha: tDateTime);
    begin
        SetValueByName(FIELD_HOFINTRA,DateTimeToStr(aFecha))
    end;


    function TVarios.GetTarifaBasica: double;
    begin
        if not Active
        then Open;
        result := StrtoFloat(ValueByName[FIELD_TARIBASI])
    end;

    function TVarios.GetCanon: double;
    begin
        if not Active
        then Open;
        result := StrToFloat(ValueByName[FIELD_CANON])
    end;

    function TVarios.GetActivarVoluntarias: string;
    begin
        if not Active
        then Open;
        result := ValueByName[FIELD_ENA_VOL]
    end;

    function TVarios.GetActivarGratuitas: string;
    begin
        if not Active
        then Open;
        result := ValueByName[FIELD_ENA_FRE]
    end;

    function TVarios.GetActivarPreverificaciones: string;
    begin
        if not Active
        then Open;
        result := ValueByName[FIELD_ENA_PRE]
    end;

    function TVarios.GetActivarDescuentos: string;
    begin
        if Active
        then close;
        open;
        result := ValueByName[FIELD_ENA_DES]
    end;


    function TVarios.GetGuardarInspecciones: string;
    begin
        if not Active
        then Open;
        result := ValueByName[FIELD_ENA_SAV]
    end;

    function TVarios.GetPermitirStandBy: string;
    begin
        if not Active
        then Open;
        result := ValueByName[FIELD_ENA_REI]
    end;

    function TVarios.GetNumOblea: integer;
    begin
        if not Active
        then Open;
        result := StrToInt(ValueByName[FIELD_NUMOBLEA])
    end;

    function TVarios.GetNumObleaB: integer;
    begin
        if not Active
        then Open;
        result := StrToInt(ValueByName[FIELD_NUMOBLEAB])
    end;

    function TVarios.GetHorasCorrectas: boolean;
    // True si HoraFin es >= HoraInicio
    begin
        Result := (HoraFin >= HoraInicio);
    end;

    function TVarios.GetLimiteEncuestas: string;
    begin
        if not Active
        then Open;
        result := ValueByName[FIELD_LIMITE_ENCUESTA]
    end;


end.
