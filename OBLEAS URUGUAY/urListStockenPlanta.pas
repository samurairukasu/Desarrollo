unit urListStockenPlanta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, dbTables, globals, uStockEstacion,
  RxGIF, uStockClasses, FMTBcd, SqlExpr, Provider, DB, DBClient;

type
  TfRepListStockEnPlanta = class(TForm)
    repStockEnPlanta: TQuickRep;
    QRBand1: TQRBand;
    qriapplus: TQRImage;
    qrlTitulo: TQRLabel;
    QRBand2: TQRBand;
    QRBDetalle: TQRBand;
    qrlPlanta: TQRLabel;
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
    QRBTotalAno: TQRBand;
    QRExpr2: TQRExpr;
    QRLabel4: TQRLabel;
    QRSysData2: TQRSysData;
    QRLabel1: TQRLabel;
    QRBand3: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    qconsulta: TClientDataSet;
    dspconsulta: TDataSetProvider;
    sdsconsulta: TSQLDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  procedure DoLisStockenPlanta(aPlanta,aIdPlanta, aTipo: string);

var
  fRepListStockEnPlanta: TfRepListStockEnPlanta;

implementation

{$R *.dfm}

procedure DoLisStockenPlanta(aPlanta,aIdPlanta, aTipo: string);
var idempresa : integer;
begin
  with TfRepListStockEnPlanta.Create(application) do
   try
      with qConsulta do
     begin
       sdsconsulta.SQLConnection := MyBD;
       CommandText:= 'SELECT * FROM TTMP_STOCKOBLEAS ORDER BY ANIO';
       open;
     end;
     repStockEnPlanta.DataSet := qConsulta;
     if aTipo = L_TIPO_VTV then
       qrlTitulo.Caption := 'Stock de Obleas VTV';
     qrlPlanta.Caption := 'Planta: '+aPlanta;


          with tplantas.CreateById(mybd,aIdPlanta) do
            try
              open;
              idempresa := strtoint(valuebyname[FIELD_IDEMPRESA]);
            finally
              free;
            end;
        {if idempresa = 1 then
        begin
          qriapplus.picture := nil;
        end
        else
        begin
          qriapplus.picture := nil;
        end;}
     repStockEnPlanta.preview;
   finally
     qConsulta.Free;
     free;
   end;
end;

end.
