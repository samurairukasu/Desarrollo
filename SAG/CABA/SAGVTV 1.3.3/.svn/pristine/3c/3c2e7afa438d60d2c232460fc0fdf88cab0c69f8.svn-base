unit UFMantDefects;
{ Unidad que se encarga del Mantenimiento de Defectos }

{
  Ultima Traza: 67
  Ultima Incidencia: 7
  Ultima Anomalia: 19
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, DB, SQLExpr, UCTDEFECTOS, Provider,
  DBClient;


const
    MINIMO_CODIGO_VALIDO = 1;
    MAXIMO_CODIGO_VALIDO = 99;
    RANGO_CODIGOS_VALIDOS = [MINIMO_CODIGO_VALIDO..MAXIMO_CODIGO_VALIDO];


type
  TfrmMantenimientoDefectos = class(TForm)
    Bevel1: TBevel;
    btnInsertar: TBitBtn;
    btnImprimir: TBitBtn;
    grpbxCapitulos: TGroupBox;
    lblCodigoCapitulo: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    btnSalir: TBitBtn;
    grpbxApartados: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    grpbxDefectos: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Bevel2: TBevel;
    CmbBxAbreviaturaDefecto: TComboBox;
    edtCodigoDefecto: TEdit;
    ChkBxActivoDefecto: TCheckBox;
    edtLiteralDefecto: TEdit;
    edtLiteralApartado: TEdit;
    edtCodigoApartado: TEdit;
    CmbBxAbreviaturaApartado: TComboBox;
    edtLiteralCapitulo: TEdit;
    edtCodigoCapitulo: TEdit;
    CmbBxAbreviaturaCapitulo: TComboBox;
    btnModificar: TBitBtn;
    CBCLASE: TComboBox;
    Label9: TLabel;
    procedure btnInsertarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CmbBxAbreviaturaDefectoChange(Sender: TObject);
    procedure edtCodigoDefectoChange(Sender: TObject);
    procedure ActivarCapitulos;
    procedure ActivarApartados;
    procedure ActivarDefectos;
    procedure DesactivarCapitulos;
    procedure DesactivarApartados;
    procedure DesactivarDefectos;
    procedure FormActivate(Sender: TObject);
    procedure edtCodigoCapituloChange(Sender: TObject);
    procedure CmbBxAbreviaturaCapituloChange(Sender: TObject);
    procedure CmbBxAbreviaturaCapituloKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure CmbBxAbreviaturaApartadoKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure CmbBxAbreviaturaDefectoKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure edtLiteralCapituloExit(Sender: TObject);
    procedure edtLiteralApartadoExit(Sender: TObject);
    procedure edtCodigoApartadoChange(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure CmbBxAbreviaturaApartadoChange(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodigoCapituloKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoCapituloEnter(Sender: TObject);
    procedure edtCodigoCapituloExit(Sender: TObject);

  private
    { Private declarations }
    {procedure ActivarControlesDefectos;
    procedure DesactivarControlesDefectos;}
    procedure MostrarHints_Defectos;
    //function Devolver_CodigoLiteralActivo_Defecto (AbrDefecto: string; var CodigoDefecto: integer; var LiteralDefecto: string; var EstaActivo: boolean): boolean;
    function AniadirNuevoDefecto_TDEFECTOS (var ValDefecto: tValoresDefecto): boolean;
    procedure RellenarCapitulo (CCap: integer; Acap, LCap: string);
    procedure RellenarApartado (CApa: integer; AApa, LApa: string);
    procedure RellenarDefecto (CDef: integer; ADef, LDef, DAct: string);
    procedure CargarAbreviaturasApartados_ComboBox (CodigoCap: integer; Elementos: TStrings);
    procedure CargarAbreviaturasDefectos_ComboBox (CodCap, CodApa: integer; Elementos: TStrings);

    function Devolver_AbrLiteral_Capitulo (CodigoCap: integer; var AbrCap: string; var LiteralCap: string): boolean;
    function Devolver_CodLiteral_Apartado (CodigoCap: integer; var CodApa: integer; AbrApa: string; var LiteralApa: string): boolean;
    function Devolver_AbrLiteral_Apartado (CodigoCap: integer; CodApa: integer; var AbrApa: string; var LiteralApa: string): boolean;
    function Devolver_CodLiteralAct_Defecto (CodigoCap: integer; CodigoApa: integer; var CodDef: integer; AbrDef: string; var LiteralDef: string; var EstaActivo: string): boolean;
    function Devolver_AbrLiteralAct_Defecto (CodigoCap: integer; CodigoApa: integer; CodDef: integer; var AbrDef: string; var LiteralDef: string; var EstaActivo: string): boolean;
    procedure InicializarCapitulos;
    procedure InicializarApartados;
    procedure InicializarDefectos;
    function Rellenar_CodigosCapituloApartado (var Valores: tValoresDefecto): boolean;
    function DevolverMaximoNumeroDefectos (Valores: tValoresDefecto; var MaxNum: integer): boolean;
    function ExisteDefecto_TDEFECTOS (Valores: tValoresDefecto): boolean;
    function Componer_CadenaDefecto (Val: tValoresDefecto): string;
    function ModificarDefecto_TDEFECTOS (Valores: tValoresDefecto): boolean;
    procedure Generacion_FicheroINIDefectos;
    function CodigoDefectoValido (sCodDef: string): boolean;
  public
    { Public declarations }
    function CodigoValido (CD: string): boolean;
    function Devolver_CodLiteral_Capitulo (var CodigoCap: integer; AbrCap: string; var LiteralCap: string): boolean;
    function AbreviaturaValido (AD: string): boolean;
    function LiteralValido (LD: string): boolean;
    procedure CargarAbreviaturasCapitulos_ComboBox (Elementos: TStrings);
  end;


var
   frmMantenimientoDefectos: TfrmMantenimientoDefectos;       CLASE: string;


procedure Mantenimiento_Defectos (aForm: TForm);


implementation

{$R *.DFM}

uses
   UFNEWDEFECT,
   UCDIALGS,
   FICHINI,
   UFPRINTDEFECTS,
   ULOGS,
   UVERSION,
   GLOBALS,
   USUPERREGISTRY,
   FILECTRL,
   USECUENCIADORES,
   UFTMP,
   UINTERFAZUSUARIO,
   UUTILS;


const
    COD_ULTIMO_DEFECTO_VISUAL = 49; { El último defecto visual es el 49 }


resourcestring
    CABECERA_MENSAJES_MDEFECTO = 'Mantenimiento Defectos';
    FICHERO_ACTUAL = 'MDefect';



      { Hints del form MDefect }
      HNT_MDEFECT_CODDEF = 'Código del defecto|Código del defecto visible';
      HNT_MDEFECT_ABRDEF = 'Abreviatura del defecto|Abreviatura del defecto visible';
      HNT_MDEFECT_LITDEF = 'Literal del defecto|Literal del defecto visible';
      HNT_MDEFECT_CODAPA = 'Código del apartado|Código del apartado';
      HNT_MDEFECT_ABRAPA = 'Abreviatura del apartado|Abreviatura apartado';
      HNT_MDEFECT_LITAPA = 'Literal del apartado|Literal del apartado';
      HNT_MDEFECT_CODCAP = 'Código del capítulo|Código del capítulo';
      HNT_MDEFECT_ABRCAP = 'Abreviatura del capítulo|Abreviatura del capítulo';
      HNT_MDEFECT_LITCAP = 'Literal del capítulo|Literal del capítulo';

      { Mensajes enviados al usuario desde MDefect }
      MSJ_MDEF_CODCAPMAL = 'El código del capítulo no se ha introducido o es incorrecto. El código del capítulo está comprendido entre 1 y 99.';
      MSJ_MDEF_LITCAPMAL = 'El literal del capítulo no se ha introducido';
      MSJ_MDEF_ABRCAPMAL = 'La abreviatura del capítulo no se ha introducido';
      MSJ_MDEF_CODAPAMAL = 'El código del apartado no se ha introducido o es incorrecto. El código de la abreviatura está comprendido entre 1 y 99.';
      MSJ_MDEF_LITAPAMAL = 'El literal del apartado no se ha introducido';
      MSJ_MDEF_ABRAPAMAL = 'La abreviatura del apartado no se ha introducido';
      MSJ_MDEF_CODDEFMAL = 'No ha introducido el código del defecto a modificar o éste es incorrecto';
      MSJ_MDEF_MAXNUMDEF = 'Lo siento, pero se ha llegado al límite del máximo número de defectos visuales que se pueden añadir para el apartado del capítulo seleccionado';
      MSJ_MDEF_DEFEXIS = 'Lo siento, pero el nuevo defecto que se desea añadir ya se encuentra almacenado';

      { Mensaje de sistema inestable }
      MSJ_SISTEMA_INESTABLE = 'Ha ocurrido un error grave en la base de datos. El sistema está inestable, con lo que deberá reiniciarlo de nuevo';
      { Mensajes enviados al usuario desde NDefect }
      MSJ_NDEF_CODMAL = 'El código del defecto no se ha introducido o es incorrecto. El código de defecto está comprendido entre 1 y 99.';
      MSJ_NDEF_LITMAL = 'El literal del defecto no se ha introducido';
      MSJ_NDEF_ABRMAL = 'La abreviatura del defecto no se ha introducido';

      MSJ_UMAIN_FICHINI_CORRECTO = 'CORRECTAMENTE';
      MSJ_UMAIN_FICHINI_INCORRECTO = 'INCORRECTAMENTE';



procedure Mantenimiento_Defectos (aForm: TForm);
var
   frmMantenimientoDefectos_Auxi: TfrmMantenimientoDefectos;

begin
    aForm.Enabled := False;
    try
      frmMantenimientoDefectos_Auxi := TfrmMantenimientoDefectos.Create (Application);
      try
         frmMantenimientoDefectos_Auxi.ShowModal;
      finally
           frmMantenimientoDefectos_Auxi.Free;
      end;
    finally
         aForm.Enabled := True;
         aForm.Show;
    end;
end;


var
  bFicheroDefModificado: boolean; { True si el fichero de defectos se ha modificado }


procedure TfrmMantenimientoDefectos.MostrarHints_Defectos;
{ Muestra los hints del form frmMantenimientoDefectos }
begin { de MostrarHints_Defectos }
    { Hints de CAPITULOS }
    edtCodigoCapitulo.Hint := HNT_MDEFECT_CODCAP;
    cmbbxAbreviaturaCapitulo.Hint := HNT_MDEFECT_ABRCAP;
    edtLiteralCapitulo.Hint := HNT_MDEFECT_LITCAP;
    { Hints de APARTADOS }
    edtCodigoApartado.Hint := HNT_MDEFECT_CODAPA;
    cmbbxAbreviaturaApartado.Hint := HNT_MDEFECT_ABRAPA;
    edtLiteralApartado.Hint := HNT_MDEFECT_LITAPA;
    { Hints de DEFECTOS }
    edtCodigoDefecto.Hint := HNT_MDEFECT_CODDEF;
    cmbbxAbreviaturaDefecto.Hint := HNT_MDEFECT_ABRDEF;
    edtLiteralDefecto.Hint := HNT_MDEFECT_LITDEF;
end; { de MostrarHints_Defectos }

(*
procedure TfrmMantenimientoDefectos.ActivarControlesDefectos;
begin { de ActivarControlesDefectos }
    with grpbxApartados do
    begin
        Enabled := True;
        Font.Color := clBlack;
    end;
    with grpbxDefectos do
    begin
        Enabled := True;
        Font.Color := clBlack;
    end
end; { de ActivarControlesDefectos }


procedure TfrmMantenimientoDefectos.DesactivarControlesDefectos;
begin { de DesactivarControlesDefectos }
    with grpbxApartados do
    begin
        Enabled := False;
        Font.Color := clGray;
    end;
    with grpbxDefectos do
    begin
        Enabled := False;
        Font.Color := clGray;
    end
end; { de DesactivarControlesDefectos }
*)

procedure TfrmMantenimientoDefectos.btnInsertarClick(Sender: TObject);
var
  frmNuevoDefecto_Auxi: TfrmNuevoDefecto;
  ValoresDefecto: tValoresDefecto;

begin
    frmNuevoDefecto_Auxi := nil;
    try
       if CodigoDefectoValido (edtCodigoDefecto.Text) then
       begin
         frmNuevoDefecto_Auxi := TfrmNuevoDefecto.Create(Application);
         frmNuevoDefecto_Auxi.Inicializar_DefectoActivo_Insertar;
         frmNuevoDefecto_Auxi.Inicializar_OtrosCampos_Insertar;
         frmNuevoDefecto_Auxi.ShowModal;
         if frmNuevoDefecto_Auxi.ModalResult = mrOk then
         begin
             { Hay que rellenar el código de capítulo y apartado del defecto }
             if Rellenar_CodigosCapituloApartado (ValoresDefecto) then
             begin
                 if FrmNuevoDefecto_Auxi.LeerValoresDefecto (ValoresDefecto) then
                 begin
                     { Hay que añadir un nuevo defecto }
                     if AniadirNuevoDefecto_TDEFECTOS (ValoresDefecto) then
                     begin
                         { Si se ha añadido correctamente un defecto, entonces hay que
                           refrescar lo que el usuario ve por pantalla }
                         CargarAbreviaturasDefectos_ComboBox
                           (StrToInt(edtCodigoCapitulo.Text), StrToInt(edtCodigoApartado.Text),
                           CmbBxAbreviaturaDefecto.Items);
                         with ValoresDefecto do
                           RellenarDefecto (CodigoDefecto, AbreviaturaDefecto, LiteralDefecto, DefectoActivo);

                         { Como se ha modificado la tabla TDEFECTOS, hey que generar un nuevo fichero
                           DEFECT.INI }
                         bFicheroDefModificado := True;
                     end;
                 end;
             end;
         end;
       end
       else
       begin
            MessageDlg (CABECERA_MENSAJES_MDEFECTO, MSJ_MDEF_CODDEFMAL, mtInformation, [mbOk], mbOk, 0);
            edtCodigoDefecto.Setfocus;
       end;
    finally
         frmNuevoDefecto_Auxi.Free;
    end;
end;



procedure TfrmMantenimientoDefectos.FormCreate(Sender: TObject);
{ Inicializa algunos valores del form frmMantenimientoDefectos }
begin
    bFicheroDefModificado := False;
    MostrarHints_Defectos;
end;

procedure TfrmMantenimientoDefectos.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Key := #0;
        Perform (WM_NEXTDLGCTL, 0, 0)
    end
end;

procedure TfrmMantenimientoDefectos.CmbBxAbreviaturaDefectoChange(Sender: TObject);
var
   CDef: integer;
   ADef, LDef: string;
   DefActivo: string;

begin
    { Inicializamos el código y el literal del defecto }
    edtCodigoDefecto.Text := '';
    edtLiteralDefecto.Text := '';
    if (CmbBxAbreviaturaDefecto.ItemIndex = -1) then
       CmbBxAbreviaturaDefecto.ItemIndex := 0;
    CmbBxAbreviaturaDefecto.Items[CmbBxAbreviaturaDefecto.ItemIndex];


    if (AbreviaturaValido (CmbBxAbreviaturaDefecto.Items[CmbBxAbreviaturaDefecto.ItemIndex])) then
    begin
        ADef := CmbBxAbreviaturaDefecto.Items[CmbBxAbreviaturaDefecto.ItemIndex];
        Devolver_CodLiteralAct_Defecto (StrToInt(edtCodigoCapitulo.Text), StrToInt(edtCodigoApartado.Text), CDef, ADef, LDef, DefActivo);
        RellenarDefecto (CDef, ADef, LDef, DefActivo);
    end

end;


function TfrmMantenimientoDefectos.Devolver_CodLiteral_Apartado (CodigoCap: integer; var CodApa: integer; AbrApa: string; var LiteralApa: string): boolean;
{ Devuelve el código y el literal de un apartado. Devuelve True si ha logrado
  devolverlos. }
var
   qryConsultas: TSQLQuery;

begin
    qryConsultas := TSQLQuery.Create (nil);
    try
       try
          with qryConsultas do
          begin

              Close;
              SQLConnection := MyBD;
              Sql.Clear;
              Sql.Add ('SELECT CODAPART,LITAPART');
              Sql.Add ('  FROM TAPARTADOS');
              Sql.Add ('  WHERE CODCAPIT=:CodigoCap AND ABRAPART=:AbrApa ');
              Params[0].AsInteger := CodigoCap;
              Params[1].AsString := AbrApa;

              {$IFDEF TRAZAS}
                FTrazas.PonComponente (TRAZA_SQL,42,FICHERO_ACTUAL,qryConsultas);
              {$ENDIF}
              Open;
              Application.ProcessMessages;
              {$IFDEF TRAZAS}
                FTrazas.PonRegistro (TRAZA_REGISTRO,59,FICHERO_ACTUAL,qryConsultas);
              {$ENDIF}
              CodApa := Fields[0].AsInteger;
              LiteralApa:= Fields[1].AsString;
          end;
          Result := True;
       except
            on E:Exception do
            begin
                Result := False;
                FAnomalias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL,Format ('%s %s %d %s', ['NO se ha podido obtener la abreviatura y el literal de un apartado: ',E.Message,CodigoCap,AbrApa]));
            end
       end;
    finally
         qryConsultas.Free;
    end;
end;


function TfrmMantenimientoDefectos.Devolver_AbrLiteral_Apartado (CodigoCap: integer; CodApa: integer; var AbrApa: string; var LiteralApa: string): boolean;
{ Devuelve la abreviatura y el literal de un apartado }
{ Devuelve True si se ha podido seleccionar la abreviatura y el literal de un apartado }
var
  qryConsultas: TSQLQuery;

begin
    qryConsultas := TSQLQuery.Create (nil);
    try
       try
          with qryConsultas do
          begin

              Close;
              SQLConnection := MyBD;
              Sql.Clear;
              Sql.Add ('SELECT ABRAPART,LITAPART FROM TAPARTADOS WHERE CODCAPIT=:CodigoCap AND CODAPART=:CodApa ');
              Params[0].AsInteger := CodigoCap;
              Params[1].AsInteger := CodApa;

              {$IFDEF TRAZAS}
                FTrazas.PonComponente (TRAZA_SQL,43,FICHERO_ACTUAL,qryConsultas);
              {$ENDIF}
              Open;
              Application.ProcessMessages;
              {$IFDEF TRAZAS}
                FTrazas.PonRegistro (TRAZA_REGISTRO,60,FICHERO_ACTUAL,qryConsultas);
              {$ENDIF}
              AbrApa := Fields[0].AsString;
              LiteralApa:= Fields[1].AsString;
          end;
          Result := True;
       except
            on E:Exception do
            begin
                Result := False;
                FAnomalias.PonAnotacion (TRAZA_SIEMPRE,2,FICHERO_ACTUAL,Format ('%s %s %s %s',['NO se ha podido obtener la abreviatura y el literal de un apartado:',E.Message,AbrApa,LiteralApa]));
            end
       end;
    finally
         qryConsultas.Free;
    end;
end;


function TfrmMantenimientoDefectos.Devolver_CodLiteralAct_Defecto (CodigoCap: integer; CodigoApa: integer; var CodDef: integer; AbrDef: string; var LiteralDef: string; var EstaActivo: string): boolean;
{ Devuelve el código y el literal de un defecto. Devuelve True si ha logrado
  devolverlos. }
var
  qryConsultas: TSQLQuery;

begin
    qryConsultas := TSQLQuery.Create (nil);
    try
       try
          with qryConsultas do
          begin
              if trim(cbclase.Text)='Moto' then clase:='1';
              if trim(cbclase.Text)='Auto' then clase:='2';
              Close;
              Sql.Clear;
              SQLConnection := MyBD;
              Sql.Add ('SELECT CODDEFEC,LITDEFEC,ACTIVO FROM TDEFECTOS WHERE CODCAPIT=:CodigoCap AND CODAPART=:CodigoApa AND ABRDEFEC=:AbrDef and TRIM(CODCLASE)=TRIM(:CLASE)');
              Params[0].AsInteger := CodigoCap;
              Params[1].AsInteger := CodigoApa;
              Params[2].AsString := AbrDef;
              Params[3].AsString:=CLASE;
              {$IFDEF TRAZAS}
                FTrazas.PonComponente (TRAZA_SQL,44,FICHERO_ACTUAL,qryConsultas);
              {$ENDIF}
              Open;
              Application.ProcessMessages;
              {$IFDEF TRAZAS}
                FTrazas.PonRegistro (TRAZA_REGISTRO,61,FICHERO_ACTUAL,qryConsultas);
              {$ENDIF}
              CodDef := Fields[0].AsInteger;
              LiteralDef:= Fields[1].AsString;
              EstaActivo := Fields[2].AsString;
          end;
          Result := True;
       except
            on E:Exception do
            begin
                Result := False;
                FAnomalias.PonAnotacion (TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'NO se ha podido obtener el código y el literal de un defecto: ' + E.Message);
            end
       end;
    finally
         qryConsultas.Free;
    end;
end;


function TfrmMantenimientoDefectos.Devolver_AbrLiteralAct_Defecto (CodigoCap: integer; CodigoApa: integer; CodDef: integer; var AbrDef: string; var LiteralDef: string; var EstaActivo: string): boolean;
{ Devuelve la abreviatura y el literal de un defecto.
  Devuelve True si se ha podido seleccionar la abreviatura y el literal de un defecto }
var
  qryConsultas: TSQLQuery;

begin
    qryConsultas := TSQLQuery.Create (nil);
    try
       try
          with qryConsultas do
          begin
              if trim(cbclase.Text)='Moto' then clase:='1';
              if trim(cbclase.Text)='Auto' then clase:='2';
              Close;
              SQLConnection := MyBD;
              Sql.Clear;
              Sql.Add ('SELECT ABRDEFEC,LITDEFEC,ACTIVO FROM TDEFECTOS WHERE CODCAPIT=:CodigoCap AND CODAPART=:CodApa AND CODDEFEC=:CodDef and TRIM(CODCLASE)=TRIM(:CLASE)');
              Params[0].AsInteger := CodigoCap;
              Params[1].AsInteger := CodigoApa;
              Params[2].AsInteger := CodDef;
              Params[3].AsString:= clase;
              {$IFDEF TRAZAS}
                FTrazas.PonComponente (TRAZA_SQL,45,FICHERO_ACTUAL,qryConsultas);
              {$ENDIF}
              Open;
              Application.ProcessMessages;
              {$IFDEF TRAZAS}
                FTrazas.PonRegistro (TRAZA_REGISTRO,62,FICHERO_ACTUAL,qryConsultas);
              {$ENDIF}
              AbrDef := Fields[0].AsString;
              LiteralDef:= Fields[1].AsString;
              EstaActivo := Fields[2].AsString;
          end;
          Result := True;
       except
            on E:Exception do
            begin
                Result := False;
                FAnomalias.PonAnotacion (TRAZA_SIEMPRE,4,FICHERO_ACTUAL,Format ('%s %d %d %d', ['NO se ha podido obtener la abreviatura y el literal de un defecto:',E.Message,CodigoCap,CodigoApa,CodDef]));
            end
       end;
    finally
         qryConsultas.Free;
    end;
end;

(*
function TfrmMantenimientoDefectos.Devolver_CodigoLiteralActivo_Defecto (AbrDefecto: string; var CodigoDefecto: integer; var LiteralDefecto: string; var EstaActivo: boolean): boolean;
{ Devuelve True si se ha podido seleccionar el código, literal y si está activo
  un defecto }
var
  qryConsultas: TQuery;

begin
    qryConsultas := TQuery.Create (nil);
    try
       try
          with qryConsultas do
          begin
              Close;
              DatabaseName := MyBD.DatabaseName;
              SessionName := MyBD.SessionName;
              Sql.Clear;
              Sql.Add ('SELECT CODDEFEC,ACTIVO,LITDEFEC FROM TDEFECTOS WHERE ABRDEFEC=:AbrDefecto');
              Prepare;
              Params[0].AsString := AbrDefecto;
              {$IFDEF TRAZAS}
                FTrazas.PonComponente (TRAZA_SQL,46,FICHERO_ACTUAL,qryConsultas);
              {$ENDIF}
              Open;
              Application.ProcessMessages;
              {$IFDEF TRAZAS}
                FTrazas.PonRegistro (TRAZA_REGISTRO,63,FICHERO_ACTUAL,qryConsultas);
              {$ENDIF}
              CodigoDefecto := Fields[0].AsInteger;
              LiteralDefecto:= Fields[1].AsString;
              EstaActivo := (Fields[2].AsString <> DEFECTO_NOACTIVO);
          end;
          Result := True;
       except
            on E:Exception do
            begin
                Result := False;
                FAnomalias.PonAnotacion (TRAZA_SIEMPRE,5,FICHERO_ACTUAL,'NO se ha podido obtener el código, literal y si está activo un defecto: ' + E.Message);
            end
       end;
    finally
         qryConsultas.Free;
    end;
end;
*)

procedure TfrmMantenimientoDefectos.edtCodigoDefectoChange(
  Sender: TObject);
var
   CDef: integer;
   ADef, LDef: string;
   DefActivo: string; { Está vacío si el defecto está activo }

begin
    { Inicializamos la abreviatura y el literal del defecto }
    if (edtLiteralDefecto.Text = '') then
       CmbBxAbreviaturaDefecto.ItemIndex := -1;

    ChkBxActivoDefecto.Checked := False;
    edtLiteralDefecto.Text := '';

    
    if (edtCodigoDefecto.Text <> '') then
    begin
      if ((edtCodigoCapitulo.Text <> '') and (edtCodigoApartado.Text <> '')) then
      begin
          if (CodigoValido (edtCodigoDefecto.Text)) then
          begin
              CDef := StrToInt(edtCodigoDefecto.Text);
              Devolver_AbrLiteralAct_Defecto (StrToInt(edtCodigoCapitulo.Text), StrToInt(edtCodigoApartado.Text), CDef, ADef, LDef, DefActivo);
              RellenarDefecto (CDef, ADef, LDef, DefActivo);
          end
          else
          begin
              MessageDlg (CABECERA_MENSAJES_MDEFECTO, MSJ_NDEF_CODMAL, mtInformation, [mbOk], mbOk, 0);
              edtCodigoDefecto.setfocus;
          end;
      end
      else
      begin
          edtCodigoDefecto.Text := '';
      end;
    end;

end;


procedure TFrmMantenimientoDefectos.ActivarCapitulos;
begin
    grpbxCapitulos.Enabled := True;
    grpbxCapitulos.Font.Color := clBlack;
    DesactivarApartados;
    DesactivarDefectos;
end;


procedure TFrmMantenimientoDefectos.ActivarApartados;
begin
    grpbxApartados.Enabled := True;
    grpbxApartados.Font.Color := clBlack;
    DesactivarCapitulos;
    DesactivarDefectos;
end;

procedure TFrmMantenimientoDefectos.ActivarDefectos;
begin
    grpBxDefectos.Enabled := True;
    grpBxDefectos.Font.Color := clBlack;
    DesactivarCapitulos;
    DesactivarApartados;
end;


procedure TFrmMantenimientoDefectos.DesactivarCapitulos;
begin
    grpbxCapitulos.Enabled := False;
    grpbxCapitulos.Font.Color := clGray;
end;


procedure TFrmMantenimientoDefectos.DesactivarApartados;
begin
    grpbxApartados.Enabled := False;
    grpbxApartados.Font.Color := clGray;
end;

procedure TFrmMantenimientoDefectos.DesactivarDefectos;
begin
    grpBxDefectos.Enabled := False;
    grpBxDefectos.Font.Color := clGray;
end;


function TFrmMantenimientoDefectos.AniadirNuevoDefecto_TDEFECTOS (var ValDefecto: tValoresDefecto): boolean;
{ Devuelve True si ha logrado añadir un nuevo defecto a la tabla TDEFECTOS.
  Como máximo se pueden insertar 50 defectos (1..49). Si no se pueden insertar
  más se envía un mensaje de error }
var
   NumDefs, UltimoNumDef: integer;
   FechaAlta: tDateTime;
   CadenaDefecto: string;
   qryConsultas: TSQLQuery;
   aSequence: TSecuenciadores;

begin
    //qryConsultas := nil;

    result := false;
    
    aSequence := TSecuenciadores.Create (MyBD);
    qryConsultas := TSQLQuery.Create (nil);
    try
       try
          if DevolverMaximoNumeroDefectos (ValDefecto, NumDefs) then
          begin
            if (not (ExisteDefecto_TDEFECTOS (ValDefecto))) then
            begin
              if (NumDefs < COD_ULTIMO_DEFECTO_VISUAL) then
              begin
                  inc (NumDefs);
                  ValDefecto.CodigoDefecto := NumDefs;
                  //UltimoNumDef := SecuenciaDe(SECUENCIADOR_TDEFECTOS);
                  UltimoNumDef := aSequence.GetValorSecuenciador (SECUENCIADOR_DEFECTOS);
                  inc (UltimoNumDef);
                  FechaAlta := Now;
                  CadenaDefecto := Componer_CadenaDefecto (ValDefecto);

                  {if IniciarTransaccion then
                  begin}
                      if (not MyBD.InTransaction) then
                         MyBd.InTransaction;

                      with qryConsultas do
                      begin
                          if trim(cbclase.Text)='Moto' then clase:='1';
                          if trim(cbclase.Text)='Auto' then clase:='2';
                          Close;
                          SQLConnection := MyBD;
                          Sql.Clear;
                          Sql.Add ('INSERT INTO TDEFECTOS');
                          Sql.Add ('(NUMDEFEC,CODCAPIT,CODAPART,CODDEFEC,FECHALTA,CADDEFEC,ACTIVO,ABRDEFEC,LITDEFEC,CODCLASE) VALUES');
                          Sql.Add ('(:UltimoNumDef,:ValDefecto.CodigoCapitulo,:ValDefecto.CodigoApartado,:NumDefs,:FechaAlta,:CadenaDefecto,:ValDefecto.DefectoActivo,:ValDefecto.AbreviaturaDefecto,:ValDefecto.LiteralDefecto,:clase)');
                          Params[0].AsInteger := UltimoNumDef;
                          Params[1].AsInteger := ValDefecto.CodigoCapitulo;
                          Params[2].AsInteger := ValDefecto.CodigoApartado;
                          Params[3].AsInteger := NumDefs;
                          Params[4].AsDateTime := FechaAlta;
                          Params[5].AsString := CadenaDefecto;
                          Params[6].AsString := ValDefecto.DefectoActivo;
                          Params[7].AsString := ValDefecto.AbreviaturaDefecto;
                          Params[8].AsString := ValDefecto.LiteralDefecto;
                          Params[9].AsString := clase;
                          {$IFDEF TRAZAS}
                            FTrazas.PonComponente (TRAZA_SQL,54,FICHERO_ACTUAL,qryConsultas);
                          {$ENDIF}
                          ExecSQL;
                          Application.ProcessMessages;
                      end;
                      Result := True;
                      {$IFDEF TRAZAS}
                        FTrazas.PonAnotacion (TRAZA_FLUJO,6,FICHERO_ACTUAL,'Se ha añadido un nuevo defecto en TDEFECTOS');
                      {$ENDIF}

                      { hacemos un COMMIT }
                      if MyBD.InTransaction then
                         MyBd.Commit(TD);

                      (*
                      if AlmacenarCambiosTransaccion then
                      begin
                          {$IFDEF TRAZAS}
                            FTrazas.PonAnotacion (TRAZA_FLUJO,7,FICHERO_ACTUAL, 'Se ha hecho un commit al añadir datos de TDEFECTOS');
                          {$ENDIF}
                          Result := True;
                      end
                      else
                      begin
                          if DeshacerCambiosTransaccion then
                          begin
                              FIncidencias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL, 'Se ha hecho un rollback al añadir datos en TDEFECTOS');
                          end
                          else
                          begin
                              FIncidencias.PonAnotacion (TRAZA_SIEMPRE,2,FICHERO_ACTUAL, 'NO se ha hecho un rollback al añadir datos en TDEFECTOS');
                              MessageDlg (FICHERO_ACTUAL, MSJ_SISTEMA_INESTABLE, mtInformation, [mbOk], mbOk, 0);
                          end;
                      end;
                  end
                  else
                  begin
                      { Como no se ha podido iniciar una transacción generamos una incidencia }
                      FIncidencias.PonAnotacion (TRAZA_SIEMPRE,3,FICHERO_ACTUAL, 'No se ha podido iniciar una transacción para intentar añadir datos de TDEFECTOS');
                  end;*)
              end
              else
              begin
                  MessageDlg (CABECERA_MENSAJES_MDEFECTO, MSJ_MDEF_MAXNUMDEF, mtInformation, [mbOk], mbOk, 0);
                  {$IFDEF TRAZAS}
                    FTrazas.PonAnotacion (TRAZA_FLUJO,8,FICHERO_ACTUAL,'NO se puede añadir un nuevo defecto en TDEFECTOS porque ya hay 49 defectos visuales');
                  {$ENDIF}
              end;
            end
            else
            begin
               MessageDlg (CABECERA_MENSAJES_MDEFECTO, MSJ_MDEF_DEFEXIS, mtInformation, [mbOk], mbOk, 0);
               {$IFDEF TRAZAS}
                 FTrazas.PonAnotacion (TRAZA_FLUJO,9,FICHERO_ACTUAL,'Se intenta añadir un defecto que ya existe en TDEFECTOS ');
               {$ENDIF}
            end;
          end
          else
          begin
             FAnomalias.PonAnotacion (TRAZA_SIEMPRE,6,FICHERO_ACTUAL, 'Error al intentar conocer el máximo número de defectos que hay en un apartado');
          end;
       except
            on E:Exception do
            begin
                Result := False;
                FAnomalias.PonAnotacion (TRAZA_SIEMPRE,7,FICHERO_ACTUAL, 'Error al añadir un nuevo defecto en TDEFECTOS: ' + E.Message);
            end;
       end;
    finally
         qryConsultas.Free;
         aSequence.Destroy
    end;
end;


function TfrmMantenimientoDefectos.Componer_CadenaDefecto (Val: tValoresDefecto): string;
{ Formato del campo CADDEFEC de TDEFECTOS }
begin
    Result := Format ('%1.2d.%1.2d.%1.3d', [Val.CodigoCapitulo, Val.CodigoApartado, Val.CodigoDefecto]);
end;


procedure TfrmMantenimientoDefectos.FormActivate(Sender: TObject);
begin
    CargarAbreviaturasCapitulos_ComboBox (CmbBxAbreviaturaCapitulo.Items);
    InicializarCapitulos;
    InicializarApartados;
    InicializarDefectos;
    edtCodigoCapitulo.setfocus;
end;

function TfrmMantenimientoDefectos.Devolver_AbrLiteral_Capitulo (CodigoCap: integer; var AbrCap: string; var LiteralCap: string): boolean;
{ Devuelve True si se ha podido seleccionar la abreviatura y el literal de un capítulo }
var
   qryConsultas: TSQLQuery;

begin
    qryConsultas := TSQLQuery.Create (nil);
    try
       try
          with qryConsultas do
          begin
              Close;
              Sql.Clear;
              SQLConnection := MyBD;
              //modi MLA
              Sql.Add (format('SELECT ABRCAPIT,LITCAPIT FROM TCAPITULOS WHERE CODCAPIT=%s',[inttostr(CodigoCap)]));
             //   Sql.Add ('SELECT ABRCAPIT,LITCAPIT FROM TCAPITULOS WHERE CODCAPIT=2');
             // Params[0].AsInteger := CodigoCap;
              {$IFDEF TRAZAS}
                FTrazas.PonComponente (TRAZA_SQL,47,FICHERO_ACTUAL,qryConsultas);
              {$ENDIF}
              Open;
              Application.ProcessMessages;
              {$IFDEF TRAZAS}
                FTrazas.PonRegistro (TRAZA_REGISTRO,64,FICHERO_ACTUAL,qryConsultas);
              {$ENDIF}
              AbrCap := Fields[0].AsString;
              LiteralCap:= Fields[1].AsString;
          end;
          Result := True;
       except
            on E:Exception do
            begin
                Result := False;
                FAnomalias.PonAnotacion (TRAZA_SIEMPRE,8,FICHERO_ACTUAL,Format ('%s %s %d',['NO se ha podido obtener la abreviatura y el literal de un capítulo:',E.Message,CodigoCap]));
            end
       end;
    finally
         qryConsultas.Free;
    end;
end;


function TfrmMantenimientoDefectos.Devolver_CodLiteral_Capitulo (var CodigoCap: integer; AbrCap: string; var LiteralCap: string): boolean;
{ Devuelve True si se ha podido seleccionar la abreviatura y el literal de un capítulo }
var
  qryConsultas: TSQLQuery;

begin
    qryConsultas := TSQLQuery.Create (nil);
    try
       try
          with qryConsultas do
          begin
              Close;
              SQLConnection := MyBD;
              Sql.Clear;
              Sql.Add ('SELECT CODCAPIT,LITCAPIT FROM TCAPITULOS WHERE ABRCAPIT=:AbrCap');
              Params[0].AsString := AbrCap;
              {$IFDEF TRAZAS}
                FTrazas.PonComponente (TRAZA_SQL,48,FICHERO_ACTUAL,qryConsultas);
              {$ENDIF}
              Open;
              Application.ProcessMessages;
              {$IFDEF TRAZAS}
                FTrazas.PonRegistro (TRAZA_REGISTRO,65,FICHERO_ACTUAL,qryConsultas);
              {$ENDIF}
              CodigoCap := Fields[0].AsInteger;
              LiteralCap:= Fields[1].AsString;
          end;
          Result := True;
       except
            on E:Exception do
            begin
                Result := False;
                FAnomalias.PonAnotacion (TRAZA_SIEMPRE,9,FICHERO_ACTUAL,Format ('%s %s %s', ['NO se ha podido obtener la abreviatura y el literal de un capítulo:',E.Message,AbrCap]));
            end
       end;
    finally
         qryConsultas.Free;
    end;
end;


function TfrmMantenimientoDefectos.CodigoValido (CD: string): boolean;
{ Devuelve True si el formato del código de defecto es correcto }
var
   ValorAuxi: integer;

begin
    if (CD = '') then
      Result := True
    else
    begin
        try
            ValorAuxi := StrToInt (CD);
            Result := (ValorAuxi in RANGO_CODIGOS_VALIDOS);
        except
             on E:Exception do
             begin
                 Result := False;
                 FAnomalias.PonAnotacion (TRAZA_SIEMPRE,10,FICHERO_ACTUAL,'Error en CodigoValido: ' + E.Message);
             end;
        end;
    end;
end;


function TfrmMantenimientoDefectos.AbreviaturaValido (AD: string): boolean;
{ Devuelve True si el formato de la abreviatura de defecto es correcto }
begin
     Result := (AD <> '');
end;


function TfrmMantenimientoDefectos.LiteralValido (LD: string): boolean;
{ Devuelve True si el formato del literal de defecto es correcto }
begin
     Result := (LD <> '');
end;

procedure TfrmMantenimientoDefectos.RellenarCapitulo (CCap: integer; Acap, LCap: string);
begin
    edtCodigoCapitulo.Text := IntToStr (CCap);
    CmbBxAbreviaturaCapitulo.ItemIndex := Devolver_Posicion_ComboBox (CmbBxAbreviaturaCapitulo.Items, CmbBxAbreviaturaCapitulo.Items.Count, Acap);
    CmbBxAbreviaturaCapitulo.Items[CmbBxAbreviaturaCapitulo.ItemIndex];
    edtLiteralCapitulo.Enabled := True;
    edtLiteralCapitulo.Text := LCap;
    edtLiteralCapitulo.Enabled := False;
end;


procedure TfrmMantenimientoDefectos.RellenarApartado (CApa: integer; AApa, LApa: string);
begin
    edtCodigoApartado.Text := IntToStr (CApa);
    CmbBxAbreviaturaApartado.ItemIndex := Devolver_Posicion_ComboBox (CmbBxAbreviaturaApartado.Items, CmbBxAbreviaturaApartado.Items.Count, AApa);
    CmbBxAbreviaturaApartado.Items[CmbBxAbreviaturaApartado.ItemIndex];
    edtLiteralApartado.Enabled := True;
    edtLiteralApartado.Text := LApa;
    edtLiteralApartado.Enabled := False;
end;


procedure TfrmMantenimientoDefectos.RellenarDefecto (CDef: integer; ADef, LDef, DAct: string);
begin
    edtCodigoDefecto.Text := IntToStr (CDef);
    CmbBxAbreviaturaDefecto.ItemIndex := Devolver_Posicion_ComboBox (CmbBxAbreviaturaDefecto.Items, CmbBxAbreviaturaDefecto.Items.Count, ADef);
    CmbBxAbreviaturaDefecto.Items[CmbBxAbreviaturaDefecto.ItemIndex];
    ChkBxActivoDefecto.Enabled := True;
    ChkBxActivoDefecto.Checked := (DAct <> DEFECTO_NOACTIVO);
    ChkBxActivoDefecto.Enabled := False;
    edtLiteralDefecto.Enabled := True;
    edtLiteralDefecto.Text := LDef;
    edtLiteralDefecto.Enabled := False;
end;


procedure TfrmMantenimientoDefectos.edtCodigoCapituloChange(
  Sender: TObject);
var
   CCap: integer;
   ACap, LCap: string;

begin

   if cbclase.ItemIndex=-1 then
   begin
    Application.MessageBox( 'Debe seleccionar la clase.',
  'Acceso denegado', MB_ICONSTOP );
    exit;
   end;

    { Inicializamos la abreviatura y el literal del capítulo }
    if (edtLiteralCapitulo.Text = '') then
       CmbBxAbreviaturaCapitulo.ItemIndex := -1;
    edtLiteralCapitulo.Text := '';
    InicializarApartados;
    InicializarDefectos;


    if (edtCodigoCapitulo.Text <> '') then
    begin
      if (CodigoValido (edtCodigoCapitulo.Text)) then
      begin
          CCap := StrToInt(edtCodigoCapitulo.Text);
          Devolver_AbrLiteral_Capitulo (CCap, Acap, LCap);
          RellenarCapitulo (CCap, Acap, LCap);

          CargarAbreviaturasApartados_ComboBox (StrToInt(edtCodigoCapitulo.Text), CmbBxAbreviaturaApartado.Items);
      end
      else
      begin
          MessageDlg (CABECERA_MENSAJES_MDEFECTO, MSJ_MDEF_CODCAPMAL, mtInformation, [mbOk], mbOk, 0);
          edtCodigoCapitulo.setfocus;
      end;
    end;

end;

procedure TfrmMantenimientoDefectos.CmbBxAbreviaturaCapituloChange(
  Sender: TObject);
var
   CCap: integer;
   ACap, LCap: string;

begin
    { Inicializamos el código y el literal del capítulo }
    edtCodigoCapitulo.Text := '';
    edtLiteralCapitulo.Text := '';
    if (CmbBxAbreviaturaCapitulo.ItemIndex = -1) then
       CmbBxAbreviaturaCapitulo.ItemIndex := 0;
    CmbBxAbreviaturaCapitulo.Items[CmbBxAbreviaturaCapitulo.ItemIndex];
    InicializarApartados;
    InicializarDefectos;


    if (AbreviaturaValido (CmbBxAbreviaturaCapitulo.Items[CmbBxAbreviaturaCapitulo.ItemIndex])) then
    begin
        ACap := CmbBxAbreviaturaCapitulo.Items[CmbBxAbreviaturaCapitulo.ItemIndex];
        Devolver_CodLiteral_Capitulo (CCap, Acap, LCap);
        RellenarCapitulo (CCap, Acap, LCap);

        CargarAbreviaturasApartados_ComboBox (StrToInt(edtCodigoCapitulo.Text), CmbBxAbreviaturaApartado.Items);
    end

end;

procedure  TfrmMantenimientoDefectos.CargarAbreviaturasCapitulos_ComboBox (Elementos: TStrings);
{ Devuelve las abreviaturas de los defectos en el combo box
  CmbBxAbreviaturaCapitulo }
var
   qryConsultas: TClientDataSet;
   sdsConsultas: TSQLDataSet;
   dspConsultas: TDataSetProvider;

begin
  sdsConsultas := TSQLDataSet.Create(Self);
  sdsConsultas.SQLConnection := MyBD;
  sdsConsultas.CommandType := ctQuery;
  sdsConsultas.GetMetadata := false;
  sdsConsultas.NoMetadata := true;
  sdsConsultas.ParamCheck := false;  

  dspConsultas := TDataSetProvider.Create(self);
  dspConsultas.DataSet := sdsConsultas;
  dspConsultas.Options := [poIncFieldProps,poAllowCommandText];
  qryConsultas :=TClientDataSet.Create(Self);
    try
       Elementos.Clear;
       try
         with qryConsultas do
         begin
             SetProvider(dspConsultas);
             CommandText := ('SELECT ABRCAPIT FROM TCAPITULOS');
             {$IFDEF TRAZAS}
               FTrazas.PonComponente (TRAZA_SQL,49,FICHERO_ACTUAL,qryConsultas);
             {$ENDIF}
             Open;
             Application.ProcessMessages;
         end;
         qryConsultas.First;

         while (not qryConsultas.eof) do
         begin
            Elementos.Add(qryConsultas.Fields[0].AsString);
            qryConsultas.Next;
         end;
       except
            on E:Exception do
            begin
                FAnomalias.PonAnotacion (TRAZA_SIEMPRE,11,FICHERO_ACTUAL, 'NO se han podido cargar las abreviaturas de los defectos visuales en el combo box: ' + E.Message);
            end;
       end;
    finally
         qryConsultas.Free;
    end;
end;


procedure TfrmMantenimientoDefectos.CargarAbreviaturasApartados_ComboBox (CodigoCap: integer; Elementos: TStrings);
{ Devuelve las abreviaturas de los defectos en el combo box
  CmbBxAbreviaturaApartado }
var
   qryConsultas: TClientDataSet;
   sdsConsultas: TSQLDataSet;
   dspConsultas: TDataSetProvider;
begin
  sdsConsultas := TSQLDataSet.Create(Self);
  sdsConsultas.SQLConnection := MyBD;
  sdsConsultas.CommandType := ctQuery;
  sdsConsultas.GetMetadata := false;
  sdsConsultas.NoMetadata := true;
  sdsConsultas.ParamCheck := false;  

  dspConsultas := TDataSetProvider.Create(self);
  dspConsultas.DataSet := sdsConsultas;
  dspConsultas.Options := [poIncFieldProps,poAllowCommandText];
  qryConsultas :=TClientDataSet.Create(Self);
    try
       Elementos.Clear;
       try
         with qryConsultas do
         begin

             SetProvider(dspConsultas);
             CommandText := 'SELECT ABRAPART FROM TAPARTADOS WHERE CODCAPIT=:CodigoCap ';
             Params[0].AsInteger := CodigoCap;
             {$IFDEF TRAZAS}
               FTrazas.PonComponente (TRAZA_SQL,50,FICHERO_ACTUAL,qryConsultas);
             {$ENDIF}
             Open;
             Application.ProcessMessages;
         end;

         qryConsultas.First;
         while (not qryConsultas.eof) do
         begin
            Elementos.Add(qryConsultas.Fields[0].AsString);
            qryConsultas.Next;
         end;
       except
            on E:Exception do
            begin
                FAnomalias.PonAnotacion (TRAZA_SIEMPRE,12,FICHERO_ACTUAL, 'NO se han podido cargar las abreviaturas de los Apartados de los apartados de los defectos visuales en el combo box: ' + E.Message);
            end;
       end;
    finally
         qryConsultas.Free;
    end;
end;


procedure TfrmMantenimientoDefectos.CargarAbreviaturasDefectos_ComboBox (CodCap, CodApa: integer; Elementos: tstrings);
{ Devuelve las abreviaturas de los defectos en el combo box CmbBxAbreviaturaDefecto }
var
   qryConsultas: TClientDataSet;
   sdsConsultas: TSQLDataSet;
   dspConsultas: TDataSetProvider;
begin
  sdsConsultas := TSQLDataSet.Create(Self);
  sdsConsultas.SQLConnection := MyBD;
  sdsConsultas.CommandType := ctQuery;
  sdsConsultas.GetMetadata := false;
  sdsConsultas.NoMetadata := true;
  sdsConsultas.ParamCheck := false;

  dspConsultas := TDataSetProvider.Create(self);
  dspConsultas.DataSet := sdsConsultas;
  dspConsultas.Options := [poIncFieldProps,poAllowCommandText];
  qryConsultas :=TClientDataSet.Create(Self);
    try
       Elementos.Clear;
       try
         with qryConsultas do
         begin
             if trim(cbclase.Text)='Moto' then clase:='1';
             if trim(cbclase.Text)='Auto' then clase:='2';
             SetProvider(dspConsultas);
             CommandText := 'SELECT ABRDEFEC FROM TDEFECTOS WHERE CODCAPIT=:CodCap AND CODAPART=:CodApa AND TRIM(CODCLASE)=TRIM(:CLASE)';
             Params[0].AsInteger := CodCap;
             Params[1].AsInteger := CodApa;
             Params[2].AsString:= clase;
             {$IFDEF TRAZAS}
               FTrazas.PonComponente (TRAZA_SQL,51,FICHERO_ACTUAL,qryConsultas);
             {$ENDIF}
             Open;
             Application.ProcessMessages;
         end;

         qryConsultas.First;
         while (not qryConsultas.eof) do
         begin
            Elementos.Add(qryConsultas.Fields[0].AsString);
            qryConsultas.Next;
         end;
       except
            on E:Exception do
            begin
                FAnomalias.PonAnotacion (TRAZA_SIEMPRE,13,FICHERO_ACTUAL, 'NO se han podido cargar las abreviaturas de los defectos de los defectos visuales en el combo box: ' + E.Message);
            end;
       end;
    finally
         qryConsultas.Free;
    end;
end;


procedure TfrmMantenimientoDefectos.CmbBxAbreviaturaCapituloKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
var
   iPosicion_Combo: integer; { almacena de forma temporal el valor de ItemIndex
                               del combo porque tras ejecutarse Combo_ConTeclas
                               el valor de ItemIndex = -1 }
begin
   iPosicion_Combo := CmbBxAbreviaturaCapitulo.Itemindex;
   if Key = VK_SPACE then
     Combo_ConTeclas (CmbBxAbreviaturaCapitulo, Key);

   CmbBxAbreviaturaCapitulo.Itemindex := iPosicion_Combo;
end;

procedure TfrmMantenimientoDefectos.CmbBxAbreviaturaApartadoKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
var
   iPosicion_Combo: integer; { almacena de forma temporal el valor de ItemIndex
                               del combo porque tras ejecutarse Combo_ConTeclas
                               el valor de ItemIndex = -1 }
begin
   iPosicion_Combo := CmbBxAbreviaturaApartado.Itemindex;
   if Key = VK_SPACE then
     Combo_ConTeclas (CmbBxAbreviaturaApartado, Key);
   CmbBxAbreviaturaApartado.Itemindex := iPosicion_Combo;
end;

procedure TfrmMantenimientoDefectos.CmbBxAbreviaturaDefectoKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
var
   iPosicion_Combo: integer; { almacena de forma temporal el valor de ItemIndex
                               del combo porque tras ejecutarse Combo_ConTeclas
                               el valor de ItemIndex = -1 }

begin
   iPosicion_Combo := CmbBxAbreviaturaDefecto.Itemindex;
   if Key = VK_SPACE then
     Combo_ConTeclas (CmbBxAbreviaturaDefecto, Key);
   CmbBxAbreviaturaDefecto.Itemindex := iPosicion_Combo;
end;

procedure TfrmMantenimientoDefectos.edtLiteralCapituloExit(
  Sender: TObject);
begin
    if (edtCodigoCapitulo.Text = '') then
    begin
        MessageDlg (CABECERA_MENSAJES_MDEFECTO, MSJ_MDEF_CODCAPMAL, mtInformation, [mbOk], mbOk, 0);
        edtCodigoCapitulo.setfocus;
    end;
end;


procedure TfrmMantenimientoDefectos.edtLiteralApartadoExit(
  Sender: TObject);
begin
    if (edtCodigoApartado.Text = '') then
    begin
        MessageDlg (CABECERA_MENSAJES_MDEFECTO, MSJ_MDEF_CODAPAMAL, mtInformation, [mbOk], mbOk, 0);
        edtCodigoApartado.setfocus;
    end;
end;


procedure TfrmMantenimientoDefectos.edtCodigoApartadoChange(
  Sender: TObject);
var
   CApa: integer;
   AApa, LApa: string;

begin
    { Inicializamos la abreviatura y el literal del apartado }
    if (edtLiteralApartado.Text = '') then
       CmbBxAbreviaturaApartado.ItemIndex := -1;
    edtLiteralApartado.Text := '';
    InicializarDefectos;

    
    if (edtCodigoApartado.Text <> '') then
    begin
      if (edtCodigoCapitulo.Text <> '') then
      begin
          if (CodigoValido (edtCodigoApartado.Text)) then
          begin
              CApa := StrToInt(edtCodigoApartado.Text);
              Devolver_AbrLiteral_Apartado (StrToInt(edtCodigoCapitulo.Text), Capa, AApa, LApa);
              RellenarApartado (CApa, AApa, LApa);

              CargarAbreviaturasDefectos_ComboBox (StrToInt(edtCodigoCapitulo.Text), StrToInt(edtCodigoApartado.Text),CmbBxAbreviaturaDefecto.Items);
          end
          else
          begin
              MessageDlg (CABECERA_MENSAJES_MDEFECTO, MSJ_MDEF_CODAPAMAL, mtInformation, [mbOk], mbOk, 0);
              edtCodigoApartado.setfocus;
          end;
      end
      else
      begin
          edtCodigoApartado.Text := ''
      end;
    end;

end;

procedure TfrmMantenimientoDefectos.btnBuscarClick(Sender: TObject);
begin
    ActivarCapitulos;
end;


procedure TfrmMantenimientoDefectos.InicializarCapitulos;
{ Inicializa los capítulos }
begin
    edtCodigoCapitulo.Text := '';
    CmbBxAbreviaturaCapitulo.ItemIndex := -1;
    edtLiteralCapitulo.Text := '';
end;


procedure TfrmMantenimientoDefectos.InicializarApartados;
{ Inicializa los apartados }
begin
    edtCodigoApartado.Text := '';
    CmbBxAbreviaturaApartado.ItemIndex := -1;
    edtLiteralApartado.Text := '';
end;


procedure TfrmMantenimientoDefectos.InicializarDefectos;
{ Inicializa los defectos }
begin
    edtCodigoDefecto.Text := '';
    CmbBxAbreviaturaDefecto.ItemIndex := -1;
    edtLiteralDefecto.Text := '';
end;

procedure TfrmMantenimientoDefectos.CmbBxAbreviaturaApartadoChange(
  Sender: TObject);
var
   CApa: integer;
   AApa, LApa: string;

begin
    { Inicializamos el código y el literal del apartado }
    edtCodigoApartado.Text := '';
    edtLiteralApartado.Text := '';
    if (CmbBxAbreviaturaApartado.ItemIndex = -1) then
       CmbBxAbreviaturaApartado.ItemIndex := 0;
    CmbBxAbreviaturaApartado.Items[CmbBxAbreviaturaApartado.ItemIndex];
    InicializarDefectos;

    if (AbreviaturaValido (CmbBxAbreviaturaApartado.Items[CmbBxAbreviaturaApartado.ItemIndex])) then
    begin
        AApa := CmbBxAbreviaturaApartado.Items[CmbBxAbreviaturaApartado.ItemIndex];
        Devolver_CodLiteral_Apartado (StrToInt(edtCodigoCapitulo.Text), CApa, AApa, LApa);
        RellenarApartado (CApa, AApa, LApa);

        CargarAbreviaturasDefectos_ComboBox (StrToInt(edtCodigoCapitulo.Text), StrToInt(edtCodigoApartado.Text),CmbBxAbreviaturaDefecto.Items);
    end
    
end;


function TfrmMantenimientoDefectos.Rellenar_CodigosCapituloApartado (var Valores: tValoresDefecto): boolean;
{ Devuelve True si se han logrado rellenar el código del capítulo y apartado correctamente }
begin
    try
      Valores.CodigoCapitulo := StrToInt (edtCodigoCapitulo.Text);
      Valores.CodigoApartado := StrToInt (edtCodigoApartado.Text);
      Result := True;
    except
        on E:Exception do
        begin
            Result := False;
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,14,FICHERO_ACTUAL, 'Error en Rellenar_CodigosCapituloApartado: ' + E.Message);
        end;
    end;
