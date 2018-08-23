unit Udetalle_de_turnos_por_centros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls,uglobal,usuperregistry,uconst,QRExport, QRExtra, QRPDFFilt, QRWebFilt,comobj;

type
  Tdetalle_de_turnos_por_centros = class(TForm)
    GroupBox1: TGroupBox;
    DateTimePicker1: TDateTimePicker;
    BitBtn1: TBitBtn;
    GroupBox3: TGroupBox;
    DateTimePicker3: TDateTimePicker;
    GroupBox2: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    SaveDialog1: TSaveDialog;
    SaveDialog2: TSaveDialog;
    CheckBox1: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  detalle_de_turnos_por_centros: Tdetalle_de_turnos_por_centros;

implementation

uses Uinforme_detalle_por_turnos_por_centro, Umodulo, Uimprimir_turnos,
  Umensaje, Ureporte_cantidad;

{$R *.dfm}

procedure Tdetalle_de_turnos_por_centros.BitBtn1Click(Sender: TObject);
var sql,fecha_se,path,fecha_ha,fname,fecha_consulta:string;
 aPDF : TQRPDFDocumentFilter;
     canti:longint;
          fila_fecha:longint ;
          fila_concepto,i:longint;
          fila:longint;
 ExcelApp, ExcelLibro, ExcelHoja, ExcelHoja2: Variant;
begin
mensaje.Show;
application.ProcessMessages;
fecha_se:=datetostr(datetimepicker1.DateTime);
fecha_ha:=datetostr(datetimepicker3.DateTime);

if checkbox1.Checked then
begin
     SaveDialog1.FileName := informe_detalle_por_turnos_por_centro.QRMODMARCA.ReportTitle;
        If SaveDialog1.Execute Then
           Begin
              FName := SaveDialog1.FileName+'.xls';
              SaveDialog1.Files.SaveToFile(FName);
              end;

end;


{
 if radiobutton3.Checked then
begin
     SaveDialog2.FileName := informe_detalle_por_turnos_por_centro.QRMODMARCA.ReportTitle;
If SaveDialog2.Execute Then
   Begin
   informe_detalle_por_turnos_por_centro.Cursor := Screen.Cursor;
   Screen.Cursor := crHourGlass;
   FName := SaveDialog2.FileName+'.pdf';
   end;

end;

 }


sql:='select   '+
' c.centro as ccentro,  '+
' c.nombre  as cnombre,  '+
' r.fecha as rfecha,  '+
' r.patente as rpatente,  '+
' r.nombre as rnombre,  '+
' r.apellido as rapellido,  '+
' r.hora  as rhora   '+
' from centros c, reserva r where c.centro=r.centro  '+
' and r.fecha  between CONVERT(DATETIME,'+#39+fecha_se+#39+',103) and CONVERT(DATETIME,'+#39+fecha_ha+#39+',103)  '+
' group by r.fecha, c.centro, c.nombre,  r.patente, r.nombre, r.apellido, r.hora    '+
' order by r.fecha, c.centro, r.hora asc ';


