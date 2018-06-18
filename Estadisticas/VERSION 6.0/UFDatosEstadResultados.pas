unit UFDatosEstadResultados;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, UCDialgs,
  Grids, DBGrids, UFEstadisticasResultados, StdCtrls, Buttons;

type
  TfrmDatosEstadResultados = class(TForm)
    dbgresult: TDBGrid;
    btnSalir: TBitBtn;
    btnImprimir: TBitBtn;
    procedure btnSalirClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    sTitulo: string;
  public
    { Public declarations }
  end;
  procedure DoDatosEstadResultados(aTitulo: string; azona: integer);

var
  frmDatosEstadResultados: TfrmDatosEstadResultados;
  szona: integer;
implementation

{$R *.DFM}

USES
  UFTMP,
  UFEstadisticasResultadosToPrint;


procedure DoDatosEstadResultados(aTitulo: string; azona: integer);
begin
szona:=azona;
with TfrmDatosEstadResultados.Create(Nil) do
  try
    try
      sTitulo:=aTitulo;
      ShowModal;
    except
      on E: Exception do
        begin
          FTmp.Temporizar(FALSE,FALSE,'', '');
          Application.ProcessMessages;
          MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)
        end
    end
  finally
    Free;
    Application.ProcessMessages;
  end;
end;


procedure TfrmDatosEstadResultados.FormCreate(Sender: TObject);
var i:integer;
begin
  with dbgresult do
  begin
    case szona of
      2:begin
          columns[1].fieldname:='PORCENT'+inttostr(szona)+'1';
          columns[2].fieldname:='PORCENT'+inttostr(szona)+'2';
          columns[3].fieldname:='PORCENT'+inttostr(szona)+'3';
          columns[4].fieldname:='PORCENT'+inttostr(szona)+'4';
          columns[5].fieldname:='PORCENT'+inttostr(szona)+'5';
          columns[6].fieldname:='PORCENT'+inttostr(szona)+'6';
          columns[7].fieldname:='PORCENT'+inttostr(szona)+'7';
          columns[8].fieldname:='PORCENT'+inttostr(szona)+'8';
          columns[9].fieldname:='MEDIA';


          columns[1].title.caption:='Planta '+inttostr(szona)+'1';
          columns[2].title.caption:='Planta '+inttostr(szona)+'2';
          columns[3].title.caption:='Planta '+inttostr(szona)+'3';
          columns[4].title.caption:='Planta '+inttostr(szona)+'4';
          columns[5].title.caption:='Planta '+inttostr(szona)+'5';
          columns[6].title.caption:='Planta '+inttostr(szona)+'6';
          columns[7].title.caption:='Planta '+inttostr(szona)+'7';
          columns[8].title.caption:='Planta '+inttostr(szona)+'8';
          columns[9].title.caption:='Media';
        end;

      6:begin
          columns[1].fieldname:='PORCENT'+inttostr(szona)+'1';
          columns[2].fieldname:='PORCENT'+inttostr(szona)+'2';
          columns[3].fieldname:='PORCENT'+inttostr(szona)+'3';
          columns[4].fieldname:='PORCENT'+inttostr(szona)+'4';
          columns[5].fieldname:='PORCENT'+inttostr(szona)+'5';
          columns[6].fieldname:='PORCENT'+inttostr(szona)+'6';
          columns[7].fieldname:='PORCENT'+inttostr(szona)+'7';
          columns[8].fieldname:='PORCENT'+inttostr(szona)+'8';
          columns[9].fieldname:='MEDIA';

          columns[1].title.caption:='Planta '+inttostr(szona)+'1';
          columns[2].title.caption:='Planta '+inttostr(szona)+'2';
          columns[3].title.caption:='Planta '+inttostr(szona)+'3';
          columns[4].title.caption:='Planta '+inttostr(szona)+'4';
          columns[5].title.caption:='Planta '+inttostr(szona)+'5';
          columns[6].title.caption:='Planta '+inttostr(szona)+'6';
          columns[7].title.caption:='Planta '+inttostr(szona)+'7';
          columns[8].title.caption:='Planta '+inttostr(szona)+'8';
          columns[9].title.caption:='Media';
        end;

      7:begin
          columns[1].fieldname:='PORCENT'+inttostr(szona)+'1';
          columns[2].fieldname:='PORCENT'+inttostr(szona)+'2';
          columns[3].fieldname:='PORCENT'+inttostr(szona)+'3';
          columns[4].fieldname:='PORCENT'+inttostr(szona)+'5';
          columns[5].fieldname:='MEDIA';
          columns[6].Destroy;
          columns[7].Destroy;
          columns[8].Destroy;
          columns[9].Destroy;

          columns[1].title.caption:='Planta '+inttostr(szona)+'1';
          columns[2].title.caption:='Planta '+inttostr(szona)+'2';
          columns[3].title.caption:='Planta '+inttostr(szona)+'3';
          columns[4].title.caption:='Planta '+inttostr(szona)+'5';
          columns[5].title.caption:='Media';
        end;
    end;
  end;
