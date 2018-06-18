unit uInformeGNC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ExtCtrls, StdCtrls,UCDialgs,
  USAGCLASSES, USAGPRINTERS,
  quickrpt, Qrctrls, Db, SQLEXPR;

type
  TfrmInformeGNC = class(TForm)
    QRInforme: TQuickRep;
    QRBand1: TQRBand;
    TitleBand1: TQRBand;
    lblCuit: TQRLabel;
    lblRSocial: TQRLabel;
    lblDireccion: TQRLabel;
    lblFechaHab: TQRLabel;
    lblFechaVen: TQRLabel;
    lblObleaA: TQRLabel;
    lblObleaN: TQRLabel;
    lblMarca: TQRLabel;
    lblModelo: TQRLabel;
    lblAno: TQRLabel;
    lblDominio: TQRLabel;
    lblInyeccionS: TQRLabel;
    lblInyeccionN: TQRLabel;
    lblTaxi: TQRLabel;                                                                        
    lblPick: TQRLabel;
    lblPart: TQRLabel;
    lblBus: TQRLabel;
    lblOperacion: TQRLabel;
    lblTitular: TQRLabel;
    lblDomicilio: TQRLabel;
    lblLocalidad: TQRLabel;
    lblProvincia: TQRLabel;
    lblTelefono: TQRLabel;
    LblNumeroDoc: TQRLabel;
    lblCpa: TQRLabel;
    lblCodRegulador: TQRLabel;
    lblNroRegulador: TQRLabel;
    lblRegN: TQRLabel;
    lblRegU: TQRLabel;
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
    lblCodTaller: TQRLabel;
    lblOficial: TQRLabel;
    lblOtros: TQRLabel;
    LblXNumero: TQRLabel;
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
    lblRTecnico: TQRLabel;
    QRBand2: TQRBand;
    LblXEjemplarPara: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
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
    QRLabel57: TQRLabel;
    QRLabel58: TQRLabel;
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
    QRLabel74: TQRLabel;
    QRLabel75: TQRLabel;
    QRLabel76: TQRLabel;
    QRLabel77: TQRLabel;
    QRLabel78: TQRLabel;
    QRLabel79: TQRLabel;
    QRLabel80: TQRLabel;
    QRLabel81: TQRLabel;
    QRLabel82: TQRLabel;
    QRLabel83: TQRLabel;
    QRLabel84: TQRLabel;
    QRLabel85: TQRLabel;
    QRLabel86: TQRLabel;
    QRLabel87: TQRLabel;
    QRLabel88: TQRLabel;
    QRLabel89: TQRLabel;
    QRLabel90: TQRLabel;
    QRLabel91: TQRLabel;
    QRLabel92: TQRLabel;
    QRLabel93: TQRLabel;
    QRLabel94: TQRLabel;
    QRLabel95: TQRLabel;
    QRLabel96: TQRLabel;
    QRLabel97: TQRLabel;
    QRLabel98: TQRLabel;
    QRLabel99: TQRLabel;
    QRLabel100: TQRLabel;
    QRLabel101: TQRLabel;
    QRLabel102: TQRLabel;
    QRLabel103: TQRLabel;
    QRLabel104: TQRLabel;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRLabel105: TQRLabel;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRShape23: TQRShape;
    QRShape24: TQRShape;
    QRShape25: TQRShape;
    QRShape26: TQRShape;
    QRShape27: TQRShape;
    QRShape28: TQRShape;
    QRShape30: TQRShape;
    QRShape31: TQRShape;
    QRShape32: TQRShape;
    QRShape33: TQRShape;
    QRShape34: TQRShape;
    QRShape29: TQRShape;
    QRShape35: TQRShape;
    QRShape36: TQRShape;
    QRShape37: TQRShape;
    QRShape38: TQRShape;
    QRShape39: TQRShape;
    QRShape40: TQRShape;
    QRShape41: TQRShape;
    QRShape42: TQRShape;
    QRShape43: TQRShape;
    QRShape44: TQRShape;
    QRShape45: TQRShape;
    QRShape46: TQRShape;
    QRShape47: TQRShape;
    QRShape48: TQRShape;
    QRShape49: TQRShape;
    QRShape50: TQRShape;
    QRShape51: TQRShape;
    QRShape52: TQRShape;
    QRShape53: TQRShape;
    QRShape54: TQRShape;
    QRShape55: TQRShape;
    QRShape57: TQRShape;
    QRShape58: TQRShape;
    QRShape56: TQRShape;
    QRShape59: TQRShape;
    QRShape60: TQRShape;
    QRShape61: TQRShape;
    QRShape62: TQRShape;
    QRShape63: TQRShape;
    QRShape64: TQRShape;
    QRShape65: TQRShape;
    QRShape66: TQRShape;
    QRShape67: TQRShape;
    QRShape68: TQRShape;
    QRShape69: TQRShape;
    QRShape70: TQRShape;
    QRShape71: TQRShape;
    QRShape72: TQRShape;
    QRShape73: TQRShape;
    QRShape74: TQRShape;
    QRShape75: TQRShape;
    QRShape76: TQRShape;
    QRShape77: TQRShape;
    QRShape78: TQRShape;
    QRShape79: TQRShape;
    QRShape80: TQRShape;
    QRShape81: TQRShape;
    QRShape82: TQRShape;
    QRShape83: TQRShape;
    QRShape84: TQRShape;
    QRShape85: TQRShape;
    QRShape86: TQRShape;
    QRShape87: TQRShape;
    QRShape88: TQRShape;
    QRShape89: TQRShape;
    QRShape90: TQRShape;
    lblRTecnico2: TQRLabel;
    lblRTecnico3: TQRLabel;
    lblNroCalle: TQRLabel;
    lblDepto: TQRLabel;
    procedure QRInformePreview(Sender: TObject);
    procedure QRInformeNeedData(Sender: TObject; var MoreData: Boolean);
    procedure QRInformeAfterPreview(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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
    procedure Rellenar_Ficha;
    procedure ActivarDesactivar_Componentes (const bActivar: boolean);
    procedure TipoVehiculo( aTipoVeh : integer);
    procedure setTipoOperacion(aTipoOperacion : char);
    function SetTipoOpCilindro(aTipoOperacion : char):char;
  public
    { Public declarations }
    property ImprimirInformeGNC: boolean read GetImprimirInformeInspeccion write SetImprimirInformeInspeccion;
    constructor CreateFromInspeccion (const aInspec: TInspGNC; bEsOrig: integer; const bPresPreliminar: boolean; aContexto: pTContexto);
    constructor CreateFromEjercicioAndCode (const aEjercicio, aCode : integer; bEsOrig: integer; const bPresPreliminar: boolean; aContexto: pTContexto);
  end;

var
  frmInformeGNC: TfrmInformeGNC;



implementation

uses
   UFPRESPRELIMINAR,
   USAGESTACION,
   USAGCLASIFICACION,
   QrPrntr,
   Globals,
   Printers, uUtils;

{$R *.DFM}

resourcestring
      FICHERO_ACTUAL = 'UInformeGNC';


var
  frmPresPreliminar_Auxi: TfrmPresPreliminar;

const
  TO_CONVERSION = 'C';
  TO_MODIFICACION = 'M';
  TO_REVISION_ANUAL = 'R';
  TO_DESMONTAJE = 'D';
  TO_BAJA = 'B';
  ORIGINAL = 'ORIGINAL';
  DUPLICADO = 'DUPLICADO';
  TRIPLICADO = 'TRIPLICADO';


procedure TfrmInformeGNC.QRInformePreview(Sender: TObject);
begin
   frmPresPreliminar_Auxi := TfrmPresPreliminar.Create (Application);
   frmPresPreliminar_Auxi.QRPrevPresPrel.QRPrinter := TQRPrinter (Sender);
   frmPresPreliminar_Auxi.Show;
end;

constructor TfrmInformeGNC.CreateFromEjercicioAndCode (const aEjercicio, aCode : integer; bEsOrig: integer; const bPresPreliminar: boolean; aContexto: pTContexto);
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
        'SELECT TO_CHAR(I.FECHVENCI, ''DD/MM/YYYY'') VENCIMIENTO, I.CODVEHIC, I.CODCLIEN,  ' +
        '       MOD(I.EJERCICI,100) || '' '' || LTRIM(TO_CHAR(R.ZONA,''0000'')) || LTRIM(TO_CHAR(R.ESTACION,''0000'')) || LTRIM(TO_CHAR(I.CODINSPGNC,''000000'')) INFORME, ' +
//        '       SUBSTR(LTRIM(TO_CHAR(TO_NUMBER(NVL(I.OBLEANUEVA,0)),''00000000'')),1,1) || ''.'' || SUBSTR(LTRIM(TO_CHAR(TO_NUMBER(NVL(I.OBLEANUEVA,0)),''00000000'')),2,3)|| ''.'' || SUBSTR(LTRIM(TO_CHAR(TO_NUMBER(NVL(I.OBLEANUEVA,0)),''00000000'')),5,3) OBLEAN, ' +
//        '       SUBSTR(LTRIM(TO_CHAR(TO_NUMBER(NVL(I.OBLEAANT,0)),''00000000'')),1,1) || ''.'' || SUBSTR(LTRIM(TO_CHAR(TO_NUMBER(NVL(I.OBLEAANT,0)),''00000000'')),2,3)|| ''.'' || SUBSTR(LTRIM(TO_CHAR(TO_NUMBER(NVL(I.OBLEAANT,0)),''00000000'')),5,3) OBLEAA, ' +
        '       I.OBLEANUEVA OBLEAN, ' +
        '       I.OBLEAANT OBLEAA, ' +
        '       I.FECHALTA, I.CODEQUIGNC, I.TIPOOPERACION ' +
        'FROM  INSPGNC I, TVARIOS R  ' +
        'WHERE I.EJERCICI = %D AND I.CODINSPGNC = %D',[fEjercicio, fCodigo]));
    fConsulta.Open;

    Rellenar_Ficha;

    case bEsOrig of
      1:begin
             LblXEjemplarPara.Caption := ORIGINAL
      end;
      2:begin
             LblXEjemplarPara.Caption := DUPLICADO
      end;
      3:begin
             LblXEjemplarPara.Caption := TRIPLICADO
      end;
    end;

    if bPresPreliminar then
    begin
        ActivarDesactivar_Componentes (True);
        QRInforme.Page.Orientation := poPortrait;
        QRInforme.Preview
    end
    else
    begin
        ActivarDesactivar_Componentes (False);
        QRInforme.Page.Orientation := poPortrait;

        if (aContexto <> nil) then
        begin
            QRInforme.PrinterSettings.PrinterIndex:=Printer.Printers.IndexOf(aContexto^.sNombre);
            QRInforme.Printersettings.OutputBin := aContexto^.qrbBandeja;
            QRInforme.Page.PaperSize := aContexto^.qrpPapel;
            QRInforme.PrinterSettings.Orientation := aContexto^.qroOrientacion;
            QRInforme.Page.LeftMargin := aContexto^.iMargenIzquierdo;
            QRInforme.Page.TopMargin := aContexto^.iMargenSuperior;
        end;
        QRInforme.Print;
    end;
