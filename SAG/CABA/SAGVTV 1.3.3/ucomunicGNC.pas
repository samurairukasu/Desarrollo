unit ucomunicGNC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, UFTmp,
  DB, SQLExpr, StdCtrls, ExtCtrls, DBCtrls, ComCtrls, Grids, DBGrids,
  Buttons, UCDialgs, USagClasses, RXDBCtrl, SpeedBar, USagData;

const
        FICHERO_ACTUAL = 'UComunicGNC.pas';
        WM_LINEAINSPGNC = WM_USER+12;
        WM_SHOW_IMAGE = WM_USER+5;

type
  TFrmLineaGNC = class(TForm)
    TimerReloj: TTimer;
    InspectionSource: TDataSource;
    SpeedBar1: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    BtnVerificar: TSpeedItem;
    BtnReiniciar: TSpeedItem;
    BtnInterfaz: TSpeedItem;
    BtnRefrescar: TSpeedItem;
    BtnBuscar: TSpeedItem;
    Bevel4: TBevel;
    EDTBUSCAR: TEdit;
    Label1: TLabel;
    BtnCancelar: TSpeedItem;
    SpeedbarSection2: TSpeedbarSection;
    bSalir: TSpeedItem;
    Panel1: TPanel;
    LHora: TLabel;
    LTitulo: TLabel;
    Bevel1: TBevel;
    BtnArriba: TSpeedButton;
    BtnAbajo: TSpeedButton;
    Panel2: TPanel;
    DBGTESTADOINSPB: TRxDBGrid;
    Label2: TLabel;
    btnRechazar: TSpeedItem;
    btnDefectos: TSpeedItem;
    procedure FormDestroy(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure BtnInterfazClick(Sender: TObject);
    procedure BtnVerificarClick(Sender: TObject);
    procedure BtnArribaClick(Sender: TObject);
    procedure BtnAbajoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnRefrescarClick(Sender: TObject);
    procedure BtnBuscarClick(Sender: TObject);
    procedure EdtBuscarKeyPress(Sender: TObject; var Key: Char);
    procedure EdtBuscarExit(Sender: TObject);
    procedure EdtBuscarEnter(Sender: TObject);
    procedure TimerRelojTimer(Sender: TObject);
    procedure BtnReiniciarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure DBGTESTADOINSPBDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure BtnInterfazMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure InspectionSourceDataChange(Sender: TObject; Field: TField);
    procedure DBGTESTADOINSPBDblClick(Sender: TObject);
    procedure bSalirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGTESTADOINSPBKeyPress(Sender: TObject; var Key: Char);
    procedure btnRechazarClick(Sender: TObject);
    procedure btnDefectosClick(Sender: TObject);

  private
    FDataBase: tSQLConnection;
    FInspecciones: TEstadoInspGNC;
    fInspGNC : TInspGNC;
    fVehiculo : TVehiculo;
    procedure HabilitarBotones;
    procedure Refrescar;      
    Procedure DeleteEndingInspections;
    function DatosEquipo : boolean;
    { Private declarations }
  public
    { Public declarations }
    Constructor CreateFromDataBase(aOwner: TComponent; aDataBase: tSQLConnection);   
    Procedure UpdateLineaInspeccionGNC(var msg:tmessage);message WM_LINEAINSPGNC;
  end;

const
  DiaDeLaSemana : array[1..7] of string =
   ('Domingo ', 'Lunes ', 'Martes ', 'Miércoles ', 'Jueves ', 'Viernes ', 'Sabado ');


var
  FrmLineaGNC: TFrmLineaGNC;
  FOwner: TForm;

    procedure DoVerVehiculosGNC(const aBD : tSQLConnection; aOwner:TComponent);

implementation

uses
    UFINVERIGNC,
    ULOGS,
    UUTILS,
    USAGESTACION,
    USAGVARIOS,
    ufDatosEquipoGNC,
    ufRechazarGNC, ufCargaDefectosGNC;

{$R *.DFM}

ResourceString

    ESTADO = 'ESTADO';
    CODIGO_INSPECCION = 'CODINSPGNC';
    EJERCICIO = 'EJERCICI';

    MATRICULA = 'MATRICUL';

    TITULO_1 = 'VEHÍCULOS CON INSPECCIÓN GNC DE LÍNEA FINALIZADA';
    TITULO_2 = 'VEHÍCULOS EN TODA LA PLANTA - GNC';

    MQ_TO_INSPECTION_LINE = 'Volver a Poner Vehículo en la Línea de Inspecciones';

    MSJ_NO_ENCUENTRO_MATRICULA = 'No Se Encontró la Matrícula Solicitada';



Constructor TFrmLineaGNC.CreateFromDataBase(aOwner: TComponent; aDataBase: tSQLConnection);
begin
    //Constructor de la clase dispuesto para ser invocado desde fuera de la ficha
    //Probablemente haya que modificarle cuando se invoque este constructor
    FTmp.Temporizar(True,True,'Verificaciones','Iniciando Línea de Inspección');
    Inherited Create(aOwner);
    FDataBase:=aDataBase;
    FInspecciones:= TEstadoInspGNC.CreateFromDataBase(FDataBase,DATOS_ESTADOINSPGNC,Format(' ORDER BY %S',[FIELD_HORAFINA]));
    InspectionSource.DataSet:=FInspecciones.DataSet;
    Finspecciones.Open;
    FInspecciones.First;
    LTitulo.Caption := TITULO_2;
    BtnInterfaz.Layout:=blGlyphBottom;
    TimerRelojTimer(Self);
    FTmp.Temporizar(False,True,'','');
    Self.Tag:=1;
    TimerReloj.Enabled := True;
    HabilitarBotones;
end;

procedure TFrmLineaGNC.FormDestroy(Sender: TObject);
begin
    fDatabase := nil;
    Self.Tag:=0;
    TimerReloj.Enabled := False;
    if assigned(FInspecciones)
    then FInspecciones.Free;
end;

procedure TFrmLineaGNC.FormDeactivate(Sender: TObject);
begin
    EdtBuscar.Visible := False;
end;


procedure TFrmLineaGNC.BtnInterfazClick(Sender: TObject);
begin
    If (Finspecciones=nil) then Exit;
    if EdtBuscar.Visible then EdtBuscarExit(Sender);
    //Utiliza la propiedad Layout del boton como un biestable para conocer en que estado se e
    //encuentra ya que la propiedad DOWN en botonoes transparentes no funciona
    if BtnInterfaz.Layout=blGlyphTop then begin
        FInspecciones.Filter:=Format(' ORDER BY %S',[FIELD_HORAINIC]);
        LTitulo.Caption := TITULO_2;
        BtnInterfaz.Layout:=blGlyphBottom;
    end
    else begin
        FInspecciones.Filter:=Format(' WHERE %S IN (''%S'',''%S'') ORDER BY %S',[FIELD_ESTADO,E_RECIBIDO_OK,E_STANDBY,FIELD_HORAFINA]);
        LTitulo.Caption := TITULO_1;
        BtnInterfaz.Layout:=blGlyphTop;
    end;
    Refrescar;
    perform(WM_NEXTDLGCTL,0,0);
end;


procedure TFrmLineaGNC.BtnVerificarClick(Sender: TObject);
{var
  ElConjuntoDeDependencias : tRDependencias;}
begin
    If ((Finspecciones=nil) or (FInspecciones.IsNew)) then Exit;
    if EdtBuscar.Visible then EdtBuscarExit(Sender);
    //llama al form  de Finalizar la inspeccion
    Self.Tag:=0;
    Try
        with  FInspecciones do
        begin
            case ValueByName[FIELD_ESTADO][1] of
              E_RECIBIDO_OK, E_FACTURADO:
              begin

            { Puesta a punto de las variables globales necesarias }

                try
                    FrmFinalGNC:=TFrmFinalGNC.CreateFromInspeccion(FInspecciones);
                    try
                        FrmFinalGNC.ShowModal;
                    except
                        on E : Exception do
                            MessageDlg(Caption,'Un error grave ha ocurrido al intentar finalizar la inspección. Si continua el problema contacte con el administrador del sistema', mtError, [mbOk], mbOk, 0);
                    end;
                finally
                    FrmFinalGNC.Free;
                end;
              end;
              E_PENDIENTE_SIC:
              begin
                if DatosEquipo then
                begin
                  FInspecciones.ValueByName[FIELD_ESTADO] := V_ESTADOS_INSP [teVerificandose];
                  FInspecciones.Post(true);
                end;
              end;
              E_MODIFICADO:
              begin
                if DatosEquipo then
                begin
                  FInspecciones.ValueByName[FIELD_ESTADO] := V_ESTADOS_INSP [teRecibido_OK];
                  FInspecciones.Post(true);
                end;
              end;
              else begin
                MessageDlg('VERIFICACIONES','NO PUEDO DAR NINGUN INFORME, NO HA TERMINADO LA VERIFICACIÓN TODAVÍA',mtInformation,[mbOk], mbOk,0);
              end;
            end;
        end;
    Finally
        DeleteEndingInspections;
        FInspecciones.Refresh;
        Refrescar;
        Self.Tag:=1;
    end;
end;

procedure TFrmLineaGNC.BtnArribaClick(Sender: TObject);
begin
  if EdtBuscar.Visible then EdtBuscarExit(Sender);
  FInspecciones.Prior;
end;

procedure TFrmLineaGNC.BtnAbajoClick(Sender: TObject);
begin
  if EdtBuscar.Visible then EdtBuscarExit(Sender);
  FInspecciones.Next;
end;

procedure TFrmLineaGNC.HabilitarBotones;
const
    INTOCABLE = 10;
var
    i : integer;
begin
    { EVALUACION CORTA DE IZQUIERDA A DERECHA }
    {$B-}
    for i := 0 to ComponentCount - 1 do
    begin
        //Botonones de barra superior
        if (Components[i] is TSpeedItem) and (TSpeedItem(Components[i]).Tag <> INTOCABLE) Then
            TSpeedItem(Components[i]).Enabled := (FInspecciones.RecordCount > 0);
        //Otros botonoes del tipo TSPeedButton
        if (Components[i] is TSpeedButton) and (TSpeedButton(Components[i]).Tag <> INTOCABLE) Then
            TSpeedButton(Components[i]).Enabled := (FInspecciones.RecordCount > 0)
    end;

end;

procedure TFrmLineaGNC.Refrescar;
begin
  //Refresca en interfaz solamente
    Self.Tag:=0;
    HabilitarBotones;
    Self.Tag:=1;
end;

procedure TFrmLineaGNC.BtnRefrescarClick(Sender: TObject);
begin
    If (FInspecciones.IsNew) then Exit;
    if EdtBuscar.Visible then EdtBuscarExit(Sender);
    FInspecciones.Refresh;
    Refrescar;
end;

procedure TFrmLineaGNC.BtnBuscarClick(Sender: TObject);
begin

    If ((Finspecciones=nil) or (FInspecciones.IsNew))
    then begin
        Messagedlg(Caption,'¡ No Hay Ninguna Inspección !', mtInformation, [mbYes], mbYes, 0);
        Exit;
    end;
    if EdtBuscar.Visible then EdtBuscarExit(Sender);
    EdtBuscar.Visible := True;
    EdtBuscar.SetFocus;
end;

procedure TFrmLineaGNC.EdtBuscarKeyPress(Sender: TObject; var Key: Char);
begin
  if key = chr(vk_return) then begin
    perform(WM_NEXTDLGCTL,0,0);
    key := #0;
  end
  else if key=chr(VK_SPACE) then
    key := #0;
end;

procedure TFrmLineaGNC.EdtBuscarEnter(Sender: TObject);
begin
    Self.Tag:=0;
end;


procedure TFrmLineaGNC.EdtBuscarExit(Sender: TObject);
begin

  if ((length(EdtBuscar.Text) > 0)) then begin
    Refrescar;
    EdtBuscar.Text := Trim(EdtBuscar.Text);
    if not ExisteRegistro(FInspecciones.DataSet, MATRICULA, EdtBuscar.Text) then begin
      MessageDlg('Solución a la Búsqueda', MSJ_NO_ENCUENTRO_MATRICULA + EdtBuscar.Text, mtInformation, [mbOk], mbOk,0);
      FInspecciones.Prior;
    end;
  end;
  EdtBuscar.Visible := False;
  Self.Tag:=1;
end;

procedure TFrmLineaGNC.TimerRelojTimer(Sender: TObject);
begin
   LHora.Caption := FormatDateTime('HH:MM',now);
end;

procedure TFrmLineaGNC.BtnReiniciarClick(Sender: TObject);
var
  sClave : string;
  sChar : string;
  sMensaje : string;
begin
    //Reinicia la inspeccion
    If ((Finspecciones=nil) or (FInspecciones.IsNew)) then Exit;
    if FInspecciones.ValueByName[FIELD_ESTADO][1] in ([E_FACTURADO])
    then begin
        Messagedlg(Application.Title,'No se puede reiniciar este tipo de verificaciones',mtInformation,[mbok],mbok,0);
        Exit;
    end;
    if EdtBuscar.Visible then EdtBuscarExit(Sender);
    try
        with FInspecciones do
        begin

            sClave := ValueByName[FIELD_EJERCICI] + ',' + ValueByName[FIELD_CODINSPGNC];

            sChar := ValueByName[FIELD_ESTADO];

            case sChar[1] of
                E_FACTURADO : begin
                    sMensaje := 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' está FACTURADO, quiere continuar con la TAREA DE REINICIO DE VERIFICACIÓN';
                end;

                E_VERIFICANDOSE : begin
                    sMensaje := 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' está VERIFICANDOSE, quiere continuar con la TAREA DE REINICIO DE VERIFICACIÓN';
                end;

                E_RECIBIDO_OK : begin
                    sMensaje := 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' está ESPERANDO LA SALIDA DE SUS INFORMES POR IMPRESORA, quiere continuar con la TAREA DE REINICIO DE VERIFICACIÓN';
                end;

                E_RECIBIDO_NOK : begin
                    sMensaje := 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' está ESPERANDO QUE SE CORRIJAN SUS PROBLEMAS CON LA LÍNEA DE VERIFICACIÓN, quiere continuar con la TAREA DE REINICIO DE VERIFICACIÓN';
                end;

                E_ANULADO : begin
                    sMensaje := 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' tiene ANULADA SU VERIFICACIÓN, quiere continuar con la TAREA DE REINICIO DE VERIFICACIÓN';
                end;

                E_FINALIZADO : begin
                    sMensaje := 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' ha FINALIZADO SU VERIFICACIÓN, quiere continuar con la TAREA DE REINICIO DE VERIFICACIÓN';
                end;

                E_PENDIENTE_SIC : begin
                    sMensaje := 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + 'está ESPERANDO LA COMPARACIÓN DE SUS DATOS CON EL SIC-GNC, quiere continuar con la TAREA DE REINICIO DE VERIFICACIÓN';
                end;

                E_PENDIENTE_FACTURAR : begin
                    sMensaje := 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + 'está ESPERANDO SER FACTURADO, quiere continuar con la TAREA DE REINICIO DE VERIFICACIÓN';
                end;

            end;  // case

            if MessageDlg('PLANTA DE VERIFICACION',sMensaje,mtInformation,[mbIgnore,mbCancel],mbIgnore,0) = mrIgnore then
            begin
                if Finspecciones.Reiniciar
                then
                else begin
                    MessageDlg('PLANTA DE VERIFICACION',
                      'EN ESTE MOMENTO NO SE PUEDE EFECTUAR DICHA OPERACIÓN, ESPERE UNOS SEGUNDOS E INTÉNTELO DE NUEVO, SI EL PROBLEMA PERSISTE CONTACTE CON SU DISTRIUBIDOR',
                      mtWarning,[mbOk], mbOk,0);
                end;
            end; // if
        end; // with
    except
        on E : Exception do
        begin
            fAnomalias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'NO SE PUEDE PONER EN ESTADO FACTURADO EL REGISTRO: ' +  sClave + ' POR : ' + E.message);
        end;
    end;
    FInspecciones.Refresh;
    Refrescar;
