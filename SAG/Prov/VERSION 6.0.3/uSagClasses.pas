unit UsagClasses;

interface

    uses
        DB,
        sqlexpr,
        SysUtils,
        Forms,
        FmtBCD,
        Classes,
        Controls,
        USAGDATA,
        USAGVARIOS,
        USAGESTACION,
        USAGPRINTERS,
        USAGDOMINIOS,
        USUPERREGISTRY,
        Windows,
        UVERSION,
        UCDIALGS,
        EPSON_Impresora_Fiscal_TLB, ComObj,uconversiones, ucontstatus, uutils,
        variants,DBXpress, dbclient,provider;


    type


    {
        Cabeceras de todas las clases utilizadas en el SAG'98 así como aquellas
        clases principales que puedan tener relaciones entre ellas.
    }

            //TSagKernel = class(TSagData);
            TRevisor = Array [1..3] of String;

                TSagUsers = class(TSagKernel);

                    TGrupos = class(TSagUsers);
                    TUsuarios = class(TSagUsers);
                    TServicios = class(TSagUsers);
                    TServiciosGrupos = class(TSagUsers);
                    TServiciosUsuarios = class(TSagUsers);
                    TComponentesGrupo = class(TSagUsers);

                TSagControl = class(TSagKernel);

                    TColaDeImpresion = class(TSagControl);

            //TSagHistorico = class(TSagData);

                TCopiasSeguridad = class(TSagHistorico);

                    TBackups = class(TCopiasSeguridad);

                TEntradaSalida = class(TSagHistorico);

                    TTransferencias = class(TEntradaSalida);

            //TSagGlobal = class(TSagData);

                //TSagParameters = class(TSagData);

                    TSagDefectos = class(TSagParameters);

                        TCapitulos = class(TSagDefectos);
                        TApartados = class(TSagDefectos);
                        TDefectos = class(TSagDefectos);

                    TSagUmbrales = class(TSagParameters);

                        //TCampos = class(TSagUmbrales);

                    TSagGeografia = class(TSagParameters);

                        //TProvincias = class(TSagGeografia);
                        //TPartidos = class(TSagGeografia);

                    TSagLegislado = class(TSagParameters);

                        TTarifas = class(TSagLegislado);
                        TColores = class(TSagLegislado);
                    {*} //TGVehiculares = class(TSagLegislado);
                        //TTiposVehiculares = class(TSagLegislado);

                        //TClasificacion = class(TSagLegislado);

                        {*} //TTEspecies = class(TClasificacion);
                        {*} //TTDestinos = class(TClasificacion);

                TSagEstacion = class(TSagGlobal);

                    TSagContabilidad = class(TSagEstacion);

                        TSagCaja = class(TSagContabilidad);

                            TCaja = class(TSagCaja);
                            TCajaGastos = class(TSagCaja);

                    TSagGeneral = class(TSagEstacion);

                        //TSagFabricante = class(TSagGeneral);

                    {*}     //TMarcas = class(TSagFabricante);
                    {*}     //TModelos = class(TSagFabricante);
                    {*}
                        //TVarios = class(TSagGeneral);

                    TSagVerificaciones = class(TSagGeneral);

                        TSagVisual = class(TSagVerificaciones);

                            TDatosVisuales = class(TSagVisual);

                        TSagAutomaticos = class(TSagVerificaciones);

                            TDatosAutomaticos = class(TSagAutomaticos);
                            TResultados = class(TSagAutomaticos);

                        TSagSupervisores = class(TSagVerificaciones);

      {**************************************************************************}

                        TSagInspeccion = class;
                            TInspeccion= class;
                            TEstadoInspeccion = class;
                            TAuditoriaStandBy = TSagInspeccion;

                        TSagFacturacion = class(TSagData);
                            TFacturacion = class;
                            TContraFacturas = class;
                        TSagVehiculos = class(TSagData);
                            TVehiculo = class;
                        TSagClientes = class(TSagData);
                            TClientes = class;
                            TTiposCliente = Class(TSagClientes);
                        TSagPtoVenta = class(TSagData);    //
                            TPtoVenta = class;
                        TSagCierreZ = class(TSagData);
                            TCierrez = class;
                        TSagFact_Adicionales = class(TSagData);
                            tFact_Adicionales = class;
                        TSagDatos_Estacion = class(TSagData);
                            tDatos_Estacion = class;
                        TSagTarjeta = class(TSagData);
                            tTarjeta = class;
                        TSagDescuento = class(TSagData);
                            tDescuento = class;
                        TSagCheque = class(TSagData);
                            tCheque = class;
                        TSagBancos = class(TSagData);
                            tBancos = class;
                        TSagSucursales = class(TSagData);
                            TSucursales = class;
                        TSagMonedas = class(TSagData);
                            TMonedas = class;
                        TSagDatosPromocion = class(TSagData);
                            TDatosPromocion = class;
                        TSagEncuestaSatisfaccion = class(TSagData);
                            TEncuestaSatisfaccion = class;
                        TSagDatInspecc = class(TSagData);
                            TDatInspecc = class;
                        TSagCambiosFecha = class(TSagData);
                            TCambiosFecha = class;
                            TCambiosFecha_gnc = class;
                        TSagMotivos_Cambios = class(TSagData);
                            TMotivos_Cambios = class;
                            TMotivos_Cambios_gnc = class;                            
                        TSagSeries_Encuestas = class(TSagData);
                            TSeries_Encuestas = class;
                        TSagPreguntas_Encuestas = class(TSagData);
                            TPreguntas_Encuestas = class;
                        TSagProvSeguros = class(TSagData);
                            TProvSeguros = class;
                        TSagCodposta_Capital = class(TSagData);
                            TCodposta_Capital = class;
                        TSagCodposta_Interior = class(TSagData);
                            TCodposta_Interior = class;
                        TSagLocalidad_Interior = class(TSagData);
                            TLocalidad_Interior = class;
                        TSagDecJurada = class(TSagData);
                            TDecJurada = class;
                        tSagDatosProvincia = class(TSagData);
                            TDatosProvincia = class;
                        tSagDatosLiquidacion = class(tSagData);
                            TBancos_Deposito = class;
                            TDepositos_liq = class;
                            TLiquidacion = class;

                        TSagGNC = class(TSagData);
                            TInspGNC = class;
                            TCentrosRPC = class;
                            TEquiposGNC = class;
                            TCilindros = class;
                            TAdicionalesGNC = class;
                            TValvulasEnargas = class;
                            TCilindrosEnargas = class;
                            TMarcasEnargas = class;
                            TReguladoresEnargas = class;
                            TequiGNC_Cilindro = class;
                            TReguladores = class;
                            TEstadoInspGNC = class;
                            TDefectosGNC = class;
                            TInspGNC_Defectos = class;
                            TLogRegulador = class;
                            TLogCilindro = class;
                            TDescuentoGNC = class;
                            TObleasReemp = class;
                            TObleasAnuladasGNC = class;
                            TVehiculos_GNC = class;

                        TSagInspVigente = class(TSagData);
                            TInspVigente = class;

                        TSagOblea = class(TSagData);
                            TOblea = class;

                        TSagVersiones = class(TSagData);
                            TVersiones = class;

                        TSagReveExterna = class(TSagData);
                            TReveExterna = class;

        TProvincias = class(TSagGeografia)
        public
            constructor Create (const aBD : TSQLConnection);
        end;

        TPartidos = class(TSagGeografia)
        private
            fZona : Integer;
            fProvincia : Integer;
        public
            constructor Create (const DVarios: TVarios);
        end;


       TFacturacion = class(TSagFacturacion)
        private
            Function GetPorNormal:integer;
            function GetOficial: boolean;

        protected
            Function GetTituloFactura: String;
            procedure AfterPost(aDataSet: TDataSet); override;
            Procedure BeforePost(aDataSet: TDataSet); override;
        public
            fCodFactu: String;
            ffactadicionales: tfact_adicionales;     //
            function Monto : Double;
            function IVAInscriptoFactura: double;
            function IVANoInscriptoFactura: double;
            function DevolverSecuenciadorFactura(apuntoventa: integer): integer;
            function VerImprimirFactura (bVisualizar: boolean; aContexto: pTContexto): boolean; virtual;
            function VerImprimirFacturaGNC (bVisualizar: boolean; aContexto: pTContexto): boolean; virtual;

            function ImprimirFacturaCF(aCliente: Tclientes; aTipoIva: integer): boolean; virtual;   // 
            function VerImprimirNCDescuento (bVisualizar: boolean; aContexto: pTContexto): boolean;

            constructor CreateByRowId (const aBD: TSQLConnection; const aRowId: string);
            constructor CreateByTipoNumero (const aBD : TSQLConnection; const aTipo: string; const aNumero: integer);
            constructor CreateByTipoNumeroAdic (const aBD : TSQLConnection; const aTipo: string; const aNumero: integer; aPtoVenta: integer);  //
//            constructor CreateFromSagData(aSagData: TObject);
//            constructor CreateDescFromFact (const aBD: TSQLConnection; const aFactura: TFacturacion);

            // Devuelve el número de factura formateado de la forma aaaa-bbbbbbbb
            function DevolverNumeroFactura (const aTipo: string): string;
            procedure SetImportes(const aEjercicio, aCodigo, aCliente_id: integer; const fverificacion: tfVerificacion; const aCodDescu: string);
            procedure SetImporteNeto(const aEjercicio, aCodigo, aCliente_id: integer);
            procedure SetImporteNeto_Desc(const aEjercicio, aCodigo, aCliente_id: integer; aPorcDesc: string);
            procedure SetImporteNetoGNC(const aEjercicio, aCodigo: integer);
            procedure SetImporteNetoGNC_Desc(const aEjercicio, aCodigo: integer; aPorcDesc: string);
            Function GetInspeccion : TInspeccion;
            Function GetInspeccionGNC : TInspGNC;
            //Devuelve las inspecciones finalizadas que tengan asociado informe de inspección, es decir, que no sean Gratuitas o Preverificaciones
            Function GetInspeccionFinalizadasConInforme : TInspeccion;
            Function GetCliente : TClientes;
            Property TituloFactura: String Read GetTituloFactura;
            Function ValidateNumeroFactura(Valor: String):Boolean;
            function DevolverNroCheque:string;
            function TieneDescuento(const fverificacion: tfVerificacion; const aCodDescu: string):boolean;
            function TieneDescuentoGNC(const aCodDescu: string):boolean;
            procedure SetImportesGNC(const aEjercicio, aCodigo: integer; const fverificacion: tfVerificacion; const aCodDescu: string);

            Property EsDeOficial: boolean Read GetOficial;
        end;

        TContraFacturas = class(TFacturacion)
        protected
            Procedure AfterPost(aDataSet: TDataSet);Override;
            Procedure BeforePost(aDataSet: TDataSet); override;            
            Function GetTituloFactura: String;
        public
            fMasterFactura : TFacturacion;

            constructor CreateByRowId (const aBD: TSQLConnection; const aRowId: string);
            constructor CreateFromFactura(const aBD: TSQLConnection;const aFactur : TFacturacion);
            destructor destroy; override;
            property TituloFactura: String Read GetTituloFactura;

            function VerImprimirFactura (bVisualizar: boolean; aContexto: pTContexto): boolean; override;
            function VerImprimirFacturaGNC (bVisualizar: boolean; aContexto: pTContexto): boolean; override;
        end;


        TVehiculo = class(TSagVehiculos)
        public
            function GetPatente: string;
            constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
            function GetInspections: TInspeccion;
            function GetInspectionsGNC: TInspGNC;            
            //Devuelve las inspecciones finalizadas que tengan asociado informe de inspección, es decir, que no sean Gratuitas o Preverificaciones
            function GetInspectionsFinalizadasConInforme: TInspeccion;
            function GetHistoria:TInspeccion;
            function GetHistoriaGNC:TInspGNC;
            Function GetModelo: TSagData;
            Function GetTipoVehic: Integer;
            Function GetEspecie: TSagData;
            Function GetDestino: TSagData;
            class function UpdatePatentes(const aBD : TSQLConnection; const APatente: TDominio; var ExisteYa : boolean) : integer;
            class function RespetadaUnicidadPatentes(const aBD: TSQLConnection; const aPatente: TDominio): boolean;
            procedure AfterInsert(aDataSet: TDataSet); override;
            function GetUltimoVencimiento:TInspeccion;
            function GetUltimoVencimientoSinPreve:TInspeccion;            
            function Marca: string;
            function Modelo: string;
            function Destino: string;
            Function EsMayorA20 : boolean;
            function EsMenorA2M : Boolean;
        end;

        TClientes = class(TSagClientes)
        private
            fPartidos : TPartidos;
        protected
            function GetCalculatedValueByName (Index: string) : string; Override;
            function GetMoroso: boolean;
            Function GetCredito: tTipoCredito;
            Procedure SetTipoCliente(aTipo: TTiposCliente);
            Function GetTipoCliente:TTiposCliente;
            function GetPartidos :TPartidos;
            Procedure SetPartidos(aPartido: TPartidos);
        public
            constructor CreateByRowId (const aBD : TSQLConnection; const aRowId : string);
            constructor CreateFromCode(const aBD : TSQLConnection;aIdCode,aCode: String);
            constructor CreateByCopy (const aCliente : TClientes);
            constructor Create(const aBD : TSQLConnection); //
            constructor CreateFromCodclien(const aBD : TSQLConnection; aCodClien: integer);    //
            procedure PutFechaMorosidad (const aValue: string);
            Property IsMoroso: Boolean read GetMoroso;
            Property Credito: tTipoCredito Read GetCredito;
            property Partido: TPartidos read GetPartidos Write SetPartidos;
            Property TipoCliente : TTiposCliente Read GetTipoCliente Write SetTipoCliente;
            function Provincia: string;
            function Domicilio: string;
        end;

        TSagInspeccion = Class(TSagData)
        Protected
             WithColumns: boolean;
        public
            constructor CreateFromColumns(const aBD : TSQLConnection; const aTable : string; aColumns: string; aFilter: String);Override;
        end;

        TInspeccion = class(TSagInspeccion)
        private
            CurrEjercicio,CurrCodInspe: String;
            function LastVencimiento(const aInspections : TInspeccion; const aType: tfVerificacion; var LastResultado : string) : string;
        protected
            function GetValueKey (const aFieldName : string) : string; Override;
            function ValidateFieldsData: Boolean; Override;
        public
            Constructor Create(aBd: TSQLConnection;aFilter: String);
            constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
            Constructor CreateFromEstadoInspeccion(aInspeccion: TEstadoInspeccion);Virtual;
            // procedure Open; Override;
            function IsReverification(const aInspections : TInspeccion; const aType: tfVerificacion) : boolean;
            function Informe: string;
            Function GetPropietario: TClientes;
            Function GetTenedor: TClientes;
            Function GetConductor: TClientes;
            Function GetVehiculo:TVehiculo;
            Function GetFactura: TFacturacion;
            function GetFactConAdicional: TFacturacion;      //
            function GetNumOblea: string;
            function VerImprimirInformeInspeccion (const bVisualizar,bOriginal: boolean; aContexto: pTContexto): boolean;
            function VerImprimirCertificado (const bVisualizar: boolean; aContexto: pTContexto; const sZona, sEstacion: string): boolean;
            function VerImprimirInformeMedicion (const aEjercici,aCodinspe: longint; aContexto: pTContexto; const bVisualizar: boolean): boolean;
            procedure AfterPost(aDataSet: TDataSet); override;
            Procedure BeforePost(aDataSet: TDataSet); override;
            procedure COMMIT; override;
            function InspeccionVigente : boolean;
            function InspeccionVigenteCon30 : boolean;
        end;

        TInspeccionJoin = class (TInspeccion)
        private
             fFiltroPatente: string;
        protected
        public
             procedure SetFilter(const aValue: string); override;
             Constructor CreateFromPatente(aBd: TSQLConnection;aFilter: String);
        end;


        TEstadoInspeccion = class(TSagInspeccion)
        private
        Protected
            Procedure AnularReferencias;
            Function GetStandByValues: Boolean;
        Public
            Constructor Create(aBd: TSQLConnection;aFilter: String);
            Constructor CreateByRowId (aBd: TSQLConnection;aFilter: String);
            procedure SetFilter(const aValue: string);Override;
            Function Cancelar : Boolean;
            Function RestaurarPreverificacion: Boolean;
            Function Reiniciar: Boolean;
            Function StandBy: Boolean;
            Procedure UnStandBy;
            Function IsBlockByUser: Boolean;
            Function BlockInsp: Boolean;
            Procedure UnBlockInsp;
            Function UnicaxUsuario: Boolean;
            Function Borrar: Boolean;
        end;

        TPtoVenta = class(TSagPtoVenta)
        private
            function GetVigente: string;
        public
            constructor Create(const aBD : TSQLConnection);
            constructor CreateByTipo(const aBD: TSQLConnection; const atipo: string; aNroCaja: integer; aVigente: string);
            constructor createbyNroPto(const aDB: TSQLConnection; aPtoVenta: integer);
            function GetTipo: string;
            function EsCaja: boolean;
            function EncendidoyFunciona:boolean;
            function StatusCF:boolean;
            function GetPtoVenta: integer;
            function GetPtoVentaManual: integer;
            function ProximoNroFactura(aTipoFac: string): string;
            function ES_SOLO_REVE:STRING;
            property Vigente: string read GetVigente;
        end;

        TCierreZ = class(TSagCierreZ)
        private
        public
            Constructor Create(aBd: TSQLConnection);
            constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
        end;

        tFact_Adicionales = class (TSagFact_Adicionales)
        private
        public
              constructor CreateFromFactura(const aBD : TSQLConnection; const aCodFactu: string; aTipoFac, aTipoFac2: string);
              constructor create (abd: TSQLConnection);
              constructor CreateByRowid (const aBD : TSQLConnection; const aRowId: string);
              procedure SetImporteDescuento(const aEjercicio, aCodigo: integer);
              procedure SetImporteDescuento_Desc(const aEjercicio, aCodigo: integer; const aPorcDesc: real);
              procedure SetImporteDescuentoGNC(const aEjercicio, aCodigo: integer);
              procedure SetImporteDescuentoGNC_Desc(const aEjercicio, aCodigo: integer; const aPorcDesc: real);

              function GetNombreTarjeta(const aCodTarjeta: string): string;
         end;

        tDatos_Estacion = class (TSagDatos_Estacion)
        private
        public
              constructor Create (aBD: TSQLConnection);
        end;

        TTarjeta = class (TSagTarjeta)
        private
        public
              constructor Create (aBD: TSQLConnection);
              constructor CreateByCodTarjet(aBD: TSQLConnection; aCodTarjet: string);

        end;

        TDescuento = class (TSagDescuento)
        private
        public
              constructor Create (aBD: TSQLConnection);
              constructor CreateFromCoddescu(aBD: TSQLConnection; const aCoddescu: string);
              constructor CreateBySysDate(aBD: TSQLConnection);
              constructor CreateConFechas(aBD: TSQLConnection; aDateIni, aDateFin: string);
        end;

        tCheque = class(TSagCheque)
        private
        public
              constructor Create (aBD: TSQLConnection);
              constructor CreateFromFactura (aBD: TSQLConnection; aCodFactu: string);
              constructor CreateByRowID(const aBD: TSQLConnection; const aRowId: string);
              function DevolverNroBanco:string;
        end;

        tBancos = class(TSagBancos)
        private
        public
              constructor Create (aBD: TSQLConnection);
              constructor CreateFromCodBanco(aBD: TSQLConnection; aCodBanco: String);
        end;

        tSucursales = class(TSagSucursales)
        private
        public
              constructor Create (aBD: TSQLConnection);
              constructor CreateFromBanco(const aBD: TSQLConnection; const aCodBanco: string);
        end;

        tMonedas = class(TSagMonedas)
        private
        public
              constructor Create (aBD: TSQLConnection);
        end;

        tDatosPromocion = class (TSagDatosPromocion)
        private
        public
             constructor Create (aBD: TSQLConnection);
             constructor CreateFromFactura(aBD: TSQLConnection; aCodFactu, aCodclien, aCodDesc: string);
        end;

        TEncuestaSatisfaccion = class (TSagEncuestaSatisfaccion)
        private
        public
             constructor Create (aBd: TSQLConnection);
             constructor CreateBySerie (aBD: TSQLConnection; aSerie: integer);
             function serie: string;
        end;

        TDatInspecc = class(tSagDatInspecc)
        private
             vNomyAppInspector: TRevisor;
             vCodInspector: TRevisor;
             function GetInspectoresLineasByApellido: TRevisor;
        public
             constructor Create (aBD: TSQLConnection);
             constructor CreatebyCodEjer(aInspeccion: TEstadoInspeccion);Virtual;
             constructor CreateByEjerCodinspe(const aBD: TSQLConnection; const aEjercici, aCodInspe: string);
             constructor CreatebyInspecc(aInspeccion: TInspeccion);Virtual;
             function GetDominio:string;
             function GetNroInforme:string;
             function GetInspectoresLineasByCodigo: TRevisor;
             Property InspectorLinea: TRevisor read vCodInspector;
             Property NomyAppInspectorLinea: TRevisor read vNomyAppInspector;
        end;

        TCambiosFecha = class(TSagCambiosFecha)
        private
        public
              constructor CreateByRowID(const aBD: TSQLConnection; const aRowId: string);
              constructor CreateByCodEjer(const aBD: TSQLConnection; const aEjercici, aCodInspe: string);
        end;

        TMotivos_Cambios = class(TSagMotivos_Cambios)
        private
        public
             constructor Create (aBD: TSQLConnection);
        end;

        TCambiosFecha_gnc = class(TSagCambiosFecha)
        private
        public
              constructor CreateByRowID(const aBD: TSQLConnection; const aRowId: string);
              constructor CreateByCodEjer(const aBD: TSQLConnection; const aEjercici, aCodInspe: string);
        end;

        TMotivos_Cambios_gnc = class(TSagMotivos_Cambios)
        private
        public
             constructor Create (aBD: TSQLConnection);
        end;


        TSeries_Encuestas = class(TSagSeries_Encuestas)
        private
               function GetSerie: string;
               function GetNOM_F_IMPR: string;
        public
              constructor CreateByFecha (aBD: TSQLConnection; aFecha: string);
              property serie : string read GetSerie;
              property Nom_F_Impr : string read GetNOM_F_IMPR;
        end;

        TPreguntas_Encuestas = class(TSagPreguntas_Encuestas)
        private
               function GetNroPregunta : string;
               function GetAbrevia : string;
        public
              constructor CreateBySerie(aBD: TSQLConnection; aserie: string);
              property NroPregunta : string read getNroPregunta;
              property Abrevia : string read GetAbrevia;
        end;

        TInspGNC = class (TSagGNC)
        private
            CurrEjercicio,CurrCodInspe: String;
        protected
            function GetValueKey (const aFieldName : string) : string; Override;
        public
              Constructor Create(aBd: TSQLConnection;aFilter: String);
              constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
              Constructor CreateFromEstadoInspeccion(aInspeccion: TEstadoInspGNC);Virtual;
              Function GetPropietario: TClientes;
              Function GetConductor: TClientes;              
              function GetNumOblea: string;
              Function GetVehiculo:TVehiculo;
              function GetInspector : string;
              procedure COMMIT; override;
              Function Informe: string;
              function VerImprimirInformeGNC (const bVisualizar: boolean; aContexto: pTContexto; const sZona, sEstacion: string): boolean;
              function VerImprimirTAmarilla (const bVisualizar: boolean; aContexto: pTContexto; const sZona, sEstacion: string): boolean;
              Function GetFactura: TFacturacion;
              function LlevaCombo(aCodvehic: string) : string;
              procedure AfterPost(aDataSet: TDataSet); override;
              Procedure BeforePost(aDataSet: TDataSet); override;
        end;

        TCentrosRPC = class(TSagGNC)
        private
        public
             constructor Create (aBD: TSQLConnection);
        end;

        TEquiposGNC = class(TSagGNC)
        private
            CurrCodEqui: String;
        public
            constructor CreateByCodequi(const aBD: TSQLConnection; const aCodEquip: string);
            constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
            function GetCilindro: TEquiGNC_Cilindro;
            function GetRegulador: TReguladores;
            procedure SetEquipo (var aEquipo: TEquiposGNC; const aRegOrig, aRegActual: tReguladores;
                                aCilOrig, aCilActual: TCilindros; var aEqui_Cilindro : TequiGNC_Cilindro);
            procedure AfterPost(aDataSet: TDataSet); override;
            Procedure BeforePost(aDataSet: TDataSet); override;
        end;

        TCilindros = class(TSagGNC)
        private
        public
              constructor CreateByConCodigos(const aBD: TSQLConnection; const aCodCilindro: string);
              constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
              constructor CreateByIDCilSerie(const aBD : TSQLConnection; const aIdCilindro, aNroSerie: string);
              constructor CreateByCopy (const aCilindro : TCilindros);
              constructor CreateByCodCilindro (const aBD : TSQLConnection; const aCodCilindro: string);
              Function GetCodEnargas: string;
              function GetCodValvEnargas: string;
              function GetCRPC: string;
        end;

        TAdicionalesGNC = class(TSagGNC)
        private
        public
        end;

        TValvulasEnargas = class(TSagGNC)
        private
        public
             constructor Create (aBD: TSQLConnection);
        end;

        TCilindrosEnargas = class(TSagGNC)
        private
        public
             constructor Create (aBD: TSQLConnection);
        end;

        TMarcasEnargas = class(TSagGNC)
        private
        public
        end;

        TReguladoresEnargas = class(TSagGNC)
        private
        public
             constructor Create (aBD: TSQLConnection);
             constructor CreateByCodigo (const aBD : TSQLConnection; const aCodigo : string);
             constructor CreateById (const aBD : TSQLConnection; const aCodigo : string);
        end;

        TequiGNC_Cilindro = class(TSagGNC)
        private
        public
            constructor CreateByCodequi(const aBD: TSQLConnection; const aCodEquip: string);
            constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
            function GetCilindros : TCilindros;
        end;

        TReguladores = class(TSagGNC)
        private
        public
            constructor CreateByCodRegulador(const aBD: TSQLConnection; const aCodRegulador: string);
            constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
            constructor CreateByIDRegSerie(const aBD : TSQLConnection; const aIdRegulador, aNroSerie: string);
            constructor CreateByCopy (const aRegulador : TReguladores);
            Function GetCodEnargas: string;
        end;

        TEstadoInspGNC = class(TSagGNC)
        private
            Procedure AnularReferencias;
        public
            constructor Create (aBD: TSQLConnection);
            constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
            constructor CreateAutosEnLinea(abd: TSQLConnection);
            constructor CreateAutosEnEspera(abd: TSQLConnection);
            Function Cancelar : Boolean;
            Function Reiniciar: Boolean;
            Function Rechazar: Boolean;
        end;

        TDefectosGNC = class(TSagGNC)
        private
        public
             constructor Create (aBD: TSQLConnection);
             constructor CreateLinea (aBD: TSQLConnection);
             constructor CreateSAG (aBD: TSQLConnection);
        end;

        TInspGNC_Defectos = class(TSagGNC)
        private
        public
             constructor Create (aBD: TSQLConnection);
             constructor CreateFromInspeccion(aBD: TSQLConnection; aEjercici, aCodinspgnc : string);
             constructor CreateFromInspeccionsup(aBD: TSQLConnection; aEjercici, aCodinspgnc : string);             
             constructor CreateFromDatos(aBD: TSQLConnection; aEjercici, aCodinspgnc, aCoddefec : string);
             function GetNroInforme:string;
             function GetDominio:string;
        end;

        TLogRegulador = class(TSagGNC)
        private
        public
            constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
        end;

        TLogCilindro = class(TSagGNC)
        private
        public
            constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
        end;

        TDescuentoGNC = class(TSagGNC)
        private
        public
             constructor Create (aBD: TSQLConnection);
             constructor CreateConVigente(aBD: TSQLConnection; aVigente : string);
             constructor CreateFromCoddescu(aBD: TSQLConnection; const aCoddescu: string);
        end;

        tObleasReemp = class(TSagGNC)
        private
        public
             constructor Create (aBD: TSQLConnection);
             constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
        end;

        TProvSeguros = class (TSagProvSeguros)
        private
        public
          constructor CreateByPoliza( aBD: TSQLConnection; aPoliza, aCertificado: string);
          constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
        end;

        TCodposta_Capital = class (TSagCodposta_Capital)
        private
        public
             constructor Create (aBD: TSQLConnection);
        end;

        TCodposta_Interior = class (TSagCodposta_Interior)
        private
          function GetLocalidad : string;
        public
          property localidad : string read GetLocalidad;
          constructor CreateByCodProvi( aBD: TSQLConnection; aCodProvi: string);
        end;

        TLocalidad_Interior = class (TSagLocalidad_Interior)
        private
          function GetCodposta : string;
        public
          property Codposta : string read GetCodposta;
          constructor CreateByCodProvi( aBD: TSQLConnection; aCodProvi: string);
          constructor CreateByParecido( aBD: TSQLConnection; aCodProvi, aNombre: string);
        end;

        TDecJurada = class (TSagDecJurada)
        private
        public
          constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
          constructor CreateByCodigo(const aBD : TSQLConnection; aEjercici, aCodinspe : string);
        end;

        TObleasAnuladasGNC = class (TSagGNC)
        private
        public
          constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
          constructor Create (aBD: TSQLConnection);
          constructor CreateByFechas(const aBD : TSQLConnection; fecini, fecfin: string);
        end;

        TVehiculos_GNC = class (TSagGNC)
        private
        public
          constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
          constructor CreateByCodinspe(const aBD : TSQLConnection; aCodinspe : string);
          constructor CreateByCodVehic(const aBD : TSQLConnection; aCodVehic : string);
          constructor Create (aBD: TSQLConnection);
        end;

        tDatosProvincia = class (TSagDatosProvincia)
        private
        public
          constructor Create (aBD: TSQLConnection);
          constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
        end;

        TBancos_Deposito = class (tSagDatosLiquidacion)
        private
        public
          constructor Create (aBD: TSQLConnection);
        end;

        TDepositos_liq = class (tSagDatosLiquidacion)
        private
        public
          constructor CreateByFecha(const aBD : TSQLConnection; const aFechini, aFechfin, aIdUsuario: string);
          constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
          constructor CreateByLiquidacion(const aBD : TSQLConnection; const aCodliq: string);
          constructor CreateByLiquidacionNro(const aBD : TSQLConnection; const aCodliq, aNro: string);
        end;

        TSocios_Acavtv = class (tSagDatosLiquidacion)
        private
        public
          constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
          constructor CreateByFactura(const aBD : TSQLConnection; const aCodFactu: string);
          constructor CreateByFecha(const aBD : TSQLConnection; const aFechini, aFechfin: string);
          constructor CreateByFechaCompleto(const aBD : TSQLConnection; const aFechini, aFechfin: string);
          constructor CreateByFactura_u(const aBD : TSQLConnection; const aCodFactu, aIdUsuario: string);
          constructor CreateByFecha_u(const aBD : TSQLConnection; const aFechini, aFechfin, aIdUsuario: string);
          constructor CreateByFechaCompleto_u(const aBD : TSQLConnection; const aFechini, aFechfin, aIdUsuario: string);

        end;

        Tliquidacion = class (tSagDatosLiquidacion)
        private
        public
          constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
          constructor CreateByFechaMax(const aBD : TSQLConnection; const  aIdUsuario, aFechini: string);
          constructor CreateByFecha(const aBD : TSQLConnection; const aFechini, aFechfin, aIdUsuario: string);
          constructor CreateByCodigo(const aBD : TSQLConnection; const aCodliq: string);
        end;

        TInspVigente = class(TSagInspVigente)
        private
        public
          constructor CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
        end;

        TOblea = class(TSagOblea)
        Private

        Public
          constructor Create (const aBD : TSQLConnection);
          constructor CreateByOblea (const aBD : TSQLConnection; vOblea: String);
          constructor CreateByObleaDisponible(const aBD: TSQLConnection; const vOblea, vAnioVenci: Integer);

          Procedure TomarOblea;
          Procedure LiberarOblea;
          Procedure ConsumirOblea(vFecha,vEjercici,vCodInspe: String);
          Procedure ConsumirObleaFromInu(vFecha,vEjercici,vCodInspe: String);
          Procedure AnularOblea(vFecha: String);
          Procedure InutilizarOblea(vFecha: String);
          Function IsObleaDisponible: Boolean;
          Function IsObleaTomada: Boolean;
          Function IsObleaInutilizada: Boolean;
          Function GetObleaByVenci(vAnio: Integer): String;
          Function ExisteOblea: Boolean;
          Function Inspeccion: String;
          Function Estado: String;
          Function ExistInT_ERVTV_INUTILIZ(NumOblea: String): Boolean;
          Function ExistInTInspeccion(NumOblea: String): Boolean;
        end;

        TVersiones = class(TSagVersiones)
        Public
          constructor Create (const aBD : TSQLConnection);
          Procedure AltaPaquete(sNombrePaquete: String);
          Function ExistePaqueteSQL(sNombrePaquete: String): Boolean;
        end;

        TReveExterna = class(TSagOblea)
          Public
            constructor Create (const aBD : TSQLConnection);
          end;
    implementation

    uses
        GLOBALS,
        ULOGS,
        UTILORACLE,
        DateUtil,
        USAGFABRICANTE,
        USAGCLASIFICACION,
        UFSTANDBYDATA,
        UFFACTURA, uFFacturaGNC,
        UINFORME,
        UCERTIFI,
        UFTAmarilla,
        UInformeGNC, ufMedicionesAutomaticas,ufrecepcion;

    const

        SELECTED_FIELDS = ' A.EJERCICI,A.CODINSPE,A.MATRICUL,A.ESTADO,A.HORAINIC,A.HORAFINA,B.TIPO ';
        CONDITION_FIELDS = ', TINSPECCION B WHERE A.CODINSPE=B.CODINSPE AND A.EJERCICI=B.EJERCICI';

        SELECTED_FIELDS_TINSPECCION = 'A.EJERCICI,A.CODINSPE,A.FECHALTA, NVL(B.PATENTEN,B.PATENTEA) MATRICUL';
        CONDITION_FIELDS_INSP = ', TVEHICULOS B where A.FECHALTA>=TO_DATE(''%S'',''dd/mm/yyyy hh24:mi:ss'') AND A.FECHALTA<=TO_DATE(''%S'',''dd/mm/yyyy hh24:mi:ss'') AND A.INSPFINA=''S'' AND A.CODVEHIC=B.CODVEHIC ORDER BY A.FECHALTA';

        FILE_NAME = 'USAGCLASSES.PAS';

   var impfis:_PrinterFiscalDisp;



