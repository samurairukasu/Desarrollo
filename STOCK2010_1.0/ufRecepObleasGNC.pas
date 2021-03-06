unit ufRecepObleasGNC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, globals, uStockClasses, uStockEstacion, uLogs, ucDialgs,
  StdCtrls, Buttons, RxLookup, ToolEdit, RXDBCtrl, Mask, DBCtrls, DB, SqlExpr,
  ExtCtrls;

type
  TfrmRecepObleasGNC = class(TForm)
    btnSalir: TBitBtn;
    srcProveedor: TDataSource;
    srcPlanta: TDataSource;
    srcMovimiento: TDataSource;
    edObleaInicial: TDBEdit;
    edAno: TDBEdit;
    edCantidad: TDBEdit;
    edObleaFinal: TDBEdit;
    DBEdit5: TDBEdit;
    edFecha: TDBDateEdit;
    lcbProveedor: TRxDBLookupCombo;
    lcbDeposito: TRxDBLookupCombo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    Bevel1: TBevel;
    procedure btnSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edCantidadExit(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure lcbProveedorCloseUp(Sender: TObject);
    procedure lcbDepositoCloseUp(Sender: TObject);
  private
    { Private declarations }
    fProveedor: tProveedores;
    fMovimiento: tMovimientos;
    fPlanta: tPlantas;
    
  public
    { Public declarations }
    procedure GuardarObleas;
    function ValidatePost:boolean;
  end;
  procedure DoRecepObleasGNC;

var
  frmRecepObleasGNC: TfrmRecepObleasGNC;

resourcestring
  FILE_NAME = 'UfRecepObleasGNC';
  CAPTION = 'Recepci�n de Obleas';

implementation

uses Math;

{$R *.dfm}

procedure DoRecepObleasGNC;
begin
  with TfrmRecepObleasGNC.Create(application) do
    try
      showmodal;
    finally
      free;
    end;
end;


procedure TfrmRecepObleasGNC.btnSalirClick(Sender: TObject);
begin
  if MyBD.InTransaction then MyBD.Rollback(td);
  close;
end;

procedure TfrmRecepObleasGNC.FormCreate(Sender: TObject);
begin
    fProveedor := nil;
    fMovimiento := nil;
    fPlanta := nil;

    fProveedor := tProveedores.Create(MYBD);
    fPlanta := tPlantas.CreateDepositos(MYBD);
    fMovimiento := tMovimientos.CreateByRowId(mybd,'');

    fProveedor.Open;
    fPlanta.Open;
    fMovimiento.Open;
    fMovimiento.Append;

    srcProveedor.DataSet := fProveedor.DataSet;
    srcPlanta.DataSet := fPlanta.DataSet;
    srcMovimiento.DataSet := fMovimiento.DataSet;

    MyBD.StartTransaction(td);
    
end;

procedure TfrmRecepObleasGNC.FormDestroy(Sender: TObject);
begin
    fProveedor.free;
    fMovimiento.free;
    fPlanta.free;
end;

procedure TfrmRecepObleasGNC.btnAceptarClick(Sender: TObject);
begin
  try
    if ValidatePost then
    begin
      fMovimiento.ValueByName[FIELD_TIPO] := MOV_TIPO_ENTRADA;
      fMovimiento.Post(true);
      GuardarObleas;
      MyBD.Commit(td);
      MessageDlg(CAPTION,'Recepci�n registrada con �xito',mtInformation,[mbOK],mbOK,0);
      fMovimiento.Append;
      MyBD.StartTransaction(td);
    end;
  except
   on E: Exception do
   begin
      MessageDlg(CAPTION,Format('No se ha podido registrar la recepci�n por: %s. ',[E.message]), mtError, [mbOk], mbOk, 0);
      MyBD.Rollback(td);
   end;

  end;
end;

procedure TfrmRecepObleasGNC.GuardarObleas;
var i:integer;
begin
      with tsqlquery.create(nil) do
       try
         SqlConnection := MyBD;
         for i := StrToInt(edObleaInicial.Text) to StrToInt(edObleaFinal.text) do
         begin
           sql.Clear;
           sql.Add(format('INSERT INTO OBLEAS VALUES (NEXT_OBLEA, %S, %D, %S, %S, %S, ''S'', SYSDATE, %S, NULL,NULL,NULL)',[edano.text,i, fPlanta.ValueByName[FIELD_IDPLANTA], fProveedor.ValueByName[FIELD_IDPROVEEDOR], fPlanta.ValueByName[FIELD_IDEMPRESA], fMovimiento.ValueByName[FIELD_IDMOVIMIENTO]]));
           ExecSQL;
           close;
         end;
       finally
         free;
       end;
end;

function TfrmRecepObleasGNC.ValidatePost: boolean;
begin
  result := false;
  if edFecha.Date = 0  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la fecha de recepci�n',mtError,[mbOK],mbOK,0);
        edFecha.SetFocus;
        exit;
  end;
  if edAno.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar el a�o de las obleas',mtError,[mbOK],mbOK,0);
        edAno.SetFocus;
        exit;
  end;
  if edObleaInicial.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar el N� de oblea inicial',mtError,[mbOK],mbOK,0);
        edObleaInicial.SetFocus;
        exit;
  end;
  if edCantidad.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la cantidad de obleas',mtError,[mbOK],mbOK,0);
        edCantidad.SetFocus;
        exit;
  end;
  if lcbProveedor.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar el proveedor de obleas',mtError,[mbOK],mbOK,0);
        lcbProveedor.SetFocus;
        exit;
  end;
  if lcbDeposito.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar el dep�sito al que ingresaron las obleas',mtError,[mbOK],mbOK,0);
        lcbDeposito.SetFocus;
        exit;
  end;


  with tSqlquery.Create(nil) do
    try
      SqlConnection := MyBD;
      sql.Add(format('SELECT COUNT(*) FROM OBLEAS WHERE ANO = %S AND NUMERO BETWEEN %S AND %S',[edAno.Text,edObleaInicial.Text,edObleaFinal.Text]));
      open;
      if Fields[0].AsInteger > 0 then
      begin
        MessageDlg(CAPTION,'Est� intentando ingresar obleas que ya existen en el sistema',mtError,[mbOK],mbOK,0);
        exit;
      end;
    finally
      free;
    end;
  result := true;
end;

procedure TfrmRecepObleasGNC.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TfrmRecepObleasGNC.edCantidadExit(Sender: TObject);
begin
  if (edObleaInicial.text <> '') AND (edCantidad.Text <> '') then
  begin
    fMovimiento.ValueByName[FIELD_OBLEAFINAL] := inttostr(strtoInt(edObleaInicial.Text)+strToInt(edCantidad.Text)-1);
  end;
end;

procedure TfrmRecepObleasGNC.btnCancelarClick(Sender: TObject);
begin
  fMovimiento.Cancel;
  fMovimiento.Append;
end;

procedure TfrmRecepObleasGNC.lcbProveedorCloseUp(Sender: TObject);
begin
  lcbProveedor.Value := fProveedor.ValueByName[lcbProveedor.LookUpField];
end;

procedure TfrmRecepObleasGNC.lcbDepositoCloseUp(Sender: TObject);
begin
  lcbDeposito.Value := fPlanta.ValueByName[lcbDeposito.LookUpField];
end;

end.
