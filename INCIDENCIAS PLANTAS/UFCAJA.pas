unit UFCaja;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, db,
  ULOGS, UCDIALGS, USAGCLASSES, Mask, globals, EPSON_impresora_Fiscal_TLB, ComObj,uconversiones, ucontstatus,
  uftmp, sqlExpr, DBXpress, dbclient,provider;

type
  TFrmCaja = class(TForm)
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
    fDescuento: TDescuento;
    fDatosEstacion: TDatos_estacion;
    fptoventa: tptoventa;   //
    impfis: _PrinterFiscalDisp;
    fInspeccion: TInspeccion;
    imprimiolinea: boolean;     //para que no imprima mas de una vez el item del ticket
    estadoticket:integer;    //Para saber en que etapa esta el ticket (en el encabezado, en el detalle, etc);
    usuario: Tusuarios;
    fFactDescuento: TFacturacion;
    fcheque: TCheque;
    //function CambiarNumeroFactura (iCodigoFac, iNumeroFac: integer): boolean;
    function PagaBien: boolean;
    Function IsPossibleZero: Boolean;
    function AbrirTicket:boolean;   //
    function ImprimirLineaComun(ainspeccion: Tinspeccion):boolean;   //
    function ImprimirLineaDescuento(ainspeccion: Tinspeccion):boolean;   //
    function CerrarTicket:boolean;
    procedure AbrirNoFiscal;
    procedure ImprimirLineaDNF(ainspeccion: Tinspeccion);
    function CerrarDNF:boolean;
    procedure datosencabezado;
    function devolver_imp_descuento:string;
    function GeneraNC_Descuento: boolean;
    function FacturaImpresa: boolean;
    procedure registradiscap;
  public
    constructor CreateFromBD (const aFactura: TFacturacion; const aCliente : Tclientes; const aVehiculo: TVehiculo; const adescuento: TDescuento);
    function Execute : boolean;
    function controla_que_no_se_facture_dos_vece:boolean;
  end;

var
  FrmCaja: TFrmCaja;
    tipodf,saliimp,letradoc,cantcopi,tipoform,tipoletra,ivaemisor,ivacompr,l1nombre,l2nombre,
    tipodoc,nrodoc,bienuso,l1domic,l2domic,l3domic,l1remito,l2remito,tipotab,tipostatus,tipopago,
    descitem,cant,precio,iva,tipoitem,cantbult,impintporc,l1extra,l2extra,l3extra,tasa,impintfijo,
    montopago,textonf,accion,dfnumero,texto:widestring;
    imp : double;
  bConsumidorFinal: boolean = false;

implementation

uses
   UINTERFAZUSUARIO,
   USAGESTACION,
   UUtils,
   UCTIMPRESION, //
   UCLIENTE, UFRecepcion;


{$R *.DFM}

resourcestring
      FICHERO_ACTUAL = 'UFCaja';
      // Captionde los mensajes que se van a dar al usuario del form
      CABECERA_MENSAJES_CAJA = 'Caja';

      MSJ_CAJA_CANTIDADINS = 'La cantidad entregada es insuficiente';
      MSJ_CAJA_CANCELACION = 'La factura ya est� emitida. �Desea cancelarla?';
      MSJ_CAJA_CAMBIARFACT = '�Realmente desea cambiar el n�mero de factura?';
      MSJ_CAJA_CANTIDADERR = 'La cantidad entregada es incorrecta';
      MSJ_CAJA_NUMFACTEXIST = 'Si desea cambiar el n�mero de factura deber� poner ' +
                             'un n�mero cuya factura no se haya emitido anteriormente. ' +
                             'Adem�s deber�a cambiar el pr�ximo n�mero de factura en la ' +
                             'pantalla de DATOS VARIABLES.';
      MSJ_CAJA_NUMFACERR = 'No se ha introducido un nuevo n�mero de factura o �ste es incorrecto. Introd�zcalo de nuevo por favor.';
      MSJ_WRONG_NUMFACTU = '� N�mero de Facturas Erroneo o Duplicado !';

      CADENA_FACTURA_A = 'A';
      CADENA_FACTURA_B = 'B';



constructor TFrmCaja.CreateFromBD (const aFactura: TFacturacion; const aCliente : TClientes; const aVehiculo: TVehiculo; const adescuento: TDescuento);
begin
    inherited Create(nil);
    fFactura := aFactura;
    if assigned (fFactura.ffactadicionales) then
      fFactura.ffactadicionales.close;   //MULTI
    fFactura.ffactadicionales:=tFact_adicionales.CreateFromFactura(MyBD,Ffactura.valuebyname[FIELD_CODFACTU],TIPO_FACTURA, TIPO_FACTURAGNC);   //MULTI
    fFactura.ffactadicionales.Open;  //MULTI
    fCliente := aCliente;
    fVehiculo := aVehiculo;
    fDescuento := aDescuento;
