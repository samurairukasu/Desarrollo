unit ufDatosEquipoGNC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uSagClasses, StdCtrls, Buttons, globals, uSagEstacion, Db, Mask, DBCtrls,
  ToolEdit, RXDBCtrl, DBCGrids, ExtCtrls, Grids, DBGrids,
  MemTable, RXLookup, UCEdit, UCDIALGS, UCDBEdit, uUtils, shellapi,
  DBClient, RxMemDS;

type
  TFrmDatosEquiposGNC = class(TForm)
    BContinuar: TBitBtn;
    BCancelar: TBitBtn;
    srcCilindroEG: TDataSource;
    dbeCilCantidad: TDBEdit;
    srcReguladorEG: TDataSource;
    srcMtCilindros: TDataSource;
    grCilindros: TDBGrid;
    btnCilEliminar: TBitBtn;
    btnCilAgregar: TBitBtn;
    Panel15: TPanel;
    Bevel1: TBevel;
    Label22: TLabel;
    Bevel5: TBevel;
    Label13: TLabel;
    Label1: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel4: TBevel;
    Bevel6: TBevel;
    Label4: TLabel;
    btnNueRegulador: TBitBtn;
    btnNueCilindro: TBitBtn;
    dbcbRegulador: TRxDBLookupCombo;
    Label5: TLabel;
    Label6: TLabel;
    edNuevo: TColorEdit;
    dbcbCilindro: TRxDBLookupCombo;
    edVencimiento: TColorEdit;
    Label7: TLabel;
    Label8: TLabel;
    srcEquiGNC: TDataSource;
    edRegNroSerie: TColorEdit;
    edCilNroSerie: TColorEdit;
    srcInspGNC: TDataSource;
    edObleaAnt: TColorDBEdit;
    Bevel7: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    CBTipoOperacion: TComboBox;
    Panel1: TPanel;
    btnsic: TButton;
    mtFCilindros: TRxMemoryData;
    mtFCilindrosCODCILINDRO: TIntegerField;
    mtFCilindrosCODCILENARGAS: TStringField;
    mtFCilindrosIDCILINDRO: TIntegerField;
    mtFCilindrosNROSERIE: TStringField;
    mtFCilindrosCODVALENARGAS: TStringField;
    mtFCilindrosNROSERIEVALV: TStringField;
    procedure FormShow(Sender: TObject);
    procedure BContinuarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure grCilindrosCellClick(Column: TColumn);
    procedure dbcbReguladorChange(Sender: TObject);
    procedure edRegNroSerieChange(Sender: TObject);
    procedure btnNueReguladorClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCilEliminarClick(Sender: TObject);
    procedure dbcbCilindroChange(Sender: TObject);
    procedure edCilNroSerieChange(Sender: TObject);
    procedure btnNueCilindroClick(Sender: TObject);
    procedure btnCilAgregarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edRegNroSerieExit(Sender: TObject);
    procedure edCilNroSerieExit(Sender: TObject);
    procedure CBTipoOperacionChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbcbReguladorCloseUp(Sender: TObject);
    procedure dbcbCilindroCloseUp(Sender: TObject);
    procedure btnsicClick(Sender: TObject);
    procedure edRegNroSerieKeyPress(Sender: TObject; var Key: Char);
    procedure edObleaAntKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    fInspGNC : TInspGNC;
    fEquipoGNC : TEquiposGNC;
    fCilindro, fActualCilindro : TCilindros;
    fCilindroEnargas : TCilindrosEnargas;
    fReguladorEnargas : TReguladoresEnargas;
    fVehiculo : TVehiculo;
    fEqui_Cilindro : TequiGNC_Cilindro;
    fRegulador, fActualRegulador : TReguladores;
    vTipoForm : char;
    procedure CompletarDatosCilindro;
    procedure CompletarDatosRegulador;
    procedure MostrarDatos_Regulador (var aRegulador: TReguladores; sRegulador, sNroserie: string);
    procedure MostrarDatos_cilindro (var aCilindro : TCilindros; sCilindro, sNroserie : string);
    procedure AsignarEquipo;
    function GetCilindrosActual: tCilindros;
    function DatosCompletos:boolean;
    function ModificoCilindro( aCilindro, aCilindro_old : TCilindros ): boolean;
  public
    { Public declarations }
    constructor CreateFromBD (const aInspGNC: TInspGNC; const aVehiculo: TVehiculo; aTipo : char);
    function Execute: boolean;

  end;

