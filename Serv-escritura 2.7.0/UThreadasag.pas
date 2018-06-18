unit UThread;

interface
Uses
  Classes,DBTables,Forms,Messages;

const
    MAX_TIEMPOTIMEOUT = 20; { timeout para esa alerta }
    WM_LINEAINSP = WM_USER+10;
    WM_SERVIMPRE = WM_USER+11;

type
  TProcessThread = class(TThread)
    Constructor Create(aDatabase: TDatabase; aOwner: TForm; aMode: Integer);
    Procedure Execute; override;
  private
    FEndReached: Boolean;
    FromDatabase: TDatabase;
    fOwner: TForm;
    fListenAlarms: Integer;
  public
    property EndReached: BOOLEAN read FEndReached;
    procedure Synchronize(Proc: TThreadMethod);
    procedure Finaliza;
//    procedure MostrarMensaje;
    procedure SepararMensaje (const Mensaje: string;const Nombre: string; var iTipo, iIdentificador: integer);
  end;


var
  Mensaje, Nombre: String;
  MyDataB: TDataBase;

implementation

Uses
  Sysutils,DB,Dialogs, Controls, Windows;

const
    MAX_TIEMPOESPERA = 10; { tiempo de espera antes de enviar un mensaje }
//    NOMBRE_ALERTA = 'Alerta';


Constructor TProcessThread.Create(aDatabase: TDatabase; aOwner: TForm; aMode: Integer);
begin
  inherited Create(False);
  fOwner:=aOwner;
  fListenAlarms := aMode;
  FreeOnTerminate := FALSE;
  FEndReached:= FALSE;
  FromDatabase := aDatabase;
end;

Procedure TProcessThread.Execute;
var
  iTiempoEspera: integer; { var. auxi. que almacena el tiempo de espera antes de+
                            enviar un mensaje }
  iTipoMsg, iID_Estado: integer; { Almacenan el tipo de mensaje y el ID de la
                                   tabla TCITAS }
  TempDataBase: TDataBase;
  SessionName: String;
  Proc1,Proc2: TStoredProc;
  AlertStr1,AlertStr2: String;
begin
  // Creación de su propia session y database
  SessionName := 'Thread'+IntToStr(ThreadId);
  TempDataBase := nil;
  TRY
    Sessions.OpenSession(SessionName);
    WITH Sessions DO
      WITH FindSession(SessionName) DO
        BEGIN
          TempDataBase := TDataBase.Create(nil);
          TempDataBase.AliasName := FromDatabase.AliasName;
          TempDataBase.SessionName := SessionName;
          TempDataBase.DataBaseName := 'Mia';
          TempDataBase.Params.Add(FromDatabase.Params[0]);
          TempDataBase.Params.Add(FromDatabase.Params[1]);
          TempDataBase.LoginPrompt := FALSE;
          TempDataBase.KeepConnection := TRUE;

          MyDataB := OpenDataBase(TempDataBase.DatabaseName);
        END;
  EXCEPT
    TempDataBase.Free;
    Terminate;
  END;

  TRY
  AlertStr1:='';
  AlertStr2:='';
  Case fListenAlarms of
       1:Begin//Eschcha Linea de inspeccion
           AlertStr1 := 'Alerta_LINEAINSP';
       end;
       2:Begin//Eschcha Servicios de impresion
           AlertStr1 := 'Alerta_SERVIMPRE';
       end;
       3:Begin//Eschcha todo
           AlertStr1 := 'Alerta_LINEAINSP';
           AlertStr2 := 'Alerta_SERVIMPRE';
       end;
  end;
  Proc1:= TStoredProc.Create(nil);
  Proc2:= TStoredProc.Create(nil);
  Proc1.DataBaseName := MyDataB.DataBaseName;
  Proc1.SessionName := MyDataB.SessionName;
  Proc2.DataBaseName := MyDataB.DataBaseName;
  Proc2.SessionName := MyDataB.SessionName;
  If fListenAlarms=3
  then
    Proc2.StoredProcName := 'SYS.DBMS_ALERT.WAITANY'
  else
    Proc2.StoredProcName := 'SYS.DBMS_ALERT.WAITONE';

  Proc2.Prepare;
  Proc2.ParamByName('name').AsString := AlertStr1{'Alerta'};
  Proc2.ParamByName('timeout').AsInteger := MAX_TIEMPOTIMEOUT;

  Proc1.StoredProcName := 'SYS.DBMS_ALERT.REGISTER';
  Proc1.Prepare;
  Proc1.ParamByName('name').AsString := AlertStr1{'Alerta'};
  Proc1.ExecProc;

  If AlertStr2<>''
  then begin
      Proc1.Close;
      Proc1.Prepare;
      Proc1.ParamByName('name').AsString := AlertStr2{'Alerta'};
      Proc1.ExecProc;
  end;

  while not Terminated do begin
    Proc2.ExecProc;
     if Proc2.ParamByName('status').AsInteger = 0 then
    begin
        Mensaje := Proc2.ParamByName('message').AsString;
        Nombre := Proc2.ParamByName('name').AsString;
        SepararMensaje (Mensaje,UpperCase(Nombre), iTipoMsg, iID_Estado);
//        Synchronize(MostrarMensaje);

        //randomize;
        //iTiempoEspera := random (MAX_TIEMPOESPERA+1)*1000;
        { Multiplicamos el tiempo de espera por 1000 porque a SLEEP se le pasan
          milisegundos y NO segundos }
        //sleep (iTiempoEspera);
       If UpperCase(Nombre)='ALERTA_LINEAINSP'
       then
           SendMessage(fOwner.Handle,WM_LINEAINSP, iTipoMsg, iID_Estado)
       else
           SendMessage(fOwner.Handle,WM_SERVIMPRE, iTipoMsg, iID_Estado);

    end;
  end;
  finally
    with Sessions.FindSession(SessionName) do
    begin
        Close;
    end;
    FEndReached:= TRUE;
  end;

end;

procedure TProcessThread.SepararMensaje (const Mensaje: string;const Nombre: string; var iTipo, iIdentificador: integer);
begin
    iTipo := StrToInt(Copy (Mensaje,1,1));    
    If UpperCase(Nombre)<>'ALERTA_LINEAINSP'
    then
        iIdentificador := StrToInt(Trim(Copy (Mensaje,3,Length(Mensaje))))
    else               
        iIdentificador := Ord((Trim(Copy (Mensaje,3,Length(Mensaje))))[1])-64;
end;

Procedure TProcessThread.Synchronize(Proc: TThreadMethod);
begin
  inherited Synchronize(Proc);
end;

procedure TProcessThread.Finaliza;
begin
     Terminate;
end;


end.//Final de la unidad
