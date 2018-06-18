unit UWraMaha;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DB, ULogs, StdCtrls, Menus, Buttons, SpeedBar,
  ComCtrls, RXShell, Animate, GIFCtrl, UThread, sqlexpr, XPMan;

const
  FICHERO_ACTUAL = 'UWraMaha.Pas';      
  WM_LINEAINSP = WM_USER+10;

type
  TFrmES_IN = class(TForm)
    RxTrayIcon1: TRxTrayIcon;
    Bevel3: TBevel;
    GIF: TRxGIFAnimator;
    Label1: TLabel;
    Bevel2: TBevel;
    BtnArrancar: TSpeedButton;
    BtnParar: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Timer1: TTimer;
    Label2: TLabel;
    XPManifest1: TXPManifest;
    Bevel1: TBevel;
    procedure TimerProcesoEscrituraTimer(Sender: TObject);
    procedure TimerComprobarProcesoEscirituraTimer(Sender: TObject);
    procedure BtnPararClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure BtnArrancarClick(Sender: TObject);
    procedure BtnSalirClick(Sender: TObject);
    procedure BtnSucesosClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    Thread: TProcessThread;
    fProcessing, FStarted: Boolean;
    procedure EscribirFicherosEnES_IN;
    Function  InciarAplicacion:Boolean;
    Procedure LimpiarInspeccionesFinalizadas;
  public
    { Public declarations }    
    Procedure UpdateLineaInspeccion(var msg:tmessage);message WM_LINEAINSP;
  end;

var
  FrmES_IN: TFrmES_IN;

implementation

{$R *.DFM}

uses
  UModDat, UTiposIN, UWrES_IN, UCDialgs, UInicio, USucesos, Globals, utilOracle, UendApplicationform,
  DBClient, UVersion;

var
  Inicializacion: Boolean;

const
  DATOS_VERSION= NOMBRE_PROYECTO+' '+VERSION;


procedure TFrmES_IN.EscribirFicherosEnES_IN;
const
EJERCICIO         = 'EJERCICI';
CODIGO_INSPECCION = 'CODINSPE';
ESTADO            = 'ESTADO';
FECHA_INICIO      = 'HORAINIC';
MATRICULA         = 'MATRICUL';
SESION = 'SesionIN';
EN_LINEA = 'B';
var
I : Integer;
aMatricula, aFecha : string;
Begin
While fProcessing do
  Application.ProcessMessages;
  try
    Sleep(100);
    fProcessing:=True;
    Label2.Caption:=' Realizandose.';
    Label2.Font.Color:= ClGreen;
    with DataDiccionario.TESTADOINSP do
      begin
        try
        { Se ordena la tabla por fecha de inicio, y se filtra cogiendo las de hoy cuyo estado sea Facturado
          para generar el fichero de inicio }

          {IndexFieldNames := FECHA_INICIO;
          Filtered:=FalsE;
          Filter := FECHA_INICIO + ' >=' + '''' + DateToStr(Date) + ''' AND (' + ESTADO + '= ''A'' )';
          Filtered := True;
          Cancel;
          Refresh;}
          Close;
          //aFecha:=DateBd(MyBd);
          //PArams[0].AsString:=''''+aFecha+'''';
          //sQL.cLEAR;
          //Sql.Add('SELECT * FROM TESTADOINSP WHERE ESTADO=''A''');
          //Sql.Add(Format('SELECT * FROM TESTADOINSP WHERE ESTADO=''A'' AND HORAINIC >= ''%s''',[FormatDateTime('dd/mm/yy',StrToDate(aFecha))]));
          Open;
          First;
