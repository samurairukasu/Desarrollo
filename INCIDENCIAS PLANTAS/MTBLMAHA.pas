unit mtblmaha;
{ Unidad que se encarga del mantenimiento de tablas para MAHA }

interface

{
  Ultima Traza: 39
  Ultima Incidencia:
  Ultima Anomalia: 19
}


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Buttons, ExtCtrls, ComCtrls, Spin, UGESTIONCAMPOS,
  FMTBcd, SqlExpr, DB;

type
  { Sentido de las Motocicletas, V.Ligeros, V.Pesados y Remolques }
  tSentido = record
      sdpe: string;
      sdoe: string;
      sefe: string;
      sefs: string;
      sdfs1e: string;
      sdfsoe: string;
  end;

  { Sentido de los Datos Comunes }
  tSentidoDComunes = record
      sdmae: string;
      sema: string;
      semam: string;
      scoa92: string;
      sco9294: string;
      scop94: string;
      shca92: string;
      shc9294: string;
      shcp94: string;
      seha95: string;
      sehp95: string;
  end;

  tSentido_Vehiculos = record
      Motocicletas: tSentido;
      VLigeros: tSentido;
      VPesados: tSentido;
      Remolques: tSentido;
      DatosComunes: tSentidoDComunes;
  end;

  tDatos_TodosLosVehiculos = record
    slevedpe: string;
    sObsdpe: string;
    sOkDpe: string;
    slevedoe: string;
    sobsdoe: string;
    sokdoe: string;
    sleveefs: string;
    sobsefs: string;
    sokefs: string;
    sleveefe: string;
    sobsefe: string;
    sOkEFE: string;
    slevedfsoe: string;
    sobsdfsoe: string;
    sokdfsoe: string;
    slevedfs1e: string;
    sobsdfs1e: string;
    sOkDFS1E: string;
  end;

  tDatos_DatosComunes = record
    slevedmae: string;
    sObsdmae: string;
    sOkdmae: string;
    sleveema: string;
    sobsema: string;
    sokema: string;
    sleveemam: string;
    sobsemam: string;
    sokemam: string;
    sleveco1: string;
    sobsco1: string;
    sokco1: string;
    sleveco2: string;
    sobsco2: string;
    sokco2: string;
    sleveco3: string;
    sobsco3: string;
    sokco3: string;
    slevehc1: string;
    sobshc1: string;
    sokhc1: string;
    slevehc2: string;
    sobshc2: string;
    sokhc2: string;
    slevehc3: string;
    sobshc3: string;
    sokhc3: string;
    sleveem1: string;
    sobsem1: string;
    sokem1: string;
    sleveem2: string;
    sobsem2: string;
    sokem2: string;
  end;

  TfrmValoresLimite = class(TForm)
    btnCancelar: TBitBtn;
    btnModificar: TBitBtn;
    PgCtrlValoresLimite: TPageControl;
    TSheetMotocicletas: TTabSheet;
    Bevel1: TBevel;
    Bevel4: TBevel;
    Bevel12: TBevel;
    Bevel9: TBevel;
    Bevel13: TBevel;
    Bevel14: TBevel;
    LblNombreCampo1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblDeslizamOtrosEjes: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    lblEficaciaFrenoEstac: TLabel;
    lblEficaciaFrenoServ: TLabel;
    lblDeseqFrenosOtrosEjes: TLabel;
    lblDeseqFrenosPrimerEje: TLabel;
    edtlevedpe: TEdit;
    edtObsdpe: TEdit;
    edtOkDpe: TEdit;
    edtlevedoe: TEdit;
    edtobsdoe: TEdit;
    edtokdoe: TEdit;
    edtleveefs: TEdit;
    edtobsefs: TEdit;
    edtokefs: TEdit;
    edtleveefe: TEdit;
    edtobsefe: TEdit;
    EdtOkEFE: TEdit;
    edtlevedfsoe: TEdit;
    edtobsdfsoe: TEdit;
    edtokdfsoe: TEdit;
    edtlevedfs1e: TEdit;
    edtobsdfs1e: TEdit;
    edtOkDFS1E: TEdit;
    TSheetVehiculosLigeros: TTabSheet;
    Bevel10: TBevel;
    Bevel11: TBevel;
    Bevel15: TBevel;
    Bevel16: TBevel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    LblDeslPrimerEje: TLabel;
    lblEficFrenoEstac: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    lblDeseqFrenosServ1Eje: TLabel;
    Label55: TLabel;
    Bevel17: TBevel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    lblDeseqFrenosServoEje: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Bevel18: TBevel;
    Label62: TLabel;
    lblEficFrenoServ: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    lblDeslizOtrosEjes: TLabel;
    edtlevedpevl: TEdit;
    edtobsdpevl: TEdit;
    edtokdpevl: TEdit;
    edtleveefevl: TEdit;
    edtobsefevl: TEdit;
    edtokefevl: TEdit;
    edtokdfs1evl: TEdit;
    edtobsdfs1evl: TEdit;
    edtlevedfs1evl: TEdit;
    edtokdfsoevl: TEdit;
    edtobsdfsoevl: TEdit;
    edtlevedfsoevl: TEdit;
    edtleveefsvl: TEdit;
    edtobsefsvl: TEdit;
    edtokefsvl: TEdit;
    edtlevedoevl: TEdit;
    edtobsdoevl: TEdit;
    edtokdoevl: TEdit;
    TSheetVehiculosPesados: TTabSheet;
    Bevel31: TBevel;
    Bevel32: TBevel;
    Bevel33: TBevel;
    Bevel34: TBevel;
    Bevel35: TBevel;
    Bevel36: TBevel;
    lblDesl1Eje: TLabel;
    Label160: TLabel;
    Label161: TLabel;
    Label162: TLabel;
    lblEficFrenEstac: TLabel;
    Label164: TLabel;
    Label165: TLabel;
    Label166: TLabel;
    lblDeslizOtrEjes: TLabel;
    Label168: TLabel;
    Label169: TLabel;
    Label170: TLabel;
    lblEficFrenServ: TLabel;
    Label172: TLabel;
    Label173: TLabel;
    Label174: TLabel;
    lblDeseqFrenosSer1Eje: TLabel;
    Label176: TLabel;
    Label177: TLabel;
    Label178: TLabel;
    Label179: TLabel;
    lblDeseqFrenosSeroEje: TLabel;
    Label181: TLabel;
    Label182: TLabel;
    edtobsdpevp: TEdit;
    edtlevedpevp: TEdit;
    edtokdpevp: TEdit;
    edtokefevp: TEdit;
    edtobsefevp: TEdit;
    edtleveefevp: TEdit;
    edtokdoevp: TEdit;
    edtobsdoevp: TEdit;
    edtlevedoevp: TEdit;
    edtleveefsvp: TEdit;
    edtobsefsvp: TEdit;
    edtokefsvp: TEdit;
    edtokdfs1evp: TEdit;
    edtobsdfs1evp: TEdit;
    edtlevedfs1evp: TEdit;
    edtokdfsoevp: TEdit;
    edtobsdfsoevp: TEdit;
    edtlevedfsoevp: TEdit;
    TSheetRemolques: TTabSheet;
    Bevel37: TBevel;
    Bevel38: TBevel;
    Bevel39: TBevel;
    Bevel40: TBevel;
    Bevel41: TBevel;
    Bevel42: TBevel;
    lblDesliz1Eje: TLabel;
    Label184: TLabel;
    Label185: TLabel;
    Label186: TLabel;
    lblEficFrEstac: TLabel;
    Label188: TLabel;
    Label189: TLabel;
    Label190: TLabel;
    lblDeslizoEjes: TLabel;
    Label192: TLabel;
    Label193: TLabel;
    Label194: TLabel;
    lblEficFrServ: TLabel;
    Label196: TLabel;
    Label197: TLabel;
    Label198: TLabel;
    lblDeseqFrSer1Eje: TLabel;
    Label200: TLabel;
    Label201: TLabel;
    Label202: TLabel;
    Label203: TLabel;
    lblDeseqFrSeroEje: TLabel;
    Label205: TLabel;
    Label206: TLabel;
    edtobsdper: TEdit;
    edtlevedper: TEdit;
    edtokdper: TEdit;
    edtokefer: TEdit;
    edtobsefer: TEdit;
    edtleveefer: TEdit;
    edtokdoer: TEdit;
    edtobsdoer: TEdit;
    edtlevedoer: TEdit;
    edtleveefsr: TEdit;
    edtobsefsr: TEdit;
    edtokefsr: TEdit;
    edtokdfs1er: TEdit;
    edtobsdfs1er: TEdit;
    edtlevedfs1er: TEdit;
    edtokdfsoer: TEdit;
    edtobsdfsoer: TEdit;
    edtlevedfsoer: TEdit;
    TSheetComunes: TTabSheet;
    Bevel6: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel5: TBevel;
    Bevel8: TBevel;
    Bevel7: TBevel;
    lblDeslizam1Eje: TLabel;
    Label127: TLabel;
    Label128: TLabel;
    Label129: TLabel;
    lblEficMinAmort: TLabel;
    Label131: TLabel;
    Label132: TLabel;
    Label133: TLabel;
    lblEficMaxAmort: TLabel;
    Label135: TLabel;
    Label136: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    Label140: TLabel;
    lblCOMaximo: TLabel;
    lblAntes1992: TLabel;
    lbl19921994: TLabel;
    lblPos1994: TLabel;
    lblHCMaximos: TLabel;
    Label147: TLabel;
    Label148: TLabel;
    Label149: TLabel;
    lblhcPos1994: TLabel;
    lblhc19921994: TLabel;
    lblAnterior1992: TLabel;
    lblEmisionHumos: TLabel;
    Label154: TLabel;
    lblAntes1995: TLabel;
    lblPos1995: TLabel;
    Label157: TLabel;
    Label158: TLabel;
    TabSheet6: TTabSheet;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Bevel25: TBevel;
    Label97: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    Label104: TLabel;
    Label105: TLabel;
    Bevel26: TBevel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    Bevel27: TBevel;
    Label114: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    Bevel28: TBevel;
    Label120: TLabel;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Bevel29: TBevel;
    Bevel30: TBevel;
    Edit88: TEdit;
    Edit89: TEdit;
    Edit90: TEdit;
    Edit91: TEdit;
    Edit92: TEdit;
    Edit93: TEdit;
    Edit94: TEdit;
    Edit95: TEdit;
    Edit96: TEdit;
    Edit97: TEdit;
    Edit98: TEdit;
    Edit99: TEdit;
    Edit100: TEdit;
    Edit101: TEdit;
    Edit102: TEdit;
    Edit103: TEdit;
    Edit104: TEdit;
    Edit105: TEdit;
    Edit106: TEdit;
    Edit107: TEdit;
    Edit108: TEdit;
    Edit109: TEdit;
    Edit110: TEdit;
    Edit111: TEdit;
    Edit112: TEdit;
    Edit113: TEdit;
    Edit114: TEdit;
    Edit115: TEdit;
    Edit116: TEdit;
    Edit117: TEdit;
    Edit118: TEdit;
    Edit119: TEdit;
    Edit120: TEdit;
    edtokdmae: TEdit;
    edtobsdmae: TEdit;
    edtlevedmae: TEdit;
    edtleveema: TEdit;
    edtobsema: TEdit;
    edtokema: TEdit;
    edtokemam: TEdit;
    edtobsemam: TEdit;
    edtleveemam: TEdit;
    edtleveco1: TEdit;
    edtobsco1: TEdit;
    edtokco1: TEdit;
    edtokco2: TEdit;
    edtobsco2: TEdit;
    edtleveco2: TEdit;
    edtokhc1: TEdit;
    edtokhc2: TEdit;
    edtobshc2: TEdit;
    edtobshc1: TEdit;
    edtlevehc1: TEdit;
    edtlevehc2: TEdit;
    edtokhc3: TEdit;
    edtobshc3: TEdit;
    edtlevehc3: TEdit;
    edtokem1: TEdit;
    edtokem2: TEdit;
    edtobsem2: TEdit;
    edtobsem1: TEdit;
    edtleveem1: TEdit;
    edtleveem2: TEdit;
    edtokco3: TEdit;
    edtobsco3: TEdit;
    edtleveco3: TEdit;
    btnImprimir: TBitBtn;
    btnVisualizar: TBitBtn;
    qryConsultas: TSQLQuery;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure PgCtrlValoresLimiteChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtokefsKeyPress(Sender: TObject; var Key: Char);
    procedure edtokdmaeEnter(Sender: TObject);
    procedure edtokdmaeExit(Sender: TObject);
  private
    { Private declarations }
    function ValoresMotocicletas_Validos: boolean;
    function ValoresVehiculosLigeros_Validos: boolean;
    function ValoresRemolques_Validos: boolean;
    function ValoresVehiculosPesados_Validos: boolean;
    function ValoresDatosComunes_Validos: boolean;
    function ActualizarCampo_TCAMPOS (iCampo: integer; iDepend: integer; VUmbral: string; VLiteral: string; sSentido:string): boolean;
    function ValorLimite_Correcto (sCadena: string): boolean;
    function CamposIntroducidos_Correctos (sValorOk, sValorObs, sValorLeve: string; var sCampoSentido: string): boolean;
    procedure Inicializar_Sentidos;

    function ActualizarDatos_DatosComunes (DDC: tDatos_DatosComunes; SD: tSentidoDComunes): boolean;
    function ActualizarDatos_Remolques (DR: tDatos_TodosLosVehiculos; SD: tSentido): boolean;
    function ActualizarDatos_VehiculosPesados (DVP: tDatos_TodosLosVehiculos; SD: tSentido): boolean;
    function ActualizarDatos_VehiculosLigeros (DVL: tDatos_TodosLosVehiculos; SD: tSentido): boolean;
    function ActualizarDatos_Motocicletas (DM: tDatos_TodosLosVehiculos; SD: tSentido): boolean;

    function RellenarValores_Motocicletas (var Datos_Mot_TCAMPOS: tDatos_TodosLosVehiculos; const ValoresDeCampos: TCampos): boolean;
    function RellenarValores_Remolques (var Datos_Rem_TCAMPOS: tDatos_TodosLosVehiculos; const ValoresDeCampos: TCampos): boolean;
    function RellenarValores_VehiculosLigeros (var Datos_VL_TCAMPOS: tDatos_TodosLosVehiculos; const ValoresDeCampos: TCampos): boolean;
    function RellenarValores_VehiculosPesados (var Datos_VP_TCAMPOS: tDatos_TodosLosVehiculos; const ValoresDeCampos: TCampos): boolean;
    function RellenarValores_DatosComunes (var Datos_Com_TCAMPOS: tDatos_DatosComunes; const ValoresDeCampos: TCampos): boolean;

    function LeerValoresLimite_Motocicletas (var DV: tDatos_TodosLosVehiculos): boolean;
    function LeerValoresLimite_VehiculosLigeros (var DV: tDatos_TodosLosVehiculos): boolean;
    function LeerValoresLimite_VehiculosPesados (var DV: tDatos_TodosLosVehiculos): boolean;
    function LeerValoresLimite_Remolques (var DV: tDatos_TodosLosVehiculos): boolean;
    function LeerValoresLimite_DatosComunes (var DDC: tDatos_DatosComunes): boolean;


  public
    { Public declarations }
    function ActualizarValoresLimite_TDATINSPECC (DM, DVL, DVP, DR: tDatos_TodosLosVehiculos; DDC: tDatos_DatosComunes; SD: tSentido_Vehiculos): boolean;

    function ActualizarValores_Motocicletas_TCAMPOS (DV: tDatos_TodosLosVehiculos; SDM: tSentido): boolean;
    function ActualizarValores_VehiculosLigeros_TCAMPOS (DV: tDatos_TodosLosVehiculos; SDVL: tSentido): boolean;
    function ActualizarValores_VehiculosPesados_TCAMPOS (DV: tDatos_TodosLosVehiculos; SDVP: tSentido): boolean;
    function ActualizarValores_Remolques_TCAMPOS (DV: tDatos_TodosLosVehiculos; SDR: tSentido): boolean;
    function ActualizarValores_DatosComunes_TCAMPOS (DDC: tDatos_DatosComunes; SDC: tSentidoDComunes): boolean;
    function SonIguales_TodosVehiculos (R1, R2: tDatos_TodosLosVehiculos): boolean;
    function SonIguales_DatosComunes (R1, R2: tDatos_DatosComunes): boolean;

    function LeerValoresLimite_Form (var Datos_Mot_TCAMPOS, Datos_VehiLigeros_TCAMPOS,
                                 Datos_VehiPesados_TCAMPOS, Datos_Rem_TCAMPOS: tDatos_TodosLosVehiculos;
                                 var Datos_DCom_TCAMPOS: tDatos_DatosComunes): boolean;
                                 
    procedure RellenarValores_form (Datos_Mot_TCAMPOS, Datos_VehiLigeros_TCAMPOS,
                                 Datos_VehiPesados_TCAMPOS, Datos_Rem_TCAMPOS: tDatos_TodosLosVehiculos;
                                 Datos_DCom_TCAMPOS: tDatos_DatosComunes; VDeCampos: TCampos);
  end;


