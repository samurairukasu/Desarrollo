unit UFPrintSpecies;
{ Impresión del tipo de especie de los vehítulos }

{
  Ultima Traza: 1
  Ultima Incidencia:
  Ultima Anomalia: 1
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, quickrpt, Qrctrls, DBXpress, FMTBcd,
  DBClient, Provider, SqlExpr;

type
  TfrmEspecie = class(TForm)
    sdsqryImprimirEspecie: TSQLDataSet;
    dspqryImprimirEspecie: TDataSetProvider;
    qryImprimirEspecie: TClientDataSet;
    QREspecie: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRBand3: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRLabel6: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    function SeleccionarEspecie: boolean;
  end;

var
  frmEspecie: TfrmEspecie;

implementation

{$R *.DFM}

uses
   ULOGS,
   GLOBALS;

const
  FICHERO_ACTUAL = 'IMPRESPE.PAS';

function TfrmEspecie.SeleccionarEspecie: boolean;
begin
    try
      qryImprimirEspecie.Close;
      sdsqryImprimirEspecie.SQLConnection := MyBd;
      {$IFDEF TRAZAS}
         FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, qryImprimirEspecie);
      {$ENDIF}
      qryImprimirEspecie.Open;
      Application.ProcessMessages;
      qryImprimirEspecie.First;
      Result := True;
    except
        on E:Exception do
        begin
            Result := False;
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL, 'Error en SeleccionarEspecie: ' + E.Message);
        end;
    end;
end;





end.