var
  FrmDatosEquiposGNC: TFrmDatosEquiposGNC;

implementation

{$R *.DFM}
uses
  ufMantReguladores, ufMantCilindros, ULOGS;

resourcestring
        FILE_NAME = 'ufDatosEquipoGNC.PAS';

constructor TFrmDatosEquiposGNC.CreateFromBD (const aInspGNC: TInspGNC; const aVehiculo: TVehiculo; aTipo : char);
begin
    inherited Create(Application);
    fInspGNC := aInspGNC;
    fInspGNC.open;
    //
    fVehiculo := tvehiculo.CreateFromDataBase(MyBD,DATOS_VEHICULOS,FORMAT('WHERE CODVEHIC = %s',[aVehiculo.ValueByName[FIELD_CODVEHIC]]));
    //
    fVehiculo.Open;
    fEquipoGNC := nil;
    fCilindro := nil;
    fCilindroEnargas := nil;
    fReguladorEnargas := nil;
    fEqui_Cilindro := nil;
    fRegulador := nil;
    fActualRegulador := nil;
    fActualCilindro := nil;
    vTipoForm := aTipo;
    if aTipo = E_MODIFICADO then
    begin
      activarcomponentes(false,self,[1]);
      grCilindros.TabStop := false;
    end;
    btnsic.visible := aTipo = E_PENDIENTE_SIC;
end;

function TFrmDatosEquiposGNC.Execute: boolean;
begin
    try
        result := FALSE;
        if ShowModal = mrOk
        then begin
            result := TRUE;
        end;
    except
        result := FALSE;
    end;
end;

procedure TFrmDatosEquiposGNC.FormShow(Sender: TObject);
begin
  fReguladorEnargas := TReguladoresEnargas.Create(MyBD);
  fReguladorEnargas.open;
  srcReguladorEG.dataset := fReguladorEnargas.DataSet;

  fCilindroEnargas := TCilindrosEnargas.Create(mybd);
  fCilindroEnargas.open;
  srcCilindroEG.DataSet := fCilindroEnargas.DataSet;

  if fVehiculo.valuebyname[FIELD_CODEQUIGNC] <> '' then
    fEquipoGNC := TEquiposGNC.CreateByCodequi(mybd,fVehiculo.valuebyname[FIELD_CODEQUIGNC])
  else
    fEquipoGNC := TEquiposGNC.CreateByRowId(mybd,'');
  fEquipoGNC.open;
  srcEquiGNC.DataSet := fEquipoGNC.DataSet;
  if fEquipoGNC.RecordCount > 0 then
  begin
    fEqui_Cilindro := fEquipoGNC.GetCilindro;
    fRegulador := fEquipoGNC.GetRegulador;
    fRegulador.Open;
    if fRegulador.RecordCount > 0 then
      fActualRegulador := TReguladores.CreateByCopy(fRegulador)
    else

      fActualRegulador := TReguladores.CreateByRowId(mybd,'');
  end
  else
  begin
    fEqui_Cilindro := TequiGNC_Cilindro.CreateByRowId(mybd,'');
    fRegulador := TReguladores.CreateByRowId(mybd,'');
    fActualRegulador := TReguladores.CreateByRowId(mybd,'');
  end;
  fEqui_Cilindro.open;
  fCilindro := fEqui_Cilindro.GetCilindros;
  fCilindro.open;
  mtFCilindros.open;
  CompletarDatosCilindro;

  fRegulador.Open;
  CompletarDatosRegulador;

  srcInspGNC.DataSet := fInspGNC.DataSet;
  CBTipoOperacion.ItemIndex := 0;  
end;


