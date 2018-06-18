 unit UFMantVehiculos;

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
        GIFCtrl, RXDBCtrl;

    type
        TFMantVehiculos = class(TForm)
            Panel5: TPanel;
            PVehiculo: TPanel;
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
            Label36: TLabel;
            Label37: TLabel;
            Label38: TLabel;
            Label39: TLabel;
            Bevel22: TBevel;
            Bevel23: TBevel;
            Panel15: TPanel;
            CEAntiguo: TColorDBEdit;
            CENuevo: TColorDBEdit;
            CEMotor: TColorDBEdit;
            CEBastidor: TColorDBEdit;
            CEFabricado: TColorDBEdit;
            SEEjes: TColorDBEdit;
            CBCombustible: TComboBox;
            CEGNC: TColorDBEdit;
            CECodigoDestino: TColorDBEdit;
            CECodigoEspecie: TColorDBEdit;
            Label13: TLabel;
            Label14: TLabel;
            Bevel8: TBevel;
            CBMarca: TRxDBLookupCombo;
            CBModelo: TRxDBLookupCombo;
            CBGrupoEspecie: TRxDBLookupCombo;
            CBTipoEspecie: TRxDBLookupCombo;
            CBGrupoDestino: TRxDBLookupCombo;
            CBTipoDestino: TRxDBLookupCombo;
            BBMarca: TBitBtn;
            BBModelo: TBitBtn;
            BContinuar: TBitBtn;
            BCancelar: TBitBtn;
            DSToTMarcas: TDataSource;
            DSToTModelos: TDataSource;
            DSToTGEspecies: TDataSource;
            DSToTEspecies: TDataSource;
            DSToTGDestinos: TDataSource;
            DSToTDestinos: TDataSource;
            DSToTVehiculos: TDataSource;
            SEMinusMas: TRxSpinButton;
            DEMatriculado: TDBDateEdit;
    EsOficial: TDBCheckBox;
    Sirena: TRxGIFAnimator;
    Image1: TImage;
    Bevel1: TBevel;

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

            procedure CBCombustibleChange(Sender: TObject);
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

        public
            bOk : boolean;
            fCertificado : string;
            constructor CreateByPatente (const aPatente: TDominioNuevo);
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
            procedure NuevaMarca;
            procedure NuevoModelo;
            procedure RellenaFormulario;
        end;


    var
        FMantVehiculos: TFMantVehiculos;

    procedure DoMantenimientoDeVehiculos;


implementation

