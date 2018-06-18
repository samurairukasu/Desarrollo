unit urTransObleasExtraVTV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, jpeg, DB, SqlExpr, globals, RxGIF, uStockClasses,
  uStockEstacion, FMTBcd, DBClient, Provider;

type
  TFrepTransObleasExtraVTV = class(TForm)
    repMovObleasGNC: TQuickRep;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    qriapplus: TQRImage;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape4: TQRShape;
    QRLabel16: TQRLabel;
    QRExpr9: TQRExpr;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRLabel17: TQRLabel;
    QRExpr10: TQRExpr;
    QRLabel22: TQRLabel;
    QRExpr14: TQRExpr;
    qrivtv: TQRImage;
    QRLabel4: TQRLabel;
    sdsQMovimiento: TSQLDataSet;
    dspQMovimiento: TDataSetProvider;
    QMovimiento: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  procedure DoRepTransObleasExtraVTV(idMovimiento: string; idempresa: integer);

var
  FrepTransObleasExtraVTV: TFrepTransObleasExtraVTV;

implementation

{$R *.dfm}

procedure DoRepTransObleasExtraVTV(idMovimiento: string; idempresa: integer);
var
fSQL : tStringList;
begin
  with tfrepTransObleasExtraVTV.Create(application) do
    try
     fSQL := TStringList.Create;
        with QMovimiento do
        begin
        sdsQMovimiento.SqlConnection:= MyBD;
        fsql.Add('SELECT M.IDMOVIMIENTO, P.RSOCIAL PLANTA,  GET_NROPLANTA_ID(M.IDDESTINO) PDESTINO, M.CANTIDAD, '+
        'M.ANO, M.OBLEAINICIAL, M.OBLEAFINAL,TO_CHAR(M.FECHA,''DD/MM/YYYY'')AS FECHA, TO_CHAR(FECHSOLI,''DD/MM/YYYY'')AS FECHSOLI ,  '+
        'SUBSTR(GET_NOMBRE_PLANTA_ID(M.IDORIGEN),1,40) ORIGEN, GET_NROPLANTA_ID(M.IDORIGEN) PORIGEN, M.IDORIGEN PLORIGEN '+
        'FROM PROVEEDORES P, VTV_MOVIMIENTO M '+
        format('WHERE IDMOVIMIENTO = %S ',[idMovimiento])+
        'AND M.IDDESTINO = P.IDPROVEEDOR AND M.TIPO = ''X''');
        CommandText:=fsql.text;
        open;
        if recordcount = 0 then
        begin
           Application.MessageBox('La Transferencia solicitada no existe en la base','Reimpresiones',mb_iconerror+mb_ok+mb_applmodal);
           exit;
        end;
        repMovObleasGNC.DataSet := QMovimiento;

        if idempresa = 0 then
          with tplantas.CreateById(mybd,QMovimiento.fieldbyname('PLORIGEN').AsString) do
            try
              open;
              idempresa := strtoint(valuebyname[FIELD_IDEMPRESA]);
            finally
              free;
            end;
       if idempresa = 1 then
        begin
          qriapplus.picture := nil;
        end
        else
        begin
          qrivtv.picture := nil;
        end;
      end;
      repMovObleasGNC.preview;
    finally
      QMovimiento.Free;
      free;
    end;
end;

end.