end;


function TfrmMantenimientoDefectos.DevolverMaximoNumeroDefectos (Valores: tValoresDefecto; var MaxNum: integer): boolean;
{ Devuelve el número máximo de defectos visuales de un apartado }
var
  qryConsultas: TSQLQuery;

begin
    qryConsultas := TSQLQuery.Create(self);
    try
       try
          with qryConsultas do
          begin
              if trim(cbclase.Text)='Moto' then clase:='1';
              if trim(cbclase.Text)='Auto' then clase:='2';
              Close;
              Sql.Clear;
              SQLConnection := MyBD;
              Sql.Add ('SELECT MAX(CODDEFEC) FROM TDEFECTOS');
              Sql.Add ('  WHERE CODCAPIT=:Valores.CodigoCapitulo AND CODAPART=:Valores.CodigoApartado AND TRIM(CODCLASE)=TRIM(:CLASE)');
              Params[0].AsInteger := Valores.CodigoCapitulo;
              Params[1].AsInteger := Valores.CodigoApartado;
              Params[2].AsString:= clase;
              {$IFDEF TRAZAS}
                FTrazas.PonComponente (TRAZA_SQL,52,FICHERO_ACTUAL,qryConsultas);
              {$ENDIF}
              Open;
              Application.ProcessMessages;
              {$IFDEF TRAZAS}
                FTrazas.PonRegistro (TRAZA_REGISTRO,66,FICHERO_ACTUAL,qryConsultas);
              {$ENDIF}
              MaxNum := Fields[0].AsInteger;
          end;
          Result := True;
       except
            on E:Exception do
            begin
                Result := False;
                FAnomalias.PonAnotacion (TRAZA_SIEMPRE,15,FICHERO_ACTUAL,'NO se han podido obtener el máximo nº defectos: ' + E.Message);
            end;
       end;
    finally
         qryConsultas.Free;
    end;
