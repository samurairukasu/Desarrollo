unit UListadoEstadovtv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB,SqlExpr, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, UDDEExcelObject, Dialogs, comobj, FMTBcd, Provider, DBClient;

type
  TFrmListadoEstadoVTV = class(TForm)
    DSourceArqueoCaja: TDataSource;
    ti: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    Print: TSpeedItem;
    SBBusqueda: TSpeedItem;
    SBSalir: TSpeedItem;
    Excel: TSpeedItem;
    Label6: TLabel;
    DBGridArqueoCaja: TDBGrid;
    OpenDialog: TOpenDialog;
    sdsQTTMPLISTCAMBIO: TSQLDataSet;
    QTTMPLISTCAMBIO: TClientDataSet;
    dspQTTMPLISTCAMBIO: TDataSetProvider;
    procedure FormDestroy(Sender: TObject);
    procedure PutSumaryResults;
    procedure PrintClick(Sender: TObject);
    procedure SBBusquedaClick(Sender: TObject);
    procedure SBSalirClick(Sender: TObject);
    procedure ExcelClick(Sender: TObject);
    procedure OnOpen (Sender: TObject);
    procedure OnClose (Sender: TObject);
    procedure ExportacionExcelGeneral;
    procedure FormCreate(Sender: TObject);
  public
    { Public declarations }
    bErrorCreando : boolean;
    NombreEstacion, NumeroEstacion, sEspecie, sDestino: string;
    Especie, Destino : integer;
    function PutEstacion : string;
  end;

  procedure GenerateListadoEstadoVTV;
  procedure DoListadoEstadoVTV(const ES,DE: integer);

var
  FrmListadoEstadoVTV: TFrmListadoEstadoVTV;

implementation

{$R *.DFM}


uses
   UCDIALGS,
   UUTILS,
   uGetEspeDesti,
   ULOGS,
   GLOBALS,
   UListadoEstadoVTVToPrint,
   UFTMP,
   USAGESTACION;


resourcestring
    FICHERO_ACTUAL = 'UListadoEstadovtv.PAS';


procedure DoListadoEstadoVTV(const ES,DE: integer);

begin
    DeleteTable(MyBD, ' TTMPLISTTRANSPORTE');

    with TSQLStoredProc.Create(application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_LIST_VARIOS.DOLISTADOTRANSPORTES';
        ParamByName('CODESPE').Value := ES;
        ParamByName('CODDESTINO').Value := DE;

        ExecProc;

        Close;
    finally
        Free
    end
end;


procedure GenerateListadoEstadoVTV;
begin

        with TFrmListadoEstadoVTV.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                If not GetEspeDesti(Especie,Destino, sEspecie, sDestino) then Exit;

                Caption := Format('Listado Estado VTV y Cantidad de Inspecciones. Planta: %S. ', [PutEstacion]);
                FTmp.Temporizar(TRUE,FALSE,'Listado Estado VTV y Cantidad de Inspecciones','Generando el informe Estado VTV y Cantidad de Inspecciones.');
                Application.ProcessMessages;

                DoListadoEstadoVTV(Especie, Destino);

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

procedure TFrmListadoEstadoVTV.FormDestroy(Sender: TObject);
begin
    QTTMPLISTCAMBIO.Close;

    try
        try
            if MyBD.InTransaction then
              Begin
                MyBD.Rollback(td); // MyBD.Commit
              end
            else raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del listado de Estado VTV')
        except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'Error cerrando la ficha de UListadoEstadoVTV: %s', [E.message]);
                MessageDlg('Generación de Informes.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end
        end
    finally
        FTmp.Temporizar(FALSE,FALSE,'','');
    end
end;

function TFrmListadoEstadoVTV.PutEstacion : string;
begin
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
    Result := NumeroEstacion + ' ' + NombreEstacion;
end;


procedure TFrmListadoEstadoVTV.PutSumaryResults;
begin
    try

        with QTTMPLISTCAMBIO do
        begin
            Close;
            sdsQTTMPLISTCAMBIO.SQLConnection := MyBD;
            sdsQTTMPLISTCAMBIO.CommandText := 'SELECT DOMINIO, CANTINSP, ESTADO, ULTFECVENCI FROM  TTMPLISTTRANSPORTE ORDER BY DOMINIO ';
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTCAMBIO);
            {$ENDIF}

            Open;
        end
    finally
        Application.ProcessMessages;
    end;
end;


procedure TFrmListadoEstadoVTV.PrintClick(Sender: TObject);
begin
       with TFListadoEstadoVtvToPrint.Create(Application) do
       try
          Execute(sEspecie, sDestino, NombreEstacion, NumeroEstacion);
       finally
          Free;
       end;
end;

procedure TFrmListadoEstadoVTV.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try

            If Not GetEspeDesti(Especie,Destino, sEspecie, sDestino) Then Exit;
            Caption := Format('Listado Estado VTV y Cantidad de Inspecciones. Planta: %S. ', [PutEstacion]);
            FTmp.Temporizar(TRUE,FALSE,'Listado Estado VTV y Cantidad de Inspecciones','Generando el informe Estado VTV y Cantidad de Inspecciones.');
            Application.ProcessMessages;

            DoListadoEstadoVTV(Especie, Destino);

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

procedure TFrmListadoEstadoVTV.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure TFrmListadoEstadoVTV.ExcelClick(Sender: TObject);
var
    i,f : integer;
    ExcelApp, ExcelLibro, ExcelHoja: Variant;
const
     F_INI = 5;
     F_TTL = 1;   C_TTL = 2;
     F_STT = 2;   C_STT = 2;

begin


  f:= F_INI;
  opendialog.Title := 'Seleccione la Planilla de Entrada';
  if OpenDialog.Execute then   // para seleccionar el archivo
  begin

    ExcelApp := CreateOleObject('Excel.Application');
    ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
    ExcelHoja := ExcelLibro.Worksheets['Hoja1'];


    excelHoja.cells[F_TTL, C_TTL].Value := 'Listado de Estado VTV y Cantidad de Inspecciones';
    excelHoja.cells[F_STT, C_STT].Value := sEspecie+' '+sDestino;

    QTTMPLISTCAMBIO.First;
    while not QTTMPLISTCAMBIO.EOF do
    begin
        for i := 0 to DBGridArqueoCaja.Columns.Count - 1 do
            excelHoja.cells[f,i+1].value := QTTMPLISTCAMBIO.FieldByName(DBGridArqueoCaja.Columns[i].FieldName).AsString;
        QTTMPLISTCAMBIO.Next;
        inc(f);
    end;
  end;

  opendialog.Title := 'Seleccione la Planilla de Salida';
  if OpenDialog.Execute then
    excellibro.saveas(opendialog.filename);

  ExcelApp.Quit;


end;


Procedure TFrmListadoEstadoVTV.ExportacionExcelGeneral;
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
        FTmp.Temporizar(TRUE,FALSE,'Estado VTV', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        ExcelHoja := ExcelLibro.Worksheets[1];
        F:= F_INI;
        ExcelHoja.Cells[F_TTL,C_TTL].value:='Listado Cambio Fecha de Vencimiento';
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
  except
    on E: Exception do
      begin
        FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de UfListadoEstadoVTV: %s', [E.message]);
        MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
      end
  end;
end;

procedure TFrmListadoEstadoVTV.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TFrmListadoEstadoVTV.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;


procedure TFrmListadoEstadoVTV.FormCreate(Sender: TObject);
begin
    if (not MyBD.InTransaction) then MyBD.StartTransaction(td);
end;

end.


