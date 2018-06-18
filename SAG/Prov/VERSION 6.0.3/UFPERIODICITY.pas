unit UFPeriodicity;
{ Unidad encargada de modificar las periodicidades de un vehículo }

{
  Ultima Traza: 7
  Ultima Incidencia:
  Ultima Anomalia: 2 
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Buttons, ExtCtrls, Db, sqlexpr, UCTTITAPER, UCEdit;

type
  TfrmModificarPeriodicidad = class(TForm)
    Bevel1: TBevel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    lblAntiguedadL1: TLabel;
    lblAntiguedadL2: TLabel;
    lblPeriodicidadP1: TLabel;
    lblPeriodicidadP2: TLabel;
    lblClasificacion: TLabel;
    SpnEdtAntiguedadL1: TSpinEdit;
    SpnEdtAntiguedadL2: TSpinEdit;
    SpnEdtPeriodicidadP1: TSpinEdit;
    SpnEdtPeriodicidadP2: TSpinEdit;
    edtClasificacion: TColorEdit;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnAceptarClick(Sender: TObject);
    procedure edtClasificacionExit(Sender: TObject);
    procedure SpnEdtAntiguedadL1KeyPress(Sender: TObject; var Key: Char);
    procedure SpnEdtAntiguedadL1Enter(Sender: TObject);
    procedure SpnEdtAntiguedadL1Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    iCodFrecu_Anterior: integer;

    procedure InicializarHintsModifEspDest;
    function ValoresPeriodicidad_Validos: boolean;
    function Existe_ClasificacionAnterior_TFRECUENCIA (const sClasif: string; const iCodFrecu: integer): boolean;
    procedure ObtenerCodigoFrecuencia_TFRECUENCIA (const sClasif: string; var iCodFrecu: integer);

  public
    { Public declarations }
    procedure LeerForm_Frecuencia (var DatFrmFrecuencia: tDatos_FormPeriodicidad);
    constructor CreateFromPeriodicity (const iL1, iL2, iP1, iP2: integer; const sClasific: string);
  end;

var
  frmModificarPeriodicidad: TfrmModificarPeriodicidad;


implementation

uses
   UCDIALGS,
   ULOGS,
   GLOBALS,
   UUTILS,
   USAGESTACION,
   UINTERFAZUSUARIO;


resourcestring
      CABECERA_MENSAJES_MTM = 'Modificar Periodicidad';
      FICHERO_ACTUAL = 'UFPeriodicity';

      { Hints enviados desde el form MPeriod }
      HNT_MPER_ANTL1ESP = 'Antigüedad L1 (especie)|Antigüedad L1 del vehículo según su especie';
      HNT_MPER_ANTL2ESP = 'Antigüedad L2 (especie)|Antigüedad L2 del vehículo según su especie';
      HNT_MPER_PERP1ESP = 'Periodicidad P1 (especie)|Periodicidad P1 del vehículo según su especie';
      HNT_MPER_PERP2ESP = 'Periodicidad P2 (especie)|Periodicidad P2 del vehículo según su especie';
      HNT_MPER_CLASDES = 'Clasificación del vehículo (destino servicio)|Clasificación del vehículo según su especie';
      HNT_MPER_ANTL1DES = 'Antigüedad L1 (destino servicio)|Antigüedad L1 del vehículo según su destino servicio';
      HNT_MPER_ANTL2DES = 'Antigüedad L2 (destino servicio)|Antigüedad L2 del vehículo según su destino servicio';
      HNT_MPER_PERP1DES = 'Periodicidad P1 (destino servicio)|Periodicidad P1 del vehículo según su destino servicio';
      HNT_MPER_PERP2DES = 'Periodicidad P2 (destino servicio)|Periodicidad P2 del vehículo según su destino servicio';
      HNT_MPER_CLASESP = 'Clasificación del vehículo (destino servicio)|Clasificación del vehículo según su destino servicio';


      { Mensajes enviados desde el form MPeriod }
      MSJ_PER_P2NOVAL = 'La periodicidad P2 introducida no es correcta';
      MSJ_PER_P1NOVAL = 'La periodicidad P1 introducida no es correcta';
      MSJ_PER_L2NOVAL = 'La antigüedad L2 introducida no es correcta';
      MSJ_PER_L1NOVAL = 'La antigüedad L1 introducida no es correcta';
      MSJ_PER_CLAVAC = 'Es obligatorio introducir la clasificación del vehículo';
      MSJ_PER_CLASIFEXIST = 'La clasificación introducida ya existe';

{$R *.DFM}


procedure TfrmModificarPeriodicidad.LeerForm_Frecuencia (var DatFrmFrecuencia: tDatos_FormPeriodicidad);
begin
    with DatFrmFrecuencia do
    begin
        L1 := SpnEdtAntiguedadL1.Value;
        L2 := SpnEdtAntiguedadL2.Value;
        P1 := SpnEdtPeriodicidadP1.Value;
        P2 := SpnEdtPeriodicidadP2.Value;
        Clasificacion := edtClasificacion.Text;
    end
end;



procedure TfrmModificarPeriodicidad.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TfrmModificarPeriodicidad.InicializarHintsModifEspDest;
begin
    if (Caption = CAPTION_ESPECIE) then
    begin
        SpnEdtAntiguedadL1.Hint := HNT_MPER_ANTL1ESP;
        SpnEdtAntiguedadL2.Hint := HNT_MPER_ANTL2ESP;
        SpnEdtPeriodicidadP1.Hint := HNT_MPER_PERP1ESP;
        SpnEdtPeriodicidadP2.Hint := HNT_MPER_PERP2ESP;
        edtClasificacion.Hint := HNT_MPER_CLASESP;
    end
    else
    begin
        SpnEdtAntiguedadL1.Hint := HNT_MPER_ANTL1DES;
        SpnEdtAntiguedadL2.Hint := HNT_MPER_ANTL2DES;
        SpnEdtPeriodicidadP1.Hint := HNT_MPER_PERP1DES;
        SpnEdtPeriodicidadP2.Hint := HNT_MPER_PERP2DES;
        edtClasificacion.Hint := HNT_MPER_CLASDES;
    end;
end;

// Devuelve True si los valores introducidos son válidos 
function TfrmModificarPeriodicidad.ValoresPeriodicidad_Validos: boolean;
var
   iValor_Auxi, iCodErr: integer;

begin
    Result := False;
    Val (SpnEdtAntiguedadL1.Text, iValor_Auxi, iCodErr);
    if ((iCodErr <> 0) or (iValor_Auxi <= 0)) then
    begin
        MessageDlg (CABECERA_MENSAJES_MTM, MSJ_PER_L1NOVAL, mtInformation, [mbOk], mbOk, 0);
        SpnEdtAntiguedadL1.setfocus;
        exit;
    end;

    Val (SpnEdtAntiguedadL2.Text, iValor_Auxi, iCodErr);
    if ((iCodErr <> 0) or (iValor_Auxi <= 0)) then
    begin
        MessageDlg (CABECERA_MENSAJES_MTM, MSJ_PER_L2NOVAL, mtInformation, [mbOk], mbOk, 0);
        SpnEdtAntiguedadL2.setfocus;
        exit;
    end;

    Val (SpnEdtPeriodicidadP1.Text, iValor_Auxi, iCodErr);
    if ((iCodErr <> 0) or (iValor_Auxi <= 0)) then
    begin
        MessageDlg (CABECERA_MENSAJES_MTM, MSJ_PER_P1NOVAL, mtInformation, [mbOk], mbOk, 0);
        SpnEdtPeriodicidadP1.setfocus;
        exit;
    end;

    Val (SpnEdtPeriodicidadP2.Text, iValor_Auxi, iCodErr);
    if ((iCodErr <> 0) or (iValor_Auxi <= 0)) then
    begin
        MessageDlg (CABECERA_MENSAJES_MTM, MSJ_PER_P2NOVAL, mtInformation, [mbOk], mbOk, 0);
        SpnEdtPeriodicidadP2.setfocus;
        exit;
    end;

    if (edtClasificacion.Text <> '') then
    begin
        if (Existe_ClasificacionAnterior_TFRECUENCIA (edtClasificacion.Text, iCodFrecu_Anterior)) then
        begin
            MessageDlg (CABECERA_MENSAJES_MTM, MSJ_PER_CLASIFEXIST, mtInformation, [mbOk], mbOk, 0);
            edtClasificacion.setfocus;
            exit;
        end
        else
           Result := True
    end
    else
    begin
        MessageDlg (CABECERA_MENSAJES_MTM, MSJ_PER_CLAVAC, mtInformation, [mbOk], mbOk, 0);
        edtClasificacion.setfocus;
    end
end;


procedure TfrmModificarPeriodicidad.btnAceptarClick(Sender: TObject);
begin
    if ValoresPeriodicidad_Validos then
    begin
        {$IFDEF TRAZAS}
           FTrazas.PonComponente (TRAZA_FORM,4,FICHERO_ACTUAL, Self);
        {$ENDIF}
        ModalResult := mrOk;
    end;
end;

function TfrmModificarPeriodicidad.Existe_ClasificacionAnterior_TFRECUENCIA (const sClasif: string; const iCodFrecu: integer): boolean;
var
  aQ: TSQLQuery;

begin
    Result := False;
    aQ := TSQLQuery.Create(self);
    try
        with aQ do
        try
            sqlconnection := MyBD;
            SQL.Add(Format ('select %s from %s where %s=''%s'' and %s<>%d',[FIELD_CLASIFIC, DATOS_FRECUENCIA, FIELD_CLASIFIC, sClasif, FIELD_CODFRECU, iCodFrecu]));
            Open;
            Result := (Fields[0].AsString = sClasif);
        except
            on E: Exception do;
                //fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Falló la lectura de la fecha y hora por: %s',[E.message]);
        end
    finally
        aQ.Close;
        aQ.Free;
    end
end;


procedure TfrmModificarPeriodicidad.ObtenerCodigoFrecuencia_TFRECUENCIA (const sClasif: string; var iCodFrecu: integer);
var
  aQ: TSQLQuery;

begin
    aQ := TSQLQuery.Create(self);
    try
        with aQ do
        try
            SQLConnection := MyBD;
            SQL.Add(Format ('select %s from %s where %s=''%s''',[FIELD_CODFRECU, DATOS_FRECUENCIA, FIELD_CLASIFIC, sClasif]));
            Open;
            iCodFrecu := Fields[0].AsInteger;
        except
            on E: Exception do;
                //fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Falló la lectura de la fecha y hora por: %s',[E.message]);
        end
    finally
        aQ.Close;
        aQ.Free;
    end
end;


procedure TfrmModificarPeriodicidad.edtClasificacionExit(Sender: TObject);
begin
    Self.Text := Trim (Self.Text);
end;

procedure TfrmModificarPeriodicidad.SpnEdtAntiguedadL1KeyPress(
  Sender: TObject; var Key: Char);
begin
    if (Key = '-') then
       Key := #0
end;

procedure TfrmModificarPeriodicidad.SpnEdtAntiguedadL1Enter(
  Sender: TObject);
begin
    DestacarControl (Sender, clGreen, clWhite, False);
end;

procedure TfrmModificarPeriodicidad.SpnEdtAntiguedadL1Exit(
  Sender: TObject);
begin
    AtenuarControl (Sender, False);
end;

procedure TfrmModificarPeriodicidad.FormShow(Sender: TObject);
begin
    SpnEdtAntiguedadL1.Setfocus;
end;

constructor TfrmModificarPeriodicidad.CreateFromPeriodicity (const iL1, iL2, iP1, iP2: integer; const sClasific: string);
begin
    inherited Create (Application);

    InicializarHintsModifEspDest;
    try
       SpnEdtAntiguedadL1.Value := iL1;
       SpnEdtAntiguedadL2.Value := iL2;
       SpnEdtPeriodicidadP1.Value := iP1;
       SpnEdtPeriodicidadP2.Value := iP2;
       edtClasificacion.Text := sClasific;

       ObtenerCodigoFrecuencia_TFRECUENCIA (edtClasificacion.Text, iCodFrecu_Anterior);
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacion (TRAZA_FLUJO,1,FICHERO_ACTUAL, 'Error en el constructor de Periodicidad por: ' + E.Message);
        end;
    end;
end;

end.
