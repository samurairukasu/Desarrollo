unit ufEstadisticasTiempos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ucDialgs,
  TeEngine, Series, ExtCtrls, TeeProcs, Chart, DBChart, RXCtrls, StdCtrls,
  Buttons, Spin, SpeedBar, Db, usagestacion, Grids, DBGrids, FMTBcd,
  SqlExpr, Provider, DBClient;

type
  TfrmEstadisticasTiempos = class(TForm)
    SpeedBar1: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    btnImprimir: TSpeedItem;
    btnSalir: TSpeedItem;
    btnTabla: TSpeedItem;
    Label2: TLabel;
    Label3: TLabel;
    cbMes: TComboBox;
    cbPunto: TComboBox;
    Label4: TLabel;
    seAno: TSpinEdit;
    btnAceptar: TBitBtn;
    pd: TPrintDialog;
    Bevel1: TBevel;
    chSeries: TRxCheckListBox;
    QTTMPTIEMPOS: TClientDataSet;
    dspQTTMPTIEMPOS: TDataSetProvider;
    sdsQTTMPTIEMPOS: TSQLDataSet;
    chTiempos: TDBChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Series5: TLineSeries;
    Series6: TLineSeries;
    Series7: TLineSeries;
    dsQTTMPESTAD: TDataSource;
    Series8: TLineSeries;

    procedure btnSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnTablaClick(Sender: TObject);
    procedure chSeriesClickCheck(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Procedure PutEstacion;
    Procedure PutTitulo;
    procedure PutSumaryResults;
    procedure PutFechaPunto;
    procedure DibujaGrafico;
    procedure PutDatosZ2(const tipotiempo, tabla: string);
    procedure PutDatosZ6(const tipotiempo, tabla: string);
    procedure PutDatosZ7(const tipotiempo, tabla: string);


  public
    { Public declarations }
    bErrorCreando,crearseries : boolean;
    DateIni, DateFin, aPunto, sZona, aux_dateini, aux_datefin: string;
    todos: integer;
  end;
  procedure doEstadisticaTiempos(const FI, FF, PUNTO: string; delete:boolean);
  procedure generateEstadisticaTiempos;

var
  frmEstadisticasTiempos: TfrmEstadisticasTiempos;
  borrar, imprimiendotodos: boolean;
implementation

uses
  UFTMP,
  UUTILS,
  DATEUTIL,
  GLOBALS,
  ufSeleccionaPunto,
  UFEstadisticasTiemposToPrint,
  UFDatosEstadTiempos,
  UFEstadisticasTiemposPromZ2ToPrint,
  UFEstadisticasTiemposPromZ7ToPrint;


{$R *.DFM}

procedure doEstadisticaTiempos(const FI, FF, PUNTO: string; delete:boolean);
var aq: TClientDataSet;
    dsp: TDataSetProvider;
    sds: TSQLDataSet;
    dbusername, dbPassword: string;
begin

  sds:=TSQLDataSet.Create(application);
  sds.SQLConnection := BDAG;
  sds.CommandType := ctQuery;
  sds.GetMetadata := false;
  sds.NoMetadata := true;
  sds.ParamCheck := false;
  dsp := TDataSetProvider.Create(application);
  dsp.DataSet := sds;
  dsp.Options := [poIncFieldProps,poAllowCommandText];

  aq:=TClientdataset.Create (application);
    try
      aq.setprovider(dsp);
      aq.CommandText := format('select * from TPLANTAS WHERE CODZONA = %D',[fZona.fields[0].asinteger]);
      aq.open;
      aq.first;
      while not aq.eof do
      begin
        dbUserName:=aq.fieldbyname(FIELD_USUARIO).asstring;
        dbPassword:=aq.fieldbyname(FIELD_PASSWORD).asstring;
//        mybd.Close;
        mybd.free;
        TestOfBD('',dbUserName,dbPassword,false);
        if (not MyBD.InTransaction) then MyBD.StartTransaction(td);
        with tsqlquery.create(nil) do
        begin
          try
            SQLConnection:=mybd;
            sql.add('alter session set nls_date_format = ''dd/mm/yyyy HH24:mi:ss''');
            execsql;
            close;
          finally
            free
          end;
        end;
        DeleteTable(MYBD, 'TTMPESTADTIEMPOS');
        with TSQLStoredProc.Create(nil) do
        try
          SQLConnection := MyBD;
          StoredProcName := 'PQ_ESTADISTICAS.DOESTADTIEMPOS';
          Prepared := true;
          ParamByName('FI').Value := FI;
          ParamByName('FF').Value := FF;
          ExecProc;
          Close;
        finally
            Free
        end;
        aq.next;
      end;
    finally
      aq.close;
      aq.free;
    end;
end;

procedure generateEstadisticaTiempos;
begin
        with TfrmEstadisticasTiempos.Create(Application) do
        try
            try
                if bErrorCreando then exit;

                PutEstacion;

                FTmp.Temporizar(TRUE,FALSE,'Análisis de Tiempos de Inspección', 'Generando el informe Estadística de Tiempos de Inspección.');
                Application.ProcessMessages;

                dateini:=FechaInicio(ExtractMonth(firstdayofprevmonth),extractyear(firstdayofprevmonth));
                datefin:=FormatoCeros(DaysPerMonth(extractyear(firstdayofprevmonth),ExtractMonth(firstdayofprevmonth)),2)+'/'+FormatoCeros(ExtractMonth(firstdayofprevmonth),2)+'/'+inttostr(extractyear(firstdayofprevmonth))+' 23:59:59';

                aPunto:='1';
                aux_dateini:=dateini;
                aux_datefin:=datefin;

                doEstadisticaTiempos(dateini, datefin, aPunto, borrar);

                FTmp.Temporizar(FALSE,FALSE,'', '');
                Application.ProcessMessages;

                PutTitulo;
                DibujaGrafico;

                ShowModal;
            except
                on E: Exception do
                begin
                    FTmp.Temporizar(FALSE,FALSE,'', '');
                    Application.ProcessMessages;
                    MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)
                end
            end
        finally
            Free;
            Application.ProcessMessages;
        end;

