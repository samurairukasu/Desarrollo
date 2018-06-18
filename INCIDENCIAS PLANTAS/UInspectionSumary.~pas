unit UInspectionSumary;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, quickrpt, Qrctrls;

type
  TFInspectionsSumary = class(TForm)
    QRBand1: TQRBand;
    QRBand3: TQRBand;
    QRResumen: TQuickRep;
    QRLabel1: TQRLabel;
    QRBand4: TQRBand;
    QRLabel2: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRLblPrimeroInsp: TQRLabel;
    QRLblUltimoInsp: TQRLabel;
    QRLblNumReverifi: TQRLabel;
    QRLblNumInsp: TQRLabel;
    QRLblNumBaja: TQRLabel;
    QRLblNumRechazado: TQRLabel;
    QRLblNumCondicional: TQRLabel;
    QRLblNumApto: TQRLabel;
    QRLblTotalInformes: TQRLabel;
    QRLblPrimeroCert: TQRLabel;
    QRLblUltimoCert: TQRLabel;
    QRLblPrimeraOblea: TQRLabel;
    QRLblUltimaOblea: TQRLabel;
    QRLblCertApto: TQRLabel;
    QRLblTotalCert: TQRLabel;
    QRLblTotalOblea: TQRLabel;
    QRLblAptoOblea: TQRLabel;
    QRLblCondicionalOblea: TQRLabel;
    QRLblIntervaloFechas: TQRLabel;
    DetailBand1: TQRBand;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    procedure QRResumenNeedData(Sender: TObject; var MoreData: Boolean);
    procedure QRResumenBeforePrint(Sender: TQuickRep;
      var PrintReport: Boolean);
  private
    bHaEntrado: boolean;

  public
    procedure Execute(const aDateIni, aDateFin,
                            PrimerInforme, UltimoInforme,
                            PrimeraOblea,  UltimaOblea,
                            Aptas, EnPrimera, Reverificaciones, Condicionales, Rechazadas, Bajas: string);
  end;

var
  FInspectionsSumary: TFInspectionsSumary;

implementation

{$R *.DFM}

procedure TFInspectionsSumary.Execute(const aDateIni, aDateFin,
                                  PrimerInforme, UltimoInforme,
                                  PrimeraOblea,  UltimaOblea,
                                  Aptas, EnPrimera, Reverificaciones, Condicionales, Rechazadas, Bajas: string);
begin
    bHaEntrado := False;

    QRLblIntervaloFechas.Caption := Format('(%s-%s)',[Copy(aDateIni,1,10),Copy(aDateFin,1,10)]);

    QRLblPrimeroInsp.Caption := PrimerInforme;
    QRLblUltimoInsp.Caption := UltimoInforme;

    QRLblPrimeraOblea.Caption := PrimeraOblea;
    QRLblUltimaOblea.Caption :=  UltimaOblea;

    QRLblNumInsp.Caption :=  EnPrimera;
    QRLblNumReverifi.Caption := Reverificaciones;
    QRLblNumApto.Caption := Aptas;
    QRLblAptoOblea.Caption := Aptas;
    QRLblNumCondicional.Caption := Condicionales;
    QRLblCondicionalOblea.Caption := Condicionales;
    QRLblNumRechazado.Caption := Rechazadas;
    QRLblNumBaja.Caption := Bajas;

    QRLblTotalInformes.Caption := IntToStr (StrToInt(Aptas) + StrToInt(Condicionales) + StrToInt(Rechazadas) + StrToInt(Bajas));
    QRLblTotalOblea.Caption := IntToStr (StrToInt(Aptas) + StrToInt(Condicionales));

    QRResumen.PrinterSetup;
    QRResumen.Print;
end;




procedure TFInspectionsSumary.QRResumenNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
    if bHaEntrado then
       MoreData := False
    else
    begin
        bHaEntrado := True;
        MoreData := True
    end;
end;

procedure TFInspectionsSumary.QRResumenBeforePrint(Sender: TQuickRep;
  var PrintReport: Boolean);
begin
    bHaEntrado := False;
end;


end.



