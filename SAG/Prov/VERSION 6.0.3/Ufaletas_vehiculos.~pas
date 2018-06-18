unit Ufaletas_vehiculos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, Buttons, ToolWin, ComCtrls, DB, FMTBcd, SqlExpr,
  StdCtrls, globals,
  DBCtrls, USAGClasses,USAGDOMINIOS,USAGESTACION, ADODB, ExtCtrls, UCDIALGS;

type
  Tfrmalertas_vehiculos = class(TForm)
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Edit5: TEdit;
    Label6: TLabel;
    Edit6: TEdit;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmalertas_vehiculos: Tfrmalertas_vehiculos;

implementation

uses Unitnueva_alerta;

{$R *.dfm}

procedure Tfrmalertas_vehiculos.SpeedButton1Click(Sender: TObject);
VAR CODVEHI, i:LONGINT;
    fechaalta,motivo,sql_con,patente:string;
    idusuario:longint;
      sql_global: TSQLQuery;
begin
if trim(edit1.Text)='' then
 begin
     MessageDlg(caption,'Debe ingresar la pantente del vehículo.',mteRROR,[mbYes],mbyes,0)  ;
     edit1.Color:=clinfobk;
     edit1.SetFocus;
     exit;
 end;
  if not (TDominio.TipoDominio(Trim(edit1.Text)) in [ttdmAntiguo, ttdmAutos, ttdmMotos, ttdmTractor, ttdmEmbajada,ttdmDiplomatica,ttdmMercosur]) then
  begin
       MessageDlg(caption,'El formato de la patente es incorrecto.',mteRROR,[mbYes],mbyes,0)  ;
     edit1.Color:=clinfobk;
     edit1.SetFocus;
     exit;
  end;

 if trim(edit3.Text)='' then
 begin
     MessageDlg(caption,'Debe ingresar el motivo del alerta.',mteRROR,[mbYes],mbyes,0)  ;
     edit3.Color:=clinfobk;
     edit3.SetFocus;
     exit;
 end;



   with TSQLQuery.Create(self) do
          try
            SQLConnection:=mybd;

                close;
            sql.clear;
            SQL.Add('SELECT patenten FROM patente_en_alerta WHERE PATENTEN=:PATENTE AND FECHABAJA IS NULL');
            ParamByName('PATENTE').AsString:=EDIT1.Text;
            OPEN;
               if  not (IsEmpty) then
               begin
                   MessageDlg(caption,'La Patente ingresada ya tiene un alerta activo.',mteRROR,[mbYes],mbyes,0)  ;
               exit;
               end;

              close;
            sql.clear;
            SQL.Add('SELECT codvehic FROM tvehiculos WHERE PATENTEN=:PATENTE');
            ParamByName('PATENTE').AsString:=EDIT1.Text;
            OPEN;

                if (IsEmpty) then
                   MessageDlg(caption,'La Patente ingresada no pertenece a ningún vehículo.',mteRROR,[mbYes],mbyes,0)
                   else
                   begin


                        CODVEHI:=Fields[0].AsInteger;
                        fechaalta:=datetostr(date);
                        motivo:=trim(edit3.Text);
                        patente:=trim(edit1.Text);
                        idusuario:=GLOBALS.IDUSUARIO_ALERTAS;
                         close;
                         sql.clear;
                         sql.add('alter session set nls_date_format = ''dd/mm/yyyy''');
                         execsql;


                         close;
                         sql.clear;
                         SQL.Add('insert into patente_en_alerta (FECHALTA, codvehic, patenten, idusuario_alta, motivo)');
                          SQL.Add('VALUES(:FECHALTA,:CODVEHI,:PATENTE,:IDUSUARIO,:MOTIVO)');

                         ParamByName('FECHALTA').AsString:=trim(fechaalta);
                         ParamByName('CODVEHI').ASINTEGER:=CODVEHI;
                         ParamByName('PATENTE').AsString:=trim(patente);
                         ParamByName('IDUSUARIO').ASINTEGER:=idusuario;
                         ParamByName('MOTIVO').AsString:=trim(MOTIVO);
                        ExecSQL;
                        MessageDlg(caption,'Se ha procesado el alerta.',mtconfirmation,[mbYes],mbyes,0);
                        edit1.Clear;
                        edit2.Clear;
                        edit3.Clear;
                        edit4.Clear;
                        edit5.Clear;
                        edit6.Clear;



                   end;


          except
            MessageDlg(caption,'Se produjo un error al intentar procesar el alerta.',mteRROR,[mbYes],mbyes,0);
          end;



 