end;


procedure TfrmDatosEstadResultados.btnSalirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmDatosEstadResultados.btnImprimirClick(Sender: TObject);
begin
with TFrmEstadisticasResultadosToPrint.Create(Self) do
  try
    try
      case szona of
        2:begin
            lbltitulo.caption:=sTitulo;
            bdtplanta1.datafield:='PORCENT'+inttostr(szona)+'1';
            bdtplanta2.datafield:='PORCENT'+inttostr(szona)+'2';
            bdtplanta3.datafield:='PORCENT'+inttostr(szona)+'3';
            bdtplanta4.datafield:='PORCENT'+inttostr(szona)+'4';
            bdtplanta5.datafield:='PORCENT'+inttostr(szona)+'5';
            bdtplanta6.datafield:='PORCENT'+inttostr(szona)+'6';
            bdtplanta7.datafield:='PORCENT'+inttostr(szona)+'7';
            bdtplanta8.datafield:='PORCENT'+inttostr(szona)+'8';
            bdtmedia.datafield:='MEDIA';


            qrlplanta1.caption:='Planta '+inttostr(szona)+'1';
            qrlplanta2.caption:='Planta '+inttostr(szona)+'2';
            qrlplanta3.caption:='Planta '+inttostr(szona)+'3';
            qrlplanta4.caption:='Planta '+inttostr(szona)+'4';
            qrlplanta5.caption:='Planta '+inttostr(szona)+'5';
            qrlplanta6.caption:='Planta '+inttostr(szona)+'6';
            qrlplanta7.caption:='Planta '+inttostr(szona)+'7';
            qrlplanta8.caption:='Planta '+inttostr(szona)+'7';
            qrlmedia.caption:='Media';


            RepResultados.Prepare;
            RepResultados.PrinterSetup;
            RepResultados.print;
          end;

        6:begin
            lbltituloz.caption:=sTitulo;

            bdtplanta1.datafield:='PORCENT'+inttostr(szona)+'1';
            bdtplanta2.datafield:='PORCENT'+inttostr(szona)+'2';
            bdtplanta3.datafield:='PORCENT'+inttostr(szona)+'3';
            bdtplanta4.datafield:='PORCENT'+inttostr(szona)+'4';
            bdtplanta5.datafield:='PORCENT'+inttostr(szona)+'5';
            bdtplanta6.datafield:='PORCENT'+inttostr(szona)+'6';
            bdtplanta7.datafield:='PORCENT'+inttostr(szona)+'7';
            bdtplanta8.datafield:='PORCENT'+inttostr(szona)+'8';
            bdtmedia.datafield:='MEDIA';

            qrlplanta1.caption:='Planta '+inttostr(szona)+'1';
            qrlplanta2.caption:='Planta '+inttostr(szona)+'2';
            qrlplanta3.caption:='Planta '+inttostr(szona)+'3';
            qrlplanta4.caption:='Planta '+inttostr(szona)+'4';
            qrlplanta5.caption:='Planta '+inttostr(szona)+'5';
            qrlplanta6.caption:='Planta '+inttostr(szona)+'6';
            qrlplanta7.caption:='Planta '+inttostr(szona)+'7';
            qrlplanta8.caption:='Planta '+inttostr(szona)+'8';
            qrlmedia.caption:='Media';

            RepResultados.Prepare;
            RepResultados.PrinterSetup;
            RepResultados.print;
          end;

        7:begin
            lbltitulo.caption:=sTitulo;
            bdtplanta1.datafield:='PORCENT'+inttostr(szona)+'1';
            bdtplanta2.datafield:='PORCENT'+inttostr(szona)+'2';
            bdtplanta3.datafield:='PORCENT'+inttostr(szona)+'3';
            bdtplanta4.datafield:='PORCENT'+inttostr(szona)+'5';
            bdtmedia.datafield:='MEDIA';
            bdtplanta5.Destroy;
            bdtplanta6.Destroy;
            bdtplanta7.Destroy;

            qrlplanta1.caption:='Planta '+inttostr(szona)+'1';
            qrlplanta2.caption:='Planta '+inttostr(szona)+'2';
            qrlplanta3.caption:='Planta '+inttostr(szona)+'3';
            qrlplanta4.caption:='Planta '+inttostr(szona)+'5';
            qrlmedia.caption:='Media';

            qrlplanta5.Destroy;
            qrlplanta6.Destroy;
            qrlplanta7.Destroy;

            RepResultados.Prepare;
            RepResultados.PrinterSetup;
            RepResultados.print;
          end;
      end;
    except
      on E: Exception do
        begin
          FTmp.Temporizar(FALSE,FALSE,'', '');
          Application.ProcessMessages;
          MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)
        end
    end
  finally
    Free;
  end;
end;













end.
