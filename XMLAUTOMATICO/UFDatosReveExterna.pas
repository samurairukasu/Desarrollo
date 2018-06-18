unit UFDatosReveExterna;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ToolEdit, RXDBCtrl, StdCtrls, Mask, DBCtrls, UCDBEdit,
  Buttons, ComCtrls, USAGClasses, USAGEstacion, GLOBALS, Spin;

type
  TFrmDatosReveExterna = class(TForm)
    Label26: TLabel;
    Label33: TLabel;
    Label1: TLabel;
    BContinuar: TBitBtn;
    BCancelar: TBitBtn;
    CBResultado: TComboBox;
    DFechaVerificacion: TDateTimePicker;
    ENroInspeccion: TEdit;
    DFechaVencimiento: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LOblea: TLabel;
    Label6: TLabel;
    EOblea: TMaskEdit;
    SEZona: TSpinEdit;
    SEPlanta: TSpinEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    procedure BContinuarClick(Sender: TObject);
    procedure RegistrarReveExterna;
    procedure BCancelarClick(Sender: TObject);
    procedure EZonaKeyPress(Sender: TObject; var Key: Char);
    procedure CBResultadoChange(Sender: TObject);
  private
    ReveExterna: TReveExterna;
    iCodigoInspeccion: Integer;
    sCodigoInspeccion,iCodVehiculo, iEjercicio: String;

    Function SResultado(Combobox: TComboBox): String;
    Function DatosOk : Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;
  Function DoRecogeDatosInspeccionExt(const CodigoInspeccion, CodVehiculo, Ejercicio: String): Boolean;

var
  FrmDatosReveExterna: TFrmDatosReveExterna;

implementation

{$R *.dfm}


Function DoRecogeDatosInspeccionExt(const CodigoInspeccion, CodVehiculo, Ejercicio: String): Boolean;
Begin
Result:=False;
With TFrmDatosReveExterna.Create(Nil) do
  try
    iCodigoInspeccion:=StrToInt(CodigoInspeccion);
    DFechaVerificacion.Date:=Now;
    DFechaVencimiento.Date:=Now;
    Inc(iCodigoInspeccion);
    iCodVehiculo:=CodVehiculo;
    iEjercicio:=Ejercicio;
    ShowModal;
    if not DatosOk then
      Result:=False
    else
      Result:=True;
  finally
    Free;
  end;
end;


Function TFrmDatosReveExterna.SResultado(ComboBox:TComboBox): String;
Begin
  Case ComboBox.ItemIndex of
    0: Result := 'C';
    1: Result := 'R';
  end;
end;


procedure TFrmDatosReveExterna.RegistrarReveExterna;
Begin
ReveExterna:=TReveExterna.Create(MyBD);
With ReveExterna do
  try
    Open;
    Append;
    ValueByName[FIELD_CODINSPE]:= IntToStr(iCodigoInspeccion);
    ValueByName[FIELD_CODVEHIC]:= iCodVehiculo;
    ValueByName[FIELD_EJERCICI]:= iEjercicio;
    ValueByName[FIELD_FECHALTA]:= DateTimeToStr(Now);
    ValueByName[FIELD_RESULTAD]:= SResultado(CBResultado);
    ValueByName[FIELD_FECVERIFICACION]:= DateToStr(DFechaVerificacion.Date);
    ValueByName[FIELD_FECVENCI]:= DateToStr(DFechaVencimiento.Date);
    ValueByName[FIELD_ZONA]:= SEZona.text;
    ValueByName[FIELD_PLANTA]:=SEPlanta.text;
    if SResultado(CBResultado) = 'C' then
      ValueByName[FIELD_NUMOBLEA]:= FormatFloat('00000000',StrToInt(EOBlea.Text));
    Post(true);
    Close;
  finally
    free;
  end;
end;


procedure TFrmDatosReveExterna.BContinuarClick(Sender: TObject);
begin
if not DatosOk then
  MessageDlg ('Debe completar todos los datos requeridos', mtInformation, [mbOk], 0)
else
  Begin
    RegistrarReveExterna;
    ModalResult := mrOK;
  end;
end;


Function TFrmDatosReveExterna.DatosOk : Boolean;
Begin
Result :=  false;
if (ENroInspeccion.Text = '') then
  exit;
if (CBResultado.Text = '') then
  exit;
if  (DFechaVerificacion.Date > Now) then
  exit;
result := true;
end;

procedure TFrmDatosReveExterna.BCancelarClick(Sender: TObject);
begin
ModalResult := mrCancel;
Close;
end;

procedure TFrmDatosReveExterna.EZonaKeyPress(Sender: TObject;
  var Key: Char);
begin
if not (key in ['0'..'9',#8]) then
  Key:=#0;
end;

procedure TFrmDatosReveExterna.CBResultadoChange(Sender: TObject);
begin
if CBREsultado.ItemIndex = 0 then
  Begin
    LOblea.Enabled:=true;
    EOblea.Enabled:=true;
  end
else
  Begin
    LOblea.Enabled:=false;
    EOblea.Enabled:=false;
  end;
end;

end.
