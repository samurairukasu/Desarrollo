unit UFFactura;


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, ExtCtrls,Printers, SQLEXPR,
  USAGCLASSES, USAGPRINTERS, Globals,  usuperregistry, OleCtrls,
  OCXFISLib_TLB,strUtils, ComObj,uconversiones, ucontstatus,
  EPSON_Impresora_Fiscal_TLB;

type
  TfrmFactura = class(TForm)
    QRFactura: TQuickRep;
    DetailBand1: TQRBand;
    TitleBand1: TQRBand;
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
    QRChildA: TQRChildBand;
    QRChildB: TQRChildBand;
    QRLblSubTotal: TQRLabel;
    QRLblIVAInscr: TQRLabel;
    QRLblIVANoIns: TQRLabel;
    QRLblTotalA: TQRLabel;
    QRLblTotalB: TQRLabel;
    QRLblNumero: TQRLabel;
    SummaryBand1: TQRBand;
    QRShape1: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
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
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRLabel20: TQRLabel;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape18: TQRShape;
    QRLabel21: TQRLabel;
    QRShape14: TQRShape;
    QRShape16: TQRShape;
    QRShape5: TQRShape;
    QRShape17: TQRShape;
    QRLabel23: TQRLabel;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRShape15: TQRShape;
    QRLblIVAInsPorcen: TQRLabel;
    QRLblIVANoInsPorcen: TQRLabel;
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
    QRLey13987: TQRLabel;
    DriverFiscal1: TDriverFiscal;




    procedure QRFacturaNeedData(Sender: TObject; var MoreData: Boolean);
    procedure QRFacturaAfterPrint(Sender: TObject);
    procedure QRFacturaAfterPreview(Sender: TObject);
    procedure QRFacturaPreview(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRFacturaBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    bFacturaRellena: boolean;
    fImprimirFactura: boolean; { True si el usuario ha pulsado "Imprimir" }
//    aImporte : TQuery;  //  
      impfis: _PrinterFiscalDisp;
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
    function Devolver_patente_Vehiculo_NC: string;
    function Devolver_Descripcion_NCD(const aPausa: boolean) : string;
    function Devolver_Descripcion_Descuento:string;
     function Devolver_numero_inspeccion_Vehiculo: string;


    //-----------------------
  public
   tiene_que_imprimir:boolean;
     cf:integer;
     puerto:string;
     velo:integer;
    { Public declarations }
    constructor CreateFromFactura (aFact: TFacturacion; const bVisualizar: boolean; aContexto: pTContexto);
    constructor CreateFromNCredito (aNCredito: TContraFacturas; const bVisualizar: boolean; aContexto: pTContexto);
    constructor CreateFromNCDescuento (aFact: TFacturacion; const bVisualizar: boolean; aContexto: pTContexto);
    property ImprimirFactura: boolean read GetImprimirFactura write SetImprimirFactura;

    procedure Rellenar_Factura;
    procedure Rellenar_NCDescuento(const aPausa:boolean);   //


     //para NC con controlador fiscal
     function controlador_imprime_NC:boolean;
     procedure imprimir_NC_en_CF;
      procedure Rellenar_DatosCliente_NC;

  end;


var
  frmFactura: TfrmFactura;

implementation

{$R *.DFM}

uses
   UFPRESPRELIMINAR,
   QrPrnTr,
   USAGESTACION,
   UTILORACLE,
   ULOGS,
   UCTIMPRESION,
   UCONST,
   UCLIENTE,
   UUtils,
  USAGDATA,UVERSION;

const
   CANTIDAD_VEHICULOS = 1; { Nº de vehículos a cobrar por factura }

resourcestring
    FICHERO_ACTUAL = 'UFFactura';

    LITERAL_DESCRIPCION_FACTURA = 'Revisión Técnica vehicular nº   ''%s'' del vehículo patente ''%s''.';


var
  frmPresPreliminar_Auxi: TfrmPresPreliminar;


procedure TFrmFactura.Rellenar_DatosCliente_NC;
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




procedure TFrmFactura.imprimir_NC_en_CF;
var error,longi,NUM_FACTU:longint;
cabezal,sCadena_Auxi,Li,nombre_cliente,dire_cliente:string;
localidad_cliente,letra,patente,MOTIVO,status:string;
cuit_cliente,numero_factura,puerto_cf,puerto,TIPODOCU,DOCUMENTO,nro_insp,sql:string;
cf,velo,NUMERO_CODFAC:longint;

importe,tp_factura,iibb,item_nc,cantidad,IMPRIMIO,FECHAALTA:string;
 aQ : TsqlQuery;
item_descuento,X1,X2,X3,X4,X5,X6,X7,X8,X9:string;
   canti_descuento:string;
   importe_descuento,importe_iibb,cant_iibb, item_iibb,strCampo:string;
begin


// me traigo el puerto, la velocidad

with TSuperRegistry.Create do
try
   RootKey := HKEY_LOCAL_MACHINE;
     if  OpenKeyRead(CAJA_) then
         begin
          puerto:= ReadString(PortNumber_);
          velo:= strtoint(ReadString(BaudRate_));
           end;


finally
free;
end;
//---------------fin



 // abro el puerto
puerto_cf:='COM'+trim(puerto);

// para ocx if
error :=DriverFiscal1.IF_OPEN(puerto_cf,velo);


// averiguo iva  del cliente
with aFactura do
begin
  sCadena_Auxi := ValueByName[FIELD_TIPTRIBU];
        if (sCadena_Auxi = IVA_INSCRIPTO) then
          begin
           Li := 'I';
           letra:='A';
          end
        else if (sCadena_Auxi = IVA_NO_INSCRIPTO) then
             begin
              Li := 'R';
              letra:='A';
             end
        else if (sCadena_Auxi = IVA_EXENTO) then
              begin
               Li := 'E';
              letra:='B';
              end
        else if (sCadena_Auxi = IVA_MONOTRIBUTO) then
             begin
              Li := 'M';
               letra:='B';
              end
        else
           begin
           Li := 'F';
           letra:='B';
           end;
end;
//********************fin iva del cliente




with aFactura do
begin


// averiguo datos del cliente
        if (ValueByName[FIELD_SINDATOS] = SIN_DATOS_CLIENTE) then
        begin
            nombre_cliente:= '';
            dire_cliente := '';
            localidad_cliente := '';
            cuit_cliente:= '';
        end
        else
         begin
            with TSQLQuery.Create(self) do
            begin
                try
                    try
                         SQLConnection := MyBD;
                         SQL.Add (Format('SELECT NOMBRE || '' '' || APELLID1 || '' '' || APELLID2 NAME, TIPODOCU, DOCUMENT, CUIT_CLI, DIRECCIO, NROCALLE, PISO, DEPTO, CODPOSTA || '' - '' || LOCALIDA  LOCALITY FROM TCLIENTES WHERE CODCLIEN = %s',[aFactura.ValueByName[FIELD_CODCLIEN]]));
                         Open;
                         nombre_cliente:= FieldByName('NAME').AsString;
                         dire_cliente := FieldByName(FIELD_DIRECCIO).AsString+' '+FieldByName(FIELD_NROCALLE).AsString+' '+FieldByName(FIELD_PISO).AsString+' '+FieldByName(FIELD_DEPTO).AsString;
                         localidad_cliente:= FieldByName('LOCALITY').AsString;
                         cuit_cliente := FieldByName(FIELD_CUIT_CLI).AsString;
                         cuit_cliente:= AnsiReplaceStr(cuit_cliente,'-','');
                         tipodocu:= FieldByName(FIELD_TIPODOCU).AsString;
                         documento:= FieldByName(FIELD_DOCUMENT).AsString;
                           if trim(cuit_cliente)='' then
                              cuit_cliente:='';
                      except
                         on E: Exception do
                         begin
                            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'Error al recuperar datos de la descripción del cliente por: %s',[E.message]);
                            raise Exception.Create('The retrieve of client description was wrong')
                          end
                      end;
                finally
                    Free;
                end;
            end;
        end;
