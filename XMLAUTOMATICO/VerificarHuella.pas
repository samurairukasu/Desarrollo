unit VerificarHuella;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, DPFPCtlXLib_TLB, DB, ADODB,DPFPShrXLib_TLB,DPFPEngXLib_TLB,
  FMTBcd, SqlExpr, Provider, DBClient, ExtCtrls, RxGIF;

type
  TVerify = class(TForm)
    DPFPVerificationControl1: TDPFPVerificationControl;
    ADOQuery1: TADOQuery;
    DS_Contactos_Sel: TDataSource;
    CDS_CONTACTO_SEL: TClientDataSet;
    dspContactos_Sel: TDataSetProvider;
    sdsContactos_Sel: TSQLDataSet;
    Image1: TImage;
    procedure DPFPVerificationControl1Complete(ASender: TObject;
      const pFeatureSet, pStatus: IDispatch);
    function VerifyTemplate(const pFeatureSet: IDispatch; const Template: DPFPShrXLib_TLB.DPFPTemplate): boolean;
    function VerifyString(const pFeatureSet: IDispatch): boolean;
    function MemoryStreamToOleVariant(Strm: TMemoryStream): OleVariant;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }

  end;
  Function GetUsuario(var idUsuario: integer;var nombreUsuario: string;var pasUsuario: string): Boolean;

var
  Verify: TVerify;
  verifier : DPFPEngXLib_TLB.DPFPVerification;
  regTemplate1:DPFPShrXLib_TLB.DPFPTemplate;
  clientEncryptionKey: string;
  existe: boolean;
  usuario: integer;
  nombre,password:string;


implementation

{$R *.dfm}
uses globals;

Function GetUsuario(var idUsuario: integer;var nombreUsuario: string;var pasUsuario: string): Boolean;
begin
    Result:=false;
    try
        with TVerify.Create(Application) do
        try
            if ShowModal = mrOk
            then begin
                idUsuario:=usuario;
                nombreUsuario:=nombre;
                pasUsuario:=password;
                Result:=existe;
            end;
        finally
            Free
        end
    finally
        Application.ProcessMessages
    end
end;


function TVerify.VerifyTemplate(const pFeatureSet: IDispatch;
  const Template: DPFPShrXLib_TLB.DPFPTemplate): boolean;
begin
  result := DPFPEngXLib_TLB.DPFPVerificationResult(verifier.Verify(pFeatureSet,
    Template)).Verified;
end;

procedure TVerify.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Verify.Destroy;
  Verify:=Nil;
end;

procedure TVerify.FormCreate(Sender: TObject);
begin
//  TestOfBD('','','',true);
  verifier:= CoDPFPVerification.Create;
end;

function TVerify.VerifyString(const pFeatureSet: IDispatch): boolean;
var
   fSQL : TStringList; BlobS: TStream;
   BlobField: TBlobField;
  bStream: TStream;   var Stream : TMemoryStream;
Begin


       fSQL:= TStringList.Create();

        with CDS_CONTACTO_SEL do
        begin
            Close;
            sdsContactos_Sel.SQLConnection := MyBD;
            fSQL.CLEAR;
            CommandText:='select idusuario,nombre,huella as template,nvl(clave,'' '') as clave from tusuario';
            sdsContactos_Sel.CommandText:= fSQL.Text;
            Open;
        end;

  usuario:=-1;
  CDS_CONTACTO_SEL.First;
  existe:=false;
  while (cds_Contacto_sel.FieldByName('idusuario').value<>usuario) and (existe=false) do
  begin
    Stream := TMemoryStream.Create;
    TBlobField(cds_Contacto_sel.FieldByName('template')).SaveToStream(Stream);
    regTemplate1 := DPFPShrXLib_TLB.CoDPFPTemplate.Create();
    regTemplate1.Deserialize(MemoryStreamToOleVariant(Stream));
    GLOBALS.ID_USUARIO_LOGEO_SAG:= cds_Contacto_sel.FieldByName('idusuario').value;
    usuario:= cds_Contacto_sel.FieldByName('idusuario').value;
    nombre:= cds_Contacto_sel.FieldByName('nombre').value;
    password:= cds_Contacto_sel.FieldByName('clave').value;
    existe := VerifyTemplate(pFeatureSet, regTemplate1);
    CDS_CONTACTO_SEL.Next;
  end;
  result := existe;
end;

function TVerify.MemoryStreamToOleVariant(Strm: TMemoryStream): OleVariant;
var
  Data: PByteArray;
begin
  Result := VarArrayCreate([0, Strm.Size - 1], varByte);
  Data := VarArrayLock(Result);
  try
    Strm.Position := 0;
    Strm.ReadBuffer(Data^, Strm.Size);
  finally
    VarArrayUnlock(Result);
  end;
end;


procedure TVerify.DPFPVerificationControl1Complete(ASender: TObject;
  const pFeatureSet, pStatus: IDispatch);
  var
  Id:integer;
begin

    VerifyString(pFeatureSet);

    ModalResult := mrOk;

end;

end.