end;

procedure TfrmEstadisticasTiempos.PutEstacion;
begin
sZona := Format('Zona: %d',[fVarios.Zona]);
end;

procedure TfrmEstadisticasTiempos.PutTitulo;
begin
  application.ProcessMessages;
  chTiempos.Title.Text.clear;
  chTiempos.Title.Text.Add('GRÁFICO PARA ANÁLISIS DE TIEMPOS DE INSPECCIÓN');
  chTiempos.Title.Text.Add(cbPunto.text+'  -  '+sZona);
  chTiempos.Title.Text.Add('');  
  application.ProcessMessages;
  PutSumaryResults;
  application.ProcessMessages;
end;


procedure TfrmEstadisticasTiempos.PutSumaryResults;
var
tablazona,tipotiempo: string;
fsql : TStringList;
begin
  try
    case cbpunto.ItemIndex of
      0:begin
          tipotiempo:='TLINEAPROM';
        end;
      1:begin
          tipotiempo:='TTOTALPROM';
        end;
    end;

    case fvarios.zona of
      2:begin
        case strtoint(apunto) of
          1:begin
              tablazona:='TTMPESTAD_TTL_Z2';
            end;
          2:begin
              tablazona:='TTMPESTAD_TTE_Z2';
            end;
        end;
        PutDatosZ2(tipotiempo,tablazona);
        end;

      6:begin
        case strtoint(apunto) of
          1:begin
              tablazona:='TTMPESTAD_TTL_Z6';
            end;
          2:begin
              tablazona:='TTMPESTAD_TTE_Z6';
            end;
        end;
        PutDatosZ6(tipotiempo,tablazona);
        end;

      7:begin
        case strtoint(apunto) of
          1:begin
              tablazona:='TTMPESTAD_TTL_Z7';
            end;
          2:begin
              tablazona:='TTMPESTAD_TTE_Z7';
            end;
        end;
        PutDatosZ7(tipotiempo,tablazona);
        end;
    end;

    fsql := TStringList.Create;
    with QTTMPTIEMPOS do
    begin
      Close;
      sdsQTTMPTIEMPOS.SQLConnection := BDAG;
      if borrar then
        CommandText := format('SELECT * FROM %S order by 1',[tablazona])
      else
        begin
          fSQL.Add(format('SELECT * FROM %S ',['TTMPESTAD_TTL_Z'+inttostr(fvarios.zona)]));
          fSQL.Add(format('union SELECT * FROM %S ',['TTMPESTAD_TTE_Z'+inttostr(fvarios.zona)]));
          //mofico MLA el report de la zona 2 salia desordenado.
          if fvarios.zona = 6 then
            fsql.add(' order by 11,1');
          if fvarios.zona = 7 then
            fsql.add(' order by 7,1');
          if fvarios.zona = 2 then
            fsql.add(' order by 11,1');
          CommandText := fsql.Text;
        end;
        Open;
      end;
  finally
    Application.ProcessMessages;
  end;
end;


procedure TfrmEstadisticasTiempos.btnSalirClick(Sender: TObject);
begin
FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
close;
end;


procedure TfrmEstadisticasTiempos.FormCreate(Sender: TObject);
begin
borrar:=true;
imprimiendotodos:=false;
bErrorCreando := False;
crearseries := true;
if (not MyBD.InTransaction) then
  MyBD.StartTransaction(td);
if (not BDAG.InTransaction) then
  BDAG.StartTransaction(td);

  try
    LoockAndDeleteTable(MyBD, 'TTMPESTADTIEMPOS');
    PutFechaPunto;
    chTiempos.AutoRefresh:=true;
  except
    on E:Exception do
      begin
        MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
        bErrorCreando := True
      end
  end;
end;

