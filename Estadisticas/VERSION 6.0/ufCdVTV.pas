{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE ON}
{$WARN UNSAFE_CODE ON}
{$WARN UNSAFE_CAST ON}
unit ufCdVTV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SpeedBar, ExtCtrls, ucDialgs, StdCtrls,Globals, uSagEstacion,
  ToolEdit, RXDBCtrl, Mask, DBCtrls, DB, Buttons, uUtils, ZipMstr,
  dbcgrids, RxMemDS,SqlExpr,UsagClasses;

type
  TfrmCdVTV = class(TForm)
    SpeedBar1: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    btnImpCD: TSpeedItem;
    btnSalir: TSpeedItem;
    btnManCD: TSpeedItem;
    OpenDialog1: TOpenDialog;
    pnDatosCd: TPanel;
    edZona: TDBEdit;
    edPlanta: TDBEdit;
    edFecha: TDBDateEdit;
    edAptasV: TDBEdit;
    edCondicV: TDBEdit;
    edAptasR: TDBEdit;
    edCondicR: TDBEdit;
    edRechazR: TDBEdit;
    edAnuladas: TDBEdit;
    edInutilizadas: TDBEdit;
    edULPROX: TDBEdit;
    edRechazV: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    srcCD: TDataSource;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    Bevel1: TBevel;
    btnPlanilla: TSpeedItem;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    tabObleas: TRxMemoryData;
    tabObleasPRIMERA: TIntegerField;
    tabObleasULTIMA: TIntegerField;
    tabObleasTIPO: TStringField;
    DBCtrlGrid1: TDBCtrlGrid;
    dsObleas: TDataSource;
    edInicial: TDBEdit;
    edfinal: TDBEdit;
    edtipo: TDBComboBox;
    DBNavigator1: TDBNavigator;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Bevel2: TBevel;
    Label15: TLabel;
    btnplanillamen: TSpeedItem;
    procedure btnSalirClick(Sender: TObject);
    procedure btnImpCDClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnManCDClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnPlanillaClick(Sender: TObject);
    procedure DBCtrlGrid1Enter(Sender: TObject);
    procedure btnplanillamenClick(Sender: TObject);
  private
    { Private declarations }
    fDatos_CD : TDatos_CDVTV;
    fObleas : tObleas_VTV;
    DatosOK : boolean;
    archObleas, archCD : string;
    procedure InsertarCD (aDatos: string);
    procedure InsertarObleas (aDatos: string);    
    function CDYaImportado(Zona, Planta, Fecha : string):boolean;
    function ValidatePost:boolean;
    function Descomprimir(aZipFile : string):boolean;
    procedure ImportarCD(archivo : string);
    procedure ImportarObleas(archivo : string);
    procedure ActualizaObleas;
  public
    { Public declarations }
  end;

  procedure generateCDVTV;

var
  frmCdVTV: TfrmCdVTV;

implementation

uses
  UFTMP, Math, DateUtil, ufPlanillaSemanalVTV, USAGDATA, ufPlanillaResumenVTV;

resourcestring
  CAPTION = 'Controles Diarios VTV';


{$R *.dfm}

procedure generateCDVTV;
begin
        with TfrmCdVTV.Create(Application) do
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


procedure TfrmCdVTV.btnSalirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmCdVTV.btnImpCDClick(Sender: TObject);
begin
  if pnDatosCd.Visible then pnDatosCd.Visible := false;
  if OpenDialog1.Execute then
  begin
    if not Descomprimir(OpenDialog1.FileName) then exit;
    BDAG.StartTransaction(td);
    ImportarCD(OpenDialog1.FileName);
    ImportarObleas(OpenDialog1.FileName);
    if DatosOK then
    begin
      BDAG.Commit(td);
      MessageDlg(CAPTION, 'CD importado con éxito', mtInformation, [mbOk], mbOk, 0);
    end
    else
    begin
      BDAG.Rollback(td);
      MessageDlg(CAPTION, 'El CD no ha sido importado', mtError, [mbOk], mbOk, 0);
      DatosOK := true;
    end;
    DeleteFile(archObleas);
    DeleteFile(archCD);
  end;
end;

procedure TfrmCdVTV.FormCreate(Sender: TObject);
begin
  fDatos_CD := TDatos_CDVTV.CreatebyRowID(bdag,'');
  fDatos_CD.Open;
  srcCD.DataSet := fDatos_CD.DataSet;
  fObleas := nil;
  DatosOK := true;
end;

