unit UFNewInspector;
{ Unidad para dar de alta a un Nuevo Inspector en la tabla INSPECTORES }

{
  Ultima Traza: 28
  Ultima Incidencia: 6
  Ultima Anomalia: 6
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db,
  UCTINSPECTORES, UCEdit, FMTBcd, SqlExpr, DBClient, SimpleDS, RxGIF;


type
  TfrmNuevoInspector = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    Bevel1: TBevel;
    lblNombreInspector: TLabel;
    lblPassword: TLabel;
    lblPassword2: TLabel;
    ChkBxSuperusuario: TCheckBox;
    edtNombreInspector: TColorEdit;
    edtPassword: TColorEdit;
    edtPassword2: TColorEdit;
    qryConsultas: TSQLQuery;
    ChEstado: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    edApellidoInspe: TColorEdit;
    Image1: TImage;
    procedure btnAceptarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function PasswordIguales (P1, P2: string): boolean;
    function CalcularNumeroInspector: tNumeroInspector;
    function ExisteInspector_TablaTREVISOR (Nombre_Inspector, Apellido_Inspector: string): boolean;
    function ExisteOtroSuperusuario_TREVISOR(sEsSuperUsuario: tEsSuperUsuario): boolean;
    function Devolver_NumeroInspector (Nombre_Inspector: tNombreInspector): tNumeroInspector;
    function Es_SoN(Valor: Boolean): Char;
  public
    { Public declarations }
    function AniadirInspectorTablaInspectores (NInsp: tNuevoInspector): boolean;
    function CambiarPasswordTablaInspectores (NInsp: tNuevoInspector): boolean;
    procedure CodificarPassword (NumInsp: tNumeroInspector; Pwd: tPasswordInspector; var PwdCodif: tPasswordInspector);
    procedure DecodificarPassword (NumInsp: tNumeroInspector; PwdCodif: tPasswordInspector; var Pwd: tPasswordInspector);
  end;


var
  frmNuevoInspector: TfrmNuevoInspector;

implementation

{$R *.DFM}

uses
   UCDIALGS,
   ULOGS,
   GLOBALS,
   USAGVARIOS,
   USAGESTACION,
   UFSEARCHINSPECTOR,
   USECUENCIADORES;

const
    MODULO_CLAVE = 32; { Módulo por el que se va a dividir para encriptar o
                   desencriptar la clave de un inspector }

resourcestring
      FICHERO_ACTUAL = 'UFNewInspector';
      CABECERA_MENSAJES_NINSP = 'Nuevo Inspector';
      { Mensajes enviados al usuario desde el form FrmNuevoInspector }
      MSJ_FRMINSP_NOMVAC = 'Debe introducir el nombre del inspector';
      MSJ_FRMINSP_PWDMAL = 'Las palabras clave introducidas no son iguales. Por favor, introdúzcalas de nuevo';
      MSJ_FRMINSP_LENPWDMAL = '¡ La clave Debe Tener al Menos 4 Caracteres !';
      MSJ_FRMINSP_INSNOEX = 'No se puede modificar la palabra clave del inspector porque sus datos no se encuentran almacenados';
      MSJ_FRMINSP_NUMNOEX = 'El número de inspector introducido no se encuentra almacenado';
      MSJ_FRMINSP_NOMNOEX = 'El nombre de inspector introducido no se encuentra almacenado';
      { Mensajes enviados al usuario desde NInsp }
      MSJ_NINSP_INSPEX = 'Lo siento, pero el nombre del inspector que desea añadir ya se encuentra almacenado';
      MSJ_NINSP_SUPEX = 'Lo siento, pero el ya se encuentra almacenado un superusuario del sistema';
      { Mensaje de sistema inestable }
      MSJ_SISTEMA_INESTABLE = 'Ha ocurrido un error grave en la base de datos. El sistema está inestable, con lo que deberá reiniciarlo de nuevo';



function TfrmNuevoInspector.Es_SoN(Valor: Boolean): Char;
Begin
  case Valor of
    false: Result:= 'N';
    true: Result:= 'S';
  end;
end;


// Devuelve True si P1 y P2 son iguales
function TfrmNuevoInspector.PasswordIguales (P1, P2: string): boolean;
begin
    { Devolvemos True si las password son iguales y no son cadenas vacías }
    Result := ((P1 = P2) and (P1 <> ''));
end;


function TfrmNuevoInspector.ExisteInspector_TablaTREVISOR (Nombre_Inspector, Apellido_Inspector: string): boolean;
begin
    with qryConsultas do
    begin
        try
          Close;
          Sql.Clear;
          Sql.Add('SELECT * FROM TREVISOR WHERE NOMREVIS = :NOMBRE AND APPEREVIS = :APELLIDO');
          Params[0].AsString:=Nombre_Inspector;
          Params[1].AsString:=Apellido_Inspector;
          {$IFDEF TRAZAS}
            FTrazas.PonComponente (TRAZA_SQL,13,FICHERO_ACTUAL,qryConsultas);
          {$ENDIF}
          Open;
          Application.ProcessMessages;
          {$IFDEF TRAZAS}
            FTrazas.PonRegistro (TRAZA_REGISTRO,1,FICHERO_ACTUAL,qryConsultas);
          {$ENDIF}
          Result := (qryConsultas.FieldByName(FIELD_NOMREVIS).AsString <> '');
        except
           on E:Exception do
           begin
               FAnomalias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL, 'ExisteInspector_TablaTREVISOR: ' + E.Message);
               Result := False;
           end;
        end;
    end;
