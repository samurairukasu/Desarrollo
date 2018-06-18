unit UListadoTotalTarjetasGNC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons, comobj,
  SpeedBar, UDDEExcelObject, FMTBcd, DBClient, Provider, SqlExpr, Dialogs;

type
  TFrmListadoTotalTarjetasGNC = class(TForm)
    ti: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    Print: TSpeedItem;
    SBBusqueda: TSpeedItem;
    SBSalir: TSpeedItem;
    Ascci: TSpeedItem;
    Excel: TSpeedItem;
    Label6: TLabel;
    sdsQTTMPTOTALTARJETA: TSQLDataSet;
    dspQTTMPTOTALTARJETA: TDataSetProvider;
    QTTMPTOTALTARJETA: TClientDataSet;
    DBGridArqueoCaja: TDBGrid;
    DSourceArqueoCaja: TDataSource;
    OpenDialog: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PutSumaryResults;
    procedure PrintClick(Sender: TObject);
    procedure SBBusquedaClick(Sender: TObject);
    procedure SBSalirClick(Sender: TObject);
    procedure AscciClick(Sender: TObject);
    procedure ExcelClick(Sender: TObject);
    procedure OnOpen (Sender: TObject);
    procedure OnClose (Sender: TObject);
    procedure ExportacionExcelGeneral;
  public
    { Public declarations }
    bErrorCreando : boolean;
    NombreEstacion, NumeroEstacion,
    TipoPago,
    DateIni, DateFin: string;
    function PutTipoPago(const aTP : string): string;
    function PutEstacion : string;
  end;

  procedure GenerateListadoTotalTarjetasGNC;
  procedure DoListadoTotalTarjetas(const FI,FF: string);

var
  FrmListadoTotalTarjetasGNC: TFrmListadoTotalTarjetasGNC;

implementation

{$R *.DFM}


uses
   UCDIALGS,
   UUTILS,
   UGETDATES,
   ULOGS,
   GLOBALS,
   UListadoTotalTarjetasToPrint,
   UFTMP,
   USAGESTACION;


resourcestring
    FICHERO_ACTUAL = 'UListadoTotalTarjetasGNC.PAS';


procedure DoListadoTotalTarjetas(const FI,FF: string);

begin
    DeleteTable(MyBD, 'TTMPTOTALTARJETA');

    with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_ARQUEO_GNC.DOALLTOTALESTARJETAGNC';
        Prepared := true;
        ParamByName('FECHAINI').Value := FI;
        ParamByName('FECHAFIN').Value := FF;

        ExecProc;

        Close;
    finally
        Free
    end
end;


procedure GenerateListadoTotalTarjetasGNC;
begin


        with TFrmListadoTotalTarjetasGNC.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                If not GetDates(DateIni,DateFin) then Exit;

                Caption := Format('Listado Totales de Tarjetas. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                FTmp.Temporizar(TRUE,FALSE,'Listado Totales de Tarjetas', 'Generando el informe listado totales de Tarjetas.');
                Application.ProcessMessages;

                DoListadoTotalTarjetas(DateIni, DateFin);

                FTmp.Temporizar(FALSE,FALSE,'', '');
                Application.ProcessMessages;

                PutSumaryResults;
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

procedure TFrmListadoTotalTarjetasGNC.FormCreate(Sender: TObject);
begin
    bErrorCreando := False;

    if (not MyBD.InTransaction) then MyBD.StartTransaction(td);

    try
        LoockAndDeleteTable(MyBD, 'TTMPTOTALTARJETA')
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
            MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
            bErrorCreando := True
        end
    end
end;

procedure TFrmListadoTotalTarjetasGNC.FormDestroy(Sender: TObject);
begin
    QTTMPTOTALTARJETA.Close;

    try
        try
            if MyBD.InTransaction then MyBD.Rollback(td) // MyBD.Commit
            else raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del listado de Cheques')
        except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'Error cerrando la ficha de UListadoCheques: %s', [E.message]);
                MessageDlg('Generación de Informes.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end
        end
    finally
        FTmp.Temporizar(FALSE,FALSE,'','');
    end
end;

function TFrmListadoTotalTarjetasGNC.PutEstacion : string;
begin
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
    Result := NumeroEstacion + ' ' + NombreEstacion;
end;


function TFrmListadoTotalTarjetasGNC.PutTipoPago(const aTP : string) : string;
begin
            result := S_FORMA_PAGO[tfpCheque];
            TipoPago := V_FORMA_PAGO[tfpCheque];
end;

procedure TFrmListadoTotalTarjetasGNC.PutSumaryResults;
begin
    try

        with QTTMPTOTALTARJETA do
        begin
            Close;
            sdsQTTMPTOTALTARJETA.SQLConnection := MyBD;
            CommandText := 'SELECT CODTARJETA, TARJETA, SUBTOTAL, IVACAJA, IVANOINSC, TOTALCAJA, IIBB FROM TTMPTOTALTARJETA ORDER BY CODTARJETA';
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPTOTALTARJETA);
            {$ENDIF}

            Open;
        end
    finally
        Application.ProcessMessages;
    end;
end;


procedure TFrmListadoTotalTarjetasGNC.PrintClick(Sender: TObject);
begin
       with TFListadoTotalTarjetasToPrint.Create(Application) do
       try
          lblTitulo.caption := 'Listado Totales de Tarjetas GNC';
          Execute(DateIni, DateFin, NombreEstacion, NumeroEstacion);
       finally
          Free;
       end;
