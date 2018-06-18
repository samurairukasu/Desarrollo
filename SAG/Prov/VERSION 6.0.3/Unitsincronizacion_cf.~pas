unit Unitsincronizacion_cf;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, ExtCtrls,Printers, SQLEXPR,
  USAGCLASSES, USAGPRINTERS, Globals,  usuperregistry, OleCtrls,
  OCXFISLib_TLB,strUtils, ComObj,uconversiones, ucontstatus,
  EPSON_Impresora_Fiscal_TLB, StdCtrls, Buttons,UVERSION;

type
  Tsincronizacion_cf = class(TForm)
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DriverFiscal1: TDriverFiscal;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  sincronizacion_cf: Tsincronizacion_cf;

implementation

{$R *.dfm}

procedure Tsincronizacion_cf.BitBtn2Click(Sender: TObject);
begin
close;
end;

procedure Tsincronizacion_cf.BitBtn1Click(Sender: TObject);
var puerto,puerto_cf:string;
 velo,error:longint;
begin
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

 DriverFiscal1.Printer:='TM2000';

 // abro el puerto
puerto_cf:='COM'+trim(puerto);

// para ocx if
error :=DriverFiscal1.IF_OPEN(puerto_cf,velo);
if error<>0 then
begin
   Application.MessageBox( 'Error de comunicación con el Controlador Fiscal. Intente de nuevo por favor. Si el error persiste comuniquese con el depto de sistemas.',
  'Nota de Crédito', MB_ICONSTOP );
      error :=DriverFiscal1.IF_WRITE('@SINCRO|');
      DriverFiscal1.IF_CLOSE;

  exit;
end;
 DriverFiscal1.SerialNumber:='27-0163848-435';
 error :=DriverFiscal1.IF_WRITE('@SINCRO|');

  error :=DriverFiscal1.IF_WRITE('@CIERREX|');
  error :=DriverFiscal1.IF_WRITE('@CIERREZ|');


      DriverFiscal1.IF_CLOSE;


 close;
end;

end.
