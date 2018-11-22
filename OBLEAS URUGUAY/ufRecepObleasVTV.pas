unit ufRecepObleasVTV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, globals, uStockClasses, uStockEstacion, uLogs, ucDialgs,
  StdCtrls, Buttons, RxLookup, ToolEdit, RXDBCtrl, Mask, DBCtrls, DB, SqlExpr,
  ExtCtrls, FMTBcd, DBClient, Provider;

type
  TfrmRecepObleasVTV = class(TForm)
    btnSalir: TBitBtn;
    srcProveedor: TDataSource;
    srcPlanta: TDataSource;
    srcMovimiento: TDataSource;
    edObleaInicial: TDBEdit;
    edAno: TDBEdit;
    edCantidad: TDBEdit;
    edObleaFinal: TDBEdit;
    edNroComprobante: TDBEdit;
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
    SQLDataSet1: TSQLDataSet;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
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
    //fMovimiento: tMovimientos_VTV;  //roto
    fPlanta: tPlantas;
    fMovimiento : TClientDataSet;
  public
    { Public declarations }
    MOVIMIENTO : longint;
    procedure GuardarObleas;
    function ValidatePost:boolean;
  end;
  procedure DoRecepObleasVTV;

var
  frmRecepObleasVTV: TfrmRecepObleasVTV;

resourcestring
  FILE_NAME = 'UfRecepObleasVTV';
  CAPTION = 'Recepción de Obleas';

implementation

uses Math;

{$R *.dfm}

procedure DoRecepObleasVTV;
begin
  with TfrmRecepObleasVTV.Create(application) do
    try
      showmodal;
    finally
      free;
    end;
end;


procedure TfrmRecepObleasVTV.btnSalirClick(Sender: TObject);
begin
  if MyBD.InTransaction then MyBD.Rollback(td);
  close;
end;

procedure TfrmRecepObleasVTV.FormCreate(Sender: TObject);
begin
    fProveedor := nil;
    fMovimiento := nil;
    fPlanta := nil;

    SQLDataSet1.SQLConnection := mybd;
    SQLDataSet1.CommandType := ctQuery;
    SQLDataSet1.GetMetadata := false;
    SQLDataSet1.NoMetadata := true;
    SQLDataSet1.ParamCheck := false;
    DataSetProvider1.DataSet := SQLDataSet1;
    DataSetProvider1.Options := [poIncFieldProps,poAllowCommandText];

    fProveedor := tProveedores.Create(MYBD);
    fPlanta := tPlantas.CreateDepositos(MYBD);
    //fMovimiento := tMovimientos_VTV.CreateByRowId(mybd,''); //roto
    //fMovimiento := tMovimientos_VTV.Create(MYBD); //roto
    //fMovimiento := tMovimientos_VTV.CreateById(MYBD,''); //roto

    fMovimiento := ClientDataSet1.Create(MYBD);

    With fMovimiento do
        Try
            close;
            SetProvider(DataSetProvider1);
            commandtext:='SELECT A.IDMOVIMIENTO,A.FECHA,A.CANTIDAD,A.OBLEAINICIAL,A.ANO,A.OBLEAFINAL, '+
                         'A.IDORIGEN,A.IDDESTINO,A.TIPO,A.ANULADO,A.NROCOMPROBANTE,A.MOTIVO,A.FECHALTA,A.FECHSOLI, '+
                         'A.IDPREPARA,A.IDAUTORIZA,A.CANTCERTIF,A.CANTBOLSI,A.CERTINICIAL,A.CERTFINAL '+
                         'FROM VTV_MOVIMIENTO A';
            //fMovimiento.Open;
    Finally
    end;

    fProveedor.Open;
    fPlanta.Open;
    fMovimiento.Open;
    //fMovimiento.Append;

    srcProveedor.DataSet := fProveedor.DataSet;
    srcPlanta.DataSet := fPlanta.DataSet;
    //srcMovimiento.DataSet := fMovimiento.DataSet; //roto
    srcMovimiento.DataSet:=fMovimiento;

    MyBD.StartTransaction(td);

end;

procedure TfrmRecepObleasVTV.FormDestroy(Sender: TObject);
begin
    fProveedor.free;
    fMovimiento.free;
    fPlanta.free;
end;

