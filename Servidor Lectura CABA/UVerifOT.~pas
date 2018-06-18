unit UVerifOT;

interface
uses
  Forms,
  DB,
  sqlexpr,dbclient,provider,
  SysUtils,
  ULogs;

const

    FICHERO_ACTUAL = 'UVerifOT.pas';

    { CONSTANTES PARA EL PASO DE LAS REVISIONES }
       OKEY = 0;
       OBS= 1;
       DL = 2;
       DG = 3;
       IMP = 4;

       PRIMERA_DEPENDENCIA = 1;
       ULTIMA_DEPENDENCIA = 20;

    { TIPOS DE VEHICULOS }
      REMOLQUE_PESADO = 5;  // CODIGO PARA EL TIPO DE VEHICULO REMOLQUE PESADO
      REMOLQUE_LIGERO = 4;
      REMOLQUE = REMOLQUE_LIGERO;  // VALOR DEPENDENCIA  1 PARA UN REMOLQUE PESADO COINCIDE CON UN REMOLQUE LIGERO }

  { UMBRALES PARA LAS DEPENDENCIAS POR ANTIGUEDAD }
    MCMXCII = '1992';
    MCMXCIV = '1994';
    MCMXCV  = '1995';

  { VALORES DE LA DEPENDENCIA 2 SEGUN EL TIPO DE ANTIGUEDAD}
    ANTIGUEDAD_1 = 7;  // (00, 92)
    ANTIGUEDAD_2 = 8;  // [92, 94)
    ANTIGUEDAD_3 = 9;  // [94, 95)

  { VALORES DE LA DEPENDENCIAS 2 SEGUN EL TIPO DE ANTIGUEDAD}
    ANTIGUEDAD_4 = 10; // [00, 95)
    ANTIGUEDAD_5 = 11; // [95, 00)

type

  tDependencia = PRIMERA_DEPENDENCIA..ULTIMA_DEPENDENCIA;

  tRDependencias = record
    D1, D2, D3, D4 : tDependencia;
  end;

  tRegistroTINSPEDEFECT  = record
    iEjercicio, iCodigoInspeccion,
    iSecuenciaDefecto : integer;
    sCadenaDefecto, sCalificacion,
    sLocalizacion : string;
  end;

function ObtenidasDependenciasOk (const iEjercicio, iCodigoInspeccion : integer;
                                  var rDependencias : tRDependencias) : boolean;

function RevisionOk ( const iUnEjercicio, iUnCodigo : integer;
                      const D1 : tDependencia;
                      const D2 : tDependencia;
                      const D3 : tDependencia;
                      const D4 : tDependencia;
                      var iSecuenciaDefecto : integer;
                      const isSBy: boolean) : boolean;

implementation

uses
    UMODDAT, UGESTIONCAMPOS, GLOBALS, URES_OUT;


function InspeccionEnLinea (const iEjercicio, iCodigo:integer):boolean;
var
    aQ: TClientDataset;
    dsp: TDataSetProvider;
    sds: TSQLDataSet;
begin
    //Determina si se trata de una inspeccion que proviene de StandBy
    sds:=TSQLDataSet.Create(application);
    sds.SQLConnection := MyBD;
    sds.CommandType := ctQuery;
    sds.GetMetadata := false;
    sds.NoMetadata := true;
    sds.ParamCheck := false;
    dsp := TDataSetProvider.Create(application);
    dsp.DataSet := sds;
    dsp.Options := [poIncFieldProps,poAllowCommandText];
    aq:=TClientdataset.Create (application);
  with aq do
    try
      SetProvider(dsp);
      CommandText := format('SELECT * FROM TESTADOINSP WHERE EJERCICI = %D AND CODINSPE = %D',[iEjercicio, iCodigo]);
      open;
      result:=RecordCount>0;
    finally
      free;
      dsp.Free;
      sds.Free;
    end;
end;


function InsertadoDefecto(const aRegistro : tRegistroTINSPEDEFECT; const isSBy: boolean) : boolean;
var
 sClave,califActual: string; existeDef: integer;