procedure TfrmCdVTV.InsertarCD(aDatos: string);
begin
   if not CDYaImportado(copy(aDatos,1,2),copy(aDatos,3,2),copy(aDatos,5,10)) then
   begin
       try
          fDatos_CD.Append;
          fDatos_CD.ValueByName[FIELD_ZONA] := copy(aDatos,1,2) ;
          fDatos_CD.ValueByName[FIELD_PLANTA] := copy(aDatos,3,2) ;
          fDatos_CD.ValueByName[FIELD_FECHA] := copy(aDatos,5,10) ;
          fDatos_CD.ValueByName[FIELD_CANTAPRV] :=copy(aDatos,15,6) ;
          fDatos_CD.ValueByName[FIELD_CANTCONV] :=copy(aDatos,21,6) ;
          fDatos_CD.ValueByName[FIELD_CANTRECV]:=copy(aDatos,27,6) ;
          fDatos_CD.ValueByName[FIELD_CANTAPRR] := copy(aDatos,33,6);
          fDatos_CD.ValueByName[FIELD_CANTCONR] := copy(aDatos,39,6);
          fDatos_CD.ValueByName[FIELD_CANTRECR] := copy(aDatos,45,6);
          fDatos_CD.ValueByName[FIELD_CANTANULADAS] := copy(aDatos,51,6) ;
          fDatos_CD.ValueByName[FIELD_CANTINUTIL] :=copy(aDatos,57,6) ;
          fDatos_CD.ValueByName[FIELD_RECAUDACION] := '';
          fDatos_CD.ValueByName[FIELD_TIPO] := TIPO_AUTOMATICA;
//          fDatos_CD.ValueByName[FIELD_FECHMODI] := datetostr(date);
          fDatos_CD.Post(true);
       except
         on E: Exception do
         begin
            MessageDlg(CAPTION,Format('No se ha podido importar el CD por: %s. ',[E.message]), mtError, [mbOk], mbOk, 0);
            DatosOK := false;
         end;
       end;
   end
   else
   begin
     MessageDlg(CAPTION, 'Este CD ya se ha importado en la base con anterioridad', mtError, [mbOk], mbOk, 0);
     DatosOK := FALSE;
   end;
end;

function TfrmCdVTV.CDYaImportado(Zona, Planta, Fecha: string): boolean;
begin
  result := true;
  with tsqlquery.create(nil) do
    try
      SQLConnection  := BDAG;
      sql.Add(format('SELECT * FROM VTV_DATOS_CD WHERE ZONA = %S AND PLANTA = %S AND TO_CHAR(FECHA,''DD/MM/YYYY'') = ''%S''',[Zona, Planta, Fecha]));
      open;
      if recordcount > 0 then
      begin
        exit;
      end;
    finally
      free;
    end;
  result := false;
end;

procedure TfrmCdVTV.btnManCDClick(Sender: TObject);
begin
  pnDatosCd.Visible := true;
  edZona.SetFocus;
  if BDAG.InTransaction then BDAG.Rollback(td);
  BDAG.StartTransaction(td);
  fDatos_CD.Append;
  tabObleas.open;  
end;

procedure TfrmCdVTV.btnAceptarClick(Sender: TObject);
begin
  if ValidatePost then
  begin
   if not CDYaImportado(edzona.Text,edPlanta.Text,datetostr(edFecha.date)) then
   begin
     try
       try
         fDatos_CD.ValueByName[FIELD_TIPO] := TIPO_MANUAL;
         fDatos_CD.Post(true);
         ActualizaObleas;
         pnDatosCd.Visible := false;
       except
         on E: Exception do
         begin
            MessageDlg(CAPTION,Format('No se ha podido importar el CD por: %s. ',[E.message]), mtError, [mbOk], mbOk, 0);
            datosok := false;
         end;
       end;
     finally
       if DatosOK then
       begin
         BDAG.Commit(td);
         MessageDlg(CAPTION, 'CD importado con éxito', mtInformation, [mbOk], mbOk, 0);
       end
       else
       begin
         BDAG.Rollback(td);
         MessageDlg(CAPTION, 'El CD no ha sido importado', mtError, [mbOk], mbOk, 0);
         DatosOK := true;
       end;
       tabObleas.Close;
     end;
   end
   else
   begin
     MessageDlg(CAPTION, 'Este CD ya se ha importado en la base con anterioridad', mtError, [mbOk], mbOk, 0);
   end;
  end;
end;

procedure TfrmCdVTV.btnCancelarClick(Sender: TObject);
begin
  fDatos_CD.Cancel;
  fDatos_CD.Append;
  tabObleas.Close;
  pnDatosCd.Visible := FALSE;
end;

procedure TfrmCdVTV.FormDestroy(Sender: TObject);
begin
  if BDAG.InTransaction then BDAG.Rollback(td);
