unit UFMantClientes;

interface

    uses
        Windows,
        Messages,
        SysUtils,
        Classes,
        Graphics,
        Controls,
        Forms,
        StdCtrls,
        ExtCtrls,
        Buttons,
        Mask,
        ToolEdit,
        JLLabel,
        DBCtrls,
        SQLExpr,
        RXLookup,
        RXDBCtrl,
        UCDBEdit,
        UCDIALGS,
        USAGCLASSES,
        USAGVARIOS,
        USAGESTACION,
        Uutils,
        ugacceso, DB;

    type

        TFAMCliente = class(TForm)
            ClienteSource: TDataSource;
            ProvinciaSource: TDataSource;
            PartidoSource: TDataSource;
    TipoclienteSource: TDataSource;
    dsLocalidad: TDataSource;
    dsCodposta: TDataSource;
    Label22: TLabel;
    Image1: TImage;
    Label1: TLabel;
    CETDocu: TColorDBEdit;
    CETelefono: TColorDBEdit;
    CBCodposta: TRxDBLookupCombo;
    Label10: TLabel;
    CEDepto: TColorDBEdit;
    Label25: TLabel;
    CEPiso: TColorDBEdit;
    Label24: TLabel;
    ceNumero: TColorDBEdit;
    Label23: TLabel;
    CEDireccion: TColorDBEdit;
    Label7: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    CBPartido: TRxDBLookupCombo;
    BBOtros: TBitBtn;
    Label11: TLabel;
    CBProvincia: TRxDBLookupCombo;
    Label8: TLabel;
    btnBuscarLoc: TBitBtn;
    CEPrimerApellido: TColorDBEdit;
    CESegundoApellido: TColorDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    CENDocu: TColorDBEdit;
    Label2: TLabel;
    Label5: TLabel;
    CENombre: TColorDBEdit;
    CBLocalidad: TRxDBLookupCombo;
  //  RLSinCredito: TRotateLabel;
    ISinCredito: TImage;
    IConCredito: TImage;
    ICorriente: TImage;
    IFrack: TImage;
    Label14: TLabel;
    DBEditFormulario: TDBEdit;
    DBEditTipoIva: TDBEdit;
    DBEditTipoFactura: TDBEdit;
    Label21: TLabel;
    RBDePago: TRadioButton;
    RBDeCredito: TRadioButton;
    Label33: TLabel;
    CEMorosidad: TDBDateEdit;
    CEIIBB: TColorDBEdit;
    Label26: TLabel;
    cbIIBB: TCheckBox;
    Label20: TLabel;
    CEFechaAlta: TColorDBEdit;
    CECUIT: TColorDBEdit;
    Label17: TLabel;
    Label19: TLabel;
    CBTipoIva: TComboBox;
    LISTATIPOCLIENTE: TRxDBLookupCombo;
    Label18: TLabel;
    CBFormulario: TCheckBox;
    CBTipoFactura: TRadioGroup;
    Image3: TImage;
    BContinuar: TBitBtn;
    BCancelar: TBitBtn;
    CEHabilitacion: TColorDBEdit;
    Label16: TLabel;
    PCredito: TPanel;
    Panel5: TPanel;
    IMoroso: TImage;
    Panel6: TPanel;
    ICredito: TImage;
    Panel7: TPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label6: TLabel;
    CEArea: TColorDBEdit;
    Label27: TLabel;
    Label9: TLabel;
    CECelular: TColorDBEdit;
    Label15: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    PInformativo: TPanel;
    Bevel5: TBevel;
    RLSinCredito: TLabel;
            procedure RBDePagoClick(Sender: TObject);
            procedure RBDeCreditoClick(Sender: TObject);
            procedure CEMorosidadChange(Sender: TObject);
            procedure CBProvinciaEnter(Sender: TObject);
            procedure FormCreate(Sender: TObject);
            procedure FormKeyPress(Sender: TObject; var Key: Char);
            procedure CBProvinciaExit(Sender: TObject);
            procedure FormDestroy(Sender: TObject);
            procedure CBProvinciaChange(Sender: TObject);
            procedure CBPartidoChange(Sender: TObject);
            procedure BContinuarClick(Sender: TObject);
            procedure BCancelarClick(Sender: TObject);
            procedure CBTipoIvaChange(Sender: TObject);
            procedure CBFormularioClick(Sender: TObject);
            procedure CBTipoFacturaClick(Sender: TObject);
            procedure DBEditFormularioChange(Sender: TObject);
            procedure DBEditTipoIvaChange(Sender: TObject);
            procedure DBEditTipoFacturaChange(Sender: TObject);
            procedure CBFormularioEnter(Sender: TObject);
            procedure CBFormularioExit(Sender: TObject);
            procedure CBTipoFacturaEnter(Sender: TObject);
            procedure CBTipoFacturaExit(Sender: TObject);
            procedure RBDeCreditoEnter(Sender: TObject);
            procedure RBDePagoExit(Sender: TObject);
            procedure FormActivate(Sender: TObject);
            procedure CEMorosidadEnter(Sender: TObject);
            procedure CEMorosidadExit(Sender: TObject);
            procedure CBProvinciaCloseUp(Sender: TObject);
            procedure CBPartidoCloseUp(Sender: TObject);
            procedure LISTATIPOCLIENTECloseUp(Sender: TObject);
            procedure CBLocalidadCloseUp(Sender: TObject);
            procedure CBLocalidadChange(Sender: TObject);
            procedure CBCodpostaChange(Sender: TObject);
            procedure CBCodpostaCloseUp(Sender: TObject);
    procedure CBLocalidadEnter(Sender: TObject);
    procedure CBLocalidadExit(Sender: TObject);
    procedure btnBuscarLocClick(Sender: TObject);
    procedure cbIIBBClick(Sender: TObject);
    procedure CEAreaKeyPress(Sender: TObject; var Key: Char);
    procedure BBOtrosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BBOtrosMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BBOtrosClick(Sender: TObject);
        private
          { Private declarations }
            fUpdating: Boolean;
            PrimeraVez: Boolean; // Para evitar que cuando se crea el form verifique el servicio de cta cte
            ContPrimeraVez: Integer; //Contador porque cuando se crea el form pasa 2 veces
            UnCliente: TClientes;
            LPartidos : TPartidos;
            LProvincias : TProvincias;
            fLocalidad: TLocalidad_interior;
            fCPInterior: TCodposta_Interior;
            fCPCapital: TCodposta_Capital;
            fTipoCliente: TTIposCliente;
            FDAtaBase: TSQLConnection;
            Function ValidatePost:Boolean;
            procedure PonCredito;
            procedure LoadAllPartidosOfProvinceZone (aPartido: TPartidos);
        public
          { Public declarations }
            bAbort : boolean;
            Constructor CreateFromCliente(aOwner:TComponent;aCliente:TClientes);
            procedure QuitaCredito;
        end;

    var
        FAMCliente: TFAMCliente;


