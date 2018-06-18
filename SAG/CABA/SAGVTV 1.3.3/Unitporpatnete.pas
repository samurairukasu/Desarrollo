unit Unitporpatnete;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  Tdescargar_por_patente = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  descargar_por_patente: Tdescargar_por_patente;

implementation

{$R *.dfm}

procedure Tdescargar_por_patente.BitBtn2Click(Sender: TObject);
begin
close;
end;

end.
