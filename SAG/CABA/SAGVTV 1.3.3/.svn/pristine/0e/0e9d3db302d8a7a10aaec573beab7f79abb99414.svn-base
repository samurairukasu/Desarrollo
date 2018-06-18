unit UcertificadoCABA;

interface

uses
 { Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, QRCtrls, ExtCtrls, jpeg, FMTBcd, DB, SqlExpr,UCteVerificaciones;
   }
     Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  ExtCtrls,
  StdCtrls,
  Qrctrls,
  quickrpt,
  USAGVARIOS,
  USAGCLASSES,
  Db,
  USAGPRINTERS,
  sqlExpr, FMTBcd, jpeg, RxGIF, pCore2D, pBarcode2D, pQRCode,
       Variants,
  Dialogs,  Buttons,
  ULOGS,
  USAGESTACION,
  USAGCLASIFICACION,
  USAGFABRICANTE,
  UCTINSPECTORES,
  UFPRESPRELIMINAR,
  UCTEVERIFICACIONES,
  PRINTERS,
  GLOBALS,    USuperRegistry,uversion,
  QrPrnTr,
  UUtils, RxMemDS;

type
  TCERTIFICADOCABA = class(TForm)
    QuickRep1: TQuickRep;
    PageFooterBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel;
    QRLabel38: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel44: TQRLabel;
    QRLabel45: TQRLabel;
    QRLabel62: TQRLabel;
    QRLabel63: TQRLabel;
    QRLabel64: TQRLabel;
    QRLabel65: TQRLabel;
    QRLabel66: TQRLabel;
    QRLabel68: TQRLabel;
    QRLabel69: TQRLabel;
    QRLabel70: TQRLabel;
    QRLabel71: TQRLabel;
    QRLabel72: TQRLabel;
    QRLabel73: TQRLabel;
    QRLabel46: TQRLabel;
    QRExpr1: TQRExpr;
    QryDEFECTOSINSPECCION: TSQLQuery;
    LblGraves: TQRLabel;
    LblDescripcion: TQRDBText;
    LblLeves: TQRDBText;
    RxMemoryData1: TRxMemoryData;
    RxMemoryData1codigo: TStringField;
    RxMemoryData1descripcion: TStringField;
    RxMemoryData1calif: TStringField;
    RxMemoryData1califdef: TStringField;
    RxMemoryData1localiza: TStringField;
    RxMemoryData1literal: TStringField;
    QRLabel4: TQRLabel;
    QRLabel47: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel50: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel53: TQRLabel;
    QRLabel54: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel51: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel55: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel52: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel49: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel57: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel56: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    SQLQuery1: TSQLQuery;
    SummaryBand1: TQRBand;
    Barcode2D_QRCode1: TBarcode2D_QRCode;
    QRImage1: TQRImage;
    QRLabel12: TQRLabel;
    procedure QuickRep1BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }

     fInspeccion: TInspeccion;
    fEjercicio : integer;
    fCodigo: integer;
    fConsulta : TsqlQuery;

  public
    { Public declarations }
    REIMPRIME:BOOLEAN;
    contador:longint;
    FUNCTION ACTIVAR_COMPONENTES(bActivar:BOOLEAN):BOOLEAN;
  end;

var
  CERTIFICADOCABA: TCERTIFICADOCABA;

implementation

{$R *.dfm}

FUNCTION TCERTIFICADOCABA.ACTIVAR_COMPONENTES(bActivar:BOOLEAN):BOOLEAN;
  var i:longint;

begin

    for i := 0 to Self.ComponentCount-1 do
    begin
        if (Self.Components[i].Tag = 1) then
        begin
            if (Self.Components[i] is TQRImage) then
               TQRImage(Self.Components[i]).Enabled := bActivar
            else if (Self.Components[i] is TQRLabel) then
               TQRLabel(Self.Components[i]).Enabled := bActivar
            else if (Self.Components[i] is TQRShape) then
               TQRShape(Self.Components[i]).Enabled := bActivar
        end;
    end;

END;
procedure TCERTIFICADOCABA.QuickRep1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
  var i,NRO:longint;
  bActivar:boolean;
  aContexto:TSQLQuery;
begin

