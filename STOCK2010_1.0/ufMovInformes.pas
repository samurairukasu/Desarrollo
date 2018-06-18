unit ufMovInformes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, globals, uStockClasses, uStockEstacion, uLogs, ucDialgs,
  StdCtrls, Buttons, RxLookup, ToolEdit, RXDBCtrl, Mask, DBCtrls, DB, SqlExpr,
  ExtCtrls, Menus;

type
  TfrmMovInformes = class(TForm)
    btnSalir: TBitBtn;
    srcOrigen: TDataSource;
    srcPlanta: TDataSource;
    srcMovimiento: TDataSource;
    edinformeinicial: TDBEdit;
    edCantidad: TDBEdit;
    edinformefinal: TDBEdit;
    edFecha: TDBDateEdit;
    lcbOrigen: TRxDBLookupCombo;
    lcbDestino: TRxDBLookupCombo;
    Label1: TLabel;
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
    Label8: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    PopupMenu1: TPopupMenu;
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
    procedure edCantCertifEnter(Sender: TObject);
    procedure edCantBolsiEnter(Sender: TObject);
 //   procedure edCertIniExit(Sender: TObject);
  private
    { Private declarations }
    fMovimiento: tMovimientos_Informe;
    fPlanta, fOrigen: tPlantas;
    fPrepara, fAutoriza: tPersonal;
  public
    { Public declarations }
    function ValidatePost:boolean;
    function ExisteInformes: boolean ;
    procedure DevuelveSecuencia;
    procedure ActualizarInformes;
  end;
  procedure DoMovInformes;

var
  frmMovInformes: TfrmMovInformes;
resourcestring
  FILE_NAME = 'UfMovInformes';
  CAPTION = 'Movimiento de Informes';

implementation

uses Math, urMovInformes;

{$R *.dfm}

procedure DoMovInformes;
begin
  with TfrmMovInformes.Create(application) do
    try
      showmodal;
    finally
      free;
    end;
end;


procedure TfrmMovInformes.btnSalirClick(Sender: TObject);
begin
  if MyBD.InTransaction then MyBD.Rollback(TD);
  close;
end;

procedure TfrmMovInformes.FormCreate(Sender: TObject);
begin
    fOrigen := nil;
    fMovimiento := nil;
    fPlanta := nil;
    fPrepara := nil;
    fAutoriza := nil;

    fOrigen := tPlantas.Create(MYBD);
    fPlanta := tPlantas.CreatePlantas(MYBD);
    fMovimiento := tMovimientos_informe.CreateByRowId(mybd,'');
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

procedure TfrmMovInformes.FormDestroy(Sender: TObject);
begin
    fOrigen.free;
    fMovimiento.free;
    fPlanta.free;
    fPrepara.free;
    fAutoriza.free;
end;

procedure TfrmMovInformes.btnAceptarClick(Sender: TObject);
begin
  try
      if ValidatePost then
      begin
        fMovimiento.ValueByName[FIELD_TIPO] := MOV_TIPO_MOVIMIENTO;
        DevuelveSecuencia;
        ActualizarInformes ;
        fMovimiento.PosT(true);
        MyBD.Commit(td);
        DoRepMovInformes(fMovimiento.ValueByName[FIELD_IDMOVIMIENTO],strtoint(fOrigen.valuebyname[FIELD_IDEMPRESA]));
        MessageDlg(CAPTION,'Movimiento registrado con éxito',mtInformation,[mbOK],mbOK,0);
        fMovimiento.Append;
        MyBD.StartTransaction(td);
      end;

  except
   on E: Exception do
   begin
      MessageDlg(CAPTION,Format('No se ha podido registrar el movimiento por: %s. ',[E.message]), mtError, [mbOk], mbOk, 0);
      MyBD.Rollback(td);
   end;
  end;
end;


function TfrmMovInformes.ValidatePost: boolean;
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

  if edInformeInicial.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar el Nº de informe inicial',mtError,[mbOK],mbOK,0);
        edInformeInicial.SetFocus;
        exit;
  end;
  if edCantidad.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la cantidad de informe',mtError,[mbOK],mbOK,0);
        edCantidad.SetFocus;
        exit;
  end;
 { if lcbOrigen.Text = ''  then
  begin
       MessageDlg(CAPTION,'Se debe ingresar el proveedor de obleas',mtError,[mbOK],mbOK,0);
        lcbOrigen.SetFocus;
       exit;
  end; }
  if lcbDestino.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar el depósito al que ingresaron las informe',mtError,[mbOK],mbOK,0);
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


   // Controlar que los numeros de informes ya no existan en moviemientos_informes  (dentro de los RANGO)
  if edInformeInicial.Text <> ''  then
  begin
       if not ExisteInformes then
        begin
          MessageDlg(CAPTION,'El lote de informes ya ha sido ingresado anteriormente',mtError,[mbOK],mbOK,0);
          exit;
        end;
 end;
  result := true;
