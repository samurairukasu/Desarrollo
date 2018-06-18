unit ufprintOblAnGNC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, quickrpt, Qrctrls, Db,  globals, FMTBcd, Provider,
  DBClient, SqlExpr;

type
  TfmImprimOblAnulGNC = class(TForm)
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
    QRBand4: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRDBText5: TQRDBText;
    sdsquery1: TSQLDataSet;
    query1: TClientDataSet;
    dspquery1: TDataSetProvider;
    qrlestacion: TQRLabel;
    QRLabel8: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure QuickRep1BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  procedure DoImprimeOblAnulGNC;

var
  fmImprimOblAnulGNC: TfmImprimOblAnulGNC;
  dateini,datefin:string;

implementation

uses ugetdates,
     ugacceso,
     usagctte;

{$R *.DFM}

procedure DoImprimeOblAnulGNC;
begin
   if not getdates(dateini,datefin) then exit;
   with TfmImprimOblAnulGNC.Create(Application) do
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

procedure TfmImprimOblAnulGNC.FormCreate(Sender: TObject);
begin
  sdsquery1.SQLConnection :=mybd;
end;


procedure TfmImprimOblAnulGNC.QuickRep1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
//    if PasswordUser = MASTER_KEY then
//      quickrep1.PrinterSettings.Copies := 2;
end;

end.
