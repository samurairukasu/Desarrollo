unit Upideidturno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TPIDEIDTURNO = class(TForm)
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sale:boolean;
  end;

var
  PIDEIDTURNO: TPIDEIDTURNO;

implementation

{$R *.dfm}

procedure TPIDEIDTURNO.BitBtn1Click(Sender: TObject);
begin
sale:=falsE;
close;
end;

procedure TPIDEIDTURNO.BitBtn2Click(Sender: TObject);
begin
sale:=true;
close;
end;

end.
