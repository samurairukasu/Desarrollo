unit ufPlanillaSemanal;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  Dialogs, Grids, ExtCtrls, StdCtrls, globals, ucdialgs, uUtils, Buttons, comobj, FMTBcd,
  DBXpress, SqlExpr, FxPivSrc, FxGrid, FxDB, FxCommon, FxStore, Provider,
  DBClient, DB;

type
  TfrmPlanillaSemanal = class(TForm)
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
    decuverific: TFxCube;
    desuverific: TFxSource;
    degriverific: TFxGrid;
    FxPivot1: TFxPivot;
    desuacum: TFxSource;
    cdsacum: TClientDataSet;
    dspacum: TDataSetProvider;
    sdsacum: TSQLDataSet;
    degriacum: TFxGrid;
    FxPivot3: TFxPivot;
    decuacum: TFxCube;
    Label10: TLabel;
    edMediaDiariaPesos: TEdit;
    edPrevistoPesos: TEdit;
    Label11: TLabel;
    edAcumMensualenPesos: TEdit;
    Label12: TLabel;
    procedure btnSalirClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);

  private
    { Private declarations }
    //procedure GeneraExcelRegion13;
   // procedure GeneraExcelRegion9;
    procedure PutTotales;
  public
    { Public declarations }
    dateini, datefin,
    DiasTranscurridos, DiasFaltan, MediaDiaria, AcumSemAnterior, AcumMensual,
    Previsto, AcumSemAnteriorT, AcumMensualT, MediaDiariaPesos, PrevistoPesos,
    PrevistoT, MediaDiariaTotal, MediaDiariaReves, AcumMensualAnt, AcumMensualenPesos,
    PrimAnoAnterior, TotalAnoAnterior : string;
  end;
  procedure GeneratePlanillaSemanal;
  procedure DoPlanillaSemanal(aDateIni, aDateFin:string; var aDiasTranscurridos, aDiasFaltan,
    aMediaDiaria, aAcumSemAnterior, aAcumMensual, aPrevisto, aMediaDiariaPesos, aPrevistoPesos,aAcumMensualenPesos,
    aAcumSemAnteriorT, aAcumMensualT, aPrevistoT, aMediaDiariaTotal, aMediaDiariaReves,
    aAcumMensualAnt, aPrimAnoAnterior, aTotalAnoAnterior:string);

var
  frmPlanillaSemanal: TfrmPlanillaSemanal;
  region :String;
implementation

uses
  uGetDates;

{$R *.dfm}

procedure GeneratePlanillaSemanal;
begin

        with TfrmPlanillaSemanal.Create(Application) do
        try
            try
                If not GetDates(DateIni,DateFin) then Exit;

                Caption := Format('Planilla Inspecciones VTV (%S - %S) ', [Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                Application.ProcessMessages;

                DoPlanillaSemanal(DateIni, DateFin, DiasTranscurridos, DiasFaltan,
                    MediaDiaria, AcumSemAnterior, AcumMensual, Previsto, MediaDiariaPesos, PrevistoPesos,AcumMensualenPesos,
                    AcumSemAnteriorT, AcumMensualT, PrevistoT, MediaDiariaTotal, MediaDiariaReves, AcumMensualAnt, PrimAnoAnterior, TotalAnoAnterior);

                cdsverifc.Close;
                cdsacum.Close;
                sdsverif.SQLConnection:=  BDAG;
                sdsacum.SQLConnection:=  BDAG;

                PutTotales;

                Application.ProcessMessages;

                sdsverif.Open;
                cdsverifc.Open;
                decuverific.Active := TRUE;

                sdsacum.Open;
                cdsacum.Open;
                decuacum.Active := TRUE;


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

procedure DoPlanillaSemanal(aDateIni, aDateFin:string; var aDiasTranscurridos, aDiasFaltan,
    aMediaDiaria, aAcumSemAnterior, aAcumMensual, aPrevisto, aMediaDiariaPesos, aPrevistoPesos,aAcumMensualenPesos,
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
    aAcumMensualenPesos:='0'; aMediaDiariaPesos:='0'; aPrevistoPesos:='0';

    with TsqlStoredProc.Create(application) do
    try

          SQLConnection :=BDAG;
         StoredProcName := 'LIST_INFORME_INSPVTV'  ;
         ParamByName('FI').Value := copy(aDateIni,1,10);
         ParamByName('FF').Value := copy(aDateFin,1,10);
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

procedure TfrmPlanillaSemanal.PutTotales;
begin

        MediaDiaria := inttostr(ROUND(strtofloat(MediaDiaria)));
        MediaDiariaTotal := inttostr(ROUND(strtofloat(MediaDiariaTotal)));
        MediaDiariaReves := inttostr(ROUND(strtofloat(MediaDiariaReves)));
        MediaDiariaPesos := inttostr(ROUND(strtofloat(MediaDiariaPesos)));
        Previsto := inttostr(ROUND(strtofloat(Previsto)));
        PrevistoPesos := inttostr(ROUND(strtofloat(PrevistoPesos)));
        PrevistoT := inttostr(ROUND(strtofloat(PrevistoT)));


        edDiasTranscurridos.text := DiasTranscurridos;
        edDiasFaltan.text:= DiasFaltan;
        edMediaDiaria.text:= MediaDiaria;
        edMediaDiariaPesos.text:= MediaDiariaPesos;
        edAcumSemAnterior.text:= AcumSemAnterior;
        edAcumMensual.text:= AcumMensual;
        edAcumMensualenPesos.text:= AcumMensualenPesos;
        edPrevisto.text:= Previsto;
        edPrevistoPesos.text := PrevistoPesos;
        edAcumSemAnteriorT.text:= AcumSemAnteriorT;
        edAcumMensualT.text:= AcumMensualT;
        edPrevistoT.text:= PrevistoT;
        edMediaDiariaTotal.text := MediaDiariaTotal;
        edMediaDiariaReves.text := MediaDiariaReves;
        edAcumMensualAnt.text:= AcumMensualAnt;
        edPrimAnoAnterior.Text := PrimAnoAnterior;
        edTotalAnoAnterior.Text := TotalAnoAnterior;

end;

procedure TfrmPlanillaSemanal.btnSalirClick(Sender: TObject);
begin
  close;
end;
procedure TfrmPlanillaSemanal.btnExportarClick(Sender: TObject);
begin
    if Region = '13' then
      //GeneraExcelRegion13
    else
     //GeneraExcelRegion9;
end;
end.
