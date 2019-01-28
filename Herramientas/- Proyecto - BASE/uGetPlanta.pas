unit uGetPlanta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, Buttons, ExtCtrls, Mask, ToolEdit, uUtiles, RxLookup, DB, ustockclasses,
  ustockestacion, ucdialgs, globals, variants;

type

  TFGetPlanta = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    srcPlanta: TDataSource;
    lcbPlanta: TRxDBLookupCombo;
    Label2: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lcbPlantaCloseUp(Sender: TObject);
  private

    fPlanta : tPlantas;
    function GetIdPlanta : integer;
    function GetNomPlanta : string;
    function GetIdZona : string;
    function GetNroPlanta : string;
    function GetTaller: string;

  public
    property IdPlanta : integer read GetIdPlanta;
    property NomPlanta : string read GetNomPlanta;
    property IdZona : string read GetIdZona;
    property NroPlanta : string read GetNroPlanta;
    property Taller : string read GetTaller;

  end;

   Function GetPlanta (var vIdPlanta: integer; var vNomPlanta, vTaller  : string): Boolean;

var
  FGetPlanta: TFGetPlanta;

implementation
uses
  DateUtil;
{$R *.DFM}

const
    CABECERA_MENSAJES_BUSFECH = 'Buscar por Planta';


function TFGetPlanta.GetIdPlanta : integer;
begin
    result := strtoint(fPlanta.ValueByName[FIELD_IDPLANTA]);
end;


procedure TFGetPlanta.btnAceptarClick(Sender: TObject);
begin
      if lcbPlanta.Text = '' then
      begin
         MessageDlg(CAPTION,'Seleccione una Planta', mtError, [mbOk], mbOk, 0);
         lcbPlanta.SetFocus;
      end
    else ModalResult := mrOK
end;

procedure TFGetPlanta.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TFGetPlanta.FormCreate(Sender: TObject);
begin
  fPlanta := nil;
  fPlanta := tPlantas.Create(mybd);
  fPlanta.Open;
  srcPlanta.DataSet := fPlanta.DataSet;
end;

procedure TFGetPlanta.FormDestroy(Sender: TObject);
begin
  fPlanta.Free;
end;

Function GetPlanta (var vIdPlanta: integer;
           var vNomPlanta, vTaller : string):Boolean;
begin
    Result:=FalsE;
    try
        with TFGetPlanta.Create(Application) do
        try
            if ShowModal = mrOk
            then begin
                vIdPlanta := IdPlanta;
                vNomPlanta := NomPlanta;
                vTaller := Taller;
                Result:=True;
            end;
        finally
            Free
        end
    finally
        Application.ProcessMessages
    end
end;

function TFGetPlanta.GetNomPlanta: string;
begin
    result := lcbPlanta.Text;
end;

function TFGetPlanta.GetIdZona: string;
begin
  result := fPlanta.ValueByName[FIELD_IDZONA];
end;

function TFGetPlanta.GetNroPlanta: string;
begin
  result := fPlanta.ValueByName[FIELD_NROPLANTA]
end;

function TFGetPlanta.GetTaller: string;
var
   ArrayVar: Variant;
begin
  ArrayVar:=VarArrayCreate([0,1],VarVariant);
  ArrayVar[0]:=idzona;
  ArrayVar[1]:=nroPlanta;
  fPlanta.ExecuteFunction('GET_CODTALLER',ArrayVar);
end;

procedure TFGetPlanta.lcbPlantaCloseUp(Sender: TObject);
begin
  lcbPlanta.Value := fPlanta.ValueByName[lcbPlanta.LookUpField];
end;


end.


