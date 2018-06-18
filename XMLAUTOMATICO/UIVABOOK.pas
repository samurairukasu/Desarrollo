unit UIVABook;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  DB, StdCtrls, Grids, DBGrids, ExtCtrls, Buttons, SQLExpr,
  SpeedBar, Dialogs, comobj, FMTBcd, Provider, DBClient;

type
  TFIVABook = class(TForm)
    lblNombreTabla: TLabel;
    lblIntervaloFechas: TLabel;
    lblTotalFacturasA: TLabel;
    lblTotalFacturasB: TLabel;
    lblTotal: TLabel;
    lblNumeroEstacion2: TLabel;
    lblNombreEstacion: TLabel;
    lblNumeroEstacion: TLabel;
    EImporteGravado: TEdit;
    edtTotalFacturasA: TEdit;
    edtTotalFacturasB: TEdit;
    EImporteIva: TEdit;
    Label1: TLabel;
    edtTotalNotasCredito: TEdit;
    DSourceLibroIVA: TDataSource;
    EImporteTotal: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ti: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    Print: TSpeedItem;
    Excel: TSpeedItem;
    SBBusqueda: TSpeedItem;
    SBSalir: TSpeedItem;
    Label5: TLabel;
    EImporteIIBB: TEdit;
    OpenDialog: TOpenDialog;
    QTTMPIVABOOK: TClientDataSet;
    dspQTTMPIVABOOK: TDataSetProvider;
    sdsQTTMPIVABOOK: TSQLDataSet;
    DBGridLibroIVA: TDBGrid;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PutFechas;
    function PutEstacion:string;
    procedure PutSumaryResults;
    procedure FormDestroy(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure OnOpen (Sender: TObject);
    procedure OnClose (Sender: TObject);
  public
    { Public declarations }
    bErrorCreando : boolean;
    NombreEstacion, NumeroEstacion,
    DateIni, DateFin,
    TotalImporte,
    TotalIva,
    Total, TotalIIBB,
    NumeroFacturasA,
    NumeroFacturasB,
    NumeroNotasCredito : string;
  end;

var
  FIVABook: TFIVABook;

  procedure GenerateIVABook (aForm: TForm);

implementation

{$R *.DFM}

uses
   UIVABOOKTOPRINT,
   ULOGS,
   GLOBALS,
   UFTMP,
   UUTILS,
   UCDIALGS,
   UGETDATES,
   USAGVARIOS;

const
    FICHERO_ACTUAL = 'UIVABook.pas';

procedure DoCalculateIVABook( const cInitialDate, cFinalDate : string;
                              var vNFA, vNFB, vNNC, vTImporte, vTIva, vTotal, vTotalIIBB : string);
begin
    DeleteTable(MyBD, 'TTMPBOOKIVA');

    with TSQLStoredProc.Create(application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_LIBRO_IVA.DOCALCULATEIVABOOK';

        Prepared := true;
        ParamByName('FECHAINI').Value := cInitialDate;
        ParamByName('FECHAFIN').Value := cFinalDate;

        ExecProc;
        vNFA := ParamByName('NumeroFacturasA').AsString;
        vNFB := ParamByName('NumeroFacturasB').AsString;
        vNNC := ParamByName('NumeroNotasCredito').AsString;
        vTImporte := ParamByName('TotalImporte').AsString;
        vTIva := ParamByName('TotalIva').AsString;
        vTotal := ParamByName('Total').AsString;
        vTotalIIBB := ParambyName('IIBBEnCaja').AsString;
        Close
    finally
        Free
    end
end;

procedure GenerateIVABook (aForm: TForm);
begin
    aForm.Enabled := False;
    try
        with TFIVABook.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                TotalImporte := '0'; TotalIva := '0'; Total := '0'; TotalIIBB := '0';
                NumeroFacturasA := '0'; NumeroFacturasB := '0'; NumeroNotasCredito := '0';
                if not GetDates(DateIni,DateFin) then Exit;
                PutFechas;
                PutEstacion;

                FTmp.Temporizar(TRUE,FALSE,'Libro IVA de Ventas', 'Generando el informe libro de iva ventas');

                DoCalculateIVABook(DateIni, DateFin, NumeroFacturasA, NumeroFacturasB, NumeroNotasCredito, TotalImporte, TotalIva, Total, TotalIIBB);

                FTmp.Temporizar(FALSE,FALSE,'', '');

                PutSumaryResults;
                ShowModal;
            except
                on E: Exception do
                begin
                    FTmp.Temporizar(FALSE,FALSE,'', '');
                    FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
                    MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)
                end
            end
        finally
            Free;
            Application.ProcessMessages;
        end;
    finally
        aForm.Enabled := True;
    end;
end;

procedure TFIVABook.btnBuscarClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            TotalImporte := '0'; TotalIva := '0'; Total := '0';  TotalIIBB := '0';
            NumeroFacturasA := '0'; NumeroFacturasB := '0'; NumeroNotasCredito := '0';
            GetDates(DateIni,DateFin);
            PutFechas;

            FTmp.Temporizar(TRUE,FALSE,'Libro IVA de Ventas', 'Generando el informe libro de iva ventas.');
            Application.ProcessMessages;

            DoCalculateIVABook(DateIni, DateFin, NumeroFacturasA, NumeroFacturasB, NumeroNotasCredito, TotalImporte, TotalIva, Total, TotalIIBB);
            FTmp.Temporizar(FALSE,FALSE,'','');
            Application.ProcessMessages;
            PutSumaryResults;
        except
            on E: Exception do
            begin
                FTmp.Temporizar(FALSE,FALSE,'','');
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
                MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo' , mtError, [mbOk], mbOk, 0);
            end
        end
    finally
        Enabled := True;
        Application.ProcessMessages
    end
end;

procedure TFIVABook.btnImprimirClick(Sender: TObject);
begin
    try
        FTmp.Temporizar(TRUE,FALSE,'Libro IVA de Ventas', 'Imprimiendo el informe libro de iva ventas.');
        Enabled := False;
        Application.ProcessMessages;

        with  TFIVABookToPrint.Create(Application) do
        try
            try
                Execute(DateIni, DateFin, TotalImporte, TotalIva, Total, NumeroFacturasA, NumeroFacturasB, NumeroNotasCredito, NombreEstacion, NumeroEstacion, TotalIIBB);
                FTmp.Temporizar(FALSE,FALSE,'','');
                Application.ProcessMessages
            except
                on E : Exception do
                begin
                    FTmp.Temporizar(FALSE,FALSE,'','');
                    FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
                    MessageDlg('Generación de Informes.', 'El informe no puede imprimirse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0);
                end
            end
        finally
            Free
        end;
    finally
        Enabled := True;
        Show;
        Application.ProcessMessages
    end
end;

procedure TFIVABook.FormCreate(Sender: TObject);
begin
    bErrorCreando := False;

    if (not MyBD.InTransaction) then MyBD.StartTransaction(td);

    try
        LoockAndDeleteTable(MyBD, 'TTMPBOOKIVA')
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
            MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
            bErrorCreando := True
        end
    end
end;

procedure TFIVABook.FormDestroy(Sender: TObject);
begin
    QTTMPIVABOOK.Close;

    try
        try
            if MyBD.InTransaction then
              Begin
                MyBD.Rollback(td);
              end
            else raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del libro de IVA')
        except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de UIVABook: %s', [E.message]);
                MessageDlg('Generación de Informes.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end
        end
    finally
        FTmp.Temporizar(FALSE,FALSE,'','');
        Application.ProcessMessages;
    end
end;

Function TFIVABook.PutEstacion:string;
begin
    try
       NombreEstacion := fVarios.NombreEstacion;
       NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
       LblNumeroEstacion.Caption := NumeroEstacion;
       LblNombreEstacion.Caption := NombreEstacion;
       Result := NumeroEstacion + ' ' + NombreEstacion;
    finally
    end;
end;

procedure TFIVABook.PutFechas;
begin
    LblIntervaloFechas.Caption := Format ('(%s-%s)', [Copy(DateIni,1,10), Copy(DateFin,1,10)])
end;

procedure TFIVABook.PutSumaryResults;
begin
    try
        TotalImporte := ConviertePuntoEnComa(TotalImporte);
        TotalIva := ConviertePuntoEnComa(TotalIva);
        Total := ConviertePuntoEnComa(Total);
        TotalIIBB := ConviertePuntoEnComa(TotalIIBB);
        EImporteGravado.Text := TotalImporte;
        EImporteIva.Text := TotalIva;
        EImporteTotal.Text := Total;
        EdtTotalFacturasA.Text := NumeroFacturasA;
        EdtTotalFacturasB.Text := NumeroFacturasB;
        EdtTotalNotasCredito.Text := NumeroNotasCredito;
        EImporteIIBB.Text := TotalIIBB;

        with QTTMPIVABOOK do
        begin
            Close;
            sdsQTTMPIVABOOK.SQLConnection := MyBD;
            commandtext := 'SELECT FECHALTA FO, NFACTURA#, CONCEPTO, NOMBRE, TO_CHAR(FECHALTA,''DD/MM/YY'') FECHALTA, IMPONETO, IVA, PORIVA, TOTAL, CUIT_CLI, IIBB FROM TTMPBOOKIVA ORDER BY FO, NFACTURA#';
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPIVABOOK);
            {$ENDIF}
            Open
        end

    finally
        Application.ProcessMessages;
    end;

end;

procedure TFIVABook.btnSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    close;
end;

procedure TFIVABook.BitBtn1Click(Sender: TObject);

const
    F_TTL = 1;   C_TTL = 5;
    F_FEC = 2;   C_FEC = 5;
    F_STT = 3;   C_STT = 1;

    F_INI = 7;

    C_NFA = 3;
    C_NFB = 3;
    C_NNC = 3;

    C_LTT = 5;
    C_TIG = 6;
    C_IVA = 9;
    C_TIB = 10;
    C_TTO = 11;

var
    ExcelApp, ExcelLibro, ExcelHoja: Variant;
    i,f : integer;
begin

  try
    DBGridLibroIVA.DataSource.DataSet.DisableControls;
    try
      opendialog.Title := 'Seleccione la Planilla de Entrada';
      if OpenDialog.Execute then
      begin
        FTmp.Temporizar(TRUE,FALSE,'Libro IVA de Ventas', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        ExcelHoja := ExcelLibro.Worksheets['Hoja1'];

        f:= F_INI;

        excelHoja.cells[F_TTL,C_TTL].value := 'IVA DEBITO FISCAL';
        excelHoja.cells[F_FEC,C_FEC].value := Format('(%S - %S)', [Copy(DateIni,1,10), Copy(DateFin,1,10)]);
        excelHoja.cells[F_STT,C_STT].value := Format('Planta nº: %S.', [PutEstacion]);

        QTTMPIVABOOK.First;
        while not QTTMPIVABOOK.EOF do
        begin
            for i := 0 to DBGridLibroIVA.Columns.Count - 1 do
            begin
    {lo siguiente se hace porque para las columas 6,11 no existen los correspondientes
    campos en la tabla QTTMPIVABOOK, por lo que tira error al buscar el nombre del campo}
                if i in [6,11] then
                else
                  excelHoja.cells[f,i+1].value := QTTMPIVABOOK.FieldByName(DBGridLibroIVA.Columns[i].FieldName).AsString
            end;
            QTTMPIVABOOK.Next;
            inc(f);
        end;
        QTTMPIVABOOK.First;

        if f=F_INI
        then f := f + 1;

        inc(f);
        excelHoja.cells[f,C_NFA-2].value := 'Total Facturas A:';
        ExcelHoja.cells[f,C_NFA].value := edtTotalFacturasA.text;
        excelHoja.cells[f,C_LTT].value := 'TOTALES';
        excelHoja.cells[f,C_TIG].value := EImporteGravado.Text;
        excelHoja.cells[f,C_IVA].value := EImporteIva.Text;
        excelHoja.cells[f,C_TIB].value := EImporteIIBB.Text;
        excelHoja.cells[f,C_TTO].value := EImporteTotal.Text;

        inc(f);
        excelHoja.cells[f,C_NFB-2].value := 'Total Facturas B:';
        excelHoja.cells[f,C_NFB].value := edtTotalFacturasB.text;

        inc(f);
        excelHoja.cells[f,C_NNC-2].value := 'Total N. Crédito:';
        excelHoja.cells[f,C_NNC].value := edtTotalNotasCredito.text;
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
      DBGridLibroIVA.DataSource.DataSet.enableControls;
      FTmp.Temporizar(FALSE,FALSE,'','');
      application.ProcessMessages;
  end;

end;


procedure TFIVABook.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TFIVABook.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;

end.
