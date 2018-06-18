unit ufListadoCilindrosRegulad;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TfrmListCiliRegu = class(TForm)
    RBCilindros: TRadioButton;
    rbReguladores: TRadioButton;
    btnImprimir: TBitBtn;
    btnSalir: TBitBtn;
    Bevel1: TBevel;
    procedure btnSalirClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  procedure DoListadoCiliRegu;
var
  frmListCiliRegu: TfrmListCiliRegu;

implementation
uses
  ufListadoCilindrosReguladToPrint;
{$R *.DFM}

procedure DoListadoCiliRegu;
begin
  with TfrmListCiliRegu.create(application) do
    try
      showmodal;
    finally
      free;
    end;
end;

procedure TfrmListCiliRegu.btnSalirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmListCiliRegu.btnImprimirClick(Sender: TObject);
begin
  if RBCilindros.Checked then
  begin
    with TfrmListCiliReguToPrint.CreateCiliRegu('C') do
      try
        repCilindros.Preview;
      finally
        free;
      end;
  end
  else
  begin
      with TfrmListCiliReguToPrint.CreateCiliRegu('R') do
      try
        repRegularores.Preview;
      finally
        free;
      end;
  end;
end;

end.