var
  frmValoresLimite: TfrmValoresLimite;


procedure Mantenimiento_ValoresLimite (aForm: TForm);


implementation

{$R *.DFM}

uses
    UCDIALGS,
    ULOGS,
    IMPRVLIM,
    GLOBALS,
    UFTMP,
    UINTERFAZUSUARIO,
    UUTILS,
    UGAcceso,USagCtte;


const
    DEPEND_MOTOCICLETA = 1;
    DEPEND_VL = 2;
    DEPEND_VP = 3;
    DEPEND_REMOLQUE = 4;
    DEPEND_CAMPO6 = 6;
    DEPEND_ANT92 = 7;
    DEPEND_9294 = 8;
    DEPEND_POS94 = 9;
    DEPEND_ANT95 = 10;
    DEPEND_POS95= 11;


    EFE_OK_DPE = 10;
    EFE_OBS_DPE = 11;
    EFE_LEVE_DPE = 12;

    EFE_OK_DOE = 13;
    EFE_OBS_DOE = 14;
    EFE_LEVE_DOE = 15;

    EFE_OK_EFE = 16;
    EFE_OBS_EFE = 17;
    EFE_LEVE_EFE = 18;

    EFE_OK_EFS = 19;
    EFE_OBS_EFS = 20;
    EFE_LEVE_EFS = 21;

    EFE_OK_DFS1E = 22;
    EFE_OBS_DFS1E = 23;
    EFE_LEVE_DFS1E = 24;

    EFE_OK_DFSOE = 25;
    EFE_OBS_DFSOE = 26;
    EFE_LEVE_DFSOE = 27;

    EFE_OK_DMAE = 28;
    EFE_OBS_DMAE = 29;
    EFE_LEVE_DMAE = 30;

    EFE_OK_EMA = 31;
    EFE_OBS_EMA = 32;
    EFE_LEVE_EMA = 33;

    EFE_OK_EMAM = 34;
    EFE_OBS_EMAM = 35;
    EFE_LEVE_EMAM = 36;

    EFE_OK_CO = 37;
    EFE_OBS_CO = 38;
    EFE_LEVE_CO = 39;

    EFE_OK_HC = 40;
    EFE_OBS_HC = 41;
    EFE_LEVE_HC = 42;

    EFE_OK_EM = 43;
    EFE_OBS_EM = 44;
    EFE_LEVE_EM = 45;

{ constantes que se utilizan en MTblMaha }
  MAXIMO = 999999999;


resourcestring
    FICHERO_ACTUAL = 'MTblMaha';

    ARRIBA = 'U';
    ABAJO =  'D';


    OBSERV = 'O'; { Observaci�n }
    LEVE = 'L';   { Leve }
    PASA_OK = 'P';{ Pasa (OK) }
    CABECERA_MENSAJES_VALLIM = 'Modificaci�n Valores L�mite';

      { Mensajes enviados al usuario desde MTblMaha }
      MSJ_VALLIM_VALNOVALIDO = 'No ha introducido el valor correspondiente o �ste es incorrecto';
      MSJ_VALLIM_INC = 'Los valores introducidos en los campos Ok, Observaci�n y/o Defecto Leve no son correctos. Debe introducir dicho trio en orden ascendente o descendente. Si no desea introducir ning�n valor introduzca "999999999"';
      MSJ_SISTEMA_INESTABLE = 'Ha ocurrido un error grave en la base de datos. El sistema est� inestable, con lo que deber� reiniciarlo de nuevo';

      MSJ_UMAIN_ERRBD = 'Ha ocurrido un error grave con la base de datos al intentar obtener los valores l�mite.';
      MSJ_UMAIN_RESETEAR = 'Atenci�n, los valores l�mite se han modificado. Para que este cambio tenga efecto ' +
                           'deber� reinicializar los servidores';
      MSJ_UMAIN_ERRACTVALLIM = 'Ha ocurrido un error grave con la base de datos al intentar almacenar los nuevos valores l�mite.';


procedure Mantenimiento_ValoresLimite (aForm: TForm);
resourcestring
       CABECERA_VALLIM = 'Modificaci�n Valores L�mite';

var
   ValoresDeCampos : TCampos;

   frmValoresLimite_Auxi: TfrmValoresLimite;

   Datos_Motocicletas,
   Datos_VehiculosLigeros,
   Datos_VehiculosPesados,
   Datos_Remolques: tDatos_TodosLosVehiculos;
   Datos_DatosComunes: tDatos_DatosComunes;
   Sentido_Datos: tSentido_Vehiculos;
   { Tendremos var. auxi que almacenar�n valores de la tabla TCAMPOS para que,
     en caso de en caso de NO cambiar nada, no almacenar los cambios producidos }
   Datos_Motocicletas_TCAMPOS,
   Datos_VehiculosLigeros_TCAMPOS,
   Datos_VehiculosPesados_TCAMPOS,
   Datos_Remolques_TCAMPOS: tDatos_TodosLosVehiculos;
   Datos_DatosComunes_TCAMPOS: tDatos_DatosComunes;

   aFTmp: TFTmp;

begin
    aForm.Enabled := False;
    try
       frmValoresLimite := nil;
       FTmp.Temporizar(True,True,'Mantenimiento Valores L�mite','Iniciando Mantenimiento Valores L�mite');

       ValoresDeCampos := TCampos.Create(MyBD);
       if (not Assigned(ValoresDeCampos)) or  (ValoresDeCampos.HuboError)
       then MessageDlg (CABECERA_VALLIM,MSJ_UMAIN_ERRBD,mtInformation,[mbOk],mbOk,0);

       frmValoresLimite_Auxi := TfrmValoresLimite.Create(Application);
       try
          with frmValoresLimite_Auxi do
          begin
              RellenarValores_form (Datos_Motocicletas_TCAMPOS, Datos_VehiculosLigeros_TCAMPOS,
                                    Datos_VehiculosPesados_TCAMPOS, Datos_Remolques,
                                    Datos_DatosComunes_TCAMPOS, ValoresDeCampos);

              if (ShowModal = mrOk) then
              begin
                  aFTmp := TFTmp.Create (Application);
                  frmValoresLimite_Auxi.Enabled := False;
                  try
                     aFTmp.MuestraClock ('Valores L�mite','Actualizando los valores l�mite de los veh�culos...');
                     if LeerValoresLimite_Form (Datos_Motocicletas, Datos_VehiculosLigeros,
                           Datos_VehiculosPesados, Datos_Remolques, Datos_DatosComunes) then
                     begin
                         if (not ((SonIguales_TodosVehiculos (Datos_Motocicletas_TCAMPOS, Datos_Motocicletas))
                              and (SonIguales_TodosVehiculos (Datos_VehiculosLigeros_TCAMPOS, Datos_VehiculosLigeros))
                              and (SonIguales_TodosVehiculos (Datos_VehiculosPesados_TCAMPOS, Datos_VehiculosPesados))
                              and (SonIguales_TodosVehiculos (Datos_Remolques_TCAMPOS, Datos_Remolques))
                              and (SonIguales_DatosComunes (Datos_DatosComunes_TCAMPOS, Datos_DatosComunes)))) then
                         begin
                             if (ActualizarValoresLimite_TDATINSPECC (Datos_Motocicletas, Datos_VehiculosLigeros,
                                 Datos_VehiculosPesados,Datos_Remolques,Datos_DatosComunes, Sentido_Datos)) then
                             begin
                                 aFTmp.Hide;
                                 MessageDlg (CABECERA_VALLIM, MSJ_UMAIN_RESETEAR,mtInformation, [mbOk], mbOk, 0);
                             end
                             else
                             begin
                                 aFTmp.Hide;
                                 MessageDlg (CABECERA_VALLIM,MSJ_UMAIN_ERRACTVALLIM, mtInformation, [mbOk], mbOk, 0);
                             end;
                         end;
                     end;
                  finally
                       frmValoresLimite_Auxi.Enabled := True;
                       frmValoresLimite_Auxi.Show;
                       aFTmp.Free;
                  end;
              end;
          end;
       finally
            frmValoresLimite_Auxi.Free;
            ValoresDeCampos.Free;
       end;
    finally
         aForm.Enabled := True;
         aForm.Show;
    end;
end;



var
  Sentido: tSentido_Vehiculos; { almacena el sentido de todos los veh�culos }



procedure TfrmValoresLimite.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end
end;


procedure TfrmValoresLimite.FormActivate(Sender: TObject);
{ Inicializa algunas propiedades del PageControl }
begin
    Inicializar_Sentidos;
    PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
    FTmp.Temporizar(False,True,'','');
    if PasswordUser = MASTER_KEY then
    begin
      btnModificar.enabled:=true;
    end;

end;


procedure TfrmValoresLimite.btnModificarClick(Sender: TObject);
begin
    if ValoresMotocicletas_Validos then
      if ValoresVehiculosLigeros_Validos then
        if ValoresVehiculosPesados_Validos then
          if ValoresRemolques_Validos then
             if ValoresDatosComunes_Validos then
             begin
                 {$IFDEF TRAZAS}
                    FTrazas.PonComponente (TRAZA_FORM, 3, FICHERO_ACTUAL, Self);
                 {$ENDIF}
                 ModalResult := mrOk
             end;
end;

// Devuelve True si el valor l�mite introducido es correcto
function TFrmValoresLimite.ValorLimite_Correcto (sCadena: string): boolean;
var
   iCadena: real;
   iCodErr: integer; { var. auxiliares }

begin
   Result := False;
   try
     Val (ConvierteComaEnPunto(sCadena), iCadena, iCodErr);
     Result := (iCodErr = 0);
   except
        on E:Exception do
        begin
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL, Format ('%s %s %s %d', ['Error en ValorLimite_Correcto:',E.Message,sCadena,iCodErr]));
        end;
   end;
end;


