unit UModDat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB,Globals, SQLExpr,
  ExtCtrls,
  Printers,
  USAGPRINTERS, FMTBcd, DBXpress, Provider, DBClient;

type
  ENoHayDatos = class (Exception);
  TDatosImpresion = class(TDataModule)
    QryPrimerPreparadoTTRABAIMPRE: TClientDataSet;
    dspQryPrimerPreparadoTTRABAIMPRE: TDataSetProvider;
    sdsQryPrimerPreparadoTTRABAIMPRE: TSQLDataSet;
    QryPrimerTrabajoTTRABAIMPRE: TClientDataSet;
    dspQryPrimerTrabajoTTRABAIMPRE: TDataSetProvider;
    sdsQryPrimerTrabajoTTRABAIMPRE: TSQLDataSet;
    QryTrabajosListosTTRABAIMPRE: TClientDataSet;
    dspQryTrabajosListosTTRABAIMPRE: TDataSetProvider;
    sdsQryTrabajosListosTTRABAIMPRE: TSQLDataSet;
    QryLockTTRABAIMPRE: TClientDataSet;
    despQryLockTTRABAIMPRE: TDataSetProvider;
    sdsQryLockTTRABAIMPRE: TSQLDataSet;
    QryDeleteTTRABAIMPRE: TClientDataSet;
    dspQryDeleteTTRABAIMPRE: TDataSetProvider;
    sdsQryDeleteTTRABAIMPRE: TSQLDataSet;
    QryUpdateTTRABAIMPRE: TClientDataSet;
    dspQryUpdateTTRABAIMPRE: TDataSetProvider;
    sdsQryUpdateTTRABAIMPRE: TSQLDataSet;
    QryPonerUltimoTTRABAIMPRE: TClientDataSet;
    dspQryPonerUltimoTTRABAIMPRE: TDataSetProvider;
    dsdQryPonerUltimoTTRABAIMPRE: TSQLDataSet;
    QrySolicitudesEnTTRABAIMPRE: TClientDataSet;
    dspQrySolicitudesEnTTRABAIMPRE: TDataSetProvider;
    sdsQrySolicitudesEnTTRABAIMPRE: TSQLDataSet;
    DSTTRABAIMPRE: TDataSource;
    QrySolicitudesEnTTRABAIMPREPATENTE: TStringField;
    QrySolicitudesEnTTRABAIMPRETIPOTRAB: TStringField;
    QrySolicitudesEnTTRABAIMPREMiSolicitud: TStringField;
    QrySolicitudesEnTTRABAIMPREMiEstado: TStringField;
    QrySolicitudesEnTTRABAIMPREESTADO: TStringField;
    QrySolicitudesEnTTRABAIMPREFECHALTA: TStringField;
    procedure QrySolicitudesEnTTRABAIMPRECalcFields(DataSet: TDataSet);

    procedure TimerAtencionSolicitudesaTimer(Sender: TObject);
    procedure TimerRefrescoSolicitudesaTimer(Sender: TObject);
    procedure TimerImpresionPreparadosaTimer(Sender: TObject);

    function  CanceladaSolicitudOk ( const iUnHandle : integer;
                                     var iMotivo: LONGINT) : boolean;



    function  ATerminadoSolicitudOk ( const iUnHandle, iUnEstado : LONGINT ) : boolean;

    procedure BorrarSolicitud (const iUnHandle : LONGINT);
    procedure DatosImpresionDestroy(Sender: TObject);

    public
        constructor CreateByABD (const aB: tSQLConnection);
    private
        fDataBase: tSQLConnection;


    { Private declarations }

    function  PrimerTrabajoDeLaCola : tSolicitud;
    function  PrimerTrabajoPreparado : tPaqueteDeSolicitud;
    function  ColaDeTrabajos( const UnaSolicitud : tSolicitud ) : LONGINT;
    function  CambiarEstadoSolicitudOk (const iUnEstado, iUnHandle : LONGINT) : boolean;
    function  PuestoAUltimoOk( const iUnHandle : integer) : boolean;


    function  AImprimiendoseSolicitudOk ( const iUnHandle, iUnEstado : LONGINT ) : boolean;
    procedure PrepararSolicitud ( const iUnHandle, iUnEstado : LONGINT );
    procedure PonerUltimoDeLaCola ( const iUnHandle : LONGINT );

  public
    { Public declarations }
  end;



{ function ImpresoraEstaOciosaPara (const UnaSolicitud : tSolicitud ) : integer;
  No hace falta hacer publica esta funcion }

function Calcular_NumeroInspeccion (
                const Ejer:longint;
                const DatVar_Zona: integer; const DatVar_Estacion: LONGINT;
                const CodInsp: longint; const Reverif: string): string;


function  ExisteRegistro (UnaTabla : TClientDataSet; UnasColumnas : string; UnosValores : Variant) : boolean;
procedure IrPrimerRegistro (UnaTabla : TClientDataSet);
procedure IrUltimoRegistro (UnaTabla : TClientDataSet);
procedure RegistroArriba (UnaTabla : TClientDataSet);
procedure RegistroAbajo (UnaTabla : TClientDataSet);
procedure RecorrePorTecla (UnaTabla : TClientDataSet; var UnaTecla : word);
procedure RefrescarQry (UnaQry : TClientDataSet);

var
  DatosImpresio: TDatosImpresion;

implementation

uses
  UCDIALGS,
  UVERSION,
  ULOGS,
  USUCESOS,
  UPRINTER,
  UMENSCTS,
  UTIPOSPR,
  UIMPRIME;

{$R *.DFM}
    const
        FILE_NAME = 'UMODAT.PAS';

  { CONSTANTES QUE IDENTIFICAN LAS DISTINAS SOLICITUDES, TIPOS DE TRABAJO }

  UN_CERTIFICADO       = 1;
  UN_INFORME           = 2;
  UNA_FACTURA_A        = 3;
  UNA_FACTURA_B        = 4;
  UNA_NOTA_A           = 5;
  UNA_NOTA_B           = 6;
  UN_INFORME_DIFERIDO  = 7;
  UNA_NCDESCUENTO_A    = 8;  //AGRE RAN
  UNA_NCDESCUENTO_B    = 9;
  UNA_MEDICION        = 10;  //AGRE RAN MEDI
  UNA_TAMARILLA       = 11;
  UN_INFORMEGNC       = 12;
  UNA_FACTURA_A_GNC   = 13;
  UNA_FACTURA_B_GNC   = 14;
  UNA_NOTA_A_GNC      = 15;
  UNA_NOTA_B_GNC      = 16;


  { LITERALES CORRESPONDIENTES A LOS TIPOS Y ESTADOS DE LOS TRABAJOS }

  LITERAL_FACTURA_A =    'Factura de Tipo A';
  LITERAL_FACTURA_B =    'Factura de Tipo B';
  LITERAL_NOTA_A =       'Nota de Cr�dito de Tipo A';
  LITERAL_NOTA_B =       'Nota de Cr�dito de Tipo B';
  LITERAL_INFORME =      'Informe de Inspecci�n';
  LITERAL_CERTIFICADO =  'Certificado de Inspecci�n';
  LITERAL_NO_SOLICITUD = 'Trabajo por determinar';
  LITERAL_NCDESCUENTO_A = 'Nota Descuento de Tipo A';  //AGRE RAN
  LITERAL_NCDESCUENTO_B = 'Nota Descuento de Tipo B';
  LITERAL_MEDICIONES = 'Informe de Mediciones';     //AGRE RAN MEDI
  LITERAL_TAMARILLA = 'C�dula de Identificaci�n GNC';
  LITERAL_INFORMEGNC = 'Ficha T�cnica GNC';

  LITERAL_EN_ESPERA            = 'Esperando ser atendido';
  LITERAL_CAMBIO_PAPEL         = 'Esperando por cambio de papel';
  LITERAL_PREPRADO             = 'Listo para imprimir';
  LITERAL_IMPRIMIENDOSE        = 'Imprimi�ndose';
  LITERAL_DESCONOCIDO_ESTADO   = 'Desconocido';

  { INCIDENCIAS OCURRIDAS AL INTENTAR ANULAR UN TRABAJO }
  INCIDENCIA_BORRADA   = 1;
  INCIDENCIA_BLOQUEADA = 2;
  INCIDENCIA_BD        = 3;
  INCIDENCIA_RARA      = 4;

  { ERRORES ORACLE LITERAL DE ERROR SI UN REGISTRO SE BLOQUEA }
    REGISTRO_BLOQUEADO = 'ORA-00054';
  { LITERALES ESPECIALES }
     CARACTER_REVERIFICACION = 'R'; { Car�cter que hay que a�adir al n� inspecci�n en caso de tratarse de una reverificaci�n }


