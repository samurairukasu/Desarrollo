unit UFinVeri;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, sqlExpr,
  StdCtrls, Buttons, ExtCtrls, DBCtrls, Grids, DBGrids, DB, Mask,
  USAGCLASSES,UtilOracle,USAGVARIOS, uUtils, Provider, DBClient, ADODB;

type

  tResultado = (APTO, CONDICIONAL, RECHAZADO);

  tIZonas = (tPasa, tNopasa, tNoSe);

  tRegZonas = record
    z1, z2, z3 : tIzonas;
  end;

  tRegMediciones = record
    efs, efe, da1, da2, de1, co2, kme, fx1, fx2 : tIzonas;
  end;

  TFrmFinal = class(TForm)
    LabelTMatricula: TLabel;
    CheckBaja: TCheckBox;
    LabelTInspector: TLabel;
    Bevel2: TBevel;
    LabelDeficiencias: TLabel;
    BtnCancelar: TBitBtn;
    MemoDeficiencias: TMemo;
    LabelMatricula: TLabel;
    LabelInspector: TLabel;
    LabelApta: TLabel;
    LabelCondicional: TLabel;
    LabelRechazada: TLabel;
    BtnAceptar: TBitBtn;
    Label1: TLabel;
    BtnReiniciar: TBitBtn;
    LabelVencimiento: TLabel;
    Bevel3: TBevel;
    Panel1: TPanel;
    Panel3: TPanel;
    PZ3: TPanel;
    PZ1: TPanel;
    PZ2: TPanel;
    bStandBy: TBitBtn;
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
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    pda1: TPanel;
    pkme: TPanel;
    pde1: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    pefs: TPanel;
    pefe: TPanel;
    pda2: TPanel;
    pco2: TPanel;
    dsDatinspecc: TDataSource;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    LblMarcaModelo: TLabel;
    Bevel6: TBevel;
    Label2: TLabel;
    lblFabricado: TLabel;
    Bevel7: TBevel;
    pfx1: TPanel;
    pfx2: TPanel;
    Panel15: TPanel;
    Panel20: TPanel;
    Label23: TLabel;
    Bevel1: TBevel;
    LabelTipo: TLabel;
    Bevel8: TBevel;
    InpePanel: TPanel;
    lblNroInspe: TLabel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel21: TPanel;
    Panel22: TPanel;
    I1: TPanel;
    I2: TPanel;
    I3: TPanel;
    procedure BtnReiniciClick(Sender: TObject);
    procedure CheckBajaClick(Sender: TObject);
    procedure BEdtObleaKeyPress(Sender: TObject; var Key: Char);
    procedure BtnAceptaClick(Sender: TObject);
    procedure bStandByClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bPagarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BEdtObleaChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    iObleaEnVarios : integer;
    TipoGas: string;
    FDataBase: TSQLConnection;
    FInspeccion : TInspeccion;
    FInspecciones: TEstadoInspeccion;
    FDatInspecc : TDatinspecc; //
    procedure ObtenerDatosFinales (var aResultado : tResultado);
    procedure ActualizacionNumeroOblea(const iNumero : Integer);
    function FinalizarInspeccion : boolean;
    function GetColor (const aId: integer) : string;
    Function GetDeficienaciasCount: Integer;
    Procedure InspeccionSinOblea;
    Function GetStandByEnabled:Boolean;
    function PasaPorZonas : tRegZonas;
    Function FormatNumOblea(Cad:Integer):String;

    Procedure LlenarDatosVehiculo;
    Function ValoresMedicion : tRegMediciones;
    procedure PintaPanelesMedicion(aMediciones: tRegMediciones);

  public
    { Public declarations }
    Constructor CreateFromInspeccion(aInspeccion:TEstadoInspeccion);
    procedure RellenarDatosFinales;
    function ObtenerReenvio(Cod_Inspeccion: String):Boolean; //Lucho
    Procedure InsertarReenvio(Cod_Inspeccion: String);       //Lucho
    Function Encontrar_Auditoria(sInspeccion, sEjercicio: String): Boolean; // Lucho
  end;

var
    FrmFinal: TFrmFinal;
    vObleas, vAnioVenci: Integer;
    vObleaAsig: String;
    Imprimio: Boolean = false;

const
    DEFICIENCIAS = 'DEFICIENCIAS OBSERVADAS: ';
    CADENA_VACIA = '';
    CAD_OK = ' Ok: ';
    NUMERO_COLORES = 6;
    MSJ_PAGAR_PREVERIFICACION = '¿ Desea Pagar La Preverificación Para Obtener Validez Oficial ?';


implementation

uses
    UFTmp,
    UCDialgs,
    ULOGS,
    UDATEVEN,
    UCTIMPRESION,
    UCLIENTE,
    USAGESTACION,
    UCTEVERIFICACIONES,
    Globals,
    ufMedicionesAutomaticas,
    ucomunic;

    {$R *.DFM}

const
    FICHERO_ACTUAL = 'UFinVeri.pas';
    COMBUSTIBLE_NAFTA = 'N';
    COMBUSTIBLE_GASOIL = 'L';
    COMBUSTIBLE_GNC = 'G';
    COMBUSTIBLE_MEZCLA = 'M';
    COMBUSTIBLE_NULL = '';


type
    EDatosMalEnTDATOSINSPECC = class (Exception);



function TFrmFinal.ObtenerReenvio(Cod_Inspeccion: String):Boolean;
var
TraeDatos:TSQLQuery;
begin
TraeDatos:=TSQLQuery.Create(nil);
  with TraeDatos do
    begin
    SQLConnection:=mybd;
    SQL.Add('SELECT COUNT (*) FROM TREENVIOLINEA WHERE CODINSPE = :COD_INSPECCION AND ESTADO IS NULL ORDER BY FECHALTA');
    ParamByName('COD_INSPECCION').Value:=Cod_Inspeccion;
      try
        Open;
        if (Fields[0].Value <> 0) then
        Result:=true;
      finally
        Close;
        Free;
      end;
    end;
end;


Procedure TFrmFinal.InsertarReenvio(Cod_Inspeccion: String);
var
TraeDatos:TSQLQuery;
begin
TraeDatos:=TSQLQuery.Create(nil);
  with TraeDatos do
  try
    begin
    SQLConnection:=mybd;
    SQL.Clear;
    SQL.Add('INSERT INTO TREENVIOLINEA (CODINSPE, FECHALTA) VALUES (:Cod_Inspeccion, SYSDATE)');
    ParamByName('COD_INSPECCION').Value:=Cod_Inspeccion;
    ExecSQL;
    {$IFDEF TRAZAS}
    FTrazas.PonAnotacion(TRAZA_SIEMPRE,300,FICHERO_ACTUAL,'**********************************************************************************************');
    FTrazas.PonAnotacion(TRAZA_USUARIO,300,FICHERO_ACTUAL,'***  Se inserto el valor "104" en la campo 10002 para la inspeccion Nº '+Cod_Inspeccion+'    ***');
    FTrazas.PonAnotacion(TRAZA_SIEMPRE,300,FICHERO_ACTUAL,'**********************************************************************************************');
    {$ENDIF}
    end;
  finally
    Free;
  end;
