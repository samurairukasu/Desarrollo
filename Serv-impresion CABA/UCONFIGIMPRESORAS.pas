unit UConfigImpresoras;

interface

uses
  Windows,
  winspool,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  ExtCtrls,
  StdCtrls,
  Buttons,
  ComCtrls,
  Spin,
  UTiposPr,
  USAGPrinters,
  UBinResource;

type

  TCambio = (cFacturasA, cFacturasB, cInformes, cCertificados, cMediciones, cTAmarilla, cInformesGNC);


  TFormCfgU = class(TForm)
    TabTrabajos: TTabControl;
    Image1: TImage;
    Bevel1: TBevel;
    Label7: TLabel;
    Label1: TLabel;
    LImpresora: TComboBox;
    LBandeja: TComboBox;
    LPapel: TComboBox;
    GroupBox8: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    SpinCDirectas: TSpinEdit;
    SpinCDiferido: TSpinEdit;
    CheckApaisadas: TCheckBox;
    GroupBox10: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    btnMarxDef: TSpeedButton;
    SpinMSuperior: TSpinEdit;
    SpinMIzquierdo: TSpinEdit;
    BtnCancelar: TBitBtn;
    BtnTest: TBitBtn;
    BtnAceptar: TBitBtn;
    procedure TabTrabajosChange(Sender: TObject);
    procedure TabTrabajosChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure LImpresoraClick(Sender: TObject);
    procedure LImpresoraKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnTestClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnAceptarClick(Sender: TObject);
    procedure SpinCDirectasExit(Sender: TObject);
    procedure SpinCDiferidoExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TabTrabajosExit(Sender: TObject);
    procedure SpinMSuperiorExit(Sender: TObject);
    procedure SpinMIzquierdoExit(Sender: TObject);
    procedure btnMarxDefClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    function ActualizadasImpresoras : Boolean;
    procedure RestaurarContexto (const Tipo : TCambio);
    procedure GuardarContexto (const Tipo : TCambio);
    function  ContextosDistinto (const A, B : tContexto) : boolean;
    function CambioInterfaz : boolean;
    function GuardadosContextosEnRegistro : boolean;
    function MargenIzqPorDefecto(const h: THandle) : integer;
    function MargenSupPorDefecto(const h: THandle) : integer;

    {$ifdef ver90}

    function DeviceCapabilities; external winspool name 'DeviceCapabilitiesA';
    {$endif}



  public
    ContextosDeEntrada, ContextosDeSalida : tContextos;
    bPulsadoAceptar : Boolean;
  end;

var
  FormCfgU: TFormCfgU;

implementation

uses
   UCDialgs,
   USucesos,
   Printers,
   QuickRpt,
   IniFiles,
   ULogs,
   UTest,
   qrprntr,
   UsuperRegistry,
   UVERSION,
   UMensCts;

{$R *.DFM}
const
  FICHERO_ACTUAL = 'UConfigImpresoras';

{$ifdef ver90}
  winspool = 'winspool.drv';

function DeviceCapabilities; external winspool name 'DeviceCapabilitiesA';
{$endif}




procedure InitError(Msg: String);
begin
    MessageDlg('Error en la Inicialización',Msg,mtError,[mbOK],mbOK,0);
    If Assigned(fAnomalias)
    then fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,Msg);
    InitializationError := TRUE;
    Application.Terminate;
end;


(*
function GetPDPaperBins: SetOfTQRBin;
var
   PaperBins : TPaperBinsSupported;
   DCResult : array[0..16] of word;
   I : integer;
   J : TQRBin;
   Count : integer;
   vFDevice : PChar;
   vFDriver : PChar;
   vFPort : PChar;
   vDeviceMode : THandle;
   vFHandle:     THandle;
{$ifndef win32}
   DeviceCapabilities : TDeviceCapabilities;
   FDeviceHandle : THandle;
   DriverName: array[0..255] of Char;
{$endif}
begin
   result := [];
   GetMem (vFDevice, 255); GetMem (vFDriver, 255); GetMem (vFPort, 255);
   Printer.GetPrinter (vFDevice,vFDriver, vFPort, vFHandle);
   FillChar(PaperBins,SizeOf(PaperBins),0);
   Fillchar(DCResult,SizeOf(DCResult),0);
{$ifndef win32}
   StrCat(StrCopy(DriverName, FDriver), '.DRV');
   FDeviceHandle := LoadLibrary(DriverName);
   if FDeviceHandle <= 16 then FDeviceHandle := 0;
   if FDeviceHandle <> 0
   then begin
     @DeviceCapabilities := GetProcAddress(FDeviceHandle, 'DeviceCapabilities');
     if assigned(DeviceCapabilities)
     then Count:=DeviceCapabilities(FDevice, FPort, DC_BINS, @DCResult, nil)
     else Count:=0;
   end;
   if FDeviceHandle<>0 then FreeLibrary(FDeviceHandle);
{$else}
   Count:=DeviceCapabilities(vFDevice, vFPort, DC_BINS, @DCResult, nil);
{$endif}
   for I:=0 to Count-1 do
     for J:=First to Last do
       if cQRBinTranslate[J]=DCResult[I]
       then include(result,j)
end;

 *)
