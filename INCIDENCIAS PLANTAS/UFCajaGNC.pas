unit UFCAJAGNC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons,
  ULOGS, UCDIALGS, USAGCLASSES, Mask, globals, EPSON_impresora_Fiscal_TLB, ComObj,uconversiones, ucontstatus,
  uftmp, db, sqlexpr;

type
  TFrmCajaGNC = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    Bevel1: TBevel;
    Bevel2: TBevel;
    lblNumeroFactura: TLabel;
    lblPersonaFacturar: TLabel;
    lblMatricula: TLabel;
    lblNombreClienteAFacturar: TLabel;
    lblMatriculaVehiculo: TLabel;
    lblAPagar: TLabel;
    lblEntregado: TLabel;
    lblADevolver: TLabel;
    lblCantidadADevolver: TLabel;
    edtNumeroFacturaReal: TMaskEdit;
    lblMoneda1: TLabel;
    lblMoneda2: TLabel;
    lblMoneda3: TLabel;
    edtCantidadEntregada: TEdit;
    lblCantidadAPagar: TLabel;
    lblTipoFactura: TLabel;
    Timer1: TTimer;
    Label1: TLabel;
    lblforpago: TLabel;
    Label2: TLabel;
    lblCantDescu: TLabel;
    lblImpDescu: TLabel;
    Bevel3: TBevel;
    procedure btnCancelarClick(Sender: TObject);
    procedure edtNumeroFacturaRealKeyPress(Sender: TObject; var Key: Char);
    procedure edtCantidadEntregadaKeyPress(Sender: TObject; var Key: Char);
    procedure btnAceptarClick(Sender: TObject);
    procedure edtNumeroFacturaRealEnter(Sender: TObject);
    procedure edtNumeroFacturaRealExit(Sender: TObject);
    procedure edtCantidadEntregadaExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    fCliente : TClientes;
    fVehiculo : TVehiculo;
    fFactura : TFacturacion;
    fDescuento: TDescuentoGNC;
    fDatosEstacion: TDatos_estacion;
    fptoventa: tptoventa;   //
    impfis: _PrinterFiscalDisp;
    fInspeccion: TInspgnc;
    imprimiolinea: boolean;     //para que no imprima mas de una vez el item del ticket
    estadoticket:integer;    //Para saber en que etapa esta el ticket (en el encabezado, en el detalle, etc);
    usuario: Tusuarios;
    fFactDescuento: TFacturacion;
    fcheque: TCheque;
    //function CambiarNumeroFactura (iCodigoFac, iNumeroFac: integer): boolean;
    function PagaBien: boolean;
    Function IsPossibleZero: Boolean;
    function AbrirTicket:boolean;   //
    function ImprimirLineaComun(ainspeccion: TinspGNC):boolean;   //
    function ImprimirLineaDescuento(ainspeccion: TinspGNC):boolean;   //
    function CerrarTicket:boolean;
    procedure AbrirNoFiscal;
    procedure ImprimirLineaDNF(ainspeccion: TinspGNC);
    function CerrarDNF:boolean;
    procedure datosencabezado;
  public
    constructor CreateFromBD (const aFactura: TFacturacion; const aCliente : Tclientes; const aVehiculo: TVehiculo; const adescuento: TDescuentoGNC);
    function Execute : boolean;
  end;

var
  FrmCajaGNC: TFrmCajaGNC;
    tipodf,saliimp,letradoc,cantcopi,tipoform,tipoletra,ivaemisor,ivacompr,l1nombre,l2nombre,
    tipodoc,nrodoc,bienuso,l1domic,l2domic,l3domic,l1remito,l2remito,tipotab,tipostatus,tipopago,
    descitem,cant,precio,iva,tipoitem,cantbult,impintporc,l1extra,l2extra,l3extra,tasa,impintfijo,
    montopago,textonf,accion,dfnumero,texto:widestring;
    imp : double;

implementation

uses
   UINTERFAZUSUARIO,
   USAGESTACION,
   UUtils,
   UCTIMPRESION, //
   UCLIENTE;


{$R *.DFM}

resourcestring
      FICHERO_ACTUAL = 'UFCaja';
      // Captionde los mensajes que se van a dar al usuario del form
      CABECERA_MENSAJES_CAJA = 'Caja';

      MSJ_CAJA_CANTIDADINS = 'La cantidad entregada es insuficiente';
      MSJ_CAJA_CANCELACION = 'La factura ya está emitida. ¿Desea cancelarla?';
      MSJ_CAJA_CAMBIARFACT = '¿Realmente desea cambiar el número de factura?';
      MSJ_CAJA_CANTIDADERR = 'La cantidad entregada es incorrecta';
      MSJ_CAJA_NUMFACTEXIST = 'Si desea cambiar el número de factura deberá poner ' +
                             'un número cuya factura no se haya emitido anteriormente. ' +
                             'Además debería cambiar el próximo número de factura en la ' +
                             'pantalla de DATOS VARIABLES.';
      MSJ_CAJA_NUMFACERR = 'No se ha introducido un nuevo número de factura o éste es incorrecto. Introdúzcalo de nuevo por favor.';
      MSJ_WRONG_NUMFACTU = '¡ Número de Facturas Erroneo o Duplicado !';

      CADENA_FACTURA_A = 'A';
      CADENA_FACTURA_B = 'B';

