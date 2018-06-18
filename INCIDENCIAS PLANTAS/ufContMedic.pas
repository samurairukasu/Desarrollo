unit ufContMedic;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  QuickRpt, Qrctrls, ExtCtrls, Db, SqlExpr, globals, FMTBcd, Provider,
  DBClient, DBXpress;

type
  TfmControlMed = class(TForm)
    quickrep1: TQuickRep;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRLabel1: TQRLabel;
    QRBand3: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    query1: TClientDataSet;
    dspquery1: TDataSetProvider;
    sdsquery1: TSQLDataSet;
    QRLabel14: TQRLabel;
    LblXEstacion: TQRLabel;
    QRLblIntervaloFechas: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  procedure DoControlMediciones;



var
  fmControlMed: TfmControlMed;
  dateini,datefin:string;

implementation

{$R *.DFM}

uses
  ugetdates;

  
procedure DoControlMediciones;
begin
  with TfmControlMed.Create(Application) do
    try
      if not getdates(dateini,datefin) then exit;
      Query1.Close;
      sdsQuery1.ParamByName('fechaini').AsDatetime:=strtodatetime(dateini);
      sdsQuery1.ParamByName('fechafin').AsDatetime:=strtodatetime(datefin);
      Query1.Open;
      LblXEstacion.Caption := 'Planta: '+fVarios.NombreEstacion;
      QRLblIntervaloFechas.Caption := Format('Desde: %s - Hasta: %s',[Copy(dateIni,1,10),Copy(dateFin,1,10)]);
      QuickRep1.Preview;
    finally
      Free;
    end;

end;

procedure TfmControlMed.FormCreate(Sender: TObject);
begin
  sdsquery1.SQLConnection:=mybd;
end;

end.
