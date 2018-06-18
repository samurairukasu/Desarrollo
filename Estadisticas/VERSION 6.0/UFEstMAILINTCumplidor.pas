unit UFEstMAILINTCumplidor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uutils,
  QRCtrls, jpeg, QuickRpt,  Dialogs, ExtCtrls, sqlexpr, globals, uGetDates, UFPlanta,
  FMTBcd, DBClient, Provider, DB, QRExport,UFPorDigito;

type
  TfRepMAILINTCumplidor = class(TForm)
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
    qrlFecha: TQRLabel;
    QRExpr2: TQRExpr;
    procedure QRBDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

  Procedure GenerateMAILINTERNO;
  function  PutEstacion : string;

var
  fRepMAILINTCumplidor: TfRepMAILINTCumplidor;



implementation

{$R *.dfm}

var
 DateIni, DateFin,desde, hasta : string;


procedure DoProcedure;
begin
    with TSQLStoredProc.Create(application) do
    try
        Screen.Cursor := crHourglass;
        SQLConnection := BDChile;
        StoredProcName := 'CENTRALMAIL.CUMPLIDORES_MAIL_INTERNO' ;
       // BDChile.ExecuteDirect('alter session set nls_date_format = ''dd/mm/yyyy''');
        ParamByName('DIGITO').Value := desde;
        ParamByName('FECHAINI').Value := copy(dateini,1,10);
        ParamByName('FECHAFIN').Value := copy(datefin,1,10);
        ExecProc;
        Screen.Cursor := crDefault;
    finally
        free;
    end;

end;

Procedure GenerateMAILINTERNO;

begin
if   BDChile.Connected=false then
    begin
        showmessage('No hay una conexi�n activa a Chile. Por favor utilice la opci�n Conectar a Chile.');
        exit;
    end;
    
  If not GetDates(DateIni,DateFin) then Exit;

  PorDigito(desde);
   DoProcedure;

  with TfRepMAILINTCumplidor.Create(application) do
   try
     sdsConsulta.SQLConnection:= BDChile;
     with CDSConsulta do
     begin
       commandtext := 'select planta,enviados,cumplidores, (cumplidores*100/enviados) porc '+
                      'from TTMP_MAIL_CUMPLIDORE where enviados > 0' ;
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

procedure TfRepMAILINTCumplidor.QRBDetalleBeforePrint(Sender: TQRCustomBand;
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