constructor TFrmCajaGNC.CreateFromBD (const aFactura: TFacturacion; const aCliente : TClientes; const aVehiculo: TVehiculo; const adescuento: TDescuentoGNC);
begin
    inherited Create(Application);
    fFactura := aFactura;
    if assigned (fFactura.ffactadicionales) then
                fFactura.ffactadicionales.close;   //MULTI
    fFactura.ffactadicionales:=tFact_adicionales.CreateFromFactura(MyBD,Ffactura.valuebyname[FIELD_CODFACTU],TIPO_FACTURA,TIPO_FACTURAGNC);   
    fFactura.ffactadicionales.Open;  //MULTI
    fCliente := aCliente;
    fVehiculo := aVehiculo;
    fDescuento := aDescuento;
end;

procedure TFrmCajaGNC.FormShow(Sender: TObject);
var
      FBusqueda: TFTmp;
begin
    estadoticket:=0;                //Ticket no esta abierto todavia
    fbusqueda:= TFTmp.create(application);
    with fbusqueda do
    try
      muestraclock('Facturación','Imprimiendo el encabezado de la Factura');
      try
        fptoventa:=nil;
        fptoventa:=tptoventa.create(MyBD);       //
        fptoventa.Open;
        fFactura.Open;
        ffactura.ffactadicionales.open;
        Try
            fFactura.Edit;
            ffactura.ffactadicionales.Edit;  //
        Except
            On E: Exception do;
        end;
        fcheque:=nil;
        lblTipoFactura.Caption := fFactura.ValueByName[FIELD_TIPFACTU];
        imp := fFactura.Monto;
        lblMatriculaVehiculo.Caption := fVehiculo.GetPatente;
        lblNombreClienteAFacturar.Caption := fCliente.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
        lblCantidadAPagar.Caption := Format ('%1.2f',[imp]);
        edtCantidadEntregada.Text := lblCantidadAPagar.Caption;
        lblCantidadADevolver.Caption := '0,00';


        if ffactura.valuebyname[FIELD_FORMPAGO] = FORMA_PAGO_METALICO then
        begin
            lblforpago.caption:='Contado';
        end
        else
          if ffactura.valuebyname[FIELD_FORMPAGO] = FORMA_PAGO_CREDITO then
          begin
            lblforpago.caption:='Cuenta Corriente';
          end
          else
          if ffactura.valuebyname[FIELD_FORMPAGO] = FORMA_PAGO_TARJETA then
          begin
            lblforpago.caption:='Tarjeta de Credito';
          end
          else
          begin
            lblforpago.caption:='Pago con Cheque';
            fcheque:=tcheque.CreateFromFactura(Mybd,ffactura.valueByName[FIELD_CODFACTU]);
            fcheque.open;
            fcheque.Edit;
            fcheque.valuebyName[FIELD_IMPORTE]:=format('%1.2f',[imp]);
          end;
        if fptoventa.GetTipo = TIPO_MANUAL THEN
        begin
          edtNumeroFacturaReal.Text := fFactura.DevolverNumeroFactura(TIPO_FACTURAGNC);
          if ((imp = 0)  and (Not(IsPossibleZero)))
            then btnAceptar.Enabled := False;
          btnAceptar.ModalResult := mrNone;
          btnCancelar.ModalResult := mrNone;
        end
        else
        begin
          if strtofloat(ffactura.ValueByName[FIELD_IMPONETO]) = 0 then
          begin
            AbrirNoFiscal;
            lblTipoFactura.Caption := 'N';
          end
          else
          begin
            if not AbrirTicket then timer1.enabled:=true ;
          end;
          btnAceptar.ModalResult := mrNone;
          btnCancelar.ModalResult := mrNone;
          edtNumeroFacturaReal.enabled:=false;
        end;
      except
        on E: Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'Error extraño en la inicialización de la ficha: %s', [E.message]);
            raise
        end;
      end;
    finally
        fbusqueda.close;
        fbusqueda.free;
    end;
end;

function TFrmCajaGNC.Execute: boolean;
begin
    try
        result := FALSE;
        if ShowModal = mrOk
        then begin
//            fFactura.VAlueByName[FIELD_NUMFACTU] := Trim(Copy(edtNumeroFacturaReal.Text,6,Length(edtNumeroFacturaReal.Text)));  
//            fFactura.ValueByName[FIELD_ERROR]:='N';
            result := TRUE;
        end;
        fFactura.ffactadicionales.Post(TRUE);
        fFactura.Post(TRUE);
    except
        result := FALSE;
    end;