function TFrmValoresLimite.ValoresMotocicletas_Validos: boolean;
begin
    Result := False;
    { Deslizamiento Primer Eje }
    if (not ValorLimite_Correcto(edtOkdpe.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkdpe.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsdpe.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsdpe.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtLevedpe.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLevedpe.setfocus;
        exit;
    end
    else if (not CamposIntroducidos_Correctos (edtOkdpe.Text, edtObsdpe.Text, edtLevedpe.Text, Sentido.Motocicletas.sdpe)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkdpe.setfocus;
        exit;
    end;

    { Deslizamiento Otros Ejes }
    if (not ValorLimite_Correcto(edtOkdoe.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkdoe.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsdoe.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsdoe.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtLevedoe.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLevedoe.setfocus;
        exit;
    end
    else if (not CamposIntroducidos_Correctos (edtOkdoe.Text, edtObsdoe.Text, edtLevedoe.Text, Sentido.Motocicletas.sdoe)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkdoe.setfocus;
        exit;
    end;

    { Eficacia Freno Estacionamiento }
    if (not ValorLimite_Correcto(edtOkefe.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkEfe.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsefe.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsEfe.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtLeveefe.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLeveEfe.setfocus;
        exit;
    end
    else if (not CamposIntroducidos_Correctos (edtOkefe.Text, edtObsefe.Text, edtLeveefe.Text, Sentido.Motocicletas.sefe)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkefe.setfocus;
        exit;
    end;

    { Eficacia Freno Servicio }
    if (not ValorLimite_Correcto(edtOkefs.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkEfs.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsefs.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsEfs.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtLeveefs.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLeveEfs.setfocus;
        exit;
    end
    else if (not CamposIntroducidos_Correctos (edtOkefs.Text, edtObsefs.Text, edtLeveefs.Text, Sentido.Motocicletas.sefs)) then
    begin
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkefs.setfocus;
        exit;
    end;

    { Deslizamiento Frenos Servicio 1er. eje }
    if (not ValorLimite_Correcto(edtOkdfs1e.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkdfs1e.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsdfs1e.Text)) then
    begin
       PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
       MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
       edtObsdfs1e.setfocus;
       exit;
    end;

    if (not ValorLimite_Correcto(edtLevedfs1e.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLevedfs1e.setfocus;
        exit;
    end
    else if (not CamposIntroducidos_Correctos (edtOkdfs1e.Text, edtObsdfs1e.Text, edtLevedfs1e.Text, Sentido.Motocicletas.sdfs1e)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkdfs1e.setfocus;
        exit;
    end;

    { Deslizamiento Freno Servicio Otros Ejes }
    if (not ValorLimite_Correcto(edtOkdfsoe.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkdfsoe.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsdfsoe.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsdfsoe.setfocus;
        exit;
    end;

    if (not CamposIntroducidos_Correctos (edtOkdfsoe.Text, edtObsdfsoe.Text, edtLevedfsoe.Text, Sentido.Motocicletas.sdfsoe)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkdfsoe.setfocus;
        exit;
    end
    else if ValorLimite_Correcto(edtLevedfsoe.Text) then
    begin
        Result := True
    end
    else
    begin
        PgCtrlValoresLimite.ActivePage := TSheetMotocicletas;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLevedfsoe.setfocus;
        exit;
    end;
end;


function TFrmValoresLimite.ValoresVehiculosLigeros_Validos: boolean;
begin
    Result := False;
    { Deslizamiento 1er. eje }
    if (not ValorLimite_Correcto(edtOkdpevl.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkdpevl.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsdpevl.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsdpevl.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtLevedpevl.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLevedpevl.setfocus;
        exit;
    end
    else if (not CamposIntroducidos_Correctos (edtOkDpevl.Text, edtObsDpevl.Text, edtLeveDpevl.Text, Sentido.VLigeros.sdpe)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkDpevl.setfocus;
        exit;
    end;

    { Deslizamiento Otros Ejes }
    if (not ValorLimite_Correcto(edtOkdoevl.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkdoevl.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsdoevl.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsdoevl.setfocus;
        exit
    end;

    if (not ValorLimite_Correcto(edtLevedoevl.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLevedoevl.setfocus;
        exit;
    end
    else if (not CamposIntroducidos_Correctos (edtOkDoevl.Text, edtObsDoevl.Text, edtLeveDoevl.Text, Sentido.VLigeros.sdoe)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkDoevl.setfocus;
        exit;
    end;

    { Eficacia Freno Estacionamiento }
    if (not ValorLimite_Correcto(edtOkefevl.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkEfevl.setfocus;
        exit
    end;

    if (not ValorLimite_Correcto(edtObsefevl.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsEfevl.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtLeveefevl.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLeveEfevl.setfocus;
        exit;
    end
    else if (not CamposIntroducidos_Correctos (edtOkefevl.Text, edtObsefevl.Text, edtLeveefevl.Text, Sentido.VLigeros.sefe)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkefevl.setfocus;
        exit;
    end;

    { Eficacia Freno Servicio }
    if (not ValorLimite_Correcto(edtOkefsvl.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkEfsvl.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsefsvl.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsEfsvl.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtLeveefsvl.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLeveEfsvl.setfocus;
        exit;
    end
    else if (not CamposIntroducidos_Correctos (edtOkefsvl.Text, edtObsefsvl.Text, edtLeveefsvl.Text, Sentido.VLigeros.sefs)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkefsvl.setfocus;
        exit;
    end;

    { Desequilibrio Frenos Servicio 1er. Eje }
    if (not ValorLimite_Correcto(edtOkdfs1evl.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkdfs1evl.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsdfs1evl.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsdfs1evl.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtLevedfs1evl.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLevedfs1evl.setfocus;
        exit
    end
    else if (not CamposIntroducidos_Correctos (edtOkdfs1evl.Text, edtObsdfs1evl.Text, edtLevedfs1evl.Text, Sentido.VLigeros.sdfs1e)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkdfs1evl.setfocus;
        exit;
    end;

    { Deslizamiento Frenos Servicio Otros Ejes }
    if (not ValorLimite_Correcto(edtOkdfsoevl.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkdfsoevl.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsdfsoevl.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsdfsoevl.setfocus;
        exit
    end;

    if (not CamposIntroducidos_Correctos (edtOkdfsoevl.Text, edtObsdfsoevl.Text, edtLevedfsoevl.Text, Sentido.VLigeros.sdfsoe)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkdfsoevl.setfocus;
        exit;
    end
    else if ValorLimite_Correcto(edtLevedfsoevl.Text) then
    begin
        Result := True
    end
    else
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosLigeros;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLevedfsoevl.setfocus;
        exit;
    end;
end;


function TFrmValoresLimite.ValoresRemolques_Validos: boolean;
begin
    Result := False;
    { Deslizamiento 1er. Eje }
    if (not ValorLimite_Correcto(edtOkdper.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkdper.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsdper.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsdper.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtLevedper.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLevedper.setfocus;
        exit;
    end
    else if (not CamposIntroducidos_Correctos (edtOkdper.Text, edtObsdper.Text, edtLevedper.Text, Sentido.Remolques.sdpe)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkdper.setfocus;
        exit;
    end;

    { Deslizamiento Otros Ejes }
    if (not ValorLimite_Correcto(edtOkdoer.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkdoer.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsdoer.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsdoer.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtLevedoer.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLevedoer.setfocus;
        exit;
    end
    else if (not CamposIntroducidos_Correctos (edtOkdoer.Text, edtObsdoer.Text, edtLevedoer.Text, Sentido.Remolques.sdoe)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkdoer.setfocus;
        exit;
    end;

    { Eficacia Freno Estacionamiento }
    if (not ValorLimite_Correcto(edtOkefer.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkEfer.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsefer.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsEfer.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtLeveefer.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLeveEfer.setfocus;
        exit;
    end
    else if (not CamposIntroducidos_Correctos (edtOkefer.Text, edtObsefer.Text, edtLeveefer.Text, Sentido.Remolques.sefe)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkefer.setfocus;
        exit;
    end;

    { Eficacia Freno Servicio }
    if (not ValorLimite_Correcto(edtOkefsr.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkEfsr.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsefsr.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsEfsr.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtLeveefsr.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLeveEfsr.setfocus;
        exit;
    end
    else if (not CamposIntroducidos_Correctos (edtOkefsr.Text, edtObsefsr.Text, edtLeveefsr.Text, Sentido.Remolques.sefs)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkefsr.setfocus;
        exit;
    end;

    { Desequilibrio Frenos Servicio 1er. Eje }
    if (not ValorLimite_Correcto(edtOkdfs1er.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkdfs1er.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsdfs1er.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsdfs1er.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtLevedfs1er.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLevedfs1er.setfocus;
        exit
    end
    else if (not CamposIntroducidos_Correctos (edtOkdfs1er.Text, edtObsdfs1er.Text, edtLevedfs1er.Text, Sentido.Remolques.sdfs1e)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkdfs1er.setfocus;
        exit;
    end;

    { Desequilibrio Frenos Servicio Otros Ejes }
    if (not ValorLimite_Correcto(edtOkdfsoer.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkdfsoer.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsdfsoer.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsdfsoer.setfocus;
        exit;
    end;

    if (not CamposIntroducidos_Correctos (edtOkdfsoer.Text, edtObsdfsoer.Text, edtLevedfsoer.Text, Sentido.Remolques.sdfsoe)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkdfsoer.setfocus;
        exit;
    end
    else if ValorLimite_Correcto(edtLevedfsoer.Text) then
    begin
        Result := True
    end
    else
    begin
        PgCtrlValoresLimite.ActivePage := TSheetRemolques;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLevedfsoer.setfocus;
        exit;
    end;
end;


function TFrmValoresLimite.ValoresVehiculosPesados_Validos: boolean;
begin
    Result := False;
    { Deslizamiento 1er. eje }
    if (not ValorLimite_Correcto(edtOkdpevp.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkdpevp.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsdpevp.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsdpevp.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtLevedpevp.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLevedpevp.setfocus;
        exit;
    end
    else if (not CamposIntroducidos_Correctos (edtOkDpevp.Text, edtObsDpevp.Text, edtLeveDpevp.Text, Sentido.VPesados.sdpe)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkDpevp.setfocus;
        exit;
    end;

    { Deslizamiento Otros Ejes }
    if (not ValorLimite_Correcto(edtOkdoevp.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkdoevp.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsdoevp.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsdoevp.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtLevedoevp.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLevedoevp.setfocus;
        exit;
    end
    else if (not CamposIntroducidos_Correctos (edtOkDoevp.Text, edtObsDoevp.Text, edtLeveDoevp.Text, Sentido.VPesados.sdoe)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkDoevp.setfocus;
        exit;
    end;

    { Eficacia Freno Estacionamiento }
    if (not ValorLimite_Correcto(edtOkefevp.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkEfevp.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsefevp.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsEfevp.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtLeveefevp.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLeveEfevp.setfocus;
        exit;
    end
    else if (not CamposIntroducidos_Correctos (edtOkefevp.Text, edtObsefevp.Text, edtLeveefevp.Text, Sentido.VPesados.sefe)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkefevp.setfocus;
        exit;
    end;

    { Eficacia Freno Servicio }
    if (not ValorLimite_Correcto(edtOkefsvp.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkEfsvp.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsefsvp.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsEfsvp.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtLeveefsvp.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLeveEfsvp.setfocus;
        exit;
    end
    else if (not CamposIntroducidos_Correctos (edtOkefsvp.Text, edtObsefsvp.Text, edtLeveefsvp.Text, Sentido.VPesados.sefs)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkefsvp.setfocus;
        exit;
    end;

    { Desequilibrio Frenos Servicio 1er. Eje }
    if (not ValorLimite_Correcto(edtOkdfs1evp.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkdfs1evp.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsdfs1evp.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsdfs1evp.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtLevedfs1evp.Text)) then
    begin
         PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
         MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
         edtLevedfs1evp.setfocus;
         exit;
    end
    else if (not CamposIntroducidos_Correctos (edtOkdfs1evp.Text, edtObsdfs1evp.Text, edtLevedfs1evp.Text, Sentido.VPesados.sdfs1e)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkdfs1evp.setfocus;
        exit;
    end;

    { Desequilibrio Frenos Servicio Otros Ejes }
    if (not ValorLimite_Correcto(edtOkdfsoevp.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkdfsoevp.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObsdfsoevp.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsdfsoevp.setfocus;
        exit;
    end;

    if (not CamposIntroducidos_Correctos (edtOkdfsoevp.Text, edtObsdfsoevp.Text, edtLevedfsoevp.Text, Sentido.VPesados.sdfsoe)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkdfsoevp.setfocus;
        exit;
    end
    else if ValorLimite_Correcto(edtLevedfsoevp.Text) then
    begin
        Result := True
    end
    else
    begin
        PgCtrlValoresLimite.ActivePage := TSheetVehiculosPesados;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLevedfsoevp.setfocus;
    end;
end;


function TFrmValoresLimite.ValoresDatosComunes_Validos: boolean;
begin
    Result := False;
    { Desequilibrio M�ximo Amortiguadores Eje }
    if (not ValorLimite_Correcto(edtOkdmae.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkdmae.setfocus;
        exit
    end;

    if (not ValorLimite_Correcto(edtObsdmae.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsdmae.setfocus;
        exit
    end;

    if (not ValorLimite_Correcto(edtLevedmae.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLevedmae.setfocus;
        exit
    end
    else if (not CamposIntroducidos_Correctos (edtOkDmae.Text, edtObsDmae.Text, edtLeveDmae.Text, Sentido.DatosComunes.sdmae)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkDmae.setfocus;
        exit;
    end;

    { Eficacia M�nima Amortiguador }
    if (not ValorLimite_Correcto(edtOkema.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkema.setfocus;
        exit
    end;

    if (not ValorLimite_Correcto(edtObsema.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsema.setfocus;
        exit
    end;

    if (not ValorLimite_Correcto(edtLeveema.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLeveema.setfocus;
        exit
    end
    else if (not CamposIntroducidos_Correctos (edtOkema.Text, edtObsema.Text, edtLeveema.Text, Sentido.DatosComunes.sema)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkema.setfocus;
        exit;
    end;

    { Eficacia M�xima Amortiguador }
    if (not ValorLimite_Correcto(edtOkemam.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkemam.setfocus;
        exit
    end;

    if (not ValorLimite_Correcto(edtObsemam.Text)) then
    begin
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsemam.setfocus;
        exit
    end;

    if (not ValorLimite_Correcto(edtLeveemam.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLeveemam.setfocus;
        exit
    end
    else if (not CamposIntroducidos_Correctos (edtOkemam.Text, edtObsemam.Text, edtLeveemam.Text, Sentido.DatosComunes.semam)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkemam.setfocus;
        exit;
    end;

    { % CO M�ximo Anter. 1992 }
    if (not ValorLimite_Correcto(edtOkco1.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkco1.setfocus;
        exit
    end;

    if (not ValorLimite_Correcto(edtObsco1.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsco1.setfocus;
        exit
    end;

    if (not ValorLimite_Correcto(edtLeveco1.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLeveco1.setfocus;
        exit
    end
    else if (not CamposIntroducidos_Correctos (edtOkco1.Text, edtObsco1.Text, edtLeveco1.Text, Sentido.DatosComunes.scoa92)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkco1.setfocus;
        exit;
    end;

    { % CO M�ximo 1992-1994 }
    if (not ValorLimite_Correcto(edtOkco2.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkco2.setfocus;
        exit
    end;

    if (not ValorLimite_Correcto(edtObsco2.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsco2.setfocus;
        exit
    end;

    if (not ValorLimite_Correcto(edtLeveco2.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLeveco2.setfocus;
        exit
    end
    else if (not CamposIntroducidos_Correctos (edtOkco2.Text, edtObsco2.Text, edtLeveco2.Text, Sentido.DatosComunes.sco9294)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkco2.setfocus;
        exit;
    end;

    { % CO M�ximo Post.1994 }
    if (not ValorLimite_Correcto(edtOkco3.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkco3.setfocus;
        exit
    end;

    if (not ValorLimite_Correcto(edtObsco3.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsco3.setfocus;
        exit
    end;

    if (not ValorLimite_Correcto(edtLeveco3.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLeveco3.setfocus;
        exit
    end
    else if (not CamposIntroducidos_Correctos (edtOkco3.Text, edtObsco3.Text, edtLeveco3.Text, Sentido.DatosComunes.scop94)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkco3.setfocus;
        exit;
    end;

    { HC ppm M�ximos Admisibles Ant. 1992 }
    if (not ValorLimite_Correcto(edtOkhc1.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkhc1.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObshc1.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObshc1.setfocus;
        exit
    end;

    if (not ValorLimite_Correcto(edtLevehc1.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLevehc1.setfocus;
        exit
    end
    else if (not CamposIntroducidos_Correctos (edtOkhc1.Text, edtObshc1.Text, edtLevehc1.Text, Sentido.DatosComunes.shca92)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkhc1.setfocus;
        exit
    end;

    { HC ppm M�ximos Admisibles 1992-1994 }
    if (not ValorLimite_Correcto(edtOkhc2.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkhc2.setfocus;
        exit
    end;

    if (not ValorLimite_Correcto(edtObshc2.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObshc2.setfocus;
        exit
    end;

    if (not ValorLimite_Correcto(edtLevehc2.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLevehc2.setfocus;
        exit;
    end
    else if (not CamposIntroducidos_Correctos (edtOkhc2.Text, edtObshc2.Text, edtLevehc2.Text, Sentido.DatosComunes.shc9294)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkhc2.setfocus;
        exit;
    end;

    { HC ppm M�ximos Admisibles Post. 1994 }
    if (not ValorLimite_Correcto(edtOkhc3.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkhc3.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtObshc3.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObshc3.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtLevehc3.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLevehc3.setfocus;
        exit;
    end
    else if (not CamposIntroducidos_Correctos (edtOkhc3.Text, edtObshc3.Text, edtLevehc3.Text, Sentido.DatosComunes.shcp94)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkhc3.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtOkem1.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkem1.setfocus;
        exit
    end;

    { Emisi�n Humos Ant. 1995 }
    if (not ValorLimite_Correcto(edtObsem1.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsem1.setfocus;
        exit;
    end;

    if (not ValorLimite_Correcto(edtLeveem1.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLeveem1.setfocus;
        exit;
    end
    else if (not CamposIntroducidos_Correctos (edtOkem1.Text, edtObsem1.Text, edtLeveem1.Text, Sentido.DatosComunes.seha95)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkem1.setfocus;
        exit;
    end;

    { Emisi�n Humos Post. 1995 }
    if (not ValorLimite_Correcto(edtOkem2.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtOkem2.setfocus;
        exit
    end;

    if (not ValorLimite_Correcto(edtObsem2.Text)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtObsem2.setfocus;
        exit
    end;

    if (not CamposIntroducidos_Correctos (edtOkem2.Text, edtObsem2.Text, edtLeveem2.Text, Sentido.DatosComunes.sehp95)) then
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_INC, mtInformation, [mbOk], mbOk,0);
        edtOkem2.setfocus;
        exit;
    end
    else if ValorLimite_Correcto(edtLeveem2.Text) then
    begin
        Result := True
    end
    else
    begin
        PgCtrlValoresLimite.ActivePage := TSheetComunes;
        MessageDlg (CABECERA_MENSAJES_VALLIM, MSJ_VALLIM_VALNOVALIDO, mtInformation, [mbYes, mbNo], mbYes,0);
        edtLeveem2.setfocus;
    end;
end;


function TFrmValoresLimite.RellenarValores_Motocicletas (var Datos_Mot_TCAMPOS: tDatos_TodosLosVehiculos; const ValoresDeCampos: TCampos): boolean;
begin
   try
      with ValoresDeCampos do
      begin
        EdtOkDpe.Text := SimboloDeCampoPara (EFE_OK_DPE, DEPEND_MOTOCICLETA);
        EdtOBSDpe.Text := SimboloDeCampoPara (EFE_OBS_DPE, DEPEND_MOTOCICLETA);
        EdtLEVEDpe.Text := SimboloDeCampoPara (EFE_LEVE_DPE, DEPEND_MOTOCICLETA);

        EdtOkDoe.Text := SimboloDeCampoPara (EFE_OK_DOE, DEPEND_MOTOCICLETA);
        EdtOBSDoe.Text := SimboloDeCampoPara (EFE_OBS_DOE, DEPEND_MOTOCICLETA);
        EdtLEVEDoe.Text := SimboloDeCampoPara (EFE_LEVE_DOE, DEPEND_MOTOCICLETA);

        EdtOkEfe.Text := SimboloDeCampoPara (EFE_OK_EFE, DEPEND_MOTOCICLETA);
        EdtObsEfe.Text := SimboloDeCampoPara (EFE_OBS_EFE, DEPEND_MOTOCICLETA);
        EdtLeveEfe.Text := SimboloDeCampoPara (EFE_LEVE_EFE, DEPEND_MOTOCICLETA);

        EdtOkEfs.Text := SimboloDeCampoPara (EFE_OK_EFS, DEPEND_MOTOCICLETA);
        EdtObsEfs.Text := SimboloDeCampoPara (EFE_OBS_EFS, DEPEND_MOTOCICLETA);
        EdtLeveEfs.Text := SimboloDeCampoPara (EFE_LEVE_EFS, DEPEND_MOTOCICLETA);

        EdtOkDfs1e.Text := SimboloDeCampoPara (EFE_OK_DFS1E, DEPEND_MOTOCICLETA);
        EdtObsDfs1e.Text := SimboloDeCampoPara (EFE_OBS_DFS1E, DEPEND_MOTOCICLETA);
        EdtLeveDfs1e.Text := SimboloDeCampoPara (EFE_LEVE_DFS1E, DEPEND_MOTOCICLETA);

        EdtOkDfsoe.Text := SimboloDeCampoPara (EFE_OK_DFSOE, DEPEND_MOTOCICLETA);
        EdtObsDfsoe.Text := SimboloDeCampoPara (EFE_OBS_DFSOE, DEPEND_MOTOCICLETA);
        EdtLeveDfsoe.Text := SimboloDeCampoPara (EFE_LEVE_DFSOE, DEPEND_MOTOCICLETA);

        { Ahora rellenamos los valores de una var. auxi de MOTOCICLETAS }
        with Datos_Mot_TCAMPOS do
        begin
          slevedpe := EdtLEVEDpe.Text;
          sObsdpe := EdtOBSDpe.Text;
          sOkDpe := EdtOKDpe.Text;
          slevedoe := EdtLEVEDoe.Text;
          sobsdoe := EdtOBSDoe.Text;
          sokdoe := EdtOkDoe.Text;
          sleveefs := EdtLeveEfs.Text;
          sobsefs := EdtObsEfs.Text;
          sokefs := EdtOkEfs.Text;
          sleveefe := EdtLeveEfe.Text;
          sobsefe := EdtObsEfe.Text;
          sOkEFE := EdtOkEfe.Text;
          slevedfsoe := EdtLeveDfsoe.Text;
          sobsdfsoe := EdtObsDfsoe.Text;
          sokdfsoe := EdtOkDfsoe.Text;
          slevedfs1e := EdtLeveDfs1e.Text;
          sobsdfs1e := EdtObsDfs1e.Text;
          sOkDFS1E := EdtOkDfs1e.Text;
        end;
      end;
      Result := True;
   except
        on E:Exception do
        begin
            Result := False;
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'Error en RellenarValores_Motocicletas: ' + E.Message);
        end;
   end;
end;


function TFrmValoresLimite.RellenarValores_VehiculosLigeros (var Datos_VL_TCAMPOS: tDatos_TodosLosVehiculos; const ValoresDeCampos: TCampos): boolean;
begin
   try
      with ValoresDeCampos do
      begin
        EdtOkdpevl.Text := SimboloDeCampoPara (EFE_OK_DPE, DEPEND_VL);
        EdtObsdpevl.Text := SimboloDeCampoPara (EFE_OBS_DPE, DEPEND_VL);
        EdtLevedpevl.Text := SimboloDeCampoPara (EFE_LEVE_DPE, DEPEND_VL);

        EdtOkdoevl.Text := SimboloDeCampoPara (EFE_OK_DOE, DEPEND_VL);
        EdtObsdoevl.Text := SimboloDeCampoPara (EFE_OBS_DOE, DEPEND_VL);
        EdtLevedoevl.Text := SimboloDeCampoPara (EFE_LEVE_DOE, DEPEND_VL);

        EdtOkEfevl.Text := SimboloDeCampoPara (EFE_OK_EFE, DEPEND_VL);
        EdtObsEfevl.Text := SimboloDeCampoPara (EFE_OBS_EFE, DEPEND_VL);
        EdtLeveEfevl.Text := SimboloDeCampoPara (EFE_LEVE_EFE, DEPEND_VL);

        EdtOkEfsvl.Text := SimboloDeCampoPara (EFE_OK_EFS, DEPEND_VL);
        EdtObsEfsvl.Text := SimboloDeCampoPara (EFE_OBS_EFS, DEPEND_VL);
        EdtLeveEfsvl.Text := SimboloDeCampoPara (EFE_LEVE_EFS, DEPEND_VL);

        EdtOkDfs1evl.Text := SimboloDeCampoPara (EFE_OK_DFS1E, DEPEND_VL);
        EdtObsDfs1evl.Text := SimboloDeCampoPara (EFE_OBS_DFS1E, DEPEND_VL);
        EdtLeveDfs1evl.Text := SimboloDeCampoPara (EFE_LEVE_DFS1E, DEPEND_VL);

        EdtOkDfsoevl.Text := SimboloDeCampoPara (EFE_OK_DFSOE, DEPEND_VL);
        EdtObsDfsoevl.Text := SimboloDeCampoPara (EFE_OBS_DFSOE, DEPEND_VL);
        EdtLeveDfsoevl.Text := SimboloDeCampoPara (EFE_LEVE_DFSOE, DEPEND_VL);
      end;

      with Datos_VL_TCAMPOS do
      begin
          slevedpe := EdtLEVEDpevl.Text;
          sObsdpe := EdtOBSDpevl.Text;
          sOkDpe := EdtOKDpevl.Text;
          slevedoe := EdtLEVEDoevl.Text;
          sobsdoe := EdtOBSDoevl.Text;
          sokdoe := EdtOkDoevl.Text;
          sleveefs := EdtLeveEfsvl.Text;
          sobsefs := EdtObsEfsvl.Text;
          sokefs := EdtOkEfsvl.Text;
          sleveefe := EdtLeveEfevl.Text;
          sobsefe := EdtObsEfevl.Text;
          sOkEFE := EdtOkEfevl.Text;
          slevedfsoe := EdtLeveDfsoevl.Text;
          sobsdfsoe := EdtObsDfsoevl.Text;
          sokdfsoe := EdtOkDfsoevl.Text;
          slevedfs1e := EdtLeveDfs1evl.Text;
          sobsdfs1e := EdtObsDfs1evl.Text;
          sOkDFS1E := EdtOkDfs1evl.Text;
      end;

      Result := True;
   except
        on E:Exception do
        begin
            Result := False;
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'RellenarValores_VehiculosLigeros: ' + E.Message);
        end;
   end;
end;


function TFrmValoresLimite.RellenarValores_VehiculosPesados (var Datos_VP_TCAMPOS: tDatos_TodosLosVehiculos; const ValoresDeCampos: TCampos): boolean;
begin
   try
      with ValoresDeCampos do
      begin
        EdtOkdpevp.Text := SimboloDeCampoPara (EFE_OK_DPE, DEPEND_VP);
        EdtObsdpevp.Text := SimboloDeCampoPara (EFE_OBS_DPE, DEPEND_VP);
        EdtLevedpevp.Text := SimboloDeCampoPara (EFE_LEVE_DPE, DEPEND_Vp);

        EdtOkdoevp.Text := SimboloDeCampoPara (EFE_OK_DOE, DEPEND_VP);
        EdtObsdoevp.Text := SimboloDeCampoPara (EFE_OBS_DOE, DEPEND_VP);
        EdtLevedoevp.Text := SimboloDeCampoPara (EFE_LEVE_DOE, DEPEND_VP);

        EdtOkEfevp.Text := SimboloDeCampoPara (EFE_OK_EFE, DEPEND_VP);
        EdtObsEfevp.Text := SimboloDeCampoPara (EFE_OBS_EFE, DEPEND_VP);
        EdtLeveEfevp.Text := SimboloDeCampoPara (EFE_LEVE_EFE, DEPEND_VP);

        EdtOkEfsvp.Text := SimboloDeCampoPara (EFE_OK_EFS, DEPEND_VP);
        EdtObsEfsvp.Text := SimboloDeCampoPara (EFE_OBS_EFS, DEPEND_VP);
        EdtLeveEfsvp.Text := SimboloDeCampoPara (EFE_LEVE_EFS, DEPEND_VP);

        EdtOkDfs1evp.Text := SimboloDeCampoPara (EFE_OK_DFS1E, DEPEND_VP);
        EdtObsDfs1evp.Text := SimboloDeCampoPara (EFE_OBS_DFS1E, DEPEND_VP);
        EdtLeveDfs1evp.Text := SimboloDeCampoPara (EFE_LEVE_DFS1E, DEPEND_VP);

        EdtOkDfsoevp.Text := SimboloDeCampoPara (EFE_OK_DFSOE, DEPEND_VP);
        EdtObsDfsoevp.Text := SimboloDeCampoPara (EFE_OBS_DFSOE, DEPEND_VP);
        EdtLeveDfsoevp.Text := SimboloDeCampoPara (EFE_LEVE_DFSOE, DEPEND_VP);
      end;

      with Datos_VP_TCAMPOS do
      begin
          slevedpe := EdtLEVEDpevp.Text;
          sObsdpe := EdtOBSDpevp.Text;
          sOkDpe := EdtOKDpevp.Text;
          slevedoe := EdtLEVEDoevp.Text;
          sobsdoe := EdtOBSDoevp.Text;
          sokdoe := EdtOkDoevp.Text;
          sleveefs := EdtLeveEfsvp.Text;
          sobsefs := EdtObsEfsvp.Text;
          sokefs := EdtOkEfsvp.Text;
          sleveefe := EdtLeveEfevp.Text;
          sobsefe := EdtObsEfevp.Text;
          sOkEFE := EdtOkEfevp.Text;
          slevedfsoe := EdtLeveDfsoevp.Text;
          sobsdfsoe := EdtObsDfsoevp.Text;
          sokdfsoe := EdtOkDfsoevp.Text;
          slevedfs1e := EdtLeveDfs1evp.Text;
          sobsdfs1e := EdtObsDfs1evp.Text;
          sOkDFS1E := EdtOkDfs1evp.Text;
      end;
      Result := True;
   except
        on E:Exception do
        begin
            Result := False;
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'RellenarValores_VehiculosPesados: ' + E.Message);
        end;
   end;
end;


function TFrmValoresLimite.RellenarValores_Remolques (var Datos_Rem_TCAMPOS: tDatos_TodosLosVehiculos; const ValoresDeCampos: TCampos): boolean;
begin
    try
       with ValoresDeCampos do
       begin
            EdtOkDper.Text := SimboloDeCampoPara (EFE_OK_DPE, DEPEND_REMOLQUE);
            EdtOBSDper.Text := SimboloDeCampoPara (EFE_OBS_DPE, DEPEND_REMOLQUE);
            EdtLEVEDper.Text := SimboloDeCampoPara (EFE_LEVE_DPE, DEPEND_REMOLQUE);

            EdtOkDoer.Text := SimboloDeCampoPara (EFE_OK_DOE, DEPEND_REMOLQUE);
            EdtOBSDoer.Text := SimboloDeCampoPara (EFE_OBS_DOE, DEPEND_REMOLQUE);
            EdtLEVEDoer.Text := SimboloDeCampoPara (EFE_LEVE_DOE, DEPEND_REMOLQUE);

            EdtOkEfer.Text := SimboloDeCampoPara (EFE_OK_EFE, DEPEND_REMOLQUE);
            EdtObsEfer.Text := SimboloDeCampoPara (EFE_OBS_EFE, DEPEND_REMOLQUE);
            EdtLeveEfer.Text := SimboloDeCampoPara (EFE_LEVE_EFE, DEPEND_REMOLQUE);

            EdtOkEfsr.Text := SimboloDeCampoPara (EFE_OK_EFS, DEPEND_REMOLQUE);
            EdtObsEfsr.Text := SimboloDeCampoPara (EFE_OBS_EFS, DEPEND_REMOLQUE);
            EdtLeveEfsr.Text := SimboloDeCampoPara (EFE_LEVE_EFS, DEPEND_REMOLQUE);

            EdtOkDfs1er.Text := SimboloDeCampoPara (EFE_OK_DFS1E, DEPEND_REMOLQUE);
            EdtObsDfs1er.Text := SimboloDeCampoPara (EFE_OBS_DFS1E, DEPEND_REMOLQUE);
            EdtLeveDfs1er.Text := SimboloDeCampoPara (EFE_LEVE_DFS1E, DEPEND_REMOLQUE);

            EdtOkDfsoer.Text := SimboloDeCampoPara (EFE_OK_DFSOE, DEPEND_REMOLQUE);
            EdtObsDfsoer.Text := SimboloDeCampoPara (EFE_OBS_DFSOE, DEPEND_REMOLQUE);
            EdtLeveDfsoer.Text := SimboloDeCampoPara (EFE_LEVE_DFSOE, DEPEND_REMOLQUE);
          end;

          with Datos_Rem_TCAMPOS do
          begin
              slevedpe := EdtLEVEDper.Text;
              sObsdpe := EdtOBSDper.Text;
              sOkDpe := EdtOKDper.Text;
              slevedoe := EdtLEVEDoer.Text;
              sobsdoe := EdtOBSDoer.Text;
              sokdoe := EdtOkDoer.Text;
              sleveefs := EdtLeveEfsr.Text;
              sobsefs := EdtObsEfsr.Text;
              sokefs := EdtOkEfsr.Text;
              sleveefe := EdtLeveEfer.Text;
              sobsefe := EdtObsEfer.Text;
              sOkEFE := EdtOkEfer.Text;
              slevedfsoe := EdtLeveDfsoer.Text;
              sobsdfsoe := EdtObsDfsoer.Text;
              sokdfsoe := EdtOkDfsoer.Text;
              slevedfs1e := EdtLeveDfs1er.Text;
              sobsdfs1e := EdtObsDfs1er.Text;
              sOkDFS1E := EdtOkDfs1er.Text;
       end;
       Result := True;
   except
        on E:Exception do
        begin
            Result := False;
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,5,FICHERO_ACTUAL,'RellenarValores_Remolques: ' + E.Message);
        end;
   end;
end;


function TFrmValoresLimite.RellenarValores_DatosComunes (var Datos_Com_TCAMPOS: tDatos_DatosComunes; const ValoresDeCampos: TCampos): boolean;
begin
   try
      with ValoresDeCampos do
      begin
        EdtOkDmae.Text := SimboloDeCampoPara (EFE_OK_DMAE, DEPEND_CAMPO6);
        EdtObsDmae.Text := SimboloDeCampoPara (EFE_OBS_DMAE, DEPEND_CAMPO6);
        EdtLeveDmae.Text := SimboloDeCampoPara (EFE_LEVE_DMAE, DEPEND_CAMPO6);

        EdtOkEma.Text := SimboloDeCampoPara (EFE_OK_EMA, DEPEND_CAMPO6);
        EdtObsEma.Text := SimboloDeCampoPara (EFE_OBS_EMA, DEPEND_CAMPO6);
        EdtLeveEma.Text := SimboloDeCampoPara (EFE_LEVE_EMA, DEPEND_CAMPO6);

        EdtOkEmam.Text := SimboloDeCampoPara (EFE_OK_EMAM, DEPEND_CAMPO6);
        EdtObsEmam.Text := SimboloDeCampoPara (EFE_OBS_EMAM, DEPEND_CAMPO6);
        EdtLeveEmam.Text := SimboloDeCampoPara (EFE_LEVE_EMAM, DEPEND_CAMPO6);

        EdtOkco1.Text := SimboloDeCampoPara (EFE_OK_CO, DEPEND_ANT92);
        EdtObsco1.Text := SimboloDeCampoPara (EFE_OBS_CO, DEPEND_ANT92);
        EdtLeveco1.Text := SimboloDeCampoPara (EFE_LEVE_CO, DEPEND_ANT92);

        EdtOkco2.Text := SimboloDeCampoPara (EFE_OK_CO, DEPEND_9294);
        EdtObsco2.Text := SimboloDeCampoPara (EFE_OBS_CO, DEPEND_9294);
        EdtLeveco2.Text := SimboloDeCampoPara (EFE_LEVE_CO, DEPEND_9294);

        EdtOkco3.Text := SimboloDeCampoPara (EFE_OK_CO, DEPEND_POS94);
        EdtObsco3.Text := SimboloDeCampoPara (EFE_OBS_CO, DEPEND_POS94);
        EdtLeveco3.Text := SimboloDeCampoPara (EFE_LEVE_CO, DEPEND_POS94);

        EdtOkhc1.Text := SimboloDeCampoPara (EFE_OK_HC, DEPEND_ANT92);
        EdtObshc1.Text := SimboloDeCampoPara (EFE_OBS_HC, DEPEND_ANT92);
        EdtLevehc1.Text := SimboloDeCampoPara (EFE_LEVE_HC, DEPEND_ANT92);

        EdtOkhc2.Text := SimboloDeCampoPara (EFE_OK_HC, DEPEND_9294);
        EdtObshc2.Text := SimboloDeCampoPara (EFE_OBS_HC, DEPEND_9294);
        EdtLevehc2.Text := SimboloDeCampoPara (EFE_LEVE_HC, DEPEND_9294);

        EdtOkhc3.Text := SimboloDeCampoPara (EFE_OK_HC, DEPEND_POS94);
        EdtObshc3.Text := SimboloDeCampoPara (EFE_OBS_HC, DEPEND_POS94);
        EdtLevehc3.Text := SimboloDeCampoPara (EFE_LEVE_HC, DEPEND_POS94);

        EdtOkem1.Text := SimboloDeCampoPara (EFE_OK_EM, DEPEND_ANT95);
        EdtObsem1.Text := SimboloDeCampoPara (EFE_OBS_EM, DEPEND_ANT95);
        EdtLeveem1.Text := SimboloDeCampoPara (EFE_LEVE_EM, DEPEND_ANT95);

        EdtOkem2.Text := SimboloDeCampoPara (EFE_OK_EM, DEPEND_POS95);
        EdtObsem2.Text := SimboloDeCampoPara (EFE_OBS_EM, DEPEND_POS95);
        EdtLeveem2.Text := SimboloDeCampoPara (EFE_LEVE_EM, DEPEND_POS95);
      end;

      with Datos_Com_TCAMPOS do
      begin
          slevedmae := EdtLeveDmae.Text;
          sObsdmae := EdtObsDmae.Text;
          sOkdmae := EdtOkDmae.Text;
          sleveema := EdtLeveEma.Text;
          sobsema := EdtObsEma.Text;
          sokema := EdtOkEma.Text;
          sleveemam := EdtLeveEmam.Text;
          sobsemam := EdtObsEmam.Text;
          sokemam := EdtOkEmam.Text;
          sleveco1 := EdtLeveco1.Text;
          sobsco1 := EdtObsco1.Text;
          sokco1 := EdtOkco1.Text;
          sleveco2 := EdtLeveco2.Text;
          sobsco2 := EdtObsco2.Text;
          sokco2 := EdtOkco2.Text;
          sleveco3 := EdtLeveco3.Text;
          sobsco3 := EdtObsco3.Text;
          sokco3 := EdtOkco3.Text;
          slevehc1 := EdtLevehc1.Text;
          sobshc1 := EdtObshc1.Text;
          sokhc1 := EdtOkhc1.Text;
          slevehc2 := EdtLevehc2.Text;
          sobshc2 := EdtObshc2.Text;
          sokhc2 := EdtOkhc2.Text;
          slevehc3 := EdtLevehc3.Text;
          sobshc3 := EdtObshc3.Text;
          sokhc3 := EdtOkhc3.Text;
          sleveem1 := EdtLeveem1.Text;
          sobsem1 := EdtObsem1.Text;
          sokem1 := EdtOkem1.Text;
          sleveem2 := EdtLeveem2.Text;
          sobsem2 := EdtObsem2.Text;
          sokem2 := EdtOkem2.Text;
      end;
      Result := True;
   except
        on E:Exception do
        begin
            Result := False;
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'RellenarValores_DatosComunes: ' + E.Message);
        end;
   end;
end;


procedure TfrmValoresLimite.PgCtrlValoresLimiteChange(Sender: TObject);
begin
    if (PgCtrlValoresLimite.ActivePage = TSheetMotocicletas) then
      edtOkDpe.setfocus
    else if (PgCtrlValoresLimite.ActivePage = TSheetVehiculosLigeros) then
      edtOkDpevl.setfocus
    else if (PgCtrlValoresLimite.ActivePage = TSheetVehiculosPesados) then
      edtOkDpevp.setfocus
    else if (PgCtrlValoresLimite.ActivePage = TSheetRemolques) then
      edtOkDper.setfocus
    else if (PgCtrlValoresLimite.ActivePage = TSheetComunes) then
      edtOkDmae.setfocus
end;

// Devuelve True si se han logrado actualizar TODOS los valores relacionados con las motocicletas en la tabla TCAMPOS
function TfrmValoresLimite.ActualizarValores_Motocicletas_TCAMPOS (DV: tDatos_TodosLosVehiculos; SDM: tSentido): boolean;
var
  Umbral_Auxi: string; { Almacena el umbral de una tupla }

begin
    Result := False;
    with DV do
    begin
        try
           Umbral_Auxi := ConvierteComaEnPunto(sOkDpe);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_DPE, DEPEND_MOTOCICLETA, Umbral_Auxi, sOkDpe, SDM.sdpe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsDpe);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_DPE, DEPEND_MOTOCICLETA, Umbral_Auxi, sObsDpe, SDM.sdpe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveDpe);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_DPE, DEPEND_MOTOCICLETA, Umbral_Auxi, sLeveDpe, SDM.sdpe)) then
             exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkDoe);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_DOE, DEPEND_MOTOCICLETA, Umbral_Auxi, sOkDoe, SDM.sdoe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsDoe);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_DOE, DEPEND_MOTOCICLETA, Umbral_Auxi, sObsDoe, SDM.sdoe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveDoe);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_DOE, DEPEND_MOTOCICLETA, Umbral_Auxi, sLeveDoe, SDM.sdoe)) then
             exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkEfe);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_EFE, DEPEND_MOTOCICLETA, Umbral_Auxi, sOkEfe, SDM.sefe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsEfe);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_EFE, DEPEND_MOTOCICLETA, Umbral_Auxi, sObsEfe, SDM.sefe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveEfe);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_EFE, DEPEND_MOTOCICLETA, Umbral_Auxi, sLeveEfe, SDM.sefe)) then
             exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkEfs);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_EFS, DEPEND_MOTOCICLETA, Umbral_Auxi, sOkEfs, SDM.sefs)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsEfs);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_EFS, DEPEND_MOTOCICLETA, Umbral_Auxi, sObsEfs, SDM.sefs)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveEfs);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_EFS, DEPEND_MOTOCICLETA, Umbral_Auxi, sLeveEfs, SDM.sefs)) then
             exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkDfs1e);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_DFS1E, DEPEND_MOTOCICLETA, Umbral_Auxi, sOkDfs1e, SDM.sdfs1e)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsDfs1e);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_DFS1E, DEPEND_MOTOCICLETA, Umbral_Auxi, sObsDfs1e, SDM.sdfs1e)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveDfs1e);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_DFS1E, DEPEND_MOTOCICLETA, Umbral_Auxi, sLeveDfs1e, SDM.sdfs1e)) then
             exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkDfsoe);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_DFSOE, DEPEND_MOTOCICLETA, Umbral_Auxi, sOkDfsoe, SDM.sdfsoe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsDfsoe);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_DFSOE, DEPEND_MOTOCICLETA, Umbral_Auxi, sObsDfsoe, SDM.sdfsoe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveDfsoe);
           if (ActualizarCampo_TCAMPOS (EFE_LEVE_DFSOE, DEPEND_MOTOCICLETA, Umbral_Auxi, sLeveDfsoe, SDM.sdfsoe)) then
              Result := True;
        except
            on E:Exception do
            begin
                Result := False;
                FAnomalias.PonAnotacion (TRAZA_SIEMPRE,7,FICHERO_ACTUAL,'Error al actualizar MOTOCICLETAS en TCAMPOS: ' + E.Message);
            end;
        end;
    end;
end;

// Devuelve True si se han logrado actualizar TODOS los valores relacionados con los veh�culos ligeros en la tabla TCAMPOS
function TfrmValoresLimite.ActualizarValores_VehiculosLigeros_TCAMPOS (DV: tDatos_TodosLosVehiculos; SDVL: tSentido): boolean;
var
  Umbral_Auxi: string; { Almacena el umbral de una tupla }

begin
    Result := False;
    with DV do
    begin
        try
           Umbral_Auxi := ConvierteComaEnPunto(sOkDpe);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_DPE, DEPEND_VL, Umbral_Auxi, sOkDpe, SDVL.sdpe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsDpe);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_DPE, DEPEND_VL, Umbral_Auxi, sObsDpe, SDVL.sdpe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveDpe);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_DPE, DEPEND_VL, Umbral_Auxi, sLeveDpe, SDVL.sdpe)) then
             exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkDoe);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_DOE, DEPEND_VL, Umbral_Auxi, sOkDoe, SDVL.sdoe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsDoe);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_DOE, DEPEND_VL, Umbral_Auxi, sObsDoe, SDVL.sdoe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveDoe);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_DOE, DEPEND_VL, Umbral_Auxi, sLeveDoe, SDVL.sdoe)) then
             exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkEfe);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_EFE, DEPEND_VL, Umbral_Auxi, sOkEfe, SDVL.sefe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsEfe);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_EFE, DEPEND_VL, Umbral_Auxi, sObsEfe, SDVL.sefe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveEfe);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_EFE, DEPEND_VL, Umbral_Auxi, sLeveEfe, SDVL.sefe)) then
             exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkEfs);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_EFS, DEPEND_VL, Umbral_Auxi, sOkEfs, SDVL.sefs)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsEfs);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_EFS, DEPEND_VL, Umbral_Auxi, sObsEfs, SDVL.sefs)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveEfs);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_EFS, DEPEND_VL, Umbral_Auxi, sLeveEfs, SDVL.sefs)) then
             exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkDfs1e);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_DFS1E, DEPEND_VL, Umbral_Auxi, sOkDfs1e, SDVL.sdfs1e)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsDfs1e);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_DFS1E, DEPEND_VL, Umbral_Auxi, sObsDfs1e, SDVL.sdfs1e)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveDfs1e);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_DFS1E, DEPEND_VL, Umbral_Auxi, sLeveDfs1e, SDVL.sdfs1e)) then
             exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkDfsoe);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_DFSOE, DEPEND_VL, Umbral_Auxi, sOkDfsoe, SDVL.sdfsoe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsDfsoe);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_DFSOE, DEPEND_VL, Umbral_Auxi, sObsDfsoe, SDVL.sdfsoe)) then
             exit;

           Umbral_Auxi := ConvierteComaEnPunto(sLeveDfsoe);
           if ActualizarCampo_TCAMPOS (EFE_LEVE_DFSOE, DEPEND_VL, Umbral_Auxi, sLeveDfsoe, SDVL.sdfsoe) then
              Result := True;

        except
            on E:Exception do
            begin
                Result := False;
                FAnomalias.PonAnotacion (TRAZA_SIEMPRE,8,FICHERO_ACTUAL,'Error al actualizar VEHICULOS LIGEROS en TCAMPOS: ' + E.Message);
            end;
        end;
    end;
end;

// Devuelve True si se han logrado actualizar TODOS los valores relacionados con los veh�culos pesados en la tabla TCAMPOS
function TfrmValoresLimite.ActualizarValores_VehiculosPesados_TCAMPOS (DV: tDatos_TodosLosVehiculos; SDVP: tSentido): boolean;
var
  Umbral_Auxi: string; { Almacena el umbral de una tupla }

begin
    Result := False;
    with DV do
    begin
        try
           Umbral_Auxi := ConvierteComaEnPunto(sOkDpe);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_DPE, DEPEND_VP, Umbral_Auxi, sOkDpe, SDVP.sdpe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsDpe);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_DPE, DEPEND_VP, Umbral_Auxi, sObsDpe, SDVP.sdpe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveDpe);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_DPE, DEPEND_VP, Umbral_Auxi, sLeveDpe, SDVP.sdpe)) then
             exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkDoe);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_DOE, DEPEND_vp, Umbral_Auxi, sOkDoe, SDVP.sdoe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsDoe);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_DOE, DEPEND_vp, Umbral_Auxi, sObsDoe, SDVP.sdoe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveDoe);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_DOE, DEPEND_vp, Umbral_Auxi, sLeveDoe, SDVP.sdoe)) then
             exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkEfe);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_EFE, DEPEND_vp, Umbral_Auxi, sOkEfe, SDVP.sefe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsEfe);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_EFE, DEPEND_vp, Umbral_Auxi, sObsEfe, SDVP.sefe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveEfe);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_EFE, DEPEND_vp, Umbral_Auxi, sLeveEfe, SDVP.sefe)) then
             exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkEfs);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_EFS, DEPEND_vp, Umbral_Auxi, sOkEfs, SDVP.sefs)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsEfs);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_EFS, DEPEND_vp, Umbral_Auxi, sObsEfs, SDVP.sefs)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveEfs);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_EFS, DEPEND_vp, Umbral_Auxi, sLeveEfs, SDVP.sefs)) then
             exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkDfs1e);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_DFS1E, DEPEND_vp, Umbral_Auxi, sOkDfs1e, SDVP.sdfs1e)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsDfs1e);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_DFS1E, DEPEND_vp, Umbral_Auxi, sObsDfs1e, SDVP.sdfs1e)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveDfs1e);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_DFS1E, DEPEND_vp, Umbral_Auxi, sLeveDfs1e, SDVP.sdfs1e)) then
             exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkDfsoe);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_DFSOE, DEPEND_vp, Umbral_Auxi, sOkDfsoe, SDVP.sdfsoe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsDfsoe);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_DFSOE, DEPEND_vp, Umbral_Auxi, sObsDfsoe, SDVP.sdfsoe)) then
             exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveDfsoe);
           if ActualizarCampo_TCAMPOS (EFE_LEVE_DFSOE, DEPEND_vp, Umbral_Auxi, sLeveDfsoe, SDVP.sdfsoe) then
             Result := True;

        except
            on E:Exception do
            begin
                Result := False;
                FAnomalias.PonAnotacion (TRAZA_SIEMPRE,9,FICHERO_ACTUAL,'Error al actualizar VEHICULOS PESADOS en TCAMPOS: ' + E.Message);
            end;
        end;
    end;
end;

// Devuelve True si se han logrado actualizar TODOS los valores relacionados con los remolques en la tabla TCAMPOS
function TfrmValoresLimite.ActualizarValores_Remolques_TCAMPOS (DV: tDatos_TodosLosVehiculos; SDR: tSentido): boolean;
var
  Umbral_Auxi: string; { Almacena el umbral de una tupla }

begin
    Result := False;
    with DV do
    begin
        try
           Umbral_Auxi := ConvierteComaEnPunto(sOkDpe);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_DPE, DEPEND_REMOLQUE, Umbral_Auxi, sOkDpe, SDR.sdpe)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsDpe);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_DPE, DEPEND_REMOLQUE, Umbral_Auxi, sObsDpe, SDR.sdpe)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveDpe);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_DPE, DEPEND_REMOLQUE, Umbral_Auxi, sLeveDpe, SDR.sdpe)) then
              exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkDoe);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_DOE, DEPEND_REMOLQUE, Umbral_Auxi, sOkDoe, SDR.sdoe)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsDoe);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_DOE, DEPEND_REMOLQUE, Umbral_Auxi, sObsDoe, SDR.sdoe)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveDoe);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_DOE, DEPEND_REMOLQUE, Umbral_Auxi, sLeveDoe, SDR.sdoe)) then
              exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkEfe);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_EFE, DEPEND_REMOLQUE, Umbral_Auxi, sOkEfe, SDR.sefe)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsEfe);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_EFE, DEPEND_REMOLQUE, Umbral_Auxi, sObsEfe, SDR.sefe)) then

           Umbral_Auxi := ConvierteComaEnPunto(sLeveEfe);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_EFE, DEPEND_REMOLQUE, Umbral_Auxi, sLeveEfe, SDR.sefe)) then
              exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkEfs);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_EFS, DEPEND_REMOLQUE, Umbral_Auxi, sOkEfs, SDR.sefs)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsEfs);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_EFS, DEPEND_REMOLQUE, Umbral_Auxi, sObsEfs, SDR.sefs)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveEfs);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_EFS, DEPEND_REMOLQUE, Umbral_Auxi, sLeveEfs, SDR.sefs)) then
              exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkDfs1e);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_DFS1E, DEPEND_REMOLQUE, Umbral_Auxi, sOkDfs1e, SDR.sdfs1e)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsDfs1e);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_DFS1E, DEPEND_REMOLQUE, Umbral_Auxi, sObsDfs1e, SDR.sdfs1e)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveDfs1e);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_DFS1E, DEPEND_REMOLQUE, Umbral_Auxi, sLeveDfs1e, SDR.sdfs1e)) then
              exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkDfsoe);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_DFSOE, DEPEND_REMOLQUE, Umbral_Auxi, sOkDfsoe, SDR.sdfsoe)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsDfsoe);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_DFSOE, DEPEND_REMOLQUE, Umbral_Auxi, sObsDfsoe, SDR.sdfsoe)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveDfsoe);
           if (ActualizarCampo_TCAMPOS (EFE_LEVE_DFSOE, DEPEND_REMOLQUE, Umbral_Auxi, sLeveDfsoe, SDR.sdfsoe)) then
              Result := True;

        except
            on E:Exception do
            begin
                Result := False;
                FAnomalias.PonAnotacion (TRAZA_SIEMPRE,10,FICHERO_ACTUAL,'Error al actualizar VEHICULOS PESADOS en TCAMPOS: ' +E.Message);
            end;
        end;
    end;
