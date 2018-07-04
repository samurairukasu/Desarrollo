unit Unit3lo_que_tiene_que_venir;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons;

type
  Tlo_que_tiene_que_venir = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sale:boolean;
  end;

var
  lo_que_tiene_que_venir: Tlo_que_tiene_que_venir;

implementation

{$R *.dfm}

procedure Tlo_que_tiene_que_venir.BitBtn2Click(Sender: TObject);
begin
sale:=true;
close;
end;

procedure Tlo_que_tiene_que_venir.BitBtn1Click(Sender: TObject);
begin
sale:=false;
close;
end;

end.
