unit uGetEmpresa;

{ Unidad encargada de recoger las fechas por teclado, la salida es
  Fecha Inicial + 00h:00m:00s, Fecha Final + 23h:59m:59ss}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, Buttons, ExtCtrls, Mask, ToolEdit, uUtiles, RxLookup, DB, ustockclasses,
  ustockestacion, ucdialgs, globals;

type

  TFGetEmpresa = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    srcEmpresas: TDataSource;
    lcbEmpresa: TRxDBLookupCombo;
    Label2: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lcbEmpresaCloseUp(Sender: TObject);
  private

    fEmpresas : tEmpresas;
    function GetIdEmpresa : integer;
    function GetNomEmpresa : string;
  public
    property IdEmpresa : integer read GetIdEmpresa;
    property NomEmpresa : string read GetNomEmpresa;
  end;

   Function GetEmpresa (var vIdEmpresa: integer; var vNomEmpresa : string): Boolean;

var
  FGetEmpresa: TFGetEmpresa;

implementation
uses
  DateUtil;
{$R *.DFM}

const
    CABECERA_MENSAJES_BUSFECH = 'Buscar por Empresa';


function TFGetEmpresa.GetIdEmpresa : integer;
begin
    result := strtoint(fEmpresas.ValueByName[FIELD_IDEMPRESA]);
end;


procedure TFGetEmpresa.btnAceptarClick(Sender: TObject);
begin
      if lcbEmpresa.Text = '' then
      begin
         MessageDlg(CAPTION,'Seleccione una Empresa', mtError, [mbOk], mbOk, 0);
         lcbEmpresa.SetFocus;
      end
    else ModalResult := mrOK
end;

procedure TFGetEmpresa.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TFGetEmpresa.FormCreate(Sender: TObject);
begin
  fEmpresas := nil;
  fEmpresas := tEmpresas.Create(mybd);
  fEmpresas.Open;
  srcEmpresas.DataSet := fEmpresas.DataSet;
end;

procedure TFGetEmpresa.FormDestroy(Sender: TObject);
begin
  fEmpresas.Free;
end;

Function GetEmpresa (var vIdEmpresa: integer; var vNomEmpresa : string):Boolean;
begin
    Result:=FalsE;
    try
        with TFGetEmpresa.Create(Application) do
        try
            if ShowModal = mrOk
            then begin
                vIdEmpresa := IdEmpresa;
                vNomEmpresa := NomEmpresa;
                Result:=True;
            end;
        finally
            Free
        end
    finally
        Application.ProcessMessages
    end
end;

function TFGetEmpresa.GetNomEmpresa: string;
begin
    result := lcbEmpresa.Text;
end;

procedure TFGetEmpresa.lcbEmpresaCloseUp(Sender: TObject);
begin
  lcbEmpresa.Value := fEmpresas.ValueByName[lcbEmpresa.LookupField];
end;

end.


