unit ufrmodificar_oblea_en_tvarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, FMTBcd, DB, SqlExpr,Globals;

type
  Tfrmodificar_oblea_en_tvarios = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmodificar_oblea_en_tvarios: Tfrmodificar_oblea_en_tvarios;

implementation

{$R *.dfm}

procedure Tfrmodificar_oblea_en_tvarios.BitBtn2Click(Sender: TObject);
var  aq:tsqlquery;
oblea:longint;
begin
  if trim(edit2.Text)='' then
  begin
    Application.MessageBox( 'Debe ingresar el Nro de OBlea',
  'Atenci�n', MB_ICONSTOP );
  exit;
  end;

oblea:=strtoint(edit2.Text);
   aq:=tsqlquery.create(self);
  try


       aq.SQLConnection := MyBD;
       aq.sql.add('update tvarios set  oblea_rucara='+inttostr(oblea));
       aq.ExecSQL();
     if MyBD.InTransaction then
              Begin
              MyBD.Rollback(td);
              end
            else
            begin
            Application.MessageBox( 'Se ha modificado correctamente el Nro de Oblea.', 'Atenci�n',
          MB_ICONINFORMATION );
          end;

            except
            on E: Exception do
            begin
               MyBD.Rollback(td);            //   MessageDlg('Modificando oblea rucara en tvarios.', 'Perdida de Transaccines: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end ;


 end;    

end;

procedure Tfrmodificar_oblea_en_tvarios.FormActivate(Sender: TObject);
var aq:tsqlquery;
begin
  //extrae el nro de oblea actual
       aq:=tsqlquery.create(self);
       aq.SQLConnection := MyBD;
       aq.sql.add('Select oblea_rucara from tvarios');
       aq.ExecSQL;
       aq.open;
       Edit1.Text:=trim(aq.fields[0].asstring);



      aq.free;

    //-----------------------------------

end;

procedure Tfrmodificar_oblea_en_tvarios.Edit2KeyPress(Sender: TObject;
  var Key: Char);
begin
if key in ['0','1','2','3','4','5','6','7','8','9',#8] then
      edit2.ReadOnly:=false
      else
      edit2.ReadOnly:=true;



end;

end.
