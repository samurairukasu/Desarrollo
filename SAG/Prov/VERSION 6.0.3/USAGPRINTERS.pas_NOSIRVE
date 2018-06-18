unit USAGPrinters;

interface

    uses
        Printers,
        QrPrntr,
        UBinResource;

    const
       MAXIMO_NUMERO_IMPRESORAS_EN_PAMPA = 7;
       MAXIMO_NUMERO_DE_IMPRESORAS_EN_SISTEMA = 20;

      { INDICES FIJOS DE LAS IMPRESORAS DE PAMPA  }
        IMPRESORA_PARA_FACTURAS_A = 1;
        IMPRESORA_PARA_FACTURAS_B = 2;
        IMPRESORA_PARA_INFORMES = 3;
        IMPRESORA_PARA_CERTIFICADOS = 4;
        IMPRESORA_PARA_MEDICIONES = 5;
        IMPRESORA_PARA_TAMARILLA = 6;
        IMPRESORA_PARA_INFORMESGNC = 7;

//        C_REGISTRO : ARRAY [1..MAXIMO_NUMERO_IMPRESORAS_EN_PAMPA] of string = ('A','B','I','C');
        C_REGISTRO : ARRAY [1..MAXIMO_NUMERO_IMPRESORAS_EN_PAMPA] of string = ('A','B','I','C','M','T','G');

    type


        tContexto = record
            sNombre : string;
            iCopiasDiferidas, iCopiasDirectas,
            iMargenIzquierdo, iMargenSuperior : integer;
            qrbBandeja : TQRBin;
            qrpPapel : TQRPaperSize;
            qroOrientacion : tPrinterOrientation;
        end;

        PTContexto = ^tContexto;
        tContextos = array[1..MAXIMO_NUMERO_IMPRESORAS_EN_PAMPA] of TContexto;
        TPaperBinsSupported = array[First..Last] of boolean;
        tNumeroOcupaciones = array [0..MAXIMO_NUMERO_DE_IMPRESORAS_EN_SISTEMA, First..Last] of integer; { HACE REFERENCIA AL NUMERO DE OCUPACIONES POR CADA IMPRESORAS FISICA DEL SISTEMA, 0 por el primer indice de una lista }


      TImpresora = class
         driver, device, port: Pchar
      end;

      tEstadosHandle =  ( HDesconocido {0}, HEsperando_xx_Atencion {1},
                          HEsperando_xx_Papel {2}, HPreparado {3},  HImprimiendose {4},
                          HTerminado {5}, HCancelado {6},
                          HDesaparecido {n-1}, HBloqueado {n} );

      tTrabajo = ( Nulo, Certificado , Informe, tFactura_A, tFactura_B, Nota_A, Nota_B, InformeDiferido, NCDescuento_A, NCDescuento_B, Medicion, tAmarilla, InformeGNC, Factura_A_GNC, Factura_B_GNC, Nota_A_GNC, Nota_B_GNC); 

      tSolicitud = record
        iHandle : integer;
        iSolicitud : tTrabajo;
      end;

      tCabecera = record
        iCodigoInspeccion : integer;
        iEjercicio : integer;
        sMatricula : string;
      end;

      tPeticionDeServicio = record
        dCabecera : tCabecera;
        iServicio : tTrabajo;
      end;

      tPaqueteDeSolicitud = record
        iHandle : integer;
        dPeticion : tPeticionDeServicio;
      end;

      {$IFDEF SIMPRESION}

      TImpresorasPampa = class;
      tImpresoras = array[1..MAXIMO_NUMERO_IMPRESORAS_EN_PAMPA] of TImpresorasPampa;

      TImpresorasPampa = class
      private
        fContexto : tContexto;
        fDefecto : boolean;
      public
        constructor Create (const UnContexto : tContexto);
        function CambiaContexto (const UnContexto : tContexto) : boolean;
        function GetImpresora : integer;
      public
        property Impresora : integer      read GetImpresora;
        property Defecto : boolean        read fDefecto;
        property MargenSuperior: integer  read fContexto.iMargenSuperior;
        property MargenIzquierdo: integer read fContexto.iMargenIzquierdo;
        property CopiasDirectas : integer read fContexto.iCopiasDirectas;
        property CopiasDiferido : integer read fContexto.iCopiasDiferidas;

        {Mirar estas dos propiedades}
        property Bandeja : TQRBin         read fContexto.qrbBAndeja;
        property Papel   : TQRPaperSize   read fContexto.qrpPapel;
        property Nombre : string          read fContexto.sNombre;
        property Orientacion : tPrinterOrientation read fContexto.qroOrientacion;
        property Contexto : tContexto     read fContexto;
     end;

    procedure TestOfContextos;
    procedure TestCreadasImpresoras;
    procedure TestOcupacionesPorImpresoraOk;
    function NecesitaCambioDePapel (UnaImpresora: tImpresorasPampa) : boolean;
    function BandejaPorNombre (const s : string) : TQrBin;

    var
        ContextosImpresoras : tContextos;
        ImpresorasEnPampa : tImpresoras;
        OcupacionesImpresora : tNumeroOcupaciones;

