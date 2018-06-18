unit ufListadoPreves;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, UGetDates, SQLExpr, jpeg;

type
  TfrmListInformesReves = class(TForm)
    repListPreves: TQuickRep;
    QRBand1: TQRBand;
    QrTitulo: TQRLabel;
    qrlFecha: TQRLabel;
    QRBDetalle: TQRBand;
    QRBand2: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel6: TQRLabel;
    QRDBText7: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText1: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText15: TQRDBText;
    procedure QRBDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Procedure DoListInformaReves;



var
  frmListInformesReves: TfrmListInformesReves;

implementation

{$R *.dfm}

uses
Globals;


Procedure DoListInformaReves;
var
Consulta: TSQLQuery;
DateIni, DateFin : string;
begin
Consulta:=TSQLQuery.Create(Application);
  If not GetDates(DateIni,DateFin)then
  Exit;
  with TSQLStoredProc.Create(application) do
    try
      Screen.Cursor := crHourglass;
      SQLConnection := MyBD;
      StoredProcName := '';
      ParamByName('FECHAINI').Value := copy(DateIni,1,10);
      ParamByName('FECHAFIN').Value := copy(DateFin,1,10);
      ExecProc;
      Screen.Cursor := crDefault;
      Close;
    finally
      Free
    end;
  with TfrmListInformesReves.Create(application) do
   try
     with Consulta do
     begin
      SQL.Clear;
      SQL.Add('SELECT * FROM ORDER BY ');
      open;
     end;
     repListPreves.DataSet := Consulta;
     qrlFecha.Caption := 'Desde: '+copy(DateIni,1,10)+' - Hasta: '+copy(DateFin,1,10);
     repListPreves.Preview;
   finally
     Consulta.Free;
   end;
end;



procedure TfrmListInformesReves.QRBDetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if repListPreves.RecordNumber mod 2 <> 0 then
    QRBDetalle.color := clWhite
  else
    QRBDetalle.color := $00EBEBEB
end;

end.
