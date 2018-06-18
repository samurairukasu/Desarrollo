unit ufPagoConCheque;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, UCDialgs, uSagClasses,
  ExtCtrls, StdCtrls, Buttons, Db, Globals, USAGEstacion, ToolEdit,UInterfazUsuario,
  RXDBCtrl, Mask, DBCtrls, UCDBEdit, UCEdit, RxLookup, usagcuit, ufmantclientes,
  ulogs, Grids, DBGrids, UFInsertarSucursalBanco, UtilOracle, RxGIF, sqlexpr, provider, dbclient;

type
  TfrmPagoConCheque = class(TForm)
    BContinuar: TBitBtn;
    BCancelar: TBitBtn;
    Panel15: TPanel;
    Bevel1: TBevel;
    dsCheque: TDataSource;
    dbenrocheque: TDBEdit;
    dbefecven: TDBDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    CBMoneda: TRxDBLookupCombo;
    Bevel2: TBevel;
    Panel1: TPanel;
    Label7: TLabel;
    CEDireccion: TColorDBEdit;
    Label11: TLabel;
    CELocalidad: TColorDBEdit;
    CBProvincia: TRxDBLookupCombo;
    CECP: TColorDBEdit;
    Label13: TLabel;
    CBPartido: TRxDBLookupCombo;
    CETelefono: TColorDBEdit;
    Label8: TLabel;
    Label12: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    Image2: TImage;
    Bevel3: TBevel;
    PartidoSource: TDataSource;
    ProvinciaSource: TDataSource;
    ClienteSource: TDataSource;
    BBOtros: TBitBtn;
    Label6: TLabel;
    CBTDConductor: TComboBox;
    CENroConductor: TColorEdit;
    CENombreConductor: TColorEdit;
    BBConductor: TBitBtn;
    dsBancos: TDataSource;
    BBModelo: TBitBtn;
    dsSucursales: TDataSource;
    dsMonedas: TDataSource;
    CENroSucursal: TEdit;
    cbbancos: TRxDBLookupCombo;
    cbSucursales: TRxDBLookupCombo;
    ceNroBanco: TColorEdit;
    Label14: TLabel;
    lblCantidadAPagar: TLabel;
    Bevel4: TBevel;
    procedure BCancelarClick(Sender: TObject);
    procedure BContinuarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbenrochequeEnter(Sender: TObject);                          
    procedure dbenrochequeExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BBOtrosClick(Sender: TObject);
    procedure BBOtrosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BBOtrosMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CBProvinciaChange(Sender: TObject);
    procedure CBProvinciaCloseUp(Sender: TObject);
    procedure CBProvinciaEnter(Sender: TObject);
    procedure CBProvinciaExit(Sender: TObject);
    procedure CBPartidoChange(Sender: TObject);
    procedure CBPartidoCloseUp(Sender: TObject);
    procedure CBTDConductorChange(Sender: TObject);
    procedure CENroConductorChange(Sender: TObject);
    procedure CENroConductorExit(Sender: TObject);
    procedure BBConductorClick(Sender: TObject);
    procedure BBModeloClick(Sender: TObject);
    procedure BBModeloKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CBMonedaCloseUp(Sender: TObject);
    procedure CBMonedaEnter(Sender: TObject);
    procedure CENroSucursalExit(Sender: TObject);
    procedure CBMonedaExit(Sender: TObject);
    procedure CENroSucursalEnter(Sender: TObject);
    procedure dbenrochequeKeyPress(Sender: TObject; var Key: Char);
    procedure CENroBancoEnter(Sender: TObject);
    procedure CENroBancoExit(Sender: TObject);
    procedure CENroBancoKeyPress(Sender: TObject; var Key: Char);
    procedure cbbancosChange(Sender: TObject);
    procedure cbSucursalesChange(Sender: TObject);
    procedure cbSucursalesCloseUp(Sender: TObject);
    procedure cbbancosCloseUp(Sender: TObject);
    procedure dbefecvenExit(Sender: TObject);
    procedure CETelefonoExit(Sender: TObject);
    procedure cbbancosExit(Sender: TObject);
    procedure cbSucursalesExit(Sender: TObject);
    procedure CENroSucursalChange(Sender: TObject);
    procedure ceNroBancoChange(Sender: TObject);
  private
    { Private declarations }
    fCheque: TCheque;
    fBancos: TBancos;
    fSucursales: TSucursales;
    fMonedas: TMonedas;
    Completo: boolean;
    LPartidos : TPartidos;
    LProvincias : TProvincias;
    fUpdating,InicioForm: Boolean;
    UnCliente: TClientes;
    MiCodFactura: string;
    function ValidatePost: boolean;
    procedure LoadAllPartidosOfProvinceZone (aPartido: TPartidos);
    procedure RellenarFormulario;
    procedure MostrarDatos_Cliente (var aCliente: TClientes; iTipoDocu: integer; sDocument: string);
    procedure NuevaSucursal;
  public
    { Public declarations }
  end;
  function DoPagoConCheque (const acodfactu: string; const aCodClien : string):boolean;
  function DoPagoConChequeImporte (const acodfactu: string; const aCodClien : string; Importe: Double):boolean;

