unit UImprime;

interface

uses
  QuickRpt,
  qrprntr,
  Qr3Const,
  SysUtils,
  Printers,
  Forms,
  Messages,
  USAGPrinters,
  GLOBALS,
  USAGCLASSES;

////////////////////////////////////////////////////////////////////////////////////////////////////
//    La clase TimpresorasPampa, se encuentra en la unit USAGPrinters. La mayoria de las veces    //
//    ocurria que al buildear el serv de impresion, no veia esta unit en el directorio del SAG    //
//    ya que ahi se encontraba, probe con pasarme esa unit a la misma carpeta del servidor de     //
//    impresion, evitando el compartimiento de la misma, y al buildear lo hizo sin problemas      //
//////////////////////////////////////////////////////////////////////////////////////////////////// 



procedure ImprimirInforme ( const iUnHandle, iUnEjercicio, iUnCodigo : LONGINT;
                            const UnaImpresora : TImpresorasPampa; const bDirecto : boolean );

procedure ImprimirCertificado( const iUnHandle, iUnEjercicio, iUnCodigo : LONGINT;
                               const UnaImpresora : TImpresorasPampa );


procedure ImprimirFacturaA( const iUnHandle, iUnEjercicio, iUnCodigo : LONGINT;
                            const UnaImpresora : TImpresorasPampa;
                            const bEsNota : boolean);

procedure ImprimirFacturaB( const iUnHandle, iUnEjercicio, iUnCodigo : LONGINT;
                            const UnaImpresora : TImpresorasPampa;
                            const bEsNota : boolean);


procedure ImprimirNCDescuentoA( const iUnHandle, iUnEjercicio, iUnCodigo : LONGINT;    //AGRE RAN
                            const UnaImpresora : TImpresorasPampa;
                            const bEsNota : boolean);

procedure ImprimirNCDescuentoB( const iUnHandle, iUnEjercicio, iUnCodigo : LONGINT;    //AGRE RAN
                            const UnaImpresora : TImpresorasPampa;
                            const bEsNota : boolean);

procedure ImprimirMediciones ( const iUnHandle, iUnEjercicio, iUnCodigo : LONGINT;     //AGRE RAN MEDI
                            const UnaImpresora : TImpresorasPampa; const bDirecto : boolean );

procedure ImprimirTAmarilla ( const iUnHandle, iUnEjercicio, iUnCodigo : LONGINT;
                               const UnaImpresora : TImpresorasPampa );

//procedure ImprimirInformeGNC ( const iUnHandle, iUnEjercicio, iUnCodigo : integer;
//                            const UnaImpresora : TImpresorasPampa; const bDirecto : boolean );
procedure ImprimirInformeGNC( const iUnHandle, iUnEjercicio, iUnCodigo : integer;
                               const UnaImpresora : TImpresorasPampa );

procedure ImprimirFacturaAGNC( const iUnHandle, iUnEjercicio, iUnCodigo : LONGINT;
                            const UnaImpresora : TImpresorasPampa;
                            const bEsNota : boolean);

procedure ImprimirFacturaBGNC( const iUnHandle, iUnEjercicio, iUnCodigo : LONGINT;
                            const UnaImpresora : TImpresorasPampa;
                            const bEsNota : boolean);



function TratamientodeFacturacion(var aF:TFacturacion; const iUnEjercicio, iUnCodigo,iUnHandle : LONGINT;const ftipo:string):boolean;
function TratamientoDeContraFacturacion(var caF : TContraFacturas; const iUnEjercicio, iUnCodigo, iUnHandle : LONGINT;const ftipo: string): boolean;
function TratamientoDeNCDescuento(var aF:TFacturacion; const iUnEjercicio, iUnCodigo, iUnHandle : LONGINT;const ftipo: string): boolean;  //AGRE RAN

function TratamientodeFacturacionGNC(var aF:TFacturacion; const iUnEjercicio, iUnCodigo,iUnHandle : LONGINT;const ftipo:string):boolean;
function TratamientoDeContraFacturacionGNC(var caF : TContraFacturas; const iUnEjercicio, iUnCodigo, iUnHandle : LONGINT;const ftipo: string): boolean;



implementation

uses
  ULogs,
  UModDat,
  USAGVARIOS,
  UCertifi,
  UCDialGs,
  USucesos,
  UMensCts,
  UINFORME,
  uFMedicionesAutomaticas,
  UFTAmarilla, uInformeGNC;

const
  FICHERO_ACTUAL = 'UImprime.pas';

{***************************************************************************}

function TratamientoDeFacturacion(var aF : TFacturacion; const iUnEjercicio, iUnCodigo, iUnHandle : LONGINT;const ftipo: string): boolean;
var
    InspecFact: TInspeccion;
//    iNumFactura : Integer;
    Cad: String;
    fptoventa: tptoventa;
    ptoventa: integer;
