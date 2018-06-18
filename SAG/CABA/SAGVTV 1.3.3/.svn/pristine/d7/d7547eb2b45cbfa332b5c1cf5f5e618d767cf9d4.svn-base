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
  FrmSucesos: TFrmSucesos = NIL;

implementation

uses
  ULogs;

{$R *.DFM}
const
  FICHERO_ACTUAL = 'USucesos.pas';

procedure TFrmSucesos.Limpiar1Click(Sender: TObject);
begin
  MemoErrores.Lines.Clear;
end;

procedure TFrmSucesos.FormDeactivate(Sender: TObject);
begin
  Hide;
  {$IFDEF TRAZAS}
    fTrazas.PonComponente(TRAZA_FORM, 0, FICHERO_ACTUAL, self);
  {$ENDIF}
end;

procedure TFrmSucesos.FormCreate(Sender: TObject);
begin
  FrmSucesos.Caption := 'Visor de Sucesos de Impresión';
end;

initialization

    if not Assigned(FrmSucesos)
    then FrmSucesos := TFrmSucesos.Create(Application);

finalization

    if not Assigned(FrmSucesos)
    then FrmSucesos.Free;

end.
