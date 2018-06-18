unit urListConsumosVTVxAno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, SqlExpr, globals, FMTBcd,
  Provider, DB, DBClient;

type
  TfRepListConsumosVTVxAno = class(TForm)
    qconsulta: TClientDataSet;
    dspconsulta: TDataSetProvider;
    sdsconsulta: TSQLDataSet;
    repConsumosGNCxAno: TQuickRep;
    QRBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    qrlFecha: TQRLabel;
    QRBand2: TQRBand;
    QRLabel2: TQRLabel;
    qrlComprob: TQRLabel;
    qrlTaller: TQRLabel;
    qrlcant: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRBDetalle: TQRBand;
    QREComprob: TQRExpr;
    qretaller: TQRExpr;
    qrecant: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr7: TQRExpr;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    qrbTotal: TQRBand;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRLabel3: TQRLabel;
    QRExpr6: TQRExpr;
    QRGroup1: TQRGroup;
    QRExpr4: TQRExpr;
    QRExpr8: TQRExpr;
    QRBand4: TQRBand;
    QRLabel6: TQRLabel;
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    QRExpr12: TQRExpr;
    procedure QRBDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  Procedure DoLisConsumosVTVxAno(fi,ff: string);

var
  fRepListConsumosVTVxAno: TfRepListConsumosVTVxAno;

implementation

{$R *.dfm}

Procedure DoLisConsumosVTVxAno(fi,ff: string);

begin
  with TfRepListConsumosVTVxAno.Create(application) do
   try
      with qConsulta do
     begin
       sdsconsulta.SQLConnection := MyBD;
       CommandText:= 'SELECT SUBSTR(GET_NOMBRE_PLANTA(ZONA,PLANTA),1,25) SPLANTA, ZONA||PLANTA TALLER, EJERCICI ,CONSUMIDAS, ANULADAS, INUTILIZADAS, TOTAL FROM TTMP_CONSUMOSANIO_VTV ORDER BY  TALLER,SPLANTA, EJERCICI';
       open;
     end;
     repConsumosGNCxAno.DataSet := qConsulta;
     qrlFecha.Caption := 'Desde: '+copy(fi,1,10)+' - Hasta: '+copy(ff,1,10);
     repConsumosGNCxAno.preview;

   finally
     qConsulta.Free;
     free;
   end;
end;


procedure TfRepListConsumosVTVxAno.QRBDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
//  if repConsumosGNCxAno.RecordNumber mod 2 <> 0 then
//    QRBDetalle.color := clWhite
//  else
//    QRBDetalle.color := $00EBEBEB
end;

end.
