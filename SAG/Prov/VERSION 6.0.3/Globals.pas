unit Globals;

interface

    uses
        SQLEXPR, Messages, DBXpress, Provider, dbclient, USagVarios, DB, ADODB;


    Const
        WM_LINEAINSP = WM_USER+10;
        WM_SERVIMPRE = WM_USER+11;
        WM_LINEAINSPGNC = WM_USER+12;

    Threadvar
       MyBD : TSqlConnection;
       BDAG: TSQLConnection;
       TD: TTransactionDesc;
       BDPADRON : TSqlConnection;
//       MyTraza: TSQLMonitor;


    var
      datos_tarjetatarjeta:string;
      datos_tarjetanumero:string;
      datos_tarjetacodigo:string;
      datos_tarjetavencimiento:string;
      datos_tarjetacuotas:string;
      datos_tarjetacodtarjeta:string;
      datos_tarjetausa:longint;



        TipoEquipo : string;
        CODFACT_NC:LONGINT;
        DirectorioIn :string;
        DirectorioOut :string;
        fVarios: TVarios;
        Cursores: Integer;
        MaxCursores: Integer;
        cierrezok: boolean;
        VerEurosystem: string;
        VerSO: String;
        DBAliasSql : string;
        sEsCaja: Integer;
        //MARTIN 21/12/2012 SIRVER PARA QUE NO SE INGRESEN
        // DOS VECES LA MATRICULA
        CONTROL_MATRICULA:STRING;
        IDUSUARIO_ALERTAS:LONGINT;
        dsp_user_tab_columns : TDataSetProvider;
        dsp_user_ind_columns : TDataSetProvider;
        dsp_user_sequences : TDataSetProvider;

        cds_user_tab_columns : TSQLDataSet;
        cds_user_ind_columns : TSQLDataSet;
        cds_user_sequences : TSQLDataSet;
        IMPRIMI_NC_POR_CF:STRING;
        TUser_Tab_Columns : TClientDataSet;
        TUser_Ind_Columns : TClientDataSet;
        TUser_Sequences : TClientDataSet;

        ADOConexion: TADOConnection;

        ID_USUARIO_LOGEO_SAG:LONGINT;
        LEYENDA_RESOLUCION_ENTE_COMBI_1:STRING;
        IMPRIME_LEYENDA_ENTE_COMBI:BOOLEAN;
        LEYENDA_RESOLUCION_ENTE_COMBI_2:string;

    procedure TestOfDirectories;
    procedure TestOfLicencia;
    procedure TestOfBD(Alias, UserName, Password: String; Ageva: boolean);
    procedure TestOfBugs;
    procedure TestOfTerminal;
    procedure InitAplicationGlobalTables;
    procedure FinishAplicationGlobalTables;
    Function LeerVersion: String;
    procedure LiberarMemoria;

//**************************************************************************************************
    Function ConectarMAHA: Boolean;
    Function ExisteEnMAHA(vMatricula: String): Boolean;
//**************************************************************************************************






implementation

    uses
        Forms,
        FileCtrl,
        Windows,
        SysUtils,
        ULOGS,
        UCHECSM,
        UVERSION,
        UPROTECT,
        UCDIALGS,
        UtilOracle,
        USUPERREGISTRY,
        ugacceso,
        usagctte;

    const
        FILE_NAME = 'GLOBALS.PAS';


    procedure InitError(Msg: String);
    begin
        MessageDlg('Error en la Inicializaci�n',Msg,mtError,[mbOK],mbOK,0);
        if Assigned(fAnomalias)
        then fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FILE_NAME,Msg);
        InitializationError := TRUE;
        Application.Terminate;
    end;



//*************************************** Conexion MAHA  *******************************************
Function ConectarMAHA: Boolean;
var
  varConexion: string;
