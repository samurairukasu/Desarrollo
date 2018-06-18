unit UFTmp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Animate, GIFCtrl, Globals, RxGIF, jpeg;

type
    TFTmp = class(TForm)
    LEstado: TLabel;
    bOk: TBitBtn;
    Bevel1: TBevel;
    Lupa: TImage;
    Clock: TImage;
        procedure bOkClick(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
    private
        { Private declarations }
    public
        { Public declarations }
        procedure MuestraClock (const s, ss: string);
        procedure MuestraLupa (const s, ss: string);   
        Procedure Temporizar(aState,aTempo:Boolean;Const s,ss: string);
    end;

var
    FTmp: TFTmp;

implementation

{$R *.DFM}

procedure TFTmp.bOkClick(Sender: TObject);
begin
if Visible then
  Hide;
end;

procedure TFTmp.MuestraClock (const s,ss: string);
begin
  LiberarMemoria;
  Caption := s;
  LEstado.Caption := ss;
  Lupa.Visible := FALSE;
  Clock.Visible := TRUE;
  Show;
  Refresh;
end;

procedure TFTmp.MuestraLupa (const s,ss: string);
begin
  Caption := s;
  LEstado.Caption := ss;
  Lupa.Visible := TRUE;
  Clock.Visible := FALSE;
  Show;
  Refresh;
end;

procedure TFTmp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
LiberarMemoria;
    {if Clock.Animate
    then Clock.Animate := FALSE;}
end;

Procedure TFTmp.Temporizar(aState,aTempo:Boolean;Const s,ss: string);
begin
If aState then   //Mostrar temporizacion
  begin
  //FTmp:=TFTmp.Create(application);
    If aTempo Then
      MuestraClock(s,ss)
    Else
      MuestraLupa(s,ss);
  end
else
  begin      //Ocultar temporizacion
    if Visible Then
      Hide;
    bOk.Visible:=FalsE;
    //fTmp.Free;
  end;
Refresh;
end;



Initialization

    FTmp := TFTmp.Create(Application);

end.