function Bandejas(const iIndice: integer; ABandejas: TStrings) : boolean;
var
  ib : TQrBin;
  ConjuntoBandejas : Set Of TQrBin;
begin
ABandejas.Clear;
with ABandejas do
  begin
    QrPrinter.PrinterIndex := iIndice;
//P Esto tiene que ser el conjunto de bandejas de la impresora
//    ConjuntoBandejas := QRPrinter.OutputBins;
    ConjuntoBandejas := UBinResource.fOutPutBin(iIndice);
    for ib := First to Last do
      if ib in ConjuntoBandejas then
        Add(SBandejas[ib]);
   end;
   result := True;
end;

procedure TFormCfgU.LImpresoraClick(Sender: TObject);
begin
  Bandejas((Sender as TComboBox).ItemIndex, Lbandeja.Items);

  if LBandeja.Items.Count >= 1
  then LBandeja.ITemIndex := 0
  else LBandeja.ITemIndex := -1;
end;

procedure TFormCfgU.FormActivate(Sender: TObject);
var
  i : Integer;
begin

  for i := low(ContextosDeEntrada) to high(ContextosDeEntrada) do
  begin
    ContextosDeEntrada[i] := ImpresorasEnPampa[i].Contexto;
    ContextosDeSalida[i] := ContextosDeEntrada[i];
  end;

  RestaurarContexto(cFacturasA);

end;

function TFormCfgu.MargenIzqPorDefecto(const h: THandle) : integer;
var
  m, tm, rn : Integer;
begin
   m := GetDeviceCaps(h,PHYSICALOFFSETX);
   tm := GetDeviceCaps(h,VERTSIZE);
   rn := GetDeviceCaps(h,VERTRES);
   result := Round((m * tm) / rn);
end;

function TFormCfgu.MargenSupPorDefecto(const h: THandle) : integer;
var
  m, tm, rn : Integer;
begin
  m := GetDeviceCaps(h,PHYSICALOFFSETY);
  tm := GetDeviceCaps(h,HORZSIZE);
  rn := GetDeviceCaps(h,HORZRES);
  result := Round((m * tm) / rn);
end;


procedure TFormCfgU.RestaurarContexto (const Tipo : TCambio);
begin
  SPinCDiferido.Enabled := False;

  LPapel.Enabled := False;
  LPapel.Items.Clear;

  LBandeja.Items.Clear;
  LImpresora.Items.Clear;

  CheckApaisadas.Enabled := False;
  CheckApaisadas.State := cbUnChecked;

  with ContextosDeSalida[Ord(Tipo) +1] do
  begin
    if Tipo = cInformes
    then SPinCDiferido.Enabled := True;

    LPapel.Items.Add(sPapeles[qrpPapel]);
    LPapel.ItemIndex := 0;

    SpinCDirectas.Value  := iCopiasDirectas;
    SpinCDiferido.Value  := iCopiasDiferidas;
    SpinMSuperior.Value  := iMargenSuperior;
    SpinMIzquierdo.Value := iMargenIzquierdo;

    if (qroOrientacion = poLandsCape) or  ((Ord(Tipo) + 1) = IMPRESORA_PARA_CERTIFICADOS)
    then CheckApaisadas.State := cbGrayed;


    try
      // Toma siempre los valores del sistema
      with TPrinter.Create do
      try
        LImpresora.Items := Printers;
        LImpresora.ItemIndex := LImpresora.Items.IndexOf(sNombre);
        if LImpresora.ItemIndex = -1
        then raise Exception.CreateFmt('No se encuentra la impresora %s',[sNombre]);
      finally
        free;
      end;

      Bandejas(LImpresora.ItemIndex, LBandeja.Items);
           //p hay que tomar todas las bandejas de la impresora
      LBandeja.ItemIndex := LBandeja.Items.IndexOf(SBandejas[qrbBandeja]);
    except
      on E: Exception do
        MessageDlg('Configuración de Impresoras',
                   format('La impresora %s ha desaparecido del sistema: %s',[sNombre, E.message]),
                   mtError, [mbOk], mbOk, 0);
    end;
  end;
