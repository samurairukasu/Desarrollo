unit UUtiles;
interface
uses
  ExtCtrls, DBCtrls, Forms, speedbar, stdCtrls, comctrls, buttons, ToolEdit,
  dateutil, RxLookup, quickrpt, qrctrls, db, RxDBComb, sysutils, ucdialgs, ustockestacion;

  procedure ActivarFondo(Modo: Boolean; pdatos: TObject; DBENombre: TObject; TipoPanel, tipoEdit: string);
  procedure ActivarComponentes(Modo: boolean; formulario: TForm; atag:ttagset);
  procedure MostrarComponentes(Modo: boolean; formulario: TForm; atag:ttagset);
  function  directorio(aDire:string):string;
  function  IntervalDatesOk(afecini, afecfin: tdatetime) : boolean;
  function  FormatoCeros (anumero: integer; acantidad: integer):string;

implementation


procedure ActivarFondo(Modo: Boolean; pdatos: TObject; DBENombre: TObject; tipoPanel, tipoEdit: string);
begin
    if tipoPanel = TIPO_PANEL then
      (pDatos as tpanel).Visible:=Modo
    else
      (pDatos as tpageControl).Visible:=Modo;
    if Modo
    then begin
        if tipoPanel = TIPO_PANEL then
          (pDatos as tpanel).BringToFront
        else
          (pDatos as tpageControl).BringToFront;
        if dbeNombre <> nil then
          if tipoEdit = TIPO_COMBO then
            (dbenombre as tRxDBComboBox).SetFocus
          else
            (dbenombre as tdbEdit).SetFocus
    end;
end;

procedure ActivarComponentes(Modo: boolean; formulario: TForm; atag: ttagset);
var i:integer;
begin
  for i := 0 to formulario.ComponentCount-1 do
  begin
    if (formulario.Components[i].Tag in atag) then
    begin
       if (formulario.Components[i] is TSpeedBar) then
           TSpeedBar(formulario.Components[i]).enabled := Modo
       else if (formulario.Components[i] is TSpeedItem) then
           TSpeedItem(formulario.Components[i]).enabled := Modo
       else if (formulario.Components[i] is Tdbedit) then
           Tdbedit(formulario.Components[i]).enabled := Modo
       else if (formulario.Components[i] is TrxdbcomboBox) then
           TrxdbcomboBox(formulario.Components[i]).enabled := Modo
       else if (formulario.Components[i] is Trxdblookupcombo) then
           Trxdblookupcombo(formulario.Components[i]).enabled := Modo;

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
       if (formulario.Components[i] is TLabel) then
           TLabel(formulario.Components[i]).visible := Modo
       else if (formulario.Components[i] is TProgressBar) then
           TProgressBar(formulario.Components[i]).visible := Modo
       else if (formulario.Components[i] is TBitBtn) then
           TBitBtn(formulario.Components[i]).visible := Modo
       else if (formulario.Components[i] is TDirectoryEdit) then
           TDirectoryEdit(formulario.Components[i]).visible := Modo
       else if (formulario.Components[i] is TBevel) then
           TBevel(formulario.Components[i]).visible := Modo
       else if (formulario.Components[i] is TRxDBLookupCombo) then
           TRxDBLookupCombo(formulario.Components[i]).visible := Modo
       else if (formulario.Components[i] is TPageControl) then
           TPageControl(formulario.Components[i]).visible := Modo
       else if (formulario.Components[i] is TRadioGroup) then
           TRadioGroup(formulario.Components[i]).visible := Modo;

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

function FormatoCeros (anumero: integer; acantidad: integer):string;
var aux:string;
    ceros,i: integer;
begin
  try
    ceros:= length(inttostr(anumero));
    if ceros > acantidad then
       raise exception.create('Error en la conversión de formato')
    else
    begin
       ceros:=acantidad-ceros;
       for i:= 1 to ceros do
         aux:=aux+'0';
       aux:=aux+inttostr(anumero);
       result:=aux;
    end;

  except
        Messagedlg('ERROR','Error en la conversión de formato',mtERROR,[mbok],mbok,0);

  end;

end;

end.
