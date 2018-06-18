unit ufOblAnulad;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, SQLExpr, Mask, ToolEdit, ucdialgs, ExtCtrls, globals,
  DBCtrls, USAGClasses;

const
  WM_SEGUIRANUL=WM_USER+2;
  FICHERO_ACTUAL = 'ufOblAnulad';

type
  TfmOblAnul = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cbautorizo: TComboBox;
    Label4: TLabel;
    edmotivo: TEdit;
    btnaceptar: TBitBtn;
    btneliminar: TBitBtn;
    btnsalir: TBitBtn;
    defecha: TDateEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    EdNumOblea: TEdit;
    procedure btneliminarClick(Sender: TObject);
    procedure btnaceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EdNumObleaKeyPress(Sender: TObject; var Key: Char);
    procedure btnsalirClick(Sender: TObject);
  private
    { Private declarations }
     procedure RegistObleaDeVehicDesconocido(var Msge:TMessage); message WM_SEGUIRANUL;
     function datoscompletos:boolean;
     Procedure LimpiarDatos;
  public
    { Public declarations }
  end;
  procedure DoObleaAnulada;

//const RegistrarOblea:boolean = true;

var
  fmOblAnul: TfmOblAnul;
  fOblea:TOblea;
  RegistrarOblea:boolean;

implementation

{$R *.DFM}

uses
  uftmp, USAGESTACION, uLogs;


Procedure TfmOblAnul.LimpiarDatos;
var
I: Integer;
Begin
For I:=0 To ComponentCount-1 do
  if Components[I] is TEdit then
    TEdit(Components[I]).Text:='';
EdNumOblea.SetFocus;
cbAutorizo.ItemIndex:=-1;
end;


Function NroInspecCombo(Cadena:String):String;
var
I: Integer;
Begin
I:=1;
Result:='';
While Cadena[I] <> '-' do
  Begin
    Result:=Result+Cadena[I];
    Inc(I);
  end;
Result:=TrimRight(Result);
end;


procedure DoObleaAnulada;
begin
RegistrarOblea:= true ;
with TfmOblAnul.Create(Application.MainForm) do
  try
    ShowModal;
  finally
    Free;
  end;
end;


procedure TfmOblAnul.RegistObleaDeVehicDesconocido(var Msge:TMessage);
begin
if Msge.Msg=0 then
  RegistrarOblea:=true;
if Msge.WParam=1 then
   RegistrarOblea:=false;
end;


procedure TfmOblAnul.btnaceptarClick(Sender: TObject);
var
ID,Nrevis:integer;
begin
RegistrarOblea:=true;
fOblea:=TOblea.CreateByOblea(MyBD,ednumoblea.Text);
fOblea.Open;
  if datoscompletos then
    try
      if not (fOblea.IsObleaTomada) and fOblea.ExisteOblea then
      begin
        btneliminar.Enabled:=false;
        btnsalir.Enabled:=false;
        ID:=0;
          with TSQLQuery.Create(self) do
          try
            SQLConnection:=mybd;
            sql.add('alter session set nls_date_format = ''dd/mm/yyyy''');
            execsql;
            close;
            sql.clear;
            SQL.Add('SELECT CODINSPE FROM TINSPECCION WHERE NUMOBLEA=:OBLEA');
            ParamByName('OBLEA').AsString:=ednumoblea.Text;
            Open;

            if (not IsEmpty) then
              if MessageDlg(caption,'Oblea utilizada. ¿Esta Ud seguro que desea seguir?',mtConfirmation,[mbYes,mbNo],mbyes,0)=mrYes then
                RegistrarOblea:=true
              else
                RegistrarOblea:=false;

            if RegistrarOblea then
              begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT CODANULAC FROM T_ERVTV_ANULAC WHERE NUMOBLEA=:OBLEA');
                ParamByName('OBLEA').AsString:=ednumoblea.Text;
                Open;
                if (IsEmpty) or (Fields[0].AsInteger=0) then
                  begin

//********************************** VERSION SAG 4.00 **********************************************
//
                  fOblea.AnularOblea(DateTimeToStr(defecha.Date));
                  {$IFDEF TRAZAS}
                  FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE PASO A ESTADO ANULADO LA OBLEA: '+ednumoblea.Text+', AUTORIZADO POR '+CbAutorizo.Text);
                  {$ENDIF}
