unit UComunic;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, UFTmp,
  DB, SQLExpr, StdCtrls, ExtCtrls, DBCtrls, ComCtrls, Grids, DBGrids,
  Buttons, UCDialgs, USagClasses, RXDBCtrl, SpeedBar, USagData, RxGIF, globals,
  ADODB;

const
        FICHERO_ACTUAL = 'UComunic.pas';
        WM_LINEAINSP = WM_USER+10;
        WM_SHOW_IMAGE = WM_USER+5;

type
  TFrmLinea = class(TForm)
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
    RecuperardeStandBy: TSpeedItem;
    Panel1: TPanel;
    LHora: TLabel;
    LTitulo: TLabel;
    Bevel1: TBevel;
    BtnArriba: TSpeedButton;
    BtnAbajo: TSpeedButton;
    Panel2: TPanel;
    DBGTESTADOINSPB: TRxDBGrid;
    Label2: TLabel;
    PGNC: TPanel;
    TmGNC: TTimer;
    Image1: TImage;
    MahaQuery: TADOQuery;
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
    procedure RecuperardeStandByClick(Sender: TObject);
    procedure InspectionSourceDataChange(Sender: TObject; Field: TField);
    procedure DBGTESTADOINSPBDblClick(Sender: TObject);
    procedure bSalirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGTESTADOINSPBKeyPress(Sender: TObject; var Key: Char);
    procedure TmGNCTimer(Sender: TObject);
    procedure FormResize(Sender: TObject);

  private

    FDataBase: tSQLConnection;
    FInspecciones: TEstadoInspeccion;
    FInspGNC : TEstadoInspGNC;
    procedure HabilitarBotones;

    procedure Refrescar;      
    Procedure DeleteEndingInspections;
    Function VehiculosEnLineaGNC: boolean;
    { Private declarations }
  public
    { Public declarations }
    ADOConexion: TADOConnection;
    Constructor CreateFromDataBase(aOwner: TComponent; aDataBase: tSQLConnection);   
    Procedure UpdateLineaInspeccion(var msg:tmessage);message WM_LINEAINSP;
  end;

const
  DiaDeLaSemana : array[1..7] of string =
   ('Domingo ', 'Lunes ', 'Martes ', 'Miércoles ', 'Jueves ', 'Viernes ', 'Sabado ');
  Minima = 800;
  Maxima = 1024;

var
  FrmLinea: TFrmLinea;     
  FOwner: TForm;

    procedure DoVerVehiculos(const aBD : tSQLConnection; aOwner:TComponent);

implementation

uses
    UFINVERI,
    ULOGS,
    UUTILS,
    USAGESTACION,
    USAGVARIOS;

{$R *.DFM}

ResourceString

    FIELD_HORAINIC = 'HORAINIC';
    FIELD_HORAFINA = 'HORAFINA';
    FIELD_ESTADO = 'ESTADO';
    FIELD_CODINSPE = 'CODINSPE';
    FIELD_EJERCICI = 'EJERCICI';
    FIELD_MATRICUL = 'MATRICUL';
    FIELD_TIPO = 'TIPO';

    ESTADO = 'ESTADO';
    CODIGO_INSPECCION = 'CODINSPE';
    EJERCICIO = 'EJERCICI';

    MATRICULA = 'MATRICUL';

    TITULO_1 = 'VEHÍCULOS CON INSPECCIÓN DE LÍNEA FINALIZADA';
    TITULO_2 = 'VEHÍCULOS EN TODA LA PLANTA';

    MQ_TO_INSPECTION_LINE = 'Volver a Poner Vehículo en la Linea de Inspecciones';

    MSJ_NO_ENCUENTRO_MATRICULA = 'No Se Encontró la Matrícula Solicitada';
    MSJ_RESTAURAR_PEVE = 'Realmente quiere cancelar el estado PENDIENTE A FACTURAR?';