end;


// Devuelve true si ya hay un superusuario almacenado en TREVISOR
function TFrmNuevoInspector.ExisteOtroSuperusuario_TREVISOR (sEsSuperUsuario: tEsSuperUsuario): boolean;
begin
    try
      with qryConsultas do
      begin
          Close;
          Sql.Clear;
          Sql.Add (Format('SELECT %s FROM %s WHERE %s=''S''',[FIELD_ESSUPERV, DATOS_TREVISOR, FIELD_ESSUPERV]));
          {$IFDEF TRAZAS}
            FTrazas.PonComponente (TRAZA_SQL,16,FICHERO_ACTUAL,qryConsultas);
          {$ENDIF}
          Open;
          Application.ProcessMessages;
      end;
      {$IFDEF TRAZAS}
        FTrazas.PonRegistro (TRAZA_REGISTRO,28,FICHERO_ACTUAL,qryConsultas);
      {$ENDIF}
      Result := (qryConsultas.Fields[0].AsString = ES_SUPERUSUARIO);
    except
        on E:Exception do
        begin
            Result := False;
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'Error al intentar ver si existe otro usuario en TREVISOR: ' + E.Message);
        end;
    end;
end;


// Añade un nuevo inspector a la tabla TREVISOR
function TfrmNuevoInspector.AniadirInspectorTablaInspectores (NInsp: tNuevoInspector): boolean;
var
iNumeroInspectorAuxi: integer;
FecAltaInsp: TDateTime;
PasswordCifrada: tPasswordInspector;
begin
Result := False;
  try
  { Hay que comprobar que sólo haya un único Supervisor del sistema }
  If (NInsp.sEsSuperUsuario = ES_SUPERUSUARIO) then
    begin
      if (ExisteOtroSuperusuario_TREVISOR(NInsp.sEsSuperUsuario)) then
        begin
          MessageDlg (CABECERA_MENSAJES_NINSP, MSJ_NINSP_SUPEX, mtInformation, [mbOk], mbOk, 0);
          {$IFDEF TRAZAS}
           FTrazas.PonAnotacion (TRAZA_FLUJO,4,FICHERO_ACTUAL,'Se intenta añadir un superusuario (y ya hay uno almacenado)');
          {$ENDIF}
           exit;
        end
    end;
  If (not ExisteInspector_TablaTREVISOR (NInsp.sNombre, NInsp.sApellido)) then
    begin
      FecAltaInsp := Now;
        if (not MyBD.InTransaction) then
          MyBD.InTransaction;
          with qryConsultas do
            begin
              try
                NInsp.sNumeroInspector := CalcularNumeroInspector;
                iNumeroInspectorAuxi :=  StrToInt(Format ('%0.2d%0.4d', [fVarios.CodeEstacion, NInsp.sNumeroInspector]));
                 { No se puede codificar la password hasta que no se tenga el nº de
                   inspector ya que la password depende directamente de este nº }
