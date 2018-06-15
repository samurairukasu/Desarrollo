unit Uselecciona_plantilla;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons,ufunciones,UGLOBAL,uplantillas;

type
  Tselecciona_plantilla = class(TForm)
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    GroupBox2: TGroupBox;
    DBGrid2: TDBGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  selecciona_plantilla: Tselecciona_plantilla;

implementation

uses Umodulo, Umodificar_plantillas, Uver_plantillas;

{$R *.dfm}

procedure Tselecciona_plantilla.BitBtn1Click(Sender: TObject);
begin
close;
end;

procedure Tselecciona_plantilla.FormActivate(Sender: TObject);
var tf:tfuncion;
begin
  tf:=tfuncion.Create;
  tf.carga_plantillas_para_copia;
  tf.carga_canti_plantillas_para_copia(dbgrid1.Fields[6].asinteger);
  tf.Free;
end;

procedure Tselecciona_plantilla.DBGrid1CellClick(Column: TColumn);
var tf:tfuncion;
begin
 tf:=tfuncion.Create;
   tf.carga_canti_plantillas_para_copia(dbgrid1.Fields[6].asinteger);
   tf.Free;

end;

procedure Tselecciona_plantilla.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
var tf:tfuncion;
begin
if key=#13 then
 


end;

procedure Tselecciona_plantilla.DBGrid1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var tf:tfuncion;
begin

 tf:=tfuncion.Create;
   tf.carga_canti_plantillas_para_copia(dbgrid1.Fields[6].asinteger);
   tf.Free;




end;

procedure Tselecciona_plantilla.BitBtn2Click(Sender: TObject);
var idms ,POSI:longint;
tf:tfuncion;
tp:ttemplate;
begin

