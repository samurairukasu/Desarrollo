unit ufPlanillaSemanalVTV;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  Dialogs, Grids, ExtCtrls, StdCtrls, globals, ucdialgs, uUtils, Buttons, comobj, FMTBcd,
  DBXpress, SqlExpr, FxPivSrc, FxGrid, FxDB, FxCommon, FxStore, Provider,
  DBClient, DB;
type
  TfrmPlanillaSemanalVTV = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edDiasTranscurridos: TEdit;
    edDiasFaltan: TEdit;
    edMediaDiaria: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edAcumSemAnterior: TEdit;
    edAcumMensual: TEdit;
    edPrevisto: TEdit;
    Bevel1: TBevel;
    btnSalir: TBitBtn;
    btnExportar: TBitBtn;
    OpenDialog: TOpenDialog;
    edAcumSemAnteriorT: TEdit;
    edAcumMensualT: TEdit;
    edPrevistoT: TEdit;
    edMediaDiariaTotal: TEdit;
    edMediaDiariaReves: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    edAcumMensualAnt: TEdit;
    Label9: TLabel;
    edPrimAnoAnterior: TEdit;
    edTotalAnoAnterior: TEdit;
    sdsverif: TSQLDataSet;
    cdsverifc: TClientDataSet;
    dsdverific: TDataSetProvider;
    decuinsp: TFxCube;
    desuverific: TFxSource;
    desuacum: TFxSource;
    cdsacum: TClientDataSet;
    sdsacum: TSQLDataSet;
    decuacu: TFxCube;
    dspacum: TDataSetProvider;
    FxPivot1: TFxPivot;
    FxPivot3: TFxPivot;
    degrinsp: TFxGrid;
    degracum: TFxGrid;
    SQLConnection1: TSQLConnection;
    procedure btnSalirClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
  private
    { Private declarations }
    procedure PutTotales;
  public
    { Public declarations }
    dateini, datefin,
    DiasTranscurridos, DiasFaltan, MediaDiaria, AcumSemAnterior, AcumMensual,
    Previsto, AcumSemAnteriorT, AcumMensualT,
    PrevistoT, MediaDiariaTotal, MediaDiariaReves, AcumMensualAnt,
    PrimAnoAnterior, TotalAnoAnterior : string;
  end;
  procedure GeneratePlanillaSemanalVTV;
  procedure DoPlanillaSemanalVTV(aDateIni, aDateFin:string; var aDiasTranscurridos, aDiasFaltan,
    aMediaDiaria, aAcumSemAnterior, aAcumMensual, aPrevisto,
    aAcumSemAnteriorT, aAcumMensualT, aPrevistoT, aMediaDiariaTotal, aMediaDiariaReves,
    aAcumMensualAnt, aPrimAnoAnterior, aTotalAnoAnterior:string);

var
  frmPlanillaSemanalVTV: TfrmPlanillaSemanalVTV;

implementation

uses
  uGetDates;

{$R *.dfm}