informe_detalle_por_turnos_por_centro.ADOQuery1.Close;
informe_detalle_por_turnos_por_centro.ADOQuery1.SQL.Clear;
informe_detalle_por_turnos_por_centro.ADOQuery1.SQL.Add(sql);
informe_detalle_por_turnos_por_centro.ADOQuery1.Open;
informe_detalle_por_turnos_por_centro.ADOQuery1.ExecSQL;
informe_detalle_por_turnos_por_centro.ADOQuery1.Open;
if   informe_detalle_por_turnos_por_centro.ADOQuery1.RecordCount > 0 then
begin
   //genera_execel
       if checkbox1.Checked then
          begin
           ExcelApp := CreateOleObject('Excel.Application');
           ExcelLibro := ExcelApp.Workbooks.open(FName);
           ExcelLibro.Worksheets[1].Name := 'Reporte';
           ExcelHoja := ExcelLibro.Worksheets['Reporte'];

           excelHoja.cells[1, 1].Value := 'DETALLE DE RESERVAS POR TURNOS';

           //fecha
           excelHoja.cells[3, 1].Value := 'Fecha Desde: '+fecha_se;
           excelHoja.cells[3, 5].Value := 'Fecha Hasta: '+fecha_ha;
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
           for i:=1 to   informe_detalle_por_turnos_por_centro.ADOQuery1.RecordCount do
           begin

           if  informe_detalle_por_turnos_por_centro.ADOQuery1.fields[2].AsString <> fecha_consulta then
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


                 fecha_consulta:=informe_detalle_por_turnos_por_centro.ADOQuery1.fields[2].AsString;
                 excelHoja.cells[fila_fecha, 1].Value := 'Fecha : ';
                 excelHoja.cells[fila_fecha, 2].Value := fecha_consulta;

                 excelHoja.cells[fila_concepto, 1].Value := 'Hora';
                 excelHoja.cells[fila_concepto, 2].Value := 'Cód. Centro';
                 excelHoja.cells[fila_concepto, 3].Value := 'Centro';
                 excelHoja.cells[fila_concepto, 4].Value := 'Apellido';
                 excelHoja.cells[fila_concepto, 5].Value := 'Nombre';
                 excelHoja.cells[fila_concepto, 6].Value := 'Patente';



              end;

              excelHoja.cells[fila, 1].Value := informe_detalle_por_turnos_por_centro.ADOQuery1.fields[6].AsString;
              excelHoja.cells[fila, 2].Value := informe_detalle_por_turnos_por_centro.ADOQuery1.fields[0].AsString;
              excelHoja.cells[fila, 3].Value := informe_detalle_por_turnos_por_centro.ADOQuery1.fields[1].AsString;
              excelHoja.cells[fila, 4].Value := informe_detalle_por_turnos_por_centro.ADOQuery1.fields[5].AsString;
              excelHoja.cells[fila, 5].Value := informe_detalle_por_turnos_por_centro.ADOQuery1.fields[4].AsString;
              excelHoja.cells[fila, 6].Value := informe_detalle_por_turnos_por_centro.ADOQuery1.fields[3].AsString;

            //  canti:=canti + informe_detalle_por_turnos_por_centro.ADOQuery1.fields[0].asinteger;
              inc(fila);




                 informe_detalle_por_turnos_por_centro.ADOQuery1.Next;
           end;






             excellibro.saveas(FName);
            ExcelApp.DisplayAlerts := False;
            ExcelApp.Quit;
           end;



with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(APPLICATION_KEY) then
      Begin
     uglobal.ID_EMPRESA:=ReadString('Empresa');
      uglobal.ID_PLANTA:=ReadString('Planta');
      //actual:=ReadString('Conex_actual');
      end;
  Finally
    free;
  end;


    if uglobal.ID_EMPRESA='0003' then
    begin
    path := ExtractFilePath( Application.ExeName ) +'/Logo Applus Argentina.bmp' ;
    informe_detalle_por_turnos_por_centro.QRImage1.Picture.LoadFromFile(path);
    end;

    if uglobal.ID_EMPRESA='0001' then
    begin
    path := ExtractFilePath( Application.ExeName ) +'/Logo Applus Chile-3.bmp' ;
    informe_detalle_por_turnos_por_centro.QRImage1.Picture.LoadFromFile(path);
    end;


informe_detalle_por_turnos_por_centro.QRLabel5.Caption:=datetostr(datetimepicker1.DateTime);
informe_detalle_por_turnos_por_centro.QRLabel8.Caption:=datetostr(datetimepicker3.DateTime);
informe_detalle_por_turnos_por_centro.QRMODMARCA.Prepare;
mensaje.Hide;

if radiobutton2.Checked then
informe_detalle_por_turnos_por_centro.QRMODMARCA.Preview;

if radiobutton1.Checked then
informe_detalle_por_turnos_por_centro.QRMODMARCA.print;

  {
    if radiobutton3.Checked then
             begin
                 aPDF := TQRPDFDocumentFilter.Create(FName);
                informe_detalle_por_turnos_por_centro.QRMODMARCA.ExportToFilter(aPDF);
                aPDF.Free;
            end;

  }
end else
begin
mensaje.Hide;
showmessage('No se encotraron registros en la fecha: '+fecha_se);
end;

end;

procedure Tdetalle_de_turnos_por_centros.FormActivate(Sender: TObject);
begin
datetimepicker1.DateTime:=now;
datetimepicker3.DateTime:=now;
end;

end.