{$ENDIF}

implementation
{$IFDEF SIMPRESION}
    uses
        Forms,
        Windows,
        SysUtils,
        ULOGS,
        UVERSION,
        UCDIALGS,
        USUPERREGISTRY,
        TypInfo;

    Const
        FILE_NAME = 'USAGPrinters.PAS';


    procedure InitError(Msg: String);
    begin
        MessageDlg('Error en la Inicialización',Msg,mtError,[mbOK],mbOK,0);
        if Assigned(fAnomalias)
        then fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FILE_NAME,Msg);
        InitializationError := TRUE;
        Application.Terminate;
    end;





function MargenIzqPorDefecto(const h: THandle) : integer;
var
  m, tm, rn : Integer;
begin
   m := GetDeviceCaps(h,PHYSICALOFFSETX);
   tm := GetDeviceCaps(h,VERTSIZE);
   rn := GetDeviceCaps(h,VERTRES);
   result := Round((m * tm) / rn);
end;

function MargenSupPorDefecto(const h: THandle) : integer;
var
  m, tm, rn : Integer;
begin
  m := GetDeviceCaps(h,PHYSICALOFFSETY);
  tm := GetDeviceCaps(h,HORZSIZE);
  rn := GetDeviceCaps(h,HORZRES);
  result := Round((m * tm) / rn);
end;



function BandejaPorNombre (const s : string) : TQrBin;
var
ipb : TQrBin;
begin
result := FIRST;
for ipb := First to Last do
if SBandejas[ipb] = s then
  begin
    result := ipb;
    break;
  end;
end;