begin

  { Se obtiene la clave de la tabla }
  sClave := IntToStr(aRegistro.iEjercicio) + ' ' + IntToStr(aRegistro.iCodigoInspeccion) +
            ' ' + IntToStr(aRegistro.iSecuenciaDefecto);
  try

    if InspeccionEnLinea(aRegistro.iEjercicio, aRegistro.iCodigoInspeccion ) then
    with DataDiccionario.QryGeneral do
    begin

      Close;
      SetProvider(DataDiccionario.dspQryGeneral);

      {*
      commandtext := 'select count(*) as existeDef,nvl(max(califdef),0) as calidef from TINSPDEFECT where EJERCICI=:UnEjercicio AND CODINSPE=:UnCodigo AND CADDEFEC=:UnaCadena and localiza=:UnaLocalizacion';
      params.ParamByName('UnEjercicio').AsInteger := aRegistro.iEjercicio;
      params.ParamByName('UnCodigo').AsInteger  := aRegistro.iCodigoInspeccion;
      params.ParamByName('UnaCadena').AsString := aRegistro.sCadenaDefecto;
      params.ParamByName('UnaLocalizacion').AsString := aRegistro.sLocalizacion;
      Execute;
      open;
      existeDef:=FieldByName('existeDef').AsInteger;
      close;

      If (existeDef>0)      //IsSBy
      Then begin

          CommandText := 'UPDATE TINSPDEFECT ' +
                'SET EJERCICI=:UnEjercicio,CODINSPE=:UnCodigo,CADDEFEC=:UnaCadena,CALIFDEF=:UnaCalificacion, LOCALIZA=:UnaLocalizacion, FECHALTA=SysDate ' +
                'WHERE EJERCICI=:UnEjercicio AND CODINSPE=:UnCodigo AND CADDEFEC=:UnaCadena and califdef<:UnaCalificacion ';
          params.ParamByName('UnaLocalizacion').AsString := aRegistro.sLocalizacion;
          params.ParamByName('UnaCalificacion').AsString := aRegistro.sCalificacion;
          //params.ParamByName('califActual').AsString :=  califActual;
      end
      else
      begin
        commandtext := 'INSERT INTO TINSPDEFECT ' +
                '( EJERCICI, CODINSPE, SECDEFEC, CADDEFEC, CALIFDEF, LOCALIZA, FECHALTA ) ' +
                ' VALUES ( :UnEjercicio, :UnCodigo, :UnaSecuencia, ' +
                '          :UnaCadena, :UnaCalificacion, :UnaLocalizacion, SysDate)';
      params.ParamByName('UnEjercicio').AsInteger := aRegistro.iEjercicio;
      params.ParamByName('UnCodigo').AsInteger  := aRegistro.iCodigoInspeccion;
      params.ParamByName('UnaCadena').AsString := aRegistro.sCadenaDefecto;
      params.ParamByName('UnaLocalizacion').AsString := aRegistro.sLocalizacion;
      params.ParamByName('UnaSecuencia').AsInteger := aRegistro.iSecuenciaDefecto;
      params.ParamByName('UnaLocalizacion').AsString := aRegistro.sLocalizacion;
      params.ParamByName('UnaCalificacion').AsString := aRegistro.sCalificacion;
    end;
    *}
      commandtext := 'INSERT INTO TINSPDEFECT ' +
                '( EJERCICI, CODINSPE, SECDEFEC, CADDEFEC, CALIFDEF, LOCALIZA, FECHALTA ) ' +
                ' VALUES ( :UnEjercicio, :UnCodigo, :UnaSecuencia, ' +
                '          :UnaCadena, :UnaCalificacion, :UnaLocalizacion, SysDate)';
      params.ParamByName('UnEjercicio').AsInteger := aRegistro.iEjercicio;
      params.ParamByName('UnCodigo').AsInteger  := aRegistro.iCodigoInspeccion;
      params.ParamByName('UnaCadena').AsString := aRegistro.sCadenaDefecto;
      params.ParamByName('UnaLocalizacion').AsString := aRegistro.sLocalizacion;
      params.ParamByName('UnaSecuencia').AsInteger := aRegistro.iSecuenciaDefecto;
      params.ParamByName('UnaLocalizacion').AsString := aRegistro.sLocalizacion;
      params.ParamByName('UnaCalificacion').AsString := aRegistro.sCalificacion;

      {$IFDEF TRAZAS}
        fTrazas.PonComponente(TRAZA_SQL,1,FICHERO_ACTUAL,DataDiccionario.QryGeneral);
      {$ENDIF}
      Execute;
      //commandtext := 'commit';
      //Execute;
      Application.ProcessMessages;
      {$IFDEF TRAZAS}
        fTrazas.PonAnotacion(TRAZA_FLUJO,0,FICHERO_ACTUAL,'INSERTADO EN TINSPEDEFECT EL REGISTRO ' + sClave);
      {$ENDIF}
    end;
    result := True;
  except
    on E:Exception do
    begin
      result := False;
      fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL,'NO SE PUEDE INSERTAR EL REGISTRO ' + sClave + ' EN TINSPEDEFECT POR: ' + E.message);
    end;
  end;