end;


Function TFrmFinal.Encontrar_Auditoria(sInspeccion, sEjercicio: String): Boolean;
var
Total: Integer;
Begin
Result:=false;
With TsqlQuery.Create(nil) do
  Begin
  SQLConnection:=mybd;
  SQL.Add('SELECT COUNT(CODINSPE) AS TOTAL FROM TAUDITORIAINSPECCIONES WHERE CODINSPE = :CODINSPE AND EJERCICI = :EJERCICI');
  Params[0].Value:=sInspeccion;
  Params[1].Value:=sEjercicio;
  Open;
  Total:=Fields[0].Value;
    try
      If (Total>=1) then
      Result:=true;
    finally
      Free;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////


function LineaCon ( const sCod, sDes, sOk, sDl, sDg : string) : string;
const
  CADENA_VACIA = '';
begin
  result := sCod;
  If sOK <>  CADENA_VACIA
  then begin
    result := result + CAD_OK ;
  end
  else begin
        if (sDl = CADENA_VACIA) and (sDg = CADENA_VACIA) then result := result + ' OBS: '
        else if sDl <> CADENA_VACIA then result := result + ' DL: '
            else result := result + ' DG: ';
  end;
  result := result + sDes;
end;


Constructor TFrmFinal.CreateFromInspeccion(aInspeccion: TEstadoInspeccion);
begin
    //Crera el forma a partir de los datos de un ESTADOINSPECCION seleccionado previamente
    Screen.Cursor:=crHourGlass;
    FTmp.Temporizar(True,True,'Verificación','Iniciando Inspección en Linea.'+#13#10+'Aguarde un momento por favor...');
    try
        Inherited Create(nil);
        FDataBase:=aInspeccion.DataBase;
        FInspecciones:=aInspeccion;
        FInspeccion := TInspeccion.CreateFromEstadoInspeccion(fInspecciones);
        FInspeccion.Open;
        FInspeccion.First;
        InspeccionesSource.DataSet:=FInspecciones.DataSet;
        LabelMatricula.Caption := FInspecciones.ValueByName[FIELD_MATRICUL];
        LabelInspector.Caption := FVarios.ValueByName[FIELD_NOMRESPO];
        LlenarDatosVehiculo;
        RellenarDatosFinales;
    Finally
        FTmp.Temporizar(False,True,'','');
        Screen.Cursor:=crDefault;
    end;
end;


procedure TFrmFinal.BtnReiniciClick(Sender: TObject);
const
FACTURADO = 'A';
var
sMensaje: string;
begin
//Reinicia la inspeccion
If ExisteEnMAHA(FInspecciones.ValueByName[FIELD_MATRICUL]) then
  Exit;

If FInspecciones.ValueByName[FIELD_ESTADO][1] in ([E_PENDIENTE_FACTURAR]) then
  begin
    Messagedlg(Application.Title,'No se puede reinicar este tipo de verificaciones',mtInformation,[mbok],mbok,0);
    Exit;
  end;

With FInspecciones do
  Begin
    try
      if MessageDlg('PLANTA DE VERIFICACION', 'ESTA VIENDO EL INFORME DEL VEHICULO '+ValueByName[FIELD_MATRICUL] + '.'+#13#10+
                    '¿SEGURO QUE DESEA CONTINUAR CON LA TAREA DE REINICO?', mtInformation,[mbIgnore, mbCancel], mbIgnore,0) = mrIgnore then
        Begin
        InspeccionSinOblea;
        ModalResult := MrOk;
     
        If Encontrar_Auditoria(ValueByName[FIELD_CODINSPE], ValueByName[FIELD_EJERCICI]) then
          Begin
            InsertarReenvio(ValueByName[FIELD_CODINSPE]);
            With TSQLQuery.Create(nil) do
              try
                Close;
                SQL.Clear;
                SQLConnection:=mybd;
                SQL.Add('UPDATE TESTADOINSP SET ESTADO = ''A'' WHERE CODINSPE = :CODINSPE AND EJERCICI = :EJERCICI');
                Params[0].Value:=ValueByName[FIELD_CODINSPE];
                Params[1].Value:=ValueByName[FIELD_EJERCICI];
                ExecSQL;
              finally
                free;
              end;
          end
        else
          if Reiniciar then
            InsertarReenvio(ValueByName[FIELD_CODINSPE])
          else
            MessageDlg('PLANTA DE VERIFICACION','EN ESTE MOMENTO NO SE PUEDE EFECTUAR DICHA OPERACIÓN, ESPERE UNOS SEGUNDOS E INTÉNTELO DE NUEVO, SI EL PROBLEMA PERSISTE CONTACTE CON SU DISTRIUBIDOR', mtWarning,[mbOk], mbOk,0);
      end;
////////////////////////////////////////////////////////////////////////////////////////////////////
    except
      on E: Exception do
        begin
          fAnomalias.PonAnotacion(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'NO SE PUEDE REINICIAR LA VERIFICACION POR: ' + E.message);
        end;
    end;
  end;
end;


procedure TFrmFinal.ActualizacionNumeroOblea(const iNumero : Integer);
var
iObleaParaVarios : integer;
begin
if iNumero = iObleaEnVarios then
  iObleaParaVarios := iObleaEnVarios + 1
else
  iObleaParaVarios := iObleaEnVarios;

fVarios.Edit;
if Copy(LabelVencimiento.Caption,7,4) = Copy(DateBD(FDataBase),7,4) then
  fVarios.ValueByName[FIELD_NUMOBLEA] := IntToStr(iObleaParaVarios)
else
  fVarios.ValueByName[FIELD_NUMOBLEAB] := IntToStr(iObleaParaVarios);
fVarios.Post(true);
end;


procedure TFrmFinal.CheckBajaClick(Sender: TObject);
begin
  {$B-}
  if (CheckBaja.Checked ) and ( MessageDlg('BAJA DE VEHICULOS', 'EL VEHÍCULO ' +Finspecciones.ValueByName[FIELD_MATRICUL] +' VA HA SER DADO DE BAJA. ¿ DESEA CONTINUAR ?',
     mtInformation, [mbCancel, mbIgnore], mbCancel, 0) = mrIgnore ) then
     CheckBaja.Checked := True
  else
    CheckBaja.Checked := False;
end;


procedure TFrmFinal.BEdtObleaKeyPress(Sender: TObject; var Key: Char);
begin
if key = chr(Vk_Return) then
  begin
    key := #0;
    perform(WM_NEXTDLGCTL,0,0);
  end;
end;


procedure TFrmFinal.BtnAceptaClick(Sender: TObject);
var
UnaCabecera : tCabecera;
vObleaAsig: String;
begin
try
BtnAceptar.Enabled:=false;
  Begin
    if FinalizarInspeccion then
      begin
        UnaCabecera.iEjercicio := StrToInt(Finspecciones.ValueByName[FIELD_EJERCICI]);
        UnaCabecera.iCodigoInspeccion := StrToInt(FInspecciones.ValueByName[FIELD_CODINSPE]);
        UnaCabecera.sMatricula := FInspecciones.ValueByName[FIELD_MATRICUL];
        Imprimio:= true;
        if fInspeccion.ValueByName[FIELD_TIPO][1] in [T_NORMAL, T_REVERIFICACION, T_VOLUNTARIA, T_VOLUNTARIAREVERIFICACION] then
          begin
            if not LabelRechazada.Visible then
              begin
                {$B-}
                if (TrabajoEnviadoOk (UnaCabecera, Certificado))  and (TrabajoEnviadoOk (UnaCabecera, Informe)) then
                  begin
                    if (fInspeccion.ValueByName[FIELD_TIPO][1] in [T_NORMAL, T_VOLUNTARIA]) and (fVarios.ActivarInfMediciones = OP_ACTIVA) then
                      if not TrabajoEnviadoOk(UnaCabecera, Medicion) then
                        showmessage('IMPRESION DE INFORMES', 'Los Informes enviados a impresora, no se han impreso. Vuélvalo a intentar con el menú de Reimpresiones');
                  end
                else
                  showmessage('IMPRESION DE INFORMES', 'Los Informes enviados a impresora, no se han impreso. Vuélvalo a intentar con el menú de Reimpresiones');
              end
            else
              if TrabajoEnviadoOk (UnaCabecera, Informe) then
                begin
                  if (fInspeccion.ValueByName[FIELD_TIPO][1] in [T_NORMAL, T_VOLUNTARIA]) and (fVarios.ActivarInfMediciones = OP_ACTIVA) then
                    if not TrabajoEnviadoOk(UnaCabecera, Medicion) then
                      showmessage('IMPRESION DE INFORMES', 'Los Informes enviados a impresora, no se han impreso. Vuélvalo a intentar con el menú de Reimpresiones');
                end
              else
                showmessage('IMPRESION DE INFORMES', 'Los Informes enviados a impresora, no se han impreso. Vuélvalo a intentar con el menú de Reimpresiones');
          end
        else
          begin
            if not TrabajoEnviadoOk (UnaCabecera, Informe)then
              showmessage('IMPRESION DE INFORMES', 'Los Informes enviados a impresora, no se han impreso. Vuelvalo a intentar con el menú de Reimpresiones')
            else
              begin
                if fVarios.ActivarInfMediciones = OP_ACTIVA then
                  if not TrabajoEnviadoOk(UnaCabecera, Medicion) then
                    showmessage('IMPRESION DE INFORMES', 'Los Informes enviados a impresora, no se han impreso. Vuélvalo a intentar con el menú de Reimpresiones');
              end;
          end;
      end;
      ModalResult := mrOk
    end
  except
      on E : Exception do
      begin
          MessageDlg('ACEPTAR INSPECCION','SE HA PRODUCIDO UN ERROR GRAVE CONTACTE CON SU DISTRIBUIDOR SI EL PROBLEMA PERSISTE', mtError, [mbOK], mbOk,0);
          fIncidencias.PonAnotacion(TRAZA_SIEMPRE,12, FICHERO_ACTUAL,'ERROR MUY RARO AL ACEPTAR LA INSPECCION DEL VEHICULO ' +
                                    FInspecciones.ValueByName[FIELD_MATRICUL] + ' POR:' + E.message);
      end;
  end;
end;


function TFrmFinal.FinalizarInspeccion : boolean;

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
    aResultado, sNumeroOblea : string;
begin
aQ:=TSQLQuery.Create(self);
aQ.SQLConnection:=FInspeccion.Database;
AntiguoDateSeparator := DateSeparator;
result := True;
  try
    DateSeparator := '/';
    
    if not LabelRechazada.Visible then
      begin
        try
          FInspeccion.START;
          sNumeroOblea:= (Trim(Copy(BEdtOblea.Text,1,2)+Copy(BEdtOblea.Text,3,7)));

          if ((not (FInspecciones.ValueByName[FIELD_TIPO][1] in ([T_GRATUITA,T_PREVERIFICACION,T_VOLUNTARIA, T_VOLUNTARIAREVERIFICACION])))
              and not(LabelRechazada.Visible)) then
            ActualizacionNumeroOblea(StrToInt(sNumeroOblea));

          if LabelApta.Visible then
            aResultado := INSPECCION_APTA
          else
            aResultado := INSPECCION_CONDICIONAL;

          fInspeccion.Edit;
          fInspeccion.ValueByName[FIELD_RESULTAD] := aResultado;
          fInspeccion.ValueByName[FIELD_INSPFINA] := INSPECCION_FINALIZADA;
          fInspeccion.ValueByName[FIELD_HORFINAL] := DateTimeBD(FInspeccion.DataBase);
          fInspeccion.ValueByName[FIELD_FECVENCI] := LabelVencimiento.Caption;

          If ObleaPanel.Visible then
            Begin
              FInspeccion.ValueByName[FIELD_NUMOBLEA] := sNumeroOblea;
              CommitOblea(sNumeroOblea,IntToStr(vAnioVenci),Finspecciones.ValueByName[FIELD_EJERCICI],FInspecciones.ValueByName[FIELD_CODINSPE], MyBD);
              {$IFDEF TRAZAS}
              FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE CONSUMIO LA OBLEA : '+Copy(BEdtOblea.Text,1,2)+Copy(BEdtOblea.Text,3,7));
              {$ENDIF}
            end;
          fInspeccion.Post(true);
          fInspeccion.Refresh;

          with aQ do
            begin
              SQL.Add (Format('DELETE TESTADOINSP WHERE EJERCICI = %S AND CODINSPE =%S', [FINspecciones.ValueByName[FIELD_EJERCICI], FINspecciones.ValueByName[FIELD_CODINSPE]]));
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
              Result := FALSE;
              fIncidencias.PonAnotacion(TRAZA_SIEMPRE,13,FICHERO_ACTUAL,'ERROR AL FINALIZAR LA INSPECCION DEL VEHICULO: ' +
                                        FInspecciones.ValueByName[FIELD_MATRICUL] + ' POR: ' +E.message);
              MessageDlg('FINALIZACION DE INSPECCION', 'NO PUEDE REALIZAR DICHA OPERACION EN ESTOS MOMENTOS, ' +
                         'SI EL PROBLEMA PERSISTE CONTACTE CON SU DISTRIBUIDOR', mtInformation, [mbOk], mbOk,0);
            end;
        end;
      end
    else
      begin
        try
          FInspeccion.START;
            if CheckBaja.Checked then
              aResultado := INSPECCION_BAJA
            else
              aResultado := INSPECCION_RECHAZADO;

          fInspeccion.Edit;
          fInspeccion.ValueByName[FIELD_RESULTAD] := aResultado;
          fInspeccion.ValueByName[FIELD_INSPFINA] := INSPECCION_FINALIZADA;
          fInspeccion.ValueByName[FIELD_HORFINAL] := datetimetostr(GetDateTimePure(MyBD));
          fInspeccion.ValueByName[FIELD_FECVENCI] := LabelVencimiento.Caption;
          fInspeccion.Post(true);

          with aQ do
            begin
              SQL.Add (Format('DELETE TESTADOINSP WHERE EJERCICI = %S AND CODINSPE =%S', [FINspecciones.ValueByName[FIELD_EJERCICI], FINspecciones.ValueByName[FIELD_CODINSPE]]));
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
              Finspecciones.ValueByName[FIELD_MATRICUL] + ' POR: ' +E.message);
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