procedure TFrmDatosEquiposGNC.BContinuarClick(Sender: TObject);
begin
  try
    if DatosCompletos then
    begin
      fInspGNC.ValueByName[FIELD_TIPOOPERACION] := TTO_SAG_TO_DB[tTipoOperacionGNC(CBTipoOperacion.ItemIndex)];
      AsignarEquipo;
      ModalResult := mrOk;
    end
    else
      exit;
  except
     on E: Exception do
     begin
                MessageDlg(Caption,Format('Error al intentar grabar los datos del equipo GNC: %s. ',[E.message]), mtInformation, [mbOk],mbOk,0);
                fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error al intentar grabar los datos del equipo GNC: %s',[E.message]);
     end
  end;
end;

procedure TFrmDatosEquiposGNC.BCancelarClick(Sender: TObject);
begin
   ModalResult := mrCancel;
end;

procedure TFrmDatosEquiposGNC.CompletarDatosCilindro;
begin
  with fcilindro do
  begin
    open;
    first;
    while not eof do
    begin
      mtFCilindros.Append;
      mtFCilindrosCODCILINDRO.value := strtoInt(valueByName[FIELD_CODCILINDRO]);
      mtFCilindrosCODCILENARGAS.Value := GetCodEnargas;
      mtFCilindrosIDCILINDRO.Value := StrToInt(ValueByName[FIELD_IDCILINDRO]);
      mtFCilindrosNROSERIE.Value := ValueByName[FIELD_NROSERIE];
      mtFCilindrosCODVALENARGAS.Value := getcodvalvEnargas;
      mtFCilindrosNROSERIEVALV.Value := ValueByName[FIELD_NROSERIEVALV];
      next;
    end;
    if mtFCilindros.State in [dsInsert,dsEdit] then mtFCilindros.Post;
  end;
end;

procedure TFrmDatosEquiposGNC.CompletarDatosRegulador;
begin
  dbcbRegulador.value := fRegulador.ValueByName[FIELD_IDREGULADOR];
  edRegNroSerie.Text := fRegulador.ValueByName[FIELD_NROSERIE];
end;

procedure TFrmDatosEquiposGNC.grCilindrosCellClick(Column: TColumn);
begin
  dbcbCilindro.Value := mtFCilindrosIDCILINDRO.asstring;
  edCilNroSerie.text := mtFCilindrosNROSERIE.Value;
end;


procedure TFrmDatosEquiposGNC.dbcbReguladorChange(Sender: TObject);
begin
  edRegNroSerie.Clear;
end;

procedure TFrmDatosEquiposGNC.edRegNroSerieChange(Sender: TObject);
begin
        edNuevo.Text := '';
        if ((Length((SEnder as TEdit).Text) > 0) and (dbcbRegulador.text<>''))
        then begin
                try
                        if assigned(fActualRegulador) then fActualRegulador.Free;
                        fActualRegulador := nil;
                        fActualRegulador := TReguladores.CreateByIDRegSerie(MyBD,dbcbRegulador.value,edRegNroSerie.text);
                        fActualRegulador.Open;
                        if vTipoForm <> E_MODIFICADO then
                          btnNueRegulador.Enabled := TRUE;
                        if (fActualRegulador.RecordCount <> 0) then
                        begin
                            dbcbRegulador.value := fActualRegulador.ValueByName[FIELD_IDREGULADOR];
                            edRegNroSerie.Text := fActualRegulador.ValueByName[FIELD_NROSERIE];
                            edNuevo.Text := fActualRegulador.ValueByName[FIELD_NUEVOREG];
                        end;
                except
                    on E: Exception do
                        MessageDlg('Identificación del Regulador',Format('Esta fallando la introducción de datos del regulador por: %s. Compruebe que los datos introducidos son correctos. Si el error persiste indíquelo al Depto. de Sistemas.',[E.message]), mtInformation, [mbOk], mbOk, 0)
                end
        end
        else btnNueRegulador.Enabled := FALSE

end;

procedure TFrmDatosEquiposGNC.MostrarDatos_Regulador (var aRegulador: TReguladores; sRegulador, sNroserie: string);
var
        EditRegulador: TfrmMantReguladores;
        aRegulador_Auxi, aRegulador_auxi_old : TReguladores;
        aLogsReg : TLogRegulador;
