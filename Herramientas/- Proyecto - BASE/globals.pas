unit Globals;

interface

    uses
         SQLEXPR, Messages, DBXpress, Provider, dbclient, DB,classes ;

    Const
        WM_LINEAINSP = WM_USER+10;
        WM_SERVIMPRE = WM_USER+11;

    Threadvar
       MyBD : TSqlConnection;
       TD: TTransactionDesc;
    var

        TipoEquipo : string;
        DirectorioIn :string;
        DirectorioOut :string;
        Cursores: Integer;
        MaxCursores: Integer;
        cierrezok: boolean;
        Parametros_ID : TStringList;
        Usuario_Gestion : string;

        dsp_user_tab_columns : TDataSetProvider;
        dsp_user_ind_columns : TDataSetProvider;
        dsp_user_sequences : TDataSetProvider;
        dsp_user_parametros : TDataSetProvider;

        cds_user_tab_columns : TSQLDataSet;
        cds_user_ind_columns : TSQLDataSet;
        cds_user_sequences : TSQLDataSet;
        cds_user_parametros : TSQLDataSet;

        TUser_Tab_Columns : TClientDataSet;
        TUser_Ind_Columns : TClientDataSet;
        TUser_Sequences : TClientDataSet;
        TUser_parametros : TClientDataSet;

        aIDPC, aIDZONA, aIDPLANTA: integer;

    procedure TestOfDirectories;
    procedure TestOfBugs;
    procedure TestOfBD(Alias, UserName, Password: String);
    procedure InitAplicationGlobalTables;
    procedure FinishAplicationGlobalTables;

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
        USUPERREGISTRY;


    const
        FILE_NAME = 'GLOBALS.PAS';


    procedure InitError(Msg: String);
    begin
        MessageDlg('Error en la Inicialización',Msg,mtError,[mbOK],mbOK,0);
        if Assigned(fAnomalias)
        then fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FILE_NAME,Msg);
        InitializationError := TRUE;
        Application.Terminate;
    end;

    procedure TestOfBugs;
    begin
        if not FileFreeOfBugs(Application.ExeName)
        then begin
            {$IFDEF WITHBUGS}
            InitError('El fichero está contaminado por bugs bunnie.')
            {$ENDIF}
        end
    end;


    procedure TestOfBD(Alias, UserName, Password: String);
    var
       DBAlias, DBUserName, DBPassword,DBDriverName, DBLibraryName, DBVendorLib, DBGetDriverFunc: String;
    const
     coEnableBCD = TSQLConnectionOption(102); // boolean
    begin
        with TSuperRegistry.Create do
        try
            RootKey := HKEY_LOCAL_MACHINE;

            if not OpenKeyRead(BD_KEY)
            then InitError('No se encontraron los parámetros de conexión a la base de datos')
            else begin
                try
                    If Alias=''
                    then
                        DBAlias := ReadString(ALIAS_)
                    Else
                        DBAlias:=Alias;

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
                except
                    InitError('No se encontró en el registro algún parámetro necesario para la conexión a la base de datos');
                    exit;
                end;

                MyBD := TSQLConnection.Create(application);
                with MyBD do
                begin
                   MyBD.DriverName := DBDriverName;
                   MyBD.LibraryName := DBLibraryName;
                   MyBD.VendorLib := DBVendorLib;
                   MyBD.GetDriverFunc := DBGetDriverFunc;

                   MyBD.Params.Values['DataBase'] := DBAlias;
                   MyBD.Params.Values['EnableBCD'] := 'True';
                   MyBD.Params.Values['User_Name'] := DBUserName;
                   MyBD.Params.Values['Password'] := DBPassword;


                   MyBD.LoginPrompt := false;
                   MyBD.KeepConnection := true;

                end;
                    try
                   mybd.Connected := true;
                   mybd.SQLConnection.SetOption(coEnableBCD, Integer(False));
                except
                    on E: Exception do
                    begin
                        InitError('No se pudo conectar con la base de datos por: ' + E.message);
                        if Assigned(fAnomalias)
                        then fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FILE_NAME,E.message);
                    end;
                end;
                TD.IsolationLevel := xilREADCOMMITTED;
                td.TransactionID := 1;
                td.GlobalID := 0;
         end;
        finally
            Free;
        end;
    end;

    procedure TestOfDirectories;
    begin
(*        with TSuperRegistry.Create do
        try
            RootKey := HKEY_LOCAL_MACHINE;
            if not OpenKeyRead(IO_KEY)
            then InitError('No se encontraron los parámetros de comunición con la línea de insepcción.')
            else begin
            end
        finally
            Free;
        end*)
    end;


    Procedure InitAplicationGlobalTables;
    begin
    { TODO -oran -creemplazo componentes : Ver si pueden tener el mismo provider }

        cds_user_tab_columns := TSQLDataSet.Create(Application);
        cds_user_ind_columns := TSQLDataSet.Create(Application);
        cds_user_sequences   := TSQLDataSet.Create(Application);
        cds_user_parametros   := TSQLDataSet.Create(Application);

        cds_user_tab_columns.SQLConnection := MyBD;
        cds_user_ind_columns.SQLConnection := MyBD;
        cds_user_sequences.SQLConnection := MyBD;


        cds_user_tab_columns.CommandType := ctQuery;
        cds_user_ind_columns.CommandType := ctQuery;
        cds_user_sequences.CommandType := ctQuery;
        cds_user_parametros.CommandType := ctQuery;

        dsp_user_tab_columns := TDataSetProvider.Create(Application);
        dsp_user_tab_columns.DataSet := cds_user_tab_columns;
        dsp_user_tab_columns.Options := [poIncFieldProps,poAllowCommandText];

        dsp_user_ind_columns := TDataSetProvider.Create(Application);
        dsp_user_ind_columns.DataSet := cds_user_ind_columns;
        dsp_user_ind_columns.Options := [poIncFieldProps,poAllowCommandText];

        dsp_user_Sequences := TDataSetProvider.Create(Application);
        dsp_user_Sequences.DataSet := cds_user_sequences;
        dsp_user_Sequences.Options := [poIncFieldProps,poAllowCommandText];

        dsp_user_parametros := TDataSetProvider.Create(Application);
        dsp_user_parametros.DataSet := cds_user_parametros;
        dsp_user_parametros.Options := [poIncFieldProps,poAllowCommandText];

        TUser_Tab_Columns:=TClientDataSet.Create(Application);
        TUser_Ind_Columns:=TClientDataSet.Create(Application);
        TUser_Sequences:=TClientDataSet.Create(Application);
        TUser_parametros:=TClientDataSet.Create(Application);

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
       {  With TUser_parametros do
        begin
            SetProvider(dsp_user_parametros);
            CommandText := ('SELECT * FROM PARAMETROS_SOFT');
            Open;
            First;
            Parametros_ID := TStringList.Create();
            while not Eof do
              begin
               Parametros_ID.Add(Fields[2].AsString);
               Next;
              end;  }
      //  end;
//        fVarios:=TVarios.Create(MyBD);
//        fVarios.Open;
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


