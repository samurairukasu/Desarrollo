unit ufPlanta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, globals, uSagClasses, RxLookup, UsagEstacion,
  uUtils, ExtCtrls, SqlExpr, dbclient, provider, DB;

type
  TfrmPlanta = class(TForm)
    btnaceptarPlanta: TBitBtn;
    Label1: TLabel;
    btncancelar: TBitBtn;
    cbPlanta: TRxDBLookupCombo;
    dsPlantas: TDataSource;
    Bevel1: TBevel;
    procedure btnaceptarPlantaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    function GetIdPlanta : string;
    function GetNombre : string;
  private
    { Private declarations }
    fPlanta: TClientDataSet;
  public
    property IdPlanta :string read GetIdPlanta;
    property Nombre : string read GetNombre;
  end;
  Function GetPlanta (var vidplanta, vnombre: string):Boolean;
var
  frmPlanta: TfrmPlanta;

implementation

uses
    UFTMP;
{$R *.DFM}



Function GetPlanta (var vidplanta, vnombre: string):Boolean;
begin
    Result:=FalsE;
    try
        with TfrmPlanta.Create(Application) do
        try
            if ShowModal = mrOk
            then begin
                vidplanta := IdPlanta;
                vnombre := Nombre;
                Result:=True;
            end;
        finally
            Free
        end
    finally
        Application.ProcessMessages
    end
end;
procedure TfrmPlanta.btnaceptarPlantaClick(Sender: TObject);

begin

  ModalResult := mrOK


end;


procedure TfrmPlanta.FormActivate(Sender: TObject);
var username:string;
    sdsfPlanta : TSQLDataSet;
    dspfPlanta : TDataSetProvider;
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

end;


function TfrmPlanta.GetIdPlanta : string;
begin
    result := fPlanta.fieldbyname(FIELD_IDPLANTA).asstring
end;

function TfrmPlanta.GetNombre : string;
begin
    result := fPlanta.fieldbyname(FIELD_NOMBRE).asstring
end;


procedure TfrmPlanta.FormDestroy(Sender: TObject);
begin

  fplanta.Close;
  fplanta.free;

end;





end.
