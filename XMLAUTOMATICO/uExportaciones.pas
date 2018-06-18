unit uExportaciones;

interface
  uses ugetdates, globals, SQLExpr, forms,  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs,
  StdCtrls, Db, ZipMstr, dateutil, dbclient, provider;

  procedure DoExportacionEnte;
  procedure DoExportacionEspana;
  procedure DoExportacionEnteObleas;
  procedure DoExportacionAnexo;
  procedure DoExportacionGNC;
  procedure DoExportacionCDiarioGNC(aq: tClientDataset; fechini, fechfin:string);
  procedure DoExportacionCDiarioVTV(fechini, fechfin: string);
  procedure DoExportacionProvSeguros;
  function CorregirCodigo(q:string):string;
  function ObtenerPatente(obl_a,obl_n:string):string;
  procedure ComprimirArchivos(tipo: integer);
  procedure DoExportacionEnte_New(dateini, datefin: String);

implementation

uses
  UFContEnte, ufTmp, ULOGS, uutils, uSagClasses, uSagEstacion;

var
  dateini,datefin:string;
  f1,f2:text;
  FBusqueda: TFTmp;
  ZipMaster1: TZipMaster;

resourcestring
  FICHERO_ACTUAL = 'uExportaciones';
  clavezip = 'FlashE60&MX!pci';

const
  SEP_GNC = '|';  //separador de campos para exportación GNC


procedure DoExportacionEnte_New(dateini, datefin: String);
VAR Sentence:TSQLQuery;
   res:array [1..3] of char;
   ver:array [1..2] of char;
   ClasVeh,ClasClient,cantid,i,j:integer;
   ProcLimpia,ProcLlena:TSQLStoredProc;
   dspTableInspect,dspTableVehic,dspTableDefect,dspTableClient:TDataSetProvider;
   sdsTableInspect,sdsTableVehic,sdsTableDefect,sdsTableClient:TSQLDataSet;
   TableInspect,TableVehic,TableDefect,TableClient:TClientDataSet;
