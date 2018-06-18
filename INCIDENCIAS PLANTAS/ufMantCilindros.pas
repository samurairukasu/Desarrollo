unit ufMantCilindros;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Globals,
  uSagClasses, Db, StdCtrls, DBCtrls, RXLookup, Mask, UCDBEdit, Buttons, uCDialgs,
  ToolEdit, ExtCtrls, RXDBCtrl, DateUtil, uUtils;

type
  TfrmMantCilindros = class(TForm)
    srcCilindro: TDataSource;
    edNroSerie: TColorDBEdit;
    dbcbCilindro: TRxDBLookupCombo;
    srcCilindroEG: TDataSource;
    BContinuar: TBitBtn;
    BCancelar: TBitBtn;
    Label13: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    DBCBNuevo: TDBComboBox;
    edFabri: TDBDateEdit;
    edRevi: TDBDateEdit;
    edVenci: TDBDateEdit;
    srcCentros: TDataSource;
    srcValvulas: TDataSource;
    dbcbCentro: TRxDBLookupCombo;
    dbcbValvula: TRxDBLookupCombo;
    edNroSerieValv: TColorDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Bevel3: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure BContinuarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edNroSerieExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBCBNuevoKeyPress(Sender: TObject; var Key: Char);
    procedure DBCBNuevoChange(Sender: TObject);
    procedure edVenciEnter(Sender: TObject);
    procedure dbcbCilindroCloseUp(Sender: TObject);
    procedure dbcbCentroCloseUp(Sender: TObject);
    procedure dbcbValvulaCloseUp(Sender: TObject);
    procedure edFabriExit(Sender: TObject);
  private
    { Private declarations }
    fCilindro : TCilindros;
    fUpdating: Boolean;
    fCilEG : TCilindrosEnargas;
    fCentros : TCentrosRPC;
    fValvulas : TValvulasEnargas;
    function ValidatePost : boolean;
  public
    { Public declarations }
    Constructor CreateFromCilindro(aOwner:TComponent; var aCilindro:TCilindros; aTipo : char);
  end;

var
  frmMantCilindros: TfrmMantCilindros;

implementation

{$R *.DFM}

uses
  uSagEstacion;
  
Constructor TfrmMantCilindros.CreateFromCilindro(aOwner:TComponent; var aCilindro:TCilindros; aTipo : char);
begin
        Inherited Create(aOwner);
        fCilindro:=aCilindro;
        srcCilindro.DataSet:=fCilindro.DataSet;
        fCilEG := TCilindrosEnargas.Create(MyBD);
        fCilEG.Open;
        srcCilindroEG.DataSet := fCilEG.DataSet;
        fCentros := TCentrosRPC.Create(MyBD);
        fCentros.open;
        srcCentros.DataSet := fCentros.DataSet;
        fValvulas := TValvulasEnargas.Create(MyBD);
        fValvulas.Open;
        srcValvulas.DataSet := fValvulas.DataSet;
        case aTipo of
          TIPO_EDIT: begin
            ActivarComponentes(false,self,[1]);
          end;
          E_MODIFICADO: begin
            ActivarComponentes(false,self,[1,2]);
          end;
        end;
end;

procedure TfrmMantCilindros.FormCreate(Sender: TObject);
begin
        fUpdating:=False;
end;



procedure TfrmMantCilindros.BContinuarClick(Sender: TObject);
begin
        FUpdating:=True;
        If ValidatePost
        then begin
            fCilindro.Post(true);
            ModalResult:=Mrok;
        end
        else begin
            FUpdating:=FalsE;
        end;
end;

procedure TfrmMantCilindros.BCancelarClick(Sender: TObject);
begin
    FUpdating:=True;
    fCilindro.Cancel;
    ModalResult:=MrCancel;
end;

