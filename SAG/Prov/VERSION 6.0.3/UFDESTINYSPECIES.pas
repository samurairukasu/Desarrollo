unit UFDestinySpecies;
{ Unidad encargada de modificar la especie o el destino del vehículo }

{
  Ultima Traza: 6
  Ultima Incidencia:
  Ultima Anomalia: 4
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask, Spin, Db, UCTTITAPER, UCEdit,
  FMTBcd, SqlExpr, DBXpress, DBClient, Provider;


type
  TfrmModificarEspDest = class(TForm)
    Bevel1: TBevel;
    lblDescripcion: TLabel;
    lblTipoVehiculo: TLabel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    Frecuencia: TLabel;
    edtTarifa: TMaskEdit;
    lblTarifa: TLabel;
    lblTituloAModificar: TLabel;
    edtFrecuencia: TColorEdit;
    edtDescripcion: TColorEdit;
    edtTipoVehiculo: TColorEdit;
    sdsqryConsultasTTIPOESPVEH: TSQLDataSet;
    sdsqryConsultasTTIPODESVEH: TSQLDataSet;
    qryConsultas: TSQLQuery;
    dspqryConsultasTTIPOESPVEH: TDataSetProvider;
    dspqryConsultasTTIPODESVEH: TDataSetProvider;
    qryConsultasTTIPOESPVEH: TClientDataSet;
    qryConsultasTTIPODESVEH: TClientDataSet;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnAceptarClick(Sender: TObject);
    procedure edtFrecuenciaKeyPress(Sender: TObject; var Key: Char);
    procedure edtDescripcionExit(Sender: TObject);
    procedure edtTarifaEnter(Sender: TObject);
    procedure edtTarifaExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    iGrupo_Anterior: integer;

    procedure InicializarHints_ModificarEspDest;
    function ValoresEspDest_Validos: boolean;
    function ExisteTarifa_TTIPOVEHICU (const sTarifa: string): boolean;
    function ExisteFrecuencia_TFRECUENCIAS (const sFrecuencia: string): boolean;
    procedure ObtenerDescripcion_TGRUPOTIPOS (const sDescrip: string; var iGrupo: integer);
    function ExisteDescripcion_TGRUPOTIPOS (const sDescrip: string; var iGrupo: integer): boolean;

  public
    { Public declarations }
    procedure LeerForm_EspDest (var DatFrmEspDest: tDatos_FormEspDest);
    constructor CreateFromEspDest (const Caption_Form, sTipoVehi, sCodFrecu, sDescrip, sNomEsp: string);
  end;

var
  frmModificarEspDest: TfrmModificarEspDest;

implementation

uses
   UCDIALGS,
   ULOGS,
   GLOBALS,
   USAGESTACION,
   UINTERFAZUSUARIO,
   UUTILS;

{$R *.DFM}


resourcestring
      FICHERO_ACTUAL = 'UFDestinySpecies';

      { Hints enviados desde el form MEspDest }
      HNT_MODED_TARIFA = 'Introduzca la tarifa del vehículo|Introduzca la tarifa a aplicar al vehículo';
      HNT_MODED_FRECESP = 'Frecuencia del vehículo (especie)|Introduzca la frecuencia del vehículo (según su especie)';
      HNT_MODED_FRECDES = 'Frecuencia del vehículo (d. servicio)|Introduzca la frecuencia del vehículo (según su destino servicio)';
      HNT_MODED_DESESP = 'Introduzca la descripción de la especie|Descripción de la especie del vehículo';
      HNT_MODED_TIPESP = 'Introduzca el tipo del vehículo (especie)|Tipo del vehículo según su especie';
      HNT_MODED_DESDES = 'Introduzca la descripción del destino servicio|Descripción del destino de servicio del vehículo';
      HNT_MODED_TIPDES = 'Introduzca el tipo del vehículo (destino servicio)|Tipo del vehículo según su destino de servicio';

      { Mensajes enviados al usuario desde el form MEspDest }
      MSJ_ED_TIPVAC = 'Es obligatorio introducir el tipo del vehículo';
      MSJ_ED_DESVAC = 'Es obligatorio introducir la descripción del vehículo';
      MSJ_ED_TARINOVAL = 'La tarifa no se ha introducido o es incorrecta';
      MSJ_ED_FRECMAL = 'La frecuencia no se ha introducido o es incorrecta';

      MSJ_FRECUENC_NOEXISTE = 'Lo siento pero la frecuencia introducida no existe. Por favor, introdúzcala de nuevo.';
      MSJ_TARIFA_NOEXISTE = 'Lo siento pero la tarifa introducida no existe. Por favor, introdúzcala de nuevo.';

      MSJ_TTM_DESCRIP = 'La descripción del vehículo ya existe';



procedure TfrmModificarEspDest.LeerForm_EspDest (var DatFrmEspDest: tDatos_FormEspDest);
begin
    with DatFrmEspDest do
    begin
       if (Caption = CAPTION_ESPECIE) then
          iTarifa := StrToInt (edtTarifa.Text);

           if (edtFrecuencia.Text <> '') then
              iFrecuencia := StrToInt (edtFrecuencia.Text)
           else
              iFrecuencia := -1; { Ponemos un -1 para indicar que la frecuencia está en blanco }

       Descrip := edtDescripcion.Text;
       TipoVeh := edtTipoVehiculo.Text;
    end
end;


procedure TfrmModificarEspDest.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TfrmModificarEspDest.InicializarHints_ModificarEspDest;
begin
    if (Caption = CAPTION_DESTSERV) then
    begin
        edtTarifa.Hint := HNT_MODED_TARIFA;
        edtFrecuencia.Hint := HNT_MODED_FRECESP;
        edtDescripcion.Hint := HNT_MODED_DESESP;
        edtTipoVehiculo.Hint := HNT_MODED_TIPESP;
    end
    else
    begin
        edtFrecuencia.Hint := HNT_MODED_FRECDES;
        edtDescripcion.Hint := HNT_MODED_DESDES;
        edtTipoVehiculo.Hint := HNT_MODED_TIPDES;
    end;
end;


function TfrmModificarEspDest.ValoresEspDest_Validos: boolean;
begin
    Result := False;

    if (Caption = CAPTION_ESPECIE) then
    begin
        if (not Es_Numero (edtTarifa.Text)) then
        begin
            MessageDlg (Caption, MSJ_ED_TARINOVAL, mtInformation, [mbOk], mbOk, 0);
            edtTarifa.SetFocus;
            exit;
        end;

        { En DESTINO SERVICIO la frecuencia puede ser null }
        if (not Es_Numero (edtFrecuencia.Text)) then
        begin
            MessageDlg (Caption, MSJ_ED_FRECMAL, mtInformation, [mbOk], mbOk, 0);
            edtFrecuencia.Setfocus;
            exit;
        end;
    end
    else
    begin
        { En DESTINO SERVICIO la frecuencia puede ser null }
        if ((edtFrecuencia.Text <> '') and (not Es_Numero (edtFrecuencia.Text))) then
        begin
            MessageDlg (Caption, MSJ_ED_FRECMAL, mtInformation, [mbOk], mbOk, 0);
            edtFrecuencia.Setfocus;
            exit;
        end;
    end;

    { Hay que comprobar que el Código de Frecuencia exista en TFRECUENCIA }
    if (edtTarifa.Visible and (not ExisteTarifa_TTIPOVEHICU (edtTarifa.Text))) then
    begin
        MessageDlg (Caption, MSJ_TARIFA_NOEXISTE, mtInformation, [mbOk], mbOk, 0);
        edtTarifa.SetFocus;
        exit;
    end;


    { Hay que comprobar que el Código de Frecuencia exista en TFRECUENCIA }
    if (not ExisteFrecuencia_TFRECUENCIAS (edtFrecuencia.Text)) then
    begin
        MessageDlg (Caption, MSJ_FRECUENC_NOEXISTE, mtInformation, [mbOk], mbOk, 0);
        edtFrecuencia.SetFocus;
        exit;
    end;

    if (edtDescripcion.Text <> '') then
    begin
        if ExisteDescripcion_TGRUPOTIPOS (edtDescripcion.Text, iGrupo_Anterior) then
        begin
            MessageDlg (Caption, MSJ_TTM_DESCRIP, mtInformation, [mbOk], mbOk, 0);
            edtDescripcion.SetFocus;
            exit;
        end
        else
        begin
            if (edtTipoVehiculo.Text <> '') then
               Result := True
            else
            begin
                MessageDlg (Caption, MSJ_ED_TIPVAC, mtInformation, [mbOk], mbOk, 0);
                edtTipoVehiculo.setfocus;
            end;
        end;
    end
    else
    begin
        MessageDlg (Caption, MSJ_ED_DESVAC, mtInformation, [mbOk], mbOk, 0);
        edtDescripcion.setfocus;
    end;
end;

procedure TfrmModificarEspDest.btnAceptarClick(Sender: TObject);
begin
    if ValoresEspDest_Validos then
    begin
        {$IFDEF TRAZAS}
          FTrazas.PonComponente (TRAZA_FORM,6,FICHERO_ACTUAL, Self);
        {$ENDIF}
        ModalResult := mrOk;
    end;
end;

function TFrmModificarEspDest.ExisteTarifa_TTIPOVEHICU (const sTarifa: string): boolean;
{ Devuelve True si existe la tarifa en TTIPOVEHICU }
begin
    with qryConsultas do
    begin
        Close;
        Sql.Clear;
        Sql.Add (Format ('SELECT %s FROM %s WHERE %s=%s',[FIELD_TIPOVEHI, DATOS_TIPOS_DE_VEHICULOS, FIELD_TIPOVEHI, sTarifa]));
        Open;

        Result := (Fields[0].AsString <> '');
    end;
end;


function TFrmModificarEspDest.ExisteFrecuencia_TFRECUENCIAS (const sFrecuencia: string): boolean;
{ Devuelve True si existe el código de frecuencia en TFRECUENCIAS }
begin
    if (sFrecuencia <> '') then
    begin
        with qryConsultas do
        begin
            Close;
            Sql.Clear;
            Sql.Add (Format ('SELECT %s FROM %s WHERE %s=%s',[FIELD_CODFRECU, DATOS_FRECUENCIA, sFrecuencia, FIELD_CODFRECU]));
            Open;

            Result := (Fields[0].AsString <> '');
        end;
    end
    else
       Result := True;
end;


procedure TfrmModificarEspDest.edtFrecuenciaKeyPress(Sender: TObject;
  var Key: Char);
begin
    if (((key < '0') or (key > '9')) and (key <> #8)) then
       key := #0
end;

procedure TfrmModificarEspDest.edtDescripcionExit(Sender: TObject);
begin
    TColorEdit(Sender).Text := Trim (TColorEdit(Sender).Text);
end;

procedure TfrmModificarEspDest.ObtenerDescripcion_TGRUPOTIPOS (const sDescrip: string; var iGrupo: integer);
var
  aQ: TSQLQuery;

begin
    aQ := TSQLQuery.Create (nil);
    try
       try
          with aQ do
          begin
              SQLConnection := MyBD;
              Sql.Clear;
              Sql.Add (Format('select %s from %s where %s=''%s''',[FIELD_GRUPOTIP, DATOS_GRUPOS_DE_VEHICULOS, FIELD_DESCRIPC, sDescrip]));
              Open;
              iGrupo := Fields[0].AsInteger;
          end;
       except
           on E:Exception do
           begin
               FIncidencias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL, 'Error en ObtenerDescripcion_TGRUPOTIPOS: ' + E.Message);
           end;
       end;
    finally
         aQ.Free;
    end;
end;

function TfrmModificarEspDest.ExisteDescripcion_TGRUPOTIPOS (const sDescrip: string; var iGrupo: integer): boolean;
var
  aQ: TSQLQuery;

begin
    result := true;

    aQ := TSQLQuery.Create (nil);
    try
       try
          with aQ do
          begin
              SQLConnection := MyBD;
              Sql.Clear;
              Sql.Add (Format('select %s from %s where %s=''%s'' and %s<>%d',[FIELD_GRUPOTIP, DATOS_GRUPOS_DE_VEHICULOS, FIELD_DESCRIPC, sDescrip, FIELD_GRUPOTIP, iGrupo]));
              Open;
              Result := (Fields[0].AsInteger = iGrupo);
          end;
       except
           on E:Exception do
           begin
               FIncidencias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL, 'Error en ExisteDescripcion_TGRUPOTIPOS: ' + E.Message);
           end;
       end;
    finally
         aQ.Free;
    end;
end;

constructor TfrmModificarEspDest.CreateFromEspDest (const Caption_Form, sTipoVehi, sCodFrecu, sDescrip, sNomEsp: string);
begin
    inherited Create (Application);
    Self.Caption := Caption_Form;

    InicializarHints_ModificarEspDest;

    try
       with qryConsultas do
       begin
           Close;
           SQLConnection := MyBD;
       end;

       if Caption_Form = CAPTION_ESPECIE then
       begin
           lblTituloAModificar.Caption := TITULO_ESPECIE;
           lblTarifa.Visible := True;
           edtTarifa.Visible := True;

           edtTarifa.Text := sTipoVehi;
           edtFrecuencia.Text := sCodFrecu;
           edtDescripcion.Text := sDescrip;
           edtTipoVehiculo.Text := sNomEsp;
       end
       else
       begin
           lblTituloAModificar.Caption := TITULO_DSERV;
           lblTarifa.Visible := False;
           edtTarifa.Visible := False;

           edtFrecuencia.Text := sCodFrecu;
           edtDescripcion.Text := sDescrip;
           edtTipoVehiculo.Text := sNomEsp;
       end;

       ObtenerDescripcion_TGRUPOTIPOS (edtDescripcion.Text, iGrupo_Anterior);
    except
         on E:Exception do
         begin
             FAnomalias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL, 'Error en el constructor de Especie-Destino por: ' + E.Message);
         end;
    end;
end;


procedure TfrmModificarEspDest.edtTarifaEnter(Sender: TObject);
begin
    DestacarControl (Sender, clGreen, clWhite, False);
end;

procedure TfrmModificarEspDest.edtTarifaExit(Sender: TObject);
begin
    AtenuarControl (Sender, False);
end;

procedure TfrmModificarEspDest.FormShow(Sender: TObject);
begin
    if (Caption = CAPTION_DESTSERV) then
       edtFrecuencia.Setfocus
    else
       edtTarifa.Setfocus;
end;

end.