begin
   res[1]:='A';
   res[2]:='C';
   res[3]:='R';
   ver[1]:='V';
   ver[2]:='R';
   try
     try
      fbusqueda:= TFTmp.create(application);
        try
        Screen.Cursor:=crHourGlass;
          with fbusqueda do
            muestraclock('Exportación','Generando los datos para la Exportación...');
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
                muestraclock('Exportación','Exportando los datos para el ENTE...');

              AssignFile(f1,'c:\argentin\envio\ente\inspec.dat');
              rewrite(f1);
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
              closeFile(f1);
              TableInspect.Close;
              AssignFile(f1,'c:\argentin\envio\ente\vehiculo.dat');
              rewrite(f1);
              TableVehic.Open;
              TableVehic.First;

              while not TableVehic.EOF do
                begin
                  writeln(f1,TableVehic.FieldByName('MATRICULA_N').AsString:10,
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

              closeFile(f1);
              TableVehic.Close;
              AssignFile(f1,'c:\argentin\envio\ente\defect.dat');
              rewrite(f1);
              TableDefect.Open;
              TableDefect.First;
              while not TableDefect.EOF do
                begin
                  writeln(f1,TableDefect.FieldByName('ZONA').AsString:2,
                  TableDefect.FieldByName('ESTACION').AsString:3,
                  TableDefect.FieldByName('EJERCICI').AsString:4,
                  TableDefect.FieldByName('NUMINSPE').AsString:7,
                  TableDefect.FieldByName('SECCION').AsString:2,
                  TableDefect.FieldByName('PUNTOS').AsString:2,
                  TableDefect.FieldByName('CALIFIC').AsString:1);
                  TableDefect.Next;
                end;

              closeFile(f1);
              TableDefect.Close;
              AssignFile(f1,'c:\argentin\envio\ente\client.dat');
              rewrite(f1);
              TableClient.Open;
              TableClient.First;
              while not TableClient.EOF do
                begin
                  writeln(f1,TableClient.FieldByName('TIPODOC').AsString:4,
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
          closeFile(f1);
          TableClient.Close;
          ComprimirArchivos(1);
          MessageDlg('Exportación el ENTE generada correctamente',mtInformation,[mbOK],0);
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
        {IFDEF TRAZAS}
        fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'No se pudo realizar la exportación al ENTE por: %s', [E.message]);
        {END IF}
        MessageDlg('No se pudo realizar la exportación por: ' + E.message,mtInformation,[mbOK],0);
      end;
   end;
end;



procedure DoExportacionEnte;
VAR Sentence:TSQLQuery;
   res:array [1..3] of char;
   ver:array [1..2] of char;
   ClasVeh,ClasClient,cantid,i,j:integer;
   ProcLimpia,ProcLlena:TSQLStoredProc;
   dspTableInspect,dspTableVehic,dspTableDefect,dspTableClient:TDataSetProvider;
   sdsTableInspect,sdsTableVehic,sdsTableDefect,sdsTableClient:TSQLDataSet;
   TableInspect,TableVehic,TableDefect,TableClient:TClientDataSet;
begin
   if not getdates(dateini,datefin) then
    exit;
   res[1]:='A';
   res[2]:='C';
   res[3]:='R';
   ver[1]:='V';
   ver[2]:='R';
   try
     try
      fbusqueda:= TFTmp.create(application);
        try
        Screen.Cursor:=crHourGlass;
          with fbusqueda do
            muestraclock('Exportación','Generando los datos para la Exportación...');
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
                muestraclock('Exportación','Exportando los datos...');

              AssignFile(f1,'c:\argentin\envio\ente\inspec.dat');
              rewrite(f1);
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
              closeFile(f1);
              TableInspect.Close;
              AssignFile(f1,'c:\argentin\envio\ente\vehiculo.dat');
              rewrite(f1);
              TableVehic.Open;
              TableVehic.First;

              while not TableVehic.EOF do
                begin
                  writeln(f1,TableVehic.FieldByName('MATRICULA_N').AsString:10,
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

              closeFile(f1);
              TableVehic.Close;
              AssignFile(f1,'c:\argentin\envio\ente\defect.dat');
              rewrite(f1);
              TableDefect.Open;
              TableDefect.First;
              while not TableDefect.EOF do
                begin
                  writeln(f1,TableDefect.FieldByName('ZONA').AsString:2,
                  TableDefect.FieldByName('ESTACION').AsString:3,
                  TableDefect.FieldByName('EJERCICI').AsString:4,
                  TableDefect.FieldByName('NUMINSPE').AsString:7,
                  TableDefect.FieldByName('SECCION').AsString:2,
                  TableDefect.FieldByName('PUNTOS').AsString:2,
                  TableDefect.FieldByName('CALIFIC').AsString:1);
                  TableDefect.Next;
                end;

              closeFile(f1);
              TableDefect.Close;
              AssignFile(f1,'c:\argentin\envio\ente\client.dat');
              rewrite(f1);
              TableClient.Open;
              TableClient.First;
              while not TableClient.EOF do
                begin
                  writeln(f1,TableClient.FieldByName('TIPODOC').AsString:4,
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
          closeFile(f1);
          TableClient.Close;
          ComprimirArchivos(1);
          MessageDlg('Archivos generados correctamente',mtInformation,[mbOK],0);
          Application.ProcessMessages;
          with TfmControlENTE.Create(Application) do
              try
                Screen.Cursor:=crhourGlass;
                Query1.Active:=true;
                Query1.Close;
                Query1.Open;
                QRLabel1.Caption:='Planta '+fVarios.NombreEstacionCompleto;
                QRLabel8.Caption:=copy(dateini,1,10)+' - '+copy(datefin,1,10);
                Screen.Cursor:=crDefault;
                QuickRep1.Preview;
                Application.ProcessMessages;
              finally
                Free;
                Screen.Cursor:=crDefault;
              end;
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
        {IFDEF TRAZAS}
        fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'No se pudo realizar la exportación al ENTE por: %s', [E.message]);
        {END IF}
        MessageDlg('No se pudo realizar la exportación por: ' + E.message,mtInformation,[mbOK],0);
      end;
   end;
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

procedure DoExportacionEspana;
var TableSpain:TClientDataSet;
    sdsTableSpain:TSQLDataSet;
    dspTableSpain: TDataSetProvider;
    ProcLimpia,ProcLlena:TSQLStoredProc;
begin
     if not getdates(dateini,datefin) then exit;
       try
         try
               fbusqueda:= TFTmp.create(application);
               try
                 with fbusqueda do
                   muestraclock('Exportación','Generando los datos para la Exportación...');
                 Application.ProcessMessages;
                 ProcLimpia:=TSQLStoredProc.Create(application);
                 ProcLimpia.SQLConnection:=mybd;
                 ProcLimpia.StoredProcName:='PQ_EXPORTA.CLEANT_SPAIN';
                 ProcLimpia.Prepared := true;
                 ProcLimpia.ExecProc;

                 ProcLlena:=TSQLstoredProc.Create(application);
                 ProcLlena.SQLConnection:=mybd;
                 ProcLlena.StoredProcName:='PQ_EXPORTA.LISTADO_SPAIN';
                 try
                   ProcLlena.Prepared := true;
                 except
                   ProcLlena.Prepared := true;
                 end;
                 ProcLlena.ParamByName('FECHAFIN').AsString:=copy(datetimetostr(strtodatetime(datefin)+1),1,10);
                 ProcLlena.ParamByName('FECHAINI').AsString:=copy(dateini,1,10);
                 ProcLlena.ExecProc;
                 with fbusqueda do
                   muestraclock('Exportación','Exportando los datos...');
                 AssignFile(f1,'c:\argentin\envio\inspain.dat');
                 rewrite(f1);

                 sdsTableSpain := TSQLDataSet.Create(application);
                 sdsTableSpain.SQLConnection := MyBD;
                 sdsTableSpain.CommandType := ctTable;
                 sdsTableSpain.GetMetadata := false;
                 sdsTableSpain.NoMetadata := true;
                 sdsTableSpain.ParamCheck := false;

                 dspTableSpain := TDataSetProvider.Create(application);
                 dspTableSpain.DataSet := sdsTableSpain;
                 dspTableSpain.Options := [poIncFieldProps,poAllowCommandText];

                 TableSpain:=TClientDataSet.Create(application);
                 TableSpain.SetProvider(dspTableSpain);
                 TableSpain.CommandText:='T_SPAIN_INSPECT';

                 TableSpain.Open;
                 TableSpain.First;
                 while not TableSpain.EOF do begin
                   writeln(f1,TableSpain.FieldByName('ZONA').AsString:3,
                     TableSpain.FieldByName('ESTACION').AsString:4,
                     TableSpain.FieldByName('TIPOINSP').AsString:1,
                     TableSpain.FieldByName('NUMINSPE').AsString:7,
                     TableSpain.FieldByName('REVERIFI').AsString:1,
                     TableSpain.FieldByName('CLASIFIC').AsString:6,
                     TableSpain.FieldByName('FECHA').AsString:8,
                     TableSpain.FieldByName('HORA').AsString:8,
                     TableSpain.FieldByName('FECVENCI').AsString:8,
                     TableSpain.FieldByName('IMPONETO').AsFloat:12:2,
                     TableSpain.FieldByName('RESULTAD').AsString:1,
                     TableSpain.FieldByName('IVA').AsFloat:12:2);
                   TableSpain.Next;
                 end;
                 closeFile(f1);
                 TableSpain.Close;
                 ComprimirArchivos(2);
               finally
                 fbusqueda.close;
                 fbusqueda.free;
               end;
               MessageDlg('Archivos generados correctamente',mtInformation,[mbOK],0);
         finally
               ProcLimpia.Free;
               ProcLlena.Free;
               TableSpain.Free;
               dspTableSpain.Free;
               sdsTableSpain.Free;
         end;
       except
         on E: Exception do
         begin
          {IFDEF TRAZAS}
          fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'No se pudo realizar la exportación a Espana por: %s', [E.message]);
          {END IF}
          MessageDlg('No se pudo realizar la exportación por: ' + E.message,mtInformation,[mbOK],0);
         end;
       end;
end;

procedure DoExportacionEnteObleas;
var s,matricula:string;
    zona,estacion:integer;
    sdsObleasInut,sdsObleasAnul:TSQLDataSet;
    dspObleasInut,dspObleasAnul:TDataSetProvider;
    ObleasInut,ObleasAnul:TClientDataSet;
begin
    if not getdates(dateini,datefin) then exit;
      try
             try
               fbusqueda:= TFTmp.create(application);
               try
                 with fbusqueda do
                   muestraclock('Exportación','Generando los datos para la Exportación...');

                 Application.ProcessMessages;
                 AssignFile(f1,'c:\argentin\envio\inutiliz.dat');
                 rewrite(f1);

                 with TSQLQuery.Create(application) do
                     try
                        SQLConnection:=mybd;
                        SQL.Add('SELECT ZONA,ESTACION FROM TVARIOS');
                        Open;
                        zona:=Fields[0].AsInteger;
                        estacion:=Fields[1].AsInteger;
                     finally
                        Close;
                        Free;
                     end;

                 sdsObleasInut := TSQLDataSet.Create(application);
                 sdsObleasInut.SQLConnection := MyBD;
                 sdsObleasInut.CommandType := ctTable;
                 sdsObleasInut.GetMetadata := false;
                 sdsObleasInut.NoMetadata := true;
                 sdsObleasInut.ParamCheck := false;

                 dspObleasInut := TDataSetProvider.Create(application);
                 dspObleasInut.DataSet := sdsObleasInut;
                 dspObleasInut.Options := [poIncFieldProps,poAllowCommandText];

                 ObleasInut:=TClientDataSet.Create(application);
                 ObleasInut.SetProvider(dspObleasInut);
                 ObleasInut.CommandText:='T_ERVTV_INUTILIZ';

                 sdsObleasAnul := TSQLDataSet.Create(application);
                 sdsObleasAnul.SQLConnection := MyBD;
                 sdsObleasAnul.CommandType := ctTable;
                 sdsObleasAnul.GetMetadata := false;
                 sdsObleasAnul.NoMetadata := true;
                 sdsObleasAnul.ParamCheck := false;

                 dspObleasAnul := TDataSetProvider.Create(application);
                 dspObleasAnul.DataSet := sdsObleasAnul;
                 dspObleasAnul.Options := [poIncFieldProps,poAllowCommandText];

                 ObleasAnul:=TClientDataSet.Create(application);
                 ObleasAnul.SetProvider(dspObleasAnul);
                 ObleasAnul.CommandText:='T_ERVTV_ANULAC';

                 ObleasInut.Open;
                 ObleasInut.First;

                 while not ObleasInut.EOF do
                 begin
                     if (strtodatetime(dateini)<=StrToDate(ObleasInut.FieldByName('FECHA').AsString))
                     and (strtodatetime(datefin)>=StrToDate(ObleasInut.FieldByName('FECHA').AsString)) then begin
                        s:=Copy(ObleasInut.Fields[1].AsString,1,2)+Copy(ObleasInut.Fields[1].AsString,4,2)+Copy(ObleasInut.Fields[1].AsString,7,4);
                        if not ObleasInut.FieldByName('CODVEHIC').IsNull then
                           with TSQLQuery.Create(application) do
                              try
                                 SQLConnection:=mybd;
                                 SQL.Add('SELECT NVL(PATENTEN,PATENTEA) FROM TVEHICULOS WHERE CODVEHIC=:VEHIC');
                                 ParamByName('VEHIC').AsInteger:=ObleasInut.FieldByName('CODVEHIC').AsInteger;
                                 Open;
                                 if not IsEmpty then matricula:=Fields[0].AsString;
                              finally
                                 Close;
                                 Free;
                              end;
                        if (matricula='') or (matricula=' ') then
                           matricula:=ObtenerPatente(ObleasInut.FieldByName('OBLEAANT').AsString,ObleasInut.FieldByName('OBLEANUEV').AsString);
                        writeln(f1,zona:2,estacion:3,matricula:10,s:8,
                          ObleasInut.FieldByName('OBLEAANT').AsString:9,
                          ObleasInut.FieldByName('OBLEANUEV').AsString:9,
                          ObleasInut.FieldByName('MOTIVO').AsString:50);
                     end;
                     ObleasInut.Next;
                 end;
                 CloseFile(f1);
                 ObleasInut.Close;
                 AssignFile(f1,'c:\argentin\envio\anulac.dat');
                 rewrite(f1);
                 ObleasAnul.Open;
                 ObleasAnul.First;
                 while not ObleasAnul.EOF do begin
                     if (strtodatetime(dateini)<=StrToDate(ObleasAnul.FieldByName('FECHA').AsString))
                     and (strtodatetime(datefin)>=StrToDate(ObleasAnul.FieldByName('FECHA').AsString)) then begin
                        s:=Copy(ObleasAnul.FieldByName('FECHA').AsString,1,2)+Copy(ObleasAnul.FieldByName('FECHA').AsString,4,2)+Copy(ObleasAnul.FieldByName('FECHA').AsString,7,4);
                        writeln(f1,zona:2,estacion:3,s:8,
                          ObleasAnul.FieldByName('NUMOBLEA').AsString:9,
                          ObleasAnul.FieldByName('MOTIVO').AsString:50);
                     end;
                     ObleasAnul.Next;
                 end;
                 CloseFile(f1);
                 ObleasAnul.Close;
                 ComprimirArchivos(3);
               finally
                 fbusqueda.close;
                 fbusqueda.free;
               end;
                  MessageDlg('Archivos generados correctamente',mtInformation,[mbOK],0);
               finally
                  ObleasInut.Free;
                  ObleasAnul.Free;
                  dspObleasAnul.Free;
                  dspObleasInut.Free;
                  sdsObleasAnul.Free;
                  sdsObleasInut.Free;
               end;
       except
         on E: Exception do
         begin
          {IFDEF TRAZAS}
          fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'No se pudo realizar la exportación de Obleas al ENTE por: %s', [E.message]);
          {END IF}
          MessageDlg('No se pudo realizar la exportación por: ' + E.message,mtInformation,[mbOK],0);
         end;
       end;

