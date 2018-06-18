unit ufLiqDiaria;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, globals,
  ucdialgs, ulogs, uutils, uSagEstacion, uSagClasses, Db, Grids,
  DBGrids, RXDBCtrl, StdCtrls, UCEdit, Mask, DBCtrls, UCDBEdit, ExtCtrls,
  ComCtrls, SpeedBar, comobj, utiloracle,variants, FMTBcd, DBClient,
  Provider, SqlExpr;

type
  TfrmLiqDiaria = class(TForm)
    SBarPrincipal: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    Print: TSpeedItem;
    SExcel: TSpeedItem;
    SBBusqueda: TSpeedItem;
    SBSalir: TSpeedItem;
    OpenDialog: TOpenDialog;
    sdsQTTMPLIQDIARIATOTFPAGO: TSQLDataSet;
    dspQTTMPLIQDIARIATOTFPAGO: TDataSetProvider;
    QTTMPLIQDIARIATOTFPAGO: TClientDataSet;
    sdsQTTMPTOTALXDESC: TSQLDataSet;
    dspQTTMPTOTALXDESC: TDataSetProvider;
    QTTMPTOTALXDESC: TClientDataSet;
    sdsQTTMPTOTALXUSU: TSQLDataSet;
    dspQTTMPTOTALXUSU: TDataSetProvider;
    QTTMPTOTALXUSU: TClientDataSet;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Bevel4: TBevel;
    Label9: TLabel;
    Label1: TLabel;
    Label11: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label10: TLabel;
    Label17: TLabel;
    grTotFPago: TRxDBGrid;
    grtipousu: TRxDBGrid;
    grdescuentos: TRxDBGrid;
    DBMemo1: TDBMemo;
    eAcaEvectivo: TEdit;
    eAcaCheque: TEdit;
    eTotalACA: TEdit;
    TabSheet2: TTabSheet;
    Bevel3: TBevel;
    Bevel2: TBevel;
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    grdepositos: TRxDBGrid;
    eTotalCaja: TColorEdit;
    eDiferencia: TColorEdit;
    eTransporte: TColorEdit;
    eCambio: TColorEdit;
    eCtaCte: TColorEdit;
    eTotalDep: TColorEdit;
    eTotalxarq: TColorEdit;
    eTotalxarqche: TColorEdit;
    srcTOTFPAGO: TDataSource;
    srcdescuentos: TDataSource;
    srctipousu: TDataSource;
    srcdepositos: TDataSource;
    srcliquidacion: TDataSource;
    sdsTotClienCtaCte: TSQLDataSet;
    dspTotClienCtaCte: TDataSetProvider;
    cdsTotClienCtaCte: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure SBSalirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SExcelClick(Sender: TObject);
    procedure SBBusquedaClick(Sender: TObject);
  private
    { Private declarations }
    fSumaryLD: tSumaryLD;
    fCodliq : string;
    qdepositos, qtotaldepositos: TClientDataSet;
    sdsqdepositos, sdsqtotaldepositos : TSQLDataSet;
    dspqdepositos, dspqtotaldepositos : TDataSetProvider;
    procedure PutSumaryResults;
  public
    { Public declarations }
    bErrorCreando : boolean;
    NombreEstacion, NumeroEstacion,
    DateIni, DateFin,
    aTipoCliente, sUsuario : string;
    fliquidacion : tliquidacion;
    function PutEstacion : string;
  end;
  procedure GenerateLiqDiaria;
  procedure DoLiqDiaria(const FI,FF, usuario: string);

var
  frmLiqDiaria: TfrmLiqDiaria;

implementation

uses
  ugetdates, uftmp, UPrevioLiqDiaria, UFPorTipo;


resourcestring
  FICHERO_ACTUAL = 'ufLigDiaria';
  TIPO_ARQUEO_CAJEROS = 'C';
  claveexcel = '01Ma02Ni*adm';


{$R *.DFM}