implementation

{$R *.DFM}

    uses
        UTILORACLE,
        USAGCUIT,
        UINTERFAZUSUARIO,
        GLOBALS,
        ufBuscaLocalidad;

    ResourceString

        M_BUENOS_AIRES = 'BUENOS AIRES';
        M_INVALID_DATA = 'Datos Tipo Iva, formulario 576 y Tipo Factura no se Corresponden';
        M_WRONG_DATA = 'Falta Completar Datos Del Cliente';
        M_NUM_CUIT_NOT_FOUND = 'Debe Introducir Un Código CUIT Correcto';
        M_INVALID_IIBB = 'Debe completar los datos de IIBB';

    Constructor TFAMCliente.CreateFromCliente(aOwner:TComponent;aCliente:TClientes);
    var
        Documento : String;
    begin
        //Construtor de la clase
        Inherited Create(aOwner);
        UnCliente:=aCliente;
        FDataBase:=aCliente.DataBase;
        ClienteSource.DataSet:=UnCliente.DataSet;

            with UnCliente do                               {DvARIOS}
            begin
                LPartidos := TPartidos.Create(fVarios);
                LProvincias := TProvincias.Create(FDataBase);
                fTipoCliente:= TTiposcliente.CreateFromDatabase(DataBase,DATOS_TIPOS_DE_CLIENTE,'WHERE VIGENTE = ''S'' ORDER BY TIPOCLIENTE_ID ASC');
                LPartidos.Open;
                LProvincias.Open;
                fTipoCliente.Open;
                fLocalidad := TLocalidad_Interior.CreateByCodProvi(mybd,LProvincias.ValueByName[FIELD_CODPROVI]);
                fCPInterior := TCodposta_Interior.CreateByCodProvi(mybd,LProvincias.ValueByName[FIELD_CODPROVI]);
                fCPCapital := TCodposta_Capital.Create(mybd);

                LoadAllPartidosOfProvinceZone(UnCliente.Partido);
                PartidoSource.DataSet:=LPArtidos.DataSet;
                ProvinciaSource.DataSet:=LProvincias.DataSet;
                TipoclienteSource.Dataset:=fTipoCliente.DataSet;
                CBPartidoChange(ProvinciaSource);