end;

// Devuelve True si se han logrado actualizar TODOS los valores relacionados con los datos comunes en la tabla TCAMPOS
function TfrmValoresLimite.ActualizarValores_DatosComunes_TCAMPOS (DDC: tDatos_DatosComunes; SDC: tSentidoDComunes): boolean;
var
  Umbral_Auxi: string; { Almacena el umbral de una tupla }

begin
    Result := False;
    with DDC do
    begin
        try
           Umbral_Auxi := ConvierteComaEnPunto(sOkDmae);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_DMAE, DEPEND_CAMPO6, Umbral_Auxi, sOkDmae, SDC.sdmae)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsDmae);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_DMAE, DEPEND_CAMPO6, Umbral_Auxi, sObsDmae, SDC.sdmae)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveDmae);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_DMAE, DEPEND_CAMPO6, Umbral_Auxi, sLeveDmae, SDC.sdmae)) then
              exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkEma);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_EMA, DEPEND_CAMPO6, Umbral_Auxi, sOkEma, SDC.sema)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsEma);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_EMA, DEPEND_CAMPO6, Umbral_Auxi, sObsEma, SDC.sema)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveEma);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_EMA, DEPEND_CAMPO6, Umbral_Auxi, sLeveEma, SDC.sema)) then
              exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkEmam);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_EMAM, DEPEND_CAMPO6, Umbral_Auxi, sOkEmam, SDC.semam)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsEmam);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_EMAM, DEPEND_CAMPO6, Umbral_Auxi, sObsEmam, SDC.semam)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveEmam);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_EMAM, DEPEND_CAMPO6, Umbral_Auxi, sLeveEmam, SDC.semam)) then
              exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkco1);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_CO, DEPEND_ANT92, Umbral_Auxi, sOkco1, SDC.scoa92)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsco1);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_CO, DEPEND_ANT92, Umbral_Auxi, sObsco1, SDC.scoa92)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveco1);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_CO, DEPEND_ANT92, Umbral_Auxi, sLeveco1, SDC.scoa92)) then
              exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkco2);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_CO, DEPEND_9294, Umbral_Auxi, sOkco2, SDC.sco9294)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsco2);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_CO, DEPEND_9294, Umbral_Auxi, sObsco2, SDC.sco9294)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveco2);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_CO, DEPEND_9294, Umbral_Auxi, sLeveco2, SDC.sco9294)) then
              exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkco3);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_CO, DEPEND_POS94, Umbral_Auxi, sOkco3, SDC.scop94)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsco3);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_CO, DEPEND_POS94, Umbral_Auxi, sObsco3, SDC.scop94)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveco3);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_CO, DEPEND_POS94, Umbral_Auxi, sLeveco3, SDC.scop94)) then
              exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkhc1);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_HC, DEPEND_ANT92, Umbral_Auxi, sOkhc1, SDC.shca92)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObshc1);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_HC, DEPEND_ANT92, Umbral_Auxi, sObshc1, SDC.shca92)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLevehc1);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_HC, DEPEND_ANT92, Umbral_Auxi, sLevehc1, SDC.shca92)) then
              exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkhc2);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_HC, DEPEND_9294, Umbral_Auxi, sOkhc2, SDC.shc9294)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObshc2);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_HC, DEPEND_9294, Umbral_Auxi, sObshc2, SDC.shc9294)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLevehc2);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_HC, DEPEND_9294, Umbral_Auxi, sLevehc2, SDC.shc9294)) then
              exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkhc3);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_HC, DEPEND_POS94, Umbral_Auxi, sOkhc3, SDC.shcp94)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObshc3);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_HC, DEPEND_POS94, Umbral_Auxi, sObshc3, SDC.shcp94)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLevehc3);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_HC, DEPEND_POS94, Umbral_Auxi, sLevehc3, SDC.shcp94)) then
              exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkem1);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_EM, DEPEND_ANT95, Umbral_Auxi, sOkem1, SDC.seha95)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsem1);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_EM, DEPEND_ANT95, Umbral_Auxi, sObsem1, SDC.seha95)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveem1);
           if not (ActualizarCampo_TCAMPOS (EFE_LEVE_EM, DEPEND_ANT95, Umbral_Auxi, sLeveem1, SDC.seha95)) then
              exit;

           Umbral_Auxi := ConvierteComaEnPunto(sOkem2);
           if not (ActualizarCampo_TCAMPOS (EFE_OK_EM, DEPEND_POS95, Umbral_Auxi, sOkem2, SDC.sehp95)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sObsem2);
           if not (ActualizarCampo_TCAMPOS (EFE_OBS_EM, DEPEND_POS95, Umbral_Auxi, sObsem2, SDC.sehp95)) then
              exit;
           Umbral_Auxi := ConvierteComaEnPunto(sLeveem2);
           if (ActualizarCampo_TCAMPOS (EFE_LEVE_EM, DEPEND_POS95, Umbral_Auxi, sLeveem2, SDC.sehp95)) then
              Result := True;

        except
            on E:Exception do
            begin
                Result := False;
                FAnomalias.PonAnotacion (TRAZA_SIEMPRE,11,FICHERO_ACTUAL,'Error al actualizar VEHICULOS PESADOS en TCAMPOS: ' +E.Message);
            end;
        end;
    end;
