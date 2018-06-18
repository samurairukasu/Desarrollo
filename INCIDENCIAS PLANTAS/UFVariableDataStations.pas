unit UFVariableDataStations;
{ Mantenimiento Datos Variables - Estación }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  USagVarios, StdCtrls, Buttons, ExtCtrls, UCEdit, RXSpin, Mask,
  CurrEdit, Db, DBCtrls, UCDBEdit, RXLookup, ComCtrls, USAGCLASSES;

type
  TfrmVariableDataStations = class(TForm)
    Bevel1: TBevel;
    BBAceptar: TBitBtn;
    BBCancelar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Image1: TImage;
    DSourceTVARIOS: TDataSource;
    DSProvincias: TDataSource;
    RxSEdtEstacion: TColorDBEdit;
    RxSpnEdtZona: TColorDBEdit;
    RxSpinButton1: TRxSpinButton;
    RxSpinButton2: TRxSpinButton;
    edtHInicio2: TColorDBEdit;
    edtHFin2: TColorDBEdit;
    edtResponsable: TColorDBEdit;
    edtCUIT: TColorDBEdit;
    edtIdentificacion: TColorDBEdit;
    edtTelefono: TColorDBEdit;
    edtFAX: TColorDBEdit;
    edtDireccion: TColorDBEdit;
    edtCPostal: TColorDBEdit;
    edtLocalidad: TColorDBEdit;
    cmbbxprovincia: TRxDBLookupCombo;
    Panel1: TPanel;
    Label12: TLabel;
    edtHInicio: TDateTimePicker;
    Label13: TLabel;
    edtHFin: TDateTimePicker;
    DBBMedauto: TDBComboBox;
    Label15: TLabel;
    GroupBox1: TGroupBox;
    DBComboBox1: TDBComboBox;
    Label16: TLabel;
    ColorDBEdit1: TColorDBEdit;
    ColorDBEdit2: TColorDBEdit;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    ColorDBEdit3: TColorDBEdit;
    Bevel2: TBevel;
    Label14: TLabel;
    ColorDBEdit4: TColorDBEdit;
    GroupBox2: TGroupBox;
    Label20: TLabel;
    DBBIIBB: TDBComboBox;
    edNroSucur: TColorDBEdit;
    Label21: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmbbxProvinciaEnter(Sender: TObject);
    procedure cmbbxProvinciaExit(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BBCancelarClick(Sender: TObject);
    procedure edtHInicioChange(Sender: TObject);
    procedure edtHFinChange(Sender: TObject);
    procedure RxSpinButton1TopClick(Sender: TObject);
    procedure RxSpinButton1BottomClick(Sender: TObject);
    procedure RxSpinButton2TopClick(Sender: TObject);
    procedure RxSpinButton2BottomClick(Sender: TObject);
    procedure edtHInicioEnter(Sender: TObject);
    procedure edtHInicioExit(Sender: TObject);
    procedure edtHInicioClick(Sender: TObject);
    procedure DBBMedautoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    fOldDateFormat: string;
    fTProvincias: TProvincias;

  public
    { Public declarations }
    bHuboError: boolean;
  end;



procedure Mantenimiento_DatosEstacion (aForm: TForm);


var
  frmVariableDataStations: TfrmVariableDataStations;


implementation

{$R *.DFM}

uses
   GLOBALS,
   ULOGS,
   UCDIALGS,
   UINTERFAZUSUARIO,
   UUTILS,
   USAGCUIT,
   UFTMP;


const
    MINIMO_NUMERO_ESTACION_ZONA = 1;
    MAXIMO_NUMERO_ESTACION_ZONA = 99;

resourcestring
       FICHERO_ACTUAL = 'UFVariableDataStations.pas';
       MSJ_DATOS_ESTACION = 'Datos de la Planta Concesionaria';
       MSJ_CUIT_MAL = 'El CUIT introducido es incorrecto. Por favor, introdúzcalo de nuevo';
       MSJ_HORA_MAL = 'La hora introducida no es correcta. Por favor, introdúzcala de nuevo';
       MSJ_HORA_MENOR = 'La hora de inicio de trabajo debe ser menor o igual que la hora de fin del mismo';
       MSJ_FALTA_RESPONSABLE = 'Debe introducir el nombre del responsable de la planta';
       MSJ_FALTA_IDENTIFICACION = 'Debe introducir el nombre de la planta concesionaria';
       MSJ_FALTA_TELEFONO = 'Por favor, teclee el número de teléfono de la planta';
       MSJ_FALTA_FAX = 'Debe introducir el número de fax de la concesionaria';
       MSJ_FALTA_DIRECCION = 'Teclee la dirección donde está situada la planta';
       MSJ_FALTA_CPOSTAL = 'Escriba el código postal que tiene asignado la planta';
       MSJ_FALTA_LOCALIDAD = 'Debe introducir la localidad en la que se encuentra la concesionaria';
       MSJ_FALTA_PROVINCIA = 'Por favor, seleccione una de las provincias disponibles';
       MSJ_HORA_CERO = 'Por favor, introduzca la hora de inicio o fin de la jornada laboral';


       MSJ_APLIC_IMPR_PARADOS = 'Para poder modificar los datos deberá asegurarse que NO hay ningún programa SAG ESTACION ejecutándose y que todos los servidores de impresión están parados. ¿Desea continuar?';


procedure Mantenimiento_DatosEstacion (aForm: TForm);

var
  frmVariableDataStations_Auxi: TfrmVariableDataStations;

begin
    aForm.Enabled := False;
    try
      if (MessageDlg ('Aviso',MSJ_APLIC_IMPR_PARADOS, mtInformation, [mbYes, mbNo], mbNo, 0) = mrYes) then
      begin
          frmVariableDataStations_Auxi := TfrmVariableDataStations.Create (Application);
          try
             if (not frmVariableDataStations_Auxi.bHuboError) then
                frmVariableDataStations_Auxi.ShowModal;

          finally
               frmVariableDataStations_Auxi.Free;
          end;
      end;
    finally
         aForm.Enabled := True;
         aForm.Show;
    end;
end;


procedure TfrmVariableDataStations.FormCreate(Sender: TObject);
begin
    fOldDateFormat := ShortDateFormat;
    ShortDateFormat := 'dd/mm/yyyy hh:mm:ss';

    bHuboError := True;

    fTProvincias := TProvincias.Create (MyBD);

    try
      DSourceTVarios.Dataset := fVarios.Dataset;
      DSProvincias.Dataset := fTProvincias.Dataset;

      ftProvincias.Open;
      fVarios.START;
      if (not fVarios.LockedTable) then
      begin
          fVarios.Close;
          fVarios.LockedTable := True;
          fVarios.Open;

          fVarios.SetMask ('HOINITRA','!99/99/9999 99:99:99;1; ','dd/mm/yyyy hh:mm:ss');
          fVarios.SetMask ('HOFINTRA','!99/99/9999 99:99:99;1; ','dd/mm/yyyy hh:mm:ss');
          fVarios.SetMask ('CUIT_CON','99-99999999-9;1; ','');

          if fVarios.IsNew then
             fVarios.Append
          else
             fVarios.Edit;

          edtHInicio.Time := StrToTime(FormatDateTime ('hh:mm:ss',fVarios.HoraInicio));
          edtHFin.Time := StrToTime(FormatDateTime ('hh:mm:ss',fVarios.HoraFin));
      end
      else
      begin
          MessageDlg(Caption,'Error inicializando el formulario de mantenimiento de datos de estaciones: %s. Espere unos minutos y si el error persiste, indíquelo al Jefe de Planta.', mtInformation, [mbOk],mbOk,0);
          fIncidencias.PonAnotacion(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Error inicializando el formulario de mantenimiento de la planta por tabla bloqueada.');
      end;

      CmbBxProvincia.LookupDisplayIndex := 1;

      bHuboError := False;
    except
        on E:Exception do
        begin
            MessageDlg(Caption,'Error inicializando el formulario de mantenimiento de datos de estaciones. Comience de nuevo y si el error persiste, indíquelo al Jefe de Planta.', mtInformation, [mbOk],mbOk,0);
            fIncidencias.PonAnotacion (TRAZA_SIEMPRE,2,FICHERO_ACTUAL,Format('Error inicializando el formulario de mantenimiento de datos de estaciones: %s. Comience de nuevo y si el error persiste, indíquelo al Jefe de Planta.',[E.message]));
        end
    end;
end;




procedure TfrmVariableDataStations.FormDestroy(Sender: TObject);
begin
   ShortDateFormat := fOldDateFormat;

   fTProvincias.Free;
   try
      fVarios.COMMIT;
   except
       on E:Exception do
       begin
           MessageDlg(Caption,'Error finalizando el formulario de mantenimiento de datos de estaciones. Comience de nuevo y si el error persiste, indíquelo al Jefe de Planta.', mtInformation, [mbOk],mbOk,0);
           fIncidencias.PonAnotacion (TRAZA_SIEMPRE,3,FICHERO_ACTUAL,Format('Error inicializando el formulario de mantenimiento de datos de estaciones por :%s',[E.message]));
       end
   end;
end;


procedure TfrmVariableDataStations.cmbbxProvinciaEnter(Sender: TObject);
begin
    DestacarControl (Sender, clGreen, clWhite,False);
end;

procedure TfrmVariableDataStations.cmbbxProvinciaExit(Sender: TObject);
begin
    AtenuarControl(Sender, False);
end;


procedure TfrmVariableDataStations.BBAceptarClick(Sender: TObject);
var
  aTmp: TFTmp;

begin
     aTmp := TFTmp.Create (Application);
     Self.Enabled := False;
     try
         aTmp.MuestraClock('Actualizando Datos','Actualizando los datos de la planta');
         try
            fVarios.Post(true);
            ModalResult := mrOk
         except
             on E:Exception do
             begin
                 aTmp.Hide;
                 fIncidencias.PonAnotacionFmt (TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Error al actualizar en la base de datos por: %s',[E.Message]);
                 MessageDlg (Caption,'Error actualizando el formulario de mantenimiento de datos de la planta. Compruebe que ha rellenado todos los datos y si el error persiste, indíquelo al Jefe de Planta.', mtInformation, [mbOk], mbOk, 0);
             end;
         end;
     finally
         aTmp.Free;
         Self.Enabled := True;
         Self.Show;
     end;
end;


procedure TfrmVariableDataStations.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;



procedure TfrmVariableDataStations.BBCancelarClick(Sender: TObject);
var
  aTmp: TFTmp;

begin
//    fTProvincias.Cancel;
     aTmp := TFTmp.Create (Application);
     Self.Enabled := False;
     try
         aTmp.MuestraClock('Cancelando Datos','Cancelando los datos de la planta');
         try
            fVarios.Cancel;
            fVarios.DataSet.CancelUpdates;
         except
             on E:Exception do
             begin
                 aTmp.Hide;
                 fIncidencias.PonAnotacionFmt (TRAZA_SIEMPRE,5,FICHERO_ACTUAL,'Error al actualizar en la base de datos por: %s',[E.Message]);
                 raise Exception.Create ('Error actualizando el formulario de mantenimiento de datos de la planta. Compruebe que ha rellenado todos los datos y si el error persiste, indíquelo al Jefe de Planta.');
             end;
         end;
     finally
         aTmp.Free;
         Self.Enabled := True;
         Self.Show;
     end
end;


procedure TfrmVariableDataStations.edtHInicioChange(Sender: TObject);
begin
    edtHInicio2.Text := FormatDateTime('dd/mm/yyyy',0) + ' ' + TimeToStr(edtHInicio.Time);
    fVarios.HoraInicio := StrToDateTime (edtHInicio2.Text);
end;

procedure TfrmVariableDataStations.edtHFinChange(Sender: TObject);
begin
    edtHFin2.Text := FormatDateTime('dd/mm/yyyy',0) + ' ' + TimeToStr(edtHFin.Time);
    fVarios.HoraFin := StrToDateTime (edtHFin2.Text);
end;

procedure TfrmVariableDataStations.RxSpinButton1TopClick(Sender: TObject);
var
  iValor: integer;

begin
    try
      iValor := StrToInt (RxSEdtEstacion.Text);
      if iValor < MAXIMO_NUMERO_ESTACION_ZONA then
         RxSEdtEstacion.Text := IntToStr(iValor + 1)
    except
        on E:Exception do
           RxSEdtEstacion.Text := IntToStr(MAXIMO_NUMERO_ESTACION_ZONA)
    end;
end;

procedure TfrmVariableDataStations.RxSpinButton1BottomClick(
  Sender: TObject);
var
  iValor: integer;

begin
    try
      iValor := StrToInt (RxSEdtEstacion.Text);
      if iValor > MINIMO_NUMERO_ESTACION_ZONA then
         RxSEdtEstacion.Text := IntToStr(iValor - 1)
    except
        on E:Exception do
           RxSEdtEstacion.Text := IntToStr(MINIMO_NUMERO_ESTACION_ZONA)
    end;
end;

procedure TfrmVariableDataStations.RxSpinButton2TopClick(Sender: TObject);
var
  iValor: integer;

begin
    try
      iValor := StrToInt (RxSpnEdtZona.Text);
      if iValor < MAXIMO_NUMERO_ESTACION_ZONA then
         RxSpnEdtZona.Text := IntToStr(iValor + 1)
    except
        on E:Exception do
           RxSpnEdtZona.Text := IntToStr(MAXIMO_NUMERO_ESTACION_ZONA)
    end;
end;

procedure TfrmVariableDataStations.RxSpinButton2BottomClick(
  Sender: TObject);
var
  iValor: integer;

begin
    try
      iValor := StrToInt (RxSpnEdtZona.Text);
      if iValor > MINIMO_NUMERO_ESTACION_ZONA then
         RxSpnEdtZona.Text := IntToStr(iValor - 1)
    except
        on E:Exception do
           RxSpnEdtZona.Text := IntToStr(MINIMO_NUMERO_ESTACION_ZONA)
    end;
end;

procedure TfrmVariableDataStations.edtHInicioEnter(Sender: TObject);
begin
    DestacarControl (Sender, clGreen, clWhite, False);
end;

procedure TfrmVariableDataStations.edtHInicioExit(Sender: TObject);
begin
    AtenuarControl(Sender, False);
end;


procedure TfrmVariableDataStations.edtHInicioClick(Sender: TObject);
begin
    Self.Setfocus
end;



procedure TfrmVariableDataStations.DBBMedautoKeyPress(Sender: TObject;
  var Key: Char);
begin
        if not (Key in ['S','N'])
        then key := #0;
        if length((sender as tdbcombobox).Text) > 1 then key := #0;
end;











end.
