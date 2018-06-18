unit UListadoCambioFecha;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB,StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, UDDEExcelObject,Provider, DBClient, SqlExpr, FMTBcd, Dialogs, Comobj;

type
  TFrmListadoCambioFecha = class(TForm)
    DSourceArqueoCaja: TDataSource;
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
    DBGridArqueoCaja: TDBGrid;
    QTTMPLISTCAMBIO: TClientDataSet;
    dspListCambio: TDataSetProvider;
    sdslistcambio: TSQLDataSet;
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
    DateIni, DateFin,
    TotalImporte,
    Total, TotalIva, TotalIvaNoInscripto,
    NumeroFacturas,
    NumeroNotasCredito, aTipoCliente : string;
    function PutTipoPago(const aTP : string): string;
    function PutEstacion : string;
  end;

  procedure GenerateListadoCambioFecha;
  procedure DoListadoCambioFecha(const FI,FF: string);

var
  FrmListadoCambioFecha: TFrmListadoCambioFecha;

implementation

{$R *.DFM}


uses
   UCDIALGS,
   UUTILS,
   UGETDATES,
   ULOGS,
   GLOBALS,
   ULISTADOCAMBIOFECHATOPRINT,
   UFTMP,
   USAGESTACION;


resourcestring
    FICHERO_ACTUAL = 'UListadoCambioFecha.PAS';


procedure DoListadoCambioFecha(const FI,FF: string);

begin
    DeleteTable(MyBD, ' TTMPLISTCAMBIO');

    with TSQLStoredProc.Create(application) do
    try
        sqlconnection := MyBD;
        StoredProcName := 'PQ_LIST_VARIOS.DOLISTADOCAMBIOFECHA';
//        Prepared := true;
        ParamByName('FECHAINI').Value := FI;
        ParamByName('FECHAFIN').Value := FF;

        ExecProc;

        Close;
    finally
        Free
    end
end;


procedure GenerateListadoCambioFecha;
begin

        with TFrmListadoCambioFecha.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                TotalImporte := '0';
                Total := '0'; NumeroFacturas := '0'; NumeroNotasCredito := '0';
                If not GetDates(DateIni,DateFin) then Exit;

                Caption := Format('Listado Cambio Fecha de Vencimiento. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                FTmp.Temporizar(TRUE,FALSE,'Listado Cambio Fecha Vencimiento','Generando el informe cambio fecha de vencimiento.');
                Application.ProcessMessages;

                DoListadoCambioFecha(DateIni, DateFin);

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

procedure TFrmListadoCambioFecha.FormCreate(Sender: TObject);
begin
    bErrorCreando := False;

     if (not MyBD.InTransaction) then MyBD.StartTransaction(td);

    try
        LoockAndDeleteTable(MyBD, ' TTMPLISTCAMBIO')
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
            MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
            bErrorCreando := True
        end
    end
end;

procedure TFrmListadoCambioFecha.FormDestroy(Sender: TObject);
begin
    QTTMPLISTCAMBIO.Close;

    try
        try
            if MyBD.InTransaction then MyBD.Rollback(td)  // MyBD.Commit
            else raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del listado de cambios de fecha')
        except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'Error cerrando la ficha de UListadoCambioFecha: %s', [E.message]);
                MessageDlg('Generación de Informes.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end
        end
    finally
        FTmp.Temporizar(FALSE,FALSE,'','');
    end
end;

function TFrmListadoCambioFecha.PutEstacion : string;
begin
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
    Result := NumeroEstacion + ' ' + NombreEstacion;
end;


function TFrmListadoCambioFecha.PutTipoPago(const aTP : string) : string;
begin
            result := S_FORMA_PAGO[tfpCheque];
            TipoPago := V_FORMA_PAGO[tfpCheque];
end;

procedure TFrmListadoCambioFecha.PutSumaryResults;
begin
    try
        TotalImporte := ConviertePuntoEnComa(TotalImporte);
        Total := ConviertePuntoEnComa(Total);

        with QTTMPLISTCAMBIO do
        begin
            Close;
            sdslistcambio.SQLConnection:=MyBD;
            CommandText := 'SELECT TO_CHAR(FECHALTA,''DD/MM/YYYY'') FECHALTA, NUMINFORME,DOMINIO,TO_CHAR(FECHA_VENC_OLD,''DD/MM/YYYY'') FECHA_VENC_OLD,TO_CHAR(FECHA_VENC_NEW,''DD/MM/YYYY'') FECHA_VENC_NEW,DESCMOTIVO,NRONOTA,USUARIO FROM  TTMPLISTCAMBIO ORDER BY FECHALTA, NRONOTA ';
            {$IFDEF TRAZAS}
            FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTCAMBIO);
            {$ENDIF}

            Open;
        end
    finally
        Application.ProcessMessages;
    end;
