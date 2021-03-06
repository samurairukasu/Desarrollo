unit UFRESULTADINSPECTIEMPOS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, RXLookup, ComCtrls, USAGESTACION, quickrpt, RXDBCtrl, ComObj,
  FMTBcd, DBClient, Provider, SqlExpr, Dialogs, DBXpress;

type
// ALTER TABLE TTMPRESINSP MODIFY (NUMOBLEA NULL)
// ALTER TABLE TTMPRESINSP MODIFY (FECHALTA VARCHAR2(10));


  TFResultadosTiempos = class(TForm)
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
    procedure FormCreate(Sender: TObject);
    procedure SBBusquedaClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AscciClick(Sender: TObject);
    procedure BExcelClick(Sender: TObject);
    procedure OnOpen (Sender: TObject);
    procedure OnClose (Sender: TObject);
    procedure SBSalirClick(Sender: TObject);
  private
    { Private declarations }
     procedure DoInformesDeInspeccion;
     Procedure  ExportacionExcelGeneral;
  public
    { Public declarations }
      bErrorCreando : boolean;
      NombreEstacion, NumeroEstacion,
      DateIni, DateFin, tiempoProm, tiempototal, tiempototalmaximo, tiempototalminimo,
      TiempoPromedioS1, TiempoMaximoS1, TiempoMinimoS1,
      TiempoPromedioS2, TiempoMaximoS2, TiempoMinimoS2,
      TiempoPromedioS3, TiempoMaximoS3, TiempoMinimoS3 : string;
      function PutEstacion : string;
  end;

    procedure GenerateInformesDeTiempos;

  var
    FResultadosTiempos: TFResultadosTiempos;

implementation

{$R *.DFM}


uses
   UCDIALGS, ULOGS,
   UINSPECTIONRESULTS,
   UGETDATES,
   UFTMP,
   GLOBALS,
   UUTILS,
   USAGVARIOS;
   

resourcestring
      FICHERO_ACTUAL = 'UFResultadosInspeccion';

    procedure GenerateInformesDeTiempos;
    begin
        with TFResultadosTiempos.Create(Application) do
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

    function TFResultadosTiempos.PutEstacion : string;
    begin
        NombreEstacion := fVarios.NombreEstacion;
        NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
        Result := NumeroEstacion + ' ' + NombreEstacion;
    end;

    procedure TFResultadosTiempos.DoInformesDeInspeccion;
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
            StoredProcName := 'PQ_RI_VTV.DoinformestiemposSeccion';

            ParamByName('TIEMPOPROMEDIO').Value := 0;
            ParamByName('TIEMPOTOTALPROMEDIO').Value := 0;
            ParamByName('TIEMPOTOTALMAXIMO').Value := 0;
            ParamByName('TIEMPOTOTALMINIMO').Value := 0;

            ParamByName('TIEMPOPROMEDIOS1').Value := 0;
            ParamByName('TIEMPOMAXIMOS1').Value := 0;
            ParamByName('TIEMPOMINIMOS1').Value := 0;

            ParamByName('TIEMPOPROMEDIOS2').Value := 0;
            ParamByName('TIEMPOMAXIMOS2').Value := 0;
            ParamByName('TIEMPOMINIMOS2').Value := 0;

            ParamByName('TIEMPOPROMEDIOS3').Value := 0;
            ParamByName('TIEMPOMAXIMOS3').Value := 0;
            ParamByName('TIEMPOMINIMOS3').Value := 0;

            Prepared := true;
            ParamByName('FECHAINI').Value := DateIni;
            ParamByName('FECHAFIN').Value := DateFin;
            ExecProc;

            tiempoprom:=ParamByName('TIEMPOPROMEDIO').value;
            tiempototal:=ParamByName('TIEMPOTOTALPROMEDIO').value;
            tiempototalmaximo:=ParamByName('TIEMPOTOTALMAXIMO').value;
            tiempototalminimo:=ParamByName('TIEMPOTOTALMINIMO').value;

            TiempoPromedioS1:=ParamByName('TIEMPOPROMEDIOS1').value;
            TiempoMaximoS1:=ParamByName('TIEMPOMAXIMOS1').value;
            TiempoMinimoS1:=ParamByName('TIEMPOMINIMOS1').value;

            TiempoPromedioS2:=ParamByName('TIEMPOPROMEDIOS2').value;
            TiempoMaximoS2:=ParamByName('TIEMPOMAXIMOS2').value;
            TiempoMinimoS2:=ParamByName('TIEMPOMINIMOS2').value;

            TiempoPromedioS3:=ParamByName('TIEMPOPROMEDIOS3').value;
            TiempoMaximoS3:=ParamByName('TIEMPOMAXIMOS3').value;
            TiempoMinimoS3:=ParamByName('TIEMPOMINIMOS3').value;

            with tsqlquery.create(self) do       //
            try
             SQLConnection := mybd;

(* hago los siguientes try porque en algunos oracle no acepta con coma y en otros no acepta con punto *)

             //tiempoprom
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

           (*//tiempototal
             sql.add(format('SELECT LTRIM(TO_CHAR(TRUNC(SYSDATE)+''%S'',''HH24:MI:SS'')) FROM DUAL',[ConvierteComaEnPtoMasDec(tiempototal)]));
             try
               open;
             except
               sql.Clear;
               sql.add(format('SELECT LTRIM(TO_CHAR(TRUNC(SYSDATE)+''%S'',''HH24:MI:SS'')) FROM DUAL',[tiempototal]));
               open;
             end;

             tiempototal:=fields[0].value;
            *)
            finally
              free;
            end;
            Close;
        finally
            Free
        end;
    end;

    procedure TFResultadosTiempos.FormCreate(Sender: TObject);
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