//                fLocalidad.Open;
                dsLocalidad.DataSet := fLocalidad.DataSet;
                if LProvincias.ValueByName[FIELD_CODPROVI] <> '3' then
                begin
                  fCPInterior.Open;
                  dsCodposta.DataSet := fCPInterior.DataSet;
                end
                else
                begin
                  fCPCapital.Open;
                  dsCodposta.DataSet := fCPCapital.DataSet;
                end;
                CBProvinciaChange(CBProvincia);
                PInformativo.Caption := Format('%S: %S',[fVarios.ValueByName[FIELD_IDENCONC], DateBD(MyBD)]);
                Documento := UnCLiente.ValueByName[FIELD_TIPODOCU];
                //CETDocu.Text := S_TIPO_DOCUMENTO[Documento];

                if Documento = 'CUIT' //ttdCUIT
                then begin
                    CECUIT.ReadOnly := True;
                    CECUIT.FondoColor :=clFuchsia;
                    CECUIT.Text:=aCliente.ValuebyName[FIELD_DOCUMENT];
                    aCliente.ValuebyName[FIELD_CUIT_CLI]:=aCliente.ValuebyName[FIELD_DOCUMENT];
                end
                else begin
                    CECUIT.ReadOnly := False;
                    CECUIT.FondoColor := clGreen
                end;

                if UnCliente.ValueByName[FIELD_EXENTO_IIBB] = 'S' then
                  cbIIBB.Checked := true;

                if UnCliente.DataSet.State=dsInsert
                then begin
                    CEFechaAlta.Text := DateBD(MyBD);
                    UnCliente.DataSet.FieldByName(FIELD_FECHALTA).asString:=DateBd(MyBD);
                    CBFormulario.Checked := False;
                    cbIIBB.Checked := False;
                    CBTipoIva.ItemIndex := -1;
                    CBTipoFactura.ItemIndex := -1;
                    PonCredito;
                    Uncliente.ValueByName[FIELD_TIPOCLIENTE_ID]:=fTipoCliente.ValueByName[FIELD_TIPOCLIENTE_ID];
                    LISTATIPOCLIENTE.Value:=fTipoCliente.ValueByName[FIELD_TIPOCLIENTE_ID];
                    If CETDocu.text='CUIT'
                    then begin
                        CBTipoIva.Itemindex:=0;
                    end
                    else begin
                        CBTipoIva.Itemindex:=1;
                    end;
                    CBTipoIvaChange(Self);
                end
                else begin
                    If not(UnCliente.Dataset.State = dsInsert)
                    then begin
                    end;
                    PonCredito
                end;
            end;
    end;

    procedure TFAMCliente.PonCredito;
    begin
        if UnCliente.Credito in [ttcNull, ttcNormal]
        then begin
            RBDePago.Checked := TRUE;
            RBDePagoClick(RBDePago);
            ContPrimeraVez := 2;
            PrimeraVez := False;
        end
        else begin
            RBDeCredito.Checked := TRUE;
            RBDeCreditoClick(RBDeCredito)
        end
    end;

    procedure TFAMCliente.QuitaCredito;
    begin
        RBDePago.Enabled := FALSE;
        RBDeCredito.Enabled := FALSE;
        CEMorosidad.ReadOnly := TRUE;
        CEMorosidad.Color := clFuchsia
    end;


    procedure TFAMCliente.RBDePagoClick(Sender: TObject);
    begin
        If fUpdating Then Exit;
        fUpdating:=True;
        Try
            if (Sender as TRadioButton).Checked
            then begin
                UnCliente.ValueByName[FIELD_CREDITCL]:='N';
                PCredito.Caption := ' ' + S_TIPO_CREDITO[ttcNormal];
                PCredito.Font.Color := clBlue;
                ICredito.Picture := ISinCredito.Picture;
                IMoroso.PIcture := ICorriente.Picture;
                RLSinCredito.Visible := FALSE;
            end;
        Finally
            FUpdating:=False;
        end;
    end;

    procedure TFAMCliente.RBDeCreditoClick(Sender: TObject);
    begin
      if (PrimeraVez) or (contPrimeraVez = 3)
       or AccederAServicio(ID_SERVICIO_AUTORIZACION_CUENTA_CORRIENTE,ApplicationUser,PasswordUser, GestorSeg) //
      then begin
        if contPrimeraVez = 2 then PrimeraVez := False;
        inc(contPrimeraVez);
        If fUpdating Then Exit;
        fUpdating:=True;
        Try
            if (Sender as TRadioButton).Checked
            then begin
                UnCliente.ValueByName[FIELD_CREDITCL]:='S';
                PCredito.Caption := ' ' + S_TIPO_CREDITO[ttcCredito];
                PCredito.Font.Color := clGreen;
                ICredito.Picture := IConCredito.Picture;
                if not UnCliente.IsMoroso
                then begin
                    IMoroso.Picture := ICorriente.Picture;
                    RLSinCredito.Visible := FALSE;
                end
                else begin
                    IMoroso.Picture := IFrack.Picture;
                    RLSinCredito.Visible := TRUE;
                end;
            end;
        finally
            fUpdating:=FalsE;
        end;
      end
      else
      begin
        RBDePago.Checked := True;
        RBDePago.SetFocus;
      end;
    end;

    procedure TFAMCliente.CEMorosidadChange(Sender: TObject);
    begin
        If fUpdating then Exit;
        fUpdating:=true;
        Try
            //UnCliente.ValueByName[FIELD_FECMOROS] := CEMorosidad.Text;
            fUpdating:=False;
            PonCredito;
        Finally
            fUpdating:=False;
        end;
    end;

    procedure TFAMCliente.CBProvinciaEnter(Sender: TObject);
    begin
        DestacarControl (Sender, clGreen, clWhite, TRUE);
    end;

    procedure TFAMCliente.CBProvinciaExit(Sender: TObject);
    begin
        AtenuarControl (Sender, TRUE);
    end;

    procedure TFAMCliente.FormCreate(Sender: TObject);
    begin
        fUpdating:=False;
        PrimeraVez:=True;
        ContPrimeraVez := 1;
        bAbort := FALSE;
        LPartidos := nil;
        LProvincias := nil;
        fTipoCliente := nil;
        fLocalidad := nil;
        fCPInterior := nil;
        fCPCapital := nil;
        ShortDateFormat := 'DD/MM/YYYY';
    end;

    procedure TFAMCliente.FormKeyPress(Sender: TObject; var Key: Char);
    begin
        if key = ^M
        then begin
            Perform(WM_NEXTDLGCTL,0,0);
            Key := #0
        end
    end;




    procedure TFAMCliente.FormDestroy(Sender: TObject);
    begin
        PartidoSource.DataSet:=nil;
        ProvinciaSource.DataSet:=nil;
        LPartidos.Free;
        LProvincias.Free;
        If Assigned(fTipoCliente) then fTipocliente.Free;
        fLocalidad.free;
        fCPInterior.Free;
        fCPCapital.Free;
    end;


    procedure TFAMCliente.CBProvinciaChange(Sender: TObject);
    begin
        if FUpdating then Exit;
        FUpdating:=True;
        Try
            if (CBProvincia.Text <> M_BUENOS_AIRES)
            then LPartidos.Filter := Format('WHERE %S = %S ORDER BY NOMBPART',[FIELD_CODPROVI,LProvincias.ValueByName[FIELD_CODPROVI]])
            else LPartidos.Filter := Format('WHERE %S = %S AND %S = %S ORDER BY NOMBPART',[FIELD_CODPROVI,LProvincias.ValueByName[FIELD_CODPROVI],FIELD_NUMZONAP,fVarios.ValueByName[FIELD_ZONA]]);


              fLocalidad.Filter := format('WHERE CODPROVI = %S ORDER BY LOCALIDAD ',[LProvincias.ValueByName[FIELD_CODPROVI]]);
              if (cbProvincia.text <> 'CAPITAL FEDERAL') then
              begin
                if not fcpInterior.active then fCPInterior.open;
                fCPInterior.Filter := format('WHERE CODPROVI = %S ORDER BY CODPOSTA',[LProvincias.ValueByName[FIELD_CODPROVI]]);
                dsCodposta.DataSet := fCPInterior.DataSet;
              end
              else
              begin
                if not fCPCapital.Active then fCPCapital.Open;
                dsCodposta.DataSet := fCPCapital.DataSet;
              end;
              fLocalidad.Open;  //**************
              dsLocalidad.DataSet := fLocalidad.DataSet;

        FInally
            FUpdating:=FalsE;
        end;
    end;

    procedure TFAMCliente.LoadAllPartidosOfProvinceZone (aPartido: TPartidos);
    var
        aProvincia : string;
        aZone : string;
    begin
        try
            If aPartido=nil
            Then begin
                aPartido:=TPartidos.CreateFromDatabase(FDataBase,DATOS_PARTIDOS,Format(' WHERE NUMPARTI = %S AND NUMZONAP = %S',[fVarios.ValuebyName[FIELD_CODPROVI],fVarios.ValueByName[FIELD_ZONA]]));
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