end;


function TfrmMantenimientoDefectos.ExisteDefecto_TDEFECTOS (Valores: tValoresDefecto): boolean;
{ Devuelve true si el defecto que se desea añadir ya existe en TDEFECTOS }
var
  qryConsultas: TSQLQuery;

begin
    qryConsultas := TSQLQuery.Create(self);
    try
       try
         with qryConsultas do
         begin
             Close;
             Sql.Clear;
             SQLConnection := MyBD;
             Sql.Add ('SELECT NUMDEFEC FROM TDEFECTOS');
             Sql.Add ('  WHERE CODCAPIT=:Valores.CodigoCapitulo AND CODAPART=:Valores.CodigoApartado AND CODDEFEC=:Valores.CodigoDefecto');
             Params[0].AsInteger := Valores.CodigoCapitulo;
             Params[1].AsInteger := Valores.CodigoApartado;
             Params[2].AsInteger := Valores.CodigoDefecto;
             {$IFDEF TRAZAS}
               FTrazas.PonComponente (TRAZA_SQL,53,FICHERO_ACTUAL,qryConsultas);
             {$ENDIF}
             Open;
             Application.ProcessMessages;
             {$IFDEF TRAZAS}
               FTrazas.PonRegistro (TRAZA_REGISTRO,67,FICHERO_ACTUAL,qryConsultas);
             {$ENDIF}
             Result := (Fields[0].AsInteger <> 0);
         end;
       except
            on E:Exception do
            begin
                Result := False;
                FAnomalias.PonAnotacion (TRAZA_SIEMPRE,16,FICHERO_ACTUAL, 'El defecto SI existe en TDEFECTOS: ' + E.Message);
            end;
       end;
    finally
         qryConsultas.Free;
    end;
