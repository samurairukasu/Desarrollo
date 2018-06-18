unit ufCdGNC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SpeedBar, ExtCtrls, ucDialgs, StdCtrls, uSagClasses, Globals, uSagEstacion,
  ToolEdit, RXDBCtrl, Mask, DBCtrls, DB, dbtables, Buttons, uUtils, ZipMstr;

type
  TfrmCdGNC = class(TForm)
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
    edAptas: TDBEdit;
    edRechazadas: TDBEdit;
    edCantActual: TDBEdit;
    edPRACTUAL: TDBEdit;
    edULACTUAL: TDBEdit;
    edCantProximo: TDBEdit;
    edPRPROX: TDBEdit;
    edULPROX: TDBEdit;
    edAnuladas: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    srcCD: TDataSource;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    edAnoActual: TEdit;
    edAnoProximo: TEdit;
    Label10: TLabel;
    Bevel1: TBevel;
    SpeedItem1: TSpeedItem;
    procedure btnSalirClick(Sender: TObject);
    procedure btnImpCDClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnManCDClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edCantActualExit(Sender: TObject);
    procedure edCantProximoExit(Sender: TObject);
    procedure SpeedItem1Click(Sender: TObject);
  private
    { Private declarations }
    fDatos_CD : TDatos_CDGNC;
    fAnuladas : TAnuladasGNC;
    DatosOK : boolean;
    archObleas, archCD : string;
    fObleas : tObleas_GNC;
    procedure InsertarCD (aDatos: string);
    procedure InsertarObleas (aDatos: string);        
    procedure ActualizaObleas( aAno, aObleaInicial, aObleaFinal, Zona, Planta, Cantidad: string);
    function CDYaImportado(Zona, Planta, Fecha : string):boolean;
    function ValidatePost:boolean;
    function Descomprimir(aZipFile : string):boolean;
    procedure ImportarCD(archivo : string);
    procedure ImportarObleas(archivo : string);

  public
    { Public declarations }
  end;

  procedure generateCDGNC;

var
  frmCdGNC: TfrmCdGNC;

implementation

uses
  UFTMP, Math, DateUtil, ufPlanillaSemanal;

resourcestring
  CAPTION = 'Controles Diarios GNC';

{$R *.dfm}

procedure generateCDGNC;
begin
        with TfrmCdGNC.Create(Application) do
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


procedure TfrmCdGNC.btnSalirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmCdGNC.btnImpCDClick(Sender: TObject);
begin
  if pnDatosCd.Visible then pnDatosCd.Visible := false;
  if OpenDialog1.Execute then
  begin

    if not Descomprimir(OpenDialog1.FileName) then exit;

    BDAG.StartTransaction;
    ImportarCD(OpenDialog1.FileName);
    ImportarObleas(OpenDialog1.FileName);
    if DatosOK then
    begin
      BDAG.Commit;
      MessageDlg(CAPTION, 'CD importado con éxito', mtInformation, [mbOk], mbOk, 0);
    end
    else
    begin
      BDAG.Rollback;
      MessageDlg(CAPTION, 'El CD no ha sido importado', mtError, [mbOk], mbOk, 0);
      DatosOK := true;
    end;
    DeleteFile(archObleas);
    DeleteFile(archCD);
  end;

end;

procedure TfrmCdGNC.FormCreate(Sender: TObject);
begin
  fDatos_CD := TDatos_CDGNC.CreatebyRowID(BDAG,'');
  fAnuladas := TAnuladasGNC.CreatebyRowID(BDAG,'');
  fDatos_CD.Open;
  fAnuladas.Open;
  srcCD.DataSet := fDatos_CD.DataSet;
  DatosOK := true;  
end;

procedure TfrmCdGNC.InsertarCD(aDatos: string);
begin
   if not CDYaImportado(copy(aDatos,1,2),copy(aDatos,3,2),copy(aDatos,5,10)) then
   begin
       try
          fDatos_CD.Append;
          fDatos_CD.ValueByName[FIELD_ZONA] := copy(aDatos,1,2) ;
          fDatos_CD.ValueByName[FIELD_PLANTA] := copy(aDatos,3,2) ;
          fDatos_CD.ValueByName[FIELD_FECHA] := copy(aDatos,5,10) ;
          fDatos_CD.ValueByName[FIELD_CANTAPTAS] :=copy(aDatos,15,6) ;
          fDatos_CD.ValueByName[FIELD_CANTRECHAZADAS] :=copy(aDatos,21,6) ;
          fDatos_CD.ValueByName[FIELD_CANTACTUAL]:=copy(aDatos,27,6) ;
          fDatos_CD.ValueByName[FIELD_PRACTUAL] := copy(aDatos,33,11);
          fDatos_CD.ValueByName[FIELD_ULACTUAL] := copy(aDatos,44,11);
          fDatos_CD.ValueByName[FIELD_CANTPROX] := copy(aDatos,55,6);
          fDatos_CD.ValueByName[FIELD_PRPROX] := copy(aDatos,61,11) ;
          fDatos_CD.ValueByName[FIELD_ULPROX] :=copy(aDatos,72,11) ;
          fDatos_CD.ValueByName[FIELD_CANTANULADAS] := copy(aDatos,83,6);
          fDatos_CD.ValueByName[FIELD_FECHMODI] := datetostr(date);
          fDatos_CD.Post;
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