type
  EDescripcionDeImpresoraNoValida = class(Exception);
  ESolicitudDeTrabajoDesconocida = class(Exception);
  EBorradoElRegistro = class(Exception);
  ETransformadoMientrasDormia = class(Exception);


    procedure InitError(Msg: String);
    begin
        MessageDlg('Error en la Inicializaci�n',Msg,mtError,[mbOK],mbOK,0);
        if Assigned(fAnomalias)
        then fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FILE_NAME,Msg);
        InitializationError := TRUE;
        Application.Terminate;
    end;


function ExisteRegistro (UnaTabla : TClientDataSet; UnasColumnas : string; UnosValores : Variant) : boolean;
var
  bok : boolean;
begin
  bok := False;
  try
    try
      bOk := UnaTabla.Locate(UnasColumnas, UnosValores, [loCaseInsensitive]);
    except
      on E : Exception do begin
        bOk := False;
        fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'NO SE PUEDE BUSCAR EN ' + UnaTabla.Name + ': ' + E.message);
      end;
    end;
  finally
    result := bOk;
  end;
end;




procedure RecorrePorTecla (UnaTabla : TClientDataSet; var UnaTecla : word);
const
    TECLA_NULA = 0;

begin
   case UnaTecla of
      VK_LEFT, VK_DOWN: RegistroAbajo(UnaTabla);
       VK_RIGHT, VK_UP: RegistroArriba(UnaTabla);
               VK_PRIOR, VK_HOME: IrPrimerRegistro(UnaTabla);
                   VK_NEXT, VK_END: IrUltimoRegistro(UnaTabla);
    end;

    if UnaTecla in [ VK_LEFT, VK_DOWN, VK_RIGHT, VK_UP, VK_PRIOR, VK_HOME, VK_NEXT, VK_END ]
    then UnaTecla := TECLA_NULA;
end;

procedure IrPrimerRegistro (UnaTabla : TClientDataSet);
begin
  try
     UnaTabla.First
  except
    on E: Exception do
    begin
      fAnomalias.PonAnotacion(TRAZA_SIEMPRE,3,FICHERO_ACTUAL, 'NO SE PUEDE IR AL PRIMER REGISTRO DE ' + UnaTabla.Name + ': ' + E.message);
    end;
  end;
end;

procedure IrUltimoRegistro (UnaTabla : TClientDataSet);
begin
  try
     UnaTabla.Last
  except
    on E: Exception do
    begin
      fAnomalias.PonAnotacion(TRAZA_SIEMPRE,4,FICHERO_ACTUAL, 'NO SE PUEDE IR AL ULTIMO  REGISTRO DE ' + UnaTabla.Name + ': ' + E.message);
    end;
  end;
end;

procedure RegistroAbajo (UnaTabla : TClientDataSet);
begin
 try
   with UnaTabla do
   begin
     next;
     if eof then first;
   end;
 except
   on E: exception do
   begin
     fAnomalias.PonAnotacion(TRAZA_SIEMPRE,5,FICHERO_ACTUAL, 'NO SE PUEDE RECORRER ' + UnaTabla.Name + ' HACIA ABAJO: ' + E.message);
   end;
 end;
end;

procedure RegistroArriba (UnaTabla : TClientDataSet);
begin
  try
    with UnaTabla do
    begin
      prior;
      if bof then last;
    end;
  except
    on E: exception do
    begin
      fAnomalias.PonAnotacion(TRAZA_SIEMPRE,6,FICHERO_ACTUAL, 'NO SE PUEDE RECORRER ' + UnaTabla.Name + ' HACIA ARRIBA: ' + E.message);
     end;
  end;
end;

constructor TDatosImpresion.CreateByABD (const aB: tSQLConnection);
var
    i: integer;
begin
    inherited Create (Application);
  try
     fDataBase := aB;

    for I := 0 to ComponentCount - 1 do
    begin
            if Components[I] is TSQLDataSet
            then begin
                With (TSQLDataSet(Components[I])) do
                begin
                    SQLConnection:=MyBd;
                    if CommandText <> '' then
                    Active;
                end;
            end;
    end;

  except
    on E : Exception do
    begin
        InitError(Format('Ocurri� un error iniciando el servicio de impresion: %S',[E.message]));
    end;
  end;
end;


procedure TDatosImpresion.QrySolicitudesEnTTRABAIMPRECalcFields(DataSet: TDataSet);
var
 sTipo : integer;