end;

constructor TfrmInformeGNC.CreateFromInspeccion (const aInspec: TInspGNC; bEsOrig: integer; const bPresPreliminar: boolean; aContexto: pTContexto);
begin
    inherited Create (Application);
    fConsulta := nil;

    fInspeccion := aInspec;
    fInspeccion.Open;
    fEjercicio := StrToInt(fInspeccion.ValueByName[FIELD_EJERCICI]);
    fCodigo := StrToInt(fInspeccion.ValueByName[FIELD_CODINSPGNC]);

    Rellenar_Ficha;

    if bPresPreliminar then
    begin
        ActivarDesactivar_Componentes (True);
        QRInforme.Page.Orientation := poPortrait;
        QRInforme.Preview
    end
    else
    begin
        ActivarDesactivar_Componentes (False);
        QRInforme.Page.Orientation := poPortrait;

        if (aContexto <> nil) then
        begin
            QRInforme.PrinterSettings.PrinterIndex:=Printer.Printers.IndexOf(aContexto^.sNombre);
            QRInforme.Printersettings.OutputBin := aContexto^.qrbBandeja;
            QRInforme.Page.PaperSize := aContexto^.qrpPapel;
            QRInforme.PrinterSettings.Orientation := aContexto^.qroOrientacion;
            QRInforme.Page.LeftMargin := aContexto^.iMargenIzquierdo;
            QRInforme.Page.TopMargin := aContexto^.iMargenSuperior;
        end;
        QRInforme.Print;
    end;
