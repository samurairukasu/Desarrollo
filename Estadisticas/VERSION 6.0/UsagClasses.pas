{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE ON}
{$WARN UNSAFE_CODE ON}
{$WARN UNSAFE_CAST ON}
unit UsagClasses;

interface

    uses
        DBXpress, dbclient,provider,SqlExpr,
        SysUtils,
        Classes,
        Controls,
        USAGDATA,
        USAGESTACION,
        USUPERREGISTRY,
        Windows,
        UVERSION,
        UCDIALGS;

    type

        {Cabeceras de las clases utilizadas para las tablas del sistema}

        tEstadisticas = Class(TSagData);

         TSagDescuento = class(TSagData);
         tDescuento = class;
        TSagSeries_Encuestas = class(TSagData);
              TSeries_Encuestas = class;
        TSagPreguntas_Encuestas = class(TSagData);
              TPreguntas_Encuestas = class;

          TSagDatos_CDVTV = class(TSagData);
              TDatos_CDVTV = class;

        tplantas = class (tEstadisticas)
        private
        public
              constructor CreateP (const aBD : TSQLConnection);
              constructor CreatePlantas (const aBD : TSQLConnection);
        end;

        tZonas = class (tEstadisticas)
        private
        public
              constructor Create (const aBD : TSQLConnection);
        end;

        TDescuento = class (TSagDescuento)
        private
        public
              constructor Create (aBD : TSQLConnection);
              constructor CreateFromCoddescu(aBD : TSQLConnection; const aCoddescu: string);
              constructor CreateBySysDate(aBD : TSQLConnection);
              constructor CreateConFechas(aBD : TSQLConnection; aDateIni, aDateFin: string);
        end;

        TSeries_Encuestas = class(TSagSeries_Encuestas)
        private
               function GetSerie: string;
               function GetNOM_F_IMPR: string;
        public
              constructor CreateByFecha (aBD : TSQLConnection; aFecha: string);
              property serie : string read GetSerie;
              property Nom_F_Impr : string read GetNOM_F_IMPR;
        end;

        TPreguntas_Encuestas = class(TSagPreguntas_Encuestas)
        private
               function GetNroPregunta : string;
               function GetAbrevia : string;
        public
              constructor CreateBySerie(aBD : TSQLConnection; aserie: string);
              property NroPregunta : string read getNroPregunta;
              property Abrevia : string read GetAbrevia;
        end;

        TDatos_CDGNC = class (tEstadisticas)
        private
        public
              constructor Create (const aBD : TSQLConnection);
              constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
        end;

        TAnuladasGNC = class (tEstadisticas)
        private
        public
              constructor Create (const aBD : TSQLConnection);
              constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
        end;

        tInsp_Provincia = class (tEstadisticas)
        private
        public
              constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
        end;

        TDatos_CDVTV = class (TSagDatos_CDVTV)
        private
        public
              constructor Create (const aBD : TSQLConnection);
              constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
        end;

        tObleas_VTV = class (tEstadisticas)
        private
        public
              constructor CreateByNumero(const aBD : TSQLConnection; const aNumero: string);
        end;

        tObleas_GNC = class (tEstadisticas)
        private
        public
              constructor CreateByNumero(const aBD : TSQLConnection; const aNumero: string);
        end;

        tResumen_Mensual = class (tEstadisticas)
        private
        public
              constructor CreateByMes(const aBD : TSQLConnection; const aMes: string);
        end;


    implementation

    uses
        GLOBALS,
//        ULOGS,
        UTILORACLE;



constructor TDEscuento.Create (aBD: TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_DESCUENTOS,'');
end;

constructor TDEscuento.CreateFromCoddescu(aBD: TSQLConnection; const aCoddescu: string);
begin
    inherited CreateFromDataBase (aBD,DATOS_DESCUENTOS,Format('WHERE %S = ''%S''',[FIELD_CODDESCU, aCodDescu]));
end;

constructor TDEscuento.CreateBySysDate(aBD: TSQLConnection);
begin
      inherited CreateFromDataBase (aBD,DATOS_DESCUENTOS,'WHERE FECVIGINI <= SYSDATE AND FECVIGFIN >= SYSDATE OR (FECVIGINI <= SYSDATE AND FECVIGFIN IS NULL)');
end;

constructor TDEscuento.CreateConFechas(aBD : TSQLConnection; aDateIni, aDateFin: string);
begin
      inherited CreateFromDataBase (aBD,DATOS_DESCUENTOS,format('WHERE EMITENC = ''N'' AND ( FECVIGINI <= TO_DATE(''%S'',''dd/mm/yyyy hh24:mi:ss'') AND (FECVIGINI >= TO_DATE(''%S'',''dd/mm/yyyy hh24:mi:ss'') OR (FECVIGFIN >= TO_DATE(''%S'',''dd/mm/yyyy hh24:mi:ss'') OR FECVIGFIN IS NULL)))',[adatefin, adateini, adateini]))