procedure TFrmFinal.RellenarDatosFinales;
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
            {// Sobreescritura del numero de oblea si la inspeccion ya tiene uno.
            if aInspect.Recordcount=0
            then raise Exception.Create('No existe el registro')
            else if not aInspect.DataSet.FieldByName(FIELD_NUMOBLEA).IsNull
                 then BEdtOblea.Text := aInspect.ValueByName[FIELD_NUMOBLEA];
            }

        fDatInspecc := nil;
        fDatInspecc := tdatinspecc.CreatebyCodEjer(finspecciones);
        fDatInspecc.open;
        fDatInspecc.GetInspectoresLineasByCodigo;
        dsDatinspecc.DataSet:=fDatInspecc.DataSet;

        ObtenerDatosFinales (Resultado);

        case Resultado of
            APTO:
            begin
                LabelApta.Visible := True;
                LabelVencimiento.Caption := FormatDateTime('dd/mm/yyyy', dNuevaFechaDeVencimiento  (StrToInt(FInspeccion.ValueByName[FIELD_CODVEHIC]), FDataBase, INSPECCION_APTA,Tipo));
            end;

            CONDICIONAL:
            begin
                LabelCondicional.Visible := True;
                LabelVencimiento.Caption := FormatDateTime('dd/mm/yyyy', dNuevaFechaDeVencimiento (StrToInt(FInspeccion.ValueByName[FIELD_CODVEHIC]), FDataBase, INSPECCION_RECHAZADO,Tipo ));
            end;

            RECHAZADO:
            begin
                LabelRechazada.Visible := True;
                CheckBaja.Visible := True;
                LabelVencimiento.Caption := FormatDateTime('dd/mm/yyyy',dNuevaFechaDeVencimiento (StrToInt(FInspeccion.ValueByName[FIELD_CODVEHIC]), FDataBase, INSPECCION_RECHAZADO,Tipo ));
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