function TfrmMantCilindros.ValidatePost : boolean;
begin
  result := false;
  if dbcbCilindro.Text = '' then
  begin
      Messagedlg(Application.Title,'Se debe ingresar un Código de Cilindro válido',mtError,[mbok],mbyes,0);
      dbcbCilindro.setfocus;
      exit;
  end;
  if length(edNroSerie.Text) < 2 then
  begin
      Messagedlg(Application.Title,'Se debe ingresar un Nro. de Serie válido',mtError,[mbok],mbyes,0);
      edNroSerie.setfocus;
      exit;
  end;
  if DBCBNuevo.Text = '' then
  begin
      Messagedlg(Application.Title,'Indique si el cilindro es o no nuevo',mtError,[mbok],mbyes,0);
      DBCBNuevo.setfocus;
      exit;
  end;
  if DBCBCentro.Text = '' then
  begin
      Messagedlg(Application.Title,'Se debe ingresar un Centro válido',mtError,[mbok],mbyes,0);
      DBCBCentro.setfocus;
      exit;
  end;
  if edRevi.date > edVenci.Date then
  begin
      Messagedlg(Application.Title,'La fecha de vencimiento debe ser mayor a la de revisión',mtError,[mbok],mbyes,0);
      edRevi.setfocus;
      exit;
  end;

  result := true;
end;


procedure TfrmMantCilindros.FormDestroy(Sender: TObject);
begin
    fCilEG.free;
    fCentros.free;
    fValvulas.free;
end;

procedure TfrmMantCilindros.edNroSerieExit(Sender: TObject);
begin
    (Sender as TColorDBEdit).Text := Trim((Sender as TColorDBEdit).Text)
end;

procedure TfrmMantCilindros.FormKeyPress(Sender: TObject; var Key: Char);
begin
        if key = ^M
        then begin
            Perform(WM_NEXTDLGCTL,0,0);
            Key := #0
        end
end;


procedure TfrmMantCilindros.DBCBNuevoKeyPress(Sender: TObject;
  var Key: Char);
begin
        if not (Key in ['S','N','s','n'])
        then key := #0
end;

procedure TfrmMantCilindros.DBCBNuevoChange(Sender: TObject);
begin
  if Length(DBCBNuevo.Text) > 1 then DBCBNuevo.Text := copy(DBCBNuevo.Text,1,1);
  if (DBCBNuevo.Text = 's') or  (DBCBNuevo.Text = 'n') then
     DBCBNuevo.Text := uppercase(DBCBNuevo.Text);
end;

procedure TfrmMantCilindros.edVenciEnter(Sender: TObject);
begin
  if edRevi.Date <> 0 then
    edVenci.Date := IncYear(edRevi.Date,5);
end;

procedure TfrmMantCilindros.dbcbCilindroCloseUp(Sender: TObject);
begin
        dbcbCilindro.Value := fCilEg.ValueByName[dbcbCilindro.LookUpField];
end;

procedure TfrmMantCilindros.dbcbCentroCloseUp(Sender: TObject);
begin
        dbcbCentro.Value := fCentros.ValueByName[dbcbCentro.LookUpField];
end;

procedure TfrmMantCilindros.dbcbValvulaCloseUp(Sender: TObject);
begin
        dbcbValvula.Value := fValvulas.ValueByName[dbcbValvula.LookUpField];
end;

procedure TfrmMantCilindros.edFabriExit(Sender: TObject);
begin
  if (sender as tdbdateEdit).date < strtodate('01/01/1900') then
  begin
      Messagedlg(Application.Title,'La fecha debe ser posterior al 01/01/1900',mtError,[mbok],mbyes,0);
      (sender as tdbdateEdit).setfocus;
  end;
  if (sender as tdbdateEdit).name <> 'edVenci' then
    if (sender as tdbdateEdit).date > date then
    begin
      Messagedlg(Application.Title,'La fecha debe ser posterior a la actual',mtError,[mbok],mbyes,0);
      (sender as tdbdateEdit).setfocus;
    end;
end;

end.