var
  frmPagoConCheque: TfrmPagoConCheque;

implementation

ResourceString

        M_BUENOS_AIRES = 'BUENOS AIRES';
        FILE_NAME = 'UFPagoConCheque.PAS';

{$R *.DFM}


function DoPagoConChequeImporte (const acodfactu: string; const aCodclien : string; Importe: Double):boolean;
begin
    with TfrmPagoConCheque.Create(Application) do
    begin
      try
        MiCodFactura:=aCodfactu;

        unCliente:=TClientes.createfromCodClien(MyBD,strtoint(aCodclien));
        unCliente.Open;
        clientesource.dataset:=Uncliente.DataSet;
        with UnCliente do                               {DvARIOS}
        begin
                LPartidos := TPartidos.Create(fVarios);
                LProvincias := TProvincias.Create(uncliente.DataBase);
                LPartidos.Open;
                LProvincias.Open;
                LoadAllPartidosOfProvinceZone(UnCliente.Partido);
                PartidoSource.DataSet:=LPArtidos.DataSet;
                ProvinciaSource.DataSet:=LProvincias.DataSet;
                CBPartidoChange(ProvinciaSource);
        end;
        fBancos:=NIL;
        fSucursales:=nil;
        fMonedas:=nil;
        lblCantidadAPagar.Caption:= Format ('%1.2f',[Importe]);
        showmodal;
      finally
        result:= completo ;
        free
      end;
    end;
end;


function DoPagoConCheque (const acodfactu: string; const aCodclien : string):boolean;
begin
    with TfrmPagoConCheque.Create(Application) do
    begin
      try
        MiCodFactura:=aCodfactu;

        unCliente:=TClientes.createfromCodClien(MyBD,strtoint(aCodclien));
        unCliente.Open;
        clientesource.dataset:=Uncliente.DataSet;
        with UnCliente do                               {DvARIOS}
        begin
                LPartidos := TPartidos.Create(fVarios);
                LProvincias := TProvincias.Create(uncliente.DataBase);
                LPartidos.Open;
                LProvincias.Open;
                LoadAllPartidosOfProvinceZone(UnCliente.Partido);
                PartidoSource.DataSet:=LPArtidos.DataSet;
                ProvinciaSource.DataSet:=LProvincias.DataSet;
                CBPartidoChange(ProvinciaSource);
        end;
        fBancos:=NIL;
        fSucursales:=nil;
        fMonedas:=nil;
        showmodal;
      finally
        result:= completo ;
        free
      end;
    end;
end;

procedure TfrmPagoConCheque.BCancelarClick(Sender: TObject);
begin
  fCheque.Cancel;
  completo := False;
  modalresult:=mrCancel;
end;

procedure TfrmPagoConCheque.BContinuarClick(Sender: TObject);
var aq: TSQLDataSet;
    dsp : tDatasetprovider;
    cds : tClientDataSet;