procedure TFAMCliente.CBPartidoChange(Sender: TObject);
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

procedure TFAMCliente.BContinuarClick(Sender: TObject);
var
    ii: integer;
begin
    //Aceptar Datos
    Try

    //validacion del area del celular    MB 07.09.2011
    if TRIM(cecelular.Text)<>'' then
    begin
          if TRIM(cearea.Text)='' then
          begin
             showmessage('ATENCION.', 'Debe ingresar el área del número de celular.');
           cearea.SetFocus;

            exit;
          end;
    end;
     /// fin validacion area


        FUpdating:=True;
        If ValidatePost
        then begin
            UnCliente.Post(true);
            ModalResult:=Mrok;
        end
        else begin
//            messagedlg(Application.Title,M_INVALID_DATA,mtInformation,[mbyes],mbyes,0);
            FUpdating:=FalsE;
        end;
        Except
        //Problemas con el post
            messagedlg(Application.Title,M_WRONG_DATA,mtInformation,[mbyes],mbyes,0);
            FUpdating:=False;
            For ii:=0 to Self.ComponentCount-1 do
            begin
                Try
                    If (Self.Components[ii] Is TDbEdit)
                    then
                        If TDbedit(Self.Components[ii]).DataField=UnCliente.FieldRequired
                        then begin
                            TWinControl(Self.Components[ii]).SetFocus;
                            Exit;
                        end;
                    If (Self.Components[ii] Is TDbDateEdit)
                    then
                        If TDbDateEdit(Self.Components[ii]).DataField=UnCliente.FieldRequired
                        then begin
                            TWinControl(Self.Components[ii]).SetFocus;
                            Exit;
                        end;
                    If (Self.Components[ii] Is TRxDbLookUpCombo)
                    then
                        If TRxDbLookUpCombo(Self.Components[ii]).DataField=UnCliente.FieldRequired
                        then begin
                            TWinControl(Self.Components[ii]).SetFocus;
                            Exit;
                        end;
                Except
                end;
            end;
        raise;
    end;
