unit UFINVERIGNC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, sqlexpr,
  StdCtrls, Buttons, ExtCtrls, DBCtrls, Grids, DBGrids, DB, Mask,
  USAGCLASSES,UtilOracle,USAGVARIOS,uutils, RxGIF, provider, dbclient;

type

  tResultado = (APTO, RECHAZADO);

  tIZonas = (tPasa, tNopasa, tNoSe);

  tRegZonas = record
    z1: tIzonas;
  end;


  TFrmFinalGNC = class(TForm)
    LabelTMatricula: TLabel;
    LabelTInspector: TLabel;
    Bevel2: TBevel;
    LabelDeficiencias: TLabel;
    BtnCancelar: TBitBtn;
    MemoDeficiencias: TMemo;
    LabelMatricula: TLabel;
    LabelInspector: TLabel;
    LabelApta: TLabel;
    LabelRechazada: TLabel;
    BtnAceptar: TBitBtn;
    Label1: TLabel;
    BtnReiniciar: TBitBtn;
    LabelVencimiento: TLabel;
    Bevel3: TBevel;
    InspeccionesSource: TDataSource;
    Bevel4: TBevel;
    Bevel5: TBevel;
    bPagar: TBitBtn;
    ObleaPanel: TPanel;
    PMeses: TPanel;
    P12: TPanel;
    P11: TPanel;
    P10: TPanel;
    P9: TPanel;
    P8: TPanel;
    P7: TPanel;
    P6: TPanel;
    P5: TPanel;
    P4: TPanel;
    P3: TPanel;
    P2: TPanel;
    P1: TPanel;
    LColor: TLabel;
    BEdtOblea: TMaskEdit;
    LabelTOblea: TLabel;
    LblMarcaModelo: TLabel;
    Bevel6: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Image1: TImage;
    BtnRechazar: TBitBtn;
    procedure BtnReiniciClick(Sender: TObject);
    procedure BEdtObleaKeyPress(Sender: TObject; var Key: Char);
    procedure BtnAceptaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bPagarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnRechazarClick(Sender: TObject);
  private
    iObleaEnVarios : integer;
    TipoGas: string;
    FDataBase: TSQLConnection;
    FInspeccion : TInspGNC;
    FInspecciones: TEstadoInspGNC;
    procedure ObtenerDatosFinales (var aResultado : tResultado);
    procedure ActualizacionNumeroOblea(const iNumero : Integer);
    function FinalizarInspeccion : boolean;
    function GetColor (const aId: integer) : string;
    Function GetDeficienaciasCount: Integer;
    Procedure InspeccionSinOblea;

    Procedure LlenarDatosVehiculo;

  public
    { Public declarations }
    Constructor CreateFromInspeccion(aInspeccion:TEstadoInspGNC);
    procedure RellenarDatosFinales;
  end;

var
    FrmFinalGNC: TFrmFinalGNC;

const
    DEFICIENCIAS = 'DEFICIENCIAS OBSERVADAS: ';
    CADENA_VACIA = '';
    CAD_OK = ' Ok: ';
    NUMERO_COLORES = 6;
    MSJ_PAGAR_PREVERIFICACION = '¿ Desea Pagar La Inspección ?';


implementation

uses
    UFTmp,
    UCDialgs,
    ULOGS,
    UDATEVENGNC,
    UCTIMPRESION,
    UCLIENTE,
    USAGESTACION,
    Globals,
    ufRechazarGNC;

    {$R *.DFM}

const
    FICHERO_ACTUAL = 'UFinVeriGNC.pas';
    COMBUSTIBLE_NAFTA = 'N';
    COMBUSTIBLE_GASOIL = 'L';
    COMBUSTIBLE_GNC = 'G';
    COMBUSTIBLE_MEZCLA = 'M';
    COMBUSTIBLE_NULL = '';


type
    EDatosMalEnTDATOSINSPECC = class (Exception);


function LineaCon ( const sCod, sDes : string) : string;
const
  CADENA_VACIA = '';
begin
  result := sCod;
  result := result +' - '+sDes;
end;