(******************************************************************************)
(*                                                                            *)
(*                              TVERSIONES_SAG                                *)
(*                                                                            *)
(******************************************************************************)


constructor TVersiones.Create(const aBD: TSQLConnection);
begin
inherited CreateFromDataBase (aBD,DATOS_SAG_INSTALADO,'ORDER BY FECHALTA DESC');
end;

Procedure TVersiones.AltaPaquete(sNombrePaquete: String);
Begin
inherited start;
Append;
ValueByName[FIELD_VERSION] := sNombrePaquete;
ValueByName[FIELD_FECHALTA] := DateToStr(Now);
Post(True);
inherited commit;
end;


Function TVersiones.ExistePaqueteSQL(sNombrePaquete: String): boolean;
begin
Result:=false;
  With TSQLQuery.Create(nil) do
    Begin
      SQLConnection := MyBD;
      Close;
      SQL.Add('SELECT VERSION FROM TSAG_INSTALADO WHERE VERSION = :sNombrePaquete');
      Params[0].AsString:=sNombrePaquete;
      Open;
      If not (Fields[0].IsNull) then
        Result:=true;
      Application.ProcessMessages;
    end;
end;


(******************************************************************************)
(*                                                                            *)
(*                                                                            *)
(*                              TREVEEXTERNA                                  *)
(*                                                                            *)
(******************************************************************************)

constructor TReveExterna.Create(const aBD: TSQLConnection);
begin
inherited CreateFromDataBase (aBD,DATOS_REVES_EXTERNA,'');
end;


(******************************************************************************)
(*                               TOBLEAS                                      *)
(*                                                                            *)
(******************************************************************************)

constructor TOblea.Create(const aBD: TSQLConnection);
begin
inherited CreateFromDataBase (aBD,DATOS_OBLEAS,'');
end;

constructor TOblea.CreateByOblea(const aBD: TSQLConnection; vOblea: String);
begin
  try
    inherited CreateFromDatabase(aBD,DATOS_OBLEAS,Format(' WHERE NUMOBLEA =%s',[vOblea]));
  except
    ShowMessage('ERROR', 'No se encontró la oblea');
  end;
end;


constructor TOblea.CreateByObleaDisponible(const aBD: TSQLConnection; const vOblea, vAnioVenci: Integer);
begin
inherited CreateFromDataBase (aBD,DATOS_OBLEAS,'');
end;


Function TOblea.ExisteOblea: Boolean;
Begin
Result:=false;
If (ValueByName[FIELD_NUMERO_OB] <> '') then
  Result:=true;
end;


Function TOblea.GetObleaByVenci(vAnio: Integer): String;  //Ver que esta mal.
begin
Inherited CreateFromDataBase (MyBD,DATOS_OBLEAS,'');
With TSQLQuery.Create(Application) do
  try
    SQLConnection := MyBD;
    Close;
    SQL.Add('SELECT MIN(NUMOBLEA) FROM TOBLEAS WHERE ANIO = :ANIO AND ESTADO = :DISPONIBLE');
    Params[0].AsInteger:=vAnio;
    Params[1].AsString:=DISPONIBLE;
    Open;
    Result:=Fields[0].Value;
  except
  On E: Exception do
    MessageDlg ('ERROR','Se ha producido un error: '+#13#10+E.Message, mtWarning, [mbOk],mbOk, 0);
  end;
end;


Function TOblea.IsObleaDisponible: Boolean;
Begin
Result:=false;
If ValueByName[FIELD_ESTADO_OB] = DISPONIBLE then
  Result:=true;
end;


Function TOblea.IsObleaTomada: Boolean;
Begin
Result:=false;
If ValueByName[FIELD_ESTADO_OB] = TOMADA then
  Result:=true;
end;

Function TOblea.IsObleaInutilizada: Boolean;
Begin
Result:=false;
If ValueByName[FIELD_ESTADO_OB] = INUTILIZADA then
  Result:=true;
end;



procedure TOblea.ConsumirOblea(vFecha,vEjercici,vCodInspe: String);
begin
  inherited start;
  Edit;
  ValueByName[FIELD_ESTADO_OB] := CONSUMIDA;
  ValueByName[FIELD_FECHA_CON_OB] := vFecha;
  ValueByName[FIELD_EJERCICIO_OB] := vEjercici;
  ValueByName[FIELD_CODINSP_OB] := vCodInspe;
  Post(True);
  inherited commit;
end;


procedure TOblea.ConsumirObleaFromInu(vFecha,vEjercici,vCodInspe: String);
begin
  inherited start;
  Edit;
  ValueByName[FIELD_ESTADO_OB] := CONSUMIDA_K;
  ValueByName[FIELD_FECHA_CON_OB] := vFecha;
  ValueByName[FIELD_EJERCICIO_OB] := vEjercici;
  ValueByName[FIELD_CODINSP_OB] := vCodInspe;
  Post(True);
  inherited commit;
end;


procedure TOblea.InutilizarOblea(vFecha: String);
begin
  inherited start;
  Edit;
  ValueByName[FIELD_ESTADO_OB] := INUTILIZADA;
  ValueByName[FIELD_FECHA_INU_OB] := vFecha;
  Post(True);
  inherited commit;
end;


procedure TOblea.AnularOblea(vFecha: String);
begin
  inherited start;
  Edit;
  ValueByName[FIELD_ESTADO_OB] := ANULADA;
  ValueByName[FIELD_FECHA_ANUL_OB] := vFecha;
  Post(True);
  inherited commit;
end;


procedure TOblea.TomarOblea;
begin
  inherited start;
  Edit;
  ValueByName[FIELD_ESTADO_OB] := TOMADA;
  Post(True);
  inherited commit;
end;


procedure TOblea.LiberarOblea;
begin
  inherited start;
  Edit;
  ValueByName[FIELD_ESTADO_OB] := DISPONIBLE;
  ValueByName[FIELD_FECHA_CON_OB] := '';
  ValueByName[FIELD_FECHA_INU_OB] := '';
  ValueByName[FIELD_FECHA_ANUL_OB] := '';
  ValueByName[FIELD_CODINSP_OB] := '';
  ValueByName[FIELD_EJERCICIO_OB] := '';
  Post(True);
  inherited commit;
end;


Function TOblea.Inspeccion: String;
Begin
  Result:=ValueByName[FIELD_CODINSPE];
end;


Function TOblea.Estado: String;
Begin
If ValueByName[FIELD_ESTADO] <> '' then
  Result:=(ValueByName[FIELD_ESTADO]);
end;

Function TOblea.ExistInT_ERVTV_INUTILIZ(NumOblea: String): Boolean;
begin
Result:=False;
Screen.Cursor:=crHourGlass;
With TSQLQuery.Create(Application) do
  try
    SQLConnection := MyBD;
    Close;
    SQL.Add('SELECT OBLEAANT FROM T_ERVTV_INUTILIZ WHERE OBLEAANT = :NumObleaS');
    Params[0].AsString:=NumOblea;
    Open;
    If not (Fields[0].IsNull) then
      Result:=true;
  except
    Result:=False;
  end;
Screen.Cursor:=crDefault;
end;


Function TOblea.ExistInTInspeccion(NumOblea: String): Boolean;
begin
Result:=False;
Screen.Cursor:=crHourGlass;
With TSQLQuery.Create(Application) do
  try
    SQLConnection := MyBD;
    Close;
    SQL.Add('SELECT NUMOBLEA FROM TINSPECCION WHERE NUMOBLEA = :NumObleaS');
    Params[0].AsString:=NumOblea;
    Open;
    If not (Fields[0].IsNull) then
      Result:=true;
  except
    Result:=False;
  end;
Screen.Cursor:=crDefault;
end;



(******************************************************************************)
(*                                                                            *)
(*                               TFacturacion                                 *)
(*                                                                            *)
(******************************************************************************)


constructor TFacturacion.CreateByRowId (const aBD: TSQLConnection; const aRowId: string);
{ si aRowId está vacía => se obtienen los datos de la factura directamente }
begin
    inherited CreateFromDataBase (aBD,DATOS_FACTURAS,Format('WHERE %S = ''%S''',[FIELD_ROWID, aRowId]));
    ffactadicionales:=tfact_Adicionales.CreateByRowid(MyBD,'');
end;

{constructor TFacturacion.CreateFromSagData(aSagData: TObject);
begin
  inherited CreateFromSagData((aSagData As TSagData));
  ffactadicionales := tfact_Adicionales.CreateFromSagData((aSagData As TFacturacion).ffactadicionales);
end;}

function TFacturacion.DevolverSecuenciadorFactura(aPuntoVenta: integer): integer;
var
   aNumber : Integer;
   aQ: TSQLQuery;
begin
    try
      try
        aQ:=TSQLQuery.create(application);
        aQ.SQLConnection:=self.database;

        aNumber := -1;
        {$IFNDEF SAT98}
        if (ValueByName[FIELD_TIPFACTU] = FACTURA_TIPO_A)
        then aq.sql.add(FORMAT('SELECT FACTUNUMBERA(%d) FROM DUAL',[aPuntoVenta]))
        else aq.sql.add(FORMAT('SELECT FACTUNUMBERB(%d) FROM DUAL',[aPuntoVenta]));
        {$ELSE}
        aFunctionName := 'FACTUNUMBER';
        {$ENDIF}
        try
          try
            aq.open;
          except
            on E:exception do

            messagedlg('',E.message,mtError,[mbOK],mbOK,0);
            end;
//            aNumber:=StrToInt(ExecuteFunction(aFunctionName,null));
            aNumber:=aq.Fields[0].asinteger;
        finally
            if aNumber <= 0
            then raise Exception.Create('Número de factura incorrecto')
            else Result := aNumber;
        end;
      finally
         aq.close;
         aq.free;
      end;
    except
        on E: Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'Falla la obtencion de secuencia por: %S',[E.message]);
            raise;
        end
    end;
end;

procedure TFacturacion.BeforePost(aDataSet: TDataSet);
begin
  fCodfactu := ValueByName[FIELD_CODFACTU];
  Inherited BeforePost(aDataSet);
end;

procedure TFacturacion.AfterPost(aDataSet: TDataSet);
begin
  inherited AfterPost (aDataSet);
  fFilter := Format('WHERE %s = %s',[FIELD_CODFACTU, fCodFactu])
end;


function TFacturacion.Monto : Double;
var
    ImporteGravado, IvaIns, IvaNIns, iibb,iibbCaba: Double;
begin
{$IFNDEF SAT98}
  try

    if (ValueByName[FIELD_TIPFACTU]='B') then
    ImporteGravado :=(strtofloat(ValueByName[FIELD_IMPONETO])/(1+(strtofloat(ValueByName[FIELD_IVAINSCR]) / 100)))
    else
    ImporteGravado :=strtofloat(ValueByName[FIELD_IMPONETO]);

    if (fVarios.ValueByName[FIELD_ENA_PIB] = 'S') and (ValueByName[FIELD_IIBB] <> '0') then
    begin
        iibb:=strtofloat(floattostrf(strtofloat(ValueByName[FIELD_IIBB])/100*ImporteGravado,fffixed,15,2));
    end;

    if (fVarios.ValueByName[FIELD_ENA_PIB] = 'S') and (ValueByName[FIELD_IIBB_CABA] <> '0') then
    begin
        iibbCaba:=strtofloat(floattostrf(strtofloat(ValueByName[FIELD_IIBB_CABA])/100*ImporteGravado,fffixed,15,2));
    end;

    if (ValueByName[FIELD_TIPFACTU] = FACTURA_TIPO_A) then
      begin
        IvaIns := StrToFloat(ValueByName[FIELD_IVAINSCR]);
        IvaNIns := StrToFloat(ValueByName[FIELD_IVANOINS]);
        result := ImporteGravado +  (StrToFloat(FloattoStrF((ImporteGravado*IvaIns*0.01),fffixed,8,2)) + StrToFloat(FloatTostrF((ImporteGravado*IvaNIns*0.01),fffixed,8,2)) )+iibb+iibbCaba;
      end
    else
      result := strtofloat(ValueByName[FIELD_IMPONETO])+iibb+iibbCaba;
  except
    on E: Exception do
      begin
        fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,3,FILE_NAME,'Error al calcular el monto de la factura por: %s',[E.message]);
        result := 0;
      end;
  end;
  {$ELSE}
  Inet := StrToFloat(ValueByName[FIELD_IMPONETO]);
  IvaIns := StrToFloat(ValueByName[FIELD_IVA]);
  result := Inet + StrToFloat(FloattoStrF((Inet*IvaIns*0.01),fffixed,8,2));
  {$ENDIF}
end;

function TFacturacion.IVAInscriptoFactura: double;
begin
    {$IFNDEF SAT98}
    Result := (StrToFloat(ValueByName[FIELD_IMPONETO]) * StrToFloat(ValueByName[FIELD_IVAINSCR]) * 0.01);
    {$ELSE}
    Result := (StrToFloat(ValueByName[FIELD_IMPONETO]) * StrToFloat(ValueByName[FIELD_IVA]) * 0.01);
    {$ENDIF}
end;


function TFacturacion.IVANoInscriptoFactura: double;
begin
    Result := (StrToFloat(ValueByName[FIELD_IMPONETO]) * StrToFloat(ValueByName[FIELD_IVANOINS]) * 0.01);
end;

function TFacturacion.VerImprimirFactura (bVisualizar: boolean; aContexto: pTContexto): boolean;
var
  frmFactura_Auxi: TFrmFactura;
begin
    try
        frmFactura_Auxi := TFrmFactura.CreateFromFactura (Self, bVisualizar, aContexto);
        Try
            Result := frmFactura_Auxi.ImprimirFactura;
        Finally
            frmFactura_Auxi.Free;
        end;
    except
        on E:Exception do
        begin
//         Result := False;
           raise Exception.Create ('Error al ver o imprimir una factura por: ' + E.Message);
        end;
    end;
end;

function TFacturacion.VerImprimirFacturaGNC (bVisualizar: boolean; aContexto: pTContexto): boolean;
var
  frmFactura_Auxi: TFrmFacturaGNC;
begin
    try
        frmFactura_Auxi := TFrmFacturaGNC.CreateFromFactura (Self, bVisualizar, aContexto);
        Try
            Result := frmFactura_Auxi.ImprimirFactura;
        Finally
            frmFactura_Auxi.Free;
        end;
    except
        on E:Exception do
        begin
//         Result := False;
           raise Exception.Create ('Error al ver o imprimir una factura por: ' + E.Message);
        end;
    end;
end;


// 
function TFacturacion.ImprimirFacturaCF(aCliente: Tclientes; aTipoIva: Integer): boolean;
var impfis: _PrinterFiscalDisp;
    tipostatus: widestring;
begin
   result := False;
   impfis := CreateComObject(CLASS_PrinterFiscal) as _PrinterFiscalDisp;
   impfis.PortNumber := PortNumber;
   impfis.BaudRate := BaudRate;
   tipostatus := INF_NUMERADORES;
   if impfis.Status(tipostatus) then
   begin
     if statusok(hexabina(impfis.fiscalstatus),'F',FALSE)and statusok(hexabina(impfis.printerstatus),'I',FALSE) then
         result:=true
   end
   else
   begin
     result:=false;
   end;
end;

function TFacturacion.VerImprimirNCDescuento (bVisualizar: boolean; aContexto: pTContexto): boolean;
var
  frmFactura_Auxi: TFrmFactura;
begin
    try
        frmFactura_Auxi := TFrmFactura.CreateFromNCDescuento (Self, bVisualizar, aContexto);
        Try
            Result := frmFactura_Auxi.ImprimirFactura;
        Finally
            frmFactura_Auxi.Free;
        end;
    except
        on E:Exception do
        begin
//         Result := False;
           raise Exception.Create ('Error al ver o imprimir una factura por: ' + E.Message);
        end;
    end;
end;


constructor TFacturacion.CreateByTipoNumero (const aBD : TSQLConnection; const aTipo: string; const aNumero: integer);
begin
     { obtenemos de la base de datos los datos de la factura }
    if aTipo <> ''
    then
    begin
      Inherited CreateFromDatabase(aBD,DATOS_FACTURAS,Format('WHERE a.%s=''%s'' AND a.%s=%d',[FIELD_TIPFACTU,aTipo,FIELD_NUMFACTU,aNumero]));
      open;
      ffactadicionales:=tfact_adicionales.CreateFromFactura(aBD,valuebyname[FIELD_CODFACTU],'F','G');
    end
    else
    begin
      Inherited CreateFromDatabase(aBD,DATOS_FACTURAS,Format('WHERE a.%s=%d',[FIELD_NUMFACTU,aNumero]));
      open;
      ffactadicionales:=tfact_adicionales.CreateFromFactura(aBD,valuebyname[FIELD_CODFACTU],'F','G');
    end;
end;

Constructor TFacturacion.CreateByTipoNumeroAdic (const aBD : TSQLConnection; const aTipo: string; const aNumero: integer; aPtoVenta: integer);
var aQ: TSQLQuery;
    aCodfactu:integer;
begin
     { obtenemos de la base de datos los datos de la factura }
    if aTipo <> ''
    then
    begin
      aQ := TSQLQuery.create(application);
      try
        aQ.SQLConnection := abd;

        aQ.SQL.Add ('SELECT A.CODFACTU FROM TFACTURAS A, TFACT_ADICION F WHERE ');
        aQ.SQL.Add (Format('NUMFACTU = %d and TIPFACTU = ''%s'' and A.CODFACTU = F.CODFACT AND PTOVENT = %d',[aNumero,aTipo,aPtoVenta]));
        aQ.open;
        aCodfactu:=strtoint(aQ.fields[0].asstring);
        Inherited CreateFromDatabase(aBD,DATOS_FACTURAS,Format('WHERE a.%s=%d',[FIELD_CODFACTU,aCodfactu]));
        open;
        ffactadicionales:=tfact_adicionales.CreateFromFactura(aBD,valuebyname[FIELD_CODFACTU],TIPO_FACTURA,TIPO_FACTURAGNC);
      finally
        aQ.close;
        aQ.free;
      end;
    end
    else
    begin
      Inherited CreateFromDatabase(aBD,DATOS_FACTURAS,Format('WHERE a.%s=%d',[FIELD_NUMFACTU,aNumero]));
      open;
      ffactadicionales:=tfact_adicionales.CreateFromFactura(aBD,valuebyname[FIELD_CODFACTU],TIPO_FACTURA, TIPO_FACTURAGNC);
    end;
end;

Function TFacturacion.GetPorNormal:integer;
var aQ:TSQLQuery;
begin
  aq:=TSQLQuery.create(application);
  try
      aQ.SQLConnection:=MyBD;
    

      aQ.sql.add(format('SELECT TT.PORNORMAL FROM TTIPOSCLIENTE TT, TCLIENTES TC, TFACTURAS TF'+#13+
                    'WHERE TF.CODFACTU = ''%S'' AND TC.CODCLIEN = TF.CODCLIEN AND '+#13+
                    'TT.TIPOCLIENTE_ID = TC.TIPOCLIENTE_ID',[valuebyname[FIELD_CODFACTU]]));
      aQ.open;
      result:=aQ.fields[0].asinteger;
  finally
    aQ.free;
  end;
end;

function TFacturacion.TieneDescuento(const fverificacion: tfVerificacion; const aCodDescu: string):boolean;
begin
  result:=true;
  if (aCodDescu = '') or ((aCodDescu <> '') and ((fVerificacion in [fvVoluntaria, fvReverificacion, fvVoluntariaReverificacion]) or (GetPornormal = 100)))then
  begin
    result:=false;
  end;
end;

function TFacturacion.TieneDescuentoGNC(const aCodDescu: string):boolean;
begin
  result:=true;
  if (aCodDescu = '') then
  begin
    result:=false;
  end;
end;


procedure TFacturacion.SetImportes(const aEjercicio, aCodigo, aCliente_id: integer; const fverificacion: tfVerificacion; const aCodDescu: string);
var fdescuento: tdescuento;
begin
  if tieneDescuento(fverificacion,acodDescu) then
  begin
    fdescuento:=nil;
    try
      fdescuento:=tdescuento.CreateFromCoddescu(myBd,aCodDescu);
      fdescuento.open;
      if fdescuento.valuebyname[FIELD_EMITENC] = 'S' then
      begin
        SetImporteNeto(aEjercicio, aCodigo, aCliente_id);
        fFactadicionales.SetImporteDescuento(aEjercicio, aCodigo);
      end
      else
      begin
        SetImporteNeto_Desc(aEjercicio, aCodigo, aCliente_id, fDescuento.valuebyname[FIELD_PORCENTA]);
        fFactadicionales.SetImporteDescuento_Desc(aEjercicio, aCodigo, strtofloat(fDescuento.valuebyname[FIELD_PORCENTA]));
      end;
    finally
      fdescuento.free;
    end;
  end
  else
  begin
      SetImporteNeto(aEjercicio, aCodigo,aCliente_id);
      fFactadicionales.SetImporteDescuento(aEjercicio, aCodigo);
  end;
end;

procedure TFacturacion.SetImportesGNC(const aEjercicio, aCodigo: integer; const fverificacion: tfVerificacion; const aCodDescu: string);
var fdescuento: tdescuentognc;
begin
  if tieneDescuentognc(acodDescu) then
  begin
    fdescuento:=nil;
    try
      fdescuento:=tdescuentognc.CreateFromCoddescu(myBd,aCodDescu);
      fdescuento.open;
        SetImporteNetoGNC_Desc(aEjercicio, aCodigo, fDescuento.valuebyname[FIELD_PORCENTA]);
        fFactadicionales.SetImporteDescuentoGNC_Desc(aEjercicio, aCodigo, strtofloat(fDescuento.valuebyname[FIELD_PORCENTA]));
    finally
      fdescuento.free;
    end;
  end
  else
  begin
      SetImporteNetoGNC(aEjercicio, aCodigo);
      fFactadicionales.SetImporteDescuentoGNC(aEjercicio, aCodigo);
  end;
end;


procedure TFacturacion.SetImporteNeto(const aEjercicio, aCodigo, aCliente_Id: integer);
var
    aQ: TSQLQuery;
begin
    try
        aQ := TSQLQuery.create(application);
        try
            aQ.SQLConnection := Self.Database;
          aQ.SQL.Add (Format('SELECT GETIMPONETO(%d,%d,%d) FROM DUAL',[aEjercicio,aCodigo,aCliente_ID]));
         
            {$IFDEF TRAZAS}
            fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME,'Obtención del importe por vez primera.');
            fTrazas.PonComponente(TRAZA_SQL,1,FILE_NAME,aQ);
            {$ENDIF}
            aQ.Open;
            {$IFDEF TRAZAS}
            fTrazas.PonRegistro(TRAZA_SQL,1,FILE_NAME,aQ);
            {$ENDIF}

            Self.Edit;
            ValueByName[FIELD_CODFACTU] ;
            ValueByName[FIELD_IMPONETO] := aQ.Fields[0].AsString;
            self.post(true);

            aQ.close;
            aQ.SQL.clear;
            aQ.SQL.Add (Format('SELECT GRABA_IIBB(%d,%d) FROM DUAL',[aEjercicio,aCodigo]));
            aQ.Open;

            self.edit;
            ValueByName[FIELD_CODFACTU] ;
            ValueByName[FIELD_IIBB_CABA] :=aQ.Fields[0].AsString;
            ValueByName[FIELD_IIBB] :=aQ.Fields[1].AsString;



        {
            IF TRIM(aQ.Fields[0].AsString)='X' THEN
             BEGIN
              ValueByName[FIELD_IIBB] :='0';
              ValueByName[FIELD_IIBB_CABA] :='0';
             END ELSE
              BEGIN
                 IF TRIM(aQ.Fields[0].AsString)='P' THEN
                     ValueByName[FIELD_IIBB] := aQ.Fields[1].AsString
                       ELSE
                        ValueByName[FIELD_IIBB_CABA] := aQ.Fields[1].AsString;
              END;

            }
            self.Post(True);
        finally
            aQ.Close;
            aQ.Free;
        end;
    except
        on E: Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error calculando el importe por: %S',[E.message]);
            raise
        end;
    end;

end;

procedure TFacturacion.SetImporteNeto_Desc(const aEjercicio, aCodigo, aCliente_Id: integer; aPorcDesc: string);
var
    aQ: TSQLQuery;
