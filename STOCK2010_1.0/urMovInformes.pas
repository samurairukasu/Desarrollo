unit urMovInformes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, jpeg, DB, SqlExpr, globals, RxGIF, uStockClasses,
  uStockEstacion, FMTBcd, DBClient, Provider;

type
  TFrepMovInformes = class(TForm)
    repMovInformes: TQuickRep;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    qriapplus: TQRImage;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
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
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    dbtPrepara: TQRDBText;
    dbtAutoriza: TQRDBText;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRLabel17: TQRLabel;
    QRLabel19: TQRLabel;
    QRShape14: TQRShape;
    QRLabel22: TQRLabel;
    QRExpr14: TQRExpr;
    QRLabel4: TQRLabel;
    QRExpr10: TQRExpr;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRId: TQRLabel;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    sdsQMovimiento: TSQLDataSet;
    dspQMovimiento: TDataSetProvider;
    QMovimiento: TClientDataSet;
  private
    { Private declarations }

  public
    { Public declarations }
  end;
  procedure DoRepMovInformes(idMovimiento: string; idempresa: integer);

var
  FrepMovInformes: TFrepMovInformes;

implementation

{$R *.dfm}

procedure DoRepMovInformes(idMovimiento: string; idempresa: integer);
var
Num: String;
fsql: tStringList;
begin
  with tfrepMovInformes.Create(application) do
   try
     fSQL := TStringList.Create;
      with QMovimiento do
      begin
        sdsQMovimiento.SqlConnection:= MyBD;
        fsql.Add('SELECT M.IDMOVIMIENTO, P.NOMBRE PLANTA,  GET_NROPLANTA_ID(M.IDDESTINO) PDESTINO, E.DESCRIPCION EMPRESA, M.CANTIDAD, GETPERSONAL(IDPREPARA) PREPARA, ');
        fsql.Add('GETPERSONAL (IDAUTORIZA) AUTORIZA,  M.INFORMEINICIAL, M.INFORMEFINAL, TO_CHAR(M.FECHA,''DD/MM/YYYY'')AS FECHA, TO_CHAR(FECHSOLI,''DD/MM/YYYY'')AS FECHSOLI , ');
        fsql.Add('SUBSTR(GET_NOMBRE_PLANTA_ID(M.IDORIGEN),1,40) ORIGEN, GET_NROPLANTA_ID(M.IDORIGEN) PORIGEN, M.IDORIGEN PLORIGEN ');
        fsql.Add('FROM PLANTAS P, EMPRESAS E, MOV_INFORME M ');
        fsql.Add(format('WHERE IDMOVIMIENTO = %S ',[idMovimiento]));
        fsql.add('AND M.IDDESTINO = P.IDPLANTA AND P.IDEMPRESA = E.IDEMPRESA ');       //AND M.TIPO = ''M''
        CommandText:=fsql.text;
        open;
        if recordcount = 0 then
        begin
           Application.MessageBox('El Movimiento solicitado no existe en la base','Reimpresiones',mb_iconerror+mb_ok+mb_applmodal);
           exit;
        end;
        repMovInformes.DataSet := QMovimiento;
        dbtPrepara.DataSet := QMovimiento;
        dbtAutoriza.DataSet := QMovimiento;

        Num:=QMovimiento.Fields[0].Value;
        QRId.Caption:='N° '+Num;

      { if idempresa = 0 then
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
        //  qrivtv.picture := nil;
        end; }
      end;
      Screen.Cursor:=crDefault;
      repMovInformes.preview;
    finally
      QMovimiento.Free;
      free;
      Screen.Cursor:=crDefault;
    end;
end;

end.
