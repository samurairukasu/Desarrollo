unit ufOblAnuladGNC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, SQLExpr, Mask, ToolEdit, ucdialgs, ExtCtrls, globals, uSagClasses,
  uSagEstacion, UtilOracle, RXLookup;

const WM_SEGUIRANUL=WM_USER+2;

type
  TfmOblAnulGNC = class(TForm)
    Label1: TLabel;
    ednumoblea: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edmotivo: TEdit;
    btnaceptar: TBitBtn;
    btneliminar: TBitBtn;
    btnsalir: TBitBtn;
    defecha: TDateEdit;
    Bevel1: TBevel;
    cbautorizo: TRxDBLookupCombo;
    srcUsuario: TDataSource;
    edAnoOblea: TEdit;
    Label5: TLabel;
    procedure btneliminarClick(Sender: TObject);
    procedure btnaceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ednumobleaKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
     fObleasAnuladasGNC : TObleasAnuladasGNC;
     fUsuario : TUsuarios;
     procedure RegistObleaDeVehicDesconocido(var Msge:TMessage); message WM_SEGUIRANUL;
     function datoscompletos:boolean;
  public
    { Public declarations }
  end;
  procedure DoObleaAnuladaGNC;

const RegistrarOblea:boolean = true;

var
  fmOblAnulGNC: TfmOblAnulGNC;

implementation

{$R *.DFM}

uses
  uftmp;

procedure DoObleaAnuladaGNC;
begin
  with TfmOblAnulGNC.Create(Application.MainForm) do
         try
            ShowModal;
         finally
            Free;
         end;
end;

procedure TfmOblAnulGNC.RegistObleaDeVehicDesconocido(var Msge:TMessage);
begin
  // if Msge.Msg=0 then
    //  RegistrarOblea:=true;
  // if Msge.WParam=1 then
     // RegistrarOblea:=false;
end;

procedure TfmOblAnulGNC.btneliminarClick(Sender: TObject);
begin
   btnaceptar.Enabled:=false;
   btnsalir.Enabled:=false;
   if MessageDlg(caption,'�Esta seguro que desea eliminar?',mtConfirmation,[mbYes,mbNo],mbyes,0)=mrYes then
      with TSQLQuery.Create(NIL) do
         try
            SQLConnection := mybd;
            SQL.Add('DELETE FROM ANULADAS_GNC WHERE NUMOBLEA=:NUMOBLEA AND ANIO = :ANIO');
            ParamByName('NUMOBLEA').AsString:=ednumoblea.Text;
            ParamByName('ANIO').Asstring:=edAnoOblea.text;
            ExecSQL;
            ednumoblea.Clear;
            edmotivo.Clear;
            defecha.Date:=Date;
         finally
            Close;
            Free;
         end;
   btnaceptar.Enabled:=true;
   btnsalir.Enabled:=true;
end;

procedure TfmOblAnulGNC.btnaceptarClick(Sender: TObject);
var ID:integer;
    FBusqueda: TFTmp;
