unit ufProvSeguros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SpeedBar, ExtCtrls, ucDialgs, StdCtrls, uSagClasses, Globals, uSagEstacion,
  ToolEdit, RXDBCtrl, Mask, DBCtrls, DB, Buttons, uUtils, USUPERREGISTRY,
  uversion,ZipMstr,Provider, SqlExpr, DBClient, DBXpress ;

type
  TfrmProvSeguros = class(TForm)
    SpeedBar1: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    btnImpProv: TSpeedItem;
    btnSalir: TSpeedItem;
    OpenDialog1: TOpenDialog;
    SpeedItem1: TSpeedItem;
    procedure btnSalirClick(Sender: TObject);
    procedure btnImpProvClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedItem1Click(Sender: TObject);
  private
    { Private declarations }
    fInsp_prov : tInsp_Provincia;
    dateini,datefin: string;
    procedure InsertarCD (aDatos: string);
    procedure DoExportacionProvSeguros;
    function Descomprimir(aZipFile : string):boolean;
  public
    { Public declarations }
  end;

  procedure generateProvSeguros;

var
  frmProvSeguros: TfrmProvSeguros;
  f1 : text;

implementation

uses
  UFTMP, Math, DateUtil, ugetdates;

resourcestring
  CAPTION = 'Importación Datos Provincia Seguros';

{$R *.dfm}

procedure generateProvSeguros;
begin
        with TfrmProvSeguros.Create(Application) do
        try
            try
                ShowModal;
            except
                on E: Exception do
                begin
                    FTmp.Temporizar(FALSE,FALSE,'', '');
                    Application.ProcessMessages;
//                    FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
                    MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)
                end
            end
        finally
            Free;
            Application.ProcessMessages;
        end;
end;


procedure TfrmProvSeguros.btnSalirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmProvSeguros.btnImpProvClick(Sender: TObject);
var
  F: TextFile;
  S: string;
begin

  if OpenDialog1.Execute then
  begin
    try

      if not Descomprimir(OpenDialog1.FileName) then exit;

      AssignFile(F, copy(OpenDialog1.FileName,1,Length(OpenDialog1.FileName)-3)+'dat' );
      Reset(F);
      while True do
      begin
        Readln(F, S);
        try
          if S = '' then Break
          else begin
            InsertarCD (s);
          end;
        finally
        end;
      end;
      MessageDlg(CAPTION, 'Registros importados con éxito', mtInformation, [mbOk], mbOk, 0);
      CloseFile(F);
    except
    end;
  end;
end;

procedure TfrmProvSeguros.FormCreate(Sender: TObject);
begin
  fInsp_prov := tInsp_Provincia.CreateByRowId(MYBD,'');
//  fInsp_prov.Open;

end;

procedure TfrmProvSeguros.InsertarCD(aDatos: string);
var ArrayVar: Variant;
    dsp: TDataSetProvider;
    sds: TSQLDataSet;
