unit UARQUEOCAJATOTALES;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB, SQLExpr, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, UDDEExcelObject, USagClasses;

type
  TFArqueoCajaExtTot = class(TForm)
    lblTotalNotasCredito: TLabel;
    edtTotalImporteVTV: TEdit;
    edtTotalCDVTV: TEdit;
    edtTotalFacturas: TEdit;
    edtTotalNotasCredito: TEdit;
    edtTotalIVANOInscriptoVTV: TEdit;
    edtTotalIVAVTV: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
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
    Label5: TLabel;
    edtTotalImporteGNC: TEdit;
    edtTotalIVAGNC: TEdit;
    edtTotalCDGNC: TEdit;
    edtTotalFacturasGNC: TEdit;
    edtTotalNotasCreditoGNC: TEdit;
    edtTotalIVANOInscriptoGNC: TEdit;
    Label6: TLabel;
    edtTotalImporteTT: TEdit;
    edtTotalIVATT: TEdit;
    edtTotalCD: TEdit;
    edtTotalFacturasTT: TEdit;
    edtTotalNotasCreditoTT: TEdit;
    edtTotalIVANOInscriptoTT: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    EdtIIBBvtv: TEdit;
    EdtIIBBgnc: TEdit;
    EdtTotalIIBB: TEdit;
    EdtTotalVTV: TEdit;
    EdtTotalGNC: TEdit;
    EdtTotalTotal: TEdit;
    Label9: TLabel;
    Label10: TLabel;
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
    TotalImporteVTV, TotalImporteGNC,
    TotalIvaVTV, TotalIvaGNC,
    TotalIvaNIVTV, TotalIvaNoInscriptoGNC,
    TotalCDVTV, TotalCDGNC, TotalIIBBVTV, TotalTotalVTV,
    TotalIIBBGNC, TotalTotalGNC,
    NumeroFacturas, NumeroFacturasGNC,
    NumeroNotasCredito, NumeroNotasCreditoGNC,
    aTipoCliente : string;
    function PutTipoPago : string;
    function PutEstacion : string;

  end;

  procedure GenerateArqueoCajaTotales;
  procedure DoArqueoCajaTotales(const FI,FF: string;
                         var sTotFactVTV, sTotNCVTV, sTotImpVTV, sTotIVAInsVTV, sTotIVANoInsVTV, sTotCDVTV, sTotIBBVTV, sTotTotVTV: string; sTipoCliente:string;
                         var sTotFactGNC, sTotNCGNC, sTotImpGNC, sTotIVAInsGNC, sTotIVANoInsGNC, sTotCDGNC, sTotIBBGNC, sTotTotGNC : string);

var
  FArqueoCajaExtTot: TFArqueoCajaExtTot;

implementation

{$R *.DFM}

uses
   UCDIALGS,
   UUTILS,
   UGETDATES,
   ULOGS,
   GLOBALS,
   UARQUEOCAJAEXTENDEDtotTOPRINT,
   UFTMP,
   USAGESTACION,
   USAGVARIOS;


resourcestring
    FICHERO_ACTUAL = 'UArqueoCajaTotales.PAS';

procedure DoArqueoCajaTotales(const FI,FF: string;
                         var sTotFactVTV, sTotNCVTV, sTotImpVTV, sTotIVAInsVTV, sTotIVANoInsVTV, sTotCDVTV, sTotIBBVTV, sTotTotVTV: string; sTipoCliente:string;
                         var sTotFactGNC, sTotNCGNC, sTotImpGNC, sTotIVAInsGNC, sTotIVANoInsGNC, sTotCDGNC, sTotIBBGNC, sTotTotGNC : string);
