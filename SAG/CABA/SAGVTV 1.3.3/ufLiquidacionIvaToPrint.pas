unit ufLiquidacionIvaToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, quickrpt, Qrctrls, FMTBcd, DBClient, Provider,
  SqlExpr;

type
  TFRMLiquidacionIVAToPrint = class(TForm)
    SD: TSaveDialog;
    sdsQTTMPIVAVENTAS: TSQLDataSet;
    dspQTTMPIVAVENTAS: TDataSetProvider;
    QTTMPIVAVENTAS: TClientDataSet;
    QRImprimirCaja: TQuickRep;
    QRBand1: TQRBand;
    QRLlbTitulo: TQRLabel;
    QRLabel13: TQRLabel;
    QRLblNumeroEstacion: TQRLabel;
    QRLblIntervaloFechas: TQRLabel;
    QRBand2: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLblInspeccion: TQRLabel;
    QRLbldominio: TQRLabel;
    Total: TQRLabel;
    QRLabel4: TQRLabel;
    QRBand3: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBTinspeccion: TQRDBText;
    QRDBTDominio: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText3: TQRDBText;
    QRBand5: TQRBand;
    QRLabel15: TQRLabel;
    qrlbltotal: TQRLabel;
    qrlblivanoincr: TQRLabel;
    qrlblivainscr: TQRLabel;
    qrlblneto: TQRLabel;
    qrlblIIBB: TQRLabel;
    QRLabel1: TQRLabel;

    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion, aNeto, aIvaInscr, aIvaNoInscr, aTotal, aTotalIIBB: string);
  end;

var
  FRMLiquidacionIVAToPrint: TFRMLiquidacionIVAToPrint;

implementation

{$R *.DFM}

uses
   QREXTRA,
   QRPRNTR,
   ULOGS,
   GLOBALS,
   USAGESTACION,
   USAGCLASSES;


const
    FICHERO_ACTUAL = 'UFLiquidacionIVAToPrint';

procedure TFRMLiquidacionIVAToPrint.Execute(const cFechaIni, cFechaFin, NombreEstacion, NumeroEstacion, aNeto, aIvaInscr, aIvaNoInscr, aTotal, aTotalIIBB: string);
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + ' - ' + NombreEstacion;
    QRLblIntervaloFechas.Caption := Format('Desde: %s - Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);

    qrlblneto.caption := aneto;
    qrlblivainscr.caption := aivainscr;
    qrlblivanoincr.caption := aivanoinscr;
    qrlbltotal.caption := atotal;
    qrlblIIBB.Caption := aTotalIIBB;

    with QTTMPIVAVENTAS do
    begin
        Close;
        sdsQTTMPIVAVENTAS.SQLConnection := MyBD;
        CommandText := 'SELECT DESCRIPCION, NETO, IVAINSCR, IVANOINS, TOTAL, IIBB FROM TTMPIVAVENTAS';
        {$IFDEF TRAZAS}
        FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPIVAVENTAS);
        {$ENDIF}
        Open
    end;
    QRImprimirCaja.PrinterSetup;
    QRImprimirCaja.Print;
end;

procedure TFRMLiquidacionIVAToPrint.FormDestroy(Sender: TObject);
begin
    QTTMPIVAVENTAS.Close;
end;

end.