begin
Result:=False;
varConexion := 'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Password=;Initial Catalog=maha_eurosystem;Data Source='+DBAliasSQL ;
ADOConexion := TADOConnection.Create(nil);
ADOConexion.Close;
ADOConexion.CommandTimeout := 30;
ADOConexion.ConnectionTimeout := 15;
ADOConexion.CursorLocation := clUseClient;
ADOConexion.IsolationLevel := ilCursorStability;
ADOConexion.LoginPrompt := False;
ADOConexion.ConnectionString := varConexion;
  try
    ADOConexion.Open;
    Result:=True;
  except
    on E:Exception do
    begin
      FAnomalias.PonAnotacion (TRAZA_SIEMPRE,9,FICHERO_ACTUAL,'Error en la conecci�n al servidor de sql server: ' + E.Message);
      ShowMessage(Application.Title,'Error en la conecci�n al servidor de sql server.');
    end;
  end;
end;


Function ExisteEnMAHA(vMatricula: String): Boolean;
Begin
Result:=False;
If ConectarMAHA then
  Begin
    With TADOQuery.Create(Application) do
      Begin
        Connection:= ADOConexion;
        Active:=false;
        try
          SQL.Clear;
          SQL.Add(format('SELECT * FROM  MAHA_USER.MAHA_MAIN_DATAS WHERE offene_pruefung = ''J''  AND (kennzeichen =''%s'')',[vMatricula])) ;
          Open;
          If (RecordCount>=1) then
          begin
            MessageDlg('PLANTA DE VERIFICACION','ERROR: EL VEHICULO YA EXISTE EN LA LINEA DE INSPECCION.', mtWarning,[mbOk], mbOk,0);
            Result:=True;
          end;
        except
          on E:Exception do
            begin
              FAnomalias.PonAnotacion (TRAZA_SIEMPRE,9,FICHERO_ACTUAL,'Error en la coNsulta de MAHA: '+ E.Message);
              ShowMessage(Application.Title,'Error en la coNsulta de MAHA.');
            end;
        end;
      Free;
      end;
  end;
end;
//**************************************************************************************************


Function LeerVersion: String;
Begin
with TSuperRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(VERSION_KEY) then
      Begin
      VerSO:=ReadString('CurrentVersion');
      Result:=VerSO;
      end;
  Finally
    free;
  end;
end;

procedure LiberarMemoria;
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
    SetProcessWorkingSetSize(GetCurrentProcess, $FFFFFFFF, $FFFFFFFF);
