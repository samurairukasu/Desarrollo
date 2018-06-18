unit UfConfigurarRuta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IniFiles, FileCtrl, ComCtrls, ShellCtrls, DateUtil;

type
  TfrmConfigurarRuta = class(TForm)
    Label1: TLabel;
    BtnGuardar: TBitBtn;
    BtnCancelar: TBitBtn;
    SCBx: TShellComboBox;
    SLV: TShellListView;
    Barra: TStatusBar;
    procedure BtnGuardarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  procedure DoConfigurarRutaArchivos;

var
  frmConfigurarRuta: TfrmConfigurarRuta;
  ArchivoIni: TIniFile;

implementation

uses
Globals;

{$R *.dfm}

procedure DoConfigurarRutaArchivos;
Begin
with TfrmConfigurarRuta.Create(Application) do
  Try
    Showmodal;
  finally
    Free;
    Application.ProcessMessages;
  end;
end;


procedure TfrmConfigurarRuta.BtnGuardarClick(Sender: TObject);
begin
ArchivoIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+'\Config.ini');
ArchivoIni.WriteString('Ruta','Archivos_destino',SCBx.Path);
  if MessageDlg('Se ha guardado la dirección de destino'+#13+#10+'de los archivos.', mtInformation, [mbOK], 0) = mrOk then
    close;
end;


procedure TfrmConfigurarRuta.FormCreate(Sender: TObject);
var
Anio, Mes: Integer;
Meses, Ruta_Archivos: String;
begin
Anio:=(ExtractYear(IncYear(now,0)));
Mes:= (ExtractMonth(IncMonth(now,-1)));
Meses:= IntToStr(Mes);
if Mes < 10 then
  Meses:='0'+Meses;
  try
    ArchivoIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+'\Config.ini');
    Ruta_Archivos:=ArchivoIni.ReadString('Ruta','Archivos_destino','');
    Barra.Panels[1].Text:=Ruta_Archivos;
  Except
    On E: Exception Do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

end.



if not DirectoryExists(Destino_Archivos+'\Informes Estadisticos') then