begin
result := TRUE;
InspecFact := NIL;
  try
    try
      InspecFact := TInspeccion.Create(MyBD, Format('WHERE EJERCICI = %d AND CODINSPE = %d',[iUnEjercicio, iUnCodigo]));
      InspecFact.Open;
      if InspecFact.RecordCount = 1 then
        begin
          if Assigned(aF) then
            begin
              aF.Free;
              aF := nil;
            end;
          try
            Cad:=InspecFact.ValueByName['CODFACTU'];
            aF := TFacturacion.CreateFromDataBase(MyBD,'TFACTURAS',Format('WHERE CODFACTU = %S',[Cad]));
            aF.Open;
          except
            on E : Exception  do
              begin
                //tRATAMIENTO DE LA EXCPECION POR CREACION DE FACTURA
                result:= FALSE;
                fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'NO SE CREAR LA FACTURA CON CODIGO ' + InspecFact.ValueByName['CODFACTU'] + ': ' + E.message);
              end
          end;

          try
            aF.START;
            aF.Edit;
            aF.ValueByName['TIPFACTU']:= ftipo;
            // Comprobar que no tiene número ni esta ya impresa

            if af.VAlueByName['IMPRESA'] = 'S' then
              raise Exception.Create('Factura anteriormente numerada')
            else
              begin
                aF.ValuebyName['IMPRESA']:='S';
                try
                  fptoventa:=nil;
                  fptoventa:=tptoventa.Create(mybd);
                  fptoventa.open;
                  ptoventa:=fptoventa.GetPtoVentaManual;
                finally
                  fptoventa.close;
                  fptoventa.Free;
                end;

                aF.ValuebyName['NUMFACTU']:=IntToStr(aF.DevolverSecuenciadorFactura(ptoventa));
              end;

            DatosImpresio.AterminadoSolicitudOK(iUnHandle, ord(HTerminado));
            aF.Post(true);
            aF.COMMIT;
            af.Refresh;
          except
            on E: Exception do
              begin
                aF.Rollback;
                result := FALSE;
                fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'NO SE PUEDE REALIZAR LA TRANSACION CON CODIGO ' + InspecFact.ValueByName['CODFACTU'] + ': ' + E.message + ' pv: '+inttostr(ptoventa));
              end;
          end;
        end;
    except
      on E : Exception do
        begin
          result := FALSE;
          fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'NO SE PUEDE CREAR LA TRANSACION CON CODIGO ' + InspecFact.ValueByName['CODFACTU'] + ': ' + E.message + ' pv: '+inttostr(ptoventa));
        end;
    end;
  finally
    InspecFact.free;// Liberar la inspeccion
  end;
end;


{***************************************************************************}
function TratamientoDeContraFacturacion(var caF : TContraFacturas; const iUnEjercicio, iUnCodigo, iUnHandle : LONGINT;const ftipo: string): boolean;
var
    InspecFact: TInspeccion;
    auxF: TFacturacion;
//    iNumFactura : Integer;
    Cad: String;
    fptoventa: tptoventa;
    ptoventa: integer;
begin
    result := TRUE;
    InspecFact := NIL;
//    auxF:= NIL;
    try
        try
            InspecFact := TInspeccion.Create(MyBD, Format('WHERE EJERCICI = %d AND CODINSPE = %d',[iUnEjercicio, iUnCodigo]));
            InspecFact.Open;
            if InspecFact.RecordCount = 1
            then begin
                if Assigned(caF)
                then begin
                    caF.Free;
                    caF := nil;
                end;

                try
                    Cad:=InspecFact.ValueByName['CODFACTU'];
                    // Encontrar la contrafactura de esta factura//
                    auxF := TFacturacion.CreateFromDataBase(MyBD,'TFACTURAS',Format('WHERE CODFACTU = %S',[Cad]));
                    //InspecFact.Close;
                    auxF.Open;
                    // !!! OJO AQUI ES LA MADRE DE TODOS LOS PROBLEMAS
                    caf:= TContraFacturas.CreateFromFactura(MyBD,auxF);
                    caf.Open;
                except
                    on E : Exception  do
                    begin
                        //tRATAMIENTO DE LA EXCPECION POR CREACION DE NOTA DE CREDITO
                        result:= FALSE;
                        fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'NO SE CREAR LA NOTA DE CREDITO DE LA FACTURA ' + InspecFact.ValueByName['CODFACTU'] + ': ' + E.message);
                    end
                end;

                try
                    caF.START;
                    caF.Edit;

                    if caf.VAlueByName['IMPRESA'] = 'S'
                    then raise Exception.Create('Nota anteriormente impresa')
                    else begin
                        caF.ValuebyName['IMPRESA']:='S';
                        try
                          fptoventa:=nil;
                          fptoventa:=tptoventa.Create(mybd);
                          fptoventa.open;
                          ptoventa:=fptoventa.GetPtoVentaManual;
                        finally
                          fptoventa.close;
                          fptoventa.Free;
                        end;
                        caF.ValuebyName['NUMFACTU']:=IntToStr( caf.fMasterFactura.DevolverSecuenciadorFactura(ptoventa));
                    end;
                    DatosImpresio.AterminadoSolicitudOK(iUnHandle, ord(HTerminado));
//                    auxf:=caf.fMasterFactura;
                    caF.Post(true);
                    caF.COMMIT;
                except
                    on E: Exception do
                    begin
                        caf.Rollback;
                        result := FALSE;
                        fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'NO SE PUEDE REALIZAR LA TRANSACION CON CODIGO ' + InspecFact.ValueByName['CODFACTU'] + ': ' + E.message + ' pv: '+inttostr(ptoventa));
                        // Tratamiento de excepcion dentro de la transaccion
                    end;
                end;
            end;
        except
            on E : Exception do
            begin
              result := FALSE;
              fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'NO SE PUEDE CREAR LA TRANSACION CON CODIGO ' + InspecFact.ValueByName['CODFACTU'] + ': ' + E.message + ' pv: '+inttostr(ptoventa));
            end;
        end;
    finally
        if Assigned(InspecFact) then InspecFact.free;// Liberar la inspeccion
        if Assigned(AuxF) then AuxF.Close;
    end;
end;

function TratamientoDeFacturacionGNC(var aF : TFacturacion; const iUnEjercicio, iUnCodigo, iUnHandle : LONGINT;const ftipo: string): boolean;
var
    InspecFact: TInspGNC;
//    iNumFactura : Integer;
    Cad: String;
    fptoventa: tptoventa;
    ptoventa: integer;
