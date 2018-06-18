unit UCONTROLDIARIO;
{ Realiza el "Control diario", para ello necesita que se haya creado en la base de datos
la tabla TTMPCONTROLDIARIO, del siguiente modo:
CREATE TABLE TTMPCONTROLDIARIO
(
    TIPOVEHICULO_ID  NUMBER(1)       NOT NULL,
    TIPOCLIENTE_ID   NUMBER(10)      NOT NULL,
    PUV              NUMBER(5,2)     NOT NULL,
    NAPRV            NUMBER(6)       NOT NULL,
    NCONV            NUMBER(6)       NOT NULL,
    NRECV            NUMBER(6)       NOT NULL,
    PUR              NUMBER(5,2)     NOT NULL,
    NAPRR            NUMBER(6)       NOT NULL,
    NCONR            NUMBER(6)       NOT NULL,
    NRECR            NUMBER(6)       NOT NULL,
    CONSTRAINT FRK_TTMPCONTROLDIA_TTIPOVEHICU FOREIGN KEY (TIPOVEHICULO_ID) REFERENCES TTIPOVEHICU (TIPOVEHI),
    CONSTRAINT FRK_TTMPCONTROLDIA_TTIPOSCLIEN FOREIGN KEY (TIPOCLIENTE_ID) REFERENCES TTIPOSCLIENTE (TIPOCLIENTE_ID),
    CONSTRAINT PRK_TTMPCONTROLDIARIO PRIMARY KEY (TIPOVEHICULO_ID,TIPOCLIENTE_ID)
        USING INDEX TABLESPACE INDEX_ESTACION -- U OTRO TABLESPACE PARA INDICES
        PCTFREE 5
        STORAGE
        (
              INITIAL 176128
              NEXT 88064
              PCTINCREASE 25
        )
)
PCTFREE 5
PCTUSED 90
STORAGE (
          INITIAL 1228800
          NEXT 614400
          MINEXTENTS 1
          MAXEXTENTS 121
          PCTINCREASE 0
        )
TABLESPACE USER_DATA_ESTACION; -- U OTRO TABLESPACE PARA DATOS

Sobre esta tabla se construirá la siguiente vista

CREATE OR REPLACE VIEW VTMPCONTROLDIARIO
(
  TIPOVEHICULO_ID, TIPOCLIENTE_ID,
  TIPOVEHICULO_DES, TIPOCLIENTE_DES,
  PUV, NAPRV, MNAPRV, NCONV, MNCONV, NRECV, MNRECV, SMONV,
  PUR, NAPRR, MNAPRR, NCONR, MNCONR, NRECR, MNRECR, SMONR,
  TMONVR )
AS SELECT
    V.TIPOVEHI, D.TIPOCLIENTE_ID,
    V.NOMTIPVE, LTRIM(TO_CHAR(D.TIPOCLIENTE_ID,'RM') || ' ' || C.DESCRIPCION),
    D.PUV,
    D.NAPRV,
    D.PUV*D.NAPRV,
    D.NCONV,
    D.PUV*D.NCONV,
    D.NRECV,
    D.PUV*D.NRECV,
    D.PUV * (D.NAPRV + D.NCONV + D.NRECV),
    D.PUR,
    D.NAPRR,
    D.PUR*D.NAPRR,
    D.NCONR,
    D.PUR*D.NCONR,
    D.NRECR,
    D.PUR*D.NRECR,
    D.PUR * (D.NAPRR + D.NCONR + D.NRECR),
    (D.PUV * (D.NAPRV + D.NCONV + D.NRECV)) + (D.PUR * (D.NAPRR + D.NCONR + D.NRECR))
        FROM TTIPOVEHICU V, TTIPOSCLIENTE C, TTMPCONTROLDIARIO D
            WHERE (V.TIPOVEHI = D.TIPOVEHICULO_ID) AND (C.TIPOCLIENTE_ID = D.TIPOCLIENTE_ID);

Se reutilizará el servicios 4,
"SERVICIO DE ENVIO DE INFORMACIÓN",

y pasarán a ser:

4 "CONTROL DIARIO"

Habrá que ejecutar y validar los cambios realizados por las siguientes sentencias:

UPDATE TSERVIC SET NOMBRE = 'Control Diario' WHERE IDSERVICIO = 4;

COMMIT;

}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DB, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  SpeedBar, RXLookup, ComCtrls, USAGESTACION, quickrpt, comobj, Dialogs, variants,
  FMTBcd, DBClient, Provider, SqlExpr;

