 unit UFRECEPGNC;

interface

    uses
        Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
        ExtCtrls, RXCtrls, StdCtrls, UCEdit, Mask, ToolEdit, RXSpin,
        Buttons, RXLookup, Db, DBCtrls, UCDBEdit,
        UCDIALGS,
        USAGFABRICANTE,
        USAGCLASSES,
        USAGDOMINIOS,
        USAGCLASIFICACION,
        Animate,
        GIFCtrl, RXDBCtrl, sqlexpr, UtilOracle, USAGESTACION,
        uUtils, RxGIF, provider, dbclient;

    type
        TFrmRecepGNC = class(TForm)
            Panel5: TPanel;
            BContinuar: TBitBtn;
            BCancelar: TBitBtn;
            DSToTMarcas: TDataSource;
            DSToTModelos: TDataSource;
            DSToTGEspecies: TDataSource;
            DSToTEspecies: TDataSource;
            DSToTGDestinos: TDataSource;
            DSToTDestinos: TDataSource;
            DSToTVehiculos: TDataSource;
            Label7: TLabel;
            Bevel2: TBevel;
            Label1: TLabel;
            Bevel9: TBevel;
            CBTDPropietario: TComboBox;
            CENroPropietario: TColorEdit;
            CENombrePropietario: TColorEdit;
            BBPropietario: TBitBtn;
            Bevel13: TBevel;
            Label22: TLabel;
            Label23: TLabel;
            Bevel14: TBevel;
            Label24: TLabel;
            Label25: TLabel;
            Bevel15: TBevel;
            Label26: TLabel;
            Label27: TLabel;
            Label28: TLabel;
            Bevel16: TBevel;
            Label29: TLabel;
            Label30: TLabel;
            Label31: TLabel;
            Label32: TLabel;
            Label33: TLabel;
            Bevel17: TBevel;
            Label34: TLabel;
            Bevel18: TBevel;
            Label35: TLabel;
            Bevel19: TBevel;
            Label36: TLabel;
            Bevel21: TBevel;
            Label37: TLabel;
            Label38: TLabel;
            Label39: TLabel;
            Bevel22: TBevel;
            Bevel23: TBevel;
    Label13: TLabel;
    Bevel5: TBevel;
    Label14: TLabel;
    Bevel6: TBevel;
    Bevel8: TBevel;
    SEMinusMas: TRxSpinButton;
    Image1: TImage;
    Bevel1: TBevel;
    CEAntiguo: TColorDBEdit;
    CENuevo: TColorDBEdit;
    CEMotor: TColorDBEdit;
    CEBastidor: TColorDBEdit;
    CEFabricado: TColorDBEdit;
    SEEjes: TColorDBEdit;
    CBCombustible: TComboBox;
    BBMarca: TBitBtn;
    BBModelo: TBitBtn;
    CBMarca: TRxDBLookupCombo;
    CBModelo: TRxDBLookupCombo;
    CECodigoEspecie: TColorDBEdit;
    CECodigoDestino: TColorDBEdit;
    CBGrupoEspecie: TRxDBLookupCombo;
    CBTipoEspecie: TRxDBLookupCombo;
    CBGrupoDestino: TRxDBLookupCombo;
    CBTipoDestino: TRxDBLookupCombo;
    DEMatriculado: TDBDateEdit;
    EsOficial: TDBCheckBox;
    Panel15: TPanel;
    Sirena: TRxGIFAnimator;
    EDCERTNC: TColorDBEdit;
    Panel1: TPanel;
    PTipoVerificacion: TPanel;
    PInformativo: TPanel;
    Panel2: TPanel;
    Image2: TImage;
    Bevel3: TBevel;
    Bevel4: TBevel;
    CBTDConductor: TComboBox;
    CENroConductor: TColorEdit;
    CENombreConductor: TColorEdit;
    Label2: TLabel;
    BBConductor: TBitBtn;

            // Cambio de foco al pulsar enter
            procedure FormKeyPress(Sender: TObject; var Key: Char);

            // Creación e inicialización del Formulario con valores por defecto
            procedure FormCreate(Sender: TObject);

            // Proceso general en el evento OnEnter, salvo para ColorEdit, y DateEdit
            procedure CBMarcaEnter(Sender: TObject);

            // Proceso general en el evento OnExit, salvo para ColorEdit, y DateEdit
            procedure CBMarcaExit(Sender: TObject);

            // Proceso general cuando cambia el codigo de la marca
            procedure CBMarcaChange(Sender: TObject);

            // Inserción de una nueva marca
            procedure BBMarcaMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
            procedure BBMarcaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

            // Inserción de un nuevo modelo
            procedure BBModeloMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
            procedure BBModeloKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

            // Control de tabulación, escape, y enter en el date edit
            procedure DEMatriculadoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);


            // Seleción de selección de fecha de matriculación
            procedure CEMatriculadoClick(Sender: TObject);
            procedure CEMatriculadoKeyPress(Sender: TObject; var Key: Char);

            // Filtro de teclas, deja pasar números, borrado, cursores ->, <-, y backspace
            procedure CEFabricadoKeyPress(Sender: TObject; var Key: Char);

            // Inicialización por defecto con la fecha de matriculación
            procedure CEFabricadoEnter(Sender: TObject);

            // Anulación de teclas para la inserción del número de ejes
            procedure SEEjesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
            procedure FormDestroy(Sender: TObject);

            procedure CBGrupoEspecieChange(Sender: TObject);
            procedure CBTipoEspecieChange(Sender: TObject);
            procedure CEMotorKeyPress(Sender: TObject; var Key: Char);
            procedure CBMarcaCloseUp(Sender: TObject);
            procedure CECodigoEspecieChange(Sender: TObject);
            procedure CBGrupoEspecieCloseUp(Sender: TObject);
            procedure BContinuarClick(Sender: TObject);
            procedure BCancelarClick(Sender: TObject);
            procedure BBMarcaClick(Sender: TObject);
            procedure CBTipoEspecieCloseUp(Sender: TObject);
            procedure SEMinusMasTopClick(Sender: TObject);
            procedure SEMinusMasBottomClick(Sender: TObject);
            procedure SEEjesKeyPress(Sender: TObject; var Key: Char);
            procedure CEMotorExit(Sender: TObject);
            procedure CBModeloCloseUp(Sender: TObject);
            procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
            procedure DEMatriculadoExit(Sender: TObject);
            procedure DEMatriculadoChange(Sender: TObject);
            procedure EsOficialClick(Sender: TObject);
            procedure CBTDPropietarioChange(Sender: TObject);
            procedure CENroPropietarioExit(Sender: TObject);
            procedure CENroPropietarioKeyDown(Sender: TObject; var Key: Word;
                      Shift: TShiftState);
            procedure CENroPropietarioMouseMove(Sender: TObject;
                      Shift: TShiftState; X, Y: Integer);
            procedure BBPropietarioClick(Sender: TObject);
            procedure SetOperacion (const aValue: tfVerificacion);
            procedure CENroPropietarioChange(Sender: TObject);
            procedure CBCombustibleChange(Sender: TObject);
    procedure CBTDConductorChange(Sender: TObject);
    procedure CENroConductorChange(Sender: TObject);
    procedure CENroConductorExit(Sender: TObject);
    procedure CENroConductorMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure BBConductorClick(Sender: TObject);
    procedure EDCERTNCKeyPress(Sender: TObject; var Key: Char);
        private
            { Private declarations }
            bCanClose : boolean;
            fOldDateFormat : string;
            fPatente : TDominioNuevo;
            fVehiculo : TVehiculo;
            fMarcas: TMarcas;
            fModelos: TModelos;
            fGEspecies: TGVehicularesEspecie;
            fGDestinos: TGVehicularesDestino;
            fDestinos : TTDestinos;
            fEspecies : TTEspecies;
            fInspGNC, fAllInspectionsGNC : TInspGNC;
            fAllInspections : Tinspeccion;
            fPropietario, fConductor : TClientes;
            fEstadoInsp : TEstadoInspGNC;
            fVerificacion : tfVerificacion;
            procedure NuevaMarca;
            procedure NuevoModelo;
            procedure RellenaFormulario;
            procedure MostrarDatos_Cliente (var aCliente: TClientes; iTipoDocu: integer; sDocument: string);
            procedure GenerarInspeccion;
            function DatosEquipo : boolean;
            function EnviadaInspeccionAlinea: boolean;
            function ValidatePost:boolean;
        public
            bOk : boolean;
            fCertificado : string;
            constructor CreateByPatente (const aPatente: TDominioNuevo; aCodinspe : string);
            property Operacion: tfVerificacion read fVerificacion write SetOperacion;
        end;


    var
        FrmRecepGNC: TFrmRecepGNC;


    procedure DoRecepGNC (aOperation: tfVerificacion; aCodinspe : string);
    Function OnLineGNC(UnaPatente: TDominioNuevo; aDataBase: TSQLConnection):Boolean;
    procedure DoAMDeVehiculos(const UnaPatente : TDominioNuevo; var bSeguir : boolean; aOperation: tfVerificacion; aCodInspe: string);

