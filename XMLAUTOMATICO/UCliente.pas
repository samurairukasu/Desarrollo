unit UCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, UCDialgs,
  ExtCtrls, StdCtrls, Buttons, DB, SQLExpr, UCTImpresion, FMTBcd, Globals,
  Provider, DBClient, SimpleDS;

const
  FICHERO_ACTUAL = 'UCLIENTE.PAS';



type
  TFichaCliente = class(TForm)
    BtnCancelarGeneral: TBitBtn;
    Shape1: TShape;
    Image0: TImage;
    Image3: TImage;
    Image2: TImage;
    Image1: TImage;
    TimerImage: TTimer;
    Image: TPaintBox;
    TimerCortesiaBorrado: TTimer;
    TimerEstadoHandle: TTimer;
    QryUpdateTTRABAIMPRE: TSQLQuery;
    QryDeleteTTRABAIMPRE: TSQLQuery;
    QryInsertTTRABAIMPRE: TSQLQuery;
    QrySelectTTRABAIMPRE: TClientDataSet;
    dspQrySelectTTRABAIMPRE: TDataSetProvider;
    sdsQrySelectTTRABAIMPRE: TSQLDataSet;
    QrySECUENCIADOR: TClientDataSet;
    dspQrySECUENCIADOR: TDataSetProvider;
    sdsQrySECUENCIADOR: TSQLDataSet;
    sdsQryLockTTRABAIMPRE: TSQLDataSet;
    dspQryLockTTRABAIMPRE: TDataSetProvider;
    QryLockTTRABAIMPRE: TClientDataSet;
    MemoEstado: TMemo;

    procedure TimerEstadoHandleTimer(Sender: TObject);
    procedure BtnCancelarGeneralClick(Sender: TObject);
    procedure TimerCortesiaBorradoTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TimerImageTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MemoEstadoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure ImagePaint(Sender: TObject);
  private
    { Private declarations }


    dEstadoCliente : tEstadosCliente; { PAR NO REPETIR DOS ACCIONES }

    dEstadoHandle : tEstadosHandle;
    iImageContador : Integer;
    bPuedeSalir : Boolean;
    bPulsadoCancelar : Boolean;

    dErrorPrinting : tErrorPrinting;
    SolicitudDelCliente : tPaqueteDeSolicitud;

    { CONEXION }
    function SolicitudInterna (const UnServicio: tPeticionDeServicio) : tPaqueteDeSolicitud;
    function EnviadaSolicitud : boolean;


    { ENLACE }
    function TestEstadoSolicitud : tEstadosHandle;
    function CambiarEstadoSolicitudOk (const UnEstado : Integer) : boolean;
    procedure TratadoCambioPapel;
    procedure DejarloAPreparado;


    { DESCONEXION EXPLICITA POR CANCELACION }
    function EsPosibleCancelacion (var iMotivo : integer) : boolean;
    procedure BorrarSolicitud;
    procedure TratadoTerminado;

    { TIMMERS }
    procedure ActivarTestEstadoSolicitud;
    procedure DesactivarTestEstadoSolicitud;
    function DesactivadoTestEstadoSolicitud : boolean;

    procedure ActivarCortesiaDeBorrado;
    procedure DesacitivarCortesiaDeBorrado;


    { INTERFAZ }
    procedure ActualizarInformacionDelUsuario;
    procedure Pinta;


  public
    { Public declarations }
    constructor FormCreateByBD(const aBD : tSQLConnection);
    Procedure UpdatePrintJob(var msg:tmessage);message WM_SERVIMPRE;
  end;


function TrabajoEnviadoOk (const UnaCabecera : tCabecera; const UnTrabajo: tTrabajo) : boolean;
procedure InitClienteImpresion (const aBD : tSQLConnection);

var
  FichaCliente : TFichaCliente = nil;
  bTerminado : boolean;

implementation

{$R *.DFM}


uses
    ULogs;

var
    sTipoTrabajo: String;


           { ********************************************************** }

procedure Espera (const segundos : integer);
const
  UN_SEGUNDO = 116E-7;
var
  ahora : tDateTime;
begin
  ahora := now;
  while now < ahora + (segundos * UN_SEGUNDO) do;
end;

         { ********************************************************** }


function ClienteDeImpresion (const UnServicio : tPeticionDeServicio) : tErrorPrinting;
//var
  //FichaCliente : TFichaCliente;
begin
result.iCodigoError := NO_ERROR_CLIENTE_IMPRESION;
result.sLiteralError := LITERAL_NO_ERROR_CLIENTE_IMPRESION;
  try