end;

 function TFrmCaja.controla_que_no_se_facture_dos_vece:boolean;
 var
  //martin 12/01/2012
      QryConsultas: TClientDataSet;
      sdsQryConsultas : TSQLDataSet;
      dspQryConsultas : tdatasetprovider;
 begin
          controla_que_no_se_facture_dos_vece:=false;
            sdsQryConsultas := TSQLDataSet.Create(Application);
            sdsQryConsultas.SQLConnection := mybd;
            sdsQryConsultas.CommandType := ctQuery;
            sdsQryConsultas.GetMetadata := false;
            sdsQryConsultas.NoMetadata := true;
            sdsQryConsultas.ParamCheck := false;
            dspQryConsultas := TDataSetProvider.Create(application);
            dspQryConsultas.DataSet := sdsQryConsultas;
            dspQryConsultas.Options := [poIncFieldProps,poAllowCommandText];
            QryConsultas:=TClientDataSet.create(application);

                              with QryConsultas do
                               Try
                                Close;
                                SetProvider(dspQryConsultas);
                                commandtext := Format('SELECT * FROM TESTADOINSP WHERE ESTADO <>''%S''  and MATRICUL = ''%S''  ',[E_PENDIENTE_FACTURAR,fVehiculo.GetPatente]);
                                 Open;
                                  If RecordCount > 0 then
                                     begin
                                         application.messagebox('ESTA PATENTE YA SE ENCUENTRA EN PROCESO DE FACTURACION.',pchar(caption),mb_ok+mb_applmodal+mb_iconerror);



                                          // La siguiente pregunta hay que hacerla por si el usuario pulsa sin querer el bot�n de Cancelar

      
                                            fFactura.ValueByName[FIELD_IDCANCELACION]:='6';


                                             fFactura.ValueByName[FIELD_ERROR] := 'S';
                                              ModalResult := mrCancel;


                                                   ffactura.Post(true);

                                          controla_que_no_se_facture_dos_vece:=true;



                                     end;


                               Except

                                end;

                                QryConsultas.Close;
                                QryConsultas.Free;
                                dspQryConsultas.Free;
                                sdsQryConsultas.Free;




 end;

procedure TFrmCaja.FormShow(Sender: TObject);
var
      FBusqueda: TFTmp;
      i:integer;

      //martin 12/01/2012
      QryConsultas: TClientDataSet;
      sdsQryConsultas : TSQLDataSet;
      dspQryConsultas : tdatasetprovider;
begin
    estadoticket:=0;                //Ticket no esta abierto todavia
    fbusqueda:= TFTmp.create(nil);
    with fbusqueda do
    try
      muestraclock('Facturaci�n','Imprimiendo el encabezado de la Factura');
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
        //imp:=0;
        lblCantidadAPagar.Caption := Format ('%1.2f',[imp]);
        edtCantidadEntregada.Text := lblCantidadAPagar.Caption;
        lblCantidadADevolver.Caption := '0,00';

        if (ffactura.ffactadicionales.valuebyName[FIELD_CODDESCU] <> '') and (fdescuento.valuebyname[FIELD_EMITENC] = 'S') then   //
        begin
          for i := 0 to Self.ComponentCount-1 do
            begin
              if (Self.Components[i].Tag = 1) then
              begin
                if (Self.Components[i] is Tlabel) then
                   Tlabel(Self.Components[i]).top := 187
                else if (Self.Components[i] is TEdit) then
                   TEdit(Self.Components[i]).top := 187
              end
              else if (Self.Components[i].Tag = 2) then
              begin
                if (Self.Components[i] is Tlabel) then
                   Tlabel(Self.Components[i]).top := 217
              end
              else if (Self.Components[i].Tag = 3) then
              begin
                if (Self.Components[i] is Tlabel) then
                   Tlabel(Self.Components[i]).visible := true
                else if (Self.Components[i] is TBevel) then
                   TBevel(Self.Components[i]).visible := true

              end;
          end;
          lblCantDescu.caption := format('%1.2f',[imp*(100-strtofloat(fdescuento.valuebyname[FIELD_PORCENTA]))/100])
        end;

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
            if (ffactura.ffactadicionales.valuebyName[FIELD_CODDESCU] <> '') and (fdescuento.valuebyname[FIELD_EMITENC] = 'S') then
                fcheque.ValueByName[FIELD_IMPORTE]:= format('%1.2f',[imp*(100-strtofloat(fdescuento.valuebyname[FIELD_PORCENTA]))/100])
            else
                fcheque.valuebyName[FIELD_IMPORTE]:=format('%1.2f',[imp]);
          end;
