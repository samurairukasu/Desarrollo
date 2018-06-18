unit UReimpCer;
// Reimpresi�n de Certificados e Informes de inspecci�n

{
  Ultima Traza: 15
  Ultima Incidencia:
  Ultima Anomalia: 4
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db, FMTBcd, SqlExpr;

type
  TfrmReimpresionCertificados = class(TForm)
    Bevel1: TBevel;
    lblMatricula: TLabel;
    edtMatricula: TEdit;
    lblInforme: TLabel;
    edtInformeInspeccion: TEdit;
    ChkBxBusquedaMatricula: TCheckBox;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    qryConsultas: TSQLQuery;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnAceptarClick(Sender: TObject);
    procedure ChkBxBusquedaMatriculaClick(Sender: TObject);
    procedure ChkBxBusquedaMatriculaKeyPress(Sender: TObject;
      var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure edtMatriculaExit(Sender: TObject);
    procedure edtMatriculaEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fRowidVehiculo: string;
    fEjercicio, fCodigoInsp: integer;
    ZonaEstacion, CodigoEstacion: integer;


    function ExisteVehiculo_TVEHICULOS: boolean;
    procedure ActivarDesactivarInforme (const bActivar: boolean);
    function Sumar_1900 (iAnio: integer): integer;

  public
    { Public declarations }
    // Almacena el rowid del veh�culo
    property RowidVehiculo: string read fRowidVehiculo write fRowidVehiculo;
    property Ejercicio: integer read fEjercicio write fEjercicio;
    property CodigoInspeccion: integer read fCodigoInsp write fCodigoInsp;
    // Devuelve True si el n� de informe de inspecci�n introducido existe en TINSPECCION y la inspecci�n est� finalizada
    function Existe_InformeInspeccion_TINSPECCION: boolean;

    constructor CreateFromInforme (const iZona, iCodEstac: integer);
    constructor CreateFromCertificado (const iZona, iCodEstac: integer);
  end;

var
  frmReimpresionCertificados: TfrmReimpresionCertificados;

implementation

{$R *.DFM}

uses
   UCDIALGS, ULOGS, GLOBALS, USAGVARIOS, USAGDOMINIOS, USAGESTACION,
   USAGCLASSES, UINTERFAZUSUARIO;

const
  PRIMER_ANIO_SIGLO20 = 70; { El 1er. a�o del siglo XX a tener en cuenta es 1970 }
  ULTIMO_ANIO_SIGLO20 = 99; { El �ltimo a�o del siglo XX a tener en cuenta es 1999 }


resourcestring
    CABECERA_MENSAJES_REIMPNC = 'Reimpresi�n Certificados';
    CABECERA_MENSAJES_REIMPINF = 'Reimpresi�n I.Inspecci�n';
    FICHERO_ACTUAL = 'UReimpCer';

    { Mensajes enviados al usuario desde REIMPCER }
    MSJ_REIMPCER_CODINSPNOVAL = 'El c�digo de inspecci�n introducido no es v�lido o no se ha introducido';
    MSJ_ENTDTVEH_DOMNOVAL = 'El formato del dominio introducido es ' +
          'incorrecto. Deber�a introducir, o bien tres letras y tres d�gitos '+
          '(por ejemplo: AAA111) o bien una letra y siete d�gitos (por ejemplo: A1234567). ' +
          'De todas formas, �Desea continuar realizando la inspecci�n del veh�culo?';
    MSJ_REIMPFNC_MATNOEX = 'La patente introducida no se encuentra almacenada.';


procedure TfrmReimpresionCertificados.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
    if (Key = Chr(VK_RETURN)) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

// Devuelve True si la patente est� almacenada en TVEHICULOS
function TfrmReimpresionCertificados.ExisteVehiculo_TVEHICULOS: boolean;
begin
    result := False;
    try
       with qryConsultas do
       begin
           Close;
           Sql.Clear;
           Sql.Add (Format('SELECT %s FROM %s WHERE %s=''%s'' or %s=''%s''',[FIELD_ROWID, DATOS_VEHICULOS, FIELD_PATENTEN, edtMatricula.Text,FIELD_PATENTEA, edtMatricula.Text]));
           {$IFDEF TRAZAS}
             FTrazas.PonComponente (TRAZA_FLUJO,10,FICHERO_ACTUAL,qryConsultas);
           {$ENDIF}
           Open;
           Application.ProcessMessages;
       end;
       if (qryConsultas.Fields[0].AsString <> '') then
       begin
           Result := True;
           fRowidVehiculo := qryConsultas.Fields[0].AsString;
       end;
    except
         on E:Exception do
         begin
             Result := False;
             FAnomalias.PonAnotacion (TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'No existe el veh�culo en TVEHICULOS' + E.Message);
         end;
    end;
end;

// Devuelve True si el n� de informe de inspecci�n introducido existe en TINSPECCION y la inspecci�n est� finalizada
function TfrmReimpresionCertificados.Existe_InformeInspeccion_TINSPECCION: boolean;
var
  iZona, iEstacion, iEjercicio, iCodInsp: integer; { var. auxi. que nos indican si existe el c�digo de
                                                    inspecci�n en una zona y planta determinada }
begin
    Result := False;
    try
       iZona := StrToInt(Copy (edtInformeInspeccion.Text, 4, 4));
       iEstacion := StrToInt(Copy (edtInformeInspeccion.Text, 8, 4));
       iEjercicio := StrToInt(Format ('%0.4d', [Sumar_1900(StrToInt(Copy (edtInformeInspeccion.Text, 1, 2)))]));
       iCodInsp := StrToInt(Copy (edtInformeInspeccion.Text, 12, 6));

       if ((iZona = ZonaEstacion) and (iEstacion = CodigoEstacion)) then
       begin
           try
              with qryConsultas do
              begin
                  Close;
                  Sql.Clear;
                  Sql.Add (Format('SELECT %s,%s FROM %s WHERE %s=%d and %s=%d and INSPFINA=''S''',[FIELD_EJERCICI, FIELD_CODINSPE, DATOS_INSPECCIONES, FIELD_EJERCICI, iEjercicio,FIELD_CODINSPE, iCodInsp]));
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
              end;
           except
                on E:Exception do
                begin
                    Result := False;
                    FAnomalias.PonAnotacion (TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'No existe el veh�culo en TVEHICULOS' + E.Message);
                end;
           end;
       end;
    except
         on E:Exception do
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'Error en Existe_InformeInspeccion_TINSPECCION: ' + E.Message);
    end;
end;



procedure TfrmReimpresionCertificados.btnAceptarClick(Sender: TObject);
var
   Tecla_Pulsada: integer;

begin
    if (not chkBxBusquedaMatricula.Checked) then
    begin
        {if (not TSagInspeccion.Is_Correct (edtInformeInspeccion.Text)) then
        begin
            MessageDlg (CABECERA_MENSAJES_REIMPNC,MSJ_REIMPCER_CODINSPNOVAL, mtInformation, [mbOk], mbOk, 0);
            Tecla_Pulsada := PULSADO_NO;
            edtInformeInspeccion.setfocus;
        end
        else} if (not Existe_InformeInspeccion_TINSPECCION) then
        begin
            MessageDlg (CABECERA_MENSAJES_REIMPNC,MSJ_REIMPCER_CODINSPNOVAL, mtInformation, [mbOk], mbOk, 0);
            //Tecla_Pulsada := PULSADO_NO;
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
    end
    else
    begin
        if ExisteVehiculo_TVEHICULOS then
        begin
            if (not (TDominio.TipoDominio (edtMatricula.Text) in [ttdmAntiguo, ttdmAutos, ttdmMotos, ttdmTractor])) then      //mb
            begin
                Tecla_Pulsada := MessageDlg (CABECERA_MENSAJES_REIMPNC,MSJ_ENTDTVEH_DOMNOVAL, mtInformation, [mbYes, mbNo], mbYes, 0);
            end
            else
               Tecla_Pulsada := mrYes;

            if (Tecla_Pulsada = mrYes) then
            begin
                {$IFDEF TRAZAS}
                   FTrazas.PonComponente (TRAZA_FORM,8,FICHERO_ACTUAL,Self);
                {$ENDIF}
                ModalResult := mrOk
            end
        end
        else
        begin
            // La patente introducida no existe en TVEHICULOS
            MessageDlg (CABECERA_MENSAJES_REIMPNC, MSJ_REIMPFNC_MATNOEX, mtInformation, [mbOk], mbOk, 0);
            {$IFDEF TRAZAS}
              FTrazas.PonAnotacion (TRAZA_FLUJO,2,FICHERO_ACTUAL,'Se ha intentado reimprimir el certificado de un veh�culo que no est� en TVEHICULOS');
            {$ENDIF}
            edtMatricula.setfocus;
        end;
    end
end;


procedure TfrmReimpresionCertificados.ChkBxBusquedaMatriculaClick(Sender: TObject);
begin
    if (chkBxBusquedaMatricula.Checked) then
    begin
        edtInformeInspeccion.Text := '';
        ActivarDesactivarInforme (False);
        edtMatricula.setfocus;
    end
    else
    begin
        edtMatricula.Text := '';
        ActivarDesactivarInforme (True);
        edtInformeInspeccion.setfocus;
    end
end;

procedure TfrmReimpresionCertificados.ChkBxBusquedaMatriculaKeyPress(
  Sender: TObject; var Key: Char);
begin
    ChkBxBusquedaMatriculaClick(Sender);
end;


procedure TfrmReimpresionCertificados.ActivarDesactivarInforme (const bActivar: boolean);
begin
    lblInforme.Enabled := bActivar;
    edtInformeInspeccion.Enabled := bActivar;

    lblMatricula.Enabled := not bActivar;
    edtMatricula.Enabled := not bActivar;
end;


procedure TfrmReimpresionCertificados.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    qryConsultas.Close;
end;

procedure TfrmReimpresionCertificados.FormCreate(Sender: TObject);
begin
    with qryConsultas do
    begin
        Close;
        SQLConnection := MyBD;
    end;
end;


function TfrmReimpresionCertificados.Sumar_1900 (iAnio: integer): integer;
{ Suma 1900 si el a�o est� comprendido entre 70-99 y Suma 2000 si iAnio est�
  comprendido entre 00-69. Devuelve 0 si se ha producido alg�n error }
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



procedure TfrmReimpresionCertificados.edtMatriculaExit(Sender: TObject);
begin
    Text := Trim(Self.Text);



    AtenuarControl (Sender, False);
end;

procedure TfrmReimpresionCertificados.edtMatriculaEnter(Sender: TObject);
begin
    DestacarControl (Sender, clGreen, clWhite, False);
end;

constructor TfrmReimpresionCertificados.CreateFromInforme (const iZona, iCodEstac: integer);
begin
    inherited Create (Application);

    ZonaEstacion := iZona;
    CodigoEstacion := iCodEstac;

    Caption := CABECERA_MENSAJES_REIMPINF;
    ActivarDesactivarInforme (True);
end;

constructor TfrmReimpresionCertificados.CreateFromCertificado (const iZona, iCodEstac: integer);
begin
    inherited Create (Application);

    ZonaEstacion := iZona;
    CodigoEstacion := iCodEstac;

    Caption := CABECERA_MENSAJES_REIMPNC;
    ActivarDesactivarInforme (False);
end;


procedure TfrmReimpresionCertificados.FormShow(Sender: TObject);
begin
//    if edtMatricula.Enabled
//    then begin
        ChkBxBusquedaMatricula.Checked := True;
        edtMatricula.setfocus;
//    end
//    else begin
//        ChkBxBusquedaMatricula.Checked := False;
//        edtInformeInspeccion.setfocus;
//    end;
end;

end.