end;

procedure TFrmLineaGNC.BtnCancelarClick(Sender: TObject);
var
  sClave : string;
  sChar : string;
  sMensaje : string;
begin
    //Cancela la inspeccion
    If ((Finspecciones=nil) or (FInspecciones.IsNew)) then Exit;
    if EdtBuscar.Visible then EdtBuscarExit(Sender);
    try
        with FInspecciones do
        begin

            sClave := ValueByName[FIELD_EJERCICI] + ',' + ValueByName[FIELD_CODINSPGNC];

            sChar := ValueByName[FIELD_ESTADO];
            sMensaje := '!!ATENCIÓN!!' + #13 + #10 + ' Cancelar Inspección Del Vehículo ' + ValueByName[FIELD_MATRICUL];
            case sChar[1] of
                E_FACTURADO : begin
                    sMensaje := '!!ATENCIÓN!!' + #13 + #10 + 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' está FACTURADO, quiere continuar con la TAREA DE CANCELACIÓN DE VERIFICACIÓN';
                end;

                E_VERIFICANDOSE : begin
                    sMensaje := '!!ATENCIÓN!!' + #13 + #10 + 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' está VERIFICANDOSE, quiere continuar con la TAREA DE CANCELACIÓN DE VERIFICACIÓN';
                end;

                E_RECIBIDO_OK : begin
                    sMensaje := '!!ATENCIÓN!!' + #13 + #10 + 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' está ESPERANDO LA SALIDAD DE SUS INFORMES POR IMPRESORA, quiere continuar con la TAREA DE CANCELACIÓN DE VERIFICACIÓN';
                end;

                E_RECIBIDO_NOK : begin
                    sMensaje := '!!ATENCIÓN!!' + #13 + #10 + 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' está ESPERANDO QUE SE CORRIJAN SUS PROBLEMAS CON LA LÍNEA DE VERIFICACIÓN, quiere continuar con la TAREA DE CANCELACIÓN DE VERIFICACIÓN';
                end;

                E_ANULADO : begin
                    sMensaje := '!!ATENCIÓN!!' + #13 + #10 + 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' tiene ANULADA SU VERIFICACIÓN, quiere continuar con la TAREA DE CANCELACIÓN DE VERIFICACIÓN';
                end;

                E_FINALIZADO : begin
                    sMensaje := '!!ATENCIÓN!!' + #13 + #10 + 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' ha FINALIZADO SU VERIFICACIÓN, quiere continuar con la TAREA DE DE CANCELACIÓN DE VERIFICACIÓN';
                end;

                E_PENDIENTE_SIC : begin
                    sMensaje := '!!ATENCIÓN!!' + #13 + #10 + 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' está ESPERANDO LA COMPROBACIÓN DE SUS DATOS EN EL SIC, quiere continuar con la TAREA DE DE CANCELACIÓN DE VERIFICACIÓN';
                end;

            end;  // case

            if MessageDlg('PLANTA DE VERIFICACION',sMensaje,mtInformation,[mbIgnore, mbCancel],mbIgnore,0) = mrIgnore then
            begin
                if Not Finspecciones.Cancelar
                then begin
                    MessageDlg('PLANTA DE VERIFICACION',
                      'EN ESTE MOMENTO NO SE PUEDE EFECTUAR DICHA OPERACIÓN, ESPERE UNOS SEGUNDOS E INTÉNTELO DE NUEVO, SI EL PROBLEMA PERSISTE CONTACTE CON SU DISTRIUBIDOR',
                      mtWarning,[mbOk], mbOk,0);
                end;
            end; // if
        end; // with
    except
        on E : Exception do
        begin
            fAnomalias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'NO SE PUEDE PONER EN ESTADO FACTURADO EL REGISTRO: ' +  sClave + ' POR : ' + E.message);
       end;
    end;
    FInspecciones.Refresh;
    Refrescar;

    end;


