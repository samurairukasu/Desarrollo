unit ufprintOblAn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, quickrpt, Qrctrls, Db,SqlExpr, globals, FMTBcd, Provider,
  DBClient;

type
  TfmImprimOblAnul = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    query1: TClientDataSet;
    dspquery1: TDataSetProvider;
    sdsquery1: TSQLDataSet;
    qrlestacion: TQRLabel;
    QRLabel8: TQRLabel;
    QRBand4: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel9: TQRLabel;
    QRSysData2: TQRSysData;
    procedure FormCreate(Sender: TObject);
    procedure QuickRep1BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DoImprimeOblAnul(dateini,datefin: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  procedure DoImprimeOblAnul;

var
  fmImprimOblAnul: TfmImprimOblAnul;
  dateini,datefin:string;

implementation

uses ugetdates,
     ugacceso,
     usagctte;

{$R *.DFM}


procedure TfmImprimOblAnul.DoImprimeOblAnul(dateini,datefin: String);
begin
with TfmImprimOblAnul.Create(Application) do
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

procedure DoImprimeOblAnul;
begin
if not getdates(dateini,datefin) then
  exit;
with TfmImprimOblAnul.Create(Application) do
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

procedure TfmImprimOblAnul.FormCreate(Sender: TObject);
begin
  sdsquery1.sqlconnection:=mybd;
end;


procedure TfmImprimOblAnul.QuickRep1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
//   if PasswordUser = MASTER_KEY then
//      quickrep1.PrinterSettings.Copies := 2;
end;

end.
