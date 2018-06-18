unit UFRestaurarOblea;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Mask, UsagClasses, SQLExpr, globals, USAGESTACION;

type
  TFrmRestaurarOblea = class(TForm)
    BtnRestaurar: TBitBtn;
    BitBtn2: TBitBtn;
    MEOblea: TMaskEdit;
    Label2: TLabel;
    Bevel1: TBevel;
    Ima2: TImage;
    Ima1: TImage;
    procedure BitBtn2Click(Sender: TObject);
    procedure BtnRestaurarClick(Sender: TObject);
    Procedure RestaurarOblea(sOblea: String);
    Procedure DesbloquearOblea(sOblea: String);
    Function NoTieneNotaDeCredito(sOblea: String): Boolean;
    Procedure ObleaValida(Mostrar: Boolean);
    procedure FormShow(Sender: TObject);
    procedure MEObleaChange(Sender: TObject);
    procedure ReLimpiar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Procedure DoReestablecerObleaNC;
  Procedure DoReestablecerObleaBloqueada;

var
  FrmRestaurarOblea: TFrmRestaurarOblea;
  fInspeccion: TInspeccion;
  fOblea: TOblea;
  fFactura: TFacturacion;
  sIInspeccion, sOInspeccion, sObleaAsig: String;
  aContraFactura: TContrafacturas;
  sNroFactura: String;

const
 SOBLEANC  = 'Restaurar Oblea por NOTA DE CREDITO';
 SOBLEABK  = 'Restaurar Oblea BLOQUEADA';
 kVacio = '';

implementation

uses
UFRestaurarObleaPWD;


{$R *.dfm}

Procedure DoReestablecerObleaNC;
Begin
With TFrmRestaurarOblea.Create(Nil) do
  try
    Caption:= SOBLEANC;
    ShowModal;
  finally
    Free;
  end;
end;


Procedure DoReestablecerObleaBloqueada;
Begin
With TFrmRestaurarObleaPWD.Create(Nil) do
  try
    Resultado:=False;
    ShowModal;
    If Resultado then
      With TFrmRestaurarOblea.Create(nil) do
        try
          Caption:= SOBLEABK;
          ShowModal;
        finally
          Free;
      end;
  finally
    free;
  end;
end;


procedure TFrmRestaurarOblea.ReLimpiar;
Begin
Ima1.Visible:=False;
Ima2.Visible:=False;
MEOblea.Clear;
MEOblea.SetFocus;
end;


procedure TFrmRestaurarOblea.BtnRestaurarClick(Sender: TObject);
begin
If Caption = SOBLEANC then
  Begin
    RestaurarOblea(sObleaAsig);
  end
else
if Caption = SOBLEABK then
  Begin
    If MessageBox(0, '¿ESTA SEGURO QUE QUIERE DESBLOQUAR LA OBLEA?', 'Desbloquear Oblea', MB_ICONQUESTION or MB_YESNO) = mrYes then
      DesbloquearOblea(sObleaAsig);
  end;
end;


procedure TFrmRestaurarOblea.MEObleaChange(Sender: TObject);
begin
If length(MEOblea.Text)=8 then
  Begin
    sObleaAsig:=Copy(MEOblea.Text,1,2)+Copy(MEOblea.Text,3,7);
    fOblea:=TOblea.CreateByOblea(MyBD,sObleaAsig);
    fOblea.Open;
    If Caption = SOBLEANC then
      ObleaValida(NoTieneNotaDeCredito(sObleaAsig))
    else
    If Caption = SOBLEABK then
      Begin
        If (fOblea.IsObleaTomada) or (fOblea.IsObleaInutilizada) then
          ObleaValida(True)
        else
          Begin
            ObleaValida(False);
            MessageDlg('LA OBLEA INGRESADA NO SE ENCUENTRA EN'+#13+#10+'ESTADO "BLOQUEADA"', mtInformation, [mbOK], 0);
          end;
      end;
  end;
end;



Function TFrmRestaurarOblea.NoTieneNotaDeCredito(sOblea: String): Boolean;
Begin
Screen.Cursor:=crHourGlass;
Result:=False;
  try
    fInspeccion:=TInspeccion.Create(MyBD,Format('WHERE NUMOBLEA = ''%S'' ',[sOblea]));
    fInspeccion.Open;
    if (fInspeccion.ValueByName[FIELD_NUMOBLEA] <> kVacio) and (fInspeccion.ValueByName[FIELD_CODFACTU] <> kVacio) then
      Begin
        fFactura:=fInspeccion.GetFactura;
        fFactura.Open;
        if (fFactura.ValueByName[FIELD_CODCOFAC] <> '') then
          Result:=true;
        fFactura.Free;
      end;
  finally
    fInspeccion.Free;
    Screen.Cursor:=crDefault;
  end;
end;


 
Procedure TFrmRestaurarOblea.RestaurarOblea(sOblea: String);
Begin
If NoTieneNotaDeCredito(sObleaAsig) then
  Begin
    fOblea.LiberarOblea;
    fOblea.Free;
    MessageBox(0, 'La Oblea, ha sido restaurada!', 'Felicidades!', MB_ICONINFORMATION or MB_OK);
    ReLimpiar;
  end
else
  MessageDlg('Esa Oblea, no esta asignada a una Inspeccion'+#13+#10+'que tenga realizada una Nota de Credito.', mtError, [mbOK], 0);
end;


Procedure TFrmRestaurarOblea.DesbloquearOblea(sOblea: String);
Begin
  Try
    Case fOblea.Estado[1] of
      INUTILIZADA:
        Begin
          If not fOblea.ExistInT_ERVTV_INUTILIZ(sOblea) and not fOblea.ExistInTInspeccion(sOblea) then
            Begin
              fOblea.LiberarOblea;
              fOblea.Free;
              ReLimpiar;
              MessageDlg('LA OBLEA HA SIDO RESTAURADA CON EXITO!', mtInformation, [mbOK], 0);
            end
          else
            MessageDlg('LA OBLEA NO HA SIDO RESTAURADA!', mtError, [mbOK], 0);
        end;
      TOMADA:
        Begin
          fOblea.LiberarOblea;
          fOblea.Free;
          ReLimpiar;
          MessageDlg('LA OBLEA HA SIDO RESTAURADA CON EXITO!', mtInformation, [mbOK], 0);
        end;
    end;
  Except
    On E: Exception Do
      ShowMessage('LA OBLEA NO SE PUDO DESBLOQUEAR A CAUSA DE: '+#13#10+E.Message);
  End;
end;



procedure TFrmRestaurarOblea.BitBtn2Click(Sender: TObject);
begin
Close;
end;


procedure TFrmRestaurarOblea.FormShow(Sender: TObject);
begin
MEOblea.SetFocus;
end;


procedure TFrmRestaurarOblea.ObleaValida(Mostrar: Boolean);
Begin
  Case Mostrar of
    true:
      Begin
        Ima1.Visible:=True;
        Ima2.Visible:=False;
      end;
    False:
      Begin
        Ima2.Visible:=True;
        Ima1.Visible:=False;
      end;
  end;
end;



end.