Constructor TFrmLinea.CreateFromDataBase(aOwner: TComponent; aDataBase: tSQLConnection);
begin
    //Constructor de la clase dispuesto para ser invocado desde fuera de la ficha
    //Probable mente haya que modificarle cuando se invoque este constructor
    FTmp.Temporizar(True,True,'Verificaciones','Iniciando Línea de Inspección'+#13#10+'Aguarde un momento por favor...');
    Inherited Create(nil);
    FDataBase:=aDataBase;
    //FInspecciones:= TEstadoInspeccion.Create(FDataBase,Format(' WHERE %S = ''%S'' ORDER BY %S',[FIELD_ESTADO,E_RECIBIDO_OK,FIELD_HORAFINA]));
    FInspecciones:= TEstadoInspeccion.CreateFromDataBase(FDataBase,DATOS_ESTADOINSPECCION,(' ORDER BY ESTADO DESC, TO_CHAR(HORAINIC,''dd/mm/yyyy HH:MI:SS'') DESC '));
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
    TmGNC.enabled :=  VehiculosEnLineaGNC;
end;


procedure TFrmLinea.FormDestroy(Sender: TObject);
begin
fDatabase := nil;
Self.Tag:=0;
TimerReloj.Enabled := False;
if assigned(FInspecciones) then
  FInspecciones.Free;
end;

procedure TFrmLinea.FormDeactivate(Sender: TObject);
begin
  EdtBuscar.Visible := False;
end;


procedure TFrmLinea.BtnInterfazClick(Sender: TObject);
begin
If (Finspecciones=nil) then
  Exit;
If EdtBuscar.Visible then
  EdtBuscarExit(Sender);
//Utiliza la propiedad Layout del boton como un biestable para conocer en que estado se e
//encuentra ya que la propiedad DOWN en botonoes transparentes no funciona
if BtnInterfaz.Layout=blGlyphTop then
  begin
    FInspecciones.Filter:=Format(' ORDER BY ESTADO DESC, TO_CHAR(HORAINIC,''dd/mm/yyyy HH:MI:SS'') DESC',[FIELD_HORAINIC]);
    LTitulo.Caption := TITULO_2;
    BtnInterfaz.Layout:=blGlyphBottom;
  end
else
  begin
    FInspecciones.Filter:=Format(' WHERE %S IN (''%S'',''%S'') ORDER BY %S',[FIELD_ESTADO,E_RECIBIDO_OK,E_STANDBY,FIELD_HORAFINA]);
    LTitulo.Caption := TITULO_1;
    BtnInterfaz.Layout:=blGlyphTop;
  end;
Refrescar;
perform(WM_NEXTDLGCTL,0,0);
end;


procedure TFrmLinea.BtnVerificarClick(Sender: TObject);
{var
  ElConjuntoDeDependencias : tRDependencias;}
  var matricula,alerta:string;
begin

Screen.Cursor:=crHourGlass;
DBGTESTADOINSPB.Enabled:=false;

If ((Finspecciones=nil) or (FInspecciones.IsNew)) then
  Exit;
if EdtBuscar.Visible then
  EdtBuscarExit(Sender);

Self.Tag:=0;
  Try
    with FInspecciones do
      begin
        if ValueByName[FIELD_ESTADO][1] in ([E_RECIBIDO_OK,E_STANDBY]) then
          Begin
          if (FInspecciones.BlockInsp) then
          { Puesta a punto de las variables globales necesarias }
            try
              {$IFDEF TRAZAS}
              FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'EL USUARIO A BLOQUEADO LA INSPECCION '+FInspecciones.ValueByName[FIELD_CODINSPE]);
              {$ENDIF}
              FrmFinal:=TFrmFinal.CreateFromInspeccion(FInspecciones);
                try
                  Screen.Cursor:=crDefault;  
                  matricula:=ValueByName[FIELD_MATRICUL];
                  FrmFinal.Label4.Caption:='';
                  alerta:=trim(FrmFinal.Tiene_Alerta(matricula));
                   if trim(alerta)='' then
                      FrmFinal.panel2.Visible:=false
                      else
                      begin
                       FrmFinal.panel2.Visible:=true;
                       FrmFinal.Label4.Caption:=alerta;
                       end;

                  FrmFinal.VARIABLE_COLOR:=1;
                  FrmFinal.ShowModal;
                  DBGTESTADOINSPB.Enabled:=True;
                except
                  on E : Exception do
                    Begin
                      DBGTESTADOINSPB.Enabled:=True;
                      Screen.Cursor:=crDefault;
                      MessageDlg(Caption,'Un error grave ha ocurrido al intentar finalizar la inspección. Si continua el problema contacte con el administrador del sistema', mtError, [mbOk], mbOk, 0);
                    end;
                end;
            finally
              FrmFinal.Free;
            end;
          end
        else
          begin
            MessageDlg('VERIFICACIONES','NO PUEDO DAR NINGUN INFORME, NO HA TERMINADO LA VERIFICACIÓN TODAVÍA',mtInformation,[mbOk], mbOk,0);
          end;
      end;
  Finally
    DeleteEndingInspections;
    FInspecciones.Refresh;
    Refrescar;
    Self.Tag:=1;
    Screen.Cursor:=crDefault;
    DBGTESTADOINSPB.Enabled:=True;
    DBGTESTADOINSPB.SetFocus;
  end;
