unit UFPrintInspectors;
{ Impresión de listados de inspectores }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DB, quickrpt, Qrctrls, FMTBcd, DBClient, Provider,
  SqlExpr;

type
  TfrmListadoInspectores = class(TForm)
    sdsqryListadoInspectores: TSQLDataSet;
    DataSetProvider1: TDataSetProvider;
    qryListadoInspectores: TClientDataSet;
    QRInspectores: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRDBText3: TQRDBText;
    QRLblNumInspector: TQRLabel;
    QRBand3: TQRBand;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRLabel2: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel3: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel6: TQRLabel;
    QRDBText2: TQRDBText;
    procedure FormCreate(Sender: TObject);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }

  public
    { Public declarations }
    function SeleccionarInspectores: boolean;
  end;

var
  frmListadoInspectores: TfrmListadoInspectores;

implementation

{$R *.DFM}

uses
   UCDIALGS,
   ULOGS,
   GLOBALS;


const
   FICHERO_ACTUAL = 'UFPrintInspectors';


function TFrmListadoInspectores.SeleccionarInspectores: boolean;
begin
    Result := False;
    try
      qryListadoInspectores.Close;
      qryListadoInspectores.Open;
      Application.ProcessMessages;
      qryListadoInspectores.First;
      Result := True;
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL, 'Error en SeleccionarInspectores: ' + E.Message);
        end;
    end;
end;


procedure TfrmListadoInspectores.FormCreate(Sender: TObject);
begin
    with qryListadoInspectores do
    begin
        Close;
        sdsqryListadoInspectores.SQLConnection := MyBD;
    end;
end;


procedure TfrmListadoInspectores.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
    QRLblNumInspector.caption := Format ('%0.2d%0.4d', [qryListadoInspectores.FieldByName('ESTACION').AsInteger, qryListadoInspectores.FieldByName('NUMREVIS').AsInteger]);
end;


end.
