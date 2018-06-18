unit UFDatosEstadEncuesta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, UCDialgs,
  Grids, DBGrids, UFEstadisticasEncSatis, StdCtrls, Buttons;

type
  TfrmDatosEstadEncuesta = class(TForm)
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    btnImprimir: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    sTitulo: string;
  public
    { Public declarations }
  end;
  procedure DoDatosEstadEncuesta(aTitulo: string);

var
  frmDatosEstadEncuesta: TfrmDatosEstadEncuesta;

implementation

{$R *.DFM}

USES
  UFTMP,
  ULOGS,
  UFEstadisticasEncSatisToPrint;

resourcestring
    FICHERO_ACTUAL = 'UFDatosEstadEncuesta.PAS';


procedure DoDatosEstadEncuesta(aTitulo: string);
begin
        with TfrmDatosEstadEncuesta.Create(Application) do
        try
            try
                sTitulo:=aTitulo;
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

procedure TfrmDatosEstadEncuesta.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmDatosEstadEncuesta.btnImprimirClick(Sender: TObject);
begin
        with TFrmEstadisticasEncSatisToPrint.Create(Application) do
        try
            try
              lbltitulo.caption:=sTitulo;
              repValores.PrinterSetup;
              RepValores.print;
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
        end;
end;

end.
