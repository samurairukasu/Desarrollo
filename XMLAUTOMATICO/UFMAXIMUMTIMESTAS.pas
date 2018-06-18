unit UFMaximumTimesTas;
{ Unidad encargada de modificar una tarifa y/o tiempo máximo }

{
  Ultima Traza: 6
  Ultima Incidencia:
  Ultima Anomalia: 2
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Buttons, ExtCtrls, Db, UCTTITAPER, UCEdit, sqlexpr;

type
  TfrmModificarTarifa = class(TForm)
    Bevel1: TBevel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    lblPorcentajeTarifa: TLabel;
    lblTiempoMaximo: TLabel;
    lblminutos: TLabel;
    lblNombreVehiculo: TLabel;
    SpnEdtTarifa: TSpinEdit;
    SpnEdtTiempoMaximo: TSpinEdit;
    edtNombreVehiculo: TColorEdit;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnAceptarClick(Sender: TObject);
    procedure edtNombreVehiculoExit(Sender: TObject);
    procedure SpnEdtTarifaKeyPress(Sender: TObject; var Key: Char);
    procedure SpnEdtTarifaEnter(Sender: TObject);
    procedure SpnEdtTarifaExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    iCodigoVeh_Anterior: integer;

    function ValoresTarifas_Validos: boolean;

  public
    { Public declarations }
    function ExisteVehiculo_TTIPOVEHICU (const sNombre: string): boolean;
    function ObtenerCodigoVehiculo_TTIPOVEHICU (const sNombre: string; var iCodVeh: integer): boolean;
    procedure LeerForm_TarifasTMaximos (var Datos_FormTarifasTMaximos: tDatos_FormTarifasTMaximos);

    constructor CreateByTarifa (const itarifa, itiempmax: integer; const snombre: string);
  end;

var
  frmModificarTarifa: TfrmModificarTarifa;

implementation

uses
   UCDIALGS,
   ULOGS,
   GLOBALS,
   UINTERFAZUSUARIO;


resourcestring
      CABECERA_MENSAJES_MTM = 'Modificar Tarifa / Tiempo Máximo';
      FICHERO_ACTUAL = 'UFMaximumTimesTas';

      { Mensajes enviados desde el form MTarTMax }
      MSJ_TTM_TARNOVAL = 'La tarifa introducida no es válida';
      MSJ_TTM_TIEMNOVAL = 'El tiempo máximo introducido no es válido';
      MSJ_TTM_NOMVAC = 'Es obligatorio introducir el nombre del vehículo';
      MSJ_TTM_NOMREP = 'El nombre del vehículo ya se ha introducido anteriormente. Introduzca otro nombre diferente.';



{$R *.DFM}

{ Devuelve el código del vehículo que se va a modificar. Devuelve True si se ha
  podido obtener el código del vehículo sin problemas }
function TfrmModificarTarifa.ObtenerCodigoVehiculo_TTIPOVEHICU (const sNombre: string; var iCodVeh: integer): boolean;
var
  aQ: TSQLQuery;

begin
    Result := False;
    aQ := TSQLQuery.Create (self);
    try
       try
          with aQ do
          begin
              sqlconnection := MyBD;
              Sql.Clear;
              Sql.Add (Format('select tipovehi from ttipovehicu where nomtipve=''%s''',[sNombre]));
              Open;
              iCodVeh := Fields[0].AsInteger;
              Result := True;
          end;
       except
           on E:Exception do
           begin
               FIncidencias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL, 'Error en ObtenerCodigoVehiculo_TTIPOVEHICU: ' + E.Message);
           end;
       end;
    finally
         aQ.Free;
    end;
end;


procedure TfrmModificarTarifa.LeerForm_TarifasTMaximos (var Datos_FormTarifasTMaximos: tDatos_FormTarifasTMaximos);
begin
    with Datos_FormTarifasTMaximos do
    begin
        PorcenTarifa:= SpnEdtTarifa.Value;
        TiempoMax:= SpnEdtTiempoMaximo.Value;
        NomVehic:= edtNombreVehiculo.Text;
    end
end;