begin
    try
        aQ := TSQLQuery.create(application);
        try
            aQ.SQLConnection := Self.Database;
            aQ.SQL.Add (Format('SELECT GETIMPONETO_DESC(%d,%d,%d,''%s'') FROM DUAL',[aEjercicio,aCodigo,aCliente_ID,aPorcDesc]));
            {$IFDEF TRAZAS}
            fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME,'Obtención del importe por primera vez.');
            fTrazas.PonComponente(TRAZA_SQL,1,FILE_NAME,aQ);
            {$ENDIF}
(*hago el try porque en algunos oracle pide con punto y otros con coma*)
            try
              aQ.Open;
            except
              aq.SQL.Clear;
              aQ.SQL.Add (Format('SELECT GETIMPONETO_DESC(%d,%d,%d,''%s'') FROM DUAL',[aEjercicio,aCodigo,aCliente_ID,ConvierteComaEnPtoMasDec(aPorcDesc)]));
              aq.open;
            end;
            {$IFDEF TRAZAS}
            fTrazas.PonRegistro(TRAZA_SQL,1,FILE_NAME,aQ);
            {$ENDIF}
            Edit;
            ValueByName[FIELD_IMPONETO] := aQ.Fields[0].AsString;
            post(true);

            aQ.close;
            aQ.SQL.clear;
            aQ.SQL.Add (Format('SELECT GRABA_IIBB(%d,%d) FROM DUAL',[aEjercicio,aCodigo]));
            aQ.Open;

            edit;
            ValueByName[FIELD_IIBB_CABA] := aQ.Fields[0].AsString;
            ValueByName[FIELD_IIBB] := aQ.Fields[1].AsString;

            Post(true);
        finally
            aQ.Close;
            aQ.Free;
        end;
    except
        on E: Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error calculando el importe por: %S',[E.message]);
            raise
        end;
    end;

end;


procedure TFacturacion.SetImporteNetoGNC(const aEjercicio, aCodigo: integer);
var
    aQ: TSQLQuery;
begin
    try
        aQ := TSQLQuery.create(application);
        try
            aQ.SQLConnection := Self.Database;
            aQ.SQL.Add (Format('SELECT GETIMPONETO_GNC(%d,%d) FROM DUAL',[aEjercicio,aCodigo]));
            {$IFDEF TRAZAS}
            fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME,'Obtención del importe por vez primera.');
            fTrazas.PonComponente(TRAZA_SQL,1,FILE_NAME,aQ);
            {$ENDIF}
            aQ.Open;
            {$IFDEF TRAZAS}
            fTrazas.PonRegistro(TRAZA_SQL,1,FILE_NAME,aQ);
            {$ENDIF}
            Edit;
            ValueByName[FIELD_IMPONETO] := aQ.Fields[0].AsString;
            post(true);

            aQ.close;
            aQ.SQL.clear;
            aQ.SQL.Add (Format('SELECT GRABA_IIBB_GNC(%d,%d) FROM DUAL',[aEjercicio,aCodigo]));
            aQ.Open;

            edit;
            ValueByName[FIELD_IIBB_CABA] := aQ.Fields[0].AsString;
            ValueByName[FIELD_IIBB] := aQ.Fields[1].AsString;
            Post(true);
        finally
            aQ.Close;
            aQ.Free;
        end;
    except
        on E: Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error calculando el importe por: %S',[E.message]);
            raise
        end;
    end;

end;

procedure TFacturacion.SetImporteNetoGNC_Desc(const aEjercicio, aCodigo: integer; aPorcDesc: string);
var
    aQ: TSQLQuery;
begin
    try
        aQ := TSQLQuery.create(application);
        try
            aQ.SQLConnection := Self.Database;
            aQ.SQL.Add (Format('SELECT GETIMPONETO_GNC_DESC(%d,%d,''%s'') FROM DUAL',[aEjercicio,aCodigo,aPorcDesc]));
            {$IFDEF TRAZAS}
            fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME,'Obtención del importe por vez primera.');
            fTrazas.PonComponente(TRAZA_SQL,1,FILE_NAME,aQ);
            {$ENDIF}
(*hago el try porque en algunos oracle pide con punto y otros con coma*)
            try
              aQ.Open;
            except
              aq.SQL.Clear;
              aQ.SQL.Add (Format('SELECT GETIMPONETO_GNC_DESC(%d,%d,''%s'') FROM DUAL',[aEjercicio,aCodigo,ConvierteComaEnPtoMasDec(aPorcDesc)]));
              aq.open;
            end;

            {$IFDEF TRAZAS}
            fTrazas.PonRegistro(TRAZA_SQL,1,FILE_NAME,aQ);
            {$ENDIF}
            Edit;
            ValueByName[FIELD_IMPONETO] := aQ.Fields[0].AsString;
            post(true);

            aQ.close;
            aQ.SQL.clear;
            aQ.SQL.Add (Format('SELECT GRABA_IIBB_GNC(%d,%d) FROM DUAL',[aEjercicio,aCodigo]));
            aQ.Open;

            edit;
            ValueByName[FIELD_IIBB_CABA] := aQ.Fields[0].AsString;
            ValueByName[FIELD_IIBB] := aQ.Fields[1].AsString;
            Post(true);
        finally
            aQ.Close;
            aQ.Free;
        end;
    except
        on E: Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error calculando el importe por: %S',[E.message]);
            raise
        end;
    end;

end;



function TFacturacion.DevolverNumeroFactura(const aTipo: string) : string;
var aux_ffactadicionales: TFact_adicionales;
begin
    try
       try
         if ValueByName[FIELD_NUMFACTU] = ''
         then begin
            {$IFNDEF SAT98}
            Result := ''
            {$ELSE}
            Result := 'XXXXXXXX';
            {$ENDIF}
         end
         else
         begin
             aux_ffactadicionales:=nil;
             try
               aux_ffactadicionales:=TFact_Adicionales.CreateFromFactura(MyBD,valuebyname[FIELD_CODFACTU],aTipo,aTipo);  //
               aux_fFactadicionales.open;
//             Result := Format ('%1.4d-%1.8d',[fPtoVenta.GetPtoVentaManual, StrToInt(ValueByName[FIELD_NUMFACTU])]);
               Result := FormatoCeros(strtoint(aux_ffactadicionales.valuebyname[FIELD_PTOVENT]),4)+'-'+Format ('%1.8d',[StrToInt(ValueByName[FIELD_NUMFACTU])]);
             finally
               aux_ffactadicionales.free;
             end;
         end;
       finally
       end;
    except
        on E:Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,3,FILE_NAME,'Error al recuperar un nº de factura por: %s',[E.message]);
            raise Exception.Create('The retrieve of a bill number was wrong')
        end;
    end;
end;

Function TFacturacion.ValidateNumeroFactura(Valor: String):Boolean;
Var
    numero:Integer;
    ArrayVar: Variant;
    ptoventa: integer;                             //
begin
    Try
        ptoventa:=StrToInt(Copy(Valor,1,4));
        Numero:=StrToInt(Copy(Valor,6,8));
        If Numero<>StrToInt(ValueByName[FIELD_NUMFACTU])
        Then begin
            Result:=False;
            ArrayVar:=VarArrayCreate([0,1],VarVariant);
            ArrayVar[0]:=ValueByName[FIELD_TIPFACTU];
            ArrayVar[1]:=Numero;
            ArrayVar[2]:=ptoventa;
            if ExecuteFunction('FacturasIguales',ArrayVar)='0'
            Then
                Result:=True;
        end
        Else
            Result:=True;
    Except
        //Ante cualquier Error de conversion de vuelve false
        Result:=False;
    end;
end;


Function TFacturacion.GetInspeccion : TInspeccion;
begin
    //Devuelve la inspeccion correspondiente a la factura
    If ((Active) and (RecordCount>0))
    Then
        Result:=TInspeccion.CreateFromDataBase(fSagBd,DATOS_INSPECCIONES,Format('WHERE %S = ''%S''',[FIELD_CODFACTU,ValueByName[FIELD_CODFACTU]]))
    else
        Result:=Nil;
end;

Function TFacturacion.GetInspeccionGNC : TInspGNC;
begin
    //Devuelve la inspeccion correspondiente a la factura
    If ((Active) and (RecordCount>0))
    Then
        Result:=TInspGNC.CreateFromDataBase(fSagBd,DATOS_INSPGNC,Format('WHERE %S = ''%S''',[FIELD_CODFACTU,ValueByName[FIELD_CODFACTU]]))
    else
        Result:=Nil;
end;

Function TFacturacion.GetInspeccionFinalizadasConInforme : TInspeccion;
begin
    //Devuelve la inspeccion correspondiente a la factura
    If ((Active) and (RecordCount>0))
    Then
        Result:=TInspeccion.CreateFromDataBase(fSagBd,DATOS_INSPECCIONES,Format('WHERE a.%S = ''%S'' and a.%s=''S'' and a.%s not in (''%s'',''%s'') order by %s desc',[FIELD_CODFACTU,ValueByName[FIELD_CODFACTU], FIELD_INSPFINA, FIELD_TIPO, T_PREVERIFICACION, T_GRATUITA, FIELD_FECHALTA]))
    else
        Result:=nil;
end;


Function TFacturacion.GetCliente : TClientes;
begin
    //Devuelve el cliente de la factura
    If ((Active) and (RecordCount>0))
    Then
        Result:=TClientes.CreateFromDataBase(fSagBd,DATOS_CLIENTES,Format('WHERE %S = ''%S''',[FIELD_CODCLIEN,ValueByName[FIELD_CODCLIEN]]))
    else
        Result:=Nil;
end;


Function TFacturacion.GetTituloFactura: String;
const
    {$IFNDEF SAT98}
    LITERAL_FACTURA = 'FACTURA';
    {$ELSE}
    LITERAL_FACTURA = 'FACTURA Nº:';
    {$ENDIF}
begin
    //Devuelve el titulo de la factura
    Result:=LITERAL_FACTURA;
end;

function TFacturacion.DevolverNroCheque:string;
var fcheque:TCheque;
begin
  fcheque:=nil;
  try
     fcheque:=Tcheque.CreateFromFactura(database,valuebyname[FIELD_CODFACTU]);
     fcheque.open;
     result:=formatoceros(strtoint(fcheque.devolverNroBanco),3)+' '+formatoceros(strtoint(fcheque.ValueByName[FIELD_CODSUCURSAL]),3)+' '+fcheque.ValueByName[FIELD_NUMCHEQUE];
  finally
    fcheque.close;
    fcheque.Free;
  end;
end;

function tFacturacion.GetOficial: boolean;
begin
  result := false;
  with TSQLQuery.create(application) do
    try
      SQLConnection := mybd;
      sql.add(format('SELECT TIPOCLIENTE_ID FROM TCLIENTES WHERE CODCLIEN = %S',[ValueByName[FIELD_CODCLIEN]]));
      open;
      if ((fields[0].asinteger = TIPO_USUARIO_PUBLICO) or (fields[0].asinteger = TIPO_USUARIO_PUBLICO_VIG)) then
        result := true;
    finally
      free;
    end;
end;




(******************************************************************************)
(*                                                                            *)
(*                               TContraFacturas                               *)
(*                                                                            *)
(******************************************************************************)


function TContraFacturas.VerImprimirFactura (bVisualizar: boolean; aContexto: pTContexto): boolean;
var
  frmFactura_Auxi: TFrmFactura;

begin
    try

    ///--------------------------------------------------------------------------------
        frmFactura_Auxi := TFrmFactura.CreateFromNCredito (Self, bVisualizar, aContexto);
        Try
           Result := frmFactura_Auxi.ImprimirFactura;
        Finally
            frmFactura_Auxi.Free;
        end;
   //*******************************************************************************



    except
        on E:Exception do
        begin
//           Result := False;
           raise Exception.Create ('Error al ver o imprimir una factura por: ' + E.Message);
        end;
    end;
end;

function TContraFacturas.VerImprimirFacturaGNC (bVisualizar: boolean; aContexto: pTContexto): boolean;
var
  frmFactura_Auxi: TFrmFacturaGNC;
begin
    try
        frmFactura_Auxi := TFrmFacturaGNC.CreateFromNCredito (Self, bVisualizar, aContexto);
        Try
           Result := frmFactura_Auxi.ImprimirFactura;
        Finally
            frmFactura_Auxi.Free;
        end;
    except
        on E:Exception do
        begin
//           Result := False;
           raise Exception.Create ('Error al ver o imprimir una factura por: ' + E.Message);
        end;
    end;
end;


Procedure TContraFacturas.AfterPost(aDataSet: TDataSet);
begin
    fFilter := Format('WHERE %s = %s',[FIELD_CODCOFAC, fCodfactu])
end;

Procedure TContraFacturas.BeforePost(aDataSet: TDataSet);
begin
  fCodfactu := ValueByName[FIELD_CODCOFAC];
end;


destructor TContraFacturas.Destroy;
begin
    if Assigned(fMasterFactura) then fMasterFactura.Free;
    inherited Destroy;
end;

constructor TContraFacturas.CreateByRowId (const aBD: TSQLConnection; const aRowId: string);
{ si aRowId está vacía => se obtienen los datos de la factura directamente }
begin
    fMasterFactura := nil;
    inherited CreateFromDataBase (aBD,DATOS_CONTRAFACTURAS,Format('WHERE %S = ''%S''',[FIELD_ROWID, aRowId]));
    ffactadicionales:=tfact_Adicionales.CreateByRowid(MyBD,'');
end;


Constructor TContraFacturas.CreateFromFactura(const aBD: TSQLConnection;const aFactur : TFacturacion);
begin
    //Crea una nota de crédito a partir del una factura
    // FMasterFactura := aFactur;
    FMasterFactura := TFacturaCion.CreateByRowId(aBD,aFactur.ValueByName[FIELD_ROWID]);
    FMasterFactura.Open;
    If fMasterFactura.ValueByName[FIELD_CODCOFAC]=M_NIL
    Then begin//Crea una ContraFactura nueva
        CreateFromDataBase(aBd,DATOS_CONTRAFACTURAS,'');
        Append;
        ffactadicionales:=tfact_adicionales.CreateFromDataBase(aBd,DATOS_FACT_ADICIONALES,'');
        ffactadicionales.append;
    end
    Else //Busca la contrafactura correspondiente
    begin
        CreateFromDataBase(aBd,DATOS_CONTRAFACTURAS,Format('WHERE %S = ''%S''',[FIELD_CODCOFAC,fMasterFactura.ValueByName[FIELD_CODCOFAC]]));
        open;
        ffactadicionales:=tfact_adicionales.CreateFromFactura(aBD,valuebyname[FIELD_CODCOFAC],'N','C');
    end;

end;

Function TContraFacturas.GetTituloFactura: String;
const
    {$IFNDEF SAT98}
    LITERAL_NOTA_CREDITO = 'NOTA DE CRÉDITO';
    {$ELSE}
    LITERAL_NOTA_CREDITO = 'NOTA DE ABONO Nº:';
    {$ENDIF}
begin
    //Devuelve el titulo de la factura
    Result:=LITERAL_NOTA_CREDITO;
end;


(******************************************************************************)
(*                                                                            *)
(*                               TVehiculo                                    *)
(*                                                                            *)
(******************************************************************************)

    procedure TVehiculo.AfterInsert(aDataSet: TDataSet);
    begin
        {$IFDEF SAG98}
        ValueByName[FIELD_OFICIAL] := 'N';
        {$ENDIF}
    end;

    function TVehiculo.GetPatente: string;
    begin
        Result := ValueByName[FIELD_PATENTEN];
        if (Result = '') then
           Result := ValueByName[FIELD_PATENTEA];
    end;

    constructor TVehiculo.CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
    begin
        inherited CreateFromDataBase (aBD,DATOS_VEHICULOS,Format('WHERE a.ROWID = ''%S''',[aRowId]));
    end;

    class function TVehiculo.RespetadaUnicidadPatentes (const aBD : TSQLConnection; const aPatente: TDominio): boolean;
    resourcestring
        UNI_PATENTEA = 'SELECT COUNT(*) REPETIDAS FROM TVehiculos WHERE PATENTEA=''%S''';
        UNI_PATENTEN = 'SELECT COUNT(*) REPETIDAS FROM TVehiculos WHERE PATENTEN=''%S''';
        REPETIDAS = 'REPETIDAS';
    var
        aQuery : TsqlQuery;
    begin
        aQuery := TSQLQuery.create(application);
        with aQuery do
        try
            SQLConnection := aBD;

            

            if APatente is TDominioAntiguo
            then SQL.Add(Format(UNI_PATENTEA,[aPatente.Patente]))
            else SQL.Add(Format(UNI_PATENTEN,[aPatente.Patente]));

            {$IFDEF TRAZAS}
            fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'Unicidad de Patentes');
            fTrazas.PonComponente(TRAZA_SQL,1,FILE_NAME,aQuery);
            {$ENDIF}

            try
                Open;
                Result := FieldByName(REPETIDAS).AsInteger = 0;
                {$IFDEF TRAZAS}
                fTrazas.PonRegistro(TRAZA_SQL,1,FILE_NAME,aQuery);
                {$ENDIF}

            except
                on E: Exception do
                begin
                    fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Falló la busqueda de claves repetidas por: %s',[E.message]);
                    Result := False
                end;
            end

        finally
            Close;
            Free
        end
    end;

    class function TVehiculo.UpdatePatentes(const aBD : TSQLConnection; const APatente: TDominio; var ExisteYa : boolean) : integer;
    resourcestring
        U_PATENTEN  = 'UPDATE TVehiculos SET PATENTEN = ''%S'' WHERE ROWID = ''%S''';
        U_PATENTEA  = 'UPDATE TVehiculos SET PATENTEA = ''%S'' WHERE ROWID = ''%S''';
    var
        aQuery : TSQLQuery;
    begin
        ExisteYa := FALSE;

        aQuery := TSQLQuery.create(application);
        with aQuery do
        try
            SQLConnection := aBD;

            

            if APatente is TDominioAntiguo
            then SQL.Add(Format(U_PATENTEA,[aPatente.Patente, aPatente.PerteneceA]))
            else SQL.Add(Format(U_PATENTEN,[aPatente.Patente, aPatente.PerteneceA]));

            {$IFDEF TRAZAS}
            fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'Actualización de patentes');
            fTrazas.PonComponente(TRAZA_SQL,1,FILE_NAME,aQuery);
            {$ENDIF}

            try
                ExecSql;
                result := 0;
                ExisteYa := FALSE;
            except
                on E: Exception do
                begin
                    if ((Pos('ORA-00001',E.message) <> 0) and (Pos('CISA.UNI_TVEHICULOS_PATENTEN',E.message) <> 0)) or ((Pos('ORA-00001',E.message) <> 0) and (Pos('CISA.UNI_TVEHICULOS_PATENTEA',E.message) <> 0))
                    then begin
                        result := 0;
                        ExisteYa := TRUE;
                        fIncidencias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'No se puede actualizar patentes por: %s',[E.message])
                    end
                    else begin
                        result := -1;
                        fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Falló la actualización porr: %s',[E.message])
                    end;
                end;
            end

        finally
            aQuery.Close;
            aQuery.Free
        end;
    end;

    function TVehiculo.GetInspections: TInspeccion;
    begin
        //Devuelve un objecto de la clase TSaginspection que son las inspecciones del vehiculo
        if ((Active) and (RecordCount>0))
        Then
            Result:=TInspeccion.CreateFromDataBase(fSagBd,DATOS_INSPECCIONES,'WHERE '+FIELD_CODVEHIC+' = '+ValueByName[FIELD_CODVEHIC] + ' ORDER BY FECHALTA')
        Else
            Result:=nil;
    end;

    function TVehiculo.GetInspectionsGNC: TInspGNC;
    begin
        //Devuelve un objecto de la clase TSaginspection que son las inspecciones del vehiculo
        if ((Active) and (RecordCount>0))
        Then
            Result:=TInspGNC.CreateFromDataBase(fSagBd,DATOS_INSPGNC,'WHERE '+FIELD_CODVEHIC+' = '+ValueByName[FIELD_CODVEHIC] + ' ORDER BY FECHALTA')
        Else
            Result:=nil;
    end;


    function TVehiculo.GetInspectionsFinalizadasConInforme: TInspeccion;
    begin
        //Devuelve un objecto de la clase TSaginspection que son las inspecciones del vehiculo
        If ((Active) and (RecordCount>0))
        Then
            Result:=TInspeccion.CreateFromDataBase(fSagBd,DATOS_INSPECCIONES,Format ('WHERE a.%s=%s and a.%s=''S'' and a.%s not in (''%s'',''%s'') ORDER BY a.%s desc',[FIELD_CODVEHIC,ValueByName[FIELD_CODVEHIC],FIELD_INSPFINA,FIELD_TIPO,T_PREVERIFICACION,T_GRATUITA,FIELD_FECHALTA]))
        else
            Result:=nil;
    end;


    function TVehiculo.GetHistoria:TInspeccion;
    begin
        If ((Active) and (RecordCount>0))
        then begin
            try
                //Lee las inspecciones del historico
                Result:=TInspeccion.CreateFromColumns(fSagBd,DATOS_INSPECCIONES,Format(CONSULTA_HISTORICO, [fVarios.Zona, fVarios.CodeEstacion]) ,'WHERE '+FIELD_CODVEHIC+' = '+ValueByName[FIELD_CODVEHIC] + ' ORDER BY FECHALTA ');
            finally
            end;
        End
        else
            Result:=nil;
    end;

    function TVehiculo.GetHistoriaGNC:TInspGNC;
    begin
        If ((Active) and (RecordCount>0))
        then begin
            try
                //Lee las inspecciones del historico
//                Result:=TInspGNC.CreateFromColumns(fSagBd,DATOS_INSPGNC,Format(CONSULTA_HISTORICO_GNC, [fVarios.Zona, fVarios.CodeEstacion]) ,'WHERE '+FIELD_CODVEHIC+' = '+ValueByName[FIELD_CODVEHIC] + ' ORDER BY FECHALTA ');
                Result:=TInspGNC.CreateFromDatabase(fSagBd,DATOS_INSPGNC,'WHERE '+FIELD_CODVEHIC+' = '+ValueByName[FIELD_CODVEHIC] + ' ORDER BY FECHALTA ');
            finally
            end;
        End
        else
            Result:=nil;
    end;

    function TVehiculo.GetUltimoVencimiento:TInspeccion;
    begin
        If ((Active) and (RecordCount>0))
        then begin
            try
                //Lee las inspecciones del historico
                Result:=TInspeccion.CreateFromColumns(fSagBd,DATOS_INSPECCIONES,Format(CONSULTA_HISTORICO, [fVarios.Zona, fVarios.CodeEstacion]) ,'WHERE INSPFINA = ''S'' AND '+FIELD_CODVEHIC+' = '+ValueByName[FIELD_CODVEHIC] + ' ORDER BY FECVENCI DESC ');
            finally
            end;
        End
        else
            Result:=nil;
    end;


    function TVehiculo.GetUltimoVencimientoSinPreve:TInspeccion;
    begin
        If ((Active) and (RecordCount>0))
        then begin
            try
                //Lee las inspecciones del historico
                Result:=TInspeccion.CreateFromColumns(fSagBd,DATOS_INSPECCIONES,Format(CONSULTA_HISTORICO, [fVarios.Zona, fVarios.CodeEstacion]) ,
                'WHERE INSPFINA = ''S'' AND '+FIELD_CODVEHIC+' = '+ValueByName[FIELD_CODVEHIC]+' AND TIPO IN (''A'',''E'',''D'',''I'') AND TIENE_NC(CODFACTU) = ''N'' ORDER BY FECVENCI DESC ');
            finally
            end;
        End
        else
            Result:=nil;
    end;

    Function TVehiculo.GetTipoVehic: Integer;
    var
        aQ: TClientDataSet;
        sdsaQ : TSQLDataSet;
        dspaQ : TDataSetProvider;
        aDataBase: TSQLConnection;
    begin
        Result:=0;
        If ((Active) and (RecordCount>0))
        then begin
            aDataBase:=DataBase;

            sdsaQ := TSQLDataSet.Create(Application);
            sdsaQ.SQLConnection := MyBD;
            sdsaQ.CommandType := ctQuery;
            sdsaQ.GetMetadata := false;
            sdsaQ.NoMetadata := true;
            sdsaQ.ParamCheck := false;            

            dspaQ := TDataSetProvider.Create(application);
            dspaQ.DataSet := sdsaQ;
            dspaQ.Options := [poIncFieldProps,poAllowCommandText];
            aQ:=TClientDataSet.create(application);

            With aQ do
            Try
                SetProvider(dspaQ);

                CommandText := fORMAT('SELECT TIPOVEHI FROM TTIPOESPVEH WHERE TIPOESPE = %S',[ValueByName[FIELD_TIPOESPE]]);
                Open;
                If RecordCount>0
                Then
                    Result:=Fields[0].AsInteger;
            Finally
                ClosE;
                Free;
                dspaQ.Free;
                sdsaQ.Free;
            end;
        end;
    end;

    Function TVehiculo.GetModelo: TSagData;
    Const
        TABLA_MODELOS = 'TMODELOS';
    begin
        If ((Active) and (RecordCount>0))
        Then
            Result:=TModelos.CreateFromDataBase(DataBase,TABLA_MODELOS ,Format(' WHERE CODMARCA=%S AND CODMODEL=%S',[ValueByName[FIELD_CODMARCA],ValueByName[FIELD_CODMODEL]]))
        Else
            Result:=nil;
    end;

    Function TVehiculo.GetEspecie: TSagData;
    begin
        //Devuelve un objecto tespecie con la especie del vehiculo
        If ((Active) and (RecordCount>0))
        Then
            Result:=TTEspecies.CreateByTipo(DataBase,ValueByName[FIELD_TIPOESPE])
        else
            Result:=nil;
    end;

    Function TVehiculo.GetDestino: TSagData;
    begin
        //Devuelve un objeto TDestino con el destino del vehiculo
        If ((Active) and (RecordCount>0))
        then
            Result:=TTDestinos.CreateByTipo(DataBase,ValueByName[FIELD_TIPODEST])
        else
            Result:=nil;
    end;

    function TVehiculo.Marca: string;
    begin
      with TSQLQuery.create(application) do
        try
          SQLConnection := mybd;
          sql.add(format('SELECT GETMARCA(%S) FROM DUAL',[valuebyname[FIELD_CODVEHIC]]));
          open;
          result := fields[0].asstring;
        finally
          free;
        end;

    end;

    function TVehiculo.Modelo: string;
    begin
      with TSQLQuery.create(application) do
        try
          SQLConnection := mybd;
          sql.add(format('SELECT GETMODELO(%S) FROM DUAL',[valuebyname[FIELD_CODVEHIC]]));
          open;
          result := fields[0].asstring;
        finally
          free;
        end;
    end;

    function tVehiculo.Destino: string;
    begin
      with TSQLQuery.create(application) do
        try
          SQLConnection := mybd;
          sql.add(format('SELECT NOMDESTI FROM TTIPODESVEH WHERE TIPODEST = %S',[valuebyname[FIELD_TIPODEST]]));
          open;
          result := fields[0].asstring;
        finally
          free;
        end;
    end;

    function tVehiculo.EsMayorA20 : Boolean;
    Var Fld: TFMTBCDField;
    begin
      result := false;
      with tsqlquery.Create(application) do
        try
          SQLConnection:=mybd;

{ TODO -oran -cquedo asi !!!! : cambiar a .asfloat de vuelta y probar }
          sql.add('alter session set nls_date_format = ''dd/mm/yyyy''');
          execsql;
          sql.clear;
          sql.add(format('select months_between (sysdate,''%s'')/12 ant from dual',[valuebyname[FIELD_FECMATRI]]));
          open;
          Fld := TFMTBCDField(FindField(fields[0].FieldName));
          Result := ( BCDToDouble(fld.AsBCD ) >= 20 );
        finally
          free;
        end;
    end;

    function tVehiculo.EsMenorA2M : Boolean;
    Var Fld: TFMTBCDField;
       L1:integer;
       L2:STRING;
    begin
      result := false;
       L1:=0;
      with tsqlquery.Create(application) do
        try
          SQLConnection:=mybd;
          sql.add(format('SELECT F.L1 FROM TFRECUENCIA  F, TVEHICULOS V, TTIPODESVEH D WHERE V.CODVEHIC =''%s'' AND V.TIPODEST = D.TIPODEST AND F.CODFRECU = D.CODFRECU',[valuebyname[FIELD_CODVEHIC]]));
          open;

          L1:=fields[0].AsInteger;
        finally
          free;
        end;

        if L1=0 then
        begin
           with tsqlquery.Create(application) do
        try
          SQLConnection:=mybd;
          sql.add(format('SELECT  F.L1 FROM TFRECUENCIA  F, TVEHICULOS V, TTIPOESPVEH E  WHERE V.CODVEHIC =''%s'' AND V.TIPOESPE = E.TIPOESPE  AND F.CODFRECU = E.CODFRECU',[valuebyname[FIELD_CODVEHIC]]));
          open;
          L1:=fields[0].AsInteger;
        finally
          free;
        end;
        end ;
      with tsqlquery.Create(application) do
        try
          SQLConnection:=mybd;
          sql.add('alter session set nls_date_format = ''dd/mm/yyyy''');
          execsql;
          sql.clear;
          sql.add(format('select months_between (sysdate,(to_date(''%s'',''dd/mm/yyyy''))+31) ant from dual',[valuebyname[FIELD_FECMATRI]]));
          open;
          Fld := TFMTBCDField(FindField(fields[0].FieldName));
          Result := ( BCDToDouble(fld.AsBCD ) <= L1 );
        finally
          free;
        end;
    end;


