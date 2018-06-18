unit UCOMPNFGNC;
{ Sirve para comprobar el n� factura o de nota de cr�dito impreso que se va a
  almacenar en TFACTURAS. Este form se muestra a los clientes de cr�dito que no
  van a abonar en el momento la cantidad a pagar por la inspecci�n realizada. }

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
    NumeroEstacion: integer; // N�mero de la estaci�n
    // -1 si no hay que cambiar el n�mero de oblea. Otro valor en caso contrario
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
    LBL_OBLEA = 'N� de oblea impreso:';
    FICHERO_ACTUAL = 'UCOMPNFGNC';

    MSJ_SISTEMA_INESTABLE = 'Ha ocurrido un error grave en la base de datos. El sistema est� inestable, con lo que deber� reiniciarlo de nuevo';
    MSJ_NUMOBLEA_MODIFICADO = 'El n�mero de oblea se ha modificado. �Est� seguro de que quiere cambiarlo?';
    MSJ_NUMOBLEA_OBLEAMAL = 'El n� oblea del veh�culo es incorrecto o no se encuentra almacenado. El formato correcto es: dd-dddddd';
    //MSJ_NUMOBLEA_OBLEAMAYOR = 'No puede emitir una oblea cuyo n�mero sea mayor al que se ha indicado.';

    HNT_COMP_NF = 'Compruebe si el n�mero de factura mostrada y la impresa coinciden';
    HNT_COMP_NC = 'Compruebe si el n�mero de nota de cr�dito mostrada y la impresa coinciden';
    HNT_COMP_OBLEA = 'Compruebe si el n�mero de oblea mostrada y la impresa coinciden';


    CABECERA_MENSAJES_OBLEA = 'Comprobar N�mero Oblea';

    MSJ_COMPNF_CAMBIARFACT = '�Realmente desea cambiar el n�mero de factura?';
    MSJ_CAJA_NUMFACTEXIST = 'Si desea cambiar el n�mero de factura deber� poner ' +
                             'un n�mero cuya factura no se haya emitido anteriormente. ' +
                             'Adem�s deber�a cambiar el pr�ximo n�mero de factura en la ' +
                             'pantalla de DATOS VARIABLES.';
    MSJ_CAJA_NUMFACERR = 'No se ha introducido un nuevo n�mero de factura o �ste es incorrecto. Introd�zcalo de nuevo por favor.';


var
   NumFacturaAuxiReimp: string; { N� factura auxiliar }



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

// Dado un n� factura con formato: abcd-nnnnnnnn, devuelve True si abcd se corresponde con el n� de la estaci�n
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