begin
  if ValidatePost then
    try
      aQ := TSQLDataSet.Create(self);
      aQ.SQLConnection := fsucursales.DataBase;
      aQ.CommandType := ctQuery;
      aQ.GetMetadata := false;
      aQ.NoMetadata := true;
      aQ.ParamCheck := false;

      dsp := TDataSetProvider.Create(self);
      dsp.DataSet := aQ;
      dsp.Options := [poIncFieldProps,poAllowCommandText];

      cds:=TClientDataSet.Create(self);
        try
          with cds do
          begin
            SetProvider(dsp);
            commandtext := ('SELECT SQ_TCHEQUES_CODCHEQUE.NEXTVAL FROM DUAL');
            Open;
            FCheque.ValueByName[FIELD_CODCHEQUE]:=fields[0].asstring;
          end;
        finally
          cds.Free;
          dsp.Free;
          aQ.close;
          aQ.free;
        end;
      fCheque.ValueByName[FIELD_CODFACTU]:=MiCodFactura;
      fCheque.valuebyname[FIELD_CODCLIEN]:=UnCliente.valuebyname[FIELD_CODCLIEN];
      fCheque.ValueByName[FIELD_ERROR]:='S';
      fCheque.post(true);
      if UnCliente.dataset.state in [dsInsert,dsEdit] then
        UnCliente.Post(true);
      Completo := True;
      modalresult:=mrok;
    except
      on E: Exception do
          ShowMessage(caption,'Error al conectarse a la base de datos: '+E.Message);
    end;
end;

procedure TfrmPagoConCheque.FormCreate(Sender: TObject);
begin
  InicioForm:=true;
  fCheque:=nil;
  fCheque:= tCheque.CreateByRowid(MyBD,'');
  dsCheque.dataset:=fCheque.DataSet;
end;

procedure TfrmPagoConCheque.FormShow(Sender: TObject);
begin
  fCheque.open;
  RellenarFormulario;
end;