begin
  try
    sTipo := QrySolicitudesEnTTRABAIMPRE.FieldByName('TIPOTRAB').AsInteger;

   case sTipo of
     UN_CERTIFICADO      : QrySolicitudesEnTTRABAIMPREMISOLICITUD.Value := LITERAL_CERTIFICADO;
     UN_INFORME,
     UN_INFORME_DIFERIDO : QrySolicitudesEnTTRABAIMPREMISOLICITUD.Value := LITERAL_INFORME;
     UNA_FACTURA_A       : QrySolicitudesEnTTRABAIMPREMISOLICITUD.Value := LITERAL_FACTURA_A;
     UNA_FACTURA_B       : QrySolicitudesEnTTRABAIMPREMISOLICITUD.Value := LITERAL_FACTURA_B;
     UNA_NOTA_A          : QrySolicitudesEnTTRABAIMPREMISOLICITUD.Value := LITERAL_NOTA_A;
     UNA_NOTA_B          : QrySolicitudesEnTTRABAIMPREMISOLICITUD.Value := LITERAL_NOTA_B;
     UNA_NCDESCUENTO_A   : QrySolicitudesEnTTRABAIMPREMISOLICITUD.Value := LITERAL_NCDESCUENTO_A; //AGRE RAN
     UNA_NCDESCUENTO_B   : QrySolicitudesEnTTRABAIMPREMISOLICITUD.Value := LITERAL_NCDESCUENTO_B;
     UNA_MEDICION        : QrySolicitudesEnTTRABAIMPREMISOLICITUD.Value := LITERAL_MEDICIONES;  //AGRE RAN MEDI
     UNA_TAMARILLA       : QrySolicitudesEnTTRABAIMPREMISOLICITUD.Value := LITERAL_TAMARILLA;
     UN_INFORMEGNC       : QrySolicitudesEnTTRABAIMPREMISOLICITUD.Value := LITERAL_INFORMEGNC;
     UNA_FACTURA_A_GNC   : QrySolicitudesEnTTRABAIMPREMISOLICITUD.Value := LITERAL_FACTURA_A;
     UNA_FACTURA_B_GNC   : QrySolicitudesEnTTRABAIMPREMISOLICITUD.Value := LITERAL_FACTURA_B;
     UNA_NOTA_A_GNC      : QrySolicitudesEnTTRABAIMPREMISOLICITUD.Value := LITERAL_NOTA_A;
     UNA_NOTA_B_GNC      : QrySolicitudesEnTTRABAIMPREMISOLICITUD.Value := LITERAL_NOTA_B;
     else QrySolicitudesEnTTRABAIMPREMISOLICITUD.Value := LITERAL_NO_SOLICITUD;
   end;

   case QrySolicitudesEnTTRABAIMPRE.FieldByName('ESTADO').AsInteger of
     ord(HEsperando_xx_Atencion): QrySolicitudesEnTTRABAIMPREMIESTADO.Value := LITERAL_EN_ESPERA;
     ord(HEsperando_xx_Papel)   : QrySolicitudesEnTTRABAIMPREMIESTADO.Value := LITERAL_CAMBIO_PAPEL;
     ord(HPreparado)            : QrySolicitudesEnTTRABAIMPREMIESTADO.Value := LITERAL_PREPRADO;
     ord(HImprimiendose)        : QrySolicitudesEnTTRABAIMPREMIESTADO.Value := LITERAL_IMPRIMIENDOSE;
     else QrySolicitudesEnTTRABAIMPREMIESTADO.Value := LITERAL_DESCONOCIDO_ESTADO
   end;

 except
   on E : exception do
   begin
     fAnomalias.PonAnotacion(TRAZA_SIEMPRE,7,FICHERO_ACTUAL,'NO SE PUEDEN CALCUALAR LOS CAMPOS DE TTRABIMPRE POR: '+ E.message);
   end;
 end;
end;

procedure RefrescarQry (UnaQry : TClientDataSet);
begin
  try
    UnaQry.Close;
    Application.ProcessMessages;
    UnaQry.Open;
  except
    on E : Exception do
    begin
      fAnomalias.PonAnotacion(TRAZA_SIEMPRE,8,FICHERO_ACTUAL, 'NO SE PUEDE REFRESCAR LA TABLA ' + UnaQry.Name + ' : ' + E.message);
    end;
  end;
end;

{*************************************************************************************
*************************************************************************************
*************************************************************************************
*************************************************************************************
*************************************************************************************
*************************************************************************************
*************************************************************************************
                              ACTUALIZACIONES }

function TDatosImpresion.PrimerTrabajoDeLaCola : tSolicitud;
var
  sLiteralError, sn : string;
  sTipoSolicitud : integer;
  //d: Tstrings;
begin

 { Obtiene la solicitud mas antigua de la tabla TTrabaimpre
   devuelve un 0 si no hay trabajos en la cola y un -1 si surge
   alg�n error }
  try
    try
      result.iHandle := 0;
      sn := QryPrimerTrabajoTTRABAIMPRE.Name;


      with QryPrimerTrabajoTTRABAIMPRE  do
      begin
        Close;

          {$IFDEF TRAZAS}
            fTrazas.PonComponente(TRAZA_SQL,1,FICHERO_ACTUAL,QryPrimerTrabajoTTRABAIMPRE);
          {$ENDIF}
        Application.ProcessMessages;
        Open;
        Application.ProcessMessages;

        if RecordCount > 0 then
        begin

          {$IFDEF TRAZAS}
            fTrazas.PonRegistro(TRAZA_REGISTRO,1,FICHERO_ACTUAL,QryPrimerTrabajoTTRABAIMPRE);
          {$ENDIF}

          result.iHandle := Fields[0].AsInteger;
          sTipoSolicitud := Fields[1].AsInteger;
          case sTipoSolicitud of
            UN_CERTIFICADO      : result.iSolicitud := Certificado;
            UN_INFORME          : result.iSolicitud := Informe;
            UN_INFORME_DIFERIDO : result.iSolicitud := InformeDiferido;
            UNA_FACTURA_A       : result.iSolicitud := tFactura_A;
            UNA_FACTURA_B       : result.iSolicitud := tFactura_B;
            UNA_NOTA_A          : result.iSolicitud := Nota_A;
            UNA_NOTA_B          : result.iSolicitud := Nota_B;
            UNA_NCDESCUENTO_A   : result.iSolicitud := NCDescuento_A;  //AGRE RAN
            UNA_NCDESCUENTO_B   : result.iSolicitud := NCDescuento_B;
            UNA_MEDICION        : Result.iSolicitud := Medicion;    //AGRE RAN MEDI
            UNA_TAMARILLA       : Result.iSolicitud := TAmarilla;
            UN_INFORMEGNC       : Result.iSolicitud := InformeGNC;
            UNA_FACTURA_A_GNC   : result.iSolicitud := Factura_A_GNC;
            UNA_FACTURA_B_GNC   : result.iSolicitud := Factura_B_GNC;
            UNA_NOTA_A_GNC      : result.iSolicitud := Nota_A_GNC;
            UNA_NOTA_B_GNC      : result.iSolicitud := Nota_B_GNC;
            else raise ESolicitudDeTrabajoDesconocida.Create (' El tipo de solicitud no es valido: ' + inttostr(sTipoSolicitud));
          end;
        end;

        Close;
      end;

    except
      on E : Exception do
      begin
        QryPrimerTrabajoTTRABAIMPRE.Close;
        result.iHandle := -1;
        sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_OBTENIENDO_PRIMERO_COLA;
        FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
        fAnomalias.PonAnotacion(TRAZA_SIEMPRE, 9, FICHERO_ACTUAL, LITERAL_ERROR_SERVIDOR_IMPRESION_OBTENIENDO_PRIMERO_COLA + E.message);
      end;
    end;
  finally
    QryPrimerTrabajoTTRABAIMPRE.Close;
  end;
end;

{ ************************************************************************************* }

function TDatosImpresion.ColaDeTrabajos( const UnaSolicitud : tSolicitud) : LONGINT;
{
  Funcion que devuelve el numero de trabajos en la cola de un determinado
  tipo de trabajo, sin contarse �l , siendo el valor de -1 si ocurre alg�n error
}

var
 sLiteralError : string;
 aux : string;
