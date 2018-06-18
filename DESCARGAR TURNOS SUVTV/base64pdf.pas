unit base64pdf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IdBaseComponent,
  IdCoder, IdCoder3to4, IdCoderUUE,
  Dialogs, StdCtrls, Grids, DBGrids, DB, Buttons, ExtCtrls,ActiveX, ComObj,wcrypt2;

type
Tbase64Pdf = class
  protected
      IDBASE64: TIdEncoderUUE;
      b64:string;
      s_md5:string;
      function md5(const Input: String): String;
      FUNCTION base64(Input: String):string;
  public
     FUNCTION Genera_base64(const Input: String):boolean;
     Property ver_base64:string read   b64;
     Property ver_md5:string read   s_md5;
end;

implementation
FUNCTION Tbase64Pdf.base64(Input: String):string;
var 
source, target : TFileStream; 
encoded ,hash_md5: string;
begin
source := TFileStream.Create(Input, fmOpenRead);
IDBASE64:=TIdEncoderUUE.Create(application);
encoded := IDBASE64.Encode(sourCE,2147483647);
IDBASE64.Free;
base64:=encoded;

end;


FUNCTION Tbase64Pdf.Genera_base64(const Input: String):boolean;
begin
b64:=base64(Input);
s_md5:=md5(b64);

end;

function Tbase64Pdf.md5(const Input: String): String;
var
  hCryptProvider: HCRYPTPROV;
  hHash: HCRYPTHASH;
  bHash: array[0..$7f] of Byte;
  dwHashBytes: Cardinal;
  pbContent: PByte;
  i: Integer;
begin
  dwHashBytes := 16;
  pbContent := Pointer(PChar(Input));
  Result := '';
  if CryptAcquireContext(@hCryptProvider, nil, nil, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT or CRYPT_MACHINE_KEYSET) then
  begin
    if CryptCreateHash(hCryptProvider, CALG_MD5, 0, 0, @hHash) then
    begin
      if CryptHashData(hHash, pbContent, Length(Input) * sizeof(Char), 0) then
      begin
        if CryptGetHashParam(hHash, HP_HASHVAL, @bHash[0], @dwHashBytes, 0) then
        begin
          for i := 0 to dwHashBytes - 1 do
          begin
            Result := Result + Format('%.2x', [bHash[i]]);
          end;
        end;
      end;
      CryptDestroyHash(hHash);
    end;
    CryptReleaseContext(hCryptProvider, 0);
  end;
  Result := AnsiLowerCase(Result);
end;

end.