//                CodificarPassword (iNumeroInspectorAuxi, NInsp.sPassword, PasswordCifrada);

//                NInsp.sPassword := PasswordCifrada;
                Ninsp.sPassword:=Encriptar(NInsp.sPassword, NInsp.sNumeroInspector);
                Close;
                Sql.Clear;
                Sql.Add ('INSERT INTO TREVISOR (NUMREVIS, FECHALTA, NOMREVIS, APPEREVIS,PALCLAVE,ESSUPERV, ACTIVO)');
                Sql.Add ('  VALUES (:NInsp.sNumeroInspector,:FecAltaInsp,:NInsp.sNombre, :AppeRevis,:NInsp.sPassword,:NInsp.sEsSuperUsuario, :ACTIVO)');
                Params[0].AsInteger := NInsp.sNumeroInspector;
                Params[1].AsDateTime := FecAltaInsp;
                Params[2].AsString := NInsp.sNombre;
                Params[3].AsString := NInsp.SApellido;
                Params[4].AsString := NInsp.sPassword;
                Params[5].AsString := NInsp.sEsSuperUsuario;
                Params[6].Value := Es_SoN(ChEstado.Checked);
                {$IFDEF TRAZAS}
                FTrazas.PonComponente (TRAZA_SQL,17,FICHERO_ACTUAL,qryConsultas);
                {$ENDIF}
                ExecSQL;
                Application.ProcessMessages;
                {$IFDEF TRAZAS}
                FTrazas.PonAnotacion (TRAZA_FLUJO,5,FICHERO_ACTUAL,'Se ha añadido un inspector correctamente');
                {$ENDIF}
                ShowMessage('Nuevo Inspector','El inspector se ha creado con exito!');
                Result := True;
              except
                on E:Exception do
                  begin
                    FAnomalias.PonAnotacion (TRAZA_SIEMPRE,3,FICHERO_ACTUAL, 'Error en AniadirInspectorTablaInspectores: ' + E.Message);
                    Result := False;
                  end;
               end;
            end;
           { hacemos un COMMIT }
        if MyBd.InTransaction then
          MyBD.Commit(td);
    end
  else
    begin
      MessageDlg (CABECERA_MENSAJES_NINSP, MSJ_NINSP_INSPEX, mtInformation, [mbOk], mbOk, 0);
      {$IFDEF TRAZAS}
      FTrazas.PonAnotacion (TRAZA_FLUJO,6,FICHERO_ACTUAL,'El inspector ya existe el inspector en TREVISOR');
      {$ENDIF}
      Result := False;
    end;
  finally
  end;
end;


////////////////////////////////////////////////////////////////////////////////////////////////////
// Modifica la palabra clave de un inspector en la tabla INSPECTORES                              //
////////////////////////////////////////////////////////////////////////////////////////////////////
function TfrmNuevoInspector.CambiarPasswordTablaInspectores (NInsp: tNuevoInspector): boolean;
var
   Numero_De_Inspector: tNumeroInspector; // var. auxi. que almacena temporalmente el nº inspector
   PasswordCifrada: tPasswordInspector;   // Var. aux. que almacenará la password cifrada