//        if ((imp = 0)  and (Not(IsPossibleZero)))
//        then btnAceptar.Enabled := False;
//        btnAceptar.ModalResult := mrNone;
//        btnCancelar.ModalResult := mrNone;
        if fptoventa.GetTipo = TIPO_MANUAL THEN
        begin
          edtNumeroFacturaReal.Text := fFactura.DevolverNumeroFactura(TIPO_FACTURA);
          if ((imp = 0)  and (Not(IsPossibleZero)))
            then btnAceptar.Enabled := False;
          btnAceptar.ModalResult := mrNone;
          btnCancelar.ModalResult := mrNone;
        end
        else
        begin
        //*****************************************************************************

      {

            sdsQryConsultas := TSQLDataSet.Create(Application);
            sdsQryConsultas.SQLConnection := mybd;
            sdsQryConsultas.CommandType := ctQuery;
            sdsQryConsultas.GetMetadata := false;
            sdsQryConsultas.NoMetadata := true;
            sdsQryConsultas.ParamCheck := false;
            dspQryConsultas := TDataSetProvider.Create(application);
            dspQryConsultas.DataSet := sdsQryConsultas;
            dspQryConsultas.Options := [poIncFieldProps,poAllowCommandText];
            QryConsultas:=TClientDataSet.create(application);

                              with QryConsultas do
                               Try
                                Close;
                                SetProvider(dspQryConsultas);
                                commandtext := Format('SELECT * FROM TESTADOINSP WHERE MATRICUL = ''%S''  ',[fVehiculo.GetPatente]);
                                 Open;
                                  If RecordCount = 0 then
                                     begin
                                         application.messagebox('HUEVOOOOOOOOOOONNNNNNNN!!! ESTAS FACTURANDO LA PATENTE AL MISMO TIEMPO.',pchar(caption),mb_ok+mb_applmodal+mb_iconerror);



                                          // La siguiente pregunta hay que hacerla por si el usuario pulsa sin querer el bot�n de Cancelar

      
                                            fFactura.ValueByName[FIELD_IDCANCELACION]:='6';


                                             fFactura.ValueByName[FIELD_ERROR] := 'S';
                                              ModalResult := mrCancel;


                                                   ffactura.Post(true);


                                     //  FrmCaja.FormDestroy(Sender);

                                         exit;
                                     end;


                               Except

                                end;

                                QryConsultas.Close;
                                QryConsultas.Free;
                                dspQryConsultas.Free;
                                sdsQryConsultas.Free;



                          }










      //*******************************************************************************

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
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'Error extra�o en la inicializaci�n de la ficha: %s', [E.message]);
            raise
        end;
      end;
    finally
        fbusqueda.close;
        fbusqueda.free;
    end;
end;

function TFrmCaja.Execute: boolean;
begin
if not controla_que_no_se_facture_dos_vece then
begin
    try
        result := FALSE;

        if ShowModal = mrOk
        then begin
//            fFactura.VAlueByName[FIELD_NUMFACTU] := Trim(Copy(edtNumeroFacturaReal.Text,6,Length(edtNumeroFacturaReal.Text)));  
//            fFactura.ValueByName[FIELD_ERROR]:='N';
            result := TRUE;
        end;
        fFactura.ffactadicionales.Post(True);
        fFactura.Post(True);
    except
        result := FALSE;
    end;

end else
begin
result := FALSE;
end;

end;

procedure TFrmCaja.EdtCantidadEntregadaKeyPress(Sender: TObject; var Key: Char);
begin
    if (Key = Chr(VK_RETURN)) then
    begin
        PagaBien;
        Key := #0;
    end;
end;

// Comprueba si la cantidad entregada por el cliente es correcta, devolviendo en este caso True
function TFrmCaja.PagaBien: boolean;
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


procedure TFrmCaja.btnCancelarClick(Sender: TObject);
{ Se desea cancelar la operaci�n }
begin

    fFactura.ValueByName[FIELD_IDCANCELACION]:='2';
    ffactura.Post(true);
    // La siguiente pregunta hay que hacerla por si el usuario pulsa sin querer el bot�n de Cancelar
    if (MessageDlg (CABECERA_MENSAJES_CAJA, MSJ_CAJA_CANCELACION, mtInformation, [mbYes, mbNo], mbNo, 0) = mrYes) then
    begin
      
        fFactura.ValueByName[FIELD_IDCANCELACION]:='6';
        ffactura.Post(true);
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
    end ;
   fFactura.ValueByName[FIELD_IDCANCELACION]:='7';
     ffactura.Post(true);
