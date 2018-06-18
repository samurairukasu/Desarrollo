unit UFtotal_diario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, RXLookup, ComCtrls, USAGESTACION, quickrpt, RXDBCtrl, ComObj,
  FMTBcd, DBClient, Provider, SqlExpr, Dialogs, DBXpress, RxMemDS;

type
// ALTER TABLE TTMPRESINSP MODIFY (NUMOBLEA NULL)
// ALTER TABLE TTMPRESINSP MODIFY (FECHALTA VARCHAR2(10));


  Tfrtotaldiario = class(TForm)
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
    OpenDialog: TOpenDialog;
    SQLQuery1: TSQLQuery;
    SQLConnection1: TSQLConnection;
    SpeedbarSection4: TSpeedbarSection;
    SpeedItem1: TSpeedItem;
    QTResultadosInspeccion: TClientDataSet;
    dspquery1: TDataSetProvider;
    sdsquery1: TSQLDataSet;
    SQLStoredProc1: TSQLStoredProc;
    SaveDialog1: TSaveDialog;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    RxMemoryData1: TRxMemoryData;
    RxMemoryData1vehiculo: TStringField;
    RxMemoryData1neto: TStringField;
    RxMemoryData1iva: TStringField;
    RxMemoryData1total: TStringField;
    RadioGroup1: TRadioGroup;
    DBGrid2: TDBGrid;
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
    procedure DBReVerificacionesTitleBtnClick(Sender: TObject;
      ACol: Integer; Field: TField);
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

    procedure Generatetotales_diarios;

  var
    frtotaldiario: Tfrtotaldiario;

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

    procedure Generatetotales_diarios;
    var sql_moto,sql_auto,sql_TOTAL:string;
    Sentencia : TSQLQuery;
    begin
        with Tfrtotaldiario.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                If not GetDates(DateIni,DateFin) then Exit;
                Caption := Format('Reporte de Totales Diarios. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);

                 label5.caption := Format('Reporte de Totales Diarios. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);

                FTmp.Temporizar(TRUE,FALSE,'Reporte Administración.', 'Generando el informe Reporte Totales Diarios.');

                Application.ProcessMessages;

                RxMemoryData1.Close;
                RxMemoryData1.open;
                {sdsQuery1.ParamByName('fechaini').AsDatetime:=strtodatetime(dateini);
                sdsQuery1.ParamByName('fechafin').AsDatetime:=strtodatetime(datefin);
                  }

                   sql_moto:=' select sum(case when tf.tipfactu=''B'' then  ROUND((tf.IMPONETO / (1+(tf.IVAINSCR/100))),2)  else imponeto end) AS IMPONETO,   '+
                              ' sum(IMPONETO) as IMPOBRUTO , '+
                              ' (sum(IMPONETO) - sum(case when tf.tipfactu=''B'' then  ROUND((tf.IMPONETO / (1+(tf.IVAINSCR/100))),2)  else imponeto end) ) as iva  '+

                             '  from tfacturas tf,  tvehiculos tv '+
                            ' where tf.codvehic=tv.codvehic and tv.tipoespe in (1,2,3,4,5)  '+
                            ' and tf.fechalta  between to_date('+#39+dateini+#39+',''dd/mm/yyyy hh24:mi:ss'') and  to_date('+#39+DateFin+#39+',''dd/mm/yyyy hh24:mi:ss'') ';



                   Sentencia := TSQLQuery.Create(Application);
                   Sentencia.SQLConnection:= mybd;
                   Sentencia.Close;
                   Sentencia.SQL.Add(sql_moto);
                   Sentencia.open;
                   while not Sentencia.Eof do
                   begin
                        RxMemoryData1.Append;
                        RxMemoryData1vehiculo.Value:='MOTOVEHICULOS';
                        RxMemoryData1neto.Value:=trim(Sentencia.fieldbyname('IMPONETO').asstring);
                        RxMemoryData1iva.Value:=trim(Sentencia.fieldbyname('iva').asstring);
                        RxMemoryData1total.Value:=trim(Sentencia.fieldbyname('IMPOBRUTO').asstring);
                        RxMemoryData1.Post;
                   Sentencia.Next;
                   end;


                   Sentencia.close;
                   Sentencia.Free;


                 sql_auto:=' select sum(case when tf.tipfactu=''B'' then  ROUND((tf.IMPONETO / (1+(tf.IVAINSCR/100))),2)  else imponeto end) AS IMPONETO,   '+
                              ' sum(IMPONETO) as IMPOBRUTO, '+
                              '  (sum(IMPONETO) - sum(case when tf.tipfactu=''B'' then  ROUND((tf.IMPONETO / (1+(tf.IVAINSCR/100))),2)  else imponeto end) ) as iva  '+
                              '  from tfacturas tf,  tvehiculos tv '+
                              ' where tf.codvehic=tv.codvehic and tv.tipoespe in (6,7,8,9)  '+
                              ' and tf.fechalta  between to_date(''01/11/2016'',''dd/mm/yyyy'') and  to_date(''30/11/2016'',''dd/mm/yyyy'') ';



                   Sentencia := TSQLQuery.Create(Application);
                   Sentencia.SQLConnection:= mybd;
                   Sentencia.Close;
                   Sentencia.SQL.Add(sql_auto);
                   Sentencia.open;
                   while not Sentencia.Eof do
                   begin
                        RxMemoryData1.Append;
                        RxMemoryData1vehiculo.Value:='AUTOMOVILES';
                        RxMemoryData1neto.Value:=trim(Sentencia.fieldbyname('IMPONETO').asstring);
                        RxMemoryData1iva.Value:=trim(Sentencia.fieldbyname('iva').asstring);
                        RxMemoryData1total.Value:=trim(Sentencia.fieldbyname('IMPOBRUTO').asstring);
                        RxMemoryData1.Post;
                   Sentencia.Next;
                   end;


                   Sentencia.close;
                   Sentencia.Free;


                      sql_TOTAL:=' select sum(case when tf.tipfactu=''B'' then  ROUND((tf.IMPONETO / (1+(tf.IVAINSCR/100))),2)  else imponeto end) AS IMPONETO,   '+
                              ' sum(IMPONETO) as IMPOBRUTO,  '+
                              ' (sum(IMPONETO) - sum(case when tf.tipfactu=''B'' then  ROUND((tf.IMPONETO / (1+(tf.IVAINSCR/100))),2)  else imponeto end) ) as iva  '+
                              '  from tfacturas tf,  tvehiculos tv '+
                              ' where tf.codvehic=tv.codvehic   '+
                              ' and tf.fechalta  between to_date('+#39+dateini+#39+',''dd/mm/yyyy hh24:mi:ss'') and  to_date('+#39+DateFin+#39+',''dd/mm/yyyy hh24:mi:ss'') ';



                   Sentencia := TSQLQuery.Create(Application);
                   Sentencia.SQLConnection:= mybd;
                   Sentencia.Close;
                   Sentencia.SQL.Add(sql_TOTAL);
                   Sentencia.open;
                   while not Sentencia.Eof do
                   begin
                        RxMemoryData1.Append;
                        RxMemoryData1vehiculo.Value:='TOTAL';
                        RxMemoryData1neto.Value:=trim(Sentencia.fieldbyname('IMPONETO').asstring);
                        RxMemoryData1iva.Value:=trim(Sentencia.fieldbyname('iva').asstring);
                        RxMemoryData1total.Value:=trim(Sentencia.fieldbyname('IMPOBRUTO').asstring);
                        RxMemoryData1.Post;
                   Sentencia.Next;
                   end;


                   Sentencia.close;
                   Sentencia.Free;

               // QTResultadosInspeccion.Open;

                FTmp.Temporizar(FALSE,FALSE,'', '');
                ShowModal;
            except
                on E: Exception do
                begin
                    FTmp.Temporizar(FALSE,FALSE,'', '');
                    Application.ProcessMessages;
                    FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
                    MessageDlg('Generación de Totales Diarios..', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)
                end
            end
        finally
            Free;
            Application.ProcessMessages;
        end;
    end;

    function Tfrtotaldiario.PutEstacion : string;
    begin
        NombreEstacion := fVarios.NombreEstacion;
        NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
        Result := NumeroEstacion + ' ' + NombreEstacion;
    end;

    procedure Tfrtotaldiario.FormCreate(Sender: TObject);
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

procedure Tfrtotaldiario.SBBusquedaClick(Sender: TObject);
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

procedure Tfrtotaldiario.PrintClick(Sender: TObject);
begin
                    with TFInspectionsResults.Create(Application) do
                    try
                        Execute(DateIni,DateFin,PutEstacion,tiempoprom, tiempototal, MyBD);
                    finally
                        Free;
                    end;
end;


procedure Tfrtotaldiario.FormDestroy(Sender: TObject);
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

procedure Tfrtotaldiario.AscciClick(Sender: TObject);
begin
                    with TFInspectionsResults.Create(Application) do
                    try
                        ExportaAscii(DateIni,DateFin,PutEstacion,tiempoprom, tiempototal, MyBD);
                    finally
                        Free;
                    end;
end;

procedure Tfrtotaldiario.BExcelClick(Sender: TObject);
begin
  ExportacionExcelGeneral;
end;

procedure Tfrtotaldiario.ExportacionExcelGeneral;
const
    F_TTL = 3;   C_TTL = 5;
    F_STT = 2;   C_STT = 5;
    F_INI = 6;
                 C_TPI = 13;
var
    i,f : integer;
    ExcelApp, ExcelLibro, ExcelHoja: Variant;
begin
 { try
   DBReVerificaciones.DataSource.DataSet.DisableControls;
    try
      opendialog.Title := 'Seleccione la Planilla de Entrada';
     // if OpenDialog.Execute then
      //begin
        FTmp.Temporizar(TRUE,FALSE,'Reporte Administración', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.add;
        //ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        ExcelHoja := ExcelLibro.Worksheets[1];

        ExcelHoja.Cells[2,2].value := 'Reporte Administración';
        ExcelHoja.Cells[3,2].value := Format('Planta nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);

        for i := 0 to DBReVerificaciones.Columns.Count - 1 do
           ExcelHoja.Cells[5,i+1].value :=DBReVerificaciones.Columns[i].Title.Caption;

        f:= 6;

        QTRESULTADOSINSPECCION.First;
        while not QTRESULTADOSINSPECCION.EOF do
        begin
            for i := 0 to DBReVerificaciones.Columns.Count - 1 do
              ExcelHoja.Cells[f,i+1].value := QTRESULTADOSINSPECCION.FieldByName(DBReVerificaciones.Columns[i].FieldName).AsString;
            QTRESULTADOSINSPECCION.Next;
            inc(f);
        end;
        QTRESULTADOSINSPECCION.First;

     
      SaveDialog1.Title := 'Seleccione la Planilla de Salida';
      if SaveDialog1.Execute then
         excellibro.saveas(SaveDialog1.filename);
      ExcelApp.Quit;
    except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de Reporte Administración: %s', [E.message]);
                MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
            end
    end;
  finally
     // DBReVerificaciones.DataSource.DataSet.enableControls;
      FTmp.Temporizar(FALSE,FALSE,'','');
      application.ProcessMessages;
  end;     }
end;

procedure Tfrtotaldiario.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure Tfrtotaldiario.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;

procedure Tfrtotaldiario.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure Tfrtotaldiario.SpeedItem1Click(Sender: TObject);
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


     {  encontro:=false;
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
      end; }

end;


procedure Tfrtotaldiario.DBReVerificacionesTitleBtnClick(
  Sender: TObject; ACol: Integer; Field: TField);
begin
{if  DBReVerificaciones.Columns[ACol].Title.Caption='FECHA TURNO'  then
       MessageDlg('Buscar Patente','No se encontro la patente ', mterror, [mbOk], mbOK, 0);
 }
end;

end.







