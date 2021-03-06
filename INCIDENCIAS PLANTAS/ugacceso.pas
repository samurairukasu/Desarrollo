unit UGAcceso;

interface

    uses
        Windows,
        Messages,
        SysUtils,
        Classes,
        Controls,
        DB,
        ACCESO;


    const
         { Estas constantes deben coincider con el tag, de los botones, y
         con el orden de insercion en la tabla de servicios }
       AMOVILES : Array [1..6] of String = ('23','24','25','65','66','73');

       ID_SERVICIO_ACCESO = 1;         // Acceso al programa
       ID_SERVICIO_ALTAS = 2;          // Altas de Clientes
       ID_SERVICIO_INSP_FIN = 3;       // Finalizacion de Inspecciones
       ID_SERVICIO_ENVIAR_INFO = 4;    // Envio de informaci�n diaria a central
       ID_SERVICIO_CONTROL_DIARIO = ID_SERVICIO_ENVIAR_INFO;
       ID_SERVICIO_RECIBIR_INFO = 5;
       ID_SERVICIO_CONTROL_COM = 6;
       ID_SERVICIO_BACKUP_TOTAL = 7;
       ID_SERVICIO_BACKUP_INCREMENTAL = 8;
       ID_SERVICIO_CONTROL_BACKUP = 9;
       ID_SERVICIO_FACTURAS = 10;
       ID_SERVICIO_CERTIFICADOS = 11;
       ID_SERVICIO_INFORMES_RI = 12;
       ID_SERVICIO_ARQUEO_X_DESCUENTOS = 13;
       ID_SERVICIO_ARQUEO_CAJA_GASTOS = 14;
       ID_SERVICIO_NOTA_CREDITO = 15;
       ID_SERVICIO_MANT_INSPECTORES = 16;
       ID_SERVICIO_MANT_DATOS = 17;
       ID_SERVICIO_MANT_TTP = 18;
       ID_SERVICIO_MANT_CLIENTES = 19;
       ID_SERVICIO_MANT_TIEMPOS = 20;
       ID_SERVICIO_MANT_INCID = 21;
       ID_SERVICIO_CONV_BD = 22;
       ID_SERVICIO_MANT_DEFECTOS = 23;
       ID_SERVICIO_MANT_VALLIM = 24;
       ID_SERVICIO_MANT_VEHICULOS = 25;
       ID_SERVICIO_LIBROIVA_VENTAS = 26;
       ID_SERVICIO_ARQUEO_CAJA_INGRESOS = 27;
       ID_SERVICIO_ARQUEO_CAJA_EGRESOS = 28;
       ID_SERVICIO_ARQUEO_CAJA_CIERRE = 29;
       ID_SERVICIO_ARQUEO_CAJA_EXTENDIDO_AMBOS = ID_SERVICIO_ARQUEO_CAJA_INGRESOS;
       ID_SERVICIO_ARQUEO_CAJA_EXTENDIDO_CONTADO = ID_SERVICIO_ARQUEO_CAJA_EGRESOS;
       ID_SERVICIO_ARQUEO_CAJA_EXTENDIDO_CREDITO = ID_SERVICIO_ARQUEO_CAJA_CIERRE;
       ID_SERVICIO_CARGAHISTORICOS = 30;
       ID_SERVICIO_GENERACIONHISTORICOS = 31;
       ID_SERVICIO_CARGADATOSLOCALES = 32;
       ID_SERVICIO_ELIMINACIONDATOS = 33;
       ID_SERVICIO_CORTESIA_VENCIMIENTO = 34;
       ID_SERVICIO_MANT_DATOS_FACTURACION = 35;
       ID_SERVICIO_MANT_DATOS_AUTOMATICOS = 36;
       ID_SERVICIO_MANT_DATOS_GESTION_INSPECCIONES = 37;
       ID_SERVICIO_LISTADO_CHEQUES = 38;
       ID_SERVICIO_ARQUEO_CAJA_TIPO_CLIENTES = 39;
       ID_SERVICIO_INFORMES_HV = 40;
       ID_SERVICIO_MANT_TIPO_CLIENTES = 41;
       ID_SERVICIO_MANT_PTO_VENTA = 42;
       ID_SERVICIO_CIERRE_Z = 43;
       ID_SERVICIO_ABM_CAJA = 44;
       ID_SERVICIO_ABM_TARJETA = 45;
       ID_SERVICIO_ARQUEO_CAJA_EXTENDIDO_TARJETA = 46;
       ID_SERVICIO_AUTORIZACION_CUENTA_CORRIENTE = 47;
       ID_SERVICIO_ABM_DESCUENTOS = 48;
       ID_SERVICIO_ARQUEO_CAJA_EXTENDIDO_CHEQUE = 49;
       ID_SERVICIO_LISTADO_SOCIOS_ACA = 50;
       ID_SERVICIO_ENCUESTA_SATISFACCION = 51;
       ID_SERVICIO_LIQUIDACION_IVA = 52;
       ID_SERVICIO_ESTADISTICAS_ENCUESTA = 53;
       ID_SERVICIO_CANTIDAD_DESCUENTOS = 54;
       ID_SERVICIO_CAMBIO_FECHA = 55;
       ID_SERVICIO_MED_INSPECCION = 56;
       ID_SERVICIO_RESUMEN_MEDICIONES = 57;
       ID_SERVICIO_REGISTRO_OBLEAS_INUT = 58;
       ID_SERVICIO_REGISTRO_OBLEAS_ANUL = 59;
       ID_SERVICIO_IMPRIME_OBLEAS_INUT = 60;
       ID_SERVICIO_IMPRIME_OBLEAS_ANUL = 61;
       ID_SERVICIO_EXPORTA_ENTE = 62;
       ID_SERVICIO_EXPORTA_ESPANA = 63;
       ID_SERVICIO_EXPORTA_ENTEOBLEAS = 64;
       ID_SERVICIO_EXPORTA_ANEXOS = 65;
       ID_SERVICIO_LISTADO_CAMBIO_FECHA = 66;
       ID_SERVICIO_CAMBIO_PLANTA = 67;
       ID_SERVICIO_TOTALES_CAJA = 68;
       ID_SERVICIO_TOTALES_TARJETAS = 69;
       ID_SERVICIO_LISTADO_MARCAS = 70;
       ID_SERVICIO_INSPECCION_GNC = 71;
       ID_SERVICIO_INSP_FIN_GNC = 72;
       ID_SERVICIO_FACTURACION_GNC = 73;
       ID_SERVICIO_ARQUEO_CAJA_GNC_AMBOS = 74;
       ID_SERVICIO_ARQUEO_CAJA_GNC_CHEQUE = 75;
       ID_SERVICIO_ARQUEO_CAJA_GNC_CONTADO = 76;
       ID_SERVICIO_ARQUEO_CAJA_GNC_TARJETA = 77;
       ID_SERVICIO_ARQUEO_CAJA_GNC_CCORRIENTE = 78;
       ID_SERVICIO_INFORMES_RI_GNC = 79;
       ID_SERVICIO_TOTALES_TARJETAS_GNC = 80;
       ID_SERVICIO_RESUMEN_DESCUENTOS_GNC = 81;
       ID_SERVICIO_CONTROL_DIARIO_GNC = 82;
       ID_SERVICIO_LISTADO_CILI_REGU = 83;
       ID_SERVICIO_INFORME_DEFECTOS = 84;
       ID_SERVICIO_LISTADO_VEH_OFICIAL = 85;
       ID_SERVICIO_LISTADO_CAMBIO_ZONA = 86;
       ID_SERVICIO_PROVINCIA_SEGUROS_CONS = 87;
       ID_SERVICIO_PROVINCIA_SEGUROS_IMP = 88;
       ID_SERVICIO_EXPORTA_GNC = 89;
       ID_SERVICIO_ANULA_OBLEA_GNC = 90;
       ID_SERVICIO_EXPORT_ANULA_OBLEA_GNC = 91;
       ID_SERVICIO_IMPRIME_OBLEAS_ANUL_GNC = 92;
       ID_SERVICIO_DEC_JURADAS = 93;
       ID_SERVICIO_ESTADO_VTV = 94;
       ID_SERVICIO_EXPORTA_PROVINCIA = 95;
       ID_SERVICIO_LIQUIDACION_DIARIA = 96;
       ID_SERVICIO_SOCIOS_ACA = 97;
       ID_SERVICIO_CAMBIO_FECHA_GNC = 98;
       ID_SERVICIO_REIMP_REEMPLAZO_OBLEAS = 99;
       ID_SERVICIO_REIMP_DEC_JURADA = 100;
       ID_SERVICIO_RESUMEN_MEDICIONES_INC = 101;
       ID_SERVICIO_LISTADO_CLIENTES_CUIT = 102;
       ID_SERVICIO_AUTORIZA_VIGENTE = 103;
       ID_SERVICIO_INFORMES_REVERIFICACIONES = 104;
       ID_SERVICIO_REGISTRO_OBLEAS_NC = 105;
       ID_SERVICIO_ALTA_OBLEAS = 106;
       ID_SERVICIO_REGISTRO_OBLEAS_BLOQUEADAS = 107;
       ID_SERVICIO_EJECUTAR_PAQUETES = 108;
       ID_SERVICIO_INFORMES_TIEMPOS=109;
    var
        GestorSeg : TGestorSeg = NIL;
        ApplicationUser : integer;
        PasswordUser : string;

    function PermitidoAcceso (var iIDUsuario: integer; var sClaveUsuario: string; GestorSeg: TGestorSeg; aCaption: string;inicio: Boolean; Permitir: String): boolean;

 //   function PermitidoAccesoCambios (var iIDUsuario: integer; var sClaveUsuario: string; GestorSeg: TGestorSeg): boolean;  //

    function AccederAServicio(IDS: Integer; iIDUsuario: integer; sClaveUsuario: string; GestorSeg: TGestorSeg) : Boolean;

    implementation

    uses
        Forms,
        UCDIALGS,
        ULOGS,
        PASSWORD,
        UfUsuarioCambios,GLOBALS;
        
    const
        FILE_NAME = 'UGAcceso';
        MAX_NUM_INTENTOS = 3;
        ACCESO = 'ACCESO';
        CAMBIO = 'CAMBIO';