procedure TFrmLineaGNC.DBGTESTADOINSPBDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
    Cad: String;
    idx: Integer;
begin
    //Dibuja en las celdas en funcion de los valores contenidos en Tipo y Estado segun
    //los valores guardados dentro de los arrays de USagEstacion
    If ((not(FInspecciones.Active)) or (FInspecciones.RecordCount=0)) then Exit;
    IF Column.Index = 2 //columna de estados
    then begin
        Cad:='';
        Try
            Idx:=(Ord(FInspecciones.ValueByName[FIELD_ESTADO][1])-65);
        Except
            Idx:=0;
        end;
        Cad:=(S_ESTADO_INSPECCION[tEstados(Idx)]);
        DBGTESTADOINSPB.Canvas.Brush.Color:=S_ESTADOS_COLORES[tEstados(Idx)];
        DBGTESTADOINSPB.Canvas.Font.Color:=S_ESTADOS_FUENTES_COLORES[tEstados(Idx)];
        DBGTESTADOINSPB.Canvas.FillRect(Rect);
        DBGTESTADOINSPB.Canvas.TextOut(Rect.Left,Rect.Top,Cad);
    end
    else begin
        if Column.Index=0   //Tipo
        then begin
            Cad:='';
            Try
                Idx:=(Ord(FInspecciones.ValueByName[FIELD_TIPO][1])-65);
            Except
                Idx:=0;
            end;
            Cad:=(S_TIPO_VERIFICACION[tfVerificacion(Idx)]);
            DBGTESTADOINSPB.Canvas.Brush.Color:=S_TIPOS_COLORES[tfVerificacion(Idx)];
            DBGTESTADOINSPB.Canvas.Font.Color:=S_TIPOS_FUENTES_COLORES[tfVerificacion(Idx)];
            DBGTESTADOINSPB.Canvas.FillRect(Rect);
            DBGTESTADOINSPB.Canvas.TextOut(Rect.Left,Rect.Top,Cad);
        end;
    end;

