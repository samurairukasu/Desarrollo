unit Unitnueva_alerta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, SQLExpr, Mask, ToolEdit,  ExtCtrls, globals,
  DBCtrls, USAGClasses,USAGDOMINIOS,USAGESTACION, FMTBcd, ADODB;

type
  Tnueva_alerta = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    SQLQuery1: TSQLQuery;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  nueva_alerta: Tnueva_alerta;

implementation

{$R *.dfm}
   uses
        UCDIALGS,
        UFTMP, Ufaletas_vehiculos;

procedure Tnueva_alerta.BitBtn2Click(Sender: TObject);
begin
close;
end;

procedure Tnueva_alerta.BitBtn1Click(Sender: TObject);
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

 if trim(edit2.Text)='' then
 begin
     MessageDlg(caption,'Debe ingresar el motivo del alerta.',mteRROR,[mbYes],mbyes,0)  ;
     edit2.Color:=clinfobk;
     edit2.SetFocus;
     exit;
 end;


   with TSQLQuery.Create(self) do
          try
            SQLConnection:=mybd;

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
                        motivo:=trim(edit2.Text);
                        patente:=trim(edit1.Text);
                        idusuario:=5;
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

                     


                   end;


          except
            MessageDlg(caption,'Se produjo un error al intentar procesar el alerta.',mteRROR,[mbYes],mbyes,0);
          end;



 



      
end;

procedure Tnueva_alerta.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  edit1.Color:=clwhite
end;

procedure Tnueva_alerta.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
edit2.Color:=clwhite
end;

procedure Tnueva_alerta.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not (TDominio.TipoDominio(Trim(edit1.Text)) in [ttdmAntiguo, ttdmAutos, ttdmMotos, ttdmTractor, ttdmEmbajada,ttdmDiplomatica,ttdmMercosur]) then
  begin
 
     edit1.Color:=clinfobk;
     edit1.SetFocus;
     exit;
  end;

end;

end.
