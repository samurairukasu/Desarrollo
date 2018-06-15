unit Udetalle_cantidad_por_centro_por_fecha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls,uglobal,usuperregistry, DataExport,
  DataToXLS, DB,QRExport, QRExtra, QRPDFFilt, QRWebFilt,comobj;

type
  Tdetalle_cantidad_por_centro_por_fecha = class(TForm)
    GroupBox1: TGroupBox;
    DateTimePicker1: TDateTimePicker;
    GroupBox2: TGroupBox;
    DateTimePicker2: TDateTimePicker;
    BitBtn1: TBitBtn;
    SaveDialog1: TSaveDialog;
    SaveDialog2: TSaveDialog;
    GroupBox3: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    GroupBox4: TGroupBox;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    opcion:longint;
  end;

var
  detalle_cantidad_por_centro_por_fecha: Tdetalle_cantidad_por_centro_por_fecha;

implementation

uses Uimprime_detalle_cantidad_por_centro_por_fecha, Umensaje,
  Ureporte_cantidad;

{$R *.dfm}

procedure Tdetalle_cantidad_por_centro_por_fecha.BitBtn1Click(
  Sender: TObject);
var fd,fh,sql,path1,FName,fecha_consulta:string;
 aPDF : TQRPDFDocumentFilter;
    ExcelApp, ExcelLibro, ExcelHoja, ExcelHoja2: Variant;
    i,fila,fila_fecha,fila_concepto,canti:longint;

begin

mensaje.show;
application.ProcessMessages;
fd:=datetostr(datetimepicker1.DateTime);
fh:=datetostr(datetimepicker2.DateTime);





if radiobutton4.Checked then
begin
     SaveDialog1.FileName := reporte_cantidad.repConsumosGNCxAno.ReportTitle;
If SaveDialog1.Execute Then
   Begin
    {
    reporte_cantidad.Cursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    }
    FName := SaveDialog1.FileName+'.xls';
    SaveDialog1.Files.SaveToFile(FName);
         //  FTmp.Temporizar(TRUE,FALSE,'Liquidaci�n de caja Diaria', 'Exportando los datos a excel');




   end;

end;



 if radiobutton3.Checked then
begin
     SaveDialog2.FileName := reporte_cantidad.repConsumosGNCxAno.ReportTitle;
If SaveDialog2.Execute Then
   Begin
   reporte_cantidad.Cursor := Screen.Cursor;
   Screen.Cursor := crHourGlass;
   FName := SaveDialog2.FileName+'.pdf';
   end;

end;




if opcion=1 then
begin
sql:='select '+
 ' count(*) as cantidad, '+
 ' CONVERT(DATETIME,r.fecha,103) as rfecha,  '   +
 ' r.centro as rcentro,  '  +
 ' c.nombre as cnombre    '  +
 ' from reserva r, centros c  ' +
 ' where r.centro=c.centro  and '  +
 ' r.fecha between CONVERT(DATETIME,'+#39+fd+#39+',103) and CONVERT(DATETIME,'+#39+fh+#39+',103) '+
 ' group by CONVERT(DATETIME,r.fecha,103), r.centro, c.nombre order by CONVERT(DATETIME,r.fecha,103) asc ' ;






           //excelHoja.cells[F_FEE, C_DAT].Value := datebd(mybd);
          // excelHoja.cells[F_PLA, C_DAT].Value := PutEstacion;
          // excelHoja.cells[F_USU, C_DAT].Value := sUsuario;
          // excelHoja.cells[F_TDA, C_IMP].Value := eTransporte.text;
          // excelHoja.cells[F_CAR, C_IMP].Value := eCambio.text;
          // excelHoja.cells[F_CCC, C_IMP].Value := eCtaCte.text;



 reporte_cantidad.ADOQuery1.Close;