end;

procedure TFormCfgU.GuardarContexto (const Tipo : TCambio);
begin
with ContextosDeSalida[ord(Tipo) +1] do
  begin
    sNombre := LImpresora.Text;
    iCopiasDiferidas := SpinCDiferido.Value;
    iCopiasDirectas := SpinCDirectas.Value;
    iMargenIzquierdo := SpinMIzquierdo.Value;
    iMargenSuperior :=  SpinMSuperior.Value;
    qrbBandeja :=  BandejaPorNombre(LBandeja.Text);
    if (ord(Tipo) + 1) = IMPRESORA_PARA_CERTIFICADOS then
      begin
        qroOrientacion := poLandscape;
        qrpPapel := C5 {Tiene que ser C5}
      end
    else
      begin
      qroOrientacion := poPortrait;
        if ((ord(Tipo) + 1) = IMPRESORA_PARA_INFORMES) or ((ord(Tipo) + 1) = IMPRESORA_PARA_MEDICIONES)
            or ((ord(Tipo) + 1) = IMPRESORA_PARA_INFORMESGNC) then
          qrpPapel := A4
        else
        if (ord(Tipo) + 1) = IMPRESORA_PARA_TAMARILLA then
          qrpPapel := C5
        else
          qrpPapel := Letter
      end;
  end;
end;


function TFormCfgU.ContextosDistinto (const A, B : tContexto) : boolean;
begin
 {$B-}
 result := (A.sNombre <> B.sNombre)
           or (A.iCopiasDiferidas <> B.iCopiasDiferidas)
           or (A.iCopiasDirectas <> B.iCopiasDirectas)
           or (A.iMargenIzquierdo <> B.iMargenIzquierdo)
           or (A.iMargenSuperior <> B.iMargenSuperior)
           or (A.qrbBandeja <> B.qrbBandeja)
           or (A.qrpPapel  <> B.qrpPapel)
           or (A.qroOrientacion <> B.qroOrientacion)
end;

procedure TFormCfgU.TabTrabajosChange(Sender: TObject);
begin
  case (Sender as TTabControl).TabIndex of
    0: RestaurarContexto(cFacturasA);
    1: RestaurarContexto(cFacturasB);
    2: RestaurarContexto(cInformes);
    3: RestaurarContexto(cCertificados);
    4: RestaurarContexto(cMediciones);
    5: RestaurarContexto(cTAmarilla);
    6: RestaurarContexto(cInformesGNC);
  end;
end;

procedure TFormCfgU.TabTrabajosChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
{$IFDEF TRAZAS}
  fTrazas.PonAnotacion(TRAZA_USUARIO,0,FICHERO_ACTUAL, 'HA CAMBIANDO DE FICHA DE IMPRESORA');
  fTrazas.PonComponente(TRAZA_FORM,0,FICHERO_ACTUAL,self);
{$ENDIF}
  case (Sender as TTabControl).TabIndex of
    0: GuardarContexto(cFacturasA);
    1: GuardarContexto(cFacturasB);
    2: GuardarContexto(cInformes);
    3: GuardarContexto(cCertificados);
    4: GuardarContexto(cMediciones);
    5: GuardarContexto(cTAmarilla);
    6: GuardarContexto(cInformesGNC);    
  end;
end;


procedure TFormCfgU.LImpresoraKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
const
 BARRA_ESPACIADORA =  32;
begin
if Key = BARRA_ESPACIADORA then
 begin
   if (Sender is TComboBox) then
     if Boolean(SendMessage(TComboBox(Sender).Handle, CB_GETDROPPEDSTATE, 0, 0)) then
        SendMessage(TComboBox(Sender).Handle, CB_SHOWDROPDOWN, 0, 0)
     else SendMessage(TComboBox(Sender).Handle, CB_SHOWDROPDOWN, 1, 0);
   Key := 0;
 end;