function tFrmPagoConCheque.ValidatePost:boolean;
begin
  Result := False;
  if CENroBanco.Text = '' then
  begin
     MessageDlg (Application.Title, 'Debe Asignarle un Nro de Banco al Cheque', mtError, [mbOk],mbOk,0);
     CENroBanco.SetFocus;
     exit;
  end;
  if CENroSucursal.Text = '' then
  begin
     MessageDlg (Application.Title, 'Debe Asignarle una Sucursal al Cheque', mtError, [mbOk],mbOk,0);
     CENroSucursal.SetFocus;
     exit;
  end;
  if (dbenrocheque.text = '') then
  begin
     MessageDlg (Application.Title, 'Debe Introducir un Nro de Cheque', mtError, [mbOk],mbOk,0);
     dbenrocheque.SetFocus;
     exit;
  end;
  Try
     StrToDate(dbefecven.Text);
     If (strtodate(dbefecven.text)>date)  or ((date-strtodate(dbefecven.text))>30)
     then begin
            Raise Exception.Create('Ingrese una Fecha de Pago Válida');
     end;
  Except
     Messagedlg(Caption,'La Fecha de Pago Debe ser Anterior o Igual a la Actual y la Diferencia con la Fecha Actual'+#13+'no Debe ser Mayor a 30 Días',mtError,[mbok],mbok,0);
     dbefecven.Clear;
     dbefecven.SetFocus;
     exit;
  end;
  if cbMoneda.Text = '' then
  begin
     MessageDlg (Application.Title, 'Debe Asignarle una Moneda al Cheque', mtError, [mbOk],mbOk,0);
     CENroSucursal.SetFocus;
     exit;
  end;
  if CENombreConductor.text = '' then
  begin
     MessageDlg (Application.Title, 'Debe Asignarle un Cliente al Cheque', mtError, [mbOk],mbOk,0);
     CBTDConductor.SetFocus;
     exit;
  end;
  if CEDireccion.text = '' then
  begin
     MessageDlg (Application.Title, 'Debe Asignarle un Domicilio al Cliente', mtError, [mbOk],mbOk,0);
     CBTDConductor.SetFocus;
     exit;
  end;

  Result := True;
end;

procedure TfrmPagoConCheque.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fCheque.Close;
  fCheque.Free;
  UnCliente.free;
  fBancos.Free;
  if assigned(fsucursales) then fsucursales.Free;
  if assigned(lpartidos) then lpartidos.free;
  if assigned(lprovincias) then lprovincias.free;
  fmonedas.free;
end;



procedure TfrmPagoConCheque.dbenrochequeEnter(Sender: TObject);
begin
        DestacarControl (Sender, clGreen, clWhite, TRUE);
end;

procedure TfrmPagoConCheque.dbenrochequeExit(Sender: TObject);
begin
    AtenuarControl(Sender, TRUE);
end;

procedure TfrmPagoConCheque.FormKeyPress(Sender: TObject; var Key: Char);
begin
     if key = #13
     then begin
         Perform(WM_NEXTDLGCTL,0,0);
         Key := #0
     end;
end;

procedure TfrmPagoConCheque.BBOtrosClick(Sender: TObject);
begin
        Perform (WM_NEXTDLGCTL, 0, 0)
end;

procedure TfrmPagoConCheque.BBOtrosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
        if Key = VK_SPACE
        then begin
            LPartidos.Filter := Format('WHERE %S = %S ORDER BY NOMBPART',[FIELD_CODPROVI,LProvincias.ValueByName[FIELD_CODPROVI]]);
            CBPartido.SetFocus;
        end

end;

procedure TfrmPagoConCheque.BBOtrosMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
        LPartidos.Filter := Format('WHERE %S = %S ORDER BY NOMBPART',[FIELD_CODPROVI,LProvincias.ValueByName[FIELD_CODPROVI]]);
        CBPartido.SetFocus;
end;

procedure TfrmPagoConCheque.CBProvinciaChange(Sender: TObject);
begin
        if FUpdating then Exit;
        FUpdating:=True;
        Try
            if (CBProvincia.Text <> M_BUENOS_AIRES)
            then LPartidos.Filter := Format('WHERE %S = %S ORDER BY NOMBPART',[FIELD_CODPROVI,LProvincias.ValueByName[FIELD_CODPROVI]])
            else LPartidos.Filter := Format('WHERE %S = %S AND %S = %S ORDER BY NOMBPART',[FIELD_CODPROVI,LProvincias.ValueByName[FIELD_CODPROVI],FIELD_NUMZONAP,fVarios.ValueByName[FIELD_ZONA]]);
        FInally
            FUpdating:=FalsE;
        end;

end;

procedure TfrmPagoConCheque.CBProvinciaCloseUp(Sender: TObject);
begin
    CBProvincia.Value := LProvincias.ValueByName[CBProvincia.LookUpField];
end;

procedure TfrmPagoConCheque.CBProvinciaEnter(Sender: TObject);
begin
        DestacarControl (Sender, clGreen, clWhite, TRUE)
end;

procedure TfrmPagoConCheque.CBProvinciaExit(Sender: TObject);
begin
        AtenuarControl (Sender, TRUE)
end;

procedure TfrmPagoConCheque.CBPartidoChange(Sender: TObject);
begin
    //Marcar la provincia según la seleccion
    if FUpdating then Exit;
    If LPArtidos.ValueByName[FIELD_CODPROVI]='' then Exit;
    FUpdating:=True;
    Try
        LProvincias.First;
        While ((LProvincias.ValueByName[FIELD_CODPROVI]<>LPArtidos.ValueByName[FIELD_CODPROVI]) and (not(LProvincias.Eof))) do
        begin
            LProvincias.Next;
        end;
    Finally
        CBProvincia.Value:=LProvincias.ValueByName[FIELD_CODPROVI];
        FUpdating:=False;
    end;

end;

procedure TfrmPagoConCheque.CBPartidoCloseUp(Sender: TObject);
begin
    CBPartido.Value := LPartidos.ValueByName[CBPartido.LookUpField];
end;

procedure TfrmPagoConCheque.LoadAllPartidosOfProvinceZone (aPartido: TPartidos);
var
        aProvincia : string;
        aZone : string;
begin
        try
            If aPartido=nil
            Then begin
                aPartido:=TPartidos.CreateFromDatabase(MyBD,DATOS_PARTIDOS,Format(' WHERE NUMPARTI = %S AND NUMZONAP = %S',[fVarios.ValuebyName[FIELD_CODPROVI],fVarios.ValueByName[FIELD_ZONA]]));
            end;
            aPartido.Open;
            if (aPartido.ValueByName[FIELD_CODPROVI] = '') or (aPartido.ValueByName[FIELD_NUMZONAP] = '')
            then begin
                aProvincia := IntToStr(fVarios.CodProvi);
                aZone := IntToStr(fVarios.Zona);
            end
            else begin
                aProvincia := aPartido.ValueByName[FIELD_CODPROVI];
                aZone := aPartido.ValueByName[FIELD_NUMZONAP];
            end;
        Finally
            aPartido.Free;
            LPartidos.Filter:=(Format('WHERE %S = %S AND %S = %S ORDER BY NOMBPART',[FIELD_CODPROVI,aProvincia,FIELD_NUMZONAP,aZone]))
        end;
end;

procedure TfrmPagoConCheque.RellenarFormulario;
begin
    CBTDConductor.ItemIndex := CBTDConductor.Items.IndexOf (UnCliente.ValueByName[FIELD_TIPODOCU]);
    CENroConductor.Text := UnCliente.ValueByName[FIELD_DOCUMENT];
    CENombreConductor.Text := UnCliente.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
    fBancos:=TBancos.Create(myBD);
    fBancos.Open;
    dsBancos.DataSet:=fBancos.DataSet;
    fMonedas:=TMonedas.create(MyBD);
    fMonedas.Open;
    dsMonedas.dataset:=fMonedas.dataset;
end;


procedure TfrmPagoConCheque.CBTDConductorChange(Sender: TObject);
begin
        with CENroConductor do
        begin
            Text := ''; Color := clWindow; Enabled := TRUE
        end;

end;

procedure TfrmPagoConCheque.CENroConductorChange(Sender: TObject);
begin
        CENombreConductor.Text := '';
        if ((Length((SEnder as TColorEdit).Text) > 0) and (CBTDConductor.ItemIndex<>-1)) and not InicioForm
        then begin
                try
                    BBConductor.Enabled := FALSE;
                    Label2.Font.Color:=clBlack;
                    if (TTipoDocumento(CBTDConductor.ItemIndex) <> ttdCUIT) or
                       ((TTipoDocumento(CBTDConductor.ItemIndex) = ttdCUIT) and (TCUIT.IsCorrect((Sender as TColorEdit).Text)))
                    then begin
                        UnCliente.Free;
                        UnCliente := nil;
                        UnCliente := TClientes.CreateFromCode(MyBD,CBTDConductor.Items[CBTDConductor.ItemIndex],(Sender as TColorEdit).Text);
                        UnCliente.Open;
                        clientesource.dataset:=Uncliente.DataSet;
                        BBConductor.Enabled := TRUE;
                        if (UnCliente.RecordCount <> 0) then
                        begin
                            CBTDConductor.ItemIndex := CBTDConductor.Items.IndexOf (UnCliente.ValueByName[FIELD_TIPODOCU]);
                            CENroConductor.Text := UnCliente.ValueByName[FIELD_DOCUMENT];
                            CENombreConductor.Text := UnCliente.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
                        end
                    end
                    else begin
                        Label2.Font.Color:=clRed;
                        BBConductor.Enabled := FALSE;
                    end;
                except
                    on E: Exception do
                        MessageDlg('Identificación del Cliente',Format('Esta fallando la introducción de datos del cliente por: %s. Compruebe que los datos introducidos son correctos. Si el error persiste indíquelo al jefe de planta.',[E.message]), mtInformation, [mbOk], mbOk, 0)
                end
        end
        else
        begin
          BBConductor.Enabled := FALSE;
          inicioForm:=False;
        end;
end;

procedure TfrmPagoConCheque.CENroConductorExit(Sender: TObject);
begin
        If ((UnCliente=nil) or (UnCliente.IsNew)) then BBConductorClick(BBConductor);
end;

procedure TfrmPagoConCheque.BBConductorClick(Sender: TObject);
begin
    MostrarDatos_Cliente (UnCliente, CBTDConductor.ItemIndex, CENroConductor.Text);
    if Assigned(UnCliente)
    then CENombreConductor.Text := UnCliente.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
    CENroConductorChange(CENroConductor);
end;

procedure TfrmPagoConCheque.MostrarDatos_Cliente (var aCliente: TClientes; iTipoDocu: integer; sDocument: string);
var
        EditCliente: TFAMCliente;
        aCliente_Auxi: TClientes;
begin
        if (not assigned(aCliente)) Then Exit;
        aCliente_Auxi := TClientes.CreateByCopy (aCliente);
        try
           aCliente_Auxi.Open;
           If aCliente_Auxi.IsNew
           Then begin
               aCliente_Auxi.Append;
               aCliente_Auxi.ValueByName[FIELD_TIPODOCU] := V_TIPO_DOCUMENTO[tTipoDocumento(iTipoDocu)];
               aCliente_Auxi.ValueByName[FIELD_DOCUMENT] := sDocument;
           end
           else begin
               If not aCliente_Auxi.Edit
               then begin
                   fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FILE_NAME,'Falló la puesta en edicion de la tabla de clientes');
                   Raise Exception.Create('The Data Could not Be Edit');
               end;
           end;

           EditCliente:= TFAMCliente.CreateFromCliente(Application,aCliente_Auxi);
           try
               if (EditCliente.ShowModal = mrOk) then
               begin
                   aCliente.Free;
                   aCliente := TClientes.CreateFromCode (MyBD, V_TIPO_DOCUMENTO[tTipoDocumento(iTipoDocu)], sDocument);
                   aCliente.Open;
               end;
           finally
               EditCliente.Free;
           end;
        finally
             aCliente_Auxi.Free;
        end;