end;

procedure DoExportacionAnexo;
var zona,estacion:integer;
    sdsTraeDatos:TSQLDataSet;
    dspTraeDatos:TDataSetProvider;
    TraeDatos:TClientDataSet;
    ProcLimpia,ProcLlena:TSQLStoredProc;
    fSQL : TStringList;
begin
      if not getdates(dateini,datefin) then exit;
        try
               try
               fbusqueda:= TFTmp.create(application);
               try
                 with fbusqueda do
                   muestraclock('Exportación','Generando los datos para la Exportación...');
                  Application.ProcessMessages;
                  AssignFile(f1,'c:\argentin\envio\anexo.dat');
                  rewrite(f1);

                  sdsTraeDatos := TSQLDataSet.Create(application);
                  sdsTraeDatos.SQLConnection := MyBD;
                  sdsTraeDatos.CommandType := ctQuery;
                  sdsTraeDatos.GetMetadata := false;
                  sdsTraeDatos.NoMetadata := true;
                  sdsTraeDatos.ParamCheck := false;                  
                  
                  dspTraeDatos := TDataSetProvider.Create(application);
                  dspTraeDatos.DataSet := sdsTraeDatos;
                  dspTraeDatos.Options := [poIncFieldProps,poAllowCommandText];
                  TraeDatos:=TClientDataSet.Create(application);
                  TraeDatos.SetProvider(dspTraeDatos);
                  TraeDatos.CommandText:='SELECT ZONA,ESTACION FROM TVARIOS';
                  TraeDatos.Open;
                  zona:=TraeDatos.Fields[0].AsInteger;
                  estacion:=TraeDatos.Fields[1].AsInteger;

                  ProcLimpia:=TSQLStoredProc.Create(application);
                  ProcLimpia.SQLConnection:=mybd;
                  ProcLimpia.StoredProcName:='PQ_EXPORTA.CLEANT_ERVTV';
                  ProcLimpia.Prepared := true;
                  ProcLimpia.ExecProc;
                  ProcLlena:=TSQLStoredProc.Create(application);
                  ProcLlena.SQLConnection:=mybd;
                  ProcLlena.StoredProcName:='PQ_EXPORTA.LISTADO_ERVTV_INSPEC';
                  try
                    ProcLlena.Prepared := true;
                  except
                    ProcLlena.Prepared := true;
                  end;
                  ProcLlena.ParamByName('FECHAFIN').AsString:=copy(datetimetostr(strtodatetime(datefin)+1),1,10);
                  ProcLlena.ParamByName('FECHAINI').AsString:=copy(dateini,1,10);
                  ProcLlena.ExecProc;
                  ProcLimpia.Free;
                  ProcLlena.Free;
                  TraeDatos.Close;
                  TraeDatos.CommandText := 'DELETE FROM TEMPTAB';
                  TraeDatos.SetProvider(dspTraeDatos);
                  TraeDatos.Execute;
                  TraeDatos.Close;
                  fSQL := TStringList.Create;
                  fSQL.Add('SELECT DISTINCT(I.NUMINSPE),V.MATRICULA_N,V.MATRICULA_A,V.FECHAMAT,');
                  fSQL.Add('V.MARCA,V.MODELO,V.ANIOFABR,C.TIPODOC,C.NUMDOCU,');
                  fSQL.Add('C.NOMBRE,C.APELLID1,C.APELLID2,C.DIRECCIO,C.CODPOSTA,');
                  fSQL.Add('SUBSTR(C.TELEFONO,1,15),SUBSTR(C.LOCALIDA,1,30),C.PARTIDO,I.FECHAVER,');
                  fSQL.Add('I.REVERIFI,I.FECHAVENC,I.NUMOBLEA,I.RESULTAD FROM  ');
                  fSQL.Add('T_ERVTV_INSPECT I,T_ERVTV_VEHICULOS V,T_ERVTV_CLIENTES C  ');
                  fSQL.Add('WHERE I.TIPODOC=C.TIPODOC AND I.NUMDOCU=C.NUMDOCU AND  ');
                  fSQL.Add('(I.MATRICULA=V.MATRICULA_N OR ');
                  fSQL.Add('I.MATRICULA=V.MATRICULA_A)');
                  TraeDatos.CommandText := fSQL.Text;
                  TraeDatos.Open;
                  TraeDatos.First;
                  while not TraeDatos.EOF do begin
                     writeln(f1,zona:2,estacion:3,TraeDatos.Fields[1].AsString:10,TraeDatos.Fields[2].AsString:10,
                             TraeDatos.Fields[3].AsString:8,TraeDatos.Fields[4].AsString:12,
                             TraeDatos.Fields[5].AsString:12,TraeDatos.Fields[6].AsString:4,
                             TraeDatos.Fields[7].AsString:4,TraeDatos.Fields[8].AsString:13,
                             TraeDatos.Fields[9].AsString:30,TraeDatos.Fields[10].AsString:50,
                             TraeDatos.Fields[11].AsString:50,TraeDatos.Fields[12].AsString:50,
                             TraeDatos.Fields[13].AsString:5,TraeDatos.Fields[14].AsString:15,
                             TraeDatos.Fields[15].AsString:30,TraeDatos.Fields[16].AsString:3,
                             TraeDatos.Fields[0].AsString:7,TraeDatos.Fields[17].AsString:8,
                             TraeDatos.Fields[18].AsString:1,TraeDatos.Fields[19].AsString:8,
                             TraeDatos.Fields[20].AsString:9,TraeDatos.Fields[21].AsString:1);
                     TraeDatos.Next;
                  end;
                  CloseFile(f1);
                  ComprimirArchivos(4);
               finally
                 fbusqueda.close;
                 fbusqueda.free;
               end;
                  MessageDlg('Archivos generados correctamente',mtInformation,[mbOK],0);
               finally
                 TraeDatos.free;
               end;
       except
         on E: Exception do
         begin
          {IFDEF TRAZAS}
          fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'No se pudo realizar la exportación de Anexo por: %s', [E.message]);
          {END IF}
          MessageDlg('No se pudo realizar la exportación por: ' + E.message,mtInformation,[mbOK],0);
         end;
       end;
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
   NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
   codtaller := fVarios.codtaller;
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