end;


    procedure TestOfBugs;
    begin
        if not FileFreeOfBugs(Application.ExeName)
        then begin
            {$IFDEF WITHBUGS}
            InitError('El fichero est� contaminado por bugs bunnie.')
            {$ENDIF}
        end
    end;

    procedure TestOfLicencia;
    var
        sLicencia : string;
    begin
        sLicencia := '';
        with TSuperRegistry.Create do
        try
            RootKey := HKEY_LOCAL_MACHINE;

            if not OpenKeyRead(LICENCIA_KEY) then
              InitError('No se encontraron los par�metros de licencia del programa.')
            else
              begin
                try
                  {$IFDEF SERVIDORES}
                  sLicencia := ReadString(LICENCIA_SERV);
                  if not HayLicencia(sLicencia,lServidor)
                  {$ENDIF}

                  {$IFDEF APLICACION}
                  sLicencia := ReadString(LICENCIA_APP);
                  if not HayLicencia(sLicencia,lAplicacion)
                  {$ENDIF}
                  then
                    begin
                      {$IFDEF WITHLICENCE}
                    InitError('El fichero est� contaminado por bugs externos.')
                     {$ENDIF}
                   end;
                except
                    InitError('No se encontr� en el registro alg�n par�metro necesario para la comprobaci�n de licencias.');
                end
            end;
        finally
            Free;
        end;
    end;


    procedure TestOfBD(Alias, UserName, Password: String; Ageva: boolean);
    var
        DBAlias, DBUserName, DBPassword, DBAlias2, DBUserName2, DBPassword2,
        DBAlias3, DBUserName3, DBPassword3,
        DBDriverName, DBLibraryName, DBVendorLib, DBGetDriverFunc: String;
    const
  coEnableBCD = TSQLConnectionOption(102); // boolean
    begin
        with TSuperRegistry.Create do
        try
            RootKey := HKEY_LOCAL_MACHINE;

            if not OpenKeyRead(BD_KEY)
            then InitError('No se encontraron los par�metros de conexi�n a la base de datos')
            else begin
                try
                    If Alias=''
                    then
                        DBAlias := ReadString(ALIAS_)
                    Else
                        DBAlias:=Alias;

                    //SQL SERVER
                      DBAliasSql:=ReadString(ALIAS_sql);
                     // DBAliasSql:=:= ReadString(ALIAS_)
                    //  DBAliasSql:='SERVER-AZUL';

                    If UserName=''
                    then
                        DBUserName := ReadString(USER_)
                    else
                        DBUserName:=UserName;

                    If Password=''
                    then
                        DBPassword := ReadString(PASSWORD_)
                    else
                        DBPassword:=Password;

                    DBDriverName := ReadString(DRIVERNAME_);
                    DBLibraryName := ReadString(LIBRARYNAME_);
                    DBVendorLib := ReadString(VENDORLIB_);
                    DBGetDriverFunc := ReadString(GETDRIVERFUNC_);

                    DBAlias2:='';
                    DBUserName2:='';
                    DBPassword2:='';
                    DBAlias3:='';
                    DBUserName3:='';
                    DBPassword3:='';
                    try
                      DBAlias2 := ReadString(ALIAS2_);
                      DBUserName2 := ReadString(USER2_);
                      DBPassword2 := ReadString(PASSWORD2_);
                      DBAlias3 := ReadString(ALIAS3_);
                      DBUserName3 := ReadString(USER3_);
                      DBPassword3 := ReadString(PASSWORD3_);
                    except

                    end;

                except
                    InitError('No se encontr� en el registro alg�n par�metro necesario para la conexi�n a la base de datos');
                    exit;
                end;


                MyBD := TSQLConnection.Create(nil);
                with MyBD do
                begin
                   DriverName := DBDriverName;
                   LibraryName := DBLibraryName;
                   VendorLib := DBVendorLib;
                   GetDriverFunc := DBGetDriverFunc;

                   Params.Values['DataBase'] := DBAlias;
                   Params.Values['EnableBCD'] := 'True';
                   Params.Values['User_Name'] := DBUserName;
                   Params.Values['Password'] := DBPassword;
                   LoginPrompt := false;
                   KeepConnection := true;
                end;
                try
                    MyBD.Open;
                    mybd.SQLConnection.SetOption(coEnableBCD, Integer(False));
                except
                    on E: Exception do
                        InitError('No se pudo conectar con la base de datos por: ' + E.message);
                end;

