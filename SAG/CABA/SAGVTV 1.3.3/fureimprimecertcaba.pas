unit fureimprimecertcaba;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,SQLEXPR, Graphics, Controls, Forms, UFRMSCANEOCERTIFICADO,
  Dialogs, StdCtrls, Buttons, Grids, globals,DBGrids,ufrmscanearnrooblea, ExtCtrls, DB, RxMemDS,class_impresion;

type
  Tureimprimecertcaba = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    RxMemoryData1: TRxMemoryData;
    DataSource1: TDataSource;
    RxMemoryData1FECHA: TStringField;
    RxMemoryData1NROINSPECCION: TStringField;
    RxMemoryData1RESULTADO: TStringField;
    RxMemoryData1OBLEA: TStringField;
    RxMemoryData1INFORME1: TStringField;
    RxMemoryData1INFORME2: TStringField;
    RxMemoryData1CODINSPE: TIntegerField;
    RxMemoryData1ANIO: TIntegerField;
    RxMemoryData1TITULAR: TStringField;
    RxMemoryData1CONDUCTOR: TStringField;
    RxMemoryData1VENCE: TStringField;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ureimprimecertcaba: Tureimprimecertcaba;

implementation

uses UMENSAJEIMPRESION, Ufrmturnos, UnitPISE_MOTIVO_CAMBIO_OBLEA;

{$R *.dfm}

procedure Tureimprimecertcaba.BitBtn2Click(Sender: TObject);
begin
CLOSE;
end;

procedure Tureimprimecertcaba.BitBtn1Click(Sender: TObject);
var codinspe,icodturnoid:longint;
    anio:longint;
     anio_oblea:sTRING;
    TIMPRE:TIMPRESIONCABA;
    numoblea:string;
    aQim:TSQLQuery;
    aniooblea,MOTIVO_OBLEA:STRING;
    NROBLEASCANEADA,motivocambiooblea,nroinforme:STRING;
    continuar:BOOLEAN;
begin

 codinspe:=dbgrid1.Fields[7].asinteger;
anio:=dbgrid1.Fields[8].asinteger;

    MyBD.StartTransaction(TD);
    TRY

 aQim:=TSQLQuery.Create(nil);
        aQim.SQLConnection:=mybd;
        aQim.SQL.Clear;
        aQim.sql.add('select numoblea from tinspeccion WHERE CODINSPE=:CODINSPE and ejercici=:ejercici ');
        aQim.ParamByName('CODINSPE').Value:=codinspe;
        aQim.ParamByName('ejercici').Value:=anio;
        aQim.ExecSQL;
        aQim.Open;

       numoblea:=trim(aqim.FieldByName('numoblea').asstring);

        aQim.close;
        aQim.free;




