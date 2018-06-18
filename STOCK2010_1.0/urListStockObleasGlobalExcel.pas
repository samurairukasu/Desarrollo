unit urListStockObleasGlobalExcel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, QRCtrls, jpeg, ExtCtrls, SqlExpr, globals, FMTBcd,
  Provider, DB, DBClient, RxMemDS, ExcelXP, OleServer, ComObj,
  StdCtrls, Buttons;

type
  TfListStockObleaGlobalExcel = class(TForm)
    Planilla: TDBGrid;
    SQLQuery1: TSQLQuery;
    DataSource1: TDataSource;
    consulta: TClientDataSet;
    sdsconsulta: TSQLDataSet;
    dspconsulta: TDataSetProvider;
    RxMemoryData1: TRxMemoryData;
    RxMemoryData1ANIO: TIntegerField;
    RxMemoryData1IDMOVIMIENTO: TIntegerField;
    RxMemoryData1IDPLANTA: TIntegerField;
    RxMemoryData1SPLANTA: TStringField;
    RxMemoryData1CANTIDAD: TIntegerField;
    RxMemoryData1OBLEAINIC: TIntegerField;
    RxMemoryData1OBLEAFIN: TIntegerField;
    ExcelApplication1: TExcelApplication;
    ExcelWorkbook1: TExcelWorkbook;
    ExcelWorksheet1: TExcelWorksheet;
    Exportar: TButton;
    Salir: TButton;
    procedure DoLisStockGlobalV2(Sender: TObject);
    procedure ExportarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SalirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fListStockObleaGlobalExcel: TfListStockObleaGlobalExcel;

implementation

{$R *.dfm}

procedure TfListStockObleaGlobalExcel.DoLisStockGlobalV2(Sender: TObject);

begin
  with TfListStockObleaGlobalExcel.Create(application) do
   try
   SQLQuery1.SQLConnection:=mybd;
   SQLQuery1.Close;
   SQLQuery1.SQL.Clear;
   SQLQuery1.SQL.Add('SELECT ANIO, IDMOVIMIENTO, SUBSTR(GET_NROPLANTA_ID(IDPLANTA),1,6) AS IDPLANTA, SUBSTR(GET_NOMBRE_PLANTA_ID(IDPLANTA),1,35) AS SPLANTA, CANTIDAD, OBLEAINIC, OBLEAFIN ');
   SQLQuery1.SQL.Add('FROM TTMP_STOCKOBLEAS_GLOBAL ');
   SQLQuery1.SQL.Add('ORDER BY IDPLANTA, ANIO, IDMOVIMIENTO');
   SQLQuery1.ExecSQL();
   SQLQuery1.Open;
   self.RxMemoryData1.Close;
   self.RxMemoryData1.Open;
   while not SQLQuery1.Eof do
   begin
        self.RxMemoryData1.Append;
        self.RxMemoryData1ANIO.Value:=SQLQuery1.fieldbyname('ANIO').AsInteger;
        self.RxMemoryData1IDMOVIMIENTO.Value:=SQLQuery1.fieldbyname('IDMOVIMIENTO').AsInteger;
        self.RxMemoryData1IDPLANTA.Value:=SQLQuery1.fieldbyname('IDPLANTA').AsInteger;
        self.RxMemoryData1SPLANTA.Value:=SQLQuery1.fieldbyname('SPLANTA').AsString;
        self.RxMemoryData1CANTIDAD.Value:=SQLQuery1.fieldbyname('CANTIDAD').AsInteger;
        self.RxMemoryData1OBLEAINIC.Value:=SQLQuery1.fieldbyname('OBLEAINIC').AsInteger;
        self.RxMemoryData1OBLEAFIN.Value:=SQLQuery1.fieldbyname('OBLEAFIN').AsInteger;
        self.RxMemoryData1.Post;

       SQLQuery1.Next;
   end;
   self.RxMemoryData1.First;

    finally
     consulta.Free;
     free;
    end;
end;

 procedure TfListStockObleaGlobalExcel.ExportarClick(Sender: TObject);
var
  excel:Variant;
  fila,columna:Integer;
  Data : TDataSet;
  MyDataSet:TDataSet;
  aplanta : string;

begin
  try
    excel:=CreateOleObject('Excel.Application');
  except
    ShowMessage('Excel no se pudo iniciar.');
    exit;
  end;

  cursor:=crSQLWait;
  application.ProcessMessages;
  excel.Visible:=true;

  Data:=self.DataSource1.DataSet;
  Data.First;
  fila:=2;
  columna:=1;
  excel.Workbooks.Add;

  excel.Cells[fila, 1].Value:='Stock de Obleas Global VTV';
  
  fila:=4;
    //Poner los títulos
     {for columna := 0 to Reja.Columns.Count-1 do
     begin
     excel.Cells[fila,columna + 1].Value:=Reja.Columns[columna].FieldName;
     end;}

     //solamente hay 7 columnas pongo los nombres a mano
     excel.Cells[fila, 1].Value:='AÑO';
     excel.Cells[fila, 2].Value:='IDMOVIMIENTO';
     excel.Cells[fila, 3].Value:='IDPLANTA';
     excel.Cells[fila, 4].Value:='SPLANTA';
     excel.Cells[fila, 5].Value:='CANTIDAD';
     excel.Cells[fila, 6].Value:='OBLEAINIC';
     excel.Cells[fila, 7].Value:='OBLEAFIN';

   fila:=5;

   self.DataSource1.DataSet.DisableControls;
   try
     while not(Data.eof) do
      begin

       for columna := 0 to Planilla.Columns.Count-1 do
       begin

        Excel.Cells[fila,columna + 1].Value:=Data.FieldByName(Planilla.Columns[Columna].FieldName).AsString;

       end;
        Data.Next;
        fila:= fila + 1;
      end;
      //Ajustar columnas
        for columna:=1 to 8 do
        begin
        Excel.Columns[Columna].EntireColumn.AutoFit;
        end;

   Except
   ShowMessage('Atención, se produjo un error en la transmisión.');
   end;

  self.DataSource1.DataSet.EnableControls;

 cursor:=crDefault;
 application.ProcessMessages;

end;

procedure TfListStockObleaGlobalExcel.FormShow(Sender: TObject);
begin
    DoLisStockGlobalV2(Sender);
end;

procedure TfListStockObleaGlobalExcel.SalirClick(Sender: TObject);
begin
    Close;
end;

end.