end;

procedure TFrmLineaGNC.BtnInterfazMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    //Cambiar el hint del boton segun el estado al que llevaria en caso de ser pulsado
    if BtnInterfaz.Layout=blGlyphTop //Ver todos
    then begin
        BtnInterfaz.Hint:='Ver Todos Los Vehículos en la Planta';
    end
    else begin
        BtnInterfaz.Hint:='Ver Los Vehículos en la Planta Con Inspección Finalizada';
    end;
end;

procedure TFrmLineaGNC.InspectionSourceDataChange(Sender: TObject;
  Field: TField);
begin
    //cambian los datos y actualiza el estado de algunos botones
    If ((((Sender as TDataSource).DataSet<>nil) and ((Sender as TDataSource).DataSet.Active)) and (not(Finspecciones.IsNew)))
    then begin

        Try
            If FInspecciones.ValueByName[FIELD_ESTADO][1] in ([E_PENDIENTE_SIC, E_RECIBIDO_OK,E_MODIFICADO,E_FACTURADO])
            then
                BtnVerificar.Enabled:=True
            else
                BtnVerificar.Enabled:=False;
        Except
           BtnVerificar.Enabled:=False;
        end;

        Try
            if FInspecciones.ValueByName[FIELD_ESTADO][1] in ([E_FACTURADO])
            then
            begin
                btnRechazar.Enabled:=False;
                BtnReiniciar.Enabled:=False;
            end
            else
            begin
                btnRechazar.Enabled:=True;
                BtnReiniciar.Enabled:=True;
            end;
        Except
           btnRechazar.Enabled:=False;
           BtnReiniciar.Enabled:=False;
        end;
    end;