////////////////////////////////////////////////////////////////////////////////////////////////////
          While not Eof do
            Begin
              aMatricula :=  FieldbyName(MATRICULA).AsString;
              If GeneradoFicheroINOkDe ( FieldByName(EJERCICIO).AsInteger, FieldbyName(CODIGO_INSPECCION).AsInteger, aMatricula) then
                begin
                  Try
                    MyBD.StartTransaction(td);
                    Edit;
                    FieldByName(ESTADO).Value := EN_LINEA;
                    Post;
                    ApplyUpdates(0);
                    MyBD.Commit(td);
                    {$IFDEF TRAZAS}
                    fTrazas.PonAnotacion(TRAZA_REGISTRO,0,FICHERO_ACTUAL,'VEHICULO: ' + aMatricula + ' HA PASADO DEL ESTADO FACTURADO A VERIFICANDOSE');
                    {$ENDIF}
                  Except
                    On E : Exception do { HUBO UN ERROR AL INTENRAR CAMBIAR EL ESTADO, NO PROVOCA ERROR, SE GENERO EL FICHERO INI PERO NO SE CAMBIO EL ESTADO }
                      fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL,'VEHICULO: ' + aMatricula + 'HA OBTENIDO SU FICHERO INI Y NO HA PODIDO PASAR DEL ESTADO FACTURADO A VERIFICANDOSE POR: ' + E.message);
                  End;
                end
              Else
                begin { ERROR HAY QUE MOSTRARLO no se pudo genererar el fichero de inicializacion }
                  fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'VEHICULO: ' + aMatricula + ' NO HA OBTENIDO SU FICHERO INI PERO Y NO HA PODIDO PASAR DEL ESTADO FACTURADO A VERIFICANDOSE');
//                  FrmSucesos.MemoErrores.Lines.Add('EL VEHICULO: ' + aMatricula + ' NO HA OBTENIDO SUS DATOS NECESARIOS PARA VERIFICARSE EN LA LÍNEA (POSIBLEMENE YA LOS TUVIERA)');
                end;
              Close;
              Open;
            end;
////////////////////////////////////////////////////////////////////////////////////////////////////

          except
              on E : Exception do
              begin
                  fAnomalias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'ERROR GENERANDO EL FICHERO INI PARA EL VEHICULO: ' + aMatricula + ' POR: ' + E.Message);
                  FrmSucesos.MemoErrores.Lines.Add('ERROR GRAVE EL VEHICULO: ' + aMatricula + ' NO HA OBTENIDO SUS DATOS NECESARIOS PARA VERIFICARSE EN LA LÍNEA POR: ' + E.message);
                  { ERROR GRAVE HAY QUE MOSTRARLO durante el proceso se tiene que mostrar }
              end;
          end;
      End;
  finally
      //LimpiarInspeccionesFinalizadas;
      fProcessing:=False;
  end;
end;



procedure TFrmES_IN.BtnPararClick(Sender: TObject);
begin
fStarted:=false;
{$IFDEF TRAZAS}
fTrazas.PonAnotacion(TRAZA_USUARIO,0,FICHERO_ACTUAL, 'EL USUARAIO HA ELEGIDO PARAR EL SERVIDOR DE ESCRITURA');
{$ENDIF}
BtnArrancar.Enabled := True;
BtnParar.Enabled := False;
GIF.Animate:=false;
GIF.FrameIndex:=0;
Label2.Caption:=' Detenido.';
Label2.Font.Color:= ClRed;
RxTrayIcon1.Animated:=False;
end;


procedure TFrmES_IN.TimerProcesoEscrituraTimer(Sender: TObject);
begin
  EscribirFicherosEnES_IN;
end;


procedure TFrmES_IN.TimerComprobarProcesoEscirituraTimer(
  Sender: TObject);
begin
if Not btnParar.Enabled then
  begin
    Label2.Caption:=' Detenido.';
    Label2.Font.Color:= ClRed;
    RxTrayIcon1.Animated:=False;
  end
else
  begin
    Label2.Caption:=' Realizandose.';
    Label2.Font.Color:= ClGreen;
    RxTrayIcon1.Animated:=True;
  end;
end;


procedure TFrmES_IN.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if (label2.Caption <> ' Detenido.') then
  begin
    MessageDlg('Escritura en Línea','Pare el Servicio de Escritura en Línea antes de salir',
               mtInformation, [mbOk], mbOk, 0);
    CanClose := False;
  end
else
  CanClose := True;
end;


procedure TFrmES_IN.FormCreate(Sender: TObject);
begin
fProcessing:=False;
fStarted:=true;
Inicializacion:=True;
BtnArrancar.Enabled := True;
If InciarAplicacion then
  begin
    Show;
    Caption:= NOMBRE_PROYECTO+' '+VERSION;
  end
else
  begin
    Inicializacion:=FalsE;
    Application.terminate;
  end;
end;

