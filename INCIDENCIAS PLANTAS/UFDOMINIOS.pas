unit UFDominios;

interface

    uses
        Windows,
        Messages,
        SysUtils,
        Classes,
        Graphics,
        Controls,
        Forms,
        Dialogs,
        ExtCtrls,
        StdCtrls,
        UCEdit,
        Buttons,
        USAGESTACION,
        USAGDOMINIOS, ImgList, RxGIF;


    type
        TFDominios = class(TForm)
            Panel1: TPanel;
            CEDominio: TColorEdit;
            CEAntiguo: TColorEdit;
            CENuevo: TColorEdit;
            Label1: TLabel;
            Bevel1: TBevel;
            Label2: TLabel;
            Label3: TLabel;
            Image1: TImage;
            Bevel2: TBevel;
            Label4: TLabel;
            Label5: TLabel;
            Panel2: TPanel;
            Image3: TImage;
            Bevel3: TBevel;
            Panel3: TPanel;
            Image2: TImage;
            BContinuar: TBitBtn;
            BCancelar: TBitBtn;
            ILIconos: TImageList;
            procedure FormKeyPress(Sender: TObject; var Key: Char);
            procedure CEDominioExit(Sender: TObject);
            procedure CEDominioKeyPress(Sender: TObject; var Key: Char);
            procedure BContinuarClick(Sender: TObject);
            procedure FormCreate(Sender: TObject);
            procedure FormDestroy(Sender: TObject);
            procedure CEAntiguoExit(Sender: TObject);
    procedure CEDominioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
        private
            { Private declarations }
            fVerificacion : tfVerificacion;
            PatenteAntigua : TDominioAntiguo;
            function PatentesActualizadas : boolean;
            procedure BusquedaDePatente (const aPatente: string);
            procedure SetOperacion (const aValue: tfVerificacion);
        public
            { Public declarations }
            PatenteNueva : TDominioNuevo;
            property Operacion : tfVerificacion read fVerificacion write SetOperacion;
        end;


    var
        FDominios: TFDominios;
        Ignorar: Boolean;

    procedure DoRecogeVehiculo (const aOperation: tfVerificacion; var bOk: boolean; var aPatente : TDominioNuevo);

implementation