end;


procedure TFormCfgU.BtnTestClick(Sender: TObject);
begin
{$IFDEF TRAZAS}
  fTrazas.PonAnotacion(TRAZA_USUARIO,0,FICHERO_ACTUAL, 'HA PULSADO VER LAS IMPRESORAS UTILIES DEL SISTEMA (TEST)');
{$ENDIF}
   with TFormTest.Create(self) do
   try
     Showmodal;
   finally
     Free;
   end;
end;

procedure TFormCfgU.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    SendMessage(Handle,WM_NEXTDLGCTL,0, 0);
    Key := #0;
  end;
end;


function TFormCfgU.GuardadosContextosEnRegistro: boolean;
var
  I : Integer;
begin
result := TRUE;
with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    try
      for i := low(ContextosImpresoras) to high(ContextosImpresoras) do
        begin
          if not OpenKeySec(PRINTER_KEY+'\'+C_REGISTRO[i],FALSE,KEY_SET_VALUE)then
            InitError('Los Registros de la impresora estan Bloqueados');
          with ImpresorasEnPampa[i].Contexto do
            begin
              WriteInteger(DIRECTAS_VALUE,iCopiasDirectas);
              WriteInteger(DIFERIDAS_VALUE,iCopiasDiferidas);
              WriteInteger(SUPERIOR_VALUE,iMargenSuperior);
              WriteInteger(IZQUIERDO_VALUE,iMargenIzquierdo);
              WriteString(NAME_VALUE,sNombre);
              WriteString(BANDEJA_VALUE, sBandejas[qrbBandeja]);
              if I = IMPRESORA_PARA_INFORMES then
                WriteInteger (DIFERIDAS_VALUE, iCopiasDiferidas);
            end;
        end;
    except
      on E: exception do
        InitError(Format('No se escribieron correctamente los parametros por: %S', [E.message]));
    end;
  finally
   Free;
  end;
end;

function TFormCfgU.ActualizadasImpresoras : Boolean;
{ Se pulsa al aceptar, hay que comprobar que estén disponibles }
var
  i : Integer;
begin
  result := True;
  try
    // Cambio todos para ver si es correcta la configuración elegida)
    for i := low(ContextosDeSalida) to high(ContextosDeSalida) do
       ImpresorasEnPampa[i].CambiaContexto(ContextosDeSalida[i]);
  except
    on E : Exception do
    begin
       result := true;
       fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL,'El conjunto de impresoras seleccionado no es valido por: ' + E.message);
     end;
  end;
end;

procedure TFormCfgU.BtnAceptarClick(Sender: TObject);
begin
{$IFDEF TRAZAS}
  fTrazas.PonAnotacion(TRAZA_USUARIO,0,FICHERO_ACTUAL, 'HA PULSADO GUARDAR LA CONFIGURACIÓN ELEGIDA');
  fTrazas.PonComponente(TRAZA_FORM,0,FICHERO_ACTUAL,self);
{$ENDIF}

{$B-}
    TestOcupacionesPorImpresoraOk;
    if  (not ActualizadasImpresoras) {or (not OcupacionesPorImpresoraOK(nil))} then
    begin
      MessageDlg('Servidor de Impresión', LITERAL_CONJUNTO_IMPRESORAS_NO_VALIDO, mtInformation, [mbOk], mbOk, 0) ;
        if GuardadosContextosEnRegistro then
      begin
        ModalResult := mrOk;
        bPulsadoAceptar := True;
        VarGlobs.bConfiguracionTemporal := False;
      end;
      end
    else begin
      if GuardadosContextosEnRegistro then
      begin
        ModalResult := mrOk;
        bPulsadoAceptar := True;
        VarGlobs.bConfiguracionTemporal := False;
      end
      else begin
        ModalResult := mrOk;
        MessageDlg('Servidor de Impresión', LITERAL_ERROR_ENTRADA_SALIDA, mtError, [mbOk], mbOk, 0);
      end;
    end;
end;

