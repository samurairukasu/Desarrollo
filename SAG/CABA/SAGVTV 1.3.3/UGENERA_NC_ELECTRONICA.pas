unit UGENERA_NC_ELECTRONICA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask,SqlExpr,globals,WSFEV1,Exportar2PDF,UdiseniofacturaBelectronica;

type
  TGENERA_NC_ELECTRONICA = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    SpeedButton1: TSpeedButton;
    Button1: TButton;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FA:tfacturae;
    function guarda_nc(CODFACTU,NUMERO:LONGINT;NCAE,FEV:sTRING;punto_vta:longint):boolean;
    FUNCTION ARMAR_NUMERO_FACTURA(NRO_FACT:STRING):STRING;
    function generar_pdf(nro_comprobante,cae,fechavence,gravado,iva21,total,TIPOCOMPROBANTE,PV:string;idturno:longint;letra,patente_para_factura:string):STRING;
    function generar_pdf_B(nro_comprobante,cae,fechavence,gravado,iva21,total,TIPOCOMPROBANTE,PV:string;idturno:longint;letra,patente_para_factura:string):STRING;
    FUNCTION DIGITO_VERIFICADOR_FACTURA(CODIGO_BARRA:STRING):STRING;
  public
    { Public declarations }
  end;

var
  GENERA_NC_ELECTRONICA: TGENERA_NC_ELECTRONICA;

implementation

uses Unitfrmdiseniofactelectronica;

