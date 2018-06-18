unit ufPlanillaResumenVTV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SpeedBar, ExtCtrls, ucDialgs, uUtils, globals, DB,  DBXpress, SqlExpr,
  Provider,
  DBClient,
  Grids, DBGrids, uSagClasses, uSagEstacion, comobj, StdCtrls, Buttons, xlconst,
  DBTables, FMTBcd;

type
  TfrmPlanillaResumenVTV = class(TForm)
    SpeedBar1: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    btnSalir: TSpeedItem;
    grResumen: TDBGrid;
    dsResumen: TDataSource;
    btnExportar: TSpeedItem;
    OpenDialog: TOpenDialog;
    btnRecaudacion: TSpeedItem;
    grRecauda: TDBGrid;
    dsRecauda: TDataSource;
    btnAceptar: TBitBtn;
    grtotales: TDBGrid;
    dstotales: TDataSource;
    qResumenMensual: TClientDataSet;
    sdsrepmensual: TSQLDataSet;
    Dsprepmensual: TDataSetProvider;
    qTotales: TClientDataSet;
    sdstotales: TSQLDataSet;
    Dsptotales: TDataSetProvider;
    procedure btnSalirClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRecaudacionClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
  private
    { Private declarations }
    ExcelApp, ExcelLibro, ExcelHoja: Variant;
    fResumen : tResumen_Mensual;
    procedure ExportaPlanta(planta : string);
    procedure ExportaTotal(aZona : string);
  public
    { Public declarations }
    dateini, datefin: string;
  end;
  procedure GeneratePlanillaResumenVTV;
  procedure DoPlanillaResumenVTV(aDateIni, aDateFin:string);

var
  frmPlanillaResumenVTV: TfrmPlanillaResumenVTV;

implementation

{$R *.dfm}
uses
  uGetDates;

const
  claveBloqueo = 'Sesamo@GraniX';