begin
    result := TRUE;
    InspecFact := NIL;
    try
        try
            InspecFact := TInspGNC.Create(MyBD, Format('WHERE EJERCICI = %d AND CODINSPGNC = %d',[iUnEjercicio, iUnCodigo]));
            InspecFact.Open;
            if InspecFact.RecordCount = 1
            then begin
                if Assigned(aF)
                then begin
                    aF.Free;
                    aF := nil;
                end;
                try
                    Cad:=InspecFact.ValueByName['CODFACTU'];
                    aF := TFacturacion.CreateFromDataBase(MyBD,'TFACTURAS',Format('WHERE CODFACTU = %S',[Cad]));
                    aF.Open;
                except
                    on E : Exception  do
                    begin
                        //tRATAMIENTO DE LA EXCPECION POR CREACION DE FACTURA
                        result:= FALSE;
                        fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'NO SE CREAR LA FACTURA CON CODIGO ' + InspecFact.ValueByName['CODFACTU'] + ': ' + E.message);
                    end
                end;

                try
                    aF.START;
                    aF.Edit;
                    aF.ValueByName['TIPFACTU']:= ftipo;
                    // Comprobar que no tiene número ni esta ya impresa


                    if af.VAlueByName['IMPRESA'] = 'S'
                    then raise Exception.Create('Factura anteriormente numerada')
                    else begin
                        aF.ValuebyName['IMPRESA']:='S';
                        try
                          fptoventa:=nil;
                          fptoventa:=tptoventa.Create(mybd);
                          fptoventa.open;
                          ptoventa:=fptoventa.GetPtoVentaManual;
                        finally
                          fptoventa.close;
                          fptoventa.Free;
                        end;
                        aF.ValuebyName['NUMFACTU']:=IntToStr(aF.DevolverSecuenciadorFactura(ptoventa));
                    end;
                    DatosImpresio.AterminadoSolicitudOK(iUnHandle, ord(HTerminado));
                    aF.Post(true);
                    aF.COMMIT;
                except
                    on E: Exception do
                    begin
                        aF.Rollback;
                        result := FALSE;
                        fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'NO SE PUEDE REALIZAR LA TRANSACION CON CODIGO ' + InspecFact.ValueByName['CODFACTU'] + ': ' + E.message + ' pv: '+inttostr(ptoventa));
                    end;
                end;
            end;
        except
            on E : Exception do
            begin
                result := FALSE;
                fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'NO SE PUEDE CREAR LA TRANSACION CON CODIGO ' + InspecFact.ValueByName['CODFACTU'] + ': ' + E.message + ' pv: '+inttostr(ptoventa));
            end;
        end;
    finally
        InspecFact.free;// Liberar la inspeccion
    end;
end;


{***************************************************************************}
function TratamientoDeContraFacturacionGNC(var caF : TContraFacturas; const iUnEjercicio, iUnCodigo, iUnHandle : LONGINT;const ftipo: string): boolean;
var
    InspecFact: TInspGNC;
    auxF: TFacturacion;
//    iNumFactura : Integer;
    Cad: String;
    fptoventa: tptoventa;
    ptoventa: integer;
begin
    result := TRUE;
    InspecFact := NIL;
//    auxF:= NIL;
    try
        try
            InspecFact := TInspGNC.Create(MyBD, Format('WHERE EJERCICI = %d AND CODINSPGNC = %d',[iUnEjercicio, iUnCodigo]));
            InspecFact.Open;
            if InspecFact.RecordCount = 1
            then begin
                if Assigned(caF)
                then begin
                    caF.Free;
                    caF := nil;
                end;

                try
                    Cad:=InspecFact.ValueByName['CODFACTU'];
                    // Encontrar la contrafactura de esta factura//
                    auxF := TFacturacion.CreateFromDataBase(MyBD,'TFACTURAS',Format('WHERE CODFACTU = %S',[Cad]));
                    //InspecFact.Close;
                    auxF.Open;
                    // !!! OJO AQUI ES LA MADRE DE TODOS LOS PROBLEMAS
                    caf:= TContraFacturas.CreateFromFactura(MyBD,auxF);
                    caf.Open;
                except
                    on E : Exception  do
                    begin
                        //tRATAMIENTO DE LA EXCPECION POR CREACION DE NOTA DE CREDITO
                        result:= FALSE;
                        fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'NO SE CREAR LA NOTA DE CREDITO DE LA FACTURA ' + InspecFact.ValueByName['CODFACTU'] + ': ' + E.message);
                    end
                end;

                try
                    caF.START;
                    caF.Edit;

                    if caf.VAlueByName['IMPRESA'] = 'S'
                    then raise Exception.Create('Nota anteriormente impresa')
                    else begin
                        caF.ValuebyName['IMPRESA']:='S';
                        try
                          fptoventa:=nil;
                          fptoventa:=tptoventa.Create(mybd);
                          fptoventa.open;
                          ptoventa:=fptoventa.GetPtoVentaManual;
                        finally
                          fptoventa.close;
                          fptoventa.Free;
                        end;
                        caF.ValuebyName['NUMFACTU']:=IntToStr( caf.fMasterFactura.DevolverSecuenciadorFactura(ptoventa));
                    end;
                    DatosImpresio.AterminadoSolicitudOK(iUnHandle, ord(HTerminado));
//                    auxf:=caf.fMasterFactura;
                    caF.Post(true);
                    caF.COMMIT;
                except
                    on E: Exception do
                    begin
                        caf.Rollback;
                        result := FALSE;
                        fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'NO SE PUEDE REALIZAR LA TRANSACION CON CODIGO ' + InspecFact.ValueByName['CODFACTU'] + ': ' + E.message + ' pv: '+inttostr(ptoventa));
                        // Tratamiento de excepcion dentro de la transaccion
                    end;
                end;
            end;
        except
            on E : Exception do
            begin
              result := FALSE;
              fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'NO SE PUEDE CREAR LA TRANSACION CON CODIGO ' + InspecFact.ValueByName['CODFACTU'] + ': ' + E.message + ' pv: '+inttostr(ptoventa));
            end;
        end;
    finally
        if Assigned(InspecFact) then InspecFact.free;// Liberar la inspeccion
        // if Assigned(AuxF) then AuxF.Close;
    end;