end;



procedure TfrmPagoConCheque.NuevaSucursal;
begin
        if InsercionDeSucursalesBanco(FBancos.valuebyname[FIELD_CODBANCO],fSucursales, CENroSucursal.text)
        then
        begin
          CENroSucursal.text := fSucursales.ValueByName[FIELD_CODSUCURSAL];
          cbSucursales.Value:= fSucursales.ValueByName[FIELD_CODSUCURSAL];
        end;

end;

procedure TfrmPagoConCheque.BBModeloClick(Sender: TObject);
begin
    NuevaSucursal;
//    Perform (WM_NEXTDLGCTL, 0, 0)
end;

procedure TfrmPagoConCheque.BBModeloKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
        if Key = VK_SPACE then
        begin
            NuevaSucursal;
            Perform (WM_NEXTDLGCTL, 0, 0)
        end;
end;


procedure TfrmPagoConCheque.CBMonedaCloseUp(Sender: TObject);
begin
        CBMoneda.Value := fMonedas.ValueByName[CBMoneda.LookUpField];
        Perform (WM_NEXTDLGCTL, 0, 0)
end;

procedure TfrmPagoConCheque.CBMonedaEnter(Sender: TObject);
begin
     DestacarControl (Sender, clGreen, clWhite, FALSE);
     if cbMoneda.Text = '' then
        CBMoneda.Value := fMonedas.ValueByName[FIELD_CODMONEDA];
