unit Unitseleccione_fecha_turnos_por_plantilla;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, DB, RxMemDS;

type
  Tseleccione_fecha_turnos_por_plantilla = class(TForm)
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    ComboBox1: TComboBox;
    BitBtn1: TBitBtn;
    Button1: TButton;
    RxMemoryData1: TRxMemoryData;
    RxMemoryData1centro: TStringField;
    RxMemoryData1nombre: TStringField;
    RxMemoryData1asginado: TStringField;
    RxMemoryData1reservado: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  seleccione_fecha_turnos_por_plantilla: Tseleccione_fecha_turnos_por_plantilla;

implementation

uses Umodulo, Unitprocesando_e, Unitimprimie_asigandovsreservado;

{$R *.dfm}

procedure Tseleccione_fecha_turnos_por_plantilla.FormActivate(
  Sender: TObject);
begin
modulo.cargar_centros_combo(combobox1);
end;

procedure Tseleccione_fecha_turnos_por_plantilla.Button1Click(
  Sender: TObject);
begin
close;
end;

procedure Tseleccione_fecha_turnos_por_plantilla.BitBtn1Click(
  Sender: TObject);
  var sql,fd,fh:string;
  centro:string;
  posi,i:longint;
  rasignado, rreservado, suma_asignado, suma_reservado:longint;
  rcentro, rnombre:string;
begin
fd:=datetostr(datetimepicker1.DateTime);
fh:=datetostr(datetimepicker2.DateTime);
posi:=pos('-',trim(combobox1.Text));
centro:=trim(copy(trim(combobox1.Text),0,posi-1));
suma_asignado:=0;
suma_reservado:=0;

 procesando_e.Show;
 APPLICATION.ProcessMessages;
if centro='0' then
begin
sql:='select    '+
' sum(p.d0600+p.d0615+p.d0630+p.d0645+p.d0700+p.d0715+p.d0730+p.d0745+p.d0800+p.d0815+p.d0830+p.d0845+p.d0900+p.d0915+p.d0930+p.d0945+p.d1000+p.d1015+p.d1030+p.d1045  '+
' +p.d1100+p.d1115+p.d1130+p.d1145+p.d1200+p.d1215+p.d1230+p.d1245+p.d1300+p.d1315+p.d1330+p.d1345+p.d1400+p.d1415+p.d1430+p.d1445+p.d1500+p.d1515+p.d1530+p.d1545  '+
' +p.d1600+p.d1615+p.d1630+p.d1645+p.d1700+p.d1715+p.d1730+p.d1745+p.d1800+p.d1815+p.d1830+p.d1845+p.d1900+p.d1915+p.d1930+p.d1945+p.d2000+p.d2015+p.d2030+p.d2045+  '+
' p.d2100+p.d2115+p.d2130+p.d2145+p.d2200+p.d2215+p.d2230+p.d2245) as cantidad, c.centro, c.nombre   '+
' from plantilla p , centros c where p.desde between convert(datetime,'+#39+trim(fd)+#39+',103) and convert(datetime,'+#39+trim(fh)+#39+',103) and p.Hasta between convert(datetime,'+#39+trim(fd)+#39+',103) and convert(datetime,'+#39+trim(fh)+#39+',103)  '+
' and p.centro=c.centro group by c.centro, c.nombre order by cantidad asc';
  end else
  begin
   sql:='select    '+
' sum(p.d0600+p.d0615+p.d0630+p.d0645+p.d0700+p.d0715+p.d0730+p.d0745+p.d0800+p.d0815+p.d0830+p.d0845+p.d0900+p.d0915+p.d0930+p.d0945+p.d1000+p.d1015+p.d1030+p.d1045  '+
' +p.d1100+p.d1115+p.d1130+p.d1145+p.d1200+p.d1215+p.d1230+p.d1245+p.d1300+p.d1315+p.d1330+p.d1345+p.d1400+p.d1415+p.d1430+p.d1445+p.d1500+p.d1515+p.d1530+p.d1545  '+
' +p.d1600+p.d1615+p.d1630+p.d1645+p.d1700+p.d1715+p.d1730+p.d1745+p.d1800+p.d1815+p.d1830+p.d1845+p.d1900+p.d1915+p.d1930+p.d1945+p.d2000+p.d2015+p.d2030+p.d2045+  '+
' p.d2100+p.d2115+p.d2130+p.d2145+p.d2200+p.d2215+p.d2230+p.d2245) as cantidad, c.centro, c.nombre   '+
' from plantilla p , centros c where p.desde between convert(datetime,'+#39+trim(fd)+#39+',103) and convert(datetime,'+#39+trim(fh)+#39+',103) and p.Hasta between convert(datetime,'+#39+trim(fd)+#39+',103) and convert(datetime,'+#39+trim(fh)+#39+',103)  '+
' and c.centro='+#39+trim(centro)+#39+
' and p.centro=c.centro group by c.centro, c.nombre order by cantidad asc ';
  end;


modulo.sql_global.Close;
modulo.sql_global.SQL.Clear;
modulo.sql_global.SQL.Add(sql);
modulo.sql_global.ExecSQL;
modulo.sql_global.Open;
self.RxMemoryData1.Close;
self.RxMemoryData1.Open;
for i:= 1 to modulo.sql_global.RecordCount do
begin
      rasignado:=modulo.sql_global.Fields[0].asinteger;
      rcentro:=trim(modulo.sql_global.Fields[1].AsString);
      rnombre:=trim(modulo.sql_global.Fields[2].AsString);



        sql:='select count(*) ,c.centro, c.nombre from reserva r , centros c where  '+
             ' r.centro=c.centro and   '+
             ' r.fecha between convert(datetime,'+#39+trim(fd)+#39+',103) and convert(datetime,'+#39+trim(fh)+#39+',103)    '+
             ' and c.centro='+#39+trim(rcentro)+#39+
             ' group by c.centro, c.nombre'  ;
        modulo.sql_aux1.Close;
        modulo.sql_aux1.SQL.Clear;
        modulo.sql_aux1.SQL.Add(sql);
        modulo.sql_aux1.ExecSQL;
        modulo.sql_aux1.Open;
        rreservado:=modulo.sql_aux1.Fields[0].asinteger;

       self.RxMemoryData1.Append;
       self.RxMemoryData1centro.Value:=trim(rcentro);
       self.RxMemoryData1nombre.Value:=trim(rnombre);

        if  rasignado <   rreservado then
        begin
            self.RxMemoryData1asginado.Value:=inttostr(rreservado) ;
                suma_asignado:=suma_asignado +  rreservado;
         end
            else
            begin
              self.RxMemoryData1asginado.Value:=inttostr(rasignado);
              suma_asignado:=suma_asignado +  rasignado;
             end;

       self.RxMemoryData1reservado.Value:=inttostr(rreservado);


       suma_reservado:=suma_reservado +  rreservado;



       self.RxMemoryData1.Post;


modulo.sql_global.Next;
end;

  imprimie_asigandovsreservado.QRLabel5.Caption:=FD;
  imprimie_asigandovsreservado.QRLabel2.Caption:=FH;
  imprimie_asigandovsreservado.QRLabel9.Caption:=INTTOSTR(suma_ASIGNADO);
  imprimie_asigandovsreservado.QRLabel10.Caption:=INTTOSTR(suma_reservado);
  imprimie_asigandovsreservado.QRMODMARCA.Prepare;
  procesando_e.Close;
  imprimie_asigandovsreservado.QRMODMARCA.Preview;

end;

end.
