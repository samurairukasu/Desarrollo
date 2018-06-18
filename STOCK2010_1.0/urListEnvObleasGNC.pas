unit urListEnvObleasGNC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, SqlExpr, globals, ustockestacion,
  QRExport, FMTBcd, Provider, DB, DBClient;

type
  TfRepListEnvObleasGNC = class(TForm)
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
    qrltaller: TQRLabel;
    QRExcelFilter1: TQRExcelFilter;
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
  Procedure DoLisEnvObleasGNCGlobal(fi,ff,aTipo: string);
  procedure DoLisEnvObleasGNCxPlanta(fi,ff,aPlanta,aTipo: string);

var
  fRepListEnvObleasGNC: TfRepListEnvObleasGNC;

implementation

{$R *.dfm}

Procedure DoLisEnvObleasGNCGlobal(fi,ff,aTipo: string);
begin
  with TfRepListEnvObleasGNC.Create(application) do
   try
      with qConsulta do
     begin
       sdsconsulta.SQLConnection := MyBD;
       CommandText:= 'SELECT TO_CHAR(FECHA,''DD/MM/YYYY'') AS FECHA,IDMOVIMIENTO,PLANTAORIGEN,PLANTADESTINO,CODTALLERDESTINO,CANTIDAD,ANIO,OBLEAINIC,OBLEAFIN FROM TTMP_SALIDAS ORDER BY FECHA';
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

procedure DoLisEnvObleasGNCxPlanta(fi,ff,aPlanta,aTipo: string);
begin
  with TfRepListEnvObleasGNC.Create(application) do
   try
     with qConsulta do
     begin
       sdsconsulta.SQLConnection := MyBD;
       CommandText:= 'SELECT M.*, SUBSTR(GET_CODTALLER_NOM(NOMPLANTA),1,4) TALLER FROM TTMP_MOVIMIENTOS M ORDER BY FECHA';
       open;
     end;
     repMovObleasGNC.DataSet := qConsulta;
     qretaller.Expression := 'TALLER+'' ''+NOMPLANTA';
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

procedure TfRepListEnvObleasGNC.QRBDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if repMovObleasGNC.RecordNumber mod 2 <> 0 then
    QRBDetalle.color := clWhite
  else
//    QRBDetalle.color := $00DFDFDF;
    QRBDetalle.color := $00EBEBEB
end;

end.