{$R *.DFM}

    uses
        UCDIALGS,
        UFTMP,
        GLOBALS,
        USAGCLASSES;

    const
        CAPTIONS_BY_TYPE : array [fvNormal..fvGNCRPAOK] of string =
        ('Nueva Verificación: NORMAL', 'Nueva Verificacion: PREVERIFICACIÓN',
         'Nueva Verificación: GRATUITA', 'Nueva Verificacion: VOLUNTARIA',
         'Nueva Verificación: REVERIFICACION',
         'Regresa Vehículo: STAND-BY', 'Regresa Vehículo: PREVERIFICACIÓN PAGADA',
         'Mantenimiento de vehículos','','Nueva Verificación: GNC - RPA','Nueva Verificación: GNC - RC','Pago Verificación GNC - RPA');


    procedure TFDominios.SetOperacion (const aValue: tfVerificacion);
    begin
        case avalue of
           fvNormal, fvStandBy, fvPreverificacionOK, fvMantenimiento: ILIconos.GetIcon(Ord(fvNormal), Icon);
           else ILIconos.GetIcon(Ord(aValue), Icon);
        end;

        Caption := CAPTIONS_BY_TYPE[aValue]

    end;

    procedure TFDominios.FormKeyPress(Sender: TObject; var Key: Char);
    begin
        if ((key = ^M) and not(Ignorar))
        then begin
            Perform(WM_NEXTDLGCTL,0,0);
            Key := #0
        end
    end;

    procedure TFDominios.CEDominioKeyPress(Sender: TObject; var Key: Char);
    begin
        if Key = Char(VK_SPACE)
        then Key := #0;
           
        if Key = Char(VK_RETURN)
        then begin
        end;
    end;

    function TFDominios.PatentesActualizadas : boolean;
    var
        ExisteYa: boolean;
        aDominio : tDominio;
    begin
        Result := FALSE;
        aDominio := nil;
        FTmp.Temporizar(True,True,'Búsqueda | Actualización.','Comprobando que las patentes son únicas en la planta...');
        try
            ExisteYa := FALSE;

            Application.ProcessMessages;

            if CENuevo.ReadOnly
            then begin
                if CEAntiguo.ReadOnly
                then begin
                    Result := TRUE;
                    exit
                end
                else aDominio := PatenteAntigua
            end
            else if CEAntiguo.ReadOnly
                then aDominio := PatenteNueva;

            if aDominio.PerteneceA = ''
            then begin
                if TVehiculo.RespetadaUnicidadPatentes(MyBD,aDominio)
                then begin
                    Result := TRUE;
                    Exit
                end
                else begin
                    Result := FALSE;
                    MessageDlg(Caption,Format('La patente: %s pertenece a otro vehículo.',[aDominio.Patente]),mtInformation,[mbOK],mbOk,0);
                    Exit
                end
            end
            else begin
                case TVehiculo.UpdatePatentes(MyBD, aDominio, ExisteYa) of
                    0: begin
                        if ExisteYa
                        then begin
                            Result := FALSE;
                            MessageDlg(Caption,Format('La patente: %s pertenece a otro vehículo.',[aDominio.Patente]),mtInformation,[mbOK],mbOk,0);
                            Exit
                        end
                        else result := TRUE;
                    end;
                    -1: begin
                        MessageDlg(Caption,Format('No se pueden actualizar las patentes del vehículo ya que la patente: %s pertenece a otro. Si se trata del mismo vehículo recepcioneló con la otra patente. Si el error persiste consulte a su jefe de planta.',[aDominio.Patente]),mtWarning,[mbOK], mbOk,0);
                        Result := FALSE;
                        Exit;
                    end;
                end;
            end;
        finally
            FTmp.Temporizar(False,True,'','');
        end;
    end;


    procedure TFDominios.BusquedaDePatente(const aPatente: string);
    var
        fBusqueda: TFTmp;
    begin
        FTmp.Temporizar(True,True,'Búsqueda','Buscando Patentes');
        fBusqueda:=TFTmp.Create(nil);
        try
            try
                case TDominio.TipoDominio(aPatente) of

                    ttdmAutos,ttdmMotos, ttdmTractor:    //mb:
                    begin
                        PatenteNueva := TDominioNuevo.Create(MyBD, aPatente);
                        PatenteAntigua := TDominioAntiguo.CreateBis(PatenteNueva.Complementaria,PatenteNueva.PerteneceA,PatenteNueva.Patente)
                    end;

                    ttdmAntiguo:
                    begin
                        PatenteAntigua := TDominioAntiguo.Create(MyBD, aPatente);
                        PatenteNueva := TDominioNuevo.CreateBis(PatenteAntigua.Complementaria,PatenteAntigua.PerteneceA,PatenteAntigua.Patente)
                    end;

                    else raise Exception.Create('El Formato de la patente es desconocido.');
                end;

                CENuevo.Text := PatenteNueva.Patente;
                CEAntiguo.Text := PatenteAntigua.Patente;
                CENuevo.ReadOnly := Length(CENuevo.Text) <> 0;
                CEAntiguo.ReadOnly := Length(CEAntiguo.Text) <> 0;

                if not CEAntiguo.ReadOnly
                then begin
                    CEAntiguo.FondoColor := clGreen;
                end;

                if not CENuevo.ReadOnly
                then begin
                    CENuevo.FondoColor := clGreen;
                end;

                if PatenteNueva.PerteneceA <> ''
                then begin
                    if CENuevo.ReadOnly and CEAntiguo.ReadOnly
                    then begin
                        BContinuar.Enabled := True;
                        FTmp.Temporizar(False,True,'','');
                        fBusqueda.Caption := 'Recepción';
                        fBusqueda.LEstado.Caption := 'Vehículo encontrado. Patentes COMPLETAS.';
                        fBusqueda.BOk.Visible := True;
                        fBusqueda.ShowModal;
                        ModalResult := mrOk
                    end
                    else begin
                        BContinuar.Enabled := True;
                        FTmp.Temporizar(False,True,'','');
                        fBusqueda.Caption := 'Recepción';
                        fBusqueda.LEstado.Caption := 'Vehículo encontrado. Puede faltar alguna patente.';
                        fBusqueda.BOk.Visible := True;
                        fBusqueda.ShowModal;
                   end
                end
                else begin
                    BContinuar.Enabled := True;
                    FTmp.Temporizar(False,True,'','');
                    fBusqueda.Caption := 'Recepción';
                    fBusqueda.LEstado.Caption := 'Vehículo nuevo en la planta. Puede faltar alguna patente.';
                    fBusqueda.BOk.Visible := True;
                    fBusqueda.ShowModal;
                end;
            except
                on E: Exception do
                begin
                    BContinuar.Enabled := False;
                    FTmp.Temporizar(False,True,'','');
                    MessageDlg('Error en la Búsqueda', Format('Se ha producido un error mientras se buscaba el vehículo en la planta. Si el error persiste indíquelo al Jefe de Planta. Error: %s',[E.message]),mtError,[mbOk],mbOk,0);
                    ModalResult := mrCancel
                end
            end
        finally
            fBusqueda.Free;
            FTmp.Temporizar(False,True,'','');
            Ignorar:=false;
        end
    end;

    procedure TFDominios.CEDominioExit(Sender: TObject);
    begin
        if (Trim(CEDominio.Text) <> '') and (TDominio.TipoDominio(Trim(CEDominio.Text)) in [ttdmAntiguo, ttdmAutos, ttdmMotos, ttdmTractor])     //mb
        then begin
                CEDominio.Enabled := False;
                CEDominio.Color := clGray;
                try
                    Enabled := False;
                    BusquedaDePatente(Trim(CEDominio.Text))
                finally
                    Enabled := True;
                    Enabled := True;
                    if not CEAntiguo.ReadOnly
                    then CEAntiguo.SetFocus
                    else if not CENuevo.ReadOnly
                        then CENuevo.SetFocus
                        else if BContinuar.Enabled
                            then BContinuar.SetFocus;
                    Show;
               end;
        end
        else if Trim(CEDominio.Text) <> ''
            then begin
                ShowMessage(Caption, 'El formato escrito no puede ser reconocido por el sistema');
                BCancelar.SetFocus
            end
    end;

    procedure TFDominios.BContinuarClick(Sender: TObject);
    var
        bSalir : boolean;
        TA, TN : tTipoDominio;
    begin
        bSalir := FALSE;
        TA := TDominio.TipoDominio(CEAntiguo.Text);
        TN := TDominio.TipoDominio(CENuevo.Text);
        if (TA <> ttdmNull) and (TN <> ttdmNull) and (TABLA_COMBINACIONES_OK[TA,TN])
        then begin
            PatenteNueva.Patente := CENuevo.Text;
            PatenteNueva.Complementaria := CEAntiguo.Text;

            PatenteAntigua.Patente := CEAntiguo.Text;
            PatenteAntigua.Complementaria := CENuevo.Text;

            try
                Enabled := FALSE;
                bSalir := PatentesActualizadas
            finally
                Enabled := TRUE;
                Show;
                if bSalir
                then ModalResult := mrOk
            end;

        end
        else ShowMessage(Caption,'La combinación de formatos elegida, no es correcta.');
    end;

    procedure TFDominios.FormCreate(Sender: TObject);
    begin
        Application.HintHidePause := 10000;
        PatenteAntigua := nil;
        PatenteNueva := nil;
        LiberarMemoria;
    end;

    procedure TFDominios.FormDestroy(Sender: TObject);
    begin
        Application.HintHidePause := 2500;
        PatenteAntigua.Free;
        PatenteNueva.Free;
    end;

    procedure TFDominios.CEAntiguoExit(Sender: TObject);
    begin
        if TDominio.TipoDominio(CEAntiguo.Text) = ttdmAntiguo
        then CEAntiguo.Text := Format('%s%.7d',[CEAntiguo.Text[1],StrToInt(Copy(CEAntiguo.Text,2,Length(CEAntiguo.Text)))])
    end;

    procedure DoRecogeVehiculo (const aOperation: tfVerificacion; var bOk: boolean; var aPatente : TDominioNuevo);
    var
        FormDominios : TFDominios;
    begin
        bOk := False;
        FormDominios := TFDominios.Create(nil);
        with FormDominios do
        try
            Operacion := aOperation;
            bOk := ShowModal = mrOK;
            if bOK
            then aPatente := TDominioNuevo.CreateBis(PatenteNueva.Patente, PatenteNueva.PerteneceA, PatenteNueva.Complementaria)
        finally
            FormDominios.Free
        end
    end;

procedure TFDominios.CEDominioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    //Buscar
    If Key=vk_return
    then begin
            Ignorar:=True;
            if (Trim(CEDominio.Text) <> '') and (TDominio.TipoDominio(Trim(CEDominio.Text)) in [ttdmAntiguo, ttdmAutos, ttdmMotos, ttdmTractor])     //mb
            then begin
                    CEDominio.Enabled := False;
                    CEDominio.Color := clGray;
                    try
                        Enabled := False;
                        BusquedaDePatente(Trim(CEDominio.Text));
                    finally
                        Enabled := True;
                        if not CEAntiguo.ReadOnly
                        then CEAntiguo.SetFocus
                        else if not CENuevo.ReadOnly
                            then CENuevo.SetFocus
                            else if BContinuar.Enabled
                                then BContinuar.SetFocus;
                        Show;
                    end;
            end
            else if Trim(CEDominio.Text) <> ''
                then begin
                    ShowMessage(Caption, 'El formato escrito no puede ser reconocido por el sistema');
                    BCancelar.SetFocus
                end;
    end;
end;

procedure TFDominios.FormActivate(Sender: TObject);
begin
    Ignorar:=False;
end;

end.
