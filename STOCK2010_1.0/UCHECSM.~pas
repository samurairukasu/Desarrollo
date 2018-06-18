unit UChecSm;

interface

uses
  Windows,
  SysUtils,
  ULOGS;

const

  FICHERO_ACTUAL = 'UChecSum.pas';
  MAX_LEN_BUFFER = 128; { Tamaño del buffer de lectura en words}
  ERROR_IO = $FFFFFFFF;
  BYTES_DE_CONTROL = 10; { 2 BYTES PARA EL CHEKSUM Y 8 PARA LA SUMA }
  IS_EJECUTABLE = '.EXE';

  PAR = 0;
  IMPAR = 1;

type

  tWord = ^Word;
  tDouble = ^Double;

  tBuffer = array [1..MAX_LEN_BUFFER] of word; { 256 bytes }

  { Un objeto de este tipo cumple las siguientes propiedades
    - Tamaño par.
    - 5 ultimas palabras son de control 1 de check y 4 de suma
  }


  tFileExePampaProperties = class(tObject)
  private

    fCheckSum : Word;   {2 bytes}
    fSuma     : Double; {8 bytes}

    fControl  : Double; {8 bytes}

    fSize     : DWORD; { Tamaño del fichero en bytes }
    fName     : PChar;

    fSuma_8LB : Double; {8 bytes} {Contenido de los últimos 8 bytes}
    fXor_b8LB : Word;   {2 bytes} {Contenido de los 2 últimos bytes anteriores a los 8 últimos del fichero}

  public

    constructor Create ( const sFileName : string);


    destructor Destroy; override;

  published

    property CheckSum : Word
      read fCheckSum;

    property Suma : Double
      read fSuma;

    property Control : Double
      read fControl;

//    property Nombre : Pchar
//      read fName;

    property Size : DWORD
      read fSize;

  end;

  function DepuradoElFichero (const saFile : string) : boolean;
  function FileFreeOfBugs (const saFile: string) : boolean;

implementation


procedure Error(const sMensaje: string);
begin
  raise Exception.Create(sMensaje);
end;

