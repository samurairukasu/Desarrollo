unit UFInicioAplicacion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, RxGIF, jpeg;

type
    TFInicioAplicacion = class(TForm)
    status: TLabel;
    lVersion: TLabel;
    Label1: TLabel;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    private
        { Private declarations }

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


end.