procedure DoExportacionGNC;
var TraeDatos:TClientDataset;
    sdsTraeDatos : TSQLDataSet;
    dspTraeDatos : TDataSetProvider;
    ProcLlena:TSQLStoredProc;
    nombrefec: string;
    fSQL : TStringList;
begin
      if not getdates(dateini,datefin) then exit;
        try
               try
               fbusqueda:= TFTmp.create(application);
               try
                 with fbusqueda do
                  muestraclock('Exportación','Generando los datos para la Exportación GNC...');
                  Application.ProcessMessages;
                  nombrefec := inttostr(extractyear(strtodate(copy(datefin,1,10))))+formatoceros(extractmonth(strtodate(copy(datefin,1,10))),2)+formatoceros(extractday(strtodate(copy(datefin,1,10))),2);

                  sdsTraeDatos := TSQLDataSet.Create(application);
                  sdsTraeDatos.SQLConnection := MyBD;
                  sdsTraeDatos.CommandType := ctQuery;
                  sdsTraeDatos.GetMetadata := false;
                  sdsTraeDatos.NoMetadata := true;
                  sdsTraeDatos.ParamCheck := false;
                  dspTraeDatos := TDataSetProvider.Create(application);
                  dspTraeDatos.DataSet := sdsTraeDatos;
                  dspTraeDatos.Options := [poIncFieldProps,poAllowCommandText];
                  TraeDatos:=TClientDataSet.Create(application);
                  TraeDatos.SetProvider(dspTraeDatos);

                  DeleteTable(MyBD, 'TTMP_ENARGAS_FICHA');
                  DeleteTable(MyBD, 'TTMP_ENARGAS_CILINDROS');
                  DeleteTable(MyBD, 'TTMP_ENARGAS_REGULADORES');
                  ProcLlena:=TSQLStoredProc.Create(application);
                  ProcLlena.SQLConnection:=mybd;
                  ProcLlena.StoredProcName:='PQ_EXPORTA.EXPORTA_ENARGAS';
                  try
                    ProcLlena.Prepared := true;
                  except
                    ProcLlena.Prepared := true;
                  end;
                  ProcLlena.ParamByName('FECHAFIN').AsString:=copy(datetimetostr(strtodatetime(datefin)+1),1,10);
                  ProcLlena.ParamByName('FECHAINI').AsString:=copy(dateini,1,10);
                  ProcLlena.ExecProc;
                  ProcLlena.Free;

                  fSQL := TStringList.Create;
                  fSQL.Add('SELECT CODTALLER,NRO_OPERACION,CODIGO,NRO_SERIE,NUEVO,MES_FABRI,ANIO_FABRI,MES_REVI,ANIO_REVI,');
                  fSQL.Add('CRPC,SITUACION FROM TTMP_ENARGAS_CILINDROS ORDER BY NRO_OPERACION');
                  TraeDatos.CommandText := fSQL.Text;
                  try
                    AssignFile(f1,'c:\argentin\envio\GNC_Enargas\cil'+nombrefec+'.txt');
                    rewrite(f1);
                    TraeDatos.Open;
                    TraeDatos.First;
                    while not TraeDatos.EOF do begin
                      writeln(f1,TraeDatos.Fields[0].asstring,SEP_GNC,TraeDatos.Fields[1].asstring,SEP_GNC,TraeDatos.Fields[2].AsString,SEP_GNC,TraeDatos.Fields[3].AsString,SEP_GNC,
                             TraeDatos.Fields[4].AsString,SEP_GNC,TraeDatos.Fields[5].AsString,SEP_GNC,TraeDatos.Fields[6].AsString,SEP_GNC,TraeDatos.Fields[7].AsString,SEP_GNC,
                             TraeDatos.Fields[8].AsString,SEP_GNC,TraeDatos.Fields[9].AsString,SEP_GNC,TraeDatos.Fields[10].AsString);
                      TraeDatos.Next;
                    end;
                    CloseFile(f1);

                    AssignFile(f1,'c:\argentin\envio\GNC_Enargas\reg'+nombrefec+'.txt');
                    rewrite(f1);
                    TraeDatos.close;
                    fsql.Clear;
                    fsql.Add('SELECT CODTALLER,NRO_OPERACION,CODIGO,NRO_SERIE,NUEVO,OPERACION ');
                    fsql.Add('FROM TTMP_ENARGAS_REGULADORES ORDER BY NRO_OPERACION');
                    TraeDatos.CommandText := fSQL.Text;
                    TraeDatos.SetProvider(dspTraeDatos);
                    TraeDatos.Open;
                    TraeDatos.First;
                    while not TraeDatos.EOF do begin
                       writeln(f1,TraeDatos.Fields[0].asstring,SEP_GNC,TraeDatos.Fields[1].asstring,SEP_GNC,TraeDatos.Fields[2].AsString,SEP_GNC,TraeDatos.Fields[3].AsString,SEP_GNC,
                             TraeDatos.Fields[4].AsString,SEP_GNC,TraeDatos.Fields[5].AsString);
                       TraeDatos.Next;
                    end;
                    closeFile(f1);

                    AssignFile(f1,'c:\argentin\envio\GNC_Enargas\ft'+nombrefec+'.txt');
                    rewrite(f1);

                    TraeDatos.close;
                    fsql.Clear;
                    fsql.Add('SELECT CODTALLER,NRO_OPERACION,SUBSTR(TO_CHAR(FECHA_HAB,''DD/MM/YYYY''),1,10),SUBSTR(TO_CHAR(FECHA_VENC,''DD/MM/YYYY''),1,10),OBLEA_ANT,OBLEA_NUEVA,MARCA,MODELO, ');
                    fsql.Add('ANIO_FAB,DOMINIO,INYECCION,TIPOVEH,TIPO_OPERA,APELLIDO,NOMBRE,TIPO_DOC,NRO_DOC, ');
                    fsql.Add('TELEFONO,CALLE,NRO,PISO,DEPTO,CPA,LOCALIDAD,OBSERV,PCIA,TIPOPERA ');
                    fsql.Add('FROM TTMP_ENARGAS_FICHA ORDER BY FECHA_HAB, NRO_OPERACION');
                    TraeDatos.CommandText := fSQL.Text;
                    TraeDatos.SetProvider(dspTraeDatos);
                    TraeDatos.Open;
                    TraeDatos.First;
                    while not TraeDatos.EOF do begin
                       writeln(f1,TraeDatos.Fields[0].asstring,SEP_GNC,TraeDatos.Fields[1].asstring,SEP_GNC,TraeDatos.Fields[26].asstring,SEP_GNC,TraeDatos.Fields[2].AsString,SEP_GNC,TraeDatos.Fields[3].AsString,SEP_GNC,
                             TraeDatos.Fields[4].AsString,SEP_GNC,TraeDatos.Fields[5].AsString,SEP_GNC,TraeDatos.Fields[6].AsString,SEP_GNC,TraeDatos.Fields[7].AsString,SEP_GNC,
                             TraeDatos.Fields[8].AsString,SEP_GNC,TraeDatos.Fields[9].AsString,SEP_GNC,TraeDatos.Fields[10].AsString,SEP_GNC,TraeDatos.Fields[11].AsString,SEP_GNC,
                             TraeDatos.Fields[12].AsString,SEP_GNC,TraeDatos.Fields[13].AsString,SEP_GNC,TraeDatos.Fields[14].AsString,SEP_GNC,TraeDatos.Fields[15].AsString,SEP_GNC,
                             TraeDatos.Fields[16].AsString,SEP_GNC,TraeDatos.Fields[17].AsString,SEP_GNC,TraeDatos.Fields[18].AsString,SEP_GNC,TraeDatos.Fields[19].AsString,SEP_GNC,
                             TraeDatos.Fields[20].AsString,SEP_GNC,TraeDatos.Fields[21].AsString,SEP_GNC,TraeDatos.Fields[22].AsString,SEP_GNC,TraeDatos.Fields[23].AsString,SEP_GNC,
                             TraeDatos.Fields[24].AsString,SEP_GNC,TraeDatos.Fields[25].AsString);
                       TraeDatos.Next;
                    end;
                    closeFile(f1);
               finally
                 try
                    closeFile(f1);
                 except
                 end;
               end;
                  ComprimirArchivos(5);
               finally
                 fbusqueda.close;
                 fbusqueda.free;
               end;
                  MessageDlg('Archivos generados correctamente',mtInformation,[mbOK],0);
               finally
                 TraeDatos.free;
                 dspTraeDatos.Free;
                 sdsTraeDatos.Free;
               end;
       except
         on E: Exception do
         begin
          {IFDEF TRAZAS}
          fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'No se pudo realizar la exportación de GNC por: %s', [E.message]);
          {END IF}
          MessageDlg('No se pudo realizar la exportación por: ' + E.message,mtInformation,[mbOK],0);
         end;
       end;
