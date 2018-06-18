unit Unitincedencias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ComCtrls, Buttons, WinSkinData, StdCtrls,Globals, Menus,
  ExtCtrls;

type
  Tprincipal = class(TForm)
    StatusBar1: TStatusBar;
    SkinData1: TSkinData;
    MainMenu1: TMainMenu;
    Incidencias1: TMenuItem;
    RestaurarObleas1: TMenuItem;
    N1: TMenuItem;
    CambiarObleaaunaInspeccin1: TMenuItem;
    N2: TMenuItem;
    CambiodePatentes1: TMenuItem;
    Registros1: TMenuItem;
    N3: TMenuItem;
    CambiodeDNI1: TMenuItem;
    N4: TMenuItem;
    CambiarClienteaInspeccin1: TMenuItem;
    Timer1: TTimer;
    procedure RestaurarObleas1Click(Sender: TObject);
    procedure CambiarObleaaunaInspeccin1Click(Sender: TObject);
    procedure CambiodePatentes1Click(Sender: TObject);
    procedure CambiodeDNI1Click(Sender: TObject);
    procedure CambiarClienteaInspeccin1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  principal: Tprincipal;

implementation

uses Unitcambiar_oblea, Unitcambiar_oblea_a_inspec,
  Unitcambio_de_pantentes, Unitcambio_de_dni,
  Unitcambiar_cliente_a_inspeccion;

{$R *.dfm}

procedure Tprincipal.RestaurarObleas1Click(Sender: TObject);
begin
cambiar_oblea.Edit1.CLEAR;
cambiar_oblea.showmodal;
end;

procedure Tprincipal.CambiarObleaaunaInspeccin1Click(Sender: TObject);
begin
cambiar_oblea_a_inspec.Edit1.CLEAR;
cambiar_oblea_a_inspec.Edit2.CLEAR;
cambiar_oblea_a_inspec.showmodal;
end;

procedure Tprincipal.CambiodePatentes1Click(Sender: TObject);
begin
cambio_de_pantentes.showmodal;
end;

procedure Tprincipal.CambiodeDNI1Click(Sender: TObject);
begin
cambio_de_dni.showmodal;
end;

procedure Tprincipal.CambiarClienteaInspeccin1Click(Sender: TObject);
begin
cambiar_cliente_a_inspeccion.showmodal;
end;

procedure Tprincipal.Timer1Timer(Sender: TObject);
begin
STATUSBAR1.Panels[0].Text:='  '+DATETOSTR(DATE);
STATUSBAR1.Panels[1].Text:='  '+TIMETOSTR(time);

end;

procedure Tprincipal.FormActivate(Sender: TObject);
begin
STATUSBAR1.Panels[2].Text:='  Usuario: Ramiro Torreblanca';
end;

end.
