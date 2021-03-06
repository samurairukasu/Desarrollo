unit urListEnviosCD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, SqlExpr, globals, FMTBcd,
  Provider, DB, DBClient;

type
  TfRepListEnviosCDGNC = class(TForm)
    repEnviosCDGNC: TQuickRep;
    QRBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRBDetalle: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    qrlComprob: TQRLabel;
    qrlTaller: TQRLabel;
    QREComprob: TQRExpr;
    qretaller: TQRExpr;
    QRExpr8: TQRExpr;
    qrbPiePagina: TQRBand;
    QRSysData1: TQRSysData;
    QRGroup1: TQRGroup;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRLabel4: TQRLabel;
    qrlFecha: TQRLabel;
    QRExpr3: TQRExpr;
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
  procedure DoLisEnvioCDGNC(fechas: string);

var
  fRepListEnviosCDGNC: TfRepListEnviosCDGNC;

implementation

{$R *.dfm}

procedure DoLisEnvioCDGNC(fechas: string);
var fSQL : tStringList;
begin
  with TfRepListEnviosCDGNC.Create(application) do
   try
     fSQL := TStringList.Create;
     with qConsulta do
     begin
       sdsconsulta.SQLConnection := MyBD;
       fSQL.Add('SELECT substr(GET_CODTALLER(ZONA,PLANTA),1,4) TALLER, TO_CHAR(FECHA,''dd/mm/yyyy'') as FECHA, APTAS, '+
       'RECHAZADAS, ANULADAS, SUBSTR(GET_NOMBRE_PLANTA(ZONA,PLANTA),1,20) NOMBRE FROM TTMP_CONTROL ORDER BY TALLER ,FECHA');
        CommandText:=fsql.Text;
       open;
     end;
     repEnviosCDGNC.DataSet := qConsulta;
     qrlFecha.Caption := fechas;
     repEnviosCDGNC.preview;
   finally
     qConsulta.Free;
     free;
   end;
end;

procedure TfRepListEnviosCDGNC.QRBDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if repEnviosCDGNC.RecordNumber mod 2 <> 0 then
    QRBDetalle.color := clWhite
  else
    QRBDetalle.color := $00EBEBEB
end;

end.