end;

procedure DoExportacionCDiarioGNC(aq: tClientDataset; fechini, fechfin:string);
var NumeroEstacion, nombrefec, cantanul:string;
    zona,estacion:integer;
    aObleas: TClientDataSet;
    sdsaObleas: TSQLDataSet;
    dspaObleas: TDataSetProvider;
begin

    dateini := fechini;
    datefin := fechfin;

    if copy(dateini,1,10) <> copy (datefin,1,10) then
    begin
      MessageDlg('La exportación no se puede realizar porque la fecha de inicio y fin son diferentes',mtError,[mbOK],0);
      exit;
    end;
      try
             try
               fbusqueda:= TFTmp.create(application);
               try
                 with fbusqueda do
                   muestraclock('Exportación','Generando los datos para la Exportación...');

                 Application.ProcessMessages;
                 cantanul := '0';
                 with TSQLQuery.Create(application) do
                     try
                        SQLConnection:=mybd;
                        SQL.Add('SELECT ZONA,ESTACION FROM TVARIOS');
                        Open;
                        zona:=Fields[0].AsInteger;
                        estacion:=Fields[1].AsInteger;
                        close;
                        sql.clear;
                        sql.add('alter session set nls_date_format = ''dd/mm/yyyy hh24:mi:ss''');
                        execsql;
                        close;
                        sql.Clear;
                        sql.Add(format('select count(*) from anuladas_gnc where fecha >= ''%s'' and fecha <=''%s''',[dateini, datefin]));
                        open;
                        cantanul := fields[0].asstring;
                     finally
                        Close;
                        Free;
                     end;

                 NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
                 nombrefec := inttostr(extractyear(strtodate(copy(datefin,1,10))))+formatoceros(extractmonth(strtodate(copy(datefin,1,10))),2)+formatoceros(extractday(strtodate(copy(datefin,1,10))),2);

                 AssignFile(f1,'c:\argentin\envio\GNC_Enargas\CG'+NumeroEstacion+nombrefec+'.dat');
                 rewrite(f1);

                 AssignFile(f2,'c:\argentin\envio\GNC_Enargas\OB'+NumeroEstacion+nombrefec+'.dat');
                 rewrite(f2);


                 aQ.Open;
                 aQ.First;
                 while not aQ.EOF do
                 begin
                        writeln(f1,zona:2,estacion:2,copy(dateini,1,10):10,
                          aQ.fieldbyname(FIELD_CANTAPTAS).asstring:6,aQ.fieldbyname(FIELD_CANTRECH).asstring:6,
                          aQ.fieldbyname(FIELD_COBLEASACT).asstring:6,aQ.fieldbyname(FIELD_MINOBLEACT).asstring:11,aQ.fieldbyname(FIELD_MAXOBLEACT).asstring:11,
                          aQ.fieldbyname(FIELD_COBLEASIG).asstring:6,aQ.fieldbyname(FIELD_MINOBLEASIG).asstring:11,aQ.fieldbyname(FIELD_MAXOBLEASIG).asstring:11,
                          cantanul:6);
                        aQ.Next;
                 end;
                 CloseFile(f1);

                 sdsaObleas := TSQLDataSet.Create(application);
                 sdsaObleas.SQLConnection := MyBD;
                 sdsaObleas.CommandType := ctQuery;
                 sdsaObleas.GetMetadata := false;
                 sdsaObleas.NoMetadata := true;
                 sdsaObleas.ParamCheck := false;

                 dspaObleas := TDataSetProvider.Create(application);
                 dspaObleas.DataSet := sdsaObleas;
                 dspaObleas.Options := [poIncFieldProps,poAllowCommandText];
                 aObleas:=TClientDataSet.Create(application);
                 aObleas.SetProvider(dspaObleas);

                 with aObleas do
                 begin
                   CommandText:='SELECT TO_CHAR(FECHALTA,''DD/MM/YYYY'') FECHALTA, NUMOBLEA, PROCEDENCIA, CODINSPE, EJERCICI FROM TTMPOBLEAS';
                   Open;
                   First;
                   while not EOF do begin
                     writeln(f2,zona:2,estacion:2,fieldbyname(FIELD_FECHALTA).asstring:10,
                          fieldbyname(FIELD_NUMOBLEA).asstring:9,fieldbyname(FIELD_PROCEDENCIA).asstring:1,
                          fieldbyname(FIELD_EJERCICI).asstring:4,fieldbyname(FIELD_CODINSPE).asstring:LENGTH(fieldbyname(FIELD_CODINSPE).asstring));
                     Next;
                   end;
                 end;
                 CloseFile(f2);
                 ComprimirArchivos(9);
               finally
                 fbusqueda.close;
                 fbusqueda.free;
               end;
                  MessageDlg('Archivos generados correctamente',mtInformation,[mbOK],0);
               finally
                  try
                    CloseFile(f1);
                    CloseFile(f2);
                  except
                  end;
               end;
       except
         on E: Exception do
         begin
          {IFDEF TRAZAS}
          fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'No se pudo realizar la exportación de Obleas al ENTE por: %s', [E.message]);
          {END IF}
          MessageDlg('No se pudo realizar la exportación por: ' + E.message,mtInformation,[mbOK],0);
         end;
       end;
