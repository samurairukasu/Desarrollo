unit UFPrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms,
  StdCtrls, DBTables, GLOBALS, SpeedBar, ExtCtrls, Controls, Menus, RxMenus,
  ActnList, ToolWin, ActnMan, ActnCtrls, ActnMenus, XPStyleActnCtrls,
  ImgList, BandActn, StdStyleActnCtrls, StdActns, ExtActns,DecisionCubeBugWorkaround,
  WinSkinData, Buttons, Graphics, ComCtrls,uGetDates;

type
  Tfrmprincipal = class(TForm)
    ActionManager1: TActionManager;
    Action1: TAction;
    Action5: TAction;
    Action6: TAction;
    actSalir: TAction;
    ActionList1: TActionList;
    actEncuestas: TAction;
    actTiempos: TAction;
    actCalificacion: TAction;
    actPlanta: TAction;
    actZona: TAction;
    actDescuentos: TAction;
    ImageList1: TImageList;
    EditCut1: TEditCut;
    RichEditBold1: TRichEditBold;
    HelpContents1: THelpContents;
    WindowClose1: TWindowClose;
    bactEncuestas: TAction;
    bactTiempos: TAction;
    bactCalificacion: TAction;
    bactPlanta: TAction;
    bactZona: TAction;
    bactDescuentos: TAction;
    bactSalir: TAction;
    actFideliza: TAction;
    actPrimeras: TAction;
    actSatisfaccion: TAction;
    actCdGnc: TAction;
    bactCdGnc: TAction;
    actProvincia: TAction;
    actCDVTV: TAction;
    actTotalesGNC: TAction;
    actRechGNC: TAction;
    actDefectos: TAction;
    ActRutaFiles: TAction;
    acdefec: TAction;
    Acdefecxplanta: TAction;
    Actdefecpartic: TAction;
    Actdefparticxzona: TAction;
    actente: TAction;
    acturnos: TAction;
    Acsms: TAction;
    ac0kmcumplidores: TAction;
    ASMS: TAction;
    Action2: TAction;
    CSMSCUMPLIDORES: TAction;
    csmscumpli: TAction;
    SkinData1: TSkinData;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Image1: TImage;
    aCMailInternoCumplidores: TAction;
    aCMailExternoCumplidores: TAction;
    Action3: TAction;
    SpeedButton8: TSpeedButton;
    MainMenu1: TMainMenu;
    Estadsticas1: TMenuItem;
    Fidelizacin1: TMenuItem;
    N1Inspeccin1: TMenuItem;
    Listados1: TMenuItem;
    urnosCaptacinFuga1: TMenuItem;
    N0KMCumplidores1: TMenuItem;
    SMS1: TMenuItem;
    CelularesPrimeras1: TMenuItem;
    SMSCumplidores1: TMenuItem;
    Configuracin1: TMenuItem;
    CambiarPlanta1: TMenuItem;
    CambiarZona1: TMenuItem;
    Chile1: TMenuItem;
    MailExterno1: TMenuItem;
    MailInterno1: TMenuItem;
    Salir1: TMenuItem;
    ejecutarmenu: TAction;
    HabilitarConexinaChile1: TMenuItem;
    N1: TMenuItem;
    StatusBar1: TStatusBar;
    OKM1: TMenuItem;
    AnlisisdeCoeficiente1: TMenuItem;
    EmailingEnviados1: TMenuItem;
    Nuevo1: TMenuItem;
    IPO1COMPLIDORES1: TMenuItem;
    IPO4Cumplidores1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure btnsalirClick(Sender: TObject);
    procedure btnencuestasClick(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure CSMSCUMPLIDORESExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aCMailExternoCumplidoresExecute(Sender: TObject);
    procedure aCMailInternoCumplidoresExecute(Sender: TObject);
    procedure aCestablecerconexionchileExecute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure N1Inspeccin1Click(Sender: TObject);
    procedure Fidelizacin1Click(Sender: TObject);
    procedure urnosCaptacinFuga1Click(Sender: TObject);
    procedure N0KMCumplidores1Click(Sender: TObject);
    procedure SMS1Click(Sender: TObject);
    procedure CelularesPrimeras1Click(Sender: TObject);
    procedure SMSCumplidores1Click(Sender: TObject);
    procedure CambiarPlanta1Click(Sender: TObject);
    procedure CambiarZona1Click(Sender: TObject);
    procedure MailExterno1Click(Sender: TObject);
    procedure MailInterno1Click(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure HabilitarConexinaChile1Click(Sender: TObject);
    procedure OKM1Click(Sender: TObject);
    procedure AnlisisdeCoeficiente1Click(Sender: TObject);
    procedure EmailingEnviados1Click(Sender: TObject);
    procedure Nuevo1Click(Sender: TObject);
    procedure IPO1COMPLIDORES1Click(Sender: TObject);
    procedure IPO4Cumplidores1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmprincipal: Tfrmprincipal;

 DateIni, DateFin : string;
implementation

USES
  utiloracle, UCDIALGS, UVersion, UFInicioAplicacion,
  UFEstadisticasEncSatis,
  ufSeleccionaPlanta,
  ufEstadisticasResultados,
  ufEstadisticasTiempos,
  UFSeleccionaZona,
  //uFListadoDescuentos,
  UFListadoFidelizacion,
  UFListadoPrimInspecc,
  UFEstadPorcentajeSatis,UFEstadTIPO3Cumplidores,
 // ufCdGNC,
   ufCdVTV,
 // ufProvSeguros, ufTotalesInspGNC, ufestadisticasRechGNC,
  ufEstadisticasDefectos,
  UfConfigurarRuta,UFEstadisticadefectosGlobal,
  UFEstdefectoPartxplanta,UFEstdefectoPartxGlobal,UExportaciones, Unitfrmmailingenviado,
  UFEstadTurnoCaptacion,UFEstadOKMCumplidores, UEstablecerconexion,
  UFEstadCelularesxPrimeras,UFEstadSMS,UFEstadSMSCumplidor,UFEstadMAILCumplidor,UFEstMAILINTCumplidor,
  Unitespera,unit_frmmailng_sms_cumplidores;
{$R *.dfm}

procedure InitError(Msg: String);
begin
        MessageDlg('Error en la Inicialización',Msg,mtError,[mbOK],mbOK,0);
        InitializationError := TRUE;
        Application.Terminate;
end;

procedure Tfrmprincipal.FormShow(Sender: TObject);
var
Ahora : tDateTime;
begin
if (FindWindow(Pchar('TFInicioAplicacion'), PChar(NOMBRE_PROYECTO)) <> 0) or
   (FindWindow(Pchar('Tfrmprincipal'), PChar('Informes Estadísticos para ISO 9001')) <> 0) then
      InitError('Ya existe una copia del programa en ejecución');

if InitializationError then
  exit;

Caption := 'Informes Estadísticos para ISO 9001';

  with TFInicioAplicacion.Create(Application) do
    try
      Status.Caption := Format('%S (Comprobando su sistema)', [LITERAL_VERSION]);
      Show;

      Application.ProcessMessages;
      TestOfBugs;
      Application.ProcessMessages;
      if InitializationError then
        exit;

      Application.ProcessMessages;
      TestOfTerminal;
      if InitializationError then
        exit;

      Status.Caption := Format('%S (Conectándose al servidor)', [LITERAL_VERSION]);
      Application.ProcessMessages;
      If ParamCount=0 then
        TestOfBD('','','',true)
      else
        begin
          If ParamCount=1 Then
            begin
              TestOfBD(ParamStr(1),'','',true);
            end
          else
            begin
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

      Application.ProcessMessages;
      Status.Caption := Format('%S (Iniciando la Base de Datos)', [LITERAL_VERSION]);
      Application.ProcessMessages;
      InitAplicationGlobalTables;
      if InitializationError then
        exit;


      Ahora := Now;
      while Now <= (Ahora + EncodeTime(0,0,3,0)) do
        Application.ProcessMessages;
    finally
      free;
    end;
Application.ProcessMessages;
end;


procedure Tfrmprincipal.btnsalirClick(Sender: TObject);
begin
  FinishAplicationGlobalTables;
  application.Terminate;
end;


procedure Tfrmprincipal.btnencuestasClick(Sender: TObject);
var aServicio : Integer;
begin
  aServicio := (Sender as TComponent).Tag;
  case aServicio of
    1:Begin
        generateEstadisticaEncuestas
    end;
    2:Begin
        doSeleccionarPlanta;
    end;
    3:Begin
        generateEstadisticaResultados
    end;
    4:Begin
        generateEstadisticaTiempos
    end;
    5:Begin
       doSeleccionarZona;
    end;
    //6:begin
  //     GenerateListadoDescuento('');
 //   end;
    7:begin
       GenerateListadoFidelizacion;
    end;
    8:begin
       GenerateListadoPrimInspecc('');
    end;
    9:begin
       GeneratePorcentajeSatis('');
    end;
   // 10:begin
    //  generateCDGNC;
   // end;
   // 11:begin
   //   generateProvSeguros
   // end;
    12:begin
      generateCDVTV;
    end;
   // 13:begin
    //  GeneratePlanillaTotalesGNC;
   // end;
 ///  14:begin
    //  GenerateListRechGNC;
   // end;
    15:begin
      GenerateEstadDefectos;
    end;
    16:begin
         DoConfigurarRutaArchivos;
       end;
    17:begin
         GenerateLisDefectos(1);
       end;
    18:begin
         GenerateLisDefectos(2);
       end;
    19:begin
         GenerateDefecPartic;
       end;
    20:begin
     GenerateDefecParticGlobal;
       end;
    21:Begin
      GenerateLisTurnoCaptacion;
    end;
    22:Begin
      GenerateLisCelulvsPrim;
    end;
    23:Begin
      GenerateLisOKM;
    end;
    24:Begin
      GenerateSMS;
    end;
    25:Begin
      GenerateSMSCumplidor;
    end;
    30:Begin
      DoExportacionEnte_New;
      end;

        31:Begin
      DoExportacionEnte_New;
      end;

  end;
end;

procedure Tfrmprincipal.Action8Execute(Sender: TObject);
begin
  FinishAplicationGlobalTables;
  application.Terminate;
end;







procedure Tfrmprincipal.CSMSCUMPLIDORESExecute(Sender: TObject);
begin


      GenerateSMSCumplidor;
end;

procedure Tfrmprincipal.FormActivate(Sender: TObject);
begin
speedbutton1.Caption:='';
speedbutton2.Caption:='';

speedbutton4.Caption:='';
speedbutton5.Caption:='';
speedbutton6.Caption:='';
speedbutton7.Caption:='';
speedbutton9.Caption:='';
 if CONEXION_ESTABLECIDA_CHILE=true then
  FRMPRINCIPAL.StatusBar1.Panels[0].Text:='Conexión a Chile: On-Line'
    else
      FRMPRINCIPAL.StatusBar1.Panels[0].Text:='Conexión a Chile: Off-Line' ;


end;

procedure Tfrmprincipal.aCMailExternoCumplidoresExecute(Sender: TObject);
begin
GenerateMAILEXTERNO;
end;

procedure Tfrmprincipal.aCMailInternoCumplidoresExecute(Sender: TObject);
begin
GenerateMAILINTERNO;
end;

procedure Tfrmprincipal.aCestablecerconexionchileExecute(Sender: TObject);
begin
Generateconexion;
end;

procedure Tfrmprincipal.Action3Execute(Sender: TObject);
begin
  Generateconexion;
end;

procedure Tfrmprincipal.SpeedButton8Click(Sender: TObject);
begin
Generateconexion;
end;

procedure Tfrmprincipal.N1Inspeccin1Click(Sender: TObject);
begin
  GenerateListadoPrimInspecc('');
end;

procedure Tfrmprincipal.Fidelizacin1Click(Sender: TObject);
begin
GenerateListadoFidelizacion;
end;

procedure Tfrmprincipal.urnosCaptacinFuga1Click(Sender: TObject);
begin
 GenerateLisTurnoCaptacion;
end;

procedure Tfrmprincipal.N0KMCumplidores1Click(Sender: TObject);
begin
  GenerateLisOKM;
end;

procedure Tfrmprincipal.SMS1Click(Sender: TObject);
begin
   GenerateSMS;
end;

procedure Tfrmprincipal.CelularesPrimeras1Click(Sender: TObject);
begin
GenerateLisCelulvsPrim;
end;

procedure Tfrmprincipal.SMSCumplidores1Click(Sender: TObject);
begin
     GenerateSMSCumplidor;
end;

procedure Tfrmprincipal.CambiarPlanta1Click(Sender: TObject);
begin
    doSeleccionarZona;
end;

procedure Tfrmprincipal.CambiarZona1Click(Sender: TObject);
begin
  doSeleccionarPlanta;
end;

procedure Tfrmprincipal.MailExterno1Click(Sender: TObject);
begin
GenerateMAILEXTERNO;
end;

procedure Tfrmprincipal.MailInterno1Click(Sender: TObject);
begin
GenerateMAILINTERNO;
end;

procedure Tfrmprincipal.Salir1Click(Sender: TObject);
begin
if CONEXION_ESTABLECIDA_CHILE=true then
   DesconectarBDCHILE;
   
application.Terminate;
end;

procedure Tfrmprincipal.HabilitarConexinaChile1Click(Sender: TObject);
begin
Generateconexion;
end;

procedure Tfrmprincipal.OKM1Click(Sender: TObject);
begin
GenerateLisTipo3;
end;

procedure Tfrmprincipal.AnlisisdeCoeficiente1Click(Sender: TObject);
var fechaini, fechafin,sql,sql2:string;
    aniomenos2:longint;
begin
  If not GetDates(DateIni,DateFin) then Exit;



    fechaini:=copy(trim(dateini),7,4)+copy(trim(dateini),4,2)+copy(trim(dateini),1,2);
    fechafin:=copy(trim(DateFin),7,4)+copy(trim(DateFin),4,2)+copy(trim(DateFin),1,2);


     aniomenos2:=strtoint(trim(copy(trim(DateFin),7,4)))-2;
     espera.Label1.Caption:=inttostr(aniomenos2);
    espera.show;
    application.ProcessMessages;



sql:=  'select codigo_zona,TO_CHAR(FECha_verificacion,YYYY),COUNT(*),  '+
  ' from inspecciones where reverificacion=V  '+
  ' and codigo_zona In(2,6,7) '+
  ' and  ANIO_FABRICACION ='+INTTOSTR(aniomenos2)+
  ' AND FECha_verificacion between TO_DATE('+#39+trim(DateIni)+#39+',''DD/MM/YYYY'')and TO_DATE('+#39+trim(DateFin)+#39+',''DD/MM/YYYY'') '+
  ' GROUP BY  codigo_zona,TO_CHAR(FECha_verificacion,YYYY)';





  with TfRepOKMCump.Create(application) do
   try

     sdsConsulta.SQLConnection:= bdempex;
     with CDSConsulta do
     begin
       commandtext :=sql  ;
         Begin
          open;
          if RecordCount > 0 then
          Begin


           // espera.close;
           // qrlFecha.Caption := 'Desde: '+copy(DateIni,1,10)+' - Hasta: '+copy(DateFin,1,10);
           // repexceptionTiposDocu.preview;
          end
          else
          begin
           espera.close;
           //ShowMessage('No existen resultados para esta consulta!');
           end;
         end;
     end;
   finally
     free;
   end;





 sql2:='SELECT  p.codigo_zona , SUBSTR(v.fecha_alta_n, 1,4) ,count(*)  '+
           ' FROM VEHICULOS_TOTALES_01_2011 v, PARTIDOS p    '+
          ' WHERE v.codigo_partido_vehiculo = p.codigo_partido    '+
            ' AND p.codigo_zona  IN (2,6,7)  '+
          ' AND v.patente_actual NOT LIKE 0% '+
            ' AND TO_DATE (v.fecha_alta_n, YYYYMMDD) between TO_DATE('+#39+trim(fechaini)+#39+',YYYYMMDD) AND TO_DATE ('+#39+trim(fechafin)+#39+',	YYYYMMDD)'+
            ' and modelo='+inttostr(aniomenos2);



    
end;

procedure Tfrmprincipal.EmailingEnviados1Click(Sender: TObject);
begin
GenerateMAILINGENVIADO;
end;

procedure Tfrmprincipal.Nuevo1Click(Sender: TObject);
begin
GenerateLismailing_Sms_cumpli;
end;

procedure Tfrmprincipal.IPO1COMPLIDORES1Click(Sender: TObject);
begin
GenerateLisTipo1;
end;

procedure Tfrmprincipal.IPO4Cumplidores1Click(Sender: TObject);
begin
GenerateLisTipo4;
end;

end.
