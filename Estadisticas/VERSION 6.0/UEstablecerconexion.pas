unit UEstablecerconexion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uutils,
  QRCtrls, jpeg, QuickRpt,  Dialogs, ExtCtrls, sqlexpr, globals, uGetDates, UFPlanta,
  FMTBcd, DBClient, Provider, DB, QRExport, StdCtrls, Buttons, Gauges,
  ComCtrls;

type
  Tfrestablecerconexion = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Timer1: TTimer;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  
  private
    { Private declarations }
  public
    { Public declarations }
     CONT:LONGINT;
  end;

  Procedure Generateconexion;


var
  frestablecerconexion: Tfrestablecerconexion;



implementation

uses UFPrincipal;

{$R *.dfm}

var
 DateIni, DateFin : string;

  


Procedure Generateconexion;

begin


  with Tfrestablecerconexion.Create(application) do
   try
      showmodal;
   finally
     free;
   end;

end;





procedure Tfrestablecerconexion.BitBtn1Click(Sender: TObject);
begin
progressbar1.Visible:=true;
label1.Visible:=true;
CONT:=1;
TIMER1.Enabled:=TRUE;

APPLICATION.ProcessMessages;

IF TestOfBDCHILE('', '', '',TRUE)=TRUE THEN
begin

    FRMPRINCIPAL.StatusBar1.Panels[0].Text:='Conexi�n a Chile: On-Line' ;
    CONEXION_ESTABLECIDA_CHILE:=TRUE;
    TIMER1.Enabled:=FALSE;
    progressbar1.Visible:=false;
    label1.Visible:=falsE;
    showmessage('Conexi�n establecida  a chile correcta !!!');
    close;
    end
    else
    begin
      progressbar1.Visible:=false;
     label1.Visible:=falsE;
       FRMPRINCIPAL.StatusBar1.Panels[0].Text:='Conexi�n a Chile: Off-Line' ;
      CONEXION_ESTABLECIDA_CHILE:=FALSE;
      showmessage('No se puede establecer la conexi�n a Chile. Por favor verifique el Cliente VPN de Conexi�n a Chile.');
   
      TIMER1.Enabled:=FALSE;
      end;

end;

procedure Tfrestablecerconexion.BitBtn2Click(Sender: TObject);
begin
DesconectarBDCHILE;
FRMPRINCIPAL.StatusBar1.Panels[0].Text:='Conexi�n a Chile: Off-Line' ;
end;

procedure Tfrestablecerconexion.Timer1Timer(Sender: TObject);
begin
  CONT:=CONT + 1;
  ProgressBar1.StepBy(CONT);
  APPLICATION.ProcessMessages;
  IF CONT >=14 THEN
     CONT:=0;
end;

procedure Tfrestablecerconexion.FormActivate(Sender: TObject);
begin
progressbar1.Visible:=false;
label1.Visible:=falsE;
end;

end.
