unit UniCONTROLSERVICIO_SVVTV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TCONTROLSERVICIO_SVVTV = class(TForm)
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CONTROLSERVICIO_SVVTV: TCONTROLSERVICIO_SVVTV;

implementation

uses Ufrmturnos;

{$R *.dfm}

procedure TCONTROLSERVICIO_SVVTV.BitBtn1Click(Sender: TObject);
begin
self.BitBtn1.Caption:='TESTEANDO...';
SELF.BitBtn1.Enabled:=FALSE;
frmturnos.Inicializa;
frmturnos.ControlServidor;
if (frmturnos.disponibilidad_servidor='true') AND (frmturnos.respuestaidservidor=1) THEN
begin
    Application.MessageBox( 'SERVICIO DE SUVTV OK !!!', 'Atención',
  MB_ICONINFORMATION );


END ELSE
BEGIN

  Application.MessageBox( PCHAR('SERVICIO DE SUVTV CON PROBLEMAS: '+frmturnos.respuestamensajeservidor),
  'SERVICIO DE SUVTV', MB_ICONSTOP );

END;


 self.BitBtn1.Caption:='TESTEAR';
SELF.BitBtn1.Enabled:=TRUE;

end;

end.