procedure TfrmEstadisticasTiempos.PutFechaPunto;
begin
  cbPunto.ItemIndex:=0;
  cbMes.ItemIndex:= ExtractMonth(IncMonth(now,-2));
  seAno.value:=ExtractYear(IncMonth(now,-1));
  aPunto:=inttostr(cbPunto.itemindex+1);
end;


procedure TfrmEstadisticasTiempos.FormDestroy(Sender: TObject);
begin
    QTTMPTIEMPOS.Close;
    try
        try
            if MyBD.InTransaction then MyBD.Rollback(td)
            else raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del Análisis de Tiempos de Inspección');
            if BDAG.InTransaction then BDAG.Rollback(td)
            else raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del Análisis de Tiempos de Inspección');

        except
            on E: Exception do
            begin
                MessageDlg('Generación de Informes.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end
        end
    finally
        FTmp.Temporizar(FALSE,FALSE,'','');
    end
end;

procedure TfrmEstadisticasTiempos.DibujaGrafico;
begin
  if fVarios.Zona = 2 then
  begin
    series1.title:= 'Planta '+copy(QTTMPTIEMPOS.fields[2].DisplayName,6,2);
    series2.title:= 'Planta '+copy(QTTMPTIEMPOS.fields[3].DisplayName,6,2);
    series3.title:= 'Planta '+copy(QTTMPTIEMPOS.fields[4].DisplayName,6,2);
    series4.title:= 'Planta '+copy(QTTMPTIEMPOS.fields[5].DisplayName,6,2);
    series5.title:= 'Planta '+copy(QTTMPTIEMPOS.fields[6].DisplayName,6,2);
    series6.title:= 'Planta '+copy(QTTMPTIEMPOS.fields[7].DisplayName,6,2);
    series7.title:= 'Planta '+copy(QTTMPTIEMPOS.fields[8].DisplayName,6,2);
    series8.title:= 'Planta '+copy(QTTMPTIEMPOS.fields[9].DisplayName,6,2);

    series1.YValues.ValueSource := QTTMPTIEMPOS.fields[2].DisplayName;
    series2.YValues.ValueSource := QTTMPTIEMPOS.fields[3].DisplayName;
    series3.YValues.ValueSource := QTTMPTIEMPOS.fields[4].DisplayName;
    series4.YValues.ValueSource := QTTMPTIEMPOS.fields[5].DisplayName;
    series5.YValues.ValueSource := QTTMPTIEMPOS.fields[6].DisplayName;
    series6.YValues.ValueSource := QTTMPTIEMPOS.fields[7].DisplayName;
    series7.YValues.ValueSource := QTTMPTIEMPOS.fields[8].DisplayName;
    series8.YValues.ValueSource := QTTMPTIEMPOS.fields[9].DisplayName;

  end;

  if fVarios.Zona = 6 then
  begin
    series1.title:= 'Planta '+copy(QTTMPTIEMPOS.fields[2].DisplayName,6,2);
    series2.title:= 'Planta '+copy(QTTMPTIEMPOS.fields[3].DisplayName,6,2);
    series3.title:= 'Planta '+copy(QTTMPTIEMPOS.fields[4].DisplayName,6,2);
    series4.title:= 'Planta '+copy(QTTMPTIEMPOS.fields[5].DisplayName,6,2);
    series4.SeriesColor:=clblue;
    series5.title:= 'Planta '+copy(QTTMPTIEMPOS.fields[6].DisplayName,6,2);
    series6.title:= 'Planta '+copy(QTTMPTIEMPOS.fields[7].DisplayName,6,2);
    series7.title:= 'Planta '+copy(QTTMPTIEMPOS.fields[8].DisplayName,6,2);
    series8.title:= 'Planta '+copy(QTTMPTIEMPOS.fields[9].DisplayName,6,2);

    series1.YValues.ValueSource := QTTMPTIEMPOS.fields[2].DisplayName;
    series2.YValues.ValueSource := QTTMPTIEMPOS.fields[3].DisplayName;
    series3.YValues.ValueSource := QTTMPTIEMPOS.fields[4].DisplayName;
    series4.YValues.ValueSource := QTTMPTIEMPOS.fields[5].DisplayName;
    series5.YValues.ValueSource := QTTMPTIEMPOS.fields[6].DisplayName;
    series6.YValues.ValueSource := QTTMPTIEMPOS.fields[7].DisplayName;
    series7.YValues.ValueSource := QTTMPTIEMPOS.fields[8].DisplayName;
    series8.YValues.ValueSource := QTTMPTIEMPOS.fields[9].DisplayName;

  end;

  if fVarios.Zona = 7 then
  Begin
    series1.title:= 'Planta '+copy(QTTMPTIEMPOS.fields[2].DisplayName,6,2);
    series2.title:= 'Planta '+copy(QTTMPTIEMPOS.fields[3].DisplayName,6,2);
    series3.title:= 'Planta '+copy(QTTMPTIEMPOS.fields[4].DisplayName,6,2);
    series4.title:= 'Planta '+copy(QTTMPTIEMPOS.fields[5].DisplayName,6,2);

    series1.YValues.ValueSource := QTTMPTIEMPOS.fields[2].DisplayName;
    series2.YValues.ValueSource := QTTMPTIEMPOS.fields[3].DisplayName;
    series3.YValues.ValueSource := QTTMPTIEMPOS.fields[4].DisplayName;
    series4.YValues.ValueSource := QTTMPTIEMPOS.fields[5].DisplayName;

    series5.free;
    series6.free;
    series7.free;
    series8.free;
  end;
end;


procedure TfrmEstadisticasTiempos.PutDatosZ2(const tipotiempo, tabla: string);
begin
   with tsqlquery.Create(nil) do
   begin
     try
       SQLConnection:=bdag;
       if borrar then
       begin
         sql.add(format('TRUNCATE table %s',[tabla]));
         execsql;
       end;

       sql.clear;
       sql.add(format('INSERT INTO %s ',[tabla]));
       sql.add('select c21.ejercicio||c21.nromes as mesejer,c21.nombremes||'' ''||c21.ejercicio as mesanio,');

       sql.add(format('to_char(to_date(c21.%:1S,''hh24:mi:ss''),''mi'')||'',''||to_char(to_date(c21.%:1S,''hh24:mi:ss''),''ss'') as tprom21,',[tipotiempo]));
       sql.add(format('to_char(to_date(c22.%:1S,''hh24:mi:ss''),''mi'')||'',''||to_char(to_date(c22.%:1S,''hh24:mi:ss''),''ss'') as tprom22,',[tipotiempo]));
       sql.add(format('to_char(to_date(c23.%:1S,''hh24:mi:ss''),''mi'')||'',''||to_char(to_date(c23.%:1S,''hh24:mi:ss''),''ss'') as tprom23,',[tipotiempo]));
       sql.add(format('to_char(to_date(c24.%:1S,''hh24:mi:ss''),''mi'')||'',''||to_char(to_date(c24.%:1S,''hh24:mi:ss''),''ss'') as tprom24,',[tipotiempo]));
       sql.add(format('to_char(to_date(c25.%:1S,''hh24:mi:ss''),''mi'')||'',''||to_char(to_date(c25.%:1S,''hh24:mi:ss''),''ss'') as tprom25,',[tipotiempo]));          //
       sql.add(format('to_char(to_date(c26.%:1S,''hh24:mi:ss''),''mi'')||'',''||to_char(to_date(c26.%:1S,''hh24:mi:ss''),''ss'') as tprom26,',[tipotiempo]));
       sql.add(format('to_char(to_date(c27.%:1S,''hh24:mi:ss''),''mi'')||'',''||to_char(to_date(c27.%:1S,''hh24:mi:ss''),''ss'') as tprom27,',[tipotiempo]));
       sql.add(format('to_char(to_date(c28.%:1S,''hh24:mi:ss''),''mi'')||'',''||to_char(to_date(c28.%:1S,''hh24:mi:ss''),''ss'') as tprom28,',[tipotiempo]));
       sql.add(format('''%s'' as punto ',[inttostr(cbpunto.itemindex+1)]));

       sql.add('from cisa21.TTMPESTADTIEMPOS c21,cisa22.TTMPESTADTIEMPOS c22,cisa23.TTMPESTADTIEMPOS c23, cisa24.TTMPESTADTIEMPOS c24, cisa25.TTMPESTADTIEMPOS c25, cisa26.TTMPESTADTIEMPOS c26,cisa27.TTMPESTADTIEMPOS c27 ,cisa28.TTMPESTADTIEMPOS c28  '); //
       sql.add('where c21.nombremes=c22.nombremes ');
       sql.add('and c21.nombremes=c23.nombremes ');
       sql.add('and c21.nombremes=c24.nombremes ');
       sql.add('and c21.nombremes=c25.nombremes ');
       sql.add('and c21.nombremes=c26.nombremes ');
       sql.add('and c21.nombremes=c27.nombremes ');
       sql.add('and c21.nombremes=c28.nombremes ');
       sql.add('and c21.ejercicio=c22.ejercicio ');
       sql.add('and c21.ejercicio=c23.ejercicio');
       sql.add('and c21.ejercicio=c24.ejercicio');
       sql.add('and c21.ejercicio=c25.ejercicio');
       sql.add('and c21.ejercicio=c26.ejercicio');
       sql.add('and c21.ejercicio=c27.ejercicio');
       sql.add('and c21.ejercicio=c28.ejercicio');
       execsql;
     finally
       close;
       free;
     end;
   end;
end;


procedure TfrmEstadisticasTiempos.PutDatosZ6(const tipotiempo, tabla: string);
begin
   with tsqlquery.Create(nil) do
   begin
     try
       SQLConnection:=bdag;
       if borrar then
       begin
         sql.add(format('TRUNCATE table %s',[tabla]));
         execsql;
       end;

       sql.clear;
       sql.add('ALTER SESSION SET NLS_DATE_FORMAT = ''DD/MM/YYYY HH24:MI:SS''');
       execsql;
       sql.clear;
       sql.add(format('INSERT INTO %s ',[tabla]));
       sql.add('select c61.ejercicio||c61.nromes as mesejer,c61.nombremes||'' ''||c61.ejercicio as mesanio,');
       sql.add(format('to_char(to_date(c61.%:1S,''hh24:mi:ss''),''mi'')||'',''||to_char(to_date(c61.%:1S,''hh24:mi:ss''),''ss'') as tprom61,',[tipotiempo]));
       sql.add(format('to_char(to_date(c62.%:1S,''hh24:mi:ss''),''mi'')||'',''||to_char(to_date(c62.%:1S,''hh24:mi:ss''),''ss'') as tprom62,',[tipotiempo]));
       sql.add(format('to_char(to_date(c63.%:1S,''hh24:mi:ss''),''mi'')||'',''||to_char(to_date(c63.%:1S,''hh24:mi:ss''),''ss'') as tprom63,',[tipotiempo]));
       sql.add(format('to_char(to_date(c64.%:1S,''hh24:mi:ss''),''mi'')||'',''||to_char(to_date(c64.%:1S,''hh24:mi:ss''),''ss'') as tprom64,',[tipotiempo]));
       sql.add(format('to_char(to_date(c65.%:1S,''hh24:mi:ss''),''mi'')||'',''||to_char(to_date(c65.%:1S,''hh24:mi:ss''),''ss'') as tprom65,',[tipotiempo]));
       sql.add(format('to_char(to_date(c66.%:1S,''hh24:mi:ss''),''mi'')||'',''||to_char(to_date(c66.%:1S,''hh24:mi:ss''),''ss'') as tprom66,',[tipotiempo]));
       sql.add(format('to_char(to_date(c67.%:1S,''hh24:mi:ss''),''mi'')||'',''||to_char(to_date(c67.%:1S,''hh24:mi:ss''),''ss'') as tprom67,',[tipotiempo]));
       sql.add(format('to_char(to_date(c68.%:1S,''hh24:mi:ss''),''mi'')||'',''||to_char(to_date(c68.%:1S,''hh24:mi:ss''),''ss'') as tprom68,',[tipotiempo]));
       sql.add(format('''%s'' as punto ',[inttostr(cbpunto.itemindex+1)]));
       sql.add('from cisa61.TTMPESTADTIEMPOS c61,cisa62.TTMPESTADTIEMPOS c62,cisa63.TTMPESTADTIEMPOS c63,');
       sql.add('cisa64.TTMPESTADTIEMPOS c64, cisa65.TTMPESTADTIEMPOS c65, cisa66.TTMPESTADTIEMPOS c66,cisa67.TTMPESTADTIEMPOS c67,cisa68.TTMPESTADTIEMPOS c68 ');
       sql.add('where c61.nombremes=c62.nombremes ');
       sql.add('and c61.nombremes=c63.nombremes ');
       sql.add('and c61.nombremes=c64.nombremes ');
       sql.add('and c61.nombremes=c65.nombremes ');
       sql.add('and c61.nombremes=c66.nombremes ');
       sql.add('and c61.nombremes=c67.nombremes ');
       sql.add('and c61.nombremes=c68.nombremes ');
       sql.add('and c61.ejercicio=c62.ejercicio ');
       sql.add('and c61.ejercicio=c63.ejercicio ');
       sql.add('and c61.ejercicio=c64.ejercicio ');
       sql.add('and c61.ejercicio=c65.ejercicio ');
       sql.add('and c61.ejercicio=c66.ejercicio ');
       sql.add('and c61.ejercicio=c67.ejercicio ');
       sql.add('and c61.ejercicio=c68.ejercicio ');
       execsql;
     finally
       close;
       free;
     end;
   end;
end;


procedure TfrmEstadisticasTiempos.PutDatosZ7(const tipotiempo, tabla: string);
var
  fsql : TStringList;
begin
   with TsqlQUERY.CREATE(NIL) do
   begin
     try
       SQLConnection:=bdag;
       if borrar then
       begin
         sql.add(format('TRUNCATE table %s',[tabla]));
         execsql;
       end;

       fsql := TStringList.Create;

       sql.clear;
       sql.add('ALTER SESSION SET NLS_DATE_FORMAT = ''DD/MM/YYYY HH24:MI:SS''');
       execsql;
       sql.clear;
       fsql.add(format('INSERT INTO %s ',[tabla]));
       fsql.add('select c71.ejercicio||c71.nromes as mesejer,c71.nombremes||'' ''||c71.ejercicio as mesanio,');

       fsql.add(format('to_char(to_date(c71.%:1S,''hh24:mi:ss''),''mi'')||'',''||to_char(to_date(c71.%:1S,''hh24:mi:ss''),''ss'') as tprom71,',[tipotiempo]));
       fsql.add(format('to_char(to_date(c72.%:1S,''hh24:mi:ss''),''mi'')||'',''||to_char(to_date(c72.%:1S,''hh24:mi:ss''),''ss'') as tprom72,',[tipotiempo]));
       fsql.add(format('to_char(to_date(c73.%:1S,''hh24:mi:ss''),''mi'')||'',''||to_char(to_date(c73.%:1S,''hh24:mi:ss''),''ss'') as tprom73,',[tipotiempo]));
       fsql.add(format('to_char(to_date(c75.%:1S,''hh24:mi:ss''),''mi'')||'',''||to_char(to_date(c75.%:1S,''hh24:mi:ss''),''ss'') as tprom75,',[tipotiempo]));
       fsql.add(format('''%s'' as punto ',[inttostr(cbpunto.itemindex+1)]));
       fsql.add('from cisa71.TTMPESTADTIEMPOS c71,cisa72.TTMPESTADTIEMPOS c72,cisa73.TTMPESTADTIEMPOS c73,cisa75.TTMPESTADTIEMPOS c75 ');
       fsql.add('where c71.nombremes=c72.nombremes ');
       fsql.add('and c71.nombremes=c73.nombremes ');
       fsql.add('and c71.nombremes=c75.nombremes ');
       fsql.add('and c71.ejercicio=c72.ejercicio ');
       fsql.add('and c71.ejercicio=c73.ejercicio');
       fsql.add('and c71.ejercicio=c75.ejercicio');
       fsql.text;
       sql := fsql;
       execsql;
     finally
       close;
       free;
     end;
   end;
end;


procedure TfrmEstadisticasTiempos.btnAceptarClick(Sender: TObject);
begin
if not imprimiendotodos then
  FTmp.Temporizar(TRUE,FALSE,'Análisis de Tiempos de Inspección', 'Generando el informe de Tiempos de Inspección');
Application.ProcessMessages;
dateini:=FechaInicio(cbMes.itemindex+1,seAno.value);
datefin:=FormatoCeros(DaysPerMonth(seAno.value,cbMes.itemindex+1),2)+'/'+FormatoCeros(cbMes.itemindex+1,2)+'/'+inttostr(seAno.value)+' 23:59:59';
aPunto:=inttostr(cbPunto.itemindex+1);
if (dateini <> aux_dateini) or (datefin <> aux_datefin) then
  doEstadisticaTiempos(dateini, datefin, aPunto, borrar);
PutTitulo;
DibujaGrafico;
if not imprimiendotodos then
  FTmp.Temporizar(FALSE,FALSE,'', '');
Application.ProcessMessages;
end;


procedure TfrmEstadisticasTiempos.btnImprimirClick(Sender: TObject);
var
I,E:integer;
Archivo: String;
begin
todos:=0;
  if DoSeleccionaPunto(todos) = mrcancel then
  exit;
  case todos of
  0:begin
    Screen.Cursor:=crHourGlass;
    chTiempos.Gradient.Visible:=false;
    chTiempos.SaveToBitmapFile(NOM_DIR+NOM_TMP+IntToStr(0)+'.bmp');
    chTiempos.Gradient.Visible:=true;
      case fvarios.zona of
        2:begin
          with TFrmEstadisticasTiemposZ2ToPrint.Create(application) do
            try
              lbltitulo.caption:=sZona;;
              bdtplanta1.datafield:='TPROM'+inttostr(fvarios.zona)+'1';
              bdtplanta2.datafield:='TPROM'+inttostr(fvarios.zona)+'2';
              bdtplanta3.datafield:='TPROM'+inttostr(fvarios.zona)+'3';
              bdtplanta4.datafield:='TPROM'+inttostr(fvarios.zona)+'4';
              bdtplanta5.datafield:='TPROM'+inttostr(fvarios.zona)+'5';
              bdtplanta6.datafield:='TPROM'+inttostr(fvarios.zona)+'6';
              bdtplanta7.datafield:='TPROM'+inttostr(fvarios.zona)+'7';
              bdtplanta8.datafield:='TPROM'+inttostr(fvarios.zona)+'8';

              qrlplanta1.caption:='Planta '+inttostr(fvarios.zona)+'1';
              qrlplanta2.caption:='Planta '+inttostr(fvarios.zona)+'2';
              qrlplanta3.caption:='Planta '+inttostr(fvarios.zona)+'3';
              qrlplanta4.caption:='Planta '+inttostr(fvarios.zona)+'4';
              qrlplanta5.caption:='Planta '+inttostr(fvarios.zona)+'5';
              qrlplanta6.caption:='Planta '+inttostr(fvarios.zona)+'6';
              qrlplanta7.caption:='Planta '+inttostr(fvarios.zona)+'7';
              qrlplanta8.caption:='Planta '+inttostr(fvarios.zona)+'8';

              Screen.Cursor:=crDefault;
              QRImage1.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'0.bmp');

              RepTiempos21.Prepare;
              RepTiempos21.Preview;
            finally
              borrar:=true;
              btnaceptar.Click;
              free;
              Screen.Cursor:=crDefault;
            end;
          end;

        6:begin
          With TFrmEstadisticasTiempoPromZ7ToPrint.Create(Application) do
            try
              lbltituloz6.caption:=cbPunto.text+'  -  '+sZona;;
              Screen.Cursor:=crDefault;
              QRImage1.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'0.bmp');
              RepTiempos61.Preview;
            finally
              Free;
            end;
          end;

        7:begin
          with TFrmEstadisticasTiemposZ2ToPrint.Create(application) do
            try
              lbltitulo.caption:=sZona;;
              bdtplanta1.datafield:='TPROM'+inttostr(fvarios.zona)+'1';
              bdtplanta2.datafield:='TPROM'+inttostr(fvarios.zona)+'2';
              bdtplanta3.datafield:='TPROM'+inttostr(fvarios.zona)+'3';
              bdtplanta4.datafield:='TPROM'+inttostr(fvarios.zona)+'5';

              qrlplanta1.caption:='Planta '+inttostr(fvarios.zona)+'1';
              qrlplanta2.caption:='Planta '+inttostr(fvarios.zona)+'2';
              qrlplanta3.caption:='Planta '+inttostr(fvarios.zona)+'3';
              qrlplanta4.caption:='Planta '+inttostr(fvarios.zona)+'5';

              qrlplanta5.Destroy;
              qrlplanta6.Destroy;
              qrlplanta6.Destroy;

              Screen.Cursor:=crDefault;
              QRImage1.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'0.bmp');

              RepTiempos21.Prepare;
              RepTiempos21.Preview;
            finally
              borrar:=true;
              btnaceptar.Click;
              free;
              Screen.Cursor:=crDefault;
            end;
          end;
      end;
    end;

  1,2:begin
    Screen.Cursor:=crHourGlass;
    try
      for I := 0 to cbPunto.Items.Count-1 do
      Begin
        with ChTiempos do
          Begin
          cbpunto.itemindex:=I;
          btnaceptar.Click;
          Gradient.Visible:=False;
          SaveToBitmapFile(NOM_DIR+NOM_TMP+IntToStr(I)+'.bmp');
          Gradient.Visible:=true;
          borrar:=true;
          end;
      end;
      for E := 0 to cbPunto.Items.Count-1 do
        begin
          cbpunto.itemindex:=I;
          btnaceptar.Click;
          borrar:=false;
        end;

        case fvarios.zona of
          2:Begin
            with TFrmEstadisticasTiemposZ2ToPrint.Create(application) do
              try
                Begin
                  lbltitulo.caption:=sZona;
                  bdtplanta1.datafield:='TPROM'+inttostr(fvarios.zona)+'1';
                  bdtplanta2.datafield:='TPROM'+inttostr(fvarios.zona)+'2';
                  bdtplanta3.datafield:='TPROM'+inttostr(fvarios.zona)+'3';
                  bdtplanta4.datafield:='TPROM'+inttostr(fvarios.zona)+'4';
                  bdtplanta5.datafield:='TPROM'+inttostr(fvarios.zona)+'5';
                  bdtplanta6.datafield:='TPROM'+inttostr(fvarios.zona)+'6';
                  bdtplanta7.datafield:='TPROM'+inttostr(fvarios.zona)+'7';
                  bdtplanta8.datafield:='TPROM'+inttostr(fvarios.zona)+'8';

                  qrlplanta1.caption:='Planta '+inttostr(fvarios.zona)+'1';
                  qrlplanta2.caption:='Planta '+inttostr(fvarios.zona)+'2';
                  qrlplanta3.caption:='Planta '+inttostr(fvarios.zona)+'3';
                  qrlplanta4.caption:='Planta '+inttostr(fvarios.zona)+'4';
                  qrlplanta5.caption:='Planta '+inttostr(fvarios.zona)+'5';
                  qrlplanta6.caption:='Planta '+inttostr(fvarios.zona)+'6';
                  qrlplanta7.caption:='Planta '+inttostr(fvarios.zona)+'7';
                  qrlplanta8.caption:='Planta '+inttostr(fvarios.zona)+'8';

                  RepTiempos21.Prepare;
                  QRTIemposZona2.Prepare;

                  Screen.Cursor:=crDefault;
                  QRImage1.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'0.bmp');
                  QRImage2.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'1.bmp');

                  case Todos of
                  1: QRTIemposZona2.Preview;
                  2: Begin
                     if GetImpresora <> -1 then
                       Begin
                       QRTIemposZona2.PrinterSettings.PrinterIndex:=GetImpresora;
                       QRTIemposZona2.Print;
                       Sleep(900);
                       Archivo:='Tiemposz'+IntToStr(fvarios.zona)+'.pdf';
                       Guardar(Archivo);
                       end;
                     end;
                  end;
                  end;
                finally
                  Free;
                end;
            end;

          7:Begin
            with TFrmEstadisticasTiemposZ2ToPrint.Create(application) do
              try
                Begin
                  lbltitulo.caption:=sZona;
                  bdtplanta1.datafield:='TPROM'+inttostr(fvarios.zona)+'1';
                  bdtplanta2.datafield:='TPROM'+inttostr(fvarios.zona)+'2';
                  bdtplanta3.datafield:='TPROM'+inttostr(fvarios.zona)+'3';
                  bdtplanta4.datafield:='TPROM'+inttostr(fvarios.zona)+'5';

                  qrlplanta1.caption:='Planta '+inttostr(fvarios.zona)+'1';
                  qrlplanta2.caption:='Planta '+inttostr(fvarios.zona)+'2';
                  qrlplanta3.caption:='Planta '+inttostr(fvarios.zona)+'3';
                  qrlplanta4.caption:='Planta '+inttostr(fvarios.zona)+'5';

                  qrlplanta5.Destroy;
                  qrlplanta6.Destroy;

                  RepTiempos21.Prepare;
                  QRTIemposZona2.Prepare;

                  Screen.Cursor:=crDefault;
                  QRImage1.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'0.bmp');
                  QRImage2.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'1.bmp');
                  case Todos of
                  1: QRTIemposZona2.Preview;
                  2: Begin
                     if GetImpresora <> -1 then
                       Begin
                       QRTIemposZona2.PrinterSettings.PrinterIndex:=GetImpresora;
                       QRTIemposZona2.Print;
                       Sleep(900);
                       Archivo:='Tiemposz'+IntToStr(fvarios.zona)+'.pdf';
                       Guardar(Archivo);
                       end;
                     end;
                  end;
                  end;
                finally
                  Free;
                end;
            end;

        6: Begin
            With TFrmEstadisticasTiempoPromZ7ToPrint.Create(Application) do
              try
                lbltituloz6.caption:=sZona;;
                QRImage1.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'0.bmp');
                QRImage2.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'1.bmp');
                Screen.Cursor:=crDEfault;
                case Todos of
                  1: QRTiemposZona6.Preview;
                  2: Begin
                     if GetImpresora <> -1 then
                       Begin
                       QRTIemposZona6.PrinterSettings.PrinterIndex:=GetImpresora;
                       QRTIemposZona6.Print;
                       Sleep(900);
                       Archivo:='Tiemposz'+IntToStr(fvarios.zona)+'.pdf';
                       Guardar(Archivo);
                       end;
                     end;
                  end;
              finally
                Free;
              end;
           end;
         end;
    finally
      borrar:=true;
      btnaceptar.Click;
      Screen.Cursor:=crDefault;
    end;
  end;
end;
end;


procedure TfrmEstadisticasTiempos.btnTablaClick(Sender: TObject);
begin
  DoDatosEstadTiempos(cbPunto.text+'  -  '+szona,fvarios.zona);
end;

  
procedure TfrmEstadisticasTiempos.chSeriesClickCheck(Sender: TObject);
begin
 case fvarios.Zona of
   2:begin
      series1.Marks.visible:=chSeries.Checked[0];
      series2.Marks.visible:=chSeries.Checked[1];
      series3.Marks.visible:=chSeries.Checked[2];
      series4.Marks.visible:=chSeries.Checked[3];
      series5.Marks.visible:=chSeries.Checked[4];
      series6.Marks.visible:=chSeries.Checked[5];
      series7.Marks.visible:=chSeries.Checked[6];
      series8.Marks.visible:=chSeries.Checked[7];
   end;
   6:begin
      series1.Marks.visible:=chSeries.Checked[0];
      series2.Marks.visible:=chSeries.Checked[1];
      series3.Marks.visible:=chSeries.Checked[2];
      series4.Marks.visible:=chSeries.Checked[3];
      series5.Marks.visible:=chSeries.Checked[4];
      series6.Marks.visible:=chSeries.Checked[5];
      series7.Marks.visible:=chSeries.Checked[6];
      series8.Marks.visible:=chSeries.Checked[7];
   end;
   7:begin
      series1.Marks.visible:=chSeries.Checked[0];
      series2.Marks.visible:=chSeries.Checked[1];
      series3.Marks.visible:=chSeries.Checked[2];
      series4.Marks.visible:=chSeries.Checked[3];
   end;
 end;
end;


procedure TfrmEstadisticasTiempos.FormShow(Sender: TObject);
var i:integer;
begin
  case fvarios.Zona of
    2:begin
      for i:=0 to 7 do
        chSeries.Items.add('Planta '+copy(QTTMPTIEMPOS.fields[i+2].DisplayName,6,2));
      end;
    6:begin
      for i:=0 to 7 do
        chSeries.Items.add('Planta '+copy(QTTMPTIEMPOS.fields[i+2].DisplayName,6,2));
      end;
    7:begin
      for i:=0 to 3 do
        chSeries.Items.add('Planta '+copy(QTTMPTIEMPOS.fields[i+2].DisplayName,6,2));
      end;
  end;
end;






end.
