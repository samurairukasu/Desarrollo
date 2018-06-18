unit uExportaciones;

interface
  uses ugetdates, globals, SQLExpr, forms,  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs,
  StdCtrls, Db, ZipMstr, dateutil, dbclient, provider;


  function CorregirCodigo(q:string):string;
  function ObtenerPatente(obl_a,obl_n:string):string;
  procedure ComprimirArchivos(tipo: integer);
  procedure DoExportacionEnte_New;

implementation

uses
  ufTmp,  uutils, uSagClasses, uSagEstacion;

var
  dateini,datefin:string;
  f1,f2,f3,f4:text;
  FBusqueda: TFTmp;
  ZipMaster1: TZipMaster;

resourcestring
  FICHERO_ACTUAL = 'uExportaciones';
  clavezip = 'FlashE60&MX!pci';

const
  SEP_GNC = '|';  //separador de campos para exportación GNC


procedure DoExportacionEnte_New;
VAR Sentence:TSQLQuery;
   res:array [1..3] of char;
   ver:array [1..2] of char;
   ClasVeh,ClasClient,cantid,i,j:integer;
   ProcLimpia,ProcLlena:TSQLStoredProc;
   sdsfPlanta : TSQLDataSet;
   dspfPlanta : TDataSetProvider;
   fPlanta: TClientDataSet;
   dspTableInspect,dspTableVehic,dspTableDefect,dspTableClient:TDataSetProvider;
   sdsTableInspect,sdsTableVehic,sdsTableDefect,sdsTableClient:TSQLDataSet;
   TableInspect,TableVehic,TableDefect,TableClient:TClientDataSet;