{$R *.dfm}
 function TGENERA_NC_ELECTRONICA.guarda_nc(CODFACTU,NUMERO:LONGINT;NCAE,FEV:sTRING;punto_vta:longint):boolean;
 var aqQm,aqQmf,aqQmfac:tsqlquery;
 impresa,tipo:string;
 secuenciador:longint;
 begin
 try



 impresa:='S';


  aqQm:=tsqlquery.create(nil);
  aqQm.SQLConnection := MyBD;
  aqQm.CLOSE;
  aqQm.SQL.CLEAR;
  aqQm.sql.add('select sq_tcontrafact_codcofac.nextval from dual');
  aqQm.ExecSQL;
  aqqm.Open;
  secuenciador:=aqqm.Fields[0].asinteger;

  aqqm.Close;
  aqqm.Free;



  aqQm:=tsqlquery.create(nil);
  aqQm.SQLConnection := MyBD;
  aqQm.CLOSE;
  aqQm.SQL.CLEAR;
  aqQm.sql.add('insert into tcontrafact (codcofac,impresa,fechalta,numfactu,CAE,FECHAVENCE) '+
  ' values ('+inttostr(secuenciador)+','+#39+TRIM(impresa)+#39+',SYSDATE,'+INTTOSTR(NUMERO)+','+#39+TRIM(NCAE)+#39+','+#39+TRIM(FEV)+#39+')');
  aqQm.ExecSQL;



  aqQmf:=tsqlquery.create(nil);
  aqQmf.SQLConnection := MyBD;
  aqQmf.CLOSE;
  aqQmf.SQL.CLEAR;
  aqQmf.sql.add('update tfacturas set codcofac='+inttostr(secuenciador)+'  where codfactu='+inttostr(CODFACTU));
  aqQmf.ExecSQL;




  tipo:='N';
  aqQmfac:=tsqlquery.create(nil);
  aqQmfac.SQLConnection := MyBD;
  aqQmfac.CLOSE;
  aqQmfac.SQL.CLEAR;
  aqQmfac.sql.add('insert into tfact_adicion (codfact,tipofac,ptovent,idusuari) '+
  ' values ('+inttostr(CODFACTU)+','+#39+TRIM(tipo)+#39+','+INTTOSTR(punto_vta)+','+inttostr(globals.ID_USUARIO_LOGEO_SAG)+')');
  aqQmfac.ExecSQL;



 except



 end;

  aqqm.close;
  aqqm.Free;

  aqqmf.close;
  aqqmf.Free;


    aqQmfac.close;
  aqQmfac.Free;

 end;

FUNCTION TGENERA_NC_ELECTRONICA.DIGITO_VERIFICADOR_FACTURA(CODIGO_BARRA:STRING):STRING;


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


function TGENERA_NC_ELECTRONICA.generar_pdf(nro_comprobante,cae,fechavence,gravado,iva21,total,TIPOCOMPROBANTE,PV:string;idturno:longint;letra,patente_para_factura:string):STRING;
var posi,I:longint;
dd,mm,aaaa,nombre_archivo:string;
CODIGO_BARRA,DIGITO,CUIT,nombre_archivo_original:STRING;
aqQm:tsqlquery;
 VAR Gpdf:TExportar2PDFSyn;
begin
  with Tfrmdiseniofactelectronica.Create(Nil) do
  begin
  aqQm:=tsqlquery.create(nil);
  aqQm.SQLConnection := MyBD;
  aqQm.CLOSE;
  aqQm.SQL.CLEAR;
  aqQm.sql.add('select dirconce from tvarios');
  aqQm.ExecSQL;
  aqQm.open;


  //QRLabel22.Caption:=trim(aqqm.fieldbyname('dirconce').asstring);
  QRLabel23.Caption:='Ciudad de Buenos Aires';

  aqqm.Close;
  aqqm.Free;

    aqQm:=tsqlquery.create(nil);
  aqQm.SQLConnection := MyBD;
  aqQm.CLOSE;
  aqQm.SQL.CLEAR;
  aqQm.sql.add('select DVDOMINO from tdatosturno WHERE TURNOID='+INTTOSTR(idturno));
  aqQm.ExecSQL;
  aqQm.open;
   patente_para_factura:=TRIM(AQQM.FIELDBYNAME('DVDOMINO').ASSTRING);


  
RxMemoryData1.Close;
RxMemoryData1.Open;
RxMemoryData1.Append;
RxMemoryData1servicio.Value:='VTV A VEHICULO '+TRIM(patente_para_factura);
RxMemoryData1cantidad.Value:='1.00';

if trim(letra)='A' then
begin
RxMemoryData1preciounit.Value:=trim(gravado);
RxMemoryData1iva.Value:=trim(iva21);
RxMemoryData1total.Value:=trim(total);

 QRLabel58.Caption:=gravado;
 QRLabel68.Caption:=iva21;
 QRLabel74.Caption:=total;

end;

if trim(letra)='B' then
begin
RxMemoryData1preciounit.Value:=trim(total);
RxMemoryData1iva.Value:='';
RxMemoryData1total.Value:=trim(total);

 QRLabel58.Caption:=total;
 QRLabel68.Caption:='0.00';
 QRLabel74.Caption:=total;

end;

 RxMemoryData1.Post;





  posi:=pos('-',trim(nro_comprobante));
 QRLabel7.Caption:=trim(copy(trim(nro_comprobante),0,posi-1));
 QRLabel8.Caption:=trim(copy(trim(nro_comprobante),posi+1,length(trim(nro_comprobante))));
 QRLabel10.Caption:=datetostr(date);
 QRLabel77.Caption:=cae;


 QRLabel2.Caption:=letra;
  if trim(TIPOCOMPROBANTE)='FAA' then
  BEGIN
  QRLabel4.Caption:='FACTURA';

 QRLabel3.Caption:='COD. 01';

 END;

  if trim(TIPOCOMPROBANTE)='FAB' then
  BEGIN
   QRLabel4.Caption:='FACTURA';

  QRLabel3.Caption:='COD. 06';
  END;

   if trim(TIPOCOMPROBANTE)='NCA' then
   BEGIN
   QRLabel4.Caption:='NOTA DE CREDITO';

   QRLabel3.Caption:='COD. 03';
   END;

  if trim(TIPOCOMPROBANTE)='NCB' then
   BEGIN
   QRLabel4.Caption:='NOTA DE CREDITO';

   QRLabel3.Caption:='COD. 08';
   END;

 dd:=copy(trim(fechavence),7,2);
 mm:=copy(trim(fechavence),5,2);
 aaaa:=copy(trim(fechavence),1,4);

  aqQm:=tsqlquery.create(nil);
  aqQm.SQLConnection := MyBD;
  aqQm.CLOSE;
  aqQm.SQL.CLEAR;
  aqQm.sql.add('select facturarazonsocial,cuitfactura,dfiva,dfnombre,dfapellido,dfnrodocumento,'+
               ' dftipodocumento,dfcalle, dfnumerocalle,dfpiso,DFDEPARTAMENTO,DFLOCALIDAD,DFPROVINCIA from tdatosturno WHERE TURNOID='+INTTOSTR(idturno));
  aqQm.ExecSQL;
  aqQm.open;

     IF TRIM(aqQm.FIELDBYNAME('facturarazonsocial').AsString)<>'' THEN
       QRLabel27.Caption:=TRIM(aqQm.FIELDBYNAME('facturarazonsocial').AsString)
       ELSE
         QRLabel27.Caption:=TRIM(aqQm.FIELDBYNAME('dfapellido').AsString)+' '+TRIM(aqQm.FIELDBYNAME('dfnombre').AsString);



  IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='1' THEN
  BEGIN
    QRLabel24.Caption:='DNI: ';
    QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('dfnrodocumento').AsString);

  END;

   IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='2' THEN
  BEGIN
    QRLabel24.Caption:='LE: ';
    QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('dfnrodocumento').AsString);

  END;

     IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='3' THEN
  BEGIN
    QRLabel24.Caption:='LC: ';
    QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('dfnrodocumento').AsString);

  END;

       IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='4' THEN
  BEGIN
    QRLabel24.Caption:='DNI EX.: ';
    QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('dfnrodocumento').AsString);

  END;

       IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='5' THEN
  BEGIN
    QRLabel24.Caption:='CED.EX.: ';
    QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('dfnrodocumento').AsString);

  END;

         IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='6' THEN
  BEGIN
    QRLabel24.Caption:='PASAP.: ';
    QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('dfnrodocumento').AsString);

  END;

          IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='7' THEN
  BEGIN
    QRLabel24.Caption:='';
    QRLabel26.Caption:='';

  END;


            IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='8' THEN
  BEGIN
    QRLabel24.Caption:='CED';
    QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('dfnrodocumento').AsString);

  END;


   IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='9' THEN
  BEGIN
    QRLabel24.Caption:='C.U.I.T.:';
    QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('cuitfactura').AsString);

  END;

           IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='10' THEN
  BEGIN
    QRLabel24.Caption:='CERT.NAC';
    QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('dfnrodocumento').AsString);

  END;
           IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='11' THEN
  BEGIN
    QRLabel24.Caption:='CERT';
    QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('dfnrodocumento').AsString);

  END;
           IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='12' THEN
  BEGIN
    QRLabel24.Caption:='CED.CIU';
    QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('dfnrodocumento').AsString);

  END;




   IF TRIM(aqQm.FIELDBYNAME('dfiva').AsString)='C' THEN
    QRLabel29.Caption:='Consumidor Final';


    IF TRIM(AQQm.FIELDBYNAME('dfiva').AsString)='R' THEN
    QRLabel29.Caption:='Responsable Inscripto';


    IF TRIM(AQQm.FIELDBYNAME('dfiva').AsString)='M' THEN
    QRLabel29.Caption:='Monotributo';

    IF TRIM(AQQm.FIELDBYNAME('dfiva').AsString)='E' THEN
    QRLabel29.Caption:='Exento';


   QRLabel31.Caption:=TRIM(aqQm.FIELDBYNAME('dfcalle').AsString)+
   ' '+TRIM(aqQm.FIELDBYNAME('dfnumerocalle').AsString)+' Piso: '+TRIM(aqQm.FIELDBYNAME('dfpiso').AsString)+
   ' Depto: '+TRIM(aqQm.FIELDBYNAME('DFDEPARTAMENTO').AsString)+' - '+TRIM(aqQm.FIELDBYNAME('DFLOCALIDAD').AsString)+
   ' - '+TRIM(aqQm.FIELDBYNAME('DFPROVINCIA').AsString);


   aqQm.Close;
   aqQm.Free;

  QRLabel33.Caption:='Contado';
 QRLabel78.Caption:=dd+'/'+mm+'/'+aaaa;


 {CODIGO BARRA}
 CUIT:='30714930490';

 CODIGO_BARRA:=CUIT+TIPOCOMPROBANTE+'000'+PV+CAE+FECHAVENCE+DIGITO;
 Barcode1D_Code1281.Barcode:=CODIGO_BARRA;


  QRLabel79.Caption:=CODIGO_BARRA;//+DIGITO_VERIFICADOR_FACTURA(CODIGO_BARRA);

 {FIN}
  QRLabel1.Caption:='ORIGINAL';
  nombre_archivo:='NC'+trim(letra)+''+TRIM(nro_comprobante)+'ORIGINAL.PDF';
  nombre_archivo_original:=nombre_archivo;
  QuickRep1.Prepare;


  Gpdf:=TExportar2PDFSyn.create;
  Gpdf.rutaPDF:=GetCurrentDir+ '\'+nombre_archivo;
  Gpdf.exportar2PDF(QuickRep1);
  Gpdf.Free;



  QRLabel1.Caption:='DUPLICADO';
  nombre_archivo:='NC'+trim(letra)+''+TRIM(nro_comprobante)+'DUPLICADO.PDF';

  QuickRep1.Prepare;


  Gpdf:=TExportar2PDFSyn.create;
  Gpdf.rutaPDF:=fa.DIRFAE+ '\'+nombre_archivo;
  Gpdf.exportar2PDF(QuickRep1);
  Gpdf.Free;



  QRLabel1.Caption:='TRIPLICADO';
  nombre_archivo:='NC'+trim(letra)+''+TRIM(nro_comprobante)+'TRIPLICADO.PDF';

  QuickRep1.Prepare;


  Gpdf:=TExportar2PDFSyn.create;
 // Gpdf.rutaPDF:=GetCurrentDir+ '\'+nombre_archivo;
   Gpdf.rutaPDF:=fa.DIRFAE+ '\'+nombre_archivo;
  Gpdf.exportar2PDF(QuickRep1);
  Gpdf.Free;