end;

procedure TfrmPagoConCheque.CENroSucursalExit(Sender: TObject);
begin
  if (CENroSucursal.Text <> '') and (fSucursales.locate(FIELD_CODSUCURSAL,StrToInt(CENroSucursal.text),[])) then
  begin
      FCheque.ValueByName[FIELD_CODSUCURSAL] := CENroSucursal.text;
      AtenuarControl (Sender, FALSE);
      cbsucursales.LookupSource:=dssucursales;
  end
  else
  begin
    if (not cbSucursales.focused) and (not CENroBanco.focused) and (not cbBancos.focused) and (not bcancelar.focused) then
    begin
      NuevaSucursal;
      if (CENroSucursal.Text <> '') and (fSucursales.locate(FIELD_CODSUCURSAL,StrToInt(CENroSucursal.text),[])) then
      begin
        FCheque.ValueByName[FIELD_CODSUCURSAL] := CENroSucursal.text;
        AtenuarControl (Sender, FALSE);
        cbsucursales.LookupSource:=dssucursales;
//        Perform (WM_NEXTDLGCTL, -1, 0)   //*******
      end
      else
      begin
       if not bcancelar.focused then
       begin
         MessageDlg (Application.Title, 'Debe Asignarle una Sucursal al Cheque', mtError, [mbOk],mbOk,0);
         CENroSucursal.clear;
         cenroSucursal.setfocus;
       end;
      end;
    end
    else
      AtenuarControl (Sender, FALSE);
  end;
end;

procedure TfrmPagoConCheque.CBMonedaExit(Sender: TObject);
begin
        AtenuarControl (Sender, FALSE)
end;

procedure TfrmPagoConCheque.CENroSucursalEnter(Sender: TObject);
begin
  cbsucursales.LookupSource:=nil;
  DestacarControl (Sender, clGreen, clWhite, FALSE);
  fsucursales.Open;
  cbsucursales.LookupSource:=dssucursales;
  if fsucursales.RecordCount > 0 then
    cbsucursales.Enabled:=true
  else
    cbsucursales.Enabled:=false;
end;

procedure TfrmPagoConCheque.dbenrochequeKeyPress(Sender: TObject;
  var Key: Char);
