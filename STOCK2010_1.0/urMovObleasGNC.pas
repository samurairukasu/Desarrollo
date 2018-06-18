unit urMovObleasGNC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, jpeg, DB,  globals, RxGIF,
  ustockclasses, ustockestacion,sqlexpr ;

type
  TFrepMovObleasGNC = class(TForm)
    repMovObleasGNC: TQuickRep;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    qriapplus: TQRImage;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    dbtPrepara: TQRDBText;
    dbtAutoriza: TQRDBText;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape4: TQRShape;
    QRLabel16: TQRLabel;
    QRExpr9: TQRExpr;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRLabel17: TQRLabel;
    QRExpr10: TQRExpr;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRExpr11: TQRExpr;
    QRExpr12: TQRExpr;
    QRExpr13: TQRExpr;
    QRShape14: TQRShape;
    QRLabel22: TQRLabel;
    QRExpr14: TQRExpr;
    qrivtv: TQRImage;
  private
    { Private declarations }
    QMovimiento : TSqlQuery;
  public
    { Public declarations }
  end;
  procedure DoRepMovObleasGNC(idMovimiento: string; idempresa: integer);

var
  FrepMovObleasGNC: TFrepMovObleasGNC;

implementation

{$R *.dfm}

procedure DoRepMovObleasGNC(idMovimiento: string; idempresa: integer);
begin
  with tfrepMovObleasGNC.Create(application) do
    try
      QMovimiento := TSqlQuery.Create(nil);
      with QMovimiento do
      begin
        SQLConnection:= MyBD;
        sql.Add('SELECT M.IDMOVIMIENTO, P.NOMBRE PLANTA, P.CODTALLER, E.DESCRIPCION EMPRESA, M.CANTIDAD, GETPERSONAL(IDPREPARA) PREPARA, ');
        sql.Add('GETPERSONAL (IDAUTORIZA) AUTORIZA, M.ANO, M.OBLEAINICIAL, M.OBLEAFINAL, TO_CHAR(M.FECHA,''DD/MM/YYYY'') FECHA , TO_CHAR(FECHSOLI,''DD/MM/YYYY'') AS FECHSOLI, CANTTARJAMA, CANTETIQGNC, CANTBOLSI, ');
        sql.Add('SUBSTR(GET_NOMBRE_PLANTA_ID(M.IDORIGEN),1,20) ORIGEN, SUBSTR(GET_CODTALLER_ID(M.IDORIGEN),1,6) TALLORIGEN, M.IDORIGEN PLORIGEN ');
        sql.Add('FROM PLANTAS P, EMPRESAS E, MOVIMIENTOS M ');
        sql.Add(format('WHERE IDMOVIMIENTO = %S ',[idMovimiento]));
        sql.add('AND M.IDDESTINO = P.IDPLANTA AND P.IDEMPRESA = E.IDEMPRESA');
        open;
        if recordcount = 0 then
        begin
           Application.MessageBox('El N� de entrega solicitado no existe en la base','Reimpresiones',mb_iconerror+mb_ok+mb_applmodal);
           exit;
        end;
        repMovObleasGNC.DataSet := QMovimiento;
        dbtPrepara.DataSet := QMovimiento;
        dbtAutoriza.DataSet := QMovimiento;
      end;
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

      repMovObleasGNC.preview;
    finally
      QMovimiento.Free;
      free;
    end;
end;

end.