constructor tFileExePampaProperties.Create
 (
   const sFileName : string
 );

  var
    BytesTratados  : integer;
    Asa, AsaMap : tHandle;
    PFichero : PChar;
  begin

    inherited Create;

      AsaMap       := INVALID_HANDLE_VALUE;
      Asa          := INVALID_HANDLE_VALUE;
      PFichero     := nil;
      fName        := PChar(sFileName);
      fCheckSum    := 0;
      fControl     := 0;
      fSuma        := 0;

    try
      { Inicializacion de variables }



     { COMPROBACION DE QUE EL FICHERO ES EJECUTABLE }
      if not (UpperCase(ExtractFileExt(sFileName)) = IS_EJECUTABLE)
      then Error(Format('Error al Intentar abrir el Fichero %s. No es un ejecutable', [fName]));

     { COMPROBACION DE APERTURA CORRECTA DEL FICHERO}
      Asa := CreateFile(fName, GENERIC_READ, FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
      if Asa = INVALID_HANDLE_VALUE
      then Error(Format('Error (%d) al Intentar abrir el Fichero %s', [GetLastError, fName]));

     { OBTENCION DEL TAMAÑO }
      fSize := GetFileSize (Asa, nil); { Para ficheros mayores de 2 gigas poner la direccion de la palabra alta}

      if (fSize = ERROR_IO)
      then Error(Format('Error (%d) al obtener el tamanio del Fichero %s', [GetLastError, fName]));

      { Todos los ficheros a controlor deben tener un tamaño par }
      if Odd(fSize)
      then Error(Format('Error al Intentar abrir el Fichero %s. No es un ejecutable con paridad', [fName]));

      { Además todos los ficheros pequeños deben ser como minimo igulaes a las palabras
        de control }
      if fSize <= (BYTES_DE_CONTROL)
      then Error(Format('Error al Intentar abrir el Fichero %s. Error de paridad', [fName]));

      { VOLCADO DEL FICHERO EN MEMORIA }
      AsaMap := CreateFileMapping(Asa, nil, PAGE_READONLY, 0, fSize, nil);
//      if AsaMap = NULL
//      then Error(Format('Error al Intentar crear un copia en memoria del Fichero %s por %d.', [fName, GetLastError]));

      PFichero := MapViewOfFile(AsaMap, FILE_MAP_READ, 0, 0, 0);
      if PFichero = nil
      then Error(Format('Error al Intentar crear la vista en memoria del Fichero %s por %d.', [fName, GetLastError]));

      { LECTURA DE LAS PALABRAS DE INFORMACION }

      { El fichero ya tiene un tamaño par y restando las palabras de control
        se puede calcular el numero de lecturas fijas }

      BytesTratados := 0;
      while BytesTratados < (fsize - BYTES_DE_CONTROL) do
      begin
        fCheckSum := fCheckSum xor tWord(@PFichero[BytesTratados])^;
        fSuma    := fSuma + tWord(@PFichero[BytesTratados])^;
        Inc(BytesTratados,SizeOf(fCheckSum));
      end;

      { En este punto es seguro que el puntero está sobre la informacion
        del checksum y suma }

       { 2 bytes before 8 last bytes }
       fXor_b8LB := tWord(@PFichero[BytesTratados])^;
       Inc(BytesTratados,SizeOf(fXor_b8LB));

       { 8 last bytes }
       fSuma_8LB := tDouble(@PFichero[BytesTratados])^;
       Inc(BytesTratados,SizeOf(fSuma_8LB));

       if BytesTratados <> fSize
       then Error(Format('Error no completada la lectura del Fichero %s', [fName]));

       fControl := (fCheckSum + fSuma) - (fXor_b8LB + fSuma_8LB);

       {$B+}
       if (not UnmapViewOfFile(PFichero)) or (not CloseHandle(AsaMap)) or (not (CloseHandle(Asa)))
       then  Error(Format('Error (%d) al Cerrar el Fichero %s', [GetLastError, fName]));

    except
      on E : Exception do
      begin
        fControl := -1;
        UnmapViewOfFile(PFichero);
        CloseHandle(AsaMap);
        CloseHandle(Asa);
        if fAnomalias <> nil then
          fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL,'Error construyendo el objeto FILEPROPERTIES POR: ' + E.message );
      end;
    end;
  end;

destructor  tFileExePampaProperties.destroy;
begin

  inherited destroy;
end;



procedure AniadirControlFinal (const Asa: tHandle; const saFile : string);
var
  fSize, fSizeConControl : Dword; // Tamaño original y con control del fichero
  AsaMap : tHandle;               // Manejador de la vista en memoria
  wCheckSum : Word;               // Checksum del fichero
  dSuma : Double;                 // Suma del fichero
  PFichero : PChar;               // Puntero al fichero en memoria
  BytesTratados : Integer;        // Indice del fichero
begin

//   PFichero := nil;
   wCheckSum := 0;
   dSuma := 0;

 { OBTENCION DEL TAMAÑO }
   fSize := GetFileSize (Asa, nil); { Para ficheros mayores de 2 gigas poner la direccion de la palabra alta}

   if (fSize = ERROR_IO)
   then Error(Format('Error (%d) al obtener el tamanio del Fichero %s', [GetLastError,saFile]));

  { Todos los ficheros a controlor deben tener un tamaño par, incluidos los bytes de control }
   if Odd(fSize)
   then fSizeConControl := fsize + BYTES_DE_CONTROL + 1
   else fSizeConControl := fsize + BYTES_DE_CONTROL;

  { VOLCADO DEL FICHERO EN MEMORIA }
   AsaMap := CreateFileMapping(Asa, nil, PAGE_READWRITE, 0, fSizeConControl, nil);
