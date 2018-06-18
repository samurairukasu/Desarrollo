unit UFRecepcion;

interface

    uses
        Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
        ExtCtrls, RXCtrls, StdCtrls, UCEdit, Mask, ToolEdit, RXSpin,
        Buttons,
        UCDialgs,
        USAGDATA,
        USAGESTACION,
        USAGFABRICANTE,
        USAGVARIOS,
        USAGCLASIFICACION,
        USAGDOMINIOS,       Ufrmconveniorucara,
        USAGCLASSES,
        UFMANTCLIENTES,
        RXDBCtrl, RXLookup, DBCtrls, UCDBEdit, Db, Animate, GIFCtrl,
        ugacceso, ACCESO1, acceso, Uutils, UFPagoConTarjeta, Grids, DBGrids,
        uFPagoConCheque, UFDatosPromocion, ImgList, RxGIF,
        provider,
        dbclient,usuperregistry;

    type
        TFRecepcion = class(TForm)
            Panel1: TPanel;
            Panel5: TPanel;
            PFormaDePago: TPanel;
            Panel7: TPanel;
            PTipoVerificacion: TPanel;
            PInformativo: TPanel;
            Panel10: TPanel;
            Panel11: TPanel;
            Panel12: TPanel;
            Panel13: TPanel;
            PVehiculo: TPanel;
            Panel15: TPanel;
            Label1: TLabel;
            Bevel1: TBevel;
            Label2: TLabel;
            Bevel2: TBevel;
            Label3: TLabel;
            Bevel3: TBevel;
            CENroPropietario: TColorEdit;
            CENombrePropietario: TColorEdit;
            BContinuar: TBitBtn;
            BCancelar: TBitBtn;
            PEsReverificacion: TPanel;
            Panel16: TPanel;
            Label4: TLabel;
            CBFacturarA: TComboBox;
            Label5: TLabel;
            CBTipoDeIva: TComboBox;
            Bevel10: TBevel;
            Label6: TLabel;
            CSinDatosCliente: TCheckBox;
            Bevel11: TBevel;
            Label7: TLabel;
            Bevel9: TBevel;
            CBTDPropietario: TComboBox;
            CBTDConductor: TComboBox;
            CENroConductor: TColorEdit;
            CENombreConductor: TColorEdit;
            CBTDTenedor: TComboBox;
            CENroTenedor: TColorEdit;
            CENombreTenedor: TColorEdit;
            Panel3: TPanel;
            Panel8: TPanel;
            IFormaDePago: TImage;
            IEsReverificacion: TImage;
            ITipoInspeccion: TImage;
            BBPropietario: TBitBtn;
            BBConductor: TBitBtn;
            BBTenedor: TBitBtn;
            Panel2: TPanel;
            IAnteriores: TImage;
            Panel4: TPanel;
            Panel6: TPanel;
            Panel17: TPanel;
            PTipoFactura: TPanel;
            Panel19: TPanel;
            Panel20: TPanel;
            IDatosEnFactura: TImage;
            Voluntaria: TImage;
            Gratis: TImage;
            Preverificacion: TImage;
            Normal: TImage;
            Periodica: TImage;
            Money: TImage;
            cheque: TImage;
            NoMoney: TImage;
            SinDatos: TImage;
            ConDatos: TImage;
            SiAnteriores: TImage;
            Reverificacion: TImage;
            NoAnteriores: TImage;
            ILIconos: TImageList;
            Otra: TImage;
            PCortesia: TPanel;
            Label22: TLabel;
            Bevel14: TBevel;
            Label24: TLabel;
            Label25: TLabel;
            CEAntiguo: TColorDBEdit;
            CENuevo: TColorDBEdit;
            Label23: TLabel;
            Label26: TLabel;
            Bevel15: TBevel;
            Label27: TLabel;
            CEBastidor: TColorDBEdit;
            CEMotor: TColorDBEdit;
            Label28: TLabel;
            Label29: TLabel;
            Bevel16: TBevel;
            Label30: TLabel;
            CBModelo: TRxDBLookupCombo;
            CBMarca: TRxDBLookupCombo;
            BBMarca: TBitBtn;
            BBModelo: TBitBtn;
            Label31: TLabel;
            Label32: TLabel;
            Bevel13: TBevel;
            Label33: TLabel;
            DEMatriculado: TDBDateEdit;
            Label34: TLabel;
            CEFabricado: TColorDBEdit;
            Bevel18: TBevel;
            Label35: TLabel;
            SEEjes: TColorDBEdit;
            SEMinusMas: TRxSpinButton;
            Bevel8: TBevel;
            Label36: TLabel;
            Bevel21: TBevel;
            CBCombustible: TComboBox;
            Label37: TLabel;
            Label38: TLabel;
            CEGNC: TColorDBEdit;
            Label39: TLabel;
            Label13: TLabel;
            Bevel22: TBevel;
            CECodigoEspecie: TColorDBEdit;
            CBGrupoEspecie: TRxDBLookupCombo;
            CBTipoEspecie: TRxDBLookupCombo;
            Bevel23: TBevel;
            Label14: TLabel;
            CECodigoDestino: TColorDBEdit;
            CBGrupoDestino: TRxDBLookupCombo;
            CBTipoDestino: TRxDBLookupCombo;
            DSToTGEspecies: TDataSource;
            DSToTEspecies: TDataSource;
            DSToTVehiculos: TDataSource;
            DSToTGDestinos: TDataSource;
            DSToTDestinos: TDataSource;
            DSToTMarcas: TDataSource;
            DSToTModelos: TDataSource;
    EsOficial: TDBCheckBox;
    Sirena: TRxGIFAnimator;
    Image1: TImage;
    Bevel4: TBevel;
    CBEsDeCredito: TComboBox;
    Label8: TLabel;
    ctacte: TImage;
    Bevel7: TBevel;
    DsToTDescuento: TDataSource;
    visa: TImage;
    chkbGNC: TCheckBox;
    Label10: TLabel;
    pGNC: TPanel;
    Bevel6: TBevel;
    Image2: TImage;
    chbDecJur: TCheckBox;
    Bevel20: TBevel;
    DEVencGNC: TDBDateEdit;
    Label11: TLabel;
    DSToVehGNC: TDataSource;
    Label9: TLabel;
    CBDescuentos: TRxDBLookupCombo;
    Bevel5: TBevel;
    Bevel17: TBevel;
    Bevel12: TBevel;



            // Cambio de foco al pulsar enter
            procedure FormKeyPress(Sender: TObject; var Key: Char);

            // Creaci�n e inicializaci�n del Formulario con valores por defecto
            procedure FormCreate(Sender: TObject);

            // Proceso general en el evento OnEnter, salvo para ColorEdit, y DateEdit
            procedure CBMarcaEnter(Sender: TObject);

            // Proceso general en el evento OnExit, salvo para ColorEdit, y DateEdit
            procedure CBMarcaExit(Sender: TObject);

            // Proceso general cuando cambia el codigo de la marca
            procedure CBMarcaChange(Sender: TObject);
            procedure BBMarcaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

            // Control de tabulaci�n, escape, y enter en el date edit
            procedure DEMatriculadoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

            // Seleci�n de selecci�n de fecha de matriculaci�n
            procedure CEMatriculadoClick(Sender: TObject);
            procedure CEMatriculadoKeyPress(Sender: TObject; var Key: Char);

            // Filtro de teclas, deja pasar n�meros, borrado, cursores ->, <-, y backspace
            procedure CEFabricadoKeyPress(Sender: TObject; var Key: Char);

            // Inicializaci�n por defecto con la fecha de matriculaci�n
            procedure CEFabricadoEnter(Sender: TObject);

            // Anulaci�n de teclas para la inserci�n del n�mero de ejes
            procedure SEEjesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
            procedure CSinDatosClienteClick(Sender: TObject);
            procedure FormDestroy(Sender: TObject);
            procedure CBGrupoEspecieChange(Sender: TObject);
            procedure CBTipoEspecieChange(Sender: TObject);
            procedure BBPropietarioMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
            procedure IAnterioresDblClick(Sender: TObject);
            procedure CBCombustibleChange(Sender: TObject);
            procedure CBTDPropietarioChange(Sender: TObject);
            procedure CENroPropietarioChange(Sender: TObject);
            procedure CEMotorKeyPress(Sender: TObject; var Key: Char);
            procedure CEMotorExit(Sender: TObject);
            procedure CBMarcaCloseUp(Sender: TObject);
            procedure CBModeloCloseUp(Sender: TObject);
            procedure BBMarcaClick(Sender: TObject);
            procedure SEEjesKeyPress(Sender: TObject; var Key: Char);
            procedure CECodigoEspecieChange(Sender: TObject);
            procedure CBGrupoEspecieCloseUp(Sender: TObject);
            procedure CBTipoEspecieCloseUp(Sender: TObject);
            procedure CECodigoDestinoChange(Sender: TObject);
            procedure SEMinusMasBottomClick(Sender: TObject);
            procedure SEMinusMasTopClick(Sender: TObject);
            procedure BBModeloKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
            procedure CBTDConductorChange(Sender: TObject);
            procedure CBTDTenedorChange(Sender: TObject);
            procedure CENroConductorChange(Sender: TObject);
            procedure CENroTenedorChange(Sender: TObject);
            procedure BBConductorMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
            procedure BBTenedorMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
            procedure CENroPropietarioExit(Sender: TObject);
            procedure CENroConductorExit(Sender: TObject);
            procedure CENroTenedorExit(Sender: TObject);
            procedure BCancelarClick(Sender: TObject);
            procedure CBFacturarAChange(Sender: TObject);
            procedure BContinuarClick(Sender: TObject);
            procedure BBPropietarioEnter(Sender: TObject);
            procedure BBConductorEnter(Sender: TObject);
            procedure BBTenedorEnter(Sender: TObject);
            procedure BBPropietarioClick(Sender: TObject);
            procedure BBConductorClick(Sender: TObject);
            procedure BBTenedorClick(Sender: TObject);
            procedure BBModeloClick(Sender: TObject);
            procedure DEMatriculadoExit(Sender: TObject);
    procedure DEMatriculadoChange(Sender: TObject);
    procedure CENroPropietarioMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure CENroConductorMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure CENroTenedorMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CENroPropietarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EsOficialClick(Sender: TObject);
    procedure CBEsDeCreditoClick(Sender: TObject);
    procedure CBEsDeCreditoChange(Sender: TObject);
    procedure CBDescuentosEnter(Sender: TObject);
    procedure CBDescuentosExit(Sender: TObject);
    procedure CBEsDeCreditoEnter(Sender: TObject);
    procedure CBEsDeCreditoExit(Sender: TObject);
    procedure chkbGNCClick(Sender: TObject);
    procedure DEVencGNCExit(Sender: TObject);
    procedure CENroPropietarioKeyPress(Sender: TObject; var Key: Char);
    procedure CENroConductorKeyPress(Sender: TObject; var Key: Char);
    procedure CENroTenedorKeyPress(Sender: TObject; var Key: Char);

        private
            { Private declarations }
            firstActivating : Boolean;
            bValidate : Boolean;
            fVerificacion : tfVerificacion;
            bCanClose : boolean;
            fOldDateFormat : string;
            fPatente : TDominioNuevo;
            fVehiculo : TVehiculo;
            fInspeccion, fAllInspections: TInspeccion;
            fMarcas: TMarcas;
            fModelos: TModelos;
            fGEspecies: TGVehicularesEspecie;
            fGDestinos: TGVehicularesDestino;
            fDestinos : TTDestinos;
            fEspecies : TTEspecies;
            fPropietario, fConductor, fTenedor : TClientes;
            fEstadoInsp: TEstadoInspeccion;
            fFactura: TFacturacion;
            fPtoVenta: TPtoVenta;
            fDescuento: TDescuento;
            fUnaPatente: TDominioNuevo;
            fVehiculos_GNC: TVehiculos_GNC;
            fInspVigente : TInspVigente;

            procedure RegresaAlVehiculo;
            procedure GenerarFactura;
            procedure GenerarInspeccion (const WithFacture : boolean);
            procedure DisableFacturacion;
            procedure NuevaMarca;
            procedure NuevoModelo;
            procedure RellenaFormulario;
            procedure SetOperacion (const aValue: tfVerificacion);
            constructor CreateByPatente (const aPatente: TDominioNuevo; aOperacion: tfVerificacion);
            procedure Rellenar_DatosFacturas (aCliente: TClientes);
            //Valida los datos introducidos
            function ValidatePost: boolean;

            // True si el cliente ha pagado la inspeccion
            function BoxManAcceptTheInspection(const WithFacture: Boolean) : boolean;
            procedure MostrarDatos_Cliente (var aCliente: TClientes; iTipoDocu: integer; sDocument: string);

            function FacturaImpresa: boolean;
            function EnviadaInspeccionAlinea: boolean;
            function InspeccionPagada: boolean;
            function datoscompletospago: boolean;
            procedure TipoCliente (var aCliente: tclientes);
            procedure GenerarVehiculo_GNC;
            procedure CancelarVehiculo_GNC;
            procedure CompletarVehiculo_GNC;
            procedure GrabaInspEnVigente;
            function CalculaVTVVigente(var aCliente: tclientes) : boolean;
            Procedure ActivarDescactivar(Activo: Boolean);

        public
            { Public declarations }
            bOk : boolean;
            fVerificacionNueva : tfVerificacion;
            property Operacion: tfVerificacion read fVerificacion write SetOperacion;

           
       end;


    var
        FRecepcion: TFRecepcion;
        //MB VARIABLES UTULIZADA PARA LA MODIDFICACION DEL PROBLEMA DEL FORMUALRIO DE TARJETA
        codigo_vehiculo,codigo_factura:string;
        //FIN
    procedure DoVerificacion (aOperation: tfVerificacion);
   // Procedure BorrarControlInsp(Patente :string);




implementation

