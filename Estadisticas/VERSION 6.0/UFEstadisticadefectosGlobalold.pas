unit UFEstadisticadefectosGlobalold;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uutils,
  QRCtrls, jpeg, QuickRpt,  Dialogs, ExtCtrls, sqlexpr, globals, uGetDates,
  FMTBcd, DBClient, Provider, DB, QRExport;

type
  TfRepdefectosGlobal = class(TForm)
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
    QRGroup1: TQRGroup;
    QREtipoDocu: TQRExpr;
    procedure QRBDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

  Procedure GenerateLisDefectos;
  procedure DoLisdefectos;
  function  PutEstacion : string;
var
  fRepdefectosGlobal: TfRepdefectosGlobal;



implementation

{$R *.dfm}

var
  DateIni, DateFin : string;

procedure DoLisdefectos;
begin
    DeleteTable(bdempex, 'ttmp7_ervtv');
    with TSQLStoredProc.Create(application) do
    try
        Screen.Cursor := crHourglass;
        SQLConnection := bdempex;
        StoredProcName := 'informedefectos_ERVTV.carga_ttmp_ervtv' ;
        bdempex.ExecuteDirect('alter session set nls_date_format = ''dd/mm/yyyy hh24:mi:ss''');
        ParamByName('FI').Value := copy(dateini,1,2)+ copy(dateini,4,2)+copy(dateini,7,4);
        ParamByName('FF').Value := copy(datefin,1,2)+ copy(datefin,4,2)+copy(datefin,7,4);
        ExecProc;
        Screen.Cursor := crDefault;
    finally
        free;
    end;

end;

Procedure GenerateLisDefectos;
var
Parametro: string;
begin
  If not GetDates(DateIni,DateFin) then Exit;
  //DoLisdefectos;
  with TfRepdefectosGlobal.Create(application) do
   try
     sdsConsulta.SQLConnection:= bdempex;
     with CDSConsulta do
     begin
       commandtext := 'select t.zona, t.seccion, s.descripcion, t.defectos  '+
                      'from ttmp7_ervtv T, Secciones S   ' +
                      'WHERE T.seccion = S.codigo '+
                      'ORDER BY to_number(t.zona)';
         Begin
          open;
          if RecordCount > 0 then
          Begin
            //qrlEmpresa.Caption := 'Planta: ' + putestacion ;
            qrlFecha.Caption := 'Desde: '+copy(DateIni,1,10)+' - Hasta: '+copy(DateFin,1,10);
            QRLabel1.caption :='Defectos por Zona y Planta' ;
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

procedure TfRepdefectosGlobal.QRBDetalleBeforePrint(Sender: TQRCustomBand;
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
