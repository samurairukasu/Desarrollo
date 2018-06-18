unit ufControlMinimosVTV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, SqlExpr, Grids, DBGrids, globals,
  QuickRpt, ExtCtrls, QRCtrls, uUtils, jpeg,  FMTBcd, DBClient,
  Provider;

type
  TfrmControlMinimosVTV = class(TForm)
    qrControlMinimosVTV: TQuickRep;
    QRBand1: TQRBand;
    QRBdetalle: TQRBand;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    QRBand3: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRBand2: TQRBand;
    QRSysData1: TQRSysData;
    qrControlMinimosgnc: TQuickRep;
    QRBand4: TQRBand;
    QRImage2: TQRImage;
    QRLabel7: TQRLabel;
    qrbdetallegnc: TQRBand;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRBand6: TQRBand;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRBand7: TQRBand;
    QRSysData2: TQRSysData;
    sdsQTablaControl: TSQLDataSet;
    dspQTablaControl: TDataSetProvider;
    QTablaControl: TClientDataSet;
    procedure QRBdetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbdetallegncBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    ExcelApp, ExcelLibro, ExcelHoja: Variant;
    marcaConsumos, marcaExistencias, f: integer;
    plantaCons, plantaConsAnt, PlantaExis, PlantaExisAnt : string;
    procedure PutSummaryResults;
  public
    { Public declarations }
  end;
  procedure GenerateControMinimosVTV;
  procedure DoControlMinimosVTV;
  procedure GenerateControMinimosGNC;
  procedure DoControlMinimosGNC;

var
  frmControlMinimosVTV: TfrmControlMinimosVTV;
  DateIni, DateFin:string;
  fSQL : tstringList;

implementation

uses
  ulogs,uftmp;

resourcestring
  FICHERO_ACTUAL = 'ufControlMinimosVTV.pas';

{$R *.dfm}

procedure GenerateControMinimosVTV;
begin
  with TfrmControlMinimosVTV.Create(application) do
    try
      FTmp.Temporizar(TRUE,FALSE,'Control Mínimos Obleas VTV', 'Generando el Listado Control Mínimos Obleas VTV');
      Application.ProcessMessages;
      DoControlMinimosVTV;
      PutSummaryResults;
      FTmp.Temporizar(FALSE,FALSE,'', '');
      Application.ProcessMessages;
      qrControlMinimosVTV.preview;
    finally
      free;
    end;
end;

procedure DoControlMinimosVTV;
begin
    DeleteTable(MyBD, ' TTMP_MINOB_VTV');
    with TSqlStoredProc.Create(nil) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'DO_MINIMOS_OBVTV';
        ExecProc;
        Close;
    finally
        Free
    end
end;

procedure TfrmControlMinimosVTV.PutSummaryResults;
begin
  fSQL := TStringList.Create;
  with QTablaControl do
  begin
    Close;
    sdsQTablaControl.SQLConnection := MyBD;
    fsql.Add('SELECT INITCAP(LOWER(NOMBRE)) NOMBRE, MINOBVCUR,  MINOBVSIG,  CANTOBVCUR, CANTOBVSIG FROM TTMP_MINOB_VTV ');
    fsql.Add('ORDER BY NROPLANTA ');
    CommandText := fSQL.text;
    Open;
  end;
end;

procedure TfrmControlMinimosVTV.QRBdetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if qrControlMinimosVTV.DataSet.FieldByName('MINOBVSIG').AsInteger >= qrControlMinimosVTV.DataSet.FieldByName('CANTOBVSIG').AsInteger then
  begin
    QRBDetalle.color :=  $006CB6FF
  end
  else
  if qrControlMinimosVTV.DataSet.FieldByName('minobvcur').AsInteger >= qrControlMinimosVTV.DataSet.FieldByName('CANTOBVCUR').AsInteger then
      QRBDetalle.color := $00A8FFFF
    else
      QRBDetalle.color := clWhite;
end;

procedure GenerateControMinimosGNC;
begin
  with TfrmControlMinimosVTV.Create(application) do
    try
      FTmp.Temporizar(TRUE,FALSE,'Control Mínimos Obleas GNC', 'Generando el Listado Control Mínimos Obleas GNC');
      Application.ProcessMessages;
      DoControlMinimosGNC;
      PutSummaryResults;
      FTmp.Temporizar(FALSE,FALSE,'', '');
      Application.ProcessMessages;
      qrControlMinimosGNC.preview;
    finally
      free;
    end;
end;

procedure DoControlMinimosGNC;
begin
    DeleteTable(MyBD, 'TTMP_MINOB_VTV');
    with TsqlStoredProc.Create(nil) do
    try
        SqlConnection:= MyBD;
        StoredProcName := 'DO_MINIMOS_OBGNC';
        ExecProc;
        Close;
    finally
        Free
    end
end;

procedure TfrmControlMinimosVTV.qrbdetallegncBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if qrControlMinimosGNC.DataSet.FieldByName('minobvcur').AsInteger >= qrControlMinimosgnc.DataSet.FieldByName('CANTOBVCUR').AsInteger then
      QRBDetallegnc.color := $006CB6FF
    else
      QRBDetallegnc.color := clWhite;
end;

end.