//    FichaCliente := TFichaCliente.Create(Application);
  with FichaCliente do
    begin
    {$B-}
    if ((SolicitudInterna(UnServicio).iHandle > 0) and (EnviadaSolicitud)) then
      begin
      // ActivarTestEstadoSolicitud;
      if (ShowModal = mrCancel) then
        begin
          result.iCodigoError  := CANCELADO_POR_CLIENTE;
          result.sLiteralError := LITERAL_NO_ERROR_CLIENTE_IMPRESION;
        end;
      Hide;
      end;
  //result := dErrorPrinting;
  //Free;
    end;
  except
    on E : exception do
    begin
      result.iCodigoError  := ERROR_CLIENTE_IMPRESION_EXECUTING;
      result.sLiteralError := LITERAL_ERROR_CLIENTE_IMPRESION_EXECUTING + E.message;
    end;
  end;
end;

          { ********************************************************** }

constructor TFichaCliente.FormCreateByBD(const aBD: tSQLConnection);
{ En la creacion de la Ficha del cliente:
   - Se preparan los componentes de acceso a la base de datos;
   - Se inicializan todos los demas componentes de la ficha
}
//const
//  TEST_ESTADO_HANDLE = 'TimerEstadoHandle';
//  TEST_BORRADO = 'TimerCortesiaBorrado';
var
i : integer;
begin
(*try

    { Inicializacion de componentes de acceso a la base de datos, enlazandoles
      a la BASE DE DATOS y SESION ABIERTA }

*) inherited Create(Application);
//    try
      for I := 0 to ComponentCount - 1 do
        if Components[I] is TSQLQuery then
        begin
          TSQLQuery(Components[I]).SQLConnection := aBD;
        end
        else
        begin
          if Components[I] is TSQLDataSet then
          begin
            TSQLDataSet(Components[I]).SQLConnection := aBD;
          end
        end;
//    except
//        on E: Exception do
//            InitError('Error generando el Cliente de Impresion: ' + E.Message);
//    end;
  (*    else if Components[I] is TTimer then
           begin
             TTimer(Components[I]).Enabled  := False;
             if (TTimer(Components[I]).Name = TEST_ESTADO_HANDLE) then
                TTimer(Components[I]).Interval := INTERVALO_COMPROBACION_ESTADO_HANDLE
                else TTimer(Components[I]).Interval := INTERVALO_CORTESIA_BORRADO
           end
           else if Components[I] is TMemo then
                begin
                  TMemo(Components[I]).Lines.Clear;
                  TMemo(Components[I]).ReadOnly := True;
                end
                else if Components[I] is TBitBtn then TBitBtn(Components[I]).Enabled := True;




  except
    on E : Exception do
    begin
     dErrorPrinting.iCodigoError := ERROR_CLIENTE_IMPRESION_CREATE;
     dErrorPrinting.sLiteralError := LITERAL_ERROR_CLIENTE_IMPRESION_CREATE + E.message;
     raise;
    end;
  end;
*)
end;

          { ********************************************************** }

procedure TFichaCliente.TimerEstadoHandleTimer(Sender: TObject);
begin
  try
  (Sender as TTimer).Enabled := False;
  Application.ProcessMessages;
  if not bPulsadoCancelar then
    begin
      case TestEstadoSolicitud of
        HEsperando_xx_Papel :
        if dEstadoCliente <> CEsperando_x_Papel then
          TratadoCambioPapel;
        HTerminado: TratadoTerminado;
      end
    end
  else
    DesactivarTestEstadoSolicitud;
  ActualizarInformacionDelUsuario;
  finally
    (Sender as TTimer).Enabled := True;
  Application.ProcessMessages;
  end;
end;

          { ********************************************************** }


procedure TFichaCliente.BtnCancelarGeneralClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  BtnCancelarGeneral.Enabled := False;
  bPulsadoCancelar := True; // Si salto el timer de testeo que no se realice;
  DesactivarTestEstadoSolicitud;
  ActivarCortesiaDeBorrado;
  ActualizarInformacionDelUsuario;
  //BorrarSolicitud;  // <--
  TratadoTerminado; // <--
  Application.ProcessMessages;
end;


function TFichaCliente.SolicitudInterna ( const UnServicio: tPeticionDeServicio ) : tPaqueteDeSolicitud;
{Completa el paquete de solicitud y obtiene el handle correcto del servicio,
  el handle es el codigo del trabajo y ha de ser siempre mayor que 0}
const
  UNICO = 1;
  IMPOSIBLE = 0;
var
  siHandle : string;