function TFrmFinal.PasaPorZonas: tRegZonas;
const
    F_NULA = '01/01/1901';
begin
    result.z1 := tNoSe;
    result.z2 := tNose;
    result.z3 := tNose;
    with TSQLQuery.Create(nil) do
    try
        try
            SQLconnection := FInspecciones.DataBase;

            Sql.Add(Format('SELECT TO_CHAR(HORENTZ1,''DD/MM/YYYY''), ' +
                           '       TO_CHAR(HORSALZ1,''DD/MM/YYYY''), ' +
                           '       TO_CHAR(HORENTZ2,''DD/MM/YYYY''), ' +
                           '       TO_CHAR(HORSALZ2,''DD/MM/YYYY''), ' +
                           '       TO_CHAR(HORENTZ3,''DD/MM/YYYY''), ' +
                           '       TO_CHAR(HORSALZ3,''DD/MM/YYYY'') , ' +
                           '       HORENTZ1,HORENTZ2,HORENTZ3,GREATEST(HORENTZ1,HORENTZ2,HORENTZ3) '+
                           '   FROM TINSPECCION ' +
                           '   WHERE EJERCICI = %S AND CODINSPE = %S', [FInspecciones.ValueByName[FIELD_EJERCICI],FInspecciones.ValueByName[FIELD_CODINSPE]]));
            Open;

            if ((Fields[0].AsString = '') or (Fields[0].AsString = F_NULA)) and ((Fields[1].AsString = '') or (Fields[1].AsString = F_NULA))
                then result.z1 := tNoPasa
                else if (Not (Fields[0].AsString = '')) and (Not (Fields[0].AsString = F_NULA)) and (Not (Fields[1].AsString = '')) and (Not (Fields[1].AsString = F_NULA)) then result.z1 := tPasa
                    else result.z1 := tNoSe;

            if ((Fields[2].AsString = '') or (Fields[2].AsString = F_NULA)) and ((Fields[3].AsString = '') or (Fields[3].AsString = F_NULA))
                then result.z2 := tNoPasa
                else if (Not (Fields[2].AsString = '')) and (Not (Fields[2].AsString = F_NULA)) and (Not (Fields[3].AsString = '')) and (Not (Fields[3].AsString = F_NULA)) then result.z2 := tPasa
                    else result.z2 := tNoSe;

            if ((Fields[4].AsString = '') or (Fields[4].AsString = F_NULA)) and ((Fields[5].AsString = '') or (Fields[5].AsString = F_NULA))
                then result.z3 := tNoPasa
                else if (Not (Fields[4].AsString = '')) and (Not (Fields[4].AsString = F_NULA)) and (Not (Fields[5].AsString = '')) and (Not (Fields[5].AsString = F_NULA)) then result.z3 := tPasa
                    else result.z3 := tNoSe;

             if   Fields[6].AsString =Fields[9].AsString  then
              I1.Color:=clRed;

             if   Fields[7].AsString =Fields[9].AsString  then
              I2.Color:=clRed;

             if   Fields[8].AsString =Fields[9].AsString  then
              I3.Color:=clRed;




        except
            On E : Exception do
            begin
                fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1, FICHERO_ACTUAL,'NO SE PUEDEN CALCULAR LOS PASOS POR ZONA: %s',[E.Message]);
                raise;
            end;
        end;
    finally
        Close;
        Free;
    end;
end;


procedure TFrmFinal.ObtenerDatosFinales (var aResultado : tResultado);
const
  DEFECTO_LEVE = '2';
  DEFECTO_GRAVE = '3';
  SALTADA = '¡ SALTADA !';
  INCOMPLETA = 'INCOMPLETA';
  COMPLETA = 'COMPLETA';
var
  ColoresZona : tRegZonas;
  ColoresMediciones : TRegMediciones;
  i : integer;
  iDefectosLeves, iDefectosGraves : integer;
  sCodigo, sDescripcion,
  sOk, sDL, sDG : string;
  aq: TSQLDataSet;
  dsp : tDatasetprovider;
  cds : tClientDataSet;