procedure TfrmRecepObleasVTV.btnAceptarClick(Sender: TObject);
begin
  try
    if ValidatePost then
    begin
      //fMovimiento.ValueByName[FIELD_TIPO] := MOV_TIPO_ENTRADA;
      fMovimiento.FieldValues[FIELD_TIPO] := MOV_TIPO_ENTRADA;
      //fMovimiento.Post(true);
      GuardarObleas;
      MyBD.Commit(td);
      MessageDlg(CAPTION,'Recepción registrada con éxito',mtInformation,[mbOK],mbOK,0);
      fMovimiento.Append;
      MyBD.StartTransaction(td);
    end;
  except
   on E: Exception do
   begin
      MessageDlg(CAPTION,Format('No se ha podido registrar la recepción por: %s. ',[E.message]), mtError, [mbOk], mbOk, 0);
      MyBD.Rollback(td);
   end;

  end;
end;

procedure TfrmRecepObleasVTV.GuardarObleas;
var i,planta,MOVIMIENTO:integer;
sqloracle_mov,sqloracle,TIPO,Comprobante:string;
begin

    //GENERO EL CODIGO DE MOVIMIENTO
     with tsqlQuery.Create(nil) do
       try
          SQLConnection:= MYBD;
          SQL.Add('select SQ_MOVIMIENTOS_IDMOVIMIENTO.nextval from DUAL');
          Open;
          MOVIMIENTO:=fields[0].ASInteger;
       finally
        close;
         free;
       end;

planta := strtoint(fPlanta.ValueByName[FIELD_IDPLANTA]);
TIPO := MOV_TIPO_ENTRADA;
Comprobante:=TRIM(edNroComprobante.Text);

     with tSqlquery.Create(nil) do
       try
         SQLConnection:= MyBD;
           sql.Clear;
           //for testing only
           //sqloracle_mov:=(format('INSERT INTO VTV_MOVIMIENTO VALUES (SQ_MOVIMIENTOS_IDMOVIMIENTO.nextval, SYSDATE, %S, %S, %S, %S, %S, NULL, ''E'', NULL, %S, NULL, SYSDATE)',[StrToInt(edCantidad.Text), StrToInt(edObleaInicial.Text), StrToInt(edano.Text), StrToInt(edObleaFinal.Text), fPlanta.ValueByName[FIELD_IDPLANTA], StrToInt(edNroComprobante.Text)] ));

           sqloracle_mov := 'INSERT INTO VTV_MOVIMIENTO (IDMOVIMIENTO,FECHA,CANTIDAD,OBLEAINICIAL,ANO,OBLEAFINAL,IDORIGEN,TIPO,NROCOMPROBANTE,FECHALTA) ' +
                            ' VALUES ( '+
                            ' '+IntToSTR(MOVIMIENTO)+' '+
                            ',SYSDATE '+
                            ','+#39+TRIM(edCantidad.Text)+#39+' '+
                            ','+#39+TRIM(edObleaInicial.Text)+#39+' '+
                            ','+#39+TRIM(edano.Text)+#39+' '+
                            ','+#39+TRIM(edObleaFinal.Text)+#39+' '+
                            ','+IntToSTR(planta)+' '+
                            ','+#39+TRIM(TIPO)+#39+' '+
                            ','+#39+TRIM(Comprobante)+#39+' '+
                            ',SYSDATE '+  
                            ')';
           SQL.Add(sqloracle_mov);
           //-------------------//
           ExecSQL;
       finally
         close;
         free;
       end;

     with tSqlquery.Create(nil) do
       try
         SQLConnection:= MyBD;
         for i := StrToInt(edObleaInicial.Text) to StrToInt(edObleaFinal.text) do
         begin
           sql.Clear;
           //sql.Add(format('INSERT INTO VTV_OBLEAS VALUES (NEXT_OBLEA, %S, %D, %S, %S, %S, ''S'', SYSDATE, %S, NULL,NULL,NULL,NULL)',[edano.text,i, fPlanta.ValueByName[FIELD_IDPLANTA], fProveedor.ValueByName[FIELD_IDPROVEEDOR], fPlanta.ValueByName[FIELD_IDEMPRESA], fMovimiento.ValueByName[FIELD_IDMOVIMIENTO] ]));

           //for testing only
           //sqloracle:=(format('INSERT INTO VTV_OBLEAS VALUES (NEXT_OBLEA, %S, %D, %S, %S, %S, ''S'', SYSDATE, %S, NULL,NULL,NULL,NULL)',[edano.text,i, fPlanta.ValueByName[FIELD_IDPLANTA], fProveedor.ValueByName[FIELD_IDPROVEEDOR], fPlanta.ValueByName[FIELD_IDEMPRESA], fMovimiento.FieldValues[FIELD_IDMOVIMIENTO] ] ));
           //sqloracle:=(format('INSERT INTO VTV_OBLEAS VALUES (NEXT_OBLEA, %S, %D, %S, %S, %S, ''S'', SYSDATE, %S, NULL,NULL,NULL,NULL)',[edano.text,i, fPlanta.ValueByName[FIELD_IDPLANTA], fProveedor.ValueByName[FIELD_IDPROVEEDOR], fPlanta.ValueByName[FIELD_IDEMPRESA], fMovimiento.ValueByName[FIELD_IDMOVIMIENTO] ] ));

           sqloracle := 'INSERT INTO VTV_OBLEAS (IDOBLEA,ANO,NUMERO,IDPLANTA,IDPROVEEDOR,IDEMPRESAORIGEN,ESTADO,FECHALTA,IDMOVIMIENTO) ' +
                        ' VALUES ( NEXT_OBLEA'+
                        ','+#39+TRIM(edano.Text)+#39+' '+
                        ','+IntToSTR(i)+' '+
                        ','+IntToSTR(planta)+' '+
                        ','+fProveedor.ValueByName[FIELD_IDPROVEEDOR]+' '+
                        ','+fPlanta.ValueByName[FIELD_IDEMPRESA]+' '+
                        ',''S'' '+
                        ',SYSDATE '+
                        ','+IntToSTR(MOVIMIENTO)+' '+      
                        ')';
           SQL.Add(sqloracle);
           //-------------------//

           ExecSQL;
           close;
         end;
       finally
         free;
       end;
