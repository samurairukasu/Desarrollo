unit UFEstdefectoPartxGlobal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uutils,
  QRCtrls, jpeg, QuickRpt,  Dialogs, ExtCtrls, sqlexpr, globals, uGetDates, UFPlanta,
  FMTBcd, DBClient, Provider, DB, QRExport;

type
  TfRepdefPartxglobal = class(TForm)
    repexceptionTiposDocu: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    qrlComprob: TQRLabel;
    qrlcant: TQRLabel;
    qrlFecha: TQRLabel;
    sdsConsulta: TSQLDataSet;
    dspConsulta: TDataSetProvider;
    cdsConsulta: TClientDataSet;
    QRRTFFilter1: TQRRTFFilter;
    QRExcelFilter1: TQRExcelFilter;
    QRTextFilter1: TQRTextFilter;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRExpr5: TQRExpr;
    QRBDETALLE: TQRBand;
    QRExpr2: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRLabel4: TQRLabel;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRExpr1: TQRExpr;
    QRExpr3: TQRExpr;
    procedure QRBDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

  Procedure GenerateDefecParticGlobal;
  procedure DoDefectosParticGlobal;
  function  PutEstacion : string;

var
  fRepdefPartxglobal: TfRepdefPartxglobal;



implementation

{$R *.dfm}

var
  DateIni, DateFin : string;


procedure DoDefectosParticGlobal;
var aInsertTable: tsqlQuery;
sdsfPlanta : TSQLDataSet;
dspfPlanta : TDataSetProvider;
fPlanta: TClientDataSet;

sdsTotAtenc : TSQLDataSet;
dspTotAtenc : TDataSetProvider;
cdsTotAtenc: TClientDataSet;
begin

  //If not GetDates(DateIni,DateFin) then Exit;

  sdsfPlanta:=TSQLDataSet.Create(application);
  sdsfPlanta.SQLConnection := BDAG;
  sdsfPlanta.CommandType := ctQuery;
  dspfPlanta := TDataSetProvider.Create(application);
  dspfPlanta.DataSet := sdsfPlanta;
  dspfPlanta.Options := [poIncFieldProps,poAllowCommandText];


  fPlanta:=TClientdataset.Create (application);

  try
    with fplanta do
    begin
     Screen.Cursor := crHourglass;
      setprovider(dspfPlanta);
      commandtext := 'SELECT * FROM TPLANTAS  WHERE TIPO=''P'' ';
      Open;

      DeleteTable(BDAG, 'TTMPESTADDEFECTOS');

      while not fPlanta.Eof do
      begin
          MyBD.Close;
          MyBD.free;
          TestOfBD('',fplanta.fields[2].value,fplanta.fields[3].value,false);
          InitAplicationGlobalTables;
          with TSQLStoredProc.Create(application) do
            try
                SQLConnection := MyBD;
                StoredProcName := 'Pq_Estadisticas.Doestaddefectos';
                ParamByName('FI').Value := copy(DateIni,1,10);
                ParamByName('FF').Value := copy(DateFin,1,10);
                ExecProc;
                Close;
          finally
              Free
          end;

        { sdsTotAtenc:=TSQLDataSet.Create(application);
         sdsTotAtenc.SQLConnection := MyBD;
         sdsTotAtenc.CommandType := ctQuery;
         dspTotAtenc := TDataSetProvider.Create(application);
         dspTotAtenc.DataSet := sdsTotAtenc;
         dspTotAtenc.Options := [poIncFieldProps,poAllowCommandText];
         cdsTotAtenc:=TClientdataset.Create (application);
         try
            with cdsTotAtenc  do
              begin
                setprovider(dspTotAtenc);
                CommandText:='SELECT * FROM  TTMPESTADDEFECTOS';
                Open;
                while not Eof do
                  begin
                     aInsertTable:= TSQLQuery.Create(application);
                     with aInsertTable do
                     try
                        SQLConnection:= BDAG;
                        SQL.Add('INSERT INTO TTMPESTADDEFECTOS VALUES(') ;
                        SQL.Add(Format('%s,%s,''%S'',%s,%d,%d,%d)',[cdsTotAtenc.Fields[0].Value,cdsTotAtenc.Fields[1].Value,cdsTotAtenc.Fields[2].Value,cdsTotAtenc.Fields[3].Value,cdsTotAtenc.Fields[4].Value,cdsTotAtenc.Fields[5].Value,cdsTotAtenc.Fields[6].Value]));
                        ExecSQL() ;
                    finally
                        aInsertTable.Free
                    end;


                    next;
                 end;
            end;
            finally
              cdsTotAtenc.close;
              cdsTotAtenc.Free ;
            end;  }
           //GenerarExcel(dateini,datefin);
       fPlanta.Next;
    end;
      Screen.Cursor := crDefault;
 end;
  fplanta.Close;
  fplanta.free;
  //ShowMessage('Transferencia de Archivo','Transferencia de Archivo');

   except
// ShowMessage('Error','No se puede realizar esta operación.')
  end;
end;

Procedure GenerateDefecParticGlobal;
begin
 If not GetDates(DateIni,DateFin) then Exit;
   DoDefectosParticGlobal;

  with TfRepdefPartxGlobal.Create(application) do
   try
     sdsConsulta.SQLConnection:= BDAG;
     with CDSConsulta do
     begin
       commandtext := 'select zona, defecto,SUM(calif0)calif0, SUM(calif1)calif1,SUM(calif2)calif2,SUM(calif3)calif3 '+
                      'from TTMPESTADDEFECTOS GROUP BY ZONA,DEFECTO ORDER BY ZONA,DEFECTO';
         Begin
          open;
          if RecordCount > 0 then
          Begin
            QRLabel1.caption :='Defectos - Zona 2, 6 y 7';
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

procedure TfRepdefPartxglobal.QRBDetalleBeforePrint(Sender: TQRCustomBand;
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
