unit UPrinter;

interface

uses
  UThread, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, UCDialgs,
  Grids, DBGrids, Buttons, StdCtrls, UTiposPr, ExtCtrls, UMensCts, SQLExpr,
  Menus, RXShell, XPMan;

const
  FICHERO_ACTUAL = 'UPrinter.pas';

type
  EDatosVariosMal = class(Exception);

  TFrmPrinters = class(TForm)
    DBGridSolicitudes: TDBGrid;
    Panel1: TPanel;
    BtnRefrescar: TSpeedButton;
    BtnAnular: TSpeedButton;
    BtnBuscar: TSpeedButton;
    BtnSalir: TSpeedButton;
    MainMenu1: TMainMenu;
    MnuConfiguracion: TMenuItem;
    MnuSucesos: TMenuItem;
    Opciones1: TMenuItem;
    BtnArrancar: TSpeedButton;
    BtnParar: TSpeedButton;
    BtnSucesos: TSpeedButton;
    BtnOpciones: TSpeedButton;
    BtnConfiguracion: TSpeedButton;
    BtnFacturaA: TSpeedButton;
    BtnFacturaB: TSpeedButton;
    Nmeros1: TMenuItem;
    FacturasA1: TMenuItem;
    FacturasB1: TMenuItem;
    Panel2: TPanel;
    PanelRecibidas_: TPanel;
    BtnAbajo: TSpeedButton;
    BtnArriba: TSpeedButton;
    Panel4: TPanel;
    PanelEstado: TPanel;
    PanelRecibidas: TPanel;
    MenuPop: TPopupMenu;
    Refrescar1: TMenuItem;
    Anular1: TMenuItem;
    Buscar1: TMenuItem;
    Arrancar1: TMenuItem;
    Parar1: TMenuItem;
    N1: TMenuItem;
    Configuracin1: TMenuItem;
    Test1: TMenuItem;
    N2: TMenuItem;
    Salir1: TMenuItem;
    Mrgenes1: TMenuItem;
    RxTrayIcon1: TRxTrayIcon;
    Label1: TLabel;
    bTestForms: TButton;
    Visualizaciondetrabajos1: TMenuItem;
    Limpiezadedatos1: TMenuItem;
    XPManifest1: TXPManifest;
    EdtBuscar: TEdit;
    Sucesos1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure BtnArribaClick(Sender: TObject);
    procedure BtnAbajoClick(Sender: TObject);
    procedure DBGridSolicitudesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure HabilitarBotones;
    procedure Estado;
    procedure BtnConfiguracionClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure BtnSalirClick(Sender: TObject);
    procedure EdtBuscarKeyPress(Sender: TObject; var Key: Char);
    procedure EdtBuscarExit(Sender: TObject);
    procedure BtnAnularClick(Sender: TObject);
    procedure BtnBuscarClick(Sender: TObject);
    procedure Refresco;
    procedure BtnRefrescarClick(Sender: TObject);
    procedure BtnArrancarClick(Sender: TObject);
    procedure BtnPararClick(Sender: TObject);
    procedure FacturasA1Click(Sender: TObject);
    procedure FacturasB1Click(Sender: TObject);
    procedure Test1Click(Sender: TObject);
    procedure AsignadaAlgunaPorDefectoEnCreacion;
    procedure Mrgenes1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bTestFormsClick(Sender: TObject);
    procedure Visualizaciondetrabajos1Click(Sender: TObject);
    procedure Limpiezadedatos1Click(Sender: TObject);
    procedure Sucesos1Click(Sender: TObject);
    procedure BtnSucesosClick(Sender: TObject);
  Public
    Procedure UpdatePrintJob(var msg:tmessage);message WM_SERVIMPRE;
    Procedure SetOpenForms(Sender: TObject);
  Private
    Thread: TProcessThread;
    fProcessing: boolean;
    fStarted: Boolean;
    fWaiting: Integer;
  end;

var
  FrmPrinters: TFrmPrinters;

implementation


{$R *.DFM}