procedure GeneratePlanillaResumenVTV;
begin
        with TfrmPlanillaResumenVTV.Create(Application) do
        try
            try
                If not GetDates(DateIni,DateFin) then Exit;

                Caption := Format('Planilla Resumen Inspecciones VTV (%S - %S) ', [Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                Application.ProcessMessages;

                DoPlanillaResumenVTV(DateIni, DateFin);

                Application.ProcessMessages;
                ShowModal;

            except
                on E: Exception do
                begin
                    Application.ProcessMessages;
                    MessageDlg(Caption, 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)
                end
            end
        finally
            Free;
            Application.ProcessMessages;
        end;

end;

procedure DoPlanillaResumenVTV(aDateIni, aDateFin:string);
begin
     with tsqlquery.Create(application) do
      try
        SQLConnection := BDAG;
        sql.Add('ALTER SESSION SET NLS_DATE_FORMAT = ''DD/MM/YYYY HH24:MI:SS''');
        ExecSQL;
      finally
        free;
      end;

    with TSqlStoredProc.Create(nil) do
    try
        SQLConnection := BDAG;
        StoredProcName := 'REPORTE_MENSUALVTV';
        ParamByName('FI').Value := aDateIni;
        ParamByName('FF').Value := aDateFin;
        ExecProc;

        Close;
    finally
        Free
    end;

end;

procedure TfrmPlanillaResumenVTV.btnSalirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmPlanillaResumenVTV.btnExportarClick(Sender: TObject);
var fPlanta : tplantas;
    fZona : tZonas;
    fsql:tstringlist;
begin
  try
    try
      opendialog.Title := 'Seleccione la Planilla de Entrada';
      if OpenDialog.Execute then
      begin
//        FTmp.Temporizar(TRUE,FALSE,'Libro IVA de Ventas', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);

        fPlanta := tplantas.CreatePlantas(BDAG);
        fPlanta.Open;
        fPlanta.First;
        fsql:= tStringList.Create();
        while not fPlanta.Eof do
        begin
          with qResumenMensual do
          begin
            Close;
            sdsrepmensual.SQLConnection  := BDAG;
            fSQL.Add('SELECT mes,SUM(CANTPRI) CANTPRI,SUM(CANTREVE) CANTREVE,SUM(CANTOTAL) CANTOTAL,'+
            'SUM(MEDIA) MEDIA,sum(RECAUDACION) RECAUDACION,SUM(CANTAPTOS) CANTAPTOS,SUM(CANTCOND) CANTCOND,SUM(CANTRECH) CANTRECH '+
            'FROM REPORTE_MENSUAL '+
            format('where zona = %s and planta = %s ',[fplanta.ValueByName[FIELD_IDZONA],fplanta.ValueByName[FIELD_NROPLANTA]])+
            'group by mes order by mes');

            commandtext :=fsql.text;
            open;
            exportaplanta(fplanta.ValueByName[FIELD_IDZONA]+fplanta.ValueByName[FIELD_NROPLANTA]);
          end;
          fPlanta.Next;
        end;

        fZona := tZonas.Create(BDAG);
        fZona.Open;

        fZona.First;
        while not fZona.Eof do
        begin
          with qResumenMensual do
          begin
            fsql.Clear;
            Close;
            sdsrepmensual.SQLConnection  := BDAG;
            fSQL.Add('SELECT mes,SUM(CANTPRI) CANTPRI,SUM(CANTREVE) CANTREVE,SUM(CANTOTAL) CANTOTAL,'+
            'SUM(MEDIA) MEDIA,sum(RECAUDACION) RECAUDACION,SUM(CANTAPTOS) CANTAPTOS,SUM(CANTCOND) CANTCOND,SUM(CANTRECH) CANTRECH '+
            'FROM REPORTE_MENSUAL '+
            format('where zona = %s ',[fZona.ValueByName[FIELD_IDZONA]])+
            'group by mes order by mes');
            commandtext :=fsql.text;
            open;
            exportaplanta('Zona '+fZona.ValueByName[FIELD_IDZONA]);
          end;
          with qTotales do
          begin
            fsql.Clear;
            Close;
            sdstotales.SQLConnection  := BDAG;
            fSQL.Add('SELECT ANIO,ENERO, FEBRERO, MARZO, ABRIL, MAYO, JUNIO, JULIO, AGOSTO, '+
            'SEPTIEMBRE, OCTUBRE, NOVIEMBRE, DICIEMBRE, TOTAL '+
            'FROM VERIFICACIONES_ANUALES '+
            format('where zona = %s ',[fZona.ValueByName[FIELD_IDZONA]])+
            'order by anio');
            commandtext :=fsql.text;
            open;
            ExportaTotal('Zona '+fZona.ValueByName[FIELD_IDZONA]+' (1 VERIF)');
          end;


          fZona.Next;
        end;

          with qResumenMensual do
          begin
            fsql.Clear;
            Close;
            sdsrepmensual.SQLConnection  := BDAG;
            fSQL.Add('SELECT mes,SUM(CANTPRI) CANTPRI,SUM(CANTREVE) CANTREVE,SUM(CANTOTAL) CANTOTAL,'+
            'SUM(MEDIA) MEDIA,sum(RECAUDACION) RECAUDACION,SUM(CANTAPTOS) CANTAPTOS,SUM(CANTCOND) CANTCOND,SUM(CANTRECH) CANTRECH '+
            'FROM REPORTE_MENSUAL '+
            'group by mes order by mes');
            commandtext :=fsql.text;
            open;
            exportaplanta('General');
          end;
          with qTotales do
          begin
             fsql.Clear;
            Close;
            sdstotales.SQLConnection  := BDAG;
            fSQL.Add('SELECT ANIO,SUM(ENERO) ENERO, SUM(FEBRERO) FEBRERO, SUM(MARZO) MARZO, SUM(ABRIL)ABRIL, '+
            'SUM(MAYO) MAYO, SUM(JUNIO) JUNIO, SUM(JULIO) JULIO, SUM(AGOSTO) AGOSTO, '+
            'SUM(SEPTIEMBRE) SEPTIEMBRE, SUM(OCTUBRE) OCTUBRE, SUM(NOVIEMBRE) NOVIEMBRE, SUM(DICIEMBRE) DICIEMBRE, SUM(TOTAL) TOTAL '+
            'FROM VERIFICACIONES_ANUALES '+
            'group by anio order by anio');
            commandtext :=fsql.text;
            open;
            ExportaTotal('COMPARATIVA DE 1 VERIF. ANUALES');
          end;


        ExcelHoja := ExcelLibro.Worksheets['Recaudaciones'];
        ExcelHoja.protect(claveBloqueo);
        ExcelHoja := ExcelLibro.Worksheets['Gráficos Recaudaciones'];
        ExcelHoja.protect(claveBloqueo);


      end;
      opendialog.Title := 'Seleccione la Planilla de Salida';
      if OpenDialog.Execute then
         excellibro.saveas(opendialog.filename);
      ExcelApp.Quit;
    except
            on E: Exception do
            begin
//                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de UIVABook: %s', [E.message]);
                MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
            end
    end;
  finally
    application.ProcessMessages;
    fPlanta.Close;
    fPlanta.Free;
    fZona.Close;
    fZona.Free;
  end;
end;

procedure TfrmPlanillaResumenVTV.ExportaPlanta(planta : string);
const

    F_INI = 8;  C_INI = 2;
var
    i,f : integer;
begin

        ExcelHoja := ExcelLibro.Worksheets[PLANTA];
        ExcelHoja.unprotect(claveBloqueo);

        f:= F_INI;

        qResumenMensual.First;
        while not qResumenMensual.EOF do
        begin
            for i := 0 to grResumen.Columns.Count - 1 do
            begin
                  excelHoja.cells[f,i+2] := conviertecomaenpunto(qResumenMensual.FieldByName(grResumen.Columns[i].FieldName).AsString)
            end;
            qResumenMensual.Next;
            inc(f);
        end;
        qResumenMensual.First;
        ExcelHoja.protect(claveBloqueo);

end;

procedure TfrmPlanillaResumenVTV.FormCreate(Sender: TObject);
begin
    with qResumenMensual do
    begin
      sdsrepmensual.SQLConnection  := BDAG;
    end;
    with qTotales do
    begin
      sdstotales.SQLConnection  := BDAG;
    end;

end;

procedure TfrmPlanillaResumenVTV.btnRecaudacionClick(Sender: TObject);
begin
  fResumen := tResumen_Mensual.CreateByMes(BDAG,copy(dateini,4,2));
  fResumen.Open;
  dsRecauda.DataSet := fResumen.DataSet;
  grRecauda.Visible:= true;
end;

procedure TfrmPlanillaResumenVTV.FormDestroy(Sender: TObject);
begin
  if assigned(fResumen) then fResumen.Free;
end;

procedure TfrmPlanillaResumenVTV.btnAceptarClick(Sender: TObject);
begin
  if fResumen.DataSet.State in [dsinsert, dsedit] then
    fResumen.Post;
  grRecauda.Visible := false;
end;

procedure TfrmPlanillaResumenVTV.ExportaTotal(aZona: string);
const
    F_INI = 6;  C_INI = 1;
var
    i,f : integer;
begin

        ExcelHoja := ExcelLibro.Worksheets[azona];
        ExcelHoja.unprotect(claveBloqueo);        

        f:= F_INI;

        qTotales.First;
        while not qTotales.EOF do
        begin
            for i := 0 to grtotales.Columns.Count - 1 do
            begin
                  excelHoja.cells[f,i+1] := conviertecomaenpunto(qTotales.FieldByName(grtotales.Columns[i].FieldName).AsString)
            end;
            qTotales.Next;
            inc(f);
        end;
        qTotales.First;
      ExcelHoja.protect(claveBloqueo);        

end;

end.
