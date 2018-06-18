unit ufDeclaracionJurada;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, uSagClasses, uSagEstacion, Globals, quickrpt, Qrctrls,
  ExtCtrls, sqlexpr, ucdialgs;

type
  TfrmDeclaracionJurada = class(TForm)
    qrDecJur: TQuickRep;
    QRBand1: TQRBand;
    qrlPlanta: TQRLabel;
    qrlnforme: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    qrlNroDJ: TQRLabel;
    qrlTelefono: TQRLabel;
    qrlDominio: TQRLabel;
    qrlMarca: TQRLabel;
    qrlModelo: TQRLabel;
    qrlUso: TQRLabel;
    qrlNombre1: TQRLabel;
    qrlDocumento1: TQRLabel;
    qrlDomicilio1: TQRLabel;
    qrlCiudad1: TQRLabel;
    qrlProvincia1: TQRLabel;
    qrlprovincia2: TQRLabel;
    qrlciudad2: TQRLabel;
    qrldomicilio2: TQRLabel;
    qrldocumento2: TQRLabel;
    qrlNombre2: TQRLabel;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape8: TQRShape;
    QRImage1: TQRImage;
    QRShape9: TQRShape;
    QRLabel30: TQRLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    ejercici, codinspe: string;
    fInspeccion : TInspeccion;
    fVehiculo : TVehiculo;
    fPropietario, fConductor : TClientes;
    fDecJurada : TDecJurada;
    TipoDec : char;
    procedure CompletarFormulario;
    function GetSecuenciaDJ: string;
  public
    { Public declarations }
    constructor CreateFromInspeccion(aejercici, acodinspe: string; const aTipo: char);
  end;
  procedure DoDeclaracionJurada(aejercici, acodinspe: string; const aTipo: char);

var
  frmDeclaracionJurada: TfrmDeclaracionJurada;

implementation

{$R *.DFM}

uses
ulogs,
UFTMP;

resourcestring
  FILE_NAME = 'ufDeclaracionJurada';

constructor TfrmDeclaracionJurada.CreateFromInspeccion(aejercici, acodinspe: string; const aTipo: char);
begin
{    fInspeccion := nil;
    fVehiculo := nil;
    fConductor := nil;
    fPropietario := nil;
    fDecJurada := nil;
    ejercici := aejercici;
    codinspe := aCodinspe;
    TipoDec := aTipo;
    inherited Create (Application);
    }
end;

procedure DoDeclaracionJurada(aejercici, acodinspe: string; const aTipo: char);
var
FPreviaPrint: TFTmp;
begin
with TfrmDeclaracionJurada.Create(nil) do
  try
    fInspeccion := nil;
    fVehiculo := nil;
    fConductor := nil;
    fPropietario := nil;
    fDecJurada := nil;

    ejercici := aejercici;
    codinspe := aCodinspe;

    FPreviaPrint:=TFTMP.Create(nil);

    try
      FPreviaPrint.muestraclock('Declaración Jurada','Procesando datos para imprimir la Declaración Jurada.');

      fInspeccion := TInspeccion.CreateFromDataBase(mybd, DATOS_INSPECCIONES, format('WHERE EJERCICI = %S AND CODINSPE = %S',[ejercici,codinspe]));
      fInspeccion.Open;

      fVehiculo := fInspeccion.GetVehiculo;
      fPropietario := fInspeccion.GetPropietario;
      fConductor := fInspeccion.GetConductor;

      fVehiculo.Open;
      fPropietario.Open;
      fConductor.Open;

      CompletarFormulario;
      qrDecJur.PrinterSetup;
      qrDecJur.Prepare;

      if aTipo = DJ_NUEVA then
        try
          fDecJurada := TDecJurada.CreateByRowId(mybd,'');
          fDecJurada.Open;
          fDecJurada.Append;
          fDecJurada.ValueByName[FIELD_EJERCICI] := aejercici;
          fDecJurada.ValueByName[FIELD_CODINSPE] := acodinspe;
          fDecJurada.Post(true);
        except
            on E: Exception do
            begin
              fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error inicializanco el formulario de recepcion por :%s',[E.Message]);
              MessageDlg(Caption,Format('Error Guardando los datos de la Declaración Jurada: %s. ',[E.message]), mtInformation, [mbOk],mbOk,0);
            end
        end;
    finally
      qrDecJur.Print;
      FPreviaPrint.Close;
      FPreviaPrint.Free;
      free;
    end;
  except
    on E: Exception do
      begin
        fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error inicializanco el formulario de recepcion por :%s',[E.Message]);
        MessageDlg(Caption,Format('Error Guardando los datos de la Declaración Jurada: %s. ',[E.message]), mtInformation, [mbOk],mbOk,0);
      end;
  end;
end;

procedure TfrmDeclaracionJurada.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmDeclaracionJurada.FormDestroy(Sender: TObject);
begin
fInspeccion.free;
fVehiculo.free;
fConductor.free;
fPropietario.free;
fDecJurada.Free;
end;

procedure TFrmDeclaracionJurada.CompletarFormulario;
begin
      qrlPlanta.Caption := fvarios.NombreEstacionCompleto;
      if TipoDec = DJ_NUEVA then
        qrlNroDJ.Caption := GetSecuenciaDJ
      else
      begin
        with TDecJurada.CreateByCodigo(MyBD,ejercici,codinspe) do
          try
            open;
            qrlNroDJ.Caption := ValueByName[FIELD_NRODECLARACION];
          finally
            free;
          end;
      end;
      qrlnforme.Caption := fInspeccion.Informe;
      qrlTelefono.Caption := fVarios.Telefono;

      qrlDominio.Caption := fVehiculo.GetPatente;
      qrlMarca.Caption := fVehiculo.Marca;
      qrlModelo.Caption := fVehiculo.Modelo;
      qrlUso.Caption := fVehiculo.Destino;

      qrlNombre1.Caption := fPropietario.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
      qrlDocumento1.Caption := fPropietario.ValueByName[FIELD_DOCUMENT];
      qrlDomicilio1.Caption := fPropietario.Domicilio;
      qrlCiudad1.Caption := fPropietario.ValueByName[FIELD_LOCALIDA];
      qrlProvincia1.Caption := fPropietario.Provincia;

      qrlNombre2.Caption := fConductor.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
      qrlDocumento2.Caption := fConductor.ValueByName[FIELD_DOCUMENT];
      qrlDomicilio2.Caption := fConductor.Domicilio;
      qrlCiudad2.Caption := fConductor.ValueByName[FIELD_LOCALIDA];
      qrlProvincia2.Caption := fConductor.Provincia;

end;

function TFrmDeclaracionJurada.GetSecuenciaDJ: string;
begin
  with tsqlquery.create(self) do
    try
       sqlconnection := mybd;
       Sql.Add('SELECT LAST_NUMBER FROM USER_SEQUENCES WHERE SEQUENCE_NAME=''SQ_DEC_JURADA_NRODECLARACION''');
       open;
       result := inttostr(fields[0].asinteger);
       close;
    finally
       free
    end;
end;


end.
