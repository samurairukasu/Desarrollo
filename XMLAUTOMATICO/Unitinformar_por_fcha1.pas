unit Unitinformar_por_fcha1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls,SqlExpr,Globals;

type
  Tinformar_por_fcha = class(TForm)
    DateTimePicker1: TDateTimePicker;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  informar_por_fcha: Tinformar_por_fcha;

implementation

uses Ufrmturnos;

{$R *.dfm}

procedure Tinformar_por_fcha.BitBtn1Click(Sender: TObject);
VAR IDTURNO:LONGINT;
AqSININFORMAR:tsqlquery;
begin
   AqSININFORMAR:=tsqlquery.create(nil);
   AqSININFORMAR.SQLConnection := MyBD;
   AqSININFORMAR.sql.add('select turnoid from tdatosturno where  fechaturno=to_date('+#39+datetostr(datetimepicker1.Date)+#39+',''dd/mm/yyyy'')  and estadoid=5 order by turnoid asc');
   AqSININFORMAR.ExecSQL;
   AqSININFORMAR.open;
   while not AqSININFORMAR.Eof do
   begin
     IDTURNO:=AqSININFORMAR.fieldbyname('turnoid').AsInteger;
      frmturnos.INFORMA_INSPECCION_AL_WEBSERVICES_POR_IDTURNO_por_fecha(IDTURNO);

      AqSININFORMAR.Next;

    end;


    AqSININFORMAR.close;
    AqSININFORMAR.free;
   Application.MessageBox( 'Proceso Terminado.', 'Atención',
  MB_ICONINFORMATION );
end;

end.
