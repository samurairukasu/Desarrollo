unit ufEmailCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, globals, uStockClasses, uStockEstacion, uLogs, ucDialgs,
  StdCtrls, Buttons, RxLookup, ToolEdit, RXDBCtrl, Mask, DBCtrls, DB, SqlExpr,
  ExtCtrls;

type
  TfrmEmailCliente = class(TForm)
    btnSalir: TBitBtn;
    srcProveedor: TDataSource;
    srcPlanta: TDataSource;
    srcMovimiento: TDataSource;
    lcbProveedor: TRxDBLookupCombo;
    lcbDeposito: TRxDBLookupCombo;
    Label1: TLabel;
    LbTipo: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    Bevel1: TBevel;
    cbtipo: TComboBox;
    srcMovimiento_informe: TDataSource;
    edFecha: TDateEdit;
    edNroInicial: TEdit;
    edcantidad: TEdit;
    ednrofinal: TEdit;
    ednrocomprobante: TEdit;
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
    fMovimiento: tMovimientos_VTV;
    fMovimiento_informe: tMovimientos_informe ;
    fPlanta: tPlantas;
  public
    { Public declarations }
    procedure GuardarDatos;
    function ValidatePost:boolean;
  end;
  procedure DoEmailCliente;

var
  frmEmailCliente: TfrmEmailCliente;

resourcestring
  FILE_NAME = 'UfEmailCliente';
  CAPTION = 'DATOS CLIENTES -EMAIL-';

implementation

uses Math;

{$R *.dfm}

procedure DoEmailCliente;
begin
  with TfrmEmailCliente.Create(application) do
    try
      showmodal;
    finally
      free;
    end;
end;


procedure TfrmEmailCliente.btnSalirClick(Sender: TObject);
begin
  if MyBD.InTransaction then MyBD.Rollback(td);
  close;
end;

procedure TfrmEmailCliente.FormCreate(Sender: TObject);
begin
    fProveedor := nil;
    fMovimiento := nil;
    fMovimiento_informe := nil;
    fPlanta := nil;

    fProveedor := tProveedores.Create(MYBD);
    fPlanta := tPlantas.CreateDepositos(MYBD);
    fMovimiento := tMovimientos_VTV.CreateByRowId(mybd,'');
    fMovimiento_informe :=tMovimientos_Informe.CreateByRowId(mybd,'');

    fProveedor.Open;
    fPlanta.Open;


    srcProveedor.DataSet := fProveedor.DataSet;
    srcPlanta.DataSet := fPlanta.DataSet;
  //  srcMovimiento.DataSet := fMovimiento.DataSet;
   // srcMovimiento_informe.DataSet := fMovimiento_informe.DataSet;

    MyBD.StartTransaction(td);

end;

procedure TfrmEmailCliente.FormDestroy(Sender: TObject);
begin
    fProveedor.free;
     if cbtipo.Text='C' then
      fMovimiento.free
    else
      fMovimiento_informe.free;
    fPlanta.free;
end;

procedure TfrmEmailCliente.btnAceptarClick(Sender: TObject);
begin
  try
    if ValidatePost then
    begin
      if cbtipo.Text='I' then
        begin
          fMovimiento_informe.Open;
          fMovimiento_informe.Append;
          if fMovimiento_informe.DataSet.State in [dsinsert, dsedit] then
            begin
              with TsqlQuery.Create(nil) do
                try
                  SqlConnection:=MyBD;
                  sql.Add('select SQ_MOV_INFORME_IDMOVIMIENTO.nextval from dual');
                  open;
                  fMovimiento_informe.ValueByName[FIELD_IDMOVIMIENTO]:=inttostr(Fields[0].AsInteger)
              finally
                free;
              end;
            end;
          fMovimiento_informe.ValueByName['INFORMEINICIAL'] := edNroInicial.Text;
          fMovimiento_informe.ValueByName['INFORMEFINAL'] := edNroFinal.text;
          fMovimiento_informe.ValueByName['CANTIDAD'] := edCantidad.Text;
          fMovimiento_informe.ValueByName['FECHA'] := edFecha.text;
          fMovimiento_informe.ValueByName['IDORIGEN'] := lcbProveedor.Value;
          fMovimiento_informe.ValueByName['IDDESTINO'] := lcbDeposito.value;
          fMovimiento_informe.ValueByName['NROCOMPROBANTE'] := edNroComprobante.text;
          fmovimiento_informe.ValueByName[FIELD_TIPO] := MOV_TIPO_ENTRADA;
          fMovimiento_informe.Post(true);
        end
      else
        begin
          fMovimiento.Open;
          fMovimiento.Append;
        {  if fMovimiento.DataSet.State in [dsinsert, dsedit] then
            begin
              with TQuery.Create(nil) do
                try
                  DatabaseName := mybd.DatabaseName;
                  SessionName := MyBD.SessionName;
                  sql.Add('select SQ_VTV_MOVIMIENTO_IDMOVIMIENTO.nextval from dual');
                  open;
                  fMovimiento.ValueByName[FIELD_IDMOVIMIENTO]:=inttostr(Fields[0].AsInteger)
              finally
                free;
              end;
            end;  }
          fMovimiento.ValueByName['CERTINICIAL'] := edNroInicial.Text;
          fMovimiento.ValueByName['CERTFINAL'] := edNroFinal.text;
          fMovimiento.ValueByName['CANTCERTIF'] := edCantidad.Text;
          fMovimiento.ValueByName['FECHA'] := edFecha.text;
          fMovimiento.ValueByName['IDORIGEN'] := lcbProveedor.VALUE;
          fMovimiento.ValueByName['IDDESTINO'] := lcbDeposito.value;
          fMovimiento.ValueByName['NROCOMPROBANTE'] := edNroComprobante.text;
          fMovimiento.ValueByName[FIELD_TIPO] := MOV_TIPO_ENTRADA;
          fMovimiento.Post(true);
        end;


      GuardarDatos;
      MyBD.Commit(td);
      MessageDlg(CAPTION,'Recepci�n registrada con �xito',mtInformation,[mbOK],mbOK,0);
      IF CBTipo.Text='I' then
        fMovimiento_informe.Append
      ELSE
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

