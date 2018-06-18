unit UFEstadSMSCumplidor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uutils,
  QRCtrls, jpeg, QuickRpt,  Dialogs, ExtCtrls, sqlexpr, globals, uGetDates, UFPlanta,
  FMTBcd, DBClient, Provider, DB, QRExport;

type
  TfRepSMSCumplidor = class(TForm)
    repexceptionTiposDocu: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRBDetalle: TQRBand;
    QREComprob: TQRExpr;
    QRExpr8: TQRExpr;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    sdsConsulta: TSQLDataSet;
    dspConsulta: TDataSetProvider;
    cdsConsulta: TClientDataSet;
    QRRTFFilter1: TQRRTFFilter;
    QRExcelFilter1: TQRExcelFilter;
    QRTextFilter1: TQRTextFilter;
    QRExpr1: TQRExpr;
    qrlFecha: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRExpr2: TQRExpr;
    SummaryBand1: TQRBand;
    QRShape1: TQRShape;
    QRExpr3: TQRExpr;
    QRLabel6: TQRLabel;
    QRExpr4: TQRExpr;
    QRImage1: TQRImage;
    procedure QRBDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

  Procedure GenerateSMSCumplidor;
  function  PutEstacion : string;

var
  fRepSMSCumplidor: TfRepSMSCumplidor;



implementation

uses Unitespera;

{$R *.dfm}

var
 DateIni, DateFin : string;

  
procedure DoProcedure;
begin
    with TSQLStoredProc.Create(application) do
    try
        Screen.Cursor := crHourglass;
        SQLConnection := bdempex;
        StoredProcName := 'TURNOS_SMS.DO_CUMPLIMIENTO_SMS' ;
        bdempex.ExecuteDirect('alter session set nls_date_format = ''dd/mm/yyyy''');
        ParamByName('FECHAINI').Value := copy(dateini,1,10);
        ParamByName('FECHAFIN').Value := copy(datefin,1,10);
        ExecProc;
        Screen.Cursor := crDefault;
    finally
        free;
    end;

end;

Procedure GenerateSMSCumplidor;

begin
  If not GetDates(DateIni,DateFin) then Exit;
  
    espera.Show;
     application.ProcessMessages;
   DoProcedure;

  with TfRepSMSCumplidor.Create(application) do
   try


     sdsConsulta.SQLConnection:= bdempex;
     with CDSConsulta do
     begin
       commandtext := 'select zona,planta,enviados,vinieron '+
                      'from TTMP_SMS_CUMPLIDORES   ' +
                      'ORDER BY to_number(zona)';
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




procedure TfRepSMSCumplidor.QRBDetalleBeforePrint(Sender: TQRCustomBand;
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
