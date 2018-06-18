unit urListConsCertificados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, SqlExpr, globals, FMTBcd,
  Provider, DB, DBClient;

type
  TfRepListConsCertifInfor = class(TForm)
    repStockGlobal: TQuickRep;
    QRBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRBDetalle: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    qrlComprob: TQRLabel;
    qrlTaller: TQRLabel;
    qretaller: TQRExpr;
    QRExpr8: TQRExpr;
    qrbPiePagina: TQRBand;
    QRSysData1: TQRSysData;
    QRGroup1: TQRGroup;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRLabel4: TQRLabel;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    sumxplanta: TQRBand;
    QRExpr5: TQRExpr;
    QRBand3: TQRBand;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr9: TQRExpr;
    QRSysData2: TQRSysData;
    qconsulta: TClientDataSet;
    dspconsulta: TDataSetProvider;
    sdsconsulta: TSQLDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  procedure DoLisConsCertificados;

var
  fRepListConsCertifInfor: TfRepListConsCertifInfor;

implementation

{$R *.dfm}

procedure DoLisConsCertificados;
var fSQL : tStringList;
begin
  with TfRepListConsCertifInfor.Create(application) do
   try
     fSQL := TStringList.Create;
     with qConsulta do
     begin
       sdsconsulta.SQLConnection := MyBD;
       fSQL.Add('SELECT ID,IDMOVIMIENTO, SUBSTR(GET_NROPLANTA_ID(IDPLANTA),1,6) IDPLANTA, SUBSTR(GET_NOMBRE_PLANTA_ID(IDPLANTA),1,35) SPLANTA, '+
       'CANTIDAD, NROINICIAL , NROFINAL  FROM ttmp_stock_certinfor ORDER BY IDPLANTA ,ID,IDMOVIMIENTO');
        CommandText:=fsql.text ;
       open;
     end;
     repStockGlobal.DataSet := qConsulta;
//     qrlFecha.Caption := fechas;
       repStockGlobal.preview;

   finally
     qConsulta.Free;
     free;
   end;
end;

end.
