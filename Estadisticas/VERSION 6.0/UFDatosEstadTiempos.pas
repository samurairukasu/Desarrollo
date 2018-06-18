unit UFDatosEstadTiempos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, UCDialgs,
  Grids, DBGrids, StdCtrls, Buttons;

type
  TfrmDatosEstadTiempos = class(TForm)
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
  procedure DoDatosEstadTiempos(aTitulo: string; azona: integer);

var
  frmDatosEstadTiempos: TfrmDatosEstadTiempos;
  szona: integer;
implementation

{$R *.DFM}

USES
  UFTMP,
  ufEstadisticasTiempos,
  UFEstadisticasTiemposToPrint;


procedure DoDatosEstadTiempos(aTitulo: string; azona: integer);
begin
  szona:=azona;
  with TfrmDatosEstadTiempos.Create(Application) do
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

procedure TfrmDatosEstadTiempos.btnSalirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmDatosEstadTiempos.btnImprimirClick(Sender: TObject);
begin
   with TFrmEstadisticasTiemposToPrint.Create(Application) do
   try
       try
         QRGpunto.enabled:=false;
         QRGpuntoz6.enabled:=false;
         case szona of
           2:begin
             lbltitulo.caption:=sTitulo;
             bdtplanta1.datafield:='TPROM'+inttostr(szona)+'1';
             bdtplanta2.datafield:='TPROM'+inttostr(szona)+'2';
             bdtplanta3.datafield:='TPROM'+inttostr(szona)+'3';
             bdtplanta4.datafield:='TPROM'+inttostr(szona)+'4';
             bdtplanta5.datafield:='TPROM'+inttostr(szona)+'5';

             qrlplanta1.caption:='Planta '+inttostr(szona)+'1';
             qrlplanta2.caption:='Planta '+inttostr(szona)+'2';
             qrlplanta3.caption:='Planta '+inttostr(szona)+'3';
             qrlplanta4.caption:='Planta '+inttostr(szona)+'4';
             qrlplanta5.caption:='Planta '+inttostr(szona)+'5';

             repValores.PrinterSetup;
             RepValores.print;
           end;

           6:begin
              lbltituloz6.caption:=sTitulo;
              repValoresz6.PrinterSetup;
              RepValoresz6.print;
             end;

           7:begin
             lbltitulo.caption:=sTitulo;
             bdtplanta1.datafield:='TPROM'+inttostr(szona)+'1';
             bdtplanta2.datafield:='TPROM'+inttostr(szona)+'2';
             bdtplanta3.datafield:='TPROM'+inttostr(szona)+'3';
             bdtplanta4.datafield:='TPROM'+inttostr(szona)+'5';

             qrlplanta1.caption:='Planta '+inttostr(szona)+'1';
             qrlplanta2.caption:='Planta '+inttostr(szona)+'2';
             qrlplanta3.caption:='Planta '+inttostr(szona)+'3';
             qrlplanta4.caption:='Planta '+inttostr(szona)+'5';

             repValores.PrinterSetup;
             RepValores.print;
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


procedure TfrmDatosEstadTiempos.FormCreate(Sender: TObject);
var i:integer;
begin
  with dbgresult do
  begin
    case szona of
    2:begin
      columns[1].fieldname:='TPROM'+inttostr(szona)+'1';
      columns[2].fieldname:='TPROM'+inttostr(szona)+'2';
      columns[3].fieldname:='TPROM'+inttostr(szona)+'3';
      columns[4].fieldname:='TPROM'+inttostr(szona)+'4';
      columns[5].fieldname:='TPROM'+inttostr(szona)+'5';

      columns[1].title.caption:='Planta '+inttostr(szona)+'1';
      columns[2].title.caption:='Planta '+inttostr(szona)+'2';
      columns[3].title.caption:='Planta '+inttostr(szona)+'3';
      columns[4].title.caption:='Planta '+inttostr(szona)+'4';
      columns[5].title.caption:='Planta '+inttostr(szona)+'5';

      for i:=7 downto 6 do
        columns[i].destroy;
      end;

    6:begin
      columns[1].fieldname:='TPROM'+inttostr(szona)+'1';
      columns[2].fieldname:='TPROM'+inttostr(szona)+'2';
      columns[3].fieldname:='TPROM'+inttostr(szona)+'3';
      columns[4].fieldname:='TPROM'+inttostr(szona)+'4';
      columns[5].fieldname:='TPROM'+inttostr(szona)+'5';
      columns[6].fieldname:='TPROM'+inttostr(szona)+'6';
      columns[7].fieldname:='TPROM'+inttostr(szona)+'7';
      columns[1].title.caption:='Planta '+inttostr(szona)+'1';
      columns[2].title.caption:='Planta '+inttostr(szona)+'2';
      columns[3].title.caption:='Planta '+inttostr(szona)+'3';
      columns[4].title.caption:='Planta '+inttostr(szona)+'4';
      columns[5].title.caption:='Planta '+inttostr(szona)+'5';
      columns[6].title.caption:='Planta '+inttostr(szona)+'6';
      columns[7].title.caption:='Planta '+inttostr(szona)+'7';
      end;

    7:begin
      columns[1].fieldname:='TPROM'+inttostr(szona)+'1';
      columns[2].fieldname:='TPROM'+inttostr(szona)+'2';
      columns[3].fieldname:='TPROM'+inttostr(szona)+'3';
      columns[4].fieldname:='TPROM'+inttostr(szona)+'5';

      columns[1].title.caption:='Planta '+inttostr(szona)+'1';
      columns[2].title.caption:='Planta '+inttostr(szona)+'2';
      columns[3].title.caption:='Planta '+inttostr(szona)+'3';
      columns[4].title.caption:='Planta '+inttostr(szona)+'5';
      for i:=7 downto 5 do
        columns[i].destroy;
      end;
    end;
  end;
end;

end.
