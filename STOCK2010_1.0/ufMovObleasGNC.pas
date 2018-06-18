unit ufMovObleasGNC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, globals, uStockClasses, uStockEstacion, uLogs, ucDialgs,
  StdCtrls, Buttons, RxLookup, ToolEdit, RXDBCtrl, Mask, DBCtrls, DB, SqlExpr,
  ExtCtrls;

type
  TfrmMovObleasGNC = class(TForm)
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
    srcPrepara: TDataSource;
    srcAutoriza: TDataSource;
    Label11: TLabel;
    lcbPrepara: TRxDBLookupCombo;
    Label12: TLabel;
    lcbAutoriza: TRxDBLookupCombo;
    edCanttarjama: TDBEdit;
    edCantetiqgnc: TDBEdit;
    edCantBolsi: TDBEdit;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label8: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    procedure btnSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edCantidadExit(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure lcbOrigenCloseUp(Sender: TObject);
    procedure lcbDestinoCloseUp(Sender: TObject);
    procedure lcbPreparaCloseUp(Sender: TObject);
    procedure lcbAutorizaCloseUp(Sender: TObject);
    procedure edCanttarjamaEnter(Sender: TObject);
    procedure edCantetiqgncEnter(Sender: TObject);
    procedure edCantBolsiEnter(Sender: TObject);
  private
    { Private declarations }
    fMovimiento: tMovimientos;
    fPlanta, fOrigen: tPlantas;
    fPrepara, fAutoriza: tPersonal;
  public
    { Public declarations }
    procedure ActualizarObleas;
    function ValidatePost:boolean;
    function CantidadIgualObleas:boolean;
  end;
  procedure DoMovObleasGNC;

var
  frmMovObleasGNC: TfrmMovObleasGNC;

resourcestring
  FILE_NAME = 'UfMovObleasGNC';
  CAPTION = 'Movimiento de Obleas';

implementation

uses Math, urMovObleasGNC;

{$R *.dfm}

procedure DoMovObleasGNC;
begin
  with TfrmMovObleasGNC.Create(application) do
    try
      showmodal;
    finally
      free;
    end;
end;


procedure TfrmMovObleasGNC.btnSalirClick(Sender: TObject);
begin
  if MyBD.InTransaction then MyBD.Rollback(td);
  close;
end;

procedure TfrmMovObleasGNC.FormCreate(Sender: TObject);
begin
    fOrigen := nil;
    fMovimiento := nil;
    fPlanta := nil;
    fPrepara := nil;
    fAutoriza := nil;

    fOrigen := tPlantas.Create(MYBD);
    fPlanta := tPlantas.CreatePlantas(MYBD);
    fMovimiento := tMovimientos.CreateByRowId(mybd,'');
    fPrepara := tPersonal.Create(mybd);
    fAutoriza := tPersonal.Create(MyBD);

    fOrigen.Open;
    fPlanta.Open;
    fMovimiento.Open;
    fPrepara.Open;
    fAutoriza.Open;
    fMovimiento.Append;

    srcOrigen.DataSet := fOrigen.DataSet;
    srcPlanta.DataSet := fPlanta.DataSet;
    srcMovimiento.DataSet := fMovimiento.DataSet;
    srcPrepara.DataSet := fPrepara.DataSet;
    srcAutoriza.DataSet := fAutoriza.DataSet;

    MyBD.StartTransaction(td);
    
end;

procedure TfrmMovObleasGNC.FormDestroy(Sender: TObject);
begin
    fOrigen.free;
    fMovimiento.free;
    fPlanta.free;
    fPrepara.free;
    fAutoriza.free;
end;

procedure TfrmMovObleasGNC.btnAceptarClick(Sender: TObject);
begin
  try
    if CantidadIgualObleas then
    begin
      if ValidatePost then
      begin
        fMovimiento.ValueByName[FIELD_TIPO] := MOV_TIPO_MOVIMIENTO;
        fMovimiento.Post(true);
        ActualizarObleas;
        MyBD.Commit(td);
        DoRepMovObleasGNC(fMovimiento.ValueByName[FIELD_IDMOVIMIENTO],strtoint(fOrigen.valuebyname[FIELD_IDEMPRESA]));
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

procedure TfrmMovObleasGNC.ActualizarObleas;
//var i:integer;
begin
      with tSqlquery.create(nil) do
       try
           SqlConnection:= MyBD;
//         for i := StrToInt(edObleaInicial.Text) to StrToInt(edObleaFinal.text) do
//         begin
           sql.Clear;
           sql.Add(format('UPDATE OBLEAS SET IDPLANTA = %S, IDMOVIMIENTO = %S WHERE ANO = %S AND NUMERO BETWEEN %S AND %S',[fPlanta.ValueByName[FIELD_IDPLANTA],fMovimiento.ValueByName[FIELD_IDMOVIMIENTO], edano.text,edObleaInicial.Text,edObleaFinal.Text]));
           ExecSQL;
           close;
//         end;
       finally
         free;
       end;
end;

function TfrmMovObleasGNC.ValidatePost: boolean;
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
  if lcbPrepara.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la persona que preparó la entrega',mtError,[mbOK],mbOK,0);
        lcbPrepara.SetFocus;
        exit;
  end;
  if lcbAutoriza.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la persona que autorizó la entrega',mtError,[mbOK],mbOK,0);
        lcbAutoriza.SetFocus;
        exit;
  end;

  if not CantidadIgualObleas then
  begin
        MessageDlg(CAPTION,'El lote de obleas no se encuentra en la planta de origen',mtError,[mbOK],mbOK,0);
        exit;
  end;

  result := true;
end;

procedure TfrmMovObleasGNC.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TfrmMovObleasGNC.edCantidadExit(Sender: TObject);
begin
  if (edObleaInicial.text <> '') AND (edCantidad.Text <> '') then
  begin
    fMovimiento.ValueByName[FIELD_OBLEAFINAL] := inttostr(strtoInt(edObleaInicial.Text)+strToInt(edCantidad.Text)-1);
  end;
end;

procedure TfrmMovObleasGNC.btnCancelarClick(Sender: TObject);
begin
  fMovimiento.Cancel;
  fMovimiento.Append;
end;

procedure TfrmMovObleasGNC.lcbOrigenCloseUp(Sender: TObject);
begin
  lcbOrigen.Value := fOrigen.ValueByName[lcbOrigen.LookUpField];
end;

procedure TfrmMovObleasGNC.lcbDestinoCloseUp(Sender: TObject);
begin
  lcbDestino.Value := fPlanta.ValueByName[lcbDestino.LookUpField];
end;

procedure TfrmMovObleasGNC.lcbPreparaCloseUp(Sender: TObject);
begin
  lcbPrepara.Value := fPrepara.ValueByName[lcbPrepara.LookupField];
end;

procedure TfrmMovObleasGNC.lcbAutorizaCloseUp(Sender: TObject);
begin
  lcbAutoriza.Value := fAutoriza.ValueByName[lcbAutoriza.LookupField];
end;

procedure TfrmMovObleasGNC.edCanttarjamaEnter(Sender: TObject);
begin
  fMovimiento.ValueByName[FIELD_CANTTARJAMA] := edCantidad.Text;
end;

procedure TfrmMovObleasGNC.edCantetiqgncEnter(Sender: TObject);
begin
  fMovimiento.ValueByName[FIELD_CANTETIQGNC] := edCantidad.Text;
end;

procedure TfrmMovObleasGNC.edCantBolsiEnter(Sender: TObject);
begin
  fMovimiento.ValueByName[FIELD_CANTBOLSI] := edCantidad.Text;
end;

function TfrmMovObleasGNC.CantidadIgualObleas: boolean;
begin
  result := false;
  with tSqlquery.Create(nil) do
    try
      SqlConnection := mybd;
      sql.Add(format('SELECT COUNT(*) FROM OBLEAS WHERE ANO = %S AND NUMERO BETWEEN %S AND %S AND IDPLANTA = %S AND ESTADO = ''S''',[edAno.Text,edObleaInicial.Text,edObleaFinal.Text, fOrigen.ValueByName[FIELD_IDPLANTA]]));
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
