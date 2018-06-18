unit UPrintControlDiarioSumary;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, ExtCtrls, Db, USAGESTACION, qrexport;

type
  TFPrintControlDiarioSumary = class(TForm)
    QRControlDiarioSumary: TQuickRep;
    BAnda: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    LPlanta: TQRLabel;
    LFecha: TQRLabel;
    SD: TSaveDialog;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    SUP: TQRLabel;
    VSUP: TQRLabel;
    OVC: TQRLabel;
    VC: TQRLabel;
    IVC: TQRLabel;
    TVC: TQRLabel;
    TSAC: TQRLabel;
    QRShape1: TQRShape;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    SAC: TQRLabel;
    FCYP1: TQRLabel;
    NCYP1: TQRLabel;
    NCYP2: TQRLabel;
    NNYP1: TQRLabel;
    NNYP2: TQRLabel;
    SR: TQRLabel;
    SACR: TQRLabel;
    LCYP2: TQRLabel;
    LCYP1: TQRLabel;
    FNYP2: TQRLabel;
    FCYP2: TQRLabel;
    FNYP1: TQRLabel;
    LNYP2: TQRLabel;
    LNYP1: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel40: TQRLabel;
    Obs: TQRLabel;
    QRLabel18: TQRLabel;
    SOU: TQRLabel;
    procedure QRControlDiarioSumaryNeedData(Sender: TObject;var MoreData: Boolean);
  private
    { Private declarations }
    fSeguir : Boolean;
    fSumaryCD : tSumaryCD;
    ffi, fff, fEstacion : string;
  public
    { Public declarations }
    procedure Execute (const aFi, aFf, aEstacion: string; const aSCD: tSumaryCD);
    procedure ExportaAscii (const aFi, aFf, aEstacion: string; const asCD: tSumaryCD);
  end;

var
  FPrintControlDiarioSumary: TFPrintControlDiarioSumary;

implementation

{$R *.DFM}

uses
   QREXTRA,
   QRPRNTR;

    procedure TFPrintControlDiarioSumary.Execute (const aFi, aFf, aEstacion: string; const aSCD: tSumaryCD);
    begin
        fSumaryCD := aSCD;
        FFi := aFI;
        FFf := aFf;
        fEstacion := aEstacion;
        fSeguir := TRUE;
        QRControlDiarioSumary.PrinterSetup;
        QRControlDiarioSumary.Print;
    end;

    procedure TFPrintControlDiarioSumary.ExportaAscii (const aFi, aFf, aEstacion: string; const aSCD: tSumaryCD);
    var
        aExportFilter : TQRAsciiExportFilter;
    begin
            fSumaryCD := aSCD;
            FFi := aFI;
            FFf := aFf;
            fEstacion := aEstacion;
            fSeguir := TRUE;
            if SD.Execute
            then begin
                aExportFilter := TQRAsciiExportFilter.Create(SD.FileName);
                try
                    QRControlDiarioSumary.ExportToFilter(aExportFilter);
                finally
                    aExportFilter.Free;
                end;
            end;
    end;


procedure TFPrintControlDiarioSumary.QRControlDiarioSumaryNeedData(Sender: TObject; var MoreData: Boolean);
begin
    LPlanta.Caption := fEstacion;
    LFecha.Caption := Format('%S-%S',[Copy(fFi,1,10),Copy(fFF,1,10)]);

    with fSumaryCD do
    begin
        SUP.Caption := '$'+Format('%.2f  ',[StrToFloat(iSubPubUsers)]);
        VSUP.Caption := '$'+Format('%.2f  ',[StrToFloat(iSalesWOPubUsers)]);
        OVC.Caption := '$'+Format('%.2f  ',[StrToFloat(iOCreditSales)]);
        VC.Caption := '$'+Format('%.2f  ',[StrToFloat(iContSales)]);
        IVC.Caption := '$'+Format('%.2f  ',[StrToFloat(iIvaContSales)]);
        TVC.Caption := '$'+Format('%.2f  ',[StrToFloat(iTtlContSales)]);
        TSAC.Caption := '$'+Format('%.2f  ',[StrToFloat(iTtlArqueoCaja)]);
        SAC.Caption := iNAC + '  ';
        SR.Caption := iNR + '  ';
        SACR.Caption := iNACR + '  ';

        NCYP1.Caption := iNOblCYP1 + '  ';
        NCYP2.Caption := iNOblCYP2 + '  ';
        NNYP1.Caption := iNOblNYP1 + '  ';
        NNYP2.Caption := iNOblNYP2 + '  ';;
        SOU.Caption := IntToStr ( StrToInt(iNOblCYP1) + StrToInt(iNOblCYP2) + StrToInt(iNOblNYP1) + StrToInt(iNOblNYP2))  + '  ';

        FCYP1.Caption := FOblCYearP1;
        LCYP1.Caption := LOblCYearP1;

        FNYP1.Caption := FOblNYearP1;
        LNYP1.Caption := LOblNYearP1;

        FCYP2.Caption := FOblCYearP2;
        LCYP2.Caption := LOblCYearP2;

        FNYP2.Caption := FOblNYearP2;
        LNYP2.Caption := LOblNYearP2;

        Obs.Caption := 'Observaciones:' + #13 + #10 + Observaciones + '  ';
    end;

    if not fSeguir
    then MoreData := FALSE;

    fSeguir := FALSE;
end;



end.