begin
    try
       // Leemos el nombre del inspector y la password a cambiar
       if (ExisteInspector_TablaTREVISOR (NInsp.sNombre, NInsp.sApellido)) then
       begin
           // Buscamos el Nº inspector, necesario para cifrar la password
           Numero_De_Inspector := Devolver_NumeroInspector (NInsp.sNombre);
           Numero_De_Inspector := StrToInt(Format ('%0.2d%0.4d', [fVarios.CodeEstacion, Numero_De_Inspector]));
           { Ciframos la password }
           CodificarPassword (Numero_De_Inspector, NInsp.sPassword, PasswordCifrada);
           NInsp.sPassword := PasswordCifrada;

            if (not MyBd.InTransaction) then
               MyBd.InTransaction;

            with qryConsultas do
            begin
                try
                  Close;
                  Sql.Clear;
                  Sql.Add (Format ('UPDATE %s SET %s=''%s'' WHERE %s=''%s''',[DATOS_TREVISOR, FIELD_PALCLAVE, NInsp.sPassword, FIELD_NOMREVIS, NInsp.sNombre]));
                  {$IFDEF TRAZAS}
                    FTrazas.PonComponente (TRAZA_SQL,19,FICHERO_ACTUAL,qryConsultas);
                  {$ENDIF}
                  ExecSQL;
                  Application.ProcessMessages;
                  {$IFDEF TRAZAS}
                    FTrazas.PonAnotacion (TRAZA_FLUJO,9,FICHERO_ACTUAL,'Se ha modificado la password de un inspector correctamente');
                  {$ENDIF}
                  ShowMessage('Cambio de Clave','La clave del inspector ha sido modificada!');
                  Result := True;
                except
                   on E:Exception do
                   begin
                       FAnomalias.PonAnotacion (TRAZA_SIEMPRE,4,FICHERO_ACTUAL, 'NO se ha modificado la password de un inspector correctamente: ' + E.Message);
                       Result := False;
                   end;
                end;
            end;

            if MyBd.InTransaction then
               MyBd.Commit(td);
       end
       else
       begin
           MessageDlg (CABECERA_MENSAJES_NINSP, MSJ_FRMINSP_INSNOEX, mtInformation, [mbOk], mbOk, 0);
           {$IFDEF TRAZAS}
             FTrazas.PonAnotacion (TRAZA_FLUJO,11,FICHERO_ACTUAL,'El inspector NO existe el inspector en TINSPECTORES');
           {$ENDIF}
           Result := False;
           ModalResult := mrNone;
       end;
    finally
    end;
end;


// Devuelve el nº asociado al nuevo inspector
function TfrmNuevoInspector.CalcularNumeroInspector: tNumeroInspector;
var
  aSequence: TSecuenciadores;
begin
result := 0;
aSequence := TSecuenciadores.Create (MyBD);
  try
    try
    // El número de inspector se obtiene de un secuenciador
    Result := StrToInt(Format ('%0.4d', [aSequence.GetValorSecuenciador (SECUENCIADOR_REVISOR)]));
    except
      on E:Exception do
        FAnomalias.PonAnotacion (TRAZA_SIEMPRE,5,FICHERO_ACTUAL,'Error en CalcularNumeroInspector: ' + E.Message);
    end;
  finally
    aSequence.Free
  end;
end;


procedure TfrmNuevoInspector.btnAceptarClick(Sender: TObject);
begin
if (edtNombreInspector.Text <> '') then
  begin
    If (Length(edtPassword.Text)<4) then
      begin
        MessageDlg (CABECERA_MENSAJES_NINSP, MSJ_FRMINSP_LENPWDMAL, mtInformation, [mbOk], mbOk, 0);
            //Exit;
      end
    else
      begin
        if (PasswordIguales (edtPassword.Text, edtPassword2.Text)) then
          begin
          // las password son iguales. Leemos los datos del inspector del form y calculamos el nº inspector
          {$IFDEF TRAZAS}
            FTrazas.PonComponente (TRAZA_FORM,22,FICHERO_ACTUAL,Self);
          {$ENDIF}
          ModalResult := mrOk
          end
        else { Las password no son iguales }
          begin
            MessageDlg (CABECERA_MENSAJES_NINSP, MSJ_FRMINSP_PWDMAL, mtInformation, [mbOk], mbOk, 0);
            edtPassword.setfocus;
          end;
      end;
  end
else
  begin
    MessageDlg (CABECERA_MENSAJES_NINSP, MSJ_FRMINSP_NOMVAC, mtInformation, [mbOk], mbOk, 0);
    edtNombreInspector.setfocus;
  end;
end;


procedure TfrmNuevoInspector.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key = Chr(VK_RETURN) then
  begin
    Perform (WM_NEXTDLGCTL, 0, 0);
    Key := #0;
   end;
end;

// Cifra la password Pwd y la devuelve encriptada
procedure TfrmNuevoInspector.CodificarPassword (NumInsp: tNumeroInspector; Pwd: tPasswordInspector; var PwdCodif: tPasswordInspector);
var
   Ci, Mi: tPasswordCodificada; { Almacenará el codigo ASCII de Pwd }
   { iContador es un contador auxiliar }
   iContador: Byte;
   { CodErr almacenará el código de error, en caso de haberse producido al
     intentar pasar la cadena NumInsp a número }