end;


function ObtenidasDependenciasOk (const iEjercicio, iCodigoInspeccion : integer; var rDependencias : tRDependencias) : boolean;
var
  sClave : string; sAnio: integer;
begin
sClave := IntToStr(iEjercicio) + ',' + IntToStr(iCodigoInspeccion);
  try
    with DataDiccionario.QryGeneral do
    begin
      Close;
      SetProvider(DataDiccionario.dspQryGeneral);
      CommandText := 'SELECT T.TIPOVEHI, V.FECMATRI, nvl(tipomotordiesel,0) as motorDiesel, nvl(tipomotormoto,0) as motorMoto FROM TVEHICULOS V,  TINSPECCION I , TTIPOESPVEH T ' +
                     'WHERE V.CODVEHIC = I.CODVEHIC AND V.TIPOESPE = T.TIPOESPE AND I.EJERCICI =:UnEjercicio ' +
                     'AND I.CODINSPE =:UnCodigo';
      //Prepare;
      params.ParamByName('UnEjercicio').value := iEjercicio;
      params.ParamByName('UnCodigo').value  := iCodigoInspeccion;
      {$IFDEF TRAZAS}
        fTrazas.PonComponente(TRAZA_SQL,1,FICHERO_ACTUAL,DataDiccionario.QryGeneral);
      {$ENDIF}
      Open;
      Application.ProcessMessages;
      if RecordCount = 1 then
        begin
        {$IFDEF TRAZAS}
        fTrazas.PonRegistro(TRAZA_REGISTRO,1,FICHERO_ACTUAL,DataDiccionario.QryGeneral);
        {$ENDIF}
        if FieldByName('TIPOVEHI').AsInteger = REMOLQUE_PESADO then
          rDependencias.D1 := REMOLQUE
        else
          rDependencias.D1 := FieldByName('TIPOVEHI').AsInteger;
        sAnio := strtoint(FormatDateTime('yyyy',FieldByName('FECMATRI').AsDateTime));

        if FieldByName('MotorDiesel').AsInteger =0 then
          if  FieldByName('MotorMoto').AsInteger =0 then
            if sAnio <= 1991 then // (-oo, 1992)
                rDependencias.D2 := 12
            else
              If sAnio <= 1994 then // [1992, 1995)
                rDependencias.D2 := 13
              else
                If sAnio <= 1999 then // [1992, 1995)
                  rDependencias.D2 := 14
                else
                  rDependencias.D2 := 15
          else
            if  FieldByName('MotorMoto').AsInteger =1 then  rDependencias.D2 :=16
            else rDependencias.D2 :=17
        else
            if  FieldByName('MotorDiesel').AsInteger =1 then  rDependencias.D2 :=10
            else rDependencias.D2 :=11;

        if sAnio <= 1996 then rDependencias.D3 :=18 else rDependencias.D3 :=19;

        rDependencias.D4 :=20;



                // modificacion 28/08/2013 - emision de humos
         //analiza campo 70 de tdatinpec

 (*
         if FieldByName('TIPOVEHI').AsInteger = 2  then
              rDependencias.D3 := 10;

         if FieldByName('TIPOVEHI').AsInteger = 3  then
              rDependencias.D3 := 11;
 *)
        {$IFDEF TRAZAS}
           fTrazas.PonAnotacion(TRAZA_FLUJO,1,FICHERO_ACTUAL,'OBTENIDAS LAS DEPENDECIAS PARA EL VEHICULO (Ejercicio, Codigo): ' + sClave);
        {$ENDIF}
        result := True;
        end
      else
        begin
          result := False;
          fAnomalias.PonAnotacion(TRAZA_FLUJO,1,FICHERO_ACTUAL,'ERROR, NO HAY DEPENDENCIAS PARA EL VEHICULO (Ejercicio, Codigo): ' + sClave + ' PORQUE NO EXISTE EL REGISTRO');
        end;
    end;
  except
    on E:Exception do
    begin
      result := False;
      fAnomalias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'ERROR, NO HAY DEPENDENCIAS PARA EL VEHCIULO (Ejercicio, Código): ' + sClave + ' POR: ' + E.message);
    end;
  end;
