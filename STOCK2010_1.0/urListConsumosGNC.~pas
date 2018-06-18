unit urListConsumosGNC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, SqlExpr, globals, FMTBcd,
  Provider, DB, DBClient;

type
  TfRepListConsumosGNC = class(TForm)
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
    QRSysData2: TQRSysData;
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
  Procedure DoLisConsumosGNC(fi,ff: string);

var
  fRepListConsumosGNC: TfRepListConsumosGNC;

implementation

{$R *.dfm}

Procedure DoLisConsumosGNC(fi,ff: string);
begin
  with TfRepListConsumosGNC.Create(application) do
   try
    with qConsulta do
     begin
       sdsconsulta.SQLConnection := MyBD;
       CommandText:= 'SELECT SUBSTR(GET_NOMBRE_PLANTA(ZONA,PLANTA),1,25) SPLANTA, SUBSTR(GET_CODTALLER(ZONA,PLANTA),1,4) TALLER, APTAS, ANULADAS FROM TTMP_CONSUMOS ORDER BY ZONA, PLANTA';
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


procedure TfRepListConsumosGNC.QRBDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if repConsumosGNC.RecordNumber mod 2 <> 0 then
    QRBDetalle.color := clWhite
  else
    QRBDetalle.color := $00EBEBEB
end;

end.
