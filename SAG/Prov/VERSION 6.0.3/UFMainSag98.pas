unit UFMainSag98;

interface

    uses
        Windows,
        Messages,
        SysUtils,
        Classes,
        Graphics,
        Controls,
        Forms,
        Menus,
        SpeedBar,
        ExtCtrls,
        StdCtrls,
        Buttons,
        UThread,
        Globals,
        ugetdates,
        UFTmp,
        ufrmodificar_oblea_en_tvarios,
        EPSON_Impresora_Fiscal_TLB,
        ComObj,
        USagClasses,
        ufabmcaja,
        usuperregistry,
        DBCtrls,
        Mask,
        RxLookup,
        USagCtte,
        Unitfrmodificar_oblea_rucara_inspeccion,
        Provider,
        DBClient,
        FMTBcd,
        DB,
        SqlExpr,
        StrUtils,
        ComCtrls,
        WinSkinData,
        OleServer,
        ExcelXP;

    Const
        WM_SHOW_IMAGE = WM_USER+5;

    type
        TFMainSag98 = class(TForm)
        MainMenu1: TMainMenu;
        Verificaciones1: TMenuItem;
        ANormal1: TMenuItem;
        BPreverificacin1: TMenuItem;
        CVoluntaria1: TMenuItem;
        DGratuita1: TMenuItem;
        ANueva1: TMenuItem;
        BDeVuelta1: TMenuItem;
        N4: TMenuItem;
        ProcedimientosDiversos1: TMenuItem;
        ArqueoCaja1: TMenuItem;
        mnuContado: TMenuItem;
        mnuCredito: TMenuItem;
        mnuAmbos: TMenuItem;
        N7: TMenuItem;
        mnuLibroIVAVentas: TMenuItem;
        MantenimientodeDatos1: TMenuItem;
        DatosVariables1: TMenuItem;
        mnuEstacion: TMenuItem;
        mnuFacturacion: TMenuItem;
        mnuCortesia: TMenuItem;
        mnuGestionInspecciones: TMenuItem;
        CSecuenciasNumricas1: TMenuItem;
        N8: TMenuItem;
        TiposTarifasyPeriodicidad1: TMenuItem;
        N10: TMenuItem;
        ClientesHabituales1: TMenuItem;
        Mantenimientodevehculos1: TMenuItem;
        N11: TMenuItem;
        ValoresLmite1: TMenuItem;
        N12: TMenuItem;
        MantenimientodeUsuarios1: TMenuItem;
        MantenimientodeInspectores1: TMenuItem;
        MantenimientodeDefectos1: TMenuItem;
        Reimpresiones1: TMenuItem;
        Certificados1: TMenuItem;
        Informes1: TMenuItem;
        ProcedimientosdeCaja1: TMenuItem;
        GeneracinFactura1: TMenuItem;
        NotadeCrdito1: TMenuItem;
        Informes3: TMenuItem;
        mnuResultadosdeInspeccion: TMenuItem;
        mnuHistorialVehiculo: TMenuItem;
        N5: TMenuItem;
        ELineadeInspeccin1: TMenuItem;
        ETiposdeClientes1: TMenuItem;
        Salir1: TMenuItem;
        SBarPrincipal: TSpeedBar;
        SpeedbarSection1: TSpeedbarSection;
        SpeedbarSection2: TSpeedbarSection;
        SpeedbarSection3: TSpeedbarSection;
        SBNormal: TSpeedItem;
        SBPreverificacion: TSpeedItem;
        SBVoluntaria: TSpeedItem;
        SBGratuita: TSpeedItem;
        SBLinea: TSpeedItem;
        SBSalir: TSpeedItem;
        ArqueodeCajaExtendido1: TMenuItem;
        AContado1: TMenuItem;
        BCrdito1: TMenuItem;
        CAmbos1: TMenuItem;
        BControlDiario1: TMenuItem;
        CCierreZ1: TMenuItem;
        JMantenimientoPuntosdeVenta1: TMenuItem;
        N6: TMenuItem;
        FValores1: TMenuItem;
        N9: TMenuItem;
        KMantenimientoTarjetasdeCrdito1: TMenuItem;
        Tarjetas1: TMenuItem;
        EConveniosdeDescuentos1: TMenuItem;
        Cheques1: TMenuItem;
        Df1: TMenuItem;
        ISO90011: TMenuItem;
        AEncuestadeSatisfaccin1: TMenuItem;
        FLibroIVAVentas1: TMenuItem;
        BLiquidacinIVA1: TMenuItem;
        BGrficoAnlisis1: TMenuItem;
        E1: TMenuItem;
        CCambioFecha1: TMenuItem;
        Utilidades1: TMenuItem;
        DMedicionesInspeccin1: TMenuItem;
        EResumenMediciones1: TMenuItem;
        Obleas1: TMenuItem;
        BExportacion1: TMenuItem;
        Registrar1: TMenuItem;
        Imprimir1: TMenuItem;
        Inutilizadas1: TMenuItem;
        Anuladas1: TMenuItem;
        Inutilizadas2: TMenuItem;
        Anuladas2: TMenuItem;
        ENTE1: TMenuItem;
        Espaa1: TMenuItem;
        EnteObleas1: TMenuItem;
        Anexos1: TMenuItem;
        N13: TMenuItem;
        F1: TMenuItem;
        btnCambioPlanta: TSpeedItem;
        FTotalesCaja1: TMenuItem;
        GTotalesTarjetas1: TMenuItem;
        N14: TMenuItem;
        GListadosVarios1: TMenuItem;
        AMarcasyModelos1: TMenuItem;
        N15: TMenuItem;
        ContadoPorCajero1: TMenuItem;
        Contado1: TMenuItem;
        CuentaCorriente1: TMenuItem;
        Cheques2: TMenuItem;
        Tarjetas2: TMenuItem;
        Global1: TMenuItem;
        btnRPA: TSpeedItem;
        btnRC: TSpeedItem;
        btnLineaGNC: TSpeedItem;
        GNCRTA1: TMenuItem;
        Nueva1: TMenuItem;
        Facturar1: TMenuItem;
        N17: TMenuItem;
        GNCRC1: TMenuItem;
        HLneadeInspeccinGNC1: TMenuItem;
        Nueva2: TMenuItem;
        AFacturar1: TMenuItem;
        DTarjetaAmarilla1: TMenuItem;
        EFichaTcnicaGNC1: TMenuItem;
        VTV1: TMenuItem;
        GNC1: TMenuItem;
        VTV2: TMenuItem;
        GNC2: TMenuItem;
        VTV3: TMenuItem;
        GNC3: TMenuItem;
        VTV4: TMenuItem;
        GNC4: TMenuItem;
        VTV5: TMenuItem;
        GNC5: TMenuItem;
        VTV6: TMenuItem;
        GNC6: TMenuItem;
        VTV7: TMenuItem;
        GNC7: TMenuItem;
        VTV8: TMenuItem;
        GNC8: TMenuItem;
        VTV9: TMenuItem;
        GNC9: TMenuItem;
        VTV10: TMenuItem;
        GNC10: TMenuItem;
        VTV11: TMenuItem;
        GNC11: TMenuItem;
        VTV12: TMenuItem;
        GNC12: TMenuItem;
        VTV13: TMenuItem;
        GNC13: TMenuItem;
        N1: TMenuItem;
        VTV14: TMenuItem;
        GNC14: TMenuItem;
        BCilindrosyReguladores1: TMenuItem;
        FDefectosInspeccinGNC1: TMenuItem;
        N2: TMenuItem;
        HVehculosOficiales1: TMenuItem;
        ICambiosdeZona1: TMenuItem;
        N3: TMenuItem;
        HConsultaProvinciaSeguros1: TMenuItem;
        GenerarIndices1: TMenuItem;
        Consultas1: TMenuItem;
        Acercade1: TMenuItem;
        CExportacionGN1: TMenuItem;
        CInformeMediciones1: TMenuItem;
        VTV15: TMenuItem;
        GNC15: TMenuItem;
        Registros1: TMenuItem;
        VTV16: TMenuItem;
        GNC16: TMenuItem;
        JDeclaracionesJuradas1: TMenuItem;
        N16: TMenuItem;
        CEstadoVTVyCantInsp1: TMenuItem;
        ExportarDatos1: TMenuItem;
        N18: TMenuItem;
        LiquidacinDiaria1: TMenuItem;
        DInscripcionesACA1: TMenuItem;
        IAutomovilClubArgentino1: TMenuItem;
        VTV17: TMenuItem;
        GNC17: TMenuItem;
        GReemplazodeObleas1: TMenuItem;
        HDeclaracionesJuradas1: TMenuItem;
        FResumenMedicionesFaltantes1: TMenuItem;
        N19: TMenuItem;
        ClientesconCUIT1: TMenuItem;
        Preves1: TMenuItem;
        AltadeObleas1: TMenuItem;
        Reimpresiones2: TMenuItem;
        RestaurarObleadeNC1: TMenuItem;
        RestaurarObleas1: TMenuItem;
        PorBloqueodelSistema1: TMenuItem;
        EjecutarSQLs1: TMenuItem;
        sBarra: TStatusBar;
        btnVerPendFact: TSpeedItem;
        SpeedItem1: TSpeedItem;
        N20: TMenuItem;
        InformadeCierreZ1: TMenuItem;
        iemposvtv1: TMenuItem;
        N21: TMenuItem;
        AlertasdeVehculos1: TMenuItem;
        SkinData1: TSkinData;
        EliminarDefectodeRevesAptas1: TMenuItem;
        PendientedeFacturar1: TMenuItem;
        RUCARA1: TMenuItem;
        ModificarNrodeObleaenInspeccin1: TMenuItem;
        ModificarNroOblea1: TMenuItem;
        GenerarListadoRUCARA1: TMenuItem;
        ExcelQueryTable1: TExcelQueryTable;
        ExcelApplication1: TExcelApplication;

    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Mantenimientodevehculos1Click(Sender: TObject);
    procedure SBSalirClick(Sender: TObject);
    procedure MantenimientodeUsuarios1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    Procedure SetActiveServices;
    procedure FormDestroy(Sender: TObject);
    procedure Acercade1Click(Sender: TObject);
    procedure SpeedItem1Click(Sender: TObject);
    procedure Preves1Click(Sender: TObject);
    procedure Reimpresiones2Click(Sender: TObject);
    procedure btnVerPendFactClick(Sender: TObject);
    procedure RevesExt1Click(Sender: TObject);
    procedure InformadeCierreZ1Click(Sender: TObject);
    procedure AlertasdeVehculos1Click(Sender: TObject);
    procedure CambiarCalificacinaDefecto1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PendientedeFacturar1Click(Sender: TObject);
    procedure ModificarNrodeObleaenInspeccin1Click(Sender: TObject);
    procedure ModificarNroOblea1Click(Sender: TObject);
    procedure GenerarListadoRUCARA1Click(Sender: TObject);
    procedure EliminarDefectodeRevesAptas1Click(Sender: TObject);
   // procedure EliminarDefectodeRevesAptas1Click(Sender: TObject);

        private
            { Private declarations }
            NumeroPlanta: String;
            FirstActivating : Boolean;
            HacerCierreZ:boolean;
            Thread: TProcessThread;
            fPtoVenta: TPtoVenta;
            procedure CaptureException (Sender: TObject; E: Exception);
            procedure DoServicio (const aService : integer; lParams: array of variant);
            Function TestPrOrStCurrent: Boolean;
            procedure ControlarCF;
            procedure HabilitarBotones;
        public
            { Public declarations }
            Procedure UpdateLineaInspeccion(var msg:tmessage);message WM_LINEAINSP;
            Procedure UpdateLineaInspeccionGNC(var msg:tmessage);message WM_LINEAINSPGNC;
            Procedure UpdatePrintJob(var msg:tmessage);message WM_SERVIMPRE;
        end;

    var
        FMainSag98: TFMainSag98;

