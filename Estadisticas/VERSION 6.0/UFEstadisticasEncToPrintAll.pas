unit UFEstadisticasEncToPrintAll;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, QRCtrls, ExtCtrls, SqlExpr, GLobals, FMTBcd, Provider, UsagClasses,
  DB, DBClient, jpeg;

type
  TUFEstadisitcasEncToPrintAll = class(TForm)
    QuickRep1: TQuickRep;
    DetailBand1: TQRBand;
    QRImage1: TQRImage;
    QRImage2: TQRImage;
    Estadisticas: TQRCompositeReport;
    QuickRep2: TQuickRep;
    DetailBand2: TQRBand;
    QRImage3: TQRImage;
    QRImage4: TQRImage;
    QuickRep3: TQuickRep;
    QRBand1: TQRBand;
    QRImage5: TQRImage;
    QRImage6: TQRImage;
    QuickRep4: TQuickRep;
    PageFooterBand1: TQRBand;
    PageFooterBand2: TQRBand;
    PageFooterBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRSysData3: TQRSysData;
    PageFooterBand4: TQRBand;
    QRSysData4: TQRSysData;
    Reporte: TQuickRep;
    QRBand3: TQRBand;
    QRLabel7: TQRLabel;
    QRPlanta: TQRLabel;
    QRBand4: TQRBand;
    QRBand5: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRGroup1: TQRGroup;
    QRBand2: TQRBand;
    QRImage7: TQRImage;
    PageFooterBand5: TQRBand;
    QRSysData5: TQRSysData;
    MES: TQRExpr;
    MUYSATIS: TQRExpr;
    SATISFAC: TQRExpr;
    ALGOINSATIF: TQRExpr;
    INSATIF: TQRExpr;
    SUM3Y4: TQRExpr;
    sdsConsulta: TSQLDataSet;
    dspConsulta: TDataSetProvider;
    cdsConsulta: TClientDataSet;
    QRLabel9: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    SummaryBand1: TQRBand;
    QRImage9: TQRImage;
    qrlFormulario: TQRLabel;
    procedure EstadisticasAddReports(Sender: TObject);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    Procedure Preparacion;
    procedure PutEstacion;
  private
  fSerie : TSeries_Encuestas;
    { Private declarations }
  public
    { Public declarations }
  end;
  Procedure EstadisticasPreviasAll;
  Procedure EstadisticasPDF;
var
  UFEstadisitcasEncToPrintAll: TUFEstadisitcasEncToPrintAll;
  NombreEstacion, NumeroEstacion: String;
  NROSERIE: Integer;

implementation

{$R *.dfm}

uses
UFEstadisticasEncSatis;


Procedure TUFEstadisitcasEncToPrintAll.Preparacion;
Begin;
  Screen.Cursor:=crHourGlass;
  sdsConsulta.SQLConnection:= MyBD;
  with CDSConsulta do
    begin
    Screen.Cursor:=crHourGlass;
    commandtext := ('SELECT P.ABREVIA, T.MES, T.MUYSATIS, T.SATISFAC, T.ALGOINSA, T.INSATISF, T.SUM3Y4, T.PUNTO from TTMPESTAD_ENCUESTAS T, TPREGUNTAS_ENCUESTAS P Where T.PUNTO = P.NROPREGUNTA AND P.SERIE = :SERIE ORDER BY T.PUNTO, T.ORDEN ');
    Params[0].AsInteger:= NROSERIE;
    open;
    QRImage1.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'1.bmp');
    QRImage2.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'2.bmp');
    QRImage3.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'3.bmp');
    QRImage4.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'4.bmp');
    QRImage5.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'5.bmp');
    QRImage6.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'6.bmp');
    QRImage7.Picture.LoadFromFile(NOM_DIR+NOM_TMP+'7.bmp');
    Screen.Cursor:=crDefault;
    PutEstacion;
    QRPlanta.caption:='Planta: '+NumeroEstacion+' - '+NombreEstacion;
    QRLFormulario.Caption:= UFEstadisticasEncSatis.fSerie.Nom_F_Impr;
    Estadisticas.Prepare;
    end;
end;


procedure TUFEstadisitcasEncToPrintAll.PutEstacion;
begin
  try
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
  finally
  end;
end;


Procedure EstadisticasPreviasAll;
begin
  with TUFEstadisitcasEncToPrintAll.Create(application) do
   try
   Preparacion;
   Estadisticas.Preview;
   finally
     free;
     TQRImage.Create(nil).Free;
   end;
end;


Procedure EstadisticasPDF;
var
Archivo: String;
begin
  with TUFEstadisitcasEncToPrintAll.Create(application) do
   try
   if GetImpresora <> -1 then
    Begin
      Estadisticas.PrinterSettings.PrinterIndex:=GetImpresora;
      Preparacion;
      Application.ProcessMessages;
      Estadisticas.Print;
      Sleep(900);
      Archivo:='EncuestasP'+NumeroEstacion+'.pdf';
      Guardar(Archivo);
    end;
   finally
     free;
     TQRImage.Create(nil).Free;
   end;
Application.ProcessMessages;
end;



procedure TUFEstadisitcasEncToPrintAll.EstadisticasAddReports(Sender: TObject);
begin
  with Estadisticas do
  begin
    Reports.Add(Reporte);
    Reports.Add(QuickRep1);
    Reports.Add(QuickRep2);
    Reports.Add(QuickRep3);
    Reports.Add(QuickRep4);
  end;
end;

procedure TUFEstadisitcasEncToPrintAll.QRBand4BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if (cdsConsulta.FieldByName('SUM3Y4').Value >= fVarios.LimiteEncuestas) then
    SUM3y4.Font.Color:=clred
  else
    SUM3y4.Font.Color:=clWindowText;
end;

end.




