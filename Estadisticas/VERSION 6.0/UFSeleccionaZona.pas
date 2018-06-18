unit UFSeleccionaZona;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, globals, uSagClasses, RxLookup, Db, UsagEstacion,
  uUtils, ExtCtrls,SqlExpr, dbclient, provider;

type
  TfrmSeleccionaZona = class(TForm)
    btnaceptar: TBitBtn;
    Label1: TLabel;
    btncancelar: TBitBtn;
    cbZona: TRxDBLookupCombo;
    dsZonas: TDataSource;
    Bevel1: TBevel;
    Image1: TImage;
    procedure btnaceptarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fPlanta: TClientDataSet;
    fZona_aux: TClientDataSet;
    sdsfPlanta : TSQLDataSet;
    dspfPlanta : TDataSetProvider;
    sdsfZona_aux : TSQLDataSet;
    dspfZona_aux : TDataSetProvider;
  public
    { Public declarations }
  end;
  Procedure DoSeleccionarZona;
var
  frmSeleccionaZona: TfrmSeleccionaZona;

implementation

uses
    UFTMP, UFPrincipal;
{$R *.DFM}

Procedure DoSeleccionarZona;
begin
  with TfrmSeleccionaZona.create(application) do
  begin
    try
      showmodal;
    finally
      free;
    end;
  end;
end;

procedure TfrmSeleccionaZona.btnaceptarClick(Sender: TObject);
var
    DBUserName, DBPassword : string;
begin
  FTmp.Temporizar(TRUE,FALSE,'Informes Estadísticos ', 'Cambiando a la Zona Seleccionada');
  with fzona do
  begin
    close;
    sql.clear;
    sql.add(format('SELECT * FROM TZONAS WHERE CODZONA = %D',[fzona_aux.FIELDS[0].ASINTEGER]));
    open;
  end;
  with fplanta do
  begin
    close;
    SetProvider(dspfPlanta);
    commandtext := format('select * from tplantas where codzona = %d',[fzona_aux.FIELDS[0].ASINTEGER]);
    open;
    dbUserName:=fieldbyname(FIELD_USUARIO).asstring;
    dbPassword:=fieldbyname(FIELD_PASSWORD).asstring;
    mybd.Close;
    mybd.free;
    TestOfBD('',dbUserName,dbPassword,false);
    InitAplicationGlobalTables;
  end;
  FTmp.Temporizar(FALSE,FALSE,'', '');
  // frmprincipal.Barra.Panels[1].Text:=' Zona actual: '+IntToStr(fvarios.zona);
end;


procedure TfrmSeleccionaZona.FormActivate(Sender: TObject);
var username:string;
begin
  sdsfPlanta:=TSQLDataSet.Create(self);
  sdsfPlanta.SQLConnection := BDAG;
  sdsfPlanta.CommandType := ctQuery;
  sdsfPlanta.GetMetadata := false;
  sdsfPlanta.NoMetadata := true;
  sdsfPlanta.ParamCheck := false;
  dspfPlanta := TDataSetProvider.Create(self);
  dspfPlanta.DataSet := sdsfPlanta;
  dspfPlanta.Options := [poIncFieldProps,poAllowCommandText];

  fPlanta:=TClientdataset.Create (self);
  with fplanta do
  begin
    SetProvider(dspfPlanta);
    username:=devuelveusuario(mybd);
    CommandText := format('SELECT * FROM TPLANTAS WHERE USUARIO = ''%s''',[username]);
    Open;
  end;

  sdsfZona_aux:=TSQLDataSet.Create(self);
  sdsfZona_aux.SQLConnection := BDAG;
  sdsfZona_aux.CommandType := ctQuery;
  sdsfZona_aux.GetMetadata := false;
  sdsfZona_aux.NoMetadata := true;
  sdsfZona_aux.ParamCheck := false;
  dspfZona_aux := TDataSetProvider.Create(self);
  dspfZona_aux.DataSet := sdsfZona_aux;
  dspfZona_aux.Options := [poIncFieldProps,poAllowCommandText];

  fZona_aux:=TClientdataset.Create (self);
  with fZona_aux do
  begin
    SetProvider(dspfZona_aux);
    commandtext := 'SELECT * FROM TZONAS';
    Open;
    dsZonas.DataSet:=fZona_aux;
    cbzona.value:=fZona.fields[0].asstring;
  end;
end;

procedure TfrmSeleccionaZona.FormDestroy(Sender: TObject);
begin
  fplanta.Close;
  fplanta.free;
  dspfPlanta.Free;
  sdsfPlanta.Free;
  fZona_aux.close;
  fZona_aux.free;
  dspfZona_aux.Free;
  sdsfZona_aux.free;
end;

end.
