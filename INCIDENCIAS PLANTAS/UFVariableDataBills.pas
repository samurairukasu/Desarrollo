unit UFVariableDataBills;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Mask, CurrEdit, StdCtrls, RXSpin, Buttons, USagVarios, 
  Db, DBCtrls, UCDBEdit;

type
  TfrmVariableDataBills = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    BBAceptar: TBitBtn;
    BBCancelar: TBitBtn;
    Image1: TImage;
    DCETarifaBasica: TColorDBEdit;
    DSourceTVarios: TDataSource;
    DCEEdtReverifi: TColorDBEdit;
    RxSpinBtnReverifi: TRxSpinButton;
    DCEEdtIVAIns: TColorDBEdit;
    RxSpinBtnIVAInsc: TRxSpinButton;
    DCEEdtIVANoIns: TColorDBEdit;
    RxSpinBtnIVANoIns: TRxSpinButton;
    DCEEdtCanon: TColorDBEdit;
    RxSpinBtnCanon: TRxSpinButton;
    Label11: TLabel;
    Label12: TLabel;
    DCETarifaBasicagnc: TColorDBEdit;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    RxSBPIB: TRxSpinButton;
    RxSBIMPIIBB: TRxSpinButton;
    CEIIBB: TColorDBEdit;
    CEIMP_IIBB: TColorDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BBCancelarClick(Sender: TObject);
    procedure RxSpinBtnReverifiBottomClick(Sender: TObject);
    procedure RxSpinBtnReverifiTopClick(Sender: TObject);
    procedure RxSpinBtnIVAInscBottomClick(Sender: TObject);
    procedure RxSpinBtnIVAInscTopClick(Sender: TObject);
    procedure RxSpinBtnIVANoInsBottomClick(Sender: TObject);
    procedure RxSpinBtnIVANoInsTopClick(Sender: TObject);
    procedure RxSpinBtnCanonBottomClick(Sender: TObject);
    procedure RxSpinBtnCanonTopClick(Sender: TObject);
    procedure RxSBPIBBottomClick(Sender: TObject);
    procedure RxSBPIBTopClick(Sender: TObject);
    procedure RxSBIMPIIBBBottomClick(Sender: TObject);
    procedure RxSBIMPIIBBTopClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    bHuboError: boolean;
  end;

var
  frmVariableDataBills: TfrmVariableDataBills;


procedure Mantenimiento_DatosFacturacion (aForm: TForm);


implementation

{$R *.DFM}

uses
   GLOBALS,
   ULOGS,
   UCDIALGS,
   UINTERFAZUSUARIO,
   USAGESTACION,
   UFTMP;


const
   MINIMO_NUMERICO = 1;
   MINIMO_IIBB = 0;
   MAXIMO_NUMERO_REVERIFI = 9999; { es un number (6,2) }
   MAXIMO_NUMERO_IVA = 99; { es un number (4,2) }
   MAXIMO_NUMERO_IIBB = 100;
   MAXIMO_NUMERO_CANON = 999; { es un number (5,3) }

   
resourcestring
    FICHERO_ACTUAL = 'UFVariableDataBills.pas';
    MSJ_DATOS_FACTURACION = 'Información de Facturación';

    MSJ_APLIC_IMPR_PARADOS = 'Para poder modificar los datos deberá asegurarse que NO hay ningún programa SAG ESTACION ejecutándose y que todos los servidores de impresión están parados. ¿Desea continuar?';


procedure Mantenimiento_DatosFacturacion (aForm: TForm);
var
  frmVariableDataBills_Auxi: TfrmVariableDataBills;

begin
    aForm.Enabled := False;
    try
      if (MessageDlg ('Aviso',MSJ_APLIC_IMPR_PARADOS, mtInformation, [mbYes, mbNo], mbNo, 0) = mrYes) then
      begin
          frmVariableDataBills_Auxi := TfrmVariableDataBills.Create (Application);
          try
             if (not frmVariableDataBills_Auxi.bHuboError) then
                frmVariableDataBills_Auxi.ShowModal;

          finally
               frmVariableDataBills_Auxi.Free;
          end;
      end;
    finally
         aForm.Enabled := True;
         aForm.Show;
    end;
end;


