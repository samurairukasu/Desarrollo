unit UFPrintDestiny;
{ Impresión del tipo de destino de servicio de los vehítulos }

interface

{
  Ultima Traza: 1
  Ultima Incidencia:
  Ultima Anomalia: 1 
}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, quickrpt, Qrctrls, FMTBcd, SqlExpr, Provider,
  DBClient;

type
  TfrmDServicio = class(TForm)
    qryImprimirDServicio: TClientDataSet;
    dspqryImprimirDServicio: TDataSetProvider;
    sdsqryImprimirDServicio: TSQLDataSet;
    QRDServicio: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRBand3: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRBand4: TQRBand;
    QRLabel4: TQRLabel;
    QRSysData1: TQRSysData;
  private
    { Private declarations }
  public
    { Public declarations }
    function SeleccionarDServicio: boolean;
  end;

var
  frmDServicio: TfrmDServicio;

implementation

{$R *.DFM}

uses
   ULOGS,
   GLOBALS;

const
    FICHERO_ACTUAL = 'ImprDSer';

function TfrmDServicio.SeleccionarDServicio: boolean;
begin
    try
      qryImprimirDServicio.Close;
      sdsqryImprimirDServicio.sqlconnection := MyBD;
      {$IFDEF TRAZAS}
         FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, qryImprimirDServicio);
      {$ENDIF}
      qryImprimirDServicio.Open;
      Application.ProcessMessages;
      qryImprimirDServicio.First;
      Result := True;
    except
        on E:Exception do
        begin
            Result := False;
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL, 'Error en SeleccionarDServicio: ' + E.Message);
        end;
    end;
end;




end.