end;

procedure TFrmListadoTotalTarjetasGNC.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            If Not GetDates(DateIni,DateFin) Then Exit;
            Caption := Format('Listado Totales de Tarjetas. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
            FTmp.Temporizar(TRUE,FALSE,'Listado Totales de Tarjetas','Generando el informe listado de Totales de Tarjetas.');
            Application.ProcessMessages;

            DoListadoTotalTarjetas(dateini, datefin);

            FTmp.Temporizar(FALSE,FALSE,'','');
            Application.ProcessMessages;

            PutSumaryResults;

        except
            on E: Exception do
            begin
                FTmp.Temporizar(FALSE,FALSE,'','');
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
                MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo' , mtError, [mbOk], mbOk, 0);
            end
        end
    finally
        Enabled := True;
        Show;
        Application.ProcessMessages
    end
end;

procedure TFrmListadoTotalTarjetasGNC.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure TFrmListadoTotalTarjetasGNC.AscciClick(Sender: TObject);
begin
     with TFListadoTotalTarjetasToPrint.Create(Application) do
     try
        ExportaAscii(DateIni, DateFin, NombreEstacion, NumeroEstacion);
     finally
        Free;
     end;
end;

procedure TFrmListadoTotalTarjetasGNC.ExcelClick(Sender: TObject);
const
    F_TTL = 1;   C_TTL = 4;
    F_STT = 2;   C_STT = 4;

    F_INI = 5;

var
    ExcelApp, ExcelLibro, ExcelHoja, range: Variant;
    i,f : integer;
begin


  try
    DBGridArqueoCaja.DataSource.DataSet.DisableControls;
    try
      opendialog.Title := 'Seleccione la Planilla de Entrada';
      if OpenDialog.Execute then
      begin
        FTmp.Temporizar(TRUE,FALSE,'Listado Totales de Tarjetas', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        ExcelHoja := ExcelLibro.Worksheets['Hoja1'];

        f:= F_INI;

        excelHoja.cells[F_TTL,C_TTL].value := 'Listado Totales de Tarjetas';
        excelHoja.cells[F_STT,C_STT].value := Format('Planta nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);

        QTTMPTOTALTARJETA.First;
        while not QTTMPTOTALTARJETA.EOF do
        begin
              for i := 0 to DBGridArqueoCaja.Columns.Count - 1 do
              begin
                  excelHoja.cells[f,i+1].value := QTTMPTOTALTARJETA.FieldByName(DBGridArqueoCaja.Columns[i].FieldName).AsString;
                  range := excelhoja.cells[f,i+1];
                  if i = 0 then
                    range.horizontalAlignment := xlLeft
                  else
                    range.horizontalAlignment := xlRight;

              end;
              QTTMPTOTALTARJETA.Next;
              inc(f);
        end;
        QTTMPTOTALTARJETA.First;
      end;

      opendialog.Title := 'Seleccione la Planilla de Salida';
      if OpenDialog.Execute then
         excellibro.saveas(opendialog.filename);
      ExcelApp.Quit;
    except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de UIVABook: %s', [E.message]);
                MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
            end
    end;
  finally
      DBGridArqueoCaja.DataSource.DataSet.enableControls;
      FTmp.Temporizar(FALSE,FALSE,'','');
      application.ProcessMessages;
  end;
end;


Procedure TFrmListadoTotalTarjetasGNC.ExportacionExcelGeneral;
const
    F_TTL = 1;   C_TTL = 4;
    F_STT = 2;   C_STT = 4;
    F_INI = 5;
var
ExcelApp, ExcelLibro, ExcelHoja: Variant;
i,f : integer;
anu,inu: integer;
begin
    try
      Opendialog.Title := 'Seleccione la Planilla de Entrada';
      if OpenDialog.Execute then
      begin
        FTmp.Temporizar(TRUE,FALSE,'Listado de Vehículos Oficiales', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        ExcelHoja := ExcelLibro.Worksheets[1];
        f:= F_INI;
        ExcelHoja.cells[F_TTL,C_TTL].value :='Listado Totales de Tarjetas';
        ExcelHoja.cells[F_STT,C_STT].value :=Format('Planta nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
        QTTMPTOTALTARJETA.First;
        while not QTTMPTOTALTARJETA.EOF do
          begin
            for i := 0 to DBGridArqueoCaja.Columns.Count - 1 do
              ExcelHoja.cells[f,i+1].value:=QTTMPTOTALTARJETA.FieldByName(DBGridArqueoCaja.Columns[i].FieldName).AsString;
            QTTMPTOTALTARJETA.Next;
          inc(f);
          end;
        QTTMPTOTALTARJETA.First;
        Opendialog.Title := 'Seleccione la Planilla de Salida';
        if OpenDialog.Execute then
          excellibro.SaveAs(Opendialog.filename);
        ExcelApp.Quit;
        MessageDlg('Archivo exportado.','La exportación se realizó con exito!', mtInformation, [mbOK],mbOK, 0);
      end;
    except
      on E: Exception do
        begin
        FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de UfListadoTotalTarjeta: %s', [E.message]);
        MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
        end
    end;
end;

procedure TFrmListadoTotalTarjetasGNC.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TFrmListadoTotalTarjetasGNC.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;


end.


