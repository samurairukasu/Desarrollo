unit urListEntObleasGNC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, SqlExpr, globals, FMTBcd,
  Provider, DBClient, DB;

type
  TfRepListEntObleasGNC = class(TForm)
    repEntObleasGNC: TQuickRep;
    QRBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRBDetalle: TQRBand;
    qrlPlanta: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    qrlComprob: TQRLabel;
    qrlTaller: TQRLabel;
    qrlcant: TQRLabel;
    qrlAno: TQRLabel;
    qrlini: TQRLabel;
    qrlfin: TQRLabel;
    QRExpr1: TQRExpr;
    QREComprob: TQRExpr;
    qretaller: TQRExpr;
    qrecant: TQRExpr;
    qreano: TQRExpr;
    qreini: TQRExpr;
    qrefin: TQRExpr;
    qrlFecha: TQRLabel;
    QRExpr8: TQRExpr;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRLabel4: TQRLabel;
    QRExpr2: TQRExpr;
    qconsulta: TClientDataSet;
    dspconsulta: TDataSetProvider;
    sdsconsulta: TSQLDataSet;
    ClientDataSet1: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    SQLDataSet1: TSQLDataSet;
    procedure QRBDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  Procedure DoLisEntObleasGNCGlobal(fi,ff: string);
  procedure DoLisEntObleasGNCxPlanta(fi,ff,aPlanta: string);

var
  fRepListEntObleasGNC: TfRepListEntObleasGNC;

implementation

{$R *.dfm}

Procedure DoLisEntObleasGNCGlobal(fi,ff: string);
var   SQL: TStringList;
begin
 SQL:=TStringList.Create ;
  with TfRepListEntObleasGNC.Create(application) do
   try
     with qConsulta do
     begin
       sdsconsulta.SQLConnection := MyBD;
       //CommandText:= 'SELECT  TO_CHAR(FECHA,''DD/MM/YYYY'') AS FECHA, PROVEEDOR,COMPROBANTE,EMPRESA,CANTIDAD,ANIO,OBLEAINIC,OBLEAFIN,ZONA  FROM TTMP_ENTRADAS ORDER BY FECHA';
       SQL.Add('SELECT e.anio,e.cantidad,e.comprobante,e.empresa, TO_CHAR(E.FECHA,''DD/MM/YYYY'') AS FECHA,e.proveedor,e.zona, ');
       SQL.Add(' DECODE( LENGTH(e.obleainic)  ,8, TO_CHAR(e.OBLEAINIC),');
       SQL.Add(' ''0''||TO_CHAR(e.OBLEAINIC)) AS OBLEAINIC,    DECODE( LENGTH(e.OBLEAFIN)  ,8, TO_CHAR(e.OBLEAFIN),  ');
       SQL.Add(' ''0''||TO_CHAR(e.OBLEAFIN)) AS OBLEAFIN    FROM TTMP_ENTRADAS  e ORDER BY e.FECHA ');
       CommandText:=   SQL.Text;
       open;
     end;
     repEntObleasGNC.DataSet := qConsulta;
     qrlFecha.Caption := 'Desde: '+copy(fi,1,10)+' - Hasta: '+copy(ff,1,10);
     repEntObleasGNC.preview;
   finally
     qConsulta.Free;
     free;
   end;
end;

procedure DoLisEntObleasGNCxPlanta(fi,ff,aPlanta: string);
begin
  with TfRepListEntObleasGNC.Create(application) do
   try
     with qConsulta do
     begin
       sdsconsulta.SQLConnection := MyBD;
       CommandText:='SELECT  TO_CHAR(FECHA,''DD/MM/YYYY'') AS FECHA, PROVEEDOR,COMPROBANTE,EMPRESA,CANTIDAD,ANIO,OBLEAINIC,OBLEAFIN,ZONA  FROM TTMP_ENTRADAS ORDER BY FECHA';
       open;
     end;
     repEntObleasGNC.DataSet := qConsulta;
     qrlPlanta.Caption := 'Empresa: '+aPlanta;
     qrlFecha.Caption := 'Desde: '+copy(fi,1,10)+' - Hasta: '+copy(ff,1,10);
     qrlTaller.Enabled := false;
     QRETaller.Enabled := false;
     QRlComprob.Left := QRlComprob.Left + 40;
     qrlcant.Left := qrlcant.Left - 130;
     qrlAno.Left := qrlAno.Left -100;
     qrlini.Left := qrlini.Left - 70;
     qrlfin.Left :=  qrlfin.Left - 40;
     QREComprob.Left := QREComprob.Left + 40;
     qrecant.Left := qrecant.Left - 130;
     qreAno.Left := qreAno.Left -100;
     qreini.Left := qreini.Left - 70;
     qrefin.Left :=  qrefin.Left - 40;

     repEntObleasGNC.preview;
   finally
     qConsulta.Free;
     free;
   end;
end;

procedure TfRepListEntObleasGNC.QRBDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if repEntObleasGNC.RecordNumber mod 2 <> 0 then
    QRBDetalle.color := clWhite
  else
    QRBDetalle.color := $00EBEBEB
end;

end.
