unit UFFacturaGNC;


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, ExtCtrls,Printers, SQLEXPR,
  USAGCLASSES, USAGPRINTERS, globals;

type
  TfrmFacturaGNC = class(TForm)
    QRFactura: TQuickRep;
    DetailBand1: TQRBand;
    QRChildA: TQRChildBand;
    QRChildB: TQRChildBand;
    QRLblSubTotal: TQRLabel;
    QRLblIVAInscr: TQRLabel;
    QRLblIVANoIns: TQRLabel;
    QRLblTotalA: TQRLabel;
    QRLblTotalB: TQRLabel;
    SummaryBand1: TQRBand;
    QRShape1: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRLabel20: TQRLabel;
    QRShape18: TQRShape;
    QRLabel21: TQRLabel;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRLabel23: TQRLabel;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRShape15: TQRShape;
    QRLblIVAInsPorcen: TQRLabel;
    QRLblIVANoInsPorcen: TQRLabel;
    TitleBand1: TQRBand;
    QRShape4: TQRShape;
    QRShape3: TQRShape;
    QRShape2: TQRShape;
    QRLblTitulo: TQRLabel;
    QRLblNombreCompleto: TQRLabel;
    QRLblDireccion: TQRLabel;
    QRLblLocalidad: TQRLabel;
    QRLblIVA: TQRLabel;
    QRLblCUIT: TQRLabel;
    QRLblCondicionesVenta: TQRLabel;
    QRLblCantidad: TQRLabel;
    QRLblDescripcion: TQRLabel;
    QRLblPrecioUni: TQRLabel;
    QRLblTipo: TQRLabel;
    QRLblFecha: TQRLabel;
    QRLblTotalUnidad: TQRLabel;
    QRLblNumero: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape5: TQRShape;
    QRLabel22: TQRLabel;
    QRLabel24: TQRLabel;
    QRImage1: TQRImage;
    QRLbldescuento: TQRLabel;
    QRLblCantidaddesc: TQRLabel;
    QRLblPrecioUnidesc: TQRLabel;
    QRLblTotalUnidadDesc: TQRLabel;
    QRLblCantidadIIBB: TQRLabel;
    QRLblIIBB: TQRLabel;
    QRLblPrecioUniIIBB: TQRLabel;
    QRLblTotalUnidadIIBB: TQRLabel;
    procedure QRFacturaNeedData(Sender: TObject; var MoreData: Boolean);
    procedure QRFacturaAfterPrint(Sender: TObject);
    procedure QRFacturaAfterPreview(Sender: TObject);
    procedure QRFacturaPreview(Sender: TObject);
    procedure QRFacturaBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    bFacturaRellena: boolean;
    fImprimirFactura: boolean; { True si el usuario ha pulsado "Imprimir" }

    aFactura: TFacturacion;

    procedure Rellenar_CabeceraFactura(const atipo:string);
    procedure Rellenar_Concepto;
    procedure Rellenar_Concepto_NCD(const aPausa:boolean);
    procedure Rellenar_Totales;
    procedure Rellenar_Total_FacturaA;
    procedure Rellenar_Total_FacturaB;
    procedure Rellenar_DatosCliente;
    function GetImprimirFactura: boolean;
    procedure SetImprimirFactura (const bImprimir: boolean);
    procedure ActivarDesactivar_Componentes (const bActivar: boolean);
    function Devolver_Descripcion_Vehiculo: string;
    function Devolver_Descripcion_NCD(const aPausa: boolean) : string;
    function Devolver_Descripcion_Descuento:string;
  public
    { Public declarations }
    constructor CreateFromFactura (aFact: TFacturacion; const bVisualizar: boolean; aContexto: pTContexto);
    constructor CreateFromNCredito (aNCredito: TContraFacturas; const bVisualizar: boolean; aContexto: pTContexto);
    constructor CreateFromNCDescuento (aFact: TFacturacion; const bVisualizar: boolean; aContexto: pTContexto);
    property ImprimirFactura: boolean read GetImprimirFactura write SetImprimirFactura;

    procedure Rellenar_Factura;
    procedure Rellenar_NCDescuento(const aPausa:boolean);   //
  end;


