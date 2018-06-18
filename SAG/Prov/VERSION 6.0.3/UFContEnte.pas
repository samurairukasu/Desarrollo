unit ufContENTE;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, quickrpt, Db, Qrctrls, RxQuery, globals, FMTBcd,
  Provider, DBClient, SqlExpr, Grids, DBGrids, DBXpress;

type
  TfmControlENTE = class(TForm)
    sdsListado: TSQLDataSet;
    Query1: TClientDataSet;
    dspListado: TDataSetProvider;
    QuickRep1: TQuickRep;
    QRBand3: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRBand4: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel8: TQRLabel;
    QRBand1: TQRBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure QuickRep1BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmControlENTE: TfmControlENTE;

implementation

{$R *.DFM}

uses
   ugacceso,
   usagctte;

procedure TfmControlENTE.FormCreate(Sender: TObject);
begin
  sdsListado.sqlconnection := mybd;
end;

procedure TfmControlENTE.QuickRep1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
//    if PasswordUser = MASTER_KEY then
//      quickrep1.PrinterSettings.Copies := 3;
end;

end.
