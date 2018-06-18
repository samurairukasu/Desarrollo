unit Uniingresar_patente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  Tingresar_patente = class(TForm)
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sale:boolean;
  end;

var
  ingresar_patente: Tingresar_patente;

implementation

{$R *.dfm}

procedure Tingresar_patente.BitBtn2Click(Sender: TObject);
begin
sale:=true;
close;
end;

procedure Tingresar_patente.BitBtn1Click(Sender: TObject);
begin
sale:=false;
close;
end;

procedure Tingresar_patente.FormActivate(Sender: TObject);
begin
edit1.Clear;
end;

end.
