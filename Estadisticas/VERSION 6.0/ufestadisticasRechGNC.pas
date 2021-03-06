unit ufestadisticasRechGNC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB, DBTables, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar,DBClient, Provider, SqlExpr, FMTBcd;//, UDDEExcelObject;

type
  TFrmEstadisticasRechGNC = class(TForm)
    Label6: TLabel;
    ti: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    Print: TSpeedItem;
    Excel: TSpeedItem;
    SBBusqueda: TSpeedItem;
    SBSalir: TSpeedItem;
    DSourceArqueoCaja: TDataSource;
    DBGFidelizacion: TDBGrid;
    sdsQTTMPLISTDESCUENTOS: TSQLDataSet;
    dspQTTMPLISTDESCUENTOS: TDataSetProvider;
    QTTMPLISTDESCUENTOS: TClientDataSet;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PutSumaryResults;
    procedure PrintClick(Sender: TObject);
    procedure SBBusquedaClick(Sender: TObject);
    procedure SBSalirClick(Sender: TObject);
    procedure ExcelClick(Sender: TObject);
    procedure OnOpen (Sender: TObject);
    procedure OnClose (Sender: TObject);
  public
    { Public declarations }
    bErrorCreando : boolean;
    NombreEstacion, NumeroEstacion,
    TipoPago,
    DateIni, DateFin,
    NumeroFacturas,
    aTipoCliente : string;
  end;

  procedure GenerateListRechGNC;
  procedure DoListRechGNC(const FI,FF: string );

var
  FrmEstadisticasRechGNC: TFrmEstadisticasRechGNC;
  sTipo_Auxi: string;

implementation

{$R *.DFM}


uses
   UCDIALGS,
   UUTILS,
   UGETDATES,
//   ULOGS,
   GLOBALS,
   UFListadoEstadisticaRechGNC,
//   UFINFORMESDIALOGPRINT,
//   UFINFORMESDIALOGASCII,
//   UFINFORMESDIALOGEXCEL,
   UFTMP,
//   USAGESTACION,
   USAGVARIOS;
//   USAGCLASSES;


resourcestring
    FICHERO_ACTUAL = 'UFListadoFidelizacion.PAS';


procedure DoListRechGNC(const FI,FF :string);

begin
    DeleteTable(BDAG, 'TTMP_RECH_VUELVEN_GNC');

     with TSQLStoredProc.Create(nil) do
    try
        SQLConnection := BDAG;
        StoredProcName := 'DO_RECHAZ_VUELVEN_GNC';
        Prepared := true;
        ParamByName('FECHAINI').Value := COPY(FI,1,10);
        {sumo 1 a la fecha fin, porque en el procedimiento de oracle se armaba quilombo
        y estuve mucho rato y no salia, asi que aunque esto es horrible lo deje asi}
        ParamByName('FECHAFIN').Value := COPY(datetimetostr(strtodatetime(FF)+1),1,10);

        ExecProc;

        Close;
    finally
        Free
    end
end;