end;


function TFrmValoresLimite.ActualizarCampo_TCAMPOS (iCampo: integer; iDepend: integer; VUmbral: string; VLiteral: string; sSentido:string): boolean;
var
   fUmbral {,fLiteral}: double;
   CodErr: integer;

begin
    Result := False;
    fUmbral := 0;
    try
       Val (VUmbral, fUmbral,CodErr);
       if (CodErr <> 0) then
       begin
           {$IFDEF TRAZAS}
             FTrazas.PonAnotacion (TRAZA_FLUJO,1,FICHERO_ACTUAL,'Error al convertir un Umbral para actualizar un campo de TCAMPOS');
           {$ENDIF}
       end
       else
       begin
          VLiteral := ConvierteComaEnPunto(VLiteral);
          { Hay que ver si se ha modificado o no el sentido }
          if (sSentido <> '') then
          begin
              with qryConsultas do
              begin
                  Close;
                  Sql.Clear;
                  Sql.Add ('UPDATE TCAMPOS SET UMBRAL=:fUmbral,LITERAL=:VLiteral,SENTIDO=:sSentido WHERE CAMPO=:iCampo AND DEPENDEN=:iDepend');
                  Params[1].AsString := VLiteral;
                  Params[2].AsString := sSentido;
                  Params[3].AsInteger := iCampo;
                  Params[4].AsInteger := iDepend;
                  {$IFDEF TRAZAS}
                     FTrazas.PonComponente (TRAZA_REGISTRO, 37, FICHERO_ACTUAL, qryConsultas);
                  {$ENDIF}
                  ExecSQL;
                  Application.ProcessMessages;
              end;
          end
          else
          begin
              with qryConsultas do
              begin
                  Close;
                  Sql.Clear;
                  Sql.Add ('UPDATE TCAMPOS SET UMBRAL=:fUmbral,LITERAL=:VLiteral WHERE CAMPO=:iCampo AND DEPENDEN=:iDepend');
                  Params[0].AsFloat := fUmbral;
                  Params[1].AsString := VLiteral;
                  Params[2].AsInteger := iCampo;
                  Params[3].AsInteger := iDepend;
                  {$IFDEF TRAZAS}
                     FTrazas.PonComponente (TRAZA_REGISTRO, 38, FICHERO_ACTUAL, qryConsultas);
                  {$ENDIF}
                  ExecSQL;
                  Application.ProcessMessages;
              end;
          end;
          Result := True;
          {$IFDEF TRAZAS}
             FTrazas.PonAnotacion (TRAZA_FLUJO,2,FICHERO_ACTUAL,Format ('%s %4.2f %s %d %d', ['Tupla de TCAMPOS actualizada correctamente',fUmbral,vLiteral,iCampo,iDepend]));
          {$ENDIF}
       end;
    except
        on E:Exception do
        begin
            Result := False;
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,12,FICHERO_ACTUAL,Format ('%s %s %4.2f %s %d %d', ['Tupla de TCAMPOS NO actualizada correctamente: ',E.Message,fUmbral,vLiteral,iCampo,iDepend]));
        end;
    end;