end;


generar_pdf:=fa.DIRFAE+ '\'+nombre_archivo_original;
end;

function TGENERA_NC_ELECTRONICA.generar_pdf_B(nro_comprobante,cae,fechavence,gravado,iva21,total,TIPOCOMPROBANTE,PV:string;idturno:longint;letra,patente_para_factura:string):STRING;
var posi,I:longint;
dd,mm,aaaa,nombre_archivo:string;
CODIGO_BARRA,DIGITO,CUIT,nombre_archivo_original:STRING;
aqQm:tsqlquery;
 VAR Gpdf:TExportar2PDFSyn;
begin
 with Tfacturabelectronica.Create(Nil) do
 begin
  aqQm:=tsqlquery.create(nil);
  aqQm.SQLConnection := MyBD;
  aqQm.CLOSE;
  aqQm.SQL.CLEAR;
  aqQm.sql.add('select dirconce from tvarios');
  aqQm.ExecSQL;
  aqQm.open;
  QRLabel22.Caption:=trim(aqqm.fieldbyname('dirconce').asstring);
  QRLabel23.Caption:='Ciudad de Buenos Aires';

  aqqm.Close;
  aqqm.Free;

    aqQm:=tsqlquery.create(nil);
  aqQm.SQLConnection := MyBD;
  aqQm.CLOSE;
  aqQm.SQL.CLEAR;
  aqQm.sql.add('select facturarazonsocial,cuitfactura,dfiva,dfnombre,dfapellido,dfnrodocumento,'+
               ' dftipodocumento,dfcalle, dfnumerocalle,dfpiso,DFDEPARTAMENTO,DFLOCALIDAD,DFPROVINCIA,dvdomino from tdatosturno WHERE TURNOID='+INTTOSTR(idturno));
  aqQm.ExecSQL;
  aqQm.open;

RxMemoryData1.Close;
RxMemoryData1.Open;
RxMemoryData1.Append;
RxMemoryData1servicio.Value:='VTV A VEHICULO '+TRIM(aqqm.fieldbyname('dvdomino').asstring);
RxMemoryData1cantidad.Value:='1.00';
 aqQm.close;
 aqQm.Free;
if trim(letra)='A' then
begin
RxMemoryData1preciounit.Value:=trim(gravado);
RxMemoryData1iva.Value:=trim(iva21);
RxMemoryData1total.Value:=trim(total);

 QRLabel58.Caption:=gravado;
 //facturabelectronica.QRLabel68.Caption:=iva21;
 QRLabel74.Caption:=total;

end;

if trim(letra)='B' then
begin
RxMemoryData1preciounit.Value:=trim(total);
RxMemoryData1iva.Value:='';
RxMemoryData1total.Value:=trim(total);

 QRLabel58.Caption:=total;
// facturabelectronica.QRLabel68.Caption:='0.00';
 QRLabel74.Caption:=total;