(*                MyTraza := TSQLMonitor.Create(NIL);
                MyTraza.SQLConnection := MyBD;
                MyTraza.FileName := extractfilepath(application.ExeName)+'MyLog.txt';
                MyTraza.AutoSave := True;
                MyTraza.Active := True;*)

                TD.IsolationLevel := xilREADCOMMITTED;
                td.TransactionID := 1;
                td.GlobalID := 0;

                  if (DBAlias2<>'') and (DBUserName2<>'') and (DBPassword2<>'') then
                  if ageva then  //esto se hace para que la primera vez se cree la base ageva, despues no la vuelve a crear
                  begin
                    bdag := TSQLConnection.Create(nil);
                    bdag.DriverName := DBDriverName;
                    bdag.LibraryName := DBLibraryName;
                    bdag.VendorLib := DBVendorLib;
                    bdag.GetDriverFunc := DBGetDriverFunc;
                    bdag.Params.Values['DataBase'] := DBAlias2;
                    bdag.Params.Values['EnableBCD'] := 'True';
                    bdag.Params.Values['User_Name'] := DBUserName2;
                    bdag.Params.Values['Password'] := DBPassword2;
                    bdag.LoginPrompt := false;
                    bdag.KeepConnection := true;
                    try
                        BDAG.Open;
                        bdag.SQLConnection.SetOption(coEnableBCD, Integer(False));                        
                    except
                        on E: Exception do
                            InitError('No se pudo conectar con la base de datos por: ' + E.message);
                    end
                  end;
                  if (DBAlias3<>'') and (DBUserName3<>'') and (DBPassword3<>'') then
                  if ageva then  //esto se hace para que la primera vez se cree la base ageva, despues no la vuelve a crear
                  begin
                    BDPADRON := TSQLConnection.Create(nil);
                    BDPADRON.DriverName := DBDriverName;
                    BDPADRON.LibraryName := DBLibraryName;
                    BDPADRON.VendorLib := DBVendorLib;
                    BDPADRON.GetDriverFunc := DBGetDriverFunc;
                    BDPADRON.Params.Values['DataBase'] := DBAlias3;
                    BDPADRON.Params.Values['EnableBCD'] := 'True';
                    BDPADRON.Params.Values['User_Name'] := DBUserName3;
                    BDPADRON.Params.Values['Password'] := DBPassword3;
                    BDPADRON.LoginPrompt := false;
                    BDPADRON.KeepConnection := true;
                    try
                        BDPADRON.Open;
                        BDPADRON.SQLConnection.SetOption(coEnableBCD, Integer(False));
                    except
                        on E: Exception do
                            InitError('No se pudo conectar con la base de datos por: ' + E.message);
                    end
                  end;
            end
        finally
            Free;
        end;
    end;

    procedure TestOfTerminal;
    begin
        {$IFDEF SAG98}
        with TSuperRegistry.Create do
        try
            RootKey := HKEY_LOCAL_MACHINE;
            if not OpenKeyRead(LICENCIA_KEY)
            then InitError('No se encontraron los par�metros de tipo de terminal del equipo')
            else begin
                try
                    TipoEquipo := ReadString(TIPO_);
                    if (TipoEquipo <> CONSOLA_VALUE) and (TipoEquipo <> SERVIDOR_VALUE) and (TipoEquipo <> SERVICON_VALUE)
                    then TipoEquipo := CONSOLA_VALUE;

                    if OpenKeyRead(CAJA_) then
                      sEsCaja:= ReadInteger(ESCAJA_);

                except
                    InitError('No se encontr� en la configuraci�n del sistema el tipo de servidor.');
                end
            end;
        finally
            Free;
        end;
        {$ENDIF}
        {$IFDEF SERVIDORES}
            TipoEquipo := SERVIDOR_VALUE;
        {$ENDIF}
    end;

    procedure TestOfDirectories;
    begin
        with TSuperRegistry.Create do
        try
            RootKey := HKEY_LOCAL_MACHINE;
            if not OpenKeyRead(IO_KEY)
            then InitError('No se encontraron los par�metros de comunicaci�n con la l�nea de insepcci�n.')
            else begin
                try


                    VerEurosystem := ReadString(VER_EURO_);

                    {$IFDEF SAG98}
                    DirectorioIn := ReadString(ES_IN_);
                    if not DirectoryExists(DirectorioIn)
                    {$ENDIF}

                    {$IFDEF SLG98}
                    DirectorioIn := ReadString(ES_IN_);
                    if not DirectoryExists(DirectorioIn)
                    {$ENDIF}

                    {$IFDEF SAT98}
                    DirectorioIn := ReadString(ES_IN_);
                    if not DirectoryExists(DirectorioIn)
                    {$ENDIF}

                    {$IFDEF SESCRITURA}
                    DirectorioIn := ReadString(ES_IN_);
                    if not DirectoryExists(DirectorioIn)
                    {$ENDIF}

                    {$IFDEF SLECTURA}
                    //DirectorioIn := ReadString(ES_IN_);
                    DirectorioOut := ReadString(ES_OUT_);
                    if not DirectoryExists(DirectorioOut)
                    {$ENDIF}

                    {$IFDEF SIMPRESION}
                    DirectorioIn := ReadString(ES_IN_);
                    if not DirectoryExists(DirectorioIn)
                    {$ENDIF}
                    then if TipoEquipo <> CONSOLA_VALUE
                        then InitError('El directorio temporal '+{$IFDEF SESCRITURA}DirectorioIn{$ENDIF}
                                                                 {$IFDEF SLECTURA}DirectorioOut{$ENDIF}
                                                                 {$IFDEF SAG98}DirectorioIn{$ENDIF}
                                                                 {$IFDEF SLG98}DirectorioIn{$ENDIF}                                                                 
                                                                 {$IFDEF SAT98}DirectorioIn{$ENDIF}
                                                                 {$IFDEF SIMPRESION}DirectorioIN{$ENDIF}+
                                                                 ' no existe');
                except
                    InitError('No se encontr� en el registro la ruta del directorio temporal');
                end
            end
        finally
            Free;
        end
    end;
    


    Procedure InitAplicationGlobalTables;
    begin
    { TODO -oran -creemplazo componentes : Ver si pueden tener el mismo provider }

        cds_user_tab_columns := TSQLDataSet.Create(Application);
        cds_user_ind_columns := TSQLDataSet.Create(Application);
        cds_user_sequences   := TSQLDataSet.Create(Application);

        cds_user_tab_columns.SQLConnection := MyBD;
        cds_user_ind_columns.SQLConnection := MyBD;
        cds_user_sequences.SQLConnection := MyBD;

        cds_user_tab_columns.CommandType := ctQuery;
        cds_user_ind_columns.CommandType := ctQuery;
        cds_user_sequences.CommandType := ctQuery;

        cds_user_tab_columns.GetMetadata := false;
        cds_user_ind_columns.GetMetadata := false;
        cds_user_sequences.GetMetadata := false;

        cds_user_tab_columns.NoMetadata := true;
        cds_user_ind_columns.NoMetadata := true;
        cds_user_sequences.NoMetadata := true;

        cds_user_tab_columns.ParamCheck := false;
        cds_user_ind_columns.ParamCheck := false;
        cds_user_sequences.ParamCheck := false;

        dsp_user_tab_columns := TDataSetProvider.Create(Application);
        dsp_user_tab_columns.DataSet := cds_user_tab_columns;
        dsp_user_tab_columns.Options := [poIncFieldProps,poAllowCommandText];

        dsp_user_ind_columns := TDataSetProvider.Create(Application);
        dsp_user_ind_columns.DataSet := cds_user_ind_columns;
        dsp_user_ind_columns.Options := [poIncFieldProps,poAllowCommandText];

        dsp_user_Sequences := TDataSetProvider.Create(Application);
        dsp_user_Sequences.DataSet := cds_user_sequences;
        dsp_user_Sequences.Options := [poIncFieldProps,poAllowCommandText];



        TUser_Tab_Columns:=TClientDataSet.Create(Application);
        TUser_Ind_Columns:=TClientDataSet.Create(Application);
        TUser_Sequences:=TClientDataSet.Create(Application);

        With TUser_Tab_Columns do
        begin
            SetProvider(dsp_user_tab_columns);
            CommandText := ('SELECT * FROM USER_TAB_COLUMNS ORDER BY TABLE_NAME');
            Open;
        end;
        With TUser_Ind_Columns do
        begin
            SetProvider(dsp_user_ind_columns);
            CommandText := ('SELECT * FROM USER_IND_COLUMNS ORDER BY INDEX_NAME');
            Open;
        end;
        With TUser_Sequences do
        begin
            SetProvider(dsp_user_sequences);
            CommandText := ('SELECT * FROM USER_SEQUENCES');
            Open;
        end;
        fVarios:=TVarios.Create(MyBD);
        fVarios.Open;
        Cursores:=5;
        MaxCursores:=5;
    end;

    Procedure FinishAplicationGlobalTables;
    begin

        if Assigned(TUser_Tab_Columns)
        then begin
            TUser_Tab_Columns.Close;
            TUser_Tab_Columns.Free;
        end;

        if Assigned(TUser_Ind_Columns)
        then begin
            TUser_Ind_Columns.Close;
            TUser_Ind_Columns.Free;
        end;

        if Assigned(TUser_Sequences)
        then begin
            TUser_Sequences.Close;
            TUser_Sequences.Free;
        end;
    end;


initialization


end.