end;


//Devuelve True si ha le�do correctamente todos los valores del form. Devuelve los valores l�mite de una Motocicleta
function TFrmValoresLimite.LeerValoresLimite_Motocicletas (var DV: tDatos_TodosLosVehiculos): boolean;
begin
    try
       with DV do
       begin
           slevedpe:= edtLeveDpe.Text;
           sObsdpe:= edtObsDpe.Text;
           sOkDpe:= edtOkDpe.Text;
           slevedoe:= edtLeveDoe.Text;
           sObsdoe:= edtObsDoe.Text;
           sOkDoe:= edtOkDoe.Text;
           sleveefs:= edtLeveefs.Text;
           sObsefs:= edtObsefs.Text;
           sOkefs:= edtOkefs.Text;
           sleveefe:= edtLeveefe.Text;
           sObsefe:= edtObsefe.Text;
           sOkefe:= edtOkefe.Text;
           slevedfsoe:= edtLevedfsoe.Text;
           sObsdfsoe:= edtObsdfsoe.Text;
           sOkdfsoe:= edtOkdfsoe.Text;
           slevedfs1e:= edtLevedfs1e.Text;
           sObsdfs1e:= edtObsdfs1e.Text;
           sOkdfs1e:= edtOkdfs1e.Text;
       end;
       Result := True
    except
        on E:Exception do
        begin
            Result := False;
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,13,FICHERO_ACTUAL, 'Error en LeerValoresLimite_Motocicletas: ' + E.Message);
        end;
    end;
