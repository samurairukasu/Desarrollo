unit UARQUEOCAJASUMARYPRINT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ExtCtrls, SQLEXPR, quickrpt, Qrctrls, USAGCLASSES, variants,
  qrexport;

type
  TFArqueoCajaSumary = class(TForm)
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    QRImprimirIntervalos: TQuickRep;
    QRLabel1: TQRLabel;
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
    QRPorCajero: TQuickRep;
    QRBand5: TQRBand;
    QRBand6: TQRBand;
    QRBand7: TQRBand;
    QRBand8: TQRBand;
    dbtINeto: TQRDBText;
    dbtIva: TQRDBText;
    dbtIvan: TQRDBText;
    dbtTot: TQRDBText;
    QRLTitulo: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    DBTCajero: TQRDBText;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRLabel15: TQRLabel;
    QRLblIntervaloFechas2: TQRLabel;
    LTipoPago2: TQRLabel;
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
  FArqueoCajaSumary: TFArqueoCajaSumary;

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

procedure TFArqueoCajaSumary.Execute(const cFechaIni, cFechaFin, cTipoPago, aTipoCliente:  string);
var fTiposCliente: TTiposCliente;
begin
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);
    QRLblIntervaloFechas2.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);
    LTipoPago.Caption := Format('TIPO DE PAGO: %S',[UpperCase(cTipoPago)]);
    LTipoPago2.Caption := Format('TIPO DE PAGO: %S',[UpperCase(cTipoPago)]);
    if aTipoCliente = FACTURAS_CON_DESCUENTO then
    begin
      LTipoPago.Caption := 'TIPO DE PAGO: GLOBAL';
      LTipoPago2.Caption := 'TIPO DE PAGO: GLOBAL';
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

procedure TFArqueoCajaSumary.Doit;
var
    ArrayVar: Variant;
begin
    LTCliente.Caption := fTiposCliente.ValueByName[FIELD_DESCRIPCION];
    ArrayVar:=VarArrayCreate([0,0],VarVariant);
    ArrayVar[0]:=fTiposCliente.ValueByName[FIELD_DESCRIPCION];
    if ListadoDescuento <> 'D' then
    begin
      LFacturas.Caption := fTiposCliente.ExecuteFunction('NFACTURAS_CAJ',ArrayVar);
      LNotas.Caption := fTiposCliente.ExecuteFunction('NNotas_caj',ArrayVar);
    end
    else
    begin
      LFacturas.Caption := fTiposCliente.ExecuteFunction('NFacturasDesc',ArrayVar);
      LNotas.Caption := fTiposCliente.ExecuteFunction('NNotasDesc',ArrayVar);
    end;
    with TSQLQuery.Create(self) do
    try
        SQLConnection := fTiposCliente.Database;
        if ListadoDescuento <> 'D' then                                       
          SQL.Add (Format ('SELECT NVL(SUM(IMPORTE),0) INETO, NVL(SUM(IVA),0) IVA, NVL(SUM(IVANOINSCRIPTO),0) IVAN, NVL(SUM(TOTAL),0) TOT FROM TTMPARQCAJAEXTENCAJ WHERE TIPOCLIENTE = ''%S''',[fTiposCliente.ValueByName[FIELD_DESCRIPCION]]))
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


procedure TFArqueoCajaSumary.FormCreate(Sender: TObject);
begin
    fTiposCliente := nil;
    fTiposCliente := TTIposCliente.CreateFromDatabase(MyBD,DATOS_TIPOS_DE_CLIENTE,'WHERE VIGENTE = ''S'' ORDER BY TIPOCLIENTE_ID');
    fTiposCliente.Open;
end;

procedure TFArqueoCajaSumary.FormDestroy(Sender: TObject);
begin
    if Assigned(fTiposCliente)
    then fTiposCliente.Free;
end;

procedure TFArqueoCajaSumary.QRImprimirIntervalosNeedData(Sender: TObject;
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


procedure TFArqueoCajaSumary.ExportaAscii(const cFechaIni, cFechaFin, cTipoPago, aTipoCliente:  string);
var
    aExportFilter : TQRAsciiExportFilter;
begin
    QRLblIntervaloFechas.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);
    QRLblIntervaloFechas2.Caption := Format('Desde: %s, Hasta: %s',[Copy(cFechaIni,1,10),Copy(cFechaFin,1,10)]);
    LTipoPago.Caption := Format('TIPO DE PAGO: %S',[UpperCase(cTipoPago)]);
    LTipoPago2.Caption := Format('TIPO DE PAGO: %S',[UpperCase(cTipoPago)]);
    if aTipoCliente = FACTURAS_CON_DESCUENTO then
    begin
      LTipoPago.Caption := 'TIPO DE PAGO: GLOBAL';
      LTipoPago2.Caption := 'TIPO DE PAGO: GLOBAL';
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