end;


procedure TfrmInformeGNC.Rellenar_Ficha;
var
    aCodigoVehiculo : string;
    aCodigoPropietario : string;
    fDatos_estacion : tDatos_Estacion;
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
    fDatos_estacion := nil;
    try
      if Assigned(fInspeccion)
      then begin
        aCodigoVehiculo := fInspeccion.ValueByName[FIELD_CODVEHIC];
        aCodigoPropietario := fInspeccion.ValueByName[FIELD_CODCLIEN];
        fEquipo := TEquiposGNC.CreateByCodequi(MyBD,fInspeccion.ValueByName[FIELD_CODEQUIGNC]);
      end
      else begin
        aCodigoVehiculo := fConsulta.FieldByName(FIELD_CODVEHIC).AsString;
        aCodigoPropietario := fConsulta.FieldByName(FIELD_CODCLIEN).AsString;
        fEquipo := TEquiposGNC.CreateByCodequi(MyBD,fConsulta.FieldByName(FIELD_CODEQUIGNC).AsString);
      end;

      fDatos_estacion := tDatos_Estacion.create(mybd);
      fDatos_estacion.Open;

      lblRSocial.Caption := fVarios.ValueByName[FIELD_RSOCIAL];
      lblDireccion.caption := fdatos_estacion.valuebyname[FIELD_CALLECOM];
      LblCuit.Caption := fDatos_estacion.ValueByName[FIELD_CUIT];
      lblCodTaller.Caption := fVarios.ValueByName[FIELD_CODTALLER];
      lblRTecnico.Caption := fVarios.ValueByName[FIELD_RTECNICO]+' /Mat. Nº '+fVarios.ValueByName[FIELD_MATRICULART];
      lblRTecnico2.Caption := fVarios.ValueByName[FIELD_RTECNICO]+' /Mat. Nº '+fVarios.ValueByName[FIELD_MATRICULART];
      lblRTecnico3.Caption := fVarios.ValueByName[FIELD_RTECNICO]+' /Mat. Nº '+fVarios.ValueByName[FIELD_MATRICULART];

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
//      lblTaller.Caption := fvarios.ValueByName[FIELD_CODTALLER];
//      lblOperacion.Caption := 'Revisión Anual';    //  fInspeccion.ValueByName[FIELD_TIPOOPERACION];

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
               if (Self.Components[i].Tag = contcilindros+120) then
               begin
                       cualtag := contcilindros+120;
                       TQRLabel(Self.Components[i]).caption := GetCodEnargas
               end else
               if (Self.Components[i].Tag = contcilindros+130) then
               begin
                       cualtag := contcilindros+130;
                       TQRLabel(Self.Components[i]).caption := ValueByName[FIELD_NROSERIE]
               end else
               if (Self.Components[i].Tag = contcilindros+140) then
               begin
                       cualtag := contcilindros+140;
                       if ValueByName[FIELD_NUEVO] = 'S' then
                         TQRLabel(Self.Components[i]).caption := 'X'
                       else
                         TQRLabel(Self.Components[i]).caption := '';

               end else
               if (Self.Components[i].Tag = contcilindros+150) then
               begin
                       cualtag := contcilindros+150;
                       if ValueByName[FIELD_NUEVO] = 'N' then
                         TQRLabel(Self.Components[i]).caption := 'X'
                       else
                         TQRLabel(Self.Components[i]).caption := '';
               end else
               if (Self.Components[i].Tag = contcilindros+160) then
               begin
                       cualtag := contcilindros+160;
                       TQRLabel(Self.Components[i]).caption := copy(ValueByName[FIELD_FECHFABRI],4,7);
               end
               else if (Self.Components[i].Tag = contcilindros+170) then
               begin
                       cualtag := contcilindros+170;
                       TQRLabel(Self.Components[i]).caption := copy(ValueByName[FIELD_FECHREVI],4,7);;
               end
               else if (Self.Components[i].Tag = contcilindros+180) then
               begin
                       cualtag := contcilindros+180;
                       TQRLabel(Self.Components[i]).caption := GetCRPC;
               end
               else if (Self.Components[i].Tag = contcilindros+190) then
               begin
                       cualtag := contcilindros+190;
                       if Assigned(fInspeccion)
                       then begin
                            TQRLabel(Self.Components[i]).caption := SetTipoOpCilindro(fInspeccion.ValueByName[FIELD_TIPOOPERACION][1]);
                       end
                       else begin
                            TQRLabel(Self.Components[i]).caption := SetTipoOpCilindro(fConsulta.FieldByName('TIPOOPERACION').AsString[1]);
                       end;
               end
               else if (Self.Components[i].Tag = contcilindros+200) then
               begin
                       cualtag := contcilindros+200;
                       TQRLabel(Self.Components[i]).caption := GetCodValvEnargas;
               end               else if (Self.Components[i].Tag = contcilindros+210) then
               begin
                       cualtag := contcilindros+210;
                       TQRLabel(Self.Components[i]).caption := copy(ValueByName[FIELD_NROSERIEVALV],4,7);;
               end




          end;
          inc(contcilindros);
          next;
        end;
      end;


      with TSQLQuery.Create(self) do
      try
        SQLConnection := fVarios.Database;

        { TODO -oran -ctransacciones : ver tema session }

        SQL.Add (Format(
                   ' SELECT NVL(PATENTEN, PATENTEA) PATENTE, (NOMBRE || '' '' || APELLID1 || '' '' || APELLID2) NOMBREC, (TIPODOCU ||'' '' || DOCUMENT) DOCUMENTO, ' +
                   ' GETMARCA(CODVEHIC) MARCA, GETMODELO(CODVEHIC) MODELO, INYECCION, ANIOFABR, CODPOSTA, LOCALIDA, DIRECCIO, TELEFONO, getipvehgnc(TIPOESPE,TIPODEST) TIPOVEH, '+
                   ' GETPROVINCIA(CODPARTI) PROVINCIA, NROCALLE, PISO||'' ''||DEPTO DEPTO '+
                   ' FROM TCLIENTES, TVEHICULOS WHERE CODCLIEN = %S AND CODVEHIC = %S ', [aCodigoPropietario, aCodigoVehiculo]));

        Open;
        LblNumeroDoc.Caption := FieldByName('DOCUMENTO').AsString;
        LblTitular.Caption := FieldByName('NOMBREC').AsString;
        LblDominio.Caption := FieldByName('PATENTE').AsString;
        lblMarca.Caption := fieldbyName('MARCA').asString;
        lblModelo.Caption := fieldbyName('MODELO').asstring;
        lblAno.Caption := FieldByName('ANIOFABR').asString;
        lblCPA.Caption := FieldByName('CODPOSTA').AsString;
        lblDomicilio.Caption := FieldByName('DIRECCIO').AsString;
        lblNroCalle.Caption := FieldByName('NROCALLE').AsString;
        lblDepto.Caption := FieldByName('DEPTO').AsString;
        lblLocalidad.Caption := FieldByName('LOCALIDA').AsString;
        lblTelefono.Caption := FieldByName('TELEFONO').AsString;
        lblProvincia.Caption := FieldByName('PROVINCIA').AsString;

        TipoVehiculo(FieldByName('TIPOVEH').asInteger);
        if  FieldByName('INYECCION').AsString = 'S' then
        begin
          lblInyeccionS.enabled := true;
          lblInyeccionN.enabled := false;
        end
        else
        begin
          lblInyeccionS.enabled := false;
          lblInyeccionN.enabled := true;
        end;

        if Assigned(fInspeccion)
        then begin
          LblXNumero.Caption := fInspeccion.Informe;
          lblFechaHab.caption := fInspeccion.ValueByName[FIELD_FECHALTA];
          lblFechaVen.Caption := fInspeccion.ValueByName[FIELD_FECHVENCI];
          lblObleaA.Caption := fInspeccion.ValueByName[FIELD_OBLEAANT];
          lblObleaN.Caption := fInspeccion.ValueByName[FIELD_OBLEANUEVA];
          setTipoOperacion(fInspeccion.ValueByName[FIELD_TIPOOPERACION][1]);
        end
        else begin
          LblXNumero.Caption := fConsulta.FieldByName('INFORME').AsString;
          lblFechaHab.Caption :=  FormatDateTime('dd/mm/yyyy',StrToDateTime(fConsulta.FieldByName(FIELD_FECHALTA).AsString));
          lblFechaVen.Caption := fConsulta.FieldByName('VENCIMIENTO').AsString;
          lblObleaA.Caption := fConsulta.FieldByName('OBLEAA').AsString;
          lblObleaN.Caption := fConsulta.FieldByName('OBLEAN').AsString;
          setTipoOperacion(fConsulta.FieldByName('TIPOOPERACION').AsString[1]);
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
      fDatos_estacion.Free;
    end;
