unit class_impresion;

interface

uses  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, s_0011,Inifiles,XSBuiltIns, globals,
  Dialogs, StdCtrls, Grids, DBGrids, DB,Buttons, ExtCtrls,ActiveX, ComObj,Registry,ComCtrls, UCTEVERIFICACIONES,  RxMemDS,UcertificadoCABA,
   SQLEXPR, DBXpress, Provider, dbclient,  ADODB,USuperRegistry,uversion,InvokeRegistry, Rio, SOAPHTTPClient,PRINTERS;


type
TIMPRESIONCABA= class
  protected
     CANTIDAD_HOJAS:LONGINT;
    fEjercicio : integer;
    fCodigo: integer;
    fConsulta : TsqlQuery;
    function CALCULA_CANTIDAD_HOJA(codinspe,ejercicio:longint):longint;
    FUNCTION ACTIVAR_COMPONENTES(bActivar:BOOLEAN):BOOLEAN;
  public
   PROPERTY VER_CANTIDAD:LONGINT READ CANTIDAD_HOJAS;
   function imprimir_certificado_caba(codinspe,ejercicio,cantidadhojas:longint;REIMPRIMIR:BOOLEAN;NRO_INFORME:string):boolean;


  end;

implementation
FUNCTION TIMPRESIONCABA.ACTIVAR_COMPONENTES(bActivar:BOOLEAN):BOOLEAN;

  var i:longint;

begin

   { for i := 0 to Self.ComponentCount-1 do
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
    end; }

end;


function TIMPRESIONCABA.imprimir_certificado_caba(codinspe,ejercicio,cantidadhojas:longint;REIMPRIMIR:BOOLEAN;NRO_INFORME:string):boolean;

var aq,aContexto,aQim: TSQLQuery;
    codpro:longint;
    codcon:longint;
    fechalta:string;
    numoblea:string;
    fechavenci:string;
    resultad:string;
    observa,CADENA_QR:string;
    CODVEHIC:LONGINT;
   // NRO_INFORME:STRING;
    {TITULAR}
    TITULARNOMBRE:STRING;
    TITULARAPELLID1:STRING;
    TITULARAPELLID2:STRING;
    TITULARDOCUMENT:STRING;
    TIPODOCU:LONGINT;
    TITULARDOCUMENTODESCRIPCION:STRING;
    I:LONGINT;
    {CONDUCTOR}
    CONDUCTORDOCUMENTODESCRIPCION:STRING;
    CONDUCTORNOMBRE:STRING;
    CONDUCTORPELLID1:STRING;
    CONDUCTORPELLID2:STRING;
    CONDUCTORDOCUMENT,parte1,parte2:STRING;

    {VEHICULO}
    tipodest:LONGINT;
    tipoESPE:LONGINT;
    codmodelo:LONGINT;
    codmarca:LONGINT;
    DOMINIO:STRING;
    ANIOFABR:STRING;
    CHASIS,CADDEFEC:STRING;
    MARCAVEHICULO,cal:STRING;
  //  cantidadhojas:LONgint;
    MODELOVEHICULO:sTRING;     AWidth, AHeight, ASymbolWidth, ASymbolHeight:longint;
    HORENTZ1,HORSALZ1,HORENTZ2 ,HORSALZ2,HORENTZ3,HORSALZ3:STRING;
    LblXHoraIngreso, LblXHegr,LblXHTTE,LblXHTTL,HORFINAL:STRING;
    {PLANTA}   aQDE:TSQLQuery;     NRO,ORDEN:longint;
    PLANTA,CLASIFICACION:STRING;  cant_item_informe:longint;
     sCodigo_Auxi, sDescripcion_Auxi, sOk_Auxi, sLeve_Auxi, sGrave_Auxi: string;
begin
imprimir_certificado_caba:=true;
try

