unit UFLiquidacionIVA;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  DB, StdCtrls, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar,  comobj, ToolEdit, CurrEdit, Dialogs, Mask, FMTBcd, DBClient,
  Provider, SqlExpr;

type
  TFrmLiquidacionIVA = class(TForm)
    Label3: TLabel;
    Label6: TLabel;
    ti: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    Print: TSpeedItem;
    Excel: TSpeedItem;
    SBBusqueda: TSpeedItem;
    SBSalir: TSpeedItem;
    Bevel1: TBevel;
    edtTotalNeto: TCurrencyEdit;
    edtTotalIva: TCurrencyEdit;
    edtTotalIvaInsc: TCurrencyEdit;
    edtTotalContable: TCurrencyEdit;
    EdtTotalIIBB: TCurrencyEdit;
    OpenDialog: TOpenDialog;
    sdsQTTMPIVAVENTAS: TSQLDataSet;
    dspQTTMPIVAVENTAS: TDataSetProvider;
    QTTMPIVAVENTAS: TClientDataSet;
    DBGridArqueoCaja: TDBGrid;
    DSourceArqueoCaja: TDataSource;


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
    TotalNeto, TotalIva, TotalIvaNoInsc, TotalContable, TotalIIBB,
    DateIni, DateFin: string;
    function PutEstacion : string;
  end;

  procedure GenerateLiquidacionIVA;
  procedure DoLiquidacionIVA(const FI,FF :string; var aTotalNeto, aTotalIva, aTotalIvaInsc, aTotalContable, aTotalIIBB: string);

var
  FrmLiquidacionIVA: TFrmLiquidacionIVA;

implementation

{$R *.DFM}


uses
   UCDIALGS,
   UUTILS,
   UGETDATES,
   ULOGS,
   GLOBALS,
   UFTMP,
   USAGESTACION,
   USAGVARIOS,
   ufLiquidacionIvaToPrint,
   USAGCLASSES;


resourcestring
    FICHERO_ACTUAL = 'UFLiquidacionIVA.PAS';

    CADENA_ARQUEO_AMBOS = 'Global';
    TIPO_ARQUEO_SOCIOS = 'S';


procedure DoLiquidacionIVA(const FI,FF :string; var aTotalNeto, aTotalIva, aTotalIvaInsc, aTotalContable, aTotalIIBB: string);

begin
    DeleteTable(MyBD, 'TTMPIVAVENTAS');

    with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_LIBRO_IVA.IVAVENTAS';
        Prepared := true;
        ParamByName('FI').Value := FI;
        ParamByName('FF').Value := FF;

        ExecProc;

        aTotalNeto := floattostrf(strtofloat(ParamByName('TotalNeto').AsString),fffixed,8,2);
        aTotalIva := floattostrf(strtofloat(ParamByName('TotalIva').AsString),fffixed,8,2);
        aTotalIvaInsc := floattostrf(strtofloat(ParamByName('TotalIvaInsc').AsString),fffixed,8,2);
        aTotalContable := floattostrf(strtofloat(ParamByName('TotalContable').AsString),fffixed,8,2);
        aTotalIIBB := floattostrf(strtofloat(ParamByName('TotalIIBB').AsString),fffixed,8,2);

        Close;
    finally
        Free
    end
end;

procedure GenerateLiquidacionIVA;
begin

        with TFrmLiquidacionIVA.Create(Application) do
        try
            try
                if bErrorCreando then exit;

                If not GetDates(DateIni,DateFin) then Exit;

                Caption := Format('Liquidación IVA. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                FTmp.Temporizar(TRUE,FALSE,'Liquidación IVA', 'Generando la Liquidación de IVA.');
                Application.ProcessMessages;

                DoLiquidacionIVA(DateIni, DateFin, TotalNeto, TotalIva, TotalIvaNoInsc, TotalContable, TotalIIBB);

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


procedure TFrmLiquidacionIVA.FormCreate(Sender: TObject);
begin
    bErrorCreando := False;

    if (not MyBD.InTransaction) then MyBD.StartTransaction(td);

    try
        LoockAndDeleteTable(MyBD, 'TTMPIVAVENTAS')
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
            MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
            bErrorCreando := True
        end
    end
end;

procedure TFrmLiquidacionIVA.FormDestroy(Sender: TObject);
begin
    QTTMPIVAVENTAS.Close;

    try
        try
            if MyBD.InTransaction then
              Begin
                MyBD.Rollback(td); // MyBD.Commit
              end
            else raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del arqueo de Caja')
        except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'Error cerrando la ficha de UArqueoCaja: %s', [E.message]);
                MessageDlg('Generación de Informes.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end
        end
    finally
        FTmp.Temporizar(FALSE,FALSE,'','');
    end
end;

function TFrmLiquidacionIVA.PutEstacion : string;
begin
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
    Result := NumeroEstacion + ' ' + NombreEstacion;
end;

procedure TFrmLiquidacionIVA.PutSumaryResults;
begin
    try

        TotalNeto := ConviertePuntoEnComa(TotalNeto);
        TotalIVA := ConviertePuntoEnComa(TotalIVA);
        TotalIVANoInsc := ConviertePuntoEnComa(TotalIVANoInsc);
        TotalContable := ConviertePuntoEnComa(TotalContable);
        TotalIIBB := ConviertePuntoEnComa(TotalIIBB);

        EdtTotalNeto.Text := TotalNeto;
        EdtTotalIVA.Text := TotalIVA;
        EdtTotalIVAInsc.text := TotalIVANoInsc;
        EdtTotalContable.text := TotalContable;
        EdtTotalIIBB.Text := TotalIIBB;


        with QTTMPIVAVENTAS do
        begin
            Close;
            sdsQTTMPIVAVENTAS.SQLConnection := MyBD;
            CommandText := 'SELECT DESCRIPCION, NETO, IVAINSCR, IVANOINS, TOTAL, IIBB FROM TTMPIVAVENTAS';
            {$IFDEF TRAZAS}
            FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPIVAVENTAS);
            {$ENDIF}
            Open;
        end
    finally
        Application.ProcessMessages;
    end;
