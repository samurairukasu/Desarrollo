unit ufTAmarilla;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ExtCtrls, StdCtrls,UCDialgs,
  USAGCLASSES, USAGPRINTERS,
  quickrpt, Qrctrls, Db, SQLEXPR;

type
  TFrmTAmarilla = class(TForm)
    QRCertificado: TQuickRep;
    QRBand1: TQRBand;
    TitleBand1: TQRBand;
    lblDominio: TQRLabel;
    lblNumero: TQRLabel;
    LblNumeroOblea: TQRLabel;
    lblMarca: TQRLabel;
    LblFechaVencimiento: TQRLabel;
    lblCodregulador: TQRLabel;
    lblNroRegulador: TQRLabel;
    lblRegU: TQRLabel;
    lblRegN: TQRLabel;
    lblOperacion: TQRLabel;
    lblTaller: TQRLabel;
    QRLabel1: TQRLabel;
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
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
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
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel42: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel44: TQRLabel;
    QRLabel45: TQRLabel;
    QRLabel46: TQRLabel;
    QRLabel47: TQRLabel;
    QRLabel48: TQRLabel;
    QRLabel49: TQRLabel;
    QRLabel50: TQRLabel;
    QRLabel51: TQRLabel;
    QRLabel52: TQRLabel;
    QRLabel53: TQRLabel;
    QRLabel54: TQRLabel;
    QRLabel55: TQRLabel;
    QRLabel56: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRLabel57: TQRLabel;
    QRLabel58: TQRLabel;
    QRLabel59: TQRLabel;
    qrlDomicilio: TQRLabel;
    qrlLugarFecha: TQRLabel;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    qrlRTecnico: TQRLabel;
    procedure QRCertificadoPreview(Sender: TObject);
    procedure QRCertificadoNeedData(Sender: TObject; var MoreData: Boolean);
    procedure QRCertificadoAfterPreview(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure QRCertificadoBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    bCertificadoRelleno: boolean;
    fImprimirInformeInspeccion: boolean; // True si el usuario ha pulsado "Imprimir"
    fInspeccion: TInspGNC;
    fEjercicio: integer;
    fCodigo: integer;
    fConsulta: TSQLQuery;
    function GetImprimirInformeInspeccion: boolean;
    procedure SetImprimirInformeInspeccion (const bImprimir: boolean);
    procedure Rellenar_Certificado;
    procedure ActivarDesactivar_Componentes (const bActivar: boolean);

  public
    { Public declarations }
    property ImprimirCertificado: boolean read GetImprimirInformeInspeccion write SetImprimirInformeInspeccion;
    constructor CreateFromCertificado (const aInspec: TInspGNC; const bPresPreliminar: boolean; aContexto: pTContexto);
    constructor CreateFromEjercicioAndCode (const aEjercicio, aCode : integer; const bPresPreliminar: boolean; aContexto: pTContexto);
  end;

var
  FrmTAmarilla: TFrmTAmarilla;



implementation

uses
   UFPRESPRELIMINAR,
   USAGESTACION,
   USAGCLASIFICACION,
   QrPrntr,
   Globals,
   Printers;

{$R *.DFM}

resourcestring
      FICHERO_ACTUAL = 'UfTAmarilla';


var
  frmPresPreliminar_Auxi: TfrmPresPreliminar;


procedure TFrmTAmarilla.QRCertificadoPreview(Sender: TObject);
begin
   frmPresPreliminar_Auxi := TfrmPresPreliminar.Create (Application);
   frmPresPreliminar_Auxi.QRPrevPresPrel.QRPrinter := TQRPrinter (Sender);
   frmPresPreliminar_Auxi.Show;
end;

constructor TFrmTAmarilla.CreateFromEjercicioAndCode (const aEjercicio, aCode : integer; const bPresPreliminar: boolean; aContexto: pTContexto);
begin
    inherited Create (Application);
    fInspeccion := nil;
    fEjercicio := aEjercicio;
    fCodigo := aCode;
    fConsulta := TSQLQuery.Create(self);
    fConsulta.SQLConnection := fVarios.DataBase;

    { TODO -oran -ctransacciones : ver tema session }

    fConsulta.SQL.Add
    (Format(
        'SELECT TO_CHAR(I.FECHVENCI, ''DD/MM/YYYY'') VENCIMIENTO, I.CODVEHIC, I.CODCLIEN, ' +
//        '       SUBSTR(LTRIM(TO_CHAR(TO_NUMBER(NVL(I.OBLEANUEVA,0)),''00000000'')),1,1) || ''.'' || SUBSTR(LTRIM(TO_CHAR(TO_NUMBER(NVL(I.OBLEANUEVA,0)),''00000000'')),2,3)|| ''.'' || SUBSTR(LTRIM(TO_CHAR(TO_NUMBER(NVL(I.OBLEANUEVA,0)),''00000000'')),5,3) OBLEA, ' +
        '       I.OBLEANUEVA OBLEA, ' +
        '       I.FECHALTA, I.CODEQUIGNC ' +
        'FROM  INSPGNC I, TVARIOS R                                                                                                                                                                                     ' +
        'WHERE I.EJERCICI = %D AND I.CODINSPGNC = %D',[fEjercicio, fCodigo]));
    fConsulta.Open;

    Rellenar_Certificado;

    if bPresPreliminar then
    begin
        ActivarDesactivar_Componentes (True);
        QRCertificado.Page.Orientation := poPortrait;
        QRCertificado.Preview
    end
    else
    begin
        ActivarDesactivar_Componentes (False);
        QRCertificado.Page.Orientation := poLandscape;

        if (aContexto <> nil) then
        begin
            QRCertificado.PrinterSettings.PrinterIndex:=Printer.Printers.IndexOf(aContexto^.sNombre);
            QRCertificado.Printersettings.OutputBin := aContexto^.qrbBandeja;
            QRCertificado.Page.PaperSize := aContexto^.qrpPapel;
            QRCertificado.PrinterSettings.Orientation := aContexto^.qroOrientacion;
            QRCertificado.Page.LeftMargin := aContexto^.iMargenIzquierdo;
            QRCertificado.Page.TopMargin := aContexto^.iMargenSuperior;
        end;
        QRCertificado.Print;
    end;
end;

constructor TFrmTAmarilla.CreateFromCertificado (const aInspec: TInspGNC; const bPresPreliminar: boolean; aContexto: pTContexto);
begin
    inherited Create (Application);
    fConsulta := nil;

    fInspeccion := aInspec;
    fInspeccion.Open;
    fEjercicio := StrToInt(fInspeccion.ValueByName[FIELD_EJERCICI]);
    fCodigo := StrToInt(fInspeccion.ValueByName[FIELD_CODINSPGNC]);

    Rellenar_Certificado;

    if bPresPreliminar then
    begin
        ActivarDesactivar_Componentes (True);
        QRCertificado.Page.Orientation := poPortrait;
        QRCertificado.Preview
    end
    else
    begin
        ActivarDesactivar_Componentes (False);
        QRCertificado.Page.Orientation := poLandscape;

        if (aContexto <> nil) then
        begin
            QRCertificado.PrinterSettings.PrinterIndex:=Printer.Printers.IndexOf(aContexto^.sNombre);
            QRCertificado.Printersettings.OutputBin := aContexto^.qrbBandeja;
            QRCertificado.Page.PaperSize := aContexto^.qrpPapel;
            QRCertificado.PrinterSettings.Orientation := aContexto^.qroOrientacion;
            QRCertificado.Page.LeftMargin := aContexto^.iMargenIzquierdo;
            QRCertificado.Page.TopMargin := aContexto^.iMargenSuperior;
        end;
        QRCertificado.Print;
    end;
end;


procedure TFrmTAmarilla.Rellenar_Certificado;
var
    aCodigoVehiculo : string;
    aCodigoPropietario : string;
    fEquipo : TEquiposGNC;
    fRegulador : TReguladores;
    fRegEG : TReguladoresEnargas;
    fEqui_Cilindro : TequiGNC_Cilindro;
    fCilindros : tCilindros;
    i, contcilindros, cualtag : integer;
begin
    fequipo := nil;
    fRegulador := nil;
    fRegEG := nil;
    fEqui_Cilindro := nil;
    fCilindros := nil;

    try
      if Assigned(fInspeccion)
      then begin
          aCodigoVehiculo := fInspeccion.ValueByName[FIELD_CODVEHIC];
          aCodigoPropietario := fInspeccion.ValueByName[FIELD_CODCLIEN];
          fEquipo := TEquiposGNC.CreateByCodequi(MyBD,fInspeccion.ValueByName[FIELD_CODEQUIGNC]);
          qrlLugarFecha.Caption := FVARIOS.provincia+', '+copy(fInspeccion.ValueByName[FIELD_FECHALTA],1,10);
      end
      else begin
          aCodigoVehiculo := fConsulta.FieldByName(FIELD_CODVEHIC).AsString;
          aCodigoPropietario := fConsulta.FieldByName(FIELD_CODCLIEN).AsString;
          fEquipo := TEquiposGNC.CreateByCodequi(MyBD,fConsulta.FieldByName(FIELD_CODEQUIGNC).AsString);
          qrlLugarFecha.Caption := FVARIOS.provincia+', '+copy(fConsulta.FieldByName(FIELD_FECHALTA).asstring,1,10);
      end;

      fEquipo.Open;
      fRegulador := TReguladores.CreateByCodRegulador(MyBD,fEquipo.valueByName[FIELD_CODREGULADOR]);
      fRegulador.Open;
      fRegEG := TReguladoresEnargas.CreateById(mybd,fRegulador.ValueByName[FIELD_IDREGULADOR]);
      fRegEG.Open;
      lblCodregulador.Caption := fRegEG.ValueByName[FIELD_CODIGO];
      lblNroRegulador.Caption := fRegulador.ValueByName[FIELD_NROSERIE];
      if fRegulador.ValueByName[FIELD_NUEVOREG] = 'S' then
      begin
           lblRegU.Caption := '';
           lblRegN.Caption := 'X';
      end
      else
      begin
           lblRegU.Caption := 'X';
           lblRegN.Caption := '';
      end;
      lblTaller.Caption := fvarios.ValueByName[FIELD_CODTALLER];
      lblOperacion.Caption := 'Revisión Anual';    //  fInspeccion.ValueByName[FIELD_TIPOOPERACION];
      qrlRTecnico.Caption := fVarios.ValueByName[FIELD_RTECNICO];

      qrlDomicilio.Caption := fvarios.ValueByName[FIELD_DIRCONCE]+' '+fVarios.ValueByName[FIELD_LOCALIDA]+' Tel. '+ fVarios.ValueByName[FIELD_TELFCONC];

      fEqui_Cilindro := fEquipo.GetCilindro;
      fEqui_Cilindro.Open;
      fCilindros := fEqui_Cilindro.GetCilindros;
      fCilindros.open;

      fCilindros.First;
      contcilindros := 1;
      with fCilindros do
      begin
        while not eof do
        begin
          for i := 0 to Self.ComponentCount-1 do
          begin
               if (Self.Components[i].Tag = contcilindros+20) then
               begin
                       cualtag := contcilindros+20;
                       TQRLabel(Self.Components[i]).caption := GetCodEnargas
               end else
               if (Self.Components[i].Tag = contcilindros+30) then
               begin
                       cualtag := contcilindros+30;
                       TQRLabel(Self.Components[i]).caption := ValueByName[FIELD_NROSERIE]
               end else
               if (Self.Components[i].Tag = contcilindros+40) then
               begin
                       cualtag := contcilindros+40;
                       if ValueByName[FIELD_NUEVO] = 'S' then
                         TQRLabel(Self.Components[i]).caption := 'X'
                       else
                         TQRLabel(Self.Components[i]).caption := '';

               end else
               if (Self.Components[i].Tag = contcilindros+50) then
               begin
                       cualtag := contcilindros+50;
                       if ValueByName[FIELD_NUEVO] = 'N' then
                         TQRLabel(Self.Components[i]).caption := 'X'
                       else
                         TQRLabel(Self.Components[i]).caption := '';
               end else
               if (Self.Components[i].Tag = contcilindros+60) then
               begin
                       cualtag := contcilindros+60;
                       TQRLabel(Self.Components[i]).caption := copy(ValueByName[FIELD_FECHVENC],4,7);
               end;

          end;
          inc(contcilindros);
          next;
        end;
      end;

      with TSQLQuery.Create(self) do
      try
          SQLConnection := fVarios.Database;

          { TODO -oran -ctransacciones : ver tema session }

          SQL.Add (Format( ' SELECT NVL(PATENTEN, PATENTEA) PATENTE, (TIPODOCU ||'' '' || DOCUMENT) DOCUMENTO, ' +
                   ' GETMARCA_MODELO (CODVEHIC) MARCA '+
                   ' FROM TCLIENTES, TVEHICULOS WHERE CODCLIEN = %S AND CODVEHIC = %S ', [aCodigoPropietario, aCodigoVehiculo]));

          Open;
          LblNumero.Caption := FieldByName('DOCUMENTO').AsString;
          LblMarca.Caption := FieldByName('MARCA').AsString;
          LblDominio.Caption := FieldByName('PATENTE').AsString;


          if Assigned(fInspeccion)
          then begin
             LblFechaVencimiento.Caption := copy(fInspeccion.ValueByName[FIELD_FECHVENCI],4,7);
             LblNumeroOblea.Caption := fInspeccion.GetNumOblea;
          end
          else begin
             LblFechaVencimiento.Caption := copy(fConsulta.FieldByName('VENCIMIENTO').AsString,4,7);
             LblNumeroOblea.Caption := fConsulta.FieldByName('OBLEA').AsString;
          end;
      finally
          Close;
          Free;
      end;
    finally
      fEquipo.Free;
      fRegulador.Free;
      fRegEG.free;
      fEqui_Cilindro.free;
      fCilindros.Free;
    end;
end;

procedure TFrmTAmarilla.QRCertificadoNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
    if bCertificadoRelleno then
       MoreData := False
    else
    begin
        bCertificadoRelleno := True;
        MoreData := True;
    end;
end;

function TFrmTAmarilla.GetImprimirInformeInspeccion: boolean;
begin
    Result := fImprimirInformeInspeccion;
end;

procedure TFrmTAmarilla.SetImprimirInformeInspeccion (const bImprimir: boolean);
begin
    fImprimirInformeInspeccion := bImprimir;
end;


procedure TFrmTAmarilla.ActivarDesactivar_Componentes (const bActivar: boolean);
var
  i: integer;

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
end;

procedure TFrmTAmarilla.QRCertificadoAfterPreview(Sender: TObject);
begin
    ImprimirCertificado := (frmPresPreliminar_Auxi.ModalResult = mrOk);
end;

procedure TFrmTAmarilla.FormDestroy(Sender: TObject);
begin
    if Assigned(fConsulta)
    then begin
        fConsulta.Close;
        fConsulta.Free;
    end;
end;






























































procedure TFrmTAmarilla.QRCertificadoBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
    bCertificadoRelleno := False;
end;

end.