function PermitidoAcceso (var iIDUsuario: integer; var sClaveUsuario: string; GestorSeg: TGestorSeg; aCaption: string;
                          inicio: Boolean; Permitir: String): boolean;
var
iIntentos : integer;
bCorrecto, Resultado : boolean;
NombreUsuario: String;
begin
bCorrecto := False;
  Try
    iIntentos := 0;
      repeat
        Application.ProcessMessages;
        with  TFrmPassword.Create(Application) do
          try
            if aCaption <> '' then
              Caption := aCaption
            else
              Caption := 'Acceso al Programa';
          if ShowModal <> IDOK then
            begin
              bCorrecto := False;
              if Assigned(fAnomalias) then
                fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME, 'No consigui� acceder al programa en el intento: %d, cancelo el acceso.',[iIntentos]);
              iIntentos := MAX_NUM_INTENTOS;
            end
          else
            begin

              NombreUsuario := EdtNombreUsuario.Text;
              GLOBALS.USUARIO_CONECTADO:=NombreUsuario;
              iIDUsuario := GestorSeg.ObtenerIDUsuario(NombreUsuario);
              sClaveUsuario := EdtPassword.Text;

              if Permitir = 'ACCESO' then
                Resultado:=GestorSeg.ComprobarClaveUsuario(iIDUsuario, sClaveUSuario);
              if Permitir = 'CAMBIO' then
                Resultado:=GestorSeg.ComprobarClaveCambios(iIDUsuario, sClaveUSuario);

              if Resultado then
                begin
                  If Inicio then
                    Begin
                      if GestorSeg.LoginUser(NombreUsuario) then
                        bCorrecto := True
                      else
                        inc(iIntentos);
                    end
                  else
                    Begin
                      bCorrecto := True;
                    end;
                  {$IFDEF TRAZAS}
                  if Assigned(fTrazas) then
                    fTrazas.PonAnotacionFmt (TRAZA_SIEMPRE, 2, FILE_NAME, '%S: accede al programa con clave correcta', [NombreUsuario]);
                  {$ENDIF}
                end
              else
                begin
                  bCorrecto := False;
                  Showmessage('Gesti�n de Acceso', 'La palabra clave introducida es incorrecta');
                  if Assigned(fAnomalias) then
                    fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'El usuario %s, no conoce la clave, y lleva %d intentos (s)',[NombreUsuario,iIntentos]);
                  inc(iIntentos);
                end;
            end;
          finally
            Free;
          end
      until (bCorrecto) or (iIntentos = MAX_NUM_INTENTOS);
  finally
    if not bCorrecto then
      sClaveUsuario := '';
    result := bCorrecto;
  end;