end;




{*********************************************************************************************}
function TratamientoDeNCDescuento(var aF:TFacturacion; const iUnEjercicio, iUnCodigo, iUnHandle : LONGINT;const ftipo: string): boolean;  //AGRE RAN
var
  InspecFact: TInspeccion;
//    iNumFactura : Integer;
  Cad: String;
  fptoventa: tptoventa;
  ptoventa: integer;
  aNCD: TFacturacion;
begin
result := TRUE;
InspecFact := NIL;
aNCD := Nil;
  try
    try
      InspecFact := TInspeccion.Create(MyBD, Format('WHERE EJERCICI = %d AND CODINSPE = %d',[iUnEjercicio, iUnCodigo]));
      InspecFact.Open;
      if InspecFact.RecordCount = 1 then
        begin
          if Assigned(aF) then
            begin
              aF.Free;
              aF := nil;
            end;
          try
            Cad:=InspecFact.ValueByName['CODFACTU'];
            aNCD := TFacturacion.CreateFromDataBase(MyBD,'TFACTURAS',Format('WHERE CODFACTU = %S',[Cad]));
            aNCD.Open;
            aNCD.ffactadicionales:= TFact_adicionales.CreateFromFactura(MyBd,aNCD.valuebyname['CODFACTU'],'F','F');
            aNCD.ffactadicionales.open;
            aF:=nil;
            aF:= tFacturacion.CreateFromDataBase(MyBD,'TFACTURAS',Format('WHERE CODFACTU = %S',[aNCD.ffactadicionales.ValueByName['RELCODFAC']]));
            aF.open;
          except
            on E : Exception  do
              begin
                //tRATAMIENTO DE LA EXCPECION POR CREACION DE FACTURA
                result:= FALSE;
                fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'NO SE CREAR LA FACTURA CON CODIGO ' + InspecFact.ValueByName['CODFACTU'] + ': ' + E.message);
              end
          end;

          try
            aF.START;
            aF.Edit;
            aF.ValueByName['TIPFACTU']:= ftipo;
            // Comprobar que no tiene número ni esta ya impresa

            if aF.VAlueByName['IMPRESA'] = 'S' then
              raise Exception.Create('Factura anteriormente numerada')
            else
              begin
                aF.ValuebyName['IMPRESA']:='S';
                try
                  fptoventa:=nil;
                  fptoventa:=tptoventa.Create(mybd);
                  fptoventa.open;
                  ptoventa:=fptoventa.GetPtoVentaManual;
                finally
                  fptoventa.close;
                  fptoventa.Free;
                end;

                aF.ValuebyName['NUMFACTU']:=IntToStr(aF.DevolverSecuenciadorFactura(ptoventa));
              end;

            DatosImpresio.AterminadoSolicitudOK(iUnHandle, ord(HTerminado));
            aF.Post(true);
            aF.COMMIT;
          except
            on E: Exception do
              begin
                aF.Rollback;
                result := FALSE;
                fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'NO SE PUEDE REALIZAR LA TRANSACION CON CODIGO ' + InspecFact.ValueByName['CODFACTU'] + ': ' + E.message + ' pv: '+inttostr(ptoventa));
              end;
          end;
      end;
    except
      on E : Exception do
        begin
          result := FALSE;
          fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'NO SE PUEDE CREAR LA TRANSACION CON CODIGO ' + InspecFact.ValueByName['CODFACTU'] + ': ' + E.message + ' pv: '+inttostr(ptoventa));
        end;
    end;
  finally
    InspecFact.free;// Liberar la inspeccion
    aNCD.Free;
  end;
end;


procedure ImprimirFacturaB( const iUnHandle, iUnEjercicio, iUnCodigo : LONGINT; const UnaImpresora : TImpresorasPampa;
                            const bEsNota : boolean);
var
  bContraFactura : TContraFacturas;
  BFactura: TFacturacion;
  i, iTope : Integer;
  FContextoB : PTContexto;
  tipob: string;
begin
bFactura := nil;
bContraFactura := nil;
  try
    try
      BFactura := nil;
//      FContextoB := nil;
      FContextoB := @UnaImpresora.Contexto;
      if bEsNota then
        tipob := 'NB'
      else
        tipob := 'B';

      if tipob = 'B' then
        begin
          if TratamientoDeFacturacion (BFactura, iUnEjercicio, iUnCodigo, iUnHandle, tipob) then
            begin
              if UnaImpresora.CopiasDirectas = 0 then
                iTope := 1
              else
                iTope := UnaImpresora.CopiasDirectas;
              for i:=1 to iTope do
                BFactura.VerImprimirFactura(FALSE,FContextoB);//,PContexto(UnaImpresora);
            end
          else
            begin
              DatosImpresio.BorrarSolicitud(iUnHandle);
              fIncidencias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'La Factura de tipo B ' + IntToStr(IUnHandle) + ' ' +
              IntToStr(iUnCodigo) + ' ' + IntToStr(iUnEjercicio) + ' se borrará, la obtención de sus datos ha fallado');
              FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + ' -FACTURA O NOTA A-');
            end
        end

      else
        if tipob = 'NB' then
          begin
            bContraFactura := nil;
            // Devuelve el objeto aFactura apuntando y abierto
            if TratamientoDeContraFacturacion (bContraFactura,iUnEjercicio, iUnCodigo, iUnHandle,tipob) then
              begin
                if UnaImpresora.CopiasDirectas = 0 then
                  iTope := 1
                else
                  iTope := UnaImpresora.CopiasDirectas;
                for i:=1 to iTope do
                  bContraFactura.VerImprimirFactura(FALSE,FContextoB);//,PContexto(UnaImpresora);
              end
            else
              begin
                DatosImpresio.BorrarSolicitud(iUnHandle);
                fIncidencias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'La Nota de tipo B ' + IntToStr(IUnHandle) + ' ' +
                IntToStr(iUnCodigo) + ' del ' + IntToStr(iUnEjercicio) + ' se borrará, la obtención de sus datos ha fallado');
                FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + ' -FACTURA O NOTA B-');
              end;
          end;
    except
      on E: Exception do
        begin
          FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + '-FACTURA O NOTA DE TIPO B-');
          fAnomalias.PonAnotacion(TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'ERROR AL INTENTAR IMPRIMIR POR: ' + E.Message);
        end;
    end;
  finally
    if Assigned(bFactura) then
      bFactura.Free;
    if Assigned(bContrafactura) then
      bContraFactura.Free;
  end;
