unit uSQLExec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ShellAPI, ExtCtrls;

type
  TFrmSQLExec = class(TForm)
    BtnOpen: TBitBtn;
    OD: TOpenDialog;
    Label1: TLabel;
    Bevel1: TBevel;
    BtnRun: TBitBtn;
    stPath: TEdit;
    procedure BtnOpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnRunClick(Sender: TObject);
    Function AltaPaqueteTabla(sDescripcion: String): Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  Procedure DoEjecutarPaqueteSQL;
var
  FrmSQLExec: TFrmSQLExec;
  sParametros, sDirectorio, sPaqueteSQL, sNombreArchivo: String;
  sUsuario, sPwd, sServicio: String;
  iVersionPQSQL: Integer;

const
  kFuncion = 'OPEN';
  kPrograma = 'SQLPLUS.exe';
  kVACIO = '';

implementation

{$R *.dfm}

uses
Globals,
uSuperRegistry,
uSagClasses,
uVersion;


procedure TFrmSQLExec.BtnOpenClick(Sender: TObject);
begin
if OD.Execute then
  stPath.Text:=OD.FileName;
end;


Procedure DoEjecutarPaqueteSQL;
Begin
With TFrmSQLExec.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;


procedure TFrmSQLExec.FormCreate(Sender: TObject);
begin
with TSuperRegistry.Create do
  Try
    RootKey := HKEY_LOCAL_MACHINE;
    if OpenKeyRead(BD_KEY) then
      Begin
        sUsuario:=  ReadString(USER_);
        sPwd:= ReadString(PASSWORD_);
        sServicio:= ReadString(ALIAS_);
      end;
  Finally
    Free;
  End;
end;


procedure TFrmSQLExec.BtnRunClick(Sender: TObject);
begin
with OD do
  If (ExtractFilename(FileName) <> kVACIO) and (stPath.Text <> kVACIO) then
  begin
    sNombreArchivo:=Copy(ExtractFilename(FileName),1,11);
    sDirectorio:=ExtractFilePath(FileName);
    sPaqueteSQL:='@'+ExtractFilename(FileName);
    sParametros:= sUsuario+'/'+sPwd+'@'+sServicio;
    try
      if MessageDlg('¿Esta seguro que desea correr el paquete SQL?', mtInformation, [mbYes, mbNo], 0) = MrYes then
        Begin
          If AltaPaqueteTabla(sNombreArchivo) then
            Begin
              If MessageDlg('     El paquete se ha ejecutado EXITOSAMENTE!'+#13+#10+'Por favor, enviar el archivo solicitado para control.'+#13+#10+''+#13+#10+'      ¿Desea ejecutar otro paquete SQL?', mtInformation, [mbYes, mbNo], 0) = mrNo then
                Close
              else
                Begin
                  stPath.Text:=kVACIO;
                  sNombreArchivo:= kVACIO;
                  sPaqueteSQL:=kVACIO;
                end;
            end;
        end;
    Except
      On E:Exception do
        MessageDlg('Se produjo el siguiente error'+#13#10+E.Message, mtError, [mbOK], 0);
    end;
  end;
end;


Function TFrmSQLExec.AltaPaqueteTabla(sDescripcion: String): Boolean;
var
NewPaqueteSQL: TVersiones;
Begin
Result:=False;
  try
    NewPaqueteSQL:=TVersiones.Create(MyBD);
    With NewPaqueteSQL do
      Begin
        Open;
        If not ExistePaqueteSQL(sDescripcion) then
          Begin
            AltaPaquete(sDescripcion);
            Application.ProcessMessages;
            ShellExecute(HANDLE,kFuncion, kPrograma, pchar(sParametros +' '+sPaqueteSQL),pchar(sDirectorio),SW_SHOW);
            Result:=true;
          end
        else
          MessageDlg('Ya existe un paquete con ese nombre!', mtError, [mbOK], 0);
      end;
  finally
    NewPaqueteSQL.Free;
    Application.ProcessMessages;
  end;
end;



end.

