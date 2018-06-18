unit uSeleccionaNroInforme;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db, SQLExpr, Mask, FMTBcd;

type
  TfrmSeleccionaNroInforme = class(TForm)
    Bevel1: TBevel;
    lblInforme: TLabel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    qryConsultas: TSQLQuery;
    edtInformeInspeccion: TEdit;
    Label1: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure edtInformeInspeccionEnter(Sender: TObject);
    procedure edtInformeInspeccionExit(Sender: TObject);
  private
    { Private declarations }
    fRowidVehiculo, ffechaVencimiento: string;
    fEjercicio, fCodigoInsp: integer;
    function Sumar_1900 (iAnio: integer): integer;
  public
    { Public declarations }
    property Ejercicio: integer read fEjercicio write fEjercicio;
    property CodigoInspeccion: integer read fCodigoInsp write fCodigoInsp;
    property FechaVencimiento: string read ffechaVencimiento write ffechaVencimiento;
    // Devuelve True si el nº de informe de inspección introducido existe en TINSPECCION y la inspección está finalizada
    function Existe_InformeInspeccion_TINSPECCION: boolean;
  end;

  function SeleccInforme(const iZona, iCodEstac: integer; var aEjercicio, aCodigoInspeccion:integer; var aFecVenci: string): boolean;

var
  frmSeleccionaNroInforme: TfrmSeleccionaNroInforme;
  ZonaEstacion, CodigoEstacion: integer;

implementation

{$R *.DFM}

uses
   UCDIALGS, ULOGS, GLOBALS, USAGVARIOS, USAGDOMINIOS, USAGESTACION,
   USAGCLASSES, UINTERFAZUSUARIO;

const
  PRIMER_ANIO_SIGLO20 = 70; { El 1er. año del siglo XX a tener en cuenta es 1970 }
  ULTIMO_ANIO_SIGLO20 = 99; { El último año del siglo XX a tener en cuenta es 1999 }


resourcestring
    FICHERO_ACTUAL = 'uSeleccionaNroInforme';

    { Mensajes enviados al usuario desde REIMPCER }
    MSJ_REIMPCER_CODINSPNOVAL = 'El código de inspección introducido no es válido o no se ha introducido';


function SeleccInforme(const iZona, iCodEstac: integer; var aEjercicio, aCodigoInspeccion:integer; var aFecVenci: string):boolean;
begin
    ZonaEstacion := iZona;
    CodigoEstacion := iCodEstac;
    Result:=FalsE;
    try
        with TfrmSeleccionaNroInforme.Create(Application) do
        try
            if ShowModal = mrOk
            then begin
                aEjercicio:=ejercicio;
                aCodigoInspeccion:=CodigoInspeccion;
                aFecVenci:=FechaVencimiento;
                Result:=True;
            end;
        finally
            Free
        end
    finally
        Application.ProcessMessages
    end
end;


procedure TfrmSeleccionaNroInforme.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
    if (Key = Chr(VK_RETURN)) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;


// Devuelve True si el nº de informe de inspección introducido existe en TINSPECCION y la inspección está finalizada
function TfrmSeleccionaNroInforme.Existe_InformeInspeccion_TINSPECCION: boolean;
var
  iZona, iEstacion, iEjercicio, iCodInsp: integer; { var. auxi. que nos indican si existe el código de
                                                    inspección en una zona y planta determinada }
begin
    Result := False;
    try
       iZona := StrToInt(Copy (edtInformeInspeccion.Text, 4, 4));
       iEstacion := StrToInt(Copy (edtInformeInspeccion.Text, 8, 4));
       iEjercicio := StrToInt(Format ('%0.4d', [Sumar_1900(StrToInt(Copy (edtInformeInspeccion.Text, 1, 2)))]));
       iCodInsp := StrToInt(Copy (edtInformeInspeccion.Text, 12, length(edtInformeInspeccion.Text)));

       if ((iZona = ZonaEstacion) and (iEstacion = CodigoEstacion)) then
       begin
           try
              with qryConsultas do
              begin
                  Close;
                  Sql.Clear;
                  Sql.Add (Format('SELECT %s,%s,FECVENCI FROM %s WHERE %s=%d and %s=%d and INSPFINA=''S''',[FIELD_EJERCICI, FIELD_CODINSPE, DATOS_INSPECCIONES, FIELD_EJERCICI, iEjercicio,FIELD_CODINSPE, iCodInsp]));
                  {$IFDEF TRAZAS}
                    FTrazas.PonComponente (TRAZA_FLUJO,10,FICHERO_ACTUAL,qryConsultas);
                  {$ENDIF}
                  Open;
                  Application.ProcessMessages;
              end;
              if (qryConsultas.Fields[0].AsString <> '') then
              begin
                  Result := True;
                  Ejercicio := qryConsultas.Fields[0].AsInteger;
                  CodigoInspeccion := qryConsultas.Fields[1].AsInteger;
                  FechaVencimiento := qryConsultas.Fields[2].AsString;
              end;
           except
                on E:Exception do
                begin
                    Result := False;
                    FAnomalias.PonAnotacion (TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'No existe el vehículo en TVEHICULOS' + E.Message);
                end;
           end;
       end;
    except
         on E:Exception do
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'Error en Existe_InformeInspeccion_TINSPECCION: ' + E.Message);
    end;
end;



procedure TfrmSeleccionaNroInforme.btnAceptarClick(Sender: TObject);
var
   Tecla_Pulsada: integer;
begin
if pos('-',edtInformeInspeccion.text)=0 then
   begin

    Application.MessageBox( 'El formato ingresado es incorrecto Debe ingresar el siguiente formato: xx-xxxxxxxxxxxxxxx.',
  'Atención', MB_ICONSTOP );
       exit;
   end;
        if (not Existe_InformeInspeccion_TINSPECCION) then
        begin
            MessageDlg (caption,MSJ_REIMPCER_CODINSPNOVAL, mtInformation, [mbOk], mbOk, 0);
            edtInformeInspeccion.setfocus;
            exit;
        end
        else
           Tecla_Pulsada := mrYes;

        if (Tecla_Pulsada = mrYes) then
        begin
            {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_FORM,7,FICHERO_ACTUAL,Self);
            {$ENDIF}
            ModalResult := mrOk
        end;

end;


procedure TfrmSeleccionaNroInforme.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    qryConsultas.Close;
end;

procedure TfrmSeleccionaNroInforme.FormCreate(Sender: TObject);
begin
    with qryConsultas do
    begin
        Close;
        SQLConnection := MyBD;
    end;
end;


function TfrmSeleccionaNroInforme.Sumar_1900 (iAnio: integer): integer;
{ Suma 1900 si el año está comprendido entre 70-99 y Suma 2000 si iAnio está
  comprendido entre 00-69. Devuelve 0 si se ha producido algún error }
begin
    Result := 0;
    try
       if (iAnio in [PRIMER_ANIO_SIGLO20..ULTIMO_ANIO_SIGLO20]) then
           Result := 1900 + iAnio
       else
           Result := 2000 + iAnio
    except
         on E:Exception do
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,9,FICHERO_ACTUAL,'Error en Sumar_1900: ' + E.Message);
    end;
end;

procedure TfrmSeleccionaNroInforme.edtInformeInspeccionEnter(
  Sender: TObject);
begin
    DestacarControl (Sender, clGreen, clWhite, False);
end;

procedure TfrmSeleccionaNroInforme.edtInformeInspeccionExit(
  Sender: TObject);
begin
    Text := Trim(Self.Text);
    AtenuarControl (Sender, False);
end;

end.
