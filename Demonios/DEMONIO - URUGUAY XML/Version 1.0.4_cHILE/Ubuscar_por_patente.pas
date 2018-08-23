unit Ubuscar_por_patente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,ufunciones,UGLOBAL;

type
  Tbuscar_por_patente = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  buscar_por_patente: Tbuscar_por_patente;

implementation

uses Unitgestion_de_turnos;

{$R *.dfm}

procedure Tbuscar_por_patente.BitBtn1Click(Sender: TObject);
var patente:string;
tf:tfuncion;

begin
if trim(edit1.Text)='' then
begin
showmessage('Debe ingresar la patente.');
exit;
end;

patente:=trim(edit1.Text);
UGLOBAL.VALOR_BUSQUEDA_GESTION:=patente;
tf:=tfuncion.Create;
 if tf.busca_turnos_patene(patente)  then
    begin
    gestion_de_turnos.DBGrid1.Columns[0].Visible:=true;
      gestion_de_turnos.porfecha.Caption:='Turno de la Patente: '+trim(patente);
     gestion_de_turnos.porfecha.Visible:=true;
    end else
    begin
     showmessage('No se encontraron turnos con la patente: '+trim(patente));
    end;
tf.Free;
close;

end;

procedure Tbuscar_por_patente.FormActivate(Sender: TObject);
begin
edit1.SetFocus;
end;

procedure Tbuscar_por_patente.Edit1KeyPress(Sender: TObject;
  var Key: Char);
begin
if key=#13 then
begin
BitBtn1Click(Sender);
end;
end;

procedure Tbuscar_por_patente.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key=#27 then
close;

end;

end.