end;


{function PermitidoAccesoCambios (var iIDUsuario: integer; var sClaveUsuario: string; GestorSeg: TGestorSeg): boolean;
var
iIntentos : integer;
bCorrecto : boolean;
NombreUsuario: String;
begin
bCorrecto := False;
  try
    iIntentos := 0;
      repeat
        with  TfrmUsuarioCambios.Create(Application) do
          try
            Caption := 'Acceso a Cambios de Fecha';
            if ShowModal <> IDOK then
              begin
                bCorrecto := False;
                if Assigned(fAnomalias) then
                  fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME, 'No consigui� acceder al programa en el intento: %d, cancelo el acceso.',[iIntentos]);
                  iIntentos := MAX_NUM_INTENTOS;
              end
            else
              begin
                NombreUsuario := EdtNombreUsuario.Text;
                iIDUsuario := GestorSeg.ObtenerIDUsuario(NombreUsuario);
                sClaveUsuario := EdtPassword.Text;
                if GestorSeg.ComprobarClaveCambios(iIDUsuario, sClaveUSuario) then
                  begin
                    if GestorSeg.LoginUser(NombreUsuario) then
                      bCorrecto := True
                    else
                      inc(iIntentos);
                    {$IFDEF TRAZAS}
{                    if Assigned(fTrazas) then
                      fTrazas.PonAnotacionFmt (TRAZA_SIEMPRE, 2, FILE_NAME, '%S: accede a cambio de datos con clave correcta', [NombreUsuario]);
                    {$ENDIF}
{                  end
                else
                  begin
                    bCorrecto := False;
                    Showmessage('Gesti�n de Acceso', 'La palabra clave introducida es incorrecta');
                    if Assigned(fAnomalias) then
                      fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'El usuario %s, no conoce la clave para cambios, y lleva %d intentos (s)',[NombreUsuario,iIntentos]);
                    inc(iIntentos);
                  end;
              end;
          finally
            Free;
          end
      until (bCorrecto) or (iIntentos = MAX_NUM_INTENTOS);
    finally
        if not bCorrecto
        then sClaveUsuario := '';
        result := bCorrecto;
    end;
end;
}

    function AccederAServicio(IDS: Integer; iIDUsuario: integer; sClaveUsuario: string; GestorSeg: TGestorSeg) : Boolean;
    begin
        if GestorSeg.AccesoServicio(IDS,iIDUsuario,sClaveUsuario)
        then begin
            Result := True;
            {$IFDEF TRAZAS}
            if Assigned(fTrazas)
            then fTrazas.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME, 'USUARIO %d ACCEDE AL SERVICIO %d CORRECTAMENTE',[iIdUsuario,IDS]);
            {$ENDIF}
        end
        else begin
            Result := False;
            ShowMessage('Gesti�n de Acceso','Acceso a servicio denegado');
            if Assigned (fAnomalias)
            then FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME, 'USUARIO %d NO ACCEDE AL SERVICIO %d', [iIdUsuario,IDS]);
        end;
    end;

    initialization

    finalization

        if Assigned(GestorSeg)
        then GestorSeg.Free;

end.