begin
  if (not assigned(aRegulador)) Then Exit;
     try
        aRegulador_Auxi := TReguladores.CreateByCopy (aRegulador);
        aRegulador_Auxi_old := TReguladores.CreateByCopy (aRegulador);
        aRegulador_auxi_old.open;
//        aRegulador_Auxi.DataSet.CachedUpdates := true;
        try
           aRegulador_Auxi.Open;
           If aRegulador_Auxi.IsNew
           Then begin
               aRegulador_Auxi.Append;
               aRegulador_Auxi.ValueByName[FIELD_IDREGULADOR] := sRegulador;
               aRegulador_Auxi.ValueByName[FIELD_NROSERIE] := sNroserie;
           end
           else begin
               If not aRegulador_Auxi.Edit
               then begin
                   fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FILE_NAME,'Falló la puesta en edicion de la tabla de reguladores');
                   Raise Exception.Create('La Tabla no pudo ser editada');
               end
               else
               begin
                    if vTipoForm <> TIPO_NEW then
                    begin
                      aLogsReg := TLogRegulador.CreateByRowId(mybd,'');
                      with aLogsReg do
                      begin
                        Open;
                        Edit;
                        ValueByName[FIELD_EJERCICI] := fInspGNC.ValueByName[FIELD_EJERCICI];
                        ValueByName[FIELD_CODINSPGNC] := fInspGNC.ValueByName[FIELD_CODINSPGNC];
                        ValueByName[FIELD_CODREGULADOR] := aRegulador_Auxi.ValueByName[FIELD_CODREGULADOR];
                        ValueByName[FIELD_NROSERIE] := aRegulador_Auxi.ValueByName[FIELD_NROSERIE];
                        ValueByName[FIELD_NUEVOREG] := aRegulador_Auxi.ValueByName[FIELD_NUEVOREG];
                      end;
                    end;
               end;
           end;

           EditRegulador:= TfrmMantReguladores.CreateFromRegulador(Application,aRegulador_Auxi, vTipoForm);
           try
               if (EditRegulador.ShowModal = mrOk) then
               begin
                   if assigned (aLogsReg) then
                     if aRegulador_auxi.DataSet.FieldByName(FIELD_NROSERIE).value <> aRegulador_auxi_old.DataSet.FieldByName(FIELD_NROSERIE).value then
                        aLogsReg.post(true)
                     else
                        aLogsReg.Cancel;
//                   aRegulador_Auxi.DataSet.ApplyUpdates;
                   aRegulador.Free;
                   aRegulador := TReguladores.CreateByCodRegulador (mybd, aRegulador_Auxi.ValueByName[FIELD_CODREGULADOR]);
                   aRegulador.Open;
               end
               else if assigned (aLogsReg) then aLogsReg.cancel;
           finally
               EditRegulador.Free;
           end;
        finally
             aRegulador_Auxi.Free;
             aRegulador_Auxi_old.Free;             

        end;
     finally
            if assigned (aLogsReg) then aLogsReg.Free;
     end;

end;

procedure TFrmDatosEquiposGNC.MostrarDatos_cilindro (var aCilindro : TCilindros; sCilindro, sNroserie : string);
var
        EditCilindro: TfrmMantCilindros;
        aCilindro_Auxi: TCilindros;
        aCilindro_auxi_old: tcilindros;
        aLogsCil : TLogCilindro;
begin
  if (not assigned(aCilindro)) Then Exit;
    try
        aLogsCil := nil;
        aCilindro_Auxi := TCilindros.CreateByCopy (aCilindro);
        aCilindro_auxi_old := TCilindros.CreateByCopy (aCilindro);
        aCilindro_auxi_old.open;
