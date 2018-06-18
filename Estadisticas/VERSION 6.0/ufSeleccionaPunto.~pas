unit ufSeleccionaPunto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TfrmSeleccionaPunto = class(TForm)
    rgImprimir: TRadioGroup;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Bevel1: TBevel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  function DoSeleccionaPunto(var Opcion: integer):Tmodalresult;
var
  frmSeleccionaPunto: TfrmSeleccionaPunto;

implementation

{$R *.DFM}

Function DoSeleccionaPunto(var Opcion: integer):Tmodalresult;
begin
  with TfrmSeleccionaPunto.Create(application) do
  begin
    try
      showmodal;
    finally
      opcion:=rgImprimir.itemindex;
      result:=modalresult;
      free;
    end;
  end;
end;

end.
