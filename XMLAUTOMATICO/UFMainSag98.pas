unit UFMainSag98;

interface

    uses
        Windows,  UPIDE_TURNO_AUSENTE,
        Messages,
        SysUtils, ShellAPI,
        Classes,
        Graphics,   UGENERA_NC_ELECTRONICA,
        Controls,  Ufrconfiguracion_impresoras,  class_impresion, UcertificadoCABA,
        Forms,   WinInet, WinSock,
        Menus,
        SpeedBar,
        ExtCtrls,
        StdCtrls,  Ufrmturnos,
        Buttons,
        UThread,   Unconsultaws,
        Globals,   ugetdates,
        UFTmp,   ufrmodificar_oblea_en_tvarios,
        EPSON_Impresora_Fiscal_TLB, ComObj, USagClasses, ufabmcaja, usuperregistry,
        DBCtrls, Mask, RxLookup, USagCtte,  Unitfrmodificar_oblea_rucara_inspeccion,
        Provider, DBClient, FMTBcd, DB, SqlExpr, StrUtils, ComCtrls,
  WinSkinData, OleServer, ExcelXP, xmldom, XMLIntf, msxmldom, XMLDoc,
  RxMemDS, Grids, DBGrids, sHintManager;

  type TDatosPC   = record
    Nombre, IP, Usuario :String;