end;

procedure TfrmMovInformes.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TfrmMovInformes.edCantidadExit(Sender: TObject);
begin
  if (edInformeInicial.text <> '') AND (edCantidad.Text <> '') then
  begin
    fMovimiento.ValueByName['INFORMEFINAL'] := inttostr(strtoInt(edInformeInicial.Text)+strToInt(edCantidad.Text)-1);
  end;
end;

procedure TfrmMovInformes.btnCancelarClick(Sender: TObject);
begin
  fMovimiento.Cancel;
  fMovimiento.Append;
end;

procedure TfrmMovInformes.lcbOrigenCloseUp(Sender: TObject);
begin
  lcbOrigen.Value := fOrigen.ValueByName[lcbOrigen.LookUpField];
end;

procedure TfrmMovInformes.lcbDestinoCloseUp(Sender: TObject);
begin
  lcbDestino.Value := fPlanta.ValueByName[lcbDestino.LookUpField];
end;

procedure TfrmMovInformes.lcbPreparaCloseUp(Sender: TObject);
begin
  lcbPrepara.Value := fPrepara.ValueByName[lcbPrepara.LookupField];
end;

procedure TfrmMovInformes.lcbAutorizaCloseUp(Sender: TObject);
begin
  lcbAutoriza.Value := fAutoriza.ValueByName[lcbAutoriza.LookupField];
end;

procedure TfrmMovInformes.edCantCertifEnter(Sender: TObject);
begin
  fMovimiento.ValueByName['CANTIDAD'] := edCantidad.Text;
end;

procedure TfrmMovInformes.edCantBolsiEnter(Sender: TObject);
begin
  fMovimiento.ValueByName[FIELD_CANTBOLSI] := edCantidad.Text;
end;

function TfrmMovInformes.ExisteInformes: boolean;
begin
  result := false;
  with tSQLquery.Create(nil) do
    try
      SqlConnection:=MyBD;
      sql.Add('SELECT count(*) FROM mov_informe m  WHERE  cantidad > 0  and tipo=''M''') ; //le saque esto para  que pueda mover de (deposito 2) a la 21
      sql.Add(format( 'AND ((informeinicial BETWEEN %S AND %S ) OR (informefinal BETWEEN %S AND %S))',[edInformeInicial.Text,edInformeFinal.Text,edInformeInicial.Text,edInformeFinal.Text]));
      open;
      if Fields[0].AsInteger > 0 then
      begin
        exit;
      end;
    finally
      free;
    end;
  result := true;
end;



procedure TfrmMovInformes.DevuelveSecuencia;
begin
  if fMovimiento.DataSet.State in [dsinsert, dsedit] then
  begin
      with TSQLQuery.Create(nil) do
       try
         SqlConnection:= MyBD;
         sql.Add('select SQ_MOV_INFORME_IDMOVIMIENTO.nextval from dual');
         open;
         fMovimiento.ValueByName[FIELD_IDMOVIMIENTO]:=inttostr(Fields[0].AsInteger)
       finally
         free;
       end;
  end;
end;

procedure TfrmMovInformes.ActualizarInformes;
begin
     if (edinformeinicial.text <> '')  and (edinformefinal.text <> '')  then
       begin
          with tsqlquery.create(nil) do
          try
            SqlConnection:=MyBD;
            sql.Clear;
            sql.Add(format('UPDATE INFOR_CERTIF SET IDPLANTA = %S, IDMOVIMIENTO = %S , ESTADO =''C'' WHERE ID=''I'' AND  NUMERO BETWEEN %S AND %S',[fPlanta.ValueByName[FIELD_IDPLANTA],fMovimiento.ValueByName[FIELD_IDMOVIMIENTO], edinformeinicial.Text,edinformefinal.Text]));
            ExecSQL;
            close;
          finally
            free;
          end;
     end;
end;

end.
