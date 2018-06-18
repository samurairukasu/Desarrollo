unit Unprocesando;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  Tprocesando = class(TForm)
    Label1: TLabel;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  procesando: Tprocesando;

implementation

{$R *.dfm}

procedure Tprocesando.BitBtn1Click(Sender: TObject);
begin
close;
end;

end.