//        aCilindro_Auxi.DataSet.CachedUpdates := true;
        try
           aCilindro_Auxi.Open;
           If aCilindro_Auxi.IsNew
           Then begin
               aCilindro_Auxi.Append;
               aCilindro_Auxi.ValueByName[FIELD_IDCILINDRO] := sCilindro;
               aCilindro_Auxi.ValueByName[FIELD_NROSERIE] := sNroserie;
           end
           else begin
               If not aCilindro_Auxi.Edit
               then begin
                   fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FILE_NAME,'Falló la puesta en edicion de la tabla de reguladores');
                   Raise Exception.Create('La Tabla no pudo ser editada');
               end
               else
               begin
                  if vTipoForm <> TIPO_NEW then
                  begin
                    aLogsCil := TLogCilindro.CreateByRowId(mybd,'');
                    with aLogsCil do
                    begin
                      Open;
                      Edit;
                      ValueByName[FIELD_EJERCICI] := fInspGNC.ValueByName[FIELD_EJERCICI];
                      ValueByName[FIELD_CODINSPGNC] := fInspGNC.ValueByName[FIELD_CODINSPGNC];
                      ValueByName[FIELD_CODCILINDRO] := aCilindro_Auxi.ValueByName[FIELD_CODCILINDRO];
                      ValueByName[FIELD_NROSERIE] := aCilindro_Auxi.ValueByName[FIELD_NROSERIE];
                      ValueByName[FIELD_NUEVO] := aCilindro_Auxi.ValueByName[FIELD_NUEVO];
                      ValueByName[FIELD_FECHFABRI] := aCilindro_Auxi.ValueByName[FIELD_FECHFABRI];
                      ValueByName[FIELD_FECHREVI] := aCilindro_Auxi.ValueByName[FIELD_FECHREVI];
                      ValueByName[FIELD_FECHVENC] := aCilindro_Auxi.ValueByName[FIELD_FECHVENC];
                      ValueByName[FIELD_NROSERIEVALV] := aCilindro_Auxi.ValueByName[FIELD_NROSERIEVALV];
                      ValueByName[FIELD_IDCRPC] := aCilindro_Auxi.ValueByName[FIELD_IDCRPC];
                    end;
                  end;
               end;
           end;

           EditCilindro:= TfrmMantCilindros.CreateFromCilindro(Application,aCilindro_Auxi,vTipoForm);
           try
               if (EditCilindro.ShowModal = mrOk) then
               begin
                   if assigned(aLogsCil) then
                     if ModificoCilindro(aCilindro_auxi, aCilindro_auxi_old) then
                     begin
                       aLogsCil.post(true);
                     end
                     else aLogsCil.cancel;
//                   aCilindro_auxi.DataSet.ApplyUpdates;
                   aCilindro.Free;
                   aCilindro := TCilindros.CreateByCodCilindro (mybd,aCilindro_auxi.valuebyname[FIELD_CODCILINDRO] );
                   aCilindro.Open;
               end
               else if assigned(aLogsCil) then aLogsCil.cancel;
           finally
               EditCilindro.Free;
           end;
        finally
             aCilindro_Auxi.Free;
             aCilindro_auxi_old.free;
        end;
    finally
          if assigned (aLogsCil) then aLogsCil.Free;
    end;

end;



procedure TFrmDatosEquiposGNC.btnNueReguladorClick(Sender: TObject);
begin
    MostrarDatos_Regulador (fActualRegulador, dbcbRegulador.Value, edRegNroSerie.Text);
    if Assigned(fActualRegulador)
    then
    begin
      dbcbRegulador.value := fActualRegulador.ValueByName[FIELD_IDREGULADOR];
      edRegNroSerie.text := fActualRegulador.ValueByName[FIELD_NROSERIE];
      edNuevo.Text := fActualRegulador.ValueByName[FIELD_NUEVOREG];
    end;
end;

procedure TFrmDatosEquiposGNC.FormDestroy(Sender: TObject);
begin
    fEquipoGNC.free;
    fCilindro.free;
    fCilindroEnargas.free;
    fReguladorEnargas.free;
    fEqui_Cilindro.free;
    fRegulador.free;
    fActualRegulador.free;
    fActualCilindro.free;
//    fIncidencias.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'sale udDatosEquiposGNC '+inttostr(cursores));
end;

procedure TFrmDatosEquiposGNC.btnCilEliminarClick(Sender: TObject);
begin
  if Application.MessageBox('¿Desea eliminar este cilindro del equipo?','Eliminar Cilindro',mb_yesno+mb_defbutton1+mb_iconquestion+mb_applmodal) = 6 then
  begin
    mtFCilindros.delete;
    dbcbCilindro.ClearValue;
    dbcbCilindroChange(dbcbCilindro);
  end;

