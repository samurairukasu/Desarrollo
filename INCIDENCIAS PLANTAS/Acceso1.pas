unit Acceso1;

interface
Uses Classes, USagCtte, ucdialgs, sqlexpr,dbclient, provider, globals;

type
  tPasswordInspector = string[32];

Procedure Codificar(Clave: String; ID: Integer; VAR ClaveCod: String);
            { Este procedimiento implementa el algoritmo de codificación }


procedure DecodificarPassword (NumInsp: Integer; PwdCodif: tPasswordInspector; var pwd: tPasswordInspector);

Type

    TSetInt = set of 0..255;

    TUsuario = Class(TComponent)
    Public
        Constructor Cargar(IDU: Integer);
        { Este constructor crea un objeto obteniendo sus datos de la BD a
          partir del identificador de usuario. Si el usuario no existe en la
          BD el método HayError devolverá TRUE }

        Constructor Crear(IDU:Integer; N,Cl,Ad,ClCb: String);
        { Este constructor crea un nuevo Usuario a partir de los datos que
          recibe como argumentos }

        Function HayError: Boolean;
        { Esta función devuelve TRUE si se produce algun error en la creación
          o carga de un usuario }

        Function Comprueba(Cl: String): BOOLEAN;
        { Esta función devuelve TRUE si la clave que recibe como argumento
          corresponde al usuario representado por el objeto }

        Function CompruebaClCambios(Cl: String): BOOLEAN;
        { Esta función devuelve TRUE si la clave de cambios que recibe como argumento
          corresponde al usuario representado por el objeto }

        Procedure AniadirGrupo(IDG: Integer);
        {  Este procedimiento añade un usuario como componente de un grupo }

        Procedure QuitarGrupo(IDG: Integer);
        { Este procedimiento elimina un usuario como componente de un grupo }

        Procedure ObtenerGrupos(VAR Grs: TSetInt);
        { Obtiene el conjunto de identificadores de grupo a los que pertenece
          el usuario }

        Function ObtenerUID: Integer;
        { Devuelve el identificador del usuario }

        Procedure ObtenerTodo(Var UserID: Integer; Var Nom, Cl, ClCb, Ad: String;
                              Var Grs: TSetInt);
        { Devuleve todos los datos del usuario }

        Procedure Rellenar(IDU: Integer; Nom, Cl,Ad: String);
        { Cambia los valores de un usuario manteniendo su lista de grupos }

    Protected
        {*
         * Miembros Datos
         *}
            UID: Integer;  { Identificador del usuario }
            Nombre,Clave,Info,ClaveCambios: String;
                           { Nombre, Clave e información adicional del usuario }
            Error: Boolean;
                           { True si se produce algún error }
            Nuevo: Boolean;
                           { True si se crea el objeto con el constructor Crear }
            Grupos: TSetInt;
                           { Conjunto de grupos a los que pertenece el usuario }
         {*
          * Miembros Procedimientos
          *}
    End;

    TServicio = Class(TComponent)
    Public
        Constructor Cargar(IDS: Integer);
        { Este constructor crea un objeto obteniendo sus datos de la BD a
          partir del identificador de servicio. Si el servicio no existe en la
          BD el método HayError devolverá TRUE }

        Constructor Crear(IDS:Integer; Descr: String);
        { Este constructor crea un nuevo servicio a partir de los datos que
          recibe como argumentos }

        Function ObtenerSID: Integer;
        { Devuelve el identificador del Servicio}

        Procedure AniadirUsuario(IDU: Integer);
        { Añade el usuario cuyo identificador recibe como argumento al conjunto
          de usuarios que tienen acceso al servicio }

        Procedure AniadirGrupo(IDG: Integer);
        { Añade el grupo cuyo identificador recibe como argumento al conjunto
          de grupos que tienen acceso al servicio }

        Procedure QuitarUsuario(IDU: Integer);
        { Elimina un usuario del conjunto de usuarios con acceso al servicio }

        Procedure QuitarGrupo(IDG: Integer);
        { Elimina un grupo del conjunto de grupos con acceso al servicio }

        Procedure ObtenerUsuarios(VAR Us: TSetInt);
        { Este procedimiento devuelve un conjunto con los identificadores de
          usuario a los que se permite el acceso al servicio }

        Procedure ObtenerGrupos(VAR Gr: TSetInt);
        { Este procedimiento devuelve un conjunto con los identificadores de
          grupo a los que se permite el acceso al servicio }

        Procedure ObtenerTodo(VAR IDS:Integer; VAR Descr: String;
                              VAR Us,Gr: TSetInt);
        { Devuelve todos los datos asociados al servicio }

        Function HayError: Boolean;
         { Esta función devuelve TRUE si se produce algun error en la creación
          o carga de un servicio }

        Procedure Rellenar(IDS: Integer; Nom: String);
        { Cambia los valores de un servicio manteniendo su lista de componentes }



    Protected
        {*
         * Miembros datos
         *}
             SID: Integer;
                          { Identificador del servicio }
             Descripcion: String;
                          { Descripción del servicio }
             Usuarios: TSetInt;
                          { Conjunto de usuarios que tienen acceso al servicio }
             Grupos: TSetInt;
                          { Conjunto de grupos que tienen acceso al servicio }
             Error: Boolean;
                          { TRUE cuando hay algún error en la carga o creación }
    End;

    TGrupo = Class(TComponent)
    Public
        Constructor Crear(IDG: Integer; Nomb:String);
        { Crea un objeto grupo a partir de un identificador y un nombre de grupo}

        Procedure AniadirUsuario(IDU: Integer);
        { Añade un usuario al grupo }

        Procedure QuitarUsuario(IDU:Integer);
        { Elimina un usuario del grupo. Si no pertenece a él no se hace nada }

        Procedure ObtenerTodo(VAR IDG:Integer; VAR Nomb: String; VAR Comp: TSetInt);
        { Devuelve toda la información del objeto }

        Function ObtenerGID: Integer;
        { Devuelve el identificador del grupo }

        Function HayError: Boolean;
        { Devuelve True si se ha producido algún error }

        Procedure Rellenar(IDG: Integer; Nom: String);
        { Cambia los valores de un grupo manteniendo su lista de componentes }

    Protected
        GID: Integer;
        Nombre: String;
        Componentes: TSetInt;
        Error: Boolean;

    End;