end;


function TFrmMantenimientoDefectos.CodigoDefectoValido (sCodDef: string): boolean;
{ Devuelve true si el código del defecto introducido es correcto }
var
   iValorAuxi: integer; { variable auxiliar que almacena un entero }
   iCodErr: integer;

begin
    try
       Val (sCodDef, iValorAuxi, iCodErr);
       Result := ((iCodErr = 0) and (iValorAuxi <> 0));
    except
         on E:Exception do
         begin
             Result := False;
             FAnomalias.PonAnotacion (TRAZA_SIEMPRE,17,FICHERO_ACTUAL,'Error en CodigoValido: ' + E.Message);
         end;
    end;
end;


procedure TfrmMantenimientoDefectos.btnModificarClick(Sender: TObject);
var
  frmNuevoDefecto_Auxi: TfrmNuevoDefecto;
  ValoresDefecto : tValoresDefecto;

begin
  frmNuevoDefecto_Auxi := nil;
  try
     try
        if CodigoDefectoValido (edtCodigoDefecto.Text) then
        begin
            frmNuevoDefecto_Auxi := TfrmNuevoDefecto.Create(Application);
            //frmNuevoDefecto_Auxi.Caption := CAPTION_Modificar_DEFECTO;

            ValoresDefecto.CodigoDefecto := StrToInt(edtCodigoDefecto.Text);
            ValoresDefecto.AbreviaturaDefecto := CmbBxAbreviaturaDefecto.Items[CmbBxAbreviaturaDefecto.Itemindex];
            ValoresDefecto.LiteralDefecto := edtLiteralDefecto.Text;
            if (not (ChkBxActivoDefecto.Checked)) then
              ValoresDefecto.DefectoActivo := DEFECTO_NOACTIVO;

            frmNuevoDefecto_Auxi.Inicializar_DefectoActivo_Modificar;
            if frmNuevoDefecto_Auxi.Inicializar_OtrosCampos_Modificar (ValoresDefecto) then
            begin
                frmNuevoDefecto_Auxi.ShowModal;
                if frmNuevoDefecto_Auxi.ModalResult = mrOk then
                begin
                    { Hay que rellenar el código de capítulo y apartado del defecto }
                    if Rellenar_CodigosCapituloApartado (ValoresDefecto) then
                    begin
                        if FrmNuevoDefecto_Auxi.LeerValoresDefecto (ValoresDefecto) then
                        begin
                            { Hay que añadir un nuevo defecto }
                            if ModificarDefecto_TDEFECTOS (ValoresDefecto) then
                            begin
                                { Si se ha añadido correctamente un defecto, entonces hay que
                                  refrescar lo que el usuario ve por pantalla }

                                CargarAbreviaturasDefectos_ComboBox
                                  (StrToInt(edtCodigoCapitulo.Text), StrToInt(edtCodigoApartado.Text),
                                  CmbBxAbreviaturaDefecto.Items);

                                with ValoresDefecto do
                                  RellenarDefecto (CodigoDefecto, AbreviaturaDefecto, LiteralDefecto, DefectoActivo);

                                { Como se ha modificado la tabla TDEFECTOS, hey que generar un nuevo fichero
                                  DEFECT.INI }
                                bFicheroDefModificado := True;
                            end;
                        end;