end;



procedure ImprimirFacturaA( const iUnHandle, iUnEjercicio, iUnCodigo : LONGINT; const UnaImpresora : TImpresorasPampa;
                            const bEsNota : boolean);
var
  aContraFactura: TContraFacturas;
  Afactura : TFacturacion;
  i, iTope : Integer;
  FContextoA : PTContexto;
  tipoa: string;
begin
aFactura := nil;
aContraFactura := nil;
  try
    try
//            FContextoA := nil;
      FContextoA := @UnaImpresora.Contexto;
      if bEsNota then
        tipoa := 'NA'
      else
        tipoa := 'A';
      If tipoa = 'A' then
        begin
          aFactura := nil;
          // Devuelve el objeto aFactura apuntando y abierto
          if TratamientoDeFacturacion (aFactura,iUnEjercicio, iUnCodigo, iUnHandle,tipoa) then
            begin
              if UnaImpresora.CopiasDirectas = 0 then
                iTope := 1
              else
                iTope := UnaImpresora.CopiasDirectas;
              for i:=1 to iTope do
                aFactura.VerImprimirFactura(FALSE,FContextoA);//,PContexto(UnaImpresora);
            end
          else
            begin
              DatosImpresio.BorrarSolicitud(iUnHandle);
              fIncidencias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'La Factura de tipo A ' + IntToStr(IUnHandle) + ' ' +
              IntToStr(iUnCodigo) + ' del ' + IntToStr(iUnEjercicio) + ' se borrará, la obtención de sus datos ha fallado');
              FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + ' -FACTURA O NOTA A-');
            end;
        end
      else
        if tipoa = 'NA' then
          begin
            aContraFactura := nil;
            // Devuelve el objeto aFactura apuntando y abierto
            if TratamientoDeContraFacturacion (aContraFactura,iUnEjercicio, iUnCodigo, iUnHandle,tipoa) then
              begin
            //aFactura:= aContraFactura.fMasterFactura;
                if UnaImpresora.CopiasDirectas = 0 then
                  iTope := 1
                else
                  iTope := UnaImpresora.CopiasDirectas;
                for i:=1 to iTope do
                  aContraFactura.VerImprimirFactura(FALSE,FContextoA);//,PContexto(UnaImpresora);
              end
            else
              begin
                DatosImpresio.BorrarSolicitud(iUnHandle);
                fIncidencias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'La Nota de tipo A ' + IntToStr(IUnHandle) + ' ' +
                IntToStr(iUnCodigo) + ' del ' + IntToStr(iUnEjercicio) + ' se borrará, la obtención de sus datos ha fallado');
              end;
          end;
    except
      on E: Exception do
        begin
          FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + '-FACTURA O NOTA DE TIPO A-');
          fAnomalias.PonAnotacion(TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'ERROR AL INTENTAR IMPRIMIR POR: ' + E.Message);
        end;
    end;
  finally
    if Assigned(aFactura) then
      aFactura.Free;
    if Assigned(aContrafactura) then
      aContraFactura.Free;
  end;
end;


procedure ImprimirFacturaBGNC( const iUnHandle, iUnEjercicio, iUnCodigo : LONGINT;
                            const UnaImpresora : TImpresorasPampa;
                            const bEsNota : boolean);
var
    bContraFactura : TContraFacturas;
    BFactura: TFacturacion;
    i, iTope : Integer;
    FContextoB : PTContexto;
    tipob: string;
begin
    bFactura := nil;
    bContraFactura := nil;
    try
        try
            BFactura := nil;