//fin datos clientes



  // devuelve importe factura
   with TSQLQuery.Create(self) do
            begin
                try
                    try
                         SQLConnection := MyBD;
                         Sql.add(format('select  tipfactu,  imponeto,  ROUND(imponeto+((IMPONETO*IVAINSCR)/100)+ ((IMPONETO*IVANOINS)/100) ,2) AS imponetoa ,iibb from tfacturas   where codfactu = %s ',[aFactura.ValueByName[FIELD_CODFACTU]]));
                         Open;
                          if  Fields[0].asstring='B' then
                              importe:=floattostr(Fields[1].asfloat+Fields[3].asfloat)
                           else
                              importe:=Fields[1].asstring;

                         importe:= AnsiReplaceStr(importe,',','.');
                         iibb:= AnsiReplaceStr(iibb,',','.');
                         tp_factura:=FieldByName('TIPFACTU').AsString;




                      except
                        on E: Exception do
                        begin
                            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'Error al recuperar datos de la descripción del cliente por: %s',[E.message]);
                            raise Exception.Create('The retrieve of client description was wrong')
                        end
                    end;
                finally
                    Free;
                end;
            end;




end;


// averiguo numero de factura
with aFactura do
begin
       if  TIPO_FACTURA <> '' then
          numero_factura := DevolverNumeroFactura(TIPO_FACTURA)
        else
          numero_factura := 'XXXXXXX';
