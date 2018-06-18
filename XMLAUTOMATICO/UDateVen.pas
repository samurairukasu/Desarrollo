// 10/01/2012 - se saco el tema de los 60 dias.


unit UDateVen;


interface
 uses
   Classes, SysUtils, Messages, Forms ,SQLExpr, uSagClasses, Provider, dbclient;

 type
   EFechaInCorrecta = class(Exception);
   ENoExisteRegistro = class(Exception);

   ttFechas = record
    dFechaVencimientoApto,
    dFechaActual,
    dFechaMatriculacion,
    dFechaInspeccion : Integer;
    dresultado: char;         // MODI RAN VAZ
   end;

   ttFrecuencias = record
    iPeriodicidad1,
    iPeriodicidad2,
    iPeriodicidad3,
    iLongevidad1,
    iLongevidad2,
    iLongevidad3 : Integer;
   end;

   ttFechasReve = record
     dFechaVencimientoApto: integer;
     dResultado : char;
   end;

 function dNuevaFechaDeVencimiento ( const iCodigoVehiculo : integer;aDataBase:tSQLConnection;
                                     const cResultadoInspeccionActual,aTipo: char) : Integer;

{ ********************************************************************** }
// Nueva función para modularizar un poco más los diferentes casos que hay que
// contemplar en las reverificaciones. MODI RAN VAZ
{ ********************************************************************** }

 Function ObtieneFechaReve( const iCodigoVehiculo : integer;aDataBase:TSQLConnection;const cResultadoInspeccionActual:char) : ttFechasReve;

 procedure FechaVencModificada( var iFechaVencimiento: integer; var iresultado: char; const iCodigoVehiculo : integer; const adatabase: tSQLConnection);

 Function ObtieneFechaReveExterna( const iCodigoVehiculo : integer;aDataBase:TSQLConnection;const cResultadoInspeccionActual:char) : ttFechasReve;

 procedure FechaVencModificadaReve( var iFechaVencimiento: integer; var iresultado: char; const iCodigoVehiculo : integer; const adatabase: tSQLConnection);

 implementation


uses
  ULogs, DateUtil, UTilOracle, USAGVARIOS, USAGESTACION, Globals;

const
    FICHERO_ACTUAL = 'UDateVen.pas';
    NUM_DIAS_MES = 30;
    DIEZ_DIAS = 10;
    DIAS_X_MES = 30.42;
    SIN_FECHA = '01/01/1500';




function tFrecuenciasVehiculo ( const iCodigoVehiculo : integer; aDataBase: TSQLConnection) : ttFrecuencias;
var
    aq: TSQLDataSet;
    dsp : tDatasetprovider;
    cds : tClientDataSet;
const
  UNICO = 1;
begin
      aQ := TSQLDataSet.Create(application);
      aQ.SQLConnection := aDataBase;
      aQ.CommandType := ctQuery;

      aQ.GetMetadata := false;
      aQ.NoMetadata := true;
      aQ.ParamCheck := false;

      dsp := TDataSetProvider.Create(application);
      dsp.DataSet := aQ;
      dsp.Options := [poIncFieldProps,poAllowCommandText];

      cds:=TClientDataSet.Create(application);
  try
    { BUSQUEDA EN CUANTO DESTINO }
    try
      with cds do
      begin
        SetProvider(dsp);
        Close;
        commandtext := 'SELECT  F.L1, F.L2, F.P1, F.P2, F.L3, F.P3 ' +
                  'FROM  ' +
                  'TFRECUENCIA  F, TVEHICULOS V, TTIPODESVEH D ' +
                  'WHERE ' +
                     'V.CODVEHIC =:UnCodigo AND ' +
                     'V.TIPODEST = D.TIPODEST AND ' +
                     'F.CODFRECU = D.CODFRECU';

        {$IFDEF TRAZAS}
          fTrazas.PonComponente(TRAZA_SQL,30,FICHERO_ACTUAL,aQ);
        {$ENDIF}

        Params.ParamByName('UnCodigo').AsInteger := iCodigoVehiculo;
        Open;

        {$IFDEF TRAZAS}
          fTrazas.PonRegistro(TRAZA_REGISTRO,31,FICHERO_ACTUAL,aQ);
        {$ENDIF}


        if RecordCount = UNICO
        then begin

          result.iLongevidad1 := FieldByName('L1').AsInteger;
          result.iPeriodicidad1 := FieldByName('P1').AsInteger;

          if FieldByName('L2').IsNull
          then result.iLongevidad2 := 0
          else result.iLongevidad2 := FieldByName('L2').AsInteger;

          if FieldByName('P2').IsNull
          then result.iPeriodicidad2 := 0
          else result.iPeriodicidad2 := FieldByName('P2').AsInteger;

          if FieldByName('L3').IsNull
          then result.iLongevidad3 := 0
          else result.iLongevidad3 := FieldByName('L3').AsInteger;

          if FieldByName('P2').IsNull
          then result.iPeriodicidad2 := 0
          else result.iPeriodicidad2 := FieldByName('P2').AsInteger;

          if FieldByName('P3').IsNull
          then result.iPeriodicidad3 := 0
          else result.iPeriodicidad3 := FieldByName('P3').AsInteger;

          Close;
        end
        else begin
          { BUSQUEDA EN CUANTO A ESPECIE }
          Close;
          SetProvider(dsp);
          commandtext :=  'SELECT  F.L1, F.L2, F.P1, F.P2, F.L3, F.P3 ' +
                    'FROM  ' +
                    'TFRECUENCIA  F, TVEHICULOS V, TTIPOESPVEH E ' +
                    'WHERE ' +
                       format('V.CODVEHIC = %s AND ',[inttostr(iCodigoVehiculo)]) +
                       'V.TIPOESPE = E.TIPOESPE AND ' +
                       'F.CODFRECU = E.CODFRECU';

          { TODO -oran -cconsultas : esta bien asi??? }