procedure TfrmCdGNC.ActualizaObleas( aAno, aObleaInicial, aObleaFinal, Zona, Planta, cantidad: string);
begin
      with tquery.create(nil) do
       try
         DatabaseName := bdag.DatabaseName;
         SessionName := bdag.SessionName;
         sql.Add('ALTER SESSION SET NLS_DATE_FORMAT = ''DD/MM/YYYY''');
         ExecSQL;
         sql.Clear;
         sql.Add(format('UPDATE OBLEAS SET ESTADO = ''C'', FECHCONS = ''%S'' WHERE ANO = %S AND NUMERO BETWEEN %S AND %S AND IDPLANTA = GETPLANTA(%S,%S)',[copy(fDatos_CD.ValueByName[FIELD_FECHA],1,10), aAno,copy(aObleaInicial,1,7), copy(aObleaFinal,1,7),Zona,Planta]));
         ExecSQL;
         close;
       finally
         free;
       end;
end;


function TfrmCdGNC.CDYaImportado(Zona, Planta, Fecha: string): boolean;
begin
  result := true;
  with tquery.create(nil) do
    try
      DatabaseName := BDAG.DatabaseName;
      SessionName := BDAG.SessionName;
      sql.Add(format('SELECT * FROM DATOS_CD WHERE ZONA = %S AND PLANTA = %S AND TO_CHAR(FECHA,''DD/MM/YYYY'') = ''%S''',[Zona, Planta, Fecha]));
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

procedure TfrmCdGNC.btnManCDClick(Sender: TObject);
begin
  pnDatosCd.Visible := true;
  edZona.SetFocus;
  if BDAG.InTransaction then BDAG.Rollback;
  BDAG.StartTransaction;
  fDatos_CD.Append;
end;

procedure TfrmCdGNC.btnAceptarClick(Sender: TObject);
begin
  if ValidatePost then
  begin
   if not CDYaImportado(edzona.Text,edPlanta.Text,datetostr(edFecha.date)) then
   begin
     try
       fDatos_CD.Post;
       if edAnoActual.Text <> '' then
         ActualizaObleas(edAnoActual.text,formatoceros(strtoint(copy(fDatos_CD.ValueByName[FIELD_PRACTUAL],1,7)),7),formatoceros(strtoint(copy(fDatos_CD.ValueByName[FIELD_ULACTUAL],1,7)),7),fDatos_CD.ValueByName[FIELD_ZONA],fDatos_CD.ValueByName[FIELD_PLANTA],fDatos_CD.ValueByName[FIELD_CANTACTUAL]);
       if edAnoProximo.Text <> '' then
       ActualizaObleas(edAnoProximo.text,formatoceros(strtoint(copy(fDatos_CD.ValueByName[FIELD_PRPROX],1,7)),7),formatoceros(strtoint(copy(fDatos_CD.ValueByName[FIELD_ULPROX],1,7)),7),fDatos_CD.ValueByName[FIELD_ZONA],fDatos_CD.ValueByName[FIELD_PLANTA],fDatos_CD.ValueByName[FIELD_CANTPROX]);
       BDAG.Commit;
       messageDlg(CAPTION, 'CD importado con éxito', mtInformation, [mbOk], mbOk, 0);
       pnDatosCd.Visible := false;
       except
         on E: Exception do
         begin
            MessageDlg(CAPTION,Format('No se ha podido importar el CD por: %s. ',[E.message]), mtError, [mbOk], mbOk, 0);
            BDAG.Rollback;
         end;
       end;
   end
   else
   begin
     MessageDlg(CAPTION, 'Este CD ya se ha importado en la base con anterioridad', mtError, [mbOk], mbOk, 0);
   end;
  end;
end;

procedure TfrmCdGNC.btnCancelarClick(Sender: TObject);
begin
  fDatos_CD.Cancel;
  fDatos_CD.Append;
end;