begin
  try
    result := -1;

    try
      with QryTrabajosListosTTRABAIMPRE do
      begin
        Close;
        case UnaSolicitud.iSolicitud of
          Certificado     : params.ParamByName('UnTipoTrabajo').Value := UN_CERTIFICADO;
          Informe         : params.ParamByName('UnTipoTrabajo').Value := UN_INFORME;
          InformeDiferido : params.ParamByName('UnTipoTrabajo').Value := UN_INFORME_DIFERIDO;
          tFactura_A       : params.ParamByName('UnTipoTrabajo').Value := UNA_FACTURA_A;
          tFactura_B       : params.ParamByName('UnTipoTrabajo').Value := UNA_FACTURA_B;
          Nota_A          : params.ParamByName('UnTipoTrabajo').Value := UNA_NOTA_A;
          Nota_B          : params.ParamByName('UnTipoTrabajo').Value := UNA_NOTA_B;
          NCDescuento_A   : params.ParamByName('UnTipoTrabajo').Value := UNA_NCDESCUENTO_A;
          NCDescuento_B   : params.ParamByName('UnTipoTrabajo').Value := UNA_NCDESCUENTO_B;
          Medicion        : params.ParamByName('UnTipoTrabajo').Value := UNA_MEDICION;
          TAmarilla       : params.ParamByName('UnTipoTrabajo').Value := UNA_TAMARILLA;
          InformeGNC      : params.ParamByName('UnTipoTrabajo').Value := UN_INFORMEGNC;
          Factura_A_GNC   : params.ParamByName('UnTipoTrabajo').Value := UNA_FACTURA_A_GNC;
          Factura_B_GNC   : params.ParamByName('UnTipoTrabajo').Value := UNA_FACTURA_B_GNC;
          Nota_A_GNC      : params.ParamByName('UnTipoTrabajo').Value := UNA_NOTA_A_GNC;
          Nota_B_GNC      : params.ParamByName('UnTipoTrabajo').Value := UNA_NOTA_B_GNC;
        end;
        params.ParamByName('UnCodigoTrabajo').Value := UnaSolicitud.iHandle;

        {$IFDEF TRAZAS}
          fTrazas.PonComponente(TRAZA_SQL,1,FICHERO_ACTUAL,QryTrabajosListosTTRABAIMPRE);
        {$ENDIF}
        SetProvider(dspQryTrabajosListosTTRABAIMPRE);
        aux := sdsQryTrabajosListosTTRABAIMPRE.CommandText;
        Open;
        Application.ProcessMessages;
        result := RecordCount;
      end;
    except
      on E : Exception do
      begin
        QryTrabajosListosTTRABAIMPRE.Close;
        result := -1;
        sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_TRABAJOS_EN_COLA;
        FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
        fAnomalias.PonAnotacion(TRAZA_SIEMPRE, 10, FICHERO_ACTUAL, LITERAL_ERROR_SERVIDOR_IMPRESION_OBTENIENDO_PRIMERO_COLA + E.message);
      end;
    end;
  finally
    QryTrabajosListosTTRABAIMPRE.Close;
  end;
end;



{ ************************************************************************************* }


function ImpresoraEstaOciosaPara ( const UnaSolicitud : tSolicitud ) : LONGINT;
{Devuelve un:
    0 : Si La impresora a la que hay que enviar el trabajo esta lista para
        para imprimir sin tener que cambiar papel;

    1: Esta lista para imprimir pero hay que cambiar papel;

   -1: No esta lista.}
const
  NINGUNO = 0;
  UNO = 1;
var
  iTrabajosEnCola : Integer;
  UnaImpresora : tImpresorasPampa;
begin
//  result := -1;
UnaImpresora := nil;
  case UnaSolicitud.iSolicitud of
    Informe, InformeDiferido: UnaImpresora := ImpresorasEnPampa[IMPRESORA_PARA_INFORMES];
    Certificado: UnaImpresora := ImpresorasEnPampa[IMPRESORA_PARA_CERTIFICADOS];
    tFactura_A, Nota_A, NCDescuento_A, factura_A_GNC, Nota_A_GNC: UnaImpresora := ImpresorasEnPampa[IMPRESORA_PARA_FACTURAS_A];
    tFactura_B, Nota_B, NCDescuento_B, factura_B_GNC, Nota_B_GNC: UnaImpresora := ImpresorasEnPampa[IMPRESORA_PARA_FACTURAS_B];
    Medicion: UnaImpresora := ImpresorasEnPampa[IMPRESORA_PARA_MEDICIONES];  //AGRE RAN MEDI
    TAmarilla : UnaImpresora := ImpresorasEnPampa[IMPRESORA_PARA_TAMARILLA];
    InformeGNC : UnaImpresora := ImpresorasEnPampa[IMPRESORA_PARA_INFORMESGNC];
  end;

iTrabajosEnCola := DatosImpresio.ColaDeTrabajos(UnaSolicitud);

if (iTrabajosEnCola = NINGUNO) then
  begin
    if not (NecesitaCambioDePapel(UnaImpresora)) then
      result := 0
    else
      result := 1;
  end
else
  if (iTrabajosEnCola >= UNO ) then
    begin
      if not (NecesitaCambioDePapel(UnaImpresora)) then
        result := 0
      else
        //result := -1;  //Orig.
        result := 1; //Pruebas Buenas Lucho
      end
  else
    result := -1;
end;

{ ************************************************************************************* }

procedure TDatosImpresion.TimerAtencionSolicitudesaTimer(Sender: TObject);
var
  PrimeraSolicitud : tSolicitud;
//  SiguienteEstado  : tEstadosHandle;
//  bErrores : boolean;
//  i : integer;
begin
//  TIMERIMPRESIONPREPARADOS.ENABLED := FALSE;
  Application.ProcessMessages;

  if Varglobs.bPararProceso then
    begin
    //TimerAtencionSolicitudes.Enabled := False;
    if FrmPrinters <> nil then
      FrmPrinters.Estado;
    end
  else
    begin
      if FrmPrinters <> nil then
        FrmPrinters.Estado;
        //TimerAtencionSolicitudes.Enabled := False;
        PrimeraSolicitud := PrimerTrabajoDeLaCola;
        case PrimeraSolicitud.iHandle of
          0: { No hay trabajos, de momento no se hace nada };
          -1: { Error con la Base de datos, no se hace nada };
        else
          begin
            case ImpresoraEstaOciosaPara(PrimeraSolicitud) of
            { Hay que poner a preparado el trabajo }
            0: PrepararSolicitud (PrimeraSolicitud.iHandle, ord(HPreparado));
            { Hay que poner a esperando por papel el trabajo }
            1: PrepararSolicitud (PrimeraSolicitud.iHandle, ord(HEsperando_xx_Papel));
            { Hay que poner el trabajo el ultimo de la cola, de momento no hay prioridades }
           -1: PonerUltimoDeLaCola(PrimeraSolicitud.iHandle);
          end;
        end;
    end;
    //TimerAtencionSolicitudes.Enabled := True;
  end;
  ////TIMERIMPRESIONPREPARADOS.ENABLED := TRUE;
end;

{ ************************************************************************************* }

procedure TDatosImpresion.PonerUltimoDeLaCola ( const iUnHandle: LONGINT );
const
  NINGUNO = 0;
  UNO = 1;
