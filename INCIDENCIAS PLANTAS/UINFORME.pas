unit UINFORME;

interface

uses
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
  sqlExpr, FMTBcd, jpeg, RxGIF;


type
  TFrmFichaInspeccion = class(TForm)
    BandFichaInspeccion: TQRBand;
    QRInformeInspeccion: TQuickRep;
    CabeceraPagina: TQRBand;
    LblXZona: TQRLabel;
    LblXEstacion: TQRLabel;
    LblXNumero: TQRLabel;
    LblXConductor: TQRLabel;
    LblXDocumento: TQRLabel;
    LblXMarca: TQRLabel;
    LblXTipo: TQRLabel;
    LblXModelo: TQRLabel;
    LblXGNC: TQRLabel;
    LblXAnio: TQRLabel;
    LblXTitular: TQRLabel;
    LblXDocumentoTitular: TQRLabel;
    LblXDominio: TQRLabel;
    LblXMotor: TQRLabel;
    LblXChasis: TQRLabel;
    LblXVencimiento: TQRLabel;
    LblXBaja: TQRLabel;
    LblXRechazado: TQRLabel;
    LblXCondicional: TQRLabel;
    LblXApto: TQRLabel;
    LblXMotocicleta: TQRLabel;
    LblXAgricola: TQRLabel;
    LblXVial: TQRLabel;
    LblXEscuela: TQRLabel;
    LblXAlquiler: TQRLabel;
    LblXAmbulancia: TQRLabel;
    LblXCarga: TQRLabel;
    LblXMasDeNueve: TQRLabel;
    LblXPubliNueve: TQRLabel;
    LblXPartiNueve: TQRLabel;
    PieDePagina: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRSysData3: TQRSysData;
    QRMemo1: TQRMemo;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRSysData4: TQRSysData;
    QRMemo2: TQRMemo;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    LblXEjemplarPara: TQRLabel;
    lblXResponsable: TQRLabel;
    QRSysData5: TQRSysData;
    LblXNEstacion: TQRLabel;
    QRMemo3: TQRMemo;
    MemoObservaciones: TQRMemo;
    LblXHoraIngreso: TQRLabel;
    LblXHegr: TQRLabel;
    LblXHTTL: TQRLabel;
    LblXHTTE: TQRLabel;
    LblLeves: TQRLabel;
    LblGraves: TQRLabel;
    QRDBTxtCadDefec: TQRDBText;
    LblDescripcion: TQRLabel;
    LblTipoInspeccion: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel48: TQRLabel;
    QRShape9: TQRShape;
    QRLabel49: TQRLabel;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRImage2: TQRImage;
    QRLabel50: TQRLabel;
    QRLabel51: TQRLabel;
    QRLabel52: TQRLabel;
    QRLabel53: TQRLabel;
    QRShape12: TQRShape;
    QRShape16: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRShape24: TQRShape;
    QRShape25: TQRShape;
    QRShape26: TQRShape;
    QRShape27: TQRShape;
    QRShape28: TQRShape;
    QRShape29: TQRShape;
    QRShape30: TQRShape;
    QRLabel54: TQRLabel;
    QRLabel55: TQRLabel;
    QRLabel56: TQRLabel;
    QRLabel57: TQRLabel;
    QRLabel58: TQRLabel;
    QRShape31: TQRShape;
    QRShape32: TQRShape;
    QRShape33: TQRShape;
    QRShape34: TQRShape;
    QRLabel59: TQRLabel;
    QRLabel60: TQRLabel;
    QRLabel61: TQRLabel;
    QRLabel62: TQRLabel;
    QRLabel63: TQRLabel;
    QRLabel64: TQRLabel;
    QRLabel65: TQRLabel;
    QRSysData1: TQRSysData;
    qrlfechalta: TQRLabel;
    QryDEFECTOSINSPECCION: TSQLQuery;
    qrlPreve1: TQRLabel;
    qrlPreve2: TQRLabel;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape23: TQRShape;
    QRShape35: TQRShape;
    QRShape3: TQRShape;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    QrTotal: TQRLabel;
    QRShape36: TQRShape;
    QRShape15: TQRShape;
    QRLabel66: TQRLabel;
    procedure CabeceraPaginaBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure PieDePaginaBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure BandFichaInspeccionBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRInformeInspeccionPreview(Sender: TObject);
    procedure QRInformeInspeccionAfterPreview(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure QRInformeInspeccionBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    iNumDefectosPorPagina_Auxi{, cantpaginas}: integer;
    fImprimirInformeInspeccion: boolean; { True si el usuario ha pulsado "Imprimir" }
    fInspeccion: TInspeccion;
    fEjercicio : integer;
    fCodigo: integer;
    fConsulta : TsqlQuery;
    function GetImprimirInformeInspeccion: boolean;
    procedure SetImprimirInformeInspeccion (const bImprimir: boolean);
    // Devuelve True si se han logrado obtener los datos de las observaciones correctamente
    function ObtenerObservaciones_Inspeccion (var ListaObs: TStringList): Boolean;
    procedure ActivarDesactivar_Componentes (const bActivar: boolean);

  public
    { Public declarations }
    property ImprimirInformeInspeccion: boolean read GetImprimirInformeInspeccion write SetImprimirInformeInspeccion;
    procedure ResultadoInspeccion (bEsOriginal: boolean);
    constructor CreateFromInspeccion (const aInspec: TInspeccion; const bEsOrig, bPresPreliminar: boolean; aContexto: pTContexto);
    constructor CreateFromEjercicioAndCode (const aEjercicio, aCode : integer; const bEsOrig, bPresPreliminar: boolean; aContexto: pTContexto);
  end;

var
  FrmFichaInspeccion: TFrmFichaInspeccion;


implementation

uses
  ULOGS,
  USAGESTACION,
  USAGCLASIFICACION,
  USAGFABRICANTE,
  UCTINSPECTORES,
  UFPRESPRELIMINAR,
  UCTEVERIFICACIONES,
  PRINTERS,
  GLOBALS,
  QrPrnTr,
  UUtils;


{$R *.DFM}

const
    COLOR_GRIS_CLARO = $00DFDFDF;


resourcestring
     FICHERO_ACTUAL = 'UInforme.Pas';
     NO_OFICIAL = 'NO OFICIAL.';
     ORIGINAL = 'ORIGINAL';
     DUPLICADO = 'DUPLICADO';
     CARACTER_X = 'X';
var
  frmPresPreliminar_Auxi: TfrmPresPreliminar;


function TFrmFichaInspeccion.GetImprimirInformeInspeccion: boolean;
begin
Result := fImprimirInformeInspeccion;
end;


procedure TFrmFichaInspeccion.SetImprimirInformeInspeccion (const bImprimir: boolean);
begin
fImprimirInformeInspeccion := bImprimir;
end;


procedure TFrmFichaInspeccion.ResultadoInspeccion (bEsOriginal: boolean);
var  aq:tsqlquery;

begin
  try
    with qryDefectosInspeccion do
      begin
        Close;
        sqlconnection := MyBD;
        if Assigned(fInspeccion) then
          begin
            ParamByName('UnCodigo').AsString := fInspeccion.ValueByName[FIELD_CODINSPE];
            ParamByName('UnEjercicio').AsString := fInspeccion.ValueByName[FIELD_EJERCICI];
          end
        else
          begin
            ParamByName('UnCodigo').AsInteger := fCodigo;
            ParamByName('UnEjercicio').AsInteger := fEjercicio;
           end;
        Open;
      end;


    if Assigned(fInspeccion)then
      begin
        case fInspeccion.ValueByName[FIELD_TIPO][1] of
          T_PREVERIFICACION, T_GRATUITA:
            begin
              BandFichaInspeccion.Color := COLOR_GRIS_CLARO;
                case fInspeccion.ValueByName[FIELD_TIPO][1] of
                  T_PREVERIFICACION:
                    begin
                      MemoObservaciones.Enabled := false;
                      LblXNEstacion.Enabled := false;
                      lblXResponsable.Enabled := false;
                      LblTipoInspeccion.Enabled := false;
                      qrlPreve1.Enabled := true;
                      qrlPreve2.enabled := true;
                    end;
                  T_GRATUITA: LblTipoInspeccion.Caption := Format('Verificación %s. %s',[C_GRATUITA, NO_OFICIAL]);
                end;
            end;
          T_VOLUNTARIA, T_VOLUNTARIAREVERIFICACION:
            begin
              BandFichaInspeccion.Color := clWhite;
                case fInspeccion.ValueByName[FIELD_TIPO][1] of
                  T_VOLUNTARIA: LblTipoInspeccion.Caption := Format('Verificación %s. %s',[T_VOLUNTARIA, NO_OFICIAL]);
                  T_VOLUNTARIAREVERIFICACION: LblTipoInspeccion.Caption := Format('Verificación %s. %s',[C_VOLUNTARIAREVERIFICACION, NO_OFICIAL]);
                end;
            end
        else
          begin
            BandFichaInspeccion.Color := clWhite;
            LblTipoInspeccion.Enabled := False;



          end;
        end;
      end
    else
      begin
        case fConsulta.FieldByName(FIELD_TIPO).AsString[1] of
          T_PREVERIFICACION, T_GRATUITA:
            begin
              BandFichaInspeccion.Color := COLOR_GRIS_CLARO;
                case fConsulta.FieldByName(FIELD_TIPO).AsString[1] of
                  T_PREVERIFICACION:
                    begin
                      MemoObservaciones.Enabled := false;
                      LblXNEstacion.Enabled := false;
                      lblXResponsable.Enabled := false;
                      LblTipoInspeccion.Enabled := false;
                      qrlPreve1.Enabled := true;
                      qrlPreve2.enabled := true;
                    end;
                  T_GRATUITA: LblTipoInspeccion.Caption := Format('Verificación %s. %s',[C_GRATUITA, NO_OFICIAL]);
                end;
            end;
          T_VOLUNTARIA, T_VOLUNTARIAREVERIFICACION:
            begin
              BandFichaInspeccion.Color := clWhite;
                case fConsulta.FieldByName(FIELD_TIPO).AsString[1] of
                  T_VOLUNTARIA: LblTipoInspeccion.Caption := Format('Verificación %s. %s',[T_VOLUNTARIA, NO_OFICIAL]);
                  T_VOLUNTARIAREVERIFICACION: LblTipoInspeccion.Caption := Format('Verificación %s. %s',[C_VOLUNTARIAREVERIFICACION, NO_OFICIAL]);
                end;
            end
        else
          begin
            BandFichaInspeccion.Color := clWhite;
            LblTipoInspeccion.Enabled := False;

            //29/09/2010
            {
              aq:=tsqlquery.create(self);
               try
                 aq.SQLConnection := MyBD;
                 if Assigned(fInspeccion) then
                    aq.sql.add(format('select  tipfactu,  imponeto,  ROUND(imponeto+((IMPONETO*IVAINSCR)/100)+ ((IMPONETO*IVANOINS)/100) ,2) AS imponetoa ,iibb from tfacturas f,tinspeccion i where f.codfactu=i.codfactu and i.codinspe= %d ',[fInspeccion.ValueByName[FIELD_CODINSPE]]))
                 else
                    aq.sql.add(format('select  tipfactu,  imponeto,  ROUND(imponeto+((IMPONETO*IVAINSCR)/100)+ ((IMPONETO*IVANOINS)/100) ,2) AS imponetoa ,iibb from tfacturas f,tinspeccion i where f.codfactu=i.codfactu and i.codinspe= %d ',[fcodigo]));
                 aq.open;
                 qrlPreve1.Enabled := true;
                 qrlPreve1.Font.Size :=12;
                 if  aq.Fields[0].asstring='B' then
                   qrlPreve1.caption := 'USTED HA ABONADO POR ESTA INSPECCION : $'+aq.Fields[1].asstring
                 else
                   qrlPreve1.caption := 'USTED HA ABONADO POR ESTA INSPECCION : $'+aq.Fields[2].asstring;


               finally
                 aq.free;
               end;
               }

               //03/11/2010 CAMBIO ML - MAR
                if (fConsulta.FieldByName(FIELD_TIPO).AsString[1] = T_REVERIFICACION) then
                  begin

                     aq:=tsqlquery.create(self);
                     aq.SQLConnection := MyBD;
                     if Assigned(fInspeccion) then
                     aq.sql.add(Format('SELECT  COUNT(*) FROM TINSPECCIONEXTERNA   '+
                                        ' WHERE (CODINSPE = %D) ',[fInspeccion.ValueByName[FIELD_CODINSPE]]))
                     ELSE
                       aq.sql.add(Format('SELECT  COUNT(*) FROM TINSPECCIONEXTERNA   '+
                                        ' WHERE (CODINSPE = %D) ',[fCodigo]));


                     aq.open;

                     if aq.fields[0].asinteger > 0 then
                         qrlPreve1.caption := 'REVERIFICACION EXTERNA';
                     {
                     cds:=TClientDataSet.Create(application);
                     with cds do
                     begin
                      SetProvider(dsp);
                      CommandText:= (Format('SELECT  COUNT(*) FROM TINSPECCIONEXTERNA   '+
                                        ' WHERE (CODINSPE = %D) ',[iCodigo]));


                    open;
                    Fields[0].AsInteger;
                    end ;
                      if  Fields[0].AsInteger >0 then
                    }

                    


                 end;



                  //13/10/2010 CAMBIO ML - MAR
                 if (fConsulta.FieldByName(FIELD_TIPO).AsString[1] = T_NORMAL) then
             begin
               aq:=tsqlquery.create(self);
               try
                 aq.SQLConnection := MyBD;
                 if Assigned(fInspeccion) then
                    aq.sql.add(format('select  tipfactu,  imponeto,  ROUND(imponeto+((IMPONETO*IVAINSCR)/100)+ ((IMPONETO*IVANOINS)/100) ,2) AS imponetoa ,ROUND(((IMPONETO*IIBB)/100),2)iibb from tfacturas f,tinspeccion i where f.codfactu=i.codfactu and EJERCICI=%d and i.codinspe= %d ',[fEjercicio,fInspeccion.ValueByName[FIELD_CODINSPE]]))
                 else
                    aq.sql.add(format('select  tipfactu,  imponeto,  ROUND(imponeto+((IMPONETO*IVAINSCR)/100)+ ((IMPONETO*IVANOINS)/100) ,2) AS imponetoa ,ROUND(((IMPONETO*IIBB)/100),2)iibb  from tfacturas f,tinspeccion i where f.codfactu=i.codfactu and EJERCICI=%d and i.codinspe= %d ',[fEjercicio,fcodigo]));
                 aq.open;
                 qrlPreve1.Enabled := true;
                 qrlPreve1.Font.Size :=12;
                 if  aq.Fields[0].asstring='B' then
                   qrlPreve1.caption := 'USTED HA ABONADO POR ESTA INSPECCION : $'+floattostr(aq.Fields[1].asfloat+aq.Fields[3].asfloat)
                 else
                   qrlPreve1.caption := 'USTED HA ABONADO POR ESTA INSPECCION : $'+aq.Fields[2].asstring;

               finally
                 aq.free;
               end;
            end  ;
           //****************************
          end;
        end;
      end;

    QRDBTxtCadDefec.Color := BandFichaInspeccion.Color;
    LblDescripcion.Color := BandFichaInspeccion.Color;
    LblLeves.Color := BandFichaInspeccion.Color;
    LblGraves.Color := BandFichaInspeccion.Color;
    if bEsOriginal then
      LblXEjemplarPara.Caption := ORIGINAL
    else
      LblXEjemplarPara.Caption := DUPLICADO;
  except
    on E:Exception do
    raise Exception.Create ('Error rellenando el informe de inspección por: ' + E.Message);
  end;
end;


procedure TFrmFichaInspeccion.CabeceraPaginaBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
aCodigoVehiculo,
aCodigoFrecuencia,
aCodigoPropietario,
aCodigoConductor : string;
begin
LblXPartiNueve.Caption := '';  LblXPubliNueve.Caption := '';
LblXAmbulancia.Caption := '';  LblXCarga.Caption := '';
LblXMasDeNueve.Caption := '';  LblXVial.Caption := '';
LblXEscuela.Caption := '';     LblXAlquiler.Caption := '';
LblXMotocicleta.Caption := ''; LblXAgricola.Caption := '';

LblXApto.Caption := '';      LblXCondicional.Caption := '';
LblXRechazado.Caption := ''; LblXBaja.Caption := '';

  if Assigned(FInspeccion) then
    begin
    //INSPECCION
      LblXNumero.Caption := fInspeccion.Informe;
      LblXVencimiento.Caption := fInspeccion.ValueByName[FIELD_FECVENCI];
      if (fInspeccion.ValueByName[FIELD_RESULTAD] = INSPECCION_APTA) then
        LblXApto.Caption := CARACTER_X
      else
        if (fInspeccion.ValueByName[FIELD_RESULTAD] = INSPECCION_CONDICIONAL) then
          LblXCondicional.Caption := CARACTER_X
        else
        if (fInspeccion.ValueByName[FIELD_RESULTAD] = INSPECCION_RECHAZADO) then
          LblXRechazado.Caption := CARACTER_X
        else
          LblXBaja.Caption := CARACTER_X;

        aCodigoVehiculo := fInspeccion.ValueByName[FIELD_CODVEHIC];
        aCodigoFrecuencia := fInspeccion.ValueByName[FIELD_CODFRECU];
        aCodigoPropietario := fInspeccion.ValueByName[FIELD_CODCLPRO];
        aCodigoConductor := fInspeccion.ValueByName[FIELD_CODCLCON];
    end
  else
    begin
      LblXNumero.Caption := fConsulta.FieldByName('INFORME').AsString;
      LblXVencimiento.Caption := fConsulta.FieldByName('VENCIMIENTO').AsString;
      if (fConsulta.FieldByName(FIELD_RESULTAD).AsString = INSPECCION_APTA) then
        LblXApto.Caption := CARACTER_X
      else
      if (fConsulta.FieldByName(FIELD_RESULTAD).AsString = INSPECCION_CONDICIONAL) then
        LblXCondicional.Caption := CARACTER_X
      else
        if (fConsulta.FieldByName(FIELD_RESULTAD).AsString = INSPECCION_RECHAZADO)then
          LblXRechazado.Caption := CARACTER_X
        else
          LblXBaja.Caption := CARACTER_X;

        aCodigoVehiculo := fConsulta.FieldByname(FIELD_CODVEHIC).AsString;
        aCodigoFrecuencia := fConsulta.FieldByName(FIELD_CODFRECU).AsString;
        aCodigoPropietario := fConsulta.FieldByName(FIELD_CODCLPRO).AsString;
        aCodigoConductor := fConsulta.FieldByName(FIELD_CODCLCON).AsString;
    end;

    case StrToInt(aCodigoFrecuencia) of
      1:  LblXMotocicleta.Caption := CARACTER_X;
      2:  LblXPartiNueve.Caption := CARACTER_X;
      3:  LblXPubliNueve.Caption := CARACTER_X;
      4,11,12:  LblXMasDeNueve.Caption := CARACTER_X;
      5:  LblXCarga.Caption := CARACTER_X;
      6:  LblXAgricola.Caption := CARACTER_X;
      7:  LblXVial.Caption := CARACTER_X;
      8:  LblXEscuela.Caption := CARACTER_X;
      9:  LblXAlquiler.Caption := CARACTER_X;
      10:  LblXAmbulancia.Caption := CARACTER_X;
    end;

      //PLANTA
    LblXZona.Caption := fVarios.ValueByName[FIELD_ZONA];
    LblXEstacion.Caption := fVarios.ValueByName[FIELD_ESTACION];

    with TsqlQuery.Create(self) do
      try
        SQLConnection := MyBD;
        { TODO -oran -ctransacciones : Ver tema sesion }
        SQL.Add(Format('SELECT NOMMARCA, NOMMODEL, NUMMOTOR, NUMBASTI, NOMTIPVE, NCERTGNC, NVL(PATENTEN, PATENTEA) PATENTE, ANIOFABR, (NOMBRE || '' '' || APELLID1 || '' '' || APELLID2) NOMBREC, (TIPODOCU || '' '' || DOCUMENT) DOCUMENTO ' +
                       '   FROM TVEHICULOS TV,                                                                                                                                                              ' +
                       '        TMARCAS TM,                                                                                                                                                                 ' +
                       '        TMODELOS TML,                                                                                                                                                               ' +
                       '        TTIPOESPVEH TTE,                                                                                                                                                            ' +
                       '        TTIPOVEHICU TTV,                                                                                                                                                            ' +
                       '        TCLIENTES TC                                                                                                                                                                ' +
                       '   WHERE                                                                                                                                                                            ' +
                       '        TC.CODCLIEN = %S AND TV.CODVEHIC = %S AND                                                                                                  ' +
                       '        TV.TIPOESPE = TTE.TIPOESPE AND                                                                                                                                              ' +
                       '        TTE.TIPOVEHI = TTV.TIPOVEHI AND                                                                                                                                             ' +
                       '        TV.CODMARCA = TML.CODMARCA AND                                                                                                                                              ' +
                       '        TV.CODMODEL = TML.CODMODEL AND                                                                                                                                              ' +
                       '        TV.CODMARCA = TM.CODMARCA',[aCodigoPropietario, aCodigoVehiculo]));
        Open;

        //VEHICULO
        LblXAnio.Caption := FieldByName(FIELD_ANIOFABR).AsString;
        LblXGnc.Caption := FieldByName(FIELD_NCERTGNC).AsString;
        LblXDominio.Caption := FieldByName('PATENTE').AsString;
        LblXMotor.Caption := FieldByName(FIELD_NUMMOTOR).AsString;
        LblXChasis.Caption := FieldByName(FIELD_NUMBASTI).AsString;
        LblXTipo.Caption := FieldByName(FIELD_NOMTIPVE).AsString;
        LblXMarca.Caption := FieldByName(FIELD_NOMMARCA).AsString;
        LblXModelo.Caption := FieldByName(FIELD_NOMMODEL).AsString;

        //PROPIETARIO
        LblXTitular.Caption := FieldByName('NOMBREC').AsString;
        LblXDocumentoTitular.Caption := FieldByName('DOCUMENTO').AsString;

        Close;
        SQL.Clear;
        SQL.Add (Format('SELECT (NOMBRE || '' '' || APELLID1 || '' '' || APELLID2) NOMBREC, (TIPODOCU || '' '' || DOCUMENT) DOCUMENTO ' +
                        ' FROM TCLIENTES WHERE CODCLIEN = %S', [aCodigoConductor]));
        Open;

        //CONDUCTOR
        LblXConductor.Caption := FieldByName('NOMBREC').AsString;
        LblXDocumento.Caption := FieldByName('DOCUMENTO').AsString;
      finally
        Close;
        Free;
      end;
end;

procedure TFrmFichaInspeccion.PieDePaginaBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
   ListaObs: TStringList;
   aq: tsqlQuery;
begin
    if Assigned(FInspeccion)
    then begin
        LblXHoraIngreso.Caption := FormatDateTime('hh:nn:ss',StrToDateTime(fInspeccion.ValueByName[FIELD_FECHALTA]));
        LblXHegr.Caption := FormatDateTime('hh:nn:ss',StrToDateTime(fInspeccion.ValueByName[FIELD_HORFINAL]));
        try
           with fInspeccion do
           begin
//               LblXHTTL.Caption := FormatDateTime('hh:nn:ss',
//                    (
//                     ( StrToDateTime(ValueByName[FIELD_HORSALZ1]) - StrToDateTime(ValueByName[FIELD_HORENTZ1]) ) +
//                     ( StrToDateTime(ValueByName[FIELD_HORSALZ2]) - StrToDateTime(ValueByName[FIELD_HORENTZ2]) ) +
//                     ( StrToDateTime(ValueByName[FIELD_HORSALZ3]) - StrToDateTime(ValueByName[FIELD_HORENTZ3]) )
//                    )
//                 );



               aq:=tsqlquery.create(self);
               try
                 aq.SQLConnection := MyBD;
                 aq.sql.add('alter session set nls_date_format = ''dd/mm/yyyy hh24:mi:ss''');
                 aq.ExecSQL;
                 aq.SQL.Clear;
                 aq.sql.add(format('select mayorfecha(''%s'',''%s'',''%s'',''%s''), menorfecha(''%s'',''%s'',''%s'',''%s'') from dual',[ValueByName[FIELD_HORSALZ1],ValueByName[FIELD_HORSALZ2],ValueByName[FIELD_HORSALZ3],ValueByName[FIELD_HORfinal],ValueByName[FIELD_HORENTZ1],ValueByName[FIELD_HORENTZ2],ValueByName[FIELD_HORENTZ3],ValueByName[FIELD_fechalta]]));
                 aq.open;
                 LblXHTTL.Caption := FormatDateTime('hh:nn:ss',
                    (
                     aq.Fields[0].asdatetime - aq.Fields[1].asdatetime
                    )
                 );
               finally
                 aq.free;
               end;
           end;
        except
            on E:Exception do
               LblXHTTL.Caption := '';
        end;

        try
           LblXHTTE.Caption := FormatDateTime('hh:nn:ss', (StrToDateTime(fInspeccion.ValueByName[FIELD_HORFINAL]) -  StrToDateTime(fInspeccion.ValueByName[FIELD_FECHALTA])));
        except
            on E:Exception do
               LblXHTTE.Caption := '';
        end;
        qrlfechalta.Caption := copy(fInspeccion.ValueByName[FIELD_FECHALTA],1,10);
    end
    else begin
        LblXHoraIngreso.Caption := FormatDateTime('hh:nn:ss',StrToDateTime(fConsulta.FieldByName(FIELD_FECHALTA).AsString));
        LblXHegr.Caption := FormatDateTime('hh:nn:ss',StrToDateTime(fConsulta.FieldByName(FIELD_HORFINAL).AsString));
        try
           with fConsulta do
           begin
//               LblXHTTL.Caption := FormatDateTime('hh:nn:ss',
//                    (
//                     ( StrToDateTime(FieldByName(FIELD_HORSALZ1).AsString) - StrToDateTime(FieldByName(FIELD_HORENTZ1).AsString) ) +
//                     ( StrToDateTime(FieldByName(FIELD_HORSALZ2).AsString) - StrToDateTime(FieldByName(FIELD_HORENTZ2).AsString) ) +
//                     ( StrToDateTime(FieldByName(FIELD_HORSALZ3).AsString) - StrToDateTime(FieldByName(FIELD_HORENTZ3).AsString) )
//                    )
//                 );
               aq:=tsqlquery.create(self);
               try
                 aq.SQLConnection := MyBD;
                 aq.sql.add('alter session set nls_date_format = ''dd/mm/yyyy hh24:mi:ss''');
                 aq.ExecSQL;
                 aq.SQL.Clear;
                 aq.sql.add(format('select mayorfecha(''%s'',''%s'',''%s'',''%s''), menorfecha(''%s'',''%s'',''%s'',''%s'') from dual',[FieldByName(FIELD_HORSALZ1).asstring,FieldbyName(FIELD_HORSALZ2).asstring,FieldByName(FIELD_HORSALZ3).asstring,FieldByName(FIELD_HORfinal).asstring,FieldByName(FIELD_HORENTZ1).asstring,FieldByName(FIELD_HORENTZ2).asstring,FieldByName(FIELD_HORENTZ3).asstring,FieldByName(FIELD_fechalta).asstring]));
                 aq.open;
                 LblXHTTL.Caption := FormatDateTime('hh:nn:ss',
                    (
                     aq.Fields[0].asdatetime - aq.Fields[1].asdatetime
                    )
                 );
               finally
                 aq.free;
               end;
             end;
        except
            on E:Exception do
               LblXHTTL.Caption := '';
        end;

        try
            LblXHTTE.Caption := FormatDateTime('hh:nn:ss', (StrToDateTime(fConsulta.FieldByName(FIELD_HORFINAL).AsString) -  StrToDateTime(fConsulta.FieldByName(FIELD_FECHALTA).AsString)));
        except
            on E:Exception do
               LblXHTTE.Caption := '';
        end;
        qrlfechalta.Caption := copy(fConsulta.fieldByName(FIELD_FECHALTA).asstring,1,10);
    end;


// No descomentar   ListaObs := nil;
////////////////////////////////////////////// LUCHO ///////////////////////////////////////////////
    ListaObs := TStringList.Create;
    try
       ListaObs.Clear;
// No descomentar    //       ObtenerObservaciones_Inspeccion (ListaObs);
//       ListaObs.Add('Las DEFICIENCIAS OBSERVADAS que NO estén calificadas como Defecto Leve (DL) o Defecto Grave (DG) deberán ser igualmente reparadas, ') ;
//       listaobs.Add('aunque no sea necesario volver para una nueva Verificación');
       ListaObs.Add('Consultas al: '+fVarios.Telefono);
       MemoObservaciones.Lines := ListaObs;
    finally
      ListaObs.Free;
    end;
//      MemoObservaciones.Lines.Add('Consultas al: '+fVarios.Telefono); //--> Agregado porque faltaban los telefonos
                                                                      //    esos si debian salir.
////////////////////////////////////////////////////////////////////////////////////////////////////

//    LblXNEstacion.Caption := 'Planta Nº: ' + fVarios.ValueByName[FIELD_IDENCONC];  MODI RAN
    LblXNEstacion.Caption := 'Planta Nº: '+ fVarios.NombreEstacionCompleto;
    //LblXResponsable.Caption := 'Firma y aclaración responsable: ' + fVarios.ValueByName[FIELD_NOMRESPO];
    LblXResponsable.Caption :=fVarios.ValueByName[FIELD_NOMRESPO];

//    qrlPagina.caption := 'Página '+inttostr(QRInformeInspeccion.QRPrinter.pagenumber) +' de '+intToStr(cantpaginas);// PAGINA
//    fIncidencias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL,inttostr(cursores));

end;


// True si ha devuelto las observaciones de la inspección
function TFrmFichaInspeccion.ObtenerObservaciones_Inspeccion (var ListaObs: TStringList): Boolean;
resourcestring
    ZONA_1 = 'Zona: 1';
    ZONA_2 = 'Zona: 2';
    ZONA_3 = 'Zona: 3';
var
   iNumRevisor_Auxi: integer; // var. auxi.
   sCadena_Auxi, sNombreInspector: string; // Cadenas auxiliares
   aQ: TsqlQuery;
begin
    Result := False;
    ListaObs.Clear;
    aQ := TsqlQuery.Create (nil);
    try
      try
         Result := False;
         with aQ do
         begin

             SQLConnection := MyBD;
             Sql.Clear;
             Sql.Add ('SELECT nvl(NUMREVZ1,0) numrevz1, nvl(NUMLINZ1,0) numlinz1, nvl(NUMREVZ2,0) numrevz2, nvl(NUMLINZ2,0) numlinz2, nvl(NUMREVZ3,0)numrevz3, nvl(NUMLINZ3,0) numlinz3 FROM TDATINSPECC');
             Sql.Add (Format ('   WHERE EJERCICI=%d AND CODINSPE=%d',[fEjercicio, fCodigo]));

             {$IFDEF TRAZAS}
               fTrazas.PonComponente(TRAZA_SQL,1,FICHERO_ACTUAL,aQ);
             {$ENDIF}

             Open;

             if (not aQ.Eof) then
             begin
                 {$IFDEF TRAZAS}
                   fTrazas.PonRegistro(TRAZA_REGISTRO,1,FICHERO_ACTUAL,aQ);
                 {$ENDIF}

                 // Zona 1
                 iNumRevisor_Auxi := FieldByName (FIELD_NUMREVZ1).AsInteger;
                 if (Length(IntToStr(iNumRevisor_Auxi)) > 4)
                 then iNumRevisor_Auxi := StrToInt (Copy (IntToStr(iNumRevisor_Auxi),length(IntToStr(iNumRevisor_Auxi))-3,4));
                 sNombreInspector := Devolver_NombreInspector (iNumRevisor_Auxi);
                 //sNombreInspector := ''; //Devolver_NombreInspector (iNumRevisor_Auxi);
                 if (sNombreInspector = '')
                 then sNombreInspector := 'Desconocido: '+  ComponerNumeroInspector (FieldByName (FIELD_NUMREVZ1).AsInteger);
                 sCadena_Auxi := Format ('%s    Linea: %1.2d  Inspector: %s', [ZONA_1, FieldByName(FIELD_NUMLINZ1).AsInteger, sNombreInspector]);
                 ListaObs.Add(sCadena_Auxi);

                 // Zona 2
                 iNumRevisor_Auxi := FieldByName (FIELD_NUMREVZ2).AsInteger;
                 if (Length(IntToStr(iNumRevisor_Auxi)) > 4)
                 then iNumRevisor_Auxi := StrToInt (Copy (IntToStr(iNumRevisor_Auxi),length(IntToStr(iNumRevisor_Auxi))-3,4));
                 //sNombreInspector := '';
                 sNombreInspector := Devolver_NombreInspector (iNumRevisor_Auxi);
                 if (sNombreInspector = '')
                 then sNombreInspector := 'Desconocido: '+ ComponerNumeroInspector (FieldByName (FIELD_NUMREVZ2).AsInteger);
                 sCadena_Auxi := Format ('%s    Linea: %1.2d  Inspector: %s', [ZONA_2, FieldByName(FIELD_NUMLINZ2).AsInteger, sNombreInspector]);
                 ListaObs.Add(sCadena_Auxi);

                 // Zona 3
                 iNumRevisor_Auxi := FieldByName (FIELD_NUMREVZ3).AsInteger;
                 if (Length(IntToStr(iNumRevisor_Auxi)) > 4)
                 then iNumRevisor_Auxi := StrToInt (Copy (IntToStr(iNumRevisor_Auxi),length(IntToStr(iNumRevisor_Auxi))-3,4));
                 //sNombreInspector := '';
                 sNombreInspector := Devolver_NombreInspector (iNumRevisor_Auxi);
                 if (sNombreInspector = '')
                 then sNombreInspector := 'Desconocido: '+ ComponerNumeroInspector (FieldByName (FIELD_NUMREVZ3).AsInteger);
                 sCadena_Auxi := Format ('%s    Linea: %1.2d  Inspector: %s', [ZONA_3, FieldByName(FIELD_NUMLINZ3).AsInteger, sNombreInspector]);
                 ListaObs.Add(sCadena_Auxi);
             end;
         end;
         Result := True;
      except
        on E:Exception do
        begin
          FAnomalias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL, 'Error en ObtenerObservaciones_Inspeccion: ' + E.Message);
        end;
      end;
    finally
         aQ.Close;
         aQ.Free;
    end;