(******************************************************************************)
(*                                                                            *)
(*                               TClientes                                    *)
(*                                                                            *)
(******************************************************************************)

    constructor TClientes.CreateByCopy (const aCliente : TClientes);
    begin
        inherited CreateFromDataBase(aCliente.fSagBD,DATOS_CLIENTES,Format('WHERE %S = ''%S''',[FIELD_ROWID,aCliente.ValueByName[FIELD_ROWID]]));
    end;

    constructor TClientes.CreateByRowId (const aBD : TSQLConnection; const aRowId : string);
    begin
        inherited CreateFromDataBase(aBD,DATOS_CLIENTES,Format('WHERE %S = ''%S''',[FIELD_ROWID,aROwId]));
    end;

    constructor TClientes.CreateFromCode(const aBD : TSQLConnection;aIdCode,aCode: String);
    begin
        //Construye por el codigo indicado con el valor indicado
        inherited CreateFromDataBase(aBD,DATOS_CLIENTES,Format('WHERE %S = ''%S'' AND %S = ''%S''',[FIELD_TIPODOCU,aIdCode,FIELD_DOCUMENT,aCode]));
    end;

    constructor TClientes.Create(const aBD : TSQLConnection);    //
    begin
         inherited CreateFromDataBase (aBD,DATOS_CLIENTES,'');
    end;

    constructor TClientes.CreateFromCodclien(const aBD : TSQLConnection; aCodClien: integer);    //
    begin
        inherited CreateFromDataBase(aBD,DATOS_CLIENTES,Format('WHERE %S = %d',[FIELD_CODCLIEN,aCodClien]));
    end;


    function TClientes.GetCalculatedValueByName (Index: string) : string;
    begin
        //Sobreescribe el método de lectura de campos calculados
        //Inherited GetCalculatedValueByName (Index);
        If Index=FIELD_NOMBRE_Y_APELLIDOS
        Then
            Result:=Format ('%s %s %s',[ValueByName[FIELD_NOMBRE], ValueByName[FIELD_APELLID1], ValueByName[FIELD_APELLID2]]);

        If Index=FIELD_APELLIDOS_Y_NOMBRE
        Then
            if ValueByName[FIELD_APELLID2] = ''
            then result :=  Format('%s, %s',[ValueByName[FIELD_APELLID1], ValueByName[FIELD_NOMBRE]])
            else result := Format('%s %s, %s',[ValueByName[FIELD_APELLID1], ValueByName[FIELD_APELLID2], ValueByName[FIELD_NOMBRE]]);
        result := Trim(result);
    end;


    procedure TClientes.PutFechaMorosidad (const aValue: string);
    var
        OldDateFormat : string;
    begin
        //Pone la fecha de morosidad
        OldDateFormat := ShortDateFormat;
        try
            ShortDateFormat := 'dd/mm/yyyy';
            try
                StrToDate(aValue);
                ValueByName[FIELD_FECMOROS] := aValue
            except
                on E: Exception do
                begin
                    ValueByName[FIELD_FECMOROS] := FormatDateTime('DD/MM/YYYY',GetPureDateTime);
                    fIncidencias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'La fecha de morosidad %s, no tiene el formato correcto. %s',[aValue, E.message])
                end
            end
        finally
            ShortDateFormat := OldDateFormat
        end
    end;

    function TClientes.GetMoroso: boolean;
    var
        OldDateFormat : string;
    begin
        //Dice si el cliente es moroso
        OldDateFormat := ShortDateFormat;
        try
            ShortDateFormat := 'dd/mm/yyyy';
            Result := (Credito = ttcCredito) and (ValueByName[FIELD_FECMOROS] <> '') and
                       (StrToDate(ValueByName[FIELD_FECMOROS]) < StrToDate(DateBD(DataBase)));
        finally
            ShortDateFormat := OldDateFormat
        end
    end;


    Function TClientes.GetCredito: tTipoCredito;
    begin
        //Determina el tipo de credito del cliente
        Try
            If ValueByName[FIELD_CREDITCL]='S'
            then
                Result:=tTipoCredito(1)
            else
                Result:=tTipoCredito(0);
        Except
            Result:=ttcNull;
        end;
    end;

    Procedure TClientes.SetPartidos(aPartido: TPartidos);
    begin
        ValueByName[FIELD_CODPARTI]:=aPartido.ValueByName[FIELD_CODPARTI];
        fPartidos.Free;
        fPartidos := nil;
        fPartidos := TPartidos.CreateFromDatabase(DataBase,DATOS_PARTIDOS,Format(' WHERE CODPARTI = %S',[ValuebyName[FIELD_CODPARTI]]));
    end;


    Function TClientes.GetPartidos:TPartidos;
    Begin
        Result:=nil;
        If ((Active) and (RecordCount>0))
        Then begin
            if Assigned(fPartidos)
            then result := fPartidos
            else begin
                fPartidos := TPartidos.CreateFromDatabase(DataBase,DATOS_PARTIDOS,Format(' WHERE CODPARTI = %S',[ValuebyName[FIELD_CODPARTI]]));
                Result:= fPartidos;
            end;
        end;
    end;


    Procedure TClientes.SetTipoCliente(aTipo: TTiposCliente);
    begin
        ValueByName[FIELD_TIPOCLIENTE_ID]:=aTipo.ValueByName[FIELD_TIPOCLIENTE_ID];
    end;


    Function TClientes.GetTipoCliente:TTiposCliente;
    Begin
        Result:=nil;
        If ((Active) and (RecordCount>0))
        Then
            Result:=TTIposCliente.CreateFromDatabase(DataBase,DATOS_TIPOS_DE_CLIENTE,Format(' WHERE TIPOCLIENTE_ID = %S',[ValuebyName[FIELD_TIPOCLIENTE_ID]]));
    end;

    function tclientes.Provincia : string;
    begin
      with TSQLQuery.create(application) do
        try
          SQLConnection := mybd;



          sql.Add(format('SELECT GETPROVINCIA (%S) from dual',[ValueByName[FIELD_CODPARTI]]));
          open;
          result := fields[0].asstring;
        finally
          free;
        end;
    end;

    function tclientes.Domicilio : string;
    begin
         result := valuebyname[FIELD_DIRECCIO]+' '+valuebyname[FIELD_NROCALLE]+' '+valuebyname[FIELD_PISO]+' '+valuebyname[FIELD_DEPTO];
    end;
(******************************************************************************)
(*                                                                            *)
(*                               TInspeccion                                  *)
(*                                                                            *)
(******************************************************************************)


    function TInspeccion.GetNumOblea: string;
    var
      iNumeroOblea_Auxi: integer; // var. auxi.

    begin
        try
          Result:='';
          iNumeroOblea_Auxi := StrToInt (ValueByname[FIELD_NUMOBLEA]);
          if (iNumeroOblea_Auxi <= 999999) then
            Result := Format ('%1.2d-%1.6d', [0, iNumeroOblea_Auxi])
          else
            Result := Format ('%1.2d-%1.6d', [
                       StrToInt(Copy (IntToStr(iNumeroOblea_Auxi),1,(Length(IntToStr(iNumeroOblea_Auxi))-6))),
                       StrToInt(Copy (IntToStr(iNumeroOblea_Auxi),(Length(IntToStr(iNumeroOblea_Auxi))-6)+1,
                       Length(IntToStr(iNumeroOblea_Auxi))))]);
        except
            on E:Exception do
        end;
    end;


    function TInspeccion.VerImprimirInformeInspeccion (const bVisualizar,bOriginal: boolean; aContexto: pTContexto): boolean;
    var
      frmInspeccion_Auxi: TFrmFichaInspeccion;
    begin
        frmInspeccion_Auxi := nil;
        try
            frmInspeccion_Auxi := TFrmFichaInspeccion.CreateFromInspeccion (Self, bOriginal, bVisualizar, aContexto);
            Result := frmInspeccion_Auxi.ImprimirInformeInspeccion;
        finally
            frmInspeccion_Auxi.Free;
        end;
     end;

     function TInspeccion.VerImprimirCertificado (const bVisualizar: boolean; aContexto: pTContexto; const sZona, sEstacion: string): boolean;
     var
         FrmCertificado_Auxi: TFrmCertificado;
     begin
         FrmCertificado_Auxi := TFrmCertificado.CreateFromCertificado (Self, bVisualizar, aContexto);
         Try
            Result := FrmCertificado_Auxi.ImprimirCertificado;
         Finally
            FrmCertificado_Auxi.Free;
         end;
     end;

    function TInspeccion.VerImprimirInformeMedicion (const aEjercici,aCodinspe: longint; aContexto: pTContexto; const bVisualizar: boolean): boolean;
    var
      frmInspeccion_Auxi: TfrmMedicionesAutomaticas;
    begin
        frmInspeccion_Auxi := nil;
        try
            frmInspeccion_Auxi := TfrmMedicionesAutomaticas.CreateFromEjercicioAndCode (aEjercici, aCodinspe, aContexto, bVisualizar);
            Result := frmInspeccion_Auxi.ImprimirInformeMedicion;
        finally
            frmInspeccion_Auxi.Free;
        end;
     end;


     function TInspeccion.ValidateFieldsData: Boolean;
     var
        aQ: TSQLQuery;
     begin
        aQ := TSQLQuery.create(application);
        try
            {$IFNDEF SAT98}
            try
                aQ.SQLConnection := Database;
                aQ.SQL.Add (Format('SELECT GetCodigoFrecuencia (%S) FROM DUAL',[ValueByName[FIELD_CODVEHIC]]));
                {$IFDEF TRAZAS}
                fTrazas.PonAnotacion(TRAZA_FLUJO,0,FILE_NAME,'Obtiene codigo de frecuencia');
                fTrazas.PonComponente(TRAZA_SQL,0,FILE_NAME,aQ);
                {$ENDIF}
                aQ.Open;
                {$IFDEF TRAZAS}
                fTrazas.PonRegistro(TRAZA_SQL,0,FILE_NAME,aQ);
                {$ENDIF}
                ValueByName[FIELD_CODFRECU] := aQ.Fields[0].AsString;
            except
                on E: Exception do
                begin
                    fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'No obtuvo el codigo de frecuencia del vehículo por: %S',[E.message]);
                    fSagQuery.FieldbyName(FIELD_CODFRECU).Clear;
                end;
            end;
            {$ENDIF}
        finally
            aQ.Close;
            aQ.Free;
            Result:=inherited ValidateFieldsData;
        end;
     end;

     Procedure TInspeccion.BeforePost(aDataSet: TDataSet);
     begin
        //Guarda en variables temporales los codigos de la inspeccion actual
        CurrCodInspe:= ValueByName[FIELD_CODINSPE];
        CurrEjercicio:=ValueByName[FIELD_EJERCICI];
        Inherited BeforePost(aDataSet);
     end;

     procedure TInspeccion.AfterPost(aDataSet: TDataSet);
     begin
         inherited AfterPost (aDataSet);
         fFilter := Format('WHERE EJERCICI = %s AND CODINSPE = %s',[CurrEjercicio,CurrCodInspe])
     end;

     Constructor TInspeccion.CreateFromEstadoInspeccion;
     begin
        //Crea un objeto inspeccion a aprtir de los datos de un ESTADOINPECCION
        Inherited CreateFromDataBase(aInspeccion.DataBase,DATOS_INSPECCIONES,
                Format(' WHERE %S = %S AND %S = %S ',
                [FIELD_EJERCICI,aInspeccion.ValueByName[FIELD_EJERCICI],
                FIELD_CODINSPE,aInspeccion.ValueByName[FIELD_CODINSPE]]));
     end;


     Constructor TInspeccion.Create(aBd: TSQLConnection;aFilter: String);
     begin
        //Constructor de la clase
        Inherited CreateFromDataBase(aBd,DATOS_INSPECCIONES,aFilter);
     end;


    constructor TInspeccion.CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
    begin
        inherited CreateFromDataBase (aBD,DATOS_INSPECCIONES,Format('WHERE ROWID = ''%S''',[aRowId]));
    end;

     procedure TInspeccion.COMMIT;
     begin
        if StrToInt(ValueByName[FIELD_CODINSPE]) = -1
        then begin
            Edit;
            ValueByName[FIELD_CODINSPE] := IntToStr(GetValorSecuenciador);
            Post(True);
        end;
        inherited commit;
     end;

     function TInspeccion.GetValueKey (const aFieldName : string) : string;
     var
        a,m,d: Word;
     begin
        //Sobrerescribe este metodo para esta cñase que utiliza una clave doble
        if Pos(aFieldName,SequenceName) <> 0
        then begin
            if fSagQuery.FieldByName(aFieldName).IsNull
            then result := '-1'; //  result := IntToStr(GetValorSecuenciador);
        end
        else begin
            //Devolver clave para el otro campo parte de la clave de la atbla
            if fSagQuery.FieldByName(aFieldName).IsNull
            then begin
                Decodedate(StrToDate(DateBD(Database)),a,m,d);
                result := IntTostr(a);
            end
            else result := fSagQuery.FieldByName(aFieldName).AsString
        end
     end;



    // Esta funcion hay que realizarla sobre un conjunto de verificaciones

    function TInspeccion.LastVencimiento(const aInspections : TInspeccion; const aType: tfVerificacion; var LastResultado: string) : string;
    var
        aQ : TClientDataSet;
        sdsaQ : TSQLDataSet;
        dspaq : TDataSetProvider;

    begin
        try
            result := '';
            sdsaQ := TSQLDataSet.Create(Application);
            sdsaQ.SQLConnection := MyBD;
            sdsaQ.CommandType := ctQuery;
            sdsaQ.GetMetadata := false;
            sdsaQ.NoMetadata := true;
            sdsaQ.ParamCheck := false;

            dspaQ := TDataSetProvider.Create(application);
            dspaQ.DataSet := sdsaQ;
            dspaQ.Options := [poIncFieldProps,poAllowCommandText];
            aQ:=TClientDataSet.create(application);
            with aQ do
            try
                SetProvider(dspaq);

                if aType = fvVoluntaria
                then commandtext := Format(LAST_VENCIMIENTO_INSPECCIONES,[DATOS_INSPECCIONES, Format('''%S'', ''%S''',[T_VOLUNTARIA, T_VOLUNTARIAREVERIFICACION]), aInspections.ConjuntoRowIds])
                else CommandText := Format(LAST_VENCIMIENTO_INSPECCIONES,[DATOS_INSPECCIONES, Format('''%S'', ''%S''',[T_NORMAL, T_REVERIFICACION]), aInspections.ConjuntoRowIds]);
               // result:= Format(LAST_VENCIMIENTO_INSPECCIONES,[DATOS_INSPECCIONES, Format('''%S'', ''%S''',[T_VOLUNTARIA, T_VOLUNTARIAREVERIFICACION]), aInspections.ConjuntoRowIds]);
                {$IFDEF TRAZAS}
                fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'Obtención de la última fecha de vencimiento de la inspección.');
                fTrazas.PonComponente(TRAZA_SQL,1,FILE_NAME,aQ);
                {$ENDIF}

                Open;
                if RecordCount = 0
                then begin
                    {$IFDEF TRAZAS}
                    fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'No tiene inspecciones Normales, por tanto no es reverificación');
                    {$ENDIF}
                end
                else begin
                    {$IFDEF TRAZAS}
                    fTrazas.PonRegistro(TRAZA_SQL,1,FILE_NAME,aQ);
                    {$ENDIF}
                    result := FieldByName(FIELD_VENCE).AsString;
                    LastResultado := FieldByName(FIELD_RESULTAD).AsString;
                end;
            finally
                aQ.Close;
                aQ.Free;
                dspaq.Free;
                sdsaQ.Free;
            end;
        except
            on E: Exception do
            begin
                result := '';
                fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'Error obteniendo la ultima fecha de vencimiento de una inspección por: %s',[E.message]);
                raise Exception.Create('An error occur when testing inspection''s expired date.');
            end
        end
    end;


function TInspeccion.IsReverification (const aInspections : TInspeccion; const aType: tfVerificacion) : boolean;
var
bEs: Boolean;
OldDateFormat, sLastVencimiento, sLastResultado : string;
begin
//Comprueba si la inspeccion es una reverificacion
OldDateFormat := LongDateFormat;
bEs := False;
  try
    try
      if aInspections.RecordCount = 0 then
        bEs := False
      else
        begin
          sLastVencimiento := LastVencimiento(aInspections, aType, sLastResultado);
          if sLastVencimiento = '' then
            bEs := FALSE
          else
            begin
              LongDateFormat := 'dd/mm/yyyy';
              bEs := (not (sLastResultado = INSPECCION_APTA)) and (StrToDate(DateBD(Database)) <= IncDate(StrToDate(sLastVencimiento),fVarios.Carry,0,0));
            end;
        end;
    except
      on E: Exception do
        begin
          bEs := False;
          fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'Error obteniendo si se trata o no de una reverificación por: %s',[E.message]);
          raise Exception.Create('An error occur when testing if the inspect was a reverification');
        end;
    end;
  finally
    LongDateFormat := OldDateFormat;
    result := bEs;
  end;
end;


    Function TInspeccion.Informe: string;
    var
       cV: string;

    begin

        try
            if (Active) and (not IsNew)
            then begin
                try
                    if ValueByName[FIELD_TIPO][1] in [T_REVERIFICACION, T_VOLUNTARIAREVERIFICACION]
                    then cV := 'R'
                    else cV := '';

                    Result := Format('%1.2d %1.4d%1.4d%1.7d %s',[StrToInt(Copy(ValueByName[FIELD_EJERCICI],3,4)), fVarios.Zona, fVarios.CodeEstacion, StrToInt(ValueByName[FIELD_CODINSPE]), cV]);

                finally
                end;
            end
            else raise Exception.Create('The dataset is closed, or the record is New, or too many records are selected');
        except
            on E: Exception do
            begin
                fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'Error obteniendo un nº de inspección por: %s',[E.message]);
                raise Exception.Create('An error occur when gettin an inspection number');
            end
        end
    end;


Function TInspeccion.GetVehiculo:TVehiculo;
begin
    //Devuelve un objeto vehiculo que es el de la inspeccion
    If ((Active) and (RecordCount>0))
    then
        Result:=TVehiculo.CreateFromDataBase(fSagBd,DATOS_VEHICULOS,'WHERE '+FIELD_CODVEHIC+' = '+ValueByName[FIELD_CODVEHIC])
    Else
        Result:=nil;
end;


Function TInspeccion.GetFactura: TFacturacion;
begin
    //Devuelve la factura correspondiente al ainspeccion
    If ((Active) and (RecordCount>0))
    then
        Result:=TFacturacion.CreateFromDataBase(fSagBd,DATOS_FACTURAS,'WHERE '+FIELD_CODFACTU+' = '+ValueByName[FIELD_CODFACTU])
    else
        Result:=nil;
end;


Function TInspeccion.GetFactConAdicional: TFacturacion;
var ffact_auxi: TFacturacion;
begin
    //Devuelve la factura correspondiente al ainspeccion
    If ((Active) and (RecordCount>0))
    then begin
        ffact_auxi:=TFacturacion.CreateFromDataBase(fSagBd,DATOS_FACTURAS,'WHERE '+FIELD_CODFACTU+' = '+ValueByName[FIELD_CODFACTU]);
        ffact_auxi.open;
        ffact_auxi.ffactadicionales:=tfact_adicionales.CreateFromFactura(fSagBd,valuebyname[FIELD_CODFACTU],TIPO_FACTURA,TIPO_FACTURAGNC);
        result:=ffact_auxi;
    end
    else
        Result:=nil;
end;

Function TInspeccion.GetPropietario: TClientes;
begin
    //Devuel un objecto de la clase TSagClientes que es el propietario del vehiculo
    If ((Active) and (RecordCount>0))
    Then
        Result:=TClientes.CreateFromDataBase(fSagBd,DATOS_CLIENTES,'WHERE '+FIELD_CODCLIEN+' = '+ValueByName[FIELD_CODCLPRO])
    else
        Result:=nil;
end;

Function TInspeccion.GetTenedor: TClientes;
begin
    //Devuel un objecto de la clase TSagClientes que es el Tenedor del vehiculo
    If ((Active) and (RecordCount>0))
    then
        Result:=TClientes.CreateFromDataBase(fSagBd,DATOS_CLIENTES,'WHERE '+FIELD_CODCLIEN+' = '+ValueByName[FIELD_CODCLTEN])
    Else
        Result:=nil;
end;

Function TInspeccion.GetConductor: TClientes;
begin
    //Devuel un objecto de la clase TSagClientes que es el Conductor del vehiculo
    If ((Active) and (RecordCount>0))
    Then
        Result:=TClientes.CreateFromDataBase(fSagBd,DATOS_CLIENTES,'WHERE '+FIELD_CODCLIEN+' = '+ValueByName[FIELD_CODCLCON])
    else
        Result:=nil;
end;

function TInspeccion.InspeccionVigente : boolean;
begin
  result := false;
  if strtoDate(ValueByName[FIELD_VENCE]) >= StrToDate(DateBD(DataBase)) then
    result := true;
end;

function TInspeccion.InspeccionVigenteCon30 : boolean;
begin
  result := false;
  if copy(ValueByName[FIELD_RESULTADO],1,1) <> INSPECCION_APTA then
  begin
  if strtoDate(ValueByName[FIELD_VENCE]) >= StrToDate(DateBD(DataBase)) then
    result := true;
  end
  else
  begin
  if strtoDate(ValueByName[FIELD_VENCE])+30 >= StrToDate(DateBD(DataBase)) then
    result := true;
  end
end;

(******************************************************************************)
(*                                                                            *)
(*                               TInspeccionJoin                              *)
(*                                                                            *)
(******************************************************************************)

Constructor TInspeccionJoin.CreateFromPatente(aBd: TSQLConnection;aFilter: String);
begin
    //Constructor de la clase
    fFiltroPatente := aFilter;
    CreateFromColumns(aBd,DATOS_INSPECCIONES,SELECTED_FIELDS_TINSPECCION,aFilter);
end;


procedure TInspeccionJoin.SetFilter(const aValue: string);
    var
        OldActive : boolean;
    begin
        //Sobreescribe este metodo para poder modificar el filtro
        //insertando un JOIN con TINSPECCION
        OldActive := Active;
        try
            if Active
            then fSagQuery.Close;

            If Pos('WHERE',aValue)>0
            then begin
                //If pos (CONDITION_FIELDS,aValue)>0
                If pos (fFiltroPatente,aValue)>0
                then
                    fFilter := aValue
                else
                    fFilter := fFiltroPatente+' And '+Trim(Copy(aValue,Pos('WHERE',aValue)+6,length(aValue)));
                    //fFilter := CONDITION_FIELDS+' And '+Trim(Copy(aValue,Pos('WHERE',aValue)+6,length(aValue)));
            end
            else
                fFilter := fFiltroPatente+aValue;
                //fFilter := CONDITION_FIELDS+aValue;

            if fFilter <> ''
            then begin
                if fSQL.Count > 1
                then fSQL[1] := fFilter
                else fSQL.Add(fFilter);
                fSagQuery.commandtext := GetCommandText;
            end

        finally

            if OldActive
            then Open
        end;
    end;


(******************************************************************************)
(*                                                                            *)
(*                               TEstadoInspeccion                            *)
(*                                                                            *)
(******************************************************************************)

Constructor TSagInspeccion.CreateFromColumns(const aBD : TSQLConnection; const aTable : string; aColumns: string; aFilter: String);
begin
        //Sobreescribe este constructor para cojer el tipo del TINSPECCION
        WithColumns:=True;
        CreateFromDataBase(aBD,aTable,aFilter);
        FDefaultColumnas:=False;
        fColumnas := aColumns;
        FDefaultNulls:=TStringList.Create;
        fCursor := M_NIL;
        AddCursor;
        Filter:=aFilter;
end;

Constructor TEstadoInspeccion.Create(aBd: TSQLConnection;aFilter: String);
begin
    //Constructor de la clase
    //Inherited CreateFromDataBase(aBd,DATOS_ESTADOINSPECCION,aFilter);
    CreateFromColumns(aBd,DATOS_ESTADOINSPECCION,SELECTED_FIELDS,CONDITION_FIELDS);
end;

Constructor TEstadoInspeccion.CreateByRowId (aBd: TSQLConnection;aFilter: String);
begin
    Inherited CreateFromDataBase(aBd,DATOS_ESTADOINSPECCION,aFilter);
end;

procedure TEstadoInspeccion.SetFilter(const aValue: string);
var
    OldActive : boolean;
begin
    //Sobreescribe este metodo para poder modificar el filtro
    //insertando un JOIN con TINSPECCION
    If WithColumns
    then begin
        OldActive := Active;
        try
            if Active
            then fSagQuery.Close;

            If Pos('WHERE',aValue)>0
            then begin
                If pos (CONDITION_FIELDS,aValue)>0
                then
                    fFilter := aValue
                else
                    fFilter := CONDITION_FIELDS+' And '+Trim(Copy(aValue,Pos('WHERE',aValue)+6,length(aValue)));
            end
            else
                fFilter := CONDITION_FIELDS+aValue;

            if fFilter <> ''
            then begin
                if fSQL.Count > 1
                then fSQL[1] := fFilter
                else fSQL.Add(fFilter);
                fSagQuery.CommandText := GetCommandText;
            end

        finally

            if OldActive
            then Open
        end;
    end
    else begin
        Inherited SetFilter(aValue);
    end;
end;

Function TEstadoInspeccion.Cancelar: Boolean;
const
    UNICO = 1;
var
    //Cancela la inspeccion
    QryConsultas: TClientDataSet;
    sdsQryConsultas : TSQLDataSet;
    dspQryConsultas, dspQryConsultas1 : tdatasetprovider;
    iUnCodigo,iUnEjercicio: Integer;
    sEstado: String;
    fSQL : TStringList;
begin
    //Reinicia la inspeccion
    START;
    Result:=True;
    iUnCodigo := StrToInt(ValueByName[FIELD_CODINSPE]);
    iUnEjercicio := StrToInt(ValueByName[FIELD_EJERCICI]);
    sEstado:=E_FACTURADO;
    sdsQryConsultas := TSQLDataSet.Create(Application);
    sdsQryConsultas.SQLConnection := MyBD;
    sdsQryConsultas.CommandType := ctQuery;
    sdsQryConsultas.GetMetadata := false;
    sdsQryConsultas.NoMetadata := true;
    sdsQryConsultas.ParamCheck := false;    

    dspQryConsultas := TDataSetProvider.Create(application);
    dspQryConsultas.DataSet := sdsQryConsultas;
    dspQryConsultas.Options := [poIncFieldProps,poAllowCommandText];
    dspQryConsultas1 := TDataSetProvider.Create(application);
    dspQryConsultas1.DataSet := sdsQryConsultas;
    dspQryConsultas1.Options := [poIncFieldProps,poAllowCommandText, poAllowMultiRecordUpdates, poAutoRefresh];

    QryConsultas:=TClientDataSet.create(application);

    Try
        try
            { BLOQUEO DEL REGISTRO DE LA TABLA TESTADOINSPE PARA MODIFICARLO }

            with QryConsultas do
            begin
                SetProvider(dspQryConsultas);
                Close;
                fSQL := TStringList.Create;
                fSQL.Add('SELECT ESTADO ' +
                        'FROM TESTADOINSP ' +
                        'WHERE EJERCICI =:UnEjercicio AND CODINSPE =:UnCodigo ' +
                        'FOR UPDATE OF ESTADO NOWAIT');
                CommandText:=fSQL.text;
                params.ParamByName('UnEjercicio').value := iUnEjercicio;
                params.ParamByName('UnCodigo').value := iUnCodigo;
                Open;

                if RecordCount <> UNICO then raise Exception.Create('ERROR DE INTEGRIDAD EN TESTADOINSP');

                AnularReferencias;

                { ACTUALIZACION DE LA TABLA ESTADOINSECCION }
                Close;
                fSQL.Clear;
                fSQL.Add('DELETE TESTADOINSP ' +
                        format('WHERE EJERCICI = %s AND CODINSPE = %s ',[inttostr(iUnEjercicio),inttostr(iUnCodigo)]));
                CommandText := fSQL.Text;
                SetProvider(dspQryConsultas);
                Execute;

                { ACTUALIZACION DE LA TABLA INPSECCION }
                Close;
                SetProvider(dspQryConsultas1);
                fSQL.Clear;
                fSQL.Add('UPDATE TINSPECCION '+
                        'SET INSPFINA=''N'', '+
                        'RESULTAD = NULL, FECVENCI = NULL, '+
                        'HORFINAL = NULL '+
                        'WHERE EJERCICI =:UnEjercicio AND CODINSPE =:UnCodigo ');
                CommandText := fSQL.Text;

                params.ParamByName('UnEjercicio').value := iUnEjercicio;
                params.ParamByName('UnCodigo').value := iUnCodigo;
                Execute;
                Close;
            end; // with
            //Delete;
            //ValueByName[FIELD_ESTADO]:=ANULADO;
        except
            on E : Exception do
            begin
                result := False;
                fAnomalias.PonAnotacion(TRAZA_SIEMPRE,8,FILE_NAME,'NO SE PUDO CAMBIAR EL REGISTRO '
                                  + IntToStr(iUnEjercicio) + ' ' + IntToStr(iUnCodigo)
                                  + ' AL ESTADO ' + sEstado + ' POR: ' + E.message );
                ROLLBACK;
            end;
        end;
    Finally
        Try
            COMMIT;
        Except
        end;
        QryConsultas.Close;
        QryConsultas.Free;
        dspQryConsultas.Free;
        dspQryConsultas1.Free;
        sdsQryConsultas.Free;
    end;
