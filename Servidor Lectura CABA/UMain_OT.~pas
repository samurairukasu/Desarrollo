unit UMain_OT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, UCDialgs,
  ExtCtrls, StdCtrls, ComCtrls, Buttons, Menus, UInspeOT,
  UInicio, SpeedBar, RXShell, Animate, GIFCtrl, USucesos, OleCtrls,
  XPMan, DB, RxMemDS, FMTBcd, SqlExpr;


type
  TFrmES_OUT = class(TForm)
    IconoNormal: TImage;
    IconoWarning: TImage;
    IconoStop: TImage;
    PopupMenu1: TPopupMenu;
    Sucesos1: TMenuItem;
    N2: TMenuItem;
    Propiedades1: TMenuItem;
    Version1: TMenuItem;
    RxTrayIcon1: TRxTrayIcon;
    BtnArrancar: TSpeedButton;
    BtnParar: TSpeedButton;
    BtnSucesos: TSpeedButton;
    BtnSalir: TSpeedButton;
    Bevel1: TBevel;
    XPManifest1: TXPManifest;
    GIF: TRxGIFAnimator;
    Timer1: TTimer;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label1: TLabel;
    Estado: TLabel;
    Timer2: TTimer;
    SQLStoredProc1: TSQLStoredProc;
    SpeedButton1: TSpeedButton;
    procedure BtnParar_Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnArrancarClick(Sender: TObject);
    procedure BtnSucesosClick(Sender: TObject);
    procedure BtnSalirClick(Sender: TObject);
    procedure Version1Click(Sender: TObject);
    procedure AppIconizada_DblClick(Sender: TObject);
    procedure LeerDatosDeMaha;
    procedure Propiedades1Click(Sender: TObject);
    procedure PonerIconoWarning;
    procedure PonerIconoNormal;
    procedure PonerIconoStop;
    procedure OcultarFicha(Sender : TObject);
    procedure TimerComprobarLecturaTimer(Sender: TObject);
    procedure TimerProcesoLecturaTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnPararClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure timerfacturaTimer(Sender: TObject);
    procedure timercerTimer(Sender: TObject);
    procedure BtnDesbloquearClick(Sender: TObject);
  private
    { Private declarations }
    fProcessing, fStarted: Boolean;
    Procedure IniciarAplicacion(Gestor:TThreadMethod);
  public
    { Public declarations }
    FrmSucesos : TFSucesos;
    Procedure RefrescoDirectorio;

  end;

var
  FrmES_OUT: TFrmES_OUT;
  bPulsadoExit : Boolean = False;
  Inicio: TModalResult;
  Archivos: Integer;
  
implementation


uses
  UVersion,
  UModDat,
  UrES_OUT,
  ULogs,
  UConfgOT,
  UAbout,
  Globals,
  UCambDir;



const
    FICHERO_ACTUAL = 'UMain_OT.pas';
    NO_HAY_ERROR = 0;
    ERR_FICHERO_INI_NO_COMPLETO = 1;
    DATOS_VERSION= NOMBRE_PROYECTO+' 5.5.2';

ResourceString
    MSJ_ERR_GENERAL = 'Error General En Servisor de Lectura - ';

{$R *.DFM}

var
    Inicializacion: Boolean;
    Iniciar : TFrmInicio;


function DIRECTORIO_TRAZAS : String;
begin
    Result:=ExtractFilePath(fAnomalias.FileHandle)
end;

function Borrar_Fichero (const Nombre: string) : Boolean;
var
  F : file;
begin
  try
    AssignFile (F,  Nombre);
    Erase(F);
    result := True;
  except
    on E:Exception do
     begin
//       fAnomalias.PonAnotacion (TRAZA_SIEMPRE,0,FICHERO_ACTUAL,'NO SE PUDO BORRAR EL FICHERO POR: ' + E.Message);  LUCHO
       result := False;
     end;
  end;
end;


function Mover_Fichero (const Nombre: string) : boolean;
var
  F: File;