var
  frmFacturaGNC: TfrmFacturaGNC;

implementation

{$R *.DFM}

uses
   UFPRESPRELIMINAR,
   QrPrnTr,
   USAGESTACION,
   UTILORACLE,
   ULOGS,
   UCTIMPRESION,
   UCLIENTE;


const
   CANTIDAD_VEHICULOS = 1; { Nº de vehículos a cobrar por factura }

resourcestring
    FICHERO_ACTUAL = 'UFFacturagnc';

    LITERAL_DESCRIPCION_FACTURA = 'Revisión Técnica vehicular nº   ''%s'' del vehículo patente ''%s''.';


var
  frmPresPreliminar_Auxi: TfrmPresPreliminar;



constructor TfrmFacturaGNC.CreateFromFactura (aFact: TFacturacion; const bVisualizar: boolean; aContexto: pTContexto);
begin
    inherited Create (Application);

    aFactura := aFact;
    Rellenar_Factura;

    if bVisualizar then
    begin
        ActivarDesactivar_Componentes (True);
        QRFactura.Preview;
    end
    else
    begin
        ActivarDesactivar_Componentes (False);

        if (aContexto <> nil) then
        begin
            QRFactura.PrinterSettings.PrinterIndex:=Printer.Printers.IndexOf(aContexto^.sNombre);
            QRFactura.Printersettings.OutputBin := aContexto^.qrbBandeja;
            QRFactura.Page.PaperSize := aContexto^.qrpPapel;
            QRFactura.PrinterSettings.Orientation := aContexto^.qroOrientacion;
            QRFactura.Page.LeftMargin := aContexto^.iMargenIzquierdo;
            QRFactura.Page.TopMargin := aContexto^.iMargenSuperior;
        end;

        QRFactura.Print;
    end
end;

constructor TfrmFacturaGNC.CreateFromNCredito (aNCredito: TContraFacturas; const bVisualizar: boolean; aContexto: pTContexto);
begin
    inherited Create (Application);

    aFactura := aNCredito.fMasterFactura;
    Rellenar_Factura;

    // En una nota de crédito cambian el título y número de factura
    QRLblTitulo.Caption := aNCredito.TituloFactura;

    if bVisualizar then
    begin
        ActivarDesactivar_Componentes (True);
        QRFactura.Preview;
    end
    else
    begin
        ActivarDesactivar_Componentes (False);

        if (aContexto <> nil) then
        begin
            QRFactura.PrinterSettings.PrinterIndex:=Printer.Printers.IndexOf(aContexto^.sNombre);
            QRFactura.Printersettings.OutputBin := aContexto^.qrbBandeja;
            QRFactura.Page.PaperSize := aContexto^.qrpPapel;
            QRFactura.PrinterSettings.Orientation := aContexto^.qroOrientacion;
            QRFactura.Page.LeftMargin := aContexto^.iMargenIzquierdo;
            QRFactura.Page.TopMargin := aContexto^.iMargenSuperior;
        end;

        QRFactura.Print;
    end
end;

constructor TfrmFacturaGNC.CreateFromNCDescuento (aFact: TFacturacion; const bVisualizar: boolean; aContexto: pTContexto);
begin
    inherited Create (Application);
    aFactura := aFact;
    Rellenar_NCDescuento(not bVisualizar);
    if bVisualizar then
    begin
        ActivarDesactivar_Componentes (True);
        QRFactura.Preview;
    end
    else
    begin
        ActivarDesactivar_Componentes (False);
        if (aContexto <> nil) then
        begin
            QRFactura.PrinterSettings.PrinterIndex:=Printer.Printers.IndexOf(aContexto^.sNombre);
            QRFactura.Printersettings.OutputBin := aContexto^.qrbBandeja;
            QRFactura.Page.PaperSize := aContexto^.qrpPapel;
            QRFactura.PrinterSettings.Orientation := aContexto^.qroOrientacion;
            QRFactura.Page.LeftMargin := aContexto^.iMargenIzquierdo;
            QRFactura.Page.TopMargin := aContexto^.iMargenSuperior;
        end;
        QRFactura.Print;
    end