begin
   res[1]:='A';
   res[2]:='C';
   res[3]:='R';
   ver[1]:='V';
   ver[2]:='R';

  sdsfPlanta:=TSQLDataSet.Create(application);
  sdsfPlanta.SQLConnection := BDAG;
  sdsfPlanta.CommandType := ctQuery;
  dspfPlanta := TDataSetProvider.Create(application);
  dspfPlanta.DataSet := sdsfPlanta;
  dspfPlanta.Options := [poIncFieldProps,poAllowCommandText];
  fPlanta:=TClientdataset.Create (application);

  AssignFile(f1,'c:\argentin\envio\ente\inspec.dat');
  AssignFile(f2,'c:\argentin\envio\ente\vehiculo.dat');
  AssignFile(f3,'c:\argentin\envio\ente\defect.dat');
  AssignFile(f4,'c:\argentin\envio\ente\client.dat');
  rewrite(f1);
  rewrite(f2);
  rewrite(f3);
  rewrite(f4);
   if not GetDates(dateini,datefin) then exit;
    with fplanta do
       begin
       setprovider(dspfPlanta);
       commandtext := 'SELECT * FROM TPLANTAS  WHERE TIPO=''P'' ';
       Open;
       while not fPlanta.Eof do
       begin
        MyBD.Close;
        MyBD.free;
        TestOfBD('',fplanta.fields[2].value,fplanta.fields[3].value,false);
        InitAplicationGlobalTables;
      try
     try
      fbusqueda:= TFTmp.create(application);
        try
        Screen.Cursor:=crHourGlass;
          with fbusqueda do
            muestraclock('Exportación','Leyendo los datos para la Exportación Planta '+fplanta.fields[2].value);
            Application.ProcessMessages;

            ProcLimpia:=TSQLStoredProc.Create(application);
            ProcLimpia.SQLConnection:=mybd;
            ProcLimpia.StoredProcName:='PQ_EXPORTA.CLEANT_ERVTV';
            ProcLimpia.Prepared := true;
            ProcLimpia.ExecProc;

            ProcLlena:=TSQLStoredProc.Create(application);
            ProcLlena.SQLConnection:=mybd;
            ProcLlena.StoredProcName:='PQ_EXPORTA.LISTADO_ERVTV_INSPEC';

              try               //porque la primera vez que se lo corre despues de importar la base tira un error
                ProcLlena.Prepared := true;
              except
                ProcLlena.Prepared := true;
              end;

             ProcLlena.ParamByName('FECHAFIN').value:=copy(datetimetostr(strtodatetime(datefin)+1),1,10);
             ProcLlena.ParamByName('FECHAINI').value:=copy(dateini,1,10);
             ProcLlena.ExecProc;

             Sentence:=TSQLQuery.Create(application);
             Sentence.SQLConnection:=mybd;
             Sentence.SQL.Add('DELETE FROM TEMPTAB');
             Sentence.ExecSQL;
             for ClasVeh:=1 to 5 do
              for ClasClient:=1 to 7 do
                for i:=1 to 3 do
                  for j:=1 to 2 do
                    begin
                      Sentence.SQL.Clear;
                      Sentence.SQL.Add('SELECT COUNT(DISTINCT(I.NUMINSPE)) FROM T_ERVTV_INSPECT I,T_ERVTV_VEHICULOS V WHERE I.MATRICULA IN (V.MATRICULA_A,V.MATRICULA_N) AND I.RESULTAD=:RES AND I.REVERIFI=:VER AND I.TIPORIGEN=:ORI AND V.CLASIFIC=:CLA');
                      Sentence.ParamByName('RES').AsString:=res[i];
                      Sentence.ParamByName('VER').AsString:=ver[j];
                      Sentence.ParamByName('ORI').AsInteger:=ClasClient;
                      Sentence.ParamByName('CLA').AsInteger:=ClasVeh;
                      Sentence.Open;
                      cantid:=Sentence.Fields[0].AsInteger;
                      if cantid<>0 then
                        begin
                          Sentence.Close;
                          Sentence.SQL.Clear;
                          Sentence.SQL.Add('INSERT INTO TEMPTAB VALUES(:CLA,:ORI,:RES,:VER,:CAN)');
                          Sentence.ParamByName('RES').AsString:=res[i];
                          Sentence.ParamByName('VER').AsString:=ver[j];
                          Sentence.ParamByName('ORI').AsInteger:=ClasClient;
                          Sentence.ParamByName('CLA').AsInteger:=ClasVeh;
                          Sentence.ParamByName('CAN').AsInteger:=cantid;
                          Sentence.ExecSQL;
                        end
                      else
                        Sentence.Close;
                    end;
              Application.ProcessMessages;

              sdsTableInspect := TSQLDataSet.Create(application);
              sdsTableVehic := TSQLDataSet.Create(application);
              sdsTableDefect := TSQLDataSet.Create(application);
              sdsTableClient := TSQLDataSet.Create(application);

              sdsTableInspect.GetMetadata := false;
              sdsTableVehic.GetMetadata := false;
              sdsTableDefect.GetMetadata := false;
              sdsTableClient.GetMetadata := false;

              sdsTableInspect.NoMetadata := true;
              sdsTableVehic.NoMetadata := true;
              sdsTableDefect.NoMetadata := true;
              sdsTableClient.NoMetadata := true;


              sdsTableInspect.ParamCheck := false;
              sdsTableVehic.ParamCheck := false;
              sdsTableDefect.ParamCheck := false;
              sdsTableClient.ParamCheck := false;


              sdsTableInspect.SQLConnection := MyBD;
              sdsTableVehic.SQLConnection := MyBD;
              sdsTableDefect.SQLConnection := MyBD;
              sdsTableClient.SQLConnection := MyBD;

              sdsTableInspect.CommandType := ctTable;
              sdsTableVehic.CommandType := ctTable;
              sdsTableDefect.CommandType := ctTable;
              sdsTableClient.CommandType := ctTable;

              dspTableInspect := TDataSetProvider.Create(application);
              dspTableInspect.DataSet := sdsTableInspect;
              dspTableInspect.Options := [poIncFieldProps,poAllowCommandText];

              dspTableVehic := TDataSetProvider.Create(application);
              dspTableVehic.DataSet := sdsTableVehic;
              dspTableVehic.Options := [poIncFieldProps,poAllowCommandText];

              dspTableDefect := TDataSetProvider.Create(application);
              dspTableDefect.DataSet := sdsTableDefect;
              dspTableDefect.Options := [poIncFieldProps,poAllowCommandText];

              dspTableClient := TDataSetProvider.Create(application);
              dspTableClient.DataSet := sdsTableClient;
              dspTableClient.Options := [poIncFieldProps,poAllowCommandText];

              TableInspect:=TClientDataSet.Create(application);
              TableInspect.SetProvider(dspTableInspect);
              TableInspect.CommandText:='T_ERVTV_INSPECT';

              TableVehic:=TClientDataSet.Create(application);
              TableVehic.SetProvider(dspTableVehic);
              TableVehic.CommandText:='T_ERVTV_VEHICULOS';

              TableDefect:=TClientDataSet.Create(application);
              TableDefect.SetProvider(dspTableDefect);
              TableDefect.CommandText:='T_ERVTV_DEFECTOS';

              TableClient:=TClientDataSet.Create(application);
              TableClient.SetProvider(dspTableClient);
              TableClient.CommandText:='T_ERVTV_CLIENTES';

              with fbusqueda do
              //  muestraclock('Exportación','Exportando los datos para el ENTE...');


              //rewrite(f1);
              TableInspect.Open;
              TableInspect.First;
              while not TableInspect.EOF do
                begin
                  writeln(f1,TableInspect.FieldByName('ZONA').AsString:2,
                  TableInspect.FieldByName('ESTACION').AsString:3,
                  TableInspect.FieldByName('EJERCICI').AsString:4,
                  TableInspect.FieldByName('NUMINSPE').AsString:7,
                  TableInspect.FieldByName('MATRICULA').AsString:10,
                  TableInspect.FieldByName('TIPODOC').AsString:4,
                  TableInspect.FieldByName('NUMDOCU').AsString:13,
                  TableInspect.FieldByName('FECHAVER').AsString:8,
                  TableInspect.FieldByName('REVERIFI').AsString:1,
                  TableInspect.FieldByName('TTOTAL').AsString:15,
                  TableInspect.FieldByName('FECHAVENC').AsString:8,
                  TableInspect.FieldByName('NUMOBLEA').AsString:9,
                  TableInspect.FieldByName('RESULTAD').AsString:1,
                  TableInspect.FieldByName('COMENTS').AsString:128,
                  TableInspect.FieldByName('LINEA').AsString:3,
                  TableInspect.FieldByName('TIPFACTU').AsString:1,
                  TableInspect.FieldByName('NUMFACTU').AsString:12,
                  TableInspect.FieldByName('IMPORTE').AsFloat:6:2,
                  TableInspect.FieldByName('TIPORIGEN').AsString:2,
                  TableInspect.FieldByName('PUBUSU').AsString:1);
                  TableInspect.Next;
                end;
             // closeFile(f1);
              TableInspect.Close;
             // AssignFile(f2,'c:\argentin\envio\ente\vehiculo.dat');
             // rewrite(f2);
              TableVehic.Open;
              TableVehic.First;

              while not TableVehic.EOF do
                begin
                  writeln(f2,TableVehic.FieldByName('MATRICULA_N').AsString:10,
                  TableVehic.FieldByName('MATRICULA_A').AsString:10,
                  TableVehic.FieldByName('FECHAMAT').AsString:8,
                  TableVehic.FieldByName('MARCA').AsString:12,
                  TableVehic.FieldByName('MODELO').AsString:12,
                  TableVehic.FieldByName('CLASIFIC').AsString:2,
                  TableVehic.FieldByName('NACIONAL').AsString:3,
                  TableVehic.FieldByName('ANIOFABR').AsString:4,
                  TableVehic.FieldByName('NUMBASTI').AsString:20,
                  TableVehic.FieldByName('NUMOTOR').AsString:20,
                  TableVehic.FieldByName('NUMEJES').AsString:1,
                  TableVehic.FieldByName('TIPOCOMB').AsString:1);
                  TableVehic.Next;
                end;

            //  closeFile(f1);
              TableVehic.Close;
             // AssignFile(f3,'c:\argentin\envio\ente\defect.dat');
             // rewrite(f3);
              TableDefect.Open;
              TableDefect.First;
              while not TableDefect.EOF do
                begin
                  writeln(f3,TableDefect.FieldByName('ZONA').AsString:2,
                  TableDefect.FieldByName('ESTACION').AsString:3,
                  TableDefect.FieldByName('EJERCICI').AsString:4,
                  TableDefect.FieldByName('NUMINSPE').AsString:7,
                  TableDefect.FieldByName('SECCION').AsString:2,
                  TableDefect.FieldByName('PUNTOS').AsString:2,
                  TableDefect.FieldByName('CALIFIC').AsString:1);
                  TableDefect.Next;
                end;

             // closeFile(f1);
              TableDefect.Close;
           //   AssignFile(f4,'c:\argentin\envio\ente\client.dat');
             // rewrite(f4);
              TableClient.Open;
              TableClient.First;
              while not TableClient.EOF do
                begin
                  writeln(f4,TableClient.FieldByName('TIPODOC').AsString:4,
                  TableClient.FieldByName('NUMDOCU').AsString:13,
                  TableClient.FieldByName('NOMBRE').AsString:30,
                  TableClient.FieldByName('APELLID1').AsString:50,
                  TableClient.FieldByName('APELLID2').AsString:50,
                  TableClient.FieldByName('DIRECCIO').AsString:50,
                  CorregirCodigo(TableClient.FieldByName('CODPOSTA').AsString):5,
                  copy(TableClient.FieldByName('TELEFONO').AsString,1,15):15,
                  copy(TableClient.FieldByName('LOCALIDA').AsString,1,30):30,
                  TableClient.FieldByName('PARTIDO').AsString:3);
                  TableClient.Next;
                end;

          Screen.Cursor:=crDefault;
         // closeFile(f1);
          TableClient.Close;
         // ComprimirArchivos(1);
        //  MessageDlg('Exportación el ENTE generada correctamente',mtInformation,[mbOK],0);
          Application.ProcessMessages;
         finally
          fbusqueda.close;
          fbusqueda.free;
        end;
     finally
       Sentence.Close;
       Sentence.Free;
       ProcLimpia.Free;
       ProcLlena.Free;
       TableInspect.Free;
       dspTableInspect.Free;
       sdsTableInspect.Free;
       TableVehic.Free;
       dspTableVehic.Free;
       sdsTableVehic.Free;
       TableDefect.Free;
       dspTableDefect.Free;
       sdsTableDefect.Free;
       TableClient.Free;
       dspTableClient.Free;
       sdsTableClient.Free;
     end;

   except
    on E: Exception do
      begin
        Screen.Cursor:=crDefault;
        MessageDlg('No se pudo realizar la exportación por: ' + E.message,mtInformation,[mbOK],0);
      end;
   end;

   fPlanta.Next;
   end;
  end;
  fplanta.Close;
  fplanta.free;
  closeFile(f1);
  closeFile(f2);
  closeFile(f3);
  closeFile(f4);
  ComprimirArchivos(1);