begin
       if not fInsp_prov.Active then fInsp_prov.Open;
       try
          MYBD.StartTransaction(td);
          sds:=TSQLDataSet.Create(SELF);
          sds.SQLConnection := mybd;
          sds.CommandType := ctQuery;
          sds.GetMetadata := false;
          sds.NoMetadata := true;
          sds.ParamCheck := false;
          dsp := TDataSetProvider.Create(self);
          dsp.DataSet := sds;
          dsp.Options := [poIncFieldProps,poAllowCommandText];

          with TClientDataSet.create(nil) do
            try
              SetProvider(dsp);
              CommandText := format('SELECT * FROM INSP_PROVINCIA WHERE ZONA = %S AND ESTACION = %S AND CODINSPE = %S',[copy(aDatos,1,2),copy(aDatos,3,2),copy(aDatos,5,6)]);
              open;
              if not (recordcount > 0) then
              begin
                fInsp_prov.Append;
                fInsp_prov.ValueByName[FIELD_ZONA] := copy(aDatos,1,2) ;
                fInsp_prov.ValueByName[FIELD_ESTACION] := copy(aDatos,3,2) ;
                fInsp_prov.ValueByName[FIELD_CODINSPE] := copy(aDatos,5,6) ;
                fInsp_prov.ValueByName[FIELD_PATENTE] :=copy(aDatos,11,9) ;
                fInsp_prov.ValueByName[FIELD_MOTOR] :=copy(aDatos,20,24) ;
                fInsp_prov.ValueByName[FIELD_CHASIS]:=copy(aDatos,44,24) ;
                fInsp_prov.ValueByName[FIELD_ANO] := copy(aDatos,68,4);
                fInsp_prov.ValueByName[FIELD_MARCA] := copy(aDatos,72,30);
                fInsp_prov.ValueByName[FIELD_MODELO] := copy(aDatos,102,30);
                fInsp_prov.ValueByName[FIELD_POLIZA] := copy(aDatos,132,9) ;
                fInsp_prov.ValueByName[FIELD_CERTIFICADO] :=copy(aDatos,141,7) ;
                fInsp_prov.ValueByName[FIELD_ASEGURADO] := copy(aDatos,148,80);
                fInsp_prov.ValueByName[FIELD_TIPODOC] := copy(aDatos,228,3);
                fInsp_prov.ValueByName[FIELD_NRODOC] := copy(aDatos,231,13);
                fInsp_prov.ValueByName[FIELD_FECHA] := copy(aDatos,244,10);
                fInsp_prov.ValueByName[FIELD_TIPOVENTA] := copy(aDatos,254,1);
                fInsp_prov.ValueByName[FIELD_FECHA_ARCHIVO] := copy(aDatos,255,10) ;
                fInsp_prov.ValueByName[FIELD_TIPFACTU] := copy(aDatos,265,1) ;
                fInsp_prov.ValueByName[FIELD_IMPONETO] := copy(aDatos,266,11);
                fInsp_prov.ValueByName[FIELD_NUMFACTU] := copy(aDatos,277,13);
                fInsp_prov.ValueByName[FIELD_IVAINSCR] := copy(aDatos,290,7);

                ArrayVar:=VarArrayCreate([0,1],VarVariant);
                ArrayVar[0]:=copy(aDatos,1,2);
                ArrayVar[1]:=copy(aDatos,3,2);
                fInsp_prov.ValueByName[FIELD_IDEMPRESA] := fVarios.ExecuteFunction('GETEMPRESA',ArrayVar);
                fInsp_prov.Post(true);

              end;
            finally
              free;
            end;


          MYBD.Commit(td);
       except
         on E: Exception do
         begin
            MessageDlg(CAPTION,Format('No se ha podido importar los registros por: %s. ',[E.message]), mtError, [mbOk], mbOk, 0);
            MYBD.Rollback(td);
         end;
       end;

end;


procedure TfrmProvSeguros.FormDestroy(Sender: TObject);
begin
  if MYBD.InTransaction then MYBD.Rollback(td);
end;

procedure TfrmProvSeguros.FormKeyPress(Sender: TObject; var Key: Char);
begin
        if key = ^M
        then begin
            Perform(WM_NEXTDLGCTL,0,0);
            Key := #0
        end
end;