end;


procedure TFrmDatosEquiposGNC.dbcbCilindroChange(Sender: TObject);
begin
  edCilNroSerie.Clear;
end;


procedure TFrmDatosEquiposGNC.edCilNroSerieChange(Sender: TObject);
begin
        edVencimiento.Text := '';
        if ((Length((SEnder as TEdit).Text) > 0) and (dbcbCilindro.text<>''))
        then begin
                try
                        if assigned(fActualCilindro) then fActualCilindro.Free;
                        fActualCilindro := nil;
                        fActualCilindro := TCilindros.CreateByIDCilSerie(MyBD,dbcbCilindro.value,edCilNroSerie.text);
                        fActualCilindro.Open;
                        btnNueCilindro.Enabled := TRUE;
                        if (fActualCilindro.RecordCount <> 0) then
                        begin
                            dbcbCilindro.value := fActualCilindro.ValueByName[FIELD_IDCILINDRO];
                            edCilNroSerie.Text := fActualCilindro.ValueByName[FIELD_NROSERIE];
                            edVencimiento.Text := fActualCilindro.ValueByName[FIELD_FECHVENC];
                        end;
                except
                    on E: Exception do
                        MessageDlg('Identificación del Cilindro',Format('Esta fallando la introducción de datos del cilindro por: %s. Compruebe que los datos introducidos son correctos.',[E.message]), mtInformation, [mbOk], mbOk, 0)
                end
        end
        else btnNueCilindro.Enabled := FALSE
end;

procedure TFrmDatosEquiposGNC.btnNueCilindroClick(Sender: TObject);
begin
  try
    MostrarDatos_Cilindro (fActualCilindro, dbcbCilindro.Value, edCilNroSerie.Text);
    if Assigned(fActualCilindro)
    then
    begin
      if fActualCilindro.RecordCount > 0 then
      begin
        if mtFCilindros.Locate(FIELD_CODCILINDRO,fActualCilindro.ValueByName[FIELD_CODCILINDRO],[]) then
        begin
          mtFCilindros.Edit;
          mtFCilindrosCODCILENARGAS.Value := fActualCilindro.GetCodEnargas;
          mtFCilindrosIDCILINDRO.asstring := fActualCilindro.valuebyname[FIELD_IDCILINDRO];
          mtFCilindrosNROSERIE.Value := fActualCilindro.ValueByName[FIELD_NROSERIE];
          mtFCilindrosNROSERIEVALV.Value := fActualCilindro.ValueByName[FIELD_NROSERIEVALV];
          mtFCilindrosCODVALENARGAS.Value := fActualCilindro.getcodvalvEnargas;
          mtFCilindros.post;
        end;
        dbcbCilindro.value := fActualCilindro.ValueByName[FIELD_IDCILINDRO];
        edCilNroSerie.text := fActualCilindro.ValueByName[FIELD_NROSERIE];
        edVencimiento.Text := fActualCilindro.ValueByName[FIELD_FECHVENC];
      end;
    end;
  except
     on E: Exception do
     begin
                MessageDlg(Caption,Format('Error al intentar agregar el cilindro: %s. ',[E.message]), mtInformation, [mbOk],mbOk,0);
                fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error al intentar agregar el cilindro: %s'+' '+inttostr(cursores)+' '+inttostr(maxcursores),[E.message]);
     end
  end;

end;

