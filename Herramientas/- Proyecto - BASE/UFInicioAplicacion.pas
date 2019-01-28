unit UFInicioAplicacion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, RxGIF, jpeg;

type
    TFInicioAplicacion = class(TForm)
    lblisostat: TLabel;
    status: TLabel;
    Timer1: TTimer;
    Shape1: TShape;
    Bevel1: TBevel;
    imageva: TImage;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    private
        { Private declarations }
        cont: integer;
        cadena: string;
        Procedure Dibujalineas;
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

Procedure TFInicioAplicacion.Dibujalineas;
var
   hRgn1, hRgn2, hRgn3, hRgn4, hRgn5: THandle;
begin
   // creamos una zona rectangular del mismo tamaño del form
   hRgn1 := CreateRectRgn(0, 0, Width, Height);
   // creamos una zona circular de 100 x 100 en el centro del form
   hRgn2 := CreateRectRgn(10, 10, width -10, 13);
   hRgn3 := CreateRectRgn(10, height-13, width -10, height-10);
   hRgn4 := CreateRectRgn(width -13, 10, width -10, height-13);
   hRgn5 := CreateRectRgn(10, 10, 13, height-13);
   // combinamos las regiones quitando la region circular
   // de la rectangular
   CombineRgn(hRgn1, hRgn1, hRgn2, RGN_DIFF);
   CombineRgn(hRgn1, hRgn1, hRgn3, RGN_DIFF);
   CombineRgn(hRgn1, hRgn1, hRgn4, RGN_DIFF);
   CombineRgn(hRgn1, hRgn1, hRgn5, RGN_DIFF);
   // poner la nueva region
   SetWindowRgn(Handle, hRgn1, False);
   // borrar la region 2, la region 1 se la apaña por windows y la borrawindows
   DeleteObject(hRgn2);
   DeleteObject(hRgn3);
   DeleteObject(hRgn4);
   DeleteObject(hRgn5);
end;

procedure TFInicioAplicacion.FormCreate(Sender: TObject);
begin
  Dibujalineas;
  cont:=0;
  cadena:='  Proyecto de Prueba  ';
end;

procedure TFInicioAplicacion.Timer1Timer(Sender: TObject);
begin
  if (length(lblisostat.caption)) < (length (cadena)) then
  begin
    lblisostat.caption:=lblisostat.caption+cadena[cont];
    inc(cont);
    if imageva.top < 80 then
    begin
      imageva.top := imageva.top+cont*2;
      lblisostat.top := lblisostat.top - (cont - 2);
    end
    else
    begin
      imageva.top := imageva.top+1;
    end;
    application.processmessages;
  end
  else
  begin
    timer1.enabled:=false;
    sleep(2500);
  end;
end;


end.

