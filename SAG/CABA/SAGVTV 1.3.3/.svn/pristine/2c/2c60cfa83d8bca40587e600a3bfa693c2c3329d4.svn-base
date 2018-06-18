unit Unitfrmregistrar_remitos_certificados;

interface

uses
  Windows, Messages,UniREMITO_CERTIFICADOS, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, StdCtrls, Buttons, ComCtrls, FMTBcd, DB, SqlExpr,GLOBALS,
  RxLookup;

type
  Tfrmregistrar_remitos_certificados = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    SQLQuery1: TSQLQuery;
    DataSource1: TDataSource;
    Label6: TLabel;
    Edit3: TEdit;
    SQLQuery2: TSQLQuery;
    DataSource2: TDataSource;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label7: TLabel;
    Edit4: TEdit;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    FUNCTION IMPRIMIR_REMITO(IDENTREGA:LONGINT):BOOLEAN;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmregistrar_remitos_certificados: Tfrmregistrar_remitos_certificados;

implementation

{$R *.dfm}

procedure Tfrmregistrar_remitos_certificados.FormCreate(Sender: TObject);
begin
edit1.clear;
edit2.Clear;
edit3.clear;
edit4.clear;
datetimepicker1.DateTime:=now;
 combobox2.clear;
SELF.SQLQuery2.SQLConnection:=GLOBALS.MyBD;
SELF.SQLQuery2.Close;
SELF.SQLQuery2.SQL.Clear;
SELF.SQLQuery2.SQL.Add('SELECT idusuario, nombre FROM tusuario ORDER BY nombre ASC');
SELF.SQLQuery2.ExecSQL;
SELF.SQLQuery2.Open;
while not self.SQLQuery2.Eof do
begin
      combobox2.Items.Add(trim(SELF.SQLQuery2.fieldbyname('nombre').AsString));

    self.SQLQuery2.Next;
end;



 combobox1.Clear;
SELF.SQLQuery1.SQLConnection:=GLOBALS.MyBD;
SELF.SQLQuery1.Close;
SELF.SQLQuery1.SQL.Clear;
SELF.SQLQuery1.SQL.Add('SELECT PROVEEDORID, RAZONSOCIAL FROM TPROVEEDORES ORDER BY RAZONSOCIAL ASC');
SELF.SQLQuery1.ExecSQL;
SELF.SQLQuery1.Open;
 while not self.SQLQuery1.Eof do
begin
      combobox1.Items.Add(trim(SELF.SQLQuery1.fieldbyname('RAZONSOCIAL').AsString));

    self.SQLQuery1.Next;
end;





end;

procedure Tfrmregistrar_remitos_certificados.BitBtn2Click(Sender: TObject);
begin
close;
end;

FUNCTION Tfrmregistrar_remitos_certificados.IMPRIMIR_REMITO(IDENTREGA:LONGINT):BOOLEAN;
 var proveedor,cantidad, detalle,fecha,nro,n,f1,f2,f3:string;
 largo,hasta,i,idproveedor:longint;
BEGIN


   with TSQLQuery.Create(application) do
     try
       SQLConnection:=MYBD;
       SQL.ADD('select zona from tvarios');
       Open;
       nro:='000'+trim(fieldbyname('zona').asstring);

         finally
            Close;
            Free;
        end;






largo:=length(inttostr(IDENTREGA));
hasta:=8 - largo;
n:='';
for i:=1 to hasta do
    n:=n + '0';


n:=n + inttostr(identrega);


nro:=nro+'-'+n;

f1:=copy(datetostr(date),1,2);
f2:=copy(datetostr(date),4,2);
f3:=copy(datetostr(date),7,4);



   with TSQLQuery.Create(application) do
     try
       SQLConnection:=MYBD;
       SQL.ADD(' SELECT IDENTREGA, PROVEEDOR, NROINICIAL, NROFINAL, CANTIDAD, NROREMITO, FECHAENTREGA, '+
               ' RECIBE, FECHALTA  FROM TENTREGA_CERTIFICADOS  '+
               ' where identrega='+inttostr(IDENTREGA));
       Open;
      // idproveedor:=fieldbyname('PROVEEDOR').asinteger;
       proveedor:=trim(fieldbyname('PROVEEDOR').asstring);
       cantidad:=trim(fieldbyname('CANTIDAD').asstring);
       detalle:='Certificado Verificación Técnica Vehicular. Nro Desde: '+trim(fieldbyname('NROINICIAL').asstring)+'  Nro Hasta '+trim(fieldbyname('NROFINAL').asstring);



         finally
            Close;
            Free;
        end;







    with TREMITO_CERTIFICADOS.Create(Nil) do
   try
     RxMemoryData1.Close;
     RxMemoryData1.Open;
     RxMemoryData1.Append;
     RxMemoryData1detalle.Value:=trim(detalle);
     RxMemoryData1cantidad.Value:=trim(cantidad) ;
     RxMemoryData1.post;

     qrlabel4.Caption:=nro;
      qrlabel12.Caption:=proveedor;
      qrlabel6.Caption:=f1;
      qrlabel7.Caption:=f2;
      qrlabel8.Caption:=f3;

      QuickRep1.Prepare;
      QuickRep1.Preview;

      
     finally
      free;
      end;