(*
{----------------------------------------------------------------}
                                CargarAbreviaturasDefectos_ComboBox
                                  (StrToInt(edtCodigoCapitulo.Text), StrToInt(edtCodigoApartado.Text),
                                  CmbBxAbreviaturaDefecto.Items);


                                { Como se ha modificado la tabla TDEFECTOS, hey que generar un nuevo fichero
                                  DEFECT.INI }
                                //bFicheroDefModificado := True;
{----------------------------------------------------------------}
*)
                    end;
                end;
            end;
        end
        else
        begin
            MessageDlg (CABECERA_MENSAJES_MDEFECTO, MSJ_MDEF_CODDEFMAL, mtInformation, [mbOk], mbOk, 0);
            edtCodigoDefecto.Setfocus;
        end;
     except
          on E:Exception do
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,18,FICHERO_ACTUAL, 'Error en btnModificarClick: ' + E.Message);
     end;
  finally
       frmNuevoDefecto_Auxi.Free;
  end;
end;


function TFrmMantenimientoDefectos.ModificarDefecto_TDEFECTOS (Valores: tValoresDefecto): boolean;
{ Devuelve True si los defectos se han modificado correctamente }
var
   qryConsultas: TSQLQuery;

begin
    qryConsultas := TSQLQuery.Create (nil);
    try
       try
         with qryConsultas do
         begin
             if trim(cbclase.Text)='Moto' then clase:='1';
             if trim(cbclase.Text)='Auto' then clase:='2';
             Close;
             Sql.Clear;
             SQLConnection := MyBD;
             Sql.Add ('UPDATE TDEFECTOS');
             Sql.Add ('  SET ACTIVO=:Valores.DefectoActivo,');
             Sql.Add ('  ABRDEFEC=:Valores.AbreviaturaDefecto,');
             Sql.Add ('  LITDEFEC=:Valores.LiteralDefecto');
             Sql.Add ('  WHERE CODCAPIT=:Valores.CodigoCapitulo AND CODAPART=:Valores.CodigoApartado AND CODDEFEC=:Valores.CodigoDefecto AND TRIM(CODCLASE)=TRIM(:CLASE)');
             Params[0].AsString := Valores.DefectoActivo;
             Params[1].AsString := Valores.AbreviaturaDefecto;
             Params[2].AsString := Valores.LiteralDefecto;
             Params[3].AsInteger := Valores.CodigoCapitulo;
             Params[4].AsInteger := Valores.CodigoApartado;
             Params[5].AsInteger := Valores.CodigoDefecto;
             Params[6].AsString:=CLASE;
             {$IFDEF TRAZAS}
               FTrazas.PonComponente (TRAZA_SQL,55,FICHERO_ACTUAL,qryConsultas);
             {$ENDIF}
             ExecSQL;
             Application.ProcessMessages;
         end;
         Result := True;
         {$IFDEF TRAZAS}
            FTrazas.PonAnotacion (TRAZA_FLUJO,14,FICHERO_ACTUAL,'Se ha modificado un defecto de TDEFECTOS');
         {$ENDIF}
       except
           on E:Exception do
           begin
               Result := False;
               FAnomalias.PonAnotacion (TRAZA_SIEMPRE,19,FICHERO_ACTUAL,'Se ha modificado un defecto de TDEFECTOS: ' + E.Message);
           end;
       end;
    finally
        qryConsultas.Free;
    end;