end;

procedure TFrmCajaGNC.EdtCantidadEntregadaKeyPress(Sender: TObject; var Key: Char);
begin
    if (Key = Chr(VK_RETURN)) then
    begin
        PagaBien;
        Key := #0;
    end;
end;

// Comprueba si la cantidad entregada por el cliente es correcta, devolviendo en este caso True
function TFrmCajaGNC.PagaBien: boolean;
var
   Pagado, Total: double;
   aError: Integer;
   CadenaAux: string;
   APagar, ADar: string;

begin { de Verificar_CantidadEntregada }
    Pagado := 0;

    APagar := ConvierteComaEnPunto (lblCantidadAPagar.Caption);
    Val (APagar, Total, aError);
    if aError = 0
    then begin
        ADar := ConvierteComaEnPunto (EdtCantidadEntregada.Text);
        Val (aDar, Pagado, aError);
    end;

    if aError = 0
    then begin
        if (Total > Pagado)
        then begin
            { La cantidad entregada no es suficiente }
            MessageDlg (CABECERA_MENSAJES_CAJA, MSJ_CAJA_CANTIDADINS, mtInformation, [mbOk], mbOk,0);
            Result := False;
        end
        else begin
            Str((Pagado - Total):8:2, CadenaAux);
            lblCantidadADevolver.Caption := ConviertePuntoEnComa (CadenaAux);
            btnAceptar.Setfocus;
            Result := True;
        end
    end
    else begin
        EdtCantidadEntregada.Text := '';
        EdtCantidadEntregada.Setfocus;
        Result := False;
    end;
end; { de Verificar_CantidadEntregada }


procedure TFrmCajaGNC.btnCancelarClick(Sender: TObject);
{ Se desea cancelar la operación }
begin
    // La siguiente pregunta hay que hacerla por si el usuario pulsa sin querer el botón de Cancelar
    if (MessageDlg (CABECERA_MENSAJES_CAJA, MSJ_CAJA_CANCELACION, mtInformation, [mbYes, mbNo], mbNo, 0) = mrYes) then
    begin
        btnaceptar.Enabled:=false;
        btncancelar.Enabled:=false;
        l1extra:='cancelado';                    //
        precio:='1';
        tipostatus:='C';
        if strtofloat(Ffactura.valuebyname[FIELD_IMPONETO]) <> 0 then
        begin
           Impfis.SendInvoicePayment(l1extra,precio,tipostatus) ;
        end
        else
        begin
           Impfis.CloseNoFiscal;
        end;
        fFactura.ValueByName[FIELD_ERROR] := 'S';
        ModalResult := mrCancel;
    end
end;

procedure TFrmCajaGNC.edtNumeroFacturaRealKeyPress(Sender: TObject; var Key: Char);
begin
    if (Key = Chr(VK_RETURN))
    then begin
        //edtNumeroFacturaRealExit(Sender);
        Perform(WM_NEXTDLGCTL,0,0);
        Key := #0;
    end
    else if Key = Char(VK_SPACE)
    then Key := #0
end;


procedure TFrmCajaGNC.btnAceptarClick(Sender: TObject);
var
    aSize,cont: integer;
    cerrobien:boolean;
    tipofactu : string;
