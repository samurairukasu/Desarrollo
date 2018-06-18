unit Unitpide_fecha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons;

type
  Tpide_fecha = class(TForm)
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sale:boolean;
  end;

var
  pide_fecha: Tpide_fecha;

implementation

{$R *.dfm}

procedure Tpide_fecha.BitBtn1Click(Sender: TObject);
begin
sale:=true;
end;

procedure Tpide_fecha.BitBtn2Click(Sender: TObject);
begin
sale:=false;
end;

end.