begin
  result := SolicitudDelCliente;
  MemoEstado.Text:=LITERAL_ESPERANDO_ATENCION;
  Application.ProcessMessages;
  try
    With QrySecuenciador do
    begin
      Close;
      {$IFDEF TRAZAS}
         FTrazas.PonComponente (TRAZA_SQL, 2, FICHERO_ACTUAL, QrySecuenciador);
      {$ENDIF}
      Open;
      {$IFDEF TRAZAS}
         FTrazas.PonRegistro (TRAZA_SQL, 3, FICHERO_ACTUAL, QrySecuenciador);
      {$ENDIF}
      Application.ProcessMessages;
      {$B-}
      if ((RecordCount <> UNICO) or (Fields[0].isNull) or (Fields[0].AsInteger <= IMPOSIBLE)) then
      begin
        if not Fields[0].IsNull then siHandle := '0'
        else siHandle := Fields[0].AsString;
        raise EHandleIncorrecto.Create('EL HANDLE: ' + siHandle  + ' ES INCORRECTO');
      end
      else begin
        with SolicitudDelCliente do
        begin
          iHandle := Fields[0].AsInteger;
          Close;
          dPeticion := UnServicio;
          Application.ProcessMessages;
        end;
      end;
    end;

    result := SolicitudDelCliente;

  except
    on E : Exception do
    begin
      QrySecuenciador.Close;
      result.iHandle := IMPOSIBLE;
      dErrorPrinting.iCodigoError := ERROR_CLIENTE_IMPRESION_FORMANDO_SOLICITUD;
      dErrorPrinting.sLiteralError := LITERAL_ERROR_CLIENTE_IMPRESION_FORMANDO_SOLICITUD + E.message;
    end;
  end;
end;

          { ********************************************************** }


function TFichaCliente.EnviadaSolicitud : Boolean;
{
  Envia la solicitud al servidor de impresion:

    Insercion en la tabla TTRABAIMPRE, con el manejador del trabajo,
    los datos de cabecera  -matricula, ejercicio y codigo de la inspeccion-,
    el tipo de trabajo, y la hora de la peticion.

    El estado inicial del Handle es el de Espeando_x_Atencion, y el del
    Cliente de Impresion Esperando_x_Papel
 }

begin


  try

    result := True;
    with QryInsertTTRABAIMPRE, SolicitudDelCliente do
      Begin
      If integer(dPeticion.iServicio) in [3,4] then
        Begin
          If SQLConnection.InTransaction then
            SQLConnection.Commit(Td);
        end;
      Close;
      Params[0].Value := iHandle;
      params[1].Value := dPeticion.dCabecera.iEjercicio;
      params[2].Value := dPeticion.dCabecera.iCodigoInspeccion;
      params[3].Value := dPeticion.dCabecera.sMatricula;
      params[4].Value := integer(dPeticion.iServicio);
      {$IFDEF TRAZAS}
       FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QryInsertTTRABAIMPRE);
      {$ENDIF}
      ExecSql;
      Close;
      Application.ProcessMessages;
      end;
    dEstadoCliente := CEsperando_x_Atencion;
    dEstadoHandle :=  HEsperando_xx_Atencion; { LA PRIMERA VEZ SE PONE A CAPON, SIN NECESIDAD DE LEER LA LINEA ANTES }
    Application.ProcessMessages;
    ActualizarInformacionDelUsuario;
  except
    on E : Exception do
    begin
      QryInsertTTRABAIMPRE.Close;
      result := False;
      dErrorPrinting.iCodigoError := ERROR_CLIENTE_IMPRESION_ENVIANDO_SOLICITUD;
      dErrorPrinting.sLiteralError := LITERAL_ERROR_CLIENTE_IMPRESION_ENVIANDO_SOLICITUD + E.message;
//      application.messagebox(pchar(E.message),'',mb_ok);  //**********************
    end;
  end;

  

end;

          { ********************************************************** }

procedure TFichaCliente.ActivarCortesiaDeBorrado;
{ Activa el Timer de Cortesia para Borrar }
begin
  TimerCortesiaBorrado.Enabled := True;
end;


          { ********************************************************** }

procedure TFichaCliente.DesacitivarCortesiaDeBorrado;
{ Desactiva el Timer de Cortesia para Borrar }
begin
  TimerCortesiaBorrado.Enabled := False;
end;

          { ********************************************************** }

procedure TFichaCliente.DesactivarTestEstadoSolicitud;
{ Desactiva el test del estado de la solicitud }
begin
  TimerEstadoHandle.Enabled := False
end;
          { ********************************************************** }

procedure TFichaCliente.ActivarTestEstadoSolicitud;
{ Activa el test del estado de la solicitud }
begin
  TimerEstadoHandle.Enabled := True
end;
          { ********************************************************** }

function TFichaCliente.TestEstadoSolicitud : tEstadosHandle;
const
  NINGUNO = 0;
  UNO = 1;
var
  aux : string;