begin
  if fptoventa.GetTipo = TIPO_MANUAL THEN         //
    BEGIN
    if PagaBien Then
        If fFactura.ValidateNumeroFactura(edtNumeroFacturaReal.Text)
        then begin
            aSize := DialogsFont.Size;
            try
                DialogsFont.Size := 15;
                if MessageDlg(Caption,'Confirmar cobro de factura: '+ #13 +
                                Format('Factura nº: %s.',[edtNumeroFacturaReal.Text]) + #13 +
                                Format('Importe: %s',[lblCantidadAPagar.Caption]), mtConfirmation, [mbOk, mbNo], mbNo, 0) = mrOk
                 then
                 begin
                   fFactura.ValueByName[FIELD_ERROR]:='N';
                   if ffactura.valuebyname[FIELD_FORMPAGO] = FORMA_PAGO_CHEQUE then
                     fCheque.valueByName[FIELD_ERROR]:='N';
                   ModalResult := mrOk;
                 end;
            finally
                DialogsFont.Size := aSize
            end;

        end
        else begin
            Messagedlg(Application.Title,MSJ_WRONG_NUMFACTU,mtInformation,[mbyes],mbyes,0);
        end;
    end
  else                   //
    begin
     if PagaBien Then begin
       aSize := DialogsFont.Size;
         try
            btnaceptar.enabled:=false;
            btncancelar.enabled:=false;
            DialogsFont.Size := 15;
            if MessageDlg(Caption,'Confirmar cobro de factura: '+ #13 +
                          Format('Factura nº: %s.',[edtNumeroFacturaReal.Text]) + #13 +
                          Format('Importe: %s',[lblCantidadAPagar.Caption]), mtConfirmation, [mbOk, mbNo], mbOk, 0) = mrOk
            then
            begin
              finspeccion:=fFactura.GetInspeccionGNC; //agre vaz
              try
                fInspeccion.Open;
                if strtofloat(Ffactura.valuebyname[FIELD_IMPONETO]) <> 0 then
                begin
                  if imprimiolinea = false then
                  begin
                    cont:=0;
                    while (not ImprimirLineaComun(fInspeccion)) and (not cont > 10) do
                    begin
                        application.ProcessMessages;
                        inc(cont);
                    end;
{aca no entro}                    if strtofloat(ffactura.ValueByName[FIELD_IMPONETO])<>strtofloat(ffactura.ffactadicionales.ValueByName[FIELD_IMPSINDES]) then //MULTI
                    begin
                      cont:=0;
                      while (not ImprimirLineaDescuento(fInspeccion)) and (not cont > 10) do
                      begin
                        application.ProcessMessages;
                        inc(cont);
                      end;
                    end;
                    cerrobien:=cerrarticket;
                  end else
                  begin
                    application.messagebox('Ya esta impresa la la línea del item',pchar(caption),mb_ok+mb_applmodal+mb_iconerror);
                    cerrobien:=cerrarticket;
                  end;
                end
                else
                begin
                  ImprimirLineaDNF(fInspeccion);
                  cerrobien:=cerrardnf;
                  ffactura.valuebyname[FIELD_TIPFACTU]:=FACTURA_NO_FISCAL;
                  ffactura.post(TRUE);
                end;
                try
                  if cerrobien then
                  begin

                    tipofactu:=ffactura.valuebyname[FIELD_TIPFACTU];
                    tipostatus:=INF_NUMERADORES;
                    impfis.Status(tipostatus);
                    if tipofactu =  FACTURA_TIPO_A then
                    begin
                       fFactura.VAlueByName[FIELD_NUMFACTU] := impfis.AnswerField_7;
                    end
                    else
                    if tipofactu =  FACTURA_TIPO_B then
                    begin
                       fFactura.VAlueByName[FIELD_NUMFACTU] := impfis.AnswerField_5;
                    end
                    else
                    if tipofactu = FACTURA_NO_FISCAL  then
                    begin
                       fFactura.VAlueByName[FIELD_NUMFACTU] := impfis.AnswerField_10;
                    end;
                    ffactura.ValueByName[FIELD_IMPRESA] := FACTURA_IMPRESA;
                    fFactura.ValueByName[FIELD_ERROR]:='N';
                    if ffactura.valuebyname[FIELD_FORMPAGO] = FORMA_PAGO_CHEQUE then
                      fCheque.valueByName[FIELD_ERROR]:='N';
                    ModalResult := mrOk;
                  end
                  else
                  begin
                    raise Exception.Createfmt('Error en la registración de la Factura con Código ''%S''',[fFactura.ValuebyName[FIELD_CODFACTU]]);
                    fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL,'La factura ''%S'' no fue impresa Correctamente', [fFactura.Valuebyname[FIELD_CODFACTU]]);
                    ModalResult := mrCancel;
                  end;
                except
                  on E: Exception do
                  begin
                       application.messagebox('No se pudo finalizar correctamente la facturación.',pchar(caption),mb_ok+mb_applmodal+mb_iconerror);
                       fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'No se pudo finalizar correctamente la facturación. %s', [E.message]);
                       ModalResult := mrCancel;
                       raise
                  end;
                end;
              finally
                  finspeccion.free;
              end;
            end;
         finally
            DialogsFont.Size := aSize;
            btnaceptar.enabled:=true;
            btncancelar.enabled:=true;
         end;
     end;
    END;
end;

procedure TFrmCajaGNC.edtNumeroFacturaRealEnter(Sender: TObject);
begin
    DestacarControl (Sender, clGreen, clWhite, False);
end;

procedure TFrmCajaGNC.edtNumeroFacturaRealExit(Sender: TObject);
begin
    AtenuarControl(Sender, TRUE);
end;

procedure TFrmCajaGNC.edtCantidadEntregadaExit(Sender: TObject);
begin
    if PagaBien
    then AtenuarControl(Sender, TRUE);
end;

Function TFrmCajaGNC.IsPossibleZero: Boolean;
var
    fInspeccion: TInspGNC;
Begin
    //Determina si una factura puede tener importe CERO
    Result:=falsE;
    fInspeccion:=fFactura.GetInspeccionGNC;
    fInspeccion.Open;
    Try
        With fCliente.TipoCliente do
        Try
            Open;
            If ((((StrToInt(ValueByName[FIELD_PORREVERIFICACION])=100)) and (fInspeccion.ValueByName[FIELD_TIPO][1] in ([T_REVERIFICACION,T_VOLUNTARIAREVERIFICACION])))or
                (((StrToInt(ValueByName[FIELD_PORNORMAL])=100)) and (fInspeccion.ValueByName[FIELD_TIPO]=T_NORMAL)))
            then
                Result:=True;
        Finally
            Free;
        end;
    Finally
        fInspeccion.Free;
    end;