with TSuperRegistry.Create do
     try
        RootKey := HKEY_LOCAL_MACHINE;
      if not OpenKeyRead(II_) then
      begin
      Application.MessageBox( 'No se encontraron los parámetros NROPC de la Estación de Trabajo.',
  'Acceso denegado', MB_ICONSTOP );
        //  Messagedlg('ERROR','No se encontraron los parámetros de la Estación de Trabajo', mtInformation, [mbOk],mbOk,0);

       EXIT;
      end
      else
      begin
        NRO :=strtoint(ReadString('NROPC'));

      end;


      FINALLY
       FREE;
      END;



contador:=contador + 1;
IF (REIMPRIME=TRUE)  and (contador >=3) THEN
BEGIN
bActivar:=false;
    for i := 0 to Self.ComponentCount-1 do
    begin
        if (Self.Components[i].Tag = 0) then
        begin
            if (Self.Components[i] is TQRImage) then
               TQRImage(Self.Components[i]).Enabled := bActivar
            else if (Self.Components[i] is TQRLabel) then
               TQRLabel(Self.Components[i]).Enabled := bActivar
            else if (Self.Components[i] is TQRShape) then
               TQRShape(Self.Components[i]).Enabled := bActivar
        end;
    end;

 end ;

 IF (REIMPRIME=false)  and (contador >=2) THEN
BEGIN
bActivar:=false;
    for i := 0 to Self.ComponentCount-1 do
    begin
        if (Self.Components[i].Tag = 0) then
        begin
            if (Self.Components[i] is TQRImage) then
               TQRImage(Self.Components[i]).Enabled := bActivar
            else if (Self.Components[i] is TQRLabel) then
               TQRLabel(Self.Components[i]).Enabled := bActivar
            else if (Self.Components[i] is TQRShape) then
               TQRShape(Self.Components[i]).Enabled := bActivar
        end;
    end;

 end ;
       aContexto:=TSQLQuery.Create(nil);

     ////armar consulta
          with aContexto do
            begin
              SQLConnection:=mybd;
              sql.add('select NOMBREIMPRESORA,IZQUIERDO,SUPERIOR,IMPRESION from CONFIGURACIONIMPRESORA WHERE IMPRESION=:IMPRE  AND NROPC=:NROPC');
              ParamByName('IMPRE').Value:='II';
               ParamByName('NROPC').Value:=NRO;


                try
                  Open;



                   QuickRep1.PrinterSettings.PrinterIndex:=Printer.Printers.IndexOf(trim(aContexto.fieldbyname('NOMBREIMPRESORA').asstring));


                   /// QuickRep1.PrinterSettings.PrinterIndex:=Printer.Printers.IndexOf(trim('PS Driver for Universal Print'));

                    QuickRep1.Printersettings.OutputBin :=Auto;
                    QuickRep1.Printersettings.PaperSize :=Folio;
                  //  QuickRep1.PrinterSettings.Orientation :=poLandscape;// poPortrait;   //poLandscape
                    QuickRep1.Page.LeftMargin := STRTOINT(TRIM(aContexto.fieldbyname('IZQUIERDO').asstring));
                    QuickRep1.Page.TopMargin := STRTOINT(TRIM(aContexto.fieldbyname('SUPERIOR').asstring));

                  finally
                    Close;
                    Free;
                end;
            end;





end;

procedure TCERTIFICADOCABA.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  sCodigo_Auxi, sDescripcion_Auxi, sOk_Auxi, sLeve_Auxi, sGrave_Auxi: string;
begin
   {
    with qryDefectosInspeccion do
    begin


        ObtenerLiteralCalificativo (fVarios.Database, fEjercicio, fCodigo,
                                    trim(self.RxMemoryData1codigo.Value),
                                    trim(self.RxMemoryData1califdef.value),
                                    trim(self.RxMemoryData1literal.Value),
                                    trim(self.RxMemoryData1localiza.Value),
                                    sCodigo_Auxi, sDescripcion_Auxi, sOk_Auxi, sLeve_Auxi,
                                    sGrave_Auxi);
                                    

     //  if  trim(qryDefectosInspeccion.FieldByName(FIELD_CADDEFEC).AsString) <> '09.13.014' then
     //  begin

        LblDescripcion.Caption := sDescripcion_Auxi;
         if  (trim(sLeve_Auxi)='X') or (trim(sLeve_Auxi)='x') then
             LblLeves.Caption:='Leve';

         if  (trim(sGrave_Auxi)='X') or (trim(sGrave_Auxi)='x') then
             LblLeves.Caption:='Grave';

        // LblLeves.Caption := sLeve_Auxi;
         //LblGraves.Caption := sGrave_Auxi;


    end; }

end;

end.
