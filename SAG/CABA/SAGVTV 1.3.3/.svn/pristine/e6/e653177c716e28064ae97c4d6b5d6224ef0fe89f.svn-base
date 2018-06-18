unit UlistadoCambioZona;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, UDDEExcelObject, FMTBcd, SqlExpr, Provider, DBClient, ComObj,
  Dialogs;

type
  TFrmListadoCambioZona = class(TForm)
    edtTotalTotal: TEdit;
    DSourceArqueoCaja: TDataSource;
    Label3: TLabel;
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
    QTTMPLISTCAMBZONA: TClientDataSet;
    dspQTTMPLISTCAMBZONA: TDataSetProvider;
    sdsQTTMPLISTCAMBZONA: TSQLDataSet;
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
    Procedure ExportacionExcelGeneral;
  public
    { Public declarations }
    bErrorCreando : boolean;
    NombreEstacion, NumeroEstacion,
    DateIni, DateFin,
    Total: string;
    function PutEstacion : string;
  end;

  
  procedure GenerateListadoCambioZona ;
  procedure DoListadoCambioZona(const FI,FF: string;
                       var sTotal: string);

var
  FrmListadoCambioZona: TFrmListadoCambioZona;

implementation

{$R *.DFM}


uses
   UCDIALGS,
   UUTILS,
   UGETDATES,
   ULOGS,
   GLOBALS,
   uListadoCambioZonaToPrint,
   UFTMP,
   USAGESTACION,
   USAGVARIOS;


resourcestring
    FICHERO_ACTUAL = 'UListadoCambioZona';


procedure DoListadoCambioZona(const FI,FF: string;
                       var sTotal: string);

begin
    DeleteTable(MyBD, 'TTMPLISTCAMBIOZONA');

    with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;

        StoredProcName := 'PQ_LIST_VARIOS.DOLISTADOCAMBIOZONA';
        Prepared := True;
        ParamByName('FECHAINI').Value := FI;
        ParamByName('FECHAFIN').Value := FF;

        ExecProc;

        sTotal := ParamByName('Cantidad').AsString;
        Close;
    finally
        Free
    end
end;


procedure GenerateListadoCambioZona;
begin


        with TFrmListadoCambioZona.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                Total := '0';
                If not GetDates(DateIni,DateFin) then Exit;


                Caption := Format('Listado de Cambios de Zona. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                FTmp.Temporizar(TRUE,FALSE,'Listado de Cambios de Zona', 'Generando el informe listado de Cambios de Zona.');
                Application.ProcessMessages;

                DoListadoCambioZona(DateIni, DateFin, Total);

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

procedure TFrmListadoCambioZona.FormCreate(Sender: TObject);
begin
    bErrorCreando := False;

    if (not MyBD.InTransaction) then MyBD.StartTransaction(td);

    try
        LoockAndDeleteTable(MyBD, 'TTMPLISTCAMBIOZONA')
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
            MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
            bErrorCreando := True
        end
    end
end;

procedure TFrmListadoCambioZona.FormDestroy(Sender: TObject);
begin
    QTTMPLISTCAMBZONA.Close;

    try
        try
            if MyBD.InTransaction then
              Begin
                MyBD.Rollback(td); // MyBD.Commit
              end
            else raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del listado de Vehículos Oficiales')
        except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'Error cerrando la ficha de UListadoVehOficial: %s', [E.message]);
                MessageDlg('Generación de Informes.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end
        end
    finally
        FTmp.Temporizar(FALSE,FALSE,'','');
    end
end;

function TFrmListadoCambioZona.PutEstacion : string;
begin
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
    Result := NumeroEstacion + ' ' + NombreEstacion;
end;

procedure TFrmListadoCambioZona.PutSumaryResults;
var
  fSQL : TStringList;
begin
    try
        Total := ConviertePuntoEnComa(Total);

        EdtTotalTotal.Text := Total;
        fSQL := TStringList.Create;
        with QTTMPLISTCAMBZONA do
        begin
            Close;
            sdsQTTMPLISTCAMBZONA.SQLConnection := MyBD;
            fSQL.Clear;
            fSQL.Add('SELECT TO_CHAR(FECHALTA,''DD/MM/YYYY'') FECHALTA, ');
            fsql.add('NUMINFORME, DOMINIO, MARCAMODELO, NOMBRECLIENTE, ZONAPROC, TO_CHAR(FECHALTA,''YYYY/MM/DD'') FO ');
            fsql.add('FROM TTMPLISTCAMBIOZONA ORDER BY FO, NUMINFORME ');
            CommandText := fSQL.Text;
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTCAMBZONA);
            {$ENDIF}
            Open;
        end
    finally
        Application.ProcessMessages;
    end;