end;


procedure TFrmLinea.BtnArribaClick(Sender: TObject);
begin
  if EdtBuscar.Visible then EdtBuscarExit(Sender);
  FInspecciones.Prior;
end;


procedure TFrmLinea.BtnAbajoClick(Sender: TObject);
begin
  if EdtBuscar.Visible then EdtBuscarExit(Sender);
  FInspecciones.Next;
end;

procedure TFrmLinea.HabilitarBotones;
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

procedure TfrmLinea.Refrescar;
begin
Self.Tag:=0;
HabilitarBotones;
Self.Tag:=1;
end;

procedure TFrmLinea.BtnRefrescarClick(Sender: TObject);
begin
If (FInspecciones.IsNew) then
  Exit;
If EdtBuscar.Visible then
  EdtBuscarExit(Sender);
FInspecciones.Refresh;
Refrescar;
end;

procedure TFrmLinea.BtnBuscarClick(Sender: TObject);
begin
If ((Finspecciones=nil) or (FInspecciones.IsNew)) then
  begin
    Messagedlg(Caption,'¡ No Hay Ninguna Inspección !', mtInformation, [mbYes], mbYes, 0);
    Exit;
  end;
If EdtBuscar.Visible then
  EdtBuscarExit(Sender);
EdtBuscar.Visible := True;
EdtBuscar.SetFocus;
end;

procedure TFrmLinea.EdtBuscarKeyPress(Sender: TObject; var Key: Char);
begin
  if key = chr(vk_return) then begin
    perform(WM_NEXTDLGCTL,0,0);
    key := #0;
  end
  else
  if key=chr(VK_SPACE) then
    key := #0;
end;

procedure TFrmLinea.EdtBuscarEnter(Sender: TObject);
begin
Self.Tag:=0;
end;


procedure TFrmLinea.EdtBuscarExit(Sender: TObject);
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


procedure TFrmLinea.TimerRelojTimer(Sender: TObject);
begin
LHora.Caption := FormatDateTime('HH:MM:SS',now);
FInspecciones.Refresh;
end;

procedure TFrmLinea.BtnReiniciarClick(Sender: TObject);
var
  sClave : string;
  sChar : string;   cont_reenvio:longint;
  sMensaje, sEjercicio, sInspeccion : string;
begin
//Reinicia la inspeccion
//********************************** VERSION SAG 4.00 **********************************************
if not (Finspecciones.IsBlockByUser) then
//**************************************************************************************************
  Begin
    If ExisteEnMAHA(FInspecciones.ValueByName[FIELD_MATRICUL]) then
      Exit;
    If ((Finspecciones=nil) or (FInspecciones.IsNew)) then
      Exit;

    If FInspecciones.ValueByName[FIELD_ESTADO][1] in ([E_PENDIENTE_FACTURAR]) then
      begin
        Messagedlg(Application.Title,'No se puede reiniciar este tipo de verificaciones',mtInformation,[mbok],mbok,0);
        Exit;
      end;

    If EdtBuscar.Visible then
      EdtBuscarExit(Sender);

    try
    with FInspecciones do
      begin
        sClave := ValueByName[FIELD_EJERCICI] + ',' + ValueByName[FIELD_CODINSPE];
        sChar := ValueByName[FIELD_ESTADO];
        case sChar[1] of
          E_FACTURADO : sMensaje := 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' está FACTURADO, quiere continuar con la TAREA DE REINICIO DE VERIFICACIÓN';
          E_VERIFICANDOSE : sMensaje := 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' está VERIFICANDOSE, quiere continuar con la TAREA DE REINICIO DE VERIFICACIÓN';
          E_RECIBIDO_OK : sMensaje := 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' está ESPERANDO LA SALIDA DE SUS INFORMES POR IMPRESORA, quiere continuar con la TAREA DE REINICIO DE VERIFICACIÓN';
          E_RECIBIDO_NOK : sMensaje := 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' está ESPERANDO QUE SE CORRIJAN SUS PROBLEMAS CON LA LÍNEA DE VERIFICACIÓN, quiere continuar con la TAREA DE REINICIO DE VERIFICACIÓN';
          E_ANULADO : sMensaje := 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' tiene ANULADA SU VERIFICACIÓN, quiere continuar con la TAREA DE REINICIO DE VERIFICACIÓN';
          E_FINALIZADO: sMensaje := 'El Vehículo ' + ValueByName[FIELD_MATRICUL] + ' ha FINALIZADO SU VERIFICACIÓN, quiere continuar con la TAREA DE REINICIO DE VERIFICACIÓN';
        end;

      If MessageDlg('PLANTA DE VERIFICACION',sMensaje,mtInformation,[mbIgnore,mbCancel],mbIgnore,0) = mrIgnore then
        begin
