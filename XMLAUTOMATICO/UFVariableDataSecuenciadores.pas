unit UFVariableDataSecuenciadores;
{ Mantenimiento Datos Variables - Secuenciadores }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, UCEdit, Buttons, ExtCtrls, USagVarios, SQLExpr, USecuenciadores,
  Mask, DBCtrls, UCDBEdit, Db, Grids, DBGrids, DBClient, SimpleDS;

type
  TfrmSecuenciadores = class(TForm)
    BBAceptar: TBitBtn;
    BBCancelar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtFacturasA: TEdit;
    edtFacturasB: TEdit;
    edtNumeroInspeccion: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    DSourceTVarios: TDataSource;
    Label6: TLabel;
    edtNumeroInspeccionGNC: TEdit;
    edtObleaActualGNC: TColorDBEdit;
    edtObleaSiguienteGNC: TColorDBEdit;
    Label7: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    DBGObleas: TDBGrid;
    DSObleas: TDataSource;
    sdsObleas: TSimpleDataSet;
    Label8: TLabel;
    Bevel1: TBevel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtFacturasAKeyPress(Sender: TObject; var Key: Char);
    procedure edtFacturasAEnter(Sender: TObject);
    procedure edtFacturasAExit(Sender: TObject);
    procedure BBCancelarClick(Sender: TObject);
    procedure LevantarObleas;
  private
    { Private declarations }
    aSequence: TSecuenciadores;


    //Próximos valores de Facturas A, Facturas B, Nº Inspección, Nº Oblea Actual y Nº Oblea Siguiente
    iProximaFA_Inicial, iProximaFB_Inicial, iProximoNI_Inicial, iProximoNI_Inicial_GNC: integer;


    function ValoresForm_Correctos: boolean;
    procedure Inicializar_FrmMantenimientoSecuenciadores (aBD: TSQLConnection);
    procedure RellenarFrmDatos_Secuenciadores ({aVarios: TVarios; }iOblea,iObleaB,iNumInsp,iNumInspGNC: integer);
  public
    { Public declarations }
    bHuboError: boolean;

  end;

var
  frmSecuenciadores: TfrmSecuenciadores;


procedure Mantenimiento_ValoresAutomaticos (aForm: TForm);


implementation

{$R *.DFM}

uses
   UUTILS,
   ULOGS,
   UCDIALGS,
   GLOBALS,
   UINTERFAZUSUARIO,
   UFTMP;


resourcestring
      FICHERO_ACTUAL = 'UFVariableDataSecuenciadores.pas';
      CAPTION_MSJ_FORM = 'Valores automáticos de la aplicación';

      MSJ_FACT_INC = 'El número de facturas A es incorrecto. Por favor, compruebe que lo ha introducido correctamente.';
      MSJ_FACT_MAYOR = 'El número de facturas A deberá ser mayor o igual que el indicado.';
      MSJ_FACTB_INC = 'El número de facturas B es incorrecto. Por favor, compruebe que lo ha introducido correctamente.';
      MSJ_FACTB_MAYOR = 'El número de facturas B deberá ser mayor o igual que el indicado.';
      MSJ_INSP_INC = 'El número de inspección es incorrecto. Por favor, compruebe que lo ha introducido correctamente.';
      MSJ_INSP_MAYOR = 'El número de inspección deberá ser mayor o igual que el indicado.';
      MSJ_OBLEA_INC = 'El número de oblea del año en curso es incorrecto. Por favor, compruebe que lo ha introducido correctamente.';
      MSJ_INSP_INC_GNC = 'El número de inspección es incorrecto. Por favor, compruebe que lo ha introducido correctamente.';
      MSJ_INSP_MAYOR_GNC = 'El número de inspección deberá ser mayor o igual que el indicado.';
      MSJ_OBLEA_INC_GNC = 'El número de oblea del año en curso es incorrecto. Por favor, compruebe que lo ha introducido correctamente.';

      MSJ_APLIC_IMPR_PARADOS = 'Para poder modificar los datos deberá asegurarse que NO hay ningún programa SAG ESTACION ejecutándose y que todos los servidores de impresión están parados. ¿Desea continuar?';




