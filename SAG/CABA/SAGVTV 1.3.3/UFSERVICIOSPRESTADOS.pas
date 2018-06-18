unit UFSERVICIOSPRESTADOS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DBXpress, DB, SqlExpr, Provider, DBClient, Grids,
  DBGrids, RXDBCtrl, USAGESTACION, SpeedBar, ExtCtrls,
  StdCtrls, Mask, DBCtrls, Buttons,
  RXLookup, ComCtrls, ComObj;

type
  TFServiciosPrestados = class(TForm)
    OpenDialog: TOpenDialog;
    DSTServiciosPrestados: TDataSource;
    QTServiciosPrestados: TClientDataSet;
    dspQTServiciosPrestados: TDataSetProvider;
    sdsQTServiciosPrestados: TSQLDataSet;
    SQLQuery1: TSQLQuery;
    SQLConnection1: TSQLConnection;
    DBServiciosPrestados: TRxDBGrid;
    SBarPrincipal: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    BExcel: TSpeedItem;
    SBBusqueda: TSpeedItem;
    SBSalir: TSpeedItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SBBusquedaClick(Sender: TObject);
    procedure BExcelClick(Sender: TObject);
    procedure OnOpen (Sender: TObject);
    procedure OnClose (Sender: TObject);
    procedure SBSalirClick(Sender: TObject);
  private
     procedure DoReporteADM;
     Procedure ExportacionExcelGeneral;
  public
     bErrorCreando : boolean;
     NombreEstacion, NumeroEstacion, DateIni, DateFin, ServiciosPrestados, ServiciosPendientes : string;
     function PutEstacion : string;
  end;

  procedure GenerateServiciosPrestados;

var
  FServiciosPrestados: TFServiciosPrestados;

implementation

{$R *.dfm}

uses
   UCDIALGS,
   ULOGS,
   UGETDATES,
   UFTMP,
   GLOBALS,
   UUTILS,
   USAGVARIOS;

resourcestring
      FICHERO_ACTUAL = 'UFSERVICIOSPRESTADOS';

