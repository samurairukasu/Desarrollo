unit urListProveedoresObleas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, SqlExpr, globals, FMTBcd,
  Provider, DB, DBClient;

type
  TfRepListProveedoresObleas = class(TForm)
    rep: TQuickRep;
    QRBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRBDetalle: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    qrlcant: TQRLabel;
    qrlini: TQRLabel;
    QRExpr1: TQRExpr;
    qrecant: TQRExpr;
    qreini: TQRExpr;
    QRExpr8: TQRExpr;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    qconsulta: TClientDataSet;
    dspconsulta: TDataSetProvider;
    sdsconsulta: TSQLDataSet;
    procedure QRBDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  Procedure DoLisProveedoresObleas();


var
  fRepListProveedoresObleas: TfRepListProveedoresObleas;

implementation

{$R *.dfm}

Procedure DoLisProveedoresObleas;
begin
  with TfRepListProveedoresObleas.Create(application) do
   try
      with qConsulta do
      begin
       sdsconsulta.SQLConnection := MyBD;
       CommandText:='SELECT * FROM PROVEEDORES_OBLEAS ORDER BY ANO';
       open;
     end;
     rep.DataSet := qConsulta;
     rep.preview;
   finally
     free;
   end;
end;

procedure TfRepListProveedoresObleas.QRBDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if rep.RecordNumber mod 2 <> 0 then
    QRBDetalle.color := clWhite
  else
    QRBDetalle.color := $00EBEBEB
end;

end.