end;


procedure TfrmFacturaGNC.Rellenar_Factura;
begin
    Rellenar_CabeceraFactura(TIPO_FACTURAGNC);
    Rellenar_Concepto;
    Rellenar_Totales;
end;

procedure TfrmFacturaGNC.Rellenar_NCDescuento(const aPausa:boolean);
begin
    Rellenar_CabeceraFactura(TIPO_NCD);
    Rellenar_Concepto_NCD(apausa);
    Rellenar_Totales;
end;

procedure TfrmFacturaGNC.Rellenar_Concepto;
var aQ: TsqlQuery;
begin
    with aFactura do
    begin
        QRLblCantidad.Caption := Format ('%d',[CANTIDAD_VEHICULOS]);
        QRLblDescripcion.Caption := Devolver_Descripcion_Vehiculo;

        if (fVarios.ValueByName[FIELD_ENA_PIB] = 'S') and (aFactura.ValueByName[FIELD_IIBB] <> '0') then
        begin
          QRLblCantidadIIBB.Caption := Format ('%d',[CANTIDAD_VEHICULOS]);
          QRLblIIBB.Caption := 'PERCEPCIONES: II BB BS.AS.';
          QRLblPrecioUniIIBB.caption := Format ('%1.2f',[strtofloat(floattostrf(strtofloat(aFactura.ValueByName[FIELD_IIBB])/100*strtofloat(aFactura.ValueByName[FIELD_IMPONETO]),fffixed,15,2))]);
          QRLblTotalUnidadIIBB.caption := Format ('%1.2f',[strtofloat(floattostrf(strtofloat(aFactura.ValueByName[FIELD_IIBB])/100*strtofloat(aFactura.ValueByName[FIELD_IMPONETO]),fffixed,15,2))]);

          QRLblCantidadIIBB.enabled := true;
          QRLblIIBB.enabled := true;
          QRLblPrecioUniIIBB.enabled := true;
          QRLblTotalUnidadIIBB.enabled := true;
        end;

        aFactura.ffactadicionales:=nil;
        try
          aFactura.ffactadicionales := TFact_adicionales.CreateFromFactura(aFactura.database,aFactura.ValueByName[FIELD_CODFACTU],'F','G');
          afactura.ffactadicionales.open;
          if strtofloat(afactura.ValueByName[FIELD_IMPONETO])<>strtofloat(afactura.ffactadicionales.ValueByName[FIELD_IMPSINDES]) then    // 
          begin
            try
              aQ := TsqlQuery.Create(self);
              try
                aQ.sqlconnection := mybd;

{ TODO -oran -ctransacciones : Ver tema sesion }


                aQ.SQL.Add('SELECT C.COLETILLA FROM TFACTURAS F, TTIPOSCLIENTE C ');
                aQ.SQL.Add(Format('WHERE F.CODFACTU= ''%S'' AND C.TIPOCLIENTE_ID=F.TIPOCLIENTE_ID',[aFactura.ValueByName[FIELD_CODFACTU]]));
                aQ.Open;
                QRLblDescuento.Caption := 'Bonificación '+aQ.fields[0].asstring;
              finally
                aQ.Free;
              end;
              if aFactura.ffactadicionales.valuebyname[FIELD_CODDESCU] <> '' then
                qrLblDescuento.Caption := qrLblDescuento.Caption +#13+devolver_descripcion_descuento;
            except
              on E:Exception do
              begin
                 fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'Error al recuperar datos de la descripción de un vehículo por: %s',[E.message]);
                 raise Exception.Create('Error en la recuperación de datos')
              end;
            end;

            QRLblCantidadDesc.Caption := Format ('%d',[CANTIDAD_VEHICULOS]);
            QRLblCantidadDesc.Enabled := True;
            QRLblDescuento.Enabled := True;
            QRLblPrecioUniDesc.Caption := Format ('%1.2f',[StrToFloat(afactura.ffactadicionales.ValueByName[FIELD_DESCUENT])]);
            QRLblPrecioUniDesc.Enabled := True;
            QRLblTotalUnidadDesc.Caption := Format ('%1.2f',[StrToFloat(afactura.ffactadicionales.ValueByName[FIELD_DESCUENT])]);
            QRLblTotalUnidadDesc.Enabled := True;
        end;

        QRLblPrecioUni.Caption := Format ('%1.2f',[StrToFloat(afactura.ffactadicionales.ValueByName[FIELD_IMPSINDES])]);
        QRLblTotalUnidad.Caption := Format ('%1.2f',[StrToFloat(afactura.ffactadicionales.ValueByName[FIELD_IMPSINDES])]);
        QRLblIVAInsPorcen.Caption := Format ('%1.2f%%',[StrToFloat(aFactura.ValueByName[FIELD_IVAINSCR])]);
        QRLblIVANoInsPorcen.Caption := Format ('%1.2f%%',[StrToFloat(aFactura.ValueByName[FIELD_IVANOINS])]);
        finally
          aFactura.ffactadicionales.close;
        end;
    end;