end;

procedure TFAMCliente.BCancelarClick(Sender: TObject);
begin
    //Cancelar Datos
    FUpdating:=True;
    UnCliente.Cancel;
    ModalResult:=MrCancel;
end;

procedure TFAMCliente.CBTipoIvaChange(Sender: TObject);
begin
    //Cmabio del tipo de IVA
    If FUpdating then Exit;
    fUpdating:=True;
    Try
        //Cambiar datos del control
        DBEditTipoIva.Text:=tTiposIva[CBTipoIva.ItemIndex];
        Uncliente.ValueByName[DBEditTipoIva.DataField]:=tTiposIva[CBTipoIva.ItemIndex];
    Finally
        fUpdating:=False;
        IF CBTipoIva.ItemIndex in [0]
        then begin
            CBFormulario.Checked:=True;
            DBEditFormulario.Text:='S';
            UnCliente.ValueByName[DBEditFormulario.DataField]:='S';
            While fUpdating do Application.Processmessages;
            CBTipoFactura.ItemIndex:=0;
            DBEditTipoFactura.Text:='A';
            UnCliente.ValueByName[DBEditTipoFactura.DataField]:='A';
        end
        else begin
        if   cbtipoiva.ItemIndex=1 then
               begin
                   CECUIT.Clear;
                   CEIIBB.Clear;
               end;
               
            CBFormulario.Checked:=False;
            DBEditFormulario.Text:='N';
            UnCliente.ValueByName[DBEditFormulario.DataField]:='N';
            While fUpdating do Application.Processmessages;
            CBTipoFactura.ItemIndex:=1;
            DBEditTipoFactura.Text:='B';
            UnCliente.ValueByName[DBEditTipoFactura.DataField]:='B';
        end;
    end;