end;


// solo para ocx if
//armo cabezal para imprimir nota de credito

cabezal:='@FACTABRE|M|C|'+trim(tp_factura)+'|1|P|10|I|'+trim(li)+'|'+trim(nombre_cliente)+'|';
 if (sCadena_Auxi = IVA_INSCRIPTO) then
    cabezal:=cabezal + '|CUIT |'+trim(cuit_cliente)
    else
    cabezal:=cabezal + '|'+trim(tipodocu)+'|'+trim(documento);


  //direccion y nro de factura
  cabezal:=cabezal +'|N|'+trim(dire_cliente)+'|||'+trim(numero_factura)+'||C';

  //imprimo cabezal  para ocx if
 error:=DriverFiscal1.IF_WRITE(cabezal) ;




 {
 X1:='M';
 X2:='C';
 X3:='1';
 X4:='P';
 X5:='10';
 X6:='I';
 X7:='-';
 X8:='CUIT';
 X9:='N';


impfis.OpenInvoice(X1,X2,TP_FACTURA,X3,X4,X5,X6,li,nombre_clientE,X7,X8,cuit_cliente,X9,dire_cliente,X7,X7,numero_factura,X7,X2);
 }


// PrinterFiscal1.OpenInvoice("F", "C", "A", "1", "F", "17", "I", "I", "Nombre comercial 1", "Nombre comercial 2", "CUIT", "30614104712", "N", "Domicilio 1", "Domicilio 2", "Domicilio 3", "Remitos 1", "Remitos 2", "C")