procedure TfrmSecuenciadores.LevantarObleas;
Begin
  try
    sdsObleas.Connection:=MyBD;
    //sdsObleas.DataSet.CommandText:=('select min(numoblea) oblea, anio from tobleas where estado=''S'' group by anio');
    sdsObleas.DataSet.CommandText:=('select LPAD(min(numoblea),8,''0'') Oblea, count(numoblea) cantidad ,anio from tobleas where estado=''S'' group by anio');
    sdsObleas.Open;
  except
    MessageDlg(Caption,'En este momento no se puede realizar la consulta.'+#13+#10+'Aguarde unos minutos y vuelva a intentarlo.', mtError, [mbOK],mbOk, 0);
  end;
end;


procedure Mantenimiento_ValoresAutomaticos (aForm: TForm);
var
  frmSecuenciadores_Auxi: TfrmSecuenciadores;

begin
    aForm.Enabled := False;
    try
      if (MessageDlg ('Aviso',MSJ_APLIC_IMPR_PARADOS, mtInformation, [mbYes, mbNo], mbNo, 0) = mrYes) then
      begin
          frmSecuenciadores_Auxi := TfrmSecuenciadores.Create (Application);
          try
             if (not frmSecuenciadores_Auxi.bHuboError) then
                frmSecuenciadores_Auxi.ShowModal;

          finally
               frmSecuenciadores_Auxi.Free;
          end;
      end;
    finally
         aForm.Enabled := True;
         aForm.Show;
    end;
end;




procedure TfrmSecuenciadores.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TfrmSecuenciadores.BBAceptarClick(Sender: TObject);
var
  aTmp: TFTmp;

begin
     aTmp := TFTmp.Create (Application);
     Self.Enabled :=False;
     try
         aTmp.MuestraClock('Actualizando Datos','Actualizando los datos de valores automáticos');
         try
            if ValoresForm_Correctos then
            begin
                fVarios.Post(true);
                ModalResult := mrOk
            end;
         except
             on E:Exception do
             begin
                 fIncidencias.PonAnotacionFmt (TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Error al actualizar en la base de datos por: %s',[E.Message]);
                 MessageDlg (Caption,'Error actualizando el formulario de mantenimiento de valores automáticos. Compruebe que ha rellenado todos los datos y si el error persiste, indíquelo al Jefe de Planta.', mtInformation, [mbOk], mbOk, 0);
             end;
         end;
     finally
         aTmp.Free;
         Self.Enabled := True;
         Self.Show;
     end;
end;

function TfrmSecuenciadores.ValoresForm_Correctos: boolean;
begin
    Result := False;


    if (not Es_Numero(edtFacturasA.Text)) then
    begin
        MessageDlg (CAPTION_MSJ_FORM, MSJ_FACT_INC, mtError, [mbOk], mbOk, 0);
        edtFacturasA.Setfocus;
        exit;
    end;

    if (not Es_Numero(edtFacturasB.Text)) then
    begin
        MessageDlg (CAPTION_MSJ_FORM,MSJ_FACTB_INC, mtError, [mbOk], mbOk, 0);
        edtFacturasB.Setfocus;
        exit;
    end;


    if (not Es_Numero(edtNumeroInspeccion.Text)) then
    begin
        MessageDlg (CAPTION_MSJ_FORM,MSJ_INSP_INC, mtError, [mbOk], mbOk, 0);
        edtNumeroInspeccion.Setfocus;
        exit;
    end;

    if (not Es_Numero(edtNumeroInspeccionGNC.Text)) then
    begin
        MessageDlg (CAPTION_MSJ_FORM,MSJ_INSP_INC_GNC, mtError, [mbOk], mbOk, 0);
        edtNumeroInspeccionGNC.Setfocus;
        exit;
    end;

    if (StrToInt (edtNumeroInspeccion.Text) < iProximoNI_Inicial) then
    begin
        MessageDlg (CAPTION_MSJ_FORM,MSJ_INSP_MAYOR, mtError, [mbOk], mbOk, 0);
        edtNumeroInspeccion.Text := Format ('%d',[iProximoNI_Inicial]);
        edtNumeroInspeccion.Setfocus;
        exit;
    end;

    if (StrToInt (edtNumeroInspeccionGNC.Text) < iProximoNI_Inicial_GNC) then
    begin
        MessageDlg (CAPTION_MSJ_FORM,MSJ_INSP_MAYOR_GNC, mtError, [mbOk], mbOk, 0);
        edtNumeroInspecciongnc.Text := Format ('%d',[iProximoNI_Inicial_GNC]);
        edtNumeroInspecciongnc.Setfocus;
        exit;
    end;

    aSequence.CrearSecuenciador (SECUENCIADOR_FACTA,StrToInt(edtFacturasA.Text));
    aSequence.CrearSecuenciador (SECUENCIADOR_FACTB,StrToInt(edtFacturasB.Text));
    aSequence.CrearSecuenciador (SECUENCIADOR_INSP, StrToInt(edtNumeroInspeccion.Text));
    aSequence.CrearSecuenciador (SECUENCIADOR_INSP_GNC, StrToInt(edtNumeroInspeccionGNC.Text));


    Result := True;
end;

procedure TfrmSecuenciadores.FormDestroy(Sender: TObject);
begin
    if (aSequence <> nil) then
       aSequence.Destroy;

end;

procedure TfrmSecuenciadores.FormCreate(Sender: TObject);
begin
    bHuboError := True;
    aSequence := nil;
    Inicializar_FrmMantenimientoSecuenciadores (MyBD);

    try
      DSourceTVarios.Dataset := fVarios.Dataset;

      LevantarObleas;

      if (not fVarios.IsNew) then
      begin
          fVarios.Edit;
          bHuboError := False;
      end
      else
      begin
          MessageDlg(Caption,'Error inicializando el formulario de mantenimiento de datos de valores automáticos. Comience de nuevo y si el error persiste, indíquelo al Jefe de Planta.', mtInformation, [mbOk],mbOk,0);
          fIncidencias.PonAnotacion(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Error inicializando el formulario de mantenimiento de facturación por que no hay ningún registro en TVARIOS');
      end;
    except
        on E:Exception do
        begin
            MessageDlg(Caption,Format('Error inicializando el formulario de mantenimiento de datos de valores automáticos: %s. Comience de nuevo y si el error persiste, indíquelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk],mbOk,0);
            fIncidencias.PonAnotacionFmt(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'Error inicializando el formulario de mantenimiento de valores automáticos por :%s',[E.message]);
        end
    end;

end;

procedure TfrmSecuenciadores.Inicializar_FrmMantenimientoSecuenciadores (aBD: TSQLConnection);
begin
    aSequence := TSecuenciadores.Create (aBD);

    iProximaFA_Inicial := aSequence.GetValorSecuenciador_UserSequences (SECUENCIADOR_FACTA);
    iProximaFB_Inicial := aSequence.GetValorSecuenciador_UserSequences (SECUENCIADOR_FACTB);
    iProximoNI_Inicial := aSequence.GetValorSecuenciador_UserSequences (SECUENCIADOR_INSP);
    iProximoNI_Inicial_GNC := aSequence.GetValorSecuenciador_UserSequences (SECUENCIADOR_INSP_GNC);

    RellenarFrmDatos_Secuenciadores ({aVarios_Auxi,}iProximaFA_Inicial,iProximaFB_Inicial,iProximoNI_Inicial,iProximoNI_Inicial_GNC);
end;


procedure TfrmSecuenciadores.RellenarFrmDatos_Secuenciadores ({aVarios: TVarios; }iOblea,iObleaB,iNumInsp,iNumInspGNC: integer);
begin
    edtFacturasA.Text := Format ('%d',[iOblea]);
    edtFacturasB.Text := Format ('%d',[iObleaB]);
    edtNumeroInspeccion.Text := Format ('%d',[iNumInsp]);
    edtNumeroInspeccionGNC.Text := Format ('%d',[iNumInspGNC]);
end;

procedure TfrmSecuenciadores.edtFacturasAKeyPress(Sender: TObject;
  var Key: Char);
begin
    if (((Key < '0') or (Key > '9')) and (key <> #8)) then
       Key := #0;
end;

procedure TfrmSecuenciadores.edtFacturasAEnter(Sender: TObject);
begin
    DestacarControl (Sender, clGreen, clWhite,False);
end;

procedure TfrmSecuenciadores.edtFacturasAExit(Sender: TObject);
begin
    AtenuarControl(Sender, False);
end;

procedure TfrmSecuenciadores.BBCancelarClick(Sender: TObject);
var
  aTmp: TFTmp;

begin
     aTmp := TFTmp.Create (Application);
     Self.Enabled := False;
     try
         aTmp.MuestraClock('Cancelando Datos','Cancelando los datos de los valores automáticos');
         try
            fVarios.Cancel;
         except
             on E:Exception do
             begin
                 fIncidencias.PonAnotacionFmt (TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'Error al actualizar en la base de datos por: %s',[E.Message]);
                 raise Exception.Create ('Error actualizando el formulario de mantenimiento de datos de los valores automáticos. Compruebe que ha rellenado todos los datos y si el error persiste, indíquelo al Jefe de Planta.');
             end;
         end;
     finally
         aTmp.Free;
         Self.Enabled := True;
         Self.Show;
     end
end;

end.
