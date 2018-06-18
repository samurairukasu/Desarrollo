unit ufContMedicIncompletas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  QuickRpt, Qrctrls, ExtCtrls, Db, globals, FMTBcd, Provider,
  DBClient, SqlExpr;

type
  TfmControlMedIncompletas = class(TForm)
    quickrep1: TQuickRep;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRLabel1: TQRLabel;
    QRBand3: TQRBand;
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
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRDBText2: TQRDBText;
    QRDBText11: TQRDBText;
    QRLabel12: TQRLabel;
    QRDBText12: TQRDBText;
    QRLabel13: TQRLabel;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    sdsquery1: TSQLDataSet;
    query1: TClientDataSet;
    dspquery1: TDataSetProvider;
    QRLabel14: TQRLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  procedure DoControlMedicionesIncompletas;



var
  fmControlMedIncompletas: TfmControlMedIncompletas;
  dateini,datefin:string;

implementation

{$R *.DFM}

uses
  ugetdates;

procedure DoControlMedicionesIncompletas;
var
  fSQL : TStringList;
begin
  with TfmControlMedIncompletas.Create(Application) do
    try
      if not getdates(dateini,datefin) then exit;
      Query1.Close;
      fsql := TStringList.Create;
      fsql.Add('select to_char(i.fechalta,''dd/mm/yyyy'') fecha,i.codinspe,decode(I.tipo,''E'',''R'',''I'',''R'','''') tipo,');
      fsql.add('nvl(v.patenten,v.patentea) patente,LTrim(m.effresta) effresta,LTrim(m.effrserv) effrserv,m.dese1eje,m.dese2eje, m.desl1eje, ');
      fsql.add('decode(v.tipogas,''N'',''Nafta'',''L'',''Gasoil'',''G'',''Gas'',''Otros'') combustible,m.porceco2, ');
      fsql.add('m.valorkme,m.NUMLINZ1||''- ''||m.NUMLINZ2||''- ''||m.NUMLINZ3 linea,nvl(m.NUMREVZ1,''**'')');
      fsql.add('||''-''||nvl(m.NUMREVZ2,''**'')||''-''||nvl(m.NUMREVZ3,''**'') inspector ');
      fsql.add('from tinspeccion i, tvehiculos v, tdatinspecc m, tfacturas f ');
      fsql.add('where i.tipo = ''A'' and i.codinspe=m.codinspe and i.ejercici=m.ejercici and i.codfactu=f.codfactu ');
      fsql.add('and i.codvehic=v.codvehic and i.fechalta between :fechaini and :fechafin and i.inspfina=''S'' ');
      fsql.add(' and f.codcofac is null and ((EFFRSERV IS null) or (EFFRESTA IS null)');
      fsql.add('or (DESE1EJE IS null) or (DESE2EJE IS null) or (DESL1EJE IS null) or ');
      fsql.add('(TipoGas = ''N'' AND ((PORCECO2 IS NULL) OR (VALORKME IS NOT NULL))) or (TipoGas = ''L''');
      fsql.Add(' AND ((VALORKME IS NULL) OR (PORCECO2 IS NOT NULL))) or (TipoGas IN (''G'',''M'') AND ');
      fsql.add('((VALORKME IS NOT NULL) OR (PORCECO2 IS NOT NULL)))) order by i.fechalta');
      query1.CommandText := fSQL.text;
      query1.params.ParamByName('fechaini').value:=strtodatetime(dateini);
      query1.params.ParamByName('fechafin').value:=strtodatetime(datefin);
      Query1.Open;
      QuickRep1.Preview;
    finally
      Free;
    end;
end;

procedure TfmControlMedIncompletas.FormCreate(Sender: TObject);
begin
  sdsQuery1.SQLConnection:=mybd;
end;

end.
