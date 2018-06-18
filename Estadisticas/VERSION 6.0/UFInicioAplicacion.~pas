unit UFInicioAplicacion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, RxGIF, jpeg;

type
    TFInicioAplicacion = class(TForm)
    lblisostat: TLabel;
    status: TLabel;
    Bevel1: TBevel;
    Timer1: TTimer;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
      private
        { Private declarations }
        cont: integer;
        cadena: string;
    public
        { Public declarations }
    end;

var
    FInicioAplicacion: TFInicioAplicacion;

implementation

{$R *.DFM}

    uses
        UVERSION;

    procedure TFInicioAplicacion.FormShow(Sender: TObject);
    begin
        Caption := NOMBRE_PROYECTO;
    end;



procedure TFInicioAplicacion.FormCreate(Sender: TObject);
begin
  cont:=0;
  cadena:='Estadísticas ISO 9001';
end;


procedure TFInicioAplicacion.Timer1Timer(Sender: TObject);
begin
  application.processmessages;
  timer1.enabled:=false;
  sleep(1000);
end;



end.
