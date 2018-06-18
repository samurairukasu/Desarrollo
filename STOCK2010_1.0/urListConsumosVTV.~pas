unit urListConsumosVTV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, SqlExpr, globals, FMTBcd,
  Provider, DB, DBClient;

type
  TfRepListConsumosVTV = class(TForm)
    repConsumosGNC: TQuickRep;
    QRBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRBDetalle: TQRBand;
    QRLabel2: TQRLabel;
    qrlComprob: TQRLabel;
    qrlTaller: TQRLabel;
    qrlcant: TQRLabel;
    QREComprob: TQRExpr;
    qretaller: TQRExpr;
    qrecant: TQRExpr;
    qrlFecha: TQRLabel;
    QRExpr8: TQRExpr;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRBand4: TQRBand;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRLabel3: TQRLabel;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRLabel4: TQRLabel;
    qconsulta: TClientDataSet;
    dspconsulta: TDataSetProvider;
    sdsconsulta: TSQLDataSet;
    procedure QRBDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  Procedure DoLisConsumosVTV(fi,ff: string);

var
  fRepListConsumosVTV: TfRepListConsumosVTV;

implementation

{$R *.dfm}

Procedure DoLisConsumosVTV(fi,ff: string);
begin
  with TfRepListConsumosVTV.Create(application) do
   try
      with qConsulta do
      begin
       sdsconsulta.SQLConnection := MyBD;
       CommandText:='SELECT SUBSTR(GET_NOMBRE_PLANTA(ZONA,PLANTA),1,25) SPLANTA, ZONA||PLANTA TALLER, APTAS, ANULADAS, INUTILIZADAS, TOTAL FROM TTMP_CONSUMOS_VTV ORDER BY ZONA, PLANTA';
       open;
     end;
     repConsumosGNC.DataSet := qConsulta;
     qrlFecha.Caption := 'Desde: '+copy(fi,1,10)+' - Hasta: '+copy(ff,1,10);
     repConsumosGNC.preview;
   finally
     qConsulta.Free;
     free;
   end;
end;

procedure TfRepListConsumosVTV.QRBDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if repConsumosGNC.RecordNumber mod 2 <> 0 then
    QRBDetalle.color := clWhite
  else
    QRBDetalle.color := $00EBEBEB
end;

end.