//          params.ParamByName('UnCodigo').value := iCodigoVehiculo;

        {$IFDEF TRAZAS}
          fTrazas.PonRegistro(TRAZA_SQL,32,FICHERO_ACTUAL,aQ);
        {$ENDIF}

          Open;

        {$IFDEF TRAZAS}
          fTrazas.PonRegistro(TRAZA_REGISTRO,33,FICHERO_ACTUAL,aQ);
        {$ENDIF}

          if RecordCount = UNICO then
          begin
            result.iLongevidad1 := FieldByName('L1').AsInteger;
            result.iPeriodicidad1 := FieldByName('P1').AsInteger;

            if FieldByName('L2').IsNull then result.iLongevidad2 := 0
            else result.iLongevidad2 := FieldByName('L2').AsInteger;

            if FieldByName('L3').IsNull then result.iLongevidad3 := 0
            else result.iLongevidad3 := FieldByName('L3').AsInteger;

            if FieldByName('P2').IsNull then result.iPeriodicidad2 := 0
            else result.iPeriodicidad2 := FieldByName('P2').AsInteger;

            if FieldByName('P3').IsNull then result.iPeriodicidad3 := 0
            else result.iPeriodicidad3 := FieldByName('P3').AsInteger;

            Close;
          end
          else begin
            raise ENoExisteRegistro.Create('No se obtiene ninguna frecuencia');
            Close;
          end;
        end;
      end;
    except
      on E : Exception do
      begin
        fIncidencias.PonAnotacion(0,0,FICHERO_ACTUAL,'ERROR AL BUASCAR LAS FRECUENCIAS DE: ' + IntToStr(iCodigoVehiculo)  + ' POR :' + E.message);
        raise;
      end;
    end;
  finally
    cds.Free;
    dsp.Free;
    aQ.close;
    aQ.free;
  end;
end;


function tFechasVehiculo (const iCodigoVehiculo : integer; const aDataBase: TSQLConnection; const aTipo : char;const cResultadoInspeccionActual:char ) : ttFechas;
const
    UNICO = 1;
var
    sFechaAntiguo : string;
    aq: TSQLDataSet;
    dsp : tDatasetprovider;
    cds : tClientDataSet;
    FechasReve: ttFechasReve;
    ExisteRE:Integer;
begin
      aQ := TSQLDataSet.Create(application);
      aQ.SQLConnection := aDataBase;
      aQ.CommandType := ctQuery;

      aQ.GetMetadata := false;
      aQ.NoMetadata := true;
      aQ.ParamCheck := false;      

      dsp := TDataSetProvider.Create(application);
      dsp.DataSet := aQ;
      dsp.Options := [poIncFieldProps,poAllowCommandText];

      cds:=TClientDataSet.Create(application);
    with cds do
    try
        sFechaAntiguo := ShortDateFormat;
        ShortDateFormat := 'DD/MM/YYYY';
        try
            SetProvider(dsp);

            CommandText := (Format('SELECT TO_CHAR(FECMATRI, ''DD/MM/YYYY'') FROM TVEHICULOS WHERE CODVEHIC = %D',[iCodigoVehiculo]));;

            // CommandText:= (Format('SELECT  COUNT(*) FROM TINSPECCIONEXTERNA   '+
              //                          ' WHERE (CODVEHIC = %D) AND FECVENCI > = SYSDATE -1  ORDER BY FECHALTA DESC',[iCodigoVehiculo]));

            {$IFDEF TRAZAS}
            fTrazas.PonComponente(TRAZA_FLUJO,33,FICHERO_ACTUAL,aQ);
            {$ENDIF}

            Open;
            {$IFDEF TRAZAS}
            fTrazas.PonComponente(TRAZA_REGISTRO,34,FICHERO_ACTUAL,aQ);
            {$ENDIF}

            if RecordCount <> UNICO
            then begin
                Close;
                raise ENoExisteRegistro.Create('No se obtiene ninguna frecuencia');
            end
            else begin
            // Trunco los resultados para no tener parte decimal, almacenando enteros;
               with result do
                begin
                    dFechaActual := Trunc(StrToDate(DateBD(aQ.SQLConnection)));
                    dFechaMatriculacion := Trunc(StrToDate(Fields[0].AsString));
                end;
            end;

            //Seleccionar fecha de ultima inspeccion valida

            Close;
            if (aTipo in [T_NORMAL,T_VOLUNTARIA])
            then begin
                SetProvider(dsp);
                if aTipo in [T_NORMAL]
                then CommandText := (Format('SELECT TO_CHAR(FECVENCI, ''DD/MM/YYYY''), RESULTAD FROM TINSPECCION I ' +
                                     ' WHERE (CODVEHIC = %D) AND (INSPFINA=''S'') AND (TIPO IN (''%S'',''%S'')) ' +
                                     ' AND NOT EXISTS (SELECT ''X'' FROM TFACTURAS F ' +
                                     ' WHERE F.CODFACTU = I.CODFACTU AND CODCOFAC IS NOT NULL)' +
                                     ' ORDER BY FECHALTA DESC',[iCodigoVehiculo,T_NORMAL,T_REVERIFICACION]))

                else CommandText := (Format('SELECT TO_CHAR(FECVENCI, ''DD/MM/YYYY'') FROM TINSPECCION I' +
                                     ' WHERE (CODVEHIC = %D) AND (INSPFINA=''S'') AND (TIPO IN (''%S'',''%S'')) ' +
                                     ' AND NOT EXISTS (SELECT ''X'' FROM TFACTURAS F ' +
                                      ' WHERE F.CODFACTU = I.CODFACTU AND CODCOFAC IS NOT NULL )' +
                                     ' ORDER BY FECHALTA DESC',[iCodigoVehiculo,T_VOLUNTARIA,T_VOLUNTARIAREVERIFICACION]));

                Open;
                // se inicializa la fecha de vencimiento en cero
                Result.dFechaVencimientoApto:=Trunc(StrToDateTime(SIN_FECHA));
                if Recordcount>0
                then
                  if ((aTipo in [T_NORMAL]) and (Fields[1].asstring = INSPECCION_APTA)) or (aTipo in [T_VOLUNTARIA])
                  then Result.dFechaVencimientoApto:=Trunc(StrToDate(Fields[0].AsString))
                  else Result.dFechaVencimientoApto:=Trunc(StrToDateTime(SIN_FECHA))
            end
            else
              if aTipo in [T_REVERIFICACION,T_VOLUNTARIAREVERIFICACION] then
              begin
                //mla  reves externas//
               cds:=TClientDataSet.Create(application);
               with cds do
                 begin
                 SetProvider(dsp);

                 //original MB 28-06-2010
                // CommandText:= (Format('SELECT  COUNT(*) FROM TINSPECCIONEXTERNA ' +
                  //          ' WHERE (CODVEHIC = %D) AND TO_CHAR(FECHALTA,''DD/MM/YYYY'') = TO_CHAR(SYSDATE,''DD/MM/YYYY'')  ' +
                    //        ' ORDER BY FECHALTA DESC',[iCodigoVehiculo]));

                 CommandText:= (Format('SELECT  COUNT(*) FROM TINSPECCIONEXTERNA   '+
                                        ' WHERE (CODVEHIC = %D) AND FECHALTA  '+
                                        '  BETWEEN  SYSDATE-59 AND SYSDATE  ORDER BY FECHALTA DESC',[iCodigoVehiculo]));


                 open;
                 ExisteRE := Fields[0].AsInteger;
                end ;
                if  ExisteRE =0 then
                  FechasReve := ObtieneFechaReve(iCodigoVehiculo,aDatabase,cResultadoInspeccionActual)
                else
                  FechasReve := ObtieneFechaReveExterna(iCodigoVehiculo,aDatabase,cResultadoInspeccionActual);

                result.dFechaVencimientoApto := FechasReve.dFechaVencimientoApto;
                result.dResultado := FechasReve.dResultado;
              end

              else if aTipo in [T_PREVERIFICACION, T_GRATUITA]
                then Result.dFechaVencimientoApto:=Trunc(StrToDateTime(SIN_FECHA))
                else raise Exception.CreateFmt('Tipo de inspeccion no contemplada: %S',[aTipo]);
        except
            on E : Exception do
            begin
                fIncidencias.PonAnotacion(0,0,FICHERO_ACTUAL,'ERROR OTENIENDO LAS FECHAS DEL VEHICULO ' + IntToStr(iCodigoVehiculo) + ' POR: '+ E.message);
                raise;
            end;
        end;
    finally
        ShortDateFormat := sFechaAntiguo;
        cds.Free;
        dsp.Free;
        aQ.close;
        aQ.free;
    end;
