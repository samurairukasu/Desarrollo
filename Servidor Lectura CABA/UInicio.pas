unit UInicio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, UVersion, UCambDir, CommCtrl;

type
  TFrmInicio = class(TForm)
    Progreso: TProgressBar;
    Panel1: TPanel;
    Image1: TImage;
    Bevel1: TBevel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    Procedure Inicializar(Gestor:TThreadMethod);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInicio: TFrmInicio;  
  Inicial: TModalResult;

implementation

{$R *.DFM}

uses
  UModDat,
  Globals;


procedure TFrmInicio.FormCreate(Sender: TObject);
begin
    Caption := LITERAL_VERSION;
    Inicial:=MrNone;
end;


Procedure TFrmInicio.Inicializar(Gestor:TThreadMethod);
var
Directorio_Aux: String;
begin
caption:=APP_TITLE;
Refresh;
Application.ProcessMessages;
//Realiza los test de inicialización
  Try
    Label1.Caption:='Realizando Test de Directorios';
    TestOfDirectories;
    If InitializationError then
      Exit;
    Label1.Caption:='Realizando Test de Licencia';
    Progreso.Position:=15;
    Application.ProcessMessages;
    sleep(1500);

//TestOfLicencia;
    If InitializationError Then
      Exit;
    label1.Caption:='Realizando Test de Base de Datos';
    Application.ProcessMessages;
    Progreso.Position:=30;

    //TestOfBD('','','',false);
    If InitializationError Then
      Exit;
    Label1.Caption:='Realizando Test de Errores';
    Application.ProcessMessages;
    Progreso.Position:=45;

    TestOfBugs;
    If InitializationError Then
      Exit;
    Label1.Caption:='Realizando Test del Terminal';
    Application.ProcessMessages;
    Progreso.Position:=60;

    TestOfTerminal;
    If InitializationError Then
      Exit;
    Label1.Caption:='Inicialización del Servidor';
    Application.ProcessMessages;
    Progreso.Position:=75;

    If InitializationError Then
      Exit;
    Label1.Caption:='Abriendo tablas temporales';
    Application.ProcessMessages;
    Progreso.Position:=90;
   // DataDiccionario.ConexionABDOk;

    If InitializationError Then
      Exit;
    Label1.Caption:='Iniciado subprocesos de escucha';
    Application.ProcessMessages;
    Progreso.Position:=100;

    Directorio_Aux:=DirectorioOut;
    if (Copy(Directorio_aux,Length(Directorio_Aux),1)='\') Then
      Directorio_Aux:=Copy(Directorio_Aux,1,Length(Directorio_Aux)-1);
    ThreadCD := TCambioDirectorio.Create(Directorio_Aux,False,Gestor);

    Finally
      if InitializationError Then
        Inicial:=mrCancel
      else
        Inicial:=mrOk;
    end;
end;


procedure TFrmInicio.FormShow(Sender: TObject);
begin
Progreso.Perform(PBM_SETBARCOLOR, 0, ColorToRGB($000080FF));
end;

end.
