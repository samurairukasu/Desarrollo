unit ufTransObleasExtraVTV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, globals, uStockClasses, uStockEstacion, uLogs, ucDialgs,
  StdCtrls, Buttons, RxLookup, ToolEdit, RXDBCtrl, Mask, DBCtrls, DB, SqLeXPR,
  ExtCtrls;

type
  TfrmTransObleasExtraVTV = class(TForm)
    btnSalir: TBitBtn;
    srcOrigen: TDataSource;
    srcDestino: TDataSource;
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
    fOrigen: tPlantas;
    fDestino: tProveedores;

  public
    { Public declarations }
    procedure ActualizarObleas;
    function ValidatePost:boolean;
    function CantidadIgualObleas:boolean;
  end;
  procedure DoTransObleasExtraVTV;

var
  frmTransObleasExtraVTV: TfrmTransObleasExtraVTV;

resourcestring
  FILE_NAME = 'UfTransObleasExtraVTV';
  CAPTION = 'Transferencia de Obleas a Otras Zonas';

implementation

uses Math, urTransObleasExtraVTV;

{$R *.dfm}

procedure DoTransObleasExtraVTV;
begin
  with TfrmTransObleasExtraVTV.Create(application) do
    try
      showmodal;
    finally
      free;
    end;
end;


procedure TfrmTransObleasExtraVTV.btnSalirClick(Sender: TObject);
begin
  if MyBD.InTransaction then MyBD.Rollback(td);
  close;
end;

procedure TfrmTransObleasExtraVTV.FormCreate(Sender: TObject);
begin
    fOrigen := nil;
    fMovimiento := nil;
    fDestino := nil;

    fOrigen := tPlantas.CreateDepositos(MYBD);
    fDestino := tProveedores.Create(mybd);
    fMovimiento := tMovimientos_VTV.CreateByRowId(mybd,'');

    fOrigen.Open;
    fDestino.Open;
    fMovimiento.Open;
    fMovimiento.Append;

    srcOrigen.DataSet := fOrigen.DataSet;
    srcDestino.DataSet := fDestino.DataSet;
    srcMovimiento.DataSet := fMovimiento.DataSet;

    MyBD.StartTransaction(td);
    
end;

procedure TfrmTransObleasExtraVTV.FormDestroy(Sender: TObject);
begin
    fOrigen.free;
    fMovimiento.free;
    fDestino.free;
end;

procedure TfrmTransObleasExtraVTV.btnAceptarClick(Sender: TObject);
begin
  try
    if CantidadIgualObleas then
    begin
      if ValidatePost then
      begin
        fMovimiento.ValueByName[FIELD_TIPO] := MOV_TIPO_EXTRAZONA;
        fMovimiento.Post(true);
        ActualizarObleas;
        MyBD.Commit(td);
        DoRepTransObleasExtraVTV(fMovimiento.ValueByName[FIELD_IDMOVIMIENTO],strtoint(fOrigen.valuebyname[FIELD_IDEMPRESA]));
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

procedure TfrmTransObleasExtraVTV.ActualizarObleas;
begin
      with tsqlquery.create(nil) do
       try
         SqlConnection := MyBD;
         sql.add('alter session set nls_date_format = ''dd/mm/yyyy''');
         ExecSQL;
           sql.Clear;
           sql.Add(format('UPDATE VTV_OBLEAS SET IDPLANTA = %S, IDMOVIMIENTO = %S, ESTADO = ''T'', FECHCONS = ''%S'' WHERE ANO = %S AND NUMERO BETWEEN %S AND %S',[fDestino.ValueByName[FIELD_IDPROVEEDOR],fMovimiento.ValueByName[FIELD_IDMOVIMIENTO],edfecha.text,edano.text,edObleaInicial.Text,edObleaFinal.Text]));
           ExecSQL;
           close;
       finally
         free;
       end;
end;

function TfrmTransObleasExtraVTV.ValidatePost: boolean;
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

procedure TfrmTransObleasExtraVTV.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TfrmTransObleasExtraVTV.edCantidadExit(Sender: TObject);
begin
  if (edObleaInicial.text <> '') AND (edCantidad.Text <> '') then
  begin
    fMovimiento.ValueByName[FIELD_OBLEAFINAL] := inttostr(strtoInt(edObleaInicial.Text)+strToInt(edCantidad.Text)-1);
  end;
end;

procedure TfrmTransObleasExtraVTV.btnCancelarClick(Sender: TObject);
begin
  fMovimiento.Cancel;
  fMovimiento.Append;
end;

procedure TfrmTransObleasExtraVTV.lcbOrigenCloseUp(Sender: TObject);
begin
  lcbOrigen.Value := fOrigen.ValueByName[lcbOrigen.LookUpField];
end;

procedure TfrmTransObleasExtraVTV.lcbDestinoCloseUp(Sender: TObject);
begin
  lcbDestino.Value := fDestino.ValueByName[lcbDestino.LookUpField];
end;

procedure TfrmTransObleasExtraVTV.edCantCertifEnter(Sender: TObject);
begin
  fMovimiento.ValueByName[FIELD_CANTCERTIF] := edCantidad.Text;
end;

procedure TfrmTransObleasExtraVTV.edCantBolsiEnter(Sender: TObject);
begin
  fMovimiento.ValueByName[FIELD_CANTBOLSI] := edCantidad.Text;
end;

function TfrmTransObleasExtraVTV.CantidadIgualObleas: boolean;
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