begin
    MemoDeficiencias.Lines.Clear;

    iDefectosLeves := 0;
    iDefectosGraves := 0;

    ColoresZona := PasaPorZonas;
    ColoresMediciones := ValoresMedicion;

    with FDatInspecc do
      Begin
        I1.Caption:= InspectorLinea[1];
        I1.Hint:= NomyAppInspectorLinea[1];
        I2.Caption:= InspectorLinea[2];
        I2.Hint:= NomyAppInspectorLinea[2];
        I3.Caption:= InspectorLinea[3];
        I3.Hint:= NomyAppInspectorLinea[3];
      end;

    case ColoresZona.Z1 of
        tPasa:
        begin
            PZ1.Color :=  clLime;
            PZ1.Caption := COMPLETA;
        end;

        tNoPasa:
        begin
            PZ1.Color :=  clRed;
            PZ1.Caption := SALTADA;
        end;

        tNose:
        begin
            PZ1.Color :=  clYellow;
            PZ1.Caption := INCOMPLETA;
        end;
    end;

    case ColoresZona.Z2 of
        tPasa:
        begin
            PZ2.Color :=  clLime;
            PZ2.Caption := COMPLETA;
        end;

        tNoPasa:
        begin
            PZ2.Color :=  clRed;
            PZ2.Caption := SALTADA;
        end;

        tNose:
        begin
            PZ2.Color :=  clYellow;
            PZ2.Caption := INCOMPLETA;
        end;
    end;

    case ColoresZona.Z3 of
        tPasa:
        begin
            PZ3.Color :=  clLime;
            PZ3.Caption := COMPLETA;
        end;

        tNoPasa:
        begin
            PZ3.Color :=  clRed;
            PZ3.Caption := SALTADA;
        end;

        tNose:
        begin
            PZ3.Color :=  clYellow;
            PZ3.Caption := INCOMPLETA;
        end;
    end;

      aQ := TSQLDataSet.Create(nil);
      aQ.SQLConnection := fInspecciones.DataBase;
      aQ.CommandType := ctQuery;
      aq.GetMetadata := false;
      aq.NoMetadata := true;
      aq.ParamCheck := false;

      dsp := TDataSetProvider.Create(nil);
      dsp.DataSet := aQ;
      dsp.Options := [poIncFieldProps,poAllowCommandText];

      cds:=TClientDataSet.Create(nil);
    with cds do
    try
        setprovider(dsp);
        Close;
        CommandText:=(Format(' SELECT D.EJERCICI EJERCICI, D.CODINSPE CODINSPE, D.CADDEFEC CADDEFEC,          ' +
                       '       D.CALIFDEF CALIFDEF, D.SECDEFEC SECDEFEC,                                ' +
                       '       ABRCAPIT || '' - '' || A.ABRAPART || '' : '' || T.LITDEFEC LITDEFEC,    ' +
                       '       D.LOCALIZA LOCALIZA                                                     ' +
                       ' FROM                                                                           ' +
                       '   TINSPDEFECT D, TDEFECTOS  T, TCAPITULOS C, TAPARTADOS A                      ' +
                       ' WHERE                                                                          ' +
                       '   D.CADDEFEC = T.CADDEFEC   AND                                                ' +
                       '   C.CODCAPIT = T.CODCAPIT   AND                                                ' +
                       '   A.CODAPART = T.CODAPART   AND                                                ' +
                       '   A.CODCAPIT = T.CODCAPIT   AND                                                ' +
                       '   D.EJERCICI = %S AND                                                          ' +
                       '   D.CODINSPE = %S                                                              ' +
                       ' UNION                                                                          ' +
                       ' SELECT D.EJERCICI EJERCICI, D.CODINSPE CODINSPE, D.CADDEFEC CADDEFEC,          ' +
                       '        D.CALIFDEF CALIFDEF, D.SECUDEFE SECDEFEC,                               ' +
                       '        DECODE                                                                  ' +
                       '        ( SUBSTR (T.CADDEFEC,LENGTH(T.CADDEFEC)-1),  ''01'',                    ' +
                       '                    C.ABRCAPIT || '' - '' || A.ABRAPART || '' : '' || D.OTROSDEF || D.UBICADEF || ''-'' ||  D.OBSERVAC, ' +
                       '                    C.ABRCAPIT || '' - '' || A.ABRAPART || '' : '' || T.LITDEFEC ||'' ''|| D.UBICADEF ||'' ''|| D.OTROSDEF || ''-'' ||  D.OBSERVAC  ' +
                       '        )  LITDEFEC,                                                            ' +
                       '       NULL LOCALIZA                                                            ' +
                       ' FROM TDATINSPEVI D, TDEFECTOS  T, TCAPITULOS C, TAPARTADOS A                   ' +
                       ' WHERE                                                                          ' +
                       '   D.CADDEFEC = T.CADDEFEC AND                                                  ' +
                       '   C.CODCAPIT = T.CODCAPIT AND                                                  ' +
                       '   A.CODAPART = T.CODAPART AND                                                  ' +
                       '   A.CODCAPIT = T.CODCAPIT AND                                                  ' +
                       '   D.EJERCICI = %S AND                                                          ' +
                       '   D.CODINSPE = %S                                                              ',
                       [ fInspeccion.ValueByName[FIELD_EJERCICI],fInspeccion.ValueByName[FIELD_CODINSPE],
                         fInspeccion.ValueByName[FIELD_EJERCICI],fInspeccion.ValueByName[FIELD_CODINSPE]]));

        {$IFDEF TRAZAS}
        fTrazas.PonComponente(TRAZA_SQL,90,FICHERO_ACTUAL,aQ);
        {$ENDIF}

        Open;

        for i := 1 to RecordCount do
        begin
            {$IFDEF TRAZAS}
            fTrazas.PonRegistro(TRAZA_REGISTRO,91,FICHERO_ACTUAL,aQ);
            {$ENDIF}

            if FieldByName(FIELD_CALIFDEF).AsString = DEFECTO_GRAVE
            then inc(iDefectosGraves, 1)
            else if FieldByName(FIELD_CALIFDEF).AsString = DEFECTO_LEVE
                 then inc(iDefectosLeves, 1);

//            ObtenerLiteralCalificativo( FINspecciones.Database, StrToInt(FINspecciones.ValueByName[FIELD_EJERCICI]), StrToInt(FINspecciones.ValueByName[FIELD_CODINSPE]),
//                                        FieldByName(FIELD_CADDEFEC).AsString, FieldByName(FIELD_CALIFDEF).AsString,
//                                        GetLiteralDefecto(FieldByName(FIELD_CADDEFEC).AsString), FieldByName(FIELD_UBICADEF).AsString, sCodigo, sDescripcion, sOk, sDL ,sDG);

            ObtenerLiteralCalificativo (fVarios.Database, StrToInt(FINspecciones.ValueByName[FIELD_EJERCICI]), StrToInt(FINspecciones.ValueByName[FIELD_CODINSPE]),
                                        cds.FieldByName(FIELD_CADDEFEC).AsString,
                                        cds.FieldByName(FIELD_CALIFDEF).AsString,
                                        cds.FieldByName(FIELD_LITDEFEC).AsString,
                                        cds.FieldByName(FIELD_LOCALIZA).AsString,
                                        sCodigo, sDescripcion, sOk, sDL, sDG);

            MemoDeficiencias.Lines.Add(LineaCon(sCodigo, sDescripcion, sOk, sDL, sDG));//%%%
            //MemoDeficiencias.Lines.Add(sCodigo+sDescripcion+sOk+sDL+sDG);
            Next;
        end;
    finally
          Free;
          dsp.Free;
          aQ.close;
          aQ.free;
    end;

    if iDefectosGraves <> 0 then
      aResultado := RECHAZADO
    else
    if iDefectosLeves <> 0 then
      aResultado := CONDICIONAL
    else
      aResultado := APTO;

    PintaPanelesMedicion(ColoresMediciones);