implementation

{$R *.DFM}
    uses
        DateUtil,
        ULOGS,
        UFTMP,
        GLOBALS,
        UFDOMINIOS,
        UINTERFAZUSUARIO,
        UFINSERTMARCASMODELOS,
        USAGCUIT, UFMANTCLIENTES, ufDatosEquipoGNC;

    resourcestring
        FILE_NAME = 'UFRecepGNC.PAS';
        MSJ_INVALID_DATE = '¡ Fecha no Valida !, La Fecha No Puede Ser Mayor a La Actual';
        INSP_NO_FINALIZADA = 'N';
        MSJ_ON_LINE = 'Esta vehículo ya se Encuentra en Linea de Inspección GNC';
        MSJ_DATOS_CLIENTE = 'Los datos del propietario no están completos';        
        M_FALTAPROP = 'Es obligatorio introducir el propietario del vehículo';
        M_FALTACOND = 'Es obligatorio introducir el conductor del vehículo';
        M_FALTCOMBUSTIBLE = 'Es obligatorio introducir el tipo de combustible del vehículo';
        M_FALTACERTIFICADO = 'Es obligatorio introducir el nro de certificado anterior';
        M_FALTADESTINO = 'Es obligatorio introducir un destino para el vehículo';
        M_FALTAESPECIE = 'Es obligatorio introducir una especie para el vehículo';                
const
        CF_BY_TYPE : array [fvGNCRPA..fvGNCRC] of string =
        ('Nueva Verificación: GNC - RPA', 'Nueva Verificación: GNC - RC');

var
  vCodinspe : string;

Function OnLineGNC(UnaPatente: TDominioNuevo; aDataBase: TSQLConnection):Boolean;
var
        aQ : TSQLDataSet;
        dsp : tDatasetprovider;
        cds : tClientDataSet;
begin
        //Comprueba si este vehículo se encuentra ya la estación en linea
        Result:=False;
        aQ := TSQLDataSet.Create(application);
        aQ.SQLConnection := MyBD;
        aQ.CommandType := ctQuery;
        aQ.GetMetadata := false;
        aQ.NoMetadata := true;
        aQ.ParamCheck := false;

        dsp := TDataSetProvider.Create(application);
        dsp.DataSet := aQ;
        dsp.Options := [poIncFieldProps,poAllowCommandText];

        cds:=TClientDataSet.Create(application);
        With cds do
        Try
            SetProvider(dsp);
            commandtext := Format('SELECT * FROM ESTADOINSPGNC WHERE MATRICUL = ''%S'' OR MATRICUL = ''%S'' ',[UnaPatente.Patente,UnaPatente.Complementaria]);
            Open;
            If RecordCount>0 then Result:=True;
        Finally
            Close;
            Free;
            dsp.free;
            aq.free;
        end;

end;


procedure DoAMDeVehiculos(const UnaPatente : TDominioNuevo; var bSeguir : boolean; aOperation: tfVerificacion; aCodinspe : string);
var
        FAMVehiculos : TFrmRecepGNC;
        FBusqueda : TFTmp;
begin
        FBusqueda := TFTmp.Create(Application);
        with FBusqueda do
        try
            MuestraClock('Presentación','Preparando los datos para ser presentados.');
            FAMVehiculos := TFrmRecepGNC.CreateByPatente(UnaPatente,aCodinspe);
            with FAMVehiculos do
            try
                if bOk
                then begin
                   FBusqueda.Close;
                   FBusqueda.Free;
                   FBusqueda := nil;
                   FAMVehiculos.Operacion := aOperation;
                   FAMVehiculos.ShowModal;
                end
                else bSeguir := FALSE;
            finally
                FAMVehiculos.Free;
            end;
        finally
            FBusqueda.Free;
        end;