procedure TFrmDatosEquiposGNC.btnCilAgregarClick(Sender: TObject);
begin
  try
      if assigned(fActualCilindro) then
        if fActualCilindro.RecordCount <> 0 then
        begin
          if not (mtFCilindros.Locate(FIELD_CODCILINDRO,fActualCilindro.ValueByName[FIELD_CODCILINDRO],[])) then
          begin
            mtFCilindros.append;
            mtFCilindrosCODCILINDRO.asstring := fActualCilindro.valuebyname[FIELD_CODCILINDRO];
            mtFCilindrosCODCILENARGAS.Value := fActualCilindro.GetCodEnargas;
            mtFCilindrosIDCILINDRO.asstring := fActualCilindro.valuebyname[FIELD_IDCILINDRO];
            mtFCilindrosNROSERIE.Value := fActualCilindro.ValueByName[FIELD_NROSERIE];
            mtFCilindrosNROSERIEVALV.Value := fActualCilindro.ValueByName[FIELD_NROSERIEVALV];
            mtFCilindrosCODVALENARGAS.Value := fActualCilindro.getcodvalvEnargas;
            mtFCilindros.post;
          end;
        end
        else
          application.MessageBox('Los datos del cilindro no están completos','Agregar Cilindros',mb_ok+mb_iconexclamation);
      Perform(WM_NEXTDLGCTL,0,0);
    except
     on E: Exception do
     begin
                MessageDlg(Caption,Format('Error al intentar agregar el cilindro: %s. ',[E.message]), mtInformation, [mbOk],mbOk,0);
                fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error al intentar agregar el cilindro: %s'+' '+inttostr(cursores)+' '+inttostr(maxcursores),[E.message]);
     end
  end;
end;

procedure TFrmDatosEquiposGNC.FormKeyPress(Sender: TObject; var Key: Char);
begin
        if key = ^M
        then begin
            Perform(WM_NEXTDLGCTL,0,0);
            Key := #0
        end
end;

function TFrmDatosEquiposGNC.GetCilindrosActual : TCilindros;
var
  codigos : string;
begin
  with mtFCilindros do
  begin
    first;
    codigos := '';
    while not eof do
    begin
      if codigos = '' then codigos := FieldByName(FIELD_CODCILINDRO).asstring
      else
        codigos := codigos +','+FieldByName(FIELD_CODCILINDRO).asstring;
      next;
    end;
    if codigos <> '' then
      result := tCilindros.CreateByConCodigos(MyBD,codigos)
    else
      result := tCilindros.CreateByRowId(MyBD,'');
  end;
end;

procedure TFrmDatosEquiposGNC.AsignarEquipo;
begin
  if (fActualCilindro.RecordCount > 0) or (fActualRegulador.RecordCount > 0) then
  begin
    fEquipoGNC.SetEquipo(fEquipoGNC, fRegulador, fActualRegulador, fCilindro, fActualCilindro, fEqui_Cilindro);
    fEquipoGNC.Open;
    fEquipoGNC.Refresh;
    fEquipoGNC.edit;
    fEquipoGNC.ValueByName[FIELD_CANTCILINDROS] := inttoStr(fActualCilindro.recordcount);
    fVehiculo.Edit;
    fVehiculo.ValueByName[FIELD_CODEQUIGNC] := fEquipoGNC.ValueByName[FIELD_CODEQUIGNC];
    with fInspGNC do
    begin
      fEquipoGNC.open;
      open;
      ValueByName[FIELD_CODEQUIGNC] := fEquipoGNC.ValueByName[FIELD_CODEQUIGNC];
      post(true);
    end;
    fEquipoGNC.Post(true);
    fVehiculo.Post(true);
  end
  else
  begin
    fEquipoGNC.Cancel;
    fInspGNC.post(true);
    fVehiculo.Edit;
    fVehiculo.ValueByName[FIELD_CODEQUIGNC] := '';
    fVehiculo.Post(true);
  end;
end;

procedure TFrmDatosEquiposGNC.edRegNroSerieExit(Sender: TObject);
begin
        If ((fActualRegulador=nil) or ((fActualRegulador.active) and (fActualRegulador.IsNew))) then btnNueReguladorClick(btnNueRegulador);
end;

procedure TFrmDatosEquiposGNC.edCilNroSerieExit(Sender: TObject);
begin
        If ((fActualCilindro=nil) or (fActualCilindro.IsNew)) then btnNueCilindroClick(btnNueCilindro);
end;

procedure TFrmDatosEquiposGNC.CBTipoOperacionChange(Sender: TObject);
begin
        if CBTipoOperacion.ItemIndex <> -1
        then begin
            fInspGNC.ValueByName[FIELD_TIPOOPERACION] := TTO_SAG_TO_DB[tTipoOperacionGNC(CBTipoOperacion.ItemIndex)];
        end;
end;

