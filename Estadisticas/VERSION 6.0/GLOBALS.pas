unit Globals;

interface

    uses
        SQLEXPR, Messages, DBXpress, Provider, dbclient, USagVarios, uutils, Printers, Windows,
        DateUtil, IniFiles;

    Const
        WM_LINEAINSP = WM_USER+10;
        WM_SERVIMPRE = WM_USER+11;
        WM_LINEAINSPGNC = WM_USER+12;
        NOM_DIR = 'C:\TMPGes\';
        NOM_TMP = 'TMPPreg';

    Threadvar
       MyBD : TSqlConnection;
       BDAG: TSQLConnection;
       BDEmpex: TSQLConnection;
       BDChile: TSQLConnection;
       TD: TTransactionDesc;
       MyTraza: TSQLMonitor;


    var
        TipoEquipo : string;
        DirectorioIn :string;
        DirectorioOut :string;
        fVarios: TVarios;
        fZona : tsqlquery;
        Cursores: Integer;
        MaxCursores: Integer;
        cierrezok: boolean;

        Destino_Archivos: String;

        PrinterReady: Boolean;  //Lucho
        Ruta: String;            //Lucho

        dsp_user_tab_columns : TDataSetProvider;
        dsp_user_ind_columns : TDataSetProvider;
        dsp_user_sequences : TDataSetProvider;

        cds_user_tab_columns : TSQLDataSet;
        cds_user_ind_columns : TSQLDataSet;
        cds_user_sequences : TSQLDataSet;

        TUser_Tab_Columns : TClientDataSet;
        TUser_Ind_Columns : TClientDataSet;
        TUser_Sequences : TClientDataSet;

        dsp_ageva_tab_columns : TDataSetProvider;
        dsp_ageva_ind_columns : TDataSetProvider;
        dsp_ageva_sequences : TDataSetProvider;

        cds_ageva_tab_columns : TSQLDataSet;
        cds_ageva_ind_columns : TSQLDataSet;
        cds_ageva_sequences : TSQLDataSet;

        Tageva_Tab_Columns : TClientDataSet;
        Tageva_Ind_Columns : TClientDataSet;
        Tageva_Sequences : TClientDataSet;

        CONEXION_ESTABLECIDA_CHILE:BOOLEAN;

      FUNCTION DesconectarBDCHILE:BOOLEAN;
    procedure TestOfBD(Alias, UserName, Password: String; Ageva: boolean);
    FUNCTION TestOfBDCHILE(Alias, UserName, Password: String; Ageva: boolean):BOOLEAN;
    procedure TestOfBugs;
    procedure TestOfTerminal;
    procedure InitAplicationGlobalTables;
    procedure FinishAplicationGlobalTables;
    Function GetImpresora: Integer;
    function FindControlByNumber(hApp: HWND; ControlClassName: string; ControlNr: Word = 1): HWND;
    Procedure Guardar(Archivo: String);
    Procedure CrearCarpetas;
    Function GetRutaArchivos: String;

implementation

    uses
        Forms,
        FileCtrl,
        SysUtils,
        UCHECSM,
        UVERSION,
        UPROTECT,
        UCDIALGS,
        UtilOracle,
        USUPERREGISTRY, Dialogs;

    const
        FILE_NAME = 'GLOBALS.PAS';