end;

function TFrmCajaGNC.AbrirTicket:boolean;
var i: integer;
    tipofactu:string;
begin
          tipostatus:=INF_NUMERADORES;
          if impfis.Status(tipostatus) then
          if statusok(hexabina(impfis.fiscalstatus),'F',FALSE)and statusok(hexabina(impfis.printerstatus),'I',FALSE) then
          begin
            tipodf:=TIQUEFACTURA;
            saliimp:=SLIP;
            letradoc:=ffactura.valuebyname[FIELD_TIPFACTU];
            cantcopi:=#127;
            tipoform:=#127;
            tipoletra:='17';         //Si lo dejo en blanco no anda
            ivaemisor:=IVA_INSCRIPTO;
            ivacompr:=tipoiva(fFactura.ValueByName[FIELD_TIPTRIBU]);
            l1nombre:=stringParaCF(fcliente.ValueByName[FIELD_NOMBRE]+' '+fcliente.ValueByName[FIELD_APELLID1]);
            l2nombre:=#127;
            if (ivacompr = 'I') or (ivacompr = 'R') or (ivacompr = 'M')or (ivacompr = 'N')or (ivacompr = 'E') then
            begin
                 tipodoc:=TIPO_DOC_CUIT;
                 if CuitCorrecto(fcliente.valuebyname[FIELD_CUIT_CLI]) then
                     nrodoc:=cuitsinguion(fcliente.valuebyname[FIELD_CUIT_CLI]);
                 if ivacompr = 'N' then nrodoc:='20240834783';
            end
            else
            begin
                 tipodoc:=Fcliente.valuebyname[FIELD_TIPODOCU];
                 nrodoc:=fcliente.valuebyname[FIELD_DOCUMENT];
                 if tipodoc=TIPO_DOC_CUIT then
                   if CuitCorrecto(fcliente.valuebyname[FIELD_CUIT_CLI]) then
                     nrodoc:=cuitsinguion(fcliente.valuebyname[FIELD_CUIT_CLI]);
            end;
            bienuso:=BIENUSO_NO;
            l1domic:=stringParaCF(fcliente.valuebyname[FIELD_DIRECCIO]+' '+fcliente.valuebyname[FIELD_NROCALLE]+' '+fcliente.valuebyname[FIELD_PISO]+' '+fcliente.valuebyname[FIELD_DEPTO]);
            if length(l1domic) > 40 then
            begin
                 i:= abs(40- length(l1domic));
                 delete(l1domic,40,i);
            end;
            l2domic:=stringParaCF(fcliente.valuebyname[FIELD_CODPOSTA]+' - '+fcliente.valuebyname[FIELD_LOCALIDA]);
            if length(l2domic) > 40 then
            begin
                 i:= abs(40- length(l2domic));
                 delete(l2domic,40,i);
            end;
            l3domic:=#127;
            l1remito:=#127;
            l2remito:=#127;
            tipotab:=FARMACIA_NO;
            datosencabezado;
            result:=impfis.OpenInvoice(tipodf,saliimp,letradoc,cantcopi,tipoform,tipoletra,ivaemisor,ivacompr,
                     l1nombre,l2nombre,tipodoc,nrodoc,bienuso,l1domic,l2domic,l3domic,l1remito,
                     l2remito,tipotab);
            tipostatus:=INF_ENCURSO;
            impfis.Status(tipostatus);
            tipofactu:=impfis.AnswerField_4;
            tipostatus:=INF_NUMERADORES;
            impfis.Status(tipostatus);
            if tipofactu =  FACTURA_TIPO_A then
            begin
                edtNumeroFacturaReal.Text := FormatoCeros(strtoint(ffactura.ffactadicionales.valuebyname[FIELD_PTOVENT]),4)+'-'+impfis.AnswerField_7
            end
            else
            begin
                edtNumeroFacturaReal.Text := FormatoCeros(strtoint(ffactura.ffactadicionales.valuebyname[FIELD_PTOVENT]),4)+'-'+impfis.AnswerField_5;
            end;
        end
        else
          raise exception.create('Ha ocurrido un error al tratar de imprimir en el Controlador Fiscal');


end;

