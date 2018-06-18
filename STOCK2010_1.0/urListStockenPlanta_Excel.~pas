unit urListStockenPlanta_Excel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, QRCtrls, jpeg, ExtCtrls, SqlExpr, globals, FMTBcd,
  Provider, DB, DBClient, RxMemDS, ExcelXP, OleServer, ComObj,
  StdCtrls, Buttons;

type
  TListaStockEnPlanta_Excel = class(TForm)
    Planilla: TDBGrid;
    Exportar: TButton;
    Salir: TButton;
    consulta: TClientDataSet;
    dspconsulta: TDataSetProvider;
    sdsconsulta: TSQLDataSet;
    ExcelApplication1: TExcelApplication;
    ExcelWorkbook1: TExcelWorkbook;
    ExcelWorksheet1: TExcelWorksheet;
    RxMemoryData1: TRxMemoryData;
    DataSource1: TDataSource;
    SQLQuery1: TSQLQuery;
    RxMemoryData1ANIO: TIntegerField;
    RxMemoryData1IDMOVIMIENTO: TIntegerField;
    RxMemoryData1CANTIDAD: TIntegerField;
    RxMemoryData1OBLEAINIC: TIntegerField;
    RxMemoryData1OBLEAFIN: TIntegerField;
    procedure DoLisStockenPlantaV2(Sender: TObject);
    procedure ExportarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SalirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ListaStockEnPlanta_Excel: TListaStockEnPlanta_Excel;

implementation

{$R *.dfm}

procedure TListaStockEnPlanta_Excel.DoLisStockenPlantaV2(Sender: TObject);

begin
  with TListaStockEnPlanta_Excel.Create(application) do
   try
   SQLQuery1.SQLConnection:=mybd;
   SQLQuery1.Close;
   SQLQuery1.SQL.Clear;
   SQLQuery1.SQL.Add('SELECT * FROM TTMP_STOCKOBLEAS ORDER BY ANIO');
   SQLQuery1.ExecSQL();
   SQLQuery1.Open;
   self.RxMemoryData1.Close;
   self.RxMemoryData1.Open;
   while not SQLQuery1.Eof do
   begin
        self.RxMemoryData1.Append;
        self.RxMemoryData1ANIO.Value:=SQLQuery1.fieldbyname('ANIO').AsInteger;
        self.RxMemoryData1IDMOVIMIENTO.Value:=SQLQuery1.fieldbyname('IDMOVIMIENTO').AsInteger;
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

 procedure TListaStockEnPlanta_Excel.ExportarClick(Sender: TObject);
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

  excel.Cells[fila, 1].Value:='Stock de Obleas VTV';
  
  fila:=4;
    //Poner los títulos
     {for columna := 0 to Reja.Columns.Count-1 do
     begin
     excel.Cells[fila,columna + 1].Value:=Reja.Columns[columna].FieldName;
     end;}

     //solamente hay 6 columnas pongo los nombres a mano
     excel.Cells[fila, 1].Value:='AÑO';
     excel.Cells[fila, 2].Value:='IDMOVIMIENTO';
     excel.Cells[fila, 3].Value:='CANTIDAD';
     excel.Cells[fila, 4].Value:='OBLEAINIC';
     excel.Cells[fila, 5].Value:='OBLEAFIN';

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
        for columna:=1 to 6 do
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

procedure TListaStockEnPlanta_Excel.FormShow(Sender: TObject);
begin
    DoLisStockenPlantaV2(Sender);
end;

procedure TListaStockEnPlanta_Excel.SalirClick(Sender: TObject);
begin
    Close;
end;

end.
