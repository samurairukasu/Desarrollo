unit Ubuscar_inspeccion_por_patente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls,UFRESULTADOSINSPECCION;

type
  Tbuscar_inspeccion_por_patente = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  buscar_inspeccion_por_patente: Tbuscar_inspeccion_por_patente;

implementation

{$R *.dfm}

procedure Tbuscar_inspeccion_por_patente.FormActivate(Sender: TObject);
begin
edit1.Clear;
end;

procedure Tbuscar_inspeccion_por_patente.SpeedButton1Click(
  Sender: TObject);
begin

close;
end;

procedure Tbuscar_inspeccion_por_patente.Edit1KeyPress(Sender: TObject;
  var Key: Char);
begin
if key=#13 then
 SpeedButton1Click(Sender);
end;

end.