function TFrmCajaGNC.ImprimirLineaComun(ainspeccion: TinspGNC):boolean;
var tipover: string;
begin
   descitem:='Verificacion';
   cant:='1000';
   precio:=floattostr(strtofloat(fFactura.ffactadicionales.ValueByName[FIELD_IMPSINDES])*100);//MULTI
   iva:=floattostr(strtofloat(fFactura.valuebyname[FIELD_IVAINSCR])*100);
   tipoitem:=SUMA_ITEM;
   cantbult:='1';
   impintporc:='0';
   l1extra:='RPA del vehiculo';
   l2extra:=fvehiculo.getpatente;
   if (ainspeccion.ValueByName[FIELD_TIPO]= T_REVERIFICACION) or (ainspeccion.ValueByName[FIELD_TIPO]=T_VOLUNTARIAREVERIFICACION)
      then
          tipover:= 'R'
      else
          tipover:='V';
   l3extra:='Nro: '+tipover+Trim(Copy(ainspeccion.ValueByName[FIELD_EJERCICI],3,2))+'000'+fvarios.ValueByName[FIELD_ZONA]+'000'+fvarios.ValueByName[FIELD_ESTACION]+formatoceros(strtoint(ainspeccion.ValueByName[FIELD_CODINSPGNC]),6); //AGRE VAZ
   tasa:=floattostr(strtofloat(fFactura.valuebyname[FIELD_IVANOINS])*100);
   impintfijo:='0';
   imprimiolinea:= impfis.SendInvoiceItem(descitem,cant,precio,iva,tipoitem,cantbult,impintporc,l1extra,l2extra,l3extra,
      tasa,impintfijo);
   result:=imprimiolinea;
end;

function TFrmCajaGNC.ImprimirLineaDescuento(ainspeccion: TinspGNC):boolean;
var QColetilla: TSQLQuery;
begin
    QColetilla := TSQLQuery.Create(self);
    try
       QColetilla.sqlconnection := MyBD;
       QColetilla.SQL.Add('SELECT C.COLETILLA FROM TFACTURAS F, TTIPOSCLIENTE C ');
       QColetilla.SQL.Add(Format('WHERE F.CODFACTU= ''%S'' AND C.TIPOCLIENTE_ID=F.TIPOCLIENTE_ID',[fFactura.ValueByName[FIELD_CODFACTU]]));
       QColetilla.Open;
       descitem := QColetilla.fields[0].asstring;
    finally
       QColetilla.Free;
    end;
    l1extra:=descitem;
    descitem:=#127;
    l2extra:=#127;
    l3extra:=#127;
    if (ffactura.ffactadicionales.valuebyname[FIELD_CODDESCU] <> '') then
    begin
      l2extra := copy(fDescuento.ValueByName[FIELD_CONCEPTO],1,25);
    end;
    cant:='1000';
    precio:=floattostr(strtofloat(fFactura.ffactadicionales.valuebyname[FIELD_DESCUENT])*100);   //MULTI
    iva:=floattostr(strtofloat(fFactura.valuebyname[FIELD_IVAINSCR])*100);
    tipoitem:=BONIFICACION;
    cantbult:='1';
    impintporc:='0';
    tasa:=floattostr(strtofloat(fFactura.valuebyname[FIELD_IVANOINS])*100);      
    impintfijo:='0';
    result:=impfis.SendInvoiceItem(descitem,cant,precio,iva,tipoitem,cantbult,impintporc,l1extra,l2extra,l3extra,
            tasa,impintfijo);
end;

function TFrmCajaGNC.CerrarTicket:boolean;
begin
    if decimalseparator = ',' then
    begin
       montopago:=floattostr(strtofloat(ConviertePuntoEnComa(edtCantidadEntregada.text))*100);
    end
    else
    begin
       montopago:=floattostr(strtofloat(ConvierteComaEnPunto(edtCantidadEntregada.text))*100);
    end;

    tasa := '0';

    if (fVarios.ValueByName[FIELD_ENA_PIB] = 'S') and (fFactura.ValueByName[FIELD_IIBB] <> '0') then
    begin
        descitem:=('IIBB BS.AS.');
        tipoitem:='O';
        tasa:=floattostrf(strtofloat(floattostrf(strtofloat(fFactura.ValueByName[FIELD_IIBB])/100*strtofloat(fFactura.ValueByName[FIELD_IMPONETO]),fffixed,15,2))*100,fffixed,3,2);
        impfis.SendInvoicePerception(descitem,tipoitem,tasa);
    end;
    

    tipopago:='T';
    descitem:='Monto';
    impfis.SendInvoicePayment(descitem,montopago,tipopago);  //************ aca va lo de la moneda y su cotizacion
    result:= impfis.CloseInvoice(tipodf,letradoc,l1extra);
end;

