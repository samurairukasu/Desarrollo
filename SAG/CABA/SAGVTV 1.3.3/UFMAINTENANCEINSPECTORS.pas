unit UFMaintenanceInspectors;
{ Unidad para realizar el mantenimiento de inspectores, pudiendo modificar la
  tabla TREVISOR }

{
  Ultima Traza: 15
  Ultima Incidencia:
  Ultima Anomalia:
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TfrmMantenimientoInspectores = class(TForm)
    Bevel1: TBevel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    lblfrmMantenimientoInspectores: TLabel;
    rdgrpMantenimientoInspectores: TRadioGroup;
    BBCrearIni: TBitBtn;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure BBCrearIniClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    procedure AltaNuevoInspector;
    procedure BusquedaInspectores;
    procedure CambiarPasswordInspector (Modif: boolean; NombreInsp: string);
    // Imprime un listado con los nombres y números de los inspectores
    procedure ImprimirListadoInspectores;
    procedure Generacion_FicheroInspectores (aForm: TForm; const sTipoTer: string);
  end;


procedure Mantenimiento_Inspectores (aForm: TForm);


implementation


uses
   UFNEWINSPECTOR,
   UFSEARCHINSPECTOR,
   FICHINI,
   UFPRINTINSPECTORS,
   ULOGS,
   GLOBALS,
   UVERSION,
   USUPERREGISTRY,
   FileCtrl,
   UFTMP,
   UCTINSPECTORES,
   UUTILS;

{$R *.DFM}



resourcestring
     FICHERO_ACTUAL = 'UFMaintenanceInspectors';


      { Mensajes enviados al usuario }
      MSJ_UMAIN_FICHINI_CORRECTO = 'CORRECTAMENTE';
      MSJ_UMAIN_FICHINI_INCORRECTO = 'INCORRECTAMENTE';


procedure Mantenimiento_Inspectores (aForm: TForm);
var
   frmMantenimientoInspectores_Auxi: TfrmMantenimientoInspectores;
begin
    aForm.Enabled := False;
    try
      frmMantenimientoInspectores_Auxi := TfrmMantenimientoInspectores.Create(Application);
      try
         frmMantenimientoInspectores_Auxi.ShowModal;
      finally
         frmMantenimientoInspectores_Auxi.Free;
      end;
    finally
      aForm.Enabled := True;
      aForm.Show;
    end;
end;


procedure TfrmMantenimientoInspectores.AltaNuevoInspector;
var
   frmNuevoInspector_Auxi: TFrmNuevoInspector;
   NuevoInsp: tNuevoInspector; { Almacenará los datos de un inspector }
begin
  frmNuevoInspector_Auxi := TFrmNuevoInspector.Create(Application);
  try
    frmNuevoInspector_Auxi.Caption := 'Alta de un nuevo Inspector';
    if frmNuevoInspector_Auxi.ShowModal = mrOk then
    begin
    { Leemos los datos del inspector del form y calculamos el nº inspector }
      NuevoInsp.sNombre:= frmNuevoInspector_Auxi.edtNombreInspector.Text;
      if VerEurosystem = '3.18' then
        NuevoInsp.sApellido:=frmNuevoInspector_Auxi.edApellidoInspe.Text
      else
        NuevoInsp.sNombre:= frmNuevoInspector_Auxi.edtNombreInspector.Text+' '+frmNuevoInspector_Auxi.edApellidoInspe.Text;
      NuevoInsp.sPassword := frmNuevoInspector_Auxi.edtPassword.Text;

      if (frmNuevoInspector_Auxi.ChkBxSuperusuario.Checked) then
        NuevoInsp.sEsSuperUsuario := ES_SUPERUSUARIO
      else
        NuevoInsp.sEsSuperUsuario := NO_ES_SUPERUSUARIO;

        // Hay que dar de alta al inspector en la tabla INSPECTORES
      if (frmNuevoInspector_Auxi.AniadirInspectorTablaInspectores (NuevoInsp)) then
        begin
        // Como se ha modificado la tabla TREVISOR, hey que generar un nuevo fichero INSPECT.TXT
        bFicheroInspModificado := True;
        end;
    end;
  finally
    frmNuevoInspector_Auxi.Free;
  end;
end;


procedure TfrmMantenimientoInspectores.BusquedaInspectores;
begin
With TFrmBusquedaInspector.Create(Application) do
  try
    ShowModal;
  finally
    free;
  end;
end;


procedure TfrmMantenimientoInspectores.CambiarPasswordInspector (Modif: boolean; NombreInsp: string);
var
   frmNuevoInspector_Auxi: TFrmNuevoInspector;
   NuevoInsp: tNuevoInspector; { Almacenará los datos de un inspector }

begin
    frmNuevoInspector_Auxi := TFrmNuevoInspector.Create(Application);
    try
      if Modif then
         frmNuevoInspector_Auxi.edtNombreInspector.Text := NombreInsp
      else
         frmNuevoInspector_Auxi.edtNombreInspector.Text := '';

      frmNuevoInspector_Auxi.Caption := 'Cambio de password de un Inspector';
      if (frmNuevoInspector_Auxi.ShowModal = mrOk) then
      begin
          // Leemos los datos del inspector del form y calculamos el nº inspector
          NuevoInsp.sNombre:= frmNuevoInspector_Auxi.edtNombreInspector.Text;
          NuevoInsp.sApellido:= frmNuevoInspector_Auxi.edtNombreInspector.Text;
          NuevoInsp.sPassword := frmNuevoInspector_Auxi.edtPassword.Text;

          // Hay que dar de cambiar el password al inspector en la tabla INSPECTORES
          if (frmNuevoInspector_Auxi.CambiarPasswordTablaInspectores (NuevoInsp)) then
          begin
              // Como se ha modificado la tabla TREVISOR, hey que generar un nuevo fichero INSPECT.TXT
              bFicheroInspModificado := True;
          end;
      end;
    finally
         frmNuevoInspector_Auxi.Free;
    end;
end;


// Imprime un listado con los nombres y números de los inspectores
procedure TfrmMantenimientoInspectores.ImprimirListadoInspectores;
var
  aFTmp: TFTmp;
  frmListadoInspectores_Auxi: TfrmListadoInspectores;

begin
    aFTmp := TFTmp.Create (Application);
    Self.Enabled := False;
    try
      aFTmp.MuestraClock('Impresión', 'Imprimiendo un listado de inspectores');

      frmListadoInspectores_Auxi := TfrmListadoInspectores.Create(Application);
      try
        if ImpresoraPreparada_ImprimirInformes then
        begin
           FrmListadoInspectores_Auxi.SeleccionarInspectores;
           frmListadoInspectores_Auxi.QRInspectores.Print;
        end
        else
        begin
            aFTmp.Hide;
            Lanzar_ErrorImpresion_Mantenimiento;
        end;
      finally
           frmListadoInspectores_Auxi.Free;
      end;
    finally
         Self.Enabled := True;
         Self.Show;
         aFTmp.Free;
    end;
end;


procedure TfrmMantenimientoInspectores.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
   if Key = Chr(VK_RETURN) then
   begin
       Perform (WM_NEXTDLGCTL, 0, 0);
       Key := #0;
   end;
end;



procedure TfrmMantenimientoInspectores.FormCreate(Sender: TObject);
begin
    BBCrearIni.Caption:='&Generar'+#10#13+'Archivo INI';
    bFicheroInspModificado := False;
end;

// Hay que pasar datos de la Tabla TREVISOR a un fichero INI
procedure TFrmMantenimientoInspectores.Generacion_FicheroInspectores (aForm: TForm; const sTipoTer: string);
var
   { FicheroINIDe contiene la cabecera del mensaje de salida indicando si ha
     sido generado correcta o incorrectamente.
     Mens_Sal es un mensaje de información para el usuario indicando si se ha
     podido o no generar el fichero INI }
   FicheroINIDe, Mens_Sal: string;
begin
FicheroINIDe := 'Inspectores';
if (TipoEquipo <> CONSOLA_VALUE) then
  begin
  If PasarDe_TablaTREVISOR_FicheroINI (TipoEquipo, DirectorioIn) then
    Mens_Sal := MSJ_UMAIN_FICHINI_CORRECTO
  else
    Mens_Sal := MSJ_UMAIN_FICHINI_INCORRECTO;
  end;
aForm.Hide;
Mostrar_Mensaje_Salida_FicherosINI (FicheroINIDe, Mens_Sal);
end;


procedure TfrmMantenimientoInspectores.btnAceptarClick(Sender: TObject);
begin
  case rdgrpMantenimientoInspectores.ItemIndex of
    0: AltaNuevoInspector;
    1: BusquedaInspectores;
  end;
end;

procedure TfrmMantenimientoInspectores.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    { Si se pulsa Alr+F4 => se asocia dicha combinación de teclas a CANCELAR }
    if Ha_Pulsado_AltF4 (Shift, Key) then
       btnCancelarClick(Sender);
end;

procedure TfrmMantenimientoInspectores.btnCancelarClick(Sender: TObject);
{ Se ha modificado el fichero de inspectores. Si se trata de una
  estación cliente, entonces NO generamos el fichero de inspectores. }
var
   aFTmp: TFTmp;

begin
{    aFTmp := TFTmp.Create (Application);
    Self.Enabled := False;
    try
      if (bFicheroInspModificado) then
      begin
          aFTmp.MuestraClock('Ficheros', 'Generando el fichero inspectores');
          if (TipoEquipo <> CONSOLA_VALUE) then
             Generacion_FicheroInspectores (aFTmp, TipoEquipo);
          {$IFDEF TRAZAS} {
             FTrazas.PonAnotacion (TRAZA_FLUJO,2,FICHERO_ACTUAL,TipoEquipo);
          {$ENDIF}
{      end
      else
      begin
          {$IFDEF TRAZAS}
{             FTrazas.PonAnotacion (TRAZA_FLUJO,1,FICHERO_ACTUAL,'No se ha modificado la tabla TREVISOR');
          {$ENDIF}
{      end;
    finally
         Self.Enabled := True;
         Self.Show;
         aFTmp.Free;
    end;}
Close;
end;

    
procedure TfrmMantenimientoInspectores.BBCrearIniClick(Sender: TObject);
{ Se ha modificado el fichero de inspectores. Si se trata de una
  estación cliente, entonces NO generamos el fichero de inspectores. }
var
   FicheroINIDe, Mens_Sal: string;
begin
FicheroINIDe := 'Inspectores';
  if (TipoEquipo <> CONSOLA_VALUE) then
    begin
    If PasarDe_TablaTREVISOR_FicheroINI (TipoEquipo, DirectorioIn) then
      MessageDlg('El archivo "INSPECT.txt" se genero '+#13#10+'correctamente!!!', mtInformation, [mbOK], 0);
    end
  else
    MessageDlg('Asegurese que la PC sea un SERVIDOR'+#13#10+'Cualquier duda consulte con el responsable de sistemas.', mtWarning, [mbOK], 0);
end;


end.