with aFactura do
begin


   //amor item VTV Vehiculo para nota de credito.
   cantidad:=Format ('%d',[CANTIDAD_VEHICULOS]);
   item_nc:= 'VTV del Vehiculo ';

   aFactura.ffactadicionales := TFact_adicionales.CreateFromFactura(aFactura.database,aFactura.ValueByName[FIELD_CODFACTU],'F','G');
   afactura.ffactadicionales.open;

   // importe para el item de la nota de credito
   importe:= Format ('%1.2f',[StrToFloat(ffactadicionales.ValueByName[FIELD_IMPSINDES])]);
   importe:= AnsiReplaceStr(importe,',','.');



   // busco  patente   y nro inspeccion
   with TSQLQuery.Create(self) do
   begin
        try
           try
              SQLConnection := MyBD;
              SQL.Add (Format( ' SELECT NVL(PATENTEN, PATENTEA),  ' +
                               ' MOD(I.EJERCICI,100) || '' '' || LTRIM(TO_CHAR(V.ZONA,''0000'')) || LTRIM(TO_CHAR(V.ESTACION,''0000'')) || DECODE(I.CODINSPE,-1,''XXXXXX'',LTRIM(TO_CHAR(I.CODINSPE,''000000''))) || DECODE(I.TIPO,''I'','' R'',''E'', '' R'', '''') ' +
                               ' FROM   '+
                               ' 	TINSPECCION I, TVARIOS V, TFACTURAS F, TVEHICULOS V, TTIPOSCLIENTE C    '+
                               ' WHERE     '+
                               ' 	F.CODFACTU = %S AND    '+
                               ' 	I.CODFACTU = F.CODFACTU AND   '+
                               ' 	I.CODVEHIC = V.CODVEHIC AND     '+
                               '  C.TIPOCLIENTE_ID = F.TIPOCLIENTE_ID     '
                               ,[aFactura.ValueByName[FIELD_CODFACTU]]));

               Open;
               patente:=  Fields[0].asstring;
               nro_insp:='Nro: '+Fields[1].asstring;


           except
             on E: Exception do
                begin
                    fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'Error al recuperar datos de patente y nro inspeccion para la ota de credito por : %s',[E.message]);
                    raise Exception.Create('The retrieve of client description was wrong')
                 end
             end;
           finally
             Free;
          end;
    end;

//************fin patente  y nro inspeccion




// imprimo item VTV   - solo para ocx if
error := DriverFiscal1.IF_WRITE('@FACTITEM|Verificacion|'+trim(cantidad)+'|'+TRIM(importe)+'|0.2100|M|1|0.0|'+trim(item_nc)+'|'+trim(patente)+'|'+trim(nro_insp)+'|0.0000|0');

 //impfis.SendInvoiceItem('Verificacion',trim(cantidad),TRIM(importe),'0.2100','M','1','0.0',trim(item_nc),trim(patente),trim(nro_insp),'0.0000','0');

//  SendInvoiceItem("Descripcion 1", "00001000", "00000000200", "2100", "M", "00000", "00000000", "Descripcion 1", "Descripcion 2", "Descripcion 3", "0000", "000000000000000")



  // me fijo si tiene descuento y percepciones
  if strtofloat(afactura.ValueByName[FIELD_IMPONETO])<>strtofloat(afactura.ffactadicionales.ValueByName[FIELD_IMPSINDES]) then    //
  begin

        try
        //descuentos
          aQ := TsqlQuery.Create(self);
            try
               aQ.SQLConnection := MyBD;
               aQ.SQL.Add('SELECT C.COLETILLA FROM TFACTURAS F, TTIPOSCLIENTE C ');
               aQ.SQL.Add(Format('WHERE F.CODFACTU= ''%S'' AND C.TIPOCLIENTE_ID=F.TIPOCLIENTE_ID',[aFactura.ValueByName[FIELD_CODFACTU]]));
               aQ.Open;
               item_descuento:=aQ.fields[0].asstring;
               importe_descuento:=Format ('%1.2f',[StrToFloat(afactura.ffactadicionales.ValueByName[FIELD_DESCUENT])]);
               importe_descuento:= AnsiReplaceStr(importe_descuento,',','.');
               canti_descuento:=Format ('%d',[CANTIDAD_VEHICULOS]);
            finally
                aQ.Free;
            end;
           if item_descuento <> ''then
            // imprimo descuentos
              error := DriverFiscal1.IF_WRITE('@FACTITEM||'+trim(canti_descuento)+'|'+TRIM(importe_descuento)+'|0.2100|R|1|0.0|'+trim(item_descuento)+'|||0.0000|0');
          except
              on E:Exception do
              begin
                 fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'Error al recuperar datos de la descripción de un vehículo por: %s',[E.message]);
                 raise Exception.Create('Error en la recuperación de datos')
              end ;

     end;
     aFactura.ffactadicionales.close;
    end;


    //end;








         // percepciones
         if (fVarios.ValueByName[FIELD_ENA_PIB] = 'S') and (aFactura.ValueByName[FIELD_IIBB] <> '0') then
        begin

          cant_iibb := Format ('%d',[CANTIDAD_VEHICULOS]);
          item_iibb := 'PERCEPCIONES: II BB BS.AS.';
          importe_iibb := Format ('%1.2f',[strtofloat(floattostrf(strtofloat(aFactura.ValueByName[FIELD_IIBB])/100*strtofloat(aFactura.ValueByName[FIELD_IMPONETO]),fffixed,15,2))]);
          importe_iibb:= AnsiReplaceStr(importe_iibb,',','.');
           if importe_iibb <> '' then
              // imprimo perecepciones
              error := DriverFiscal1.IF_WRITE('@FACTITEM||'+trim(cant_iibb)+'|'+TRIM(importe_iibb)+'|0.2100|M|1|0.0|'+trim(item_iibb)+'|||0.0000|0');


        end;


 end;



// cierro nota de credito
error:=DriverFiscal1.IF_WRITE('@FACTCIERRA|M|'+trim(tp_factura)+'|FINAL');

   IF ERROR = 0 THEN
    IMPRIMIO:='S'
    ELSE
    IMPRIMIO:='N';



 



errOR := DriverFiscal1.IF_WRITE('@ESTADO|N');

 




strCampo := DriverFiscal1.IF_READ(3);










//cierro puerto
DriverFiscal1.IF_CLOSE;
//impfis.CloseInvoice(x1,tp_factura,x7);
 //CloseInvoice("N", "A", "")


  aQ := TsqlQuery.Create(self);
            try
               aQ.SQLConnection := MyBD;
               aQ.SQL.Add('SELECT MAX(CODCOFAC) AS MAXIMO FROM TCONTRAFACT');
               aQ.Open;
               NUMERO_CODFAC:=aQ.fields[0].ASINTEGER + 1;
            finally
                aQ.Free;
            end;


 NUM_FACTU:=1;
 MOTIVO:='  ';
// guardo en tabla tcontrafact
  FECHAALTA:=DATETOSTR(DATE);
   aQ := TsqlQuery.Create(self);
            try
            //IMPRESA, FECHALTA, NUMFACTU, MOTIVAN
            //'+#39+IMPRIMIO+#39+', TO_CHAR('+#39+FECHALTA+#39+',''DD/MM/YYYY''),'+INTTOSTR(NUM_FACTU)+','+#39+TRIM(MOTIVO)+#39+')';
               sql:='INSERT INTO TCONTRAFACT (CODCOFAC, IMPRESA, FECHALTA, NUMFACTU, MOTIVAN)  VALUES ('+INTTOSTR(NUMERO_CODFAC)+','+#39+IMPRIMIO+#39+', TO_DATE('+#39+FECHAALTA+#39+',''DD/MM/YYYY''),'+inttostr(NUM_FACTU)+','+#39+MOTIVO+#39+')';
               aQ.SQLConnection := MyBD;
               aQ.SQL.Add(sql);
               aQ.ExecSQL;
            finally
                aQ.Free;
            end;


//---------------------
//actualizo la tabla factura.
  aQ := TsqlQuery.Create(self);
            try
               aQ.SQLConnection := MyBD;
               aQ.SQL.Add('UPDATE TFACTURAS  SET CODCOFAC= '+INTTOSTR(NUMERO_CODFAC)+' ');
               aQ.SQL.Add(Format('WHERE CODFACTU = ''%S''' ,[aFactura.ValueByName[FIELD_CODFACTU]]));
               aQ.ExecSQL;
            finally
                aQ.Free;
            end;

