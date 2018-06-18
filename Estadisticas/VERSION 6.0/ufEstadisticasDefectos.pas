unit ufEstadisticasDefectos;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  Dialogs, Grids,  ExtCtrls, DB,  StdCtrls, globals, ucdialgs, uUtils, Buttons, comobj, FMTBcd,
  DBClient, Provider, SqlExpr, FxGrid, FxPivSrc, FxDB, FxCommon, FxStore;

type
  TfrmEstadisticasDefectos = class(TForm)
    Panel1: TPanel;
    btnSalir: TBitBtn;
    btnExportar: TBitBtn;
    OpenDialog: TOpenDialog;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    sdsdefe: TSQLDataSet;
    dspdefe: TDataSetProvider;
    cdsdefe: TClientDataSet;
    decudefe: TFxCube;
    desudefe: TFxSource;
    sdsincr: TSQLDataSet;
    dspincr: TDataSetProvider;
    cdsincr: TClientDataSet;
    decuincr: TFxCube;
    desuincr: TFxSource;
    degrdefe: TFxGrid;
    degrincr: TFxGrid;
    FxPivot1: TFxPivot;
    FxPivot2: TFxPivot;
    procedure btnSalirClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
  private
    { Private declarations }
    function TextoTotal(aValor : string):string;
    function TextoCero(aValor : string):string;
  public
    { Public declarations }
    dateini, datefin: string;
  end;
  procedure GenerateEstadDefectos;
  procedure DoEstadDefectos(aDateIni, aDateFin:string);

var
  frmEstadisticasDefectos: TfrmEstadisticasDefectos;

implementation

uses
  uGetDates, uftmp;

{$R *.dfm}