procedure GeneratePlanillaSemanalVTV;
begin

        with TfrmPlanillaSemanalVTV.Create(Application) do
        try
            try
                If not GetDates(DateIni,DateFin) then Exit;

                Caption := Format('Planilla Inspecciones VTV (%S - %S) ', [Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                Application.ProcessMessages;

                DoPlanillaSemanalVTV(DateIni, DateFin, DiasTranscurridos, DiasFaltan,
                    MediaDiaria, AcumSemAnterior, AcumMensual, Previsto,
                    AcumSemAnteriorT, AcumMensualT, PrevistoT, MediaDiariaTotal, MediaDiariaReves, AcumMensualAnt, PrimAnoAnterior, TotalAnoAnterior);

                cdsverifc.Close;
                cdsacum.Close;
                sdsverif.SQLConnection:=  BDAG;
                sdsacum.SQLConnection:=  BDAG;

                PutTotales;

                Application.ProcessMessages;

                sdsverif.Open;
                cdsverifc.Open;
                decuinsp.Active := TRUE;

                sdsacum.Open;
                cdsacum.Open;
                decuacu.Active := TRUE;


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

procedure DoPlanillaSemanalVTV(aDateIni, aDateFin:string; var aDiasTranscurridos, aDiasFaltan,
    aMediaDiaria, aAcumSemAnterior, aAcumMensual, aPrevisto,
    aAcumSemAnteriorT, aAcumMensualT, aPrevistoT, aMediaDiariaTotal, aMediaDiariaReves,
    aAcumMensualAnt, aPrimAnoAnterior, aTotalAnoAnterior:string);
begin
    DeleteTable(bdag, 'INFORME_INSPVTV');
    DeleteTable(bdag, 'RESUMEN_INSPVTV');
    with tsqlquery.Create(application) do
      try
        SQLConnection := BDAG;
        sql.Add('ALTER SESSION SET NLS_DATE_FORMAT = ''DD/MM/YYYY HH24:MI:SS''');
        ExecSQL;
      finally
        free;
      end;

    aDiasTranscurridos := '0';  aDiasFaltan:= '0'; aMediaDiaria:= '0';
    aAcumSemAnterior:= '0'; aAcumMensual:= '0'; aPrevisto:= '0';
    aAcumSemAnteriorT:= '0'; aAcumMensualT:= '0'; aPrevistoT:= '0';
    aMediaDiariaTotal := '0'; aMediaDiariaReves := '0';
    aAcumMensualAnt := '0'; aPrimAnoAnterior:='0'; aTotalAnoAnterior:='0';


        with TsqlStoredProc.Create(application) do
    try
         SQLConnection :=BDAG;
         StoredProcName := 'LIST_INFORME_INSPVTV'  ;
         ParamByName('FI').Value := aDateIni;
         ParamByName('FF').Value := aDateFin ;
         ExecProc;

        aDiasTranscurridos := ParamByName('aDiasTranscurridos').AsString;
        aDiasFaltan:= ParamByName('aDiasFaltan').AsString;
        aMediaDiaria:= floattostrf(ParamByName('MediaDiaria').AsFloat,fffixed,8,2);
        aAcumSemAnterior:= ParamByName('AcumSemAnterior').AsString;
        aAcumMensual:= ParamByName('AcumMensual').AsString;
        aPrevisto:= floattostrf(ParamByName('Previsto').AsFloat,fffixed,8,2);
        aAcumSemAnteriorT:= ParamByName('AcumSemAnteriorTotal').AsString;
        aAcumMensualT:= ParamByName('AcumMensualTotal').AsString;
        aPrevistoT:= floattostrf(ParamByName('PrevistoTotal').AsFloat,fffixed,8,2);
        aMediaDiariaTotal := floattostrf(ParamByName('MediaDiariaTotal').AsFloat,fffixed,8,2);
        aMediaDiariaReves := floattostrf(ParamByName('MediaDiariaReves').AsFloat,fffixed,8,2);
        aAcumMensualAnt:= ParamByName('AcumMensualAnt').AsString;
        aPrimAnoAnterior := ParamByName('PrimAnoAnterior').AsString;
        aTotalAnoAnterior := ParamByName('TotalAnoAnterior').AsString;
        Close;
    finally
        Free
    end;
end;

procedure TfrmPlanillaSemanalVTV.PutTotales;
begin

        MediaDiaria := inttostr(ROUND(strtofloat(MediaDiaria)));
        MediaDiariaTotal := inttostr(ROUND(strtofloat(MediaDiariaTotal)));
        MediaDiariaReves := inttostr(ROUND(strtofloat(MediaDiariaReves)));
        Previsto := inttostr(ROUND(strtofloat(Previsto)));
        PrevistoT := inttostr(ROUND(strtofloat(PrevistoT)));


        edDiasTranscurridos.text := DiasTranscurridos;
        edDiasFaltan.text:= DiasFaltan;
        edMediaDiaria.text:= MediaDiaria;
        edAcumSemAnterior.text:= AcumSemAnterior;
        edAcumMensual.text:= AcumMensual;
        edPrevisto.text:= Previsto;
        edAcumSemAnteriorT.text:= AcumSemAnteriorT;
        edAcumMensualT.text:= AcumMensualT;
        edPrevistoT.text:= PrevistoT;
        edMediaDiariaTotal.text := MediaDiariaTotal;
        edMediaDiariaReves.text := MediaDiariaReves;
        edAcumMensualAnt.text:= AcumMensualAnt;
        edPrimAnoAnterior.Text := PrimAnoAnterior;
        edTotalAnoAnterior.Text := TotalAnoAnterior;

end;

procedure TfrmPlanillaSemanalVTV.btnSalirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmPlanillaSemanalVTV.btnExportarClick(Sender: TObject);
var
    i,j, col : integer;
    ExcelApp, ExcelLibro, ExcelHoja: Variant;

const
  FFECH = 5;
  FSEM = 2; CSEM = 12;
  CTS1 = 4;  CTN1=7;
  CTS2 = 11; CTN2=14;

begin

  if OpenDialog.Execute then   // para seleccionar el archivo
  begin

    decuinsp.CurrentSummary := 0;
    degrinsp.Refresh;
    decuacu.CurrentSummary := 1;
    degracum.Refresh;

    ExcelApp := CreateOleObject('Excel.Application');
    ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
    ExcelHoja := ExcelLibro.Worksheets['Hoja1'];
    ExcelApp.Visible := True;

    for j := 0 to degrinsp.RowCount - 3  do
    begin
      col := 1;
      for i := 0 to degrinsp.ColCount - 4 do
      begin
        if j = 0 then
        begin
          excelHoja.cells[j+6,col+1].value := '1º Inspecc';
          excelHoja.cells[j+7,col+1].value := FloatToStrF(StrToFloat(degrinsp.Cells[i,j]),fffixed,8,0);
        end
        else
          excelHoja.cells[j+7,col+1].value := FloatToStrF(StrToFloat(degrinsp.Cells[i,j]),fffixed,8,0);
        col := col+2;
      end;
      if j = 0 then
      begin
         excelHoja.cells[j+6,col+1].value := 'Verific';
         excelHoja.cells[j+7,col+2].value := FloatToStrF(StrToFloat(degracum.Cells[0,j]),fffixed,8,0);
      end
      else
         excelHoja.cells[j+7,col+2].value := FloatToStrF(StrToFloat(degracum.Cells[0,j]),fffixed,8,0);
    end;

    decuinsp.CurrentSummary := 1;
    degrinsp.Refresh;
    decuacu.CurrentSummary := 0;
    degracum.Refresh;
    with tsqlquery.Create(application) do
      try
        SQLConnection := BDAG;
        sql.Add('SELECT DISTINCT (STRFECHA), FECHA FROM INFORME_INSPVTV ORDER BY FECHA');
        open;
        first;
        col := 2;
        while not eof do
        begin
          excelHoja.cells[FFECH,COL].value := fields[0].asstring;
          COL := COL+2;
          next;
        end;
          excelHoja.cells[FFECH,COL].value := 'Total';
          COL := COL+2;
          excelHoja.cells[FFECH,COL].value := 'Acum 1º a la Fecha';
      finally
        free;
      end;

    for j := 0 to degrinsp.RowCount - 3 do
    begin
      col := 2;
      for i := 0 to degrinsp.ColCount - 4 do
      begin
        if j = 0 then
        begin
           excelHoja.cells[j+6,col+1].value :='Total';
           excelHoja.cells[j+7,col+1].value := FloatToStrF(StrToFloat(degrinsp.Cells[i,j]),fffixed,8,0) ;
        end
        else
           excelHoja.cells[j+7,col+1].value := FloatToStrF(StrToFloat(degrinsp.Cells[i,j]),fffixed,8,0);
        col := col+2;
      end;
      if j = 0 then
      begin
        excelHoja.cells[j+6,col+1].value := 'Reves';
        excelHoja.cells[j+7,col].value := FloatToStrF(StrToFloat(degracum.Cells[0,j]),fffixed,8,0);
      end
      else
        excelHoja.cells[j+7,col].value := FloatToStrF(StrToFloat(degracum.Cells[0,j]),fffixed,8,0);
    end;

    j:=j+9;
    excelHoja.cells[j,CTS1].value := 'Días Transcurridos';
    excelHoja.cells[j,CTN1].value := edDiasTranscurridos.TEXT;
    excelHoja.cells[j,CTS2].value := 'Acum. semanas anteriores';
    excelHoja.cells[j,CTN2].value := edAcumSemAnterior.TEXT;
    excelHoja.cells[j,CTN2+1].value := edAcumSemAnteriorT.TEXT;

    inc(j);
    excelHoja.cells[j,CTS1].value := 'Días que faltan';
    excelHoja.cells[j,CTN1].value := edDiasFaltan.TEXT;
    excelHoja.cells[j,CTS2].value := 'Acum. mes';
    excelHoja.cells[j,CTN2].value := edAcumMensual.TEXT;
    excelHoja.cells[j,CTN2+1].value := edAcumMensualt.TEXT;

    inc(j);
    excelHoja.cells[j,CTS1].value := 'Media diaria 1º Inspección';
    excelHoja.cells[j,CTN1].value := edMediaDiaria.TEXT;
    excelHoja.cells[j,CTS2].value := 'Previsto fin de mes';
    excelHoja.cells[j,CTN2].value := edPrevisto.TEXT;
    excelHoja.cells[j,CTN2+1].value := edPrevistot.TEXT;

    inc(j);
    excelHoja.cells[j,CTS1].value := 'Media diaria Total';
    excelHoja.cells[j,CTN1].value := edMediaDiariaTotal.TEXT;
    excelHoja.cells[j,CTS2].value := 'Mes Año Anterior';
    excelHoja.cells[j,CTN2].value := edPrimAnoAnterior.TEXT;
    excelHoja.cells[j,CTN2+1].value := edTotalAnoAnterior.TEXT;


    inc(j);
    excelHoja.cells[j,CTS1].value := 'Media diaria Reves';
    excelHoja.cells[j,CTN1].value := edMediaDiariaReves.TEXT;
    excelHoja.cells[j,CTN2].value := edAcumMensualAnt.TEXT;

    excelHoja.cells[FSEM,CSEM].value := 'Semana del '+copy(dateini,1,10)+' al '+copy(datefin,1,10);

  end;
end;

end.