end;

procedure Tfrmalertas_vehiculos.SpeedButton3Click(Sender: TObject);
var sql_global: TSQLQuery;
idalta,idbaja:longint;
idalta_s, idbaja_s:string;
begin
if trim(edit1.Text)='' then
 begin
     MessageDlg(caption,'Debe ingresar la pantente del vehículo.',mteRROR,[mbYes],mbyes,0)  ;
     edit1.Color:=clinfobk;
     edit1.SetFocus;
     exit;
 end;

 try
    sql_global:= TSQLQuery.Create(self);
     sql_global.SQLConnection:=mybd;
     sql_global.Close;
     sql_global.SQL.Clear;
     sql_global.SQL.Add('SELECT FECHALTA, codvehic, patenten, idusuario_alta, motivo, fechabaja, idusuario_baja FROM patente_en_alerta WHERE PATENTEN=:PATENTE');
     sql_global.ParamByName('PATENTE').AsString:=trim(EDIT1.Text);
     sql_global.Open;
     if not (sql_global.IsEmpty) then
     begin
     edit2.Text:=trim(sql_global.Fields[0].AsString);
     edit3.Text:=trim(sql_global.Fields[4].AsString);
     edit5.Text:=trim(sql_global.Fields[5].AsString);
     idalta_s:=sql_global.Fields[3].asstring;
     idbaja_s:=sql_global.Fields[6].asstring;
      sql_global.Free;
       if  trim(idalta_s)<>'' then
        begin
        idalta:=strtoint(trim(idalta_s));
          sql_global:= TSQLQuery.Create(self);
          sql_global.SQLConnection:=mybd;
          sql_global.Close;
          sql_global.SQL.Clear;
          sql_global.SQL.Add('select nombre from tusuario where idusuario=:idusuario');
          sql_global.ParamByName('idusuario').asinteger:=idalta;
          sql_global.Open;
          edit4.Text:=trim(sql_global.Fields[0].AsString);
          sql_global.Free;
        end;
           if  trim(idbaja_s)<>'' then
        begin
           idbaja:=strtoint(trim(idbaja_s));
           sql_global:= TSQLQuery.Create(self);
          sql_global.SQLConnection:=mybd;
          sql_global.Close;
          sql_global.SQL.Clear;
          sql_global.SQL.Add('select nombre from tusuario where idusuario=:idusuario');
          sql_global.ParamByName('idusuario').asinteger:=idbaja;
          sql_global.Open;
          edit6.Text:=trim(sql_global.Fields[0].AsString);
          sql_global.Free;
        end;
 end;

   except
          MessageDlg(caption,'Se produjo un error. Consulte al depto. de Sistemas.',mteRROR,[mbYes],mbyes,0)  ;
     end;


end;

procedure Tfrmalertas_vehiculos.Edit1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if not (TDominio.TipoDominio(Trim(edit1.Text)) in [ttdmAntiguo, ttdmAutos, ttdmMotos, ttdmTractor, ttdmEmbajada,ttdmDiplomatica,ttdmMercosur]) then
  begin
 
     edit1.Color:=clinfobk;
     edit1.SetFocus;
     exit;
  end;

     with TSQLQuery.Create(self) do
          try
            SQLConnection:=mybd;

                close;
            sql.clear;
            SQL.Add('SELECT patenten FROM patente_en_alerta WHERE PATENTEN=:PATENTE');
            ParamByName('PATENTE').AsString:=trim(EDIT1.Text);
            OPEN;
               if  not (IsEmpty) then
               begin
                   MessageDlg(caption,'La Patente ingresada ya tiene un alerta activo.',mteRROR,[mbYes],mbyes,0)  ;
               exit;
               end;

          except

          end;     
