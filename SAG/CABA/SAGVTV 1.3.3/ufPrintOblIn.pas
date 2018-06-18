unit ufPrintOblIn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, quickrpt, Qrctrls, Db, SQLExpr, globals, FMTBcd,
  Provider, DBClient;

type
  TfmImprimOblInut = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    qrlestacion: TQRLabel;
    query1: TClientDataSet;
    dspquery1: TDataSetProvider;
    sdsquery1: TSQLDataSet;
    QRBand4: TQRBand;
    QRLabel7: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    QRSysData2: TQRSysData;
    QRLabel9: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure QuickRep1BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure doImprimeOblInutilizadas(dateini,datefin: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  procedure doImprimeOblInut;


var
  fmImprimOblInut: TfmImprimOblInut;
  dateini,datefin: string;
implementation

{$R *.DFM}
uses ugetdates,
     ugacceso,
     usagctte;

procedure TfmImprimOblInut.doImprimeOblInutilizadas(dateini,datefin: String);
begin
with TfmImprimOblInut.Create(Application) do
   try
      Query1.Close;
      sdsQuery1.ParamByName('fechaini').AsDatetime:=strtodatetime(dateini);
      sdsQuery1.ParamByName('fechafin').AsDatetime:=strtodatetime(datefin);
      Query1.Open;
      qrlestacion.Caption := 'Planta: '+fvarios.NombreEstacionCompleto;
      QuickRep1.Print;
   finally
      Free;
   end;
end;


procedure doImprimeOblInut;
begin
if not getdates(dateini,datefin) then exit;
with TfmImprimOblInut.Create(Application) do
   try
      Query1.Close;
      sdsQuery1.ParamByName('fechaini').AsDatetime:=strtodatetime(dateini);
      sdsQuery1.ParamByName('fechafin').AsDatetime:=strtodatetime(datefin);
      Query1.Open;
      qrlestacion.Caption := 'Planta: '+fvarios.NombreEstacionCompleto;
      QuickRep1.Preview;
   finally
      Free;
   end;
end;

procedure TfmImprimOblInut.FormCreate(Sender: TObject);
begin
  sdsQuery1.sqlconnection:=mybd;
end;

procedure TfmImprimOblInut.QuickRep1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
//  if PasswordUser = MASTER_KEY then
//      quickrep1.PrinterSettings.Copies := 2;
end;

end.




