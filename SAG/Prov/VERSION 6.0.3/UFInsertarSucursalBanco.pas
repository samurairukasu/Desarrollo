unit UFInsertarSucursalBanco;

interface

uses
        Windows,
        Messages,
        SysUtils,
        Classes,
        Graphics,
        Controls,
        Forms,
        UCdialgs,
        StdCtrls,
        Buttons,
        ExtCtrls,
        UCEdit,
        SQLExpr,
        Mask,
        DBCtrls,
        UCDBEdit,
        USAgClasses,
        uSagEstacion,
        DB,
        Provider,
        dbClient;

type
  TfrmInsertarSucursalBanco = class(TForm)
    Image1: TImage;
    CECodSucursal: TColorDBEdit;
    Bevel1: TBevel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    DSSucursales: TDataSource;
    CENombre: TColorDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CECodSucursalChange(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fSucursales: TSucursales;
    function ValidatePost:boolean;
  public
    { Public declarations }
  end;
  function InsercionDeSucursalesBanco (const aCodBanco: String; var aSucursales: TSucursales; const aCodSucursal: string) : boolean;

var
  frmInsertarSucursalBanco: TfrmInsertarSucursalBanco;
  Codsucursal:string;

implementation

{$R *.DFM}


function InsercionDeSucursalesBanco (const aCodBanco: String; var aSucursales: TSucursales; const aCodSucursal: string) : boolean;
var
        bOk : boolean;
begin
        bOk := FALSE;
        with TfrmInsertarSucursalBanco.Create(Application) do
        try
            fSucursales := aSucursales;
            dsSucursales.DataSet:=fSucursales.DataSet;
            fsucursales.Append;
            fsucursales.ValueByName[FIELD_CODBANCO]:=aCodBanco;
            CodSucursal:=aCodSucursal;
            bOK := (ShowModal = mrOk)
        finally
            Free;
            result := bOk;
        end
end;

procedure TfrmInsertarSucursalBanco.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
         if key = ^M
            then begin
                Perform(WM_NEXTDLGCTL,0,0);
                Key := #0
            end
end;

procedure TfrmInsertarSucursalBanco.CECodSucursalChange(Sender: TObject);
begin
        btnAceptar.Enabled := (Length(Trim(CECodSucursal.Text)) > 0) and (Length(Trim(CENombre.Text)) > 0)
end;

procedure TfrmInsertarSucursalBanco.btnAceptarClick(Sender: TObject);
var
        sNuevaSucursal : string;
begin
        try
            if ValidatePost then
            begin
              sNuevaSucursal := Trim(CECodSucursal.Text);
              fSucursales.Post(true);
              fSucursales.Refresh;
              FSucursales.DataSet.Locate(FIELD_CODSUCURSAL,sNuevaSucursal,[]);
              ModalResult := mrOk;
//              fSucursales.COMMIT;
            end;
        except
            on E: Exception do
                MessageDlg(Caption, 'No pudo insertarse. Si el error persiste contacte con el Jefe de Planta.',mtInformation,[mbOk],mbOk,0)
        end

end;

procedure TfrmInsertarSucursalBanco.btnCancelarClick(Sender: TObject);
begin
  fSucursales.Cancel;
end;

function TfrmInsertarSucursalBanco.validatepost:boolean;
var aq: TSQLDataSet;
    dsp : tDatasetprovider;
    cds : tClientDataSet;
begin
  result:=false;

    aQ := TSQLDataSet.Create(self);
    aQ.SQLConnection := fsucursales.DataBase;
    aQ.CommandType := ctQuery;
    aQ.GetMetadata := false;
    aQ.NoMetadata := true;
    aQ.ParamCheck := false;

    dsp := TDataSetProvider.Create(self);
    dsp.DataSet := aQ;
    dsp.Options := [poIncFieldProps,poAllowCommandText];

    cds:=TClientDataSet.Create(self);

  with cds do
  begin
    try

      SetProvider(dsp);

      commandtext :=(format('select codsucursal from tsucursales where codbanco = ''%S'' and codsucursal = ''%S''',[fsucursales.valuebyname[FIELD_CODBANCO],cecodsucursal.text]));
      open;
      if recordcount > 0 then
      begin
        MessageDlg(Caption, 'Ya existe una sucursal con el mismo número para este banco',mtInformation,[mbOk],mbOk,0);
        cecodsucursal.SetFocus;
        exit;
      end;
      result:=true;
    finally
      close;
      free;
    end;
  end;
end;

procedure TfrmInsertarSucursalBanco.FormShow(Sender: TObject);
begin
  fSucursales.valuebyname[FIELD_CODSUCURSAL]:=CodSucursal;
end;

end.
