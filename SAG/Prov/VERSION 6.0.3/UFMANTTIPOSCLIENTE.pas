unit UFMantTiposCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, UCDialgs,
  StdCtrls, Buttons, SQLExpr, USAGCLASSES, Grids, DBGrids, Db, ExtCtrls,
  Mask, DBCtrls, PicClip, SpeedBar;

type
  TFMantTiposClientes = class(TForm)
    TiposSource: TDataSource;
    DBGrid1: TDBGrid;
    bAnadir: TBitBtn;
    bModificar: TBitBtn;
    bEliminar: TBitBtn;
    Fondo: TPanel;
    bOK: TBitBtn;
    bCancel: TBitBtn;
    Label1: TLabel;
    Bevel1: TBevel;
    DBEdit1: TDBEdit;
    PORREVERIFICACION: TDBEdit;
    DBEdit3: TDBEdit;
    DESCRIPCION: TDBEdit;
    Identificador: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Label8: TLabel;
    DBEdit2: TDBEdit;
    Label9: TLabel;
    DBComboBox2: TDBComboBox;
    SBarPrincipal: TSpeedBar;
    SpeedbarSection3: TSpeedbarSection;
    SBSalir: TSpeedItem;
    DBComboBox1: TDBComboBox;
    Label10: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure bAnadirClick(Sender: TObject);
    procedure bModificarClick(Sender: TObject);
    procedure bEliminarClick(Sender: TObject);
    procedure TiposSourceDataChange(Sender: TObject; Field: TField);
    procedure bCancelClick(Sender: TObject);
    procedure bOKClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBComboBox2KeyPress(Sender: TObject; var Key: Char);
    procedure SBSalirClick(Sender: TObject);
  private
    { Private declarations }
    FDataBase: TSQLConnection;
    fTipos: TTiposCliente;  
    Procedure ActivarFondo(Modo: Boolean);
  public
    { Public declarations }
    constructor CreateFromDataBase(aOwner:TComponent; aDataBase: TSQLConnection);
  end;

  Procedure DoMantTiposCliente(aDataBase: TSQLConnection);

var
  FMantTiposClientes: TFMantTiposClientes;

implementation

Uses USAGESTACION;

{$R *.DFM}

ResourceString

    MSJ_CANNOT_DELETE_TYPE = '¡ No se Puede Borrar Este Tipo de Cliente, Probablemaente Haya Clientes de Este tipo Definidos !';
    MSJ_DELETE_TYPE = '¿ Borrar el Tipo de Cliente Seleccionado ?';
    MSJ_WRONG_POST = '¡ No Se Pudieron Grabar Los Datos, Compruebe Que No Está Duplicando El Identificacdor !';

Procedure DoMantTiposCliente(aDataBase: TSQLConnection);
begin
    With TFMantTiposClientes.CreateFromDataBase(Application,aDatabase) do
    Try
        Showmodal;
    Finally
        Free;
    end;
end;

constructor TFMantTiposClientes.CreateFromDataBase(aOwner:TComponent; aDataBase: TSQLConnection);
begin
    //Constructor de la clase
    Inherited Create(aOwner);
    FDatabase:= aDataBase;
    fTipos:=TTIposcliente.CreateFromDataBase(fDataBase,DATOS_TIPOS_DE_CLIENTE,'');

    { TODO -oran -cquedo asi !!!! : ver si esto es necesario hacer algo }
    //    fTipos.DataSet.RequestLive:=True;
    fTipos.Open;
    TiposSource.DataSet:=fTipos.DataSet;
end;

procedure TFMantTiposClientes.FormDestroy(Sender: TObject);
begin
    fTipos.Free;
end;

procedure TFMantTiposClientes.bAnadirClick(Sender: TObject);
begin
    //Añadir nuevo Tipo
    ActivarFondo(True);
    fTipos.Append;
end;

procedure TFMantTiposClientes.bModificarClick(Sender: TObject);
begin
    //Modificar Tipo
    ActivarFondo(True);
    fTipos.Edit;
end;

procedure TFMantTiposClientes.bEliminarClick(Sender: TObject);
begin
    //Eliminar Tipo
    If Messagedlg(Caption,MSJ_DELETE_TYPE+' : '+fTipos.ValuebyName[FIELD_DESCRIPCION],mtconfirmation,[mbyes,mbno],mbNo,0)=mrYes
    then begin
        //Borrar Tipo de cliente
        Try
            fTipos.DataSet.Delete;
            if fTipos.dataset.applyupdates(-1) > 0 then
              raise Exception.Create(MSJ_CANNOT_DELETE_TYPE);
        Except
            fTipos.DataSet.CancelUpdates;
            Messagedlg(Caption,MSJ_CANNOT_DELETE_TYPE,mtInformation,[mbOk],mbOk,0);
        end;
    end;
end;

Procedure TFMantTiposClientes.ActivarFondo(Modo: Boolean);
begin
    Fondo.Visible:=Modo;
    if Modo
    then begin
        Fondo.BringToFront;
        DBEdit1.SetFocus;
    end;
end;

procedure TFMantTiposClientes.TiposSourceDataChange(Sender: TObject;
  Field: TField);
begin
    If ((fTipos<>nil) and (fTipos.Active))
    then begin
        bAnadir.Enabled:=True;
        if Ftipos.RecordCount>0
        then begin
            bModificar.Enabled:=True;
            bEliminar.Enabled:=True;
        end
        else begin
            bModificar.Enabled:=False;
            bEliminar.Enabled:=False;
        end;
    end
    else begin
        bAnadir.Enabled:=False;
        bModificar.Enabled:=False;
        bEliminar.Enabled:=False;
    end;
end;

procedure TFMantTiposClientes.bCancelClick(Sender: TObject);
begin
    Try
        fTipos.Cancel;
    Except
    End;
    ActivarFondo(False);
end;

procedure TFMantTiposClientes.bOKClick(Sender: TObject);
begin
    Try
        fTipos.Post(true);
        fTipos.Refresh;
        ActivarFondo(False);
    Except
        Messagedlg(Caption,MSJ_WRONG_POST,mtInformation,[mbok],mbok,0);
    End;
end;






procedure TFMantTiposClientes.FormKeyPress(Sender: TObject; var Key: Char);
begin
        if key = ^M
        then begin
            Perform(WM_NEXTDLGCTL,0,0);
            Key := #0
        end
end;




procedure TFMantTiposClientes.DBComboBox2KeyPress(Sender: TObject;
  var Key: Char);
begin
        if not (Key in ['S','N'])
        then key := #0
end;

procedure TFMantTiposClientes.SBSalirClick(Sender: TObject);
begin
  close;
end;

end.
