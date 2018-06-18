unit ufCertAnulad;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, SQLExpr, Mask, ToolEdit, ucdialgs, ExtCtrls, globals,
  DBCtrls, USAGClasses;

const
  WM_SEGUIRANUL=WM_USER+2;
  FICHERO_ACTUAL = 'ufOblAnulad';

type
  TfmCertAnul = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    edmotivo: TEdit;
    btnaceptar: TBitBtn;
    btnsalir: TBitBtn;
    defecha: TDateEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    EdNumOblea: TEdit;
    procedure btnaceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EdNumObleaKeyPress(Sender: TObject; var Key: Char);
    procedure btnsalirClick(Sender: TObject);
  private
    { Private declarations }
     procedure RegistObleaDeVehicDesconocido(var Msge:TMessage); message WM_SEGUIRANUL;
     function datoscompletos:boolean;
     Procedure LimpiarDatos;
  public
    { Public declarations }
  end;
  procedure DoCertAnulado;

//const RegistrarOblea:boolean = true;

var
  fmCertAnul: TfmCertAnul;
  fOblea:TOblea;
  RegistrarOblea:boolean;

implementation

{$R *.DFM}

uses
  uftmp, USAGESTACION, uLogs;


Procedure TfmCertAnul.LimpiarDatos;
var
I: Integer;
Begin
For I:=0 To ComponentCount-1 do
  if Components[I] is TEdit then
    TEdit(Components[I]).Text:='';
EdNumOblea.SetFocus;
end;


Function NroInspecCombo(Cadena:String):String;
var
I: Integer;
Begin
I:=1;
Result:='';
While Cadena[I] <> '-' do
  Begin
    Result:=Result+Cadena[I];
    Inc(I);
  end;
Result:=TrimRight(Result);
end;


procedure DoCertAnulado;
begin
RegistrarOblea:= true ;
with TfmCertAnul.Create(Application.MainForm) do
  try
    ShowModal;
  finally
    Free;
  end;
end;


procedure TfmCertAnul.RegistObleaDeVehicDesconocido(var Msge:TMessage);
begin
if Msge.Msg=0 then
  RegistrarOblea:=true;
if Msge.WParam=1 then
   RegistrarOblea:=false;
end;


procedure TfmCertAnul.btnaceptarClick(Sender: TObject);
var
ID,Nrevis:integer;
begin
RegistrarOblea:=true;

  if datoscompletos then
    try
          with TSQLQuery.Create(self) do
          try
            SQLConnection:=mybd;
            sql.add('alter session set nls_date_format = ''dd/mm/yyyy''');
            execsql;
            close;
            sql.clear;
            SQL.Add('SELECT CODINSPE FROM CERTIFICADOINSPECCION WHERE NROCERTIFICADO=:numcertif');
            ParamByName('numcertif').AsString:=ednumoblea.Text;
            Open;

            {
            if (not IsEmpty) then
              if MessageDlg(caption,'Certificado utilizado. ¿Esta Ud seguro que desea seguir?',mtConfirmation,[mbYes,mbNo],mbyes,0)=mrYes then
                RegistrarOblea:=true
              else
                RegistrarOblea:=false; }
            if (not IsEmpty) then
            begin
              RegistrarOblea:=false;
              messagedlg(caption,'Ese certificado esta asignado a una inspección',mtInformation,[mbOK],mbOK,0);
            end;

            if RegistrarOblea then
            begin
                Close;
                sql.clear;
                SQL.Add('SELECT NUMCERTIF FROM TCERTIFICADOS WHERE NUMCERTIF=:numcertif');
                ParamByName('numcertif').AsString:=ednumoblea.Text;
                Open;
                if (IsEmpty) then
                begin
                  RegistrarOblea:=false;
                  messagedlg(caption,'Ese certificado no esta disponible',mtInformation,[mbOK],mbOK,0);
                end;
            end;

            if RegistrarOblea then
            begin
                Close;
                sql.clear;
                SQL.Add('SELECT NUMCERTIF FROM TCERTIFICADOS WHERE ESTADO=''A'' and NUMCERTIF=:numcertif');
                ParamByName('numcertif').AsString:=ednumoblea.Text;
                Open;
                if (IsEmpty) then
                begin
                  Close;
                  sql.clear;
                  SQL.Add('SELECT NUMCERTIF FROM TCERTIFICADOS_ANULADOS WHERE NUMCERTIF=:numcertif');
                  ParamByName('numcertif').AsString:=ednumoblea.Text;
                  Open;
                end;
                if (not IsEmpty) then
                begin
                    RegistrarOblea:=false;
                    messagedlg(caption,'Ese certificado ya esta anulado',mtInformation,[mbOK],mbOK,0);
                end
            end;

            if RegistrarOblea then
            begin
                  Close;
                  SQL.Clear;
                  SQL.Add('UPDATE TCERTIFICADOS set estado=''A'',fecha_anulado=sysdate where numcertif=:NUMCERTIF ');
                  ParamByName('NUMCERTIF').AsString:=ednumoblea.Text;
                  ExecSQL;
                  SQL.Clear;
                  SQL.Add('INSERT INTO TCERTIFICADOS_ANULADOS(CODANULAC,FECHA,NUMCERTIF,MOTIVO,AUTORIZO) ');     //
                  SQL.Add('VALUES(sq_tcertificados_anulados.nextval,:FECHA,:NUMCERTIF,:MOTIVO,:AUTORIZO)');      //
                  ParamByName('FECHA').AsString:=defecha.Text;
                  ParamByName('NUMCERTIF').AsString:=ednumoblea.Text;
                  ParamByName('MOTIVO').AsString:=edmotivo.Text;
                  Nrevis:= id_usuario_logeo_sag;
                  ParamByName('AUTORIZO').AsInteger:=Nrevis;
                  ExecSQL;
                  ShowMessage(caption,'Se ha anulado el certificado '+ednumoblea.Text+' con exito!!!');
            end


          finally
          Free;
          end;
          btnsalir.Enabled:=true;
          LimpiarDatos;

    Except
      Begin
        btnsalir.Enabled:=true;
      end;
  end
end;


procedure TfmCertAnul.FormCreate(Sender: TObject);
begin
defecha.Date:=Date;
end;


procedure TfmCertAnul.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key=#13 then
  begin
    Perform(WM_NEXTDLGCTL,0,0);
    Key:=#0;
  end;
if Key = chr(VK_ESCAPE) then
  close;
end;


function TfmCertAnul.datoscompletos:boolean;
begin
result:=false;
  if ednumoblea.text = '' then
  begin
    messagedlg(caption,'Se debe ingresar el número de certificado a anular',mtError,[mbOK],mbOK,0);
    ednumoblea.setfocus;
    exit;
  end;
  if defecha.text = '  /  /    ' then
  begin
    messagedlg(caption,'Se debe ingresar la fecha',mtError,[mbOK],mbOK,0);
    defecha.setfocus;
    exit;
  end;
  if edmotivo.text = '' then
  begin
    messagedlg(caption,'Se debe ingresar el motivo de la anulación',mtError,[mbOK],mbOK,0);
    edmotivo.setfocus;
    exit;
  end;
  result:=true;
end;

procedure TfmCertAnul.EdNumObleaKeyPress(Sender: TObject; var Key: Char);
begin
if not (Key in ['0'..'9',#8]) then
  key := #0
end;


procedure TfmCertAnul.btnsalirClick(Sender: TObject);
begin
Close;
end;

end.