Constructor TFrmFinalGNC.CreateFromInspeccion(aInspeccion: TEstadoInspGNC);
begin
        Inherited Create(Application);
        FDataBase:=aInspeccion.DataBase;
        FInspecciones:=aInspeccion;
        FInspeccion := TInspGNC.CreateFromEstadoInspeccion(fInspecciones);
        FInspeccion.Open;
        FInspeccion.First;
        InspeccionesSource.DataSet:=FInspecciones.DataSet;
        LabelMatricula.Caption := FInspecciones.ValueByName[FIELD_MATRICUL];
        LabelInspector.Caption := FInspeccion.GetInspector;
        LlenarDatosVehiculo;
end;


procedure TFrmFinalGNC.BtnReiniciClick(Sender: TObject);
const
    FACTURADO = 'A';
begin
    //Reinicia la inspeccion
    if FInspecciones.ValueByName[FIELD_ESTADO][1] in ([E_FACTURADO])
    then begin
        Messagedlg(Application.Title,'No se puede reinicar este tipo de verificaciones',mtInformation,[mbok],mbok,0);
        Exit;
    end;
    
    try
        if MessageDlg('PLANTA DE VERIFICACION', 'ESTA VIENDO EL INFORME DEL VEHICULO ' +
                   FInspecciones.ValueByName[FIELD_MATRICUL] + '. SEGURO QUE DESEA CONTINUAR CON LA TAREA DE REINICO ',
                   mtInformation,[mbIgnore, mbCancel], mbIgnore,0) = mrIgnore
        then begin
            InspeccionSinOblea;
            if FInspecciones.Reiniciar
            then begin
                ModalResult := MrOk;
            end
            else begin
                MessageDlg('PLANTA DE VERIFICACION',
                   'EN ESTE MOMENTO NO SE PUEDE EFECTUAR DICHA OPERACIÓN, ESPERE UNOS SEGUNDOS E INTÉNTELO DE NUEVO, SI EL PROBLEMA PERSISTE CONTACTE CON SU DISTRIUBIDOR',
                   mtWarning,[mbOk], mbOk,0);
            end;
        end;
    except
        on E: Exception do
        begin
            fAnomalias.PonAnotacion(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'NO SE PUEDE REINICIAR LA VERIFICACION POR: ' + E.message);
        end;
    end;
end;

procedure TFrmFinalGNC.ActualizacionNumeroOblea(const iNumero : Integer);
var
    iObleaParaVarios : integer;
begin
     if iNumero = iObleaEnVarios
     then iObleaParaVarios := iObleaEnVarios + 1
     else iObleaParaVarios := iObleaEnVarios;

     fVarios.Edit;
     if Copy(LabelVencimiento.Caption,7,4) = Copy(DateBD(FDataBase),7,4)
     then fVarios.ValueByName[FIELD_NUMOBLEAGNC] := IntToStr(iObleaParaVarios)
     else fVarios.ValueByName[FIELD_NUMOBLEAGNCB] := IntToStr(iObleaParaVarios);
     fVarios.Post(true);
end;


procedure TFrmFinalGNC.BEdtObleaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = chr(Vk_Return) then begin
     key := #0;
     perform(WM_NEXTDLGCTL,0,0);
  end;
end;

(*function TFrmFinal.NumeroDeObleaCorrecto(var iNumeroDeOblea : integer) : Boolean;
begin
  result := True;
  try
    iNumeroDeOblea := StrToInt(BEdtOblea.Text);
    if iNumeroDeOblea <> iObleaEnVarios then
      if MessageDlg('NUMERO DE OBLEA',
                    'EL Número de Oblea introducido NO sigue la secuencia de números establecida, pero podrá modificarlo con el mantenimiento de datos',
                    mtWarning, [mbIgnore, mbCancel], mbIgnore, 0) = mrCancel then result := False;


  except
    on E : Exception do
    begin
        result := False;
        If Not (FInspecciones.ValueByName[FIELD_TIPO][1] in ([T_GRATUITA,T_PREVERIFICACION]))
        Then MessageDlg('NUMERO DE OBLEA', 'EL NUMERO DE OBLEA INTRODUCIDO NO ES CORRECTO', mtWarning, [mbOk], mbOk,0);
    end;
  end;
end;
*)