end;

{ ********************************************************************** }

function dNuevaFechaDeVencimiento ( const iCodigoVehiculo : integer;aDataBase:TSQLConnection;
                                    const cResultadoInspeccionActual,aTipo: char) : Integer;

var
    tFrecuencias : ttFrecuencias;
    tFechas : ttFechas;

    { ********************************************************************** }

    function iAntiguedadDelVehiculo (const F : ttFechas) : Integer;
    var
        rDividendo : Integer;
     begin
        //Devuelve la antigüedad "aproximada" del vehículo en meses de 30 dias
        rDividendo := F.dFechaActual - F.dFechaMatriculacion; // Obtengo sólo fechas

        if rDividendo < 0
        then raise EFechaIncorrecta.Create('La diferencia entre ' + DateToStr(F.dFechaActual) + ' y ' + DateToStr(F.dFechaMatriculacion) + ' es negativa');

       // Result := rDividendo div NUM_DIAS_MES;    CAMBIO LAURA FECHA DE VENCI>20 AÑOS
       Result := round( rDividendo / DIAS_X_MES);

    end;

    { ********************************************************************** }

    function EsReverificacion (const F: ttFechas;aDataBase:TSQLConnection) : boolean;
    begin

        // Es reverificación si la fecha de vencimiento no apto tiene valor
        // y ademas la fecha actual es inferior a la fecha límite

        With fVarios do
        begin
            Try
                Open;
                result := (F.dFechaVencimientoApto <> Trunc(StrToDateTime(SIN_FECHA))) and
                    (F.dFechaActual <= IncDate(F.dFechaVencimientoApto,StrToInt(ValueByName[FIELD_CARRY]),0,0))
            Finally
                Free;
            end;
        end;
    end;


    { ********************************************************************** }

    function ExisteCertificado(const F : ttFechas) : boolean;
    begin
        result := F.dFechaVencimientoApto <> Trunc(StrToDate(SIN_FECHA));
    end;

    { ********************************************************************** }

    function Condicion_1(const F : ttFechas; const FF : ttFrecuencias ) : boolean;
    begin
        with F, FF do
            result := (dFechaActual + (iPeriodicidad1*DIAS_X_MES))
                <
                (dFechaMatriculacion + (iLongevidad1*DIAS_X_MES))
    end;


    { ********************************************************************** }

    Function Condicion_2(const F : ttFechas) : boolean;
    begin



         {  if aTipo in ([T_REVERIFICACION,T_VOLUNTARIAREVERIFICACION])//tomar de datos de la inspeccion
            then
           result :=(((F.dFechaVencimientoApto-F.dFechaActual) >= 0) and
                   (( F.dFechaVencimientoApto-F.dFechaActual) <= (DIAS_X_MES)))
           else
               result :=(((F.dFechaVencimientoApto-F.dFechaActual) >= 0) and
                   (( F.dFechaVencimientoApto-F.dFechaActual) <= (DIAS_X_MES+DIAS_X_MES)));  }

       // 30 diasa ntes
       result :=(((F.dFechaVencimientoApto-F.dFechaActual) >= 0) and
                  (( F.dFechaVencimientoApto-F.dFechaActual) <= DIAS_X_MES))

    // 30 dias antes y despues  result := ABS(F.dFechaActual - F.dFechaVencimientoApto) <=  DIAS_X_MES
    end;


   // modificacion de 2010-09-15 para vehiculos que vienen dentro de la fecha de vencimiento
   // tienen 30 dias no 60 como antes para venir.
  // 30 antes y 30 despues asi tenian
  // ahora es hasta la fecha de vencimiento

    { ********************************************************************** }

    function Condicion_3(const F : ttFechas; const FF : ttFrecuencias ) : boolean;
    begin
        with F, FF do
            result := (dFechaVencimientoApto + (iPeriodicidad1*DIAS_X_MES))
                >=
                (dFechaMatriculacion + ((iLongevidad2 + iPeriodicidad2)*DIAS_X_MES))
    end;

    { ********************************************************************** }

    function Condicion_4(const F : ttFechas; const FF : ttFrecuencias ) : boolean;
    begin
        with F, FF do
            result := (dFechaActual + (iPeriodicidad1*DIAS_X_MES))
                >=
                (dFechaMatriculacion + ((iLongevidad2 + iPeriodicidad2)*DIAS_X_MES))
    end;

    { ********************************************************************** }

    function Condicion_5(const F : ttFechas) : boolean;
    begin
        result := ABS(F.dFechaActual - F.dFechaVencimientoApto) <= DIEZ_DIAS
    end;

    { ********************************************************************** }

    function Intervalo(const F : ttFechas) : integer;
    begin
        tFrecuencias := tFrecuenciasVehiculo(iCodigoVehiculo,aDataBase);
        if (tFrecuencias.iPeriodicidad3 <> 0) and (iAntiguedadDelVehiculo(f) >= tfrecuencias.iLongevidad3) then
          result := INTERVALO_DIEZ_DIAS_PERIODO
        else
          result := INTERVALO_DIAS_PERIODO;

    end;