procedure GenerateLiqDiaria;
begin
  with TfrmLiqDiaria.Create(application) do
    try
      try
        if bErrorCreando then exit;
        If not GetDates(DateIni,DateFin) then Exit;


        If not PorTipo(TIPO_ARQUEO_CAJEROS, aTipoCliente,'','') then Exit;

        with tusuarios.CreateFromDataBase(mybd,DATOS_USUARIO,format('WHERE IDUSUARIO = %S',[aTipoCliente])) do
          try
            open;
            Caption := Format('Liquidación de caja diaria. Planta: %S. (%S - %S) - Cajero: %S ', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10),ValueByName[FIELD_NOMBRE]]);
            sUsuario := ValueByName[FIELD_NOMBRE];
            close;
          finally
            free
          end;

        FTmp.Temporizar(TRUE,FALSE,'Liquidación de caja diaria', 'Generando el informe Liquidación de caja diaria.');
        Application.ProcessMessages;

        with TFrmPrevioLiqDiaria.CreateByFecha(Application,dateini,datefin, aTipoCliente) do
                try
                    Caption := Format('Petición de parámetros. Liquidación de caja diaria en:  %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                    if not (ShowModal = mrOk)
                    then exit;
                    fSumaryLD := SumaryLD;
                    fLiquidacion.Open;
                    fCodliq := fliquidacion.valuebyname[FIELD_CODLIQUIDACION];
                    MyBD.Commit(td);
                    fLiquidacion.close; //******************************
                finally
                    Free;
                end;


        Application.ProcessMessages;

        DoLiqDiaria(DateIni,DateFin, aTipoCliente);

        fliquidacion := TLiquidacion.CreateByCodigo(mybd,fcodliq);
        fliquidacion.Open;
        srcliquidacion.DataSet := fliquidacion.DataSet;

        FTmp.Temporizar(FALSE,FALSE,'', '');
        Application.ProcessMessages;
        PutSumaryResults;
        showmodal;
      except
          on E: Exception do
          begin
             FTmp.Temporizar(FALSE,FALSE,'', '');
             Application.ProcessMessages;
             FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
             MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)
          end
      end;
    finally
       FTmp.Temporizar(FALSE,FALSE,'', '');
       free;
       Application.ProcessMessages;
    end;
end;

procedure DoLiqDiaria(const FI,FF, usuario: string);
begin
    DeleteTable(MyBD, 'TTMP_LIQDIARIA_TOTFPAGO');
    DeleteTable(MyBD, 'TTMPTOTALXUSU');
    DeleteTable(MyBD, 'TTMPTOTALXDESC');
    DeleteTable(MyBD, 'TTMPTOTALTARJETA');

    with TSQLStoredProc.Create(Application) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_LIQDIARIA.CALCULAGRILLATOTALES';
        Prepared := true;
        ParamByName('FECHAINI').Value := FI;
        ParamByName('FECHAFIN').Value := FF;
        ParamByName('CAJERO').Value := usuario;
        ExecProc;
        Close;
        //mla clientes cta cte 20-10-2008
        StoredProcName := 'PQ_LIQDIARIA.CALCULATOTALESXCLIENTECTACTE';
        Prepared := true;
        ParamByName('FECHAINI').Value := FI;
        ParamByName('FECHAFIN').Value := FF;
        ParamByName('CAJ').Value := usuario;
        ExecProc;
        Close;
        //mla
        StoredProcName := 'PQ_LIQDIARIA.CALCULATOTALESUSUARIOS';
        Prepared := true;
        ParamByName('FECHAINI').Value := FI;
        ParamByName('FECHAFIN').Value := FF;
        ParamByName('CAJERO').Value := usuario;
        ExecProc;
        Close;

        StoredProcName := 'PQ_LIQDIARIA.CALCULATOTALESDESCUENTOS';
        Prepared := true;
        ParamByName('FECHAINI').Value := FI;
        ParamByName('FECHAFIN').Value := FF;
        ParamByName('CAJERO').Value := usuario;
        ExecProc;
        Close;


        StoredProcName := 'PQ_ARQUEO_VTV.DOALLTOTALESTARJETAXCAJERO';
        Prepared := true ;
        ParamByName('FECHAINI').Value := FI;
        ParamByName('FECHAFIN').Value := FF;
        ParamByName('IDCAJERO').Value := usuario;
        ExecProc;
        Close;

    finally
        Free
    end;

end;