//            FContextoB := nil;
            FContextoB := @UnaImpresora.Contexto;
            if bEsNota
            then tipob := 'NB'
            else tipob := 'B';

            if tipob = 'B'
            then begin
                if TratamientoDeFacturacionGNC (BFactura, iUnEjercicio, iUnCodigo, iUnHandle, tipob)
                then begin
                    if UnaImpresora.CopiasDirectas = 0
                    then iTope := 1
                    else iTope := UnaImpresora.CopiasDirectas;
                    for i:=1 to iTope do BFactura.VerImprimirFacturaGNC(FALSE,FContextoB);//,PContexto(UnaImpresora);
                end
                else begin
                    DatosImpresio.BorrarSolicitud(iUnHandle);
                    fIncidencias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'La Factura de tipo B ' + IntToStr(IUnHandle) + ' ' +
                    IntToStr(iUnCodigo) + ' ' + IntToStr(iUnEjercicio) + ' se borrará, la obtención de sus datos ha fallado');
                    FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + ' -FACTURA O NOTA A-');
                end
            end
            else if tipob = 'NB'
                then begin
                    bContraFactura := nil;
                    // Devuelve el objeto aFactura apuntando y abierto
                    if TratamientoDeContraFacturacionGNC (bContraFactura,iUnEjercicio, iUnCodigo, iUnHandle,tipob)
                    then begin
                        if UnaImpresora.CopiasDirectas = 0
                        then iTope := 1
                        else iTope := UnaImpresora.CopiasDirectas;
                        for i:=1 to iTope do bContraFactura.VerImprimirFacturaGNC(FALSE,FContextoB);//,PContexto(UnaImpresora);
                    end
                    else begin
                        DatosImpresio.BorrarSolicitud(iUnHandle);
                        fIncidencias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'La Nota de tipo B ' + IntToStr(IUnHandle) + ' ' +
                        IntToStr(iUnCodigo) + ' del ' + IntToStr(iUnEjercicio) + ' se borrará, la obtención de sus datos ha fallado');
                        FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + ' -FACTURA O NOTA B-');
                    end;
                end;
        except
            on E: Exception do
            begin
                FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + '-FACTURA O NOTA DE TIPO B-');
                fAnomalias.PonAnotacion(TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'ERROR AL INTENTAR IMPRIMIR POR: ' + E.Message);
            end;
        end;
    finally
        if Assigned(bFactura) then bFactura.Free;
        if Assigned(bContrafactura) then bContraFactura.Free;
    end;
end;



procedure ImprimirFacturaAGNC( const iUnHandle, iUnEjercicio, iUnCodigo : LONGINT;
                            const UnaImpresora : TImpresorasPampa;
                            const bEsNota : boolean);
var
  aContraFactura: TContraFacturas;
  Afactura : TFacturacion;
  i, iTope : Integer;
  FContextoA : PTContexto;
  tipoa: string;
begin
    aFactura := nil;
    aContraFactura := nil;
    try
        try
//            FContextoA := nil;
            FContextoA := @UnaImpresora.Contexto;
            if bEsNota
            then tipoa := 'NA'
            else tipoa := 'A';
            If tipoa = 'A'
            then begin
                aFactura := nil;
                // Devuelve el objeto aFactura apuntando y abierto
                if TratamientoDeFacturacionGNC (aFactura,iUnEjercicio, iUnCodigo, iUnHandle,tipoa)
                then begin
                    if UnaImpresora.CopiasDirectas = 0
                    then iTope := 1
                    else iTope := UnaImpresora.CopiasDirectas;
                    for i:=1 to iTope do aFactura.VerImprimirFacturaGNC(FALSE,FContextoA);//,PContexto(UnaImpresora);
                end
                else begin
                    DatosImpresio.BorrarSolicitud(iUnHandle);
                    fIncidencias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'La Factura de tipo A ' + IntToStr(IUnHandle) + ' ' +
                    IntToStr(iUnCodigo) + ' del ' + IntToStr(iUnEjercicio) + ' se borrará, la obtención de sus datos ha fallado');
                    FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + ' -FACTURA O NOTA A-');
                end;
            end
            else if tipoa = 'NA'
                then begin
                    aContraFactura := nil;
                    // Devuelve el objeto aFactura apuntando y abierto
                    if TratamientoDeContraFacturacionGNC (aContraFactura,iUnEjercicio, iUnCodigo, iUnHandle,tipoa)
                    then begin
                        //aFactura:= aContraFactura.fMasterFactura;
                        if UnaImpresora.CopiasDirectas = 0
                        then iTope := 1
                        else iTope := UnaImpresora.CopiasDirectas;
                        for i:=1 to iTope do aContraFactura.VerImprimirFacturaGNC(FALSE,FContextoA);//,PContexto(UnaImpresora);
                    end
                    else begin
                        DatosImpresio.BorrarSolicitud(iUnHandle);
                        fIncidencias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'La Nota de tipo A ' + IntToStr(IUnHandle) + ' ' +
                        IntToStr(iUnCodigo) + ' del ' + IntToStr(iUnEjercicio) + ' se borrará, la obtención de sus datos ha fallado');
                    end;
                end;
        except
            on E: Exception do
            begin
                FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + '-FACTURA O NOTA DE TIPO A-');
                fAnomalias.PonAnotacion(TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'ERROR AL INTENTAR IMPRIMIR POR: ' + E.Message);
            end;
        end;
    finally
        if Assigned(aFactura) then aFactura.Free;
        if Assigned(aContrafactura) then aContraFactura.Free;
    end;
end;




{ ********************************************************************************** }

procedure ImprimirCertificado( const iUnHandle, iUnEjercicio, iUnCodigo : LONGINT; const UnaImpresora : TImpresorasPampa );
var
  i, iTope : Integer;
  pCertificado : pTContexto;
  FichaCertificado : TFrmCertificado;
begin
FichaCertificado := nil;
pCertificado:= @UnaImpresora.Contexto;
  try
    if UnaImpresora.CopiasDirectas = 0 then
      iTope := 1
    else
      iTope := UnaImpresora.CopiasDirectas;
    for i:=1 to iTope do
      begin
        try
          FichaCertificado := TFrmCertificado.CreateFromEjercicioAndCode (iUnEjercicio, iUnCodigo, FALSE, pCertificado);
        finally
          FichaCertificado.Free;
          FichaCertificado := nil;
        end;
      end;
    if not(DatosImpresio.AterminadoSolicitudOK(iUnHandle, ord(HTerminado))) then
      begin
        DatosImpresio.BorrarSolicitud(iUnHandle);
        fIncidencias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'El Certificado ' + IntToStr(IUnHandle) + ' ' +
        IntToStr(iUnCodigo) + ' ' + IntToStr(iUnEjercicio) + ' se borrará, la obtención de sus datos ha fallado');
        FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + ' -CERTIFICADO- ');
      end
  except
    on E: Exception do
      Begin
        FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + '- CERTIFICADO - ');
        fAnomalias.PonAnotacion(TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'ERROR AL INTENTAR IMPRIMIR POR: ' + E.Message);
      end;
  end;
