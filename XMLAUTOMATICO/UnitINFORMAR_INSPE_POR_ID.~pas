unit UnitINFORMAR_INSPE_POR_ID;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TINFORMAR_INSPE_POR_ID = class(TForm)
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  INFORMAR_INSPE_POR_ID: TINFORMAR_INSPE_POR_ID;

implementation

uses Ufrmturnos;

{$R *.dfm}

procedure TINFORMAR_INSPE_POR_ID.BitBtn1Click(Sender: TObject);
VAR IDTURNO:LONGINT;
begin
IDTURNO:=STRTOINT(EDIT1.TEXT);
 frmturnos.INFORMA_INSPECCION_AL_WEBSERVICES_POR_IDTURNO(IDTURNO);


end;

end.
