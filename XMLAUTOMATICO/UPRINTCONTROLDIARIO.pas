unit UPrintControlDiario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, ExtCtrls, Db, qrexport, FMTBcd, DBClient, Provider,
  SqlExpr;

type
  TFPrintControlDiario = class(TForm)
    SD: TSaveDialog;
    sdsQVControlDiario: TSQLDataSet;
    dspQVControlDiario: TDataSetProvider;
    QVControlDiario: TClientDataSet;
    QRControlDiario: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    LPlanta: TQRLabel;
    LFecha: TQRLabel;
    headergroup: TQRGroup;
    QRDBText1: TQRDBText;
    detailedgroup: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    QRDBText16: TQRDBText;
    QRDBText17: TQRDBText;
    QRDBText18: TQRDBText;
    QRDBText19: TQRDBText;
    groupfooter: TQRBand;
    QRExpr2: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    QRExpr1: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr12: TQRExpr;
    QRExpr13: TQRExpr;
    QRExpr14: TQRExpr;
    QRExpr15: TQRExpr;
    QRLabel14: TQRLabel;
    QRBand2: TQRBand;
    QRLabel15: TQRLabel;
    QRExpr16: TQRExpr;
    QRExpr17: TQRExpr;
    QRExpr18: TQRExpr;
    QRExpr19: TQRExpr;
    QRExpr20: TQRExpr;
    QRExpr21: TQRExpr;
    QRExpr22: TQRExpr;
    QRExpr23: TQRExpr;
    QRExpr24: TQRExpr;
    QRExpr25: TQRExpr;
    QRExpr26: TQRExpr;
    QRExpr27: TQRExpr;
    QRExpr28: TQRExpr;
    QRExpr29: TQRExpr;
    QRExpr30: TQRExpr;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel;
    QRLabel38: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    QRLabel42: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel44: TQRLabel;
    QRLabel45: TQRLabel;
    QRLabel46: TQRLabel;
    QRLabel47: TQRLabel;
    QRLabel48: TQRLabel;
    QRLabel49: TQRLabel;
    QRLabel50: TQRLabel;
    QRLabel51: TQRLabel;
    QRLabel52: TQRLabel;
    QRLabel53: TQRLabel;
    QRLabel54: TQRLabel;
    ColumnHeader: TQRBand;
    QRLabel32: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel13: TQRLabel;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute (const aFi, aFf, aEstacion: string; const aBD: tSQLConnection);
    procedure ExportaAscii (const aFi, aFf, aEstacion: string; const aBD: tSQLConnection);
  end;

var
  FPrintControlDiario: TFPrintControlDiario;

implementation

{$R *.DFM}

uses
   QREXTRA,
   QRPRNTR;

    procedure TFPrintControlDiario.Execute (const aFi, aFf, aEstacion: string; const aBD: tSQLConnection);
    begin
        try
            LPlanta.Caption := aEstacion;
            LFecha.Caption := Format('%S-%S',[Copy(aFi,1,10),Copy(aFF,1,10)]);
            sdsQVControlDiario.SQLConnection := aBD;
            QVControlDiario.Open;
            QRcontrolDiario.PrinterSetup;
            QRcontrolDiario.Print;
        finally
            QVControlDiario.Close;
        end;
    end;

    procedure TFPrintControlDiario.ExportaAscii (const aFi, aFf, aEstacion: string; const aBD: tSQLConnection);
    var
        aExportFilter : TQRAsciiExportFilter;
    begin
        try
            LPlanta.Caption := aEstacion;
            LFecha.Caption := Format('%S-%S',[Copy(aFi,1,10),Copy(aFF,1,10)]);
            sdsQVControlDiario.SQLConnection := aBD;
            QVControlDiario.Open;

            if SD.Execute
            then begin
                aExportFilter := TQRAsciiExportFilter.Create(SD.FileName);
                try
                    QRControlDiario.ExportToFilter(aExportFilter);
                finally
                    aExportFilter.Free;
                end;
            end;
        finally
            QVControlDiario.Close;
        end;
    end;
end.