end;

procedure TFrmLineaGNC.DBGTESTADOINSPBDblClick(Sender: TObject);
begin
    //Si hacemos dobleclick en una inspeccion dispuesta para finalizar, tiene el boton habilitado'
    //pasa al form de finalizacion de inspecciones
    If BtnVerificar.Enabled then BtnVerificarClick(Sender);
end;

procedure DoVerVehiculosGNC(const aBD : tSQLConnection; aOwner: TComponent);
begin
        if FrmLineaGNC=nil
        then begin
            fOwner := Tform(aOwner);
            FrmLineaGNC:= TFrmLineaGNC.CreateFromDataBase(Application, aBD);
            with FrmLineaGNC do
            try
                try
                except
                 on E: Exception do
                    begin
                        fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL,'Error intentando visualizar los vehículos en la planta por: %s ', [E.message]);
                        MessageDlg(Application.Title,'No pueden visualizarse los vehículos en la planta. Intentelo de nuevo y si el error persiste, contacte con el jefe de la planta.',mtInformation,[mbOk],mbOk,0);
                    end;
                end;
            finally
            end;
        end;
end;

procedure TFrmLineaGNC.FormActivate(Sender: TObject);
begin
        (Sender as Tform).Windowstate:=wsMaximized;
end;

procedure TFrmLineaGNC.bSalirClick(Sender: TObject);
begin
    Self.Tag:=0;
    TimerReloj.Enabled:=False;
    Application.ProcessMessages;
    FrmLineaGNC.Close;
    FrmLineaGNC:=nil;
    Sendmessage(fOwner.Handle,WM_SHOW_IMAGE,0,0);