procedure TFrmFinalGNC.BtnAceptaClick(Sender: TObject);
var
    UnaCabecera : tCabecera;
begin
    try
        if FinalizarInspeccion then
        begin
            if not (LabelRechazada.visible) then
            begin
              UnaCabecera.iEjercicio := StrToInt(Finspecciones.ValueByName[FIELD_EJERCICI]);
              UnaCabecera.iCodigoInspeccion := StrToInt(FInspecciones.ValueByName[FIELD_CODINSPGNC]);
              UnaCabecera.sMatricula := FInspecciones.ValueByName[FIELD_MATRICUL];
              {$B-}
              if (TrabajoEnviadoOk (UnaCabecera, tAmarilla))
              and  (TrabajoEnviadoOk (UnaCabecera, InformeGNC))then
              begin
              end
              else showmessage('IMPRESION DE INFORMES', 'Los Informes enviados a impresora, no se han impreso. Vuélvalo a intentar con el menú de Reimpresiones');
            end;
        end;
        ModalResult := mrOk;
    except
        on E : Exception do
        begin
            MessageDlg('ACEPTAR INSPECCION',
                 'SE HA PRODUCIDO UN ERROR GRAVE CONTACTE CON SU DISTRIBUIDOR SI EL PROBLEMA PERSISTE', mtError, [mbOK], mbOk,0);
            fIncidencias.PonAnotacion(TRAZA_SIEMPRE,12, FICHERO_ACTUAL,
                                'ERROR MUY RARO AL ACEPTAR LA INSPECCION DEL VEHICULO ' +
                                 FInspecciones.ValueByName[FIELD_MATRICUL] + ' POR:' + E.message);

        end;
    end;
end;

function TFrmFinalGNC.FinalizarInspeccion : boolean;
    function TrimDust(const s: string) : string;
    var
        i: integer;
    begin
        result := '';
        for i:=1 to length(s) do
            if s[i] in ['0'..'9']
            then result := result + s[i];
    end;
var
    AntiguoDateSeparator : char;
    aQ: TSQLQuery;
    aResultado : string;
