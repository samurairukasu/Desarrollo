unit UFEstadSMS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uutils,
  QRCtrls, jpeg, QuickRpt,  Dialogs, ExtCtrls, sqlexpr, globals, uGetDates, UFPlanta,
  FMTBcd, DBClient, Provider, DB, QRExport;

type
  TfRepSMS = class(TForm)
    repexceptionTiposDocu: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRBDetalle: TQRBand;
    QRLabel2: TQRLabel;
    qrlComprob: TQRLabel;
    QREComprob: TQRExpr;
    QRExpr8: TQRExpr;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    qrltipodoc: TQRLabel;
    sdsConsulta: TSQLDataSet;
    dspConsulta: TDataSetProvider;
    cdsConsulta: TClientDataSet;
    QRRTFFilter1: TQRRTFFilter;
    QRExcelFilter1: TQRExcelFilter;
    QRTextFilter1: TQRTextFilter;
    QRExpr1: TQRExpr;
    SummaryBand1: TQRBand;
    QRExpr2: TQRExpr;
    QRShape1: TQRShape;
    QRLabel3: TQRLabel;
    QRImage1: TQRImage;
    procedure QRBDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

  Procedure GenerateSMS;
  function  PutEstacion : string;

var
  fRepSMS: TfRepSMS;



implementation

uses Unitespera;

{$R *.dfm}

var
 INI,FIN, DateIni, DateFin : string;



Procedure GenerateSMS;

begin
  If not GetDates(DateIni,DateFin) then Exit;

  espera.Show;
  APPLICATION.ProcessMessages;
  with TfRepSMS.Create(application) do
   try
     sdsConsulta.SQLConnection:= bdempex;
     with CDSConsulta do
     begin
       commandtext := ' SELECT SUBSTR(nombre,4,10) AS FECHA, DOMINIO AS PLANTA,COUNT(*) SMS FROM central.envio_sms_enviados '+
                      ' WHERE TO_DATE(nombre,''DD-MON-YY'')  BETWEEN TO_DATE ('''+COPY(dateini,1,10)+''',''dd/mm/yyyy'')  AND TO_DATE ('''+COPY(datefin,1,10)+''',''dd/mm/yyyy'') '+
                      ' GROUP BY SUBSTR(nombre,4,10), DOMINIO   '+
                      ' ORDER BY PLANTA ,FECHA ';
         Begin
          open;
          if RecordCount > 0 then
          Begin
            ESPERA.Close;
         //   qrlFecha.Caption := 'Desde: '+copy(DateIni,1,10)+' - Hasta: '+copy(DateFin,1,10);
            repexceptionTiposDocu.preview;
          end
          else
            BEGIN
              ESPERA.Close;
               ShowMessage('No existen resultados para esta consulta!');
             END;

         end;
     end;
   finally
     free;
   end;

end;

procedure TfRepSMS.QRBDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if repexceptionTiposDocu.RecordNumber mod 2 <> 0 then
    QRBDetalle.color := clWhite
  else
    QRBDetalle.color := $00EBEBEB
end;

function PutEstacion : string;
begin
    with TSQLQuery.Create(application) do
    try
        SQLConnection := mybd;
        SQL.Clear;
        SQL.Add('select NOMBRE_FANTASIA_PLANTA  from plantas');
        {$IFDEF TRAZAS}
             FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLIQDIARIATOTFPAGO);
        {$ENDIF}
         Open;
         Result := fields[0].asstring;
    finally
         free;
    end;
end;

end.