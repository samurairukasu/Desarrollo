unit Unitseleccione_fecha_cantidad_turnos_globalizado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Buttons, StdCtrls,UGLOBAL;

type
  Tseleccione_fecha_cantidad_turnos_globalizado = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  seleccione_fecha_cantidad_turnos_globalizado: Tseleccione_fecha_cantidad_turnos_globalizado;

implementation

uses Unitcantidad_turnos_globalizado, Ureporte_cantidad, Umensaje,
  Unitprocesando_e;

{$R *.dfm}

procedure Tseleccione_fecha_cantidad_turnos_globalizado.SpeedButton1Click(
  Sender: TObject);
var sql,fd,fh,path1:string;
begin
  procesando_e.Show;
  APPLICATION.ProcessMessages;

fd:=datetostr(datetimepicker1.DateTime);
fh:=datetostr(datetimepicker2.DateTime);



sql:= 'select  '+
  ' count(*) as cantidad, '+
  ' r.centro as rcentro, '+
  ' c.nombre as cnombre  '+
  ' from reserva r, centros c '+
  ' where r.centro=c.centro  and  '+
  ' r.fecha between CONVERT(DATETIME,'+#39+fd+#39+',103) and CONVERT(DATETIME,'+#39+fh+#39+',103)  '+
  ' group by  r.centro, c.nombre  order by r.centro asc';




           //excelHoja.cells[F_FEE, C_DAT].Value := datebd(mybd);
          // excelHoja.cells[F_PLA, C_DAT].Value := PutEstacion;
          // excelHoja.cells[F_USU, C_DAT].Value := sUsuario;
          // excelHoja.cells[F_TDA, C_IMP].Value := eTransporte.text;
          // excelHoja.cells[F_CAR, C_IMP].Value := eCambio.text;
          // excelHoja.cells[F_CCC, C_IMP].Value := eCtaCte.text;



 cantidad_turnos_globalizado.ADOQuery1.Close;
cantidad_turnos_globalizado.ADOQuery1.SQL.Clear;
cantidad_turnos_globalizado.ADOQuery1.SQL.Add(sql);
cantidad_turnos_globalizado.ADOQuery1.Open;
cantidad_turnos_globalizado.ADOQuery1.ExecSQL;
cantidad_turnos_globalizado.ADOQuery1.Open;
if cantidad_turnos_globalizado.ADOQuery1.RecordCount > 0 then
begin

    {  //genera_execel
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

          // excelHoja.cells[5, 1].Value := 'Fecha :';
          // excelHoja.cells[6, 2].Value := 'Cód. Centro';
          // excelHoja.cells[6, 3].Value := 'Centro';
          // excelHoja.cells[6, 4].Value := 'Cantidad';

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

                 excelHoja.cells[fila_concepto, 2].Value := 'Cód. Centro';
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

   }


  if uglobal.ID_EMPRESA='0003' then
    begin
    path1 := ExtractFilePath( Application.ExeName ) +'/Logo Applus Argentina.bmp' ;
    cantidad_turnos_globalizado.QRImage1.Picture.LoadFromFile(path1);
    end;

    if uglobal.ID_EMPRESA='0001' then
    begin
    path1 := ExtractFilePath( Application.ExeName ) +'/Logo Applus Chile-3.bmp' ;
    cantidad_turnos_globalizado.QRImage1.Picture.LoadFromFile(path1);
    end;




cantidad_turnos_globalizado.QRLabel2.Caption:='Fecha desde: '+datetostr(datetimepicker1.DateTime);
cantidad_turnos_globalizado.QRLabel4.Caption:='Fecha hasta: '+datetostr(datetimepicker2.DateTime);

cantidad_turnos_globalizado.QRLabel1.Caption:='REPORTE DE CANTIDADES TOTALES DE TURNOS AGRUPADO POR PLANTAS';

reporte_cantidad.repConsumosGNCxAno.Prepare;
mensaje.hide;

  cantidad_turnos_globalizado.repConsumosGNCxAno.Cursor := Screen.Cursor;
   Screen.Cursor := crdefault;


   procesando_e.Close;
cantidad_turnos_globalizado.repConsumosGNCxAno.Preview ;


end;

END;

end.