procedure TFrmES_IN.BtnArrancarClick(Sender: TObject);
begin
{$IFDEF TRAZAS}
fTrazas.PonAnotacion(TRAZA_USUARIO,0,FICHERO_ACTUAL, 'EL USUARAIO HA ELEGIDO ARRANCAR EL SERVIDOR DE ESCRITURA');
{$ENDIF}
BtnArrancar.Enabled := False;
BtnParar.Enabled := True;
//TimerProcesoEscritura.Enabled := True;
GIF.Animate:=true;
Label2.Caption:=' Realizandose.';
Label2.Font.Color:= ClGreen;
RxTrayIcon1.Animated:=True;
FStarted:=true;
TimerProcesoEscrituraTimer(Self);
end;

procedure TFrmES_IN.BtnSalirClick(Sender: TObject);
begin
{$IFDEF TRAZAS}
fTrazas.PonAnotacion(TRAZA_USUARIO,0,FICHERO_ACTUAL, 'EL USUARAIO HA ELEGIDO SALIR DEL SERVIDOR DE ESCRITURA');
{$ENDIF}
Close;
end;

procedure TFrmES_IN.BtnSucesosClick(Sender: TObject);
begin
{$IFDEF TRAZAS}
fTrazas.PonAnotacion(TRAZA_USUARIO,0,FICHERO_ACTUAL, 'EL USUARAIO HA ELEGIDO VER LOS SUCESOS DEL SERVIDOR DE ESCRITURA');
{$ENDIF}
With TFrmSucesos.Create(Application) do
  try
    ShowModal;
  finally
    free;
  end;
end;

procedure TFrmES_IN.FormActivate(Sender: TObject);
begin
If Not Inicializacion Then
  Application.Terminate;
end;

Function  TFrmES_IN.InciarAplicacion:Boolean;
var
Iniciar : TFrmInicio;
begin
//Inicializar aplicacion
Result:=False;
if FindWindow(nil,APP_TITLE) <> 0 then
  begin
    ShowMessage('Lectura de Línea','Ya existe una copia del programa en ejecución');
    Inicio:=mrCancel;
    Application.Terminate;
  end
else
  Begin
    Iniciar := TFrmInicio.Create(Application);
    With iniciar do
      Try
        Show;
        Inicializar;
        Hide;
        if inicio = mrok then
          Result:=True;
      Finally
        Free;
      end;
  end;
end;


Procedure TFrmES_IN.LimpiarInspeccionesFinalizadas;
Const
SQL_DELETE_END_INSPECTIONS = 'DELETE TESTADOINSP WHERE ESTADO = ''F''';
var
aQ: TSQLQuery;
begin
MyBD.ExecuteDirect(SQL_DELETE_END_INSPECTIONS);
end;


procedure TFrmES_IN.FormShow(Sender: TObject);
begin
  {$IFDEF TRAZAS}
  fTrazas.PonAnotacion(TRAZA_USUARIO,0,FICHERO_ACTUAL, 'EL USUARAIO HA ELEGIDO ARRANCAR EL SERVIDOR DE ESCRITURA');
  {$ENDIF}
  BtnArrancar.Enabled := False;
  BtnParar.Enabled := True;
  Label2.Caption:=' Realizandose.';
  Label2.Font.Color:= ClGreen;
  RxTrayIcon1.Animated:=True;
  Thread := nil;
  Thread:= TProcessThread.Create (MyBd,self,1);
  DataDiccionario.ConexionABDOk;
  fStarted:=true;
  TimerProcesoEscrituraTimer(Self);
end;


procedure TFrmES_IN.FormDestroy(Sender: TObject);
begin
if Thread <> nil then Thread.Finaliza;
end;


procedure TFrmES_IN.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Enabled:=false;
  With TEndApplicationForm.Create(Application) do
    Try
      Show;
      Thread.Finaliza;
      while not Thread.EndReached do Application.ProcessMessages;
      Thread.Free;
      Hide;
    Finally
      Free;
    end;
Application.Terminate;
end;


Procedure TFrmES_IN.UpdateLineaInspeccion(var msg:tmessage);
begin
//Cambio en la linea de isnpeccion
If ((Msg.LParam=1) and (FStarted)) then
  TimerProcesoEscrituraTimer(Self);
end;


procedure TFrmES_IN.Timer1Timer(Sender: TObject);
begin
GIF.Refresh;
end;

end.//final de la unidad
