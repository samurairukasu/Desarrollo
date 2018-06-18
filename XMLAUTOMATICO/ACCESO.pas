unit Acceso;

interface

Uses
    Windows,Classes, sqlExpr, SysUtils, ACCESO1, DBXpress, dbclient,provider;
Type
    EIntegrity = class(Exception);

    TGestorSeg = Class(TComponent)
    Public
       Constructor Inicializa(DB: TSQLConnection; NombreAlias,Usr,Pwd: String);
            { Lee los Usuarios, grupos y Servicios de la BD e iniciliza el Gestor. El
              objeto DB, si es distinto de nil, permite cargar todos los elementos del
              gestor dentro de su sesión. Si DB es nil, el gestor crea su propio objeto
              TDataBase a partir de NombreAlias, Usr y Pwd }

       Destructor Destroy; override;
            { Libera todas las estructuras utilizadas }

       Function HayError: Boolean;
            { Devuelve TRUE si se produjo algún error durante la carga de datos }

       Function ObtenerIDUsuario(Nombre: String): Integer;
            { Devuleve el identificador de el usuario cuyo nombre recibe como
              argumento }

       Function ComprobarClaveUsuario(IDU: Integer; Clave: String): BOOLEAN;
            { Devuelve True si la clave es correcta para el usuario con identificador
              IDU y False en otro caso }

       Function ComprobarClaveCambios(IDU: Integer; Clave: String): BOOLEAN;
            { Devuelve True si la clave de cambios es correcta para el usuario con identificador
              IDU y False en otro caso }


       Function AccesoServicio(IDS,IDU: Integer; Clave: String): BOOLEAN;
            {Devuelve TRUE si el usuario con identificador IDU con clave "Clave"
             puede acceder al servicio con identificador IDS y FALSE si:
                 - La clave es incorrecta.
                 - El usuario no tiene permiso.
             }

       Function ObtenerNUsuarios: Integer;
             { Devuelve el número de usuarios en la BD }

       Function ObtenerNServicios: Integer;
             { Devuelve el número de servicios en la BD }

       Function ObtenerNGrupos: Integer;
             { Devuelve el número de grupos en la BD }


       Procedure ObtenerUsuario(I:Integer; VAR IDU: Integer; VAR Nombre,Info,clave,ClaveCambio: String;
                                 VAR Grupos: TSetInt);
             { Obtiene el usuario I de la BD. Si IDU es -1 no existe ese usuario.
                       I: Valor en el rango 1 .. ObtenerNUsuarios
                       IDU: Identificador de Usuario
                       Nombre: Nombre del Usuario
                       Info: Información Adicional
                       Grupos: Grupos a los que pertenece el usuario}

       Procedure ObtenerGrupo(I:Integer; VAR IDG: Integer; VAR Nombre: String;
                               VAR Componentes: TSetInt);
             { Obtiene el grupo I de la BD. Si IDU es -1 no existe ese grupo.
                       I: Valor en el rango -> 1 .. ObtenerNGrupos
                       IDG: Identificador de Grupo
                       Nombre: Nombre del grupo
                       Componentes: Conjunto con los identificadores de los componentes}

       Procedure ObtenerServicio(I:Integer; VAR IDS: Integer; VAR Descripcion: String;
                               VAR Usuarios,Grupos: TSetInt);
             { Obtiene el Servicio I de la BD. Si IDS es -1 no existe el servicio.
                       I: Valor en el rango -> 1 .. ObtenerNGrupos
                       IDS: Identificador de Servicio
                       Descripción: Descripción del Servicio
                       Usuarios: Conjunto de usuarios con acceso permitido
                       Grupos: Conjunto de Grupos con acceso permitido}

       Function AniadirUsuario(IDU: Integer; Nombre,Clave,Adicional,ClaveSup,ClaveCambio: String): Boolean;
             { Añade un nuevo usuario a la BD con los parámetros que recibe como
               argumentos. Es necesario pasar la clave del superusuario. El valor
               devuelto indica si la operación tuvo o no éxito }

       Function EliminarUsuario(IDU: Integer; ClaveSup: String): Boolean;
             { Elimina el Usuario con identificador IDU de la BD. El valor devuelto
               indica si lo operación tuvo o no éxito }

       Function ModificarUsuario(IDU: Integer; Nombre,Clave,Adicional,ClaveSup,ClaveCambio:String): Boolean;
             { Modifica los datos del usuario con identificador IDU con los valores que
               recibe como argumentos. El valor devuelto indica si la operación tuvo
               éxito. Es necesario introducir bien la clave del usuario o la del superusuario }

       Function AniadirGrupo(IDG: Integer; Nombre,ClaveSup:String): Boolean;
             { Crea un nuevo grupo en la BD con el identificador y nombre que recibe como
               argumentos. El valor devuelto indica si la operación tuvo o no éxito }

       Function EliminarGrupo(IDG: Integer; ClaveSup: String): Boolean;
             { Elimina el grupo con identificador IDG de la BD. El valor devuelto indica
               si la operación tuvo éxito }

       Function ModificarGrupo(IDG: Integer; Nombre,ClaveSup: String): Boolean;
             { Modifica el nombre del grupo con identificador IDG. El valor devuelto indica
               si la operación tuvo éxito }

       Function AniadirServicio(IDS: Integer; Nombre,ClaveSup:String): Boolean;
             { Añade un nuevo servicio a la BD con los valores que recibe como argumentos.
               El valor devuelto indica si la operación tuvo éxito }

       Function EliminarServicio(IDS: Integer; ClaveSup: String): Boolean;
             { Elimina el servicio con identificador IDS de la BD. El valor devuelto indica
               si la operación tuvo éxito }

       Function ModificarServicio(IDS: Integer; Nombre,ClaveSup: String): Boolean;

       Function AsociarUsuarioGrupo(IDU,IDG: Integer; ClaveSup:String): Boolean;

       Function AsociarUsuarioServicio(IDU,IDS: Integer; ClaveSup: String): Boolean;

       Function AsociarGrupoServicio(IDG,IDS: Integer; ClaveSup:String): Boolean;

       Function DAsociarUsuarioGrupo(IDU,IDG: Integer; ClaveSup:String): Boolean;

       Function DAsociarUsuarioServicio(IDU,IDS: Integer; ClaveSup: String): Boolean;

       Function DAsociarGrupoServicio(IDG,IDS: Integer; ClaveSup:String): Boolean;

       Function ObtenerNIDU: Integer;
       { Devuelve un identificador de usuario válido para un nuevo usuario o -1 si
         no consigue leer la BD }

       Function ObtenerNIDG: Integer;
       { Devuleve un identificador de grupo válido para un nuevo grupo o -1 si no
         consigue leer la BD }

       Function ObtenerNIDS: Integer;
       { Devuleve un identificador de servicio válido para un nuevo servicio o -1 si
         no consigue leer la BD }

       Function BuscarUsuario(IDU: Integer): TUsuario;

       Function UsuarioDisponible(Nombre: String): Boolean;
       Function LoginUser(Nombre: String): Boolean;
       Procedure LimpiarRestos(vNombre: String);
       Procedure LimpiarTablaEstadoInsp(vNombre: String);

    Private
        {*
         * Miembros datos
         *}
             NumUsuarios, NumGrupos, NumServicios: Integer;
                 {* Número de Usuarios, Grupos y Servicios existentes *}
             UsuariosBD, GruposBD,ServiciosBD: TList;
                 {* Listas de objetos de las clases TUsuario, TGrupo y TServicio
                    que representan a los usuarios, grupos y servicios almacenados
                    en la BD *}
             Superusuario : TUsuario;
                 {* Referencia al objeto que representa al Superusuario *}
             Error: Boolean;

             BaseDatos: TSQLConnection;
                 {* Objeto necesario para mantener la sesion *}
             BDMia: BOOLEAN;
        {*
         * Miembros función
         *}
