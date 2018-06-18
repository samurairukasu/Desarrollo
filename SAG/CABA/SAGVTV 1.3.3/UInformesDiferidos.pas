unit UInformesDiferidos;
{ Realiza los informes diferidos }

{
  Ultima Traza: 20
  Ultima Incidencia: 2
  Ultima Anomalia: 9
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask, Db, USAGVARIOS, UCEdit,
  UCTIMPRESION, DBTables;

type
  TfrmInformesDiferidos = class(TForm)
    btnImprimir: TBitBtn;
    btnSalir: TBitBtn;
    Bevel1: TBevel;
    ChkBxImprimirPorFechas: TCheckBox;
    Bevel2: TBevel;
    lblFechaInicio: TLabel;
    lblFechaFin: TLabel;
    Bevel3: TBevel;
    lblInformeInicial: TLabel;
    lblInformeFinal: TLabel;
    edtFechaInicial: TMaskEdit;
    edtFechaFinal: TMaskEdit;
    qryConsultas: TQuery;
    edtInformeInicial: TColorEdit;
    edtInformeFinal: TColorEdit;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure ChkBxImprimirPorFechasClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtFechaInicialEnter(Sender: TObject);
    procedure edtFechaInicialExit(Sender: TObject);
    procedure edtInformeInicialExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    // Activa los informes de inspección y desactiva las fechas
    procedure ActivarDesactivarInformes (const bActivar: boolean);
    function Imprimir_InformesDiferidos (iEjerIni, iCodIni, iEjerFin, iCodFin: integer): boolean;
    //function Obtener_NumeroInsp_ConFechas (sFechaInic, sFechaFin: string; var iEjerIni, iCodIni, iEjerFin, iCodFin: integer): boolean;
    procedure Chequear_ImpresionPorFechas;
    function EsMenor_NumeroInsp (iEjerIni, iCodIni, iEjerFin, iCodFin: integer): boolean;
    //function Leer_UltimoID_TVARIOS (var sUltimoId: string): boolean;
    function Cargar_Fechas_Informes: boolean;
    function Guardar_ProximaFechaInforme (sCadena: string): boolean;
    function ObtenerUltimoCodigoInspeccion_TINSPECCION (var iEjer, iCod: integer): boolean;

    function EsZonaCorrecta_NumeroInspeccion (sNumInsp: string): boolean;
    function EsEstacionCorrecta_NumeroInspeccion (sNumInsp: string): boolean;

    //Envía al servidor de impresión las inspecciones diferidas por fechas
    function Imprimir_InspeccionesDiferidas_Fechas (sFechaInic, sFechaFin: string): boolean;
    // Devuelve True si ha logrado enviar un trabajo correctamente al servidor de impresión
    function EnviarTrabajo_ServidorImpresion (const sEjer, sCodInsp, sMatr: string; const aTrabajo: tTrabajo): boolean;


  public
      { Public declarations }
      constructor CreateFromInformeDiferido;
  end;

var
  frmInformesDiferidos: TfrmInformesDiferidos;

implementation

{$R *.DFM}

uses
   //UConst,
   ULOGS,
   UCDIALGS,
   //COMUNES, UTIPOS, UCLIENTE, UCTCOMUN,
   GLOBALS,
   UINTERFAZUSUARIO,
   UUTILS,
   USAGESTACION,
   USAGCLASSES,
   UCLIENTE;


resourcestring
      CABECERA_MENSAJES_INFDIF = 'Informes Diferidos';
      FICHERO_ACTUAL = 'UInformesDiferidos';

      { Mensajes enviados al usuario desde InfDif }
      MSJ_INFDIF_INFMAL = 'El número del informe de inspección no se ha introducido o es incorrecto. Por favor introdúzcalo de nuevo';
      MSJ_INDIF_FECHAMAL = 'No se ha introducido la fecha o ésta es incorrecta';
      MSJ_INDIF_FECHAMEN = 'Lo siento pero la fecha inicial debe ser menor o igual que la final';
      MSJ_INDIF_ERRBD = 'Lo siento pero ha ocurrido un error con la base de datos y NO se podrán imprimir los informes diferidos.';
      MSJ_INFDIF_INFMAYOR = 'Lo siento pero el informe de inspección inicial debe ser menor o igual que el final. Por favor, introdúzcalo de nuevo';


constructor TfrmInformesDiferidos.CreateFromInformeDiferido;
begin
    inherited Create (Application);

    with qryConsultas do
    begin
        Close;
        DatabaseName := MyBD.DatabaseName;
        SessionName := MyBD.SessionName;
    end;

    { Por defecto imprimiré por nº informe inspección }
    Cargar_Fechas_Informes;
end;

procedure TfrmInformesDiferidos.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
    if (Key = Chr(VK_RETURN)) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TFrmInformesDiferidos.Chequear_ImpresionPorFechas;
{ Activa o desactiva las fechas o números de informes }
begin
    if chkbxImprimirPorFechas.Checked then
       ActivarDesactivarInformes (False)
    else
       ActivarDesactivarInformes (True);
end;

// Activa los informes de inspección y desactiva las fechas
procedure TFrmInformesDiferidos.ActivarDesactivarInformes (const bActivar: boolean);
begin
    lblInformeInicial.Enabled := bActivar;
    lblInformeFinal.Enabled := bActivar;
    edtInformeInicial.Enabled := bActivar;
    edtInformeFinal.Enabled := bActivar;

    lblFechaInicio.Enabled := not bActivar;
    lblFechaFin.Enabled := not bActivar;
    edtFechaInicial.Enabled := not bActivar;
    edtFechaFinal.Enabled := not bActivar;


    if bActivar then
    begin
       edtInformeInicial.Font.Color := clBlack;
       edtInformeFinal.Font.Color := clBlack;

       edtFechaInicial.Font.Color := clGray;
       edtFechaFinal.Font.Color := clGray;
    end
    else
    begin
        edtInformeInicial.Font.Color := clGray;
        edtInformeFinal.Font.Color := clGray;

       edtFechaInicial.Font.Color := clBlack;
       edtFechaFinal.Font.Color := clBlack;
    end;
end;

procedure TfrmInformesDiferidos.btnImprimirClick(Sender: TObject);
var
   iEjerIni, iCodIni, iEjerFin, iCodFin: integer; { almacenar el ejercicio y
      código de inspección inicial y final cuyos informes se desean imprimir }

begin
  try
    { Hay que comprobar si el intervalo de fechas o los informes introducidos
      son correctos y el inicial es menor o igual que el final }
    if chkbxImprimirPorFechas.Checked then
    begin
        if FechaCorrecta (edtFechaInicial.Text) then
        begin
            if FechaCorrecta (edtFechaFinal.Text) then
            begin
                if EsFechaMenor (edtFechaInicial.Text, edtFechaFinal.Text) then
                begin
                    if Imprimir_InspeccionesDiferidas_Fechas (edtFechaInicial.Text, edtFechaFinal.Text) then
                    begin
                        fVarios.ValueByName[FIELD_ULTIMOID] := edtFechaFinal.Text;
                        fVarios.Post;

                        ModalResult := mrOk;
                    end
                    else
                       fVarios.Cancel;

                    (*
                    if Obtener_NumeroInsp_ConFechas (edtFechaInicial.Text, edtFechaFinal.Text, iEjerIni, iCodIni, iEjerFin, iCodFin) then
                    begin
                        if Imprimir_InformesDiferidos (iEjerIni, iCodIni, iEjerFin, iCodFin) then
                           Guardar_ProximaFechaInforme (edtFechaFinal.Text);
                        ModalResult := mrOk;
                    end
                    else
                    begin
                        FIncidencias.PonAnotacion (TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'Error al obtener_NumeroInsp_ConFechas');
                        MessageDlg (CABECERA_MENSAJES_INFDIF, MSJ_INDIF_ERRBD, mtInformation, [mbOk], mbOk, 0);
                    end;
                    *)
                end
                else
                begin
                    MessageDlg (CABECERA_MENSAJES_INFDIF, MSJ_INDIF_FECHAMEN, mtInformation, [mbOk], mbOk, 0);
                    edtFechaInicial.setfocus;
                end;
            end
            else
            begin
                MessageDlg (CABECERA_MENSAJES_INFDIF, MSJ_INDIF_FECHAMAL, mtInformation, [mbOk], mbOk, 0);
                edtFechaFinal.setfocus;
            end;
        end
        else
        begin
            MessageDlg (CABECERA_MENSAJES_INFDIF, MSJ_INDIF_FECHAMAL, mtInformation, [mbOk], mbOk, 0);
            edtFechaInicial.setfocus;
        end;
    end
    else
    begin
(*
        { Se imprime una serie de informes de inspección cuyos números se
          encuentran entre un rango de valores }
        if (EsZonaCorrecta_NumeroInspeccion (edtInformeInicial.Text) and EsEstacionCorrecta_NumeroInspeccion (edtInformeInicial.Text) and NumeroInspeccion_Correcto (edtInformeInicial.Text)) then
        begin
            if (EsZonaCorrecta_NumeroInspeccion (edtInformeFinal.Text) and EsEstacionCorrecta_NumeroInspeccion (edtInformeFinal.Text) and NumeroInspeccion_Correcto (edtInformeFinal.Text)) then
            begin
                iEjerIni := Obtener_Ejercicio (edtInformeInicial.Text);
                iCodIni := Obtener_NumeroInspeccion (edtInformeInicial.Text);
                iEjerFin := Obtener_Ejercicio (edtInformeFinal.Text);
                iCodFin := Obtener_NumeroInspeccion (edtInformeFinal.Text);
                if (EsMenor_NumeroInsp (iEjerIni, iCodIni, iEjerFin, iCodFin)) then
                begin
                    if Imprimir_InformesDiferidos (iEjerIni, iCodIni, iEjerFin, iCodFin) then
                       Guardar_ProximaFechaInforme (edtInformeFinal.Text);
                    ModalResult := mrOk;
                end
                else
                begin
                    MessageDlg (CABECERA_MENSAJES_INFDIF, MSJ_INFDIF_INFMAYOR, mtInformation, [mbOk], mbOk, 0);
                    edtInformeInicial.setfocus;
                end;
            end
            else
            begin
                MessageDlg (CABECERA_MENSAJES_INFDIF, MSJ_INFDIF_INFMAL, mtInformation, [mbOk], mbOk, 0);
                edtInformeFinal.setfocus;
            end
        end
        else
        begin
            MessageDlg (CABECERA_MENSAJES_INFDIF, MSJ_INFDIF_INFMAL, mtInformation, [mbOk], mbOk, 0);
            edtInformeInicial.setfocus;
        end
*)
    end;
  except
       on E:Exception do
          FAnomalias.PonAnotacion (TRAZA_SIEMPRE,6,FICHERO_ACTUAL, 'Error en btnImprimirClick: ' + E.Message);
  end;
end;


function TFrmInformesDiferidos.Imprimir_InformesDiferidos (iEjerIni, iCodIni, iEjerFin, iCodFin: integer): boolean;
{ Devuelve True si se han podido imprimir los informes comprendidos entre dos valores }
const
   MSJ_INFDIF_INFDIFMAL = 'Lo siento pero el servidor de impresión NO ha aceptado el informe %s. Verifique que funcione correctamente.';
(*
var

   bInformeAceptadoServImpres: boolean; { True si el informe diferido ha sido
                                          aceptado por el servidor de impresión }
   sNumInsp_Auxi: string; { var. auxi que almacenará el nº inspección }
   SolicitudDeServicio_Impresion: tPeticionDeServicio;
*)
begin
    Result := False;
    try
       with qryConsultas do
       begin
           Close;
           Sql.Clear;
           Sql.Add ('SELECT I.EJERCICI, I.CODINSPE, decode(I.TIPO,''R'',''R'',''''), nvl(V.patenten,v.patentea) matricul');
           Sql.Add ('  FROM TINSPECCION I, TVEHICULOS V');
           Sql.Add ('  WHERE (I.EJERCICI >=:iEjerIni AND I.CODINSPE>=:iCodIni) AND');
           Sql.Add ('        (I.EJERCICI<=:iEjerFin AND I.CODINSPE<=:iCodFin) AND');
           Sql.Add ('        I.CODVEHIC=V.CODVEHIC AND');
           Sql.Add ('        I.INSPFINA=''S''');
           Prepare;
           Params[0].AsInteger := iEjerIni;
           Params[1].AsInteger := iCodIni;
           Params[2].AsInteger := iEjerFin;
           Params[3].AsInteger := iCodFin;
           {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 3, FICHERO_ACTUAL, qryConsultas);
           {$ENDIF}
           Open;
           Application.ProcessMessages;
           while (not qryConsultas.eof) do
           begin
               (*
               with SolicitudDeServicio_Impresion do
               begin
                   iServicio := InformeDiferido;
                   with dCabecera do
                   begin
                       iCodigoInspeccion := FieldByName ('CODINSPE').AsInteger;
                       iEjercicio := FieldByName ('EJERCICI').AsInteger;
                       sMatricula := FieldByName ('MATRICUL').AsString;
                   end;
               end;

               bInformeAceptadoServImpres := (TrabajoEnviadoOk (SolicitudDeServicio_Impresion.dCabecera, SolicitudDeServicio_Impresion.iServicio));
               if (not bInformeAceptadoServImpres) then
               begin
                   { Si ha ocurrido algún error raro con el servidor de impresión
                     NO continúo imprimiendo y genero una incidencia }
                     with SolicitudDeServicio_Impresion.dCabecera do
                     begin
                         FIncidencias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Informe diferido NO aceptado: ' +
                                IntToStr(iEjercicio) + '-' +
                                IntToStr(iCodigoInspeccion));
                         { Calculamos el nº inspección para mostrárselo al usuario }
                         sNumInsp_Auxi := Format (MSJ_INFDIF_INFDIFMAL,
                               //[Calcular_NumeroInspeccion (iEjercicio, DatosVarios.dEstacion.Zona, DatosVarios.dEstacion.Estacion, iCodigoInspeccion, FieldByName ('REVERIFI').AsString)]);
                               [Calcular_NumeroInspeccion (iEjercicio, aVarios_Auxi.Zona, aVarios_Auxi.CodeEstacion, iCodigoInspeccion, FieldByName ('REVERIFI').AsString)]);
                         MessageDlg (CABECERA_MENSAJES_INFDIF, sNumInsp_Auxi, mtWarning, [mbOk], mbOk, 0);
                     end;
                   exit;
               end;
               *)
               {$IFDEF TRAZAS}
                  FTrazas.PonRegistro (TRAZA_REGISTRO, 4, FICHERO_ACTUAL, qryConsultas);
               {$ENDIF}
               qryConsultas.Next;
           end;
           Result := True;
       end;
    except
         on E:Exception do
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL, 'Error en Imprimir_InformesDiferidos: ' + E.Message);
    end;