procedure TfrmLiqDiaria.FormCreate(Sender: TObject);
begin
    bErrorCreando := False;

    if (not MyBD.InTransaction) then MyBD.StartTransaction(td);

    try
        LoockAndDeleteTable(MyBD, 'TTMP_LIQDIARIA_TOTFPAGO')
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
            MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
            bErrorCreando := True
        end
    end
end;

function TfrmLiqDiaria.PutEstacion : string;
begin
    NombreEstacion := fVarios.NombreEstacion;
    NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
    Result := NumeroEstacion + ' ' + NombreEstacion;
end;

procedure TfrmLiqDiaria.SBSalirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmLiqDiaria.PutSumaryResults;
var
  ArrayVar : variant;
  fSQL : TStringList;
begin
        fSQL := TStringList.Create;

        with QTTMPLIQDIARIATOTFPAGO do
        begin
            Close;
            sdsQTTMPLIQDIARIATOTFPAGO.SQLConnection := MyBD;
            fSQL.Clear;
            fSQL.Add('SELECT NRO, DECODE(INSPECCION,''V'',''VTV'',''G'',''GNC'',''T'',''Total'',''S'',''Subtotal'') TIPO, ');
            fsql.add('DECODE(FORMPAGO,''M'',''Efectivo'',''H'',''Cheques'',''C'',''Cuenta Corriente'',''T'',''Tarjeta'',''R'',''Credito'',''O'',''Contado'',''A'',''Global'') FORMPAGO, ');
            fsql.add('SUBTOTAL, IVATOTAL, IIBBTOTAL, TOTAL FROM TTMP_LIQDIARIA_TOTFPAGO ORDER BY NRO');
            CommandText := fSQL.Text;
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLIQDIARIATOTFPAGO);
            {$ENDIF}
            Open;
        end;

        with QTTMPTOTALXUSU do
        begin
            Close;
            sdsQTTMPTOTALXUSU.SQLConnection := MyBD;
            fSQL.Clear;
            fSQL.Add('SELECT TIPOUSUARIO, IMPORTE ');
            fsql.add('FROM TTMPTOTALXUSU');
            CommandText := fSQL.Text;
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPTOTALXUSU);
            {$ENDIF}
            Open;
        end;

        with QTTMPTOTALXDESC do
        begin
            Close;
            sdsQTTMPTOTALXDESC.SQLConnection := MyBD;
            fSQL.Clear;
            fSQL.Add('SELECT DESCUENTO, IMPORTE ');
            fsql.add('FROM TTMPTOTALXDESC');
            CommandText := fSQL.Text;
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPTOTALXDESC);
            {$ENDIF}
            Open;
        end;

        eTransporte.Text := fSumaryLD.iTransporte;
        eCambio.Text := fSumaryLD.iCambioRec;
        eCtaCte.Text := fSumaryLD.iCobranzasCtaCte;
        eTotalDep.Text := fSumaryLD.iTotalDep;
        eTotalxarq.Text := fSumaryLD.iTotalXArqueo;
        eTotalxarqche.Text := fSumaryLD.iTotalXArqueoche;

        ArrayVar:=VarArrayCreate([0,3],VarVariant);
        ArrayVar[0]:=DateIni;
        ArrayVar[1]:=DateFin;
        ArrayVar[2]:=aTipoCliente;
        ArrayVar[3]:='M';

        eAcaEvectivo.text := floattostrf(strtofloat(fVarios.ExecuteFunction('PQ_LIQDIARIA.DOTOTALESACA',ArrayVar)),fffixed,8,2);

        ArrayVar[3]:='H';
        eAcaCheque.text := floattostrf(strtofloat(fVarios.ExecuteFunction('PQ_LIQDIARIA.DOTOTALESACA',ArrayVar)),fffixed,8,2);

        eTotalACA.text := floattostrf((strtofloat(eAcaEvectivo.text)+strtofloat(eAcaCheque.text)),fffixed,8,2);

        sdsqdepositos := TSQLDataSet.Create(self);
        sdsqdepositos.SQLConnection := MyBD;
        sdsqdepositos.CommandType := ctQuery;
        sdsqdepositos.GetMetadata := false;
        sdsqdepositos.NoMetadata := true;
        sdsqdepositos.ParamCheck := false;

        dspqdepositos := TDataSetProvider.Create(self);
        dspqdepositos.DataSet := sdsqdepositos;
        dspqdepositos.Options := [poIncFieldProps,poAllowCommandText];
        qdepositos := TClientDataSet.Create(self);
        with qdepositos do
        begin
             SetProvider(dspqdepositos);
             fSQL.Clear;
             fsql.Add('select nrocomprob, m.nombre moneda, b.nombre banco, imponeto, deporeca, fechreca from depositos_liq d, ');
             fSQL.ADD('tmonedas m, bancos_deposito b ');
             fsql.add('WHERE D.CODBANCO = B.CODBANCO AND D.CODMONEDA = M.CODMONEDA ');
             fsql.add(format('and (FECHA >= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS'')) AND (FECHA <= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS''))',[dateini,datefin]));
             fsql.add(format('and idusuario = %s',[aTipoCliente]));
             CommandText := fSQL.Text;
             open;
        end;

        sdsqtotaldepositos := TSQLDataSet.Create(self);
        sdsqtotaldepositos.SQLConnection := MyBD;
        sdsqtotaldepositos.CommandType := ctQuery;
        sdsqtotaldepositos.GetMetadata := false;
        sdsqtotaldepositos.NoMetadata := true;
        sdsqtotaldepositos.ParamCheck := false;

        dspqtotaldepositos := TDataSetProvider.Create(self);
        dspqtotaldepositos.DataSet := sdsqtotaldepositos;
        dspqtotaldepositos.Options := [poIncFieldProps,poAllowCommandText];
        qtotaldepositos := TClientDataSet.Create(self);
        with qtotaldepositos do
        begin
             SetProvider(dspqtotaldepositos);
             fSQL.Clear;
             fsql.Add('select sum(imponeto) from depositos_liq  ');
             fsql.add(format('where (FECHA >= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS'')) AND (FECHA <= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS''))',[dateini,datefin]));
             fsql.add(format('and idusuario = %s',[aTipoCliente]));
             CommandText := fSQL.Text;
             open;
             if fields[0].value > 0 then
               eTotalDep.Text := fields[0].asstring
             else
               eTotalDep.Text := '0';
        end;

        srcdepositos.DataSet := qdepositos;

        with TSQLQuery.Create(self) do
          try
            SQLConnection := mybd;
            SQL.Clear;
            SQL.Add('SELECT TOTAL FROM TTMP_LIQDIARIA_TOTFPAGO WHERE INSPECCION = ''T'' AND FORMPAGO = ''O''');
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 1, FICHERO_ACTUAL, QTTMPLIQDIARIATOTFPAGO);
            {$ENDIF}
            Open;
            fSumaryLD.iTotalContado := fields[0].asstring;
          finally
            free;
          end;

        with fSumaryLD do
        begin
          iTotalCaja := floattostrf(strtofloat(iTransporte)+strtofloat(iCambioRec)+strtofloat(iTotalContado)+strtofloat(eTotalACA.text)-strtofloat(eTotalDep.Text),fffixed,8,2);
          iDiferencia :=  floattostrf(strtofloat(iTotalXArqueo)+strtofloat(iTotalXArqueoChe)-strtofloat(iTotalCaja),fffixed,8,2);
        end;

        eTotalCaja.Text := fSumaryLD.iTotalCaja;
        eDiferencia.Text := fSumaryLD.iDiferencia;