end;

procedure TfrmCdVTV.FormKeyPress(Sender: TObject; var Key: Char);
begin
        if key = ^M
        then begin
            Perform(WM_NEXTDLGCTL,0,0);
            Key := #0
        end
end;

function TfrmCdVTV.ValidatePost: boolean;
begin
  result := false;
  if edZona.Text = '' then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la Zona',mtError,[mbOK],mbOK,0);
        edZona.SetFocus;
        exit;
  end;

  If edPlanta.Text = '' then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la Planta',mtError,[mbOK],mbOK,0);
        edPlanta.SetFocus;
        exit;
  end;

  If edFecha.date = 0 then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la Fecha del CD',mtError,[mbOK],mbOK,0);
        edFecha.SetFocus;
        exit;
  end;
  If edAptasV.Text = '' then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la cantidad de Inspecciones Normales Aptas',mtError,[mbOK],mbOK,0);
        edAptasV.SetFocus;
        exit;
  end;
  If edCondicV.Text = '' then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la cantidad de Inspecciones Normales Condicionales',mtError,[mbOK],mbOK,0);
        edCondicV.SetFocus;
        exit;
  end;
  If edRechazV.Text = '' then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la cantidad de Inspecciones Normales Rechazadas',mtError,[mbOK],mbOK,0);
        edRechazV.SetFocus;
        exit;
  end;
    If edAptasR.Text = '' then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la cantidad de Reverificaciones Aptas',mtError,[mbOK],mbOK,0);
        edAptasR.SetFocus;
        exit;
  end;
  If edCondicR.Text = '' then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la cantidad de Reverificaciones Condicionales',mtError,[mbOK],mbOK,0);
        edCondicR.SetFocus;
        exit;
  end;
  If edRechazR.Text = '' then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la cantidad de Reverificaciones Rechazadas',mtError,[mbOK],mbOK,0);
        edRechazR.SetFocus;
        exit;
  end;
  If edAnuladas.Text = '' then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la cantidad de Obleas Anuladas',mtError,[mbOK],mbOK,0);
        edAnuladas.SetFocus;
        exit;
  end;
  If edInutilizadas.Text = '' then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la cantidad de Obleas Inutilizadas',mtError,[mbOK],mbOK,0);
        edInutilizadas.SetFocus;
        exit;
  end;



  result := true;
end;


procedure TfrmCdVTV.btnPlanillaClick(Sender: TObject);
begin
  GeneratePlanillaSemanalvtv;
end;

function TfrmCdVTV.Descomprimir(aZipFile: string):boolean;
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
   ZipMaster1.Password := clavezip;

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

procedure TfrmCdVTV.ImportarCD(archivo: string);
var
 narchivo, s : string;
 F: TextFile;
begin
  try
    narchivo := copy(archivo,1,Length(archivo)-3)+'dat';
    archCD := narchivo;
    AssignFile(F, narchivo);
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
    CloseFile(F);
  except
    DatosOK := false;
  end;
end;

procedure TfrmCdVTV.ImportarObleas(archivo: string);
var
 narchivo, s : string;
 F: TextFile;
begin
  try
    narchivo := copy(archivo,1,Length(archivo)-16)+'OB'+copy(archivo,Length(archivo)-13,11)+'dat';
    archObleas := narchivo;
    AssignFile(F, narchivo);
    Reset(F);
    while True do
    begin
      Readln(F, S);
      try
        if (S = '') or (DatosOK = false) then Break
        else begin
          InsertarObleas (s);
        end;
      finally
      end;
    end;
    CloseFile(F);
  except
    DatosOK := false;
  end;

end;

procedure TfrmCdVTV.InsertarObleas(aDatos: string);
var
  ArrayVar : Variant;
