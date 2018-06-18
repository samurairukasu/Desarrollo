unit ufInformeRevesExternasToPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uutils,
  QRCtrls, jpeg, QuickRpt,  Dialogs, ExtCtrls, sqlexpr, globals, uGetDates,
  QRExport;

type
  TFrmInformeRevesExternasToPrint = class(TForm)
    repRevesExternas: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRBDetalle: TQRBand;
    QRLabel2: TQRLabel;
    qrlComprob: TQRLabel;
    qrlcant: TQRLabel;
    QREComprob: TQRExpr;
    qrecant: TQRExpr;
    qrlFecha: TQRLabel;
    QRExpr8: TQRExpr;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    qrltipodoc: TQRLabel;
    QREtipoDocu: TQRExpr;
    QRLEmpresa: TQRLabel;
    QRRTFFilter1: TQRRTFFilter;
    QRExcelFilter1: TQRExcelFilter;
    QRTextFilter1: TQRTextFilter;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRExpr5: TQRExpr;
    QRLabel7: TQRLabel;
    QRExpr6: TQRExpr;
    QRLabel8: TQRLabel;
    QRExpr7: TQRExpr;
    QRLabel9: TQRLabel;
    procedure QRBDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

  Procedure DoRevesExternas;
var
  FrmInformeRevesExternasToPrint: TFrmInformeRevesExternasToPrint;

implementation

uses
    USAGESTACION;
{$R *.dfm}

Procedure DoRevesExternas;
var
aConsulta: tsqlQuery;
DateIni, DateFin : string;
begin
  If not GetDates(DateIni,DateFin) then Exit;
  aConsulta:= nil;
  with TFrmInformeRevesExternasToPrint.Create(application) do
   try
     Screen.Cursor:=crHourGlass;
     aconsulta := TsqlQuery.Create(nil);
     with aConsulta do
     begin
       SQLConnection:= MyBD;
       SQL.Add('SELECT EX.ZONA,EX.PLANTA,TO_CHAR(EX.FECHAVERI,''DD/MM/YYYY'')FECHAVERI,EX.NRO_INSP_ANT,V.PATENTEN,TO_CHAR(EX.FECVENCI,''DD/MM/YYYY'')FECHAVENCI,EX.EJERCICI,EX.RESULTAD,EX.NUMOBLEA,  ');
       SQL.Add('LTRIM(TO_CHAR(MOD(I.EJERCICI,100),''00'')) || '' '' ||  LTRIM(TO_CHAR('''+ InttoStr(fVarios.Zona) +''',''00'')) || LTRIM(TO_CHAR('''+InttoStr(fVarios.CodeEstacion)+''',''00'')) || LTRIM(TO_CHAR(EX.CODINSPE,''000000'')) INFORME, I.RESULTAD as RESULT2 , TO_CHAR(EX.FECHALTA,''DD/MM/YYYY'')FECHALTA ');
       SQL.Add('FROM TINSPECCIONEXTERNA EX,TVEHICULOS V, TINSPECCION I ');
       SQL.Add('WHERE  EX.CODVEHIC=V.CODVEHIC AND EX.CODINSPE=I.CODINSPE AND  ');
       SQL.Add(format('EX.FECHALTA BETWEEN TO_DATE(''%S'',''dd/mm/yyyy hh24:mi:ss'') AND TO_DATE(''%S'',''dd/mm/yyyy hh24:mi:ss'') ',[dateini,datefin]));
       SQL.Add('ORDER BY EX.FECHALTA ');
       open;
       reprevesExternas.DataSet := aConsulta;
       qrlEmpresa.Caption := 'Planta: '+fVarios.NombreEstacion;
       qrlFecha.Caption := 'Desde: '+copy(DateIni,1,10)+' - Hasta: '+copy(DateFin,1,10);
       Screen.Cursor:=crDefault;
       repRevesExternas.preview;
     end;
   finally
     Screen.Cursor:=crDefault;
     aConsulta.Free;
     free;
   end;

end;

procedure TFrmInformeRevesExternasToPrint.QRBDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if reprevesExternas.RecordNumber mod 2 <> 0 then
    QRBDetalle.color := clWhite
  else
    QRBDetalle.color := $00EBEBEB
end;



end.
