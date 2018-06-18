unit UCDBEdit;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  DBCtrls;

type
  TColorDBEdit = class(TDBEdit)
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

    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit (var Message: TCMExit); message CM_EXIT;

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
  RegisterComponents('VTVObjects', [TColorDBEdit]);
end;

procedure TColorDBEdit.CMEnter(var Message: TCMEnter);
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

    inherited
end;

procedure TColorDBEdit.CMExit(var Message: TCMExit);
begin
    Color := FAuxFondo;
    Font.Assign(FAuxFont);
    inherited
end;




procedure TColorDBEdit.KeyPress(var Key: Char);
begin
 if key = ^M
 then begin
    key := #0;
    SendMessage(Parent.Handle,WM_NEXTDLGCTL,0,0);
 end;
 inherited;

end;

constructor TColorDBEdit.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
  FFondo := clWindow;
  FTextClFondo := clBlack;
  FDestacar := True;
  FAuxFondo := clWindow;
  FAuxFont := TFont.Create;
end;


procedure TColorDBEdit.SetDestacar(Value: Boolean);
begin
  fDestacar := Value;
end;

procedure TColorDBEdit.SetFondo(Value: TColor);
begin
  if FFondo <> Value then FFondo := Value;
end;


function TColorDBEdit.IsColorStored: Boolean;
begin
  Result := not ParentColor;
end;

end.
