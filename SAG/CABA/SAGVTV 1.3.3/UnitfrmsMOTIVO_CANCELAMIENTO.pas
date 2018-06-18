unit UnitfrmsMOTIVO_CANCELAMIENTO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfrmsMOTIVO_CANCELAMIENTO = class(TForm)
    ComboBox1: TComboBox;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmsMOTIVO_CANCELAMIENTO: TfrmsMOTIVO_CANCELAMIENTO;

implementation

{$R *.dfm}

procedure TfrmsMOTIVO_CANCELAMIENTO.BitBtn1Click(Sender: TObject);
begin
IF COMBOBOX1.ItemIndex=-1 THEN
BEGIN
Application.MessageBox( 'Debe seleccionar un motivo.',
  'Atención', MB_ICONSTOP );
EXIT;
END;

CLOSE;
end;

end.
