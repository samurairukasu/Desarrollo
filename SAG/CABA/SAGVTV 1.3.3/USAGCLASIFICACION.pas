unit USagClasificacion;

interface

    uses
        SysUtils,
        Forms,
        Classes,
        USAGCLASSES,
        sqlexpr;

    type
        ttGVehiculares = (gEspecie, gDestino);

        TTiposVehiculares = class(TSagLegislado)
        public
            constructor CreateByTipo(const aBD : TSQLConnection; const aTipo: integer);
            constructor Create(const aBD: TSQLConnection; const asFilter: string);
            constructor CreateEdit(const aBD: TSQLConnection);
        end;

        TGrupoVehiculos = class(TSagLegislado)
        public
            constructor Create(const aBD: TSQLConnection; const asFilter: string);
        end;

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


        TClasificacion = class(TSagLegislado)
        private
            fName : string;
        public
            constructor Create(const aBD : TSQLConnection; const aTable, aName : string);
            property Nombre : string read fName;
            procedure FiltraPorCodigo (const sCode: string);
            procedure FiltraPorGrupo(const sCode: string);
        end;


        TFrecuencia = class (TClasificacion)
        public
            constructor CreateByCode (aBD: TSQLConnection; const aCodigo: integer);
        end;


        TTDestinos = class(TClasificacion)
        public
            constructor Create(const aBD : TSQLConnection);
            constructor CreateByTipo (const aBD: TSQLConnection; sTipo: string);
        end;

        TTEspecies = class(TClasificacion)
        public
            constructor Create(const aBD : TSQLConnection);
            constructor CreateByTipo (const aBD: TSQLConnection; sTipo: string);
        end;


implementation

    uses
        ULOGS,
        USAGESTACION;

    resourcestring
        FILE_NAME = 'USAGCLASIFICACION.PAS';

    const

        TIPO_GRUPO : array [gEspecie..gDestino] of string = ('E', 'D');


    constructor TFrecuencia.CreateByCode (aBD: TSQLConnection; const aCodigo: integer);
    begin
        inherited CreateFromDataBase(aBD, DATOS_FRECUENCIA, Format ('WHERE CODFRECU = %d',[aCodigo]));
    end;

    constructor TTiposVehiculares.CreateByTipo(const aBD : TSQLConnection; const aTipo: integer);
    begin
        inherited CreateFromDataBase(aBD, DATOS_TIPOS_DE_VEHICULOS, Format ('WHERE TIPOVEHI = %d',[aTipo]));
    end;

    constructor TTiposVehiculares.CreateEdit(const aBD: TSQLConnection);
    begin
        inherited CreateFromDataBase(aBD, DATOS_TIPOS_DE_VEHICULOS, '');
    end;

    constructor TTiposVehiculares.Create(const aBD: TSQLConnection; const asFilter: string);
    begin
        inherited CreateFromDataBase(aBD, DATOS_TIPOS_DE_VEHICULOS, asFilter);
    end;


    constructor TGVehiculares.Create(const aBD : TSQLConnection; const aTipo : ttGVehiculares);
    begin
        fGrupo := TIPO_GRUPO[aTipo];
        inherited CreateFromDataBase(aBD, DATOS_GRUPOS_DE_VEHICULOS, Format ('WHERE ESPEDEST = ''%S'' ORDER BY GRUPOTIP',[fGrupo]));
    end;

    constructor TGVehicularesEspecie.Create(const aBD : TSQLConnection);
    begin
        inherited Create(aBD, gEspecie);
    end;

    constructor TGVehicularesDestino.Create(const aBD : TSQLConnection);
    begin
        inherited Create(aBD, gDestino);
    end;

    constructor TClasificacion.Create(const aBD : TSQLConnection; const aTable, aName : string);
    begin
        fName := aName;
        inherited CreateFromDataBase(aBD, aTable, Format('ORDER BY %s',[fName]));
    end;

    procedure TClasificacion.FiltraPorGrupo(const sCode: string);
    begin
        if sCode <> ''
        then Filter := Format('WHERE GRUPOTIP = %S ORDER BY %S',[sCode,Nombre]);
    end;

    procedure TClasificacion.FiltraPorCodigo(const sCode: string);
    var
        aQ : TSQLQuery;
        sFil : String;
    begin
        if sCode <> ''
        then begin
            try
                aQ := TSQLQuery.Create(Application);
                with aQ do
                try
                    SQLConnection := fSagBD;

  { TODO -oran -ctransacciones : Ver tema sesion }

                    SQL.Add (Format('SELECT GRUPOTIP FROM %S WHERE %S = %S',[fTableName,Nombre,sCode]));

                    {$IFDEF TRAZAS}
                    fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'Selección del grupo');
                    fTrazas.PonComponente(TRAZA_SQL,1,FILE_NAME,aQ);
                    {$ENDIF}

                    aQ.Open;

                    {$IFDEF TRAZAS}
                    fTrazas.PonRegistro(TRAZA_SQL,1,FILE_NAME,aQ);
                    {$ENDIF}

                    if aQ.RecordCount > 0  Then begin
                        sFil := Format('WHERE GRUPOTIP = %S ORDER BY %S',[aQ.Fields[0].AsString, Nombre]);
                        self.Filter := sFil;
                    End;
                finally
                    aQ.Close;
                    aQ.Free;
                end

            except
                on E: Exception do
                begin
                    fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error Filtrando doblemente por: %s',[E.message]);
                    raise;
                end
            end;
        end;
    end;

    constructor TTEspecies.Create(const aBD : TSQLConnection);
    begin
        inherited Create(aBD, DATOS_TIPOS_DE_ESPECIE, FIELD_ESPECIE)
    end;

    constructor TTEspecies.CreateByTipo (const aBD: TSQLConnection; sTipo: string);
    begin
        inherited CreateFromDataBase(aBD, DATOS_TIPOS_DE_ESPECIE, Format ('WHERE TIPOESPE = %s',[sTipo]));
    end;


    constructor TTDestinos.Create(const aBD : TSQLConnection);
    begin
        inherited Create(aBD, DATOS_TIPOS_DE_DESTINO, FIELD_DESTINO)
    end;

    constructor TTDestinos.CreateByTipo (const aBD: TSQLConnection; sTipo: string);
    begin
        inherited CreateFromDataBase(aBD, DATOS_TIPOS_DE_DESTINO, Format ('WHERE TIPODEST = %s',[sTipo]));
    end;


    constructor TGrupoVehiculos.Create(const aBD: TSQLConnection; const asFilter: string);
    begin
        inherited CreateFromDataBase(aBD, DATOS_GRUPOSVEHICULOS, asFilter);
    end;

end.