begin
  try
    dEstadoHandle := HDesconocido;
    try
      with QrySelectTTRABAIMPRE do
      begin
        Close;
        SetProvider(dspQrySelectTTRABAIMPRE);
        aux := CommandText;
        Params.ParamByName('UnCodigoTrabajo').Value := SolicitudDelCliente.iHandle;
        Open;
        case RecordCount of
        {
         LOS UNICOS VALORES POSIBLES SON
           0 -> NO EXISTE,
           1 -> EXISTE, OTRO ES IMPOSIBLE PUES ROMPERIAN LAS RESTRICCIONES DEFINIDAS
        }

          NINGUNO:
            raise EBorradoElRegistro.Create('LA SOLICITUD: ' + IntToStr(SolicitudDelCliente.iHandle) + ' HA DESAPARECIDO DEL SERVIDOR');

          UNO: begin
                case Fields[0].AsInteger of
                  1: dEstadoHandle := HEsperando_xx_Atencion;
                  2: dEstadoHandle := HEsperando_xx_Papel;
                  3: dEstadoHandle := HPreparado;
                  4: begin
                        if sTipoTrabajo = LITERAL_TRABAJO_ENVIADO_IMFORME
                        then dEstadoHandle:=HTerminado
                        else dEstadoHandle:=HImprimiendose;
                    end;
                  5: dEstadoHandle := HTerminado;
                end;
          end;
          else
            raise EDuplicadoElRegistro.Create('LA SOLICITUD: ' + IntToStr(SolicitudDelCliente.iHandle) + ' EST� DUPLICADA EN EL SERVIDOR');
        end;
        Close;
        Application.ProcessMessages;
      end;
    except
      on E : Exception do
      begin
        QrySelectTTRABAIMPRE.Close;

        if E.ClassType = EBorradoElRegistro then dEstadoHandle := HDesaparecido
        else dEstadoHandle := HDesconocido;

        dErrorPrinting.iCodigoError := ERROR_CLIENTE_IMPRESION_COMPROBANDO_ESTADO_SOLICITUD;
        dErrorPrinting.sLiteralError := LITERAL_ERROR_CLIENTE_IMPRESION_COMPROBANDO_ESTADO_SOLICITUD + E.message;
      end;
    end;
  finally
    result := dEstadoHandle;
  end;
end;

          { ********************************************************** }


procedure TFichaCliente.ActualizarInformacionDelUsuario;

var
  sEstadoTrabajo : string;
begin
 // MemoEstado.Clear;
  case SolicitudDelCliente.dPeticion.iServicio of
    Factura_A :          sTipoTrabajo := LITERAL_TRABAJO_ENVIADO_FACTURA_A;
    Nota_A :             sTipoTrabajo := LITERAL_TRABAJO_ENVIADO_NOTA_A;
    Factura_B :          sTipoTrabajo := LITERAL_TRABAJO_ENVIADO_FACTURA_B;
    Nota_B :             sTipoTrabajo := LITERAL_TRABAJO_ENVIADO_NOTA_B;
    Certificado:         sTipoTrabajo := LITERAL_TRABAJO_ENVIADO_CERTIFICADO;
    Informe,
    InformeDiferido :    sTipoTrabajo := LITERAL_TRABAJO_ENVIADO_IMFORME;
    NCDescuento_A :      sTipoTrabajo := LITERAL_TRABAJO_ENVIADO_NCDESCUENTO_A;  //
    NCDescuento_B :      sTipoTrabajo := LITERAL_TRABAJO_ENVIADO_NCDESCUENTO_B;
  end;
  Application.ProcessMessages;
  case dEstadoHandle of
    HDesconocido :            sEstadoTrabajo := LITERAL_ESTADO_DESCONOCIDO;
    HEsperando_xx_Atencion :  sEstadoTrabajo := LITERAL_ESPERANDO_ATENCION;
    HEsperando_xx_Papel   :   sEstadoTrabajo := LITERAL_ESPERANDO_PAPEL;
    HPreparado :              sEstadoTrabajo := LITERAL_PREPARADO;
    HImprimiendose :          sEstadoTrabajo := LITERAL_IMPRIMIENDOSE;
    HTerminado :              sEstadoTrabajo := LITERAL_TERMINADO;
    HDesaparecido :           sEstadoTrabajo := LITERAL_DESAPARECIDO;
  end;
  Application.ProcessMessages;
  MemoEstado.Text:=sTipoTrabajo + sEstadoTrabajo;
  if bPulsadoCancelar then
    Begin
      Application.ProcessMessages;
      MemoEstado.Text:=sTipoTrabajo + sEstadoTrabajo + LITERAL_INTENTANDO_CANCELACION;
    end
  else
    Begin
      MemoEstado.Text:=( sTipoTrabajo + sEstadoTrabajo );
      Application.ProcessMessages;
    end;
end;


procedure TFichaCliente.TimerCortesiaBorradoTimer(Sender: TObject);
var
  iUnMotivo : Integer;