end;

function InspeccionParaLuces(const iUnEjercicio, iUnCodigo : integer; const icodPrueba: string) : integer;
var
  SQLStoredProc1: TSQLStoredProc;    aux: integer;

begin
      SQLStoredProc1:=TSQLStoredProc.create(Application);
      with SQLStoredProc1 do
      begin
        SQLStoredProc1.sqlConnection:=MyBD;
        StoredProcName := 'Pq_ServLectura.inspeccionParaLuces';
        Params.ParamByName('codPruebaP').AsString := icodPrueba ;
        Params.ParamByName('codinspeP').AsString := inttostr(iUnCodigo) ;
        Params.ParamByName('pEJERCICI').AsString := inttostr(iUnEjercicio) ;
        ExecProc;
        //Result:=aux;
        //aux := Params.ParamByName('ARESULTAD').AsInteger;
        Result := Params.ParamByName('ARESULTAD').AsInteger;
      end;
 // Result := a + b;
end;

function RevisionOk ( const iUnEjercicio, iUnCodigo : integer;
                      const D1 : tDependencia;
                      const D2 : tDependencia;
                      const D3 : tDependencia;
                      const D4 : tDependencia;
                      var iSecuenciaDefecto : integer;
                      const isSBy: boolean) : boolean;


var
    UnRegistro : tRegistroTINSPEDEFECT;
    Dependencia : tDependencia;
    sClave,aux1,sql : string;
    ValorAComprobar : real;
    Code_Error : integer;
    aq:tsqlquery;
    iParametroVerificacion,iParametroComprobacion,iParamLuces,comprobacion: integer;
    sCampoRevision,sCodPrueba : string;
    //SQLStoredProc1: TSQLStoredProc;

begin

    UnRegistro.iEjercicio := iUnEjercicio;
    UnRegistro.iCodigoInspeccion := iUnCodigo;



    result := True;

//    sql:='execute CABA.COMPLETAR_RES_INSPECCION('''+inttostr(iUnCodigo)+''','''+inttostr(iUnEjercicio)+''')';
    aq:=tsqlquery.create(Application);
    aq.SQLConnection := MyBD;
