unit ufEstadisticasResultados;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ucDialgs,
  TeEngine, Series, ExtCtrls, TeeProcs, Chart, DBChart, RXCtrls, StdCtrls,
  Buttons, Spin, SpeedBar, Db, usagestacion, Grids, DBGrids,
  FMTBcd, Provider, SqlExpr, DBClient, DBXpress;

type
  TfrmEstadisticasResultados = class(TForm)
    SpeedBar1: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    btnImprimir: TSpeedItem;
    btnSalir: TSpeedItem;
    btnTabla: TSpeedItem;
    Label3: TLabel;
    cbMes: TComboBox;
    Label2: TLabel;
    cbPunto: TComboBox;
    Label4: TLabel;
    seAno: TSpinEdit;
    btnAceptar: TBitBtn;
    dsQTTMPESTAD: TDataSource;
    pd: TPrintDialog;
    Bevel1: TBevel;
    chSeries: TRxCheckListBox;
    chResultados: TDBChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Series5: TLineSeries;
    Series6: TLineSeries;
    Series7: TLineSeries;
    Series8: TLineSeries;
    QTTMPRESULT: TClientDataSet;
    sdsQTTMPRESULT: TSQLDataSet;
    dspQTTMPRESULT: TDataSetProvider;
    SQLConnection1: TSQLConnection;
    Series9: TLineSeries;
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
    procedure PutDatosZ2(const tipores, tabla: string);
    procedure PutDatosZ6(const tipores, tabla: string);
    procedure PutDatosZ7(const tipores, tabla: string);

  public
    { Public declarations }
    bErrorCreando,crearseries : boolean;
    DateIni, DateFin, aPunto, sZona, aux_dateini, aux_datefin: string;
    todos: integer;
  end;
  procedure doEstadisticaResultados(const FI, FF, PUNTO: string; delete:boolean);
  procedure generateEstadisticaResultados;

var
  frmEstadisticasResultados: TfrmEstadisticasResultados;
  borrar, imprimiendotodos: boolean;
implementation

uses
  UFTMP,
  UUTILS,
  DATEUTIL,
  GLOBALS,
  ufSeleccionaPunto,
  UFEstadisticasResultadosToPrint,
  UFDatosEstadResultados,
  UFSeleccionaZona,           //Lucho
  UFEstadisticasResZ2ToPrint, //Lucho
  UFEstadisticasResZ7ToPrint; //Lucho


{$R *.DFM}

procedure doEstadisticaResultados(const FI, FF, PUNTO: string; delete:boolean);
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
        mybd.Close;
        mybd.free;
        TestOfBD('',dbUserName,dbPassword,false);
        if (not MyBD.InTransaction) then MyBD.StartTransaction(td);
        if borrar then
           DeleteTable(MYBD, 'TTMPESTADCALIFIC');
        with TsqlStoredProc.Create(nil) do
       try
         SQLConnection := MyBD;
          StoredProcName := 'PQ_ESTADISTICAS.DOESTADCALIFICACION';
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