begin

    with TSQLStoredProc.Create(application) do
    try
        SQLConnection := MyBD;

        StoredProcName := 'PQ_ARQUEO_VTV.DOTOTALESCAJACONTADO';

        Prepared := true;
        ParamByName('FECHAINI').Value := FI;
        ParamByName('FECHAFIN').Value := FF;

        ExecProc;
        sTotFactVTV := ParamByName('numfacturas').AsString;
        sTotNCVTV := ParamByName('numcontrafacturas').AsString;
        sTotImpVTV := floattostrf(strtofloat(ParamByName('debeencaja').AsString),fffixed,8,2);
        sTotIVAInsVTV := floattostrf(strtofloat(ParamByName('ivaencaja').AsString),fffixed,8,2);
        sTotIVANoInsVTV := floattostrf(strtofloat(ParamByName('ivanoinscriptoencaja').AsString),fffixed,8,2);
        sTotCDVTV := floattostrf(strtofloat(ParamByName('totalencaja').AsString),fffixed,8,2);
        sTotIBBVTV := floattostrf(strtofloat(ParamByName('IIBBEnCaja').AsString),fffixed,8,2);
        sTotTotVTV := floattostrf(strtofloat(ParamByName('TotalGlobal').AsString),fffixed,8,2);
        Close;

        StoredProcName := 'PQ_ARQUEO_GNC.DOTOTALESCAJACONTADOGNC';

        Prepared := true;
        ParamByName('FECHAINI').Value := FI;
        ParamByName('FECHAFIN').Value := FF;

        ExecProc;
        sTotFactGNC := ParamByName('numfacturas').AsString;
        sTotNCGNC := ParamByName('numcontrafacturas').AsString;
        sTotImpGNC := floattostrf(strtofloat(ParamByName('debeencaja').AsString),fffixed,8,2);
        sTotIVAInsGNC := floattostrf(strtofloat(ParamByName('ivaencaja').AsString),fffixed,8,2);
        sTotIVANoInsGNC := floattostrf(strtofloat(ParamByName('ivanoinscriptoencaja').AsString),fffixed,8,2);
        sTotCDGNC := floattostrf(strtofloat(ParamByName('totalencaja').AsString),fffixed,8,2);
        sTotIBBGNC := floattostrf(strtofloat(ParamByName('IIBBEnCaja').AsString),fffixed,8,2);
        sTotTotGNC := floattostrf(strtofloat(ParamByName('TotalGlobal').AsString),fffixed,8,2);

        Close;
    finally
        Free
    end
end;


procedure GenerateArqueoCajaTotales;
begin

        with TFArqueoCajaExtTot.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                TotalImporteVTV := '0'; TotalIvaVTV := '0';  TotalIvaNIVTV := '0';
                TotalCDVTV := '0'; NumeroFacturas := '0'; NumeroNotasCredito := '0';
                TotalImporteGNC := '0'; TotalIvaGNC := '0';  TotalIvaNoInscriptoGNC := '0';
                TotalCDGNC := '0'; NumeroFacturasGNC := '0'; NumeroNotasCreditoGNC := '0';
                TotalIIBBVTV := '0'; TotalTotalVTV := '0'; TotalIIBBGNC := '0'; TotalTotalGNC := '0';
                If not GetDates(DateIni,DateFin) then Exit;

                Caption := Format('Totales de Caja. Planta: %S. (%S - %S) %S', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10), PutTipoPago]);
                FTmp.Temporizar(TRUE,FALSE,'Totales de Caja', 'Generando el informe totales de caja.');
                Application.ProcessMessages;

                DoArqueoCajaTotales(DateIni, DateFin, NumeroFacturas, NumeroNotasCredito, TotalImporteVTV, TotalIvaVTV, TotalIvaNIVTV, TotalCDVTV,TotalIIBBVTV, TotalTotalVTV,'',
                                    NumeroFacturasGNC, NumeroNotasCreditoGNC, TotalImporteGNC, TotalIvaGNC, TotalIvaNoInscriptoGNC, TotalCDGNC, TotalIIBBGNC, TotalTotalGNC );

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