end;

procedure TFrmCaja.edtNumeroFacturaRealKeyPress(Sender: TObject; var Key: Char);
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


procedure TFrmCaja.btnAceptarClick(Sender: TObject);
var
    aSize,cont: integer;
    cerrobien:boolean;
    tipofactu : string;
begin



  fFactura.ValueByName[FIELD_IDCANCELACION]:='3';
  ffactura.Post(true);
  if fptoventa.GetTipo = TIPO_MANUAL THEN         //
    BEGIN
    if PagaBien Then
        If fFactura.ValidateNumeroFactura(edtNumeroFacturaReal.Text) then
          begin
            aSize := DialogsFont.Size;
            try
              DialogsFont.Size := 15;
              if MessageDlg(Caption,'Confirmar cobro de factura: '+ #13 + Format('Factura n�: %s.',[edtNumeroFacturaReal.Text]) + #13 +
                            Format('Importe: %s',[lblCantidadAPagar.Caption]), mtConfirmation, [mbOk, mbNo], mbNo, 0) = mrOk then
                begin
                  //MLA
                  fFactura.ValueByName[FIELD_IDCANCELACION]:='5';
                  ffactura.Post(true);
                  finspeccion:=fFactura.GetInspeccion; //agre vaz
                    try
                      finspeccion.open;
                        registradiscap;
                        if (ffactura.ffactadicionales.valuebyName[FIELD_CODDESCU] <> '') and (fdescuento.valuebyname[FIELD_EMITENC] = 'S') then   //
                          try
                            if generaNC_Descuento then
                              if fFactDescuento.VerImprimirNCDescuento(True, NIL) then
                                begin
                                  DialogsFont.Size := aSize;
                                    if FacturaImpresa then
                                      begin
                                        fFactDescuento.Edit;
                                        fFactDescuento.ValueByName[FIELD_ERROR]:='N';
                                        fFactDescuento.Post(true);
                                      end
                                    else
                                      begin
                                        raise Exception.Create('No se ha podido Imprimir la Nota de Cr�dito');
                                        fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'No se ha podido mostrar la Nota de Cr�dito');
                                      end;
                                end
                              else
                                begin
                                  raise Exception.Create('No se ha podido mostrar la Nota de Cr�dito');
                                  fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'No se ha podido mostrar la Nota de Cr�dito');
                                end
                            else
                              begin
                                raise Exception.Create('No se ha podido generar la Nota de Cr�dito');
                                fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'No se ha podido generar la Nota de Cr�dito');
                              end;
                          except
                            on E: Exception do
                              begin
                                application.messagebox('No se pudo generar correctamente la Nota de Cr�dito.',pchar(caption),mb_ok+mb_applmodal+mb_iconerror);
                                fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'No se pudo generar correctamente la Nota de Cr�dito. %s', [E.message]);
                              end;
                          end;
                    finally
                      finspeccion.free;
                    end;
                   fFactura.ValueByName[FIELD_ERROR]:='N';
                   if ffactura.valuebyname[FIELD_FORMPAGO] = FORMA_PAGO_CHEQUE then
                     fCheque.valueByName[FIELD_ERROR]:='N';
                   ModalResult := mrOk;
                 end;
            finally
                DialogsFont.Size := aSize
            end;

        end
        else
        begin
            Messagedlg(Application.Title,MSJ_WRONG_NUMFACTU,mtInformation,[mbyes],mbyes,0);
        end;
    end
  else                   //Si no es MANUAL
    begin
     if PagaBien Then begin
       aSize := DialogsFont.Size;
         try
            btnaceptar.enabled:=false;
            btncancelar.enabled:=false;
            edtCantidadEntregada.ReadOnly:=True;
            DialogsFont.Size := 15;
            if MessageDlg(Caption,'Confirmar cobro de factura: '+ #13 +
                          Format('Factura n�: %s.',[edtNumeroFacturaReal.Text]) + #13 +
                          Format('Importe: %s',[lblCantidadAPagar.Caption]), mtConfirmation, [mbOk, mbNo], mbOk, 0) = mrOk
            then
            begin
              fFactura.ValueByName[FIELD_IDCANCELACION]:='5';
              ffactura.Post(true);
              finspeccion:=fFactura.GetInspeccion; //agre vaz
              try
                fInspeccion.Open;
                 registradiscap;
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
{aca no entro}      if strtofloat(ffactura.ValueByName[FIELD_IMPONETO])<>strtofloat(ffactura.ffactadicionales.ValueByName[FIELD_IMPSINDES]) then //MULTI
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
                    application.messagebox('Ya esta impresa la la l�nea del item',pchar(caption),mb_ok+mb_applmodal+mb_iconerror);
                    cerrobien:=cerrarticket;
                  end;
                end
                else
                begin
                  ImprimirLineaDNF(fInspeccion);
                  cerrobien:=cerrardnf;
                  ffactura.valuebyname[FIELD_TIPFACTU]:=FACTURA_NO_FISCAL;
                  ffactura.post(true);
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
                    if (ffactura.ffactadicionales.valuebyName[FIELD_CODDESCU] <> '') and (fdescuento.valuebyname[FIELD_EMITENC] = 'S') then   //
                        try
                          if generaNC_Descuento then
                            if fFactDescuento.VerImprimirNCDescuento(True, NIL) then
                            begin
                                     DialogsFont.Size := aSize;
                                     if FacturaImpresa then
                                     begin
                                       fFactDescuento.Edit;
                                       fFactDescuento.ValueByName[FIELD_ERROR]:='N';
                                       fFactDescuento.Post(true);
                                     end
                                     else
                                     begin
                                          raise Exception.Create('No se ha podido Imprimir la Nota de Cr�dito');
                                          fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'No se ha podido mostrar la Nota de Cr�dito');
                                     end;
                            end
                            else
                            begin
                                 raise Exception.Create('No se ha podido mostrar la Nota de Cr�dito');
                                 fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'No se ha podido mostrar la Nota de Cr�dito');
                            end
                          else
                          begin
                            raise Exception.Create('No se ha podido generar la Nota de Cr�dito');
                            fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'No se ha podido generar la Nota de Cr�dito');
                          end;
                        except
                           on E: Exception do
                           begin
                               application.messagebox('No se pudo generar correctamente la Nota de Cr�dito.',pchar(caption),mb_ok+mb_applmodal+mb_iconerror);
                               fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'No se pudo generar correctamente la Nota de Cr�dito. %s', [E.message]);
                           end;
                        end;


                    ffactura.ValueByName[FIELD_IMPRESA] := FACTURA_IMPRESA;
                    fFactura.ValueByName[FIELD_ERROR]:='N';
                    if ffactura.valuebyname[FIELD_FORMPAGO] = FORMA_PAGO_CHEQUE then
                      fCheque.valueByName[FIELD_ERROR]:='N';
                    ModalResult := mrOk;
                  end
                  else
                  begin
                    raise Exception.Createfmt('Error en la registraci�n de la Factura con C�digo ''%S''',[fFactura.ValuebyName[FIELD_CODFACTU]]);
                    fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL,'La factura ''%S'' no fue impresa Correctamente', [fFactura.Valuebyname[FIELD_CODFACTU]]);
                    ModalResult := mrCancel;
                  end;
                except
                  on E: Exception do
                  begin
                       application.messagebox('No se pudo finalizar correctamente la facturaci�n.',pchar(caption),mb_ok+mb_applmodal+mb_iconerror);
                       fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'No se pudo finalizar correctamente la facturaci�n. %s', [E.message]);
                        if fFactura.ValueByName[FIELD_IDCANCELACION]='5' then
                           begin
                           fFactura.ValueByName[FIELD_IDCANCELACION]:='8' ;
                           ffactura.Post(true);
                           end;


                       ModalResult := mrCancel;
                       raise
                  end;
                end;
              finally
                  finspeccion.free;
              end;
            end;
         finally
            fFactura.ValueByName[FIELD_IDCANCELACION]:='4';
            ffactura.Post(true);
            DialogsFont.Size := aSize;
            btnaceptar.enabled:=true;
            btncancelar.enabled:=true;
            edtCantidadEntregada.ReadOnly:=false;
         end;
     end;
    END;
