unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, msxmldom, XMLDoc, StdCtrls, oxmldom,  ComObj, MSXML,xml_caba,
  InvokeRegistry, Rio,WSFEV1, SQLEXPR,SOAPHTTPClient, ToolWin, ComCtrls, DateUtils,
  Buttons, ExtCtrls, TlHelp32,   base64pdf,wcrypt2,  base64_new,
  Exportar2PDF, IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient,
  OleServer, ExcelXP,   {epagos,}
  Menus, DB, DBClient ,DBXpress, IdSMTP, IdMessage;



type
  TForm1 = class(TForm)
    Button5: TButton;
    Memo1: TMemo;
    Button8: TButton;
    Button11: TButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    TIMENOVEDAD: TTimer;
    OpenDialog1: TOpenDialog;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn10: TBitBtn;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    timepagos: TTimer;
    Button2: TButton;
    BitBtn13: TBitBtn;
    DateTimePicker1: TDateTimePicker;
    Timer1: TTimer;
    Label4: TLabel;
    Button1: TButton;
    Button3: TButton;
    Edit4: TEdit;
    Memo2: TMemo;
    Memo3: TMemo;
    DateTimePicker2: TDateTimePicker;
    Edit5: TEdit;
    BitBtn14: TBitBtn;
    Label5: TLabel;
    Edit6: TEdit;
    Label6: TLabel;
    Edit7: TEdit;
    Label7: TLabel;
    ComboBox1: TComboBox;
    Label8: TLabel;
    BitBtn15: TBitBtn;
    Timer2: TTimer;
    enviarmail: TTimer;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    Edit8: TEdit;
    BitBtn16: TBitBtn;
    Button4: TButton;
    Excel: TExcelApplication;
    Timer3: TTimer;
    Button7: TButton;
    Cliente: TIdUDPClient;
    Button6: TButton;
    BitBtn17: TBitBtn;
    BitBtn18: TBitBtn;
    BitBtn19: TBitBtn;
    HTTPRIO1: THTTPRIO;
    Button9: TButton;
    Button10: TButton;
    BitBtn21: TBitBtn;
    DateTimePicker3: TDateTimePicker;
    BitBtn22: TBitBtn;
    BitBtn9: TBitBtn;
    OpenDialog2: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure TIMENOVEDADTimer(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure timepagosTimer(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure BitBtn15Click(Sender: TObject);
    procedure enviarmailTimer(Sender: TObject);
    procedure BitBtn16Click(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure BitBtn17Click(Sender: TObject);
    procedure BitBtn18Click(Sender: TObject);
    procedure BitBtn19Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtn21Click(Sender: TObject);
    procedure BitBtn22Click(Sender: TObject);
  private
    { Private declarations }
    ARCHIVO_PARA_BASE64:STRING;

  public
    { Public declarations }
    ES_SERVIDOR:BOOLEAN;  total_envio:longint;
    CONEXION_OK:BOOLEAN;   tx:txml_caba;
    relacion:string;  FA:tfacturae;  ERROR_MAIL:STRING;
     TIENE_CONEXION_ELECTRONICA:BOOLEAN;
    function servicio_reenvio_factura_suvtv:boolean;
    FUNCTION EnviarMensaje_ERROR_base(destino,PLANTA:STRING):BOOLEAN;
    FUNCTION GENERA_TODOS_PDF_FALTANTE:BOOLEAN;
    PROCEDURE SERVICIO_FACTURA_ELECTRONICA;
    FUNCTION PROCEDIMIENTOS_XML_PAGOS_INDIVIDUAL_por_fecha(desde,hasta:string):BOOLEAN;
    PROCEDURE PROCEDIMIENTO_CONTROL_DE_PAGOS;
    FUNCTION INFORMAR_INSPECCION_DEL_DIA:BOOLEAN;
    FUNCTION EnviarMensaje_TRAZAS(destino,ARCHIVO,PLANTA:STRING):BOOLEAN;
    function StopProcess(ExeFileName: string) : Integer;
    function PROCEDIMIENTOS_XML_PAGOS_FLOTA:BOOLEAN;
    function PROCEDIMIENTOS_XML_PAGOS_INDIVIDUAL:BOOLEAN;
     FUNCTION INFORMAR_TURNO_COMO_AUSENTE(IDT:LONGINT;TABLA:STRING):BOOLEAN;
     FUNCTION PROCEDIMIENTOS_XML_PAGOS_INDIVIDUAL_1830:BOOLEAN;
     FUNCTION EnviarMensaje_ERROR(destino,PAGOID,ARCHIVO,PLANTA:STRING):BOOLEAN;
    function renviar_mail_facturas:boolean;
    procedure DomToTree (XmlNode: IXMLNode);
    FUNCTION INFORMAR_INSPECCION_COMO_AUCENTES_TODOSL_hisotrial:BOOLEAN;
    Function Genera_NOTA_CREDITO_SAG_v2(IDDETALLE,idpago:longint;facturado:string;numero,punto_venta:longint;cae,fev:string):boolean;
    procedure DESCARGAR_XML_PAGOS;
    procedure Arregla_codcliente_cero;
    procedure Arregla_codcliente_cero_fechaturno;
    function es_linea(cadena:string):string ;
    function extrae_valor(cadena:string):string;
    FUNCTION INICIAR_NOVEDAD:BOOLEAN;
    FUNCTION INICIAR_NOVEDAD_1833:BOOLEAN;
    FUNCTION INFORMAR_LOS_TODOS_AUCENTES:BOOLEAN;
    FUNCTION INICIAR_DESCARGA_DIA:BOOLEAN;
    procedure BorrarArchivos(Ruta: string);
    FUNCTION INICIAR_NOVEDAD_20minutos:BOOLEAN;
     function baja_pagos_faltantes:boolean;
    FUNCTION ACTUALIZA_TURNO_DEL_DIA:BOOLEAN;
     
FUNCTION INICIAR_DESCARGA_DIA_fecha(fecha:string):BOOLEAN;
   FUNCTION INFORMAR_INSPECCION_COMO_AUCENTES_TODOSL(fechaturno:STRING):BOOLEAN;
FUNCTION INFORMAR_INSPECCION_SIN_INFORMAR_HISTORIAL(fechaturno:STRING):BOOLEAN;
    FUNCTION INFORMAR_INSPECCION_SIN_INFORMAR(fechaturno:STRING):BOOLEAN;
    function Factura_Electronica:boolean;
    FUNCTION GENERAR_FACTURAS_ELECTRONICAS:BOOLEAN;
//  function  INFORMAR_TURNO_COMO_AUSENTE_hoistorial :boolean;
    FUNCTION GENERAR_FACTURAS_ELECTRONICAS_PAGOS_SUVTV(planta,iddetallespagoPARAMETRO:longint):BOOLEAN;
    function exiete_en_tfactura(turnoid,pagoidverificacion:longint):boolean;
    function exiete_idpago_en_tfactura(pagoidverificacion:longint):boolean;
    FUNCTION ARMAR_NUMERO_FACTURA(NRO_FACT:STRING):STRING;
    Function Genera_Fact_SAG(IDDETALLE:longint;facturado:string):boolean;
    FUNCTION EnviarMensaje(sDestino,NRO_COMPROBANTE,ARCHIVO,nombre,patente:STRING):BOOLEAN;
    FUNCTION DIGITO_VERIFICADOR_FACTURA(CODIGO_BARRA:STRING):STRING;
    function generar_pdf(nro_comprobante,cae,fechavence,gravado,iva21,total,TIPOCOMPROBANTE,PV:string;idturno:longint;letra,
                         patente_para_factura,NOMBRE_CLIENTE,TTIPODOCU,nro_doc:string;codclientefacturacion:LONGINT;MODO:STRING;iddetallespago:longint;fecha_comprobante:string):STRING;

  function controla_servicio_prestado(iddetallespago, pagoid:longint):boolean;
 FUNCTION EnviarMensaje_control(sDestino,hora,asunto,mensajea,sAdjunto,NPLANTA:STRING):BOOLEAN;
FUNCTION INFORMAR_LOS_AUSENTES_DEL_DIA:BOOLEAN;
 function control_nc_flota(planta,iddetallespagoPARAMETRO:longint):boolean;
function INFORMAR_FACTURA(externalReference,numeroFactura,tipoComprobante,Dominio,importeTotal,importeNeto,
importeIVA,cae,vencimientoCae,tipoFactura,fechaFactura,comprobantehash,smd5 :string):boolean;

    function generar_pdf_B(nro_comprobante,cae,fechavence,gravado,iva21,total,TIPOCOMPROBANTE,PV:string;idturno:longint;letra,
             patente_para_factura,NOMBRE_CLIENTE,TTIPODOCU,nro_doc:string;codclientefacturacion:LONGINT;MODO:STRING;iddetallespago:longint;fecha_comprobante:string):STRING;
      function exiete_idpago_en_tfactura_PARANC(pagoidverificacion:longint):boolean;
    function GENERA_COMPROBANTES_ELECTRONICOS_AFIP(PLANTA:LONGINT):BOOLEAN;
    function generar_pdf_viejo(idturno:longint):STRING;
    function veririca_si_es_una_reve(iddetallepago:longint):boolean;
    FUNCTION TURNOS_SIN_FACTURAR_DEL_DIA:BOOLEAN;
    function Factura_Electronica_POR_TURNO(IDTURNO:LONGINT):boolean;
    FUNCTION GENERAR_FACTURAS_ELECTRONICAS_IDTURNOS(IDTURNO:LONGINT):BOOLEAN;
    FUNCTION TURNOS_SIN_FACTURAR_todos:BOOLEAN;
    FUNCTION CONTROLES:BOOLEAN;
    function ES_RELACIONADO_PADRE(IDDETURNO:longint):boolean;
    function ES_RELACIONADO_HIJO(IDDETURNO:longint):boolean;
    function ES_PAGOID_RELACIONADO(IDPAGORELA:longint):boolean;
    function Factura_Electronica_pagos_suvtv(planta:longint):boolean;
    Function Genera_Fact_SAG_v2(IDDETALLE:longint;facturado:string):boolean;
    FUNCTION GENERAR_NOTACREDRITOS_ELECTRONICAS_PAGOS_SUVTV(planta,iddetallespagoPARAMETRO:longint):BOOLEAN;
    function pagos_sin_bajar_segun_turnos_descargados:boolEAN;
    procedure obtener_feriados;
    procedure generar_domingos;
   procedure COPIAR_HISTORIAL_TURNOS;

   procedure COPIAR_HISTORIAL_TMPDATODEFECIM;
   procedure BORRAR_TURNOS_SYSDATE_30;
function PROCEDIMIENTOS_XML_PAGOS_FLOTA_POR_FECHA(DESDE,HASTA:STRING):BOOLEAN;
procedure reenvio_de_mail_sin_enviar;
FUNCTION GENERA_PDF_FALTANTE(nro,tipo:sTRING):BOOLEAN;
procedure arregla_exentos_sin_idpago;
procedure procesar_idpago_bajar(pagoidd:longint);
 procedure arregla_cliente_cero_con_pagos  ;
 procedure arregla_cliente_cero_con_pagos_fechaturno  ;
procedure serivicio_de_reinformar_facturas_a_suvtv;
procedure ARREGLA_TURNOS_CLIENTES_CEROS;
procedure ARREGLA_TURNOS_CLIENTES_CEROS_fecharegistro;
function envia_error_a_reconquista(coderror,mensaje:string):boolean;
procedure PONE_FACUTURDO_EL_TURNO;

FUNCTION PROCEDIMIENTOS_XML_PAGOS_flota_1830:BOOLEAN;
  end;

var
  Form1: TForm1;

implementation

uses Unitfrmdiseniofactelectronica, UdiseniofacturaBelectronica;

{$R *.dfm}
function TForm1.envia_error_a_reconquista(coderror,mensaje:string):boolean;
var cadena:string;
begin
cadena:=trim(coderror)+'|'+trim(mensaje);
 Cliente.Host := '10.100.10.128';
 Cliente.Port := StrToIntDef( '80', 0 );
 Cliente.Send(cadena);

end;


function TForm1.servicio_reenvio_factura_suvtv:boolean;
var  aqQm:tsqlquery;   tc,Texto_encode,texto_md5,informada_fact,IMP_NETO,c:String;  tipo_cbte,iddetallespago:longint;   Stream:TMemoryStream;
TDNRO_COMPROBANTE,TDPAGOID,TDTIPOCOMPROBANTEAFIP,TDCAE,TDFECHAVENCEFACTURA,TDARCHIVOENVIADO ,TDIMPORTE,TFIMPONETO,TFIVAINSCR:string;
aqQ:tsqlquery;      posi:longint;     ii:longint;
 begin
 ii:=0;
     aqQm:=tsqlquery.create(nil);
     aqQm.SQLConnection := MyBD;
     aqQm.CLOSE;
     aqQm.SQL.CLEAR;
     aqQm.sql.add('select  TD.NRO_COMPROBANTE,TD.PAGOID,TD.TIPOCOMPROBANTEAFIP,TD.CAE,TD.FECHAVENCEFACTURA ,TD.IMPORTE,TF.IMPONETO, '+
                 ' TF.IVAINSCR,TD.ARCHIVOENVIADO , TD.IDDETALLESPAGO '+
                  'from tdetallespago  td, tdatreserva tdr ,tfacturas tf  '+
                  'where (td.informada=''N'' or td.informada is null or td.informada=''X'')  '+
                  'and TD.TIPOBOLETA=''I'' and archivoenviado is not null and td.cae is not null '+
                  'and TD.IDDETALLESPAGO=TDR.IDDETALLESPAGO and td.iddetallespago >20000 '+
                  'and (TDR.ESREVE=''N'' and TDR.ESREVEDIA=''N'')  '+
                 'and TD.PAGOID=TF.IDPAGO and TD.FACTURADO=''S'' '+
                 'order by TD.IDDETALLESPAGO asc');
     aqQm.ExecSQL;
     aqQm.open;
     while not aqqm.Eof do
     begin
     ii:=ii +1;
           TDNRO_COMPROBANTE:=trim(aqqm.Fields[0].asstring);
           TDPAGOID:=trim(aqqm.Fields[1].asstring);
           TDTIPOCOMPROBANTEAFIP:=trim(aqqm.Fields[2].asstring);
           TDCAE:=trim(aqqm.Fields[3].asstring);
           TDFECHAVENCEFACTURA:=trim(aqqm.Fields[4].asstring);
           TDIMPORTE:=trim(aqqm.Fields[5].asstring);
           TFIMPONETO:=trim(aqqm.Fields[6].asstring);
           TFIVAINSCR:= trim(aqqm.Fields[7].asstring);
           TDARCHIVOENVIADO:=trim(aqqm.Fields[8].asstring);
           iddetallespago:=aqqm.Fields[9].asinteger;

           if (trim(TDTIPOCOMPROBANTEAFIP)='FB') then
                 tc:='FC';

           if (trim(TDTIPOCOMPROBANTEAFIP)='FA') then
                  tc:='FC';

           if (trim(TDTIPOCOMPROBANTEAFIP)='CB') then
                 tc:='NC';

           if (trim(TDTIPOCOMPROBANTEAFIP)='CA') then
                  tc:='NC';


          if (trim(TDTIPOCOMPROBANTEAFIP)='FB') then
                 tipo_cbte:=6;

           if (trim(TDTIPOCOMPROBANTEAFIP)='FA') then
                  tipo_cbte:=1;

           if (trim(TDTIPOCOMPROBANTEAFIP)='CB') then
                 tipo_cbte:=8;

           if (trim(TDTIPOCOMPROBANTEAFIP)='CA') then
                  tipo_cbte:=3;


             posi:=pos('.',TDIMPORTE) ;
             if posi > 0 then
             begin
              TDIMPORTE  :=copy(TDIMPORTE,0,posi-1);
             end;

             posi:=pos(',',TDIMPORTE) ;
             if posi > 0 then
             begin
              TDIMPORTE  :=copy(TDIMPORTE,0,posi-1);
             end;

             if TFIVAINSCR='21' then
                TFIVAINSCR:='1,21';


          IMP_NETO:=floattostr(strtofloat(TDIMPORTE)/strtofloat(TFIVAINSCR));
          // IMP_NETO:=floattostr(TDIMPORTE/1.21);
         try
             Stream:= TMemoryStream.Create;
             try
               Stream.LoadFromFile(TDARCHIVOENVIADO);
               Texto_encode:= base64_new.BinToStr(Stream.Memory,Stream.Size);
               texto_md5:=base64_new.md5_suvtv(TDARCHIVOENVIADO);
                  if  INFORMAR_FACTURA(TDPAGOID,
                                       TDNRO_COMPROBANTE,
                                       inttostr(tipo_cbte),
                                        '',
                                      TDIMPORTE,
                                      IMP_NETO,
                                      TFIVAINSCR,
                                      TDCAE,
                                      TDFECHAVENCEFACTURA,
                                      tc,
                                      datetostr(date),
                                      Texto_encode,texto_md5)=true then

                      informada_fact:='S'
                      ELSE
                         informada_fact:='N';


                if strtoint(trim(tx.ver_respuestaid_factura_informar_factura))=1 then
                    informada_fact:='S'
                    else
                    informada_fact:='N';

                  IF informada_fact='S' THEN
                   MEMO1.Lines.Add(inttostr(ii)+'  INFORMA FACT: SI . '+TRIM(TX.ver_respuestamensaje_factura_informar_factura))
                   ELSE
                   MEMO1.Lines.Add(inttostr(ii)+'  INFORMA FACT: NO . '+TRIM(TX.ver_respuestamensaje_factura_informar_factura));

                  APPLICATION.ProcessMessages;

                 MyBD.StartTransaction(TD);
                 TRY
                  aqQ:=tsqlquery.create(nil);
                  aqQ.SQLConnection := MyBD;
                  aqQ.CLOSE;
                  aqQ.SQL.CLEAR;
                  aqQ.sql.add('UPDATE tdetallespago SET  INFORMADA='+#39+TRIM(informada_fact)+#39+', FECHAINFORMA=SYSDATE, RESPUESTAINFORMAR='+#39+TRIM(TX.ver_respuestamensaje_factura_informar_factura)+#39+'   WHERE iddetallespago='+INTTOSTR(iddetallespago));
                  AQQ.ExecSQL;


                  MYBD.Commit(TD);

                  EXCEPT
                    MyBD.Rollback(TD);

                  END ;

                AQQ.close;
                AQQ.free;






          finally
            Stream.Free;
          end;

     except
       on E : Exception do
         BEGIN
         form1.EnviarMensaje_ERROR('martin.bien@applus.com','ERROR AL GENERAR PDF BASE64. iddetallespago='+INTTOSTR(iddetallespago)+'. ERROR: '+E.Message,'',inttostr(tx.ver_PLANTA));

         END;
    end;
         c:=ExtractFilePath(Application.ExeName);
         BorrarArchivos(c);
         aqqm.Next;
     end;

     aqqm.close;
     aqqm.Free;

     c:=ExtractFilePath(Application.ExeName);
         BorrarArchivos(c);
 end;
function TForm1.generar_pdf_B(nro_comprobante,cae,fechavence,gravado,iva21,total,TIPOCOMPROBANTE,PV:string;idturno:longint;
letra,patente_para_factura,NOMBRE_CLIENTE,TTIPODOCU,nro_doc:string;codclientefacturacion:LONGINT;MODO:STRING;iddetallespago:longint;fecha_comprobante:string):STRING;
var posi,I:longint;  directorio,fechadir,directoriosave:String;
dd,mm,aaaa,nombre_archivo,tc:string;      LINEA:STRING;
CODIGO_BARRA,DIGITO,CUIT,nombre_archivo_original:STRING;
aqQm:tsqlquery;  cantidad,item:longint;  unitario:real;
 VAR Gpdf:TExportar2PDFSyn;
begin
  facturabelectronica:=Tfacturabelectronica.Create(SELF);
  aqQm:=tsqlquery.create(nil);
  aqQm.SQLConnection := MyBD;
  aqQm.CLOSE;
  aqQm.SQL.CLEAR;
  aqQm.sql.add('select dirconce from tvarios');
  aqQm.ExecSQL;
  aqQm.open;
  facturabelectronica.QRLabel22.Caption:=trim(aqqm.fieldbyname('dirconce').asstring);
  facturabelectronica.QRLabel23.Caption:='Ciudad de Buenos Aires';

  aqqm.Close;
  aqqm.Free;






facturabelectronica.RxMemoryData1.Close;
facturabelectronica.RxMemoryData1.Open;

 
 facturabelectronica.RxMemoryData1.Append;
facturabelectronica.RxMemoryData1servicio.Value:='VTV A VEHICULO: ';
facturabelectronica.RxMemoryData1cantidad.Value:='1.00';
  facturabelectronica.RxMemoryData1cantidad.Value:='1.00';
    if trim(letra)='A' then
       begin
       facturabelectronica.RxMemoryData1preciounit.Value:=trim(gravado);
       facturabelectronica.RxMemoryData1iva.Value:=trim(iva21);
       facturabelectronica.RxMemoryData1total.Value:=trim(total);
       end;

    if trim(letra)='B' then
      begin
       facturabelectronica.RxMemoryData1preciounit.Value:=trim(total);
       facturabelectronica.RxMemoryData1iva.Value:='';
       facturabelectronica.RxMemoryData1total.Value:=trim(total);
      end;

 facturabelectronica.RxMemoryData1.Post;

 { aqQm:=tsqlquery.create(nil);
  aqQm.SQLConnection := MyBD;
  aqQm.CLOSE;
  aqQm.SQL.CLEAR;
  aqQm.sql.add(' select TI.DOMINIO from tinformacionpago ti, tdatreserva td   '+
               ' where  ti.iddetallespago=TD.IDDETALLESPAGO and trim(TI.DOMINIO)=trim(td.dominio) '+
               ' and TI.IDDETALLESPAGO='+INTTOSTR(iddetallespago)+
               ' and (TRIM(TD.ESREVE)=''N'' OR TRIM(TD.ESREVEDIA)=''N'')');
  aqQm.ExecSQL;
  aqQm.open;  }

    aqQm:=tsqlquery.create(nil);
  aqQm.SQLConnection := MyBD;
  aqQm.CLOSE;
  aqQm.SQL.CLEAR;
  aqQm.sql.add(' select TI.DOMINIO from tinformacionpago ti  '+
               ' where  TI.IDDETALLESPAGO='+INTTOSTR(iddetallespago));
  aqQm.ExecSQL;
  aqQm.open;


  item:=0;
  while not aqqm.Eof do
  begin
  item:=item + 1;

   if item=9 then
   begin
        facturabelectronica.RxMemoryData1.Append;
        facturabelectronica.RxMemoryData1servicio.Value:=linea;
        facturabelectronica.RxMemoryData1cantidad.Value:='';
        facturabelectronica.RxMemoryData1preciounit.Value:='';
        facturabelectronica.RxMemoryData1iva.Value:='';
        facturabelectronica.RxMemoryData1total.Value:='';
        facturabelectronica.RxMemoryData1.Post;
       item:=1;
       linea:='';
   end;
  linea:=linea + TRIM(aqQm.Fields[0].ASSTRING)+',';


   aqQm.Next;
  end;
   aqQm.close;
   aqQm.Free;

  if trim(linea)<>'' then
  begin
       facturabelectronica.RxMemoryData1.Append;
        facturabelectronica.RxMemoryData1servicio.Value:=copy(linea,0,length(linea)-1);
        facturabelectronica.RxMemoryData1cantidad.Value:='';
        facturabelectronica.RxMemoryData1preciounit.Value:='';
        facturabelectronica.RxMemoryData1iva.Value:='';
        facturabelectronica.RxMemoryData1total.Value:='';
        facturabelectronica.RxMemoryData1.Post;
  end;



 {

  aqQm:=tsqlquery.create(nil);
  aqQm.SQLConnection := MyBD;
  aqQm.CLOSE;
  aqQm.SQL.CLEAR;
  aqQm.sql.add(' select TI.DOMINIO from tinformacionpago ti, tdatreserva td   '+
               ' where  ti.iddetallespago=TD.IDDETALLESPAGO and trim(TI.DOMINIO)=trim(td.dominio) '+
               ' and TI.IDDETALLESPAGO='+INTTOSTR(iddetallespago)+
               ' and (TRIM(TD.ESREVE)=''N'' OR TRIM(TD.ESREVEDIA)=''N'')');
  aqQm.ExecSQL;
  aqQm.open;
  item:=0;
  while not aqqm.Eof do
  begin
  item:=item + 1;

facturabelectronica.RxMemoryData1.Append;
facturabelectronica.RxMemoryData1servicio.Value:='VTV A VEHICULO '+TRIM(aqQm.Fields[0].ASSTRING);
facturabelectronica.RxMemoryData1cantidad.Value:='1.00';

 if item=1 then
  begin
    facturabelectronica.RxMemoryData1cantidad.Value:='1.00';
    if trim(letra)='A' then
       begin
       facturabelectronica.RxMemoryData1preciounit.Value:=trim(gravado);
       facturabelectronica.RxMemoryData1iva.Value:=trim(iva21);
       facturabelectronica.RxMemoryData1total.Value:=trim(total);
       end;

    if trim(letra)='B' then
      begin
       facturabelectronica.RxMemoryData1preciounit.Value:=trim(total);
       facturabelectronica.RxMemoryData1iva.Value:='';
       facturabelectronica.RxMemoryData1total.Value:=trim(total);
      end;

 end else begin
       facturabelectronica.RxMemoryData1cantidad.Value:='';
       facturabelectronica.RxMemoryData1preciounit.Value:='';
       facturabelectronica.RxMemoryData1iva.Value:='';
       facturabelectronica.RxMemoryData1total.Value:='';

 end;

 facturabelectronica.RxMemoryData1.Post;


  aqQm.Next;

  end;
        }

 ////itemsn

 //ttoales;
  if trim(letra)='A' then
begin
facturabelectronica.QRLabel58.Caption:=gravado;
 //facturabelectronica.QRLabel68.Caption:=iva21;
 facturabelectronica.QRLabel74.Caption:=total;

end;



 if trim(letra)='B' then
begin
 facturabelectronica.QRLabel58.Caption:=total;
// facturabelectronica.QRLabel68.Caption:='0.00';
 facturabelectronica.QRLabel74.Caption:=total;

end;



  posi:=pos('-',trim(nro_comprobante));
 facturabelectronica.QRLabel7.Caption:=trim(copy(trim(nro_comprobante),0,posi-1));
 facturabelectronica.QRLabel8.Caption:=trim(copy(trim(nro_comprobante),posi+1,length(trim(nro_comprobante))));
 facturabelectronica.QRLabel10.Caption:=fecha_comprobante;
 facturabelectronica.QRLabel77.Caption:=cae;


 facturabelectronica.QRLabel2.Caption:=letra;

 IF TIPOCOMPROBANTE='01' THEN  {FACT ELECT TIPO A}
 BEGIN
   facturabelectronica.QRLabel3.Caption:='COD. 01';
     facturabelectronica.QRLabel4.Caption:='FACTURA';
     tc:='Fact';
 END;

  IF TIPOCOMPROBANTE='06' THEN  {FACT ELECT TIPO B}
  BEGIN
  facturabelectronica.QRLabel3.Caption:='COD. 06';
  facturabelectronica.QRLabel4.Caption:='FACTURA';
  tc:='Fact';
  END;



  IF TIPOCOMPROBANTE='03' THEN  {NC ELECT TIPO A}
  BEGIN
  facturabelectronica.QRLabel3.Caption:='COD. 03';
  facturabelectronica.QRLabel4.Caption:='NOTA DE CREDITO';
  tc:='NC';
  END;

  IF TIPOCOMPROBANTE='08' THEN  {NC ELECT TIPO B}
  BEGIN
  facturabelectronica.QRLabel3.Caption:='COD. 08';
  facturabelectronica.QRLabel4.Caption:='NOTA DE CREDITO';
  tc:='NC';
  END;

 dd:=copy(trim(fechavence),7,2);
 mm:=copy(trim(fechavence),5,2);
 aaaa:=copy(trim(fechavence),1,4);

 { aqQm:=tsqlquery.create(nil);
  aqQm.SQLConnection := MyBD;
  aqQm.CLOSE;
  aqQm.SQL.CLEAR;
  aqQm.sql.add('select facturarazonsocial,cuitfactura,dfiva,dfnombre,dfapellido,dfnrodocumento,'+
               ' dftipodocumento,dfcalle, dfnumerocalle,dfpiso,DFDEPARTAMENTO,DFLOCALIDAD,DFPROVINCIA from tdatosturno WHERE TURNOID='+INTTOSTR(idturno));
  aqQm.ExecSQL;
  aqQm.open;

     IF TRIM(aqQm.FIELDBYNAME('facturarazonsocial').AsString)<>'' THEN
       facturabelectronica.QRLabel27.Caption:=TRIM(aqQm.FIELDBYNAME('facturarazonsocial').AsString)
       ELSE
         facturabelectronica.QRLabel27.Caption:=TRIM(aqQm.FIELDBYNAME('dfapellido').AsString)+' '+TRIM(aqQm.FIELDBYNAME('dfnombre').AsString);

  }


  facturabelectronica.QRLabel27.Caption:=TRIM(NOMBRE_CLIENTE);


  IF TRIM(TTIPODOCU)='1' THEN
  BEGIN
    facturabelectronica.QRLabel24.Caption:='DNI: ';
    facturabelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;

   IF TRIM(TTIPODOCU)='2' THEN
  BEGIN
    facturabelectronica.QRLabel24.Caption:='LE: ';
    facturabelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;

     IF TRIM(TTIPODOCU)='3' THEN
  BEGIN
    facturabelectronica.QRLabel24.Caption:='LC: ';
    facturabelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;

       IF TRIM(TTIPODOCU)='4' THEN
  BEGIN
    facturabelectronica.QRLabel24.Caption:='DNI EX.: ';
    facturabelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;

       IF TRIM(TTIPODOCU)='5' THEN
  BEGIN
    facturabelectronica.QRLabel24.Caption:='CED.EX.: ';
    facturabelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;

         IF TRIM(TTIPODOCU)='6' THEN
  BEGIN
    facturabelectronica.QRLabel24.Caption:='PASAP.: ';
    facturabelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;

          IF TRIM(TTIPODOCU)='7' THEN
  BEGIN
    facturabelectronica.QRLabel24.Caption:='';
    facturabelectronica.QRLabel26.Caption:='';

  END;


            IF TRIM(TTIPODOCU)='8' THEN
  BEGIN
    facturabelectronica.QRLabel24.Caption:='CED';
    facturabelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;


   IF TRIM(TTIPODOCU)='9' THEN
  BEGIN
    facturabelectronica.QRLabel24.Caption:='C.U.I.T.:';
    facturabelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;

           IF TRIM(TTIPODOCU)='10' THEN
  BEGIN
    facturabelectronica.QRLabel24.Caption:='CERT.NAC';
    facturabelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;
           IF TRIM(TTIPODOCU)='11' THEN
  BEGIN
    facturabelectronica.QRLabel24.Caption:='CERT';
    facturabelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;
           IF TRIM(TTIPODOCU)='12' THEN
  BEGIN
    facturabelectronica.QRLabel24.Caption:='CED.CIU';
    facturabelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;



   facturabelectronica.QRLabel38.Caption:='';





       aqQm:=tsqlquery.create(nil);
       aqQm.SQLConnection := MyBD;
       aqQm.sql.add('select  CONDICIONIVA '+
                                    '   from TDETALLESPAGO where IDDETALLESPAGO='+INTTOSTR(iddetallespago));
       aqQm.ExecSQL;
       aqQm.open;




   IF TRIM(aqQm.FIELDBYNAME('CONDICIONIVA').AsString)='C' THEN
   begin
    facturabelectronica.QRLabel29.Caption:='Consumidor Final';
    facturabelectronica.QRLabel38.Caption:='"147 - TEL�FONO GRATUITO CABA, AREA DE DEFENSA Y PROTECCI�N AL CONSUMIDOR"';

    end;

    IF TRIM(AQQm.FIELDBYNAME('CONDICIONIVA').AsString)='R' THEN
    facturabelectronica.QRLabel29.Caption:='-';

      IF TRIM(AQQm.FIELDBYNAME('CONDICIONIVA').AsString)='I' THEN
    facturabelectronica.QRLabel29.Caption:='-';

    IF TRIM(AQQm.FIELDBYNAME('CONDICIONIVA').AsString)='M' THEN
    facturabelectronica.QRLabel29.Caption:='Monotributo';

    IF TRIM(AQQm.FIELDBYNAME('CONDICIONIVA').AsString)='E' THEN
    facturabelectronica.QRLabel29.Caption:='Exento';


      aqQm.Close;
      aqQm.Free;



        aqQm:=tsqlquery.create(nil);
       aqQm.SQLConnection := MyBD;
       aqQm.sql.add('select  tiptribu, LOCALIDA,DIRECCIO,NROCALLE'+
                                    '   from tclientes where codclien ='+inttostr(codclientefacturacion));
       aqQm.ExecSQL;
       aqQm.open;

   facturabelectronica.QRLabel31.Caption:=TRIM(aqQm.FIELDBYNAME('DIRECCIO').AsString)+
   ' '+TRIM(aqQm.FIELDBYNAME('NROCALLE').AsString)+
   ' - '+TRIM(aqQm.FIELDBYNAME('LOCALIDA').AsString);



   aqQm.Close;
   aqQm.Free;

  facturabelectronica.QRLabel33.Caption:='Contado';
 facturabelectronica.QRLabel78.Caption:=dd+'/'+mm+'/'+aaaa;


 {CODIGO BARRA}
 CUIT:='30714930490';

 FECHAVENCE:=stringreplace(FECHAVENCE, '/', '',
                          [rfReplaceAll, rfIgnoreCase]);

 CODIGO_BARRA:=CUIT+TIPOCOMPROBANTE+'000'+PV+CAE+FECHAVENCE+DIGITO;
 facturabelectronica.Barcode1D_Code1281.Barcode:=CODIGO_BARRA;


  facturabelectronica.QRLabel79.Caption:=CODIGO_BARRA+DIGITO_VERIFICADOR_FACTURA(CODIGO_BARRA);

 {FIN}

 {directorios}
 fechadir:=copy(datetostr(date),0,2)+copy(datetostr(date),4,2)+copy(datetostr(date),7,4);
   directorio:=fa.DIRFAE+'\'+fechadir;
     If not DirectoryExists(directorio) then
            CreateDir(directorio) ;


  If not DirectoryExists(ExtractFilePath(Application.ExeName)+'FACT_SUVTV') then
            CreateDir(ExtractFilePath(Application.ExeName)+'FACT_SUVTV') ;

 directoriosave:=directorio;
 {-------------}

 {original}

  IF TRIM(MODO)='H' THEN
  facturabelectronica.QRLabel1.Caption:='COMPROBANTE EN MODO TESTING. NO VALIDO COMO FACTURA ORIGINAL'
  ELSE
  facturabelectronica.QRLabel1.Caption:='ORIGINAL';


  nro_comprobante:=copy(nro_comprobante,1,4)+copy(nro_comprobante,6,length(nro_comprobante));

  nombre_archivo:=tc+trim(letra)+''+TRIM(nro_comprobante)+'ORIGINAL.PDF';  //'_'+TRIM(patente_para_factura)+
  nombre_archivo_original:=nombre_archivo;
//  facturabelectronica.QuickRep1.Prepare;


  Gpdf:=TExportar2PDFSyn.create;
  //Gpdf.rutaPDF:=fa.DIRFAE+ '\'+nombre_archivo;
  Gpdf.rutaPDF:=directoriosave+ '\'+nombre_archivo;



  Gpdf.exportar2PDF(facturabelectronica.QuickRep1);
  Gpdf.Free;

   {fin original}

   {ARCHIVO PARA SUVTV}

 // ARCHIVO_PARA_BASE64:=ExtractFilePath(Application.ExeName)+'FACT_SUVTV\'+nombre_archivo;
 // CopyFile(PChar(directoriosave+ '\'+nombre_archivo), PChar(ARCHIVO_PARA_BASE64), true);





   {duplicado}

  facturabelectronica.QRLabel1.Caption:='DUPLICADO';
  nombre_archivo:=tc+trim(letra)+''+TRIM(nro_comprobante)+'DUPLICADO.PDF';  //'_'+TRIM(patente_para_factura)+'

  //facturabelectronica.QuickRep1.Prepare;


  Gpdf:=TExportar2PDFSyn.create;
  //Gpdf.rutaPDF:='C:\APPLUS\DESARROLLO STARTEAM\EN DESARROLLOS\SISTEMA SAG VTV\VTVSAG CAPITAL FEDERAL\NUEVO TURNOS CABA\'+nombre_archivo;
 // Gpdf.rutaPDF:=fa.DIRFAE+ '\'+nombre_archivo;
  Gpdf.rutaPDF:=directoriosave+ '\'+nombre_archivo;
  Gpdf.exportar2PDF(facturabelectronica.QuickRep1);
  Gpdf.Free;

  {fin duplicado}

  facturabelectronica.QRLabel1.Caption:='TRIPLICADO';
  nombre_archivo:=tc+trim(letra)+''+TRIM(nro_comprobante)+'TRIPLICADO.PDF'; //'_'+TRIM(patente_para_factura)+

 // facturabelectronica.QuickRep1.Prepare;


  Gpdf:=TExportar2PDFSyn.create;

 Gpdf.rutaPDF:=directoriosave+ '\'+nombre_archivo;
  Gpdf.exportar2PDF(facturabelectronica.QuickRep1);
  Gpdf.Free;



 facturabelectronica.Free;

  generar_pdf_B:=directoriosave+'\'+nombre_archivo_original;

end;



FUNCTION TFORM1.DIGITO_VERIFICADOR_FACTURA(CODIGO_BARRA:STRING):STRING;


var s:string;    aux:longint;
i,sumapar,totalpar,x,sumaimpar,totalimpar,total,etapa2,etapa1,etapa3,etapa4:longint;
digito:LONGINT;
begin
s:=CODIGO_BARRA;
sumapar:=0;
sumaimpar:=0;

for i:=1 to length(s) do
begin
    if (i mod 2 = 0) then
        sumapar:=sumapar + strtoint(s[i])
       else
        sumaimpar:=sumaimpar + strtoint(s[i]);


end;

etapa1:=sumaimpar;

etapa2:= etapa1 * 3;


etapa3:=sumapar ;




etapa4:= etapa2 + etapa3;


aux:=etapa4 div 10;
aux:=aux * 10;
//digito:= 10 - (etapa4 - (etapa4 / 10) * 10);
aux:=etapa4 - aux;
digito:=10 -aux;
if digito =10 then
  digito := 0 ;


DIGITO_VERIFICADOR_FACTURA:=INTTOSTR(digito);


END;
                                                               




function TForm1.generar_pdf(nro_comprobante,cae,fechavence,gravado,iva21,total,TIPOCOMPROBANTE,PV:string;
idturno:longint;letra,patente_para_factura,NOMBRE_CLIENTE,TTIPODOCU,nro_doc:string;codclientefacturacion:LONGINT;MODO:STRING;iddetallespago:longint;fecha_comprobante:string):STRING;
var posi,I:longint;
dd,mm,aaaa,nombre_archivo,directoriosave:string;
CODIGO_BARRA,DIGITO,CUIT,nombre_archivo_original,TC:STRING;
aqQm:tsqlquery;      ITEM:LONGINT;   linea:string;
 VAR Gpdf:TExportar2PDFSyn;
 directorio,fechadir:string;
begin
  frmdiseniofactelectronica:=tfrmdiseniofactelectronica.Create(self);
  aqQm:=tsqlquery.create(nil);
  aqQm.SQLConnection := MyBD;
  aqQm.CLOSE;
  aqQm.SQL.CLEAR;
  aqQm.sql.add('select dirconce from tvarios');
  aqQm.ExecSQL;
  aqQm.open;
  frmdiseniofactelectronica.QRLabel22.Caption:=trim(aqqm.fieldbyname('dirconce').asstring);
  frmdiseniofactelectronica.QRLabel23.Caption:='Ciudad de Buenos Aires';

  aqqm.Close;
  aqqm.Free;








frmdiseniofactelectronica.RxMemoryData1.Close;
frmdiseniofactelectronica.RxMemoryData1.Open;

 frmdiseniofactelectronica.RxMemoryData1.Append;
frmdiseniofactelectronica.RxMemoryData1servicio.Value:='VTV A VEHICULO: ';
frmdiseniofactelectronica.RxMemoryData1cantidad.Value:='1.00';
  frmdiseniofactelectronica.RxMemoryData1cantidad.Value:='1.00';
    if trim(letra)='A' then
       begin
       frmdiseniofactelectronica.RxMemoryData1preciounit.Value:=trim(gravado);
       frmdiseniofactelectronica.RxMemoryData1iva.Value:=trim(iva21);
       frmdiseniofactelectronica.RxMemoryData1total.Value:=trim(total);
       end;

    if trim(letra)='B' then
      begin
       frmdiseniofactelectronica.RxMemoryData1preciounit.Value:=trim(total);
       frmdiseniofactelectronica.RxMemoryData1iva.Value:='';
       frmdiseniofactelectronica.RxMemoryData1total.Value:=trim(total);
      end;

 frmdiseniofactelectronica.RxMemoryData1.Post;

  aqQm:=tsqlquery.create(nil);
  aqQm.SQLConnection := MyBD;
  aqQm.CLOSE;
  aqQm.SQL.CLEAR;
  aqQm.sql.add(' select TI.DOMINIO from tinformacionpago ti '+
               ' where  TI.IDDETALLESPAGO='+INTTOSTR(iddetallespago));
  aqQm.ExecSQL;
  aqQm.open;
  item:=0;
  while not aqqm.Eof do
  begin
  item:=item + 1;

   if item=9 then
   begin
        frmdiseniofactelectronica.RxMemoryData1.Append;
        frmdiseniofactelectronica.RxMemoryData1servicio.Value:=linea;
        frmdiseniofactelectronica.RxMemoryData1cantidad.Value:='';
        frmdiseniofactelectronica.RxMemoryData1preciounit.Value:='';
        frmdiseniofactelectronica.RxMemoryData1iva.Value:='';
        frmdiseniofactelectronica.RxMemoryData1total.Value:='';
        frmdiseniofactelectronica.RxMemoryData1.Post;
       item:=1;
       linea:='';
   end;
  linea:=linea + TRIM(aqQm.Fields[0].ASSTRING)+',';


   aqQm.Next;
  end;

  aqQm.Close;
  aqQm.Free;

  if trim(linea)<>'' then
  begin
       frmdiseniofactelectronica.RxMemoryData1.Append;
        frmdiseniofactelectronica.RxMemoryData1servicio.Value:=copy(linea,0,length(linea)-1);
        frmdiseniofactelectronica.RxMemoryData1cantidad.Value:='';
        frmdiseniofactelectronica.RxMemoryData1preciounit.Value:='';
        frmdiseniofactelectronica.RxMemoryData1iva.Value:='';
        frmdiseniofactelectronica.RxMemoryData1total.Value:='';
        frmdiseniofactelectronica.RxMemoryData1.Post;
  end;
{
frmdiseniofactelectronica.RxMemoryData1.Append;
frmdiseniofactelectronica.RxMemoryData1servicio.Value:='VTV A VEHICULO '+TRIM(aqQm.Fields[0].ASSTRING);
frmdiseniofactelectronica.RxMemoryData1cantidad.Value:='1.00';
}
{if item=1 then
  begin
    frmdiseniofactelectronica.RxMemoryData1cantidad.Value:='1.00';
    if trim(letra)='A' then
       begin
       frmdiseniofactelectronica.RxMemoryData1preciounit.Value:=trim(gravado);
       frmdiseniofactelectronica.RxMemoryData1iva.Value:=trim(iva21);
       frmdiseniofactelectronica.RxMemoryData1total.Value:=trim(total);
       end;

    if trim(letra)='B' then
      begin
       frmdiseniofactelectronica.RxMemoryData1preciounit.Value:=trim(total);
       frmdiseniofactelectronica.RxMemoryData1iva.Value:='';
       frmdiseniofactelectronica.RxMemoryData1total.Value:=trim(total);
      end;

 end else begin
       frmdiseniofactelectronica.RxMemoryData1cantidad.Value:='';
       frmdiseniofactelectronica.RxMemoryData1preciounit.Value:='';
       frmdiseniofactelectronica.RxMemoryData1iva.Value:='';
       frmdiseniofactelectronica.RxMemoryData1total.Value:='';

 end;
      }
{ frmdiseniofactelectronica.RxMemoryData1.Post; }


 { aqQm.Next;
  end;   }







    //TOTALES
    frmdiseniofactelectronica.QRLabel58.Caption:=trim(gravado);
    frmdiseniofactelectronica.QRLabel68.Caption:=trim(iva21);
    frmdiseniofactelectronica.QRLabel74.Caption:=trim(total);

  IF TIPOCOMPROBANTE='01' THEN  {FACT ELECT TIPO A}
    BEGIN
     frmdiseniofactelectronica.QRLabel4.Caption:='FACTURA';

     frmdiseniofactelectronica.QRLabel3.Caption:='COD. 01';
       tc:='Fact';
  END;

  
  IF TIPOCOMPROBANTE='06' THEN
  BEGIN
   frmdiseniofactelectronica.QRLabel4.Caption:='FACTURA';

  frmdiseniofactelectronica.QRLabel3.Caption:='COD. 06';
   tc:='Fact';
  END;


    IF TIPOCOMPROBANTE='03' THEN  {NC ELECT TIPO A}
  BEGIN
   frmdiseniofactelectronica.QRLabel4.Caption:='NOTA DE CREDITO';

  frmdiseniofactelectronica.QRLabel3.Caption:='COD. 03';
   tc:='NC';
  END;

  
  IF TIPOCOMPROBANTE='08' THEN  {NC ELECT TIPO B}
  BEGIN
   frmdiseniofactelectronica.QRLabel4.Caption:='NOTA DE CREDITO';

  frmdiseniofactelectronica.QRLabel3.Caption:='COD. 08';
   tc:='NC';
  END;



  posi:=pos('-',trim(nro_comprobante));
 frmdiseniofactelectronica.QRLabel7.Caption:=trim(copy(trim(nro_comprobante),0,posi-1));
 frmdiseniofactelectronica.QRLabel8.Caption:=trim(copy(trim(nro_comprobante),posi+1,length(trim(nro_comprobante))));
 frmdiseniofactelectronica.QRLabel10.Caption:=fecha_comprobante;
 frmdiseniofactelectronica.QRLabel77.Caption:=cae;


 frmdiseniofactelectronica.QRLabel2.Caption:=letra;
 { if trim(letra)='A' then
 frmdiseniofactelectronica.QRLabel3.Caption:='COD. 01';

  if trim(letra)='B' then
  frmdiseniofactelectronica.QRLabel3.Caption:='COD. 06';
 }

 dd:=copy(trim(fechavence),7,2);
 mm:=copy(trim(fechavence),5,2);
 aaaa:=copy(trim(fechavence),1,4);

 { aqQm:=tsqlquery.create(nil);
  aqQm.SQLConnection := MyBD;
  aqQm.CLOSE;
  aqQm.SQL.CLEAR;
  aqQm.sql.add('select facturarazonsocial,cuitfactura,dfiva,dfnombre,dfapellido,dfnrodocumento,'+
               ' dftipodocumento,dfcalle, dfnumerocalle,dfpiso,DFDEPARTAMENTO,DFLOCALIDAD,DFPROVINCIA from tdatosturno WHERE TURNOID='+INTTOSTR(idturno));
  aqQm.ExecSQL;
  aqQm.open;

     IF TRIM(aqQm.FIELDBYNAME('facturarazonsocial').AsString)<>'' THEN
       frmdiseniofactelectronica.QRLabel27.Caption:=TRIM(aqQm.FIELDBYNAME('facturarazonsocial').AsString)
       ELSE
         frmdiseniofactelectronica.QRLabel27.Caption:=TRIM(aqQm.FIELDBYNAME('dfapellido').AsString)+' '+TRIM(aqQm.FIELDBYNAME('dfnombre').AsString);
        }

      frmdiseniofactelectronica.QRLabel27.Caption:=TRIM(NOMBRE_CLIENTE);




  IF TRIM(TTIPODOCU)='1' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='DNI: ';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;

   IF TRIM(TTIPODOCU)='2' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='LE: ';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;

     IF TRIM(TTIPODOCU)='3' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='LC: ';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;

       IF TRIM(TTIPODOCU)='4' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='DNI EX.: ';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;

       IF TRIM(TTIPODOCU)='5' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='CED.EX.: ';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;

         IF TRIM(TTIPODOCU)='6' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='PASAP.: ';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;

          IF TRIM(TTIPODOCU)='7' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='';
    frmdiseniofactelectronica.QRLabel26.Caption:='';

  END;


            IF TRIM(TTIPODOCU)='8' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='CED';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;


   IF TRIM(TTIPODOCU)='9' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='C.U.I.T.:';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;

           IF TRIM(TTIPODOCU)='10' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='CERT.NAC';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;
           IF TRIM(TTIPODOCU)='11' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='CERT';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;
           IF TRIM(TTIPODOCU)='12' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='CED.CIU';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(nro_doc);

  END;


     aqQm:=tsqlquery.create(nil);
       aqQm.SQLConnection := MyBD;
       aqQm.sql.add('select  CONDICIONIVA '+
                                    '   from TDETALLESPAGO where IDDETALLESPAGO='+INTTOSTR(iddetallespago));
       aqQm.ExecSQL;
       aqQm.open;

   IF TRIM(aqQm.FIELDBYNAME('CONDICIONIVA').AsString)='C' THEN
    frmdiseniofactelectronica.QRLabel29.Caption:='Consumidor Final';


    IF TRIM(AQQm.FIELDBYNAME('CONDICIONIVA').AsString)='R' THEN
    frmdiseniofactelectronica.QRLabel29.Caption:='Responsable Inscripto';
    
       IF TRIM(AQQm.FIELDBYNAME('CONDICIONIVA').AsString)='I' THEN
    frmdiseniofactelectronica.QRLabel29.Caption:='Responsable Inscripto';

    IF TRIM(AQQm.FIELDBYNAME('CONDICIONIVA').AsString)='M' THEN
    frmdiseniofactelectronica.QRLabel29.Caption:='Monotributo';

    IF TRIM(AQQm.FIELDBYNAME('CONDICIONIVA').AsString)='E' THEN
    frmdiseniofactelectronica.QRLabel29.Caption:='Exento';

       aqQm.Close;
       aqQm.Free;


      aqQm:=tsqlquery.create(nil);
       aqQm.SQLConnection := MyBD;
       aqQm.sql.add('select  tiptribu, LOCALIDA,DIRECCIO,NROCALLE'+
                                    '   from tclientes where codclien ='+inttostr(codclientefacturacion));
       aqQm.ExecSQL;
       aqQm.open;
       frmdiseniofactelectronica.QRLabel31.Caption:=TRIM(aqQm.FIELDBYNAME('DIRECCIO').AsString)+
   ' '+TRIM(aqQm.FIELDBYNAME('NROCALLE').AsString)+
   ' - '+TRIM(aqQm.FIELDBYNAME('LOCALIDA').AsString);



     aqQm.Close;
     aqQm.Free;

  frmdiseniofactelectronica.QRLabel33.Caption:='Contado';
 frmdiseniofactelectronica.QRLabel78.Caption:=dd+'/'+mm+'/'+aaaa;


 {CODIGO BARRA}
 CUIT:='30714930490';
  FECHAVENCE:=stringreplace(FECHAVENCE, '/', '',
                          [rfReplaceAll, rfIgnoreCase]);
                          

 CODIGO_BARRA:=CUIT+TIPOCOMPROBANTE+'000'+PV+CAE+FECHAVENCE+DIGITO;
 frmdiseniofactelectronica.Barcode1D_Code1281.Barcode:=CODIGO_BARRA;


  frmdiseniofactelectronica.QRLabel79.Caption:=CODIGO_BARRA+DIGITO_VERIFICADOR_FACTURA(CODIGO_BARRA);

 {FIN}
 {directorios}
 fechadir:=copy(datetostr(date),0,2)+copy(datetostr(date),4,2)+copy(datetostr(date),7,4);
   directorio:=fa.DIRFAE+'\'+fechadir;
     If not DirectoryExists(directorio) then
            CreateDir(directorio) ;



 If not DirectoryExists(ExtractFilePath(Application.ExeName)+'FACT_SUVTV') then
            CreateDir(ExtractFilePath(Application.ExeName)+'FACT_SUVTV') ;



 directoriosave:=directorio;
 {-------------}
 IF TRIM(MODO)='H' THEN
  frmdiseniofactelectronica.QRLabel1.Caption:='COMPROBANTE EN MODO TESTING. NO VALIDO COMO FACTURA ORIGINAL'
  ELSE
  frmdiseniofactelectronica.QRLabel1.Caption:='ORIGINAL';


  nro_comprobante:=copy(nro_comprobante,1,4)+ copy(nro_comprobante,6,length(nro_comprobante));
  nombre_archivo:=tc+trim(letra)+''+TRIM(nro_comprobante)+'ORIGINAL.PDF';  //'_'+TRIM(patente_para_factura)
  nombre_archivo_original:=nombre_archivo;
 // frmdiseniofactelectronica.QuickRep1.Prepare;


  Gpdf:=TExportar2PDFSyn.create;
 // Gpdf.rutaPDF:=fa.DIRFAE+ '\'+nombre_archivo;
  Gpdf.rutaPDF:=directoriosave+ '\'+nombre_archivo;
 // Gpdf.rutaPDF:=fa.DIRFAE+ '\'+nombre_archivo;
  Gpdf.exportar2PDF(frmdiseniofactelectronica.QuickRep1);
  Gpdf.Free;

  {ARCHIVO PARA SUVTV}
 //  ARCHIVO_PARA_BASE64:=ExtractFilePath(Application.ExeName)+'FACT_SUVTV\'+nombre_archivo;
 // CopyFile(PChar(directoriosave+ '\'+nombre_archivo), PChar(ARCHIVO_PARA_BASE64), true);

  {
    Gpdf:=TExportar2PDFSyn.create;
 // Gpdf.rutaPDF:=fa.DIRFAE+ '\'+nombre_archivo;

  Gpdf.rutaPDF:=ARCHIVO_PARA_BASE64;
 // Gpdf.rutaPDF:=fa.DIRFAE+ '\'+nombre_archivo;
  Gpdf.exportar2PDF(frmdiseniofactelectronica.QuickRep1);
  Gpdf.Free; }
  {FIN------------------}

  frmdiseniofactelectronica.QRLabel1.Caption:='DUPLICADO';
  nombre_archivo:=tc+trim(letra)+''+TRIM(nro_comprobante)+'DUPLICADO.PDF';   //+'_'+TRIM(patente_para_factura)+

 // frmdiseniofactelectronica.QuickRep1.Prepare;


  Gpdf:=TExportar2PDFSyn.create;
 // Gpdf.rutaPDF:=fa.DIRFAE+ '\'+nombre_archivo;
  Gpdf.rutaPDF:=directoriosave+ '\'+nombre_archivo;
  Gpdf.exportar2PDF(frmdiseniofactelectronica.QuickRep1);
  Gpdf.Free;



  frmdiseniofactelectronica.QRLabel1.Caption:='TRIPLICADO';
  nombre_archivo:=tc+trim(letra)+''+TRIM(nro_comprobante)+'TRIPLICADO.PDF'; //'_'+TRIM(patente_para_factura)+

 // frmdiseniofactelectronica.QuickRep1.Prepare;


  Gpdf:=TExportar2PDFSyn.create;
 // Gpdf.rutaPDF:=GetCurrentDir+ '\'+nombre_archivo;
 //  Gpdf.rutaPDF:=fa.DIRFAE+ '\'+nombre_archivo;
  Gpdf.rutaPDF:=directoriosave+ '\'+nombre_archivo;
  Gpdf.exportar2PDF(frmdiseniofactelectronica.QuickRep1);
  Gpdf.Free;



   frmdiseniofactelectronica.free;

generar_pdf:=directoriosave+ '\'+nombre_archivo_original;
end;



function TForm1.generar_pdf_viejo(idturno:longint):STRING;
var posi,I,codclientefacturacion:longint;
dd,mm,aaaa,nombre_archivo,directoriosave:string;  gravado,iva:real;
CODIGO_BARRA,DIGITO,CUIT,nombre_archivo_original,MODO,t:STRING;
aqQm,aturnos:tsqlquery;                dirfinal:string;
 VAR Gpdf:TExportar2PDFSyn;  fefa:tdate;
 archi:textfile;
 directorio,fechadir,letra,NOMBRE_CLIENTE,fchafactura:string;
begin
 { assignfile(archi,'C:\APPLUS\DESARROLLO STARTEAM\EN DESARROLLOS\SISTEMA SAG VTV\VTVSAG CAPITAL FEDERAL\WS XML CABA V2\fact_faltantes\email.txt');
  if fileexists('C:\APPLUS\DESARROLLO STARTEAM\EN DESARROLLOS\SISTEMA SAG VTV\VTVSAG CAPITAL FEDERAL\WS XML CABA V2\fact_faltantes\email.txt')=false then
    rewrite(archi);}

   frmdiseniofactelectronica:=tfrmdiseniofactelectronica.Create(self);

  aturnos:=tsqlquery.create(nil);
  aturnos.SQLConnection := MyBD;
  aturnos.CLOSE;
  aturnos.SQL.CLEAR;
  aturnos.sql.add('select * from tdatosturno where  TURNOID='+inttostr(idturno));
  aturnos.ExecSQL;
  aturnos.open;
  while not aturnos.eof do
  begin

    aqQm:=tsqlquery.create(nil);
  aqQm.SQLConnection := MyBD;
  aqQm.CLOSE;
  aqQm.SQL.CLEAR;
  aqQm.sql.add('select dirconce from tvarios');
  aqQm.ExecSQL;
  aqQm.open;
  frmdiseniofactelectronica.QRLabel22.Caption:=trim(aqqm.fieldbyname('dirconce').asstring);
  frmdiseniofactelectronica.QRLabel23.Caption:='Ciudad de Buenos Aires';

  aqqm.Close;
  aqqm.Free;


   t  := StringReplace(TRIM(aturnos.fieldbyname('importeverificacion').asstring), '.', ',',
                          [rfReplaceAll, rfIgnoreCase]);

frmdiseniofactelectronica.RxMemoryData1.Close;
frmdiseniofactelectronica.RxMemoryData1.Open;
frmdiseniofactelectronica.RxMemoryData1.Append;
frmdiseniofactelectronica.RxMemoryData1servicio.Value:='VTV A VEHICULO '+TRIM(aturnos.fieldbyname('dvdomino').asstring);
frmdiseniofactelectronica.RxMemoryData1cantidad.Value:='1.00';

gravado:=strtofloat(t)/1.21;
iva:=strtofloat(t) - gravado ;

if TRIM(aturnos.fieldbyname('TIPOCOMPROBANTEAFIP').asstring)='FAA' then
begin
frmdiseniofactelectronica.RxMemoryData1preciounit.Value:=floattostr(gravado)+'.00';
frmdiseniofactelectronica.RxMemoryData1iva.Value:=floattostr(iva)+'.00';
frmdiseniofactelectronica.RxMemoryData1total.Value:=TRIM(aturnos.fieldbyname('importeverificacion').asstring);

 frmdiseniofactelectronica.QRLabel58.Caption:=floattostr(gravado)+'.00';
 frmdiseniofactelectronica.QRLabel68.Caption:=floattostr(iva)+'.00';
 frmdiseniofactelectronica.QRLabel74.Caption:=TRIM(aturnos.fieldbyname('importeverificacion').asstring);

end;

if TRIM(aturnos.fieldbyname('TIPOCOMPROBANTEAFIP').asstring)='FAB' then
begin
frmdiseniofactelectronica.RxMemoryData1preciounit.Value:=TRIM(aturnos.fieldbyname('importeverificacion').asstring);
frmdiseniofactelectronica.RxMemoryData1iva.Value:='';
frmdiseniofactelectronica.RxMemoryData1total.Value:=TRIM(aturnos.fieldbyname('importeverificacion').asstring);

 frmdiseniofactelectronica.QRLabel58.Caption:=TRIM(aturnos.fieldbyname('importeverificacion').asstring);
 frmdiseniofactelectronica.QRLabel68.Caption:='0.00';
 frmdiseniofactelectronica.QRLabel74.Caption:=TRIM(aturnos.fieldbyname('importeverificacion').asstring);

end;



 frmdiseniofactelectronica.RxMemoryData1.Post;

 if  TRIM(aturnos.fieldbyname('TIPOCOMPROBANTEAFIP').asstring)='FAA' then 
  BEGIN
  frmdiseniofactelectronica.QRLabel4.Caption:='FACTURA';

 frmdiseniofactelectronica.QRLabel3.Caption:='COD. 01';
   letra:='A';
 END;

  if TRIM(aturnos.fieldbyname('TIPOCOMPROBANTEAFIP').asstring)='FAB' then
  BEGIN
  letra:='B';
   frmdiseniofactelectronica.QRLabel4.Caption:='FACTURA';

  frmdiseniofactelectronica.QRLabel3.Caption:='COD. 06';
  END;

  fchafactura:=copy(trim(aturnos.fieldbyname('fechavence').asstring),7,2)+'/'+copy(trim(aturnos.fieldbyname('fechavence').asstring),5,2)+'/'+copy(trim(aturnos.fieldbyname('fechavence').asstring),1,4);


  fefa:=strtodate(fchafactura);

  fefa:=fefa - 10;
   fchafactura:=datetostr(fefa);

  posi:=pos('-',trim(aturnos.fieldbyname('NRO_COMPROBANTE').asstring));
 frmdiseniofactelectronica.QRLabel7.Caption:=trim(copy(trim(aturnos.fieldbyname('NRO_COMPROBANTE').asstring),0,posi-1));
 frmdiseniofactelectronica.QRLabel8.Caption:=trim(copy(trim(aturnos.fieldbyname('NRO_COMPROBANTE').asstring),posi+1,length(trim(aturnos.fieldbyname('NRO_COMPROBANTE').asstring))));
 frmdiseniofactelectronica.QRLabel10.Caption:=fchafactura;
 frmdiseniofactelectronica.QRLabel77.Caption:=trim(aturnos.fieldbyname('CAE').asstring);


 frmdiseniofactelectronica.QRLabel2.Caption:=letra;
  if trim(letra)='A' then
 frmdiseniofactelectronica.QRLabel3.Caption:='COD. 01';

  if trim(letra)='B' then
  frmdiseniofactelectronica.QRLabel3.Caption:='COD. 06';


 dd:=copy(trim(aturnos.fieldbyname('FECHAVENCE').asstring),7,2);
 mm:=copy(trim(aturnos.fieldbyname('FECHAVENCE').asstring),5,2);
 aaaa:=copy(trim(aturnos.fieldbyname('FECHAVENCE').asstring),1,4);

 { aqQm:=tsqlquery.create(nil);
  aqQm.SQLConnection := MyBD;
  aqQm.CLOSE;
  aqQm.SQL.CLEAR;
  aqQm.sql.add('select facturarazonsocial,cuitfactura,dfiva,dfnombre,dfapellido,dfnrodocumento,'+
               ' dftipodocumento,dfcalle, dfnumerocalle,dfpiso,DFDEPARTAMENTO,DFLOCALIDAD,DFPROVINCIA from tdatosturno WHERE TURNOID='+INTTOSTR(idturno));
  aqQm.ExecSQL;
  aqQm.open;

     IF TRIM(aqQm.FIELDBYNAME('facturarazonsocial').AsString)<>'' THEN
       frmdiseniofactelectronica.QRLabel27.Caption:=TRIM(aqQm.FIELDBYNAME('facturarazonsocial').AsString)
       ELSE
         frmdiseniofactelectronica.QRLabel27.Caption:=TRIM(aqQm.FIELDBYNAME('dfapellido').AsString)+' '+TRIM(aqQm.FIELDBYNAME('dfnombre').AsString);
        }






  IF TRIM(aturnos.fieldbyname('DFTIPODOCUMENTO').asstring)='1' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='DNI: ';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(aturnos.fieldbyname('DFNRODOCUMENTO').asstring);

  END;

   IF TRIM(aturnos.fieldbyname('DFTIPODOCUMENTO').asstring)='2' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='LE: ';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(aturnos.fieldbyname('DFNRODOCUMENTO').asstring);

  END;

     IF TRIM(aturnos.fieldbyname('DFTIPODOCUMENTO').asstring)='3' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='LC: ';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(aturnos.fieldbyname('DFNRODOCUMENTO').asstring);;

  END;

       IF TRIM(aturnos.fieldbyname('DFTIPODOCUMENTO').asstring)='4' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='DNI EX.: ';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(aturnos.fieldbyname('DFNRODOCUMENTO').asstring);

  END;

       IF TRIM(aturnos.fieldbyname('DFTIPODOCUMENTO').asstring)='5' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='CED.EX.: ';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(aturnos.fieldbyname('DFNRODOCUMENTO').asstring);

  END;

         IF TRIM(aturnos.fieldbyname('DFTIPODOCUMENTO').asstring)='6' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='PASAP.: ';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(aturnos.fieldbyname('DFNRODOCUMENTO').asstring);

  END;

          IF TRIM(aturnos.fieldbyname('DFTIPODOCUMENTO').asstring)='7' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='';
    frmdiseniofactelectronica.QRLabel26.Caption:='';

  END;


            IF TRIM(aturnos.fieldbyname('DFTIPODOCUMENTO').asstring)='8' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='CED';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(aturnos.fieldbyname('DFNRODOCUMENTO').asstring);

  END;


   IF TRIM(aturnos.fieldbyname('DFTIPODOCUMENTO').asstring)='9' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='C.U.I.T.:';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(aturnos.fieldbyname('CUITFACTURA').asstring);

  END;

           IF TRIM(aturnos.fieldbyname('DFTIPODOCUMENTO').asstring)='10' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='CERT.NAC';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(aturnos.fieldbyname('DFNRODOCUMENTO').asstring);

  END;
           IF TRIM(aturnos.fieldbyname('DFTIPODOCUMENTO').asstring)='11' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='CERT';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(aturnos.fieldbyname('DFNRODOCUMENTO').asstring);

  END;
           IF TRIM(aturnos.fieldbyname('DFTIPODOCUMENTO').asstring)='12' THEN
  BEGIN
    frmdiseniofactelectronica.QRLabel24.Caption:='CED.CIU';
    frmdiseniofactelectronica.QRLabel26.Caption:=TRIM(aturnos.fieldbyname('DFNRODOCUMENTO').asstring);

  END;

       codclientefacturacion:=aturnos.fieldbyname('CODCLIEN').ASINTEGER ;
       aqQm:=tsqlquery.create(nil);
       aqQm.SQLConnection := MyBD;
       aqQm.sql.add('select  tiptribu, LOCALIDA,DIRECCIO,NROCALLE,NOMBRE,APELLID1'+
                                    '   from tclientes where codclien ='+inttostr(codclientefacturacion));
       aqQm.ExecSQL;
       aqQm.open;

       NOMBRE_CLIENTE:=TRIM(aqQm.FIELDBYNAME('NOMBRE').AsString)+' '+TRIM(aqQm.FIELDBYNAME('APELLID1').AsString);


         frmdiseniofactelectronica.QRLabel27.Caption:=TRIM(NOMBRE_CLIENTE);




         
   IF TRIM(aturnos.fieldbyname('DFIVA').asstring)='C' THEN
    frmdiseniofactelectronica.QRLabel29.Caption:='Consumidor Final';


    IF TRIM(aturnos.FIELDBYNAME('DFIVA').AsString)='R' THEN
    frmdiseniofactelectronica.QRLabel29.Caption:='Responsable Inscripto';


    IF TRIM(aturnos.FIELDBYNAME('DFIVA').AsString)='M' THEN
    frmdiseniofactelectronica.QRLabel29.Caption:='Monotributo';

    IF TRIM(aturnos.FIELDBYNAME('DFIVA').AsString)='E' THEN
    frmdiseniofactelectronica.QRLabel29.Caption:='Exento';


   frmdiseniofactelectronica.QRLabel31.Caption:=TRIM(aqQm.FIELDBYNAME('DIRECCIO').AsString)+
   ' '+TRIM(aqQm.FIELDBYNAME('NROCALLE').AsString)+
   ' - '+TRIM(aqQm.FIELDBYNAME('LOCALIDA').AsString);



   aqQm.Close;
   aqQm.Free;

  frmdiseniofactelectronica.QRLabel33.Caption:='Contado';
 frmdiseniofactelectronica.QRLabel78.Caption:=dd+'/'+mm+'/'+aaaa;


 {CODIGO BARRA}
 CUIT:='30714930490';

 CODIGO_BARRA:=CUIT+'01'+trim(copy(trim(aturnos.fieldbyname('NRO_COMPROBANTE').asstring),0,posi-1))+TRIM(aturnos.fieldbyname('CAE').asstring)+TRIM(aturnos.fieldbyname('FECHAVENCE').asstring)+DIGITO;
 frmdiseniofactelectronica.Barcode1D_Code1281.Barcode:=CODIGO_BARRA;


  frmdiseniofactelectronica.QRLabel79.Caption:=CODIGO_BARRA+DIGITO_VERIFICADOR_FACTURA(CODIGO_BARRA);

 {FIN}
 {directorios}
 fechadir:=copy(trim(fchafactura),0,2)+copy(trim(fchafactura),4,2)+copy(trim(fchafactura),7,4);
   directorio:=fa.DIRFAE+'\'+fechadir;
     If not DirectoryExists(directorio) then
            CreateDir(directorio) ;





 directoriosave:=directorio;
 {-------------}
 MODO:='P';
 IF TRIM(MODO)='H' THEN
  frmdiseniofactelectronica.QRLabel1.Caption:='COMPROBANTE EN MODO TESTING. NO VALIDO COMO FACTURA ORIGINAL'
  ELSE
  frmdiseniofactelectronica.QRLabel1.Caption:='ORIGINAL';

  //nombre_archivo:='Fact'+trim(letra)+''+TRIM(aturnos.fieldbyname('nro_comprobante').asstring)+'_'+TRIM(aturnos.fieldbyname('dvdomino').asstring)+'_ORIGINAL.PDF';

  nombre_archivo:='Fact'+trim(letra)+''+TRIM(aturnos.fieldbyname('nro_comprobante').asstring)+'ORIGINAL.PDF';
  nombre_archivo_original:=nombre_archivo;
  frmdiseniofactelectronica.QuickRep1.Prepare;



   //directoriosave:='\\10.54.3.3\'+fechadir;
  Gpdf:=TExportar2PDFSyn.create;
 // Gpdf.rutaPDF:=fa.DIRFAE+ '\'+nombre_archivo;
  Gpdf.rutaPDF:=directoriosave+ '\'+nombre_archivo;
 // Gpdf.rutaPDF:=fa.DIRFAE+ '\'+nombre_archivo;
  Gpdf.exportar2PDF(frmdiseniofactelectronica.QuickRep1);
  Gpdf.Free;

  { append(archi);
  writeln(archi,trim(aturnos.fieldbyname('turnoid').asstring)+'|'+trim(aturnos.fieldbyname('contactoemail').asstring)+'|'+directoriosave+ '\'+nombre_archivo);
   closefile(archi); }

  frmdiseniofactelectronica.QRLabel1.Caption:='DUPLICADO';
  //nombre_archivo:='Fact'+trim(letra)+''+TRIM(aturnos.fieldbyname('nro_comprobante').asstring)+'_'+TRIM(aturnos.fieldbyname('dvdomino').asstring)+'_DUPLICADO.PDF';
  nombre_archivo:='Fact'+trim(letra)+''+TRIM(aturnos.fieldbyname('nro_comprobante').asstring)+'_DUPLICADO.PDF';

  frmdiseniofactelectronica.QuickRep1.Prepare;


  Gpdf:=TExportar2PDFSyn.create;
 // Gpdf.rutaPDF:=fa.DIRFAE+ '\'+nombre_archivo;
  Gpdf.rutaPDF:=directoriosave+ '\'+nombre_archivo;
  Gpdf.exportar2PDF(frmdiseniofactelectronica.QuickRep1);
  Gpdf.Free;



  frmdiseniofactelectronica.QRLabel1.Caption:='TRIPLICADO';
  nombre_archivo:='Fact'+trim(letra)+''+TRIM(aturnos.fieldbyname('nro_comprobante').asstring)+'_TRIPLICADO.PDF';
  //nombre_archivo:='Fact'+trim(letra)+''+TRIM(aturnos.fieldbyname('nro_comprobante').asstring)+'_'+TRIM(aturnos.fieldbyname('dvdomino').asstring)+'_TRIPLICADO.PDF';

  frmdiseniofactelectronica.QuickRep1.Prepare;


  Gpdf:=TExportar2PDFSyn.create;
 // Gpdf.rutaPDF:=GetCurrentDir+ '\'+nombre_archivo;
 //  Gpdf.rutaPDF:=fa.DIRFAE+ '\'+nombre_archivo;
  Gpdf.rutaPDF:=directoriosave+ '\'+nombre_archivo;
  Gpdf.exportar2PDF(frmdiseniofactelectronica.QuickRep1);
  Gpdf.Free;

   aturnos.Next;

   end;

   aturnos.Close;
  aturnos.Free;
  frmdiseniofactelectronica.Free;
  dirfinal:=fa.DIRFAE+'\'+fechadir+'\'+nombre_archivo_original;
generar_pdf_viejo:=directoriosave+ '\'+nombre_archivo_original;
end;

procedure TForm1.Button1Click(Sender: TObject);


begin
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);
TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN
           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('DESCARGANDO  FERIADOS...');

               TX.DESCARGAR_FERIADO(TRIM(EDIT4.Text));

               if tx.ver_respuestaidpago=1 then
                begin

                     APPLICATION.ProcessMessages;





                end ELSE BEGIN
                  MEMO1.Lines.Add('ESTADO DESCARGA: '+TX.ver_respuestamensajepago);


                END;







               MEMO1.Clear;
               MEMO1.Lines.Add('PROCESO TERMINADO !!!!.');

              END;

            TX.Cerrar_seccion;

         END else
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');






  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
  END;







end;

procedure TForm1.generar_domingos;
var DiasASumar,cont:longint;
fecha,fechafinal:tdatetime;
a,iddomingo,descripcionferiado,fechaferiado,SSQL:String;    aqinsertadetallepago:tsqlquery ;
  wAnyo, wMes, wDia: Word;
begin
{borrar domingos}
if (not MyBD.InTransaction) then
        MyBD.StartTransaction(td);

        TRY
           SSQL:=' delete from XML_FERIADOS where feriadoid < 0';
           aqinsertadetallepago:=tsqlquery.create(nil);
           aqinsertadetallepago.SQLConnection := MyBD;
           aqinsertadetallepago.sql.add(SSQL);
           aqinsertadetallepago.ExecSQL;
           MYBD.Commit(TD);
        EXCEPT
          on E : Exception do
           BEGIN
            MyBD.Rollback(TD);
            END;
          END;


DecodeDate( now , wAnyo, wMes, wDia );
a:=IntToStr( wAnyo );
Fecha := Now;
fechafinal:=strtodate('31/12/'+trim(a));
DiasASumar:=daysbetween(fecha,fechafinal);
cont:=1;
while (cont<=DiasASumar) do
begin

   //showmessage(datetostr(fecha));

   if (DayOfTheWeek(Fecha) = 7) then {1 lunes, 5 viernes, 6 sabado, 7 domingo}
   begin
   iddomingo:='-'+inttostr(strtoint(trim(copy(datetostr(fecha),1,2)+copy(datetostr(fecha),4,2)+copy(datetostr(fecha),7,4))));
   descripcionferiado:='Domingo';
   fechaferiado:=datetostr(fecha);
    if (not MyBD.InTransaction) then
        MyBD.StartTransaction(td);

        TRY
           SSQL:=' INSERT INTO XML_FERIADOS  VALUES ('+INTTOSTR(STRTOINT(TRIM(iddomingo)))+
                 ',TO_DATE('+#39+fechaferiado+#39+',''dd/mm/yyyy''),'+#39+TRIM(descripcionferiado)+#39+')';
           aqinsertadetallepago:=tsqlquery.create(nil);
           aqinsertadetallepago.SQLConnection := MyBD;
           aqinsertadetallepago.sql.add(SSQL);
           aqinsertadetallepago.ExecSQL;
           MYBD.Commit(TD);
        EXCEPT
          on E : Exception do
           BEGIN
            MyBD.Rollback(TD);
            END;
          END;

   end;
   fecha:=IncDay(Fecha,1);
   inc(cont);

end;
end;


procedure TForm1.obtener_feriados;

var
a:string;
  wAnyo, wMes, wDia: Word;
begin
  DecodeDate( now, wAnyo, wMes, wDia );
  a:=IntToStr( wAnyo ) ;

TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN
           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('DESCARGANDO  FERIADOS...');

               TX.DESCARGAR_FERIADO(TRIM(a));




                generar_domingos;


               if tx.ver_respuestaidpago=1 then
                begin

                     APPLICATION.ProcessMessages;





                end ELSE BEGIN
                  MEMO1.Lines.Add('ESTADO DESCARGA: '+TX.ver_respuestamensajepago);


                END;







               MEMO1.Clear;
               MEMO1.Lines.Add('PROCESO TERMINADO !!!!.');

              END;

            TX.Cerrar_seccion;

         END else
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');






  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
  END;







end;



FUNCTION TForm1.PROCEDIMIENTOS_XML_PAGOS_INDIVIDUAL:BOOLEAN;
var
  XMLDoc: IXMLDocument;
  Node: IXMLNode;
  I: Integer;
  role, link: string;

begin

TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN

           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('DESCARGANDO  PAGOS INDIVIDUALES...');
             // TX.DESCARGAR_PAGOS_POR_CODIGO_PAGO(183834,0);       //183838
               TX.DESCARGAR_PAGOS_POR_NOVEDAD('I');

               if tx.ver_respuestaidpago=1 then
                begin
                     MEMO1.Lines.Add('ESTADO DESCARGA: '+TX.ver_respuestamensajepago);
                     MEMO1.Lines.Add('CANTIDAD DE PAGOS: '+TX.ver_cantidadPagos);
                     APPLICATION.ProcessMessages;

                   IF STRTOINT(TX.ver_cantidadPagos) > 0 THEN
                   begin
                    MEMO1.Lines.Add('PROCESANDO PAGOS...');
                     APPLICATION.ProcessMessages;

                     TX.PROCESARARCHIVOPAGOS(TX.VER_ARCHIVOS_XML_PAGOS);
                  end;



                end ELSE BEGIN
                BEGIN
                  MEMO1.Lines.Add('ESTADO DESCARGA: '+TX.ver_respuestamensajepago);

                 END;

                END;



             { IF CONEXION_OK=TRUE THEN
               BEGIN
              IF  (TRIM(TX.VER_HABILITADO_FACTURA)='S') AND (TRIM(TX.VER_FECHA_VENCE_CERTIFICADO)<>'N') THEN
                BEGIN
                   IF STRTODATE(TRIM(TX.VER_FECHA_VENCE_CERTIFICADO))> NOW THEN
                       Factura_Electronica_pagos_suvtv(TX.ver_planta)
                      else
                      MEMO1.Lines.Add('CERTIFICADO DE FACTURA ELECTRONICA VENCIDO!!!!');

                END;
              END;    }

               MEMO1.Clear;
               MEMO1.Lines.Add('PROCESO TERMINADO !!!!.INSERTADOS: '+INTTOSTR(TX.ver_total_registros_pagos_insertados)+'  DE: '+TX.ver_cantidadPagos);

              END;

            TX.Cerrar_seccion;

         END else
         BEGIN
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');

           END;




  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);

  END;











END;


FUNCTION TForm1.PROCEDIMIENTOS_XML_PAGOS_INDIVIDUAL_1830:BOOLEAN;
var
  XMLDoc: IXMLDocument;
  Node: IXMLNode;
  I: Integer;
  role, link: string;
  ic:longint;
  hd,hh,d,h:string;
begin
  D:=COPY(DATETOSTR(date),7,4)+'-'+COPY(DATETOSTR(date),4,2)+'-'+COPY(DATETOSTR(date),1,2);
  H:=COPY(DATETOSTR(date),7,4)+'-'+COPY(DATETOSTR(date),4,2)+'-'+COPY(DATETOSTR(date),1,2);


                 ic:=1;
                while ic <=18 do
                begin
                h:='';
                d:='';
                         if ic=1 then
                   begin
                     hd:='00:00:00';
                     hh:='01:00:00';
                   end;


                      if ic=2 then
                   begin
                     hd:='01:00:01';
                     hh:='02:00:00';
                   end;

                        if ic=3 then
                   begin
                     hd:='02:00:01';
                     hh:='03:00:00';
                   end;

                       if ic=4 then
                   begin
                     hd:='03:00:01';
                     hh:='04:00:00';
                   end;

                   if ic=5 then
                   begin
                     hd:='04:00:01';
                     hh:='05:00:00';
                   end;

                   if ic=6 then
                   begin
                     hd:='05:00:01';
                     hh:='06:00:00';
                   end;

                   if ic=7 then
                   begin
                     hd:='06:00:01';
                     hh:='07:00:00';
                   end;

                   if ic=8 then
                   begin
                     hd:='07:00:01';
                     hh:='08:00:00';
                   end;
                    if ic=9 then
                   begin
                     hd:='08:00:01';
                     hh:='09:00:00';
                   end;

                      if ic=10 then
                   begin
                     hd:='09:00:01';
                     hh:='10:00:00';
                   end;

                      if ic=11 then
                   begin
                     hd:='10:00:01';
                     hh:='11:00:00';
                   end;
                  if ic=12 then
                   begin
                     hd:='11:00:01';
                     hh:='12:00:00';
                   end;
                  if ic=13 then
                   begin
                     hd:='12:00:01';
                     hh:='13:00:00';
                   end;
                if ic=14 then
                   begin
                     hd:='13:00:01';
                     hh:='14:00:00';
                   end;
                if ic=15 then
                   begin
                     hd:='14:00:01';
                     hh:='15:00:00';
                   end;
               if ic=16 then
                   begin
                     hd:='15:00:01';
                     hh:='16:00:00';
                   end;
               if ic=17 then
                   begin
                     hd:='16:00:01';
                     hh:='17:00:00';
                   end;
                   if ic=18 then
                          begin
                     hd:='17:00:01';
                     hh:='18:00:00';
                   end;



                   d:=d+' '+hd;
                   h:=h+' '+hh;
                    memo1.Lines.Add('pagos individuales: '+inttostr(ic)+': '+d+'   '+h);
                    application.ProcessMessages;
                    sleep(1000);
                   self.PROCEDIMIENTOS_XML_PAGOS_INDIVIDUAL_por_fecha(d,h);

                 ic:=ic+1;
                end;










END;




FUNCTION TForm1.PROCEDIMIENTOS_XML_PAGOS_flota_1830:BOOLEAN;
var
  XMLDoc: IXMLDocument;
  Node: IXMLNode;
  I: Integer;
  role, link: string;
  ic:longint;
  hd,hh,d,h:string;
begin
  D:=COPY(DATETOSTR(date),7,4)+'-'+COPY(DATETOSTR(date),4,2)+'-'+COPY(DATETOSTR(date),1,2);
  H:=COPY(DATETOSTR(date),7,4)+'-'+COPY(DATETOSTR(date),4,2)+'-'+COPY(DATETOSTR(date),1,2);



ic:=1;
                while ic <=18 do
                begin
                h:='';
                d:='';
                           if ic=1 then
                   begin
                     hd:='00:00:00';
                     hh:='01:00:00';
                   end;


                      if ic=2 then
                   begin
                     hd:='01:00:01';
                     hh:='02:00:00';
                   end;

                        if ic=3 then
                   begin
                     hd:='02:00:01';
                     hh:='03:00:00';
                   end;

                       if ic=4 then
                   begin
                     hd:='03:00:01';
                     hh:='04:00:00';
                   end;

                   if ic=5 then
                   begin
                     hd:='04:00:01';
                     hh:='05:00:00';
                   end;

                   if ic=6 then
                   begin
                     hd:='05:00:01';
                     hh:='06:00:00';
                   end;

                   if ic=7 then
                   begin
                     hd:='06:00:01';
                     hh:='07:00:00';
                   end;

                   if ic=8 then
                   begin
                     hd:='07:00:01';
                     hh:='08:00:00';
                   end;
                    if ic=9 then
                   begin
                     hd:='08:00:01';
                     hh:='09:00:00';
                   end;

                      if ic=10 then
                   begin
                     hd:='09:00:01';
                     hh:='10:00:00';
                   end;

                      if ic=11 then
                   begin
                     hd:='10:00:01';
                     hh:='11:00:00';
                   end;
                  if ic=12 then
                   begin
                     hd:='11:00:01';
                     hh:='12:00:00';
                   end;
                  if ic=13 then
                   begin
                     hd:='12:00:01';
                     hh:='13:00:00';
                   end;
                if ic=14 then
                   begin
                     hd:='13:00:01';
                     hh:='14:00:00';
                   end;
                if ic=15 then
                   begin
                     hd:='14:00:01';
                     hh:='15:00:00';
                   end;
               if ic=16 then
                   begin
                     hd:='15:00:01';
                     hh:='16:00:00';
                   end;
               if ic=17 then
                   begin
                     hd:='16:00:01';
                     hh:='17:00:00';
                   end;
                   if ic=18 then
                          begin
                     hd:='17:00:01';
                     hh:='18:00:00';
                   end;


                   d:=d+' '+hd;
                   h:=h+' '+hh;

                     
                   memo1.Lines.Add('pagos flotas: '+inttostr(ic)+': '+d+'   '+h);
                    application.ProcessMessages;
                    sleep(1000);
                   self.PROCEDIMIENTOS_XML_PAGOS_FLOTA_POR_FECHA(d,h);

                 ic:=ic+1;
                end;










END;



 PROCEDURE TForm1.SERVICIO_FACTURA_ELECTRONICA;
 BEGIN
 IF CONEXION_OK=TRUE THEN
 BEGIN
              IF  (TRIM(TX.VER_HABILITADO_FACTURA)='S') AND (TRIM(TX.VER_FECHA_VENCE_CERTIFICADO)<>'N') THEN
                BEGIN
                   IF STRTODATE(TRIM(TX.VER_FECHA_VENCE_CERTIFICADO))> NOW THEN
                   BEGIN

                       Factura_Electronica_pagos_suvtv(TX.ver_planta)
                    END  else
                      BEGIN

                      MEMO1.Lines.Add('CERTIFICADO DE FACTURA ELECTRONICA VENCIDO!!!!');
                      END;
                END;

 END;

  END;


FUNCTION TForm1.PROCEDIMIENTOS_XML_PAGOS_INDIVIDUAL_por_fecha(desde,hasta:string):BOOLEAN;
var
  XMLDoc: IXMLDocument;
  Node: IXMLNode;
  I: Integer;
  role, link: string;

begin

TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN
           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('DESCARGANDO  PAGOS INDIVIDUALES POR FECHA...');
               APPLICATION.ProcessMessages;

             // TX.DESCARGAR_PAGOS_POR_CODIGO_PAGO(183834,0);       //183838
               TX.DESCARGAR_PAGOS_POR_NOVEDAD_fecha('I',desde,hasta);

               if tx.ver_respuestaidpago=1 then
                begin
                     MEMO1.Lines.Add('ESTADO DESCARGA: '+TX.ver_respuestamensajepago);
                     MEMO1.Lines.Add('CANTIDAD DE PAGOS: '+TX.ver_cantidadPagos);
                     APPLICATION.ProcessMessages;

                   IF STRTOINT(TX.ver_cantidadPagos) > 0 THEN
                   begin
                    MEMO1.Lines.Add('PROCESANDO PAGOS...');
                     APPLICATION.ProcessMessages;

                     TX.PROCESARARCHIVOPAGOS(TX.VER_ARCHIVOS_XML_PAGOS);

                  end;



                end ELSE BEGIN
                  MEMO1.Lines.Add('ESTADO DESCARGA: '+TX.ver_respuestamensajepago);
                   APPLICATION.ProcessMessages;


                END;





           {   IF  (TRIM(TX.VER_HABILITADO_FACTURA)='S') AND (TRIM(TX.VER_FECHA_VENCE_CERTIFICADO)<>'N') THEN
                BEGIN
                   IF STRTODATE(TRIM(TX.VER_FECHA_VENCE_CERTIFICADO))> NOW THEN
                       Factura_Electronica_pagos_suvtv(TX.ver_planta)
                      else
                      MEMO1.Lines.Add('CERTIFICADO DE FACTURA ELECTRONICA VENCIDO!!!!');

                END; }


               MEMO1.Clear;
               MEMO1.Lines.Add('PROCESO TERMINADO !!!!.INSERTADOS: '+INTTOSTR(TX.ver_total_registros_pagos_insertados)+'  DE: '+TX.ver_cantidadPagos);
                APPLICATION.ProcessMessages;

              END;

            TX.Cerrar_seccion;

         END else
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');






  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
  END;











END;



function tform1.pagos_sin_bajar_segun_turnos_descargados:boolEAN;
var
  XMLDoc: IXMLDocument;
  Node: IXMLNode;
  I: Integer;
  role, link: string;
    aqQ:tsqlquery ;
    SI:BOOLEAN;
begin

TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN
           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('PROCESANDO TURNOS SIN PAGOS DESCARGADOS');
               application.ProcessMessages;

               {----------------------------------------------}
                   aqQ:=tsqlquery.create(nil);
                   aqQ.SQLConnection := MyBD;
                   aqQ.CLOSE;
                   aqQ.SQL.CLEAR;
                   aqQ.sql.add('SELECT TD.PAGOIDVERIFICACION,TD.TIPOTURNO FROM TDATOSTURNO TD  '+
                               ' WHERE TD.FECHALTA=TO_DATE('+#39+DATETOSTR(DATE)+#39',''DD/MM/YYYY'')  '+
                               ' AND   '+
                               ' TD.TIPOTURNO IN (''O'',''P'')'+
                               ' AND TD.PAGOIDVERIFICACION NOT IN (SELECT TF.IDPAGO FROM TFACTURAS TF)');
                   AQQ.ExecSQL;
                   AQQ.OPEN;
                   SI:=FALSE;
                   WHILE NOT AQQ.EOF DO
                   BEGIN
                   SI:=TRUE;
                    TX.DESCARGAR_PAGOS_POR_CODIGO_PAGO(AQQ.FieldS[0].AsInteger,0);       //183838

                      APPLICATION.ProcessMessages;

                       if tx.ver_respuestaidpago=1 then
                          begin

                           MEMO1.Lines.Add('PROCESANDO PAGOS...');
                           APPLICATION.ProcessMessages;

                           TX.PROCESARARCHIVOPAGOS(TX.VER_ARCHIVOS_XML_PAGOS);
                          end;

                    AQQ.NEXT;
                    END;
                {------------------------------------------------------------------}

                end ELSE BEGIN
                  MEMO1.Lines.Add('ESTADO DESCARGA: '+TX.ver_respuestamensajepago);


                END;   //ABRIR






                IF  (TRIM(TX.VER_HABILITADO_FACTURA)='S') AND (TRIM(TX.VER_FECHA_VENCE_CERTIFICADO)<>'N') AND (SI=TRUE) THEN
                BEGIN
                   IF STRTODATE(TRIM(TX.VER_FECHA_VENCE_CERTIFICADO))> NOW THEN
                      Factura_Electronica_pagos_suvtv(TX.ver_planta)
                      else
                      MEMO1.Lines.Add('CERTIFICADO DE FACTURA ELECTRONICA VENCIDO!!!!');

                END;


               MEMO1.Clear;
               MEMO1.Lines.Add('PROCESO TERMINADO !!!!.INSERTADOS: '+INTTOSTR(TX.ver_total_registros_pagos_insertados)+'  DE: '+TX.ver_cantidadPagos);

              END;  //SER

           TX.Cerrar_seccion;






  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
  END;





  //tx.Cerrar_seccion;





end;

function TForm1.PROCEDIMIENTOS_XML_PAGOS_FLOTA:BOOLEAN;
var
  XMLDoc: IXMLDocument;
  Node: IXMLNode;
  I: Integer;
  role, link: string;

begin

TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN

           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('DESCARGANDO  PAGOS POR FLOTA...');
               application.ProcessMessages;
             // TX.DESCARGAR_PAGOS_POR_CODIGO_PAGO(183834,0);       //183838
              TX.DESCARGAR_PAGOS_POR_NOVEDAD('F');
                  APPLICATION.ProcessMessages;

               if tx.ver_respuestaidpago=1 then
                begin
                     MEMO1.Lines.Add('ESTADO DESCARGA: '+TX.ver_respuestamensajepago);
                     MEMO1.Lines.Add('CANTIDAD DE PAGOS: '+TX.ver_cantidadPagos);
                     APPLICATION.ProcessMessages;

                   IF STRTOINT(TX.ver_cantidadPagos) > 0 THEN
                       begin
                        MEMO1.Lines.Add('PROCESANDO PAGOS...');
                         APPLICATION.ProcessMessages;

                         TX.PROCESARARCHIVOPAGOS(TX.VER_ARCHIVOS_XML_PAGOS);
                    end;



                end ELSE BEGIN
                  MEMO1.Lines.Add('ESTADO DESCARGA: '+TX.ver_respuestamensajepago);


                END;




               { if FORM1.CONEXION_OK=TRUE then
                begin

                   IF  (TRIM(TX.VER_HABILITADO_FACTURA)='S') AND (TRIM(TX.VER_FECHA_VENCE_CERTIFICADO)<>'N') THEN
                      BEGIN
                        IF STRTODATE(TRIM(TX.VER_FECHA_VENCE_CERTIFICADO))> NOW THEN
                           Factura_Electronica_pagos_suvtv(TX.ver_planta)
                           else
                           MEMO1.Lines.Add('CERTIFICADO DE FACTURA ELECTRONICA VENCIDO!!!!');

                      END;
               end;    }


               MEMO1.Clear;
               MEMO1.Lines.Add('PROCESO TERMINADO !!!!.INSERTADOS: '+INTTOSTR(TX.ver_total_registros_pagos_insertados)+'  DE: '+TX.ver_cantidadPagos);

              END;

           TX.Cerrar_seccion;

         END else  BEGIN
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');



          END;



  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);

  END;





  //tx.Cerrar_seccion;




END;



function TForm1.PROCEDIMIENTOS_XML_PAGOS_FLOTA_POR_FECHA(DESDE,HASTA:STRING):BOOLEAN;
var
  XMLDoc: IXMLDocument;
  Node: IXMLNode;
  I: Integer;
  role, link: string;

begin

TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN
           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('DESCARGANDO  PAGOS POR FLOTA...');
               application.ProcessMessages;
             // TX.DESCARGAR_PAGOS_POR_CODIGO_PAGO(183834,0);       //183838
              TX.DESCARGAR_PAGOS_POR_NOVEDAD_fecha('F',DESDE,HASTA);
                  APPLICATION.ProcessMessages;

               if tx.ver_respuestaidpago=1 then
                begin
                     MEMO1.Lines.Add('ESTADO DESCARGA: '+TX.ver_respuestamensajepago);
                     MEMO1.Lines.Add('CANTIDAD DE PAGOS: '+TX.ver_cantidadPagos);
                     APPLICATION.ProcessMessages;

                   IF STRTOINT(TX.ver_cantidadPagos) > 0 THEN
                       begin
                        MEMO1.Lines.Add('PROCESANDO PAGOS...');
                         APPLICATION.ProcessMessages;

                         TX.PROCESARARCHIVOPAGOS(TX.VER_ARCHIVOS_XML_PAGOS);
                    end;



                end ELSE BEGIN
                  MEMO1.Lines.Add('ESTADO DESCARGA: '+TX.ver_respuestamensajepago);


                END;






             {   IF  (TRIM(TX.VER_HABILITADO_FACTURA)='S') AND (TRIM(TX.VER_FECHA_VENCE_CERTIFICADO)<>'N') THEN
                BEGIN
                   IF STRTODATE(TRIM(TX.VER_FECHA_VENCE_CERTIFICADO))> NOW THEN
                      Factura_Electronica_pagos_suvtv(TX.ver_planta)
                      else
                      MEMO1.Lines.Add('CERTIFICADO DE FACTURA ELECTRONICA VENCIDO!!!!');

                END;  }


               MEMO1.Clear;
               MEMO1.Lines.Add('PROCESO TERMINADO !!!!.INSERTADOS: '+INTTOSTR(TX.ver_total_registros_pagos_insertados)+'  DE: '+TX.ver_cantidadPagos);

              END;

           TX.Cerrar_seccion;

         END else
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');






  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
  END;





  //tx.Cerrar_seccion;




END;

procedure TForm1.Button2Click(Sender: TObject);
var
  XMLDoc: IXMLDocument;
  Node: IXMLNode;
  I: Integer;
  role, link: string;

begin
PROCEDIMIENTOS_XML_PAGOS_INDIVIDUAL;
PROCEDIMIENTOS_XML_PAGOS_FLOTA;
Timer1.Enabled:=TRUE;




end;



  

procedure TForm1.serivicio_de_reinformar_facturas_a_suvtv;
var
  archi,g:textfile;
  linea,l,aux:string;
  hasta,i:longint;
  bandera:boolean;
  cont,TURNOID:longint;

vslFichero: TStringList;
aqQ,aqQ1:tsqlquery;
begin
memo1.Clear;
TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN
           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('INFORMANDO FACTURA...');
                application.ProcessMessages;

               self.servicio_reenvio_factura_suvtv;


               MEMO1.Lines.Add('PROCESO TERMINADO !!!!.');

              END;

            TX.Cerrar_seccion;

         END else
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');






  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
  END;





 END;



procedure TForm1.Button3Click(Sender: TObject);
var
  archi,g:textfile;
  linea,l,aux:string;
  hasta,i:longint;
  bandera:boolean;
  cont,TURNOID:longint;

vslFichero: TStringList;
aqQ,aqQ1:tsqlquery;
begin
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);

  serivicio_de_reinformar_facturas_a_suvtv;
  mybd.Close;
  tx.Free;
 END;

procedure TForm1.Button4Click(Sender: TObject);

var
  XMLDoc: IXMLDocument;
  Node: IXMLNode;
  I: Integer;
  role, link: string;




  si,archi,ip: String;
  Hoja: _WorkSheet;
begin
tx:=txml_caba.Create;
TX.CONFIGURAR;
TX.ControlServidor;

tX.TestOfBD('', '', '' ,false);

if opendialog1.Execute then
archi:=opendialog1.FileName;


 Excel.Workbooks.Open( archi,
  EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
  EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
  EmptyParam, EmptyParam, EmptyParam, EmptyParam, 0 );

  
Hoja := Excel.Worksheets.Item[1] as _WorkSheet;
i := 1;
si := IntToStr( i );
repeat

TX.ControlServidor;

    ip:=Hoja.Range['A'+si,'A'+si].Value2; // C�digo
    if trIm(ip)<>'' then
       BEGIN

      MEMO1.Lines.Add('DESCARGANDO PAGO: '+IP);
      APPLICATION.ProcessMessages;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN
             TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               TX.DESCARGAR_PAGOS_POR_CODIGO_PAGO(STRTOINT(ip),0);       //183838
               //TX.DESCARGAR_PAGOS_POR_NOVEDAD('I');

               if tx.ver_respuestaidpago=1 then
                begin
                     APPLICATION.ProcessMessages;

                   IF STRTOINT(TX.ver_cantidadPagos) > 0 THEN
                   begin
                      APPLICATION.ProcessMessages;

                     TX.PROCESARARCHIVOPAGOS(TX.VER_ARCHIVOS_XML_PAGOS);
                  end;



                end ELSE BEGIN


                END;









              END;



         END ELSE BEGIN

         END;






  END ELSE BEGIN

  END;





       END;

  Inc( i );
  si := IntToStr( i );
until ( VarType( Excel.Range['A'+si,'A'+si].Value2 ) = VarEmpty );
  TX.Cerrar_seccion;
MYBD.Close;TX.Free;
 memo1.Lines.Add('PROCESO TERMINADO...') ;
end;



procedure TForm1.Button6Click(Sender: TObject);
var
  xml: IXMLDOMDocument;
  node: IXMLDomNode;
  nodes_row, nodes_se: IXMLDomNodeList;
  i, j: Integer;
  url: string;
begin
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);


 TX.CONFIGURAR;
PONE_FACUTURDO_EL_TURNO;
MEMO1.Lines.Add('TERMINADO');

 mybd.Close;
  tx.Free;

end;

procedure TForm1.Button5Click(Sender: TObject);
var
     I: Integer;
XmlNode: IXMLNode;
  NodeText: string;
  AttrNode: IXMLNode;
  begin
 END;




procedure TForm1.DomToTree (XmlNode: IXMLNode);
var
  I: Integer;  es_relacionado:boolean;
   turnorelacionado:boolean;
  NodeText,corte,r: string;
  AttrNode: IXMLNode;
begin

  // skip text nodes and other special cases
  if XmlNode.NodeType <> ntElement then
  begin


    Exit;
   end;
     
     NodeText := XmlNode.NodeName;
 


   corte:=XmlNode.ParentNode.NodeName+'_'+NodeText;
 

   if trim(corte)='datosTurno_turnosRelacionados' then
   begin
     // showmessage('i');
     // r:='turnosRelacionados_';
      relacion:='s';
   end;
   

  if XmlNode.IsTextElement then
    NodeText :=XmlNode.ParentNode.NodeName+'_'+NodeText + ' = ' + XmlNode.NodeValue
    else
    NodeText :=XmlNode.ParentNode.NodeName+'_'+NodeText ;


  memo1.Lines.Add(NodeText);



  if (trim(corte)='detallesPagoOblea_estadoAcreditacion') then
  begin
     if  trim(relacion)='s' then
     begin
        relacion:='n';
        memo1.Lines.Add('****000****');
        r:=''; 
        end
     else
     begin
     r:='';
      relacion:='n';
       memo1.Lines.Add('****999****');
       end;
  end;

  // add attributes
 { for I := 0 to xmlNode.AttributeNodes.Count - 1 do
  begin
    AttrNode := xmlNode.AttributeNodes.Nodes[I];

     memo1.Lines.Add(AttrNode.NodeName + ' = ' + AttrNode.Text);
  end; }
  // add each child node
  if XmlNode.HasChildNodes then
    for I := 0 to xmlNode.ChildNodes.Count - 1 do
      DomToTree (xmlNode.ChildNodes.Nodes [I]);
end;

function TForm1.es_linea(cadena:string):string ;
 var posi:longint;
begin
 posi:=pos('=',trim(cadena));
 if posi <> 0 then
   es_linea:=copy(trim(cadena),0,posi-1)
   else
   es_linea:=cadena;

end;

function TForm1.extrae_valor(cadena:string):string;
var posi:longint;
begin
posi:=pos('=',cadena);
 if posi> 0 then
  begin
    extrae_valor:=trim(copy(trim(cadena),posi+1,length(trim(cadena))));
  end else
    extrae_valor:='0';

end;

procedure TForm1.Button8Click(Sender: TObject);
var archi:textfile;       posi,cantidad,leyo:longint;
linea:string;


respuestaID,respuestaMensaje:string;
 turnoID:string;
estadoID :string;
estado:string;
tipoTurno:string;
fechaTurno:string;
horaTurno:string;
fechaRegistro:string;
fechaNovedad:string;
plantaID:string;
genero:string;
tipoDocumento:string;
numeroDocumento:string;
numeroCuit:string;
nombre:string;
apellido:string;
razonSocial:string;
 domicilio:string;
calle:string;
numero:string;
piso:string;
departamento:string;
localidad:string;
provinciaID:string;
provincia:string;
codigoPostal:string;
condicionIva:string;
numeroIibb:string;
 telefonoCelular:string;
email:string;
fechaNacimiento:string;
pagoID:String;
gatewayID:string;
entidadID:string;
entidadNombre:string;
fechaPago:string;
importeTotal:string;

importe:string;
estadoAcreditacion:string;
pagoGatewayID:string;
 re_item_turnoID:string;
re_item_plantaID:string;
re_item_estado:string;
re_item_fechaNovedad:string;
re_datosPago_pagoID:string;
re_datosPago_entidadID:string;
re_datosPago_fechaPago:string;
re_datosPago_importeTotal:string;
re_detallesPagoVerificacion_pagoID:string;
re_detallesPagoVerificacion_importe:string;
re_detallesPagoVerificacion_estadoAcreditacion:string;
re_detallesPagoOblea_pagoID:string;
re_detallesPagoOblea_importe:string;
re_detallesPagoOblea_estadoAcreditacion:string;
datosTitular_genero:string;
datosTitular_tipoDocumento :string;
datosTitular_numeroDocumento:string;
datosTitular_numeroCuit:string;
datosTitular_nombre:string;
datosTitular_apellido :string;
datosTitular_razonSocial:string;
datosPersonalesTurno_tipoDocumento:string;
datosPersonalesTurno_numeroDocumento:string;
datosPersonalesTurno_numeroCuit:string;
datosPersonalesTurno_nombre:string;
datosPersonalesTurno_apellido:string;
datosPersonalesTurno_razonSocial:string;
contactoTurno_telefonoCelular:string;
contactoTurno_email:string;
contactoTurno_fechaNacimiento:string;


 datosPersonales_genero:string;
datosPersonales_tipoDocumento:string;
datosPersonales_numeroDocumento:string;
datosPersonales_numeroCuit:string;
datosPersonales_nombre:string;
datosPersonales_apellido:string;
datosPersonales_razonSocial:string;
datosFacturacion_domicilio:string;
domicilio_calle:string;
domicilio_numero:string;
domicilio_piso:string;
domicilio_departamento:string;
domicilio_localidad :string;
domicilio_provinciaID :string;
domicilio_provincia :string;
domicilio_codigoPostal:string;
datosFacturacion_condicionIva:string;
datosFacturacion_numeroIibb:string;

datosPago_pagoID:string;
datosPago_gatewayID:string;
datosPago_entidadID:string;
datosPago_entidadNombre:string;
datosPago_fechaPago:string;
datosPago_importeTotal:string;

detallesPagoVerificacion_pagoID:string;
detallesPagoVerificacion_importe:string;
detallesPagoVerificacion_estadoAcreditacion:string;
detallesPagoVerificacion_pagoGatewayID:string;

detallesPagoOblea_pagoID:string;
detallesPagoOblea_importe:string;
detallesPagoOblea_estadoAcreditacion:string;

datosVehiculo_dominio:string;
datosVehiculo_marcaID:string;
datosVehiculo_marca:string;
datosVehiculo_tipoID:string;
datosVehiculo_tipo:string;
datosVehiculo_modeloID:string;
datosVehiculo_modelo:string;
numeroChasis_marca:string;
numeroChasis_numero:string;
datosVehiculo_anio:string;
datosVehiculo_jurisdiccionID:string;
datosVehiculo_jurisdiccion:string;
datosVehiculo_mtm:string;
datosVehiculo_valTitular:string;
datosVehiculo_valChasis:string;
datosValidados_marcaID:string;
datosValidados_marca:string;
datosValidados_tipoID:string;
datosValidados_tipo:string;
datosValidados_modeloID:string;
datosValidados_modelo:string;


datosValidados_mtm:string;


entro:boolean;
begin
assignfile(archi,ExtractFilePath(Application.ExeName) + 'archivoparseado.txt');
reset(archi);
leyo:=0;
cantidad:=-1;
entro:=false;
linea:='';
while (not eof(archi)) or (trim(linea)='**FIN**') do
begin
 readln(archi,linea);

if  trim(linea)='****999****' then
begin
leyo:=leyo + 1;
  showmessage('guarda base '+inttostr(leyo)+'   '+turnoID);

end;




   if trim(es_linea(linea))=trim(es_linea('return_respuestaID')) then
      respuestaID:=trim(extrae_valor(trim(linea)));


  
 if trim(es_linea(linea))=trim(es_linea('return_respuestaMensaje')) then
  begin
       respuestaMensaje:=trim(extrae_valor(trim(linea)));

    if trim(respuestaID)<>'1' then
       break;



  end;



     if trim(es_linea(linea))=trim(es_linea('return_cantidadTurnos')) then
         begin
            cantidad:=strtoint(trim(extrae_valor(trim(linea))));

            if cantidad = 0 then
               break;


     end;





       if trim(es_linea(linea))=trim(es_linea('datosTurno_turnoID')) then
           turnoID:=trim(extrae_valor(trim(linea)));


       if trim(es_linea(linea))=trim(es_linea('datosTurno_estadoID')) then
           estadoID:=trim(extrae_valor(trim(linea)));


       if trim(es_linea(linea))=trim(es_linea('datosTurno_estado')) then
             estado:=trim(extrae_valor(trim(linea)));


       if trim(es_linea(linea))=trim(es_linea('datosTurno_tipoTurno')) then
               tipoTurno:=trim(extrae_valor(trim(linea)));



       if trim(es_linea(linea))=trim(es_linea('datosTurno_fechaTurno')) then
           fechaTurno:=trim(extrae_valor(trim(linea)));


       if trim(es_linea(linea))=trim(es_linea('datosTurno_horaTurno')) then
           horaTurno:=trim(extrae_valor(trim(linea)));


      if trim(es_linea(linea))=trim(es_linea('datosTurno_fechaRegistro')) then
           fechaRegistro:=trim(extrae_valor(trim(linea)));


        if trim(es_linea(linea))=trim(es_linea('datosTurno_fechaNovedad')) then
           fechaNovedad:=trim(extrae_valor(trim(linea)));


       if trim(es_linea(linea))=trim(es_linea('datosTurno_plantaID')) then
           plantaID:=trim(extrae_valor(trim(linea)));

         {turno relacionado}
            if trim(es_linea(linea))=trim(es_linea('datosTurno_turnosRelacionados')) then
                   begin
                        readln(archi,linea);
                        while trim(linea)<>'****000****' do
                        begin
                             if trim(es_linea(linea))=trim(es_linea('item_turnoID')) then
                                re_item_turnoID:=trim(extrae_valor(trim(linea)));

                             if trim(es_linea(linea))=trim(es_linea('item_plantaID')) then
                                re_item_plantaID:=trim(extrae_valor(trim(linea)));

                             if trim(es_linea(linea))=trim(es_linea('item_estado')) then
                                re_item_estado:=trim(extrae_valor(trim(linea)));

                            if trim(es_linea(linea))=trim(es_linea('item_fechaNovedad')) then
                                re_item_fechaNovedad:=trim(extrae_valor(trim(linea)));

                            if trim(es_linea(linea))=trim(es_linea('datosPago_pagoID')) then
                                re_datosPago_pagoID:=trim(extrae_valor(trim(linea)));


                            if trim(es_linea(linea))=trim(es_linea('datosPago_entidadID')) then
                                re_datosPago_entidadID:=trim(extrae_valor(trim(linea)));


                             if trim(es_linea(linea))=trim(es_linea('datosPago_fechaPago')) then
                                re_datosPago_fechaPago:=trim(extrae_valor(trim(linea)));


                             if trim(es_linea(linea))=trim(es_linea('datosPago_importeTotal')) then
                                re_datosPago_importeTotal:=trim(extrae_valor(trim(linea)));


                             if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_pagoID')) then
                                re_detallesPagoVerificacion_pagoID:=trim(extrae_valor(trim(linea)));


                            
                             if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_importe')) then
                                re_detallesPagoVerificacion_importe:=trim(extrae_valor(trim(linea)));

                               if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_estadoAcreditacion')) then
                                re_detallesPagoVerificacion_estadoAcreditacion:=trim(extrae_valor(trim(linea)));

                             if trim(es_linea(linea))=trim(es_linea('detallesPagoOblea_pagoID')) then
                                re_detallesPagoOblea_pagoID:=trim(extrae_valor(trim(linea)));

                             if trim(es_linea(linea))=trim(es_linea('detallesPagoOblea_importe')) then
                                re_detallesPagoOblea_importe:=trim(extrae_valor(trim(linea)));

                              if trim(es_linea(linea))=trim(es_linea('detallesPagoOblea_estadoAcreditacion')) then
                                re_detallesPagoOblea_estadoAcreditacion:=trim(extrae_valor(trim(linea)));




                            readln(archi, linea);
                        end;





                   end;


         {fin turno relacionado}


        {titula}
       if trim(es_linea(linea))=trim(es_linea('datosTitular_genero')) then
           datosTitular_genero:=trim(extrae_valor(trim(linea)));

        if trim(es_linea(linea))=trim(es_linea('datosTitular_tipoDocumento')) then
           datosTitular_tipoDocumento:=trim(extrae_valor(trim(linea)));

       if trim(es_linea(linea))=trim(es_linea('datosTitular_numeroDocumento')) then
           datosTitular_numeroDocumento:=trim(extrae_valor(trim(linea)));


        if trim(es_linea(linea))=trim(es_linea('datosTitular_numeroCuit')) then
           datosTitular_numeroCuit:=trim(extrae_valor(trim(linea)));

        if trim(es_linea(linea))=trim(es_linea('datosTitular_nombre')) then
           datosTitular_nombre:=trim(extrae_valor(trim(linea)));


       if trim(es_linea(linea))=trim(es_linea('datosTitular_apellido')) then
           datosTitular_apellido:=trim(extrae_valor(trim(linea)));

       if trim(es_linea(linea))=trim(es_linea('datosTitular_razonSocial')) then
           datosTitular_razonSocial:=trim(extrae_valor(trim(linea)));


        {datos personales}

       if trim(es_linea(linea))=trim(es_linea('datosPersonalesTurno_tipoDocumento')) then
           datosPersonalesTurno_tipoDocumento:=trim(extrae_valor(trim(linea)));



         if trim(es_linea(linea))=trim(es_linea('datosPersonalesTurno_numeroCuit')) then
           datosPersonalesTurno_numeroCuit:=trim(extrae_valor(trim(linea)));



       if trim(es_linea(linea))=trim(es_linea('datosPersonalesTurno_nombre')) then
           datosPersonalesTurno_nombre:=trim(extrae_valor(trim(linea)));


         if trim(es_linea(linea))=trim(es_linea('datosPersonalesTurno_apellido')) then
           datosPersonalesTurno_apellido:=trim(extrae_valor(trim(linea)));

      
         if trim(es_linea(linea))=trim(es_linea('datosPersonalesTurno_razonSocial')) then
           datosPersonalesTurno_razonSocial:=trim(extrae_valor(trim(linea)));




          {datos contactos}
        if trim(es_linea(linea))=trim(es_linea('contactoTurno_telefonoCelular')) then
           contactoTurno_telefonoCelular:=trim(extrae_valor(trim(linea)));


      if trim(es_linea(linea))=trim(es_linea('contactoTurno_email')) then
           contactoTurno_email:=trim(extrae_valor(trim(linea)));

       if trim(es_linea(linea))=trim(es_linea('contactoTurno_fechaNacimiento')) then
           contactoTurno_fechaNacimiento:=trim(extrae_valor(trim(linea)));


        {datos facturacion}
       if trim(es_linea(linea))=trim(es_linea('datosPersonales_genero')) then
           datosPersonales_genero:=trim(extrae_valor(trim(linea)));


         if trim(es_linea(linea))=trim(es_linea('datosPersonales_tipoDocumento')) then
           datosPersonales_tipoDocumento:=trim(extrae_valor(trim(linea)));


       if trim(es_linea(linea))=trim(es_linea('datosPersonales_numeroDocumento')) then
           datosPersonales_numeroDocumento:=trim(extrae_valor(trim(linea)));




   if trim(es_linea(linea))=trim(es_linea('datosPersonales_numeroCuit')) then
           datosPersonales_numeroCuit:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPersonales_nombre')) then
           datosPersonales_nombre:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPersonales_apellido')) then
           datosPersonales_apellido:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPersonales_razonSocial')) then
           datosPersonales_razonSocial:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosFacturacion_domicilio')) then
           datosFacturacion_domicilio:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('domicilio_calle')) then
           domicilio_calle:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('domicilio_numero')) then
           domicilio_numero:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('domicilio_piso')) then
           domicilio_piso:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('domicilio_departamento')) then
           domicilio_departamento:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('domicilio_localidad')) then
           domicilio_localidad:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('domicilio_provinciaID')) then
           domicilio_provinciaID:=trim(extrae_valor(trim(linea)));


   if trim(es_linea(linea))=trim(es_linea('domicilio_provincia')) then
           domicilio_provincia:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('domicilio_codigoPostal')) then
           domicilio_codigoPostal:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosFacturacion_condicionIva')) then
           datosFacturacion_condicionIva:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosFacturacion_numeroIibb')) then
           datosFacturacion_numeroIibb:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPago_pagoID')) then
           datosPago_pagoID:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPago_gatewayID')) then
           datosPago_gatewayID:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPago_entidadID')) then
           datosPago_entidadID:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPago_entidadNombre')) then
           datosPago_entidadNombre:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPago_fechaPago')) then
           datosPago_fechaPago:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('datosPago_importeTotal')) then
           datosPago_importeTotal:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_pagoID')) then
           detallesPagoVerificacion_pagoID:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_importe')) then
           detallesPagoVerificacion_importe:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_estadoAcreditacion')) then
           detallesPagoVerificacion_estadoAcreditacion:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('detallesPagoVerificacion_pagoGatewayID')) then
           detallesPagoVerificacion_pagoGatewayID:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('detallesPagoOblea_pagoID')) then
           detallesPagoOblea_pagoID:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('detallesPagoOblea_importe')) then
           detallesPagoOblea_importe:=trim(extrae_valor(trim(linea)));



   if trim(es_linea(linea))=trim(es_linea('detallesPagoOblea_estadoAcreditacion')) then
           detallesPagoOblea_estadoAcreditacion:=trim(extrae_valor(trim(linea)));


           

      {vehiculo}




  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_dominio')) then
           datosVehiculo_dominio:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_marcaID')) then
           datosVehiculo_marcaID:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_marca')) then
           datosVehiculo_marca:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_tipoID')) then
           datosVehiculo_tipoID:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_tipo')) then
           datosVehiculo_tipo:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_modeloID')) then
           datosVehiculo_modeloID:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_modelo')) then
           datosVehiculo_modelo:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('numeroChasis_marca')) then
           numeroChasis_marca:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('numeroChasis_numero')) then
           numeroChasis_numero:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_anio')) then
           datosVehiculo_anio:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_jurisdiccionID')) then
           datosVehiculo_jurisdiccionID:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_jurisdiccion')) then
           datosVehiculo_jurisdiccion:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_mtm')) then
           datosVehiculo_mtm:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_valTitular')) then
           datosVehiculo_valTitular:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosVehiculo_valChasis')) then
           datosVehiculo_valChasis:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosValidados_marcaID')) then
           datosValidados_marcaID:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosValidados_marca')) then
           datosValidados_marca:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosValidados_tipoID')) then
           datosValidados_tipoID:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosValidados_tipo')) then
           datosValidados_tipo:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosValidados_modeloID')) then
           datosValidados_modeloID:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosValidados_modelo')) then
           datosValidados_modelo:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('numeroChasis_marca')) then
           numeroChasis_marca:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('numeroChasis_numero')) then
           numeroChasis_numero:=trim(extrae_valor(trim(linea)));



  if trim(es_linea(linea))=trim(es_linea('datosValidados_mtm')) then
           datosValidados_mtm:=trim(extrae_valor(trim(linea)));







 end;  //while






end;


procedure TForm1.COPIAR_HISTORIAL_TMPDATODEFECIM;
VAR aqDTURNOS:tsqlquery;
CODINSPE:LONGINT;
BEGIN
aqDTURNOS:=tsqlquery.create(nil);
aqDTURNOS.SQLConnection := MyBD;
aqDTURNOS.Close;
aqDTURNOS.SQL.Clear;
aqDTURNOS.SQL.Add('SELECT Min(CODINSPE) FROM TINSPECCION WHERE FECHALTA = SYSDATE');
aqDTURNOS.ExecSQL;
aqDTURNOS.Open;
CODINSPE:= aqDTURNOS.Fields[0].AsInteger;
aqDTURNOS.Close;
aqDTURNOS.Free;



 MYBD.StartTransaction(TD);
 TRY

aqDTURNOS:=tsqlquery.create(nil);
aqDTURNOS.SQLConnection := MyBD;
aqDTURNOS.Close;
aqDTURNOS.SQL.Clear;
aqDTURNOS.SQL.Add(' INSERT INTO  TMPDATODEFECIMHISTORIAL '+
                  ' SELECT * FROM TMPDATODEFECIM '+
                  ' WHERE CODINSPE >='+INTTOSTR(CODINSPE));
aqDTURNOS.ExecSQL;

MYBD.Commit(TD);
EXCEPT
MYBD.Rollback(TD);
END;
aqDTURNOS.Close;
aqDTURNOS.Free;


   MYBD.StartTransaction(TD);
 TRY

aqDTURNOS:=tsqlquery.create(nil);
aqDTURNOS.SQLConnection := MyBD;
aqDTURNOS.Close;
aqDTURNOS.SQL.Clear;
aqDTURNOS.SQL.Add(' DELETE  FROM TMPDATODEFECIM '+
                  ' WHERE CODINSPE >='+INTTOSTR(CODINSPE));
aqDTURNOS.ExecSQL;

MYBD.Commit(TD);
EXCEPT
MYBD.Rollback(TD);
END;
aqDTURNOS.Close;
aqDTURNOS.Free;



END;




procedure TForm1.COPIAR_HISTORIAL_TURNOS;
VAR aqDTURNOS,aqexsiste,aqguadar:tsqlquery;
turnodi, estadoid:longint;  estadodesc:string;

BEGIN

aqDTURNOS:=tsqlquery.create(nil);
aqDTURNOS.SQLConnection := MyBD;
aqDTURNOS.Close;
aqDTURNOS.SQL.Clear;
aqDTURNOS.SQL.Add(' SELECT turnoid, estadoid, estadodesc FROM TDATOSTURNO '+
                  ' WHERE TO_CHAR(FECHATURNO,''DD/MM/YYYY'') = to_char(SYSDATE-1,''DD/MM/YYYY'') ');
aqDTURNOS.ExecSQL;
aqDTURNOS.Open;
while not aqDTURNOS.Eof do
begin
   turnodi:=aqDTURNOS.fieldbyname('turnoid').AsInteger;
   estadoid:=aqDTURNOS.fieldbyname('estadoid').AsInteger;
   estadodesc:=trim(aqDTURNOS.fieldbyname('estadodesc').AsString);


   aqexsiste:=tsqlquery.create(nil);
   aqexsiste.SQLConnection := MyBD;
   aqexsiste.Close;
   aqexsiste.SQL.Clear;
   aqexsiste.SQL.Add(' SELECT turnoid, estadoid FROM TDATOSTURNOHISTORIAL '+
                  ' WHERE turnoid='+inttostr(turnodi));
  aqexsiste.ExecSQL;
  aqexsiste.Open;
   if aqexsiste.IsEmpty=true then
       begin

          MYBD.StartTransaction(TD);
         TRY

            aqguadar:=tsqlquery.create(nil);
            aqguadar.SQLConnection := MyBD;
            aqguadar.Close;
            aqguadar.SQL.Clear;
            aqguadar.SQL.Add(' INSERT INTO  TDATOSTURNOHISTORIAL '+
                  ' SELECT * FROM TDATOSTURNO '+
                  ' WHERE turnoid='+inttostr(turnodi));
            aqguadar.ExecSQL;
           MYBD.Commit(TD);
           EXCEPT
         MYBD.Rollback(TD);
        END;
        aqguadar.Close;
        aqguadar.free;
    end else begin

         MYBD.StartTransaction(TD);
         TRY

            aqguadar:=tsqlquery.create(nil);
            aqguadar.SQLConnection := MyBD;
            aqguadar.Close;
            aqguadar.SQL.Clear;
            aqguadar.SQL.Add(' update TDATOSTURNOHISTORIAL '+
                  'set estadoid='+inttostr(estadoid)+', estadodesc='+#39+trim(estadodesc)+#39+
                  '  WHERE turnoid='+inttostr(turnodi));
            aqguadar.ExecSQL;
           MYBD.Commit(TD);
           EXCEPT
         MYBD.Rollback(TD);
        END;
        aqguadar.Close;
        aqguadar.free;

    end;

    aqexsiste.Close;
    aqexsiste.Free;



    aqDTURNOS.Next;
end;





aqDTURNOS.Close;
aqDTURNOS.Free;
END;



procedure TForm1.BORRAR_TURNOS_SYSDATE_30;
VAR aqDTURNOS:tsqlquery;

BEGIN

 MYBD.StartTransaction(TD);
 TRY

aqDTURNOS:=tsqlquery.create(nil);
aqDTURNOS.SQLConnection := MyBD;
aqDTURNOS.Close;
aqDTURNOS.SQL.Clear;
aqDTURNOS.SQL.Add('DELETE FROM TDATOSTURNO '+
                  ' WHERE TO_CHAR(FECHATURNO,''DD/MM/YYYY'') = to_char(SYSDATE-1,''DD/MM/YYYY'') ');
aqDTURNOS.ExecSQL;

MYBD.Commit(TD);
EXCEPT
MYBD.Rollback(TD);
END;
aqDTURNOS.Close;
aqDTURNOS.Free;
END;

procedure TForm1.Button10Click(Sender: TObject);
var
  xml: IXMLDOMDocument;
  node: IXMLDomNode;
  nodes_row, nodes_se: IXMLDomNodeList;
  i, j: Integer;
  url: string;
begin
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);



 TX.CONFIGURAR;



SERVICIO_FACTURA_ELECTRONICA;
memo1.Lines.Add('PROCESO TERMINADO...');
mybd.Close;
  tx.Free;
end;

procedure TForm1.Button11Click(Sender: TObject);
var tx:txml_caba;
v:string;
begin
v:=ExtractFilePath(Application.ExeName) + 'CONSULTA25643.xml';
tx:=txml_caba.Create;
TX.CONSULTA('N','21/10/2016','21/10/2016',0);
tx.Free;

end;

PROCEDURE TFORM1.PROCEDIMIENTO_CONTROL_DE_PAGOS;
VAR aqDTURNOS,aq:tsqlquery;
IDPAGOVERIFICACION,FE:STRING;
BEGIN
FE:=DATETOSTR(DATE);

{descarga_pago_del_turno}
aqDTURNOS:=tsqlquery.create(nil);
aqDTURNOS.SQLConnection := MyBD;
aqDTURNOS.Close;
aqDTURNOS.SQL.Clear;
aqDTURNOS.SQL.Add('select PAGOIDVERIFICACION from TDATOSTURNO WHERE FECHATURNO=TO_DATE('+#39+TRIM(FE)+#39+',''DD/MM/YYYY'')');
aqDTURNOS.ExecSQL;
aqDTURNOS.Open ;
WHILE NOT aqDTURNOS.Eof DO
BEGIN

IDPAGOVERIFICACION:=TRIM(aqDTURNOS.FIELDBYNAME('PAGOIDVERIFICACION').AsString);
       if trim(IDPAGOVERIFICACION)<>'' then
       begin
         aq:=tsqlquery.create(nil);
      aq.SQLConnection := MyBD;
      aq.Close;
      aq.SQL.Clear;
      aq.SQL.Add('select * from tdetallespago where pagoid='+inttostr(strtoint(IDPAGOVERIFICACION)));
      aq.ExecSQL;
      aq.Open;
      if aq.IsEmpty then
      begin
       
         TX.CONFIGURAR;
         TX.ControlServidor;
          IF TX.ver_respuestaidservidor=1 THEN
             BEGIN
                 IF trim(TX.ver_disponibilidad_servidor)='true' then
                    BEGIN
                     TX.Abrir_Seccion;
                      IF  TX.ver_respuestaid_Abrir=1 THEN
                          BEGIN

                            TX.DESCARGAR_PAGOS_POR_CODIGO_PAGO(strtoint(trim(IDPAGOVERIFICACION)),0);

                              if TX.ver_respuestaidpago=1 then
                                  begin
                                     IF STRTOINT(TX.ver_cantidadPagos) > 0 THEN
                                         begin
                                         TX.PROCESARARCHIVOPAGOS(TX.VER_ARCHIVOS_XML_PAGOS);
                                         end;

                                    end;



                           end;



                      end;
               end;


         end;
         aq.Close;
        aq.Free;

  end;


aqDTURNOS.Next;
END;
 aqDTURNOS.Close;
 aqDTURNOS.Free;
END;


FUNCTION TForm1.INICIAR_DESCARGA_DIA:BOOLEAN;
//var tx:txml_caba;
var fd,fh,hora_desde,hora_hasta:string;  i:longint;
begin
MEMO1.Clear;
MEMO1.Lines.Add('INICIO DEL DIA: '+DATETOSTR(DATE)+' '+TIMETOSTR(TIME));

//tx:=txml_caba.Create;
//tf.TestOfBD('', '', '' ,false);
TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN
           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('DESCARGANDO...');

               for i:=1 to 15 do
                begin
                  if i=1 then
                     begin
                       hora_desde:='06:00:00';
                       hora_hasta:='07:00:00';
                     end;

                  if i=2 then
                    begin
                      hora_desde:='07:00:01';
                      hora_hasta:='08:00:00';
                    end;
                  if i=3 then
                  begin
                   hora_desde:='08:00:01';
                   hora_hasta:='09:00:00';

                  end;

               if i=4 then
                begin
                  hora_desde:='09:00:01';
                  hora_hasta:='10:00:00';

                end;


                   if i=5 then
                begin
                  hora_desde:='10:00:01';
                  hora_hasta:='11:00:00';

                end;

                if i=6 then
                begin
                  hora_desde:='11:00:01';
                  hora_hasta:='12:00:00';

                end;

                   if i=7 then
                begin
                  hora_desde:='11:00:01';
                  hora_hasta:='12:00:00';

                end;

                   if i=8 then
                begin
                  hora_desde:='12:00:01';
                  hora_hasta:='13:00:00';

                end;

                   if i=9 then
                begin
                  hora_desde:='13:00:01';
                  hora_hasta:='14:00:00';

                end;

                   if i=10 then
                begin
                  hora_desde:='14:00:01';
                  hora_hasta:='15:00:00';

                end;

                   if i=11 then
                begin
                  hora_desde:='15:00:01';
                  hora_hasta:='16:00:00';

                end;

                   if i=12 then
                begin
                  hora_desde:='16:00:01';
                  hora_hasta:='17:00:00';

                end;

                   if i=13 then
                begin
                  hora_desde:='17:00:01';
                  hora_hasta:='18:00:00';

                end;


                   if i=14 then
                begin
                  hora_desde:='18:00:01';
                  hora_hasta:='19:00:00';

                end;

                       if i=15 then
                begin
                  hora_desde:='19:00:01';
                  hora_hasta:='20:00:00';

                end;

                fd:=copy(DATETOSTR(DATE),7,4)+'-'+copy(DATETOSTR(DATE),4,2)+'-'+copy(DATETOSTR(DATE),1,2)+' '+hora_desde;
                fh:=copy(DATETOSTR(DATE),7,4)+'-'+copy(DATETOSTR(DATE),4,2)+'-'+copy(DATETOSTR(DATE),1,2)+' '+hora_hasta;

                MEMO1.Lines.Add('DESCARGANDO HORARIO: '+hora_desde+' - '+hora_hasta);
                APPLICATION.ProcessMessages;
               TX.CONSULTA('FT',trim(fd),trim(fh),I);


            end;
                MEMO1.Clear;
               MEMO1.Lines.Add('ARREGLA CLIENTE CERO...');
               APPLICATION.ProcessMessages;
            //  Arregla_codcliente_cero;


               MEMO1.Clear;
               MEMO1.Lines.Add('ESPERANDO CONEXION...');
              END;



         END else
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');






  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
  END;




   TX.Cerrar_seccion;


 END;






FUNCTION TForm1.INICIAR_DESCARGA_DIA_fecha(fecha:string):BOOLEAN;
//var tx:txml_caba;
var fd,fh,hora_desde,hora_hasta:string;  i:longint;
begin
MEMO1.Clear;
MEMO1.Lines.Add('INICIO DEL DIA: '+DATETOSTR(DATE)+' '+TIMETOSTR(TIME));

//tx:=txml_caba.Create;
//tf.TestOfBD('', '', '' ,false);
TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN
           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('DESCARGANDO...');

               for i:=1 to 15 do
                begin
                  if i=1 then
                     begin
                       hora_desde:='06:00:00';
                       hora_hasta:='07:00:00';
                     end;

                  if i=2 then
                    begin
                      hora_desde:='07:00:01';
                      hora_hasta:='08:00:00';
                    end;
                  if i=3 then
                  begin
                   hora_desde:='08:00:01';
                   hora_hasta:='09:00:00';

                  end;

               if i=4 then
                begin
                  hora_desde:='09:00:01';
                  hora_hasta:='10:00:00';

                end;


                   if i=5 then
                begin
                  hora_desde:='10:00:01';
                  hora_hasta:='11:00:00';

                end;

                if i=6 then
                begin
                  hora_desde:='11:00:01';
                  hora_hasta:='12:00:00';

                end;

                   if i=7 then
                begin
                  hora_desde:='11:00:01';
                  hora_hasta:='12:00:00';

                end;

                   if i=8 then
                begin
                  hora_desde:='12:00:01';
                  hora_hasta:='13:00:00';

                end;

                   if i=9 then
                begin
                  hora_desde:='13:00:01';
                  hora_hasta:='14:00:00';

                end;

                   if i=10 then
                begin
                  hora_desde:='14:00:01';
                  hora_hasta:='15:00:00';

                end;

                   if i=11 then
                begin
                  hora_desde:='15:00:01';
                  hora_hasta:='16:00:00';

                end;

                   if i=12 then
                begin
                  hora_desde:='16:00:01';
                  hora_hasta:='17:00:00';

                end;

                   if i=13 then
                begin
                  hora_desde:='17:00:01';
                  hora_hasta:='18:00:00';

                end;


                   if i=14 then
                begin
                  hora_desde:='18:00:01';
                  hora_hasta:='19:00:00';

                end;

                       if i=15 then
                begin
                  hora_desde:='19:00:01';
                  hora_hasta:='20:00:00';

                end;

                fd:=copy(trim(fecha),7,4)+'-'+copy(trim(fecha),4,2)+'-'+copy(trim(fecha),1,2)+' '+hora_desde;
                fh:=copy(trim(fecha),7,4)+'-'+copy(trim(fecha),4,2)+'-'+copy(trim(fecha),1,2)+' '+hora_hasta;

                MEMO1.Lines.Add('DESCARGANDO HORARIO: '+hora_desde+' - '+hora_hasta);
                APPLICATION.ProcessMessages;
               TX.CONSULTA('FT',trim(fd),trim(fh),I);


            end;
                MEMO1.Clear;
               MEMO1.Lines.Add('ARREGLA CLIENTE CERO...');
               APPLICATION.ProcessMessages;
            //  Arregla_codcliente_cero;


               MEMO1.Clear;
               MEMO1.Lines.Add('ESPERANDO CONEXION...');
              END;



         END else
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');






  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
  END;




   TX.Cerrar_seccion;


 END;

FUNCTION TForm1.EnviarMensaje_control(sDestino,hora,asunto,mensajea,sAdjunto,NPLANTA:STRING):BOOLEAN;
var SMTP: TIdSMTP;
   Mensaje: TIdMessage;   SIGUE:BOOLEAN;
   Adjunto: TIdAttachment;
    sUsuario, sClave, sHost,FROM_NAME,FROM_ADDRES,  sAsunto,  sMensaje,SPUERTO: String ;
begin
EnviarMensaje_control:=TRUE;

sAsunto:=asunto;
sMensaje:=mensajea;

 IF NPLANTA='3' THEN
 NPLANTA:='VELEZ SARFIELD';

 IF NPLANTA='4' THEN
 NPLANTA:='SANTA MARIA';

SIGUE:=TRUE;
sUsuario:='factura.electronica@applus.com.ar';
sClave:='Applus01$';
sHost:='mail.applus.com.ar';
SPUERTO:='25';
FROM_NAME:='CONTROL XML :'+NPLANTA;
FROM_ADDRES:='factura.electronica@applus.com.ar';

  // Creamos el componente de conexi�n con el servidor
  SMTP := TIdSMTP.Create( nil );
  SMTP.Username := sUsuario;//'factura.electronica@applus.com.ar';
  SMTP.Password := sClave;//Applus01$
  SMTP.Host := sHost;//'mail.applus.com.ar'
  SMTP.Port :=STRTOINT(SPUERTO);
  SMTP.AuthenticationType := atLogin;


  // Creamos el contenido del mensaje
  Mensaje := TIdMessage.Create( nil );
  Mensaje.Clear;
  Mensaje.From.Name := FROM_NAME;
  Mensaje.From.Address :=FROM_ADDRES;
  Mensaje.Subject := sAsunto;
  Mensaje.Body.Text := sMensaje;
  Mensaje.Recipients.Add;
  Mensaje.Recipients.Items[0].Address := sDestino;

  // Si hay que meter un archivo adjunto lo creamos y lo asignamos al mensaje
  if sAdjunto <> '' then
  begin
    if FileExists( sAdjunto ) then
      Adjunto := TIdAttachment.Create( Mensaje.MessageParts, sAdjunto );
  end
  else
    Adjunto := nil;

  // Conectamos con el servidor SMTP
  try
    SMTP.Connect;
  except
    BEGIN
    SIGUE:=FALSe;

     EnviarMensaje_control:=FALSE;
    end;
  END;

  // Si ha conectado enviamos el mensaje y desconectamos
  if SMTP.Connected then
  begin
    try
      SMTP.Send( Mensaje );
    except
        BEGIN

           SIGUE:=FALSe;
           EnviarMensaje_control:=FALSE;
        END;

    end;

    try
      SMTP.Disconnect;
    except
    BEGIN
     SIGUE:=FALSe;

      EnviarMensaje_control:=FALSE;
    end;
    END;
  end;

  // Liberamos los objetos creados
  if Adjunto <> nil then
    FreeAndNil( Adjunto );

  FreeAndNil( Mensaje );
  FreeAndNil( SMTP );
  IF SIGUE=TRUE THEN
   BEGIN

    EnviarMensaje_control:=TRUE;
   END;
 EnviarMensaje_control:=SIGUE;
end;


FUNCTION TForm1.INFORMAR_LOS_AUSENTES_DEL_DIA:BOOLEAN;
//var tx:txml_caba;
var fd,fh,hora_desde,hora_hasta:string;  i:longint;
begin
MEMO1.Clear;
MEMO1.Lines.Add('INICIO DESCARGA DE NOVEDADES '+DATETOSTR(DATE)+' '+TIMETOSTR(TIME));

//tx:=txml_caba.Create;
//tf.TestOfBD('', '', '' ,false);
TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN
           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('INFORMANDO AUSENTES DEL DIA..');



               IF   TX.informar_ausentes=TRUE THEN
                    BEGIN
                        if fileexists(ExtractFilePath(Application.ExeName) +'informarausentes.xml') then
                           begin
                             if TX.generar_archivo('informarausentes')=true then
                                begin
                                TX.leer_respuesta_ausentes(ExtractFilePath(Application.ExeName)+'informarausentes.txt');
                                EnviarMensaje_control('martin.bien@applus.com',TIMETOSTR(TIME),'INFORME DE AUSENTES: '+inttostr(TX.ver_PLANTA),'RESPUESTA INFORME AUSENTES',ExtractFilePath(Application.ExeName) +'informarausentes.xml',TX.ver_plantaID);
                                 end;

                            end;

                    END;







               MEMO1.Clear;
               MEMO1.Lines.Add('ESPERANDO CONEXION...');
              END;



         END else
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');






  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
  END;




   TX.Cerrar_seccion;


 END;

  
FUNCTION TForm1.INFORMAR_LOS_TODOS_AUCENTES:BOOLEAN;
//var tx:txml_caba;
var fd,fh,hora_desde,hora_hasta:string;  i:longint;
begin
MEMO1.Clear;

//tx:=txml_caba.Create;
//tf.TestOfBD('', '', '' ,false);
TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN
           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('INFORMANDO AUSENTES DEL DIA..');



               IF   TX.informar_ausentes=TRUE THEN
                    BEGIN
                        if fileexists(ExtractFilePath(Application.ExeName) +'informarausentes.xml') then
                           begin
                             if TX.generar_archivo('informarausentes')=true then
                                begin
                                TX.leer_respuesta_ausentes(ExtractFilePath(Application.ExeName)+'informarausentes.txt');
                                EnviarMensaje_control('martin.bien@applus.com',TIMETOSTR(TIME),'INFORME DE AUSENTES: '+inttostr(TX.ver_PLANTA),'RESPUESTA INFORME AUSENTES',ExtractFilePath(Application.ExeName) +'informarausentes.xml',TX.ver_plantaID);
                                 end;

                            end;

                    END;







               MEMO1.Clear;
               MEMO1.Lines.Add('ESPERANDO CONEXION...');
              END;



         END else
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');






  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
  END;




   TX.Cerrar_seccion;


 END;



FUNCTION TForm1.INFORMAR_TURNO_COMO_AUSENTE(IDT:LONGINT;TABLA:STRING):BOOLEAN;
//var tx:txml_caba;
var fd,fh,hora_desde,hora_hasta:string;  i:longint;
begin
MEMO1.Clear;

//tx:=txml_caba.Create;
//tf.TestOfBD('', '', '' ,false);
TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN
           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('INFORMANDO TURNO COMO AUSENTE..');



               IF   TX.informar_ausentes_TURNO_INDVI_faltante(IDT,TABLA)=TRUE THEN
                    BEGIN
                        if fileexists(ExtractFilePath(Application.ExeName) +'informarausentes.xml') then
                           begin
                             if TX.generar_archivo('informarausentes')=true then
                                begin
                                TX.leer_respuesta_ausentes_turnoid(IDT,ExtractFilePath(Application.ExeName)+'informarausentes.txt',TABLA);
                               // EnviarMensaje_control('martin.bien@applus.com',TIMETOSTR(TIME),'INFORME DE AUSENTES: '+inttostr(TX.ver_PLANTA),'RESPUESTA INFORME AUSENTES',ExtractFilePath(Application.ExeName) +'informarausentes.xml',TX.ver_plantaID);
                                 end;

                            end;

                    END;







               MEMO1.Clear;
               MEMO1.Lines.Add('ESPERANDO CONEXION...');
              END;



         END else
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');






  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
  END;




   TX.Cerrar_seccion;


 END;



 FUNCTION TForm1.ACTUALIZA_TURNO_DEL_DIA;
 BEGIN
 MEMO1.Clear;
MEMO1.Lines.Add('INICIO DESCARGA DE TURNOS DEL D�A '+DATETOSTR(DATE));

//tx:=txml_caba.Create;
//tf.TestOfBD('', '', '' ,false);
TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN
           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('DESCARGANDO...');
               TX.CONSULTA('N','-','-',0);
               MEMO1.Clear;
               MEMO1.Lines.Add('ESPERANDO CONEXION...');
              END;



         END else
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');






  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
  END;








 END;

  function TFORM1.exiete_idpago_en_tfactura(pagoidverificacion:longint):boolean;
var aqfact:tsqlquery;
EXITE:BOOLEAN;
begin

exiete_idpago_en_tfactura:=FALSE;
    aqfact:=tsqlquery.create(nil);
    aqfact.SQLConnection := MyBD;
    aqfact.sql.add('SELECT * FROM TFACTURAS WHERE  idpago='+inttostr(pagoidverificacion));
    aqfact.ExecSQL;
    aqfact.open;
    if not aqfact.IsEmpty then
       exiete_idpago_en_tfactura:=true
       else
       exiete_idpago_en_tfactura:=false;


    aqfact.Close;
    aqfact.Free;



end;


  function TFORM1.exiete_idpago_en_tfactura_PARANC(pagoidverificacion:longint):boolean;
var aqfact:tsqlquery;
EXITE:BOOLEAN;
begin

exiete_idpago_en_tfactura_PARANC:=FALSE;
    aqfact:=tsqlquery.create(nil);
    aqfact.SQLConnection := MyBD;
    aqfact.sql.add('SELECT * FROM TFACTURAS WHERE  idpago='+inttostr(pagoidverificacion)+' and codcofac is null');
    aqfact.ExecSQL;
    aqfact.open;
    if not aqfact.IsEmpty then
       exiete_idpago_en_tfactura_PARANC:=true
       else
       exiete_idpago_en_tfactura_PARANC:=false;


    aqfact.Close;
    aqfact.Free;



end;

     function TFORM1.ES_RELACIONADO_HIJO(IDDETURNO:longint):boolean;
var aqfact:tsqlquery;
EXITE:BOOLEAN;
begin

ES_RELACIONADO_HIJO:=FALSE;
    aqfact:=tsqlquery.create(nil);
    aqfact.SQLConnection := MyBD;
    aqfact.sql.add('SELECT * FROM TTURNORELACIONADO WHERE  TURNOIDRE='+inttostr(IDDETURNO));
    aqfact.ExecSQL;
    aqfact.open;
    WHILE NOT aqfact.EOF DO
    BEGIN
        ES_RELACIONADO_HIJO:=TRUE;
        BREAK;
        aqfact.NEXT;
    END;
    aqfact.Close;
    aqfact.Free;



end;



function TFORM1.ES_PAGOID_RELACIONADO(IDPAGORELA:longint):boolean;
var aqfact:tsqlquery;
EXITE:BOOLEAN;
begin

ES_PAGOID_RELACIONADO:=FALSE;
    aqfact:=tsqlquery.create(nil);
    aqfact.SQLConnection := MyBD;
    aqfact.sql.add('SELECT * FROM TTURNORELACIONADO WHERE  PAGOSID='+inttostr(IDPAGORELA));
    aqfact.ExecSQL;
    aqfact.open;
    WHILE NOT aqfact.EOF DO
    BEGIN
        ES_PAGOID_RELACIONADO:=TRUE;
        BREAK;
        aqfact.NEXT;
    END;
    aqfact.Close;
    aqfact.Free;



end;

  function TFORM1.ES_RELACIONADO_PADRE(IDDETURNO:longint):boolean;
var aqfact:tsqlquery;
EXITE:BOOLEAN;
begin

ES_RELACIONADO_PADRE:=FALSE;
    aqfact:=tsqlquery.create(nil);
    aqfact.SQLConnection := MyBD;
    aqfact.sql.add('SELECT * FROM TTURNORELACIONADO WHERE  TURNOID='+inttostr(IDDETURNO));
    aqfact.ExecSQL;
    aqfact.open;
    WHILE NOT aqfact.EOF DO
    BEGIN
        ES_RELACIONADO_PADRE:=TRUE;
        BREAK;
        aqfact.NEXT;
    END;
    aqfact.Close;
    aqfact.Free;



end;

function TFORM1.exiete_en_tfactura(turnoid,pagoidverificacion:longint):boolean;
var aqfact:tsqlquery;
EXITE:BOOLEAN;
begin

exiete_en_tfactura:=FALSE;
    aqfact:=tsqlquery.create(nil);
    aqfact.SQLConnection := MyBD;
    aqfact.sql.add('SELECT * FROM TFACTURAS WHERE  idpago='+inttostr(pagoidverificacion));
    aqfact.ExecSQL;
    aqfact.open;
    WHILE NOT aqfact.EOF DO
    BEGIN
        exiete_en_tfactura:=TRUE;
        BREAK;
        aqfact.NEXT;
    END;
    aqfact.Close;
    aqfact.Free;



end;




FUNCTION TFORM1.ARMAR_NUMERO_FACTURA(NRO_FACT:STRING):STRING;
VAR HASTA :LONGINT;
I:LONGINT;
NUM:STRING;
BEGIN
HASTA:=8 - LENGTH(TRIM(NRO_FACT));
FOR I:=1 TO HASTA DO
BEGIN
 NUM:=NUM +'0';

END;

 ARMAR_NUMERO_FACTURA:=NUM+NRO_FACT;

END;


Function TFORM1.Genera_Fact_SAG(IDDETALLE:longint;facturado:string):boolean;

 var aq:tsqlquery;

StoredProc: TSQLStoredProc;

 begin
 TRY

  with TSQLStoredProc.Create(application) do
       try
          SQLConnection :=MyBD;
          StoredProcName :='Pq_DatosRecep.Guardafactura';  //PARA FACT a y b
          ParamByName('codturno').Value :=IDDETALLE;
          ParamByName('facturado').Value :=facturado;
          ExecProc;


           finally
              Close;
               Free;
           end;
   Genera_Fact_SAG:=TRUE;
  EXCEPT
    Genera_Fact_SAG:=FALSE;
  END;


end;


Function TFORM1.Genera_Fact_SAG_v2(IDDETALLE:longint;facturado:string):boolean;

 var aq:tsqlquery;

StoredProc: TSQLStoredProc;

 begin
 TRY

  with TSQLStoredProc.Create(application) do
       try
          SQLConnection :=MyBD;
          StoredProcName :='Pq_DatosRecep.GuardafacturaV2';  //PARA FACT a y b
          ParamByName('iddetpago').Value :=IDDETALLE;
          ParamByName('facturado').Value :=facturado;
          ExecProc;


           finally
              Close;
               Free;
           end;
   Genera_Fact_SAG_v2:=TRUE;
  EXCEPT
    Genera_Fact_SAG_v2:=FALSE;
  END;


end;





Function TFORM1.Genera_NOTA_CREDITO_SAG_v2(IDDETALLE,idpago:longint;facturado:string;numero,punto_venta:longint;cae,fev:string):boolean;
var aq, aqQm,aqQmf,aqQmfac:tsqlquery;   usuario:longint;
secuenciador,codfactu:longint; impresa,tipo:string;
begin

MyBD.StartTransaction(TD) ;
  TRY

  aq:=tsqlquery.create(nil);
    aq.SQLConnection := MyBD;
    aq.sql.add('select codfactu from tfacturas  where idpago='+inttostr(idpago));
    aq.ExecSQL;
    aq.open;
    codfactu:=aq.fields[0].asinteger;
    aq.Close;
    aq.Free;



    aq:=tsqlquery.create(nil);
    aq.SQLConnection := MyBD;
    aq.sql.add('select sq_tcontrafact_codcofac.nextval from dual');
    aq.ExecSQL;
    aq.open;
    secuenciador:=aq.fields[0].asinteger;
    aq.Close;
    aq.Free;


     impresa:='S';

    aqQm:=tsqlquery.create(nil);
    aqQm.SQLConnection := MyBD;
    aqQm.CLOSE;
    aqQm.SQL.CLEAR;
    aqQm.sql.add('insert into tcontrafact (codcofac,impresa,fechalta,numfactu,CAE,FECHAVENCE) '+
                ' values ('+inttostr(secuenciador)+','+#39+TRIM(impresa)+#39+',SYSDATE,'+INTTOSTR(NUMERO)+','+#39+TRIM(cae)+#39+','+#39+TRIM(FEV)+#39+')');
    aqQm.ExecSQL;



    aqQmf:=tsqlquery.create(nil);
    aqQmf.SQLConnection := MyBD;
    aqQmf.CLOSE;
    aqQmf.SQL.CLEAR;
    aqQmf.sql.add('update tfacturas set codcofac='+inttostr(secuenciador)+'  where codfactu='+inttostr(CODFACTU) +' and idpago='+inttostr(idpago));
    aqQmf.ExecSQL;



    usuario:=0;
    tipo:='N';
    aqQmfac:=tsqlquery.create(nil);
    aqQmfac.SQLConnection := MyBD;
    aqQmfac.CLOSE;
    aqQmfac.SQL.CLEAR;
    aqQmfac.sql.add('insert into tfact_adicion (codfact,tipofac,ptovent,idusuari) '+
                   ' values ('+inttostr(CODFACTU)+','+#39+TRIM(tipo)+#39+','+INTTOSTR(punto_venta)+','+inttostr(usuario)+')');
    aqQmfac.ExecSQL;


   MYBD.Commit(TD);
   Genera_NOTA_CREDITO_SAG_v2:=true;
 EXCEPT
   MyBD.Rollback(TD);
  Genera_NOTA_CREDITO_SAG_v2:=false;
 END;


 aqQm.close;
 aqQm.free;
 aqQmf.close;
 aqQmf.free;
 aqQmfac.close;
 aqQmfac.free;



end;


FUNCTION TForm1.EnviarMensaje_ERROR(destino,PAGOID,ARCHIVO,PLANTA:STRING):BOOLEAN;
var SMTP: TIdSMTP;
   Mensaje: TIdMessage;   SIGUE:BOOLEAN;      FA:tfacturae;
   Adjunto: TIdAttachment;
    sUsuario, sClave, sHost,FROM_NAME,FROM_ADDRES, sAdjunto, sAsunto,  sMensaje,SPUERTO: String ;
begin
 FA:=tfacturae.CREATE;
FA.LEER_PARAMETROS;
EnviarMensaje_ERROR:=TRUE;
sAdjunto:=ARCHIVO;
//sAsunto:='Factura Electronica Nro '+TRIM(NRO_COMPROBANTE);
if trim(planta)='3' then
   plAnta:='VELEZ'
   ELSE
   PLANTA:='SANTA MARIA';

sAsunto:='ERROR EXTERNAL REFERENCE  '+PAGOID+'. PLANTA '+PLANTA;
//sMensaje:='Enviamos factura electronica por los servicios prestados: Factura '+TRIM(NRO_COMPROBANTE)+'.pdf';

sMensaje:='EL EXTERNAL REFERENCE '+PAGOID+' TIENE ERRORES. SE ADJUNTA ARCHIVO XML.';


SIGUE:=TRUE;
sUsuario:=TRIM(FA.FA_USUARIO);
sClave:=TRIM(FA.FA_PASSWORD);
sHost:=TRIM(FA.FA_SMTP);
SPUERTO:=TRIM(FA.FA_PUERTO);
FROM_NAME:=TRIM(FA.FA_FROM_NAME);
FROM_ADDRES:=TRIM(FA.FA_FROM_ADDRESS);

  // Creamos el componente de conexi�n con el servidor
  SMTP := TIdSMTP.Create( nil );
  SMTP.Username := sUsuario;//'factura.electronica@applus.com.ar';
  SMTP.Password := sClave;//Applus01$
  SMTP.Host := sHost;//'mail.applus.com.ar'
  SMTP.Port :=STRTOINT(SPUERTO);
  SMTP.AuthenticationType := atLogin;


  // Creamos el contenido del mensaje
  Mensaje := TIdMessage.Create( nil );
  Mensaje.Clear;
  Mensaje.From.Name := FROM_NAME;
  Mensaje.From.Address :=FROM_ADDRES;
  Mensaje.Subject := sAsunto;
  Mensaje.Body.Text := sMensaje;
  Mensaje.Recipients.Add;
  Mensaje.Recipients.Items[0].Address :=destino;
   // Si hay que meter un archivo adjunto lo creamos y lo asignamos al mensaje
  if sAdjunto <> '' then
  begin
    if FileExists( sAdjunto ) then
      Adjunto := TIdAttachment.Create( Mensaje.MessageParts, sAdjunto );
  end
  else
    Adjunto := nil;

  // Conectamos con el servidor SMTP
  try
    SMTP.Connect;
  except
    BEGIN
    SIGUE:=FALSe;
    ERROR_MAIL:='Error al conectar con el servidor.';
     EnviarMensaje_ERROR:=FALSE;
    end;
  END;

  // Si ha conectado enviamos el mensaje y desconectamos
  if SMTP.Connected then
  begin
    try
      SMTP.Send( Mensaje );
    except
        BEGIN
          ERROR_MAIL:='Error al enviar el mensaje.';
           SIGUE:=FALSe;
           EnviarMensaje_ERROR:=FALSE;
        END;

    end;

    try
      SMTP.Disconnect;
    except
    BEGIN
     SIGUE:=FALSe;
      ERROR_MAIL:='Error al desconectar del servidor.';
      EnviarMensaje_ERROR:=FALSE;
    end;
    END;
  end;

  // Liberamos los objetos creados
  if Adjunto <> nil then
    FreeAndNil( Adjunto );

  FreeAndNil( Mensaje );
  FreeAndNil( SMTP );
  IF SIGUE=TRUE THEN
   BEGIN
    ERROR_MAIL:='Mensaje enviado correctamente.';
    EnviarMensaje_ERROR:=TRUE;
   END;
 EnviarMensaje_ERROR:=SIGUE;

 fa.Free;
end;



FUNCTION TForm1.EnviarMensaje_ERROR_base(destino,PLANTA:STRING):BOOLEAN;
var SMTP: TIdSMTP;
   Mensaje: TIdMessage;   SIGUE:BOOLEAN;      FA:tfacturae;
   Adjunto: TIdAttachment;
    sUsuario, sClave, sHost,FROM_NAME,FROM_ADDRES, sAdjunto, sAsunto,  sMensaje,SPUERTO: String ;
begin
 FA:=tfacturae.CREATE;
FA.LEER_PARAMETROS;
EnviarMensaje_ERROR_base:=TRUE;
sAdjunto:='';
//sAsunto:='Factura Electronica Nro '+TRIM(NRO_COMPROBANTE);
if trim(planta)='3' then
   plAnta:='VELEZ'
   ELSE
   PLANTA:='SANTA MARIA';

sAsunto:=' PLANTA '+PLANTA+'. ERROR BASE DE DATOS';
//sMensaje:='Enviamos factura electronica por los servicios prestados: Factura '+TRIM(NRO_COMPROBANTE)+'.pdf';

sMensaje:='SE PRODUJO UN ERROR DE CONEXION CON LA BASE DE DATOS. LA VARIABLE FACTURA DEL ARCHIVO CONFIG.INI '+#13+
' SE HA CONFIGURADO EN N. POR FAVOR REVISAR Y CONFIGURAR LA VARIABLE EN S.';


SIGUE:=TRUE;
sUsuario:=TRIM(FA.FA_USUARIO);
sClave:=TRIM(FA.FA_PASSWORD);
sHost:=TRIM(FA.FA_SMTP);
SPUERTO:=TRIM(FA.FA_PUERTO);
FROM_NAME:=TRIM(FA.FA_FROM_NAME);
FROM_ADDRES:=TRIM(FA.FA_FROM_ADDRESS);

  // Creamos el componente de conexi�n con el servidor
  SMTP := TIdSMTP.Create( nil );
  SMTP.Username := sUsuario;//'factura.electronica@applus.com.ar';
  SMTP.Password := sClave;//Applus01$
  SMTP.Host := sHost;//'mail.applus.com.ar'
  SMTP.Port :=STRTOINT(SPUERTO);
  SMTP.AuthenticationType := atLogin;


  // Creamos el contenido del mensaje
  Mensaje := TIdMessage.Create( nil );
  Mensaje.Clear;
  Mensaje.From.Name := FROM_NAME;
  Mensaje.From.Address :=FROM_ADDRES;
  Mensaje.Subject := sAsunto;
  Mensaje.Body.Text := sMensaje;
  Mensaje.Recipients.Add;
  Mensaje.Recipients.Items[0].Address :=destino;

   // Si hay que meter un archivo adjunto lo creamos y lo asignamos al mensaje
  if sAdjunto <> '' then
  begin
    if FileExists( sAdjunto ) then
      Adjunto := TIdAttachment.Create( Mensaje.MessageParts, sAdjunto );
  end
  else
    Adjunto := nil;

  // Conectamos con el servidor SMTP
  try
    SMTP.Connect;
  except
    BEGIN
    SIGUE:=FALSe;
    ERROR_MAIL:='Error al conectar con el servidor.';
     EnviarMensaje_ERROR_base:=FALSE;
    end;
  END;

  // Si ha conectado enviamos el mensaje y desconectamos
  if SMTP.Connected then
  begin
    try
      SMTP.Send( Mensaje );
    except
        BEGIN
          ERROR_MAIL:='Error al enviar el mensaje.';
           SIGUE:=FALSe;
           EnviarMensaje_ERROR_base:=FALSE;
        END;

    end;

    try
      SMTP.Disconnect;
    except
    BEGIN
     SIGUE:=FALSe;
      ERROR_MAIL:='Error al desconectar del servidor.';
      EnviarMensaje_ERROR_base:=FALSE;
    end;
    END;
  end;

  // Liberamos los objetos creados
  if Adjunto <> nil then
    FreeAndNil( Adjunto );

  FreeAndNil( Mensaje );
  FreeAndNil( SMTP );
  IF SIGUE=TRUE THEN
   BEGIN
    ERROR_MAIL:='Mensaje enviado correctamente.';
    EnviarMensaje_ERROR_base:=TRUE;
   END;
 EnviarMensaje_ERROR_base:=SIGUE;

 fa.Free;
end;



FUNCTION TForm1.EnviarMensaje_TRAZAS(destino,ARCHIVO,PLANTA:STRING):BOOLEAN;
var SMTP: TIdSMTP;
   Mensaje: TIdMessage;   SIGUE:BOOLEAN;      FA:tfacturae;
   Adjunto: TIdAttachment;
    sUsuario, sClave, sHost,FROM_NAME,FROM_ADDRES, sAdjunto, sAsunto,  sMensaje,SPUERTO: String ;
begin
 FA:=tfacturae.CREATE;
FA.LEER_PARAMETROS;
EnviarMensaje_TRAZAS:=TRUE;
sAdjunto:=ARCHIVO;
//sAsunto:='Factura Electronica Nro '+TRIM(NRO_COMPROBANTE);
if trim(planta)='3' then
   plAnta:='VELEZ'
   ELSE
   PLANTA:='SANTA MARIA';

sAsunto:='ERROR EN PLANTA '+PLANTA;
//sMensaje:='Enviamos factura electronica por los servicios prestados: Factura '+TRIM(NRO_COMPROBANTE)+'.pdf';

sMensaje:=ARCHIVO;


SIGUE:=TRUE;
sUsuario:=TRIM(FA.FA_USUARIO);
sClave:=TRIM(FA.FA_PASSWORD);
sHost:=TRIM(FA.FA_SMTP);
SPUERTO:=TRIM(FA.FA_PUERTO);
FROM_NAME:=TRIM(FA.FA_FROM_NAME);
FROM_ADDRES:=TRIM(FA.FA_FROM_ADDRESS);

  // Creamos el componente de conexi�n con el servidor
  SMTP := TIdSMTP.Create( nil );
  SMTP.Username := sUsuario;//'factura.electronica@applus.com.ar';
  SMTP.Password := sClave;//Applus01$
  SMTP.Host := sHost;//'mail.applus.com.ar'
  SMTP.Port :=STRTOINT(SPUERTO);
  SMTP.AuthenticationType := atLogin;


  // Creamos el contenido del mensaje
  Mensaje := TIdMessage.Create( nil );
  Mensaje.Clear;
  Mensaje.From.Name := FROM_NAME;
  Mensaje.From.Address :=FROM_ADDRES;
  Mensaje.Subject := sAsunto;
  Mensaje.Body.Text := sMensaje;
  Mensaje.Recipients.Add;
  Mensaje.Recipients.Items[0].Address :=destino;
   // Si hay que meter un archivo adjunto lo creamos y lo asignamos al mensaje

    Adjunto := nil;

  // Conectamos con el servidor SMTP
  try
    SMTP.Connect;
  except
    BEGIN
    SIGUE:=FALSe;
    ERROR_MAIL:='Error al conectar con el servidor.';
     EnviarMensaje_TRAZAS:=FALSE;
    end;
  END;

  // Si ha conectado enviamos el mensaje y desconectamos
  if SMTP.Connected then
  begin
    try
      SMTP.Send( Mensaje );
    except
        BEGIN
          ERROR_MAIL:='Error al enviar el mensaje.';
           SIGUE:=FALSe;
           EnviarMensaje_TRAZAS:=FALSE;
        END;

    end;

    try
      SMTP.Disconnect;
    except
    BEGIN
     SIGUE:=FALSe;
      ERROR_MAIL:='Error al desconectar del servidor.';
      EnviarMensaje_TRAZAS:=FALSE;
    end;
    END;
  end;

  // Liberamos los objetos creados


  FreeAndNil( Mensaje );
  FreeAndNil( SMTP );
  IF SIGUE=TRUE THEN
   BEGIN
    ERROR_MAIL:='Mensaje enviado correctamente.';
    EnviarMensaje_TRAZAS:=TRUE;
   END;
 EnviarMensaje_TRAZAS:=SIGUE;

 fa.Free;
end;



FUNCTION TForm1.EnviarMensaje(sDestino,NRO_COMPROBANTE,ARCHIVO,nombre,patente:STRING):BOOLEAN;
var SMTP: TIdSMTP;
   Mensaje: TIdMessage;   SIGUE:BOOLEAN;
   Adjunto: TIdAttachment;
    sUsuario, sClave, sHost,FROM_NAME,FROM_ADDRES, sAdjunto, sAsunto,  sMensaje,SPUERTO: String ;
begin

EnviarMensaje:=TRUE;
sAdjunto:=ARCHIVO;
//sAsunto:='Factura Electronica Nro '+TRIM(NRO_COMPROBANTE);
sAsunto:='Comprobante de pago de tu VTV';
//sMensaje:='Enviamos factura electronica por los servicios prestados: Factura '+TRIM(NRO_COMPROBANTE)+'.pdf';

sMensaje:='Hola, '+trim(nombre)+':'+#13+#13+
'�Felicitaciones! Ya abonaste el tr�mite de la VTV. Te enviamos el comprobante del pago correspondiente a tu veh�culo '+trim(patente)+'.'+#13+#13+#13+
'Si ten�s que cambiar o cancelar tu turno, entr� a http://www.buenosaires.gob.ar/tramites/vtv  .'+#13+#13+#13+
'�Te esperamos! ';



SIGUE:=TRUE;
sUsuario:=TRIM(FA.FA_USUARIO);
sClave:=TRIM(FA.FA_PASSWORD);
sHost:=TRIM(FA.FA_SMTP);
SPUERTO:=TRIM(FA.FA_PUERTO);
FROM_NAME:=TRIM(FA.FA_FROM_NAME);
FROM_ADDRES:=TRIM(FA.FA_FROM_ADDRESS);

  // Creamos el componente de conexi�n con el servidor
  SMTP := TIdSMTP.Create( nil );
  SMTP.Username := sUsuario;//'factura.electronica@applus.com.ar';
  SMTP.Password := sClave;//Applus01$
  SMTP.Host := sHost;//'mail.applus.com.ar'
  SMTP.Port :=STRTOINT(SPUERTO);
  SMTP.AuthenticationType := atLogin;


  // Creamos el contenido del mensaje
  Mensaje := TIdMessage.Create( nil );
  Mensaje.Clear;
  Mensaje.From.Name := FROM_NAME;
  Mensaje.From.Address :=FROM_ADDRES;
  Mensaje.Subject := sAsunto;
  Mensaje.Body.Text := sMensaje;
  Mensaje.Recipients.Add;
  Mensaje.Recipients.Items[0].Address := sDestino;

  // Si hay que meter un archivo adjunto lo creamos y lo asignamos al mensaje
  if sAdjunto <> '' then
  begin
    if FileExists( sAdjunto ) then
      Adjunto := TIdAttachment.Create( Mensaje.MessageParts, sAdjunto );
  end
  else
    Adjunto := nil;

  // Conectamos con el servidor SMTP
  try
   APPLICATION.ProcessMessages;
    SMTP.Connect;
     APPLICATION.ProcessMessages;
  except
    BEGIN
    SIGUE:=FALSe;
    ERROR_MAIL:='Error al conectar con el servidor.';
     EnviarMensaje:=FALSE;
    end;
  END;

  // Si ha conectado enviamos el mensaje y desconectamos
  if SMTP.Connected then
  begin
    try
     APPLICATION.ProcessMessages;
      SMTP.Send( Mensaje );
       APPLICATION.ProcessMessages;
    except
        BEGIN
          ERROR_MAIL:='Error al enviar el mensaje.';
           SIGUE:=FALSe;
           EnviarMensaje:=FALSE;
        END;

    end;

    try
     APPLICATION.ProcessMessages;
      SMTP.Disconnect;
       APPLICATION.ProcessMessages;
    except
    BEGIN
     SIGUE:=FALSe;
      ERROR_MAIL:='Error al desconectar del servidor.';
      EnviarMensaje:=FALSE;
    end;
    END;
  end;

  // Liberamos los objetos creados
  if Adjunto <> nil then
    FreeAndNil( Adjunto );

  FreeAndNil( Mensaje );
  FreeAndNil( SMTP );
  IF SIGUE=TRUE THEN
   BEGIN
    ERROR_MAIL:='Mensaje enviado correctamente.';
    EnviarMensaje:=TRUE;
   END;
 EnviarMensaje:=SIGUE;
end;

FUNCTION TForm1.GENERAR_FACTURAS_ELECTRONICAS:BOOLEAN;

var id_SERVICIO:longint;
    TIPO_COMPROBANTE,LETRA:STRING;
    TURNOID:LONGINT;
    TIPOTURNO:STRING;
    FECHATURNO:STRING;
    HORATURNO:STRING;
    FECHAREGISTRO:STRING;
    DFGENERO:STRING;
    DFTIPODOCUMENTO:STRING;
    DFNRODOCUMENTO:STRING;
    DFNOMBRE:STRING;
    DFAPELLIDO:STRING;
    DFCALLE:STRING;
    DFNUMEROCALLE:STRING;
    DFPISO:STRING;
    DFDEPARTAMENTO:STRING;
    DFLOCALIDAD:STRING;
    DFPROVINCIAID:STRING;
    DFPROVINCIA:STRING;
    DFCODIGOPOSTAL:STRING;
    DFIVA:STRING;
    DFIIBB:STRING;
    PAGOSID:STRING;
    PAGOSGETWAY:STRING;
    PAGOSENTIDADID:STRING;
    PAGOSENTIDAD:STRING;
    PAGOSFECHA:STRING;
    PAGOSIMPORTE:STRING;
    PAGOSESTADOLIQUIDACION:STRING;
    CODVEHIC:LONGINT;
    CODCLIEN:LONGINT;
    AUSENTE:STRING;
    FACTURADO:STRING;
    REVISO:STRING;
    DVNUMERO:STRING;
    CODINSPE:LONGINT;
    ANIO:LONGINT;
    fecha,APRO:string;
     CONTACTOEMAIL:STRING;


punto_vta:longint;
cbt_desde:string;
cbt_hasta:string;
para_Actualizar_numero:string;
para_Actualizar_compro:string;
tipo_cbte:longint;

 NRO_COMPROBANTE:STRING;
imp_total:string;
imp_tot_conc:string;
imp_neto:string;
imp_iva:string;
imp_trib:string;
imp_op_ex:string;
 IMPORTEVERIFICACION,patente_para_factura:sTRING;
  F1:string;
  F2:string;
  F3:string;
   numeroCuit:string;
 tipo_doc:longint;
 nro_doc:string;
 nro_doc1:string;
fecha_cbte:string;
fecha_venc_pago:string;
fecha_serv_desde:string;
fecha_serv_hasta:string;
moneda_id,SE_ENVIO ,STIPOCOMPROBANTE:string;
moneda_ctz,ERROR :string;
IMPORTE_PARA21_s,TIPOCOMPROBANTEAFIP:string;
IVA21:string;        aqQm:tsqlquery;
aq,aqQ,aqQarchi:tsqlquery ;
posi,i:longint;     archivo,nombre_para_mail,ESTADOID:string;
TD: TTransactionDesc;
  IMPORTE_SIN_IVA,IMPORTE_IVA:REAL;
  pagoidverificacion:longint;
begin
TRY
IMPORTE_SIN_IVA:=0;
IMPORTE_IVA:=0;
 fecha:=datetostr(date);
 id_SERVICIO:=2;
 TIPO_COMPROBANTE:='FAC';

 //FECHA:='22/07/2016';

    aq:=tsqlquery.create(nil);
    aq.SQLConnection := MyBD;


    aq.sql.add('SELECT TURNOID	,TIPOTURNO	, dvdomino,'+
               ' FECHATURNO, '+
               ' HORATURNO	, '+
               ' FECHAREGISTRO	, '+
               ' DFGENERO,  '+
               ' DFTIPODOCUMENTO,  '+
               ' DFNRODOCUMENTO,'+
               ' DFNOMBRE,  '+
               ' DFAPELLIDO	,'+
               ' DFCALLE	, '+
               ' DFNUMEROCALLE,'+
               ' DFPISO, '+
               ' DFDEPARTAMENTO, '+
               ' DFLOCALIDAD	, '+
               ' DFPROVINCIAID	, '+
               ' DFPROVINCIA	, '+
               ' DFCODIGOPOSTAL	, '+
               ' DFIVA	,'+
               ' DFIIBB, '+
               ' PAGOSID	,'+
               ' PAGOSGETWAY	,  '+
               ' PAGOSENTIDADID	, '+
               ' PAGOSENTIDAD,'+
               ' PAGOSFECHA	, '+
               ' PAGOSIMPORTE	,'+
               ' PAGOSESTADOLIQUIDACION	,'+
               ' CODVEHIC	, '+
               ' CODCLIEN	, '+
               ' AUSENTE	, '+
               ' FACTURADO	, '+
               ' REVISO	, '+
               ' DVNUMERO	, '+
               ' CODINSPE	, CUITFACTURA,'+
               ' ANIO ,IMPORTEVERIFICACION , CONTACTOEMAIL, ESTADOID,pagoidverificacion '+
              ' FROM tdatosturno where  FACTURADO=''N'' and modo=''P'' and ESTADOACREDITACIONVERIFICACION	=''A'' and ESTADOID in(1,2,3,7,4,6) '+
              ' and TIPOTURNO in (''O'',''P'')  '+
              ' AND TIPOINSPE=''P'' and CODCLIEN <> 0  AND  codvehic <> 0   ORDER BY TURNOID ASC');



    aq.ExecSQL;
    aq.open;
    while not aq.eof do
    begin

       TURNOID:=aq.fieldbyname('TURNOID').asinteger;
       pagoidverificacion:=aq.fieldbyname('pagoidverificacion').asinteger;

    IF  (exiete_idpago_en_tfactura(pagoidverificacion)=false) AND
        (ES_RELACIONADO_PADRE(TURNOID)=FALSE) AND
        (ES_RELACIONADO_HIJO(TURNOID)=FALSE)  AND
         (exiete_idpago_en_tfactura(pagoidverificacion)=FALSE) THEN
      BEGIN
     patente_para_factura:=trim(aq.fieldbyname('dvdomino').asstring);
     TURNOID:=aq.fieldbyname('TURNOID').asinteger;
     TIPOTURNO:=trim(aq.fieldbyname('TIPOTURNO').asstring);
     FECHATURNO:=trim(aq.fieldbyname('FECHATURNO').asstring);
     HORATURNO:=trim(aq.fieldbyname('HORATURNO').asstring);
     FECHAREGISTRO:=trim(aq.fieldbyname('FECHAREGISTRO').asstring);
     DFGENERO:=trim(aq.fieldbyname('DFGENERO').asstring);
     DFTIPODOCUMENTO:=trim(aq.fieldbyname('DFTIPODOCUMENTO').asstring);
     DFNRODOCUMENTO:=trim(aq.fieldbyname('DFNRODOCUMENTO').asstring);
     numeroCuit:=trim(aq.fieldbyname('cuitfactura').asstring);
     DFNOMBRE:=trim(aq.fieldbyname('DFNOMBRE').asstring);
     DFAPELLIDO:=trim(aq.fieldbyname('DFAPELLIDO').asstring);
     DFCALLE:=trim(aq.fieldbyname('DFCALLE').asstring);
     DFNUMEROCALLE:=trim(aq.fieldbyname('DFNUMEROCALLE').asstring);
     DFPISO:=trim(aq.fieldbyname('DFPISO').asstring);
     DFDEPARTAMENTO:=trim(aq.fieldbyname('DFDEPARTAMENTO').asstring);
     DFLOCALIDAD:=trim(aq.fieldbyname('DFLOCALIDAD').asstring);
     DFPROVINCIAID:=trim(aq.fieldbyname('DFPROVINCIAID').asstring);
     DFPROVINCIA:=trim(aq.fieldbyname('DFPROVINCIA').asstring);
     DFCODIGOPOSTAL	:=trim(aq.fieldbyname('DFCODIGOPOSTAL').asstring);
     DFIVA:=trim(aq.fieldbyname('DFIVA').asstring);
     DFIIBB:=trim(aq.fieldbyname('DFIIBB').asstring);
     PAGOSID:=trim(aq.fieldbyname('PAGOSID').asstring);
     PAGOSGETWAY:=trim(aq.fieldbyname('PAGOSGETWAY').asstring);
     PAGOSENTIDADID:=trim(aq.fieldbyname('PAGOSENTIDADID').asstring);
     PAGOSENTIDAD:=trim(aq.fieldbyname('PAGOSENTIDAD').asstring);
     PAGOSFECHA:=trim(aq.fieldbyname('PAGOSFECHA').asstring);
     PAGOSIMPORTE:=trim(aq.fieldbyname('PAGOSIMPORTE').asstring);
     PAGOSESTADOLIQUIDACION:=trim(aq.fieldbyname('PAGOSESTADOLIQUIDACION').asstring);
     CODVEHIC:=aq.fieldbyname('CODVEHIC').asinteger;
     CODCLIEN:=aq.fieldbyname('CODCLIEN').asinteger;
     AUSENTE:=trim(aq.fieldbyname('AUSENTE').asstring);
     FACTURADO:=trim(aq.fieldbyname('FACTURADO').asstring);
     REVISO:=trim(aq.fieldbyname('REVISO').asstring);
     DVNUMERO:=trim(aq.fieldbyname('DVNUMERO').asstring);
     CODINSPE:=aq.fieldbyname('CODINSPE').asinteger;
     ANIO:=aq.fieldbyname('ANIO').asinteger;
     IMPORTEVERIFICACION:=trim(aq.fieldbyname('IMPORTEVERIFICACION').asstring);
     CONTACTOEMAIL:=trim(aq.fieldbyname('CONTACTOEMAIL').asstring);


     if trim(TIPO_COMPROBANTE)='FAC' then
      begin
             if (trim(DFIVA)='R') then
                begin

                letra:='A';
               tipo_cbte:=1;
               TIPOCOMPROBANTEAFIP:='FAA';

               STIPOCOMPROBANTE:='01';
               end else begin
                   letra:='B';
                    tipo_cbte:=6;
                   TIPOCOMPROBANTEAFIP:='FAB';
                  STIPOCOMPROBANTE:='06';

               end;






      enD;

      if trim(TIPO_COMPROBANTE)='N/D' then
      begin




      enD;

           if trim(TIPO_COMPROBANTE)='N/C' then
      begin

      enD;



  if  (trim(DFTIPODOCUMENTO)='2')  then     //le
           begin
             tipo_doc:=89;
            nro_doc:=TRIM(DFNRODOCUMENTO);
           end;

           if  (trim(DFTIPODOCUMENTO)='3')  then // lc
           begin
               tipo_doc:=90;
            nro_doc:=TRIM(DFNRODOCUMENTO);
           end;

           if  (trim(DFTIPODOCUMENTO)='4')  then // dni ex
           begin
               tipo_doc:=91;
            nro_doc:=TRIM(DFNRODOCUMENTO);
           end;

            if  (trim(DFTIPODOCUMENTO)='5')  then // ced ex
           begin
               tipo_doc:=91;
            nro_doc:=TRIM(DFNRODOCUMENTO);
           end;

             if  (trim(DFTIPODOCUMENTO)='6')  then // pasaporte
           begin
               tipo_doc:=94;
            nro_doc:=TRIM(DFNRODOCUMENTO);
           end;


             if (trim(DFTIPODOCUMENTO)='7')    //otros
                 or (trim(DFTIPODOCUMENTO)='8')
                 or (trim(DFTIPODOCUMENTO)='10')
                 or (trim(DFTIPODOCUMENTO)='11')
                  or (trim(DFTIPODOCUMENTO)='12')
                 or (trim(DFTIPODOCUMENTO)='13') then
              begin
                    tipo_doc:=99;
            nro_doc:=TRIM(DFNRODOCUMENTO);

              end;




      if trim(DFTIPODOCUMENTO)='1' then   //dni
       begin

          tipo_doc:=96;
          nro_doc:=TRIM(DFNRODOCUMENTO);
       end;


      if trim(DFTIPODOCUMENTO)='9' then   //cuit
       begin
         tipo_doc:=80;
         POSI:=POS('-',TRIM(numeroCuit));
          IF POSI > 0 THEN
           BEGIN
            nro_doc:='';
            nro_doc1:=TRIM(numeroCuit);
              FOR I:=1 TO LENGTH(TRIM(nro_doc1)) DO
               BEGIN
                   IF TRIM(nro_doc1[I])<>'-' THEN
                      nro_doc:=nro_doc + TRIM(nro_doc1[I]);
                end;

           END else
             nro_doc:=TRIM(numeroCuit);

       end;











punto_vta:=FA.PUNTOVENTAFAE;
cbt_desde:='0';
cbt_hasta:='0';
para_Actualizar_numero:='1';
para_Actualizar_compro:='1';

//IMPORTEVERIFICACION:='12.10';
imp_total:=trim(IMPORTEVERIFICACION);//'12.10';


 IMPORTEVERIFICACION:= StringReplace(TRIM(IMPORTEVERIFICACION), '.', ',',
                          [rfReplaceAll, rfIgnoreCase]);


IMPORTE_SIN_IVA:=STRTOFLOAT(IMPORTEVERIFICACION)/1.21;
IMPORTE_IVA:=STRTOFLOAT(IMPORTEVERIFICACION) - IMPORTE_SIN_IVA;
imp_tot_conc:='0.00';
//imp_neto:='504.14';//'10.00';
// IMP_NETO:=FLOATTOSTR(IMPORTE_SIN_IVA);
  IMP_NETO:=FLOATTOSTRF(IMPORTE_SIN_IVA,FFFIXED,8,2);
//imp_iva:='105.86';
//IMP_IVA:=FLOATTOSTR(IMPORTE_IVA);
IMP_IVA:=FLOATTOSTRF(IMPORTE_IVA,FFFIXED,8,2);
imp_trib:='0.00';
imp_op_ex:='0.00';


 IMP_NETO:= StringReplace(TRIM(IMP_NETO), ',', '.',
                          [rfReplaceAll, rfIgnoreCase]);


 IMP_IVA:= StringReplace(TRIM(IMP_IVA), ',', '.',
                          [rfReplaceAll, rfIgnoreCase]);


  F1:=COPY(trim(fecha),7,4);
  F2:=COPY(trim(fecha),4,2);
  F3:=COPY(trim(fecha),1,2);
  FECHA:=F1+F2+F3;
  DateTimeToString(Fecha, 'yyyymmdd', date);

fecha_cbte:=trim(fecha);
fecha_venc_pago:=trim(fecha);
fecha_serv_desde:=trim(fecha);
fecha_serv_hasta:=trim(fecha);
moneda_id := 'PES';
moneda_ctz := '1.000';
//IMPORTE_PARA21_s:='504.14';
IMPORTE_PARA21_s:=IMP_NETO;

//IVA21:='105.86';
IVA21:=IMP_IVA;



  {
IF  Genera_Fact_SAG(inttostr(turnoid),'S')=FALSE THEN
   BEGIN
    {ERROR AL GUARDAR EN TFACTURAS}
    //   EXIT;
  // END;



   if fa.procesar_comprobante(id_SERVICIO, tipo_doc, nro_doc, tipo_cbte, punto_vta,
     STRTOINT(cbt_desde), STRTOINT(cbt_hasta), imp_total, imp_tot_conc, imp_neto,
      imp_iva, imp_trib, imp_op_ex, fecha_cbte, fecha_venc_pago,
      fecha_serv_desde, fecha_serv_hasta,
      moneda_id, moneda_ctz,IMPORTE_PARA21_s,IVA21,fa.Token,fa.Sign,fa.CUIT_EMPRESA,fa.MODO_FAE,LETRA, MyBD,TURNOID) =true then
     begin

      NRO_COMPROBANTE:='000'+INTTOSTR(punto_vta)+'-'+ARMAR_NUMERO_FACTURA(INTTOSTR(FA.ULTIMO));

      APRO:='SI' ;

       {generar pdf}
       {  if trim(letra)='A' then
              archivo:=generar_pdf(NRO_COMPROBANTE,FA.cae,FA.fecha_vence,IMP_NETO,IVA21,imp_total,STIPOCOMPROBANTE,INTTOSTR(punto_vta),TURNOID,letra,patente_para_factura,'','','',0,'',0)
              else
             archivo:=generar_pdf_B(NRO_COMPROBANTE,FA.cae,FA.fecha_vence,IMP_NETO,IVA21,imp_total,STIPOCOMPROBANTE,INTTOSTR(punto_vta),TURNOID,letra,patente_para_factura,'','','',0,'',0);

         }



      MyBD.StartTransaction(TD);
       TRY

        aqQ:=tsqlquery.create(nil);
        aqQ.SQLConnection := MyBD;
        aqQ.CLOSE;
        aqQ.SQL.CLEAR;
        aqQ.sql.add('UPDATE TDATOSTURNO SET FACTURADO=''S'', CAE='+#39+TRIM(FA.cae)+#39+', FECHAVENCE='+#39+TRIM(FA.fecha_vence)+#39+
        ', RESPUESTAAFIP='+#39+TRIM(FA.OBSERVACIONES_CAE)+#39+', APROBADA='+#39+APRO+#39+
        ', NRO_COMPROBANTE='+#39+TRIM(NRO_COMPROBANTE)+#39+
        ', TIPOCOMPROBANTEAFIP='+#39+TRIM(TIPOCOMPROBANTEAFIP)+#39+',  ARCHIVOENVIADO='+#39+TRIM(archivo)+#39+'   WHERE TURNOID='+INTTOSTR(TURNOID));
        AQQ.ExecSQL;







         Genera_Fact_SAG(turnoid,'S') ;

          archivo:=generar_pdf_viejo(TURNOID);


        aqQarchi:=tsqlquery.create(nil);
        aqQarchi.SQLConnection := MyBD;
        aqQarchi.CLOSE;
        aqQarchi.SQL.CLEAR;
        aqQarchi.sql.add('UPDATE TDATOSTURNO SET  ARCHIVOENVIADO='+#39+TRIM(archivo)+#39+'   WHERE TURNOID='+INTTOSTR(TURNOID));
        aqQarchi.ExecSQL;

          MYBD.Commit(TD);


        

         {ENVIAR MAIL}

         aqQm:=tsqlquery.create(nil);
         aqQm.SQLConnection := MyBD;
         aqQm.CLOSE;
         aqQm.SQL.CLEAR;
         aqQm.sql.add('select facturarazonsocial,cuitfactura,dfiva,dfnombre,dfapellido,dfnrodocumento,'+
               ' dftipodocumento,dfcalle, dfnumerocalle,dfpiso,DFDEPARTAMENTO,DFLOCALIDAD,DFPROVINCIA from tdatosturno WHERE TURNOID='+INTTOSTR(TURNOID));
         aqQm.ExecSQL;
         aqQm.open;




     IF TRIM(aqQm.FIELDBYNAME('facturarazonsocial').AsString)<>'' THEN
       nombre_para_mail:=TRIM(aqQm.FIELDBYNAME('facturarazonsocial').AsString)
       ELSE
         nombre_para_mail:=TRIM(aqQm.FIELDBYNAME('dfapellido').AsString)+' '+TRIM(aqQm.FIELDBYNAME('dfnombre').AsString);



        aqQm.close;
        aqQm.free;


        aqQarchi.close;
        aqQarchi.free;


         if EnviarMensaje(TRIM(CONTACTOEMAIL),NRO_COMPROBANTE,archivo,nombre_para_mail,patente_para_factura)=true then
            se_envio:='S'
            ELSE
            SE_ENVIO:='N';



         {FIN ENVIAR MAIL}

        EXCEPT
            MyBD.Rollback(TD);
        END ;

        AQQ.close;
     AQQ.free;


        MyBD.StartTransaction(TD);
       TRY

      aqQ:=tsqlquery.create(nil);
      aqQ.SQLConnection := MyBD;
      aqQ.CLOSE;
      aqQ.SQL.CLEAR;
      aqQ.sql.add('UPDATE TDATOSTURNO SET   ENVIOMAIL='+#39+SE_ENVIO+#39+',  ERROR_MAIL='+#39+TRIM(ERROR_MAIL)+#39+'  WHERE TURNOID='+INTTOSTR(TURNOID));
      AQQ.ExecSQL;

         MYBD.Commit(TD);






        EXCEPT
            MyBD.Rollback(TD);
        END ;


     AQQ.close;
     AQQ.free;


end ELSE BEGIN
 ERROR:= StringReplace(TRIM(FA.OBSERVACIONES_CAE), '''', ' ',
                          [rfReplaceAll, rfIgnoreCase]);
APRO:='NO' ;
MyBD.StartTransaction(TD);
       TRY
      aqQ:=tsqlquery.create(nil);
      aqQ.SQLConnection := MyBD;
       aqQ.CLOSE;
      aqQ.SQL.CLEAR;
      aqQ.sql.add('UPDATE TDATOSTURNO SET FACTURADO=''N'', CAE=NULL, FECHAVENCE=NULL, RESPUESTAAFIP='+#39+TRIM(ERROR)+#39+
      ', APROBADA='+#39+APRO+#39+', NRO_COMPROBANTE=NULL, TIPOCOMPROBANTEAFIP=NULL   WHERE TURNOID='+INTTOSTR(TURNOID));
      AQQ.ExecSQL;

          MYBD.Commit(TD);
        EXCEPT
            MyBD.Rollback(TD);
        END ;

      AQQ.close;
     AQQ.free;
END;








END;// SI EXISTE EN TFACTURAS

  aq.next;
    end;

    AQ.Close;
    AQ.FREE;



EXCEPT


END;



end;


function TForm1.veririca_si_es_una_reve(iddetallepago:longint):boolean;
var aqesreve:tsqlquery;
begin
aqesreve:=tsqlquery.create(nil);
aqesreve.SQLConnection := MyBD;
aqesreve.sql.add('select esreve, esrevedia from  tdatreserva  where iddetallespago='+inttostr(iddetallepago));
aqesreve.ExecSQL;
aqesreve.open;
if  (trim(aqesreve.fieldbyname('esreve').asstring)='S') or  (trim(aqesreve.fieldbyname('esrevedia').asstring)='S') then
     veririca_si_es_una_reve:=true
      else
      veririca_si_es_una_reve:=false;



aqesreve.Close;
aqesreve.Free;

end;


function TForm1.INFORMAR_FACTURA(externalReference,
numeroFactura,
tipoComprobante,
Dominio,
importeTotal,
importeNeto,
importeIVA,
cae,
vencimientoCae,
tipoFactura,
fechaFactura,
comprobantehash,smd5 :string):boolean;
begin
if tx.INFORMAR_FACTURA_a_suvtv(externalReference,
                            numeroFactura,
                            tipoComprobante,
                            Dominio,
                            importeTotal,
                            importeNeto,
                            importeIVA,
                            cae,
                            vencimientoCae,
                            tipoFactura,
                            fechaFactura,
                            comprobantehash,smd5)=true then
  begin

    INFORMAR_FACTURA:=true;

  end else
  INFORMAR_FACTURA:=false;



end;






FUNCTION TForm1.GENERAR_FACTURAS_ELECTRONICAS_PAGOS_SUVTV(planta,iddetallespagoPARAMETRO:longint):BOOLEAN;

var id_SERVICIO:longint;
    TIPO_COMPROBANTE,LETRA:STRING;
    TURNOID:LONGINT;
    TIPOTURNO:STRING;
    FECHATURNO:STRING;
    HORATURNO:STRING;
    FECHAREGISTRO:STRING;
    DFGENERO:STRING;
    DFTIPODOCUMENTO:STRING;
    DFNRODOCUMENTO:STRING;
    DFNOMBRE:STRING;
    DFAPELLIDO:STRING;
    DFCALLE:STRING;
    DFNUMEROCALLE:STRING;
    DFPISO:STRING;
    DFDEPARTAMENTO:STRING;
    DFLOCALIDAD:STRING;
    DFPROVINCIAID:STRING;
    DFPROVINCIA:STRING;
    DFCODIGOPOSTAL:STRING;
    DFIVA:STRING;
    DFIIBB:STRING;
    PAGOSID:STRING;
    PAGOSGETWAY:STRING;
    PAGOSENTIDADID:STRING;
    PAGOSENTIDAD:STRING;
    PAGOSFECHA:STRING;
    PAGOSIMPORTE:STRING;
    PAGOSESTADOLIQUIDACION:STRING;
    CODVEHIC:LONGINT;
    CODCLIEN:LONGINT;
    AUSENTE:STRING;
    FACTURADO:STRING;
    REVISO:STRING;
    DVNUMERO:STRING;
    CODINSPE:LONGINT;
    ANIO:LONGINT;
    fecha,APRO:string;
     CONTACTOEMAIL:STRING;


punto_vta:longint;
cbt_desde:string;
cbt_hasta:string;
para_Actualizar_numero:string;
para_Actualizar_compro:string;
tipo_cbte:longint;

 NRO_COMPROBANTE:STRING;
imp_total:string;
imp_tot_conc:string;
imp_neto:string;
imp_iva:string;
imp_trib:string;
imp_op_ex:string;
 IMPORTEVERIFICACION,patente_para_factura:sTRING;
  F1:string;
  F2:string;
  F3:string;
   numeroCuit:string;
 tipo_doc:longint;
 nro_doc:string;
 nro_doc1:string;
fecha_cbte:string;
fecha_venc_pago:string;
fecha_serv_desde:string;
fecha_serv_hasta:string;
moneda_id,SE_ENVIO ,STIPOCOMPROBANTE:string;
moneda_ctz,ERROR :string;
IMPORTE_PARA21_s,TIPOCOMPROBANTEAFIP:string;
IVA21:string;        aqQm,aqcliente,aqesreve:tsqlquery;
aq,aqQ,aqinformapago:tsqlquery ;         continua:boolean;
posi,i:longint;     archivo,nombre_para_mail,ESTADOID:string;
TD: TTransactionDesc;
  IMPORTE_SIN_IVA,IMPORTE_IVA:REAL;
  pagoidverificacion,iddetallespago,plantaid,codclientefacturacion,idplantaid:longint;
 numfa:longint;   nombre_archivo:STRING;
tbase:Tbase64Pdf;
 m5,b64:string;
 
         Stream: TMemoryStream;
  Texto_encode,texto_md5,archi: String;


   informada_fact:STRING;

begin
if FORM1.CONEXION_OK=TRUE then
BEGIN
TRY
IMPORTE_SIN_IVA:=0;
IMPORTE_IVA:=0;
fecha:=datetostr(date);
id_SERVICIO:=2;
TIPO_COMPROBANTE:='FAC';

 //FECHA:='22/07/2016';


aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
aq.sql.add('Select iddetallespago, pagoid, importe, plantaid,TIPOCOMPROBANTEAFIP,EMAIL from TDETALLESPAGO '+
               '  where estadoacreditacion = ''A'' AND Facturado = ''N'' '+
               ' and plantaid='+inttostr(planta)+' AND iddetallespago='+INTTOSTR(iddetallespagoPARAMETRO));
aq.ExecSQL;
aq.open;
while not aq.eof do
  begin
    iddetallespago:=aq.fieldbyname('iddetallespago').asinteger;
    pagoidverificacion:=aq.fieldbyname('pagoid').asinteger;

     //condicion de reves
  if veririca_si_es_una_reve(iddetallespago)=false then
    begin

      IF  (exiete_idpago_en_tfactura(pagoidverificacion)=false) then
        BEGIN
          IMPORTEVERIFICACION:=trim(aq.fieldbyname('importe').asstring);
          plantaid:=aq.fieldbyname('plantaid').asinteger;
          CONTACTOEMAIL:=trim(aq.fieldbyname('EMAIL').asstring);
          TIPO_COMPROBANTE:=trim(aq.fieldbyname('TIPOCOMPROBANTEAFIP').asstring);

          aqinformapago:=tsqlquery.create(nil);
          aqinformapago.SQLConnection := MyBD;
          aqinformapago.sql.add('select codvehiculo, codclientefacturacion, dominio,tipodocufactelec from tinformacionpago '+
                                   ' where (codvehiculo <> 0) '+
                                   ' and (codclientefacturacion <> 0) and iddetallespago='+inttostr(iddetallespago));
          aqinformapago.ExecSQL;
          aqinformapago.open;
            if not aqinformapago.IsEmpty then
              begin

                codclientefacturacion:=aqinformapago.FiELDBYNAME('codclientefacturacion').ASINTEGER;
                patente_para_factura:=trim(aqinformapago.fieldbyname('dominio').asstring);
                DFTIPODOCUMENTO:=trim(aqinformapago.fieldbyname('tipodocufactelec').asstring);

               if trim(TIPO_COMPROBANTE)='FA' then
                   begin
                    letra:='A';
                    tipo_cbte:=1;
                    STIPOCOMPROBANTE:='01';
                   end;

               if trim(TIPO_COMPROBANTE)='FB' then
                   begin
                    letra:='B';
                    tipo_cbte:=6;
                    STIPOCOMPROBANTE:='06';
                   end;


               if trim(TIPO_COMPROBANTE)='FC' then
                  begin
                   letra:='C';
                   tipo_cbte:=11;
                   STIPOCOMPROBANTE:='11';
                  end;


                   aqinformapago.close;
                    aqinformapago.free;

                  aqcliente:=tsqlquery.create(nil);
                  aqcliente.SQLConnection := MyBD;
                  aqcliente.sql.add('select codclien, tipodocu, document, nombre, apellid1,tiptribu, cuit_cli, genero '+
                                      'from tclientes where codclien ='+inttostr(codclientefacturacion));
                  aqcliente.ExecSQL;
                  aqcliente.open;

                  DFNRODOCUMENTO:=trim(aqcliente.fieldbyname('document').AsString);
                  numeroCuit:=trim(aqcliente.fieldbyname('cuit_cli').AsString);


                  nombre_para_mail:=TRIM(aqcliente.FIELDBYNAME('nombre').AsString)+' '+TRIM(aqcliente.FIELDBYNAME('apellid1').AsString);

                  aqcliente.close;
                  aqcliente.Free;



               if (trim(DFTIPODOCUMENTO)='2')  then     //le
                    begin
                     tipo_doc:=89;
                     nro_doc:=TRIM(DFNRODOCUMENTO);
                    end;

               if  (trim(DFTIPODOCUMENTO)='3')  then // lc
                   begin
                     tipo_doc:=90;
                     nro_doc:=TRIM(DFNRODOCUMENTO);
                   end;

               if  (trim(DFTIPODOCUMENTO)='4')  then // dni ex
                  begin
                    tipo_doc:=91;
                    nro_doc:=TRIM(DFNRODOCUMENTO);
                  end;

               if  (trim(DFTIPODOCUMENTO)='5')  then // ced ex
                 begin
                   tipo_doc:=91;
                   nro_doc:=TRIM(DFNRODOCUMENTO);
                 end;

               if  (trim(DFTIPODOCUMENTO)='6')  then // pasaporte
                 begin
                   tipo_doc:=94;
                   nro_doc:=TRIM(DFNRODOCUMENTO);
                end;


             if (trim(DFTIPODOCUMENTO)='7')    //otros
                 or (trim(DFTIPODOCUMENTO)='8')
                 or (trim(DFTIPODOCUMENTO)='10')
                 or (trim(DFTIPODOCUMENTO)='11')
                  or (trim(DFTIPODOCUMENTO)='12')
                 or (trim(DFTIPODOCUMENTO)='13') then
              begin
                    tipo_doc:=99;
                    nro_doc:=TRIM(DFNRODOCUMENTO);

              end;




          if trim(DFTIPODOCUMENTO)='1' then   //dni
            begin
            tipo_doc:=96;
            nro_doc:=TRIM(DFNRODOCUMENTO);
           end;


          if trim(DFTIPODOCUMENTO)='9' then   //cuit
           begin
             IF TRIM(numeroCuit)='' THEN
                 numeroCuit:=DFNRODOCUMENTO;


             tipo_doc:=80;
             POSI:=POS('-',TRIM(numeroCuit));
              IF POSI > 0 THEN
               BEGIN
                nro_doc:='';
                nro_doc1:=TRIM(numeroCuit);
                 FOR I:=1 TO LENGTH(TRIM(nro_doc1)) DO
                  BEGIN
                    IF TRIM(nro_doc1[I])<>'-' THEN
                      nro_doc:=nro_doc + TRIM(nro_doc1[I]);
                   end;

              END else
                nro_doc:=TRIM(numeroCuit);

          end;











punto_vta:=FA.PUNTOVENTAFAE;
cbt_desde:='0';
cbt_hasta:='0';
para_Actualizar_numero:='1';
para_Actualizar_compro:='1';

//IMPORTEVERIFICACION:='12.10';
imp_total:=trim(IMPORTEVERIFICACION);//'12.10';
IMPORTEVERIFICACION:= StringReplace(TRIM(IMPORTEVERIFICACION), '.', ',',
                          [rfReplaceAll, rfIgnoreCase]);

IMPORTE_SIN_IVA:=STRTOFLOAT(IMPORTEVERIFICACION)/1.21;
IMPORTE_IVA:=STRTOFLOAT(IMPORTEVERIFICACION) - IMPORTE_SIN_IVA;
imp_tot_conc:='0.00';
IMP_NETO:=FLOATTOSTRF(IMPORTE_SIN_IVA,FFFIXED,8,2);
IMP_IVA:=FLOATTOSTRF(IMPORTE_IVA,FFFIXED,8,2);
imp_trib:='0.00';
imp_op_ex:='0.00';

IMP_NETO:= StringReplace(TRIM(IMP_NETO), ',', '.',
                          [rfReplaceAll, rfIgnoreCase]);


IMP_IVA:= StringReplace(TRIM(IMP_IVA), ',', '.',
                          [rfReplaceAll, rfIgnoreCase]);


F1:=COPY(trim(fecha),7,4);
F2:=COPY(trim(fecha),4,2);
F3:=COPY(trim(fecha),1,2);
FECHA:=F1+F2+F3;
DateTimeToString(Fecha, 'yyyymmdd', date);
fecha_cbte:=trim(fecha);
fecha_venc_pago:=trim(fecha);
fecha_serv_desde:=trim(fecha);
fecha_serv_hasta:=trim(fecha);
moneda_id := 'PES';
moneda_ctz := '1.000';
//IMPORTE_PARA21_s:='504.14';
IMPORTE_PARA21_s:=IMP_NETO;

//IVA21:='105.86';
IVA21:=IMP_IVA;
MEMO1.Clear;
 MEMO1.Lines.Add('VALIDANDO PAGO : '+INTTOSTR(pagoidverificacion));
 APPLICATION.ProcessMessages;
if fa.procesar_comprobante(id_SERVICIO, tipo_doc, nro_doc, tipo_cbte, punto_vta,
                           STRTOINT(cbt_desde), STRTOINT(cbt_hasta), imp_total, imp_tot_conc, imp_neto,
                           imp_iva, imp_trib, imp_op_ex, fecha_cbte, fecha_venc_pago,
                           fecha_serv_desde, fecha_serv_hasta,
                           moneda_id, moneda_ctz,IMPORTE_PARA21_s,IVA21,fa.Token,fa.Sign,fa.CUIT_EMPRESA,
                           fa.MODO_FAE,letra, MyBD,TURNOID) =true then
begin
if FORM1.CONEXION_OK=TRUE then
 BEGIN
  nombre_archivo:='';

      NRO_COMPROBANTE:='000'+INTTOSTR(punto_vta)+'-'+ARMAR_NUMERO_FACTURA(INTTOSTR(FA.ULTIMO));
      APRO:='SI' ;

      MEMO1.Lines.Add('PAGO : '+INTTOSTR(pagoidverificacion)+' APROBADO  NRO FACT: '+NRO_COMPROBANTE);
      APPLICATION.ProcessMessages;
       {fin control de numeros facturas}
        nombre_archivo:=TIPO_COMPROBANTE+LETRA+INTTOSTR(FA.ULTIMO);


       MyBD.StartTransaction(TD);
        TRY
        informada_fact:='N';
         aqQ:=tsqlquery.create(nil);
         aqQ.SQLConnection := MyBD;
         aqQ.CLOSE;
         aqQ.SQL.CLEAR;
         aqQ.sql.add('UPDATE tdetallespago SET FACTURADO=''S'', CAE='+#39+TRIM(FA.cae)+#39+
                    ', APROBADA='+#39+APRO+#39+
                    ', FECHAVENCEFACTURA='+#39+TRIM(FA.fecha_vence)+#39+
                    ', RESPUESTAAFIP='+#39+TRIM(FA.OBSERVACIONES_CAE)+#39+
                    ', NRO_COMPROBANTE='+#39+TRIM(NRO_COMPROBANTE)+#39+
                    ', ENVIOMAIL='+#39+TRIM(informada_fact)+#39+
                    ', INFORMADA='+#39+TRIM(informada_fact)+#39+
                    '  WHERE iddetallespago='+INTTOSTR(iddetallespago));
         AQQ.ExecSQL;





        MYBD.Commit(TD);
        continua:=true;
        EXCEPT

           on E : Exception do
               BEGIN
                MyBD.Rollback(TD);
                continua:=false;
                TX.TRAZAS('ERROR AL UPDATE tdetallespago . '+E.ClassName+'. iddetallespago='+INTTOSTR(iddetallespago)+'. ERROR: '+E.Message);
                form1.EnviarMensaje_ERROR('martin.bien@applus.com',' NO ACTUALIZO EN TDETALLESPAGO. iddetallespago='+INTTOSTR(iddetallespago),'',inttostr(tx.ver_PLANTA));

               END;
        END ;
       AQQ.close;
       AQQ.free;
        if continua=true then
        begin
             MyBD.StartTransaction(TD);
             TRY
              Genera_Fact_SAG_v2(iddetallespago,'S') ;

              MYBD.Commit(TD);
              continua:=true;
             EXCEPT
               on E : Exception do
               BEGIN
                MyBD.Rollback(TD);
                continua:=false;
                TX.TRAZAS('ERROR AL GUARDAR EN TFACTURAS. '+E.ClassName+'. iddetallespago='+INTTOSTR(iddetallespago)+'. ERROR: '+E.Message);
                form1.EnviarMensaje_ERROR('martin.bien@applus.com',' NO GUARDO EN TFACTURAS. iddetallespago='+INTTOSTR(iddetallespago),'',inttostr(tx.ver_PLANTA));

               END;
             END ;
         end;

         

      {generar pdf}
       if trim(letra)='A' then
          archivo:=generar_pdf(NRO_COMPROBANTE,FA.cae,FA.fecha_vence,IMP_NETO,IVA21,imp_total,STIPOCOMPROBANTE,INTTOSTR(punto_vta),iddetallespago,letra,patente_para_factura,nombre_para_mail,DFTIPODOCUMENTO,nro_doc,codclientefacturacion,fa.MODO_FAE,iddetallespago,datetostr(date))
         else
         archivo:=generar_pdf_B(NRO_COMPROBANTE,FA.cae,FA.fecha_vence,IMP_NETO,IVA21,imp_total,STIPOCOMPROBANTE,INTTOSTR(punto_vta),iddetallespago,letra,patente_para_factura,nombre_para_mail,DFTIPODOCUMENTO,nro_doc,codclientefacturacion,fa.MODO_FAE,iddetallespago,datetostr(date));

         nombre_archivo:=ExtractFilePath(Application.ExeName)+'FACT_SUVTV\'+nombre_archivo+'.pdf';
         CopyFile(PChar(archivo), PChar(nombre_archivo), true);




        MyBD.StartTransaction(TD);
        TRY
         aqQ:=tsqlquery.create(nil);
         aqQ.SQLConnection := MyBD;
         aqQ.CLOSE;
         aqQ.SQL.CLEAR;
         aqQ.sql.add('UPDATE tdetallespago SET  ARCHIVOENVIADO='+#39+TRIM(archivo)+#39+'   WHERE iddetallespago='+INTTOSTR(iddetallespago));
         AQQ.ExecSQL;





        MYBD.Commit(TD);
        continua:=true;
        EXCEPT
         MyBD.Rollback(TD);
         continua:=false;
        END ;


        AQQ.close;
        AQQ.free;





      try
        Stream:= TMemoryStream.Create;
         try
           Stream.LoadFromFile(nombre_archivo);
           Texto_encode:= base64_new.BinToStr(Stream.Memory,Stream.Size);
           texto_md5:=base64_new.md5_suvtv(nombre_archivo);
        if  INFORMAR_FACTURA(inttostr(pagoidverificacion),
                      NRO_COMPROBANTE,
                      inttostr(tipo_cbte),
                      '',
                      imp_total,
                      IMP_NETO,
                      IVA21,
                      FA.cae,
                      FA.fecha_vence,
                      'FC',
                      datetostr(date),
                      Texto_encode,texto_md5)=true then

               informada_fact:='S'
              ELSE
               informada_fact:='N';
        

                if strtoint(trim(tx.ver_respuestaid_factura_informar_factura))=1 then
                    informada_fact:='S'
                    else
                    informada_fact:='N';

                  IF informada_fact='S' THEN
                   MEMO1.Lines.Add('INFORMA FACT: SI . '+TRIM(TX.ver_respuestamensaje_factura_informar_factura))
                   ELSE
                   MEMO1.Lines.Add('INFORMA FACT: NO . '+TRIM(TX.ver_respuestamensaje_factura_informar_factura));

                  APPLICATION.ProcessMessages;

                 MyBD.StartTransaction(TD);
                 TRY
                  aqQ:=tsqlquery.create(nil);
                  aqQ.SQLConnection := MyBD;
                  aqQ.CLOSE;
                  aqQ.SQL.CLEAR;
                  aqQ.sql.add('UPDATE tdetallespago SET  INFORMADA='+#39+TRIM(informada_fact)+#39+', FECHAINFORMA=SYSDATE, RESPUESTAINFORMAR='+#39+TRIM(TX.ver_respuestamensaje_factura_informar_factura)+#39+'   WHERE iddetallespago='+INTTOSTR(iddetallespago));
                  AQQ.ExecSQL;


                  MYBD.Commit(TD);

                  EXCEPT
                    MyBD.Rollback(TD);

                  END ;

                AQQ.close;
                AQQ.free;






          finally
            Stream.Free;
          end;

     except
       on E : Exception do
         BEGIN
         form1.EnviarMensaje_ERROR('martin.bien@applus.com','ERROR AL GENERAR PDF BASE64. iddetallespago='+INTTOSTR(iddetallespago)+'. ERROR: '+E.Message,'',inttostr(tx.ver_PLANTA));

         END;
    end;





         {ENVIAR MAIL}
     
         MEMO1.Lines.Add('ENVIANDO MAIL A :'+CONTACTOEMAIL);
         APPLICATION.ProcessMessages;
          if continua=true then
        begin

         
      {  if EnviarMensaje(TRIM(CONTACTOEMAIL),NRO_COMPROBANTE,archivo,nombre_para_mail,patente_para_factura)=true then
            se_envio:='S'
            ELSE   
            SE_ENVIO:='N'; }

          se_envio:='S';
            
          {  IF SE_ENVIO='S' THEN
             MEMO1.Lines.Add('ENVIO DE MAIL: SI')
            ELSE
             MEMO1.Lines.Add('ENVIO DE MAIL: NO');
            }


            MyBD.StartTransaction(TD);
            TRY

              aqQ:=tsqlquery.create(nil);
              aqQ.SQLConnection := MyBD;
              aqQ.CLOSE;
              aqQ.SQL.CLEAR;
              aqQ.sql.add('UPDATE tdetallespago SET   ENVIOMAIL='+#39+SE_ENVIO+#39+',  ERROR_MAIL='+#39+TRIM(ERROR_MAIL)+#39+ '  WHERE  iddetallespago='+INTTOSTR(iddetallespago));
              AQQ.ExecSQL;

              MYBD.Commit(TD);

           EXCEPT
              MyBD.Rollback(TD);
           END ;


          AQQ.close;
          AQQ.free;
      end;

   {  end ELSE BEGIN
       ERROR:= StringReplace(TRIM(FA.OBSERVACIONES_CAE), '''', ' ',
                          [rfReplaceAll, rfIgnoreCase]);
       APRO:='NO' ;
       MyBD.StartTransaction(TD);
        TRY
         aqQ:=tsqlquery.create(nil);
         aqQ.SQLConnection := MyBD;
         aqQ.CLOSE;
         aqQ.SQL.CLEAR;
         aqQ.sql.add('UPDATE tdetallespago SET FACTURADO=''N'', CAE=NULL, FECHAVENCEFACTURA=NULL, RESPUESTAAFIP='+#39+TRIM(ERROR)+#39+
                     ', APROBADA='+#39+APRO+#39+', NRO_COMPROBANTE=NULL   WHERE  iddetallespago='+INTTOSTR(iddetallespago));
         AQQ.ExecSQL;

         MYBD.Commit(TD);
        EXCEPT
            MyBD.Rollback(TD);
        END ;

        AQQ.close;
        AQQ.free;
      END;  }




   END; //COENXION_OK
    

  end//factura
    else begin
    
    ERROR:= StringReplace(TRIM(FA.OBSERVACIONES_CAE), '''', ' ',
                          [rfReplaceAll, rfIgnoreCase]);

       IF FA.PARAR_SERVICIO_FACTURACION=TRUE THEN
        BEGIN
           TX.PARAR_SERVICIO_FACTURACION_AFIP;
          form1.EnviarMensaje_ERROR('lucas.suarez@applus.com',ERROR+'. iddetallespago='+INTTOSTR(iddetallespago),'',inttostr(tx.ver_PLANTA));
          form1.EnviarMensaje_ERROR('martin.bien@applus.com',ERROR+'. iddetallespago='+INTTOSTR(iddetallespago),'',inttostr(tx.ver_PLANTA));

        END;



       APRO:='NO' ;
       MyBD.StartTransaction(TD);
        TRY
         aqQ:=tsqlquery.create(nil);
         aqQ.SQLConnection := MyBD;
         aqQ.CLOSE;
         aqQ.SQL.CLEAR;
         aqQ.sql.add('UPDATE tdetallespago SET FACTURADO=''N'', CAE=NULL, FECHAVENCEFACTURA=NULL, RESPUESTAAFIP='+#39+TRIM(ERROR)+#39+
                     ', APROBADA='+#39+APRO+#39+', NRO_COMPROBANTE=NULL   WHERE  iddetallespago='+INTTOSTR(iddetallespago));
         AQQ.ExecSQL;

         MYBD.Commit(TD);

       //  TX.TRAZAS(ERROR+'. iddetallespago='+INTTOSTR(iddetallespago));


        EXCEPT
            MyBD.Rollback(TD);
        END ;

        AQQ.close;
        AQQ.free;
        end;


 end else begin

     form1.EnviarMensaje_ERROR('martin.bien@applus.com',' no se genero comprobante.no tiene datos en tinformacionpago. iddetallespago='+INTTOSTR(iddetallespago),'',inttostr(tx.ver_PLANTA));

 end; //tinformacionpago

END;// SI EXISTE EN TFACTURAS


end;//es_reve


aq.next;
end;    //while



    AQ.Close;
    AQ.FREE;




   EXCEPT
   on E : Exception do
   BEGIN

    TX.TRAZAS('ERROR LA GENERAR LA FACTURA ELECTRONICA'+E.ClassName+'. iddetallespago='+INTTOSTR(iddetallespago)+'. ERROR: '+E.Message);
    form1.EnviarMensaje_ERROR('martin.bien@applus.com',' no se genero comprobante. iddetallespago='+INTTOSTR(iddetallespago),'',inttostr(tx.ver_PLANTA));


   END;

END ;

 END; //OK CONEXION

end;





FUNCTION TForm1.GENERA_PDF_FALTANTE(nro,tipo:sTRING):BOOLEAN;

var id_SERVICIO:longint;
    TIPO_COMPROBANTE,LETRA:STRING;
    TURNOID:LONGINT;
    TIPOTURNO:STRING;
    FECHATURNO:STRING;
    HORATURNO:STRING;
    FECHAREGISTRO:STRING;
    DFGENERO:STRING;
    DFTIPODOCUMENTO:STRING;
    DFNRODOCUMENTO:STRING;
    DFNOMBRE:STRING;
    DFAPELLIDO:STRING;
    DFCALLE:STRING;
    DFNUMEROCALLE:STRING;
    DFPISO:STRING;
    DFDEPARTAMENTO:STRING;
    DFLOCALIDAD:STRING;
    DFPROVINCIAID:STRING;
    DFPROVINCIA:STRING;
    DFCODIGOPOSTAL:STRING;
    DFIVA:STRING;
    DFIIBB:STRING;
    PAGOSID:STRING;
    PAGOSGETWAY:STRING;
    PAGOSENTIDADID:STRING;
    PAGOSENTIDAD:STRING;
    PAGOSFECHA:STRING;
    PAGOSIMPORTE:STRING;
    PAGOSESTADOLIQUIDACION:STRING;
    CODVEHIC:LONGINT;
    CODCLIEN:LONGINT;
    AUSENTE:STRING;
    FACTURADO:STRING;
    REVISO:STRING;
    DVNUMERO:STRING;
    CODINSPE:LONGINT;
    ANIO:LONGINT;
    fecha,APRO:string;
     CONTACTOEMAIL:STRING;


punto_vta:longint;
cbt_desde:string;
cbt_hasta:string;
para_Actualizar_numero:string;
para_Actualizar_compro:string;
tipo_cbte:longint;

 NRO_COMPROBANTE:STRING;
imp_total:string;
imp_tot_conc:string;
imp_neto:string;
imp_iva:string;
imp_trib:string;
imp_op_ex:string;
 IMPORTEVERIFICACION,patente_para_factura:sTRING;
  F1:string;
  F2:string;
  F3:string;
   numeroCuit:string;
 tipo_doc:longint;
 nro_doc:string;
 nro_doc1:string;
fecha_cbte:string;
fecha_venc_pago:string;
fecha_serv_desde:string;
fecha_serv_hasta:string;
moneda_id,SE_ENVIO ,STIPOCOMPROBANTE:string;
moneda_ctz,ERROR :string;
IMPORTE_PARA21_s,TIPOCOMPROBANTEAFIP:string;
IVA21:string;        aqQm,aqcliente,aqesreve:tsqlquery;
aq,aqQ,aqinformapago:tsqlquery ;         continua:boolean;
posi,i:longint;     archivo,nombre_para_mail,ESTADOID:string;
TD: TTransactionDesc;
  IMPORTE_SIN_IVA,IMPORTE_IVA:REAL;
  pagoidverificacion,iddetallespago,plantaid,codclientefacturacion,idplantaid:longint;
  NRO_COMPROBANTEFACT,CAEFACTURA,FECHAVENCEFACTURA :sTRING;
tbase:Tbase64Pdf;
 m5,b64,ARCHIVOENVIADO:string;
begin
TRY
IMPORTE_SIN_IVA:=0;
IMPORTE_IVA:=0;
fecha:=datetostr(date);
id_SERVICIO:=2;
TIPO_COMPROBANTE:='FAC';

 //FECHA:='22/07/2016';


aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
aq.sql.add('Select iddetallespago, pagoid, importe, plantaid,TIPOCOMPROBANTEAFIP,EMAIL, NRO_COMPROBANTE,CAE, '+
' FECHAVENCEFACTURA, ARCHIVOENVIADO from TDETALLESPAGO '+
               '  where   Facturado = ''S''  AND CAE IS NOT NULL AND APROBADA=''SI'' AND NRO_COMPROBANTE='+#39+trim(nro)+#39+
               ' and TIPOCOMPROBANTEAFIP='+#39+trim(tipo)+#39);
aq.ExecSQL;
aq.open;
while not aq.eof do
  begin
  ARCHIVOENVIADO:=trim(aq.fieldbyname('ARCHIVOENVIADO').asSTRING) ;

  IF FILEEXISTS(ARCHIVOENVIADO)=false THEN
  begin

    iddetallespago:=aq.fieldbyname('iddetallespago').asinteger;
    pagoidverificacion:=aq.fieldbyname('pagoid').asinteger;
    NRO_COMPROBANTEFACT:=trim(aq.fieldbyname('NRO_COMPROBANTE').asstring);
    CAEFACTURA:=trim(aq.fieldbyname('CAE').asSTRING) ;
    FECHAVENCEFACTURA:=trim(aq.fieldbyname('FECHAVENCEFACTURA').asSTRING) ;


          IMPORTEVERIFICACION:=trim(aq.fieldbyname('importe').asstring);
          plantaid:=aq.fieldbyname('plantaid').asinteger;
          CONTACTOEMAIL:=trim(aq.fieldbyname('EMAIL').asstring);
          TIPO_COMPROBANTE:=trim(aq.fieldbyname('TIPOCOMPROBANTEAFIP').asstring);

          aqinformapago:=tsqlquery.create(nil);
          aqinformapago.SQLConnection := MyBD;
          aqinformapago.sql.add('select codvehiculo, codclientefacturacion, dominio,tipodocufactelec from tinformacionpago '+
                                   ' where (codvehiculo <> 0) '+
                                   ' and (codclientefacturacion <> 0) and iddetallespago='+inttostr(iddetallespago));
          aqinformapago.ExecSQL;
          aqinformapago.open;
            if not aqinformapago.IsEmpty then
              begin

                codclientefacturacion:=aqinformapago.FiELDBYNAME('codclientefacturacion').ASINTEGER;
                patente_para_factura:=trim(aqinformapago.fieldbyname('dominio').asstring);
                DFTIPODOCUMENTO:=trim(aqinformapago.fieldbyname('tipodocufactelec').asstring);

               if trim(TIPO_COMPROBANTE)='FA' then
                   begin
                    letra:='A';
                    tipo_cbte:=1;
                    STIPOCOMPROBANTE:='01';
                   end;

               if trim(TIPO_COMPROBANTE)='FB' then
                   begin
                    letra:='B';
                    tipo_cbte:=6;
                    STIPOCOMPROBANTE:='06';
                   end;


               if trim(TIPO_COMPROBANTE)='FC' then
                  begin
                   letra:='C';
                   tipo_cbte:=11;
                   STIPOCOMPROBANTE:='11';
                  end;

                   if trim(TIPO_COMPROBANTE)='CB' then
                   begin
                      letra:='B';
                        tipo_cbte:=8;
                   STIPOCOMPROBANTE:='08';
                    end;
                   if trim(TIPO_COMPROBANTE)='CA' then
                   begin
                    tipo_cbte:=03;
                   STIPOCOMPROBANTE:='03';
                      letra:='A';
                   end;
                   aqinformapago.close;
                    aqinformapago.free;

                  aqcliente:=tsqlquery.create(nil);
                  aqcliente.SQLConnection := MyBD;
                  aqcliente.sql.add('select codclien, tipodocu, document, nombre, apellid1,tiptribu, cuit_cli, genero '+
                                      'from tclientes where codclien ='+inttostr(codclientefacturacion));
                  aqcliente.ExecSQL;
                  aqcliente.open;

                  DFNRODOCUMENTO:=trim(aqcliente.fieldbyname('document').AsString);
                  numeroCuit:=trim(aqcliente.fieldbyname('cuit_cli').AsString);


                  nombre_para_mail:=TRIM(aqcliente.FIELDBYNAME('nombre').AsString)+' '+TRIM(aqcliente.FIELDBYNAME('apellid1').AsString);

                  aqcliente.close;
                  aqcliente.Free;



               if (trim(DFTIPODOCUMENTO)='2')  then     //le
                    begin
                     tipo_doc:=89;
                     nro_doc:=TRIM(DFNRODOCUMENTO);
                    end;

               if  (trim(DFTIPODOCUMENTO)='3')  then // lc
                   begin
                     tipo_doc:=90;
                     nro_doc:=TRIM(DFNRODOCUMENTO);
                   end;

               if  (trim(DFTIPODOCUMENTO)='4')  then // dni ex
                  begin
                    tipo_doc:=91;
                    nro_doc:=TRIM(DFNRODOCUMENTO);
                  end;

               if  (trim(DFTIPODOCUMENTO)='5')  then // ced ex
                 begin
                   tipo_doc:=91;
                   nro_doc:=TRIM(DFNRODOCUMENTO);
                 end;

               if  (trim(DFTIPODOCUMENTO)='6')  then // pasaporte
                 begin
                   tipo_doc:=94;
                   nro_doc:=TRIM(DFNRODOCUMENTO);
                end;


             if (trim(DFTIPODOCUMENTO)='7')    //otros
                 or (trim(DFTIPODOCUMENTO)='8')
                 or (trim(DFTIPODOCUMENTO)='10')
                 or (trim(DFTIPODOCUMENTO)='11')
                  or (trim(DFTIPODOCUMENTO)='12')
                 or (trim(DFTIPODOCUMENTO)='13') then
              begin
                    tipo_doc:=99;
                    nro_doc:=TRIM(DFNRODOCUMENTO);

              end;




          if trim(DFTIPODOCUMENTO)='1' then   //dni
            begin
            tipo_doc:=96;
            nro_doc:=TRIM(DFNRODOCUMENTO);
           end;


          if trim(DFTIPODOCUMENTO)='9' then   //cuit
           begin
             IF TRIM(numeroCuit)='' THEN
                 numeroCuit:=DFNRODOCUMENTO;


             tipo_doc:=80;
             POSI:=POS('-',TRIM(numeroCuit));
              IF POSI > 0 THEN
               BEGIN
                nro_doc:='';
                nro_doc1:=TRIM(numeroCuit);
                 FOR I:=1 TO LENGTH(TRIM(nro_doc1)) DO
                  BEGIN
                    IF TRIM(nro_doc1[I])<>'-' THEN
                      nro_doc:=nro_doc + TRIM(nro_doc1[I]);
                   end;

              END else
                nro_doc:=TRIM(numeroCuit);

          end;











punto_vta:=FA.PUNTOVENTAFAE;
cbt_desde:='0';
cbt_hasta:='0';
para_Actualizar_numero:='1';
para_Actualizar_compro:='1';

//IMPORTEVERIFICACION:='12.10';
imp_total:=trim(IMPORTEVERIFICACION);//'12.10';
IMPORTEVERIFICACION:= StringReplace(TRIM(IMPORTEVERIFICACION), '.', ',',
                          [rfReplaceAll, rfIgnoreCase]);

IMPORTE_SIN_IVA:=STRTOFLOAT(IMPORTEVERIFICACION)/1.21;
IMPORTE_IVA:=STRTOFLOAT(IMPORTEVERIFICACION) - IMPORTE_SIN_IVA;
imp_tot_conc:='0.00';
IMP_NETO:=FLOATTOSTRF(IMPORTE_SIN_IVA,FFFIXED,8,2);
IMP_IVA:=FLOATTOSTRF(IMPORTE_IVA,FFFIXED,8,2);
imp_trib:='0.00';
imp_op_ex:='0.00';

IMP_NETO:= StringReplace(TRIM(IMP_NETO), ',', '.',
                          [rfReplaceAll, rfIgnoreCase]);


IMP_IVA:= StringReplace(TRIM(IMP_IVA), ',', '.',
                          [rfReplaceAll, rfIgnoreCase]);


F1:=COPY(trim(fecha),7,4);
F2:=COPY(trim(fecha),4,2);
F3:=COPY(trim(fecha),1,2);
FECHA:=F1+F2+F3;
DateTimeToString(Fecha, 'yyyymmdd', date);
fecha_cbte:=trim(fecha);
fecha_venc_pago:=trim(fecha);
fecha_serv_desde:=trim(fecha);
fecha_serv_hasta:=trim(fecha);
moneda_id := 'PES';
moneda_ctz := '1.000';
//IMPORTE_PARA21_s:='504.14';
IMPORTE_PARA21_s:=IMP_NETO;

//IVA21:='105.86';
IVA21:=IMP_IVA;


    NRO_COMPROBANTE:=NRO_COMPROBANTEFACT;
    APRO:='SI' ;

    {generar pdf}
    if trim(letra)='A' then
       archivo:=generar_pdf(NRO_COMPROBANTE,CAEFACTURA,FECHAVENCEFACTURA,IMP_NETO,IVA21,imp_total,STIPOCOMPROBANTE,INTTOSTR(punto_vta),iddetallespago,letra,patente_para_factura,nombre_para_mail,DFTIPODOCUMENTO,nro_doc,codclientefacturacion,fa.MODO_FAE,iddetallespago,datetostr(date))
    else

       archivo:=generar_pdf_B(NRO_COMPROBANTE,CAEFACTURA,FECHAVENCEFACTURA,IMP_NETO,IVA21,imp_total,STIPOCOMPROBANTE,INTTOSTR(punto_vta),iddetallespago,letra,patente_para_factura,nombre_para_mail,DFTIPODOCUMENTO,nro_doc,codclientefacturacion,fa.MODO_FAE,iddetallespago,datetostr(date));





               MyBD.StartTransaction(TD);
            TRY

              aqQ:=tsqlquery.create(nil);
              aqQ.SQLConnection := MyBD;
              aqQ.CLOSE;
              aqQ.SQL.CLEAR;
              aqQ.sql.add('UPDATE tdetallespago SET   ARCHIVOENVIADO='+#39+archivo+#39+'  WHERE  iddetallespago='+INTTOSTR(iddetallespago));
              AQQ.ExecSQL;

              MYBD.Commit(TD);

           EXCEPT
              MyBD.Rollback(TD);
           END ;


          AQQ.close;
          AQQ.free;






        continua:=TRUE;



         {ENVIAR MAIL}
      {    if continua=true then
        begin
         if EnviarMensaje(TRIM(CONTACTOEMAIL),NRO_COMPROBANTE,archivo,nombre_para_mail,patente_para_factura)=true then
            se_envio:='S'
            ELSE
            SE_ENVIO:='N';

            MyBD.StartTransaction(TD);
            TRY

              aqQ:=tsqlquery.create(nil);
              aqQ.SQLConnection := MyBD;
              aqQ.CLOSE;
              aqQ.SQL.CLEAR;
              aqQ.sql.add('UPDATE tdetallespago SET   ENVIOMAIL='+#39+SE_ENVIO+#39+',  ERROR_MAIL='+#39+TRIM(ERROR_MAIL)+#39+ '  WHERE  iddetallespago='+INTTOSTR(iddetallespago));
              AQQ.ExecSQL;

              MYBD.Commit(TD);

           EXCEPT
              MyBD.Rollback(TD);
           END ;


          AQQ.close;
          AQQ.free;


     end ELSE BEGIN
     
      END;    }

  {FIN ENVIAR MAIL}








 end else begin

     form1.EnviarMensaje_ERROR('martin.bien@applus.com',' no se genero comprobante.no tiene datos en tinformacionpago. iddetallespago='+INTTOSTR(iddetallespago),'',inttostr(tx.ver_PLANTA));

 end; //tinformacionpago


END;//ARCHVIO ENVIDO EXISTE

aq.next;
end;    //while



    AQ.Close;
    AQ.FREE;




   EXCEPT
   on E : Exception do
   BEGIN

    TX.TRAZAS('ERROR LA GENERAR LA FACTURA ELECTRONICA'+E.ClassName+'. iddetallespago='+INTTOSTR(iddetallespago)+'. ERROR: '+E.Message);
    form1.EnviarMensaje_ERROR('martin.bien@applus.com',' no se genero comprobante. iddetallespago='+INTTOSTR(iddetallespago),'',inttostr(tx.ver_PLANTA));


   END;

END ;



end;






FUNCTION TForm1.GENERA_TODOS_PDF_FALTANTE:BOOLEAN;

var id_SERVICIO:longint;
    TIPO_COMPROBANTE,LETRA:STRING;
    TURNOID:LONGINT;
    TIPOTURNO:STRING;
    FECHATURNO:STRING;
    HORATURNO:STRING;
    FECHAREGISTRO:STRING;
    DFGENERO:STRING;
    DFTIPODOCUMENTO:STRING;
    DFNRODOCUMENTO:STRING;
    DFNOMBRE:STRING;
    DFAPELLIDO:STRING;
    DFCALLE:STRING;
    DFNUMEROCALLE:STRING;
    DFPISO:STRING;
    DFDEPARTAMENTO:STRING;
    DFLOCALIDAD:STRING;
    DFPROVINCIAID:STRING;
    DFPROVINCIA:STRING;
    DFCODIGOPOSTAL:STRING;
    DFIVA:STRING;
    DFIIBB:STRING;
    PAGOSID:STRING;
    PAGOSGETWAY:STRING;
    PAGOSENTIDADID:STRING;
    PAGOSENTIDAD:STRING;
    PAGOSFECHA:STRING;
    PAGOSIMPORTE:STRING;
    PAGOSESTADOLIQUIDACION:STRING;
    CODVEHIC:LONGINT;
    CODCLIEN:LONGINT;
    AUSENTE:STRING;
    FACTURADO:STRING;
    REVISO:STRING;
    DVNUMERO:STRING;
    CODINSPE:LONGINT;
    ANIO:LONGINT;
    fecha,APRO:string;
     CONTACTOEMAIL:STRING;


punto_vta:longint;
cbt_desde:string;
cbt_hasta:string;
para_Actualizar_numero:string;
para_Actualizar_compro:string;
tipo_cbte:longint;

 NRO_COMPROBANTE:STRING;
imp_total:string;
imp_tot_conc:string;
imp_neto:string;
imp_iva:string;
imp_trib:string;
imp_op_ex:string;
 IMPORTEVERIFICACION,patente_para_factura:sTRING;
  F1:string;
  F2:string;
  F3:string;
   numeroCuit:string;
 tipo_doc:longint;
 nro_doc:string;
 nro_doc1:string;
fecha_cbte:string;
fecha_venc_pago:string;
fecha_serv_desde:string;
fecha_serv_hasta:string;
moneda_id,SE_ENVIO ,STIPOCOMPROBANTE:string;
moneda_ctz,ERROR :string;
IMPORTE_PARA21_s,TIPOCOMPROBANTEAFIP:string;
IVA21:string;        aqQm,aqcliente,aqesreve,AQFA:tsqlquery;
aq,aqQ,aqinformapago:tsqlquery ;         continua:boolean;
posi,i:longint;     archivo,nombre_para_mail,ESTADOID:string;
TD: TTransactionDesc;
  IMPORTE_SIN_IVA,IMPORTE_IVA:REAL;
  pagoidverificacion,iddetallespago,plantaid,codclientefacturacion,idplantaid:longint;
  NRO_COMPROBANTEFACT,CAEFACTURA,FECHAVENCEFACTURA :sTRING;
tbase:Tbase64Pdf;
 m5,b64,ARCHIVOENVIADO,fecha_comprobante:string;
begin
TRY
IMPORTE_SIN_IVA:=0;
IMPORTE_IVA:=0;
fecha:=datetostr(date);
id_SERVICIO:=2;
TIPO_COMPROBANTE:='FAC';

 //FECHA:='22/07/2016';


aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
aq.sql.add('Select iddetallespago, pagoid, importe, plantaid,TIPOCOMPROBANTEAFIP,EMAIL, NRO_COMPROBANTE,CAE, '+
' FECHAVENCEFACTURA, ARCHIVOENVIADO from TDETALLESPAGO '+
               '  where   Facturado = ''S''  AND CAE IS NOT NULL AND APROBADA=''SI'' '+
               ' and ARCHIVOENVIADO IS NULL  and rownum <=50 ');
aq.ExecSQL;
aq.open;
while not aq.eof do
  begin
    MEMO1.Clear;
    ARCHIVOENVIADO:=trim(aq.fieldbyname('ARCHIVOENVIADO').asSTRING) ;

  //IF (FILEEXISTS(ARCHIVOENVIADO)=false) OR (TRIM(ARCHIVOENVIADO)='') THEN
  //begin

    iddetallespago:=aq.fieldbyname('iddetallespago').asinteger;
    pagoidverificacion:=aq.fieldbyname('pagoid').asinteger;
    NRO_COMPROBANTEFACT:=trim(aq.fieldbyname('NRO_COMPROBANTE').asstring);
    CAEFACTURA:=trim(aq.fieldbyname('CAE').asSTRING) ;
    FECHAVENCEFACTURA:=trim(aq.fieldbyname('FECHAVENCEFACTURA').asSTRING) ;
    IMPORTEVERIFICACION:=trim(aq.fieldbyname('importe').asstring);
    plantaid:=aq.fieldbyname('plantaid').asinteger;
    CONTACTOEMAIL:=trim(aq.fieldbyname('EMAIL').asstring);
    TIPO_COMPROBANTE:=trim(aq.fieldbyname('TIPOCOMPROBANTEAFIP').asstring);

    aqFA:=tsqlquery.create(nil);
    aqFA.SQLConnection := MyBD;
    aqFA.sql.add('Select TO_CHAR(FECHALTA,''DD/MM/YYYY'') AS FE FROM TFACTURAS WHERE IDDETALLESPAGO='+INTTOSTR(iddetallespago));
    aqFA.ExecSQL;
    aqFA.open;
    fecha_comprobante:=AQFA.FIELDBYNAME('FE').AsString;
    AQFA.CLOSE;
    AQFA.FREE;


    aqinformapago:=tsqlquery.create(nil);
    aqinformapago.SQLConnection := MyBD;
    aqinformapago.sql.add('select codvehiculo, codclientefacturacion, dominio,tipodocufactelec from tinformacionpago '+
                          ' where (codvehiculo <> 0) '+
                          ' and (codclientefacturacion <> 0) and iddetallespago='+inttostr(iddetallespago));
    aqinformapago.ExecSQL;
    aqinformapago.open;
       if not aqinformapago.IsEmpty then
          begin
           codclientefacturacion:=aqinformapago.FiELDBYNAME('codclientefacturacion').ASINTEGER;
           patente_para_factura:=trim(aqinformapago.fieldbyname('dominio').asstring);
           DFTIPODOCUMENTO:=trim(aqinformapago.fieldbyname('tipodocufactelec').asstring);
            if trim(TIPO_COMPROBANTE)='FA' then
                begin
                  letra:='A';
                  tipo_cbte:=1;
                  STIPOCOMPROBANTE:='01';
                end;

            if trim(TIPO_COMPROBANTE)='FB' then
                begin
                  letra:='B';
                  tipo_cbte:=6;
                  STIPOCOMPROBANTE:='06';
                end;


            if trim(TIPO_COMPROBANTE)='FC' then
                 begin
                   letra:='C';
                   tipo_cbte:=11;
                   STIPOCOMPROBANTE:='11';
                 end;


             if trim(TIPO_COMPROBANTE)='CA' then
                  begin
                   letra:='A';
                   tipo_cbte:=3;
                   STIPOCOMPROBANTE:='03';
                  end;


            if trim(TIPO_COMPROBANTE)='CB' then
                  begin
                   letra:='B';
                   tipo_cbte:=8;
                   STIPOCOMPROBANTE:='08';
                  end;


             if trim(TIPO_COMPROBANTE)='CC' then
                     begin
                      letra:='C';
                      tipo_cbte:=33;
                      STIPOCOMPROBANTE:='33';
                     end;







             aqcliente:=tsqlquery.create(nil);
             aqcliente.SQLConnection := MyBD;
             aqcliente.sql.add('select codclien, tipodocu, document, nombre, apellid1,tiptribu, cuit_cli, genero '+
                                      'from tclientes where codclien ='+inttostr(codclientefacturacion));
             aqcliente.ExecSQL;
             aqcliente.open;

             DFNRODOCUMENTO:=trim(aqcliente.fieldbyname('document').AsString);
             numeroCuit:=trim(aqcliente.fieldbyname('cuit_cli').AsString);
             nombre_para_mail:=TRIM(aqcliente.FIELDBYNAME('nombre').AsString)+' '+TRIM(aqcliente.FIELDBYNAME('apellid1').AsString);
             aqcliente.close;
             aqcliente.Free;



               if (trim(DFTIPODOCUMENTO)='2')  then     //le
                    begin
                     tipo_doc:=89;
                     nro_doc:=TRIM(DFNRODOCUMENTO);
                    end;

               if  (trim(DFTIPODOCUMENTO)='3')  then // lc
                   begin
                     tipo_doc:=90;
                     nro_doc:=TRIM(DFNRODOCUMENTO);
                   end;

               if  (trim(DFTIPODOCUMENTO)='4')  then // dni ex
                  begin
                    tipo_doc:=91;
                    nro_doc:=TRIM(DFNRODOCUMENTO);
                  end;

               if  (trim(DFTIPODOCUMENTO)='5')  then // ced ex
                 begin
                   tipo_doc:=91;
                   nro_doc:=TRIM(DFNRODOCUMENTO);
                 end;

               if  (trim(DFTIPODOCUMENTO)='6')  then // pasaporte
                 begin
                   tipo_doc:=94;
                   nro_doc:=TRIM(DFNRODOCUMENTO);
                end;


              if (trim(DFTIPODOCUMENTO)='7')    //otros
                 or (trim(DFTIPODOCUMENTO)='8')
                 or (trim(DFTIPODOCUMENTO)='10')
                 or (trim(DFTIPODOCUMENTO)='11')
                  or (trim(DFTIPODOCUMENTO)='12')
                 or (trim(DFTIPODOCUMENTO)='13') then
                  begin
                    tipo_doc:=99;
                    nro_doc:=TRIM(DFNRODOCUMENTO);

                  end;




              if trim(DFTIPODOCUMENTO)='1' then   //dni
                begin
                  tipo_doc:=96;
                  nro_doc:=TRIM(DFNRODOCUMENTO);
                end;


             if trim(DFTIPODOCUMENTO)='9' then   //cuit
               begin
                  IF TRIM(numeroCuit)='' THEN
                     numeroCuit:=DFNRODOCUMENTO;


                tipo_doc:=80;
                POSI:=POS('-',TRIM(numeroCuit));
                  IF POSI > 0 THEN
                    BEGIN
                      nro_doc:='';
                      nro_doc1:=TRIM(numeroCuit);
                        FOR I:=1 TO LENGTH(TRIM(nro_doc1)) DO
                          BEGIN
                            IF TRIM(nro_doc1[I])<>'-' THEN
                                nro_doc:=nro_doc + TRIM(nro_doc1[I]);
                           end;

                    END else
                       nro_doc:=TRIM(numeroCuit);

              end;











   punto_vta:=FA.PUNTOVENTAFAE;
   cbt_desde:='0';
   cbt_hasta:='0';
   para_Actualizar_numero:='1';
   para_Actualizar_compro:='1';

  //IMPORTEVERIFICACION:='12.10';
  imp_total:=trim(IMPORTEVERIFICACION);//'12.10';
  IMPORTEVERIFICACION:= StringReplace(TRIM(IMPORTEVERIFICACION), '.', ',',
                          [rfReplaceAll, rfIgnoreCase]);

  IMPORTE_SIN_IVA:=STRTOFLOAT(IMPORTEVERIFICACION)/1.21;
  IMPORTE_IVA:=STRTOFLOAT(IMPORTEVERIFICACION) - IMPORTE_SIN_IVA;
  imp_tot_conc:='0.00';
  IMP_NETO:=FLOATTOSTRF(IMPORTE_SIN_IVA,FFFIXED,8,2);
  IMP_IVA:=FLOATTOSTRF(IMPORTE_IVA,FFFIXED,8,2);
  imp_trib:='0.00';
  imp_op_ex:='0.00';

  IMP_NETO:= StringReplace(TRIM(IMP_NETO), ',', '.',
                          [rfReplaceAll, rfIgnoreCase]);


IMP_IVA:= StringReplace(TRIM(IMP_IVA), ',', '.',
                          [rfReplaceAll, rfIgnoreCase]);


F1:=COPY(trim(fecha),7,4);
F2:=COPY(trim(fecha),4,2);
F3:=COPY(trim(fecha),1,2);
FECHA:=F1+F2+F3;
DateTimeToString(Fecha, 'yyyymmdd', date);
fecha_cbte:=trim(fecha);
fecha_venc_pago:=trim(fecha);
fecha_serv_desde:=trim(fecha);
fecha_serv_hasta:=trim(fecha);
moneda_id := 'PES';
moneda_ctz := '1.000';
//IMPORTE_PARA21_s:='504.14';
IMPORTE_PARA21_s:=IMP_NETO;

//IVA21:='105.86';
IVA21:=IMP_IVA;


    NRO_COMPROBANTE:=NRO_COMPROBANTEFACT;
    APRO:='SI' ;

    {generar pdf}
    if trim(letra)='A' then
       archivo:=generar_pdf(NRO_COMPROBANTE,CAEFACTURA,FECHAVENCEFACTURA,IMP_NETO,IVA21,imp_total,STIPOCOMPROBANTE,INTTOSTR(punto_vta),iddetallespago,letra,patente_para_factura,nombre_para_mail,DFTIPODOCUMENTO,nro_doc,codclientefacturacion,fa.MODO_FAE,iddetallespago,fecha_comprobante)
    else

       archivo:=generar_pdf_B(NRO_COMPROBANTE,CAEFACTURA,FECHAVENCEFACTURA,IMP_NETO,IVA21,imp_total,STIPOCOMPROBANTE,INTTOSTR(punto_vta),iddetallespago,letra,patente_para_factura,nombre_para_mail,DFTIPODOCUMENTO,nro_doc,codclientefacturacion,fa.MODO_FAE,iddetallespago,fecha_comprobante);


      memo1.Lines.Add('ARCHIVO PDF GENERADO: FACT: NRO_COMPROBANTE');


               MyBD.StartTransaction(TD);
            TRY

              aqQ:=tsqlquery.create(nil);
              aqQ.SQLConnection := MyBD;
              aqQ.CLOSE;
              aqQ.SQL.CLEAR;
              aqQ.sql.add('UPDATE tdetallespago SET   ARCHIVOENVIADO='+#39+archivo+#39+'  WHERE  iddetallespago='+INTTOSTR(iddetallespago));
              AQQ.ExecSQL;

              MYBD.Commit(TD);

           EXCEPT
              MyBD.Rollback(TD);
           END ;


          AQQ.close;
          AQQ.free;






        continua:=TRUE;



         {ENVIAR MAIL}
      {    if continua=true then
        begin
         if EnviarMensaje(TRIM(CONTACTOEMAIL),NRO_COMPROBANTE,archivo,nombre_para_mail,patente_para_factura)=true then
            se_envio:='S'
            ELSE
            SE_ENVIO:='N';

            MyBD.StartTransaction(TD);
            TRY

              aqQ:=tsqlquery.create(nil);
              aqQ.SQLConnection := MyBD;
              aqQ.CLOSE;
              aqQ.SQL.CLEAR;
              aqQ.sql.add('UPDATE tdetallespago SET   ENVIOMAIL='+#39+SE_ENVIO+#39+',  ERROR_MAIL='+#39+TRIM(ERROR_MAIL)+#39+ '  WHERE  iddetallespago='+INTTOSTR(iddetallespago));
              AQQ.ExecSQL;

              MYBD.Commit(TD);

           EXCEPT
              MyBD.Rollback(TD);
           END ;


          AQQ.close;
          AQQ.free;


     end ELSE BEGIN
     
      END;    }

  {FIN ENVIAR MAIL}








 end else begin

     form1.EnviarMensaje_ERROR('martin.bien@applus.com',' no se genero comprobante.no tiene datos en tinformacionpago. iddetallespago='+INTTOSTR(iddetallespago),'',inttostr(tx.ver_PLANTA));

 end; //tinformacionpago
   aqinformapago.close;
   aqinformapago.free;

//END;//ARCHVIO ENVIDO EXISTE

aq.next;
end;    //while



    AQ.Close;
    AQ.FREE;




   EXCEPT
   on E : Exception do
   BEGIN

    TX.TRAZAS('ERROR LA GENERAR LA FACTURA ELECTRONICA'+E.ClassName+'. iddetallespago='+INTTOSTR(iddetallespago)+'. ERROR: '+E.Message);
    form1.EnviarMensaje_ERROR('martin.bien@applus.com',' no se genero comprobante. iddetallespago='+INTTOSTR(iddetallespago),'',inttostr(tx.ver_PLANTA));


   END;

END ;



end;

function tform1.control_nc_flota(planta,iddetallespagoPARAMETRO:longint):boolean;
var sqlnc,sqlfactura:tsqlquery;
importe_nc,importe_FA:string;   pagoid:longint;
begin
control_nc_flota:=FALSE;
sqlnc:=tsqlquery.create(nil);
sqlnc.SQLConnection := MyBD;
sqlnc.sql.add('Select  pagoid, importe from TDETALLESPAGO '+
               '  where estadoacreditacion = ''D'' AND Facturado = ''N'' '+
               ' and plantaid='+inttostr(planta)+' AND iddetallespago='+INTTOSTR(iddetallespagoPARAMETRO));
sqlnc.ExecSQL;
sqlnc.open;

if not sqlnc.IsEmpty then
begin
 importe_nc:=trim(sqlnc.fieldbyname('importe').asstring);
 pagoid:=sqlnc.fieldbyname('pagoid').asinteger;



 sqlfactura:=tsqlquery.create(nil);
 sqlfactura.SQLConnection := MyBD;
 sqlfactura.sql.add('Select  pagoid, importe from TDETALLESPAGO '+
               '  where estadoacreditacion = ''A'' AND Facturado = ''S'' '+
               ' and plantaid='+inttostr(planta)+' AND pagoid='+INTTOSTR(pagoid));
 sqlfactura.ExecSQL;
 sqlfactura.open;

  if not sqlfactura.IsEmpty then
   begin
    importe_FA:=trim(sqlfactura.fieldbyname('importe').asstring);


      IF TRIM(importe_FA)=TRIM(importe_nc) THEN
         control_nc_flota:=TRUE;

  END;

 sqlfactura.Close;
sqlfactura.Free;
end;


  sqlNC.Close;
sqlNC.Free;


end;

function TForm1.controla_servicio_prestado(iddetallespago, pagoid:longint):boolean;
var aqfact:tsqlquery;
 r:string;
begin
 controla_servicio_prestado:=false;

    aqfact:=tsqlquery.create(nil);
    aqfact.SQLConnection := MyBD;
    aqfact.sql.add(' select TDH.CODINSPE, tdh.pagoidverificacion '+
                   ' from tdetallespago tdet, tdatosturnohistorial tdh, tinspeccion ti '+
                   ' where tdet.pagoid = '+inttostr(pagoid)+
                   ' and ti.tipo = ''A''   '+
                   ' and TI.INSPFINA = ''S'' '+
                   ' and tdet.pagoid = tdh.pagoidverificacion '+
                   ' and tdh.codinspe = ti.codinspe');
    aqfact.ExecSQL;
    aqfact.open;
    if  not (aqfact.IsEmpty) then
    begin
    r:='Servicio Prestado. No se realiza NC';
      // aqfact.SQLConnection := MyBD;
      // aqfact.Close;
       aqfact.SQL.Clear;
       aqfact.sql.add('update tdetallespago  set facturado=''P'',  respuestaafip='#39+r+#39' where iddetallespago='+inttostr(iddetallespago));
       aqfact.ExecSQL;
    
     controla_servicio_prestado:=true;
    end ;

    aqfact.Close;
    aqfact.Free;
    

end;


FUNCTION TForm1.GENERAR_NOTACREDRITOS_ELECTRONICAS_PAGOS_SUVTV(planta,iddetallespagoPARAMETRO:longint):BOOLEAN;

var id_SERVICIO:longint;
    TIPO_COMPROBANTE,LETRA:STRING;
    TURNOID:LONGINT;
    TIPOTURNO:STRING;
    FECHATURNO:STRING;
    HORATURNO:STRING;
    FECHAREGISTRO:STRING;
    DFGENERO:STRING;
    DFTIPODOCUMENTO:STRING;
    DFNRODOCUMENTO:STRING;
    DFNOMBRE:STRING;
    DFAPELLIDO:STRING;
    DFCALLE:STRING;
    DFNUMEROCALLE:STRING;
    DFPISO:STRING;
    DFDEPARTAMENTO:STRING;
    DFLOCALIDAD:STRING;
    DFPROVINCIAID:STRING;
    DFPROVINCIA:STRING;
    DFCODIGOPOSTAL:STRING;
    DFIVA:STRING;
    DFIIBB:STRING;
    PAGOSID:STRING;
    PAGOSGETWAY:STRING;
    PAGOSENTIDADID:STRING;
    PAGOSENTIDAD:STRING;
    PAGOSFECHA:STRING;
    PAGOSIMPORTE:STRING;
    PAGOSESTADOLIQUIDACION:STRING;
    CODVEHIC:LONGINT;
    CODCLIEN:LONGINT;
    AUSENTE:STRING;
    FACTURADO:STRING;
    REVISO:STRING;
    DVNUMERO:STRING;
    CODINSPE:LONGINT;
    ANIO:LONGINT;
    fecha,APRO:string;
     CONTACTOEMAIL:STRING;


punto_vta:longint;
cbt_desde:string;
cbt_hasta:string;
para_Actualizar_numero:string;
para_Actualizar_compro:string;
tipo_cbte:longint;

 NRO_COMPROBANTE:STRING;
imp_total:string;
imp_tot_conc:string;
imp_neto:string;
imp_iva:string;
imp_trib:string;
imp_op_ex:string;
 IMPORTEVERIFICACION,patente_para_factura:sTRING;
  F1:string;
  F2:string;
  F3:string;
   numeroCuit:string;
 tipo_doc:longint;
 nro_doc:string;
 nro_doc1:string;
fecha_cbte:string;
fecha_venc_pago:string;
fecha_serv_desde:string;
fecha_serv_hasta,nombre_archivo:string;
moneda_id,SE_ENVIO ,STIPOCOMPROBANTE:string;
moneda_ctz,ERROR :string;
IMPORTE_PARA21_s,TIPOCOMPROBANTEAFIP:string;
IVA21:string;        aqQm,aqcliente,aqesreve:tsqlquery;
aq,aqQ,aqinformapago:tsqlquery ;
posi,i:longint;     archivo,nombre_para_mail,ESTADOID:string;
TD: TTransactionDesc;
  IMPORTE_SIN_IVA,IMPORTE_IVA:REAL;  tbase:Tbase64Pdf;   B64,M5:STRING;
  pagoidverificacion,iddetallespago,plantaid,codclientefacturacion,idplantaid:longint;
      Stream: TMemoryStream;
  Texto_encode,texto_md5,archi: String;


   informada_fact:STRING;
begin

//control para no hacer nc a flota con distitnos importe
  IF control_nc_flota(PLANTA,iddetallespagoPARAMETRO)=FALSE THEN
  BEGIN



  END ELSE BEGIN


//**********************************************



TRY
IMPORTE_SIN_IVA:=0;
IMPORTE_IVA:=0;
 fecha:=datetostr(date);
 id_SERVICIO:=2;
 TIPO_COMPROBANTE:='FAC';

 //FECHA:='22/07/2016';


aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
aq.sql.add('Select iddetallespago, pagoid, importe, plantaid,TIPOCOMPROBANTEAFIP,EMAIL from TDETALLESPAGO '+
               '  where estadoacreditacion = ''D'' AND Facturado = ''N'' '+
               ' and plantaid='+inttostr(planta)+' AND iddetallespago='+INTTOSTR(iddetallespagoPARAMETRO));
aq.ExecSQL;
aq.open;
while not aq.eof do
  begin
    iddetallespago:=aq.fieldbyname('iddetallespago').asinteger;
    pagoidverificacion:=aq.fieldbyname('pagoid').asinteger;

     //condicion de reves
  {if veririca_si_es_una_reve(iddetallespago)=false then
    begin }


   if controla_servicio_prestado(iddetallespago, pagoidverificacion)=false then
      begin

      IF  (exiete_idpago_en_tfactura_PARANC(pagoidverificacion)=TRUE) then  {SI EXISTE EN TFACTURAS HAGO LA NC}
        BEGIN
          IMPORTEVERIFICACION:=trim(aq.fieldbyname('importe').asstring);
          plantaid:=aq.fieldbyname('plantaid').asinteger;
          CONTACTOEMAIL:=trim(aq.fieldbyname('EMAIL').asstring);
          TIPO_COMPROBANTE:=trim(aq.fieldbyname('TIPOCOMPROBANTEAFIP').asstring);

          aqinformapago:=tsqlquery.create(nil);
          aqinformapago.SQLConnection := MyBD;
          aqinformapago.sql.add('select codvehiculo, codclientefacturacion, dominio,tipodocufactelec from tinformacionpago '+
                                   ' where (codvehiculo <> 0) '+
                                   ' and (codclientefacturacion <> 0) and iddetallespago='+inttostr(iddetallespago));
          aqinformapago.ExecSQL;
          aqinformapago.open;
            if not aqinformapago.IsEmpty then
               begin

                codclientefacturacion:=aqinformapago.FiELDBYNAME('codclientefacturacion').ASINTEGER;
                patente_para_factura:=trim(aqinformapago.fieldbyname('dominio').asstring);
                DFTIPODOCUMENTO:=trim(aqinformapago.fieldbyname('tipodocufactelec').asstring);

                 If trim(TIPO_COMPROBANTE)='CA' then
                   begin
                        letra:='A';
                        tipo_cbte:=3;
                        STIPOCOMPROBANTE:='03';
                   end;

                    if trim(TIPO_COMPROBANTE)='CB' then
                    begin
                         letra:='B';
                         tipo_cbte:=8;
                         STIPOCOMPROBANTE:='08';

                     end;


                       if trim(TIPO_COMPROBANTE)='CC' then
                         begin
                         letra:='B';
                         tipo_cbte:=13;
                         STIPOCOMPROBANTE:='13';

                     end;

                     aqinformapago.close;
                     aqinformapago.Free;

                    aqcliente:=tsqlquery.create(nil);
                    aqcliente.SQLConnection := MyBD;
                    aqcliente.sql.add('select codclien, tipodocu, document, nombre, apellid1,tiptribu, cuit_cli, genero '+
                                      'from tclientes where codclien ='+inttostr(codclientefacturacion));
                    aqcliente.ExecSQL;
                    aqcliente.open;

                    DFNRODOCUMENTO:=trim(aqcliente.fieldbyname('document').AsString);
                    numeroCuit:=trim(aqcliente.fieldbyname('cuit_cli').AsString);



                     nombre_para_mail:=TRIM(aqcliente.FIELDBYNAME('nombre').AsString)+' '+TRIM(aqcliente.FIELDBYNAME('apellid1').AsString);





                     aqcliente.close;
                     aqcliente.Free;



                 if  (trim(DFTIPODOCUMENTO)='2')  then     //le
                    begin
                     tipo_doc:=89;
                     nro_doc:=TRIM(DFNRODOCUMENTO);
                    end;

                 if  (trim(DFTIPODOCUMENTO)='3')  then // lc
                   begin
                     tipo_doc:=90;
                     nro_doc:=TRIM(DFNRODOCUMENTO);
                   end;

                if  (trim(DFTIPODOCUMENTO)='4')  then // dni ex
                  begin
                   tipo_doc:=91;
                   nro_doc:=TRIM(DFNRODOCUMENTO);
                  end;

                if  (trim(DFTIPODOCUMENTO)='5')  then // ced ex
                 begin
                  tipo_doc:=91;
                 nro_doc:=TRIM(DFNRODOCUMENTO);
                end;

                if  (trim(DFTIPODOCUMENTO)='6')  then // pasaporte
                 begin
                  tipo_doc:=94;
                  nro_doc:=TRIM(DFNRODOCUMENTO);
                end;


             if (trim(DFTIPODOCUMENTO)='7')    //otros
                 or (trim(DFTIPODOCUMENTO)='8')
                 or (trim(DFTIPODOCUMENTO)='10')
                 or (trim(DFTIPODOCUMENTO)='11')
                  or (trim(DFTIPODOCUMENTO)='12')
                 or (trim(DFTIPODOCUMENTO)='13') then
              begin
                    tipo_doc:=99;
                    nro_doc:=TRIM(DFNRODOCUMENTO);

              end;




          if trim(DFTIPODOCUMENTO)='1' then   //dni
            begin
            tipo_doc:=96;
            nro_doc:=TRIM(DFNRODOCUMENTO);
           end;


          if trim(DFTIPODOCUMENTO)='9' then   //cuit
           begin
           IF TRIM(numeroCuit)='' THEN
              numeroCuit:=DFNRODOCUMENTO;

             tipo_doc:=80;
             POSI:=POS('-',TRIM(numeroCuit));
              IF POSI > 0 THEN
               BEGIN
                nro_doc:='';
                nro_doc1:=TRIM(numeroCuit);
                 FOR I:=1 TO LENGTH(TRIM(nro_doc1)) DO
                  BEGIN
                    IF TRIM(nro_doc1[I])<>'-' THEN
                      nro_doc:=nro_doc + TRIM(nro_doc1[I]);
                   end;

              END else
                nro_doc:=TRIM(numeroCuit);

         end;











punto_vta:=FA.PUNTOVENTAFAE;
cbt_desde:='0';
cbt_hasta:='0';
para_Actualizar_numero:='1';
para_Actualizar_compro:='1';

//IMPORTEVERIFICACION:='12.10';
imp_total:=trim(IMPORTEVERIFICACION);//'12.10';


 IMPORTEVERIFICACION:= StringReplace(TRIM(IMPORTEVERIFICACION), '.', ',',
                          [rfReplaceAll, rfIgnoreCase]);


IMPORTE_SIN_IVA:=STRTOFLOAT(IMPORTEVERIFICACION)/1.21;
IMPORTE_IVA:=STRTOFLOAT(IMPORTEVERIFICACION) - IMPORTE_SIN_IVA;
imp_tot_conc:='0.00';
IMP_NETO:=FLOATTOSTRF(IMPORTE_SIN_IVA,FFFIXED,8,2);
IMP_IVA:=FLOATTOSTRF(IMPORTE_IVA,FFFIXED,8,2);
imp_trib:='0.00';
imp_op_ex:='0.00';


 IMP_NETO:= StringReplace(TRIM(IMP_NETO), ',', '.',
                          [rfReplaceAll, rfIgnoreCase]);


 IMP_IVA:= StringReplace(TRIM(IMP_IVA), ',', '.',
                          [rfReplaceAll, rfIgnoreCase]);


  F1:=COPY(trim(fecha),7,4);
  F2:=COPY(trim(fecha),4,2);
  F3:=COPY(trim(fecha),1,2);
  FECHA:=F1+F2+F3;
  DateTimeToString(Fecha, 'yyyymmdd', date);

fecha_cbte:=trim(fecha);
fecha_venc_pago:=trim(fecha);
fecha_serv_desde:=trim(fecha);
fecha_serv_hasta:=trim(fecha);
moneda_id := 'PES';
moneda_ctz := '1.000';
//IMPORTE_PARA21_s:='504.14';
IMPORTE_PARA21_s:=IMP_NETO;

//IVA21:='105.86';
IVA21:=IMP_IVA;





if fa.procesar_comprobante(id_SERVICIO, tipo_doc, nro_doc, tipo_cbte, punto_vta,
     STRTOINT(cbt_desde), STRTOINT(cbt_hasta), imp_total, imp_tot_conc, imp_neto,
      imp_iva, imp_trib, imp_op_ex, fecha_cbte, fecha_venc_pago,
      fecha_serv_desde, fecha_serv_hasta,
      moneda_id, moneda_ctz,IMPORTE_PARA21_s,IVA21,fa.Token,fa.Sign,fa.CUIT_EMPRESA,fa.MODO_FAE,LETRA, MyBD,TURNOID) =true then
begin



      NRO_COMPROBANTE:='000'+INTTOSTR(punto_vta)+'-'+ARMAR_NUMERO_FACTURA(INTTOSTR(FA.ULTIMO));

      APRO:='SI' ;



      nombre_archivo:=TIPO_COMPROBANTE+LETRA+INTTOSTR(FA.ULTIMO);



      MyBD.StartTransaction(TD);
       TRY
        informada_fact:='N';
        aqQ:=tsqlquery.create(nil);
        aqQ.SQLConnection := MyBD;
        aqQ.CLOSE;
        aqQ.SQL.CLEAR;
        aqQ.sql.add('UPDATE tdetallespago SET FACTURADO=''S'', CAE='+#39+TRIM(FA.cae)+#39+
                    ', APROBADA='+#39+APRO+#39+
                    ', FECHAVENCEFACTURA='+#39+TRIM(FA.fecha_vence)+#39+
                    ', RESPUESTAAFIP='+#39+TRIM(FA.OBSERVACIONES_CAE)+#39+
                    ', NRO_COMPROBANTE='+#39+TRIM(NRO_COMPROBANTE)+#39+
                    ', ENVIOMAIL='+#39+TRIM(informada_fact)+#39+
                    ', INFORMADA='+#39+TRIM(informada_fact)+#39+
                    '   WHERE iddetallespago='+INTTOSTR(iddetallespago));
        AQQ.ExecSQL;



        MYBD.Commit(TD);

        EXCEPT
            MyBD.Rollback(TD);
        END;
          aqQ.Close;
          aqQ.free;

          Genera_NOTA_CREDITO_SAG_v2(iddetallespago,pagoidverificacion,'S',FA.ULTIMO,punto_vta,FA.cae,FA.fecha_vence);



           {generar pdf}
        if trim(letra)='A' then
              archivo:=generar_pdf(NRO_COMPROBANTE,FA.cae,FA.fecha_vence,IMP_NETO,IVA21,imp_total,STIPOCOMPROBANTE,INTTOSTR(punto_vta),iddetallespago,letra,patente_para_factura,nombre_para_mail,DFTIPODOCUMENTO,nro_doc,codclientefacturacion,fa.MODO_FAE,iddetallespago,datetostr(date))
              else
             archivo:=generar_pdf_B(NRO_COMPROBANTE,FA.cae,FA.fecha_vence,IMP_NETO,IVA21,imp_total,STIPOCOMPROBANTE,INTTOSTR(punto_vta),iddetallespago,letra,patente_para_factura,nombre_para_mail,DFTIPODOCUMENTO,nro_doc,codclientefacturacion,fa.MODO_FAE,iddetallespago,datetostr(date));




             

      MyBD.StartTransaction(TD);
       TRY

        aqQ:=tsqlquery.create(nil);
        aqQ.SQLConnection := MyBD;
        aqQ.CLOSE;
        aqQ.SQL.CLEAR;
        aqQ.sql.add('UPDATE tdetallespago SET  ARCHIVOENVIADO='+#39+TRIM(archivo)+#39+'   WHERE iddetallespago='+INTTOSTR(iddetallespago));
        AQQ.ExecSQL;



        MYBD.Commit(TD);

        EXCEPT
            MyBD.Rollback(TD);
        END;
          aqQ.Close;
          aqQ.free;


          nombre_archivo:=ExtractFilePath(Application.ExeName)+'FACT_SUVTV\'+nombre_archivo+'.pdf';
         CopyFile(PChar(archivo), PChar(nombre_archivo), true);




         

      try
        Stream:= TMemoryStream.Create;
         try
           Stream.LoadFromFile(nombre_archivo);
           Texto_encode:= base64_new.BinToStr(Stream.Memory,Stream.Size);
           texto_md5:=base64_new.md5_suvtv(nombre_archivo);
        if  INFORMAR_FACTURA(inttostr(pagoidverificacion),
                      NRO_COMPROBANTE,
                      inttostr(tipo_cbte),
                      '',
                      imp_total,
                      IMP_NETO,
                      IVA21,
                      FA.cae,
                      FA.fecha_vence,
                      'NC',
                      datetostr(date),
                      Texto_encode,texto_md5)=true then

               informada_fact:='S'
              ELSE
               informada_fact:='N';
        

                if strtoint(trim(tx.ver_respuestaid_factura_informar_factura))=1 then
                    informada_fact:='S'
                    else
                    informada_fact:='N';

                  IF informada_fact='S' THEN
                   MEMO1.Lines.Add('INFORMA NC: SI . '+TRIM(TX.ver_respuestamensaje_factura_informar_factura))
                   ELSE
                   MEMO1.Lines.Add('INFORMA NC: NO . '+TRIM(TX.ver_respuestamensaje_factura_informar_factura));

                  APPLICATION.ProcessMessages;

                 MyBD.StartTransaction(TD);
                 TRY
                  aqQ:=tsqlquery.create(nil);
                  aqQ.SQLConnection := MyBD;
                  aqQ.CLOSE;
                  aqQ.SQL.CLEAR;
                  aqQ.sql.add('UPDATE tdetallespago SET  INFORMADA='+#39+TRIM(informada_fact)+#39+', FECHAINFORMA=SYSDATE, RESPUESTAINFORMAR='+#39+TRIM(TX.ver_respuestamensaje_factura_informar_factura)+#39+'   WHERE iddetallespago='+INTTOSTR(iddetallespago));
                  AQQ.ExecSQL;


                  MYBD.Commit(TD);

                  EXCEPT
                    MyBD.Rollback(TD);

                  END ;

                AQQ.close;
                AQQ.free;






          finally
            Stream.Free;
          end;

     except
       on E : Exception do
         BEGIN
         form1.EnviarMensaje_ERROR('martin.bien@applus.com','ERROR AL GENERAR PDF BASE64. iddetallespago='+INTTOSTR(iddetallespago)+'. ERROR: '+E.Message,'',inttostr(tx.ver_PLANTA));

         END;
    end;





           //   se_envio:='N';

         {ENVIAR MAIL}

        {if EnviarMensaje(TRIM(CONTACTOEMAIL),NRO_COMPROBANTE,archivo,nombre_para_mail,patente_para_factura)=true then
            se_envio:='S'
            ELSE   
            SE_ENVIO:='N';  }

             

        se_envio:='S';







        MyBD.StartTransaction(TD);
       TRY

      aqQ:=tsqlquery.create(nil);
      aqQ.SQLConnection := MyBD;
      aqQ.CLOSE;
      aqQ.SQL.CLEAR;
      aqQ.sql.add('UPDATE tdetallespago SET   ENVIOMAIL='+#39+SE_ENVIO+#39+',  ERROR_MAIL='+#39+TRIM(ERROR_MAIL)+#39+ '  WHERE  iddetallespago='+INTTOSTR(iddetallespago));
      AQQ.ExecSQL;

         MYBD.Commit(TD);






        EXCEPT
            MyBD.Rollback(TD);
        END ;


     AQQ.close;
     AQQ.free;

         {FIN ENVIAR MAIL}
end ELSE BEGIN
 ERROR:= StringReplace(TRIM(FA.OBSERVACIONES_CAE), '''', ' ',
                          [rfReplaceAll, rfIgnoreCase]);
APRO:='NO' ;
MyBD.StartTransaction(TD);
       TRY
      aqQ:=tsqlquery.create(nil);
      aqQ.SQLConnection := MyBD;
       aqQ.CLOSE;
      aqQ.SQL.CLEAR;
      aqQ.sql.add('UPDATE tdetallespago SET FACTURADO=''N'', CAE=NULL, FECHAVENCEFACTURA=NULL, RESPUESTAAFIP='+#39+TRIM(ERROR)+#39+
      ', APROBADA='+#39+APRO+#39+', NRO_COMPROBANTE=NULL   WHERE  iddetallespago='+INTTOSTR(iddetallespago));
      AQQ.ExecSQL;

          MYBD.Commit(TD);

          TX.TRAZAS('AFIP NO VALIDO EL COMPROBANTE.  iddetallespago='+INTTOSTR(iddetallespago));

        EXCEPT
            MyBD.Rollback(TD);
        END ;

      AQQ.close;
     AQQ.free;
END;






 end; //tinformacionpago

END;// SI EXISTE EN TFACTURAS


{end;//es_reve }

end;//servicio prestado

aq.next;
end;    //while



    AQ.Close;
    AQ.FREE;



   EXCEPT
   on E : Exception do
   BEGIN

    TX.TRAZAS('ERROR LA GENERAR LA NOTA DE CREDITO ELECTRONICA'+E.ClassName+'. iddetallespago='+INTTOSTR(iddetallespago)+'. ERROR: '+E.Message);
   END;

END ;




END;

end;


function TForm1.renviar_mail_facturas:boolean;
var aq,aqQ:tsqlquery;
SE_ENVIO,ERROR_MAIL,linea,maile:string;   iddetallespago,posi:LONGINT;
CONTACTOEMAIL,NRO_COMPROBANTE,archivo,nombre_para_mail,patente_para_factura:string;
archi:textfile; idturn:longint;
begin
assignfile(archi,'C:\APPLUS\DESARROLLO STARTEAM\EN DESARROLLOS\SISTEMA SAG VTV\VTVSAG CAPITAL FEDERAL\WS XML CABA V2\fact_faltantes\email.txt');
 reset(archi);
 while not eof(archi) do
 begin
 readln(archi,linea);
  posi:=pos('|',trim(linea));

  idturn:=strtoint(trim(copy(trim(linea),0,posi-1)));
  linea:=trim(copy(trim(linea),posi+1,length(trim(linea))));
  posi:=pos('|',trim(linea));
  maile:=trim(copy(trim(linea),0,posi-1));
  archivo:=trim(copy(trim(linea),posi+1,length(trim(linea))));


   aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aq.sql.add(' select TD.DVDOMINO, td.CONTACTOEMAIL, TC.NOMBRE,TC.APELLID1,td.NRO_COMPROBANTE from tdatosturno td, tclientes tc '+
              ' where TD.CODCLIEN=TC.CODCLIEN  '+
              ' and TD.TURNOID='+inttostr(idturn));
   aq.ExecSQL;
   aq.open;
    while not aq.eof do
    begin

        CONTACTOEMAIL:=trim(aq.fiELdS[1].asstring);

        //archivo:=trim(aq.fiELdS[2].asstring);
        nombre_para_mail:=trim(aq.fiELdS[2].asstring)+' '+trim(aq.fiELdS[3].asstring);
        patente_para_factura:=trim(aq.fiELdS[0].asstring);
        NRO_COMPROBANTE:=trim(aq.fiELdS[4].asstring);
        memo1.Lines.Add(contactoemail);
      if EnviarMensaje(TRIM(CONTACTOEMAIL),NRO_COMPROBANTE,archivo,nombre_para_mail,patente_para_factura)=true then
      BEGIN
            se_envio:='S';
            ERROR_MAIL:='ENVIO OK';
            memo1.Lines.Add('ENVIO OK');
       END     ELSE
            begin
            SE_ENVIO:='N';
             ERROR_MAIL:='ERROR AL ENVIAR EL MAIL';
             memo1.Lines.Add('ERROR AL ENVIAR EL MAIL');
            end;






      aq.Next;
      end;


end;//while

  memo1.Lines.Add('termino');

end;




FUNCTION TForm1.GENERAR_FACTURAS_ELECTRONICAS_IDTURNOS(IDTURNO:LONGINT):BOOLEAN;

var id_SERVICIO:longint;
    TIPO_COMPROBANTE,LETRA:STRING;
    TURNOID:LONGINT;
    TIPOTURNO:STRING;
    FECHATURNO:STRING;
    HORATURNO:STRING;
    FECHAREGISTRO:STRING;
    DFGENERO:STRING;
    DFTIPODOCUMENTO:STRING;
    DFNRODOCUMENTO:STRING;
    DFNOMBRE:STRING;
    DFAPELLIDO:STRING;
    DFCALLE:STRING;
    DFNUMEROCALLE:STRING;
    DFPISO:STRING;
    DFDEPARTAMENTO:STRING;
    DFLOCALIDAD:STRING;
    DFPROVINCIAID:STRING;
    DFPROVINCIA:STRING;
    DFCODIGOPOSTAL:STRING;
    DFIVA:STRING;
    DFIIBB:STRING;
    PAGOSID:STRING;
    PAGOSGETWAY:STRING;
    PAGOSENTIDADID:STRING;
    PAGOSENTIDAD:STRING;
    PAGOSFECHA:STRING;
    PAGOSIMPORTE:STRING;
    PAGOSESTADOLIQUIDACION:STRING;
    CODVEHIC:LONGINT;
    CODCLIEN:LONGINT;
    AUSENTE:STRING;
    FACTURADO:STRING;
    REVISO:STRING;
    DVNUMERO:STRING;
    CODINSPE:LONGINT;
    ANIO:LONGINT;
    fecha,APRO:string;
     CONTACTOEMAIL:STRING;


punto_vta:longint;
cbt_desde:string;
cbt_hasta:string;
para_Actualizar_numero:string;
para_Actualizar_compro:string;
tipo_cbte:longint;

 NRO_COMPROBANTE:STRING;
imp_total:string;
imp_tot_conc:string;
imp_neto:string;
imp_iva:string;
imp_trib:string;
imp_op_ex:string;
 IMPORTEVERIFICACION,patente_para_factura:sTRING;
  F1:string;
  F2:string;
  F3:string;
   numeroCuit:string;
 tipo_doc:longint;
 nro_doc:string;
 nro_doc1:string;
fecha_cbte:string;
fecha_venc_pago:string;
fecha_serv_desde:string;
fecha_serv_hasta:string;
moneda_id,SE_ENVIO ,STIPOCOMPROBANTE:string;
moneda_ctz,ERROR :string;
IMPORTE_PARA21_s,TIPOCOMPROBANTEAFIP:string;
IVA21:string;        aqQm:tsqlquery;
aq,aqQ:tsqlquery ;
posi,i:longint;     archivo,nombre_para_mail,ESTADOID:string;
TD: TTransactionDesc;    pagoidverificacion:longint;
  IMPORTE_SIN_IVA,IMPORTE_IVA:REAL;
begin
TRY
IMPORTE_SIN_IVA:=0;
IMPORTE_IVA:=0;
 fecha:=datetostr(date);
 id_SERVICIO:=2;
 TIPO_COMPROBANTE:='FAC';

 //FECHA:='22/07/2016';

    aq:=tsqlquery.create(nil);
    aq.SQLConnection := MyBD;


    aq.sql.add('SELECT TURNOID	,TIPOTURNO	, dvdomino,'+
               ' FECHATURNO, '+
               ' HORATURNO	, '+
               ' FECHAREGISTRO	, '+
               ' DFGENERO,  '+
               ' DFTIPODOCUMENTO,  '+
               ' DFNRODOCUMENTO,'+
               ' DFNOMBRE,  '+
               ' DFAPELLIDO	,'+
               ' DFCALLE	, '+
               ' DFNUMEROCALLE,'+
               ' DFPISO, '+
               ' DFDEPARTAMENTO, '+
               ' DFLOCALIDAD	, '+
               ' DFPROVINCIAID	, '+
               ' DFPROVINCIA	, '+
               ' DFCODIGOPOSTAL	, '+
               ' DFIVA	,'+
               ' DFIIBB, '+
               ' PAGOSID	,'+
               ' PAGOSGETWAY	,  '+
               ' PAGOSENTIDADID	, '+
               ' PAGOSENTIDAD,'+
               ' PAGOSFECHA	, '+
               ' PAGOSIMPORTE	,'+
               ' PAGOSESTADOLIQUIDACION	,'+
               ' CODVEHIC	, '+
               ' CODCLIEN	, '+
               ' AUSENTE	, '+
               ' FACTURADO	, '+
               ' REVISO	, '+
               ' DVNUMERO	, '+
               ' CODINSPE	, CUITFACTURA,'+
               ' ANIO ,IMPORTEVERIFICACION , CONTACTOEMAIL, ESTADOID,pagoidverificacion '+
              ' FROM tdatosturno where  FACTURADO=''N'' and modo=''P'' and ESTADOACREDITACIONVERIFICACION	=''A'' '+
              ' and TIPOTURNO in (''O'',''P'',''F'')  AND TIPOINSPE=''P'' and CODCLIEN <> 0  AND  codvehic <> 0 AND TURNOID='+INTTOSTR(IDTURNO));         //





    aq.ExecSQL;
    aq.open;
    while not aq.eof do
    begin

       TURNOID:=aq.fieldbyname('TURNOID').asinteger;
       pagoidverificacion:=aq.fieldbyname('pagoidverificacion').asinteger;
    IF (exiete_en_tfactura(TURNOID,pagoidverificacion)=FALSE) and (exiete_idpago_en_tfactura(pagoidverificacion)=false) THEN
    BEGIN


     patente_para_factura:=trim(aq.fieldbyname('dvdomino').asstring);
     TURNOID:=aq.fieldbyname('TURNOID').asinteger;
     TIPOTURNO:=trim(aq.fieldbyname('TIPOTURNO').asstring);
     FECHATURNO:=trim(aq.fieldbyname('FECHATURNO').asstring);
     HORATURNO:=trim(aq.fieldbyname('HORATURNO').asstring);
     FECHAREGISTRO:=trim(aq.fieldbyname('FECHAREGISTRO').asstring);
     DFGENERO:=trim(aq.fieldbyname('DFGENERO').asstring);
     DFTIPODOCUMENTO:=trim(aq.fieldbyname('DFTIPODOCUMENTO').asstring);
     DFNRODOCUMENTO:=trim(aq.fieldbyname('DFNRODOCUMENTO').asstring);
     numeroCuit:=trim(aq.fieldbyname('cuitfactura').asstring);
     DFNOMBRE:=trim(aq.fieldbyname('DFNOMBRE').asstring);
     DFAPELLIDO:=trim(aq.fieldbyname('DFAPELLIDO').asstring);
     DFCALLE:=trim(aq.fieldbyname('DFCALLE').asstring);
     DFNUMEROCALLE:=trim(aq.fieldbyname('DFNUMEROCALLE').asstring);
     DFPISO:=trim(aq.fieldbyname('DFPISO').asstring);
     DFDEPARTAMENTO:=trim(aq.fieldbyname('DFDEPARTAMENTO').asstring);
     DFLOCALIDAD:=trim(aq.fieldbyname('DFLOCALIDAD').asstring);
     DFPROVINCIAID:=trim(aq.fieldbyname('DFPROVINCIAID').asstring);
     DFPROVINCIA:=trim(aq.fieldbyname('DFPROVINCIA').asstring);
     DFCODIGOPOSTAL	:=trim(aq.fieldbyname('DFCODIGOPOSTAL').asstring);
     DFIVA:=trim(aq.fieldbyname('DFIVA').asstring);
     DFIIBB:=trim(aq.fieldbyname('DFIIBB').asstring);
     PAGOSID:=trim(aq.fieldbyname('PAGOSID').asstring);
     PAGOSGETWAY:=trim(aq.fieldbyname('PAGOSGETWAY').asstring);
     PAGOSENTIDADID:=trim(aq.fieldbyname('PAGOSENTIDADID').asstring);
     PAGOSENTIDAD:=trim(aq.fieldbyname('PAGOSENTIDAD').asstring);
     PAGOSFECHA:=trim(aq.fieldbyname('PAGOSFECHA').asstring);
     PAGOSIMPORTE:=trim(aq.fieldbyname('PAGOSIMPORTE').asstring);
     PAGOSESTADOLIQUIDACION:=trim(aq.fieldbyname('PAGOSESTADOLIQUIDACION').asstring);
     CODVEHIC:=aq.fieldbyname('CODVEHIC').asinteger;
     CODCLIEN:=aq.fieldbyname('CODCLIEN').asinteger;
     AUSENTE:=trim(aq.fieldbyname('AUSENTE').asstring);
     FACTURADO:=trim(aq.fieldbyname('FACTURADO').asstring);
     REVISO:=trim(aq.fieldbyname('REVISO').asstring);
     DVNUMERO:=trim(aq.fieldbyname('DVNUMERO').asstring);
     CODINSPE:=aq.fieldbyname('CODINSPE').asinteger;
     ANIO:=aq.fieldbyname('ANIO').asinteger;
     IMPORTEVERIFICACION:=trim(aq.fieldbyname('IMPORTEVERIFICACION').asstring);
     CONTACTOEMAIL:=trim(aq.fieldbyname('CONTACTOEMAIL').asstring);


     if trim(TIPO_COMPROBANTE)='FAC' then
      begin
             if (trim(DFIVA)='R') then
                begin

                letra:='A';
               tipo_cbte:=1;
               TIPOCOMPROBANTEAFIP:='FAA';

               STIPOCOMPROBANTE:='01';
               end else begin
                   letra:='B';
                    tipo_cbte:=6;
                   TIPOCOMPROBANTEAFIP:='FAB';
                  STIPOCOMPROBANTE:='06';

               end;






      enD;

      if trim(TIPO_COMPROBANTE)='N/D' then
      begin




      enD;

           if trim(TIPO_COMPROBANTE)='N/C' then
      begin

      enD;



           if  (trim(DFTIPODOCUMENTO)='2')  then     //le
           begin
             tipo_doc:=89;
            nro_doc:=TRIM(DFNRODOCUMENTO);
           end;

           if  (trim(DFTIPODOCUMENTO)='3')  then // lc
           begin
               tipo_doc:=90;
            nro_doc:=TRIM(DFNRODOCUMENTO);
           end;

           if  (trim(DFTIPODOCUMENTO)='4')  then // dni ex
           begin
               tipo_doc:=91;
            nro_doc:=TRIM(DFNRODOCUMENTO);
           end;

            if  (trim(DFTIPODOCUMENTO)='5')  then // ced ex
           begin
               tipo_doc:=91;
            nro_doc:=TRIM(DFNRODOCUMENTO);
           end;

             if  (trim(DFTIPODOCUMENTO)='6')  then // pasaporte
           begin
               tipo_doc:=94;
            nro_doc:=TRIM(DFNRODOCUMENTO);
           end;


             if (trim(DFTIPODOCUMENTO)='7')    //otros
                 or (trim(DFTIPODOCUMENTO)='8')
                 or (trim(DFTIPODOCUMENTO)='10')
                 or (trim(DFTIPODOCUMENTO)='11')
                  or (trim(DFTIPODOCUMENTO)='12')
                 or (trim(DFTIPODOCUMENTO)='13') then
              begin
                    tipo_doc:=99;
            nro_doc:=TRIM(DFNRODOCUMENTO);

              end;




      if trim(DFTIPODOCUMENTO)='1' then   //dni
       begin

          tipo_doc:=96;
          nro_doc:=TRIM(DFNRODOCUMENTO);
       end;


      if trim(DFTIPODOCUMENTO)='9' then   //cuit
       begin
         tipo_doc:=80;
         POSI:=POS('-',TRIM(numeroCuit));
          IF POSI > 0 THEN
           BEGIN
            nro_doc:='';
            nro_doc1:=TRIM(numeroCuit);
              FOR I:=1 TO LENGTH(TRIM(nro_doc1)) DO
               BEGIN
                   IF TRIM(nro_doc1[I])<>'-' THEN
                      nro_doc:=nro_doc + TRIM(nro_doc1[I]);
                end;

           END else
             nro_doc:=TRIM(numeroCuit);

       end;











punto_vta:=FA.PUNTOVENTAFAE;
cbt_desde:='0';
cbt_hasta:='0';
para_Actualizar_numero:='1';
para_Actualizar_compro:='1';

//IMPORTEVERIFICACION:='12.10';
imp_total:=trim(IMPORTEVERIFICACION);//'12.10';


 IMPORTEVERIFICACION:= StringReplace(TRIM(IMPORTEVERIFICACION), '.', ',',
                          [rfReplaceAll, rfIgnoreCase]);


IMPORTE_SIN_IVA:=STRTOFLOAT(IMPORTEVERIFICACION)/1.21;
IMPORTE_IVA:=STRTOFLOAT(IMPORTEVERIFICACION) - IMPORTE_SIN_IVA;
imp_tot_conc:='0.00';
//imp_neto:='504.14';//'10.00';
// IMP_NETO:=FLOATTOSTR(IMPORTE_SIN_IVA);
  IMP_NETO:=FLOATTOSTRF(IMPORTE_SIN_IVA,FFFIXED,8,2);
//imp_iva:='105.86';
//IMP_IVA:=FLOATTOSTR(IMPORTE_IVA);
IMP_IVA:=FLOATTOSTRF(IMPORTE_IVA,FFFIXED,8,2);
imp_trib:='0.00';
imp_op_ex:='0.00';


 IMP_NETO:= StringReplace(TRIM(IMP_NETO), ',', '.',
                          [rfReplaceAll, rfIgnoreCase]);


 IMP_IVA:= StringReplace(TRIM(IMP_IVA), ',', '.',
                          [rfReplaceAll, rfIgnoreCase]);


  F1:=COPY(trim(fecha),7,4);
  F2:=COPY(trim(fecha),4,2);
  F3:=COPY(trim(fecha),1,2);
  FECHA:=F1+F2+F3;
  DateTimeToString(Fecha, 'yyyymmdd', date);

fecha_cbte:=trim(fecha);
fecha_venc_pago:=trim(fecha);
fecha_serv_desde:=trim(fecha);
fecha_serv_hasta:=trim(fecha);
moneda_id := 'PES';
moneda_ctz := '1.000';
//IMPORTE_PARA21_s:='504.14';
IMPORTE_PARA21_s:=IMP_NETO;

//IVA21:='105.86';
IVA21:=IMP_IVA;

if fa.procesar_comprobante(id_SERVICIO, tipo_doc, nro_doc, tipo_cbte, punto_vta,
    STRTOINT(cbt_desde), STRTOINT(cbt_hasta), imp_total, imp_tot_conc, imp_neto,
     imp_iva, imp_trib, imp_op_ex, fecha_cbte, fecha_venc_pago,
    fecha_serv_desde, fecha_serv_hasta,
    moneda_id, moneda_ctz,IMPORTE_PARA21_s,IVA21,fa.Token,fa.Sign,fa.CUIT_EMPRESA,fa.MODO_FAE,LETRA, MyBD,TURNOID) =true then
begin

NRO_COMPROBANTE:='000'+INTTOSTR(punto_vta)+'-'+ARMAR_NUMERO_FACTURA(INTTOSTR(FA.ULTIMO));

APRO:='SI' ;

 {generar pdf}
        { if trim(letra)='A' then
              archivo:=generar_pdf(NRO_COMPROBANTE,FA.cae,FA.fecha_vence,IMP_NETO,IVA21,imp_total,STIPOCOMPROBANTE,INTTOSTR(punto_vta),TURNOID,letra,patente_para_factura)
              else
             archivo:=generar_pdf_B(NRO_COMPROBANTE,FA.cae,FA.fecha_vence,IMP_NETO,IVA21,imp_total,STIPOCOMPROBANTE,INTTOSTR(punto_vta),TURNOID,letra,patente_para_factura);
          }



MyBD.StartTransaction(TD);
       TRY

      aqQ:=tsqlquery.create(nil);
      aqQ.SQLConnection := MyBD;
      aqQ.CLOSE;
      aqQ.SQL.CLEAR;
      aqQ.sql.add('UPDATE TDATOSTURNO SET FACTURADO=''S'', CAE='+#39+TRIM(FA.cae)+#39+', FECHAVENCE='+#39+TRIM(FA.fecha_vence)+#39+
      ', RESPUESTAAFIP='+#39+TRIM(FA.OBSERVACIONES_CAE)+#39+', APROBADA='+#39+APRO+#39+
      ', NRO_COMPROBANTE='+#39+TRIM(NRO_COMPROBANTE)+#39+
      ', TIPOCOMPROBANTEAFIP='+#39+TRIM(TIPOCOMPROBANTEAFIP)+#39+',  ARCHIVOENVIADO='+#39+TRIM(archivo)+#39+'   WHERE TURNOID='+INTTOSTR(TURNOID));
      AQQ.ExecSQL;




         {genera factura sag}
         // Genera_Fact_SAG(inttostr(TURNOID),'S');
         {--}

      //   Genera_Fact_SAG(inttostr(turnoid),'S');
          MYBD.Commit(TD);
         // sleep(100);
         {fin genera pdf}

         {ENVIAR MAIL}

         aqQm:=tsqlquery.create(nil);
         aqQm.SQLConnection := MyBD;
         aqQm.CLOSE;
         aqQm.SQL.CLEAR;
         aqQm.sql.add('select facturarazonsocial,cuitfactura,dfiva,dfnombre,dfapellido,dfnrodocumento,'+
               ' dftipodocumento,dfcalle, dfnumerocalle,dfpiso,DFDEPARTAMENTO,DFLOCALIDAD,DFPROVINCIA from tdatosturno WHERE TURNOID='+INTTOSTR(TURNOID));
         aqQm.ExecSQL;
         aqQm.open;




     IF TRIM(aqQm.FIELDBYNAME('facturarazonsocial').AsString)<>'' THEN
       nombre_para_mail:=TRIM(aqQm.FIELDBYNAME('facturarazonsocial').AsString)
       ELSE
         nombre_para_mail:=TRIM(aqQm.FIELDBYNAME('dfapellido').AsString)+' '+TRIM(aqQm.FIELDBYNAME('dfnombre').AsString);



        aqQm.close;
        aqQm.free;

        se_envio:='S'
       {  if EnviarMensaje(TRIM(CONTACTOEMAIL),NRO_COMPROBANTE,archivo,nombre_para_mail,patente_para_factura)=true then
            se_envio:='S'
            ELSE
            SE_ENVIO:='N'; }

         // sleep(500);

         {FIN ENVIAR MAIL}

        EXCEPT
            MyBD.Rollback(TD);
        END ;

        AQQ.close;
     AQQ.free;


        MyBD.StartTransaction(TD);
       TRY

      aqQ:=tsqlquery.create(nil);
      aqQ.SQLConnection := MyBD;
      aqQ.CLOSE;
      aqQ.SQL.CLEAR;
      aqQ.sql.add('UPDATE TDATOSTURNO SET   ENVIOMAIL='+#39+SE_ENVIO+#39+',  ERROR_MAIL='+#39+TRIM(ERROR_MAIL)+#39+'  WHERE TURNOID='+INTTOSTR(TURNOID));
      AQQ.ExecSQL;

         MYBD.Commit(TD);






        EXCEPT
            MyBD.Rollback(TD);
        END ;


     AQQ.close;
     AQQ.free;


end ELSE BEGIN
 ERROR:= StringReplace(TRIM(FA.OBSERVACIONES_CAE), '''', ' ',
                          [rfReplaceAll, rfIgnoreCase]);
APRO:='NO' ;
MyBD.StartTransaction(TD);
       TRY
      aqQ:=tsqlquery.create(nil);
      aqQ.SQLConnection := MyBD;
       aqQ.CLOSE;
      aqQ.SQL.CLEAR;
      aqQ.sql.add('UPDATE TDATOSTURNO SET FACTURADO=''N'', CAE=NULL, FECHAVENCE=NULL, RESPUESTAAFIP='+#39+TRIM(ERROR)+#39+
      ', APROBADA='+#39+APRO+#39+', NRO_COMPROBANTE=NULL, TIPOCOMPROBANTEAFIP=NULL   WHERE TURNOID='+INTTOSTR(TURNOID));
      AQQ.ExecSQL;

          MYBD.Commit(TD);
        EXCEPT
            MyBD.Rollback(TD);
        END ;

      AQQ.close;
     AQQ.free;
END;








END;// SI EXISTE EN TFACTURAS

  aq.next;
    end;

    AQ.Close;
    AQ.FREE;



EXCEPT


END;



end;


function TForm1.Factura_Electronica_pagos_suvtv(planta:longint):boolean;


begin
FA:=tfacturae.CREATE;
FA.LEER_PARAMETROS;
memo1.Lines.Add('CONECTANDO CON AFIP...');
application.ProcessMessages;

if fa.Autenticar(trim(fa.MODO_FAE),trim(fa.carpeta),trim(fa.CUIT_EMPRESA))=false then
 begin
 TIENE_CONEXION_ELECTRONICA:=FALSE;
    memo1.Lines.Add('FACTURA ELECTRONICA: ERROR DE AUTENTICACION.');
    TX.TRAZAS('FACTURA ELECTRONICA: ERROR DE AUTENTICACION.');

    application.ProcessMessages;

 end ELSE
 BEGIN
 fA.Control_servidores(FA.Token,FA.Sign,FA.MODO_FAE,FA.CUIT_EMPRESA);

    IF TRIM(FA.estado_servidor)='OK' THEN
     BEGIN
       MEMO1.Lines.Add('ESTADO SERVIDOR AFIP: OK');
     END ELSE
     BEGIN
     MEMO1.Lines.Add('ESTADO SERVIDOR AFIP: NO DISPONIBLE');
     TX.TRAZAS('ESTADO SERVIDOR AFIP: NO DISPONIBLE.');

     END;

    application.ProcessMessages;
    sleep(200);

   IF TRIM(FA.Estado_autentica)='OK' THEN
    BEGIN
    MEMO1.Lines.Add('ESTADO AUTENTICACION AFIP: OK');
    END ELSE
    BEGIN
      MEMO1.Lines.Add('ESTADO AUTENTICACION AFIP: NO DISPONIBLE');
      TX.TRAZAS('ESTADO AUTENTICACION AFIP: NO DISPONIBLE.');

    END;
     application.ProcessMessages;


   IF TRIM(FA.estado_bd)='OK' THEN
    BEGIN
     MEMO1.Lines.Add('ESTADO BASE DE DATOS AFIP: OK');
    END ELSE
   BEGIN
     MEMO1.Lines.Add('ESTADO BASE DE DATOS AFIP: NO DISPONIBLE');
     TX.TRAZAS('ESTADO BASE DE DATOS AFIP: NO DISPONIBLE.');

   END;

    application.ProcessMessages;



    IF   (TRIM(FA.estado_bd)='OK')  AND (TRIM(FA.Estado_autentica)='OK')  AND (TRIM(FA.estado_servidor)='OK') THEN
     BEGIN
        TIENE_CONEXION_ELECTRONICA:=TRUE;
        MEMO1.Lines.Add('PROCESO DE FACTURA ELECTRONICA: OK');
        application.ProcessMessages;

      END      ELSE
        BEGIN

          TIENE_CONEXION_ELECTRONICA:=FALSE;
          MEMO1.Lines.Add('PROCESO DE FACTURA ELECTRONICA: NO DISPONIBLE');
          TX.TRAZAS('PROCESO DE FACTURA ELECTRONICA: NO DISPONIBLe.');
          application.ProcessMessages;

        END;


END;




  IF (TRIM(FA.SE_FACTURA)='S') THEN
  BEGIN
       IF TIENE_CONEXION_ELECTRONICA=TRUE THEN
         BEGIN

         MEMO1.Lines.Add('BUSCANDO PAGOS A FACTURAR...');
        application.ProcessMessages;


          GENERA_COMPROBANTES_ELECTRONICOS_AFIP(PLANTA);


         END;

  END ELSE
  begin

     MEMO1.Lines.Add('NO CONFIGURADO PARA FACTURA ELECTRONICA !!!');
     TX.TRAZAS('NO CONFIGURADO PARA FACTURA ELECTRONICA !!!');
     application.ProcessMessages;

   end;

end;

function TForm1.GENERA_COMPROBANTES_ELECTRONICOS_AFIP(PLANTA:LONGINT):BOOLEAN;
VAR AQCOMPROBANTES,aqtfacturas,aqgatewaygabilitado:tsqlquery;
iddetallespago,idpago:LONGINT;   gateway_habilitado:String;
BEGIN
 if FORM1.CONEXION_OK=TRUE then
begin
TRY
gateway_habilitado:='(';
aqgatewaygabilitado:=tsqlquery.create(nil);
aqgatewaygabilitado.SQLConnection := MyBD;
aqgatewaygabilitado.Close;
aqgatewaygabilitado.SQL.Clear;
aqgatewaygabilitado.SQL.Add('select pagogatewayid from TCONFIGWS where habilita_facelec=''S'' ');
aqgatewaygabilitado.ExecSQL;
aqgatewaygabilitado.Open ;
while not aqgatewaygabilitado.Eof do
begin
   gateway_habilitado:=gateway_habilitado +trim(aqgatewaygabilitado.Fields[0].asstring)+',';

  aqgatewaygabilitado.Next;
end;
  gateway_habilitado:=copy(trim(gateway_habilitado),0,length(gateway_habilitado)-1);

  gateway_habilitado:=gateway_habilitado+')';

aqgatewaygabilitado.Close;
aqgatewaygabilitado.Free;

AQCOMPROBANTES:=tsqlquery.create(nil);
AQCOMPROBANTES.SQLConnection := MyBD;
AQCOMPROBANTES.sql.add(' Select iddetallespago, pagoid, importe, plantaid,TIPOCOMPROBANTEAFIP,EMAIL,estadoacreditacion '+
                       ' from TDETALLESPAGO '+
                       '  where estadoacreditacion in (''A'',''D'') AND Facturado = ''N'' '+
                       ' and pagogatewayid in '+trim(gateway_habilitado)+
                       ' and plantaid='+inttostr(planta)+' order by iddetallespago asc'); //+' AND PAGOID NOT IN (SELECT IDPAGO  FROM TFACTURAS)');
AQCOMPROBANTES.ExecSQL;
AQCOMPROBANTES.open;
while not AQCOMPROBANTES.eof do
  begin
    iddetallespago:=AQCOMPROBANTES.FIELDBYNAME('iddetallespago').ASINTEGER;
    idpago:=AQCOMPROBANTES.FIELDBYNAME('pagoid').ASINTEGER;

     
  FA.LEER_PARAMETROS;
   if TRIM(FA.SE_FACTURA)='S' THEN
     BEGIN

     LABEL4.Caption:='SERVICIO DE FACTURA ELECTRONICA ONLINE';
     LABEL4.Font.Color:=CLGREEN;
     END
     ELSE
     BEGIN
     LABEL4.Caption:='SERVICIO DE FACTURA ELECTRONICA OFFLINE';

     LABEL4.Font.Color:=CLRED;
     END;


     {FACTURAS ELECTRONICAS}
    if trim(AQCOMPROBANTES.FIELDBYNAME('estadoacreditacion').ASstring)='A' then
       begin
        if veririca_si_es_una_reve(iddetallespago)=false then
        begin

          aqtfacturas:=tsqlquery.create(nil);
          aqtfacturas.SQLConnection := MyBD;
          aqtfacturas.SQL.Add('SELECT IDPAGO  FROM TFACTURAS where IDPAGO='+INTTOSTR(idpago));
          aqtfacturas.ExecSQL;
          aqtfacturas.Open;
          IF  (aqtfacturas.IsEmpty=true) AND (FA.SE_FACTURA='S') THEN {NO EXISTE EN TFACTURAS}
              GENERAR_FACTURAS_ELECTRONICAS_PAGOS_SUVTV(planta,iddetallespago);


          aqtfacturas.Close;
          aqtfacturas.Free;
         END;
       end;

     {NOTAS DE CREDITOS ELECTRONICAS}
   if trim(AQCOMPROBANTES.FIELDBYNAME('estadoacreditacion').ASstring)='D' then
      begin
          aqtfacturas:=tsqlquery.create(nil);
          aqtfacturas.SQLConnection := MyBD;
          aqtfacturas.SQL.Add('SELECT IDPAGO  FROM TFACTURAS where IDPAGO='+INTTOSTR(idpago)+' AND CODCOFAC IS NULL');
          aqtfacturas.ExecSQL;
          aqtfacturas.Open;
          IF ( not aqtfacturas.IsEmpty) AND (FA.SE_FACTURA='S') THEN
             GENERAR_NOTACREDRITOS_ELECTRONICAS_PAGOS_SUVTV(planta,iddetallespago);

          aqtfacturas.Close;
          aqtfacturas.Free;

      end;


    AQCOMPROBANTES.Next;
  END;
 AQCOMPROBANTES.Close;
 AQCOMPROBANTES.Free;




   EXCEPT
   on E : Exception do
   BEGIN

    TX.TRAZAS('ERROR EN GENERA_COMPROBANTES_ELECTRONICOS_AFIP '+E.ClassName+'. ERROR: '+E.Message);
   END;

END

end else
 TX.TRAZAS('ERROR DE CONEXION CON LA BASE DE DATOS');

 
END;


function TForm1.Factura_Electronica:boolean;


begin
FA:=tfacturae.CREATE;
FA.LEER_PARAMETROS;

if fa.Autenticar(trim(fa.MODO_FAE),trim(fa.carpeta),trim(fa.CUIT_EMPRESA))=false then
 begin
 TIENE_CONEXION_ELECTRONICA:=FALSE;
    memo1.Lines.Add('FACTURA ELECTRONICA: ERROR DE AUTENTICACION.');
    application.ProcessMessages;

 end ELSE
 BEGIN
 fA.Control_servidores(FA.Token,FA.Sign,FA.MODO_FAE,FA.CUIT_EMPRESA);

    IF TRIM(FA.estado_servidor)='OK' THEN
     BEGIN
       MEMO1.Lines.Add('ESTADO SERVIDOR AFIP: OK');
     END ELSE
     BEGIN
     MEMO1.Lines.Add('ESTADO SERVIDOR AFIP: NO DISPONIBLE');

     END;

    application.ProcessMessages;


   IF TRIM(FA.Estado_autentica)='OK' THEN
    BEGIN
    MEMO1.Lines.Add('ESTADO AUTENTICACION AFIP: OK');
    END ELSE
    BEGIN
      MEMO1.Lines.Add('ESTADO AUTENTICACION AFIP: NO DISPONIBLE');
    END;
     application.ProcessMessages;


   IF TRIM(FA.estado_bd)='OK' THEN
    BEGIN
     MEMO1.Lines.Add('ESTADO BASE DE DATOS AFIP: OK');
    END ELSE
   BEGIN
     MEMO1.Lines.Add('ESTADO BASE DE DATOS AFIP: NO DISPONIBLE');
   END;

    application.ProcessMessages;



    IF   (TRIM(FA.estado_bd)='OK')  AND (TRIM(FA.Estado_autentica)='OK')  AND (TRIM(FA.estado_servidor)='OK') THEN
     BEGIN                   
        TIENE_CONEXION_ELECTRONICA:=TRUE;
        MEMO1.Lines.Add('PROCESO DE FACTURA ELECTRONICA: OK');
        application.ProcessMessages;

      END      ELSE
        BEGIN

          TIENE_CONEXION_ELECTRONICA:=FALSE;
          MEMO1.Lines.Add('PROCESO DE FACTURA ELECTRONICA: NO DISPONIBLE');
          application.ProcessMessages;

        END;


END;

  IF (TRIM(FA.SE_FACTURA)='S') THEN
  BEGIN
       IF TIENE_CONEXION_ELECTRONICA=TRUE THEN
         BEGIN
         MEMO1.Lines.Add('GENERADO FACTURAS ELECTRONICAS !!!');
        application.ProcessMessages;

            GENERAR_FACTURAS_ELECTRONICAS;
         END;

  END ELSE
  begin
     MEMO1.Lines.Add('NO CONFIGURADO PARA FACTURA ELECTRONICA !!!');
     application.ProcessMessages;

   end;

end;


function TForm1.Factura_Electronica_POR_TURNO(IDTURNO:LONGINT):boolean;


begin
FA:=tfacturae.CREATE;
FA.LEER_PARAMETROS;

if fa.Autenticar(trim(fa.MODO_FAE),trim(fa.carpeta),trim(fa.CUIT_EMPRESA))=false then
 begin
 TIENE_CONEXION_ELECTRONICA:=FALSE;
    memo1.Lines.Add('FACTURA ELECTRONICA: ERROR DE AUTENTICACION.');
    application.ProcessMessages;

 end ELSE
 BEGIN
 fA.Control_servidores(FA.Token,FA.Sign,FA.MODO_FAE,FA.CUIT_EMPRESA);

    IF TRIM(FA.estado_servidor)='OK' THEN
     BEGIN
       MEMO1.Lines.Add('ESTADO SERVIDOR AFIP: OK');
     END ELSE
     BEGIN
     MEMO1.Lines.Add('ESTADO SERVIDOR AFIP: NO DISPONIBLE');

     END;

    application.ProcessMessages;


   IF TRIM(FA.Estado_autentica)='OK' THEN
    BEGIN
    MEMO1.Lines.Add('ESTADO AUTENTICACION AFIP: OK');
    END ELSE
    BEGIN
      MEMO1.Lines.Add('ESTADO AUTENTICACION AFIP: NO DISPONIBLE');
    END;
     application.ProcessMessages;


   IF TRIM(FA.estado_bd)='OK' THEN
    BEGIN
     MEMO1.Lines.Add('ESTADO BASE DE DATOS AFIP: OK');
    END ELSE
   BEGIN
     MEMO1.Lines.Add('ESTADO BASE DE DATOS AFIP: NO DISPONIBLE');
   END;

    application.ProcessMessages;



    IF   (TRIM(FA.estado_bd)='OK')  AND (TRIM(FA.Estado_autentica)='OK')  AND (TRIM(FA.estado_servidor)='OK') THEN
     BEGIN
        TIENE_CONEXION_ELECTRONICA:=TRUE;
        MEMO1.Lines.Add('PROCESO DE FACTURA ELECTRONICA: OK');
        application.ProcessMessages;

      END      ELSE
        BEGIN

          TIENE_CONEXION_ELECTRONICA:=FALSE;
          MEMO1.Lines.Add('PROCESO DE FACTURA ELECTRONICA: NO DISPONIBLE');
          application.ProcessMessages;

        END;


END;

  IF (TRIM(FA.SE_FACTURA)='S') THEN
  BEGIN
       IF TIENE_CONEXION_ELECTRONICA=TRUE THEN
         BEGIN
         MEMO1.Lines.Add('GENERADO FACTURAS ELECTRONICAS !!!');
        application.ProcessMessages;

             GENERAR_FACTURAS_ELECTRONICAS_IDTURNOS(IDTURNO);
         END;

  END ELSE
  begin
     MEMO1.Lines.Add('NO CONFIGURADO PARA FACTURA ELECTRONICA !!!');
     application.ProcessMessages;

   end;

end;

FUNCTION TForm1.INICIAR_NOVEDAD:BOOLEAN;
//var tx:txml_caba;
begin
MEMO1.Clear;
MEMO1.Lines.Add('INICIO DESCARGA DE NOVEDADES '+DATETOSTR(DATE)+' '+TIMETOSTR(TIME));

//tx:=txml_caba.Create;
//tf.TestOfBD('', '', '' ,false);

 TX.CONFIGURAR;
 if TRIM(tx.VER_HABILITADO_FACTURA)='S' THEN
     BEGIN

     LABEL4.Caption:='SERVICIO DE FACTURA ELECTRONICA ONLINE';
     LABEL4.Font.Color:=CLGREEN;
     END
     ELSE
     BEGIN

     LABEL4.Caption:='SERVICIO DE FACTURA ELECTRONICA OFFLINE';
     LABEL4.Font.Color:=CLRED;
     END;


TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN

           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           application.ProcessMessages;

           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('DESCARGANDO TURNOS...');
                application.ProcessMessages;
               TX.CONSULTA('N','-','-',0);
               MEMO1.Clear;


                MEMO1.Lines.Add('ARREGLANDO CODCLIENTE=0...');
                application.ProcessMessagES;
                baja_pagos_faltantes;
                self.ARREGLA_TURNOS_CLIENTES_CEROS;
                self.ARREGLA_TURNOS_CLIENTES_CEROS_fecharegistro;
                arregla_cliente_cero_con_pagos;
                arregla_cliente_cero_con_pagos_fechaturno;
                Arregla_codcliente_cero;
                Arregla_codcliente_cero_fechaturno;
                baja_pagos_faltantes;
               arregla_cliente_cero_con_pagos;
               self.ARREGLA_TURNOS_CLIENTES_CEROS;
                self.ARREGLA_TURNOS_CLIENTES_CEROS_fecharegistro;

               MEMO1.Lines.Add('CERRANDO SECCION...');
               application.ProcessMessagES;
               TX.Cerrar_seccion;

               MEMO1.Clear;
               MEMO1.Lines.Add('INICIANDO DESCARGAS DE PAGOS INDIVIDUALES...');
               application.ProcessMessages;



              PROCEDIMIENTOS_XML_PAGOS_INDIVIDUAL;

              MEMO1.Clear;
              MEMO1.Lines.Add('INICIANDO DESCARGAS DE PAGOS POR FLOTAS...');
              application.ProcessMessagES;


              PROCEDIMIENTOS_XML_PAGOS_FLOTA ;



               arregla_cliente_cero_con_pagos;
               arregla_cliente_cero_con_pagos_fechaturno;
               Arregla_codcliente_cero;
               Arregla_codcliente_cero_fechaturno;
                baja_pagos_faltantes;
               arregla_cliente_cero_con_pagos;


               SERVICIO_FACTURA_ELECTRONICA;
               MEMO1.Lines.Add('GENERANDO PDF...');
               GENERA_TODOS_PDF_FALTANTE;
               MEMO1.Lines.Add('ESPERANDO CONEXION...');
              END;



         END else
         begin
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');

          end;




  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);

  END;







 END;


 
FUNCTION TForm1.INICIAR_NOVEDAD_20minutos:BOOLEAN;
//var tx:txml_caba;
begin
MEMO1.Clear;
MEMO1.Lines.Add('INICIO DESCARGA DE NOVEDADES '+DATETOSTR(DATE)+' '+TIMETOSTR(TIME));

//tx:=txml_caba.Create;
//tf.TestOfBD('', '', '' ,false);

 TX.CONFIGURAR;
 if TRIM(tx.VER_HABILITADO_FACTURA)='S' THEN
     BEGIN

     LABEL4.Caption:='SERVICIO DE FACTURA ELECTRONICA ONLINE';
     LABEL4.Font.Color:=CLGREEN;
     END
     ELSE
     BEGIN

     LABEL4.Caption:='SERVICIO DE FACTURA ELECTRONICA OFFLINE';
     LABEL4.Font.Color:=CLRED;
     END;


TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN

           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           application.ProcessMessages;

           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('DESCARGANDO TURNOS...');
                application.ProcessMessages;
               TX.CONSULTA('20','-','-',0);
               MEMO1.Clear;



               MEMO1.Lines.Add('CERRANDO SECCION...');
               application.ProcessMessagES;
               TX.Cerrar_seccion;


               MEMO1.Clear;
              {
               MEMO1.Lines.Add('INICIANDO DESCARGAS DE PAGOS INDIVIDUALES...');
               application.ProcessMessages;



              PROCEDIMIENTOS_XML_PAGOS_INDIVIDUAL;

              MEMO1.Clear;
              MEMO1.Lines.Add('INICIANDO DESCARGAS DE PAGOS POR FLOTAS...');
              application.ProcessMessagES;


              PROCEDIMIENTOS_XML_PAGOS_FLOTA ;



               arregla_cliente_cero_con_pagos;
               arregla_cliente_cero_con_pagos_fechaturno;
               Arregla_codcliente_cero;
               Arregla_codcliente_cero_fechaturno;
                baja_pagos_faltantes;
               arregla_cliente_cero_con_pagos;


               SERVICIO_FACTURA_ELECTRONICA;
               MEMO1.Lines.Add('GENERANDO PDF...');
               GENERA_TODOS_PDF_FALTANTE;
               MEMO1.Lines.Add('ESPERANDO CONEXION...');
               }
              END;



         END else
         begin
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');

          end;




  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);

  END;







 END;




FUNCTION TForm1.INICIAR_NOVEDAD_1833:BOOLEAN;
//var tx:txml_caba;
var ic:longint;
hd,hh:string;
begin
MEMO1.Clear;
MEMO1.Lines.Add('INICIO DESCARGA DE NOVEDADES '+DATETOSTR(DATE)+' '+TIMETOSTR(TIME));

//tx:=txml_caba.Create;
//tf.TestOfBD('', '', '' ,false);

 TX.CONFIGURAR;
 if TRIM(tx.VER_HABILITADO_FACTURA)='S' THEN
     BEGIN

     LABEL4.Caption:='SERVICIO DE FACTURA ELECTRONICA ONLINE';
     LABEL4.Font.Color:=CLGREEN;
     END
     ELSE
     BEGIN

     LABEL4.Caption:='SERVICIO DE FACTURA ELECTRONICA OFFLINE';
     LABEL4.Font.Color:=CLRED;
     END;


TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN

           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           application.ProcessMessages;

           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
              ic:=1;
                while ic <=19 do
                begin
                   if ic=1 then
                   begin
                     hd:='00:00:01';
                     hh:='01:00:00';
                   end;

                    if ic=2 then
                   begin
                     hd:='01:00:01';
                     hh:='02:00:00';
                   end;

                      if ic=3 then
                   begin
                     hd:='02:00:01';
                     hh:='03:00:00';
                   end;


                   if ic=4 then
                   begin
                     hd:='03:00:01';
                     hh:='04:00:00';
                   end;

                   if ic=5 then
                   begin
                     hd:='04:00:01';
                     hh:='05:00:00';
                   end;

                   if ic=6 then
                   begin
                     hd:='05:00:01';
                     hh:='06:00:00';
                   end;
                    if ic=7 then
                   begin
                     hd:='06:00:01';
                     hh:='07:00:00';
                   end;

                    if ic=8 then
                   begin
                     hd:='07:00:01';
                     hh:='08:00:00';
                   end;

                    if ic=9 then
                   begin
                     hd:='08:00:01';
                     hh:='09:00:00';
                   end;
                    if ic=10 then
                   begin
                     hd:='09:00:01';
                     hh:='10:00:00';
                   end;

                    if ic=11 then
                   begin
                     hd:='10:00:01';
                     hh:='11:00:00';
                   end;

                  {   if ic=12 then
                   begin
                     hd:='10:00:01';
                     hh:='11:00:00';
                   end;  }

                {     if ic=13 then
                   begin
                     hd:='10:00:01';
                     hh:='11:00:00';
                   end;  }

                     if ic=12 then
                   begin
                     hd:='11:00:01';
                     hh:='12:00:00';
                   end;

                     if ic=13 then
                   begin
                     hd:='12:00:01';
                     hh:='13:00:00';
                   end;

                     if ic=14 then
                   begin
                     hd:='13:00:01';
                     hh:='14:00:00';
                   end;

                     if ic=15 then
                   begin
                     hd:='14:00:01';
                     hh:='15:00:00';
                   end;

                     if ic=16 then
                   begin
                     hd:='15:00:01';
                     hh:='16:00:00';
                   end;

                      if ic=17 then
                   begin
                     hd:='16:00:01';
                     hh:='17:00:00';
                   end;

                     if ic=18 then
                   begin
                     hd:='17:00:01';
                     hh:='18:00:00';
                   end;

                         if ic=19 then
                   begin
                     hd:='18:00:01';
                     hh:='19:00:00';
                   end;

                  MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
                  MEMO1.Lines.Add('DESCARGANDO TURNOS...18:30 hs   '+inttostr(ic)+' - '+hd+'  '+hh);
                  application.ProcessMessages;
                 TX.CONSULTA('18',hd,hh,0);
                 MEMO1.Clear;
                 TX.Cerrar_seccion;
                 TX.CONFIGURAR;
                 TX.Abrir_Seccion;
                 IF  TX.ver_respuestaid_Abrir<>1 THEN
                       break;
                 ic:=ic+1;
                end;

                MEMO1.Lines.Add('ARREGLANDO CODCLIENTE=0...');
                application.ProcessMessagES;
                baja_pagos_faltantes;
                self.ARREGLA_TURNOS_CLIENTES_CEROS;
                self.ARREGLA_TURNOS_CLIENTES_CEROS_fecharegistro;
                arregla_cliente_cero_con_pagos;
                arregla_cliente_cero_con_pagos_fechaturno;
                Arregla_codcliente_cero;
                Arregla_codcliente_cero_fechaturno;
                baja_pagos_faltantes;
               arregla_cliente_cero_con_pagos;
               self.ARREGLA_TURNOS_CLIENTES_CEROS;
                self.ARREGLA_TURNOS_CLIENTES_CEROS_fecharegistro;

               MEMO1.Lines.Add('CERRANDO SECCION...');
               application.ProcessMessagES;
               TX.Cerrar_seccion;

               MEMO1.Clear;
               MEMO1.Lines.Add('INICIANDO DESCARGAS DE PAGOS INDIVIDUALES...');
               application.ProcessMessages;



              PROCEDIMIENTOS_XML_PAGOS_INDIVIDUAL;

              MEMO1.Clear;
              MEMO1.Lines.Add('INICIANDO DESCARGAS DE PAGOS POR FLOTAS...');
              application.ProcessMessagES;


              PROCEDIMIENTOS_XML_PAGOS_FLOTA ;



               arregla_cliente_cero_con_pagos;
               arregla_cliente_cero_con_pagos_fechaturno;
               Arregla_codcliente_cero;
               Arregla_codcliente_cero_fechaturno;
                baja_pagos_faltantes;
               arregla_cliente_cero_con_pagos;


               SERVICIO_FACTURA_ELECTRONICA;
               MEMO1.Lines.Add('GENERANDO PDF...');
               GENERA_TODOS_PDF_FALTANTE;
               MEMO1.Lines.Add('ESPERANDO CONEXION...');
              END;



         END else
         begin
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');

          end;




  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);

  END;







 END;

procedure TForm1.FormCreate(Sender: TObject);
VAR TX1:txml_caba;
begin



total_envio:=0;
TX1:=txml_caba.Create;
TX1.CargarINI;


IF TRIM(TX1.ESSERVIDOR)='S' THEN
ES_SERVIDOR:=true
ELSE
ES_SERVIDOR:=FALSE;

 if TRIM(tx1.VER_HABILITADO_FACTURA)='S' THEN
     BEGIN
     LABEL4.Caption:='SERVICIO DE FACTURA ELECTRONICA ONLINE';
     LABEL4.Font.Color:=CLGREEN;
     END
     ELSE
     BEGIN
     LABEL4.Caption:='SERVICIO DE FACTURA ELECTRONICA OFFLINE';
     LABEL4.Font.Color:=CLRED;
     END;
TX1.Free;




IF ES_SERVIDOR=TRUE THEN
BEGIN
self.Caption:='WebServices [11.0.0] v2  modo servidor';
    SELF.BitBtn1.Enabled:=TRUE;
    SELF.BitBtn2.Enabled:=TRUE;
    SELF.BitBtn3.Enabled:=TRUE;
    SELF.BitBtn4.Enabled:=TRUE;
    SELF.BitBtn7.Enabled:=TRUE;
    SELF.BitBtn6.Enabled:=TRUE;
    SELF.BitBtn9.Enabled:=TRUE;
    SELF.BitBtn10.Enabled:=TRUE;
    SELF.BitBtn11.Enabled:=TRUE;
    SELF.BitBtn8.Enabled:=TRUE;

     SELF.BitBtn1.Enabled:=TRUE;
    SELF.BitBtn2.Enabled:=TRUE;
    SELF.BitBtn3.Enabled:=TRUE;
    SELF.BitBtn4.Enabled:=TRUE;
    SELF.BitBtn7.Enabled:=TRUE;
    SELF.BitBtn6.Enabled:=TRUE;
    SELF.BitBtn9.Enabled:=TRUE;
    SELF.BitBtn10.Enabled:=TRUE;
    SELF.BitBtn11.Enabled:=TRUE;
    SELF.BitBtn8.Enabled:=TRUE;
     self.Button1.Enabled:=TRUE;
      self.Button4.Enabled:=TRUE;
     self.Button6.Enabled:=TRUE;
self.Button7.Enabled:=TRUE;
  self.Button10.Enabled:=TRUE;

  self.Button3.Enabled:=TRUE;
    SELF.BitBtn13.Enabled:=TRUE;
    SELF.BitBtn15.Enabled:=TRUE;
    SELF.BitBtn3.Enabled:=TRUE;
    SELF.BitBtn18.Enabled:=TRUE;
    SELF.BitBtn17.Enabled:=TRUE;
    SELF.BitBtn7.Enabled:=TRUE;
    SELF.BitBtn6.Enabled:=TRUE;

    SELF.BitBtn10.Enabled:=TRUE;
    SELF.BitBtn19.Enabled:=TRUE;
    SELF.Button9.Enabled:=TRUE;
    SELF.BitBtn14.Enabled:=TRUE;
    SELF.BitBtn16.Enabled:=TRUE;
    SELF.BitBtn4.Enabled:=TRUE;



   EDIT3.Enabled:=TRUE;
   EDIT2.Enabled:=TRUE;
END ELSE BEGIN
self.Caption:='WebServices [11.0.0] v2 modo descarga';
  SELF.BitBtn1.Enabled:=FALSE;
    SELF.BitBtn2.Enabled:=FALSE;
    SELF.BitBtn3.Enabled:=FALSE;
    SELF.BitBtn4.Enabled:=FALSE;
    SELF.BitBtn7.Enabled:=FALSE;
    SELF.BitBtn6.Enabled:=FALSE;
    SELF.BitBtn9.Enabled:=FALSE;
    SELF.BitBtn10.Enabled:=FALSE;
    SELF.BitBtn11.Enabled:=TRUE;
    SELF.BitBtn8.Enabled:=FALSE;
     self.Button1.Enabled:=false;
      self.Button4.Enabled:=false;
     self.Button6.Enabled:=false;
self.Button7.Enabled:=false;
  self.Button10.Enabled:=false;

  self.Button3.Enabled:=false;
    SELF.BitBtn13.Enabled:=FALSE;
    SELF.BitBtn15.Enabled:=FALSE;
    SELF.BitBtn3.Enabled:=FALSE;
    SELF.BitBtn18.Enabled:=FALSE;
    SELF.BitBtn17.Enabled:=FALSE;
    SELF.BitBtn7.Enabled:=FALSE;
    SELF.BitBtn6.Enabled:=FALSE;

    SELF.BitBtn10.Enabled:=FALSE;
    SELF.BitBtn19.Enabled:=FALSE;
    SELF.Button9.Enabled:=FALSE;
    SELF.BitBtn14.Enabled:=FALSE;
    SELF.BitBtn16.Enabled:=FALSE;
    SELF.BitBtn4.Enabled:=FALSE;


   EDIT3.Enabled:=TRUE;
   EDIT2.Enabled:=TRUE;

END;



EDIT2.Clear;
EDIT3.CLEAR;


MEMO1.Clear;

 


end;

procedure TForm1.BitBtn1Click(Sender: TObject);
VAR C:STRING;
begin
//INICIAR_NOVEDAD_1833 ;
{INICIAR_NOVEDAD;
self.ARREGLA_TURNOS_CLIENTES_CEROS;
arregla_cliente_cero_con_pagos;
arregla_cliente_cero_con_pagos_fechaturno;
Arregla_codcliente_cero;
Arregla_codcliente_cero_fechaturno;
self.baja_pagos_faltantes;
arregla_cliente_cero_con_pagos;
ARREGLA_TURNOS_CLIENTES_CEROS_fecharegistro ;
 self.ARREGLA_TURNOS_CLIENTES_CEROS;
 arregla_exentos_sin_idpago;
 PONE_FACUTURDO_EL_TURNO;
 GENERA_TODOS_PDF_FALTANTE;
 memo1.Lines.Add('LIMPIANDO DIRECTORIO...');
c:=ExtractFilePath(Application.ExeName);
BorrarArchivos(c);
memo1.Lines.Add('PROCESO DE LIMPIEZA TERMONADO');  }
TIMENOVEDAD.Enabled:=TRUE;
SELF.Timer3.Enabled:=TRUE;
end;

FUNCTION TForm1.TURNOS_SIN_FACTURAR_DEL_DIA:BOOLEAN;
VAR  aq:tsqlquery;
fecha,linea,archivo_patente,FECHA1:string;
archi:textfile;
BEGIN
FECHA1:=TRIM(COPY(DATETOSTR(DATE),1,2))+TRIM(COPY(DATETOSTR(DATE),4,2))+TRIM(COPY(DATETOSTR(DATE),7,4));
archivo_patente:=ExtractFilePath(Application.ExeName)+'sinfacturar'+FECHA1+'.txt';
assignfile(archi,archivo_patente);
rewrite(archi);
fecha:=datetostr(date);
   aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aq.sql.add('select *  from TDETALLESPAGO  '+
   ' WHERE FECHANOVEDAD=TO_DATE('+#39+trim(fecha)+#39+',''dd/mm/yyyy'') and facturado=''N'' '+
   ' and CAE IS NULL ');
   aq.ExecSQL;
   aq.open;
   while not aq.eof do
   begin
    linea:='ID: '+trim(aq.fieldbyname('IDDETALLESPAGO').AsString)+'  PAGOID: '+trim(aq.fieldbyname('PAGOID').AsString)+'  ESTADO: '+trim(aq.fieldbyname('ESTADOACREDITACIOND').AsString);
        append(archi);
        writeln(archi,linea);


       aq.Next;
   end;

   closefile(archi);
   aq.Close;
   aq.Free;

END;



FUNCTION TForm1.CONTROLES:BOOLEAN;
VAR  aq,AQ1:tsqlquery;
turnoid:LONGINT;
tipoturno,facturado, nro_comprobante:STRING; pagoidverificacion:LONGINT;
BEGIN

   aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aq.sql.add(' select turnoid,tipoturno,facturado, nro_comprobante, pagoidverificacion,tipoinspe from tdatosturno '+
              ' where  fecharegistro >=to_date(''01/12/2016'',''dd/mm/yyyy'')  and tipoinspe=''P'' and facturado  in (''R'',''O'')  '+
              ' and tipoturno in (''P'',''O'')   '+
              ' and turnoid  not in (select turnoid from tturnorelacionado)');
   aq.ExecSQL;
   aq.open;
   while not aq.eof do
   begin
        turnoid:=AQ.FIELDBYNAME('turnoid').AsInteger;
        tipoturno:=TRIM(AQ.FIELDBYNAME('tipoturno').AsSTRING);
        facturado:=TRIM(AQ.FIELDBYNAME('facturado').AsSTRING);
        nro_comprobante:=TRIM(AQ.FIELDBYNAME('nro_comprobante').AsSTRING);
        pagoidverificacion:=AQ.FIELDBYNAME('pagoidverificacion').AsInteger;


            aq1:=tsqlquery.create(nil);
            aq1.SQLConnection := MyBD;
            aq1.sql.add('select * from tturnorelacionado WHERE TURNOID='+INTTOSTR(turnoid));
            aq1.ExecSQL;
            aq1.open;
            IF AQ1.IsEmpty THEN
             BEGIN
                 aq1.SQL.Clear;
                 aq1.sql.add('select * from TFACTURAS WHERE IDPAGO='+INTTOSTR(pagoidverificacion));
                 aq1.ExecSQL;
                 aq1.open;
                   IF AQ1.IsEmpty THEN
                     BEGIN
                         MyBD.StartTransaction(TD);
                           TRY
                             aq1.SQL.Clear;
                             aq1.sql.add('UPDATE TDATOSTURNOS  SET FACTURADO=''N'' WHERE TURNOID='+INTTOSTR(turnoid));
                             aq1.ExecSQL;
                              MYBD.Commit(TD);
                           EXCEPT

                              MyBD.Rollback(TD);
                           END;

                     END;
             END;

             AQ1.CLOSE;
             AQ1.Free;



       aq.Next;
   end;


   aq.Close;
   aq.Free;

END;


FUNCTION TForm1.TURNOS_SIN_FACTURAR_todos:BOOLEAN;
VAR  aq:tsqlquery;
fecha,linea,archivo_patente,FECHA1:string;
archi:textfile;
BEGIN
FECHA1:=TRIM(COPY(DATETOSTR(DATE),1,2))+TRIM(COPY(DATETOSTR(DATE),4,2))+TRIM(COPY(DATETOSTR(DATE),7,4));
archivo_patente:=ExtractFilePath(Application.ExeName)+'sinfacturar'+FECHA1+'.txt';
assignfile(archi,archivo_patente);
rewrite(archi);
fecha:=datetostr(date);
   aq:=tsqlquery.create(nil);
   aq.SQLConnection := MyBD;
   aq.sql.add('select * from tdetallespago  '+
   ' WHERE  facturado=''N''  and CAE IS NULL ');
   aq.ExecSQL;
   aq.open;
   while not aq.eof do
   begin



    linea:='ID: '+trim(aq.fieldbyname('IDDETALLESPAGO').AsString)+'   PAGOID: '+trim(aq.fieldbyname('PAGOID').ASSTRING+'  ESTADO: '+trim(aq.fieldbyname('ESTADOACREDITACIOND').AsString));
        append(archi);
        writeln(archi,linea);


       aq.Next;
   end;

   closefile(archi);
   aq.Close;
   aq.Free;

END;

procedure TForm1.TIMENOVEDADTimer(Sender: TObject);
VAR C:STRING;
begin
MEMO1.Clear;
memo1.Lines.Add('ESPERADO CONEXION...'+DATETOSTR(DATE)+' - '+TIMETOSTR(TIME));

TIMENOVEDAD.Enabled:=FALSE;






   if (trim(timetostr(time))='06:00:00')  then
begin
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);

  memo1.Lines.Add('COPIANDO TURNOS...');
  APPLICATION.ProcessMessages;
  COPIAR_HISTORIAL_TURNOS;
  memo1.Lines.Add('BORRAR TURNOS DE AYER...');
  APPLICATION.ProcessMessages;
  BORRAR_TURNOS_SYSDATE_30;
  // memo1.Lines.Add('COPIAR_HISTORIAL_TMPDATODEFECIM...');
{ APPLICATION.ProcessMessages;
  COPIAR_HISTORIAL_TMPDATODEFECIM;

  }
  mybd.Close;
  tx.Free;
end;

if (trim(timetostr(time))='06:15:00') then
  begin
  tx:=txml_caba.Create;
  tX.TestOfBD('', '', '' ,false);

    memo1.Clear;
    memo1.Lines.Add('DESCARGA DE TURNOS DEL DIA POR FECHA '+DATETOSTR(DATE)+'-'+timetostr(time));
    INICIAR_DESCARGA_DIA;
    self.ARREGLA_TURNOS_CLIENTES_CEROS;
    baja_pagos_faltantes;
    arregla_cliente_cero_con_pagos;
    {CONTROL DE PAGOS}
    PROCEDIMIENTO_CONTROL_DE_PAGOS;
    memo1.Lines.Add('LIMPIANDO DIRECTORIO...');
    c:=ExtractFilePath(Application.ExeName);
    BorrarArchivos(c);
    memo1.Lines.Add('PROCESO DE LIMPIEZA TERMINADO');
  mybd.Close;
  tx.Free;
  end;

if (trim(timetostr(time))='01:30:00')
    or  (trim(timetostr(time))='02:30:00')
    or  (trim(timetostr(time))='03:30:00')
    or  (trim(timetostr(time))='04:30:00')
    or  (trim(timetostr(time))='05:30:00')
   // or  (trim(timetostr(time))='06:30:00')
    or  (trim(timetostr(time))='07:30:00')
    or  (trim(timetostr(time))='19:30:00')
    or  (trim(timetostr(time))='20:30:00')
    or  (trim(timetostr(time))='21:30:00')
    or  (trim(timetostr(time))='22:30:00')
    or  (trim(timetostr(time))='23:20:00')

 then
begin
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);

  INICIAR_NOVEDAD;
  self.ARREGLA_TURNOS_CLIENTES_CEROS;
  arregla_cliente_cero_con_pagos;
  arregla_cliente_cero_con_pagos_fechaturno;
  Arregla_codcliente_cero;
  Arregla_codcliente_cero_fechaturno;
  self.baja_pagos_faltantes;
  arregla_cliente_cero_con_pagos;
  ARREGLA_TURNOS_CLIENTES_CEROS_fecharegistro ;
  self.ARREGLA_TURNOS_CLIENTES_CEROS;
  arregla_exentos_sin_idpago;
  PONE_FACUTURDO_EL_TURNO;
  memo1.Lines.Add('LIMPIANDO DIRECTORIO...');
  c:=ExtractFilePath(Application.ExeName);
  BorrarArchivos(c);
  memo1.Lines.Add('PROCESO DE LIMPIEZA TERMINADO');
 mybd.Close;
 tx.Free;
end;




{INFORMAR INSPECCIONES}
 if (trim(timetostr(time))='07:50:00')
    OR (trim(timetostr(time))='08:00:00')
    OR (trim(timetostr(time))='08:10:00')
    OR (trim(timetostr(time))='08:20:00')
    OR (trim(timetostr(time))='08:30:00')
    OR (trim(timetostr(time))='08:40:00')
    OR (trim(timetostr(time))='08:50:00')
    OR (trim(timetostr(time))='09:00:00')
    OR (trim(timetostr(time))='09:10:00')
    OR (trim(timetostr(time))='09:20:00')
    OR (trim(timetostr(time))='09:30:00')
    OR (trim(timetostr(time))='09:40:00')
    OR (trim(timetostr(time))='09:50:00')
    OR (trim(timetostr(time))='10:00:00')
    OR (trim(timetostr(time))='10:10:00')
    OR (trim(timetostr(time))='10:20:00')
    OR (trim(timetostr(time))='10:30:00')
    OR (trim(timetostr(time))='10:40:00')
    OR (trim(timetostr(time))='10:50:00')
    OR (trim(timetostr(time))='11:00:00')
    OR (trim(timetostr(time))='11:10:00')
    OR (trim(timetostr(time))='11:20:00')
    OR (trim(timetostr(time))='11:30:00')
    OR (trim(timetostr(time))='11:40:00')
    OR (trim(timetostr(time))='11:50:00')
    OR (trim(timetostr(time))='12:00:00')
    OR (trim(timetostr(time))='12:10:00')
    OR (trim(timetostr(time))='12:20:00')
    OR (trim(timetostr(time))='12:30:00')
    OR (trim(timetostr(time))='12:40:00')
    OR (trim(timetostr(time))='12:50:00')
    OR (trim(timetostr(time))='13:00:00')
    OR (trim(timetostr(time))='13:10:00')
    OR (trim(timetostr(time))='13:20:00')
    OR (trim(timetostr(time))='13:30:00')
    OR (trim(timetostr(time))='13:40:00')
    OR (trim(timetostr(time))='13:50:00')
    OR (trim(timetostr(time))='14:00:00')
    OR (trim(timetostr(time))='14:10:00')
    OR (trim(timetostr(time))='14:20:00')
    OR (trim(timetostr(time))='14:30:00')
    OR (trim(timetostr(time))='14:40:00')
    OR (trim(timetostr(time))='14:50:00')
    OR (trim(timetostr(time))='15:00:00')
    OR (trim(timetostr(time))='15:10:00')
    OR (trim(timetostr(time))='15:20:00')
    OR (trim(timetostr(time))='15:30:00')
    OR (trim(timetostr(time))='15:40:00')
    OR (trim(timetostr(time))='15:50:00')
    OR (trim(timetostr(time))='16:00:00')
    OR (trim(timetostr(time))='16:10:00')
    OR (trim(timetostr(time))='16:20:00')
    OR (trim(timetostr(time))='16:30:00')
    OR (trim(timetostr(time))='16:40:00')
    OR (trim(timetostr(time))='16:50:00')
    OR (trim(timetostr(time))='17:00:00')
    OR (trim(timetostr(time))='17:10:00')
    OR (trim(timetostr(time))='17:20:00')
    OR (trim(timetostr(time))='17:30:00')
    OR (trim(timetostr(time))='17:40:00')
    OR (trim(timetostr(time))='17:50:00')
    or(trim(timetostr(time))='18:00:00')
    or(trim(timetostr(time))='18:10:00')
    or(trim(timetostr(time))='18:20:00')

  then
  begin
  tx:=txml_caba.Create;
  tX.TestOfBD('', '', '' ,false);

  INFORMAR_INSPECCION_DEL_DIA;
  INICIAR_NOVEDAD_20minutos;

  memo1.Lines.Add('LIMPIANDO DIRECTORIO...');
  c:=ExtractFilePath(Application.ExeName);
  BorrarArchivos(c);
  memo1.Lines.Add('PROCESO DE LIMPIEZA TERMINADO');

   memo1.Lines.Add('LIMPIANDO DIRECTORIO...');
c:=ExtractFilePath(Application.ExeName);
BorrarArchivos(c);
memo1.Lines.Add('PROCESO DE LIMPIEZA TERMINADO');
mybd.Close;
tx.Free;
  end;
{FIN INFORMAR INSPECCION}






if (trim(timetostr(time))='18:30:00') then
begin
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);

  INICIAR_NOVEDAD_1833;
  PROCEDIMIENTOS_XML_PAGOS_INDIVIDUAL_1830;
  PROCEDIMIENTOS_XML_PAGOS_flota_1830;
   TX.CONFIGURAR;
  SERVICIO_FACTURA_ELECTRONICA;
  FA:=tfacturae.CREATE;
FA.LEER_PARAMETROS;
SELF.GENERA_TODOS_PDF_FALTANTE;
fa.free;

      memo1.Lines.Add('LIMPIANDO DIRECTORIO...');
c:=ExtractFilePath(Application.ExeName);
BorrarArchivos(c);
memo1.Lines.Add('PROCESO DE LIMPIEZA TERMINADO');
mybd.Close;
tx.Free;
end;


if (trim(timetostr(time))='21:00:00') then
begin
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);

  memo1.Clear;
  memo1.Lines.Add('INFORMES DE AUSENTES..... '+timetostr(time));
  SELF.INFORMAR_LOS_AUSENTES_DEL_DIA;
  memo1.Lines.Add('LIMPIANDO DIRECTORIO...');
  c:=ExtractFilePath(Application.ExeName);
  BorrarArchivos(c);
  memo1.Lines.Add('PROCESO DE LIMPIEZA TERMONADO');
mybd.Close;
 tx.Free;
end;


if (trim(timetostr(time))='22:00:00')  then
begin
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);

   serivicio_de_reinformar_facturas_a_suvtv;
   memo1.Lines.Add('LIMPIANDO DIRECTORIO...');
   c:=ExtractFilePath(Application.ExeName);
   BorrarArchivos(c);
   memo1.Lines.Add('PROCESO DE LIMPIEZA TERMONADO');
 mybd.Close;
 tx.Free;
end;








if (trim(timetostr(time))='23:00:00') OR (trim(timetostr(time))='05:00:00') then
begin
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);

    memo1.Clear;
    memo1.Lines.Add('INFORMANDO TIPO 5.... '+timetostr(time));
    tx.INFORMAR_TODOS_LOS_TIPO_5;
    memo1.Lines.Add('LIMPIANDO DIRECTORIO...');
    c:=ExtractFilePath(Application.ExeName);
    BorrarArchivos(c);
    memo1.Lines.Add('PROCESO DE LIMPIEZA TERMONADO');
    mybd.Close;
    tx.Free;
end;




 TIMENOVEDAD.Enabled:=true;


end;



FUNCTION TForm1.INFORMAR_INSPECCION_DEL_DIA:BOOLEAN;

var  aqlistado,aqSININFORMAR,aqSININFORMAR1:TSQLQuery;
fechaturno:STRING;  inspe:longint;
begin
 fechaturno:=DATETOSTR(DATE);

 MEMO1.Clear;
 MEMO1.Lines.Add('INFORMANADO INSPECCIONES...');
 //APPLICATION.ProcessMessages;


aqSININFORMAR:=tsqlquery.create(nil);
aqSININFORMAR.Close;
aqSININFORMAR.SQLConnection :=MyBD;
aqSININFORMAR.sql.add('SELECT  TURNOID, codinspe, anio, DVDOMINO FROM tdatosturno   '+
                     ' WHERE fechaturno=to_date('+#39+trim(fechaturno)+#39+',''dd/mm/yyyy'') and TRIM(ausente)=''N'' and TRIM(modo)=''P''  '+
                     ' and TRIM(reviso)=''S'' and  (TRIM(informadows)=''NO'' OR informadows IS NULL)  AND  (CODINSPE IS NOT NULL OR CODINSPE=0)   ' );    //AND ESTADOID IN(1,7)


aqSININFORMAR.ExecSQL;
aqSININFORMAR.open;
while not aqSININFORMAR.eof do
begin
inspe:=AqSININFORMAR.FIELDBYNAME('codinspe').ASINTEGER;

   aqSININFORMAR1:=tsqlquery.create(nil);
   aqSININFORMAR1.SQLConnection := MyBD;
   aqSININFORMAR1.sql.add('select * from tinspeccion where codinspe='+inttostr(inspe)+' and inspfina=''S'' ');

   aqSININFORMAR1.ExecSQL;
   aqSININFORMAR1.open;
    IF TRIM(aqSININFORMAR1.FIELDBYNAME('inspfina').ASSTRING)='S' THEN
     BEGIN
       MEMO1.Lines.Add('INFORMANDO...'+TRIM(aqSININFORMAR.FIELDBYNAME('DVDOMINO').ASSTRING));
       APPLICATION.ProcessMessages;
     TX.INFORMA_INSPECCION_AL_WEBSERVICES_automatico(aqSININFORMAR.FIELDBYNAME('TURNOID').ASINTEGER,AqSININFORMAR.FIELDBYNAME('codinspe').ASINTEGER,AqSININFORMAR.FIELDBYNAME('anio').ASINTEGER,'tdatosturno');

       application.ProcessMessages;
    END;

     aqSININFORMAR1.CLOSE;
     aqSININFORMAR1.FREE;


    aqSININFORMAR.next;
end;




 aqSININFORMAR.Close;
 aqSININFORMAR.Free;





end;





FUNCTION TForm1.INFORMAR_INSPECCION_SIN_INFORMAR(fechaturno:STRING):BOOLEAN;

var  aqlistado,aqSININFORMAR,aqSININFORMAR1:TSQLQuery;
  inspe:longint;
begin


 MEMO1.Clear;
 MEMO1.Lines.Add('INFORMANADO INSPECCIONES...');
 //APPLICATION.ProcessMessages;


aqSININFORMAR:=tsqlquery.create(nil);
aqSININFORMAR.Close;
aqSININFORMAR.SQLConnection :=MyBD;
aqSININFORMAR.sql.add('SELECT  TURNOID, codinspe, anio, DVDOMINO FROM tdatosturno   '+
                     ' WHERE  TRIM(ausente)=''N'' and TRIM(modo)=''P''  AND FECHATURNO = TO_DATE('+#39+TRIM(fechaturno)+#39+',''DD/MM/YYYY'') '+
                     ' and TRIM(reviso)=''S'' and  (TRIM(informadows)=''NO'' OR informadows IS NULL)  ' );    //AND ESTADOID IN(1,7)


aqSININFORMAR.ExecSQL;
aqSININFORMAR.open;
while not aqSININFORMAR.eof do
begin
inspe:=AqSININFORMAR.FIELDBYNAME('codinspe').ASINTEGER;

   aqSININFORMAR1:=tsqlquery.create(nil);
   aqSININFORMAR1.SQLConnection := MyBD;
   aqSININFORMAR1.sql.add('select * from tinspeccion where codinspe='+inttostr(inspe)+' and inspfina=''S'' ');

   aqSININFORMAR1.ExecSQL;
   aqSININFORMAR1.open;
    IF TRIM(aqSININFORMAR1.FIELDBYNAME('inspfina').ASSTRING)='S' THEN
     BEGIN
       MEMO1.Lines.Add('INFORMANDO...'+TRIM(aqSININFORMAR.FIELDBYNAME('DVDOMINO').ASSTRING));
       APPLICATION.ProcessMessages;
     TX.INFORMA_INSPECCION_AL_WEBSERVICES_automatico(aqSININFORMAR.FIELDBYNAME('TURNOID').ASINTEGER,AqSININFORMAR.FIELDBYNAME('codinspe').ASINTEGER,AqSININFORMAR.FIELDBYNAME('anio').ASINTEGER,'tdatosturno');

       application.ProcessMessages;
    END;

     aqSININFORMAR1.CLOSE;
     aqSININFORMAR1.FREE;


    aqSININFORMAR.next;
end;




 aqSININFORMAR.Close;
 aqSININFORMAR.Free;





end;


 


FUNCTION TForm1.INFORMAR_INSPECCION_SIN_INFORMAR_HISTORIAL(fechaturno:STRING):BOOLEAN;

var  aqlistado,aqSININFORMAR,aqSININFORMAR1:TSQLQuery;
  inspe:longint;
begin


 MEMO1.Clear;
 MEMO1.Lines.Add('INFORMANADO INSPECCIONES...');
 //APPLICATION.ProcessMessages;


aqSININFORMAR:=tsqlquery.create(nil);
aqSININFORMAR.Close;
aqSININFORMAR.SQLConnection :=MyBD;
aqSININFORMAR.sql.add('SELECT  TURNOID, codinspe, anio, DVDOMINO FROM TDATOSTURNOHISTORIAL   '+
                     ' WHERE  TRIM(ausente)=''N'' and TRIM(modo)=''P'' AND FECHATURNO = TO_DATE('+#39+TRIM(fechaturno)+#39+',''DD/MM/YYYY'') '+
                     ' and TRIM(reviso)=''S'' and  (TRIM(informadows)=''NO'' OR informadows IS NULL)   ' );    //AND ESTADOID IN(1,7)


aqSININFORMAR.ExecSQL;
aqSININFORMAR.open;
while not aqSININFORMAR.eof do
begin
inspe:=AqSININFORMAR.FIELDBYNAME('codinspe').ASINTEGER;

   aqSININFORMAR1:=tsqlquery.create(nil);
   aqSININFORMAR1.SQLConnection := MyBD;
   aqSININFORMAR1.sql.add('select * from tinspeccion where codinspe='+inttostr(inspe)+' and inspfina=''S'' ');

   aqSININFORMAR1.ExecSQL;
   aqSININFORMAR1.open;
    IF TRIM(aqSININFORMAR1.FIELDBYNAME('inspfina').ASSTRING)='S' THEN
     BEGIN
       MEMO1.Lines.Add('INFORMANDO...'+TRIM(aqSININFORMAR.FIELDBYNAME('DVDOMINO').ASSTRING));
       APPLICATION.ProcessMessages;
     TX.INFORMA_INSPECCION_AL_WEBSERVICES_automatico(aqSININFORMAR.FIELDBYNAME('TURNOID').ASINTEGER,AqSININFORMAR.FIELDBYNAME('codinspe').ASINTEGER,AqSININFORMAR.FIELDBYNAME('anio').ASINTEGER,'TDATOSTURNOHISTORIAL');

       application.ProcessMessages;
    END;

     aqSININFORMAR1.CLOSE;
     aqSININFORMAR1.FREE;


    aqSININFORMAR.next;
end;




 aqSININFORMAR.Close;
 aqSININFORMAR.Free;





end;

      


FUNCTION TForm1.INFORMAR_INSPECCION_COMO_AUCENTES_TODOSL(fechaturno:STRING):BOOLEAN;

var  aqlistado,aqSININFORMAR,aqSININFORMAR1:TSQLQuery;
  inspe,TURNOID:longint;
begin

 MEMO1.Clear;
 MEMO1.Lines.Add('INFORMANADO INSPECCIONES...');
 //APPLICATION.ProcessMessages;


aqSININFORMAR:=tsqlquery.create(nil);
aqSININFORMAR.Close;
aqSININFORMAR.SQLConnection :=MyBD;
aqSININFORMAR.sql.add('SELECT  TURNOID, codinspe, anio, DVDOMINO FROM TDATOSTURNO  '+
                     ' WHERE  TRIM(ausente)=''S'' and TRIM(modo)=''P'' AND FECHATURNO = TO_DATE('+#39+TRIM(fechaturno)+#39+',''DD/MM/YYYY'') '+
                     ' and TRIM(reviso)=''N'' ' );    //AND ESTADOID IN(1,7)


aqSININFORMAR.ExecSQL;
aqSININFORMAR.open;
while not aqSININFORMAR.eof do
begin
TURNOID:=AqSININFORMAR.FIELDBYNAME('TURNOID').ASINTEGER;


       MEMO1.Lines.Add('INFORMANDO...'+TRIM(aqSININFORMAR.FIELDBYNAME('DVDOMINO').ASSTRING));
       APPLICATION.ProcessMessages;
       SELF.INFORMAR_TURNO_COMO_AUSENTE(TURNOID,'TDATOSTURNO');
       application.ProcessMessages;



    aqSININFORMAR.next;
end;




 aqSININFORMAR.Close;
 aqSININFORMAR.Free;



 
 MEMO1.Clear;
 MEMO1.Lines.Add('INFORMANADO INSPECCIONES...');
 //APPLICATION.ProcessMessages;


aqSININFORMAR:=tsqlquery.create(nil);
aqSININFORMAR.Close;
aqSININFORMAR.SQLConnection :=MyBD;
aqSININFORMAR.sql.add('SELECT  TURNOID, codinspe, anio, DVDOMINO FROM TDATOSTURNOHISTORIAL  '+
                     ' WHERE  TRIM(ausente)=''S'' and TRIM(modo)=''P'' AND FECHATURNO = TO_DATE('+#39+TRIM(fechaturno)+#39+',''DD/MM/YYYY'') '+
                     ' and TRIM(reviso)=''N'' ' );    //AND ESTADOID IN(1,7)


aqSININFORMAR.ExecSQL;
aqSININFORMAR.open;
while not aqSININFORMAR.eof do
begin
TURNOID:=AqSININFORMAR.FIELDBYNAME('TURNOID').ASINTEGER;


       MEMO1.Lines.Add('INFORMANDO...'+TRIM(aqSININFORMAR.FIELDBYNAME('DVDOMINO').ASSTRING));
       APPLICATION.ProcessMessages;
       SELF.INFORMAR_TURNO_COMO_AUSENTE(TURNOID,'TDATOSTURNOHISTORIAL');
       application.ProcessMessages;



    aqSININFORMAR.next;
end;




 aqSININFORMAR.Close;
 aqSININFORMAR.Free;



end;


FUNCTION TForm1.INFORMAR_INSPECCION_COMO_AUCENTES_TODOSL_hisotrial:BOOLEAN;

var  aqlistado,aqSININFORMAR,aqSININFORMAR1:TSQLQuery;
fechaturno:STRING;  inspe,TURNOID:longint;
begin
 fechaturno:=DATETOSTR(DATE);

 MEMO1.Clear;
 MEMO1.Lines.Add('INFORMANADO INSPECCIONES...');
 //APPLICATION.ProcessMessages;


aqSININFORMAR:=tsqlquery.create(nil);
aqSININFORMAR.Close;
aqSININFORMAR.SQLConnection :=MyBD;
aqSININFORMAR.sql.add('SELECT  TURNOID, codinspe, anio, DVDOMINO FROM TDATOSTURNOHISTORIAL  '+
                     ' WHERE  TRIM(ausente)=''S'' and TRIM(modo)=''P''  '+
                     ' and TRIM(reviso)=''N'' and  (TRIM(informadows)=''NO'' OR informadows IS NULL)  AND  (CODINSPE IS NULL OR CODINSPE=0)   ' );    //AND ESTADOID IN(1,7)


aqSININFORMAR.ExecSQL;
aqSININFORMAR.open;
while not aqSININFORMAR.eof do
begin
TURNOID:=AqSININFORMAR.FIELDBYNAME('TURNOID').ASINTEGER;


       MEMO1.Lines.Add('INFORMANDO...'+TRIM(aqSININFORMAR.FIELDBYNAME('DVDOMINO').ASSTRING));
       APPLICATION.ProcessMessages;
      // SELF.INFORMAR_TURNO_COMO_AUSENTE_hoistorial(TURNOID);
       application.ProcessMessages;



    aqSININFORMAR.next;
end;




 aqSININFORMAR.Close;
 aqSININFORMAR.Free;





end;

procedure TForm1.BitBtn3Click(Sender: TObject);
VAR ARCHI:TEXTFILE; LINEA,IDT,PATENTE:STRING;  CANT:LONGINT;
begin
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);
IF OPENDIALOG1.Execute THEN
BEGIN
ASSIGNFILE(ARCHI,OPENDIALOG1.FileName);
END;
CANT:=0;

RESET(ARCHI);
WHILE NOT EOF(ARCHI) DO
BEGIN
CANT:=CANT + 1;
READLN(ARCHI, LINEA) ;
PATENTE:=TRIM(COPY(LINEA,1,7));
IDT:=TRIM(COPY(LINEA,7,LENGTH(TRIM(LINEA))));


TIMENOVEDAD.Enabled:=FALSe;
MEMO1.Clear;
MEMO1.Lines.Add('INICIO DESCARGA DE TURNOID '+DATETOSTR(DATE)+' '+TIMETOSTR(TIME)+' '+idt +' '+patente+'  '+INTTOSTR(CANT));




TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN
           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('DESCARGANDO...');
               TX.CONSULTA('ID',IDT,PATENTE,0);
              // TX.CONSULTA('ID','25432','GWQ730');

               MEMO1.Clear;
               MEMO1.Lines.Add('ESPERANDO CONEXION...');
              END;



         END else
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');






  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
  END;







TIMENOVEDAD.Enabled:=TRUE;

END;//WHILE ARCHI
mybd.Close;
  tx.Free;
  memo1.Lines.Add('tERMINO....');
APPLICATION.ProcessMessages;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
TIMENOVEDAD.Enabled:=FALSe;
 SELF.Timer3.Enabled:=false;

MEMO1.Clear;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
Timer1.Enabled:=FALSE;
PROCEDIMIENTOS_XML_PAGOS_INDIVIDUAL;
PROCEDIMIENTOS_XML_PAGOS_FLOTA;
Timer1.Enabled:=TRUE;
   
end;

procedure TForm1.BitBtn6Click(Sender: TObject);

begin
FA:=tfacturae.CREATE;
FA.LEER_PARAMETROS;
memo1.Lines.Add('CONECTANDO CON AFIP...');
application.ProcessMessages;

if fa.Autenticar(trim(fa.MODO_FAE),trim(fa.carpeta),trim(fa.CUIT_EMPRESA))=false then
 begin
 TIENE_CONEXION_ELECTRONICA:=FALSE;
    memo1.Lines.Add('FACTURA ELECTRONICA: ERROR DE AUTENTICACION.');
    TX.TRAZAS('FACTURA ELECTRONICA: ERROR DE AUTENTICACION.');

    application.ProcessMessages;

 end ELSE
 BEGIN
 fA.Control_servidores(FA.Token,FA.Sign,FA.MODO_FAE,FA.CUIT_EMPRESA);

    IF TRIM(FA.estado_servidor)='OK' THEN
     BEGIN
       MEMO1.Lines.Add('ESTADO SERVIDOR AFIP: OK');
     END ELSE
     BEGIN
     MEMO1.Lines.Add('ESTADO SERVIDOR AFIP: NO DISPONIBLE');
     TX.TRAZAS('ESTADO SERVIDOR AFIP: NO DISPONIBLE.');

     END;

    application.ProcessMessages;


   IF TRIM(FA.Estado_autentica)='OK' THEN
    BEGIN
    MEMO1.Lines.Add('ESTADO AUTENTICACION AFIP: OK');
    END ELSE
    BEGIN
      MEMO1.Lines.Add('ESTADO AUTENTICACION AFIP: NO DISPONIBLE');
      TX.TRAZAS('ESTADO AUTENTICACION AFIP: NO DISPONIBLE.');
    END;
     application.ProcessMessages;


   IF TRIM(FA.estado_bd)='OK' THEN
    BEGIN
     MEMO1.Lines.Add('ESTADO BASE DE DATOS AFIP: OK');
    END ELSE
   BEGIN
     MEMO1.Lines.Add('ESTADO BASE DE DATOS AFIP: NO DISPONIBLE');
     TX.TRAZAS('ESTADO BASE DE DATOS AFIP: NO DISPONIBLE.');
   END;

    application.ProcessMessages;



    IF   (TRIM(FA.estado_bd)='OK')  AND (TRIM(FA.Estado_autentica)='OK')  AND (TRIM(FA.estado_servidor)='OK') THEN
     BEGIN
        TIENE_CONEXION_ELECTRONICA:=TRUE;
        MEMO1.Lines.Add('PROCESO DE FACTURA ELECTRONICA: OK');
        application.ProcessMessages;

      END      ELSE
        BEGIN

          TIENE_CONEXION_ELECTRONICA:=FALSE;
          MEMO1.Lines.Add('PROCESO DE FACTURA ELECTRONICA: NO DISPONIBLE');
          TX.TRAZAS('PROCESO DE FACTURA ELECTRONICA: NO DISPONIBLe.');
          application.ProcessMessages;

        END;


END;





       IF TIENE_CONEXION_ELECTRONICA=TRUE THEN
         BEGIN
         MEMO1.Lines.Add('CONSULTANDO PROXIMOS NRO...');
        application.ProcessMessages;

          FA.consultas_numeros_FACTURAS(FA.MODO_FAE) ;
           MEMO1.Lines.Add('SANTA MARIA ---> FACTURA A PROXIMO: '+INTTOSTR(FA.proxima_Fa_3));
           MEMO1.Lines.Add('SANTA MARIA ---> FACTURA B PROXIMO: '+INTTOSTR(FA.proxima_Fb_3));
           MEMO1.Lines.Add('VELEZ ---> FACTURA A PROXIMO: '+INTTOSTR(FA.proxima_Fa_2));
           MEMO1.Lines.Add('VELEZ ---> FACTURA B PROXIMO: '+INTTOSTR(FA.proxima_FB_2));


         END;

  

end;


procedure TForm1.BitBtn7Click(Sender: TObject);
VAR   aqBUSCARTURNO:tsqlquery;  CANT:LONGINT;
PATENTE,IDT:STRING;
BEGIN
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);


MEMO1.Lines.Add('UPDATE CLIENTES =0');
MEMO1.Lines.Add('arregla_cliente_cero_con_pagos');
APPLICATION.ProcessMessages;
arregla_cliente_cero_con_pagos;
self.arregla_cliente_cero_con_pagos_fechaturno;
MEMO1.Lines.Add('Arregla_codcliente_cero');
APPLICATION.ProcessMessages;
Arregla_codcliente_cero;
self.Arregla_codcliente_cero_fechaturno;
baja_pagos_faltantes;
arregla_cliente_cero_con_pagos;
self.ARREGLA_TURNOS_CLIENTES_CEROS;
ARREGLA_TURNOS_CLIENTES_CEROS_fecharegistro ;
arregla_exentos_sin_idpago;
MEMO1.Lines.Add('PROCESO TERMINADO TODOS !!!');
{
 CANT:=0;

   aqBUSCARTURNO:=tsqlquery.create(nil);
   aqBUSCARTURNO.SQLConnection := MyBD ;
   aqBUSCARTURNO.sql.add('SELECT  TURNOID, DVDOMINO FROM TDATOSTURNO WHERE CODCLIEN=0' );// and fechaturno=to_date('+#39+trim(FECHA)+#39+',''dd/mm/yyyy'')');

   aqBUSCARTURNO.ExecSQL;
   aqBUSCARTURNO.OPEN ;


WHILE NOT aqBUSCARTURNO.EOF DO
BEGIN
CANT:=CANT + 1;

PATENTE:=TRIM(aqBUSCARTURNO.FIELDBYNAME('DVDOMINO').AsString);
IDT:=TRIM(aqBUSCARTURNO.FIELDBYNAME('TURNOID').AsString);


TIMENOVEDAD.Enabled:=FALSe;
MEMO1.Clear;
MEMO1.Lines.Add('INICIO DESCARGA DE TURNOID '+DATETOSTR(DATE)+' '+TIMETOSTR(TIME)+' '+idt +' '+patente+'  '+INTTOSTR(CANT));

//tx:=txml_caba.Create;
//tf.TestOfBD('', '', '' ,false);
TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN
           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('DESCARGANDO...');
               TX.CONSULTA('IDCL',IDT,PATENTE);
              // TX.CONSULTA('ID','25432','GWQ730');
                 sleep(500);
               MEMO1.Clear;
               MEMO1.Lines.Add('ESPERANDO CONEXION...');
              END;



         END else
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');






  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
  END;








  aqBUSCARTURNO.Next;
END;//WHILE ARCHI
 TIMENOVEDAD.Enabled:=TRUE;
 memo1.lines.add('PROCESO TERMINADO !!!');
 }

 mybd.Close;
  tx.Free;
  
end;

procedure TForm1.arregla_cliente_cero_con_pagos  ;
VAR   aqBUSCARTURNO,aqBUSCARTURNO1,aqBUSCARTURNO2:tsqlquery;  CANT,IDp,CODCLIENTETITULAR,IDT:LONGINT;
PATENTE:STRING;
BEGIN

 CANT:=0;

   aqBUSCARTURNO:=tsqlquery.create(nil);
   aqBUSCARTURNO.SQLConnection := MyBD ;
   aqBUSCARTURNO.sql.add('SELECT  TURNOID, DVDOMINO,pagoidverificacion FROM TDATOSTURNO '+
   ' WHERE to_char(fecharegistro,''dd/mm/yyyy'')= to_char(sysdate,''dd/mm/yyyy'') and  '+
   ' CODCLIEN=0 and reviso=''N'' and ESTADOACREDITACIONVERIFICACION in (''A'',''E'') ');// and fechaturno=to_date('+#39+trim(FECHA)+#39+',''dd/mm/yyyy'')');

   aqBUSCARTURNO.ExecSQL;
   aqBUSCARTURNO.OPEN ;


WHILE NOT aqBUSCARTURNO.EOF DO
BEGIN
     IDp:=aqBUSCARTURNO.FIELDBYNAME('pagoidverificacion').asinteger;
     idt:=aqBUSCARTURNO.FIELDBYNAME('TURNOID').asinteger;
       aqBUSCARTURNO1:=tsqlquery.create(nil);
       aqBUSCARTURNO1.SQLConnection := MyBD ;
       aqBUSCARTURNO1.Close;
       aqBUSCARTURNO1.SQL.Clear;
       aqBUSCARTURNO1.sql.add('  select  TI.CODCLIENTETITULAR from tdetallespago td, tinformacionpago ti '+
                             ' where TD.IDDETALLESPAGO=TI.IDDETALLESPAGO and td.PAGOID='+inttostr(IDp));
       aqBUSCARTURNO1.ExecSQL;
       aqBUSCARTURNO1.OPEN ;

      while not  aqBUSCARTURNO1.Eof do
       BEGIN
            CODCLIENTETITULAR:=aqBUSCARTURNO1.fields[0].asinteger;

             aqBUSCARTURNO2:=tsqlquery.create(nil);
             aqBUSCARTURNO2.SQLConnection := MyBD ;
            aqBUSCARTURNO2.Close;
            aqBUSCARTURNO2.SQL.Clear;
            aqBUSCARTURNO2.sql.add(' update TDATOSTURNO set codclien='+inttostr(CODCLIENTETITULAR)+' where turnoid='+inttostr(idt));
            aqBUSCARTURNO2.ExecSQL;

            aqBUSCARTURNO2.close;
            aqBUSCARTURNO2.free;
            aqBUSCARTURNO1.Next
       END;

       aqBUSCARTURNO1.Close;
       aqBUSCARTURNO1.Free;




 aqBUSCARTURNO.Next;
END;//WHILE ARCHI

  aqBUSCARTURNO.close;
  aqBUSCARTURNO.free;

end;


procedure TForm1.arregla_cliente_cero_con_pagos_fechaturno  ;
VAR   aqBUSCARTURNO,aqBUSCARTURNO1,aqBUSCARTURNO2:tsqlquery;  CANT,IDp,CODCLIENTETITULAR,IDT:LONGINT;
PATENTE:STRING;
BEGIN

 CANT:=0;

   aqBUSCARTURNO:=tsqlquery.create(nil);
   aqBUSCARTURNO.SQLConnection := MyBD ;
   aqBUSCARTURNO.sql.add('SELECT  TURNOID, DVDOMINO,pagoidverificacion FROM TDATOSTURNO '+
   ' WHERE to_char(fechaturno,''dd/mm/yyyy'')= to_char(sysdate,''dd/mm/yyyy'')  '+
   ' and  CODCLIEN=0 and reviso=''N''  and ESTADOACREDITACIONVERIFICACION in (''A'',''E'') ');// and fechaturno=to_date('+#39+trim(FECHA)+#39+',''dd/mm/yyyy'')');

   aqBUSCARTURNO.ExecSQL;
   aqBUSCARTURNO.OPEN ;


WHILE NOT aqBUSCARTURNO.EOF DO
BEGIN
     IDp:=aqBUSCARTURNO.FIELDBYNAME('pagoidverificacion').asinteger;
     idt:=aqBUSCARTURNO.FIELDBYNAME('TURNOID').asinteger;
       aqBUSCARTURNO1:=tsqlquery.create(nil);
       aqBUSCARTURNO1.SQLConnection := MyBD ;
       aqBUSCARTURNO1.Close;
       aqBUSCARTURNO1.SQL.Clear;
       aqBUSCARTURNO1.sql.add('  select  TI.CODCLIENTETITULAR from tdetallespago td, tinformacionpago ti '+
                             ' where TD.IDDETALLESPAGO=TI.IDDETALLESPAGO and td.PAGOID='+inttostr(IDp));
       aqBUSCARTURNO1.ExecSQL;
       aqBUSCARTURNO1.OPEN ;

      while not  aqBUSCARTURNO1.Eof do
       BEGIN
            CODCLIENTETITULAR:=aqBUSCARTURNO1.fields[0].asinteger;

             aqBUSCARTURNO2:=tsqlquery.create(nil);
             aqBUSCARTURNO2.SQLConnection := MyBD ;
            aqBUSCARTURNO2.Close;
            aqBUSCARTURNO2.SQL.Clear;
            aqBUSCARTURNO2.sql.add(' update TDATOSTURNO set codclien='+inttostr(CODCLIENTETITULAR)+' where turnoid='+inttostr(idt));
            aqBUSCARTURNO2.ExecSQL;

            aqBUSCARTURNO2.close;
            aqBUSCARTURNO2.free;
            aqBUSCARTURNO1.Next
       END;

       aqBUSCARTURNO1.Close;
       aqBUSCARTURNO1.Free;




 aqBUSCARTURNO.Next;
END;//WHILE ARCHI

  aqBUSCARTURNO.close;
  aqBUSCARTURNO.free;

end;

procedure TForm1.Arregla_codcliente_cero;
VAR   aqBUSCARTURNO:tsqlquery;  CANT:LONGINT;
PATENTE,IDT:STRING;
BEGIN

 CANT:=0;

   aqBUSCARTURNO:=tsqlquery.create(nil);
   aqBUSCARTURNO.SQLConnection := MyBD ;
   aqBUSCARTURNO.sql.add('SELECT  TURNOID, DVDOMINO,pagoidverificacion FROM TDATOSTURNO '+
   ' WHERE to_char(fecharegistro,''dd/mm/yyyy'')= to_char(sysdate,''dd/mm/yyyy'') and  CODCLIEN=0 and reviso=''N'' '+
   '   and ESTADOACREDITACIONVERIFICACION in (''A'',''E'')  ');// and fechaturno=to_date('+#39+trim(FECHA)+#39+',''dd/mm/yyyy'')');

   aqBUSCARTURNO.ExecSQL;
   aqBUSCARTURNO.OPEN ;

 TIMENOVEDAD.Enabled:=FALSe;
WHILE NOT aqBUSCARTURNO.EOF DO
BEGIN
CANT:=CANT + 1;

PATENTE:=TRIM(aqBUSCARTURNO.FIELDBYNAME('DVDOMINO').AsString);
IDT:=TRIM(aqBUSCARTURNO.FIELDBYNAME('TURNOID').AsString);



MEMO1.Clear;
MEMO1.Lines.Add('INICIO DESCARGA DE TURNOID '+DATETOSTR(DATE)+' '+TIMETOSTR(TIME)+' '+idt +' '+patente+'  '+INTTOSTR(CANT));

//tx:=txml_caba.Create;
//tf.TestOfBD('', '', '' ,false);
TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN
           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('DESCARGANDO...');
               TX.CONSULTA('IDCL',IDT,PATENTE,0);
              // TX.CONSULTA('ID','25432','GWQ730');

               MEMO1.Clear;
               MEMO1.Lines.Add('ESPERANDO CONEXION...');
              END;



         END else
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');






  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
  END;








  aqBUSCARTURNO.Next;
END;//WHILE ARCHI
aqBUSCARTURNO.Close;
aqBUSCARTURNO.Free;

 memo1.lines.add('PROCESO TERMINADO !!!');

end;



procedure TForm1.Arregla_codcliente_cero_fechaturno;
VAR   aqBUSCARTURNO:tsqlquery;  CANT:LONGINT;
PATENTE,IDT:STRING;
BEGIN

 CANT:=0;

   aqBUSCARTURNO:=tsqlquery.create(nil);
   aqBUSCARTURNO.SQLConnection := MyBD ;
   aqBUSCARTURNO.sql.add('SELECT  TURNOID, DVDOMINO,pagoidverificacion FROM TDATOSTURNO '+
   ' WHERE to_char(fechaturno,''dd/mm/yyyy'')= to_char(sysdate,''dd/mm/yyyy'') and   '+
   ' CODCLIEN=0 and reviso=''N''  and ESTADOACREDITACIONVERIFICACION in (''A'',''E'') ');// and fechaturno=to_date('+#39+trim(FECHA)+#39+',''dd/mm/yyyy'')');

   aqBUSCARTURNO.ExecSQL;
   aqBUSCARTURNO.OPEN ;

 TIMENOVEDAD.Enabled:=FALSe;
WHILE NOT aqBUSCARTURNO.EOF DO
BEGIN
CANT:=CANT + 1;

PATENTE:=TRIM(aqBUSCARTURNO.FIELDBYNAME('DVDOMINO').AsString);
IDT:=TRIM(aqBUSCARTURNO.FIELDBYNAME('TURNOID').AsString);



MEMO1.Clear;
MEMO1.Lines.Add('INICIO DESCARGA DE TURNOID '+DATETOSTR(DATE)+' '+TIMETOSTR(TIME)+' '+idt +' '+patente+'  '+INTTOSTR(CANT));

//tx:=txml_caba.Create;
//tf.TestOfBD('', '', '' ,false);
TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN
           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('DESCARGANDO...');
               TX.CONSULTA('IDCL',IDT,PATENTE,0);
              // TX.CONSULTA('ID','25432','GWQ730');

               MEMO1.Clear;
               MEMO1.Lines.Add('ESPERANDO CONEXION...');
              END;



         END else
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');






  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
  END;








  aqBUSCARTURNO.Next;
END;//WHILE ARCHI

aqBUSCARTURNO.Close;
aqBUSCARTURNO.Free;

 memo1.lines.add('PROCESO TERMINADO !!!');

end;

procedure TForm1.BitBtn8Click(Sender: TObject);
begin
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);


TURNOS_SIN_FACTURAR_DEL_DIA;
mybd.Close;
  tx.Free;
end;

procedure TForm1.BitBtn9Click(Sender: TObject);
VAR IDTURNO:LONGINT;
updatesql:TSQLQuery;
arhivo_xml:string;
begin
if OpenDialog2.Execute then
begin
arhivo_xml:=OpenDialog2.FileName;
 if trim(arhivo_xml)='' then
 exit;

 
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);
 TX.CONFIGURAR;

tx.procesar_xml_a_pata(arhivo_xml);
mybd.Close;
  tx.Free;
  memo1.Clear;
  memo1.Lines.Add('PROCESO TERMINADO');
end;



end;

procedure TForm1.BitBtn10Click(Sender: TObject);
begin
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);


TURNOS_SIN_FACTURAR_todos;
mybd.Close;
  tx.Free;
end;

procedure TForm1.BitBtn11Click(Sender: TObject);
VAR ARCHI:TEXTFILE; LINEA,IDT,PATENTE:STRING;  CANT:LONGINT;
begin
IF TRIM(EDIT2.Text)='' THEN
 BEGIN

     Application.MessageBox( 'Debe ingrear la patente.', 'Atenci�n',
  MB_ICONINFORMATION );
  exit;
 END;


 IF TRIM(EDIT3.Text)='' THEN
 BEGIN

     Application.MessageBox( 'Debe ingrear el turnoid.', 'Atenci�n',
  MB_ICONINFORMATION );
  exit;
 END;

PATENTE:=TRIM(EDIT2.TEXT);
IDT:=TRIM(EDIT3.TEXT);


TIMENOVEDAD.Enabled:=FALSe;
MEMO1.Clear;
MEMO1.Lines.Add('INICIANDO DESCARGA DE TURNO:  '+idt +' '+patente);
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);

//tx:=txml_caba.Create;
//tf.TestOfBD('', '', '' ,false);
TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN
           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('DESCARGANDO...');
               TX.CONSULTA('ID',IDT,PATENTE,0);
              // TX.CONSULTA('ID','25432','GWQ730');

               MEMO1.Clear;
               MEMO1.Lines.Add('PROCESO TERMINADO !!!!');
               EDIT2.Clear;
               EDIT3.CLEAR;
              END;



         END else
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');






  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
  END;





  tx.Cerrar_seccion;


// mybd.Close;
  tx.Free;
 //Application.MessageBox( 'PROCESO TERMINADO !!!.', 'Atenci�n',
 // MB_ICONINFORMATION );
end;


procedure TForm1.BitBtn5Click(Sender: TObject);
begin
CLOSE;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);


INICIAR_DESCARGA_DIA;
mybd.Close;
  tx.Free;
end;

procedure TForm1.DESCARGAR_XML_PAGOS;
begin
TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN
           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('DESCARGANDO  PAGOS...');
               TX.DESCARGAR_PAGOS_POR_NOVEDAD('F');
               if tx.ver_respuestaidpago=1 then
                begin
                     MEMO1.Lines.Add('ESTADO DESCARGA: '+TX.ver_respuestamensajepago);
                     MEMO1.Lines.Add('CANTIDAD DE PAGOS: '+TX.ver_cantidadPagos);
                     APPLICATION.ProcessMessages;

                     IF STRTOINT(TX.ver_cantidadPagos) > 0 THEN
                       TX.PROCESARARCHIVOPAGOS(TX.VER_ARCHIVOS_XML_PAGOS);




                end ELSE BEGIN
                  MEMO1.Lines.Add('ESTADO DESCARGA: '+TX.ver_respuestamensajepago);


                END;







            //  Factura_Electronica_pagos_suvtv(TX.ver_planta);
               MEMO1.Clear;
               MEMO1.Lines.Add('PROCESO TERMINADO !!!!.INSERTADOS: '+INTTOSTR(TX.ver_total_registros_pagos_insertados)+'  DE: '+TX.ver_cantidadPagos);

              END;



         END else
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');






  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
  END;





  tx.Cerrar_seccion;



end;



procedure TForm1.BitBtn12Click(Sender: TObject);
begin
MEMO1.Clear;
memo1.Lines.Add('ESPERADO CONEXION...'+DATETOSTR(DATE)+' - '+TIMETOSTR(TIME));

//DESCARGAR_XML_PAGOS;

TX.TRAZAS('PP');
end;

procedure TForm1.timepagosTimer(Sender: TObject);
begin
MEMO1.Clear;
memo1.Lines.Add('ESPERADO CONEXION...'+DATETOSTR(DATE)+' - '+TIMETOSTR(TIME));

timepagos.Enabled:=FALSE;
{if (trim(timetostr(time))='01:30:00')
    or  (trim(timetostr(time))='02:30:00')
    or  (trim(timetostr(time))='03:30:00')
    or  (trim(timetostr(time))='04:30:00')
    or  (trim(timetostr(time))='05:30:00')
    or  (trim(timetostr(time))='06:30:00')
    or  (trim(timetostr(time))='07:30:00')
    or  (trim(timetostr(time))='08:30:00')
    or  (trim(timetostr(time))='09:30:00')
    or  (trim(timetostr(time))='10:30:00')
    or  (trim(timetostr(time))='11:30:00')
    or  (trim(timetostr(time))='12:30:00')
    or  (trim(timetostr(time))='13:30:00')
    or  (trim(timetostr(time))='14:30:00')
     or  (trim(timetostr(time))='16:02:00')
    or  (trim(timetostr(time))='15:30:00')
    or  (trim(timetostr(time))='16:30:00')
    or  (trim(timetostr(time))='17:30:00')
    or  (trim(timetostr(time))='18:30:00')
    or  (trim(timetostr(time))='19:30:00')
    or  (trim(timetostr(time))='20:30:00')
    or  (trim(timetostr(time))='21:30:00')
    or  (trim(timetostr(time))='22:30:00')
    or  (trim(timetostr(time))='23:20:00')

 then
  begin }
//  DESCARGAR_XML_PAGOS;
 // end;









timepagos.Enabled:=TRUE;
end;

function TForm1.StopProcess(ExeFileName: string) : Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(
                        OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

procedure TForm1.BitBtn13Click(Sender: TObject);
var letra,A,nro,tipo:string;
aqQmt:tsqlquery;
begin
FA:=tfacturae.CREATE;
FA.LEER_PARAMETROS;
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);

GENERA_PDF_FALTANTE(trim(edit7.Text),trim(combobox1.Text));
fa.free;
 mybd.Close;
  tx.Free;
 memo1.Lines.Add('GENERACION DE PDF TERMINADO...');
 APPLICATION.ProcessMessages;
// SetProcessWorkingSetSize(GetCurrentProcess, $FFFFFFFF, $FFFFFFFF);
end;

procedure TForm1.BitBtn14Click(Sender: TObject);
VAR D,H:STRING;
begin
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);

D:=COPY(DATETOSTR(DATETIMEPICKER2.DateTime),7,4)+'-'+COPY(DATETOSTR(DATETIMEPICKER2.DateTime),4,2)+'-'+COPY(DATETOSTR(DATETIMEPICKER2.DateTime),1,2);
H:=COPY(DATETOSTR(DATETIMEPICKER2.DateTime),7,4)+'-'+COPY(DATETOSTR(DATETIMEPICKER2.DateTime),4,2)+'-'+COPY(DATETOSTR(DATETIMEPICKER2.DateTime),1,2);

D:=D+' '+TRIM(EDIT5.Text);
H:=H+' '+TRIM(EDIT6.Text);


self.PROCEDIMIENTOS_XML_PAGOS_INDIVIDUAL_por_fecha(D,H);
SELF.PROCEDIMIENTOS_XML_PAGOS_FLOTA_POR_FECHA(D,H);
mybd.Close;

  tx.Free;
end;

procedure TForm1.BitBtn15Click(Sender: TObject);
VAR   aq,aq1:tsqlquery;
 NRO_COMPROBANTE,  EMAIL,nombre_para_mail,patente_para_factura:STRING; IDDETALLESPAGO,CODCLIENTE:LONGINT;  ARCHIVOENVIADO:sTRING;
begin
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);

self.enviarmail.Enabled:=true;
enviarmailTimer(Sender);
mybd.Close;
  tx.Free;
{
 TX.CONFIGURAR;
 FA:=tfacturae.CREATE;
FA.LEER_PARAMETROS;

aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
aq.sql.add('Select  NRO_COMPROBANTE,  EMAIL, IDDETALLESPAGO, '+
'  ARCHIVOENVIADO from TDETALLESPAGO  WHERE ENVIOMAIL=''N'' AND FACTURADO=''S'' ');

aq.ExecSQL;
aq.open;
while not aq.eof do
  begin
 NRO_COMPROBANTE:=aq.FIELDBYNAME('NRO_COMPROBANTE').ASSTRING;
 EMAIL:=aq.FIELDBYNAME('EMAIL').ASSTRING;
 IDDETALLESPAGO:=aq.FIELDBYNAME('IDDETALLESPAGO').ASINTEGER;
 ARCHIVOENVIADO:=aq.FIELDBYNAME('ARCHIVOENVIADO').ASSTRING;


 aq1:=tsqlquery.create(nil);
aq1.SQLConnection := MyBD;
aq1.sql.add('Select  * FROM TINFORMACIONPAGO WHERE IDDETALLESPAGO='+INTTOSTR(IDDETALLESPAGO));

aq1.ExecSQL;
aq1.open;
patente_para_factura:=aq1.FIELDBYNAME('DOMINIO').ASSTRING;
CODCLIENTE:=aq1.FIELDBYNAME('CODCLIENTEFACTURACION').ASINTEGER;
aq1.CLOSE;
aq1.Free;



 aq1:=tsqlquery.create(nil);
aq1.SQLConnection := MyBD;
aq1.sql.add('Select  * FROM TCLIENTES WHERE CODCLIEN='+INTTOSTR(CODCLIENTE));

aq1.ExecSQL;
aq1.open;
nombre_para_mail:=aq1.FIELDBYNAME('NOMBRE').ASSTRING+' '+aq1.FIELDBYNAME('APELLID1').ASSTRING;

aq1.CLOSE;
aq1.Free;


 IF EnviarMensaje(TRIM(EMAIL),NRO_COMPROBANTE,ARCHIVOENVIADO,nombre_para_mail,patente_para_factura)=true then
 BEGIN
     aq1:=tsqlquery.create(nil);
     aq1.SQLConnection := MyBD;
     aq1.sql.add('UPDATE TDETALLESPAGO SET ENVIOMAIL=''S'' WHERE IDDETALLESPAGO='+INTTOSTR(IDDETALLESPAGO));

    aq1.ExecSQL;

 END;


AQ.Next;

END;
FA.Free;
 TX.Free;;
Application.MessageBox( 'LISTO !!!.', 'Atenci�n',
  MB_ICONINFORMATION ); }


end;




procedure TForm1.reenvio_de_mail_sin_enviar;
VAR   aq,aq1:tsqlquery;  total:longint;
 NRO_COMPROBANTE,  EMAIL,nombre_para_mail,patente_para_factura:STRING; IDDETALLESPAGO,CODCLIENTE:LONGINT;  ARCHIVOENVIADO:sTRING;
begin
 TX.CONFIGURAR;
 FA:=tfacturae.CREATE;
FA.LEER_PARAMETROS;

aq:=tsqlquery.create(nil);
aq.SQLConnection := MyBD;
aq.sql.add('Select  NRO_COMPROBANTE,  EMAIL, IDDETALLESPAGO, '+
'  ARCHIVOENVIADO from TDETALLESPAGO  WHERE ENVIOMAIL=''N'' AND FACTURADO=''S'' and rownum=1');

aq.ExecSQL;
aq.open;
while not aq.eof do
  begin
 NRO_COMPROBANTE:=aq.FIELDBYNAME('NRO_COMPROBANTE').ASSTRING;
 EMAIL:=aq.FIELDBYNAME('EMAIL').ASSTRING;
 IDDETALLESPAGO:=aq.FIELDBYNAME('IDDETALLESPAGO').ASINTEGER;
 ARCHIVOENVIADO:=aq.FIELDBYNAME('ARCHIVOENVIADO').ASSTRING;
 memo1.Lines.Add(ARCHIVOENVIADO+'  '+NRO_COMPROBANTE);
 application.ProcessMessages;

 aq1:=tsqlquery.create(nil);
aq1.SQLConnection := MyBD;
aq1.sql.add('Select  * FROM TINFORMACIONPAGO WHERE IDDETALLESPAGO='+INTTOSTR(IDDETALLESPAGO));

aq1.ExecSQL;
aq1.open;
patente_para_factura:=aq1.FIELDBYNAME('DOMINIO').ASSTRING;
CODCLIENTE:=aq1.FIELDBYNAME('CODCLIENTEFACTURACION').ASINTEGER;
aq1.CLOSE;
aq1.Free;



 aq1:=tsqlquery.create(nil);
aq1.SQLConnection := MyBD;
aq1.sql.add('Select  * FROM TCLIENTES WHERE CODCLIEN='+INTTOSTR(CODCLIENTE));

aq1.ExecSQL;
aq1.open;
nombre_para_mail:=aq1.FIELDBYNAME('NOMBRE').ASSTRING+' '+aq1.FIELDBYNAME('APELLID1').ASSTRING;

aq1.CLOSE;
aq1.Free;


 IF EnviarMensaje(TRIM(EMAIL),NRO_COMPROBANTE,ARCHIVOENVIADO,nombre_para_mail,patente_para_factura)=true then
 BEGIN
     aq1:=tsqlquery.create(nil);
     aq1.SQLConnection := MyBD;
     aq1.sql.add('UPDATE TDETALLESPAGO SET ENVIOMAIL=''S'' WHERE IDDETALLESPAGO='+INTTOSTR(IDDETALLESPAGO));

    aq1.ExecSQL;

    total_envio:=total_envio + 1;
    memo1.Lines.Add('envio: '+inttostr(total_envio)) ;
    application.ProcessMessages;
 END;





AQ.Next;

END;
AQ.Close;
AQ.Free;

FA.Free;
 TX.Free;;

end;

procedure TForm1.enviarmailTimer(Sender: TObject);
begin
memo1.Lines.Add('reenviado mail...');
application.ProcessMessages;
self.Enabled:=false;
reenvio_de_mail_sin_enviar;
self.Enabled:=true;
end;


function tform1.baja_pagos_faltantes:boolean;
var aqbajapagofaltante:tsqlquery; idpagoverif:longint;
begin
TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN

           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN

               aqbajapagofaltante:=tsqlquery.create(nil);
               aqbajapagofaltante.SQLConnection := MyBD;
               aqbajapagofaltante.sql.add('select tipoturno, pagoidverificacion from tdatosturno '+
                                          ' where to_char(fecharegistro,''dd/mm/yyyy'')=to_char(sysdate,''dd/mm/yyyy'') '+
                                          ' and codclien=0 and ESTADOACREDITACIONVERIFICACION in (''A'',''E'')  ');
               aqbajapagofaltante.ExecSQL;
               aqbajapagofaltante.Open;
               while not aqbajapagofaltante.Eof do
                begin
                    idpagoverif:=aqbajapagofaltante.fieldbyname('pagoidverificacion').AsInteger;
                    TX.DESCARGAR_PAGOS_POR_CODIGO_PAGO(idpagoverif,0);       //183838


                     if tx.ver_respuestaidpago=1 then
                         begin
                          IF STRTOINT(TX.ver_cantidadPagos) > 0 THEN
                             begin
                               TX.PROCESARARCHIVOPAGOS(TX.VER_ARCHIVOS_XML_PAGOS);
                              end;

                         END;





                aqbajapagofaltante.Next;
               end;
               aqbajapagofaltante.Close;
               aqbajapagofaltante.Free;

 end;
 end;
 end;
     
end;

procedure TForm1.BitBtn16Click(Sender: TObject);
var
  XMLDoc: IXMLDocument;
  Node: IXMLNode;
  I: Integer;
  role, link: string;

begin
IF TRIM(EDIT8.Text)='' THEN
BEGIN

 SHOWMESSAGE('INGRESE EL EXTERNARL REFERENCE');
   EXIT;
END;
tx:=txml_caba.Create;
TX.CONFIGURAR;
TX.ControlServidor;

tX.TestOfBD('', '', '' ,false);

IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN
           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('DESCARGANDO  PAGO '+TRIM(EDIT8.Text)+'...');
              TX.DESCARGAR_PAGOS_POR_CODIGO_PAGO(STRTOINT(EDIT8.Text),0);       //183838
               //TX.DESCARGAR_PAGOS_POR_NOVEDAD('I');

               if tx.ver_respuestaidpago=1 then
                begin
                     MEMO1.Lines.Add('ESTADO DESCARGA: '+TX.ver_respuestamensajepago);
                     MEMO1.Lines.Add('CANTIDAD DE PAGOS: '+TX.ver_cantidadPagos);
                     APPLICATION.ProcessMessages;

                   IF STRTOINT(TX.ver_cantidadPagos) > 0 THEN
                   begin
                    MEMO1.Lines.Add('PROCESANDO PAGOS...');
                     APPLICATION.ProcessMessages;

                     TX.PROCESARARCHIVOPAGOS(TX.VER_ARCHIVOS_XML_PAGOS);
                  end;



                end ELSE BEGIN
                  MEMO1.Lines.Add('ESTADO DESCARGA: '+TX.ver_respuestamensajepago);


                END;





              {IF  (TRIM(TX.VER_HABILITADO_FACTURA)='S') AND (TRIM(TX.VER_FECHA_VENCE_CERTIFICADO)<>'N') THEN
                BEGIN
                   IF STRTODATE(TRIM(TX.VER_FECHA_VENCE_CERTIFICADO))> NOW THEN
                       Factura_Electronica_pagos_suvtv(TX.ver_planta)
                      else
                      MEMO1.Lines.Add('CERTIFICADO DE FACTURA ELECTRONICA VENCIDO!!!!');

                END;  }


               MEMO1.Clear;
               MEMO1.Lines.Add('PROCESO TERMINADO !!!!.');

              END;

            TX.Cerrar_seccion;

         END else
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');






  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
  END;



mybd.Close;
  tx.Free;

end;


procedure TForm1.procesar_idpago_bajar(pagoidd:longint);
var
  XMLDoc: IXMLDocument;
  Node: IXMLNode;
  I: Integer;
  role, link: string;

begin
 memo1.Clear;

TX.CONFIGURAR;
TX.ControlServidor;
IF TX.ver_respuestaidservidor=1 THEN
  BEGIN
        IF trim(TX.ver_disponibilidad_servidor)='true' then
        BEGIN
           MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: SI');
           MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
           TX.Abrir_Seccion;
              IF  TX.ver_respuestaid_Abrir=1 THEN
              BEGIN
               MEMO1.Lines.Add('INICIO DE SECCION EN SUVTV: '+TX.ver_respuestamensaje_Abrir);
               MEMO1.Lines.Add('DESCARGANDO  PAGO '+inttostr(pagoidd)+'...');
              TX.DESCARGAR_PAGOS_POR_CODIGO_PAGO(pagoidd,0);       //183838
               //TX.DESCARGAR_PAGOS_POR_NOVEDAD('I');

               if tx.ver_respuestaidpago=1 then
                begin
                     MEMO1.Lines.Add('ESTADO DESCARGA: '+TX.ver_respuestamensajepago);
                     MEMO1.Lines.Add('CANTIDAD DE PAGOS: '+TX.ver_cantidadPagos);
                     APPLICATION.ProcessMessages;

                   IF STRTOINT(TX.ver_cantidadPagos) > 0 THEN
                   begin
                    MEMO1.Lines.Add('PROCESANDO PAGOS...');
                     APPLICATION.ProcessMessages;

                     TX.PROCESARARCHIVOPAGOS(TX.VER_ARCHIVOS_XML_PAGOS);
                  end;



                end ELSE BEGIN
                  MEMO1.Lines.Add('ESTADO DESCARGA: '+TX.ver_respuestamensajepago);


                END;




            {
              IF  (TRIM(TX.VER_HABILITADO_FACTURA)='S') AND (TRIM(TX.VER_FECHA_VENCE_CERTIFICADO)<>'N') THEN
                BEGIN
                   IF STRTODATE(TRIM(TX.VER_FECHA_VENCE_CERTIFICADO))> NOW THEN
                       Factura_Electronica_pagos_suvtv(TX.ver_planta)
                      else
                      MEMO1.Lines.Add('CERTIFICADO DE FACTURA ELECTRONICA VENCIDO!!!!');

                END;   }


               MEMO1.Clear;
               MEMO1.Lines.Add('PROCESO TERMINADO !!!!.');

              END;

            TX.Cerrar_seccion;

         END else
             MEMO1.Lines.Add('SERVIDOR SUVTV DISPONIBLE: NO');






  END ELSE BEGIN
    MEMO1.Lines.Add('CONEXION A SUVTV: '+TX.ver_respuestamensajeservidor);
  END;





end;

procedure TForm1.Timer3Timer(Sender: TObject);
VAR TXT:txml_caba;
begin

SELF.Timer3.Enabled:=FALSE;
TXT:=txml_caba.Create;
if TXT.Control_conexion_TestOfBD('', '', '' ,false)=true then
    CONEXION_OK:=TRUE
    ELSE
    BEGIN
    CONEXION_OK:=FALSE;
    TXT.PARAR_SERVICIO_FACTURACION_AFIP;

      Form1.EnviarMensaje_ERROR_base('martin.bien@applus.com',inttostr(TXT.ver_PLANTA));
      Form1.EnviarMensaje_ERROR_base('lucas.suarez@applus.com',inttostr(TXT.ver_PLANTA));
    END;

    TXT.CargarINI;


IF TRIM(TXT.ESSERVIDOR)='S' THEN
ES_SERVIDOR:=true
ELSE
ES_SERVIDOR:=FALSE;

 if TRIM(TXT.VER_HABILITADO_FACTURA)='S' THEN
     BEGIN
     LABEL4.Caption:='SERVICIO DE FACTURA ELECTRONICA ONLINE';
     LABEL4.Font.Color:=CLGREEN;
     APPLICATION.ProcessMessages;
     END
     ELSE
     BEGIN
     LABEL4.Caption:='SERVICIO DE FACTURA ELECTRONICA OFFLINE';
     LABEL4.Font.Color:=CLRED;
     APPLICATION.ProcessMessages;
     END;


SELF.Timer3.Enabled:=TRUE;


  TXT.Free;
end;

procedure TForm1.Button7Click(Sender: TObject);
var  aq1,aqupdate:tsqlquery;  codcliente,turnoid:longint;

NRODOC,
NOMBRECLIENTE ,
APELLIDOCLIENTE ,
domicilio_calle ,
domicilio_numero,
domicilio_departamento,
domicilio_localidad,
domicilio_provincia ,
domicilio_codigoPostal,GENERO,datosPersonalesTurno_tipoDocumento,tipofact,datosFacturacion_condicionIva:string;
TMP_TITULAR_CUIT,TMP_TITULAR_RAZONSOCIAL,TMP_TITULAR_NOMBRE,TMP_TITULAR_APELLIDO:string;


begin
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);



 aq1:=tsqlquery.create(nil);
aq1.SQLConnection := MyBD;
aq1.sql.add('select turnoid,titulargenero,ttulartipodocumento,titularnrodocumento,titularnombre,dfdepartamento, '+
' titularapellido,cuittitular,titularrazonsocial,dfiva,dfcalle,dfnumerocalle,dflocalidad,dfprovincia,dfcodigopostal from tdatosturno  '+
' where codclien=0 and to_char(fecharegistro,''dd/mm/yyyy'')=to_char(sysdate,''dd/mm/yyyy'') and turnoid<>0');

aq1.ExecSQL;
aq1.open;
while not aq1.Eof do
begin

                  turnoid:=aq1.fieldbyname('turnoid').asinteger;
                  if turnoid<>0 then
                  begin
                  GENERO:=TRIM(aq1.fieldbyname('titulargenero').asstring);
                  datosPersonalesTurno_tipoDocumento:=TRIM(aq1.fieldbyname('ttulartipodocumento').asstring);
                  TMP_TITULAR_CUIT:=TRIM(aq1.fieldbyname('cuittitular').asstring);
                  TMP_TITULAR_RAZONSOCIAL:=TRIM(aq1.fieldbyname('titularrazonsocial').asstring);
                  TMP_TITULAR_NOMBRE:=TRIM(aq1.fieldbyname('titularnombre').asstring);
                  TMP_TITULAR_APELLIDO:=TRIM(aq1.fieldbyname('titularapellido').asstring);
                  datosFacturacion_condicionIva:=TRIM(aq1.fieldbyname('dfiva').asstring);
                  domicilio_codigoPostal:=TRIM(aq1.fieldbyname('dfcodigopostal').asstring);
                  domicilio_calle:=TRIM(aq1.fieldbyname('dfcalle').asstring);
                  domicilio_numero:=TRIM(aq1.fieldbyname('dfnumerocalle').asstring);
                  domicilio_departamento:=TRIM(aq1.fieldbyname('dfdepartamento').asstring);
                  domicilio_localidad:=TRIM(aq1.fieldbyname('dflocalidad').asstring);
                  domicilio_provincia:=TRIM(aq1.fieldbyname('dfprovincia').asstring);


                   IF TRIM(datosPersonalesTurno_tipoDocumento)='9' THEN
                    BEGIN
                      IF (TRIM(TMP_TITULAR_CUIT)<>'') and (TRIM(TMP_TITULAR_CUIT)<>'0') THEN
                         NRODOC:=TRIM(TMP_TITULAR_CUIT)
                         ELSE
                         NRODOC:=TRIM(aq1.fieldbyname('titularnrodocumento').asstring);

                    END else
                    NRODOC:=TRIM(aq1.fieldbyname('titularnrodocumento').asstring);


              IF  (TRIM(datosPersonalesTurno_tipoDocumento)='0') AND (TRIM(GENERO)='PJ') THEN
                   NRODOC:=TRIM(TMP_TITULAR_CUIT);




                     IF (TRIM(TMP_TITULAR_RAZONSOCIAL)<>'') and (TRIM(TMP_TITULAR_RAZONSOCIAL)<>'0') THEN
                     BEGIN
                       NOMBRECLIENTE:=TRIM(TMP_TITULAR_RAZONSOCIAL);
                       APELLIDOCLIENTE:='.';
                     END  ELSE
                     BEGIN
                       NOMBRECLIENTE:=TRIM(TMP_TITULAR_NOMBRE);
                       APELLIDOCLIENTE:=TRIM(TMP_TITULAR_APELLIDO);
                    END;


                     IF TRIM(NOMBRECLIENTE)='' THEN
                        NOMBRECLIENTE:='.';

                     IF TRIM(APELLIDOCLIENTE)='' THEN
                        APELLIDOCLIENTE:='.';


                        if (trim(datosFacturacion_condicionIva)='R') then
                            tipofact:='A'
                            else
                            tipofact:='B';


                       IF TRIM(domicilio_codigoPostal)='' THEN
                               domicilio_codigoPostal:='1000';


   try

 codcliente:=tx.Devuelve_codclienV2(NRODOC,
                                     NOMBRECLIENTE ,
                                     APELLIDOCLIENTE ,
                                     domicilio_calle ,
                                     domicilio_numero,
                                     domicilio_departamento,
                                     domicilio_localidad,
                                     domicilio_provincia ,
                                     domicilio_codigoPostal,GENERO,datosPersonalesTurno_tipoDocumento,tipofact,datosFacturacion_condicionIva);


  except

  end;


          if codcliente > 0 then
          begin
            MyBD.StartTransaction(TD);
              TRY

                aqupdate:=tsqlquery.create(nil);
                aqupdate.SQLConnection := MyBD;
                aqupdate.sql.add('update tdatosturno set codclien='+inttostr(codcliente)+'  where turnoid='+inttostr(turnoid));
                aqupdate.ExecSQL;
                MYBD.Commit(TD);

                  EXCEPT
                    MyBD.Rollback(TD);

                  END ;
            aqupdate.Close;
            aqupdate.Free;
          end;
    end;

aq1.Next;

end;

aq1.Close;
aq1.Free;

mybd.Close;
  tx.Free;
end;

procedure TForm1.ARREGLA_TURNOS_CLIENTES_CEROS_fecharegistro;
var  aq1,aqupdate:tsqlquery;  codcliente,turnoid:longint;

NRODOC,
NOMBRECLIENTE ,
APELLIDOCLIENTE ,
domicilio_calle ,
domicilio_numero,
domicilio_departamento,
domicilio_localidad,
domicilio_provincia ,
domicilio_codigoPostal,GENERO,datosPersonalesTurno_tipoDocumento,tipofact,datosFacturacion_condicionIva:string;
TMP_TITULAR_CUIT,TMP_TITULAR_RAZONSOCIAL,TMP_TITULAR_NOMBRE,TMP_TITULAR_APELLIDO:string;


begin
 aq1:=tsqlquery.create(nil);
aq1.SQLConnection := MyBD;
aq1.sql.add('select turnoid,titulargenero,ttulartipodocumento,titularnrodocumento,titularnombre,dfdepartamento, '+
' titularapellido,cuittitular,titularrazonsocial,dfiva,dfcalle,dfnumerocalle,dflocalidad,dfprovincia,dfcodigopostal from tdatosturno  '+
' where codclien=0 and to_char(fecharegistro,''dd/mm/yyyy'')=to_char(sysdate,''dd/mm/yyyy'') and turnoid<>0');

aq1.ExecSQL;
aq1.open;
while not aq1.Eof do
begin

                  turnoid:=aq1.fieldbyname('turnoid').asinteger;
                  if turnoid<>0 then
                  begin
                  GENERO:=TRIM(aq1.fieldbyname('titulargenero').asstring);
                  datosPersonalesTurno_tipoDocumento:=TRIM(aq1.fieldbyname('ttulartipodocumento').asstring);
                  TMP_TITULAR_CUIT:=TRIM(aq1.fieldbyname('cuittitular').asstring);
                  TMP_TITULAR_RAZONSOCIAL:=TRIM(aq1.fieldbyname('titularrazonsocial').asstring);
                  TMP_TITULAR_NOMBRE:=TRIM(aq1.fieldbyname('titularnombre').asstring);
                  TMP_TITULAR_APELLIDO:=TRIM(aq1.fieldbyname('titularapellido').asstring);
                  datosFacturacion_condicionIva:=TRIM(aq1.fieldbyname('dfiva').asstring);
                  domicilio_codigoPostal:=TRIM(aq1.fieldbyname('dfcodigopostal').asstring);
                  domicilio_calle:=TRIM(aq1.fieldbyname('dfcalle').asstring);
                  domicilio_numero:=TRIM(aq1.fieldbyname('dfnumerocalle').asstring);
                  domicilio_departamento:=TRIM(aq1.fieldbyname('dfdepartamento').asstring);
                  domicilio_localidad:=TRIM(aq1.fieldbyname('dflocalidad').asstring);
                  domicilio_provincia:=TRIM(aq1.fieldbyname('dfprovincia').asstring);


                   IF TRIM(datosPersonalesTurno_tipoDocumento)='9' THEN
                    BEGIN
                      IF (TRIM(TMP_TITULAR_CUIT)<>'') and (TRIM(TMP_TITULAR_CUIT)<>'0') THEN
                         NRODOC:=TRIM(TMP_TITULAR_CUIT)
                         ELSE
                         NRODOC:=TRIM(aq1.fieldbyname('titularnrodocumento').asstring);

                    END else
                    NRODOC:=TRIM(aq1.fieldbyname('titularnrodocumento').asstring);


              IF  (TRIM(datosPersonalesTurno_tipoDocumento)='0') AND (TRIM(GENERO)='PJ') THEN
                   NRODOC:=TRIM(TMP_TITULAR_CUIT);




                     IF (TRIM(TMP_TITULAR_RAZONSOCIAL)<>'') and (TRIM(TMP_TITULAR_RAZONSOCIAL)<>'0') THEN
                     BEGIN
                       NOMBRECLIENTE:=TRIM(TMP_TITULAR_RAZONSOCIAL);
                       APELLIDOCLIENTE:='.';
                     END  ELSE
                     BEGIN
                       NOMBRECLIENTE:=TRIM(TMP_TITULAR_NOMBRE);
                       APELLIDOCLIENTE:=TRIM(TMP_TITULAR_APELLIDO);
                    END;


                     IF TRIM(NOMBRECLIENTE)='' THEN
                        NOMBRECLIENTE:='.';

                     IF TRIM(APELLIDOCLIENTE)='' THEN
                        APELLIDOCLIENTE:='.';


                        if (trim(datosFacturacion_condicionIva)='R') then
                            tipofact:='A'
                            else
                            tipofact:='B';


                       IF TRIM(domicilio_codigoPostal)='' THEN
                               domicilio_codigoPostal:='1000';


   try

 codcliente:=tx.Devuelve_codclienV2(NRODOC,
                                     NOMBRECLIENTE ,
                                     APELLIDOCLIENTE ,
                                     domicilio_calle ,
                                     domicilio_numero,
                                     domicilio_departamento,
                                     domicilio_localidad,
                                     domicilio_provincia ,
                                     domicilio_codigoPostal,GENERO,datosPersonalesTurno_tipoDocumento,tipofact,datosFacturacion_condicionIva);


  except

  end;


          if codcliente > 0 then
          begin
            MyBD.StartTransaction(TD);
              TRY

                aqupdate:=tsqlquery.create(nil);
                aqupdate.SQLConnection := MyBD;
                aqupdate.sql.add('update tdatosturno set codclien='+inttostr(codcliente)+'  where turnoid='+inttostr(turnoid));
                aqupdate.ExecSQL;
                MYBD.Commit(TD);

                  EXCEPT
                    MyBD.Rollback(TD);

                  END ;
            aqupdate.Close;
            aqupdate.Free;
          end;
    end;

aq1.Next;

end;

aq1.Close;
aq1.Free;

end;




procedure TForm1.arregla_exentos_sin_idpago;
var  aq1,aqupdate:tsqlquery;  codcliente,turnoid:longint;

NRODOC,
NOMBRECLIENTE ,
APELLIDOCLIENTE ,
domicilio_calle ,
domicilio_numero,
domicilio_departamento,
domicilio_localidad,
domicilio_provincia ,
domicilio_codigoPostal,GENERO,datosPersonalesTurno_tipoDocumento,tipofact,datosFacturacion_condicionIva:string;
TMP_TITULAR_CUIT,TMP_TITULAR_RAZONSOCIAL,TMP_TITULAR_NOMBRE,TMP_TITULAR_APELLIDO:string;


begin
 aq1:=tsqlquery.create(nil);
aq1.SQLConnection := MyBD;
aq1.sql.add('select turnoid from tdatosturno where tipoturno=''EX'' and pagoidverificacion is null');

aq1.ExecSQL;
aq1.open;
while not aq1.Eof do
begin

       turnoid:=aq1.fieldbyname('turnoid').asinteger;

            MyBD.StartTransaction(TD);
              TRY

                aqupdate:=tsqlquery.create(nil);
                aqupdate.SQLConnection := MyBD;
                aqupdate.sql.add('update tdatosturno set pagoidverificacion=-1  where turnoid='+inttostr(turnoid));
                aqupdate.ExecSQL;
                MYBD.Commit(TD);

                  EXCEPT
                    MyBD.Rollback(TD);

                  END ;
            aqupdate.Close;
            aqupdate.Free;


aq1.Next;

end;

aq1.Close;
aq1.Free;

end;

procedure TForm1.PONE_FACUTURDO_EL_TURNO;
var  aq1,aqupdate:tsqlquery;  codcliente,turnoid:longint;
ARCHIVO,COMPRO:sTRING;
begin
aq1:=tsqlquery.create(nil);
aq1.SQLConnection := MyBD;
aq1.sql.add('select distinct TDET.NRO_COMPROBANTE, tdat.pagoidverificacion, tdat.facturado, TDAT.TURNOID, TDET.ARCHIVOENVIADO '+
            'from tdatosturno tdat inner join tdetallespago tdet  '+
            'on tdat.pagoidverificacion = tdet.pagoid  '+
            'where tdat.pagoidverificacion in (select idpago from tfacturas) '+
            'and tdat.facturado = ''N''  '+
            'and tdat.tipoinspe = ''P''   '+
            'and tdat.tipoturno <> ''EX'' '+
            'and tdat.fechalta >= to_date (''01/01/2017'',''dd/mm/yyyy'')  '+
            'and tdet.facturado = ''S'' ');

aq1.ExecSQL;
aq1.open;
while not aq1.Eof do
begin
turnoid:=aq1.Fields[3].AsInteger;
ARCHIVO:=TRIM(aq1.FIELDS[4].ASSTRING);
COMPRO:=TRIM(aq1.FIELDS[0].ASSTRING);

     aqupdate:=tsqlquery.create(nil);
     aqupdate.SQLConnection := MyBD;
     aqupdate.sql.add('UPDATE tdatosturno SET FACTURADO=''S'', NRO_COMPROBANTE='+#39+TRIM(COMPRO)+#39+', ARCHIVOENVIADO='+#39+TRIM(ARCHIVO)+#39+' WHERE TURNOID='+INTTOSTR(turnoid));

    MyBD.StartTransaction(TD);
    TRY
    aqupdate.ExecSQL;
     MYBD.Commit(TD);

     EXCEPT
     MyBD.Rollback(TD);

     END ;

aqupdate.Close;
aqupdatE.Free;


aq1.NEXT;
END;


end;


procedure TForm1.ARREGLA_TURNOS_CLIENTES_CEROS;
var  aq1,aqupdate:tsqlquery;  codcliente,turnoid:longint;

NRODOC,
NOMBRECLIENTE ,
APELLIDOCLIENTE ,
domicilio_calle ,
domicilio_numero,
domicilio_departamento,
domicilio_localidad,
domicilio_provincia ,
domicilio_codigoPostal,GENERO,datosPersonalesTurno_tipoDocumento,tipofact,datosFacturacion_condicionIva:string;
TMP_TITULAR_CUIT,TMP_TITULAR_RAZONSOCIAL,TMP_TITULAR_NOMBRE,TMP_TITULAR_APELLIDO:string;


begin
 aq1:=tsqlquery.create(nil);
aq1.SQLConnection := MyBD;
aq1.sql.add('select turnoid,titulargenero,ttulartipodocumento,titularnrodocumento,titularnombre,dfdepartamento, '+
' titularapellido,cuittitular,titularrazonsocial,dfiva,dfcalle,dfnumerocalle,dflocalidad,dfprovincia,dfcodigopostal from tdatosturno  '+
' where codclien=0 and to_char(fechaturno,''dd/mm/yyyy'')=to_char(sysdate,''dd/mm/yyyy'') and turnoid<>0');

aq1.ExecSQL;
aq1.open;
while not aq1.Eof do
begin

                  turnoid:=aq1.fieldbyname('turnoid').asinteger;
                  if turnoid<>0 then
                  begin
                  GENERO:=TRIM(aq1.fieldbyname('titulargenero').asstring);
                  datosPersonalesTurno_tipoDocumento:=TRIM(aq1.fieldbyname('ttulartipodocumento').asstring);
                  TMP_TITULAR_CUIT:=TRIM(aq1.fieldbyname('cuittitular').asstring);
                  TMP_TITULAR_RAZONSOCIAL:=TRIM(aq1.fieldbyname('titularrazonsocial').asstring);
                  TMP_TITULAR_NOMBRE:=TRIM(aq1.fieldbyname('titularnombre').asstring);
                  TMP_TITULAR_APELLIDO:=TRIM(aq1.fieldbyname('titularapellido').asstring);
                  datosFacturacion_condicionIva:=TRIM(aq1.fieldbyname('dfiva').asstring);
                  domicilio_codigoPostal:=TRIM(aq1.fieldbyname('dfcodigopostal').asstring);
                  domicilio_calle:=TRIM(aq1.fieldbyname('dfcalle').asstring);
                  domicilio_numero:=TRIM(aq1.fieldbyname('dfnumerocalle').asstring);
                  domicilio_departamento:=TRIM(aq1.fieldbyname('dfdepartamento').asstring);
                  domicilio_localidad:=TRIM(aq1.fieldbyname('dflocalidad').asstring);
                  domicilio_provincia:=TRIM(aq1.fieldbyname('dfprovincia').asstring);


                   IF TRIM(datosPersonalesTurno_tipoDocumento)='9' THEN
                    BEGIN
                      IF (TRIM(TMP_TITULAR_CUIT)<>'') and (TRIM(TMP_TITULAR_CUIT)<>'0') THEN
                         NRODOC:=TRIM(TMP_TITULAR_CUIT)
                         ELSE
                         NRODOC:=TRIM(aq1.fieldbyname('titularnrodocumento').asstring);

                    END else
                    NRODOC:=TRIM(aq1.fieldbyname('titularnrodocumento').asstring);


              IF  (TRIM(datosPersonalesTurno_tipoDocumento)='0') AND (TRIM(GENERO)='PJ') THEN
                   NRODOC:=TRIM(TMP_TITULAR_CUIT);




                     IF (TRIM(TMP_TITULAR_RAZONSOCIAL)<>'') and (TRIM(TMP_TITULAR_RAZONSOCIAL)<>'0') THEN
                     BEGIN
                       NOMBRECLIENTE:=TRIM(TMP_TITULAR_RAZONSOCIAL);
                       APELLIDOCLIENTE:='.';
                     END  ELSE
                     BEGIN
                       NOMBRECLIENTE:=TRIM(TMP_TITULAR_NOMBRE);
                       APELLIDOCLIENTE:=TRIM(TMP_TITULAR_APELLIDO);
                    END;


                     IF TRIM(NOMBRECLIENTE)='' THEN
                        NOMBRECLIENTE:='.';

                     IF TRIM(APELLIDOCLIENTE)='' THEN
                        APELLIDOCLIENTE:='.';


                        if (trim(datosFacturacion_condicionIva)='R') then
                            tipofact:='A'
                            else
                            tipofact:='B';


                       IF TRIM(domicilio_codigoPostal)='' THEN
                               domicilio_codigoPostal:='1000';


   try

 codcliente:=tx.Devuelve_codclienV2(NRODOC,
                                     NOMBRECLIENTE ,
                                     APELLIDOCLIENTE ,
                                     domicilio_calle ,
                                     domicilio_numero,
                                     domicilio_departamento,
                                     domicilio_localidad,
                                     domicilio_provincia ,
                                     domicilio_codigoPostal,GENERO,datosPersonalesTurno_tipoDocumento,tipofact,datosFacturacion_condicionIva);


  except

  end;


          if codcliente > 0 then
          begin
            MyBD.StartTransaction(TD);
              TRY

                aqupdate:=tsqlquery.create(nil);
                aqupdate.SQLConnection := MyBD;
                aqupdate.sql.add('update tdatosturno set codclien='+inttostr(codcliente)+'  where turnoid='+inttostr(turnoid));
                aqupdate.ExecSQL;
                MYBD.Commit(TD);

                  EXCEPT
                    MyBD.Rollback(TD);

                  END ;
            aqupdate.Close;
            aqupdate.Free;
          end;
    end;

aq1.Next;

end;

aq1.Close;
aq1.Free;

end;

procedure TForm1.BorrarArchivos(Ruta: string);
var
  SR: TSearchRec;
begin
  if FindFirst(Ruta + '*.xml', $23 , SR)= 0 then  //$23 , SR
   repeat
     DeleteFile(Ruta+'\'+SR.Name);
   until FindNext(SR) <> 0;

   if FindFirst(Ruta + '*.txt', $23 , SR)= 0 then  //$23 , SR
   repeat
     DeleteFile(Ruta+'\'+SR.Name);
   until FindNext(SR) <> 0;

end;
procedure TForm1.BitBtn17Click(Sender: TObject);
var c:string;
begin
memo1.Lines.Add('LIMPIANDO DIRECTORIO...');
c:=ExtractFilePath(Application.ExeName);
BorrarArchivos(c);
memo1.Lines.Add('PROCESO DE LIMPIEZA TERMONADO');
end;

procedure TForm1.BitBtn18Click(Sender: TObject);
BEGIN
FA:=tfacturae.CREATE;
FA.LEER_PARAMETROS;
memo1.Lines.Add('CONECTANDO CON AFIP...');
application.ProcessMessages;

if fa.Autenticar(trim(fa.MODO_FAE),trim(fa.carpeta),trim(fa.CUIT_EMPRESA))=false then
 begin
 TIENE_CONEXION_ELECTRONICA:=FALSE;
    memo1.Lines.Add('FACTURA ELECTRONICA: ERROR DE AUTENTICACION.');
    TX.TRAZAS('FACTURA ELECTRONICA: ERROR DE AUTENTICACION.');

    application.ProcessMessages;

 end ELSE
 BEGIN
 fA.Control_servidores(FA.Token,FA.Sign,FA.MODO_FAE,FA.CUIT_EMPRESA);

    IF TRIM(FA.estado_servidor)='OK' THEN
     BEGIN
       MEMO1.Lines.Add('ESTADO SERVIDOR AFIP: OK');
     END ELSE
     BEGIN
     MEMO1.Lines.Add('ESTADO SERVIDOR AFIP: NO DISPONIBLE');
     TX.TRAZAS('ESTADO SERVIDOR AFIP: NO DISPONIBLE.');

     END;

    application.ProcessMessages;


   IF TRIM(FA.Estado_autentica)='OK' THEN
    BEGIN
    MEMO1.Lines.Add('ESTADO AUTENTICACION AFIP: OK');
    END ELSE
    BEGIN
      MEMO1.Lines.Add('ESTADO AUTENTICACION AFIP: NO DISPONIBLE');
      TX.TRAZAS('ESTADO AUTENTICACION AFIP: NO DISPONIBLE.');
    END;
     application.ProcessMessages;
      

   IF TRIM(FA.estado_bd)='OK' THEN
    BEGIN
     MEMO1.Lines.Add('ESTADO BASE DE DATOS AFIP: OK');
    END ELSE
   BEGIN
     MEMO1.Lines.Add('ESTADO BASE DE DATOS AFIP: NO DISPONIBLE');
     TX.TRAZAS('ESTADO BASE DE DATOS AFIP: NO DISPONIBLE.');
   END;

    application.ProcessMessages;



    IF   (TRIM(FA.estado_bd)='OK')  AND (TRIM(FA.Estado_autentica)='OK')  AND (TRIM(FA.estado_servidor)='OK') THEN
     BEGIN
        TIENE_CONEXION_ELECTRONICA:=TRUE;
        MEMO1.Lines.Add('PROCESO DE FACTURA ELECTRONICA: OK');
        application.ProcessMessages;

      END      ELSE
        BEGIN

          TIENE_CONEXION_ELECTRONICA:=FALSE;
          MEMO1.Lines.Add('PROCESO DE FACTURA ELECTRONICA: NO DISPONIBLE');
          TX.TRAZAS('PROCESO DE FACTURA ELECTRONICA: NO DISPONIBLe.');
          application.ProcessMessages;

        END;


END;





       IF TIENE_CONEXION_ELECTRONICA=TRUE THEN
         BEGIN
         MEMO1.Lines.Add('CONSULTANDO PROXIMOS NRO...');
        application.ProcessMessages;

          FA.CONSULTA_COMPROBANRTES_APROBADOS('3','24258','6');


         END;

  


end;

procedure TForm1.BitBtn19Click(Sender: TObject);
var letra,A,nro,tipo,sqql:string;
aqQmt,aqqcantidad:tsqlquery;
cantidad,jj:longint;   total:longint;
begin
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);



FA:=tfacturae.CREATE;
FA.LEER_PARAMETROS;

aqqcantidad:=tsqlquery.Create(nil);


sqql:='Select count(*) from TDETALLESPAGO  '+
               '  where   Facturado = ''S''  AND CAE IS NOT NULL AND APROBADA=''SI'' '+
               ' and ARCHIVOENVIADO IS NULL ';

aqqcantidad:=tsqlquery.create(nil);
aqqcantidad.SQLConnection := MyBD;
aqqcantidad.sql.add(sqql);
aqqcantidad.ExecSQL;
aqqcantidad.open;
cantidad:=aqqcantidad.Fields[0].asinteger;
aqqcantidad.close;
aqqcantidad.free;
total:=0;
if cantidad >0 then
   begin
   total:=cantidad div 50;
   end;
if total > 0 then
begin
  for jj:=1 to total do
   begin
   SELF.GENERA_TODOS_PDF_FALTANTE;
   sleep(10000);
   end;
end;
 sleep(10000);
 SELF.GENERA_TODOS_PDF_FALTANTE;
fa.free;

 memo1.Lines.Add('GENERACION DE PDF TERMINADO...');
 mybd.Close;
  tx.Free;
 APPLICATION.ProcessMessages;

end;

procedure TForm1.Button9Click(Sender: TObject);
VAR C:STRING;
begin
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);
MEMO1.Clear;
memo1.Lines.Add('INICIOS DE SERVICIOS COMPLETOS....');
memo1.Lines.Add('SERVICIO 18:30');
APPLICATION.ProcessMessages;
sleep(1000);
INICIAR_NOVEDAD_1833;
arregla_cliente_cero_con_pagos;
PROCEDIMIENTOS_XML_PAGOS_INDIVIDUAL_1830;
PROCEDIMIENTOS_XML_PAGOS_flota_1830;
tx.CONFIGURAR;
SERVICIO_FACTURA_ELECTRONICA;
MEMO1.Lines.Add('GENERANDO PDF...');
GENERA_TODOS_PDF_FALTANTE;
MEMO1.Lines.Add('ESPERANDO CONEXION...');
memo1.Lines.Add('INFORMANDO TIPO 5.... ');
APPLICATION.ProcessMessages;
sleep(1000);
tx.INFORMAR_TODOS_LOS_TIPO_5;
serivicio_de_reinformar_facturas_a_suvtv;
memo1.Lines.Add('LIMPIANDO DIRECTORIO...');
c:=ExtractFilePath(Application.ExeName);
BorrarArchivos(c);
memo1.Lines.Add('PROCESO DE LIMPIEZA TERMINADO');




  memo1.Lines.Add('PROCESO COMPLETO TERMINAD !!!!');
 mybd.Close;
  tx.Free; 






















end;

procedure TForm1.Button12Click(Sender: TObject);
//var e:TePagos;
begin
{memo1.Lines.Clear;
memo1.Lines.Add('Obteniendo token de Epagos...');
application.ProcessMessages;
e:=TePagos.Create;
e.obtener_token;
memo1.Lines.Clear;
memo1.Lines.Add('Respuesta: ('+e.ver_id_respuesta+') '+e.ver_respuesta);
 if trim(e.ver_id_respuesta)='01001' then
    memo1.Lines.Add('Token: '+e.ver_token);


e.obtener_entidades;
e.obtener_pago;
e.free;

   }
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
 tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);
  INFORMAR_INSPECCION_DEL_DIA;
   memo1.Lines.Add('LIMPIANDO DIRECTORIO...');

memo1.Lines.Add('PROCESO DE LIMPIEZA TERMINADO');
mybd.Close;
tx.free;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
application.Terminate;
end;

procedure TForm1.BitBtn21Click(Sender: TObject);
var mdate,mdate1:tdatetime;
FECHADESDE,FECHAHASTA,C:string;
begin
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);

 memo1.Lines.Add('INSPECCIONES FINALIZADAS...');
 APPLICATION.ProcessMessages;

INFORMAR_INSPECCION_SIN_INFORMAR(datetostr(datetimepicker3.DateTime));

 memo1.Lines.Add('LIMPIANDO DIRECTORIO...');
  c:=ExtractFilePath(Application.ExeName);
  BorrarArchivos(c);
  memo1.Lines.Add('PROCESO DE LIMPIEZA TERMINADO');
   APPLICATION.ProcessMessages;
   memo1.Lines.Add('LIMPIANDO DIRECTORIO...');
c:=ExtractFilePath(Application.ExeName);
BorrarArchivos(c);
memo1.Lines.Add('PROCESO DE LIMPIEZA TERMINADO');

INFORMAR_INSPECCION_SIN_INFORMAR_HISTORIAL(datetostr(datetimepicker3.DateTime));


 memo1.Lines.Add('LIMPIANDO DIRECTORIO...');
  c:=ExtractFilePath(Application.ExeName);
  BorrarArchivos(c);
  memo1.Lines.Add('PROCESO DE LIMPIEZA TERMINADO');
   APPLICATION.ProcessMessages;
   memo1.Lines.Add('LIMPIANDO DIRECTORIO...');
c:=ExtractFilePath(Application.ExeName);
BorrarArchivos(c);
memo1.Lines.Add('PROCESO DE LIMPIEZA TERMINADO');

memo1.Lines.Add('INSPECCIONES AUSENTES...');
 APPLICATION.ProcessMessages;
 self.INFORMAR_INSPECCION_COMO_AUCENTES_TODOSL(datetostr(datetimepicker3.DateTime));


 memo1.Lines.Add('LIMPIANDO DIRECTORIO...');
  c:=ExtractFilePath(Application.ExeName);
  BorrarArchivos(c);
  memo1.Lines.Add('PROCESO DE LIMPIEZA TERMINADO');
   APPLICATION.ProcessMessages;
   memo1.Lines.Add('LIMPIANDO DIRECTORIO...');
c:=ExtractFilePath(Application.ExeName);
BorrarArchivos(c);
memo1.Lines.Add('PROCESO DE LIMPIEZA TERMINADO');
  memo1.Lines.Add('PROCESO TERMINADO !!!');
 mybd.Close;
TX.FREE;

end;

procedure TForm1.BitBtn22Click(Sender: TObject);
begin
tx:=txml_caba.Create;
tX.TestOfBD('', '', '' ,false);


self.INICIAR_DESCARGA_DIA_fecha(datetostr(self.DateTimePicker3.DateTime));
mybd.Close;
tx.Free;
end;

end.