var
  sLiteralError : string;
{ Pone la Primera solicitud de la cola a preparado, o Esperando por papel }
begin
  try
    with QryLockTTRABAIMPRE do
    begin
      Close;
      Params[0].Value := iUnHandle;

      {$IFDEF TRAZAS}
        fTrazas.PonComponente(TRAZA_SQL,1,FICHERO_ACTUAL,QryLockTTRABAIMPRE);
      {$ENDIF}

      Open;
      Application.ProcessMessages;

      case RecordCount of
       {
        LOS UNICOS VALORES POSIBLES SON
        0 -> NO EXISTE,
        1 -> EXISTE, OTRO ES IMPOSIBLE PUES ROMPERIAN LAS RESTRICCIONES DEFINIDAS
       }

       NINGUNO:
          raise EBorradoElRegistro.Create('LA SOLICITUD: ' + IntToStr(iUnHandle) + ' HA DESAPARECIDO DEL SERVIDOR');


       UNO:
         if Fields[0].AsInteger <> ord(HEsperando_xx_Atencion) then
         begin
           PuestoAUltimoOk(iUnHandle);
           raise ETransformadoMientrasDormia.Create('LA SOLICITUD: ' + IntToStr(iUnHandle) + ' HA SIDO ALTERADA PREVIAMENTE DEL ESTADO DE ESPERA(1) AL ESTADO ' + Fields[0].AsString + ' DESDE EL CLIENTE')
         end;
         else begin
           PuestoAUltimoOk(iUnHandle);
         end;

      end;
    end;
  except
    on E: Exception do
    begin
      if E.ClassType = EBorradoElRegistro then
      begin
        sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_TRABAJO_BORRADO;
        FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
        fIncidencias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, sLiteralError + E.Message);
      end
      else if E.ClassType = ETransformadoMientrasDormia then
           begin
             sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_TRABAJO_MODIFICADO;
             FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
             fIncidencias.PonAnotacion(TRAZA_SIEMPRE,1,FICHERO_ACTUAL, sLiteralError + E.Message);
           end
           else if E.ClassType = EDataBaseError then { bloqueado el registro }
                begin
                  if Pos(REGISTRO_BLOQUEADO, E.Message) <> 0 then
                  begin
                    sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_TRABAJO_MODIFICADO;
                    FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
                    fIncidencias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL, sLiteralError + E.Message);
                  end
                  else begin
                    sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_ERROR_BD;
                    FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
                    fIncidencias.PonAnotacion(TRAZA_SIEMPRE,3,FICHERO_ACTUAL, sLiteralError + E.Message);
                  end
                end
                else begin
                  sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_ERROR_GENERAL;
                  FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
                  fIncidencias.PonAnotacion(TRAZA_SIEMPRE,4,FICHERO_ACTUAL, sLiteralError + E.Message);
                end;
      QryLockTTRABAIMPRE.Close;
    end;
  end;
end;

{ ************************************************************************************* }

function TDatosImpresion.CambiarEstadoSolicitudOk (const iUnEstado, iUnHandle : LONGINT) : boolean;
begin
  result := True;
  try
    with QryUpdateTTRABAIMPRE do
    begin
      Close;
      params.ParamByName('UnNuevoEstado').Value := iUnEstado;
      params.ParamByName('UnCodigoTrabajo').Value := iUnHandle;
      Execute;
      Application.ProcessMessages;
      Close;
    end;
  except
    on E : Exception do
    begin
//      result := False;
      QryUpdateTTRABAIMPRE.Close;
      raise;
    end;
  end;
end;

{ ************************************************************************************* }

function TDatosImpresion.PuestoAUltimoOk( const iUnHandle : LONGINT) : boolean;
begin
  result := True;
  try
    with QryPonerUltimoTTRABAIMPRE do
    begin
      Close;
      params.ParamByName('UnCodigoTrabajo').Value := iUnHandle;
      Execute;
      Application.ProcessMessages;
      Close;
    end;
  except
    on E : Exception do
    begin
//      result := False;
      QryUpdateTTRABAIMPRE.Close;
      raise;
    end;
  end;
end;

{ *********************************************************************************** }

procedure TDatosImpresion.TimerRefrescoSolicitudesaTimer(Sender: TObject);
//var
//  i : integer;
//  bErrores : Boolean;
begin
  try
    //(Sender as TTimer).Enabled := False;
    Application.ProcessMessages;
    if FrmPrinters <> nil then FrmPrinters.Refresco;
//    TestDeImpresionOk;
  finally
   //(Sender as TTimer).Enabled := True;
  end;
end;


{ *********************************************************************************** }


function TDatosImpresion.CanceladaSolicitudOk ( const iUnHandle : LONGINT; var iMotivo: LONGINT) : boolean;
{ Borra una solicitud sel servidor de impresion, sea cual sea su estado, a no
  ser que haya terminado. Simepre que se llama a esta funcion, el estado
  del handle es de no terminado}
const
  NINGUNO = 0;
  UNO = 1;
begin
result := True;
try
  with QryLockTTRABAIMPRE do
    begin
    Close;
    Params[0].Value :=  iUnHandle;
    Open;
    Application.ProcessMessages;
    case RecordCount of
      {LOS UNICOS VALORES POSIBLES SON
         0 -> NO EXISTE,
         1 -> EXISTE, OTRO ES IMPOSIBLE PUES ROMPERIAN LAS RESTRICCIONES DEFINIDAS}
        NINGUNO:
          raise EBorradoElRegistro.Create('LA SOLICITUD: ' + IntToStr(iUnHandle) + ' HA DESAPARECIDO DEL SERVIDOR, O HA TERMINADO');
        UNO: BorrarSolicitud(iUnHandle);
      end;
    end;
  except
    on E: Exception do
    begin
      if E.ClassType = EBorradoElRegistro then
      begin
        { NO HAY ERROR, PERO EL REGISTRO FUE YA BORRADO DESDE EL CLIENTE O HA TERMINADO }
        result := False;
        iMotivo := INCIDENCIA_BORRADA;
        fIncidencias.PonAnotacion(TRAZA_SIEMPRE,5,FICHERO_ACTUAL,E.message);
      end
      else if E.ClassType = EDataBaseError then
           begin
             if Pos(REGISTRO_BLOQUEADO, E.Message) <> 0 then
             begin
               result := False; { No puede borrarse porque el servidor de impresion esta con el}
               iMotivo := INCIDENCIA_BLOQUEADA;
               fIncidencias.PonAnotacion(TRAZA_SIEMPRE,6,FICHERO_ACTUAL, 'No se puede cancelar ' + IntToStr(iUnHandle) + ' por: ' + E.message);
             end
            else begin
              result := False;
              iMotivo := INCIDENCIA_BD;
              fIncidencias.PonAnotacion(TRAZA_SIEMPRE,7,FICHERO_ACTUAL, 'No se puede cancelar ' + IntToStr(iUnHandle) + ' por: ' + E.message);
              { que salte por otro lado, al borrar por ejemplo }
            end;
           end
           else begin
             result := False;
             iMotivo := INCIDENCIA_RARA;
             fIncidencias.PonAnotacion(TRAZA_SIEMPRE,8,FICHERO_ACTUAL, 'No se puede cancelar ' + IntToStr(iUnHandle) + ' por: ' + E.message);
           end;
    end;
  end;

end;

{ *********************************************************************************** }


procedure  TDatosImpresion.BorrarSolicitud (const iUnHandle : LONGINT);
{ Borra el trabajo del servidor de impresion si todav�a existe,
  si se produce una excepcion la replica para que la detecte
  el procedimiendo de Cancelacion OK }
begin
  try
    With TSQLQuery.Create(self) do
      try
        Begin
          Close;
          SQLConnection:=MyBD;
          SQL.Clear;
          SQL.CommaText:=('DELETE FROM TTRABAIMPRE WHERE CODTRABA = :CODTRABA');
          Params[0].Value:=iUnHandle;
          ExecSQL;
        end;
      except
        on E : Exception do
          begin
            fAnomalias.PonAnotacion(TRAZA_SIEMPRE,11,FICHERO_ACTUAL,'No se ha podido borrar el trabajo de impresion: ' +
            IntToSTr(iUnHandle) + ' Por: ' + E.message);
            raise;
          end;
      end;
  finally
    free;
  end;
end;

{ *********************************************************************************** }

