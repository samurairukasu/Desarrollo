unit UFSeleccionaPlanta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, globals, uSagClasses, RxLookup, UsagEstacion,
  uUtils, ExtCtrls, SqlExpr, dbclient, provider, DB;

type
  TfrmSeleccionaPlanta = class(TForm)
    btnaceptarPlanta: TBitBtn;
    Label1: TLabel;
    btncancelar: TBitBtn;
    cbPlanta: TRxDBLookupCombo;
    dsPlantas: TDataSource;
    Bevel1: TBevel;
    Image1: TImage;
    dsUsuarios: TDataSource;
    cbUsuarios: TRxDBLookupCombo;
    btnAceptarUsu: TBitBtn;
    Label2: TLabel;
    procedure btnaceptarPlantaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAceptarUsuClick(Sender: TObject);
  private
    { Private declarations }
    fPlanta: TClientDataSet;
    fUsuario: TClientDataSet;
  public
    { Public declarations }
  end;
  Procedure DoSeleccionarPlanta;
var
  frmSeleccionaPlanta: TfrmSeleccionaPlanta;

implementation

uses
    UFTMP;
{$R *.DFM}

Procedure DoSeleccionarPlanta;
begin
  with TfrmSeleccionaPlanta.create(application) do
  begin
    try
      showmodal;
    finally
      free;
    end;
  end;
end;

procedure TfrmSeleccionaPlanta.btnaceptarPlantaClick(Sender: TObject);
var
    DBUserName, DBPassword : string;
begin
  FTmp.Temporizar(TRUE,FALSE,'Informes Estadísticos', 'Cambiando a la Planta Seleccionada');
  dbUserName:=fPlanta.fieldbyname(FIELD_USUARIO).asstring;
  dbPassword:=fPlanta.fieldbyname(FIELD_PASSWORD).asstring;
  mybd.Close;
  mybd.free;
  TestOfBD('',dbUserName,dbPassword,false);
  InitAplicationGlobalTables;
  with tsqlquery.create(nil) do
  begin
     try
            SQLConnection:=bdag;
            sql.add(format('SELECT CODZONA FROM TPLANTAS WHERE USUARIO = ''%S''',[devuelveusuario(mybd)]));
            open;
            fzona.close;
            fzona.sql.clear;
            fzona.sql.add(format('SELECT * FROM TZONAS WHERE CODZONA = %D',[FIELDS[0].ASINTEGER]));
            fzona.open;
      finally
            free;
      end;
  end;
  FTmp.Temporizar(FALSE,FALSE,'', '');
end;


procedure TfrmSeleccionaPlanta.FormActivate(Sender: TObject);
var username:string;
    sdsfPlanta : TSQLDataSet;
    dspfPlanta : TDataSetProvider;
    sdsfUsuario : TSQLDataSet;
    dspfUsuario : TDataSetProvider;
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
    setprovider(dspfPlanta);
    commandtext := 'SELECT * FROM TPLANTAS WHERE TIPO = ''P'' ORDER BY IDPLANTA';
    Open;
    dsPlantas.DataSet:=fplanta;
    username:=devuelveusuario(mybd);
    if not (fPlanta.locate(FIELD_USUARIO,username,[])) then
      fplanta.first;
    cbplanta.value:=fplanta.fields[0].value;
  end;

  sdsfUsuario:=TSQLDataSet.Create(self);
  sdsfUsuario.SQLConnection := BDAG;
  sdsfUsuario.CommandType := ctQuery;
  sdsfUsuario.GetMetadata := false;
  sdsfUsuario.NoMetadata := true;
  sdsfUsuario.ParamCheck := false;
  dspfUsuario := TDataSetProvider.Create(self);
  dspfUsuario.DataSet := sdsfUsuario;
  dspfUsuario.Options := [poIncFieldProps,poAllowCommandText];

  fUsuario:=TClientdataset.Create (self);

  with fUsuario do
  begin
    SetProvider(dspfUsuario);
    CommandText := 'SELECT * FROM TPLANTAS WHERE TIPO = ''U''';
    Open;
    dsUsuarios.DataSet:=fUsuario;
    username:=devuelveusuario(mybd);
    if not (fUsuario.locate(FIELD_USUARIO,username,[])) then
      fUsuario.first;
    cbUsuarios.value:=fUsuario.fields[0].value;
  end;
end;

procedure TfrmSeleccionaPlanta.FormDestroy(Sender: TObject);
begin
  fplanta.Close;
  fplanta.free;
  fUsuario.close;
  fUsuario.Free;
end;



procedure TfrmSeleccionaPlanta.btnAceptarUsuClick(Sender: TObject);
var
    DBUserName, DBPassword : string;
begin
  FTmp.Temporizar(TRUE,FALSE,'Informes Estadísticos', 'Cambiando al Usuario Seleccionado');
  dbUserName:=fUsuario.fieldbyname(FIELD_USUARIO).asstring;
  dbPassword:=fUsuario.fieldbyname(FIELD_PASSWORD).asstring;
  mybd.Close;
  mybd.free;
  TestOfBD('',dbUserName,dbPassword,false);
  InitAplicationGlobalTables;
  FTmp.Temporizar(FALSE,FALSE,'', '');
end;

end.