begin
  try
  (Sender as TTimer).Enabled := False;
  iUnMotivo := 0;
  Application.ProcessMessages;
  if DesactivadoTestEstadoSolicitud then
    begin
      DesacitivarCortesiaDeBorrado;
      if EsPosibleCancelacion (iUnMotivo) then
        begin
          ActualizarInformacionDelUsuario;
          Application.ProcessMessages;
          BorrarSolicitud;
          {$IFDEF RETARDO}
          Espera(2);
          {$ENDIF}
          bPuedeSalir := True;
          if dEstadoCliente <> CFin_cn_Incidencias then
            dErrorPrinting.iCodigoError := CANCELADO_POR_CLIENTE;
          //ModalResult := mrOk;
          ModalResult := mrCancel;
        end
      else
        begin
        { EL REGISTRO SE HA CANCELADO }
          case iUnMotivo of
          1:begin
              MessageDlg('Notificacion Del Servidor De Impresi�n',LITERAL_NO_CANCELAR_BLOQUEADO,MtInformation, [mbOk], mbOk,0);
            end;
          2:begin
              MessageDlg('Notificacion Del Serividor De Impresi�n',LITERAL_NO_CANCELAR_IMPRIMIENDOSE, MtInformation, [mbOk], mbOk,0);
            end;
         end;
      BtnCancelarGeneral.Enabled := True;
      bPulsadoCancelar := False;
      ActivarTestEstadoSolicitud;
      ActualizarInformacionDelUsuario;
      Application.ProcessMessages;
    end;
    end;
  finally
    (Sender as TTimer).Enabled := True;
  end;
end;



function TFichaCliente.DesactivadoTestEstadoSolicitud : boolean;
begin
  result := not TimerEstadoHandle.Enabled;
end;


function TFichaCliente.EsPosibleCancelacion (var iMotivo: integer) : boolean;
{ Cuando se cancela la solicitud de impresion, el fin �ltimo es que no se imprima
  dicho trabajo.

  Esta operaci�n puede hacerse siempre que el usuario lo desee, por tanto tiene
  prioridad absoluta.

  Los pasos a seguir siempre son los mismos:

    Bloquear el registro, con el fin de cambiar su estado actual, ( cualquiera
    que sea) al estado de CANCELADO, con el objetivo de no mandarlo a la impresora
    en caso de que su estado fuera ya el de PREPARADO.

    Con Varias Pruebas se ha visto que no es necesario cambiar el estado de la
    solicitud a CANCELADO, basta con bloquear antes que el servidor lo cambie
    a IMPRIMIENDOSE.

    Casos en los que esta operacion no puede realizarse:

      * A : El servidor de impresi�n ha bloqueado antes el registro porque lo
            est� procesando, en este caso dependiendo del estado en que se
            encuentre el cliente se tomar� una accion u otra.

      * B : El estado del trabajo es IMPRIMIENDOSE, por tanto ya no se puede
            cancelar, y se deja como est�.

      * C : El trabajo ha desaparecido, esto indica que el servidor de impresi�n
            ya lo ha borrado, y al usuario no le importa;

}

const
  NINGUNO = 0;
  UNO = 1;
begin
result := True;
  try
    with QryLockTTRABAIMPRE do
    begin
      Close;
      Params[0].Value := SolicitudDelCliente.iHandle;
      Open;
      case RecordCount of
      {LOS UNICOS VALORES POSIBLES SON
         0 -> NO EXISTE,
         1 -> EXISTE, OTRO ES IMPOSIBLE PUES ROMPERIAN LAS RESTRICCIONES DEFINIDAS}
        NINGUNO:
          raise EBorradoElRegistro.Create('LA SOLICITUD: ' + IntToStr(SolicitudDelCliente.iHandle) + ' HA DESAPARECIDO DEL SERVIDOR');
        UNO: case Fields[0].AsInteger of
               4,5 : { Se est� Imprimiendo, o a Terminado ya }
                  if CambiarEstadoSolicitudOk(Fields[0].AsInteger) then
                  begin
                    iMotivo := 2;
                    result := False;
                  end
                  else result := True; { Si no se pudo cambiar el estado hubo error, que salte por otro lado }
               else result := True;    { EN CUALQUIER OTRO ESTADO SE PUEDE BORRAR }
             end;
      end;
    end;
  except
    on E: Exception do
    begin
      if E.ClassType = EBorradoElRegistro then
      begin
        { NO HAY ERROR, PERO EL REGISTRO FUE YA BORRADO DESDE EL SERVIDOR }
        result := True;
        dEstadoCliente := CFin_cn_Incidencias; { EL CLIENTE PASA DE ESTADO }
        dEstadoHandle := HDesaparecido;
        dErrorPrinting.iCodigoError := ERROR_CLIENTE_IMPRESION_CANCELANDO_BORRADA;
        dErrorPrinting.sLiteralError := LITERAL_ERROR_CLIENTE_IMPRESION_BLOQUEANDO_SOLICITUD + E.Message;
      end