end;

procedure TfrmFacturaGNC.Rellenar_Concepto_NCD(const aPausa:boolean);
var aNCredito: TContraFacturas;
begin
    with aFactura do
    begin
        QRLblCantidad.Caption := Format ('%d',[CANTIDAD_VEHICULOS]);
        aFactura.ffactadicionales:=nil;
      try
        aFactura.ffactadicionales := TFact_adicionales.CreateFromFactura(aFactura.database,aFactura.ValueByName[FIELD_CODFACTU],'D','D');
        aFactura.ffactadicionales.open;
        QRLblPrecioUni.Caption := Format ('%1.2f',[StrToFloat(ffactadicionales.ValueByName[FIELD_IMPSINDES])]);
        QRLblTotalUnidad.Caption := Format ('%1.2f',[StrToFloat(ffactadicionales.ValueByName[FIELD_IMPSINDES])]);
        QRLblIVAInsPorcen.Caption := Format ('%1.2f%%',[StrToFloat(ValueByName[FIELD_IVAINSCR])]);
        QRLblIVANoInsPorcen.Caption := Format ('%1.2f%%',[StrToFloat(ValueByName[FIELD_IVANOINS])]);
        QRLblDescripcion.Caption := devolver_descripcion_NCD(aPausa);
        try
          aNCredito := nil;
          QRLblTitulo.caption :=  aNCredito.TituloFactura;
        finally
          aNCredito.free;
        end;
      finally
        aFactura.ffactadicionales.close;
        aFactura.ffactadicionales:=nil;
      end;
    end;
end;


procedure TfrmFacturaGNC.Rellenar_CabeceraFactura(const aTipo: string);
var
  sCadena_Auxi,sTarjeta: string; //cadena auxiliar
  LiteralIVA_Auxi: tTipoTributacion;
  FormaPago_Auxi: tFormaPago;