uses
  Globals,
  UModDat,
  UENDAPPLICATIONFORM,
  Printers,
  UVERSION,
  USUCESOS,
  ULOGS,
  UOPTIONS,
  UINICIO,
  UTEST,
  UTESTMARGENES,
  USAGPRINTERS,
  UCONFIGIMPRESORAS,
  ULimpiezaVarEntorno;




 const

   FILE_NAME = 'UPrinter.pas';

  { ESTADOS DEL SERVIDOR DE IMPRESION }
    ESTADO_PARADA = ' DETENIDO.';
    ESTADO_ACTIVANDOSE = ' ACTIVÁNDOSE';
    ESTADO_PROCESANDO = ' PROCESANDO SOLICITUD';
    ESTADO_REALIZANDOSE = ' REALIZÁNDOSE';

  { INCIDENCIAS OCURRIDAS AL INTENTAR ANULAR UN TRABAJO }
  INCIDENCIA_BORRADA   = 1;
  INCIDENCIA_BLOQUEADA = 2;
  INCIDENCIA_BD        = 3;
  INCIDENCIA_RARA      = 4;

 Var

    bActivandose : boolean = TRUE;

    procedure InitError(Msg: String);
    begin
        MessageDlg('Error en la Inicialización',Msg,mtError,[mbOK],mbOK,0);
        if Assigned(fAnomalias)
        then fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FILE_NAME,Msg);
        InitializationError := TRUE;
        Application.Terminate;
    end;

procedure EnableSysCloseItem(Handle: HWND; Enable: Boolean);
const
   Flags : array[Boolean] of Integer = (MF_GRAYED, MF_ENABLED);
var
  SysMenu : HMENU;
begin
  SysMenu := GetSystemMenu(Handle, false);
  EnableMenuItem(SysMenu, SC_CLOSE, MF_BYCOMMAND or Flags[Enable]);
end;


    procedure TFrmPrinters.FormShow(Sender: TObject);
    begin
        try
            if bActivandose then
            begin
                bActivandose := FALSE;
                Top := -7000;

                if (FindWindow(nil,APP_TITLE) <> 0) then
                  InitError('Ya existe una copia del programa en ejecución')
                else
                  InitLogs;
                Application.Title:=APP_TITLE;
                if InitializationError then
                  raise
                  Exception.Create('Error iniciando');

                Caption := NOMBRE_PROYECTO+' '+VERSION;
                with TFrmInicio.Create(Application) do
                try
                {$IFDEF TRAZAS}
                fTrazas.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'%S', [LITERAL_VERSION]);
                {$ENDIF}
                Application.ProcessMessages;
                PStatus.Caption := 'Iniciando el servidor de impresión.';
                Show;

                Progreso.StepIt;
                Sleep(50);
                PStatus.Caption := 'Comprobando configuración del sistema.';
                Application.ProcessMessages;

                TestOfBugs;
                Progreso.StepIt;
                Sleep(50);
                if InitializationError then
                raise Exception.Create('Error iniciando');

                TestOfLicencia;
                Progreso.StepIt;
                Sleep(50);
                if InitializationError then
                raise Exception.Create('Error iniciando');
                Application.ProcessMessages;

                PStatus.Caption := 'Iniciando sesión en el servidor.';
                TestOfBD('','','',false);
                if InitializationError then
                raise Exception.Create('Error iniciando');
                Progreso.stepit;
                Sleep(50);

                PStatus.Caption := 'Iniciando impresoras del sistema.';
                TestOfContextos;
                if InitializationError then
                raise Exception.Create('Error iniciando');
                Progreso.StepIt;
                Application.ProcessMessages;
                Sleep(10);

////////////////////////////////////////////////////////////////////////////////////////////////////
                PStatus.Caption := 'Borrando Directorios Temporales.';
                if ObtenerVariableEntorno then
                  BorrarArchivosTEMP;
                Progreso.StepIt;
                Application.ProcessMessages;
////////////////////////////////////////////////////////////////////////////////////////////////////

                PStatus.Caption := 'Creando Impresoras.';
                TestCreadasImpresoras;
                if InitializationError then
                raise Exception.Create('Error iniciando');
                Progreso.StepIt;
                Sleep(10);

                Application.ProcessMessages;

                PStatus.Caption := 'Asignando Bandejas de Impresión.';
                TestOcupacionesPorImpresoraOk;
                if InitializationError then
                raise Exception.Create('Error iniciando');
                Progreso.StepIt;
                Application.ProcessMessages;
                Sleep(20);

                DatosImpresio := TDatosImpresion.CreateByABD(MyBD);
                if InitializationError then
                raise Exception.Create('Error iniciando');

                //inicialización de las tablas globales del sistema
                InitAplicationGlobalTables;
                MyBD.ExecuteDirect('ALTER SESSION SET NLS_DATE_FORMAT = ''DD/MM/YYYY HH24:MI:SS''');
                Progreso.Position:=100;
                Sleep(20);

                Estado;
                AsignadaAlgunaPorDefectoEnCreacion;
                // Proceso de escucha de las alrmas de BD
                Thread:= TProcessThread.Create (MyBd,Self,2);
                BtnArrancarClick(Sender);

                finally
                  Free
                end;

                Application.ProcessMessages;
            end
        except
            on E: Exception do
                Application.Terminate;
        end;
    end;