procedure TFResultadosTiempos.SBBusquedaClick(Sender: TObject);
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

procedure TFResultadosTiempos.PrintClick(Sender: TObject);
begin
                    with TFInspectionsResults.Create(Application) do
                    try
                        Execute(DateIni,DateFin,PutEstacion,tiempoprom, tiempototal, MyBD);
                    finally
                        Free;
                    end;
end;


procedure TFResultadosTiempos.FormDestroy(Sender: TObject);
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

procedure TFResultadosTiempos.AscciClick(Sender: TObject);
begin
                    with TFInspectionsResults.Create(Application) do
                    try
                        ExportaAscii(DateIni,DateFin,PutEstacion,tiempoprom, tiempototal, MyBD);
                    finally
                        Free;
                    end;
end;

procedure TFResultadosTiempos.BExcelClick(Sender: TObject);
begin
  ExportacionExcelGeneral;
end;

procedure TFResultadosTiempos.ExportacionExcelGeneral;
const

    //Titulos Cabecera
    F_TTL = 1;   C_TTL = 5;
    F_STT = 2;   C_STT = 5;

    //Datos
    F_INI = 10;

    //Titulos Cuadros
    //F_TPT = 4;   C_TPT = 1;  //Tiempos Promedio
    //F_TPM = 5;   C_TPM = 1;  //Tiempos Maximo
    //F_TPMN = 6;  C_TPMN = 1; //Tiempos Minimo

    //Valores Cuadros
    F_TPT_R = 5;   C_TPT_R = 7;   //Tiempos Promedio
    F_TPM_R = 6;   C_TPM_R = 7;   //Tiempos Maximo
    F_TPMN_R = 7;   C_TPMN_R = 7; //Tiempos Minimo

    F_TPS1_R = 5;   C_TPS1 = 10;   //Tiempos Promedio S1
    F_TMS1_R = 6;   C_TMS1_R = 10;   //Tiempos Maximo S1
    F_TMNS1_R = 7;   C_TMNS1_R = 10; //Tiempos Minimo S1

    F_TPS2_R = 5;   C_TPS2 = 14;   //Tiempos Promedio S2
    F_TMS2_R = 6;   C_TMS2_R = 14;   //Tiempos Maximo S2
    F_TMNS2_R = 7;   C_TMNS2_R = 14; //Tiempos Minimo S2

    F_TPS3_R = 5;   C_TPS3 = 18;   //Tiempos Promedio S3
    F_TMS3_R = 6;   C_TMS3_R = 18;   //Tiempos Maximo S3
    F_TMNS3_R = 7;   C_TMNS3_R = 18; //Tiempos Minimo S3

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

        //ExcelHoja.Cells[F_TPT,C_TPT].value := 'Tiempos Promedio:';
        //ExcelHoja.Cells[F_TPM,C_TPM].value := 'Tiempos Maximo:';
        //ExcelHoja.Cells[F_TPMN,C_TPMN].value := 'Tiempos Minimo:';

        ExcelHoja.Cells[F_TPT_R,C_TPT_R].value := TIEMPOTOTAL; //Tiempo Total Promedio
        ExcelHoja.Cells[F_TPM_R,C_TPM_R].value := TIEMPOTOTALMAXIMO; //Tiempo Total Maximo
        ExcelHoja.Cells[F_TPMN_R,C_TPMN_R].value := TIEMPOTOTALMINIMO; //Tiempo Total Minimo

        ExcelHoja.Cells[F_TPS1_R,C_TPS1].value := TIEMPOPROMEDIOS1; //Tiempo Promedio S1
        ExcelHoja.Cells[F_TMS1_R,C_TMS1_R].value := TIEMPOMAXIMOS1; //Tiempo Maximo S1
        ExcelHoja.Cells[F_TMNS1_R,C_TMNS1_R].value := TIEMPOMINIMOS1; //Tiempo Minimo S1

        ExcelHoja.Cells[F_TPS2_R,C_TPS2].value := TIEMPOPROMEDIOS2; //Tiempo Promedio S2
        ExcelHoja.Cells[F_TMS2_R,C_TMS2_R].value := TIEMPOMAXIMOS2; //Tiempo Maximo S2
        ExcelHoja.Cells[F_TMNS2_R,C_TMNS2_R].value := TIEMPOMINIMOS2; //Tiempo Minimo S2

        ExcelHoja.Cells[F_TPS3_R,C_TPS3].value := TIEMPOPROMEDIOS3; //Tiempo Promedio S3
        ExcelHoja.Cells[F_TMS3_R,C_TMS3_R].value := TIEMPOMAXIMOS3; //Tiempo Maximo S3
        ExcelHoja.Cells[F_TMNS3_R,C_TMNS3_R].value := TIEMPOMINIMOS3; //Tiempo Minimo S3

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

procedure TFResultadosTiempos.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TFResultadosTiempos.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;

procedure TFResultadosTiempos.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


end.







