unit UFEstadTIPO3Cumplidores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uutils,
  QRCtrls, jpeg, QuickRpt,  Dialogs, ExtCtrls, sqlexpr, globals, uGetDates, UFPlanta,
  FMTBcd, DBClient, Provider, DB, QRExport;

type
  TfRepTIPO3Cump = class(TForm)
    repexceptionTiposDocu: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRBDetalle: TQRBand;
    qrlComprob: TQRLabel;
    QREComprob: TQRExpr;
    qrlFecha: TQRLabel;
    QRExpr8: TQRExpr;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    sdsConsulta: TSQLDataSet;
    dspConsulta: TDataSetProvider;
    cdsConsulta: TClientDataSet;
    QRRTFFilter1: TQRRTFFilter;
    QRExcelFilter1: TQRExcelFilter;
    QRTextFilter1: TQRTextFilter;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRImage1: TQRImage;
    SummaryBand1: TQRBand;
    QRShape1: TQRShape;
    QRExpr4: TQRExpr;
    QRExpr3: TQRExpr;
    QRLabel6: TQRLabel;
    procedure QRBDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

  Procedure GenerateLisTipo3;
  function  PutEstacion : string;
  Procedure   GenerateLisTipo1;
  Procedure   GenerateLisTipo4;
var
  fRepTIPO3Cump: TfRepTIPO3Cump;



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
        StoredProcName := 'TURNOS_SMS.CUMPLIDORES_TIPO3' ;
        bdempex.ExecuteDirect('alter session set nls_date_format = ''dd/mm/yyyy''');
        ParamByName('FECHAINI').Value := copy(dateini,1,10);
        ParamByName('FECHAFIN').Value := copy(datefin,1,10);
        ExecProc;
        Screen.Cursor := crDefault;
    finally
        free;
    end;

end;

Procedure GenerateLisTipo3;

begin
  If not GetDates(DateIni,DateFin) then Exit;


    espera.show;
    application.ProcessMessages;

   doprocedure;


  with TfReptipo3Cump.Create(application) do
   try

     sdsConsulta.SQLConnection:= bdempex;
     with CDSConsulta do
     begin
       commandtext := 'select planta, enviados, cumplidores, round((cumplidores*100)/enviados,2)  porc from  TTMP_0KMCUMPLIDOR where enviados > 0'  ;
         Begin
          open;
          if RecordCount > 0 then
          Begin
          espera.close;
            qrlFecha.Caption := 'Desde: '+copy(DateIni,1,10)+' - Hasta: '+copy(DateFin,1,10);
            qrlabel1.Caption:='An�lisis - Cumplidores T3 a VENCER';
            repexceptionTiposDocu.Prepare;
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



procedure DoProcedure1;
begin
    with TSQLStoredProc.Create(application) do
    try
        Screen.Cursor := crHourglass;
        SQLConnection := bdempex;
        StoredProcName := 'TURNOS_SMS.CUMPLIDORES_TIPO1' ;
        bdempex.ExecuteDirect('alter session set nls_date_format = ''dd/mm/yyyy''');
        ParamByName('FECHAALTA').Value := copy(dateini,1,10);
       // ParamByName('FECHAFIN').Value := copy(datefin,1,10);
        ExecProc;
        Screen.Cursor := crDefault;
    finally
        free;
    end;

end;

Procedure GenerateLisTipo1;

begin
  If not GetDates(DateIni,DateFin) then Exit;


    espera.show;
    application.ProcessMessages;

   doprocedure1;


  with TfReptipo3Cump.Create(application) do
   try

     sdsConsulta.SQLConnection:= bdempex;
     with CDSConsulta do
     begin
       commandtext := 'select planta, enviados, cumplidores, round((cumplidores*100)/enviados,2)  porc from  TTMP_0KMCUMPLIDOR where enviados > 0'  ;
         Begin
          open;
          if RecordCount > 0 then
          Begin
          espera.close;
            qrlFecha.Caption := 'Mes de envio mailing: '+copy(DateIni,1,10);

               qrlabel1.Caption:='An�lisis - Cumplidores T1 VENCIDOS';
            repexceptionTiposDocu.Prepare;
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



procedure DoProcedure4;
begin
    with TSQLStoredProc.Create(application) do
    try
        Screen.Cursor := crHourglass;
        SQLConnection := bdempex;
        StoredProcName := 'TURNOS_SMS.CUMPLIDORES_TIPO4' ;
        bdempex.ExecuteDirect('alter session set nls_date_format = ''dd/mm/yyyy''');
        ParamByName('FECHAALTA').Value := copy(dateini,1,10);
       // ParamByName('FECHAFIN').Value := copy(datefin,1,10);
        ExecProc;
        Screen.Cursor := crDefault;
    finally
        free;
    end;

end;

Procedure GenerateLisTipo4;

begin
  If not GetDates(DateIni,DateFin) then Exit;


    espera.show;
    application.ProcessMessages;

   doprocedure4;


  with TfReptipo3Cump.Create(application) do
   try

     sdsConsulta.SQLConnection:= bdempex;
     with CDSConsulta do
     begin
       commandtext := 'select planta, enviados, cumplidores, round((cumplidores*100)/enviados,2)  porc from  TTMP_0KMCUMPLIDOR where enviados > 0'  ;
         Begin
          open;
          if RecordCount > 0 then
          Begin
          espera.close;
           qrlFecha.Caption := 'Mes de envio mailing: '+copy(DateIni,1,10);
              qrlabel1.Caption:='An�lisis - Cumplidores T4 VENCIDOS';
            repexceptionTiposDocu.Prepare;
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



procedure TfRepTIPO3Cump.QRBDetalleBeforePrint(Sender: TQRCustomBand;
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
