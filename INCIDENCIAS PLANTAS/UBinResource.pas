unit UBinResource;

interface

Uses WinSpool, QRPrntr, Printers, Windows, SysUtils, Dialogs;

var
Listado_Bin: Array of Word;
TotalBin: Integer;
QRB : TQRBin;

Function fOutPutBin(IndexPrinter: Integer): SetofTQRBin;
Function CantidadPrinter: Integer;


implementation


Function CantidadPrinter: Integer;
var
nCont: Integer;
Begin
  try
    For nCont:=0 to (Printer.Printers.Count - 1) do
      Result:=nCont;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;










Function fOutPutBin(IndexPrinter: Integer): SetofTQRBin;
type
TBinarray = array [1..High(Integer) div Sizeof(Word)] of Word;
PBinArray   = ^TBinArray;
var
I, IA,numBins: Integer;
pBins, BinArray: PBinarray;
Device, Driver, Port: array [0..1024] of Char;
hDevMode: THandle;
FOutputBins: SetofTQRBin;
begin
Listado_Bin:=nil;
FOutputBins := [];
Printer.PrinterIndex := IndexPrinter;
Printer.GetPrinter(Device, Driver, Port, hDevmode);
numBins     := WinSpool.DeviceCapabilities(Device, Port, DC_BINS, nil, nil);
if numBins > 0 then
  begin
    BinArray:=nil;
    GetMem(pBins, numBins * Sizeof(Word));
    try
      WinSpool.DeviceCapabilities(Device, Port, DC_BINS,Pchar(pBins), nil );
      SetLength(Listado_Bin, numBins);
      TotalBin:=numBins;
      For i:= 1 to numBins do
        begin
          Listado_Bin[I-1]:=pBins^[i];;
        end;
      QRB:=First;
      For IA:= 0 to (TotalBin-1) do
        begin
        for QRB:= First to Last do
          begin
            if (cQRBinTranslate[QRB]) = (Listado_Bin[IA]) then
              begin
                Include(FOutputBins, (QRB));
                break;
              end;
          end;
        QRB:=First;
        end;
    if pBins <> nil then
      FreeMem(pBins);
    except
      On E: Exception  do
        MessageDlg(E.message, mtError, [mbOK], 0);
    end;
    Result:=FOutPutBins;
  end;
end;

{
  procedure GPaperSize;
  var
    aSize : integer;
    I : TQRPaperSize;
  begin
    FPaperSize := Default;
    if Supported(dm_papersize) then
    begin
      aSize := DevMode^.dmPaperSize;
      for I := Default to Custom do
      begin
        if aSize=cQRPaperTranslate[I] then
        begin
          FPaperSize := I;
          exit;
        end
      end
    end
  end;

  procedure GPaperDim;
  var
    PSize : TPoint;
  begin
    PSize.X := GetDeviceCaps(FPrinter.Handle, PHYSICALWIDTH);
    PSize.Y := GetDeviceCaps(FPrinter.Handle, PHYSICALHEIGHT);
    FPaperWidth := round(PSize.X / PixelsPerX * 254);
    FPaperLength := round(PSize.Y / PixelsPerY * 254);
  end;

{$ifndef ver110}

{  procedure GPaperSizes;
  var
    DCResult : array of word;
    I : integer;
    J : TQRPaperSize;
    Count : integer;
  begin
    Count := DeviceCapabilities(FDevice, FPort, DC_PAPERS, nil, DevMode);
    SetLength(DCResult, Count);
    Fillchar(Pointer(DCResult)^, Count * Sizeof(word), #0);
    Fillchar(FPaperSizes,Sizeof(FPaperSizes),#0);
    Count := DeviceCapabilities(FDevice, FPort, DC_PAPERS, PChar(DCResult), DevMode);
    for I := 0 to Count - 1 do
    begin
      for J := Default to Custom do
      begin
        if cQRPaperTranslate[J] = DCResult[I] then
        begin
          FPaperSizes[J] := true;
          break;
        end
      end
    end;
    FPaperSizes[Custom] := true;
  end;
{$endif}



end.
