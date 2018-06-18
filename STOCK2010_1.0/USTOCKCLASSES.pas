unit UstockClasses;

interface

    uses
         DB,
        DBClient,
        Provider,
        DBXpress,
        SqlExpr,
        SysUtils,
        Classes,
        Controls,
        USTOCKDATA,
        USTOCKESTACION,
        USUPERREGISTRY,
        Windows,
        UVERSION,
        UCDIALGS;

    type

    {
        Cabeceras de todas las clases utilizadas en el Sistema de Stock así como aquellas
        clases principales que puedan tener relaciones entre ellas.
    }


        TStockObleas = class(TSagData);


        tPlantas = class (TStockObleas)
        private
        public
              constructor Create (const aBD: TSQLConnection);
              constructor CreateDepositos (const aBD: TSQLConnection);
              constructor CreatePlantas (const aBD: TSQLConnection);
              constructor CreatePlantasVTV (const aBD: TSQLConnection);
              constructor CreateById(const aBD: TSQLConnection; aIdPlanta : string);
        end;

        tEmpresas = class (TStockObleas)
        private
        public
              constructor Create (const aBD: TSQLConnection);
        end;

        tProveedores = class (TStockObleas)
        private
        public
              constructor Create (const aBD: TSQLConnection);
        end;

        tLocalidad_interior = class (TStockObleas)
        private
        public
        end;

        tCodposta_interior= class (TStockObleas)
        private
        public
        end;

        tCodposta_capital= class (TStockObleas)
        private
        public
        end;

        tProvincias= class (TStockObleas)
        private
        public
        end;

        tMovimientos= class (TStockObleas)
        private
        public
            constructor CreateByRowId(const aBD: TSQLConnection; const aRowId: string);
        end;

        tMovimientos_VTV= class (TStockObleas)
        private
        public
            constructor CreateByRowId(const aBD: TSQLConnection; const aRowId: string);
        end;

        tMovimientos_Informe= class (TStockObleas)
        private
        public
            constructor CreateByRowId(const aBD: TSQLConnection; const aRowId: string);
        end;

        tInfor_Certif= class (TStockObleas)
        private
        public
            constructor CreateByRowId(const aBD: TSQLConnection; const aRowId: string);
        end;
        tObleas= class (TStockObleas)
        private
        public
        end;

        tColores= class (TStockObleas)
        private
        public
        end;

        tPersonal = class (TStockObleas)
        private
        protected
            function GetCalculatedValueByName (Index: string) : string; Override;
        public
            constructor Create (const aBD: TSQLConnection);
        end;

        tzonas = class (TStockObleas)
        private
        public
            constructor Create (const aBD: TSQLConnection);
        end;

    implementation

    uses
        GLOBALS,
        ULOGS,
        UTILORACLE;

    const
        FILE_NAME = 'USTOCKCLASSES.PAS';


{ tProveedores }

constructor tProveedores.Create(const aBD: TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_PROVEEDORES,'');
end;

{ tPlantas }

constructor tPlantas.Create(const aBD: TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_PLANTAS,'');
end;

constructor tPlantas.CreateById(const aBD: TSQLConnection; aIdPlanta: string);
begin
    inherited CreateFromDataBase (aBD,DATOS_PLANTAS,format('WHERE IDPLANTA = %S',[aIdPlanta]));
end;

constructor tPlantas.CreateDepositos(const aBD: TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_PLANTAS,'WHERE TIPO = ''D''');
end;

constructor tPlantas.CreatePlantas(const aBD: TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_PLANTAS,'WHERE TIPO = ''P''');
end;

constructor tPlantas.CreatePlantasVTV(const aBD: TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_PLANTAS,'WHERE TIPO IN (''P'',''M'') ORDER BY NOMBRE');
end;

{ tEmpresas }

constructor tEmpresas.Create(const aBD: TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_EMPRESAS,'');
end;

{ tMovimientos }

constructor tMovimientos.CreateByRowId(const aBD: TSQLConnection;
  const aRowId: string);
begin
        inherited CreateFromDataBase (aBD,DATOS_MOVIMIENTOS,Format('WHERE ROWID = ''%S''',[aRowId]));
end;

{ tPersonal }

constructor tPersonal.Create(const aBD: TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_PERSONAL,'');
end;

function tPersonal.GetCalculatedValueByName(Index: string): string;
begin
        If Index=FIELD_NOMBRE_Y_APELLIDOS
        Then
            Result:=Format ('%s %s',[ValueByName[FIELD_NOMBRE], ValueByName[FIELD_APELLIDO]]);
        result := Trim(result);
end;

{ tMovimientos_VTV }

constructor tMovimientos_VTV.CreateByRowId(const aBD: TSQLConnection;
  const aRowId: string);
begin
        inherited CreateFromDataBase (aBD,DATOS_MOVIMIENTOS_VTV,Format('WHERE ROWID = ''%S''',[aRowId]));
end;

{ tMovimientos_Informe }

constructor tMovimientos_Informe.CreateByRowId(const aBD: TSQLConnection;
  const aRowId: string);
begin
        inherited CreateFromDataBase (aBD, DATOS_MOVIMIENTOS_INFORME ,Format('WHERE ROWID = ''%S''',[aRowId]));
end;


{ tInfor_Certif }

constructor tInfor_Certif.CreateByRowId(const aBD: TSQLConnection;
  const aRowId: string);
begin
        inherited CreateFromDataBase (aBD, DATOS_INFOR_CERTIF ,Format('WHERE ROWID = ''%S''',[aRowId]));
end;

{ tZonas }

constructor tZonas.Create(const aBD: TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_ZONAS,'');
end;

end.//Final de la unidad