end;


Function TEstadoInspeccion.RestaurarPreverificacion: Boolean;
var
    //Cancela la inspeccion
    QryConsultas: TClientDataSet;
    sdsQryConsultas : TSQLDataSet;
    dspQryConsultas, dspQryConsultas1 : tdatasetprovider;
    iUnCodigo,iUnEjercicio: Integer;
    sEstado: String;
    fSQL : TStringList;
begin

Result:=True;
START;
iUnCodigo := StrToInt(ValueByName[FIELD_CODINSPE]);
iUnEjercicio := StrToInt(ValueByName[FIELD_EJERCICI]);

sdsQryConsultas := TSQLDataSet.Create(Application);
sdsQryConsultas.SQLConnection := MyBD;
sdsQryConsultas.CommandType := ctQuery;
sdsQryConsultas.GetMetadata := false;
sdsQryConsultas.NoMetadata := true;
sdsQryConsultas.ParamCheck := false;

dspQryConsultas := TDataSetProvider.Create(application);
dspQryConsultas.DataSet := sdsQryConsultas;
dspQryConsultas.Options := [poIncFieldProps,poAllowCommandText];
dspQryConsultas1 := TDataSetProvider.Create(application);
dspQryConsultas1.DataSet := sdsQryConsultas;
dspQryConsultas1.Options := [poIncFieldProps,poAllowCommandText, poAllowMultiRecordUpdates, poAutoRefresh];

QryConsultas:=TClientDataSet.create(application);
  Try
    Try
      with QryConsultas do
        Begin
          fSQL := TStringList.Create;
          fSQL.Clear;

         { ACTUALIZACION DE LA TABLA ESTADOINSECCION }
          SetProvider(dspQryConsultas);
          Close;
          fSQL.Add('UPDATE TESTADOINSP SET TIPO = ''B'', ESTADO = ''C'' WHERE EJERCICI = :EJERCICIO AND CODINSPE = :CODINSPECCION');
          CommandText := fSQL.Text;
          params.ParamByName('EJERCICIO').value := iUnEjercicio;
          params.ParamByName('CODINSPECCION').value := iUnCodigo;
          Execute;

          { ACTUALIZACION DE LA TABLA INPSECCION }
          Close;
          SetProvider(dspQryConsultas1);
          fSQL.Clear;
          fSQL.Add('UPDATE TINSPECCION SET WASPRE = NULL WHERE EJERCICI =:EJERCICIO AND CODINSPE =:CODINSPECCION ');
          CommandText := fSQL.Text;
          params.ParamByName('EJERCICIO').value := iUnEjercicio;
          params.ParamByName('CODINSPECCION').value := iUnCodigo;
          Execute;
          Close;
          COMMIT;
        end;
      except
        on E : Exception do
          begin
            result := False;
            fAnomalias.PonAnotacion(TRAZA_SIEMPRE,8,FILE_NAME,'NO SE PUDO CAMBIAR EL REGISTRO '+ IntToStr(iUnEjercicio) + ' ' + IntToStr(iUnCodigo)
                                    + ' AL ESTADO ' + sEstado + ' POR: ' + E.message );
            ROLLBACK;
          end;
      end;
    Finally
      QryConsultas.Close;
      QryConsultas.Free;
      dspQryConsultas.Free;
      dspQryConsultas1.Free;
      sdsQryConsultas.Free;
    end;
end;




Function TEstadoInspeccion.Reiniciar: Boolean;
const
    UNICO = 1;
var
    QryConsultas: TClientDataSet;
    sdsQryConsultas : TSQLDataSet;
    dspQryConsultas,dspQryConsultas1 : tdatasetprovider;
    iUnCodigo,iUnEjercicio: Integer;
    sEstado: String;
    fsql : TStringList;
begin
    //Reinicia la inspeccion
    START;
    Result:=True;
    iUnCodigo := StrToInt(ValueByName[FIELD_CODINSPE]);
    iUnEjercicio := StrToInt(ValueByName[FIELD_EJERCICI]);
    sEstado:=E_FACTURADO;

    sdsQryConsultas := TSQLDataSet.Create(Application);
    sdsQryConsultas.SQLConnection := MyBD;
    sdsQryConsultas.CommandType := ctQuery;
    sdsQryConsultas.GetMetadata := false;
    sdsQryConsultas.NoMetadata := true;
    sdsQryConsultas.ParamCheck := false;

    dspQryConsultas := TDataSetProvider.Create(application);
    dspQryConsultas.DataSet := sdsQryConsultas;
    dspQryConsultas.Options := [poIncFieldProps,poAllowCommandText];

    dspQryConsultas1 := TDataSetProvider.Create(application);
    dspQryConsultas1.DataSet := sdsQryConsultas;
    dspQryConsultas1.Options := [poIncFieldProps,poAllowCommandText, poAllowMultiRecordUpdates, poAutoRefresh];


    QryConsultas:=TClientDataSet.create(application);
    Try
        try
            { BLOQUEO DEL REGISTRO DE LA TABLA TESTADOINSPE PARA MODIFICARLO }

            with QryConsultas do
            begin
                Close;
                SetProvider(dspQryConsultas);
                fsql := TStringList.Create;
                fSQL.Add('SELECT ESTADO FROM TESTADOINSP WHERE EJERCICI =:UnEjercicio AND CODINSPE =:UnCodigo ' +
                         'FOR UPDATE OF ESTADO NOWAIT');
                CommandText := fsql.Text;
                Params.ParamByName('UnEjercicio').value := iUnEjercicio;
                Params.ParamByName('UnCodigo').value := iUnCodigo;
                Open;
                if RecordCount <> UNICO then
                  raise Exception.Create('ERROR DE INTEGRIDAD EN TESTADOINSP');

                AnularReferencias;
                Close;

                { ACTUALIZACION DE LA TABLA INPSECCION }
                
                SetProvider(dspQryConsultas1);
                fSQL.Clear;
                fSQL.Add('SELECT HORFINAL, HORENTZ1, HORENTZ2, HORENTZ3, HORSALZ1, HORSALZ2, HORSALZ3 FROM TINSPECCION ' +
                         'WHERE EJERCICI =:UnEjercicio AND CODINSPE =:UnCodigo FOR UPDATE OF HORFINAL, HORENTZ1, HORENTZ2, HORENTZ3, ' +
                         'HORSALZ1, HORSALZ2, HORSALZ3  NOWAIT' );
                CommandText := fsql.Text;
                SetProvider(dspQryConsultas1);
                params.ParamByName('UnEjercicio').value := iUnEjercicio;
                params.ParamByName('UnCodigo').value := iUnCodigo;
                Open;
                if RecordCount <> UNICO then
                  raise Exception.Create('ERROR DE INTEGRIDAD EN TINSPECCION');
                Close;

                fSQL.Clear;
                fSQL.Add ('UPDATE TINSPECCION SET ');
                fSQL.Add ('INSPFINA = ''N'', RESULTAD = NULL, FECVENCI = NULL, ');
                fSQL.Add ('HORFINAL = NULL, HORENTZ1 = NULL, ');
                fSQL.Add ('HORENTZ2 = NULL, HORENTZ3 = NULL, ');
                fSQL.Add ('HORSALZ1 = NULL, HORSALZ2 = NULL, ');
                fSQL.Add ('HORSALZ3 = NULL ');
                fSQL.Add (format('WHERE EJERCICI = %S ',[inttostr(iUnEjercicio)]));
                fSQL.Add ('AND ' );
                fSQL.Add (format('CODINSPE = %S ',[inttostr(iUnCodigo)]));
                CommandText := fsql.Text;
                SetProvider(dspQryConsultas1);
                Execute;
                Close;

                SetProvider(dspQryConsultas);
                fSQL.Clear;
                fSQL.Add('UPDATE TESTADOINSP SET ESTADO =:UnEstado WHERE EJERCICI =:UnEjercicio AND CODINSPE =:UnCodigo ');
                CommandText := fsql.Text;
                params.ParamByName('UnEjercicio').value := iUnEjercicio;
                params.ParamByName('UnCodigo').value := iUnCodigo;
                params.ParamByName('UnEstado').AsString := sEstado;
                Execute;
                Close;
            end // with
        except
            on E : Exception do
            begin
                result := False;
                fAnomalias.PonAnotacion(TRAZA_SIEMPRE,8,FILE_NAME,'NO SE PUDO CAMBIAR EL REGISTRO '
                                  + IntToStr(iUnEjercicio) + ' ' + IntToStr(iUnCodigo)
                                  + ' AL ESTADO ' + sEstado + ' POR: ' + E.message );
                ROLLBACK;
            end;
        end;
    Finally
        Try
            COMMIT;
        Except
        end;
        QryConsultas.Close;
        QryConsultas.Free;
        dspQryConsultas.Free;
        dspQryConsultas1.Free;
        sdsQryConsultas.Free;
    end;
end;


Procedure TEstadoInspeccion.UnStandBy;
const
    UNICO = 1;
var
    QryConsultas: TClientDataSet;
    sdsQryConsultas : TSQLDataSet;
    dspQryConsultas , dspQryConsultas1: tdatasetprovider;
    iUnCodigo,iUnEjercicio: Integer;
    sEstado: String;
    fsql : TStringList;
    TraeDatos:TSQLQuery;

begin
//Reinicia la inspeccion puesta previamente en StandBy
START;
iUnCodigo := StrToInt(ValueByName[FIELD_CODINSPE]);
iUnEjercicio := StrToInt(ValueByName[FIELD_EJERCICI]);
sEstado:=E_FACTURADO;
sdsQryConsultas := TSQLDataSet.Create(Application);
sdsQryConsultas.SQLConnection := MyBD;
sdsQryConsultas.CommandType := ctQuery;
sdsQryConsultas.GetMetadata := false;
sdsQryConsultas.NoMetadata := true;
sdsQryConsultas.ParamCheck := false;

dspQryConsultas := TDataSetProvider.Create(application);
dspQryConsultas.DataSet := sdsQryConsultas;
dspQryConsultas.Options := [poIncFieldProps,poAllowCommandText];
dspQryConsultas1 := TDataSetProvider.Create(application);
dspQryConsultas1.DataSet := sdsQryConsultas;
dspQryConsultas1.Options := [poIncFieldProps,poAllowCommandText, poAllowMultiRecordUpdates, poAutoRefresh];

QryConsultas:=TClientDataSet.create(application);
  Try
    try
    { BLOQUEO DEL REGISTRO DE LA TABLA TESTADOINSPE PARA MODIFICARLO }
      with QryConsultas do
        begin
          SetProvider(dspQryConsultas);
          Close;
          fsql := tstringlist.create;
          fSQL.Add('SELECT ESTADO FROM TESTADOINSP WHERE EJERCICI =:UnEjercicio AND CODINSPE =:UnCodigo FOR UPDATE OF ESTADO NOWAIT');
          CommandText := fsql.Text;
          params.ParamByName('UnEjercicio').AsInteger := iUnEjercicio;
          params.ParamByName('UnCodigo').AsInteger := iUnCodigo;
          Open;
          if RecordCount <> UNICO then
            raise Exception.Create('ERROR DE INTEGRIDAD EN TESTADOINSP');

          { ACTUALIZACION DE LA TABLA INPSECCION }
          Close;
          fSQL.Clear;
          fSQL.Add('SELECT HORFINAL, HORENTZ1, HORENTZ2, HORENTZ3, HORSALZ1, HORSALZ2, HORSALZ3 ' +
                    'FROM TINSPECCION ' +
                    'WHERE EJERCICI =:UnEjercicio AND CODINSPE =:UnCodigo ' +
                    'FOR UPDATE OF HORFINAL, HORENTZ1, HORENTZ2, HORENTZ3, ' +
                    'HORSALZ1, HORSALZ2, HORSALZ3  NOWAIT' );
          CommandText := fsql.Text;
          SetProvider(dspQryConsultas1);
          params.ParamByName('UnEjercicio').AsInteger := iUnEjercicio;
          params.ParamByName('UnCodigo').AsInteger := iUnCodigo;
          Open;
          if RecordCount <> UNICO then
            raise Exception.Create('ERROR DE INTEGRIDAD EN TINSPECCION');

          Close;
          fSQL.Clear;
          fSQL.Add ('UPDATE TINSPECCION SET INSPFINA = ''N'', RESULTAD = NULL, FECVENCI = NULL, '+
                    'HORFINAL = NULL, HORENTZ1 = NULL, ' +
                    'HORENTZ2 = NULL, HORENTZ3 = NULL, ' +
                    'HORSALZ1 = NULL, HORSALZ2 = NULL, ' +
                    'HORSALZ3 = NULL ' +
                    format('WHERE EJERCICI = %s',[inttostr(iUnEjercicio)]) +
                    'AND ' +
                    format('CODINSPE = %s ',[inttostr(iUnCodigo)]));
          CommandText := fsql.Text;
          SetProvider(dspQryConsultas1);
          Execute;

          Close;
          fSQL.Clear;
          SetProvider(dspQryConsultas);
          fSQL.Add('UPDATE TESTADOINSP SET ESTADO =:UnEstado, HORAINIC = SYSDATE WHERE EJERCICI =:UnEjercicio AND CODINSPE =:UnCodigo ');
          CommandText := fsql.Text;
          params.ParamByName('UnEjercicio').value := iUnEjercicio;
          params.ParamByName('UnCodigo').value := iUnCodigo;
          params.ParamByName('UnEstado').AsString := sEstado;
          Execute;
          Close;
         end; // with
////////////////////////////////////////////////////////////////////////////////////////////////////
//    INSERTO EN TREENVIO PARA QUE EL SE LE PONGA EL 104 - 19/10/2007                             //
////////////////////////////////////////////////////////////////////////////////////////////////////
        TraeDatos:=TSQLQuery.Create(application);
        With TraeDatos do
          begin
            Close;
            SQL.Clear;
            SQLConnection:=mybd;
            SQL.Add('INSERT INTO TREENVIOLINEA (CODINSPE, FECHALTA, ESTADO) VALUES (:Cod_Inspeccion, SYSDATE, null)');
            ParamByName('Cod_Inspeccion').Value:=iUnCodigo;
            ExecSQL;
            Close;
          end;
////////////////////////////////////////////////////////////////////////////////////////////////////

      except
        on E : Exception do
          begin
            fAnomalias.PonAnotacion(TRAZA_SIEMPRE,8,FILE_NAME,'NO SE PUDO CAMBIAR EL REGISTRO '
                                  + IntToStr(iUnEjercicio) + ' ' + IntToStr(iUnCodigo)
                                  + ' AL ESTADO ' + sEstado + ' POR: ' + E.message );
            ROLLBACK;
          end;
      end;
  Finally
    Try
      COMMIT;
    Except
    end;
  QryConsultas.Close;
  QryConsultas.Free;
  dspQryConsultas.Free;
  sdsQryConsultas.Free;
  end;
end;


Function TEstadoInspeccion.StandBy: Boolean;
var
    QryConsultas: TClientDataSet;
    sdsQryConsultas : TSQLDataSet;
    dspQryConsultas : tdatasetprovider;
    iUnCodigo,iUnEjercicio: Integer;
    sEstado : string;
    fsql : TStringList;
begin
    //Recoje los valores para el StandBy
    If Not GetStandByValues
    Then begin
        Result:=False;
        Exit;
    end;

    //y si son correctos paSA A sTANDby
    START;
    //Result:=True;
    iUnCodigo := StrToInt(ValueByName[FIELD_CODINSPE]);
    iUnEjercicio := StrToInt(ValueByName[FIELD_EJERCICI]);
    sEstado:=E_STANDBY;
    sdsQryConsultas := TSQLDataSet.Create(Application);
    sdsQryConsultas.SQLConnection := MyBD;
    sdsQryConsultas.CommandType := ctQuery;
    sdsQryConsultas.GetMetadata := false;
    sdsQryConsultas.NoMetadata := true;
    sdsQryConsultas.ParamCheck := false;
    dspQryConsultas := TDataSetProvider.Create(application);
    dspQryConsultas.DataSet := sdsQryConsultas;
    dspQryConsultas.Options := [poIncFieldProps,poAllowCommandText];

    QryConsultas:=TClientDataSet.create(application);
    Try
        try
            with QryConsultas do
            begin
                SetProvider(dspQryConsultas);
                Close;
                fsql := TStringList.Create;
                fSQL.Add('UPDATE TESTADOINSP SET ESTADO='''+sEstado+''' ' +
                        ' WHERE EJERCICI =:UnEjercicio AND CODINSPE =:UnCodigo ');
                CommandText := fsql.Text;
                params.ParamByName('UnEjercicio').AsInteger := iUnEjercicio;
                params.ParamByName('UnCodigo').AsInteger := iUnCodigo;
                Execute;
                Result:=true;
                Close;
            end // with
        except
            on E : Exception do
            begin
                result := False;
                fAnomalias.PonAnotacion(TRAZA_SIEMPRE,8,FILE_NAME,'NO SE PUDO CAMBIAR EL REGISTRO '
                                  + IntToStr(iUnEjercicio) + ' ' + IntToStr(iUnCodigo)
                                  + ' AL ESTADO '+sEstado+' POR: ' + E.message );
                ROLLBACK;
            end;
        end;
    Finally
        Try
            COMMIT;
        Except
        end;
        QryConsultas.Close;
        QryConsultas.Free;
        dspQryConsultas.Free;
        sdsQryConsultas.Free;
    end;
end;


//********************************** VERSION SAG 4.00 **********************************************

Function TEstadoInspeccion.UnicaxUsuario: Boolean;
var
QryConsultas: TClientDataSet;
sdsQryConsultas : TSQLDataSet;
dspQryConsultas : tdatasetprovider;
iUnCodigo,iUnEjercicio: Integer;
sEstado : string;
fsql : TStringList;
begin
Result:=False;

sdsQryConsultas := TSQLDataSet.Create(Application);
sdsQryConsultas.SQLConnection := MyBD;
sdsQryConsultas.CommandType := ctQuery;
sdsQryConsultas.GetMetadata := false;
sdsQryConsultas.NoMetadata := true;
sdsQryConsultas.ParamCheck := false;
dspQryConsultas := TDataSetProvider.Create(application);
dspQryConsultas.DataSet := sdsQryConsultas;
dspQryConsultas.Options := [poIncFieldProps,poAllowCommandText];

QryConsultas:=TClientDataSet.create(application);
  Try
    with QryConsultas do
      Try
        SetProvider(dspQryConsultas);
        Close;
        CommandText:='SELECT COUNT(USUARIO) FROM TESTADOINSP WHERE USUARIO =:UnUsuario';
        params.ParamByName('UnUsuario').Value := UpperCase(GetUserName);
        Open;
        If Fields[0].AsInteger < 1 then
          Result:=true;
      Except
        Messagedlg('VEHICULO BLOQUEADO POR OTRO SUPERVISOR','Atención, el mismo usuario no puede abrir mas'+#13#10+
                   'de un vehiculo que se encuentra en la linea. Intente con otro usuario.', mtWarning, [mbOk],mbOk,0);
      end;
  finally
    QryConsultas.Close;
    QryConsultas.Free;
    dspQryConsultas.Free;
    sdsQryConsultas.Free;
  end;
end;


Function TEstadoInspeccion.IsBlockByUser: Boolean;
var
    QryConsultas: TClientDataSet;
    sdsQryConsultas : TSQLDataSet;
    dspQryConsultas : tdatasetprovider;
    iUnCodigo,iUnEjercicio: Integer;
    sEstado : string;
    fsql : TStringList;
begin
Result:=False;

iUnCodigo := StrToInt(ValueByName[FIELD_CODINSPE]);
iUnEjercicio := StrToInt(ValueByName[FIELD_EJERCICI]);

sdsQryConsultas := TSQLDataSet.Create(Application);
sdsQryConsultas.SQLConnection := MyBD;
sdsQryConsultas.CommandType := ctQuery;
sdsQryConsultas.GetMetadata := false;
sdsQryConsultas.NoMetadata := true;
sdsQryConsultas.ParamCheck := false;
dspQryConsultas := TDataSetProvider.Create(application);
dspQryConsultas.DataSet := sdsQryConsultas;
dspQryConsultas.Options := [poIncFieldProps,poAllowCommandText];

QryConsultas:=TClientDataSet.create(application);
  Try
    with QryConsultas do
      Try
        SetProvider(dspQryConsultas);
        Close;
        sdsQryConsultas.SQLConnection.StartTransaction(td);
        CommandText:='SELECT USUARIO FROM TESTADOINSP WHERE EJERCICI =:UnEjercicio AND CODINSPE =:UnCodigo FOR UPDATE NOWAIT';
        params.ParamByName('UnEjercicio').Value := ValueByName[FIELD_EJERCICI];
        params.ParamByName('UnCodigo').Value := ValueByName[FIELD_CODINSPE];
        Open;
        If Fields[0].AsString <> '' then
          Result:=true;
        sdsQryConsultas.SQLConnection.Commit(td);
      Except
        sdsQryConsultas.SQLConnection.Rollback(td);
        Messagedlg('VEHICULO BLOQUEADO POR OTRO SUPERVISOR','Atención, el vehiculo que esta intentado abrir ya se encuentra'+#13#10+
                   'bloqueado por otro inspector. Espere a que lo libere.', mtWarning, [mbOk],mbOk,0);
      end;
  finally
    QryConsultas.Close;
    QryConsultas.Free;
    dspQryConsultas.Free;
    sdsQryConsultas.Free;
  end;
end;


Procedure TEstadoInspeccion.UnBlockInsp;
var
    QryConsultas: TClientDataSet;
    sdsQryConsultas : TSQLDataSet;
    dspQryConsultas : tdatasetprovider;
    iUnCodigo,iUnEjercicio: Integer;
    sEstado : string;
    fsql : TStringList;
begin
iUnCodigo := StrToInt(ValueByName[FIELD_CODINSPE]);
iUnEjercicio := StrToInt(ValueByName[FIELD_EJERCICI]);

sdsQryConsultas := TSQLDataSet.Create(Application);
sdsQryConsultas.SQLConnection := MyBD;
sdsQryConsultas.CommandType := ctQuery;
sdsQryConsultas.GetMetadata := false;
sdsQryConsultas.NoMetadata := true;
sdsQryConsultas.ParamCheck := false;
dspQryConsultas := TDataSetProvider.Create(application);
dspQryConsultas.DataSet := sdsQryConsultas;
dspQryConsultas.Options := [poIncFieldProps,poAllowCommandText];

QryConsultas:=TClientDataSet.create(application);
  Try
    with QryConsultas do
      Try
        SetProvider(dspQryConsultas);
        Close;
        sdsQryConsultas.SQLConnection.StartTransaction(td);
        CommandText:='UPDATE TESTADOINSP SET USUARIO = null WHERE EJERCICI =:UnEjercicio AND CODINSPE =:UnCodigo ';
        params.ParamByName('UnEjercicio').AsInteger := iUnEjercicio;
        params.ParamByName('UnCodigo').AsInteger := iUnCodigo;
        Execute;
        sdsQryConsultas.SQLConnection.Commit(td);
        Close;
      except
        fAnomalias.PonAnotacion(TRAZA_SIEMPRE,8,FILE_NAME,'NO SE PUDO CAMBIAR EL REGISTRO '+ IntToStr(iUnEjercicio) + ' ' + IntToStr(iUnCodigo)
                                                            + ' AL ESTADO '+sEstado);
        sdsQryConsultas.SQLConnection.Rollback(td);
      end;
  Finally
    QryConsultas.Close;
    QryConsultas.Free;
    dspQryConsultas.Free;
    sdsQryConsultas.Free;
  end;
end;


Function TEstadoInspeccion.BlockInsp: Boolean;
var
    QryConsultas: TClientDataSet;
    sdsQryConsultas : TSQLDataSet;
    dspQryConsultas : tdatasetprovider;
    iUnCodigo,iUnEjercicio: Integer;
    sEstado : string;
    fsql : TStringList;
begin
Result:=False;

iUnCodigo := StrToInt(ValueByName[FIELD_CODINSPE]);
iUnEjercicio := StrToInt(ValueByName[FIELD_EJERCICI]);

sdsQryConsultas := TSQLDataSet.Create(Application);
sdsQryConsultas.SQLConnection := MyBD;
sdsQryConsultas.CommandType := ctQuery;
sdsQryConsultas.GetMetadata := false;
sdsQryConsultas.NoMetadata := true;
sdsQryConsultas.ParamCheck := false;
dspQryConsultas := TDataSetProvider.Create(application);
dspQryConsultas.DataSet := sdsQryConsultas;
dspQryConsultas.Options := [poIncFieldProps,poAllowCommandText];

QryConsultas:=TClientDataSet.create(application);
  Try
    with QryConsultas do
      Try
        SetProvider(dspQryConsultas);
        Close;
        sdsQryConsultas.SQLConnection.StartTransaction(td);
        CommandText:='SELECT USUARIO FROM TESTADOINSP WHERE EJERCICI =:UnEjercicio AND CODINSPE =:UnCodigo FOR UPDATE NOWAIT';
        params.ParamByName('UnEjercicio').Value := ValueByName[FIELD_EJERCICI];
        params.ParamByName('UnCodigo').Value := ValueByName[FIELD_CODINSPE];
        Open;
        If Fields[0].AsString = '' then
          Begin
            CommandText:='UPDATE TESTADOINSP SET USUARIO = :USUARIO WHERE EJERCICI =:UnEjercicio AND CODINSPE =:UnCodigo';
            params.ParamByName('UnEjercicio').Value:= ValueByName[FIELD_EJERCICI];
            params.ParamByName('UnCodigo').Value:= ValueByName[FIELD_CODINSPE];
            params.ParamByName('USUARIO').Value := UpperCase(GetUserName);
            Execute;
            Result:=true;
          end;
        sdsQryConsultas.SQLConnection.Commit(td);
      Except
        sdsQryConsultas.SQLConnection.Rollback(Td);
        DialogsFont.Size:=15;
        Messagedlg('VEHICULO BLOQUEADO POR OTRO USUARIO','Atención: El vehiculo que esta intentado abrir esta siendo'+#13#10+
                   'utlizado por otro usuario. Espere a que lo libere.', mtWarning, [mbOk],mbOk,0);
        DialogsFont.Size:=8;
      end;
  finally
    QryConsultas.Close;
    QryConsultas.Free;
    dspQryConsultas.Free;
    sdsQryConsultas.Free;
  end;
end;
//**************************************************************************************************


Procedure TEstadoInspeccion.AnularReferencias;
const
    ATABLASALIMPIAR : array [1..3] of string = (DATOS_TDATINSPECC, DATOS_TDATINSPEVI, DATOS_TINSPDEFECT);
var
    i: Integer;
    QryConsultas: TSQLQuery;
    sUnCodigo,sUnEjercicio: string;
    sEstado: String;
begin
    sUnCodigo := ValueByName[FIELD_CODINSPE];
    sUnEjercicio := ValueByName[FIELD_EJERCICI];
    sEstado:=E_FACTURADO;
    //Anula referencias a datos de otras tablas antes de borrar o reiniciar una inspeccion
     { BORRADO DE LAS TABLAS }
    QryConsultas:=TSQLQuery.create(application);
    Try
        With QryConsultas do
        begin
            SQLConnection:=fSagBd;
            for i := low(aTablasALimpiar) to high(aTablasALimpiar) do
            begin
                Close;
                SQL.Clear;
                SQL.Add(Format('DELETE FROM %s WHERE ' + FIELD_EJERCICI + ' = %s AND ' + FIELD_CODINSPE + ' = %s' ,[aTablasALimpiar[i], sUnEjercicio, sUnCodigo]));
                ExecSQL;
            end;
        end;
    Finally
        QryConsultas.ClosE;
        QryConsultas.Free;
    end;
end;


Function TEstadoInspeccion.GetStandByValues: Boolean;
var
    EnvioStandBy: TFrmToStandByData;
begin
    //Pide los datos para enviar una inspeccion a StandBy
    Result:=true;
    EnvioStandBy := TFrmToStandByData.CreateFromInspeccion(Self);
    Try
        if EnvioStandBy.Showmodal = mrCancel then Result:=False;
    Finally
        EnvioStandBy.Free;
    End;
end;


Function TEstadoInspeccion.Borrar: Boolean;
const
    UNICO = 1;
var
    //Cancela la inspeccion
    QryConsultas: TClientDataSet;
    sdsQryConsultas : TSQLDataSet;
    dspQryConsultas, dspQryConsultas1 : tdatasetprovider;
    iUnCodigo,iUnEjercicio: Integer;
    sEstado: String;
    fSQL : TStringList;
begin
//Borra la inspeccion de TESTADOINSP
START;
Result:=False;
iUnCodigo := StrToInt(ValueByName[FIELD_CODINSPE]);
iUnEjercicio := StrToInt(ValueByName[FIELD_EJERCICI]);

sdsQryConsultas := TSQLDataSet.Create(Application);
sdsQryConsultas.SQLConnection := MyBD;
sdsQryConsultas.CommandType := ctQuery;

sdsQryConsultas.GetMetadata := false;
sdsQryConsultas.NoMetadata := true;
sdsQryConsultas.ParamCheck := false;

dspQryConsultas := TDataSetProvider.Create(application);
dspQryConsultas.DataSet := sdsQryConsultas;
dspQryConsultas.Options := [poIncFieldProps,poAllowCommandText];
dspQryConsultas1 := TDataSetProvider.Create(application);
dspQryConsultas1.DataSet := sdsQryConsultas;
dspQryConsultas1.Options := [poIncFieldProps,poAllowCommandText, poAllowMultiRecordUpdates, poAutoRefresh];

QryConsultas:=TClientDataSet.create(application);
  Try
    try
      with QryConsultas do
        begin
          SetProvider(dspQryConsultas);
          Close;
          CommandText:= ('DELETE TESTADOINSP WHERE EJERCICI = :EJERCICIO AND CODINSPE =:CODINSPECCION');
          params.ParamByName('EJERCICIO').value := iUnEjercicio;
          params.ParamByName('CODINSPECCION').value := iUnCodigo;
          Execute;
          Result := True;
        end;
    except
      on E : Exception do
        begin
          fAnomalias.PonAnotacion(TRAZA_SIEMPRE,8,FILE_NAME,'NO SE PUDO BORRAR EL REGISTRO '+ IntToStr(iUnEjercicio) + ' ' + IntToStr(iUnCodigo)+
                                  ' EN LA TABLA TESTADOINSP POR: ' + E.message );
          ROLLBACK;
        end;
    end;
  Finally
    COMMIT;
  end;
  QryConsultas.Close;
  QryConsultas.Free;
  dspQryConsultas.Free;
  dspQryConsultas1.Free;
  sdsQryConsultas.Free;
end;







    constructor TPartidos.Create (const DVarios: TVarios);
    begin
       try
            DVarios.Open;
            fZona := DVarios.Zona;
            fProvincia := DVarios.CodProvi;
            inherited CreateFromDataBase(DVarios.DataBase,DATOS_PARTIDOS,Format('ORDER BY NOMBPART',[fProvincia,fZona]));
       except
            on E: Exception do
            begin
                fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Falló la carga de partidos por: %s',[E.message]);
                raise Exception.Create('The retrieve of "partidos" was wrong')
            end
        end
    end;

constructor TProvincias.Create (const aBD : TSQLConnection);
begin
    inherited CreateFromDataBase(aBD,DATOS_PROVINCIAS,' ORDER BY ' + FIELD_DESPROVI);
end;

procedure InitError(Msg: String);  //
    begin
        MessageDlg('Error',Msg,mtError,[mbOK],mbOK,0);
        if Assigned(fAnomalias)
        then fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FILE_NAME,Msg);
        InitializationError := TRUE;
    end;

constructor TPtoVenta.Create(const aBD : TSQLConnection);      // DE ACA PARA ABAJO
begin
    inherited CreateFromDataBase(aBD, DATOS_PTOVENTA ,'');         //VER RAN
end;

constructor TPtoVenta.CreateByTipo(const aBD: TSQLConnection; const atipo: string; aNroCaja: integer; avigente: string);
begin
  inherited CreateFromDataBase(aBD, DATOS_PTOVENTA, format('WHERE %s=''%s'' AND %s=%d AND %s=''%s''',[FIELD_TIPO,aTipo,FIELD_CAJA,aNroCaja,FIELD_VIGENTE,avigente]));