reporte_cantidad.ADOQuery1.SQL.Clear;
reporte_cantidad.ADOQuery1.SQL.Add(sql);
reporte_cantidad.ADOQuery1.Open;
reporte_cantidad.ADOQuery1.ExecSQL;
reporte_cantidad.ADOQuery1.Open;
if reporte_cantidad.ADOQuery1.RecordCount > 0 then
begin

      //genera_execel
       if radiobutton4.Checked then
          begin
           ExcelApp := CreateOleObject('Excel.Application');
           ExcelLibro := ExcelApp.Workbooks.open(FName);
           ExcelLibro.Worksheets[1].Name := 'Reporte';
           ExcelHoja := ExcelLibro.Worksheets['Reporte'];

           excelHoja.cells[1, 1].Value := 'DETALLE DE CANTIDAD DE TURNOS';

           //fecha
           excelHoja.cells[3, 1].Value := 'Fecha Desde: '+fd;
           excelHoja.cells[3, 5].Value := 'Fecha Hasta: '+fh;
           {
           excelHoja.cells[5, 1].Value := 'Fecha :';
           excelHoja.cells[6, 2].Value := 'C�d. Centro';
           excelHoja.cells[6, 3].Value := 'Centro';
           excelHoja.cells[6, 4].Value := 'Cantidad';
            }
            canti:=0;
          fila_fecha:=5;
          fila_concepto:=6;
          fila:=7;
          fecha_consulta:='-';
           for i:=1 to   reporte_cantidad.ADOQuery1.RecordCount do
           begin

           if  reporte_cantidad.ADOQuery1.fields[1].AsString <> fecha_consulta then
              begin
                  if i > 1 then
                  begin
                  fila:=fila + 1;
                  excelHoja.cells[fila, 3].Value :='Total ';
                  excelHoja.cells[fila, 4].Value :=inttostr(canti);
                  canti:=0;
                    fila_fecha:=fila + 2;
                    fila_concepto:=fila_fecha + 1;
                    fila:= fila_concepto + 1;
                   end;


                 fecha_consulta:=reporte_cantidad.ADOQuery1.fields[1].AsString;
                 excelHoja.cells[fila_fecha, 1].Value := 'Fecha : ';
                 excelHoja.cells[fila_fecha, 2].Value := fecha_consulta;

                 excelHoja.cells[fila_concepto, 2].Value := 'C�d. Centro';
                 excelHoja.cells[fila_concepto, 3].Value := 'Centro';
                 excelHoja.cells[fila_concepto, 4].Value := 'Cantidad';




              end;

            //  excelHoja.cells[fila, 1].Value := reporte_cantidad.ADOQuery1.fields[1].AsString;
              excelHoja.cells[fila, 2].Value := reporte_cantidad.ADOQuery1.fields[2].AsString;
              excelHoja.cells[fila, 3].Value := reporte_cantidad.ADOQuery1.fields[3].AsString;
              excelHoja.cells[fila, 4].Value := reporte_cantidad.ADOQuery1.fields[0].AsString;
              canti:=canti + reporte_cantidad.ADOQuery1.fields[0].asinteger;
              inc(fila);




                 reporte_cantidad.ADOQuery1.Next;
           end;
                  fila:=fila + 1;
                  excelHoja.cells[fila, 3].Value :='Total ';
                  excelHoja.cells[fila, 4].Value :=inttostr(canti);

             excellibro.saveas(FName);
            ExcelApp.DisplayAlerts := False;
            ExcelApp.Quit;
           end;




  if uglobal.ID_EMPRESA='0003' then
    begin
    path1 := ExtractFilePath( Application.ExeName ) +'/Logo Applus Argentina.bmp' ;
    reporte_cantidad.QRImage1.Picture.LoadFromFile(path1);
    end;

    if uglobal.ID_EMPRESA='0001' then
    begin
    path1 := ExtractFilePath( Application.ExeName ) +'/Logo Applus Chile-3.bmp' ;
    reporte_cantidad.QRImage1.Picture.LoadFromFile(path1);
    end;




reporte_cantidad.QRLabel2.Caption:='Fecha desde: '+datetostr(datetimepicker1.DateTime);
reporte_cantidad.QRLabel4.Caption:='Fecha hasta: '+datetostr(datetimepicker2.DateTime);

reporte_cantidad.QRLabel1.Caption:='DETALLE DE CANTIDAD DE TURNOS';

reporte_cantidad.repConsumosGNCxAno.Prepare;
mensaje.hide;

  reporte_cantidad.repConsumosGNCxAno.Cursor := Screen.Cursor;
   Screen.Cursor := crdefault;


if radiobutton1.Checked then
reporte_cantidad.repConsumosGNCxAno.Print ;

if radiobutton2.Checked then
reporte_cantidad.repConsumosGNCxAno.Preview ;




          if radiobutton3.Checked then
             begin
                 aPDF := TQRPDFDocumentFilter.Create(FName);
                reporte_cantidad.repConsumosGNCxAno.ExportToFilter(aPDF);
                aPDF.Free;
            end;

end else
begin
mensaje.hide;
 showmessage('No se encotraron registros.');
end;
end;//opcion 1



if opcion=2 then
begin
sql:='select '+
 ' count(*) as cantidad, '+
 ' SUBSTRING(CONVERT(varchar,r.fechalta,103),1,10) as rfecha, '+
 ' r.centro as rcentro,  '  +
 ' c.nombre as cnombre    '  +
 ' from reserva r, centros c  ' +
 ' where r.centro=c.centro  and '  +
 ' r.fechalta between CONVERT(DATETIME,'+#39+fd+#39+', 103) and CONVERT(DATETIME,'+#39+fh+#39+', 103) '+
 ' group by SUBSTRING(CONVERT(varchar, r.fechalta, 103),1,10) , r.centro, c.nombre order by SUBSTRING(CONVERT(varchar, r.fechalta, 103),1,10) asc ' ;

   //  ' CONVERT(DATETIME,r.fechalta,103) as rfecha,