end;


procedure TFrmFinal.bStandByClick(Sender: TObject);
const
  FACTURADO = 'A';
begin
  try
    if MessageDlg('PLANTA DE VERIFICACION', 'ESTA VIENDO EL INFORME DEL VEHICULO ' +
                  fInspecciones.ValueByName[FIELD_MATRICUL] + '. SEGURO QUE DESEA DEJARLO EN STANDBY ',
                  mtInformation,[mbIgnore, mbNo], mbIgnore,0) = mrIgnore then
    begin
    //Poner el valor de estado en StandBy Me !!!!!
    if FINspecciones.StandBy then
      begin
        InspeccionSinOblea;
        ModalResult:=mrok;
      end;
    end;
  except
    on E: Exception do
    begin
      fAnomalias.PonAnotacion(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'NO SE PUEDE REINICIAR LA VERIFICACION POR: ' + E.message);
    end;
  end;
end;


function TFrmFinal.GetColor (const aId: integer) : string;
begin
    with tsqlQuery.Create(nil) do
    try
        SQLConnection:= fDataBase;
        SQL.Add(Format('SELECT NOMCOLOR FROM TCOLORES WHERE CODCOLOR# = %d', [aId]));
        Open;
        Result := Fields[0].AsString;
    finally
        Close;
        Free;
    end
end;


Function TFrmFinal.GetDeficienaciasCount: Integer;
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


procedure TFrmFinal.bPagarClick(Sender: TObject);
var
    aQ: TSQLQuery;
    aTipo: String;
begin
//Paga uns Preverificacion
If Messagedlg(Caption,MSJ_PAGAR_PREVERIFICACION,mtConfirmation,[mbyes,mbno],mbno,0)=mrYes then
  begin
    try
      try
        fInspeccion.START;
        FInspeccion.Edit;
        If FInspeccion.IsReverification(FInspeccion,fvReverificacion)then
          begin
            FInspeccion.ValueByName[FIELD_TIPO]:=T_REVERIFICACION;
            aTipo:=T_REVERIFICACION;
          end
        else
          begin
            FInspeccion.ValueByName[FIELD_TIPO]:=T_NORMAL;
            aTipo:=T_NORMAL;
          end;
        FInspeccion.ValueByName[FIELD_WASPRE]:=INSPECCION_FUE_PREVERIFICACION;
        FInspeccion.Post(true);

        aQ:=TSQLQuery.Create(nil);
        with aQ do
          Try
            SQL.Clear;
            SQLConnection:=FInspeccion.DataBase;

            SQL.Add (Format('UPDATE TESTADOINSP SET ESTADO = ''%S'', TIPO = ''%S'' WHERE EJERCICI = %S AND CODINSPE = %S',
                             [E_PENDIENTE_FACTURAR,aTipo, FInspecciones.ValueByName[FIELD_EJERCICI], FInspecciones.ValueByName[FIELD_CODINSPE]]));
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
      FInspecciones.UnBlockInsp;
      FInspecciones.Refresh;
      ModalResult:=mrCancel;
    end;
  end;
end;


Procedure TFrmFinal.InspeccionSinOblea;
begin
//elimina el numero de oblea
FInspeccion.Edit;
FInspeccion.ValueByName[FIELD_NUMOBLEA]:='';
FInspeccion.Post(true);
end;


procedure TFrmFinal.FormActivate(Sender: TObject);
var
  sOblea, Fecha: String;
  nOblea: TOblea;
begin
Imprimio:=false;
vObleas:=0;
vAnioVenci:=0;
 
Application.ProcessMessages;

Fecha:=DateBd(FDataBase);
vAnioVenci:=StrToInt(Copy(LabelVencimiento.Caption,7,4));

