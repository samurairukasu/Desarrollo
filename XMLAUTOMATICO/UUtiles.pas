unit UUtiles;
interface
uses
  ExtCtrls, DBCtrls, Forms, speedbar, stdCtrls, comctrls, buttons, uvaryconst,ToolEdit,
  dateutil, RxLookup, quickrpt, qrctrls, db, UCEdit, dbGrids;

  procedure ActivarFondo(Modo: Boolean; pdatos: TPanel; DBENombre: TDBEdit);
  procedure ActivarComponentes(Modo: boolean; formulario: TForm; atag:ttagset);
  procedure MostrarComponentes(Modo: boolean; formulario: TForm; atag:ttagset);
  function  directorio(aDire:string):string;
  function  IntervalDatesOk(afecini, afecfin: tdatetime) : boolean;

implementation


procedure ActivarFondo(Modo: Boolean; pdatos: TPanel; DBENombre: TDBEdit);
begin
    pDatos.Visible:=Modo;
    if Modo
    then begin
        pDatos.BringToFront;
        if dbeNombre <> nil then
           DBEnombre.SetFocus;
    end;
end;

procedure ActivarComponentes(Modo: boolean; formulario: TForm; atag: ttagset);
var i:integer;
begin
  for i := 0 to formulario.ComponentCount-1 do
  begin
    if (formulario.Components[i].Tag in atag) then
    begin
       if (formulario.Components[i] is TColorEdit) then
           TColorEdit(formulario.Components[i]).enabled := Modo
       else if (formulario.Components[i] is TDbGrid) then
           TDbGrid(formulario.Components[i]).enabled := Modo
       else if (formulario.Components[i] is TSpeedItem) then
           TSpeedItem(formulario.Components[i]).enabled := Modo

       else if (formulario.Components[i] is TQRLabel) then
           TQRLabel(formulario.Components[i]).enabled := Modo
       else if (formulario.Components[i] is TQRExpr) then
           TQRExpr(formulario.Components[i]).enabled := Modo
       else if (formulario.Components[i] is TQRShape) then
           TQRShape(formulario.Components[i]).enabled := Modo

    end;
  end;
end;

procedure MostrarComponentes(Modo: boolean; formulario: TForm; atag: ttagset);
var i:integer;
begin
  for i := 0 to formulario.ComponentCount-1 do
  begin
    if (formulario.Components[i].Tag in atag) then
    begin
       if (formulario.Components[i] is TDBGrid) then
           TDBGrid(formulario.Components[i]).visible := Modo
       else if (formulario.Components[i] is TPanel) then
           TPanel(formulario.Components[i]).visible := Modo
       else if (formulario.Components[i] is TBitBtn) then
           TBitBtn(formulario.Components[i]).visible := Modo
    end;
  end;
end;

function directorio(aDire:string):string;
var posi:integer;
begin
  posi:=length(adire);
  if Pos('\', adire) = posi then
       delete(adire,Pos('\', adire),1);
  result:=adire;
end;

function IntervalDatesOk(afecini, afecfin:tdatetime) : boolean;
begin
    result :=  ValidDate(afecini) and ValidDate(afecfin) and (afecini <= afecfin)
end;


end.
