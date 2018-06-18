unit UFLISTADOPAGOS_EP;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, FMTBcd, DBXpress, DB, SqlExpr, Provider, DBClient, Grids,
    DBGrids, RXDBCtrl, USAGESTACION, SpeedBar, ExtCtrls,
    StdCtrls, Mask, DBCtrls, Buttons,
    RXLookup, ComCtrls, ComObj;

type
  TPagosEP = class(TForm)
    SBarPrincipal: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    BExcel: TSpeedItem;
    SBBusqueda: TSpeedItem;
    SBSalir: TSpeedItem;
    DBPagosEP: TRxDBGrid;
    SQLConnection1: TSQLConnection;
    SQLQuery1: TSQLQuery;
    DSTPagosEP: TDataSource;
    sdsQTPagosEP: TSQLDataSet;
    dspQTPagosEP: TDataSetProvider;
    QTPagosEP: TClientDataSet;
    OpenDialog: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SBBusquedaClick(Sender: TObject);
    procedure BExcelClick(Sender: TObject);
    procedure OnOpen (Sender: TObject);
    procedure OnClose (Sender: TObject);
    procedure SBSalirClick(Sender: TObject);
  private
    procedure DoListadoEP;
    Procedure ExportacionExcelGeneral;
  public
    bErrorCreando : boolean;
    NombreEstacion, NumeroEstacion, DateIni, DateFin : string;
    function PutEstacion : string;
  end;

  procedure GenerateListadoEpago;

var
  PagosEP: TPagosEP;

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
      FICHERO_ACTUAL = 'UFLISTADOPAGOS_EP';