implementation

{$R *.DFM}
    uses
        UendApplicationForm,
        UTILORACLE,
        UINTERFAZUSUARIO,
        UFINICIOAPLICACION,
        UFMANTDEFECTS,
        UFMANTVEHICULOS,
        UFPREVIOMANTCLIENTES,
        UFMAINTENANCEINSPECTORS,
        UFPERIODICITYTYPESTAS,
        UFVARIABLEDATASTATIONS,
        UFGESTIONINSPECCIONES,
        UFVARIABLEDATASECUENCIADORES,
        UFRESULTADOSINSPECCION,
        UCOMUNIC,
        UCOMUNICGNC,
        UARQUEOCAJAEXTENDED,
        UIVABOOK,
        UFCORTESIAVENCIMIENTO,
        UFRECEPCION,
        UFVARIABLEDATABILLS,
        USAGESTACION,
        MTBLMAHA,
        UVERSION,
        UCDIALGS,
        ULOGS,
        ACCESO,
        GESTION,
        UCLIENTE,
        UGACCESO,
        UREIMPRESION,
        UCALLHISTORIALVEHICULO,
        USAGVARIOS,
        UFMANTTIPOSCLIENTE,
        UCONTROLDIARIO,
        UFMANTPTOVENTA,
        UFCIERREZETA,
        uFAcercaDe,
        UFABMTARJETA,
        UFABMDESCUENTOS,
        ULISTADOCHEQUES,
        UFLISTADODESCUENTOS,
        UFLISTADOSOCIOSACA,
        ufEncuestaSatisfaccion,
        UFEstadisticasEncSatis,
        UFLIQUIDACIONIVA,
        UFLISTADOCANTDESCUENTOS,
        UFCAMBIOFECHAVENCIMIENTO,  //laura
        UfDatosInspeccion,   //LAURA
        ufContMedic,    //laura
        UFOBLINUTILIZAD,  //laura
        ufOblAnulad, ufPrintOblIn,  //laura
        ufPrintOblAn,    //laura
        uexportaciones,
        uListadoCambioFecha, UFSeleccionaPlanta,   //laura
        UARQUEOCAJATOTALES, UListadoTotalTarjetas,  //laura
        UFListadoMarcas,   //LAURA
        uArqueoCajaExtendedXCajero,  //laura
        UFRECEPGNC,
        ufFacturacionGNC,
        UARQUEOCAJAEXTENDEDGNC,
        uArqueoCajaXCajeroGNC,
        UFResultadosInspeccionGNC,
        UListadoTotalTarjetasGNC,
        UFResumendescuentosGNC, UUTILS,
        UControlDiarioGNC,
        ufListadoCilindrosRegulad, UFDefectosInspGNC, UListadoVehOficial,
        UlistadoCambioZona,
        UFDatosProvSeguros,
        ufImportaProvincia,
        ufOblAnuladGNC, //LAURA
        ufprintOblAnGNC, //LAURA
        UFListadoDecJuradas, UListadoEstadovtv,    //laura
        ufLiqDiaria, ufpagoSociosAca,
        UFCambioFechaVencGNC,
        ufReimpReemplazoObleas,
        ufContMedicIncompletas,
        uflistadoCliCuit,     //LAURA
        UResultadoPreverificacion,
        UAltasdeOblea,
        UReImpresionObleas,
        UFRestaurarOblea,
        uSQLExec,
        ufPendientesFacturar,
        Ulistadocierrez,
        ufInformeRevesExternasToPrint,UFRESULTADINSPECTIEMPOS, Ufaletas_vehiculos,
        Unitsincronizacion_cf, Uncambiar_calificacion_defectos_solo_reve,
        Unifinaliza,
        Unborrar_defectos_solo_reveApta, Unitpide_fecha;

    resourcestring
        FILE_NAME = 'UFMAINSAG98.PAS';
        SQL_SELECT_STANDBY_AND_PREVERIF = 'SELECT I.CODINSPE FROM TINSPECCION I, TESTADOINSP E WHERE I.TIPO IN (''F'',''B'') AND I.CODINSPE = E.CODINSPE AND I.EJERCICI = E.EJERCICI';
        MSJ_STANDBY_AND_PREVERIF = 'Hay Inspecciones en StandBy y Preverificaciones.'+#10#13+
                                   '   �Desea Visualizar la Linea de Inspeccion?';

    const
        bActivandose : boolean = TRUE;


