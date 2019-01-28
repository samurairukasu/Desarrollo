unit ULogs;

interface

Uses
    Windows,
    Classes,
    DB,
    DBCtrls;

CONST
     TRAZA_SIEMPRE=0;
     TRAZA_USUARIO=$1;
     TRAZA_MAHA=$2;
     TRAZA_FLUJO=$4;
     TRAZA_FORM=$8;
     TRAZA_FICHEROS=$10;
     TRAZA_COPIAS=$20;
     TRAZA_TABLAS=$40;
     TRAZA_LINEAS=$80;
     TRAZA_SQL=$100;
     TRAZA_BUCLES=$200;
     TRAZA_REGISTRO=$400;

TYPE
    TFicheroAnotaciones=Class (TObject)
    private
           nombre:string;
           hf: tHandle;
           nfcopia:Integer;
           SectionFileShared : TRTLCriticalSection;
           function GrupoSeleccionado(grupo:Integer):Boolean;virtual;
           procedure PonLinea(CONST s:string);
           procedure VuelcaComponente(c:TComponent;nivel,orden:Integer);
           procedure PonLineaComponente(nivel,orden:Integer;CONST texto:string);
           function  ComponenteStr(c:TComponent):string;

           procedure  ReAssingFile;
           function  GetFileSize : integer; 
           function  GetExists : boolean;
           function  IsToBigger : boolean;
           procedure SetNewHandle (const fichero: string);


    public
          constructor Create(nf:string);
          destructor Destroy; override;
          procedure PonAnotacion(grupo,linea:Integer;CONST modulo,mensaje:string);virtual;
          procedure PonAnotacionFmt(grupo,linea:Integer;CONST modulo,Fmt:String;Pars:ARRAY OF CONST);
          procedure PonFichero(grupo,linea:Integer;CONST modulo,fichero:string);
          procedure PonComponente(grupo,linea:Integer;CONST modulo:string; Componente:TComponent);
          procedure PonRegistro(grupo,linea:Integer; CONST modulo:string;DataSet:TDataSet);

    public
        property Size : Integer read GetFileSize;
        property Exists : boolean read GetExists;
        property FileHandle: string read Nombre write SetNewHandle;
    end;

    TFicheroTrazas=Class (TFicheroAnotaciones)
    private
           FMascara:Integer;
           function GrupoSeleccionado(grupo:Integer):Boolean;override;
    public
          constructor Create(nf:string;mascara:Integer);
          Procedure PonMascara(mascara:Integer);
    end;

    TFicheroAnomalias=Class(TFicheroAnotaciones)
    private
           Fasociado:TFicheroTrazas;
    public
          constructor Create(nf:string;asociado:TFicheroTrazas);
          procedure PonAnotacion(grupo,linea:Integer;CONST modulo,mensaje:string);override;
    end;

    // Procedimientos para iniciar y finalizar el sistema de trazas.
    Procedure InitLogs;
    Procedure EndLogs;
VAR
   FTrazas:TFicheroTrazas=NIL;
   FIncidencias:TFicheroAnomalias=NIL;
   FAnomalias:TFicheroAnomalias=NIL;

implementation

uses
   SysUtils,
   Forms,
   FileCtrl,
   DBTables,
   StdCtrls,
   ExtCtrls,
   Mask,
   Spin,
   ComCtrls,
   UVERSION,
   UCDIALGS,
   USUPERREGISTRY;

const

     UN_K = 1024;
     MAXTAMTRAZAS= 500*UN_K; // 500000 bytes
     MAXDIAS=7;
     FILE_NAME='ULogs.PAS';

procedure InitError(Msg: String);
begin
    MessageDlg('Error en la Inicialización',Msg,mtError,[mbOK],mbOK,0);
    if Assigned(fAnomalias)
    then fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FILE_NAME,Msg);
    InitializationError := TRUE;
    Application.Terminate;
end;

function TFicheroAnotaciones.GrupoSeleccionado(grupo:Integer):Boolean;
begin
     Result:=True
end;

function TFicheroAnotaciones.GetExists : boolean;
begin
    result := SysUtils.FileExists(nombre);
end;

function TFicheroAnotaciones.GetFileSize : integer;
begin
    if Exists
    then result := Windows.GetFileSize(hf,nil)
    else result := 0
