unit UDDEObject;

interface

Uses DdeMan, Classes, Forms;

Type

TDDEObject = Class;

TExternalMetod = Function(aDataSet: TQuery; DdeClient: TDDEObject): Boolean of object;

TDDEObject = Class (TComponent)
  Private
    DdeItem: TDdeClientItem;
    DdeClient: TDdeClientConv;
    fProcedure: TExternalMetod;
    fQuery: TQuery;
    Function GetFileName: String;
    function GetServiceA:String;
  Protected
  Public
    Constructor CreateFromMethod(aProcedure: TExternalMetod; aDataSet: TQuery);
    Destructor Destroy; Override;
    Function SetDataToDDE(aCells: String; aData: Pchar): Boolean;
    Function GetDataFromDDe(Topic: String):Pchar;
    Function DoMacro(Macro: String;Wait: Boolean): Boolean;
    Function Execute: Boolean;
    Property Metodo: TExternalMetod read fProcedure write fProcedure;
  Published
end;

implementation

Uses SysUtils, Dialogs, ShellApi, Windows, USuperRegistry;

Constructor TDDEObject.CreateFromMethod(aProcedure: TExternalMetod;aDataSet: TQuery);
begin
    //constructor de laclase
    Inherited Create(nil);
    fProcedure := aProcedure;
    fQuery := aDataSet;
    DdeClient := TDdeClientConv.Create(Self);
    //DdeClient.ServiceApplication:=GetServiceA;
    DdeItem := TDdeClientItem.Create(Self);
    DdeItem.DDeConv:=DdeClient;
end;

Destructor TDDEObject.Destroy;
begin
    //Destructor de la clase
    while DDeClient.WaitStat do Application.ProcessMessages;
    DDeClient.CloseLink;
    while DDeClient.WaitStat do Application.ProcessMessages;
    DdeItem.Free;
    while DDeClient.WaitStat do Application.ProcessMessages;    
    DdeClient.Free;
    Inherited Destroy;
end;

Function TDDEObject.SetDataToDDE(aCells: String; aData: Pchar): Boolean;
begin
    //inserta datos en la conexión DDE
    Result:=DdeClient.PokeData(aCells,aData);
    while ddeClient.WaitStat do Application.ProcessMessages;
end;

Function TDDEObject.GetDataFromDDe(Topic: String):Pchar;
begin
    //Consulta Datos al dde
    Result:=DdeClient.RequestData(Topic);
    while ddeClient.WaitStat do Application.ProcessMessages;
end;

Function TDDEObject.DoMacro(Macro: String;Wait: Boolean): Boolean;
begin
    //Ejecuta un macro con la conexión DDE
    Result:=DdeClient.ExecuteMacro(PChar(Format('[%s]',[Macro])),Wait);
    while ddeClient.WaitStat do Application.ProcessMessages;
end;

Function TDDEObject.Execute: Boolean;
var
    Planilla, Fichero, Directorio: String;
    ii: Integer;
begin
    //Ejecuta la conexión DDE
    Result:=FalsE;
    Planilla:=GetFileName;
    if Planilla<>''
    then begin
        //Preparar conexion
        Fichero:=ExtractFileName(Planilla);
        Directorio:=ExtractFilePath(Planilla);
        ShellExecute(0,'Open',PChar(Planilla),'','',SW_MAXIMIZE);
        Sleep(3000);
        DDeClient.CLoseLink;
        DDeClient.ConnectMode:=ddeManual;
        DDeClient.SetLink('Excel',Format('%s[%s]%s',[Directorio,Fichero,'Planilla VTV']));
        ii:=0;
        While ii<3 do
        begin
            If DdeClient.OpenLink
            Then begin
                ii:=100;
                Result:=True;
                DDeClient.ExecuteMacro('[Workspace(,,TRUE)]',False);//Formato FxCx
                while ddeClient.WaitStat do Application.ProcessMessages;
                fProcedure(fQuery,Self);
                while ddeClient.WaitStat do Application.ProcessMessages;
            end
            else begin
                inc(ii);
                if ii<3 then Sleep(2000);
            end;
        end;
    end;
end;

Function TDDEObject.GetFileName: String;
var
    OpenD: TOpenDialog;
begin
    //Devuelve el nombre de una planilla seleccionada
    Result:='';
    OpenD:=TOpenDialog.Create(Nil);
    with OpenD do
    Try
        Filter:='Fichero Excel|*.Xls';
        DefaultExt:='*.Xls';
        Title:='Selleccione Planilla a Utilizar';
        if Execute
        then
            Result:=FileName;
    Finally
        Free;
    end;
end;

function TDDEObject.GetServiceA:String;
Const
    DDEKEY = 'SOFTWARE\Microsoft\Office\8.0\Common\FileNew\NFT\General\Blank Workboook';
    KEY = 'command';
var
    SuperRegistry: TSuperRegistry;
begin
    //devuelve el servidor de aplicaciones para excell
    Result:='';
    SuperRegistry := TSuperRegistry.Create;
    With SuperRegistry do
    Try
        RootKey := HKEY_LOCAL_MACHINE;
        if OpenKeyRead(DDEKEY)
        then begin
            Result:=ReadString(KEY);
            if Result='' then
            begin
                //Error no existe la clave en el registro
                Showmessage('No hay claves en el registro para conexión DDE con Excel');
            end
            else
                Result:=Result; //Copy(Result,1,Pos(' /e',Result));
        end
        else begin
            //Error no existe la clave en el registro
            Showmessage('No hay claves en el registro para conexión DDE con Excel');
        end;
    Finally
        Free;
    end;
end;

end.