///////////////////////////////////////////////////////////////////////////////////////////////////
          With TFrmFinal.Create(nil) do
            try
              if Encontrar_Auditoria(ValueByName[FIELD_CODINSPE], ValueByName[FIELD_EJERCICI]) then
                Begin
                  InsertarReenvio(ValueByName[FIELD_CODINSPE]);
                  With TSQLQuery.Create(nil) do
                    try
                      Close;
                      SQL.Clear;
                      SQLConnection:=mybd;
                      SQL.Add('UPDATE TESTADOINSP SET ESTADO = ''A'' WHERE CODINSPE = :CODINSPE AND EJERCICI = :EJERCICI');
                      Params[0].Value:=ValueByName[FIELD_CODINSPE];
                      Params[1].Value:=ValueByName[FIELD_EJERCICI];
                      ExecSQL;

                      //**********
                        //contador de reinicio
                            /// contador de reniciadas

                       Close;
                       SQL.Clear;
                       SQLConnection:=mybd;
                       SQL.Add('SELECT CODINSPE   FROM tcantreenviolinea  WHERE CODINSPE = :CODINSPE');
                       Params[0].Value:=ValueByName[FIELD_CODINSPE];
                       OPEN;



                       IF  trim(FieldByName('CODINSPE').AsString)='' then
                       BEGIN
                               cont_reenvio:=1;
                               Close;
                               SQL.Clear;
                               SQLConnection:=mybd;
                               SQL.Add('insert into tcantreenviolinea  (codinspe, reenvios) values (:CODINSPE,:reenvios)');
                               Params[0].Value:=ValueByName[FIELD_CODINSPE];
                               Params[1].Value:=cont_reenvio;
                               ExecSQL

                       END else
                        begin
                               Close;
                               SQL.Clear;
                               SQLConnection:=mybd;
                               SQL.Add('update tcantreenviolinea  set reenvios=reenvios  + 1  where CODINSPE = :CODINSPE');
                              // Params[0].Value:=nuevo_reenvio;
                               Params[0].Value:=ValueByName[FIELD_CODINSPE];
                               ExecSQL


                        end;


                      ///*********
                    finally
                      free;
                    end;
                end
              else
                if Reiniciar then
                begin
                  InsertarReenvio(ValueByName[FIELD_CODINSPE]);
                       With TSQLQuery.Create(nil) do
                    try
                       Close;
                       SQL.Clear;
                       SQLConnection:=mybd;
                       SQL.Add('SELECT CODINSPE, reenvios   FROM tcantreenviolinea  WHERE CODINSPE = :CODINSPE');
                       Params[0].Value:=ValueByName[FIELD_CODINSPE];
                       OPEN;

                     IF  trim(FieldByName('CODINSPE').AsString)='' then
                       BEGIN

                               cont_reenvio:=1;
                               Close;
                               SQL.Clear;
                               SQLConnection:=mybd;
                               SQL.Add('insert into tcantreenviolinea  (codinspe, reenvios) values (:CODINSPE,:reenvios)');
                               Params[0].Value:=ValueByName[FIELD_CODINSPE];
                               Params[1].Value:=cont_reenvio;
                               ExecSQL

                       END else
                        begin
                           // nuevo_reenvio:= FieldByName('reenvios').asinteger + 1;
                               Close;
                               SQL.Clear;
                               SQLConnection:=mybd;
                               SQL.Add('update tcantreenviolinea  set reenvios=reenvios  + 1  where CODINSPE = :CODINSPE');
                              // Params[0].Value:=nuevo_reenvio;
                               Params[0].Value:=ValueByName[FIELD_CODINSPE];
                               ExecSQL

                        end;
                 finally
                  free;
                 end;


                  end
                else
                  MessageDlg('PLANTA DE VERIFICACION','EN ESTE MOMENTO NO SE PUEDE EFECTUAR DICHA OPERACIÓN, ESPERE UNOS SEGUNDOS E INTÉNTELO DE NUEVO, SI EL PROBLEMA PERSISTE CONTACTE CON SU DISTRIUBIDOR', mtWarning,[mbOk], mbOk,0);