procedure TFArqueoCajaExtTot.FormCreate(Sender: TObject);
begin
    bErrorCreando := False;

    if (not MyBD.InTransaction) then MyBD.StartTransaction(td);

    try

    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
            MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
            bErrorCreando := True
        end
    end
end;

procedure TFArqueoCajaExtTot.FormDestroy(Sender: TObject);
begin

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

function TFArqueoCajaExtTot.PutEstacion : string;
begin
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
    Result := NumeroEstacion + ' ' + NombreEstacion;
end;


function TFArqueoCajaExtTot.PutTipoPago : string;
begin
        result :=  S_FORMA_PAGO[tfpMetalico]+', '+S_FORMA_PAGO[tfpCheque];
        TipoPago := V_FORMA_PAGO[tfpMetalico];
end;

procedure TFArqueoCajaExtTot.PutSumaryResults;
begin
    try
        TotalImporteVTV := ConviertePuntoEnComa(TotalImporteVTV);
        TotalIvaVTV := ConviertePuntoEnComa(TotalIvaVTV);
        TotalIvaNIVTV := ConviertePuntoEnComa(TotalIvaNIVTV);
        TotalCDVTV := ConviertePuntoEnComa(TotalCDVTV);
        TotalIIBBVTV := ConviertePuntoEnComa(TotalIIBBVTV);
        TotalTotalVTV := ConviertePuntoEnComa(TotalTotalVTV);

        TotalImporteGNC := ConviertePuntoEnComa(TotalImporteGNC);
        TotalIvaGNC := ConviertePuntoEnComa(TotalIvaGNC);
        TotalIvaNoInscriptoGNC := ConviertePuntoEnComa(TotalIvaNoInscriptoGNC);
        TotalCDGNC := ConviertePuntoEnComa(TotalCDGNC);
        TotalIIBBGNC := ConviertePuntoEnComa(TotalIIBBGNC);
        TotalTotalGNC := ConviertePuntoEnComa(TotalTotalGNC);


        EdtTotalImporteVTV.Text := TotalImporteVTV;
        EdtTotalIVAVTV.Text := TotalIvaVTV;
        EdtTotalIVANOInscriptoVTV.Text := TotalIvaNIVTV;
        edtTotalCDVTV.Text := TotalCDVTV;
        EdtIIBBvtv.Text := TotalIIBBVTV;
        EdtTotalVTV.Text := TotalTotalVTV;

        EdtTotalImporteGNC.Text := TotalImporteGNC;
        EdtTotalIVAGNC.Text := TotalIvaGNC;
        EdtTotalIVANOInscriptoGNC.Text := TotalIvaNoInscriptoGNC;
        EdtTotalCDGNC.Text := TotalCDGNC;
        EdtIIBBgnc.Text := TotalIIBBgnc;
        EdtTotalgnc.Text := TotalTotalgnc;



        EdtTotalFacturas.Text := NumeroFacturas;
        EdtTotalNotasCredito.Text := NumeroNotasCredito;

        EdtTotalFacturasGNC.Text := NumeroFacturasGNC;
        EdtTotalNotasCreditoGNC.Text := NumeroNotasCreditoGNC;

        EdtTotalImporteTT.Text := floattostrf(strtofloat(TotalImporteVTV)+strtofloat(TotalImporteGNC),fffixed,8,2);
        EdtTotalIVATT.Text := floattostrf(strtofloat(TotalIvaVTV)+strtofloat(TotalIvaGNC),fffixed,8,2);
        EdtTotalIVANOInscriptoTT.Text := floattostrf(strtofloat(TotalIvaNIVTV)+strtofloat(TotalIvaNoInscriptoGNC),fffixed,8,2);
        edtTotalCD.Text := floattostrf(strtofloat(TotalCDVTV)+strtofloat(TotalCDGNC),fffixed,8,2);
        EdtTotalIIBB.text := floattostrf(strtofloat(TotalIIBBVTV)+strtofloat(TotalIIBBgnc),fffixed,8,2);
        EdtTotalTotal.text := floattostrf(strtofloat(TotalTotalVTV)+strtofloat(TotalTotalgnc),fffixed,8,2);

        EdtTotalFacturasTT.Text := floattostrf(strtofloat(NumeroFacturas)+strtofloat(NumeroFacturasGNC),fffixed,8,0);
        EdtTotalNotasCreditoTT.Text := floattostrf(strtofloat(NumeroNotasCredito)+strtofloat(NumeroNotasCreditoGNC),fffixed,8,0);

    finally
        Application.ProcessMessages;
    end;
