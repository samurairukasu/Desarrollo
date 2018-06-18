unit Utarjetas_nc_cf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, RXSpin, Mask, ToolEdit, RxLookup, Db,
  USagClasses, Globals, USAGEstacion, ucdialgs, UInterfazUsuario, RxMemDS;

type
  Ttarj_nc_cf = class(TForm)

    BbNroFactura: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblCantidadAPagar: TLabel;
    Bevel1: TBevel;
    LblNumeroFactura: TLabel;
    lblfactura: TLabel;
    Bevel2: TBevel;
    CBTarjeta: TRxDBLookupCombo;
    ednumtarjeta: TEdit;
    edfecven: TDateEdit;
    edcantcuotas: TRxSpinEdit;
    BContinuar: TBitBtn;
    BCancelar: TBitBtn;
    Panel15: TPanel;
    Image1: TImage;
    edCodAuto: TEdit;

    DSToTTarjetas: TDataSource;
    datos_tarjeta: TRxMemoryData;
    datos_tarjetatarjeta: TStringField;
    datos_tarjetanumero: TStringField;
    datos_tarjetavencimiento: TStringField;
    datos_tarjetacuotas: TStringField;
    datos_tarjetacodigo: TStringField;
    datos_tarjetausa: TIntegerField;
    datos_tarjetacodtarjeta: TStringField;    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BContinuarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure edCodAutoKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
      { Public declarations }

        Completo: boolean;
    ftarjeta: ttarjeta;
    ffactura: tFacturacion;
    fPtoVenta: tPtoVenta;
    muestronumero: Boolean;
    cod_tarjeta:string;
    function ValidatePost: boolean;
    function NumTarjetaCorrecto(aNumerotarj: string): boolean;
  end;
     function CreateFromBD (aFactura: TFacturacion; enable: boolean):boolean;

var
  tarj_nc_cf: Ttarj_nc_cf;
   importe_paga:double;
   cancelo:boolean;
implementation

{$R *.dfm}
const
        M_FALTATARJETA = 'Debe Introducir una Tarjeta de Crédito';
        M_FALTANUMERO = 'Debe Introducir un Número de Tarjeta de Crédito Correcto';
        M_FALTAFECHA = 'Debe Introducir una Fecha de Vencimiento Válida';
        M_FALTACODAUTO = 'Debe Introducir el Código de Autorización';
        
procedure Ttarj_nc_cf.FormShow(Sender: TObject);
begin
  ftarjeta.open;
  ffactura.ffactadicionales.open;
  ffactura.ffactadicionales.edit;
  edNumTarjeta.text := ffactura.ffactadicionales.ValueByName[FIELD_NUMTARJET];
  edFecVen.text := ffactura.ffactadicionales.ValueByName[FIELD_FECHAVEN];
  cod_tarjeta := ffactura.ffactadicionales.ValueByName[FIELD_CODTARJET];
  if ffactura.ffactadicionales.ValueByName[FIELD_CANTCUOT] <> '' then
    edCantCuotas.text := ffactura.ffactadicionales.ValueByName[FIELD_CANTCUOT];

  edCodAuto.text := ffactura.ffactadicionales.ValueByName[FIELD_CODAUTO];
  CBTarjeta.Value:=ffactura.ffactadicionales.valuebyname[FIELD_CODTARJET];

  if muestronumero then
  begin
    lblNumeroFactura.Caption := fPtoVenta.ProximoNroFactura(fFactura.ValuebyName[FIELD_TIPFACTU]);
  end
  else
  begin
    bbNroFactura.visible:=false;
    lblFactura.visible := False;
    lblNumeroFactura.visible := False;
  end;
end;


function CreateFromBD (aFactura: TFacturacion; enable: boolean):boolean;
begin
    with Ttarj_nc_cf.Create(Application) do
    begin
      muestronumero:=enable;
      try
        ffactura:=afactura;
        if not enable then
        begin
          cbtarjeta.enabled:=false;
          edNumTarjeta.enabled:=false;
          edFecVen.enabled:=false;
          edCantCuotas.enabled:=false;
        end;
        showmodal;
      finally
        result:= completo ;
        free
      end;
    end;
end;
procedure Ttarj_nc_cf.FormCreate(Sender: TObject);
begin
  ftarjeta:=nil;
  ftarjeta:= ttarjeta.Create(MyBD);
  DSToTTarjetas.dataset:=ftarjeta.DataSet;
  fPtoVenta := Nil;
  fPtoVenta:= TPtoVenta.Create(MyBD);
end;

procedure Ttarj_nc_cf.FormDestroy(Sender: TObject);
begin
  fPtoVenta.Free;
  fTarjeta.Free;
end;
function Ttarj_nc_cf.ValidatePost: boolean;
begin
  Result := False;

  if (CBTarjeta.Value = '') then
  begin
     MessageDlg (Application.Title, M_FALTATARJETA, mtError, [mbOk],mbOk,0);
     CBTarjeta.SetFocus;
     exit;
  end;

  if (EdNumTarjeta.text = '') or (not numtarjetacorrecto(EdNumTarjeta.text)) then
  begin
     MessageDlg (Application.Title, M_FALTANUMERO, mtError, [mbOk],mbOk,0);
     EdNumTarjeta.SetFocus;
     exit;
  end;

  try strtodate(EdFecVen.text)
  except
     MessageDlg (Application.Title, M_FALTAFECHA, mtError, [mbOk],mbOk,0);
     EdFecVen.SetFocus;
     exit;
  end;

  if (EdCodAuto.text = '') then
  begin
     MessageDlg (Application.Title, M_FALTACODAUTO, mtError, [mbOk],mbOk,0);
     EdCodAuto.SetFocus;
     exit;
  end;

  Result := True;
end;
procedure Ttarj_nc_cf.BContinuarClick(Sender: TObject);
begin
cancelo:=true;
  Completo := False;
  if ValidatePost then
    try

      Completo := True;
      cancelo:=false;
      modalresult:=mrok;



      globals.datos_tarjetatarjeta:=trim(CBTarjeta.Text);
      globals.datos_tarjetanumero:=trim(ednumtarjeta.Text);
      globals.datos_tarjetacodigo:=trim(edCodAuto.Text);
      globals.datos_tarjetavencimiento:=edfecven.Text;
      globals.datos_tarjetacuotas:=edcantcuotas.Text;
      globals.datos_tarjetacodtarjeta:=self.cod_tarjeta ;
      globals.datos_tarjetausa:=1;

     // ffactura.ffactadicionales.Post(True);
     close;
    except
      on E: Exception do
          ShowMessage(caption,'Error  obtener los datos de la tarjeta. '+E.Message);

    end;
end;

function Ttarj_nc_cf.NumTarjetaCorrecto(anumerotarj: string): boolean;
begin
  result := True;
  try
//    strtoint(aNumerotarj);                   
    if length(aNumerotarj) < 8 then
    begin
      result := False;
    end
    else
    begin
      result := True;
    end;
  except
    result:= False;
  end;
end;

procedure Ttarj_nc_cf.BCancelarClick(Sender: TObject);
begin
cancelo:=true;
close;
end;

procedure Ttarj_nc_cf.edCodAutoKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
begin
   if trim(EdCodAuto.text) = '' then
  begin
     MessageDlg (Application.Title, M_FALTACODAUTO, mtError, [mbOk],mbOk,0);
     EdCodAuto.SetFocus;
     exit;
  end;
 BContinuar.SetFocus;
end;

end;

procedure Ttarj_nc_cf.FormActivate(Sender: TObject);
begin
edCodAuto.Clear;
edCodAuto.SetFocus;
end;

end.