end;

 RxMemoryData1.Post;





  posi:=pos('-',trim(nro_comprobante));
 QRLabel7.Caption:=trim(copy(trim(nro_comprobante),0,posi-1));
 QRLabel8.Caption:=trim(copy(trim(nro_comprobante),posi+1,length(trim(nro_comprobante))));
 QRLabel10.Caption:=datetostr(date);
 QRLabel77.Caption:=cae;




  if trim(letra)='B' then
  QRLabel3.Caption:='COD. 08';

  QRLabel4.Caption:='NOTA DE CREDITO';

 dd:=copy(trim(fechavence),7,2);
 mm:=copy(trim(fechavence),5,2);
 aaaa:=copy(trim(fechavence),1,4);

  aqQm:=tsqlquery.create(nil);
  aqQm.SQLConnection := MyBD;
  aqQm.CLOSE;
  aqQm.SQL.CLEAR;
  aqQm.sql.add('select facturarazonsocial,cuitfactura,dfiva,dfnombre,dfapellido,dfnrodocumento,'+
               ' dftipodocumento,dfcalle, dfnumerocalle,dfpiso,DFDEPARTAMENTO,DFLOCALIDAD,DFPROVINCIA,dvdomino from tdatosturno WHERE TURNOID='+INTTOSTR(idturno));
  aqQm.ExecSQL;
  aqQm.open;

     IF TRIM(aqQm.FIELDBYNAME('facturarazonsocial').AsString)<>'' THEN
       QRLabel27.Caption:=TRIM(aqQm.FIELDBYNAME('facturarazonsocial').AsString)
       ELSE
         QRLabel27.Caption:=TRIM(aqQm.FIELDBYNAME('dfapellido').AsString)+' '+TRIM(aqQm.FIELDBYNAME('dfnombre').AsString);



  IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='1' THEN
  BEGIN
    QRLabel24.Caption:='DNI: ';
    QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('dfnrodocumento').AsString);

  END;

   IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='2' THEN
  BEGIN
    QRLabel24.Caption:='LE: ';
    QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('dfnrodocumento').AsString);

  END;

     IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='3' THEN
  BEGIN
    QRLabel24.Caption:='LC: ';
    QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('dfnrodocumento').AsString);

  END;

       IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='4' THEN
  BEGIN
    QRLabel24.Caption:='DNI EX.: ';
    QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('dfnrodocumento').AsString);

  END;

       IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='5' THEN
  BEGIN
    QRLabel24.Caption:='CED.EX.: ';
    QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('dfnrodocumento').AsString);

  END;

         IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='6' THEN
  BEGIN
    facturabelectronica.QRLabel24.Caption:='PASAP.: ';
    facturabelectronica.QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('dfnrodocumento').AsString);

  END;

          IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='7' THEN
  BEGIN
    QRLabel24.Caption:='';
    QRLabel26.Caption:='';

  END;


            IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='8' THEN
  BEGIN
    QRLabel24.Caption:='CED';
    QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('dfnrodocumento').AsString);

  END;


   IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='9' THEN
  BEGIN
    QRLabel24.Caption:='C.U.I.T.:';
    QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('cuitfactura').AsString);

  END;

           IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='10' THEN
  BEGIN
    QRLabel24.Caption:='CERT.NAC';
    QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('dfnrodocumento').AsString);

  END;
           IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='11' THEN
  BEGIN
    QRLabel24.Caption:='CERT';
    QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('dfnrodocumento').AsString);

  END;
           IF TRIM(aqQm.FIELDBYNAME('dftipodocumento').AsString)='12' THEN
  BEGIN
    QRLabel24.Caption:='CED.CIU';
    QRLabel26.Caption:=TRIM(aqQm.FIELDBYNAME('dfnrodocumento').AsString);

  END;




   IF TRIM(aqQm.FIELDBYNAME('dfiva').AsString)='C' THEN
    QRLabel29.Caption:='Consumidor Final';


    IF TRIM(AQQm.FIELDBYNAME('dfiva').AsString)='R' THEN
    QRLabel29.Caption:='Responsable Inscripto';


    IF TRIM(AQQm.FIELDBYNAME('dfiva').AsString)='M' THEN
    QRLabel29.Caption:='Monotributo';

    IF TRIM(AQQm.FIELDBYNAME('dfiva').AsString)='E' THEN
    QRLabel29.Caption:='Exento';


   QRLabel31.Caption:=TRIM(aqQm.FIELDBYNAME('dfcalle').AsString)+
   ' '+TRIM(aqQm.FIELDBYNAME('dfnumerocalle').AsString)+' Piso: '+TRIM(aqQm.FIELDBYNAME('dfpiso').AsString)+
   ' Depto: '+TRIM(aqQm.FIELDBYNAME('DFDEPARTAMENTO').AsString)+' - '+TRIM(aqQm.FIELDBYNAME('DFLOCALIDAD').AsString)+
   ' - '+TRIM(aqQm.FIELDBYNAME('DFPROVINCIA').AsString);


   aqQm.Close;
   aqQm.Free;

  QRLabel33.Caption:='Contado';
 QRLabel78.Caption:=dd+'/'+mm+'/'+aaaa;


 {CODIGO BARRA}
 CUIT:='30714930490';

 CODIGO_BARRA:=CUIT+TIPOCOMPROBANTE+'000'+PV+CAE+FECHAVENCE+DIGITO;
 Barcode1D_Code1281.Barcode:=CODIGO_BARRA;


  QRLabel79.Caption:=CODIGO_BARRA;//+DIGITO_VERIFICADOR_FACTURA(CODIGO_BARRA);

 {FIN}
  QRLabel1.Caption:='ORIGINAL';
  nombre_archivo:='NC'+trim(letra)+''+TRIM(nro_comprobante)+'ORIGINAL.PDF';
  nombre_archivo_original:=nombre_archivo;
  QuickRep1.Prepare;


  Gpdf:=TExportar2PDFSyn.create;
  Gpdf.rutaPDF:=fa.DIRFAE+ '\'+nombre_archivo;
  Gpdf.exportar2PDF(QuickRep1);
  Gpdf.Free;



  QRLabel1.Caption:='DUPLICADO';
  nombre_archivo:='NC'+trim(letra)+''+TRIM(nro_comprobante)+'DUPLICADO.PDF';

  QuickRep1.Prepare;


  Gpdf:=TExportar2PDFSyn.create;
  Gpdf.rutaPDF:=fa.DIRFAE+ '\'+nombre_archivo;
  Gpdf.exportar2PDF(QuickRep1);
  Gpdf.Free;



  QRLabel1.Caption:='TRIPLICADO';
  nombre_archivo:='NC'+trim(letra)+''+TRIM(nro_comprobante)+'TRIPLICADO.PDF';

  QuickRep1.Prepare;


  Gpdf:=TExportar2PDFSyn.create;
  Gpdf.rutaPDF:=fa.DIRFAE+ '\'+nombre_archivo;
  Gpdf.exportar2PDF(QuickRep1);
  Gpdf.Free;



  end;

generar_pdf_B:=fa.DIRFAE+ '\'+nombre_archivo_original;
end;



procedure TGENERA_NC_ELECTRONICA.BitBtn2Click(Sender: TObject);
begin
close;
end;


FUNCTION TGENERA_NC_ELECTRONICA.ARMAR_NUMERO_FACTURA(NRO_FACT:STRING):STRING;
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


procedure TGENERA_NC_ELECTRONICA.BitBtn1Click(Sender: TObject);
var nrofactu,pv:longint;
tipo:string;    aContexto:TSQLQuery;  I,POSI:LONGINT;
nombrecliente:string;  tipo_doc,tipo_cbte:LONGINT;
tipodocucliente,nro_doc1,nro_doc:string;
documento:string;  TIENE_CONEXION_ELECTRONICA:boolean;
codfactu,codclien:longint; tipfactu:string;ivainscr,imponeto:string;
//FA:tfacturae;
punto_vta:longint;
cbt_desde:string;
cbt_hasta:string;
para_Actualizar_numero:string;
para_Actualizar_compro:string;
imp_total:string;
iMPORTEVERIFICACION:string;
IMPORTE_SIN_IVA:real;
IMPORTE_IVA:real;
imp_tot_conc:string;
IMP_NETO:string;
IMP_IVA:string;
imp_trib:string;
imp_op_ex:string;
id_SERVICIO,CODVEHIC:longint;
 NRO_COMPROBANTE:STRING;
F1,letra:string;
F2:string;
F3:string;
FECHA:string;
fecha_cbte:string;
fecha_venc_pago:string;
fecha_serv_desde:string;
fecha_serv_hasta:string;
moneda_id :string;
moneda_ctz :string;
IMPORTE_PARA21_s:string;
IVA21,TIPOCOMPROBANTE:string;
 archivo,patente_para_factura:string;
