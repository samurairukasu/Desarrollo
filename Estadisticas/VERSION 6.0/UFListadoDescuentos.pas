unit UFListadoDescuentos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB, DBTables, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar;//, UDDEExcelObject;

type
  TFrmListadoDescuentos = class(TForm)
    Label6: TLabel;
    ti: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    Print: TSpeedItem;
    Ascci: TSpeedItem;
    Excel: TSpeedItem;
    SBBusqueda: TSpeedItem;
    SBSalir: TSpeedItem;
    DSourceArqueoCaja: TDataSource;
    QTTMPLISTDESCUENTOS: TQuery;
    lblTotalFacturas: TLabel;
    edtTotalFacturas: TEdit;
    DBGridArqueoCaja: TDBGrid;
    SpeedItem1: TSpeedItem;

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
//    function ExportacionExcelGeneral(ExcelClient: TDDEExcelObject): Boolean;
//    function ExportacionExcelResumen(ExcelClient: TDDEExcelObject): Boolean;
    procedure SpeedItem1Click(Sender: TObject);
  public
    { Public declarations }
    bErrorCreando : boolean;
    NombreEstacion, NumeroEstacion,
    TipoPago,
    DateIni, DateFin,
    NumeroFacturas,
    aTipoCliente : string;
    function PutTipoPago(const aTP : string): string;
    function PutEstacion : string;
  end;

  procedure GenerateListadoDescuento (const TipoArqueo: string);
  procedure DoListadoDescuento(const FI,FF,aCodDescuento: string;
                       var sTotFact: string);

var
  FrmListadoDescuentos: TFrmListadoDescuentos;
  sTipo_Auxi: string;

implementation

{$R *.DFM}


uses
   UCDIALGS,
   UUTILS,
   UGETDATES,
//   ULOGS,
   GLOBALS,
   UFLISTADODESCUENTOSTOPRINT,
//   UFINFORMESDIALOGPRINT,
//   UFINFORMESDIALOGASCII,
//   UFINFORMESDIALOGEXCEL,
   UFTMP,
//   USAGESTACION,
   USAGVARIOS,
   UFPORTIPO;
//   UARQUEOCAJASUMARYPRINT,
//   UARQUEOCAJASUMARY;
//   USAGCLASSES;


resourcestring
    FICHERO_ACTUAL = 'UFListadoDescuentos.PAS';

const
    TIPO_ARQUEO_DESCUENTOS = 'D';


procedure DoListadoDescuento(const FI,FF,aCodDescuento: string;
                       var sTotFact: string);

begin
    DeleteTable(MyBD, 'TTMPRESDESC');

    with TStoredProc.Create(nil) do
    try
        DataBaseName := MyBD.DataBaseName;
        SessionName := MyBD.SessionName;

        StoredProcName := 'DOLISTADODESC_ERVTV';

        Prepare;
        ParamByName('FECHAINI').Value := FI;
        ParamByName('FECHAFIN').Value := FF;
        ParamByName('aCodDescu').Value := aCodDescuento;

        ExecProc;

        sTotFact := ParamByName('NumFacturas').AsString;

        Close;
    finally
        Free
    end
end;


procedure GenerateListadoDescuento (const TipoArqueo: string);
begin
    sTipo_Auxi := TipoArqueo;

    if (sTipo_Auxi = '') then
       sTipo_Auxi := TIPO_ARQUEO_DESCUENTOS;


        with TFrmListadoDescuentos.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                NumeroFacturas := '0';

                If not GetDates(DateIni,DateFin) then Exit;

                If not PorTipo(TIPO_ARQUEO_DESCUENTOS, aTipoCliente, DateIni, DateFin) then Exit;

                Caption := Format('Listado de Facturas con Descuentos. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                FTmp.Temporizar(TRUE,FALSE,'Listado de Facturas con Descuentos', 'Generando el informe listado de facturas con descuentos.');
                Application.ProcessMessages;

                DoListadoDescuento(DateIni, DateFin, aTipoCliente, NumeroFacturas);

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

procedure TFrmListadoDescuentos.FormCreate(Sender: TObject);
begin
    bErrorCreando := False;

    if (not MyBD.InTransaction) then MyBD.StartTransaction;

    try
        LoockAndDeleteTable(MyBD, 'TTMPRESDESC')
    except
        on E:Exception do
        begin
            MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
            bErrorCreando := True
        end
    end
end;

procedure TFrmListadoDescuentos.FormDestroy(Sender: TObject);
begin
    QTTMPLISTDESCUENTOS.Close;

    try
        try
            if MyBD.InTransaction then MyBD.Rollback // MyBD.Commit
            else raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del arqueo de Caja')
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

function TFrmListadoDescuentos.PutEstacion : string;
begin
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
    Result := NumeroEstacion + ' ' + NombreEstacion;
end;


function TFrmListadoDescuentos.PutTipoPago(const aTP : string) : string;
begin
            result := TIPO_ARQUEO_DESCUENTOS;
            TipoPago := TIPO_ARQUEO_DESCUENTOS;
end;

procedure TFrmListadoDescuentos.PutSumaryResults;
begin
    try

        EdtTotalFacturas.Text := NumeroFacturas;

        with QTTMPLISTDESCUENTOS do
        begin
            Close;
            DatabaseName := MyBD.DataBaseName;
            SessionName := MyBD.SessionName;
            SQL.Clear;
            SQL.Add('SELECT ZONA||PLANTA PLANTA, TO_CHAR(FECHALTA,''YYYY/DD/MM'') FO, ' +
                    'TO_CHAR(FECHALTA,''DD/MM/YYYY'') FECHALTA, NUMINFORME, ' +
                    'DOMINIO, TIPOCLIENTE, NOMBRECLIENTE, IMPORTE, IVA, IVANOINSCRIPTO, ' +
                    'TOTAL, CONCDESC, NROCUPON, CODDESCU FROM TTMPRESDESC ORDER BY FO  ');
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTDESCUENTOS);
            {$ENDIF}

            Open;
        end
    finally
        Application.ProcessMessages;
    end;