begin
    with aFactura do
    begin
        QRLblTipo.Caption := ValueByName[FIELD_TIPFACTU];

        QRLblTitulo.Caption := TituloFactura;
        QRLblFecha.Caption := DateBD (Database);
        if atipo = TIPO_FACTURAGNC then
          QRLblNumero.Caption := DevolverNumeroFactura(TIPO_FACTURAGNC)
        else
          QRLblNumero.Caption := 'XXXXXXX';
        Rellenar_DatosCliente;

        // Literal de IVA
        sCadena_Auxi := ValueByName[FIELD_TIPTRIBU];
        if (sCadena_Auxi = IVA_INSCRIPTO) then
           LiteralIVA_Auxi := tttIvaInscripto
        else if (sCadena_Auxi = IVA_NO_INSCRIPTO) then
           LiteralIVA_Auxi := tttIvaNoInscripto
        else if (sCadena_Auxi = IVA_EXENTO) then
           LiteralIVA_Auxi := tttIvaExento
        else if (sCadena_Auxi = IVA_MONOTRIBUTO) then
           LiteralIVA_Auxi := tttIvaMonotributo
        else
           LiteralIVA_Auxi := tttConsumidorFinal;

        QRLblIVA.Caption := S_TIPO_TRIBUTACION [tTipoTributacion(LiteralIVA_Auxi)];


        // Condiciones Venta
        sTarjeta := '';     //
        if (ValueByName[FIELD_FORMPAGO] = FORMA_PAGO_METALICO) then
           FormaPago_Auxi := tfpMetalico
        else if (ValueByName[FIELD_FORMPAGO] = FORMA_PAGO_CREDITO) then
           FormaPago_Auxi := tfpCredito
        else if (ValueByName[FIELD_FORMPAGO] = FORMA_PAGO_TARJETA) then
        begin
           aFactura.ffactadicionales := nil;
           try
             aFactura.ffactadicionales := TFact_adicionales.CreateFromFactura(aFactura.database,aFactura.ValueByName[FIELD_CODFACTU],aTipo, aTipo);
             aFactura.ffactadicionales.open;
             FormaPago_Auxi := tfpTarjeta;
             sTarjeta := ': '+afactura.ffactadicionales.GetNombreTarjeta(afactura.ffactadicionales.valuebyname[FIELD_CODTARJET])+' ... '+Trim(Copy(afactura.ffactadicionales.valuebyname[FIELD_NUMTARJET],length(afactura.ffactadicionales.valuebyname[FIELD_NUMTARJET])-7,8));;
           finally
             aFactura.ffactadicionales.close;
           end;
        end
        else if (ValueByName[FIELD_FORMPAGO] = FORMA_PAGO_CHEQUE) then
        begin
           FormaPago_Auxi := tfpCheque;
           if aTipo = TIPO_FACTURAGNC then
             sTarjeta := ': '+afactura.DevolverNroCheque;
        end
        else
           FormaPago_Auxi := tfpOficial;

        QRLblCondicionesVenta.Caption := S_FORMA_PAGO[FormaPago_Auxi]+sTarjeta;
    end;
end;

procedure TfrmFacturaGNC.Rellenar_Totales;
begin
    if (aFactura.ValueByName[FIELD_TIPFACTU] = FACTURA_TIPO_A) then
    begin
        QRChildA.Enabled := True;
        Rellenar_Total_FacturaA;
    end
    else
    begin
        QRChildA.Enabled := False;
        Rellenar_Total_FacturaB;
    end;

    QRChildB.Enabled := (not QRChildA.Enabled);
end;


procedure TfrmFacturaGNC.Rellenar_Total_FacturaA;
begin
    with aFactura do
    begin
        QRLblSubTotal.Caption := floattostrf(strtofloat(ValueByName[FIELD_IMPONETO]),ffnumber,10,2);    
        QRLblIVAInscr.Caption := Format ('%1.2f',[IvaInscriptoFactura]);
        QRLblIVANoIns.Caption := Format ('%1.2f',[IVANoInscriptoFactura]);
        QRLblTotalA.Caption := Format ('%1.2f',[Monto]);
    end;
end;


procedure TfrmFacturaGNC.Rellenar_Total_FacturaB;
begin
    with aFactura do                //  MODI RAN
    begin
      QRLblTotalB.Caption := Format ('%1.2f',[Monto]);
    end;
end;