IF UGLOBAL.OPCION_FORMULARIO='COPIA' THEN
 BEGIN
    if MessageBox(0, '¿ Desea copiar esta Plantilla ?', 'Confirmación', +mb_YesNo +mb_ICONinformation) =6 then
       begin
        tf:=tfuncion.Create;
        tf.copiar_plantilla(dbgrid1.Fields[6].asinteger);
        tf.Free;

       end;

       close;

 END;


  IF UGLOBAL.OPCION_FORMULARIO='MODIFI' THEN
   BEGIN

        tp:=ttemplate.Create;
            if tp.chequea_si_hay_reservas(trim(DBGRID1.Fields[0].ASSTRING),trim(DBGRID1.Fields[1].ASSTRING))= true then
                begin
                MessageBox(0, 'Esta Plantilla no se puede modificar porque ya tiene reservas realizadas.', 'Atención', +mb_OK +mb_ICONwarning);
                
                exit;
                end;
              tp.Free;
       uglobal.NUMERO_PLANILLA_MODIFICA:=DBGRID1.Fields[6].ASINTEGER;

            modificar_plantillas.CheckBox4.Checked:=false;
       // if  tp.es_sabado(DBGRID1.Fields[0].ASSTRING) =true then
            if  trim(DBGRID1.Fields[7].ASSTRING)='s' then
            modificar_plantillas.CheckBox4.Checked:=true;



       modificar_plantillas.DateTimePicker1.DateTime:=STRTODATE(DBGRID1.Fields[0].ASSTRING);
       modificar_plantillas.DateTimePicker2.DateTime:=STRTODATE(DBGRID1.Fields[1].ASSTRING);
       UGLOBAL.FECHA_DESDE_ORIGINAL:=TRIM(DBGRID1.Fields[0].ASSTRING);
       UGLOBAL.FECHA_HASTA_ORIGINAL:=TRIM(DBGRID1.Fields[1].ASSTRING);
       posi:=pos(':',trim(DBGRID1.Fields[2].ASSTRING));
       modificar_plantillas.Edit3.Text:=copy(trim(DBGRID1.Fields[2].ASSTRING),0,posi-1);
       modificar_plantillas.Edit4.Text:=copy(trim(DBGRID1.Fields[2].ASSTRING),posi+1,length(trim(DBGRID1.Fields[2].ASSTRING)));

       posi:=pos(':',trim(DBGRID1.Fields[3].ASSTRING));
       modificar_plantillas.Edit5.Text:=copy(trim(DBGRID1.Fields[3].ASSTRING),0,posi-1);
       modificar_plantillas.Edit6.Text:=copy(trim(DBGRID1.Fields[3].ASSTRING),posi+1,length(trim(DBGRID1.Fields[3].ASSTRING)));

          if  trim(DBGRID1.Fields[4].ASSTRING)<>'' then
           begin
             posi:=pos(':',trim(DBGRID1.Fields[4].ASSTRING));
             modificar_plantillas.Edit7.Text:=copy(trim(DBGRID1.Fields[4].ASSTRING),0,posi-1);
             modificar_plantillas.Edit8.Text:=copy(trim(DBGRID1.Fields[4].ASSTRING),posi+1,length(trim(DBGRID1.Fields[4].ASSTRING)));

             posi:=pos(':',trim(DBGRID1.Fields[5].ASSTRING));
             modificar_plantillas.Edit9.Text:=copy(trim(DBGRID1.Fields[5].ASSTRING),0,posi-1);
             modificar_plantillas.Edit10.Text:=copy(trim(DBGRID1.Fields[5].ASSTRING),posi+1,length(trim(DBGRID1.Fields[5].ASSTRING)));

             modificar_plantillas.CheckBox1.Checked:=true;

            end;

             tf:=tfuncion.Create;
             UGLOBAL.ID_PLANTILLA_MODIFICA:=DBGRID1.Fields[6].asinteger;
             tf.muestra_grilla_para_modificar(DBGRID1.Fields[6].asinteger);
             tf.Free;
             modificar_plantillas.BitBtn3.Enabled:=true;
   close;
  END;

  
  IF UGLOBAL.OPCION_FORMULARIO='VER' THEN
   BEGIN
       ver_plantillas.DateTimePicker1.DateTime:=STRTODATE(DBGRID1.Fields[0].ASSTRING);
       ver_plantillas.DateTimePicker2.DateTime:=STRTODATE(DBGRID1.Fields[1].ASSTRING);
       posi:=pos(':',trim(DBGRID1.Fields[2].ASSTRING));
       ver_plantillas.Edit3.Text:=copy(trim(DBGRID1.Fields[2].ASSTRING),0,posi-1);
       ver_plantillas.Edit4.Text:=copy(trim(DBGRID1.Fields[2].ASSTRING),posi+1,length(trim(DBGRID1.Fields[2].ASSTRING)));

       posi:=pos(':',trim(DBGRID1.Fields[3].ASSTRING));
       ver_plantillas.Edit5.Text:=copy(trim(DBGRID1.Fields[3].ASSTRING),0,posi-1);
       ver_plantillas.Edit6.Text:=copy(trim(DBGRID1.Fields[3].ASSTRING),posi+1,length(trim(DBGRID1.Fields[3].ASSTRING)));

          if  trim(DBGRID1.Fields[4].ASSTRING)<>'' then
           begin
             posi:=pos(':',trim(DBGRID1.Fields[4].ASSTRING));
             ver_plantillas.Edit7.Text:=copy(trim(DBGRID1.Fields[4].ASSTRING),0,posi-1);
             ver_plantillas.Edit8.Text:=copy(trim(DBGRID1.Fields[4].ASSTRING),posi+1,length(trim(DBGRID1.Fields[4].ASSTRING)));

             posi:=pos(':',trim(DBGRID1.Fields[5].ASSTRING));
             ver_plantillas.Edit9.Text:=copy(trim(DBGRID1.Fields[5].ASSTRING),0,posi-1);
             ver_plantillas.Edit10.Text:=copy(trim(DBGRID1.Fields[5].ASSTRING),posi+1,length(trim(DBGRID1.Fields[5].ASSTRING)));



            end;

             tf:=tfuncion.Create;
             tf.muestra_grilla_para_ver(DBGRID1.Fields[6].asinteger);
             tf.muestra_grilla_acucistas_ver(DBGRID1.Fields[6].asinteger);
             tf.Free;
   close;
  END;



end;

end.