begin
  try

    tFechas := tFechasVehiculo(iCodigoVehiculo,aDataBase,aTipo,cResultadoInspeccionActual);



    with tFechas, tFrecuencias do
    begin
      {$IFDEF TRAZAS}   {*}
      fTrazas.PonAnotacionFmt(TRAZA_FLUJO,1,FICHERO_ACTUAL,
                                 'Se han obtenido las fechas para el vehiculo %d -> FA: %s, FV: %s, FM: %s',
                                 [iCodigoVehiculo,
                                  FormatDateTime('dd/mm/yyyy', dFechaActual),
                                  FormatDateTime('dd/mm/yyyy',dFechaVencimientoApto),
                                  FormatDateTime('dd/mm/yyyy',dFechaMatriculacion)]);
      {$ENDIF}

     if aTipo in ([T_PREVERIFICACION]) then
     begin
       result := dFechaActual + INTERVALO_DIAS_PREVERIFICACION;
      {$IFDEF TRAZAS}    {*}
          fTrazas.PonAnotacionFmt(TRAZA_FLUJO,3,FICHERO_ACTUAL,
                                  'La inspeccion NO es APTA para el vehiculo %d -> y obtiene la fecha de vencimiento: %s',
                                   [iCodigoVehiculo, FormatDateTime('dd/mm/yyyy', result)]);
      {$ENDIF}

     end
     else
     begin


    // Si se trata de una ReVerificación, la fecha actual, es igual a la fecha tope
    // en que el vehículo debía reverificarse menos los dos meses de tope, es decir
    // la anterior fecha de vencimiento.

      if aTipo in ([T_REVERIFICACION,T_VOLUNTARIAREVERIFICACION])//tomar de datos de la inspeccion
      then begin
        if (dFechaVencimientoApto <> Trunc(StrToDateTime(SIN_FECHA))) then
          if dResultado = INSPECCION_APTA then
            dFechaActual:=dFechaVencimientoApto
          else dFechaActual := dFechaVencimientoApto - Intervalo(tfechas)
        else dFechaActual := dFechaActual - Intervalo(tfechas);//calculaR como fecha de vecimiento de la ultima inspeccion que no sea preverifiacion ni gratuita y InspFina=true
      end;
      {$IFDEF TRAZAS} {*}
      fTrazas.PonAnotacionFmt(TRAZA_FLUJO,2,FICHERO_ACTUAL,
                                 'Tras comprobar si es reverificacion se han obtenido las fechas para el vehiculo %d -> FA: %s, FVA: %s, FM: %s',
                                 [iCodigoVehiculo,
                                  FormatDateTime('dd/mm/yyyy', dFechaActual),
                                  FormatDateTime('dd/mm/yyyy',dFechaVencimientoApto),
                                  FormatDateTime('dd/mm/yyyy',dFechaMatriculacion)]);
      {$ENDIF}

    // Si no ha pasado la inspeccion se le dan dos meses de plazo, a partir de la
    // fecha actual correcta.  Si es uno de los casos especiales (+ de 9 plazas y de la provincia de buenos aires
    // se le dan sólo 10 días.

      if cResultadoInspeccionActual <> INSPECCION_APTA
      then begin
          result := dFechaActual + INTERVALO(tfechas);
          {$IFDEF TRAZAS}    {*}
          fTrazas.PonAnotacionFmt(TRAZA_FLUJO,3,FICHERO_ACTUAL,
                                  'La inspeccion NO es APTA para el vehiculo %d -> y obtiene la fecha de vencimiento: %s',
                                   [iCodigoVehiculo, FormatDateTime('dd/mm/yyyy', result)]);
          {$ENDIF}
      end
      else begin
        tFrecuencias := tFrecuenciasVehiculo(iCodigoVehiculo,aDataBase);

        {$IFDEF TRAZAS}  {*}
        fTrazas.PonAnotacionFmt(TRAZA_FLUJO,4,FICHERO_ACTUAL,
                                  'La inspeccion es APTA y se obtienen del vehiculo %d -> L1: %d, P1: %d, L2: %d, P2: %d, L3: %d, P3: %d',
                                  [iCodigoVehiculo, tFrecuencias.iLongevidad1, tFrecuencias.iPeriodicidad1, tFrecuencias.iLongevidad2, tFrecuencias.iPeriodicidad2, tFrecuencias.iLongevidad3, tFrecuencias.iPeriodicidad3]);
        {$ENDIF}

        if iAntiguedadDelVehiculo(tFechas) >= tFrecuencias.iLongevidad1
        then begin
         {$IFDEF TRAZAS}  {*}
          fTrazas.PonAnotacionFmt(TRAZA_FLUJO,5,FICHERO_ACTUAL,
                                  'El vehiculo tiene una antiguedad %d mayor a la longevidad 1 %d, (en dias)',
                                   [iAntiguedadDelVehiculo(tFechas), tFrecuencias.iLongevidad1]);

         {$ENDIF}

          if iAntiguedadDelVehiculo(tFechas) >= tFrecuencias.iLongevidad2
          then begin
           {$IFDEF TRAZAS} {*}
            fTrazas.PonAnotacionFmt(TRAZA_FLUJO,6,FICHERO_ACTUAL,
                                    'El vehiculo tiene una antiguedad %d mayor a la longevidad 2 %d, (en dias)',
                                     [iAntiguedadDelVehiculo(tFechas), tFrecuencias.iLongevidad2]);

           {$ENDIF}


            if (iAntiguedadDelVehiculo(tFechas) >= tFrecuencias.iLongevidad3) and (tFrecuencias.iPeriodicidad3 <> 0) then
            begin
              if ExisteCertificado(tFechas)
              then begin

              {$IFDEF TRAZAS} {*}
                fTrazas.PonAnotacion(TRAZA_FLUJO,7,FICHERO_ACTUAL,  'El vehiculo tiene certificada, ver la FVA');
              {$ENDIF}


                // Que la fecha actual menos la fecha de vencimiento sea inferior
                // o igual a 10 días, es decir perjudica si vienes dentro de los 10 dias
                // en que debes pasar la inspección.
                if Condicion_5(tFechas)
                then begin

                  if aTipo in ([T_REVERIFICACION,T_VOLUNTARIAREVERIFICACION]) then
                  { *******************  ALGO COMO ESTO POSIBLEMENTE SE PODRIA HACER **************
                    *******************  CON LAS NORMALES (NO CON P3) POR EL MOCO DE **************
                    *******************  ESE VENCIMIENTO QUE DA MAL  ******************************}
                  begin
                    result := dFechaActual + Round(tFrecuencias.iPeriodicidad3 * DIAS_X_MES);
                    {$IFDEF TRAZAS}      {*}
                    fTrazas.PonAnotacionFmt(TRAZA_FLUJO,8,FICHERO_ACTUAL,  'El vehiculo cumple la condicion 5 y es Reverificación y da como fecha de vencimiento %s',
                                      [FormatDateTime('dd/mm/yyyy', result)]);
                    {$ENDIF}

                  end
                  else begin
                    result := dFechaVencimientoApto + Round(tFrecuencias.iPeriodicidad3 * DIAS_X_MES);
                    {$IFDEF TRAZAS}      {*}
                    fTrazas.PonAnotacionFmt(TRAZA_FLUJO,8,FICHERO_ACTUAL,  'El vehiculo cumple la condicion 5 y da como fecha de vencimiento %s',
                                      [FormatDateTime('dd/mm/yyyy', result)]);
                    {$ENDIF}
                  end;
                end
                else begin
                  result := dFechaActual + Round((tFrecuencias.iPeriodicidad3 * DIAS_X_MES));
                  {$IFDEF TRAZAS}   {*}
                  fTrazas.PonAnotacionFmt(TRAZA_FLUJO,9,FICHERO_ACTUAL,  'El vehiculo NO cumple la condicion 5 y da como fecha de vencimiento %s',
                                      [FormatDateTime('dd/mm/yyyy', result)]);
                  {$ENDIF}
                end;
              end
              else begin
                result := dFechaActual + Round(tFrecuencias.iPeriodicidad3 * DIAS_X_MES);
                {$IFDEF TRAZAS} {*}
                fTrazas.PonAnotacionFmt(TRAZA_FLUJO,10,FICHERO_ACTUAL, 'El vehiculo NO tiene certificado y da como fecha de vencimiento %s',
                                   [FormatDateTime('dd/mm/yyyy', result)]);
                {$ENDIF}
              end;
            end
            else
            begin
              if ExisteCertificado(tFechas)
              then begin

              {$IFDEF TRAZAS} {*}
                fTrazas.PonAnotacion(TRAZA_FLUJO,7,FICHERO_ACTUAL,  'El vehiculo tiene certificada, ver la FVA');
              {$ENDIF}


                // Que la fecha actual menos la fecha de vencimiento sea inferior
                // o igual a un mes, es decir perjudica si vienes dentro del mes
                // en que debes pasar la inspección.
                if Condicion_2(tFechas)
                then begin
                  result := dFechaVencimientoApto + Round(tFrecuencias.iPeriodicidad2 * DIAS_X_MES);
                  {$IFDEF TRAZAS}      {*}
                  fTrazas.PonAnotacionFmt(TRAZA_FLUJO,8,FICHERO_ACTUAL,  'El vehiculo cumple la condicion 2 y da como fecha de vencimiento %s',
                                      [FormatDateTime('dd/mm/yyyy', result)]);
                  {$ENDIF}
                end
                else begin
                  result := dFechaActual + Round((tFrecuencias.iPeriodicidad2 * DIAS_X_MES));
                  {$IFDEF TRAZAS}   {*}
                  fTrazas.PonAnotacionFmt(TRAZA_FLUJO,9,FICHERO_ACTUAL, ' El vehiculo NO cumple la condicion 2 y da como fecha de vencimiento %s',
                                      [FormatDateTime('dd/mm/yyyy', result)]);
                  {$ENDIF}
                end;
              end
              else begin
                result := dFechaActual + Round(tFrecuencias.iPeriodicidad2 * DIAS_X_MES);
                {$IFDEF TRAZAS} {*}
                fTrazas.PonAnotacionFmt(TRAZA_FLUJO,10,FICHERO_ACTUAL, 'El vehiculo NO tiene certificado y da como fecha de vencimiento %s',
                                   [FormatDateTime('dd/mm/yyyy', result)]);
                {$ENDIF}
              end;
            end;
          end
          else begin
           {$IFDEF TRAZAS} {*}
            fTrazas.PonAnotacionFmt(TRAZA_FLUJO,11,FICHERO_ACTUAL,
                                    'El vehiculo tiene una antiguedad %d menor a la longevidad 2 %d, (en dias)',
                                     [iAntiguedadDelVehiculo(tFechas), tFrecuencias.iLongevidad2]);

           {$ENDIF}

            if ExisteCertificado(tFechas)
            then begin
            {$IFDEF TRAZAS} {*}
              fTrazas.PonAnotacion(TRAZA_FLUJO,12,FICHERO_ACTUAL,  'El vehiculo tiene certificada, ver la FVA, o FVNA');
            {$ENDIF}


              // Que la fecha actual menos la fecha de vencimiento sea inferior
              // o igual a un mes, es decir perjudica si vienes dentro del mes
              // en que debes pasar la inspección.
              if Condicion_2(tFechas)
              then begin
              {$IFDEF TRAZAS} {*}
                fTrazas.PonAnotacion(TRAZA_FLUJO,13,FICHERO_ACTUAL,  'El vehiculo cumple la condicion 2 ');
              {$ENDIF}



                // Que la fecha de vencimiento mas la periodicidad 1 sea mayor o
                // igual que la fecha de matriculacion mas la longevidad y la
                // periodicidad 2.
                if Condicion_3(tFechas, tFrecuencias)
                then begin
                  result := dFechaMatriculacion + Round((tFrecuencias.iLongevidad2 + tFrecuencias.iPeriodicidad2) * DIAS_X_MES);

                {$IFDEF TRAZAS} {*}
                  fTrazas.PonAnotacionFmt(TRAZA_FLUJO,14,FICHERO_ACTUAL,  'El vehiculo cumple la condicion 3 y da como fecha de vencimiento %s',
                                        [FormatDateTime('dd/mm/yyyy', result)]);
                {$ENDIF}


                end
                else begin

                  result := dFechaVencimientoApto + Round(tFrecuencias.iPeriodicidad1 * DIAS_X_MES);

                {$IFDEF TRAZAS} {*}
                  fTrazas.PonAnotacionFmt(TRAZA_FLUJO,15,FICHERO_ACTUAL,  'El vehiculo NO cumple la condicion 3 y da como fecha de vencimiento %s',
                                        [FormatDateTime('dd/mm/yyyy', result)]);
                {$ENDIF}
                end
              end
              else begin
             {$IFDEF TRAZAS}  {*}
               fTrazas.PonAnotacion(TRAZA_FLUJO,16,FICHERO_ACTUAL,  'El vehiculo NO cumple la condicion 2');
             {$ENDIF}

                // Que la fecha actual mas la periodicidad 1 sea mayor o
                // igual que la fecha de matriculacion mas la longevidad y la
                // periodicidad 2.
                if Condicion_4(tFechas, tFrecuencias)
                then begin
                  result := dFechaMatriculacion + Round((tFrecuencias.iLongevidad2 + tFrecuencias.iPeriodicidad2) * DIAS_X_MES);
                {$IFDEF TRAZAS} {*}
                  fTrazas.PonAnotacionFmt(TRAZA_FLUJO,17,FICHERO_ACTUAL,  'El vehiculo cumple la condicion 4 y da como fecha de vencimiento %s',
                                        [FormatDateTime('dd/mm/yyyy', result)]);
                {$ENDIF}

                end
                else begin
                  result := dFechaActual + Round(tFrecuencias.iPeriodicidad1 * DIAS_X_MES);
                {$IFDEF TRAZAS} {*}
                  fTrazas.PonAnotacionFmt(TRAZA_FLUJO,18,FICHERO_ACTUAL,  'El vehiculo NO cumple la condicion 4 y da como fecha de vencimiento %s',
                                        [FormatDateTime('dd/mm/yyyy', result)]);
                {$ENDIF}
                end
              end;
            end
            else begin
            {$IFDEF TRAZAS}   {*}
               fTrazas.PonAnotacion(TRAZA_FLUJO,19,FICHERO_ACTUAL, 'El vehiculo NO tiene certificado');
            {$ENDIF}


              // Que la fecha actual mas la periodicidad 1 sea mayor o
              // igual que la fecha de matriculacion mas la longevidad y la
              // periodicidad 2.
              if Condicion_4(tFechas, tFrecuencias)
              then begin
                result := dFechaMatriculacion + Round((tFrecuencias.iLongevidad2 + tFrecuencias.iPeriodicidad2) * DIAS_X_MES);
                {$IFDEF TRAZAS} {*}
                  fTrazas.PonAnotacionFmt(TRAZA_FLUJO,20,FICHERO_ACTUAL,  'El vehiculo cumple la condicion 4 y da como fecha de vencimiento %s',
                                        [FormatDateTime('dd/mm/yyyy', result)]);
                {$ENDIF}

              end
              else begin
               result := dFechaActual + Round(tFrecuencias.iPeriodicidad1 * DIAS_X_MES);
                {$IFDEF TRAZAS}  {*}
                  fTrazas.PonAnotacionFmt(TRAZA_FLUJO,21,FICHERO_ACTUAL,  'El vehiculo NO cumple la condicion 4 y da como fecha de vencimiento %s',
                                        [FormatDateTime('dd/mm/yyyy', result)]);
                {$ENDIF}
              end
            end;
          end;
        end
        else begin
        {$IFDEF TRAZAS}   {*}
          fTrazas.PonAnotacionFmt(TRAZA_FLUJO,22,FICHERO_ACTUAL,
                                   'El vehiculo tiene una antiguedad %d menor a la longevidad 1 %d, (en dias)',
                                   [iAntiguedadDelVehiculo(tFechas), tFrecuencias.iLongevidad1]);

         {$ENDIF}

          // Que la fecha actual mas la periodicidad 1 sea menor que la
          // fecha de matriculación mas la longevidad 1.
          if Condicion_1(tFechas, tFrecuencias)
          then begin
            result := dFechaMatriculacion + Round(tFrecuencias.iLongevidad1 * DIAS_X_MES);
           {$IFDEF TRAZAS} {*}
               fTrazas.PonAnotacionFmt(TRAZA_FLUJO,23,FICHERO_ACTUAL,  'El vehiculo cumple la condicion 1 y da como fecha de vencimiento %s',
                                        [FormatDateTime('dd/mm/yyyy', result)]);
           {$ENDIF}
          end
          else begin
            result := dFechaActual + Round(tFrecuencias.iPeriodicidad1 * DIAS_X_MES);
           {$IFDEF TRAZAS} {*}
               fTrazas.PonAnotacionFmt(TRAZA_FLUJO,24,FICHERO_ACTUAL,  'El vehiculo NO cumple la condicion 1 y da como fecha de vencimiento %s',
                                        [FormatDateTime('dd/mm/yyyy', result)]);
           {$ENDIF}
          end;
        end;
      end;
     end;
    end;
  except
    on E:Exception do
    begin
      FAnomalias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL, 'Error al Calcular Periodicidad' + E.Message);
      raise;
    end;
  end;
