unit uArqueoCajaSumaryPintXCajero;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, SqlExpr, quickrpt, Qrctrls, USAGCLASSES, variants,
  qrexport;

type
  TFArqueoCajaSumaryxCajero = class(TForm)
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    QRImprimirIntervalos: TQuickRep;
    qrlTitulo: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel12: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel19: TQRLabel;
    QRLblIntervaloFechas: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel2: TQRLabel;
    LTCliente: TQRLabel;
    QRLabel4: TQRLabel;
    LFacturas: TQRLabel;
    QRLabel6: TQRLabel;
    LNotas: TQRLabel;
    LINTotal: TQRLabel;
    LIva: TQRLabel;
    LIvaNo: TQRLabel;
    LTotal: TQRLabel;
    LTipoPago: TQRLabel;
    SD: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure QRImprimirIntervalosNeedData(Sender: TObject;
      var MoreData: Boolean);
  private
    { Private declarations }
    ListadoDescuento: string;
    procedure Doit;

  public
    { Public declarations }
    fTiposCliente : TTiposCliente;
    procedure Execute(const cFechaIni, cFechaFin, cTipoPago,aTipoCliente: string);
    procedure ExportaAscii(const cFechaIni, cFechaFin, cTipoPago, aTipoCliente:  string);
  end;

var
  FArqueoCajaSumaryxCajero: TFArqueoCajaSumaryxCajero;

implementation

{$R *.DFM}

uses
    QREXTRA,
    QRPRNTR,
    GLOBALS,
    USAGESTACION;



const
    FICHERO_ACTUAL = 'UArqueoCajaExtendedToPrint';
    FACTURAS_CON_DESCUENTO = 'D';

procedure TFArqueoCajaSumaryxCajero.Execute(const cFechaIni, cFechaFin, cTipoPago, aTipoCliente:  string);
var fTiposCliente: TTiposCliente;
begin
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);
    LTipoPago.Caption := Format('TIPO DE PAGO: %S',[UpperCase(cTipoPago)]);
    if aTipoCliente = FACTURAS_CON_DESCUENTO then
    begin
      LTipoPago.Caption := 'TIPO DE PAGO: GLOBAL';
    end;
    ListadoDescuento:= aTipoCliente;

    if cTipoPago = 'Tipo Cliente' then
    begin
      fTiposCliente := TTiposCliente.CreateFromDatabase(MyBD,DATOS_TIPOS_DE_CLIENTE,FORMAT('WHERE TIPOCLIENTE_ID = ''%S''',[aTipoCliente]));
      fTiposCliente.open;
      LTipoPago.caption:='TIPO DE CLIENTE: '+fTiposCliente.ValueByName[FIELD_DESCRIPCION];
      fTiposCliente.close;
      fTiposCliente.free;
    end;

    QRImprimirIntervalos.PrinterSetup;
    QRImprimirIntervalos.Print;

end;

procedure TFArqueoCajaSumaryxCajero.Doit;
var
    ArrayVar: Variant;
begin
    LTCliente.Caption := fTiposCliente.ValueByName[FIELD_DESCRIPCION];
    ArrayVar:=VarArrayCreate([0,0],VarVariant);
    ArrayVar[0]:=fTiposCliente.ValueByName[FIELD_DESCRIPCION];
    if ListadoDescuento <> 'D' then
    begin
      LFacturas.Caption := fTiposCliente.ExecuteFunction('NFacturas',ArrayVar);
      LNotas.Caption := fTiposCliente.ExecuteFunction('NNotas',ArrayVar);
    end
    else
    begin
      LFacturas.Caption := fTiposCliente.ExecuteFunction('NFacturasDesc',ArrayVar);
      LNotas.Caption := fTiposCliente.ExecuteFunction('NNotasDesc',ArrayVar);
    end;
    with TsqlQuery.Create(nil) do
    try
        SQLConnection := fTiposCliente.Database;
        if ListadoDescuento <> 'D' then
          SQL.Add (Format ('SELECT NVL(SUM(IMPORTE),0) INETO, NVL(SUM(IVA),0) IVA, NVL(SUM(IVANOINSCRIPTO),0) IVAN, NVL(SUM(TOTAL),0) TOT FROM TTMPARQCAJAEXTEN WHERE TIPOCLIENTE = ''%S''',[fTiposCliente.ValueByName[FIELD_DESCRIPCION]]))
        else
          SQL.Add (Format ('SELECT NVL(SUM(IMPORTE),0) INETO, NVL(SUM(IVA),0) IVA, NVL(SUM(IVANOINSCRIPTO),0) IVAN, NVL(SUM(TOTAL),0) TOT FROM TTMPARQCAJAEXTENDESC WHERE TIPOCLIENTE = ''%S''',[fTiposCliente.ValueByName[FIELD_DESCRIPCION]]));
        Open;
        LINTotal.Caption := FieldByName('INETO').AsString;
        LIva.Caption := FieldByName('IVA').AsString;
        LIvaNo.Caption := FieldByName('IVAN').AsString;
        LTotal.Caption := FieldByName('TOT').AsString;
    finally
        Close;
        Free;
    end;
end;


procedure TFArqueoCajaSumaryxCajero.FormCreate(Sender: TObject);
begin
    fTiposCliente := nil;
    fTiposCliente := TTIposCliente.CreateFromDatabase(MyBD,DATOS_TIPOS_DE_CLIENTE,'WHERE VIGENTE = ''S'' ORDER BY TIPOCLIENTE_ID');
    fTiposCliente.Open;
end;

procedure TFArqueoCajaSumaryxCajero.FormDestroy(Sender: TObject);
begin
    if Assigned(fTiposCliente)
    then fTiposCliente.Free;
end;

procedure TFArqueoCajaSumaryxCajero.QRImprimirIntervalosNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
    if not fTiposCliente.Eof
    then begin
        DoIt;
        fTiposCliente.Next;
        MoreData := TRUE;
    end
    else MoreData := FALSE;
end;


procedure TFArqueoCajaSumaryxCajero.ExportaAscii(const cFechaIni, cFechaFin, cTipoPago, aTipoCliente:  string);
var
    aExportFilter : TQRAsciiExportFilter;
begin
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);
    LTipoPago.Caption := Format('TIPO DE PAGO: %S',[UpperCase(cTipoPago)]);
    if aTipoCliente = FACTURAS_CON_DESCUENTO then
    begin
      LTipoPago.Caption := 'TIPO DE PAGO: GLOBAL';
    end;
    if SD.Execute
    then begin
        aExportFilter := TQRAsciiExportFilter.Create(SD.FileName);
        try
            QRImprimirIntervalos.ExportToFilter(aExportFilter);
        finally
            aExportFilter.Free;
        end;
    end;


end;








end.
