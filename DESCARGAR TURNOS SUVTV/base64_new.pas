unit base64_new;

interface

uses Windows, SysUtils, Classes,wcrypt2,Hashes;

function BinToStr(Binary: PByte; Len: Cardinal): String;
procedure StrToStream(Str: String; Stream: TStream);
function md5(const Input: String): String;
function md5_suvtv(const Input: String): String;

implementation

const
  CRYPT_STRING_BASE64 = 1;

function CryptBinaryToString(pbBinary: PByte; cbBinary: DWORD; dwFlags: DWORD;
  pszString: PChar; var pcchString: DWORD): BOOL; stdcall;
  external 'Crypt32.dll' name 'CryptBinaryToStringA';

function CryptStringToBinary(pszString: PChar; cchString: DWORD; dwFlags: DWORD;
  pbBinary: PByte; var pcbBinary: DWORD; pdwSkip: PDWORD;
  pdwFlags: PDWORD): BOOL; stdcall;
  external 'Crypt32.dll' name 'CryptStringToBinaryA';

function BinToStr(Binary: PByte; Len: Cardinal): String;
var
  Count: DWORD;
begin
  Count:= 0;
  if CryptBinaryToString(Binary,Len,CRYPT_STRING_BASE64,nil,Count) then
  begin
    SetLength(Result,Count);
    if not CryptBinaryToString(Binary,Len,CRYPT_STRING_BASE64,PChar(Result),
      Count) then
      Result:= EmptyStr;
  end;
end;

 function md5_suvtv(const Input: String): String;
 var cadena_md5:string;
 begin
   cadena_md5:=checksum(input);
   md5_suvtv:=cadena_md5;
 end;

function md5(const Input: String): String;
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


procedure StrToStream(Str: String; Stream: TStream);
var
  Buffer: PByte;
  Count: DWORD;
begin
  Count:= 0;
  if CryptStringToBinary(PChar(Str),Length(Str),CRYPT_STRING_BASE64,nil,Count,
    nil,nil) then
  begin
    GetMem(Buffer,Count);
    try
      if CryptStringToBinary(PChar(Str),Length(Str),CRYPT_STRING_BASE64,Buffer,
        Count,nil,nil) then
        Stream.WriteBuffer(Buffer^,Count);
    finally
      FreeMem(Buffer);
    end;
  end;
end;

end.
