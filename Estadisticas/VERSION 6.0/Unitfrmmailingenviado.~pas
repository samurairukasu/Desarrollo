unit Unitfrmmailingenviado;

interface

uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uutils,
  QRCtrls, jpeg, QuickRpt,  Dialogs, ExtCtrls, sqlexpr, globals, uGetDates, UFPlanta,
  FMTBcd, DBClient, Provider, DB, QRExport;

type
  Tfrmmailingenviado = class(TForm)
    QRExcelFilter1: TQRExcelFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRTextFilter1: TQRTextFilter;
    sdsConsulta: TSQLDataSet;
    dspConsulta: TDataSetProvider;
    repexceptionTiposDocu: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    qrlFecha: TQRLabel;
    QRImage1: TQRImage;
    QRBand2: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRBDetalle: TQRBand;
    QREComprob: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    SummaryBand1: TQRBand;
    QRShape1: TQRShape;
    QRExpr3: TQRExpr;
    QRLabel6: TQRLabel;
    QRExpr4: TQRExpr;
    cdsConsulta: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
   Procedure GenerateMAILINGENVIADO;
var
  frmmailingenviado: Tfrmmailingenviado;

implementation

uses Unitespera;

{$R *.dfm}
VAR
  DateIni, DateFin : string;
Procedure GenerateMAILINGENVIADO;

begin
  If not GetDates(DateIni,DateFin) then Exit;
  
    espera.Show;
     application.ProcessMessages;


  with Tfrmmailingenviado.Create(application) do
   try
   DATEINI:=COPY(DATEINI,1,10);
    DATEFIN:=COPY(DATEFIN,1,10);

     sdsConsulta.SQLConnection:= bdempex;
     with CDSConsulta do
     begin
       commandtext := 'SELECT TIPO,ZONA, TO_CHAR(FECHA_ALTA,''MM/YYYY'') AS FECHA, COUNT(*) AS CANTI FROM TIPOZONAHISTORIAL    '+
                       ' WHERE  FECHA_ALTA BETWEEN TO_DATE('+#39+TRIM(DATEINI)+#39+',''DD/MM/YYYY'') AND  TO_DATE('+#39+TRIM(DATEFIN)+#39+',''DD/MM/YYYY'')  '  +
                     ' GROUP BY TIPO,ZONA, TO_CHAR(FECHA_ALTA,''MM/YYYY'') ';
         Begin
          open;
          if RecordCount > 0 then
          Begin
            espera.close;
            qrlFecha.Caption := 'Desde: '+copy(DateIni,1,10)+' - Hasta: '+copy(DateFin,1,10);
            repexceptionTiposDocu.preview;
          end
          else
          begin
           espera.Show;
           ShowMessage('No existen resultados para esta consulta!');
           end;
         end;
     end;
   finally
     free;
   end;

end;



end.
