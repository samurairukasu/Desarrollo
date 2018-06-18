unit Hashes;

interface

uses Windows, Forms, SysUtils, Classes;
 
function CheckSum(Stream: TStream): String; overload;
function CheckSum(Archivo: String): String; overload;
function StrCheckSum(Str: String): String;
 
implementation
 
type
   HCRYPTPROV = ULONG;
   PHCRYPTPROV = ^HCRYPTPROV;
   HCRYPTKEY = ULONG;
   PHCRYPTKEY = ^HCRYPTKEY;
   HCRYPTHASH = ULONG;
   PHCRYPTHASH = ^HCRYPTHASH;
   LPAWSTR = PAnsiChar;
   ALG_ID = ULONG;

const
   CRYPT_NEWKEYSET = $00000008;
   PROV_RSA_FULL = 1;
   ALG_TYPE_ANY = 0;
   ALG_CLASS_HASH = (4 shl 13);
   ALG_SID_MD5 = 3;
   CALG_MD5 = (ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_MD5);
   HP_HASHVAL = $0002;

function CryptAcquireContext(phProv: PHCRYPTPROV;
  pszContainer: LPAWSTR;
  pszProvider: LPAWSTR;
  dwProvType: DWORD;
  dwFlags: DWORD): BOOL; stdcall;
  external ADVAPI32 name 'CryptAcquireContextA';

function CryptCreateHash(hProv: HCRYPTPROV;
                         Algid: ALG_ID;
                         hKey: HCRYPTKEY;
                         dwFlags: DWORD;
                         phHash: PHCRYPTHASH
                         ): BOOL; stdcall; external ADVAPI32 name 'CryptCreateHash';

function CryptHashData(hHash: HCRYPTHASH;
                       const pbData: PBYTE;
                       dwDataLen: DWORD;
                       dwFlags: DWORD
                      ): BOOL; stdcall; external ADVAPI32 name 'CryptHashData';

function CryptGetHashParam(hHash: HCRYPTHASH;
                           dwParam: DWORD;
                           pbData: PBYTE;
                           pdwDataLen: PDWORD;
                           dwFlags: DWORD
                          ) : BOOL; stdcall; external ADVAPI32 name 'CryptGetHashParam';

function CryptDestroyHash(hHash: HCRYPTHASH
                         ): BOOL; stdcall; external ADVAPI32 name 'CryptDestroyHash';

function CryptReleaseContext(hProv: HCRYPTPROV;
                             dwFlags: DWORD
                            ): BOOL; stdcall; external ADVAPI32 name 'CryptReleaseContext';

// Calcula el hash de un stream
function CheckSum(Stream: TStream): String; overload;
var
   hProv: HCRYPTPROV;
   hHash: HCRYPTHASH;
   Buffer: PByte;
   BytesRead: DWORD;
   Data: array[1..16] of Byte;
   DataLen: DWORD;
   Success: BOOL;
   i: integer;

begin

   Result:= EmptyStr;
   Success := CryptAcquireContext(@hProv, nil, nil, PROV_RSA_FULL, 0);

   if (not Success) then
      if GetLastError() = DWORD(NTE_BAD_KEYSET) then
         Success := CryptAcquireContext(@hProv, nil, nil, PROV_RSA_FULL, CRYPT_NEWKEYSET);

   if Success then
   begin

      if CryptCreateHash(hProv, CALG_MD5, 0, 0, @hHash) then
      begin
         GetMem(Buffer,10*1024);
         try

            while TRUE do
            begin

               BytesRead:= Stream.Read(Buffer^, 10*1024);

               if (BytesRead = 0) then
               begin
                  DataLen := Sizeof(Data);
                  if (CryptGetHashParam(hHash, HP_HASHVAL, @Data, @DataLen, 0)) then
                  for i := 1 to 16 do
                     Result := Result + LowerCase(IntToHex(Integer(Data[i]), 2));
                  break;
               end;

               if (not CryptHashData(hHash, Buffer, BytesRead, 0)) then
                  break;

               Application.ProcessMessages;

            end;

         finally

            FreeMem(Buffer);

         end;

         CryptDestroyHash(hHash);

      end;

     CryptReleaseContext(hProv, 0);

   end;

end;

// Calcula el hash de un Archivo
function CheckSum(Archivo: String): String; overload;
var
   Stream: TFileStream;

begin

   Result:= EmptyStr;

   if FileExists(Archivo) then
   try

      Stream:= TFileStream.Create(Archivo,fmOpenRead or fmShareDenyWrite);

      try
         Result:= CheckSum(Stream);
      finally
         Stream.Free;
      end;

   except
   end;

end;

// Calcula el hash de un String
function StrCheckSum(Str: String): String;
var
   Stream: TStringStream;

begin

   Result:= EmptyStr;

   Stream:= TStringStream.Create(Str);

   try
      Result:= CheckSum(Stream);
   finally
      Stream.Free;
   end;

end;

end.