begin
  try
   // Borrar_Fichero(DIRECTORIO_TRAZAS + ExtractFileName(Nombre) {+ '.txt'});
    AssignFile (F,  Nombre);
    Rename (F, DIRECTORIO_TRAZAS + Copy(ExtractFileName(Nombre), 0, Length(ExtractFileName(Nombre))-4)+'-'+FormatDateTime('ddmmyyyy-hhnnss', Now()) + '.txt');
    Result := True;
  except
    on E:Exception do
    begin
       fAnomalias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'NO SE PUDO MOVER EL FICHERO POR: ' + E.Message);
       result := False;
    end;
 end;
end;


Procedure TFrmES_OUT.LeerDatosDeMaha;
const
  RECIBIDO_OK = 'C';
  RECIBIDO_NOK = 'D';
  NADA = 0;
  BORRAR = 1;
  MOVER = 2;
  INTENTOS_POR_FICHERO = 1;
  PRIMER_INTENTO = 1;
var
  iEjercicio, iCodigo, iHuboError : integer;
  iAccionATomar : integer;
  Resultado : integer;
  Intentos : Integer;
  FicherosBuscados : TSearchRec;
  isSBy: boolean;
  NombreArchivo: String;
begin

{AHORA Y PORQUE SON PRUEBAS SE LEE UN SOLO FICHERO DE INICIALIZACION QUE YA EXISTEN EN EL DIRECTORIO ES_OUT
*.* se supone que solo habra ficheros de maha }
Timer2.Enabled:=false;
Estado.Caption:=' Realizándoze.';
//DirectorioOut:='C:\Argentin\SagVTV\ES_OUT\';
Resultado := FindFirst(DirectorioOut + '*.*' {+Extension}, faAnyFile, FicherosBuscados);
While Resultado = 0 do
  begin{ LOS DIRECTORIOS QUE LEE SIEMPRE AL PRINCIPIO SON EL . Y EL ..  }
    if (ficherosBuscados.Name <> '.') and (ficherosBuscados.Name <> '..') then
    begin
    for Intentos := PRIMER_INTENTO to INTENTOS_POR_FICHERO do
      begin
      {$IFDEF TRAZAS}
      if UpperCase(ExtractFileName((FicherosBuscados.Name))) <> 'CONTROL' then
      fTrazas.PonAnotacion(TRAZA_BUCLES,0,FICHERO_ACTUAL,'SE ENCUENTRA EL FICHERO: ' + ficherosBuscados.Name  + ' ENVIADO POR MAHA Y SE VA A TRATAR POR: ' + IntToStr(Intentos) + ' VEZ');
      {$ENDIF}
      MyBd.STARTTRANSACTION(td);
      InterpretarFichero (DirectorioOut + (ExtractFileName(FicherosBuscados.Name)),iHuboError, iEjercicio, iCodigo, IsSBy);
      case iHuboError of
        NO_HAY_ERROR:
          begin
            MyBd.COMMIT(td);
            if not PasadaInspeccion(iEjercicio, iCodigo, isSBy) then
              begin
                FrmSucesos.MemoErrores.Lines.Add(MSJ_ERR_GENERAL + FicherosBuscados.Name);
                PonerIconoWarning;
              end;
            break;
          end;
        ERR_FICHERO_INI_NO_COMPLETO:
          begin
            MyBd.ROLLBACK(td);
            break;
          end;
      else
        MyBd.ROLLBACK(td);
      end; // Case
    end; // foor
