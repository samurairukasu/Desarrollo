unit UFEstadCelularesxPrimeras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uutils,
  QRCtrls, jpeg, QuickRpt,  Dialogs, ExtCtrls, sqlexpr, globals, uGetDates, UFPlanta,
  FMTBcd, DBClient, Provider, DB, QRExport;

type
  TfRepCelulares = class(TForm)
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
    QRExpr1: TQRExpr;
    QRLabel3: TQRLabel;
    QRExpr2: TQRExpr;
    QRImage1: TQRImage;
    SummaryBand1: TQRBand;
    QRLabel6: TQRLabel;
    QRShape1: TQRShape;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    procedure QRBDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

  Procedure GenerateLisCelulVSPrim;
  procedure DoProcedure;
  function  PutEstacion : string;

var
  fRepCelulares: TfRepCelulares;



implementation

uses Unitespera;

{$R *.dfm}

var
  DateIni, DateFin ,Idplanta,Nombre: string;

procedure DoProcedure;
begin
    with TSQLStoredProc.Create(application) do
    try
        Screen.Cursor := crHourglass;
        SQLConnection := mybd;
        StoredProcName := 'Pq_Estadisticas.Doestcelulares' ;
        //bdempex.ExecuteDirect('alter session set nls_date_format = ''dd/mm/yyyy''');
        ParamByName('FI').Value := copy(dateini,1,10);
        ParamByName('FF').Value := copy(datefin,1,10);
        ExecProc;
        Screen.Cursor := crDefault;
    finally
        free;
    end;

end;


Procedure GenerateLisCelulVSPrim;
  Var
  sdsfPlanta : TSQLDataSet;
   dspfPlanta : TDataSetProvider;
   fPlanta: TClientDataSet;
begin

  sdsfPlanta:=TSQLDataSet.Create(application);
  sdsfPlanta.SQLConnection := bdag;
  sdsfPlanta.CommandType := ctQuery;
  dspfPlanta := TDataSetProvider.Create(application);
  dspfPlanta.DataSet := sdsfPlanta;
  dspfPlanta.Options := [poIncFieldProps,poAllowCommandText];
  fPlanta:=TClientdataset.Create (application);

  If not GetDates(DateIni,DateFin) then Exit;


  espera.Show;
  APPLICATION.ProcessMessages;

    DeleteTable(bdempex, 'ttmp_celulares');     //bdga


    with fplanta do
       begin
       setprovider(dspfPlanta);
       commandtext := 'SELECT * FROM TPLANTAS  WHERE TIPO=''P'' ';
       Open;
       while not fPlanta.Eof do
       begin
        MyBD.Close;
        MyBD.free;
        TestOfBD('',fplanta.fields[2].value,fplanta.fields[3].value,false);
        InitAplicationGlobalTables;

        DOProcedure;
     //   ShowMessage('No existen resultados para esta consulta!'+fplanta.fields[3].value+fplanta.fields[2].value);
        fPlanta.Next;
     end;
     close;
     Free;
   end;


  with TfRepCelulares.Create(application) do
   try
   
     sdsConsulta.SQLConnection:= bdempex;
     with CDSConsulta do
     begin
       commandtext := 'select zona,fecha,celulares, primeras, round((celulares*100/primeras),2) as porc '+
                      'from ttmp_celulares   ' +
                      'ORDER BY to_number(zona)';
         Begin
          open;
          if RecordCount > 0 then
          Begin
            qrlFecha.Caption := 'Desde: '+copy(DateIni,1,10)+' - Hasta: '+copy(DateFin,1,10);
              espera.close;
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

procedure TfRepCelulares.QRBDetalleBeforePrint(Sender: TQRCustomBand;
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
