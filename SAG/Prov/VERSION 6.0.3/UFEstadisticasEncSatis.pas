unit UFEstadisticasEncSatis;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  chartfx3, OleCtrls, ExtCtrls, TeeProcs, TeEngine, Chart,
  DBChart, Series, DB, StdCtrls, Spin, SpeedBar, Buttons, Dialogs,
  Grids, DBGrids, RXDBCtrl, RXCtrls, RXLookup, uSagClasses,qrexport,
  FMTBcd, DBClient, Provider, SqlExpr;


type
  TfrmEstadisticasEncSatis = class(TForm)
    cbMes: TComboBox;
    seAno: TSpinEdit;
    SpeedBar1: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    btnImprimir: TSpeedItem;
    btnSalir: TSpeedItem;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnAceptar: TBitBtn;
    pd: TPrintDialog;
    Bevel1: TBevel;
    btnTabla: TSpeedItem;
    chSeries: TRxCheckListBox;
    dbcbPunto: TRxDBLookupCombo;
    sdsQTTMPESTAD: TSQLDataSet;
    dspQTTMPESTAD: TDataSetProvider;
    QTTMPESTAD: TClientDataSet;
    ChEncuestas: TDBChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Series5: TLineSeries;
    Series6: TLineSeries;
    dsQTTMPESTAD: TDataSource;
    dsPregunta: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnTablaClick(Sender: TObject);
    procedure chSeriesClickCheck(Sender: TObject);
  private
    { Private declarations }
    fSerie : TSeries_encuestas;
    fPreguntas : TPreguntas_encuestas;
    procedure PutEstacion;
    procedure PutSumaryResults;
    procedure PutFechaPunto;
    function FechaInicio(const Mes,Ano:integer):string;
    procedure PutTitulo;
    procedure InicializoSerie;        //MODI NUEVO
  public
    { Public declarations }
    bErrorCreando : boolean;
    DateIni, DateFin, aPunto, NombreEstacion, NumeroEstacion: string;
  end;
  procedure doEstadisticaEncuestas(const FI, FF, PUNTO, Serie: string);    //MODI NUEVO
  procedure generateEstadisticaEncuestas;

var
  frmEstadisticasEncSatis: TfrmEstadisticasEncSatis;

implementation

{$R *.DFM}

uses

   UUTILS,
   ULOGS,
   GLOBALS,
   UFTMP,
   USAGESTACION,
   DATEUTIL,
   UGETDATES,
   UFDatosEstadEncuesta,
   UCDialgs,
   UFEstadisticasEncSatisToPrint;

resourcestring
    FICHERO_ACTUAL = 'UFEstadisticasEncSatis.PAS';



procedure doEstadisticaEncuestas(const FI, FF, PUNTO, serie: string);
begin
    DeleteTable(MyBD, 'TTMPESTAD_ENCUESTAS');

    with TSQLStoredProc.Create(application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_LIST_VARIOS.ESTADENCUESTA';
        Prepared := true;
        ParamByName('FI').Value := FI;
        ParamByName('FF').Value := FF;
        ParamByName('PUNTO').value := strtoint(PUNTO);
        ParamByName('NROSERIE').value := strtoint(serie);     //AGRE NUEVO
        ExecProc;
        Close;

    finally
        Free
    end
end;

procedure generateEstadisticaEncuestas;
begin
        with TfrmEstadisticasEncSatis.Create(Application) do
        try
            try
                if bErrorCreando then exit;

                PutEstacion;

                FTmp.Temporizar(TRUE,FALSE,'Análisis de Encuestas', 'Generando el informe Estadística de Encuestas.');
                Application.ProcessMessages;

//                dateini:=FechaInicio(ExtractMonth(DATE),CurrentYear);
//                datefin:=FormatoCeros(DaysPerMonth(CurrentYear,ExtractMonth(DATE)),2)+'/'+FormatoCeros(ExtractMonth(DATE),2)+'/'+inttostr(CurrentYear)+' 23:59:59';

                dateini:=FechaInicio(ExtractMonth(firstdayofprevmonth),extractyear(firstdayofprevmonth));
                datefin:=FormatoCeros(DaysPerMonth(extractyear(firstdayofprevmonth),ExtractMonth(firstdayofprevmonth)),2)+'/'+FormatoCeros(ExtractMonth(firstdayofprevmonth),2)+'/'+inttostr(extractyear(firstdayofprevmonth))+' 23:59:59';

                InicializoSerie;//MODI NUEVO

                aPunto:='1';
                doEstadisticaEncuestas(dateini, datefin, aPunto, fSerie.serie);

                FTmp.Temporizar(FALSE,FALSE,'', '');
                Application.ProcessMessages;

                PutTitulo;

                ShowModal;
            except
                on E: Exception do
                begin
                    FTmp.Temporizar(FALSE,FALSE,'', '');
                    Application.ProcessMessages;
                    FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
                    MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)
                end
            end
        finally
            Free;
            Application.ProcessMessages;
        end;