TURNOID:longint;
 alista:TSQLQuery;
NUMEROnc:longint;
begin
if trim(edit1.Text)='' then
begin
     showmessage('Debe ingresar el Nro de Factura');
    exit;
end;


if pos('-',trim(edit1.Text)) = 0 then
begin
     showmessage('El formato es incorrecto.');
    exit;
end;

 if  length(edit1.Text) <> 13 then
begin
     showmessage('El formato es incorrecto.');
    exit;
end;





nrofactu:=strtoint(trim(copy(trim(edit1.text),6,length(edit1.Text))));
pv:=strtoint(trim(copy(trim(edit1.text),0,4)));

if self.RadioButton1.Checked=true then
BEGIN
    TIPOCOMPROBANTE:='NCA';
   tipo:='A';
   letra:='A';
END;

if self.RadioButton2.Checked=true then
  BEGIN
  TIPOCOMPROBANTE:='NCB';
   tipo:='B';
   letra:='B';
  END;



 {busca datos facturas}

 aContexto:=TSQLQuery.Create(nil);
  with aContexto do
   try
    SQLConnection:=mybd;
    sql.add('select codfactu,codclien,tipfactu,ivainscr,imponeto,fechalta, CODTURNO from tfacturas where tipfactu=:tipofactur and numfactu=:numero');
    ParamByName('tipofactur').Value:=tipo;
    ParamByName('numero').Value:=nrofactu;
    Open;

  {  IF ACONTEXTO.RecordCount > 0 THEN
    BEGIN

     Application.MessageBox( pchar('No se ha encontrado la factura nro '+trim(edit1.Text)),
      'Atenci�n', MB_ICONSTOP );
    EXIT;
      

    END;  }

     codfactu:=fields[0].asinteger;
     codclien:=fields[1].asinteger;
     tipfactu:=trim(fields[2].asstring);
     ivainscr:=trim(fields[3].asstring);
     imponeto:=trim(fields[4].asstring);
     TURNOID:=FIELDS[6].ASINTEGER;

      finally
         close;
         free;
      end;

     //TURNOS
       aContexto:=TSQLQuery.Create(nil);
  with aContexto do
   try
    SQLConnection:=mybd;
    sql.add('SELECT codfactu,codclien,tipfactu,ivainscr,imponeto,fechalta, CODTURNO  from TFACTURAS where codfactu=:codfactu');
    ParamByName('codfactu').Value:=codfactu;

    Open;

    {         Application.MessageBox( pchar('No se ha encontrado la factura nro '+trim(edit1.Text)),
  'Atenci�n', MB_ICONSTOP );
    EXIT;
      exit;}


     codfactu:=fields[0].asinteger;
     codclien:=fields[1].asinteger;
     tipfactu:=trim(fields[2].asstring);
     ivainscr:=trim(fields[3].asstring);
     imponeto:=trim(fields[4].asstring);

      finally
         close;
         free;
      end;
   ///


 {datos clientes}
  aContexto:=TSQLQuery.Create(nil);
  with aContexto do
   try
    SQLConnection:=mybd;
    sql.add('select nombre,apellid1, tipodocu, document from tclientes where codclien=:codcliente');
    ParamByName('codcliente').Value:=codclien;
    Open;
     nombrecliente:=trim(fields[0].asstring)+' '+trim(fields[1].asstring);
     tipodocucliente:=trim(fields[2].asstring);
     documento:=trim(fields[3].asstring);

      finally
         close;
         free;
      end;



      
 {VEHICULO}
  aContexto:=TSQLQuery.Create(nil);
  with aContexto do
   try
    SQLConnection:=mybd;
    sql.add('select CODVEHIC from TINSPECCION where CODFACTU=:CODFACTU');
    ParamByName('CODFACTU').Value:=codfactu;
    Open;
     CODVEHIC:=FIELDS[0].ASINTEGER;

      finally
         close;
         free;
      end;


 {--------------------}


  aContexto:=TSQLQuery.Create(nil);
  with aContexto do
   try
    SQLConnection:=mybd;
    sql.add('select dvdomino from tdatosturno where turnoid=:turnoid');
    ParamByName('turnoid').Value:=TURNOID;

    Open;


      patente_para_factura:=TRIM(FIELDS[0].ASSTRING);


      finally
         close;
         free;
      end;



  if Application.MessageBox( pchar('�Desea realizar la nota de credito de la factura: '+trim(edit1.Text)+' de '+nombrecliente+'   Vehiculo: '+patente_para_factura+' ?'), 'Guardando factura',
  MB_ICONQUESTION OR MB_YESNO ) = ID_YES then
  begin
        if trim(tipodocucliente)='DNI'  then   //dni
       begin

          tipo_doc:=96;
          nro_doc:=TRIM(documento);
       end;

            if trim(tipodocucliente)='CUIL'   then   //dni
       begin

          tipo_doc:=86;
          nro_doc:=TRIM(documento);
       end;

              if trim(tipodocucliente)='CDI'   then   //dni
       begin

          tipo_doc:=87;
          nro_doc:=TRIM(documento);
       end;


              if trim(tipodocucliente)='LE'   then   //dni
       begin

          tipo_doc:=89;
          nro_doc:=TRIM(documento);
       end;
              if trim(tipodocucliente)='LC'   then   //dni
       begin

          tipo_doc:=90;
          nro_doc:=TRIM(documento);
       end;




      if trim(tipodocucliente)='CUIT' then   //cuit
       begin
         tipo_doc:=80;
         POSI:=POS('-',TRIM(documento));
          IF POSI > 0 THEN
           BEGIN
            nro_doc:='';
            nro_doc1:=TRIM(documento);
              FOR I:=1 TO LENGTH(TRIM(nro_doc1)) DO
               BEGIN
                   IF TRIM(nro_doc1[I])<>'-' THEN
                      nro_doc:=nro_doc + TRIM(nro_doc1[I]);
                end;

           END else
             nro_doc:=TRIM(documento);

       end;



    FA:=tfacturae.CREATE;
    FA.LEER_PARAMETROS;
    if fa.Autenticar(trim(fa.MODO_FAE),trim(fa.carpeta),trim(fa.CUIT_EMPRESA))=false then
    begin
     Application.MessageBox( 'No se pudo autenticar con AFIP.',
  'Atenci�n', MB_ICONSTOP );
    EXIT;
    END;

      FA.Control_servidores(FA.Token,FA.Sign,FA.MODO_FAE,FA.CUIT_EMPRESA);

    IF TRIM(FA.estado_servidor)='OK' THEN
     BEGIN


     END;


   IF TRIM(FA.Estado_autentica)='OK' THEN
    BEGIN

    END;

   IF TRIM(FA.estado_bd)='OK' THEN
    BEGIN

    END;


   IF   (TRIM(FA.estado_bd)='OK')  AND (TRIM(FA.Estado_autentica)='OK')  AND (TRIM(FA.estado_servidor)='OK') THEN
     BEGIN
        TIENE_CONEXION_ELECTRONICA:=TRUE;


      END      ELSE
        BEGIN
          TIENE_CONEXION_ELECTRONICA:=FALSE;

           Application.MessageBox( 'PROCESO DE FACTURA ELECTRONICA: NO DISPONIBLE.',
  'Atenci�n', MB_ICONSTOP );
  exit;
        END;


