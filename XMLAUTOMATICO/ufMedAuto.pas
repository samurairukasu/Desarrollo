unit ufMedAuto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, ExtCtrls, StdCtrls, usagclasses, uSagPrinters, globals,
  PRINTERS, uSagEstacion;

type
  TfrmMedAuto = class(TForm)
    repMedAuto: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    ChildBand1: TQRChildBand;
    QRLabel2: TQRLabel;
    qrlInforme: TQRLabel;
    QRLabel74: TQRLabel;
    QRLVehiculo: TQRLabel;
    QRLabel3: TQRLabel;
    QRBand2: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    QRLabel59: TQRLabel;
    QRLabel60: TQRLabel;
    QRLabel61: TQRLabel;
    QRLabel62: TQRLabel;
    QRLabel63: TQRLabel;
    QRLabel64: TQRLabel;
    QRLabel65: TQRLabel;
    QRLabel66: TQRLabel;
    QRLabel67: TQRLabel;
    QRLabel68: TQRLabel;
    QRLabel69: TQRLabel;
    QRLabel70: TQRLabel;
    QRLabel71: TQRLabel;
    QRLabel72: TQRLabel;
    QRLabel73: TQRLabel;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRExpr12: TQRExpr;
    QRExpr13: TQRExpr;
    QRExpr16: TQRExpr;
    QRExpr17: TQRExpr;
    QRExpr18: TQRExpr;
    QRExpr19: TQRExpr;
    QRExpr20: TQRExpr;
    QRExpr21: TQRExpr;
    QRExpr22: TQRExpr;
    QRExpr23: TQRExpr;
    QRExpr24: TQRExpr;
    QRExpr29: TQRExpr;
    QRExpr38: TQRExpr;
    QRExpr39: TQRExpr;
    QRExpr58: TQRExpr;
    QRExpr59: TQRExpr;
    QRExpr60: TQRExpr;
    QRExpr61: TQRExpr;
    QRExpr62: TQRExpr;
    QRExpr63: TQRExpr;
    QRExpr64: TQRExpr;
    QRExpr65: TQRExpr;
    QRExpr66: TQRExpr;
    QRExpr67: TQRExpr;
    QRExpr69: TQRExpr;
    QRExpr70: TQRExpr;
    QRExpr71: TQRExpr;
    QRExpr72: TQRExpr;
    QRExpr73: TQRExpr;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape5: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape23: TQRShape;
    QRShape24: TQRShape;
    QRShape33: TQRShape;
    QRShape37: TQRShape;
    QRShape38: TQRShape;
    QRShape39: TQRShape;
    QRShape40: TQRShape;
    QRShape41: TQRShape;
    QRShape42: TQRShape;
    QRShape43: TQRShape;
    QRShape44: TQRShape;
    QRShape45: TQRShape;
    QRShape48: TQRShape;
    QRShape54: TQRShape;
    QRShape55: TQRShape;
    QRShape56: TQRShape;
    QRShape57: TQRShape;
    QRShape58: TQRShape;
    QRShape61: TQRShape;
    QRShape62: TQRShape;
    QRShape64: TQRShape;
    QRShape65: TQRShape;
    QRLabel4: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr68: TQRExpr;
    QRLabel75: TQRLabel;
    QRLabel76: TQRLabel;
    QRLabel77: TQRLabel;
    qrlFechalta: TQRLabel;
    QRImage1: TQRImage;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRShape6: TQRShape;
    RBOCINA: TQRExpr;
    RESCAPE: TQRExpr;
    QRShape14: TQRShape;
    procedure FormDestroy(Sender: TObject);
 

  private
    { Private declarations }
    FDatInspecc : TDatinspecc;
  public
    { Public declarations }
    constructor CreateFromEjercicioAndCode (const aEjercicio, aCode : integer; aContexto: pTContexto);
  end;

var
  frmMedAuto: TfrmMedAuto;

implementation

{$R *.DFM}

constructor TfrmMedAuto.CreateFromEjercicioAndCode (const aEjercicio, aCode : integer; aContexto: pTContexto);
begin
    inherited Create (Application);

    fDatInspecc := nil;
    fDatInspecc := tdatinspecc.CreateByEjerCodinspe(mybd,inttostr(aEjercicio),inttostr(aCode));
    fDatInspecc.open;

    repmedauto.DataSet:=fdatinspecc.DataSet;
    QRLVehiculo.caption:= fdatinspecc.GetDominio;
    qrlInforme.caption:=fDatInspecc.GetNroInforme;

    with TInspeccion.CreateFromDataBase(mybd,DATOS_INSPECCIONES,format('WHERE EJERCICI = %S AND CODINSPE = %S',[inttostr(aEjercicio),inttostr(aCode)])) do
      try
        open;
        qrlFechalta.Caption := ValueByName[FIELD_FECHALTA];
      finally
        free;
      end;

    if (aContexto <> nil) then
    begin
            repmedauto.PrinterSettings.PrinterIndex:=Printer.Printers.IndexOf(aContexto^.sNombre);
            repmedauto.Printersettings.OutputBin := aContexto^.qrbBandeja;
            repmedauto.Page.PaperSize := aContexto^.qrpPapel;
            repmedauto.PrinterSettings.Orientation := aContexto^.qroOrientacion;
            repmedauto.Page.LeftMargin := aContexto^.iMargenIzquierdo;
            repmedauto.Page.TopMargin := aContexto^.iMargenSuperior;
    end;

    repmedauto.Print;

end;


procedure TfrmMedAuto.FormDestroy(Sender: TObject);
begin
    if Assigned(FDatInspecc)
    then begin
        FDatInspecc.Close;
        FDatInspecc.Free;
    end;
end;


end.
