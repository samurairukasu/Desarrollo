unit Unit1descargar_turno_suvtv;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,ufunciones,WSFEV1, InvokeRegistry, Rio,
  SOAPHTTPClient;

type
  Tdescargar_turno_suvtv = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    HTTPRIO1: THTTPRIO;
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  descargar_turno_suvtv: Tdescargar_turno_suvtv;

implementation

uses Ufrmturnos;

{$R *.dfm}

procedure Tdescargar_turno_suvtv.BitBtn1Click(Sender: TObject);
begin
close;
end;

procedure Tdescargar_turno_suvtv.Edit1KeyPress(Sender: TObject;
  var Key: Char);
begin
if key in ['0','1','2','3','4','5','6','7','8','9',#13,#8] then
  edit1.ReadOnly:=false
  else
  edit1.ReadOnly:=true;
end;

procedure Tdescargar_turno_suvtv.BitBtn2Click(Sender: TObject);
var FA:tfacturae;
 tf:tfunciones;
begin
if trim(edit1.Text)='' then
begin
     Application.MessageBox( 'Debe ingresar el TurnoID.',
  'Acceso denegado', MB_ICONSTOP );
  exit;
end;


  if trim(edit2.Text)='' then
begin
    Application.MessageBox( 'Debe ingresar la patente.',
  'Acceso denegado', MB_ICONSTOP );
  exit;
end;

 frmturnos.descargar_turno_suvtv_desde_sag(strtoint(edit1.Text),trim(edit2.Text));
end;

end.