{$R *.DFM}
    uses
        ULOGS,
        GLOBALS,
        DATEUTIL,
        UFINSERTMARCASMODELOS,
        UFHISTORICOINSPECCIONES,
        UINTERFAZUSUARIO,
        USAGCUIT,
        UFTMP,
        UFDOMINIOS,
        UTILORACLE,
        UFCAJA,
        UCTIMPRESION,
        UCLIENTE,
        SQLExpr,
        UFRECEPGNC,
        ufDeclaracionJurada, uGetObleaPlanta,
        UFDatosReveExterna, Uversion;

    const

        CF_BY_TYPE : array [fvNormal..fvPreverificacionOk] of string =
        ('Nueva Verificaci�n: NORMAL', 'Nueva Verificacion: PREVERIFICACI�N',
         'Nueva Verificaci�n: GRATUITA', 'Nueva Verificacion: VOLUNTARIA',
         'Nueva Verificacion: REVERIFICACION',
         'Regreso, Finalizaci�n: STAND-BY', 'Aceptaci�n de Preverificaci�n: PAGO DE PREVERIFICACI�N'
         );


        CPESREVERIFICACION_BY_TYPE : array [fvNormal..fvPreverificacionOk] of string =
        (' 1� Inspecci�n', ' Reverificaci�n', ' Obligatoria', ' Otra', ' Otra', ' Otra', ' Otra');


        GAS_NATURAL = 0;

        NUMERO_INC_FACTURA = -5;

        TIPO_VIGENTE = 'V';
        TIPO_SUPERVISOR = 'S';
        TIPO_OTRA_PLANTA = 'O';

    resourcestring
        FILE_NAME = 'UFRECEPCION.PAS';
        MSJ_ON_LINE = 'Este veh�culo ya se Encuentra en Linea de Inspecci�n';
        MSJ_ON_LINE_GNC = 'Este veh�culo ya se Encuentra en Linea de Inspecci�n GNC';
        MSJ_INVALID_DATE = '� Fecha no Valida !, La Fecha No Puede Ser Mayor a La Actual';
        MSJ_DATOS_CLIENTE = 'Los datos del propietario no est�n completos';


        INSP_NO_FINALIZADA = 'N';
        FACTURA_NO_IMPRESA = 'N';
        IVA_NO_INSCRIPTO = 'N';


        M_SINDATOSCLIENTE_INC = 'S�lo se puede emitir una factura sin datos del cliente si el tipo de IVA es Consumidor Final y la forma de pago es Contado.';
        M_CLICREDITO_OFICIAL_INC = 'El cliente no es de cr�dito, luego el veh�culo no puede ser oficial. Seleccione un cliente de cr�dito o no marque la casilla de veh�culo oficial.';
        M_FALTAPROP = 'Es obligatorio introducir el propietario del veh�culo';
        M_FALTACOND = 'Es obligatorio introducir el conductor del veh�culo';
        M_FALTATEN  = 'Es obligatorio introducir el tenedor del veh�culo';
        M_FALTAMARCA = 'Debe introducir la marca del veh�culo';
        M_FALTAMODELO = 'Debe introducir el modelo del veh�culo';
        M_INVALID_DATA = 'Faltan algunos de los datos introducidos o son incorrectos. Rev�selos de nuevo.';
        M_INSPECC_ERR = 'Error al generar una inspecci�n';
        M_TRABAJO_IMPRESOR_ERR = 'No pudo enviarse un trabajo al servidor de impresi�n. Verifique si est� en funcionamiento y si el error persiste contacte con su Jefe de Planta';
        MSJ_CAN_NOT_PREVERIFICATION = '� Este Veh�culo No tiene Inspecciones Previas Finalizadas por lo que no Puede ser Preverificado !';
        MSJ_CAN_NOT_BILLING = '� Este Veh�culo No Tiene una Preverificaci�n Pendiente de Facturar !';
        M_NOCREDITO = ' El cliente no es de cr�dito.  No se puede facturar a Cuenta Corriente ';
        M_FALTAVENC = ' Debe introducir la fecha de vencimiento de la Oblea GNC del vehiculo ';

        CADENA_PROPIETARIO = 'Propietario';
        CADENA_CONDUCTOR = 'Conductor';
        CADENA_TENEDOR = 'Tenedor';

        CADENA_FACTURA_A = 'A';
        CADENA_FACTURA_B = 'B';

    var
        EsPreve : tfVerificacion;
 {
Function OnLine(UnaPatente: TDominioNuevo; aDataBase: TSQLConnection):Boolean;
var
      aq: TSQLDataSet;
      dsp : tDatasetprovider;
      cds : tClientDataSet;

      QryConsultas: TClientDataSet;
      sdsQryConsultas : TSQLDataSet;
      dspQryConsultas : tdatasetprovider;
begin
        //Comprueba si esta veh�culo se encuentra ya la estaci�n en linea
        Result:=False;
        aQ := TSQLDataSet.Create(nil);
        aQ.SQLConnection := aDataBase;
        aQ.CommandType := ctQuery;
        aQ.GetMetadata := false;
        aQ.NoMetadata := true;
        aQ.ParamCheck := false;


        dsp := TDataSetProvider.Create(nil);
        dsp.DataSet := aQ;
        dsp.Options := [poIncFieldProps,poAllowCommandText];

       // cds:=TClientDataSet.Create(nil);
       // With cds do
       // Try


        {
           // MARTIN 21/12/2012
            SetProvider(dsp);
             commandtext:='';
            commandtext := Format('SELECT * FROM TCONTROL_TESTADOINSP WHERE MATRICULA = ''%S'' OR MATRICULA = ''%S'' ',[UnaPatente.Patente,UnaPatente.Complementaria]);
            Open;
             If RecordCount>0 then
              begin
               Result:=True;
               exit;
               end;


              close;
            }


             //FIN------------




           // SetProvider(dsp);
           //  commandtext:='';
           // commandtext := Format('SELECT * FROM TESTADOINSP WHERE MATRICUL = ''%S'' OR MATRICUL = ''%S'' ',[UnaPatente.Patente,UnaPatente.Complementaria]);
           // Open;

            //   If RecordCount>0 then
            //      Result:=True

                 //martin 21/12/2011
                 // si la patente no esta en testadoinspe, la agregamos. Esto permite que no se ingresen dos veces las patentes cuando
                 // se mantiene por un tiempo determinado el form de factura en otra caja.
                  {
                  else
                    begin
                        if  trim(UnaPatente.Patente)<>'' then
                              CONTROL_MATRICULA:=UnaPatente.Patente
                                else
                                  CONTROL_MATRICULA:=UnaPatente.Complementaria;

                           FRecepcion.INSERTA_EN_TCONTROL_TESTADOINSP(CONTROL_MATRICULA) ;
                               
                     }





              //   end;

       {
        Finally
          close;
          Free;
          dsp.Free;
          aQ.close;
          aQ.free;
        end;

end;
}



Function OnLine(UnaPatente: TDominioNuevo; aDataBase: TSQLConnection):Boolean;
var
      aq: TSQLDataSet;
      dsp : tDatasetprovider;
      cds : tClientDataSet;
begin
        //Comprueba si esta veh�culo se encuentra ya la estaci�n en linea
        Result:=False;
        aQ := TSQLDataSet.Create(nil);
        aQ.SQLConnection := aDataBase;
        aQ.CommandType := ctQuery;
        aQ.GetMetadata := false;
        aQ.NoMetadata := true;
        aQ.ParamCheck := false;


        dsp := TDataSetProvider.Create(nil);
        dsp.DataSet := aQ;
        dsp.Options := [poIncFieldProps,poAllowCommandText];

        cds:=TClientDataSet.Create(nil);

        With cds do
        Try
            SetProvider(dsp);
            commandtext := Format('SELECT * FROM TESTADOINSP WHERE MATRICUL = ''%S'' OR MATRICUL = ''%S'' ',[UnaPatente.Patente,UnaPatente.Complementaria]);
            Open;
            If RecordCount>0 then Result:=True;
        Finally
          close;
          Free;
          dsp.Free;
          aQ.close;
          aQ.free;
        end;

end;


Function OnLine_dos_factura(UnaPatente: TDominioNuevo; aDataBase: TSQLConnection):Boolean;
var
      aq: TSQLDataSet;
      dsp : tDatasetprovider;
      cds : tClientDataSet;
begin
        //Comprueba si esta veh�culo se encuentra ya la estaci�n en linea
        Result:=False;
        aQ := TSQLDataSet.Create(nil);
        aQ.SQLConnection := aDataBase;
        aQ.CommandType := ctQuery;
        aQ.GetMetadata := false;
        aQ.NoMetadata := true;
        aQ.ParamCheck := false;


        dsp := TDataSetProvider.Create(nil);
        dsp.DataSet := aQ;
        dsp.Options := [poIncFieldProps,poAllowCommandText];

        cds:=TClientDataSet.Create(nil);
        With cds do
        Try
            SetProvider(dsp);
            commandtext := Format('SELECT * FROM TESTADOINSP WHERE MATRICUL = ''%S'' OR MATRICUL = ''%S'' ',[UnaPatente.Patente,UnaPatente.Complementaria]);
            Open;
            If RecordCount>0 then Result:=True;
        Finally
          close;
          Free;
          dsp.Free;
          aQ.close;
          aQ.free;
        end;

end;


procedure DoRECEPDeVehiculos(const UnaPatente : TDominioNuevo; var bSeguir : boolean; aOperation: tfVerificacion);
var
FRecepVehiculos : TFRecepcion;
FBusqueda : TFTmp;
begin
FBusqueda := TFTmp.Create(nil);
  with FBusqueda do
    try
      MuestraClock('Presentaci�n','Preparando los datos para ser presentados.');
      FRecepVehiculos := TFRecepcion.CreateByPatente(UnaPatente, aOperation);
      with FRecepVehiculos do
        try
          if bOk then
            begin
              fUnaPatente:= UnaPatente;
              FBusqueda.Close;
              FBusqueda.Free;
              FBusqueda := nil;
              FRecepVehiculos.Operacion := aOperation;
              If bValidate then
                FRecepVehiculos.ShowModal;
            end
          else
            bSeguir := FALSE;
        finally
          FRecepVehiculos.Free;
        end;
    finally
      FBusqueda.Free;
    end;
end;


procedure DoVerificacion (aOperation: tfVerificacion);
var
bContinuar : boolean;
UnaPatente : TDominioNuevo;
begin
DoRecogeVehiculo (aOperation, bContinuar, UnaPatente);
espreve := aOperation;
while bContinuar do
  begin
    try


      If ((Not OnLine(UnaPatente, MyBd)) or (aOperation=fvPreverificacionOk)) Then
        DoRecepDeVehiculos(UnaPatente, bContinuar, aOperation)
      else
        begin
          //BorrarControlInsp(UnaPatente.Patente);
          Messagedlg(Application.Title,MSJ_ON_LINE,mtInformation,[mbok],mbok,0);
        end;
      if bContinuar then
        DoRecogeVehiculo (aOperation, bContinuar, UnaPatente)
    except
      bContinuar := False;
    end;
  end;
end;




procedure TFRecepcion.ActivarDescactivar(Activo: Boolean);
Begin
BContinuar.Enabled:=Activo;
BCancelar.Enabled:=BContinuar.Enabled;
end;


procedure TFRecepcion.DisableFacturacion;
begin
PTipoFactura.Caption := '';
CBFacturarA.Enabled := False;
CBFActurarA.Color := ClGray;
CBTipoDeIva.Enabled := False;
CBTipoDeIva.Color := ClGray;
//  CEsDeCredito.Enabled := False;
CSinDatosCliente.Enabled := False;
CBEsDeCredito.Enabled := False;
CBEsDeCredito.Color := ClGray;
CBDescuentos.Enabled := False;
CBDescuentos.Color := ClGray;
end;


procedure TFRecepcion.SetOperacion (const aValue: tfVerificacion);
begin
bValidate := True;
fEstadoInsp := nil;
  if bOk then
    begin
      try
        if Assigned(fAllInspections) and (fAllInspections.RecordCount > 0) then
          IAnteriores.Picture := SiAnteriores.Picture
        else
          begin
            IAnteriores.Enabled := False;
            IAnteriores.Picture := NoAnteriores.Picture
          end;

        fVerificacion:=aValue;
        case aValue of
          fvNormal, fvPreverificacionOK:
          begin
            if aValue=fvPreverificacionOK then
              begin
                if (not Assigned(fAllInspections)) or (fAllInspections.RecordCount = 0) then
                  begin
                    Messagedlg(Caption,MSJ_CAN_NOT_BILLING,mtInformation,[mbok],mbok,0);
                    bValidate := False;
                  end
                else
                  begin
                    fEstadoInsp:=nil;
                    fEstadoInsp:=TEstadoInspeccion.CreateFromDatabase(MyBd,DATOS_ESTADOINSPECCION,Format(' WHERE A.CODINSPE = %S AND A.EJERCICI = %S',[fAllInspections.ValueByName[FIELD_CODINSPE],fAllInspections.ValueByName[FIELD_EJERCICI]]));
                    fEstadoInsp.Open;
                    If ((fEstadoInsp.RecordCount=0) or (fEstadoInsp.ValueByName[FIELD_ESTADO][1]<>E_PENDIENTE_FACTURAR)) then
                      begin
                        Messagedlg(Caption,MSJ_CAN_NOT_BILLING,mtInformation,[mbok],mbok,0);
                        bValidate := False;
                      end;
                  end;

                If bValidate then
                  begin
                    fInspeccion:=TInspeccion.CreateFromEstadoInspeccion(fEstadoInsp);
                    fInspeccion.Open;
                  end;
              end;

            // CAPTION E ICONO DE LA FICHA
            Caption := CF_BY_TYPE[aValue];
            ILIconos.GetIcon(Ord(fvNormal), Icon);

            // PANEL TIPO DE VERIFICACION
            PTipoVerificacion.Caption := S_TIPO_VERIFICACION[fVNormal];
            PTipoVerificacion.Font.Color := clBlack;
            ITipoInspeccion.Picture := Normal.Picture;

            PCortesia.Caption := IntToStr(fVarios.Carry);

            if Assigned(fAllInspections) and (fAllInspections.RecordCount > 0) and fAllInspections.IsReverification(fAllInspections, fvNormal) then
              begin
              PEsReverificacion.Caption := S_TIPO_VERIFICACION[fvReverificacion];
              PEsReverificacion.Font.Color := clRed;
              IEsReverificacion.Picture := Reverificacion.Picture;
              fVerificacion:=fvReverificacion;
              pTipoFactura.caption := 'N';    //
              cbDescuentos.Enabled:=false;
              if assigned(fvehiculos_gnc) then
                with TVehiculos_GNC.CreateByCodVehic(mybd,fVehiculo.ValueByName[FIELD_CODVEHIC]) do
                  try
                    open;
                    if recordcount > 0 then
                      begin
                        if strtodate(copy(ValueByName[FIELD_FECVENCI],1,10)) > date then
                          fVehiculos_GNC.ValueByName[FIELD_FECVENCI] := ValueByName[FIELD_FECVENCI];
                      end;
                  finally
                    free;
                  end;
              end
            else
              begin
                PEsReverificacion.Caption := S_TIPO_VERIFICACION[fvNormal];
                IEsReverificacion.Picture := Periodica.Picture;
              end;

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
//          IDatosEnFactura.Picture := ConDatos.Picture
          end;

          fvPreverificacion:
          begin
            DisableFacturacion;
            If ((fAllInspections<>nil) and (fAllInspections.RecordCount>0)) Then
              begin
                If (fAllInspections.ValueByName[FIELD_TIPO] = C_GRATUITA) then
                  //or (fAllInspections.ValueByName[FIELD_FINALIZADA]<>'S�') then -> Eliminado x ke no se entiende
                  //or (fAllInspections.ValueByName[FIELD_TIPO] = C_PREVERIFICACION) -> Eliminado por Provincia Seguros
                  begin
                    Messagedlg(Caption,MSJ_CAN_NOT_PREVERIFICATION,mtInformation,[mbok],mbok,0);
                    bValidate := False;
                  end;
              end;

              // CAPTION E ICONO DE LA FICHA
              Caption := CF_BY_TYPE[fvPreverificacion];
              ILIconos.GetIcon(Ord(fvPreverificacion), Icon);

              // PANEL TIPO DE VERIFICACION
              PTipoVerificacion.Caption := S_TIPO_VERIFICACION[fVPreverificacion];
              PTipoVerificacion.Font.Color := clBlue;
              ITipoInspeccion.Picture := Preverificacion.Picture;

              // PANEL MOTIVO DE LA VERIFICACION
              PEsReverificacion.Caption := ' Otra';
              PEsReverificacion.Font.Color := ClGray;
              IEsReverificacion.Picture := Otra.Picture;

              // PANEL FORMA DE PAGO
              PFormaDePago.Caption := ' Gratuita';
              PFormaDePago.Font.Color := clGreen;
              IFormaDePago.Picture := NoMoney.Picture;
              IDatosEnFactura.Picture := SinDatos.Picture

              // CODIGO 104
              // Caso 1:
              // Si existe una preve anterior, donde la fecha de venc es < a la fecha actual entonces 104

              //Caso 2:
              // Si la fecha de la preve1 es = a la fecha de venc de la preve2 entonces 104

          end;


          fvGratuita:
            begin
              DisableFacturacion;

              // CAPTION E ICONO DE LA FICHA
              Caption := CF_BY_TYPE[fvGratuita];
              ILIconos.GetIcon(Ord(fvGratuita), Icon);

              // PANEL TIPO DE VERIFICACION
              PTipoVerificacion.Caption := S_TIPO_VERIFICACION[fVGratuita];
              PTipoVerificacion.Font.Color := clGreen;
              ITipoInspeccion.Picture := Gratis.Picture;

              // PANEL MOTIVO DE LA VERIFICACION
              PEsReverificacion.Caption := ' Otra';
              PEsReverificacion.Font.Color := ClGray;
              IEsReverificacion.Picture := Otra.Picture;

              // PANEL FORMA DE PAGO
              PFormaDePago.Caption := ' Gratuita';
              PFormaDePago.Font.Color := clGreen;
              IFormaDePago.Picture := NoMoney.Picture;
              IDatosEnFactura.Picture := SinDatos.Picture
            end;

          fvVoluntaria:
            begin
              // CAPTION E ICONO DE LA FICHA
              Caption := CF_BY_TYPE[fvVoluntaria];
              ILIconos.GetIcon(Ord(fvVoluntaria), Icon);

              // PANEL TIPO DE VERIFICACION
              PTipoVerificacion.Caption := S_TIPO_VERIFICACION[fvVoluntaria];
              PTipoVerificacion.Font.Color := clYellow;
              ITipoInspeccion.Picture := Voluntaria.Picture;

              if Assigned(fAllInspections) and (fAllInspections.RecordCount > 0) and fAllInspections.IsReverification(fAllInspections, fvVoluntaria) then
                begin
                  PEsReverificacion.Caption := S_TIPO_VERIFICACION[fvVoluntariaReverificacion]; // pero voluntaria
                  fVerificacion:= fvVoluntariaReverificacion;
                  PEsReverificacion.Font.Color := clRed;
                  IEsReverificacion.Picture := Reverificacion.Picture;
                  PCortesia.Caption := IntToStr(fVarios.Carry);
                  pTipoFactura.caption := 'N'; //
                end
              else
                begin
                  PEsReverificacion.Caption := ' Otra';
                  PEsReverificacion.Font.Color := ClGray;
                  IEsReverificacion.Picture := Otra.Picture;
                end;

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
                    IFormaDePago.Picture := ctacte.Picture
                  end;
                3:begin
                    PFormaDePago.Caption := ' Cheque';
                    PFormaDePago.Font.Color := clPurple;
                    IFormaDePago.Picture := Cheque.Picture
                  end;
              end;
            //    IDatosEnFactura.Picture := ConDatos.Picture;
           // end
          end;
////////////////////////////////////////////////////////////////////////////////////////////////////
//                                  ReveExterna a la planta                                       //
////////////////////////////////////////////////////////////////////////////////////////////////////

          fvReverificacionExterna:
            begin
              PEsReverificacion.Caption := C_REVERIFICACION_EXT;
              PEsReverificacion.Font.Color := clRed;
              IEsReverificacion.Picture := Reverificacion.Picture;

              fVerificacion:=fvReverificacion;
              fVerificacionNueva:=fvReverificacionExterna;

              pTipoFactura.caption := 'N';
              cbDescuentos.Enabled:=false;
              if assigned(fvehiculos_gnc) then
                with TVehiculos_GNC.CreateByCodVehic(mybd,fVehiculo.ValueByName[FIELD_CODVEHIC]) do
                  try
                    open;
                    if recordcount > 0 then
                      begin
                        if strtodate(copy(ValueByName[FIELD_FECVENCI],1,10)) > date then
                          fVehiculos_GNC.ValueByName[FIELD_FECVENCI] := ValueByName[FIELD_FECVENCI];
                      end;
                  finally
                    free;
                  end;
              end
            else
              begin
                PEsReverificacion.Caption := S_TIPO_VERIFICACION[fvNormal];
                IEsReverificacion.Picture := Periodica.Picture;
              end;

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
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
        end;
      except
        on E: Exception do
          begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error inicializando el formulario de recepcion por :%s',[E.Message]);
            MessageDlg(Caption,Format('Error inicializando el formulario de recepcion: %s. Si el error persiste ind�quelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk],mbOk,0);
            bOk := False
          end
      end
    end
end;


constructor TFRecepcion.CreateByPatente(const aPatente: TDominioNuevo; aOperacion: tfVerificacion);
begin
  try
    //fVehiculo := nil;
    fModelos := nil;
    fMarcas := nil;
    fGEspecies := nil;
    fGDestinos := nil;
    fEspecies := nil;
    fDestinos := nil;
    fInspeccion := nil;
    fAllInspections := nil;
    fEstadoInsp := nil;
    fFactura := nil;
    fPropietario := nil;
      fTenedor := nil;
    fConductor := nil;
    fPtoVenta := nil; //
    fDescuento := nil; //
    fPatente := TDominioNuevo.CreateBis(aPatente.Patente, aPatente.PerteneceA, aPatente.Complementaria);

    fVehiculo := TVehiculo.CreateByRowId (MyBD, fPatente.PerteneceA);
    fInspeccion := TInspeccion.CreateByRowId (MyBD,'');
    fFactura := TFacturacion.CreateByRowid (MyBD,'');

    fMarcas := TMarcas.Create(MyBD,'');
    fModelos := TModelos.Create(MyBD);

    fGEspecies := TGVehicularesEspecie.Create(MyBD);
    fEspecies := TTEspecies.Create(MyBD);
    fGDestinos := TGVehicularesDestino.Create(MyBD);
    fDestinos := TTDestinos.Create(MyBD);
    fPtoVenta:= TPtoVenta.Create(MyBD);  //
    fDescuento := TDescuento.CreateBySysDate(MyBD); //

    inherited Create (nil);
  except
    on E:Exception do
     Begin
       raise Exception.Create ('A Form could not be created: ' + E.Message);
       fIncidencias.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'Error al crear el form '+ E.Message);
     end;
  end;
end;

    procedure TFRecepcion.FormCreate(Sender: TObject);
    begin

//   fIncidencias.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'entra ufrecepcion '+inttostr(cursores));

         //fEstadoInsp := nil;
         //fFactura:=nil;
         firstActivating := true;
         tipostatus:='N';
         fOldDateFormat := ShortDateFormat;
         bCanClose := FALSE;
         ShortDateFormat := 'dd/mm/yyyy';
         bOk := False;
         try
            DSToTVehiculos.DataSet := fVEhiculo.DataSet;
            DSToTMarcas.DataSet := fMarcas.DataSet;
            DSToTModelos.DataSet := fModelos.DataSet;
            DSToTGEspecies.DataSet := fGEspecies.DataSet;
            DSToTEspecies.DataSet := fEspecies.DataSet;
            DSToTGDestinos.DataSEt := fGDestinos.DataSet;
            DSToTDestinos.DataSet := fDestinos.DataSet;
            DSToTDescuento.DataSet := fDescuento.dataset;

            CBCombustible.ItemIndex := -1;
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
                MessageDlg(Caption,Format('Error inicializando el formulario de mantenimiento de veh�culos: %s. Comience de nuevo y si el error persiste, ind�quelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk],mbOk,0);
                fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error inicializando el formulario de mantenimiento de veh�culos por :%s',[E.message]);
                bOk := FALSE;
            end
         end;

         With fVarios Do  //
         Try
            First;
            If ActivarDescuentos = OP_INACTIVA_N  //Desactivacion del Descuento por Convenio
            then CBDescuentos.Enabled:=False
            else CBDescuentos.Enabled:=True;

         Finally
         end;

    end;


procedure TFRecepcion.RellenaFormulario;
var
a,b,c: TNotifyEvent;
Nmarca: string;
DatosPadron:string;
begin

a := CENroPropietario.OnChange;
b := CENroConductor.OnChange;
c := CENroTenedor.OnChange;
  try
    fModelos.Open;
    fMarcas.Open;
    fGEspecies.Open;
    fEspecies.Open;
    fGDestinos.Open;
    fDestinos.Open;
    fVehiculo.Open;
    fInspeccion.Open;
    fDescuento.Open;

    PInformativo.Caption := Format('%S: %S',[fVarios.ValueByName[FIELD_IDENCONC], DateBD(MyBD)]);

    if fVehiculo.IsNew  then
    begin
       fVehiculo.Append ;

       with TSuperRegistry.Create do
        try
          RootKey := HKEY_LOCAL_MACHINE;
           if  OpenKeyRead(CAJA_) then
             begin
              DatosPadron:= ReadString(DATOSPADRON_);
             end;


      finally
       free;
      end;


       if trim(DatosPadron)='1' then
       begin
          with TSQLQuery.Create(application) do
               try
                SQLConnection:=BDPADRON;
                SQL.Add(format('SELECT NRO_MOTOR,MARCA_MOTOR  FROM VEHICULOS_TOTALES_Z2 WHERE PATENTE_ACTUAL=''%s''',[fPatente.Patente]));
                Open;
                fVehiculo.ValueByName[FIELD_NUMMOTOR] := Fields[0].AsString;
                 Nmarca :=Fields[1].AsString;
               finally
                Close;
                Free;
                  end;
         if   Nmarca <> ''   then
         begin
          with TSQLQuery.Create(application) do
         try
            SQLConnection:=MYBD;
            SQL.Add('SELECT CODMARCA FROM TMARCAS  WHERE  NOMMARCA LIKE '''+'%'+format('%s',[Nmarca])+'%''');
            Open;
            if RecordCount > 0  then
            begin
             fVehiculo.ValueByName[FIELD_CODMARCA] :=Fields[0].AsString  ;
             fModelos.Filter := Format('WHERE CODMARCA = %s',[CBMarca.Value]);
             CBModelo.Enabled := TRUE;
             BBModelo.Enabled := TRUE;
            end
            else
            fVehiculo.ValueByName[FIELD_CODMARCA] :=''
         finally
            Close;
            Free;
        end;
        end ;
       end
       else
        begin
          fVehiculo.ValueByName[FIELD_CODMARCA] := '';
          fVehiculo.ValueByName[FIELD_NUMMOTOR] := '';
        end;
        fVehiculo.ValueByName[FIELD_PATENTEN] := fPatente.Patente;
        fVehiculo.ValueByName[FIELD_PATENTEA] := fPatente.Complementaria;
        fVehiculo.ValueByName[FIELD_NUMEJES] := IntToStr(EJES_MINIMOS);
        fVehiculo.ValueByName[FIELD_TIPOESPE] := '';
        fVehiculo.ValueByName[FIELD_TIPODEST] := '';
        fVehiculo.ValueByName[FIELD_CODMODEL] := '';
        fVehiculo.ValueByname[FIELD_FECMATRI] := '';
        fVehiculo.ValueByname[FIELD_ANIOFABR] := '';
        fVehiculo.ValueByName[FIELD_NUMBASTI] := '';
        fVehiculo.ValueByName[FIELD_NCERTGNC] := '';
        fVehiculo.ValueByName[FIELD_ERROR] := '';
        fVehiculo.ValueByName[FIELD_TIPOGAS] := '';
        CBGrupoEspecie.Value := '';
        CBGrupoDestino.Value := '';
        CBTDPropietario.ItemIndex := 0;
        SEEjes.Text:='2';
      end
    else
      begin
        fModelos.Filter := Format('WHERE CODMARCA = %s',[CBMarca.Value]);
        fVehiculo.Edit;
        CBModelo.Enabled := TRUE;
        BBModelo.Enabled := TRUE;

        if fVehiculo.ValueByName[FIELD_TIPOGAS] = '' then
          CBCombustible.ItemIndex := Ord(ttcbOtros)
        else
          CBCombustible.ItemIndex := Ord(TCB_DB_TO_SAG[fVehiculo.ValueByName[FIELD_TIPOGAS][1]]);

        CENroPropietario.OnChange := nil;
        CENroConductor.OnChange := nil;
        CENroTenedor.OnChange := nil;

        // DATOS DE LOS PROPIETARIOS
        fAllInspections := fVehiculo.GetHistoria;
        fAllInspections.Open;
        fAllInspections.Last;

        if fAllInspections.RecordCount > 0 then
          begin
            fPropietario := fAllInspections.GetPropietario;
            fConductor := fAllInspections.GetConductor;
            fTenedor := fAllInspections.GetTenedor;

            fPropietario.Open;
            fConductor.Open;
            fTenedor.Open;

            CBTDPropietario.ItemIndex := CBTDPropietario.Items.IndexOf (fPropietario.ValueByName[FIELD_TIPODOCU]);
            CENroPropietario.Text := fPropietario.ValueByName[FIELD_DOCUMENT];
            CENombrePropietario.Text := fPropietario.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
            BBPropietario.Enabled := True;

            CBTDConductor.ItemIndex := CBTDConductor.Items.IndexOf (fConductor.ValueByName[FIELD_TIPODOCU]);
            CENroConductor.Text := fConductor.ValueByName[FIELD_DOCUMENT];
            CENombreConductor.Text := fConductor.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
            BBConductor.Enabled := True;

            CBTDTenedor.ItemIndex := CBTDTenedor.Items.IndexOf (fTenedor.ValueByName[FIELD_TIPODOCU]);
            CENroTenedor.Text := fTenedor.ValueByName[FIELD_DOCUMENT];
            CENombreTenedor.Text := fTenedor.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
            BBTenedor.Enabled := True;

            if EsOficial.Checked then
              begin
                Sirena.Visible := True;
                Sirena.Animate := True;
                if fVerificacion in [fvNormal, fvVoluntaria, fvReverificacion, fvPreverificacionOk, fvVoluntariaReverificacion] then
                  begin
                    CBEsDeCredito.ItemIndex := 2;
                    PFormaDePago.Caption := ' Cuenta Cte';
                    PFormaDePago.Font.Color := clRed;
                    IFormaDePago.Picture := ctacte.Picture;
                  end;
              end
            else
              begin
                Sirena.Animate := False;
                Sirena.Visible := False;
              end;
            Rellenar_DatosFacturas (fPropietario);
          end;

        CEGNC.Enabled := (tTipoCombustible(CBCombustible.ItemIndex) = ttcbGNC);

        if CEGNC.Enabled then
        begin
          CEGNC.Color := ClWindow;
          if (fVarios.ActivarGNC <> op_INACTIVA_N) then
          begin
            MostrarComponentes(true,self,[9]);
          end;
          MostrarComponentes(true,self,[10]);
          GenerarVehiculo_GNC;
        end;
    end;
  finally
    CENroPropietario.OnChange := a;
    CENroConductor.OnChange := b;
    CENroTenedor.OnChange := c;
  end;
end;


procedure TFRecepcion.FormDestroy(Sender: TObject);
var
bContinuarInsp : boolean;
aux : TVehiculo;
begin
ShortDateFormat := fOldDateFormat;


If Assigned(fPatente) then
  fPatente.Free;

If Assigned(fModelos) then
  fModelos.Free;

If Assigned(fMarcas) then
  fMarcas.Free;

If Assigned(fGEspecies) then
  fGEspecies.Free;

If Assigned(fGDestinos) then
  fGDestinos.Free;

If Assigned(fEspecies) then
  fEspecies.Free;

If Assigned(fDestinos) then
  fDestinos.Free;

If Assigned(fAllInspections) then
  fAllInspections.Free;
  
//  fConductor.Free;
{A�adidos despues del error de los cursores}
//  fEstadoInsp.Free;
  try
    if ((CBCombustible.ItemIndex = ord(ttcbGNC)) and (ModalResult <> mrCancel)) and bValidate then
      CompletarVehiculo_GNC;
  Except
    On E: Exception Do
      ShowMessage('ERROR','Error producido por: '+E.Message);
  end;

if chkbGNC.Checked then
  begin
    with TFrmRecepGNC do
      begin
        aux := tvehiculo.CreateFromDataBase(mybd,DATOS_VEHICULOS,format('WHERE CODVEHIC = %S ',[fVehiculo.ValueByName[FIELD_CODVEHIC]]));
          with aux  do
            try
              open;
              fUnaPatente := tdominionuevo.CreateBis(ValueByName[FIELD_PATENTEN],ValueByName[FIELD_ROWID],ValueByName[FIELD_PATENTEA]);
            finally
              free;
            end;
          if Not OnLineGNC(fUnaPatente, MyBd) then
            DoAMDeVehiculos(fUnaPatente, bContinuarInsp, fvGNCRPA, fInspeccion.ValueByName[FIELD_CODINSPE])
          else
            Messagedlg(Application.Title,MSJ_ON_LINE_GNC,mtInformation,[mbok],mbok,0);
      end;
  end;

If Assigned(fvehiculo) then
  fVehiculo.Free;

if assigned(fPropietario) then
   fPropietario.Free;

if assigned(fTenedor) then
   fTenedor.Free;

if assigned(fConductor) then
  fConductor.Free;

////////////////////////////////////////////////////////////////////////////////////////////////////

if assigned(fFactura.ffactadicionales) then
  fFactura.ffactadicionales.Free;

if assigned(fFactura) then
fFactura.Free;

if assigned(fPtoventa) then
fPtoventa.Free;

if assigned(FDescuento) then
  fDescuento.Free;

if assigned(fInspeccion) then
  fInspeccion.Free;

if assigned(fVehiculos_GNC) then
  begin
    fVehiculos_GNC.cancel;
    fVehiculos_GNC.Free;
  end;
end;


procedure TFRecepcion.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key = ^M  then
  begin
    Perform(WM_NEXTDLGCTL,0,0);
    Key := #0
  end;
end;

    procedure TFRecepcion.CEMotorKeyPress(Sender: TObject; var Key: Char);
    begin
        if Key = Char(VK_SPACE)
        then Key := #0
    end;

    procedure TFRecepcion.CEMotorExit(Sender: TObject);
    begin
        (Sender as TColorDBEdit).Text := Trim((Sender as TColorDBEdit).Text)
    end;

    procedure TFRecepcion.CBMarcaCloseUp(Sender: TObject);
    begin
        CBMarca.Value := fMarcas.ValueByName[CBMarca.LookUpField];
        CBMarcaChange(Sender);
    end;

    procedure TFRecepcion.CBModeloCloseUp(Sender: TObject);
    begin
        CBModelo.Value := fModelos.ValueByName[CBModelo.LookUpField];
    end;

    procedure TFRecepcion.BBMarcaClick(Sender: TObject);
    begin
        NuevaMarca;
        Perform (WM_NEXTDLGCTL, 0, 0);
    end;

    procedure TFRecepcion.CBMarcaEnter(Sender: TObject);
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

    procedure TFRecepcion.CBMarcaChange(Sender: TObject);
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

    procedure TFRecepcion.CBMarcaExit(Sender: TObject);
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

    procedure TFRecepcion.NuevaMarca;
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

    procedure TFRecepcion.BBMarcaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    begin
        if Key = VK_SPACE
        then begin
            NuevaMarca;
            Perform (WM_NEXTDLGCTL, 0, 0)
        end
    end;

    procedure TFRecepcion.BBModeloKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    begin
        if Key = VK_SPACE then
        begin
            NuevoModelo;
            Perform (WM_NEXTDLGCTL, 0, 0)
        end;
    end;

    procedure TFRecepcion.NuevoModelo;
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

    procedure TFRecepcion.SEEjesKeyPress(Sender: TObject; var Key: Char);
    begin
        if not (key in [Chr(VK_DOWN), Chr(VK_UP)])
        then key := #0;
    end;

    procedure TFRecepcion.CEMatriculadoClick(Sender: TObject);
    begin
        DEMatriculado.DoClick;
    end;

    procedure TFRecepcion.CEMatriculadoKeyPress(Sender: TObject; var Key: Char);
    begin
        DEMatriculado.DoClick;
    end;

    procedure TFRecepcion.DEMatriculadoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    begin
        if key in [VK_ESCAPE, VK_RETURN, VK_TAB]
        then Perform (WM_NEXTDLGCTL, 0, 0)
    end;

    procedure TFRecepcion.CEFabricadoEnter(Sender: TObject);
    begin
        if Trim(CEFabricado.Text) = ''
        then if (DEMatriculado.Text <> '  /  /    ') and ValidDate(DEMatriculado.Date)
            then CEFabricado.Text := IntToStr(ExtractYear(DEMatriculado.Date))
    end;

    procedure TFRecepcion.CEFabricadoKeyPress(Sender: TObject; var Key: Char);
    begin
       if not (Key in ['0','1','2','3','4','5','6','7','8','9',#37,#39,#46,#8])
        then key := #0
    end;

    procedure TFRecepcion.SEEjesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    begin
        if Key = VK_DOWN
        then SEMinusMasBottomClick(Sender)
        else if Key = VK_UP
            then SEMinusMasTopClick(Sender)
            else Key := ORD(#0)
    end;

    procedure TFRecepcion.SEMinusMasBottomClick(Sender: TObject);
    begin
      If (CECodigoEspecie.Text <> '') then
        Begin
          Case StrToInt(CECodigoEspecie.Text) of
            19,20,21,22,23:  EJES_MINIMOS:= 1;
          else
            EJES_MINIMOS:=2;
          end;
        end;

      If StrToInt(SEEjes.Text) > EJES_MINIMOS then
        SEEjes.Text := IntToStr(StrToInt(SEEjes.Text) - 1);
    end;

    procedure TFRecepcion.SEMinusMasTopClick(Sender: TObject);
    begin
    if StrToInt(SEEjes.Text) < EJES_MAXIMOS then
      SEEjes.Text := IntToStr(StrToInt(SEEjes.Text) + 1)
    end;

    procedure TFRecepcion.CBCombustibleChange(Sender: TObject);
    begin
        if CBCombustible.ItemIndex <> -1
        then begin
            fVehiculo.ValueByName[FIELD_TIPOGAS] := TCB_SAG_TO_DB[tTipoCombustible(CBCombustible.ItemIndex)];
            if (Sender as TComboBox).ItemIndex = ord(ttcbGNC)
            then begin
                CEGNC.Color := clWindow;
                CEGNC.Enabled := TRUE;
                if (fVarios.ActivarGNC <> op_INACTIVA_N) then
                  MostrarComponentes(true,self,[9,10])
                else
                  MostrarComponentes(true,self,[10]);
                GenerarVehiculo_GNC;
            end
            else begin
                CEGNC.Enabled := FALSE;
                CEGNC.Color := clBtnFace;
                fVehiculo.ValueByName[FIELD_NCERTGNC] := '';
                MostrarComponentes(false,self,[8,9,10]);
                CancelarVehiculo_GNC;
            end;
        end;
    end;

    procedure TFRecepcion.CBGrupoEspecieChange(Sender: TObject);
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


procedure TFRecepcion.CBTipoEspecieChange(Sender: TObject);
var
b,c: tNotifyEvent;     aCliente: tclientes;
formrucara:Tfrmconveniorucara;
begin


      //convenio rucara. 25/03/2015 m.b.

        if trim(CBDescuentos.Text)='CONV R.U.C.A.R.A.' then
           begin
            formrucara:=Tfrmconveniorucara.Create(nil);
            formrucara.CBPartido.Enabled:=false;
            formrucara.CargarPartidos();
            formrucara.CheckBox1.Checked:=false;
             formrucara.Edit1.Text:=trim(self.CENuevo.Text);
             formrucara.Edit2.Text:=trim(self.CENombrePropietario.Text);
             formrucara.UVEHICULO:=fVehiculo.ValueByName[FIELD_CODVEHIC];
             formrucara.UCLIENTE:=fPropietario.ValueByName[FIELD_CODCLIEN];
              With TSQLQuery.Create(Self) do
               try
                 Close;
                 SQL.Clear;
                 SQLConnection:=mybd;
                 SQL.Add('select oblea_rucara from tvarios');
                 open;
                   formrucara.Panel2.Caption:=fields[0].asstring;

                 Close;
                 SQL.Clear;
                 SQLConnection:=mybd;
                 SQL.Add('update tvarios set oblea_rucara=oblea_rucara + 1');
                 ExecSQL;
             finally
             free;
             end;



             formrucara.ShowModal;
          //  if formrucara.cancela=false then
         //   begin
         //     aCliente.edit;
         //    aCliente.ValueByName[FIELD_TIPOCLIENTE_ID] := TIPO_CLIENTE_NORMAL;
         ///    aCliente.Post(true);
          //  end;

             formrucara.Free;

           end;


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


    procedure TFRecepcion.IAnterioresDblClick(Sender: TObject);
    var
        aPatente: string;
    begin
        try
            Enabled := False;

            if CENuevo.TExt <> ''
            then aPatente := CENuevo.Text
            else aPatente := CEAntiguo.Text;

            try
                VisualizaHistoricoInspecciones (fAllInspections, fPatente)
            except
                on E: Exception do
                begin
                    MessageDlg(Caption,'Error al intentar ver la lista de inspecciones del vehiculo predeterminado. Intentelo de nuevo y si el error persiste, ind�quelo al Jefe de Planta.', mtInformation, [mbOk],mbOk,0);
                end;
            end;

        finally
            Enabled := True;
        end
    end;

procedure TFRecepcion.CECodigoEspecieChange(Sender: TObject);
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
        if CBTipoEspecie.Text <> '' then
          begin
            CBGrupoEspecie.Value := fEspecies.ValueByName[CBGrupoEspecie.LookupField];
            CBTipoEspecie.Enabled := TRUE;
          end
        else
          begin
            CBGrupoEspecie.Value := '';
            CBTipoEspecie.Enabled := FALSE;
            SEEjes.Text:='2';
          end;
      end;

    1: //Destino
      begin
        fDestinos.FiltraPorCodigo (CECodigoDestino.Text);
        CBTipoDestino.Value := CECodigoDestino.Text;
        if CBTipoDestino.Text <> '' then
          begin
            CBGrupoDestino.Value := fDestinos.ValueByName[CBGrupoDestino.LookupField];
            CBTipoDestino.Enabled := TRUE;
          end
        else
          begin
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

    procedure TFRecepcion.CBGrupoEspecieCloseUp(Sender: TObject);
    begin
        if (Sender as TControl).Tag = 0
        then CBGrupoEspecie.Value := fGEspecies.ValueByName[fGEspecies.KeyField]
        else CBGrupoDestino.Value := fGDestinos.ValueByName[fGDestinos.KeyField]
    end;

    procedure TFRecepcion.CBTipoEspecieCloseUp(Sender: TObject);
    begin
        if (Sender as TControl).Tag = 0
        then CBTipoEspecie.Value := fEspecies.ValueByName[fEspecies.KeyField]
        else CBTipoDestino.Value := fDestinos.ValueByName[fDestinos.KeyField]
    end;

    procedure TFRecepcion.CECodigoDestinoChange(Sender: TObject);
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


    //
    // IDENTIFICACI�N DEL CLIENTE
    //

    // Si cambia de tipo de documento -> se inicializan los demas datos
    // si continua con el que estaba -> no pasa nada


    procedure TFRecepcion.CBTDPropietarioChange(Sender: TObject);
    begin
        with CENroPropietario do
        begin
            Text := ''; Color := clWindow; Enabled := TRUE
        end;
    end;

    procedure TFRecepcion.CBTDConductorChange(Sender: TObject);
    begin
        with CENroConductor do
        begin
            Text := ''; Color := clWindow; Enabled := TRUE
        end;
    end;

    procedure TFRecepcion.CBTDTenedorChange(Sender: TObject);
    begin
        with CENroTenedor do
        begin
            Text := ''; Color := clWindow; Enabled := TRUE
        end;
    end;

    // Se bucan los datos del cliente, en cuanto el valor cambia
    procedure TFRecepcion.CENroPropietarioChange(Sender: TObject);
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
                        MessageDlg('Identificaci�n del Cliente',Format('Esta fallando la introducci�n de datos del cliente por: %s. Compruebe que los datos introducidos son correctos. Si el error persiste ind�quelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk], mbOk, 0)
                end
        end
        else BBPropietario.Enabled := FALSE
    end;


    procedure TFRecepcion.CENroConductorChange(Sender: TObject);
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
                        MessageDlg('Identificaci�n del Cliente',Format('Esta fallando la introducci�n de datos del cliente por: %s. Compruebe que los datos introducidos son correctos. Si el error persiste ind�quelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk], mbOk, 0)
                end
        end
        else BBConductor.Enabled := FALSE
    end;

    procedure TFRecepcion.CENroTenedorChange(Sender: TObject);
    begin
        CENombreTenedor.Text := '';
        if ((Length((SEnder as TColorEdit).Text) > 0) and (CBTDTenedor.ItemIndex<>-1))
        then begin
                try
                    BBTenedor.Enabled := FALSE;
                    Label3.Font.Color:=clBlack;
                    if (TTipoDocumento(CBTDTenedor.ItemIndex) <> ttdCUIT) or
                       ((TTipoDocumento(CBTDTenedor.ItemIndex) = ttdCUIT) and (TCUIT.IsCorrect((Sender as TColorEdit).Text)))
                    then begin
                        fTenedor.Free;
                        fTenedor := nil;
                        fTenedor := TClientes.CreateFromCode(MyBD,CBTDTenedor.Items[CBTDTenedor.ItemIndex],(Sender as TColorEdit).Text);
                        fTenedor.Open;
                        BBTenedor.Enabled := TRUE;
                        if (fTenedor.RecordCount <> 0) then
                        begin
                            CBTDTenedor.ItemIndex := CBTDTenedor.Items.IndexOf (fTenedor.ValueByName[FIELD_TIPODOCU]);
                            CENroTenedor.Text := fTenedor.ValueByName[FIELD_DOCUMENT];
                            CENombreTenedor.Text := fTenedor.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
                        end
                    end
                    else Begin
                        Label3.Font.Color:=clBlack;
                        BBTenedor.Enabled := FALSE;
                    end;
                except
                    on E: Exception do
                        MessageDlg('Identificaci�n del Cliente',Format('Esta fallando la introducci�n de datos del cliente por: %s. Compruebe que los datos introducidos son correctos. Si el error persiste ind�quelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk], mbOk, 0)
                end
        end
        else BBTenedor.Enabled := FALSE
    end;



    procedure TFRecepcion.CENroPropietarioExit(Sender: TObject);
    begin

        Rellenar_DatosFacturas (fPropietario);
        
        if ((not Assigned(fConductor)) And (Assigned(fPropietario))) then
        begin
            fConductor := TClientes.CreateByCopy (fPropietario);
            fConductor.Open;
            CBTDConductor.ItemIndex := CBTDPropietario.ItemIndex;
            CENroConductor.Text := CENroPropietario.Text;
            CENombreConductor.Text := CENombrePropietario.Text;
            BBConductor.Enabled := True;
        end;

        if ((not Assigned(fTenedor)) and (Assigned(fPropietario))) then
        begin
            fTenedor := TClientes.CreateByCopy (fPropietario);
            fTenedor.Open;
            CBTDTenedor.ItemIndex := CBTDPropietario.ItemIndex;
            CENroTenedor.Text := CENroPropietario.Text;
            CENombreTenedor.Text := CENombrePropietario.Text;
            BBTenedor.Enabled := True;
        end;
        If ((fPropietario=nil) or (fPropietario.IsNew)) then BBPropietarioClick(BBPropietario);
    end;

    procedure TFRecepcion.CENroConductorExit(Sender: TObject);
    begin
        if ((not Assigned(fPropietario)) and (Assigned(fConductor))) then
        begin
            fPropietario := TClientes.CreateByCopy (fConductor);
            fPropietario.Open;
            CBTDPropietario.ItemIndex := CBTDConductor.ItemIndex;
            CENroPropietario.Text := CENroConductor.Text;
            CENombrePropietario.Text := CENombreConductor.Text;
            BBPropietario.Enabled := True;
            Rellenar_DatosFacturas (fPropietario);
        end;

        if ((not Assigned(fTenedor)) and (Assigned(fConductor))) then
        begin
            fTenedor := TClientes.CreateByCopy (fConductor);
            fTenedor.Open;
            CBTDTenedor.ItemIndex := CBTDConductor.ItemIndex;
            CENroTenedor.Text := CENroConductor.Text;
            CENombreTenedor.Text := CENombreConductor.Text;
            BBTenedor.Enabled := True;
        end;
        If ((fConductor=nil) or (fConductor.IsNew)) then BBConductorClick(BBConductor);
    end;

    procedure TFRecepcion.CENroTenedorExit(Sender: TObject);
    begin
        if ((not Assigned(fPropietario)) and (Assigned(fTenedor))) then
        begin
            fPropietario := TClientes.CreateByCopy (fTenedor);
            fPropietario.Open;
            CBTDPropietario.ItemIndex := CBTDTenedor.ItemIndex;
            CENroPropietario.Text := CENroTenedor.Text;
            CENombrePropietario.Text := CENombreTenedor.Text;
            BBPropietario.Enabled := True;
            Rellenar_DatosFacturas (fPropietario);
        end;

        if ((not Assigned(fConductor)) and (Assigned(fTenedor))) then
        begin
            fConductor := TClientes.CreateByCopy (fTenedor);
            fConductor.Open;
            CBTDConductor.ItemIndex := CBTDTenedor.ItemIndex;
            CENroConductor.Text := CENroTenedor.Text;
            CENombreConductor.Text := CENombreTenedor.Text;
            BBConductor.Enabled := True;
        end;
        If ((fTenedor=nil) or (fTenedor.IsNew)) then BBTenedorClick(BBTenedor);
    end;

    procedure TFRecepcion.BBPropietarioMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    begin
        MostrarDatos_Cliente (fPropietario, CBTDPropietario.ItemIndex, CENroPropietario.Text);
        CENombrePropietario.Text := fPropietario.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
        Perform (WM_NEXTDLGCTL, 0, 0);
    end;

    procedure TFRecepcion.BBConductorMouseDown(Sender: TObject;  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    begin
        MostrarDatos_Cliente (fConductor, CBTDConductor.ItemIndex, CENroConductor.Text);
        CENombreConductor.Text := fConductor.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
        Perform (WM_NEXTDLGCTL, 0, 0);
    end;

    procedure TFRecepcion.BBTenedorMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    begin
        MostrarDatos_Cliente (fTenedor, CBTDTenedor.ItemIndex, CENroTenedor.Text);
        CENombreTenedor.Text := fTenedor.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
        Perform (WM_NEXTDLGCTL, 0, 0);
    end;

    procedure TFRecepcion.MostrarDatos_Cliente (var aCliente: TClientes; iTipoDocu: integer; sDocument: string);
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
                   fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FILE_NAME,'Fall� la puesta en edicion de la tabla de clientes');
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

    procedure TFRecepcion.CBFacturarAChange(Sender: TObject);
    begin
        if ((Sender as tcombobox).ItemIndex = 0)
        then  Rellenar_DatosFacturas (fPropietario)
        else if ((Sender as tcombobox).ItemIndex = 1)
            then Rellenar_DatosFacturas (fConductor)
            else Rellenar_DatosFacturas (fTenedor);
    end;

    procedure TFRecepcion.Rellenar_DatosFacturas (aCliente: TClientes);
    var
      i: integer;
      sLetra: string;

    begin
        If not assigned(aCliente) Then Exit;

        if fVerificacion in [fvNormal, fvVoluntaria, fvReverificacion, fvPreverificacionOk, fvVoluntariaReverificacion]
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




            if (aCliente.ValueByName[FIELD_CREDITCL] = INSPECCION_FINALIZADA) then         //Si es de cr�dito
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

//            CSinDatosCliente.Checked := (CBTipoDeIVA.Items[CBTipoDeIVA.ItemIndex] = 'CONSUMIDOR FINAL');
            end;
            if CSinDatosCliente.Checked
            then IDatosEnFactura.Picture := SinDatos.Picture
            else IDatosEnFactura.Picture := ConDatos.Picture;
        end;
    end;

    procedure TFRecepcion.RegresaAlVehiculo;
    var
        aRowId : string;
    begin
        aRowid := fVehiculo.ValueByName[FIELD_ROWID];
        fVehiculo.Free;
        fVehiculo := TVehiculo.CreateByRowId(MyBD,aRowId);
        DSToTVehiculos.DataSet := fVehiculo.DataSet;
        fVehiculo.Open;
        fVehiculo.Edit;
    end;

    procedure TFRecepcion.BCancelarClick(Sender: TObject);
    begin

        fVehiculo.Cancel;
        ModalResult := mrCancel;
    end;

procedure TFRecepcion.BContinuarClick(Sender: TObject);
var
bAvanzar : boolean;
ii:Integer;
FBusqueda: TFTmp;

codinsperucara:longint;
codclienterucara:longint;
codvehiculorucara:longint;
begin

bAvanzar := FALSE;
  try
    try

       fbusqueda:= TFTmp.create(nil);
      if ValidatePost then
        begin
          ActivarDescactivar(False);
          if fVehiculo.Dataset.State in [dsEdit,dsInsert] then
            begin
              // fVehiculo.START;
              fVehiculo.Post(True);
            end;
          case fVerificacion of
            fvNormal,
            fvVoluntaria,
            fvReverificacion,
            fvPReverificacionOk,
            fvVoluntariaReverificacion:
            begin
              if fPtoVenta.EsCaja then   // -> Caja
                begin // -> 1
                  with fbusqueda do
                    muestraclock('Facturaci�n','Preparando los datos para imprimir factura...');
                    if BoxManAcceptTheInspection(TRUE) then
                      begin
                        if (fptoventa.GetTipo = TIPO_CF) or ((fptoventa.GetTipo = TIPO_MANUAL) and FacturaImpresa) then
                          begin
                            fbusqueda.Close;

                            //fin rucaras

                                  codinsperucara:=strtoint(fInspeccion.valuebyname[FIELD_CODINSPE]);
                                       codclienterucara:=strtoint(fPropietario.ValueByName[FIELD_CODCLIEN]);
                                       codvehiculorucara:=strtoint(fvehiculo.ValueByName[FIELD_codvehic]);

                            if InspeccionPagada then
                              begin

                                  // rucaras
                             if  (trim(CBDescuentos.Text)='CONV R.U.C.A.R.A.') then
                             begin
                                     //rucara

                                        With TSQLQuery.Create(Self) do
                                            try
                                             Close;
                                             SQL.Clear;
                                             SQLConnection:=mybd;
                                             SQL.Add('update trucaras set codinspe='+inttostr(codinsperucara)+ ' ,codvehic=' +inttostr(codvehiculorucara)+
                                             ' where codvehic='+inttostr(codvehiculorucara)+' and codclien='+inttostr(codclienterucara)+' and codinspe=-1 ');
                                             ExecSQL;
                                            finally
                                             free;
                                          end;
                                   //fin rucara
                               end;
                                if EnviadaInspeccionALinea then
                                  begin




                                    ModalResult := mrOk;
                                    if chbDecJur.Checked then
                                      DodeclaracionJurada(fInspeccion.valuebyname[FIELD_EJERCICI],fInspeccion.valuebyname[FIELD_CODINSPE], DJ_NUEVA);
                                  end
                                else
                                  Begin
                                    MessageDlg(Caption,'El Veh�culo No Pudo Ser Enviado a la Linea de Inspecci�n',mtInformation,[mbYes],mbYes,0);
                                    ActivarDescactivar(True);
                                  end;
                              end
                            else
                              Begin
                                MessageDlg(Caption,'El Importe De La Factura No Fue Cobrado',mtInformation,[mbYes],mbYes,0);
                                ActivarDescactivar(True);
                              end;
                          end
                        else
                          begin
                            fbusqueda.Close;
                            MessageDlg(Caption,'La Factura No Pudo Imprimirse',mtInformation,[mbYes],mbYes,0);
                            ActivarDescactivar(True);
                            RegresaAlVehiculo;
                          end;
                      end
                    else
                      begin
                        fbusqueda.Close;
                        MessageDlg(Caption,'La Factura No Pudo Imprimirse',mtInformation,[mbYes],mbYes,0);
                        MessageDlg(Caption,'No Se Quiso Imprimir, o Se Gener� Mal La Inspecci�n y La Factura',mtInformation,[mbYes],mbYes,0);
                        ActivarDescactivar(True);
                        RegresaAlVehiculo;
                      end;
                end // -> cierre 1
              else
                MessageDlg(Caption,'Esta PC no est� habilitada para facturar',mtError,[mbYes],mbYes,0);
            end
          else
            begin
              if BoxManAcceptTheInspection(FALSE) then
                if EnviadaInspeccionALinea then
                  ModalResult := mrOk
                else
                  begin
                    MessageDlg(Caption,'El Veh�culo No Pudo Ser Enviado a La Linea de Inspecci�n',mtInformation,[mbYes],mbYes,0);
                    RegresaAlVehiculo;
                  end
              else
                begin
                  MessageDlg(Caption,'No Se Quiso Imprimir, o Se Gener� Mal La Inspecci�n y La Factura',mtInformation,[mbYes],mbYes,0);
                  RegresaAlVehiculo;
                end;
              ActivarDescactivar(True);
            end;
        end;
    end;
      finally
        fbusqueda.free;
      end;
  except
    MessageDlg(Caption,'Falta completar datos de la inspecci�n '+Finspeccion.FieldRequired,mtInformation,[mbOk],mbOk,0);
    ActivarDescactivar(True);
    if FVehiculo.FieldRequired <> '' then
      begin
        For ii:=0 to self.ComponentCount-1 do
          begin
            Try
            If (self.Components[ii] Is TDbEdit) then
              If TDbedit(self.Components[ii]).DataField=FVehiculo.FieldRequired then
                begin
                  TWinControl(self.Components[ii]).SetFocus;
                  exit;
                end;
            If (self.Components[ii] Is TDbDateEdit) then
              If TDbDateEdit(self.Components[ii]).DataField=FVehiculo.FieldRequired then
                begin
                  TWinControl(self.Components[ii]).SetFocus;
                  Exit;
                end;
            Except
            end;
          end;
      end;
  end;
end;


procedure TFRecepcion.GenerarInspeccion (const WithFacture : boolean);
begin
If Finspeccion.DataSet.State In [dsEdit,dsInsert] Then
  Finspeccion.Cancel;
fInspeccion.Append;
fInspeccion.ValueByName[FIELD_CODVEHIC] := fVehiculo.ValueByName[FIELD_CODVEHIC];
fInspeccion.ValueByName[FIELD_CODCLPRO] := fPropietario.ValueByName[FIELD_CODCLIEN];
fInspeccion.ValueByName[FIELD_CODCLCON] := fConductor.ValueByName[FIELD_CODCLIEN];
fInspeccion.ValueByName[FIELD_CODCLTEN] := fTenedor.ValueByName[FIELD_CODCLIEN];
fInspeccion.ValueByName[FIELD_INSPFINA] := INSP_NO_FINALIZADA;

if WithFacture then
  fInspeccion.ValueByName[FIELD_CODFACTU] := fFactura.ValueByName[FIELD_CODFACTU];
fInspeccion.ValueByName[FIELD_TIPO] := Chr(Ord(fVerificacion) +65);
fInspeccion.Post(True);
fInspeccion.Refresh;
end;


procedure TFRecepcion.GenerarFactura;
var
usuario:tusuario;
idusuario:smallint;
soloreve:string;

begin
fFactura.Open;          
if (fFactura.ValueByName[FIELD_IMPRESA] = FACTURA_NO_IMPRESA) Then
  begin
    ffactura.ffactadicionales.Close;
    ffactura.ffactadicionales.Free;
    fFactura.Close;
    fFactura.Free;
    ffactura := TFacturacion.CreateByRowId(MyBD,'');
    ffactura.Open;
  end;
fFactura.Append;
//mla

//ffactura.Post(true);
  case CBFacturarA.ItemIndex of
    0: begin
        TipoCliente(fPropietario);
        fFactura.ValueByName[FIELD_CODCLIEN] := fPropietario.ValueByName[FIELD_CODCLIEN];
        if  (trim(CBDescuentos.Text)='CONV R.U.C.A.R.A.') then
         fFactura.ValueByName[FIELD_TIPOCLIENTE_ID] := '12'
         else
        fFactura.ValueByName[FIELD_TIPOCLIENTE_ID] := fPropietario.ValueByName[FIELD_TIPOCLIENTE_ID];
    end;
    1: begin
        TipoCliente(fConductor);
        fFactura.ValueByName[FIELD_CODCLIEN] := fConductor.ValueByName[FIELD_CODCLIEN];
        if  (trim(CBDescuentos.Text)='CONV R.U.C.A.R.A.') then
         fFactura.ValueByName[FIELD_TIPOCLIENTE_ID] := '12'
        else
        fFactura.ValueByName[FIELD_TIPOCLIENTE_ID] := fConductor.ValueByName[FIELD_TIPOCLIENTE_ID];
    end;
    2: begin
        TipoCliente(fTenedor);
        fFactura.ValueByName[FIELD_CODCLIEN] := fTenedor.ValueByName[FIELD_CODCLIEN];
        if  (trim(CBDescuentos.Text)='CONV R.U.C.A.R.A.') then
         fFactura.ValueByName[FIELD_TIPOCLIENTE_ID] := '12'
        else
        fFactura.ValueByName[FIELD_TIPOCLIENTE_ID] := fTenedor.ValueByName[FIELD_TIPOCLIENTE_ID];
    end;
  end;

//actualizar  TIPOCLIENTE_ID en tclientes  se pierde al elegir un descuento y  luego cancelar -- laura
  With TSQLQuery.Create(Self) do
    try
      Close;
      SQL.Clear;
      SQLConnection:=mybd;
      SQL.Add('UPDATE TCLIENTES SET TIPOCLIENTE_ID = :TIPOCLIENTE_ID  WHERE CODCLIEN = :CODCLIEN');
      Params[0].Value:= fFactura.ValueByName[FIELD_TIPOCLIENTE_ID];
      Params[1].Value:=fFactura.ValueByName[FIELD_CODCLIEN] ;
      ExecSQL;
    finally
      free;
    end;
//----------------------mla-------------------------------------------------------------------------

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


 


    if CSinDatosCliente.Checked then
      fFactura.ValueByName[FIELD_SINDATOS] := SIN_DATOS_CLIENTE;

    fFactura.ValueByName[FIELD_IMPRESA]  := FACTURA_NO_IMPRESA;
    fFactura.ValueByName[FIELD_TIPFACTU] := PTipoFactura.Caption; // A � B
    fFactura.ValueByName[FIELD_TIPTRIBU] := Copy(CBTipoDeIVA.Items[CBTipoDeIVA.ItemIndex],1,1); // I, C, E, R, M
    fFactura.ValueByName[FIELD_ERROR] := FACTURA_ERRONEA;
    fFactura.ValueByName[FIELD_IVANOINS] := '0';

    if (fFactura.ValueByName[FIELD_TIPFACTU] = FACTURA_TIPO_A) and (fFactura.ValueByName[FIELD_TIPTRIBU] = IVA_NO_INSCRIPTO) then
      fFactura.ValueByName[FIELD_IVANOINS] := fVarios.ValueByName[FIELD_IVANOINS];

    fFactura.ValueByName[FIELD_IVAINSCR] := fVarios.ValueByName[FIELD_IVAINSCR];
    fFactura.ValueByName[FIELD_IIBB] := '0';
    fFactura.ValueByName[FIELD_IIBB_CABA] := '0';
    //ml
    fFactura.ValueByName[FIELD_IDCANCELACION]:='1';

    fFactura.Post(True);
    fFactura.Refresh;



    try
      fFactura.ffactAdicionales.Open;
    except
      on E: Exception do
        MessageDlg(Caption,Format('Error en la tabla: %s. Si el error persiste ind�quelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk],mbOk,0);
    end;
   {
    if (fFactura.ffactadicionales.ValueByName[FIELD_CODFACT] <> '') then
        (fFactura.ffactAdicionales.dataset As TClientDataset).RevertRecord;
   }
    try
      fFactura.ffactAdicionales.append
    except
      on E: Exception do
        MessageDlg(Caption,Format('Error en la tabla: %s. Si el error persiste ind�quelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk],mbOk,0);
    end;

    try
      fFactura.ffactAdicionales.valuebyname[FIELD_CODFACT]:=fFactura.ValueByName[FIELD_CODFACTU];            //
      usuario:=gestorseg.BuscarUsuario(applicationuser);
      idusuario:=usuario.obteneruid;
      fFactura.ffactAdicionales.valuebyname[FIELD_IDUSUARI]:= inttostr(idusuario);
      fFactura.ffactAdicionales.valuebyname[FIELD_PTOVENT]:= inttostr(FPtoventa.GetPtoVenta);

      if CBDescuentos.Text <> 'Cliente sin descuento' then
        fFactura.ffactAdicionales.ValueByName[FIELD_CODDESCU]:= FDescuento.ValueByName[FIELD_CODDESCU];

      if (fFactura.ffactAdicionales.valuebyname[FIELD_PTOVENT] = '-1') and  (TRIM(FPtoventa.ES_SOLO_REVE)<>'S') then
        begin
          raise Exception.Create (' Ha ocurrido una falla en el c�lculo del n�mero de Punto de Venta. Compruebe que el Controlador sea el correcto y funcione');
        end;

        if (TRIM(FPtoventa.ES_SOLO_REVE)='S') then
        begin
          fFactura.ffactAdicionales.valuebyname[FIELD_PTOVENT]:='0';

        end;


      fFactura.ffactAdicionales.valuebyname[FIELD_TIPOFAC]:=TIPO_FACTURA;

      if fFactura.TieneDescuento(fverificacion,fFactura.ffactAdicionales.ValueByName[FIELD_CODDESCU])then
        begin
          if (fDescuento.ValueByName[FIELD_PRESCOMPROB] = 'S') and (trim(CBDescuentos.Text)<>'CONV R.U.C.A.R.A.') then
            dodatosPromocion(ffactura.valuebyname[FIELD_CODFACTU], ffactura.valuebyname[FIELD_CODCLIEN], fDescuento.valuebyname[FIELD_CODDESCU],TIPO_VTV)
        end
      else
        begin
          if ffactura.EsDeOficial then
            begin
              dodatosPromocion(ffactura.valuebyname[FIELD_CODFACTU], ffactura.valuebyname[FIELD_CODCLIEN], DESCUENTO_USUARIO_PUBLICO,TIPO_VTV)
            end;
          ffactura.ffactadicionales.ValueByName[FIELD_CODDESCU]:='';
        end;

// -> Debido al cambio realizado para mostrar el importe cuando el pago es tarjeta. <- //
      if fFactura.ValueByName[FIELD_FORMPAGO] = FORMA_PAGO_TARJETA then
        fFactura.ffactAdicionales.post
      else
        fFactura.ffactAdicionales.post(true);
/////////////////////////////////////////////////////////////////////////////////////////

    except
      on E: Exception do
        begin
          MessageDlg(Caption,Format('Error: %s. Si el error persiste ind�quelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk],mbOk,0);
          fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FILE_NAME,'Ha ocurrido una falla en el c�lculo del n�mero de Punto de Venta')
        end;
    end;
end;


function TFRecepcion.BoxManAcceptTheInspection (const WithFacture: boolean) : boolean;
var
    bFueOK , DatosExternosCompletos : boolean;
    aCliente: Tclientes;
    sEje,sCod,sDes: String;
begin
bFueOk := FALSE;
  try
    fInspeccion.START;
    try
      if WithFacture then
        begin
          GenerarFactura;
         // CAMBIO  MB-   POR FORMULARIO DE TARJETA DE CREDITO QUE NO ABRIA
          {
           sEje := '2009';
           sCod := '-1';

          codigo_factura:=fFactura.ValueByName[FIELD_CODFACTU];
          codigo_vehiculo:=fvehiculo.ValueByName[FIELD_codvehic]  ;
          sDes := ffactura.ffactadicionales.valuebyname[FIELD_CODDESCU];


           if fFactura.ValueByName[FIELD_FORMPAGO] = FORMA_PAGO_TARJETA then
            begin
              fFactura.SetImportes(StrToInt(sEje), StrToInt(sCod), StrToInt( fFactura.ValueByName[FIELD_TIPOCLIENTE_ID]), fverificacion, sDes);
              imp:=fFactura.Monto;
              CreateFromBDImporte (ffactura, true, imp);
            end
          else

          if fFactura.ValueByName[FIELD_FORMPAGO] = FORMA_PAGO_CHEQUE then
          begin
            fFactura.SetImportes(StrToInt(sEje), StrToInt(sCod), StrToInt( fFactura.ValueByName[FIELD_TIPOCLIENTE_ID]), fverificacion, sDes);
            imp:=fFactura.Monto;
            DoPagoConChequeImporte(ffactura.valuebyname[FIELD_CODFACTU], fConductor.valuebyname[FIELD_CODCLIEN], imp)
          end;
          //------------------ }

          if fEstadoInsp=nil then
            GenerarInspeccion(WithFacture)
          else
            begin
              fInspeccion.Open;
              fInspeccion.ValueByName[FIELD_CODFACTU] := fFactura.ValueByName[FIELD_CODFACTU];
              if fVerificacion=fvReverificacion then
                fInspeccion.ValueByName[FIELD_TIPO] :=  Chr(Ord(fVerificacion) +65);
              fInspeccion.Post(true);
            end;

          DatosExternosCompletos:=true;
          if fVerificacionNueva = fvReverificacionExterna then
            if not DoRecogeDatosInspeccionExt(IntToStr(fInspeccion.GetValorSecuenciador), fVehiculo.ValueByName[FIELD_CODVEHIC],fInspeccion.ValueByName[FIELD_EJERCICI]) then
              DatosExternosCompletos:=False;

          sEje := fInspeccion.ValueByName[FIELD_EJERCICI];
          sCod := fInspeccion.ValueByName[FIELD_CODINSPE];
          sDes := ffactura.ffactadicionales.valuebyname[FIELD_CODDESCU];
      

          if fFactura.ValueByName[FIELD_FORMPAGO] = FORMA_PAGO_TARJETA then
            begin
              fFactura.SetImportes(StrToInt(sEje), StrToInt(sCod), StrToInt( fFactura.ValueByName[FIELD_TIPOCLIENTE_ID]), fverificacion, sDes);
              imp:=fFactura.Monto;
              CreateFromBDImporte (ffactura, true, imp);
            end
          else

          if fFactura.ValueByName[FIELD_FORMPAGO] = FORMA_PAGO_CHEQUE then
          begin
            fFactura.SetImportes(StrToInt(sEje), StrToInt(sCod), StrToInt( fFactura.ValueByName[FIELD_TIPOCLIENTE_ID]), fverificacion, sDes);
            imp:=fFactura.Monto;
            DoPagoConChequeImporte(ffactura.valuebyname[FIELD_CODFACTU], fConductor.valuebyname[FIELD_CODCLIEN], imp)
          end;


          fFactura.SetImportes(StrToInt(sEje), StrToInt(sCod), StrToInt( fFactura.ValueByName[FIELD_TIPOCLIENTE_ID]), fverificacion, sDes);
  //FIN CAMBIO

  ///control dobe factura



  //// *************************************


          if DatosCompletosPago and DatosExternosCompletos  then
            begin
              if fptoventa.getTipo = TIPO_MANUAL then
                begin
                  ffactura.ffactadicionales.close;

                  if fVerificacion  in [ fvNormal, fvVoluntaria,  fvPreverificacionOk] THEN
                  begin
                      if not fFactura.VerImprimirFactura (True, NIL) then
                        begin
                         fInspeccion.ROLLBACK;
                          bFueOk := FALSE;
                         end
                      else
                       begin
                         if fInspeccion.ValueByName[FIELD_CODINSPE] = '-1' then
                          fInspeccion.ValueByName[FIELD_CODINSPE] := IntToStr(fInspeccion.GetValorSecuenciador);
                          fInspeccion.Post(True,True);
                           GrabaInspEnVigente;
                           bFueOk := TRUE;
                       end
                    end
                  else
                    begin
                      if fInspeccion.ValueByName[FIELD_CODINSPE] = '-1' then
                        fInspeccion.ValueByName[FIELD_CODINSPE] := IntToStr(fInspeccion.GetValorSecuenciador);
                      fInspeccion.Post(True,True);
                      GrabaInspEnVigente;
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
                       2: aCliente := fTenedor;
                    end;
                      //*******************************************************

                      //*******************************************************
                  // fInspeccion.ValueByName[FIELD_TIPO] := Chr(Ord(fVerificacion) +65);
                   if (trim(fptoventa.ES_SOLO_REVE)<>'S') then
                   begin
                      if not fFactura.ImprimirFacturaCF(acliente,CBTipoDeIva.itemindex) then
                         begin
                           fInspeccion.ROLLBACK;
                           bFueOk := FALSE;
                         end
                          else
                           begin
                             if fInspeccion.ValueByName[FIELD_CODINSPE] = '-1' then
                                fInspeccion.ValueByName[FIELD_CODINSPE] := IntToStr(fInspeccion.GetValorSecuenciador);
                                fInspeccion.Post(True,True);
                                GrabaInspEnVigente;
                                bFueOk := TRUE;
                          end
                   end else begin
                       if fInspeccion.ValueByName[FIELD_CODINSPE] = '-1' then
                                fInspeccion.ValueByName[FIELD_CODINSPE] := IntToStr(fInspeccion.GetValorSecuenciador);
                                fInspeccion.Post(True,True);
                                GrabaInspEnVigente;
                                bFueOk := TRUE;

                   end
                  end
                else
                  begin
                    fInspeccion.ROLLBACK;
                    bFueOk := FALSE;
                    messagedlg(Caption,'El Punto de Venta conectado a su PC no es el correcto.'+#13
                    +'Por favor, realice las correcciones necesarias y vuelva a intentarlo.'+#13+
                    'Si el error persiste, comun�quelo al Jefe de Planta', mtError, [mbOk],mbOk,0);
                  end;
            end
          else
            begin
              fInspeccion.ROLLBACK;
              bFueOk := FALSE;
              messagedlg(Caption,'Faltan completar datos del Pago', mtError, [mbOk],mbOk,0);  //*********
            end;
        end
      else
        begin
          GenerarInspeccion(WithFacture);
          if fInspeccion.ValueByName[FIELD_CODINSPE] = '-1' then
            fInspeccion.ValueByName[FIELD_CODINSPE] := IntToStr(fInspeccion.GetValorSecuenciador);
          fInspeccion.Post(True,True);
          GrabaInspEnVigente;
          bFueOk := TRUE;
        end;
    except
      bFueOk := FALSE;
      fInspeccion.ROLLBACK;
      MessageDlg(Caption,'Falta completar datos de la inspecci�n',mtInformation,[mbOk],mbOk,0);
    end;
  finally
    result := bFueOk;
  end;
end;









 function TFRecepcion.EnviadaInspeccionALinea;
var
aQ: TSQLQuery;
matri:string;
existe:boolean;
begin
matri:=fVehiculo.GetPatente;




  try
    If fInspeccion.ValueByName[FIELD_WASPRE]<>'S' then //si no es una preverificacion a pagar
      begin



        fEstadoInsp := TEstadoInspeccion.CreateByRowId (MyBD, '');
        try
          fEstadoInsp.Open;
          fEstadoInsp.Append;


          try
            with fEstadoInsp do
              begin
                ValueByName[FIELD_EJERCICI] := fInspeccion.ValueByName[FIELD_EJERCICI];
                ValueByName[FIELD_CODINSPE] := fInspeccion.ValueByName[FIELD_CODINSPE];
                ValueByName[FIELD_TIPO] := fInspeccion.ValueByName[FIELD_TIPO];
                ValueByName[FIELD_MATRICUL] := fVehiculo.GetPatente;
                ValueByName[FIELD_ESTADO] := V_ESTADOS_INSP [teFacturado];
                ValueByName[FIELD_HORAINIC] := DateTimeBD(MyBD);
              end;
              fEstadoInsp.Post(true);
              result := TRUE;
          Except
            result := FALSE;
          end;
        finally
          fEstadoInsp.Close;
          fEstadoInsp.Free;
        end;
       // BorrarControlInsp(fVehiculo.GetPatente);

 
      end

    else
      begin  //Preverificacion
        aQ:=TSQLQuery.Create(self);
        with aQ do
          Try
            SQL.Clear;
            SQLConnection := MyBD;
            SQL.Add ('UPDATE TESTADOINSP SET ESTADO = ''' +V_ESTADOS_INSP [teRecibido_Ok]+''''+
                     ' WHERE EJERCICI = ' + fEstadoInsp.ValueByName[FIELD_EJERCICI]+
                     ' AND CODINSPE = '+fEstadoInsp.ValueByName[FIELD_CODINSPE]);
            ExecSql;
            result := TRUE;
          Finally
            try
              if MyBD.InTransaction then
                MyBD.Commit(td);
            Except
              result := FALSE;
            end;
            Close;
             Free;
             fEstadoInsp.Free;
             fEstadoInsp:=nil;
          end;
      end;
  except
    result := FALSE;
  end;


    



Application.ProcessMessages;
end;




    // Devuelve True si ha logrado enviar un trabajo correctamente al servidor de impresi�n
function TFRecepcion.FacturaImpresa: boolean;
var
dCabecera: tCabecera;
iServicio: tTrabajo;
bTodoOk : boolean;
begin
result := FALSE;

  try

    with dCabecera do
      begin
        iCodigoInspeccion := StrToInt(fInspeccion.ValueByName[FIELD_CODINSPE]);
        iEjercicio := StrToInt(fInspeccion.ValueByName[FIELD_EJERCICI]);
        sMatricula := fVehiculo.GetPatente;


        if (fFactura.ValueByName[FIELD_TIPFACTU] = CADENA_FACTURA_A) then
          iServicio := Factura_A ;


        if (fFactura.ValueByName[FIELD_TIPFACTU] = CADENA_FACTURA_B) then
          iServicio := Factura_B ;

       //MLAV554
        //mb 01.02.2016
       if fVerificacion in [fvReverificacion] THEN
        BEGIN
        IF  fFactura.ValueByName[FIELD_TIPFACTU] = 'N' then
           begin
            fFactura.ValueByName[FIELD_TIPFACTU]:= 'S';
            fFactura.ValueByName[FIELD_IMPRESA]:= 'S';
            fFactura.ValueByName[FIELD_IMPONETO]:= '0';
            fFactura.ValueByName[FIELD_NUMFACTU]:= '0';
            fFactura.Post(true);
            iServicio := NO_IMPRIME_REVE;
             bTodoOk:=true;
             result := TRUE;
            end;
        END;

        //mb 01.02.2016
        if  iServicio <> NO_IMPRIME_REVE then
         begin
         bTodoOk := TrabajoEnviadoOk (dCabecera, iServicio);
            if bTodoOk then
          begin
            fFactura.Refresh;
            fFactura.DevolverNumeroFactura(TIPO_FACTURA);
            result := TRUE;
          end;

         end;





      end

  except
    result := FALSE;
  end;
end;


// FACTURACION

    procedure TFRecepcion.CSinDatosClienteClick(Sender: TObject);
    begin
        if CSinDatosCliente.Checked
        then IDatosEnFactura.Picture := SinDatos.Picture
        else IDatosEnFactura.Picture := ConDatos.Picture;
    end;


    procedure TFRecepcion.BBPropietarioEnter(Sender: TObject);
    begin
        if Length(CENombrePropietario.Text) = 0
        then begin
            MostrarDatos_Cliente (fPropietario, CBTDPropietario.ItemIndex, CENroPropietario.Text);
            CENombrePropietario.Text := fPropietario.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
        end;
    end;

    procedure TFRecepcion.BBConductorEnter(Sender: TObject);
    begin
        if Length(CENombreConductor.Text) = 0
        then begin
            MostrarDatos_Cliente (fConductor, CBTDConductor.ItemIndex, CENroConductor.Text);
            CENombreConductor.Text := fConductor.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
        end;

    end;

    procedure TFRecepcion.BBTenedorEnter(Sender: TObject);
    begin
        if Length(CENombreTenedor.Text) = 0
        then begin
            MostrarDatos_Cliente (fTenedor, CBTDTenedor.ItemIndex, CENroTenedor.Text);
            CENombreTenedor.Text := fTenedor.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
        end;
    end;


    //Valida los datos introducidos
function TFRecepcion.ValidatePost: boolean;
begin
Result := False;

// Marca y Modelo del Veh�culo
if (CBMarca.Value = '') then
  begin
    MessageDlg (Application.Title, M_FALTAMARCA, mtInformation, [mbOk],mbOk,0);
    CBMarca.SetFocus;
    exit;
  end;
if (CBModelo.Value = '') then
  begin
    MessageDlg (Application.Title, M_FALTAMODELO, mtInformation, [mbOk],mbOk,0);
    CBModelo.SetFocus;
    exit;
  end;

// Es obligatorio introducir el propietario, conductor y tenedor
if ((CBTDPropietario.ItemIndex = -1) or (CENroPropietario.Text = '') or (CENombrePropietario.Text = '')) then
  begin
    MessageDlg (Application.Title, M_FALTAPROP, mtInformation, [mbOk],mbOk,0);
    CBTDPropietario.SetFocus;
    exit;
  end;

if ((CBTDConductor.ItemIndex = -1) or (CENroConductor.Text = '') or (CENombreConductor.Text = '')) then
  begin
    MessageDlg (Application.Title, M_FALTACOND, mtInformation, [mbOk],mbOk,0);
    CBTDConductor.SetFocus;
    exit;
  end;

if ((CBTDTenedor.ItemIndex = -1) or (CENroTenedor.Text = '') or (CENombreTenedor.Text = '')) then
  begin
    MessageDlg (Application.Title, M_FALTATEN, mtInformation, [mbOk],mbOk,0);
    CBTDTenedor.SetFocus;
    exit;
  end;

if fVerificacion in [fvNormal, fvVoluntaria, fvReverificacion, fvPreverificacionOk, fvVoluntariaReverificacion] then
  begin
  // Si el cliente es de cr�dito => se puede marcar veh�culo oficial
      {COMENTADO POR QUE LA FACTURA NO DEPDEND DEL CLIENTE }
      {
      if (CBFacturarA.ItemIndex = 0) then //Propietario
      begin
          if ((fPropietario.ValueByName[FIELD_CREDITCL] = 'N') and CEsDeCredito.Checked) then
          begin
              MessageDlg (Application.Title, M_CLICREDITO_OFICIAL_INC, mtInformation, [mbOk],mbOk,0);
              CBFacturarA.Setfocus;
              exit;
          end;
      end
      else if (CBFacturarA.ItemIndex = 1) then //Conductor
      begin
          if ((fConductor.ValueByName[FIELD_CREDITCL] = 'N') and CEsDeCredito.Checked) then
          begin
              MessageDlg (Application.Title, M_CLICREDITO_OFICIAL_INC, mtInformation, [mbOk],mbOk,0);
              CBFacturarA.setfocus;
              exit;
          end;
      end
      else // Tenedor
      begin
          if ((fTenedor.ValueByName[FIELD_CREDITCL] = 'N') and CEsDeCredito.Checked) then
          begin
              MessageDlg (Application.Title, M_CLICREDITO_OFICIAL_INC, mtInformation, [mbOk],mbOk,0);
              CBFacturarA.setfocus;
              exit;
          end;
      end;
      }

// Si el tipo de IVA es C.Final => se puede marcar Sin Datos Cliente
  if (((CBTipoDeIVA.ItemIndex <> 1) or (CBEsDeCredito.itemindex <> 0)) and (cSinDatosCliente.Checked) ) then
    begin
      MessageDlg (Application.Title, M_SINDATOSCLIENTE_INC, mtInformation, [mbOk],mbOk,0);
      CBTipoDeIVA.setfocus;
      exit;
    end;
  end;

if fPropietario.ValueByName[FIELD_IDLOCALIDAD] = '' then
  begin
    MessageDlg (Application.Title, MSJ_DATOS_CLIENTE, mtInformation, [mbOk],mbOk,0);
    exit;
  end;

if CBCombustible.ItemIndex = ord(ttcbGNC) then
  if DEVencGNC.Date = 0 then
    begin
      MessageDlg (Application.Title, M_FALTAVENC, mtInformation, [mbOk],mbOk,0);
      DEVencGNC.SetFocus;
      exit;
    end;

if (CBCombustible.ItemIndex = ord(ttcbGNC)) and (CEGNC.Text = '') then
  Begin
    MessageDlg (Application.Title, 'Debe ingresar el nro. de certificado', mtInformation, [mbOk],mbOk,0);
    CEGNC.SetFocus;
    exit;
  end;
  Result := True;
end;


    // True si el cliente ha pagado la inspeccion

    function TFRecepcion.InspeccionPagada: boolean;
    var
        aCliente : TClientes;
        ivacompr:integer;       //
        fDescuAplicado: TDescuento;
    begin
        // Nombre del cliente
        aCliente := nil;

        case CBFacturarA.ItemIndex of
            0: aCliente := fPropietario;
            1: aCliente := fConductor;
            2: aCliente := fTenedor;
        end;

        fDescuAplicado := TDescuento.CreateFromCoddescu(MyBd,fDescuento.valuebyname[FIELD_CODDESCU]);
        fDescuAplicado.open;

        with TFrmCaja.CreateFromBD (fFactura, aCliente, fVehiculo, fdescuAplicado) do
        try
            ivacompr:=cbtipodeiva.ItemIndex;
            if (ivacompr = 0) or (ivacompr = 2)or (ivacompr = 3)or (ivacompr = 4) then
            begin
                if CuitCorrecto(acliente.valuebyname[FIELD_CUIT_CLI]) then
                    result := Execute
                else
                    raise exception.Create('CUIT incorrecto');
            end
              else  result := Execute;

        finally
            Free;
            Application.ProcessMessages;
        end;
    end;



procedure TFRecepcion.BBPropietarioClick(Sender: TObject);
begin
MostrarDatos_Cliente (fPropietario, CBTDPropietario.ItemIndex, CENroPropietario.Text);
if Assigned(fPropietario) then
  CENombrePropietario.Text := fPropietario.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
CENroConductorChange(CENroConductor);
CENroTenedorChange(CENroTenedor);
CBFacturarAChange(CBFacturarA);
end;

procedure TFRecepcion.BBConductorClick(Sender: TObject);
begin
    MostrarDatos_Cliente (fConductor, CBTDConductor.ItemIndex, CENroConductor.Text);
    if Assigned(fConductor)
    then CENombreConductor.Text := fConductor.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
    CENroPropietarioChange(CENroPropietario);
    CENroTenedorChange(CENroTenedor);
    CBFacturarAChange(CBFacturarA);
end;

procedure TFRecepcion.BBTenedorClick(Sender: TObject);
begin
    MostrarDatos_Cliente (fTenedor, CBTDTenedor.ItemIndex, CENroTenedor.Text);
    if Assigned(fTenedor)
    then CENombreTenedor.Text := fTenedor.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
    CENroConductorChange(CENroConductor);
    CENroPropietarioChange(CENroPropietario);
    CBFacturarAChange(CBFacturarA);
end;

procedure TFRecepcion.BBModeloClick(Sender: TObject);
begin
    NuevoModelo;
    Perform (WM_NEXTDLGCTL, 0, 0)
end;

procedure TFRecepcion.DEMatriculadoExit(Sender: TObject);
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

procedure TFRecepcion.DEMatriculadoChange(Sender: TObject);
begin
    if firstActivating then  // para que cuando se crea el formulario no tenga en cuenta el onchage, asi carga el
                             // dato del a�o de fabricacion de la base de datos
    begin

      firstActivating := false
    end
    else
    Try
        StrToDate(DEMatriculado.Text);
        CEFabricado.Text := IntToStr(ExtractYear(DEMatriculado.Date));
        fVehiculo.ValueByName[FIELD_ANIOFABR] := CEFabricado.Text;
    Except
        //CEFabricado.Text := '';
    end;
end;

procedure TFRecepcion.CENroPropietarioMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    If CBTDPropietario.ItemIndex<>4
    Then
        (Sender as TColorEdit).Hint:='N�mero de documento del propietario del veh�culo'
    else
        (Sender as TColorEdit).Hint:='N�mero de documento del propietario del veh�culo."00-00000000-0"';
end;

procedure TFRecepcion.CENroConductorMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    If CBTDConductor.ItemIndex<>4
    Then
        (Sender as TColorEdit).Hint:='N�mero de documento del condcutor del veh�culo'
    else
        (Sender as TColorEdit).Hint:='N�mero de documento del conductor del veh�culo."00-00000000-0"';

end;

procedure TFRecepcion.CENroTenedorMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    If CBTDTenedor.ItemIndex<>4
    Then
        (Sender as TColorEdit).Hint:='N�mero de documento del tenedor del veh�culo'
    else
        (Sender as TColorEdit).Hint:='N�mero de documento del tenedor del veh�culo."00-00000000-0"';
end;

procedure TFRecepcion.CENroPropietarioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    if (Shift = [ssCtrl])
    then (Sender as TColorEdit).Clear;
end;

procedure TFRecepcion.EsOficialClick(Sender: TObject);
var aCliente: Tclientes;    //
begin
if EsOficial.Checked then
  begin
    Sirena.Visible := True;
    Sirena.Animate := True;
    if fVerificacion in [fvNormal, fvVoluntaria, fvReverificacion, fvPreverificacionOk, fvVoluntariaReverificacion] then
    //CEsDeCredito.Checked := True;
      begin
        CBEsDeCredito.ItemIndex:=2;
        PFormaDePago.Caption := ' Cuenta Cte';
        PFormaDePago.Font.Color := clRed;
        IFormaDePago.Picture := Ctacte.Picture;
      end;
  end
else
  begin
    Case CBFacturarA.ItemIndex of
      0: aCliente := fPropietario;
      1: aCliente := fConductor;
      2: aCliente := fTenedor;
    else
      aCliente := Nil;
    end;

    if aCliente <> nil then
      if (aCliente.ValueByName[FIELD_CREDITCL] = 'S') then
        begin
          CBEsDeCredito.ItemIndex := 2;
          PFormaDePago.Caption := 'Cuenta Cte';
          PFormaDePago.Font.Color := ClRed;
          IFormaDePago.Picture := Ctacte.Picture;
        end
      else
        begin
          CBEsDeCredito.ItemIndex := 0;
          PFormaDePago.Caption := 'Contado';
          PFormaDePago.Font.Color := ClOlive;
          IFormaDePago.Picture := Money.Picture;
        end;
        Sirena.Animate := False;
        Sirena.Visible := False;
  end;
end;

procedure TFRecepcion.CBEsDeCreditoClick(Sender: TObject);
begin

  if EsOficial.Checked then
  begin
     CBEsDeCredito.itemindex:=2;
     PFormaDePago.Caption := ' Cuenta Cte';
     PFormaDePago.Font.Color := clRed;
     IFormaDePago.Picture := ctacte.Picture;
  end
  else
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

function TFRecepcion.datoscompletosPago: boolean;
var fCheque: TCheque;
    fPromocion: TDatosPromocion;
begin
  result:=true;

  if fFactura.TieneDescuento(fverificacion,ffactura.ffactadicionales.valuebyname[FIELD_CODDESCU]) then                                  
  begin
     if (fDescuento.ValueByName[FIELD_PRESCOMPROB] = 'S')  AND (trim(CBDescuentos.Text)='CONV R.U.C.A.R.A.')  THEN
        result:=true

       ELSE BEGIN
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


  if ffactura.valuebyname[FIELD_FORMPAGO] = FORMA_PAGO_TARJETA then
  begin
    if (ffactura.ffactadicionales.ValueByName[FIELD_CODTARJET]='') or (ffactura.ffactadicionales.ValueByName[FIELD_NUMTARJET]='')
    or (ffactura.ffactadicionales.ValueByName[FIELD_FECHAVEN]='') or (ffactura.ffactadicionales.ValueByName[FIELD_CANTCUOT]='') then
    result:=false;
  end
  else
    if ffactura.valuebyname[FIELD_FORMPAGO] = FORMA_PAGO_CHEQUE then
    begin
      fCheque:=nil;
      try
        fCheque:=TCheque.CreateFromFactura(MyBD,ffactura.valuebyname[FIELD_CODFACTU]);
        fCheque.open;
        if fCheque.RecordCount > 0 then
        begin
          if (fCheque.ValueByName[FIELD_NUMCHEQUE]='') or (fCheque.ValueByName[FIELD_FECHPAGO]='') then
            result:=false;
        end
        else
          result:=false;

      finally
        fCheque.close;
        fCheque.Free;
      end;

    end;
  if ffactura.EsDeOficial then
  begin
       fPromocion:=nil;
       try
          fPromocion:=TDatosPromocion.CreateFromFactura(MyBd,ffactura.valuebyname[FIELD_CODFACTU],ffactura.valuebyname[FIELD_CODCLIEN],DESCUENTO_USUARIO_PUBLICO);
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

procedure TFRecepcion.CBEsDeCreditoChange(Sender: TObject);
var aCliente: TClientes;
begin
     case CBFacturarA.ItemIndex of
        0: aCliente := fPropietario;
        1: aCliente := fConductor;
        2: aCliente := fTenedor;
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

     if  (aCliente <> nil) and (aCliente.ValueByName[FIELD_CREDITCL] = 'N') and (CBEsDeCredito.itemindex = 2) and (EsOficial.Checked = False) then
     begin
       MessageDlg (Application.Title, M_NOCREDITO, mtError, [mbOk],mbOk,0);
       CBEsDeCredito.itemindex := 0;
       PFormaDePago.Caption := ' Contado';
       PFormaDePago.Font.Color := clOlive;
       IFormaDePago.Picture := Money.Picture;
     end;
end;

procedure TFRecepcion.CBDescuentosEnter(Sender: TObject);
begin
DestacarControl (Sender, $00215FEF, clWhite, FALSE);
end;

procedure TFRecepcion.CBDescuentosExit(Sender: TObject);
begin
if CBDescuentos.Text = 'Cliente sin descuento' then
  AtenuarControl(Sender, FALSE);
end;

procedure TFRecepcion.CBEsDeCreditoEnter(Sender: TObject);
begin
        DestacarControl (Sender, clGreen, clWhite, FALSE);
end;

procedure TFRecepcion.CBEsDeCreditoExit(Sender: TObject);
begin
        AtenuarControl(Sender, FALSE);
end;

procedure TFRecepcion.TipoCliente (var aCliente: tclientes);
begin
//*********************************************************//
//*********************************************************//
//**    Calcular el tipo de usuario segun vtv vigente    **//
//*********************************************************//
//*********************************************************//


if fVerificacion <> fvReverificacion then
  if not CalculaVTVVigente(aCliente) then
    raise Exception.Create('Algo anda mal !!!');

  {if (fEspecies.ValueByName[FIELD_TIPOVEHI] = '1') then
    if (((((aCliente.valuebyname[FIELD_TIPOCLIENTE_ID]<>TIPO_CLIENTE_NORMAL) and
       (aCliente.valuebyname[FIELD_TIPOCLIENTE_ID]<>TIPO_CLIENTE_DISCAPACITADO)) and
       (aCliente.valuebyname[FIELD_TIPOCLIENTE_ID]<>TIPO_CLIENTE_MUNICIPAL))and
       (aCliente.valuebyname[FIELD_TIPOCLIENTE_ID]<>TIPO_CLIENTE_BOMBERO)))  then

      begin
        aCliente.edit;
        aCliente.ValueByName[FIELD_TIPOCLIENTE_ID] := TIPO_CLIENTE_NORMAL;
        aCliente.Post(true);
      end; }
       {  if (fEspecies.ValueByName[FIELD_TIPOVEHI] = '1') then
    if ((aCliente.valuebyname[FIELD_TIPOCLIENTE_ID]<>TIPO_CLIENTE_NORMAL)and
 (aCliente.valuebyname[FIELD_TIPOCLIENTE_ID]<>TIPO_CLIENTE_NORMAL_VIG)) then
      begin
        aCliente.edit;
        aCliente.ValueByName[FIELD_TIPOCLIENTE_ID] := TIPO_CLIENTE_NORMAL;
        aCliente.Post(true);
      end;  }


      //******************ml/////10-05-2010****

       if (fEspecies.ValueByName[FIELD_TIPOVEHI] = '1') then
    if   ((((((aCliente.valuebyname[FIELD_TIPOCLIENTE_ID]<>TIPO_CLIENTE_NORMAL)and (aCliente.valuebyname[FIELD_TIPOCLIENTE_ID]<>TIPO_CLIENTE_NORMAL_VIG))  and (aCliente.valuebyname[FIELD_TIPOCLIENTE_ID]<>TIPO_CLIENTE_DISCAPACITADO)) and (aCliente.valuebyname[FIELD_TIPOCLIENTE_ID]<>TIPO_CLIENTE_MUNICIPAL)) and (aCliente.valuebyname[FIELD_TIPOCLIENTE_ID]<>TIPO_CLIENTE_BOMBERO)) and (aCliente.valuebyname[FIELD_TIPOCLIENTE_ID]<>TIPO_CLIENTE_MAY20)) then
      begin
        aCliente.edit;
        aCliente.ValueByName[FIELD_TIPOCLIENTE_ID] := TIPO_CLIENTE_NORMAL;
        aCliente.Post(true);
      end;

end;


procedure TFRecepcion.chkbGNCClick(Sender: TObject);
begin
  pGNC.Visible := chkbGNC.Checked;
end;

procedure TFRecepcion.DEVencGNCExit(Sender: TObject);
begin
    //Validar Fecha introducida
    AtenuarControl(Sender, TRUE);
    Try
        StrToDate((Sender as TDBDateEdit).Text);
    Except
        Messagedlg(Caption,'Introduzca una fecha correcta',mtInformation,[mbok],mbok,0);
        (Sender as TDBDateEdit).Date:=Date;
        (Sender as TDBDateEdit).SetFocus;
    end;
end;

procedure TFRecepcion.GenerarVehiculo_GNC;
begin
   fVehiculos_GNC := nil;
   if espreve = fvpreverificacionok then
   begin
      fVehiculos_GNC := TVehiculos_GNC.CreateByCodinspe(mybd, fAllInspections.ValueByName[FIELD_CODINSPE]);
      fVehiculos_GNC.Open;
      fVehiculos_GNC.Edit;
      DSToVehGNC.DataSet := fVehiculos_GNC.DataSet;
   end
   else
   begin
     fVehiculos_GNC := TVehiculos_GNC.CreateByRowId(MyBD,'');
     fVehiculos_GNC.Open;
     fVehiculos_GNC.Append;
     DSToVehGNC.DataSet := fVehiculos_GNC.DataSet;
   end;
end;

procedure TFRecepcion.CancelarVehiculo_GNC;
begin
  if Assigned(fvehiculos_GNC) then
    try
      fVehiculos_GNC.Cancel;
      fVehiculos_GNC.Free;
      fVehiculos_GNC := nil;
    except
      on E: Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error al intentar cancelar un Vehiculo_GNC por :%s',[E.Message]);
        end
    end;
end;

procedure TFRecepcion.CompletarVehiculo_GNC;
begin
  try
    with fVehiculos_GNC do
    begin
      valuebyname[FIELD_EJERCICI] := finspeccion.valuebyname[FIELD_EJERCICI];
      valuebyname[FIELD_CODINSPE] := finspeccion.valuebyname[FIELD_CODINSPE];
      valuebyname[FIELD_CODVEHIC] := finspeccion.valuebyname[FIELD_CODVEHIC];
      valuebyname[FIELD_NCERTGNC] := CEGNC.text;
      post(true);
    end;
  except
      on E: Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error al intentar grabar un Vehiculo_GNC por :%s',[E.Message]);
            MessageDlg(Caption,Format('Error al intentar grabar un Vehiculo_GNC por: %s.',[E.message]), mtInformation, [mbOk],mbOk,0);
        end
  end;
end;


procedure TFRecepcion.CENroPropietarioKeyPress(Sender: TObject;
  var Key: Char);
begin
if CBTDPropietario.Text = 'CUIT' then
  Begin
    if not (Key in ['0'..'9',char(VK_BACK),'-']) then
      key := #0
    else
    if Key = Char(VK_SPACE) then
      Key := #0;
  end
else
  Begin
  if not (Key in ['0'..'9',char(VK_BACK)]) then
    key := #0
  else
  if Key = Char(VK_SPACE) then
    Key := #0;
  end;
end;


function TFRecepcion.CalculaVTVVigente(var aCliente: tclientes): boolean;
var
  usuarioant: integer;
  claveant, numoblea, idusuario, zona, planta, fechavencevigente,RESULTADOEXTERNA:string;
  GestorSegAnt: TGestorSeg;
  ultvenc : tinspeccion;

    function VigenteEnPlanta: boolean;
    begin
         result := false;
         ultvenc := fVehiculo.GetUltimoVencimientoSinPreve;
         try
           if Assigned(ultvenc) then
           begin
             ultvenc.Open;
             if (ultvenc.RecordCount > 0) and (ultvenc.InspeccionVigenteCon30) then
             begin
               numoblea := ultvenc.ValueByName[FIELD_NUMOBLEA];
               result := true;
             end;
           end;
         finally
           ultvenc.Free;
         end;
    end;

    
procedure AsignaVigenteAuto( aTipo: char);
Begin
fInspVigente := nil;
fInspVigente :=  TInspVigente.createbyrowid(mybd,'');
with fInspVigente do
  try
    open;
    Append;
    ValueByName[FIELD_TIPO] := aTipo;
    case aTipo of
      TIPO_VIGENTE:
          begin
            ValueByName[FIELD_ZONA] := fVarios.ValueByName[FIELD_ZONA];
            ValueByName[FIELD_PLANTA] := fVarios.ValueByName[FIELD_ESTACION];
            ValueByName[FIELD_NUMOBLEA] := numoblea;
          end;
      TIPO_SUPERVISOR:
          begin
            ValueByName[FIELD_IDUSUARIO] := idusuario;
          end;
      TIPO_OTRA_PLANTA:
          begin
            ValueByName[FIELD_ZONA] := zona;
            ValueByName[FIELD_PLANTA] := planta;
            ValueByName[FIELD_NUMOBLEA] := numoblea;
            ValueByName['FECHAVENCI'] := fechavencevigente ;
             ValueByName['FECHALTA'] := DATETOSTR(DATE);



          end;
    end;
    POST;
  except
    on E: Exception do
      begin
        fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error al intentar grabar Insp_Vigente por :%s',[E.Message]);
        MessageDlg(Caption,Format('Error al intentar grabar Insp_Vigente por : %s. ',[E.message]), mtInformation, [mbOk],mbOk,0);
      end
  end;
if (aCliente.valuebyname[FIELD_TIPOCLIENTE_ID] = TIPO_CLIENTE_TPP) then
  begin
    aCliente.edit;
    aCliente.ValueByName[FIELD_TIPOCLIENTE_ID] := TIPO_CLIENTE_TPP;
    aCliente.Post(true);
  end
else
////////////////////////////////////////////////////////////////////////////////////////////////////
//  Si es distinto a Moto, entonces hago como siempre, en caso que sea una moto la de la          //
//  VTV Vigente, entonces al tipo de cliente le pongo TIPO_CLIENTE_NORM_MOTO_VIG                  //
////////////////////////////////////////////////////////////////////////////////////////////////////
{  if (fEspecies.ValueByName[FIELD_TIPOVEHI] <> '1') then
    Begin
      if fVehiculo.EsMayorA20 then
        begin
          aCliente.edit;
          aCliente.ValueByName[FIELD_TIPOCLIENTE_ID] := TIPO_CLIENTE_MAY20;
          aCliente.Post(true);
        end
      else
        begin
          aCliente.edit;
          aCliente.ValueByName[FIELD_TIPOCLIENTE_ID] := TIPO_CLIENTE_NORMAL_VIG;
          aCliente.Post(true);
        end;
    end
  else
    Begin
      aCliente.edit;
      aCliente.ValueByName[FIELD_TIPOCLIENTE_ID] := TIPO_CLIENTE_NORM_MOTO_VIG;
      aCliente.Post(true);
    end;
////////////////////////////////////////////////////////////////////////////////////////////////////
}
if fVehiculo.EsMayorA20 then
  begin
    aCliente.edit;
    aCliente.ValueByName[FIELD_TIPOCLIENTE_ID] := TIPO_CLIENTE_MAY20;
    aCliente.Post(true);
  end
else
  begin
    aCliente.edit;
    aCliente.ValueByName[FIELD_TIPOCLIENTE_ID] := TIPO_CLIENTE_NORMAL_VIG;
    aCliente.Post(true);
  end;
end;



    function SolicitaOblea: boolean;
    begin
      result := false;
      if not GetObleaPlanta(zona, planta, numoblea, fechavencevigente) then exit;
      result := true;
    end;

    function PideClaveJefe: boolean;
    begin
      try
        result := false;
        UsuarioAnt:=applicationuser;
        ClaveAnt:=PasswordUser;
        GestorSegAnt:=GestorSeg;
        if not PermitidoAcceso(applicationuser,PasswordUser,GestorSeg,'Autorizaci�n Supervisor',FALSE,'ACCESO') then
          exit;
        if not AccederAServicio(ID_SERVICIO_AUTORIZA_VIGENTE,ApplicationUser,PasswordUser, GestorSeg) then
          exit;
        idusuario := inttostr(applicationuser);
        result := true;
      finally
        if UsuarioAnt <> applicationuser then
          applicationUser := UsuarioAnt;
        if ClaveAnt <> PasswordUser then
          PasswordUser := ClaveAnt;
        if GestorSegAnt <> GestorSeg then
          GestorSeg := GestorSegAnt;
      end;
    end;

    procedure AsignaNoVigenteAuto;
    begin
         aCliente.edit;
         aCliente.ValueByName[FIELD_TIPOCLIENTE_ID] := TIPO_CLIENTE_NORMAL;
         aCliente.Post(true);
    end;

begin
  result := false;
  if strtoint(aCliente.valuebyname[FIELD_TIPOCLIENTE_ID]) in
    [strtoint(TIPO_CLIENTE_NORMAL),strtoint( TIPO_CLIENTE_NORMAL_VIG),strtoint( TIPO_CLIENTE_MAY20),strtoint( TIPO_CLIENTE_TPP)] then
  begin
    if VigenteEnPlanta or fVehiculo.EsMenorA2M THEN
    begin
      AsignaVigenteAuto(TIPO_VIGENTE);
      result := true;
    end
    else
    begin
      if application.MessageBox('�El veh�culo tiene VTV vigente en otra planta?','VTV Vigente',mb_yesno+mb_applmodal+mb_iconquestion+mb_defbutton2) = 6 then
      begin
        if SolicitaOblea then
        begin
          AsignaVigenteAuto(TIPO_OTRA_PLANTA);
          result := true;
        end;
      end
      else
      begin
        if application.MessageBox('�VTV vigente autorizada por el Supervisor?','VTV Vigente',mb_yesno+mb_applmodal+mb_iconquestion+mb_defbutton2) = 6 then
        begin
          if PideClaveJefe then
          begin
            AsignaVigenteAuto(TIPO_SUPERVISOR);
            result := true
          end;
        end
        else
        begin
          AsignaNoVigenteAuto;
          result := true;
        end;
      end;
    end;
  end
  else
    result := true;
end;

procedure TFRecepcion.GrabaInspEnVigente;
begin
     If Assigned (finspVigente) then
     begin
          fInspVigente.Edit;
          fInspVigente.ValueByName[FIELD_EJERCICI] := fInspeccion.ValueByName[FIELD_EJERCICI];
          fInspVigente.ValueByName[FIELD_CODINSPE] := fInspeccion.ValueByName[FIELD_CODINSPE];
          fInspVigente.post(true);
     end;
end;

procedure TFRecepcion.CENroConductorKeyPress(Sender: TObject;
  var Key: Char);
begin
if CBTDConductor.Text = 'CUIT' then
  Begin
    if not (Key in ['0'..'9',char(VK_BACK),'-']) then
      key := #0
    else
    if Key = Char(VK_SPACE) then
      Key := #0;
  end
else
  Begin
  if not (Key in ['0'..'9',char(VK_BACK)]) then
    key := #0
  else
  if Key = Char(VK_SPACE) then
    Key := #0;
  end;
end;

procedure TFRecepcion.CENroTenedorKeyPress(Sender: TObject; var Key: Char);
begin
if CBTDTenedor.Text = 'CUIT' then
  Begin
    if not (Key in ['0'..'9',char(VK_BACK),'-']) then
      key := #0
    else
    if Key = Char(VK_SPACE) then
      Key := #0;
  end
else
  Begin
  if not (Key in ['0'..'9',char(VK_BACK)]) then
    key := #0
  else
  if Key = Char(VK_SPACE) then
    Key := #0;
  end;
end;

{
Procedure BorrarControlInsp(Patente :string);
Begin
//MLA borro del tcontrolinsp la patente ya que ahora se controla desde testadoinp
//para uqe no se dupliquen en la l�nea. 07-2010
 {{
  with TSQLQuery.Create(nil) do
  try
     begin
       SQLConnection:=mybd;
       SQL.Clear;
       SQL.Add('DELETE  TCONTROLINSP WHERE MATRICUL=:MATRICUL');
       ParamByName('MATRICUL').Value:=Patente;
       ExecSQL;
     end;
     finally
       Free;
     end

//end;}
end.
//Final de la unidad