{$R *.DFM}
    uses
        DateUtil,
        ULOGS,
        UFTMP,
        GLOBALS,
        UFDOMINIOS,
        USAGESTACION,
        UINTERFAZUSUARIO,
        UFINSERTMARCASMODELOS;

    resourcestring
        FILE_NAME = 'UFMANTVEHICULOS.PAS';
        MSJ_INVALID_DATE = '¡ Fecha no Valida !, La Fecha No Puede Ser Mayor a La Actual';

    procedure DoAMDeVehiculos(const UnaPatente : TDominioNuevo; var bSeguir : boolean);
    var
        FAMVehiculos : TFMantVehiculos;
        FBusqueda : TFTmp;
    begin
        FBusqueda := TFTmp.Create(Application);
        with FBusqueda do
        try
            MuestraClock('Presentación','Preparando los datos para ser presentados.');
            FAMVehiculos := TFMantVehiculos.CreateByPatente(UnaPatente);
            with FAMVehiculos do
            try
                if bOk
                then begin
                   FBusqueda.Close;
                   FBusqueda.Free;
                   FBusqueda := nil;
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


    procedure DoMantenimientoDeVehiculos;
    var
        bContinuar : boolean;
        UnaPatente : TDominioNuevo;
    begin
        DoRecogeVehiculo (fvMantenimiento, bContinuar, UnaPatente);
        while bContinuar do
        begin
            try
                DoAMDeVehiculos(UnaPatente, bContinuar);
                if bContinuar
                then DoRecogeVehiculo (fvMantenimiento, bContinuar, UnaPatente)
            except
                bContinuar := False;
            end;
        end;
    end;


    constructor TFMantVehiculos.CreateByPatente(const aPatente: TDominioNuevo);
    begin
        fVehiculo := nil;
        fModelos := nil;
        fMarcas := nil;
        fGEspecies := nil;
        fGDestinos := nil;
        fEspecies := nil;
        fDestinos := nil;
        fPatente := TDominioNuevo.CreateBis(aPatente.Patente, aPatente.PerteneceA, aPatente.Complementaria);

        fVehiculo := TVehiculo.CreateByRowId (MyBD, fPatente.PerteneceA);
        fMarcas := TMarcas.Create(MyBD,'');
        fModelos := TModelos.Create(MyBD);

        fGEspecies := TGVehicularesEspecie.Create(MyBD);
        fEspecies := TTEspecies.Create(MyBD);

        fGDestinos := TGVehicularesDestino.Create(MyBD);
        fDestinos := TTDestinos.Create(MyBD);

        inherited Create (Application);
    end;

    procedure TFMantVehiculos.NuevoModelo;
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

    procedure TFMantVehiculos.NuevaMarca;
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


    procedure TFMantVehiculos.FormCreate(Sender: TObject);
    begin
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

            CBCombustible.ItemIndex := -1;
            RellenaFormulario;
            bOk := TRUE;
         except
            on E: Exception do
            begin
                MessageDlg(Caption,Format('Error inicializando el formulario de mantenimiento de vehículos: %s. Comience de nuevo y si el error persiste, indíquelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk],mbOk,0);
                fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error inicializanco el formulario de mantenimiento de vehículos por :%s',[E.message]);
                bOk := FALSE;
            end
         end;
    end;

    procedure TFMantVehiculos.FormDestroy(Sender: TObject);
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
    end;

    procedure TFMantVehiculos.FormKeyPress(Sender: TObject; var Key: Char);
    begin
        if key = #27
        then key := #0
        else if key = ^M
            then begin
                Perform(WM_NEXTDLGCTL,0,0);
                Key := #0
            end
    end;

    procedure TFMantVehiculos.CBMarcaEnter(Sender: TObject);
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

    procedure TFMantVehiculos.CBMarcaExit(Sender: TObject);
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

    procedure TFMantVehiculos.CBMarcaCloseUp(Sender: TObject);
    begin
        CBMarca.Value := fMarcas.ValueByName[CBMarca.LookUpField];
        CBMarcaChange(Sender);
    end;

    procedure TFMantVehiculos.CBModeloCloseUp(Sender: TObject);
    begin
        CBModelo.Value := fModelos.ValueByName[CBModelo.LookUpField];
    end;

    procedure TFMantVehiculos.CBMarcaChange(Sender: TObject);
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

    procedure TFMantVehiculos.BBMarcaMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    begin
        NuevaMarca;
        Perform (WM_NEXTDLGCTL, 0, 0);
    end;

    procedure TFMantVehiculos.BBMarcaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    begin
        if Key = VK_SPACE
        then begin
            NuevaMarca;
            Perform (WM_NEXTDLGCTL, 0, 0)
        end
    end;

    procedure TFMantVehiculos.BBModeloMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    begin
        NuevoModelo;
        Perform (WM_NEXTDLGCTL, 0, 0)
    end;

    procedure TFMantVehiculos.BBModeloKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    begin
        if Key = VK_SPACE then
        begin
            NuevoModelo;
            Perform (WM_NEXTDLGCTL, 0, 0)
        end;
    end;

    procedure TFMantVehiculos.CEMatriculadoClick(Sender: TObject);
    begin
        DEMatriculado.DoClick;
    end;

    procedure TFMantVehiculos.CEMatriculadoKeyPress(Sender: TObject; var Key: Char);
    begin
        DEMatriculado.DoClick;
    end;

    procedure TFMantVehiculos.DEMatriculadoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    begin
        if key in [VK_ESCAPE, VK_RETURN, VK_TAB]
        then Perform (WM_NEXTDLGCTL, 0, 0)
    end;

    procedure TFMantVehiculos.CEFabricadoEnter(Sender: TObject);
    begin
        if Trim(CEFabricado.Text) = ''
        then if (DEMatriculado.Text <> '  /  /    ') and ValidDate(DEMatriculado.Date)
            then CEFabricado.Text := IntToStr(ExtractYear(DEMatriculado.Date))
    end;

    procedure TFMantVehiculos.CEFabricadoKeyPress(Sender: TObject; var Key: Char);
    begin
        if not (Key in ['0','1','2','3','4','5','6','7','8','9',#37,#39,#46,#8])
        then key := #0
    end;

    procedure TFMantVehiculos.SEEjesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    begin
        if Key = VK_DOWN
        then SEMinusMasBottomClick(Sender)
        else if Key = VK_UP
            then SEMinusMasTopClick(Sender)
            else Key := ORD(#0)
    end;

    procedure TFMantVehiculos.CECodigoEspecieChange(Sender: TObject);
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

                0: //Especie
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

    procedure TFMantVehiculos.CBGrupoEspecieChange(Sender: TObject);
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

    procedure TFMantVehiculos.CBTipoEspecieChange(Sender: TObject);
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

    procedure TFMantVehiculos.CBGrupoEspecieCloseUp(Sender: TObject);
    begin
        if (Sender as TControl).Tag = 0
        then CBGrupoEspecie.Value := fGEspecies.ValueByName[fGEspecies.KeyField]
        else CBGrupoDestino.Value := fGDestinos.ValueByName[fGDestinos.KeyField]
    end;

    procedure TFMantVehiculos.CBTipoEspecieCloseUp(Sender: TObject);
    begin
        if (Sender as TControl).Tag = 0
        then CBTipoEspecie.Value := fEspecies.ValueByName[fEspecies.KeyField]
        else CBTipoDestino.Value := fDestinos.ValueByName[fDestinos.KeyField]
    end;

    procedure TFMantVehiculos.RellenaFormulario;
    begin
        fModelos.Open;
        fMarcas.Open;
        fGEspecies.Open;
        fEspecies.Open;
        fGDestinos.Open;
        fDestinos.Open;
        fVehiculo.Open;
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


            if fVehiculo.ValueByName['TIPOGAS'] = ''
            then CBCombustible.ItemIndex := Ord(ttcbOtros)
            else CBCombustible.ItemIndex := Ord(TCB_DB_TO_SAG[fVehiculo.ValueByName['TIPOGAS'][1]]);

            CEGNC.Enabled := (tTipoCombustible(CBCombustible.ItemIndex) = ttcbGNC);
            if CEGNC.Enabled
            then CEGNC.Color := ClWindow;

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
   end;



    procedure TFMantVehiculos.CBCombustibleChange(Sender: TObject);
    begin
        if CBCombustible.ItemIndex <> -1
        then begin
            fVehiculo.ValueByName['TIPOGAS'] := TCB_SAG_TO_DB[tTipoCombustible(CBCombustible.ItemIndex)];
            if (Sender as TComboBox).ItemIndex = ord(ttcbGNC)
            then begin
                CEGNC.Color := clWindow;
                CEGNC.Enabled := TRUE
            end
            else begin
                CEGNC.Enabled := FALSE;
                CEGNC.Color := clBtnFace;
                fVehiculo.ValueByName['NCERTGNC'] := '';
            end;
        end;
    end;


procedure TFMantVehiculos.CEMotorKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Char(VK_SPACE)
    then Key := #0
end;



    procedure TFMantVehiculos.BContinuarClick(Sender: TObject);
    var
        bSalir : boolean;
        ii: Integer;
    begin
        bSalir := FALSE;
        with TFTmp.Create (Application) do
        try
            MuestraClock('Actualizacion','Actualizando los datos del vehículo en la planta.');
            try
                fVehiculo.Post(true);
                Close;
                bSalir := TRUE;
            except
                on E: Exception do
                begin
                    bSalir := FALSE;
                    fVehiculo.Edit;
                    fIncidencias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'No se pudieron actualizar los datos: %s',[E.message]);
                    MessageDlg(Caption,'Falta Completar Datos Del Vehículo',mtInformation,[mbOk],mbOk,0);
                end;
            end;
            If not bSalir
            then begin
                For ii:=0 to Self.ComponentCount-1 do
                begin
                    Try
                        If (Self.Components[ii] Is TDbEdit)
                        then
                            If TDbedit(Self.Components[ii]).DataField=FVehiculo.FieldRequired
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

    procedure TFMantVehiculos.BCancelarClick(Sender: TObject);
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
                    MessageDlg(Caption,'No se pudo cancelar la actaulizacion, si el error persiste contacta con su jefe de planta',mtInformation,[mbOk],mbOk,0);
                end
            end;
        finally
            Free;
            Self.ModalResult := mrCancel;
        end
    end;

    procedure TFMantVehiculos.BBMarcaClick(Sender: TObject);
    begin
        Perform (WM_NEXTDLGCTL, 0, 0)
    end;


    procedure TFMantVehiculos.SEMinusMasTopClick(Sender: TObject);
    begin
        if StrToInt(SEEjes.Text) < EJES_MAXIMOS
        then SEEjes.Text := IntToStr(StrToInt(SEEjes.Text) + 1)
    end;

    procedure TFMantVehiculos.SEMinusMasBottomClick(Sender: TObject);
    begin
        if StrToInt(SEEjes.Text) > EJES_MINIMOS
        then SEEjes.Text := IntToStr(StrToInt(SEEjes.Text) - 1)
    end;

procedure TFMantVehiculos.SEEjesKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in [Chr(VK_DOWN), Chr(VK_UP)])
    then key := #0;
end;

procedure TFMantVehiculos.CEMotorExit(Sender: TObject);
begin
    (Sender as TColorDBEdit).Text := Trim((Sender as TColorDBEdit).Text)
end;



procedure TFMantVehiculos.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    CanClose := bCanClose;
end;

procedure TFMantVehiculos.DEMatriculadoExit(Sender: TObject);
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

procedure TFMantVehiculos.DEMatriculadoChange(Sender: TObject);
begin
    Try
        StrToDate(DEMatriculado.Text);
        CEFabricado.Text := IntToStr(ExtractYear(DEMatriculado.Date));
        fVehiculo.ValueByName[FIELD_ANIOFABR] := CEFabricado.Text;
    Except
        //CEFabricado.Text := '';
    end;
end;



procedure TFMantVehiculos.EsOficialClick(Sender: TObject);
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

end.