end;


procedure TFrmListadoCambioFecha.PrintClick(Sender: TObject);
begin
       with TFListadoCambioFechaToPrint.Create(Application) do
       try
          Execute(DateIni, DateFin, NombreEstacion, NumeroEstacion);
       finally
          Free;
       end;
end;

procedure TFrmListadoCambioFecha.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            TotalImporte := '0'; TotalIva := '0';  TotalIvaNoInscripto := '0';
            Total := '0'; NumeroFacturas := '0'; NumeroNotasCredito := '0';

            If Not GetDates(DateIni,DateFin) Then Exit;
            Caption := Format('Listado Cambio Fecha de Vencimiento. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
            FTmp.Temporizar(TRUE,FALSE,'Listado Cambio Fecha Vencimiento','Generando el informe cambio fecha de vencimiento.');
            Application.ProcessMessages;

            DoListadoCambioFecha(DateIni, DateFin);

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

procedure TFrmListadoCambioFecha.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure TFrmListadoCambioFecha.AscciClick(Sender: TObject);
begin
     with TFListadoCambioFechaToPrint.Create(Application) do
     try
        ExportaAscii(DateIni, DateFin, NombreEstacion, NumeroEstacion);
     finally
        Free;
     end;
end;

procedure TFrmListadoCambioFecha.ExcelClick(Sender: TObject);
begin
ExportacionExcelGeneral;
end;


Procedure TFrmListadoCambioFecha.ExportacionExcelGeneral;
const
    F_TTL = 1;   C_TTL = 4;
    F_STT = 2;   C_STT = 4;
    F_NFA = 4;   C_NFA = 2;
    F_INI = 7;

    C_LTT = 5;
    C_TTO = 6;
var
i,f : integer;
ExcelApp, ExcelLibro, ExcelHoja: Variant;

begin
  try
    Opendialog.Title := 'Seleccione la Planilla de Entrada';
    if OpenDialog.Execute then
      begin
        FTmp.Temporizar(TRUE,FALSE,'Listado de Cambios de Fechas', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        ExcelHoja := ExcelLibro.Worksheets[1];
        F:= F_INI;
        ExcelHoja.Cells[F_TTL,C_TTL].value:='Listado Cambio Fecha de Vencimiento';
        ExcelHoja.Cells[F_STT,C_STT].value:=Format('Planta Nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
        QTTMPLISTCAMBIO.First;
        while not QTTMPLISTCAMBIO.EOF do
          begin
            for i := 0 to DBGridArqueoCaja.Columns.Count - 1 do
              ExcelHoja.Cells[f,i+1].value:=QTTMPLISTCAMBIO.FieldByName(DBGridArqueoCaja.Columns[i].FieldName).AsString;
          QTTMPLISTCAMBIO.Next;
          inc(f);
          end;
        Opendialog.Title := 'Seleccione la Planilla de Salida';
        if OpenDialog.Execute then
          excellibro.SaveAs(Opendialog.filename);
        ExcelApp.Quit;
        MessageDlg('Archivo exportado.','La exportación se realizó con exito!', mtInformation, [mbOK],mbOK, 0);
      end;
  Except
    on E: Exception do
      begin
        FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de UfListadoCambioFecha: %s', [E.message]);
        MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
      end
  end;
end;


procedure TFrmListadoCambioFecha.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TFrmListadoCambioFecha.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;


end.