if (FInspecciones.ValueByName[FIELD_ESTADO][1] in ([E_STANDBY])) then
  bStandBy.Enabled:=false;


  Begin
  // ml mb
  // se saco t_voluntaria, T_VOLUNTARIAREVERIFICACION 19/12/2010
  if ((Not (FInspecciones.ValueByName[FIELD_TIPO][1] in ([T_GRATUITA,T_PREVERIFICACION]))) and
     (not(LabelRechazada.Visible))) then

    begin
      If ObleasEnStock(vAnioVenci,MyBd) then
        Begin
        vObleas:=StrToInt(GetOblea(vAnioVenci,MyBD));
        {$IFDEF TRAZAS}
        FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE ASIGNO POR DEFECTO LA OBLEA: '+IntToStr(vObleas));
        {$ENDIF}
        //sOblea:=Copy(IntToStr(vObleas),1,2)+'-'+Copy(IntToStr(vObleas),3,6);    <- Cero Izq.
        sOblea:=FormatFloat('00000000',vObleas);
        if not (sOblea='') then
        //  BEdtOblea.Text :=IntToStr(vObleas)                                    <- Cero Izq.
          BEdtOblea.Text := sOblea
        else
          begin
            BEdtOblea.Text := sOblea;
            BEdtOblea.Text :=FormatNumOblea(vObleas);
            Application.ProcessMessages;
            FInspeccion.Edit;
            FInspeccion.ValueByName[FIELD_NUMOBLEA]:=Trim(Copy(BEdtOblea.Text,1,2)+Trim(Copy(BEdtOblea.Text,4,length(BEdtOblea.Text))));
            FInspeccion.Post(true);
            FInspecciones.Refresh;
          end;
        end
    else
      Begin
        BEdtOblea.Text:='00000000';
        BtnAceptar.Enabled:=false;
        DialogsFont.Size:=15;
        MessageDlg ('ERROR EN EL STOCK DE OBLEAS','ATENCION!!! NO HAY MAS OBLEAS DISPONIBLES!'#13#10+'POR FAVOR, INGRESE NUEVAS OBLEAS', mtERROR, [mbOk],mbOk, 0);
        DialogsFont.Size:=8;
      end;
    end;
  if LabelApta.Visible then
    bStandBy.Enabled:=False;
  If FInspecciones.ValueByName[FIELD_TIPO] = T_PREVERIFICACION Then
    bPagar.Enabled:=True;
    //T_VOLUNTARIA,T_VOLUNTARIAREVERIFICACION  martin  20.12.2010
  If (FInspecciones.ValueByName[FIELD_TIPO][1] in ([T_GRATUITA,T_PREVERIFICACION])) Then
    begin
      ObleaPanel.Visible:=False;
      if FInspecciones.ValueByName[FIELD_TIPO][1] in ([T_PREVERIFICACION]) then
        begin
          InpePanel.visible := true;
          lblNroInspe.Caption := ' NRO. DE INSPECCION: '+FInspeccion.informe;
        end;
    end
  else
    begin
      if not LabelRechazada.Visible then
        begin
        ObleaPanel.Visible:=True;
        end;
    end;
  IF bStandBy.Enabled then
    bStandBy.Enabled:=GetStandByEnabled;
  end
end;


Function TFrmFinal.GetStandByEnabled:Boolean;
begin
//Determina si esta activo el servicio de StandBy
Result:=(FVarios.PermitirStandBy <> OP_INACTIVA)
end;



Function TFrmFinal.FormatNumOblea(Cad:Integer):String;
VAR
    Cabo,Rabo: String;
begin
    if (Cad <= 999999) then
        Result := Format ('%1.2d-%1.6d',[0,Cad])
    else begin
       {********Codigo original de IVAN DIAZ SOLE ************
        Cabo:=Copy(IntToStr(Cad),1,2);
        Rabo:=Trim(Copy(IntToStr(Cad),3,Length(IntToStr(Cad))));
        **********aqui termina
                  y empieza codigo cambiado por Vicky*******
        Revisado por VAZ SLS para instalar con modificación
        construcción secuenciadores (26-12-2000)
        Solo funciona bajo condiciones actuales de número de oblea:
        pa-dddddd}
        if Length(IntToStr(Cad))>7 then begin
           Cabo:=Copy(IntToStr(Cad),1,2);
           Rabo:=Trim(Copy(IntToStr(Cad),3,Length(IntToStr(Cad))));
        end else begin
           Cabo:=Copy(IntToStr(Cad),1,1);
           Rabo:=Trim(Copy(IntToStr(Cad),2,Length(IntToStr(Cad))));
        end;
        {**** fin de cambios, sigue codigo original ******}
        Result:=Format('%1.2d-%1.6d', [StrToInt(Cabo),StrToInt(Rabo)]);
    end;
end;


procedure TFrmFinal.LlenarDatosVehiculo;
var fVehiculo: tvehiculo;
begin
  fVehiculo := nil;
  try
    fVehiculo := finspeccion.GetVehiculo;
    fVehiculo.open;
    TipoGas := fVehiculo.Valuebyname[FIELD_TIPOGAS];
    lblFabricado.Caption := fVehiculo.ValueByName[FIELD_ANIOFABR];
    with tSQLquery.create(nil) do
      try
        SQLConnection:=mybd;
        SQL.Clear;
        Close;
        SQL.Add('SELECT MA.NOMMARCA, MO.NOMMODEL, DE.NOMDESTI FROM TMARCAS MA, TMODELOS MO, TTIPODESVEH DE ');
        SQL.Add('WHERE MA.CODMARCA = MO.CODMARCA AND MA.CODMARCA = :MARCA AND MO.CODMODEL = :MODELO AND DE.TIPODEST = :TIPO');
        Params[0].Value:= fVehiculo.valuebyname[FIELD_CODMARCA];
        Params[1].Value:= fVehiculo.valuebyname[FIELD_CODMODEL];
        Params[2].Value:= fVehiculo.valuebyname['TIPODEST'];
        Open;
        LblMarcaModelo.caption := copy(Fields[0].asstring,1,12);
        LblMarcaModelo.caption :=LblMarcaModelo.caption + ' - ' + copy(fields[1].asstring,1,12)+' ('+fVehiculo.valuebyname[FIELD_TIPOGAS]+')';
        LabelTipo.Caption:=Fields[2].AsString;
        Close;
      finally
        free;
      end;
  finally
    fVehiculo.close;
    fVehiculo.Free;
    Application.ProcessMessages;
  end;
end;


function TFrmFinal.ValoresMedicion : tRegMediciones;
var
fxd1, fxd2, fxi1, fxi2 : string;  {Variables para que si los valores de alguna de las fuerzas de frenado vienen vacios, no tire error al realizar la conversion
                                    de string a numerico}
begin
result.efs := tNoSe;
result.efe := tNose;
result.da1 := tNose;
result.da2 := tNose;
result.de1 := tNose;
result.co2 := tNose;
result.kme := tNose;
result.fx1 := tNose;
result.fx2 := tNose;
  try
      if fDatInspecc.ValueByName[FIELD_EFFRSERV] = '' then
        result.efs := tNoPasa
      else
        result.efs := tPasa;

      if fDatInspecc.ValueByName[FIELD_EFFRESTA] = '' then
        result.efe := tNoPasa
      else
        result.efe := tPasa;

      if fDatInspecc.ValueByName[FIELD_DESE1EJE] = '' then
        result.da1 := tNoPasa
      else
        result.da1 := tPasa;

      if fDatInspecc.ValueByName[FIELD_DESE2EJE] = '' then
        result.da2 := tNoPasa
      else
        result.da2 := tPasa;

      if fDatInspecc.ValueByName[FIELD_DESL1EJE] = '' then
        result.de1 := tNoPasa
      else
        result.de1 := tPasa;

      if (TipoGas = COMBUSTIBLE_NAFTA) then
      begin
         if (fDatInspecc.ValueByName[FIELD_PORCECO2] = '') then
           result.co2 := tNoPasa
         else
           result.co2 := tPasa;

         if (fDatInspecc.ValueByName[FIELD_VALORKME] = '') then
           result.kme := tPasa
         else
           result.kme := tNoPasa;
      end
      else
        if (TipoGas = COMBUSTIBLE_GASOIL) then
        begin
           if (fDatInspecc.ValueByName[FIELD_VALORKME] = '') then
             result.kme := tNoPasa
           else
             result.kme := tPasa;

           if (fDatInspecc.ValueByName[FIELD_PORCECO2] = '') then
             result.co2 := tPasa
           else
             result.co2 := tNoPasa;
        end
        else
          if (TipoGas = COMBUSTIBLE_GNC) or (TipoGas = COMBUSTIBLE_MEZCLA) or (TipoGas = COMBUSTIBLE_NULL) then
          begin
           if (fDatInspecc.ValueByName[FIELD_VALORKME] = '') then
             result.kme := tPasa
           else
             result.kme := tNoPasa;

           if (fDatInspecc.ValueByName[FIELD_PORCECO2] = '') then
             result.co2 := tPasa
           else
             result.co2 := tNoPasa;
          end;


      fxd1:= fDatInspecc.ValueByName[FIELD_FMXFSRD1];
      fxd2:= fDatInspecc.ValueByName[FIELD_FMXFSRD2];
      fxi1:= fDatInspecc.ValueByName[FIELD_FMXFSRI1];
      fxi2:= fDatInspecc.ValueByName[FIELD_FMXFSRI2];

      if fxd1 = '' then fxd1 := '0';
      if fxd2 = '' then fxd2 := '0';
      if fxi1 = '' then fxi1 := '0';
      if fxi2 = '' then fxi2 := '0';

      if fDatInspecc.ValueByName[FIELD_FMXFSRD1]+fDatInspecc.ValueByName[FIELD_FMXFSRI1] = '' then
      begin
        result.fx1 := tNoPasa;
        pfx1.Caption := '';
      end
      else
      begin
        result.fx1 := tPasa;
        pfx1.Caption := Floattostr(strtofloat(ConviertePuntoEnComa(fxd1))+strtofloat(ConviertePuntoEnComa(fxi1)));
      end;

      if fDatInspecc.ValueByName[FIELD_FMXFSRD2]+fDatInspecc.ValueByName[FIELD_FMXFSRI2] = '' then
      begin
        result.fx2 := tNoPasa;
        pfx2.Caption := '';
      end
      else
      begin
        result.fx2 := tPasa;
        pfx2.Caption := Floattostr(strtofloat(ConviertePuntoEnComa(fxd2))+strtofloat(ConviertePuntoEnComa(fxi2)));
      end;

    except
        On E : Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1, FICHERO_ACTUAL,'NO SE PUEDEN CALCULAR LOS VALORES AUTOMATICOS POR: %s',[E.Message]);  //********* VER TODO
            raise;
        end;
    end;
    Application.ProcessMessages;