{ TODO -oran -cIMPORTANTES : Ver tema errores }
//      else if E.ClassType = EDBEngineError then
      else if E.ClassType = nil then
           begin
             if Pos(REGISTRO_BLOQUEADO, E.Message) <> 0 then
             begin
               result := False; { No puede borrarse porque el servidor de impresion esta con el}
               iMotivo := 1;
             end
            else begin
              result := True;
              { que salte por otro lado, al borrar por ejemplo }
              dErrorPrinting.iCodigoError := ERROR_CLIENTE_IMPRESION_PROBLEMAS_CON_BD;
              dErrorPrinting.sLiteralError := LITERAL_ERROR_CLIENTE_IMPRESION_BLOQUEANDO_SOLICITUD + E.Message;
            end;
           end
           else begin
             result := True;
             { que salte por otro lado, al borrar por ejemplo }
             dErrorPrinting.iCodigoError :=  ERROR_CLIENTE_IMPRESION_PROBLEMAS_RAROS;
             dErrorPrinting.sLiteralError := LITERAL_ERROR_CLIENTE_IMPRESION_BLOQUEANDO_SOLICITUD + E.message;
           end;
    end;
  end;

end;


procedure  TFichaCliente.BorrarSolicitud;
{ Borra el trabajo del servidor de impresion si todav�a existe }
begin
  try
    with QryDeleteTTRABAIMPRE do
    begin
     // Close;
      Params[0].Value := SolicitudDelCliente.iHandle;
      ExecSql;
     // Close;
     // Refresh;
    end;
    Application.ProcessMessages;
  except
    on E : Exception do
    begin
      QryDeleteTTRABAIMPRE.Close;
      { Es posible Borrar uno que ya estaba borrado }
      dErrorPrinting.iCodigoError :=(dErrorPrinting.iCodigoError * 100) +  ERROR_CLIENTE_IMPRESION_BORRANDO;
      dErrorPrinting.sLiteralError := dErrorPrinting.sLiteralError + LITERAL_ERROR_CLIENTE_IMPRESION_BORRANDO + E.message;
    end;
  end;
end;


procedure TFichaCliente.FormDestroy(Sender: TObject);
//var
//  i : integer;
begin
(*   for I := 0 to ComponentCount - 1 do
     if Components[I] is TTimer then  TTimer(Components[I]).Enabled  := False;
*)
end;

procedure TFichaCliente.TimerImageTimer(Sender: TObject);
begin
  try
  (Sender as TTimer).Enabled := False;
  inc(iImageContador);
  if iImageContador = 4 then
    iImageContador := 0;
  Pinta;
  Application.ProcessMessages;
  finally
  (Sender as TTimer).Enabled := True;
  end;
end;

procedure TFichaCliente.FormActivate(Sender: TObject);
begin
{  TimerImage.Enabled := True;
  bPulsadoCancelar := False;
  bPuedeSalir := False;
  iImageContador := 0;
  //BitBtn1.SetFocus;
}
end;


function TFichaCliente.CambiarEstadoSolicitudOk (const UnEstado : Integer) : boolean;
begin
  result := True;
  try
    with QryUpdateTTRABAIMPRE do
    begin
      Close;
      ParamByName('UnNuevoEstado').Value := UnEstado;
      ParamByName('UnCodigoTrabajo').Value := SolicitudDelCliente.iHandle;
      ExecSql;
      Close;
    end;
    Application.ProcessMessages;
  except
    on E : Exception do
    begin
      result := False;
      QryUpdateTTRABAIMPRE.Close;
      dErrorPrinting.iCodigoError :=  ERROR_CLIENTE_IMPRESION_ACTUALIZANDO;
      dErrorPrinting.sLiteralError := LITERAL_ERROR_CLIENTE_IMPRESION_ACTUALIZANDO + E.message;
    end;
  end;
end;

procedure TFichaCliente.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not bPuedeSalir then CanClose := False
  else CanClose := True;
end;

procedure TFichaCliente.MemoEstadoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Application.ProcessMessages;
  perform(WM_NEXTDLGCTL,0,0);
end;

procedure TFichaCliente.TratadoCambioPapel;
var
  sMensaje : string;
