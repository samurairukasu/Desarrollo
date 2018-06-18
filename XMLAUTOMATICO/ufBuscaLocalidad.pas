unit ufBuscaLocalidad;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, Buttons, Grids, DBGrids, uSagClasses, globals, uSagEstacion;

type
  TfrmBuscaLocalidad = class(TForm)
    edLocalidad: TEdit;
    DBGrid1: TDBGrid;
    btnSalir: TBitBtn;
    btnBuscar: TBitBtn;
    srcLocalidad: TDataSource;
    Label1: TLabel;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1Exit(Sender: TObject);
  private
    { Private declarations }
    fLocalidad: TLocalidad_Interior;
    Provincia: string;
  public
    { Public declarations }
    localidad: string;
    constructor CreateFromBD (aProvincia: string);
  end;

var
  frmBuscaLocalidad: TfrmBuscaLocalidad;

implementation

{$R *.DFM}

constructor TfrmBuscaLocalidad.CreateFromBD (aProvincia: string);
begin
    inherited Create(Application);
    provincia := aProvincia;
    fLocalidad := nil;
end;

procedure TfrmBuscaLocalidad.btnBuscarClick(Sender: TObject);
begin
  if assigned (flocalidad) then fLocalidad.Free;
  fLocalidad := TLocalidad_Interior.CreateByParecido(mybd, provincia, edLocalidad.text);
  fLocalidad.Open;
  if fLocalidad.RecordCount > 0 then  srcLocalidad.DataSet := fLocalidad.DataSet
  else Application.MessageBox('No se han encontrado localidades semejantes','Buscar localidad',mb_ok+mb_applmodal+mb_iconinformation);
end;

procedure TfrmBuscaLocalidad.btnSalirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmBuscaLocalidad.FormKeyPress(Sender: TObject; var Key: Char);
begin
        if key = ^M
        then begin
            Perform(WM_NEXTDLGCTL,0,0);
            Key := #0
        end
end;

procedure TfrmBuscaLocalidad.FormDestroy(Sender: TObject);
begin
  if Assigned(flocalidad) then fLocalidad.Free;
end;

procedure TfrmBuscaLocalidad.DBGrid1CellClick(Column: TColumn);
begin
  if Assigned(flocalidad) then
    localidad := fLocalidad.ValueByName[FIELD_LOCALIDAD];
end;

procedure TfrmBuscaLocalidad.DBGrid1DblClick(Sender: TObject);
begin
  if Assigned(flocalidad) then
    localidad := fLocalidad.ValueByName[FIELD_LOCALIDAD];
end;

procedure TfrmBuscaLocalidad.DBGrid1Exit(Sender: TObject);
begin
  if Assigned(flocalidad) then
    localidad := fLocalidad.ValueByName[FIELD_LOCALIDAD];
end;

end.