end;

procedure TfrmLiqDiaria.FormDestroy(Sender: TObject);
begin
  qDepositos.Free;
  dspqdepositos.free;
  sdsqdepositos.Free;
  qtotaldepositos.free;
  dspqtotaldepositos.Free;
  sdsqtotaldepositos.Free;
  fliquidacion.Free;
end;

procedure TfrmLiqDiaria.SExcelClick(Sender: TObject);
var
    i,f,comtot, fintot, comdesc : integer;
    ExcelApp, ExcelLibro, ExcelHoja, ExcelHoja2: Variant;
    nombre : string;
    sds : TSQLDataSet;
    dsp : TDataSetProvider;
const
     F_FEL = 4;   C_FEC = 4;
     F_FEE = 7;   C_DAT = 2;
     F_PLA = 9;
     F_USU = 11;
     F_TDA = 13;  C_IMP = 5;
     F_CAR = 14;
     F_CCC = 15;
     F_INI = 19;
                  C_TDE = 6;
                  C_SAC = 3;
                  C_SAE = 4;
                  C_SAT = 5;
                  C_GNC = 1;

begin

  try
    try
      if fliquidacion.DataSet.State = dsedit then
        fliquidacion.Post(true);

      opendialog.Title := 'Seleccione la Planilla de Entrada';
      if OpenDialog.Execute then
      begin
           FTmp.Temporizar(TRUE,FALSE,'Liquidación de caja Diaria', 'Exportando los datos a excel');
           ExcelApp := CreateOleObject('Excel.Application');
           ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
           nombre := OpenDialog.FileName;
           ExcelHoja := ExcelLibro.Worksheets['Liquidacion'];
           ExcelHoja2:= ExcelLibro.Worksheets['Detalle CC - Bonificados'];
           ExcelHoja.unprotect(claveexcel);



           excelHoja.cells[F_FEL, C_FEC].Value := copy(dateini,1,10);

           excelHoja.cells[F_FEE, C_DAT].Value := datebd(mybd);
           excelHoja.cells[F_PLA, C_DAT].Value := PutEstacion;
           excelHoja.cells[F_USU, C_DAT].Value := sUsuario;
           excelHoja.cells[F_TDA, C_IMP].Value := eTransporte.text;

           excelHoja.cells[F_CAR, C_IMP].Value := eCambio.text;
           excelHoja.cells[F_CCC, C_IMP].Value := eCtaCte.text;

           f := F_INI;

           qdepositos.First;
           while not qdepositos.EOF do
           begin
                if f > 27 then
                begin
                     ExcelHoja.rows[f].insert;
                end;
                for i := 0 to 4 do //grdepositos.Columns.Count -1 do
                  if i >= 3 then
                     excelHoja.cells[f,i+2].value := qdepositos.FieldByName(grdepositos.Columns[i].FieldName).AsString
                  else
                     excelHoja.cells[f,i+1].value := qdepositos.FieldByName(grdepositos.Columns[i].FieldName).AsString;

                qdepositos.Next;
                inc(f);
           end;
           if f < 28 then
              for i:= f to 27 do
                  ExcelHoja.rows[f].delete;

           excelHoja.cells[f, C_TDE].Value := eTotalDep.text;



           f := f+4;
           comtot := f;

           QTTMPLIQDIARIATOTFPAGO.First;
           while not QTTMPLIQDIARIATOTFPAGO.EOF do
           begin
             for i := 0 to grTotFPago.Columns.Count -1 do
                if ((f-comtot) = 2) or ((f-comtot) = 5) or ((f-comtot) = 6)
                or ((f-comtot) = 9) or ((f-comtot) = 12) or ((f-comtot) = 13)
                or ((f-comtot) = 14)
                then
                begin
                   if ((f-comtot) = 2) or ((f-comtot) = 5) or ((f-comtot) = 6)
                   or ((f-comtot) = 9) or ((f-comtot) = 12) or ((f-comtot) = 13) then
                   begin
                        if ((i <> 0) and (i<>1)) then
                           excelHoja.cells[f,i+1].value := QTTMPLIQDIARIATOTFPAGO.FieldByName(grTotFPago.Columns[i].FieldName).AsString;
                   end;
                   if (f-comtot) = 14 then
                   begin
                        if ((i <> 0) and (i<>1)) then
                           excelHoja.cells[f+1,i+1].value := QTTMPLIQDIARIATOTFPAGO.FieldByName(grTotFPago.Columns[i].FieldName).AsString;
                   end
                end
             else
               excelHoja.cells[f,i+1].value := QTTMPLIQDIARIATOTFPAGO.FieldByName(grTotFPago.Columns[i].FieldName).AsString;
             QTTMPLIQDIARIATOTFPAGO.Next;
             inc(f);
           end;

           f := f+3;
           excelHoja.cells[f,C_SAC].value := eAcaCheque.TEXT;
           excelHoja.cells[f,C_SAE].value := eAcaEvectivo.TEXT;
           excelHoja.cells[f,C_SAT].value := eTotalACA.TEXT;


           fintot := f;

           f := comtot;


           { Validación Cierre}

           excelHoja.cells[f,C_IMP+5].value := eTotalCaja.TEXT;


           f := f+2;
           excelHoja.cells[f,C_IMP+4].value := eTotalxarq.TEXT;
           excelHoja.cells[f,C_IMP+5].value := eTotalxarqche.TEXT;



           inc(f);
           excelHoja.cells[f,C_IMP+5].value := eDiferencia.TEXT;
           if excelHoja.cells[f,C_IMP+5].value > 0 then
           begin
                excelHoja.cells[f,C_IMP+5].interior.color := $00E7B587
           end
           else if excelHoja.cells[f,C_IMP+5].value < 0 then
           begin
             excelHoja.cells[f,C_IMP+5].interior.color := $00688AFD
           end else
               excelHoja.cells[f,C_IMP+5].interior.color := 2;

           f := fintot;
           f := f+3;

        sds := TSQLDataSet.Create(self);
        sds.SQLConnection := MyBD;
        sds.CommandType := ctQuery;
        sds.GetMetadata := false;
        sds.NoMetadata := true;
        sds.ParamCheck := false;

        dsp := TDataSetProvider.Create(self);
        dsp.DataSet := sds;
        dsp.Options := [poIncFieldProps,poAllowCommandText];

    with TClientDataSet.create(self) do
      try
         SetProvider(dsp);
         CommandText := 'SELECT SUM(SUBTOTAL) FROM TTMP_LIQDIARIA_TOTFPAGO WHERE INSPECCION = ''G''';
         open;
         if recordcount <> 0 then
         begin
             excelHoja.cells[f,C_DAT].value := fields[0].value;
         end
         else
         begin
             excelHoja.cells[f,C_DAT].value := '0,00';
         end;
      finally
         free;
         dsp.free;
         sds.Free;
      end;

    excelHoja.cells[f,C_GNC].value := 'Rev. Per. Anual';

    f := f+3;

    QTTMPTOTALXUSU.First;
    while not QTTMPTOTALXUSU.EOF do
    begin
        for i := 0 to grtipousu.Columns.Count -1 do
               excelHoja.cells[f,i+1].value := QTTMPTOTALXUSU.FieldByName(grtipousu.Columns[i].FieldName).AsString;
        QTTMPTOTALXUSU.Next;
        inc(f);
    end;

    f := f+2;


     with tsqlquery.Create(application) do
      try
        SQLConnection := mybd;
        sql.Add('SELECT   count(*) as factcant ') ;
        sql.Add('FROM TFACTURAS f, TCLIENTES c, TTIPOSCLIENTE tt, TFACT_ADICION a,Tinspeccion i ') ;
        sql.Add('WHERE c.codclien = f.codclien and a.codfact=f.codfactu  and i.codfactu=f.codfactu and i.tipo=''A''')  ;
        sql.Add(format('AND f.fechalta BETWEEN TO_DATE (''%s'',''dd/mm/yyyy HH24::MI::SS'') ',[DATEINI])) ;
        sql.Add(format('AND TO_DATE (''%s'',''dd/mm/yyyy HH24::MI::SS'') ',[DATEFIN])) ;
        sql.Add('AND tt.pornormal = 100 AND tt.tipocliente_id = c.tipocliente_id ') ;
        sql.Add(format('AND a.idusuari = ''%s'' ',[aTipoCliente])) ;
        Open;
        First;
        excelHoja.cells[f,5].value :=fields[0].asstring ;
       finally
        free;
      end;

    comdesc := f;

    QTTMPTOTALXDESC.First;
    while not QTTMPTOTALXDESC.EOF do
    begin
        for i := 0 to grdescuentos.Columns.Count -1 do
               excelHoja.cells[f,i+1].value := QTTMPTOTALXDESC.FieldByName(grdescuentos.Columns[i].FieldName).AsString;
        QTTMPTOTALXDESC.Next;
        inc(f);
    end;

    if (f-comdesc) < 2 then
      f := f+4
    else
      f := f+2;

    ExcelHoja.cells[f,1].font.bold := true;
    excelHoja.cells[f,1].value := 'Observaciones:';
    excelHoja.cells[f+1,1].value := fliquidacion.ValueByName[FIELD_OBSERVACIONES];



    //mla-Nueva hoja que muestra los clientes en cta cte
    i:=0 ;
    f := 2;
    excelHoja2.cells[1,3].value := 'Clientes Cuenta Corriente';
    excelHoja2.cells[f,i+1].value := 'Cliente';
    excelHoja2.cells[f,i+2].value := 'Docu/Cuit';
    excelHoja2.cells[f,i+3].value := 'SubTotal';
    excelHoja2.cells[f,i+4].value := 'Iva';
    excelHoja2.cells[f,i+5].value := 'IIBB';
    excelHoja2.cells[f,i+6].value := 'Total';
    with tsqlquery.Create(application) do
      try
        SQLConnection := mybd;
        sql.Add('SELECT codclien,DOCUMENT,SUM(subtotal), SUM(ivatotal),SUM(iibbtotal),SUM(total),nro FROM TTMP_LIQDIARIA_CLIENTCTACTE GROUP BY codclien, document, nro');
        Open;
        f := 3;
        First;
        while not Eof  do
             begin
               excelHoja2.cells[f,i+1].value := fields[0].asstring;
               excelHoja2.cells[f,i+2].value := fields[1].asstring;
               excelHoja2.cells[f,i+3].value := fields[2].asstring;
               excelHoja2.cells[f,i+4].value := fields[3].asstring;
               excelHoja2.cells[f,i+5].value := fields[4].asstring;
               excelHoja2.cells[f,i+6].value := fields[5].asstring;
               excelHoja2.cells[f,i+7].value := fields[6].asstring;
               Next;
               inc(f);
             end ;
         finally
        free;
      end;

    f:=f+2 ;
    excelHoja2.cells[f,3].value := 'Clientes con factura bonificadas';
    f:=f+1 ;
    excelHoja2.cells[f,i+1].value := 'Cliente';
    excelHoja2.cells[f,i+2].value := 'Docu/Cuit';
    excelHoja2.cells[f,i+3].value := 'Tipo de Cliente';
    excelHoja2.cells[f,i+4].value := 'Nro Factura';
    excelHoja2.cells[f,i+5].value := 'Imponeto';
    f:=f+1 ;

    with tsqlquery.Create(application) do
      try
        SQLConnection := mybd;
        sql.Add('SELECT   c.apellid1 || c.nombre, document,tt.DESCRIPCION, f.numfactu, f.imponeto ') ;
        sql.Add('FROM TFACTURAS f, TCLIENTES c, TTIPOSCLIENTE tt, TFACT_ADICION a , TINSPECCION i ') ;
        sql.Add('WHERE c.codclien = f.codclien and a.codfact=f.codfactu   and i.codfactu=f.codfactu and i.tipo=''A'' ')  ;
        sql.Add(format('AND f.fechalta BETWEEN TO_DATE (''%s'',''dd/mm/yyyy HH24::MI::SS'') ',[DATEINI])) ;
        sql.Add(format('AND TO_DATE (''%s'',''dd/mm/yyyy HH24::MI::SS'') ',[DATEFIN])) ;
        sql.Add('AND tt.pornormal = 100 AND tt.tipocliente_id = c.tipocliente_id ') ;
        sql.Add(format('AND a.idusuari = ''%s'' ',[aTipoCliente])) ;
        sql.Add('ORDER BY numfactu, document ');
        Open;
        First;
        while not Eof  do
             begin
               excelHoja2.cells[f,i+1].value := fields[0].asstring;
               excelHoja2.cells[f,i+2].value := fields[1].asstring;
               excelHoja2.cells[f,i+3].value := fields[2].asstring;
               excelHoja2.cells[f,i+4].value := fields[3].asstring;
               excelHoja2.cells[f,i+5].value := fields[4].asstring;
               Next;
               inc(f);
             end ;
         finally
        free;
      end;
      inc(f);
      inc(f);
      inc(f);
      excelHoja2.cells[f,1].value := 'DATOS TARJETAS';
      inc(f);
      with tsqlquery.Create(application) do
      try
        SQLConnection := mybd;
        sql.Add('SELECT CODTARJETA, TARJETA, SUBTOTAL, IVACAJA, IVANOINSC, TOTALCAJA, IIBB FROM TTMPTOTALTARJETA ORDER BY CODTARJETA') ;
        Open;
        First;
        while not Eof  do
             begin
                excelHoja2.cells[f,i+1].value := fields[0].asstring;
               excelHoja2.cells[f,i+2].value := fields[1].asstring;
               excelHoja2.cells[f,i+3].value := fields[2].asstring;
               excelHoja2.cells[f,i+4].value := fields[3].asstring;
               excelHoja2.cells[f,i+5].value := fields[4].asstring;
               excelHoja2.cells[f,i+4].value := fields[5].asstring;
               excelHoja2.cells[f,i+5].value := fields[6].asstring;
               Next;
              inc(f);
             end ;
         finally
        free;
      end;




  //fim hoja 2 excel
  end;

  opendialog.Title := 'Seleccione la Planilla de Salida';
  ExcelHoja.protect(claveexcel);
  if OpenDialog.Execute then
    if OpenDialog.FileName <> nombre then
    begin
      excellibro.saveas(opendialog.filename);
    end
    else
    begin
       MessageDlg('Exportación a Excel.', 'La Planilla de Entrada y Salida no pueden tener el mismo nombre ', mtError, [mbOk], mbOk, 0)
    end;

    ExcelApp.DisplayAlerts := False;
    ExcelApp.Quit;
    except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de UIVABook: %s', [E.message]);
                MessageDlg('Generación de Informes.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end
    end;

  finally
      FTmp.Temporizar(FALSE,FALSE,'','');
      application.ProcessMessages;
  end;

end;

procedure TfrmLiqDiaria.SBBusquedaClick(Sender: TObject);
begin
    try
      Enabled := False;
      try
        If not GetDates(DateIni,DateFin) then Exit;

        If not PorTipo(TIPO_ARQUEO_CAJEROS, aTipoCliente,'','') then Exit;

        with tusuarios.CreateFromDataBase(mybd,DATOS_USUARIO,format('WHERE IDUSUARIO = %S',[aTipoCliente])) do
          try
            open;
            Caption := Format('Liquidación de caja diaria. Planta: %S. (%S - %S) - Cajero: %S ', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10),ValueByName[FIELD_NOMBRE]]);
            sUsuario := ValueByName[FIELD_NOMBRE];
            close;
          finally
            free
          end;

        FTmp.Temporizar(TRUE,FALSE,'Liquidación de caja diaria', 'Generando el informe Liquidación de caja diaria.');
        Application.ProcessMessages;

        mybd.StartTransaction(td);
        with TFrmPrevioLiqDiaria.CreateByFecha(Application,dateini,datefin, aTipoCliente) do
                try
                    Caption := Format('Petición de parámetros. Liquidación de caja diaria en:  %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                    if not (ShowModal = mrOk)
                    then exit;
                    fSumaryLD := SumaryLD;
                    fLiquidacion.Open;
                    fCodliq := fliquidacion.valuebyname[FIELD_CODLIQUIDACION];
                    QTTMPLIQDIARIATOTFPAGO.close;
                    QTTMPTOTALXDESC.Close;
                    QTTMPTOTALXUSU.close;
                    MyBD.Commit(td);
                    fLiquidacion.close; //***************************
                finally
                    Free;
                end;


        Application.ProcessMessages;

        DoLiqDiaria(DateIni,DateFin, aTipoCliente);

        fliquidacion.Close;
        fliquidacion := TLiquidacion.CreateByCodigo(mybd,fcodliq);
        fliquidacion.Open;
        srcliquidacion.DataSet := fliquidacion.DataSet;

        FTmp.Temporizar(FALSE,FALSE,'', '');
        Application.ProcessMessages;
        PutSumaryResults;
      except
          on E: Exception do
          begin
             FTmp.Temporizar(FALSE,FALSE,'', '');
             Application.ProcessMessages;
             FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
             MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)
          end
      end;
    finally
        Enabled := True;
        Show;
        Application.ProcessMessages;
    end;
end;



end.