if trim(numoblea)<>'' then
   begin
        aQim:=TSQLQuery.Create(nil);
        aQim.SQLConnection:=mybd;
        aQim.SQL.Clear;
        aQim.sql.add('select anio from tobleas WHERE CODINSPE=:CODINSPE and ejercici=:ejercici ');
        aQim.ParamByName('CODINSPE').Value:=codinspe;
        aQim.ParamByName('ejercici').Value:=anio;
        aQim.ExecSQL;
        aQim.Open;

        anio_oblea:=trim(aqim.FieldByName('anio').asstring);

        aQim.close;
        aQim.free;

       if Application.MessageBox( PCHAR('LA INSPECCION TIENE LA OBLEA: '+TRIM(numoblea)+' ¿DESEA SCANEAR OTRA OBLEA?'), 'Asignar oblea',
           MB_ICONQUESTION OR MB_YESNO ) = ID_YES then
       begin
         {pide motivo}
           PISE_MOTIVO_CAMBIO_OBLEA.SHOWMODAL;
           motivocambiooblea:=trim(PISE_MOTIVO_CAMBIO_OBLEA.ComboBox1.Text);
         {---------------------------}

                  if Application.MessageBox( PCHAR('A LA  OBLEA: '+TRIM(numoblea)+' QUIERE VOLVERLA AL STOCK ?'), 'Oblea',
                     MB_ICONQUESTION OR MB_YESNO ) = ID_YES then
                     begin
                            aQim:=TSQLQuery.Create(nil);
                            aQim.SQLConnection:=mybd;
                            aQim.SQL.Clear;
                            aQim.sql.add('UPDATE tobleas  SET estado=''S''  WHERE numoblea=:numoblea ');
                            aQim.ParamByName('numoblea').Value:=numoblea;
                            aQim.ExecSQL;


                           // aQim.close;
                           // aQim.free;



                     end else
                     begin
                           if Application.MessageBox( PCHAR('USTED NO VOLVIO AL STOCK A LA  OBLEA: '+TRIM(numoblea)+' QUIERE ANULAR LA OBLEA?'), 'Oblea',
                             MB_ICONQUESTION OR MB_YESNO ) = ID_YES then
                               begin
                                  aQim:=TSQLQuery.Create(nil);
                                  aQim.SQLConnection:=mybd;
                                  aQim.SQL.Clear;
                                  aQim.sql.add('UPDATE tobleas  SET estado=''A''  WHERE numoblea=:numoblea ');
                                  aQim.ParamByName('numoblea').Value:=numoblea;
                                  aQim.ExecSQL;


                               //  aQim.close;
                               //  aQim.free;



                                 aQim:=TSQLQuery.Create(nil);
                                  aQim.SQLConnection:=mybd;
                                  aQim.SQL.Clear;
                                  aQim.sql.add('INSERT INTO TOBLEAS_ANULADAS (CODANULAC,FECHA,NUMOBLEA,MOTIVO,AUTORIZO) '+
                                  ' VALUES (SQ_TOBLEAS_ANULADAS.NEXTVAL,SYSDATE,'+#39+TRIM(numoblea)+#39+','+#39+TRIM(motivocambiooblea)+#39+','+INTTOSTR(GLOBALS.ID_USUARIO_LOGEO_SAG)+') ');

                                  aQim.ExecSQL;


                               //  aQim.close;
                               //  aQim.free;



                                 end;


                     end;




           with tfrmscanearnrooblea.create(self) do
            begin
               LABEL2.CAPTION:='';
               sale:=true;
               edit1.Text:=trim(numoblea);
               edit2.Text:=anio_oblea;
               showmodal();
                if sale=true then
                   begin
                    if    TRIM(EDIT1.Text)<>'' then
                        begin
                           aniooblea:=TRIM(EDIT2.Text);
                           NROBLEASCANEADA:=TRIM(EDIT1.Text);
                // RestoreOblea(strtoint(NROBLEASCANEADA), strtoint(aniooblea) ,MyBD);
                       end;

                   continuar:=false;
                   exit;
                 end ELSE BEGIN
                      //ASIGNA LA OLBEA SCANEADA A LA INSPECCION

                       aniooblea:=TRIM(EDIT2.Text);
                       NROBLEASCANEADA:=TRIM(EDIT1.Text);

                       aQim:=TSQLQuery.Create(nil);
                       aQim.SQLConnection:=mybd;
                       aQim.SQL.Clear;
                       aQim.sql.add('UPDATE TINSPECCION SET NUMOBLEA='+#39+TRIM(NROBLEASCANEADA)+#39+' WHERE CODINSPE=:CODINSPE and ejercici=:ejercici ');
                       aQim.ParamByName('CODINSPE').Value:=codinspe;
                       aQim.ParamByName('ejercici').Value:=anio;
                       aQim.ExecSQL;


                       aQim.close;
                       aQim.free;



                         //ACTUALIZA CODINSPE EN TOBLEAS
                       aQim:=TSQLQuery.Create(nil);
                       aQim.SQLConnection:=mybd;
                       aQim.SQL.Clear;
                       aQim.sql.add('UPDATE TOBLEAS SET estado=''C'',  CODINSPE=:CODINSPE,    EJERCICI=:EJERCICI   WHERE NUMOBLEA='+#39+TRIM(NROBLEASCANEADA)+#39);
                       aQim.ParamByName('CODINSPE').Value:=codinspe;
                       aQim.ParamByName('ejercici').Value:=anio;
                       aQim.ExecSQL;


                       aQim.close;
                       aQim.free;



                           //GUARDA CAMBIO DE OBLEA
                       aQim:=TSQLQuery.Create(nil);
                       aQim.SQLConnection:=mybd;
                       aQim.SQL.Clear;
                       aQim.sql.add('INSERT INTO TCAMBIOOBLEAS (NUMOBLEA,NUMOBLEANUEV,CODINSPE, MOTIVO, FECHA_ALTA) '+
                       ' VALUES ('+#39+TRIM(numoblea)+#39+','+#39+TRIM(NROBLEASCANEADA)+#39+','+INTTOSTR(codinspe)+','+#39+TRIM(motivocambiooblea)+#39+',SYSDATE) ');

                       aQim.ExecSQL;


                       aQim.close;
                       aQim.free;




                     continuar:=TRUE;

                    END;




              free;
           end;

      end //mensaje
      ELSE
       BEGIN
           continuar:=TRUE;
       END;





 END ELSE           //OBLEAAS
 BEGIN
  continuar:=TRUE;

 END;



IF CONTINUAR=TRUE THEN
 BEGIN


 MENSAJEIMPRESION.Label1.Caption:='REIMPRIMIENDO INFORME DE INSPECCION...';
 MENSAJEIMPRESION.SHOW;
 aPPLICATION.ProcessMessages;

 TIMPRE:=TIMPRESIONCABA.Create;
 TIMPRE.imprimir_certificado_caba(codinspe,anio,0,true,'x');
 TIMPRE.Free;

 MENSAJEIMPRESION.close;

   //SCANEAR CERTIFICADOS



      with TFRMSCANEOCERTIFICADO.create(nil) do
        begin
        cantidadhojas:=0;
        sale:=true;
            edit1.cleAR;
           rxmemorydata1.close;
           rxmemorydata1.open;
         { cantidadhojas:=CALCULA_CANTIDAD_HOJA(codigoinpeccionseleccionado,anio);

           if cantidadhojas=0 then
              cantidadhojas:=1;    }

           cantidadhojas:=1;
           cantscaneeo:=1;
          // label2.Caption:='CANTIDAD: '+inttostr(cantscaneeo)+' de '+inttostr(hojasinforme);

            sale:=true;
           showmodal();
           if sale=true then
           begin

               { anular_certificado=TRUE THEN
                  BEGIN
                       With TSQLQuery.Create(nil) do
                        try
                          SQLConnection:=mybd;
                          Close;
                          SQL.Clear;
                          SQL.Add ('alter session set nls_date_format = ''dd/mm/yyyy''');
                          EXECSQL;
                          SQL.Clear;
                          SQL.Add ('insert into TCERTIFICADOS_ANULADOS ');
                          SQL.Add (' select sq_tcertificados_anulados.nextval,to_char(sysdate,''DD/MM/YYYY''),nrocertificado,''REIMPRESION'',:AUTORIZO ');
                          SQL.Add (' from certificadoinspeccion where codinspe=:CODINSPE ');
                          ParamByName('AUTORIZO').Value:=id_usuario_logeo_sag;
                          ParamByName('CODINSPE').Value:=codinspe;
                          EXECSQL;
                          SQL.Clear;
                          sql.add('select distinct nro_informe as numero from certificadoinspeccion WHERE CODINSPE=:CODINSPE');
                          ParamByName('CODINSPE').Value:=codinspe;
                          ExecSQL;
                          Open;
                          nroinforme:=trim(FieldByName('numero').asstring);
                          SQL.Clear;
                          SQL.Add ('DELETE FROM certificadoinspeccion    WHERE CODINSPE=:CODINSPE');
                          ParamByName('CODINSPE').Value:=codinspe;
                          EXECSQL;
                          SQL.Clear;
                          SQL.Add ('UPDATE tcertificados set estado=''A'',fecha_anulado=sysdate    WHERE CODINSPE=:CODINSPE');
                          ParamByName('CODINSPE').Value:=codinspe;
                          EXECSQL;
                        finally
                          Close;
                           Free;
                        end;



                 end; }


                CONTINUAR:=FALSE;
                exit;
            END;

          //guarda en la tabla  certificadoinspeccion

            With TSQLQuery.Create(nil) do
            try
                          SQLConnection:=mybd;
                          Close;
                          SQL.Clear;
                          SQL.Add ('alter session set nls_date_format = ''dd/mm/yyyy''');
                          EXECSQL;
                          SQL.Clear;
                          SQL.Add ('insert into TCERTIFICADOS_ANULADOS ');
                          SQL.Add (' select sq_tcertificados_anulados.nextval,to_char(sysdate,''DD/MM/YYYY''),nrocertificado,''REIMPRESION'',:AUTORIZO ');
                          SQL.Add (' from certificadoinspeccion where codinspe=:CODINSPE ');
                          ParamByName('AUTORIZO').Value:=id_usuario_logeo_sag;
                          ParamByName('CODINSPE').Value:=codinspe;
                          EXECSQL;
                          SQL.Clear;
                          sql.add('select distinct nro_informe as numero from certificadoinspeccion WHERE CODINSPE=:CODINSPE');
                          ParamByName('CODINSPE').Value:=codinspe;
                          ExecSQL;
                          Open;
                          nroinforme:=trim(FieldByName('numero').asstring);
                          SQL.Clear;
                          SQL.Add ('DELETE FROM certificadoinspeccion    WHERE CODINSPE=:CODINSPE');
                          ParamByName('CODINSPE').Value:=codinspe;
                          EXECSQL;
                          SQL.Clear;
                          SQL.Add ('UPDATE tcertificados set estado=''A'',fecha_anulado=sysdate    WHERE CODINSPE=:CODINSPE');
                          ParamByName('CODINSPE').Value:=codinspe;
                          EXECSQL;
            finally
                          Close;
                           Free;
            end;



           RXMEMORYDATA1.Open;
           RXMEMORYDATA1.First;
          while not  RXMEMORYDATA1.Eof DO
          BEGIN
              With TSQLQuery.Create(nil) do

                try
                    SQLConnection:=mybd;
                    Close;
                    SQL.Clear;
                    SQL.Add ('INSERT INTO CABA.CERTIFICADOINSPECCION (CODINSPE, NROCERTIFICADO, NRO_INFORME) VALUES (:CODINSPE,:NROCERTI,:NROINFOR)');
                    ParamByName('CODINSPE').Value:=codinspe;
                    ParamByName('NROCERTI').Value:=TRIM(RxMemoryData1certificado.Value);
                    ParamByName('NROINFOR').Value:=TRIM(nroinforme);
                    EXECSQL;
                  finally
                        Close;
                        Free;
                  end;

                   aQim:=TSQLQuery.Create(nil);
                   aQim.SQLConnection:=mybd;
                  aQim.Close;
                  aQim.SQL.Clear;
                  aQim.SQL.Add ('update tcertificados set estado=''C'', fecha_consumido=sysdate'+
                             ', codinspe='+inttostr(codinspe)+' where  numcertif='+#39+trim(RxMemoryData1certificado.Value)+#39);

                  aQim.EXECSQL;
                  aQim.Close;
                  aQim.Free;



            RXMEMORYDATA1.Next;

         END;
          CONTINUAR:=TRUE;



       end;


   END;
     // fin CERTIFICADO


 MYBD.Commit(TD);
 CONTINUAR:=true;
 EXCEPT
 MyBD.Rollback(TD);
 CONTINUAR:=false;
 END ;




   //-------------------------------------
   //INFORMAR AL WS
 IF CONTINUAR=TRUE THEN
     BEGIN

           With TSQLQuery.Create(nil) do

                try
                    SQLConnection:=mybd;
                    Close;
                    SQL.Clear;

                    SQL.Add ('SELECT TURNOID FROM TDATOSTURNO WHERE CODINSPE=:CODINSPE ');
                    ParamByName('CODINSPE').Value:=codinspe;
                    EXECSQL;
                    OPEN  ;
                    icodturnoid:=FIELDBYNAME('TURNOID').ASINTEGER;
                  finally
                        Close;
                        Free;
           end;



                   try
                     MENSAJEIMPRESION.Label1.Caption:='INFORMANDO REIMPRESION DE VERIFICACION A SUVTV...';
                     MENSAJEIMPRESION.SHOW;
                     frmturnos.INFORMA_INSPECCION_AL_WEBSERVICES(icodturnoid,
                                                              CODINSPE
                                                            ,anio);

                     MENSAJEIMPRESION.close;
                    except
                     MENSAJEIMPRESION.close ;
                     End;

 END;  //CONTINUA WS




 aQim:=TSQLQuery.Create(nil);
        aQim.SQLConnection:=mybd;
        aQim.SQL.Clear;
        aQim.sql.add('delete from tmp_imprsion WHERE CODINSPE=:CODINSPE ');
        aQim.ParamByName('CODINSPE').Value:=codinspe;
        aQim.ExecSQL;
        aQim.close;
        aQim.free;






end;

end.