procedure TfrmProvSeguros.DoExportacionProvSeguros;
var TraeDatos:TClientDataSet;
    dsp: TDataSetProvider;
    sds: TSQLDataSet;
    ProcLlena:TSQLStoredProc;
    nombrefec: string;
    fBusqueda : tftmp;
    fSQL : TstringList;
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

                  sds:=TSQLDataSet.Create(application);
                  sds.SQLConnection := MyBD;
                  sds.CommandType := ctQuery;
                  sds.GetMetadata := false;
                  sds.NoMetadata := true;
                  sds.ParamCheck := false;
                  dsp := TDataSetProvider.Create(application);
                  dsp.DataSet := sds;
                  dsp.Options := [poIncFieldProps,poAllowCommandText];

                  TraeDatos:=TClientdataset.Create (application);
                  TraeDatos.SetProvider(dsp);

                  nombrefec := inttostr(extractyear(strtodate(copy(datefin,1,10))))+formatoceros(extractmonth(strtodate(copy(datefin,1,10))),2)+formatoceros(extractday(strtodate(copy(datefin,1,10))),2);

                  AssignFile(f1,'c:\argentin\envio\provincia\prov_'+'VTV_'+nombrefec+'.txt');
                  rewrite(f1);

                  TraeDatos.CommandText := 'ALTER SESSION SET NLS_DATE_FORMAT = ''DD/MM/YYYY HH24:MI:SS''';
                  TraeDatos.Execute;
                  TraeDatos.Close;
                  DeleteTable(mybd, 'TTMP_EXPROVINCIA');
                  ProcLlena:=TSQLStoredProc.Create(nil);
                  ProcLlena.SQLConnection := mybd;
                  ProcLlena.StoredProcName:='PQ_ESTADISTICAS.DOEXPORTAPROVINCIA';
                  ProcLlena.Prepared := true;
                  ProcLlena.ParamByName('FECHAFIN').AsString:=datefin;
                  ProcLlena.ParamByName('FECHAINI').AsString:=dateini;
                  ProcLlena.ExecProc;
                  ProcLlena.Free;
                  TraeDatos.Close;
                  fSQL := TStringList.create;
                  fSQL.Clear;
                  fSQL.Add('SELECT PATENTE, ');
                  fSQL.Add('MOTOR, CHASIS, ANO, MARCA, MODELO, POLIZA, CERTIFICADO, ');
                  fSQL.Add('ASEGURADO, TIPODOC, NRODOC, NUMINSPE, FECHA, NUMFACTU, TIPOVENTA ');
                  fSQL.Add('FROM TTMP_EXPROVINCIA ');
                  TraeDatos.CommandText := fSQL.Text;
                  TraeDatos.Open;
                  TraeDatos.First;
                  while not TraeDatos.EOF do begin
                     writeln(f1,TraeDatos.Fields[0].AsString:9,TraeDatos.Fields[1].AsString:24,TraeDatos.Fields[2].AsString:24,
                             TraeDatos.Fields[3].AsString:4,TraeDatos.Fields[4].AsString:30,
                             TraeDatos.Fields[5].AsString:30,TraeDatos.Fields[6].AsString:9,
                             TraeDatos.Fields[7].AsString:7,TraeDatos.Fields[8].AsString:80,
                             TraeDatos.Fields[9].AsString:3,TraeDatos.Fields[10].AsString:13,
                             TraeDatos.Fields[11].AsString:16,TraeDatos.Fields[12].AsString:10,
                             TraeDatos.Fields[13].AsString:13,TraeDatos.Fields[14].AsString:1);
                     TraeDatos.Next;
                  end;
                  CloseFile(f1);
//                  ComprimirArchivos(7);
               finally
                 fbusqueda.close;
                 fbusqueda.free;
               end;
                  MessageDlg(CAPTION,'Archivos generados correctamente', mtInformation, [mbOk], mbOk, 0);

               finally
                 TraeDatos.free;
                 dsp.Free;
                 sds.Free;
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
//          {IFDEF TRAZAS}
//          fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL, 'No se pudo realizar la exportación de Provincia Seguros por: %s', [E.message]);
//          {END IF}

          MessageDlg(CAPTION,'No se pudo realizar la exportación por: ' + E.message, mtError, [mbOk], mbOk, 0);

         end;
       end;

end;


procedure TfrmProvSeguros.SpeedItem1Click(Sender: TObject);
begin
  DoExportacionProvSeguros
end;

function TfrmProvSeguros.Descomprimir(aZipFile: string): boolean;
var
   ZipMaster1: TZipMaster;
begin
   result := false;
   zipmaster1:=tzipmaster.Create(nil);
   ZipMaster1.Load_Zip_Dll;
   ZipMaster1.ZipFileName:=aZipFile;

   if ZipMaster1.Count < 1 then
   begin
         MessageDlg(CAPTION, 'El archivo está vacío', mtInformation, [mbOk], mbOk, 0);
         Exit;
   end;
   ZipMaster1.FSpecArgs.Clear;

   with ZipMaster1 do
   begin
      ExtrOptions := [];
      try
         Extract;
      except
         MessageDlg(CAPTION, 'Error en la extracción: Fatal DLL Exception in mainunit', mtError, [mbOk], mbOk, 0);
      end;
   end; { end with }
   ZipMaster1.Unload_Zip_Dll;
   zipmaster1.free;
   result := true;
end;

end.