procedure TFrmCajaGNC.AbrirNoFiscal;
var  accion,texto,nroheader: widestring;
begin
   try
      fdatosestacion:=nil;
      fdatosestacion:= tdatos_estacion.create(MyBd);
      fdatosestacion.Open;
      accion:='S';

      nroheader:=ENCA_L5;
      texto:=stringparacf(fdatosestacion.valuebyname[FIELD_CALLECOM]);
      impfis.SetGetHeaderTrailer(accion,nroheader,texto);
   finally
      fdatosestacion.close;
      fdatosestacion.free;
   end;
   dfnumero:=COLA_FORPAGO_1;
   texto:=#127;
   impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
   dfnumero:=COLA_FORPAGO_2;
   impfis.SetGetHeaderTrailer(accion,dfnumero,texto);

   texto:=LINEA_DNF;
   dfnumero:=COLA_FORPAGO_3;
   impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
   dfnumero:=COLA_CAJERO_1;
   try
        usuario:=tusuarios.CreateFromDataBase(mybd,DATOS_USUARIO,FORMAT('WHERE IDUSUARIO = %D',[strtoint(ffactura.ffactadicionales.valuebyname[FIELD_IDUSUARI])]));
        usuario.open;
        texto:='CAJERO: '+usuario.ValueByName[FIELD_NOMBRE];
   finally
        usuario.close;
        usuario.free;
   end;
   impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
   impfis.OpenNoFiscal();
   tipostatus:=INF_NUMERADORES;
   impfis.Status(tipostatus);
   edtNumeroFacturaReal.Text := FormatoCeros(strtoint(ffactura.ffactadicionales.valuebyname[FIELD_PTOVENT]),4)+'-'+impfis.AnswerField_10;
end;

procedure TFrmCajaGNC.ImprimirLineaDNF(ainspeccion: TinspGNC);
var i:integer;
    tipover,descColet: string;
    qColetilla: TSQLQuery;
begin
      tipostatus:=INF_NUMERADORES;
      textonf:=LINEA_DNF;
      impfis.SendNoFiscalText(textonf);
      ivacompr:=tipoiva(fFactura.ValueByName[FIELD_TIPTRIBU]);
      textonf:=stringParaCF(fcliente.ValueByName[FIELD_NOMBRE]+' '+fcliente.ValueByName[FIELD_APELLID1]);
      impfis.SendNoFiscalText(textonf);
      if (ivacompr = 'I') or (ivacompr = 'N') or (ivacompr = 'M')or (ivacompr = 'N')or (ivacompr = 'E') then
      begin
         tipodoc:=TIPO_DOC_CUIT;
         if CuitCorrecto(fcliente.valuebyname[FIELD_CUIT_CLI]) then
                 nrodoc:=cuitsinguion(fcliente.valuebyname[FIELD_CUIT_CLI]);
      end
      else
      begin
         tipodoc:=Fcliente.valuebyname[FIELD_TIPODOCU];
         nrodoc:=fcliente.valuebyname[FIELD_DOCUMENT];
      end;
      tipodoc:=tipodoc+' '+nrodoc;
      impfis.SendNoFiscalText(tipodoc);
      l1domic:=stringParaCF(fcliente.valuebyname[FIELD_DIRECCIO]+' '+fcliente.valuebyname[FIELD_NROCALLE]+' '+fcliente.valuebyname[FIELD_PISO]+' '+fcliente.valuebyname[FIELD_DEPTO]);
      if length(l1domic) > 40 then
      begin
         i:= abs(40- length(l1domic));
         delete(l1domic,40,i);
      end;
      l2domic:=stringParaCF(fcliente.valuebyname[FIELD_CODPOSTA]+' - '+fcliente.valuebyname[FIELD_LOCALIDA]);
      impfis.SendNoFiscalText(l1domic);
      impfis.SendNoFiscalText(l2domic);
      textonf:=LINEA_DNF;
      impfis.SendNoFiscalText(textonf);
      l1extra:='VTV del vehiculo';
      l2extra:=fvehiculo.getpatente;

      if (ainspeccion.ValueByName[FIELD_TIPO]= T_REVERIFICACION) or (ainspeccion.ValueByName[FIELD_TIPO]=T_VOLUNTARIAREVERIFICACION)
      then
          tipover:= 'R'
      else
          tipover:='V';

      l3extra:='Nro: '+tipover+Trim(Copy(ainspeccion.ValueByName[FIELD_EJERCICI],3,2))+'000'+fvarios.ValueByName[FIELD_ZONA]+'000'+fvarios.ValueByName[FIELD_ESTACION]+formatoceros(strtoint(ainspeccion.ValueByName[FIELD_CODINSPGNC]),6); //AGRE VAZ
      impfis.SendNoFiscalText(l1extra);
      impfis.SendNoFiscalText(l2extra);
      impfis.SendNoFiscalText(l3extra);
      textonf:='IMPORTE:                           '+ffactura.ffactadicionales.valuebyname[FIELD_IMPSINDES];   //MULTI
      impfis.SendNoFiscalText(textonf);

      QColetilla := TSQLQuery.Create(self);
      try
         QColetilla.SQLConnection := MyBD;
         QColetilla.SQL.Add('SELECT C.COLETILLA FROM TFACTURAS F, TTIPOSCLIENTE C ');
         QColetilla.SQL.Add(Format('WHERE F.CODFACTU= ''%S'' AND C.TIPOCLIENTE_ID=F.TIPOCLIENTE_ID',[fFactura.ValueByName[FIELD_CODFACTU]]));
         QColetilla.Open;
         descColet := QColetilla.fields[0].asstring;
      finally
         QColetilla.Free;
      end;
      textonf:='BONIF. LEY 12152:                 -'+ffactura.ffactadicionales.valuebyname[FIELD_DESCUENT];
      impfis.SendNoFiscalText(textonf);
      textonf:=LINEA_DNF;
      impfis.SendNoFiscalText(textonf);
      textonf:='IMPORTE A ABONAR:                   '+floattostrf(strtofloat(fFactura.valuebyname[FIELD_IMPONETO])*100,ffNumber,10,2);
      impfis.SendNoFiscalText(textonf);
      textonf:=LINEA_DNF;
      impfis.SendNoFiscalText(textonf);