end;


procedure TFrmListadoCambioZona.PrintClick(Sender: TObject);
begin
       with TFListadoCambioZonaToPrint.Create(Application) do
       try
          Execute(DateIni, DateFin, Total, NombreEstacion, NumeroEstacion);
       finally
          Free;
       end;
end;

procedure TFrmListadoCambioZona.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            Total := '0';

            If Not GetDates(DateIni,DateFin) Then Exit;
            Caption := Format('Listado de Cambios de Zona. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
            FTmp.Temporizar(TRUE,FALSE,'Listado de Cambios de Zona','Generando el informe listado de Cambios de Zona.');
            Application.ProcessMessages;

            DoListadoCambioZona(DateIni, DateFin, Total);

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

procedure TFrmListadoCambioZona.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure TFrmListadoCambioZona.AscciClick(Sender: TObject);
begin
     with TFListadoCambioZonaToPrint.Create(Application) do
     try
        ExportaAscii(DateIni, DateFin, Total, NombreEstacion, NumeroEstacion);
     finally
        Free;
     end;
end;

procedure TFrmListadoCambioZona.ExcelClick(Sender: TObject);
begin
  try
    ExportacionExcelGeneral;
  Except
    on E: Exception do
      ShowMessage('Error','Se ha producido un error: '+E.Message);
  end;
end;


Procedure TFrmListadoCambioZona.ExportacionExcelGeneral;
const
F_TTL = 1;
C_TTL = 3;
F_STT = 2;
C_STT = 3;
F_NFA = 4;
C_NFA = 2;
F_INI = 7;
C_LTT = 5;
C_TTO = 6;

var
i,f : integer;
ExcelApp, ExcelLibro, ExcelHoja: Variant;
begin
  try
  DBGridArqueoCaja.DataSource.DataSet.DisableControls;
    try
      Opendialog.Title := 'Seleccione la Planilla de Entrada';
      if OpenDialog.Execute then
      begin
        FTmp.Temporizar(TRUE,FALSE,'Listado de Cambios de Zona', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        ExcelHoja := ExcelLibro.Worksheets[1];
        f:= F_INI;
        ExcelHoja.Cells[F_TTL,C_TTL].value := 'Listado de Cambios de Zona';
        ExcelHoja.Cells[F_STT,C_STT].value := Format('Planta nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
        ExcelHoja.Cells[F_NFA,C_NFA].value := EdtTotalTotal.Text;
        QTTMPLISTCAMBZONA.First;
        while not QTTMPLISTCAMBZONA.EOF do
          begin
            for i := 0 to DBGridArqueoCaja.Columns.Count - 1 do
              ExcelHoja.Cells[f,i+1].value := conviertecomaenpunto(QTTMPLISTCAMBZONA.FieldByName(DBGridArqueoCaja.Columns[i].FieldName).AsString);
            QTTMPLISTCAMBZONA.Next;
          inc(f);
          end;
        Opendialog.Title := 'Seleccione la Planilla de Salida';
        if OpenDialog.Execute then
          excellibro.SaveAs(Opendialog.filename);
        ExcelApp.Quit;
        MessageDlg('Archivo exportado.','La exportación se realizó con exito!', mtInformation, [mbOK],mbOK, 0);
      end;
    except
      on E: Exception do
        begin
        FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de UfListadoCambioZona: %s', [E.message]);
        MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
        end
    end;
  finally
      DBGridArqueoCaja.DataSource.DataSet.enableControls;
      FTmp.Temporizar(FALSE,FALSE,'','');
      application.ProcessMessages;
  end;
end;



procedure TFrmListadoCambioZona.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TFrmListadoCambioZona.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;


end.