end;

procedure TFAMCliente.CBFormularioClick(Sender: TObject);
begin
    //Cambio en el tipo de formulario
    If FUpdating then Exit;
    fUpdating:=True;
    Try
        //Cambiar datos del control
        If CBFormulario.Checked
        then begin
            DBEditFormulario.Text:='S';
            UnCliente.ValueByName[DBEditFormulario.DataField]:='S';
        end
        else begin
            DBEditFormulario.Text:='N';
            UnCliente.ValueByName[DBEditFormulario.DataField]:='N';
        end;
    Finally
        fUpdating:=False;
    end;
end;

procedure TFAMCliente.CBTipoFacturaClick(Sender: TObject);
begin
    //Cambio del tipo de factura
    If FUpdating then Exit;
    fUpdating:=True;
    Try
        //Cambiar datos del control
        If CBTipoFactura.ItemIndex=0
        Then begin
            DBEditTipoFactura.Text:='A';
            UnCliente.ValueByName[DBEditTipoFactura.DataField]:='A';
        end
        else begin
            DBEditTipoFactura.Text:='B';
            UnCliente.ValueByName[DBEditTipoFactura.DataField]:='B';
        end;

    Finally
        fUpdating:=False;
    end;
end;

procedure TFAMCliente.DBEditFormularioChange(Sender: TObject);
begin
    //Cambio de formulario
    If FUpdating then Exit;
    fUpdating:=True;
    Try
        //Cambiar datos del control
        iF DBEditFormulario.Text='S' then CBFormulario.Checked:=True else CBFormulario.Checked:=False;
    Finally
        fUpdating:=False;
    end;
end;

procedure TFAMCliente.DBEditTipoIvaChange(Sender: TObject);
begin
    //Cambio del tipo de iva
    If FUpdating then Exit;
    fUpdating:=True;
    Try
        //Cambiar datos del control
        If DBEditTipoIva.Text = 'I' then
            CBTipoIva.ItemIndex:=0
            else if DBEditTipoIva.Text = 'N' then   //Se dejó por si en la base aparecía todavía algún cliente con tipo de iva No Inscripto
                CBTipoIva.ItemIndex:=1
                else if DBEditTipoIva.Text = 'C' then
                    CBTipoIva.ItemIndex:=1
                    else if DBEditTipoIva.Text = 'E' then
                        CBTipoIva.ItemIndex:=2
                        else if DBEditTipoIva.Text = 'R' then
                            CBTipoIva.ItemIndex:=3
                            else if DBEditTipoIva.Text = 'M' then
                                CBTipoIva.ItemIndex:=4;
    Finally
        fUpdating:=False;
    end;
end;

procedure TFAMCliente.DBEditTipoFacturaChange(Sender: TObject);
begin
    //Cambio del tipo de factura
    If FUpdating then Exit;
    fUpdating:=True;
    Try
        //Cambiar datos del control
        If DBEditTipoFactura.Text='A' then CBTipoFactura.Itemindex:=0 else CBTipoFactura.ItemIndex:=1;
    Finally
        fUpdating:=False;
    end;
end;

procedure TFAMCliente.CBFormularioEnter(Sender: TObject);
begin
    CBFormulario.Font.Color:=clMaroon;
end;

procedure TFAMCliente.CBFormularioExit(Sender: TObject);
begin
    CBFormulario.Font.Color:=clBlack;
end;

procedure TFAMCliente.CBTipoFacturaEnter(Sender: TObject);
begin
    CBTipoFactura.Font.Color:=clMaroon;
end;

procedure TFAMCliente.CBTipoFacturaExit(Sender: TObject);
begin
    CBTipoFactura.Font.Color:=clBlack;
end;

procedure TFAMCliente.RBDeCreditoEnter(Sender: TObject);
begin
    (Sender as TRadioButton).Font.Color:=clMaroon;
