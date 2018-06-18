unit digitalizaHuella;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,DPFPShrXLib_TLB,DPFPCtlXLib_TLB, DB, ADODB, ComCtrls, ToolWin,
  OleCtrls, ImgList, FMTBcd, SqlExpr, Provider, DBClient;

type
  TEnroll = class(TForm)
    DPFPEnrollmentControl1: TDPFPEnrollmentControl;
    ADOQuery1: TADOQuery;
    ImageList1: TImageList;
    SQLStoredProc1: TSQLStoredProc;
    procedure DPFPEnrollmentControl1Enroll(ASender: TObject;
      lFingerMask: Integer; const pTemplate, pStatus: IDispatch);
    procedure ToolButton2Click(Sender: TObject);
    procedure Finalizar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    function OleVariantToMemoryStream(OV: OleVariant): TMemoryStream;
  private
    { Private declarations }
  public
    { Public declarations }
    regTemplate: DPFPShrXLib_TLB.DPFPTemplate;


  end;
  Function SetHuella(var idUsuario: integer): Boolean;
var
  Enroll: TEnroll;
  clientEncryptionKey: string;
  idUsuarioHuella: integer;

implementation

{$R *.dfm}
 uses globals;

Function SetHuella(var idUsuario: integer): Boolean;
begin
    Result:=false;
    idUsuarioHuella:=idUsuario;
    try
        with TEnroll.Create(Application) do
        try
            if ShowModal = mrOk
            then begin
                Result:=true;
            end;
        finally
            Free
        end
    finally
        Application.ProcessMessages
    end
end;

procedure TEnroll.DPFPEnrollmentControl1Enroll(ASender: TObject;
  lFingerMask: Integer; const pTemplate, pStatus: IDispatch);
begin
  regTemplate := DPFPShrXLib_TLB.DPFPTemplate(pTemplate);
  //idUsuarioHuella:=1;
  Finalizar;
  ModalResult := mrOk;
end;

procedure TEnroll.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Enroll.Destroy;
  Enroll:=nil;
end;

procedure TEnroll.Finalizar;
var
  i:Integer;  fSQL : TStringList;  ms :TMemoryStream;
begin
  if regTemplate <> nil then
  begin
      with SQLStoredProc1 do
      begin
          SQLStoredProc1.sqlConnection:=MyBD;
          StoredProcName := 'digitalizar_huella';
          ms:=OleVariantToMemoryStream(regTemplate.Serialize);
          Params.ParamByName('huellaTemplate').LoadFromStream(ms,ftBlob);
          Params.ParamByName('idUsuarioHuella').value:=idUsuarioHuella;
          ExecProc;
      end;
  end;
end;

function TEnroll.OleVariantToMemoryStream(OV: OleVariant): TMemoryStream;
var
  Data: PByteArray;
  Size: integer;
begin
  Result := TMemoryStream.Create;
  try
    Size := VarArrayHighBound(OV, 1) - VarArrayLowBound
      (OV, 1) + 1;
    Data := VarArrayLock(OV);
    try
      Result.Position := 0;
      Result.WriteBuffer(Data^, Size);
    finally
      VarArrayUnlock(OV);
    end;
  except
    Result.Free;
    Result := nil;
  end;
end;

procedure TEnroll.ToolButton2Click(Sender: TObject);
begin
  Close;
end;

procedure TEnroll.FormCreate(Sender: TObject);
begin
TestOfBD('','','',true);
end;

end.