end;


    Const
        WM_SHOW_IMAGE = WM_USER+5;

    type
        TFMainSag98 = class(TForm)
            MainMenu1: TMainMenu;
            Verificaciones1: TMenuItem;
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
            ETiposdeClientes1: TMenuItem;
            Salir1: TMenuItem;
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
            Registrar1: TMenuItem;
            Imprimir1: TMenuItem;
            Inutilizadas1: TMenuItem;
            Anuladas1: TMenuItem;
            Inutilizadas2: TMenuItem;
            Anuladas2: TMenuItem;
            N13: TMenuItem;
            F1: TMenuItem;
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
            CInformeMediciones1: TMenuItem;
            VTV15: TMenuItem;
            GNC15: TMenuItem;
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
    N20: TMenuItem;
    InformadeCierreZ1: TMenuItem;
    iemposvtv1: TMenuItem;
    N21: TMenuItem;
    AlertasdeVehculos1: TMenuItem;
    SkinData1: TSkinData;
    ExcelQueryTable1: TExcelQueryTable;
    ExcelApplication1: TExcelApplication;
    ConfiguracinImpresoras1: TMenuItem;
    AltadeCertificados1: TMenuItem;
    SBarPrincipal: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    SBNormal: TSpeedItem;
    SBPreverificacion: TSpeedItem;
    SBVoluntaria: TSpeedItem;
    SBGratuita: TSpeedItem;
    btnCambioPlanta: TSpeedItem;
    webservices: TSpeedItem;
    btnRPA: TSpeedItem;
    btnRC: TSpeedItem;
    btnVerPendFact: TSpeedItem;
    SpeedItem1: TSpeedItem;
    SpeedItem2: TSpeedItem;
    SBLinea: TSpeedItem;
    btnLineaGNC: TSpeedItem;
    SBSalir: TSpeedItem;
    ControldeEnvios1: TMenuItem;
    DescargarTurno1: TMenuItem;
    Porfecha1: TMenuItem;
    PorPatente1: TMenuItem;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel2: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    BitBtn1: TBitBtn;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    Memo1: TMemo;
    Memo2: TMemo;
    RxMemoryData1: TRxMemoryData;
    RxMemoryData1turnoid: TIntegerField;
    RxMemoryData1hora: TStringField;
    RxMemoryData1patente: TStringField;
    RxMemoryData1estado: TStringField;
    RxMemoryData1titular: TStringField;
    RxMemoryData1telefono: TStringField;
    RxMemoryData1reviso: TStringField;
    RxMemoryData1INFOME: TStringField;
    RxMemoryData1MOTIVO: TStringField;
    RxMemoryData1codinspe: TIntegerField;
    RxMemoryData1anio: TIntegerField;
    RxMemoryData1resultado: TStringField;
    RxMemoryData1modo: TStringField;
    RxMemoryData1marca: TStringField;
    RxMemoryData1modelo: TStringField;
    RxMemoryData1tipoisnpe: TStringField;
    RxMemoryData1ESTADODES: TStringField;
    RxMemoryData1ausentes: TStringField;
    RxMemoryData1estadid: TStringField;
    RxMemoryData1ES: TStringField;
    Timeractulizar: TTimer;
    Timer1: TTimer;
    procesosauscentes: TTimer;
    PopupMenu1: TPopupMenu;
    CambiodeDominiodelTurno1: TMenuItem;
    SolicitarTurnoReverificacion1: TMenuItem;
    XMLDocument2: TXMLDocument;
    DataSource1: TDataSource;
    XMLDocument1: TXMLDocument;
    InformarXML1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    InformarTodos1: TMenuItem;
    N17: TMenuItem;
    InformarAusentes1: TMenuItem;
    InformarAusenteporPatente1: TMenuItem;
    N22: TMenuItem;
    InformarInspeccinporTurnoid1: TMenuItem;
    Informarporlote1: TMenuItem;
    sHintManager1: TsHintManager;
    InformarporFecha1: TMenuItem;
    InformarTipo51: TMenuItem;

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
    procedure Button1Click(Sender: TObject);
    procedure webservicesClick(Sender: TObject);
    procedure ConfiguracinImpresoras1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SpeedItem2Click(Sender: TObject);
    procedure ControldeEnvios1Click(Sender: TObject);
    procedure PorPatente1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TimeractulizarTimer(Sender: TObject);
    procedure procesosauscentesTimer(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure InformarXML1Click(Sender: TObject);
    procedure InformarTodos1Click(Sender: TObject);
    procedure InformarAusentes1Click(Sender: TObject);
    procedure InformarAusenteporPatente1Click(Sender: TObject);
    procedure CambiodeDominiodelTurno1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure InformarInspeccinporTurnoid1Click(Sender: TObject);
    procedure Informarporlote1Click(Sender: TObject);
    procedure InformarporFecha1Click(Sender: TObject);
   // procedure EliminarDefectodeRevesAptas1Click(Sender: TObject);
    function INFORMAR_TODOS_LOS_TIPO_5:BOOLEAN;
    procedure InformarTipo51Click(Sender: TObject);
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
           dpc:TDatosPC;
           HORA_AUSENTES:string;
            { Public declarations }
            procedure BorrarArchivos;
            procedure ObtenerDatosPC (var Datos:TDatosPC );
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
        UAltasdeOblea,  UAltadeCertificados,
        UReImpresionObleas,
        UFRestaurarOblea,
        uSQLExec,
        ufPendientesFacturar,
        Ulistadocierrez,
 ufInformeRevesExternasToPrint,UFRESULTADINSPECTIEMPOS, Ufaletas_vehiculos,
  Unitsincronizacion_cf, Uncambiar_calificacion_defectos_solo_reve,
  Unifinaliza,
  Unborrar_defectos_solo_reveApta , Unitpide_fecha,
  Unitfrmdiseniofactelectronica, UniCONTROLSERVICIO_SVVTV, Unitporpatnete,
  Upideidturno, Unicambiodominioturno, UniPORIDTURNO,
  UnitINFORMAR_INSPE_POR_ID, Unitinformar_por_fcha1;


    resourcestring
        FILE_NAME = 'UFMAINSAG98.PAS';
        SQL_SELECT_STANDBY_AND_PREVERIF = 'SELECT I.CODINSPE FROM TINSPECCION I, TESTADOINSP E WHERE I.TIPO IN (''F'',''B'') AND I.CODINSPE = E.CODINSPE AND I.EJERCICI = E.EJERCICI';
        MSJ_STANDBY_AND_PREVERIF = 'Hay Inspecciones en StandBy y Preverificaciones.'+#10#13+
                                   '   ¿Desea Visualizar la Linea de Inspeccion?';

    const
        bActivandose : boolean = TRUE;


procedure InitError(Msg: String);
begin
MessageDlg('Error en la Inicialización',Msg,mtError,[mbOK],mbOK,0);
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
          //InitError('No se encontró el usuario y la contraseña especificada')
          InitializationError:=true;
        end
      else
        InitError('No se generó de forma correcta la gestión de acceso')
    end
  else
    InitError('No se generó la gestión de acceso, no existe base de datos');
end;


procedure TFMainSag98.ObtenerDatosPC (var Datos:TDatosPC );
const LARGO_MAXIMO = 50;
var   buffer:Array [0..LARGO_MAXIMO+1] of char;
        Largo:Cardinal;
  PuntHost: PHostEnt;
  PuntIP: PAnsichar;
  wVersionRequested: WORD;
  wsaData: TWSAData;
begin
     Largo := LARGO_MAXIMO +1;
   Datos.Nombre := '';
   If GetComputerName (buffer, Largo) then
      Datos.Nombre := buffer;
 
   Datos.Usuario := '';
   {if GetUserName(buffer, largo) then
        Datos.Usuario := buffer; }
 
  wVersionRequested := MAKEWORD( 1, 1 );
  WSAStartup( wVersionRequested, wsaData );
  GetHostName( @buffer, LARGO_MAXIMO );
  PuntHost := GetHostByName( @buffer );
  PuntIP := iNet_ntoa( PInAddr( PuntHost^.h_addr_list^ )^ );
  Datos.IP := PuntIP ;
  WSACleanup;
end;

procedure TFMainSag98.FormActivate(Sender: TObject);
begin
self.Cursor:=crSQLWait;
self.Hint:='ESPERE POR FAVOR...';
application.ProcessMessages;
//Activacion del fornm
If FirstActivating then
  begin
    sBarra.Panels[0].Text:=GetFullUserName;
     sBarra.Panels[1].Text:='   Version: '+uversion.VERSION+'    '+uversion.FECHA_VERSION;
    FirstActivating:=FalsE;
    If TestPrOrStCurrent then
      SBLinea.Click;

 
    habilitarbotones;
  end;


 self.Cursor:=crDefault;
SELF.Hint:='';

application.ProcessMessages;
end;


procedure TFMainSag98.FormShow(Sender: TObject);
var
Ahora : tDateTime;
begin


ObtenerDatosPC(dpc);

If bActivandose then
  begin
  //PChar(NOMBRE_PROYECTO)
  Top := -7000;
  {if (FindWindow(Pchar('TFInicioAplicacion'), PChar('Delphi 7')) <> 0) or (FindWindow(Pchar('TFMainSag98'), PChar('Planta Verificadora de Vehículos')) <> 0)
  or (FindWindow(Pchar('TFMainSag98'), PChar('Planta Verificadora de Vehículos - [Vehículos en estación hoy ]')) <> 0) then //Lucho
  InitError('Ya existe una copia del programa en ejecución') }
//  else
    InitLogs;

    if InitializationError then
    exit;

    Caption := 'CONTROL DE ENVIO DE INSPECCIONES A SUVTV';

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

                Status.Caption := Format('%S (Conectándose al servidor)', [LITERAL_VERSION]);
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

                //Inicializar tablas de información globales de la  aplicación
                Status.Caption := Format('%S (Iniciando Configuración Base)', [LITERAL_VERSION]);
                Application.ProcessMessages;





                InitAplicationGlobalTables;

                if InitializationError then
                exit;

                Ahora := Now;
                while Now <= (Ahora + EncodeTime(0,0,3,0)) do Application.ProcessMessages;

               { Status.Caption := Format('%S (Comprobando Controlador Fiscal)', [LITERAL_VERSION]);
                Application.ProcessMessages;
                ControlarCF;
                Thread:= TProcessThread.Create (MyBd,self,1);
                }
                NumeroPlanta:=IntToStr(fVarios.Zona)+IntToStr(fVarios.CodeEstacion);

            finally
                Free
            end;
            SetActiveServices;
            Top := Top + 7000;
            Application.ProcessMessages;
        end;


    { self.Cursor:=crSQLWait;
 frmturnos.cargar_turnos(datetostr(date));
application.ProcessMessages;
 self.Cursor:=crDefault; }

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
                   // ReimpresionFacturasNCredito (FALSE);


                      with TGENERA_NC_ELECTRONICA.Create(Nil) do
                           try
                              showmodal;
                              finally
                              free;
                             end;

                end;

                ID_SERVICIO_REIMPRESION_CERTIFICADO:
                begin
                    ReimpresionCertificados;
                end;

                ID_SERVICIO_REIMPRESION_INFORME:
                begin
                    reimprimir_informe_caba;
                   // ReimpresionInformesInspeccion;
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
                       raise exception.create('El Controlador Fiscal no Funciona Correctamente. Controle que esté enchufado y/o encendido');
                   end
                   else
                       raise exception.create('Esta PC no está habilitada como Caja');
                   except
                         on E: Exception do
                         begin
                           MessageDlg(Caption,Format('Error inicializando el formulario de Cierre de Jornada: %s. Comience de nuevo y si el error persiste, indíquelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk],mbOk,0);
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
              220:
               Begin
                  DoAltaDeCertificados
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
          MessageDlg(Caption,'No tiene permisos suficientes para realizar la operación seleccionada.',mtInformation,[mbOk],mbOk,0)
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


 MYBD.Close;




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

impfis := CreateComObject(CLASS_PrinterFiscal) as _PrinterFiscalDisp;
 //  Para que no de error al salir
APplication.ProcessMessages;
FinishAplicationGlobalTables;


  {  Thread.Finaliza;
    while not Thread.EndReached do
      Application.ProcessMessages;   }
      
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
            Messagedlg('ERROR','No se encontraron los parámetros de la Estación de Trabajo', mtInformation, [mbOk],mbOk,0);
          end
        else
          begin
            BaudRate:= ReadString(BAUDRATE_);
            PortNumber:= ReadString(PORTNUMBER_);
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
      if fPtoVenta.EsCaja then
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
                      application.messagebox('Error de comunicación con el Controlador Fiscal.'+#13+
                                             'Asegúrese de que el Controlador esté enchufado y encendido',pchar(caption),mb_ok+mb_iconerror+mb_applmodal);

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
  //  BExportacion1.Visible := true;
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
MYBD.Close;






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

   {
    Thread.Finaliza;
    while not Thread.EndReached do
      Application.ProcessMessages;
    If Assigned(Thread) then
      Thread.Free;
      }




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
  'Atención', MB_ICONSTOP );
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
  excel.cells[fila,12].value:='FECHA DE INSPECCIÓN';
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

procedure TFMainSag98.Button1Click(Sender: TObject);
VAR aq,AV:tsqlquery;
IDT,IDCLIENTE, IDTURNO:LONGINT;
DOCUMENTO, APE, NOM,SQL:STRING;
TIMPRE:TIMPRESIONCABA;
begin

end;

procedure TFMainSag98.webservicesClick(Sender: TObject);
//var Frmgestion:Tfrmturnos;
begin
frmturnos.showmodal;
{Frmgestion:= Tfrmturnos.create(application);
    with Frmgestion do
      try
     

        Showmodal();
      except
        on E: Exception do
          MessageDlg(Application.Title,'No pueden visualizarse los turnos.',mtInformation,[mbOk],mbOk,0);
      end;  }
end;

procedure TFMainSag98.ConfiguracinImpresoras1Click(Sender: TObject);
begin
with Tfrconfiguracion_impresoras.Create(Nil) do
  try
    showmodal;
     finally
      free;
      end;
end;

procedure TFMainSag98.BitBtn1Click(Sender: TObject);
var facturado,numoblea:string;
StoredProc: TSQLStoredProc;    aq1:TSQLQuery;
 aq,aqb:TSQLQuery;  idturno,codinspe,TURNOID,CODVEHIC,EJERCICI:longint;


  i: Integer;
  si: String;
  Hoja: _WorkSheet;

 {
TURNOID,	TIPOTURNO	,FECHATURNO,	HORATURNO,
	FECHAREGISTRO	,TITULARGENERO ,	TTULARTIPODOCUMENTO,
  TITULARNRODOCUMENTO,	TITULARNOMBRE	,TITULARAPELLIDO ,	CONTACTOGENERO,	CONTACTOTIPODOCUMENTO,	CONTACTONRODOCUMENTO,
  	CONTACTONOMBRE,	CONTACTOAPELLIDO,	CONTACTOTELEFONO,	CONTACTOEMAIL,	CONTACTOFECHANAC,	DVDOMINO ,	DVMARCAID,DVMARCA,
    DVTIPOID ,	DVTIPO ,	DVMODELOID ,	DVMODELO,DVANIO,	DVJURISDICCIONID ,	DVJURISDICCION ,	DFGENERO,	DFTIPODOCUMENTO ,
    DFNRODOCUMENTO ,	DFNOMBRE ,	DFAPELLIDO ,	DFCALLE	,DFNUMEROCALLE,DFPISO ,	DFDEPARTAMENTO ,	DFLOCALIDAD,DFPROVINCIAID,
    	DFPROVINCIA,	DFCODIGOPOSTAL ,	DFIVA,	DFIIBB	,PAGOSID	,PAGOSGETWAY ,	PAGOSENTIDADID ,	PAGOSENTIDAD ,	PAGOSFECHA ,
      PAGOSIMPORTE,PAGOSESTADOLIQUIDACION	,CODVEHIC	,CODCLIEN	,AUSENTE ,	FACTURADO	,REVISO	,DVNUMERO	,CODINSPE ,
      	ANIO ,	IMPORTEVERIFICACION,	IMPORTEOBLEA ,	CAE	,FECHAVENCE ,	RESPUESTAAFIP	,APROBADA ,	NRO_COMPROBANTE,	INFORMADOWS ,
        MOTIVO ,	CODCLIENTEPRESENTANTE	,TIPOCOMPROBANTEAFIP ,	ENVIOMAIL	,ERROR_MAIL,	CUITTITULAR	,CUITCONTACTO,
        	CUITFACTURA	,CONTACTORAZONSOCIA,TITULARRAZONSOCIAL ,	FACTURARAZONSOCIA,	PAGOIDVERIFICACION ,
          	ESTADOACREDITACIONVERIFICACION ,
            PAGOGESTWAYIDVERIFICACION	,PAGOIDOBLEA ,	ESTADOACREDITACIONOBLEA,	VALTITULAR ,	VALCHASIS	,
            DATOSVEHICULOMTM ,	MARCAIDVAL,	MARCAVAL ,	TIPOIDVAL,	TIPOVAL	,MODELOIDVAL ,
            	MODELOVAL,	MARCACHASISVAL ,	NUMEROCHASISVAL	,MTMVAL	,ARCHIVOENVIADO	,MODO	,FECHALTA	,PLANTA	,
              TIPOINSPE,	ESTADOID ,	ESTADODESC:string;
   }

 begin
 self.Cursor:=crSQLWait;
 application.ProcessMessages;
 frmturnos.cargar_turnos(datetostr(date));
application.ProcessMessages;
 self.Cursor:=crDefault;
 application.ProcessMessages;
 {
ExcelApplication1.Workbooks.Open( 'C:\APPLUS\DESARROLLO STARTEAM\EN DESARROLLOS\SISTEMA SAG VTV\VTVSAG CAPITAL FEDERAL\TDATOSTURNO2.xls',
  EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
  EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
  EmptyParam, EmptyParam, EmptyParam, EmptyParam, 0 );

Hoja := ExcelApplication1.Worksheets.Item[1] as _WorkSheet;

  i := 2;
si := IntToStr( i );
repeat



TURNOID,
TIPOTURNO	,
FECHATURNO,
HORATURNO,
FECHAREGISTRO	,
TITULARGENERO ,
TTULARTIPODOCUMENTO,
TITULARNRODOCUMENTO,
TITULARNOMBRE	,
TITULARAPELLIDO ,
CONTACTOGENERO,
CONTACTOTIPODOCUMENTO,
CONTACTONRODOCUMENTO,
CONTACTONOMBRE,
CONTACTOAPELLIDO,
CONTACTOTELEFONO,
CONTACTOEMAIL,
CONTACTOFECHANAC,
DVDOMINO ,
DVMARCAID,
DVMARCA,
DVTIPOID ,
DVTIPO ,
DVMODELOID ,
DVMODELO,
DVANIO,
DVJURISDICCIONID ,
DVJURISDICCION ,
DFGENERO,
DFTIPODOCUMENTO ,
    DFNRODOCUMENTO ,
    DFNOMBRE ,
    DFAPELLIDO ,
    	DFCALLE	,
      DFNUMEROCALLE,
      DFPISO ,
      DFDEPARTAMENTO ,
      	DFLOCALIDAD,
        DFPROVINCIAID,
    	DFPROVINCIA,
      	DFCODIGOPOSTAL ,
        	DFIVA,
          DFIIBB	,
          PAGOSID	,
          PAGOSGETWAY ,
          PAGOSENTIDADID ,
          	PAGOSENTIDAD ,
            	PAGOSFECHA ,
      PAGOSIMPORTE,
      PAGOSESTADOLIQUIDACION	,
      CODVEHIC	,
      CODCLIEN	,AUSENTE ,	FACTURADO	,REVISO	,DVNUMERO	,CODINSPE ,
      	ANIO ,	IMPORTEVERIFICACION,	IMPORTEOBLEA ,	CAE	,FECHAVENCE ,	RESPUESTAAFIP	,APROBADA ,	NRO_COMPROBANTE,	INFORMADOWS ,
        MOTIVO ,	CODCLIENTEPRESENTANTE	,TIPOCOMPROBANTEAFIP ,	ENVIOMAIL	,ERROR_MAIL,	CUITTITULAR	,CUITCONTACTO,
        	CUITFACTURA	,CONTACTORAZONSOCIA,TITULARRAZONSOCIAL ,	FACTURARAZONSOCIA,	PAGOIDVERIFICACION ,
          	ESTADOACREDITACIONVERIFICACION ,
            PAGOGESTWAYIDVERIFICACION	,PAGOIDOBLEA ,	ESTADOACREDITACIONOBLEA,	VALTITULAR ,	VALCHASIS	,
            DATOSVEHICULOMTM ,	MARCAIDVAL,	MARCAVAL ,	TIPOIDVAL,	TIPOVAL	,MODELOIDVAL ,
            	MODELOVAL,	MARCACHASISVAL ,	NUMEROCHASISVAL	,MTMVAL	,ARCHIVOENVIADO	,MODO	,FECHALTA	,PLANTA	,
              TIPOINSPE,	ESTADOID ,	ESTADODESC:string;




     Hoja.Range['A'+si,'A'+si].Value2 ;
     Hoja.Range['B'+si,'B'+si].Value2 ;
    Hoja.Range['C'+si,'C'+si].Value2 ;
     Hoja.Range['D'+si,'D'+si].Value2 ;//o


  Inc( i );
  si := IntToStr( i );
until ( VarType( ExcelApplication1.Range['A'+si,'A'+si].Value2 ) = VarEmpty );

  }

end;

procedure TFMainSag98.SpeedItem2Click(Sender: TObject);
begin
CONTROLSERVICIO_SVVTV.SHOWMODAL;
end;

procedure TFMainSag98.ControldeEnvios1Click(Sender: TObject);
begin
frmturnos.showmodal;
end;

procedure TFMainSag98.PorPatente1Click(Sender: TObject);
begin
ShellExecute(FMainSag98.Handle, 'open', 'BUSCARPORPATENTE.EXE',
'', '', SW_SHOWNORMAL);
end;

procedure TFMainSag98.Timer1Timer(Sender: TObject);
var  aqlistado,aqSININFORMAR,aqSININFORMAR1:TSQLQuery;
fechaturno:STRING;  inspe:longint;
begin
end;





procedure TFMainSag98.TimeractulizarTimer(Sender: TObject);
begin
//frmturnos.cargar_turnos(datetostr(date));
//application.ProcessMessages;
end;

procedure TFMainSag98.procesosauscentesTimer(Sender: TObject);
 var fecha,fecharchivo:string;
begin


       




end;

procedure TFMainSag98.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin

if DataCol = 2 then
// Para solamente tratar la columna 3 
begin

if trim(self.RxMemoryData1estadid.Value)='6' then
 begin
TDrawGrid(sender).canvas.Brush.Color := clred;
TDrawGrid(sender).canvas.Font.Color := clblack;
TDrawGrid(sender).canvas.Font.Style:=[fsBold];
TdbGrid(sender).DefaultDrawColumnCell(Rect, Datacol, Column, State);

end;

end;

    if DataCol = 14 then
// Para solamente tratar la columna 3
begin

if trim(self.RxMemoryData1tipoisnpe.Value)='R' then
TDrawGrid(sender).canvas.Font.Color := clred
 ELSE
TDrawGrid(sender).canvas.font.Color := clblack;



TDrawGrid(sender).canvas.Font.Style:=[fsBold];
TdbGrid(sender).DefaultDrawColumnCell(Rect, Datacol, Column, State);

end;

          if DataCol = 0 then
// Para solamente tratar la columna 3
begin

if trim(self.RxMemoryData1ES.Value)='Reverificación' then
TDrawGrid(sender).canvas.Font.Color := clred
 ELSE
TDrawGrid(sender).canvas.font.Color := clblue;



TDrawGrid(sender).canvas.Font.Style:=[fsBold];
TdbGrid(sender).DefaultDrawColumnCell(Rect, Datacol, Column, State);

end;

   if DataCol = 8 then
// Para solamente tratar la columna 3
begin

if trim(self.RxMemoryData1reviso.Value)='SI' then
TDrawGrid(sender).canvas.Font.Color := CLGREEN
 ELSE
TDrawGrid(sender).canvas.Font.Color := CLRED;

TDrawGrid(sender).canvas.Font.Style:=[fsBold];

TdbGrid(sender).DefaultDrawColumnCell(Rect, Datacol, Column, State);

end;

    if DataCol = 9 then
// Para solamente tratar la columna 3
begin

if trim(self.RxMemoryData1reviso.Value)='SI' then
TDrawGrid(sender).canvas.Font.Color := CLGREEN
 ELSE
TDrawGrid(sender).canvas.Font.Color := CLRED;



TDrawGrid(sender).canvas.Font.Style:=[fsBold];

TdbGrid(sender).DefaultDrawColumnCell(Rect, Datacol, Column, State);

end;
  
   if DataCol = 10 then
// Para solamente tratar la columna 3
begin

if trim(self.RxMemoryData1INFOME.Value)='SI' then
TDrawGrid(sender).canvas.Font.Color := CLGREEN
 ELSE
TDrawGrid(sender).canvas.Font.Color := CLRED;



TDrawGrid(sender).canvas.Font.Style:=[fsBold];

TdbGrid(sender).DefaultDrawColumnCell(Rect, Datacol, Column, State);

end;


if (Column.Index = 5)  then begin
begin
   if TRIM(self.RxMemoryData1estado.Value)='AUSENTE' THEN
   begin

   Dbgrid1.Canvas.Font.Style:=[fsBold];
   DBGrid1.Canvas.Font.Color:=CLRED;
   DBGrid1.DefaultDrawColumnCell(Rect,Datacol,Column,State);
   end ELSE BEGIN


   Dbgrid1.Canvas.Font.Style:=[fsBold];
   DBGrid1.Canvas.Font.Color:=clgreen;
   DBGrid1.DefaultDrawColumnCell(Rect,Datacol,Column,State);

   END;

end;



        if (TRIM(self.RxMemoryData1reviso.Value)='SI') AND (TRIM(SELF.RxMemoryData1INFOME.Value)='NO') then begin

         Dbgrid1.Canvas.Font.Style:=[fsBold];
         DBGrid1.Canvas.Font.Color:=CLRED;
        // Manda pintar la celda
         DBGrid1.DefaultDrawColumnCell(rect,9,column,State);
        end;

           if (TRIM(self.RxMemoryData1reviso.Value)='SI') AND (TRIM(SELF.RxMemoryData1INFOME.Value)='') then begin

         Dbgrid1.Canvas.Font.Style:=[fsBold];
         DBGrid1.Canvas.Font.Color:=CLRED;
        // Manda pintar la celda
         DBGrid1.DefaultDrawColumnCell(rect,9,column,State);
        end;
         if (TRIM(self.RxMemoryData1reviso.Value)='SI') AND (TRIM(SELF.RxMemoryData1INFOME.Value)='SI') then begin

         Dbgrid1.Canvas.Font.Style:=[fsBold];
         DBGrid1.Canvas.Font.Color:=CLGREEN;
        // Manda pintar la celda
         DBGrid1.DefaultDrawColumnCell(rect,9,column,State);
        end;






 end;

end;

procedure TFMainSag98.InformarXML1Click(Sender: TObject);
begin
 //Informar_Inspeccion(214,13,2016);
  if (trim(dbgrid1.Fields[6].asstring)='NO') then
  begin
  Application.MessageBox( 'ESTA INSPECCION NO FUE REVISADA.',
  'Acceso denegado', MB_ICONSTOP );
  exit;
  end;



     frmturnos.INFORMA_INSPECCION_AL_WEBSERVICES(self.RxMemoryData1turnoid.Value,self.RxMemoryData1codinspe.Value,self.RxMemoryData1anio.Value);



frmturnos.cargar_turnos(datetostr(date));

end;

procedure TFMainSag98.InformarTodos1Click(Sender: TObject);


var  aqlistado,aqSININFORMAR,aqSININFORMAR1:TSQLQuery;
fechaturno:STRING;  inspe:LONGINT;
begin
 fechaturno:=DATETOSTR(DATE);

LABEL8.Caption:='PROCESANDO...';
APPLICATION.ProcessMessages;



   //self.RxMemoryData1.Open;


aqSININFORMAR:=tsqlquery.create(nil);
aqSININFORMAR.SQLConnection := MyBD;
aqSININFORMAR.sql.add('SELECT  TURNOID, codinspe, anio, DVDOMINO FROM tdatosturno   '+
                     ' WHERE fechaturno < to_date('+#39+trim(fechaturno)+#39+',''dd/mm/yyyy'') and TRIM(ausente)=''N'' and TRIM(modo)=''P''  '+
                     ' and TRIM(reviso)=''S'' and  (TRIM(informadows)=''NO'' OR informadows IS NULL)  AND  (CODINSPE IS NOT NULL OR CODINSPE=0) ' );          //  and estadoid in (1,7)


aqSININFORMAR.ExecSQL;
aqSININFORMAR.open;
while not aqSININFORMAR.eof do
begin
inspe:=AqSININFORMAR.FIELDBYNAME('codinspe').ASINTEGER;

 aqSININFORMAR1:=tsqlquery.create(nil);
   aqSININFORMAR1.SQLConnection := MyBD;
   aqSININFORMAR1.sql.add('select inspfina from tinspeccion where codinspe='+inttostr(inspe));

   aqSININFORMAR1.ExecSQL;
   aqSININFORMAR1.open;
    IF TRIM(aqSININFORMAR1.FIELDBYNAME('inspfina').ASSTRING)='S' THEN
     BEGIN


      LABEL8.Caption:='INFORMANDO...'+TRIM(aqSININFORMAR.FIELDBYNAME('DVDOMINO').ASSTRING);
         APPLICATION.ProcessMessages;
         frmturnos.INFORMA_INSPECCION_AL_WEBSERVICES_automatico(aqSININFORMAR.FIELDBYNAME('TURNOID').ASINTEGER,AqSININFORMAR.FIELDBYNAME('codinspe').ASINTEGER,AqSININFORMAR.FIELDBYNAME('anio').ASINTEGER);

       application.ProcessMessages;

   END;

    aqSININFORMAR1.CLOSE;
    aqSININFORMAR1.FREE;

    aqSININFORMAR.next;
end;

 { self.RxMemoryData1.First;
  while not self.RxMemoryData1.Eof do
  begin
       if (trim(self.RxMemoryData1INFOME.Value)='NO') and (trim(self.RxMemoryData1reviso.VALUE)='SI') and (trim(self.RxMemoryData1estadid.Value)<>'6') THEN
       BEGIN
         LABEL8.Caption:='INFORMANDO...'+TRIM(SELF.RxMemoryData1patente.Value);
         APPLICATION.ProcessMessages;
         frmturnos.INFORMA_INSPECCION_AL_WEBSERVICES_automatico(self.RxMemoryData1turnoid.Value,self.RxMemoryData1codinspe.Value,self.RxMemoryData1anio.Value);
       sleep(1000);
       application.ProcessMessages;
      END;
       LABEL8.Caption:='PROCESANDO...';
       APPLICATION.ProcessMessages;

      self.RxMemoryData1.Next;
  end; }

   LABEL8.Caption:='PROCESANDO...';
       APPLICATION.ProcessMessages;

  aqSININFORMAR.Close;
 aqSININFORMAR.Free;





 LABEL8.Caption:='';
application.ProcessMessages;
  Application.MessageBox( 'Proceso terminado.', 'Atención',
  MB_ICONINFORMATION );

end;

procedure TFMainSag98.InformarAusentes1Click(Sender: TObject);
 var fecha,fecharchivo:string;
begin
fecha:=datetostr(date-1);
fecharchivo:=copy(trim(fecha),7,4)+copy(trim(fecha),4,2)+copy(trim(fecha),1,2);



application.ProcessMessages;
frmturnos.Inicializa;


LABEL8.Caption:='INFORMANDO AUSENTES....';
APPLICATION.ProcessMessages;
Timer1.Enabled:=false;
 procesosauscentes.Enabled:=false;

frmturnos.ControlServidor;
if (frmturnos.disponibilidad_servidor='true') AND (frmturnos.respuestaidservidor=1) THEN
begin

  //ver_respuestamensajeservidor);
  APPLICATION.ProcessMessages;
  frmturnos.Abrir_Seccion;
    if frmturnos.respuestaid_Abrir=1 then
     begin


         if frmturnos.informar_ausentes=true then
                begin
                 if fileexists(ExtractFilePath(Application.ExeName) +'informarausentes.xml') then
                      begin
                       if frmturnos.generar_archivo('informarausentes')=true then
                         begin
                            frmturnos.leer_respuesta_ausentes('informarausentes.txt');
                           // EnviarMensaje_control('valeria.zamorano@applus.com',TIMETOSTR(TIME),'INFORME DE AUSENTES: '+NOMBRE_PLANTA,'RESPUESTA INFORME AUSENTES',ExtractFilePath(Application.ExeName) +'informarausentes.xml');
                            //frmturnos.EnviarMensaje_control('martin.bien@applus.com',TIMETOSTR(TIME),'INFORME DE AUSENTES: '+frmturnos.NOMBRE_PLANTA,'RESPUESTA INFORME AUSENTES',ExtractFilePath(Application.ExeName) +'informarausentes'+trim(fecharchivo)+'.xml');
                           // EnviarMensaje_control('martinbien77@gmail.com',TIMETOSTR(TIME),'INFORME DE AUSENTES: '+NOMBRE_PLANTA,'RESPUESTA INFORME AUSENTES',ExtractFilePath(Application.ExeName) +'informarausentes.xml');

                         end;

                     end;



       frmturnos.Cerrar_seccion;

        end else
         begin
          //error al abrir
         end;

end
else
begin
//error de servidor
//ver_respuestamensajeservidor);
end;




 //frmturnos.cargar_turnos(datetostr(date));



 LABEL8.Caption:='';
APPLICATION.ProcessMessages;
Application.MessageBox( 'Proceso Terminado.', 'Atención',
  MB_ICONINFORMATION );
end;



end;

procedure TFMainSag98.InformarAusenteporPatente1Click(Sender: TObject);
var idturno:longint; patente,fecha:string;
begin
with TPIDE_TURNO_AUSENTE.Create(Nil) do
   try
   edit1.Clear;
    showmodal;

    if sale=true then
      exit;

      idturno:=strtoint(Edit1.Text);
  

     finally
      free;
      end;




//idturno:=strtoint(PIDEIDTURNO.Edit1.Text);

application.ProcessMessages;
frmturnos.Inicializa;


LABEL8.Caption:='INFORMANDO AUSENTES....';
APPLICATION.ProcessMessages;
Timer1.Enabled:=false;
 procesosauscentes.Enabled:=false;

frmturnos.ControlServidor;
if (frmturnos.disponibilidad_servidor='true') AND (frmturnos.respuestaidservidor=1) THEN
begin

  //ver_respuestamensajeservidor);
  APPLICATION.ProcessMessages;
  frmturnos.Abrir_Seccion;
    if frmturnos.respuestaid_Abrir=1 then
     begin


         if frmturnos.informar_ausentes_por_id(idturno)=true then
                begin
                 if fileexists(ExtractFilePath(Application.ExeName) +'informarausentes.xml') then
                      begin
                       if frmturnos.generar_archivo('informarausentes')=true then
                         begin
                            frmturnos.leer_respuesta_ausentes_POR_IDTUNRO('informarausentes.txt',idturno);
                           // EnviarMensaje_control('valeria.zamorano@applus.com',TIMETOSTR(TIME),'INFORME DE AUSENTES: '+NOMBRE_PLANTA,'RESPUESTA INFORME AUSENTES',ExtractFilePath(Application.ExeName) +'informarausentes.xml');
                            frmturnos.EnviarMensaje_control('martin.bien@applus.com',TIMETOSTR(TIME),'INFORME DE AUSENTES: '+frmturnos.NOMBRE_PLANTA,'RESPUESTA INFORME AUSENTES',ExtractFilePath(Application.ExeName) +'informarausentes.xml');
                           // EnviarMensaje_control('martinbien77@gmail.com',TIMETOSTR(TIME),'INFORME DE AUSENTES: '+NOMBRE_PLANTA,'RESPUESTA INFORME AUSENTES',ExtractFilePath(Application.ExeName) +'informarausentes.xml');

                         end;

                     end;



       frmturnos.Cerrar_seccion;

        end else
         begin
          //error al abrir
         end;

end
else
begin
//error de servidor
//ver_respuestamensajeservidor);
end;



end;



 procesosauscentes.Enabled:=true;
 LABEL8.Caption:='';
APPLICATION.ProcessMessages;
Timer1.Enabled:=true;

end;

procedure TFMainSag98.CambiodeDominiodelTurno1Click(Sender: TObject);
begin
cambiodominioturno.EDIT1.TEXT:=TRIM(INTTOSTR(SELF.RxMemoryData1turnoid.Value));
cambiodominioturno.EDIT2.TEXT:=TRIM(SELF.RxMemoryData1patente.Value);

cambiodominioturno.showmodal;
end;
procedure TFMainSag98.BorrarArchivos;
var
  SR: TSearchRec;
   FileInfo: TShFileOpStruct;

begin
  if FindFirst(ExtractFilePath(Application.ExeName)  + '*.xml', $23, SR)= 0 then
   repeat
     DeleteFile(ExtractFilePath(Application.ExeName)+SR.Name);
   until FindNext(SR) <> 0;


    if FindFirst(ExtractFilePath(Application.ExeName)  + '*.txt', $23, SR)= 0 then
   repeat
     DeleteFile(ExtractFilePath(Application.ExeName)+SR.Name);
   until FindNext(SR) <> 0;




  FileInfo.Wnd := Handle;
  FileInfo.wFunc := FO_DELETE;
  FileInfo.pFrom := pchar(ExtractFilePath(Application.ExeName)  + '*.xml');
  FileInfo.pTo := nil;
  FileInfo.fFlags := FOF_NOCONFIRMATION;

  ShFileOperation(FileInfo);


    FileInfo.Wnd := Handle;
  FileInfo.wFunc := FO_DELETE;
  FileInfo.pFrom := pchar(ExtractFilePath(Application.ExeName)  + '*.txt');
  FileInfo.pTo := nil;
  FileInfo.fFlags := FOF_NOCONFIRMATION;

  ShFileOperation(FileInfo);
end;
procedure TFMainSag98.BitBtn2Click(Sender: TObject);

var turnoid,codvehic,codinspe, ejercici:longint;

aqSININFORMAR:tsqlquery;
aqSININFORMAR1:tsqlquery;  PATENTE,TIPOINSPE:sTRING;

begin

end;

procedure TFMainSag98.InformarInspeccinporTurnoid1Click(Sender: TObject);
begin
INFORMAR_INSPE_POR_ID.SHOWMODAL;
end;


function TFMainSag98.INFORMAR_TODOS_LOS_TIPO_5:BOOLEAN;
VAR aqSININFORMAR5,aqSININFORMAR1:tsqlquery;
CODINSPE,idturno,ANIO:LONGINT;
BEGIN
 aqSININFORMAR5:=tsqlquery.Create(NIL);
 aqSININFORMAR5.SQLConnection:=MYBD;
 aqSININFORMAR5.Close;
 aqSININFORMAR5.SQL.Clear;
 aqSININFORMAR5.SQL.Add('SELECT TURNOID, CODINSPE, ANIO FROM TDATOSTURNO WHERE ESTADOID=5');
 aqSININFORMAR5.ExecSQL;
 aqSININFORMAR5.Open;
 WHILE NOT aqSININFORMAR5.Eof DO
 BEGIN
 idturno:=aqSININFORMAR5.FieldByName('TURNOID').ASINTEGER;
 
       IF TRIM(aqSININFORMAR5.FieldByName('CODINSPE').AsString)<>'' THEN
          BEGIN
             CODINSPE:=aqSININFORMAR5.FieldByName('CODINSPE').ASINTEGER;

             ANIO:=aqSININFORMAR5.FieldByName('ANIO').ASINTEGER;

             aqSININFORMAR1:=tsqlquery.create(nil);
             aqSININFORMAR1.SQLConnection := MyBD;
             aqSININFORMAR1.sql.add('select inspfina from tinspeccion where codinspe='+inttostr(CODINSPE));
             aqSININFORMAR1.ExecSQL;
             aqSININFORMAR1.open;
              IF TRIM(aqSININFORMAR1.FIELDBYNAME('inspfina').ASSTRING)='S' THEN
                  frmturnos.INFORMA_INSPECCION_AL_WEBSERVICES_automatico(idturno,CODINSPE,anio)
                  ELSE
                  frmturnos.informar_ausentes_por_id_tipo_5(idturno);


             aqSININFORMAR1.Close;
             aqSININFORMAR1.Free;


          END ELSE
          frmturnos.informar_ausentes_por_id_tipo_5(idturno);




     aqSININFORMAR5.Next;
 END;

  aqSININFORMAR5.Close;
  aqSININFORMAR5.Free;


END;

procedure TFMainSag98.Informarporlote1Click(Sender: TObject);
var  aqlistado,aqSININFORMAR,aqSININFORMAR1:TSQLQuery;
fechaturno,idturnos:STRING;  inspe,anio:LONGINT;
archi:textfile;
idturno,cont:longint;
begin
assignfile(archi,ExtractFilePath(Application.ExeName)+'turnos.txt' );
 fechaturno:=DATETOSTR(DATE);
timer1.Enabled:=false;
Timeractulizar.Enabled:=false;
LABEL8.Caption:='PROCESANDO...';
APPLICATION.ProcessMessages;
//frmturnos.cargar_turnos(datetostr(date));
// sleep(1000);

   //self.RxMemoryData1.Open;
 cont:=0;

reset(archi);

while not eof(archi) do
begin

readln(archi, idturnos);
if trim(idturnos)='********************' then
 begin
     break;
 end;
idturno:=strtoint(idturnos);

 AqSININFORMAR:=tsqlquery.create(nil);
   AqSININFORMAR.SQLConnection := MyBD;
   AqSININFORMAR.sql.add('select codinspe, anio from tdatosturno where turnoid='+inttostr(idturno));

   AqSININFORMAR.ExecSQL;
   AqSININFORMAR.open;

   anio:=AqSININFORMAR.FIELDBYNAME('anio').ASINTEGER;
inspe:=AqSININFORMAR.FIELDBYNAME('codinspe').ASINTEGER;
 AqSININFORMAR.Close;
 AqSININFORMAR.Free;

 aqSININFORMAR1:=tsqlquery.create(nil);
   aqSININFORMAR1.SQLConnection := MyBD;
   aqSININFORMAR1.sql.add('select inspfina from tinspeccion where codinspe='+inttostr(inspe));

   aqSININFORMAR1.ExecSQL;
   aqSININFORMAR1.open;
    IF TRIM(aqSININFORMAR1.FIELDBYNAME('inspfina').ASSTRING)='S' THEN
     BEGIN
     cont:=cont+1;
            LABEL8.Caption:='nro: '+inttostr(cont);
       APPLICATION.ProcessMessages;

     
         APPLICATION.ProcessMessages;
         frmturnos.INFORMA_INSPECCION_AL_WEBSERVICES_automatico(idturno,inspe,anio);
     
       application.ProcessMessages;

   END;




end;

 { self.RxMemoryData1.First;
  while not self.RxMemoryData1.Eof do
  begin
       if (trim(self.RxMemoryData1INFOME.Value)='NO') and (trim(self.RxMemoryData1reviso.VALUE)='SI') and (trim(self.RxMemoryData1estadid.Value)<>'6') THEN
       BEGIN
         LABEL8.Caption:='INFORMANDO...'+TRIM(SELF.RxMemoryData1patente.Value);
         APPLICATION.ProcessMessages;
         frmturnos.INFORMA_INSPECCION_AL_WEBSERVICES_automatico(self.RxMemoryData1turnoid.Value,self.RxMemoryData1codinspe.Value,self.RxMemoryData1anio.Value);
       sleep(1000);
       application.ProcessMessages;
      END;
       LABEL8.Caption:='PROCESANDO...';
       APPLICATION.ProcessMessages;

      self.RxMemoryData1.Next;
  end; }

   LABEL8.Caption:='PROCESANDO...';




   Application.MessageBox( 'ok', 'Atención',  MB_ICONINFORMATION );
timer1.Enabled:=true;
Timeractulizar.Enabled:=true;

application.ProcessMessages;


end;

procedure TFMainSag98.InformarporFecha1Click(Sender: TObject);
begin
  informar_por_fcha.showmodal;
end;

procedure TFMainSag98.InformarTipo51Click(Sender: TObject);
begin
label8.Caption:='INFORMANDO TIPO 5..';
APPLICATION.ProcessMessages;
SLEEP(500);
INFORMAR_TODOS_LOS_TIPO_5;

label8.Caption:='PROCESO TERMINADO INFORMANDO TIPO 5..';
APPLICATION.ProcessMessages;
SLEEP(500);
label8.Caption:='PROCESANDO...';
end;

end.