procedure TfrmModificarTarifa.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TfrmModificarTarifa.btnAceptarClick(Sender: TObject);
begin
    if ValoresTarifas_Validos then
    begin
        {$IFDEF TRAZAS}
           FTrazas.PonComponente (TRAZA_FORM,4,FICHERO_ACTUAL, Self);
        {$ENDIF}
        ModalResult := mrOk;
    end;
end;


function TFrmModificarTarifa.ValoresTarifas_Validos: boolean;
{ Devuelve True si los valores introducidos son válidos }
var
   iValor_Auxi, iCodErr: integer;

begin
    Result := False;
    Val (SpnEdtTarifa.Text, iValor_Auxi, iCodErr);
    if ((iCodErr <> 0) or (iValor_Auxi <= 0)) then
    begin
        MessageDlg (CABECERA_MENSAJES_MTM, MSJ_TTM_TARNOVAL, mtInformation, [mbOk], mbOk, 0);
        SpnEdtTarifa.setfocus;
        exit;
    end;

    Val (SpnEdtTiempoMaximo.Text, iValor_Auxi, iCodErr);
    if ((iCodErr <> 0) or (iValor_Auxi <= 0)) then
    begin
        MessageDlg (CABECERA_MENSAJES_MTM, MSJ_TTM_TIEMNOVAL, mtInformation, [mbOk], mbOk, 0);
        SpnEdtTiempoMaximo.setfocus;
        exit;
    end;

    if (edtNombreVehiculo.Text <> '') then
    begin
        if (ExisteVehiculo_TTIPOVEHICU (edtNombreVehiculo.Text)) then
        begin
           MessageDlg (CABECERA_MENSAJES_MTM, MSJ_TTM_NOMREP, mtInformation, [mbOk], mbOk, 0);
           edtNombreVehiculo.setfocus;
           exit;
        end
        else
           Result := True
    end
    else
    begin
        MessageDlg (CABECERA_MENSAJES_MTM, MSJ_TTM_NOMVAC, mtInformation, [mbOk], mbOk, 0);
        edtNombreVehiculo.setfocus;
    end
end;

procedure TfrmModificarTarifa.edtNombreVehiculoExit(Sender: TObject);
begin
    Self.Text := Trim (Self.Text);
end;


function TfrmModificarTarifa.ExisteVehiculo_TTIPOVEHICU (const sNombre: string): boolean;
var
  aQ: TSQLQuery;

begin
    Result := True;

    aQ := TSQLQuery.Create (nil);
    try
       try
          with aQ do
          begin
              SQLConnection := MyBD;
              Sql.Clear;
              Sql.Add (Format('select nomtipve from ttipovehicu where nomtipve=''%s'' and TipoVehi <> %d',[sNombre, iCodigoVeh_Anterior]));
              Open;
              Result := (Fields[0].AsString = sNombre);
          end;
       except
           on E:Exception do
           begin
               FIncidencias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL, 'Error en ExisteVehiculo_TTIPOVEHICU: ' + E.Message);
           end;
       end;
    finally
         aQ.Free;
    end;
end;

procedure TfrmModificarTarifa.SpnEdtTarifaKeyPress(Sender: TObject;
  var Key: Char);
begin
    if (Key = '-') then
       Key := #0
end;

procedure TfrmModificarTarifa.SpnEdtTarifaEnter(Sender: TObject);
begin
    DestacarControl (Sender, clGreen, clWhite, False);
end;

procedure TfrmModificarTarifa.SpnEdtTarifaExit(Sender: TObject);
begin
    AtenuarControl (Sender, False);
end;


constructor TfrmModificarTarifa.CreateByTarifa (const itarifa, itiempmax: integer; const snombre: string);
begin
    inherited Create (Application);

    try
       SpnEdtTarifa.Value := iTarifa;
       SpnEdtTiempoMaximo.Value := iTiempMax;
       edtNombreVehiculo.Text := sNombre;

       ObtenerCodigoVehiculo_TTIPOVEHICU (edtNombreVehiculo.Text, iCodigoVeh_Anterior);
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,2,FICHERO_ACTUAL, 'Error al inicializar el constructor por: ' + E.Message);
        end;
    end;
end;

procedure TfrmModificarTarifa.FormShow(Sender: TObject);
begin
    SpnEdtTarifa.Setfocus;
end;

end.