end;


procedure TFArqueoCajaExtTot.PrintClick(Sender: TObject);
begin
    with TFArqueoCajaExtendedTotToPrint.Create(Application) do
    try
       Execute(DateIni, DateFin, TotalImporteVTV, TotalIvaVTV, TotalIvaNIVTV, TotalCDVTV, NumeroFacturas, NumeroNotasCredito, PutTipoPago, NombreEstacion, NumeroEstacion, aTipoCliente,
       TotalImporteGNC, TotalIvaGNC, TotalIvaNoInscriptoGNC, TotalCDGNC, NumeroFacturasGNC, NumeroNotasCreditoGNC, TotalIIBBVTV, TotalTotalVTV, TotalIIBBGNC, TotalTotalGNC);
    finally
       Free;
    end;
end;

procedure TFArqueoCajaExtTot.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            TotalImporteVTV := '0'; TotalIvaVTV := '0';  TotalIvaNIVTV := '0';
            TotalCDVTV := '0'; NumeroFacturas := '0'; NumeroNotasCredito := '0';
            TotalImporteGNC := '0'; TotalIvaGNC := '0';  TotalIvaNoInscriptoGNC := '0';
            TotalCDGNC := '0'; NumeroFacturasGNC := '0'; NumeroNotasCreditoGNC := '0';
            TotalIIBBVTV := '0'; TotalTotalVTV := '0'; TotalIIBBGNC := '0'; TotalTotalGNC := '0';

            If Not GetDates(DateIni,DateFin) Then Exit;
            Caption := Format('Totales de Caja. Planta: %S. (%S - %S) %S', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10), PutTipoPago]);
            FTmp.Temporizar(TRUE,FALSE,'Totales de Caja','Generando el informe totales de caja.');
            Application.ProcessMessages;

            DoArqueoCajaTotales(DateIni, DateFin, NumeroFacturas, NumeroNotasCredito, TotalImporteVTV, TotalIvaVTV, TotalIvaNIVTV, TotalCDVTV,TotalIIBBVTV, TotalTotalVTV,'',
                                NumeroFacturasGNC, NumeroNotasCreditoGNC, TotalImporteGNC, TotalIvaGNC, TotalIvaNoInscriptoGNC, TotalCDGNC,TotalIIBBGNC, TotalTotalGNC );

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

procedure TFArqueoCajaExtTot.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;


procedure TFArqueoCajaExtTot.AscciClick(Sender: TObject);
begin
     with TFArqueoCajaExtendedToTtoPrint.Create(Application) do
          try
             ExportaAscii(DateIni, DateFin, TotalImporteVTV, TotalIvaVTV, TotalIvaNIVTV, TotalCDVTV, NumeroFacturas, NumeroNotasCredito, PutTipoPago, NombreEstacion, NumeroEstacion, aTipoCliente,
                    TotalImporteGNC, TotalIvaGNC, TotalIvaNoInscriptoGNC, TotalCDGNC, NumeroFacturasGNC, NumeroNotasCreditoGNC, TotalIIBBVTV, TotalTotalVTV, TotalIIBBGNC, TotalTotalGNC);
          finally
             Free;
          end;
end;

procedure TFArqueoCajaExtTot.ExcelClick(Sender: TObject);
begin
  ExportacionExcelGeneral;
end;