end;

procedure TfrmInformeGNC.QRInformeNeedData(Sender: TObject;
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

function TfrmInformeGNC.GetImprimirInformeInspeccion: boolean;
begin
    Result := fImprimirInformeInspeccion;
end;

procedure TfrmInformeGNC.SetImprimirInformeInspeccion (const bImprimir: boolean);
begin
    fImprimirInformeInspeccion := bImprimir;
end;


procedure TfrmInformeGNC.ActivarDesactivar_Componentes (const bActivar: boolean);
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

procedure TfrmInformeGNC.QRInformeAfterPreview(Sender: TObject);
begin
    ImprimirInformeGNC := (frmPresPreliminar_Auxi.ModalResult = mrOk);
end;

procedure TfrmInformeGNC.FormDestroy(Sender: TObject);
begin
    if Assigned(fConsulta)
    then begin
        fConsulta.Close;
        fConsulta.Free;
    end;
end;

procedure TfrmInformeGNC.TipoVehiculo( aTipoVeh : integer);
begin
  case aTipoVeh of
    1:begin
      ActivarComponentes(true,self,[4]);
      ActivarComponentes(false,self,[5,6,7,8,9]);
    end;
    2:begin
      ActivarComponentes(true,self,[5]);
      ActivarComponentes(false,self,[4,6,7,8,9]);
    end;
    3:begin
      ActivarComponentes(true,self,[6]);
      ActivarComponentes(false,self,[5,4,7,8,9]);
    end;
    4:begin
      ActivarComponentes(true,self,[7]);
      ActivarComponentes(false,self,[5,6,4,8,9]);
    end;
    5:begin
      ActivarComponentes(true,self,[8]);
      ActivarComponentes(false,self,[5,6,7,4,9]);
    end;
    6:begin
      ActivarComponentes(true,self,[9]);
      ActivarComponentes(false,self,[5,6,7,8,4]);
    end;
  end;

end;

procedure TfrmInformeGNC.setTipoOperacion(aTipoOperacion : char);
begin
  case aTipoOperacion of
    TO_CONVERSION : begin
      ActivarComponentes(true,self,[10]);
      ActivarComponentes(false,self,[11,12,13,14]);
    end;
    TO_MODIFICACION : begin
      ActivarComponentes(true,self,[11]);
      ActivarComponentes(false,self,[10,12,13,14]);
    end;
    TO_REVISION_ANUAL : begin
      ActivarComponentes(true,self,[12]);
      ActivarComponentes(false,self,[11,10,13,14]);
    end;
    TO_DESMONTAJE : begin
      ActivarComponentes(true,self,[13]);
      ActivarComponentes(false,self,[11,12,10,14]);
    end;
    TO_BAJA : begin
      ActivarComponentes(true,self,[14]);
      ActivarComponentes(false,self,[11,12,13,10]);
    end;
  end;
end;

function TfrmInformeGNC.setTipoOpCilindro(aTipoOperacion : char):char;
begin
  case aTipoOperacion of
    TO_CONVERSION : begin
      result := 'M'
    end;
    TO_MODIFICACION : begin
      result := 'M'
    end;
    TO_REVISION_ANUAL : begin
      result := 'S'
    end;
    TO_DESMONTAJE : begin
      result := 'D'
    end;
    TO_BAJA : begin
      result := 'B'
    end;
  end;
end;

end.