if TIENE_CONEXION_ELECTRONICA=true then
   begin
    IF TRIM(tipo)='A' THEN
        tipo_cbte:=3;

    IF TRIM(tipo)='B' THEN
       tipo_cbte:=8;

    IF TRIM(tipo)='C' THEN
       tipo_cbte:=13;

IMPORTE_SIN_IVA:=0;
IMPORTE_IVA:=0;
 fecha:=datetostr(date);
 id_SERVICIO:=2;

punto_vta:=FA.PUNTOVENTAFAE;
cbt_desde:='0';
cbt_hasta:='0';
para_Actualizar_numero:='1';
para_Actualizar_compro:='1';

//IMPORTEVERIFICACION:='12.10';
imp_total:=trim(imponeto);//'12.10';


IMPORTEVERIFICACION:= StringReplace(TRIM(imponeto), '.', ',',
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
    fecha_serv_desde, fecha_serv_hasta,moneda_id, moneda_ctz,IMPORTE_PARA21_s,IVA21,fa.Token,fa.Sign,fa.CUIT_EMPRESA,fa.MODO_FAE,tipo,mybd,1) =true then
begin
NUMEROnc:=FA.ULTIMO;
NRO_COMPROBANTE:='000'+INTTOSTR(punto_vta)+'-'+ARMAR_NUMERO_FACTURA(INTTOSTR(FA.ULTIMO));

{guardo en la base la nc}

guarda_nc(codfactu,NUMEROnc,FA.cae,FA.fecha_vence,punto_vta);


if TRIM(TIPOCOMPROBANTE)='NCA' THEN
   archivo:=generar_pdf(NRO_COMPROBANTE,FA.cae,FA.fecha_vence,IMP_NETO,IVA21,imp_total,TIPOCOMPROBANTE,INTTOSTR(punto_vta),TURNOID,letra,patente_para_factura);

if TRIM(TIPOCOMPROBANTE)='NCB' THEN
    generar_pdf_B(NRO_COMPROBANTE,FA.cae,FA.fecha_vence,IMP_NETO,iva21,imp_total,TIPOCOMPROBANTE,INTTOSTR(punto_vta),TURNOID,letra,patente_para_factura);



     //      else
       //      archivo:=generar_pdf_B(NRO_COMPROBANTE,FA.cae,FA.fecha_vence,IMP_NETO,IVA21,imp_total,STIPOCOMPROBANTE,INTTOSTR(punto_vta),TURNOID,letra,patente_para_factura);




    showmessage(fa.OBSERVACIONES_CAE+' | NOTA CREDITO: '+NRO_COMPROBANTE+' CAE: '+trim(fa.cae)+' fecha venc: '+trim(fa.fecha_vence))
end else
begin
   showmessage(fa.OBSERVACIONES_CAE);
end;





     end;





  end;


end;

procedure TGENERA_NC_ELECTRONICA.SpeedButton1Click(Sender: TObject);
var TIENE_CONEXION_ELECTRONICA:boolean;
begin
TIENE_CONEXION_ELECTRONICA:=falsE;
 FA:=tfacturae.CREATE;
    FA.LEER_PARAMETROS;
    if fa.Autenticar(trim(fa.MODO_FAE),trim(fa.carpeta),trim(fa.CUIT_EMPRESA))=false then
    begin
     Application.MessageBox( 'No se pudo autenticar con AFIP.',
  'Atenci�n', MB_ICONSTOP );
    EXIT;
    END;

      FA.Control_servidores(FA.Token,FA.Sign,FA.MODO_FAE,FA.CUIT_EMPRESA);

    IF TRIM(FA.estado_servidor)='OK' THEN
     BEGIN


     END;


   IF TRIM(FA.Estado_autentica)='OK' THEN
    BEGIN

    END;

   IF TRIM(FA.estado_bd)='OK' THEN
    BEGIN

    END;


   IF   (TRIM(FA.estado_bd)='OK')  AND (TRIM(FA.Estado_autentica)='OK')  AND (TRIM(FA.estado_servidor)='OK') THEN
     BEGIN
        TIENE_CONEXION_ELECTRONICA:=TRUE;


      END      ELSE
        BEGIN
          TIENE_CONEXION_ELECTRONICA:=FALSE;

           Application.MessageBox( 'PROCESO DE FACTURA ELECTRONICA: NO DISPONIBLE.',
  'Atenci�n', MB_ICONSTOP );
  exit;
        END;


if TIENE_CONEXION_ELECTRONICA=true then
   begin

        FA.consultas_numeros(fa.modo_fae);

        showmessage('Pr�ximo Nro para pv 2 tipo A '+inttostr(fa.proxima_nca_2)+#13+
                    'Pr�ximo Nro para pv 2 tipo B '+inttostr(fa.proxima_ncb_2)+#13+
                    'Pr�ximo Nro para pv 3 tipo A '+inttostr(fa.proxima_nca_3)+#13+
                    'Pr�ximo Nro para pv 3 tipo B '+inttostr(fa.proxima_ncb_3));



    end;   


end;

