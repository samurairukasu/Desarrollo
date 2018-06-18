unit UFNewDefect;
// Unidad que se encarga de añadir un nuevo defecto a la tabla de defectos

{
  Ultima Traza: 4
  Ultima Incidencia:
  Ultima Anomalia: 2
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, UCTDEFECTOS, UCEdit;

type
  TfrmNuevoDefecto = class(TForm)
    Bevel1: TBevel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    lblCodigo: TLabel;
    lblAbreviatura: TLabel;
    lblLiteral: TLabel;
    ChkBxActivoDefecto: TCheckBox;
    edtCodigo: TColorEdit;
    edtAbreviatura: TColorEdit;
    edtLiteral: TColorEdit;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnAceptarClick(Sender: TObject);
  private
    { Private declarations }
    function ValoresDefecto_Validos: boolean;
    function LiteralValido (LD: string): boolean;

  public
    { Public declarations }
    function LeerValoresDefecto (var Valores: tValoresDefecto): boolean;
    procedure Inicializar_DefectoActivo_Insertar;
    procedure Inicializar_DefectoActivo_Modificar;
    function Inicializar_OtrosCampos_Modificar (Valores: tValoresDefecto): boolean;
    procedure Inicializar_OtrosCampos_Insertar;

  end;


implementation

{$R *.DFM}

uses
   UCDIALGS,
   ULOGS;


resourcestring
        CABECERA_MENSAJES_NDEFECTO = 'Añadir nuevo defecto';
        FICHERO_ACTUAL = 'UFNewDefect';

      // Mensajes enviados al usuario
      MSJ_NDEF_CODMAL = 'El código del defecto no se ha introducido o es incorrecto. El código de defecto está comprendido entre 1 y 99.';
      MSJ_NDEF_LITMAL = 'El literal del defecto no se ha introducido';
      MSJ_NDEF_ABRMAL = 'La abreviatura del defecto no se ha introducido';



procedure TfrmNuevoDefecto.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Key := #0;
        Perform (WM_NEXTDLGCTL, 0, 0);
    end
end;


procedure TfrmNuevoDefecto.btnAceptarClick(Sender: TObject);
begin
     if ValoresDefecto_Validos then
     begin
        {$IFDEF TRAZAS}
          FTrazas.PonComponente (TRAZA_FORM,2,FICHERO_ACTUAL, Self);
        {$ENDIF}
         ModalResult := mrOk;
     end;
end;

// Devuelve True si el usuario ha rellenado todos los campos y se trata de un defecto válido
function TfrmNuevoDefecto.ValoresDefecto_Validos: boolean;
begin
   Result := False;

   if (LiteralValido (edtLiteral.Text) and (edtLiteral.Text <> '')) then
   begin
       Result := True
   end
   else
   begin
       MessageDlg (CABECERA_MENSAJES_NDEFECTO, MSJ_NDEF_LITMAL, mtInformation, [mbOk], mbOk, 0);
       edtLiteral.setfocus;
   end;
end;

// Lee los valores de un defecto. Devuelve True si los ha conseguido leer del form
function TfrmNuevoDefecto.LeerValoresDefecto (var Valores: tValoresDefecto): boolean;
begin
   try
      with Valores do
      begin
          if (ChkBxActivoDefecto.Checked) then
            DefectoActivo:= ''
          else
            DefectoActivo:= DEFECTO_NOACTIVO;

          AbreviaturaDefecto:= edtAbreviatura.Text;
          LiteralDefecto := edtLiteral.Text;
      end;
      Result := True;
   except
       on E:Exception do
       begin
           Result := False;
           FAnomalias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL, 'No se han podido leer los valores de NDefecto: ' + E.Message);
       end;
   end;
end;


procedure TfrmNuevoDefecto.Inicializar_DefectoActivo_Insertar;
begin
    Caption := CAPTION_NUEVO_DEFECTO;
    ChkBxActivoDefecto.Checked := True;
    ChkBxActivoDefecto.Enabled := False;
end;


procedure TfrmNuevoDefecto.Inicializar_DefectoActivo_Modificar;
begin
    Caption := CAPTION_Modificar_DEFECTO;
    ChkBxActivoDefecto.Enabled := True;
end;

// Devuelve True si se han inicializado los valores correctamente
function TfrmNuevoDefecto.Inicializar_OtrosCampos_Modificar (Valores: tValoresDefecto): boolean;
begin
    try
       with Valores do
       begin
           edtCodigo.Enabled := True;
           edtCodigo.Text := IntToStr(CodigoDefecto);
           edtCodigo.Enabled := False;
           ChkBxActivoDefecto.Checked := (DefectoActivo <> DEFECTO_NOACTIVO);
           edtAbreviatura.Text := AbreviaturaDefecto;
           edtLiteral.Text := LiteralDefecto;
       end;
       Result := True;
    except
         on E:Exception do
         begin
             Result := False;
             FAnomalias.PonAnotacion (TRAZA_SIEMPRE,2,FICHERO_ACTUAL, 'Error en Inicializar_OtrosCampos_Modificar: ' + E.Message);
         end;
    end;
end;


procedure TfrmNuevoDefecto.Inicializar_OtrosCampos_Insertar;
begin
    edtCodigo.Enabled := True;
    edtCodigo.Text := '';
    edtCodigo.Enabled := False;
    edtAbreviatura.Text := '';
    edtLiteral.Text := '';
end;

// Devuelve True si el formato del literal de defecto es correcto
function TfrmNuevoDefecto.LiteralValido (LD: string): boolean;
begin
     Result := (LD <> '');
end;


end.