end;

constructor TPtoVenta.createbyNroPto(const aDB: TSQLConnection; aPtoVenta: integer);
begin
    inherited CreateFromDataBase(aDB, DATOS_PTOVENTA ,format('WHERE %s=%d',[FIELD_PTOVENTA,aPtoVenta]));
end;


function TPtoVenta.GetTipo: string;
var SuperRegistry: TSuperRegistry;
    nrocaja:integer;
//    tipostatus:widestring;
    aQ : TClientDataSet;
    sdsaQ : TSQLDataSet;
    dspaQ : TDataSetProvider;
begin
 try
  superregistry:=tsuperregistry.create;
  sdsaQ := TSQLDataSet.Create(Application);
  sdsaQ.SQLConnection := MyBD;
  sdsaQ.CommandType := ctQuery;
  sdsaQ.GetMetadata := false;
  sdsaQ.NoMetadata := true;
  sdsaQ.ParamCheck := false;
  dspaQ := TDataSetProvider.Create(application);
  dspaQ.DataSet := sdsaQ;
  dspaQ.Options := [poIncFieldProps,poAllowCommandText];

  aQ:=TClientDataSet.create(application);
  with SuperRegistry do
    try
      aQ.SetProvider(dspaQ);
      RootKey := HKEY_LOCAL_MACHINE;
      if not OpenKeyRead(CAJA_) then
        begin
          Messagedlg('ERROR','No se encontraron los parámetros de la Estación de Trabajo', mtInformation, [mbOk],mbOk,0);
//          result:='999';
          result:='E';
        end
      else
        begin
          nrocaja:= ReadInteger(NROCAJA_);
          aQ.CommandText := Format('SELECT PTOVENTA, TIPO FROM TPTOVENTA WHERE TIPO = ''C'' AND CAJA = %d AND VIGENTE = ''S''',[nrocaja]);
          aQ.open;
          if aQ.RecordCount > 0 then
          begin
                result:=aQ.Fields[1].AsString
          end
          else
          begin
            aq.close;
            aq.SetProvider(dspaQ);
            aQ.commandtext := Format('SELECT PTOVENTA, TIPO FROM TPTOVENTA WHERE TIPO = ''M'' AND CAJA = %d AND VIGENTE = ''S''',[nrocaja]);
            aQ.open;
            if aQ.RecordCount > 0 then
            begin
                 result:=(aQ.Fields[1].AsString)
            end
            else
            begin
//              result:='999';
              result:='E';
            end;
          end;
        end;

    except
        on E: exception do
           InitError(Format('No se leyeron correctamente los parametros por: %S', [E.message]));
        end;
 finally
   superregistry.free;
   aq.Free;
   dspaQ.Free;
   sdsaQ.Free;
 end;
end;

function TPtoVenta.GetPtoVenta: integer;
var SuperRegistry: TSuperRegistry;
    nrocaja:integer;
    tipostatus:widestring;
    aQ : TClientDataSet;
    sdsaq : TSQLDataSet;
    dspaQ : TDataSetProvider;
    soloreve:String;
begin
 try
  SuperRegistry:=tsuperregistry.Create;
  with SuperRegistry do
  try
    try
      sdsaQ := TSQLDataSet.Create(Application);
      sdsaQ.SQLConnection := MyBD;
      sdsaQ.CommandType := ctQuery;
      sdsaQ.GetMetadata := false;
      sdsaQ.NoMetadata := true;
      sdsaQ.ParamCheck := false;
      dspaQ := TDataSetProvider.Create(application);
      dspaQ.DataSet := sdsaQ;
      dspaQ.Options := [poIncFieldProps,poAllowCommandText];

      aQ:=TClientDataSet.create(application);
      aQ.setprovider(dspaq);

      RootKey := HKEY_LOCAL_MACHINE;
      if not OpenKeyRead(CAJA_) then
        begin
          Messagedlg('ERROR','No se encontraron los parámetros de la Estación de Trabajo', mtInformation, [mbOk],mbOk,0);
          result:=-1;
        end
      else
        begin
          soloreve:= ReadString(SOLOREVE_);
          nrocaja:= ReadInteger(NROCAJA_);
          aQ.commandtext := Format('SELECT PTOVENTA FROM TPTOVENTA WHERE TIPO = ''C'' AND CAJA = %d AND VIGENTE = ''S''',[nrocaja]);
          aQ.open;
          if aQ.RecordCount > 0 then
          begin

          if (ReadInteger(ESCAJA_) = 1) and (trim(soloreve)<>'S')  then
          begin
            impfis := CreateComObject(CLASS_PrinterFiscal) as _PrinterFiscalDisp;
            impfis.PortNumber:=PortNumber;
            impfis.BaudRate:=BaudRate;
            tipostatus:='C';
                if impfis.Status(tipostatus) then     //MODI
                    if strtoint(aQ.Fields[0].AsString)=strtoint(impfis.AnswerField_4) then
                       result:=strtoint(aQ.Fields[0].AsString)
                       else
                        begin
                          result:=-1;
                        end
                  else               //MODI
                   begin
                     result:=-1;
                   end;
          end
          else
            begin
                if (trim(soloreve)<>'S') then
                   result:=strtoint(aQ.Fields[0].AsString)
            end;
          end
          else
          begin
            aQ.close;
            aQ.SetProvider(dspaQ);
            aQ.CommandText := Format('SELECT PTOVENTA FROM TPTOVENTA WHERE TIPO = ''M'' AND CAJA = %d AND VIGENTE = ''S''',[nrocaja]);
            aQ.open;
            if aQ.RecordCount > 0 then
              result:=strtoint(aQ.Fields[0].AsString)
            else
            begin
              result:=-1;
            end;
          end;

        end;
    finally
      aQ.free;
      dspaQ.Free;
      sdsaq.Free;
    end;
  except
        on E: exception do
           InitError(Format('No se leyeron correctamente los parametros por: %S', [E.message]));
        end;
 finally
   superregistry.Free;
 end;

end;



function TPtoVenta.ES_SOLO_REVE:STRING;
var SuperRegistry: TSuperRegistry;
    nrocaja:integer;
    tipostatus:widestring;
    aQ : TClientDataSet;
    sdsaq : TSQLDataSet;
    dspaQ : TDataSetProvider;
    soloreve:String;
begin
 try
  SuperRegistry:=tsuperregistry.Create;
  with SuperRegistry do
  try


      RootKey := HKEY_LOCAL_MACHINE;
      if not OpenKeyRead(CAJA_) then
        begin
          Messagedlg('ERROR','No se encontraron los parámetros de la Estación de Trabajo', mtInformation, [mbOk],mbOk,0);

        end
      else
        begin
          soloreve:= ReadString(SOLOREVE_);
          nrocaja:= ReadInteger(NROCAJA_);
          ES_SOLO_REVE:=soloreve;
         END;

  except
        on E: exception do
           InitError(Format('No se leyeron correctamente los parametros por: %S', [E.message]));
        end;
 finally
   superregistry.Free;
 end;

end;



function TPtoVenta.GetVigente : string;
begin
    if not Active
    then Open;
    result := ValueByName[FIELD_VIGENTE]
end;

function TPtoVenta.EsCaja: boolean;
var SuperRegistry: TSuperRegistry;
    i:integer;
begin
 try
  superregistry:=tsuperregistry.create;
  with SuperRegistry do
    try
      result:=true;
      RootKey := HKEY_LOCAL_MACHINE;
      if not OpenKeyRead(CAJA_) then
        begin
          Messagedlg('ERROR','No se encontraron los parámetros de la Estación de Trabajo', mtInformation, [mbOk],mbOk,0);
          result:=false;
        end
      else
        begin
          i:= ReadInteger(ESCAJA_);
          if i=1 then result:=true
          else result:=false;
        end;
    except
        on E: exception do
           InitError(Format('No se leyeron correctamente los parametros por: %S', [E.message]));
        end;
 finally
   superregistry.Free;
 end;
end;

function TptoVenta.encendidoyfunciona:boolean;
var    tipostatus: widestring;
begin
     tipostatus:='N';
     impfis := CreateComObject(CLASS_PrinterFiscal) as _PrinterFiscalDisp;
     impfis.PortNumber:=PortNumber;
     impfis.BaudRate:=BaudRate;
     result:=true;
     if not (impfis.Status(tipostatus)) then
     begin
        result:=false;
     end;
end;

function TPtoVenta.StatusCF:boolean;
begin
     impfis := CreateComObject(CLASS_PrinterFiscal) as _PrinterFiscalDisp;
     impfis.PortNumber:=PortNumber;
     impfis.BaudRate:=BaudRate;
     if statusok(hexabina(impfis.fiscalstatus),'F',false) then
        result := true
     else
         result := false;
end;

Function TPtoVenta.ProximoNroFactura(aTipoFac: String):string;
var nrofactura: integer;
    tipostatus: widestring;
    aQ: TSQLQuery;
begin
  if gettipo = TIPO_CF then
  begin
     impfis := CreateComObject(CLASS_PrinterFiscal) as _PrinterFiscalDisp;
     impfis.PortNumber:=PortNumber;
     impfis.BaudRate:=BaudRate;
     if encendidoyfunciona then
     begin
        tipostatus := INF_NUMERADORES;
        impfis.Status(tipostatus);
        if aTipoFac = FACTURA_TIPO_A then
           nrofactura := strtoint(impfis.AnswerField_7)+1
        else
           nrofactura := strtoint(impfis.AnswerField_5)+1;
     end;
  end
  else
  begin
    try
        aQ:=TSQLQuery.create(application);
        aQ.SQLConnection:=self.database;



        if aTipoFac = FACTURA_TIPO_A then
           aQ.SQL.Add('SELECT LAST_NUMBER FROM USER_SEQUENCES WHERE SEQUENCE_NAME=''SQ_TFACTURAS_NUMFACTUA''')
        else
           aQ.SQL.Add('SELECT LAST_NUMBER FROM USER_SEQUENCES WHERE SEQUENCE_NAME=''SQ_TFACTURAS_NUMFACTUB''');
        aQ.Open;
        nrofactura := strtoint (aQ.Fields[0].asstring);
    finally
        aQ.close;
        aQ.Free;
    end;

  end;
  result:='"'+aTipoFac+'" '+formatoceros(getptoventa,4)+'-'+formatoceros(nrofactura,8);
end;

Constructor Tcierrez.Create(aBd: TSQLConnection);
begin
    inherited CreateFromDataBase(aBD,DATOS_CIERREZ,' ORDER BY ' + FIELD_NROULTIM);
end;

Constructor Tcierrez.CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
begin
    inherited CreateFromDataBase (aBD,DATOS_CIERREZ,Format('WHERE %S = ''%S''',[FIELD_ROWID, aRowId]));
end;

constructor tFact_Adicionales.createFromFactura (const aBD : TSQLConnection; const aCodFactu: string; aTipoFac, aTipoFac2: string);
begin
    inherited CreateFromDataBase (aBD,DATOS_FACT_ADICIONALES,Format('WHERE %S = ''%S'' and (TIPOFAC = ''%S'' or TIPOFAC = ''%S'')',[FIELD_CODFACT, acodfactu, aTipoFac, aTipoFac2]));
end;

constructor tFact_Adicionales.create (abd: TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_FACT_ADICIONALES,'');
end;

constructor tFact_Adicionales.CreateByRowid (const aBD : TSQLConnection; const aRowId: string);
begin
    inherited CreateFromDataBase (aBD,DATOS_FACT_ADICIONALES,Format('WHERE %S = ''%S''',[FIELD_ROWID, aRowId]));
end;

procedure TFact_adicionales.SetImporteDescuento(const aEjercicio, aCodigo: integer);
var
    aP: TsqlStoredProc;
begin
    try
        aP:= TSQLStoredProc.Create(nil);
        try
           aP.SQLConnection:=  mybd;
           {$IFDEF TRAZAS}
           fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME,'Obtención del importe de descuentos.');
           fTrazas.PonComponente(TRAZA_SQL,1,FILE_NAME,aP);
           {$ENDIF}

           aP.StoredProcName:= 'PQ_FACTURACION.IMPDESCUENT';
           aP.Params[0].Value := aEjercicio;
           aP.Params[1].Value := aCodigo;
           aP.ExecProc;
           {$IFDEF TRAZAS}
           fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME,'Execute de IMPDESCUENT: Ejercicio '+inttostr(aEjercicio)+' - Código '+inttostr(aCodigo) );
           {$ENDIF}
        finally
           aP.Close;
           aP.Free;
        end;
    except
        on E: Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error calculando el importe por: %S',[E.message]);
            raise
        end;
    end;

end;

procedure TFact_adicionales.SetImporteDescuento_Desc(const aEjercicio, aCodigo: integer; const aPorcDesc: real);
var
    aP: TSQLStoredProc;
begin
    try
        aP:= TSQLStoredProc.Create(application);
        try
           aP.SQLConnection:=  Self.Database;
           {$IFDEF TRAZAS}
           fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME,'Obtención del importe de descuentos.');
           fTrazas.PonComponente(TRAZA_SQL,1,FILE_NAME,aP);
           {$ENDIF}
           aP.StoredProcName:= 'PQ_FACTURACION.IMPDESCUENT_DESC';
           aP.ParamByName('EJERCICIO').value := aEjercicio;
           aP.ParamByName('CODIGO').value:= aCodigo;
           aP.ParamByName('PORCDESCUENTO').value:= aPorcDesc;
           aP.ExecProc;
           {$IFDEF TRAZAS}
           fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME,'Execute de IMPDESCUENT: Ejercicio '+inttostr(aEjercicio)+' - Código '+inttostr(aCodigo) );
           {$ENDIF}
        finally
           aP.Close;
           aP.Free;
        end;
    except
        on E: Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error calculando el importe por: %S',[E.message]);
            raise
        end;
    end;

end;

procedure TFact_adicionales.SetImporteDescuentoGNC_Desc(const aEjercicio, aCodigo: integer; const aPorcDesc: real);  //**************
var
    aP: TSQLStoredProc;
begin
    try
        aP:= TSQLStoredProc.Create(application);
        try
           aP.SQLConnection:=  Self.Database;
           {$IFDEF TRAZAS}
           fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME,'Obtención del importe de descuentos.');
           fTrazas.PonComponente(TRAZA_SQL,1,FILE_NAME,aP);
           {$ENDIF}
           aP.StoredProcName:= 'PQ_FACTURACION.IMPDESCUENT_GNC_DESC';
           aP.ParamByName('EJERCICIO').value := aEjercicio;
           aP.ParamByName('CODIGO').value:= aCodigo;
           aP.ParamByName('PORCDESCUENTO').value:= aPorcDesc;
           aP.ExecProc;
           {$IFDEF TRAZAS}
           fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME,'Execute de IMPDESCUENT: Ejercicio '+inttostr(aEjercicio)+' - Código '+inttostr(aCodigo) );
           {$ENDIF}
        finally
           aP.Close;
           aP.Free;
        end;
    except
        on E: Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error calculando el importe por: %S',[E.message]);
            raise
        end;
    end;

end;

procedure TFact_adicionales.SetImporteDescuentoGNC(const aEjercicio, aCodigo: integer);  //****************
var
    aP: TSQLStoredProc;
begin
    try
        aP:= TSQLStoredProc.Create(application);
        try
           aP.SQLConnection:=  Self.Database;
           {$IFDEF TRAZAS}
           fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME,'Obtención del importe de descuentos.');
           fTrazas.PonComponente(TRAZA_SQL,1,FILE_NAME,aP);
           {$ENDIF}
           aP.StoredProcName:= 'PQ_FACTURACION.IMPDESCUENT_GNC';
           aP.ParamByName('EJERCICIO').value := aEjercicio;
           aP.ParamByName('CODIGO').value:= aCodigo;
           aP.ExecProc;
           {$IFDEF TRAZAS}
           fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME,'Execute de IMPDESCUENT: Ejercicio '+inttostr(aEjercicio)+' - Código '+inttostr(aCodigo) );
           {$ENDIF}
        finally
           aP.Close;
           aP.Free;
        end;
    except
        on E: Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error calculando el importe por: %S',[E.message]);
            raise
        end;
    end;

end;



function TFact_adicionales.GetNombreTarjeta(const aCodTarjeta: string): string;
var fTarjeta: TTarjeta;
begin
    ftarjeta:=nil;
    try
       ftarjeta:= ttarjeta.CreateFromDataBase(self.database,DATOS_TARJETA,format('WHERE CODTARJET = %d',[strtoint(aCodTarjeta)]));
       ftarjeta.open;
       result := ftarjeta.valuebyname[FIELD_ABREVIA];
    finally
        ftarjeta.free;
    end;
end;

constructor TDatos_estacion.Create (aBD: TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_ESTACION,'');
end;

function tPtoventa.GetPtoVentaManual: integer;
var Super: TSuperRegistry;
    nrocaja:integer;
    aQ : TClientDataSet;
    sdsaq : TSQLDataSet;
    dspaq : TDataSetProvider;
begin
 super:=nil;
 try
  Super:=tsuperregistry.Create;
  with super do
  try
    sdsaQ := TSQLDataSet.Create(Application);
    sdsaQ.SQLConnection := MyBD;
    sdsaQ.CommandType := ctQuery;
    sdsaQ.GetMetadata := false;
    sdsaQ.NoMetadata := true;
    sdsaQ.ParamCheck := false;
    dspaQ := TDataSetProvider.Create(application);
    dspaQ.DataSet := sdsaQ;
    dspaQ.Options := [poIncFieldProps,poAllowCommandText];

    aQ:=TClientDataSet.create(application);
    try
      aQ.SetProvider(dspaq);

      RootKey := HKEY_LOCAL_MACHINE;
      if not OpenKeyRead(CAJA_) then
        begin
          Messagedlg('ERROR','No se encontraron los parámetros de la Estación de Trabajo', mtInformation, [mbOk],mbOk,0);
          result:=null;
        end
      else
        begin
         nrocaja:= ReadInteger(NROCAJA_);
         aQ.CommandText := Format('SELECT PTOVENTA FROM TPTOVENTA WHERE TIPO = ''M'' AND CAJA = %d AND VIGENTE = ''S''',[nrocaja]);
         aQ.open;
         if aQ.RecordCount > 0 then
              result:=strtoint(aQ.Fields[0].AsString)
         else
            begin
              result:=null;
            end;
        end;
    finally
      aQ.free;
      dspaq.Free;
      sdsaq.Free;
    end;
  except
        on E: exception do
           InitError(Format('No se leyeron correctamente los parametros por: %S', [E.message]));
  end;
 finally
   super.Free;
 end;
end;

constructor TTarjeta.Create (aBD: TSQLConnection);
  begin
    inherited CreateFromDataBase (aBD,DATOS_TARJETA,'');
end;

constructor tTarjeta.CreateByCodTarjet(aBD: TSQLConnection; aCodTarjet: string);
begin
    inherited CreateFromDataBase (aBD,DATOS_TARJETA,format('WHERE CODTARJET = ''%S''',[aCodTarjet]));
end;

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
      inherited CreateFromDataBase (aBD,DATOS_DESCUENTOS,'WHERE ACTIVO = ''S'' AND (FECVIGINI <= SYSDATE AND FECVIGFIN >= SYSDATE OR (FECVIGINI <= SYSDATE AND FECVIGFIN IS NULL)) ORDER BY CODDESCU');
end;

constructor TDEscuento.CreateConFechas(aBD: TSQLConnection; aDateIni, aDateFin: string);
begin
      inherited CreateFromDataBase (aBD,DATOS_DESCUENTOS,format('WHERE ACTIVO = ''S'' AND (FECVIGINI <= TO_DATE(''%S'',''dd/mm/yyyy hh24:mi:ss'') AND (FECVIGINI >= TO_DATE(''%S'',''dd/mm/yyyy hh24:mi:ss'') OR (FECVIGFIN >= TO_DATE(''%S'',''dd/mm/yyyy hh24:mi:ss'') OR FECVIGFIN IS NULL)))',[adatefin, adateini, adateini]))
end;

constructor TCheque.Create (aBD: TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_CHEQUES,'');
end;

constructor TCheque.CreateFromFactura (aBD: TSQLConnection; aCodFactu: string);
begin
    inherited CreateFromDataBase (aBD,DATOS_CHEQUES,Format('WHERE %S = ''%S''',[FIELD_CODFACTU, aCodFactu]));
end;

constructor TCheque.CreateByRowID(const aBD: TSQLConnection; const aRowId: string);
begin
  inherited CreateFromDataBase (aBD,DATOS_CHEQUES,Format('WHERE %S = ''%S''',[FIELD_ROWID, aRowId]));
end;

function TCheque.DevolverNroBanco:string;
begin
  try
    with tbancos.CreateFromCodBanco(MyBD,self.ValueByname[FIELD_CODBANCO]) do
    begin
      try
        open;
        result:=Valuebyname[FIELD_NROBANCO];
      finally
        free;
      end;
    end;
  except
        on E: Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'Falla la obtencion del Nro de Banco por: %S',[E.message]);
            raise;
        end
  end;

end;

constructor TBancos.Create (aBD: TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_BANCOS,' ORDER BY ' + FIELD_NROBANCO);
end;

constructor TBancos.CreateFromCodBanco(aBD: TSQLConnection; aCodBanco: String);
begin
    inherited CreateFromDataBase (aBD,DATOS_BANCOS,format('WHERE CODBANCO = ''%S''',[aCodBanco]));
end;

constructor TSucursales.Create (aBD: TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_SUCURSALES,'');
end;

constructor TSucursales.CreateFromBanco(const aBD: TSQLConnection; const aCodBanco: string);
begin
    inherited CreateFromDataBase(aBD,DATOS_SUCURSALES,format('WHERE %S = ''%S'''+' ORDER BY ' + FIELD_CODSUCURSAL,[FIELD_CODBANCO,aCodBanco]));
end;

constructor TMonedas.Create (aBD: TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_MONEDAS,'');
end;

constructor tDatosPromocion.Create (aBD: TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_PROMOCION,'');
end;

constructor tDatosPromocion.CreateFromFactura(aBD: TSQLConnection; aCodFactu, aCodclien, aCodDesc: string);
begin
    inherited CreateFromDataBase (aBD,DATOS_PROMOCION,format('WHERE CODFACTU = ''%s'' AND CODCLIEN = ''%s'' AND CODDESCU = ''%s''',[aCodFactu, aCodclien, aCodDesc]));
end;

(******************************************************************************)
(*                                                                            *)
(*                             TEncuestasSatisfaccion                         *)
(*                                                                            *)
(******************************************************************************)

constructor TEncuestaSatisfaccion.Create (aBD: TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_ENCUESTAS_SATISFACCION,'ORDER BY FECHA');
end;

constructor TEncuestaSatisfaccion.CreateBySerie (aBD: TSQLConnection; aSerie: integer);
begin
    inherited CreateFromDataBase (aBD,DATOS_ENCUESTAS_SATISFACCION,format('WHERE SERIE = %D ORDER BY FECHA',[aSerie]));
end;

function TEncuestaSatisfaccion.serie: string;
var fSeries : tSeries_Encuestas;
begin
  result := '0';
  try
     fSeries := tSeries_Encuestas.CreateByFecha(mybd,valuebyname[FIELD_FECHA]);
     fSeries.open;
     if fSeries.RecordCount > 0 then
     begin
       result := fSeries.ValueByName[FIELD_SERIE];
     end;
     fSeries.free;
  except
        on E: Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'Falla la obtencion de la Serie de las Encuestas por: %S',[E.message]);
            raise;
        end

  end;

end;

(******************************************************************************)
(*                                                                            *)
(*                                   TDatInspecc                              *)
(*                                                                            *)
(******************************************************************************)

constructor TDatInspecc.Create (aBD: TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_DATINSPECC,'');
end;

constructor TDatInspecc.CreatebyCodEjer;
begin
        //Crea un objeto tdatinspecc a aprtir de los datos de un ESTADOINPECCION
        Inherited CreateFromDataBase(aInspeccion.DataBase,DATOS_DATINSPECC,
                Format(' WHERE %S = %S AND %S = %S ',
                [FIELD_EJERCICI,aInspeccion.ValueByName[FIELD_EJERCICI],
                FIELD_CODINSPE,aInspeccion.ValueByName[FIELD_CODINSPE]]));

end;

constructor TDatInspecc.CreateByEjerCodinspe(const aBD: TSQLConnection; const aEjercici, aCodInspe: string);
begin
    inherited CreateFromDataBase (aBD,DATOS_DATINSPECC,Format('WHERE EJERCICI = %S AND CODINSPE = %S',[aEjercici,aCodinspe]));
end;

constructor TDatInspecc.CreatebyInspecc;
begin
        //Crea un objeto tdatinspecc a aprtir de los datos de una INPECCION
        Inherited CreateFromDataBase(aInspeccion.DataBase,DATOS_DATINSPECC,
                Format(' WHERE %S = %S AND %S = %S ',
                [FIELD_EJERCICI,aInspeccion.ValueByName[FIELD_EJERCICI],
                FIELD_CODINSPE,aInspeccion.ValueByName[FIELD_CODINSPE]]));
end;


function tDatInspecc.GetDominio:string;
begin
  try
    with TSQLQuery.create(application) do
      try
        SQLConnection:=self.database;
        sql.add('SELECT NVL(PATENTEN, PATENTEA) FROM TVEHICULOS V, TINSPECCION I ');
        SQL.ADD(FORMAT('WHERE CODINSPE = %D AND EJERCICI = %D ',[strtointDef(valuebyname[field_codinspe],0),strtointdef(valuebyname[field_ejercici],0)]));
        SQL.ADD('AND V.CODVEHIC = I.CODVEHIC');
        open;
        result:=fields[0].asstring;
      finally
        close;
        free;
      end;
  except
        on E: Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'Falla la obtencion del dominio del vehículo: %S',[E.message]);
            raise;
        end
  end;
end;


function tDatInspecc.GetInspectoresLineasByApellido: TRevisor;
var
I: Integer;
begin
  try
    with TSQLQuery.create(application) do
      try
        SQLConnection:=self.database;
        For I:=1 to High(TRevisor) do
          Begin
            SQL.Clear;
            SQL.Add('SELECT (R.APPEREVIS ||'' ''|| R.NOMREVIS) FROM TREVISOR R, TDATINSPECC I WHERE I.EJERCICI = :EJERCICIO AND ');
            SQL.Add('I.CODINSPE = :CODINSPE AND R.NUMREVIS = I.NUMREVZ'+IntToStr(I)+'');
            Params[0].Value:= ValueByName[FIELD_EJERCICI];
            Params[1].Value:= Valuebyname[FIELD_CODINSPE];
            Open;
            Result[I]:=fields[0].asstring;
          end;
        vNomyAppInspector:=Result;
      finally
        close;
        free;
      end;
  except
    on E: Exception do
      begin
        fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'Falla la obtencion del Inspector del vehículo: %S',[E.message]);
      raise;
    end
  end;