procedure TGENERA_NC_ELECTRONICA.Button1Click(Sender: TObject);
var nrofactu,pv:longint;
tipo:string;    aContexto:TSQLQuery;  I,POSI:LONGINT;
nombrecliente:string;  tipo_doc,tipo_cbte:LONGINT;
tipodocucliente,nro_doc1,nro_doc:string;
documento:string;  TIENE_CONEXION_ELECTRONICA:boolean;
codfactu,codclien:longint; tipfactu:string;ivainscr,imponeto:string;
//FA:tfacturae;
punto_vta:longint;
cbt_desde:string;
cbt_hasta:string;
para_Actualizar_numero:string;
para_Actualizar_compro:string;
imp_total:string;
iMPORTEVERIFICACION:string;
IMPORTE_SIN_IVA:real;
IMPORTE_IVA:real;
imp_tot_conc:string;
IMP_NETO:string;
IMP_IVA:string;
imp_trib:string;
imp_op_ex:string;
id_SERVICIO,CODVEHIC:longint;
 NRO_COMPROBANTE:STRING;
F1,letra:string;
F2:string;
F3:string;
FECHA:string;
fecha_cbte:string;
fecha_venc_pago:string;
fecha_serv_desde:string;
fecha_serv_hasta:string;
moneda_id :string;
moneda_ctz :string;
IMPORTE_PARA21_s:string;
IVA21,TIPOCOMPROBANTE:string;
 archivo,patente_para_factura:string;
TURNOID:longint;
 alista,atfact_adicion:TSQLQuery;
NUMEROnc,acodfactu:longint;

begin
{if trim(edit1.Text)='' then
begin
     showmessage('Debe ingresar el Nro de Factura');
    exit;
end;


if pos('-',trim(edit1.Text)) = 0 then
begin
     showmessage('El formato es incorrecto.');
    exit;
end;

 if  length(edit1.Text) <> 13 then
begin
     showmessage('El formato es incorrecto.');
    exit;
end;   }


alista:=TSQLQuery.Create(nil);

    alista.SQLConnection:=mybd;
    alista.sql.add('select codfactu, nunfactu from nchacer where nunfactu >1145 order by nunfactu asc');
    alista.Open;

while not alista.Eof do
begin
 acodfactu:=alista.fieldbyname('codfactu').asinteger;
 nrofactu:=alista.fieldbyname('nunfactu').asinteger;


    atfact_adicion:=TSQLQuery.Create(nil);

    atfact_adicion.SQLConnection:=mybd;
    atfact_adicion.sql.add('select * from tfact_adicion where codfact='+inttostr(acodfactu)+' and tipofac=''N'' ');
    atfact_adicion.Open;
     if atfact_adicion.RecordCount = 0 then
     begin
        atfact_adicion.close;
        atfact_adicion.Free;



//pv:=strtoint(trim(copy(trim(edit1.text),0,4)));

if self.RadioButton1.Checked=true then
BEGIN
    TIPOCOMPROBANTE:='NCA';
   tipo:='A';
   letra:='A';
END;

if self.RadioButton2.Checked=true then
  BEGIN
  TIPOCOMPROBANTE:='NCB';
   tipo:='B';
   letra:='B';
  END;



 {busca datos facturas}

 aContexto:=TSQLQuery.Create(nil);
  with aContexto do
   try
    SQLConnection:=mybd;
    // sql.add('select codfactu,codclien,tipfactu,ivainscr,imponeto,fechalta, CODTURNO from tfacturas where tipfactu=:tipofactur and numfactu=:numero and codfactu=:acodfactu');
    sql.add('select codfactu,codclien,tipfactu,ivainscr,imponeto,fechalta, CODTURNO from tfacturas where  codfactu=:acodfactu');
    //ParamByName('tipofactur').Value:=tipo;
   // ParamByName('numero').Value:=nrofactu;
    ParamByName('acodfactu').Value:=acodfactu;


    Open;

    {         Application.MessageBox( pchar('No se ha encontrado la factura nro '+trim(edit1.Text)),
  'Atenci�n', MB_ICONSTOP );
    EXIT;
      exit;}


     codfactu:=fields[0].asinteger;
     codclien:=fields[1].asinteger;
     tipfactu:=trim(fields[2].asstring);
     ivainscr:=trim(fields[3].asstring);
     imponeto:=trim(fields[4].asstring);
     TURNOID:=FIELDS[6].ASINTEGER;

      finally
         close;
         free;
      end;

     //TURNOS
       aContexto:=TSQLQuery.Create(nil);
  with aContexto do
   try
    SQLConnection:=mybd;
    sql.add('SELECT codfactu,codclien,tipfactu,ivainscr,imponeto,fechalta, CODTURNO  from TFACTURAS where codfactu=:codfactu');
    ParamByName('codfactu').Value:=codfactu;

    Open;

    {         Application.MessageBox( pchar('No se ha encontrado la factura nro '+trim(edit1.Text)),
  'Atenci�n', MB_ICONSTOP );
    EXIT;
      exit;}


     codfactu:=fields[0].asinteger;
     codclien:=fields[1].asinteger;
     tipfactu:=trim(fields[2].asstring);
     ivainscr:=trim(fields[3].asstring);
     imponeto:=trim(fields[4].asstring);

      finally
         close;
         free;
      end;
   ///


 {datos clientes}
  aContexto:=TSQLQuery.Create(nil);
  with aContexto do
   try
    SQLConnection:=mybd;
    sql.add('select nombre,apellid1, tipodocu, document from tclientes where codclien=:codcliente');
    ParamByName('codcliente').Value:=codclien;
    Open;
     nombrecliente:=trim(fields[0].asstring)+' '+trim(fields[1].asstring);
     tipodocucliente:=trim(fields[2].asstring);
     documento:=trim(fields[3].asstring);

      finally
         close;
         free;
      end;



      
 {VEHICULO}
  aContexto:=TSQLQuery.Create(nil);
  with aContexto do
   try
    SQLConnection:=mybd;
    sql.add('select CODVEHIC from TINSPECCION where CODFACTU=:CODFACTU');
    ParamByName('CODFACTU').Value:=codfactu;
    Open;
     CODVEHIC:=FIELDS[0].ASINTEGER;

      finally
         close;
         free;
      end;


 {--------------------}


  aContexto:=TSQLQuery.Create(nil);
  with aContexto do
   try
    SQLConnection:=mybd;
    sql.add('select dvdomino from tdatosturno where turnoid=:turnoid');
    ParamByName('turnoid').Value:=TURNOID;

    Open;


      patente_para_factura:=TRIM(FIELDS[0].ASSTRING);


      finally
         close;
         free;
      end;



  if Application.MessageBox( pchar('�Desea realizar la nota de credito de la factura: '+trim(edit1.Text)+' de '+nombrecliente+'   Vehiculo: '+patente_para_factura+' ?'), 'Guardando factura',
  MB_ICONQUESTION OR MB_YESNO ) = ID_YES then
  begin
        if trim(tipodocucliente)='DNI'  then   //dni
       begin

          tipo_doc:=96;
          nro_doc:=TRIM(documento);
       end;

            if trim(tipodocucliente)='CUIL'   then   //dni
       begin

          tipo_doc:=86;
          nro_doc:=TRIM(documento);
       end;

              if trim(tipodocucliente)='CDI'   then   //dni
       begin

          tipo_doc:=87;
          nro_doc:=TRIM(documento);
       end;


              if trim(tipodocucliente)='LE'   then   //dni
       begin

          tipo_doc:=89;
          nro_doc:=TRIM(documento);
       end;
              if trim(tipodocucliente)='LC'   then   //dni
       begin

          tipo_doc:=90;
          nro_doc:=TRIM(documento);
       end;




      if trim(tipodocucliente)='CUIT' then   //cuit
       begin
         tipo_doc:=80;
         POSI:=POS('-',TRIM(documento));
          IF POSI > 0 THEN
           BEGIN
            nro_doc:='';
            nro_doc1:=TRIM(documento);
              FOR I:=1 TO LENGTH(TRIM(nro_doc1)) DO
               BEGIN
                   IF TRIM(nro_doc1[I])<>'-' THEN
                      nro_doc:=nro_doc + TRIM(nro_doc1[I]);
                end;

           END else
             nro_doc:=TRIM(documento);

       end;



    FA:=tfacturae.CREATE;
    FA.LEER_PARAMETROS;
    if fa.Autenticar(trim(fa.MODO_FAE),trim(fa.carpeta),trim(fa.CUIT_EMPRESA))=false then
    begin
     Application.MessageBox( 'No se pudo autenticar con AFIP.',
  'Atenci�n', MB_ICONSTOP );
    EXIT;
    END;

      FA.Control_servidores(FA.Token,FA.Sign,FA.MODO_FAE,FA.CUIT_EMPRESA);

    IF TRIM(FA.estado_servidor)='OK' THEN
     BEGIN


     END;


   IF TRIM(FA.Estado_autentica)='OK' THEN
    BEGIN

    END;

   IF TRIM(FA.estado_bd)='OK' THEN
    BEGIN

    END;


   IF   (TRIM(FA.estado_bd)='OK')  AND (TRIM(FA.Estado_autentica)='OK')  AND (TRIM(FA.estado_servidor)='OK') THEN
     BEGIN
        TIENE_CONEXION_ELECTRONICA:=TRUE;


      END      ELSE
        BEGIN
          TIENE_CONEXION_ELECTRONICA:=FALSE;

           Application.MessageBox( 'PROCESO DE FACTURA ELECTRONICA: NO DISPONIBLE.',
  'Atenci�n', MB_ICONSTOP );
  exit;
        END;