begin
    aQ:=TSQLQuery.Create(self);
    aQ.SQLConnection:=FInspeccion.Database;

    AntiguoDateSeparator := DateSeparator;
    result := True;
    try
        DateSeparator := '/';
        if not LabelRechazada.Visible
        then begin
            try
                FInspeccion.START;
                if not(LabelRechazada.Visible)
                then ActualizacionNumeroOblea(StrToInt(Trim(BEdtOblea.Text)));

                if LabelApta.Visible
                then aResultado := INSPECCION_APTA;

                fInspeccion.Edit;
                fInspeccion.ValueByName[FIELD_RESULTADO] := aResultado;
                fInspeccion.ValueByName[FIELD_INSPFINA] := INSPECCION_FINALIZADA;
                fInspeccion.ValueByName[FIELD_HORFINAL] := DateTimeBD(FInspeccion.DataBase);
                fInspeccion.ValueByName[FIELD_FECHVENCI] := LabelVencimiento.Caption;
                If ObleaPanel.Visible
                then
                    FInspeccion.ValueByName[FIELD_OBLEANUEVA] := inttostr(strtoint(Trim(BEdtOblea.Text)));
                fInspeccion.Post(true);
                
                if not(LabelRechazada.Visible)
                then ActualizacionNumeroOblea(StrToInt(Trim(BEdtOblea.Text)));

                with aQ do
                begin
                    SQL.Add (Format('DELETE ESTADOINSPGNC WHERE EJERCICI = %S AND CODINSPGNC =%S', [FInspecciones.ValueByName[FIELD_EJERCICI], FInspecciones.ValueByName[FIELD_CODINSPGNC]]));
                    {$IFDEF TRAZAS}
                    fTrazas.PonComponente(TRAZA_SQL,96,FICHERO_ACTUAL,aQ);
                    {$ENDIF}
                    ExecSql;
                end;
                fInspeccion.COMMIT;
            except
                on E : Exception do
                begin
                    fInspeccion.ROLLBACK;
                    Result := FALSE;
                    fIncidencias.PonAnotacion(TRAZA_SIEMPRE,13,FICHERO_ACTUAL,'ERROR AL FINALIZAR LA INSPECCION DEL VEHICULO: ' +
                                    FInspecciones.ValueByName[FIELD_MATRICUL] + ' POR: ' +
                                    E.message);
                    MessageDlg('FINALIZACION DE INSPECCION', 'NO PUEDE REALIZAR DICHA OPERACION EN ESTOS MOMENTOS, ' +
                              'SI EL PROBLEMA PERSISTE CONTACTE CON SU DISTRIBUDIOR', mtInformation, [mbOk], mbOk,0);
                end;
            end;
        end
        else begin
            try
                FInspeccion.START;

                fInspeccion.Edit;
                fInspeccion.ValueByName[FIELD_RESULTADO] := INSPECCION_RECHAZADO;
                fInspeccion.ValueByName[FIELD_INSPFINA] := INSPECCION_FINALIZADA;
                fInspeccion.ValueByName[FIELD_HORFINAL] := datetimetostr(GetDateTimePure(MyBD));
                fInspeccion.ValueByName[FIELD_FECHVENCI] := '';
                fInspeccion.Post(true);


                with aQ do
                begin
                    SQL.Add (Format('DELETE ESTADOINSPGNC WHERE EJERCICI = %S AND CODINSPGNC =%S', [FINspecciones.ValueByName[FIELD_EJERCICI], FINspecciones.ValueByName[FIELD_CODINSPGNC]]));
                    {$IFDEF TRAZAS}
                    fTrazas.PonComponente(TRAZA_SQL,98,FICHERO_ACTUAL,aQ);
                    {$ENDIF}
                    ExecSql;
                end;
                fInspeccion.COMMIT;
            except
                on E : Exception do
                begin
                    fInspeccion.ROLLBACK;
                    result := FALSE;
                    fIncidencias.PonAnotacion(TRAZA_SIEMPRE,14,FICHERO_ACTUAL,'ERROR AL FINALIZAR LA INSPECCION DEL VEHICULO: ' +
                                  Finspecciones.ValueByName[FIELD_MATRICUL] + ' POR: ' +
                                  E.message);
                    MessageDlg('FINALIZACION DE INSPECCION', 'NO PUEDE REALIZAR DICHA OPERACION EN ESTOS MOMENTOS, ' +
                         'SI EL PROBLEMA PERSISTE CONTACTE CON SU DISTRIBUDIOR', mtError, [mbOk], mbOk,0);
                end;
            end;
        end;
    finally
        DateSeparator := AntiguoDateSeparator;
        aQ.Close;
        aQ.Free;
    end;
end;

procedure TFrmFinalGNC.RellenarDatosFinales;
var
  Resultado : tResultado;
  Tipo: Char;
