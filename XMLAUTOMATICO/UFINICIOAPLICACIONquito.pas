unit UFINICIOAPLICACIONquito;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, RxGIF;

type
    TFInicioAplicacion = class(TForm)
    lblisostat: TLabel;
    status: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Label3: TLabel;
    Image2: TImage;
    Image3: TImage;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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




end.