label l1;
begin
  fbusqueda:= TFTmp.create(application);
  with fbusqueda do
  try
   muestraclock('Anular Obleas','Procesando anulaci�n de oblea');
   if datoscompletos then
   begin
     btneliminar.Enabled:=false;
     btnsalir.Enabled:=false;
     ID:=0;
     with TSQLQuery.Create(self) do
      try
        SQLConnection := MYBD;
         sql.add('alter session set nls_date_format = ''dd/mm/yyyy''');
         execsql;
         close;
         sql.clear;
         SQL.Add('SELECT CODINSPGNC FROM INSPGNC WHERE OBLEANUEVA=:OBLEA');
         ParamByName('OBLEA').AsString:=ednumoblea.Text;
         Open;
         //if (not IsEmpty) and (not Fields[0].AsInteger=0) then
           // if MessageDlg(caption,'Oblea utilizada.�Esta Ud seguro que desea seguir?',mtConfirmation,[mbYes,mbNo],mbyes,0)=mrYes then
               //RegistrarOblea:=true
           // else RegistrarOblea:=false;
         if RegistrarOblea then begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT CODANULAC FROM ANULADAS_GNC WHERE NUMOBLEA=:OBLEA');
            ParamByName('OBLEA').AsString:=ednumoblea.Text;
            Open;
            if (IsEmpty) or (Fields[0].AsInteger=0) then begin
               fObleasAnuladasGNC := TObleasAnuladasGNC.CreateByRowId(mybd,'');
               fObleasAnuladasGNC.Open;
               fObleasAnuladasGNC.Append;
               fObleasAnuladasGNC.ValueByName[FIELD_FECHA] := datetimebd(mybd);
               fObleasAnuladasGNC.ValueByName[FIELD_NUMOBLEA] := ednumoblea.Text;
               fObleasAnuladasGNC.ValueByName[FIELD_MOTIVO] := edmotivo.Text;
               fObleasAnuladasGNC.ValueByName[FIELD_AUTORIZO] := cbautorizo.Value;
               fObleasAnuladasGNC.ValueByName[FIELD_ANIO] := edAnoOblea.Text;
               fObleasAnuladasGNC.Post(true);
               messagedlg(caption,'Proceso Realizado con Exito',mtInformation,[mbOK],mbOK,0);
            end else
              messagedlg(caption,'Oblea Ya Registrada',mtInformation,[mbOK],mbOK,0);
         end;
      finally
         Close;
         Free;
      end;
     btneliminar.Enabled:=true;
     btnsalir.Enabled:=true;
     ednumoblea.SetFocus;
   end;
  finally
    free;
  end;
end;

procedure TfmOblAnulGNC.FormCreate(Sender: TObject);
begin
   defecha.Date:=Date;
   fUsuario := TUsuarios.CreateFromDataBase(mybd,DATOS_USUARIO,'');
   fUsuario.Open;
   srcUsuario.DataSet := fUsuario.DataSet;
end;

procedure TfmOblAnulGNC.ednumobleaKeyPress(Sender: TObject; var Key: Char);
begin
        if not (Key in ['0','1','2','3','4','5','6','7','8','9',char(VK_BACK)])
        then key := #0
end;

procedure TfmOblAnulGNC.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key=#13 then begin
      Perform(WM_NEXTDLGCTL,0,0);
      Key:=#0;
   end;
end;

function TfmOblAnulGNC.datoscompletos:boolean;
begin
  result:=false;
  if edAnoOblea.text = '' then
  begin
    messagedlg(caption,'Se debe ingresar el a�o de la oblea a anular',mtError,[mbOK],mbOK,0);
    edAnoOblea.setfocus;
    exit;
  end;

  if ednumoblea.text = '' then
  begin
    messagedlg(caption,'Se debe ingresar el n�mero de oblea a anular',mtError,[mbOK],mbOK,0);
    ednumoblea.setfocus;
    exit;
  end;
  if defecha.text = '  /  /    ' then
  begin
    messagedlg(caption,'Se debe ingresar la fecha',mtError,[mbOK],mbOK,0);
    defecha.setfocus;
    exit;
  end;
  if cbautorizo.text = '' then
  begin
    messagedlg(caption,'Se debe ingresar la persona que autoriz� el la anulaci�n',mtError,[mbOK],mbOK,0);
    cbautorizo.setfocus;
    exit;
  end;
  if edmotivo.text = '' then
  begin
    messagedlg(caption,'Se debe ingresar el motivo de la anulaci�n',mtError,[mbOK],mbOK,0);
    edmotivo.setfocus;
    exit;
  end;
  result:=true;
end;

procedure TfmOblAnulGNC.FormDestroy(Sender: TObject);
begin
  fUsuario.free;
  fObleasAnuladasGNC.Free;
end;

end.