procedure InitError(Msg: String);
begin
MessageDlg('Error en la Inicializaci�n',Msg,mtError,[mbOK],mbOK,0);
if Assigned(fAnomalias) then
  fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FILE_NAME,Msg);
InitializationError := TRUE;
Application.Terminate;
end;


procedure TestOfAcceso;
begin
  if Assigned(MyBD) then
    begin
      GestorSeg := TGestorSeg.Inicializa (MyBD, '','','');
      if not GestorSeg.HayError then
        begin
          if not PermitidoAcceso (ApplicationUser,PasswordUser,GestorSeg,'',TRUE,'ACCESO') then
          //InitError('No se encontr� el usuario y la contrase�a especificada')
          InitializationError:=true;
        end
      else
        InitError('No se gener� de forma correcta la gesti�n de acceso')
    end
  else
    InitError('No se gener� la gesti�n de acceso, no existe base de datos');
end;


procedure TFMainSag98.FormActivate(Sender: TObject);
begin
//Activacion del fornm
If FirstActivating then
  begin
    sBarra.Panels[0].Text:=GetFullUserName;
     sBarra.Panels[1].Text:='   Version: '+uversion.VERSION+'    '+uversion.FECHA_VERSION;
    FirstActivating:=FalsE;
    If TestPrOrStCurrent then
      SBLinea.Click;

    If HacerCierreZ = true then
      begin
        while not cierrezok do
          begin
            cierrezok:=false;
            application.messagebox('Es Necesario Realizar un Cierre Z',pchar(caption),mb_ok+mb_iconerror+mb_applmodal);
            application.CreateForm(Tfcierrezeta,fcierrezeta);
            fcierrezeta.btnCancelar.enabled:=false;
            fcierrezeta.showmodal;
            fcierrezeta.free;
          end;
      end;
    habilitarbotones;
  end;
end;


procedure TFMainSag98.FormShow(Sender: TObject);
var
Ahora : tDateTime;
begin
If bActivandose then
  begin
  //PChar(NOMBRE_PROYECTO)
  Top := -7000;
  if (FindWindow(Pchar('TFInicioAplicacion'), PChar('Delphi 7')) <> 0) or (FindWindow(Pchar('TFMainSag98'), PChar('Planta Verificadora de Veh�culos')) <> 0)
  or (FindWindow(Pchar('TFMainSag98'), PChar('Planta Verificadora de Veh�culos - [Veh�culos en estaci�n hoy ]')) <> 0) then //Lucho
  InitError('Ya existe una copia del programa en ejecuci�n')
  else
    InitLogs;

    if InitializationError then
    exit;

    Caption := 'Planta Verificadora de Veh�culos';

          //  bActivandose:=FALSE;
            with TFInicioAplicacion.Create(Application) do
            try
                {$IFDEF TRAZAS}
                fTrazas.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'%S', [LITERAL_VERSION]);
                {$ENDIF}
                lVersion.Caption:= VERSION;

                Status.Caption := Format('%S (Comprobando su sistema)', [LITERAL_VERSION]);
                Show;
                Application.ProcessMessages;

                {!!!!!!!!!!!}
                TestOfBugs;

                if InitializationError then
                exit;

                Status.Caption := Format('%S (Comprobando su estructura)', [LITERAL_VERSION]);
                Application.ProcessMessages;
                TestOfLicencia;
                if InitializationError then
                exit;

                TestOfTerminal;

                if InitializationError then
                exit;

                TestOfDirectories;
                if InitializationError then
                exit;

                Status.Caption := Format('%S (Conect�ndose al servidor)', [LITERAL_VERSION]);
                Application.ProcessMessages;

                If ParamCount=0  then
                    TestOfBD('','','',true)
                else begin
                    If ParamCount=1 Then
                    begin
                        TestOfBD(ParamStr(1),'','',true);
                    end
                    else begin
                        If ParamCount=3 Then
                        begin
                            TestOfBD(ParamStr(1),ParamStr(2),ParamStr(3),true);
                        end
                        else
                        begin
                            TestOfBD('','','',true);
                        end;

                    end;
                end;

                if InitializationError then
                exit;

                Status.Caption := Format('%S (Comprobando sus permisos)', [LITERAL_VERSION]);
                Application.ProcessMessages;
                TestOfAcceso;
                if InitializationError then
                Application.Terminate;
                Application.ProcessMessages;
               InitClienteImpresion(MyBD);

                //Inicializar tablas de informaci�n globales de la  aplicaci�n
                Status.Caption := Format('%S (Iniciando Configuraci�n Base)', [LITERAL_VERSION]);
                Application.ProcessMessages;

                InitAplicationGlobalTables;

                if InitializationError then
                exit;

                Ahora := Now;
                while Now <= (Ahora + EncodeTime(0,0,3,0)) do Application.ProcessMessages;

                Status.Caption := Format('%S (Comprobando Controlador Fiscal)', [LITERAL_VERSION]);
                Application.ProcessMessages;
                ControlarCF;
                Thread:= TProcessThread.Create (MyBd,self,1);

                NumeroPlanta:=IntToStr(fVarios.Zona)+IntToStr(fVarios.CodeEstacion);

            finally
                Free
            end;
            SetActiveServices;
            Top := Top + 7000;
            Application.ProcessMessages;
        end;
    end;


procedure TFMainSag98.FormCreate(Sender: TObject);
begin
 FirstActivating:=True;