end;

procedure TFrmLineaGNC.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action:=caFree;
end;

Procedure TFrmLineaGNC.UpdateLineaInspeccionGNC(var msg:tmessage);
begin
    If Self.Tag = 1
    then begin             
        if BtnInterfaz.Layout=blGlyphTop then begin
            If Chr(msg.LParam+64) in ([E_RECIBIDO_OK,E_STANDBY])
            Then begin
                FInspecciones.Refresh;
                Refrescar;
            end;
        end
        else begin   
            FInspecciones.Refresh;
            Refrescar;
        end;
    end;
end;

Procedure TFrmLineaGNC.DeleteEndingInspections;
var
    aQ: TsqlQuery;
begin
    //Borra las inspecciones finalizadas
    aQ:=TsqlQuery.Create(self);
    With aQ do
    Try
        SQLConnection:=FDataBase;
        Sql.Add(Format('DELETE ESTADOINSPGNC WHERE ESTADO IN (''%S'',''%S'')',[E_ANULADO,E_FINALIZADO]));
        ExecSql;
    fInally
        Close;
        Free;
    end;
end;


procedure TFrmLineaGNC.DBGTESTADOINSPBKeyPress(Sender: TObject;
  var Key: Char);
begin
    If key=chr(vk_return) then DBGTESTADOINSPBDblClick(sender);