end;

procedure DoExportacionCDiarioVTV(fechini, fechfin: string);
var NumeroEstacion, nombrefec, cantanul, cantinu:string;
    zona,estacion:integer;
    ProcLlena : TSQLStoredProc;
    aQ : TClientDataSet;
    sdsaQ : TSQLDataSet;
    dspaQ : TDataSetProvider;
begin
    dateini := fechini;
    datefin := fechfin;

    if copy(dateini,1,10) <> copy (datefin,1,10) then
    begin
      MessageDlg('La exportación no se puede realizar porque la fecha de inicio y fin son diferentes',mtError,[mbOK],0);
      exit;
    end;
      try
             try
               fbusqueda:= TFTmp.create(application);
               try
                 with fbusqueda do
                   muestraclock('Exportación','Generando los datos para la Exportación...');

                 Application.ProcessMessages;
                 cantanul := '0';
                 with TSQLQuery.Create(application) do
                     try
                        SQLConnection:=mybd;
                        SQL.Add('SELECT ZONA,ESTACION FROM TVARIOS');
                        Open;
                        zona:=Fields[0].AsInteger;
                        estacion:=Fields[1].AsInteger;
                        close;
                        sql.clear;
                        sql.add('alter session set nls_date_format = ''dd/mm/yyyy hh24:mi:ss''');
                        execsql;
                        close;
                        sql.Clear;
                        sql.Add(format('select count(*) from t_ervtv_anulac where fecha >= ''%s'' and fecha <=''%s''',[dateini, datefin]));
                        open;
                        cantanul := fields[0].asstring;
                        close;
                        sql.Clear;
                        sql.Add(format('select count(*) from t_ervtv_inutiliz where fecha >= ''%s'' and fecha <=''%s''',[dateini, datefin]));
                        open;
                        cantinu := fields[0].asstring;
                     finally
                        Close;
                        Free;
                     end;

                 NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
                 nombrefec := inttostr(extractyear(strtodate(copy(datefin,1,10))))+formatoceros(extractmonth(strtodate(copy(datefin,1,10))),2)+formatoceros(extractday(strtodate(copy(datefin,1,10))),2);

                 AssignFile(f1,'c:\argentin\envio\VTV\CD'+NumeroEstacion+nombrefec+'.dat');
                 rewrite(f1);
                 AssignFile(f2,'c:\argentin\envio\VTV\OB'+NumeroEstacion+nombrefec+'.dat');
                 rewrite(f2);


                 DeleteTable(MyBD, 'TTMPCDVTV');
                 DeleteTable(MyBD, 'TTMPOBLEAS');

                 ProcLlena:=TSQLStoredProc.Create(application);
                 ProcLlena.SQLConnection:=mybd;
                 ProcLlena.StoredProcName:='PQ_CDVTV.DOCDVTV';
                 try
                    ProcLlena.Prepared := true;
                 except
                    ProcLlena.Prepared := true;
                 end;
                 ProcLlena.ParamByName('FF').AsString:=datefin;
                 ProcLlena.ParamByName('FI').AsString:=dateini;
                 ProcLlena.ExecProc;
                 ProcLlena.Free;


                 sdsaQ := TSQLDataSet.Create(application);
                 sdsaQ.SQLConnection := MyBD;
                 sdsaQ.CommandType := ctQuery;
                 sdsaQ.GetMetadata := false;
                 sdsaQ.NoMetadata := true;
                 sdsaQ.ParamCheck := false;

                 dspaQ := TDataSetProvider.Create(application);
                 dspaQ.DataSet := sdsaQ;
                 dspaQ.Options := [poIncFieldProps,poAllowCommandText];
                 aQ:=TClientDataSet.Create(application);
                 aQ.SetProvider(dspaQ);

                 with aq do
                 begin
                   CommandText := 'SELECT TO_CHAR(FECHALTA,''DD/MM/YYYY'') FECHALTA, CANTAPRV, CANTCONV, CANTRECV, CANTAPRR, CANTCONR, CANTRECR, CANTANULADAS, CANTINUTIL FROM TTMPCDVTV';
                 end;

                 aQ.Open;
                 aQ.First;
                 while not aQ.EOF do begin

                        writeln(f1,zona:2,estacion:2,aQ.fieldbyname(FIELD_FECHALTA).asstring:10,
                          aQ.fieldbyname(FIELD_CANTAPRV).asstring:6,aQ.fieldbyname(FIELD_CANTCONV).asstring:6,
                          aQ.fieldbyname(FIELD_CANTRECV).asstring:6,aQ.fieldbyname(FIELD_CANTAPRR).asstring:6,aQ.fieldbyname(FIELD_CANTCONR).asstring:6,
                          aQ.fieldbyname(FIELD_CANTRECR).asstring:6,aQ.fieldbyname(FIELD_CANTANULADAS).asstring:6,aQ.fieldbyname(FIELD_CANTINUTIL).asstring:6);
                     aQ.Next;
                 end;
                 CloseFile(f1);
                 with aq do
                 begin
                   close;
                   CommandText := 'SELECT TO_CHAR(FECHALTA,''DD/MM/YYYY'') FECHALTA, NUMOBLEA, PROCEDENCIA, CODINSPE, EJERCICI FROM TTMPOBLEAS';
                   SetProvider(dspaQ);
                 end;
                 aQ.Open;
                 aQ.First;
                 while not aQ.EOF do begin
                        writeln(f2,zona:2,estacion:2,aQ.fieldbyname(FIELD_FECHALTA).asstring:10,
                          aQ.fieldbyname(FIELD_NUMOBLEA).asstring:9,aQ.fieldbyname(FIELD_PROCEDENCIA).asstring:1,
                          aQ.fieldbyname(FIELD_EJERCICI).asstring:4,aQ.fieldbyname(FIELD_CODINSPE).asstring:LENGTH(aQ.fieldbyname(FIELD_CODINSPE).asstring));
                     aQ.Next;
                 end;
                 CloseFile(f2);
                 ComprimirArchivos(8);

               finally
                 fbusqueda.close;
                 fbusqueda.free;
               end;
                  MessageDlg('Archivos generados correctamente',mtInformation,[mbOK],0);
               finally
                  try
                   // CloseFile(f1);
                   // closeFile(f2);
                    aQ.Free;
                    dspaQ.Free;
                    sdsaQ.Free;
                  except
                  end;
               end;
       except
         on E: Exception do
         begin
          {IFDEF TRAZAS}
          fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'No se pudo realizar la exportación de Obleas al ENTE por: %s', [E.message]);
          {END IF}
          MessageDlg('No se pudo realizar la exportación por: ' + E.message,mtInformation,[mbOK],0);
         end;
       end;