function SinBlancos (const s : string) : string;
var
  i : integer;
  ss : string;
begin
  ss := '';
  for i:= 1 to length(s) do
    if s[i] <> ' ' then ss := ss + s[i];
  result := ss;
end;

procedure TFrmPrinters.Refresco;
begin
    RefrescarQry(DatosImpresio.QrySolicitudesEnTTRABAIMPRE);
    HabilitarBotones;
end;

procedure TFrmPrinters.HabilitarBotones;
const
  BD = 11;
  CAPTION_PANEL = 'SOLICITUDES DE IMPRESIÓN RECIBIDAS: ';
var
 i : integer;
 bActivado : Boolean;
begin
 try
 { EVALUACION CORTA DE IZQUIERDA A DERECHA }

   PanelRecibidas.Caption := CAPTION_PANEL + IntToStr(DatosImpresio.QrySolicitudesEnTTRABAIMPRE.RecordCount);

   bActivado := (DatosImpresio.QrySolicitudesEnTTRABAIMPRE.RecordCount > 0);

   for i := 0 to ComponentCount - 1 do
     if (Components[i] is TSpeedButton) then
     begin
       if TSpeedButton(Components[i]).Tag = BD then
         TSpeedButton(Components[i]).Enabled := bActivado;
     end;


   Refrescar1.Enabled := bActivado;
   Buscar1.Enabled := bActivado;
   Anular1.Enabled := bActivado;

 except
   on E : Exception do
   begin
     {Desahcer las posibles modificaciones }

     for i := 0 to ComponentCount - 1 do
       if (Components[i] is TSpeedButton) then
       begin
         if TSpeedButton(Components[i]).Tag = BD then
            TSpeedButton(Components[i]).Enabled := False;
       end;
     PanelRecibidas.Caption := CAPTION_PANEL + ' 0 ';
     fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'NO SE PUEDE REFRESCAR POR: ' + E.message);
   end;
 end;
end;

procedure TFrmPrinters.Estado;
begin
   with DatosImpresio do
    {$B-}
    if fStarted then
    begin
        if not fProcessing then
        begin
            PanelEstado.Font.Color := clGreen;
            PanelEstado.Caption := ESTADO_REALIZANDOSE;
            BtnArrancar.Enabled := False;
            Arrancar1.Enabled := False;
            BtnParar.Enabled := True;
            Parar1.Enabled := True;
        end
        else begin
            PanelEstado.Font.Color := clYellow;
            PanelEstado.Caption := ESTADO_PROCESANDO;
        end
    end
    else begin
          PanelEstado.Caption := ESTADO_PARADA;
          PanelEstado.Font.Color := clRed;

          BtnArrancar.Enabled := True;
          Arrancar1.Enabled := True;

          BtnParar.Enabled := False;
          Parar1.Enabled := False;
    end;
end;

procedure TFrmPrinters.BtnArribaClick(Sender: TObject);
begin
{$IFDEF TRAZAS}
   fTrazas.PonAnotacion(TRAZA_USUARIO,1,FICHERO_ACTUAL,'HA ELEGIDO IR UN TRABAJO ARRIBA');
{$ENDIF}
  EdtBuscar.Visible := False;
  RegistroArriba(DatosImpresio.QrySolicitudesEnTTRABAIMPRE);
end;

procedure TFrmPrinters.BtnAbajoClick(Sender: TObject);
begin
  EdtBuscar.Visible := False;
  RegistroAbajo(DatosImpresio.QrySolicitudesEnTTRABAIMPRE);
end;

procedure TFrmPrinters.DBGridSolicitudesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   RecorrePorTecla (DatosImpresio.QrySolicitudesEnTTRABAIMPRE, Key);
end;



procedure TFrmPrinters.FormDeactivate(Sender: TObject);
begin
  //DatosImpresion.TimerRefrescoSolicitudes.Enabled := False;
  EdtBuscar.Visible := False;