begin
    try

        Try
            Tipo:=FInspecciones.ValueByName[FIELD_TIPO][1];
        Except
            on E: Exception do
            begin
                fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL,'El tipo de la inspeccion es desconocido: %S',[E.message]);
                Tipo:=E_RECIBIDO_NOK;
            end;
        end;

        ObtenerDatosFinales (Resultado);

        case Resultado of
            APTO:
            begin
                LabelApta.Visible := True;
                LabelVencimiento.Caption := FormatDateTime('dd/mm/yyyy', dNuevaFechaDeVencimiento (StrToInt(FInspeccion.ValueByName[FIELD_CODEQUIGNC]), FDataBase, INSPECCION_APTA,Tipo));
            end;

            RECHAZADO:
            begin
                LabelRechazada.Visible := True;
                //BEdtOblea.Enabled := False;
                ObleaPanel.Visible:=False;
                ObleaPanel.Enabled:=False;
                BEdtOblea.Clear;
                BEdtOblea.Color := clInactiveBorder;
                LabelVencimiento.Caption := FormatDateTime('dd/mm/yyyy',dNuevaFechaDeVencimiento (StrToInt(FInspeccion.ValueByName[FIELD_CODEQUIGNC]), FDataBase, INSPECCION_RECHAZADO,Tipo ));
            end;
        end;


        LColor.Caption := GetColor(StrToInt(Copy(LabelVencimiento.Caption,7,4)) mod NUMERO_COLORES);

        case StrToInt(Copy(LabelVencimiento.Caption,4,2)) of
            1: P1.Color := clAqua;
            2: P2.Color := clAqua;
            3: P3.Color := clAqua;
            4: P4.Color := clAqua;
            5: P5.Color := clAqua;
            6: P6.Color := clAqua;
            7: P7.Color := clAqua;
            8: P8.Color := clAqua;
            9: P9.Color := clAqua;
            10: P10.Color := clAqua;
            11: P11.Color := clAqua;
            12: P12.Color := clAqua
        end;

        LabelDeficiencias.Caption :=  DEFICIENCIAS + IntToStr(GetDeficienaciasCount);

    except
        on E : Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,11, FICHERO_ACTUAL, 'Error finalizando la inspeccion de %d, %d por: %s',
                                     [FInspeccion.ValueByName[FIELD_EJERCICI], FInspeccion.ValueByName[FIELD_CODINSPE], E.message]);
            raise;
        end;
    end;
end;

procedure TFrmFinalGNC.ObtenerDatosFinales (var aResultado : tResultado);
const
  DEFECTO_GRAVE = '3';
  SALTADA = '¡ SALTADA !';
  INCOMPLETA = 'INCOMPLETA';
  COMPLETA = 'COMPLETA';
var
  i : integer;
  iDefectosGraves : integer;
  aq: TSQLDataSet;
  dsp : tDatasetprovider;
  cds : tClientDataSet;

begin
    MemoDeficiencias.Lines.Clear;

    iDefectosGraves := 0;

      aQ := TSQLDataSet.Create(self);
      aQ.SQLConnection := fDataBase;
      aQ.CommandType := ctQuery;
      aQ.GetMetadata := false;
      aQ.NoMetadata := true;
      aQ.ParamCheck := false;

      dsp := TDataSetProvider.Create(self);
      dsp.DataSet := aQ;
      dsp.Options := [poIncFieldProps,poAllowCommandText];

      cds:=TClientDataSet.Create(self);
    with CDS do
    try
        SetProvider(dsp);
        Close;
        CommandText:=(Format(' SELECT D.EJERCICI EJERCICI, D.CODINSPGNC CODINSPGNC, D.CODDEFEC CODDEFEC,    ' +
                       '       T.DESCRIPCION LITDEFEC                                                   ' +
                       ' FROM                                                                           ' +
                       '   INSPGNC_DEFECTOS D, DEFECTOSGNC  T                                             ' +
                       ' WHERE                                                                          ' +
                       '   D.CODDEFEC = T.CODDEFEC   AND                                                ' +
                       '   D.EJERCICI = %S AND                                                          ' +
                       '   D.CODINSPGNC = %S                                                            ',
                       [ fInspeccion.ValueByName[FIELD_EJERCICI],fInspeccion.ValueByName[FIELD_CODINSPGNC]]));

        {$IFDEF TRAZAS}
        fTrazas.PonComponente(TRAZA_SQL,90,FICHERO_ACTUAL,aQ);
        {$ENDIF}

        Open;

        for i := 1 to RecordCount do
        begin
            {$IFDEF TRAZAS}
            fTrazas.PonRegistro(TRAZA_REGISTRO,91,FICHERO_ACTUAL,aQ);
            {$ENDIF}

            inc(iDefectosGraves, 1);

            MemoDeficiencias.Lines.Add(LineaCon(FIELDS[2].ASSTRING, FIELDS[3].ASSTRING));
            Next;
        end;
    finally
          close;
          Free;
          dsp.Free;
          aQ.close;
          aQ.free;
    end;

    if iDefectosGraves <> 0
    then aResultado := RECHAZADO
    else aResultado := APTO;


end;

