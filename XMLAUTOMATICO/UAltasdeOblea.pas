unit UAltasdeOblea;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, Buttons, SqlExpr, ExtCtrls, RxGIF;

type
  TFrmAltaObleas = class(TForm)
    Grupo: TGroupBox;
    EAnio: TEdit;
    MEObleaFin: TMaskEdit;
    ECantidad: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BtnGenerar: TBitBtn;
    MEObleaIni: TMaskEdit;
    Sh_Oblea: TShape;
    Shape2: TShape;
    Label6: TLabel;
    Label7: TLabel;
    Shape1: TShape;
    Label5: TLabel;
    Image1: TImage;
    LAnio: TLabel;
    procedure ECantidadExit(Sender: TObject);
    procedure BtnGenerarClick(Sender: TObject);
    procedure MEObleaIniExit(Sender: TObject);
    procedure EAnioExit(Sender: TObject);
    Procedure AsignarColor(sAnio: String);
    procedure FormActivate(Sender: TObject);
    procedure EAnioKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  Procedure DoAltasDeObleas;

var
  FrmAltaObleas: TFrmAltaObleas;
  vObleaIni, vObleaFin, vCantidad: Integer;
  aObleas_Colores: Array [1..6] of TColor = ($005050A0,$0039B73D,$006AFFFF,$00C08000, $000000F0,clWhite);

implementation

Uses
Globals, uLogs;

{$R *.dfm}


Procedure DoAltasDeObleas;
Begin
With TFrmAltaObleas.Create(Application) Do
  try
    ShowModal;
  finally
    Free;
  end;
end;

Procedure TFrmAltaObleas.AsignarColor(sAnio: String);
var
Valor: Integer;
Begin
Valor:=StrToInt(Copy(sAnio,2,4));
  Case Valor of
    7,13,19,25: Sh_Oblea.Brush.Color:=aObleas_Colores[1];
    8,14,20,26: Sh_Oblea.Brush.Color:=aObleas_Colores[2];
    9,15,21,27: Sh_Oblea.Brush.Color:=aObleas_Colores[3];
    10,16,22,28: Sh_Oblea.Brush.Color:=aObleas_Colores[4];
    11,17,23,29: Sh_Oblea.Brush.Color:=aObleas_Colores[5];
    12,18,24,30: Sh_Oblea.Brush.Color:=aObleas_Colores[6];
  end;
end;

      
procedure TFrmAltaObleas.ECantidadExit(Sender: TObject);
begin
If ECantidad.Text = '' then
  Begin
    MessageDlg('DEBE INGRESAR UNA CANTIDAD VALIDA!!', mtError, [mbOK], 0);
    ECantidad.SetFocus;
  end
else
  Begin
    vObleaIni:=StrToInt(MEObleaIni.Text);
    vCantidad:=StrToInt(ECantidad.Text);
    vObleaFin:=(vObleaIni+vCantidad)-1;
    MEObleaFin.Text:=FormatFloat('00000000',vObleaFin);
  end;
end;


procedure TFrmAltaObleas.BtnGenerarClick(Sender: TObject);
var
Error: String;
begin
Error:='';
If (EAnio.Text = '') or (Length(EAnio.Text)<=3) then
  Error:=Error+'* Año'+#13#10;
If MEObleaIni.Text = '' then
  Error:=Error+'* Nro. de Oblea'+#13#10;
If ECantidad.Text = '' then
  Error:=Error+'* Cantidad de Obleas'+#13#10;
If Error = '' then
  Begin
    If MessageDlg('ESTA SEGURO QUE QUIERE DAR DE ALTA '+ECantidad.Text+' OBLEAS.'+#13#10+ 'PERTENECIENTES AL AÑO '+EAnio.Text +'? '+#13#10#13#10+
                  'Obleas desde: '+MEObleaIni.Text+' hasta: '+MEObleaFin.Text, mtWarning, [mbYes, mbNo], 0) = mrYes then
      Begin
        Try
        With TSQLQuery.Create(nil) do
          Begin
            SQL.Clear;
            Close;
            SQLConnection:=MyBD;
            SQL.Add('Select * from TOBLEAS Where NUMOBLEA BETWEEN :OBLEAINI AND :OBLEAFIN AND ANIO = :ANIO');
            Params[0].Value:= vObleaIni;
            Params[1].Value:= vObleaFin;
            Params[2].Value:= StrToInt(EAnio.Text);
            Open;
            If (Fields[0].Value = null) then
            Begin
              with TSQLStoredProc.Create(application) do
              Begin
                SQLConnection := MyBD;
                StoredProcName := 'PQ_NEWOBLEAS.DORANGOBLEAS';
                ParamByName('ANIO').Value:= StrToInt(EAnio.Text);
                ParamByName('OBLEAINICIAL').Value:= vObleaIni;
                ParamByName('OBLEAFINAL').Value:= vObleaFin;
                ParamByName('CANTIDAD').Value:= vCantidad;
                ExecProc;
              end;
              {$IFDEF TRAZAS}
              FTrazas.PonAnotacion (1,1, 'ALTAS DE OBLEAS: ', 'SE DIERON DE ALTA '+IntToStr(vCantidad)+' OBLEAS, DESADE LA NRO: '+IntToStr(vObleaIni)+'  HASTA LA: '+IntToStr(vObleaFin)+', PERTENECIENTES AL AÑO: '+EAnio.Text );
              {$ENDIF}
              MessageDlg('SE HAN GENERADO LAS'+#13+#10+'OBLEAS CORRECTAMENTE!!!', mtInformation, [mbOK], 0);
            end
            else
              MessageDlg('EL RANGO DE OBLEAS INGRESADO '+#13+#10+'CONTIENE NUMEROS DE OBLEAS YA'+#13+#10+'DADOS DE ALTA.', mtError, [mbOK], 0);
          end;
        Except
          on E: Exception do
            MessageDlg('Error ocurrido a:'#13#10+E.Message, mtError, [mbOK], 0);
        end;
      end;
  end
else
    MessageDlg('Se han encontrado Errores en los'+#13#10+'siguientes campos:'+#13#10#13#10+Error, mtError, [mbOK], 0);
end;


procedure TFrmAltaObleas.MEObleaIniExit(Sender: TObject);
begin
If MEObleaIni.Text = '' then
  Begin
    MessageDlg('DEBE INGRESAR UN NUMERO'+#13+#10+'DE OBLEA VALIDO!!', mtError, [mbOK], 0);
    MEObleaIni.SetFocus;
  end;
end;


procedure TFrmAltaObleas.EAnioExit(Sender: TObject);
begin
If (EAnio.Text = '') or (Length(EAnio.Text)<=3) then
  Begin
    MessageDlg('DEBE INGRESAR UN AÑO VALIDO!!', mtError, [mbOK], 0);
    EAnio.SetFocus;
  end
else
  Begin
    LAnio.Caption:=EAnio.Text[1]+' '+EAnio.Text[2]+' '+EAnio.Text[3]+' '+EAnio.Text[4];
    AsignarColor(EAnio.Text);
  end;
end;


procedure TFrmAltaObleas.FormActivate(Sender: TObject);
var
AnioActual: String;
begin
AnioActual:=Copy(DateToStr(Date),9,2);
AsignarColor(AnioActual);
end;

procedure TFrmAltaObleas.EAnioKeyPress(Sender: TObject; var Key: Char);
begin
if (Key = Chr(VK_RETURN)) then
  Perform(WM_NEXTDLGCTL,0,0);
if (Key = Chr(VK_ESCAPE)) then
  Close;
end;

end.