begin
  Application.ProcessMessages;
  DesactivarTestEstadoSolicitud;
  dEstadoCliente := CEsperando_x_Papel;
  sMensaje := '';
  case SolicitudDelCliente.dPeticion.iServicio of
    Factura_A       :  sMensaje := LITERAL_CAMBIO_PAPEL_FACTURA_A;
    Nota_A          :  sMensaje := LITERAL_CAMBIO_PAPEL_NOTA_A;
    Factura_B       :  sMensaje := LITERAL_CAMBIO_PAPEL_FACTURA_B;
    Nota_B          :  sMensaje := LITERAL_CAMBIO_PAPEL_NOTA_B;
    Informe,
    InformeDiferido :  sMensaje := LITERAL_CAMBIO_PAPEL_INFORME;
    Certificado     :  sMensaje := LITERAL_CAMBIO_PAPEL_CERTIFICADO;
    NCDescuento_A   :  sMensaje := LITERAL_CAMBIO_PAPEL_NCDESCUENTO_A;
    NCDescuento_B   :  sMensaje := LITERAL_CAMBIO_PAPEL_NCDESCUENTO_B;
    Medicion        :  sMensaje := LITERAL_CAMBIO_PAPEL_MEDICION;
    Tamarilla       :  sMensaje := LITERAL_CAMBIO_PAPEL_TAMARILLA;
    InformeGNC      :  sMensaje := LITERAL_CAMBIO_PAPEL_INFORMEGNC;
    Factura_A_GNC   :  sMensaje := LITERAL_CAMBIO_PAPEL_FACTURA_A;
    Nota_A_GNC      :  sMensaje := LITERAL_CAMBIO_PAPEL_NOTA_A;
    Factura_B_GNC   :  sMensaje := LITERAL_CAMBIO_PAPEL_FACTURA_B;
    Nota_B_GNC      :  sMensaje := LITERAL_CAMBIO_PAPEL_NOTA_B;
  end;
  Application.ProcessMessages;
  if MessageDlg( 'Notificacion Del Servidor De Impresi�n', sMensaje, mtConfirmation, [mbIgnore, mbCancel], mbIgnore, 0) = mrCancel then
    BtnCancelarGeneralClick (Self)
  else
    begin
      Application.ProcessMessages;
      DejarloAPreparado;
      ActivarTestEstadoSolicitud;
    end;
Application.ProcessMessages;
end;


procedure TFichaCliente.DejarloAPreparado;
const
  NINGUNO = 0;
  UNO = 1;
begin
  bTerminado := False;
  repeat
    try
      with QryLockTTRABAIMPRE do
      begin
        Close;
        Params[0].Value := SolicitudDelCliente.iHandle;
        Open;
        case RecordCount of
          {LOS UNICOS VALORES POSIBLES SON
              0 -> NO EXISTE,
              1 -> EXISTE, OTRO ES IMPOSIBLE PUES ROMPERIAN LAS RESTRICCIONES DEFINIDAS}
          NINGUNO:
            raise EBorradoElRegistro.Create('LA SOLICITUD: ' + IntToStr(SolicitudDelCliente.iHandle) + ' HA DESAPARECIDO DEL SERVIDOR');
          UNO:
            case Fields[0].AsInteger of
              { Esperando_xx_papel }
              2:if CambiarEstadoSolicitudOk(ord(HPreparado)) then
                  begin
                    dEstadoCliente := CEsperando_x_Terminar;
                  end
                else
                  begin
                   dEstadoHandle := HDesconocido;
                   dEstadoCliente := CFin_cn_Incidencias;
                  end;
              else
                begin
                { LIBERAR EL REGISTRO }
                dEstadoHandle := HDesconocido;    { EN CUALQUIER OTRO ESTADO SE PUEDE BORRAR }
                dEstadoCliente := CFin_cn_Incidencias;
                CambiarEstadoSolicitudOk(Fields[0].AsInteger)
                end;
            end;
        end;
        bTerminado := True;
        Application.ProcessMessages;
      end;
    except
      on E: Exception do
      begin
        if E.ClassType = EBorradoElRegistro then
        begin
          { NO HAY ERROR, PERO EL REGISTRO FUE YA BORRADO DESDE EL SERVIDOR }
          bTErminado := True;
          dEstadoCliente := CFin_cn_Incidencias; { EL CLIENTE PASA DE ESTADO }
          dEstadoHandle := HDesaparecido;
          dErrorPrinting.iCodigoError := ERROR_CLIENTE_IMPRESION_CANCELANDO_BORRADA;
          dErrorPrinting.sLiteralError := LITERAL_ERROR_CLIENTE_IMPRESION_BLOQUEANDO_SOLICITUD + E.Message;
        end
{ TODO -oran -cIMPORTANTES : Ver tema errores }
//        else if E.ClassType = EDBEngineError then
        else if E.ClassType = nil then
         begin
           if Pos(REGISTRO_BLOQUEADO, E.Message) <> 0 then bTerminado := False
           else begin
             bTerminado := True;
             dEstadoCliente := CFin_cn_Incidencias;
             dEstadoHandle := HDesconocido;
             { que salte por otro lado, al borrar por ejemplo }
             dErrorPrinting.iCodigoError := ERROR_CLIENTE_IMPRESION_PROBLEMAS_CON_BD;
             dErrorPrinting.sLiteralError := LITERAL_ERROR_CLIENTE_IMPRESION_BLOQUEANDO_SOLICITUD + E.Message;
           end;
         end
         else begin
           bTerminado := True;
           dEstadoCliente := CFin_cn_Incidencias;
           dEstadoHandle := HDesconocido;
           { que salte por otro lado, al borrar por ejemplo }
           dErrorPrinting.iCodigoError :=  ERROR_CLIENTE_IMPRESION_PROBLEMAS_RAROS;
           dErrorPrinting.sLiteralError := LITERAL_ERROR_CLIENTE_IMPRESION_BLOQUEANDO_SOLICITUD + E.message;
         end;
        QryLockTTRABAIMPRE.Close;
      end;
    end;
  until bTerminado;
