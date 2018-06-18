unit Uuingresapatentecabacert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  Tuingresapatentecabacert = class(TForm)
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  uingresapatentecabacert: Tuingresapatentecabacert;

implementation

{$R *.dfm}

procedure Tuingresapatentecabacert.BitBtn2Click(Sender: TObject);
begin
close;
end;

procedure Tuingresapatentecabacert.FormCreate(Sender: TObject);
begin
EDIT1.Clear;
end;

procedure Tuingresapatentecabacert.BitBtn1Click(Sender: TObject);
begin
IF TRIM(EDIT1.Text)='' THEN
BEGIN
SHOWMESSAGE('DEBE INGRESAR LA PATENTE');
  EXIT;
END;

end;

end.