end;

procedure TFrmCaja.edtNumeroFacturaRealEnter(Sender: TObject);
begin
    DestacarControl (Sender, clGreen, clWhite, False);
end;

procedure TFrmCaja.edtNumeroFacturaRealExit(Sender: TObject);
begin
    AtenuarControl(Sender, TRUE);
end;

procedure TFrmCaja.edtCantidadEntregadaExit(Sender: TObject);
begin
    if PagaBien
    then AtenuarControl(Sender, TRUE);
end;

Function TFrmCaja.IsPossibleZero: Boolean;
var
    fInspeccion: TInspeccion;
Begin
    //Determina si una factura puede tener importe CERO
    Result:=falsE;
    fInspeccion:=fFactura.GetInspeccion;
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

function TFrmCaja.AbrirTicket:boolean;
var i: integer;
    tipofactu:string;
    var  accion,texto,nroheader: widestring;
begin
          tipostatus:=INF_NUMERADORES;
          if impfis.Status(tipostatus) then
          if statusok(hexabina(impfis.fiscalstatus),'F',FALSE)and statusok(hexabina(impfis.printerstatus),'I',FALSE) then
          begin
            tipodf:=TIQUEFACTURA;
            saliimp:=SLIP;
            letradoc:=ffactura.valuebyname[FIELD_TIPFACTU];
            cantcopi:='1';
            tipoform:='P';
            tipoletra:='12';         //Si lo dejo en blanco no anda
            ivaemisor:=IVA_INSCRIPTO;
            ivacompr:=tipoiva(fFactura.ValueByName[FIELD_TIPTRIBU]);

            If ivacompr = 'F' then
              bConsumidorFinal:=true
            else
              bConsumidorFinal:=false;

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
            l1remito:='(NO INFORMADO)';
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

