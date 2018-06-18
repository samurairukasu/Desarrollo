unit UCertifi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ExtCtrls, StdCtrls,UCDialgs,
  USAGCLASSES, USAGPRINTERS,
  quickrpt, Qrctrls, Db, SQLEXPR;

type
  TFrmCertificado = class(TForm)
    QRCertificado: TQuickRep;
    QRBand1: TQRBand;
    TitleBand1: TQRBand;
    LblFechaInspeccion: TQRLabel;
    LblTitular: TQRLabel;
    LblNumero: TQRLabel;
    LblClasificacion: TQRLabel;
    LblDominio: TQRLabel;
    LblNumeroOblea: TQRLabel;
    LblFechaVencimiento: TQRLabel;
    LblZona: TQRLabel;
    LblEstacion: TQRLabel;
    QRLabelImpr8: TQRLabel;
    QRLabelImpr1: TQRLabel;
    QRLabelImpr9: TQRLabel;
    QRLabelImpr10: TQRLabel;
    QRLabelImpr3: TQRLabel;
    QRLabelImpr2: TQRLabel;
    QRLabelImpr4: TQRLabel;
    QRLabelImpr7: TQRLabel;
    QRLabelImpr11: TQRLabel;
    QRLabelImpr6: TQRLabel;
    QRLabelImpr17: TQRLabel;
    QRLabelImpr18: TQRLabel;
    QRLabelImpr20: TQRLabel;
    QRLabelImpr19: TQRLabel;
    QRLabelImpr21: TQRLabel;
    QRLabelImpr15: TQRLabel;
    QRLabelImpr14: TQRLabel;
    QRLabelImpr13: TQRLabel;
    QRLabelImpr12: TQRLabel;
    QRLabelImpr5: TQRLabel;
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
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRShape13: TQRShape;
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
    fInspeccion: TInspeccion;
    fEjercicio: integer;
    fCodigo: integer;
    fOblea: String;
    fConsulta: TSQLQuery;
    ftipos_inspe:TSQLQuery;
    function GetImprimirInformeInspeccion: boolean;
    procedure SetImprimirInformeInspeccion (const bImprimir: boolean);
    procedure Rellenar_Certificado;
    procedure Rellenar_Certificado_Oblea;
    procedure ActivarDesactivar_Componentes (const bActivar: boolean);
    procedure ActivarDesactivar_segun_tvoluntaria (const bActivar: boolean);
  public
    { Public declarations }
    property ImprimirCertificado: boolean read GetImprimirInformeInspeccion write SetImprimirInformeInspeccion;
    constructor CreateFromCertificado (const aInspec: TInspeccion; const bPresPreliminar: boolean; aContexto: pTContexto);
    constructor CreateFromEjercicioAndCode (const aEjercicio, aCode : integer; const bPresPreliminar: boolean; aContexto: pTContexto);
  end;

var
  FrmCertificado: TFrmCertificado;
  bandera_voluntaria:boolean;


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
      FICHERO_ACTUAL = 'UCertifi';


var
  frmPresPreliminar_Auxi: TfrmPresPreliminar;

procedure TFrmCertificado.Rellenar_Certificado_Oblea;
var
    aCodigoVehiculo : string;
    aCodigoPropietario : string;
    aCodigoFrecuencia : string;