procedure GenerateListRechGNC;
begin

        with TFrmEstadisticasRechGNC.Create(Application) do
        try
            try
                if bErrorCreando then exit;

                If not GetDates(DateIni,DateFin) then Exit;

                Caption := Format('Listado de Porcentaje Rechazados GNC que vuelven. (%S - %S)', [Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                FTmp.Temporizar(TRUE,FALSE,'Listado de Porcentaje de Fidelización', 'Generando el informe Porcentaje Rechazados GNC que vuelven.');
                Application.ProcessMessages;

                DoListRechGNC(DateIni, DateFin);

                FTmp.Temporizar(FALSE,FALSE,'', '');
                Application.ProcessMessages;

                PutSumaryResults;
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

procedure TFrmEstadisticasRechGNC.FormCreate(Sender: TObject);
begin
    bErrorCreando := False;

    if (not BDAG.InTransaction) then BDAG.StartTransaction(td);

    with tsqlquery.Create(nil) do
      try
        SQLConnection:=BDAG;
        sql.add('ALTER SESSION SET NLS_DATE_FORMAT = ''DD/MM/YYYY''');
        execsql;
      finally
        free;
      end;

    try
        LoockAndDeleteTable(BDAG, 'TTMP_RECH_VUELVEN_GNC')
    except
        on E:Exception do
        begin
            MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
            bErrorCreando := True
        end
    end
end;

procedure TFrmEstadisticasRechGNC.FormDestroy(Sender: TObject);
begin
    QTTMPLISTDESCUENTOS.Close;

    try
        try
            if BDAG.InTransaction then BDAG.Rollback(td)//  MyBD.Commit
            else raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del Listado de Fidelización')
        except
            on E: Exception do
            begin
                MessageDlg('Generación de Informes.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end
        end
    finally
        FTmp.Temporizar(FALSE,FALSE,'','');
    end
end;


procedure TFrmEstadisticasRechGNC.PutSumaryResults;
begin
    try

        with QTTMPLISTDESCUENTOS do
        begin
            Close;
           sdsQTTMPLISTDESCUENTOS.SQLConnection:=BDAG;
           CommandText:='SELECT CODIGO_ZONA, ESTACION, CANTRECH, ' +
                    'CANTVOLV, PORCENTAJE ' +
                    'FROM TTMP_RECH_VUELVEN_GNC ORDER BY CODIGO_ZONA, ESTACION ';
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTDESCUENTOS);
            {$ENDIF}

            Open;
        end
    finally
        Application.ProcessMessages;
    end;
end;


procedure TFrmEstadisticasRechGNC.PrintClick(Sender: TObject);
begin
                    with TFEstadisticaREchGNCToPrint.Create(Application) do
                    try
                        Execute(DateIni, DateFin, NumeroFacturas, NombreEstacion, NumeroEstacion, aTipoCliente);
                    finally
                        Free;
                    end;
end;

procedure TFrmEstadisticasRechGNC.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try

            If Not GetDates(DateIni,DateFin) Then Exit;
            Caption := Format('Listado de Porcentaje Rechazados GNC que vuelven. (%S - %S)', [Copy(DateIni,1,10), Copy(DateFin,1,10)]);
            FTmp.Temporizar(TRUE,FALSE,'Listado de Porcentaje Rechazados GNC que vuelven','Generando el informe de Porcentaje Rechazados GNC que vuelven.');
            Application.ProcessMessages;

            DoListRechGNC(DateIni, DateFin);

            FTmp.Temporizar(FALSE,FALSE,'','');
            Application.ProcessMessages;

            PutSumaryResults;

        except
            on E: Exception do
            begin
                FTmp.Temporizar(FALSE,FALSE,'','');
                MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo' , mtError, [mbOk], mbOk, 0);
            end
        end
    finally
        Enabled := True;
        Show;
        Application.ProcessMessages
    end
end;

procedure TFrmEstadisticasRechGNC.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure TFrmEstadisticasRechGNC.ExcelClick(Sender: TObject);
//var
//    ExcelExporter : TDDEExcelObject;
begin
{    with TFExcelDialog.Create(Self) do
    try
        if ShowModal = mrOk
        then begin
            case ExportarExcel of

                teeGeneral:
                begin
                    ExcelExporter := nil;
                    try
                        ExcelExporter:=TDDEExcelObject.CreateFromMethod(ExportacionExcelGeneral);
                        try
                            ExcelExporter.OnOpen := Self.OnOpen;
                            ExcelExporter.OnClose := Self.OnClose;
                            if not ExcelExporter.Execute
                            then MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
                        except
                            MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
                        end;
                    finally
                        if Assigned(ExcelExporter)
                        then ExcelExporter.Free;
                        FTmp.Temporizar(FALSE,FALSE,'','');
                    end;
                end;

                teeResumen:
                begin
                    ExcelExporter := nil;
                    try
                        ExcelExporter:=TDDEExcelObject.CreateFromMethod(ExportacionExcelResumen);
                        try
                            ExcelExporter.OnOpen := Self.OnOpen;
                            ExcelExporter.OnClose := Self.OnClose;
                            if not ExcelExporter.Execute
                            then MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
                        except
                            MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
                        end;
                    finally
                        if Assigned(ExcelExporter)
                        then ExcelExporter.Free;
                        FTmp.Temporizar(FALSE,FALSE,'','');
                    end;
                end;

                else begin

                    ShowMessage('Exportación','Primero realizará la exportación General');

                    ExcelExporter := nil;
                    try
                        ExcelExporter:=TDDEExcelObject.CreateFromMethod(ExportacionExcelGeneral);
                        try
                            ExcelExporter.OnOpen := Self.OnOpen;
                            ExcelExporter.OnClose := Self.OnClose;
                            if not ExcelExporter.Execute
                            then MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
                        except
                            MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
                        end;
                    finally
                        if Assigned(ExcelExporter)
                        then ExcelExporter.Free;
                        FTmp.Temporizar(FALSE,FALSE,'','');
                    end;

                    ShowMessage('Exportación','Ahora exportará el Resumen');

                    ExcelExporter := nil;
                    try
                        ExcelExporter:=TDDEExcelObject.CreateFromMethod(ExportacionExcelResumen);
                        try
                            ExcelExporter.OnOpen := Self.OnOpen;
                            ExcelExporter.OnClose := Self.OnClose;
                            if not ExcelExporter.Execute
                            then MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
                        except
                            MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
                        end;
                    finally
                        if Assigned(ExcelExporter)
                        then ExcelExporter.Free;
                        FTmp.Temporizar(FALSE,FALSE,'','');
                    end;
                end;
            end;
       end;
    finally
        Free;
    end;}
end;


{function TFrmListadoDescuentos.ExportacionExcelGeneral(ExcelClient: TDDEExcelObject): Boolean;
const
    F_TTL = 1;   C_TTL = 4;
    F_STT = 2;   C_STT = 4;
    F_TPG = 6;   C_TPG = 2;
    F_NFA = 8;   C_NFA = 2;
    F_NAB = 9;   C_NAB = 2;
    F_INI = 11;

    C_LTT = 10;
    C_TIM = 11;
    C_IVA = 12;
    C_IVN = 13;
    C_TTO = 14;
var
    i,f : integer;
    fTiposCliente: TTiposCliente;
begin
    Result := True;
    f:= F_INI;
    ExcelClient.Put(F_TTL,C_TTL,'Arqueo de Caja de Facturas con Descuento');
    ExcelClient.Put(F_STT,C_STT,Format('Estación nş: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]));
    ExcelClient.Put(F_TPG,C_TPG,'GLOBAL');
    ExcelClient.Put(F_NFA,C_NFA,EdtTotalFacturas.Text);
    ExcelClient.Put(F_NAB,C_NAB,EdtTotalNotasCredito.Text);

    QTTMPLISTDESCUENTOS.First;
    while not QTTMPLISTDESCUENTOS.EOF do
    begin
        for i := 0 to DBGridArqueoCaja.Columns.Count - 1 do
            ExcelClient.Put(f,i+1,QTTMPLISTDESCUENTOS.FieldByName(DBGridArqueoCaja.Columns[i].FieldName).AsString);
        QTTMPLISTDESCUENTOS.Next;
        inc(f);
    end;
    QTTMPLISTDESCUENTOS.First;

    if f=F_INI
    then f := f + 1;

    ExcelClient.Put(f,C_LTT,'TOTALES');
    ExcelClient.Put(f,C_TIM,EdtTotalImporte.Text);
    ExcelClient.Put(f,C_IVA,EdtTotalIVA.Text);
    ExcelClient.Put(f,C_IVN,EdtTotalIVANOInscripto.Text);
    ExcelClient.Put(f,C_TTO,EdtTotalTotal.Text);
end;}

procedure TFrmEstadisticasRechGNC.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TFrmEstadisticasRechGNC.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;

{function TFrmListadoDescuentos.ExportacionExcelResumen(ExcelClient: TDDEExcelObject): Boolean;
const
    F_TTL = 1;   C_TTL = 3;
    F_STT = 2;   C_STT = 3;
    F_TPG = 6;   C_TPG = 2;
    F_INI = 9;

    C_TPC = 1;
    C_NFA = 2;
    C_NAB = 3;
    C_IMP = 4;
    C_IVA = 5;
    C_IVN = 6;
    C_TOT = 8;
var
    i,f : integer;
    fTiposCliente: TTiposCliente;
begin
    result := True;
    with TFSumaryCaja.CreateFromDescuentos(Application) do
    try
//        ExcelClient.Put(F_TTL,C_TTL,'Resumen por Tipos de Cliente');
        ExcelClient.Put(F_STT,C_STT,Format('Estación nş: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]));
        ExcelClient.Put(F_TPG,C_TPG,'GLOBAL');

        f := F_INI;
        for i := 0 to SG.RowCount - 1 do
        begin
            ExcelClient.Put(f,C_TPC,SG.Cells[0,i]);
            ExcelClient.Put(f,C_NFA,SG.Cells[1,i]);
            ExcelClient.Put(f,C_NAB,SG.Cells[2,i]);
            ExcelClient.Put(f,C_IMP,SG.Cells[3,i]);
            ExcelClient.Put(f,C_IVA,SG.Cells[4,i]);
            ExcelClient.Put(f,C_IVN,SG.Cells[5,i]);
            ExcelClient.Put(f,C_TOT,SG.Cells[6,i]);
            inc(f)
        end;
    finally
        Free;
    end;
end;}

end.


