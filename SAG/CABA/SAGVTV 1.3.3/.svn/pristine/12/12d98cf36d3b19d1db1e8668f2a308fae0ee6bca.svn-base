unit UFPagoConTarjeta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, RXSpin, Mask, ToolEdit, RxLookup, Db,
  USagClasses, Globals, USAGEstacion, ucdialgs, UInterfazUsuario;

type
  TFrmPagoConTarjeta = class(TForm)
    DSToTTarjetas: TDataSource;
    CBTarjeta: TRxDBLookupCombo;
    ednumtarjeta: TEdit;
    edfecven: TDateEdit;
    edcantcuotas: TRxSpinEdit;
    BContinuar: TBitBtn;
    BCancelar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel15: TPanel;
    Label5: TLabel;
    edCodAuto: TEdit;
    BbNroFactura: TBevel;
    Image1: TImage;
    Label6: TLabel;
    lblCantidadAPagar: TLabel;
    Bevel1: TBevel;
    LblNumeroFactura: TLabel;
    lblfactura: TLabel;
    Bevel2: TBevel;
    procedure FormShow(Sender: TObject);
    procedure BContinuarClick(Sender: TObject);
    procedure edfecvenExit(Sender: TObject);
    procedure edfecvenEnter(Sender: TObject);
    procedure ednumtarjetaExit(Sender: TObject);
    procedure CBTarjetaKeyPress(Sender: TObject; var Key: Char);
    procedure BCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Completo: boolean;
    ftarjeta: ttarjeta;
    ffactura: tFacturacion;
    fPtoVenta: tPtoVenta;
    muestronumero: Boolean;
    function ValidatePost: boolean;
    function NumTarjetaCorrecto(aNumerotarj: string): boolean;
  public
    { Public declarations }

  end;

    function CreateFromBD (aFactura: TFacturacion; enable: boolean):boolean;
    function CreateFromBDImporte (aFactura: TFacturacion; enable: boolean; imp: Double):boolean;
var
  FrmPagoConTarjeta: TFrmPagoConTarjeta;
  importe_paga:double;

implementation

{$R *.DFM}

const
        M_FALTATARJETA = 'Debe Introducir una Tarjeta de Crédito';
        M_FALTANUMERO = 'Debe Introducir un Número de Tarjeta de Crédito Correcto';
        M_FALTAFECHA = 'Debe Introducir una Fecha de Vencimiento Válida';
        M_FALTACODAUTO = 'Debe Introducir el Código de Autorización';

procedure TFrmPagoConTarjeta.FormShow(Sender: TObject);
begin
  ftarjeta.open;
  ffactura.ffactadicionales.open;
  ffactura.ffactadicionales.edit;
  edNumTarjeta.text := ffactura.ffactadicionales.ValueByName[FIELD_NUMTARJET];
  edFecVen.text := ffactura.ffactadicionales.ValueByName[FIELD_FECHAVEN];

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

function CreateFromBDImporte (aFactura: TFacturacion; enable: boolean; imp: Double):boolean;
begin
    with TFrmPagoConTarjeta.Create(Application) do
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
        lblCantidadAPagar.Caption := Format ('%1.2f',[imp]);
        showmodal;
      finally
        result:= completo ;
        free
      end;
    end;
end;


function CreateFromBD (aFactura: TFacturacion; enable: boolean):boolean;
begin
    with TFrmPagoConTarjeta.Create(Application) do
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


procedure TFrmPagoConTarjeta.BContinuarClick(Sender: TObject);
begin
  Completo := False;
  if ValidatePost then
    try
      ffactura.ffactadicionales.ValueByName[FIELD_CODTARJET]:=FTarjeta.valuebyname[FIELD_CODTARJET];
      ffactura.ffactadicionales.ValueByName[FIELD_NUMTARJET]:=ednumtarjeta.Text;
      ffactura.ffactadicionales.ValueByName[FIELD_FECHAVEN]:=edfecven.text;
      ffactura.ffactadicionales.ValueByName[FIELD_CANTCUOT]:=edcantcuotas.Text;
      ffactura.ffactadicionales.ValueByName[FIELD_CODAUTO]:=edCodAuto.text;
    //  ffactura.ffactadicionales.ValueByName['IDUSUARI']:=INTTOSTR(GLOBALS.IDUSUARIO_ALERTAS);
     // ffactura.ffactadicionales.ValueByName['CODFACT']:=INTTOSTR(GLOBALS.CODFACT_NC);
      Completo := True;
      modalresult:=mrok;
      ffactura.ffactadicionales.Post(True);
    except
      on E: Exception do
          ShowMessage(caption,'Error al conectarse a la base de datos: '+E.Message);
    end;
end;

function TFrmPagoConTarjeta.ValidatePost: boolean;
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

procedure TFrmPagoConTarjeta.edfecvenExit(Sender: TObject);
begin
AtenuarControl(Sender, TRUE);
if not (bcancelar.focused) then
  Try
   StrToDate(edfecven.Text);
   If (edfecven.Date<Date) then
     begin
       Raise Exception.Create('La Fecha de Vencimiento debe ser Mayor o Igual a la Actual');
     end;
  Except
    Messagedlg(Caption,M_FALTAFECHA,mtError,[mbok],mbok,0);
    edfecven.Clear;
    edfecven.SetFocus;
  end;
end;

procedure TFrmPagoConTarjeta.edfecvenEnter(Sender: TObject);
begin
        DestacarControl (Sender, clGreen, clWhite, TRUE);
end;

procedure TFrmPagoConTarjeta.ednumtarjetaExit(Sender: TObject);
begin
    AtenuarControl(Sender, TRUE);
end;

function TFrmPagoConTarjeta.NumTarjetaCorrecto(anumerotarj: string): boolean;
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


procedure TFrmPagoConTarjeta.CBTarjetaKeyPress(Sender: TObject;
  var Key: Char);
begin
        if key = #13
        then begin
            Perform(WM_NEXTDLGCTL,0,0);
            Key := #0
        end;
        if not (Key in ['0','1','2','3','4','5','6','7','8','9',#8])
        then key := #0
end;

procedure TFrmPagoConTarjeta.BCancelarClick(Sender: TObject);
begin
  Completo := false;
end;


procedure TFrmPagoConTarjeta.FormCreate(Sender: TObject);
begin
  ftarjeta:=nil;
  ftarjeta:= ttarjeta.Create(MyBD);
  DSToTTarjetas.dataset:=ftarjeta.DataSet;
  fPtoVenta := Nil;
  fPtoVenta:= TPtoVenta.Create(MyBD);

end;

procedure TFrmPagoConTarjeta.FormDestroy(Sender: TObject);
begin
  fPtoVenta.Free;
  fTarjeta.Free;
end;

end.
