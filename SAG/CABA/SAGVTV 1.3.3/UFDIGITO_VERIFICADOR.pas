unit UFDIGITO_VERIFICADOR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, SqlExpr, Provider, DBClient, USAGESTACION, SpeedBar, ExtCtrls,
  StdCtrls, Mask, DBCtrls, Buttons, RXLookup, ComCtrls, ComObj, DBXpress,
  FMTBcd, Grids, DBGrids, RXDBCtrl;

type
  TFDigito_Verificador = class(TForm)
    SBarPrincipal: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    BExcel: TSpeedItem;
    SBBusqueda: TSpeedItem;
    SBSalir: TSpeedItem;
    OpenDialog: TOpenDialog;
    DBGrid1: TDBGrid;
    DSTResultadosInspeccion: TDataSource;
    Button1: TButton;
    ClientDataSet1: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    SQLDataSet1: TSQLDataSet;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SBSalirClick(Sender: TObject);
    procedure OnOpen (Sender: TObject);
    procedure OnClose (Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    bErrorCreando : boolean;
    NombreEstacion, NumeroEstacion, DateIni, DateFin: string;
    function PutEstacion : string;
  end;

  procedure Digito_Verificador;

var
  FDigito_Verificador: TFDigito_Verificador;

implementation

{$R *.dfm}

uses
   UCDIALGS,
   ULOGS,
   UGETDATES,
   UFTMP,
   GLOBALS,
   UUTILS,
   USAGVARIOS;

  resourcestring
      FICHERO_ACTUAL = 'UFDIGITO_VERIFICADOR';

procedure Digito_Verificador;
    BEGIN
      with TFDigito_Verificador.Create(Application) do
        try
            try
                if bErrorCreando then exit;
                If not GetDates(DateIni,DateFin) then Exit;
                Caption := Format('Patentes Digito Verificador. Planta: %S. (%S - %S)', [PutEstacion,Copy(DateIni,1,10), Copy(DateFin,1,10)]);
                FTmp.Temporizar(TRUE,FALSE,'Digito Verificador', 'Generando el Reporte.');

                Application.ProcessMessages;

                FTmp.Temporizar(FALSE,FALSE,'', '');
                ShowModal;
            except
                on E: Exception do
                begin
                    FTmp.Temporizar(FALSE,FALSE,'', '');
                    Application.ProcessMessages;
                    FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Digito Verificador - Reporte Cancelado por: %s', [E.message]);
                    MessageDlg('Generación de reporte.', 'El reporte no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)
                end
            end
        finally
            Free;
            Application.ProcessMessages;
        end;
    END;

    function TFDigito_Verificador.PutEstacion : string;
    begin
        NombreEstacion := fVarios.NombreEstacion;
        NumeroEstacion := Format('%d'+'%d',[fVarios.Zona, fVarios.CodeEstacion]);
        Result := NumeroEstacion + ' ' + NombreEstacion;
    end;

procedure TFDigito_Verificador.FormCreate(Sender: TObject);
    begin
        bErrorCreando := False;

        if (not MyBD.InTransaction) then MyBD.StartTransaction(td);
        try

        SQLDataSet1.SQLConnection := mybd;
        SQLDataSet1.CommandType := ctQuery;
        SQLDataSet1.GetMetadata := false;
        SQLDataSet1.NoMetadata := true;
        SQLDataSet1.ParamCheck := false;
        DataSetProvider1.DataSet := SQLDataSet1;
        DataSetProvider1.Options := [poIncFieldProps,poAllowCommandText];

        With ClientDataSet1 do
        Try
            close;
            SetProvider(DataSetProvider1);
            commandtext:='select * from vdigito_verificador';
            Open;

        Finally

        end;

        DSTResultadosInspeccion.DataSet:=ClientDataSet1;

        except
            on E:Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Reporte Cancelado por: %s', [E.message]);
                MessageDlg('Generación de Reporte.', 'El Reporte no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minuts, e intentelo de nuevo', mtError, [mbOk], mbOk, 0);
                bErrorCreando := True
            end
        end
    end;

procedure TFDigito_Verificador.FormDestroy(Sender: TObject);
begin
     try
        try
            if MyBD.InTransaction then MyBD.Rollback(td) // MyBD.Commit
            else raise Exception.Create('Se ha perdido la transacción de Bloqueo de la tabla temporal del informe')
        except
            on E: Exception do
            begin
                FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'Error cerrando la ficha del reporte: %s', [E.message]);
                MessageDlg('Generación de Informe.', 'Perdida de Transacciones: ' + E.message + #10 + #13 + 'Espere unos minutos e intentelo otra vez' , mtError, [mbOk], mbOk, 0)
            end
        end
    finally
        FTmp.Temporizar(FALSE,FALSE,'','');
    end
end;

procedure TFDigito_Verificador.OnClose (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Cerrando Excel.');
    Enabled := TRUE;
end;

procedure TFDigito_Verificador.OnOpen (Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Abriendo Excel y exportando los datos.');
    Enabled := FALSE;
end;

procedure TFDigito_Verificador.SBSalirClick(Sender: TObject);
begin
    FTmp.Temporizar(TRUE,FALSE,'Informes','Restableciendo las tablas temporales');
    ModalResult := mrOk;
end;

procedure TFDigito_Verificador.Button1Click(Sender: TObject);
begin

 SQLDataSet1.SQLConnection := mybd;
 SQLDataSet1.CommandType := ctQuery;
 SQLDataSet1.GetMetadata := false;
 SQLDataSet1.NoMetadata := true;
 SQLDataSet1.ParamCheck := false;
 DataSetProvider1.DataSet := SQLDataSet1;
 DataSetProvider1.Options := [poIncFieldProps,poAllowCommandText];

        With ClientDataSet1 do
        Try
            close;
            SetProvider(DataSetProvider1);
            commandtext:='select * from vdigito_verificador';
            Open;

        Finally

        end;

     DSTResultadosInspeccion.DataSet:=ClientDataSet1;

end;

end.