end;



procedure TFrmFichaInspeccion.BandFichaInspeccionBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
  sCodigo_Auxi, sDescripcion_Auxi, sOk_Auxi, sLeve_Auxi, sGrave_Auxi: string;
begin
    with qryDefectosInspeccion do
    begin
        ObtenerLiteralCalificativo (fVarios.Database, fEjercicio, fCodigo,
                                    qryDefectosInspeccion.FieldByName(FIELD_CADDEFEC).AsString,
                                    qryDefectosInspeccion.FieldByName(FIELD_CALIFDEF).AsString,
                                    qryDefectosInspeccion.FieldByName(FIELD_LITDEFEC).AsString,
                                    qryDefectosInspeccion.FieldByName(FIELD_LOCALIZA).AsString,
                                    sCodigo_Auxi, sDescripcion_Auxi, sOk_Auxi, sLeve_Auxi,
                                    sGrave_Auxi);
        LblDescripcion.Caption := sDescripcion_Auxi;
        LblLeves.Caption := sLeve_Auxi;
        LblGraves.Caption := sGrave_Auxi;
    end;
end;

procedure TFrmFichaInspeccion.QRInformeInspeccionPreview(Sender: TObject);
begin
   frmPresPreliminar_Auxi := TfrmPresPreliminar.Create (Application);
   frmPresPreliminar_Auxi.QRPrevPresPrel.QRPrinter := TQRPrinter (Sender);
   frmPresPreliminar_Auxi.Show;
