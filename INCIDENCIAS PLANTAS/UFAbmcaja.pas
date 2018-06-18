unit UFAbmcaja;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, usuperregistry,
  StdCtrls, RXSpin, Buttons, ExtCtrls, uversion, ucdialgs;

type
  Tfrmabmcaja = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    chcaja: TCheckBox;
    spnrocaja: TRxSpinEdit;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  frmabmcaja: Tfrmabmcaja;

implementation

{$R *.DFM}


procedure Tfrmabmcaja.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmabmcaja.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
end;

procedure Tfrmabmcaja.FormShow(Sender: TObject);
var SuperRegistry: TSuperRegistry;
    nrocaja:integer;

begin
  try
   superregistry:= tsuperregistry.create;
   with SuperRegistry do
    try
      RootKey := HKEY_LOCAL_MACHINE;
      if not OpenKeyRead(CAJA_) then
      begin
          Messagedlg('ERROR','No se encontraron los parámetros de la Estación de Trabajo', mtInformation, [mbOk],mbOk,0);
      end
      else
      begin
        spnrocaja.AsInteger := ReadInteger(NROCAJA_);
        chcaja.checked:=(ReadInteger(ESCAJA_)=1);
      end;
    except
        on E: exception do

        end;
  finally
    superregistry.free;
  end;

end;

procedure Tfrmabmcaja.BitBtn1Click(Sender: TObject);
begin
  if application.messagebox('¿Confirma los cambios realizados?',pchar(caption),mb_yesno+mb_applmodal+mb_defbutton1+mb_iconquestion) = 6 then
  begin
     with TSuperRegistry.Create do
     try
        RootKey := HKEY_LOCAL_MACHINE;
        if not OpenKeySec(CAJA_,False,KEY_SET_VALUE) then
      begin
          Messagedlg('ERROR','No se encontraron los parámetros de la Estación de Trabajo', mtInformation, [mbOk],mbOk,0);
      end
      else
      begin
        Writeinteger(NROCAJA_, spnrocaja.asinteger);
        case chcaja.checked of
        true: begin
          Writeinteger(ESCAJA_, 1)
        end;
        false: begin
          Writeinteger(ESCAJA_, 0)
        end;
        end;
      end;
     finally
       free;
     end;
     close;
  end
  else
  begin
     with TSuperRegistry.Create do
     try
        RootKey := HKEY_LOCAL_MACHINE;
      if not OpenKeyRead(CAJA_) then
      begin
          Messagedlg('ERROR','No se encontraron los parámetros de la Estación de Trabajo', mtInformation, [mbOk],mbOk,0);
      end
      else
      begin
        spnrocaja.AsInteger := ReadInteger(NROCAJA_);
        chcaja.checked:=(ReadInteger(ESCAJA_)=1);
      end;
     finally
       free;
     end;
  end;
end;

end.