end;




function CorregirCodigo(q:string):string;
var i:integer;
    s:string;
begin
   s:=q;
   if s<>'' then
      for i:=1 to Length(s) do
         if not(s[i] in ['0','1','2','3','4','5','6','7','8','9']) then
            if (i=1) or (i=Length(s)) then
               s[i]:=' '
            else
               s:=' '+Copy(s,1,i-1)+Copy(s,i+1,Length(s)-i);
   Result:=s;
end;

function ObtenerPatente(obl_a,obl_n:string):string;
var TraeDatos:TSQLQuery;
begin
   TraeDatos:=TSQLQuery.Create(application);
   with TraeDatos do
      begin
         SQLConnection:=mybd;
         SQL.Add('SELECT MATRICULA FROM T_ERVTV_INUTILIZ WHERE OBLEAANT=:OA AND OBLEANUEV=:ON');
         ParamByName('OA').AsString:=obl_a;
         ParamByName('ON').AsString:=obl_n;
         try
            Open;
            Result:=Fields[0].AsString;
         finally
             Close;
             Free;
         END;
      end;
end;

procedure ComprimirArchivos(tipo: integer);
var
Mes, Ano, Dia, FechaCompleta, NumeroEstacion,mesano,nombrefec,codtaller: string;
begin
   zipmaster1:=tzipmaster.Create(application);
   ZipMaster1.Load_Zip_Dll;
   NumeroEstacion := 'GLOBAL';
 //  codtaller := '01';
   mesano:=formatoceros(extractmonth(strtodate(copy(dateini,1,10))),2)+inttostr(extractyear(strtodate(copy(dateini,1,10))));
   nombrefec := inttostr(extractyear(strtodate(copy(datefin,1,10))))+formatoceros(extractmonth(strtodate(copy(datefin,1,10))),2)+formatoceros(extractday(strtodate(copy(datefin,1,10))),2);

   Ano:=copy(dateini,9,2);
   Mes:=copy(dateini,4,2);
   Dia:=copy(dateini,1,2);
   FechaCompleta:=Dia+Mes+Ano;

   Screen.Cursor:=crHourGlass;
   case tipo of
     1:begin
            ZipMaster1.ZipFileName:='c:\argentin\envio\ente\info'+numeroestacion+FechaCompleta+'.zip';
            ZipMaster1.FSpecArgs.Add('c:\argentin\envio\ente\vehiculo.dat');
            ZipMaster1.Add;
            ZipMaster1.FSpecArgs.Add('c:\argentin\envio\ente\inspec.dat');
            ZipMaster1.Add;
            ZipMaster1.FSpecArgs.Add('c:\argentin\envio\ente\client.dat');
            ZipMaster1.Add;
            ZipMaster1.FSpecArgs.Add('c:\argentin\envio\ente\defect.dat');
            ZipMaster1.Add;
            DeleteFile('c:\argentin\envio\ente\vehiculo.dat');
            DeleteFile('c:\argentin\envio\ente\inspec.dat');
            DeleteFile('c:\argentin\envio\ente\client.dat');
            DeleteFile('c:\argentin\envio\ente\defect.dat');
     end;
     2:begin
            ZipMaster1.ZipFileName:='c:\argentin\envio\sp'+numeroestacion+mesano+'.zip';
            ZipMaster1.FSpecArgs.Add('c:\argentin\envio\inspain.dat');
            ZipMaster1.Add;
     end;
     3:begin
            ZipMaster1.ZipFileName:='c:\argentin\envio\inuanu'+numeroestacion+mesano+'.zip';
            ZipMaster1.FSpecArgs.Add('c:\argentin\envio\inutiliz.dat');
            ZipMaster1.Add;
            ZipMaster1.FSpecArgs.Add('c:\argentin\envio\anulac.dat');
            ZipMaster1.Add;
     end;
     4:begin
            ZipMaster1.ZipFileName:='c:\argentin\envio\anexo'+numeroestacion+mesano+'.zip';
            ZipMaster1.FSpecArgs.Add('c:\argentin\envio\anexo.dat');
            ZipMaster1.Add;
     end;
     5:begin
            ZipMaster1.ZipFileName:='c:\argentin\envio\GNC_Enargas\'+codtaller+nombrefec+'.zip';
            ZipMaster1.FSpecArgs.Add('c:\argentin\envio\GNC_Enargas\cil'+nombrefec+'.txt');
            ZipMaster1.Add;
            ZipMaster1.FSpecArgs.Add('c:\argentin\envio\GNC_Enargas\reg'+nombrefec+'.txt');
            ZipMaster1.Add;
            ZipMaster1.FSpecArgs.Add('c:\argentin\envio\GNC_Enargas\ft'+nombrefec+'.txt');
            ZipMaster1.Add;
            DeleteFile('c:\argentin\envio\GNC_Enargas\cil'+nombrefec+'.txt');
            DeleteFile('c:\argentin\envio\GNC_Enargas\reg'+nombrefec+'.txt');
            DeleteFile('c:\argentin\envio\GNC_Enargas\ft'+nombrefec+'.txt');
     end;
     6:begin
            ZipMaster1.ZipFileName:='c:\argentin\envio\GNC_Enargas\anugnc'+numeroestacion+nombrefec+'.zip';
            ZipMaster1.FSpecArgs.Add('c:\argentin\envio\GNC_Enargas\anuGNC'+numeroestacion+nombrefec+'.dat');
            ZipMaster1.Add;
     end;
     7:begin
            ZipMaster1.ZipFileName:='c:\argentin\envio\provincia\prov'+NumeroEstacion+nombrefec+'.zip';
            ZipMaster1.FSpecArgs.Add('c:\argentin\envio\provincia\prov'+NumeroEstacion+nombrefec+'.dat');
            ZipMaster1.Add;
            DeleteFile('c:\argentin\envio\provincia\prov'+NumeroEstacion+nombrefec+'.dat');
     end;
     8:begin
            ZipMaster1.ZipFileName:='c:\argentin\envio\VTV\CD'+numeroestacion+nombrefec+'.zip';
            ZipMaster1.FSpecArgs.Add('c:\argentin\envio\VTV\CD'+numeroestacion+nombrefec+'.dat');
            ZipMaster1.FSpecArgs.Add('c:\argentin\envio\VTV\OB'+numeroestacion+nombrefec+'.dat');
            //sacamos la pass de zipeado
          //  ZipMaster1.FSpecArgs.Add('c:\argentin\envio\VTV\OB'+numeroestacion+nombrefec+'.dat<'+clavezip);
            ZipMaster1.Add;
            DeleteFile('c:\argentin\envio\VTV\CD'+NumeroEstacion+nombrefec+'.dat');
            DeleteFile('c:\argentin\envio\VTV\OB'+NumeroEstacion+nombrefec+'.dat');
     end;
     9:begin
            ZipMaster1.ZipFileName:='c:\argentin\envio\GNC_Enargas\CG'+numeroestacion+nombrefec+'.zip';
            ZipMaster1.FSpecArgs.Add('c:\argentin\envio\GNC_Enargas\CG'+numeroestacion+nombrefec+'.dat');
            ZipMaster1.FSpecArgs.Add('c:\argentin\envio\GNC_Enargas\OB'+numeroestacion+nombrefec+'.dat');
            //sacamos la pass de zipeado
           // ZipMaster1.FSpecArgs.Add('c:\argentin\envio\GNC_Enargas\OB'+numeroestacion+nombrefec+'.dat<'+clavezip);
            ZipMaster1.Add;
            DeleteFile('c:\argentin\envio\GNC_Enargas\CG'+NumeroEstacion+nombrefec+'.dat');
            DeleteFile('c:\argentin\envio\GNC_Enargas\OB'+NumeroEstacion+nombrefec+'.dat');
     end;
   end;
   Screen.Cursor:=crDefault;
   ZipMaster1.Unload_Zip_Dll;
   zipmaster1.free;
end;

end.


