unit USucesos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, 
  Menus, ExtCtrls, StdCtrls, Buttons;

type
  TFSucesos = class(TForm)
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
  FSucesos: TFSucesos;

implementation

{$R *.DFM}

procedure TFSucesos.Limpiar1Click(Sender: TObject);
begin
  MemoErrores.Lines.Clear;
end;

procedure TFSucesos.FormDeactivate(Sender: TObject);
begin
  Hide;
end;

procedure TFSucesos.FormCreate(Sender: TObject);
begin
  Caption := 'Visor de Sucesos en Lectura de Línea';
end;

end.
