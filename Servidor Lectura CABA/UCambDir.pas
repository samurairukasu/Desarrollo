unit UCambDir;

interface

uses
  Classes;

type
  TCambioDirectorio = class(TThread)
  private
    { Private declarations }
    Directorio:String;
    Subdirectorios:Boolean;
    OnCambio:TThreadMethod;
  protected
    procedure Execute; override;
  public
        Constructor Create(CONST Dir:String;IncSubs:Boolean;Gestor:TThreadMethod);
  end;

var
    ThreadCD : TCambioDirectorio;

implementation

Uses
    Windows;

{ TCambioDirectorio }

procedure TCambioDirectorio.Execute;
VAR
   HCD:THandle;
   Res:Integer;
begin
     HCD:=FindFirstChangeNotification(PChar(Directorio),SubDirectorios,FILE_NOTIFY_CHANGE_SIZE {OR FILE_NOTIFY_CHANGE_ATTRIBUTES});
     IF HCD<>Invalid_Handle_Value
        THEN BEGIN
                  REPEAT
                        Res:=WaitForSingleObject(HCD,1000);
                        IF (Res=WAIT_OBJECT_0) AND (@OnCambio<>NIL)
                           THEN Synchronize(OnCambio)
                  UNTIL (NOT FindNextChangeNotification(HCD)) OR Terminated;
                  FindCloseChangeNotification(HCD)
             END
        ELSE Raise EThread.Create('No se pudo crear la notificación de cambios')
end;

Constructor TCambioDirectorio.Create(CONST Dir:String;IncSubs:Boolean;Gestor:TThreadMethod);
BEGIN
     Inherited Create(False);
     Directorio:=Dir;
     Subdirectorios:=IncSubs;
     OnCambio:=Gestor;
     FreeOnTerminate:=True
END;

initialization
    ThreadCD := nil;

end.