function TDatosImpresion.PrimerTrabajoPreparado : tPaqueteDeSolicitud;
var
  sLiteralError : string;
  sTipoSolicitud : integer;
begin
 { Obtiene la solicitud mas antigua preparada de la tabla TTrabaimpre
   devuelve un 0 si no hay trabajos en la cola y un -1 si surge
   alg�n error }
  try
    result.iHandle := 0;
    with QryPrimerPreparadoTTRABAIMPRE do
    begin
      Close;
      Open;
      Application.ProcessMessages;
      if RecordCount > 0 then
      begin
        result.iHandle := Fields[0].AsInteger;
        sTipoSolicitud := Fields[1].AsInteger;
        case sTipoSolicitud of
          UN_CERTIFICADO      : result.dPeticion.iServicio := Certificado;
          UN_INFORME          : result.dPeticion.iServicio := Informe;
          UN_INFORME_DIFERIDO : result.dPeticion.iServicio  := InformeDiferido;
          UNA_FACTURA_A       : result.dPeticion.iServicio  := tFactura_A;
          UNA_FACTURA_B       : result.dPeticion.iServicio := tFactura_B;
          UNA_NOTA_A          : result.dPeticion.iServicio := Nota_A;
          UNA_NOTA_B          : result.dPeticion.iServicio  := Nota_B;
          UNA_NCDESCUENTO_A   : result.dPeticion.iServicio  := NCDescuento_A;
          UNA_NCDESCUENTO_B   : result.dPeticion.iServicio  := NCDescuento_B;
          UNA_MEDICION        : Result.dPeticion.iServicio := Medicion; //AGRE RAN MEDI
          UNA_TAMARILLA       : Result.dPeticion.iServicio := TAmarilla;
          UN_INFORMEGNC       : Result.dPeticion.iServicio := InformeGNC;
          UNA_FACTURA_A_GNC   : result.dPeticion.iServicio  := Factura_A_GNC;
          UNA_FACTURA_B_GNC   : result.dPeticion.iServicio := Factura_B_GNC;
          UNA_NOTA_A_GNC      : result.dPeticion.iServicio := Nota_A_GNC;
          UNA_NOTA_B_GNC      : result.dPeticion.iServicio  := Nota_B_GNC;
          else
            raise
            ESolicitudDeTrabajoDesconocida.Create (' El tipo de solicitud no es valido: ' + inttostr(sTipoSolicitud));
        end;
        result.dPeticion.dCabecera.iEjercicio := Fields[2].AsInteger;
        result.dPeticion.dCabecera.iCodigoInspeccion :=  Fields[3].AsInteger;
        result.dPeticion.dCabecera.sMatricula := Fields[4].AsString;
      end;
      Close;
    end;
  except
    on E : Exception do
    begin
      QryPrimerTrabajoTTRABAIMPRE.Close;
      result.iHandle := -1;
      sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_OBTENIENDO_PRIMERO_PREPARADO;
      FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
      fAnomalias.PonAnotacion(TRAZA_SIEMPRE, 12, FICHERO_ACTUAL, LITERAL_ERROR_SERVIDOR_IMPRESION_OBTENIENDO_PRIMERO_PREPARADO + E.message);
    end;
  end;
end;


{ *********************************************************************************** }



{ *********************************************************************************** }

function TDatosImpresion.AImprimiendoseSolicitudOk ( const iUnHandle, iUnEstado : LONGINT ) : boolean;
{UNA SOLICITUD QUE ESTA PREPRADA LA PASA A IMPRIMIENDOSE PARA QUE EL CLIENTE NO PUEDE BORRARLA
 MIENTRAS SE OBTIENEN SUS DATOS}

const
  NINGUNO = 0;
  UNO = 1;
 { Pone la Primera solicitud de la cola de preparados, a Imprimiendose }
var
  sLiteralError : string;
begin
  result := True;
  try
    with QryLockTTRABAIMPRE do
    begin
      Close;
      Params[0].Value := iUnHandle;
      Open;
      Application.ProcessMessages;
      case RecordCount of
       {
        LOS UNICOS VALORES POSIBLES SON
        0 -> NO EXISTE,
        1 -> EXISTE, OTRO ES IMPOSIBLE PUES ROMPERIAN LAS RESTRICCIONES DEFINIDAS
       }

       NINGUNO:
          raise EBorradoElRegistro.Create('LA SOLICITUD: ' + IntToStr(iUnHandle) + ' HA DESAPARECIDO DEL SERVIDOR, CUANDO SE IBA A PREPAR EL TRABAJO');


       UNO:
         if Fields[0].AsInteger <> ord(HPreparado) then
         begin
           CambiarEstadoSolicitudOk(iUnEstado, Fields[0].AsInteger); { Para liberar el recurso }
           raise
           ETransformadoMientrasDormia.Create('LA SOLICITUD: ' + IntToStr(iUnHandle) + ' HA SIDO ALTERADA PREVIAMENTE DEL ESTADO DE ESPERA(1) AL ESTADO ' + Fields[0].AsString + ' DESDE EL CLIENTE')
         end
         else
         cambiarEstadoSolicitudOk(iUnEstado, iUnHandle)
      end;
    end;
  except
    on E: Exception do
    begin
      if E.ClassType = EBorradoElRegistro then
      begin
        sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_TRABAJO_BORRADO;
        FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
        fIncidencias.PonAnotacion(TRAZA_SIEMPRE,9,FICHERO_ACTUAL, 'PASANDO A IMPRIMIENDOSE ' + sLiteralError + E.Message);
      end
      else if E.ClassType = ETransformadoMientrasDormia then
           begin
             sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_TRABAJO_MODIFICADO;
             FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
             fIncidencias.PonAnotacion(TRAZA_SIEMPRE,10,FICHERO_ACTUAL, 'PASANDO A IMPRIMIENDOSE ' + sLiteralError + E.Message);
           end
           else if E.ClassType = EDataBaseError then { bloqueado el registro }
                begin
                  if Pos(REGISTRO_BLOQUEADO, E.Message) <> 0 then
                  begin
                    sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_TRABAJO_MODIFICADO;
                    FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
                    fIncidencias.PonAnotacion(TRAZA_SIEMPRE,11,FICHERO_ACTUAL, 'PASANDO A IMPRIMIENDOSE ' + sLiteralError + E.Message);
                  end
                  else begin
                    sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_ERROR_BD;
                    FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
                    fIncidencias.PonAnotacion(TRAZA_SIEMPRE,12,FICHERO_ACTUAL, 'PASANDO A IMPRIMIENDOSE ' + sLiteralError + E.Message);
                  end
                end
                else begin
                  sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_ERROR_GENERAL;
                  FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
                  fIncidencias.PonAnotacion(TRAZA_SIEMPRE,13,FICHERO_ACTUAL, 'PASANDO A IMPRIMIENDOSE ' + sLiteralError + E.Message);
                end;
      QryLockTTRABAIMPRE.Close;
      result := False;
    end;
  end;
end;

{ *********************************************************************************** }

procedure TDatosImpresion.PrepararSolicitud ( const iUnHandle, iUnEstado : LONGINT );

const
  NINGUNO = 0;
  UNO = 1;
 { Pone la Primera solicitud de la cola a preparado, o Esperando por papel }
var
  sLiteralError : string;
