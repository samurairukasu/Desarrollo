unit UtilOracle;
//Utilidades para Oracle

interface
Uses DB,DBTables, Variants;


function DateTimeBD (const aBD: TDatabase): string;
function DateBD (const aBD: TDatabase): string;
function TimeBD (const aBD: TDatabase): string;


//Devuelve la representación en cadena del valor de un campo para colocarlo
//en una sentencia SQL
Function FieldQueryValue(Tipo:TFieldType;Value:Variant):string;

//Convierte un TDateTime a una expresión de fecha para Oracle
Function OracleDateStr(T:TDateTime):string;
//Convierte un string a un formato que Oracle entienda. Por ejemplo, si una cadena contiene
//el carácter ' lo sustituye por dos ''. Además coloca las comillas inicial y final.
Function OracleStr(CONST s:String):String;
//Convierte un número en coma flotante a cadena para insertar en sentencias SQL
Function OracleFloatStr(d:Double):String;
//Convierte una cadena con comodines * y ? en comodines Oracle
Function OracleLikeExpr(CONST s:String):String;
// Dada una excepcion de tipo eBDEngineError devuelve el código de error nativo de la BD
Function CodigoError(e:EDBEngineError):Integer;
// Dada una excepcion de tipo eBDEngineError devuelve el código de error nativo de la BD
Function ErrorNativo(e:EDBEngineError):Integer;
// Dada una excepcion de tipo eBDEngineError dice si ha ocurrido un error nativo del tipo indicado
Function HuboErrorNativo(e:EDBEngineError;Codigo:Integer):Boolean;

implementation
Uses SysUtils;

const
    FMTFH='yyyymmdd hhnnss';  //Formato de fecha utilizado para conversiones
    FMTFHORACLE='YYYYMMDD HH24MISS'; //Formato de fecha/hora de Oracle equivalente al anterior


    function TimeBD (const aBD: TDatabase): string;
    var
        hora : string;
        aQ: TQuery;
    begin
        hora := FormatDateTime('hh:nn:ss',now);
        aQ := TQuery.Create(nil);
        try
            with aQ do
            try
                DataBaseName := aBD.DatabaseName;
                SessionName  := aBD.SessionName;
                SQL.Add('SELECT TO_CHAR(SYSDATE,''HH24:MI:SS'') FROM DUAL');
                Open;
                hora := Fields[0].AsString;
            except
                on E: Exception do;
                    //fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Falló la lectura de la hora por: %s',[E.message]);
            end
        finally
            aQ.Close;
            aQ.Free;
            result := hora;
        end
    end;

    function DateBD (const aBD: TDatabase): string;
    var
        hora : string;
        aQ: TQuery;
    begin
        hora := FormatDateTime('dd/mm/yyyy',now);
        aQ := TQuery.Create(nil);
        try
            with aQ do
            try
                DataBaseName := aBD.DatabaseName;
                SessionName  := aBD.SessionName;
                SQL.Add('SELECT TO_CHAR(SYSDATE,''DD/MM/YYYY'') FROM DUAL');
                Open;
                hora := Fields[0].AsString;
            except
                on E: Exception do;
                    //fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Falló la lectura de la fecha por: %s',[E.message]);
            end
        finally
            aQ.Close;
            aQ.Free;
            result := hora;
        end
    end;

    function DateTimeBD (const aBD: TDatabase): string;
    var
        hora : string;
        aQ: TQuery;
    begin
        hora := FormatDateTime('dd/mm/yyyy hh:nn:ss',now);
        aQ := TQuery.Create(nil);
        try
            with aQ do
            try
                DataBaseName := aBD.DatabaseName;
                SessionName  := aBD.SessionName;
                SQL.Add('SELECT TO_CHAR(SYSDATE,''DD/MM/YYYY HH24:MI:SS'') FROM DUAL');
                Open;
                hora := Fields[0].AsString;
            except
                on E: Exception do;
                    //fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Falló la lectura de la fecha y hora por: %s',[E.message]);
            end
        finally
            aQ.Close;
            aQ.Free;
            result := hora;
        end
    end;


//Convierte un TDateTime a una expresión de fecha para Oracle
Function OracleDateStr(T:TDateTime):string;
begin
     Result:='TO_DATE('''+FormatDateTime(FMTFH,T)+''','''+FMTFHORACLE+''')';
end;

//Convierte un string a un formato que Oracle entienda. Por ejemplo, si una cadena contiene
//el carácter ' lo sustituye por dos ''. Además coloca las comillas inicial y final.
Function OracleStr(CONST s:String):String;
VAR
   i:Integer;
BEGIN
     IF Pos('''',s)=0
        THEN Result:=s
        ELSE BEGIN
                  Result:='';
                  FOR i:=1 TO Length(s) DO
                  BEGIN
                       IF s[i]='''' THEN Result:=Result+'''';
                       Result:=Result+s[i]
                  END
             END;
     Result:=''''+Result+''''
END;

//Convierte un número en coma flotante a cadena para insertar en sentencias SQL
Function OracleFloatStr(d:Double):String;
BEGIN
     Result:='TO_NUMBER('+''''+FloatToStr(d)+''''+')'
END;

//Convierte una cadena con comodines * y ? en comodines Oracle
Function OracleLikeExpr(CONST s:String):String;
VAR
   i:Integer;
BEGIN
     Result:=s;
     FOR i:=1 TO Length(Result) DO
         CASE Result[i] OF
              '?':Result[i]:='_';
              '*':Result[i]:='%'
         END
END;

Function FieldQueryValue(Tipo:TFieldType;Value:Variant):string;
begin
    if VarType(Value)=varEmpty
    then Result:='NULL'
    else begin
        case tipo of
            ftString:Result:=OracleStr(Value);
            ftSmallint,
            ftInteger,
            ftWord:Result:=IntToStr(Value);
            ftBoolean:Result:=IntToStr(Integer(Boolean(Value)));
            ftFloat,
            ftCurrency,
            ftBCD:Result:=OracleFloatStr(Value);
            ftDate,
            ftTime,
            ftDateTime:Result:=OracleDateStr(VarToDateTime(Value));
            else raise Exception.Create('Tipo de campo no insertable')
        end
    end
end;

// Dada una excepcion de tipo eBDEngineError devuelve el código de error nativo de la BD
Function CodigoError(e:EDBEngineError):Integer;
VAR
   i:Integer;
BEGIN
     Result:=0;
     FOR i:=0 TO e.ErrorCount-1 DO
     BEGIN
          Result:=e.Errors[i].ErrorCode;
          IF Result<>0
            THEN exit
     END
END;


// Dada una excepcion de tipo eBDEngineError devuelve el código de error nativo de la BD
Function ErrorNativo(e:EDBEngineError):Integer;
VAR
   i:Integer;
BEGIN
     Result:=0;
     FOR i:=0 TO e.ErrorCount-1 DO
     BEGIN
          Result:=e.Errors[i].NativeError;
          IF Result<>0
            THEN exit
     END
END;

// Dada una excepcion de tipo eBDEngineError dice si ha ocurrido un error nativo del tipo indicado
Function HuboErrorNativo(e:EDBEngineError;Codigo:Integer):Boolean;
VAR
   i:Integer;
BEGIN
     Result:=False;
     FOR i:=0 TO e.ErrorCount-1 DO
     BEGIN
          Result:=e.Errors[i].NativeError=Codigo;
          IF Result
            THEN exit
     END
END;

end.