procedure TfrmEmailCliente.GuardarDatos;
var i:integer;
begin
      with tSqlquery.create(nil) do
       try
         SqlConnection:=MyBD;
         for i := StrToInt(ednroInicial.Text) to StrToInt(ednroFinal.text) do
         begin
           sql.Clear;
           if  CBTIPO.Text = 'I' then
            sql.Add(format('INSERT INTO INFOR_CERTIF VALUES (''%S'',%D,%S,%S,%S,''S'', SYSDATE,%S, NULL,NULL,NULL,NULL)',[CBTIPO.TEXT,i,fPlanta.ValueByName[FIELD_IDPLANTA], fProveedor.ValueByName[FIELD_IDPROVEEDOR], fPlanta.ValueByName[FIELD_IDEMPRESA], fMovimiento_informe.ValueByName[FIELD_IDMOVIMIENTO]]))
           else
             sql.Add(format('INSERT INTO INFOR_CERTIF VALUES (''%S'',%D,%S,%S,%S,''S'', SYSDATE,%S, NULL,NULL,NULL,NULL)',[CBTIPO.TEXT,i,fPlanta.ValueByName[FIELD_IDPLANTA], fProveedor.ValueByName[FIELD_IDPROVEEDOR], fPlanta.ValueByName[FIELD_IDEMPRESA], fMovimiento.ValueByName[FIELD_IDMOVIMIENTO]]));
          ///sql.Add(format('INSERT INTO INFOR_CERTIF VALUES (''%S'', %S,%S, %S, %S,''S'', SYSDATE, %S, NULL,NULL,NULL,NULL)',['S',i, fPlanta.ValueByName[FIELD_IDPLANTA], fProveedor.ValueByName[FIELD_IDPROVEEDOR], fPlanta.ValueByName[FIELD_IDEMPRESA], fMovimiento_informe.ValueByName[FIELD_IDMOVIMIENTO]]));
           ExecSQL;
           close;
         end;
       finally
         free;
       end;
end;

function TfrmEmailCliente.ValidatePost: boolean;
begin
  result := false;
  if edFecha.Date = 0  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la fecha de recepci�n',mtError,[mbOK],mbOK,0);
        edFecha.SetFocus;
        exit;
  end;
  if cbtipo.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar el tipo de documento:  Certificado ''C'' o Informe de Inspecci�n ''I'' ',mtError,[mbOK],mbOK,0);
        cbtipo.SetFocus;
        exit;
  end;
  if edNroInicial.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar el N�inicial',mtError,[mbOK],mbOK,0);
        edNroInicial.SetFocus;
        exit;
  end;
  if edCantidad.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la cantidad ',mtError,[mbOK],mbOK,0);
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
        MessageDlg(CAPTION,'Se debe ingresar el dep�sito al que ingresaron.',mtError,[mbOK],mbOK,0);
        lcbDeposito.SetFocus;
        exit;
  end;


  with tSqlquery.Create(nil) do
    try
      SqlConnection:=MyBD;
      sql.Add(format('SELECT COUNT(NUMERO) FROM INFOR_CERTIF WHERE  ID= ''%S'' AND NUMERO BETWEEN %S AND %S ',[cbtipo.text,edNroInicial.Text,edNroFinal.Text]));
      open;
      if Fields[0].AsInteger > 0 then
      begin
        MessageDlg(CAPTION,'Est� intentando ingresar Certificados o Informes  que ya existen en el sistema',mtError,[mbOK],mbOK,0);
        exit;
      end;
    finally
      free;
    end;
  result := true;
end;

procedure TfrmEmailCliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TfrmEmailCliente.edCantidadExit(Sender: TObject);
begin
  if (edNroInicial.text <> '') AND (edCantidad.Text <> '') then
  begin
    edNroFinal.Text := inttostr(strtoInt(edNroInicial.Text)+strToInt(edCantidad.Text)-1);
  end;
end;

procedure TfrmEmailCliente.btnCancelarClick(Sender: TObject);
begin
  fMovimiento.Cancel;
  fMovimiento.Append;
  fMovimiento_informe.Cancel;
  fMovimiento_informe.Append;
end;

procedure TfrmEmailCliente.lcbProveedorCloseUp(Sender: TObject);
begin
  lcbProveedor.Value := fProveedor.ValueByName[lcbProveedor.LookUpField];
end;

procedure TfrmEmailCliente.lcbDepositoCloseUp(Sender: TObject);
begin
  lcbDeposito.Value := fPlanta.ValueByName[lcbDeposito.LookUpField];
end;
end.