END;

procedure Tfrmregistrar_remitos_certificados.BitBtn1Click(Sender: TObject);
var proveedor, recibe,fecha,remito:String;
inicial, final, cantidad,identrega:longiNt;
 aqi:TSQLQuery;
begin
 IF COMBOBOX1.ItemIndex=-1 THEN
  BEGIN
  Application.MessageBox( 'Debe seleccionar el Proveedor.',
  'Atención', MB_ICONSTOP );
  EXIT;
  END;


 IF trim(edit1.Text)='' THEN
  BEGIN
  Application.MessageBox( 'Debe ingresar el Nro Inicial.',
  'Atención', MB_ICONSTOP );
  EXIT;
  END;


   IF trim(edit2.Text)='' THEN
  BEGIN
  Application.MessageBox( 'Debe ingresar el Nro Final.',
  'Atención', MB_ICONSTOP );
  EXIT;
  END;


   IF trim(edit3.Text)='' THEN
  BEGIN
  Application.MessageBox( 'Debe ingresar la cantidad.',
  'Atención', MB_ICONSTOP );
  EXIT;
  END;


   IF trim(edit4.Text)='' THEN
  BEGIN
  Application.MessageBox( 'Debe ingresar el Nro de Remito.',
  'Atención', MB_ICONSTOP );
  EXIT;
  END;


    IF COMBOBOX2.ItemIndex=-1 THEN
  BEGIN
  Application.MessageBox( 'Debe seleccionar el personal que lo recibe.',
  'Atención', MB_ICONSTOP );
  EXIT;
  END;



 proveedor:=trim(combobox1.Text);
 recibe:=trim(combobox2.Text);
 fecha:=datetostr(datetimepicker1.DateTime);
 remito:=trim(edit4.Text) ;
 inicial:=strtoint(edit1.Text);
 final:=strtoint(edit2.Text);
 cantidad:=strtoint(edit3.Text);

 TRY
 aqi:=TSQLQuery.Create(nil);
 aqi.SQLConnection:=mybd;
 aqi.Close;
 aqi.SQL.Clear;
 aqi.SQL.Add ('select  max(identrega) as maximo from  TENTREGA_CERTIFICADOS');
 aqi.EXECSQL;
 aqi.open;
 identrega:=aqi.fieldbyname('maximo').asinteger + 1;
 aqi.Close;
 aqi.Free;




 aqi:=TSQLQuery.Create(nil);
 aqi.SQLConnection:=mybd;
 aqi.Close;
 aqi.SQL.Clear;
 aqi.SQL.Add ('insert into  TENTREGA_CERTIFICADOS (IDENTREGA, PROVEEDOR, NROINICIAL, NROFINAL, CANTIDAD, NROREMITO, FECHAENTREGA, RECIBE, FECHALTA)  '+
 ' values ('+INTTOSTR(IDENTREGA)+','+#39+TRIM(PROVEEDOR)+#39+','+INTTOSTR(INICIAL)+','+INTTOSTR(FINAL)+
           ','+INTTOSTR(CANTIDAD)+','+#39+TRIM(REMITO)+#39+','+#39+TRIM(FECHA)+#39+','+#39+TRIM(RECIBE)+#39+',SYSDATE)');
 aqi.EXECSQL;

 aqi.Close;
 aqi.Free;
 Application.MessageBox( 'Se ha procesdo correctamente', 'Atención',
  MB_ICONINFORMATION );

  IMPRIMIR_REMITO(IDENTREGA);
 EXCEPT
   Application.MessageBox( 'Se produjo un error al intentar procesar la información.',
  'Atención', MB_ICONSTOP );
 END;

//TENTREGA_CERTIFICADOS
end;

end.
