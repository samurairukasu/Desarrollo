unit uArqueoCajaSumaryxCajero;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Grids, variants;

type
  TFSumaryCajaxCajero = class(TForm)
    SG: TStringGrid;
    HeaderControl1: THeaderControl;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor CreateFromDescuentos(aOwner:TComponent);
  end;

var
  FSumaryCajaxCajero: TFSumaryCajaxCajero;

implementation

{$R *.DFM}

    uses
        USAGESTACION,
        Globals,
        USAGCLASSES,
        SQLExpr;

procedure TFSumaryCajaxCajero.FormCreate(Sender: TObject);
var
    fTiposCliente : TTiposCliente;
    i: integer;
    ArrayVar: Variant;
begin
//    Caption := Format('Resumen por Tipos de Cliente. Estacion: %S. (%S - %S) %S', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10), PutTipoPago(sTipo_Auxi)]);
    i := 0;
    fTiposCliente := TTIposCliente.CreateFromDatabase(MyBD,DATOS_TIPOS_DE_CLIENTE,'WHERE VIGENTE = ''S'' ORDER BY TIPOCLIENTE_ID');
    fTiposCliente.Open;
    try
        while not fTiposCliente.Eof do
        begin
            ArrayVar:=VarArrayCreate([0,0],VarVariant);
            ArrayVar[0]:=fTiposCliente.ValueByName[FIELD_DESCRIPCION];
            SG.Cells[0,i] := fTiposCliente.ValueByName[FIELD_DESCRIPCION];
            SG.Cells[1,i] := fTiposCliente.ExecuteFunction('NFacturas',ArrayVar);
            SG.Cells[2,i] := fTiposCliente.ExecuteFunction('NNotas',ArrayVar);
            with TSQLQuery.Create(self) do
            try
                SQLConnection:= fTiposCliente.Database;
                SQL.Add (Format ('SELECT NVL(SUM(IMPORTE),0) INETO, NVL(SUM(IVA),0) IVA, NVL(SUM(IVANOINSCRIPTO),0) IVAN, NVL(SUM(TOTAL),0) TOT FROM TTMPARQCAJAEXTEN WHERE TIPOCLIENTE = ''%S''',[fTiposCliente.ValueByName[FIELD_DESCRIPCION]]));
                Open;
                SG.Cells[3,i] := FieldByName('INETO').AsString;
                SG.Cells[4,i] := FieldByName('IVA').AsString;
                SG.Cells[5,i] := FieldByName('IVAN').AsString;
                SG.Cells[6,i] := FieldByName('TOT').AsString;
            finally
                Close;
                Free;
            end;
            fTiposCliente.Next;
            Inc(i);
            SG.RowCount := SG.RowCount + 1;
        end;
    finally
        SG.RowCount := SG.RowCount - 1;
        fTiposCliente.Free;
    end;
end;

constructor TFSumaryCajaxCajero.CreateFromDescuentos(aOwner:TComponent);
var
    fTiposCliente : TTiposCliente;
    i: integer;
    ArrayVar: Variant;
begin
//    Caption := Format('Resumen por Tipos de Cliente. Estacion: %S. (%S - %S) %S', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10), PutTipoPago(sTipo_Auxi)]);
    Inherited Create(aOwner);
    i := 0;
    fTiposCliente := TTIposCliente.CreateFromDatabase(MyBD,DATOS_TIPOS_DE_CLIENTE,'WHERE VIGENTE = ''S'' ORDER BY TIPOCLIENTE_ID');
    fTiposCliente.Open;
    try
        while not fTiposCliente.Eof do
        begin
            ArrayVar:=VarArrayCreate([0,0],VarVariant);
            ArrayVar[0]:=fTiposCliente.ValueByName[FIELD_DESCRIPCION];
            SG.Cells[0,i] := fTiposCliente.ValueByName[FIELD_DESCRIPCION];
            SG.Cells[1,i] := fTiposCliente.ExecuteFunction('NFacturasDesc',ArrayVar);
            SG.Cells[2,i] := fTiposCliente.ExecuteFunction('NNotasDesc',ArrayVar);
            with TSQLQuery.Create(nil) do
            try
                SQLConnection := fTiposCliente.Database;
                SQL.Add (Format ('SELECT NVL(SUM(IMPORTE),0) INETO, NVL(SUM(IVA),0) IVA, NVL(SUM(IVANOINSCRIPTO),0) IVAN, NVL(SUM(TOTAL),0) TOT FROM TTMPARQCAJAEXTENDESC WHERE TIPOCLIENTE = ''%S''',[fTiposCliente.ValueByName[FIELD_DESCRIPCION]]));
                Open;
                SG.Cells[3,i] := FieldByName('INETO').AsString;
                SG.Cells[4,i] := FieldByName('IVA').AsString;
                SG.Cells[5,i] := FieldByName('IVAN').AsString;
                SG.Cells[6,i] := FieldByName('TOT').AsString;
            finally
                Close;
                Free;
            end;
            fTiposCliente.Next;
            Inc(i);
            SG.RowCount := SG.RowCount + 1;
        end;
    finally
        SG.RowCount := SG.RowCount - 1;
        fTiposCliente.Free;
    end;
end;

end.
