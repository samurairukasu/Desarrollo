unit ufFacturacionGNC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RXLookup, StdCtrls, ExtCtrls, Buttons, UCEdit, Mask, DBCtrls, UCDBEdit, globals,
  uSagClasses, uSagEstacion, uSagDominios, ucDialgs, Db, UTILORACLE,
  uInterfazUsuario, Acceso1, ugacceso, ufdatosPromocion, RxGIF, sqlexpr, provider,
  dbclient;

type
  TfrmFacturacionGNC = class(TForm)
    Bevel5: TBevel;
    Label9: TLabel;
    Bevel10: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel11: TBevel;
    Image5: TImage;
    Label8: TLabel;
    CBFacturarA: TComboBox;
    CBTipoDeIva: TComboBox;
    CBEsDeCredito: TComboBox;
    CBDescuentos: TRxDBLookupCombo;
    Panel13: TPanel;
    Panel6: TPanel;
    PTipoFactura: TPanel;
    Panel19: TPanel;
    Panel1: TPanel;
    Label24: TLabel;
    Label25: TLabel;
    CEAntiguo: TColorDBEdit;
    CENuevo: TColorDBEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Money: TImage;
    NoMoney: TImage;
    ctacte: TImage;
    visa: TImage;
    cheque: TImage;
    Bevel9: TBevel;
    Label1: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    Bevel2: TBevel;
    CENroPropietario: TColorEdit;
    CENombrePropietario: TColorEdit;
    CENroConductor: TColorEdit;
    CENombreConductor: TColorEdit;
    BBConductor: TBitBtn;
    CBTDPropietario: TComboBox;
    CBTDConductor: TComboBox;
    PTipoVerificacion: TPanel;
    srcVehiculos: TDataSource;
    srcDescuentos: TDataSource;
    PFormaDePago: TPanel;
    Panel4: TPanel;
    IFormaDePago: TImage;
    PInformativo: TPanel;
    BCancelar: TBitBtn;
    BContinuar: TBitBtn;
    Image4: TImage;
    procedure FormCreate(Sender: TObject);
    procedure CBTDConductorChange(Sender: TObject);
    procedure CENroConductorChange(Sender: TObject);
    procedure CENroConductorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CENroConductorKeyPress(Sender: TObject; var Key: Char);
    procedure CENroConductorMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure BBConductorClick(Sender: TObject);
    procedure CBFacturarAChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure CBEsDeCreditoChange(Sender: TObject);
    procedure CBEsDeCreditoClick(Sender: TObject);
    procedure CBEsDeCreditoEnter(Sender: TObject);
    procedure CBEsDeCreditoExit(Sender: TObject);
    procedure BContinuarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
  private
    { Private declarations }
    bValidate : Boolean;
    fVerificacion : tfVerificacion;
    fEstadoInsp : TEstadoInspGNC;
    fInspeccion,fAllInspections : TInspGNC;
    fUnaPatente, fPatente: TDominioNuevo;
    fVehiculo : TVehiculo;
    fDescuento : TDescuentoGNC;
    fPropietario, fConductor : TClientes;
    fFactura: TFacturacion;
    fPtoVenta: TPtoVenta;

    constructor CreateByPatente (const aPatente: TDominioNuevo; aCodinspe : string; aOperation: tfVerificacion);
    procedure SetOperacion (const aValue: tfVerificacion);
    procedure RellenaFormulario;
    procedure MostrarDatos_Cliente (var aCliente: TClientes; iTipoDocu: integer; sDocument: string);
    procedure Rellenar_DatosFacturas (aCliente: TClientes);
    function BoxManAcceptTheInspection (const WithFacture: boolean) : boolean;
    procedure GenerarInspeccion (const WithFacture : boolean);
    procedure GenerarFactura;
    function FacturaImpresa: boolean;
    function InspeccionPagada: boolean;
    function EnviadaInspeccionAlinea: boolean;
    procedure RegresaAlVehiculo;
    function datoscompletospago: boolean;
    function TipoDescuento : string;
  public
    { Public declarations }
     bOk : boolean;
    property Operacion: tfVerificacion read fVerificacion write SetOperacion;

  end;

    procedure DoFacturacionGNC (aOperation: tfVerificacion; aCodinspe : string);
    Function OnLineGNC(UnaPatente: TDominioNuevo; aDataBase: TSQLConnection):Boolean;
    procedure DoAMDeVehiculos(const UnaPatente : TDominioNuevo; var bSeguir : boolean; aOperation: tfVerificacion; aCodInspe: string);


var
  frmFacturacionGNC: TfrmFacturacionGNC;

implementation

{$R *.DFM}
uses
   ULOGS,
   UFTMP,
   uSagCuit,
   ufdominios,
   UFMantClientes,
   UFCajaGNC,ufPagoConCheque,ufPagoConTarjeta,
   UCTIMPRESION,
   UCLIENTE,
   uUtils;


resourcestring
        FILE_NAME = 'ufFacturacionGNC.PAS';

const
        CF_BY_TYPE : array [fvGNCRPA.. fvGNCRPAOK] of string =
        ('','','Pago Verificación GNC - RPA');
        CADENA_PROPIETARIO = 'Propietario';
        CADENA_CONDUCTOR = 'Conductor';
        MSJ_ON_LINE = 'Esta vehículo ya se Encuentra en Línea de Inspección GNC';
        MSJ_CAN_NOT_BILLING = '¡ Este Vehículo No Tiene una Inspección GNC Pendiente de Facturar !';
        M_NOCREDITO = ' El cliente no es de crédito.  No se puede facturar a Cuenta Corriente ';
        INSP_NO_FINALIZADA = 'N';
        CADENA_FACTURA_A = 'A';
        CADENA_FACTURA_B = 'B';
        CADENA_USA_VIGENTE = 'S';
        CADENA_NO_USA_VIGENTE = 'N';
        CADENA_SIN_VIGENTE = 'X';