end;


procedure TFrmLiquidacionIVA.PrintClick(Sender: TObject);
begin
      with TFRMLiquidacionIVAToPrint.Create(Application) do
      try
           Execute(DateIni, DateFin, NombreEstacion, NumeroEstacion, TotalNeto, TotalIva, TotalIvaNoInsc, TotalContable, TotalIIBB);
      finally
           Free;
      end;
end;

procedure TFrmLiquidacionIVA.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try

            If Not GetDates(DateIni,DateFin) Then Exit;
            Caption := Format('Liquidación de IVA. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
            FTmp.Temporizar(TRUE,FALSE,'Liquidación IVA','Generando la Liquidación de IVA.');
            Application.ProcessMessages;

            DoLiquidacionIVA(DateIni, DateFin, TotalNeto, TotalIva, TotalIvaNoInsc, TotalContable, TotalIIBB);

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

procedure TFrmLiquidacionIVA.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure TFrmLiquidacionIVA.ExcelClick(Sender: TObject);
const
    F_TTL = 1;   C_TTL = 1;
    F_STT = 3;   C_STT = 1;
    F_FEC = 4;   C_FEC = 1;

    F_INI = 7;

    C_NET = 2;
    C_INS = 3;
    C_NOI = 4;
    C_TIB = 5;
    C_TOT = 6;

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
        FTmp.Temporizar(TRUE,FALSE,'Liquidación IVA', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        ExcelHoja := ExcelLibro.Worksheets['Hoja1'];

        f:= F_INI;


        excelHoja.cells[F_TTL,C_TTL].value := 'Liquidación IVA';
        excelHoja.cells[F_STT,C_STT].value := Format('Planta: %S.', [PutEstacion]);
        excelHoja.cells[F_FEC,C_FEC].value := Format('Fecha:   Desde: %S  |  Hasta: %S', [Copy(DateIni,1,10), Copy(DateFin,1,10)]);


        range := ExcelHoja.range['A1:F25'];


        QTTMPIVAVENTAS.First;
        while not QTTMPIVAVENTAS.EOF do
        begin
             for i := 0 to DBGridArqueoCaja.Columns.Count - 1 do
             begin
                 excelHoja.cells[f,i+1].value := QTTMPIVAVENTAS.FieldByName(DBGridArqueoCaja.Columns[i].FieldName).asstring;
                 range := excelhoja.cells[f,i+1];
                 if i = 0 then
                   range.horizontalAlignment := xlLeft
                 else
                   range.horizontalAlignment := xlRight;
             end;
             QTTMPIVAVENTAS.Next;
             inc(f);
        end;
        QTTMPIVAVENTAS.First;

        if f=F_INI
        then f := f + 1;

        range := excelhoja.cells[f,C_NET];
        range.horizontalAlignment := xlRight;
        excelHoja.cells[f,C_NET].value := edtTotalNeto.Text;
        range := excelhoja.cells[f,C_INS];
        range.horizontalAlignment := xlRight;
        excelHoja.cells[f,C_INS].value := edtTotalIva.Text;
        range := excelhoja.cells[f,C_NOI];
        range.horizontalAlignment := xlRight;
        excelHoja.cells[f,C_NOI].value := edtTotalIvaInsc.Text;
        range := excelhoja.cells[f,C_TIB];
        range.horizontalAlignment := xlRight;
        excelHoja.cells[f,C_TIB].value := edtTotalIIBB.Text;
        range := excelhoja.cells[f,C_TOT];
        range.horizontalAlignment := xlRight;
        excelHoja.cells[f,C_TOT].value := edtTotalContable.Text;
      end;

      opendialog.Title := 'Seleccione la Planilla de Salida';
      if OpenDialog.Execute then
         excellibro.saveas(opendialog.filename);
      ExcelApp.DisplayAlerts := False;  // Discard unsaved files....
      ExcelApp.Quit;
    except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de UIVABook: %s', [E.message]);
                MessageDlg('Generación de Informes.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end
    end;
  finally
      DBGridArqueoCaja.DataSource.DataSet.enableControls;
      FTmp.Temporizar(FALSE,FALSE,'','');
      application.ProcessMessages;
  end;

end;


procedure TFrmLiquidacionIVA.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TFrmLiquidacionIVA.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;


end.
