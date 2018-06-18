unit ufDevolObleasVTV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, globals, uStockClasses, uStockEstacion, uLogs, ucDialgs,
  StdCtrls, Buttons, RxLookup, ToolEdit, RXDBCtrl, Mask, DBCtrls, DB, SqlExpr,
  ExtCtrls;

type
  TfrmDevolObleasVTV = class(TForm)
    btnSalir: TBitBtn;
    srcOrigen: TDataSource;
    srcPlanta: TDataSource;
    srcMovimiento: TDataSource;
    edObleaInicial: TDBEdit;
    edAno: TDBEdit;
    edCantidad: TDBEdit;
    edObleaFinal: TDBEdit;
    edFecha: TDBDateEdit;
    lcbOrigen: TRxDBLookupCombo;
    lcbDestino: TRxDBLookupCombo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    Bevel1: TBevel;
    Label9: TLabel;
    edFechsoli: TDBDateEdit;
    edMotivo: TDBEdit;
    Label10: TLabel;
    Label8: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    procedure btnSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edCantidadExit(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure lcbOrigenCloseUp(Sender: TObject);
    procedure lcbDestinoCloseUp(Sender: TObject);
    procedure edCantCertifEnter(Sender: TObject);
    procedure edCantBolsiEnter(Sender: TObject);
  private
    { Private declarations }
    fMovimiento: tMovimientos_VTV;
    fPlanta, fOrigen: tPlantas;

  public
    { Public declarations }
    procedure ActualizarObleas;
    function ValidatePost:boolean;
    function CantidadIgualObleas:boolean;
  end;
  procedure DoDevolObleasVTV;

var
  frmDevolObleasVTV: TfrmDevolObleasVTV;

resourcestring
  FILE_NAME = 'UfDevolObleasVTV';
  CAPTION = 'Devolución de Obleas';

implementation

uses Math, urDevolObleasVTV;

{$R *.dfm}

procedure DoDevolObleasVTV;
begin
  with TfrmDevolObleasVTV.Create(application) do
    try
      showmodal;
    finally
      free;
    end;
end;


procedure TfrmDevolObleasVTV.btnSalirClick(Sender: TObject);
begin
  if MyBD.InTransaction then MyBD.Rollback(td);
  close;
end;

procedure TfrmDevolObleasVTV.FormCreate(Sender: TObject);
begin
    fOrigen := nil;
    fMovimiento := nil;
    fPlanta := nil;

    fOrigen := tPlantas.CreatePlantasVTV(MYBD);
    fPlanta := tPlantas.CreateDepositos(MYBD);
    fMovimiento := tMovimientos_VTV.CreateByRowId(mybd,'');

    fOrigen.Open;
    fPlanta.Open;
    fMovimiento.Open;
    fMovimiento.Append;

    srcOrigen.DataSet := fOrigen.DataSet;
    srcPlanta.DataSet := fPlanta.DataSet;
    srcMovimiento.DataSet := fMovimiento.DataSet;

    MyBD.StartTransaction(td);
    
end;

procedure TfrmDevolObleasVTV.FormDestroy(Sender: TObject);
begin
    fOrigen.free;
    fMovimiento.free;
    fPlanta.free;
end;

procedure TfrmDevolObleasVTV.btnAceptarClick(Sender: TObject);
begin
  try
    if CantidadIgualObleas then
    begin
      if ValidatePost then
      begin
        fMovimiento.ValueByName[FIELD_TIPO] := MOV_TIPO_DEVOLUCION;
        fMovimiento.Post(true);
        ActualizarObleas;
        MyBD.Commit(td);
        DoRepDevolObleasVTV(fMovimiento.ValueByName[FIELD_IDMOVIMIENTO],strtoint(fOrigen.valuebyname[FIELD_IDEMPRESA]));
        MessageDlg(CAPTION,'Movimiento registrado con éxito',mtInformation,[mbOK],mbOK,0);
        fMovimiento.Append;
        MyBD.StartTransaction(td);
      end;
    end
    else
        MessageDlg(CAPTION,'El lote de obleas no se encuentra en la planta de origen',mtError,[mbOK],mbOK,0);

  except
   on E: Exception do
   begin
      MessageDlg(CAPTION,Format('No se ha podido registrar el movimiento por: %s. ',[E.message]), mtError, [mbOk], mbOk, 0);
      MyBD.Rollback(td);
   end;
  end;
end;

procedure TfrmDevolObleasVTV.ActualizarObleas;
begin
      with tSqlquery.create(nil) do
       try
         SqlConnection := MyBD;
           sql.Clear;
           sql.Add(format('UPDATE VTV_OBLEAS SET IDPLANTA = %S, IDMOVIMIENTO = %S WHERE ANO = %S AND NUMERO BETWEEN %S AND %S',[fPlanta.ValueByName[FIELD_IDPLANTA],fMovimiento.ValueByName[FIELD_IDMOVIMIENTO], edano.text,edObleaInicial.Text,edObleaFinal.Text]));
           ExecSQL;
           close;
       finally
         free;
       end;
end;

function TfrmDevolObleasVTV.ValidatePost: boolean;
begin
  result := false;

  if edFechsoli.Date = 0  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la fecha de solicitud',mtError,[mbOK],mbOK,0);
        edFechsoli.SetFocus;
        exit;
  end;

  if edFecha.Date = 0  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la fecha de entrega',mtError,[mbOK],mbOK,0);
        edFecha.SetFocus;
        exit;
  end;
  if edAno.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar el año de las obleas',mtError,[mbOK],mbOK,0);
        edAno.SetFocus;
        exit;
  end;
  if edObleaInicial.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar el Nº de oblea inicial',mtError,[mbOK],mbOK,0);
        edObleaInicial.SetFocus;
        exit;
  end;
  if edCantidad.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la cantidad de obleas',mtError,[mbOK],mbOK,0);
        edCantidad.SetFocus;
        exit;
  end;
  if lcbOrigen.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar el proveedor de obleas',mtError,[mbOK],mbOK,0);
        lcbOrigen.SetFocus;
        exit;
  end;
  if lcbDestino.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar el depósito al que ingresaron las obleas',mtError,[mbOK],mbOK,0);
        lcbDestino.SetFocus;
        exit;
  end;
  if not CantidadIgualObleas then
  begin
        MessageDlg(CAPTION,'El lote de obleas no se encuentra en la planta de origen',mtError,[mbOK],mbOK,0);
        exit;
  end;

  result := true;
end;

procedure TfrmDevolObleasVTV.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TfrmDevolObleasVTV.edCantidadExit(Sender: TObject);
begin
  if (edObleaInicial.text <> '') AND (edCantidad.Text <> '') then
  begin
    fMovimiento.ValueByName[FIELD_OBLEAFINAL] := inttostr(strtoInt(edObleaInicial.Text)+strToInt(edCantidad.Text)-1);
  end;
end;

procedure TfrmDevolObleasVTV.btnCancelarClick(Sender: TObject);
begin
  fMovimiento.Cancel;
  fMovimiento.Append;
end;

procedure TfrmDevolObleasVTV.lcbOrigenCloseUp(Sender: TObject);
begin
  lcbOrigen.Value := fOrigen.ValueByName[lcbOrigen.LookUpField];
end;

procedure TfrmDevolObleasVTV.lcbDestinoCloseUp(Sender: TObject);
begin
  lcbDestino.Value := fPlanta.ValueByName[lcbDestino.LookUpField];
end;

procedure TfrmDevolObleasVTV.edCantCertifEnter(Sender: TObject);
begin
  fMovimiento.ValueByName[FIELD_CANTCERTIF] := edCantidad.Text;
end;

procedure TfrmDevolObleasVTV.edCantBolsiEnter(Sender: TObject);
begin
  fMovimiento.ValueByName[FIELD_CANTBOLSI] := edCantidad.Text;
end;

function TfrmDevolObleasVTV.CantidadIgualObleas: boolean;
begin
  result := false;
  with tSqlquery.Create(nil) do
    try
      SqlConnection := mybd;
      sql.Add(format('SELECT COUNT(IDOBLEA) FROM VTV_OBLEAS WHERE ANO = %S AND NUMERO BETWEEN %S AND %S AND IDPLANTA = %S AND ESTADO = ''S''',[edAno.Text,edObleaInicial.Text,edObleaFinal.Text, fOrigen.ValueByName[FIELD_IDPLANTA]]));
      open;
      if Fields[0].AsInteger <> strtoint(edCantidad.text) then
      begin
        exit;
      end;
    finally
      free;
    end;
  result := true;
end;

end.