procedure TFormCfgU.SpinCDirectasExit(Sender: TObject);
begin
  with (Sender as TSpinEdit) do
    if Length(TSpinEdit(Sender).Text) = 0 then
      TSpinEdit(Sender).Value := ContextosDeEntrada[TabTrabajos.TabIndex + 1].iCopiasDirectas;
end;

procedure TFormCfgU.SpinCDiferidoExit(Sender: TObject);
begin
  with (Sender as TSpinEdit) do
    if Length(TSpinEdit(Sender).Text) = 0 then
      TSpinEdit(Sender).Value := ContextosDeEntrada[TabTrabajos.TabIndex + 1].iCopiasDiferidas;
end;

function TFormCfgU.CambioInterfaz : boolean;
var
  i : Integer;
begin
  result := False;
  for i:= low(ContextosDeEntrada) to high(ContextosDeEntrada) do
    if ContextosDistinto (ContextosDeEntrada[i], ContextosDeSalida[i])
    then begin
      result := True;
      break;
    end;
end;

procedure TFormCfgU.FormCloseQuery(Sender: TObject; var CanClose: Boolean);

var
  iresultado : integer;
begin
  if not bPulsadoAceptar then
  begin
    if CambioInterfaz then
    begin
      iresultado := MessageDlg('Servidor de Impresión','ż Desea salir sin guardar la Configuración de Impresoras ?',mtWarning,[mbYes,mbNo],mbNo,0);
      if iresultado = mrNo then CanClose := False
      else CanClose := True;
    end
    else CanClose := True;
  end
  else CanClose := True;
end;

procedure TFormCfgU.TabTrabajosExit(Sender: TObject);
begin
  case (Sender as TTabControl).TabIndex of
    0: GuardarContexto(cFacturasA);
    1: GuardarContexto(cFacturasB);
    2: GuardarContexto(cInformes);
    3: GuardarContexto(cCertificados);
    4: GuardarContexto(cMediciones);  
    5: GuardarContexto(cTAmarilla);
    6: GuardarContexto(cInformesGNC);
  end;
end;

procedure TFormCfgU.SpinMSuperiorExit(Sender: TObject);
begin
  with (Sender as TSpinEdit) do
    if Length(TSpinEdit(Sender).Text) = 0 then
      TSpinEdit(Sender).Value := ContextosDeEntrada[TabTrabajos.TabIndex + 1].iMargenSuperior;

end;

procedure TFormCfgU.SpinMIzquierdoExit(Sender: TObject);
begin
  with (Sender as TSpinEdit) do
    if Length(TSpinEdit(Sender).Text) = 0 then
      TSpinEdit(Sender).Value := ContextosDeEntrada[TabTrabajos.TabIndex + 1].iMargenIzquierdo;
end;


procedure TFormCfgU.btnMarxDefClick(Sender: TObject);
var
  i : integer;
begin
{$IFDEF TRAZAS}
  fTrazas.PonAnotacion(TRAZA_USUARIO,0,FICHERO_ACTUAL, 'HA PULSADO CARGAR MÁRGENES POR DEFECTO EN LA CONFIGURACION DE IMPRESORAS');
{$ENDIF}
  try
    i := LImpresora.Items.IndexOf(LImpresora.Text);
    if i = -1 then raise Exception.Create('');
    Printer.PrinterIndex := i;
    SpinMIzquierdo.Value := MargenIzqPorDefecto(Printer.Handle);
    SpinMSuperior.Value := MargenSupPorDefecto(Printer.Handle);
  except
    SpinMIzquierdo.Value := ContextosDeEntrada[TabTrabajos.TabIndex + 1].iMargenIzquierdo;
    SpinMSuperior.Value :=  ContextosDeEntrada[TabTrabajos.TabIndex + 1].iMargenSuperior;
  end;
end;

procedure TFormCfgU.BtnCancelarClick(Sender: TObject);
begin
{$IFDEF TRAZAS}
  fTrazas.PonAnotacion(TRAZA_USUARIO,0,FICHERO_ACTUAL, 'HA PULSADO CANCELAR LA CONFIGURACION DE IMPRESORAS');
{$ENDIF}

end;

procedure TFormCfgU.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {If ((Key = Ord(#19)) and (ssAlt in Shift))
    then begin
        //configurar los timers
        With TFrmConfigTimers.Create(Application) do
        Try
            Showmodal;
        Finally
            Free;
        end;
    end;   }
end;

end.