reporte_cantidad.ADOQuery1.Close;
reporte_cantidad.ADOQuery1.SQL.Clear;
reporte_cantidad.ADOQuery1.SQL.Add(sql);
reporte_cantidad.ADOQuery1.Open;
reporte_cantidad.ADOQuery1.ExecSQL;
reporte_cantidad.ADOQuery1.Open;
if reporte_cantidad.ADOQuery1.RecordCount > 0 then
begin


     //genera_execel
       if radiobutton4.Checked then
          begin
           ExcelApp := CreateOleObject('Excel.Application');
           ExcelLibro := ExcelApp.Workbooks.open(FName);
           ExcelLibro.Worksheets[1].Name := 'Reporte';
           ExcelHoja := ExcelLibro.Worksheets['Reporte'];

           excelHoja.cells[1, 1].Value := 'DETALLE DE CANTIDAD DE TURNOS POR FECHA DE REGISTRO';

           //fecha
           excelHoja.cells[3, 1].Value := 'Fecha Desde: '+fd;
           excelHoja.cells[3, 5].Value := 'Fecha Hasta: '+fh;
           {
           excelHoja.cells[5, 1].Value := 'Fecha :';
           excelHoja.cells[6, 2].Value := 'C�d. Centro';
           excelHoja.cells[6, 3].Value := 'Centro';
           excelHoja.cells[6, 4].Value := 'Cantidad';
            }
            canti:=0;
          fila_fecha:=5;
          fila_concepto:=6;
          fila:=7;
          fecha_consulta:='-';
           for i:=1 to   reporte_cantidad.ADOQuery1.RecordCount do
           begin

           if  reporte_cantidad.ADOQuery1.fields[1].AsString <> fecha_consulta then
              begin
                  if i > 1 then
                  begin
                  fila:=fila + 1;
                  excelHoja.cells[fila, 3].Value :='Total ';
                  excelHoja.cells[fila, 4].Value :=inttostr(canti);
                  canti:=0;
                    fila_fecha:=fila + 2;
                    fila_concepto:=fila_fecha + 1;
                    fila:= fila_concepto + 1;
                   end;


                 fecha_consulta:=reporte_cantidad.ADOQuery1.fields[1].AsString;
                 excelHoja.cells[fila_fecha, 1].Value := 'Fecha : ';
                 excelHoja.cells[fila_fecha, 2].Value := fecha_consulta;

                 excelHoja.cells[fila_concepto, 2].Value := 'C�d. Centro';
                 excelHoja.cells[fila_concepto, 3].Value := 'Centro';
                 excelHoja.cells[fila_concepto, 4].Value := 'Cantidad';




              end;

            //  excelHoja.cells[fila, 1].Value := reporte_cantidad.ADOQuery1.fields[1].AsString;
              excelHoja.cells[fila, 2].Value := reporte_cantidad.ADOQuery1.fields[2].AsString;
              excelHoja.cells[fila, 3].Value := reporte_cantidad.ADOQuery1.fields[3].AsString;
              excelHoja.cells[fila, 4].Value := reporte_cantidad.ADOQuery1.fields[0].AsString;
              canti:=canti + reporte_cantidad.ADOQuery1.fields[0].asinteger;
              inc(fila);




                 reporte_cantidad.ADOQuery1.Next;
           end;
                  fila:=fila + 1;
                  excelHoja.cells[fila, 3].Value :='Total ';
                  excelHoja.cells[fila, 4].Value :=inttostr(canti);

             excellibro.saveas(FName);
            ExcelApp.DisplayAlerts := False;
            ExcelApp.Quit;
           end;



  if uglobal.ID_EMPRESA='0003' then
    begin
    path1 := ExtractFilePath( Application.ExeName ) +'/Logo Applus Argentina.bmp' ;
    reporte_cantidad.QRImage1.Picture.LoadFromFile(path1);
    end;

    if uglobal.ID_EMPRESA='0001' then
    begin
    path1 := ExtractFilePath( Application.ExeName ) +'/Logo Applus Chile-3.bmp' ;
    reporte_cantidad.QRImage1.Picture.LoadFromFile(path1);
    end;




reporte_cantidad.QRLabel2.Caption:='Fecha desde: '+datetostr(datetimepicker1.DateTime);
reporte_cantidad.QRLabel4.Caption:='Fecha hasta: '+datetostr(datetimepicker2.DateTime);

reporte_cantidad.QRLabel1.Caption:='DETALLE DE CANTIDAD DE TURNOS POR FECHA DE REGISTRO';

reporte_cantidad.repConsumosGNCxAno.Prepare;
mensaje.hide;

 reporte_cantidad.repConsumosGNCxAno.Cursor := Screen.Cursor;
   Screen.Cursor := crdefault;

if radiobutton1.Checked then
reporte_cantidad.repConsumosGNCxAno.Print ;

if radiobutton2.Checked then
reporte_cantidad.repConsumosGNCxAno.Preview ;


       


           if radiobutton3.Checked then
             begin
                 aPDF := TQRPDFDocumentFilter.Create(FName);
                reporte_cantidad.repConsumosGNCxAno.ExportToFilter(aPDF);
                aPDF.Free;
            end;





end else
begin
mensaje.hide;
 showmessage('No se encotraron registros.');
end;
end;//opcion 1





end;

procedure Tdetalle_cantidad_por_centro_por_fecha.FormActivate(
  Sender: TObject);
begin
DATETIMEPICKER1.DateTime:=NOW;
DATETIMEPICKER2.DateTime:=NOW;
radiobutton2.Checked;
end;

end.