end;


procedure TFrmListadoDescuentos.PrintClick(Sender: TObject);
begin
                    with TFListadoFacXDescuentosToPrint.Create(Application) do
                    try
                        Execute(DateIni, DateFin, NumeroFacturas, NombreEstacion, NumeroEstacion, aTipoCliente);
                    finally
                        Free;
                    end;
end;

procedure TFrmListadoDescuentos.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            NumeroFacturas := '0';

            If Not GetDates(DateIni,DateFin) Then Exit;
            Caption := Format('Listado de Facturas con Descuento. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
            FTmp.Temporizar(TRUE,FALSE,'Listado de Facturas con Descuento','Generando el informe Listado de Facturas con Descuento.');
            Application.ProcessMessages;

            DoListadoDescuento(DateIni, DateFin, aTipoCliente, NumeroFacturas);

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

procedure TFrmListadoDescuentos.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure TFrmListadoDescuentos.AscciClick(Sender: TObject);
begin
{    with TFAsciiDialog.Create(Application) do
    try
       if ShowModal = mrOk
       then begin
            case ExportarAscii of

                teaGeneral:
                begin
                    with TFListadoFacXDescuentosToPrint.Create(Application) do
                    try
                        ExportaAscii(DateIni, DateFin, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, NumeroFacturas, NumeroNotasCredito, NombreEstacion, NumeroEstacion, aTipoCliente);
                    finally
                        Free;
                    end;
                end;

               teaResumen:
               begin
                    with TFArqueoCajaSumary.Create(Application) do
                    try
                       ExportaAscii(DateIni, DateFin, PutTipoPago(TipoPago),TIPO_ARQUEO_DESCUENTOS);
                    finally
                       Free;
                    end;
               end;

               else begin

                    with TFListadoFacXDescuentosToPrint.Create(Application) do
                    try
                        ExportaAscii(DateIni, DateFin, TotalImporte, TotalIva, TotalIvaNoInscripto, Total, NumeroFacturas, NumeroNotasCredito, NombreEstacion, NumeroEstacion, aTipoCliente);
                    finally
                        Free;
                    end;

                    with TFArqueoCajaSumary.Create(Application) do
                    try
                       ExportaAscii(DateIni, DateFin, PutTipoPago(TipoPago),TIPO_ARQUEO_DESCUENTOS);
                    finally
                       Free;
                    end;
               end;
            end;
       end;
    finally
        Free;
    end;}
end;

procedure TFrmListadoDescuentos.ExcelClick(Sender: TObject);
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
    ExcelClient.Put(F_STT,C_STT,Format('Estación nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]));
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

procedure TFrmListadoDescuentos.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TFrmListadoDescuentos.OnOpen (Sender: TObject);
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
        ExcelClient.Put(F_STT,C_STT,Format('Estación nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]));
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


procedure TFrmListadoDescuentos.SpeedItem1Click(Sender: TObject);
begin
    try
        Enabled := False;
        try
            NumeroFacturas := '0'; 

            If not PorTipo(TIPO_ARQUEO_DESCUENTOS, aTipoCliente, DateIni, DateFin) then Exit;
            Caption := Format('Listado de Facturas con Descuento. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
            FTmp.Temporizar(TRUE,FALSE,'Arqueo de Caja','Generando el informe Listado de Facturas con Descuento.');
            Application.ProcessMessages;

            DoListadoDescuento(DateIni, DateFin, aTipoCliente, NumeroFacturas);

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

end.