end;

procedure TfrmEstadisticasEncSatis.FormCreate(Sender: TObject);
begin
    bErrorCreando := False;
    if (not MyBD.InTransaction) then MyBD.StartTransaction(td);
    try
        LoockAndDeleteTable(MyBD, 'TTMPESTAD_ENCUESTAS');
        PutFechaPunto;
        CHEncuestas.AutoRefresh:=true;        
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
            MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
            bErrorCreando := True
        end
    end;
end;

procedure TfrmEstadisticasEncSatis.FormDestroy(Sender: TObject);
begin
    QTTMPESTAD.Close;

    try
        try
            if MyBD.InTransaction then
              begin
                MyBD.Rollback(td);
              end
            else raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del Análisis de Encuestas')
        except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'Error cerrando la ficha de UFEstadisticasEncSatis: %s', [E.message]);
                MessageDlg('Generación de Informes.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end
        end
    finally
        FTmp.Temporizar(FALSE,FALSE,'','');
        if assigned(fSerie) then fSerie.free;         //AGRE NUEVO
        if assigned(fPreguntas) then fPreguntas.Free; //AGRE NUEVO
    end

end;

procedure TfrmEstadisticasEncSatis.PutSumaryResults;
begin
    try

        with QTTMPESTAD do
        begin
            Close;
            sdsQTTMPESTAD.SQLConnection := MyBD;
            commandtext := 'SELECT MES, MUYSATIS, SATISFAC, ALGOINSA, INSATISF, SUM3Y4, LIMITE FROM TTMPESTAD_ENCUESTAS';
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPESTAD);
            {$ENDIF}

            Open;
        end
    finally
        Application.ProcessMessages;
    end;
end;

procedure TfrmEstadisticasEncSatis.PutEstacion;
begin
    try
       NombreEstacion := fVarios.NombreEstacion;
       NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
    finally
    end;
end;

procedure TfrmEstadisticasEncSatis.PutFechaPunto;
begin
  cbMes.ItemIndex:= ExtractMonth(IncMonth(now,-2));
  seAno.value:=ExtractMonth(IncMonth(now,-1));
end;

procedure TfrmEstadisticasEncSatis.btnSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    close;
end;



procedure TfrmEstadisticasEncSatis.btnImprimirClick(Sender: TObject);
begin
       if pd.Execute then
       begin
         CHEncuestas.Gradient.Visible:=false;
         CHEncuestas.PrintMargins:=Rect(3,3,3,3);
         CHEncuestas.PrintLandscape;
         CHEncuestas.Gradient.Visible:=True;
          with TFrmEstadisticasEncSatisToPrint.Create(Application) do
          try
              try
                lbltitulo.caption:='Punto: '+fpreguntas.NroPregunta+'. '+fpreguntas.abrevia+'  -  Planta: '+NumeroEstacion+' - '+NombreEstacion;
                repValores.printersetup;
                RepValores.print;
              except
                  on E: Exception do
                  begin
                      FTmp.Temporizar(FALSE,FALSE,'', '');
                      Application.ProcessMessages;
                      FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
                      MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)
                  end
              end
          finally
              Free;
          end;
       end;