end;

function TFicheroAnotaciones.IsToBigger : Boolean;
begin
    Result := (Size >= 0) and (Size >= MAXTAMTRAZAS)
end;

procedure TFicheroAnotaciones.SetNewHandle(const fichero: string);
var
    i : integer;
begin
    if hf <> -1 then CloseHandle(hf);
    i := Windows.CreateFile(PChar(fichero), GENERIC_WRITE or GENERIC_READ, FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
    if i = INVALID_HANDLE_VALUE
    then hf := 0        //MODI RAN
    else hf := i
end;

procedure TFicheroAnotaciones.ReAssingFile;
var
    i: integer;
    NuevoNombre : string;
begin
    if hf <> -1
    then begin
        CloseHandle(hf);
        hf := 0;        //MODI RAN
    end;

    NuevoNombre := SysUtils.ChangeFileExt(Nombre,'.BAK');
    try
        if SysUtils.FileExists(NuevoNombre)
        then SysUtils.DeleteFile(NuevoNombre);

        if not SysUtils.RenameFile(Nombre,NuevoNombre)
        then begin
            CopyFile(Pchar(Nombre),PChar(NuevoNombre),FALSE);
            if hf <> -1 then CloseHandle(hf);
            i := Windows.CreateFile(PChar(Nombre), GENERIC_WRITE or GENERIC_READ, FILE_SHARE_READ or FILE_SHARE_WRITE, nil, TRUNCATE_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
            if i = INVALID_HANDLE_VALUE
            then hf := 0        //MODI RAN
            else hf := i
        end
        else FileHandle := Nombre;
    except
        on E: Exception do
            raise Exception.CreateFmt('Error al mover el fichero %s por %s',[Nombre,E.message]);
    end;

    if hf <= 0
    then raise Exception.CreateFmt('Error al Asignar el fichero %s por %d',[Nombre,GetLastError])
end;

destructor TFicheroAnotaciones.Destroy;
begin
    if hf <> -1
    then CloseHandle(hf);
    DeleteCriticalSection(SectionFileShared);
    inherited destroy;
end;

constructor TFicheroAnotaciones.Create(nf:string);
begin
    Inherited Create;
    nfcopia:=0;
    Nombre := nf;
    if not DirectoryExists(ExtractFileDir(nombre))
    then raise Exception.Create('No existe el directorio para el fichero '+nf);

    FileHandle := Nombre;
    if hf < 0
    then raise Exception.CreateFmt('No se pudo crear el fichero %s por %d',[Nombre, GetLastError])
    else if IsToBigger then ReAssingFile;

    InitializeCriticalSection(SectionFileShared)

end;



procedure TFicheroAnotaciones.PonLinea(CONST s:string);
var
    Carry   : integer;
    pBytesW : cardinal;            //MODI RAN INTEGER X CARDINAL
    Literal : string;
begin
    // Debe entrar con el handle habierto
    carry := Size;
    if carry >= 0
    then begin
        if SetFilePointer(hf,Carry,nil,FILE_BEGIN) >= 0
        then begin
            Literal := s + ^M + ^J;
            if (not WriteFile(hf,PChar(Literal)^,Length(Literal),pBytesW,nil)) or (Length(Literal) <> pBytesW)      //MODI RAN
            then raise Exception.CreateFmt('No se pudo escribir la línea en el fichero %s por %d',[Nombre, GetLastError]);

            FileHandle := Nombre;

            if hf < 0
            then raise Exception.CreateFmt('No se pudo volcar la información del fichero %s por %d',[Nombre, GetLastError]);
        end
        else raise Exception.CreateFmt('Error posicionandose al final del fichero %s por %d',[Nombre,GetLastError])
    end
    else raise Exception.CreateFmt('Error al obtener el tamaño del fichero %s por %d',[Nombre,GetLastError])
end;

procedure TFicheroAnotaciones.PonAnotacion(grupo,linea:Integer;CONST modulo,mensaje:string);
begin
    try
        try
            EnterCriticalSection(SectionFileShared);

            if IsToBigger then ReAssingFile;

            if GrupoSeleccionado(grupo)
            then PonLinea(Format('%s [%d] %s(%d): %s',[DateTimeToStr(Now),grupo,modulo,linea,mensaje]));


        finally
            LeaveCriticalSection(SectionFileShared)
        end;

    except
        on E : Exception do
            MessageDlg(Application.Title,Format('Error al escribir por: %s',[E.message]),mtError, [mbOk], mbOk,0);

    end;
end;

procedure TFicheroAnotaciones.PonAnotacionFmt(grupo,linea:Integer;CONST modulo,Fmt:String;Pars:ARRAY OF CONST);
VAR
   s:string;
begin
     try
        s:=Format(Fmt,Pars)
     except
           on E:Exception DO
              s:='!Excepción '+E.Message
     end;
     PonAnotacion(grupo,linea,modulo,s)
end;

procedure TFicheroAnotaciones.PonFichero(grupo,linea:Integer;CONST modulo,fichero:string);
VAR
   nfich,DirTrazas,texto:string;
   Existe:Boolean;
begin
     IF GrupoSeleccionado(grupo)
        THEN BEGIN
                  IF FileExists(fichero)
                     THEN BEGIN
                               DirTrazas:=ExtractFilePath(nombre);
                               REPEAT
                                     nfich:=Format('%s%.8d.TRZ',[DirTrazas,nfcopia]);
                                     Existe:=FileExists(nfich);
                                     IF Existe THEN Inc(nfcopia)
                               UNTIL NOT Existe;
                               IF NOT CopyFile(Pchar(fichero),Pchar(nfich),FALSE)
                                  THEN texto:=Format('Error %d copiando %s a %s',[GetLastError,fichero,nfich])
                                  ELSE texto:=Format('Fichero %s copiado como %s',[fichero,nfich])
                          END
                     ELSE texto:='No se encuentra el fichero origen '+fichero;
                  PonAnotacion(grupo,linea,modulo,texto)
             END
end;

procedure TFicheroAnotaciones.PonComponente(grupo,linea:Integer;CONST modulo:string; Componente:TComponent);
begin
     IF GrupoSeleccionado(Grupo)
        THEN BEGIN
                  PonAnotacion(grupo,linea,modulo,'Volcado del componente '+ComponenteStr(componente));
                  VuelcaComponente(componente,0,-1)
             END
end;

function TFicheroAnotaciones.ComponenteStr(c:TComponent):string;
begin
     Result:=Format('%s (%s)',[C.Name,C.ClassName])
end;

procedure TFicheroAnotaciones.PonLineaComponente(nivel,orden:Integer;CONST texto:string);
VAR
   s:string;
   i:Integer;
BEGIN
     s:='';
     IF orden>=0
        THEN s:=Format('%3d: ',[orden])+s;
     FOR i:=1 TO nivel DO
         s:='    '+s;
     s:=s+texto;
     PonAnotacion(0,0,'',s);
END;

procedure TFicheroAnotaciones.VuelcaComponente(c:TComponent;nivel,orden:Integer);
VAR
   i:Integer;
begin
     IF c IS TForm
        THEN WITH (c AS TForm) DO
             BEGIN
                  PonLineaComponente(nivel,orden,'Form '+ComponenteStr(c));
                  FOR i:=0 TO ComponentCount-1 DO
                      VuelcaComponente(Components[i],nivel+1,i)
             END
        ELSE IF c IS TQuery
                THEN WITH (c AS TQuery) DO
                     BEGIN
                          PonLineaComponente(nivel,orden,'Query '+ComponenteStr(c));
                          IF SQL.Count>0
                             THEN WITH SQL DO
                                  BEGIN
                                       PonLineaComponente(nivel,-1,'- Sentencia SQL:');
                                       FOR i:=0 TO Count-1 DO
                                           PonLineaComponente(nivel+1,i,strings[i]);
                                  END;
                          IF ParamCount>0
                             THEN WITH Params DO
                                  BEGIN
                                       PonLineaComponente(nivel,-1,'- Parámetros:');
                                       FOR i:=0 TO ParamCount-1 DO
                                           WITH Params[i] DO
                                                PonLineaComponente(nivel+1,i,Format('Nombre:%s,Tipo:%d,Valor:%s',[Name,Ord(DataType),Text]))
                                  END
                     END
        ELSE IF c IS TTable
                THEN WITH c AS TTable DO
                     BEGIN
                          PonLineaComponente(nivel,orden,'Table '+ComponenteStr(c));
                          IF FieldCount>0
                             THEN BEGIN
                                       PonLineaComponente(nivel,-1,'- Campos:');
                                       FOR i:=0 TO FieldCount-1 DO
                                           VuelcaComponente(Fields[i],nivel+1,i)
                                  END
                     END
        ELSE IF c IS TField
                THEN WITH c AS TField DO
                          PonLineaComponente(nivel,orden,Format('Field %s, Nombre:%s, Tipo:%d, Valor:%s',[ComponenteStr(c),FieldName,Ord(DataType),Text]))
        ELSE IF c IS TEdit
                THEN WITH c AS TEdit DO
                          PonLineaComponente(nivel,orden,Format('Edit %s, Valor:%s',[ComponenteStr(c),Text]))
        ELSE IF c IS TCheckBox
                THEN WITH c AS TCheckBox DO
                          PonLineaComponente(nivel,orden,Format('Check %s, Texto:%s, Valor:%d',[ComponenteStr(c),Caption,Ord(Checked)]))
        ELSE IF c IS TComboBox
                THEN WITH c AS TComboBox DO
                          IF ItemIndex>=0
                             THEN PonLineaComponente(nivel,orden,Format('Combo %s, Valor:%s',[ComponenteStr(c),Items[ItemIndex]]))
                             ELSE PonLineaComponente(nivel,orden,Format('Combo %s, Sin seleccionado',[ComponenteStr(c)]))
       ELSE IF c IS TListBox
               THEN WITH c AS TListBox DO
                         IF ItemIndex>=0
                             THEN PonLineaComponente(nivel,orden,Format('List %s, Valor:%s',[ComponenteStr(c),Items[ItemIndex]]))
                             ELSE PonLineaComponente(nivel,orden,Format('List %s, Sin seleccionado',[ComponenteStr(c)]))
       ELSE IF c IS TRadioButton
               THEN WITH c AS TRadioButton DO
                         PonLineaComponente(nivel,orden,Format('Radio %s, Texto:%s, Valor:%d',[ComponenteStr(c),Caption,Ord(Checked)]))
       ELSE IF c IS TRadioGroup
               THEN WITH c AS TRadioGroup DO
                         PonLineaComponente(nivel,orden,Format('RadioGroup %s, Seleccionado:%d Texto:%s',[ComponenteStr(c),ItemIndex,Items[ItemIndex]]))
       ELSE IF c IS TMaskEdit
               THEN WITH c AS TMaskEdit DO
                         PonLineaComponente(nivel,orden,Format('Mask %s, Máscara:%s, Valor:%s',[ComponenteStr(c),EditMask,Text]))
       ELSE IF c IS TSpinEdit
               THEN WITH c AS TSpinEdit DO
                         PonLineaComponente(nivel,orden,Format('SpinEdit %s, Valor:%d',[ComponenteStr(c),Value]))
       ELSE IF c IS TUpDown
               THEN WITH c AS TUpDown DO
                         PonLineaComponente(nivel,orden,Format('UpDown %s, Valor:%d',[ComponenteStr(c),Position]))
       ELSE IF c IS TDBText
               THEN WITH c AS TDBText DO
                         PonLineaCOmponente(nivel,orden,Format('DBText %s, Valor:%s',[ComponenteStr(c),DataSource.DataSet.FieldByName(DataField).Text]))
       // ELSE PonLineaComponente(nivel,orden,'Componente '+ComponenteStr(c))
END;

procedure TFicheroAnotaciones.PonRegistro(grupo,linea:Integer; CONST modulo:string;DataSet:TDataSet);
VAR
   s:string;
   i:Integer;
BEGIN
     WITH DataSet DO
     BEGIN
          s:='['+Name+'] ';
          FOR i:=0 TO FieldCount-1 DO
              WITH Fields[i] DO
                   s:=s+FieldName+':'+Text+','
     END;
     IF Length(s)=0
        THEN s:='NO HAY DATOS'
        ELSE SetLength(s,length(s)-1);
     PonAnotacion(grupo,linea,modulo,s)
END;

constructor TFicheroTrazas.Create(nf:string;mascara:Integer);
VAR
   SR:TSearchRec;
   Res:Integer;
begin
     inherited Create(nf);
     FMascara:=mascara;

     try
         Res:=SysUtils.FindFirst(ExtractFilePath(nombre)+'*.TRZ',faAnyFile,SR);
         WHILE Res=0 DO
         BEGIN
              IF (FileDateToDateTime(SR.Time)-Now)>MAXDIAS
                 THEN SysUtils.DeleteFile(SR.Name);
              Res:=SysUtils.FindNext(SR)
         END;
         SysUtils.FindClose(SR)
     except

     end;
end;

function TFicheroTrazas.GrupoSeleccionado(grupo:Integer):Boolean;
begin
     Result:=(Grupo=0) OR ((grupo AND Fmascara)<>0)
end;

Procedure TFicheroTrazas.PonMascara(mascara:Integer);
begin
     FMascara:=Mascara
end;

constructor TFicheroAnomalias.Create(nf:string;asociado:TFicheroTrazas);
begin
     inherited Create(nf);
     FAsociado:=asociado
end;

procedure TFicheroAnomalias.PonAnotacion(grupo,linea:Integer;CONST modulo,mensaje:string);
begin
     inherited PonAnotacion(grupo,linea,modulo,mensaje);
     IF Assigned(FAsociado)
        THEN FAsociado.PonAnotacion(grupo,linea,modulo,mensaje)
end;

procedure InitLogs;
var
  SuperRegistry: TSuperRegistry;
  TrazasName,AnomaliasName,IncidenciasName: String;
  MascaraTrazas: Integer;
begin
  SuperRegistry := TSuperRegistry.Create;
  TRY
    WITH SuperRegistry DO
      BEGIN
        RootKey := HKEY_LOCAL_MACHINE;
        IF NOT OpenKeyRead(LOGS_KEY)
          THEN InitError('No se encontraron los parámetros de Log en el registro')
          ELSE BEGIN
            TRY
              {$IFDEF TRAZAS}
                TrazasName := ReadString(TRAZAS_);
                MascaraTrazas := ReadInteger(MASCARA_);
              {$ENDIF}
              AnomaliasName := ReadString(ANOMALIAS_);
              IncidenciasName := ReadString(INCIDENCIAS_);
            EXCEPT
              InitError('No se encontraron los parámetros de log en el registro');
              Exit;
            END;

            {$IFDEF TRAZAS}
            try
               FTrazas:=TFicheroTrazas.Create(TrazasName,0);
               FTrazas.PonMascara(MascaraTrazas);
               FTrazas.PonAnotacion(TRAZA_SIEMPRE,300,FILE_NAME,'');
               FTrazas.PonAnotacion(TRAZA_SIEMPRE,300,FILE_NAME,'');
               FTrazas.PonAnotacion(TRAZA_SIEMPRE,300,FILE_NAME,'-> Sistema de trazas iniciado');
            except
               InitError('Error en la creación del fichero de trazas: '+TrazasName);
               exit;
            end;
            {$ENDIF}

            try
               FAnomalias:=TFicheroAnomalias.Create(AnomaliasName,FTrazas)
            except
               InitError('Error en la creación del fichero de anomalías: '+AnomaliasName);
               exit;
            end;

            try
               FIncidencias:=TFicheroAnomalias.Create(IncidenciasName,FTrazas)
            except
               InitError('Error en la creación del fichero de incidencias: '+IncidenciasName);
               exit;
            end;
          END;
      END;
  FINALLY
    SuperRegistry.Free;
  END;
end;

Procedure EndLogs;
begin
  FIncidencias.Free;
  FIncidencias := nil;
  FAnomalias.Free;
  FAnomalias := nil;
  {$IFDEF TRAZAS}
  IF Assigned(FTrazas)
     THEN BEGIN
               FTrazas.PonAnotacion(TRAZA_SIEMPRE,400,FILE_NAME,'-> Final del sistema de trazas');
               FTrazas.Free;
               FTrazas := nil;
          END
  {$ENDIF}
end;

Initialization
    InitLogs;

Finalization
    EndLogs;

end.