end;

function TFrmInformesDiferidos.Imprimir_InspeccionesDiferidas_Fechas (sFechaInic, sFechaFin: string): boolean;
CONST
   //SELECTED_FIELDS_INSP = 'A.EJERCICI,A.CODINSPE,A.FECHALTA, NVL(B.PATENTEN,B.PATENTEA) PATENTE';
   //SELECTED_FROM = 'TINSPECCION A, TVEHICULOS B';
   CONDITION_FIELDS_INSP = ', TVEHICULOS B where A.FECHALTA>=TO_DATE(''%S'',''dd/mm/yyyy hh24:mi:ss'') AND A.FECHALTA<=TO_DATE(''%S'',''dd/mm/yyyy hh24:mi:ss'') AND A.INSPFINA=''S'' AND A.CODVEHIC=B.CODVEHIC ORDER BY A.FECHALTA';
   HORA_INICIO = '00:00:00';
   HORA_FIN    = '23:59:59';

var
  //sFechaInicial, sFechaFinal: tDateTime;
  aInspec_Auxi: TInspeccionJoin;

begin
    Result := False;
    try
       aInspec_Auxi := TInspeccionJoin.CreateFromPatente (MyBD, Format(CONDITION_FIELDS_INSP,[sFechaInic + ' ' + HORA_INICIO,sFechaFin + ' ' + HORA_FIN]));
       aInspec_Auxi.Open;

       while (not aInspec_Auxi.Eof) do
       begin
           if (not EnviarTrabajo_ServidorImpresion (aInspec_Auxi.ValueByName[FIELD_EJERCICI],aInspec_Auxi.ValueByName[FIELD_CODINSPE],aInspec_Auxi.ValueByName[FIELD_MATRICUL], InformeDiferido)) then
           begin
               FIncidencias.PonAnotacion (TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'Se canceló el trabajo de las impresiones diferidas');
               MessageDlg (Application.Title, 'Informes de inspección cancelados', mtInformation, [mbOk], mbOk, 0);
               exit;
           end;

           aInspec_Auxi.Next;
       end;

       aInspec_Auxi.Free;


    (*
        sFechaInicial := StrToDateTime (sFechaInic + HORA_INICIO);
        sFechaFinal := StrToDateTime (sFechaFin + HORA_FIN);

        with qryConsultas do
        begin
            Close;
            Sql.Clear;
            Sql.Add ('SELECT EJERCICI,CODINSPE,FECHALTA');
            Sql.Add ('  FROM TINSPECCION');
            Sql.Add ('  WHERE FECHALTA>=:sFechaInicial AND');
            Sql.Add ('        FECHALTA<=:sFechaFinal AND');
            Sql.Add ('         INSPFINA=''S''');
            Prepare;
            Params[0].AsDateTime := sFechaInicial;
            Params[1].AsDateTime := sFechaFinal;
            {$IFDEF TRAZAS}
               FTrazas.PonComponente (TRAZA_SQL, 6, FICHERO_ACTUAL, qryConsultas);
            {$ENDIF}
            Open;
            Application.ProcessMessages;
            if (not eof) then
            begin
                iEjerIni := FieldByName ('EJERCICI').AsInteger;
                iCodIni := FieldByName ('CODINSPE').AsInteger;
                {$IFDEF TRAZAS}
                   FTrazas.PonRegistro (TRAZA_REGISTRO, 7, FICHERO_ACTUAL, qryConsultas);
                {$ENDIF}
                Last;
                iEjerFin := FieldByName ('EJERCICI').AsInteger;
                iCodFin := FieldByName ('CODINSPE').AsInteger;
                {$IFDEF TRAZAS}
                   FTrazas.PonRegistro (TRAZA_REGISTRO, 8, FICHERO_ACTUAL, qryConsultas);
                {$ENDIF}
            end;
        end;
    *)
        Result := True;
    except
         on E:Exception do
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,2,FICHERO_ACTUAL, 'Error en Obtener_NumeroInsp_ConFechas: ' + E.Message);
    end;