//
//**************************************************************************************************
                  Nrevis:= StrToInt(NroInspecCombo(cbautorizo.Text));
                  Close;
                  SQL.Clear;
                  SQL.Add('SELECT ANULAC FROM T_ERVTV_CURRENTNUM');
                  Open;
                  ID:=Fields[0].AsInteger;

                  Close;
                  SQL.Clear;
                  SQL.Add('INSERT INTO T_ERVTV_ANULAC(CODANULAC,FECHA,NUMOBLEA,MOTIVO,AUTORIZO) ');
                  SQL.Add('VALUES(:ID,:FECHA,:OBLEA,:MOTIVO,:AUTORIZO)');
                  ParamByName('ID').AsInteger:=ID;
                  ParamByName('FECHA').AsString:=defecha.Text;
                  ParamByName('OBLEA').AsString:=ednumoblea.Text;
                  ParamByName('MOTIVO').AsString:=edmotivo.Text;
                  ParamByName('AUTORIZO').AsInteger:=Nrevis;
                  ExecSQL;

                  Close;
                  SQL.Clear;
                  SQL.Add('UPDATE T_ERVTV_CURRENTNUM SET ANULAC=ANULAC+1');
                  ExecSQL;
                  ShowMessage(caption,'Se ha anulado la oblea '+ednumoblea.Text+' con exito!!!');
                end
              else
                messagedlg(caption,'Esa oblea ya esta anulada!!!',mtInformation,[mbOK],mbOK,0);
            end;
       finally
        Free;
       end;
        btneliminar.Enabled:=true;
        btnsalir.Enabled:=true;
        LimpiarDatos;
      end
    else
      messagedlg('Atención con el número de oblea!!','Ese número de oblea se no existe o se encuentra tomada por algún supervisor'+#13#10+
                         'Asegurese que el número de oblea sea correcto o espere a que se libere para'+#13#10+
                         'poder anularla.',mtWarning,[mbOK],mbOK,0);
    Except
      Begin
        btneliminar.Enabled:=true;
        btnsalir.Enabled:=true;
      end;
  end
end;


procedure TfmOblAnul.FormCreate(Sender: TObject);
begin
defecha.Date:=Date;
  with TSQLQuery.Create(self) do
    try
      SQLConnection:=mybd;
      SQL.Add('SELECT NUMREVIS, APPEREVIS, NOMREVIS FROM TREVISOR WHERE ACTIVO = ''S'' ');
      Open;
      First;
      while not EOF do
        begin
          cbautorizo.Items.Add(Fields[0].AsString+' - '+Fields[1].AsString +', '+ Fields[2].AsString);
          Next;
        end;
      cbautorizo.Text:=cbautorizo.Items[0];
    finally
      Close;
      Free;
    end;
end;


procedure TfmOblAnul.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key=#13 then
  begin
    Perform(WM_NEXTDLGCTL,0,0);
    Key:=#0;
  end;
if Key = chr(VK_ESCAPE) then
  close;
end;


function TfmOblAnul.datoscompletos:boolean;
begin
result:=false;
  if ednumoblea.text = '' then
  begin
    messagedlg(caption,'Se debe ingresar el número de oblea a anular',mtError,[mbOK],mbOK,0);
    ednumoblea.setfocus;
    exit;
  end;
  if defecha.text = '  /  /    ' then
  begin
    messagedlg(caption,'Se debe ingresar la fecha',mtError,[mbOK],mbOK,0);
    defecha.setfocus;
    exit;
  end;
  if cbautorizo.text = '' then
  begin
    messagedlg(caption,'Se debe ingresar la persona que autorizó el la anulación',mtError,[mbOK],mbOK,0);
    cbautorizo.setfocus;
    exit;
  end;
  if edmotivo.text = '' then
  begin
    messagedlg(caption,'Se debe ingresar el motivo de la anulación',mtError,[mbOK],mbOK,0);
    edmotivo.setfocus;
    exit;
  end;
  result:=true;
end;

procedure TfmOblAnul.EdNumObleaKeyPress(Sender: TObject; var Key: Char);
begin
if not (Key in ['0'..'9',#8]) then
  key := #0
end;


procedure TfmOblAnul.btneliminarClick(Sender: TObject);
begin
if (length(ednumoblea.text) > 7) then
  try
    btnaceptar.Enabled:=false;
    btnsalir.Enabled:=false;
    fOblea:=TOblea.CreateByOblea(MyBD,ednumoblea.Text);
    fOblea.Open;
    if MessageDlg(caption,'¿Esta seguro que desea eliminar?',mtConfirmation,[mbYes,mbNo],mbyes,0)=mrYes then
      with TSQLQuery.Create(self) do
        try
          SQLConnection:=mybd;
          SQL.Add('DELETE FROM T_ERVTV_ANULAC WHERE NUMOBLEA=:NUMOBLEA');
          ParamByName('NUMOBLEA').AsString:=ednumoblea.Text;
          ExecSQL;

//********************************** VERSION SAG 4.00 **********************************************
          fOblea.LiberarOblea;
          {$IFDEF TRAZAS}
          FTrazas.PonAnotacion (1,1,FICHERO_ACTUAL, 'SE VOLVIO AL ESTADO DISPONIBLE LA OBLEA: '+ednumoblea.Text);
          {$ENDIF}
          ShowMessage(caption,'Se ha RESTAURADO la oblea '+ednumoblea.Text+' con exito!!!');
//**************************************************************************************************

          ednumoblea.Clear;
          edmotivo.Clear;
          defecha.Date:=Date;
          cbautorizo.Text:=cbautorizo.Items[0];

        finally
          Close;
          Free;
        end;
      btnaceptar.Enabled:=true;
      btnsalir.Enabled:=true;
  Except

  end;
end;

procedure TfmOblAnul.btnsalirClick(Sender: TObject);
begin
Close;
end;

end.
