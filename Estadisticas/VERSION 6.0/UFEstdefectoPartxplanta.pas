unit UFEstdefectoPartxplanta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uutils,
  QRCtrls, jpeg, QuickRpt,  Dialogs, ExtCtrls, sqlexpr, globals, uGetDates, UFPlanta,
  FMTBcd, DBClient, Provider, DB, QRExport;

type
  TfRepdefPartxPlanta = class(TForm)
    repexceptionTiposDocu: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRBDetalle: TQRBand;
    qrlComprob: TQRLabel;
    qrlcant: TQRLabel;
    QREComprob: TQRExpr;
    qrlFecha: TQRLabel;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    sdsConsulta: TSQLDataSet;
    dspConsulta: TDataSetProvider;
    cdsConsulta: TClientDataSet;
    QRRTFFilter1: TQRRTFFilter;
    QRExcelFilter1: TQRExcelFilter;
    QRTextFilter1: TQRTextFilter;
    QRExpr1: TQRExpr;
    QRExpr3: TQRExpr;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRExpr4: TQRExpr;
    QRExpr2: TQRExpr;
    procedure QRBDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

  Procedure GenerateDefecPartic;
  procedure DoDefectosPartic;
  function  PutEstacion : string;

var
  fRepdefPartxPlanta: TfRepdefPartxPlanta;



implementation

{$R *.dfm}

var
  DateIni, DateFin ,Idplanta,Nombre: string;


procedure DoDefectosPartic;
begin

    with TSQLStoredProc.Create(application) do
    try
        Screen.Cursor := crHourglass;
        SQLConnection := mybd;
        StoredProcName := 'Pq_Estadisticas.Doestaddefectos' ;
        bdempex.ExecuteDirect('alter session set nls_date_format = ''dd/mm/yyyy hh24:mi:ss''');
        ParamByName('FI').Value := copy(dateini,1,2)+ copy(dateini,4,2)+copy(dateini,7,4);
        ParamByName('FF').Value := copy(datefin,1,2)+ copy(datefin,4,2)+copy(datefin,7,4);
        ExecProc;
        Screen.Cursor := crDefault;
    finally
        free;
    end;

end;

Procedure GenerateDefecPartic;

begin
  If not GetDates(DateIni,DateFin) then Exit;
   DoDefectosPartic;

  with TfRepdefPartxPlanta.Create(application) do
   try
     sdsConsulta.SQLConnection:= mybd;
     with CDSConsulta do
     begin
       commandtext := 'select defecto,calif0,calif1,calif2,calif3 '+
                      'from TTMPESTADDEFECTOS order by defecto ';
         Begin
          open;
          if RecordCount > 0 then
          Begin
            QRLabel1.caption :='Defectos - Planta:' + PutEstacion ;
            qrlFecha.Caption := 'Desde: '+copy(DateIni,1,10)+' - Hasta: '+copy(DateFin,1,10);
            repexceptionTiposDocu.preview;
          end
          else
           ShowMessage('No existen resultados para esta consulta!');
         end;
     end;
   finally
     free;
   end;

end;

procedure TfRepdefPartxPlanta.QRBDetalleBeforePrint(Sender: TQRCustomBand;
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
        SQL.Add('select IDENCONC from TVARIOS');
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