Function OnLineGNC(UnaPatente: TDominioNuevo; aDataBase: TSQLConnection):Boolean;
var
      aq: TSQLDataSet;
      dsp : tDatasetprovider;
      cds : tClientDataSet;
begin
        //Comprueba si esta vehículo se encuentra ya la estación en linea
        Result:=False;
        aQ := TSQLDataSet.Create(Application);
        aQ.SQLConnection := aDataBase;
        aQ.CommandType := ctQuery;
        aQ.GetMetadata := false;
        aQ.NoMetadata := true;
        aQ.ParamCheck := false;

        dsp := TDataSetProvider.Create(Application);
        dsp.DataSet := aQ;
        dsp.Options := [poIncFieldProps,poAllowCommandText];

        cds:=TClientDataSet.Create(Application);

        With cds do
        Try
            SetProvider(dsp);
            CommandText := format('SELECT * FROM ESTADOINSPGNC WHERE MATRICUL = ''%S'' OR MATRICUL = ''%S'' ',[UnaPatente.Patente,UnaPatente.Complementaria]);
            Open;
            If RecordCount>0 then Result:=True;
        Finally
            Close;
            Free;
        end;

end;


procedure DoAMDeVehiculos(const UnaPatente : TDominioNuevo; var bSeguir : boolean; aOperation: tfVerificacion; aCodinspe : string);
var
        fFacturacionGNC : TfrmFacturacionGNC;
        FBusqueda : TFTmp;
begin
        FBusqueda := TFTmp.Create(Application);
        with FBusqueda do
        try
            MuestraClock('Presentación','Preparando los datos para ser presentados.');
            fFacturacionGNC := TfrmFacturacionGNC.CreateByPatente(UnaPatente,aCodinspe, aOperation);
            with fFacturacionGNC do
            try
                if bOk
                then begin
                   FBusqueda.Close;
                   FBusqueda.Free;
                   FBusqueda := nil;
                   fUnaPatente:= UnaPatente;
                   fFacturacionGNC.Operacion := aOperation;

                   If bValidate then
                     fFacturacionGNC.ShowModal;
                end
                else bSeguir := FALSE;
            finally
                fFacturacionGNC.Free;
            end;
        finally
            FBusqueda.Free;
        end;
end;


procedure DoFacturacionGNC(aOperation: tfVerificacion; aCodinspe: string);
var
        bContinuar : boolean;
        UnaPatente : TDominioNuevo;
begin

        DoRecogeVehiculo (aOperation, bContinuar, UnaPatente);
        while bContinuar do
        begin
            try
                If (Not (OnLineGNC(UnaPatente, MyBd)) or (aOperation=fvGNCRPAOk))
                Then
                    DoAMDeVehiculos(UnaPatente, bContinuar, aOperation, aCodinspe)
                else
                    Messagedlg(Application.Title,MSJ_ON_LINE,mtInformation,[mbok],mbok,0);
                if bContinuar
                then
                begin
                   DoRecogeVehiculo (aOperation, bContinuar, UnaPatente);
                end;
            except
                bContinuar := False;
            end;
        end;
end;

constructor TfrmFacturacionGNC.CreateByPatente(const aPatente: TDominioNuevo; aCodInspe : string; aOperation: tfVerificacion);
begin

        fFactura := nil;
        fPropietario := nil;
        fConductor := nil;
        fPtoVenta := nil;
        fAllInspections := nil;

        fPatente := TDominioNuevo.CreateBis(aPatente.Patente, aPatente.PerteneceA, aPatente.Complementaria);
        fVehiculo := TVehiculo.CreateByRowId (MyBD, fPatente.PerteneceA);
        fFactura := TFacturacion.CreateByRowid (MyBD,'');
        fPtoVenta:= TPtoVenta.Create(MyBD);

        fVerificacion:=aOperation;

        inherited Create (Application);
    end;

