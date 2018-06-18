unit mbushist;
{ Form para seleccionar por qu� se desea realizar la b�squeda de un veh�culo.
  Opciones posibles:
      - Patente
      - N� Factura
      - N� Inspecci�n
}

{
  Ultima Traza: 28
  Ultima Incidencia:
  Ultima Anomalia: 9
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, UCTHISTORIALVEHICULO, USAGCLASSES,
  USAGDOMINIOS, UCEdit, FMTBcd, SqlExpr, DB;

type
  TfrmBusquedaHistorial = class(TForm)
    Bevel1: TBevel;
    Label1: TLabel;
    rdgrpHistorial: TRadioGroup;
    lblABuscar: TLabel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    CmbBxTipoFactura: TComboBox;
    edtABuscar: TColorEdit;
    edtNumeroFactura: TColorEdit;
    qryConsultas: TSQLQuery;
    procedure rdgrpHistorialClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnAceptarClick(Sender: TObject);
    procedure CmbBxTipoFacturaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtNumeroFacturaExit(Sender: TObject);
    procedure CmbBxTipoFacturaEnter(Sender: TObject);
    procedure CmbBxTipoFacturaExit(Sender: TObject);
  private
    { Private declarations }
    fPatenteN: TDominioNuevo;
    fPatenteA: TDominioAntiguo;
    fVehiculo: TVehiculo;
    fFactura: TFacturacion;

    procedure PonerHint_EditABuscar;
    procedure CambiarDatos_ABuscar;
    // Dado un n� factura con formato: abcd-nnnnnnnn, devuelve True si abcd se corresponde con el n� de la estaci�n
    function NumEstacionCorrecto (sNumFactura: string): boolean;
    function ObtenerNumeroFactura (sNumFactura: string; var iNumFactura: integer): boolean;
    //True si los datos introducidos son correctos
    function DatosFormValidos: boolean;
  public
    { Public declarations }
    fInspeccion: TInspeccion; //Almacena la �ltima inspecci�n del veh�culo

    procedure InicializarHistorial;
  end;

var
  frmBusquedaHistorial: TfrmBusquedaHistorial;

implementation

{$R *.DFM}

uses
   ULOGS,
   UCDIALGS,
   GLOBALS,
   USAGVARIOS,
   UUTILS,
   USAGESTACION,
   UINTERFAZUSUARIO,
   uhistorial;


resourcestring

    FICHERO_ACTUAL = 'MBusHist';
    CABECERA_MENSAJES_MBUSHIST = 'B�squeda Historial Veh�culo';
    CAPTION_MATRICULA = 'Patente:';
    CAPTION_FACTURA = 'N� Factura:    Tipo:';
    CAPTION_INSPECCION = 'N� Inspecci�n:';
    CAPTION_OBLEA = 'N� Oblea:';

      { Hints del form MBusHist }
      HNT_MBUSHIST_EDTMATRICULA = 'Introduzca la patente del veh�culo|Para realizar el historial del veh�culo deber� introducir la patente del veh�culo';
      HNT_MBUSHIST_EDTFACTURA = 'Introduzca el n� factura del veh�culo|Para realizar el historial del veh�culo deber� introducir el n� factura del veh�culo';
      HNT_MBUSHIST_TIPFACT = 'Seleccione el tipo de factura del veh�culo|Para realizar el historial del veh�culo deber� seleccionar el tipo de factura del veh�culo';
      HNT_MBUSHIST_EDTCERTIFICADO = 'Introduzca el n� certificado del veh�culo|Para realizar el historial del veh�culo deber� introducir el n� certificado del veh�culo';
      HNT_MBUSHIST_EDTINSPECCION = 'Introduzca el n� inspecci�n del veh�culo|Para realizar el historial del veh�culo deber� introducir el n� inspecci�n del veh�culo';
      HNT_MBUSHIST_EDTOBLEA = 'Introduzca el n� oblea del veh�culo|Para realizar el historial del veh�culo deber� introducir el n� oblea del veh�culo';

      { Mensajes enviados al usuario desde MBusHist }
      MSJ_MBUSHIST_MATRICULAMAL = 'La patente del veh�culo para realizar el historial del veh�culo es incorrecta o �sta no se encuentra almacenada';
      MSJ_MBUSHIST_FACTURAMAL = 'El n�mero de factura del veh�culo para realizar el historial del veh�culo es incorrecto o no se encuentra almacenado';
      MSJ_MBUSHIST_CERTIFICADOMAL = 'El n� certificado del veh�culo para realizar el historial del veh�culo es incorrecto o no se encuentra almacenado';
      MSJ_MBUSHIST_INSPECCIONMAL = 'El n� inspecci�n del veh�culo para realizar el historial del veh�culo es incorrecto o no se encuentra almacenado';
      MSJ_MBUSHIST_OBLEAMAL = 'El n� oblea del veh�culo para realizar el historial del veh�culo es incorrecto o no se encuentra almacenado. El formato correcto es: dd-dddddd';



procedure TFrmBusquedaHistorial.InicializarHistorial;
begin
    PonerHint_EditABuscar;
    { Por defecto se har� la b�squeda por matr�cula }
    rdgrpHistorial.ItemIndex := 0;
    CambiarDatos_ABuscar;

    with qryConsultas do
    begin
        Close;
        SQLConnection := MyBD;
    end;

    fInspeccion := nil;
    fPatenteN := nil;
    fPatenteA := nil;
    fVehiculo := nil;
    fFactura := nil;

end;

procedure TFrmBusquedaHistorial.PonerHint_EditABuscar;
begin
    case rdgrpHistorial.ItemIndex of
        0: edtABuscar.Hint := HNT_MBUSHIST_EDTMATRICULA;
        1: begin
               edtNumeroFactura.Hint := HNT_MBUSHIST_EDTFACTURA;
               CmbBxTipoFactura.Hint := HNT_MBUSHIST_TIPFACT;
        end;
        2: edtABuscar.Hint := HNT_MBUSHIST_EDTINSPECCION;
        3: edtABuscar.Hint := HNT_MBUSHIST_EDTOBLEA;
    end;
end;

procedure TFrmBusquedaHistorial.CambiarDatos_ABuscar;
{ Pone el Caption de la etiqueta lblABuscar con un valor u otro dependiendo de
  lo que se haya se�alado en el radiogroup y fija un tama�o m�ximo (MaxLength)
  para edtABuscar }
begin
    case rdgrpHistorial.ItemIndex of
         0: begin
                lblABuscar.Caption := CAPTION_MATRICULA;
                edtABuscar.MaxLength := 10;
                edtABuscar.Enabled := True;
                edtABuscar.Visible := True;
                edtNumeroFactura.Enabled := False;
                edtNumeroFactura.Visible := False;
                CmbBxTipoFactura.Enabled := False;
                CmbBxTipoFactura.Visible := False;
         end;
         1: begin
                lblABuscar.Caption := CAPTION_FACTURA;
                edtABuscar.Enabled := False;
                edtABuscar.Visible := False;
                edtNumeroFactura.Enabled := True;
                edtNumeroFactura.Visible := True;
                CmbBxTipoFactura.Enabled := True;
                CmbBxTipoFactura.Visible := True;
                CmbBxTipoFactura.ItemIndex := 1;
         end;
         2: begin
                lblABuscar.Caption := CAPTION_INSPECCION;
                edtABuscar.MaxLength := 18;
                edtABuscar.Enabled := True;
                edtABuscar.Visible := True;
                edtNumeroFactura.Enabled := False;
                edtNumeroFactura.Visible := False;
                CmbBxTipoFactura.Enabled := False;
                CmbBxTipoFactura.Visible := False;
         end;
         3: begin
                lblABuscar.Caption := CAPTION_OBLEA;
                edtABuscar.MaxLength := 9;
                edtABuscar.Enabled := True;
                edtABuscar.Visible := True;
                edtNumeroFactura.Enabled := False;
                edtNumeroFactura.Visible := False;
                CmbBxTipoFactura.Enabled := False;
                CmbBxTipoFactura.Visible := False;
         end;
    end;
end;

procedure TfrmBusquedaHistorial.rdgrpHistorialClick(Sender: TObject);
begin
    CambiarDatos_ABuscar;
    PonerHint_EditABuscar;
end;

procedure TfrmBusquedaHistorial.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
    if (Key = Chr(VK_RETURN)) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TfrmBusquedaHistorial.btnAceptarClick(Sender: TObject);
begin
    if DatosFormValidos then
       ModalResult := mrOk;
end;

//True si los datos introducidos son correctos
function TfrmBusquedaHistorial.DatosFormValidos: boolean;
var
  iNumFactura: integer;

begin
    Result := False;
    if (rdgrpHistorial.ItemIndex = 0) then // buscamos por patente
    begin
        fPatenteN := TDominioNuevo.Create(MyBD,edtABuscar.Text);
        if ((fPatenteN.Complementaria = '') and (fPatenteN.PerteneceA='')) then //La patente no es nueva
        begin
            try
               fPatenteA := TDominioAntiguo.Create(MyBD,edtABuscar.Text);
               if ((fPatenteA.Complementaria = '') and (fPatenteA.PerteneceA='')) then //La patente no existe
               begin
                   MessageDlg (Application.Title, 'La patente introducida no existe', mtInformation, [mbOk], mbOk, 0);
                   edtABuscar.SetFocus;
                   exit;
               end
               else
               begin
                   fVehiculo := TVehiculo.CreateByRowId (MyBD, fPatenteA.PerteneceA);
               end
            except
                on E:Exception do
                begin
                    MessageDlg (Application.Title, 'La patente introducida no existe', mtInformation, [mbOk], mbOk, 0);
                    edtABuscar.SetFocus;
                    exit;
                end
            end;
        end
        else
           fVehiculo := TVehiculo.CreateByRowId (MyBD, fPatenteN.PerteneceA);

        try
           try
              fVehiculo.Open;
              fInspeccion := fVehiculo.GetInspectionsFinalizadasConInforme;
              fInspeccion.Open;
              if (fInspeccion.RecordCount = 0) then
              begin
                  MessageDlg (Application.Title,'La factura no tiene inspecciones finalizadas o sus inspecciones son gratuitas o preverificaciones', mtInformation, [mbOk], mbOk, 0);
                  edtABuscar.SetFocus;
              end
              else
                 Result := True;
           finally
                fVehiculo.Free;
           end;
        finally
             fPatenteN.Free;
             fPatenteA.Free;
        end;
    end
    else if (rdgrpHistorial.ItemIndex = 1) then // buscamos por n� factura
    begin
        if ((NumEstacionCorrecto (edtNumeroFactura.Text)) and (ObtenerNumeroFactura (edtNumeroFactura.Text, iNumFactura))) then
        begin
            fFactura := TFacturacion.CreateByTipoNumero (MyBD, CmbBxTipoFactura.Items[CmbBxTipoFactura.ItemIndex], iNumFactura);
            try
              fFactura.Open;
              if (fFactura.RecordCount = 0) then
              begin
                  MessageDlg (Application.Title,'La factura no tiene inspecciones finalizadas o sus inspecciones son gratuitas o preverificaciones', mtInformation, [mbOk], mbOk, 0);
                  edtNumeroFactura.SetFocus;
              end
              else
              begin
                  fInspeccion := fFactura.GetInspeccionFinalizadasConInforme;
                  fInspeccion.Open;
                  if (fInspeccion.RecordCount = 0) then
                  begin
                      MessageDlg (Application.Title,'La factura no tiene inspecciones finalizadas o sus inspecciones son gratuitas o preverificaciones', mtInformation, [mbOk], mbOk, 0);
                      edtABuscar.SetFocus;
                  end
                  else
                     Result := True;
              end
            finally
                 fFactura.Free;
            end;
        end;
    end
    else if (rdgrpHistorial.ItemIndex = 2)
        then begin// buscamos por n� inspeccion
            fInspeccion := TInspeccion.Create(MyBD,Format('where %s=%d and %s=%d and %s=''S'' and %s not in (''%s'',''%s'')',[FIELD_EJERCICI,Obtener_Ejercicio (edtABuscar.Text),FIELD_CODINSPE,Obtener_NumeroInspeccion (edtABuscar.Text), FIELD_INSPFINA, FIELD_TIPO,T_PREVERIFICACION, T_GRATUITA]));
            fInspeccion.Open;
            if fInspeccion.RecordCount = 0
            then begin
                MessageDlg (Application.Title, 'La inspecci�n no existe, no se ha finalizado o sus inspecciones son gratuitas o preverificaciones', mtInformation, [mbOk], mbOk, 0);
                edtABuscar.SetFocus;
            end
            else Result := True;
       end
       else begin
            fInspeccion := TInspeccion.Create(MyBD,Format('where %s=''%S'' and %s=''S'' and %s not in (''%s'',''%s'')',[FIELD_NUMOBLEA, edtABuscar.Text, FIELD_INSPFINA, FIELD_TIPO,T_PREVERIFICACION, T_GRATUITA]));
            fInspeccion.Open;
            if fInspeccion.RecordCount = 0
            then begin
                MessageDlg (Application.Title, 'La inspecci�n no existe, no se ha finalizado o sus inspecciones son gratuitas o preverificaciones', mtInformation, [mbOk], mbOk, 0);
                edtABuscar.SetFocus;
            end
            else Result := True;
       end
end;

procedure TfrmBusquedaHistorial.CmbBxTipoFacturaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if Key = VK_SPACE then
     Combo_ConTeclas (CmbBxTipoFactura, Key);
end;


procedure TfrmBusquedaHistorial.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    qryConsultas.Close;
end;

// Dado un n� factura con formato: abcd-nnnnnnnn, devuelve True si abcd se corresponde con el n� de la estaci�n
function TfrmBusquedaHistorial.NumEstacionCorrecto (sNumFactura: string): boolean;
var
   iCodErr, iNumFactura: integer;
   sCadAuxi: string; { cadena auxiliar }

begin
    Result := False;
    try
       try
          { N� introducido: 9999-99999999 y s�lo queremos los 4 primeros d�gitos }
          sCadAuxi := Copy (sNumFactura, 1, 4);
          Val (sCadAuxi, iNumFactura, iCodErr);
          Result := ((iCodErr = 0) and (iNumFactura = fVarios.CodeEstacion));
       except
            on E:Exception do
            begin
                FAnomalias.PonAnotacion (TRAZA_SIEMPRE,3,FICHERO_ACTUAL, 'Error en NumEstacionCorrecto: ' + E.Message);
            end;
       end;
    finally
    end;
end;


function TfrmBusquedaHistorial.ObtenerNumeroFactura (sNumFactura: string; var iNumFactura: integer): boolean;
{ Devuelve True si sNumFactura se puede pasar a n� entero }
var
   iCodErr: integer;
   sCadAuxi: string; { cadena auxiliar }

begin
    Result := False;
    try
       { N� introducido: 9999-99999999 y s�lo queremos los 8 �ltimos d�gitos }
       sCadAuxi := Copy (sNumFactura, 6, 8);
       Val (sCadAuxi, iNumFactura, iCodErr);
       Result := (iCodErr = 0);
    except
         on E:Exception do
         begin
             FAnomalias.PonAnotacion (TRAZA_SIEMPRE,9,FICHERO_ACTUAL,'Error en ObtenerNumeroFactura: ' + E.Message);
         end;
    end;
end;



procedure TfrmBusquedaHistorial.edtNumeroFacturaExit(Sender: TObject);
begin
    TEdit(Sender).Text := Trim (TEdit(Sender).Text);
end;

procedure TfrmBusquedaHistorial.CmbBxTipoFacturaEnter(Sender: TObject);
begin
    DestacarControl (Sender, clGreen, clWhite, False);
end;

procedure TfrmBusquedaHistorial.CmbBxTipoFacturaExit(Sender: TObject);
begin
    AtenuarControl (Sender, False);
end;

end.
