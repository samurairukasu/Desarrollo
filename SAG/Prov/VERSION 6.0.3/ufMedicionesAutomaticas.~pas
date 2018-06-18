unit ufMedicionesAutomaticas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, ExtCtrls, StdCtrls, usagclasses, uSagPrinters, globals,
  PRINTERS;

type
  TfrmMedicionesAutomaticas = class(TForm)
    repMedAuto: TQuickRep;
    QRBand2: TQRBand;
    QRExpr4: TQRExpr;
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
    QRExpr69: TQRExpr;
    QRExpr72: TQRExpr;
    QRExpr73: TQRExpr;
    QRLVehiculo: TQRLabel;
    QRLInforme: TQRLabel;
    QRDBText1: TQRDBText;
    procedure FormDestroy(Sender: TObject);
    procedure repMedAutoPreview(Sender: TObject);
    procedure repMedAutoAfterPreview(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FDatInspecc : TDatinspecc;
    fImprimirInformeMedicion: boolean; { True si el usuario ha pulsado "Imprimir" }
    function GetImprimirInformeMedicion: boolean;
    procedure SetImprimirInformeMedicion (const bImprimir: boolean);
  public
    { Public declarations }
    constructor CreateFromEjercicioAndCode (const aEjercicio, aCode : integer; aContexto: pTContexto; const bPresPreliminar: boolean);
    property ImprimirInformeMedicion: boolean read GetImprimirInformeMedicion write SetImprimirInformeMedicion;
  end;

var
  frmMedicionesAutomaticas: TfrmMedicionesAutomaticas;

implementation

uses
    UFPRESPRELIMINAR,
    QrPrntr,
    uUtils;
{$R *.DFM}


var
  frmPresPreliminar_Auxi: TfrmPresPreliminar;

constructor TfrmMedicionesAutomaticas.CreateFromEjercicioAndCode (const aEjercicio, aCode : integer; aContexto: pTContexto; const bPresPreliminar: boolean);
begin
    inherited Create (Application);

    fDatInspecc := nil;
    fDatInspecc := tdatinspecc.CreateByEjerCodinspe(mybd,inttostr(aEjercicio),inttostr(aCode));
    fDatInspecc.open;

    repmedauto.DataSet:=fdatinspecc.DataSet;
    QRDBText1.DataSet := fdatinspecc.DataSet;
    QRLVehiculo.caption:= fdatinspecc.GetDominio;
    qrlInforme.caption:=fDatInspecc.GetNroInforme;


    If (QRLVehiculo.caption <> '') and (qrlInforme.caption <> '') then
      Begin
        if bPresPreliminar then
          begin
//        ActivarDesactivar_Componentes (True);
            repMedAuto.Page.Orientation := poPortrait;
            repMedAuto.Preview
          end
        else
          begin
            if (aContexto <> nil) then
              begin
                repmedauto.PrinterSettings.PrinterIndex:=Printer.Printers.IndexOf(aContexto^.sNombre);
                repmedauto.Printersettings.OutputBin := aContexto^.qrbBandeja;
                repmedauto.Page.PaperSize := aContexto^.qrpPapel;
                repmedauto.PrinterSettings.Orientation := aContexto^.qroOrientacion;
                repmedauto.Page.LeftMargin := aContexto^.iMargenIzquierdo;
                repmedauto.Page.TopMargin := aContexto^.iMargenSuperior;
              end;
           //QRMENSAJE.Caption:='UD. PUEDE COMPLETAR UNA ENCUESTA DE SATISFACCION EN www.applus.com.ar';
          repmedauto.Print;
        end;
    end
  else
    MessageDlg('No se encuentran mediciones para el vehiculo ingresado. ', mtError, [mbOK], 0);
end;

function TfrmMedicionesAutomaticas.GetImprimirInformeMedicion: boolean;
begin
//QRMENSAJE.Caption:='UD. PUEDE COMPLETAR UNA ENCUESTA DE SATISFACCION EN www.applus.com.ar';
    Result := fImprimirInformeMedicion;
end;

procedure TfrmMedicionesAutomaticas.SetImprimirInformeMedicion(const bImprimir: boolean);
begin
//QRMENSAJE.Caption:='UD. PUEDE COMPLETAR UNA ENCUESTA DE SATISFACCION EN www.applus.com.ar';
    fImprimirInformeMedicion := bImprimir;
end;

procedure TfrmMedicionesAutomaticas.FormDestroy(Sender: TObject);
begin
    if Assigned(FDatInspecc)
    then begin
        FDatInspecc.Close;
        FDatInspecc.Free;
    end;
end;


procedure TfrmMedicionesAutomaticas.repMedAutoPreview(Sender: TObject);
begin
   frmPresPreliminar_Auxi := TfrmPresPreliminar.Create (Application);
   frmPresPreliminar_Auxi.QRPrevPresPrel.QRPrinter := TQRPrinter (Sender);
  // QRMENSAJE.Caption:='UD. PUEDE COMPLETAR UNA ENCUESTA DE SATISFACCION EN www.applus.com.ar';
   frmPresPreliminar_Auxi.Show;
end;

procedure TfrmMedicionesAutomaticas.repMedAutoAfterPreview(
  Sender: TObject);
begin
//QRMENSAJE.Caption:='UD. PUEDE COMPLETAR UNA ENCUESTA DE SATISFACCION EN www.applus.com.ar';
    ImprimirInformeMedicion := (frmPresPreliminar_Auxi.ModalResult = mrOk);
end;

procedure TfrmMedicionesAutomaticas.FormCreate(Sender: TObject);
begin
//QRMENSAJE.Caption:='UD. PUEDE COMPLETAR UNA ENCUESTA DE SATISFACCION EN www.applus.com.ar';
end;

end.