end;

procedure DoExportacionProvSeguros;
var TraeDatos:TClientDataSet;
    sdsTraedatos : TSQLDataSet;
    dspTraedatos : TDataSetProvider;
    ProcLlena:TSQLStoredProc;
    numeroestacion, nombrefec: string;
    fSQL : tstringlist;
begin
      if not getdates(dateini,datefin) then exit;
        try
           try
               try
               fbusqueda:= TFTmp.create(application);
               try
                 with fbusqueda do
                   muestraclock('Exportación','Generando los datos para la Exportación...');
                  Application.ProcessMessages;

                  sdsTraedatos := TSQLDataSet.Create(application);
                  sdsTraedatos.SQLConnection := MyBD;
                  sdsTraedatos.CommandType := ctQuery;

                  sdsTraedatos.GetMetadata := false;
                  sdsTraedatos.NoMetadata := true;
                  sdsTraedatos.ParamCheck := false;

                  dspTraedatos := TDataSetProvider.Create(application);
                  dspTraedatos.DataSet := sdsTraedatos;
                  dspTraedatos.Options := [poIncFieldProps,poAllowCommandText];
                  TraeDatos :=TClientDataSet.Create(Application);

                  TraeDatos.SetProvider(dspTraedatos);

                  NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
                  nombrefec := inttostr(extractyear(strtodate(copy(datefin,1,10))))+formatoceros(extractmonth(strtodate(copy(datefin,1,10))),2)+formatoceros(extractday(strtodate(copy(datefin,1,10))),2);

                  AssignFile(f1,'c:\argentin\envio\provincia\prov'+NumeroEstacion+nombrefec+'.dat');
                  rewrite(f1);

                  TraeDatos.CommandText := 'ALTER SESSION SET NLS_DATE_FORMAT = ''DD/MM/YYYY HH24:MI:SS''';
                  TraeDatos.Execute;
                  TraeDatos.Close;
                  DeleteTable(MyBD, 'TTMPEXP_PROVINCIA');
                  ProcLlena:=TSQLStoredProc.Create(application);
                  ProcLlena.SQLConnection:=mybd;
                  ProcLlena.StoredProcName:='PQ_EXPORTA.DOEXPORTA_PROVINCIA';
                  try
                    ProcLlena.Prepared := true;
                  except
                    ProcLlena.Prepared := true;
                  end;
                  ProcLlena.ParamByName('FECHAFIN').AsString:=datefin;
                  ProcLlena.ParamByName('FECHAINI').AsString:=dateini;
                  ProcLlena.ExecProc;
                  ProcLlena.Free;
                  TraeDatos.Close;

                  fSQL := TStringList.Create;

                  fSQL.Add('SELECT ZONA, ESTACION, CODINSPE, PATENTE, ');
                  fSQL.Add('MOTOR, CHASIS, ANO, MARCA, MODELO, POLIZA, CERTIFICADO, ');
                  fSQL.Add('ASEGURADO, TIPODOC, NRODOC, SUBSTR(FECHALTA,1,10), TIPOVENTA, SUBSTR(FECHA_ARCHIVO,1,10), ');
                  fSQL.Add('TIPFACTU, IMPONETO, NUMFACTURA, IVAINSCR ');
                  fSQL.Add('FROM TTMPEXP_PROVINCIA ORDER BY ZONA, ESTACION, CODINSPE');
                  traedatos.CommandText := fSQL.Text;

                  TraeDatos.Open;
                  TraeDatos.First;
                  while not TraeDatos.EOF do begin
                     writeln(f1,TraeDatos.Fields[0].AsString:2,TraeDatos.Fields[1].AsString:2,TraeDatos.Fields[2].AsString:6,
                             TraeDatos.Fields[3].AsString:9,TraeDatos.Fields[4].AsString:24,
                             TraeDatos.Fields[5].AsString:24,TraeDatos.Fields[6].AsString:4,
                             TraeDatos.Fields[7].AsString:30,TraeDatos.Fields[8].AsString:30,
                             TraeDatos.Fields[9].AsString:9,TraeDatos.Fields[10].AsString:7,
                             TraeDatos.Fields[11].AsString:80,TraeDatos.Fields[12].AsString:3,
                             TraeDatos.Fields[13].AsString:13,TraeDatos.Fields[14].AsString:10,
                             TraeDatos.Fields[15].AsString:1,TraeDatos.Fields[16].AsString:10,
                             TraeDatos.Fields[17].AsString:1,TraeDatos.Fields[18].AsString:11,
                             TraeDatos.Fields[19].AsString:13,TraeDatos.Fields[20].AsString:7);
                     TraeDatos.Next;
                  end;
                  CloseFile(f1);
                  ComprimirArchivos(7);
               finally
                 fbusqueda.close;
                 fbusqueda.free;
               end;
                  MessageDlg('Archivos generados correctamente',mtInformation,[mbOK],0);
               finally
                 TraeDatos.free;
               end;
           finally
             try
               CloseFile(f1)
             except
             end;
           end;
       except
         on E: Exception do
         begin
          {IFDEF TRAZAS}
          fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'No se pudo realizar la exportación de Provincia Seguros por: %s', [E.message]);
          {END IF}
          MessageDlg('No se pudo realizar la exportación por: ' + E.message,mtInformation,[mbOK],0);
         end;
       end;

end;

end.