// CAMBIO DE ESTADO:
    case iHuboError of
    NO_HAY_ERROR:
      if not DataDiccionario.CambiarEstadoInspeccionOk (iEjercicio, iCodigo, RECIBIDO_OK, ChangeFileExt(ExtractFileName(ficherosBuscados.Name),'')) then
        begin
          iAccionATomar := MOVER;
          FrmSucesos.MemoErrores.Lines.Add(MSJ_ERR_GENERAL + FicherosBuscados.Name);
          PonerIconoWarning;
        end
      else
        begin
        iAccionATomar := BORRAR;
        end;
    ERR_FICHERO_INI_NO_COMPLETO:  iAccionATomar := NADA;
    else
      begin
        iAccionATomar := MOVER;
        if not DataDiccionario.CambiarEstadoInspeccionOk (iEjercicio, iCodigo, RECIBIDO_NOK, ChangeFileExt(ExtractFileName(ficherosBuscados.Name),'')) then
          FrmSucesos.MemoErrores.Lines.Add(MSJ_ERR_GENERAL + FicherosBuscados.Name);
          PonerIconoWarning;
      end;
    end;
    if iAccionATomar = BORRAR then
      begin
        {$IFDEF DEPURACION}
        if not Mover_Fichero(DirectorioOut + FicherosBuscados.Name) then
          begin
            FrmSucesos.MemoErrores.Lines.Add('No se pudo mover el fichero: ' + FicherosBuscados.Name + ' al directorio de traceado');
            PonerIconoWarning;
          end;
        {$ELSE}
        if not Borrar_Fichero(DirectorioOut + FicherosBuscados.Name) then
          begin
            FrmSucesos.MemoErrores.Lines.Add('No se pudo borrar el fichero: ' + FicherosBuscados.Name + ' del directorio ES_OUT');
          end;
        {$ENDIF}
      end
    else
      if iAccionATomar = MOVER then
        begin
          if not Mover_Fichero(DirectorioOut + FicherosBuscados.Name) then
            begin
              FrmSucesos.MemoErrores.Lines.Add('No se pudo mover el fichero: ' + FicherosBuscados.Name + ' al directorio de traceado');
              PonerIconoWarning;
            end;
        end;
      end; //else (. y ..)
    Resultado := FindNext(FicherosBuscados); // continua en el while
    end; // while
FindClose(FicherosBuscados); // Cerrar la estructura
Timer2.Enabled:=true;
end;



procedure TFrmES_OUT.BtnParar_Click(Sender: TObject);
begin
  fStarted:=False;
{$IFDEF TRAZAS}
  fTrazas.PonAnotacion(TRAZA_USUARIO,1,FICHERO_ACTUAL,'EL USUARIO A ELEGIDO PARAR EL SERVIDOR DE LECTURA');
{$ENDIF}
  BtnArrancar.Enabled := True;
  BtnParar.Enabled := False;
  //TimerProcesoLectura.Enabled := False;
  Estado.Caption:=' Detenido.';
  PonerIconoStop;
end;



procedure TFrmES_OUT.FormCreate(Sender: TObject);
begin

      FrmSucesos := TFSucesos.Create(Application);
      Top := -7000;
      fProcessing:=false;
      fStarted:=False;
      Inicio:=mrNone;
      Inicializacion:=True;
      Estado.Caption:=' Detenido.';
      IniciarAplicacion(RefrescoDirectorio);
      Caption := DATOS_VERSION;
      If Inicio=mrOk then
      begin
        BtnArrancarClick(Sender);
        Position := poScreenCenter;
        Show;
      end
      else
      begin
        Inicializacion:=FalsE;
        Application.terminate;
      end;

end;

procedure TFrmES_OUT.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    if (Estado.Caption <> ' Detenido.') then
    begin
      MessageDlg('Lectura de Línea', 'Pare el Servicio de Lectura de Línea antes de salir', mtInformation, [mbOk], mbOk, 0);
      CanClose := False;
      bPulsadoExit := False;
    end
    else begin
      CanClose := True;
    end;
end;

procedure TFrmES_OUT.BtnArrancarClick(Sender: TObject);
begin
{$IFDEF TRAZAS}
  fTrazas.PonAnotacion(TRAZA_USUARIO,1,FICHERO_ACTUAL,'EL USUARIO A ELEGIDO ARRANCAR EL SERVIDOR DE LECTURA');
{$ENDIF}
  BtnArrancar.Enabled := False;
  BtnParar.Enabled := True;
  FrmSucesos.MemoErrores.lines.Clear;
  Estado.Caption:=' Realizándoze.';
  Gif.Animate:=true;
  Estado.Font.Color:=clGreen;
  PonerIconoNormal;
  TimerProcesoLecturaTimer(self);
  Timer2.Enabled:=true;
  fStarted:=True;