end;

procedure Tfrmalertas_vehiculos.Edit1KeyPress(Sender: TObject;
  var Key: Char);
begin
 edit1.Color:=clwhite ;
 if key=#13 then
  edit3.setfocus;

end;

procedure Tfrmalertas_vehiculos.Edit3KeyPress(Sender: TObject;
  var Key: Char);
begin
 edit3.Color:=clwhite
end;

procedure Tfrmalertas_vehiculos.SpeedButton2Click(Sender: TObject);
var sql_global: TSQLQuery;
idalta,idbaja, idusuario:longint;
idalta_s, idbaja_s,fechabaja,patente:string;
begin
if trim(edit1.Text)='' then
 begin
     MessageDlg(caption,'Debe ingresar la pantente del vehículo.',mteRROR,[mbYes],mbyes,0)  ;
     edit1.Color:=clinfobk;
     edit1.SetFocus;
     exit;
 end;

    if Application.MessageBox( pchar('¿Desea eliminar el alerta de la patente '+trim(edit1.Text)+'?'), 'Eliminar Alerta',
         MB_ICONQUESTION OR MB_YESNO ) = ID_YES then
         begin
             sql_global:= TSQLQuery.Create(self);
             sql_global.SQLConnection:=mybd;

                patente:=trim(edit1.Text);
               sql_global.Close;
                sql_global.SQL.Clear;
                sql_global.SQL.Add('SELECT *  FROM patente_en_alerta WHERE PATENTEN=:PATENTE  AND FECHABAJA IS NULL');
                sql_global.ParamByName('PATENTE').AsString:=trim(EDIT1.Text);
                sql_global.Open;
                if (sql_global.IsEmpty) then
                begin
                    MessageDlg(caption,'Esta alerta ya esta dada de baja.',mteRROR,[mbYes],mbyes,0)  ;
                    exit;
                end;
                fechabaja:=datetostr(date);


                  idusuario:=GLOBALS.IDUSUARIO_ALERTAS;
                sql_global.close;
                sql_global.sql.clear;
                sql_global.sql.add('alter session set nls_date_format = ''dd/mm/yyyy''');
                sql_global.execsql;


             sql_global.Close;
             sql_global.SQL.Clear;
             sql_global.SQL.Add('update patente_en_alerta set fechabaja=:fechabaja, idusuario_baja=:idusuario  WHERE PATENTEN=:PATENTE');
             sql_global.ParamByName('fechabaja').AsString:=trim(fechabaja);
             sql_global.ParamByName('idusuario').asinteger:=idusuario;
              sql_global.ParamByName('patente').asstring:=trim(patente);
             sql_global.ExecSQL;
             MessageDlg(caption,'Se ha eliminado correctamente.',mtconfirmation,[mbYes],mbyes,0);
             edit1.Clear;
             edit2.Clear;
             edit3.Clear;
             edit4.Clear;
             edit5.Clear;
             edit6.Clear;


         end;



 
end;

procedure Tfrmalertas_vehiculos.SpeedButton4Click(Sender: TObject);

var sql_global: TSQLQuery;
idalta,idbaja:longint;
idalta_s, idbaja_s:string;
begin
if trim(edit1.Text)='' then
 begin
     MessageDlg(caption,'Debe ingresar la pantente del vehículo.',mteRROR,[mbYes],mbyes,0)  ;
     edit1.Color:=clinfobk;
     edit1.SetFocus;
     exit;
 end;

 try
    sql_global:= TSQLQuery.Create(self);
     sql_global.SQLConnection:=mybd;
     sql_global.Close;
     sql_global.SQL.Clear;
     sql_global.SQL.Add('SELECT FECHALTA, codvehic, patenten, idusuario_alta, motivo, fechabaja, idusuario_baja FROM patente_en_alerta WHERE PATENTEN=:PATENTE');
     sql_global.ParamByName('PATENTE').AsString:=trim(EDIT1.Text);
     sql_global.Open;

     except

     end;
end;

end.