//    aq.sql.add(sql);
//    aq.ExecSQL(result);
//    aq.SQL.Clear;
    sql:='select dependen,RI.codprueba,valormedida,substr(cadena,1,9) as campoRevision,substr(cadenaMoto,1,9) as campoRevisionMoto,nvl((campoverif-1),0) as campoVerificacion,nvl(cd.campo,0) as campoComprob,nvl(luces,0) as luces'+
         ' from RESULTADO_INSPECCION RI inner join (TCAMPOXDEFECTO CD left JOIN TCAMPOS C ON CD.campo=C.campo )  on replace(RI.codprueba,'' '','''')=replace(CD.codprueba,'' '','''') ' +
         ' WHERE RI.EJERCICI =' +inttostr(iUnEjercicio)+ ' AND RI.CODINSPE ='+inttostr(iUnCodigo)+' and  cd.campo <> -1 ' +
         ' and (dependen in ('+inttostr(D1)+','+inttostr(D2)+','+inttostr(D3)+','+inttostr(D4)+',6) or luces=1)';
    aq.sql.add(sql);
    aq.open;

    WHILE NOT AQ.EOF DO
    BEGIN
                sClave := IntToStr(iUnEjercicio) + ',' + IntToStr(iUnCodigo);

                Dependencia:=AQ.FieldByName('dependen').AsInteger ;

                IF (D2=16) or (D2=17) THEN
                  sCampoRevision:=AQ.FieldByName('campoRevisionMoto').AsString
                ELSE
                  sCampoRevision:=AQ.FieldByName('campoRevision').AsString ;


                sCodPrueba:=AQ.FieldByName('codprueba').AsString ;
                iParametroVerificacion:=AQ.FieldByName('campoVerificacion').AsInteger ;
                iParametroComprobacion:=AQ.FieldByName('campoComprob').AsInteger ;
                iParamLuces:=AQ.FieldByName('luces').AsInteger ;
                UnRegistro.iSecuenciaDefecto := iSecuenciaDefecto;

                UnRegistro.sCadenaDefecto := sCampoRevision;

                case iParametroVerificacion of
                  3..5 : UnRegistro.sLocalizacion := IntToStr (iParametroVerificacion - 1);
                  37..39 : UnRegistro.sLocalizacion := IntToStr (iParametroVerificacion - 35);
                  56,58 : UnRegistro.sLocalizacion := 'D';
                  57,59 : UnRegistro.sLocalizacion := 'I';
                  73,74: UnRegistro.sLocalizacion := 'BI';
                  75,76: UnRegistro.sLocalizacion := 'BD';
                  77,78: UnRegistro.sLocalizacion := 'AI';
                  79,80: UnRegistro.sLocalizacion := 'AD';
                end;

                {$IFDEF TRAZAS}
                fTrazas.PonAnotacion(TRAZA_FLUJO,2,FICHERO_ACTUAL,'COMIENZA EL TEST PARA EL CAMPO '+ sCampoRevision + ' DEL VEHICULO '+ sClave + ' CON UN VALOR DE: ' + AQ.FieldByName('valormedida').AsString);
                {$ENDIF}
                //aux1:=Fields[4].AsString;
                { Conversion de un valor literal a su valor numerico, tanto real como entero }
                Code_error:=0;

                //Val('9', ValorAComprobar, Code_error);
                ValorAComprobar:=strtofloat(AQ.FieldByName('valormedida').AsString);

                if (iParametroComprobacion <> 43) and (iParametroComprobacion <> 46) and (iParametroComprobacion <> 49) then
                  if (iParametroComprobacion = 10) or (iParametroComprobacion = 13) then
                    ValorAComprobar:=round(ValorAComprobar)
                  else
                    ValorAComprobar:=trunc(ValorAComprobar);


                if Code_Error = 0 { NO HAY ERROR } then
                begin
                    With TCampos.Create(MyBd) do
                    Try
                        if iParamLuces =0
                        then comprobacion:=InspeccionPara(iParametroComprobacion, ValorAComprobar, Dependencia)
                        else
                        comprobacion:=InspeccionParaLuces(iUnEjercicio,iUnCodigo,trim(sCodPrueba)) ;

                        case comprobacion of
                            OKEY:
                            begin
                                {$IFDEF TRAZAS}
                                fTrazas.PonAnotacion(TRAZA_FLUJO,3,FICHERO_ACTUAL,'PASA '+ sClave + ' LA REVISION DE ESTE CAMPO');
                                {$ENDIF}
                            end;
                            OBS:
                            begin
                                {$IFDEF TRAZAS}
                                fTrazas.PonAnotacion(TRAZA_FLUJO,4,FICHERO_ACTUAL,'NO PASA '+ sClave + ' LA REVISION DE ESTE CAMPO, ES OBSERVACION');
                                {$ENDIF}
                                UnRegistro.sCalificacion := IntToStr(OBS);
                                if InsertadoDefecto(UnRegistro, isSBy) then inc(iSecuenciaDefecto)
                                else begin
                                    result := False;
                                    fAnomalias.PonAnotacion(TRAZA_SIEMPRE,4,FICHERO_ACTUAL, 'HUBO UN ERROR AL INTENTAR INSERTAR EL DEFECTO EN TINSPDEFECTOS, LA VALORACION NO PUEDE COMPLETARSE Y TERMINARÁ');
                                end;
                            end;
                            DL:
                            begin
                                {$IFDEF TRAZAS}
                                fTrazas.PonAnotacion(TRAZA_FLUJO,5,FICHERO_ACTUAL,'NO PASA '+ sClave + ' LA REVISION DE ESTE CAMPO, ES LEVE');
                                {$ENDIF}
                                UnRegistro.sCalificacion := IntToSTr(DL);
                                if InsertadoDefecto(UnRegistro, isSBy) then inc(iSecuenciaDefecto)
                                else begin
                                    result := False;
                                    fAnomalias.PonAnotacion(TRAZA_SIEMPRE,5,FICHERO_ACTUAL, 'HUBO UN ERROR AL INTENTAR INSERTAR EL DEFECTO EN TINSPDEFECTOS, LA VALORACION NO PUEDE COMPLETARSE Y TERMINARÁ');
                                end;
                            end;
                            DG:
                            begin
                                {$IFDEF TRAZAS}
                                fTrazas.PonAnotacion(TRAZA_FLUJO,6,FICHERO_ACTUAL,'NO PASA '+ sClave + ' LA REVISION DE ESTE CAMPO, ES GRAVE');
                                {$ENDIF}
                                UnRegistro.sCalificacion := IntToStr(DG);
                                if InsertadoDefecto(UnRegistro, isSBy) then inc(iSecuenciaDefecto)
                                else begin
                                    result := False;
                                    fAnomalias.PonAnotacion(TRAZA_SIEMPRE,6,FICHERO_ACTUAL, 'HUBO UN ERROR AL INTENTAR INSERTAR EL DEFECTO EN TINSPDEFECTOS, LA VALORACION NO PUEDE COMPLETARSE Y TERMINARÁ');
                                end;
                            end;
                            else
                            begin
                              result := False;
                              fAnomalias.PonAnotacion(TRAZA_SIEMPRE,7,FICHERO_ACTUAL, 'ERROR LA VALORACION OBTENIDA PARA ESTE DAMPO ES DESCONOCIDA, Y SE TERMINARÁ');
                            end;
                        end; // Case;
                    Finally
                      Free;
                    end;
                    {$IFDEF TRAZAS}
                    fTrazas.PonAnotacion(TRAZA_FLUJO,7,FICHERO_ACTUAL,'TERMINA EL TEST PARA EL CAMPO ' + sCampoRevision + ' DEL VEHICULO '+ sClave + ' CON UN VALOR DE: ' + AQ.FieldByName('valormedida').AsString);
                    {$ENDIF}
                end // Comprobacion del valor numerico
                else fIncidencias.PonAnotacion(TRAZA_SIEMPRE,7,FICHERO_ACTUAL, 'TERMINA EL TEST PARA EL CAMPO ' + sCampoRevision + ' PORQUE TIENE UN VALOR INVEROSIMIL: ' + AQ.FieldByName('valormedida').AsString );
      AQ.NEXT;
    end;

end;




end.
