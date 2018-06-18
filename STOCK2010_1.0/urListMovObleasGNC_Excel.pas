unit urListMovObleasGNC_Excel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, QRCtrls, jpeg, ExtCtrls, SqlExpr, globals, FMTBcd,
  Provider, DB, DBClient, RxMemDS, ExcelXP, OleServer, ComObj,
  StdCtrls, Buttons;

type
  TListaMovObleasGNCGlobal_Excel = class(TForm)
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
    RxMemoryData1IDMovimiento: TIntegerField;
    RxMemoryData1NomPlanta: TStringField;
    RxMemoryData1CodTaller: TIntegerField;
    RxMemoryData1Cantidad: TIntegerField;
    RxMemoryData1Anio: TIntegerField;
    RxMemoryData1ObleaInic: TIntegerField;
    RxMemoryData1ObleaFin: TIntegerField;
    RxMemoryData1FECHA: TDateField;
    Salir: TButton;
    procedure DoLisMovObleasGNCGlobalV2(Sender: TObject);
    procedure ExportarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SalirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ListaMovObleasGNCGlobal_Excel: TListaMovObleasGNCGlobal_Excel;

implementation

{$R *.dfm}

procedure TListaMovObleasGNCGlobal_Excel.DoLisMovObleasGNCGlobalV2(Sender: TObject);

begin
  with TListaMovObleasGNCGlobal_Excel.Create(application) do
   try
   SQLQuery1.SQLConnection:=mybd;
   SQLQuery1.Close;
   SQLQuery1.SQL.Clear;
   SQLQuery1.SQL.Add('SELECT TO_CHAR(FECHA,''DD/MM/YYYY'') AS FECHA, IDMOVIMIENTO, NOMPLANTA, CODTALLER, CANTIDAD, ANIO, OBLEAINIC, OBLEAFIN FROM TTMP_MOVIMIENTOS ORDER BY FECHA');
   SQLQuery1.ExecSQL();
   SQLQuery1.Open;
   self.RxMemoryData1.Close;
   self.RxMemoryData1.Open;
   while not SQLQuery1.Eof do
   begin
        self.RxMemoryData1.Append;
        self.RxMemoryData1Fecha.Value:=SQLQuery1.fieldbyname('FECHA').AsDateTime;
        self.RxMemoryData1IDMovimiento.Value:=SQLQuery1.fieldbyname('IDMOVIMIENTO').AsInteger;
        self.RxMemoryData1NomPlanta.Value:=trim(SQLQuery1.fieldbyname('NOMPLANTA').AsString);
        self.RxMemoryData1CodTaller.Value:=SQLQuery1.fieldbyname('CODTALLER').AsInteger;
        self.RxMemoryData1Cantidad.Value:=SQLQuery1.fieldbyname('CANTIDAD').AsInteger;
        self.RxMemoryData1Anio.Value:=SQLQuery1.fieldbyname('ANIO').AsInteger;
        self.RxMemoryData1ObleaInic.Value:=SQLQuery1.fieldbyname('OBLEAINIC').AsInteger;
        self.RxMemoryData1ObleaFin.Value:=SQLQuery1.fieldbyname('OBLEAFIN').AsInteger;
        self.RxMemoryData1.Post;

       SQLQuery1.Next;
   end;
   self.RxMemoryData1.First;

    finally
     consulta.Free;
     free;
    end;
end;

 procedure TListaMovObleasGNCGlobal_Excel.ExportarClick(Sender: TObject);
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

  excel.Cells[fila, 1].Value:='Movimiento de Obleas Global';
  fila:=4;
    //Poner los títulos
     {for columna := 0 to Reja.Columns.Count-1 do
     begin
     excel.Cells[fila,columna + 1].Value:=Reja.Columns[columna].FieldName;
     end;}

     //solamente hay 6 columnas pongo los nombres a mano
     excel.Cells[fila, 1].Value:='FECHA';
     excel.Cells[fila, 2].Value:='ID MOVIMIENTO';
     excel.Cells[fila, 3].Value:='NOMBRE PLANTA';
     excel.Cells[fila, 4].Value:='COD. TALLER';
     excel.Cells[fila, 5].Value:='CANTIDAD';
     excel.Cells[fila, 6].Value:='AÑO';
     excel.Cells[fila, 7].Value:='OBLEA INICIAL';
     excel.Cells[fila, 8].Value:='OBLEA FINAL';

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
        for columna:=1 to 9 do
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

procedure TListaMovObleasGNCGlobal_Excel.FormShow(Sender: TObject);
begin
    DoLisMovObleasGNCGlobalV2(Sender);

end;

procedure TListaMovObleasGNCGlobal_Excel.SalirClick(Sender: TObject);
begin
    Close;
end;

end.
