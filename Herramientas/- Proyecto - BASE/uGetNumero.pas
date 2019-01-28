unit uGetNumero;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, Buttons, ExtCtrls, Mask, ToolEdit, uUtiles, RxLookup, DB,
  ustockestacion, ucdialgs, globals;

type

  TFGetNumero = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    srcEmpresas: TDataSource;
    Label2: TLabel;
    edNumeros: TEdit;
    procedure btnAceptarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edNumerosKeyPress(Sender: TObject; var Key: Char);
  private
    function GetNumero: string;
  public
    property Numero : string read GetNumero;
  end;

   Function GetNumero (var vNumero: string): Boolean;

var
  FGetNumero: TFGetNumero;

implementation
uses
  DateUtil;
{$R *.DFM}

const
    CABECERA_MENSAJES_BUSFECH = 'Buscar por Número';

procedure TFGetNumero.btnAceptarClick(Sender: TObject);
begin
      if edNumeros.Text = '' then
      begin
         MessageDlg(CAPTION,'Ingrese el número de movimiento', mtError, [mbOk], mbOk, 0);
         edNumeros.SetFocus;
      end
    else ModalResult := mrOK
end;

procedure TFGetNumero.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

Function GetNumero (var vNumero: string):Boolean;
begin
    Result:=FalsE;
    try
        with TFGetNumero.Create(Application) do
        try
            if ShowModal = mrOk
            then begin
                vNumero := Numero;
                Result:=True;
            end;
        finally
            Free
        end
    finally
        Application.ProcessMessages
    end
end;

function TFGetNumero.GetNumero: string;
begin
  result := edNumeros.text;
end;

procedure TFGetNumero.edNumerosKeyPress(Sender: TObject; var Key: Char);
begin
        if not (Key in ['0','1','2','3','4','5','6','7','8','9',char(VK_BACK)])
        then key := #0
end;

end.