end;

function tDatInspecc.GetInspectoresLineasByCodigo: TRevisor;
var
I: Integer;
begin
  try
    with TSQLQuery.create(application) do
      try
        SQLConnection:=self.database;
          Begin
            SQL.Clear;
            SQL.Add('SELECT I.NUMREVZ1, I.NUMREVZ2, I.NUMREVZ3 FROM TDATINSPECC I WHERE I.EJERCICI = :EJERCICIO AND I.CODINSPE = :CODINSPE');
            Params[0].Value:= ValueByName[FIELD_EJERCICI];
            Params[1].Value:= Valuebyname[FIELD_CODINSPE];
            Open;
            Result[1]:=fields[0].asstring;
            Result[2]:=fields[1].asstring;
            Result[3]:=fields[2].asstring;
          end;
        vCodInspector:=Result;
        GetInspectoresLineasByApellido;
      finally
        close;
        free;
      end;
  except
    on E: Exception do
      begin
        fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'Falla la obtencion del Inspector del vehículo: %S',[E.message]);
      raise;
    end
  end;
end;

function tDatInspecc.GetNroInforme:string;
begin
  try
    with TSQLQuery.create(application) do
      try
        SQLConnection:=self.database;
        sql.add('SELECT SUBSTR(EJERCICI,3,2),CODINSPE FROM TINSPECCION I ');
        SQL.ADD(FORMAT('WHERE CODINSPE = %D AND EJERCICI = %D ',[strtointDef(valuebyname[field_codinspe],0),strtointDef(valuebyname[field_ejercici],0)]));
//        SQL.ADD('AND V.CODVEHIC = I.CODVEHIC');
        open;
        result:=fields[0].asstring+' '+formatoceros(fVarios.Zona,4)+formatoceros(fVarios.CodeEstacion,4)+formatoceros(fields[1].asinteger,7);
      finally
        close;
        free;
      end;
  except
        on E: Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'Falla la obtencion del dominio del vehículo: %S',[E.message]);
            raise;
        end
  end;
end;


(******************************************************************************)
(*                                                                            *)
(*                                  TCambiosFecha                             *)
(*                                                                            *)
(******************************************************************************)

constructor TCambiosFecha.CreateByRowID(const aBD: TSQLConnection; const aRowId: string);
begin
    inherited CreateFromDataBase (aBD,DATOS_CAMBIOSFECHA,Format('WHERE a.ROWID = ''%S''',[aRowId]));
end;

constructor TCambiosFecha.CreateByCodEjer(const aBD: TSQLConnection; const aEjercici, aCodInspe: string);
begin
    inherited CreateFromDataBase (aBD,DATOS_CAMBIOSFECHA,Format('WHERE EJERCICI = %S AND CODINSPE = %S ORDER BY FECHA_V_OLD',[aEjercici,aCodinspe]));
end;

constructor TMotivos_Cambios.Create (aBD: TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_MOTIVOS_CAMBIOS,'');
end;

(******************************************************************************)
(*                                                                            *)
(*                               TCambiosFecha_gnc                            *)
(*                                                                            *)
(******************************************************************************)

constructor TCambiosFecha_gnc.CreateByRowID(const aBD: TSQLConnection; const aRowId: string);
begin
    inherited CreateFromDataBase (aBD,DATOS_CAMBIOSFECHA_GNC,Format('WHERE a.ROWID = ''%S''',[aRowId]));
end;

constructor TCambiosFecha_gnc.CreateByCodEjer(const aBD: TSQLConnection; const aEjercici, aCodInspe: string);
begin
    inherited CreateFromDataBase (aBD,DATOS_CAMBIOSFECHA_GNC,Format('WHERE EJERCICI = %S AND CODINSPE = %S ORDER BY FECHA_V_OLD',[aEjercici,aCodinspe]));
end;

constructor TMotivos_Cambios_gnc.Create (aBD: TSQLConnection);
begin
    inherited CreateFromDataBase (aBD,DATOS_MOTIVOS_CAMBIOS_GNC,'');
end;


(******************************************************************************)
(*                                                                            *)
(*                               TSeries_Encuestas                            *)
(*                                                                            *)
(******************************************************************************)

constructor TSeries_Encuestas.CreateByFecha(aBD: TSQLConnection; aFecha: string);
var x:longint;
begin
x:=5;
    with TSQLQuery.create(application) do
     try
       SQLConnection:= mybd;

       

       sql.add('alter session set nls_date_format = ''dd/mm/yyyy''');
       execsql;
     finally
       free;
     end;
   inherited CreateFromDataBase (aBD,DATOS_SERIES_ENCUESTAS,format('WHERE (''%s'' BETWEEN FECHA_INICIO AND FECHA_FIN) OR (''%S'' >= FECHA_INICIO AND FECHA_FIN IS NULL)',[aFecha, aFecha]));
  // inherited CreateFromDataBase (aBD,DATOS_SERIES_ENCUESTAS,format('WHERE ( to_date(''%s'',''dd/mm/yyyy'') BETWEEN FECHA_INICIO AND FECHA_FIN) OR (to_date(''%s'',''dd/mm/yyyy'') >= FECHA_INICIO AND FECHA_FIN IS NULL) OR (SERIE=5)',[aFecha, aFecha]));




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

constructor TPreguntas_Encuestas.CreateBySerie(aBD: TSQLConnection; aserie: string);
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

(******************************************************************************)
(*                                                                            *)
(*                               TInspGNC                                     *)
(*                                                                            *)
(******************************************************************************)


Constructor TInspGNC.Create(aBd: TSQLConnection;aFilter: String);
begin
        //Constructor de la clase
        Inherited CreateFromDataBase(aBd,DATOS_INSPGNC,aFilter);
end;


constructor TInspGNC.CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
begin
        inherited CreateFromDataBase (aBD,DATOS_INSPGNC,Format('WHERE ROWID = ''%S''',[aRowId]));
end;


function TInspGNC.GetValueKey (const aFieldName : string) : string;
     var
        a,m,d: Word;
     begin
        //Sobrerescribe este metodo para esta base que utiliza una clave doble
        if Pos(aFieldName,SequenceName) <> 0
        then begin
            if fSagQuery.FieldByName(aFieldName).IsNull
            then result := IntToStr(GetValorSecuenciador);
        end
        else begin
            //Devolver clave para el otro campo parte de la clave de la tabla
            if fSagQuery.FieldByName(aFieldName).IsNull
            then begin
                Decodedate(StrToDate(DateBD(Database)),a,m,d);
                result := IntTostr(a);
            end
            else result := fSagQuery.FieldByName(aFieldName).AsString
        end
end;

Constructor TInspGNC.CreateFromEstadoInspeccion;
begin
        //Crea un objeto inspecciongnc a aprtir de los datos de un ESTADOINPGNC
        Inherited CreateFromDataBase(aInspeccion.DataBase,DATOS_INSPGNC,
                Format(' WHERE %S = %S AND %S = %S ',
                [FIELD_EJERCICI,aInspeccion.ValueByName[FIELD_EJERCICI],
                FIELD_CODINSPGNC,aInspeccion.ValueByName[FIELD_CODINSPGNC]]));
end;


Function TInspGNC.GetPropietario: TClientes;
begin
    //Devuel un objecto de la clase TSagClientes que es el propietario del vehiculo
    If ((Active) and (RecordCount>0))
    Then
        Result:=TClientes.CreateFromDataBase(fSagBd,DATOS_CLIENTES,'WHERE '+FIELD_CODCLIEN+' = '+ValueByName[FIELD_CODCLIEN])
    else
        Result:=nil;
end;

Function TInspGNC.GetConductor: TClientes;
begin
    //Devuel un objecto de la clase TSagClientes que es el Conductor del vehiculo
    If ((Active) and (RecordCount>0))
    Then
        Result:=TClientes.CreateFromDataBase(fSagBd,DATOS_CLIENTES,'WHERE '+FIELD_CODCLIEN+' = '+ValueByName[FIELD_CODCLCON])
    else
        Result:=nil;
end;

function TInspGNC.GetNumOblea: string;
begin
        try
          Result:='';
          result := ValueByname[FIELD_OBLEANUEVA];
        except
            on E:Exception do
        end;
end;

Function TInspGNC.GetVehiculo:TVehiculo;
begin
    //Devuelve un objeto vehiculo que es el de la inspeccion
    If ((Active) and (RecordCount>0))
    then
        Result:=TVehiculo.CreateFromDataBase(fSagBd,DATOS_VEHICULOS,'WHERE '+FIELD_CODVEHIC+' = '+ValueByName[FIELD_CODVEHIC])
    Else
        Result:=nil;
end;

function TInspGNC.GetInspector: string;
begin
  with TSQLQuery.create(application) do
    try
       SQLConnection := mybd;
       sql.add(format('SELECT NOMREVIS FROM TREVISOR WHERE NUMREVIS = %S',[valuebyName[FIELD_NUMREVIS]]));
       open;
       result := fields[0].asstring;
    finally
      free;
    end;
end;

procedure TInspGNC.COMMIT;
begin
        if StrToInt(ValueByName[FIELD_CODINSPGNC]) = -1
        then begin
            Edit;
            ValueByName[FIELD_CODINSPGNC] := IntToStr(GetValorSecuenciador);
            Post(true);
        end;
        inherited commit;
end;

Function TInspGNC.Informe: string;
begin
        try
            if (Active) and (not IsNew)
            then begin
                try
                    Result := Format('%1.2d %1.4d%1.4d%1.6d',[StrToInt(Copy(ValueByName[FIELD_EJERCICI],3,4)), fVarios.Zona, fVarios.CodeEstacion, StrToInt(ValueByName[FIELD_CODINSPGNC])]);
                finally
                end;
            end
            else raise Exception.Create('The dataset is closed, or the record is New, or too many records are selected');
        except
            on E: Exception do
            begin
                fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'Error obteniendo un nº de inspección por: %s',[E.message]);
                raise Exception.Create('An error occur when gettin an inspection number');
            end
        end
end;

function TInspGNC.VerImprimirInformeGNC (const bVisualizar: boolean; aContexto: pTContexto; const sZona, sEstacion: string): boolean;
var
      frmInspeccion_Auxi: TfrmInformeGNC;
begin
        frmInspeccion_Auxi := nil;
        try
            frmInspeccion_Auxi := TfrmInformeGNC.CreateFromInspeccion (Self, 1, bVisualizar, aContexto);
            Result := frmInspeccion_Auxi.ImprimirInformeGNC;
        finally
            frmInspeccion_Auxi.Free;
        end;
end;

function TInspGNC.VerImprimirTAmarilla (const bVisualizar: boolean; aContexto: pTContexto; const sZona, sEstacion: string): boolean;
var
         FrmTamarilla_Auxi: TFrmTAmarilla;
begin
         FrmTamarilla_Auxi := TFrmTAmarilla.CreateFromCertificado (Self, bVisualizar, aContexto);
         Try
            Result := FrmTamarilla_Auxi.ImprimirCertificado;
         Finally
            FrmTamarilla_Auxi.Free;
         end;
end;

Function TInspGNC.GetFactura: TFacturacion;
begin
    //Devuelve la factura correspondiente a la inspeccion
    If ((Active) and (RecordCount>0))
    then
        Result:=TFacturacion.CreateFromDataBase(fSagBd,DATOS_FACTURAS,'WHERE '+FIELD_CODFACTU+' = '+ValueByName[FIELD_CODFACTU])
    else
        Result:=nil;
end;

function TInspGNC.LlevaCombo (aCodvehic : string): string;
var fechaR, fechaA : tdate;
    codinspe, resulta : string;
    sds : TSQLDataSet;
    dsp : TDataSetProvider;
begin
  result := '0';

  sds := TSQLDataSet.Create(Application);
  sds.SQLConnection := MyBD;
  sds.CommandType := ctQuery;
  sds.GetMetadata := false;
  sds.NoMetadata := true;
  sds.ParamCheck := false;
  dsp := TDataSetProvider.Create(application);
  dsp.DataSet := sds;
  dsp.Options := [poIncFieldProps,poAllowCommandText];

  with TClientDataSet.create(application) do
    try
      SetProvider(dsp);
      CommandText := format('select CODINSPE, FECHALTA, RESULTADO, SYSDATE  from inspgnc where codvehic = %s and INSPFINA = ''S'' and codinspe is not null ORDER BY FECHALTA DESC',[aCodVehic]);
      open;
      if recordcount > 0 then
      begin
        fechaR := fields[1].asdatetime;
        fechaA := fields[3].asdatetime;
        codinspe := fields[0].asstring;
        resulta := fields[2].asstring;
        if (resulta = INSPECCION_RECHAZADO) and ((fechaA - fechaR) < DIAS_VALIDO_COMBO) then
          result := codinspe;
      end;
    finally
      free;
      dsp.Free;
      sds.Free;
    end;
end;


procedure TInspGNC.AfterPost(aDataSet: TDataSet);
begin
         inherited AfterPost (aDataSet);
         fFilter := Format('WHERE EJERCICI = %s AND CODINSPGNC = %s',[CurrEjercicio,CurrCodInspe])
end;

procedure TInspGNC.BeforePost(aDataSet: TDataSet);
begin
        CurrCodInspe:= ValueByName[FIELD_CODINSPGNC];
        CurrEjercicio:=ValueByName[FIELD_EJERCICI];
        Inherited BeforePost(aDataSet);
end;


(******************************************************************************)
(*                                                                            *)
(*                               TEquiposGNC                                  *)
(*                                                                            *)
(******************************************************************************)

procedure TEquiposGNC.AfterPost(aDataSet: TDataSet);
begin
         inherited AfterPost (aDataSet);
         fFilter := Format('WHERE CODEQUIGNC = %s',[CurrCodEqui])
end;

procedure TEquiposGNC.BeforePost(aDataSet: TDataSet);
begin
        CurrCodEqui:= ValueByName[FIELD_CODEQUIGNC];
        Inherited BeforePost(aDataSet);
end;

constructor TEquiposGNC.CreateByCodequi(const aBD: TSQLConnection; const aCodEquip: string);
begin
        inherited CreateFromDataBase (aBD,DATOS_EQUIPOSGNC,Format('WHERE CODEQUIGNC = %S',[aCodEquip]))
end;


constructor TEquiposGNC.CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
begin
        inherited CreateFromDataBase (aBD,DATOS_EQUIPOSGNC,Format('WHERE ROWID = ''%S''',[aRowId]));
end;

function TEquiposGNC.GetCilindro: TEquiGNC_Cilindro;
begin
  result := TequiGNC_Cilindro.CreateByCodequi(MyBD,ValueByName[FIELD_CODEQUIGNC]);
end;

function TEquiposGNC.GetRegulador : TReguladores;
begin
  if ValueByName[FIELD_CODREGULADOR] <> '' then
    result := TReguladores.CreateByCodRegulador(MyBD,ValueByName[FIELD_CODREGULADOR])
  else
    result := TReguladores.CreateByRowId(MyBD,'');
end;

procedure TEquiposGNC.SetEquipo
 (var aEquipo: TEquiposGNC; const aRegOrig, aRegActual: tReguladores;
          aCilOrig, aCilActual: TCilindros; var aEqui_Cilindro : TequiGNC_Cilindro);
  function CilindrosIguales(aCilOrig, aCilActual: TCilindros): boolean;
    var NoEncontro: boolean;
  begin
    result := false;
    NoEncontro := False;
    aCilActual.open;
    aCilOrig.Open;
    if aCilOrig.RecordCount <> aCilActual.RecordCount then
      exit;
      aCilActual.First;
      while not aCilActual.eof do
      begin
        if not aCilOrig.locate(FIELD_CODCILINDRO, aCilActual.valueByName[FIELD_CODCILINDRO],[]) then
        begin
          NoEncontro := True;
          exit;
        end;
        aCilActual.next;
      end;
    result := not NoEncontro;
  end;

  function ReguladoresIguales(aRegOrig, aRegActual: TReguladores): boolean;
  begin
    result := false;
    if aRegActual.RecordCount > 0 then
    begin
      if (aRegOrig.ValueByName[FIELD_ROWID] <> aRegActual.ValueByName[FIELD_ROWID]) then
        result := false
      else
        result := true;
    end
    else
      if aRegOrig.RecordCount > 0 then
        result := false
      else
        result := true;
  end;

begin
  aRegOrig.Open;
  aRegActual.Open;
    if not (ReguladoresIguales(aRegOrig,aRegActual))
     or not (cilindrosIguales(aCilOrig, aCilActual)) then
     begin
      aEquipo.close;
      aEquipo := TEquiposGNC.CreateByRowId(MyBD,'');
      aEquipo.Open;
      aEquipo.ValueByName[FIELD_CODREGULADOR] := aRegActual.ValueByName[FIELD_CODREGULADOR];
      aEquipo.Post(true);
      aEqui_Cilindro.Close;
      aEqui_Cilindro := TequiGNC_Cilindro.CreateByRowId(MyBD,'');
      aEqui_Cilindro.Open;
      with aCilActual do
      begin
        first;
        while not eof do
        begin
             aEqui_Cilindro.Append;
             aEqui_Cilindro.ValueByName[FIELD_CODEQUIGNC] := aEquipo.ValueByName[FIELD_CODEQUIGNC];
             aEqui_Cilindro.ValueByName[FIELD_CODCILINDRO] := ValueByName[FIELD_CODCILINDRO];
             next;
        end;
        if aEqui_Cilindro.DataSet.State in [dsInsert,dsEdit] then
          aEqui_Cilindro.Post(true);
      end;
    end;
end;


(******************************************************************************)
(*                                                                            *)
(*                               TEquiGNC_cilindro                            *)
(*                                                                            *)
(******************************************************************************)

constructor TEquiGNC_Cilindro.CreateByCodequi(const aBD: TSQLConnection; const aCodEquip: string);
begin
        inherited CreateFromDataBase (aBD,DATOS_EQUIGNC_CILINDRO,Format('WHERE CODEQUIGNC = %S',[aCodEquip]));
end;

constructor TEquiGNC_Cilindro.CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
begin
        inherited CreateFromDataBase (aBD,DATOS_EQUIGNC_CILINDRO,Format('WHERE ROWID = ''%S''',[aRowId]));
end;

function TEquiGNC_Cilindro.GetCilindros : TCilindros;
var
  codigos : string;
begin
  if not (active) then open;
  first;
  codigos := '';
  while not eof do
  begin
    if codigos = '' then codigos := ValueByName[FIELD_CODCILINDRO]
    else
      codigos := codigos +','+ValueByName[FIELD_CODCILINDRO];
    next;
  end;
  if codigos <> '' then
    result := tCilindros.CreateByConCodigos(MyBD,codigos)
  else
    result := tCilindros.CreateByRowId(MyBD,'');
end;

(******************************************************************************)
(*                                                                            *)
(*                                  TReguladores                              *)
(*                                                                            *)
(******************************************************************************)

constructor TReguladores.CreateByCodRegulador(const aBD: TSQLConnection; const aCodRegulador: string);
begin
        inherited CreateFromDataBase (aBD,DATOS_REGULADORES,Format('WHERE CODREGULADOR = %S',[aCodRegulador]));
end;

constructor TReguladores.CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
begin
        inherited CreateFromDataBase (aBD,DATOS_REGULADORES,Format('WHERE ROWID = ''%S''',[aRowId]));
end;

Function TReguladores.GetCodEnargas: string;
begin
  with TSQLQuery.create(application) do
    try
      SQLConnection := mybd;

      

      sql.Add(format('SELECT CODIGO FROM REGULADORESENARGAS WHERE IDREGULADOR = %S',[valueByName[FIELD_IDREGULADOR]]));
      open;
      result := Fields[0].value;
    finally
      free;
    end;
end;

constructor TReguladores.CreateByIDRegSerie(const aBD : TSQLConnection; const aIdRegulador, aNroSerie: string);
begin

        inherited CreateFromDataBase (aBD,DATOS_REGULADORES,Format('WHERE NROSERIE = ''%S'' AND IDREGULADOR = %S',[aNroSerie, aIdRegulador]));
end;

constructor TReguladores.CreateByCopy (const aRegulador : TReguladores);
begin
        inherited CreateFromDataBase(aRegulador.fSagBD,DATOS_REGULADORES,Format('WHERE %S = ''%S''',[FIELD_ROWID,aRegulador.ValueByName[FIELD_ROWID]]));
end;


(******************************************************************************)
(*                                                                            *)
(*                                  TCilindros                                *)
(*                                                                            *)
(******************************************************************************)


constructor TCilindros.CreateByConCodigos(const aBD: TSQLConnection; const aCodCilindro: string);
begin
        inherited CreateFromDataBase (aBD,DATOS_CILINDROS,Format('WHERE CODCILINDRO IN (%S)',[aCodCilindro]));
end;

constructor TCilindros.CreateByCodCilindro (const aBD : TSQLConnection; const aCodCilindro: string);
begin
        inherited CreateFromDataBase (aBD,DATOS_CILINDROS,Format('WHERE CODCILINDRO = %S',[aCodCilindro]));
end;

constructor TCilindros.CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
begin
        inherited CreateFromDataBase (aBD,DATOS_CILINDROS,Format('WHERE ROWID = ''%S''',[aRowId]));
end;

constructor TCilindros.CreateByIDCilSerie(const aBD : TSQLConnection; const aIdCilindro, aNroSerie: string);
begin

        inherited CreateFromDataBase (aBD,DATOS_CILINDROS,Format('WHERE NROSERIE = ''%S'' AND IDCILINDRO = %S',[aNroSerie, aIdCilindro]));
end;

constructor TCilindros.CreateByCopy (const aCilindro : TCilindros);
begin
        inherited CreateFromDataBase(aCilindro.fSagBD,DATOS_CILINDROS,Format('WHERE %S = ''%S''',[FIELD_ROWID,aCilindro.ValueByName[FIELD_ROWID]]));
end;


Function TCilindros.GetCodEnargas: string;
begin
  with TSQLQuery.create(application) do
    try
      SQLConnection := mybd;

      

      sql.Add(format('SELECT CODIGO FROM CILINDROSENARGAS WHERE IDCILINDRO = %S',[valueByName[FIELD_IDCILINDRO]]));
      open;
      result := Fields[0].value;
    finally
      free;
    end;
end;

Function TCilindros.GetCodValvEnargas: string;
begin
  if valueByName[FIELD_IDVALVULA] = '' then
  begin
    result := '';
    exit;
  end;
  with TSQLQuery.create(application) do
    try
      SQLConnection := mybd;



      sql.Add(format('SELECT CODIGO FROM VALVULASENARGAS WHERE IDVALVULA = %S',[valueByName[FIELD_IDVALVULA]]));
      open;
      result := Fields[0].value;
    finally
      free;
    end;
end;

function TCilindros.GetCRPC: string;
begin
  if valueByName[FIELD_IDCRPC] = '' then
  begin
    result := '';
    exit;
  end;
  with TSQLQuery.create(application) do
    try
      SQLConnection := mybd;
      sql.Add(format('SELECT CODCRPC FROM CENTROSRPC WHERE IDCRPC = %S',[valueByName[FIELD_IDCRPC]]));
      open;
      result := Fields[0].value;
    finally
      free;
    end;
end;


(******************************************************************************)
(*                                                                            *)
(*                           TREGULADORESENARGAS                              *)
(*                                                                            *)
(******************************************************************************)


constructor tReguladoresEnargas.Create (aBD: TSQLConnection);
begin
     inherited CreateFromDataBase (aBD,DATOS_REGULADORESENARGAS,' ORDER BY CODIGO');
end;

constructor tReguladoresEnargas.CreateByCodigo (const aBD : TSQLConnection; const aCodigo : string);
begin
     inherited CreateFromDataBase (aBD,DATOS_REGULADORESENARGAS,format('WHERE CODIGO = ''%S''',[aCodigo]));
end;

constructor tReguladoresEnargas.CreateById (const aBD : TSQLConnection; const aCodigo : string);
begin
     inherited CreateFromDataBase (aBD,DATOS_REGULADORESENARGAS,format('WHERE IDREGULADOR = ''%S''',[aCodigo]));
end;

(******************************************************************************)
(*                                                                            *)
(*                           TCILINDROSENARGAS                                *)
(*                                                                            *)
(******************************************************************************)

constructor TCilindrosEnargas.Create (aBD: TSQLConnection);
begin
     inherited CreateFromDataBase (aBD,DATOS_CILINDROSENARGAS,' ORDER BY CODIGO');
end;


(******************************************************************************)
(*                                                                            *)
(*                               TCentrosRPC                                  *)
(*                                                                            *)
(******************************************************************************)

constructor TCentrosRPC.Create (aBD: TSQLConnection);
begin
     inherited CreateFromDataBase (aBD,DATOS_CENTROSRPC,'');
end;


(******************************************************************************)
(*                                                                            *)
(*                           TValvulasEnargas                                 *)
(*                                                                            *)
(******************************************************************************)

constructor TValvulasEnargas.Create (aBD: TSQLConnection);
begin
     inherited CreateFromDataBase (aBD,DATOS_VALVULASENARGAS,'');
end;


(******************************************************************************)
(*                                                                            *)
(*                            TESTADOINSPGNC                                  *)
(*                                                                            *)
(******************************************************************************)

constructor TEstadoInspGNC.Create (aBD: TSQLConnection);
begin
     inherited CreateFromDataBase (aBD,DATOS_ESTADOINSPGNC,'');
end;

constructor TEstadoInspGNC.CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
begin
        inherited CreateFromDataBase (aBD,DATOS_ESTADOINSPGNC,Format('WHERE ROWID = ''%S''',[aRowId]));
end;

constructor TEstadoInspGNC.CreateAutosEnLinea(abd: TSQLConnection);
begin
        inherited CreateFromDataBase (aBD,DATOS_ESTADOINSPGNC,Format('WHERE ESTADO = ''%S''',[V_ESTADOS_INSP [teVerificandose]]));
end;

constructor TEstadoInspGNC.CreateAutosEnEspera(abd: TSQLConnection);
begin
        inherited CreateFromDataBase (aBD,DATOS_ESTADOINSPGNC,Format('WHERE ESTADO in (''%S'',''%S'',''%S'',''%S'')',[E_RECIBIDO_OK,E_PENDIENTE_SIC,E_MODIFICADO,E_FACTURADO]));
end;

Procedure TEstadoInspGNC.AnularReferencias;
const
    ATABLASALIMPIAR : array [1..1] of string = (DATOS_INSPGNC_DEFECTOS);
var
    i: Integer;
    QryConsultas: TSQLQuery;
    sUnCodigo,sUnEjercicio: string;
    sEstado: String;
begin
    sUnCodigo := ValueByName[FIELD_CODINSPGNC];
    sUnEjercicio := ValueByName[FIELD_EJERCICI];
    sEstado:=E_PENDIENTE_SIC;
    //Anula referencias a datos de otras tablas antes de borrar o reiniciar una inspeccion
     { BORRADO DE LAS TABLAS }
    QryConsultas:=TSQLQuery.create(application);
    Try
        With QryConsultas do
        begin
            SQLConnection:=fSagBd;
            for i := low(aTablasALimpiar) to high(aTablasALimpiar) do
            begin
                Close;
                SQL.Clear;
                SQL.Add(Format('DELETE FROM %s WHERE ' + FIELD_EJERCICI + ' = %s AND ' + FIELD_CODINSPGNC + ' = %s' ,[aTablasALimpiar[i], sUnEjercicio, sUnCodigo]));
                ExecSQL;
            end;
        end;
    Finally
        QryConsultas.ClosE;
        QryConsultas.Free;
    end;
end;


Function TEstadoInspGNC.Cancelar: Boolean;
const
    UNICO = 1;
var
    //Cancela la inspeccion
    QryConsultas: TClientDataSet;
    sdsQryConsultas: TSQLDataSet;
    dspQryConsultas, dspQryConsultas1 : TDataSetProvider;
    iUnCodigo,iUnEjercicio: Integer;
    sEstado: String;
    fSQL : TStringList;