end;

Function ObtieneFechaReve( const iCodigoVehiculo : integer;aDataBase:TSQLConnection; const cResultadoInspeccionActual:char) : ttFechasReve;
var
    aq: TSQLDataSet;
    dsp : tDatasetprovider;
    cds : tClientDataSet;
    dFechaInspeccion: integer;
    FRECUENCIAS : ttFrecuencias;
begin
    try
      Result.dResultado:=cResultadoInspeccionActual;  // VER RAN
      aQ := TSQLDataSet.Create(application);
      aQ.SQLConnection := aDataBase;
      aQ.CommandType := ctQuery;
      aQ.GetMetadata := false;
      aQ.NoMetadata := true;
      aQ.ParamCheck := false;

      dsp := TDataSetProvider.Create(application);
      dsp.DataSet := aQ;
      dsp.Options := [poIncFieldProps,poAllowCommandText];

      cds:=TClientDataSet.Create(application);
      with cds do
      try
        SetProvider(dsp);
        if result.dresultado <> INSPECCION_APTA then  //
        begin
            CommandText:= (Format('SELECT TO_CHAR(FECVENCI, ''DD/MM/YYYY''), RESULTAD FROM TINSPECCION  I ' +
                            ' WHERE (CODVEHIC = %D) AND (INSPFINA=''S'') AND (TIPO IN (''%S'',''%S'',''%S'',''%S''))' +
                            ' AND NOT EXISTS (SELECT ''X'' FROM TFACTURAS F ' +
                            ' WHERE F.CODFACTU = I.CODFACTU AND CODCOFAC IS NOT NULL )' +
                            ' ORDER BY FECHALTA DESC',[iCodigoVehiculo,T_NORMAL,T_REVERIFICACION,T_VOLUNTARIA,T_VOLUNTARIAREVERIFICACION]));
            open;
            Result.dFechaVencimientoApto:=Trunc(StrToDate(Fields[0].AsString));
            result.dResultado := cResultadoInspeccionActual;
        end
        else
        begin
          CommandText:= (Format('SELECT TO_CHAR(FECVENCI, ''DD/MM/YYYY'') FROM TINSPECCION  I ' +
                        ' WHERE (CODVEHIC = %D) AND (INSPFINA=''S'') AND (TIPO IN (''%S'',''%S'',''%S'',''%S'')) AND (RESULTAD =''%S'' )' +
                        ' AND NOT EXISTS (SELECT ''X'' FROM TFACTURAS F ' +
                        ' WHERE F.CODFACTU = I.CODFACTU AND CODCOFAC IS NOT NULL )' +
                        ' ORDER BY FECHALTA DESC',[iCodigoVehiculo,T_NORMAL,T_REVERIFICACION,T_VOLUNTARIA,T_VOLUNTARIAREVERIFICACION,INSPECCION_APTA]));
          result.dResultado := INSPECCION_APTA;   //1 equivale a Apto
          open;

          frecuencias := tFrecuenciasVehiculo(iCodigoVehiculo,mybd);

          if RecordCount > 0 then
          begin
            Result.dFechaVencimientoApto:=Trunc(StrToDate(Fields[0].AsString));
            // voy a buscar la fecha de la verificación que originó la reve
            close;
            SetProvider(dsp);

            CommandText:= (Format('SELECT TO_CHAR(FECVENCI, ''DD/MM/YYYY''),TO_CHAR(FECHALTA, ''DD/MM/YYYY''),RESULTAD FROM TINSPECCION I' +
            ' WHERE (CODVEHIC = %D) AND (INSPFINA=''S'') AND (TIPO IN (''%S'',''%S''))' +
            ' AND NOT EXISTS (SELECT ''X'' FROM TFACTURAS F ' +
            ' WHERE F.CODFACTU = I.CODFACTU AND CODCOFAC IS NOT NULL )' +
            ' ORDER BY FECHALTA DESC',[iCodigoVehiculo,T_NORMAL,T_VOLUNTARIA]));




            Open;
            dFechaInspeccion:=Trunc(StrToDate(Fields[1].AsString));
            // si se distancia en mod(30) de la fecha de la verificacion que originó
            // la reve. Se cortó la historia y tomo como fecha buena, la fecha de vencimiento de la verificacion
            // Tomo la fecha de vencimiento para standarizar segun el resultado el tratamiento
            // en la funcion dNuevaFechaVencimiento (podría tomar la fecha de verificacion)



            if Frecuencias.iPeriodicidad3 <> 0 then
            begin
                // if abs(dFechaInspeccion - Result.dFechaVencimientoApto) > DIEZ_DIAS then
                 if  (((dFechaInspeccion - Result.dFechaVencimientoApto) >=0 )or
                     ((dFechaInspeccion - Result.dFechaVencimientoApto)< (-1*DIEZ_DIAS))) then
                 begin
                      Result.dFechaVencimientoApto:=Trunc(StrToDate(Fields[0].AsString));
                      if FIELDS[2].ASSTRING = INSPECCION_APTA then  //   MODI RAN
                         Result.dResultado:=INSPECCION_APTA
                      else Result.dResultado:='C';
                 end;
            end
            else
            begin
              // if abs(dFechaInspeccion - Result.dFechaVencimientoApto) > DIAS_X_MES  then
                if (((dFechaInspeccion - Result.dFechaVencimientoApto) >=0 )or
                     ((dFechaInspeccion - Result.dFechaVencimientoApto)< (-1*(DIAS_X_MES)))) then


                 begin
                       Result.dFechaVencimientoApto:=Trunc(StrToDate(Fields[0].AsString));
                      if FIELDS[2].ASSTRING = INSPECCION_APTA then  //   MODI RAN
                         Result.dResultado:=INSPECCION_APTA

                      else Result.dResultado:='C';
                 end;









                 FechaVencModificada(result.dFechaVencimientoApto,result.dresultado,iCodigoVehiculo, aDataBase); // MODFECHA
            end;
          end
          else
          begin
            close;
            SetProvider(dsp);
            {
            CommandText:= (Format('SELECT TO_CHAR(FECVENCI, ''DD/MM/YYYY''), RESULTAD FROM TINSPECCION ' +
                            ' WHERE (CODVEHIC = %D) AND (INSPFINA=''S'') AND (TIPO IN (''%S'',''%S''))' +
                            ' ORDER BY FECHALTA DESC',[iCodigoVehiculo,T_NORMAL,T_REVERIFICACION,T_VOLUNTARIA,T_VOLUNTARIAREVERIFICACION]));

          }

          CommandText:= (Format('SELECT TO_CHAR(FECVENCI, ''DD/MM/YYYY''), RESULTAD FROM TINSPECCION I' +
                            ' WHERE (CODVEHIC = %D) AND (INSPFINA=''S'') AND (TIPO IN (''%S'',''%S'',''%S'',''%S''))' +
                            ' AND NOT EXISTS (SELECT ''X'' FROM TFACTURAS F ' +
                            ' WHERE F.CODFACTU = I.CODFACTU AND CODCOFAC IS NOT NULL )' +
                            ' ORDER BY FECHALTA DESC',[iCodigoVehiculo,T_NORMAL,T_REVERIFICACION,T_VOLUNTARIA,T_VOLUNTARIAREVERIFICACION]));



            open;
            result.dFechaVencimientoApto:=Trunc(StrToDate(Fields[0].AsString));

            if Frecuencias.iPeriodicidad3 = 0 then
              FechaVencModificada(result.dFechaVencimientoApto,result.dresultado,iCodigoVehiculo, aDataBase); // MODFECHA

            if FIELDS[1].ASSTRING = INSPECCION_APTA then  //   MODI RAN
                  Result.dResultado:=INSPECCION_APTA
           else if FIELDS[1].ASSTRING = INSPECCION_CONDICIONAL then
                    Result.dResultado:=INSPECCION_CONDICIONAL
                else
                    Result.dResultado:='R';

          end;
        end;
      except
             on E : Exception do
             begin
               fIncidencias.PonAnotacion(0,0,FICHERO_ACTUAL,'ERROR OTENIENDO LAS FECHAS DEL VEHICULO REVERIFICADO ' + IntToStr(iCodigoVehiculo) + ' POR: '+ E.message);
               raise;
             end;
      end;
    finally
          cds.Free;
          dsp.Free;
          aQ.close;
          aQ.free;
    end;