end;

procedure TfrmInformesDiferidos.ChkBxImprimirPorFechasClick(
  Sender: TObject);
begin
    Chequear_ImpresionPorFechas;
end;

function TfrmInformesDiferidos.EsMenor_NumeroInsp (iEjerIni, iCodIni, iEjerFin, iCodFin: integer): boolean;
begin
    Result := ((iEjerIni <= iEjerFin) and (iCodIni <= iCodFin));
end;

(*
function TFrmInformesDiferidos.Leer_UltimoID_TVARIOS (var sUltimoId: string): boolean;
{ Devuelve True si ha logrado leer el campo ULTIMOID de la tabla TVARIOS }
begin
    Result := False;
    try
       with qryConsultas do
       begin
           Close;
           Sql.Clear;
           Sql.Add ('SELECT ULTIMOID FROM TVARIOS');
           {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 12, FICHERO_ACTUAL, qryConsultas);
           {$ENDIF}
           Open;
           Application.ProcessMessages;

           sUltimoId := FieldByName ('ULTIMOID').AsString;
           {$IFDEF TRAZAS}
              FTrazas.PonRegistro (TRAZA_REGISTRO, 13, FICHERO_ACTUAL, qryConsultas);
           {$ENDIF}
       end;
       Result := True;
    except
         on E:Exception do
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,3,FICHERO_ACTUAL, 'Error en Leer_UltimoID_TVARIOS: ' + E.Message);
    end;
