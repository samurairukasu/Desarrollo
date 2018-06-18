unit UInspectionResults;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, quickrpt, Qrctrls, QREXPORT, FMTBcd, SqlExpr,
  Provider, DBClient;

type
  TFInspectionsResults = class(TForm)
    DSourceResInsp: TDataSource;
    SD: TSaveDialog;
    QTResultadosInspeccion: TClientDataSet;
    dspQTResultadosInspeccion: TDataSetProvider;
    sdsQTResultadosInspeccion: TSQLDataSet;
    QRResultadosInspeccion: TQuickRep;
    QRBand1: TQRBand;
    lblTitulo: TQRLabel;
    QRLabel3: TQRLabel;
    LPlanta: TQRLabel;
    QRLabel4: TQRLabel;
    LFecha: TQRLabel;
    QRBand3: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel6: TQRLabel;
    QRBand5: TQRBand;
    QRSysData1: TQRSysData;
    QRBand4: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    QRBand2: TQRBand;
    QRLabel2: TQRLabel;
    qrltiempoprom: TQRLabel;
    qrltiempopromtotal: TQRLabel;
  private
    fDateIni, fDateFin, fEstacion: string;
  public
    procedure Execute(const aInitialDate, aFinalDate, aEstationName, tiempoprom, tiempototal: string; const aBD: TSQLConnection);
    procedure ExportaAscii (const aFi, aFf, aEstacion, tiempoprom, tiempototal: string; const aBD: TSQLConnection);
  end;

var
  FInspectionsResults: TFInspectionsResults;

implementation

{$R *.DFM}

uses
   QREXTRA,
   QRPRNTR;


procedure TFInspectionsResults.Execute(const aInitialDate, aFinalDate, aEstationName, tiempoprom, tiempototal: string; const aBD : TSQLConnection);
begin
    fDateIni := Copy(aInitialDate,1,10);
    fDateFin := Copy(aFinalDate,1,10);
    fEstacion := aEstationName;
    with QTResultadosInspeccion do
    try
        Close;
        sdsQTResultadosInspeccion.SQLConnection := aBD;
        Open;
        LPlanta.Caption := fEstacion;
        LFecha.Caption := Format('%S-%S',[Copy(fDateIni,1,10),Copy(fDateFin,1,10)]);
        qrltiempoprom.caption:=tiempoprom;
        qrltiempopromtotal.caption:=tiempototal;
        QRResultadosInspeccion.PrinterSetup;
        QRResultadosInspeccion.Print
    finally
        Close
    end
end;


    procedure TFInspectionsResults.ExportaAscii (const aFi, aFf, aEstacion, tiempoprom, tiempototal: string; const aBD: TSQLConnection);
    var
        aExportFilter : TQRAsciiExportFilter;
    begin
        try
            LPlanta.Caption := aEstacion;
            LFecha.Caption := Format('%S-%S',[Copy(aFi,1,10),Copy(aFF,1,10)]);
            sdsQTResultadosInspeccion.SQLConnection := aBD;
            qrltiempoprom.caption:=tiempoprom;
            qrltiempopromtotal.caption:=tiempototal;
            QTResultadosInspeccion.Open;

            if SD.Execute
            then begin
                aExportFilter := TQRAsciiExportFilter.Create(SD.FileName);
                try
                    QRResultadosInspeccion.ExportToFilter(aExportFilter);
                finally
                    aExportFilter.Free;
                end;
            end;
        finally
            QTResultadosInspeccion.Close;
        end;
    end;





end.