end;

procedure TfrmEstadisticasEncSatis.btnAceptarClick(Sender: TObject);
begin
      FTmp.Temporizar(TRUE,FALSE,'Análisis de Encuestas', 'Generando el informe Estadística de Encuestas.');
      Application.ProcessMessages;
//      dateini:=FechaInicio(cbMes.itemindex+1,seAno.value);
//      datefin:=FormatoCeros(DaysPerMonth(seAno.value,cbMes.itemindex+1),2)+'/'+FormatoCeros(cbMes.itemindex+1,2)+'/'+inttostr(seAno.value)+' 23:59:59';

      dateini:=FechaInicio(cbMes.itemindex+1,seAno.value);
      datefin:=FormatoCeros(DaysPerMonth(seAno.value,cbMes.itemindex+1),2)+'/'+FormatoCeros(cbMes.itemindex+1,2)+'/'+inttostr(seAno.value)+' 23:59:59';
      InicializoSerie;//MODI NUEVO
      aPunto:=fpreguntas.NroPregunta;
      doEstadisticaEncuestas(dateini, datefin, aPunto, fSerie.serie);
      PutTitulo;
      FTmp.Temporizar(FALSE,FALSE,'', '');
      Application.ProcessMessages;
end;

function TfrmEstadisticasEncSatis.FechaInicio(const Mes,Ano:integer):string;
begin
  if mes > 5 then result:='01/'+FormatoCeros(Mes-5,2)+'/'+inttostr(ano)+' 00:00:00'
  else
  begin
    result:='01/'+FormatoCeros(Mes+7,2)+'/'+inttostr(ano-1)+' 00:00:00';
  end;
end;

procedure TfrmEstadisticasEncSatis.PutTitulo;
begin
  application.ProcessMessages;
  CHEncuestas.Title.Text.clear;
  CHEncuestas.Title.Text.Add('GRAFICO PARA ANALISIS DE ENCUESTAS');
  CHEncuestas.Title.Text.Add('Punto: '+fpreguntas.NroPregunta+'. '+fpreguntas.Abrevia+'  - Planta: '+NumeroEstacion+' - '+NombreEstacion);
  application.ProcessMessages;
  PutSumaryResults;
  application.ProcessMessages;
end;
procedure TfrmEstadisticasEncSatis.btnTablaClick(Sender: TObject);
begin
  DoDatosEstadEncuesta('Punto: '+fpreguntas.NroPregunta+'. '+fPreguntas.Abrevia+'  -  Planta: '+NumeroEstacion+' - '+NombreEstacion);
end;

procedure TfrmEstadisticasEncSatis.chSeriesClickCheck(Sender: TObject);
begin
       series1.Marks.visible:=chSeries.Checked[0];
       series2.Marks.visible:=chSeries.Checked[1];
       series3.Marks.visible:=chSeries.Checked[2];
       series4.Marks.visible:=chSeries.Checked[3];
       series5.Marks.visible:=chSeries.Checked[4];
end;

procedure TFrmEstadisticasEncSatis.InicializoSerie;
begin
  if assigned(fSerie) then fSerie.Close;
  if Assigned(fpreguntas) then fPreguntas.Close;
  fSerie := tSeries_encuestas.CreateByFecha(mybd,copy(datefin,1,10));
  fSerie.Open;
  fPreguntas := tPreguntas_encuestas.CreateBySerie(mybd,fSerie.serie);
  fPreguntas.Open;
  fPreguntas.First;
  dsPregunta.DataSet := fPreguntas.DataSet;
  dbcbPunto.Value:=fpreguntas.NroPregunta;
  aPunto:=fPreguntas.NroPregunta;
  ChEncuestas.Foot.Text.Strings[0] := fSerie.Nom_F_Impr;
end;

end.
