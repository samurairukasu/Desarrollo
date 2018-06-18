unit UFEstadTurnoCaptacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uutils,
  QRCtrls, jpeg, QuickRpt,  Dialogs, ExtCtrls, sqlexpr, globals, uGetDates, UFPlanta,
  FMTBcd, DBClient, Provider, DB, QRExport;

type
  TfRepTurnoCaptacion = class(TForm)
    repexceptionTiposDocu: TQuickRep;
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
    sdsConsulta: TSQLDataSet;
    dspConsulta: TDataSetProvider;
    cdsConsulta: TClientDataSet;
    QRRTFFilter1: TQRRTFFilter;
    QRExcelFilter1: TQRExcelFilter;
    QRTextFilter1: TQRTextFilter;
    QRLabel3: TQRLabel;
    QRExpr2: TQRExpr;
    QRExpr1: TQRExpr;
    procedure QRBDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

  Procedure GenerateLisTurnoCaptacion;
  procedure DoProcedure;
  function  PutEstacion : string;

var
  fRepTurnoCaptacion: TfRepTurnoCaptacion;



implementation

{$R *.dfm}

var
  DateIni, DateFin ,Idplanta,Nombre: string;

procedure DoProcedure;
begin
    with TSQLStoredProc.Create(application) do
    try
        Screen.Cursor := crHourglass;
        SQLConnection := bdempex;
        StoredProcName := 'TURNOS_SMS.DOCAPTACION' ;
        bdempex.ExecuteDirect('alter session set nls_date_format = ''dd/mm/yyyy''');
        ParamByName('FI').Value := copy(dateini,1,10);
        ParamByName('FF').Value := copy(datefin,1,10);
        ExecProc;
        Screen.Cursor := crDefault;
    finally
        free;
    end;

end;


Procedure GenerateLisTurnoCaptacion;

begin
  If not GetDates(DateIni,DateFin) then Exit;

  DoProcedure;

  with TfRepTurnoCaptacion.Create(application) do
   try
     sdsConsulta.SQLConnection:= bdempex;
     with CDSConsulta do
     begin
       commandtext := 'select zona,cantidad, captacion,vienen, (captacion+vienen) as total '+
                      'from ttmp_turnos   ' +
                      'ORDER BY to_number(zona)';
         Begin
          open;
          if RecordCount > 0 then
          Begin
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

procedure TfRepTurnoCaptacion.QRBDetalleBeforePrint(Sender: TQRCustomBand;
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