begin
       try
          fObleas := tObleas_VTV.CreateByNumero(bdag,copy(aDatos,16,8));
          with fObleas do
            try
              Open;
              if recordcount > 0 then
              begin
                ArrayVar:=VarArrayCreate([0,1],VarVariant);
                ArrayVar[0]:=strtoint(copy(aDatos,1,2));
                ArrayVar[1]:=strtoint(copy(aDatos,3,2));
                if ValueByName[FIELD_IDPLANTA] =  ExecuteFunction('GETPLANTA',ArrayVar) then
                begin
                  if (ValueByName[FIELD_ESTADO] = ESTADO_STOCK)
                    or ((ValueByName[FIELD_ESTADO] = ESTADO_CONSUMIDA) and (copy(aDatos,24,1) = ESTADO_INUTILIZADA)) then
                  begin
                    if copy(aDatos,24,1) <> ESTADO_INUTILIZADA then
                      ValueByName[FIELD_FECHCONS] := copy(aDatos,5,10)
                    else
                      ValueByName[FIELD_FECHINUT] := copy(aDatos,5,10);

                    ValueByName[FIELD_ESTADO] := copy(aDatos,24,1);
                    ValueByName[FIELD_EJERCICI] := trim(copy(aDatos,25,4));
                    ValueByName[FIELD_CODINSPE] := trim(copy(aDatos,29,6));
                    post(true);
                  end
                  else
                  begin
                    MessageDlg(CAPTION, 'Se está intentando importar Obleas que no están más en stock: '+copy(aDatos,16,8), mtError, [mbOk], mbOk, 0);
                    DatosOK := false;
                    exit;
                  end;
                end
                else
                begin
                  MessageDlg(CAPTION, 'Se está intentando importar Obleas que no corresponden a la Planta '+copy(aDatos,16,8), mtError, [mbOk], mbOk, 0);
                  DatosOK := false;
                end;
              end
              else
              begin
                  MessageDlg(CAPTION, 'Se está intentando importar Obleas que no existen en la base '+copy(aDatos,16,8), mtError, [mbOk], mbOk, 0);
                  DatosOK := false;
              end;
            finally
              close;
              free;
            end;
       except
         on E: Exception do
         begin
            MessageDlg(CAPTION,Format('No se ha podido importar el CD por: %s. ',[E.message]), mtError, [mbOk], mbOk, 0);
            DatosOK := false;
         end;
       end;
end;

procedure TfrmCdVTV.ActualizaObleas;
var aq : tsqlquery;
    ArrayVar : variant;
    i : integer;
begin
  try
    if tabObleas.State in [dsinsert, dsedit] then tabObleas.Post;
    aq := TsqlQuery.Create(nil);
    with aq do
    begin
      SqlConnection := BDAG;
      sql.add('alter session set nls_date_format = ''dd/mm/yyyy''');
      ExecSQL;
    end;
    tabObleas.First;
    while not tabObleas.Eof do
    begin
      for i := tabObleas.fieldbyname('PRIMERA').AsInteger to tabObleas.fieldbyname('ULTIMA').AsInteger do
      begin
          fObleas := tObleas_VTV.CreateByNumero(bdag,inttostr(i));
          with fObleas do
            try
              Open;
              if recordcount > 0 then
              begin
                ArrayVar:=VarArrayCreate([0,1],VarVariant);
                ArrayVar[0]:=strtoint(edZona.text);
                ArrayVar[1]:=strtoint(edPlanta.Text);
                if ValueByName[FIELD_IDPLANTA] =  ExecuteFunction('GETPLANTA',ArrayVar) then
                begin
                  if (ValueByName[FIELD_ESTADO] = ESTADO_STOCK)
                    or ((ValueByName[FIELD_ESTADO] = ESTADO_CONSUMIDA) and (copy(tabObleas.fieldbyname('TIPO').AsString,1,1) = ESTADO_INUTILIZADA)) then
                  begin
                    ValueByName[FIELD_ESTADO] := copy(tabObleas.fieldbyname('TIPO').AsString,1,1);
                    if copy(tabObleas.fieldbyname('TIPO').AsString,1,1) <> ESTADO_INUTILIZADA then
                      ValueByName[FIELD_FECHCONS] := copy(edFecha.text,1,10)
                    else
                      ValueByName[FIELD_FECHINUT] := copy(edFecha.text,1,10);
                    post(true);
                  end
                  else
                  begin
                    MessageDlg(CAPTION, 'Se está intentando importar Obleas que no están más en stock: '+inttostr(i), mtError, [mbOk], mbOk, 0);
                    DatosOK := false;
                    exit;
                  end;
                end
                else
                begin
                  MessageDlg(CAPTION, 'Se está intentando importar Obleas que no corresponden a la Planta: '+inttostr(i), mtError, [mbOk], mbOk, 0);
                  DatosOK := false;
                  exit;
                end;
              end
              else
              begin
                  MessageDlg(CAPTION, 'Se está intentando importar Obleas que no existen en la base: '+inttostr(i), mtError, [mbOk], mbOk, 0);
                  DatosOK := false;
                  exit;
              end;
            finally
              close;
              free;
            end;
      end;
    tabObleas.Next;
    end;
  finally

  end;
end;

procedure TfrmCdVTV.DBCtrlGrid1Enter(Sender: TObject);
begin
  edInicial.SetFocus;
end;

procedure TfrmCdVTV.btnplanillamenClick(Sender: TObject);
begin
  GeneratePlanillaResumenVTV;
end;

end.