with TSuperRegistry.Create do
     try
        RootKey := HKEY_LOCAL_MACHINE;
      if not OpenKeyRead(II_) then
      begin
      Application.MessageBox( 'No se encontraron los parámetros NROPC de la Estación de Trabajo.',
  'Acceso denegado', MB_ICONSTOP );
        //  Messagedlg('ERROR','No se encontraron los parámetros de la Estación de Trabajo', mtInformation, [mbOk],mbOk,0);

       EXIT;
      end
      else
      begin
        NRO :=strtoint(ReadString('NROPC'));

      end;


      FINALLY
       FREE;
      END;








     if REIMPRIMIR=true then
     begin
     aQ:=TSQLQuery.Create(nil);

     ////armar consulta
          with aQ do
            begin
              SQLConnection:=mybd;
              sql.add('select NRO_INFORME from certificadoinspeccion WHERE CODINSPE=:CODINSPE ');
              ParamByName('CODINSPE').Value:=codinspe;
                try
                  Open;
                    NRO_INFORME:=trim(aq.fieldbyname('NRO_INFORME').asstring);

                  finally
                    Close;
                    Free;
                end;
            end;

   end;


aQ:=TSQLQuery.Create(nil);



     ////armar consulta
          with aQ do
            begin
              SQLConnection:=mybd;

                 sql.add('alter session set nls_date_format = ''dd/mm/yyyy hh24:mi:ss''');
                 ExecSQL;
                sql.clear;

              sql.add('select CODVEHIC, codclpro,codclcon,fechalta,numoblea,fecvenci,resultad,observac, HORFINAL, '+
              ' HORENTZ1,HORSALZ1,HORENTZ2 ,HORSALZ2,HORENTZ3,HORSALZ3 from tinspeccion ');
              sql.adD('where EJERCICI = :EJERCICI AND CODINSPE = :CODINSPE ');
              ParamByName('CODINSPE').Value:=codinspe;
              ParamByName('EJERCICI').Value:=ejercicio;
                try
                  Open;
                    CODVEHIC:=aq.fieldbyname('CODVEHIC').asinteger;
                    codpro:=aq.fieldbyname('codclpro').asinteger;
                    codcon:=aq.fieldbyname('codclcon').asinteger;
                    fechalta:=trim(aq.fieldbyname('fechalta').asstring);
                    numoblea:=trim(aq.fieldbyname('numoblea').asstring);
                    fechavenci:=trim(aq.fieldbyname('fecvenci').asstring);
                    resultad:=trim(aq.fieldbyname('resultad').asstring);
                    observa:=trim(aq.fieldbyname('observac').asstring);
                    HORFINAL:=trim(aq.fieldbyname('HORFINAL').asstring);
                    LblXHoraIngreso := FormatDateTime('hh:nn:ss',StrToDateTime(trim(aq.fieldbyname('fechalta').asstring)));

                    if trim(aq.fieldbyname('HORFINAL').asstring)='' then
                        LblXHegr:='-'
                        else
                         LblXHegr := FormatDateTime('hh:nn:ss',StrToDateTime(trim(aq.fieldbyname('HORFINAL').asstring)));

                    HORENTZ1:=trim(aq.fieldbyname('HORENTZ1').asstring);
                    HORSALZ1:=trim(aq.fieldbyname('HORSALZ1').asstring);
                    HORENTZ2:=trim(aq.fieldbyname('HORENTZ2').asstring);
                    HORSALZ2:=trim(aq.fieldbyname('HORSALZ2').asstring);
                    HORENTZ3:=trim(aq.fieldbyname('HORENTZ3').asstring);
                    HORSALZ3:=trim(aq.fieldbyname('HORSALZ3').asstring);










                     if trim(resultad)='A' then
                        resultad:='APROBADO';

                     if trim(resultad)='C' then
                        resultad:='CONDICIONAL';

                     if trim(resultad)='R' then
                        resultad:='RECHAZADO';


                  finally
                    Close;
                    Free;
                end;
            end;

     {TIEMPOS}

     aq:=tsqlquery.create(nil);

               try
                 aq.SQLConnection := MyBD;
                 aq.sql.add('alter session set nls_date_format = ''dd/mm/yyyy hh24:mi:ss''');
                 aq.ExecSQL;
                 aq.SQL.Clear;
                 aq.sql.add(format('select mayorfecha(''%s'',''%s'',''%s'',''%s''), menorfecha(''%s'',''%s'',''%s'',''%s'') from dual',[HORSALZ1,HORSALZ2,HORSALZ3,HORFINAL,HORENTZ1,HORENTZ2,HORENTZ3,fechalta]));
                 aq.open;
                 LblXHTTL := FormatDateTime('hh:nn:ss',
                    (
                     aq.Fields[0].asdatetime - aq.Fields[1].asdatetime
                    )
                 );




        except
            on E:Exception do
               LblXHTTL := '';
        end;

       
        aq.CLOSE;
         aq.free;


        try
        if trim(HORFINAL)='' then
             LblXHTTE:='-'
             else
           LblXHTTE := FormatDateTime('hh:nn:ss', (StrToDateTime(HORFINAL) -  StrToDateTime(fechalta)));
        except
            on E:Exception do
               LblXHTTE := '';
        end;

     {FIN TIEMPOS}

   {DATOS DEL TITULAR}
    aQ:=TSQLQuery.Create(nil);

     ////armar consulta
          with aQ do
            begin
              SQLConnection:=mybd;
              sql.add('SELECT NOMBRE, APELLID1,APELLID2,DOCUMENT,TIPODOCU FROM TCLIENTES WHERE CODCLIEN=:CODCLIEN ');
              ParamByName('CODCLIEN').Value:=codpro;

                try
                  Open;
                    TITULARDOCUMENTODESCRIPCION :=TRIM(aq.fieldbyname('TIPODOCU').ASSTRING);
                    //TIPODOCU:=TRIM(aq.fieldbyname('TIPODOCU').ASSTRING);
                    TITULARNOMBRE:=trim(aq.fieldbyname('NOMBRE').asstring);
                    TITULARAPELLID1:=trim(aq.fieldbyname('APELLID1').asstring);
                    TITULARAPELLID2:=trim(aq.fieldbyname('APELLID2').asstring);
                    TITULARDOCUMENT:=trim(aq.fieldbyname('DOCUMENT').asstring) ;

                    finally
                    Close;
                    Free;
                end;
            end;





   {FIN DATOS TITULAR}


   {DATOS CONDUCTOR}
    aQ:=TSQLQuery.Create(nil);

     ////armar consulta
          with aQ do
            begin
              SQLConnection:=mybd;
              sql.add('SELECT NOMBRE, APELLID1,APELLID2,DOCUMENT,TIPODOCU FROM TCLIENTES WHERE CODCLIEN=:CODCLIEN ');
              ParamByName('CODCLIEN').Value:=codcon;

                try
                  Open;
                    CONDUCTORDOCUMENTODESCRIPCION:=trim(aq.fieldbyname('TIPODOCU').asstring);
                   // TIPODOCU:=aq.fieldbyname('TIPODOCU').asinteger;
                    CONDUCTORNOMBRE:=trim(aq.fieldbyname('NOMBRE').asstring);
                    CONDUCTORPELLID1:=trim(aq.fieldbyname('APELLID1').asstring);
                    CONDUCTORPELLID2:=trim(aq.fieldbyname('APELLID2').asstring);
                    CONDUCTORDOCUMENT:=trim(aq.fieldbyname('DOCUMENT').asstring) ;

                    finally
                    Close;
                    Free;
                end;
            end;



        
   {FIN DATOS CONDUCTOR}




   {DATOS VEHICULO}
    aQ:=TSQLQuery.Create(nil);

     ////armar consulta
          with aQ do
            begin
              SQLConnection:=mybd;
              sql.add('SELECT patenten,aniofabr,codmarca, codmodel,nummotor,tipodest,tipoespe, numbasti from tvehiculos where codvehic=:codvehic');
              ParamByName('codvehic').Value:=CODVEHIC;

                try
                  Open;
                    tipodest:=aq.fieldbyname('tipodest').asinteger;
                    tipoespe:=aq.fieldbyname('tipoespe').asinteger;
                    codmodelo:=aq.fieldbyname('codmodel').asinteger;
                    codmarca:=aq.fieldbyname('codmarca').asinteger;
                    DOMINIO:=trim(aq.fieldbyname('patenten').asstring);
                    ANIOFABR:=trim(aq.fieldbyname('aniofabr').asstring);
                    CHASIS:=trim(aq.fieldbyname('numbasti').asstring);

                    finally
                    Close;
                    Free;
                end;
            end;

         {clasificacion vehiculo}
         

       aQ:=TSQLQuery.Create(nil);

     ////armar consulta
          with aQ do
            begin
              SQLConnection:=mybd;
              sql.add('select nomespec,abrevia from ttipoespveh where tipoespe=:tipoespe ');
              ParamByName('tipoespe').Value:=tipoespe;

                try
                  Open;
                    if trim(aq.fieldbyname('abrevia').asstring)='' then
                       CLASIFICACION:=trim(aq.fieldbyname('nomespec').asstring)
                       else
                        CLASIFICACION:=trim(aq.fieldbyname('abrevia').asstring);

                    finally
                    Close;
                    Free;
                end;
            end;

            {----------------------}

       aQ:=TSQLQuery.Create(nil);

     ////armar consulta
          with aQ do
            begin
              SQLConnection:=mybd;
              sql.add('SELECT NOMMARCA FROM TMARCAS WHERE CODMARCA=:CODMARCA ');
              ParamByName('CODMARCA').Value:=codmarca;

                try
                  Open;
                    MARCAVEHICULO:=trim(aq.fieldbyname('NOMMARCA').asstring) ;

                    finally
                    Close;
                    Free;
                end;
            end;

          aQ:=TSQLQuery.Create(nil);
          with aQ do
            begin
              SQLConnection:=mybd;
              sql.add('SELECT NOMMODEL FROM TMODELOS WHERE CODMODEL=:CODMODELO ');
              ParamByName('CODMODELO').Value:=codmodelo;

                try
                  Open;
                    MODELOVEHICULO:=trim(aq.fieldbyname('NOMMODEL').asstring) ;

                    finally
                    Close;
                    Free;
                end;
            end;


   {FIN DATOS VEHICULO}