//   if (AsaMap = NULL) or (AsaMap = 0)
//   then begin
//     CloseHandle(AsaMap);
//     Error(Format('Error al Intentar crear un copia en memoria del Fichero %s por %d.', [saFile,GetLastError]));
//   end;


   PFichero := MapViewOfFile(AsaMap, FILE_MAP_WRITE, 0, 0, 0);
   if not Assigned(PFichero)
   then begin
     CloseHandle(AsaMap);
     Error(Format('Error al Intentar crear la vista en memoria del Fichero %s por %d.', [saFile, GetLastError]));
   end;

   { LECTURA DE LAS PALABRAS DE INFORMACION }

   if Odd(fSize)
   then PFichero[fsize] := '0';

   { El fichero ya tiene un tamaño par y restando las palabras de control
     se puede calcular el numero de lecturas fijas }

   BytesTratados := 0;
   while BytesTratados < (fsize) do
   begin
     wCheckSum := wCheckSum xor tWord(@PFichero[BytesTratados])^;
     dSuma    := dSuma + tWord(@PFichero[BytesTratados])^;
     Inc(BytesTratados,SizeOf(wCheckSum));
   end;

   tWord(@PFichero[BytesTratados])^ := wCheckSum;
   Inc(BytesTratados,SizeOf(wCheckSum));

   tDouble(@PFichero[BytesTratados])^ := dSuma;
   Inc(BytesTratados,SizeOf(dSuma));

   if fSizeConControl <> BytesTratados
   then begin
     UnmapViewOfFile(PFichero);
     CloseHandle(AsaMap);
     Error(format('Error no Tamaño y bytes difiere en el Fichero %s, [''Tamaño'' %d, Bytes %d]',[saFile,fSizeConControl,BytesTratados]));
   end;

   if SetFilePointer(Asa,BytesTratados,nil,FILE_BEGIN) = ERROR_IO
   then begin
     UnmapViewOfFile(PFichero);
     CloseHandle(AsaMap);
     Error(format('Error no completado el posicionamiento a final del Fichero %s',[saFile]));
   end;

   if not SetEndOfFile(Asa)
   then begin
     UnmapViewOfFile(PFichero);
     CloseHandle(AsaMap);
     Error(format('Error no completado la puesta final del Fichero %s',[saFile]));
   end;

   {$B+}
   if not UnmapViewOfFile(PFichero) or not CloseHandle(AsaMap)
   then Error(format('No destruidos los manejadores de la vista del Fichero %s', [saFile]));

 end;

function FileFreeOfBugs (const saFile: string) : boolean;
begin
    with tFileExePampaProperties.Create (sAFile) do
    try
        result := Control = 0
    finally
        Free
    end;
end;



function DepuradoElFichero (const saFile : string) : boolean;
var
  Asa : THandle;
  //DatosDelFichero : TOFStruct;
begin
  Asa := INVALID_HANDLE_VALUE;
  result := True;
  try
    // No lo comparte con nadie;
    Asa := CreateFile(Pchar(saFile), GENERIC_READ OR GENERIC_WRITE, 0, NIL, OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0);
    // Esta linea de abajo es erronea;
    //CreateFile(Pchar(saFile), GENERIC_READ, FILE_SHARE_READ OR FILE_SHARE_WRITE, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
    //Asa := OpenFile(Pchar(saFile), DatosDelFichero, OF_SHARE_EXCLUSIVE + OF_READWRITE); //CreateFile(Pchar(saFile), GENERIC_READ, FILE_SHARE_READ OR FILE_SHARE_WRITE, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
    if Asa = HFILE_ERROR //INVALID_HANDLE_VALUE
    then Error(Format('Error (%d) al Intentar abrir el Fichero %s', [GetLastError, saFile]));

    AniadirControlFinal(Asa, saFile);

    if not CloseHandle(Asa) then
       Error(Format('Error (%d) al Cerrar el Fichero %s', [GetLastError, saFile]));

  except
    on E : Exception do
    begin
      result := False;
      CloseHandle(Asa);
      if fAnomalias <> nil then
        fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'ERROR DEPURANDO EL FICHERO POR: ' + E.message);
    end;
  end;
end;

end.