procedure TfrmVariableDataBills.FormCreate(Sender: TObject);
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
          MessageDlg(Caption,'Error inicializando el formulario de mantenimiento de datos de facturación. Comience de nuevo y si el error persiste, indíquelo al Jefe de Planta.', mtInformation, [mbOk],mbOk,0);
          fIncidencias.PonAnotacion(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Error inicializando el formulario de mantenimiento de facturación por que no hay ningún registro en TVARIOS');
      end;
    except
        on E:Exception do
        begin
            MessageDlg(Caption,Format('Error inicializando el formulario de mantenimiento de datos de facturación: %s. Comience de nuevo y si el error persiste, indíquelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk],mbOk,0);
            fIncidencias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Error inicializando el formulario de mantenimiento de facturación por :%s',[E.message]);
        end
    end;
end;


procedure TfrmVariableDataBills.BBAceptarClick(Sender: TObject);
var
  aTmp: TFTmp;

begin
    aTmp := TFTmp.Create (Application);
    try
       aTmp.MuestraClock('Actualizando Datos','Actualizando los datos de facturación');
        try
           fVarios.Post(true);
           ModalResult := mrOk
        except
            on E:Exception do
            begin
                aTmp.Hide;
                fIncidencias.PonAnotacionFmt (TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'Error al actualizar en la base de datos por: %s',[E.Message]);
                raise Exception.Create ('Error actualizando el formulario de mantenimiento de datos de facturación. Compruebe que ha rellenado todos los datos y si el error persiste, indíquelo al Jefe de Planta.');
            end;
        end;
    finally
         aTmp.Free;
    end;
end;

procedure TfrmVariableDataBills.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;


procedure TfrmVariableDataBills.BBCancelarClick(Sender: TObject);
var
  aTmp: TFTmp;

begin
     aTmp := TFTmp.Create (Application);
     Self.Enabled := False;
     try
         aTmp.MuestraClock('Cancelando Datos','Cancelando los datos de facturación');
         try
            fVarios.Cancel;
         except
             on E:Exception do
             begin
                 aTmp.Hide;
                 fIncidencias.PonAnotacionFmt (TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'Error al actualizar en la base de datos por: %s',[E.Message]);
                 raise Exception.Create ('Error actualizando el formulario de mantenimiento de datos de facturación. Compruebe que ha rellenado todos los datos y si el error persiste, indíquelo al Jefe de Planta.');
             end;
         end;
     finally
         aTmp.Free;
         Self.Enabled := True;
         Self.Show;
     end
end;

procedure TfrmVariableDataBills.RxSpinBtnReverifiBottomClick(Sender: TObject);
var
  iValor: double;

begin
    try
      iValor := StrToFloat (DCEEdtReverifi.Text);
      if iValor > MINIMO_NUMERICO then
         fVarios.ValueByName[FIELD_PORCREVI] := Format ('%1.2f',[iValor - 1])
    except
        on E:Exception do
           fVarios.ValueByName[FIELD_PORCREVI] := IntToStr(MINIMO_NUMERICO)
    end;
end;

procedure TfrmVariableDataBills.RxSpinBtnReverifiTopClick(Sender: TObject);
var
  iValor: double;

begin
    try
      iValor := StrToFloat (DCEEdtReverifi.Text);
      if iValor < MAXIMO_NUMERO_REVERIFI then
         fVarios.ValueByName[FIELD_PORCREVI] := Format('%1.2f',[iValor + 1])
    except
        on E:Exception do
           fVarios.ValueByName[FIELD_PORCREVI] := IntToStr(MAXIMO_NUMERO_REVERIFI)
    end;
end;

procedure TfrmVariableDataBills.RxSpinBtnIVAInscBottomClick(Sender: TObject);
var
  iValor: double;

begin
    try
      iValor := StrToFloat (DCEEdtIVAIns.Text);
      if iValor > MINIMO_NUMERICO then
         fVarios.ValueByName[FIELD_IVAINSCR] := Format ('%1.2f',[iValor - 1])
    except
        on E:Exception do
           fVarios.ValueByName[FIELD_IVAINSCR] := IntToStr(MINIMO_NUMERICO)
    end;
end;

procedure TfrmVariableDataBills.RxSpinBtnIVAInscTopClick(Sender: TObject);
var
  iValor: double;

begin
    try
      iValor := StrToFloat (DCEEdtIVAIns.Text);
      if iValor < MAXIMO_NUMERO_IVA then
         fVarios.ValueByName[FIELD_IVAINSCR] := Format('%1.2f',[iValor + 1])
    except
        on E:Exception do
           fVarios.ValueByName[FIELD_IVAINSCR] := IntToStr(MAXIMO_NUMERO_IVA)
    end;
end;

procedure TfrmVariableDataBills.RxSpinBtnIVANoInsBottomClick(Sender: TObject);
var
  iValor: double;

begin
    try
      iValor := StrToFloat (DCEEdtIVANoIns.Text);
      if iValor > MINIMO_NUMERICO then
         fVarios.ValueByName[FIELD_IVANOINS] := Format('%1.2f',[iValor - 1])
    except
        on E:Exception do
           fVarios.ValueByName[FIELD_IVANOINS] := IntToStr(MINIMO_NUMERICO)
    end;
end;

procedure TfrmVariableDataBills.RxSpinBtnIVANoInsTopClick(Sender: TObject);
var
  iValor: double;

begin
    try
      iValor := StrToFloat (DCEEdtIVANoIns.Text);
      if iValor < MAXIMO_NUMERO_IVA then
         fVarios.ValueByName[FIELD_IVANOINS] := Format ('%1.2f',[iValor + 1])
    except
        on E:Exception do
           fVarios.ValueByName[FIELD_IVANOINS] := IntToStr(MAXIMO_NUMERO_IVA)
    end;
end;

procedure TfrmVariableDataBills.RxSpinBtnCanonBottomClick(Sender: TObject);
var
  iValor: double;

begin
    try
      iValor := StrToFloat (DCEEdtCanon.Text);
      if iValor > MINIMO_NUMERICO then
         fVarios.ValueByName[FIELD_CANON] := Format('%1.2f',[iValor - 1])
    except
        on E:Exception do
           fVarios.ValueByName[FIELD_CANON] := IntToStr(MINIMO_NUMERICO)
    end;
end;

procedure TfrmVariableDataBills.RxSpinBtnCanonTopClick(Sender: TObject);
var
  iValor: double;

begin
    try
      iValor := StrToFloat (DCEEdtCanon.Text);
      if iValor < MAXIMO_NUMERO_CANON then
         fVarios.ValueByName[FIELD_CANON] := Format ('%1.2f',[iValor + 1])
    except
        on E:Exception do
           fVarios.ValueByName[FIELD_CANON] := IntToStr(MAXIMO_NUMERO_CANON)
    end;
end;



procedure TfrmVariableDataBills.RxSBPIBBottomClick(Sender: TObject);
var
  iValor: double;
begin
    try
      iValor := StrToFloat (CEIIBB.Text);
      if iValor > MINIMO_IIBB then
         fVarios.ValueByName[FIELD_IIBB] := Format('%1.2f',[iValor - 1])
    except
        on E:Exception do
           fVarios.ValueByName[FIELD_IIBB] := IntToStr(MINIMO_IIBB)
    end;
end;

procedure TfrmVariableDataBills.RxSBPIBTopClick(Sender: TObject);
var
  iValor: double;
begin
    try
      iValor := StrToFloat (CEIIBB.Text);
      if iValor < MAXIMO_NUMERO_IIBB then
         fVarios.ValueByName[FIELD_IIBB] := Format ('%1.2f',[iValor + 1])
    except
        on E:Exception do
           fVarios.ValueByName[FIELD_IIBB] := IntToStr(MAXIMO_NUMERO_IIBB)
    end;
end;

procedure TfrmVariableDataBills.RxSBIMPIIBBBottomClick(Sender: TObject);
var
  iValor: double;

begin
    try
      iValor := StrToFloat (CEIMP_IIBB.Text);
      if iValor > MINIMO_IIBB then
         fVarios.ValueByName[FIELD_IMP_IIBB] := Format('%1.2f',[iValor - 1])
    except
        on E:Exception do
           fVarios.ValueByName[FIELD_IMP_IIBB] := IntToStr(MINIMO_IIBB)
    end;

end;

procedure TfrmVariableDataBills.RxSBIMPIIBBTopClick(Sender: TObject);
var
  iValor: double;

begin
    try
      iValor := StrToFloat (CEIMP_IIBB.Text);
      if iValor < MAXIMO_NUMERO_CANON then
         fVarios.ValueByName[FIELD_IMP_IIBB] := Format ('%1.2f',[iValor + 1])
    except
        on E:Exception do
           fVarios.ValueByName[FIELD_IMP_IIBB] := IntToStr(MAXIMO_NUMERO_CANON)
    end;
end;

end.