begin
    if Assigned(fInspeccion) then
      begin
        aCodigoVehiculo := fInspeccion.ValueByName[FIELD_CODVEHIC];
        aCodigoPropietario := fInspeccion.ValueByName[FIELD_CODCLPRO];
        aCodigoFrecuencia := fInspeccion.ValueByName[FIELD_CODFRECU];





           
      end;

    LblEstacion.Caption := fVarios.ValueByName[FIELD_ESTACION];
    LblZona.Caption := fVarios.ValueByName[FIELD_ZONA];
    with TSQLQuery.Create(self) do
    try
        SQLConnection := fVarios.Database;
        { TODO -oran -ctransacciones : ver tema session }
         SQL.Add (Format(
                   ' SELECT ABRCLASI, NVL(PATENTEN, PATENTEA) PATENTE, (NOMBRE || '' '' || APELLID1 || '' '' || APELLID2) NOMBREC, (TIPODOCU ||'' '' || DOCUMENT) DOCUMENTO ' +
                   ' FROM TFRECUENCIA, TCLIENTES, TVEHICULOS WHERE CODCLIEN = %S AND CODVEHIC = %S AND CODFRECU = %S', [aCodigoPropietario, aCodigoVehiculo, aCodigoFrecuencia]));
        Open;
        LblNumero.Caption := FieldByName('DOCUMENTO').AsString;
        LblTitular.Caption := FieldByName('NOMBREC').AsString;
        LblDominio.Caption := FieldByName('PATENTE').AsString;
        LblClasificacion.Caption := FieldByname(FIELD_ABRCLASI).AsString;

        if Assigned(fInspeccion) then
          begin
            LblFechaInspeccion.Caption :=  FormatDateTime('dd/mm/yy',StrToDateTime(fInspeccion.ValueByName[FIELD_FECHALTA]));
            LblFechaVencimiento.Caption := fInspeccion.ValueByName[FIELD_FECVENCI];
            LblNumeroOblea.Caption := fOblea;
          end
    finally
        Close;
        Free;
    end;
end;




procedure TFrmCertificado.QRCertificadoPreview(Sender: TObject);
begin
   frmPresPreliminar_Auxi := TfrmPresPreliminar.Create (Application);
   frmPresPreliminar_Auxi.QRPrevPresPrel.QRPrinter := TQRPrinter (Sender);
   frmPresPreliminar_Auxi.Show;
end;