{plantas}
    aQ:=TSQLQuery.Create(nil);
          with aQ do
            begin
              SQLConnection:=mybd;
              sql.add('SELECT idenconc FROM tvarios  ');


                try
                  Open;
                    planta:=trim(aq.fieldbyname('idenconc').asstring) ;

                    finally
                    Close;
                    Free;
                end;
            end;

   if trim(resultad)='APROBADO' then
          CADENA_QR:=TRIM(numoblea)+'/'+trim(DOMINIO)
          else
          CADENA_QR:='NULL/'+trim(DOMINIO);

//CERTIFICADOCABA.QuickRep1.PrinterSettings.PrinterIndex:=
with TCERTIFICADOCABA.create(nil) do
   begin


    QRLABEL57.Caption:=TRIM(fechalta);
    QRLABEL44.Caption:=TRIM(numoblea);

    QRLABEL56.Caption:=TRIM(resultad);



    QRLABEL43.Caption:=TRIM(NRO_INFORME);
    QRLABEL64.Caption:=TRIM(NRO_INFORME);

    QRLABEL73.Caption:=TRIM(fechalta);
    QRLABEL65.Caption:=TRIM(numoblea);

    QRLABEL72.Caption:=TRIM(resultad);

    IF TRIM(resultad)='APROBADO' THEN
     BEGIN
     QRLABEL66.Caption:=copy(TRIM(fechavenci),4,length(TRIM(fechavenci)));
     QRLABEL45.Caption:=copy(TRIM(fechavenci),4,length(TRIM(fechavenci)));
     END ELSE BEGIN
       QRLABEL66.Caption:=TRIM(fechavenci);
       QRLABEL45.Caption:=TRIM(fechavenci);
     END;

   // observa:string;


    {TITULAR}
    QRLABEL47.Caption:=TRIM(TITULARNOMBRE)+' '+TRIM(TITULARAPELLID1)+' '+TRIM(TITULARAPELLID2);
    QRLABEL49.Caption:=TRIM(TITULARDOCUMENTODESCRIPCION)+' '+TRIM(TITULARDOCUMENT);
    QRLABEL68.Caption:=TRIM(TITULARNOMBRE)+' '+TRIM(TITULARAPELLID1)+' '+TRIM(TITULARAPELLID2);
    QRLABEL69.Caption:=TRIM(TITULARDOCUMENTODESCRIPCION)+' '+TRIM(TITULARDOCUMENT);



    {CONDUCTOR}
     QRLABEL70.Caption:=TRIM(CONDUCTORNOMBRE)+' '+TRIM(CONDUCTORPELLID1)+' '+TRIM(CONDUCTORPELLID2);
     QRLABEL71.Caption:=TRIM(CONDUCTORDOCUMENTODESCRIPCION)+' '+TRIM(CONDUCTORDOCUMENT);



    {VEHICULO}
    QRLABEL12.Caption:=TRIM(DOMINIO);
    QRLABEL50.Caption:=TRIM(DOMINIO);
    QRLABEL10.Caption:=TRIM(DOMINIO);
    QRLABEL51.Caption:=TRIM(ANIOFABR);
    QRLABEL55.Caption:=TRIM(CHASIS);
    QRLABEL52.Caption:=TRIM(MARCAVEHICULO);
    QRLABEL53.Caption:=TRIM(MODELOVEHICULO);
    QRLABEL54.Caption:=TRIM(CLASIFICACION);

    {PLANTA}
    QRLABEL40.Caption:=TRIM(PLANTA);
    QRLABEL38.Caption:=TRIM(PLANTA);


    {TIEMPOS}
    QRLABEL2.Caption:=TRIM(LblXHoraIngreso);
    QRLABEL5.Caption:=TRIM(LblXHegr);
    QRLABEL7.Caption:=TRIM(LblXHTTE);
    QRLABEL9.Caption:=TRIM(LblXHTTL);

    QRLABEL62.Caption:=TRIM(DATETOSTR(DATE));
    //QRLABEL46.Caption:=INTTOSTR(cantidadhojas);
    //QRLABEL63.Caption:=' de '+INTTOSTR(cantidadhojas);

   
     contador:=0;

  //  ACTIVAR_COMPONENTES(REIMPRIMIR);

     REIMPRIME:=REIMPRIMIR;

        {qr en el certificado}

    Barcode2D_QRCode1.Barcode := CADENA_QR;
    Barcode2D_QRCode1.Module := 2;
    Barcode2D_QRCode1.DrawToSize(AWidth, AHeight, ASymbolWidth, ASymbolHeight);

     WITH  QRImage1 DO
       BEGIN

           Barcode2D_QRCode1.DrawTo(Canvas, 0, 0);
      END;

        aQim:=TSQLQuery.Create(nil);
      mybd.StartTransaction(td);
        aQim.SQLConnection:=mybd;
        try
        aQim.SQL.Clear;
        aQim.sql.add('delete from tmp_imprsion WHERE CODINSPE=:CODINSPE ');
        aQim.ParamByName('CODINSPE').Value:=codinspe;
        aQim.ExecSQL;
     if mybd.InTransaction then
        mybd.Commit(td);
       except
        mybd.Rollback(td);
       end;

       RxMemoryData1.close;
       RxMemoryData1.open;
       aQ:=TSQLQuery.Create(nil);

     ////armar consulta
        cant_item_informe:=0;
          with aQ do
            begin
              SQLConnection:=mybd;
              sql.add('select CADDEFEC,LITDEFEC,CALIF from TMPDATODEFECIM WHERE CODINSPE=:CODINSPE ');
               ParamByName('CODINSPE').Value:=codinspe;
                try
                  Open;
                   while not eof do
                   begin
                    parte1:='';
                    parte2:='';
                         if length(trim(fieldbyname('LITDEFEC').asstring)) > 90 then
                          begin

                             parte1:=copy(trim(fieldbyname('LITDEFEC').asstring),0,90);
                             parte2:=copy(trim(fieldbyname('LITDEFEC').asstring),91,length(trim(fieldbyname('LITDEFEC').asstring)));


                               aQim.SQL.Clear;
                               aQim.sql.add('SELECT MAX(ORDEN) from tmp_imprsion WHERE CODINSPE=:CODINSPE ');
                               aQim.ParamByName('CODINSPE').Value:=codinspe;
                               aQim.Open;
                               ORDEN:=aQim.FIELDS[0].ASINTEGER + 1 ;


                              aQim.SQL.Clear;
                              aQim.sql.add('insert into tmp_imprsion values(:CODINSPE,:cadena,:descri,:calif,:ORDEN)');
                              aQim.ParamByName('CODINSPE').Value:=codinspe;
                              aQim.ParamByName('cadena').Value:=trim(fieldbyname('CADDEFEC').asstring);
                              aQim.ParamByName('descri').Value:=parte1;
                              aQim.ParamByName('calif').Value:='';
                              aQim.ParamByName('ORDEN').Value:=ORDEN;
                              aQim.ExecSQL;


                                 aQim.SQL.Clear;
                               aQim.sql.add('SELECT MAX(ORDEN) from tmp_imprsion WHERE CODINSPE=:CODINSPE ');
                               aQim.ParamByName('CODINSPE').Value:=codinspe;
                               aQim.Open;
                               ORDEN:=aQim.FIELDS[0].ASINTEGER + 1 ;


                                 aQim.SQL.Clear;
                              aQim.sql.add('insert into tmp_imprsion values(:CODINSPE,:cadena,:descri,:calif,:ORDEN)');
                              aQim.ParamByName('CODINSPE').Value:=codinspe;
                              aQim.ParamByName('cadena').Value:='';
                              aQim.ParamByName('descri').Value:=parte2;
                              aQim.ParamByName('calif').Value:=trim(fieldbyname('CALIF').asstring);
                              aQim.ParamByName('ORDEN').Value:=ORDEN;
                              aQim.ExecSQL;


                              RxMemoryData1.Append;
                              RxMemoryData1codigo.Value:=trim(fieldbyname('CADDEFEC').asstring);
                              RxMemoryData1descripcion.Value:=trim(parte1);
                              RxMemoryData1calif.Value:='';
                              RxMemoryData1califdef.Value:='';
                              RxMemoryData1localiza.Value:='';
                              RxMemoryData1literal.Value:='';

                              RxMemoryData1.Post;
                              cant_item_informe:= cant_item_informe + 1;

                              RxMemoryData1.Append;
                              RxMemoryData1codigo.Value:='';
                              RxMemoryData1descripcion.Value:=trim(parte2);
                              RxMemoryData1calif.Value:=trim(fieldbyname('CALIF').asstring);
                              RxMemoryData1califdef.Value:='';
                              RxMemoryData1localiza.Value:='';
                              RxMemoryData1literal.Value:='';

                              RxMemoryData1.Post;
                              cant_item_informe:= cant_item_informe + 1;


                          end
                          else
                          begin
                               aQim.SQL.Clear;
                               aQim.sql.add('SELECT MAX(ORDEN) from tmp_imprsion WHERE CODINSPE=:CODINSPE ');
                               aQim.ParamByName('CODINSPE').Value:=codinspe;
                               aQim.Open;
                               ORDEN:=aQim.FIELDS[0].ASINTEGER + 1 ;


                              aQim.SQL.Clear;
                              aQim.sql.add('insert into tmp_imprsion values(:CODINSPE,:cadena,:descri,:calif,:ORDEN)');
                              aQim.ParamByName('CODINSPE').Value:=codinspe;
                              aQim.ParamByName('cadena').Value:=trim(fieldbyname('CADDEFEC').asstring);
                              aQim.ParamByName('descri').Value:=trim(fieldbyname('LITDEFEC').asstring);
                              aQim.ParamByName('calif').Value:=trim(fieldbyname('CALIF').asstring);
                              aQim.ParamByName('ORDEN').Value:=ORDEN;
                              aQim.ExecSQL;


                              RxMemoryData1.Append;
                              RxMemoryData1codigo.Value:=trim(fieldbyname('CADDEFEC').asstring);
                              RxMemoryData1descripcion.Value:=trim(fieldbyname('LITDEFEC').asstring);
                              RxMemoryData1calif.Value:=trim(fieldbyname('CALIF').asstring);
                              RxMemoryData1.Post;
                              cant_item_informe:= cant_item_informe + 1;

                          end;


                       next;
                   end;


                  finally
                    Close;
                    Free;
                end;


        END;



 //  RxMemoryData1.First;
       aQim.CLOSE;
        aQim.FREE;
    
     SQLQuery1.SQLConnection:=mybd;
     SQLQuery1.sql.add('select caddefec,descripcion,calif from tmp_imprsion WHERE CODINSPE=:CODINSPE  ORDER BY ORDEN ASC');
     SQLQuery1.ParamByName('CODINSPE').Value:=codinspe;
     SQLQuery1.open;



    QuickRep1.Prepare;

      if cant_item_informe <= 35 then
      CANTIDAD_HOJAS:=1;

       if (cant_item_informe > 35) and  (cant_item_informe <= 65) then
          CANTIDAD_HOJAS:=2;


       if (cant_item_informe > 66) and  (cant_item_informe <= 95) then
          CANTIDAD_HOJAS:=3;










     QRLABEL46.Caption:=INTTOSTR(CANTIDAD_HOJAS);
     QRLABEL63.Caption:=' de '+INTTOSTR(CANTIDAD_HOJAS);

     
   // REIMPRIMIR:=TRUE;
    IF REIMPRIMIR=TRUE THEN
       QuickRep1.Preview
     ELSE
      begin

       QuickRep1.print;

       end;

 END;

except
   on E:Exception do
     begin
     Application.MessageBox( PCHAR('SE HA PRODUCIDO UN ERROR AL INTENTAR IMPRIMIR EL INFORME DE IMPRESION POR:' + E.message),
     'IMPRESION', MB_ICONSTOP );

       imprimir_certificado_caba:=false;
     end;


end;

end;



function TIMPRESIONCABA.CALCULA_CANTIDAD_HOJA(codinspe,ejercicio:longint):longint;
VAR SQLS:STRING;
aQ:TSQLQuery ;
cantidad:longint;
BEGIN
SQLS:='select count(*) from TMPDATODEFECIM where CODINSPE = :UnCodigo ';

     aQ:=TSQLQuery.Create(nil);

     ////armar consulta
          with aQ do
            begin
              SQLConnection:=mybd ;
              SQL.Add(SQLS);


              ParamByName('UnCodigo').Value:=codinspe;//FINspecciones.ValueByName[FIELD_CODINSPE];

                try
                  Open;
                  cantidad:=fields[0].asinteger;


                   CALCULA_CANTIDAD_HOJA:=cantidad;
                  finally
                    Close;
                    Free;
                end;
            end;


end;


end.