end;

procedure FechaVencModificada( var iFechaVencimiento: integer; var iresultado: char; const iCodigoVehiculo : integer; const adatabase: tSQLConnection);
var Consulta: tsqlquery;
    fCambios: tCambiosFecha;
begin
  Consulta:=TsqlQuery.create(application);
  with consulta do
    try
      sqlconnection:=aDataBase;
      SQL.Add (Format('SELECT EJERCICI, CODINSPE FROM TINSPECCION I' +
            ' WHERE (CODVEHIC = %D) AND (INSPFINA=''S'') AND (TIPO IN (''%S'',''%S''))' +
            ' AND NOT EXISTS (SELECT ''X'' FROM TFACTURAS F ' +
            ' WHERE F.CODFACTU = I.CODFACTU AND CODCOFAC IS NOT NULL )' +
            ' ORDER BY FECHALTA DESC',[iCodigoVehiculo,T_NORMAL, T_VOLUNTARIA]));
      open;
      fCambios:=tCambiosFecha.CreateByCodEjer(aDataBase,fields[0].asstring,fields[1].AsString);
      fCambios.open;
      if fCambios.recordcount > 0 then
      begin
        fCambios.first;
        iFechaVencimiento:=Trunc(StrToDate(fCambios.valuebyname[FIELD_FECHA_V_OLD]));
        iresultado:=INSPECCION_CONDICIONAL;
      end;
      fCambios.close;
      fCambios.free;
    finally
      free;
    end;
