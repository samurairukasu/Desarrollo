unit urListEnviosCDVTV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, SqlExpr, globals, FMTBcd,
  Provider, DB, DBClient;

type
  TfRepListEnviosCDVTV = class(TForm)
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
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr9: TQRExpr;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRBand3: TQRBand;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    QRExpr12: TQRExpr;
    QRExpr13: TQRExpr;
    QRExpr14: TQRExpr;
    QRExpr15: TQRExpr;
    QRExpr16: TQRExpr;
    QRExpr17: TQRExpr;
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
  procedure DoLisEnvioCDVTV(fechas: string);

var
  fRepListEnviosCDVTV: TfRepListEnviosCDVTV;

implementation

{$R *.dfm}

procedure DoLisEnvioCDVTV(fechas: string);
var fSQL : tStringList;
begin
  with TfRepListEnviosCDVTV.Create(application) do
   try
     fSQL := TStringList.Create;
     with qConsulta do
     begin
       sdsconsulta.SQLConnection := MyBD;
       fSQL.Add('SELECT ZONA||PLANTA TALLER, TO_CHAR(FECHA,''dd/mm/yyyy'') as FECHA, APTAS, '+
       'RECHAZADAS, CONDICIONALES, SUBSTR(GET_NOMBRE_PLANTA(ZONA,PLANTA),1,20) NOMBRE ,'+
       'APTASR, CONDICIONALESR, RECHAZADASR, ANULADAS, INUTILIZADAS FROM TTMP_CONTROL_VTV ORDER BY TALLER ,FECHA');
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

procedure TfRepListEnviosCDVTV.QRBDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if repEnviosCDGNC.RecordNumber mod 2 <> 0 then
    QRBDetalle.color := clWhite
  else
    QRBDetalle.color := $00EBEBEB
end;

end.