end;


procedure TFrmES_OUT.BtnSucesosClick(Sender: TObject);
begin
{$IFDEF TRAZAS}
  fTrazas.PonAnotacion(TRAZA_USUARIO,1,FICHERO_ACTUAL,'EL USUARIO A ELEGIDO VER SUCESOS DEL SERVIDOR DE LECTURA');
{$ENDIF}
  FrmSucesos.Show;
end;


procedure TFrmES_OUT.BtnSalirClick(Sender: TObject);
begin
{$IFDEF TRAZAS}
  fTrazas.PonAnotacion(TRAZA_USUARIO,1,FICHERO_ACTUAL,'EL USUARIO A ELEGIDO SALIR DEL SERVIDOR DE LECTURA');
{$ENDIF}
  bPulsadoExit := True;
  Close;
end;


procedure TFrmES_OUT.Version1Click(Sender: TObject);
begin
  AboutBox.ShowModal;
end;


procedure TFrmES_OUT.AppIconizada_DblClick(Sender: TObject);
begin
{  ShowWindow(FrmES_OUT.Handle, SW_RESTORE);
  SetForegroundWindow(Handle);}
end;


procedure TFrmES_OUT.Propiedades1Click(Sender: TObject);
begin
{  ShowWindow(FrmES_OUT.Handle, SW_RESTORE);
  SetForegroundWindow(Handle);
}
end;


procedure TFrmES_OUT.PonerIconoWarning;
begin
  {AppIconizada.Hint := IconoWarning.Hint;
  AppIconizada.Picture.Assign(IconoWarning.Picture);
  AppIconizada.Show;}
end;


procedure TFrmES_OUT.PonerIconoNormal;
begin                      
 RxTrayIcon1.Animated:=True;
end;


procedure TFrmES_OUT.PonerIconoStop;
begin
 RxTrayIcon1.Animated:=False;
end;


procedure TFrmES_OUT.OcultarFicha;
begin
  { ShowWindow(FrmES_OUT.Handle, SW_HIDE);
   ShowWindow(Application.Handle, SW_HIDE);
  }
end;

Procedure  TFrmES_OUT.IniciarAplicacion(Gestor:TThreadMethod);
var  accesos: integer;
begin
    //Inicializar aplicacion
    TestOfBD('','','',false);
    DataDiccionario.ConexionABDOk;
    try
      with DataDiccionario.QryGeneral do
      begin
        Close;
        SetProvider(DataDiccionario.dspQryGeneral);
        commandtext := 'select count(*) as accesos from TACCESOS where trim(upper(user_sag))=''SL''';
        Execute;
        open;
        accesos:=FieldByName('accesos').AsInteger;

        if (accesos>0) then
        begin
          if  Application.MessageBox( 'Ya se encuentra registrado una copia del programa en ejecución. Presione SI en caso de haber verificado que no haya otro ejecutándose y desee continuar.', 'SERVIDOR DE LECTURA',
              MB_ICONQUESTION OR MB_YESNO ) = ID_YES  then
          begin
            accesos:=0;
            commandtext := 'delete from TACCESOS where trim(upper(user_sag))=''SL''';
            Execute;
          end;
        end;

        if (accesos=0) then
        begin
          commandtext := 'INSERT INTO CABA.TACCESOS (TERMINAL, USER_SAG, FECHA_LOGIN,SAG_SID) VALUES ( null,''SL'',current_date,null)';
          Execute;
        end;
      end
      except
      on E:Exception do
      begin
        fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL,'NO SE PUEDE ACCEDER EN TACCESOS POR: ' + E.message);
      end;
    end;

    if (accesos = 0) then
    begin
        Iniciar := TFrmInicio.Create(Self);
        Try
            Iniciar.Show;
            Iniciar.Inicializar(Gestor);
            Inicio:=Inicial;
        Finally
            iniciar.Free;
        end;
    end;