function TFrmCaja.ImprimirLineaComun(ainspeccion: Tinspeccion):boolean;
var tipover: string;
begin
   descitem:='Verificacion';
   cant:='1000';
   precio:=floattostr(strtofloat(fFactura.ffactadicionales.ValueByName[FIELD_IMPSINDES])*100);//MULTI
   iva:=floattostr(strtofloat(fFactura.valuebyname[FIELD_IVAINSCR])*100);
   tipoitem:=SUMA_ITEM;
   cantbult:='1';
   impintporc:='0';
   l1extra:='VTV del vehiculo';
   l2extra:=fvehiculo.getpatente;
   if (ainspeccion.ValueByName[FIELD_TIPO]= T_REVERIFICACION) or (ainspeccion.ValueByName[FIELD_TIPO]=T_VOLUNTARIAREVERIFICACION)
      then
          tipover:= 'R'
      else
          tipover:='V';
   l3extra:='Nro: '+tipover+Trim(Copy(ainspeccion.ValueByName[FIELD_EJERCICI],3,2))+'000'+fvarios.ValueByName[FIELD_ZONA]+'000'+fvarios.ValueByName[FIELD_ESTACION]+formatoceros(strtoint(ainspeccion.ValueByName[FIELD_CODINSPE]),6); //AGRE VAZ
   tasa:=floattostr(strtofloat(fFactura.valuebyname[FIELD_IVANOINS])*100);
   impintfijo:='0';
   imprimiolinea:= impfis.SendInvoiceItem(descitem,cant,precio,iva,tipoitem,cantbult,impintporc,l1extra,l2extra,l3extra,
      tasa,impintfijo);
   result:=imprimiolinea;
end;

function TFrmCaja.ImprimirLineaDescuento(ainspeccion: Tinspeccion):boolean;
var QColetilla: TSQLQuery;
begin
    QColetilla := TSQLQuery.Create(self);
    try
       QColetilla.SQLConnection := MyBD;
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
    if (ffactura.ffactadicionales.valuebyname[FIELD_CODDESCU] <> '') and (fdescuento.valuebyname[FIELD_EMITENC] = 'N')then
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

function TFrmCaja.CerrarTicket:boolean;
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
        //MLA 14-07-2009   cambio en la cantidad de digitos de salida de la tasa de  3 paso a  4.
        tasa:=floattostrf(strtofloat(floattostrf(strtofloat(fFactura.ValueByName[FIELD_IIBB])/100*strtofloat(fFactura.ValueByName[FIELD_IMPONETO]),fffixed,15,2))*100,fffixed,4,0);
        impfis.SendInvoicePerception(descitem,tipoitem,tasa);
    end;

    tipopago:='T';
    descitem:='Monto';
    impfis.SendInvoicePayment(descitem,montopago,tipopago);
    result:= impfis.CloseInvoice(tipodf,letradoc,l1extra);

end;

procedure TFrmCaja.AbrirNoFiscal;
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

procedure TFrmCaja.ImprimirLineaDNF(ainspeccion: Tinspeccion);
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

      l3extra:='Nro: '+tipover+Trim(Copy(ainspeccion.ValueByName[FIELD_EJERCICI],3,2))+'000'+fvarios.ValueByName[FIELD_ZONA]+'000'+fvarios.ValueByName[FIELD_ESTACION]+formatoceros(strtoint(ainspeccion.ValueByName[FIELD_CODINSPE]),6); //AGRE VAZ
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

