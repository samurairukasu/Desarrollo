unit UFGestionInspecciones;
{ Mantenimiento Datos Variables - Gestión de Inspecciones }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, USagVarios, Db, DBCtrls;

type
  TfrmGestionInspecciones = class(TForm)
    BBAceptar: TBitBtn;
    BBCancelar: TBitBtn;
    Bevel1: TBevel;
    chkbxVoluntarias: TDBCheckBox;
    chkbxGratuitas: TDBCheckBox;
    chkbxPreverificaciones: TDBCheckBox;
    chkbxGuardarInspecciones: TDBCheckBox;
    chkbxStandBy: TDBCheckBox;
    Image1: TImage;
    DSourceTVarios: TDataSource;
    procedure chkbxVoluntariasEnter(Sender: TObject);
    procedure chkbxVoluntariasExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BBCancelarClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    bHuboError: boolean;
  end;

var
  frmGestionInspecciones: TfrmGestionInspecciones;


  procedure Mantenimiento_GestionInspecciones (aForm: TForm);


implementation

{$R *.DFM}


uses
   UInterfazUsuario,
   Globals,
   ULogs,
   UCDialgs,
   UFTmp;


resourcestring
      FICHERO_ACTUAL = 'UFGestionInspecciones.pas';

      MSJ_APLIC_PARADO = 'Para poder modificar los datos deberá asegurarse que NO hay ningún programa SAG ESTACION ejecutándose. ¿Desea continuar?';


procedure Mantenimiento_GestionInspecciones (aForm: TForm);
var
   frmGestionInspecciones_Auxi: TfrmGestionInspecciones;

begin
    aForm.Enabled := False;
    try
      if (MessageDlg ('Aviso',MSJ_APLIC_PARADO, mtInformation, [mbYes, mbNo], mbNo, 0) = mrYes) then
      begin
          frmGestionInspecciones_Auxi := TfrmGestionInspecciones.Create (Application);
          try
             if (not frmGestionInspecciones_Auxi.bHuboError) then
                frmGestionInspecciones_Auxi.ShowModal;

          finally
               frmGestionInspecciones_Auxi.Free;
          end;
      end;
    finally
         aForm.Enabled := True;
         aForm.Show;
    end;
end;


procedure TfrmGestionInspecciones.chkbxVoluntariasEnter(Sender: TObject);
begin
    DestacarControl (Sender, clGreen, clWhite,False);
end;

procedure TfrmGestionInspecciones.chkbxVoluntariasExit(Sender: TObject);
begin
    AtenuarControl(Sender, False);
end;

procedure TfrmGestionInspecciones.FormCreate(Sender: TObject);
begin
    bHuboError := True;

    try
      DSourceTVarios.Dataset := fVarios.Dataset;

      fVarios.START;
      if (not fVarios.LockedTable) then
      begin
          fVarios.Close;
          fVarios.LockedTable := True;
          fVarios.Open;

          if (not fVarios.IsNew) then
          begin
              fVarios.Edit;
              bHuboError := False;
          end
          else
          begin
              MessageDlg(Caption,'Error inicializando el formulario de mantenimiento de gestión de inspecciones de estaciones: %s. Espere unos minutos y si el error persiste, indíquelo al Jefe de Planta.', mtInformation, [mbOk],mbOk,0);
              fIncidencias.PonAnotacion(TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'Error inicializando el formulario de gestión de inspecciones de la planta por tabla bloqueada.');
          end;
      end
      else
      begin
            MessageDlg(Caption,'Error inicializando el formulario de mantenimiento de gestión de inspecciones de estaciones: %s. Espere unos minutos y si el error persiste, indíquelo al Jefe de Planta.', mtInformation, [mbOk],mbOk,0);
            fIncidencias.PonAnotacion(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Error inicializando el formulario de gestión de inspecciones de la planta por tabla bloqueada.');
      end;
    except
        on E:Exception do
        begin
            MessageDlg(Caption,'Error inicializando el formulario de mantenimiento de datos de gestión de inspecciones de estaciones. Comience de nuevo y si el error persiste, indíquelo al Jefe de Planta.', mtInformation, [mbOk],mbOk,0);
            fIncidencias.PonAnotacion (TRAZA_SIEMPRE,2,FICHERO_ACTUAL,Format('Error inicializando el formulario de mantenimiento de gestión de inspecciones de estaciones: %s. Comience de nuevo y si el error persiste, indíquelo al Jefe de Planta.',[E.message]));
        end
    end;
end;

procedure TfrmGestionInspecciones.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;


procedure TfrmGestionInspecciones.BBAceptarClick(Sender: TObject);
var
  aTmp: TFTmp;

begin
     aTmp := TFTmp.Create (Application);
     Self.Enabled := False;
     try
         aTmp.MuestraClock('Actualizando Datos','Actualizando los datos de gestión de inspecciones');
         try
            fVarios.Post(true);
            ModalResult := mrOk
         except
             on E:Exception do
             begin
                 fIncidencias.PonAnotacionFmt (TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'Error al actualizar en la base de datos por: %s',[E.Message]);
                 MessageDlg (Caption,'Error actualizando el formulario de mantenimiento de gestión de inspecciones de la planta. Compruebe que ha rellenado todos los datos y si el error persiste, indíquelo al Jefe de Planta.', mtInformation, [mbOk], mbOk, 0);
             end;
         end;
     finally
         aTmp.Free;
         Self.Enabled := True;
         Self.Show;
     end;
end;

procedure TfrmGestionInspecciones.FormDestroy(Sender: TObject);
begin
   try
      fVarios.COMMIT;
   except
       on E:Exception do
       begin
           MessageDlg(Caption,'Error finalizando el formulario de mantenimiento de gestión de inspecciones de estaciones. Comience de nuevo y si el error persiste, indíquelo al Jefe de Planta.', mtInformation, [mbOk],mbOk,0);
           fIncidencias.PonAnotacion (TRAZA_SIEMPRE,4,FICHERO_ACTUAL,Format('Error inicializando el formulario de mantenimiento de gestión de inspecciones por :%s',[E.message]));
       end
   end;
end;

procedure TfrmGestionInspecciones.BBCancelarClick(Sender: TObject);
var
  aTmp: TFTmp;

begin
     aTmp := TFTmp.Create (Application);
     Self.Enabled := False;
     try
         aTmp.MuestraClock('Cancelando Datos','Cancelando los datos de gestión de inspecciones de la planta');
         try
            fVarios.Cancel;
         except
             on E:Exception do
             begin
                 fIncidencias.PonAnotacionFmt (TRAZA_SIEMPRE,5,FICHERO_ACTUAL,'Error al actualizar en la base de datos por: %s',[E.Message]);
                 raise Exception.Create ('Error actualizando el formulario de mantenimiento de gestión de inspecciones de la planta. Compruebe que ha rellenado todos los datos y si el error persiste, indíquelo al Jefe de Planta.');
             end;
         end;
     finally
         aTmp.Free;
         Self.Enabled := True;
         Self.Show;
     end
end;

end.