// Carga los contextos de impresión del registro
procedure TestOfContextos;
var
sImpresora : string;
i : integer;
begin
sImpresora := '';
with TSuperRegistry.Create do
  try
    RootKey := HKEY_LOCAL_MACHINE;
      try
        for i := low(ContextosImpresoras) to high(ContextosImpresoras) do
          begin
            if not OpenKeyRead(PRINTER_KEY+'\'+C_REGISTRO[i]) then
              InitError('No se encontraron los parámetros de la impresora');
              with ContextosImpresoras[i] do
                begin
                  iCopiasDirectas := ReadInteger(DIRECTAS_VALUE);
                  iCopiasDiferidas := ReadInteger(DIFERIDAS_VALUE);
                  iMargenSuperior := ReadInteger(SUPERIOR_VALUE);
                  iMargenIzquierdo := ReadInteger(IZQUIERDO_VALUE);
                  sNombre := ReadString(NAME_VALUE);
                  qrbBandeja := BandejaPorNombre(ReadString(BANDEJA_VALUE));
                  case I of
                    IMPRESORA_PARA_FACTURAS_A,
                    IMPRESORA_PARA_FACTURAS_B:
                      begin
                        qrpPapel := Letter;
                        iCopiasDiferidas := 0;
                        qroOrientacion := poPortrait;
                      end;

                    IMPRESORA_PARA_INFORMES:
                      begin
                        qrpPapel := A4;
                      end;

                    IMPRESORA_PARA_CERTIFICADOS:
                      begin
                        qrpPapel := C5; {Tiene que ser C5}
                        qroOrientacion := poLandsCape;
                        iCopiasDiferidas := 0
                      end;

                    IMPRESORA_PARA_MEDICIONES:        // MEDI
                      begin
                        qrpPapel := A4;
                      end;

                    IMPRESORA_PARA_TAMARILLA:        // MEDI
                      begin
                        qrpPapel := C5;
                      end;

                    IMPRESORA_PARA_INFORMESGNC:        // MEDI
                      begin
                        qrpPapel := A4;
                      end;
                  end;
                end;
          end;
      except
        on E: exception do
          InitError(Format('No se leyeron correctamente los parametros por: %S', [E.message]));
        end;
  finally
    Free;
  end;
end;


procedure TestCreadasImpresoras;
var
i : Integer;
begin
  try
  for I := low(ImpresorasEnPampa) to high(ImpresorasEnPampa) do
    impresorasEnPampa[i] := TImpresorasPampa.Create(ContextosImpresoras[i]);
  except
    on E : Exception do
      begin
        InitError(Format('No se crearon las impresoras correctamente por: %S', [E.message]));
      end;
  end;
end;


procedure TestOcupacionesPorImpresoraOk;
{ HAY X OBJETOS DE IMPRESORA, UNO POR CADA TIPO DE PAPEL,
  CADA X OBJETO DE IMPRESORA ESTA ASOCIADO A UNA IMPRESORA DEL SISTEMA DISTINTA O NO DEL ANTERIOR OBJETO
  POR TANTO UNA IMPRESORA EN EL SISTEMA PUEDE TENER COMO MINIMO O PAPELES DISTINTOS Y
  COMO MAXIMO X OBJETOS DE IMPRESORA }
var
i : integer;
ib : TQrBin;
begin
for i := 0 to MAXIMO_NUMERO_DE_IMPRESORAS_EN_SISTEMA do
  for ib := First to Last do
    OcupacionesImpresora[i,ib] := 0;
    try
    { SE INCREMENTA EL INDICE DE LA IMPRESORA DEL SISTEMA QUE TIENE ASIGNADA OCUPACION }
    for i:= low(ImpresorasEnPampa) to high(ImpresorasEnPampa) do
      inc(OcupacionesImpresora[ImpresorasEnPampa[i].Impresora, ImpresorasEnPampa[i].Bandeja]);
                                         {Impresora i de pampa}        {Indice en el sistema}
    except
      on E: Exception do
      InitError(Format('No se leyeron correctamente numero de ocupaciones por impresora:  %S', [E.message]));
    end;
end;


function ContextoCorrecto (const UnContexto : tContexto) : boolean;
var
I : Integer;
begin
with TPrinter.Create do
  try
    I := Printers.IndexOf(UnContexto.sNombre);
  finally
    Free;
  end;
with UnContexto do
  try
    if I >= 0 then
      begin
        Printer.PrinterIndex := I;
        if qrbBAndeja in UBinResource.fOutPutBin(I) then
          if QrPrinter.PaperSizeSupported[qrpPapel] then
            result := True
          else
            raise Exception.Createfmt('<SIMPR>.002, Papel %s no disponible en Impresora',[SPapeles[qrpPapel]])
       else
        raise Exception.Createfmt('<SIMPR>.001, Bandeja %s no disponible en Impresora', [Sbandejas[qrbBandeja]])
      end
    else
      raise Exception.Create('<SIMPR>.000, Impresora no disponible');
  except
    on E : Exception do
      begin
        result := False;
        if fAnomalias <> nil then
          fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error al comprobar el contexto de impresión de %s por %s',[UnContexto.sNombre,E.message]);
       end;
  end;
end;



function ContextoPorDefecto : tContexto;
var
  pDevice, pDriver, pPort : PChar;
  aDevice : tHandle;
 // ib : TQRBin;
 // ip : TQRPaperSize;
 // CBins : Set Of TQRBin;
 // CSizes : Set Of TQRPaperSize;
begin
pDevice := nil;
pDriver:= nil;
pPort := nil;
with TPrinter.Create do
  try
    try
      PrinterIndex := -1; {si falla produce una excepcion conforme no hay impresora}
    except
      on E : Exception do
        raise Exception.CreateFmt('<SIMPR>.003a No hay impresoras en el sistema: %s', [E.message])
    end;

    GetMem(pDevice, 255);
    GetMem(pDriver, 255);
    GetMem(pPort, 255);
    GetPrinter(pDevice, pDriver, pPort, aDevice);
    if aDevice <= 0 then
      raise Exception.Create('<SIMPR>.003 No hay impresoras en el sistema.')
    else
      with result do
        begin
          if (pPort = nil) or (Length(pPort)=0) then
            sNombre := format('%s',[pDevice])
          else
            sNombre := format('%s on %s',[pDevice, pPort]);
           iCopiasDiferidas := 0;
           iCopiasDirectas  := 1;
           try
             iMargenIzquierdo := MargenIzqPorDefecto(Handle);
             iMargenSuperior  := MargenSupPorDefecto(Handle);
           except
             on E : Exception do
             begin
               raise Exception.CreateFmt('<SIMPR>.003b %s No es valida como impresora, No hay impresoras en el sistema: %s', [pDevice, E.message])
             end;
           end;
           qrbBandeja := QRPrinter.OutPutBin;
           qrpPapel := QRPrinter.PaperSize;
           qroOrientacion :=  poPorTrait;
         end;
  finally
    Free;
    FreeMem(pDevice);
    FreeMem(PDriver);
    FreeMem(pPort);
  end;
end;


function TImpresorasPampa.GetImpresora: Integer;
{
 Devuelve el índice de la impresora con el nombre indicado,
 si no existe devuelve una excepcion, diciendo que la impresora con
 ese nombre ha desaparecido;
}
var
I : integer;
begin
result := -2;
with TPrinter.Create do
  try
    I := Printers.IndexOf(fContexto.sNombre);
    if i >= 0  then
      result := I
    else
      raise Exception.CreateFmt('<SIMPR>.006, La impresora %s ha desaparecido del sistema',[fContexto.sNombre])
  finally
    free;
  end;
end;


constructor TImpresorasPampa.Create (const UnContexto : tContexto);
{
  Crea Un Objeto ImpresoraPampa, que encapsula, un miembro Impresora,
  asignandole un nombre, un numero de copias y un fichero de anotaciones
}
begin
{$B-}
inherited Create;
  fDefecto := False;
  if ContextoCorrecto(UnContexto) then
    fContexto := UnContexto
  else
    begin
      fContexto := ContextoPorDefecto;
      fDefecto := True;
      if Assigned(fIncidencias) then
        fIncidencias.PonAnotacionFmt(TRAZA_SIEMPRE,1, FILE_NAME, 'Se asigna la impresora por defecto con la bandeja y el papel, que es la del equipo',[fContexto.sNombre] {,sBandejas[fContexto.qrbBandeja], sPapeles[fContexto.qrpPapel]]});
    end;