procedure TFrmFinalGNC.FormCreate(Sender: TObject);
begin

    LabelApta.Visible := False;
    LabelRechazada.Visible := False;

    BEdtOblea.Color := clWindow;
    BEdtOblea.Enabled := True;

    LabelDeficiencias.Caption := DEFICIENCIAS;

end;


procedure TFrmFinalGNC.FormDestroy(Sender: TObject);
begin
    FInspeccion.Free;
end;


function TFrmFinalGNC.GetColor (const aId: integer) : string;
begin
    with tSQLQuery.Create(self) do
    try
        SQLConnection:= fDataBase;

        SQL.Add(Format('SELECT NOMCOLOR FROM COLORESGNC WHERE CODCOLOR# = %d', [aId]));
        Open;
        Result := Fields[0].AsString;
    finally
        Close;
        Free;
    end
end;

Function TFrmFinalGNC.GetDeficienaciasCount: Integer;
var
    ii: Integer;
begin
    //Cuenta el numero de deficiencias encontradas
    Result:=0;
    for ii := 0 to MemoDeficiencias.Lines.Count-1 do
    begin
        If pos(CAD_OK,MemoDeficiencias.Lines[ii])=0 then Inc(Result);
    end;

end;


procedure TFrmFinalGNC.bPagarClick(Sender: TObject);
var
    aQ: TSQLQuery;
begin
    //Paga una inspección gnc
    If Messagedlg(Caption,MSJ_PAGAR_PREVERIFICACION,mtConfirmation,[mbyes,mbno],mbno,0)=mrYes
    then begin
        try
            try
                fInspeccion.START;

                FInspeccion.Edit;
                FInspeccion.ValueByName[FIELD_TIPO]:=Chr(Ord(fvGNCRPAOK) +65);
                FInspeccion.Post(true);

                aQ:=TSQLQuery.Create(self);
                with aQ do
                Try
                    SQL.Clear;
                    SQLConnection:=FInspeccion.DataBase;

                    SQL.Add (Format('UPDATE ESTADOINSPGNC SET ESTADO = ''%S'' WHERE EJERCICI = %S AND CODINSPGNC = %S',
                                   [E_PENDIENTE_FACTURAR, FInspecciones.ValueByName[FIELD_EJERCICI], FInspecciones.ValueByName[FIELD_CODINSPGNC]]));
                    ExecSql;
                    {$IFDEF TRAZAS}
                    fTrazas.PonAnotacion(TRAZA_FLUJO,0,FICHERO_ACTUAL,'Actualización del estado de inspección');
                    fTrazas.PonComponente(TRAZA_SQL,0,FICHERO_ACTUAL,aQ);
                    {$ENDIF}
                finally
                    Free
                end;
                fInspeccion.COMMIT;
            except
                on E: Exception do
                begin
                    fInspeccion.ROLLBACK;
                    fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL,'No se pudo poner la preverificacion a facturar por: %S',[E.message]);
                    MessageDlg('Facturación de Preverificaciones.','Ocurrió un error mientras se intentó enviar a facturar la preverificacion. Intentelo de nuevo y si persiste el error, indíquelo al jefe de planta.', mtInformation,[mbOk],mbOk,0);
                end;
            end;
        finally
            FInspecciones.Refresh;
            ModalResult:=mrCancel;
        end;
    end;
end;

procedure TFrmFinalGNC.BtnCancelarClick(Sender: TObject);
begin
    //calcelacion de la inspeccion
    InspeccionSinOblea;
    ModalResult:=mrCancel;
end;

Procedure TFrmFinalGNC.InspeccionSinOblea;
begin
    //elimina el numero de oblea
    FInspeccion.Edit;
    FInspeccion.ValueByName[FIELD_OBLEANUEVA]:='';
    FInspeccion.Post(true);
end;

procedure TFrmFinalGNC.FormActivate(Sender: TObject);
var
  sOblea, Fecha: String;
