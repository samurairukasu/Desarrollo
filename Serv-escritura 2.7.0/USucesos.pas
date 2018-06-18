unit USucesos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, UCDialgs,
  Menus, ExtCtrls, StdCtrls, Buttons;

type
  TFrmSucesos = class(TForm)
    MemoErrores: TMemo;
    MainMenu1: TMainMenu;
    Limpiar1: TMenuItem;
    procedure Limpiar1Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSucesos: TFrmSucesos;

implementation



{$R *.DFM}

procedure TFrmSucesos.Limpiar1Click(Sender: TObject);
begin
  MemoErrores.Lines.Clear;
end;

procedure TFrmSucesos.FormDeactivate(Sender: TObject);
begin
  Hide;
end;

procedure TFrmSucesos.FormCreate(Sender: TObject);
begin
  FrmSucesos.Caption := 'Visor de Sucesos del Servidor de Escritura.';
end;

end.