procedure TFrmDatosEquiposGNC.FormCreate(Sender: TObject);
begin
//   fIncidencias.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'entra udDatosEquiposGNC '+inttostr(cursores));
   CBTipoOperacion.ItemIndex := -1;
end;

procedure TFrmDatosEquiposGNC.dbcbReguladorCloseUp(Sender: TObject);
begin
        dbcbRegulador.Value := fReguladorEnargas.ValueByName[dbcbRegulador.LookUpField];
        dbcbReguladorChange(Sender);
end;

procedure TFrmDatosEquiposGNC.dbcbCilindroCloseUp(Sender: TObject);
begin
        dbcbCilindro.Value := fCilindroEnargas.ValueByName[dbcbCilindro.LookUpField];
        dbcbCilindroChange(Sender);
end;

function TFrmDatosEquiposGNC.DatosCompletos:boolean;
var scilindro: string;
begin
  result := false;
  if assigned (fActualCilindro) then fActualCilindro.Close;
  fActualCilindro := GetCilindrosActual;
  fActualCilindro.open;
  fActualRegulador.Open;
  if (not (fActualRegulador.RecordCount > 0)) or (edNuevo.Text = ''
  ) then
  begin
    MessageDlg (Application.Title, 'El equipo debe contener un regulador', mtInformation, [mbOk],mbOk,0);
    dbcbRegulador.SetFocus;
    exit;
  end;
  if not (fActualCilindro.RecordCount > 0) then
  begin
    scilindro := dbcbCilindro.text+' '+edCilNroSerie.text;
    if (edVencimiento.text <> '') and (application.messagebox(pchar('No se asignó ningún cilindro al equipo, ¿desea agregar el cilindro '+scilindro+' ? '),pchar(Application.Title), mb_yesno+mb_iconquestion+mb_defbutton1+mb_applmodal) = 6) then
    begin
      edCilNroSerieChange(edCilNroSerie);
      btnCilAgregarClick(btnCIlAgregar);
    end
    else
    begin
      MessageDlg (Application.Title, 'El equipo debe contener un cilindro', mtInformation, [mbOk],mbOk,0);
      dbcbRegulador.SetFocus;
      dbcbCilindro.ClearValue;
      dbcbCilindroChange(dbcbCilindro);
      dbcbCilindro.SetFocus;
      exit;
    end;
  end;
  if CBTipoOperacion.Text = '' then
  begin
    MessageDlg (Application.Title, 'Introduzca un Tipo de Operación correcto', mtInformation, [mbOk],mbOk,0);
    CBTipoOperacion.SetFocus;
    exit;
  end;
  if edObleaAnt.Text = '' then
  begin
    MessageDlg (Application.Title, 'Introduzca el nro de oblea anterior', mtInformation, [mbOk],mbOk,0);
    edObleaAnt.SetFocus;
    exit;
  end;
  if edObleaAnt.Text <> '' then
    try
      StrToInt(edObleaAnt.text)
    except
      MessageDlg (Application.Title, 'El nro de oblea anterior no es correcto', mtInformation, [mbOk],mbOk,0);
      edObleaAnt.SetFocus;
      exit;
    end;

  result := true;
end;

function TFrmDatosEquiposGNC.ModificoCilindro( aCilindro, aCilindro_old : TCilindros ): boolean;
var
  ii:integer;
begin
        result := false;
        For ii:=1 To aCilindro.dataset.FieldCount-1 do
        begin
            if aCilindro.dataset.Fields[ii].Value <> aCilindro_old.dataset.Fields[ii].Value then
              result := true;
        end;

end;

procedure TFrmDatosEquiposGNC.btnsicClick(Sender: TObject);
begin
        ShellExecute(0,nil,'IEXPLORE.EXE','http://200.47.72.34/Intranet/GNC/RIC/',nil,SW_SHOW);
end;

procedure TFrmDatosEquiposGNC.edRegNroSerieKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #39
        then Key := #0
end;

procedure TFrmDatosEquiposGNC.edObleaAntKeyPress(Sender: TObject;
  var Key: Char);
begin
        if not (Key in ['0','1','2','3','4','5','6','7','8','9',char(VK_BACK)])
        then key := #0;
end;

end.
