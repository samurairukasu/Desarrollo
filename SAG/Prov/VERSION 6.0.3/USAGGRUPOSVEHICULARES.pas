unit USagGruposVehiculares;

interface

    uses
        SysUtils,
        SqlExpr,
        Classes,
        USAGCLASSES;

    type

        ttGVehiculares = (gEspecie, gDestino);

        TGVehiculares = class(TSagLegislado)
        protected
            fGrupo : string;

        public
            constructor Create (const aBD : TSQLConnection; const aTipo : ttGVehiculares);
        end;

        TGVehicularesEspecie = class (TGVehiculares)
        public
            constructor Create (const aBD : TSQLConnection);
        end;

        TGVehicularesDestino = class (TGVehiculares)
        public
            constructor Create (const aBD : TSQLConnection);
        end;

implementation

    uses
        UCDialgs;
    const

        TIPO_GRUPO : array [gEspecie..gDestino] of string = ('E', 'D');
        TABLA_GRUPOS_DE_VEHICULOS = 'TGRUPOTIPOS';

    constructor TGVehiculares.Create(const aBD : TSQLConnection; const aTipo : ttGVehiculares);
    begin
        fGrupo := TIPO_GRUPO[aTipo];
        inherited CreateFromDataBase(aBD, TABLA_GRUPOS_DE_VEHICULOS, Format ('WHERE ESPEDEST = ''%S'' ORDER BY GRUPOTIP',[fGrupo]));
    end;

    constructor TGVehicularesEspecie.Create(const aBD : TSQLConnection);
    begin
        inherited Create(aBD, gEspecie);
    end;

    constructor TGVehicularesDestino.Create(const aBD : TSQLConnection);
    begin
        inherited Create(aBD, gDestino);
    end;


end.