end;

constructor TFrmFichaInspeccion.CreateFromEjercicioAndCode (const aEjercicio, aCode : integer; const bEsOrig, bPresPreliminar: boolean; aContexto: pTContexto);
begin
    inherited Create (Application);
    fInspeccion := nil;
    fEjercicio := aEjercicio;
    fCodigo := aCode;
    fConsulta := TSQLQuery.Create(self);
    fConsulta.SQLConnection := fVarios.DataBase;

    fConsulta.SQL.Add
    (Format(
        'SELECT TO_CHAR(I.FECVENCI, ''DD/MM/YY'') VENCIMIENTO, I.CODVEHIC, I.CODCLCON, I.CODCLPRO, I.TIPO,                                                                                                                              ' +
        '       MOD(I.EJERCICI,100) || '' '' || LTRIM(TO_CHAR(R.ZONA,''0000'')) || LTRIM(TO_CHAR(R.ESTACION,''0000'')) || LTRIM(TO_CHAR(I.CODINSPE,''000000'')) || DECODE(I.TIPO,''I'','' R'',''E'', '' R'', '''') INFORME, ' +
        '       I.RESULTAD, I.CODFRECU, TO_CHAR(I.FECHALTA,''DD/MM/YYYY HH24:MI:SS'') FECHALTA, TO_CHAR(I.HORFINAL,''DD/MM/YYYY HH24:MI:SS'') HORFINAL,'+
        '       TO_CHAR(I.HORENTZ1,''DD/MM/YYYY HH24:MI:SS'') HORENTZ1, TO_CHAR(I.HORENTZ2,''DD/MM/YYYY HH24:MI:SS'') HORENTZ2, TO_CHAR(I.HORENTZ3,''DD/MM/YYYY HH24:MI:SS'') HORENTZ3, TO_CHAR(I.HORSALZ1,''DD/MM/YYYY HH24:MI:SS'') '+
        '       HORSALZ1, TO_CHAR(I.HORSALZ2,''DD/MM/YYYY HH24:MI:SS'') HORSALZ2,'+
        '       TO_CHAR(I.HORSALZ3,''DD/MM/YYYY HH24:MI:SS'') HORSALZ3 '+ 
        'FROM  TINSPECCION I, TVARIOS R                                                                                                                                                                                     ' +
        'WHERE I.EJERCICI = %D AND I.CODINSPE = %D',[fEjercicio, fCodigo]));
    fConsulta.Open;
    ResultadoInspeccion (bEsOrig);
    QRInformeInspeccion.Prepare;
//    QrTotal.Caption:='/ '+IntToStr(QrinformeInspeccion.QRPrinter.PageCount);
    QrTotal.Caption:='#D:'+IntToStr(Total_Defectos(fEjercicio,fCodigo));
    if bPresPreliminar then
      begin
       ActivarDesactivar_Componentes (True);
       QRInformeInspeccion.Preview;
      end
    else
      begin
        if (aContexto <> nil) then
        begin
            ActivarDesactivar_Componentes (False);
            QRInformeInspeccion.PrinterSettings.PrinterIndex:=Printer.Printers.IndexOf(aContexto^.sNombre);
            QRInformeInspeccion.Printersettings.OutputBin := aContexto^.qrbBandeja;
            QRInformeInspeccion.Page.PaperSize := aContexto^.qrpPapel;
            QRInformeInspeccion.PrinterSettings.Orientation := aContexto^.qroOrientacion;
            QRInformeInspeccion.Page.LeftMargin := aContexto^.iMargenIzquierdo;
            QRInformeInspeccion.Page.TopMargin := aContexto^.iMargenSuperior;
        end;
      QRInformeInspeccion.Print;
      end;
end;

constructor TFrmFichaInspeccion.CreateFromInspeccion (const aInspec: TInspeccion; const bEsOrig, bPresPreliminar: boolean; aContexto: pTContexto);
begin
    inherited Create (Application);
    fInspeccion := aInspec;
    fInspeccion.Open;
    fEjercicio := StrToInt(fInspeccion.ValueByName[FIELD_EJERCICI]);
    fCodigo := StrToInt(FInspeccion.ValueByName[FIELD_CODINSPE]);
    fConsulta := nil;

    ResultadoInspeccion (bEsOrig);
    QRInformeInspeccion.Prepare;
    QrTotal.Caption:='#D:'+IntToStr(Total_Defectos(fEjercicio,fCodigo));
//    QrTotal.Caption:='/ '+IntToStr(QrinformeInspeccion.QRPrinter.PageCount);
    if bPresPreliminar then
    begin
       ActivarDesactivar_Componentes (True);
       QRInformeInspeccion.Preview;
    end
    else begin

        if (aContexto <> nil) then
        begin
            ActivarDesactivar_Componentes (False);
            QRInformeInspeccion.PrinterSettings.PrinterIndex:=Printer.Printers.IndexOf(aContexto^.sNombre);
            QRInformeInspeccion.Printersettings.OutputBin := aContexto^.qrbBandeja;
            QRInformeInspeccion.Page.PaperSize := aContexto^.qrpPapel;
            QRInformeInspeccion.PrinterSettings.Orientation := aContexto^.qroOrientacion;
            QRInformeInspeccion.Page.LeftMargin := aContexto^.iMargenIzquierdo;
            QRInformeInspeccion.Page.TopMargin := aContexto^.iMargenSuperior;
        end;
        QRInformeInspeccion.Print;
    end;
end;

procedure TFrmFichaInspeccion.QRInformeInspeccionAfterPreview(Sender: TObject);
begin
    ImprimirInformeInspeccion := (frmPresPreliminar_Auxi.ModalResult = mrOk);
end;


procedure TFrmFichaInspeccion.ActivarDesactivar_Componentes (const bActivar: boolean);
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

procedure TFrmFichaInspeccion.FormDestroy(Sender: TObject);
begin
    if Assigned(fConsulta)
    then begin
        fConsulta.Close;
        fConsulta.Free;
    end;
end;

procedure TFrmFichaInspeccion.QRInformeInspeccionBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
    iNumDefectosPorPagina_Auxi := 0;
end;


end.



