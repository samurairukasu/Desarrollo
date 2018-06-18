unit UFEstadisticasEncSatis;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  chartfx3, OleCtrls, graphsv3, ExtCtrls, TeeProcs, TeEngine, Chart,
  DBChart, Series, DB, StdCtrls, Spin, SpeedBar, Buttons, Dialogs,
  Grids, DBGrids, RXDBCtrl, RXCtrls, uSagClasses, RXLookup,SQLEXPR, FMTBcd,
  Provider, DBClient, DBXpress;


type
  TfrmEstadisticasEncSatis = class(TForm)
    ChEncuestas: TDBChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Series5: TLineSeries;
    Series6: TLineSeries;
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
    dsQTTMPESTAD: TDataSource;
    btnTabla: TSpeedItem;
    chSeries: TRxCheckListBox;
    dsPregunta: TDataSource;
    dbcbPunto: TRxDBLookupCombo;
    QTTMPESTAD: TClientDataSet;
    sdsQTTMPESTAD: TSQLDataSet;
    dspQTTMPESTAD: TDataSetProvider;
    SpeedItem1: TSpeedItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnTablaClick(Sender: TObject);
    procedure chSeriesClickCheck(Sender: TObject);
    procedure SpeedItem1Click(Sender: TObject);
  private
    { Private declarations }

    procedure PutEstacion;
    procedure PutSumaryResults;
    procedure PutFechaPunto;
    procedure PutTitulo;
    procedure InicializoSerie;        //MODI NUEVO
  public
    { Public declarations }
    bErrorCreando : boolean;
    DateIni, DateFin, aPunto, NombreEstacion, NumeroEstacion: string;
    todos, Serie: integer;

  end;
  procedure doEstadisticaEncuestas(const FI, FF, PUNTO, serie: string; delete:boolean);
  procedure generateEstadisticaEncuestas;

var
  frmEstadisticasEncSatis: TfrmEstadisticasEncSatis;
  borrar, imprimiendotodos: boolean;
  fSerie : TSeries_Encuestas;
  fPreguntas : TPreguntas_Encuestas;

implementation

{$R *.DFM}

uses

   UUTILS,
   GLOBALS,
   UFTMP,
   USAGESTACION,
   DATEUTIL,
   UFDatosEstadEncuesta,
   UCDialgs,
   ufSeleccionaPunto,
   UFEstadisticasEncToPrint,    //Lucho
   UFEstadisticasEncToPrintAll, //Lucho
   UFSeleccionaPlanta;          //Lucho


Procedure CrearDirectorio;
Begin
if not DirectoryExists(NOM_DIR)then
MKDir(NOM_DIR);
end;