begin
    {$IFDEF TRAZAS}
      FTrazas.PonAnotacion (TRAZA_FLUJO,23,FICHERO_ACTUAL,'Entrada en CodificarPassword');
    {$ENDIF}
    { Calculamos el código ASCII de cada carácter de la clave Pwd y lo
      almacenamos en Ci }
    for iContador := Low(Pwd) to High(Pwd) do
        Ci[iContador] := ord(Pwd[iContador]);
    { Calculamos los modificadores de la clave Pwd y los guardamos en Mi }
    for iContador := Low(Mi) to High(Mi) do
        Mi[iContador] := (iContador + NumInsp{iNumeroInspector}) mod MODULO_CLAVE;
    { Calculamos el Resultado }
    for iContador := Low(Pwd) to High(Pwd) do
       PwdCodif[iContador] := (Chr(Ci[iContador] xor Mi[iContador]));
    PwdCodif[0] := chr(MAX_LONG_PASSWORD_INSPECTOR);
    {$IFDEF TRAZAS}
      FTrazas.PonAnotacion (TRAZA_FLUJO,24,FICHERO_ACTUAL,'Salida de CodificarPassword');
    {$ENDIF}
end;

// Descifra la password Pwd y la devuelve desencriptada
procedure TfrmNuevoInspector.DecodificarPassword (NumInsp: tNumeroInspector; PwdCodif: tPasswordInspector; var Pwd: tPasswordInspector);
var
   Ci, Mi: tPasswordCodificada; { Almacenará el codigo ASCII de Pwd }
   { iContador es un contador auxiliar }
   iContador: Byte;
   { CodErr almacenará el código de error, en caso de haberse producido al
     intentar pasar la cadena NumInsp a número }

begin
    {$IFDEF TRAZAS}
      FTrazas.PonAnotacion (TRAZA_FLUJO,25,FICHERO_ACTUAL,'Entrada en DecodificarPassword');
    {$ENDIF}
    { Calculamos el código ASCII de cada carácter de la clave codificada
      PwdCodif y lo almacenamos en Ci }
    for iContador := Low(Pwd) to High(Pwd) do
        Ci[iContador] := ord(PwdCodif[iContador]);
    { Calculamos los modificadores de PwdCodif y los guardamos en Mi }
    for iContador := Low(Pwd) to High(Pwd) do
        Mi[iContador] := (iContador + NumInsp{iNumeroInspector}) mod MODULO_CLAVE;
    { Calculamos el Resultado }
    for iContador := Low(Mi) to High(Mi) do
       Pwd[iContador] := (Chr(Ci[iContador] xor Mi[iContador]));
    Pwd[0] := chr(MAX_LONG_PASSWORD_INSPECTOR);
    {$IFDEF TRAZAS}
      FTrazas.PonAnotacion (TRAZA_FLUJO,26,FICHERO_ACTUAL,'Salida de DecodificarPassword');
    {$ENDIF}
end;

    
procedure TfrmNuevoInspector.FormCreate(Sender: TObject);
begin
qryConsultas.SQLConnection := MyBD;
end;


procedure TfrmNuevoInspector.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
qryConsultas.Close;
end;


{ Devuelve el número del inspector dado su nombre }
function TfrmNuevoInspector.Devolver_NumeroInspector (Nombre_Inspector: tNombreInspector): tNumeroInspector;
begin
result := 0;
  try
  with qryConsultas do
    begin
      Close;
      Sql.Clear;
      Sql.Add (Format('SELECT %s FROM %s WHERE %s=''%s''',[FIELD_NUMREVIS, DATOS_TREVISOR, FIELD_NOMREVIS, Nombre_Inspector]));
      {$IFDEF TRAZAS}
      FTrazas.PonComponente (TRAZA_FLUJO, 8, FICHERO_ACTUAL, qryConsultas);
      {$ENDIF}
      Open;
      Application.ProcessMessages;
    end;
  Result := qryConsultas.Fields[0].AsInteger;
  except
    on E:Exception do
      begin
        FAnomalias.PonAnotacion (TRAZA_SIEMPRE,2, FICHERO_ACTUAL, 'Error en Devolver_NumeroInspector: ' + E.Message);
      end;
   end;
end;


procedure TfrmNuevoInspector.FormShow(Sender: TObject);
begin
  edtNombreInspector.setfocus;
end;


end.
