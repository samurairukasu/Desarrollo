unit Ufrminformacionpago;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, FMTBcd, SqlExpr, Provider, DBClient, ComObj, RxMemDS,
  SpeedBar, ExtCtrls, OleServer, ExcelXP, StdCtrls, Globals, Buttons, ufPrintCertAn;

type
  Tfrminformacionpago = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    SQLDataSet1: TSQLDataSet;
    RxMemoryData1: TRxMemoryData;
    RxMemoryData1fecha: TStringField;
    RxMemoryData1nrocomprobante: TStringField;
    RxMemoryData1dominio: TStringField;
    RxMemoryData1idpago: TIntegerField;
    RxMemoryData1tipocomprobanteafip: TStringField;
    ExcelApplication1: TExcelApplication;
    ExcelWorkbook1: TExcelWorkbook;
    ExcelWorksheet1: TExcelWorksheet;
    ExportarExcel: TButton;
    BitBtn1: TBitBtn;
    RxMemoryData1cliente: TStringField;
    RxMemoryData1importetotal: TIntegerField;
    Label1: TLabel;
    CantiadadFact: TEdit;
    TotalNotasCredito: TLabel;
    CantidadNC: TEdit;
    Bevel1: TBevel;
    procedure ExportarExcelClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure CantiadadFactChange(Sender: TObject);
    procedure CantidadNCChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frminformacionpago: Tfrminformacionpago;

implementation

{$R *.dfm}

procedure Tfrminformacionpago.CantiadadFactChange(Sender: TObject);
  VAR  NumeroFacturas: string;
  begin

  with TSQLStoredProc.Create(application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_INFORMACIONPAGOS.INFORMACIONPAGOS_Count';
        Prepared := true;
        ParamByName('DateFrom').Value := DateIni;
        ParamByName('DateTo').Value := DateFin;

        ExecProc;

        Close;

        CantiadadFact.text := NumeroFacturas;
        NumeroFacturas := ParamByName('NumeroFacturas').AsString;

    finally
        Free;
    end;

  end;

procedure Tfrminformacionpago.CantidadNCChange(Sender: TObject);
  VAR NumeroNotasCredito: string;

  begin
    with TSQLStoredProc.Create(application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_INFORMACIONPAGOS.INFORMACIONPAGOS_Count';
        Prepared := true;
        ParamByName('DateFrom').Value := DateIni;
        ParamByName('DateTo').Value := DateFin;

        ExecProc;

        Close;

        CantidadNC.Text := NumeroNotasCredito;
        NumeroNotasCredito := ParamByName('NumeroNotasCredito').AsString;

    finally
        Free;
    end;

  end;

procedure Tfrminformacionpago.ExportarExcelClick(Sender: TObject);
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

  excel.Cells[fila, 1].Value:='LISTADO INFORMACION DE PAGOS';
  fila:=4;
    //Poner los títulos
     {for columna := 0 to Reja.Columns.Count-1 do
     begin
     excel.Cells[fila,columna + 1].Value:=Reja.Columns[columna].FieldName;
     end;}

     //solamente hay 6 columnas pongo los nombres a mano
     excel.Cells[fila, 1].Value:='Fecha';
     excel.Cells[fila, 2].Value:='Cliente';
     excel.Cells[fila, 3].Value:='Tipo Comprobante';
     excel.Cells[fila, 4].Value:='Nro Comprobante';
     excel.Cells[fila, 5].Value:='Importe Total';
     excel.Cells[fila, 6].Value:='Dominio';
     excel.Cells[fila, 7].Value:='External Reference';

   fila:=5;

   self.DataSource1.DataSet.DisableControls;
   try
     while not(Data.eof) do
      begin

       for columna := 0 to dbgrid1.Columns.Count-1 do
       begin

        Excel.Cells[fila,columna + 1].Value:=Data.FieldByName(dbgrid1.Columns[Columna].FieldName).AsString;

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

procedure Tfrminformacionpago.BitBtn1Click(Sender: TObject);
begin
close;
end;

end.
