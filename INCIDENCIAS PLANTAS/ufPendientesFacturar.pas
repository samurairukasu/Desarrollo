unit ufPendientesFacturar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, RXDBCtrl, USagClasses, globals, SQLExpr, DB,UCDialgs;

const
  WM_LINEAINSP = WM_USER+10;
  cCAPTION = 'PENDIENTES A FACTURAR';

type
  TFrmPendientesFact = class(TForm)
    DBGTESTADOINSPB: TRxDBGrid;
    InspectionSource: TDataSource;
    procedure DBGTESTADOINSPBDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
 { Private declarations }
    FDataBase: tSQLConnection;
    FInspecciones: TEstadoInspeccion;
  public
 { Public declarations }
    Constructor CreateFromDataBase(aOwner: TComponent; aDataBase: tSQLConnection);
    Procedure UpdateLineaInspeccion(var msg:tmessage);message WM_LINEAINSP;
  end;

var
  FrmPendientesFact: TFrmPendientesFact;
  FOwner: TForm;

  procedure DoVerPendientesFacturar(const aBD : tSQLConnection; aOwner: TComponent);

implementation

Uses
USAGESTACION;

{$R *.dfm}

Constructor TFrmPendientesFact.CreateFromDataBase(aOwner: TComponent; aDataBase: tSQLConnection);
begin
Inherited Create(nil);
FDataBase:=aDataBase;
FInspecciones:= TEstadoInspeccion.CreateFromDataBase(FDataBase,DATOS_ESTADOINSPECCION,('WHERE ESTADO = ''H'' ORDER BY ESTADO DESC, TO_CHAR(HORAINIC,''dd/mm/yyyy HH:MI:SS'') DESC '));
InspectionSource.DataSet:=FInspecciones.DataSet;
Finspecciones.Open;
FInspecciones.First;
end;


procedure DoVerPendientesFacturar(const aBD : tSQLConnection; aOwner: TComponent);
begin
if FrmPendientesFact = nil then
  begin
    fOwner := Tform(aOwner);
    FrmPendientesFact:= TFrmPendientesFact.CreateFromDataBase(Application, aBD);
    with FrmPendientesFact do
      try
        Top:=0;
        Left:=0;
        Caption:=cCAPTION;
        Show;
      except
        on E: Exception do
          MessageDlg(Application.Title,'No pueden visualizarse los vehículos pendientes a facturar.',mtInformation,[mbOk],mbOk,0);
      end;
  end;
end;


Procedure TFrmPendientesFact.UpdateLineaInspeccion(var msg:tmessage);
begin
FInspecciones.Refresh;
end;


procedure TFrmPendientesFact.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action:=caFree;
end;


procedure TFrmPendientesFact.DBGTESTADOINSPBDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
Cad: String;
idx: Integer;
begin
If ((not(FInspecciones.Active)) or (FInspecciones.RecordCount=0)) then
  Exit;
IF Column.Index = 1 then
  begin
    Cad:='';
    Try
      Idx:=(Ord(FInspecciones.ValueByName[FIELD_ESTADO][1])-65);
    Except
     Idx:=0;
    end;
    Cad:=(S_ESTADO_INSPECCION[tEstados(Idx)]);
    With DBGTESTADOINSPB do
      Begin
        Canvas.Brush.Color:=S_ESTADOS_COLORES[tEstados(Idx)];
        Canvas.Font.Color:=S_ESTADOS_FUENTES_COLORES[tEstados(Idx)];
        Canvas.FillRect(Rect);
        Canvas.TextOut(Rect.Left,Rect.Top,Cad);
      end;
  end
end;


procedure TFrmPendientesFact.FormDestroy(Sender: TObject);
begin
fDatabase := nil;
if assigned(FInspecciones) then
  FInspecciones.Free;
FrmPendientesFact.Close;
FrmPendientesFact:=nil;
end;


end.
