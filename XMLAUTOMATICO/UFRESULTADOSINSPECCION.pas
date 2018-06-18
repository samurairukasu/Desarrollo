unit UFRESULTADOSINSPECCION;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, RXLookup, ComCtrls, USAGESTACION, quickrpt, RXDBCtrl, ComObj,
  FMTBcd, DBClient, Provider, SqlExpr, Dialogs, DBXpress;

type
// ALTER TABLE TTMPRESINSP MODIFY (NUMOBLEA NULL)
// ALTER TABLE TTMPRESINSP MODIFY (FECHALTA VARCHAR2(10));


  TFResultadosInspeccion = class(TForm)
    SBarPrincipal: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    Print: TSpeedItem;
    Ascci: TSpeedItem;
    BExcel: TSpeedItem;
    SBBusqueda: TSpeedItem;
    SBSalir: TSpeedItem;
    DSTResultadosInspeccion: TDataSource;
    DBReVerificaciones: TRxDBGrid;
    sdsQTResultadosInspeccion: TSQLDataSet;
    dspQTResultadosInspeccion: TDataSetProvider;
    QTResultadosInspeccion: TClientDataSet;
    OpenDialog: TOpenDialog;
    SQLQuery1: TSQLQuery;
    SQLConnection1: TSQLConnection;
    SpeedbarSection4: TSpeedbarSection;
    SpeedItem1: TSpeedItem;
    procedure FormCreate(Sender: TObject);
    procedure SBBusquedaClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AscciClick(Sender: TObject);
    procedure BExcelClick(Sender: TObject);
    procedure OnOpen (Sender: TObject);
    procedure OnClose (Sender: TObject);
    procedure SBSalirClick(Sender: TObject);
    procedure SpeedItem1Click(Sender: TObject);
  private
    { Private declarations }
     procedure DoInformesDeInspeccion;

     Procedure  ExportacionExcelGeneral;
  public
    { Public declarations }
      bErrorCreando : boolean;
      NombreEstacion, NumeroEstacion,
      DateIni, DateFin, tiempoProm, tiempototal : string;
      function PutEstacion : string;
       procedure DoInformesDeInspeccion_prueba;
  end;

    procedure GenerateInformesDeInspeccion;

  var
    FResultadosInspeccion: TFResultadosInspeccion;

implementation

{$R *.DFM}


uses
   UCDIALGS, ULOGS,
   UINSPECTIONRESULTS,
   UGETDATES,
   UFTMP,
   GLOBALS,
   UUTILS,
   USAGVARIOS,Ubuscar_inspeccion_por_patente;



