unit urRecepObleasVTV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, jpeg, DB, dbTables, globals, RxGIF, uStockClasses,
  uStockEstacion;

type
  TFrepRecepObleasVTV = class(TForm)
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
    QRExpr1: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
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
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRExpr2: TQRExpr;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  procedure DoRepRecepObleasVTV(idMovimiento: string; idempresa: integer);

var
  FrepRecepObleasVTV: TFrepRecepObleasVTV;

implementation

{$R *.dfm}

procedure DoRepRecepObleasVTV(idMovimiento: string; idempresa: integer);
begin
  with TFrepRecepObleasVTV.Create(application) do
    try
      QMovimiento := TQuery.Create(nil);
      with QMovimiento do
      begin
        DatabaseName := MyBD.DatabaseName;
        SessionName := MyBD.SessionName;
        sql.Add('SELECT M.IDMOVIMIENTO, P.RSOCIAL ORIGEN,  M.CANTIDAD, ');
        sql.Add('M.ANO, M.OBLEAINICIAL, M.OBLEAFINAL, M.FECHA, NROCOMPROBANTE, ');
        sql.Add('SUBSTR(GET_NOMBRE_PLANTA_ID(M.IDDESTINO),1,40) PLANTA  ');
        sql.Add('FROM PROVEEDORES P, VTV_MOVIMIENTO M ');
        sql.Add(format('WHERE IDMOVIMIENTO = %S ',[idMovimiento]));
        sql.add('AND M.IDDESTINO = P.IDPROVEEDOR AND M.TIPO = ''E''');
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
