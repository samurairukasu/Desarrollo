unit Globals;

interface

    uses
        SQLEXPR, Messages, DBXpress, Provider, dbclient;

    Const
        WM_LINEAINSP = WM_USER+10;
        WM_SERVIMPRE = WM_USER+11;
        WM_LINEAINSPGNC = WM_USER+12;

    Threadvar
       MyBD, System : TSqlConnection;
       BDAG: TSQLConnection;
       TD: TTransactionDesc;
//       MyTraza: TSQLMonitor;


    var
        TipoEquipo : string;
        DirectorioIn :string;
        DirectorioOut :string;
        Cursores: Integer;
        MaxCursores: Integer;
        cierrezok: boolean;
        VerEurosystem: string;
        VerSO: String;

    procedure Conectar(UserName: String);
    procedure ConectarSystem;

implementation

    uses
        Forms,
        FileCtrl,
        Windows,
        SysUtils,
        UConst,
        USUPERREGISTRY;

    const

        APPLICATION_NAME = 'SAGVTV';
        COMPANY_NAME = 'CISA';

        APPLICATION_KEY = '\SOFTWARE\'+COMPANY_NAME+'\'+APPLICATION_NAME;
        BD_KEY = APPLICATION_KEY+'\BD';

        ALIAS_ = 'Alias';
        USER_  = 'User';
        PASSWORD_ = 'Password';
        ALIAS2_ = 'Alias2';
        USER2_  = 'User2';
        PASSWORD2_ = 'Password2';
        USERPROV_  = 'UserProv';
        PASSWORDPROV_ = 'PasswordProv';
        LICENCIA_APP = 'NUMAPP';
        LICENCIA_SERV = 'NUMSER';
        TIPO_ = 'TIPO';
        DRIVERNAME_ = 'Drivername';
        LIBRARYNAME_ = 'Libraryname';
        VENDORLIB_ = 'vendorlib';
        GETDRIVERFUNC_ = 'GetDriverFunc';



procedure Conectar(UserName: String);
var
DBAlias, DBUserName, DBPassword, DBAlias2, DBUserName2, DBPassword2,
DBDriverName, DBLibraryName, DBVendorLib, DBGetDriverFunc: String;
const
coEnableBCD = TSQLConnectionOption(102); // boolean
begin
with TSuperRegistry.Create do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    if not OpenKeyRead(BD_KEY) then
      //('No se encontraron los parámetros de conexión a la base de datos')
    else
      Begin
        try
          DBAlias := ReadString(ALIAS_);
          DBUserName := UserName;
          DBPassword := ReadString(PASSWORD_);
          DBDriverName := ReadString(DRIVERNAME_);
          DBLibraryName := ReadString(LIBRARYNAME_);
          DBVendorLib := ReadString(VENDORLIB_);
          DBGetDriverFunc := ReadString(GETDRIVERFUNC_);

          DBAlias2:='';
          DBUserName2:='';
          DBPassword2:='';
          try
            DBAlias2 := ReadString(ALIAS2_);
            DBUserName2 := ReadString(USER2_);
            DBPassword2 := ReadString(PASSWORD2_);
          except

          end;

        except

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

          if UserName = 'Ageva' then
            Begin
              Params.Values['User_Name'] := 'Ageva';
              Params.Values['Password'] := 'iso9001';

            end;

          if UserName = 'System' then
            Begin
              Params.Values['User_Name'] := 'Sys';
              Params.Values['Password'] := 'Applusbd';
              Params.Values['RoleName'] := 'sysdba';
            end;


            if UserName = 'Ageva2010' then
            Begin
              Params.Values['User_Name'] := 'Ageva2010';
              Params.Values['Password'] := 'iso9001';
            end;

              if UserName = 'CISA' then
            Begin
              Params.Values['User_Name'] := 'cisa';
              Params.Values['Password'] := '02lusabaqui03';
            end;


          LoginPrompt := false;
          KeepConnection := true;
        end;
        try
          MyBD.Open;
          mybd.SQLConnection.SetOption(coEnableBCD, Integer(False));
        except
          on E: Exception do

        end;
       end
    finally
        Free;
    end;
end;


procedure ConectarSystem;
var
DBAlias, DBUserName, DBPassword, DBAlias2, DBUserName2, DBPassword2,
DBDriverName, DBLibraryName, DBVendorLib, DBGetDriverFunc: String;
const
coEnableBCD = TSQLConnectionOption(102); // boolean
begin
with TSuperRegistry.Create do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    if not OpenKeyRead(BD_KEY) then
      //('No se encontraron los parámetros de conexión a la base de datos')
    else
      Begin
        try
          DBAlias := ReadString(ALIAS_);
          DBPassword := ReadString(PASSWORD_);
          DBDriverName := ReadString(DRIVERNAME_);
          DBLibraryName := ReadString(LIBRARYNAME_);
          DBVendorLib := ReadString(VENDORLIB_);
          DBGetDriverFunc := ReadString(GETDRIVERFUNC_);

          DBAlias2:='';
          DBUserName2:='';
          DBPassword2:='';
          try
            DBAlias2 := ReadString(ALIAS2_);
            DBUserName2 := ReadString(USER2_);
            DBPassword2 := ReadString(PASSWORD2_);
          except

          end;

        except

          exit;
        end;


    System := TSQLConnection.Create(nil);
      with System do
        begin
          DriverName := DBDriverName;
          LibraryName := DBLibraryName;
          VendorLib := DBVendorLib;
          GetDriverFunc := DBGetDriverFunc;
          Params.Values['EnableBCD'] := 'True';
          Params.Values['User_Name'] := 'sys';
          Params.Values['Password'] := 'Applusbd';
          LoginPrompt := false;
          KeepConnection := true;
        end;
        try
          System.Open;
          System.SQLConnection.SetOption(coEnableBCD, Integer(False));
        except
          on E: Exception do

        end;
       end
    finally
        Free;
    end;
end;


initialization


end.

