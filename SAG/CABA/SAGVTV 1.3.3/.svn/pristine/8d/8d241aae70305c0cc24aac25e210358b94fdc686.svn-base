unit GenerateResumenDiarioADM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, SqlExpr, Provider, DBClient, USAGESTACION, SpeedBar, ExtCtrls,
  StdCtrls, Mask, DBCtrls, Buttons, RXLookup, ComCtrls, ComObj, DBXpress,
  FMTBcd, Grids, DBGrids, RXDBCtrl;

type
  TResumenDiarioADM = class(TForm)
    Bevel_MP: TBevel;
    TAutosMP: TStaticText;
    TMotosMP: TStaticText;
    Cantidad_Autos_MP: TEdit;
    Cantidad_Motos_MP: TEdit;
    ImporteAutoMP: TLabeledEdit;
    IVAAutoMP: TLabeledEdit;
    IIBBAutoMP: TLabeledEdit;
    MontoTotalAutoMP: TLabeledEdit;
    ImporteMotoMP: TLabeledEdit;
    IVAMotoMP: TLabeledEdit;
    IIBBMotoMP: TLabeledEdit;
    MontoTotalMotoMP: TLabeledEdit;
    BevelMP: TBevel;
    StaticText1: TStaticText;
    Bevel_EP: TBevel;
    TAutoEP: TStaticText;
    TMotoEP: TStaticText;
    Cantidad_Autos_EP: TEdit;
    Cantidad_Motos_EP: TEdit;
    ImporteAutoEP: TLabeledEdit;
    IVAAutoEP: TLabeledEdit;
    IIBBAutoEP: TLabeledEdit;
    MontoTotalAutoEP: TLabeledEdit;
    ImporteMotoEP: TLabeledEdit;
    IVAMotoEP: TLabeledEdit;
    IIBBMotoEP: TLabeledEdit;
    MontoTotalMotoEP: TLabeledEdit;
    BevelEP: TBevel;
    StaticText6: TStaticText;
    TPagos: TStaticText;
    TServiciosPrestados: TStaticText;
    BevelTotalGeneral: TBevel;
    TotalGlobal: TStaticText;
    BevelGlobal: TBevel;
    TAutosGlobal: TStaticText;
    TMotosGlobal: TStaticText;
    Cantidad_Autos_Global: TEdit;
    Cantidad_Motos_Global: TEdit;
    ImporteAutosGlobal: TLabeledEdit;
    IVAAutosGlobal: TLabeledEdit;
    IIBBAutosGlobal: TLabeledEdit;
    MontoAutosGlobal: TLabeledEdit;
    ImporteMotosGlobal: TLabeledEdit;
    IVAMotosGlobal: TLabeledEdit;
    IIBBMotosGlobal: TLabeledEdit;
    MontoMotosGlobal: TLabeledEdit;
    TServiciosPendientes: TStaticText;
    Bevel_ServiciosPendientesMP: TBevel;
    SBarPrincipal: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    BExcel: TSpeedItem;
    SBBusqueda: TSpeedItem;
    SBSalir: TSpeedItem;
    MP: TStaticText;
    StaticText2: TStaticText;
    Bevel_ServiciosPrestadosMP: TBevel;
    MPAutosServPrestadosCantidad: TEdit;
    MPMotosServPrestadosCantidad: TEdit;
    EPAutosServPrestadosCantidad: TEdit;
    EPMotosServPrestadosCantidad: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    StaticText4: TStaticText;
    MPTotalServPrestadosCantidad: TEdit;
    EPTotalServPrestadosCantidad: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    StaticText3: TStaticText;
    StaticText5: TStaticText;
    MPAutosServPendientesCantidad: TEdit;
    MPMotosServPendientesCantidad: TEdit;
    EPAutosServPendientesCantidad: TEdit;
    EPMotosServPendientesCantidad: TEdit;
    StaticText7: TStaticText;
    MPTotalServPendientesCantidad: TEdit;
    EPTotalServPendientesCantidad: TEdit;
    EPAutosServPrestadosCash: TEdit;
    EPMotosServPrestadosCash: TEdit;
    EPTotalServPrestadosCash: TEdit;
    MPAutosServPrestadosCash: TEdit;
    MPMotosServPrestadosCash: TEdit;
    MPTotalServPrestadosCash: TEdit;
    StaticText8: TStaticText;
    StaticText9: TStaticText;
    MPAutosServPendientesCash: TEdit;
    MPMotosServPendientesCash: TEdit;
    MPTotalServPendientesCash: TEdit;
    EPAutosServPendientesCash: TEdit;
    EPMotosServPendientesCash: TEdit;
    EPTotalServPendientesCash: TEdit;
    StaticText10: TStaticText;
    StaticText11: TStaticText;
    StaticText12: TStaticText;
    Bevel1: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    TTAutosServCantidad: TEdit;
    TTMotosServCantidad: TEdit;
    StaticText15: TStaticText;
    TTotalServCantidad: TEdit;
    TTAutosServCash: TEdit;
    TTMotosServCash: TEdit;
    TTotalServCash: TEdit;
    StaticText16: TStaticText;
    StaticText13: TStaticText;
    SQLConnection1: TSQLConnection;
    SQLQuery1: TSQLQuery;
    DSTServiciosPrestados: TDataSource;
    sdsQTServiciosPrestados: TSQLDataSet;
    dspQTServiciosPrestados: TDataSetProvider;
    QTServiciosPrestados: TClientDataSet;
    OpenDialog: TOpenDialog;
    Flotas: TEdit;
    StaticText14: TStaticText;
    NoFlotas: TEdit;
    StaticText17: TStaticText;
    DBServiciosPrestados: TRxDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SBBusquedaClick(Sender: TObject);
    procedure BExcelClick(Sender: TObject);
    procedure SBSalirClick(Sender: TObject);
    procedure OnOpen (Sender: TObject);
    procedure OnClose (Sender: TObject);
  private
    procedure DoResumenDiario;
    Procedure ExportacionExcelGeneral;
  public
    bErrorCreando : boolean;
    NombreEstacion, NumeroEstacion, DateIni, DateFin, ServiciosPrestados, ServiciosPendientes: string;
    function PutEstacion : string;
  end;

  procedure GenerateResumenDiario;