resourcestring
      FICHERO_ACTUAL = 'UFResultadosInspeccion';

    procedure GenerateInformesDeInspeccion;
    begin
        with TFResultadosInspeccion.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                If not GetDates(DateIni,DateFin) then Exit;
                Caption := Format('Informes de Inspección. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                FTmp.Temporizar(TRUE,FALSE,'Informes de Inspección', 'Generando el informe informes de inspección.');

                Application.ProcessMessages;

                DoInformesDeInspeccion;

                QTResultadosInspeccion.Open;

                FTmp.Temporizar(FALSE,FALSE,'', '');
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

    function TFResultadosInspeccion.PutEstacion : string;
    begin
        NombreEstacion := fVarios.NombreEstacion;
        NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
        Result := NumeroEstacion + ' ' + NombreEstacion;
    end;

    procedure TFResultadosInspeccion.DoInformesDeInspeccion;
    begin
        DeleteTable(MyBD, 'TTMPRESINSP');

        {agregamos el alter session porque sino saltaba error en el procedimiento al
         calcular la menor fecha}
        with tsqlquery.create(self) do       //
        try
          SQLConnection := mybd;
          sql.add('alter session set nls_date_format = ''dd/mm/yyyy hh24:mi:ss''');
          execsql;
        finally
          free;
        end;

        with TSQLStoredProc.Create(self) do
        try
            SQLConnection := MyBD;
            StoredProcName := 'PQ_RI_VTV.DOINFORMESINSPECCION';

            ParamByName('TIEMPOPROMEDIO').Value := 0;
            ParamByName('TIEMPOTOTALPROMEDIO').Value := 0;
            Prepared := true;
            ParamByName('FECHAINI').Value := DateIni;
            ParamByName('FECHAFIN').Value := DateFin;
            ExecProc;
            tiempoprom:=ParamByName('TIEMPOPROMEDIO').value;
            tiempototal:=ParamByName('TIEMPOTOTALPROMEDIO').value;

            with tsqlquery.create(self) do       //
            try
             SQLConnection := mybd;

(* hago los siguientes try porque en algunos oracle no acepta con coma y en otros
   no acepta con punto *)


             sql.add(format('SELECT LTRIM(TO_CHAR(TRUNC(SYSDATE)+''%S'',''HH24:MI:SS'')) FROM DUAL',[ConvierteComaEnPtoMasDec(tiempoprom)]));
             try
               open;
             except
               sql.clear;
               sql.add(format('SELECT LTRIM(TO_CHAR(TRUNC(SYSDATE)+''%S'',''HH24:MI:SS'')) FROM DUAL',[tiempoprom]));
               open;
             end;

             tiempoprom:=fields[0].value;
             close;
             sql.Clear;
             sql.add(format('SELECT LTRIM(TO_CHAR(TRUNC(SYSDATE)+''%S'',''HH24:MI:SS'')) FROM DUAL',[ConvierteComaEnPtoMasDec(tiempototal)]));
             try
               open;
             except
               sql.Clear;
               sql.add(format('SELECT LTRIM(TO_CHAR(TRUNC(SYSDATE)+''%S'',''HH24:MI:SS'')) FROM DUAL',[tiempototal]));
               open;
             end;

             tiempototal:=fields[0].value;
            finally
              free;
            end;
            Close;
        finally
            Free
        end;
    end;


     procedure TFResultadosInspeccion.DoInformesDeInspeccion_prueba;
    begin
        DeleteTable(MyBD, 'TTMPRESINSP');

        {agregamos el alter session porque sino saltaba error en el procedimiento al
         calcular la menor fecha}
        with tsqlquery.create(self) do       //
        try
          SQLConnection := mybd;
          sql.add('alter session set nls_date_format = ''dd/mm/yyyy hh24:mi:ss''');
          execsql;
        finally
          free;
        end;

        with TSQLStoredProc.Create(self) do
        try
            SQLConnection := MyBD;
            StoredProcName := 'PQ_RI_VTV.DOINFORMESINSPECCION';

            ParamByName('TIEMPOPROMEDIO').Value := 0;
            ParamByName('TIEMPOTOTALPROMEDIO').Value := 0;
            Prepared := true;
            ParamByName('FECHAINI').Value := DateIni;
            ParamByName('FECHAFIN').Value := DateFin;
            ExecProc;
            tiempoprom:=ParamByName('TIEMPOPROMEDIO').value;
            tiempototal:=ParamByName('TIEMPOTOTALPROMEDIO').value;

            with tsqlquery.create(self) do       //
            try
             SQLConnection := mybd;

(* hago los siguientes try porque en algunos oracle no acepta con coma y en otros
   no acepta con punto *)


             sql.add(format('SELECT LTRIM(TO_CHAR(TRUNC(SYSDATE)+''%S'',''HH24:MI:SS'')) FROM DUAL',[ConvierteComaEnPtoMasDec(tiempoprom)]));
             try
               open;
             except
               sql.clear;
               sql.add(format('SELECT LTRIM(TO_CHAR(TRUNC(SYSDATE)+''%S'',''HH24:MI:SS'')) FROM DUAL',[tiempoprom]));
               open;
             end;

             tiempoprom:=fields[0].value;
             close;
             sql.Clear;
             sql.add(format('SELECT LTRIM(TO_CHAR(TRUNC(SYSDATE)+''%S'',''HH24:MI:SS'')) FROM DUAL',[ConvierteComaEnPtoMasDec(tiempototal)]));
             try
               open;
             except
               sql.Clear;
               sql.add(format('SELECT LTRIM(TO_CHAR(TRUNC(SYSDATE)+''%S'',''HH24:MI:SS'')) FROM DUAL',[tiempototal]));
               open;
             end;

             tiempototal:=fields[0].value;
            finally
              free;
            end;
            Close;
        finally
            Free
        end;
    end;



    procedure TFResultadosInspeccion.FormCreate(Sender: TObject);
    begin
        bErrorCreando := False;

        if (not MyBD.InTransaction) then MyBD.StartTransaction(td);
        try
            LoockAndDeleteTable(MyBD, 'TTMPRESINSP');

            QTResultadosInspeccion.Close;
            sdsQTResultadosInspeccion.SQLConnection := MyBD;

        except
            on E:Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
                MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minuts, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
                bErrorCreando := True
            end
        end
    end;


procedure TFResultadosInspeccion.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            If not GetDates(DateIni,DateFin) then Exit;

            FTmp.Temporizar(TRUE,FALSE,'Resultados de Inspección', 'Generando el informe informes de inspección.');

            Application.ProcessMessages;

            Caption := Format('Informes de Inspección. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
            QTResultadosInspeccion.Close;
            DoInformesDeInspeccion;

            QTResultadosInspeccion.Open;

            FTmp.Temporizar(FALSE,FALSE,'', '');

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
        Enabled := True;
        Show;
        Application.ProcessMessages;
    end;
end;

procedure TFResultadosInspeccion.PrintClick(Sender: TObject);
begin
                    with TFInspectionsResults.Create(Application) do
                    try
                        Execute(DateIni,DateFin,PutEstacion,tiempoprom, tiempototal, MyBD);
                    finally
                        Free;
                    end;
end;


procedure TFResultadosInspeccion.FormDestroy(Sender: TObject);
begin
     QTResultadosInspeccion.Close;
     try
        try
            if MyBD.InTransaction then MyBD.Rollback(td) // MyBD.Commit
            else raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del infomre de Resultados de Inspección')
        except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'Error cerrando la ficha de Resultados de Inspección: %s', [E.message]);
                MessageDlg('Generación de Informes.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end
        end
    finally
        FTmp.Temporizar(FALSE,FALSE,'','');
    end
end;

procedure TFResultadosInspeccion.AscciClick(Sender: TObject);
begin
                    with TFInspectionsResults.Create(Application) do
                    try
                        ExportaAscii(DateIni,DateFin,PutEstacion,tiempoprom, tiempototal, MyBD);
                    finally
                        Free;
                    end;
end;

procedure TFResultadosInspeccion.BExcelClick(Sender: TObject);
begin
  ExportacionExcelGeneral;
end;

procedure TFResultadosInspeccion.ExportacionExcelGeneral;
const
    F_TTL = 1;   C_TTL = 5;
    F_STT = 2;   C_STT = 5;
    F_INI = 6;
                 C_TPI = 13;
var
    i,f : integer;
    ExcelApp, ExcelLibro, ExcelHoja: Variant;
begin
  try
    DBReVerificaciones.DataSource.DataSet.DisableControls;
    try
      opendialog.Title := 'Seleccione la Planilla de Entrada';
      if OpenDialog.Execute then
      begin
        FTmp.Temporizar(TRUE,FALSE,'Resumen de Inspección', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        ExcelHoja := ExcelLibro.Worksheets[1];

        f:= F_INI;
        ExcelHoja.Cells[F_TTL,C_TTL].value := 'Resumen de Inspección';
        ExcelHoja.Cells[F_STT,C_STT].value := Format('Planta nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);

        QTRESULTADOSINSPECCION.First;
        while not QTRESULTADOSINSPECCION.EOF do
        begin
            for i := 0 to DBReVerificaciones.Columns.Count - 1 do
              ExcelHoja.Cells[f,i+1].value := QTRESULTADOSINSPECCION.FieldByName(DBReVerificaciones.Columns[i].FieldName).AsString;
            QTRESULTADOSINSPECCION.Next;
            inc(f);
        end;
        QTRESULTADOSINSPECCION.First;

        ExcelHoja.Cells[f+1,C_TPI-2].value := 'Tiempos Promedio:';
        ExcelHoja.Cells[f+1,C_TPI].value := TIEMPOPROM;
        ExcelHoja.Cells[f+1,C_TPI+1].value :=TIEMPOTOTAL;
      end;
      opendialog.Title := 'Seleccione la Planilla de Salida';
      if OpenDialog.Execute then
         excellibro.saveas(opendialog.filename);
      ExcelApp.Quit;
    except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de UfResumenDescuentosGNC: %s', [E.message]);
                MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
            end
    end;
  finally
      DBReVerificaciones.DataSource.DataSet.enableControls;
      FTmp.Temporizar(FALSE,FALSE,'','');
      application.ProcessMessages;
  end;
end;

procedure TFResultadosInspeccion.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TFResultadosInspeccion.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;

procedure TFResultadosInspeccion.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure TFResultadosInspeccion.SpeedItem1Click(Sender: TObject);
var
i:longint;
spatente: string;
encontro:boolean;
begin

with Tbuscar_inspeccion_por_patente.Create(application) do
    try

      showmodal;
   spatente:=trim(edit1.Text);

    finally
      free;
    end;



   if trim(spatente)='' then
       exit;


       encontro:=false;
      DBReVerificaciones.DataSource.DataSet.First;
      for i:=0 to   DBReVerificaciones.DataSource.DataSet.RecordCount -1 do
      begin


       if (trim(DBReVerificaciones.DataSource.DataSet.Fields[5].AsString)=spatente) then
           begin
            encontro:=true;
            DBReVerificaciones.SelectedIndex:=i;
            exit;
           end;

        DBReVerificaciones.DataSource.DataSet.Next;
      end;

      if not encontro then
      begin
      DBReVerificaciones.DataSource.DataSet.First;
       MessageDlg('Buscar Patente',Format('No se encontro la patente ', [spatente]), mterror, [mbOk], mbOK, 0);
      end;

end;


end.







