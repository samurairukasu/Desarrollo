unit VerificarSupervisor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, DPFPCtlXLib_TLB, DB, ADODB,DPFPShrXLib_TLB,DPFPEngXLib_TLB,
  FMTBcd, SqlExpr, Provider, DBClient, ExtCtrls, RxGIF, Buttons;

type
  TVerificarSupervisor = class(TForm)
    DS_Contactos_Sel: TDataSource;
    CDS_CONTACTO_SEL: TClientDataSet;
    dspContactos_Sel: TDataSetProvider;
    sdsContactos_Sel: TSQLDataSet;
    Image1: TImage;
    edtPassword: TEdit;
    Label1: TLabel;
    edtNombreUsuario: TEdit;
    lblNombreUsuario: TLabel;
    btnAceptar: TBitBtn;
    function VerifyString: boolean;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }

  end;
  Function getSupervisor(var nomSupervisor: string;var pasSupervisor: string): Boolean;

var
  Verify: TVerificarSupervisor;
  existe: boolean;
  var intentos: integer;
implementation

{$R *.dfm}
uses globals;

Function getSupervisor(var nomSupervisor: string;var pasSupervisor: string): Boolean;
begin
    Result:=false;
    intentos:=0;
    try
        with TVerificarSupervisor.Create(Application) do
        try
            if ShowModal = mrOk
            then begin
                if existe then
                begin
                  nomSupervisor:=edtNombreUsuario.text;
                  pasSupervisor:=edtPassword.text;
                end
                else
                begin
                  nomSupervisor:='';
                  pasSupervisor:='';
                end;

                Result:=true;
            end;
        finally
            Free
        end
    finally
        Application.ProcessMessages
    end
end;

procedure TVerificarSupervisor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Verify:=Nil;
end;

procedure TVerificarSupervisor.FormCreate(Sender: TObject);
begin
 // verifier:= CoDPFPVerification.Create;
end;

function TVerificarSupervisor.VerifyString: boolean;
var
  usuario: integer; fSQL : TStringList; BlobS: TStream;
   BlobField: TBlobField;
  bStream: TStream;   var Stream : TMemoryStream;
Begin
       existe:=false;
       fSQL:= TStringList.Create();
       with CDS_CONTACTO_SEL do
       begin
            Close;
            sdsContactos_Sel.SQLConnection := MyBD;
            fSQL.CLEAR;
            CommandText:='select supervisor from tusuario where nombre='''+edtNombreUsuario.Text+'''';
            sdsContactos_Sel.CommandText:= fSQL.Text;
            Open;
      end;

      if cds_Contacto_sel.FieldByName('supervisor').value=1 then existe:=true;

      result := existe;
end;

procedure TVerificarSupervisor.btnAceptarClick(Sender: TObject);
begin
    VerifyString;
    ModalResult := mrOk;

end;

procedure TVerificarSupervisor.btnCancelarClick(Sender: TObject);
begin
    ModalResult:= mrCancel;
end;

end.