end;
 procedure FechaVencModificadaReve( var iFechaVencimiento: integer; var iresultado: char; const iCodigoVehiculo : integer; const adatabase: tSQLConnection);
var Consulta: tsqlquery;
    fCambios: tCambiosFecha;
begin
  Consulta:=TsqlQuery.create(application);
  with consulta do
    try
      sqlconnection:=aDataBase;
      SQL.Add (Format('SELECT EJERCICI, CODINSPE FROM TINSPECCIONEXTERNA ' +
            ' WHERE (CODVEHIC = %D) ORDER BY FECHALTA DESC',[iCodigoVehiculo]));
      open;
      fCambios:=tCambiosFecha.CreateByCodEjer(aDataBase,fields[0].asstring,fields[1].AsString);
      fCambios.open;
      if fCambios.recordcount > 0 then
      begin
        fCambios.first;
        iFechaVencimiento:=Trunc(StrToDate(fCambios.valuebyname[FIELD_FECHA_V_OLD]));
        iresultado:=INSPECCION_CONDICIONAL;
      end;
      fCambios.close;
      fCambios.free;
    finally
      free;
    end;
end;

Function ObtieneFechaReveExterna( const iCodigoVehiculo : integer;aDataBase:TSQLConnection; const cResultadoInspeccionActual:char) : ttFechasReve;
var
    aq: TSQLDataSet;
    dsp : tDatasetprovider;
    cds : tClientDataSet;
    dFechaInspeccion: integer;
    FRECUENCIAS : ttFrecuencias;
