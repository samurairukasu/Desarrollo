unit UCOMPNFGNC;
{ Sirve para comprobar el nº factura o de nota de crédito impreso que se va a
  almacenar en TFACTURAS. Este form se muestra a los clientes de crédito que no
  van a abonar en el momento la cantidad a pagar por la inspección realizada. }

{
  Ultima Traza: 14
  Ultima Incidencia: 5
  Ultima Anomalia: 3
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db, USAGCLASSES, FMTBcd, SqlExpr;


type
  TfrmComprobarNumOblReimpGNC = class(TForm)
    Bevel1: TBevel;
    lblComprobarNF: TLabel;
    edtNumFactura: TEdit;
    btnAceptar: TBitBtn;
    qryConsultas: TSQLQuery;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtNumFacturaEnter(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
  private
    { Private declarations }
    NumeroEstacion: integer; // Número de la estación
    // -1 si no hay que cambiar el número de oblea. Otro valor en caso contrario
    fNumeroOblea: integer;
    fptoventa: tptoventa;
    Ejercicio, Codinspgnc : string;
    CambioOblea : boolean;
    function NumEstacionCorrecto (sNumFactura: string): boolean;
    procedure RegistrarCambioNroOblea(aObleaAnterior, aObleaNueva: string);

  public
    { Public declarations }
    property NumeroOblea: integer read fNumeroOblea write fNumeroOblea;

    constructor CreateFromComprobarNOblea (const iNumeroOblea: integer; aEjercici,aCodinspgnc : string);
  end;

var
  frmComprobarNumOblReimpGNC: TfrmComprobarNumOblReimpGNC;

implementation

{$R *.DFM}

uses
    UCDIALGS,
    ULOGS,
    Globals,
    UINTERFAZUSUARIO,
    UUTILS,
    USAGESTACION;


resourcestring
    LBL_OBLEA = 'Nº de oblea impreso:';
    FICHERO_ACTUAL = 'UCOMPNFGNC';

    MSJ_SISTEMA_INESTABLE = 'Ha ocurrido un error grave en la base de datos. El sistema está inestable, con lo que deberá reiniciarlo de nuevo';
    MSJ_NUMOBLEA_MODIFICADO = 'El número de oblea se ha modificado. ¿Está seguro de que quiere cambiarlo?';
    MSJ_NUMOBLEA_OBLEAMAL = 'El nº oblea del vehículo es incorrecto o no se encuentra almacenado. El formato correcto es: dd-dddddd';
    //MSJ_NUMOBLEA_OBLEAMAYOR = 'No puede emitir una oblea cuyo número sea mayor al que se ha indicado.';

    HNT_COMP_NF = 'Compruebe si el número de factura mostrada y la impresa coinciden';
    HNT_COMP_NC = 'Compruebe si el número de nota de crédito mostrada y la impresa coinciden';
    HNT_COMP_OBLEA = 'Compruebe si el número de oblea mostrada y la impresa coinciden';


    CABECERA_MENSAJES_OBLEA = 'Comprobar Número Oblea';

    MSJ_COMPNF_CAMBIARFACT = '¿Realmente desea cambiar el número de factura?';
    MSJ_CAJA_NUMFACTEXIST = 'Si desea cambiar el número de factura deberá poner ' +
                             'un número cuya factura no se haya emitido anteriormente. ' +
                             'Además debería cambiar el próximo número de factura en la ' +
                             'pantalla de DATOS VARIABLES.';
    MSJ_CAJA_NUMFACERR = 'No se ha introducido un nuevo número de factura o éste es incorrecto. Introdúzcalo de nuevo por favor.';


var
   NumFacturaAuxiReimp: string; { Nº factura auxiliar }



constructor TfrmComprobarNumOblReimpGNC.CreateFromComprobarNOblea (const iNumeroOblea: integer; aEjercici, aCodinspgnc  : string);
begin
    inherited Create (Application);

    Self.Caption := CABECERA_MENSAJES_OBLEA;
    LblComprobarNF.Caption := LBL_OBLEA;
    edtNumFactura.Hint := HNT_COMP_OBLEA;

    fNumeroOblea := -1;
    NumFacturaAuxiReimp := formatoCeros(iNumeroOblea,8);
    edtNumFactura.Text := NumFacturaAuxiReimp;
    Ejercicio := aEjercici;
    Codinspgnc := aCodinspgnc;
    cambioOblea := false;
end;


procedure TfrmComprobarNumOblReimpGNC.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
    if (Key = Chr(VK_RETURN)) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;


procedure TfrmComprobarNumOblReimpGNC.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    qryConsultas.Close;
end;

procedure TfrmComprobarNumOblReimpGNC.FormDestroy(Sender: TObject);
begin
    qryConsultas.Close;
end;

procedure TfrmComprobarNumOblReimpGNC.FormCreate(Sender: TObject);
begin
    with qryConsultas do
    begin
        Close;
        SQLConnection := MyBD;
    end;
end;

// Dado un nº factura con formato: abcd-nnnnnnnn, devuelve True si abcd se corresponde con el nº de la estación
function TfrmComprobarNumOblReimpGNC.NumEstacionCorrecto (sNumFactura: string): boolean;
begin
    try
       Result := (StrToInt(Copy (sNumFactura, 1, 4)) = NumeroEstacion);
    except
         on E:Exception do
         begin
             Result := False;
             FAnomalias.PonAnotacion (TRAZA_SIEMPRE,3,FICHERO_ACTUAL, 'Error en NumEstacionCorrecto: ' + E.Message);
         end;
    end;
end;

procedure TfrmComprobarNumOblReimpGNC.edtNumFacturaEnter(Sender: TObject);
begin
    DestacarControl (Sender, clGreen, clWhite, False);
end;

procedure TfrmComprobarNumOblReimpGNC.RegistrarCambioNroOblea(aObleaAnterior, aObleaNueva: string);
begin
   with tObleasReemp.CreateByRowId(mybd,'') do
     try
       try
         append;
         valueByName[FIELD_EJERCICI] := ejercicio;
         ValueByName[FIELD_CODINSPGNC] := CODINSPGNC;
         ValueByName[FIELD_OBLEAVIEJA] :=  aObleaAnterior;
         ValueByName[FIELD_OBLEANUEVA] := aObleaNueva;
         post(true);
       except
         on E:Exception do
         begin
             FAnomalias.PonAnotacion (TRAZA_SIEMPRE,3,FICHERO_ACTUAL, 'Error al intentar grabar la tabla OBLEAS_REEMPL_GNC: ' + E.Message);
         end;
       end;
     finally
       free;
     end;
end;

procedure TfrmComprobarNumOblReimpGNC.btnAceptarClick(Sender: TObject);
var
  iNumero_ACambiar: String;

begin
    Self.Text := Trim (Self.Text);
        try
          if (edtNumFactura.Text <> NumFacturaAuxiReimp) then
          begin
              if NumObleaGNCCorrecto (edtNumFactura.Text) then
              begin
                  if (MessageDlg (CABECERA_MENSAJES_OBLEA, MSJ_NUMOBLEA_MODIFICADO, mtInformation, [mbYes, mbNo], mbNo, 0) = mrYes) then
                  begin
                      fNumeroOblea := strtoint(edtNumFactura.Text);
                      CambioOblea := true;
                  end
                  else
                  begin
                      edtNumFactura.Text := NumFacturaAuxiReimp
                  end;
              end
              else
              begin
                  MessageDlg (CABECERA_MENSAJES_OBLEA, MSJ_NUMOBLEA_OBLEAMAL, mtInformation, [mbOk], mbOk, 0);

                  edtNumFactura.Text := NumFacturaAuxiReimp;
                  edtNumFactura.setfocus;
              end;
          end;
        except
             on E:Exception do
                FAnomalias.PonAnotacion (TRAZA_SIEMPRE,5,FICHERO_ACTUAL,'Error en edtNumeroObleaExit: ' + E.Message);
        end;
   if CambioOblea then
     RegistrarCambioNroOblea(NumFacturaAuxiReimp, edtNumFactura.Text);
end;

end.
