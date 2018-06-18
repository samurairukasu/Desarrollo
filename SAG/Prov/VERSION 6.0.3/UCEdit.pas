unit UCEdit;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls;

type
  TColorEdit = class(TEdit)
  private
    FDestacar : Boolean;
    FTextClFondo : TColor;
    FFondo: TColor;

    FAuxFondo : TColor;
    FAuxFont : TFont;
    procedure SetFondo(Value: TColor);
    procedure SetDestacar(Value: Boolean);
    function IsColorStored: Boolean;
    procedure KeyPress(var Key: Char); override;
    procedure DoEnter; override;
    procedure DoExit; override;
  public
   constructor Create (AOwner : TComponent); override;
  published
    property FondoColor: TColor read FFondo write SetFondo stored IsColorStored  default clWindow;
    property FondoDestacado : Boolean read FDestacar write SetDestacar default true;
    property FondoTexto : TColor read FTextClFondo write FTextClFondo default clBlack;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('VTVObjects', [TColorEdit]);
end;

procedure TColorEdit.DoEnter;
begin
  FAuxFont.Assign(Font);
  FAuxFondo :=  Color;

  Color := FFondo;

  Brush.Color := FFondo;
  Font.Color := fTextClFondo;

  if fDestacar
  then begin
    Font.Style := [fsBold];
    Font.Size := Font.Size + 2;
  end;
  Invalidate;
  inherited DoEnter
end;

procedure TColorEdit.DoExit;
begin
 Color := FAuxFondo;
 Font.Assign(FAuxFont);
 inherited DoExit;
end;


procedure TColorEdit.KeyPress(var Key: Char);
begin
 if key = ^M
 then begin
    key := #0;
    SendMessage(Parent.Handle,WM_NEXTDLGCTL,0,0);
 end;
 inherited;

end;

constructor TColorEdit.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);

  FFondo := clWindow;
  FTextClFondo := clBlack;
  FDestacar := True;
  FAuxFondo := clWindow;
  FAuxFont := TFont.Create;

end;


procedure TColorEdit.SetDestacar(Value: Boolean);
begin
  fDestacar := Value;
end;

procedure TColorEdit.SetFondo(Value: TColor);
begin
  if FFondo <> Value then FFondo := Value;
end;


function TColorEdit.IsColorStored: Boolean;
begin
  Result := not ParentColor;
end;

end.
