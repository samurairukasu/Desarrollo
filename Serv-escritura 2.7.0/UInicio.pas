unit UInicio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ExtCtrls, StdCtrls, ComCtrls, CommCtrl;


type
  TFrmInicio = class(TForm)
    Progreso: TProgressBar;
    Bevel1: TBevel;
    Image1: TImage;
    Label1: TLabel;
    Panel1: TPanel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure Inicializar;
  end;

var
  FrmInicio: TFrmInicio;
  Inicio: TModalResult;

implementation

{$R *.DFM}

Uses Globals, UVersion, UCDialgs;

Procedure TFrmInicio.Inicializar;
begin
Caption:= APP_TITLE;
Application.ProcessMessages;
  Try
    Label1.Caption:='Realizando Test de Directorios';
    TestOfDirectories;
    If InitializationError Then
      Exit;
    Label1.Caption:='Realizando Test de Licencia';
    Progreso.Position:=20;
    Application.ProcessMessages;
    Sleep(1500);
    If InitializationError Then
      Exit;
    Label1.Caption:='Realizando Test de Base de Datos';
    Progreso.Position:=40;
    Application.ProcessMessages;

    If ParamCount=0 then
      TestOfBD('','','',false)
    else
      begin
      If ParamCount=1 Then
        begin

         TestOfBD(ParamStr(1),'','',false);
        end
      else
        begin
        If ParamCount=3 Then
          begin
          Application.ProcessMessages;
          testOfBD(ParamStr(1),ParamStr(2),ParamStr(3),false);
          end
        else
          begin
          TestOfBD('','','',false);
          end;
        end;
      end;

    If InitializationError Then Exit;
    Label1.Caption:='Realizando Test de Errores';
    Progreso.Position:=60;
    Application.ProcessMessages;

    TestOfBugs;
    If InitializationError Then Exit;
    Label1.Caption:='Realizando Test del Terminal';
    Progreso.Position:=80;
    Application.ProcessMessages;

    TestOfTerminal;
    InitAplicationGlobalTables;
    If InitializationError Then
      Exit;
    Label1.Caption:='Finalizando Inicialización del Servidor';
    Progreso.Position:=100;
    Application.ProcessMessages;

    Finally
      if InitializationError Then
        Inicio:=mrCancel
      else
        Inicio:=mrOk;
    end;
    ModalResult:=inicio;
end;


procedure TFrmInicio.FormShow(Sender: TObject);
begin
Progreso.Perform(PBM_SETBARCOLOR, 0, ColorToRGB(clGreen));
end;

end.