if TIENE_CONEXION_ELECTRONICA=true then
   begin
    IF TRIM(tipo)='A' THEN
        tipo_cbte:=3;

    IF TRIM(tipo)='B' THEN
       tipo_cbte:=8;

    IF TRIM(tipo)='C' THEN
       tipo_cbte:=13;

IMPORTE_SIN_IVA:=0;
IMPORTE_IVA:=0;
 fecha:=datetostr(date);
 id_SERVICIO:=2;

punto_vta:=FA.PUNTOVENTAFAE;
cbt_desde:='0';
cbt_hasta:='0';
para_Actualizar_numero:='1';
para_Actualizar_compro:='1';

//IMPORTEVERIFICACION:='12.10';
imp_total:=trim(imponeto);//'12.10';


IMPORTEVERIFICACION:= StringReplace(TRIM(imponeto), '.', ',',
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
    fecha_serv_desde, fecha_serv_hasta,moneda_id, moneda_ctz,IMPORTE_PARA21_s,IVA21,fa.Token,fa.Sign,fa.CUIT_EMPRESA,fa.MODO_FAE,tipo,mybd,1) =true then
begin
NUMEROnc:=FA.ULTIMO;
NRO_COMPROBANTE:='000'+INTTOSTR(punto_vta)+'-'+ARMAR_NUMERO_FACTURA(INTTOSTR(FA.ULTIMO));

{guardo en la base la nc}

guarda_nc(codfactu,NUMEROnc,FA.cae,FA.fecha_vence,punto_vta);


if TRIM(TIPOCOMPROBANTE)='NCA' THEN
   archivo:=generar_pdf(NRO_COMPROBANTE,FA.cae,FA.fecha_vence,IMP_NETO,IVA21,imp_total,TIPOCOMPROBANTE,INTTOSTR(punto_vta),TURNOID,letra,patente_para_factura);

if TRIM(TIPOCOMPROBANTE)='NCB' THEN
    generar_pdf_B(NRO_COMPROBANTE,FA.cae,FA.fecha_vence,IMP_NETO,iva21,imp_total,TIPOCOMPROBANTE,INTTOSTR(punto_vta),TURNOID,letra,patente_para_factura);



     //      else
       //      archivo:=generar_pdf_B(NRO_COMPROBANTE,FA.cae,FA.fecha_vence,IMP_NETO,IVA21,imp_total,STIPOCOMPROBANTE,INTTOSTR(punto_vta),TURNOID,letra,patente_para_factura);




    showmessage(fa.OBSERVACIONES_CAE+' | NOTA CREDITO: '+NRO_COMPROBANTE+' CAE: '+trim(fa.cae)+' fecha venc: '+trim(fa.fecha_vence));

      atfact_adicion:=TSQLQuery.Create(nil);
        atfact_adicion.SQLConnection:=mybd;
        atfact_adicion.sql.add('update nchacer set nc=''S'' where codfactu='+inttostr(acodfactu));
        atfact_adicion.ExecSQL;

        atfact_adicion.close;
        atfact_adicion.Free;

    end else
begin
   showmessage(fa.OBSERVACIONES_CAE);
end;





     end;





  end;




    end else begin//tfac_adicion

        atfact_adicion:=TSQLQuery.Create(nil);
        atfact_adicion.SQLConnection:=mybd;
        atfact_adicion.sql.add('update nchacer set nc=''N'' where codfactu='+inttostr(acodfactu));
        atfact_adicion.ExecSQL;

        atfact_adicion.close;
        atfact_adicion.Free;

    end;

  alista.next;
 end;//hile;


   Application.MessageBox( 'TERMINADO.',
  'Atenci�n', MB_ICONSTOP );
end;

end.
