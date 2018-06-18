unit ufListadoCilindrosReguladToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, quickrpt, globals, Qrctrls, FMTBcd, DBClient, Provider,
  SqlExpr;

type
  TfrmListCiliReguToPrint = class(TForm)
    sdsqlistado: TSQLDataSet;
    dspqlistado: TDataSetProvider;
    qlistado: TClientDataSet;
    repRegularores: TQuickRep;
    QRBand5: TQRBand;
    QRLabel7: TQRLabel;
    QRBand6: TQRBand;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRBand7: TQRBand;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRBand8: TQRBand;
    QRSysData2: TQRSysData;
    repCilindros: TQuickRep;
    QRBand1: TQRBand;
    QRLabel6: TQRLabel;
    QRBand2: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRBand3: TQRBand;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor CreateCiliRegu( aTipoListado: char);
  end;

var
  frmListCiliReguToPrint: TfrmListCiliReguToPrint;

implementation

{$R *.DFM}

constructor TfrmListCiliReguToPrint.CreateCiliRegu( aTipoListado: char);
var fsql : TStringList;
begin
  inherited create(application);
  sdsqlistado.SQLConnection := MyBD;
  fsql := TStringList.Create;
  case aTipoListado of
    'C': begin
        with qlistado do
        begin
          fsql.add('SELECT CODIGO, NOMBRE, CAPACIDAD, DIAMETRO, REPRUEBA ');
          fSQL.ADD('FROM CILINDROSENARGAS C, MARCASENARGAS M ');
          fSQL.ADD('WHERE C.CODMARCA = M.CODMARCA ORDER BY CODIGO');
          CommandText := fsql.Text;
          OPEN;
        end;
    end;
    'R': begin
        with qlistado do
        begin
          fsql.add('SELECT CODIGO, NOMBRE, MODELO, TIPO ');
          fSQL.ADD('FROM REGULADORESENARGAS R, MARCASENARGAS M ');
          fSQL.ADD('WHERE R.CODMARCA = M.CODMARCA ORDER BY CODIGO');
          CommandText := fsql.Text;          
          OPEN;
        end;
    end;
  end;
end;

end.