//-------------------------

   

end;


function TFrmFactura.controlador_imprime_NC:boolean;
var imprime:integer;
aQ : TsqlQuery;
begin
   result:=falsE;
{
with TSuperRegistry.Create do
     try
        RootKey := HKEY_LOCAL_MACHINE;
          if not OpenKeyRead(CAJA_) then
             result:=false
            else
             begin
               imprime := ReadInteger(NCCF_);
               if imprime=1 then
                   result:=true;

             end;

 finally
       free;
     end;
 }



 with TSuperRegistry.Create do
try
   RootKey := HKEY_LOCAL_MACHINE;
     if  OpenKeyRead(CAJA_) then
         begin
          cf:= ReadInteger(PRINTER_);

            aQ := TsqlQuery.Create(self);
            try
               aQ.SQLConnection := MyBD;
               aQ.SQL.Add('SELECT IMPRIME_NC FROM TCONTROLADORES_FISCALES  WHERE  CODIGO ='+INTTOSTR(cf));
               aQ.Open;
               if  AQ.RecordCount > 0 then
                  begin
                       if trim(aq.Fields[0].AsString)='Si' then
                         begin
                          DriverFiscal1.Printer:='TM2000';
                          puerto:= ReadString(PortNumber_);
                          velo:= strtoint(ReadString(BaudRate_));
                          result:=true;
                         end else
                          begin
                           result:=false;
                          end;

                  end else begin
                  result:=false;
                  end;



            finally
                aQ.Free;
            end;






          end;


finally
free;
end;
//---------------fin


end;



constructor TFrmFactura.CreateFromFactura (aFact: TFacturacion; const bVisualizar: boolean; aContexto: pTContexto);
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

constructor TFrmFactura.CreateFromNCredito (aNCredito: TContraFacturas; const bVisualizar: boolean; aContexto: pTContexto);
begin
    inherited Create (Application);

    aFactura := aNCredito.fMasterFactura;
    Rellenar_Factura;