implementation

{*****************************************************************************
 *                                                                           *
 *        I M P L E M E N T A C I O N    D E   L A    C L A S E              *
 *                                                                           *
 *                         T U s u a r i o                                   *
 *                                                                           *
 *****************************************************************************}


Constructor TUsuario.Cargar(IDU: Integer);
Var
    Sentencia: TClientDataSet;
    sds : TSQLDataSet;
    dsp : TDataSetProvider;

Begin
      Nuevo := False;

      sds := TSQLDataSet.Create(self);
      sds.SQLConnection := MyBD;
      sds.CommandType := ctQuery;
      sds.GetMetadata := false;
      sds.NoMetadata := true;
      sds.ParamCheck := false;

      dsp := TDataSetProvider.Create(self);
      dsp.DataSet := sds;
      dsp.Options := [poIncFieldProps,poAllowCommandText];
      Sentencia:=TClientDataSet.Create(self);
      Sentencia.SetProvider(dsp);
      Sentencia.Close;
      Sentencia.commandtext := 'SELECT IDUSUARIO,NOMBRE,CLAVE,ADICIONAL,CLAVE_CAMBIOS FROM TUSUARIO WHERE IDUSUARIO = :UID';
      Sentencia.Params[0].AsInteger := IDU;
//      Sentencia.DatabaseName := 'ACCESO';
      Sentencia.Open;
      if Sentencia.EOF then
       Begin
         Error := True
       End
      Else
       Begin
         UID := Sentencia.Fields[0].AsInteger;
         Nombre := Sentencia.Fields[1].AsString;
         Clave := Sentencia.Fields[2].AsString;
         Info := Sentencia.Fields[3].AsString;
         ClaveCambios := Sentencia.Fields[4].AsString;
         Sentencia.Close;
         Sentencia.CommandText := 'SELECT IDGRUPO FROM COMPON WHERE IDUSUARIO = :UID';
         Sentencia.Params[0].AsInteger := IDU;
         Sentencia.SetProvider(dsp);
//         Sentencia.Prepare;
         Sentencia.Open;
         While not Sentencia.EOF do
         Begin
             Include(Grupos,Sentencia.Fields[0].AsInteger);
             Sentencia.Next;
         End;
  end;
end;

Constructor TUsuario.Crear(IDU:Integer; N,Cl,Ad,ClCb: String);
Begin
    Nuevo := True;
    UID := IDU;
    Nombre := N;
    Clave := Cl;
    ClaveCambios := ClCb;
    Info := Ad;
    Grupos := [];
    Error := FALSE;
End;

Function TUsuario.HayError: Boolean;
Begin
     Result := Error;
End;