procedure TfrmFacturaGNC.Rellenar_DatosCliente;
begin
    with aFactura do
    begin
        if (ValueByName[FIELD_SINDATOS] = SIN_DATOS_CLIENTE) then
        begin
            QRLblNombreCompleto.Caption := '';
            QRLblDireccion.Caption := '';
            QRLblLocalidad.Caption := '';
            QRLblCUIT.Caption := '';
        end
        else
        begin
            with TSQLQuery.Create(self) do
            begin
                try
                    try
                         SQLConnection := MyBD;

                         { TODO -oran -ctransacciones : Ver tema sesion }

                         SQL.Add (Format('SELECT NOMBRE || '' '' || APELLID1 || '' '' || APELLID2 NAME, CUIT_CLI, DIRECCIO, NROCALLE, PISO, DEPTO, CODPOSTA || '' - '' || LOCALIDA  LOCALITY FROM TCLIENTES WHERE CODCLIEN = %s',[aFactura.ValueByName[FIELD_CODCLIEN]]));
                         Open;
                         QRLblNombreCompleto.Caption := FieldByName('NAME').AsString;
                         QRLblDireccion.Caption := FieldByName(FIELD_DIRECCIO).AsString+' '+FieldByName(FIELD_NROCALLE).AsString+' '+FieldByName(FIELD_PISO).AsString+' '+FieldByName(FIELD_DEPTO).AsString;
                         QRLblLocalidad.Caption := FieldByName('LOCALITY').AsString;
                         QRLblCUIT.Caption := FieldByName(FIELD_CUIT_CLI).AsString;
                    except
                        on E: Exception do
                        begin
                            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'Error al recuperar datos de la descripción del ciente por: %s',[E.message]);
                            raise Exception.Create('The retrieve of client description was wrong')
                        end
                    end;
                finally
                    Free;
                end;
            end;
        end;
    end;
end;


procedure TfrmFacturaGNC.QRFacturaNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
    if bFacturaRellena then
       MoreData := False
    else
    begin
        bFacturaRellena := True;
        MoreData := True;
    end;
end;

function TfrmFacturaGNC.GetImprimirFactura: boolean;
begin
    Result := fImprimirFactura;
end;

procedure TfrmFacturaGNC.SetImprimirFactura (const bImprimir: boolean);
begin
    fImprimirFactura := bImprimir;
end;


procedure TfrmFacturaGNC.QRFacturaAfterPrint(Sender: TObject);
begin
    ImprimirFactura := True;
end;

procedure TfrmFacturaGNC.ActivarDesactivar_Componentes (const bActivar: boolean);
var
  i: integer;

begin
    for i := 0 to Self.ComponentCount-1 do
    begin
        if (Self.Components[i].Tag = 1) then
        begin
            if (Self.Components[i] is TQRImage) then
               TQRImage(Self.Components[i]).Enabled := bActivar
            else if (Self.Components[i] is TQRLabel) then
               TQRLabel(Self.Components[i]).Enabled := bActivar
            else if (Self.Components[i] is TQRShape) then
               TQRShape(Self.Components[i]).Enabled := bActivar
        end;
    end;
end;


function TfrmFacturaGNC.Devolver_Descripcion_Vehiculo: string;
const
    LITERAL_VEHICULO_OFICIAL = 'Vehículo Oficial';

var
    aQ : TSQLQuery;
begin
    Try
        aQ := TSQLQuery.Create(self);
        with aQ do
        begin
            try
                SQLConnection :=MyBD;

                { TODO -oran -ctransacciones : Ver tema sesion }

                SQL.Add (Format( ' SELECT ''Revisión Periódica Anual nº "'' ||                                                                                                                                                      ' + #10 + #13 +
                                 ' MOD(I.EJERCICI,100) || '' '' || LTRIM(TO_CHAR(V.ZONA,''0000'')) || LTRIM(TO_CHAR(V.ESTACION,''0000'')) || DECODE(I.CODINSPGNC,-1,''XXXXXX'',LTRIM(TO_CHAR(I.CODINSPGNC,''000000''))) || DECODE(I.TIPO,''I'','' R'',''E'', '' R'', '''') || ' + #10 + #13 +
                                 ' ''" del vehículo patente "'' || NVL(PATENTEN, PATENTEA) || ''"''                                                                                                                                      ' + #10 + #13 +
                                 ' || DECODE (V.OFICIAL,''S'',''. Vehículo Oficial'','''') || ''. ''                                                                                                                                     ' + #10 + #13 +
                                 ' FROM                                                                                                                                                                                                 ' + #10 + #13 +
                                 ' 	INSPGNC I, TVARIOS V, TFACTURAS F, TVEHICULOS V, TTIPOSCLIENTE C                                                                                                                                ' + #10 + #13 +
                                 ' WHERE                                                                                                                                                                                                ' + #10 + #13 +
                                 ' 	F.CODFACTU = %S AND                                                                                                                                                                                 ' + #10 + #13 +
                                 ' 	I.CODFACTU = F.CODFACTU AND                                                                                                                                                                         ' + #10 + #13 +
                                 ' 	I.CODVEHIC = V.CODVEHIC AND                                                                                                                                                                         ' + #10 + #13 +
                                 '  C.TIPOCLIENTE_ID = F.TIPOCLIENTE_ID                                                                                                                                                                 '
                                 ,[aFactura.ValueByName[FIELD_CODFACTU]]));
                Open;
                Result := Fields[0].AsString;
            finally
                Free;
            end;
        end;
    except
        on E:Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'Error al recuperar datos de la descripción de un vehículo por: %s',[E.message]);
            raise Exception.Create('The retrieve of vehicle description was wrong')
        end;
    end;
