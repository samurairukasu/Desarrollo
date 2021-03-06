unit UfMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uversion, ULogs, UCHECSM, UCDialgs, globals, UTILORACLE, uStockEstacion,
  USTOCKDATA, UFInicioAplicacion, Menus, StdCtrls, Buttons, ToolWin,
  ActnMan, ActnCtrls, ActnList, XPStyleActnCtrls, RxMenus, UGetDates;

type
  TFMain = class(TForm)
    MainMenu1: TMainMenu;
    Menu11: TMenuItem;
    Menu21: TMenuItem;
    Salir1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

{$R *.dfm}

uses
uftmp,
uGetPlanta,
uGetNumero;

var
    bActivandose : boolean = TRUE;

procedure InitError(Msg: String);
begin
        MessageDlg('Error en la Inicialización',Msg,mtError,[mbOK],mbOK,0);
        if Assigned(fAnomalias)
        then fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FILE_NAME,Msg);
        InitializationError := TRUE;
        Application.Terminate;
end;

procedure TFMain.FormShow(Sender: TObject);
var
        Ahora : tDateTime;
begin

        if bActivandose
        then begin

            Top := -7000;

            if (FindWindow(Pchar('TFInicioAplicacion'), PChar(NOMBRE_PROYECTO)) <> 0) or (FindWindow(Pchar('TFMain'), PChar('Nombre Del Proyecto')) <> 0)
            then InitError('Ya existe una copia del programa en ejecución')
            else
              InitLogs;

            if InitializationError
            then exit;
            Caption := 'Proyecto';

            bActivandose := FALSE;

            with TFInicioAplicacion.Create(Application) do
            try
                {$IFDEF TRAZAS}
                fTrazas.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'%S', [LITERAL_VERSION]);
                {$ENDIF}

                Status.Caption := Format('%S (Comprobando su sistema)', [LITERAL_VERSION]);
                Show;

                Application.ProcessMessages;
                {!!!!!!!!!!!}

                if InitializationError
                then exit;
                Status.Caption := Format('%S (Comprobando su estructura)', [LITERAL_VERSION]);
                Application.ProcessMessages;

                if InitializationError
                then exit;

                TestOfDirectories;

                Status.Caption := Format('%S (Conectándose al servidor)', [LITERAL_VERSION]);
                Application.ProcessMessages;
                If ParamCount=0
                then
                    TestOfBD('','','')
                else begin
                    If ParamCount=1
                    Then begin
                        TestOfBD(ParamStr(1),'','');
                    end
                    else begin
                        If ParamCount=3
                        Then begin
                            TestOfBD(ParamStr(1),ParamStr(2),ParamStr(3));
                        end
                        else begin
                            TestOfBD('','','');
                        end;

                    end;
                end;
                if InitializationError
                then exit;
                Application.ProcessMessages;
                InitAplicationGlobalTables;
                if InitializationError
                then exit;

                Ahora := Now;
                while Now <= (Ahora + EncodeTime(0,0,3,0)) do Application.ProcessMessages;
            finally
              free;
            end;
            Top := Top + 7000;
            Application.ProcessMessages;
        end;

end;

procedure TFMain.Salir1Click(Sender: TObject);
begin
  application.Terminate;
end;

end.