procedure TfrmFacturacionGNC.SetOperacion (const aValue: tfVerificacion);
begin
        bValidate := True;
        fEstadoInsp := nil;
        if bOk
        then begin
            try
                fVerificacion:=aValue;
                case aValue of
                    fvGNCRPA, fvGNCRPAOK:
                    begin
                        if aValue=fvGNCRPAOK
                        then begin
                            fEstadoInsp:=nil;
                            fEstadoInsp:=TEstadoInspGNC.CreateFromDatabase(MyBd,DATOS_ESTADOINSPGNC,Format(' WHERE A.MATRICUL = ''%S'' OR A.MATRICUL = ''%S''',[fvehiculo.valuebyname[FIELD_PATENTEN],fvehiculo.valuebyname[FIELD_PATENTEA]]));
                            fEstadoInsp.Open;
                            If ((fEstadoInsp.RecordCount=0) or (fEstadoInsp.ValueByName[FIELD_ESTADO][1]<>E_PENDIENTE_FACTURAR))
                            then begin
                                    Messagedlg(Caption,MSJ_CAN_NOT_BILLING,mtInformation,[mbok],mbok,0);
                                    bValidate := False;
                            end;

                            If bValidate
                            then begin
                                fInspeccion:=TInspGNC.CreateFromEstadoInspeccion(fEstadoInsp);
                                fInspeccion.Open;
                                fDescuento := TDescuentoGNC.CreateConVigente(MyBD,TipoDescuento);//******
                                fDescuento.Open;
                                srcDescuentos.DataSet := fDescuento.dataset;
                            end;
                        end;

                        // CAPTION E ICONO DE LA FICHA
                        Caption := CF_BY_TYPE[aValue];

                        // PANEL TIPO DE VERIFICACION
                        PTipoVerificacion.Caption := S_TIPO_VERIFICACION[aValue];
                        PTipoVerificacion.Font.Color := clBlack;

                        case CBEsDeCredito.ItemIndex of
                             0:begin
                                PFormaDePago.Caption := ' Contado';
                                PFormaDePago.Font.Color := clOlive;
                                IFormaDePago.Picture := Money.Picture;
                             end;
                             1:begin
                                PFormaDePago.Caption := ' Tarjeta';
                                PFormaDePago.Font.Color := clNavy;
                                IFormaDePago.Picture := Visa.Picture;
                             end;
                             2:begin
                                PFormaDePago.Caption := ' Cuenta Cte';
                                PFormaDePago.Font.Color := clRed;
                                IFormaDePago.Picture := ctacte.Picture;
                             end;
                             3:begin
                                PFormaDePago.Caption := ' Cheque';
                                PFormaDePago.Font.Color := clPurple;
                                IFormaDePago.Picture := cheque.Picture;
                             end;

                        end;
                    end;

                    fvGNCRC:
                    begin

                        // CAPTION E ICONO DE LA FICHA
                        Caption := CF_BY_TYPE[aValue];

                        // PANEL TIPO DE VERIFICACION
                        PTipoVerificacion.Caption := S_TIPO_VERIFICACION[aValue];
                        PTipoVerificacion.Font.Color := clBlue;
