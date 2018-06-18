unit UThread;

interface
Uses
  Classes,SqlExpr,Forms,Messages,DBXpress;

const
    MAX_TIEMPOTIMEOUT = 20; { timeout para esa alerta }
    WM_LINEAINSP = WM_USER+10;
    WM_SERVIMPRE = WM_USER+11;
    WM_LINEAINSPGNC = WM_USER+12;

type
  TProcessThread = class(TThread)
    Constructor Create(aDatabase: TSQLConnection; aOwner: TForm; aMode: Integer);
    Procedure Execute; override;
  private
    FEndReached: Boolean;
    FromDatabase: TSQLConnection;
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
  MyDataB: TSQLConnection;

implementation

Uses
  Sysutils,DB,Dialogs, Controls, Windows;


const
    MAX_TIEMPOESPERA = 10; { tiempo de espera antes de enviar un mensaje }
//    NOMBRE_ALERTA = 'Alerta';


Constructor TProcessThread.Create(aDatabase: TSQLConnection; aOwner: TForm; aMode: Integer);
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
//  iTiempoEspera: integer; { var. auxi. que almacena el tiempo de espera antes de+
//                            enviar un mensaje }
  iTipoMsg, iID_Estado: integer; { Almacenan el tipo de mensaje y el ID de la
                                   tabla TCITAS }
  TempDataBase: TSQLConnection;
  SessionName: String;
  Proc1,Proc2: TSQLStoredProc;
  AlertStr1,AlertStr2,AlertStr3: String;
const
  coEnableBCD = TSQLConnectionOption(102); // boolean
begin
  // Creación de su propia session y database

//application.messagebox('entra','entra',mb_ok);

  SessionName := 'Thread'+IntToStr(ThreadId);
  TempDataBase := nil;
  Proc1 := nil;
  Proc2 := nil;
  TRY
          TempDataBase := TSQLConnection.Create(Application); // Nil

                with TempDataBase do
                begin
                   DriverName := FromDatabase.DriverName;
                   LibraryName := FromDatabase.LibraryName;
                   VendorLib := FromDatabase.VendorLib;
                   GetDriverFunc := FromDatabase.GetDriverFunc;
                   ConnectionName := 'Mia';

                   Params.Values['DataBase'] := FromDatabase.Params.Values['DataBase'];
                   Params.Values['EnableBCD'] := 'True';
                   Params.Values['User_Name'] := FromDatabase.Params.Values['User_Name'];
                   Params.Values['Password'] := FromDatabase.Params.Values['Password'];
                   LoginPrompt := false;
                   KeepConnection := true;
                end;
                try
                    TempDataBase.Open;
                    TempDataBase.SQLConnection.SetOption(coEnableBCD, Integer(False));
                except
                    on E: Exception do
//                        InitError('No se pudo conectar con la base de datos por: ' + E.message);
                end;
          MyDataB := TempDataBase;
  EXCEPT
    TempDataBase.Free;
    Terminate;
  END;

  TRY
  AlertStr1:='';
  AlertStr2:='';
  AlertStr3:='';
  Case fListenAlarms of
       1:Begin//Eschcha Linea de inspeccion y Linea de Inspeccion GNC
           AlertStr1 := 'ALERTA_LINEAINSP';
           AlertStr3 := 'ALERTA_LINEAINSPGNC';
       end;
       2:Begin//Eschcha Servicios de impresion
           AlertStr1 := 'ALERTA_SERVIMPRE';
       end;
       3:Begin//Eschcha todo
           AlertStr1 := 'ALERTA_LINEAINSP';
           AlertStr2 := 'ALERTA_SERVIMPRE';
           AlertStr3 := 'ALERTA_LINEAINSPGNC';
       end;
  end;
  Proc1:= TSQLStoredProc.Create(application);
  Proc2:= TSQLStoredProc.Create(application);
  Proc1.SQLConnection := MyDataB;
  Proc2.SQLConnection := MyDataB;

  case fListenAlarms of
       1,3: begin
           Proc2.StoredProcName := 'SYS.DBMS_ALERT.WAITANY'
       end;
       2: begin
           Proc2.StoredProcName := 'SYS.DBMS_ALERT.WAITONE'
       end;
  end;

  Proc2.Prepared := true;
  Proc2.ParamByName('NAME').value := AlertStr1{'Alerta'};
  Proc2.ParamByName('TIMEOUT').Value := MAX_TIEMPOTIMEOUT;

  Proc1.StoredProcName := 'SYS.DBMS_ALERT.REGISTER';
  Proc1.Prepared := true;
  Proc1.ParamByName('NAME').value := AlertStr1{'Alerta'};
  Proc1.ExecProc;

  If AlertStr2<>''
  then begin
      Proc1.Close;
      Proc1.Prepared := true;
      Proc1.ParamByName('NAME').value := AlertStr2{'Alerta'};
      Proc1.ExecProc;
  end;

  If AlertStr3<>''
  then begin
      Proc1.Close;
      Proc1.Prepared := true;
      Proc1.ParamByName('NAME').value := AlertStr3{'Alerta'};
      Proc1.ExecProc;
  end;


  while not Terminated do begin
    Proc2.ExecProc;
    if Proc2.ParamByName('STATUS').value = 0 then
    begin
        Mensaje := Proc2.ParamByName('MESSAGE').value;
        Nombre := Proc2.ParamByName('NAME').value;
        SepararMensaje (Mensaje,UpperCase(Nombre), iTipoMsg, iID_Estado);
//        Synchronize(MostrarMensaje);

        //randomize;
        //iTiempoEspera := random (MAX_TIEMPOESPERA+1)*1000;
        { Multiplicamos el tiempo de espera por 1000 porque a SLEEP se le pasan
          milisegundos y NO segundos }
        //sleep (iTiempoEspera);
       If UpperCase(Nombre)='ALERTA_LINEAINSP'
       then begin
           SendMessage(fOwner.Handle,WM_LINEAINSP, iTipoMsg, iID_Estado);
       End
       else If UpperCase(Nombre)='ALERTA_LINEAINSPGNC' then begin
           SendMessage(fOwner.Handle,WM_LINEAINSPGNC, iTipoMsg, iID_Estado);
       End
       else begin
           SendMessage(fOwner.Handle,WM_SERVIMPRE, iTipoMsg, iID_Estado);
       End;
    end;
  end;
  finally
    if Assigned(Proc1)
    then Proc1.Free;

    if Assigned(Proc2)
    then Proc2.Free;

{    with Sessions.FindSession(SessionName) do
    begin
        Close;
    end;}

    if Assigned(MyDataB)
    then MyDataB.Free;
    FEndReached:= TRUE;
  end;
end;

procedure TProcessThread.SepararMensaje (const Mensaje: string;const Nombre: string; var iTipo, iIdentificador: integer);
begin
    iTipo := StrToInt(Copy (Mensaje,1,1));
    If UpperCase(Nombre)<>'ALERTA_LINEAINSP'
    then
    begin
        If UpperCase(Nombre)<>'ALERTA_LINEAINSPGNC' then
                iIdentificador := StrToInt(Trim(Copy (Mensaje,3,Length(Mensaje))))
        else
                iIdentificador := Ord((Trim(Copy (Mensaje,3,Length(Mensaje))))[1])-64;
    end
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