////////////////////////////////////////////////////////////////////////////////////////////////////
              finally
                free;
              end;
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
end;

procedure TFrmLinea.BtnCancelarClick(Sender: TObject);
var
  sClave : string;
  sChar : string;
  sMensaje : string;
begin
    //Cancela la inspeccion
If ((Finspecciones=nil) or (FInspecciones.IsNew)) then
  Exit;
if EdtBuscar.Visible then
  EdtBuscarExit(Sender);
    try
    with FInspecciones do
      if not (Finspecciones.IsBlockByUser) then
        begin
          sClave := ValueByName[FIELD_EJERCICI] + ',' + ValueByName[FIELD_CODINSPE];
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
          end;  // case

          if MessageDlg('PLANTA DE VERIFICACION',sMensaje,mtInformation,[mbIgnore, mbCancel],mbIgnore,0) = mrIgnore then
            begin
              if Not Finspecciones.Cancelar then
                begin
                  MessageDlg('PLANTA DE VERIFICACION','EN ESTE MOMENTO NO SE PUEDE EFECTUAR DICHA OPERACIÓN, ESPERE UNOS SEGUNDOS E INTÉNTELO DE NUEVO, SI EL PROBLEMA PERSISTE CONTACTE CON SU DISTRIUBIDOR',
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


procedure TFrmLinea.DBGTESTADOINSPBDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
    Cad: String;
    idx: Integer;
begin
    //Dibuja en las celdas en funcion de los valores contenidos en Tipo y Estado segun
    //los valores guardados dentro de los arrays de USagEstacion
If ((not(FInspecciones.Active)) or (FInspecciones.RecordCount=0)) then
  Exit;
IF Column.Index = 2 then //columna de estados
  begin
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
else
  begin  //Tipo
    if Column.Index=0 then
      begin
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


procedure TFrmLinea.BtnInterfazMouseMove(Sender: TObject;
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


procedure TFrmLinea.RecuperardeStandByClick(Sender: TObject);
begin
//Recupèrar un StandBy de nuevo a la linea de inspecciones
If ((Finspecciones=nil) or (FInspecciones.IsNew)) then
  Exit;
if not (Finspecciones.IsBlockByUser) then
  if MessageDlg('PLANTA DE VERIFICACION',MQ_TO_INSPECTION_LINE,mtInformation,[mbIgnore,mbCancel],mbIgnore,0) = mrIgnore then
  begin
    Finspecciones.UnStandBy;  // <- Se modifico el 19/10/07
    FInspecciones.Refresh;
    Refrescar;
  end;
end;


procedure TFrmLinea.InspectionSourceDataChange(Sender: TObject;
  Field: TField);
begin
    //cambian los datos y actualiza el estado de algunos botones
    If ((((Sender as TDataSource).DataSet<>nil) and ((Sender as TDataSource).DataSet.Active)) and (not(Finspecciones.IsNew)))
    then begin
        Try
            If FInspecciones.ValueByName[FIELD_ESTADO][1] = E_STANDBY
            then
                RecuperardeStandBy.Enabled:=True
            else
                RecuperardeStandBy.Enabled:=False;
        Except
           RecuperardeStandBy.Enabled:=False;
        end;

        Try
            If FInspecciones.ValueByName[FIELD_ESTADO][1] in ([E_RECIBIDO_OK,E_STANDBY])
            then
                BtnVerificar.Enabled:=True
            else
                BtnVerificar.Enabled:=False;
        Except
           BtnVerificar.Enabled:=False;
        end;

        Try
            if FInspecciones.ValueByName[FIELD_ESTADO][1] in ([E_PENDIENTE_FACTURAR])
            then
                BtnReiniciar.Enabled:=False
            else
                BtnReiniciar.Enabled:=True;
        Except
           BtnReiniciar.Enabled:=False;
        end;
    end;
end;


procedure TFrmLinea.DBGTESTADOINSPBDblClick(Sender: TObject);
begin
    //Si hacemos dobleclick en una inspeccion dispuesta para finalizar, tiene el boton habilitado'
    //pasa al form de finalizacion de inspecciones
If BtnVerificar.Enabled then
  BtnVerificarClick(Sender);
end;


procedure DoVerVehiculos(const aBD : tSQLConnection; aOwner: TComponent);
begin
if FrmLinea=nil then
  begin
    fOwner := Tform(aOwner);
    FrmLinea:= TFrmLinea.CreateFromDataBase(Application, aBD);
    with FrmLinea do
      try
        try
          //ShowModal;
        except
          on E: Exception do
            begin
              fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL,'Error intentando visualizar los vehículos en la planta por: %s ', [E.message]);
              MessageDlg(Application.Title,'No pueden visualizarse los vehículos en la planta. Intentelo de nuevo y si el error persiste, contacte con el jefe de la planta.',mtInformation,[mbOk],mbOk,0);
            end;
          end;
      finally
        //Free;
      end;
  end;
end;

procedure TFrmLinea.FormActivate(Sender: TObject);
begin
(Sender as Tform).Windowstate:=wsMaximized;
end;


procedure TFrmLinea.bSalirClick(Sender: TObject);
begin
Self.Tag:=0;
TimerReloj.Enabled:=False;
Application.ProcessMessages;
FrmLinea.Close;
FrmLinea:=nil;
Sendmessage(fOwner.Handle,WM_SHOW_IMAGE,0,0);
end;


procedure TFrmLinea.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caFree;
end;

Procedure TFrmLinea.UpdateLineaInspeccion(var msg:tmessage);
begin
If Self.Tag = 1 then
  begin
    if BtnInterfaz.Layout=blGlyphTop then
      begin
        If Chr(msg.LParam+64) in ([E_RECIBIDO_OK,E_STANDBY]) then
          begin
            FInspecciones.Refresh;
            Refrescar;
          end;
      end
    else
      begin
        FInspecciones.Refresh;
        Refrescar;
      end;
    TmGNC.enabled :=  VehiculosEnLineaGNC;
    if not TmGNC.enabled then
      PGNC.Visible := false;
  end;
end;


Procedure TFrmLinea.DeleteEndingInspections;
var
aQ: TsqlQuery;
begin
//Borra las inspecciones finalizadas
aQ:=TsqlQuery.Create(nil);
With aQ do
  Try
    SQLConnection:=FDataBase;
    Sql.Add(Format('DELETE TESTADOINSP WHERE ESTADO IN (''%S'',''%S'')',[E_ANULADO,E_FINALIZADO]));
    ExecSql;
  Finally
    Close;
    Free;
  end;
end;


procedure TFrmLinea.DBGTESTADOINSPBKeyPress(Sender: TObject;
  var Key: Char);
begin
If key=chr(vk_return) then
  DBGTESTADOINSPBDblClick(sender);
end;


Function TFrmLinea.VehiculosEnLineaGNC: boolean;
begin
    result := false;
    FInspGNC := nil;
    try
      FInspGNC := TEstadoInspGNC.CreateAutosEnEspera(fDataBase);
      FInspGNC.Open;
      if FInspGNC.RecordCount > 0  then
        result := true;
    finally
      FInspGNC.free;
    end;
end;

procedure TFrmLinea.TmGNCTimer(Sender: TObject);
begin
  PGNC.Visible := not PGNC.Visible;
end;

procedure TFrmLinea.FormResize(Sender: TObject);
begin
  with DBGTESTADOINSPB do
    if screen.Width = Minima then
      begin
        Columns[0].Width := 95;
        Columns[1].Width := 80;
        Columns[2].Width := 110;
        Columns[3].Width := 175;
        Columns[4].Width := 175;
        Columns[5].Width := 128;
      end
    else
    if screen.Width >= Maxima then
      begin
        Columns[0].Width := 125;
        Columns[1].Width := 110;
        Columns[2].Width := 140;
        Columns[3].Width := 225;
        Columns[4].Width := 225;
        Columns[5].Width := 160;
      end;
end;

end.//Final de la unidad