end;

procedure TFAMCliente.RBDePagoExit(Sender: TObject);
begin
    (Sender as TRadioButton).Font.Color:=clBlack;
end;

procedure TFAMCliente.FormActivate(Sender: TObject);
begin
    CENombre.SetFocus;
end;

procedure TFAMCliente.CEMorosidadEnter(Sender: TObject);
begin
    (Sender as TDBDateEdit).Color:=clGreen;
end;

procedure TFAMCliente.CEMorosidadExit(Sender: TObject);
begin
    (Sender as TDBDateEdit).Color:=clWhite;
    CEMorosidadChange(Sender);
end;


Function TFAMCliente.ValidatePost:Boolean;
begin
    //Valida los datos introducidos
    Result:=false;
    if length(CENombre.text) < 2 then
    begin
      Messagedlg(Application.Title,M_WRONG_DATA,mtError,[mbok],mbyes,0);
      CENombre.setfocus;
      exit;
    end;
    if length(CEPrimerApellido.text) < 2 then
    begin
      Messagedlg(Application.Title,M_WRONG_DATA,mtError,[mbok],mbyes,0);
      CEPrimerApellido.setfocus;
      exit;
    end;
    if length(CEDireccion.text) < 2 then
    begin
      Messagedlg(Application.Title,M_WRONG_DATA,mtError,[mbok],mbyes,0);
      CEDireccion.setfocus;
      exit;
    end;
    if length(CENumero.text) < 1 then
    begin
      Messagedlg(Application.Title,M_WRONG_DATA,mtError,[mbok],mbyes,0);
      CENumero.setfocus;
      exit;
    end;
    if length(CBProvincia.text) < 2 then
    begin
      Messagedlg(Application.Title,M_WRONG_DATA,mtError,[mbok],mbyes,0);
      CBProvincia.setfocus;
      exit;
    end;
    if length(CBLocalidad.text) < 2 then
    begin
      Messagedlg(Application.Title,M_WRONG_DATA,mtError,[mbok],mbyes,0);
      CBLocalidad.setfocus;
      exit;
    end;
    if length(CBCodposta.text) < 2 then
    begin
      Messagedlg(Application.Title,M_WRONG_DATA,mtError,[mbok],mbyes,0);
      CBCodposta.setfocus;
      exit;
    end;
    if length(CBPartido.text) < 2 then
    begin
      Messagedlg(Application.Title,M_WRONG_DATA,mtError,[mbok],mbyes,0);
      CBPartido.setfocus;
      exit;
    end;

    if cbIIBB.Checked then
    begin
      if CEIIBB.Text = '' then
      begin
        Messagedlg(Application.Title,M_INVALID_IIBB,mtError,[mbok],mbyes,0);
        CEIIBB.SetFocus;
        exit;
      end;
    end;

    Result:=True;
    If ((CBTipoIva.ItemIndex in [0,2,4]) and ((Length(CECUIT.Text)=0) or not(TCUIT.IsCorrect(CECUIT.Text)) or not (cuitcorrecto(CECUIT.Text))))
    then begin
        Result:=False;
        Messagedlg(Application.Title,M_NUM_CUIT_NOT_FOUND,mtInformation,[mbyes],mbyes,0);
    end
    else begin
        If CBTipoIva.ItemIndex in [0]
        then begin
            If ((CBTipoFactura.Itemindex=1) or (not(CBFormulario.Checked)))
            then
                REsult:=False;
        end
        else begin
            If (((Length(CECUIT.Text)>0) And not(TCUIT.IsCorrect(CECUIT.Text))))
            Then begin
                Result:=False;
                Messagedlg(Application.Title,M_NUM_CUIT_NOT_FOUND,mtInformation,[mbyes],mbyes,0);
            end
            else begin
                If ((CBTipoFactura.Itemindex=0) or (CBFormulario.Checked))
                then
                begin
                    Result:=False;
                    messagedlg(Application.Title,M_INVALID_DATA,mtInformation,[mbyes],mbyes,0);
                end;
            end;
        end;
    end;



    try
      UnCliente.ValueByName[FIELD_IDLOCALIDAD] := fLocalidad.ValueByName[FIELD_IDLOCALIDAD];
    except
      result := false;
    end;
end;