end;


procedure TFrmES_OUT.TimerComprobarLecturaTimer(Sender: TObject);
begin
  Application.ProcessMessages;
  if Not BtnParar.Enabled then
  begin
    Estado.Caption:=' Detenido.';
  end
  else begin
  Estado.Caption:=' Realizándoze.';
  end;
end;


procedure TFrmES_OUT.TimerProcesoLecturaTimer(Sender: TObject);
begin
  if not CreadoFicheroControlOk(nil) then
  begin
    FrmSucesos.MemoErrores.Lines.Add('SE HAN PERDIDO FICHEROS IMPRESCINDIBLES. PARE Y REINICIE');
  end;
  //DataDiccionario.LimpiarTESTADOINSP;
  LeerDatosDeMaha;
end;


Procedure TFrmES_OUT.RefrescoDirectorio;
begin
//se ha producido un cambio en el direcorio
If (LeerVersion = SO_WINNT) then
  Begin
    If fStarted then
      begin
        while FProcessing do
          Try
            fProcessing:=True;
            TimerProcesoLecturaTimer(self);
          Finally
            fProcessing:=false;
          end;
      Application.ProcessMessages;
    end;
  end;
end;

function borrarAcceso: boolean;
begin
    try
      with DataDiccionario.QryGeneral do
      begin
        Close;
        SetProvider(DataDiccionario.dspQryGeneral);
        commandtext := 'delete from TACCESOS where trim(upper(user_sag))=''SL''';
        Execute;
        commandtext := 'commit';
        Execute;
      end
      except
      on E:Exception do
      begin
        fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL,'NO SE PUEDE BORRAR EN TACCESOS POR: ' + E.message);
      end;
    end;


end;

procedure TFrmES_OUT.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    borrarAcceso;
    ThreadCD.Terminate;
    FrmSucesos.Free;
end;


procedure TFrmES_OUT.BtnPararClick(Sender: TObject);
begin
  fStarted:=False;
  Timer2.Enabled:=false;
{$IFDEF TRAZAS}
  fTrazas.PonAnotacion(TRAZA_USUARIO,1,FICHERO_ACTUAL,'EL USUARIO A ELEGIDO PARAR EL SERVIDOR DE LECTURA');
{$ENDIF}
  BtnArrancar.Enabled := True;
  BtnParar.Enabled := False;
  Gif.Animate:=false;
  Gif.FrameIndex:=0;
  Estado.Font.Color:=clRed;
  Estado.Caption:=' Detenido.';
  PonerIconoStop;
end;


procedure TFrmES_OUT.Timer1Timer(Sender: TObject);
begin
GIF.Refresh;
end;

/////////////////////////////////// Version con SO Win2003 /////////////////////////////////////////
procedure TFrmES_OUT.Timer2Timer(Sender: TObject);
begin
If (LeerVersion = SO_WIN2003) or (LeerVersion = SO_WINXP) or ((LeerVersion = SO_WIN2000)) then
  Begin
  If fStarted and not MyBD.InTransaction and BtnParar.Enabled then
    Begin
    LiberarMemoria;
    TimerProcesoLecturaTimer(self);
    Application.ProcessMessages;
    end;
  end;
Application.ProcessMessages;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TFrmES_OUT.timerfacturaTimer(Sender: TObject);
var
direccion:string;
begin


end;

procedure TFrmES_OUT.timercerTimer(Sender: TObject);
var
direccion:string;
begin


end;

procedure TFrmES_OUT.BtnDesbloquearClick(Sender: TObject);
begin
    try
      with DataDiccionario.QryGeneral do
      begin
        Close;
        SetProvider(DataDiccionario.dspQryGeneral);
        commandtext := 'delete from TACCESOS where trim(upper(user_sag))<>''SL''';
        Execute;
        commandtext := 'commit';
        Execute;
      end
      except
      on E:Exception do
      begin
        fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL,'NO SE PUEDE BORRAR EN TACCESOS POR: ' + E.message);
      end;
    end;
end;

end.