Inicializar_FrmAlturaAnchura (Sender as TForm);
Application.OnException := CaptureException;
Thread := nil;
end;

    procedure TFMainSag98.DoServicio (const aService : integer; lParams: array of variant);
    const
        ID_SERVICIO_REIMPRESION_FACTURA = -1000;
        ID_SERVICIO_REIMPRESION_NOTA = -1001;
        ID_SERVICIO_REIMPRESION_CERTIFICADO = -1002;
        ID_SERVICIO_REIMPRESION_INFORME = -1003;
        ID_SERVICIO_REIMPRESION_TAMARILLA = -1004;
        ID_SERVICIO_REIMPRESION_INFORMEGNC = -1005;
        ID_SERVICIO_REIMPRESION_INF_MEDICION = -1006;
    begin
        if aService <= -1000  then
        begin
           case aService of
                 ID_SERVICIO_REIMPRESION_FACTURA:
                begin
                    ReimpresionFacturasNCredito (TRUE);
                end;

                ID_SERVICIO_REIMPRESION_NOTA:
                begin
                    ReimpresionFacturasNCredito (FALSE);
                end;

                ID_SERVICIO_REIMPRESION_CERTIFICADO:
                begin
                    ReimpresionCertificados;
                end;

                ID_SERVICIO_REIMPRESION_INFORME:
                begin
                    ReimpresionInformesInspeccion;
                end;

                ID_SERVICIO_REIMPRESION_TAMARILLA:
                begin
                    ReimpresionTAmarilla;
                end;

                ID_SERVICIO_REIMPRESION_INFORMEGNC:
                begin
                   ReimpresionInformeGNC
                end;
                ID_SERVICIO_REIMPRESION_INF_MEDICION:
                begin
                   ReimpresionInformesMedicion
                end;
            end
        end
        else
        begin
        if AccederAServicio(aService,ApplicationUser,PasswordUser, GestorSeg) then
          begin
             case aService of
               ID_SERVICIO_ACCESO:
               begin
                   // INICIO APLICACION, FUERA DE CONTROL
               end;

               ID_SERVICIO_INSP_FIN:
               begin
                   DoVerVehiculos(MyBD,Self);
               end;

               ID_SERVICIO_INSP_FIN_GNC:
               begin
                   DoVerVehiculosGNC(MyBD,Self);
               end;

               ID_SERVICIO_CONTROL_DIARIO:
               begin
                   GenerateControlDiario;
               end;

               ID_SERVICIO_CONTROL_DIARIO_GNC:
               begin
                   GenerateControlDiarioGNC;
               end;

               ID_SERVICIO_RECIBIR_INFO:
               begin
                   DoVerificacion(tfVerificacion(lparams[0]));
               end;

               ID_SERVICIO_INFORMES_RI:
               begin
                   GenerateInformesDeInspeccion
               end;

               ID_SERVICIO_INFORMES_RI_GNC:
               begin
                   GenerateInformesDeInspeccionGNC
               end;

               ID_SERVICIO_INFORMES_HV:
               begin
                   Realizar_HistorialVehiculo
               end;

               ID_SERVICIO_ARQUEO_X_DESCUENTOS:
               begin
                   GenerateListadoDescuento('')
               end;

               ID_SERVICIO_LISTADO_CHEQUES:
               begin
                   GenerateListadoCheques('');
               end;

               ID_SERVICIO_ARQUEO_CAJA_TIPO_CLIENTES:
               begin
                    GenerateArqueoCajaExtended('L');
               end;

               ID_SERVICIO_LISTADO_SOCIOS_ACA:
               begin
                    GenerateListadoSociosAca
               end;

               ID_SERVICIO_CANTIDAD_DESCUENTOS:
               begin
                  GenerateListadoCantDescuento;
               end;

               ID_SERVICIO_MANT_INSPECTORES:
               begin
                   Mantenimiento_Inspectores(self);
               end;

               ID_SERVICIO_MANT_DATOS:
               begin
                   Mantenimiento_DatosEstacion(self);
               end;

               ID_SERVICIO_MANT_TTP:
               begin
                   Mantenimiento_TiposTarifasPeriodicidad(self)
               end;

               ID_SERVICIO_MANT_CLIENTES:
               begin
                   DoMantenimientoDeClientes;
               end;

               ID_SERVICIO_MANT_DEFECTOS:
               begin
                   Mantenimiento_Defectos(self);
               end;

               ID_SERVICIO_MANT_VALLIM:
               begin
                   Mantenimiento_ValoresLimite (Self);
               end;

               ID_SERVICIO_MANT_VEHICULOS:
               begin
                   DoMantenimientoDeVehiculos;
               end;

               ID_SERVICIO_LIBROIVA_VENTAS:
               begin
                   GenerateIVABook (Self);
               end;

               ID_SERVICIO_LIQUIDACION_IVA:
               begin
                   GenerateLiquidacionIVA;
               end;

               ID_SERVICIO_ARQUEO_CAJA_EXTENDIDO_AMBOS:
               begin
                    if lParams[0] = 'C' then
                     GenerateArqueoCajaExtendedXCajero('')
                    else
                     GenerateArqueoCajaExtended('');
               end;

              ID_SERVICIO_ARQUEO_CAJA_EXTENDIDO_CONTADO:
               begin
                    if lParams[0] = 'C' then
                     GenerateArqueoCajaExtendedXCajero(V_FORMA_PAGO[tfpMetalico])
                    else
                     GenerateArqueoCajaExtended(V_FORMA_PAGO[tfpMetalico]);
               end;

               ID_SERVICIO_ARQUEO_CAJA_EXTENDIDO_CREDITO:
               begin
                    if lParams[0] = 'C' then
                      GenerateArqueoCajaExtendedXCajero(V_FORMA_PAGO[tfpCredito])
                    else
                      GenerateArqueoCajaExtended(V_FORMA_PAGO[tfpCredito]);
               end;

               ID_SERVICIO_ARQUEO_CAJA_EXTENDIDO_TARJETA:
               begin
                    if lParams[0] = 'C' then
                      GenerateArqueoCajaExtendedXCajero(V_FORMA_PAGO[tfpTarjeta])
                    else
                      GenerateArqueoCajaExtended(V_FORMA_PAGO[tfpTarjeta])
               end;

               ID_SERVICIO_ARQUEO_CAJA_EXTENDIDO_CHEQUE:
               begin
                    if lParams[0] = 'C' then
                      GenerateArqueoCajaExtendedXCajero(V_FORMA_PAGO[tfpCheque])
                    else
                      GenerateArqueoCajaExtended(V_FORMA_PAGO[tfpCheque])
               end;

               ID_SERVICIO_ARQUEO_CAJA_GNC_AMBOS:
               begin
                    if lParams[0] = 'C' then
                     GenerateArqueoCajaXCajeroGNC('')
                    else
                     GenerateArqueoCajaGNC('');
               end;

               ID_SERVICIO_ARQUEO_CAJA_GNC_CHEQUE:
               begin
                    if lParams[0] = 'C' then
                     GenerateArqueoCajaXCajeroGNC(V_FORMA_PAGO[tfpCheque])
                    else
                     GenerateArqueoCajaGNC(V_FORMA_PAGO[tfpCheque]);
               end;
               ID_SERVICIO_ARQUEO_CAJA_GNC_CONTADO:
               begin
                    if lParams[0] = 'C' then
                     GenerateArqueoCajaXCajeroGNC(V_FORMA_PAGO[tfpMetalico])
                    else
                     GenerateArqueoCajaGNC(V_FORMA_PAGO[tfpMetalico]);
               end;
               ID_SERVICIO_ARQUEO_CAJA_GNC_TARJETA:
               begin
                    if lParams[0] = 'C' then
                     GenerateArqueoCajaXCajeroGNC(V_FORMA_PAGO[tfpTarjeta])
                    else
                     GenerateArqueoCajaGNC(V_FORMA_PAGO[tfpTarjeta]);
               end;
               ID_SERVICIO_ARQUEO_CAJA_GNC_CCORRIENTE:
               begin
                    if lParams[0] = 'C' then
                     GenerateArqueoCajaXCajeroGNC(V_FORMA_PAGO[tfpCredito])
                    else
                     GenerateArqueoCajaGNC(V_FORMA_PAGO[tfpCredito]);
               end;

               ID_SERVICIO_CORTESIA_VENCIMIENTO:
               begin
                   Mantenimiento_DiasCortesia(self);
               end;

               ID_SERVICIO_MANT_DATOS_FACTURACION:
               begin
                   Mantenimiento_DatosFacturacion(self);
               end;

               ID_SERVICIO_MANT_DATOS_AUTOMATICOS:
               begin
                   Mantenimiento_ValoresAutomaticos(self)
               end;

               ID_SERVICIO_MANT_DATOS_GESTION_INSPECCIONES:
               begin
                   Mantenimiento_GestionInspecciones(self)
               end;

               ID_SERVICIO_MANT_TIPO_CLIENTES:
               begin
                   DoMantTiposCliente(MyBd);
               end;

               ID_SERVICIO_MANT_PTO_VENTA:
               begin
                   DoMantPtoVenta(MyBd);
               end;

               ID_SERVICIO_CIERRE_Z:
               begin
                 try
                   fptoVenta:=TPtoventa.Create(MyBD);
                   if fPtoVenta.EsCaja then
                   begin
                     if fPtoVenta.EncendidoyFunciona then
                     begin
                        DoCierreZ(self);
                     end
                     else
                       raise exception.create('El Controlador Fiscal no Funciona Correctamente. Controle que est� enchufado y/o encendido');
                   end
                   else
                       raise exception.create('Esta PC no est� habilitada como Caja');
                   except
                         on E: Exception do
                         begin
                           MessageDlg(Caption,Format('Error inicializando el formulario de Cierre de Jornada: %s. Comience de nuevo y si el error persiste, ind�quelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk],mbOk,0);
                         end
                   end;
               end;

               ID_SERVICIO_ABM_CAJA:
               begin
                    frmabmcaja := Tfrmabmcaja.Create(Application);
                    frmabmcaja.ShowModal;
               end;

               ID_SERVICIO_ABM_TARJETA:
               begin
                   DoAbmTarjeta(MyBd);
               end;

               ID_SERVICIO_ABM_DESCUENTOS:
               begin
                   DoAbmDescuento(MyBd);
               end;

               ID_SERVICIO_ENCUESTA_SATISFACCION:
               begin
                   DoEncuestaSatisfaccion;
               end;

               ID_SERVICIO_ESTADISTICAS_ENCUESTA:
               begin
                   generateEstadisticaEncuestas;
               end;

               ID_SERVICIO_CAMBIO_FECHA:
               begin
                    DoCambioFechaVencimiento;
               end;

               ID_SERVICIO_MED_INSPECCION:
               begin
                    doMedicionesInspeccion;
               end;

               ID_SERVICIO_RESUMEN_MEDICIONES:
               begin
                   DoControlMediciones;
               end;

               ID_SERVICIO_RESUMEN_MEDICIONES_INC:
               begin
                   DoControlMedicionesIncompletas;
               end;

               ID_SERVICIO_REGISTRO_OBLEAS_INUT:
               begin
                   DoObleaInutilizada;
               end;
              ID_SERVICIO_REGISTRO_OBLEAS_ANUL:
               begin
                   DoObleaAnulada;
               end;
               ID_SERVICIO_IMPRIME_OBLEAS_INUT:
               begin
                  doImprimeOblInut
               end;
               ID_SERVICIO_IMPRIME_OBLEAS_ANUL:
               begin
                  DoImprimeOblAnul
               end;
               ID_SERVICIO_EXPORTA_ENTE:
               begin
                 DoExportacionEnte;
               end;
               ID_SERVICIO_EXPORTA_ESPANA:
               begin
                 DoExportacionEspana;
               end;
               ID_SERVICIO_EXPORTA_ENTEOBLEAS:
               begin
                 DoExportacionEnteObleas
               end;
               ID_SERVICIO_EXPORTA_ANEXOS:
               begin
                 DoExportacionAnexo
               end;
               ID_SERVICIO_LISTADO_CAMBIO_FECHA:
               begin
                 GenerateListadoCambioFecha
               end;
               ID_SERVICIO_CAMBIO_PLANTA:
               begin
                 DoSeleccionarPlanta
               end;
               ID_SERVICIO_TOTALES_CAJA:
               begin
                  GenerateArqueoCajaTotales;
               end;
               ID_SERVICIO_TOTALES_TARJETAS:
               begin
                  GenerateListadoTotalTarjetas;
               end;

               ID_SERVICIO_TOTALES_TARJETAS_GNC:
               begin
                  GenerateListadoTotalTarjetasGNC;
               end;

               ID_SERVICIO_LISTADO_MARCAS:
               begin
                    DoListadoMarcas;
               end;

               ID_SERVICIO_INSPECCION_GNC:
               begin
                 DoRecepGNC(tfVerificacion(lparams[0]-1),'')
               end;

               ID_SERVICIO_FACTURACION_GNC:
               begin
                DoFacturacionGNC(tfVerificacion(lparams[0]-1),'')
               end;

               ID_SERVICIO_RESUMEN_DESCUENTOS_GNC:
               begin
                 GenerateResumenDescuentoGNC
               end;

               ID_SERVICIO_LISTADO_CILI_REGU:
               begin
                 DoListadoCiliRegu
               end;

               ID_SERVICIO_INFORME_DEFECTOS:
               begin
                 doDefectosInspeccion
               end;

               ID_SERVICIO_LISTADO_VEH_OFICIAL:
               begin
                 GenerateListadoVehOficial('7');
               end;

               ID_SERVICIO_LISTADO_CAMBIO_ZONA:
               begin
                 GenerateListadoCambioZona
               end;

               ID_SERVICIO_PROVINCIA_SEGUROS_CONS:
               begin
                 DoDatosProvSeguros
               end;

               ID_SERVICIO_PROVINCIA_SEGUROS_IMP:
               begin
                  DoImportaProvincia
               end;

               ID_SERVICIO_EXPORTA_GNC:
               begin
                  DoExportacionGNC
               end;

               ID_SERVICIO_ANULA_OBLEA_GNC:
               begin
                  DoObleaAnuladaGNC
               end;

               ID_SERVICIO_IMPRIME_OBLEAS_ANUL_GNC:
               begin
                 DoImprimeOblAnulGNC
               end;

               ID_SERVICIO_DEC_JURADAS:
               begin
                  GenerateListadoDecJuradas
               end;

               ID_SERVICIO_ESTADO_VTV:
               begin
                  GenerateListadoEstadoVTV
               end;

               ID_SERVICIO_EXPORTA_PROVINCIA:
               begin
                  DoExportacionProvSeguros
               end;

               ID_SERVICIO_LIQUIDACION_DIARIA:
               begin
                 GenerateLiqDiaria;
               end;

               ID_SERVICIO_SOCIOS_ACA:
               begin
                    GenerateSociosAca;
               end;

               ID_SERVICIO_CAMBIO_FECHA_GNC:
               begin
                   DoCambioFechaVencGNC;
               end;

               ID_SERVICIO_REIMP_REEMPLAZO_OBLEAS:
               begin
                  DoReimpresiones(REIMP_REEMP_OBLEAS);
               end;

               ID_SERVICIO_REIMP_DEC_JURADA:
               begin
                  DoReimpresiones(REIMP_DEC_JURADAS);
               end;

               ID_SERVICIO_LISTADO_CLIENTES_CUIT:
               begin
                  GenerateListadoCliCuit;
               end;

               ID_SERVICIO_ALTA_OBLEAS:
               Begin
                  DoAltasDeObleas
               end;

               ID_SERVICIO_REGISTRO_OBLEAS_NC:
               Begin
                  DoReestablecerObleaNC;
               end;

               ID_SERVICIO_REGISTRO_OBLEAS_BLOQUEADAS:
               Begin
                  DoReestablecerObleaBloqueada;
               end;

               ID_SERVICIO_EJECUTAR_PAQUETES:
               Begin
                  DoEjecutarPaqueteSQL;
               end;

              ID_SERVICIO_INFORMES_TIEMPOS:
               begin
                   GenerateInformesDeTiempos;
               end;
               //ALERTTAS VEHICULOS: MARTIN 03/05/2013
               ID_SERVICIO_ALERTA_VEHICULOS:
               BEGIN

                    with Tfrmalertas_vehiculos.Create(Nil) do
                      try
                         showmodal;
                       finally
                          free;
                         end;
               END;


                   ID_SERVICIO_CAMBIA_CALIFICACION_DEFECTO_SOLO_PARA_REVE:
                     BEGIN

                        with Tcambiar_calificacion_defectos_solo_reve.Create(Nil) do
                           try
                              showmodal;
                              finally
                              free;
                             end;
                       END;


                   ID_SERVICIO_BORRA_DEFECTO_SOLO_REVES_A:
                     BEGIN

                        with Tborrar_defectos_solo_reveApta.Create(Nil) do
                           try
                              showmodal;
                              finally
                              free;
                             end;
                       END;
             end;
          end
        else
          MessageDlg(Caption,'No tiene permisos suficientes para realizar la operaci�n seleccionada.',mtInformation,[mbOk],mbOk,0)
        end;
    end;

procedure TFMainSag98.Mantenimientodevehculos1Click(Sender: TObject);
var
aServicio : integer;
begin
aServicio := (Sender as TComponent).Tag;
  case aServicio of
    5000,5001,5002,5003,5004,5006,5008,5012 : DoServicio((aServicio div 1000),[(aServicio mod 5000)]);
    6028,6029,6049,6046,6027,6074,6075,6076,6077,6078 : DoServicio((aservicio-6000),['C']);
    7110,7111 : DoServicio((aServicio div 100),[(aServicio mod 7100)]);
    7312 : DoServicio((aServicio div 100),[(aServicio mod 7300)]);
  else
    DoServicio(aServicio, [''])
  end;
end;


procedure TFMainSag98.SBSalirClick(Sender: TObject);
//var
//impfis: _PrinterFiscalDisp;
var
impfis: _PrinterFiscalDisp;
begin

With TEndApplicationForm.Create(Application) do
  Try
    Show;

If FrmLinea<>nil then
  FrmLinea.Free;
If FrmLineaGNC<>nil then
  FrmLineaGNC.Free;
If FTmp <>nil then
  FTmp.Free;
Application.OnException := nil;
Enabled:=False;
   Application.ProcessMessages;
impfis := CreateComObject(CLASS_PrinterFiscal) as _PrinterFiscalDisp;  //  Para que no de error al salir
APplication.ProcessMessages;
FinishAplicationGlobalTables;

    Thread.Finaliza;
    while not Thread.EndReached do
      Application.ProcessMessages;
    If Assigned(Thread) then
      Thread.Free;

    Hide;
  Finally
    Free;
  end;

  application.Terminate;
{
If FrmLinea<>nil then
  FrmLinea.Free;
If FrmLineaGNC<>nil then
  FrmLineaGNC.Free;
If FTmp <>nil then
  FTmp.Free;
Application.OnException := nil;
Enabled:=False;

impfis := CreateComObject(CLASS_PrinterFiscal) as _PrinterFiscalDisp;  //  Para que no de error al salir
APplication.ProcessMessages;
FinishAplicationGlobalTables;
close;
}
end;

procedure TFMainSag98.CaptureException (Sender: TObject; E: Exception);
begin
//control de excepciones
if E is EDatabaseError then
  begin
    Messagedlg(Application.Title,'Aviso: '+E.Message,mtWarning,[mbok],mbok,0);
  end
else
  Messagedlg(Application.Title,'Aviso:'+E.Message,mtWarning,[mbok],mbok,0);
end;


procedure TFMainSag98.MantenimientodeUsuarios1Click(Sender: TObject);
begin
DoMantenimientoUsuarios(GestorSeg, ApplicationUser, PasswordUser);
end;


Function TFMainSag98.TestPrOrStCurrent: Boolean;
var
aQ: TSQLDataset;
dsp : TDataSetProvider;
cds : TClientDataSet;
begin
//Si el equipo actual es un servidor, o una pc distinta a caja testea la existencia de preverificaciones
//o inspecciones en StandBy dentro de la estacion y muestra un mensaje.
Result:=False;
If (TipoEquipo = SERVIDOR_VALUE) or ((TipoEquipo = CONSOLA_VALUE) and (sEsCaja = 0)) then
  begin
    try
      aQ := TSQLDataSet.Create(self);
      aQ.SQLConnection := MyBD;
      aQ.CommandType := ctQuery;
      aQ.GetMetadata := false;
      aQ.NoMetadata := true;
      aQ.ParamCheck := false;

      dsp := TDataSetProvider.Create(self);
      dsp.DataSet := aQ;
      dsp.Options := [poIncFieldProps,poAllowCommandText];

      cds:=TClientDataSet.Create(self);

      With cds do
        begin
          SetProvider(dsp);
          CommandText := (SQL_SELECT_STANDBY_AND_PREVERIF);
          open;
          If RecordCount>0 then
            Begin
              DialogsFont.Size:=15;
              If Messagedlg(Application.Title,MSJ_STANDBY_AND_PREVERIF,mtConfirmation,[mbyes,mbno],mbyes,0)=mryes then
                Result:=True;
              DialogsFont.Size:=8;
            end;
        end;
    finally
      cds.Close;
      cds.Free;
        dsp.Free;
      aq.Close;
      aq.Free;
    end;
  end
else
if (sEsCaja = 1) then
  btnVerPendFact.Visible:=true;
end;


Procedure TFMainSag98.SetActiveServices;
Begin
//Actualizar servicios activos
With fVarios Do
  Try
    First;
    If ActivarVoluntarias = OP_INACTIVA then    //Desactivacion de las voluntarias
      begin
        SBVoluntaria.Enabled:=False;
        CVoluntaria1.Enabled:=False;
      end;
    If ActivarGratuitas = OP_INACTIVA  then     //Desactivacion de las Gratuitas
      begin
        SBGratuita.Enabled:=False;
        DGratuita1.Enabled:=False;
      end;
    If ActivarPreverificaciones = OP_INACTIVA  then //Desactivacion de las Preverificaciones
      begin
        SBPreverificacion.Enabled:=False;
        BPreverificacin1.Enabled:=False;
      end;
    If ActivarGNC = op_INACTIVA_N then          //Desactivacion de las utilidades GNC
      begin
        btnRPA.visible := false;
        btnLineaGNC.visible := false;
        HLneadeInspeccinGNC1.Visible := false;
        GNCRTA1.Visible := false;
        DTarjetaAmarilla1.Visible := FALSE;
        EFichaTcnicaGNC1.Visible := false;
        N17.Visible := false;
        FDefectosInspeccinGNC1.visible := false;
        N2.visible := false;
        BCilindrosyReguladores1.visible := false;
      end;
    If ActivarGNC_RC = op_INACTIVA_N then  //Desactivacion de las utilidades GNC
      begin
        btnRC.visible := false;
        GNCRC1.Visible := false;
      end;
  Finally
  end;
end;

Procedure TFMainSag98.UpdateLineaInspeccion(var msg:tmessage);
begin
//Cambio en la linea de inspeccion
if FrmLinea<>nil then
  SendMessage(FrmLinea.Handle,WM_LINEAINSP,0,0);
if FrmPendientesFact<>nil then
  SendMessage(FrmPendientesFact.Handle,WM_LINEAINSP,0,0);
end;


Procedure TFMainSag98.UpdateLineaInspeccionGNC(var msg:tmessage);
begin
//Cambio en la linea de inspeccion GNC
if FrmLineaGNC<>nil then
  SendMessage(FrmLineaGNC.Handle,WM_LINEAINSPGNC,0,0);
if FrmLinea<>nil then
  SendMessage(FrmLinea.Handle,WM_LINEAINSP,0,0);
end;


Procedure TFMainSag98.UpdatePrintJob(var msg:tmessage);
var
ii: integer;
begin
//Actualizacion de tabajos de impresion
for ii:=0 to Screen.FormCount-1 do
  begin
    if UpperCase(Screen.forms[ii].ClassName)='TFICHACLIENTE' then
      begin
        SendMessage(Screen.forms[ii].Handle,WM_SERVIMPRE,0,0);
      end;
  end;
end;


procedure TFMainSag98.FormDestroy(Sender: TObject);
begin
if Thread <> nil then
  Thread.Finaliza;
end;


procedure TFMainSag98.ControlarCF;
var
superregistry: TSuperRegistry;
begin
  try
    superregistry:= tsuperregistry.create();
    with SuperRegistry do
      try
        RootKey := HKEY_LOCAL_MACHINE;
        if not OpenKeyRead(CAJA_) then
          begin
            Messagedlg('ERROR','No se encontraron los par�metros de la Estaci�n de Trabajo', mtInformation, [mbOk],mbOk,0);
          end
        else
          begin
            BaudRate:= ReadString(BAUDRATE_);
            PortNumber:= ReadString(PORTNUMBER_);
            SOLOREVE:= ReadString(SOLOREVE_);


          end;
      except
        on E: exception do
          InitError(Format('No se leyeron correctamente los parametros por: %S', [E.message]));
      end;
  finally
    superregistry.Free;
  end;

  try
    try
      fptoventa:=nil;
      fptoventa:=tptoventa.create(MyBd);
      if (fPtoVenta.EsCaja) AND (SOLOREVE<>'S') then
        begin
          if fptoventa.GetTipo <> 'E' then
            begin
              if fptoventa.gettipo = 'C' then
                begin
                  if fptoventa.EncendidoyFunciona then
                    begin
                      if not fptoventa.StatusCF then
                        begin
                          hacerCierreZ:=true;
                        end
                      else
                        hacerCierreZ:=false;
                    end
                  else
                    begin
                      application.messagebox('Error de comunicaci�n con el Controlador Fiscal.'+#13+
                                             'Aseg�rese de que el Controlador est� enchufado y encendido',pchar(caption),mb_ok+mb_iconerror+mb_applmodal);

                     sincronizacion_cf.showmodal;

                    end;
                end;
            end;
        end;
    except
      application.messagebox('El Punto de Venta conectado a su PC no es el correcto.  Por favor, realice las correcciones necesarias y vuelva a intentarlo.','',mb_ok);
    end;
  finally
    fptoventa.close;
    fptoventa.free;
  end;
end;


procedure TFMainSag98.HabilitarBotones;
begin
If PasswordUser = MASTER_KEY then
  begin
    BExportacion1.Visible := true;
    btnCambioPlanta.visible := true;
    Reimpresiones2.visible := true
  end;
If PasswordUser = ADM_KEY then
  btnCambioPlanta.visible := true;
If ApplicationUser = 0 then
  begin
    GeneracinFactura1.Enabled := true;
  end;
end;


procedure TFMainSag98.Acercade1Click(Sender: TObject);
begin
  with TfrmAcercaDe.Create(application) do
    try
      label1.Caption:= 'Fecha de la Build: '+FECHA_VERSION;
      lblVersion.caption := NOMBRE_PROYECTO + VERSION_PROYECTO;
      showmodal;
    finally
      free;
    end;
end;


procedure TFMainSag98.SpeedItem1Click(Sender: TObject);
begin
DoSeleccionarPlanta;
end;


procedure TFMainSag98.Preves1Click(Sender: TObject);
begin
GenerateInformesDeReverificaciones;
end;


procedure TFMainSag98.Reimpresiones2Click(Sender: TObject);
begin
ReimpresionesInfObleas;
end;


procedure TFMainSag98.btnVerPendFactClick(Sender: TObject);
begin
DoVerPendientesFacturar(MyBD,Self);
end;

procedure TFMainSag98.RevesExt1Click(Sender: TObject);
begin
DoRevesExternas;
end;
procedure TFMainSag98.InformadeCierreZ1Click(Sender: TObject);

begin
{
if (UID <> 0)  then
 begin
    ShowMessage('Gestion de Usuarios','Usted no tiene acceso a este informe. Consulte con su administrador.');
   exit;
 end; 

 }

with Tlistadocierrez.Create(application) do
    try

      showmodal;
    finally
      free;
    end;
end;

procedure TFMainSag98.AlertasdeVehculos1Click(Sender: TObject);
var
aServicio : integer;
begin
aServicio := (Sender as TComponent).Tag;
  case aServicio of
    5000,5001,5002,5003,5004,5006,5008,5012 : DoServicio((aServicio div 1000),[(aServicio mod 5000)]);
    6028,6029,6049,6046,6027,6074,6075,6076,6077,6078 : DoServicio((aservicio-6000),['C']);
    7110,7111 : DoServicio((aServicio div 100),[(aServicio mod 7100)]);
    7312 : DoServicio((aServicio div 100),[(aServicio mod 7300)]);
  else
    DoServicio(aServicio, [''])
  end;

end;

procedure TFMainSag98.CambiarCalificacinaDefecto1Click(Sender: TObject);
var
aServicio : integer;
begin
aServicio := (Sender as TComponent).Tag;
  case aServicio of
    5000,5001,5002,5003,5004,5006,5008,5012 : DoServicio((aServicio div 1000),[(aServicio mod 5000)]);
    6028,6029,6049,6046,6027,6074,6075,6076,6077,6078 : DoServicio((aservicio-6000),['C']);
    7110,7111 : DoServicio((aServicio div 100),[(aServicio mod 7100)]);
    7312 : DoServicio((aServicio div 100),[(aServicio mod 7300)]);
  else
    DoServicio(aServicio, [''])
  end;

end;

procedure TFMainSag98.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
impfis: _PrinterFiscalDisp;
begin

With TEndApplicationForm.Create(Application) do
  Try
    Show;

If FrmLinea<>nil then
  FrmLinea.Free;
If FrmLineaGNC<>nil then
  FrmLineaGNC.Free;
If FTmp <>nil then
  FTmp.Free;
Application.OnException := nil;
Enabled:=False;
   Application.ProcessMessages;
impfis := CreateComObject(CLASS_PrinterFiscal) as _PrinterFiscalDisp;  //  Para que no de error al salir
APplication.ProcessMessages;
FinishAplicationGlobalTables;

    Thread.Finaliza;
    while not Thread.EndReached do
      Application.ProcessMessages;
    If Assigned(Thread) then
      Thread.Free;

    Hide;
  Finally
    Free;
  end;

 application.Terminate;

end;

procedure TFMainSag98.PendientedeFacturar1Click(Sender: TObject);
begin
DoVerPendientesFacturar(MyBD,Self);
end;

procedure TFMainSag98.ModificarNrodeObleaenInspeccin1Click(
  Sender: TObject);
begin
  with Tfrmodificar_oblea_rucara_inspeccionunit.Create(Nil) do
  try
    showmodal;
     finally
      free;
      end;
end;

procedure TFMainSag98.ModificarNroOblea1Click(Sender: TObject);
var aq:tsqlquery;
begin
  with Tfrmodificar_oblea_en_tvarios.Create(Nil) do
   try
     showmodal;
   finally
      free;
   end;
end;

procedure TFMainSag98.GenerarListadoRUCARA1Click(Sender: TObject);
var sql:string;
 aq:tsqlquery;

 desde,hasta:string;
 excel:variant;
 fila,columna,j:integer;
 data:tdataset;
 mydataset:tdataset;

 begin
pide_fecha.showmodal;
 if pide_fecha.sale=true then exit;

   desde:=datetostr(pide_fecha.DateTimePicker1.DateTime);
   hasta:=datetostr(pide_fecha.DateTimePicker2.DateTime);

 try
 excel:=createoleobject('Excel.Application');
 except
      Application.MessageBox( 'No se puedo carga el excel.',
  'Atenci�n', MB_ICONSTOP );
  exit;

 end;

 sql:='SELECT  C.NOMBRE||'' ''||C.APELLID1, c.tipodocu, c.document, c.cuit_cli ,V.PATENTEN, R.datos_licencia,r.municipio,r.datos_municipio, '+
 ' r.seguro_auto,r.es_conductor,r.mas_conductor,to_char(r.fechalta,''dd/mm/yyyy''),r.numoblea,Format_NumeroInforme(r.codinspe,i.ejercici)  '+
' FROM TRUCARAS R , TCLIENTES  C , TVEHICULOS  V, TINSPECCION I WHERE I.CODINSPE=R.CODINSPE AND R.CODVEHIC=V.CODVEHIC   '+
' AND C.CODCLIEN=R.CODCLIEN   '+
// ' AND R.FECHALTA BETWEEN  to_date('+DateIni+',''DD/MM/YYYY hh24:mi:ss'') AND  to_date('+DateFin+',''DD/MM/YYYY hh24:mi:ss'')';
' AND R.FECHALTA BETWEEN to_date('''+desde+''',''DD/MM/YYYY'') AND  to_date('''+hasta+''',''DD/MM/YYYY'')';

       aq:=tsqlquery.create(self);
       aq.SQLConnection := MyBD;
       aq.sql.add(sql);
       aq.open;

     fila:=1;
     columna:=1;
     excel.workbooks.add;

     excel.cells[fila,1].value:='LISTADO RUCARA';
      fila:=2;
     excel.cells[fila,1].value:='desde '+trim(desde)+' hasta '+trim(hasta);

   fila:=3;
  excel.cells[fila,1].value:='CLIENTE';
  excel.cells[fila,2].value:='TIPO DOCU.';
  excel.cells[fila,3].value:='DOCUMENTO';
  excel.cells[fila,4].value:='CUIT';
  excel.cells[fila,5].value:='PATENTE';
  excel.cells[fila,6].value:='DATO LICENCIA';
  excel.cells[fila,7].value:='MUNICIPIO';
  excel.cells[fila,8].value:='DATOS MUNICIPIO';
  excel.cells[fila,9].value:='SEGURO AUTO';
  excel.cells[fila,10].value:='ES CONDUCTOR';
  excel.cells[fila,11].value:='MAS CONDUCTOR';
  excel.cells[fila,12].value:='FECHA DE INSPECCI�N';
  excel.cells[fila,13].value:='NRO OBLEA';
  excel.cells[fila,14].value:='NRO INSPECCION';

Fila:=4;

TRY

   while not aq.Eof     do
   // for j:=1 to aq.recordcount do
        begin

        excel.Cells.Item[FILA,1]:=aq.Fields[0].AsString;
        excel.Cells.Item[FILA,2]:=aq.Fields[1].AsString;
        excel.Cells.Item[FILA,3]:=aq.Fields[2].AsString;
        excel.Cells.Item[FILA,4]:=aq.Fields[3].AsString;
        excel.Cells.Item[FILA,5]:=aq.Fields[4].AsString;
        excel.Cells.Item[FILA,6]:=aq.Fields[5].AsString;
        excel.Cells.Item[FILA,7]:=aq.Fields[6].AsString;
        excel.Cells.Item[FILA,8]:=aq.Fields[7].AsString;
        excel.Cells.Item[FILA,9]:=aq.Fields[8].AsString;
        excel.Cells.Item[FILA,10]:=aq.Fields[9].AsString;
        excel.Cells.Item[FILA,11]:=aq.Fields[10].AsString;
        excel.Cells.Item[FILA,12]:=aq.Fields[11].AsString;
         excel.Cells.Item[FILA,13]:=aq.Fields[12].AsString;
         excel.Cells.Item[FILA,14]:=aq.Fields[13].AsString;
         FILA:=FILA+1;
        aq.Next;
   end;//while
  excel.Visible:= true;

  except

  end;

end;

procedure TFMainSag98.EliminarDefectodeRevesAptas1Click(Sender: TObject);
begin
    with Tborrar_defectos_solo_reveApta.Create(Nil) do
   try
     showmodal;
   finally
      free;
   end;
end;

end.

