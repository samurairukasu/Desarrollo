unit UPIDE_TURNO_AUSENTE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TPIDE_TURNO_AUSENTE = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sale:boolean;
  end;

var
  PIDE_TURNO_AUSENTE: TPIDE_TURNO_AUSENTE;

implementation

{$R *.dfm}

procedure TPIDE_TURNO_AUSENTE.Button2Click(Sender: TObject);
begin
sale:=true;
closE;
end;

procedure TPIDE_TURNO_AUSENTE.Button1Click(Sender: TObject);
begin
sale:=false;
closE;
end;

end.