type
  TFControlDiario = class(TForm)
    SBarPrincipal: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    Print: TSpeedItem;
    SBBusqueda: TSpeedItem;
    SBSalir: TSpeedItem;
    Ascci: TSpeedItem;
    SExcel: TSpeedItem;
    Resumen: TSpeedItem;
    Panel1: TPanel;
    PSubtotales: TPanel;
    PTotales: TPanel;
    Panel2: TPanel;
    Panel6: TPanel;
    Panel8: TPanel;
    DBVerificaciones: TDBGrid;
    DBReVerificaciones: TDBGrid;
    TabTipo: TTabControl;
    Label5: TLabel;
    Label6: TLabel;
    SAV: TDBEdit;
    MSAV: TDBEdit;
    SCV: TDBEdit;
    MSCV: TDBEdit;
    SRV: TDBEdit;
    MSRV: TDBEdit;
    MSACRV: TDBEdit;
    STMVR: TDBEdit;
    DSMVControlDiario: TDataSource;
    SAR: TDBEdit;
    MSAR: TDBEdit;
    SCR: TDBEdit;
    MSCR: TDBEdit;
    SRR: TDBEdit;
    MSRR: TDBEdit;
    MSACRR: TDBEdit;
    DSSVControlDiario: TDataSource;
    TAV: TDBEdit;
    MTAR: TDBEdit;
    TCV: TDBEdit;
    MTCV: TDBEdit;
    TRV: TDBEdit;
    MTRV: TDBEdit;
    MTACRV: TDBEdit;
    TAR: TDBEdit;
    MTAV: TDBEdit;
    TCR: TDBEdit;
    MTCR: TDBEdit;
    TRR: TDBEdit;
    MTRR: TDBEdit;
    TMACRR: TDBEdit;
    TTMVR: TDBEdit;
    DSTControlDiario: TDataSource;
    Panel3: TPanel;
    RBTipoVehiculo: TRxDBLookupCombo;
    btnExportar: TSpeedItem;
    OpenDialog: TOpenDialog;
    sdsQTotalControlDiario: TSQLDataSet;
    sdsMVControlDiario: TSQLDataSet;
    sdsSVControlDiario: TSQLDataSet;
    dspQTotalControlDiario: TDataSetProvider;
    dspMVControlDiario: TDataSetProvider;
    dspSVControlDiario: TDataSetProvider;
    QTotalControlDiario: TClientDataSet;
    MVControlDiario: TClientDataSet;
    SVControlDiario: TClientDataSet;
    Panel11: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel7: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TabTipoChange(Sender: TObject);
    procedure RBTipoVehiculoCloseUp(Sender: TObject);
    procedure SBSalirClick(Sender: TObject);
    procedure ResumenClick(Sender: TObject);
    procedure SBBusquedaClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure AscciClick(Sender: TObject);
    procedure OnOpen (Sender: TObject);
    procedure OnClose (Sender: TObject);
    procedure SExcelClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
  public
    { Public declarations }
      bErrorCreando : boolean;
      NombreEstacion, NumeroEstacion,
      DateIni, DateFin : string;
      function PutEstacion : string;
  private
    fSumaryCD: tSumaryCD;
    procedure DoControlDiario;
    procedure DoResumenControlDiario;
  end;


    procedure GenerateControlDiario;

var
  FControlDiario: TFControlDiario;


implementation

{$R *.DFM}

uses
   UTILORACLE,
   UCDIALGS,
   UUTILS,
   UGETDATES,
   UPREVIOCONTROLDIARIO,
   URESUMENCONTROLDIARIO,
   UPRINTCONTROLDIARIOSUMARY,
   UPRINTCONTROLDIARIO,
   UFINFORMESDIALOGPRINT,
   UFINFORMESDIALOGASCII,
   UFINFORMESDIALOGEXCEL,
   ULOGS,
   GLOBALS,
   UFTMP,
   USAGVARIOS, uExportaciones;

const
    COLOR_VERIFICACIONES = $00BBFFDD;
    COLOR_REVERIFICACIONES = $00B8FCFA;

