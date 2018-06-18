unit Unitfrmver_remitos_certificados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, RxMemDS, SqlExpr, Grids, DBGrids,globals, StdCtrls,comobj,
  Buttons, Menus;

type
  Tfrmver_remitos_certificados = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    SQLQuery1: TSQLQuery;
    RxMemoryData1: TRxMemoryData;
    RxMemoryData1identrega: TIntegerField;
    RxMemoryData1proveedor: TStringField;
    RxMemoryData1inicial: TIntegerField;
    RxMemoryData1final: TIntegerField;
    RxMemoryData1cantidad: TIntegerField;
    RxMemoryData1nroremito: TStringField;
    RxMemoryData1fechaentrega: TStringField;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    SaveDialog1: TSaveDialog;
    PopupMenu1: TPopupMenu;
    REIMPRIMIRREMITO1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure REIMPRIMIRREMITO1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmver_remitos_certificados: Tfrmver_remitos_certificados;

implementation

uses Unitfrmregistrar_remitos_certificados;

{$R *.dfm}

procedure Tfrmver_remitos_certificados.FormCreate(Sender: TObject);
begin
self.RxMemoryData1.Close;
self.RxMemoryData1.Open;
self.SQLQuery1.SQLConnection:=globals.MyBD;
self.SQLQuery1.Close;
self.SQLQuery1.SQL.Clear;
self.SQLQuery1.SQL.Add('select 		IDENTREGA,PROVEEDOR	,	NROINICIAL,NROFINAL,CANTIDAD,NROREMITO,FECHAENTREGA,'+
'RECIBE,FECHALTA from TENTREGA_CERTIFICADOS order by fechalta asc');
self.SQLQuery1.ExecSQL;
self.SQLQuery1.Open;
while not self.SQLQuery1.Eof do
begin

      self.RxMemoryData1.Append;
      self.RxMemoryData1identrega.Value:=self.SQLQuery1.fieldbyname('IDENTREGA').AsInteger;
      self.RxMemoryData1proveedor.Value:=trim(self.SQLQuery1.fieldbyname('PROVEEDOR').Asstring);
      self.RxMemoryData1inicial.value:=self.SQLQuery1.fieldbyname('NROINICIAL').AsInteger;
      self.RxMemoryData1final.Value:=self.SQLQuery1.fieldbyname('NROFINAL').AsInteger;
      self.RxMemoryData1cantidad.Value:=self.SQLQuery1.fieldbyname('CANTIDAD').AsInteger;
      self.RxMemoryData1nroremito.Value:=trim(self.SQLQuery1.fieldbyname('NROREMITO').Asstring);
      self.RxMemoryData1fechaentrega.Value:=trim(self.SQLQuery1.fieldbyname('FECHAENTREGA').Asstring);
      self.RxMemoryData1.post;

self.SQLQuery1.Next;
end;
 self.RxMemoryData1.First;

end;

procedure Tfrmver_remitos_certificados.BitBtn2Click(Sender: TObject);
begin
close;
end;

procedure Tfrmver_remitos_certificados.BitBtn1Click(Sender: TObject);
var 
 CANTI,fila_fecha,FILA,fila_concepto,I:LONGINT;   fecha_consulta,FName:sTRING;
 ExcelApp, ExcelLibro, ExcelHoja, ExcelHoja2: Variant;
begin

 SaveDialog1.FileName :='certificados';
        If SaveDialog1.Execute Then
           Begin
              FName := SaveDialog1.FileName+'.xls';
              SaveDialog1.Files.SaveToFile(FName);
              end;



ExcelApp := CreateOleObject('Excel.Application');
           ExcelLibro := ExcelApp.Workbooks.open(FName);
           ExcelLibro.Worksheets[1].Name := 'Certificados';
           ExcelHoja := ExcelLibro.Worksheets['Certificados'];

           excelHoja.cells[1, 1].Value := 'CERTIFICADOS';

           //fecha


           {
           excelHoja.cells[5, 1].Value := 'Fecha :';
           excelHoja.cells[6, 2].Value := 'Cód. Centro';
           excelHoja.cells[6, 3].Value := 'Centro';
           excelHoja.cells[6, 4].Value := 'Cantidad';
            }
            canti:=0;
          fila_fecha:=5;
          fila_concepto:=6;
          fila:=7;
          fecha_consulta:='-';
          self.RxMemoryData1.Open;
          self.RxMemoryData1.First;
           WHILE NOT self.RxMemoryData1.Eof DO
           begin


                  if i > 1 then
                  begin
                 // fila:=fila + 1;
                 // excelHoja.cells[fila, 3].Value :='Total ';
                 // excelHoja.cells[fila, 4].Value :=inttostr(canti);
                 // canti:=0;
                    fila_fecha:=fila + 2;
                    fila_concepto:=fila_fecha + 1;
                    fila:= fila_concepto + 1;
                   end;





                 excelHoja.cells[fila_concepto, 1].Value := 'PROVEEDOR';
                 excelHoja.cells[fila_concepto, 2].Value := 'INICIAL';
                 excelHoja.cells[fila_concepto, 3].Value := 'FINAL';
                 excelHoja.cells[fila_concepto, 4].Value := 'CANTIDAD';
                 excelHoja.cells[fila_concepto, 5].Value := 'NRO REMITO';
                 excelHoja.cells[fila_concepto, 6].Value := 'FECHA ENTREGA';





              excelHoja.cells[fila, 1].Value := TRIM(SELF.RxMemoryData1proveedor.Value);
              excelHoja.cells[fila, 2].Value := TRIM(INTTOSTR(SELF.RxMemoryData1inicial.VALUE));
              excelHoja.cells[fila, 3].Value := TRIM(INTTOSTR(SELF.RxMemoryData1final.Value));
              excelHoja.cells[fila, 4].Value := TRIM(INTTOSTR(SELF.RxMemoryData1cantidad.VALUE));
              excelHoja.cells[fila, 5].Value := TRIM(SELF.RxMemoryData1nroremito.Value);
              excelHoja.cells[fila, 6].Value := TRIM(SELF.RxMemoryData1fechaentrega.Value);

            //  canti:=canti + informe_detalle_por_turnos_por_centro.ADOQuery1.fields[0].asinteger;
              inc(fila);




                 RxMemoryData1.Next;
           end;






           excellibro.saveas(FName);
            ExcelApp.DisplayAlerts := False;
            ExcelApp.Quit;
          end;


procedure Tfrmver_remitos_certificados.REIMPRIMIRREMITO1Click(
  Sender: TObject);
begin

frmregistrar_remitos_certificados.IMPRIMIR_REMITO(SELF.RxMemoryData1identrega.Value);
end;

end.
