unit UFEstadisticasEncToPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, FMTBcd, DBClient, Provider, DB,
  SqlExpr, USagClasses, Globals, jpeg;

type
  TfrmEstadisticasEncToPrint = class(TForm)
    RepEstadisticas: TQuickRep;
    QRBand1: TQRBand;
    QRLabel7: TQRLabel;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    dbtSUM3y4: TQRDBText;
    QRBand3: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRGroup1: TQRGroup;
    lbltitulo: TQRLabel;
    SummaryBand1: TQRBand;
    QRImage1: TQRImage;
    QRPunto: TQRLabel;
    qrlformulario: TQRLabel;
    QRImage4: TQRImage;
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
  Procedure EstadisticasPrevias;

var
  frmEstadisticasEncToPrint: TfrmEstadisticasEncToPrint;
  ABREVIA, NROFORM, NombreEstacion, NumeroEstacion: String;
  fLimite: TSeries_Encuestas;

implementation

{$R *.dfm}

uses
UFEstadisticasEncSatis;

procedure PutEstacion;
begin
  try
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
  finally
  end;
end;


Procedure EstadisticasPrevias;
begin
  with TfrmEstadisticasEncToPrint.Create(application) do
   try
     PutEstacion;
     lbltitulo.caption:='Número de Planta: '+NumeroEstacion+' -  Nombre de Planta: '+NombreEstacion;
     QRPunto.Caption:= ABREVIA;
     qrlFormulario.Caption:=NROFORM;
     RepEstadisticas.Prepare;
     Screen.Cursor:=crHourGlass;
     if FileExists(NOM_DIR+NOM_TMP+'1.bmp') then
     QRImage1.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'1.bmp');
     Screen.Cursor:=crDefault;
     RepEstadisticas.Preview;
   finally
     free;
     QRImage1.Free;
   end;
end;


procedure TfrmEstadisticasEncToPrint.QRBand2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if dbtSUM3y4.dataset.FieldByName('sum3y4').value >= fVarios.LimiteEncuestas then
    dbtSUM3y4.Font.Color:=clred
  else
    dbtSUM3y4.Font.Color:=clWindowText;
end;

end.
