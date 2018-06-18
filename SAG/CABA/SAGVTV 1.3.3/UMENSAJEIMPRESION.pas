unit UMENSAJEIMPRESION;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TMENSAJEIMPRESION = class(TForm)
    Label1: TLabel;
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MENSAJEIMPRESION: TMENSAJEIMPRESION;

implementation

{$R *.dfm}

end.
