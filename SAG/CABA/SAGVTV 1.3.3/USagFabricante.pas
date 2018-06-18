unit USagFabricante;

interface

        uses
            Classes,
            USAGCLASSES,
            sqlexpr,
            forms;

        type
            TSagFabricante = class(TSagGeneral)
            private
                fNombre : string;
            public
                constructor Create (const aBD : TSQLConnection; const aTable : string; const aName : string; const aFilter : string);
                property Nombre : string read fNombre;
            end;

            
            TMarcas = class(TSagFabricante)
            public
                constructor Create (const aBD : TSQLConnection; const aFilter: string);
            end;

            TModelos = class(TSagFabricante)
            private
                fMarca : string;
                fCodMarca : integer;
                function GetMarca: string;
            public
                constructor Create (const aBD : TSQLConnection);
                constructor CreateByCode (const aBD: TSQLConnection; const aCode: integer);
                constructor CreateByMarca (const aBD: TSQLConnection; const aCode: integer);
                property Marca_: string read GetMarca;
                property Marca: string read fMarca write fMarca;
                property CodMarca : integer read fCodMarca write fCodMarca;
            end;

implementation

    uses
        SysUtils,
        USAGESTACION;

    constructor TSagFabricante.Create (const aBD : TSQLConnection; const aTable : string; const aName : string; const aFilter : string);
    begin
        inherited CreateFromDataBase (aBD, aTable, Format('%s ORDER BY %S', [aFilter, aName]));
        fNombre := aName;
    end;

    constructor TMarcas.Create(const aBD : TSQLConnection; const aFilter: string);
    begin
        inherited Create(aBD, DATOS_MARCAS, FIELD_NOMMARCA, aFilter)
    end;

    constructor TModelos.Create(const aBD : TSQLConnection);
    begin
        fMarca := '';
        fCodMarca := -1;
        inherited Create(aBD, DATOS_MODELOS, FIELD_NOMMODEL, '')
    end;

    constructor TModelos.CreateByCode (const aBD: TSQLConnection; const aCode: integer);
    begin
        inherited CreateFromDatabase (aBD, DATOS_MODELOS, Format('WHERE %s=%d',[FIELD_CODMODEL, aCode]));
    end;

    constructor TModelos.CreateByMarca (const aBD: TSQLConnection; const aCode: integer);
    begin
        inherited CreateFromDatabase (aBD, DATOS_MODELOS, Format('WHERE %s=%d',[FIELD_CODMARCA, aCode]));
    end;

    function TModelos.GetMarca: string;
    begin
        result := '';
        Open;
        with TSQLQuery.Create(application) do
        try

         { TODO -oran -cquedo asi !!!! : Ver tema coneccion !!!! }

            sqlconnection := tsqlconnection.create(application);

            SQL.Add(Format('SELECT NOMMARCA FROM TMARCAS WHERE CODMARCA = %S',[ValueByName[FIELD_CODMARCA]]));
            Open;
            Result := Fields[0].AsString;
        finally
            Close;
            Free;
        end;
    end;

end.//final de la unidad
