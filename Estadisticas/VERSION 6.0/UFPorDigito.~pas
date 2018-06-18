unit UFPorDigito;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Db, RxLookup, StdCtrls, Buttons, uSagEstacion,
  UUtils, globals, usagclasses, FMTBcd, SqlExpr, Provider,
  DBClient;
              //UARQUEOCAJAEXTENDED
type
  TFrmPorDigito = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    Bevel1: TBevel;
    lbHasta: TLabel;
    CbDigitoDesde: TComboBox;
    Bevel2: TBevel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
   // fCaja : TCaja;
    procedure MuestraSegunTipo;
  public
    { Public declarations }
  end;

  function PorDigito( var aDigito_Desde: string): Boolean;

var
  FrmPorDigito: TFrmPorDigito;

implementation

{$R *.DFM}



Function PorDigito( var aDigito_Desde:string): Boolean;
begin
Result:=FalsE;
  try
    with TFrmPorDigito.Create(Application) do
      try
        MuestraSegunTipo;
        if ShowModal = mrOk then
          begin
            aDigito_Desde:= CbDigitoDesde.Text;

            Result:=True;
          end;
      finally
        Free
      end
  finally
    Application.ProcessMessages
  end
end;


procedure TFrmPorDigito.MuestraSegunTipo();
begin
  CbDigitoDesde.Itemindex := 0;

end;

procedure TFrmPorDigito.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
  begin
    Perform(WM_NEXTDLGCTL,0,0);
    Key := #0
  end;
end;

end.
