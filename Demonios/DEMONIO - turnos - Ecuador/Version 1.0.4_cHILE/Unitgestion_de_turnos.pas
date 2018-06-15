unit Unitgestion_de_turnos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ComCtrls, Buttons, StdCtrls, Grids, DBGrids, ExtCtrls,Umodulo,UGLOBAL;

type
  Tgestion_de_turnos = class(TForm)
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    StatusBar1: TStatusBar;
    Bevel1: TBevel;
    porfecha: TGroupBox;
    DBGrid1: TDBGrid;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    procedure SpeedButton1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SpeedButton2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ToolBar1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  gestion_de_turnos: Tgestion_de_turnos;

implementation

uses Useleccione_fecha, Ubuscar_por_patente, Uimprimir_turnos,
  Umodificar_estado, Useleccione_fecha_para_reporte,
  Unit2ingresar_por_codigo;

{$R *.dfm}

procedure Tgestion_de_turnos.SpeedButton1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
statusbar1.Panels[0].Text:='Consultar Turnos por Patente';
end;

procedure Tgestion_de_turnos.FormMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
statusbar1.Panels[0].Text:='';
end;

procedure Tgestion_de_turnos.SpeedButton2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
statusbar1.Panels[0].Text:='Consultar Turnos por Fecha';
end;

procedure Tgestion_de_turnos.ToolBar1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
statusbar1.Panels[0].Text:='';
end;

procedure Tgestion_de_turnos.SpeedButton2Click(Sender: TObject);
var fecha:string;
begin
UGLOBAL.OPCION_DE_GESTION:=2;
seleccione_fecha.showmodal;

//porfecha.Visible:=true;
end;

procedure Tgestion_de_turnos.SpeedButton1Click(Sender: TObject);
begin
UGLOBAL.OPCION_DE_GESTION:=1;
buscar_por_patente.Edit1.Clear;
buscar_por_patente.showmodal;
end;

procedure Tgestion_de_turnos.SpeedButton3MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
statusbar1.Panels[0].Text:='Imprimir';
end;

procedure Tgestion_de_turnos.SpeedButton3Click(Sender: TObject);
begin
seleccione_fecha_para_reporte.showmodal;


end;

procedure Tgestion_de_turnos.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key=#27 then
close;
end;

procedure Tgestion_de_turnos.SpeedButton4Click(Sender: TObject);
begin
if modulo.sql_buscA_por_fecha.Active=false then
begin
showmessage('No hay datos en la grilla.');
exit;
end;

if modulo.sql_buscA_por_fecha.RecordCount = 0 then
begin
showmessage('No hay datos en la grilla.');
exit;
end;
modificar_estado.Edit1.Text:=trim(dbgrid1.Fields[0].asstring);
modificar_estado.Edit2.Text:=trim(dbgrid1.Fields[1].asstring);
modificar_estado.Edit3.Text:=trim(dbgrid1.Fields[5].asstring);
modificar_estado.Edit4.Text:=trim(dbgrid1.Fields[3].asstring);

modificar_estado.id_reserva:=dbgrid1.Fields[7].asinteger;
modificar_estado.GroupBox1.Caption:='Patente: '+trim(dbgrid1.Fields[4].asstring);

 if   trim(dbgrid1.Fields[3].asstring)='Confirmado' then
       modificar_estado.id_estado:=1;


 if   trim(dbgrid1.Fields[3].asstring)='Cancelado' then
       modificar_estado.id_estado:=2;

modificar_estado.showmodal;
end;

procedure Tgestion_de_turnos.SpeedButton5Click(Sender: TObject);
begin
ingresar_por_codigo.showmodal;
end;

end.
