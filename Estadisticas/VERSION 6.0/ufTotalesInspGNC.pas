unit ufTotalesInspGNC;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  Dialogs, Grids, MXGRID, ExtCtrls, MXPIVSRC, MXDB, DB, DBTables, MXTABLES,
  Mxstore, StdCtrls, globals, ucdialgs, uUtils, Buttons, comobj;

type
  TfrmTotalesInspGNC = class(TForm)
    Panel1: TPanel;
    degrinsp: TDecisionGrid;
    decuinsp: TDecisionCube;
    dequinsp: TDecisionQuery;
    desuinsp: TDecisionSource;
    depiinsp: TDecisionPivot;
    btnSalir: TBitBtn;
    btnExportar: TBitBtn;
    OpenDialog: TOpenDialog;
    procedure btnSalirClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    dateini, datefin : string;
  end;
  procedure GeneratePlanillaTotalesGNC;
  procedure DoPlanillaTotalesGNC(aDateIni, aDateFin:string );

var
  frmTotalesInspGNC: TfrmTotalesInspGNC;

implementation

uses
  uGetDates;

{$R *.dfm}

procedure GeneratePlanillaTotalesGNC;
begin

        with TfrmTotalesInspGNC.Create(Application) do
        try
            try
                If not GetDates(DateIni,DateFin) then Exit;

                Caption := Format('Planilla Inspecciones GNC (%S - %S) ', [Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                Application.ProcessMessages;

                DoPlanillaTotalesGNC(DateIni, DateFin);

                dequinsp.DatabaseName := bdag.DatabaseName;
                dequinsp.SessionName := bdag.SessionName;
                dequinsp.Open;

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

procedure DoPlanillaTotalesGNC(aDateIni, aDateFin: string);
begin
    DeleteTable(bdag, 'TTMP_RECHAZOS_INSPGNC');
    with tquery.Create(nil) do
      try
        DatabaseName := BDAG.DatabaseName;
        SessionName := BDAG.SessionName;
        sql.Add('ALTER SESSION SET NLS_DATE_FORMAT = ''DD/MM/YYYY HH24:MI:SS''');
        ExecSQL;
      finally
        free;
      end;

    with TStoredProc.Create(nil) do
    try
        DataBaseName := bdag.DataBaseName;
        SessionName := bdag.SessionName;
        StoredProcName := 'LIST_RECHAZOS_GNC';

        Prepare;
        ParamByName('FI').Value := aDateIni;
        ParamByName('FF').Value := aDateFin;
        ExecProc;

        Close;
    finally
        Free
    end;
end;


procedure TfrmTotalesInspGNC.btnSalirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmTotalesInspGNC.btnExportarClick(Sender: TObject);
var
    i,j, col : integer;
    ExcelApp, ExcelLibro, ExcelHoja: Variant;

const
  FFECH = 6;
  FSEM = 3; CSEM = 1;
  CTS1 = 4;  CTN1=7;
  CTS2 = 11; CTN2=14;

begin

  if OpenDialog.Execute then   // para seleccionar el archivo
  begin

    decuinsp.CurrentSummary := 0;
    degrinsp.Refresh;

    ExcelApp := CreateOleObject('Excel.Application');
    ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
    ExcelHoja := ExcelLibro.Worksheets['Hoja1'];
    ExcelApp.Visible := True;

    for j := 0 to degrinsp.RowCount - 3  do
    begin
      col := 1;
      for i := 0 to degrinsp.ColCount - 3 do
      begin
        if j = 0 then
        begin
          excelHoja.cells[j+7,col+1].value := decuinsp.GetSummaryName(0);
          excelHoja.cells[j+8,col+1].value := degrinsp.Cells[i,j];
        end
        else
          excelHoja.cells[j+8,col+1].value := degrinsp.Cells[i,j];
        col := col+2;
      end;

    end;

    decuinsp.CurrentSummary := 1;
    degrinsp.Refresh;

    with tquery.Create(nil) do
      try
        databasename := bdag.DatabaseName;
        sessionname := bdag.SessionName;
        sql.Add('SELECT DISTINCT(LTRIM(RTRIM(SUBSTR(MES,5,13)))), FECHA FROM TTMP_RECHAZOS_INSPGNC ORDER BY FECHA');
        open;
        first;
        col := 2;
        while not eof do
        begin
          excelHoja.cells[FFECH,COL].value := fields[0].asstring;
          COL := COL+2;
          next;
        end;
          excelHoja.cells[FFECH,COL].value := 'ANUAL';
      finally
        free;
      end;


    for j := 0 to degrinsp.RowCount - 3 do
    begin
      col := 2;
      for i := 0 to degrinsp.ColCount - 3 do
      begin
        if j = 0 then
        begin
           excelHoja.cells[j+7,col+1].value := decuinsp.GetSummaryName(1);
           excelHoja.cells[j+8,col+1].value := degrinsp.Cells[i,j];
        end
        else
           excelHoja.cells[j+8,col+1].value := degrinsp.Cells[i,j];
        col := col+2;
      end;
    end;

    excelHoja.cells[FSEM,CSEM].value := 'Al '+copy(datefin,1,10);

  end;
end;

end.
