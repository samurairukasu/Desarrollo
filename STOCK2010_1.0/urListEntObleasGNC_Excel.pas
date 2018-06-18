unit urListEntObleasGNC_Excel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, QRCtrls, jpeg, ExtCtrls, SqlExpr, globals, FMTBcd,
  Provider, DB, DBClient, RxMemDS, ExcelXP, OleServer, ComObj,
  StdCtrls, Buttons;

type
  TListaEntradaObleas_Excel = class(TForm)
    Planilla: TDBGrid;
    Exportar: TButton;
    consulta: TClientDataSet;
    dspconsulta: TDataSetProvider;
    sdsconsulta: TSQLDataSet;
    ExcelApplication1: TExcelApplication;
    ExcelWorkbook1: TExcelWorkbook;
    ExcelWorksheet1: TExcelWorksheet;
    RxMemoryData1: TRxMemoryData;
    DataSource1: TDataSource;
    SQLQuery1: TSQLQuery;
    Salir: TButton;
    RxMemoryData1FECHA: TDateTimeField;
    RxMemoryData1PROVEEDOR: TStringField;
    RxMemoryData1COMPROBANTE: TIntegerField;
    RxMemoryData1EMPRESA: TStringField;
    RxMemoryData1CANTIDAD: TIntegerField;
    RxMemoryData1ANIO: TIntegerField;
    RxMemoryData1OBLEAINIC: TIntegerField;
    RxMemoryData1OBLEAFIN: TIntegerField;
    RxMemoryData1ZONA: TIntegerField;
    procedure DoLisEntObleasGNCGlobalV2(Sender: TObject);
    procedure ExportarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SalirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ListaEntradaObleas_Excel: TListaEntradaObleas_Excel;

implementation

{$R *.dfm}

procedure TListaEntradaObleas_Excel.DoLisEntObleasGNCGlobalV2(Sender: TObject);

begin
  with TListaEntradaObleas_Excel.Create(application) do
   try
   SQLQuery1.SQLConnection:=mybd;
   SQLQuery1.Close;
   SQLQuery1.SQL.Clear;
   SQLQuery1.SQL.Add('SELECT TO_CHAR(E.FECHA,''DD/MM/YYYY'') AS FECHA, e.proveedor, e.comprobante, e.empresa, e.cantidad, e.anio,');
   SQLQuery1.SQL.Add('DECODE( LENGTH(e.obleainic), 8, TO_CHAR(e.OBLEAINIC), ''0''||TO_CHAR(e.OBLEAINIC)) AS OBLEAINIC,');
   SQLQuery1.SQL.Add('DECODE( LENGTH(e.OBLEAFIN), 8, TO_CHAR(e.OBLEAFIN), ''0''||TO_CHAR(e.OBLEAFIN)) AS OBLEAFIN, e.zona');
   SQLQuery1.SQL.Add('FROM TTMP_ENTRADAS e ORDER BY e.FECHA');
   SQLQuery1.ExecSQL();
   SQLQuery1.Open;
   self.RxMemoryData1.Close;
   self.RxMemoryData1.Open;
   while not SQLQuery1.Eof do
   begin
        self.RxMemoryData1.Append;
        self.RxMemoryData1FECHA.Value:=SQLQuery1.fieldbyname('FECHA').AsDateTime;
        self.RxMemoryData1PROVEEDOR.Value:=trim(SQLQuery1.fieldbyname('PROVEEDOR').AsString);
        self.RxMemoryData1COMPROBANTE.Value:=SQLQuery1.fieldbyname('COMPROBANTE').AsInteger;
        self.RxMemoryData1EMPRESA.Value:=trim(SQLQuery1.fieldbyname('EMPRESA').AsString);
        self.RxMemoryData1CANTIDAD.Value:=SQLQuery1.fieldbyname('CANTIDAD').AsInteger;
        self.RxMemoryData1ANIO.Value:=SQLQuery1.fieldbyname('ANIO').AsInteger;
        self.RxMemoryData1OBLEAINIC.Value:=SQLQuery1.fieldbyname('OBLEAINIC').AsInteger;
        self.RxMemoryData1OBLEAFIN.Value:=SQLQuery1.fieldbyname('OBLEAFIN').AsInteger;
        self.RxMemoryData1ZONA.Value:=SQLQuery1.fieldbyname('ZONA').AsInteger;
        self.RxMemoryData1.Post;

       SQLQuery1.Next;
   end;
   self.RxMemoryData1.First;

    finally
     consulta.Free;
     free;
    end;
end;

 procedure TListaEntradaObleas_Excel.ExportarClick(Sender: TObject);
var
  excel:Variant;
  fila,columna:Integer;
  Data : TDataSet;
  MyDataSet:TDataSet;

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

  excel.Cells[fila, 1].Value:='Entrada de Obleas Global';
  fila:=4;
    //Poner los títulos
     {for columna := 0 to Reja.Columns.Count-1 do
     begin
     excel.Cells[fila,columna + 1].Value:=Reja.Columns[columna].FieldName;
     end;}

     //solamente hay 6 columnas pongo los nombres a mano
     excel.Cells[fila, 1].Value:='FECHA';
     excel.Cells[fila, 2].Value:='PROVEEDOR';
     excel.Cells[fila, 3].Value:='COMPROBANTE';
     excel.Cells[fila, 4].Value:='EMPRESA';
     excel.Cells[fila, 5].Value:='CANTIDAD';
     excel.Cells[fila, 6].Value:='AÑO';
     excel.Cells[fila, 7].Value:='OBLEA INICIAL';
     excel.Cells[fila, 8].Value:='OBLEA FINAL';
     excel.Cells[fila, 9].Value:='ZONA';

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
        for columna:=1 to 10 do
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

procedure TListaEntradaObleas_Excel.FormShow(Sender: TObject);
begin
    DoLisEntObleasGNCGlobalV2(Sender);
end;

procedure TListaEntradaObleas_Excel.SalirClick(Sender: TObject);
begin
    Close;
end;

end.