var
  ResumenDiarioADM: TResumenDiarioADM;

implementation

{$R *.dfm}

uses
   UCDIALGS,
   ULOGS,
   UGETDATES,
   UFTMP,
   GLOBALS,
   UUTILS,
   USAGVARIOS,
   UFSERVICIOSPRESTADOS;

  resourcestring
      FICHERO_ACTUAL = 'GenerateResumenDiarioADM';

  procedure GenerateResumenDiario;
    BEGIN
      with TResumenDiarioADM.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                If not GetDates(DateIni,DateFin) then Exit;
                Caption := Format('Servicios Prestados. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                FTmp.Temporizar(TRUE,FALSE,'Servicios Prestados', 'Generando el Resumen Diario.');

                Application.ProcessMessages;

                DoResumenDiario;

                QTServiciosPrestados.Open;

                FTmp.Temporizar(FALSE,FALSE,'', '');
                ShowModal;
            except
                on E: Exception do
                begin
                    FTmp.Temporizar(FALSE,FALSE,'', '');
                    Application.ProcessMessages;
                    FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Servicios Prestados - Resumen Diario Cancelado por: %s', [E.message]);
                    MessageDlg('Generación de Resumen Diario.', 'El Resumen Diario no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)
                end
            end
        finally
            Free;
            Application.ProcessMessages;
        end;
    END;

    function TResumenDiarioADM.PutEstacion : string;
    begin
        NombreEstacion := fVarios.NombreEstacion;
        NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
        Result := NumeroEstacion + ' ' + NombreEstacion;
    end;

    procedure TResumenDiarioADM.DoResumenDiario;
    begin
        DeleteTable(MyBD, 'TTMPREPORTEADM');

        {agregamos el alter session porque sino saltaba error en el procedimiento al
         calcular la menor fecha}
        with tsqlquery.create(self) do       //
        try
          SQLConnection := mybd;
          sql.add('alter session set nls_date_format = ''DD/MM/YYYY HH24:MI:SS''');
          execsql;
        finally
          free;
        end;

        with TSQLStoredProc.Create(self) do
        try
            SQLConnection := MyBD;
            StoredProcName := 'PQ_REPORTE_ADM.DoReporteADM_V3';

            ParamByName('SERVICIOSPRESTADOS').Value := 0;
            ParamByName('SERVICIOSPENDIENTES').Value := 0;

            ParamByName('vFLOTAS').Value := 0;

            ParamByName('vAUTOSMP').Value := 0;
            ParamByName('vMOTOSMP').Value := 0;
            ParamByName('vAUTOSEP').Value := 0;
            ParamByName('vMOTOSEP').Value := 0;

            ParamByName('vImporteAutosMP').Value := 0;
            ParamByName('vImporteMotosMP').Value := 0;
            ParamByName('vImporteAutosEP').Value := 0;
            ParamByName('vImporteMotosEP').Value := 0;

            ParamByName('vIvaAutosMP').Value := 0;
            ParamByName('vIvaMotosMP').Value := 0;
            ParamByName('vIvaAutosEP').Value := 0;
            ParamByName('vIvaMotosEP').Value := 0;

            ParamByName('vIIBBAutosMP').Value := 0;
            ParamByName('vIIBBMotosMP').Value := 0;
            ParamByName('vIIBBAutosEP').Value := 0;
            ParamByName('vIIBBMotosEP').Value := 0;

            ParamByName('vServPresAutosMP').Value := 0;
            ParamByName('vServPresMotosMP').Value := 0;
            ParamByName('vServPresAutosEP').Value := 0;
            ParamByName('vServPresMotosEP').Value := 0;

            ParamByName('vServPresImporteAutosMP').Value := 0;
            ParamByName('vServPresImporteMotosMP').Value := 0;
            ParamByName('vServPresImporteAutosEP').Value := 0;
            ParamByName('vServPresImporteMotosEP').Value := 0;

            ParamByName('vServPendAutosMP').Value := 0;
            ParamByName('vServPendMotosMP').Value := 0;
            ParamByName('vServPendAutosEP').Value := 0;
            ParamByName('vServPendMotosEP').Value := 0;

            ParamByName('vServPendImporteAutosMP').Value := 0;
            ParamByName('vServPendImporteMotosMP').Value := 0;
            ParamByName('vServPendImporteAutosEP').Value := 0;
            ParamByName('vServPendImporteMotosEP').Value := 0;

            Prepared := true;
            ParamByName('FECHAINI').Value := DateIni;
            ParamByName('FECHAFIN').Value := DateFin;
            ExecProc;

            ServiciosPrestados:=ParamByName('SERVICIOSPRESTADOS').value;
            ServiciosPendientes:=ParamByName('SERVICIOSPENDIENTES').value;

            Flotas.Text:=ParamByName('vFLOTAS').value;

            NoFlotas.Text :=  ((ParamByName('vServPresAutosMP').Value)+(ParamByName('vServPresAutosEP').Value)+
                               (ParamByName('vServPendAutosMP').Value)+(ParamByName('vServPendAutosEP').Value)+
                               (ParamByName('vServPresMotosMP').Value)+(ParamByName('vServPresMotosEP').Value)+
                               (ParamByName('vServPendMotosMP').Value)+(ParamByName('vServPendMotosEP').Value)) - ParamByName('vFLOTAS').value;

            Cantidad_Autos_MP.Text := ParamByName('vAUTOSMP').value;
            Cantidad_Motos_MP.Text := ParamByName('vMOTOSMP').value;
            ImporteAutoMP.Text := ParamByName('vImporteAutosMP').value;
            ImporteMotoMP.Text := ParamByName('vImporteMotosMP').value;
            IVAAutoMP.Text := ParamByName('vIvaAutosMP').value;
            IVAMotoMP.Text := ParamByName('vIvaMotosMP').value;
            IIBBAutoMP.Text := ParamByName('vIIBBAutosMP').value;
            IIBBMotoMP.Text := ParamByName('vIIBBMotosMP').value;

            MontoTotalAutoMP.Text := (ParamByName('vImporteAutosMP').value)+(ParamByName('vIvaAutosMP').value)+(ParamByName('vIIBBAutosMP').value);
            MontoTotalMotoMP.Text := (ParamByName('vImporteMotosMP').value)+(ParamByName('vIvaMotosMP').value)+(ParamByName('vIIBBMotosMP').value);

            Cantidad_Autos_EP.Text := ParamByName('vAUTOSEP').value;
            Cantidad_Motos_EP.Text := ParamByName('vMOTOSEP').value;
            ImporteAutoEP.Text := ParamByName('vImporteAutosEP').value;
            ImporteMotoEP.Text := ParamByName('vImporteMotosEP').value;
            IVAAutoEP.Text := ParamByName('vIvaAutosEP').value;
            IVAMotoEP.Text := ParamByName('vIvaMotosEP').value;
            IIBBAutoEP.Text := ParamByName('vIIBBAutosEP').value;
            IIBBMotoEP.Text := ParamByName('vIIBBMotosEP').value;

            MontoTotalAutoEP.Text := (ParamByName('vImporteAutosEP').value)+(ParamByName('vIvaAutosEP').value)+(ParamByName('vIIBBAutosEP').value);
            MontoTotalMotoEP.Text := (ParamByName('vImporteMotosEP').value)+(ParamByName('vIvaMotosEP').value)+(ParamByName('vIIBBMotosEP').value);
            
            Cantidad_Autos_Global.Text := (ParamByName('vAUTOSMP').value)+(ParamByName('vAUTOSEP').value);
            Cantidad_Motos_Global.Text := (ParamByName('vMOTOSMP').value)+(ParamByName('vMOTOSEP').value);
            ImporteAutosGlobal.Text := (ParamByName('vImporteAutosMP').value)+(ParamByName('vImporteAutosEP').value);
            ImporteMotosGlobal.Text := (ParamByName('vImporteMotosMP').value)+(ParamByName('vImporteMotosEP').value);
            IVAAutosGlobal.Text := (ParamByName('vIvaAutosMP').value)+(ParamByName('vIvaAutosEP').value);
            IVAMotosGlobal.Text := (ParamByName('vIvaMotosMP').value)+(ParamByName('vIvaMotosEP').value);
            IIBBAutosGlobal.Text := (ParamByName('vIIBBAutosMP').value)+(ParamByName('vIIBBAutosEP').value);
            IIBBMotosGlobal.Text := (ParamByName('vIIBBMotosMP').value)+(ParamByName('vIIBBMotosEP').value);

            MontoAutosGlobal.Text := (ParamByName('vImporteAutosMP').value)+(ParamByName('vIvaAutosMP').value)+(ParamByName('vIIBBAutosMP').value)+
                                     (ParamByName('vImporteAutosEP').value)+(ParamByName('vIvaAutosEP').value)+(ParamByName('vIIBBAutosEP').value);
            MontoMotosGlobal.Text := (ParamByName('vImporteMotosMP').value)+(ParamByName('vIvaMotosMP').value)+(ParamByName('vIIBBMotosMP').value)+
                                     (ParamByName('vImporteMotosEP').value)+(ParamByName('vIvaMotosEP').value)+(ParamByName('vIIBBMotosEP').value);

            MPAutosServPrestadosCantidad.text := ParamByName('vServPresAutosMP').Value;
            MPMotosServPrestadosCantidad.text := ParamByName('vServPresMotosMP').Value;
            MPTotalServPrestadosCantidad.text :=(ParamByName('vServPresAutosMP').Value)+(ParamByName('vServPresMotosMP').Value);

            EPAutosServPrestadosCantidad.text := ParamByName('vServPresAutosEP').Value;
            EPMotosServPrestadosCantidad.text := ParamByName('vServPresMotosEP').Value;
            EPTotalServPrestadosCantidad.text :=(ParamByName('vServPresAutosEP').Value)+(ParamByName('vServPresMotosEP').Value);

            MPAutosServPrestadosCash.text := ParamByName('vServPresImporteAutosMP').Value;
            MPMotosServPrestadosCash.text := ParamByName('vServPresImporteMotosMP').Value;
            MPTotalServPrestadosCash.text :=(ParamByName('vServPresImporteAutosMP').Value)+(ParamByName('vServPresImporteMotosMP').Value);

            EPAutosServPrestadosCash.text := ParamByName('vServPresImporteAutosEP').Value;
            EPMotosServPrestadosCash.text := ParamByName('vServPresImporteMotosEP').Value;
            EPTotalServPrestadosCash.text :=(ParamByName('vServPresImporteAutosEP').Value)+(ParamByName('vServPresImporteMotosEP').Value);

            MPAutosServPendientesCantidad.Text := ParamByName('vServPendAutosMP').Value;
            MPMotosServPendientesCantidad.Text := ParamByName('vServPendMotosMP').Value;
            MPTotalServPendientesCantidad.Text := (ParamByName('vServPendAutosMP').Value)+(ParamByName('vServPendMotosMP').Value);

            EPAutosServPendientesCantidad.Text := ParamByName('vServPendAutosEP').Value;
            EPMotosServPendientesCantidad.Text := ParamByName('vServPendMotosEP').Value;
            EPTotalServPendientesCantidad.Text := (ParamByName('vServPendAutosEP').Value)+(ParamByName('vServPendMotosEP').Value);

            MPAutosServPendientesCash.Text := ParamByName('vServPendImporteAutosMP').Value;
            MPMotosServPendientesCash.Text := ParamByName('vServPendImporteMotosMP').Value;
            MPTotalServPendientesCash.Text := (ParamByName('vServPendImporteAutosMP').Value)+(ParamByName('vServPendImporteMotosMP').Value);

            EPAutosServPendientesCash.Text := ParamByName('vServPendImporteAutosEP').Value;
            EPMotosServPendientesCash.Text := ParamByName('vServPendImporteMotosEP').Value;
            EPTotalServPendientesCash.Text := (ParamByName('vServPendImporteAutosEP').Value)+(ParamByName('vServPendImporteMotosEP').Value);

            TTAutosServCantidad.Text := (ParamByName('vServPresAutosMP').Value)+(ParamByName('vServPresAutosEP').Value)+
                                        (ParamByName('vServPendAutosMP').Value)+(ParamByName('vServPendAutosEP').Value);

            TTMotosServCantidad.Text := (ParamByName('vServPresMotosMP').Value)+(ParamByName('vServPresMotosEP').Value)+
                                        (ParamByName('vServPendMotosMP').Value)+(ParamByName('vServPendMotosEP').Value);

            TTotalServCantidad.Text := (ParamByName('vServPresAutosMP').Value)+(ParamByName('vServPresAutosEP').Value)+
                                       (ParamByName('vServPendAutosMP').Value)+(ParamByName('vServPendAutosEP').Value)+
                                       (ParamByName('vServPresMotosMP').Value)+(ParamByName('vServPresMotosEP').Value)+
                                       (ParamByName('vServPendMotosMP').Value)+(ParamByName('vServPendMotosEP').Value);

            TTAutosServCash.Text := (ParamByName('vServPresImporteAutosMP').Value)+(ParamByName('vServPresImporteAutosEP').Value)+
                                    (ParamByName('vServPendImporteAutosMP').Value)+(ParamByName('vServPendImporteAutosEP').Value);

            TTMotosServCash.Text := (ParamByName('vServPresImporteMotosMP').Value)+(ParamByName('vServPresImporteMotosEP').Value)+
                                    (ParamByName('vServPendImporteMotosMP').Value)+(ParamByName('vServPendImporteMotosEP').Value);

            TTotalServCash.Text := (ParamByName('vServPresImporteAutosMP').Value)+(ParamByName('vServPresImporteAutosEP').Value)+
                                   (ParamByName('vServPendImporteAutosMP').Value)+(ParamByName('vServPendImporteAutosEP').Value)+
                                   (ParamByName('vServPresImporteMotosMP').Value)+(ParamByName('vServPresImporteMotosEP').Value)+
                                   (ParamByName('vServPendImporteMotosMP').Value)+(ParamByName('vServPendImporteMotosEP').Value);

            with tsqlquery.create(self) do       //
            try
             sdsQTServiciosPrestados.SQLConnection := mybd;

            finally
              free;
            end;
        Close;
        finally
            Free
        end;
    end;

procedure TResumenDiarioADM.FormCreate(Sender: TObject);
    begin
        bErrorCreando := False;

        if (not MyBD.InTransaction) then MyBD.StartTransaction(td);
        try
            LoockAndDeleteTable(MyBD, 'TTMPREPORTEADM');

            QTServiciosPrestados.Close;
            sdsQTServiciosPrestados.SQLConnection := MyBD;

        except
            on E:Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Resumen Diario Cancelado por: %s', [E.message]);
                MessageDlg('Generación de Resumen Diario.', 'El Resumen Diario no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minuts, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
                bErrorCreando := True
            end
        end
    end;

procedure TResumenDiarioADM.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            If not GetDates(DateIni,DateFin) then Exit;

            FTmp.Temporizar(TRUE,FALSE,'Resumen Diario', 'Generando el Resumen Diario.');

            Application.ProcessMessages;

            Caption := Format('Resumen Diario. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);

            QTServiciosPrestados.Close;

            DoResumenDiario;

            QTServiciosPrestados.Open;

            FTmp.Temporizar(FALSE,FALSE,'', '');

        except
            on E: Exception do
            begin
                FTmp.Temporizar(FALSE,FALSE,'', '');
                Application.ProcessMessages;
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
                MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)
            end
        end
    finally
        Enabled := True;
        Show;
        Application.ProcessMessages;
    end;
end;

procedure TResumenDiarioADM.FormDestroy(Sender: TObject);
begin
     try
        try
            if MyBD.InTransaction then MyBD.Rollback(td) // MyBD.Commit
            else raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del informe de Resumen Diario')
        except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'Error cerrando la ficha de Resumen Diario: %s', [E.message]);
                MessageDlg('Generación de Informe.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end
        end
    finally
        FTmp.Temporizar(FALSE,FALSE,'','');
    end
end;

procedure TResumenDiarioADM.BExcelClick(Sender: TObject);
begin
  //UFSERVICIOSPRESTADOS.GenerateServiciosPrestados;
  ExportacionExcelGeneral;
end;

procedure TResumenDiarioADM.ExportacionExcelGeneral;
const

    //Titulos Cabecera
    F_TTL = 1;   C_TTL = 5;
    F_STT = 2;   C_STT = 5;

    //Datos
    F_INI = 8;   C_FAC = 1;
                 C_TUR = 16;
                 C_INS = 21;

    //Valores Cuadros
    F_TPT_R = 4;   C_TPT_R = 2;   //Servicios Prestados
    F_TPM_R = 5;   C_TPM_R = 2;   //Servicios Pendientes

    //Flotas
    F_FLO = 4;     C_FLO = 14;
    F_N_FLO = 5;

    //Valores Cuadro Resumen MercadoPago
    F_AUTO_MP = 9;  C_AUTO_MP_C = 2;
    F_MOTO_MP = 10; C_MOTO_MP_C = 2;
                    C_AUTO_MP_I = 3;
                    C_MOTO_MP_I = 3;
                    C_AUTO_MP_IVA = 4;
                    C_MOTO_MP_IVA = 4;
                    C_AUTO_MP_IIBB = 5;
                    C_MOTO_MP_IIBB = 5;
                    C_AUTO_MP_T = 6;
                    C_MOTO_MP_T = 6;

    //Valores Cuadro Resumen Epago
    F_AUTO_EP = 13; C_AUTO_EP_C = 2;
    F_MOTO_EP = 14; C_MOTO_EP_C = 2;
                    C_AUTO_EP_I = 3;
                    C_MOTO_EP_I = 3;
                    C_AUTO_EP_IVA = 4;
                    C_MOTO_EP_IVA = 4;
                    C_AUTO_EP_IIBB = 5;
                    C_MOTO_EP_IIBB = 5;
                    C_AUTO_EP_T = 6;
                    C_MOTO_EP_T = 6;

    //Valores Cuadro Resumen Total Global
    F_AUTO_T = 17;  C_AUTO_T_C = 2;
    F_MOTO_T = 18;  C_MOTO_T_C = 2;
                    C_AUTO_T_I = 3;
                    C_MOTO_T_I = 3;
                    C_AUTO_T_IVA = 4;
                    C_MOTO_T_IVA = 4;
                    C_AUTO_T_IIBB = 5;
                    C_MOTO_T_IIBB = 5;
                    C_AUTO_T_T = 6;
                    C_MOTO_T_T = 6;

    //Valores Cuadro Servicios Prestados
    F_MP = 9;       F_EP = 11;
    F_IMP_MP = 10;  F_IMP_EP = 12;

    //Valores Cuadro Servicios Pendientes
    F_MP_P = 15;      F_EP_P = 17;
    F_IMP_MP_P = 16;  F_IMP_EP_P = 18;

    //Valores Cuadro Servicios Prestados Global
    F_GLO = 9;       C_AUTO_GLO = 14;
    F_IMP_GLO = 10;  C_MOTO_GLO = 15;
                     C_TOTAL_GLO = 16;

    C_AUTO = 9;
    C_MOTO = 10;
    C_TOTAL = 11;

var
    i,f : integer;
    ExcelApp, ExcelLibro, ExcelHojaResumen, ExcelHojaDetalle: Variant;
begin
  try
    DBServiciosPrestados.DataSource.DataSet.DisableControls;
    try
      opendialog.Title := 'Seleccione la Planilla de Entrada';
      if OpenDialog.Execute then
      begin
        FTmp.Temporizar(TRUE,FALSE,'Servicios Prestados', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
        ExcelHojaResumen := ExcelLibro.Worksheets[1];
        ExcelHojaDetalle := ExcelLibro.Worksheets[2];

        //Inicia Resumen
        ExcelHojaResumen.Cells[F_TTL,C_TTL].value := 'Servicios Prestados';
        ExcelHojaResumen.Cells[F_STT,C_STT].value := Format('Planta nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);

        ExcelHojaResumen.Cells[F_TPT_R,C_TPT_R].value := '$' + ' ' + SERVICIOSPRESTADOS; //Servicios Prestados
        ExcelHojaResumen.Cells[F_TPM_R,C_TPM_R].value := '$' + ' ' + SERVICIOSPENDIENTES; //Servicios Pendientes

        //Flotas
        ExcelHojaResumen.Cells[F_FLO,C_FLO].value := Flotas.Text; //Cantidad de Vehiculos en Flotas
        ExcelHojaResumen.Cells[F_N_FLO,C_FLO].value := NoFlotas.text; //Cantidad de Vehiculos en No Flotas

        //Cuadro RESUMEN Mercado Pago
        ExcelHojaResumen.Cells[F_AUTO_MP,C_AUTO_MP_C].value := Cantidad_Autos_MP.Text; //Cantidad Autos
        ExcelHojaResumen.Cells[F_MOTO_MP,C_MOTO_MP_C].value := Cantidad_Motos_MP.Text; //Cantidad Motos
        ExcelHojaResumen.Cells[F_AUTO_MP,C_AUTO_MP_I].value := ImporteAutoMP.Text; //Importe Autos
        ExcelHojaResumen.Cells[F_MOTO_MP,C_MOTO_MP_I].value := ImporteMotoMP.Text; //Importe Motos
        ExcelHojaResumen.Cells[F_AUTO_MP,C_AUTO_MP_IVA].value := IVAAutoMP.Text; //Importe IVA Autos
        ExcelHojaResumen.Cells[F_MOTO_MP,C_MOTO_MP_IVA].value := IVAMotoMP.Text; //Importe IVA Motos
        ExcelHojaResumen.Cells[F_AUTO_MP,C_AUTO_MP_IIBB].value := IIBBAutoMP.Text; //Importe IIBB Autos
        ExcelHojaResumen.Cells[F_MOTO_MP,C_MOTO_MP_IIBB].value := IIBBMotoMP.Text; //Importe IIBB Motos
        ExcelHojaResumen.Cells[F_AUTO_MP,C_AUTO_MP_T].value := MontoTotalAutoMP.Text; //Importe TOTAL Autos
        ExcelHojaResumen.Cells[F_MOTO_MP,C_MOTO_MP_T].value := MontoTotalMotoMP.Text; //Importe TOTAL Motos

        //Cuadro RESUMEN Epago
        ExcelHojaResumen.Cells[F_AUTO_EP,C_AUTO_EP_C].value := Cantidad_Autos_EP.Text; //Cantidad Autos
        ExcelHojaResumen.Cells[F_MOTO_EP,C_MOTO_EP_C].value := Cantidad_Motos_EP.Text; //Cantidad Motos
        ExcelHojaResumen.Cells[F_AUTO_EP,C_AUTO_EP_I].value := ImporteAutoEP.Text; //Importe Autos
        ExcelHojaResumen.Cells[F_MOTO_EP,C_MOTO_EP_I].value := ImporteMotoEP.Text; //Importe Motos
        ExcelHojaResumen.Cells[F_AUTO_EP,C_AUTO_EP_IVA].value := IVAAutoEP.Text; //Importe IVA Autos
        ExcelHojaResumen.Cells[F_MOTO_EP,C_MOTO_EP_IVA].value := IVAMotoEP.Text; //Importe IVA Motos
        ExcelHojaResumen.Cells[F_AUTO_EP,C_AUTO_EP_IIBB].value := IIBBAutoEP.Text; //Importe IIBB Autos
        ExcelHojaResumen.Cells[F_MOTO_EP,C_MOTO_EP_IIBB].value := IIBBMotoEP.Text; //Importe IIBB Motos
        ExcelHojaResumen.Cells[F_AUTO_EP,C_AUTO_EP_T].value := MontoTotalAutoEP.Text; //Importe TOTAL Autos
        ExcelHojaResumen.Cells[F_MOTO_EP,C_MOTO_EP_T].value := MontoTotalMotoEP.Text; //Importe TOTAL Motos

        //Cuadro RESUMEN Total
        ExcelHojaResumen.Cells[F_AUTO_T,C_AUTO_T_C].value := Cantidad_Autos_Global.Text; //Cantidad Autos
        ExcelHojaResumen.Cells[F_MOTO_T,C_MOTO_T_C].value := Cantidad_Motos_Global.Text; //Cantidad Motos
        ExcelHojaResumen.Cells[F_AUTO_T,C_AUTO_T_I].value := ImporteAutosGlobal.Text; //Importe Autos
        ExcelHojaResumen.Cells[F_MOTO_T,C_MOTO_T_I].value := ImporteMotosGlobal.Text; //Importe Motos
        ExcelHojaResumen.Cells[F_AUTO_T,C_AUTO_T_IVA].value := IVAAutosGlobal.Text; //Importe IVA Autos
        ExcelHojaResumen.Cells[F_MOTO_T,C_MOTO_T_IVA].value := IVAMotosGlobal.Text; //Importe IVA Motos
        ExcelHojaResumen.Cells[F_AUTO_T,C_AUTO_T_IIBB].value := IIBBAutosGlobal.Text; //Importe IIBB Autos
        ExcelHojaResumen.Cells[F_MOTO_T,C_MOTO_T_IIBB].value := IIBBMotosGlobal.Text; //Importe IIBB Motos
        ExcelHojaResumen.Cells[F_AUTO_T,C_AUTO_T_T].value := MontoAutosGlobal.Text; //Importe TOTAL Autos
        ExcelHojaResumen.Cells[F_MOTO_T,C_MOTO_T_T].value := MontoMotosGlobal.Text; //Importe TOTAL Motos

        //Servicios Prestados
        ExcelHojaResumen.Cells[F_MP,C_AUTO].value := MPAutosServPrestadosCantidad.text; //Cantidad Servicios Prestados MP Autos
        ExcelHojaResumen.Cells[F_MP,C_MOTO].value := MPMotosServPrestadosCantidad.text; //Cantidad Servicios Prestados MP Motos
        ExcelHojaResumen.Cells[F_MP,C_TOTAL].value := MPTotalServPrestadosCantidad.text; //Cantidad Servicios Prestados MP Total

        ExcelHojaResumen.Cells[F_IMP_MP,C_AUTO].value := MPAutosServPrestadosCash.text; //Importe Servicios Prestados MP Autos
        ExcelHojaResumen.Cells[F_IMP_MP,C_MOTO].value := MPMotosServPrestadosCash.text; //Importe Servicios Prestados MP Motos
        ExcelHojaResumen.Cells[F_IMP_MP,C_TOTAL].value := MPTotalServPrestadosCash.text; //Importe Servicios Prestados MP Total

        ExcelHojaResumen.Cells[F_EP,C_AUTO].value := EPAutosServPrestadosCantidad.text; //Cantidad Servicios Prestados EP Autos
        ExcelHojaResumen.Cells[F_EP,C_MOTO].value := EPMotosServPrestadosCantidad.text; //Cantidad Servicios Prestados EP Motos
        ExcelHojaResumen.Cells[F_EP,C_TOTAL].value := EPTotalServPrestadosCantidad.text; //Cantidad Servicios Prestados EP Total

        ExcelHojaResumen.Cells[F_IMP_EP,C_AUTO].value := EPAutosServPrestadosCash.text; //Importe Servicios Prestados EP Autos
        ExcelHojaResumen.Cells[F_IMP_EP,C_MOTO].value := EPMotosServPrestadosCash.text; //Importe Servicios Prestados EP Motos
        ExcelHojaResumen.Cells[F_IMP_EP,C_TOTAL].value := EPTotalServPrestadosCash.text; //Importe Servicios Prestados EP Total

        //Servicios Pendientes
        ExcelHojaResumen.Cells[F_MP_P,C_AUTO].value := MPAutosServPendientesCantidad.text; //Cantidad Servicios Pendientes MP Autos
        ExcelHojaResumen.Cells[F_MP_P,C_MOTO].value := MPMotosServPendientesCantidad.text; //Cantidad Servicios Pendientes MP Motos
        ExcelHojaResumen.Cells[F_MP_P,C_TOTAL].value := MPTotalServPendientesCantidad.text; //Cantidad Servicios Pendientes MP Total

        ExcelHojaResumen.Cells[F_IMP_MP_P,C_AUTO].value := MPAutosServPendientesCash.text; //Importe Servicios Pendientes MP Autos
        ExcelHojaResumen.Cells[F_IMP_MP_P,C_MOTO].value := MPMotosServPendientesCash.text; //Importe Servicios Pendientes MP Motos
        ExcelHojaResumen.Cells[F_IMP_MP_P,C_TOTAL].value := MPTotalServPendientesCash.text; //Importe Servicios Pendientes MP Total

        ExcelHojaResumen.Cells[F_EP_P,C_AUTO].value := EPAutosServPendientesCantidad.text; //Cantidad Servicios Pendientes EP Autos
        ExcelHojaResumen.Cells[F_EP_P,C_MOTO].value := EPMotosServPendientesCantidad.text; //Cantidad Servicios Pendientes EP Motos
        ExcelHojaResumen.Cells[F_EP_P,C_TOTAL].value := EPTotalServPendientesCantidad.text; //Cantidad Servicios Pendientes EP Total

        ExcelHojaResumen.Cells[F_IMP_EP_P,C_AUTO].value := EPAutosServPendientesCash.text; //Importe Servicios Pendientes EP Autos
        ExcelHojaResumen.Cells[F_IMP_EP_P,C_MOTO].value := EPMotosServPendientesCash.text; //Importe Servicios Pendientes EP Motos
        ExcelHojaResumen.Cells[F_IMP_EP_P,C_TOTAL].value := EPTotalServPendientesCash.text; //Importe Servicios Pendientes EP Total

        //Servicios Prestados Global
        ExcelHojaResumen.Cells[F_GLO,C_AUTO_GLO].value := TTAutosServCantidad.text; //Cantidad Servicios Prestados Global Autos
        ExcelHojaResumen.Cells[F_GLO,C_MOTO_GLO].value := TTMotosServCantidad.text; //Cantidad Servicios Prestados Global Motos
        ExcelHojaResumen.Cells[F_GLO,C_TOTAL_GLO].value := TTotalServCantidad.text; //Cantidad Servicios Prestados Global Total

        ExcelHojaResumen.Cells[F_IMP_GLO,C_AUTO_GLO].value := TTAutosServCash.text; //Importe Servicios Prestados Global Autos
        ExcelHojaResumen.Cells[F_IMP_GLO,C_MOTO_GLO].value := TTMotosServCash.text; //Importe Servicios Prestados Global Motos
        ExcelHojaResumen.Cells[F_IMP_GLO,C_TOTAL_GLO].value := TTotalServCash.text; //Importe Servicios Prestados Global Total

        //Fin Resumen

        //Inicia Informe Detallado
        ExcelHojaDetalle.Cells[F_TTL,C_TTL].value := 'Servicios Prestados';
        ExcelHojaDetalle.Cells[F_STT,C_STT].value := Format('Planta nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);

        ExcelHojaDetalle.Cells[F_TPT_R,C_TPT_R].value := '$' + ' ' + SERVICIOSPRESTADOS; //Servicios Prestados
        ExcelHojaDetalle.Cells[F_TPM_R,C_TPM_R].value := '$' + ' ' + SERVICIOSPENDIENTES; //Servicios Pendientes

        f:= F_INI;

        QTSERVICIOSPRESTADOS.First;
        while not QTSERVICIOSPRESTADOS.EOF do
        begin
            for i := 0 to DBServiciosPrestados.Columns.Count - 1 do
              begin
                ExcelHojaDetalle.Cells[f,C_FAC].value := StrToDate(QTSERVICIOSPRESTADOS.FieldByName('FECHA_FACTURA').AsString); //Corrige en la exportacion a excel el formato de fecha entre las fecha 01 al 12 del mes. - Lucas
                ExcelHojaDetalle.Cells[f,C_TUR].value := StrToDate(QTSERVICIOSPRESTADOS.FieldByName('FECHA_TURNO').AsString); //Corrige en la exportacion a excel el formato de fecha entre las fecha 01 al 12 del mes. - Lucas
                ExcelHojaDetalle.Cells[f,C_INS].value := StrToDate(QTSERVICIOSPRESTADOS.FieldByName('FECHA_INSPECCION').AsString); //Corrige en la exportacion a excel el formato de fecha entre las fecha 01 al 12 del mes. - Lucas
                ExcelHojaDetalle.Cells[f,i+1].value := QTSERVICIOSPRESTADOS.FieldByName(DBServiciosPrestados.Columns[i].FieldName).AsString;
              end;
            QTSERVICIOSPRESTADOS.Next;
            inc(f);
        end;
        QTSERVICIOSPRESTADOS.First;

      end;
      opendialog.Title := 'Seleccione la Planilla de Salida';
      if OpenDialog.Execute then
         excellibro.saveas(opendialog.filename);
      ExcelApp.Quit;
    except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de Servicios Prestados: %s', [E.message]);
                MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
            end
    end;
  finally
      //DBServiciosPrestados.DataSource.DataSet.enableControls;
      FTmp.Temporizar(FALSE,FALSE,'','');
      application.ProcessMessages;
  end;
end;

procedure TResumenDiarioADM.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TResumenDiarioADM.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;

procedure TResumenDiarioADM.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;

end.
