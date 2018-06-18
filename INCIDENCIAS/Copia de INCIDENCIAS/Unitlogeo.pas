unit Unitlogeo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, Buttons;

type
  Tlogeo = class(TForm)
    GroupBox1: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    SpeedButton1: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  logeo: Tlogeo;

implementation

uses Unitincedencias;

{$R *.dfm}

Procedure Codificar(Clave: String; ID: Integer; VAR ClaveCod: String);
Var
   i: Word;
Begin
     SetLength(ClaveCod,Length(Clave));
     for i := 1 to Length(Clave) do
        ClaveCod[i] := chr(ord(Clave[i]) xor ((i + ID) mod 32));

End;


procedure Tlogeo.SpeedButton1Click(Sender: TObject);
begin
principal.showmodal;
logeo.Close;
end;

procedure Tlogeo.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
application.ProcessMessages;
end;

end.
