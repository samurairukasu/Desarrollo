unit UniPORIDTURNO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  Tinformarporturnoid = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  informarporturnoid: Tinformarporturnoid;

implementation

uses Ufrmturnos;

{$R *.dfm}

procedure Tinformarporturnoid.FormCreate(Sender: TObject);
begin
EDIT1.CLEAR;
end;

procedure Tinformarporturnoid.BitBtn2Click(Sender: TObject);
begin
close;
end;

procedure Tinformarporturnoid.BitBtn1Click(Sender: TObject);
begin
frmturnos.INFORMA_INSPECCION_AL_WEBSERVICES_POR_IDTURNO(STRTOINT(EDIT1.Text));
end;

end.