constructor TFrmCertificado.CreateFromEjercicioAndCode (const aEjercicio, aCode : integer; const bPresPreliminar: boolean; aContexto: pTContexto);
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
        'SELECT TO_CHAR(I.FECVENCI, ''DD/MM/YY'') VENCIMIENTO, I.CODVEHIC, I.CODCLPRO,                                                                                                                                      ' +
        '       MOD(I.EJERCICI,100) || '' '' || LTRIM(TO_CHAR(R.ZONA,''0000'')) || LTRIM(TO_CHAR(R.ESTACION,''0000'')) || LTRIM(TO_CHAR(I.CODINSPE,''000000'')) || DECODE(I.TIPO,''I'','' R'',''E'', '' R'', '''') INFORME, ' +
        '       SUBSTR(LTRIM(TO_CHAR(TO_NUMBER(NVL(I.NUMOBLEA,0)),''00000000'')),1,2) || ''-'' || SUBSTR(LTRIM(TO_CHAR(TO_NUMBER(NVL(I.NUMOBLEA,0)),''00000000'')),3,8) OBLEA,                                                  ' +
        '       I.CODFRECU, I.FECHALTA                                                                                                                                                                                      ' +
        'FROM  TINSPECCION I, TVARIOS R                                                                                                                                                                                     ' +
        'WHERE I.EJERCICI = %D AND I.CODINSPE = %D',[fEjercicio, fCodigo]));
    fConsulta.Open;

    Rellenar_Certificado;




    //************

    ftipos_inspe := TSQLQuery.Create(self);
    ftipos_inspe.SQLConnection := fVarios.DataBase;

    { TODO -oran -ctransacciones : ver tema session }

    ftipos_inspe.SQL.Add
    (Format(
        'SELECT TIPO                                                                                                                                                                              ' +
        'FROM  TINSPECCION                                                                                                                                                                                   ' +
        'WHERE TIPO IN(''D'',''I'') AND EJERCICI = %D AND CODINSPE = %D',[fEjercicio, fCodigo]));
    ftipos_inspe.Open;


     // bandera_voluntaria:=true;
            if  ftipos_inspe.RecordCount = 0  then
                bandera_voluntaria:=false
              else
               bandera_voluntaria:=true;


    //****************

           

    if bPresPreliminar then
    begin
        ActivarDesactivar_Componentes (True);
        QRCertificado.Page.Orientation := poPortrait;


           //martin mensaje en certificado 21/12/2010
           if not (bandera_voluntaria) then
               ActivarDesactivar_segun_tvoluntaria (false)
            else
               ActivarDesactivar_segun_tvoluntaria (true);


        QRCertificado.Preview
    end
    else
    begin

        ActivarDesactivar_Componentes (False);
        QRCertificado.Page.Orientation := poLandscape;
        
           //martin mensaje en certificado 21/12/2010
           if not (bandera_voluntaria) then
               ActivarDesactivar_segun_tvoluntaria (false)
            else
               ActivarDesactivar_segun_tvoluntaria (true);
            


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

constructor TFrmCertificado.CreateFromCertificado (const aInspec: TInspeccion; const bPresPreliminar: boolean; aContexto: pTContexto);
begin
    inherited Create (Application);
    fConsulta := nil;

    fInspeccion := aInspec;
    fInspeccion.Open;
    fEjercicio := StrToInt(fInspeccion.ValueByName[FIELD_EJERCICI]);
    fCodigo := StrToInt(fInspeccion.ValueByName[FIELD_CODINSPE]);

    Rellenar_Certificado;

      //martin mensaje en certificado 21/12/2010
      bandera_voluntaria:=true;
            if  not (finspeccion.ValueByName[FIELD_TIPO][1] in [t_voluntaria, T_VOLUNTARIAREVERIFICACION]) then
                bandera_voluntaria:=false
              else
               bandera_voluntaria:=true;





    if bPresPreliminar then
    begin
        ActivarDesactivar_Componentes (true);
        QRCertificado.Page.Orientation := poPortrait;


        //martin mensaje en certificado 21/12/2010
           if not (bandera_voluntaria) then
               ActivarDesactivar_segun_tvoluntaria (false)
            else
               ActivarDesactivar_segun_tvoluntaria (true);



        QRCertificado.Preview
    end
    else
    begin
        ActivarDesactivar_Componentes (False);
        QRCertificado.Page.Orientation := poLandscape;

       //martin mensaje en certificado 21/12/2010
           if not (bandera_voluntaria) then
               ActivarDesactivar_segun_tvoluntaria (false)
            else
               ActivarDesactivar_segun_tvoluntaria (true);


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


procedure TFrmCertificado.Rellenar_Certificado;
var
    aCodigoVehiculo : string;
    aCodigoPropietario : string;
    aCodigoFrecuencia : string;
    bandera:boolean;
begin

   bandera:=false;

    if Assigned(fInspeccion)
    then begin
        aCodigoVehiculo := fInspeccion.ValueByName[FIELD_CODVEHIC];
        aCodigoPropietario := fInspeccion.ValueByName[FIELD_CODCLPRO];
        aCodigoFrecuencia := fInspeccion.ValueByName[FIELD_CODFRECU];


    

    end
    else begin
        aCodigoVehiculo := fConsulta.FieldByName(FIELD_CODVEHIC).AsString;
        aCodigoPropietario := fConsulta.FieldByName(FIELD_CODCLPRO).AsString;
        aCodigoFrecuencia := fConsulta.FieldByName(FIELD_CODFRECU).AsString;




    end;

    LblEstacion.Caption := fVarios.ValueByName[FIELD_ESTACION];
    LblZona.Caption := fVarios.ValueByName[FIELD_ZONA];



    with TSQLQuery.Create(self) do
    try
        SQLConnection := fVarios.Database;

        { TODO -oran -ctransacciones : ver tema session }

        SQL.Add (Format(
                   ' SELECT ABRCLASI, NVL(PATENTEN, PATENTEA) PATENTE, (NOMBRE || '' '' || APELLID1 || '' '' || APELLID2) NOMBREC, (TIPODOCU ||'' '' || DOCUMENT) DOCUMENTO ' +
                   ' FROM TFRECUENCIA, TCLIENTES, TVEHICULOS WHERE CODCLIEN = %S AND CODVEHIC = %S AND CODFRECU = %S', [aCodigoPropietario, aCodigoVehiculo, aCodigoFrecuencia]));

        Open;
        LblNumero.Caption := FieldByName('DOCUMENTO').AsString;
        LblTitular.Caption := FieldByName('NOMBREC').AsString;
        LblDominio.Caption := FieldByName('PATENTE').AsString;
        LblClasificacion.Caption := FieldByname(FIELD_ABRCLASI).AsString;

        if Assigned(fInspeccion)
        then begin
            LblFechaInspeccion.Caption :=  FormatDateTime('dd/mm/yy',StrToDateTime(fInspeccion.ValueByName[FIELD_FECHALTA]));
            LblFechaVencimiento.Caption := fInspeccion.ValueByName[FIELD_FECVENCI];

            LblNumeroOblea.Caption := fInspeccion.GetNumOblea;
        end
        else begin
            LblFechaInspeccion.Caption :=  FormatDateTime('dd/mm/yy',StrToDateTime(fConsulta.FieldByName(FIELD_FECHALTA).AsString));
            LblFechaVencimiento.Caption := fConsulta.FieldByName('VENCIMIENTO').AsString;
            LblNumeroOblea.Caption := fConsulta.FieldByName('OBLEA').AsString;
        end;
    finally
        Close;
        Free;
    end;
end;

procedure TFrmCertificado.QRCertificadoNeedData(Sender: TObject;
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

function TFrmCertificado.GetImprimirInformeInspeccion: boolean;
begin
    Result := fImprimirInformeInspeccion;
end;

procedure TFrmCertificado.SetImprimirInformeInspeccion (const bImprimir: boolean);
begin
    fImprimirInformeInspeccion := bImprimir;
end;


procedure TFrmCertificado.ActivarDesactivar_Componentes (const bActivar: boolean);
var
  i: integer;

begin
    for i := 0 to Self.ComponentCount-1 do
    begin
        if (Self.Components[i].Tag = 1) then
        begin
            if (Self.Components[i] is TQRImage) then
               TQRImage(Self.Components[i]).Enabled := bActivar
            else
               if (Self.Components[i] is TQRLabel) then
                begin
                    // if   not ((TQRLabel(Self.Components[i]).Name='qrLabel1') or (TQRLabel(Self.Components[i]).Name='qrLabel2')  or (TQRLabel(Self.Components[i]).Name='qrLabel3')) then
                       TQRLabel(Self.Components[i]).Enabled := bActivar
               end

            else
              if (Self.Components[i] is TQRShape) then
               TQRShape(Self.Components[i]).Enabled := bActivar
        end;
    end;


end;


procedure TFrmCertificado.ActivarDesactivar_segun_tvoluntaria(const bActivar: boolean);
var
  i: integer;

begin
    for i := 0 to Self.ComponentCount-1 do
    begin
        if (Self.Components[i].Tag = 3) then
        begin


               if (Self.Components[i] is TQRLabel) then
                   TQRLabel(Self.Components[i]).Enabled := bActivar


            else
              if (Self.Components[i] is TQRShape) then
               TQRShape(Self.Components[i]).Enabled := bActivar
        end;
    end;


end;


procedure TFrmCertificado.QRCertificadoAfterPreview(Sender: TObject);
begin
    ImprimirCertificado := (frmPresPreliminar_Auxi.ModalResult = mrOk);
end;

procedure TFrmCertificado.FormDestroy(Sender: TObject);
begin
    if Assigned(fConsulta)
    then begin
        fConsulta.Close;
        fConsulta.Free;
    end;
end;

procedure TFrmCertificado.QRCertificadoBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
    bCertificadoRelleno := False;
end;

end.