procedure GenerateListadoEpago;
    begin
        with TPagosEP.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                If not GetDates(DateIni,DateFin) then Exit;
                Caption := Format('Listado Epago. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                FTmp.Temporizar(TRUE,FALSE,'Listado Epago', 'Generando el Listado Epago.');

                Application.ProcessMessages;

                DoListadoEP;

                QTPagosEP.Open;

                FTmp.Temporizar(FALSE,FALSE,'', '');
                ShowModal;
            except
                on E: Exception do
                begin
                    FTmp.Temporizar(FALSE,FALSE,'', '');
                    Application.ProcessMessages;
                    FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Listado Cancelado por: %s', [E.message]);
                    MessageDlg('Generación de Listado.', 'El listado no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)
                end
            end
        finally
            Free;
            Application.ProcessMessages;
        end;
    end;

    function TPagosEP.PutEstacion : string;
    begin
        NombreEstacion := fVarios.NombreEstacion;
        NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
        Result := NumeroEstacion + ' ' + NombreEstacion;
    end;

    procedure TPagosEP.DoListadoEP;
    begin
        DeleteTable(MyBD, 'TTMP_TMERCADOPAGO');

        {agregamos el alter session porque sino saltaba error en el procedimiento al
         calcular la menor fecha}
        with tsqlquery.create(self) do       //
        try
          SQLConnection := mybd;
          sql.add('alter session set nls_date_format = ''DD/MM/YYYY HH24:MI:SS''');
          execsql;
        finally
          free;
        end;

        with TSQLStoredProc.Create(self) do
        try
            SQLConnection := MyBD;
            StoredProcName := 'PQ_REPORTE_ADM.DoListadoEP';

            Prepared := true;
            ParamByName('FECHAINI').Value := DateIni;
            ParamByName('FECHAFIN').Value := DateFin;
            ExecProc;

            with tsqlquery.create(self) do       //
            try
             sdsQTPagosEP.SQLConnection := mybd;

            finally
              free;
            end;
            Close;
        finally
            Free
        end;
    end;

    procedure TPagosEP.FormCreate(Sender: TObject);
    begin
        bErrorCreando := False;

        if (not MyBD.InTransaction) then MyBD.StartTransaction(td);
        try

            QTPagosEP.Close;
            sdsQTPagosEP.SQLConnection := MyBD;

        except
            on E:Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Listado Cancelado por: %s', [E.message]);
                MessageDlg('Generación de Listado.', 'El listado no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minuts, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
                bErrorCreando := True
            end
        end
    end;

    procedure TPagosEP.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            If not GetDates(DateIni,DateFin) then Exit;

            FTmp.Temporizar(TRUE,FALSE,'Epago', 'Generando el listado de pagos.');

            Application.ProcessMessages;

            Caption := Format('Listado Epago. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);

            QTPagosEP.Close;

            DoListadoEP;

            QTPagosEP.Open;

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

procedure TPagosEP.FormDestroy(Sender: TObject);
begin
     QTPagosEP.Close;
     try
        try
            if MyBD.InTransaction then MyBD.Rollback(td) // MyBD.Commit
            else raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del informe de Epago')
        except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'Error cerrando la ficha de Epago: %s', [E.message]);
                MessageDlg('Generación de Informe.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end
        end
    finally
        FTmp.Temporizar(FALSE,FALSE,'','');
    end
end;

procedure TPagosEP.BExcelClick(Sender: TObject);
begin
  ExportacionExcelGeneral;
end;

procedure TPagosEP.ExportacionExcelGeneral;
const

    //Titulos Cabecera
    F_TTL = 1;   C_TTL = 5;
    F_STT = 2;   C_STT = 5;

    //Datos
    F_INI = 8;   C_PAG = 6;
                 C_ACR = 7;
                 C_VEN = 12;

var
    i,f : integer;
    ExcelApp, ExcelLibro, ExcelHoja: Variant;
begin
  try
    DBPagosEP.DataSource.DataSet.DisableControls;
    try
      opendialog.Title := 'Seleccione la Planilla de Entrada';
      if OpenDialog.Execute then
      begin
        FTmp.Temporizar(TRUE,FALSE,'Epago', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        ExcelHoja := ExcelLibro.Worksheets[1];

        f:= F_INI;
        ExcelHoja.Cells[F_TTL,C_TTL].value := 'Epago';
        ExcelHoja.Cells[F_STT,C_STT].value := Format('Planta nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);

        QTPagosEP.First;
        while not QTPagosEP.EOF do
        begin
            for i := 0 to DBPagosEP.Columns.Count - 1 do
              BEGIN
                ExcelHoja.Cells[f,i+1].value := QTPagosEP.FieldByName(DBPagosEP.Columns[i].FieldName).AsString;
                ExcelHoja.Cells[f,C_PAG].value := StrToDate(QTPagosEP.FieldByName('FECHAPAGO').AsString); //Corrige en la exportacion a excel el formato de fecha entre las fecha 01 al 12 del mes. - Lucas
                ExcelHoja.Cells[f,C_ACR].value := StrToDate(QTPagosEP.FieldByName('FECHAACREDITACION').AsString); //Corrige en la exportacion a excel el formato de fecha entre las fecha 01 al 12 del mes. - Lucas
                ExcelHoja.Cells[f,C_VEN].value := StrToDate(QTPagosEP.FieldByName('FECHAVENCIMIENTO').AsString); //Corrige en la exportacion a excel el formato de fecha entre las fecha 01 al 12 del mes. - Lucas
              END;
            QTPagosEP.Next;
            inc(f);
        end;
        QTPagosEP.First;

      end;
      opendialog.Title := 'Seleccione la Planilla de Salida';
      if OpenDialog.Execute then
         excellibro.saveas(opendialog.filename);
      ExcelApp.Quit;
    except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de Epago: %s', [E.message]);
                MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
            end
    end;
  finally
      DBPagosEP.DataSource.DataSet.enableControls;
      FTmp.Temporizar(FALSE,FALSE,'','');
      application.ProcessMessages;
  end;
end;

procedure TPagosEP.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TPagosEP.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;

procedure TPagosEP.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;

end.
