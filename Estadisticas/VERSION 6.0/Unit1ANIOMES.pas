unit Unit1ANIOMES;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TANIOMES = class(TForm)
    Bevel1: TBevel;
    Label1: TLabel;
    lblHasta: TLabel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ANIOMES: TANIOMES;

implementation

{$R *.dfm}

end.
