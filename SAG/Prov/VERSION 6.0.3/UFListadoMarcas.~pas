unit ufListadoMarcas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, USagFabricante, Globals,
  Db, StdCtrls, Buttons, RXLookup, ExtCtrls, uutils, SQLExpr, provider, dbclient;

type
  TfrmListadoMarcas = class(TForm)
    dsMarcas: TDataSource;
    dsModelos: TDataSource;
    pMarca: TPanel;
    Label1: TLabel;
    cbmarca: TRxDBLookupCombo;
    chTodas: TCheckBox;
    btnImprimir: TBitBtn;
    btnSalir: TBitBtn;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSalirClick(Sender: TObject);
    procedure chTodasClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    fMarcas : Tmarcas;
  public
    { Public declarations }
  end;
  procedure DoListadoMarcas;
var
  frmListadoMarcas: TfrmListadoMarcas;

implementation

{$R *.DFM}

uses
  ufListadoMarcasToPrint, USAGESTACION;

procedure DoListadoMarcas;
begin
  with TfrmListadoMarcas.Create(application) do
    try
      showmodal;
    finally
      free;
    end;
end;

procedure TfrmListadoMarcas.FormCreate(Sender: TObject);
begin
  fMarcas := nil;
  fMarcas := TMarcas.Create(MyBD,'');
  fMarcas.Filter := 'ORDER BY NOMMARCA';
  fMarcas.Open;
  dsMarcas.DataSet := fMarcas.dataset;
end;

procedure TfrmListadoMarcas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fMarcas.Free;
end;


procedure TfrmListadoMarcas.btnSalirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmListadoMarcas.chTodasClick(Sender: TObject);
begin
  MostrarComponentes(not(chtodas.checked),self,[1]);
end;

procedure TfrmListadoMarcas.btnImprimirClick(Sender: TObject);
var
  fSQL : tstringlist;
begin
  with TfrmListadoMarcasToPrint.Create(application) do
    try

      sds := TSQLDataSet.Create(self);
      sds.SQLConnection := MyBD;
      sds.CommandType := ctQuery;
      sds.GetMetadata := false;
      sds.NoMetadata := true;
      sds.ParamCheck := false;
      dsp := TDataSetProvider.Create(self);
      dsp.DataSet := sds;
      dsp.Options := [poIncFieldProps,poAllowCommandText];
      fModelo:=TClientDataSet.Create(self);
      fModelo.SetProvider(dsp);
      fsql := TStringList.create;
      if chTodas.Checked then
      begin
            with fModelo do
            begin
                    fsql.add('SELECT O.CODMARCA, O.CODMODEL, O.NOMMODEL, NOMMARCA ');
                    fSQL.Add('FROM TMARCAS A, TMODELOS O ');
                    fSQL.ADD('WHERE O.CODMARCA = A.CODMARCA ');
                    fSQL.ADD('ORDER BY NOMMARCA');
                    CommandText := fSQL.Text;
                    open;
            end;
      end
      else
      begin
            with fModelo do
            begin
                    fsql.add('SELECT O.CODMARCA, O.CODMODEL, O.NOMMODEL, NOMMARCA ');
                    fSQL.Add('FROM TMARCAS A, TMODELOS O ');
                    fSQL.ADD('WHERE O.CODMARCA = A.CODMARCA ');
                    fSQL.ADD(format('AND O.CODMARCA = %S ',[fMarcas.valuebyname[FIELD_CODMARCA]]));
                    fSQL.ADD('ORDER BY NOMMARCA');
                    CommandText := fSQL.Text;
                    open;
            end;
      end;
      repMarcas.dataset := fModelo;
      repMarcas.Prepare;
      cantPaginas := repMarcas.QRPrinter.PageCount;
      repMarcas.Preview;
    finally
      fModelo.close;
      fModelo.Free;
      free;
    end;
end;

end.