end;

{ ************************************************************************** }

function TImpresorasPampa.CambiaContexto (const UnContexto : tContexto) : boolean;
begin
result := True;
if ContextoCorrecto(UnContexto) then
  fContexto := UnContexto
else
  raise Exception.Createfmt('<SIMPR>.007 Contexto selecionado para  %s no es valido', [UnContexto.sNombre]);
end;

{ ************************************************************************** }

function PapelPorNombre (const s : string) : TQrPaperSize;
var
  ipp : TQrPaperSize;
begin
  result := A4;
  for ipp := A4 to Esheet do
    if UpperCase(GetEnumName(TypeInfo(TQRPaperSize), ord(ipp))) = UpperCase(s)
    then begin
        result := ipp;
        break;
    end;
end;


function NecesitaCambioDePapel (UnaImpresora: tImpresorasPampa) : boolean;
{ Indica si una impresora necesita o no cambiar de papel dependiendo de sus
  ocupaciones. Las ocupaciones son calcualadas al inicicializarse el programa
  y cada vez que se reconfiguran las impresoras.

¿ Necesita cambio de papel una impresora del sistema, tomada por pampa
  para imprimir ? }
const
  UNICO = 1;
var
vOcup: Integer;
begin
//result := OcupacionesImpresora[UnaImpresora.Impresora, UnaImpresora.Bandeja] <= UNICO; //Cambia x <= estaba >=
vOcup:=0;
Result:=true;
vOcup:= OcupacionesImpresora[UnaImpresora.Impresora, UnaImpresora.Bandeja];
if vOcup <= UNICO then
  Result:=false;
end;

{$ENDIF}

end.