begin
  try
    with QryLockTTRABAIMPRE do
    begin
      Close;
      Params[0].Value := iUnHandle;
      Open;
      Application.ProcessMessages;
      case RecordCount of
       {
        LOS UNICOS VALORES POSIBLES SON
        0 -> NO EXISTE,
        1 -> EXISTE, OTRO ES IMPOSIBLE PUES ROMPERIAN LAS RESTRICCIONES DEFINIDAS
       }

       NINGUNO:
          raise EBorradoElRegistro.Create('LA SOLICITUD: ' + IntToStr(iUnHandle) + ' HA DESAPARECIDO DEL SERVIDOR, CUANDO SE IBA A PREPAR EL TRABAJO');


       UNO:
         if Fields[0].AsInteger <> ord(HEsperando_xx_Atencion) then
         begin
           CambiarEstadoSolicitudOk(iUnEstado, Fields[0].AsInteger); { Para liberar el recurso }
           raise ETransformadoMientrasDormia.Create('LA SOLICITUD: ' + IntToStr(iUnHandle) + ' HA SIDO ALTERADA PREVIAMENTE DEL ESTADO DE ESPERA(1) AL ESTADO ' + Fields[0].AsString + ' DESDE EL CLIENTE')
         end
         else CambiarEstadoSolicitudOk(iUnEstado, iUnHandle)

      end;
    end;
  except
    on E: Exception do
    begin
      if E.ClassType = EBorradoElRegistro then
      begin
        sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_TRABAJO_BORRADO;
        FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
        fIncidencias.PonAnotacion(TRAZA_SIEMPRE,14,FICHERO_ACTUAL, 'PASANDO A PREPARADO ' + sLiteralError + E.Message);
      end
      else if E.ClassType = ETransformadoMientrasDormia then
           begin
             sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_TRABAJO_MODIFICADO;
             FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
             fIncidencias.PonAnotacion(TRAZA_SIEMPRE,15,FICHERO_ACTUAL, 'PASANDO A PREPARADO ' + sLiteralError + E.Message);
           end
           else if E.ClassType = EDataBaseError then { bloqueado el registro }
                begin
                  if Pos(REGISTRO_BLOQUEADO, E.Message) <> 0 then
                  begin
                    sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_TRABAJO_MODIFICADO;
                    FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
                    fIncidencias.PonAnotacion(TRAZA_SIEMPRE,16,FICHERO_ACTUAL, 'PASANDO A PREPARADO ' + sLiteralError + E.Message);
                  end
                  else begin
                    sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_ERROR_BD;
                    FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
                    fIncidencias.PonAnotacion(TRAZA_SIEMPRE,17,FICHERO_ACTUAL, 'PASANDO A PREPARADO ' + sLiteralError + E.Message);
                  end
                end
                else begin
                  sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_ERROR_GENERAL;
                  FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
                  fIncidencias.PonAnotacion(TRAZA_SIEMPRE,18,FICHERO_ACTUAL, 'PASANDO A PREPARADO ' + sLiteralError + E.Message);
                end;
      QryLockTTRABAIMPRE.Close;
    end;
  end;
end;

{ *********************************************************************************** }

function TDatosImpresion.ATerminadoSolicitudOk ( const iUnHandle, iUnEstado : LONGINT ) : boolean;
{UNA SOLICITUD QUE ESTA IMPRIMENDOSE LA PASA A TERMINADA PARA QUE EL CLIENTE LA BORRE
  Y TERMINE}

const
  NINGUNO = 0;
  UNO = 1;
 { Pone la Primera solicitud de la cola de preparados, a Imprimiendose }
var
  sLiteralError : string;
  bTerminado : boolean;
begin
  result := False;
  bTerminado := False;
  repeat
    try
      with QryLockTTRABAIMPRE do
      begin
        Close;
        Params[0].Value := iUnHandle;
        Open;
        Application.ProcessMessages;
        case RecordCount of
         { LOS UNICOS VALORES POSIBLES SON
          0 -> NO EXISTE,
          1 -> EXISTE, OTRO ES IMPOSIBLE PUES ROMPERIAN LAS RESTRICCIONES DEFINIDAS
         }

         NINGUNO:
            {raise EBorradoElRegistro.Create('LA SOLICITUD: ' + IntToStr(iUnHandle) + ' HA DESAPARECIDO DEL SERVIDOR, CUANDO SE IBA A PREPAR EL TRABAJO')};


         UNO:
           if Fields[0].AsInteger <> ord(HImprimiendose) then
           begin
             CambiarEstadoSolicitudOk(iUnEstado, Fields[0].AsInteger); { Para liberar el recurso }
             raise ETransformadoMientrasDormia.Create('LA SOLICITUD: ' + IntToStr(iUnHandle) + ' HA SIDO ALTERADA PREVIAMENTE DEL ESTADO DE ESPERA(1) AL ESTADO ' + Fields[0].AsString + ' DESDE EL CLIENTE')
           end
           else result := CambiarEstadoSolicitudOk(iUnEstado, iUnHandle);

        end;
        bTerminado := True;
      end;
    except
        on E: Exception do
        begin
            if E.ClassType = EBorradoElRegistro
            then begin
//                result := False;
                bTerminado := True;
                sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_TRABAJO_BORRADO;
                FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
                fIncidencias.PonAnotacion(TRAZA_SIEMPRE,19,FICHERO_ACTUAL, 'PASANDO A TERMINADO ' + sLiteralError + E.Message);
            end
            else if E.ClassType = ETransformadoMientrasDormia
                then begin
                    bTerminado := True;
//                    result := False;
                    sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_TRABAJO_MODIFICADO;
                    FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
                    fIncidencias.PonAnotacion(TRAZA_SIEMPRE,20,FICHERO_ACTUAL, 'PASANDO A TERMINADO ' + sLiteralError + E.Message);
                end
                else if E.ClassType = EDataBaseError
                    then begin{ bloqueado el registro }
                        if Pos(REGISTRO_BLOQUEADO, E.Message) <> 0
                        then begin
                            bTerminado := False;
                            sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_TRABAJO_MODIFICADO;
                            FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
                            fIncidencias.PonAnotacion(TRAZA_SIEMPRE,21,FICHERO_ACTUAL, 'PASANDO A TERMINADO ' + sLiteralError + E.Message);
                        end
                        else begin
                            bTerminado := True;
//                            result := False;
                            sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_ERROR_BD;
                            FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
                            fIncidencias.PonAnotacion(TRAZA_SIEMPRE,22,FICHERO_ACTUAL, 'PASANDO A TERMINADO ' + sLiteralError + E.Message);
                        end
                    end
                    else begin
                        bTerminado := True;
//                        result := False;
                        sLiteralError := LITERAL_ERROR_SERVIDOR_IMPRESION_ERROR_GENERAL;
                        FrmSucesos.MemoErrores.Lines.Add( DateTimeToStr(now) + ' ' + sLiteralError);
                        fIncidencias.PonAnotacion(TRAZA_SIEMPRE,23,FICHERO_ACTUAL, 'PASANDO A TERMINADO ' + sLiteralError + E.Message);
                    end;
            result := CambiarEstadoSolicitudOk(iUnEstado, iUnHandle);
            QryLockTTRABAIMPRE.Close;
        end;
    end;
  until bTerminado;
end;


procedure TDatosImpresion.TimerImpresionPreparadosaTimer(Sender: TObject);

{ CUANDO DECIMOS IMPRIMIR SIGNIFICA CALCULO DE DATOS ANTES DE ENVIARLOS
  A IMPRESORA
}