Procedure TFArqueoCajaExtTot.ExportacionExcelGeneral;
const
    F_TTL = 1;   C_TTL = 4;
    F_STT = 2;   C_STT = 4;
    F_TPG = 6;   C_TPG = 2;
    F_NFA = 8;   C_NFA = 2;
    F_NAB = 9;   C_NAB = 2;

    F_TIM = 10;
    F_IVA = 11;
    F_IVN = 12;
    F_TCD = 13;
    F_TIB = 14;
    F_TTO = 15;

var
i,f : integer;
ExcelApp, ExcelLibro, ExcelHoja: Variant;

begin
    try
      ExcelHoja.Cells[F_TTL,C_TTL].value:='Totales de Caja';
      ExcelHoja.Cells[F_STT,C_STT].value:=Format('Planta Nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
      ExcelHoja.Cells[F_TPG,C_TPG].value:=PutTipoPago;

      ExcelHoja.Cells[F_NFA,C_NFA].value:=EdtTotalFacturas.Text;
      ExcelHoja.Cells[F_NAB,C_NAB].value:=EdtTotalNotasCredito.Text;

      ExcelHoja.Cells[F_TIM,C_NFA].value:=EdtTotalImporteVTV.Text;
      ExcelHoja.Cells[F_IVA,C_NFA].value:=EdtTotalIVAVTV.Text;
      ExcelHoja.Cells[F_IVN,C_NFA].value:=EdtTotalIVANOInscriptoVTV.Text;
      ExcelHoja.Cells[F_TCD,C_NFA].value:=edtTotalCDVTV.Text;
      ExcelHoja.Cells[F_TIB,C_NFA].value:=EdtIIBBvtv.Text;
      ExcelHoja.Cells[F_TTO,C_NFA].value:=EdtTotalVTV.Text;

      ExcelHoja.Cells[F_NFA,C_NFA+1].value:=EdtTotalFacturasGNC.Text;
      ExcelHoja.Cells[F_NAB,C_NAB+1].value:=EdtTotalNotasCreditoGNC.Text;

      ExcelHoja.Cells[F_TIM,C_NFA+1].value:=EdtTotalImporteGNC.Text;
      ExcelHoja.Cells[F_IVA,C_NFA+1].value:=EdtTotalIVAGNC.Text;
      ExcelHoja.Cells[F_IVN,C_NFA+1].value:=EdtTotalIVANOInscriptoGNC.Text;
      ExcelHoja.Cells[F_TCD,C_NFA+1].value:=EdtTotalCDGNC.Text;
      ExcelHoja.Cells[F_TIB,C_NFA+1].value:=EdtIIBBgnc.Text;
      ExcelHoja.Cells[F_TTO,C_NFA+1].value:=EdtTotalGNC.Text;

      ExcelHoja.Cells[F_NFA,C_NFA+2].value:=EdtTotalFacturasTT.Text;
      ExcelHoja.Cells[F_NAB,C_NAB+2].value:=EdtTotalNotasCreditoTT.Text;

      ExcelHoja.Cells[F_TIM,C_NFA+2].value:=EdtTotalImporteTT.Text;
      ExcelHoja.Cells[F_IVA,C_NFA+2].value:=EdtTotalIVATT.Text;
      ExcelHoja.Cells[F_IVN,C_NFA+2].value:=EdtTotalIVANOInscriptoTT.Text;
      ExcelHoja.Cells[F_TCD,C_NFA+2].value:=edtTotalCD.Text;
      ExcelHoja.Cells[F_TIB,C_NFA+2].value:=EdtTotalIIBB.Text;
      ExcelHoja.Cells[F_TTO,C_NFA+2].value:=EdtTotalTotal.Text;

    except
      on E: Exception do
        ShowMessage('Error', 'Se ha producido un error: '+E.Message);
    end;
end;


procedure TFArqueoCajaExtTot.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TFArqueoCajaExtTot.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;









end.