end;


procedure DoRecepGNC(aOperation: tfVerificacion; aCodinspe: string);
var
        bContinuar : boolean;
        UnaPatente : TDominioNuevo;
begin
        DoRecogeVehiculo (aOperation, bContinuar, UnaPatente);
        while bContinuar do
        begin
            try

                If Not OnLineGNC(UnaPatente, MyBd)
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


constructor TFrmRecepGNC.CreateByPatente(const aPatente: TDominioNuevo; aCodInspe : string);
begin

        fVehiculo := nil;
        fModelos := nil;
        fMarcas := nil;
        fGEspecies := nil;
        fGDestinos := nil;
        fEspecies := nil;
        fDestinos := nil;
        fAllInspections := nil;
        fAllInspectionsGNC := nil;
        fPropietario := nil;
        fConductor := nil;
        fEstadoInsp := nil;
        fPatente := TDominioNuevo.CreateBis(aPatente.Patente, aPatente.PerteneceA, aPatente.Complementaria);

        fVehiculo := TVehiculo.CreateByRowId (MyBD, fPatente.PerteneceA);
        fMarcas := TMarcas.Create(MyBD,'');
        fModelos := TModelos.Create(MyBD);

        fGEspecies := TGVehicularesEspecie.Create(MyBD);
        fEspecies := TTEspecies.Create(MyBD);

        fGDestinos := TGVehicularesDestino.Create(MyBD);
        fDestinos := TTDestinos.Create(MyBD);

        fInspGNC := TInspGNC.CreateByRowId (MyBD,'');
        vCodinspe := aCodinspe;
        inherited Create (Application);

        if vCodinspe <> '' then
          ActivarComponentes(false,self,[1,2,3]);
    end;

    procedure TFrmRecepGNC.NuevoModelo;
    var
        ValorDeModelos, ValorDeMarcas : string;
    begin
        ValorDeMarcas := CBMarca.Value;
        ValorDeModelos := CBModelo.Value;
        fModelos.Marca := CBMarca.Text;
        fModelos.CodMarca := StrToInt(ValorDeMarcas);
        if InsercionDeMarcasModelos (fModelos)
        then CBModelo.Value := fModelos.ValueByName[CBModelo.LookupField]
        else begin
             fMarcas.Refresh;
             CBMarca.Value := ValorDeMarcas;
             CBModelo.Value := ValorDeModelos;
        end;
    end;

    procedure TFrmRecepGNC.NuevaMarca;
    var
        ValorDeModelos, ValorDeMarcas : string;
    begin
        ValorDeMarcas := CBMarca.Value;
        ValorDeModelos := CBModelo.Value;
        if InsercionDeMarcasModelos (fMarcas)
        then CBMarca.Value := fMarcas.ValueByName[CBMarca.LookupField]
        else begin
            fMarcas.Refresh;
            CBMarca.Value := ValorDeMarcas;
            CBModelo.Value := ValorDeModelos;
        end
end;


