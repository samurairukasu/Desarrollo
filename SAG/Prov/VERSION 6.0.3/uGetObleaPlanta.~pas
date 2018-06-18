unit uGetObleaPlanta;

{ Unidad encargada de recoger las fechas por teclado, la salida es
  Fecha Inicial + 00h:00m:00s, Fecha Final + 23h:59m:59ss}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, Buttons, ExtCtrls, Mask, ToolEdit, RXSpin, ComCtrls;

type

  TFGetObleaPlanta = class(TForm)
    Bevel1: TBevel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    Label1: TLabel;
    lblHasta: TLabel;
    edOblea: TEdit;
    edzona: TRxSpinEdit;
    edPlanta: TRxSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    fechavencianterior: TDateTimePicker;
    procedure btnAceptarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edObleaKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure fechavencianteriorKeyPress(Sender: TObject; var Key: Char);
  private
    OldDateFormat : string;
    function DatosOk : boolean;
  public
  end;

   Function GetObleaPlanta (var vZona, vPlanta, vOblea, vFechaVence: string): Boolean;

var
  FGetObleaPlanta: TFGetObleaPlanta;

implementation

{$R *.DFM}

uses
   UCDIALGS;


const
    FICHERO_ACTUAL = 'UGetObleaPlanta.pas';


procedure TFGetObleaPlanta.btnAceptarClick(Sender: TObject);
begin
    if not DatosOk
    then begin
        MessageDlg (Caption,'Debe completar todos los datos requeridos', mtInformation, [mbOk], mbOk, 0);
        edZona.setfocus;
    end
    else ModalResult := mrOK
end;

procedure TFGetObleaPlanta.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

function TFGetObleaPlanta.DatosOk : boolean;
begin
    result :=  false;
    if edZona.Text = '' then exit;
    if edPlanta.Text = '' then exit;
    if edOblea.Text = '' then exit;
    result := true;
end;


Function GetObleaPlanta (var vZona, vPlanta, vOblea, vFechaVence: string):Boolean;
begin
    Result:=False;
    try
        with TFGetObleaPlanta.Create(Application) do
        try
            if ShowModal = mrOk
            then begin
                vZona := edZona.Text;;
                vPlanta := edPlanta.Text;
                vOblea := edOblea.Text;
                vFechaVence:=trim(datetostr(fechavencianterior.DateTime));
                Result:=True;
            end;
        finally
            Free
        end
    finally
        Application.ProcessMessages
    end
end;


procedure TFGetObleaPlanta.edObleaKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
        begin
           // Perform(WM_NEXTDLGCTL,0,0);
            //Key := #0;
            fechavencianterior.SetFocus;
        end;

        if not (Key in ['0','1','2','3','4','5','6','7','8','9',#8]) then
            key := #0

end;

procedure TFGetObleaPlanta.FormActivate(Sender: TObject);
begin
fechavencianterior.DateTime:=now;
end;

procedure TFGetObleaPlanta.fechavencianteriorKeyPress(Sender: TObject;
  var Key: Char);
begin
 if key=#13 then
    begin
       Perform(WM_NEXTDLGCTL,0,0);
       Key := #0;

     end;
end;

end.