end;

procedure TfrmMantenimientoDefectos.btnSalirClick(Sender: TObject);
var
  aFTmp: TFTmp;

begin
    aFTmp := TFTmp.Create (Application);
    Self.Enabled := False;
    try
      aFTmp.MuestraClock('Ficheros','Generando el fichero de defectos de los vehículos');

      if (bFicheroDefModificado) then
      begin
          aFTmp.Hide;
          Generacion_FicheroINIDefectos;
      end
      else
      begin
          {$IFDEF TRAZAS}
             FTrazas.PonAnotacion (TRAZA_FLUJO,17,FICHERO_ACTUAL,'No se han modificado los defectos');
          {$ENDIF}
      end;
    finally
         aFTmp.Free;
         Self.Enabled := True;
         Self.Show;
    end;
end;


procedure TfrmMantenimientoDefectos.Generacion_FicheroINIDefectos;
{ Hay que generar un fichero INI con los defectos }
var
   { FicheroINIDe contiene la cabecera del mensaje de salida indicando si ha
     sido generado correcta o incorrectamente.
     Mens_Sal es un mensaje de información para el usuario indicando si se ha
     podido o no generar el fichero INI }
   FicheroINIDe, Mens_Sal: string;
begin
    MessageDlg (Caption, 'A continuación se va a generar el fichero DEFECT.INI.', mtInformation, [mbOk], mbOk, 0);
    FicheroINIDe := 'Defectos';

    if (TipoEquipo <> CONSOLA_VALUE)
      Then begin
         if PasarDe_TablaTCAPITULOS_TAPARTADOS_TDEFECTOS_FicheroINI (TipoEquipo, DirectorioIn) then
           Mens_Sal := MSJ_UMAIN_FICHINI_CORRECTO
         else
           Mens_Sal := MSJ_UMAIN_FICHINI_INCORRECTO;

         Mostrar_Mensaje_Salida_FicherosINI (FicheroINIDe, Mens_Sal);
      end;