end;
*)

// Devuelve True si ha logrado poner la fecha inicial o el nº informe inicial
function TFrmInformesDiferidos.Cargar_Fechas_Informes: boolean;
var
   iEjer_Auxi, iNumInsp_Auxi: integer; { var. auxi. para guardar el ejercicio y
                                         el nº inspección }
   sCadena: string; { cadena auxiliar }
   FechaAuxi: tDateTime;

begin
    Result := False;
    try
       if (fVarios.ValueByName[FIELD_ULTIMOID] <> '') then
       begin
           if (not FechaCorrecta (fVarios.ValueByName[FIELD_ULTIMOID])) then
           begin
(*
               iEjer_Auxi := Obtener_Ejercicio (sCadena);
               iNumInsp_Auxi := Obtener_NumeroInspeccion (sCadena);
               inc (iNumInsp_Auxi);
               edtInformeInicial.Text := Calcular_NumeroInspeccion
                   {(iEjer_Auxi, DatosVarios.dEstacion.Zona,
                    DatosVarios.dEstacion.Estacion,}
                   (iEjer_Auxi, aVarios_Auxi.Zona,
                    aVarios_Auxi.CodeEstacion,
                    iNumInsp_Auxi, CADENA_VACIA);
               if ObtenerUltimoCodigoInspeccion_TINSPECCION (iEjer_Auxi, iNumInsp_Auxi) then
                  edtInformeFinal.Text := Calcular_NumeroInspeccion
                   {(iEjer_Auxi, DatosVarios.dEstacion.Zona,
                   DatosVarios.dEstacion.Estacion,}
                   (iEjer_Auxi, aVarios_Auxi.Zona,
                    aVarios_Auxi.CodeEstacion,
                    iNumInsp_Auxi, CADENA_VACIA);
               ChkBxImprimirPorFechas.Checked := False;
               Chequear_ImpresionPorFechas;
               edtInformeInicial.setfocus;
*)
           end
           else
           begin
               {if FechaCorrecta (sCadena) then
               begin}
                   FechaAuxi := StrToDate (fVarios.ValueByName[FIELD_ULTIMOID]);
                   FechaAuxi := FechaAuxi + 1;
                   edtFechaInicial.Text := DateToStr (FechaAuxi);
                   edtFechaFinal.Text := DateToStr (Date);
                   ChkBxImprimirPorFechas.Checked := True;
                   Chequear_ImpresionPorFechas;
                   edtFechaInicial.setfocus;
               {end
               else
                  FAnomalias.PonAnotacion (TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Error con lo que hay almacenado en ULTIMOID de TVARIOS');}
           end;
       end
       else
       begin
           // si no hay nada => se introduce el nº inspección
           ChkBxImprimirPorFechas.Checked := False;
           Chequear_ImpresionPorFechas;
           //ChkBxImprimirPorFechas.setfocus;
       end;
       Result := True;
    except
         on E:Exception do
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,5,FICHERO_ACTUAL,'Error en Cargar_Fechas_Informes: ' + E.Message);
    end;
end;

function TFrmInformesDiferidos.Guardar_ProximaFechaInforme (sCadena: string): boolean;
{ Devuelve True si ha logrado guardar sCadena en el campo ULTIMOID de la tabla TVARIOS }
begin
    {$IFDEF TRAZAS}
       FTrazas.PonAnotacion (TRAZA_FLUJO, 16, FICHERO_ACTUAL, 'Entrada en Guardar_ProximaFechaInforme');
    {$ENDIF}
    Result := False;
    try
       with qryConsultas do
       begin
           Close;
           Sql.Clear;
           Sql.Add (Format ('UPDATE TVARIOS SET ULTIMOID=''%s''',[sCadena]));
           {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 18, FICHERO_ACTUAL, qryConsultas);
           {$ENDIF}
           ExecSQL;
           Application.ProcessMessages;
       end;
       Result := True;
       {$IFDEF TRAZAS}
          FTrazas.PonAnotacion (TRAZA_FLUJO, 17, FICHERO_ACTUAL, 'Salida de Guardar_ProximaFechaInforme');
       {$ENDIF}
    except
         on E:Exception do
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,7,FICHERO_ACTUAL, 'Error en Guardar_ProximaFechaInforme: ' + E.Message);
    end;
end;


function TFrmInformesDiferidos.ObtenerUltimoCodigoInspeccion_TINSPECCION (var iEjer, iCod: integer): boolean;
begin
    Result := False;
    try
       with qryConsultas do
       begin
           Close;
           Sql.Clear;
           Sql.Add ('SELECT EJERCICI,CODINSPE FROM TINSPECCION ORDER BY EJERCICI,CODINSPE desc');
           {$IFDEF TRAZAS}
              FTrazas.PonComponente (TRAZA_SQL, 19, FICHERO_ACTUAL, qryConsultas);
           {$ENDIF}
           Open;
           iEjer := FieldByName ('EJERCICI').AsInteger;
           iCod := FieldByName ('CODINSPE').AsInteger;
           {$IFDEF TRAZAS}
              FTrazas.PonRegistro (TRAZA_REGISTRO, 20, FICHERO_ACTUAL, qryConsultas);
           {$ENDIF}
       end;
       Result := True;
    except
        on E:Exception do
           FAnomalias.PonAnotacion (TRAZA_SIEMPRE,8,FICHERO_ACTUAL,'Error en ObtenerUltimoCodigoInspeccion_TINSPECCION: ' + E.Message);
    end;
end;

procedure TfrmInformesDiferidos.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    qryConsultas.Close;
end;

function TfrmInformesDiferidos.EsZonaCorrecta_NumeroInspeccion (sNumInsp: string): boolean;
{ Dado un nº con el formato: 96 00020003123456 devuelve true si 0002 coincide
  con el nº de zona }
var
   iZona_Auxi: integer;

begin
    Result := False;
    try
       iZona_Auxi := StrToInt(Copy (sNumInsp, 4, 4));
       //Result := (iZona_Auxi = DatosVarios.dEstacion.Zona);
       Result := (iZona_Auxi = fVarios.Zona);
    except
         on E:Exception do
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,12,FICHERO_ACTUAL,'Error en Es_ZonaCorrecta_NumeroInspeccion: ' + E.Message);
    end;
end;

function TfrmInformesDiferidos.EsEstacionCorrecta_NumeroInspeccion (sNumInsp: string): boolean;
{ Dado un nº con el formato: 96 00020003123456 devuelve true si 0003 coincide
  con el nº de estación }
var
   iZona_Auxi: integer;

begin
    Result := False;
    try
       iZona_Auxi := StrToInt(Copy (sNumInsp, 8, 4));
       Result := (iZona_Auxi = fVarios.CodeEstacion);
    except
         on E:Exception do
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,14,FICHERO_ACTUAL,'Error en Es_EstacionCorrecta_NumeroInspeccion: ' + E.Message);
    end;
