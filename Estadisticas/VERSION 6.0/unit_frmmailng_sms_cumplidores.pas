unit unit_frmmailng_sms_cumplidores;

interface

uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uutils,
  QRCtrls, jpeg, QuickRpt,  Dialogs, ExtCtrls, sqlexpr, globals, uGetDates, UFPlanta,
  FMTBcd, DBClient, Provider, DB, QRExport;

type
  Tfrmmailing_sms_cumplidores = class(TForm)
    repexceptionTiposDocu: TQuickRep;
    QRBand1: TQRBand;
    qrlFecha: TQRLabel;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    qrlComprob: TQRLabel;
    QRLabel2: TQRLabel;
    QRBDetalle: TQRBand;
    QREComprob: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    SummaryBand1: TQRBand;
    QRShape1: TQRShape;
    QRExpr4: TQRExpr;
    QRExpr3: TQRExpr;
    QRLabel6: TQRLabel;
    sdsConsulta: TSQLDataSet;
    dspConsulta: TDataSetProvider;
    cdsConsulta: TClientDataSet;
    QRRTFFilter1: TQRRTFFilter;
    QRExcelFilter1: TQRExcelFilter;
    QRTextFilter1: TQRTextFilter;
    QRLabel5: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel7: TQRLabel;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRLabel4: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
   Procedure GenerateLismailing_Sms_cumpli;
var
  frmmailing_sms_cumplidores: Tfrmmailing_sms_cumplidores;

implementation

uses Unitespera;

{$R *.dfm}
var
 INI,FIN, DateIni, DateFin : string;

 procedure DoProcedure;
begin
    with TSQLStoredProc.Create(application) do
    try
        Screen.Cursor := crHourglass;
        SQLConnection := bdempex;
        StoredProcName := 'TURNOS_SMS.Do_Mailing_Cumpl' ;
        bdempex.ExecuteDirect('alter session set nls_date_format = ''dd/mm/yyyy''');
        ParamByName('FECHAINI').Value := copy(dateini,1,10);
        ParamByName('FECHAFIN').Value := copy(datefin,1,10);
        ExecProc;
        Screen.Cursor := crDefault;
    finally
        free;
    end;

end;

Procedure GenerateLismailing_Sms_cumpli;

begin
  If not GetDates(DateIni,DateFin) then Exit;


    espera.show;
    application.ProcessMessages;

   doprocedure;


  with Tfrmmailing_sms_cumplidores.Create(application) do
   try

     sdsConsulta.SQLConnection:= bdempex;
     with CDSConsulta do
     begin
       commandtext := 'select zona, planta, envsms, vinsms, envmail, vinmail,enviados from  TTMP_MAILSMS_CUMPLIDOR '  ;
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
           espera.close;
           ShowMessage('No existen resultados para esta consulta!');
           end;
         end;
     end;
   finally
     free;
   end;

end;

end.
