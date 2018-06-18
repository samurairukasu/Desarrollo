unit urMovObleasVTV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, jpeg, DB, dbTables, globals, RxGIF, uStockClasses,
  uStockEstacion,SqlExpr, FMTBcd, Provider, DBClient;

type
  TFrepMovObleasVTV = class(TForm)
    repMovObleasGNC: TQuickRep;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    qriapplus: TQRImage;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
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
    QRLabel19: TQRLabel;
    QRLabel21: TQRLabel;
    QRExpr11: TQRExpr;
    QRExpr13: TQRExpr;
    QRShape14: TQRShape;
    QRLabel22: TQRLabel;
    QRExpr14: TQRExpr;
    qrivtv: TQRImage;
    QRExpr2: TQRExpr;
    QRExpr12: TQRExpr;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRLabel4: TQRLabel;
    QRShape17: TQRShape;
    qconsulta: TClientDataSet;
    dspconsulta: TDataSetProvider;
    sdsconsulta: TSQLDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  procedure DoRepMovObleasVTV(idMovimiento: string; idempresa: integer);

var
  FrepMovObleasVTV: TFrepMovObleasVTV;

implementation

{$R *.dfm}

procedure DoRepMovObleasVTV(idMovimiento: string; idempresa: integer);
var
fSQL : tStringList;
begin
  with tfrepMovObleasVTV.Create(application) do
    try
       fSQL := TStringList.Create;
      with qconsulta do
      begin
        sdsconsulta.SqlConnection:= MyBD;
        Fsql.Add('SELECT M.IDMOVIMIENTO, P.NOMBRE PLANTA,  GET_NROPLANTA_ID(M.IDDESTINO) PDESTINO, E.DESCRIPCION EMPRESA, M.CANTIDAD, GETPERSONAL(IDPREPARA) PREPARA, ');
        Fsql.Add('GETPERSONAL (IDAUTORIZA) AUTORIZA, M.ANO,  DECODE( LENGTH(M.OBLEAINICIAL)  ,8, TO_CHAR(M.OBLEAINICIAL), ');
        Fsql.Add(' ''0''||TO_CHAR(M.OBLEAINICIAL)) AS OBLEAINICIAL,    DECODE( LENGTH(M.OBLEAFINAL)  ,8, TO_CHAR(M.OBLEAFINAL), ');
        Fsql.Add(' ''0''||TO_CHAR(M.OBLEAFINAL)) AS OBLEAFINAL  , to_char(M.FECHA,''dd/mm/yyyy'') fecha, to_char(fechsoli,''dd/mm/yyyy'') fechsoli, CANTCERTIF, CANTBOLSI, ');
        Fsql.Add('SUBSTR(GET_NOMBRE_PLANTA_ID(M.IDORIGEN),1,40) ORIGEN, GET_NROPLANTA_ID(M.IDORIGEN) PORIGEN, M.IDORIGEN PLORIGEN, ');
        FSQL.Add('CERTINICIAL, CERTFINAL ');
        Fsql.Add('FROM PLANTAS P, EMPRESAS E, VTV_MOVIMIENTO M ');
        Fsql.Add(format('WHERE IDMOVIMIENTO = %S ',[idMovimiento]));
        Fsql.add('AND M.IDDESTINO = P.IDPLANTA AND P.IDEMPRESA = E.IDEMPRESA AND M.TIPO = ''M''');

        CommandText:=fsql.text;
        open;
        if recordcount = 0 then
        begin
           Application.MessageBox('El Movimiento solicitado no existe en la base','Reimpresiones',mb_iconerror+mb_ok+mb_applmodal);
           exit;
        end;
        repMovObleasGNC.DataSet := qconsulta;
        dbtPrepara.DataSet := qconsulta;
        dbtAutoriza.DataSet := qconsulta;

        if idempresa = 0 then
          with tplantas.CreateById(mybd,qconsulta.fieldbyname('PLORIGEN').AsString) do
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
      qconsulta.Free;
      free;
    end;
end;

end.