end;



{ ********************************************************************************** }

procedure ImprimirInforme ( const iUnHandle, iUnEjercicio, iUnCodigo : LONGINT; const UnaImpresora : TImpresorasPampa; const bDirecto : boolean );
var
  i, iTope : Integer;
  FichaInspeccion : TFrmFichaInspeccion;
  pInforme : pTContexto;
begin
FichaInspeccion := nil;
  try
  pInforme:= @UnaImpresora.Contexto;
    try
      if UnaImpresora.CopiasDirectas = 0 then
        iTope := 1
      else
        iTope := UnaImpresora.CopiasDirectas;
      for i:=1 to iTope do
        begin
          if i=1 then
            begin
              try
                FichaInspeccion := TFrmFichaInspeccion.CreateFromEjercicioAndCode(iUnEjercicio, iUnCodigo, TRUE, FALSE, pInforme);
              finally
                Fichainspeccion.Free;
                Fichainspeccion := nil;
              end;
            end
          else
            begin
              try
                FichaInspeccion := TFrmFichaInspeccion.CreateFromEjercicioAndCode(iUnEjercicio, iUnCodigo, FALSE, FALSE, pInforme);
              finally
                FichaInspeccion.Free;
                FichaInspeccion := nil;
              end;
            end
        end;

        // LINEAS COMENTADAS MIENTRAS SE BORRE LA SOLICITUD DEL INFORME DESDE EL CLIENTE
(*          if not(DatosImpresion.AterminadoSolicitudOK(iUnHandle, ord(HTerminado))) then
            begin
                DatosImpresion.BorrarSolicitud(iUnHandle);
                fIncidencias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'El informe de inspección ' + IntToStr(IUnHandle) + ' ' +
                IntToStr(iUnCodigo) + ' ' + IntToStr(iUnEjercicio) + ' se borrará, la obtención de sus datos ha fallado');
                FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + ' -INFORME DE INSPECCIÓN-');
            end;
*)
    except
      on E: Exception do
      begin
         DatosImpresio.BorrarSolicitud(iUnHandle);
         FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + '-INFORME DE INSPECCIÓN-');
         fAnomalias.PonAnotacion(TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'ERROR AL INTENTAR IMPRIMIR POR: ' + E.Message);
      end;
    end;
    finally
    if Assigned(FichaInspeccion) then
      Fichainspeccion.Free;
    end;
end;

procedure ImprimirNCDescuentoA( const iUnHandle, iUnEjercicio, iUnCodigo : LONGINT;
                            const UnaImpresora : TImpresorasPampa;
                            const bEsNota : boolean);
var
  Afactura : TFacturacion;
  i, iTope : Integer;
  FContextoA : PTContexto;
  tipoa: string;
begin
    aFactura := nil;
    tipoa:='A';
    try
        try
                FContextoA := @UnaImpresora.Contexto;
//                aFactura := nil;
                // Devuelve el objeto aFactura apuntando y abierto
                if TratamientoDeNCDescuento (aFactura,iUnEjercicio, iUnCodigo, iUnHandle,tipoa)
                then begin
                    if UnaImpresora.CopiasDirectas = 0
                    then iTope := 1
                    else iTope := UnaImpresora.CopiasDirectas;
                    aFactura.ffactadicionales:= TFact_adicionales.createfromfactura(MyBd,afactura.valuebyname['CODFACTU'],'D','D');
                    for i:=1 to iTope do aFactura.VerImprimirNCDescuento(FALSE,FContextoA);//,PContexto(UnaImpresora);
                end
                else begin
                    DatosImpresio.BorrarSolicitud(iUnHandle);
                    fIncidencias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'La Nota de Descuento de tipo A ' + IntToStr(IUnHandle) + ' ' +
                    IntToStr(iUnCodigo) + ' del ' + IntToStr(iUnEjercicio) + ' se borrará, la obtención de sus datos ha fallado');
                    FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + ' -FACTURA O NOTA A-');
                end;

        except
            on E: Exception do
            begin
                FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + '-FACTURA O NOTA DE TIPO A-');
                fAnomalias.PonAnotacion(TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'ERROR AL INTENTAR IMPRIMIR POR: ' + E.Message);
            end;
        end;
    finally
        if assigned(aFactura.ffactadicionales) then aFactura.ffactadicionales.Free;       //***********
        if Assigned(aFactura) then aFactura.Free;
    end;
end;


procedure ImprimirNCDescuentoB( const iUnHandle, iUnEjercicio, iUnCodigo : LONGINT;
                            const UnaImpresora : TImpresorasPampa;
                            const bEsNota : boolean);
var
    BFactura: TFacturacion;
    i, iTope : Integer;
    FContextoB : PTContexto;
    tipob: string;
begin
    bFactura := nil;
    tipob := 'B';
    try
        try