end;

(******************************************************************************)
(*                                                                            *)
(*                               TSeries_Encuestas                            *)
(*                                                                            *)
(******************************************************************************)

constructor TSeries_Encuestas.CreateByFecha(aBD : TSQLConnection; aFecha: string);
begin
    with tsqlquery.Create(nil) do
     try
       SqlConnection:= mybd;
       sql.add('alter session set nls_date_format = ''dd/mm/yyyy''');
       execsql;
     finally
       free;
     end;
    inherited CreateFromDataBase (aBD,DATOS_SERIES_ENCUESTAS,format('WHERE (''%s'' BETWEEN FECHA_INICIO AND FECHA_FIN) OR (''%S'' >= FECHA_INICIO AND FECHA_FIN IS NULL)',[aFecha, aFecha]));
end;

function TSeries_Encuestas.GetSerie: string;
begin
  result := ValueByName[FIELD_SERIE];
end;

function TSeries_Encuestas.GetNOM_F_IMPR: string;
begin
  result := ValueByName[FIELD_NOM_F_PREG];
end;

(******************************************************************************)
(*                                                                            *)
(*                               TPreguntas_Encuestas                         *)
(*                                                                            *)
(******************************************************************************)

constructor TPreguntas_Encuestas.CreateBySerie(aBD : TSQLConnection; aserie: string);
begin
    inherited CreateFromDataBase (aBD,DATOS_PREGUNTAS_ENCUESTAS,format('WHERE SERIE = %S',[aSerie]));
end;

function TPreguntas_Encuestas.GetNroPregunta : string;
begin
  result := ValueByName[FIELD_NROPREGUNTA];
end;

function TPreguntas_Encuestas.GetAbrevia : string;
begin
  result := ValueByName[FIELD_ABREVIA];
end;

{ TDatos_CD }

constructor TDatos_CDGNC.Create(const aBD : TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_CD_GNC,'');
end;

constructor TDatos_CDGNC.CreateByRowId(const aBD : TSQLConnection;
  const aRowId: string);
begin
   inherited CreateFromDataBase (aBD,DATOS_CD_GNC,Format('WHERE ROWID = ''%S''',[aRowId]));
end;

{ TAnuladas }

constructor TAnuladasGNC.Create(const aBD : TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_ANULADAS,'');
end;

constructor TAnuladasGNC.CreateByRowId(const aBD : TSQLConnection;
  const aRowId: string);
begin
   inherited CreateFromDataBase (aBD,DATOS_ANULADAS,Format('WHERE ROWID = ''%S''',[aRowId]));
end;

{ tDatos_Inspecciones }

constructor tInsp_Provincia.CreateByRowId(const aBD : TSQLConnection;
  const aRowId: string);
begin
   inherited CreateFromDataBase (aBD,DATOS_INSP_PROVINCIA,Format('WHERE ROWID = ''%S''',[aRowId]));
end;

{ TDatos_CDVTV }

constructor TDatos_CDVTV.Create(const aBD : TSQLConnection);
begin
   inherited CreateFromDataBase (aBD ,DATOS_CD_VTV,'');
end;

constructor TDatos_CDVTV.CreateByRowId(const aBD : TSQLConnection;
  const aRowId: string);
begin
   inherited CreateFromDataBaseAG (aBD,DATOS_CD_VTV,Format('WHERE ROWID = ''%S''',[aRowId]));
end;

{ tObleas_VTV }

constructor tObleas_VTV.CreateByNumero(const aBD : TSQLConnection;
  const aNumero: string);
begin
   inherited CreateFromDataBaseAG (aBD,DATOS_OBLEAS_VTV,Format('WHERE NUMERO = %S ',[aNumero]));
end;

{ tObleas_GNC }

constructor tObleas_GNC.CreateByNumero(const aBD : TSQLConnection;
  const aNumero: string);
begin
   inherited CreateFromDataBase (aBD,DATOS_OBLEAS_GNC,Format('WHERE NUMERO = %S ',[aNumero]));
end;

{ tplantas }

constructor tplantas.createP(const aBD : TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_TPLANTAS,'WHERE TIPO = ''P''');
end;

constructor tplantas.CreatePlantas(const aBD : TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_PLANTAS,'WHERE TIPO IN (''P'',''M'') order by idzona, nroplanta');
end;

{ tZonas }

constructor tZonas.Create(const aBD : TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_ZONAS,'');
end;

{ tResumen_Mensual }

constructor tResumen_Mensual.CreateByMes(const aBD : TSQLConnection;
  const aMes: string);
begin
    inherited CreateFromDataBase (aBD,DATOS_REPORTE_MENSUAL,format('WHERE MES = %S ORDER BY ANIO, MES, ZONA, PLANTA',[aMes]));
end;

end.//Final de la unidad