end;


procedure TfrmMantenimientoDefectos.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    { Si se pulsa Alr+F4 => se asocia dicha combinación de teclas a CANCELAR }
    if Ha_Pulsado_AltF4 (Shift, Key) then
       btnSalirClick(Sender);
end;

procedure TfrmMantenimientoDefectos.btnImprimirClick(Sender: TObject);
var
  frmImprimirDefectos_Auxi: TfrmImprimirDefectos;
  aFTmp: TFTmp;

begin
    aFTmp := TFTmp.Create (Application);
    Self.Enabled := False;
    try
      aFTmp.MuestraClock('Impresión','Imprimiendo los defectos de los vehículos');
      frmImprimirDefectos_Auxi := TfrmImprimirDefectos.Create (Application);
      try
         if ImpresoraPreparada_ImprimirInformes then
         begin
            frmImprimirDefectos_Auxi.SeleccionarDefectos;
//            frmImprimirDefectos_Auxi.QRDefectos.Print;     MODI 2.75
            frmImprimirDefectos_Auxi.QRDefectos.Preview;
         end
         else
         begin
             aFTmp.Hide;
             Lanzar_ErrorImpresion_Mantenimiento;
         end;
      finally
           frmImprimirDefectos_Auxi.Free;
      end;
    finally
         Self.Enabled := True;
         Self.Show;
         aFTmp.Free;
    end;
end;


procedure TfrmMantenimientoDefectos.edtCodigoCapituloKeyPress(
  Sender: TObject; var Key: Char);
begin
    if (not (Key in ['0'..'9',#8])) then
       Key := #0
end;

procedure TfrmMantenimientoDefectos.edtCodigoCapituloEnter(
  Sender: TObject);
begin
    DestacarControl (Sender, clGreen, clWhite, False);
end;

procedure TfrmMantenimientoDefectos.edtCodigoCapituloExit(Sender: TObject);
begin
    AtenuarControl (Sender, False);
end;

end.