end;


procedure TFichaCliente.TratadoTerminado;
begin
  DesactivarTestEstadoSolicitud;
  ActualizarInformacionDelUsuario;
  BorrarSolicitud;
  {$IFDEF RETARDO}
     Espera(2);
  {$ENDIF}
   bPuedeSalir := True;
   ModalResult := mrOk;
   Application.ProcessMessages;
end;


function TrabajoEnviadoOk (const UnaCabecera : tCabecera; const UnTrabajo: tTrabajo) : boolean;
var
  UnaSolicitud : tPeticionDeServicio;
  HuboErrores : tErrorPrinting;
begin
  UnaSolicitud.iServicio := UnTrabajo;
  UnaSolicitud.dCabecera := UnaCabecera;
  {$IFDEF TRAZAS}
    fTrazas.PonAnotacion(TRAZA_FLUJO,0,FICHERO_ACTUAL, 'SE ENVIA EL TRABAJO: ' +  IntToStr(Ord(UnTrabajo)) + ' con esta cabecera: EJERCICIO (' +
                         IntToStr(UnaCabecera.IEjercicio) + '),  CODIGO ( ' + IntToSTr(UnaCabecera.iCodigoInspeccion) + '), MATRICULA (' +
                         UnaCabecera.sMatricula + ')');
  {$ENDIF}

  HuboErrores := ClienteDeImpresion(UnaSolicitud);
  case HuboErrores.iCodigoError of
     0: result := True;
  else
    begin
      result := False;
      fIncidencias.PonAnotacion(0,0,FICHERO_ACTUAL,'AL CANCELAR EL TRABAJO SE OBTUBO: ' + HuboErrores.sLiteralError);
    end;
  end;
Application.ProcessMessages;
end;


procedure TFichaCliente.FormShow(Sender: TObject);
const
  TEST_ESTADO_HANDLE = 'TimerEstadoHandle';
  TEST_BORRADO = 'TimerCortesiaBorrado';
var
  i : integer;
begin
Application.ProcessMessages;
  try
    { Inicializacion de componentes de acceso a la base de datos, enlazandoles a la BASE DE DATOS y SESION ABIERTA }
    for I := 0 to ComponentCount - 1 do
{      if Components[I] is TDBDataSet then
      begin
        TDBDataSet(Components[I]).DataBaseName := DataDiccionario.BDPampa.DatabaseName;
        TDBDataSet(Components[I]).SessionName := DataDiccionario.SesionItv.Name;
      end
      else }
    if Components[I] is TTimer then
      begin
        TTimer(Components[I]).Enabled  := False;
          if (TTimer(Components[I]).Name = TEST_ESTADO_HANDLE) then
            TTimer(Components[I]).Interval := INTERVALO_COMPROBACION_ESTADO_HANDLE
          else
            TTimer(Components[I]).Interval := INTERVALO_CORTESIA_BORRADO;
      Application.ProcessMessages;
      end
    else
      if Components[I] is TBitBtn then
        TBitBtn(Components[I]).Enabled := True;

    TimerImage.Enabled := True;
    bPulsadoCancelar := False;
    bPuedeSalir := False;
    iImageContador := 0;
    ActivarTestEstadoSolicitud;
    Application.ProcessMessages;
  except
    on E : Exception do
    begin
     dErrorPrinting.iCodigoError := ERROR_CLIENTE_IMPRESION_CREATE;
     dErrorPrinting.sLiteralError := LITERAL_ERROR_CLIENTE_IMPRESION_CREATE + E.message;
    end;
  end;
end;


procedure TFichaCliente.FormHide(Sender: TObject);
var
  i : integer;
begin
   for I := 0 to ComponentCount - 1 do
     if Components[I] is TTimer then
      TTimer(Components[I]).Enabled  := False;
end;


procedure TFichaCliente.Pinta;
BEGIN
 case iImageContador of
    0: Image.Canvas.Draw(0,0,Image0.Picture.Bitmap);
    1: Image.Canvas.Draw(0,0,Image1.Picture.Bitmap);
    2: Image.Canvas.Draw(0,0,Image2.Picture.Bitmap);
    3: Image.Canvas.Draw(0,0,Image3.Picture.Bitmap);
  end;
Application.ProcessMessages;
END;


procedure TFichaCliente.ImagePaint(Sender: TObject);
begin
  Pinta
end;



Procedure TFichaCliente.UpdatePrintJob(var msg:tmessage);
begin
    //Actualiza el estado de un trabajo de impresion
  Application.ProcessMessages;
  TimerEstadoHandleTimer(Self);
end;


procedure InitClienteImpresion (const aBD : tSQLConnection);
begin
if not Assigned(FichaCliente)  then
  FichaCliente := TFichaCliente.FormCreateByBD(aBD)
end;



initialization

finalization

end.