end;

// Devuelve los valores l�mite de un Veh�culo Ligero. Devuelve True si ha logrado leer correctamente todos los valores del form
function TFrmValoresLimite.LeerValoresLimite_VehiculosLigeros (var DV: tDatos_TodosLosVehiculos): boolean;
begin
    try
       with DV do
       begin
           slevedpe:= edtLeveDpevl.Text;
           sObsdpe:= edtObsDpevl.Text;
           sOkDpe:= edtOkDpevl.Text;
           slevedoe:= edtLeveDoevl.Text;
           sObsdoe:= edtObsDoevl.Text;
           sOkDoe:= edtOkDoevl.Text;
           sleveefs:= edtLeveefsvl.Text;
           sObsefs:= edtObsefsvl.Text;
           sOkefs:= edtOkefsvl.Text;
           sleveefe:= edtLeveefevl.Text;
           sObsefe:= edtObsefevl.Text;
           sOkefe:= edtOkefevl.Text;
           slevedfsoe:= edtLevedfsoevl.Text;
           sObsdfsoe:= edtObsdfsoevl.Text;
           sOkdfsoe:= edtOkdfsoevl.Text;
           slevedfs1e:= edtLevedfs1evl.Text;
           sObsdfs1e:= edtObsdfs1evl.Text;
           sOkdfs1e:= edtOkdfs1evl.Text;
       end;
       Result := True
    except
        on E:Exception do
        begin
            Result := False;
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,14,FICHERO_ACTUAL, 'Error en LeerValoresLimite_VehiculosLigeros: ' + E.Message);
        end;
    end;
end;

// Devuelve los valores l�mite de un Veh�culo Pesado. Devuelve True si ha logrado leer todos los valores del form correctamente
function TFrmValoresLimite.LeerValoresLimite_VehiculosPesados (var DV: tDatos_TodosLosVehiculos): boolean;
begin
    try
        with DV do
        begin
            slevedpe:= edtLeveDpevp.Text;
            sObsdpe:= edtObsDpevp.Text;
            sOkDpe:= edtOkDpevp.Text;
            slevedoe:= edtLeveDoevp.Text;
            sObsdoe:= edtObsDoevp.Text;
            sOkDoe:= edtOkDoevp.Text;
            sleveefs:= edtLeveefsvp.Text;
            sObsefs:= edtObsefsvp.Text;
            sOkefs:= edtOkefsvp.Text;
            sleveefe:= edtLeveefevp.Text;
            sObsefe:= edtObsefevp.Text;
            sOkefe:= edtOkefevp.Text;
            slevedfsoe:= edtLevedfsoevp.Text;
            sObsdfsoe:= edtObsdfsoevp.Text;
            sOkdfsoe:= edtOkdfsoevp.Text;
            slevedfs1e:= edtLevedfs1evp.Text;
            sObsdfs1e:= edtObsdfs1evp.Text;
            sOkdfs1e:= edtOkdfs1evp.Text;
        end;
       Result := True
    except
        on E:Exception do
        begin
            Result := False;
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,15,FICHERO_ACTUAL, 'Error en LeerValoresLimite_VehiculosPesados: ' + E.Message);
        end;
    end;
end;

// Devuelve los valores l�mite de un Remolque. Devuelve true si ha logrado leer correctamente todos los valores del form
function TFrmValoresLimite.LeerValoresLimite_Remolques (var DV: tDatos_TodosLosVehiculos): boolean;
begin
    try
       with DV do
       begin
           slevedpe:= edtLeveDper.Text;
           sObsdpe:= edtObsDper.Text;
           sOkDpe:= edtOkDper.Text;
           slevedoe:= edtLeveDoer.Text;
           sObsdoe:= edtObsDoer.Text;
           sOkDoe:= edtOkDoer.Text;
           sleveefs:= edtLeveefsr.Text;
           sObsefs:= edtObsefsr.Text;
           sOkefs:= edtOkefsr.Text;
           sleveefe:= edtLeveefer.Text;
           sObsefe:= edtObsefer.Text;
           sOkefe:= edtOkefer.Text;
           slevedfsoe:= edtLevedfsoer.Text;
           sObsdfsoe:= edtObsdfsoer.Text;
           sOkdfsoe:= edtOkdfsoer.Text;
           slevedfs1e:= edtLevedfs1er.Text;
           sObsdfs1e:= edtObsdfs1er.Text;
           sOkdfs1e:= edtOkdfs1er.Text;
       end;
       Result := True
    except
        on E:Exception do
        begin
            Result := False;
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,16,FICHERO_ACTUAL, 'Error en LeerValoresLimite_Remolques: ' + E.Message);
        end;
    end;
end;


// Devuelve true si ha logrado leer correctamente todos los datos comunes
function TFrmValoresLimite.LeerValoresLimite_DatosComunes (var DDC: tDatos_DatosComunes) :boolean;
begin
    try
       with DDC do
       begin
           slevedmae:= edtLevedmae.Text;
           sObsdmae:= edtObsdmae.Text;
           sOkdmae:= edtOkdmae.Text;
           sleveema:= edtLeveema.Text;
           sObsema:= edtObsema.Text;
           sOkema:= edtOkema.Text;
           sleveemam:= edtLeveemam.Text;
           sObsemam:= edtObsemam.Text;
           sOkemam:= edtOkemam.Text;
           sleveco1:= edtleveco1.Text;
           sobsco1:= edtobsco1.Text;
           sokco1:= edtokco1.Text;
           sleveco2:= edtleveco2.Text;
           sobsco2:= edtobsco2.Text;
           sokco2:= edtokco2.Text;
           sleveco3:= edtleveco3.Text;
           sobsco3:= edtobsco3.Text;
           sokco3:= edtokco3.Text;
           slevehc1:= edtlevehc1.Text;
           sobshc1:= edtobshc1.Text;
           sokhc1:= edtokhc1.Text;
           slevehc2:= edtlevehc2.Text;
           sobshc2:= edtobshc2.Text;
           sokhc2:= edtokhc2.Text;
           slevehc3:= edtlevehc3.Text;
           sobshc3:= edtobshc3.Text;
           sokhc3:= edtokhc3.Text;
           sleveem1:= edtleveem1.Text;
           sobsem1:= edtobsem1.Text;
           sokem1:= edtokem1.Text;
           sleveem2:= edtleveem2.Text;
           sobsem2:= edtobsem2.Text;
           sokem2:= edtokem2.Text;
       end;
       Result := True
    except
        on E:Exception do
        begin
            Result := False;
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,17,FICHERO_ACTUAL, 'Error en LeerValoresLimite_DatosComunes: ' + E.Message);
        end;
    end;
end;
{ Devuelve True si los tres campos introducidos son correctos y los tres contienen
  valores ascendentes o descendentes, en cuyo caso se coloca en sCampoSentido
  el valor ARRIBA ('U') o el valor ABAJO ('D') }
function TFrmValoresLimite.CamposIntroducidos_Correctos (sValorOk, sValorObs, sValorLeve: string; var sCampoSentido: string): boolean;
var
  rValorOk, rValorObs, rValorLeve: real;
  iCodErrOk, iCodErrObs, iCodErrLeve: integer;

begin
    rValorLeve := 0;
    rValorObs := 0;
    try
      Result := False;
      Val (ConvierteComaEnPunto(sValorOk), rValorOk, iCoderrOk);
      if (iCoderrOk = 0) then
      begin
          Val (ConvierteComaEnPunto(sValorObs), rValorObs, iCoderrObs);
          if (iCoderrObs = 0) then
          begin
              Val (ConvierteComaEnPunto(sValorLeve), rValorLeve, iCoderrLeve);
              Result := (iCoderrLeve = 0);
          end;
      end;

      { Si se han podido pasar los valores a nros. reales }
      if Result then
      begin
          Result := False;
          if (rValorOk = MAXIMO) then
          begin
              Result := ((rValorObs = MAXIMO) and (rValorLeve = MAXIMO));
              if Result then
                 sCampoSentido := ARRIBA
          end
          else
          begin
              if (rValorObs > rValorOk) then
              begin
                  { Pongo el signo "=" para que se puedan meter ternas del tipo:
                     5  999999999  999999999 }
                  Result := (rValorLeve >= rValorObs);
                  if Result then
                     sCampoSentido := ARRIBA;
              end
              else if (rValorObs < rValorOk) then
              begin
                  Result := (rValorLeve < rValorObs);
                  if Result then
                     sCampoSentido := ABAJO;
              end;
          end;
      end;
    except
        on E:Exception do
        begin
            Result := False;
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,18,FICHERO_ACTUAL,'Error en CamposIntroducidos_Correctos: ' + E.Message);
        end;
    end;
end;

{ Hay que inicializarlos a CADENA_VACIA y antes de actualizar el campo SENTIDO
  de TCAMPOS hay que ver si est� vac�o para no actualizarlo. Esto hay que hacerlo
  por si el usuario NO cambia un tr�o de valores }
procedure TFrmValoresLimite.Inicializar_Sentidos;
begin
    with Sentido do
    begin
        with Motocicletas do
        begin
            sdpe:= '';
            sdoe:= '';
            sefe:= '';
            sefs:= '';
            sdfs1e:= '';
            sdfsoe:= '';
        end;
        with VLigeros do
        begin
            sdpe:= '';
            sdoe:= '';
            sefe:= '';
            sefs:= '';
            sdfs1e:= '';
            sdfsoe:= '';
        end;
        with VPesados do
        begin
            sdpe:= '';
            sdoe:= '';
            sefe:= '';
            sefs:= '';
            sdfs1e:= '';
            sdfsoe:= '';
        end;
        with Remolques do
        begin
            sdpe:= '';
            sdoe:= '';
            sefe:= '';
            sefs:= '';
            sdfs1e:= '';
            sdfsoe:= '';
        end;
        with DatosComunes do
        begin
            sdmae:= '';
            sema:= '';
            semam:= '';
            scoa92:= '';
            sco9294:= '';
            scop94:= '';
            shca92:= '';
            shc9294:= '';
            shcp94:= '';
            seha95:= '';
            sehp95:= '';
        end;
    end;
