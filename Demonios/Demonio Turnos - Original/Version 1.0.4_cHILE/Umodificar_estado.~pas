unit Umodificar_estado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, DBCtrls,ufunciones,uglobal;

type
  Tmodificar_estado = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    combo_estados: TDBLookupComboBox;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure combo_estadosClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id_reserva:longint;
    id_estado:longint;
  end;

var
  modificar_estado: Tmodificar_estado;

implementation

uses Umodulo;

{$R *.dfm}

procedure Tmodificar_estado.BitBtn2Click(Sender: TObject);
begin
close;
end;

procedure Tmodificar_estado.FormActivate(Sender: TObject);
begin
modulo.sql_estados.ExecSQL;
modulo.sql_estados.Open;
end;

procedure Tmodificar_estado.combo_estadosClick(Sender: TObject);
begin
id_estado:=combo_estados.KeyValue;
edit4.Text:=trim(combo_estados.Text);
end;

procedure Tmodificar_estado.BitBtn1Click(Sender: TObject);
var tf:tfuncion;
begin
tf:=tfuncion.Create;
 if tf.modifica_estado(id_reserva,id_estado) then
      begin
      showmessage('Se ha modificado correctamente.');

               if uglobal.OPCION_DE_GESTION=1 then
                  tf.busca_turnos_patene(uglobal.VALOR_BUSQUEDA_GESTION);


               if uglobal.OPCION_DE_GESTION=2 then
                  tf.busca_turnos_por_fecha_seleccionada(uglobal.VALOR_BUSQUEDA_GESTION);

       tf.Free;
       close;
      end
       else
         begin
              showmessage('Se produjo un error al intentar modificar el estado.');
              tf.Free;
          end;



end;

end.