// imprime manual
if  not controlador_imprime_NC then
begin
    aFactura := aNCredito.fMasterFactura;
    Rellenar_Factura;

    // En una nota de crédito cambian el título y número de factura
    QRLblTitulo.Caption := aNCredito.TituloFactura;
    //QRLblNumero.Caption := aNCredito.DevolverNumeroFactura;



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
    end;

end  else
begin
// imprime por controlador fiscal

 imprimir_NC_en_CF;

end;






end;

constructor TFrmFactura.CreateFromNCDescuento (aFact: TFacturacion; const bVisualizar: boolean; aContexto: pTContexto);
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
    end;

end;


procedure TfrmFactura.Rellenar_Factura;
begin
    Rellenar_CabeceraFactura(TIPO_FACTURA);
    Rellenar_Concepto;
    Rellenar_Totales;
end;

procedure TFrmFactura.Rellenar_NCDescuento(const aPausa:boolean);
begin
    Rellenar_CabeceraFactura(TIPO_NCD);
    Rellenar_Concepto_NCD(apausa);
    Rellenar_Totales;
end;

procedure TFrmFactura.Rellenar_Concepto;
var aQ: TSQLQuery;
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
                aQ.SQLConnection := MyBD;
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
//          aFactura.ffactadicionales:=nil;          
        end;
    end;
end;

procedure TFrmFactura.Rellenar_Concepto_NCD(const aPausa:boolean);
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


procedure TfrmFactura.Rellenar_CabeceraFactura(const aTipo: string);
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
        if atipo = TIPO_FACTURA then
          QRLblNumero.Caption := DevolverNumeroFactura(TIPO_FACTURA)
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

        if QRLblIVA.Caption = S_TIPO_TRIBUTACION[tttConsumidorFinal] then
          QRLey13987.Enabled:=True
        else
          QRLey13987.Enabled:=false;


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
           if aTipo = TIPO_FACTURA then
             sTarjeta := ': '+afactura.DevolverNroCheque;
        end
        else
           FormaPago_Auxi := tfpOficial;

        QRLblCondicionesVenta.Caption := S_FORMA_PAGO[FormaPago_Auxi]+sTarjeta;
    end;
end;

procedure TFrmFactura.Rellenar_Totales;
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


procedure TFrmFactura.Rellenar_Total_FacturaA;
begin
    with aFactura do
    begin
        QRLblSubTotal.Caption := floattostrf(strtofloat(ValueByName[FIELD_IMPONETO]),ffnumber,10,2);   
        QRLblIVAInscr.Caption := Format ('%1.2f',[IvaInscriptoFactura]);
        QRLblIVANoIns.Caption := Format ('%1.2f',[IVANoInscriptoFactura]);
        QRLblTotalA.Caption := Format ('%1.2f',[Monto]);
    end;
end;


procedure TFrmFactura.Rellenar_Total_FacturaB;
begin
    with aFactura do
    begin
      QRLblTotalB.Caption := Format ('%1.2f',[Monto]);
    end;
end;



procedure TFrmFactura.Rellenar_DatosCliente;
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