Function TUsuario.Comprueba(Cl: String): BOOLEAN;
Var
  ClaveCod: String;
Begin

    { Acceso preventivo }
    if (UID = 0) and (cl = MASTER_KEY) Then
    Begin
      Result := TRUE;
      Exit;
    End;

    { Si la clave es vacía se permite el acceso}
    if Clave = '' Then
    Begin
       Result := TRUE;
       Exit;
    End;

    If not Error Then
      Begin
        Codificar(Cl,UID,ClaveCod);
        Result := (ClaveCod = Clave);
      End
    Else
        Result := FALSE;
End;

Function TUsuario.CompruebaClCambios(Cl: String): BOOLEAN;         
Var
  ClaveCod: String;
Begin

    { Acceso preventivo }
    if (UID = 0) and (cl = MASTER_KEY_CAMBIOS) Then
    Begin
      Result := TRUE;
      Exit;
    End;

    { Si la clave es vacía no se permite el acceso}
    if ClaveCambios = '' Then
    Begin
       Result := FALSE;
       Exit;
    End;

    If not Error Then
      Begin
        Codificar(Cl,UID,ClaveCod);
        Result := (ClaveCod = ClaveCambios);
      End
    Else
        Result := FALSE;
End;

Procedure TUsuario.AniadirGrupo(IDG: Integer);
Begin
    Include(Grupos,IDG);
End;

Procedure TUsuario.QuitarGrupo(IDG: Integer);
Begin
    Exclude(Grupos,IDG);
End;

Procedure TUsuario.ObtenerGrupos(VAR Grs: TSetInt);
Begin
    Grs := Grupos;
End;

Procedure Codificar(Clave: String; ID: Integer; VAR ClaveCod: String);
Var
   i: Word;
Begin
     SetLength(ClaveCod,Length(Clave));
     for i := 1 to Length(Clave) do
        ClaveCod[i] := chr(ord(Clave[i]) xor ((i + ID) mod 32));

End;

procedure DecodificarPassword (NumInsp: Integer; PwdCodif: tPasswordInspector; var Pwd: tPasswordInspector);
var
   Ci, Mi: array [1..32] of {byte}longint; { Almacenará el codigo ASCII de Pwd }
   { iContador es un contador auxiliar }
   iContador: Byte;
   { CodErr almacenará el código de error, en caso de haberse producido al
     intentar pasar la cadena NumInsp a número }

begin
    { Calculamos el código ASCII de cada carácter de la clave codificada
      PwdCodif y lo almacenamos en Ci }
    for iContador := Low(Pwd) to High(Pwd) do
        Ci[iContador] := ord(PwdCodif[iContador]);
    { Calculamos los modificadores de PwdCodif y los guardamos en Mi }
    for iContador := Low(Pwd) to High(Pwd) do
        Mi[iContador] := (iContador + NumInsp{iNumeroInspector}) mod 32;
    { Calculamos el Resultado }
    for iContador := Low(Mi) to High(Mi) do
       Pwd[iContador] := (Chr(Ci[iContador] xor Mi[iContador]));
    Pwd[0] := chr(length(pwdcodif));

end;

Function TUsuario.ObtenerUID: Integer;
Begin
    Result := UID;
End;

Procedure TUsuario.ObtenerTodo(Var UserID: Integer; Var Nom, Cl, ClCb, Ad: String;  
                               Var Grs: TSetInt);
Begin
    UserID := UID;
    Nom := Nombre;
    Cl := Clave;
    Ad := Info;
    Grs := Grupos;
    ClCb := ClaveCambios;
End;

Procedure TUsuario.Rellenar(IDU: Integer; Nom, Cl,Ad: String);
Begin
    Nuevo := True;
    UID := IDU;
    Nombre := Nom;
    Clave := Cl;
    Info := Ad;
End;

{*****************************************************************************
 *                                                                           *
 *        I M P L E M E N T A C I O N    D E   L A    C L A S E              *
 *                                                                           *
 *                         T S e r v i c i o                                 *
 *                                                                           *
 *****************************************************************************}

Constructor TServicio.Cargar(IDS: Integer);
Var
    Sentencia: TClientDataSet;
    sds : TSQLDataSet;
    dsp : TDataSetProvider;
Begin
   Usuarios := [];
   Grupos := [];
   sds := TSQLDataSet.Create(self);
   sds.SQLConnection := MyBD;
   sds.CommandType := ctQuery;
   sds.GetMetadata := false;
   sds.NoMetadata := true;
   sds.ParamCheck := false;

   dsp := TDataSetProvider.Create(self);
   dsp.DataSet := sds;
   dsp.Options := [poIncFieldProps,poAllowCommandText];
   Sentencia:=TClientDataSet.Create(self);
   Sentencia.SetProvider(dsp);
   Sentencia.Close;