procedure TFAMCliente.CBProvinciaCloseUp(Sender: TObject);
begin
    CBProvincia.Value := LProvincias.ValueByName[CBProvincia.LookUpField];
end;

procedure TFAMCliente.CBPartidoCloseUp(Sender: TObject);
begin
    CBPartido.Value := LPartidos.ValueByName[CBPartido.LookUpField];
end;

procedure TFAMCliente.LISTATIPOCLIENTECloseUp(Sender: TObject);
begin
    LISTATIPOCLIENTE.Value := fTipoCliente.ValueByName[LISTATIPOCLIENTE.LookUpField];
end;

procedure TFAMCliente.CBLocalidadCloseUp(Sender: TObject);
begin
    CBLocalidad.Value := fLocalidad.ValueByName[CBLocalidad.LookUpField];
    if (cbProvincia.text <> 'CAPITAL FEDERAL') then
    begin
      CBLocalidadChange(CBLocalidad);
    end;
end;


procedure TFAMCliente.CBLocalidadChange(Sender: TObject);
begin
    if (cbProvincia.text <> 'CAPITAL FEDERAL') then
      CBCodposta.value := fLocalidad.CodPosta;
end;

procedure TFAMCliente.CBCodpostaChange(Sender: TObject);
begin
    if (cbProvincia.text <> 'CAPITAL FEDERAL') then
      CBLocalidad.value := fCPInterior.localidad;
end;

procedure TFAMCliente.CBCodpostaCloseUp(Sender: TObject);
begin
    if (cbProvincia.text <> 'CAPITAL FEDERAL') then
      CBCodposta.Value := fCPInterior.ValueByName[CBCodposta.LookUpField]
    else
      CBCodposta.Value := fCPCapital.ValueByName[CBCodposta.LookupField];
    CBCodpostaChange(CBCodposta);
end;

procedure TFAMCliente.CBLocalidadEnter(Sender: TObject);
begin
        DestacarControl (Sender, clGreen, clWhite, TRUE);
        if (Sender.ClassType = TRxDBLookupCombo) and
           (TRxDBLookupCombo(Sender).Name = 'CBLocalidad')
        then begin
            with (Sender as TRxDBLookupCombo) do
            begin
                Width := Width + 70;
            end;
            exit
        end
end;

procedure TFAMCliente.CBLocalidadExit(Sender: TObject);
begin
        AtenuarControl (Sender, TRUE);
        if (Sender.ClassType = TRxDBLookupCombo) and
           (TRxDBLookupCombo(Sender).Name = 'CBLocalidad')
        then begin
            with (Sender as TRxDBLookupCombo) do
            begin
                Width := Width - 70;
            end;
            exit
        end
end;

procedure TFAMCliente.btnBuscarLocClick(Sender: TObject);
begin
  with TfrmBuscaLocalidad.CreateFromBD(LProvincias.valuebyname[FIELD_CODPROVI]) do
    try
      showmodal;
    finally
      if localidad <> '' then CBLocalidad.Value := localidad;
      CBLocalidadChange(CBLocalidad);
      free;
    end;
end;



procedure TFAMCliente.cbIIBBClick(Sender: TObject);
begin
  if cbIIBB.checked then
    UnCliente.ValueByName[FIELD_EXENTO_IIBB] := 'S'
  else
    UnCliente.ValueByName[FIELD_EXENTO_IIBB] :='N';
end;

procedure TFAMCliente.CEAreaKeyPress(Sender: TObject; var Key: Char);
begin

If not (Key in ['0'..'9',#8]) then
 key:=#0;
end;

procedure TFAMCliente.BBOtrosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_SPACE then
  begin
    LPartidos.Filter := Format('WHERE %S = %S ORDER BY NOMBPART',[FIELD_CODPROVI,LProvincias.ValueByName[FIELD_CODPROVI]]);
    CBPartido.SetFocus;
  end
end;

procedure TFAMCliente.BBOtrosMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
LPartidos.Filter := Format('WHERE %S = %S ORDER BY NOMBPART',[FIELD_CODPROVI,LProvincias.ValueByName[FIELD_CODPROVI]]);
CBPartido.SetFocus;
end;

procedure TFAMCliente.BBOtrosClick(Sender: TObject);
begin
Perform (WM_NEXTDLGCTL, 0, 0)
end;

end.//Final de la unidad