procedure GenerateServiciosPrestados;
    begin
        with TFServiciosPrestados.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                If not GetDates(DateIni,DateFin) then Exit;
                Caption := Format('Informe de Servicios Prestados. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                FTmp.Temporizar(TRUE,FALSE,'Informes de Servicios Prestados', 'Generando el informe Servicios Prestados.');

                Application.ProcessMessages;

                DoReporteADM;

                QTServiciosPrestados.Open;

                FTmp.Temporizar(FALSE,FALSE,'', '');
                ShowModal;
            except
                on E: Exception do
                begin
                    FTmp.Temporizar(FALSE,FALSE,'', '');
                    Application.ProcessMessages;
                    FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
                    MessageDlg('Generaci�n de Informe.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)
                end
            end
        finally
            Free;
            Application.ProcessMessages;
        end;
    end;

    function TFServiciosPrestados.PutEstacion : string;
    begin
        NombreEstacion := fVarios.NombreEstacion;
        NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
        Result := NumeroEstacion + ' ' + NombreEstacion;
    end;

    procedure TFServiciosPrestados.DoReporteADM;
    begin
        DeleteTable(MyBD, 'TTMPREPORTEADM');

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
            StoredProcName := 'PQ_REPORTE_ADM.DoReporteADM';

            ParamByName('SERVICIOSPRESTADOS').Value := 0;
            ParamByName('SERVICIOSPENDIENTES').Value := 0;
            Prepared := true;
            ParamByName('FECHAINI').Value := DateIni;
            ParamByName('FECHAFIN').Value := DateFin;
            ExecProc;
            ServiciosPrestados:=ParamByName('SERVICIOSPRESTADOS').value;
            ServiciosPendientes:=ParamByName('SERVICIOSPENDIENTES').value;

            with tsqlquery.create(self) do       //
            try
             sdsQTServiciosPrestados.SQLConnection := mybd;

            finally
              free;
            end;
            Close;
        finally
            Free
        end;
    end;

    procedure TFServiciosPrestados.FormCreate(Sender: TObject);
    begin
        bErrorCreando := False;

        if (not MyBD.InTransaction) then MyBD.StartTransaction(td);
        try
            LoockAndDeleteTable(MyBD, 'TTMPREPORTEADM');

            QTServiciosPrestados.Close;
            sdsQTServiciosPrestados.SQLConnection := MyBD;

        except
            on E:Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
                MessageDlg('Generaci�n de Informe.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minuts, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
                bErrorCreando := True
            end
        end
    end;

    procedure TFServiciosPrestados.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            If not GetDates(DateIni,DateFin) then Exit;

            FTmp.Temporizar(TRUE,FALSE,'Servicios Prestados', 'Generando el informe Servicios Prestados.');

            Application.ProcessMessages;

            Caption := Format('Informe de Servicios Prestados. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);

            QTServiciosPrestados.Close;

            DoReporteADM;

            QTServiciosPrestados.Open;

            FTmp.Temporizar(FALSE,FALSE,'', '');

        except
            on E: Exception do
            begin
                FTmp.Temporizar(FALSE,FALSE,'', '');
                Application.ProcessMessages;
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
                MessageDlg('Generaci�n de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)
            end
        end
    finally
        Enabled := True;
        Show;
        Application.ProcessMessages;
    end;
end;

procedure TFServiciosPrestados.FormDestroy(Sender: TObject);
begin
     QTServiciosPrestados.Close;
     try
        try
            if MyBD.InTransaction then MyBD.Rollback(td) // MyBD.Commit
            else raise Exception.Create('Se ha perdido la transacci�n de Bloqueo de la tabla temporal del informe de Servicios Prestados')
        except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'Error cerrando la ficha de Servicios Prestados: %s', [E.message]);
                MessageDlg('Generaci�n de Informe.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end
        end
    finally
        FTmp.Temporizar(FALSE,FALSE,'','');
    end
end;

procedure TFServiciosPrestados.BExcelClick(Sender: TObject);
begin
  ExportacionExcelGeneral;
end;

procedure TFServiciosPrestados.ExportacionExcelGeneral;
const

    //Titulos Cabecera
    F_TTL = 1;   C_TTL = 5;
    F_STT = 2;   C_STT = 5;

    //Datos
    F_INI = 8;   C_FAC = 1;
                 C_TUR = 16;
                 C_INS = 21;

    //Titulos Cuadros
    //F_TPT = 4;   C_TPT = 1;  //Servicios Prestados
    //F_TPM = 5;   C_TPM = 1;  //Servicios Pendientes

    //Valores Cuadros
    F_TPT_R = 4;   C_TPT_R = 2;   //Servicios Prestados
    F_TPM_R = 5;   C_TPM_R = 2;   //Servicios Pendientes

var
    i,f : integer;
    ExcelApp, ExcelLibro, ExcelHoja: Variant;
begin
  try
    DBServiciosPrestados.DataSource.DataSet.DisableControls;
    try
      opendialog.Title := 'Seleccione la Planilla de Entrada';
      if OpenDialog.Execute then
      begin
        FTmp.Temporizar(TRUE,FALSE,'Servicios Prestados', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        ExcelHoja := ExcelLibro.Worksheets[1];

        f:= F_INI;
        ExcelHoja.Cells[F_TTL,C_TTL].value := 'Servicios Prestados';
        ExcelHoja.Cells[F_STT,C_STT].value := Format('Planta n�: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);

        QTSERVICIOSPRESTADOS.First;
        while not QTSERVICIOSPRESTADOS.EOF do
        begin
            for i := 0 to DBServiciosPrestados.Columns.Count - 1 do
              begin
                ExcelHoja.Cells[f,C_FAC].value := StrToDate(QTSERVICIOSPRESTADOS.FieldByName('FECHA_FACTURA').AsString); //Corrige en la exportacion a excel el formato de fecha entre las fecha 01 al 12 del mes. - Lucas
                ExcelHoja.Cells[f,C_TUR].value := StrToDate(QTSERVICIOSPRESTADOS.FieldByName('FECHA_TURNO').AsString); //Corrige en la exportacion a excel el formato de fecha entre las fecha 01 al 12 del mes. - Lucas
                ExcelHoja.Cells[f,C_INS].value := StrToDate(QTSERVICIOSPRESTADOS.FieldByName('FECHA_INSPECCION').AsString); //Corrige en la exportacion a excel el formato de fecha entre las fecha 01 al 12 del mes. - Lucas
                ExcelHoja.Cells[f,i+1].value := QTSERVICIOSPRESTADOS.FieldByName(DBServiciosPrestados.Columns[i].FieldName).AsString;
              end;
            QTSERVICIOSPRESTADOS.Next;
            inc(f);
        end;
        QTSERVICIOSPRESTADOS.First;

        //ExcelHoja.Cells[F_TPT,C_TPT].value := 'Servicios Prestados:';
        //ExcelHoja.Cells[F_TPM,C_TPM].value := 'Servicios Pendientes:';

        ExcelHoja.Cells[F_TPT_R,C_TPT_R].value := '$' + ' ' + SERVICIOSPRESTADOS; //Servicios Prestados
        ExcelHoja.Cells[F_TPM_R,C_TPM_R].value := '$' + ' ' + SERVICIOSPENDIENTES; //Servicios Pendientes

      end;
      opendialog.Title := 'Seleccione la Planilla de Salida';
      if OpenDialog.Execute then
         excellibro.saveas(opendialog.filename);
      ExcelApp.Quit;
    except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de Servicios Prestados: %s', [E.message]);
                MessageDlg('Exportaci�n','La exportaci�n no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
            end
    end;
  finally
      DBServiciosPrestados.DataSource.DataSet.enableControls;
      FTmp.Temporizar(FALSE,FALSE,'','');
      application.ProcessMessages;
  end;
end;

procedure TFServiciosPrestados.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TFServiciosPrestados.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;

procedure TFServiciosPrestados.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


end.