end;
 

procedure TFrmFinal.PintaPanelesMedicion(aMediciones: tRegMediciones);
begin
    case aMediciones.efs of
        tPasa:
        begin
            Pefs.Color :=  clLime;
        end;
        tNoPasa:
        begin
            Pefs.Color :=  clRed;
        end;
        tNose:
        begin
            Pefs.Color :=  clYellow;
        end;
    end;
    case aMediciones.efe of
        tPasa:
        begin
            Pefe.Color :=  clLime;
        end;
        tNoPasa:
        begin
            Pefe.Color :=  clRed;
        end;
        tNose:
        begin
            Pefe.Color :=  clYellow;
        end;
    end;
    case aMediciones.da1 of
        tPasa:
        begin
            Pda1.Color :=  clLime;
        end;
        tNoPasa:
        begin
            Pda1.Color :=  clRed;
        end;
        tNose:
        begin
            Pda1.Color :=  clYellow;
        end;
    end;
    case aMediciones.da2 of
        tPasa:
        begin
            Pda2.Color :=  clLime;
        end;
        tNoPasa:
        begin
            Pda2.Color :=  clRed;
        end;
        tNose:
        begin
            Pda2.Color :=  clYellow;
        end;
    end;
    case aMediciones.de1 of
        tPasa:
        begin
            Pde1.Color :=  clLime;
        end;
        tNoPasa:
        begin
            Pde1.Color :=  clRed;
        end;
        tNose:
        begin
            Pde1.Color :=  clYellow;
        end;
    end;

    case aMediciones.co2 of
        tPasa:
        begin
            Pco2.Color :=  clLime;
        end;
        tNoPasa:
        begin
            Pco2.Color :=  clRed;
        end;
        tNose:
        begin
            Pco2.Color :=  clYellow;
        end;
    end;

    case aMediciones.kme of
        tPasa:
        begin
            Pkme.Color :=  clLime;
        end;
        tNoPasa:
        begin
            Pkme.Color :=  clRed;
        end;
        tNose:
        begin
            Pkme.Color :=  clYellow;
        end;
    end;
    case aMediciones.fx1 of
        tPasa:
        begin
            Pfx1.Color :=  clLime;
        end;
        tNoPasa:
        begin
            Pfx1.Color :=  clRed;
        end;
        tNose:
        begin
            Pfx1.Color :=  clYellow;
        end;
    end;
    case aMediciones.fx2 of
        tPasa:
        begin
            Pfx2.Color :=  clLime;
        end;
        tNoPasa:
        begin
            Pfx2.Color :=  clRed;
        end;
        tNose:
        begin
            Pfx2.Color :=  clYellow;
        end;
    end;
Application.ProcessMessages;
end;


procedure TFrmFinal.FormDestroy(Sender: TObject);
begin
fDatInspecc.Free;
FInspeccion.Free;
end;


procedure TFrmFinal.BtnCancelarClick(Sender: TObject);
begin
if not (FInspecciones.ValueByName[FIELD_ESTADO][1] in ([E_STANDBY])) then
  InspeccionSinOblea;
ModalResult:=mrCancel;

//********************************** VERSION SAG 4.00 **********************************************
FInspecciones.UnBlockInsp;
{$IFDEF TRAZAS}
FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE DESBLOQUEO LA INSPECCION: '+fInspeccion.ValueByName[FIELD_CODINSPE]);
{$ENDIF}
If (FInspecciones.ValueByName[FIELD_TIPO][1] in ([T_NORMAL,T_REVERIFICACION,T_VOLUNTARIA,T_VOLUNTARIAREVERIFICACION])) and not (FInspecciones.ValueByName[FIELD_ESTADO][1] in [E_PENDIENTE_FACTURAR])then
  If not LabelRechazada.Visible  then
  begin
    If (StrToInt(vObleaAsig) <> vObleas)  then
      Begin
      RestoreOblea(StrToInt(vObleaAsig), vAnioVenci ,MyBD);
      {$IFDEF TRAZAS}
      FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE VOLVIO AL ESTADO DISPONIBLE LA OBLEA: '+vObleaAsig);
      {$ENDIF}
      end
    else
      Begin
      RestoreOblea(vObleas, vAnioVenci ,MyBD);
      {$IFDEF TRAZAS}
      FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE VOLVIO AL ESTADO DISPONIBLE LA OBLEA: '+IntToStr(vObleas));
      {$ENDIF}
      end;
//**************************************************************************************************
  end;
end;


procedure TFrmFinal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  BEdtOblea.ValidateEdit;
end;


procedure TFrmFinal.BEdtObleaChange(Sender: TObject);
begin
vObleaAsig:=Copy(BEdtOblea.Text,1,2)+Copy(BEdtOblea.Text,3,7);
If (StrToInt(vObleaAsig) <> vObleas) then
  If length(BEdtOblea.Text)=8 then
    If ObleaDisponible(StrToInt(vObleaAsig),vAnioVenci,MyBd) then
      Begin
        GetNewOblea(StrToInt(vObleaAsig),vAnioVenci, MyBd);
        RestoreOblea(vObleas, vAnioVenci ,MyBD);
        {$IFDEF TRAZAS}
        FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE PASO A ESTADO DISPONIBLE LA OBLEA: '+IntToStr(vObleas));
        {$ENDIF}
        vObleas:= StrToInt(vObleaAsig);
        {$IFDEF TRAZAS}
        FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE PASO A ESTADO TOMADO LA OBLEA: '+IntToStr(vObleas));
        {$ENDIF}
      end
    else
      BEdtOblea.Text:=IntToStr(vObleas);
end;

procedure TFrmFinal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if not Imprimio then
  BtnCancelar.Click;
LiberarMemoria;
end;

end.//Final de la unidad