resourcestring
    FICHERO_ACTUAL = 'UCONTROLDIARIO.PAS';

    function TFControlDiario.PutEstacion : string;
    begin
        NombreEstacion := fVarios.NombreEstacion;
        NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
        Result := NumeroEstacion + ' ' + NombreEstacion;
    end;

    procedure GenerateControlDiario;
    begin
        with TFControlDiario.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                If not GetDates(DateIni,DateFin) then Exit;
                Caption := Format('Control Diario. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                FTmp.Temporizar(TRUE,FALSE,'Control diario', 'Generando el informe control diario.');

                with TFPrevioControlDiario.Create(Application) do
                try
                    Caption := Format('Petición de parámetros. Control Diario en:  %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                    if not (ShowModal = mrOk)
                    then exit;
                    fSumaryCD := SumaryCD;
                finally
                    Free;
                end;

                Application.ProcessMessages;

                DoControlDiario;

                QTotalControlDiario.Open;
                SVControlDiario.Open;
                MVControlDiario.Open;
                RBTipoVehiculo.Value := MVControlDiario.FieldByName('TIPOVEHICULO_ID').AsString;
                FTmp.Temporizar(FALSE,FALSE,'', '');
                ShowModal;
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
            Free;
            Application.ProcessMessages;
        end;
    end;

procedure TFControlDiario.FormCreate(Sender: TObject);
var
    i : integer;
begin

    bErrorCreando := False;

    if (not MyBD.InTransaction) then MyBD.StartTransaction(td);
    try
        LoockAndDeleteTable(MyBD, 'TTMPCONTROLDIARIO');

        TabTipo.TabIndex := 0;
        PSubtotales.Color := COLOR_VERIFICACIONES;
        PTotales.Color := PSubtotales.Color;

        for i := 0 to ComponentCount - 1 do
            if TControl(Components[i]).Tag = 1
            then TControl(Components[i]).BringToFront;

        QTotalControlDiario.Close;
        sdsQTotalControlDiario.SQLConnection := MyBD;
        MVControlDiario.Close;
        sdsMVControlDiario.SQLConnection := MyBD;
        SVControlDiario.Close;
        sdsSVControlDiario.SQLConnection := MyBD;

    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
            MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minuts, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
            bErrorCreando := True
        end
    end
end;

procedure TFControlDiario.FormDestroy(Sender: TObject);
begin
    QTotalControlDiario.Close;
    MVControlDiario.Close;
    SVControlDiario.Close;

    try
        try
            if MyBD.InTransaction then
              Begin
                MyBD.Rollback(td); // MyBD.Commit
              end
            else raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del control diario')
        except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'Error cerrando la ficha de Control Diario: %s', [E.message]);
                MessageDlg('Generación de Informes.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end
        end
    finally
        FTmp.Temporizar(FALSE,FALSE,'','');
    end

end;

procedure TFControlDiario.TabTipoChange(Sender: TObject);
var
    i : Integer;
begin
    if TabTipo.TabIndex = 0
    then begin
        PSubtotales.Color := COLOR_VERIFICACIONES;
        for i := 0 to ComponentCount - 1 do
            if TControl(Components[i]).Tag = 1
            then TControl(Components[i]).BringToFront;
    end
    else begin
        PSubtotales.Color := COLOR_REVERIFICACIONES;
        for i := 0 to ComponentCount - 1 do
            if TControl(Components[i]).Tag = 2
            then TControl(Components[i]).BringToFront;
    end;
    PTotales.Color := PSubtotales.Color;
end;




procedure TFControlDiario.RBTipoVehiculoCloseUp(Sender: TObject);
begin
    RBTipoVehiculo.Value := MVControlDiario.FieldByName('TIPOVEHICULO_ID').AsString;
end;

procedure TFControlDiario.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;

procedure TFControlDiario.DoControlDiario;
begin
    DeleteTable(MyBD, 'TTMPCONTROLDIARIO');
    DeleteTable(MyBD, 'TTMPCDOBLEAS');

    with TSQLStoredProc.Create(self) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_CONTROLDIARIO.DOCONTROLDIARIO';
        Prepared := true;
        ParamByName('FI').Value := DateIni;
        ParamByName('FF').Value := DateFin;
        ExecProc;
        Close;

    finally
        Free
    end;
     with TSQLStoredProc.Create(self) do
    try
        SQLConnection := MyBD;
        StoredProcName := 'PQ_CONTROLDIARIO.DOobleas';
        Prepared := true;
        ParamByName('FI').Value := DateIni;
        ParamByName('FF').Value := DateFin;
        ExecProc;
        Close;

    finally
        Free
    end;
    DoResumenControlDiario;
end;

procedure TFControlDiario.DoResumenControlDiario;
const
    C_VENTAS_X_USUARIO = 'PQ_CONTROLDIARIO.VentasxUsuario';
    //FUNCTION VentasxUsuario (aTipoUsuario IN NUMBER) RETURN NUMBER;

    C_VENTAS_SIN_USUARIO = 'PQ_CONTROLDIARIO.VentasSinUsuario';
    //FUNCTION VentasSinUsuario (aTipoUsuario IN NUMBER) RETURN NUMBER;

    C_VENTAS_A_CREDITO = 'PQ_CONTROLDIARIO.VentasACredito';
    //FUNCTION  VentasACredito (FI IN VARCHAR2, FF IN VARCHAR2, aTipoUsuario NUMBER) RETURN NUMBER;

    C_IVA_VENTAS_A_CONTADO = 'PQ_CONTROLDIARIO.IVAVentasAContado';
    //FUNCTION  IVAVentasAContado (FI IN VARCHAR2, FF IN VARCHAR2, aTipoUsuario NUMBER) RETURN NUMBER;

    C_INS_PASADAS = 'PQ_CONTROLDIARIO.InsPasadas';
    //FUNCTION InsPasadas RETURN NUMBER;

    C_INS_NO_PASADAS = 'PQ_CONTROLDIARIO.InsNoPasadas';
    //FUNCTION InsNoPasadas RETURN NUMBER IS

    C_N_OBLEAS = 'PQ_CONTROLDIARIO.NObleas';
    //FUNCTION NObleas (FI IN VARCHAR2, FF IN VARCHAR2, aYear VARCHAR2, aProvider VARCHAR2) RETURN NUMBER IS

    C_MIN_OBLEAS = 'PQ_CONTROLDIARIO.MinOblea';
    //FUNCTION MinOblea (FI IN VARCHAR2, FF IN VARCHAR2, aYear VARCHAR2, aProvider VARCHAR2) RETURN NUMBER I

    C_MAX_OBLEAS = 'PQ_CONTROLDIARIO.MaxOblea';
    //FUNCTION MaxOblea (FI IN VARCHAR2, FF IN VARCHAR2, aYear VARCHAR2, aProvider VARCHAR2) RETURN NUMBER I

    C_N_ANULADAS = 'PQ_CONTROLDIARIO.NObleaAnulada';
    //FUNCTION NObleaAnulada (FI IN VARCHAR2, FF IN VARCHAR2) RETURN NUMBER;

    C_N_INUTILIZADAS = 'PQ_CONTROLDIARIO.NObleaInutilizadas';
    //FUNCTION NObleaInutilizadas (FI IN VARCHAR2, FF IN VARCHAR2) RETURN NUMBER;

    C_DIF_NC_X_DESCUENTO = 'PQ_CONTROLDIARIO.DifNCxDescuento';
    //FUNCTION  DifNCxDescuento (FI IN VARCHAR2, FF IN VARCHAR2, aTipoUsuario NUMBER) RETURN NUMBER IS aDifNCxDescuento NUMBER;

    C_DIF_X_CONVENIO = 'PQ_CONTROLDIARIO.DifxConvenio';
    //FUNCTION  DifxConvenio (FI IN VARCHAR2, FF IN VARCHAR2, aTipoUsuario NUMBER) RETURN NUMBER IS aDifxConvenio NUMBER;

    C_DIF_CONVENIO_CREDITO = 'PQ_CONTROLDIARIO.DifConvenioCredito';
    //FUNCTION  DifxConvenio (FI IN VARCHAR2, FF IN VARCHAR2, aTipoUsuario NUMBER) RETURN NUMBER IS aDifxConvenio NUMBER;

    C_DIF_NC_X_DESCUENTO_CREDITO = 'PQ_CONTROLDIARIO.DifNCxDescuentoCredito';
    //FUNCTION  DifNCxDescuentoCredito (FI IN VARCHAR2, FF IN VARCHAR2, aTipoUsuario NUMBER) RETURN NUMBER IS

var
   ArrayVar: Variant;
   aYear,fdesde,fhasta : string;
   i:byte;
begin
    with fSumaryCD do
    begin
        ArrayVar:=VarArrayCreate([0,0],VarVariant);
        ArrayVar[0]:=iACodeUser;
        iSubPubUsers := fVarios.ExecuteFunction(C_VENTAS_X_USUARIO,ArrayVar);
        iSalesWOPubUsers := fVarios.ExecuteFunction(C_VENTAS_SIN_USUARIO,ArrayVar);

        ArrayVar:=VarArrayCreate([0,2],VarVariant);
        ArrayVar[0]:=DateIni;
        ArrayVar[1]:=DateFin;
        ArrayVar[2]:=iACodeUser;


        //******************************************************************
        fdesde:=trim(copy(DateIni,0,10));
        fhasta:=trim(copy(Datefin,0,10));

          i:=1;
         with tsqlquery.Create(application) do
       try
        SQLConnection := mybd;
        // sql.Add(format('SELECT DISTINCT  SUBSTR(NUMOBLEA,2,1)   FROM TOBLEAS  I WHERE ESTADO=''C'' and I.FECHA_CONSUMIDA BETWEEN  TO_date(%s,''dd/mm/yyyy'') AND TO_date(%s,''dd/mm/yyyy'' )',[fdesde,fhasta]));

        sql.Add('SELECT DISTINCT  SUBSTR(NUMOBLEA,2,1)   FROM TOBLEAS  I WHERE ESTADO=''C'' and I.FECHA_CONSUMIDA BETWEEN  TO_date('+#39+fdesde+#39+',''dd/mm/yyyy'') AND TO_date('+#39+fhasta+#39+',''dd/mm/yyyy'')');
        Open;
        First;
        while not Eof  do
             begin

                if i=1 then
                begin
                      iPOblea1:=trim(fields[0].asstring);
                       i:=2;
                end else
                begin
                      iPOblea2:=trim(fields[0].asstring);
                       i:=1;
                 end;

               Next;

             end ;
         finally
        free;
      end;

    ///****************************************************************************




        iTtlDifConvCredito := fVarios.ExecuteFunction(C_DIF_CONVENIO_CREDITO,ArrayVar);
        iTtlDifNcxDesc := fVarios.ExecuteFunction(C_DIF_NC_X_DESCUENTO,ArrayVar);
        iTtlDifxConvenio := fVarios.ExecuteFunction(C_DIF_X_CONVENIO,ArrayVar);
        iTtlDifxNcxDescCred:= fVarios.ExecuteFunction(C_DIF_NC_X_DESCUENTO_CREDITO,ArrayVar);

        iOCreditSales := fVarios.ExecuteFunction(C_VENTAS_A_CREDITO,ArrayVar);
        iContSales :=  FloatToStr(StrToFloat(iSalesWOPubUsers)- StrToFloat(iOCreditSales) - StrToFloat(iTtlDifNcxDesc) - StrToFloat(iTtlDifxConvenio) - StrToFloat(iTtlDifConvCredito));

        iIvaContSales := fVarios.ExecuteFunction(C_IVA_VENTAS_A_CONTADO,ArrayVar);

        iTtlContSales := FloatToStr(StrToFloat(iContSales) + StrToFloat(iIvaContSales));

        iNAC := fVarios.ExecuteFunction(C_INS_PASADAS,null);
        iNR  := fVarios.ExecuteFunction(C_INS_NO_PASADAS,null);
        iNACR := IntToStr(StrToInt(iNAC) + StrToInt(iNR));


        aYear := IntToStr(StrToInt(Copy(DateBD(MyBD),10,1)) mod 10);

        ArrayVar:=VarArrayCreate([0,3],VarVariant);
        ArrayVar[0]:=DateIni;
        ArrayVar[1]:=DateFin;

        ArrayVar[2]:=aYear;
        ArrayVar[3]:=iPOblea1;
        iNOblCYP1 := fVarios.ExecuteFunction(C_N_OBLEAS,ArrayVar);
        FOblCYearP1 := fVarios.ExecuteFunction(C_MIN_OBLEAS,ArrayVar);
        LOblCYearP1 := fVarios.ExecuteFunction(C_MAX_OBLEAS,ArrayVar);

        ArrayVar[2]:=aYear;
        ArrayVar[3]:=iPOblea2;
        iNOblCYP2 := fVarios.ExecuteFunction(C_N_OBLEAS,ArrayVar);
        FOblCYearP2 := fVarios.ExecuteFunction(C_MIN_OBLEAS,ArrayVar);
        LOblCYearP2 := fVarios.ExecuteFunction(C_MAX_OBLEAS,ArrayVar);

        ArrayVar[2]:= IntToStr((StrToInt(aYear) + 1) mod 10);
       ArrayVar[3]:=iPOblea1;
        iNOblNYP1 := fVarios.ExecuteFunction(C_N_OBLEAS,ArrayVar);
       FOblNYearP1 := fVarios.ExecuteFunction(C_MIN_OBLEAS,ArrayVar);
        LOblNYearP1 := fVarios.ExecuteFunction(C_MAX_OBLEAS,ArrayVar);

        ArrayVar[2]:= IntToStr((StrToInt(aYear) + 1) mod 10);
        ArrayVar[3]:= iPOblea2;
        iNOblNYP2 := fVarios.ExecuteFunction(C_N_OBLEAS,ArrayVar);
        FOblNYearP2 := fVarios.ExecuteFunction(C_MIN_OBLEAS,ArrayVar);
        LOblNYearP2 := fVarios.ExecuteFunction(C_MAX_OBLEAS,ArrayVar);

        ArrayVar:=VarArrayCreate([0,1],VarVariant);
        ArrayVar[0]:=DateIni;
        ArrayVar[1]:=DateFin;
        iOblAnula := fVarios.ExecuteFunction(C_N_ANULADAS,ArrayVar);
        iOblInutil := fVarios.ExecuteFunction(C_N_INUTILIZADAS,ArrayVar);

        Observaciones := '';
    end;
end;

procedure TFControlDiario.ResumenClick(Sender: TObject);
begin
    with TFSumaryCD.CreateByCD(fSumaryCD) do
    try
        Caption := Format('Resumen de Resultados C.D. en:  %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
        ShowModal;
        fSumaryCD := SumaryCD;
    finally
        Free;
    end;
end;

procedure TFControlDiario.SBBusquedaClick(Sender: TObject);
begin
    try
        Enabled := False;
        try
            If not GetDates(DateIni,DateFin) then Exit;

            FTmp.Temporizar(TRUE,FALSE,'Control diario', 'Generando el informe control diario.');

            with TFPrevioControlDiario.Create(Application) do
            try
                Caption := Format('Petición de parámetros. Control Diario en:  %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                if not (ShowModal = mrOk)
                then exit;
                fSumaryCD := SumaryCD;
                QTotalControlDiario.Close;
                SVControlDiario.Close;
                MVControlDiario.Close;
            finally
                Free;
            end;

            Application.ProcessMessages;

            Caption := Format('Control Diario. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
            DoControlDiario;

            QTotalControlDiario.Open;
            SVControlDiario.Open;
            MVControlDiario.Open;
            RBTipoVehiculo.Value := MVControlDiario.FieldByName('TIPOVEHICULO_ID').AsString;
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


procedure TFControlDiario.PrintClick(Sender: TObject);
begin
    with TFDialogPrint.Create(Application) do
    try
       if ShowModal = mrOk
       then begin
            case Imprimir of
                tiGeneral: begin
                    with TFPrintControlDiario.Create(Application) do
                    try
                        Execute(DateIni,DateFin,PutEstacion,MyBD);
                    finally
                        Free;
                    end;
                end;

                tiResumen: begin
                    with TFPrintControlDiarioSumary.Create(Application) do
                    try
                        Execute(DateIni,DateFin,PutEstacion,fSumaryCD);
                    finally
                        Free;
                    end;
                end;

                else begin
                    with TFPrintControlDiario.Create(Application) do
                    try
                        Execute(DateIni,DateFin,PutEstacion,MyBD);
                    finally
                        Free;
                    end;

                    with TFPrintControlDiarioSumary.Create(Application) do
                    try
                        Execute(DateIni,DateFin,PutEstacion,fSumaryCD);
                    finally
                        Free;
                    end;
                end;
            end;
       end
    finally
        Free;
    end;
end;

procedure TFControlDiario.AscciClick(Sender: TObject);
begin
    with TFAsciiDialog.Create(Application) do
    try
       if ShowModal = mrOk
       then begin
            case ExportarAscii of

                teaGeneral:
                begin
                    with TFPrintControlDiario.Create(Application) do
                    try
                        ExportaAscii(DateIni,DateFin,PutEstacion,MyBD);
                    finally
                        Free;
                    end;
                end;

               teaResumen:
               begin
                    with TFPrintControlDiarioSumary.Create(Application) do
                    try
                        ExportaAscii(DateIni,DateFin,PutEstacion,fSumaryCD);
                    finally
                        Free;
                    end;
               end;

               else begin
                    with TFPrintControlDiario.Create(Application) do
                    try
                        ExportaAscii(DateIni,DateFin,PutEstacion,MyBD);
                    finally
                        Free;
                    end;

                    with TFPrintControlDiarioSumary.Create(Application) do
                    try
                        ExportaAscii(DateIni,DateFin,PutEstacion,fSumaryCD);
                    finally
                        Free;
                    end;
               end;
            end;
       end;
    finally
        Free;
    end;
end;

procedure TFControlDiario.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TFControlDiario.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;

procedure TFControlDiario.SExcelClick(Sender: TObject);
const
    F_TTL = 2;   C_TTL = 11;
    F_STT = 3;   C_STT = 11;
    F_INI = 8;  C_INI = 1;

    C_IVE = 2;
    C_IRE = 11;
    C_ITV = 4;
    C_ITR = 12;

    D_SUP = 3;   C_SUP = 10;
    D_VSP = 5;   C_VSP = 10;
    D_OVC = 8;   C_OVC = 10;
    D_DNC = 6;   C_DNC = 10;
    D_TCR = 7;   C_TCR = 10;   //ARGE RAN CD
    D_TNC = 9;   C_TNC = 10;   //ARGE RAN CD
    D_TDC = 10;  C_TDC = 10;   //ARGE RAN CD

    D_VCT = 12;   C_VCT = 10;
    D_IVC = 14;  C_IVC = 10;
    D_TVC = 16;  C_TVC = 10;
    D_SAC = 18;  C_SAC = 10;

    D_NAC = 2;   C_NAC = 16;
    D_AP1 = 4;   C_AP1 = 16;  C_APA = 17;  C_APB = 18;
    D_AP2 = 5;   C_AP2 = 16;  C_APC = 17;  C_APD = 18;
    D_NP1 = 6;   C_NP1 = 16;  C_NPA = 17;  C_NPB = 18;
    D_NP2 = 7;   C_NP2 = 16;  C_NPC = 17;  C_NPD = 18;
    D_SOU = 8;   C_SOU = 16;
    D_OBA = 9;   C_OBA = 16;
    D_OBI = 10;   C_OBI = 16;
    D_REC = 12;  C_REC = 16;
    D_ARC = 14;  C_ARC = 16;
    D_OBS = 16;  C_OBS = 12;
var
    ExcelApp, ExcelLibro, ExcelHoja: Variant;
    i,f ,obleasutiliz: integer;
    anu,inu: integer;
begin
  try
    DBVerificaciones.DataSource.DataSet.DisableControls;
    try
      opendialog.Title := 'Seleccione la Planilla de Entrada';
      if OpenDialog.Execute then
      begin
        FTmp.Temporizar(TRUE,FALSE,'Control Diario', 'Exportando los datos a excel');
        ExcelApp := CreateOleObject('Excel.Application');
        ExcelLibro := ExcelApp.Workbooks.open(OpenDialog.FileName);
(*        try
          ExcelHoja := ExcelLibro.Worksheets['Hoja1'];
        except
          ExcelHoja := ExcelLibro.Worksheets['Planilla Control Diario'];
        end;*)
          ExcelHoja := ExcelLibro.Worksheets[1];        

    f:= F_INI;
    excelHoja.cells[F_TTL,C_TTL].value := 'Control Diario';
    excelHoja.cells[F_STT,C_STT].value := Format('Planta nº: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);

    MVCONTROLDIARIO.First;
    while not MVCONTROLDIARIO.EOF do
    begin
        excelHoja.cells[f,C_INI].value := MVCONTROLDIARIO.FieldByName('TIPOVEHICULO_DES').AsString;
        SVCONTROLDIARIO.First;
        while not SVCONTROLDIARIO.EOF do
        begin
           // GRID VERIFICACIONES menos la columna total;
           for i := 0 to DBVerificaciones.Columns.Count - 2 do
                excelHoja.cells[f,(i+C_IVE)].value := SVCONTROLDIARIO.FieldByName(DBVerificaciones.Columns[i].FieldName).AsString;

           // GRID REVERIFICACIONES incluyendo la columna usuario usuario;
           for i := 1 to DBReVerificaciones.Columns.Count - 1 do
                excelHoja.cells[f,(i+C_IRE-1)].value := SVCONTROLDIARIO.FieldByName(DBReVerificaciones.Columns[i].FieldName).AsString;


            SVCONTROLDIARIO.Next;
            inc(f);
        end;
        MVCONTROLDIARIO.Next;
    end;

    // Ahora los totales

    QTOTALCONTROLDIARIO.First;
    for i := 0 to 6 do
        excelHoja.cells[f,(i+C_ITV)].value :=QTOTALCONTROLDIARIO.Fields[i].AsString;

    for i := 7 to 14 do
        excelHoja.cells[f,(i+ C_ITR - 7)].value := QTOTALCONTROLDIARIO.Fields[i].AsString;

    QTOTALCONTROLDIARIO.First;
    MVCONTROLDIARIO.First;
    SVCONTROLDIARIO.First;

    // Resumen
    with fSumaryCD do
    begin
       // usuarios publicos
       excelHoja.cells[(f + D_SUP), C_SUP].value :=Format('%.2f',[StrToFloat(iSubPubUsers)]);
       // sin usuarios publicos
       excelHoja.cells[(f + D_VSP), C_VSP].value :=Format('%.2f',[StrToFloat(iSalesWOPubUsers)]);
       // otras ventas crédito
       excelHoja.cells[(f + D_OVC), C_OVC].value :=Format('%.2f',[StrToFloat(iOCreditSales)-STRTOFLOAT(iTtlDifxNcxDescCred)]);
       // ventas contado
       excelHoja.cells[(f + D_VCT), C_VCT].value := Format('%.2f',[StrToFloat(iContSales)]);


       // Total Diferencia por Notas de Credito por Descuento Contado             CD
       excelHoja.cells[(f + D_TCR), C_TCR].value :=Format('%.2f',[StrToFloat(iTtlDifConvCredito)]);
       // Total Diferencia por Notas de Credito por Descuento                     CD
       excelHoja.cells[(f + D_TNC), C_TNC].value :=Format('%.2f',[StrToFloat(iTtlDifNcxDesc)]);
       // Total Diferencia por Descuento por Convenio                             CD
       excelHoja.cells[(f + D_TDC), C_TDC].value :=Format('%.2f',[StrToFloat(iTtlDifxConvenio)]);
       // Total Diferencia por Notas de Credito por Descuento Crédito             CD
       excelHoja.cells[(f + D_DNC), C_DNC].value :=Format('%.2f',[StrToFloat(iTtlDifxNcxDescCred)]);

       // iva Ventas Contado
       excelHoja.cells[(f + D_IVC), C_IVC].value :=Format('%.2f',[StrToFloat(iIvaContSales)]);
       // total ventas contado
       excelHoja.cells[(f + D_TVC), C_TVC].value :=Format('%.2f',[StrToFloat(iTtlContSales)]);
       // total en arqueo caja
       excelHoja.cells[(f + D_SAC), C_SAC].value :=Format('%.2f',[StrToFloat(iTtlArqueoCaja)]);

       // obleas saprobados y condicionales
       excelHoja.cells[(f + D_NAC), C_NAC].value :=iNAC;
       //mla dic-2010
      obleasutiliz:=0;
      with tsqlquery.Create(application) do
       try
        SQLConnection := mybd;
        sql.Add('SELECT CANTIDAD, MINOBLEA, MAXOBLEA, PROVEEDOR FROM  TTMPCDOBLEAS ORDER BY PROVEEDOR ');
        Open;
        First;
        while not Eof  do
             begin
                 //cantidad
                 excelHoja.cells[(f + D_AP1), C_AP1].value :=fields[0].asstring;
                //oblea menor año actual
                excelHoja.cells[(f + D_AP1), C_APA].value :=fields[1].asstring;
                //oblea mayor año actual
                excelHoja.cells[(f + D_AP1), C_APB].value :=fields[2].asstring;
                //Año-Proveedor
                excelHoja.cells[(f + D_AP1), C_AP1-4].value :=fields[3].asstring;

                obleasutiliz:= obleasutiliz + strtoint(fields[0].asstring);
               Next;
               inc(f);
             end ;
         finally
        free;
      end;

      f:=66;
       // subtotal obleas utilizadas
       excelHoja.cells[(f), C_SOU].value := obleasutiliz ;

       // obleas anuladas
       excelHoja.cells[(f+1), C_OBA].value :=iOblAnula;
       // obleas inutilizadas
       excelHoja.cells[(f+2) , C_OBI].value :=iOblInutil;


       // rechazados
       excelHoja.cells[(f+4), C_REC].value :=iNR;

       // total aptos, condicionales, rechazados
       excelHoja.cells[(f+6), C_ARC].value :=iNACR;


       // Observaciones
       excelHoja.cells[(f + D_OBS), C_OBS].value :=Observaciones;
    end;


      end;

      opendialog.Title := 'Seleccione la Planilla de Salida';
      if OpenDialog.Execute then
         excellibro.saveas(opendialog.filename);
      ExcelApp.Quit;
    except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,30,FICHERO_ACTUAL,'Error cerrando la ficha de UfResumenDescuentosGNC: %s', [E.message]);
                MessageDlg('Exportación','La exportación no ha podido efectuarse correctamente',mtInformation,[mbOK],mbOk,0);
            end
    end;
  finally
      DBVerificaciones.DataSource.DataSet.enableControls;
      FTmp.Temporizar(FALSE,FALSE,'','');
      application.ProcessMessages;
  end;

end;

procedure TFControlDiario.btnExportarClick(Sender: TObject);
begin
   DoExportacionCDiarioVTV(dateini, datefin);
   DoExportacionEnte_New(dateini, datefin);
end;

end.