end;

function TFrmCajaGNC.CerrarDNF:boolean;
var accion,dfnumero,texto: widestring;
begin
  sleep(500);
  result:=impfis.CloseNoFiscal();
  dfnumero:=ENCA_L5;
  accion:='S';
  texto:=#127;
  impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
end;

procedure TFrmCajaGNC.DatosEncabezado;
begin
   try
      fdatosestacion:=nil;
      fdatosestacion:= tdatos_estacion.create(MyBd);
      fdatosestacion.Open;
      accion:='S';
      dfnumero:=COLA_FORPAGO_1;
      texto:=LINEA_DNF;
      impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
      dfnumero:=COLA_FORPAGO_3;
      impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
      dfnumero:=COLA_FORPAGO_2;
      texto:='FORMA DE PAGO: ';
      if ffactura.valuebyname[FIELD_FORMPAGO] = FORMA_PAGO_METALICO then
      begin
          texto:=texto+'CONTADO';
      end
      else
        if ffactura.valuebyname[FIELD_FORMPAGO] = FORMA_PAGO_CREDITO then
        begin
           texto:=texto+'CUENTA CORRIENTE';
        end
        else
        if ffactura.valuebyname[FIELD_FORMPAGO] = FORMA_PAGO_TARJETA then
        begin
           texto:=texto+' '+ffactura.ffactadicionales.GetNombreTarjeta(ffactura.ffactadicionales.ValueByName[FIELD_CODTARJET])+' .. '
                  +Trim(Copy(ffactura.ffactadicionales.valuebyname[FIELD_NUMTARJET],length(ffactura.ffactadicionales.valuebyname[FIELD_NUMTARJET])-7,8));
        end
        else
        begin
           texto:=texto+'CHEQUE '+ffactura.DevolverNroCheque;
        end;
      impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
      dfnumero:=COLA_CAJERO_1;
      try
        usuario:=tusuarios.CreateFromDataBase(mybd,DATOS_USUARIO,FORMAT('WHERE IDUSUARIO = %D',[strtoint(ffactura.ffactadicionales.valuebyname[FIELD_IDUSUARI])]));
        usuario.open;
        texto:='CAJERO: '+usuario.ValueByName[FIELD_NOMBRE];
      finally
        usuario.close;
        usuario.free;
      end;
        impfis.SetGetHeaderTrailer(accion,dfnumero,texto);

   finally
      fdatosestacion.close;
      fdatosestacion.free;
   end;
end;

procedure TFrmCajaGNC.FormCreate(Sender: TObject);
begin
  imprimiolinea:=false;
  impfis := CreateComObject(CLASS_PrinterFiscal) as _PrinterFiscalDisp;
  impfis.PortNumber := PortNumber;
  impfis.BaudRate := BaudRate;
end;

procedure TFrmCajaGNC.FormDestroy(Sender: TObject);
begin
   if assigned(fPtoVenta) then fPtoVenta.Free;
   if assigned(fFactDescuento) then
   begin
     fFactDescuento.Free;
   end;
   if assigned(fDescuento) then
      fdescuento.free;
   if assigned (fCheque) then
   begin
     if fcheque.DataSet.State in [dsEdit] then
       fcheque.post(TRUE);
     fcheque.Close;
     fcheque.Free;
   end;
end;

procedure TFrmCajaGNC.Timer1Timer(Sender: TObject);
begin
  case estadoticket of
    0:begin                 // el ticket no esta abierto
      if impfis.OpenInvoice(tipodf,saliimp,letradoc,cantcopi,tipoform,tipoletra,ivaemisor,ivacompr,
                  l1nombre,l2nombre,tipodoc,nrodoc,bienuso,l1domic,l2domic,l3domic,l1remito,
                  l2remito,tipotab)
      then
          estadoticket := 1;
    end;
    1:begin                 // ya se imprimio el encabezado del ticket
      impfis.SendInvoiceItem(descitem,cant,precio,iva,tipoitem,cantbult,impintporc,l1extra,l2extra,l3extra,
      tasa,impintfijo);
    end;
  end;
  timer1.enabled:=false;
end;

end.    //Final de la unidad