function TFrmCaja.CerrarDNF:boolean;
var accion,dfnumero,texto: widestring;
begin
  sleep(500);
  result:=impfis.CloseNoFiscal();
  dfnumero:=ENCA_L5;
  accion:='S';
  texto:=#127;
  impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
end;

procedure TFrmCaja.DatosEncabezado;
begin
   try
      fdatosestacion:=nil;
      fdatosestacion:= tdatos_estacion.create(MyBd);
      fdatosestacion.Open;
      accion:='S';
      dfnumero:=COLA_FORPAGO_1;
      texto:=LINEA_DNF;
      impfis.SetGetHeaderTrailer(accion,dfnumero,texto);

      dfnumero:=CABECERA_63;
      texto:= cVacio;
      Impfis.SetGetHeaderTrailer(accion,dfnumero,texto);

      if bConsumidorFinal then
        begin
          dfnumero:=CABECERA_64;
          texto:= cLEY_13987_1;
          Impfis.SetGetHeaderTrailer(accion,dfnumero,texto);

          dfnumero:=CABECERA_65;
          texto:= cLEY_13987_2;
          Impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
        end
      else
        Begin
          dfnumero:=CABECERA_64;
          texto:= cVacio;
          Impfis.SetGetHeaderTrailer(accion,dfnumero,texto);

          dfnumero:=CABECERA_65;
          texto:= cVacio;
          Impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
        end;

      texto:=LINEA_DNF;
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


procedure TFrmCaja.FormCreate(Sender: TObject);
begin
  imprimiolinea:=false;
  impfis := CreateComObject(CLASS_PrinterFiscal) as _PrinterFiscalDisp;
  impfis.PortNumber := PortNumber;
  impfis.BaudRate := BaudRate;
end;


procedure TFrmCaja.FormDestroy(Sender: TObject);
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
//     if fcheque.DataSet.UpdateStatus in [usModified] then    { TODO -oran -cIMPORTANTES : ver bien si anda }
     if fcheque.DataSet.State in [dsedit] then    { TODO -oran -cIMPORTANTES : ver bien si anda }
       fcheque.post(true);
     fcheque.Close;
     fcheque.Free;
   end;
end;

procedure TFrmCaja.Timer1Timer(Sender: TObject);
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

function TFrmCaja.devolver_imp_descuento:string;
begin
  result := format('%1.2f',[strtofloat(ffactura.valuebyname[FIELD_IMPONETO])-(strtofloat(ffactura.valuebyname[FIELD_IMPONETO])*(100-strtofloat(fdescuento.valuebyname[FIELD_PORCENTA]))/100)]);
end;