end;


procedure TfrmInformesDiferidos.edtFechaInicialEnter(Sender: TObject);
begin
    DestacarControl (Sender, clGreen, clWhite, False);
end;

procedure TfrmInformesDiferidos.edtFechaInicialExit(Sender: TObject);
begin
    AtenuarControl (Sender, False);
end;


// Devuelve True si ha logrado enviar un trabajo correctamente al servidor de impresión
function TfrmInformesDiferidos.EnviarTrabajo_ServidorImpresion (const sEjer, sCodInsp, sMatr: string; const aTrabajo: tTrabajo): boolean;
var
  dCabecera: tCabecera;

begin
    try
       with dCabecera do
       begin
           iEjercicio := StrToInt(sEjer);
           iCodigoInspeccion := StrToInt(sCodInsp);
           sMatricula := sMatr;
           Result := TrabajoEnviadoOk (dCabecera, aTrabajo);
          end;
    except
        on E:Exception do
        begin
            Result := False;
            raise Exception.Create ('Error enviando un trabajo al servidor de impresión por: ' + E.Message);
        end;
    end;
end;

procedure TfrmInformesDiferidos.edtInformeInicialExit(Sender: TObject);
begin
    TEdit(Sender).Text := Trim (TEdit(Sender).Text);
end;

procedure TfrmInformesDiferidos.FormShow(Sender: TObject);
begin
    if edtFechaInicial.Enabled then
       edtFechaInicial.SetFocus
    else
       edtInformeInicial.Setfocus
end;

end.