begin
        RellenarDatosFinales;
        Application.ProcessMessages;
        If ((Not (FInspeccion.ValueByName[FIELD_TIPO][1] in ([T_GNCRPA, T_GNCRC]))) and
            (not(LabelRechazada.Visible)))
        Then begin
            // Inicializacion del numero de oblea;

            Fecha:=DateBd(FDataBase);
            if Copy(LabelVencimiento.Caption,7,4) = Copy(Fecha,7,4)
            then iObleaEnVarios := FVarios.NUMOBLEAGNC
            else iObleaEnVarios := FVarios.NUMOBLEAGNCB;

            // Sobreescritura del numero de oblea si la inspeccion ya tiene uno.
            sOblea:=FInspeccion.GetNumOblea;
            if not (sOblea='')
            then BEdtOblea.Text := sOblea
            else begin
                BEdtOblea.Text :=FormatoCeros(iObleaEnVarios,8);
                Application.ProcessMessages;
                FInspeccion.Edit;
                FInspeccion.ValueByName[FIELD_OBLEANUEVA]:=inttostr(strtoint(Trim(BEdtOblea.Text)));
                FInspeccion.Post(true);
                FInspeccion.Refresh;
            end;
        end;

        if ((FInspecciones.ValueByName[FIELD_ESTADO] = E_RECIBIDO_OK)
          and LabelRechazada.visible) or (FInspecciones.ValueByName[FIELD_ESTADO] = E_FACTURADO) Then
        begin
          BtnAceptar.Enabled := true;
        end;

        If (FInspecciones.ValueByName[FIELD_ESTADO] = E_RECIBIDO_OK)
          and LabelApta.visible Then
          begin
            if StrToDate(LabelVencimiento.Caption) <= (StrToDate(DateBD(MyBD))+182) then
            begin
               MessageDlg('FINALIZACION DE INSPECCION', 'No se puede otorgar oblea a un cilindro con fecha de vencimiento '+LabelVencimiento.Caption, mtError, [mbOk], mbOk,0);
               bPagar.Enabled:=false;
               BtnAceptar.Enabled := false;
            end
            else bPagar.Enabled:=True;
          end;

        If FInspecciones.ValueByName[FIELD_ESTADO] <> E_FACTURADO
        Then begin
            ObleaPanel.Enabled:=False;
            ObleaPanel.Visible:=False;
        end;
end;

procedure TFrmFinalGNC.LlenarDatosVehiculo;
var fVehiculo: tvehiculo;
begin
  fVehiculo := nil;
  try
    fVehiculo := finspeccion.GetVehiculo;
    fVehiculo.open;
    TipoGas := fVehiculo.Valuebyname[FIELD_TIPOGAS];
    with tsqlquery.create(self) do
      try
        SQLConnection:=mybd;
        sql.Add(FORMAT('SELECT NOMMARCA FROM TMARCAS WHERE CODMARCA = %S',[fVehiculo.valuebyname[FIELD_CODMARCA]]));
        open;
        LblMarcaModelo.caption := copy(fields[0].asstring,1,12);
        close;
        sql.Clear;
        sql.Add(FORMAT('SELECT NOMMODEL FROM TMODELOS WHERE CODMODEL = %S',[fVehiculo.valuebyname[FIELD_CODMODEL]]));
        open;
        LblMarcaModelo.caption :=LblMarcaModelo.caption + ' - ' + copy(fields[0].asstring,1,12);
      finally
        free;
      end;
  finally
    fVehiculo.close;
    fVehiculo.Free;
  end;
end;


procedure TFrmFinalGNC.BtnRechazarClick(Sender: TObject);
var resultado : integer;
begin
    if FInspecciones.ValueByName[FIELD_ESTADO][1] in ([E_FACTURADO])
    then begin
        Messagedlg(Application.Title,'No se puede rechazar este tipo de verificaciones',mtInformation,[mbok],mbok,0);
        Exit;
    end;
    try
        with TfrmRechazarGNC.CreateFromBD (fInspeccion, fInspecciones) do
        try
            if Execute then  resultado := MrOk
            else exit;
        finally
            Free;
        end;
        ModalResult := resultado;
    except
        on E: Exception do
        begin
            fAnomalias.PonAnotacion(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'NO SE PUEDE RECHAZAR LA VERIFICACION POR: ' + E.message);
        end;
    end;
end;

end.//Final de la unidad