end;

procedure TFrmPrinters.BtnSalirClick(Sender: TObject);
begin
     {$IFDEF TRAZAS}
     fTrazas.PonAnotacion(TRAZA_USUARIO,1,FICHERO_ACTUAL,'HA ELEGIDO SALIR DEL PROGRAMA');
     {$ENDIF}

    if (PanelEstado.Caption <> ESTADO_PARADA) then
    begin
        MessageDlg('Servidor de Impresión',
               'EL Proceso de impresión se está realizando, por favor, pare el servidor antes de salir.',
               mtInformation, [mbOk], mbOk, 0);
    end
    else begin
        EdtBusCar.Visible := False;
        //DatosImpresion.TimerRefrescoSolicitudes.Enabled := False;
        FinishAplicationGlobalTables;
        Enabled:=False;
        APplication.ProcessMessages;
        With TEndApplicationForm.Create(Application) do
        Try
            Show;
            Thread.Finaliza;
            while not Thread.EndReached do Application.ProcessMessages;
            Thread.Free;
            Thread := nil;
            Hide;
        Finally
            Free;
        end;
        Enabled:=True;
        Close;
    end;
end;

procedure TFrmPrinters.EdtBuscarKeyPress(Sender: TObject; var Key: Char);
const
  PULSACION_INTRO = #13;
  PULSACION_ANULADA = #0;
