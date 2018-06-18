unit UListadoEstadoVTVToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, Qrctrls, FMTBcd, Provider,
  DBClient, SqlExpr, QuickRpt;

type
  TFListadoEstadoVtvToPrint = class(TForm)
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    qrbdetalle: TQRBand;
    QRBand4: TQRBand;
    QRImprimirCaja: TQuickRep;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRSysData1: TQRSysData;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel13: TQRLabel;
    QRLblNumeroEstacion: TQRLabel;
    QRLblEspecieDestino: TQRLabel;
    SD: TSaveDialog;
    QRSysData2: TQRSysData;
    sdsQTTMPLISTCAMBIO: TSQLDataSet;
    QTTMPLISTCAMBIO: TClientDataSet;
    dspQTTMPLISTCAMBIO: TDataSetProvider;
    procedure FormDestroy(Sender: TObject);
    procedure qrbdetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(const cEspecie, cDestino, NombreEstacion, NumeroEstacion: string);
  end;

var
  FListadoEstadoVtvToPrint: TFListadoEstadoVtvToPrint;

implementation

{$R *.DFM}

uses
   QREXTRA,
   QRPRNTR,
   ULOGS,
   GLOBALS,
   USAGESTACION;


const
    FICHERO_ACTUAL = 'UListadoCambioFechaToPrint';

procedure TFListadoEstadoVtvToPrint.Execute(const cEspecie, cDestino, NombreEstacion, NumeroEstacion: string);
begin

    QRLblNumeroEstacion.Caption := NumeroEstacion + '-' + NombreEstacion;
    QRLblEspecieDestino.Caption := cEspecie +' '+ cDestino;    

    with QTTMPLISTCAMBIO do
    begin
        Close;
        sdsQTTMPLISTCAMBIO.SQLConnection:= MyBD;
        sdsQTTMPLISTCAMBIO.CommandText :='SELECT DOMINIO, CANTINSP, ESTADO, ULTFECVENCI FROM  TTMPLISTTRANSPORTE ORDER BY DOMINIO ';
        {$IFDEF TRAZAS}
        FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLISTCAMBIO);
        {$ENDIF}
        Open
    end;
    QRImprimirCaja.Preview;
end;

procedure TFListadoEstadoVtvToPrint.FormDestroy(Sender: TObject);
begin
    QTTMPLISTCAMBIO.Close;
end;

procedure TFListadoEstadoVtvToPrint.qrbdetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if QRImprimirCaja.RecordNumber mod 2 <> 0 then
    QRBDetalle.color := clWhite
  else
    QRBDetalle.color := $00EBEBEB
end;



end.
