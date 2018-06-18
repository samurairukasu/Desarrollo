unit ufListadoMarcasToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, quickrpt, ufListadoMarcas, Qrctrls, uSagFabricante, SQLExpr, provider,
  dbclient;

type
  TfrmListadoMarcasToPrint = class(TForm)
    repMarcas: TQuickRep;
    QRBand1: TQRBand;
    QRGroup1: TQRGroup;
    QRBand2: TQRBand;
    QRExpr2: TQRExpr;
    QRLabel1: TQRLabel;
    QRBand3: TQRBand;
    qrlPagina: TQRLabel;
    QRExpr1: TQRExpr;
    QRBand4: TQRBand;
    QRLabel2: TQRLabel;
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }

  public
    { Public declarations }
    cantPaginas : integer;
    fModelo : TClientDataSet;
    sds : TSQLDataSet;
    dsp : TDataSetProvider;
  end;

var
  frmListadoMarcasToPrint: TfrmListadoMarcasToPrint;

implementation

{$R *.DFM}

procedure TfrmListadoMarcasToPrint.QRBand3BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
      qrlPagina.caption := 'Pág. '+inttostr(repMarcas.QRPrinter.pagenumber) +' de '+intToStr(cantpaginas);
end;


end.