function TFrmCaja.GeneraNC_Descuento: boolean;
var ffactadicion_auxi: tFact_Adicionales;
begin
  result:=false;
  try
     fFactDescuento:=TFacturacion.CreateByRowid (MyBD,'');

     with fFactDescuento do
     begin
         open;
         valuebyname[FIELD_TIPFACTU] := fFactura.valuebyname[FIELD_TIPFACTU];
         valuebyname[FIELD_IMPRESA] := 'N';
         valuebyname[FIELD_TIPTRIBU] := fFactura.valuebyname[FIELD_TIPTRIBU];
         valuebyname[FIELD_FORMPAGO] := fFactura.valuebyname[FIELD_FORMPAGO];
         valuebyname[FIELD_IVAINSCR] := fFactura.valuebyname[FIELD_IVAINSCR];
         valuebyname[FIELD_CODCLIEN] := fFactura.valuebyname[FIELD_CODCLIEN];
         valuebyname[FIELD_IVANOINS] := fFactura.valuebyname[FIELD_IVANOINS];
         valuebyname[FIELD_ERROR] := 'S';
         ValueByName[FIELD_IIBB] := '0';
         valuebyname[FIELD_TIPOCLIENTE_ID] := fFactura.valuebyname[FIELD_TIPOCLIENTE_ID];
         ffactadicionales.open;
         ffactadicionales.valuebyname[FIELD_TIPOFAC] := 'D';
         ffactadicionales.valuebyname[FIELD_PTOVENT] := inttostr(fptoventa.GetPtoVentaManual);
         ffactadicionales.valuebyname[FIELD_CODTARJET] := fFactura.ffactadicionales.valuebyname[FIELD_CODTARJET];
         ffactadicionales.valuebyname[FIELD_NUMTARJET] := fFactura.ffactadicionales.valuebyname[FIELD_NUMTARJET];
         ffactadicionales.valuebyname[FIELD_FECHAVEN] := fFactura.ffactadicionales.valuebyname[FIELD_FECHAVEN];
         ffactadicionales.valuebyname[FIELD_CANTCUOT] := fFactura.ffactadicionales.valuebyname[FIELD_CANTCUOT];
         ffactadicionales.valuebyname[FIELD_IDUSUARI] := fFactura.ffactadicionales.valuebyname[FIELD_IDUSUARI];
         ffactadicionales.valuebyname[FIELD_CODAUTO] := fFactura.ffactadicionales.valuebyname[FIELD_CODAUTO];
         ffactadicionales.valuebyname[FIELD_CODDESCU] := fFactura.ffactadicionales.valuebyname[FIELD_CODDESCU];
         ffactadicionales.valuebyname[FIELD_RELCODFAC] := fFactura.ffactadicionales.valuebyname[FIELD_CODFACT];
     end;
     fFactDescuento.open;
     fFactDescuento.ffactadicionales.Open;
     fFactDescuento.ValueByName[FIELD_IMPONETO]:=devolver_imp_descuento;
     fFactDescuento.ffactadicionales.valuebyname[FIELD_IMPSINDES]:=devolver_imp_descuento;
     fFactDescuento.ffactadicionales.valuebyname[FIELD_DESCUENT]:='0';
     fFactdescuento.post(true);
     fFactDescuento.ffactadicionales.valuebyname[FIELD_CODFACT] := fFactDescuento.valuebyname[FIELD_CODFACTU];
     fFactdescuento.ffactadicionales.Post(true);
     try
       ffactadicion_auxi:=tFact_adicionales.createbyrowid(MYBD,ffactura.ffactadicionales.valuebyname[FIELD_ROWID]);
       ffactadicion_auxi.open;
       ffactadicion_auxi.Edit;
       ffactadicion_auxi.valueByName[FIELD_RELCODFAC]:=fFactDescuento.ValueByName[FIELD_CODFACTU];
       ffactadicion_auxi.post(true);
     finally
       ffactadicion_auxi.free;
     end;
     ffactdescuento.ffactadicionales.close;
     result:=true;
  except
  end;
end;

function TFrmCaja.FacturaImpresa: boolean;
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

      if (fFactDescuento.ValueByName[FIELD_TIPFACTU] = CADENA_FACTURA_A) then
        iServicio := NCDescuento_A
      else
        iServicio := NCDescuento_B;

      bTodoOk := TrabajoEnviadoOk (dCabecera, iServicio);
      if bTodoOk then
        begin
          fFactDescuento.Refresh;
          fFactDescuento.DevolverNumeroFactura(TIPO_NCD);
          result := TRUE;
        end;
    end
 except
  result := FALSE;
 end;
end;


procedure TFrmCaja.registradiscap;
var
QryConsultas: TClientDataSet;
sdsQryConsultas : TSQLDataSet;
dspQryConsultas : tdatasetprovider;
begin
sdsQryConsultas := TSQLDataSet.Create(Application);
sdsQryConsultas.SQLConnection := mybd;
sdsQryConsultas.CommandType := ctQuery;
sdsQryConsultas.GetMetadata := false;
sdsQryConsultas.NoMetadata := true;
sdsQryConsultas.ParamCheck := false;
dspQryConsultas := TDataSetProvider.Create(application);
dspQryConsultas.DataSet := sdsQryConsultas;
dspQryConsultas.Options := [poIncFieldProps,poAllowCommandText];
QryConsultas:=TClientDataSet.create(application);
//MLA   solo inserta para los discapacitados
if  fFactura.valuebyname[FIELD_TIPOCLIENTE_ID]='5' then
      begin
                           Try
                              with QryConsultas do
                               Try
                                Close;
                                SetProvider(dspQryConsultas);
                                CommandText:='INSERT INTO TDISCAPACITADOS VALUES (SQ_TDISCAPACITADOS_CODDISCAP.nextval,:CODCLIEN,:CODINSPE,:CODFACTU,SYSDATE)';
                                params[0].Value:= fFactura.ValueByName[FIELD_CODCLIEN];
                                params[1].Value:= finspeccion.ValueByName[FIELD_CODINSPE];
                                params[2].Value:= fFactura.ValueByName[FIELD_CODFACTU];
                                Execute;
                               Except

                                end;
                              finally
                                QryConsultas.Close;
                                QryConsultas.Free;
                                dspQryConsultas.Free;
                                sdsQryConsultas.Free;
                              end;
                         end;
end;

end.    //Final de la unidad