end;

function TfrmRecepObleasVTV.ValidatePost: boolean;
begin
  result := false;
  if edFecha.Date = 0  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la fecha de recepción',mtError,[mbOK],mbOK,0);
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
  if lcbProveedor.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar el proveedor de obleas',mtError,[mbOK],mbOK,0);
        lcbProveedor.SetFocus;
        exit;
  end;
  if lcbDeposito.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar el depósito al que ingresaron las obleas',mtError,[mbOK],mbOK,0);
        lcbDeposito.SetFocus;
        exit;
  end;


  with tSqlquery.Create(nil) do
    try
      SqlConnection:=Mybd;
      sql.Add(format('SELECT COUNT(IDOBLEA) FROM VTV_OBLEAS WHERE IDPLANTA = 1 AND ANO = %S AND NUMERO BETWEEN %S AND %S',[edAno.Text,edObleaInicial.Text,edObleaFinal.Text]));
      open;
      if Fields[0].AsInteger > 0 then
      begin
        MessageDlg(CAPTION,'Está intentando ingresar obleas que ya existen en el sistema',mtError,[mbOK],mbOK,0);
        exit;
      end;
    finally
      free;
    end;
  result := true;
end;

procedure TfrmRecepObleasVTV.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TfrmRecepObleasVTV.edCantidadExit(Sender: TObject);
begin
  if (edObleaInicial.text <> '') AND (edCantidad.Text <> '') then
  begin
    //fMovimiento.ValueByName[FIELD_OBLEAFINAL] := inttostr(strtoInt(edObleaInicial.Text)+strToInt(edCantidad.Text)-1);
    fMovimiento.FieldByName(FIELD_OBLEAFINAL).AsString := inttostr(strtoInt(edObleaInicial.Text)+strToInt(edCantidad.Text)-1);
  end;
end;

procedure TfrmRecepObleasVTV.btnCancelarClick(Sender: TObject);
begin
  fMovimiento.Cancel;
  fMovimiento.Append;
end;

procedure TfrmRecepObleasVTV.lcbProveedorCloseUp(Sender: TObject);
begin
  lcbProveedor.Value := fProveedor.ValueByName[lcbProveedor.LookUpField];
end;

procedure TfrmRecepObleasVTV.lcbDepositoCloseUp(Sender: TObject);
begin
  lcbDeposito.Value := fPlanta.ValueByName[lcbDeposito.LookUpField];
end;

end.