//             Function BuscarUsuario(IDU: Integer): TUsuario;         MODI RAN la pase a publica para que se la pueda ver
             Function BuscarGrupo(IDG: Integer): TGrupo;
             Function BuscarServicio(IDS: Integer): TServicio;
             { Estas tres funciones devuelven respectivamente el indice en las listas
               UsuariosBD, GruposBD, ServiciosBD de los elementos identificados por
               IDU, IDG e IDS }


    End;

    var
    UID: Integer;

implementation

uses
  Forms,
  UCDIALGS,
  uVersion,
  USUPERREGISTRY;
{*****************************************************************************
 *                                                                           *
 *        I M P L E M E N T A C I O N    D E   L A    C L A S E              *
 *                                                                           *
 *                         T G e s t o r S e g                               *
 *                                                                           *
 *****************************************************************************}

Function TGestorSeg.UsuarioDisponible(Nombre: String): Boolean;
var
QryConsultas: TClientDataSet;
sdsQryConsultas : TSQLDataSet;
dspQryConsultas : tdatasetprovider;
Begin
Result := False;
sdsQryConsultas := TSQLDataSet.Create(Application);
sdsQryConsultas.SQLConnection := BaseDatos;
sdsQryConsultas.CommandType := ctQuery;
sdsQryConsultas.GetMetadata := false;
sdsQryConsultas.NoMetadata := true;
sdsQryConsultas.ParamCheck := false;
dspQryConsultas := TDataSetProvider.Create(application);
dspQryConsultas.DataSet := sdsQryConsultas;
dspQryConsultas.Options := [poIncFieldProps,poAllowCommandText];
QryConsultas:=TClientDataSet.create(application);
  Try
    with QryConsultas do
      Try
        LimpiarRestos(Nombre);
        SetProvider(dspQryConsultas);
        Close;
        CommandText:='LOCK TABLE TACCESOS in exclusive mode nowait';
        Execute;
        SetProvider(dspQryConsultas);
        Close;
        CommandText:='SELECT USER_SAG FROM TACCESOS WHERE USER_SAG = :NOMBRE FOR UPDATE NOWAIT';
        params[0].Value:= Nombre;
        Open;
        If (RecordCount < 1) then
          Result := True
        else
          Begin
            DialogsFont.Size:=15;
            MessageDlg('ERROR DE ACCESO!','Ese usuario ya se encuentra en uso!.'+#13+#10+'Intente con un usuario diferente.', mtERROR, [mbOk], mbOK, 0);
            DialogsFont.Size:=8;
          end;
      Except
        MessageDlg('ERROR DE ACCESO!','Aguarde unos segundos en intentelo de nuevo.', mtERROR, [mbOk], mbOK, 0);
      end;
  finally
    QryConsultas.Close;
    QryConsultas.Free;
    dspQryConsultas.Free;
    sdsQryConsultas.Free;
  end;
end;


Function TGestorSeg.LoginUser(Nombre: String): Boolean;
var
QryConsultas: TClientDataSet;
sdsQryConsultas : TSQLDataSet;
dspQryConsultas : tdatasetprovider;
begin
Result:=False;
if UsuarioDisponible (Nombre) then
  Begin
    sdsQryConsultas := TSQLDataSet.Create(Application);
    sdsQryConsultas.SQLConnection := BaseDatos;
    sdsQryConsultas.CommandType := ctQuery;
    sdsQryConsultas.GetMetadata := false;
    sdsQryConsultas.NoMetadata := true;
    sdsQryConsultas.ParamCheck := false;
    dspQryConsultas := TDataSetProvider.Create(application);
    dspQryConsultas.DataSet := sdsQryConsultas;
    dspQryConsultas.Options := [poIncFieldProps,poAllowCommandText];
    QryConsultas:=TClientDataSet.create(application);
    Try
      with QryConsultas do
        Try
          Close;
          SetProvider(dspQryConsultas);
          CommandText:='INSERT INTO TACCESOS VALUES (sys_context(''userenv'',''terminal''),:NOMBRE,SysDate,sys_context(''userenv'',''SESSIONID''))';
          params[0].Value:= Nombre;
          Execute;
          Result:=true;
          LimpiarTablaEstadoInsp(Nombre);
        Except

        end;
    finally
      QryConsultas.Close;
      QryConsultas.Free;
      dspQryConsultas.Free;
      sdsQryConsultas.Free;
    end;
  end;
end;

 
Procedure TGestorSeg.LimpiarRestos(vNombre: String);
begin
  try
    with TSQLStoredProc.Create(application) do
      try
        SQLConnection := BaseDatos;
        StoredProcName := 'PQ_LOGGIN.Bad_Logoff';
        ParamByName('USUARIO').Value := vNombre;
        ExecProc;
        Close;
      finally
        Free;
    end;
  Except
    On E: Exception do
      ShowMessage('ERROR',E.Message);
  end;
end;


Procedure TGestorSeg.LimpiarTablaEstadoInsp(vNombre: String);
begin
  try
    with TSQLStoredProc.Create(application) do
      try
        SQLConnection := BaseDatos;
        StoredProcName := 'PQ_LOGGIN.Clear_Usuario';
        ParamByName('USUARIO').Value := vNombre;
        ExecProc;
        Close;
      finally
        Free;
    end;
  Except
    On E: Exception do
      ShowMessage('ERROR',E.Message);
  end;
end;


Constructor TGestorSeg.Inicializa(DB: TSQLConnection; NombreAlias,Usr, Pwd:String);
Var
Sentencia: TSQLQuery;
SID,GID: Integer;
Nombre,Clave,Info,Descripcion,ClaveCambios: String;
Contador: Integer;
Usuario: TUsuario;
Servicio: TServicio;
Grupo: TGrupo;

Begin
  try
    Error := FALSE;
    UsuariosBD:= nil;
    GruposBD:= nil;
    ServiciosBD:= nil;
    if DB <> nil then
      begin
        BaseDatos := DB;
        BDMia:= FALSE;
      end
    else
      Begin
        BDMia:= TRUE;
        BaseDatos := TSQLConnection.Create(application);
        with BaseDatos do
          begin
            { TODO -oran -cCosas a investigar y modificar : Ver de donde sacar los parametros }
            Name := 'Seguridad';
            DriverName := 'Oracle Net (Core Lab)';
            LibraryName := 'dbexpoda.dll';
            VendorLib := 'dbexpoda.dll';
            GetDriverFunc := 'getSQLDriverORANET';

            Params.Values['DataBase'] := NombreAlias;
            Params.Values['User_Name'] := Usr;
            Params.Values['Password'] := Pwd;
            LoginPrompt := false;
            KeepConnection := true;
          end;

          try
            BaseDatos.Connected := TRUE;
          except
            on E: Exception do
              begin
                ShowMessage('Gestion de Usuarios','Error al conectarse a la base de datos: '+E.Message);
                Destroy;
              end;
          end;
      end;

    NumUsuarios := 0;
    Sentencia := TSQLQuery.Create(Self);
    Sentencia.Close;
    Sentencia.SQLConnection := BaseDatos;

    { TODO -oran -ctransacciones : Ver tema de sesion }
    { Creación de Usuarios }
    Sentencia.SQL.Add('SELECT IDUSUARIO,NOMBRE,CLAVE,ADICIONAL,CLAVE_CAMBIOS FROM TUSUARIO');
    UsuariosBD := TList.Create;
    Try
       Sentencia.Open;
    Except
      On E:Exception Do
        Begin
          ShowMessage('Gestión de Usuarios','Se ha producido un error al leer la tabla <TUSUARIO> de la Base de Datos' + E.Message);
          Error := TRUE;
          exit;
        End;
    End;

    While not Sentencia.EOF Do
      Begin
        UID := Sentencia.Fields[0].AsInteger;
        Nombre := Sentencia.Fields[1].AsString;
        Clave := Sentencia.Fields[2].AsString;
        Info := Sentencia.Fields[3].AsString;
        ClaveCambios := Sentencia.Fields[4].AsString;
        Usuario := TUsuario.Crear(UID,Nombre,Clave,Info, ClaveCambios);
        if (UID = 0) Then
          SuperUsuario := Usuario;
        UsuariosBD.Add(Usuario);
        Sentencia.Next;
        inc(NumUsuarios);
      end;

    // Usuario de reserva en caso de que no haya en la base de datos
    If NumUsuarios = 0 Then
      begin
        Usuario := TUsuario.Crear(0,'ADMINISTRADOR','SUPER','Usuario Temporal','SPIDER');
        SuperUsuario := Usuario;
        UsuariosBD.Add(Usuario);
        inc(NumUsuarios);
      end;

    { Creación de Grupos }
    Sentencia.Close;
    Sentencia.SQL.Clear;
    NumGrupos := 0;
    GruposBD := TList.Create;
    Sentencia.SQL.Add('SELECT * FROM TGRUPOS');
    Try
       Sentencia.Open;
    Except
       ShowMessage('Gestion de Usuarios','Se ha producido un error al leer la tabla <TGRUPOS> de la Base de Datos');
       Error := TRUE;
       exit;
    End;

    While not Sentencia.EOF Do
    Begin
        GID := Sentencia.Fields[0].AsInteger;
        Nombre := Sentencia.Fields[1].AsString;
        Grupo := TGrupo.Crear(GID,Nombre);
        GruposBD.Add(Grupo);
        Sentencia.Next;
        inc(NumGrupos);
    End;

    { Asignación de usuarios a grupos}
    Sentencia.Close;
    Sentencia.SQL.Clear;
    Sentencia.SQL.Add('SELECT * FROM TCOMPON');
    Try
       Sentencia.Open;
    Except
       ShowMessage('Gestión de Usuarios','Se ha producido un error al leer la tabla <TCOMPON> de la Base de Datos');
       Error := TRUE;
       exit;
    End;

    While not Sentencia.EOF Do
    Begin
      GID := Sentencia.Fields[0].AsInteger;
      UID := Sentencia.Fields[1].AsInteger;
      For Contador:= 0 To (NumUsuarios-1) Do
      Begin
          Usuario := UsuariosBD.Items[Contador];
          If (Usuario.ObtenerUID = UID) Then
              Usuario.AniadirGrupo(GID);
      End;
      For Contador:= 0 To (NumGrupos-1) Do
      Begin
          Grupo := GruposBD.Items[Contador];
          If (Grupo.ObtenerGID = GID) Then
              Grupo.AniadirUsuario(UID);
      End;
      Sentencia.Next;
    End;

    { Creación de Servicios }
    Sentencia.Close;
    Sentencia.SQL.Clear;
    Sentencia.SQL.Add('SELECT IDSERVICIO,NOMBRE FROM TSERVIC');
    ServiciosBD:= TList.Create;
    NumServicios := 0;
    Try
       Sentencia.Open;
    Except
       ShowMessage('Gestión de Usuarios','Se ha producido un error al leer la tabla <TSERVIC> de la Base de Datos');
       Error := TRUE;
       exit;
    End;
    While not Sentencia.EOF do
    Begin
      SID := Sentencia.Fields[0].AsInteger;
      Descripcion := Sentencia.Fields[1].AsString;
      Servicio := TServicio.Crear(SID,Descripcion);
      ServiciosBD.Add(Servicio);
      Sentencia.Next;
      Inc(NumServicios);
    End;

     { Usuarios de cada Servicio }
    Sentencia.Close;
    Sentencia.SQL.Clear;
    Sentencia.SQL.Add('SELECT * FROM TSERVUSR');
    Try
       Sentencia.Open;
    Except
       ShowMessage('Gestión de Usuarios','Se ha producido un error al leer la tabla <TSERVUSR> de la Base de Datos');
       Error := TRUE;
       exit;
    End;
    While not Sentencia.EOF Do
    Begin
      SID := Sentencia.Fields[0].AsInteger;
      UID := Sentencia.Fields[1].AsInteger;
      For Contador:= 0 To (NumServicios-1) Do
      Begin
          Servicio := ServiciosBD.Items[Contador];
          If (Servicio.ObtenerSID = SID) Then
              Servicio.AniadirUsuario(UID);
      End;
      Sentencia.Next;
    End;

     { Grupos de cada Servicio }
    Sentencia.Close;
    Sentencia.SQL.Clear;
    Sentencia.SQL.Add('SELECT * FROM TSERVGRP');
    Try
       Sentencia.Open;
    Except
       ShowMessage('Gestion de Usuarios','Se ha producido un error al leer la tabla <TSERVGRP> de la Base de Datos');
       Error := TRUE;
       exit;
    End;
    While not Sentencia.EOF Do
    Begin
      SID := Sentencia.Fields[0].AsInteger;
      GID := Sentencia.Fields[1].AsInteger;
      For Contador:= 0 To (NumServicios-1) Do
      Begin
          Servicio := ServiciosBD.Items[Contador];
          If (Servicio.ObtenerSID = SID) Then
              Servicio.AniadirGrupo(GID);
      End;
      Sentencia.Next;
    End;

    for Contador := 0 to (NumServicios-1) do Servicio := ServiciosBD.Items[Contador];

  finally
     Application.ProcessMessages
  end;
End;

Destructor TGestorSeg.Destroy;
Var
    i: Integer;
    Usuario: TUsuario;
    Servicio: TServicio;
    Grupo: TGrupo;
Begin
  if BDMia Then
    BaseDatos.Free;
  if UsuariosBD <> nil Then
  Begin
    for i:= 0 To NumUsuarios-1 Do
    Begin
        Usuario := UsuariosBD.Items[i];
        if Usuario <> nil Then Usuario.Free;
    End;
    UsuariosBD.Free;
  End;

  if GruposBD <> nil Then
  Begin
    for i:= 0 To NumGrupos-1 Do
    Begin
        Grupo:= GruposBD.Items[i];
        if Grupo <> nil Then Grupo.Free;
    End;
    GruposBD.Free;
  End;

  if ServiciosBD <> nil Then
  Begin
    for i:= 0 To NumServicios-1 Do
    Begin
        Servicio := ServiciosBD.Items[i];
        if Servicio <> nil Then Servicio.Free;
    End;
    ServiciosBD.Free;
  End;

  inherited Destroy;

End;


Function TGestorSeg.HayError: Boolean;
Begin
    Result := Error;
End;

Function TGestorSeg.ObtenerNUsuarios: Integer;
Begin
    Result := NumUsuarios;
End;

Function TGestorSeg.ObtenerIDUsuario(Nombre: String): Integer;
Var
    Nomb,Info, clav, clavCambio: String;
    Grupos: TSetInt;
    ID,i: Integer;
Begin
    Result := -1;
    for i:= 1 To NumUsuarios Do
    Begin
        ObtenerUsuario(i,ID,Nomb,Info,clav,ClavCambio,Grupos);
        if (ID <> -1) and (Nombre = Nomb) Then
        Begin
           Result:= ID;
           Break;
        End;
    End;
End;


Function TGestorSeg.ComprobarClaveUsuario(IDU: Integer; Clave: String): BOOLEAN;
Var
Usuario: TUsuario;
Begin
Usuario := BuscarUsuario(IDU);
  if (Usuario <> nil) Then
    Result := Usuario.Comprueba(Clave)
  Else
    Result := FALSE;
End;


Function TGestorSeg.ComprobarClaveCambios(IDU: Integer; Clave: String): BOOLEAN; 
Var
    Usuario: TUsuario;
Begin
    Usuario := BuscarUsuario(IDU);
    if (Usuario <> nil) Then
        Result := Usuario.CompruebaClCambios(Clave)
    Else
        Result := FALSE;
End;

Procedure TGestorSeg.ObtenerUsuario(I:Integer; VAR IDU: Integer; VAR Nombre,Info,Clave,ClaveCambio: String;
                         VAR Grupos: TSetInt);
Var
    Usuario: TUsuario;
//    Clave: String;     MODI RAN CLAVE
Begin
    if (i < 1) Or (i > NumUsuarios) Then
        IDU := -1
    else
     Begin
       Usuario := TUsuario(UsuariosBD.Items[I-1]);
       Usuario.ObtenerTodo(IDU,Nombre,Clave,ClaveCambio,Info,Grupos);
     End;
End;

Function TGestorSeg.ObtenerNServicios: Integer;
Begin
    Result := NumServicios;
End;

Procedure TGestorSeg.ObtenerServicio(I:Integer; VAR IDS: Integer; VAR Descripcion: String;
                         VAR Usuarios,Grupos: TSetInt);
Var
    Servicio: TServicio;
Begin
    if (i < 1) Or (i > NumServicios) Then
        IDS := -1
    else
     Begin
       Servicio := TServicio(ServiciosBD.Items[I-1]);
       Servicio.ObtenerTodo(IDS,Descripcion,Usuarios,Grupos);
     End;
End;

Function TGestorSeg.ObtenerNGrupos: Integer;
Begin
    Result := NumGrupos;
End;

Procedure TGestorSeg.ObtenerGrupo(I:Integer; VAR IDG:Integer; VAR Nombre: String;
                                  VAR Componentes: TSetInt);
Var
    Grupo: TGrupo;
Begin
    if (i < 1) Or (i > NumServicios) Then
        IDG := -1
    else
     Begin
       Grupo := TGrupo(GruposBD.Items[I-1]);
       Grupo.ObtenerTodo(IDG,Nombre,Componentes);
     End;
End;

Function TGestorSeg.AccesoServicio(IDS,IDU: Integer; Clave: String): BOOLEAN;
Var
   Usuario: TUsuario;
   Servicio: TServicio;
   Usuarios, Grupos, GruposU: TSetInt;
Begin
   Usuario := BuscarUsuario(IDU);
   if Usuario.HayError Then
   Begin
       Result := False;
       exit;
   End;
   Result := Usuario.Comprueba(Clave);

   { Si la clave no corresponde al usuario se niega el acceso }
   if not Result Then exit;

   { El superusuario tiene acceso a todos los servicios }
   if Result and (IDU = 0) Then exit;

   Servicio := BuscarServicio(IDS);
   if Servicio.HayError Then
   Begin
       Result := False;
       exit;
   End;

   Servicio.ObtenerUsuarios(Usuarios);
   if IDU in Usuarios Then
   Begin
      Result := True;
      exit;
   End;
   Servicio.ObtenerGrupos(Grupos);
   Usuario.ObtenerGrupos(GruposU);
   if (Grupos * GruposU) <> [] Then
       Result := True
   else
       Result := False;

End;

Function TGestorSeg.AniadirUsuario(IDU: Integer; Nombre,Clave,Adicional,ClaveSup,ClaveCambio: String): Boolean;
Var
    Sentencia: TSQLQuery;
    Usuario: TUsuario;
    ClaveCod, ClaveCambioCod: String;
Begin
    Codificar(Clave,IDU,ClaveCod);
    Codificar(ClaveCambio,IDU,ClaveCambioCod);
    if ( (SuperUsuario <> nil) and SuperUsuario.Comprueba(ClaveSup) and
         (BuscarUsuario(IDU) = nil)) Then
      Begin

        Result := TRUE;
        Sentencia := TSQLQuery.Create(Self);
        Sentencia.SQLConnection:= BaseDatos;

        { TODO -oran -ctransacciones : Ver tema session }

        Sentencia.Close;
        Sentencia.SQL.Add('INSERT INTO TUSUARIO (IDUSUARIO,NOMBRE,CLAVE,ADICIONAL,CLAVE_CAMBIOS) VALUES (:UID,:Nombre,:Clave,:Adicional, :ClaveCambioCod)');
        Sentencia.Params[0].AsInteger := IDU;
        Sentencia.Params[1].AsString := Nombre;
        Sentencia.Params[2].AsString := ClaveCod;
        Sentencia.Params[3].AsString := Adicional;
        Sentencia.Params[4].AsString := ClaveCambioCod;
        Try
            Sentencia.ExecSQL;
        Except
            Result := FALSE;
        End;
        if Result Then
        Begin
            Usuario := TUsuario.Crear(IDU,Nombre,ClaveCod,Adicional,'');        
            UsuariosBD.Add(Usuario);
            inc(NumUsuarios);
        End;
      End
    Else
        Result := False;

End;

Function TGestorSeg.EliminarUsuario(IDU: Integer; ClaveSup: String): Boolean;
Var
    Sentencia: TSQLQuery;
    Usuario: TUsuario;
    Grupo: TGrupo;
    Servicio: TServicio;
    i: Integer;

Begin
    Usuario := BuscarUsuario(IDU);
    if ( (SuperUsuario <> nil) and SuperUsuario.Comprueba(ClaveSup) and
         (Usuario <> nil) and (IDU <> 0)) Then
      Begin
        Result := TRUE;
        Sentencia := TSQLQuery.Create(Self);
        Sentencia.SQLConnection := BaseDatos;

        { TODO -oran -ctransacciones : Ver tema session }

        Sentencia.Close;
        Sentencia.SQL.Add('DELETE FROM TUSUARIO WHERE IDUSUARIO = :UID');
        Sentencia.Params[0].AsInteger := IDU;
        Try
          Try
            Sentencia.ExecSQL;
          Except
            Raise EIntegrity.Create('El usuario está asignado a algún grupo o servicio');
            Result := FALSE;
          end;
        Finally
          Sentencia.Free;
        End;
        if Result Then
        Begin
           { Eliminacion del usuario de los grupos a que pertenece }
           for i := 0 To NumGrupos-1 Do
           Begin
               Grupo := GruposBD.Items[i];
               if Grupo <> nil Then
                   Grupo.QuitarUsuario(IDU);
           End;
           { Eliminacion del usuarios en los servicios a que pertenece }
           for i := 0 To NumServicios-1 Do
           Begin
               Servicio := ServiciosBD.Items[i];
               if Servicio <> nil Then
                   Servicio.QuitarUsuario(IDU);
           End;
           UsuariosBD.Remove(Usuario);
           Usuario.Free;
           dec(NumUsuarios);
        End;
      End
    Else
        Result := False;
End;


Function TGestorSeg.ModificarUsuario(IDU: Integer; Nombre,Clave,Adicional,ClaveSup,ClaveCambio:String): Boolean;
Var
    Sentencia: TSQLQuery;
    Usuario: TUsuario;
    ClaveCod, ClaveCambioCod: String;
Begin
    Usuario := BuscarUsuario(IDU);
    if  (Usuario <> nil) and
        (((SuperUsuario <> nil) and SuperUsuario.Comprueba(ClaveSup)) or
          Usuario.Comprueba(ClaveSup)) Then
      Begin
        Codificar(Clave,IDU,ClaveCod);
        Codificar(ClaveCambio,IDU,ClaveCambioCod);
        Result := TRUE;
        Sentencia := TSQLQuery.Create(Self);
        Sentencia.SQLConnection := BaseDatos;

        { TODO -oran -ctransacciones : Ver tema session }

        Sentencia.Close;
        Sentencia.SQL.Add('UPDATE TUSUARIO SET NOMBRE = :Nombre, CLAVE = :Clave, ' +
                           ' ADICIONAL = :Adicional, CLAVE_CAMBIOS = :ClaveCambio WHERE IDUSUARIO = :UID');

        Sentencia.Params[0].AsString := Nombre;
        Sentencia.Params[1].AsString := ClaveCod;
        Sentencia.Params[2].AsString := Adicional;
        Sentencia.Params[4].AsInteger := IDU;
        Sentencia.Params[3].AsString := ClaveCambioCod;
        Try
            Sentencia.ExecSQL;
        Except
            Result := FALSE;
        End;
        if Result Then
            Usuario.Rellenar(IDU,Nombre,ClaveCod,Adicional);
      End
    Else
        Result := False;

End;

Function TGestorSeg.AniadirGrupo(IDG: Integer; Nombre,ClaveSup:String): Boolean;
Var
    Sentencia: TSQLQuery;
    Grupo: TGrupo;
Begin
    if ( (SuperUsuario <> nil) and SuperUsuario.Comprueba(ClaveSup) and
         (BuscarGrupo(IDG) = nil)) Then
      Begin
        Result := TRUE;
        Sentencia := TSQLQuery.Create(Self);
        Sentencia.SQLConnection:= BaseDatos;

        { TODO -oran -ctransacciones : Ver tema session }

        Sentencia.Close;
        Sentencia.SQL.Add('INSERT INTO TGRUPOS (IDGRUPO,NOMBRE) VALUES (:GID,:Nombre)');
        Sentencia.Params[0].AsInteger := IDG;
        Sentencia.Params[1].AsString := Nombre;
        Try
            Sentencia.ExecSQL;
        Except
            Result := FALSE;
        End;
        if Result Then
        Begin
            Grupo := TGrupo.Crear(IDG,Nombre);
            GruposBD.Add(Grupo);
            inc(NumGrupos);
        End;
      End
    Else
        Result := False;
End;

Function TGestorSeg.EliminarGrupo(IDG: Integer; ClaveSup: String): Boolean;
Var
    Sentencia: TSQLQuery;
    Grupo: TGrupo;
    Usuario: TUsuario;
    Servicio: TServicio;
    i: Integer;
Begin
    Grupo := BuscarGrupo(IDG);
    if ( (SuperUsuario <> nil) and SuperUsuario.Comprueba(ClaveSup) and
         (Grupo <> nil) ) Then
      Begin
        Result := TRUE;
        Sentencia := TSQLQuery.Create(Self);
        Sentencia.SQLConnection := BaseDatos;

        { TODO -oran -ctransacciones : Ver tema session }

        Sentencia.Close;
        Sentencia.SQL.Add('DELETE FROM TGRUPOS WHERE IDGRUPO = :GID');
        Sentencia.Params[0].AsInteger := IDG;
        Try
          Try
            Sentencia.ExecSQL;
          Except
            Raise EIntegrity.Create('El grupo contiene algún usuario o tiene asignado algún servicio');
            Result := FALSE;
          end;
        Finally
          Sentencia.Free;
        End;
        if Result Then
        Begin
           { Eliminación del grupo en los distintos usuarios que lo componen }
           for i:= 0 To NumUsuarios-1 Do
           Begin
               Usuario := UsuariosBD.Items[i];
               if Usuario <> nil Then
                   Usuario.QuitarGrupo(IDG);
           End;

           { Eliminación del grupo en los servicios }
           for i:= 0 To NumServicios-1 Do
           Begin
               Servicio := ServiciosBD.Items[i];
               if Servicio <> nil Then
                   Servicio.QuitarGrupo(IDG);
           End;

           GruposBD.Remove(Grupo);
           Grupo.Free;
           dec(NumGrupos);
        End;
      End
    Else
        Result := False;
End;

Function TGestorSeg.ModificarGrupo(IDG: Integer; Nombre,ClaveSup: String): Boolean;
Var
    Sentencia: TSQLQuery;
    Grupo: TGrupo;
Begin
    Grupo := BuscarGrupo(IDG);
    if ( (SuperUsuario <> nil) and SuperUsuario.Comprueba(ClaveSup) and
         (Grupo <> nil)) Then
      Begin
        Result := TRUE;
        Sentencia := TSQLQuery.Create(Self);
        Sentencia.SQLConnection := BaseDatos;

        { TODO -oran -ctransacciones : Ver tema session }

        Sentencia.Close;
        Sentencia.SQL.Add('UPDATE TGRUPOS SET NOMBRE = :Nombre WHERE IDGRUPO = :GID');
        Sentencia.Params[0].AsString := Nombre;
        Sentencia.PArams[1].AsInteger := IDG;
        Try
            Sentencia.ExecSQL;
        Except
            Result := FALSE;
        End;
        if Result Then
            Grupo.Rellenar(IDG,Nombre);
      End
    Else
        Result := False;
End;

Function TGestorSeg.AniadirServicio(IDS: Integer; Nombre,ClaveSup:String): Boolean;
Var
    Sentencia: TSQLQuery;
    Servicio: TServicio;
Begin
    if ( (SuperUsuario <> nil) and SuperUsuario.Comprueba(ClaveSup) and
         (BuscarServicio(IDS) = nil)) Then
      Begin
        Result := TRUE;
        Sentencia := TSQLQuery.Create(Self);
        Sentencia.SQLConnection:= BaseDatos;

{ TODO -oran -ctransacciones : Ver tema session }

        Sentencia.Close;
        Sentencia.SQL.Add('INSERT INTO TSERVIC (IDSERVICIO,NOMBRE) VALUES (:SID,:Nombre)');
        Sentencia.Params[0].AsInteger := IDS;
        Sentencia.Params[1].AsString := Nombre;
        Try
            Sentencia.ExecSQL;
        Except
            Result := FALSE;
        End;
        if Result Then
        Begin
            Servicio := TServicio.Crear(IDS,Nombre);
            ServiciosBD.Add(Servicio);
            inc(NumServicios);
        End;
      End
    Else
        Result := False;
End;

Function TGestorSeg.EliminarServicio(IDS: Integer; ClaveSup: String): Boolean;
Var
    Sentencia: TSQLQuery;
    Servicio: TServicio;
Begin
    Servicio := BuscarServicio(IDS);
    if ( (SuperUsuario <> nil) and SuperUsuario.Comprueba(ClaveSup) and
         (Servicio <> nil) ) Then
      Begin
        Result := TRUE;
        Sentencia := TSQLQuery.Create(Self);
        Sentencia.SQLConnection := BaseDatos;

{ TODO -oran -ctransacciones : Ver tema session }

        Sentencia.Close;
        Sentencia.SQL.Add('DELETE FROM TSERVIC WHERE IDSERVICIO = :SID');
        Sentencia.Params[0].AsInteger := IDS;
        Try
          Try
            Sentencia.ExecSQL;
          Except
            Raise EIntegrity.Create('El servicio tiene asignado algún grupo o usuario');
            Result := FALSE;
          end;
        Finally
          Sentencia.Free;
        End;
        if Result Then
        Begin
           ServiciosBD.Remove(Servicio);
           Servicio.Free;
           dec(NumServicios);
        End;
      End
    Else
        Result := False;
End;

Function TGestorSeg.ModificarServicio(IDS: Integer; Nombre,ClaveSup: String): Boolean;
Var
    Sentencia: TSQLQuery;
    Servicio: TServicio;
Begin
    Servicio := BuscarServicio(IDS);
    if ( (SuperUsuario <> nil) and SuperUsuario.Comprueba(ClaveSup) and
         (Servicio <> nil)) Then
      Begin
        Result := TRUE;
        Sentencia := TSQLQuery.Create(Self);
        Sentencia.SQLConnection := BaseDatos;

        { TODO -oran -ctransacciones : Ver tema session }

        Sentencia.Close;
        Sentencia.SQL.Add('UPDATE TSERVIC SET NOMBRE = :Nombre WHERE IDSERVICIO = :SID');
        Sentencia.Params[0].AsString := Nombre;
        Sentencia.PArams[1].AsInteger := IDS;
        Try
            Sentencia.ExecSQL;
        Except
            Result := FALSE;
        End;
        if Result Then
            Servicio.Rellenar(IDS,Nombre);
      End
    Else
        Result := False;
End;

Function TGestorSeg.AsociarUsuarioGrupo(IDU,IDG: Integer; ClaveSup:String): Boolean;
Var
    Sentencia: TSQLQuery;
    Grps: TSetInt;
    Usuario: TUsuario;
    Grupo: TGrupo;
Begin
    Usuario := BuscarUsuario(IDU);
    Grupo := BuscarGrupo(IDG);
    if (Usuario <> nil) Then Usuario.ObtenerGrupos(Grps);
    if ( (SuperUsuario <> nil) and SuperUsuario.Comprueba(ClaveSup) and
         (Usuario <> nil) and (Grupo <> nil)) Then
      Begin
        Result := TRUE;

        { Si ya pertanece al grupo no se hace nada }
        if (IDG in Grps) Then exit;

        Sentencia := TSQLQuery.Create(Self);
        Sentencia.SQLConnection := BaseDatos;

        { TODO -oran -ctransacciones : Ver tema session }

        Sentencia.Close;
        Sentencia.SQL.Add('INSERT INTO TCOMPON (IDGRUPO,IDUSUARIO) VALUES (:IDG,:IDU)');
        Sentencia.Params[0].AsInteger := IDG;
        Sentencia.Params[1].AsInteger := IDU;
        Try
            Sentencia.ExecSQL;
        Except
            Result := FALSE;
        End;
        if Result Then
        Begin
            Usuario.AniadirGrupo(IDG);
            Grupo.AniadirUsuario(IDU)
        End;
      End
    Else
        Result := False;

End;

Function TGestorSeg.AsociarUsuarioServicio(IDU,IDS: Integer; ClaveSup: String): Boolean;
Var
    Sentencia: TSQLQuery;
    Servicio: TServicio;
    Usuario: TUsuario;
    Usrs: TSetInt;
Begin
    Servicio := BuscarServicio(IDS);
    Usuario := BuscarUsuario(IDU);
    If (Servicio <> nil) Then Servicio.ObtenerUsuarios(Usrs);
    if ( (SuperUsuario <> nil) and SuperUsuario.Comprueba(ClaveSup) and
         (Servicio <> nil) and (Usuario <> nil) and not (IDU in Usrs)) Then
      Begin
        Result := TRUE;
        if (IDU in Usrs) Then exit;
        Sentencia := TSQLQuery.Create(Self);
        Sentencia.SQLConnection := BaseDatos;

        { TODO -oran -ctransacciones : Ver tema session }

        Sentencia.Close;
        Sentencia.SQL.Add('INSERT INTO TSERVUSR (IDSERVICIO,IDUSUARIO) VALUES (:IDS,:IDU)');
        Sentencia.Params[0].AsInteger := IDS;
        Sentencia.Params[1].AsInteger := IDU;
        Try
            Sentencia.ExecSQL;
        Except
            Result := FALSE;
        End;
        if Result Then
                Servicio.AniadirUsuario(IDU);
      End
    Else
        Result := False;

End;

Function TGestorSeg.AsociarGrupoServicio(IDG,IDS: Integer; ClaveSup:String): Boolean;
Var
    Sentencia: TSQLQuery;
    Servicio: TServicio;
    Grupo: TGrupo;
    Grps: TSetInt;
Begin
    Servicio := BuscarServicio(IDS);
    Grupo := BuscarGrupo(IDG);
    if (Servicio <> nil) Then Servicio.ObtenerGrupos(Grps);
    if ( (SuperUsuario <> nil) and SuperUsuario.Comprueba(ClaveSup) and
         (Servicio <> nil) and (Grupo <> nil) ) Then
      Begin
        Result := TRUE;
        if (IDG in Grps) Then exit;
        Sentencia := TSQLQuery.Create(Self);
        Sentencia.SQLConnection := BaseDatos;

        { TODO -oran -ctransacciones : Ver tema session }

        Sentencia.Close;
        Sentencia.SQL.Add('INSERT INTO TSERVGRP (IDSERVICIO,IDGRUPO) VALUES (:IDS,:IDG)');
        Sentencia.Params[0].AsInteger := IDS;
        Sentencia.Params[1].AsInteger := IDG;
        Try
            Sentencia.ExecSQL;
        Except
            Result := FALSE;
        End;
        if Result Then
            Servicio.AniadirGrupo(IDG);
      End
    Else
        Result := False;

End;

Function TGestorSeg.DAsociarUsuarioGrupo(IDU,IDG: Integer; ClaveSup:String): Boolean;
Var
    Sentencia: TSQLQuery;
    Grps: TSetInt;
    Usuario: TUsuario;
    Grupo: TGrupo;
Begin
    Usuario := BuscarUsuario(IDU);
    Grupo := BuscarGrupo(IDG);
    if (Usuario <> nil) Then Usuario.ObtenerGrupos(Grps);
    if ( (SuperUsuario <> nil) and SuperUsuario.Comprueba(ClaveSup) and
         (Usuario <> nil) and (Grupo <> nil) ) Then
      Begin
        Result := TRUE;
        if not (IDG in Grps) Then exit;
        Sentencia := TSQLQuery.Create(Self);
        Sentencia.SQLConnection := BaseDatos;

        { TODO -oran -ctransacciones : Ver tema session }

        Sentencia.Close;
        Sentencia.SQL.Add('DELETE FROM TCOMPON WHERE IDGRUPO = :IDG AND IDUSUARIO = :IDU');
        Sentencia.Params[0].AsInteger := IDG;
        Sentencia.Params[1].AsInteger := IDU;
        Try
            Sentencia.ExecSQL;
        Except
            Result := FALSE;
        End;
        if Result Then
        Begin
            Usuario.QuitarGrupo(IDG);
            Grupo.QuitarUsuario(IDU)
        End;
      End
    Else
        Result := False;

End;

Function TGestorSeg.DAsociarUsuarioServicio(IDU,IDS: Integer; ClaveSup: String): Boolean;
Var
    Sentencia: TSQLQuery;
    Servicio: TServicio;
    Usuario: TUsuario;
    Usrs: TSetInt;
Begin
    Servicio := BuscarServicio(IDS);
    Usuario := BuscarUsuario(IDU);
    If (Servicio <> nil) Then Servicio.ObtenerUsuarios(Usrs);
    if ( (SuperUsuario <> nil) and SuperUsuario.Comprueba(ClaveSup) and
         (Servicio <> nil) and (Usuario <> nil) ) Then
      Begin
        Result := TRUE;
        if not (IDU in Usrs) Then exit;
        Sentencia := TSQLQuery.Create(Self);
        Sentencia.SQLConnection := BaseDatos;

        { TODO -oran -ctransacciones : Ver tema session }

        Sentencia.Close;
        Sentencia.SQL.Add('DELETE FROM TSERVUSR WHERE IDSERVICIO = :IDS AND IDUSUARIO = :IDU');
        Sentencia.Params[0].AsInteger := IDS;
        Sentencia.Params[1].AsInteger := IDU;
        Try
            Sentencia.ExecSQL;
        Except
            Result := FALSE;
        End;
        if Result Then
                Servicio.QuitarUsuario(IDU);
      End
    Else
        Result := False;

End;

Function TGestorSeg.DAsociarGrupoServicio(IDG,IDS: Integer; ClaveSup:String): Boolean;
Var
    Sentencia: TSQLQuery;
    Servicio: TServicio;
    Grupo: TGrupo;
    Grps: TSetInt;
Begin
    Servicio := BuscarServicio(IDS);
    Grupo := BuscarGrupo(IDG);
    if (Servicio <> nil) Then Servicio.ObtenerGrupos(Grps);
    if ( (SuperUsuario <> nil) and SuperUsuario.Comprueba(ClaveSup) and
         (Servicio <> nil) and (Grupo <> nil) ) Then
      Begin
        Result := TRUE;
        if not (IDG in Grps) Then exit;
        Sentencia := TSQLQuery.Create(Self);
        Sentencia.SQLConnection := BaseDatos;

        { TODO -oran -ctransacciones : Ver tema session }

        Sentencia.Close;
        Sentencia.SQL.Add('DELETE FROM TSERVGRP WHERE IDSERVICIO = :IDS AND IDGRUPO = :IDG');
        Sentencia.Params[0].AsInteger := IDS;
        Sentencia.Params[1].AsInteger := IDG;
        Try
            Sentencia.ExecSQL;
        Except
            Result := FALSE;
        End;
        if Result Then
            Servicio.QuitarGrupo(IDG);
      End
    Else
        Result := False;

End;

Function TGestorSeg.ObtenerNIDU: Integer;
Var
    Sentencia : TsqlQuery;
Begin
    Sentencia := TSQLQuery.Create(Self);
    Sentencia.Close;
    Sentencia.SQLConnection := BaseDatos;

    { TODO -oran -ctransacciones : Ver tema session }

    Sentencia.SQL.Add('SELECT MAX(IDUSUARIO) FROM TUSUARIO');
    Sentencia.Open;
    if (Sentencia.EOF) Then
        Result := 1
    else
        Result := 1 + Sentencia.Fields[0].AsInteger;
End;

Function TGestorSeg.ObtenerNIDG: Integer;
Var
    Sentencia : TsqlQuery;
Begin
    Sentencia := TSQLQuery.Create(Self);
    Sentencia.Close;
    Sentencia.SQLConnection := BaseDatos;

    { TODO -oran -ctransacciones : Ver tema session }

    Sentencia.SQL.Add('SELECT MAX(IDGRUPO) FROM TGRUPOS');
    Sentencia.Open;
    if (Sentencia.EOF) Then
        Result := 1
    else
        Result := 1 + Sentencia.Fields[0].AsInteger;
End;

Function TGestorSeg.ObtenerNIDS: Integer;
Var
    Sentencia : TSQLQuery;
Begin
    Sentencia := TSQLQuery.Create(Self);
    Sentencia.Close;
    Sentencia.SQLConnection := BaseDatos;

    { TODO -oran -ctransacciones : Ver tema session }

    Sentencia.SQL.Add('SELECT MAX(IDSERVICIO) FROM TSERVIC');
    Sentencia.Open;
    if (Sentencia.EOF) Then
        Result := 1
    else
        Result := 1 + Sentencia.Fields[0].AsInteger;
End;

{**************************************************************************************
 *                                                                                    *
 *                       M i e m b r o s    P r o t e g i d o s                       *
 *                                                                                    *
 **************************************************************************************}

Function TGestorSeg.BuscarUsuario(IDU: Integer): TUsuario;
Var
i: Integer;
Usuario: TUsuario;
Begin
i := 0;
Result := nil;
while (i < UsuariosBD.Count) do
  Begin
    Application.ProcessMessages;
    Usuario := UsuariosBD.Items[i];
    if (Usuario <> nil ) then
      if (Usuario.ObtenerUID = IDU) then
        begin
          Result := Usuario;
          exit
        end;
      inc(i);
    End;
End;

Function TGestorSeg.BuscarServicio(IDS: Integer): TServicio;
Var
i: Integer;
Servicio: TServicio;
begin
i := 0;
result := nil;
while (i < ServiciosBD.Count) do
  begin
    Application.ProcessMessages;
    Servicio := ServiciosBD.Items[i];
    if ( Servicio <> nil ) then
      if (Servicio.ObtenerSID = IDS) then
        begin
          Result := Servicio;
          exit;
        end;
      inc(i);
  end;
end;


function TGestorSeg.BuscarGrupo(IDG: Integer): TGrupo;
var
i: Integer;
Grupo: TGrupo;
begin
i := 0;
result := nil;
while ( (i < GruposBD.Count)) do
  begin
    Application.ProcessMessages;
    Grupo := GruposBD.Items[i];
    if ( Grupo <> nil ) then
      if (Grupo.ObtenerGID = IDG) then
        begin
          Result := Grupo;
          exit
        end;
      inc(i);
  end;
end;


end.