procedure doEstadisticaEncuestas(const FI, FF, PUNTO, serie: string;delete: boolean);
begin
  if borrar then
    DeleteTable(MyBD, 'TTMPESTAD_ENCUESTAS');
  with TSQLStoredProc.Create(nil) do
    try
      try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_LIST_VARIOS.ESTADENCUESTA';
        Prepared := true;
        ParamByName('FI').Value := FI;
        ParamByName('FF').Value := FF;
        ParamByName('PUNTO').value := strtoint(PUNTO);
        ParamByName('NROSERIE').value := strtoint(serie);
        ExecProc;
        Close;
      except
        on E: Exception do
          begin
          Application.ProcessMessages;
         MessageDlg('Paquete no encontrado.', 'El paquete PQ_LIST_VARIOS.ESTADENCUESTA no ha sido encontrado: '#10#13+ E.message + #10#13 + 'Intente compilar o instalar de nuevo el paquete.', mtError, [mbOk], mbOk, 0);
          Close;
          end;
      end;
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
        CrearDirectorio;
        PutEstacion;
        FTmp.Temporizar(TRUE,FALSE,'Análisis de Encuestas', 'Generando el informe Estadística de Encuestas.');
        Application.ProcessMessages;
        dateini:=FechaInicio(ExtractMonth(firstdayofprevmonth),extractyear(firstdayofprevmonth));
        datefin:=FormatoCeros(DaysPerMonth(extractyear(firstdayofprevmonth),ExtractMonth(firstdayofprevmonth)),2)+'/'+FormatoCeros(ExtractMonth(firstdayofprevmonth),2)+'/'+inttostr(extractyear(firstdayofprevmonth))+' 23:59:59';
        InicializoSerie;
        aPunto:='1';
        doEstadisticaEncuestas(dateini, datefin, aPunto, fSerie.serie, borrar);
        FTmp.Temporizar(FALSE,FALSE,'', '');
        Application.ProcessMessages;
        PutTitulo;
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


procedure TfrmEstadisticasEncSatis.FormCreate(Sender: TObject);
begin
borrar:=true;
imprimiendotodos:=false;
bErrorCreando := False;
  if (not MyBD.InTransaction) then MyBD.StartTransaction(TD);
    try
      LoockAndDeleteTable(MyBD, 'TTMPESTAD_ENCUESTAS');
      PutFechaPunto;
      CHEncuestas.AutoRefresh:=true;
    except
        on E:Exception do
        begin
          MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
          bErrorCreando := True
        end
    end;
end;


procedure TfrmEstadisticasEncSatis.FormDestroy(Sender: TObject);
var
I:Integer;
begin
  QTTMPESTAD.Close;
//    try
//      try
//        if MyBD.InTransaction then
//          MyBD.Rollback(td)
//        else
//          raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del Análisis de Encuestas')
//     except
//        on E: Exception do
//          begin
// -         FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'Error cerrando la ficha de UFEstadisticasEncSatis: %s', [E.message]);
//            MessageDlg('Generación de Informes.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
//          end
//      end
//    finally
      For I:=0 to 7 do
      Begin
      if FileExists(NOM_DIR+NOM_TMP+IntToStr(I)+'.bmp') then
      DeleteFile(NOM_DIR+NOM_TMP+IntToStr(I)+'.bmp');
      end;
      FTmp.Temporizar(FALSE,FALSE,'','');
//      if assigned(fSerie) then fSerie.free;
//      if assigned(fPreguntas) then fPreguntas.Free;
//    end
end;


procedure TfrmEstadisticasEncSatis.PutSumaryResults;
begin
  try
    with QTTMPESTAD do
      begin
        Close;
        SetProvider(dspQTTMPESTAD);
        sdsQTTMPESTAD.SQLConnection := MyBD;
        commandtext := format('SELECT MES, MUYSATIS, SATISFAC, ALGOINSA, INSATISF, SUM3Y4, LIMITE, PUNTO, DevuelvePuntoEnc(PUNTO, %s) SPUNTO, ORDEN FROM TTMPESTAD_ENCUESTAS',[fSerie.serie])+
        ' order by PUNTO, ORDEN ';
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
  seAno.value:=ExtractYear(IncMonth(now,-1));
end;


procedure TfrmEstadisticasEncSatis.btnSalirClick(Sender: TObject);
begin
  FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
  close;
end;


procedure TfrmEstadisticasEncSatis.btnImprimirClick(Sender: TObject);
var
I: Integer;
begin
Todos:=0;
if DoSeleccionaPunto(todos) = mrcancel then
  begin
    exit;
  end;
  case todos of
  0: begin
     Screen.Cursor:=crHourGlass;
      try
        With ChEncuestas do
          Begin
            BevelInner:=BvNone;
            BevelOuter:=BvNone;
            Gradient.Visible:=false;
            SaveToBitmapFile(NOM_DIR+NOM_TMP+'1.bmp');
            BevelInner:=BvLowered;
            BevelOuter:=BvRaised;
            Gradient.Visible:=true;
            ABREVIA:='Punto: '+dbcbPunto.Value+'. '+fPreguntas.Abrevia;
            NROFORM:=fSerie.Nom_F_Impr;
            EstadisticasPrevias;
          end;
      finally
        Screen.Cursor:=crDefault;
        Application.ProcessMessages;
      end;
     end;

  1,2:begin
    With ChEncuestas do
      Begin
      BevelInner:=BvNone;
      BevelOuter:=BvNone;
      Screen.Cursor:=crHourGlass;
       Try
       fPreguntas.first;
       dbcbPunto.Value:=fpreguntas.NroPregunta;

        For I:=1 To 7 do
          Begin
          dbcbPunto.Value:=fpreguntas.NroPregunta;
          PutSumaryResults;
          doEstadisticaEncuestas(dateini, datefin, fpreguntas.NroPregunta, fSerie.serie, borrar);
          PutTitulo;
          Gradient.Visible:=False;
          SaveToBitmapFile(NOM_DIR+NOM_TMP+IntToStr(I)+'.bmp');
          Gradient.Visible:=true;
          fPreguntas.Next;
          end;
          DeleteTable(MyBD, 'TTMPESTAD_ENCUESTAS');
          Borrar:=false;
          For I:=0 To 7 do
          Begin
            doEstadisticaEncuestas(dateini, datefin, IntToStr(I), fSerie.serie, borrar);
          end;
          borrar:=true;
          NROSERIE:=StrToInt(fSerie.serie);
          case Todos of
          1: EstadisticasPreviasAll;
          2: EstadisticasPDF;
          end;
       Finally
        Screen.Cursor:=crDefault;
        Application.ProcessMessages;
       end;
      end;
    end;
  end;
end;


procedure TfrmEstadisticasEncSatis.btnAceptarClick(Sender: TObject);
begin
  if not imprimiendotodos then FTmp.Temporizar(TRUE,FALSE,'Análisis de Encuestas', 'Generando el informe Estadística de Encuestas.');
  Application.ProcessMessages;
  dateini:=FechaInicio(cbMes.itemindex+1,seAno.value);
  datefin:=FormatoCeros(DaysPerMonth(seAno.value,cbMes.itemindex+1),2)+'/'+FormatoCeros(cbMes.itemindex+1,2)+'/'+inttostr(seAno.value)+' 23:59:59';
  InicializoSerie;
  aPunto:=fpreguntas.NroPregunta;
  doEstadisticaEncuestas(dateini, datefin, aPunto, fSerie.serie, borrar);
  PutTitulo;
  if not imprimiendotodos then FTmp.Temporizar(FALSE,FALSE,'', '');
  Application.ProcessMessages;
end;


procedure TfrmEstadisticasEncSatis.PutTitulo;
begin
  application.ProcessMessages;
  CHEncuestas.Title.Text.clear;
  CHEncuestas.Title.Text.Add('GRÁFICO PARA ANÁLISIS DE ENCUESTAS');
  CHEncuestas.Title.Text.Add('Punto: '+fpreguntas.NroPregunta+'. '+fpreguntas.abrevia+'  -  Planta: '+NumeroEstacion+' - '+NombreEstacion);
  ChEncuestas.Title.Text.Add('');
  application.ProcessMessages;
  PutSumaryResults;
  application.ProcessMessages;
end;


procedure TfrmEstadisticasEncSatis.btnTablaClick(Sender: TObject);
begin
 DoDatosEstadEncuesta('Punto: '+fpreguntas.NroPregunta+'. '+fpreguntas.abrevia+'  -  Planta: '+NumeroEstacion+' - '+NombreEstacion);
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
  Abrevia:= fPreguntas.Abrevia;
  ChEncuestas.Foot.Text.Strings[0] := fSerie.Nom_F_Impr;
end;


procedure TfrmEstadisticasEncSatis.SpeedItem1Click(Sender: TObject);
begin
doSeleccionarPlanta;
PutEstacion;
doEstadisticaEncuestas(dateini, datefin, aPunto, fSerie.serie, borrar);
PutTitulo;
end;

end.