var
  PrimerTrabajo : tPaqueteDeSolicitud;
begin
////  TIMERATENCIONSOLICITUDES.ENABLED := FALSE;

  Application.ProcessMessages;

  if Varglobs.bPararProceso then
  begin
    //TimerImpresionPreparados.Enabled := False;
    if FrmPrinters <> nil then FrmPrinters.Estado;
  end
  else begin

    if FrmPrinters <> nil then FrmPrinters.Estado;
    //TimerImpresionPreparados.Enabled := False;
    PrimerTrabajo := PrimerTrabajoPreparado;

    case PrimerTrabajo.iHandle of
       0: { No hay trabajos, de momento no se hace nada };
      -1: { Error con la Base de datos, no se hace nada };
       else begin
         if AImprimiendoseSolicitudOk(PrimerTrabajo.iHandle, ord(HImprimiendose)) then
         begin

           with PrimerTrabajo.dPeticion.dCabecera, PrimerTrabajo.dPeticion do
           begin
             case iServicio of
               Certificado: begin
                 ImprimirCertificado ( PrimerTrabajo.iHandle, iEjercicio, iCodigoInspeccion,
                                       ImpresorasEnPampa[IMPRESORA_PARA_CERTIFICADOS]);

               end;

               Informe: begin
                 ImprimirInforme ( PrimerTrabajo.iHandle, iEjercicio, iCodigoInspeccion,
                                   ImpresorasEnPampa[IMPRESORA_PARA_INFORMES], True);
               end;

               InformeDiferido: begin
                 ImprimirInforme ( PrimerTrabajo.iHandle, iEjercicio, iCodigoInspeccion,
                                   ImpresorasEnPampa[IMPRESORA_PARA_INFORMES], False);

               end;

               tFactura_A: begin
                  ImprimirFacturaA ( PrimerTrabajo.iHandle, iEjercicio, iCodigoInspeccion,
                                     ImpresorasEnPampa[IMPRESORA_PARA_FACTURAS_A],
                                     False);
               end;

               tFactura_B: begin
                  ImprimirFacturaB ( PrimerTrabajo.iHandle, iEjercicio, iCodigoInspeccion,
                                     ImpresorasEnPampa[IMPRESORA_PARA_FACTURAS_B],
                                     False);
               end;

               Factura_A_GNC: begin
                  ImprimirFacturaAGNC ( PrimerTrabajo.iHandle, iEjercicio, iCodigoInspeccion,
                                     ImpresorasEnPampa[IMPRESORA_PARA_FACTURAS_A],
                                     False);
               end;

               Factura_B_GNC: begin
                  ImprimirFacturaBGNC ( PrimerTrabajo.iHandle, iEjercicio, iCodigoInspeccion,
                                     ImpresorasEnPampa[IMPRESORA_PARA_FACTURAS_B],
                                     False);
               end;


               Nota_A: begin
                  ImprimirFacturaA ( PrimerTrabajo.iHandle, iEjercicio, iCodigoInspeccion,
                                     ImpresorasEnPampa[IMPRESORA_PARA_FACTURAS_A],
                                     True);

               end;

               Nota_B: begin
                  ImprimirFacturaB ( PrimerTrabajo.iHandle, iEjercicio, iCodigoInspeccion,
                                     ImpresorasEnPampa[IMPRESORA_PARA_FACTURAS_B],
                                     True);

               end;

               Nota_A_GNC: begin
                  ImprimirFacturaAGNC ( PrimerTrabajo.iHandle, iEjercicio, iCodigoInspeccion,
                                     ImpresorasEnPampa[IMPRESORA_PARA_FACTURAS_A],
                                     True);

               end;

               Nota_B_GNC: begin
                  ImprimirFacturaBGNC ( PrimerTrabajo.iHandle, iEjercicio, iCodigoInspeccion,
                                     ImpresorasEnPampa[IMPRESORA_PARA_FACTURAS_B],
                                     True);

               end;


               NCDescuento_A: begin
                  ImprimirNCDescuentoA ( PrimerTrabajo.iHandle, iEjercicio, iCodigoInspeccion,
                                     ImpresorasEnPampa[IMPRESORA_PARA_FACTURAS_A],
                                     False);
               end;

               NCDescuento_B: begin
                  ImprimirNCDescuentoB ( PrimerTrabajo.iHandle, iEjercicio, iCodigoInspeccion,
                                     ImpresorasEnPampa[IMPRESORA_PARA_FACTURAS_B],
                                     False);
               end;

               Medicion: begin
                  ImprimirMediciones ( PrimerTrabajo.iHandle, iEjercicio, iCodigoInspeccion,
                                   ImpresorasEnPampa[IMPRESORA_PARA_MEDICIONES], False);
               end;

               TAmarilla: begin
                  ImprimirTAmarilla ( PrimerTrabajo.iHandle, iEjercicio, iCodigoInspeccion,
                                       ImpresorasEnPampa[IMPRESORA_PARA_TAMARILLA]);

               end;

               InformeGNC: begin
                  ImprimirInformeGNC ( PrimerTrabajo.iHandle, iEjercicio, iCodigoInspeccion,
                                       ImpresorasEnPampa[IMPRESORA_PARA_INFORMESGNC]);
               end;

               else begin
                 fIncidencias.PonAnotacion(TRAZA_SIEMPRE,24,FICHERO_ACTUAL,'Trabajo desconocido' + IntToStr(PrimerTrabajo.iHandle));
               end
             end;

           end;
         end
         else begin
           fIncidencias.PonAnotacion(TRAZA_SIEMPRE,25,FICHERO_ACTUAL,'Trabajo no pudo ponerse a Imprimiendose ' + IntToStr(PrimerTrabajo.iHandle));
         end;
       end;
    end;
    //TimerImpresionPreparados.Enabled := True;
  end;
  ////  TIMERATENCIONSOLICITUDES.ENABLED := FALSE;
end;


{***************************************************************************}

 function Devolver_2UltimosDigitosAnio(iEjerc: word): byte;
{ Devuelve los dos �ltimos d�gitos de un a�o. Ej.: dado 1996 devuelve 96 }
 begin
     Result := iEjerc mod 100;
 end;

 { *********************************************************************** }

 function Calcular_NumeroInspeccion (const Ejer:longint;
               const DatVar_Zona: LONGINT; const DatVar_Estacion: LONGINT;
               const CodInsp: longint; const Reverif: string): string;

var
  InspTemp: string; { Almacena de forma temporal el n� inspecci�n }

begin { de Calcular_NumeroInspeccion }
    InspTemp := Format ('%1.2d %1.4d%1.4d%1.6d', [Devolver_2UltimosDigitosAnio
                (Ejer), DatVar_Zona, DatVar_Estacion, CodInsp]);
    { Hay que comprobar si se trata de una reverificaci�n }
    if (Reverif = CARACTER_REVERIFICACION) then
      InspTemp := InspTemp + ' ' + CARACTER_REVERIFICACION;
    Result := InspTemp;
end; { de Calcular_NumeroInspeccion }



procedure TDatosImpresion.DatosImpresionDestroy(Sender: TObject);
var
    i: integer;
begin
    for I := 0 to ComponentCount - 1 do
        if Components[I] is TClientDataSet
        then TClientDataSet(Components[I]).Close
        else if Components[I] is TSQLDataSet
            then TSQLDataSet(Components[I]).Close;

    DatosImpresio := nil;
end;

end.