end;

function TFrmLineaGNC.DatosEquipo : boolean;
begin
        try
          fInspGNC := TInspGNC.CreateFromEstadoInspeccion(FInspecciones);
          fInspGNC.Open;
          fVehiculo := TVehiculo.CreateFromDataBase(FDataBase,DATOS_VEHICULOS,format(' WHERE CODVEHIC = %S ',[fInspGNC.ValuebyName[FIELD_CODVEHIC]]));
          fVehiculo.Open;
          with TFrmDatosEquiposGNC.CreateFromBD (fInspGNC, fVehiculo, finspecciones.valuebyname[FIELD_ESTADO][1]) do
          try
              result := Execute
          finally
              Free;
          end;
        finally
          fInspGNC.Free;
          fVehiculo.Free;
        end;
end;

procedure TFrmLineaGNC.btnRechazarClick(Sender: TObject);
var
  sChar, sMensaje, sClave : string;
begin

    If ((Finspecciones=nil) or (FInspecciones.IsNew)) then Exit;
    if EdtBuscar.Visible then EdtBuscarExit(Sender);
    try
        with FInspecciones do
        begin
            sClave := ValueByName[FIELD_EJERCICI] + ',' + ValueByName[FIELD_CODINSPGNC];
            sChar := ValueByName[FIELD_ESTADO];
            sMensaje := '!!ATENCIÓN!!' + #13 + #10 + ' Rechazar Inspección Del Vehículo ' + ValueByName[FIELD_MATRICUL];
            case sChar[1] of
                E_FACTURADO : begin
                    sMensaje := '!!ATENCIÓN!!' + #13 + #10 + 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' está FACTURADO, quiere continuar con la tarea de Rechazo de Verificación';
                end;

                E_VERIFICANDOSE : begin
                    sMensaje := '!!ATENCIÓN!!' + #13 + #10 + 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' está VERIFICANDOSE, quiere continuar con la tarea de Rechazo de Verificación';
                end;

                E_RECIBIDO_OK : begin
                    sMensaje := '!!ATENCIÓN!!' + #13 + #10 + 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' está ESPERANDO LA SALIDAD DE SUS INFORMES POR IMPRESORA, quiere continuar con la tarea de Rechazo de Verificación';
                end;

                E_RECIBIDO_NOK : begin
                    sMensaje := '!!ATENCIÓN!!' + #13 + #10 + 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' está ESPERANDO QUE SE CORRIJAN SUS PROBLEMAS CON LA LÍNEA DE VERIFICACIÓN, quiere continuar con la tarea de Rechazo de Verificación';
                end;

                E_ANULADO : begin
                    sMensaje := '!!ATENCIÓN!!' + #13 + #10 + 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' tiene ANULADA SU VERIFICACIÓN, quiere continuar con la tarea de Rechazo de Verificación';
                end;

                E_FINALIZADO : begin
                    sMensaje := '!!ATENCIÓN!!' + #13 + #10 + 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' ha FINALIZADO SU VERIFICACIÓN, quiere continuar con la tarea de Rechazo de Verificación';
                end;

                E_PENDIENTE_SIC : begin
                    sMensaje := '!!ATENCIÓN!!' + #13 + #10 + 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' está ESPERANDO LA COMPROBACIÓN DE SUS DATOS EN EL SIC, quiere continuar con la tarea de Rechazo de Verificación';
                end;

            end;  // case

            if MessageDlg('PLANTA DE VERIFICACION',sMensaje,mtInformation,[mbIgnore, mbCancel],mbIgnore,0) = mrIgnore then
            begin
              try
                 fInspGNC := TInspGNC.CreateFromEstadoInspeccion(FInspecciones);
                 fInspGNC.start;
                 with TfrmRechazarGNC.CreateFromBD (fInspGNC, fInspecciones) do
                      try
                         Execute
                      finally
                         Free;
                      end;
              finally
                     fInspGNC.Free;
              end;
            end; // if
        end; // with
    except
        on E : Exception do
        begin
            fAnomalias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'NO SE PUEDE PONER EN ESTADO FACTURADO EL REGISTRO: ' +  sClave + ' POR : ' + E.message);
       end;
    end;


  FInspecciones.Refresh;
  Refrescar;
