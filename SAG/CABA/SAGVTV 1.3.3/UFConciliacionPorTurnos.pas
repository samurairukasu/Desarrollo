unit UFConciliacionPorTurnos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, RXLookup, ComCtrls, USAGESTACION, quickrpt, RXDBCtrl, ComObj,
  FMTBcd, DBClient, Provider, SqlExpr, Dialogs, DBXpress;

type
// ALTER TABLE TTMPRESINSP MODIFY (NUMOBLEA NULL)
// ALTER TABLE TTMPRESINSP MODIFY (FECHALTA VARCHAR2(10));


  TFConciliacion = class(TForm)
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
    OpenDialog: TOpenDialog;
    SQLQuery1: TSQLQuery;
    SQLConnection1: TSQLConnection;
    SpeedbarSection4: TSpeedbarSection;
    SpeedItem1: TSpeedItem;
    QTResultadosInspeccion: TClientDataSet;
    dspquery1: TDataSetProvider;
    sdsquery1: TSQLDataSet;
    procedure FormCreate(Sender: TObject);
    procedure SBBusquedaClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AscciClick(Sender: TObject);
    procedure BExcelClick(Sender: TObject);
    procedure OnOpen (Sender: TObject);
    procedure OnClose (Sender: TObject);
    procedure SBSalirClick(Sender: TObject);
    procedure SpeedItem1Click(Sender: TObject);
  private
    { Private declarations }
     Procedure  ExportacionExcelGeneral;
  public
    { Public declarations }
      bErrorCreando : boolean;
      NombreEstacion, NumeroEstacion,
      DateIni, DateFin, tiempoProm, tiempototal,TotRech,TotAprob,TotAus,TotCond : string;
      function PutEstacion : string;

  end;

    procedure GenerateConciliacion;

  var
    FConciliacion: TFConciliacion;

implementation

{$R *.DFM}


uses
   UCDIALGS, ULOGS,
   UINSPECTIONRESULTS,
   UGETDATES,
   UFTMP,
   GLOBALS,
   UUTILS,
   USAGVARIOS,Ubuscar_inspeccion_por_patente;



resourcestring
      FICHERO_ACTUAL = 'UFResultadosInspeccion';

    procedure GenerateConciliacion;
    begin
        with TFConciliacion.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                If not GetDates(DateIni,DateFin) then Exit;
                Caption := Format('Conciliacion. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                FTmp.Temporizar(TRUE,FALSE,'Conciliacion', 'Generando el informe Conciliacion.');

                Application.ProcessMessages;

                //DoInformesDeInspeccion;

                sdsQuery1.ParamByName('fechaini').AsDatetime:=strtodatetime(dateini);
                sdsQuery1.ParamByName('fechafin').AsDatetime:=strtodatetime(datefin);

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

    function TFConciliacion.PutEstacion : string;
    begin
        NombreEstacion := fVarios.NombreEstacion;
        NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
        Result := NumeroEstacion + ' ' + NombreEstacion;
    end;

    procedure TFConciliacion.FormCreate(Sender: TObject);
    begin
        bErrorCreando := False;

        if (not MyBD.InTransaction) then MyBD.StartTransaction(td);
        try
           // LoockAndDeleteTable(MyBD, 'TTMPRESINSP');

            QTResultadosInspeccion.Close;
            sdsquery1.SQLConnection := MyBD;

        except
            on E:Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
                MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minuts, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
                bErrorCreando := True
            end
        end
    end;

procedure TFConciliacion.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            If not GetDates(DateIni,DateFin) then Exit;

            FTmp.Temporizar(TRUE,FALSE,'Resultados de Inspección', 'Generando el informe informes de inspección.');

            Application.ProcessMessages;

            Caption := Format('Informes de Inspección. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
            QTResultadosInspeccion.Close;
            //DoInformesDeInspeccion;

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

procedure TFConciliacion.PrintClick(Sender: TObject);
begin
                    with TFInspectionsResults.Create(Application) do
                    try
                        Execute(DateIni,DateFin,PutEstacion,tiempoprom, tiempototal, MyBD);
                    finally
                        Free;
                    end;
end;


procedure TFConciliacion.FormDestroy(Sender: TObject);
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

procedure TFConciliacion.AscciClick(Sender: TObject);
begin
                    with TFInspectionsResults.Create(Application) do
                    try
                        ExportaAscii(DateIni,DateFin,PutEstacion,tiempoprom, tiempototal, MyBD);
                    finally
                        Free;
                    end;
end;

procedure TFConciliacion.BExcelClick(Sender: TObject);
begin
  ExportacionExcelGeneral;
end;

procedure TFConciliacion.ExportacionExcelGeneral;
const
    F_TTL = 3;   C_TTL = 5;
    F_STT = 2;   C_STT = 5;
    F_INI = 6;
                 C_TPI = 13;
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
        FTmp.Temporizar(TRUE,FALSE,'Conciliacion', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        ExcelHoja := ExcelLibro.Worksheets[1];

        ExcelHoja.Cells[2,2].value := 'CONCILIACION';
        ExcelHoja.Cells[3,2].value := Format('Planta nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);

        f:= 6;

        QTRESULTADOSINSPECCION.First;
        while not QTRESULTADOSINSPECCION.EOF do
        begin
            for i := 0 to DBReVerificaciones.Columns.Count - 1 do
              ExcelHoja.Cells[f,i+2].value := QTRESULTADOSINSPECCION.FieldByName(DBReVerificaciones.Columns[i].FieldName).AsString;
            QTRESULTADOSINSPECCION.Next;
            inc(f);
        end;
        QTRESULTADOSINSPECCION.First;

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

procedure TFConciliacion.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TFConciliacion.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;

procedure TFConciliacion.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure TFConciliacion.SpeedItem1Click(Sender: TObject);
var
i:longint;
spatente: string;
encontro:boolean;
begin

with Tbuscar_inspeccion_por_patente.Create(application) do
    try

      showmodal;
   spatente:=trim(edit1.Text);

    finally
      free;
    end;



   if trim(spatente)='' then
       exit;


       encontro:=false;
      DBReVerificaciones.DataSource.DataSet.First;
      for i:=0 to   DBReVerificaciones.DataSource.DataSet.RecordCount -1 do
      begin


       if (trim(DBReVerificaciones.DataSource.DataSet.Fields[5].AsString)=spatente) then
           begin
            encontro:=true;
            DBReVerificaciones.SelectedIndex:=i;
            exit;
           end;

        DBReVerificaciones.DataSource.DataSet.Next;
      end;

      if not encontro then
      begin
      DBReVerificaciones.DataSource.DataSet.First;
       MessageDlg('Buscar Patente',Format('No se encontro la patente ', [spatente]), mterror, [mbOk], mbOK, 0);
      end;

end;


end.







