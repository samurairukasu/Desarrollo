unit ufDefectosInspGNCToPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, ExtCtrls, StdCtrls, usagclasses, uSagPrinters, globals,
  PRINTERS,sqlexpr, Provider, DBClient;

type
  TfrmDefectosInspGNCToPrint = class(TForm)
    repDefInspGNC: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    ChildBand1: TQRChildBand;
    QRLabel2: TQRLabel;
    qrlInforme: TQRLabel;
    QRLabel74: TQRLabel;
    QRLVehiculo: TQRLabel;
    QRLabel3: TQRLabel;
    QRBand2: TQRBand;
    QRExpr1: TQRExpr;
    QRLabel4: TQRLabel;
    QRLFecha: TQRLabel;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FDatInspecc : TDatinspecc;
    fDefectos: TClientDataSet;
    sdsfDefectos : TSQLDataSet;
    dspfDefectos: TDataSetProvider;
  public
    { Public declarations }
    constructor CreateFromEjercicioAndCode (const aEjercicio, aCode : integer; aContexto: pTContexto);
  end;

var
  frmDefectosInspGNCToPrint: TfrmDefectosInspGNCToPrint;

implementation

{$R *.DFM}

constructor TfrmDefectosInspGNCToPrint.CreateFromEjercicioAndCode (const aEjercicio, aCode : integer; aContexto: pTContexto);
begin
    inherited Create (Application);

    sdsfDefectos := TSQLDataSet.Create(self);
    sdsfDefectos.SQLConnection := MyBD;
    sdsfDefectos.CommandType := ctQuery;
    sdsfDefectos.GetMetadata := false;
    sdsfDefectos.NoMetadata := true;
    sdsfDefectos.ParamCheck := false;

    dspfDefectos := TDataSetProvider.Create(self);
    dspfDefectos.DataSet := sdsfDefectos;
    dspfDefectos.Options := [poIncFieldProps,poAllowCommandText];
    fDefectos := TClientDataSet.Create(self);

    with fDefectos do
    begin
       SETProvider(dspfDefectos);
       CommandText := Format(' SELECT  DESCRIPCION, FECHALTA FROM ' +
                       '   INSPGNC_DEFECTOS D, DEFECTOSGNC  T WHERE ' +
                       '   D.CODDEFEC = T.CODDEFEC   AND ' +
                       '   D.EJERCICI = %S AND  ' +
                       '   D.CODINSPGNC = %S ',
                       [ inttostr(aEjercicio),inttostr(aCode)]);
      open;
    end;

    fDatInspecc := nil;
    fDatInspecc := tdatinspecc.CreateByEjerCodinspe(mybd,inttostr(aEjercicio),inttostr(aCode));
    fDatInspecc.open;

    repDefInspGNC.DataSet:=fDefectos;
    QRLVehiculo.caption:= fdatinspecc.GetDominio;
    qrlInforme.caption:=fDatInspecc.GetNroInforme;

    if (aContexto <> nil) then
    begin
            repDefInspGNC.PrinterSettings.PrinterIndex:=Printer.Printers.IndexOf(aContexto^.sNombre);
            repDefInspGNC.Printersettings.OutputBin := aContexto^.qrbBandeja;
            repDefInspGNC.Page.PaperSize := aContexto^.qrpPapel;
            repDefInspGNC.PrinterSettings.Orientation := aContexto^.qroOrientacion;
            repDefInspGNC.Page.LeftMargin := aContexto^.iMargenIzquierdo;
            repDefInspGNC.Page.TopMargin := aContexto^.iMargenSuperior;
    end;

    repDefInspGNC.Print;

end;


procedure TfrmDefectosInspGNCToPrint.FormDestroy(Sender: TObject);
begin
    if Assigned(FDatInspecc)
    then begin
        FDatInspecc.Close;
        FDatInspecc.Free;
    end;
end;



end.