procedure TfrmCdGNC.FormDestroy(Sender: TObject);
begin
  if BDAG.InTransaction then BDAG.Rollback;
end;

procedure TfrmCdGNC.FormKeyPress(Sender: TObject; var Key: Char);
begin
        if key = ^M
        then begin
            Perform(WM_NEXTDLGCTL,0,0);
            Key := #0
        end
end;

procedure TfrmCdGNC.edCantActualExit(Sender: TObject);
begin
  if (edPRACTUAL.text <> '') AND (edCantActual.Text <> '') then
  begin
    if strtoInt(copy(edPRACTUAL.Text,1,8)) <> 0 then
      fDatos_CD.ValueByName[FIELD_ULACTUAL] := inttostr(strtoInt(copy(edPRACTUAL.Text,1,8))+strToInt(edCantActual.Text)-1)+copy(edPRACTUAL.text,9,3)
    else
      fDatos_CD.ValueByName[FIELD_ULACTUAL] := edPRACTUAL.Text;
  end;
end;

procedure TfrmCdGNC.edCantProximoExit(Sender: TObject);
begin
  if (edPRPROX.text <> '') AND (edCantProximo.Text <> '') then
  begin
    if strtoInt(copy(edPRPROX.Text,1,8)) <> 0 then
      fDatos_CD.ValueByName[FIELD_ULPROX] := inttostr(strtoInt(copy(edPRPROX.Text,1,8))+strToInt(edCantProximo.Text)-1)+copy(edPRPROX.text,9,3)
    else
      fDatos_CD.ValueByName[FIELD_ULPROX] := edPRPROX.Text;
  end;
end;

function TfrmCdGNC.ValidatePost: boolean;
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
  If edAptas.Text = '' then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la cantidad de Revisiones Aptas',mtError,[mbOK],mbOK,0);
        edAptas.SetFocus;
        exit;
  end;
  If edRechazadas.Text = '' then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la cantidad de Revisiones Rechazadas',mtError,[mbOK],mbOK,0);
        edRechazadas.SetFocus;
        exit;
  end;
  If edAnuladas.Text = '' then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la cantidad de Obleas Rechazadas',mtError,[mbOK],mbOK,0);
        edAnuladas.SetFocus;
        exit;
  end;
  if (edCantActual.text <> '') then
  begin
     If edAnoActual.Text = '' then
     begin
        MessageDlg(CAPTION,'Se debe ingresar el año actual',mtError,[mbOK],mbOK,0);
        edAnoActual.SetFocus;
        exit;
     end;
     If edPRACTUAL.Text = '' then
     begin
        MessageDlg(CAPTION,'Se debe ingresar la primer oblea del año actual',mtError,[mbOK],mbOK,0);
        edPRACTUAL.SetFocus;
        exit;
     end;
  end;
  if (edCantProximo.text <> '') then
  begin
     If edAnoProximo.Text = '' then
     begin
        MessageDlg(CAPTION,'Se debe ingresar el año actual',mtError,[mbOK],mbOK,0);
        edAnoProximo.SetFocus;
        exit;
     end;
     If edPRPROX.Text = '' then
     begin
        MessageDlg(CAPTION,'Se debe ingresar la primer oblea del año actual',mtError,[mbOK],mbOK,0);
        edPRPROX.SetFocus;
        exit;
     end;
  end;

  if (edCantProximo.text = '') and  (edCantActual.text = '') then
  begin
        MessageDlg(CAPTION,'Se debe ingresar al menos una oblea',mtError,[mbOK],mbOK,0);
        edCantActual.SetFocus;
        exit;
  end;

  result := true;
end;

procedure TfrmCdGNC.SpeedItem1Click(Sender: TObject);
begin
  GeneratePlanillaSemanalGNC;
end;

function TfrmCdGNC.Descomprimir(aZipFile: string): boolean;
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

procedure TfrmCdGNC.ImportarCD(archivo: string);
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

procedure TfrmCdGNC.ImportarObleas(archivo: string);
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

procedure TfrmCdGNC.InsertarObleas(aDatos: string);
var
  ArrayVar : Variant;
begin
       try
          fObleas := tObleas_GNC.CreateByNumero(bdag,copy(aDatos,16,8));
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
                  if (ValueByName[FIELD_ESTADO] = ESTADO_STOCK) then
                  begin
                    ValueByName[FIELD_ESTADO] := copy(aDatos,24,1);
                    ValueByName[FIELD_FECHCONS] := copy(aDatos,5,10);
                    ValueByName[FIELD_EJERCICI] := trim(copy(aDatos,25,4));
                    ValueByName[FIELD_CODINSPE] := trim(copy(aDatos,29,6));
                    post;
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

end.