procedure TFrmRecepGNC.FormCreate(Sender: TObject);
begin
//         fIncidencias.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'entra ufrecepgnc '+inttostr(cursores));
         fOldDateFormat := ShortDateFormat;
         try
            bCanClose := FALSE;
            ShortDateFormat := 'dd/mm/yyyy';
            DSToTVehiculos.DataSet := fVEhiculo.DataSet;
            DSToTMarcas.DataSet := fMarcas.DataSet;
            DSToTModelos.DataSet := fModelos.DataSet;
            DSToTGEspecies.DataSet := fGEspecies.DataSet;
            DSToTEspecies.DataSet := fEspecies.DataSet;
            DSToTGDestinos.DataSEt := fGDestinos.DataSet;
            DSToTDestinos.DataSet := fDestinos.DataSet;

            RellenaFormulario;
            bOk := TRUE;
         except
            on E: Exception do
            begin
                MessageDlg(Caption,Format('Error inicializando el formulario de Recepción de Datos GNC: %s. Comience de nuevo y si el error persiste, indíquelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk],mbOk,0);
                fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error inicializanco el formulario de mantenimiento de vehículos por :%s',[E.message]);
                bOk := FALSE;
            end
         end;
end;

    procedure TFrmRecepGNC.FormDestroy(Sender: TObject);
    begin
        ShortDateFormat := fOldDateFormat;
        fPatente.Free;
        fVehiculo.Free;
        fModelos.Free;
        fMarcas.Free;
        fGEspecies.Free;
        fGDestinos.Free;
        fEspecies.Free;
        fDestinos.Free;
        fInspGNC.Free;
        fAllInspections.Free;
        fPropietario.Free;
        fConductor.Free;        
        if Assigned(fAllInspectionsGNC) then fAllInspectionsGNC.free;
//        fIncidencias.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'sale ufrecepgnc '+inttostr(cursores));
    end;

    procedure TFrmRecepGNC.FormKeyPress(Sender: TObject; var Key: Char);
    begin
        if key = #27
        then key := #0
        else if key = ^M
            then begin
                Perform(WM_NEXTDLGCTL,0,0);
                Key := #0
            end
    end;

    procedure TFrmRecepGNC.CBMarcaEnter(Sender: TObject);
    begin
        DestacarControl (Sender, clGreen, clWhite, TRUE);

        if (Sender.ClassType = TRxDBLookupCombo) and
           ((TRxDBLookupCombo(Sender).Name = 'CBGrupoDestino') or
            (TRxDBLookupCombo(Sender).Name = 'CBTipoEspecie')  or
            (TRxDBLookupCombo(Sender).Name = 'CBTipoDestino')
           )
        then begin
            with (Sender as TRxDBLookupCombo) do
            begin
                Width := Width + 50;
                if Name = 'CBTipoDestino'
                then Left := Left - 71
                else if Name = 'CBGrupoDestino'
                    then Width := Width + 70;
            end;
            exit
        end
    end;

    procedure TFrmRecepGNC.CBMarcaExit(Sender: TObject);
    begin
        AtenuarControl(Sender, TRUE);

        if (Sender.ClassType = TRxDBLookupCombo) and
           ((TRxDBLookupCombo(Sender).Name = 'CBGrupoDestino') or
            (TRxDBLookupCombo(Sender).Name = 'CBTipoEspecie')  or
            (TRxDBLookupCombo(Sender).Name = 'CBTipoDestino')
           )
        then begin
            with (Sender as TRxDBLookupCombo) do
            begin
                Width := Width - 50;
                if Name = 'CBTipoDestino'
                then Left := Left + 71
                else if Name = 'CBGrupoDestino'
                    then Width := Width - 70;
            end;
            exit
        end
    end;

    procedure TFrmRecepGNC.CBMarcaCloseUp(Sender: TObject);
    begin
        CBMarca.Value := fMarcas.ValueByName[CBMarca.LookUpField];
        CBMarcaChange(Sender);
    end;

    procedure TFrmRecepGNC.CBModeloCloseUp(Sender: TObject);
    begin
        CBModelo.Value := fModelos.ValueByName[CBModelo.LookUpField];
    end;

    procedure TFrmRecepGNC.CBMarcaChange(Sender: TObject);
    begin
        if CBMarca.Text <> ''
        then begin
            fModelos.Filter := Format('WHERE CODMARCA = %s',[CBMarca.Value]);
            CBModelo.Enabled := TRUE;
            BBModelo.Enabled := TRUE;
        end
        else begin
            CBModelo.Value := '';
            CBModelo.Enabled := FALSE;
            BBModelo.Enabled := FALSE;
        end
    end;

    procedure TFrmRecepGNC.BBMarcaMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    begin
        NuevaMarca;
        Perform (WM_NEXTDLGCTL, 0, 0);
    end;

    procedure TFrmRecepGNC.BBMarcaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    begin
        if Key = VK_SPACE
        then begin
            NuevaMarca;
            Perform (WM_NEXTDLGCTL, 0, 0)
        end
    end;

    procedure TFrmRecepGNC.BBModeloMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    begin
        NuevoModelo;
        Perform (WM_NEXTDLGCTL, 0, 0)
    end;

    procedure TFrmRecepGNC.BBModeloKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    begin
        if Key = VK_SPACE then
        begin
            NuevoModelo;
            Perform (WM_NEXTDLGCTL, 0, 0)
        end;
    end;

    procedure TFrmRecepGNC.CEMatriculadoClick(Sender: TObject);
    begin
        DEMatriculado.DoClick;
    end;

    procedure TFrmRecepGNC.CEMatriculadoKeyPress(Sender: TObject; var Key: Char);
    begin
        DEMatriculado.DoClick;
    end;

    procedure TFrmRecepGNC.DEMatriculadoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    begin
        if key in [VK_ESCAPE, VK_RETURN, VK_TAB]
        then Perform (WM_NEXTDLGCTL, 0, 0)
    end;

    procedure TFrmRecepGNC.CEFabricadoEnter(Sender: TObject);
    begin
        if Trim(CEFabricado.Text) = ''
        then if (DEMatriculado.Text <> '  /  /    ') and ValidDate(DEMatriculado.Date)
            then CEFabricado.Text := IntToStr(ExtractYear(DEMatriculado.Date))
    end;

    procedure TFrmRecepGNC.CEFabricadoKeyPress(Sender: TObject; var Key: Char);
    begin
        if not (Key in ['0','1','2','3','4','5','6','7','8','9',#37,#39,#46,#8])
        then key := #0
    end;

    procedure TFrmRecepGNC.SEEjesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    begin
        if Key = VK_DOWN
        then SEMinusMasBottomClick(Sender)
        else if Key = VK_UP
            then SEMinusMasTopClick(Sender)
            else Key := ORD(#0)
    end;

    procedure TFrmRecepGNC.CECodigoEspecieChange(Sender: TObject);
    var
        a,b,c,d: tNotifyEvent;
    begin
        a := CBTipoEspecie.OnChange;
        b := CBGrupoEspecie.OnChange;
        c := CBTipoDestino.OnChange;
        d := CBGrupoDestino.OnChange;
        try
            CBTipoEspecie.OnChange := nil;
            CBGrupoEspecie.OnChange := nil;
            CBTipoDestino.OnChange := nil;
            CBGrupoDestino.OnChange := nil;

            case (Sender as TControl).Tag of

                3: //Especie
                begin
                    fEspecies.FiltraPorCodigo (CECodigoEspecie.Text);
                    CBTipoEspecie.Value := CECodigoEspecie.Text;
                    if CBTipoEspecie.Text <> ''
                    then begin
                        CBGrupoEspecie.Value := fEspecies.ValueByName[CBGrupoEspecie.LookupField];
                        CBTipoEspecie.Enabled := TRUE;
                    end
                    else begin
                        CBGrupoEspecie.Value := '';
                        CBTipoEspecie.Enabled := FALSE;
                    end;
                end;

                1: //Destino
                begin
                    fDestinos.FiltraPorCodigo (CECodigoDestino.Text);
                    CBTipoDestino.Value := CECodigoDestino.Text;
                    if CBTipoDestino.Text <> ''
                    then begin
                        CBGrupoDestino.Value := fDestinos.ValueByName[CBGrupoDestino.LookupField];
                        CBTipoDestino.Enabled := TRUE;
                    end
                    else begin
                        CBGrupoDestino.Value := '';
                        CBTipoDestino.Enabled := FALSE;
                    end
                end;
            end;

        finally
            CBTipoEspecie.OnChange := a;
            CBGrupoEspecie.OnChange := b;
            CBTipoDestino.OnChange := c;
            CBGrupoDestino.OnChange := d;
        end;
    end;

    procedure TFrmRecepGNC.CBGrupoEspecieChange(Sender: TObject);
    var
        a,b,c,d: tNotifyEvent;
    begin
        a := CECodigoEspecie.Onchange;
        b := CBTipoEspecie.OnChange;
        c := CECodigoDestino.Onchange;
        d := CBTipoDestino.OnChange;

        try
            CECodigoEspecie.OnCHange := nil;
            CBTipoEspecie.OnChange := nil;
            CECodigoDestino.Onchange := nil;
            CBTipoDestino.OnChange := nil;

            case (Sender as TControl).Tag of
                0: //Especie
                begin
                    CECodigoEspecie.Text := '';
                    CBTipoEspecie.Value := '';
                    fEspecies.FiltraPorGrupo(CBGrupoEspecie.Value);
                    CBTipoEspecie.Enabled := CBGrupoEspecie.Text <> '';
                end;

                1: //Destino
                begin
                    CECodigoDestino.Text := '';
                    CBTipoDestino.Value := '';
                    fDestinos.FiltraPorGrupo(CBGrupoDestino.Value);
                    CBTipoDestino.Enabled := CBGrupoDestino.Text <> '';
                end;
            end;
        finally
            CECodigoEspecie.Onchange := a;
            CBTipoEspecie.OnChange := b;
            CECodigoDestino.Onchange := c;
            CBTipoDestino.OnChange := d;
        end;

    end;

    procedure TFrmRecepGNC.CBTipoEspecieChange(Sender: TObject);
    var
        b,c: tNotifyEvent;
    begin
        b := CECodigoEspecie.OnChange;
        c := CECodigoDestino.OnChange;
        try
            CECodigoEspecie.OnChange := nil;
            case (Sender as TControl).Tag of
                0: //Especie
                begin
                    CECodigoEspecie.Text := CBTipoEspecie.Value;
                end;

                1: //Destino
                begin
                   CECodigoDestino.Text := CBTipoDestino.Value;
                end;
            end;
        finally
            CECodigoEspecie.OnChange := b;
            CECodigoDestino.OnChange := c;
        end;
    end;

    procedure TFrmRecepGNC.CBGrupoEspecieCloseUp(Sender: TObject);
    begin
        if (Sender as TControl).Tag = 0
        then CBGrupoEspecie.Value := fGEspecies.ValueByName[fGEspecies.KeyField]
        else CBGrupoDestino.Value := fGDestinos.ValueByName[fGDestinos.KeyField]
    end;

    procedure TFrmRecepGNC.CBTipoEspecieCloseUp(Sender: TObject);
    begin
        if (Sender as TControl).Tag = 0
        then CBTipoEspecie.Value := fEspecies.ValueByName[fEspecies.KeyField]
        else CBTipoDestino.Value := fDestinos.ValueByName[fDestinos.KeyField]
    end;

procedure TFrmRecepGNC.RellenaFormulario;
var
      a,b: TNotifyEvent;
begin
      a := CENroPropietario.OnChange;
      b := CENroConductor.OnChange;
      try
        fModelos.Open;
        fMarcas.Open;
        fGEspecies.Open;
        fEspecies.Open;
        fGDestinos.Open;
        fDestinos.Open;
        fVehiculo.Open;
        fInspGNC.open;
        PInformativo.Caption := Format('%S: %S',[fVarios.ValueByName[FIELD_IDENCONC], DateBD(MyBD)]);
        if fVehiculo.IsNew
        then begin
            fVehiculo.Append;
            fVehiculo.ValueByName['PATENTEN'] := fPatente.Patente;
            fVehiculo.ValueByName['PATENTEA']:= fPatente.Complementaria;
            fVehiculo.ValueByName['NUMEJES'] := IntToStr(EJES_MINIMOS);
            fVehiculo.ValueByName['TIPOESPE'] := '';
            fVehiculo.ValueByName['TIPODEST'] := '';
            fVehiculo.ValueByName['CODMARCA'] := '';
            fVehiculo.ValueByName['CODMODEL'] := '';
            fVehiculo.ValueByname['FECMATRI'] := '';
            fVehiculo.ValueByname['ANIOFABR'] := '';
            fVehiculo.ValueByName['NUMBASTI'] := '';
            fVehiculo.ValueByName['NUMMOTOR'] := '';
            fVehiculo.ValueByName['NCERTGNC'] := '';
            fVehiculo.ValueByName['ERROR'] := '';
            fVehiculo.ValueByName['TIPOGAS'] := '';
            CBGrupoEspecie.Value := '';
            CBGrupoDestino.Value := '';
        end
        else begin
            fModelos.Filter := Format('WHERE CODMARCA = %s',[CBMarca.Value]);
            fVehiculo.Edit;
            CBModelo.Enabled := TRUE;
            BBModelo.Enabled := TRUE;

            if fVehiculo.ValueByName[FIELD_TIPOGAS] = ''
            then CBCombustible.ItemIndex := Ord(ttcbOtros)
            else CBCombustible.ItemIndex := Ord(TCB_DB_TO_SAG[fVehiculo.ValueByName[FIELD_TIPOGAS][1]]);

            if EsOficial.Checked
            then begin
                Sirena.Visible := True;
                Sirena.Animate := True;
            end
            else begin
                Sirena.Animate := False;
                Sirena.Visible := False;
            end;

            CENroPropietario.OnChange := nil;
            CENroConductor.OnChange := nil;

            // DATOS DEL PROPIETARIO
            fAllInspectionsGNC := fVehiculo.GetHistoriaGNC;
            fAllInspectionsGNC.open;
            fAllInspectionsGNC.last;
            if not (fAllInspectionsGNC.RecordCount > 0) then
            begin
              fAllInspections := fVehiculo.GetHistoria;
              fAllInspections.Open;
              fAllInspections.Last;
            end;


            if fAllInspectionsGNC.RecordCount > 0
            then begin
                fPropietario := fAllInspectionsGNC.GetPropietario;
                fConductor := fAllInspectionsGNC.GetConductor;

                fPropietario.Open;
                fConductor.Open;

                CBTDPropietario.ItemIndex := CBTDPropietario.Items.IndexOf (fPropietario.ValueByName[FIELD_TIPODOCU]);
                CENroPropietario.Text := fPropietario.ValueByName[FIELD_DOCUMENT];
                CENombrePropietario.Text := fPropietario.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
                BBPropietario.Enabled := True;

                CBTDConductor.ItemIndex := CBTDConductor.Items.IndexOf (fConductor.ValueByName[FIELD_TIPODOCU]);
                CENroConductor.Text := fConductor.ValueByName[FIELD_DOCUMENT];
                CENombreConductor.Text := fConductor.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
                BBConductor.Enabled := True;
            end
            else if fAllInspections.RecordCount > 0 then
            begin
                fPropietario := fAllInspections.GetPropietario;
                fConductor := fAllInspections.GetConductor;

                fPropietario.Open;
                fConductor.Open;

                CBTDPropietario.ItemIndex := CBTDPropietario.Items.IndexOf (fPropietario.ValueByName[FIELD_TIPODOCU]);
                CENroPropietario.Text := fPropietario.ValueByName[FIELD_DOCUMENT];
                CENombrePropietario.Text := fPropietario.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
                BBPropietario.Enabled := True;

                CBTDConductor.ItemIndex := CBTDConductor.Items.IndexOf (fConductor.ValueByName[FIELD_TIPODOCU]);
                CENroConductor.Text := fConductor.ValueByName[FIELD_DOCUMENT];
                CENombreConductor.Text := fConductor.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
                BBConductor.Enabled := True;

            end;
                if EsOficial.Checked
                then begin
                    Sirena.Visible := True;
                    Sirena.Animate := True;
                end
                else begin
                    Sirena.Animate := False;
                    Sirena.Visible := False;
                end;

        end
      finally
           CENroPropietario.OnChange := a;
           CENroConductor.OnChange := b;
      end;

end;



    procedure TFrmRecepGNC.CEMotorKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Char(VK_SPACE)
    then Key := #0
end;



    procedure TFrmRecepGNC.BContinuarClick(Sender: TObject);
    var
        bSalir : boolean;
        ii: Integer;
    begin
        bSalir := FALSE;
        with TFTmp.Create (Application) do
        try
            MuestraClock('Actualizacion','Actualizando los datos del vehículo en la planta.');
            try
              if ValidatePost then
              begin
                fInspGNC.START;
                if fVehiculo.DataSet.State in [dsInsert,dsEdit] then
                  try
                    fVehiculo.Post(true);
                  except
                    MessageDlg(Caption,'Los Datos del Vehículo no están completos',mtInformation,[mbYes],mbYes,0);
                    if FVehiculo.FieldRequired<>'' then
                       For ii:=0 to Self.ComponentCount-1 do
                       begin
                            Try
                               If (Self.Components[ii] Is TRxDBLookupCombo)
                               then
                                   If TRxDBLookupCombo(Self.Components[ii]).DataField=FVehiculo.FieldRequired
                                   then begin
                                        TWinControl(Self.Components[ii]).SetFocus;
                                        Exit;
                                   end;
                               If (Self.Components[ii] Is TColorDbEdit)
                               then
                                   If TColorDbEdit(Self.Components[ii]).DataField=FVehiculo.FieldRequired
                                   then begin
                                        TWinControl(Self.Components[ii]).SetFocus;
                                        Exit;
                                   end;
                               If (Self.Components[ii] Is TDbDateEdit)
                               then
                                   If TDbDateEdit(Self.Components[ii]).DataField=FVehiculo.FieldRequired
                                   then begin
                                        TWinControl(Self.Components[ii]).SetFocus;
                                        Exit;
                                   end;
                            Except
                            end;
                       end;
                    exit;
                  end;
                fVehiculo.open;
                try
                  GenerarInspeccion;
                  Close;
                  if DatosEquipo then
                  begin
                    bSalir := TRUE;
                    if EnviadaInspeccionALinea
                    then ModalResult := mrOk
                    else begin
                        MessageDlg(Caption,'El Vehículo No Pudo Ser Enviado a la Linea de Inspección GNC',mtInformation,[mbYes],mbYes,0);
                    end;
                    fInspGNC.commit;
                  end
                  else
                  begin
                    fInspGNC.ROLLBACK;
                  end;
                except
                  fInspGNC.ROLLBACK;
                  MessageDlg(Caption,'La Inspección no fue generada correctamente',mtInformation,[mbOk],mbOk,0);
                end;
              end;
            except
                on E: Exception do
                begin
                    bSalir := FALSE;
                    fVehiculo.Edit;
                    fIncidencias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'No se pudieron actualizar los datos: %s',[E.message]);
                    MessageDlg(Caption,'Falta Completar Datos Del Vehículo',mtInformation,[mbOk],mbOk,0);
                end;
            end;
        finally
            Free;
            if bSalir
            then begin
                Self.ModalResult := mrOk;
                bCanClose := TRUE;
            end
            else Self.ModalResult := mrNone
        end
    end;

    procedure TFrmRecepGNC.BCancelarClick(Sender: TObject);
    begin
        bCanClose := TRUE;
        with TFTmp.Create (Application) do
        try
            MuestraClock('Cancelación','Restaurando los valores del vehículo.');
            try
                fVehiculo.Cancel;
                Close;
            except
                on E: Exception do
                begin
                    fIncidencias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'No se pudo cancelar la actualización: %s',[E.message]);
                    MessageDlg(Caption,'No se pudo cancelar la actaulizacion, si el error persiste contacta con su Jefe de Planta',mtInformation,[mbOk],mbOk,0);
                end
            end;
        finally
            Free;
            Self.ModalResult := mrCancel;
        end
    end;

    procedure TFrmRecepGNC.BBMarcaClick(Sender: TObject);
    begin
        Perform (WM_NEXTDLGCTL, 0, 0)
    end;


    procedure TFrmRecepGNC.SEMinusMasTopClick(Sender: TObject);
    begin
        if StrToInt(SEEjes.Text) < EJES_MAXIMOS
        then SEEjes.Text := IntToStr(StrToInt(SEEjes.Text) + 1)
    end;

    procedure TFrmRecepGNC.SEMinusMasBottomClick(Sender: TObject);
    begin
        if StrToInt(SEEjes.Text) > EJES_MINIMOS
        then SEEjes.Text := IntToStr(StrToInt(SEEjes.Text) - 1)
    end;

procedure TFrmRecepGNC.SEEjesKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in [Chr(VK_DOWN), Chr(VK_UP)])
    then key := #0;
end;

procedure TFrmRecepGNC.CEMotorExit(Sender: TObject);
begin
    (Sender as TColorDBEdit).Text := Trim((Sender as TColorDBEdit).Text)
end;



procedure TFrmRecepGNC.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    CanClose := bCanClose;
end;

procedure TFrmRecepGNC.DEMatriculadoExit(Sender: TObject);
begin
    //Validar Fecha intriducida
    AtenuarControl(Sender, TRUE);
    Try
        StrToDate((Sender as TDBDateEdit).Text);
        If (Sender as TDBDateEdit).Date>Date
        then begin
            Raise Exception.Create('Wrong Date');
        end;
    Except
        Messagedlg(Caption,MSJ_INVALID_DATE,mtInformation,[mbok],mbok,0);
        (Sender as TDBDateEdit).Date:=Date;
        (Sender as TDBDateEdit).SetFocus;
    end;
    DEMatriculadoChange(Sender);
end;

procedure TFrmRecepGNC.DEMatriculadoChange(Sender: TObject);
begin
    Try
        StrToDate(DEMatriculado.Text);
        CEFabricado.Text := IntToStr(ExtractYear(DEMatriculado.Date));
        fVehiculo.ValueByName[FIELD_ANIOFABR] := CEFabricado.Text;
    Except
        //CEFabricado.Text := '';
    end;
end;



procedure TFrmRecepGNC.EsOficialClick(Sender: TObject);
begin
    if EsOficial.Checked
    then begin
        Sirena.Visible := True;
        Sirena.Animate := True;
    end
    else begin
        Sirena.Animate := False;
        Sirena.Visible := False;
    end
end;


procedure TFrmRecepGNC.CBTDPropietarioChange(Sender: TObject);
begin
        with CENroPropietario do
        begin
            Text := ''; Color := clWindow; Enabled := TRUE
        end;
end;

procedure TFrmRecepGNC.CENroPropietarioExit(Sender: TObject);
begin
        if ((not Assigned(fConductor)) And (Assigned(fPropietario))) then
        begin
            fConductor := TClientes.CreateByCopy (fPropietario);
            fConductor.Open;
            CBTDConductor.ItemIndex := CBTDPropietario.ItemIndex;
            CENroConductor.Text := CENroPropietario.Text;
            CENombreConductor.Text := CENombrePropietario.Text;
            BBConductor.Enabled := True;
        end;
        If ((fPropietario=nil) or (fPropietario.IsNew)) then BBPropietarioClick(BBPropietario);
end;

procedure TFrmRecepGNC.CENroPropietarioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    if (Shift = [ssCtrl])
    then (Sender as TColorEdit).Clear;

end;

procedure TFrmRecepGNC.CENroPropietarioMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    If CBTDPropietario.ItemIndex<>4
    Then
        (Sender as TColorEdit).Hint:='Número de documento del propietario del vehículo'
    else
        (Sender as TColorEdit).Hint:='Número de documento del propietario del vehículo."00-00000000-0"';

end;

procedure TFrmRecepGNC.BBPropietarioClick(Sender: TObject);
begin
    MostrarDatos_Cliente (fPropietario, CBTDPropietario.ItemIndex, CENroPropietario.Text);
    if Assigned(fPropietario)
    then CENombrePropietario.Text := fPropietario.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
    CENroConductorChange(CENroConductor);
end;

procedure TFrmRecepGNC.MostrarDatos_Cliente (var aCliente: TClientes; iTipoDocu: integer; sDocument: string);
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

procedure TFrmRecepGNC.GenerarInspeccion;
var aux, aux2 : integer;

begin
        If FinspGNC.DataSet.State In [dsEdit,dsInsert]
            Then FinspGNC.Cancel;
        FinspGNC.Append;
        FinspGNC.ValueByName[FIELD_CODVEHIC] := fVehiculo.ValueByName[FIELD_CODVEHIC];
        FinspGNC.ValueByName[FIELD_CODCLIEN] := fPropietario.ValueByName[FIELD_CODCLIEN];
        fInspGNC.ValueByName[FIELD_CODCLCON] := fConductor.ValueByName[FIELD_CODCLIEN];
        FinspGNC.ValueByName[FIELD_INSPFINA] := INSP_NO_FINALIZADA;
        FinspGNC.ValueByName[FIELD_TIPO] := Chr(Ord(fVerificacion) +65);
        fInspGNC.ValueByName[FIELD_CODINSPE] := vCodinspe;
        fInspGNC.Post(true);
        fInspGNC.Refresh;
        aux := 1;
        aux2 := aux;
        fInspGNC.Edit;
end;

procedure TFrmRecepGNC.CENroPropietarioChange(Sender: TObject);
begin
        CENombrePropietario.Text := '';
        if ((Length((SEnder as TColorEdit).Text) > 0) and (CBTDPropietario.ItemIndex<>-1))
        then begin
                try
                    Label1.Font.Color:=clBlack;
                    if (TTipoDocumento(CBTDPropietario.ItemIndex) <> ttdCUIT) or
                       ((TTipoDocumento(CBTDPropietario.ItemIndex) = ttdCUIT) and (TCUIT.IsCorrect((Sender as TColorEdit).Text)))
                    then begin
                        fPropietario.Free;
                        fPropietario := nil;
                        fPropietario := TClientes.CreateFromCode(MyBD,CBTDPropietario.Items[CBTDPropietario.ItemIndex],(Sender as TColorEdit).Text);
                        fPropietario.Open;
                        BBPropietario.Enabled := TRUE;
                        if (fPropietario.RecordCount <> 0) then
                        begin
                            CBTDPropietario.ItemIndex := CBTDPropietario.Items.IndexOf (fPropietario.ValueByName[FIELD_TIPODOCU]);
                            CENroPropietario.Text := fPropietario.ValueByName[FIELD_DOCUMENT];
                            CENombrePropietario.Text := fPropietario.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
                        end;
                    end
                    else begin
                        Label1.Font.Color:=clRed;
                        BBPropietario.Enabled := FALSE;
                    end;
                except
                    on E: Exception do
                        MessageDlg('Identificación del Cliente',Format('Esta fallando la introducción de datos del cliente por: %s. Compruebe que los datos introducidos son correctos. Si el error persiste indíquelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk], mbOk, 0)
                end
        end
        else BBPropietario.Enabled := FALSE

end;

function TFrmRecepGNC.DatosEquipo : boolean;
begin
        with TFrmDatosEquiposGNC.CreateFromBD (fInspGNC, fVehiculo, TIPO_NEW) do
        try
            result := Execute
        finally
            Free;
        end;
end;

procedure TFrmRecepGNC.CBCombustibleChange(Sender: TObject);
begin
        if CBCombustible.ItemIndex <> -1
        then begin
            fVehiculo.ValueByName[FIELD_TIPOGAS] := TCB_SAG_TO_DB[tTipoCombustible(CBCombustible.ItemIndex)];
        end;
end;

function TFrmRecepGNC.EnviadaInspeccionALinea;
begin
        try
                fEstadoInsp := TEstadoInspGNC.CreateByRowId (MyBD, '');
                try
                   fEstadoInsp.Open;
                   fEstadoInsp.Append;
                   fVehiculo.free;
                   fVehiculo := TVehiculo.CreateFromDataBase(mybd,DATOS_VEHICULOS,format(' WHERE CODVEHIC = %S',[fInspGNC.valuebyname[FIELD_CODVEHIC]]));
                   fVehiculo.Open;
                   with fEstadoInsp do
                   begin
                       ValueByName[FIELD_EJERCICI] := fInspGNC.ValueByName[FIELD_EJERCICI];
                       ValueByName[FIELD_CODINSPGNC] := fInspGNC.ValueByName[FIELD_CODINSPGNC];
                       ValueByName[FIELD_TIPO] := fInspGNC.ValueByName[FIELD_TIPO];
                       ValueByName[FIELD_MATRICUL] := fVehiculo.GetPatente;
                       ValueByName[FIELD_ESTADO] := V_ESTADOS_INSP [tePendienteSIC];
                       ValueByName[FIELD_HORAINIC] := DateTimeBD(MyBD);
                   end;

                   fEstadoInsp.Post(true);
                   result := TRUE;

                finally
                     fEstadoInsp.Close;
                     fEstadoInsp.Free;
                end;
        except
            result := FALSE;
        end;
end;

procedure TFrmRecepGNC.SetOperacion (const aValue: tfVerificacion);
begin
//        bValidate := True;
        fEstadoInsp := nil;
        if bOk
        then begin
            try
                fVerificacion:=aValue;
                case aValue of
                    fvGNCRPA:
                    begin
                        // CAPTION E ICONO DE LA FICHA
                        Caption := CF_BY_TYPE[aValue];

                        // PANEL TIPO DE VERIFICACION
                        PTipoVerificacion.Caption := S_TIPO_VERIFICACION[aValue];
                        PTipoVerificacion.Font.Color := clBlack;
//                        ITipoInspeccion.Picture := Normal.Picture;
//                        IDatosEnFactura.Picture := ConDatos.Picture
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

function TFrmRecepGNC.ValidatePost:boolean;
begin
  result := false;
        // Combustible del Vehículo
        if (CBCombustible.itemindex = -1) then
        begin
            MessageDlg (Application.Title, M_FALTCOMBUSTIBLE, mtInformation, [mbOk],mbOk,0);
            CBCombustible.SetFocus;
            exit;
        end;

        if (EDCERTNC.Text = '') then
        begin
            MessageDlg (Application.Title, M_FALTACERTIFICADO, mtInformation, [mbOk],mbOk,0);
            EDCERTNC.SetFocus;
            exit;
        end;

        // Es obligatorio introducir el propietario
        if ((CBTDPropietario.ItemIndex = -1) or (CENroPropietario.Text = '') or (CENombrePropietario.Text = '')) then
        begin
            MessageDlg (Application.Title, M_FALTAPROP, mtInformation, [mbOk],mbOk,0);
            CBTDPropietario.SetFocus;
            exit;
        end;

        // Es obligatorio introducir el conductor
        if ((CBTDConductor.ItemIndex = -1) or (CENroConductor.Text = '') or (CENombreConductor.Text = '')) then
        begin
            MessageDlg (Application.Title, M_FALTACOND, mtInformation, [mbOk],mbOk,0);
            CBTDConductor.SetFocus;
            exit;
        end;

        // Es obligatorio introducir el destino del Vehículo
        if ((CBGrupoDestino.text = '') or (CECodigoDestino.Text = '') or (CBTipoDestino.text = '')) then
        begin
            MessageDlg (Application.Title, M_FALTADESTINO, mtInformation, [mbOk],mbOk,0);
            CECodigoDestino.SetFocus;
            exit;
        end;

        // Es obligatorio introducir el destino del Vehículo
        if ((CBGrupoEspecie.text = '') or (CECodigoEspecie.Text = '') or (CBTipoEspecie.text = '')) then
        begin
            MessageDlg (Application.Title, M_FALTAESPECIE, mtInformation, [mbOk],mbOk,0);
            CECodigoEspecie.SetFocus;
            exit;
        end;

        if fPropietario.ValueByName[FIELD_IDLOCALIDAD] = '' then
        begin
                MessageDlg (Application.Title, MSJ_DATOS_CLIENTE, mtInformation, [mbOk],mbOk,0);
                exit;
        end;


  result := true;
end;


procedure TFrmRecepGNC.CBTDConductorChange(Sender: TObject);
begin
        with CENroConductor do
        begin
            Text := ''; Color := clWindow; Enabled := TRUE
        end;
end;

procedure TFrmRecepGNC.CENroConductorChange(Sender: TObject);
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

procedure TFrmRecepGNC.CENroConductorExit(Sender: TObject);
begin
        if ((not Assigned(fPropietario)) and (Assigned(fConductor))) then
        begin
            fPropietario := TClientes.CreateByCopy (fConductor);
            fPropietario.Open;
            CBTDPropietario.ItemIndex := CBTDConductor.ItemIndex;
            CENroPropietario.Text := CENroConductor.Text;
            CENombrePropietario.Text := CENombreConductor.Text;
            BBPropietario.Enabled := True;
        end;

        If ((fConductor=nil) or (fConductor.IsNew)) then BBConductorClick(BBConductor);
end;

procedure TFrmRecepGNC.CENroConductorMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    If CBTDConductor.ItemIndex<>4
    Then
        (Sender as TColorEdit).Hint:='Número de documento del condcutor del vehículo'
    else
        (Sender as TColorEdit).Hint:='Número de documento del conductor del vehículo."00-00000000-0"';

end;

procedure TFrmRecepGNC.BBConductorClick(Sender: TObject);
begin
    MostrarDatos_Cliente (fConductor, CBTDConductor.ItemIndex, CENroConductor.Text);
    if Assigned(fConductor)
    then CENombreConductor.Text := fConductor.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
    CENroPropietarioChange(CENroPropietario);
end;

procedure TFrmRecepGNC.EDCERTNCKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = Char(VK_SPACE)
        then Key := #0
end;

end.




