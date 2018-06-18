unit UFListadoDescuentosToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, DBTables, quickrpt, Qrctrls, qrexport;

type
  TFListadoFacXDescuentosToPrint = class(TForm)
    QRImprimirCaja: TQuickRep;
    QRBand1: TQRBand;
    QRLlbTitulo: TQRLabel;
    QRLabel13: TQRLabel;
    QRLblNumeroEstacion: TQRLabel;
    QRLblIntervaloFechas: TQRLabel;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRBand5: TQRBand;
    QRLabel15: TQRLabel;
    QRLblTotalFacturas: TQRLabel;
    QTTMPARQCAJAEXTEN: TQuery;
    SD: TSaveDialog;
    QRBand2: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel14: TQRLabel;
    QRBand3: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRLabel1: TQRLabel;
    QRDBText4: TQRDBText;
    QRLabel3: TQRLabel;
    QRDBText2: TQRDBText;
    QRLblTipoPago: TQRLabel;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(const cFechaIni, cFechaFin, sNumFact, NombreEstacion, NumeroEstacion, aCodDescu: string);
    procedure ExportaAscii(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, NombreEstacion, NumeroEstacion, aCodDescu: string);
  end;

var
  FListadoFacXDescuentosToPrint: TFListadoFacXDescuentosToPrint;

implementation

{$R *.DFM}

uses
   QREXTRA,
   QRPRNTR,
   GLOBALS,
   USAGESTACION,
   USAGCLASSES;


const
    FICHERO_ACTUAL = 'UArqueoCajaExtendedToPrint';

procedure TFListadoFacXDescuentosToPrint.Execute(const cFechaIni, cFechaFin, sNumFact, NombreEstacion, NumeroEstacion, aCodDescu: string);
var fDescuentos: TDescuento;
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);

    QRLblTotalFacturas.Caption := sNumFact;

    fDescuentos := TDescuento.CreateFromCoddescu(MyBD,aCodDescu);
    fDescuentos.open;
    QRLblTipoPago.caption:='TIPO DE DESCUENTO: '+fDescuentos.ValueByName[FIELD_CONCEPTO];
    fDescuentos.close;
    fDescuentos.free;

    with QTTMPARQCAJAEXTEN do
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
          FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPARQCAJAEXTEN);
        {$ENDIF}
        Open
    end;
    QRImprimirCaja.PrinterSetup;
    QRImprimirCaja.Print;
end;



procedure TFListadoFacXDescuentosToPrint.ExportaAscii(const cFechaIni, cFechaFin, sTotalImporte, sIVAIns, sIVANoIns, sTotalTotal, sNumFact, sNumNotas, NombreEstacion, NumeroEstacion, aCodDescu: string);
var
    aExportFilter : TQRAsciiExportFilter;
    fDescuentos: TDescuento;
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);

    QRLblTotalFacturas.Caption := sNumFact;

    fDescuentos := TDescuento.CreateFromCoddescu(MyBD,aCodDescu);
    fDescuentos.open;
    QRLblTipoPago.caption:='TIPO DE DESCUENTO: '+fDescuentos.ValueByName[FIELD_CONCEPTO];
    fDescuentos.close;
    fDescuentos.free;

    with QTTMPARQCAJAEXTEN do
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
          FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPARQCAJAEXTEN);
        {$ENDIF}
        Open
    end;

    if SD.Execute
    then begin
        aExportFilter := TQRAsciiExportFilter.Create(SD.FileName);
        try
            QRImprimirCaja.ExportToFilter(aExportFilter);
        finally
            aExportFilter.Free;
        end;
    end;
end;

procedure TFListadoFacXDescuentosToPrint.FormDestroy(Sender: TObject);
begin
    QTTMPARQCAJAEXTEN.Close;
end;






end.