begin
        if (Key in ['-'])
        then key := #0
end;

procedure TfrmPagoConCheque.CENroBancoEnter(Sender: TObject);
begin
  cbbancos.LookupSource:=nil;
//  fsucursales:=nil;
//  CENroSucursal.clear;
//  cbSucursales.LookupSource:=nil;
//  fcheque.valuebyname[FIELD_CODSUCURSAL]:='';

//  DestacarControl (Sender, clGreen, clWhite, FALSE);
end;

procedure TfrmPagoConCheque.CENroBancoExit(Sender: TObject);
begin
  if (CENroBanco.Text <> '') and (fBancos.locate(FIELD_NROBANCO,StrToInt(cenrobanco.text),[])) then
  begin
    fsucursales:=tsucursales.CreateFromBanco(MyBD,fBancos.valuebyname[FIELD_CODBANCO]);
    dsSucursales.DataSet:=fSucursales.dataset;
    fsucursales.close;
//    ceNroSucursal.Clear;
    fcheque.valuebyname[FIELD_CODBANCO]:=fbancos.ValueByName[FIELD_CODBANCO];
//    AtenuarControl (Sender, FALSE);
    cbbancos.LookupSource:=dsbancos;
  end
  else
  begin
     if (not bcancelar.focused) and not (cbbancos.focused) then
     begin
       MessageDlg (Application.Title, 'Debe Asignarle un Nro de Banco al Cheque', mtError, [mbOk],mbOk,0);
       CENroBanco.SetFocus;
     end
     else
       if cbbancos.focused then cbbancos.LookupSource:=dsbancos;
  end;
end;

procedure TfrmPagoConCheque.CENroBancoKeyPress(Sender: TObject;
  var Key: Char);
begin
        if not (Key in ['0','1','2','3','4','5','6','7','8','9',char(VK_BACK)])
        then key := #0
end;

procedure TfrmPagoConCheque.cbbancosChange(Sender: TObject);
begin
  cenrobanco.text:=fbancos.ValueByName[FIELD_NROBANCO];
end;

procedure TfrmPagoConCheque.cbSucursalesChange(Sender: TObject);
begin
  if cenrosucursal.text <> '' then
    cenrosucursal.text:=fsucursales.ValueByName[FIELD_CODSUCURSAL];
end;

procedure TfrmPagoConCheque.cbSucursalesCloseUp(Sender: TObject);
begin
  cenroSucursal.text:=fSucursales.ValueByName[FIELD_CODSUCURSAL];
  cbsucursales.Value:=fSucursales.ValueByName[FIELD_CODSUCURSAL];
  Perform (WM_NEXTDLGCTL, 0, 0)
end;

procedure TfrmPagoConCheque.cbbancosCloseUp(Sender: TObject);
begin
  cenrobanco.text:=fbancos.ValueByName[FIELD_NROBANCO];
  cbbancos.Value:=fbancos.ValueByName[FIELD_CODBANCO];
//        Perform (WM_NEXTDLGCTL, 0, 0)
end;

procedure TfrmPagoConCheque.dbefecvenExit(Sender: TObject);
begin
    AtenuarControl(Sender, TRUE);
end;

procedure TfrmPagoConCheque.CETelefonoExit(Sender: TObject);
begin
  BContinuar.SetFocus;
end;

procedure TfrmPagoConCheque.cbbancosExit(Sender: TObject);
begin
    fsucursales:=tsucursales.CreateFromBanco(MyBD,fBancos.valuebyname[FIELD_CODBANCO]);
    dsSucursales.DataSet:=fSucursales.dataset;
    fsucursales.close;
//    cenrosucursal.Clear;
end;

procedure TfrmPagoConCheque.cbSucursalesExit(Sender: TObject);
begin
  cenrosucursal.text:=fsucursales.ValueByName[FIELD_CODSUCURSAL];
end;

procedure TfrmPagoConCheque.CENroSucursalChange(Sender: TObject);
begin
   cbSucursales.Value := CENroSucursal.Text;
end;

procedure TfrmPagoConCheque.ceNroBancoChange(Sender: TObject);
begin
  fsucursales:=nil;
  CENroSucursal.clear;
  cbSucursales.LookupSource:=nil;
  fcheque.valuebyname[FIELD_CODSUCURSAL]:='';
end;

end.