end;

// Devuelve True si los dos registros pasados por par�metro tienen sus valores iguales
function TfrmValoresLimite.SonIguales_TodosVehiculos (R1, R2: tDatos_TodosLosVehiculos): boolean;
begin
    Result := ((R1.slevedpe = R2.slevedpe) and
               (R1.sObsdpe = R2.sObsdpe) and
               (R1.sOkDpe = R2.sOkDpe) and
               (R1.slevedoe = R2.slevedoe) and
               (R1.sobsdoe = R2.sobsdoe) and
               (R1.sokdoe = R2.sokdoe) and
               (R1.sleveefs = R2.sleveefs) and
               (R1.sobsefs = R2.sobsefs) and
               (R1.sokefs = R2.sokefs) and
               (R1.sleveefe = R2.sleveefe) and
               (R1.sobsefe = R2.sobsefe) and
               (R1.sOkEFE = R2.sOkEFE) and
               (R1.slevedfsoe = R2.slevedfsoe) and
               (R1.sobsdfsoe = R2.sobsdfsoe) and
               (R1.sokdfsoe = R2.sokdfsoe) and
               (R1.slevedfs1e = R2.slevedfs1e) and
               (R1.sobsdfs1e = R2.sobsdfs1e) and
               (R1.sOkDFS1E = R2.sOkDFS1E));
end;

// Devuelve True si los dos registros pasados por par�metro tienen sus valores iguales
function TfrmValoresLimite.SonIguales_DatosComunes (R1, R2: tDatos_DatosComunes): boolean;
begin
    Result := ((R1.slevedmae = R2.slevedmae) and
               (R1.sObsdmae = R2.sObsdmae) and
               (R1.sOkdmae = R2.sOkdmae) and
               (R1.sleveema = R2.sleveema) and
               (R1.sobsema = R2.sobsema) and
               (R1.sokema = R2.sokema) and
               (R1.sleveemam = R2.sleveemam) and
               (R1.sobsemam = R2.sobsemam) and
               (R1.sokemam = R2.sokemam) and
               (R1.sleveco1 = R2.sleveco1) and
               (R1.sobsco1 = R2.sobsco1) and
               (R1.sokco1 = R2.sokco1) and
               (R1.sleveco2 = R2.sleveco2) and
               (R1.sobsco2 = R2.sobsco2) and
               (R1.sokco2 = R2.sokco2) and
               (R1.sleveco3 = R2.sleveco3) and
               (R1.sobsco3 = R2.sobsco3) and
               (R1.sokco3 = R2.sokco3) and
               (R1.slevehc1 = R2.slevehc1) and
               (R1.sobshc1 = R2.sobshc1) and
               (R1.sokhc1 = R2.sokhc1) and
               (R1.slevehc2 = R2.slevehc2) and
               (R1.sobshc2 = R2.sobshc2) and
               (R1.sokhc2 = R2.sokhc2) and
               (R1.slevehc3 = R2.slevehc3) and
               (R1.sobshc3 = R2.sobshc3) and
               (R1.sokhc3 = R2.sokhc3) and
               (R1.sleveem1 = R2.sleveem1) and
               (R1.sobsem1 = R2.sobsem1) and
               (R1.sokem1 = R2.sokem1) and
               (R1.sleveem2 = R2.sleveem2) and
               (R1.sobsem2 = R2.sobsem2) and
               (R1.sokem2 = R2.sokem2));
end;

procedure TfrmValoresLimite.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    qryConsultas.Close;
end;

procedure TfrmValoresLimite.btnImprimirClick(Sender: TObject);
var
  AFTmp: TFTmp;

begin
    aFTmp := TFTmp.Create (Application);
    try
      aFTmp.MuestraClock('Impresi�n','Imprimiendo los valores l�mite de los veh�culos');
      frmImprimirValLim := TfrmImprimirValLim.Create (Application);
      try
          frmImprimirValLim.Execute (1,6,1,5,TfrmValoresLimite(Self),(sender as tcomponent).tag);
      finally
           frmImprimirValLim.Free;
      end;
    finally
         aFTmp.Free;
    end;
end;

// Devuelve True si se han logrado actualizar los valores l�mite en TDATINSPECC
function TfrmValoresLimite.ActualizarValoresLimite_TDATINSPECC (DM, DVL, DVP, DR: tDatos_TodosLosVehiculos; DDC: tDatos_DatosComunes; SD: tSentido_Vehiculos): boolean;
begin
    try
        try
           if (not MyBD.InTransaction) then
              MyBD.InTransaction;

           if (ActualizarDatos_Motocicletas(DM, SD.Motocicletas) and ActualizarDatos_VehiculosLigeros(DVL, SD.VLigeros) and
               ActualizarDatos_VehiculosPesados(DVP, SD.VPesados) and ActualizarDatos_Remolques(DR, SD.Remolques) and
               ActualizarDatos_DatosComunes(DDC, SD.DatosComunes)) then
           begin
               Result := True;
               {$IFDEF TRAZAS}
                FTrazas.PonAnotacion (TRAZA_FLUJO, 4,FICHERO_ACTUAL,'Se han actualizado correctamente los valores l�mite en TCAMPOS');
               {$ENDIF}
           end
           else
           begin
               Result := False;
               {$IFDEF TRAZAS}
                FTrazas.PonAnotacion (TRAZA_FLUJO, 5,FICHERO_ACTUAL,'NO se han actualizado correctamente los valores l�mite en TCAMPOS');
               {$ENDIF}
           end;
        except
             on E:Exception do
             begin
                 Result := False;
                 FAnomalias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'NO se han actualizado correctamente los valores l�mite en TCAMPOS: ' + E.Message);
             end;
        end;
    finally
         if MyBD.InTransaction then
            MyBD.Commit(td);
    end;
end;

// Devuelve True si los datos relativos a las motocicletas se han actualizado correctamente
function TfrmValoresLimite.ActualizarDatos_Motocicletas (DM: tDatos_TodosLosVehiculos; SD: tSentido): boolean;
begin
    try
       if ActualizarValores_Motocicletas_TCAMPOS (DM,SD) then
       begin
           Result := True;
           {$IFDEF TRAZAS}
             FTrazas.PonAnotacion (TRAZA_FLUJO, 7,FICHERO_ACTUAL,'Se han actualizado correctamente los valores de MOTOCICLETAS en TCAMPOS');
           {$ENDIF}
       end
       else
       begin
           Result := False;
           {$IFDEF TRAZAS}
             FTrazas.PonAnotacion (TRAZA_FLUJO, 8,FICHERO_ACTUAL,' NO Se han actualizado correctamente los valores de MOTOCICKETAS en TCAMPOS');
           {$ENDIF}
       end;
    except
         on E:Exception do
         begin
             Result := False;
             FAnomalias.PonAnotacion (TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'NO se han actualizado correctamente los valores de MOTOCICLETAS en TCAMPOS:' + E.Message);
         end;
    end;
end;

// Devuelve True si los datos relativos a los veh�culos ligeros se han actualizado correctamente
function TfrmValoresLimite.ActualizarDatos_VehiculosLigeros (DVL: tDatos_TodosLosVehiculos; SD: tSentido): boolean;
begin
    try
       if ActualizarValores_VehiculosLigeros_TCAMPOS (DVL,SD) then
       begin
           Result := True;
           {$IFDEF TRAZAS}
             FTrazas.PonAnotacion (TRAZA_FLUJO, 9,FICHERO_ACTUAL,'Se han actualizado correctamente los valores de VEHICULOS LIGEROS en TCAMPOS');
           {$ENDIF}
       end
       else
       begin
           Result := False;
           {$IFDEF TRAZAS}
             FTrazas.PonAnotacion (TRAZA_FLUJO,10,FICHERO_ACTUAL,' NO Se han actualizado correctamente los valores de VEHICULOS LIGEROS en TCAMPOS');
           {$ENDIF}
       end;
    except
         on E:Exception do
         begin
             Result := False;
             FAnomalias.PonAnotacion (TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'NO se han actualizado correctamente los valores de VEHICULOS LIGEROS en TCAMPOS: ' + E.Message);
         end;
    end;
end;

// Devuelve True si los datos relativos a los veh�culos pesados se han actualizado correctamente
function TfrmValoresLimite.ActualizarDatos_VehiculosPesados (DVP: tDatos_TodosLosVehiculos; SD: tSentido): boolean;
begin
    try
       if ActualizarValores_VehiculosPesados_TCAMPOS (DVP,SD) then
       begin
           Result := True;
           {$IFDEF TRAZAS}
             FTrazas.PonAnotacion (TRAZA_FLUJO,11,FICHERO_ACTUAL,'Se han actualizado correctamente los valores de VEHICULOS PESADOS en TCAMPOS');
           {$ENDIF}
       end
       else
       begin
           Result := False;
           {$IFDEF TRAZAS}
             FTrazas.PonAnotacion (TRAZA_FLUJO,12,FICHERO_ACTUAL,' NO Se han actualizado correctamente los valores de VEHICULOS PESADOS en TCAMPOS');
           {$ENDIF}
       end;
    except
         on E:Exception do
         begin
             Result := False;
             FAnomalias.PonAnotacion (TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'NO se han actualizado correctamente los valores de VEHICULOS PESADOS en TCAMPOS: ' + E.Message);
         end;
    end;
end;

// Devuelve True si los datos relativos a los remolques se han actualizado correctamente
function TfrmValoresLimite.ActualizarDatos_Remolques (DR: tDatos_TodosLosVehiculos; SD: tSentido): boolean;
begin
    try
       if ActualizarValores_Remolques_TCAMPOS (DR,SD) then
       begin
           Result := True;
           {$IFDEF TRAZAS}
             FTrazas.PonAnotacion (TRAZA_FLUJO,13,FICHERO_ACTUAL,'Se han actualizado correctamente los valores de REMOLQUES en TCAMPOS');
           {$ENDIF}
       end
       else
       begin
           Result := False;
           {$IFDEF TRAZAS}
             FTrazas.PonAnotacion (TRAZA_FLUJO,14,FICHERO_ACTUAL,' NO Se han actualizado correctamente los valores de REMOLQUES en TCAMPOS');
           {$ENDIF}
       end;
    except
         on E:Exception do
         begin
             Result := False;
             FAnomalias.PonAnotacion (TRAZA_SIEMPRE,5,FICHERO_ACTUAL,'NO se han actualizado correctamente los valores de REMOLQUES en TCAMPOS: ' + E.Message);
         end;
    end;
end;

// Devuelve True si los datos relativos a los datos comunes se han actualizado correctamente 
function TfrmValoresLimite.ActualizarDatos_DatosComunes (DDC: tDatos_DatosComunes; SD: tSentidoDComunes): boolean;
begin
    try
       if ActualizarValores_DatosComunes_TCAMPOS (DDC,SD) then
       begin
           Result := True;
           {$IFDEF TRAZAS}
             FTrazas.PonAnotacion (TRAZA_FLUJO,15,FICHERO_ACTUAL,'Se han actualizado correctamente los valores de DATOS COMUNES en TCAMPOS');
           {$ENDIF}
       end
       else
       begin
           Result := False;
           {$IFDEF TRAZAS}
             FTrazas.PonAnotacion (TRAZA_FLUJO,16,FICHERO_ACTUAL,' NO Se han actualizado correctamente los valores de DATOS COMUNES en TCAMPOS');
           {$ENDIF}
       end;
    except
         on E:Exception do
         begin
             Result := False;
             FAnomalias.PonAnotacion (TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'NO se han actualizado correctamente los valores de DATOS COMUNES en TCAMPOS: ' + E.Message);
         end;
    end;
end;

procedure TfrmValoresLimite.FormCreate(Sender: TObject);
begin
    with qryConsultas do
    begin
        Close;
        SQLConnection := mybd;
    end;
end;

procedure TfrmValoresLimite.RellenarValores_form (Datos_Mot_TCAMPOS, Datos_VehiLigeros_TCAMPOS,
                                 Datos_VehiPesados_TCAMPOS, Datos_Rem_TCAMPOS: tDatos_TodosLosVehiculos;
                                 Datos_DCom_TCAMPOS: tDatos_DatosComunes; VDeCampos: TCampos);
begin
    RellenarValores_Motocicletas (Datos_Mot_TCAMPOS, VDeCampos);
    RellenarValores_VehiculosLigeros (Datos_VehiLigeros_TCAMPOS, VDeCampos);
    RellenarValores_VehiculosPesados (Datos_VehiPesados_TCAMPOS, VDeCampos);
    RellenarValores_Remolques (Datos_Rem_TCAMPOS, VDeCampos);
    RellenarValores_DatosComunes (Datos_DCom_TCAMPOS, VDeCampos);
end;


function TfrmValoresLimite.LeerValoresLimite_Form (var Datos_Mot_TCAMPOS, Datos_VehiLigeros_TCAMPOS,
                                 Datos_VehiPesados_TCAMPOS, Datos_Rem_TCAMPOS: tDatos_TodosLosVehiculos;
                                 var Datos_DCom_TCAMPOS: tDatos_DatosComunes): boolean;
begin
    Result := (
        LeerValoresLimite_Motocicletas (Datos_Mot_TCAMPOS) and
        LeerValoresLimite_VehiculosLigeros (Datos_VehiLigeros_TCAMPOS) and
        LeerValoresLimite_VehiculosPesados (Datos_VehiPesados_TCAMPOS) and
        LeerValoresLimite_Remolques (Datos_Rem_TCAMPOS) and
        LeerValoresLimite_DatosComunes (Datos_DCom_TCAMPOS)
    );
end;


procedure TfrmValoresLimite.edtokefsKeyPress(Sender: TObject;
  var Key: Char);
begin
    if (((Key < '0') or (key > '9')) and (Key <> #8) and (Key <> '.') and (Key <> ',')) then
       Key := #0;
end;



procedure TfrmValoresLimite.edtokdmaeEnter(Sender: TObject);
begin
    DestacarControl (Sender, clGreen, clWhite, False);
end;

procedure TfrmValoresLimite.edtokdmaeExit(Sender: TObject);
begin
    AtenuarControl (Sender, False);
end;


end.
