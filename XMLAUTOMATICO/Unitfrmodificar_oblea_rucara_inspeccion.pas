unit Unitfrmodificar_oblea_rucara_inspeccion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,SqlExpr,Globals;

type
  Tfrmodificar_oblea_rucara_inspeccionunit = class(TForm)
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    Edit2: TEdit;
    GroupBox2: TGroupBox;
    Edit3: TEdit;
    BitBtn3: TBitBtn;
    Label3: TLabel;
    Edit4: TEdit;
    procedure BitBtn2Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmodificar_oblea_rucara_inspeccionunit: Tfrmodificar_oblea_rucara_inspeccionunit;

implementation

{$R *.dfm}

procedure Tfrmodificar_oblea_rucara_inspeccionunit.BitBtn2Click(
  Sender: TObject);

var aq:tsqlquery;
codinspe:longint;
begin
if trim(edit1.Text)='' then
begin
    Application.MessageBox( 'No ha ingresado el Nro de Inspección.',
  'Atención', MB_ICONSTOP );
 exit;
end;

codinspe:=strtoint(edit1.Text);
  //extrae el nro de oblea actual
       aq:=tsqlquery.create(self);
       aq.SQLConnection := MyBD;
       aq.sql.add('select tv.patenten,TR.numoblea from trucaras tr, tvehiculos tv where  tr.codvehic= TV.CODVEHIC '+
                   ' and tr.codinspe='+inttostr(codinspe));
       aq.ExecSQL;
       aq.open;
       Edit2.Text:=trim(aq.fields[0].asstring);
       Edit4.Text:=trim(aq.fields[1].asstring);


      aq.free;
end;

procedure Tfrmodificar_oblea_rucara_inspeccionunit.Edit1KeyPress(
  Sender: TObject; var Key: Char);
begin
if key in ['0','1','2','3','4','5','6','7','8','9',#8] then
      edit1.ReadOnly:=false
      else
      edit1.ReadOnly:=true;

end;

procedure Tfrmodificar_oblea_rucara_inspeccionunit.BitBtn3Click(
  Sender: TObject);
var  aq:tsqlquery;
oblea,codinspe:longint;
begin

  if trim(edit1.Text)='' then
  begin
    Application.MessageBox( 'Debe ingresar el Nro de Inspección',
  'Atención', MB_ICONSTOP );
  exit;
  end;


  if trim(edit3.Text)='' then
  begin
    Application.MessageBox( 'Debe ingresar el Nro de OBlea',
  'Atención', MB_ICONSTOP );
  exit;
  end;
codinspe:=strtoint(edit1.Text);
oblea:=strtoint(edit3.Text);
   aq:=tsqlquery.create(self);
  try


       aq.SQLConnection := MyBD;
       aq.sql.add('update trucaras set  numoblea='+inttostr(oblea)+'  where codinspe='+inttostr(codinspe));
       aq.ExecSQL();
     if MyBD.InTransaction then
              Begin
              MyBD.Rollback(td);
              end
            else
            begin
            Application.MessageBox( 'Se ha modificado correctamente el Nro de Oblea.', 'Atención',
          MB_ICONINFORMATION );
          end;

            except
            on E: Exception do
            begin
               MyBD.Rollback(td);            //   MessageDlg('Modificando oblea rucara en tvarios.', 'Perdida de Transaccines: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end ;


 end;

end;

end.
