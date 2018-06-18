unit UReImpresionObleas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, SqlExpr, dbclient, provider, ExtCtrls;

type
  TFrmReImpresionObleas = class(TForm)
    RBAnuladas: TRadioButton;
    RBInutiliz: TRadioButton;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Bevel1: TBevel;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  rCisa: Array [0..19] of String = ('CISA21','CISA22','CISA23','CISA24','CISA25','CISA26','CISA27','CISA28',
                                    'CISA61','CISA62','CISA63','CISA64','CISA65','CISA66','CISA67','CISA68',
                                    'CISA71','CISA72','CISA73','CISA75');

var
  FrmReImpresionObleas: TFrmReImpresionObleas;
  fPlanta: TClientDataSet;
  procedure ReimpresionesInfObleas;
  
implementation

{$R *.dfm}

uses
Globals,
Ugetdates,
UFTMP,
UFSeleccionaPlanta,
ufPrintOblIn,
UfprintOblAn;


procedure ReimpresionesInfObleas;
begin
With TFrmReImpresionObleas.Create(Application) do
  try
    ShowModal;
  finally
    free;
  end;
end;



procedure TFrmReImpresionObleas.BitBtn2Click(Sender: TObject);
var
I: Integer;
DBUserName, DBPassword, dateini,datefin: string;
begin
if not getdates(dateini,datefin) then
  exit;
  Try
  mybd.Close;
  Screen.Cursor:=crHourGlass;
    For I:=0 To high(rCisa) do
      Begin
        FTmp.Temporizar(TRUE,FALSE,caption, 'Cambiando a la Planta Seleccionada');
        dbUserName:= rCisa[I];
        dbPassword:='02lusabaqui03';
        try
          TestOfBD('',dbUserName,dbPassword,false);
          FTmp.Temporizar(TRUE,FALSE,caption, 'Cambiando a la Planta Seleccionada'+#13#10+'Conectando a: '+rCisa[I]);
          InitAplicationGlobalTables;
          If RBAnuladas.Checked then
            With TfmImprimOblAnul.Create(self) do
              Begin
                Application.ProcessMessages;
                FTmp.Temporizar(TRUE,FALSE,caption, 'Imprimiendo el Informe de Obleas Anuladas');
                DoImprimeOblAnul(dateini,datefin);
              end;
          If RBInutiliz.Checked then
            Begin
              With TfmImprimOblInut.Create(self) do
                Begin
                  Application.ProcessMessages;
                  FTmp.Temporizar(TRUE,FALSE,caption, 'Imprimiendo el Informe de Obleas Inutilizadas');
                  DoImprimeOblInutilizadas(dateini,datefin);
                end;
            end;
        Except
          On E: Exception do
            Begin
              FTmp.Temporizar(FALSE,FALSE,'', '');
              Screen.Cursor:=crDefault;
              ShowMessage(E.Message);
            end;
        end;
      Application.ProcessMessages;
      FTmp.Temporizar(FALSE,FALSE,caption, 'Un momento por favor.'+#13#10+'Desconectando....');
      mybd.Close;
      end;
  Finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFrmReImpresionObleas.BitBtn3Click(Sender: TObject);
begin
Close;
end;

end.