//                BFactura := nil;
                FContextoB := @UnaImpresora.Contexto;
                if TratamientoDeNCDescuento (BFactura, iUnEjercicio, iUnCodigo, iUnHandle, tipob)
                then begin
                    if UnaImpresora.CopiasDirectas = 0
                    then iTope := 1
                    else iTope := UnaImpresora.CopiasDirectas;
                    bFactura.ffactadicionales:= TFact_adicionales.createfromfactura(MyBd,bfactura.valuebyname['CODFACTU'],'D','D');
                    bFactura.ffactadicionales.open;
                    for i:=1 to iTope do BFactura.VerImprimirNCDescuento(FALSE,FContextoB);//,PContexto(UnaImpresora);
                end
                else begin
                    DatosImpresio.BorrarSolicitud(iUnHandle);
                    fIncidencias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'La Nota de Descuento de tipo B ' + IntToStr(IUnHandle) + ' ' +
                    IntToStr(iUnCodigo) + ' ' + IntToStr(iUnEjercicio) + ' se borrará, la obtención de sus datos ha fallado');
                    FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + ' -FACTURA O NOTA A-');
                end
        except
            on E: Exception do
            begin
                FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + '-FACTURA O NOTA DE TIPO B-');
                fAnomalias.PonAnotacion(TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'ERROR AL INTENTAR IMPRIMIR POR: ' + E.Message);
            end;
        end;
    finally
        if Assigned(bfactura.ffactadicionales) then bfactura.ffactadicionales.Free;  //**********
        if Assigned(bFactura) then bFactura.Free;
    end;
end;

//////////////////////////////////////////////////////////////
///     ACOMODE ERROR DE CUELGUE DE MEDICIONES - LUCHO     ///
//////////////////////////////////////////////////////////////
procedure ImprimirMediciones ( const iUnHandle, iUnEjercicio, iUnCodigo : LONGINT;
                               const UnaImpresora : TImpresorasPampa; const bDirecto : boolean );
var
  i, iTope : Longint;
  FMediciones : TfrmMedicionesAutomaticas;
  pMedicion : pTContexto;
begin
FMediciones := nil;
  try
    pMedicion:= @UnaImpresora.Contexto;
      try
        if UnaImpresora.CopiasDirectas = 0 then
          iTope := 1
        else
          iTope := UnaImpresora.CopiasDirectas;
        for i:=1 to iTope do
          begin
            try
              FMediciones := TfrmMedicionesAutomaticas.CreateFromEjercicioAndCode(iUnEjercicio, iUnCodigo, pMedicion, false);
              DatosImpresio.AterminadoSolicitudOK(iUnHandle, ord(HTerminado));
            finally
              FMediciones.Free;
              FMediciones := nil;
            end;
          end
      except
        on E: Exception do
          begin
            DatosImpresio.BorrarSolicitud(iUnHandle);
            FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + '-INFORME DE MEDICIONES-');
            fAnomalias.PonAnotacion(TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'ERROR AL INTENTAR IMPRIMIR POR: ' + E.Message);
          end;
        end;
    finally
        if Assigned(FMediciones) then
        FMediciones.Free;
    end;
end;



procedure ImprimirTAmarilla( const iUnHandle, iUnEjercicio, iUnCodigo : LONGINT;
                               const UnaImpresora : TImpresorasPampa );
var
  i, iTope : Integer;
  pCertificado : pTContexto;
  FichaCertificado : TFrmTAmarilla;
begin
    FichaCertificado := nil;
    pCertificado:= @UnaImpresora.Contexto;
    try
        if UnaImpresora.CopiasDirectas = 0
        then iTope := 1
        else iTope := UnaImpresora.CopiasDirectas;

        for i:=1 to iTope do
        begin
            try
                FichaCertificado := TFrmTAmarilla.CreateFromEjercicioAndCode (iUnEjercicio, iUnCodigo, FALSE, pCertificado);
            finally
                FichaCertificado.Free;
                FichaCertificado := nil;
            end;
        end;

        if not(DatosImpresio.AterminadoSolicitudOK(iUnHandle, ord(HTerminado))) then
        begin
            DatosImpresio.BorrarSolicitud(iUnHandle);
            fIncidencias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'El Certificado ' + IntToStr(IUnHandle) + ' ' +
            IntToStr(iUnCodigo) + ' ' + IntToStr(iUnEjercicio) + ' se borrará, la obtención de sus datos ha fallado');
            FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + ' -CERTIFICADO- ');
        end
    except
        on E: Exception do
        begin
            FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + '- CERTIFICADO - ');
            fAnomalias.PonAnotacion(TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'ERROR AL INTENTAR IMPRIMIR POR: ' + E.Message);
        end;
    end;
end;


procedure ImprimirInformeGNC( const iUnHandle, iUnEjercicio, iUnCodigo : LONGINT;
                               const UnaImpresora : TImpresorasPampa );
var
  i, iTope : Integer;
  pCertificado : pTContexto;
  FichaCertificado : TFrmInformeGNC;
begin
    FichaCertificado := nil;
    pCertificado:= @UnaImpresora.Contexto;
    try
        if UnaImpresora.CopiasDirectas = 0
        then iTope := 1
        else iTope := UnaImpresora.CopiasDirectas;

        for i:=1 to iTope do
        begin
            try
                FichaCertificado := TFrmInformeGNC.CreateFromEjercicioAndCode (iUnEjercicio, iUnCodigo,i, FALSE, pCertificado);
            finally
                FichaCertificado.Free;
                FichaCertificado := nil;
            end;
        end;

        if not(DatosImpresio.AterminadoSolicitudOK(iUnHandle, ord(HTerminado))) then
        begin
            DatosImpresio.BorrarSolicitud(iUnHandle);
            fIncidencias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'El Certificado ' + IntToStr(IUnHandle) + ' ' +
            IntToStr(iUnCodigo) + ' ' + IntToStr(iUnEjercicio) + ' se borrará, la obtención de sus datos ha fallado');
            FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + ' -CERTIFICADO- ');
        end
    except
        on E: Exception do
        begin
            FrmSucesos.MemoErrores.Lines.Add ( DateTimeToStr(now) + ' ' + LITERAL_ERROR_SERVIDOR_IMPRESION_MUY_GRAVE + InttoStr(iUnHandle) + '- CERTIFICADO - ');
            fAnomalias.PonAnotacion(TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'ERROR AL INTENTAR IMPRIMIR POR: ' + E.Message);
        end;
    end;

end;


end.