procedure GenerateEstadDefectos;
begin

        with TfrmEstadisticasDefectos.Create(Application) do
        try
            try
                If not GetDates(DateIni,DateFin) then Exit;

                Caption := Format('Estadística de Defectos (%S - %S) ', [Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                Application.ProcessMessages;

                FTmp.Temporizar(TRUE,FALSE,'Estadística de Defectos', 'Generando el informe Estadística de Defectos.  Este informe puede llevar varias horas');
                Application.ProcessMessages;

                DoEstadDefectos(DateIni, DateFin);

                FTmp.Temporizar(FALSE,FALSE,'', '');
                Application.ProcessMessages;

                cdsdefe.Close;
                cdsincr.Close;
                sdsdefe.SQLConnection:=  MyBD;
                sdsincr.SQLConnection:=  MyBD;

                Application.ProcessMessages;

                sdsincr.Open;
                cdsincr.Open;
                decuincr.Active := TRUE;

                sdsdefe.Open;
                cdsdefe.Open;
                decudefe.Active := TRUE;

                label2.caption := datetimetostr(time);
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

procedure DoEstadDefectos(aDateIni, aDateFin:string);
begin
    DeleteTable(MyBD, 'TTMP_DEFECTXCAP');
    DeleteTable(MyBD, 'TTMP_INSPECCYR');

    with TsqlStoredProc.Create(nil) do
    try
        SQLConnection:= MyBD;
        StoredProcName := 'ESTADISTICADEFECTOS_APPLUS.DEFECTOS_APPLUS';

        ParamByName('FI').Value := FormatDateTime('ddmmyyyy',strtodatetime(aDateini));
        ParamByName('FF').Value := FormatDateTime('ddmmyyyy',strtodatetime(aDateFin));
        ExecProc;

        Close;
    finally
        Free
    end;
end;


procedure TfrmEstadisticasDefectos.btnSalirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmEstadisticasDefectos.btnExportarClick(Sender: TObject);
var
    i,j, col : integer;
    ExcelApp, ExcelLibro, ExcelHoja: Variant;
const
  FPLA = 5;  FFEC = 3;  CFEC = 1;
  FINI = 10;
  FSEM = 2;  CSEM = 1;
  CTS1 = 4;  CTN1=7;
  CTS2 = 11; CTN2=14;

begin

  if OpenDialog.Execute then   // para seleccionar el archivo
  begin

   // decudefe.CurrentSummary := 0;
  //  degrdefe.Refresh;

    ExcelApp := CreateOleObject('Excel.Application');
    ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
    ExcelHoja := ExcelLibro.Worksheets['Hoja1'];
    ExcelApp.Visible := True;

    excelHoja.cells[FFEC,CFEC].value := 'Desde: '+copy(dateini,1,10)+' - Hasta: '+copy(datefin,1,10);

    col := 3;
    for i := 0 to degrincr.ColCount - 1 do
    begin
        excelHoja.cells[FINI-3,col].value := degrincr.Cells[i,0];
        col := col+2;
    end;

    for j := 0 to degrdefe.RowCount - 4  do
    begin
      col := 2;
      if (degrdefe.Cells[-2,j] <> 'Sum') and (degrdefe.Cells[-1,j] <> 'Sum') then
      begin
        excelHoja.cells[j+FINI,col].value := TextoTotal(degrdefe.Cells[-1,j]);
        excelHoja.cells[j+FINI,col-1].value := TextoTotal(degrdefe.Cells[-2,j]);

        for i := 0 to degrdefe.ColCount - 3 do
        begin
          if j = 0 then
          begin
          //  excelHoja.cells[j+FINI-1,col+1].value := decudefe.GetSummaryName(0);
            excelHoja.cells[j+FINI,col+1].value := TextoCero(ConvierteComaEnPunto(degrdefe.Cells[i,j]));
          end
          else
          begin
            excelHoja.cells[j+FINI,col+1].value := TextoCero(ConvierteComaEnPunto(degrdefe.Cells[i,j]));
          end;
          col := col+2;
        end;
      end;

    end;

    decudefe.CurrentSummary := 1;
    degrdefe.Refresh;

    with tsqlquery.Create(nil) do
      try
        SQLConnection:=MyBD;
        sql.Add('SELECT INITCAP(LOWER(NOMBRE)) FROM TTMP_INSPECCYR ORDER BY ZONA,ESTACION');
        open;
        first;
        col := 3;
        while not eof do
        begin
          if not (col in [11,27]) then
          begin
            excelHoja.cells[FPLA,COL].value := fields[0].asstring;
            next;
          end
          else
            excelHoja.cells[FPLA,COL].value := 'Total';
          COL := COL+2;
        end;
        for j := 0 to 1 do
        begin
          excelHoja.cells[FPLA,COL].value := 'Total';
          COL := COL+2;
        end;

      finally
        free;
      end;


    for j := 0 to degrdefe.RowCount - 4 do
    begin
      col := 4;
      if (degrdefe.Cells[-2,j] <> 'Sum') and (degrdefe.Cells[-1,j] <> 'Sum') then
        for i := 0 to degrdefe.ColCount - 3 do
        begin
          if j = 0 then
          begin
            // excelHoja.cells[j+FINI-1,col].value := decudefe.GetSummaryName(1);
             if not (col in [12,28,38,40]) then
               excelHoja.cells[j+FINI,col].value := TextoCero(ConvierteComaEnPunto(degrdefe.Cells[i,j]));
          end
          else
             if not (col in [12,28,38,40]) then
               excelHoja.cells[j+FINI,col].value := TextoCero(ConvierteComaEnPunto(degrdefe.Cells[i,j]));
          col := col+2;
        end;
    end;


//    excelHoja.cells[FSEM,CSEM].value := 'Al '+copy(datefin,1,10);

  end;
end;

function TfrmEstadisticasDefectos.TextoTotal(aValor: string): string;
begin
  result := aValor;
  if aValor = 'Sum' then result := 'Total';
end;

function TfrmEstadisticasDefectos.TextoCero(aValor: string): string;
begin
  result := aValor;
  if aValor = '' then result := '0';
end;

end.