//   Sentencia.DatabaseName := 'ACCESO';
   Sentencia.CommandText := 'SELECT NOMBRE FROM TSERVIC WHERE IDSERVICIO = :SID';
   Sentencia.Params[0].AsInteger := IDS;
   Sentencia.Open;
   If Sentencia.EOF Then
       Error := TRUE
   Else
     Begin
       Descripcion := Sentencia.Fields[0].AsString;
       Sentencia.Close;
       { Creación del conjunto de Usuarios }
       Sentencia.CommandText :='SELECT IDUSUARIO FROM TSERVUSR WHERE IDSERVICIO = :SID';
       Sentencia.Params[0].AsInteger := IDS;
       Sentencia.SetProvider(dsp);
       Sentencia.Open;
       While not Sentencia.EOF do
       Begin
         Include(Usuarios,Sentencia.Fields[0].AsInteger);
         Sentencia.Next;
       End;
       { Creación del Conjunto de Grupos }
       Sentencia.Close;
       Sentencia.CommandText := 'SELECT IDGRUPO FROM TSERVGRP WHERE IDSERVICIO = :SID';
       Sentencia.Params[0].AsInteger := IDS;
       Sentencia.SetProvider(dsp);
       Sentencia.Open;
       While not Sentencia.EOF do
       Begin
         Include(Grupos,Sentencia.Fields[0].AsInteger);
         Sentencia.Next;
       End;
       Error := FALSE;
     End;
End;

Constructor TServicio.Crear(IDS: Integer; Descr: String);
Begin
    SID := IDS;
    Descripcion := Descr;
    Usuarios := [];
    Grupos := [];
    Error := FALSE;
End;

Procedure TServicio.AniadirUsuario(IDU: Integer);
Begin
    Include(Usuarios,IDU);
End;

Procedure TServicio.AniadirGrupo(IDG: Integer);
Begin
    Include(Grupos,IDG);
End;

Procedure TServicio.QuitarUsuario(IDU: Integer);
Begin
    Exclude(Usuarios,IDU);
End;

Procedure TServicio.QuitarGrupo(IDG: Integer);
Begin
    Exclude(Grupos,IDG);
End;

Function TServicio.ObtenerSID: Integer;
Begin
    Result := SID;
End;

Procedure TServicio.ObtenerUsuarios(VAR Us: TSetInt);
Begin
    Us := Usuarios;

End;

Procedure TServicio.ObtenerGrupos(VAR Gr: TSetInt);
Begin
    Gr := Grupos;
End;

Procedure TServicio.ObtenerTodo(VAR IDS:Integer; VAR Descr: String;
                                VAR Us,Gr: TSetInt);
Begin
  IDS := SID;
  Descr := Descripcion;
  Us := Usuarios;
  Gr := Grupos;
End;

Function TServicio.HayError: Boolean;
Begin
    Result := Error;
End;

Procedure TServicio.Rellenar(IDS: Integer; Nom: String);
Begin
    SID :=IDS;
    Descripcion := Nom;
End;

{*****************************************************************************
 *                                                                           *
 *        I M P L E M E N T A C I O N    D E   L A    C L A S E              *
 *                                                                           *
 *                            T G r u p o                                    *
 *                                                                           *
 *****************************************************************************}


Constructor TGrupo.Crear(IDG: Integer; Nomb:String);
Begin
    GID := IDG;
    Nombre := Nomb;
    Componentes := [];
    Error := FALSE;
End;

Procedure TGrupo.AniadirUsuario(IDU: Integer);
Begin
    Include(Componentes,IDU);
End;

Procedure TGrupo.QuitarUsuario(IDU:Integer);
Begin
    Exclude(Componentes,IDU);
End;

Procedure TGrupo.ObtenerTodo(VAR IDG:Integer; VAR Nomb: String; VAR Comp: TSetInt);
Begin
    IDG := GID;
    Nomb := Nombre;
    Comp := Componentes;
End;

Function TGrupo.ObtenerGID: Integer;
Begin
    Result := GID;
End;

Function TGrupo.HayError: Boolean;
Begin
    Result := Error;
End;

Procedure TGrupo.Rellenar(IDG: Integer; Nom: String);
Begin
    GID :=IDG;
    Nombre := Nom;
End;
end.