procedure TfrmFactura.QRFacturaNeedData(Sender: TObject;
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

function TFrmFactura.GetImprimirFactura: boolean;
begin
    Result := fImprimirFactura;
end;

procedure TFrmFactura.SetImprimirFactura (const bImprimir: boolean);
begin
    fImprimirFactura := bImprimir;
end;


procedure TfrmFactura.QRFacturaAfterPrint(Sender: TObject);
begin
    ImprimirFactura := True;
end;

procedure TfrmFactura.ActivarDesactivar_Componentes (const bActivar: boolean);
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


function TFrmFactura.Devolver_patente_Vehiculo_NC: string;
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
                SQLConnection := MyBD;

{ TODO -oran -ctransacciones : Ver tema sesion }

                SQL.Add (Format( ' SELECT NVL(PATENTEN, PATENTEA) ' +
                                 ' FROM   '+
                                 ' 	TINSPECCION I, TVARIOS V, TFACTURAS F, TVEHICULOS V, TTIPOSCLIENTE C    '+
                                 ' WHERE     '+
                                 ' 	F.CODFACTU = %S AND    '+
                                 ' 	I.CODFACTU = F.CODFACTU AND   '+
                                 ' 	I.CODVEHIC = V.CODVEHIC AND     '+
                                 '  C.TIPOCLIENTE_ID = F.TIPOCLIENTE_ID     '
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

 function TFrmFactura.Devolver_numero_inspeccion_Vehiculo: string;
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
                SQLConnection := MyBD;

{ TODO -oran -ctransacciones : Ver tema sesion }

                SQL.Add (Format( ' SELECT '+
                                 ' MOD(I.EJERCICI,100) || '' '' || LTRIM(TO_CHAR(V.ZONA,''0000'')) || LTRIM(TO_CHAR(V.ESTACION,''0000'')) || DECODE(I.CODINSPE,-1,''XXXXXX'',LTRIM(TO_CHAR(I.CODINSPE,''000000''))) || DECODE(I.TIPO,''I'','' R'',''E'', '' R'', '''') || ' +
                                 ' FROM   '+
                                 ' 	TINSPECCION I, TVARIOS V, TFACTURAS F, TVEHICULOS V, TTIPOSCLIENTE C  '+
                                 ' WHERE    '+
                                 ' 	F.CODFACTU = %S AND  '+
                                 ' 	I.CODFACTU = F.CODFACTU AND '+
                                 ' 	I.CODVEHIC = V.CODVEHIC AND  '+
                                 '  C.TIPOCLIENTE_ID = F.TIPOCLIENTE_ID '
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


function TFrmFactura.Devolver_Descripcion_Vehiculo: string;
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
                SQLConnection := MyBD;

{ TODO -oran -ctransacciones : Ver tema sesion }

                SQL.Add (Format( ' SELECT ''Revisión Técnica Vehicular nº "'' ||                                                                                                                                                      ' + #10 + #13 +
                                 ' MOD(I.EJERCICI,100) || '' '' || LTRIM(TO_CHAR(V.ZONA,''0000'')) || LTRIM(TO_CHAR(V.ESTACION,''0000'')) || DECODE(I.CODINSPE,-1,''XXXXXX'',LTRIM(TO_CHAR(I.CODINSPE,''000000''))) || DECODE(I.TIPO,''I'','' R'',''E'', '' R'', '''') || ' + #10 + #13 +
                                 ' ''" del vehículo patente "'' || NVL(PATENTEN, PATENTEA) || ''"''                                                                                                                                      ' + #10 + #13 +
                                 ' || DECODE (V.OFICIAL,''S'',''. Vehículo Oficial'','''') || ''. ''                                                                                                                                     ' + #10 + #13 +
                                 ' FROM                                                                                                                                                                                                 ' + #10 + #13 +
                                 ' 	TINSPECCION I, TVARIOS V, TFACTURAS F, TVEHICULOS V, TTIPOSCLIENTE C                                                                                                                                ' + #10 + #13 +
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

function TFrmFactura.Devolver_Descripcion_NCD(const aPausa:boolean): string;
var
    aQ : TsqlQuery;
begin
    Try
        if aPausa then sleep(3000);
        aQ := TsqlQuery.Create(self);
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


procedure TfrmFactura.QRFacturaAfterPreview(Sender: TObject);
begin
    ImprimirFactura := (frmPresPreliminar_Auxi.ModalResult = mrOk);
end;

procedure TfrmFactura.QRFacturaPreview(Sender: TObject);
begin
   frmPresPreliminar_Auxi := TfrmPresPreliminar.Create (Application);
   frmPresPreliminar_Auxi.QRPrevPresPrel.QRPrinter := TQRPrinter (Sender);
   frmPresPreliminar_Auxi.Show;
end;

function TfrmFactura.Devolver_Descripcion_Descuento:string;
var fdescuento: tdescuento;
begin
  result := '';
  if aFactura.ffactadicionales.ValueByName[FIELD_CODDESCU] <> '' then
  begin
    fdescuento:=nil;
    fdescuento:=tdescuento.CreateFromCoddescu(afactura.DataBase,afactura.ffactadicionales.valuebyname[FIELD_CODDESCU]);
    try
      fdescuento.open;
      if fdescuento.ValueByName[FIELD_EMITENC] = 'N' then
        result := fDescuento.ValueByName[FIELD_DESCRIPCION];
      fdescuento.close;
    finally
      fdescuento.free;
    end;
  end;
end;


procedure TfrmFactura.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if assigned (aFactura) then
    aFactura.close;
end;

procedure TfrmFactura.QRFacturaBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
    bFacturaRellena := False;
end;

end.