begin
    try
      Result.dResultado:=cResultadoInspeccionActual;
      aQ := TSQLDataSet.Create(application);
      aQ.SQLConnection := aDataBase;
      aQ.CommandType := ctQuery;
      aQ.GetMetadata := false;
      aQ.NoMetadata := true;
      aQ.ParamCheck := false;

      dsp := TDataSetProvider.Create(application);
      dsp.DataSet := aQ;
      dsp.Options := [poIncFieldProps,poAllowCommandText];

      cds:=TClientDataSet.Create(application);
      with cds do
      try
        SetProvider(dsp);
        if result.dresultado <> INSPECCION_APTA then  //
        begin
            CommandText:= (Format('SELECT TO_CHAR(FECVENCI, ''DD/MM/YYYY''), RESULTAD FROM TINSPECCIONEXTERNA ' +
                            ' WHERE (CODVEHIC = %D) ORDER BY FECHALTA DESC',[iCodigoVehiculo]));
            open;
            Result.dFechaVencimientoApto:=Trunc(StrToDate(Fields[0].AsString));
            result.dResultado := cResultadoInspeccionActual;
        end
        else
        begin
          CommandText:= (Format('SELECT TO_CHAR(FECHAVERI, ''DD/MM/YYYY'') FROM TINSPECCIONEXTERNA ' +
                        ' WHERE (CODVEHIC = %D) ORDER BY FECHALTA DESC',[iCodigoVehiculo]));
          result.dResultado := INSPECCION_APTA;   //1 equivale a Apto
          open;

          frecuencias := tFrecuenciasVehiculo(iCodigoVehiculo,mybd);

          if RecordCount > 0 then
          begin
            Result.dFechaVencimientoApto:=Trunc(StrToDate(Fields[0].AsString));
            // voy a buscar la fecha de la verificación que originó la reve
            close;
            SetProvider(dsp);
            CommandText:= (Format('SELECT TO_CHAR(FECVENCI, ''DD/MM/YYYY''),TO_CHAR(FECHALTA, ''DD/MM/YYYY''),RESULTAD FROM TINSPECCIONEXTERNA ' +
            ' WHERE (CODVEHIC = %D) ORDER BY FECHALTA DESC',[iCodigoVehiculo]));
            Open;
            dFechaInspeccion:=Trunc(StrToDate(Fields[1].AsString));
            // si se distancia en mod(30) de la fecha de la verificacion que originó
            // la reve. Se cortó la historia y tomo como fecha buena, la fecha de vencimiento de la verificacion
            // Tomo la fecha de vencimiento para standarizar segun el resultado el tratamiento
            // en la funcion dNuevaFechaVencimiento (podría tomar la fecha de verificacion)



            if Frecuencias.iPeriodicidad3 <> 0 then
            begin
               // mla if abs(dFechaInspeccion - Result.dFechaVencimientoApto) > DIEZ_DIAS then
                   if  (((dFechaInspeccion - Result.dFechaVencimientoApto) >=0 )or
                     ((dFechaInspeccion - Result.dFechaVencimientoApto)< (-1*DIEZ_DIAS))) then
                 begin
                      Result.dFechaVencimientoApto:=Trunc(StrToDate(Fields[0].AsString));
                      if FIELDS[2].ASSTRING = INSPECCION_APTA then  //   MODI RAN
                         Result.dResultado:=INSPECCION_APTA
                      else Result.dResultado:='C';
                 end;
            end
            else
            begin
                //mla if abs(dFechaInspeccion - Result.dFechaVencimientoApto) >  then
                    if  (((dFechaInspeccion - Result.dFechaVencimientoApto) >=0 )or
                     ((dFechaInspeccion - Result.dFechaVencimientoApto)< (-1*(DIAS_X_MES)))) then
                 begin
                      Result.dFechaVencimientoApto:=Trunc(StrToDate(Fields[0].AsString));
                      if FIELDS[2].ASSTRING = INSPECCION_APTA then  //   MODI RAN
                         Result.dResultado:=INSPECCION_APTA
                      else Result.dResultado:='C';
                 end;
                 FechaVencModificadaReve(result.dFechaVencimientoApto,result.dresultado,iCodigoVehiculo, aDataBase); // MODFECHA
            end;
          end
          else
          begin
            close;
            SetProvider(dsp);
            CommandText:= (Format('SELECT TO_CHAR(FECVENCI, ''DD/MM/YYYY''), RESULTAD FROM TINSPECCIONEXTERNA ' +
                            ' WHERE (CODVEHIC = %D) ORDER BY FECHALTA DESC',[iCodigoVehiculo]));
            open;
            result.dFechaVencimientoApto:=Trunc(StrToDate(Fields[0].AsString));

            if Frecuencias.iPeriodicidad3 = 0 then
              FechaVencModificadaReve(result.dFechaVencimientoApto,result.dresultado,iCodigoVehiculo, aDataBase); // MODFECHA

            if FIELDS[1].ASSTRING = INSPECCION_APTA then  //   MODI RAN
                  Result.dResultado:=INSPECCION_APTA
           else if FIELDS[1].ASSTRING = INSPECCION_CONDICIONAL then
                    Result.dResultado:=INSPECCION_CONDICIONAL
                else
                    Result.dResultado:='R';

          end;
        end;
      except
             on E : Exception do
             begin
               fIncidencias.PonAnotacion(0,0,FICHERO_ACTUAL,'ERROR OTENIENDO LAS FECHAS DEL VEHICULO REVERIFICADO ' + IntToStr(iCodigoVehiculo) + ' POR: '+ E.message);
               raise;
             end;
      end;
    finally
          cds.Free;
          dsp.Free;
          aQ.close;
          aQ.free;
    end;
end;
end.//Final de la unidad

