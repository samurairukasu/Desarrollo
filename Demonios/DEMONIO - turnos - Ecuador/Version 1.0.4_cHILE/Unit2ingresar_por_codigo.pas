unit Unit2ingresar_por_codigo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,ufunciones,uglobal;

type
  Tingresar_por_codigo = class(TForm)
    SpeedButton1: TSpeedButton;
    Edit1: TEdit;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ingresar_por_codigo: Tingresar_por_codigo;

implementation

uses Unitgestion_de_turnos;

{$R *.dfm}

procedure Tingresar_por_codigo.SpeedButton1Click(Sender: TObject);
var codigo:string;
tf:tfuncion;

begin
if trim(edit1.Text)='' then
begin
showmessage('Debe ingresar la patente.');
exit;
end;

codigo:=trim(edit1.Text);
UGLOBAL.VALOR_BUSQUEDA_GESTION:=codigo;
tf:=tfuncion.Create;
 if tf.busca_por_codigo_reserva(codigo) then
    begin
    gestion_de_turnos.DBGrid1.Columns[0].Visible:=true;
      gestion_de_turnos.porfecha.Caption:='Turno';
     gestion_de_turnos.porfecha.Visible:=true;
    end else
    begin
     showmessage('No se encontraron turnos con el codigo: '+trim(codigo));
    end;
tf.Free;
close;


end;

end.