begin
  if not (key in ['a'..'z','A'..'Z','0'..'9',#8,#13]) then
  key:=#8;
  if key = PULSACION_INTRO then begin
    perform(WM_NEXTDLGCTL,0,0);    key := PULSACION_ANULADA;
  end;
end;

procedure TFrmPrinters.EdtBuscarExit(Sender: TObject);
const
  MATRICULA = 'PATENTE';
begin
  if ((length(EdtBuscar.Text) > 0)) then
  begin
    Refresco;
    EdtBuscar.Text := SinBlancos(EdtBuscar.Text);
    if not ExisteRegistro(DatosImpresio.QrySolicitudesEnTTRABAIMPRE, MATRICULA, EdtBuscar.Text) then
    begin
      MessageDlg('Solución a la busqueda', 'No encuentro la matricula solicitada ' + EdtBuscar.Text, mtInformation, [mbOk], mbOk, 0);
      IrPrimerRegistro(DatosImpresio.QrySolicitudesEnTTRABAIMPRE);
    end;
  end;
  EdtBuscar.Visible := False;
end;





procedure TFrmPrinters.BtnAnularClick(Sender: TObject);
var
  iUnMotivo, iCodTraba: integer;
begin
{$IFDEF TRAZAS}
   fTrazas.PonAnotacion(TRAZA_USUARIO,1,FICHERO_ACTUAL,'HA ELEGIDO ANULAR UN TRABAJO');
{$ENDIF}
  EdtBuscar.Visible := False;
  if (PanelEstado.Caption <> ESTADO_PARADA) then
    showmessage('Anulación de trabajos', LITERAL_MENSAJE_ANULACION)
  else begin
    iUnMotivo := 0;
    With TSQLQuery.Create(self) do
      Begin
      if (DBGridSolicitudes.DataSource.DataSet.RecordCount <> 0) then
        Begin
        Close;
        SQL.Clear;
        SQLConnection:=MyBD;
        SQL.CommaText:=('SELECT CODTRABA FROM TTRABAIMPRE WHERE PATENTE = :PATENTE');
        Params[0].AsString:=DBGridSolicitudes.Fields[0].AsString;
        Open;
        iCodTraba:=Fields[0].AsInteger;
        end;
      end;

    if not DatosImpresio.CanceladaSolicitudOk(iCodTraba,iUnMotivo) then
    begin
      case iUnMotivo of

        INCIDENCIA_BORRADA  : ShowMessage('ANULACION FALLIDA',LITERAL_ERROR_SERVIDOR_IMPRESION_SOLICITUD_BORRADA);
        INCIDENCIA_BLOQUEADA: ShowMessage('ANULACION FALLIDA',LITERAL_ERROR_SERVIDOR_IMPRESION_SOLICITUD_BLOQUEADA);
        INCIDENCIA_BD       : ShowMessage('ANULACION FALLIDA',LITERAL_ERROR_SERVIDOR_IMPRESION_PROBLEMAS_BD);
        INCIDENCIA_RARA     : ShowMessage('ANULACION FALLIDA',LITERAL_ERROR_SERVIDOR_IMPRESION_PROBLEMAS_RAROS);
      end;
    end
  end;
  Refresco;
end;

procedure TFrmPrinters.BtnBuscarClick(Sender: TObject);
begin
{$IFDEF TRAZAS}
   fTrazas.PonAnotacion(TRAZA_USUARIO,1,FICHERO_ACTUAL,'HA ELEGIDO BUSCAR UN TRABAJO');
{$ENDIF}

  Refresco;
  EdtBuscar.Visible := True;
  EdtBuscar.SetFocus;
end;

procedure TFrmPrinters.BtnRefrescarClick(Sender: TObject);
begin
{$IFDEF TRAZAS}
   fTrazas.PonAnotacion(TRAZA_USUARIO,1,FICHERO_ACTUAL,'HA ELEGIDO REFRESCAR LA LISTA DE TRABAJOS');
{$ENDIF}
  EdtBuscar.Visible := False;
  Refresco;
end;

procedure TFrmPrinters.BtnArrancarClick(Sender: TObject);
begin
    EdtBuscar.Visible := False;
    //DatosImpresion.TimerAtencionSolicitudes.Enabled := True;
    //DatosImpresion.TimerImpresionPreparados.Enabled := True;
    //VarGlobs.bPararProceso := False;
    fStarted:=True;
    fProcessing:=false;
    RxTrayIcon1.aNIMATED:=TRUE;
    Estado;
    DatosImpresio.TimerRefrescoSolicitudesaTimer(Self);
    Application.ProcessMessages;
    DatosImpresio.TimerAtencionSolicitudesaTimer(Self);
    Application.ProcessMessages;
    DatosImpresio.TimerImpresionPreparadosaTimer(Self);
    Application.ProcessMessages;
    fWaiting:=0;
end;

procedure TFrmPrinters.BtnPararClick(Sender: TObject);
begin
  EdtBuscar.Visible := False;
  //VarGlobs.bPararProceso := True;
  fStarted:=False;
  Estado;  
  RxTrayIcon1.aNIMATED:=fALSE;
end;

procedure TFrmPrinters.BtnConfiguracionClick(Sender: TObject);
begin
{$IFDEF TRAZAS}
   fTrazas.PonAnotacion(TRAZA_USUARIO,1,FICHERO_ACTUAL,'HA ELEGIDO CONFIGURAR LAS IMPRESORAS EN EL SERVIDOR DE IMPRESIÓN');
{$ENDIF}
  try
    FormCfgU := nil;
    EdtBuscar.Visible := False;
    {$B-}
    if (PanelEstado.Caption <> ESTADO_PARADA) then
      showmessage('Configuración de Impresoras', LITERAL_MENSAJE_CONFIGURACION)
    else
      begin
      //DatosImpresion.TimerRefrescoSolicitudes.Enabled := False; { Se para para no incordiar }
       Application.CreateForm(TFormCfgU, FormCfgU);
      if not VarGlobs.bMostrarMensajeConfiguracion then
        FormCfgU.Caption := 'Configuración POSIBLE de Impresoras'
      else
      if VarGlobs.bConfiguracionTemporal then
        FormCfgU.Caption := 'Configuración TEMPORAL de Impresoras'
      else
        FormCfgU.Caption := 'Configuración de Impresoras';
      FormCfgU.ShowModal;
    end;
  finally
    FormCfgU.Free;
    FormCfgU := nil;
    //DatosImpresion.TimerRefrescoSolicitudes.Enabled := True; { Se activa siempre para mayor seguridad }
    TestOcupacionesPorImpresoraOk;
  end;
end;

procedure TFrmPrinters.FacturasA1Click(Sender: TObject);
begin
{$IFDEF TRAZAS}
   fTrazas.PonAnotacion(TRAZA_USUARIO,1,FICHERO_ACTUAL,'HA ELEGIDO EDITAR EL NUMERO DE FACTURA A');
{$ENDIF}

  EdtBuscar.Visible := False;
  if (PanelEstado.Caption <> ESTADO_PARADA) then
    showmessage('Numeración de Facturas y Notas de Crédito de tipo A', LITERAL_MENSAJE_CAMBIO_NUMERO)
 //P else ActualizarNumeroFacturas(F_A);
end;

procedure TFrmPrinters.FacturasB1Click(Sender: TObject);
begin
{$IFDEF TRAZAS}
   fTrazas.PonAnotacion(TRAZA_USUARIO,1,FICHERO_ACTUAL,'HA ELEGIDO EDITAR EL NUMERO DE FACTURA B');
{$ENDIF}
  EdtBuscar.Visible := False;
  if (PanelEstado.Caption <> ESTADO_PARADA) then
    showmessage('Numeracíón de Facturas y Notas de Crédito de tipo B', LITERAL_MENSAJE_CAMBIO_NUMERO)
 //P else ActualizarNumeroFacturas(F_B);
end;

procedure TFrmPrinters.Test1Click(Sender: TObject);
begin
{$IFDEF TRAZAS}
   fTrazas.PonAnotacion(TRAZA_USUARIO,1,FICHERO_ACTUAL,'HA ELEGIDO REALIZAR EL TEST DE IMPRESORAS DEL SISTEMA');
{$ENDIF}

  Application.CreateForm(TFormTest, FormTest);
  FormTest.Showmodal;
  FormTest.Free;
end;


// Pregunta si alguna fue asignada por defecto, avisa.
procedure TFrmPrinters.AsignadaAlgunaPorDefectoEnCreacion;
const
  EOLN = #13;
  RC = #10;
  TAB = #9;
var
  i: integer;
  sMensaje : string;
  bMostrarMensaje : boolean;
begin
  bMostrarMensaje := False;
  try
    with VarGlobs do
    begin
      sMensaje := 'Las impresoras: ' + EOLN + RC;
      for i := low(ImpresorasEnPampa) to high(ImpresorasEnPampa) do
        if ImpresorasEnPampa[i].Defecto then
        begin
           bMostrarMensaje := True;
           if i = IMPRESORA_PARA_FACTURAS_A then sMensaje := sMensaje + format(' * [%.20s] encargada de la impresión de Facturas y Notas de Crédito de tipo A. %s%s',[ImpresorasEnPampa[i].Nombre,EOLN,RC])
             else if i = IMPRESORA_PARA_FACTURAS_B then sMensaje := sMensaje + format(' * [%.20s] encargada de la impresión de Facturas y Notas de Crédito de tipo B. %s%s',[ImpresorasEnPampa[i].Nombre,EOLN,RC])
               else if i = IMPRESORA_PARA_INFORMES then sMensaje := sMensaje + format(' * [%.20s] encargada de la impresión de Informes de Inspección. %s%s',[ImpresorasEnPampa[i].Nombre,EOLN,RC])
                 else if i = IMPRESORA_PARA_CERTIFICADOS then sMensaje := sMensaje + format(' * [%.20s] encargada de la impresión de Certificados de Inspección. %s%s',[ImpresorasEnPampa[i].Nombre,EOLN,RC])
                   else if i = IMPRESORA_PARA_TAMARILLA then sMensaje := sMensaje + format(' * [%.20s] encargada de la impresión de Tarjetas Amarillas. %s%s',[ImpresorasEnPampa[i].Nombre,EOLN,RC])
                     else if i = IMPRESORA_PARA_INFORMESGNC then sMensaje := sMensaje + format(' * [%.20s] encargada de la impresión de Fichas Técnicas. %s%s',[ImpresorasEnPampa[i].Nombre,EOLN,RC])
         end;
           sMensaje := sMensaje + 'No existen y en su lugar se ha asignado la impresora por defecto del sistema.' + EOLN + RC;
           sMensaje := sMensaje + '¿ Desea configurar ahora las impresoras ?';
      {$B-}
      if (bMostrarMensaje) and
         (MessageDlg('Servidor de Impresión', sMensaje, mtWarning, [mbYes, mbNo], mbYes, 0) = mrYes) then
      begin
        BtnPararClick(self);
        Application.ProcessMessages;
        while PanelEstado.Caption <> ESTADO_PARADA do Application.ProcessMessages;
        VarGlobs.bConfiguracionTemporal := True;
        BtnConfiguracionClick(Self);
      end;
    end;
  except
    on E : Exception do
    begin
      fIncidencias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL,'Error al comprobar las asignaciones por defecto: ' + E.message);
    end;
  end;
end;

procedure TFrmPrinters.Mrgenes1Click(Sender: TObject);
begin
{$IFDEF TRAZAS}
    fTrazas.PonAnotacion(TRAZA_USUARIO,1,FICHERO_ACTUAL,'HA ELEGIDO REALIZAR EL TEST DE MARGENES');
{$ENDIF}
    try
    FrmTestMargenes := Nil;
    EdtBuscar.Visible := False;
    If not Assigned(FrmTestMargenes)
    then
        Application.CreateForm(TFrmTestMargenes, FrmTestMargenes);
        while FrmTestMargenes.MiDialogo.Execute do
        begin
        FrmTestMargenes.QrTest.Print;
        end;
    finally
    FrmTestMargenes.Free;
    FrmTestmargenes := nil;
  end;

end;

procedure TFrmPrinters.FormCreate(Sender: TObject);
begin
     //inicalización de la aplicación
     Thread := nil;
     fStarted:=False;
     fProcessing:=False;
     fWaiting:=0;
     Screen.OnActiveFormChange:=SetOpenForms;
     EnableSysCloseItem(FrmPrinters.Handle, false);
end;

procedure TFrmPrinters.FormDestroy(Sender: TObject);
var
    i: Integer;
begin
    if Assigned(Thread)
    then Thread.Finaliza;

    for i := low(ImpresorasEnPampa) to high(ImpresorasEnPampa) do
        if Assigned(ImpresorasEnPampa[i])
        then ImpresorasEnPampa[i].Free;

    if Assigned(DatosImpresio)
    then DatosImpresio.Free;

    if Assigned(MyBD)
    then begin
        MyBD.Close;
        MyBD.Free;
    end;

end;

Procedure TFrmPrinters.UpdatePrintJob(var msg:tmessage);
var
   EstadoAct,Actualizacion: Integer;
begin
//recoge los mensajes de actualización del servidor de impresión
If fStarted then
  begin
    Inc(fWaiting);
    //while fProcessing do Application.ProcessMessages;
      fProcessing:=True;
      Estado;
      Try
        EstadoAct:=msg.LParam;//estado en el que esta el trabajo actualizado
        Actualizacion:=msg.WParam;//1.insercion,2.actualizacion,3.borrado
        If DatosImpresio<>nil then
          begin
            Case Actualizacion of
              1:begin  //insercion
                DatosImpresio.TimerRefrescoSolicitudesaTimer(Self);
                Application.ProcessMessages;
                DatosImpresio.TimerAtencionSolicitudesaTimer(Self);
                Application.ProcessMessages;
                end;
              2:begin  //Actualizacion
                Case EstadoAct of
                  1:begin //nuevo
                    DatosImpresio.TimerRefrescoSolicitudesaTimer(Self);
                    Application.ProcessMessages;
                    DatosImpresio.TimerAtencionSolicitudesaTimer(Self);
                    Application.ProcessMessages;
                    end;
                  2:begin //papel
                    DatosImpresio.TimerRefrescoSolicitudesaTimer(Self);
                    Application.ProcessMessages;
                    end;
                  3:begin //preparar
                    DatosImpresio.TimerImpresionPreparadosaTimer(Self);
                    Application.ProcessMessages;
                    DatosImpresio.TimerRefrescoSolicitudesaTimer(Self);
                    Application.ProcessMessages;
                    end;
                  4,5:begin  //imprmir y final de trabajo
                    //DatosImpresion.TimerImpresionPreparadosaTimer(Self);
                    DatosImpresio.TimerRefrescoSolicitudesaTimer(Self);
                    Application.ProcessMessages;
                    end;
                  end;
                  end;
                3:begin  //Borrado
                  DatosImpresio.TimerRefrescoSolicitudesaTimer(Self);
                  end;
            end;
          end;
      Finally
        LiberarMemoria;
        fProcessing:=False;
        Dec(fWaiting);If fWaiting<0 then
          fWaiting:=0;
        While fWaiting=0 do
          begin
            If DatosImpresio.QrySolicitudesEnTTRABAIMPRE.RecordCount>0 Then
              begin
                DatosImpresio.TimerRefrescoSolicitudesaTimer(Self);
                Application.ProcessMessages;
                DatosImpresio.TimerAtencionSolicitudesaTimer(Self);
                Application.ProcessMessages;
                DatosImpresio.TimerImpresionPreparadosaTimer(Self);
                Application.ProcessMessages;
                Break;
              End
            else
              Break;
            If Not FStarted then
              Break;
          end;
        Estado;
      end;
  end
else
  begin
    LiberarMemoria;
    DatosImpresio.TimerRefrescoSolicitudesaTimer(Self);
    Application.ProcessMessages;
  end;
end;

Procedure TFrmPrinters.SetOpenForms(Sender: TObject);
begin
    //muestra los forms creados en cada momento
    if False
    then begin
        Try
            Label1.Caption:='F.'+IntToStr(Screen.FormCount);
        Except
            Label1.Caption:='F.0';
        end;
    end;
end;


procedure TFrmPrinters.bTestFormsClick(Sender: TObject);
var
    i: Integer;
    SL: TStringList;
begin
    SL:=TStringlist.Create;
    Try
        For i:=0 to Screen.FormCount-1 do
        begin
            Sl.Add(Screen.Forms[i].ClassName);
        end;
        FrmSucesos.MemoErrores.Lines.Assign(SL);
        BtnSucesosClick(Sender);
    Finally
        SL.Free;
    end;
end;

procedure TFrmPrinters.Visualizaciondetrabajos1Click(Sender: TObject);
begin
{$IFDEF TRAZAS}
   fTrazas.PonAnotacion(TRAZA_USUARIO,1,FICHERO_ACTUAL,'HA ELEGIDO SELECCIONAR OPCIONES DE VISUALIZACION');
{$ENDIF}
  EdtBuscar.Visible := False;
  Application.CreateForm(TFrmControlPrinters,FrmControlPrinters);
  FrmControlPrinters.ShowModal;
end;

procedure TFrmPrinters.Limpiezadedatos1Click(Sender: TObject);
begin
if (PanelEstado.Caption <> ESTADO_PARADA) then
    begin
    MessageDlg('Servidor de Impresión','El Proceso de impresión se está realizando, por favor, pare el servidor antes de salir.',
    mtInformation, [mbOk], mbOk, 0);
    end
  else
  try
   With TSQLQuery.Create(nil) do
      Begin
        Close;
        SQL.Clear;
        SQLConnection:=MyBD;
        SQL.CommaText:=('SELECT COUNT(CODTRABA) FROM TTRABAIMPRE');
        Open;
        If (Fields[0].AsInteger <> 0) then
          Begin
          if MessageDlg('Confirmacion','Esta seguro que desea limpiar los datos de la'+#10#13+
                        'cola de impresion?',mtWarning,[mbYes, mbNo],mbNo,0) = mrYes then
            try
            SQL.Clear;
            SQL.CommaText:=('TRUNCATE TABLE TTRABAIMPRE');
            ExecSQL;
            Refresco;
            FrmSucesos.MemoErrores.Lines.Add('Se ha truncado la tabla TTRABAIMPRE');
            {$IFDEF TRAZAS}
            fTrazas.PonAnotacion(TRAZA_USUARIO,1,FICHERO_ACTUAL,'SE TRUNCO LA TABLA TTABAIMPRE');
            {$ENDIF}
            ShowMessage('Servidor de Impresion','Se han limpiado los datos con exito!!');
            except
              Begin
                ShowMessage('Servidor de Impresion','Se ha producido un error intentando'+#10#13+
                        'limpiar los datos de la cola de impresion.');
                {$IFDEF TRAZAS}
                FrmSucesos.MemoErrores.Lines.Add('No se ha podido truncadar la tabla TTRABAIMPRE');
                fTrazas.PonAnotacion(TRAZA_USUARIO,1,FICHERO_ACTUAL,'ERROR INTENTANDO TRUNCAR LA TABLA TTABAIMPRE');
                {$ENDIF}
              end;
            end;
          end
        else
        ShowMessage('Servidor de Impresion','No hay datos para limpiar!!');
      end;
   Except
    on E: Exception do
      ShowMessage('Error',E.Message);
   end;
end;

procedure TFrmPrinters.Sucesos1Click(Sender: TObject);
begin
BtnSucesosClick(Sender);
end;

procedure TFrmPrinters.BtnSucesosClick(Sender: TObject);
begin
{$IFDEF TRAZAS}
fTrazas.PonAnotacion(TRAZA_USUARIO,1,FICHERO_ACTUAL,'HA ELEGIDO VER LOS SUCESOS EN EL SERVIDOR DE IMPRESIÓN');
{$ENDIF}
EdtBuscar.Visible := False;
FrmSucesos.Show;
end;

end.//Final de la unidad


