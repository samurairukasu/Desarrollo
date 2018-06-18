unit UFSearchInspector;
{ Unidad encargada de la Búsqueda de un Inspector dado su Número o Nombre
  en la tabla TREVISOR }

{
  Ultima Traza: 8
  Ultima Incidencia:
  Ultima Anomalia: 5
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, DBCtrls, Db, UCTINSPECTORES,
  UCEdit, FMTBcd, SqlExpr, DBXpress, DBClient, SimpleDS, Grids, DBGrids,
  Mask, AppEvnts;

type
  TfrmBusquedaInspector = class(TForm)
    Bevel1: TBevel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    lblNumeroInspector: TLabel;
    DBGrid: TDBGrid;
    DataSource1: TDataSource;
    sdsInspector: TSimpleDataSet;
    DBNombre: TDBEdit;
    BitBtn1: TBitBtn;
    Bevel2: TBevel;
    CheckBox1: TCheckBox;
    lblPassword: TLabel;
    DBClave1: TDBEdit;
    lblPassword2: TLabel;
    DBClave2: TEdit;
    Label1: TLabel;
    DBAPELLIDO: TDBEdit;
    qryConsultas: TSQLQuery;
    CbInspectorActivo: TCheckBox;
    CBSuperUser: TCheckBox;
    ApplicationEvents: TApplicationEvents;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumeroInspectorKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelarClick(Sender: TObject);
    procedure sdsInspectorAfterPost(DataSet: TDataSet);
    procedure btnAceptarClick(Sender: TObject);
    Function ClavesIguales(Clave1, Clave2: String): boolean;
    Function SuperUsuario(DBCheck: TDBCheckBox; Valor: Boolean): Char;
    procedure CheckBox1Click(Sender: TObject);

    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sdsInspectorBeforeScroll(DataSet: TDataSet);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    Function CampoExiste(iCampo: String): Boolean;
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure DBClave2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  frmBusquedaInspector: TfrmBusquedaInspector;
  Function Encriptar(Clave: String; Planta:Integer): String;

implementation

{$R *.DFM}

uses
   UFNEWINSPECTOR,
   UCDIALGS,
   ULOGS,
   GLOBALS,
   USAGESTACION,
   UFPrintInspectors,
   UFTMP,
   USAGVARIOS,
   UUTILS;


resourcestring
      FICHERO_ACTUAL = 'UFSearchInspector';
      CABECERA_MENSAJES_BINSP = 'Búsqueda inspector';

      { Mensajes enviados desde BInspect }
      MSJ_BINSPECT_NUMINC = 'El número de revisor introducido es incorrecto o no se ha introducido. Por favor, introdúzcalo de nuevo.';
      MSJ_BINSPECT_NOMINC = 'El nombre de revisor introducido es incorrecto o no se ha introducido. Por favor, introdúzcalo de nuevo.';
      MSJ_FRMINSP_NUMNOEX = 'El número de inspector introducido no se encuentra almacenado';
      MSJ_FRMINSP_NOMNOEX = 'El nombre de inspector introducido no se encuentra almacenado';


Function TfrmBusquedaInspector.CampoExiste(iCampo: String): Boolean;
var
QueryE: TSQLQuery;
Campo: TField;
Begin
Result:=True;
QueryE:=TSQLQuery.Create(application);
  With QueryE do
    try
      SQLConnection:=MyBD;
      SQL.Add('SELECT * FROM TREVISOR');
      Open;
      Campo:= FindField(iCampo);
      if Campo = nil then
        Result:=False;
   finally
    free;
   end;
end;


Function Encriptar(Clave: String; Planta:Integer): String;
Const
Max = 4;
var
VECT1, VECT2: Array[1..10] of longint;
A,B,C,V,LEN: Integer;
Begin
LEN:=length(Clave);
  try
    For A:=1 To LEN Do
      VECT1[A]:= ord(Clave[A]);
    For B:=1 To LEN Do
      VECT2[B]:= ( B + PLANTA MOD 32);
    For C:=1 to LEN do
      Begin
      V:=(VECT1[C] XOR VECT2[C]);
      Result:=Result+chr(V);
      end;
  finally
  end;
end;


procedure TfrmBusquedaInspector.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
   if Key = Chr(VK_RETURN) then
   begin
       Perform (WM_NEXTDLGCTL, 0, 0);
       Key := #0;
   end;
end;


Function TfrmBusquedaInspector.SuperUsuario(DBCheck: TDBCheckBox; Valor: Boolean): Char;
begin
if DBCheck.Checked then
  Result:= 'S'
else
  Result:= 'N';
end;


Function TfrmBusquedaInspector.ClavesIguales(Clave1, Clave2: String): boolean;
Begin
Result:=false;
if (DBClave1.Text = DBClave2.Text) then
  Result:=true
end;

  
procedure TfrmBusquedaInspector.edtNumeroInspectorKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (((Key < '0') or (Key > '9')) and (Key <> #8)) then
  Key := #0
end;


procedure TfrmBusquedaInspector.btnCancelarClick(Sender: TObject);
begin
CLose;
end;


procedure TfrmBusquedaInspector.sdsInspectorAfterPost(DataSet: TDataSet);
begin
sdsInspector.ApplyUpdates(0);
end;


procedure TfrmBusquedaInspector.btnAceptarClick(Sender: TObject);
Var
Error: Boolean;
begin
Error:=true;
With sdsInspector do
  Begin
  Edit;
////////////////////////////////////////////////////////////////////////////////////////////////////
  if CampoExiste('ACTIVO') then
    Begin
      FieldByName('NOMREVIS').Value:=DBNombre.Text;
      FieldByName('APPEREVIS').Value:=DBAPELLIDO.Text;
      if CbInspectorActivo.Checked then
        FieldByName('ACTIVO').AsString:= 'S'
      else
        FieldByName('ACTIVO').AsString:= 'N';
    end
////////////////////////////////////////////////////////////////////////////////////////////////////

  else
    FieldByName('NOMREVIS').Value:=DBNombre.Text+' '+DBAPELLIDO.Text;

  if CBSuperUser.Checked then
    FieldByName('ESSUPERV').AsString:= 'S'
  else
    FieldByName('ESSUPERV').AsString:= 'N';

  if CheckBox1.Checked then
    Begin
      if (DBClave1.Text <> '') and ClavesIguales(DBClave1.Text,DBClave2.Text) then
        Begin
          FieldByName('PALCLAVE').Value:=Encriptar(DBClave1.Text, DBGrid.Fields[0].AsInteger);
          Error:=true;
        end
      else
        Begin
          MessageDlg('Error','Las claves ingresadas no son iguales!.', mtError, [mbOK],mbOK, 0);
          Error:=false;
        end;
    end;
  if Error then
    Begin
      Post;
      MessageDlg('Modificacion','Los datos se han modificado con exito!', mtInformation, [mbOK], mbOK, 0);
      CheckBox1.Checked:=false;
      DBClave2.Text:='';
    end
  else
    Cancel;
  end;
end;


procedure TfrmBusquedaInspector.CheckBox1Click(Sender: TObject);
begin
if CheckBox1.Checked then
    Begin
    DBClave1.Enabled:=true;
    DBClave2.Enabled:=true;
    lblPassword.Enabled:=true;
    lblPassword2.Enabled:=true;
    end
  else
    Begin
    DBClave1.Enabled:=false;
    DBClave2.Enabled:=false;
    lblPassword.Enabled:=false;
    lblPassword2.Enabled:=false;
  end;
end;


procedure TfrmBusquedaInspector.BitBtn1Click(Sender: TObject);
var
aFTmp: TFTmp;
frmListadoInspectores_Auxi: TfrmListadoInspectores;
begin
aFTmp := TFTmp.Create (Application);
Self.Enabled := False;
  try
  aFTmp.MuestraClock('Impresión', 'Preparando listado de inspectores');
  frmListadoInspectores_Auxi := TfrmListadoInspectores.Create(Application);
    try
    if ImpresoraPreparada_ImprimirInformes then
      begin
        FrmListadoInspectores_Auxi.SeleccionarInspectores;
        frmListadoInspectores_Auxi.QRInspectores.Preview;
      end
    else
      begin
        aFTmp.Hide;
        Lanzar_ErrorImpresion_Mantenimiento;
      end;
    finally
      frmListadoInspectores_Auxi.Free;
    end;
  finally
    Self.Enabled := True;
    Self.Show;
    aFTmp.Free;
  end;
end;


procedure TfrmBusquedaInspector.FormCreate(Sender: TObject);
begin
if not CampoExiste('ACTIVO') then
  Begin
    DBApellido.Destroy;
    DBGrid.Columns.Delete(2);
    DBGrid.Columns.Delete(2);
    DBGrid.Columns.Items[1].Width:=369;
  end;
With sdsInspector do
  try
    Connection:=MyBD;
    DataSet.CommandText:='select * from TREVISOR order by NUMREVIS desc';
    Open;
  except
    on E:Exception do
     ShowMessage('Exception', 'Se a producido un error con el CAMPOEXISTE');
  end;
end;


procedure TfrmBusquedaInspector.sdsInspectorBeforeScroll(
  DataSet: TDataSet);
begin
If CampoExiste('ACTIVO') Then
  Begin
  if (DataSet.FieldByName('ACTIVO').AsString = 'S') then
    CbInspectorActivo.Checked:= true
  else
    CbInspectorActivo.Checked:= False;
  if (DataSet.FieldByName('ESSUPERV').AsString = 'S') then
    CBSuperUser.Checked:= true
  else
  CBSuperUser.Checked:= False;
  end;
end;


procedure TfrmBusquedaInspector.DBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  Num: Integer;
  R: TRect;
begin
Num:=TStringGrid(DBGrid).Row;
R:=TStringGrid(DBGrid).CellRect(DataCol,Num);
if R.Top=Rect.Top then
  With DBGrid do
  if (not sdsInspector.IsEmpty) then
    begin
      if (gdFocused in State) then
        Canvas.brush.Color:=$000065FC
      else
        Canvas.Brush.Color:=$000065FC;
    end;
DBGrid.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;


procedure TfrmBusquedaInspector.ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
var
i: SmallInt;
begin
   if Msg.message = WM_MOUSEWHEEL then
   begin
     Msg.message := WM_KEYDOWN;
     Msg.lParam := 0;
     i := HiWord(Msg.wParam) ;
     if i > 0 then
       Msg.wParam := VK_UP
     else
       Msg.wParam := VK_DOWN;
     Handled := False;
   end;
end;


procedure TfrmBusquedaInspector.DBClave2Change(Sender: TObject);
begin
  If (Length(DBClave1.Text)<4) then
    Begin
      MessageDlg ('Modificacion de Clave', 'La password no puede ser menor a 4 digitos', mtInformation, [mbOk], mbOk, 0);
      DBClave1.SetFocus;
    end;
end;

end.