end;

function TfrmFacturaGNC.Devolver_Descripcion_NCD(const aPausa:boolean): string;
var
    aQ : TSQLQuery;
begin
    Try
        if aPausa then sleep(3000);
        aQ := TSQLQuery.Create(self);
        with aQ do
        begin
            try
                SQLConnection := MyBD;

                { TODO -oran -ctransacciones : Ver tema sesion }

                SQL.Add (Format( ' SELECT ''Bonificación realizada s/ Fact: '' ||                                                                                                                                                      ' + #10 + #13 +
                                 ' TIPFACTU || '' '' || LTRIM(TO_CHAR(PTOVENT,''0000'')) || ''-'' || TO_CHAR(NUMFACTU,''00000000'') || '' '' ||' +
                                 ' '' '' || DESCRIPCION '+
                                 ' FROM                                                                                                                                                                                                 ' + #10 + #13 +
                                 ' 	TFACTURAS F, TFACT_ADICION A, TDESCUENTOS D' +
                                 ' WHERE                                                                                                                                                                                                ' + #10 + #13 +
                                 ' 	F.CODFACTU = A.CODFACT  AND                                                                                                                                                                                 ' + #10 + #13 +
                                 ' 	A.CODDESCU = D.CODDESCU AND                                                                                                                                                                         ' + #10 + #13 +
                                 ' 	F.CODFACTU = ''%S''                                                                                                                                                                         '
                                 ,[aFactura.ffactadicionales.ValueByName[FIELD_RELCODFAC]]));
                Open;
                Result := Fields[0].AsString;
            finally
                Free;
            end;
        end;

    except
        on E:Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'Error al recuperar datos de la descripción de un vehículo por: %s',[E.message]);
            raise Exception.Create('The retrieve of vehicle description was wrong')
        end;
    end;
end;


procedure TfrmFacturaGNC.QRFacturaAfterPreview(Sender: TObject);
begin
    ImprimirFactura := (frmPresPreliminar_Auxi.ModalResult = mrOk);
end;

procedure TfrmFacturaGNC.QRFacturaPreview(Sender: TObject);
begin
   frmPresPreliminar_Auxi := TfrmPresPreliminar.Create (Application);
   frmPresPreliminar_Auxi.QRPrevPresPrel.QRPrinter := TQRPrinter (Sender);
   frmPresPreliminar_Auxi.Show;
end;

function TfrmFacturaGNC.Devolver_Descripcion_Descuento:string;
var fdescuento: tdescuentognc;
begin
  result := '';
  if aFactura.ffactadicionales.ValueByName[FIELD_CODDESCU] <> '' then
  begin
    fdescuento:=nil;
    fdescuento:=tdescuentognc.CreateFromCoddescu(afactura.DataBase,afactura.ffactadicionales.valuebyname[FIELD_CODDESCU]);
    try
      fdescuento.open;
      result := fDescuento.ValueByName[FIELD_DESCRIPCION];
      fdescuento.close;
    finally
      fdescuento.free;
    end;
  end;
end;


procedure TfrmFacturaGNC.QRFacturaBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
    bFacturaRellena := False;
end;

end.