Function GetRutaArchivos: String;
var
ArchivoIni: TIniFile;
Begin
ArchivoIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+'\Config.ini');
  try
    Result:=ArchivoIni.ReadString('Ruta','Archivos_destino','');
    Destino_Archivos:=Result;
  except
    On E: Exception do
      ShowMessage('Se ha producidor un error, debido a: '+#10#13+E.message);
  end;
end;



    procedure InitError(Msg: String);
    begin
//        MessageDlg('Error en la Inicialización',Msg,mtError,[mbOK],mbOK,0);
//        if Assigned(fAnomalias)
//        then fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FILE_NAME,Msg);
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

          



              FUNCTION DesconectarBDCHILE:BOOLEAN;
    var
        DBAlias, DBUserName, DBPassword, DBAlias2, DBUserName2, DBPassword2,
        DBAlias3, DBUserName3, DBPassword3, DBAliaschile, DBUserNamechile, DBPasswordchile,
        DBDriverName, DBLibraryName, DBVendorLib, DBGetDriverFunc: String;
    const
  coEnableBCD = TSQLConnectionOption(102); // boolean
    begin
   BDChile.close;

    end;


        FUNCTION TestOfBDCHILE(Alias, UserName, Password: String; Ageva: boolean):BOOLEAN;
    var
        DBAlias, DBUserName, DBPassword, DBAlias2, DBUserName2, DBPassword2,
        DBAlias3, DBUserName3, DBPassword3, DBAliaschile, DBUserNamechile, DBPasswordchile,
        DBDriverName, DBLibraryName, DBVendorLib, DBGetDriverFunc: String;
    const
  coEnableBCD = TSQLConnectionOption(102); // boolean
    begin
    TestOfBDCHILE:=false;
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


                    DBAliaschile:='';
                    DBUserNamechile:='';
                    DBPasswordchile:='';


                    try


                      DBAliaschile := ReadString(ALIASChile_);
                      DBUserNamechile := ReadString(USERChile_);
                      DBPasswordchile := ReadString(PASSWORDChile_);

                    except

                    end;

                except
                    InitError('No se encontró en el registro algún parámetro necesario para la conexión a la base de datos');
                    exit;
                end;





                        if (DBAliasChile<>'') and (DBUserNameChile<>'') and (DBPasswordChile<>'') then
                  if ageva then  //esto se hace para que la primera vez se cree la base ageva, despues no la vuelve a crear
                  begin
                    BDChile := TSQLConnection.Create(nil);
                    BDChile.DriverName := DBDriverName;
                    BDChile.LibraryName := DBLibraryName;
                    BDChile.VendorLib := DBVendorLib;
                    BDChile.GetDriverFunc := DBGetDriverFunc;
                    BDChile.Params.Values['DataBase'] := DBAliasChile;
                    BDChile.Params.Values['EnableBCD'] := 'True';
                    BDChile.Params.Values['User_Name'] := DBUserNameChile;
                    BDChile.Params.Values['Password'] := DBPasswordChile;
                    BDChile.LoginPrompt := false;
                    BDChile.KeepConnection := true;
                    try
                        APPLICATION.ProcessMessages;
                        BDChile.Open;
                        APPLICATION.ProcessMessages;
                        BDChile.SQLConnection.SetOption(coEnableBCD, Integer(False));
                        APPLICATION.ProcessMessages;
                        TestOfBDCHILE:=true;
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




    procedure TestOfBD(Alias, UserName, Password: String; Ageva: boolean);
    var
        DBAlias, DBUserName, DBPassword, DBAlias2, DBUserName2, DBPassword2,
        DBAlias3, DBUserName3, DBPassword3, DBAliaschile, DBUserNamechile, DBPasswordchile,
        DBDriverName, DBLibraryName, DBVendorLib, DBGetDriverFunc: String;
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

                    DBAlias2:='';
                    DBUserName2:='';
                    DBPassword2:='';
                    DBAlias3:='';
                    DBUserName3:='';
                    DBPassword3:='';
                    DBAliaschile:='';
                    DBUserNamechile:='';
                    DBPasswordchile:='';


                    try
                      DBAlias2 := ReadString(ALIAS2_);
                      DBUserName2 := ReadString(USER2_);
                      DBPassword2 := ReadString(PASSWORD2_);
                      DBAlias3 := ReadString(ALIAS3_);
                      DBUserName3 := ReadString(USER3_);
                      DBPassword3 := ReadString(PASSWORD3_);

                      DBAliaschile := ReadString(ALIASChile_);
                      DBUserNamechile := ReadString(USERChile_);
                      DBPasswordchile := ReadString(PASSWORDChile_);

                    except

                    end;

                except
                    InitError('No se encontró en el registro algún parámetro necesario para la conexión a la base de datos');
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

                MyTraza := TSQLMonitor.Create(NIL);
                MyTraza.SQLConnection := MyBD;
                MyTraza.FileName := extractfilepath(application.ExeName)+'MyLog.txt';
                MyTraza.AutoSave := True;
                MyTraza.Active := True;

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
                    bdempex := TSQLConnection.Create(nil);
                    bdempex.DriverName := DBDriverName;
                    bdempex.LibraryName := DBLibraryName;
                    bdempex.VendorLib := DBVendorLib;
                    bdempex.GetDriverFunc := DBGetDriverFunc;
                    bdempex.Params.Values['DataBase'] := DBAlias3;
                    bdempex.Params.Values['EnableBCD'] := 'True';
                    bdempex.Params.Values['User_Name'] := DBUserName3;
                    bdempex.Params.Values['Password'] := DBPassword3;
                    bdempex.LoginPrompt := false;
                    bdempex.KeepConnection := true;
                    try
                        bdempex.Open;
                        bdempex.SQLConnection.SetOption(coEnableBCD, Integer(False));
                    except
                        on E: Exception do
                            InitError('No se pudo conectar con la base de datos por: ' + E.message);
                    end
                  end;

             {           if (DBAliasChile<>'') and (DBUserNameChile<>'') and (DBPasswordChile<>'') then
                  if ageva then  //esto se hace para que la primera vez se cree la base ageva, despues no la vuelve a crear
                  begin
                    BDChile := TSQLConnection.Create(nil);
                    BDChile.DriverName := DBDriverName;
                    BDChile.LibraryName := DBLibraryName;
                    BDChile.VendorLib := DBVendorLib;
                    BDChile.GetDriverFunc := DBGetDriverFunc;
                    BDChile.Params.Values['DataBase'] := DBAliasChile;
                    BDChile.Params.Values['EnableBCD'] := 'True';
                    BDChile.Params.Values['User_Name'] := DBUserNameChile;
                    BDChile.Params.Values['Password'] := DBPasswordChile;
                    BDChile.LoginPrompt := false;
                    BDChile.KeepConnection := true;
                    try
                        BDChile.Open;
                        BDChile.SQLConnection.SetOption(coEnableBCD, Integer(False));
                    except
                        on E: Exception do
                            InitError('No se pudo conectar con la base de datos por: ' + E.message);
                    end
                  end;

               }
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
            then InitError('No se encontraron los parámetros de tipo de terminal del equipo')
            else begin
                try
                    TipoEquipo := ReadString(TIPO_);
                    if (TipoEquipo <> CONSOLA_VALUE) and (TipoEquipo <> SERVIDOR_VALUE) and (TipoEquipo <> SERVICON_VALUE)
                    then TipoEquipo := CONSOLA_VALUE;
                except
                    InitError('No se encontró en la configuración del sistema el tipo de servidor.');
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

    Procedure InitAplicationGlobalTables;
    begin


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

         // /*---------------------- ageva bd--------------/*
        cds_ageva_tab_columns := TSQLDataSet.Create(Application);
        cds_ageva_ind_columns := TSQLDataSet.Create(Application);
        cds_ageva_sequences   := TSQLDataSet.Create(Application);

        cds_ageva_tab_columns.SQLConnection := BDAG;
        cds_ageva_ind_columns.SQLConnection := BDAG;
        cds_ageva_sequences.SQLConnection := BDAG;

        cds_ageva_tab_columns.CommandType := ctQuery;
        cds_ageva_ind_columns.CommandType := ctQuery;
        cds_ageva_sequences.CommandType := ctQuery;

        cds_ageva_tab_columns.GetMetadata := false;
        cds_ageva_ind_columns.GetMetadata := false;
        cds_ageva_sequences.GetMetadata := false;

        cds_ageva_tab_columns.NoMetadata := true;
        cds_ageva_ind_columns.NoMetadata := true;
        cds_ageva_sequences.NoMetadata := true;

        cds_ageva_tab_columns.ParamCheck := false;
        cds_ageva_ind_columns.ParamCheck := false;
        cds_ageva_sequences.ParamCheck := false;

        dsp_ageva_tab_columns := TDataSetProvider.Create(Application);
        dsp_ageva_tab_columns.DataSet := cds_ageva_tab_columns;
        dsp_ageva_tab_columns.Options := [poIncFieldProps,poAllowCommandText];

        dsp_ageva_ind_columns := TDataSetProvider.Create(Application);
        dsp_ageva_ind_columns.DataSet := cds_ageva_ind_columns;
        dsp_ageva_ind_columns.Options := [poIncFieldProps,poAllowCommandText];

        dsp_ageva_Sequences := TDataSetProvider.Create(Application);
        dsp_ageva_Sequences.DataSet := cds_ageva_sequences;
        dsp_ageva_Sequences.Options := [poIncFieldProps,poAllowCommandText];



        Tageva_Tab_Columns:=TClientDataSet.Create(Application);
        Tageva_Ind_Columns:=TClientDataSet.Create(Application);
        Tageva_Sequences:=TClientDataSet.Create(Application);

        With Tageva_Tab_Columns do
        begin
            SetProvider(dsp_AGEVA_tab_columns);
            CommandText := ('SELECT * FROM USER_TAB_COLUMNS ORDER BY TABLE_NAME');
            Open;
        end;
        With Tageva_Ind_Columns do
        begin
            SetProvider(dsp_AGEVA_ind_columns);
            CommandText := ('SELECT * FROM USER_IND_COLUMNS ORDER BY INDEX_NAME');
            Open;
        end;
        With Tageva_Sequences do
        begin
            SetProvider(dsp_AGEVA_sequences);
            CommandText := ('SELECT * FROM USER_SEQUENCES');
            Open;
        end;

        Cursores:=5;
        MaxCursores:=5;
         //----------FIN BDAG
        with tsqlquery.create(nil) do
        begin
          try
            SQLConnection:=bdag;
            sql.add(format('SELECT CODZONA FROM TPLANTAS WHERE USUARIO = ''%S''',[devuelveusuario(mybd)]));
            open;

            // 30102012 - MB, NO SE USA PARA HAM
          //  fZona:=tsqlquery.create(nil);
           // fzona.SQLConnection:=bdag;
           // fzona.sql.add(format('SELECT * FROM TZONAS WHERE CODZONA = %D',[FIELDS[0].ASINTEGER]));
           // fzona.open;
          finally
            free;
          end;
        end;


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


/////////////////////////////////////////// -LUCHO -////////////////////////////////////////////////


Function GetImpresora: Integer;
var
nCont: Integer;
Begin
PrinterReady:=false;
  For nCont:=0 to Printer.Printers.Count - 1 do
    Begin
    if Pos('PrimoPDF', Printer.Printers[nCont]) <> 0 then
      Begin
      Result:= nCont;
      PrinterReady:=true;
      Break;
      Application.ProcessMessages;
      end
    else
      Begin
      PrinterReady:=false;
      Result:=-1;
      Application.ProcessMessages;
      end;
    end;
    if not PrinterReady then
    MessageDlg('< Impresora PrimoPDF no existe! >'+#13+#10+''+#13+#10+'Para utilizar esta funcion, debe'+#13+#10+'instaladar la impresora PrimoPDF.', mtError, [mbOK], 0);
CrearCarpetas;
Application.ProcessMessages;
end;


function FindControlByNumber(hApp: HWND; ControlClassName: string; ControlNr: Word = 1): HWND;
var
i: Word;
hControl: HWND;
begin
Result := 0;
if IsWindow(hApp) then
begin
Dec(ControlNr);
hControl := 0;
for i := 0 to ControlNr do
begin
hControl := FindWindowEx(hApp, hControl, PChar(ControlClassName), nil);
if hControl = 0 then Exit;
end;
end;
Result := hControl;
end;


Procedure Guardar(Archivo: String);
var
HWndPDF: Integer;
A,H: HWND;
Begin
if PrinterReady then
  Begin
    Sleep(800);
    HWndPDF:= FindWindow(nil,pchar('PrimoPDF'));
      If HWndPDF = 0 then
      HWndPDF := FindWindow(pchar('PrimoPDF'),nil);
    SetForegroundWindow(HWndPDF);
    h:=FindWindowEx(HWndPDF,0,'Edit',nil);
    SendMessage(h,WM_SETTEXT,0,DWORD(PChar(RUTA+'\'+Archivo)));
    A:=FindControlByNumber(HWndPDF,'Button',2);
    SendMessage(A,WM_KEYDOWN,VK_SPACE,0);
    SendMessage(A,WM_KEYUP,VK_SPACE,0);
  end;
end;


Procedure CrearCarpetas;
var
Anio, Mes: Integer;
Meses: String;
ArchivoIni: TIniFile;
Begin
ArchivoIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+'\Config.ini');
  try
    Destino_Archivos:=ArchivoIni.ReadString('Ruta','Archivos_destino','');
  except
    On E: Exception do
      ShowMessage('Se ha producidor un error, debido a: '+#10#13+E.message);
  end;

Anio:=(ExtractYear(IncYear(now,0)));
Mes:= (ExtractMonth(IncMonth(now,-1)));
Meses:= IntToStr(Mes);
if Mes < 10 then
  Meses:='0'+Meses;
if not DirectoryExists(Destino_Archivos+'\Informes Estadisticos') then
  CreateDir(Destino_Archivos+'\Informes Estadisticos');
if not DirectoryExists(Destino_Archivos+'\Informes Estadisticos\'+IntToStr(Anio)) then
  CreateDir(Destino_Archivos+'\Informes Estadisticos\'+IntToStr(Anio));
if not DirectoryExists(Destino_Archivos+'\Informes Estadisticos\'+IntToStr(Anio)+'\'+Meses) then
  CreateDir(Destino_Archivos+'\Informes Estadisticos\'+IntToStr(Anio)+'\'+Meses);
Ruta:=Destino_Archivos+'\Informes Estadisticos\'+IntToStr(Anio)+'\'+Meses+'\';
end;




initialization



end.

