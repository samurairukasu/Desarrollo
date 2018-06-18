unit Unborrar_defectos_solo_reveApta2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,SqlExpr,
  globals,
  DBCtrls, USAGClasses,USAGDOMINIOS,USAGESTACION, ADODB, ExtCtrls, UCDIALGS;

type
  Tborrar_defectos_solo_reveApta = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  borrar_defectos_solo_reveApta: Tborrar_defectos_solo_reveApta;

implementation

{$R *.dfm}

procedure Tborrar_defectos_solo_reveApta.BitBtn1Click(
  Sender: TObject);
begin
close;
end;

procedure Tborrar_defectos_solo_reveApta.BitBtn2Click(
  Sender: TObject);
  var cadena,patente,sql1,sql2,t,f,califica,sql3:string;
  CODINSPE:longint;

  sql_global: TSQLQuery;


begin
if trim(edit1.Text)='' then
 begin
     Application.MessageBox( 'Debe ingresar el código de inspección.',
  'Atención', MB_ICONSTOP );
    edit1.SetFocus;

     exit;
 end;


 if trim(edit2.Text)='' then
 begin
     Application.MessageBox( 'Debe ingresar la Cadena del Defecto.',
  'Atención', MB_ICONSTOP );
    edit2.SetFocus;

     exit;
 end;





codinspe:=strtoint(trim(edit1.Text));
cadena:=trim(edit2.Text);


if Application.MessageBox( pchar('¿Desea modificar la calificación del defecto: '+trim(cadena)+' del vehiculo nro de Inspec: '+trim(patente)+' ?'), 'Modificar Calificación',
  MB_ICONQUESTION OR MB_YESNO ) = ID_YES then
  begin
      t:='E';
      f:='S';
      sql1:=' select codinspe from TINSPECCION  I '+
            ' where  INSPFINA=:fina AND RESULTAD =''A'''+
            ' AND CODINSPE=:Codinspe';


        with TSQLQuery.Create(self) do
          try
            SQLConnection:=mybd;

                close;
                sql.clear;
                SQL.Add(sql1);
                ParamByName('fina').AsString:=f;
                ParamByName('Codinspe').Asinteger:=codinspe;
                OPEN;
                 if  IsEmpty then
                  begin
                     MessageDlg(caption,'La Codinspe ingresada no existe.',mteRROR,[mbYes],mbyes,0)  ;
                     edit1.setfocus;
                     edit1.SelectAll;
                     exit;
                  end;


                    CODINSPE:=Fields[0].AsInteger;
                    //MessageDlg(caption,INTTOSTR(CODINSPE),mteRROR,[mbYes],mbyes,0)  ;


                 sql3:=' select * from tdatinspevi where codinspe=:codinspe and CADDEFEC=:cadena AND CALIFDEF=1 ';
                 close;
                sql.clear;
                SQL.Add(sql3);
                    ParamByName('codinspe').asinteger:=codinspe;
                   ParamByName('cadena').AsString:=cadena;
                OPEN;
                 if  IsEmpty then
                  begin
                     MessageDlg(caption,'La cadena del defecto ingresada no pertenece a este vehiculo.',mteRROR,[mbYes],mbyes,0)  ;
                     edit2.setfocus;
                     edit2.SelectAll;
                     exit;
                  end;


                   sql2:=' delete tdatinspevi  '+
                         ' where codinspe=:codinspe and CADDEFEC=:cadena';


                  mybd.StartTransaction(td);
                    close;
                    sql.clear;
                   SQL.Add(sql2);
                   ParamByName('codinspe').asinteger:=codinspe;
                   ParamByName('cadena').AsString:=cadena;
                   ExecSQL;
                   mybd.Commit(td);
                        MessageDlg(caption,'Se ha procesado correctamente.',mtconfirmation,[mbYes],mbyes,0);
                   edit1.setfocus;
                   edit1.SelectAll;
                   edit2.Clear;
             except
            MessageDlg(caption,'Se produjo un error al intentar procesar la modficación.',mteRROR,[mbYes],mbyes,0);
            mybd.Rollback(td);
          end;

  end;


end;

procedure Tborrar_defectos_solo_reveApta.FormActivate(
  Sender: TObject);
begin
edit1.SetFocus;
end;

procedure Tborrar_defectos_solo_reveApta.Edit1KeyPress(
  Sender: TObject; var Key: Char);
begin
if key=#13 then
begin
     if trim(edit1.Text)='' then
 begin
     Application.MessageBox( 'Debe ingresar la Patente del Vehículo.',
  'Atención', MB_ICONSTOP );
    edit1.SetFocus;

     exit;
 end;

    edit2.SetFocus;

end;
end;

procedure Tborrar_defectos_solo_reveApta.Edit2KeyPress(
  Sender: TObject; var Key: Char);
begin
if key=#13 then
begin
     if trim(edit2.Text)='' then
 begin
     Application.MessageBox( 'Debe ingresar la Cadena del Defecto.',
  'Atención', MB_ICONSTOP );
    edit2.SetFocus;

     exit;
 end;



end;
end;

procedure Tborrar_defectos_solo_reveApta.ComboBox1KeyPress(
  Sender: TObject; var Key: Char);
begin
if key=#13 then
   BitBtn2Click(sender);
end;

end.
