unit urListConsumosVTVxAnio_Excel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, QRCtrls, jpeg, ExtCtrls, SqlExpr, globals, FMTBcd,
  Provider, DB, DBClient, RxMemDS, ExcelXP, OleServer, ComObj,
  StdCtrls, Buttons;

type
  TListaConsumosVTVxAnio_Excel = class(TForm)
    Planilla: TDBGrid;
    Exportar: TButton;
    DataSource1: TDataSource;
    SQLQuery1: TSQLQuery;
    consulta: TClientDataSet;
    dspconsulta: TDataSetProvider;
    sdsconsulta: TSQLDataSet;
    ExcelApplication1: TExcelApplication;
    ExcelWorkbook1: TExcelWorkbook;
    ExcelWorksheet1: TExcelWorksheet;
    RxMemoryData1: TRxMemoryData;
    RxMemoryData1Planta: TStringField;
    RxMemoryData1Consumidas: TIntegerField;
    RxMemoryData1Anuladas: TIntegerField;
    RxMemoryData1Inutilizadas: TIntegerField;
    RxMemoryData1Total: TIntegerField;
    RxMemoryData1anio: TIntegerField;
    RxMemoryData1Taller: TIntegerField;
    Salir: TButton;
    procedure DoLisConsumosVTVxAnioV2(Sender: TObject);
    procedure ExportarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SalirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ListaConsumosVTVxAnio_Excel: TListaConsumosVTVxAnio_Excel;

implementation

{$R *.dfm}

procedure TListaConsumosVTVxAnio_Excel.DoLisConsumosVTVxAnioV2(Sender: TObject);

begin
  with TListaConsumosVTVxAnio_Excel.Create(application) do
   try
   SQLQuery1.SQLConnection:=mybd;
   SQLQuery1.Close;
   SQLQuery1.SQL.Clear;
   SQLQuery1.SQL.Add('SELECT SUBSTR(GET_NOMBRE_PLANTA(ZONA,PLANTA),1,25) SPLANTA, (ZONA||PLANTA) TALLER, EJERCICI, CONSUMIDAS, ANULADAS, INUTILIZADAS, TOTAL FROM TTMP_CONSUMOSANIO_VTV ORDER BY  TALLER,SPLANTA, EJERCICI');
   SQLQuery1.ExecSQL();
   SQLQuery1.Open;
   self.RxMemoryData1.Close;
   self.RxMemoryData1.Open;
   while not SQLQuery1.Eof do
   begin
        self.RxMemoryData1.Append;
        self.RxMemoryData1Planta.Value:=trim(SQLQuery1.fieldbyname('SPLANTA').AsString);
        self.RxMemoryData1Taller.Value:=SQLQuery1.fieldbyname('TALLER').AsInteger;
        self.RxMemoryData1anio.Value:=SQLQuery1.fieldbyname('EJERCICI').AsInteger;
        self.RxMemoryData1Consumidas.Value:=SQLQuery1.fieldbyname('CONSUMIDAS').AsInteger;
        self.RxMemoryData1Anuladas.Value:=SQLQuery1.fieldbyname('ANULADAS').AsInteger;
        self.RxMemoryData1Inutilizadas.Value:=SQLQuery1.fieldbyname('INUTILIZADAS').AsInteger;
        self.RxMemoryData1Total.Value:=SQLQuery1.fieldbyname('TOTAL').AsInteger;
        self.RxMemoryData1.Post;

       SQLQuery1.Next;
   end;
   self.RxMemoryData1.First;

    finally
     consulta.Free;
     free;
    end;
end;

 procedure TListaConsumosVTVxAnio_Excel.ExportarClick(Sender: TObject);
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

  excel.Cells[fila, 1].Value:='Obleas Consumidas x Año';
  fila:=4;
    //Poner los títulos
     {for columna := 0 to Reja.Columns.Count-1 do
     begin
     excel.Cells[fila,columna + 1].Value:=Reja.Columns[columna].FieldName;
     end;}

     //solamente hay 6 columnas pongo los nombres a mano
     excel.Cells[fila, 1].Value:='PLANTA';
     excel.Cells[fila, 2].Value:='TALLER';
     excel.Cells[fila, 3].Value:='AÑO';
     excel.Cells[fila, 4].Value:='CONSUMIDAS';
     excel.Cells[fila, 5].Value:='ANULADAS';
     excel.Cells[fila, 6].Value:='INUTILIZADAS';
     excel.Cells[fila, 7].Value:='TOTAL';

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

procedure TListaConsumosVTVxAnio_Excel.FormShow(Sender: TObject);
begin
    DoLisConsumosVTVxAnioV2(Sender);
end;

procedure TListaConsumosVTVxAnio_Excel.SalirClick(Sender: TObject);
begin
    Close;
end;

end.