procedure generateEstadisticaResultados;
begin
 MessageDlg('Generación de Informes.', 'Epppe: Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0) ;
  with TfrmEstadisticasResultados.Create(Application) do
    try
      try
        MessageDlg('Generación de Informes.', 'E1111e: Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0) ;

        if bErrorCreando then exit;
        MessageDlg('Generación de Informes.', '222e: Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)  ;

        PutEstacion;
         MessageDlg('Generación de Informes.', '333:Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)  ;

        FTmp.Temporizar(TRUE,FALSE,'Análisis de Calificación de Resultados', 'Generando el informe Estadística de Calificación de Resultados.');
        Application.ProcessMessages;
        dateini:=FechaInicio(ExtractMonth(firstdayofprevmonth),extractyear(firstdayofprevmonth));
        datefin:=FormatoCeros(DaysPerMonth(extractyear(firstdayofprevmonth),ExtractMonth(firstdayofprevmonth)),2)+'/'+FormatoCeros(ExtractMonth(firstdayofprevmonth),2)+'/'+inttostr(extractyear(firstdayofprevmonth))+' 23:59:59';
        aPunto:='1';
        aux_dateini:=dateini;
        aux_datefin:=datefin;
        doEstadisticaResultados(dateini, datefin, aPunto, borrar);
        FTmp.Temporizar(FALSE,FALSE,'', '');
        Application.ProcessMessages;
        PutTitulo;
        DibujaGrafico;
        ShowModal;
        Except
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


procedure TfrmEstadisticasResultados.PutEstacion;
begin
sZona := Format('Zona: %d',[fVarios.Zona]);
end;


procedure TfrmEstadisticasResultados.PutTitulo;
begin
  application.ProcessMessages;
  ChResultados.Title.Text.clear;
  ChResultados.Title.Text.Add('GRÁFICO PARA ANÁLISIS DE CALIFICACION DE RESULTADOS');
  ChResultados.Title.Text.Add('Resultado: '+cbPunto.text+'  -  '+sZona);
  ChResultados.Title.Text.Add('');
  application.ProcessMessages;
  PutSumaryResults;
  application.ProcessMessages;
end;


procedure TfrmEstadisticasResultados.PutSumaryResults;
var tablazona,tiporesultado: string;
  fsql : tstringlist;
begin
  try
    case cbpunto.ItemIndex of
      0:begin
          tiporesultado:='cantapro';
        end;
      1:begin
          tiporesultado:='cantcond';
        end;
      2:begin
          tiporesultado:='cantrech';
        end;
      end;

    case fvarios.zona of
      2:begin
          case strtoint(apunto) of
            1:begin
                tablazona:='TTMPESTADZ2';
              end;
            2:begin
                tablazona:='TTMPESTAD_COND_Z2';
              end;
            3:begin
                tablazona:='TTMPESTAD_RECH_Z2';
              end;
          end;
          PutDatosZ2(tiporesultado,tablazona);
          end;
      6:begin
        case strtoint(apunto) of
          1:begin
              tablazona:='TTMPESTADZ6';
            end;
          2:begin
              tablazona:='TTMPESTAD_COND_Z6';
            end;
          3:begin
              tablazona:='TTMPESTAD_RECH_Z6';
            end;
        end;
        PutDatosZ6(tiporesultado,tablazona);
        end;
      7:begin
        case strtoint(apunto) of
          1:begin
              tablazona:='TTMPESTADZ7';
            end;
          2:begin
              tablazona:='TTMPESTAD_COND_Z7';
            end;
          3:begin
              tablazona:='TTMPESTAD_RECH_Z7';
            end;
        end;
        PutDatosZ7(tiporesultado,tablazona);
        end;
    end;
    fsql := TStringList.Create;
    sdsQTTMPRESULT.SQLConnection := BDAG;
    with QTTMPRESULT do
      begin
        Close;
        SetProvider(dspQTTMPRESULT);
        fSQL.Clear;
        if borrar then
          begin
            fSQL.Add(format('SELECT * FROM %S ',[tablazona]));
            fsql.add(' order by 1');
          end
        else
          begin
            fSQL.Add(format('SELECT * FROM %S ',['TTMPESTAD_RECH_Z'+inttostr(fvarios.zona)]));
            fSQL.Add(format('union SELECT * FROM %S ',['TTMPESTAD_COND_Z'+inttostr(fvarios.zona)]));
            fSQL.Add(format('union SELECT * FROM %S ',['TTMPESTADZ'+inttostr(fvarios.zona)]));

            if fvarios.zona = 2 then
              fsql.add(' order by 12,1');

            if fvarios.zona = 6 then
              fsql.add(' order by 12,1');

            if fvarios.zona = 7 then
              fsql.add(' order by 8,1');
          end;
        CommandText := fsql.Text;
        Open;
      end;
  finally
    Application.ProcessMessages;
  end;
end;


procedure TfrmEstadisticasResultados.btnSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    close;
end;


procedure TfrmEstadisticasResultados.FormCreate(Sender: TObject);
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
    LoockAndDeleteTable(MyBD, 'TTMPESTADCALIFIC');
    PutFechaPunto;
    CHResultados.AutoRefresh:=true;
  except
    on E:Exception do
      begin
        MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
        bErrorCreando := True
      end
  end;
end;


procedure TfrmEstadisticasResultados.PutFechaPunto;
begin
  cbPunto.ItemIndex:=0;
  cbMes.ItemIndex:= ExtractMonth(IncMonth(now,-2));
  seAno.value:=ExtractYear(IncMonth(now,-1));
  aPunto:=inttostr(cbPunto.itemindex+1);
end;


procedure TfrmEstadisticasResultados.FormDestroy(Sender: TObject);
var
I: Integer;
begin
QTTMPRESULT.Close;
  try
    try
    if MyBD.InTransaction then
      MyBD.Rollback(td)
    else
      raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del Análisis de Calificación de Resultados');
//            if BDAG.InTransaction then BDAG.Rollback(td)
//            else raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del Análisis de Calificación de Resultados');
    except
      on E: Exception do
        begin
          MessageDlg('Generación de Informes.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
        end
    end
  finally
    For I:=0 to 3 do
      Begin
        if FileExists(NOM_DIR+NOM_TMP+IntToStr(I)+'.bmp') then
          DeleteFile(NOM_DIR+NOM_TMP+IntToStr(I)+'.bmp');
      end;
    FTmp.Temporizar(FALSE,FALSE,'','');
  end;
end;





procedure TfrmEstadisticasResultados.PutDatosZ2(const tipores, tabla: string);
begin
   with tsqlquery.Create(nil) do
   begin
     try
       SQLConnection :=bdag;
       if borrar then
       begin
         sql.add(format('TRUNCATE table %s',[tabla]));
         execsql;
       end;
       sql.clear;

       sql.add(format('INSERT INTO %s ',[tabla]));
       sql.add('select c21.ejercicio||c21.nromes as mesejer,c21.nombremes||'' ''||c21.ejercicio as mesanio,');
       sql.add(format('(c21.%:1S/NO_CERO_DIVISOR(c21.cantapro,c21.cantcond,c21.cantrech))*100 as porcent21,',[tipores]));
       sql.add(format('(c22.%:1S/NO_CERO_DIVISOR(c22.cantapro,c22.cantcond,c22.cantrech))*100 as porcent22,',[tipores]));
       sql.add(format('(c23.%:1S/NO_CERO_DIVISOR(c23.cantapro,c23.cantcond,c23.cantrech))*100 as porcent23,',[tipores]));
       sql.add(format('(c24.%:1S/NO_CERO_DIVISOR(c24.cantapro,c24.cantcond,c24.cantrech))*100 as porcent24,',[tipores]));
       sql.add(format('(c25.%:1S/NO_CERO_DIVISOR(c25.cantapro,c25.cantcond,c25.cantrech))*100 as porcent25,',[tipores]));
       sql.add(format('(c26.%:1S/NO_CERO_DIVISOR(c26.cantapro,c26.cantcond,c26.cantrech))*100 as porcent26,',[tipores]));
       sql.add(format('(c27.%:1S/NO_CERO_DIVISOR(c27.cantapro,c27.cantcond,c27.cantrech))*100 as porcent27,',[tipores]));
       sql.add(format('(c28.%:1S/NO_CERO_DIVISOR(c28.cantapro,c28.cantcond,c28.cantrech))*100 as porcent28,',[tipores]));

       sql.add(format('(((c21.%:1S/NO_CERO_DIVISOR(c21.cantapro,c21.cantcond,c21.cantrech))*100)+',[tipores]));
       sql.add(format('((c22.%:1S/NO_CERO_DIVISOR(c22.cantapro,c22.cantcond,c22.cantrech))*100)+',[tipores]));
       sql.add(format('((c24.%:1S/NO_CERO_DIVISOR(c24.cantapro,c24.cantcond,c24.cantrech))*100)+',[tipores]));
       sql.add(format('((c25.%:1S/NO_CERO_DIVISOR(c25.cantapro,c25.cantcond,c25.cantrech))*100)+',[tipores]));
       sql.add(format('((c26.%:1S/NO_CERO_DIVISOR(c26.cantapro,c26.cantcond,c26.cantrech))*100)+',[tipores]));
       sql.add(format('((c27.%:1S/NO_CERO_DIVISOR(c27.cantapro,c27.cantcond,c27.cantrech))*100)+',[tipores]));
       sql.add(format('((c28.%:1S/NO_CERO_DIVISOR(c28.cantapro,c28.cantcond,c28.cantrech))*100)+',[tipores]));

       sql.add(format('((c23.%:1S/NO_CERO_DIVISOR(c23.cantapro,c23.cantcond,c23.cantrech))*100))/8 as media,',[tipores]));
       sql.add(format('''%s'' as punto ',[inttostr(cbpunto.itemindex+1)]));
       sql.add('from cisa21.TTMPESTADCALIFIC c21,cisa22.TTMPESTADCALIFIC c22,cisa23.TTMPESTADCALIFIC c23,cisa24.TTMPESTADCALIFIC c24,cisa25.TTMPESTADCALIFIC c25,cisa26.TTMPESTADCALIFIC c26,cisa27.TTMPESTADCALIFIC c27,cisa28.TTMPESTADCALIFIC c28');
       sql.add('where c21.nombremes=c22.nombremes ');
       sql.add('and c21.nombremes=c23.nombremes ');
       sql.add('and c21.nombremes=c24.nombremes ');
       sql.add('and c21.nombremes=c25.nombremes ');
       sql.add('and c21.nombremes=c26.nombremes ');
       sql.add('and c21.nombremes=c27.nombremes ');
       sql.add('and c21.nombremes=c28.nombremes ');
       sql.add('and c21.ejercicio=c22.ejercicio ');
       sql.add('and c21.ejercicio=c23.ejercicio ');
       sql.add('and c21.ejercicio=c24.ejercicio ');
       sql.add('and c21.ejercicio=c25.ejercicio ');
       sql.add('and c21.ejercicio=c26.ejercicio ');
       sql.add('and c21.ejercicio=c27.ejercicio ');
       sql.add('and c21.ejercicio=c28.ejercicio ');

       execsql;

     finally
       close;
       free;
     end;
   end;
end;


procedure TfrmEstadisticasResultados.PutDatosZ6(const tipores, tabla: string);
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
       sql.add('select c61.ejercicio||c61.nromes as mesejer,c61.nombremes||'' ''||c61.ejercicio as mesanio,');
       sql.add(format('(c61.%:1S/NO_CERO_DIVISOR(c61.cantapro,c61.cantcond,c61.cantrech))*100 as porcent61,',[tipores]));
       sql.add(format('(c62.%:1S/NO_CERO_DIVISOR(c62.cantapro,c62.cantcond,c62.cantrech))*100 as porcent62,',[tipores]));
       sql.add(format('(c63.%:1S/NO_CERO_DIVISOR(c63.cantapro,c63.cantcond,c63.cantrech))*100 as porcent63,',[tipores]));
       sql.add(format('(c64.%:1S/NO_CERO_DIVISOR(c64.cantapro,c64.cantcond,c64.cantrech))*100 as porcent64,',[tipores]));
       sql.add(format('(c65.%:1S/NO_CERO_DIVISOR(c65.cantapro,c65.cantcond,c65.cantrech))*100 as porcent65,',[tipores]));
       sql.add(format('(c66.%:1S/NO_CERO_DIVISOR(c66.cantapro,c66.cantcond,c66.cantrech))*100 as porcent66,',[tipores]));
       sql.add(format('(c67.%:1S/NO_CERO_DIVISOR(c67.cantapro,c67.cantcond,c67.cantrech))*100 as porcent67,',[tipores]));
       sql.add(format('(c68.%:1S/NO_CERO_DIVISOR(c68.cantapro,c68.cantcond,c68.cantrech))*100 as porcent68,',[tipores]));
       sql.add(format('(((c61.%:1S/NO_CERO_DIVISOR(c61.cantapro,c61.cantcond,c61.cantrech))*100)+',[tipores]));
       sql.add(format('((c62.%:1S/NO_CERO_DIVISOR(c62.cantapro,c62.cantcond,c62.cantrech))*100)+',[tipores]));
       sql.add(format('((c63.%:1S/NO_CERO_DIVISOR(c63.cantapro,c63.cantcond,c63.cantrech))*100)+',[tipores]));
       sql.add(format('((c64.%:1S/NO_CERO_DIVISOR(c64.cantapro,c64.cantcond,c64.cantrech))*100)+',[tipores]));
       sql.add(format('((c65.%:1S/NO_CERO_DIVISOR(c65.cantapro,c65.cantcond,c65.cantrech))*100)+',[tipores]));
       sql.add(format('((c66.%:1S/NO_CERO_DIVISOR(c66.cantapro,c66.cantcond,c66.cantrech))*100)+',[tipores]));
       sql.add(format('((c67.%:1S/NO_CERO_DIVISOR(c67.cantapro,c67.cantcond,c67.cantrech))*100)+',[tipores]));
       sql.add(format('((c68.%:1S/NO_CERO_DIVISOR(c68.cantapro,c68.cantcond,c68.cantrech))*100))/8 as media,',[tipores]));
       sql.add(format('''%s'' as punto ',[inttostr(cbpunto.itemindex+1)]));

       sql.add('from cisa61.TTMPESTADCALIFIC c61,cisa62.TTMPESTADCALIFIC c62,cisa63.TTMPESTADCALIFIC c63,');
       sql.add('cisa64.TTMPESTADCALIFIC c64,cisa65.TTMPESTADCALIFIC c65,cisa66.TTMPESTADCALIFIC c66,cisa67.TTMPESTADCALIFIC c67 ,cisa68.TTMPESTADCALIFIC c68 ');
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


procedure TfrmEstadisticasResultados.PutDatosZ7(const tipores, tabla: string);
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
       sql.clear;
       sql.add(format('INSERT INTO %s ',[tabla]));
       sql.add('select c71.ejercicio||c71.nromes as mesejer,c71.nombremes||'' ''||c71.ejercicio as mesanio,');
       sql.add(format('(c71.%:1S/NO_CERO_DIVISOR(c71.cantapro,c71.cantcond,c71.cantrech))*100 as porcent71,',[tipores]));
       sql.add(format('(c72.%:1S/NO_CERO_DIVISOR(c72.cantapro,c72.cantcond,c72.cantrech))*100 as porcent72,',[tipores]));
       sql.add(format('(c73.%:1S/NO_CERO_DIVISOR(c73.cantapro,c73.cantcond,c73.cantrech))*100 as porcent73,',[tipores]));
       sql.add(format('(c75.%:1S/NO_CERO_DIVISOR(c75.cantapro,c75.cantcond,c75.cantrech))*100 as porcent75,',[tipores]));
       sql.add(format('(((c71.%:1S/NO_CERO_DIVISOR(c71.cantapro,c71.cantcond,c71.cantrech))*100)+',[tipores]));
       sql.add(format('((c72.%:1S/NO_CERO_DIVISOR(c72.cantapro,c72.cantcond,c72.cantrech))*100)+',[tipores]));
       sql.add(format('((c75.%:1S/NO_CERO_DIVISOR(c75.cantapro,c75.cantcond,c75.cantrech))*100)+',[tipores]));
       sql.add(format('((c73.%:1S/NO_CERO_DIVISOR(c73.cantapro,c73.cantcond,c73.cantrech))*100))/4 as media,',[tipores]));
       sql.add(format('''%s'' as punto ',[inttostr(cbpunto.itemindex+1)]));
       sql.add('from cisa71.TTMPESTADCALIFIC c71,cisa72.TTMPESTADCALIFIC c72,cisa73.TTMPESTADCALIFIC c73,cisa75.TTMPESTADCALIFIC c75 ');
       sql.add('where c71.nombremes=c72.nombremes ');
       sql.add('and c71.nombremes=c73.nombremes ');
       sql.add('and c71.nombremes=c75.nombremes ');
       sql.add('and c71.ejercicio=c72.ejercicio ');
       sql.add('and c71.ejercicio=c73.ejercicio');
       sql.add('and c71.ejercicio=c75.ejercicio');
       execsql;
     finally
       close;
       free;
     end;
   end;
end;


procedure TfrmEstadisticasResultados.btnAceptarClick(Sender: TObject);
begin
if not imprimiendotodos then
  FTmp.Temporizar(TRUE,FALSE,'Análisis de Calificación de Resultados', 'Generando el informe de Calificación de Resultados.');
Application.ProcessMessages;
dateini:=FechaInicio(cbMes.itemindex+1,seAno.value);
datefin:= FormatoCeros(DaysPerMonth(seAno.value,cbMes.itemindex+1),2)+'/'+FormatoCeros(cbMes.itemindex+1,2)+'/'+inttostr(seAno.value)+' 23:59:59';
aPunto:=inttostr(cbPunto.itemindex+1);

if (dateini  <> aux_dateini) or (datefin <> aux_datefin) then
  doEstadisticaResultados(dateini, datefin, aPunto, borrar);
PutTitulo;
DibujaGrafico;
if not imprimiendotodos then
  FTmp.Temporizar(FALSE,FALSE,'', '');
Application.ProcessMessages;
end;


procedure TfrmEstadisticasResultados.btnImprimirClick(Sender: TObject);
var I,E:integer;
Archivo: String;
begin
todos:=0;
  if DoSeleccionaPunto(todos) = mrcancel then
  exit;
  case todos of
  0:begin
      Screen.Cursor:=crHourGlass;
      ChResultados.Gradient.Visible:=false;
      ChResultados.SaveToBitmapFile(NOM_DIR+NOM_TMP+IntToStr(0)+'.bmp');
      ChResultados.Gradient.Visible:=true;
      case fvarios.zona of
        2:begin
          with TFrmEstadisticasResZ2ToPrint.Create(application) do
            try
              lbltitulo.caption:=sZona;
              qrlplanta1.caption:='Planta '+inttostr(fvarios.zona)+'1';
              qrlplanta2.caption:='Planta '+inttostr(fvarios.zona)+'2';
              qrlplanta3.caption:='Planta '+inttostr(fvarios.zona)+'3';
              qrlplanta4.caption:='Planta '+inttostr(fvarios.zona)+'4';
              qrlplanta5.caption:='Planta '+inttostr(fvarios.zona)+'5';
              qrlplanta6.caption:='Planta '+inttostr(fvarios.zona)+'6';
              qrlplanta7.caption:='Planta '+inttostr(fvarios.zona)+'7';
              qrlplanta8.caption:='Planta '+inttostr(fvarios.zona)+'8';
              qrlmedia.caption:='Media';

              bdtmedia.datafield:='MEDIA';
              bdtplanta1.datafield:='PORCENT'+inttostr(fvarios.zona)+'1';
              bdtplanta2.datafield:='PORCENT'+inttostr(fvarios.zona)+'2';
              bdtplanta3.datafield:='PORCENT'+inttostr(fvarios.zona)+'3';
              bdtplanta4.datafield:='PORCENT'+inttostr(fvarios.zona)+'4';
              bdtplanta5.datafield:='PORCENT'+inttostr(fvarios.zona)+'5';
              bdtplanta6.datafield:='PORCENT'+inttostr(fvarios.zona)+'6';
              bdtplanta7.datafield:='PORCENT'+inttostr(fvarios.zona)+'7';
              bdtplanta8.datafield:='PORCENT'+inttostr(fvarios.zona)+'8';

              QRImage1.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'0.bmp');
              Screen.Cursor:=crDefault;

              RepResultados21.Prepare;
              RepResultados21.Preview;
            finally
              borrar:=true;
              btnaceptar.Click;
              free;
              Screen.Cursor:=crDefault;
            end;
          end;
        6:begin
            with TFrmEstadisticasResZ7ToPrint.Create(application) do
              try
                Screen.Cursor:=crHourGlass;
                lbltitulo.caption:=sZona;
                QRImage1.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'0.bmp');
                QRImage2.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'1.bmp');
                QRImage3.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'2.bmp');
                Screen.Cursor:=crDefault;
                RepResultados61.Preview;;
              finally
                borrar:=true;
                btnaceptar.Click;
                Free;
                Screen.Cursor:=crDefault;
              end;
          end;
        7:begin
            with TFrmEstadisticasResZ2ToPrint.Create(application) do
              try
                lbltitulo.caption:=sZona;
                qrlplanta1.caption:='Planta '+inttostr(fvarios.zona)+'1';
                qrlplanta2.caption:='Planta '+inttostr(fvarios.zona)+'2';
                qrlplanta3.caption:='Planta '+inttostr(fvarios.zona)+'3';
                qrlplanta4.caption:='Planta '+inttostr(fvarios.zona)+'5';
                qrlmedia.caption:='Media';

                bdtmedia.datafield:='MEDIA';
                bdtplanta1.datafield:='PORCENT'+inttostr(fvarios.zona)+'1';
                bdtplanta2.datafield:='PORCENT'+inttostr(fvarios.zona)+'2';
                bdtplanta3.datafield:='PORCENT'+inttostr(fvarios.zona)+'3';
                bdtplanta4.datafield:='PORCENT'+inttostr(fvarios.zona)+'5';

                qrlplanta5.destroy;
                qrlplanta6.destroy;
                qrlplanta7.destroy;
                qrlplanta8.destroy;
                bdtplanta5.Destroy;
                bdtplanta6.Destroy;
                bdtplanta7.Destroy;
                bdtplanta8.Destroy;
                QRImage1.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'0.bmp');
                Screen.Cursor:=crDefault;

                RepResultados21.Prepare;
                RepResultados21.Preview;
              finally
                borrar:=true;
                btnaceptar.Click;
                free;
                Screen.Cursor:=crDefault;
              end;
          end
      end;
    end;
  1,2:begin
    Screen.Cursor:=crHourGlass;
    try
      for i := 0 to cbPunto.Items.Count-1 do
      Begin
        with ChResultados do
          Begin
          cbpunto.itemindex:=I;
          btnaceptar.Click;
          Gradient.Visible:=False;
          SaveToBitmapFile(NOM_DIR+NOM_TMP+IntToStr(I)+'.bmp');
          Gradient.Visible:=true;
          Borrar:=true;
          end;
      end;
      for E := 0 to cbPunto.Items.Count-1 do
        begin
          cbpunto.itemindex:=I+1;
          btnaceptar.Click;
          borrar:=false;
        end;
      case fvarios.zona of
        2:begin
            with TFrmEstadisticasResZ2ToPrint.Create(application) do
              try
                Begin
                  lbltitulo.caption:=sZona;
                  qrlplanta1.caption:='Planta '+inttostr(fvarios.zona)+'1';
                  qrlplanta2.caption:='Planta '+inttostr(fvarios.zona)+'2';
                  qrlplanta3.caption:='Planta '+inttostr(fvarios.zona)+'3';
                  qrlplanta4.caption:='Planta '+inttostr(fvarios.zona)+'4';
                  qrlplanta5.caption:='Planta '+inttostr(fvarios.zona)+'5';
                  qrlplanta6.caption:='Planta '+inttostr(fvarios.zona)+'6';
                  qrlplanta7.caption:='Planta '+inttostr(fvarios.zona)+'7';
                  qrlplanta8.caption:='Planta '+inttostr(fvarios.zona)+'8';
                  qrlmedia.caption:='Media';

                  bdtplanta1.datafield:='PORCENT'+inttostr(fvarios.zona)+'1';
                  bdtplanta2.datafield:='PORCENT'+inttostr(fvarios.zona)+'2';
                  bdtplanta3.datafield:='PORCENT'+inttostr(fvarios.zona)+'3';
                  bdtplanta4.datafield:='PORCENT'+inttostr(fvarios.zona)+'4';
                  bdtplanta5.datafield:='PORCENT'+inttostr(fvarios.zona)+'5';
                  bdtplanta6.datafield:='PORCENT'+inttostr(fvarios.zona)+'6';
                  bdtplanta7.datafield:='PORCENT'+inttostr(fvarios.zona)+'7';
                  bdtplanta8.datafield:='PORCENT'+inttostr(fvarios.zona)+'8';
                  bdtmedia.datafield:='MEDIA';

                  QRImage1.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'0.bmp');
                  QRImage2.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'1.bmp');
                  QRImage3.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'2.bmp');

                  RepResultados21.Prepare;
                  QRResultadosZona2.Prepare;

                  Screen.Cursor:=crDefault;
                  case Todos of
                  1: QRResultadosZona2.Preview;
                  2: Begin
                     if GetImpresora <> -1 then
                       Begin
                       QRResultadosZona2.PrinterSettings.PrinterIndex:=GetImpresora;
                       QRResultadosZona2.Print;
                       Sleep(900);
                       Archivo:='Resultadosz'+IntToStr(fvarios.zona)+'.pdf';
                       Guardar(Archivo);
                       end;
                     end;
                  end;
                  end;
                Except
                  on E: Exception do
                    begin
                      FTmp.Temporizar(FALSE,FALSE,'', '');
                      Application.ProcessMessages;
                      MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)
                    end
                end;
              end;
            6:begin
                with TFrmEstadisticasResZ7ToPrint.Create(application) do
                  try
                    Screen.Cursor:=crHourGlass;
                    lbltitulo.caption:=sZona;


                    QRImage1.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'0.bmp');
                    QRImage2.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'1.bmp');
                    QRImage3.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'2.bmp');
                    Screen.Cursor:=crDefault;
                    case Todos of
                    1: QRResultadosZona6.Preview;
                    2: Begin
                         if GetImpresora <> -1 then
                           Begin
                           QRResultadosZona6.PrinterSettings.PrinterIndex:=GetImpresora;
                           QRResultadosZona6.Print;
                           Sleep(900);
                           Archivo:='Resultadosz'+IntToStr(fvarios.zona)+'.pdf';
                           Guardar(Archivo);
                           end;
                       end;
                    end;
                  finally
                    Free;
                    Screen.Cursor:=crDefault;
                  end;
              end;
            7:begin
                with TFrmEstadisticasResZ2ToPrint.Create(application) do
                  try
                    lbltitulo.caption:=sZona;
                    qrlplanta1.caption:='Planta '+inttostr(fvarios.zona)+'1';
                    qrlplanta2.caption:='Planta '+inttostr(fvarios.zona)+'2';
                    qrlplanta3.caption:='Planta '+inttostr(fvarios.zona)+'3';
                    qrlplanta4.caption:='Planta '+inttostr(fvarios.zona)+'5';
                    qrlmedia.caption:='Media';

                    qrlplanta5.destroy;
                    qrlplanta6.destroy;
                    qrlplanta7.destroy;
                    qrlplanta8.destroy;
                    bdtplanta5.DataField:='';
                    bdtplanta6.DataField:='';
                    bdtplanta7.DataField:='';
                    bdtplanta8.DataField:='';
                    bdtplanta1.datafield:='PORCENT'+inttostr(fvarios.zona)+'1';
                    bdtplanta2.datafield:='PORCENT'+inttostr(fvarios.zona)+'2';
                    bdtplanta3.datafield:='PORCENT'+inttostr(fvarios.zona)+'3';
                    bdtplanta4.datafield:='PORCENT'+inttostr(fvarios.zona)+'5';
                    bdtmedia.datafield:='MEDIA';

                    QRImage1.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'0.bmp');
                    QRImage2.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'1.bmp');
                    QRImage3.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'2.bmp');

                    RepResultados21.Prepare;
                    QRResultadosZona2.Prepare;

                    Screen.Cursor:=crDefault;
                    case Todos of
                    1: QRResultadosZona2.Preview;
                    2:Begin
                      if GetImpresora <> -1 then
                        Begin
                        QRResultadosZona2.PrinterSettings.PrinterIndex:=GetImpresora;
                        QRResultadosZona2.Print;
                        Sleep(900);
                        Archivo:='Resultadosz'+IntToStr(fvarios.zona)+'.pdf';
                        Guardar(Archivo);
                        end;
                      end;
                    end;
                  Except
                    on E: Exception do
                      begin
                      FTmp.Temporizar(FALSE,FALSE,'', '');
                      Application.ProcessMessages;
                      MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)
                      end
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




procedure TfrmEstadisticasResultados.btnTablaClick(Sender: TObject);
begin
  DoDatosEstadResultados('Punto: '+cbPunto.text+'  -  '+szona,fvarios.zona);
end;


procedure TfrmEstadisticasResultados.chSeriesClickCheck(Sender: TObject);
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
        series9.Marks.visible:=chSeries.Checked[8];
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
        series9.Marks.visible:=chSeries.Checked[8];
      end;
   7: Begin
        series1.Marks.visible:=chSeries.Checked[0];
        series2.Marks.visible:=chSeries.Checked[1];
        series3.Marks.visible:=chSeries.Checked[2];
        series4.Marks.visible:=chSeries.Checked[3];
        series5.Marks.visible:=chSeries.Checked[4];
      end;
  end;
end;


procedure TfrmEstadisticasResultados.FormShow(Sender: TObject);
var i: integer;
begin
  case fvarios.Zona of
    2:begin

        chSeries.Items.add('Planta '+copy(QTTMPRESULT.fields[2].DisplayName,8,2));
        chSeries.Items.add('Planta '+copy(QTTMPRESULT.fields[3].DisplayName,8,2));
        chSeries.Items.add('Planta '+copy(QTTMPRESULT.fields[4].DisplayName,8,2));
        chSeries.Items.add('Planta '+copy(QTTMPRESULT.fields[5].DisplayName,8,2));
        chSeries.Items.add('Planta '+copy(QTTMPRESULT.fields[6].DisplayName,8,2));
        chSeries.Items.add('Planta '+copy(QTTMPRESULT.fields[7].DisplayName,8,2));
        chSeries.Items.add('Planta '+copy(QTTMPRESULT.fields[8].DisplayName,8,2));
        chSeries.Items.add('Planta '+copy(QTTMPRESULT.fields[9].DisplayName,8,2));
        chSeries.Items.add('Media');
      end;
    6:begin
        chSeries.Items.add('Planta '+copy(QTTMPRESULT.fields[2].DisplayName,8,2));
        chSeries.Items.add('Planta '+copy(QTTMPRESULT.fields[3].DisplayName,8,2));
        chSeries.Items.add('Planta '+copy(QTTMPRESULT.fields[4].DisplayName,8,2));
        chSeries.Items.add('Planta '+copy(QTTMPRESULT.fields[5].DisplayName,8,2));
        chSeries.Items.add('Planta '+copy(QTTMPRESULT.fields[6].DisplayName,8,2));
        chSeries.Items.add('Planta '+copy(QTTMPRESULT.fields[7].DisplayName,8,2));
        chSeries.Items.add('Planta '+copy(QTTMPRESULT.fields[8].DisplayName,8,2));
        chSeries.Items.add('Planta '+copy(QTTMPRESULT.fields[9].DisplayName,8,2));
        chSeries.Items.add('Media');
      end;
    7:begin
        chSeries.Items.add('Planta '+copy(QTTMPRESULT.fields[2].DisplayName,8,2));
        chSeries.Items.add('Planta '+copy(QTTMPRESULT.fields[3].DisplayName,8,2));
        chSeries.Items.add('Planta '+copy(QTTMPRESULT.fields[4].DisplayName,8,2));
        chSeries.Items.add('Planta '+copy(QTTMPRESULT.fields[5].DisplayName,8,2));
        chSeries.Items.add('Media');
      end;
  end
end;


procedure TfrmEstadisticasResultados.DibujaGrafico;
begin
  if fVarios.Zona = 2 then
  begin
    series1.title:= 'Planta '+copy(QTTMPRESULT.fields[2].DisplayName,8,2);
    series2.title:= 'Planta '+copy(QTTMPRESULT.fields[3].DisplayName,8,2);
    series3.title:= 'Planta '+copy(QTTMPRESULT.fields[4].DisplayName,8,2);
    series4.title:= 'Planta '+copy(QTTMPRESULT.fields[5].DisplayName,8,2);
    series5.title:= 'Planta '+copy(QTTMPRESULT.fields[6].DisplayName,8,2);
    series6.title:= 'Planta '+copy(QTTMPRESULT.fields[7].DisplayName,8,2);
    series7.title:= 'Planta '+copy(QTTMPRESULT.fields[8].DisplayName,8,2);
    series8.title:= 'Planta '+copy(QTTMPRESULT.fields[9].DisplayName,8,2);
    series9.title:= 'Media';

    series1.YValues.ValueSource := QTTMPRESULT.fields[2].DisplayName;
    series2.YValues.ValueSource := QTTMPRESULT.fields[3].DisplayName;
    series3.YValues.ValueSource := QTTMPRESULT.fields[4].DisplayName;
    series4.YValues.ValueSource := QTTMPRESULT.fields[5].DisplayName;
    series5.YValues.ValueSource := QTTMPRESULT.fields[6].DisplayName;
    series6.YValues.ValueSource := QTTMPRESULT.fields[7].DisplayName;
    series7.YValues.ValueSource := QTTMPRESULT.fields[8].DisplayName;
    series8.YValues.ValueSource := QTTMPRESULT.fields[9].DisplayName;
    series9.YValues.ValueSource := QTTMPRESULT.fields[10].DisplayName;

  end;

  if fVarios.Zona = 6 then
  begin
    series1.title:= 'Planta '+copy(QTTMPRESULT.fields[2].DisplayName,8,2);
    series2.title:= 'Planta '+copy(QTTMPRESULT.fields[3].DisplayName,8,2);
    series3.title:= 'Planta '+copy(QTTMPRESULT.fields[4].DisplayName,8,2);
    series4.title:= 'Planta '+copy(QTTMPRESULT.fields[5].DisplayName,8,2);
    series4.SeriesColor:=clblue;
    series5.title:= 'Planta '+copy(QTTMPRESULT.fields[6].DisplayName,8,2);
    series6.title:= 'Planta '+copy(QTTMPRESULT.fields[7].DisplayName,8,2);
    series7.title:= 'Planta '+copy(QTTMPRESULT.fields[8].DisplayName,8,2);
    series8.title:= 'Planta '+copy(QTTMPRESULT.fields[9].DisplayName,8,2);
    series9.title:= QTTMPRESULT.fields[10].DisplayName;
    series9.SeriesColor:=clblack;

    series1.YValues.ValueSource := QTTMPRESULT.fields[2].DisplayName;
    series2.YValues.ValueSource := QTTMPRESULT.fields[3].DisplayName;
    series3.YValues.ValueSource := QTTMPRESULT.fields[4].DisplayName;
    series4.YValues.ValueSource := QTTMPRESULT.fields[5].DisplayName;
    series5.YValues.ValueSource := QTTMPRESULT.fields[6].DisplayName;
    series6.YValues.ValueSource := QTTMPRESULT.fields[7].DisplayName;
    series7.YValues.ValueSource := QTTMPRESULT.fields[8].DisplayName;
    series8.YValues.ValueSource := QTTMPRESULT.fields[9].DisplayName;
    series9.YValues.ValueSource := QTTMPRESULT.fields[10].DisplayName;
  end;

  if fVarios.Zona = 7 then
  begin
    series1.title:= 'Planta '+copy(QTTMPRESULT.fields[2].DisplayName,8,2);
    series2.title:= 'Planta '+copy(QTTMPRESULT.fields[3].DisplayName,8,2);
    series3.title:= 'Planta '+copy(QTTMPRESULT.fields[4].DisplayName,8,2);
    series4.title:= 'Planta '+copy(QTTMPRESULT.fields[5].DisplayName,8,2);
    series5.title:= 'Media';

    series1.YValues.ValueSource := QTTMPRESULT.fields[2].DisplayName;
    series2.YValues.ValueSource := QTTMPRESULT.fields[3].DisplayName;
    series3.YValues.ValueSource := QTTMPRESULT.fields[4].DisplayName;
    series4.YValues.ValueSource := QTTMPRESULT.fields[5].DisplayName;
    series5.YValues.ValueSource := QTTMPRESULT.fields[6].DisplayName;

    series6.Free;
    series7.Free;
    series8.Free;
    series9.Free;
  end;
end;






end.