end;

procedure TFrmLineaGNC.btnDefectosClick(Sender: TObject);
var
  sChar, sMensaje, sClave : string;
begin
    If ((Finspecciones=nil) or (FInspecciones.IsNew)) then Exit;
    if FInspecciones.ValueByName[FIELD_ESTADO][1] in ([E_FACTURADO, E_PENDIENTE_FACTURAR])
    then begin
        Messagedlg(Application.Title,'No se pueden cargar defectos en este estado',mtInformation,[mbok],mbok,0);
        Exit;
    end;

    if EdtBuscar.Visible then EdtBuscarExit(Sender);
    try
        with FInspecciones do
        begin
            sClave := ValueByName[FIELD_EJERCICI] + ',' + ValueByName[FIELD_CODINSPGNC];
            sChar := ValueByName[FIELD_ESTADO];
              try
                 fInspGNC := TInspGNC.CreateFromEstadoInspeccion(FInspecciones);
                 fInspGNC.start;
                 with TfrmCargaDefectosGNC.CreateFromBD (fInspGNC, fInspecciones) do
                      try
                         SoloCargar
                      finally
                         Free;
                      end;
              finally
                     fInspGNC.Free;
              end;
        end; // with
    except
        on E : Exception do
        begin
            fAnomalias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'NO SE PUEDE PONER EN ESTADO FACTURADO EL REGISTRO: ' +  sClave + ' POR : ' + E.message);
       end;
    end;


  FInspecciones.Refresh;
  Refrescar;


end;

end.//Final de la unidad