//                        ITipoInspeccion.Picture := Preverificacion.Picture;

                    end;
                end
            except
                on E: Exception do
                begin
                    fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error inicializanco el formulario de recepcion por :%s',[E.Message]);
                    MessageDlg(Caption,Format('Error inicializando el formulario de recepcion: %s. Si el error persiste indíquelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk],mbOk,0);
                    bOk := False
                end
            end
        end
end;



procedure TfrmFacturacionGNC.FormCreate(Sender: TObject);
begin
//         fOldDateFormat := ShortDateFormat;
         try
            srcVehiculos.DataSet := fVEhiculo.DataSet;
            CBFacturarA.ItemIndex := CBFacturarA.Items.IndexOf (CADENA_PROPIETARIO);
            CBEsDeCredito.ItemIndex := 0;
            PFormaDePago.Caption := ' Contado';
            PFormaDePago.Font.Color := clOlive;
            IFormaDePago.Picture := Money.Picture;
            RellenaFormulario;
            bOk := TRUE;
         except
            on E: Exception do
            begin
                MessageDlg(Caption,Format('Error inicializando el formulario de Facturación GNC: %s. Comience de nuevo y si el error persiste, indíquelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk],mbOk,0);
                fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error inicializanco el formulario de mantenimiento de vehículos por :%s',[E.message]);
                bOk := FALSE;
            end
         end;
end;

procedure TfrmFacturacionGNC.RellenaFormulario;
    var
      a,b: TNotifyEvent;

begin
      a := CENroPropietario.OnChange;
      b := CENroConductor.OnChange;
      try
        fVehiculo.Open;
        PInformativo.Caption := Format('%S: %S',[fVarios.ValueByName[FIELD_IDENCONC], DateBD(MyBD)]);

        if fVehiculo.IsNew
        then begin
            fVehiculo.Append;
            fVehiculo.ValueByName[FIELD_PATENTEN] := fPatente.Patente;
            fVehiculo.ValueByName[FIELD_PATENTEA] := fPatente.Complementaria;
            fVehiculo.ValueByName[FIELD_NUMEJES] := IntToStr(EJES_MINIMOS);
            fVehiculo.ValueByName[FIELD_TIPOESPE] := '';
            fVehiculo.ValueByName[FIELD_TIPODEST] := '';
            fVehiculo.ValueByName[FIELD_CODMARCA] := '';
            fVehiculo.ValueByName[FIELD_CODMODEL] := '';
            fVehiculo.ValueByname[FIELD_FECMATRI] := '';
            fVehiculo.ValueByname[FIELD_ANIOFABR] := '';
            fVehiculo.ValueByName[FIELD_NUMBASTI] := '';
            fVehiculo.ValueByName[FIELD_NUMMOTOR] := '';
            fVehiculo.ValueByName[FIELD_NCERTGNC] := '';
            fVehiculo.ValueByName[FIELD_ERROR] := '';
            fVehiculo.ValueByName[FIELD_TIPOGAS] := '';
            CBTDPropietario.ItemIndex := 0;
        end
        else begin

          fVehiculo.Edit;
          CENroPropietario.OnChange := nil;
          CENroConductor.OnChange := nil;

          fAllInspections := fVehiculo.GetHistoriaGNC;
          fAllInspections.Open;
          fAllInspections.Last;

          if fAllInspections.RecordCount > 0
          then begin
                fPropietario := fAllInspections.GetPropietario;
                fConductor := fAllInspections.GetConductor;
                fPropietario.Open;
                fConductor.Open;

                CBTDPropietario.ItemIndex := CBTDPropietario.Items.IndexOf (fPropietario.ValueByName[FIELD_TIPODOCU]);
                CENroPropietario.Text := fPropietario.ValueByName[FIELD_DOCUMENT];
                CENombrePropietario.Text := fPropietario.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];

                CBTDConductor.ItemIndex := CBTDConductor.Items.IndexOf (fConductor.ValueByName[FIELD_TIPODOCU]);
                CENroConductor.Text := fConductor.ValueByName[FIELD_DOCUMENT];
                CENombreConductor.Text := fConductor.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
                BBConductor.Enabled := True;
                Rellenar_DatosFacturas (fPropietario);
          end;
        end;
      finally
           CENroPropietario.OnChange := a;
           CENroConductor.OnChange := b;
      end;
end;



procedure TfrmFacturacionGNC.CBTDConductorChange(Sender: TObject);
begin
        with CENroConductor do
        begin
            Text := ''; Color := clWindow; Enabled := TRUE
        end;
end;

procedure TfrmFacturacionGNC.CENroConductorChange(Sender: TObject);
begin
        CENombreConductor.Text := '';
        if ((Length((SEnder as TColorEdit).Text) > 0) and (CBTDConductor.ItemIndex<>-1))
        then begin
                try
                    BBConductor.Enabled := FALSE;
                    Label2.Font.Color:=clBlack;
                    if (TTipoDocumento(CBTDConductor.ItemIndex) <> ttdCUIT) or
                       ((TTipoDocumento(CBTDConductor.ItemIndex) = ttdCUIT) and (TCUIT.IsCorrect((Sender as TColorEdit).Text)))
                    then begin
                        fConductor.Free;
                        fConductor := nil;
                        fConductor := TClientes.CreateFromCode(MyBD,CBTDConductor.Items[CBTDConductor.ItemIndex],(Sender as TColorEdit).Text);
                        fConductor.Open;
                        BBConductor.Enabled := TRUE;
                        if (fConductor.RecordCount <> 0) then
                        begin
                            CBTDConductor.ItemIndex := CBTDConductor.Items.IndexOf (fConductor.ValueByName[FIELD_TIPODOCU]);
                            CENroConductor.Text := fConductor.ValueByName[FIELD_DOCUMENT];
                            CENombreConductor.Text := fConductor.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
                        end
                    end
                    else begin
                        Label2.Font.Color:=clRed;
                        BBConductor.Enabled := FALSE;
                    end;
                except
                    on E: Exception do
                        MessageDlg('Identificación del Cliente',Format('Esta fallando la introducción de datos del cliente por: %s. Compruebe que los datos introducidos son correctos. Si el error persiste indíquelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk], mbOk, 0)
                end
        end
        else BBConductor.Enabled := FALSE

end;

procedure TfrmFacturacionGNC.CENroConductorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    if (Shift = [ssCtrl])
    then (Sender as TColorEdit).Clear;
end;

procedure TfrmFacturacionGNC.CENroConductorKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = Char(VK_SPACE)
        then Key := #0
end;

procedure TfrmFacturacionGNC.CENroConductorMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    If CBTDConductor.ItemIndex<>4
    Then
        (Sender as TColorEdit).Hint:='Número de documento del condcutor del vehículo'
    else
        (Sender as TColorEdit).Hint:='Número de documento del conductor del vehículo."00-00000000-0"';

end;

procedure TfrmFacturacionGNC.BBConductorClick(Sender: TObject);
begin
    MostrarDatos_Cliente (fConductor, CBTDConductor.ItemIndex, CENroConductor.Text);
    if Assigned(fConductor)
    then CENombreConductor.Text := fConductor.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
    CBFacturarAChange(CBFacturarA);
end;

procedure TfrmFacturacionGNC.MostrarDatos_Cliente (var aCliente: TClientes; iTipoDocu: integer; sDocument: string);
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

procedure TfrmFacturacionGNC.CBFacturarAChange(Sender: TObject);
begin
        if ((Sender as tcombobox).ItemIndex = 0)
        then  Rellenar_DatosFacturas (fPropietario)
        else if ((Sender as tcombobox).ItemIndex = 1)
            then Rellenar_DatosFacturas (fConductor);

end;

procedure TfrmFacturacionGNC.Rellenar_DatosFacturas (aCliente: TClientes);
    var
      i: integer;
      sLetra: string;

begin
        If not assigned(aCliente) Then Exit;


        if fVerificacion in [fvGNCRPAOK]
        then begin
            for i := 0 to CBTipoDeIVA.Items.Count do
            begin
                sLetra := Copy (CBTipoDeIVA.Items[i],1,1);
                if (sLetra = aCliente.ValueByName[FIELD_TIPTRIBU]) then
                begin
                    CBTipoDeIVA.ItemIndex := i;
                    break;
                end
            end;

            PTipoFactura.Caption := aCliente.ValueByName[FIELD_TIPFACTU];
            if (aCliente.ValueByName[FIELD_CREDITCL] = INSPECCION_FINALIZADA) then         //Si es de crédito
            begin
              PFormaDePago.Caption := ' Cuenta Cte';
              PFormaDePago.Font.Color := clRed;
              IFormaDePago.Picture := ctacte.Picture;
              CBEsDeCredito.itemindex:=2
            end
            else
            begin
              CBEsDeCredito.itemindex:=0;
              PFormaDePago.Caption := ' Contado';
              PFormaDePago.Font.Color := clOlive;
              IFormaDePago.Picture := Money.Picture;
            end;
        end;
end;

procedure TfrmFacturacionGNC.FormKeyPress(Sender: TObject; var Key: Char);
begin
        if key = ^M
        then begin
            Perform(WM_NEXTDLGCTL,0,0);
            Key := #0
        end
end;

procedure TfrmFacturacionGNC.FormDestroy(Sender: TObject);
begin
//        ShortDateFormat := fOldDateFormat;
        fPatente.Free;
        fAllInspections.Free;
        fInspeccion.Free;
        fVehiculo.Free;
        fPropietario.Free;
        fConductor.Free;
        if assigned(fFactura.ffactadicionales) then fFactura.ffactadicionales.Free;
        fFactura.Free;
        fPtoventa.Free;
        if assigned(FDescuento) then
          fDescuento.Free;

end;

procedure TfrmFacturacionGNC.CBEsDeCreditoChange(Sender: TObject);
var aCliente: TClientes;
begin
     case CBFacturarA.ItemIndex of
        0: aCliente := fPropietario;
        1: aCliente := fConductor;
        else aCliente := nil;
     end;
     case CBEsDeCredito.ItemIndex of
        0: begin
            PFormaDePago.Caption := ' Contado';
            PFormaDePago.Font.Color := clOlive;
            IFormaDePago.Picture := Money.Picture;
        end;
        1: begin
            PFormaDePago.Caption := ' Tarjeta';
            PFormaDePago.Font.Color := clNavy;
            IFormaDePago.Picture := Visa.Picture;
        end;
        2: begin
            PFormaDePago.Caption := ' Cuenta Cte';
            PFormaDePago.Font.Color := clRed;
            IFormaDePago.Picture := ctacte.Picture;
        end;
        3: begin
            PFormaDePago.Caption := ' Cheque';
            PFormaDePago.Font.Color := clPurple;
            IFormaDePago.Picture := Cheque.Picture;
        end;
        end;

     if  (aCliente <> nil) and (aCliente.ValueByName[FIELD_CREDITCL] = 'N') and (CBEsDeCredito.itemindex = 2) then
     begin
       MessageDlg (Application.Title, M_NOCREDITO, mtError, [mbOk],mbOk,0);
       CBEsDeCredito.itemindex := 0;
       PFormaDePago.Caption := ' Contado';
       PFormaDePago.Font.Color := clOlive;
       IFormaDePago.Picture := Money.Picture;
     end;


end;

procedure TfrmFacturacionGNC.CBEsDeCreditoClick(Sender: TObject);
begin
    case CBEsDeCredito.ItemIndex of
        0: begin
            PFormaDePago.Caption := ' Contado';
            PFormaDePago.Font.Color := clOlive;
            IFormaDePago.Picture := Money.Picture;
        end;
        1: begin
            PFormaDePago.Caption := ' Tarjeta';
            PFormaDePago.Font.Color := clNavy;
            IFormaDePago.Picture := Visa.Picture;
        end;
        2: begin
            PFormaDePago.Caption := ' Cuenta Cte';
            PFormaDePago.Font.Color := clRed;
            IFormaDePago.Picture := ctacte.Picture;
        end;
        3: begin
            PFormaDePago.Caption := ' Cheque';
            PFormaDePago.Font.Color := clPurple;
            IFormaDePago.Picture := Cheque.Picture;
        end;

        end;

end;

procedure TfrmFacturacionGNC.CBEsDeCreditoEnter(Sender: TObject);
begin
        DestacarControl (Sender, clGreen, clWhite, FALSE);
end;

procedure TfrmFacturacionGNC.CBEsDeCreditoExit(Sender: TObject);
begin
        AtenuarControl(Sender, FALSE);
end;


procedure TfrmFacturacionGNC.BContinuarClick(Sender: TObject);
var
        FBusqueda: TFTmp;
begin
            fbusqueda:= TFTmp.create(application);
                      if fPtoVenta.EsCaja then
                      begin
                        with fbusqueda do
                        muestraclock('Facturación','Preparando los datos para imprimir factura...');
                        if BoxManAcceptTheInspection(TRUE)
                        then begin
                             if (fptoventa.GetTipo = TIPO_CF) or ((fptoventa.GetTipo = TIPO_MANUAL) and FacturaImpresa)
                             then begin
                                fbusqueda.Close;
                                if InspeccionPagada
                                then begin
                                    if EnviadaInspeccionALinea
                                    then
                                    begin
                                      ModalResult := mrOk;
                                    end
                                    else begin
                                        MessageDlg(Caption,'El Vehículo No Pudo Ser Enviado a la Linea de Inspección',mtInformation,[mbYes],mbYes,0);
                                    end
                                end
                                else begin
                                    MessageDlg(Caption,'El Importe De La Factura No Fue Cobrado',mtInformation,[mbYes],mbYes,0);
                                end
                            end
                            else begin
                                fbusqueda.Close;
                                MessageDlg(Caption,'La Factura No Pudo Imprimirse',mtInformation,[mbYes],mbYes,0);
                                RegresaAlVehiculo;
                            end;
                        end
                        else begin
                                fbusqueda.Close;
                                MessageDlg(Caption,'La Factura No Pudo Imprimirse',mtInformation,[mbYes],mbYes,0);
                                MessageDlg(Caption,'No Se Quiso Imprimir, o Se Generó Mal La Inspección y La Factura',mtInformation,[mbYes],mbYes,0);
                                RegresaAlVehiculo;
                        end;
                      end   //
                      else MessageDlg(Caption,'Esta PC no está habilitada para facturar',mtError,[mbYes],mbYes,0);
end;

function TfrmFacturacionGNC.BoxManAcceptTheInspection (const WithFacture: boolean) : boolean;
    var
        bFueOK : boolean;
        aCliente: Tclientes;
begin
        bFueOk := FALSE;
        try
            fInspeccion.START;
            try
                if WithFacture
                then begin
                    GenerarFactura;
                    if fEstadoInsp=nil then GenerarInspeccion(WithFacture)
                    else begin
                        fInspeccion.Close;  //agregado para cuando tiraba error al cancelar
                        fInspeccion.Open;
                        fInspeccion.Edit;
                        fInspeccion.ValueByName[FIELD_CODFACTU] := fFactura.ValueByName[FIELD_CODFACTU];
                        if (fInspeccion.ValueByName[FIELD_CODINSPE] = '') and (fInspeccion.LlevaCombo(fVehiculo.valuebyname[FIELD_CODVEHIC]) <> '0') then
                          fInspeccion.ValueByName[FIELD_CODINSPE] := fInspeccion.LlevaCombo(fVehiculo.valuebyname[FIELD_CODVEHIC]);
                        if fVerificacion=fvReverificacion then fInspeccion.ValueByName[FIELD_TIPO] :=  Chr(Ord(fVerificacion) +65);    //***************
                        fInspeccion.Post(true);
                    end;
                    fFactura.SetImportesGNC(StrToInt(fInspeccion.ValueByName[FIELD_EJERCICI]), StrToInt(fInspeccion.ValueByName[FIELD_CODINSPGNC]), fverificacion, ffactura.ffactadicionales.valuebyname[FIELD_CODDESCU]);  //***********

                   if DatosCompletosPago then
                   begin
                    if fptoventa.getTipo = TIPO_MANUAL then
                    begin            //MODIF RAN
                      ffactura.ffactadicionales.close;
                      if not fFactura.VerImprimirFacturaGNC (True, NIL)
                      then begin
                          fInspeccion.ROLLBACK;
                          bFueOk := FALSE;
                      end
                      else begin
                        if fInspeccion.ValueByName[FIELD_CODINSPE] = '-1' then
                          fInspeccion.ValueByName[FIELD_CODINSPE] := IntToStr(fInspeccion.GetValorSecuenciador);
                        fInspeccion.Post(True,True);
                        bFueOk := TRUE;
                      end
                    end
                    else
                      if fptoventa.getTipo = TIPO_CF then
                      begin
                      ffactura.ffactadicionales.close;
                      case CBFacturarA.ItemIndex of
                           0: aCliente := fPropietario;
                           1: aCliente := fConductor;
                      end;
                      if not fFactura.ImprimirFacturaCF(acliente,CBTipoDeIva.itemindex)
                      then begin
                          fInspeccion.ROLLBACK;
                          bFueOk := FALSE;
                      end
                      else begin
                        if fInspeccion.ValueByName[FIELD_CODINSPE] = '-1' then
                          fInspeccion.ValueByName[FIELD_CODINSPE] := IntToStr(fInspeccion.GetValorSecuenciador);
                        fInspeccion.Post(True,True);
                        bFueOk := TRUE;
                      end
                      end
                      else
                      begin
                        fInspeccion.ROLLBACK;
                        bFueOk := FALSE;
                        messagedlg(Caption,'El Punto de Venta conectado a su PC no es el correcto.'+#13
                        +'Por favor, realice las correcciones necesarias y vuelva a intentarlo.'+#13+
                        'Si el error persiste, comuníquelo al Jefe de Planta', mtError, [mbOk],mbOk,0);
                      end;
                   end
                   else
                   begin
                        fInspeccion.ROLLBACK;
                        bFueOk := FALSE;
                        messagedlg(Caption,'Faltan completar datos del Pago', mtError, [mbOk],mbOk,0);  //*********
                   end;

                end
                else begin
                    GenerarInspeccion(WithFacture);
                    if fInspeccion.ValueByName[FIELD_CODINSPE] = '-1' then
                          fInspeccion.ValueByName[FIELD_CODINSPE] := IntToStr(fInspeccion.GetValorSecuenciador);
                    fInspeccion.Post(True,True);
                    bFueOk := TRUE;
                end;
            except
                bFueOk := FALSE;
                fInspeccion.ROLLBACK;
                MessageDlg(Caption,'Falta completar datos de la inspección',mtInformation,[mbOk],mbOk,0);
            end;
        finally
            result := bFueOk;
        end;
end;

procedure TfrmFacturacionGNC.GenerarInspeccion (const WithFacture : boolean);
begin

        If Finspeccion.DataSet.State In [dsEdit,dsInsert]
            Then Finspeccion.Cancel;
        fInspeccion.Append;
        fInspeccion.ValueByName[FIELD_CODVEHIC] := fVehiculo.ValueByName[FIELD_CODVEHIC];
        fInspeccion.ValueByName[FIELD_CODCLIEN] := fPropietario.ValueByName[FIELD_CODCLIEN];
        fInspeccion.ValueByName[FIELD_CODCLCON] := fConductor.ValueByName[FIELD_CODCLIEN];
        fInspeccion.ValueByName[FIELD_INSPFINA] := INSP_NO_FINALIZADA;
        if WithFacture
        then fInspeccion.ValueByName[FIELD_CODFACTU] := fFactura.ValueByName[FIELD_CODFACTU];

        fInspeccion.ValueByName[FIELD_TIPO] := Chr(Ord(fVerificacion) +65);    //***********
        fInspeccion.Post(TRUE);
end;

procedure TfrmFacturacionGNC.GenerarFactura;
var   usuario:tusuario;
      idusuario:smallint;
begin
//        fFactura.Open;
//        if fFactura.DataSet.State in [dsEdit,dsInsert]
//        then fFactura.Cancel;

        ffactura.Close;  //agregado cuando tiraba error al cancelar
        ffactura := TFacturacion.CreateByRowId(mybd,'');
        ffactura.open;

        fFactura.Append;
        case CBFacturarA.ItemIndex of
            0: begin
                fFactura.ValueByName[FIELD_CODCLIEN] := fPropietario.ValueByName[FIELD_CODCLIEN];
                fFactura.ValueByName[FIELD_TIPOCLIENTE_ID] := fPropietario.ValueByName[FIELD_TIPOCLIENTE_ID];
            end;
            1: begin
                fFactura.ValueByName[FIELD_CODCLIEN] := fConductor.ValueByName[FIELD_CODCLIEN];
                fFactura.ValueByName[FIELD_TIPOCLIENTE_ID] := fConductor.ValueByName[FIELD_TIPOCLIENTE_ID];
            end;
        end;

        case CBEsDeCredito.ItemIndex of
             0:begin
                    fFactura.ValueByName[FIELD_FORMPAGO] := FORMA_PAGO_METALICO;
             end;
             1:begin
                    fFactura.ValueByName[FIELD_FORMPAGO] := FORMA_PAGO_TARJETA;
             end;
             2:begin
                    fFactura.ValueByName[FIELD_FORMPAGO] := FORMA_PAGO_CREDITO;
             end;
             3:begin
                    fFactura.ValueByName[FIELD_FORMPAGO] := FORMA_PAGO_CHEQUE;
             end;
        end;

        fFactura.ValueByName[FIELD_IMPRESA]  := FACTURA_NO_IMPRESA;
        fFactura.ValueByName[FIELD_TIPFACTU] := PTipoFactura.Caption; // A ó B
        fFactura.ValueByName[FIELD_TIPTRIBU] := Copy(CBTipoDeIVA.Items[CBTipoDeIVA.ItemIndex],1,1); // I, N, C, E, R, M
        fFactura.ValueByName[FIELD_ERROR] := FACTURA_ERRONEA;
        fFactura.ValueByName[FIELD_IVANOINS] := '0';
        if (fFactura.ValueByName[FIELD_TIPFACTU] = FACTURA_TIPO_A) and (fFactura.ValueByName[FIELD_TIPTRIBU] = IVA_NO_INSCRIPTO)
        then fFactura.ValueByName[FIELD_IVANOINS] := fVarios.ValueByName[FIELD_IVANOINS];
        fFactura.ValueByName[FIELD_IVAINSCR] := fVarios.ValueByName[FIELD_IVAINSCR];
        fFactura.ValueByName[FIELD_IIBB] := '0'; 

        fFactura.Post(TRUE);
        fFactura.Refresh;

        try fFactura.ffactAdicionales.Open;
        except
              on E: Exception do
                    MessageDlg(Caption,Format('Error en la tabla: %s. Si el error persiste indíquelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk],mbOk,0);
        end;

        if fFactura.ffactAdicionales.DataSet.State in [dsEdit,dsInsert] then
          fFactura.ffactAdicionales.Cancel;
        try fFactura.ffactAdicionales.append
        except
              on E: Exception do
                    MessageDlg(Caption,Format('Error en la tabla: %s. Si el error persiste indíquelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk],mbOk,0);
        end;
        try
          fFactura.ffactAdicionales.valuebyname[FIELD_CODFACT]:=fFactura.ValueByName[FIELD_CODFACTU];
          usuario:=gestorseg.BuscarUsuario(applicationuser);
          idusuario:=usuario.obteneruid;
          fFactura.ffactAdicionales.valuebyname[FIELD_IDUSUARI]:= inttostr(idusuario);
          fFactura.ffactAdicionales.valuebyname[FIELD_PTOVENT]:= inttostr(FPtoventa.GetPtoVenta);
          if CBDescuentos.Text <> 'Cliente sin descuento' then
            fFactura.ffactAdicionales.ValueByName[FIELD_CODDESCU]:= FDescuento.ValueByName[FIELD_CODDESCU];

          IF fFactura.ffactAdicionales.valuebyname[FIELD_PTOVENT] = '-1' then
          begin
             raise Exception.Create (' Ha ocurrido una falla en el cálculo del número de Punto de Venta. Compruebe que el Controlador sea el correcto y funcione');
          end;

          fFactura.ffactAdicionales.valuebyname[FIELD_TIPOFAC]:=TIPO_FACTURAGNC;
          if fFactura.TieneDescuentognc(fFactura.ffactAdicionales.ValueByName[FIELD_CODDESCU]) then
          begin
            if fDescuento.ValueByName[FIELD_PRESCOMPROB] = 'S' then
              dodatosPromocion(ffactura.valuebyname[FIELD_CODFACTU], ffactura.valuebyname[FIELD_CODCLIEN], fDescuento.valuebyname[FIELD_CODDESCU],TIPO_GNC)
          end
          else
          ffactura.ffactadicionales.ValueByName[FIELD_CODDESCU]:='';

          if fFactura.ValueByName[FIELD_FORMPAGO] = FORMA_PAGO_TARJETA then
          begin
            CreateFromBD (ffactura, true);
          end
          else
            if fFactura.ValueByName[FIELD_FORMPAGO] = FORMA_PAGO_CHEQUE then
            begin
              DoPagoConCheque(ffactura.valuebyname[FIELD_CODFACTU], fConductor.valuebyname[FIELD_CODCLIEN])
            end;
        except
              on E: Exception do
              begin
                    MessageDlg(Caption,Format('Error: %s. Si el error persiste indíquelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk],mbOk,0);
                    fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FILE_NAME,'Ha ocurrido una falla en el cálculo del número de Punto de Venta')
              end;
        end;
        fFactura.ffactAdicionales.post(TRUE);
end;

function TfrmFacturacionGNC.FacturaImpresa: boolean;
    var
        dCabecera: tCabecera;
        iServicio: tTrabajo;
        bTodoOk : boolean;
begin
        result := FALSE;
        try
            with dCabecera do
            begin
                iCodigoInspeccion := StrToInt(fInspeccion.ValueByName[FIELD_CODINSPGNC]);
                iEjercicio := StrToInt(fInspeccion.ValueByName[FIELD_EJERCICI]);
                sMatricula := fVehiculo.GetPatente;

                if (fFactura.ValueByName[FIELD_TIPFACTU] = CADENA_FACTURA_A)
                then iServicio := Factura_A_GNC
                else iServicio := Factura_B_GNC;

                bTodoOk := TrabajoEnviadoOk (dCabecera, iServicio);
                if bTodoOk
                then begin
                    fFactura.Refresh;
                    fFactura.DevolverNumeroFactura(TIPO_FACTURAGNC);
                    result := TRUE;
                end;
            end
        except
            result := FALSE;
        end;
end;

    // True si el cliente ha pagado la inspeccion

function TfrmFacturacionGNC.InspeccionPagada: boolean;
    var
        aCliente : TClientes;
        ivacompr:integer;       //
        fDescuAplicado: TDescuentoGNC;
begin
        // Nombre del cliente
        aCliente := nil;

        case CBFacturarA.ItemIndex of
            0: aCliente := fPropietario;
            1: aCliente := fConductor;
        end;

        fDescuAplicado := TDescuentoGNC.CreateFromCoddescu(MyBd,fDescuento.valuebyname[FIELD_CODDESCU]);
        fDescuAplicado.open;

        with TFrmCajaGNC.CreateFromBD (fFactura, aCliente, fVehiculo, fdescuAplicado) do
        try
            ivacompr:=cbtipodeiva.ItemIndex;
            if (ivacompr = 0) or (ivacompr = 1) or (ivacompr = 3)or (ivacompr = 4)or (ivacompr = 5) then
            begin
                if CuitCorrecto(acliente.valuebyname[FIELD_CUIT_CLI]) then
                    result := Execute
                else
                    raise exception.Create('CUIT incorrecto');
            end
              else  result := Execute;

        finally
            Free;
        end;
end;

function TfrmFacturacionGNC.EnviadaInspeccionALinea;
    var
        aQ: TSQLQuery;
begin
        try
                aQ:=TSQLQuery.Create(self);
                with aQ do
                Try
                    SQL.Clear;
                    SQLConnection:=MyBD;
                    SQL.Add ('UPDATE ESTADOINSPGNC ' +
                             'SET ' +
                             'ESTADO = ''' +V_ESTADOS_INSP [teFacturado]+''''+
                             ' WHERE EJERCICI = ' + fEstadoInsp.ValueByName[FIELD_EJERCICI]+
                             ' AND CODINSPGNC = '+fEstadoInsp.ValueByName[FIELD_CODINSPGNC]);
                    ExecSql;
                    result := TRUE;
                 Finally
                    try
                      MyBD.Commit(td);
                    Except
                    end;
                    Close;
                    Free;
                    fEstadoInsp.Free;
                    fEstadoInsp:=nil;
                end;

        except
            result := FALSE;
        end;
end;

procedure TfrmFacturacionGNC.RegresaAlVehiculo;
    var
        aRowId : string;
begin
        aRowid := fVehiculo.ValueByName[FIELD_ROWID];
        fVehiculo.Free;
        fVehiculo := TVehiculo.CreateByRowId(MyBD,aRowId);
        SrcVehiculos.DataSet := fVehiculo.DataSet;
        fVehiculo.Open;
        fVehiculo.Edit;
end;

function TfrmFacturacionGNC.datoscompletosPago: boolean;
var fPromocion: TDatosPromocion;
begin
  result:=true;

  if fFactura.TieneDescuentoGNC(ffactura.ffactadicionales.valuebyname[FIELD_CODDESCU]) then
  begin
     if fDescuento.ValueByName[FIELD_PRESCOMPROB] = 'S' then
     begin
       fPromocion:=nil;
       try
          fPromocion:=TDatosPromocion.CreateFromFactura(MyBd,ffactura.valuebyname[FIELD_CODFACTU],ffactura.valuebyname[FIELD_CODCLIEN],fdescuento.valuebyname[FIELD_CODDESCU]);
          fPromocion.Open;
          if fPromocion.RecordCount > 0 then
          begin
            if (fPromocion.valuebyname[FIELD_NROCUPON]='') then
            begin
              result:=false;
              exit;
            end;
          end
          else
          begin
            result:=false;
            exit;
          end;
       finally
         fPromocion.free;
       end;
     end;
  end;
end;

function TfrmFacturacionGNC.TipoDescuento : string;
var
  fInspVTV : tInspeccion;
begin
  result := '';

  fInspVTV := nil;
  try
    fInspVTV := fVehiculo.GetUltimoVencimiento;
    fInspVTV.Open;
    if (fInspeccion.ValueByName[FIELD_CODINSPE] <> '') or (fInspeccion.LlevaCombo(fvehiculo.valuebyname[FIELD_CODVEHIC]) <> '0') then
      result := CADENA_NO_USA_VIGENTE      //Tiene una inspeccion asociada (COMBO)
    else
        if (fInspVTV.recordcount > 0) and (fInspVTV.InspeccionVigente) then
           result := CADENA_USA_VIGENTE    //Tiene una inspeccion vigente
        else
           result := CADENA_SIN_VIGENTE;   //No tiene inspeccion asociada ni vigente

  finally
    fInspVTV.free;
  end;
end;

procedure TfrmFacturacionGNC.BCancelarClick(Sender: TObject);
begin
        fVehiculo.Cancel;
        ModalResult := mrCancel;
end;

end.



