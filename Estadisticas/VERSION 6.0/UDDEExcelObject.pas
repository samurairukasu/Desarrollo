unit UDDEExcelObject;

interface

Uses Classes, DBTables, Forms, Excels, Dialogs, Controls;

Type

    TDDEExcelObject = Class;

    TExternalMetod = Function(DdeClient: TDDEExcelObject): Boolean of object;

    TDDEExcelObject = Class (TComponent)
    private
        fFileEnter, fFileExit : string;
        Excel: TAdvExcel;
        FOnClose: TNotifyEvent;
        FOnOpen: TNotifyEvent;
        FProcedure: TExternalMetod;
        function GetFileName(const sentido : integer): String;
    public
        constructor CreateFromMethod(aProcedure: TExternalMetod);
        destructor Destroy; Override;
        procedure Put (const Fila, Columna: integer; const s : string);
        Function Execute: Boolean;
        property Metodo: TExternalMetod read fProcedure write fProcedure;
        property OnClose: TNotifyEvent read FOnClose write FOnClose;
        property OnOpen: TNotifyEvent read FOnOpen write FOnOpen;
    end;

implementation

Uses SysUtils, ShellApi, Windows;

procedure TDDEExcelObject.Put (const Fila, Columna: integer; const s : string);
begin
    Excel.PutDataAt(Fila,Columna,[s],dirNone);
end;

Constructor TDDEExcelObject.CreateFromMethod(aProcedure: TExternalMetod);
begin
    //constructor de laclase
    Inherited Create(nil);
    Excel := TAdvExcel.Create(Application);
    Excel.LocateExcel;
    //Excel.IgnoreErrors := FALSE;
    fProcedure := aProcedure;
    fFileEnter := '12123131313131';
    fFileExit := '12123131313131';
end;


Destructor TDDEExcelObject.Destroy;
begin
    Excel.CloseExcel;
    Excel.OnClose := nil;
    Excel.Disconnect;
    Excel.Free;
    Inherited Destroy;
end;


Function TDDEExcelObject.Execute: Boolean;
var
    ExcelPath: String;
begin
    //Ejecuta la conexión DDE

    Result:=FalsE;

    while fFileEnter = fFileExit do
    begin
        fFileEnter := GetFileName(0);
        fFileExit := GetFileName(1);
        if fFileEnter = fFileExit
        then if MessageDlg('Las planillas de entrada y de salida no pueden ser la misma',mtInformation,[mbYes,mbCancel],0) = mrCancel
            then Exit;
    end;

    Excel.OnOpen := FOnOpen;
    Excel.OnClose := FOnClose;

    try
        Excel.Connect;
    except
        ExcelPath := '';
        if InputQuery( 'No se encuentra Excel', 'Especifique la ruta de ejecución para Excel', ExcelPath )
        then begin
            Excel.ExeName := ExcelPath;
            try
                Excel.Connect;
            except
                Exit;
            end;
        end
        else Exit;
    end;
    Excel.Exec(Format('[OPEN("%S")]',[fFileEnter]));
    fProcedure(Self);
    Excel.Exec(Format('[SAVE.AS("%S")]',[fFileExit]));
    Result := True;
end;

Function TDDEExcelObject.GetFileName(const sentido : integer): String;
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
        if sentido = 0
        then Title := 'Seleccione la Planilla de Entrada'
        else Title := 'Seleccione la Planilla de Salida';
        if Execute
        then Result:=FileName;
    Finally
        Free;
    end;
end;


end.
