unit urListMovObleasGNC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, SqlExpr, globals, ustockestacion,
  FMTBcd, Provider, DB, DBClient;

type
  TfRepListMovObleasGNC = class(TForm)
    repMovObleasGNC: TQuickRep;
    QRBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRBDetalle: TQRBand;
    qrlPlanta: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    qrlPlantaEnca: TQRLabel;
    qrlTaller: TQRLabel;
    qrlcant: TQRLabel;
    qrlAno: TQRLabel;
    qrlini: TQRLabel;
    qrlfin: TQRLabel;
    QRExpr1: TQRExpr;
    QREPlanta: TQRExpr;
    qretaller: TQRExpr;
    qrecant: TQRExpr;
    qreano: TQRExpr;
    qreini: TQRExpr;
    qrefin: TQRExpr;
    qrlFecha: TQRLabel;
    QRExpr8: TQRExpr;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
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
  Procedure DoLisMovObleasGNCGlobal(fi,ff,aTipo: string);
  procedure DoLisMovObleasGNCxPlanta(fi,ff,aPlanta,aTipo: string);

var
  fRepListMovObleasGNC: TfRepListMovObleasGNC;

implementation

{$R *.dfm}

Procedure DoLisMovObleasGNCGlobal(fi,ff,aTipo: string);
begin
  with TfRepListMovObleasGNC.Create(application) do
   try
     with qConsulta do
     begin
       sdsconsulta.SQLConnection := MyBD;
       CommandText:='SELECT TO_CHAR(FECHA,''DD/MM/YYYY'') AS FECHA,IDMOVIMIENTO,NOMPLANTA,CODTALLER,CANTIDAD,ANIO,OBLEAINIC,OBLEAFIN FROM TTMP_MOVIMIENTOS ORDER BY FECHA';
       open;
     end;
     repMovObleasGNC.DataSet := qConsulta;
     qrlFecha.Caption := 'Desde: '+copy(fi,1,10)+' - Hasta: '+copy(ff,1,10);
     if aTipo = L_TIPO_VTV then
     begin
        qrlTaller.Enabled := false;
        qreTaller.Enabled := false;
     end;
     repMovObleasGNC.preview;
   finally
     qConsulta.Free;
     free;
   end;
end;

procedure DoLisMovObleasGNCxPlanta(fi,ff,aPlanta,aTipo: string);
begin
  with TfRepListMovObleasGNC.Create(application) do
   try
     with qConsulta do
     begin
       sdsconsulta.SQLConnection := MyBD;
       CommandText:='SELECT  TO_CHAR(FECHA,''DD/MM/YYYY'') AS FECHA,IDMOVIMIENTO,NOMPLANTA,CODTALLER,CANTIDAD,ANIO,OBLEAINIC,OBLEAFIN FROM TTMP_MOVIMIENTOS ORDER BY FECHA';
       open;
     end;
     repMovObleasGNC.DataSet := qConsulta;
     qrlPlanta.Caption := 'Planta: '+aPlanta;
     qrlFecha.Caption := 'Desde: '+copy(fi,1,10)+' - Hasta: '+copy(ff,1,10);
     qrlPlantaEnca.Enabled := false;
     QREPlanta.Enabled := false;
     qrlTaller.Left := qrlTaller.Left - 180;
     qrlcant.Left := qrlcant.Left - 150;
     qrlAno.Left := qrlAno.Left -120;
     qrlini.Left := qrlini.Left - 90;
     qrlfin.Left :=  qrlfin.Left - 60;
     qreTaller.Left := qreTaller.Left - 180;
     qrecant.Left := qrecant.Left - 150;
     qreAno.Left := qreAno.Left -120;
     qreini.Left := qreini.Left - 90;
     qrefin.Left :=  qrefin.Left - 60;
     if aTipo = L_TIPO_VTV then
     begin
        qrlTaller.Enabled := false;
        qreTaller.Enabled := false;
     end;

     repMovObleasGNC.preview;
   finally
     qConsulta.Free;
     free;
   end;
end;

procedure TfRepListMovObleasGNC.QRBDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if repMovObleasGNC.RecordNumber mod 2 <> 0 then
    QRBDetalle.color := clWhite
  else
//    QRBDetalle.color := $00DFDFDF;
    QRBDetalle.color := $00EBEBEB
end;

end.
