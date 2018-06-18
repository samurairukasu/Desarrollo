unit ufMantReguladores;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Globals, uSagClasses,
  Db, StdCtrls, DBCtrls, RXLookup, Mask, UCDBEdit, Buttons, uCDialgs, uUtils;

type
  TfrmMantReguladores = class(TForm)
    srcRegulador: TDataSource;
    edNroSerie: TColorDBEdit;
    dbcbRegulador: TRxDBLookupCombo;
    srcReguladorEG: TDataSource;
    BContinuar: TBitBtn;
    BCancelar: TBitBtn;
    Label13: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    DBCBNuevo: TDBComboBox;
    procedure FormCreate(Sender: TObject);
    procedure BContinuarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edNroSerieExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBCBNuevoKeyPress(Sender: TObject; var Key: Char);
    procedure DBCBNuevoChange(Sender: TObject);
    procedure dbcbReguladorCloseUp(Sender: TObject);
  private
    { Private declarations }
    fRegulador : TReguladores;
    fUpdating: Boolean;
    fRegEG : TReguladoresEnargas;
    function ValidatePost : boolean;
  public
    { Public declarations }
    Constructor CreateFromRegulador(aOwner:TComponent; var aRegulador:TReguladores; aTipo : char);
  end;

var
  frmMantReguladores: TfrmMantReguladores;

implementation

{$R *.DFM}

uses
  uSagEstacion;
  
Constructor TfrmMantReguladores.CreateFromRegulador(aOwner:TComponent; var aRegulador:TReguladores; aTipo : char);
begin
        Inherited Create(aOwner);
        fRegulador:=aRegulador;
        srcRegulador.DataSet:=fRegulador.DataSet;
        fRegEG := TReguladoresEnargas.Create(MyBD);
        fRegEG.Open;
        srcReguladorEG.DataSet := fRegEG.DataSet;
        if aTipo in [TIPO_EDIT,E_MODIFICADO] then ActivarComponentes(false,self,[1]);
end;

procedure TfrmMantReguladores.FormCreate(Sender: TObject);
begin
        fUpdating:=False;
end;



procedure TfrmMantReguladores.BContinuarClick(Sender: TObject);
begin
        FUpdating:=True;
        If ValidatePost
        then begin
            fRegulador.Post(true);
            ModalResult:=Mrok;
        end
        else begin
            FUpdating:=FalsE;
        end;
end;

procedure TfrmMantReguladores.BCancelarClick(Sender: TObject);
begin
    FUpdating:=True;
    fRegulador.Cancel;
    ModalResult:=MrCancel;
end;

function TfrmMantReguladores.ValidatePost : boolean;
begin
  result := false;
  if dbcbRegulador.Text = '' then
  begin
      Messagedlg(Application.Title,'Se debe ingresar un Código de Regulador válido',mtError,[mbok],mbyes,0);
      dbcbRegulador.setfocus;
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
      Messagedlg(Application.Title,'Indique si el regulador es o no nuevo',mtError,[mbok],mbyes,0);
      DBCBNuevo.setfocus;
      exit;
  end;
  result := true;
end;


procedure TfrmMantReguladores.FormDestroy(Sender: TObject);
begin
     fRegEG.free;
end;

procedure TfrmMantReguladores.edNroSerieExit(Sender: TObject);
begin
    (Sender as TColorDBEdit).Text := Trim((Sender as TColorDBEdit).Text)
end;

procedure TfrmMantReguladores.FormKeyPress(Sender: TObject; var Key: Char);
begin
        if key = ^M
        then begin
            Perform(WM_NEXTDLGCTL,0,0);
            Key := #0
        end
end;

procedure TfrmMantReguladores.DBCBNuevoKeyPress(Sender: TObject;
  var Key: Char);
begin
        if not (Key in ['S','N','s','n'])
        then key := #0
end;

procedure TfrmMantReguladores.DBCBNuevoChange(Sender: TObject);
begin
  if Length(DBCBNuevo.Text) > 1 then DBCBNuevo.Text := copy(DBCBNuevo.Text,1,1);
  if (DBCBNuevo.Text = 's') or  (DBCBNuevo.Text = 'n') then
     DBCBNuevo.Text := uppercase(DBCBNuevo.Text);

end;

procedure TfrmMantReguladores.dbcbReguladorCloseUp(Sender: TObject);
begin
        dbcbRegulador.Value := fRegEg.ValueByName[dbcbRegulador.LookUpField];
end;

end.
