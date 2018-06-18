unit UFCortesiaVencimiento;
{ Mantenimiento Datos Variables - D�as de Cortes�a }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, RXSpin, USagVarios, Db, Mask,
  DBCtrls, UCDBEdit;

type
  TFCortesiaVencimiento = class(TForm)
    BBAceptar: TBitBtn;
    BBCancelar: TBitBtn;
    Label1: TLabel;
    CCortesia: TColorDBEdit;
    RxSpnBtnCortesia: TRxSpinButton;
    DSourceTVarios: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure CCortesiaExit(Sender: TObject);
    procedure CCortesiaEnter(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BBCancelarClick(Sender: TObject);
    procedure RxSpnBtnCortesiaBottomClick(Sender: TObject);
    procedure RxSpnBtnCortesiaTopClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    bHuboError: boolean;
  end;

var
  FCortesiaVencimiento: TFCortesiaVencimiento;


procedure Mantenimiento_DiasCortesia (aForm: TForm);


implementation

{$R *.DFM}

uses
    Ulogs,
    UCDialgs,
    Globals,
    UInterfazUsuario,
    UFTmp;

const
    MIN_DIAS_CORTESIA = 1;  { number (1) }
    MAX_DIAS_CORTESIA = 5;  { number (1) }

resourcestring
        FICHERO_ACTUAL = 'UFCortesiaVencimiento.pas';
        MSJ_DIAS_CORTESIA = 'Seleccionar N�mero de D�as de Cortes�a';

        MSJ_APLIC_PARADO = 'Para poder modificar los datos deber� asegurarse que NO hay ning�n programa SAG ESTACION ejecut�ndose. �Desea continuar?';

        
procedure Mantenimiento_DiasCortesia (aForm: TForm);
var
   FCortesiaVencimiento_Auxi: TFCortesiaVencimiento;

begin
    aForm.Enabled := False;
    try
      if (MessageDlg ('Aviso',MSJ_APLIC_PARADO, mtInformation, [mbYes, mbNo], mbNo, 0) = mrYes) then
      begin
          FCortesiaVencimiento_Auxi := TFCortesiaVencimiento.Create (Application);
          try
             if (not FCortesiaVencimiento_Auxi.bHuboError) then
                FCortesiaVencimiento_Auxi.ShowModal;

          finally
               FCortesiaVencimiento_Auxi.Free;
          end;
      end;
    finally
         aForm.Enabled := True;
         aForm.Show;
    end;
end;


procedure TFCortesiaVencimiento.FormCreate(Sender: TObject);
begin
    bHuboError := True;
    try
       DSourceTVarios.Dataset := fVarios.Dataset;

       if (not fVarios.IsNew) then
       begin
           fVarios.Edit;
           bHuboError := False;
       end
      else
      begin
          MessageDlg(Caption,'Error inicializando el formulario de mantenimiento de datos de cortes�a de vencimiento. Comience de nuevo y si el error persiste, ind�quelo al Jefe de Planta.', mtInformation, [mbOk],mbOk,0);
          fIncidencias.PonAnotacion(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Error inicializando el formulario de mantenimiento de cortes�a de vencimiento por que no hay ning�n registro en TVARIOS');
      end;

    except
        on E:Exception do
        begin
            MessageDlg(Caption,'Error inicializando el formulario de d�as de cortes�a de estaciones. Comience de nuevo y si el error persiste, ind�quelo al Jefe de Planta.', mtInformation, [mbOk],mbOk,0);
            fIncidencias.PonAnotacion (TRAZA_SIEMPRE,2,FICHERO_ACTUAL,Format('Error inicializando el formulario de d�as de cortes�a de estaciones: %s. Comience de nuevo y si el error persiste, ind�quelo al Jefe de Planta.',[E.message]));
        end
    end;
end;

procedure TFCortesiaVencimiento.BBAceptarClick(Sender: TObject);
var
  aTmp: TFTmp;

begin
     aTmp := TFTmp.Create (Application);
     Self.Enabled := False;
     try
         aTmp.MuestraClock('Actualizando Datos','Actualizando los datos de d�as de cortes�a de la planta');
         try
            fVarios.Post(true);
            ModalResult := mrOk
         except
             on E:Exception do
             begin
                 fIncidencias.PonAnotacionFmt (TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Error al actualizar en la base de datos por: %s',[E.Message]);
                 MessageDlg (Caption,'Error actualizando el formulario de de d�as de cortes�a de la planta. Compruebe que ha rellenado todos los datos y si el error persiste, ind�quelo al Jefe de Planta.', mtInformation, [mbOk], mbOk, 0);
             end;
         end;
     finally
         aTmp.Free;
         Self.Enabled := True;
         Self.Show
     end;
end;

procedure TFCortesiaVencimiento.CCortesiaExit(Sender: TObject);
begin
    AtenuarControl(Sender, False);
end;

procedure TFCortesiaVencimiento.CCortesiaEnter(Sender: TObject);
begin
    DestacarControl (Sender, clGreen, clWhite,False);
end;

procedure TFCortesiaVencimiento.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TFCortesiaVencimiento.BBCancelarClick(Sender: TObject);
var
  aTmp: TFTmp;

begin
     aTmp := TFTmp.Create (Application);
     try
         aTmp.MuestraClock('Cancelando Datos','Cancelando los datos de d�as de cortes�a de la planta');
         try
            fVarios.Cancel;
         except
             on E:Exception do
             begin
                 fIncidencias.PonAnotacionFmt (TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'Error al actualizar en la base de datos por: %s',[E.Message]);
                 raise Exception.Create ('Error actualizando el formulario de d�as de cortes�a de la planta. Compruebe que ha rellenado todos los datos y si el error persiste, ind�quelo al Jefe de Planta.');
             end;
         end;
     finally
         aTmp.Free;
     end
end;

procedure TFCortesiaVencimiento.RxSpnBtnCortesiaBottomClick(
  Sender: TObject);
var
  iValor: integer;

begin
    try
      iValor := StrToInt (CCortesia.Text);
      if iValor > MIN_DIAS_CORTESIA then
         CCortesia.Text := IntToStr(iValor - 1)
    except
        on E:Exception do
           CCortesia.Text := IntToStr(MIN_DIAS_CORTESIA)
    end;
end;

procedure TFCortesiaVencimiento.RxSpnBtnCortesiaTopClick(Sender: TObject);
var
  iValor: integer;

begin
    try
      iValor := StrToInt (CCortesia.Text);
      if iValor < MAX_DIAS_CORTESIA then
         CCortesia.Text := IntToStr(iValor + 1)
    except
        on E:Exception do
           CCortesia.Text := IntToStr(MAX_DIAS_CORTESIA)
    end;
end;

end.