begin
    //cancela la inspeccion
    START;
    Result:=True;
    iUnCodigo := StrToInt(ValueByName[FIELD_CODINSPGNC]);
    iUnEjercicio := StrToInt(ValueByName[FIELD_EJERCICI]);
    sEstado:=E_PENDIENTE_SIC;
    sdsQryConsultas := TSQLDataSet.Create(Application);
    sdsQryConsultas.SQLConnection := MyBD;
    sdsQryConsultas.CommandType := ctQuery;
    sdsQryConsultas.GetMetadata := false;
    sdsQryConsultas.NoMetadata := true;
    sdsQryConsultas.ParamCheck := false;    
    dspQryConsultas := TDataSetProvider.Create(application);
    dspQryConsultas.DataSet := sdsQryConsultas;
    dspQryConsultas.Options := [poIncFieldProps,poAllowCommandText];
    dspQryConsultas1 := TDataSetProvider.Create(application);
    dspQryConsultas1.DataSet := sdsQryConsultas;
    dspQryConsultas1.Options := [poIncFieldProps,poAllowCommandText];

    fSQL := TStringList.Create;

    QryConsultas:=TClientDataSet.create(application);
    Try
        try
            { BLOQUEO DEL REGISTRO DE LA TABLA ESTADOINSPGNC PARA MODIFICARLO }

            with QryConsultas do
            begin
                SetProvider(dspQryConsultas);
                Close;
                fSQL := TStringList.Create;
                fSQL.Add('SELECT ESTADO ' +
                        'FROM ESTADOINSPGNC ' +
                        'WHERE EJERCICI =:UnEjercicio AND CODINSPGNC =:UnCodigo ' +
                        'FOR UPDATE OF ESTADO NOWAIT');
                CommandText := fSQL.Text;
                params.ParamByName('UnEjercicio').AsInteger := iUnEjercicio;
                params.ParamByName('UnCodigo').AsInteger := iUnCodigo;
                Open;
                if RecordCount <> UNICO then raise Exception.Create('ERROR DE INTEGRIDAD EN ESTADOINSPGNC');

                AnularReferencias;

                { ACTUALIZACION DE LA TABLA ESTADOINSECCION }
                Close;
                fSQL.Clear;
                fSQL.Add('DELETE ESTADOINSPGNC ' +
                       format( 'WHERE EJERCICI = %s AND CODINSPGNC = %s ',[inttostr(iUnEjercicio),inttostr(iUnCodigo)]));
                CommandText := fSQL.Text;
                SetProvider(dspQryConsultas);
                Execute;

                { ACTUALIZACION DE LA TABLA INPSPGNC }
                Close;
                SetProvider(dspQryConsultas1);
                fSQL.Clear;
                fSQL.Add('UPDATE INSPGNC '+
                        'SET INSPFINA=''N'', '+
                        'RESULTADO = NULL, FECHVENCI = NULL, '+
                        'HORFINAL = NULL '+
                        format('WHERE EJERCICI =%S AND CODINSPGNC =%S ',[IntToStr(iUnEjercicio),IntToStr(iuncodigo)]));
                CommandText := fSQL.Text;
                Execute;
                Close;
            end; // with
            //Delete;
            //ValueByName[FIELD_ESTADO]:=ANULADO;
        except
            on E : Exception do
            begin
                result := False;
                fAnomalias.PonAnotacion(TRAZA_SIEMPRE,8,FILE_NAME,'NO SE PUDO CAMBIAR EL REGISTRO '
                                  + IntToStr(iUnEjercicio) + ' ' + IntToStr(iUnCodigo)
                                  + ' AL ESTADO ' + sEstado + ' POR: ' + E.message );
                ROLLBACK;
            end;
        end;
    Finally
        Try
            COMMIT;
        Except
        end;
        QryConsultas.Close;
        QryConsultas.Free;
        dspQryConsultas.Free;
        dspQryConsultas1.Free;        
        sdsQryConsultas.Free;
    end;
end;

Function TEstadoInspGNC.Reiniciar: Boolean;
const
    UNICO = 1;
var
    QryConsultas: TClientDataSet;
    sdsQryConsultas: TSQLDataSet;
    dspQryConsultas, dspQryConsultas1 : TDataSetProvider;
    iUnCodigo,iUnEjercicio: Integer;
    sEstado: String;
    fSQL : TStringList;
begin
    //Reinicia la inspeccion
    START;
    Result:=True;
    iUnCodigo := StrToInt(ValueByName[FIELD_CODINSPGNC]);
    iUnEjercicio := StrToInt(ValueByName[FIELD_EJERCICI]);
    sEstado:=E_PENDIENTE_SIC;
    sdsQryConsultas := TSQLDataSet.Create(Application);
    sdsQryConsultas.SQLConnection := MyBD;
    sdsQryConsultas.CommandType := ctQuery;
    sdsQryConsultas.GetMetadata := false;
    sdsQryConsultas.NoMetadata := true;
    sdsQryConsultas.ParamCheck := false;    
    dspQryConsultas := TDataSetProvider.Create(application);
    dspQryConsultas.DataSet := sdsQryConsultas;
    dspQryConsultas.Options := [poIncFieldProps,poAllowCommandText];
    dspQryConsultas1 := TDataSetProvider.Create(application);
    dspQryConsultas1.DataSet := sdsQryConsultas;
    dspQryConsultas1.Options := [poIncFieldProps,poAllowCommandText, poAllowMultiRecordUpdates, poAutoRefresh];

    fSQL := TStringList.Create;

    QryConsultas:=TClientDataSet.create(application);
    Try
        try
            { BLOQUEO DEL REGISTRO DE LA TABLA TESTADOINSPGNC PARA MODIFICARLO }

            with QryConsultas do
            begin
                SetProvider(dspQryConsultas);
                Close;
                fSQL.Add('SELECT ESTADO ' +
                        'FROM ESTADOINSPGNC ' +
                        'WHERE EJERCICI =:UnEjercicio AND CODINSPGNC =:UnCodigo ' +
                        'FOR UPDATE OF ESTADO NOWAIT');
                CommandText := fSQL.Text;
                params.ParamByName('UnEjercicio').AsInteger := iUnEjercicio;
                params.ParamByName('UnCodigo').AsInteger := iUnCodigo;
                Open;
                if RecordCount <> UNICO then raise Exception.Create('ERROR DE INTEGRIDAD EN ESTADOINSPGNC');

                AnularReferencias;

                { ACTUALIZACION DE LA TABLA INPSECCION }
                Close;
                SetProvider(dspQryConsultas1);
                fSQL.Clear;
                fSQL.Add('SELECT HORFINAL, HORENTFOSA, HORSALFOSA ' +
                        'FROM INSPGNC ' +
                        'WHERE EJERCICI =:UnEjercicio AND CODINSPGNC =:UnCodigo ' +
                        'FOR UPDATE OF HORFINAL, HORENTFOSA, HORSALFOSA NOWAIT' );
                CommandText := fSQL.Text;
                params.ParamByName('UnEjercicio').AsInteger := iUnEjercicio;
                params.ParamByName('UnCodigo').AsInteger := iUnCodigo;
                Open;
                if RecordCount <> UNICO then raise Exception.Create('ERROR DE INTEGRIDAD EN INSPGNC');

                Close;
                SetProvider(dspQryConsultas1);
                fSQL.Clear;
                fSQL.Add ('UPDATE INSPGNC ' +
                        'SET ' +
                        'INSPFINA = ''N'', RESULTADO = NULL, FECHVENCI = NULL, '+
                        'HORFINAL = NULL, HORENTFOSA = NULL, ' +
                        'HORSALFOSA = NULL ' +
                        format('WHERE EJERCICI = %s ',[inttostr(iUnEjercicio)]) +
                        'AND ' +
                        format('CODINSPGNC =%s ',[inttostr(iUnCodigo)]));
                CommandText := fSQL.Text;
                Execute;

                Close;
                SetProvider(dspQryConsultas);
                fSQL.Clear;
                fSQL.Add('UPDATE ESTADOINSPGNC ' +
                        'SET ESTADO =:UnEstado ' +
                        'WHERE EJERCICI =:UnEjercicio ' +
                        'AND ' +
                        'CODINSPGNC =:UnCodigo ');
                CommandText := fSQL.Text;
                params.ParamByName('UnEjercicio').AsInteger := iUnEjercicio;
                params.ParamByName('UnCodigo').AsInteger := iUnCodigo;
                params.ParamByName('UnEstado').AsString := sEstado;
                Execute;
                Close;
            end // with
        except
            on E : Exception do
            begin
                result := False;
                fAnomalias.PonAnotacion(TRAZA_SIEMPRE,8,FILE_NAME,'NO SE PUDO CAMBIAR EL REGISTRO '
                                  + IntToStr(iUnEjercicio) + ' ' + IntToStr(iUnCodigo)
                                  + ' AL ESTADO ' + sEstado + ' POR: ' + E.message );
                ROLLBACK;
            end;
        end;
    Finally
        Try
            COMMIT;
        Except
        end;
        QryConsultas.Close;
        QryConsultas.Free;
        dspQryConsultas.Free;
        dspQryConsultas1.Free;
        sdsQryConsultas.Free;
    end;
end;

Function TEstadoInspGNC.Rechazar: Boolean;
const
    UNICO = 1;
var
    //Rechaza y finaliza la inspeccion
    QryConsultas: TClientDataSet;
    sdsQryConsultas: TSQLDataSet;
    dspQryConsultas, dspQryConsultas1 : TDataSetProvider;
    fSQL : TStringList;
    iUnCodigo,iUnEjercicio: Integer;
    sEstado: String;
begin
    START;
    Result:=True;
    iUnCodigo := StrToInt(ValueByName[FIELD_CODINSPGNC]);
    iUnEjercicio := StrToInt(ValueByName[FIELD_EJERCICI]);
    sEstado:=E_PENDIENTE_SIC;
    sdsQryConsultas := TSQLDataSet.Create(Application);
    sdsQryConsultas.SQLConnection := MyBD;
    sdsQryConsultas.CommandType := ctQuery;
    sdsQryConsultas.GetMetadata := false;
    sdsQryConsultas.NoMetadata := true;
    sdsQryConsultas.ParamCheck := false;
    dspQryConsultas := TDataSetProvider.Create(application);
    dspQryConsultas.DataSet := sdsQryConsultas;
    dspQryConsultas.Options := [poIncFieldProps,poAllowCommandText];
    dspQryConsultas1 := TDataSetProvider.Create(application);
    dspQryConsultas1.DataSet := sdsQryConsultas;
    dspQryConsultas1.Options := [poIncFieldProps,poAllowCommandText];

    fSQL := TStringList.Create;

    QryConsultas:=TClientDataSet.create(application);
    Try
        try
            { BLOQUEO DEL REGISTRO DE LA TABLA ESTADOINSPGNC PARA MODIFICARLO }

            with QryConsultas do
            begin
                SetProvider(dspQryConsultas);
                Close;
                fSQL.Clear;
                fSQL.Add('SELECT ESTADO ' +
                        'FROM ESTADOINSPGNC ' +
                        'WHERE EJERCICI =:UnEjercicio AND CODINSPGNC =:UnCodigo ' +
                        'FOR UPDATE OF ESTADO NOWAIT');
                CommandText := fSQL.Text;
                params.ParamByName('UnEjercicio').AsInteger := iUnEjercicio;
                params.ParamByName('UnCodigo').AsInteger := iUnCodigo;
                Open;

                if RecordCount <> UNICO then raise Exception.Create('ERROR DE INTEGRIDAD EN ESTADOINSPGNC');

                { ACTUALIZACION DE LA TABLA ESTADOINSECCION }
                Close;
                SetProvider(dspQryConsultas);
                fSQL.Clear;
                fSQL.Add('DELETE ESTADOINSPGNC ' +
                        format('WHERE EJERCICI =%s AND CODINSPGNC =%s ',[IntToStr(iUnEjercicio),IntToStr(iUnCodigo)]));
                CommandText := fSQL.Text;
                Execute;

                { ACTUALIZACION DE LA TABLA INPSPGNC }
                Close;
                SetProvider(dspQryConsultas1);
                fSQL.Clear;
                fSQL.Add('UPDATE INSPGNC '+
                        'SET INSPFINA=''S'', '+
                        'RESULTADO = ''R'', FECHVENCI = NULL, '+
                        'HORFINAL = SYSDATE '+
                        format('WHERE EJERCICI =%s AND CODINSPGNC =%s ',[IntToStr(iUnEjercicio),IntToStr(iUnCodigo)]));
                CommandText := fSQL.Text;
//                params.ParamByName('UnEjercicio').AsInteger := iUnEjercicio;
//                params.ParamByName('UnCodigo').AsInteger := iUnCodigo;
                Execute;
                Close;
            end;
        except
            on E : Exception do
            begin
                result := False;
                fAnomalias.PonAnotacion(TRAZA_SIEMPRE,8,FILE_NAME,'NO SE PUDO CAMBIAR EL REGISTRO '
                                  + IntToStr(iUnEjercicio) + ' ' + IntToStr(iUnCodigo)
                                  + ' AL ESTADO ' + sEstado + ' POR: ' + E.message );
                ROLLBACK;
            end;
        end;
    Finally
        Try
            COMMIT;
        Except
        end;
        QryConsultas.Close;
        QryConsultas.Free;
        dspQryConsultas.Free;
        dspQryConsultas1.Free;
        sdsQryConsultas.Free;
    end;
end;



(******************************************************************************)
(*                                                                            *)
(*                                TDefectosGNC                                *)
(*                                                                            *)
(******************************************************************************)


constructor TDefectosGNC.Create (aBD: TSQLConnection);
begin
     inherited CreateFromDataBase (aBD,DATOS_DEFECTOSGNC,'');
end;

constructor TDefectosGNC.CreateLinea (aBD: TSQLConnection);
begin
     inherited CreateFromDataBase (aBD,DATOS_DEFECTOSGNC,' WHERE DEFLINEA = ''S''');
end;

constructor TDefectosGNC.CreateSAG (aBD: TSQLConnection);
begin
     inherited CreateFromDataBase (aBD,DATOS_DEFECTOSGNC,' WHERE DEFLINEA = ''N''');
end;

(******************************************************************************)
(*                                                                            *)
(*                           TInspGNC_Defectos                                *)
(*                                                                            *)
(******************************************************************************)

constructor TInspGNC_Defectos.Create (aBD: TSQLConnection);
begin
     inherited CreateFromDataBase (aBD,DATOS_INSPGNC_DEFECTOS,'');
end;

constructor TInspGNC_Defectos.CreateFromInspeccion(aBD: TSQLConnection; aEjercici, aCodinspgnc : string);
begin
     if (aEjercici <> '') and (aCodinspgnc <> '') then
       inherited CreateFromDataBase (aBD,DATOS_INSPGNC_DEFECTOS,format(' WHERE EJERCICI = %S AND CODINSPGNC = %S',[aEjercici, aCodinspgnc]))
     else
       inherited CreateFromDataBase (aBD,DATOS_INSPGNC_DEFECTOS,' WHERE ROWID = ''''');
end;

constructor TInspGNC_Defectos.CreateFromInspeccionSup(aBD: TSQLConnection; aEjercici, aCodinspgnc : string);
begin
     if (aEjercici <> '') and (aCodinspgnc <> '') then
       inherited CreateFromDataBase (aBD,DATOS_INSPGNC_DEFECTOS,format(' WHERE EJERCICI = %S AND CODINSPGNC = %S AND CODDEFEC IN (SELECT CODDEFEC FROM DEFECTOSGNC WHERE DEFLINEA = ''N'')',[aEjercici, aCodinspgnc]))
     else
       inherited CreateFromDataBase (aBD,DATOS_INSPGNC_DEFECTOS,' WHERE ROWID = ''''');
end;


constructor TInspGNC_Defectos.CreateFromDatos(aBD: TSQLConnection; aEjercici, aCodinspgnc, aCoddefec : string);
begin
       inherited CreateFromDataBase (aBD,DATOS_INSPGNC_DEFECTOS,format(' WHERE EJERCICI = %S AND CODINSPGNC = %S AND CODDEFEC = %S ',[aEjercici, aCodinspgnc, aCoddefec]))
end;

function TInspGNC_Defectos.GetDominio:string;
begin
  try
    with TSQLQuery.create(application) do
      try
        SQLConnection:=self.database;
        sql.add('SELECT NVL(PATENTEN, PATENTEA) FROM TVEHICULOS V, INSPGNC I ');
        SQL.ADD(FORMAT('WHERE CODINSPGNC = %D AND EJERCICI = %D ',[strtoint(valuebyname[field_codinsPGNC]),strtoint(valuebyname[field_ejercici])]));
        SQL.ADD('AND V.CODVEHIC = I.CODVEHIC');
        open;
        result:=fields[0].asstring;
      finally
        close;
        free;
      end;
  except
        on E: Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'Falla la obtencion del dominio del vehículo: %S',[E.message]);
            raise;
        end
  end;
end;

function TInspGNC_Defectos.GetNroInforme:string;
begin
  try
    with TSQLQuery.create(application) do
      try
        SQLConnection:=self.database;
        sql.add('SELECT SUBSTR(EJERCICI,3,2),CODINSPGNC FROM INSPGNC I ');
        SQL.ADD(FORMAT('WHERE CODINSPGNC = %D AND EJERCICI = %D ',[strtoint(valuebyname[field_codinspGNC]),strtoint(valuebyname[field_ejercici])]));
        open;
        result:=fields[0].asstring+' '+formatoceros(fVarios.Zona,4)+formatoceros(fVarios.CodeEstacion,4)+formatoceros(fields[1].asinteger,7);
      finally
        close;
        free;
      end;
  except
        on E: Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'Falla la obtencion del dominio del vehículo: %S',[E.message]);
            raise;
        end
  end;
end;


(******************************************************************************)
(*                                                                            *)
(*                               TLogRegulador                                *)
(*                                                                            *)
(******************************************************************************)

constructor TLogRegulador.CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
begin
        inherited CreateFromDataBase (aBD,DATOS_REGULADOR_MODI,Format('WHERE ROWID = ''%S''',[aRowId]));
end;


(******************************************************************************)
(*                                                                            *)
(*                                TLogCilindro                                *)
(*                                                                            *)
(******************************************************************************)

constructor TLogCilindro.CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
begin
        inherited CreateFromDataBase (aBD,DATOS_CILINDRO_MODI,Format('WHERE ROWID = ''%S''',[aRowId]));
end;


(******************************************************************************)
(*                                                                            *)
(*                                TLogCilindro                                *)
(*                                                                            *)
(******************************************************************************)

constructor TDescuentoGNC.Create (aBD: TSQLConnection);
begin
     inherited CreateFromDataBase (aBD,DATOS_DESCUENTOSGNC,'');
end;

constructor TDescuentoGNC.CreateConVigente(aBD: TSQLConnection; aVigente : string);
begin
     inherited CreateFromDataBase (aBD,DATOS_DESCUENTOSGNC,format(' WHERE ACTIVO = ''S'' AND USAVIGENTE = ''%S''',[aVigente]));
end;

constructor TDescuentoGNC.CreateFromCoddescu(aBD: TSQLConnection; const aCoddescu: string);
begin
    inherited CreateFromDataBase (aBD,DATOS_DESCUENTOSGNC,Format('WHERE %S = ''%S''',[FIELD_CODDESCU, aCodDescu]));
end;


(******************************************************************************)
(*                                                                            *)
(*                                TLogCilindro                                *)
(*                                                                            *)
(******************************************************************************)

constructor tObleasReemp.Create (aBD: TSQLConnection);
begin
     inherited CreateFromDataBase (aBD,DATOS_OBLEAS_REEMPL_GNC,'');
end;

constructor tObleasReemp.CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
begin
        inherited CreateFromDataBase (aBD,DATOS_OBLEAS_REEMPL_GNC,Format('WHERE ROWID = ''%S''',[aRowId]));
end;


(******************************************************************************)
(*                                                                            *)
(*                                TProvSeguros                                *)
(*                                                                            *)
(******************************************************************************)

constructor tProvSeguros.CreateByPoliza( aBD: TSQLConnection; aPoliza, aCertificado: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_PROV_SEGUROS,format('WHERE POLIZA = %S AND CERTIFICADO = %S',[aPoliza,aCertificado]));
end;

constructor tProvSeguros.CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_PROV_SEGUROS,Format('WHERE ROWID = ''%S''',[aRowId]));
end;


(******************************************************************************)
(*                                                                            *)
(*                                TCodposta_Capital                           *)
(*                                                                            *)
(******************************************************************************)

constructor TCodposta_Capital.Create (aBD: TSQLConnection);
begin
     inherited CreateFromDataBase (aBD,DATOS_CODPOSTA_CAPITAL,' ORDER BY CODPOSTA');
end;


(******************************************************************************)
(*                                                                            *)
(*                                TCodposta_Interior                          *)
(*                                                                            *)
(******************************************************************************)

constructor TCodposta_Interior.CreateByCodProvi( aBD: TSQLConnection; aCodProvi: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_CODPOSTA_INTERIOR,Format('WHERE CODPROVI = %S ORDER BY CODPOSTA',[aCodProvi]));
//     inherited CreateFromDataBase (aBD,DATOS_CODPOSTA_INTERIOR,Format('WHERE CODPROVI = %S ',[aCodProvi]));
end;

function TCodposta_Interior.GetLocalidad : string;
begin
  with TSQLQuery.create(application) do
    try
      SQLConnection := mybd;
      sql.add(format('SELECT MIN(LOCALIDAD) FROM LOCALIDAD_INTERIOR WHERE IDCODPOSTA = %S',[valuebyname[FIELD_IDCODPOSTA]]));
      open;
      result := fields[0].asstring;
    finally
      free;
    end;
end;


(******************************************************************************)
(*                                                                            *)
(*                           TLocalidad_Interior                              *)
(*                                                                            *)
(******************************************************************************)

constructor TLocalidad_Interior.CreateByCodProvi( aBD: TSQLConnection; aCodProvi: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_LOCALIDAD_INTERIOR,Format('WHERE CODPROVI = %S ORDER BY LOCALIDAD',[aCodProvi]));
//     inherited CreateFromDataBase (aBD,DATOS_LOCALIDAD_INTERIOR,Format('WHERE CODPROVI = %S ',[aCodProvi]));
end;

function tlocalidad_Interior.GetCodposta : string;
begin
  with TSQLQuery.create(application) do
    try
      SQLConnection := mybd;
      sql.add(format('SELECT CODPOSTA FROM CODPOSTA_INTERIOR WHERE IDCODPOSTA = %S',[valuebyname[FIELD_IDCODPOSTA]]));
      open;
      result := fields[0].asstring;
    finally
      free;
    end;
end;

constructor TLocalidad_Interior.CreateByParecido( aBD: TSQLConnection; aCodProvi, aNombre: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_LOCALIDAD_INTERIOR,Format('WHERE CODPROVI = %S AND LOCALIDAD LIKE ''',[aCodProvi])+'%'+format('%s',[aNombre])+'%'' ORDER BY LOCALIDAD');
end;


(******************************************************************************)
(*                                                                            *)
(*                             TDecJurada                                     *)
(*                                                                            *)
(******************************************************************************)


constructor TDecJurada.CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_DEC_JURADA,Format('WHERE ROWID = ''%S''',[aRowId]));
end;

constructor tdecjurada.CreateByCodigo(const aBD : TSQLConnection; aEjercici, aCodinspe: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_DEC_JURADA,Format('WHERE EJERCICI = %S AND CODINSPE = %S',[aEjercici, aCodinspe]));
end;


(******************************************************************************)
(*                                                                            *)
(*                             TObleasAnuladasGNC                             *)
(*                                                                            *)
(******************************************************************************)

constructor TObleasAnuladasGNC.CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_ANULADAS_GNC,Format('WHERE ROWID = ''%S''',[aRowId]));
end;

constructor TObleasAnuladasGNC.Create (aBD: TSQLConnection);
begin
     inherited CreateFromDataBase (aBD,DATOS_ANULADAS_GNC,'');
end;

constructor TObleasAnuladasGNC.CreateByFechas(const aBD : TSQLConnection; fecini, fecfin: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_ANULADAS_GNC,Format('WHERE FECHA >= ''%S'' AND FECHA <= ''%S''',[fecini,fecfin]));
end;

(******************************************************************************)
(*                                                                            *)
(*                               TVehiculos_GNC                               *)
(*                                                                            *)
(******************************************************************************)

constructor TVehiculos_GNC.CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_VEHICULOS_GNC,Format('WHERE ROWID = ''%S''',[aRowId]));
end;

constructor TVehiculos_GNC.Create (aBD: TSQLConnection);
begin
     inherited CreateFromDataBase (aBD,DATOS_VEHICULOS_GNC,'');
end;

constructor TVehiculos_GNC.CreateByCodinspe(const aBD : TSQLConnection; aCodinspe : string);
begin
     inherited CreateFromDataBase (aBD,DATOS_VEHICULOS_GNC,format('WHERE CODINSPE = %S',[aCodinspe]));
end;

constructor TVehiculos_GNC.CreateByCodVehic(const aBD : TSQLConnection; aCodVehic : string);
begin
     inherited CreateFromDataBase (aBD,DATOS_VEHICULOS_GNC,format('WHERE CODVEHIC = %S ORDER BY FECHALTA DESC',[aCodVehic]));
end;

(******************************************************************************)
(*                                                                            *)
(*                               TDatosProvincia                              *)
(*                                                                            *)
(******************************************************************************)

constructor TDatosProvincia.CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_DATOS_PROVINCIA,Format('WHERE ROWID = ''%S''',[aRowId]));
end;

constructor TDatosProvincia.Create (aBD: TSQLConnection);
begin
     inherited CreateFromDataBase (aBD,DATOS_DATOS_PROVINCIA,'');
end;


(******************************************************************************)
(*                                                                            *)
(*                               TBancos_Deposito                             *)
(*                                                                            *)
(******************************************************************************)

constructor TBancos_Deposito.Create (aBD: TSQLConnection);
begin
     inherited CreateFromDataBase (aBD,DATOS_BANCOS_DEPOSITO,'');
end;


(******************************************************************************)
(*                                                                            *)
(*                               TSocios_Acavtv                               *)
(*                                                                            *)
(******************************************************************************)

constructor tSocios_acavtv.CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_SOCIOS_ACAVTV,Format('WHERE ROWID = ''%S''',[aRowId]));
end;

constructor tSocios_acavtv.CreateByFactura(const aBD : TSQLConnection; const aCodFactu: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_SOCIOS_ACAVTV,Format('WHERE CODFACTU = %S',[aCodFactu]));
end;

constructor tSocios_acavtv.CreateByFecha(const aBD : TSQLConnection; const aFechini, aFechfin: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_SOCIOS_ACAVTV,Format('WHERE FECHA >= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS'')) AND (FECHA <= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS''))',[aFechini, aFechfin]));
end;

constructor tSocios_acavtv.CreateByFechaCompleto(const aBD : TSQLConnection; const aFechini, aFechfin: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_SOCIOS_ACAVTV,Format('WHERE (FECHA >= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS'')) AND (FECHA <= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS'')) AND (FORMPAGO IS NULL OR TOTALACA IS NULL)',[aFechini, aFechfin]));
end;

constructor tSocios_acavtv.CreateByFactura_u(const aBD : TSQLConnection; const aCodFactu, aIdusuario: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_SOCIOS_ACAVTV,Format('WHERE CODFACTU = %S AND IDUSUARIO = %S',[aCodFactu,aIdusuario]));
end;

constructor tSocios_acavtv.CreateByFecha_u(const aBD : TSQLConnection; const aFechini, aFechfin, aIdusuario: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_SOCIOS_ACAVTV,Format('WHERE FECHA >= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS'')) AND (FECHA <= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS'')) AND IDUSUARIO = %S',[aFechini, aFechfin, aIdUsuario]));
end;

constructor tSocios_acavtv.CreateByFechaCompleto_u(const aBD : TSQLConnection; const aFechini, aFechfin, aIdusuario: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_SOCIOS_ACAVTV,Format('WHERE (FECHA >= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS'')) AND (FECHA <= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS'')) AND (FORMPAGO IS NULL OR TOTALACA IS NULL) AND IDUSUARIO = %S',[aFechini, aFechfin, aIdUsuario]));
end;


(******************************************************************************)
(*                                                                            *)
(*                               TDepositos_liq                               *)
(*                                                                            *)
(******************************************************************************)

constructor TDepositos_liq.CreateByFecha(const aBD : TSQLConnection; const aFechini, aFechfin, aIdUsuario: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_DEPOSITOS_LIQ,Format('WHERE (FECHA >= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS'')) AND (FECHA <= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS'')) AND IDUSUARIO = %S',[aFechini, aFechfin, aIdUsuario]));
end;

constructor TDepositos_liq.CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_DEPOSITOS_LIQ,Format('WHERE ROWID = ''%S''',[aRowId]));
end;

constructor TDepositos_liq.CreateByLiquidacion(const aBD : TSQLConnection; const aCodliq: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_DEPOSITOS_LIQ,Format('WHERE TO_CHAR(CODLIQUIDACION) = ''%S''',[aCodliq]));
end;

constructor TDepositos_liq.CreateByLiquidacionNro(const aBD : TSQLConnection; const aCodliq, aNro: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_DEPOSITOS_LIQ,Format('WHERE CODLIQUIDACION = %S AND NROCOMPROB = %S',[aCodliq,aNro]));
end;


(******************************************************************************)
(*                                                                            *)
(*                                TLiquidacion                                *)
(*                                                                            *)
(******************************************************************************)


constructor TLiquidacion.CreateByFechaMax(const aBD : TSQLConnection; const  aIdUsuario,aFechini: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_LIQUIDACION,Format('WHERE FECHA = MAXFECLIQUID(%S,''%s'') AND IDUSUARIO = %S ',[aIdUsuario,copy(aFechini,1,10),aIdUsuario]));
end;
constructor TLiquidacion.CreateByFecha(const aBD : TSQLConnection; const aFechini, aFechfin, aIdUsuario: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_LIQUIDACION,Format('WHERE (FECHA >= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS'')) AND (FECHA <= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS'')) AND IDUSUARIO = %S',[aFechini, aFechfin, aIdUsuario]));
end;

constructor TLiquidacion.CreateByRowId(const aBD : TSQLConnection; const aRowId: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_LIQUIDACION,Format('WHERE ROWID = ''%S''',[aRowId]));
end;

constructor TLiquidacion.CreateByCodigo(const aBD : TSQLConnection; const aCodliq: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_LIQUIDACION,Format('WHERE CODLIQUIDACION = %S',[aCodliq]));
end;




{ TInspVigente }

constructor TInspVigente.CreateByRowId(const aBD: TSQLConnection;
  const aRowId: string);
begin
     inherited CreateFromDataBase (aBD,DATOS_INSP_VIGENTE,Format('WHERE ROWID = ''%S''',[aRowId]));
end;


end.//Final de la unidad

