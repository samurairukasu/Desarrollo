{*********************************************************}
{                                                         }
{     TExcel Component 3.0                                }
{                                                         }
{     Copyright (c) 1996, 1998 by                         }
{                                                         }
{       Stefan Hoffmeister                                }
{         Stefan.Hoffmeister@PoBoxes.com                  }
{         Stefan.Hoffmeister@Uni-Passau.de                }
{                                                         }
{   and (portions)                                        }
{                                                         }
{       Tibor F. Liska                                    }
{       Tel/Fax:    00-36-1-165-2019                      }
{       Office:     00-36-1-269-8284                      }
{       E-mail: liska@sztaki.hu                           }
{                                                         }
{   This component may be used freely.                    }
{                                                         }
{                                                         }
{   The UltraFast Excel DDE code is copyright 1997, 1998  }
{   by Stefan Hoffmeister.                                }
{                                                         }
{   The UltraFast code may only be used (and usually will }
{   only be available) if a licence fee has been paid.    }
{                                                         }
{     http://www.shareit.com/programs/100506.htm          }
{                                                         }
{   Unauthorized distribution of the UltraFast code       }
{   is strictly prohibited and a violation of copyright   }
{   law.                                                  }
{                                                         }
{*********************************************************}
{*********************************************************}
{                                                         }
{  Possible enhancements:                                 }
{    Add native database export code                      }
{    Improve Assign and AssignTo methods (T...XlTableData)}
{    Add example code for cell formatting                 }
{    Add more examples to the online help                 }
{                                                         }
{    Check Delphi 1 RTL whether Dispose and FreeMem       }
{       test for nil before freeing; in that case         }
{       we could get rid of redundant tests in this       }
{       unit to improve performance (slightly)            }
{                                                         }
{*********************************************************}
unit Excels;

{.$DEFINE Debug}
{$IFNDEF Debug}
  {$D-} {$Q-} {$R-} {$S-} {$O-}
{$ENDIF Debug}


{ code for long file/pathnames in Delphi 1; disable this
  if you do not want to have generic thunking }

{$DEFINE UseGenericThunks}
{.$UNDEF UseGenericThunks}



{ this makes the high-speed code available }

{$DEFINE UltraSpeed}
{.$UNDEF UltraSpeed}


{ if the high-speed code is available, defining SpeedDemo
  will cripple the component; about half of the data transferred
  will be altered. }

{.$DEFINE SpeedDemo}
{$UNDEF SpeedDemo}


{ this will change the declaration of TExcelRow and TExcelCol
  to an integer SUB-range, allowing for type-compatibility testing  }

{$DEFINE ExcelsStrict}
{.$UNDEF ExcelsStrict}


{ For Borland C++ Builder 3.0 (BCB 3.0) compatibility we need
  to export all symbols }

{$IFDEF BCB}
  {$ObjExportAll On}
{$ENDIF BCB}

interface

uses
{$IFDEF Win32}
  // dbugintf,
  Windows,
{$ELSE}
  WinProcs, WinTypes,
{$ENDIF Win32}
  Forms, Classes, DdeMan, SysUtils;

{$IFDEF Win32}
   // leave this turned on - it is required by the code!
   {$LONGSTRINGS ON}
{$ELSE}
type
  AnsiString = string;
{$ENDIF Win32}


{$IFDEF VER100}
resourcestring
{$ELSE}
const
{$ENDIF VER100}
  msgFailedTransfer = 'Data transfer to Excel failed';
  msgNotConnected = 'No open DDE connection to Excel';
  msgExcelNoReply = '*** Excel - No Reply ***';
  msgStrError = 'String transfer error';
  msgCouldNotLaunch = 'Excel could not be launched';
  msgCmdAcceptErr = '"%s" not accepted by Excel';
  msgNoRowCol = 'Could not identify letters for row and/or column';
  msgBadCellFmt = 'Unexpected Excel cell format';
  msgNoMacroFile = 'No open macro file';
  msgTableNotReady = 'Table not ready';
  msgReservedType = 'Use of reserved type';
  msgArrayMove = 'Putting an array needs auto-moving cell!';
  msgNotSupported = 'Data type not supported';
  msgCacheSize = 'Cache size must not be supported during caching operation';
  msgEndUpdate = 'EndUpdate has been called too often';
  msgWinAPI = 'Windows API: Invalid handle';



type
{ The following descendant of TDdeClientConv is only for fixing
  a severe bug in the Borland C++ Builder 3.0 of RequestData
  For all other compilers this is a no-op }
  TBCBFixedDdeClientConv = class(TDdeClientConv)
  public
    {$IFDEF VER110}
      function RequestData(const Item: string): PChar;
    {$ENDIF VER110}
  end;
  

type
  TCellDir = (dirNone, dirUp, dirDown, dirLeft, dirRight);

  TNewSheet = ( FromTemplate,
                FromActiveSheet,
                Sheet,
                ChartSelection,
                Macro,
                IntMacro,
                Reserved,
                VBModule,
                Dialog);

(*
    This is part old source code that has been left in for demonstration.
    Feel free to expoit it, but note that there will be no support for it.

  TExcelUpdateLinks = ( excelNoUpdate,
                        excelUpdateExternal,
                        excelUpdateRemote,
                        excelUpdateAll);

  TExcelFileDelimiter = ( excelDefaultDelimit,
                          excelTabs,
                          excelCommas,
                          excelSpaces,
                          excelSemicolons,
                          excelNothing,
                          excelCustom);

  TExcelFileOrigin = ( excelDefaultOrigin,
                       excelMacintosh,
                       excelWindows,
                       excelMSDOS);


  TExcelFileAccess = ( excelUnknownAccess,
                       excelRevertToSaved,
                       excelReadWriteAccess,
                       excelReadOnlyAccess);
*)

  ExcelError = class(Exception);

  TExcelRow = {$IFDEF ExcelsStrict} 1..16384 {$ELSE} integer {$ENDIF ExcelsStrict};
  TExcelCol = {$IFDEF ExcelsStrict} 1..256   {$ELSE} integer {$ENDIF ExcelsStrict};

  TExcelCell = record
    Col: TExcelCol;
    Row: TExcelRow;
  end;

type
  PExcelSelectionArray = ^TExcelSelectionArray;
  TExcelSelectionArray = record
    TopLeft    : TExcelCell;
    BottomRight: TExcelCell;
  end;





  { This is a local definition of the file extension type }
  {$IFDEF Windows}
    TFileExt = string[4]; { dot + three letters }
  {$ELSE}
    TFileExt = type string;
  {$ENDIF Windows}




  TCustomExcel = class(TComponent)
  private
    { a most severe bug in BCB 3.0 requires this change }
    FDDEClientConv: TBCBFixedDdeClientConv; { TDdeClientConv; }
    FDDEClientItem: TDDEClientItem;
    FFileExt: TFileExt;
    FExecutable: TFilename;
    FExeName: TFileName;
    FDDELaunch: Boolean;

    FProtocolsList: TStringList;
    FEditEnvItemsList: TStringList;
    FTopicsList: TStringList;
    FFormatsList: TStringList;

    FConnected: Boolean;
    FOnClose: TNotifyEvent;
    FOnOpen: TNotifyEvent;

    FExcelTimeout: boolean;
    FIgnoreErrors: boolean;

    FBeginWait: TNotifyEvent;
    FEndWait: TNotifyEvent;
    FWaiting: TNotifyEvent;

    FRowChar: Char;
    FColChar: Char;

    FSelectionList: TStringList;

    FExecCount: cardinal;
    FBurstCount: integer;

    function GetDDEClientConv: TDdeClientConv;

    procedure SetExeName(const Value: TFileName);
    procedure SetConnect(Value: Boolean);
    function GetReady: Boolean;
    function GetFormats: TStringList;
    function GetTopics: TStringList;
    function GetProtocols: TStringList;
    function GetEditEnvItems: TStringList;
    function GetSelection: string;
    function GetCurrentSheet: string;

    procedure OpenLink(Sender: TObject);
    procedure ShutDown(Sender: TObject);

    procedure CheckCellCharsOK; { will test, try and throw an exception }
    function GetCellChars: boolean;
    function CellCharsOK: boolean;

    procedure SetIgnoreErrors(Value: boolean);

    { Problem with C++ Builder:
      .hpp file is not correctly created, needs to be modified by user.
      Workaround impossible as it causes an Internal Linker error
      (failed assertion) in C++ Builder

    Original line created by C++ Builder:

       System::AnsiString __fastcall ParseSelEntry(const System::AnsiString p0, TExcelCell &Excels_, TExcelCell
         &Excels_);


    Syntactically corrected line:

       System::AnsiString __fastcall ParseSelEntry(const System::AnsiString p0, TExcelCell &Excels1, TExcelCell
         &Excels2);
    }
    function ParseSelEntry( const Sel: string; var TopLeft, BottomRight: TExcelCell): string;
  protected
    procedure CheckConnection; virtual;

    function GetStrings(var List: TStringList; const Topic: string): TStringList;
    property FileExt: TFileExt read FFileExt write FFileExt;
    property Executable: TFilename read FExecutable write FExecutable;

    { new 2.6 }
    procedure PokePCharAt(Row: TExcelRow; Col: TExcelCol; const Data: PChar; NumRows, NumCols: integer);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Connect;
    procedure Disconnect;

    function Request(const Item: string): string;
    procedure Exec(const Cmd: string);

    procedure Poke(const Data: string);
    procedure PokeAt(Row: TExcelRow; Col: TExcelCol; const Data: string);
    procedure PokeAtSheet(const Sheet: string; Row: TExcelRow; Col: TExcelCol; const Data: string);

    function SwitchTopic(const NewTopic: string): boolean;
    function SwitchToSystemTopic: boolean;

    procedure LocateExcel; virtual;
    procedure LaunchExcel; virtual; { new 2.6.5 }

    procedure CloseExcel;

    procedure Flush;

    { new 2.6 }
    procedure BeginUpdate;
    procedure EndUpdate;

    class function WriteCacheAvailable: boolean;

    procedure WaitUntilReady;

    { Problem with C++ Builder:
      .hpp file is not correctly created, needs to be modified by user.
      Workaround impossible as it causes an Internal Linker error
      (failed assertion) in C++ Builder

      Original line created by C++ Builder:

        System::AnsiString __fastcall GetRectSelection(TExcelCell &Excels_, TExcelCell &Excels_);


      Syntactically corrected line:

        System::AnsiString __fastcall GetRectSelection(TExcelCell &Excels0, TExcelCell &Excels1);

    }
    function GetRectSelection( var TopLeft, BottomRight: TExcelCell): string;

    procedure RetrieveSelection;

    { returns string with leading and trailing single quotes (') removed
      --> Excel may wrap them }
    class function StripQuotation(const AString: string): string;
    { returns true if exactly one instance of Excel is running }
    class function OneExcelInstance: boolean; { 2.6.5 }

    property Connected: Boolean read FConnected write SetConnect;
    property BurstCount: integer read FBurstCount write FBurstCount default 128;
    property DDEConv: TDDEClientConv read GetDDEClientConv;
    property DDEItem: TDDEClientItem read FDDEClientItem;
    property EditEnvItems: TStringList read GetEditEnvItems;
    property Formats: TStringList read GetFormats;
    property Protocols: TStringList read GetProtocols;
    property Ready: Boolean read GetReady;
    property Selection: string read GetSelection;
    property Topics: TStringList read GetTopics;

    { Excel note: Excel occasionally seems to return sheet names wrapped in
      ''; to use them for DDE purposes you will need to remove the leading and
      the trailing ' }
    property CurrentSheet: string read GetCurrentSheet;
    property RowChar: char read FRowChar;
    property ColChar: char read FColChar;
    property SelectionList: TStringList read FSelectionList;
    property ExeName: TFilename read FExeName write SetExeName;

    property DDELaunch: boolean read FDDELaunch write FDDELaunch default true;

    property IgnoreErrors: boolean read FIgnoreErrors write SetIgnoreErrors;

    { events }
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnOpen: TNotifyEvent read FOnOpen write FOnOpen;
    property OnBeginWait: TNotifyEvent read FBeginWait write FBeginWait;
    property OnEndWait: TNotifyEvent read FEndWait write FEndWait;
    property OnWaiting: TNotifyEvent read FWaiting write FWaiting;
  end;








  TExcel = class(TCustomExcel)
  private
    FMoveActiveCell : TCellDir;
    FDecimals: Word;
    FDecimalSeparator: Char;
    FFilterReturnedData: boolean;
    FStripCRLF: boolean;

    procedure SetFilter(DoFilter: boolean);
  public
    constructor Create(AOwner: TComponent); override;
    procedure AutoMoveActiveCell;

    procedure Select(Row: TExcelRow; Col: TExcelCol);
    procedure SelectRange( FromRow: TExcelRow; FromCol: TExcelCol;
                           ARowCount: TExcelRow; AColCount: TExcelCol);
    procedure SelectSheet(const ASheet: string);

    procedure Move(deltaRow, deltaCol: Integer);

    { new 2.6 }
    procedure CachedInsert(ARow: TExcelRow; ACol: TExcelCol; const s: string);

    procedure Insert(const s: string);
    procedure InsertAt(Row: TExcelRow; Col: TExcelCol; const s: string);

    procedure PutExt(e: Extended);
    procedure PutExtAt(Row: TExcelRow; Col: TExcelCol; e: Extended);
    procedure PutStr(const s: string);
    procedure PutStrAt(Row: TExcelRow; Col: TExcelCol; const s: string);

    function GetData: string;
    function GetDataAt(Row: TExcelRow; Col: TExcelCol): string;
    function GetDataAtFileSheet(Row: TExcelRow; Col: TExcelCol; const FileSheet: string): string;

  published
    property MoveActiveCell: TCellDir read FMoveActiveCell write FMoveActiveCell default dirDown;
    property ExeName;
    property DDELaunch;
    property Decimals: Word read FDecimals write FDecimals default 0;
    property DecimalSeparator: Char read FDecimalSeparator write FDecimalSeparator default '.';
    property FilterReturnedData: boolean read FFilterReturnedData write SetFilter;
    property StripCRLF: boolean read FStripCRLF write FStripCRLF;

    { all of the following properties documented above }
    property BurstCount;
    property OnClose;
    property OnOpen;

    property OnBeginWait;
    property OnEndWait;
    property OnWaiting;
  end;








  TAdvExcel = class(TExcel)
  private
    FMacro : TFileName;
  public
    procedure OpenMacroFile(const MacroFilename: TFileName);
    procedure CloseMacroFile;
    procedure RunMacro(const MacroName: string);

    procedure StartTable;
    procedure EndTable;

    procedure NewSheet(SheetType: TNewSheet; const TemplateName: string);

    procedure NewWorkbook(SheetType: TNewSheet; const TemplateName: string);

(*
    This is old source code that has been left in for demonstration.
    Feel free to explore, exploit and cannibalize it, but note that there will
    be no support at all for it.

    procedure OpenWorkbook( const Filename: string; UpdateLinks: TExcelUpdateLinks); virtual;
    procedure OpenWorkbookEx( const Filename: string; UpdateLinks: TExcelUpdateLinks;
                              ReadOnly: boolean;
                              DelimitFormat: TExcelFileDelimiter;
                              const Password: string;
                              const EditPassword: string;
                              IgnoreReadOnlyRecommendation: boolean;
                              FileOrigin: TExcelFileOrigin;
                              CustomDelimiter: char;
                              AddToCurrentWorkbook: boolean;
                              Editable: boolean;
                              FileAccess: TExcelFileAccess;
                              NotifyUser: boolean;
                              Converter: integer);
*)

    procedure EchoOn;
    procedure EchoOff;

    procedure DisableInput;
    procedure EnableInput;

    procedure HideCurrentWindow;
    procedure UnhideWindow(const AWindowName: string);

    procedure PutInt(i: Longint);
    procedure PutIntAt(Row: TExcelRow; Col: TExcelCol; i: Longint);

    procedure PutDate(d: TDateTime);
    procedure PutDateAt(Row: TExcelRow; Col: TExcelCol; d: TDateTime);

    procedure PutTime(d: TDateTime);
    procedure PutTimeAt(Row: TExcelRow; Col: TExcelCol; d: TDateTime);

    procedure PutDateTime(d: TDateTime);
    procedure PutDateTimeAt(Row: TExcelRow; Col: TExcelCol; d: TDateTime);

    procedure PutData(const AnArray: array of const);
    procedure PutDataAt( Row: TExcelRow; Col: TExcelCol; const AnArray: array of const;
                         FillDirection: TCellDir);

    procedure SelectWorkBook(const WorkBook, SheetName: string);

    procedure RenameSheet(const OldName, NewName: string);
  end;


{$DEFINE LocalRegister}
{.$UNDEF LocalRegister}

{$IFDEF LocalRegister}
  procedure Register;
{$ENDIF LocalRegister}



implementation


uses
{$IFNDEF Win32} {$IFDEF UseGenericThunks}
  Call32NT, { for thunking 16bit -> 32bit }
{$ENDIF Win32} {$ENDIF UseGenericThunks}
  ShellApi,
  DDEML;



{ The following descendant of TDdeClientConv is only for fixing
  a severe bug in the Borland C++ Builder 3.0 of RequestData }

{$IFDEF VER110} // only for BCB 3.0
  function TBCBFixedDdeClientConv.RequestData(const Item: string): PChar;
  var
    hData: HDDEData;
    ddeRslt: LongInt;
    hItem: HSZ;
    pData: Pointer;
    Len: Integer;
  begin
    Result := nil;

    if (Conv = 0) or WaitStat then
      Exit;

    hItem := DdeCreateStringHandle(ddeMgr.DdeInstId, PChar(Item), CP_WINANSI);
    if hItem <> 0 then
    begin
      hData := DdeClientTransaction( nil, 0, Conv, hItem, DdeFmt, XTYP_REQUEST, 10000, @ddeRslt);
      DdeFreeStringHandle(ddeMgr.DdeInstId, hItem);
      if hData <> 0 then
      try
        pData := DdeAccessData(hData, @Len);
        if pData <> nil then
        try
          Result := StrAlloc(Len + 1);
          Move(pData^, Result^, len);  { <-- originally BCB 3 had a bug here }
          Result[len] := #0;
        finally
          DdeUnaccessData(hData);
        end;
      finally
        DdeFreeDataHandle(hData);
      end;
    end;

  end;
{$ENDIF VER110}


const
  MaxSingleElementSize = 255;
  { maximum overhead for an element }
  CacheElementOverhead = 3; { SizeOf(#13) + SizeOf(#10) + SizeOf(#9) }
  AllowedMaximumCacheSize = 65520 - MaxSingleElementSize - 2;


{ Although StrScan is in assembler this is faster, by about 40% }
{ local override of SysUtils function! }
function StrScan(ToScan: PChar; Sign: Char): PChar;
begin
  Result := nil;

  if ToScan <> nil then
    while (ToScan^ <> #0) do
    begin
      if ToScan^ = Sign then
      begin
        Result := ToScan;
        break;
      end;
      inc(ToScan);
    end;
end;


{$IFDEF LocalRegister}
  procedure Register;
  begin
    RegisterComponents('Samples', [TAdvExcel, TExcel]);
  end;

  {$IFDEF Win32}
     {$R EXCELS.D32}
  {$ELSE}
     {$R EXCELS.D16}
  {$ENDIF Win32}

{$ENDIF LocalRegister}



{$IFNDEF Win32}
  function Str2PChar(var s: string): PChar;
  { Convert a string to a pchar by adding a NULL
    character to the string passed and returning
    the address of the first element s[1] of the
    string.
    This is only needed in 16bit, as in 32bit
    Delphi a string can be safely type-casted
    into a PChar. }
  var
    i : integer;
  begin
    Str2PChar := @s[1];

    i := length(s);
    if s[i] <> #0 then
      if (i < 255) then
        AppendStr(s, #0)
      else
        raise ExcelError.Create(msgStrError);
  end;
{$ENDIF Win32}


function RScan(const S: string; Chr: char): integer;
begin
  Result := Length(s);
  while Result > 0 do
  begin
    if S[Result] = Chr then
      break;

    dec(Result);
  end;
end;

function FindExcelColon(x: integer; const s: string): integer;
var
  counter: integer;
begin
  counter := x;
  while counter <= length(s) do
  begin
    if s[counter] = #39 then
    begin
      inc(counter);
      while (counter < length(s)) and (s[counter] <> #39) do
        inc(counter);
      inc(counter);
    end
    else
    begin
      if s[counter] = ';' then
        break
      else
        inc(counter);
    end;
  end;

  if (s[counter] = ';') and (counter < length(s)) then
    Result := counter
  else
    Result := 0;
end;

{ TCustomExcel }
constructor TCustomExcel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FFileExt := '.xls';
  FExecutable := 'EXCEL.EXE';

  if not (csDesigning in ComponentState) then
  begin
    FDDEClientConv := TBCBFixedDdeClientConv.Create(nil); { TDdeClientConv.Create(nil); }
    with FDDEClientConv do
    begin
      ConnectMode := ddeManual;
      OnOpen  := Self.OpenLink;
      OnClose := Self.ShutDown;
    end;

    FDDEClientItem := TDDEClientItem.Create(nil);
    with FDDEClientItem do
    begin
      DDEConv := FDDEClientConv;
    end;

  end;

  FSelectionList := TStringList.Create;
  FSelectionList.Sorted := false;
  FSelectionList.Duplicates := dupAccept;

  FBurstCount := 128;

  SetExeName('Excel');

  FDDELaunch := true; { 2.6.5 - do not break existing code } 
end;

destructor TCustomExcel.Destroy;
var
  counter : integer;
begin
  FFormatsList.Free;
  FTopicsList.Free;
  FProtocolsList.Free;
  FEditEnvItemsList.Free;

  if not (csDesigning in ComponentState) then
  begin
    FDDEClientItem.DDEConv := nil;
    FDDEClientItem.Free;
    FDDEClientItem := nil;

    FDDEClientConv.Free;
    FDDEClientConv := nil;
  end;

  with FSelectionList do
    for counter := 0 to Count-1 do
    begin
      if Objects[counter] <> nil then
        dispose(PExcelSelectionArray(Objects[counter]));
    end;
  FSelectionList.Free;
  FSelectionList := nil;

  inherited Destroy;
end;

procedure TCustomExcel.SetExeName(const Value: TFileName);
begin
  Disconnect;

  FExeName := ChangeFileExt(Value, '');
  if not (csDesigning in ComponentState) then
    FDDEClientConv.ServiceApplication := FExeName;
end;

procedure TCustomExcel.SetConnect(Value: Boolean);
begin
  if FConnected = Value then Exit;
  if Value then
    Connect
  else
    Disconnect;
end;

function TCustomExcel.GetReady: Boolean;
begin
  Application.ProcessMessages;
  SwitchToSystemTopic;
  Result := 'Ready' = Request('Status');
end;

function TCustomExcel.GetFormats: TStringList;
begin
  Result := GetStrings(FFormatsList, 'Formats');
end;

function TCustomExcel.GetTopics: TStringList;
begin
  Result := GetStrings(FTopicsList, 'Topics');
end;

function TCustomExcel.GetProtocols: TStringList;
begin
  Result := GetStrings(FProtocolsList, 'Protocols');
end;

function TCustomExcel.GetEditEnvItems: TStringList;
begin
  Result := GetStrings(FEditEnvItemsList, 'EditEnvItems');
end;

function TCustomExcel.GetSelection: string;
begin
  Application.ProcessMessages;
  SwitchToSystemTopic;
  Result := Request('Selection');
end;

function TCustomExcel.GetCurrentSheet: string;
var
  ExclPos: integer;
begin
  Result := GetSelection;
  if Result = msgExcelNoReply then
    Result := ''
  else
  begin
    ExclPos := RScan(Result, '!');
    if ExclPos > 0 then
      Delete(Result, ExclPos, length(Result));
  end;
end;

procedure TCustomExcel.OpenLink(Sender: TObject);
begin
  FConnected := True;
  FExcelTimeout := true;

  if Assigned(FOnOpen) then FOnOpen(Self);
end;

procedure TCustomExcel.ShutDown(Sender: TObject);
begin
  FConnected := False;
  if Assigned(FOnClose) then FOnClose(Self);
end;

{ procedure relies on List <> nil }
procedure TABStringToStringList(TABString: PChar; List: TStringList);
var
  StartPos,
  TabPos : PChar;
begin
  if TABString = nil then Exit;
  StartPos := TABString;
  TabPos := StrScan(StartPos, #9);
  while TabPos <> nil do
  begin
    TabPos[0] := #0; { replace #9 with #0 }
    List.Add(StrPas(StartPos)); { add format to list }
    StartPos := TabPos+1; { position to after TAB}
    TabPos := StrScan(StartPos, #9);
  end;
  if StrLen(StartPos) > 0 then
    List.Add(StrPas(StartPos));
end;

function TCustomExcel.GetStrings(var List: TStringList;
                               const Topic: string): TStringList;
var
  Reply : PChar;
begin
  Application.ProcessMessages;

  if not Assigned(List) then
    List := TStringList.Create
  else
    List.Clear;

  SwitchToSystemTopic;
  Reply := FDDEClientConv.RequestData(Topic);
  try
    { retrieve TAB-delimited list of formats }
    TABStringToStringList(Reply, List);
  finally
    StrDispose(Reply);
  end;

  Result := List;
end;

class function TCustomExcel.StripQuotation(const AString: string): string;
begin
  if (Length(AString) > 0) and
     (AString[Length(AString)] = #39) and (AString[1] = #39 ) then { test for ' }

    Result := Copy(AString, 2, Length(AString)-2)
  else
    Result := AString;
end;
                   

procedure TCustomExcel.Connect;
begin
  if not FConnected then
  begin
    { initially use the system topic }
    FDDEClientConv.SetLink('Excel', 'System');

    if FDDEClientConv.OpenLink then
    begin
      try
        GetCellChars; { try to find out the cell chars NOW }
      except
        on E: Exception do { ignore };
      end;

      Exit;
    end;

    LocateExcel;

    if not DDELaunch then
      LaunchExcel; { do launch "manually" - since a DDE launch seems to cause problems with DDE }

    if not FDDEClientConv.OpenLink then
      if not FDDEClientConv.OpenLink then
        raise ExcelError.Create(msgCouldNotLaunch);

    try
      GetCellChars; { try to find out the cell chars NOW }
    except
      on E: Exception do { ignore };
    end;

  end;
end;

procedure TCustomExcel.Disconnect;
begin
  if FConnected then
    FDDEClientConv.CloseLink;
end;


function TCustomExcel.Request(const Item: string): string;
var
  Reply : PChar;
begin
  Reply := FDDEClientConv.RequestData(Item);
  if Reply = nil then
    Result := msgExcelNoReply
  else
    Result := StrPas(Reply);
  StrDispose(Reply);
end;

procedure TCustomExcel.Exec(const Cmd: string);
{$IFDEF Windows}
var
  Buffer : PChar;
{$ENDIF Windows}
begin
  SwitchToSystemTopic;

  inc(FExecCount);
  if (FExecCount = FBurstCount) and (FBurstCount >= 0) then
  begin
    Flush;

    FExecCount := 0;
  end;

{$IFDEF Windows}
  Buffer := StrAlloc(Length(Cmd)+SizeOf(Char));
  try
{$ENDIF Windows}
  {$IFDEF Windows}
    if not FDDEClientConv.ExecuteMacro(StrPCopy(Buffer, Cmd), False) then
  {$ELSE}
    if not FDDEClientConv.ExecuteMacro(PChar(Cmd), False) then
  {$ENDIF Windows}
    begin
      Flush;

    {$IFDEF Windows}
      if not FDDEClientConv.ExecuteMacro(Buffer, True) then
    {$ELSE}
      if not FDDEClientConv.ExecuteMacro(PChar(Cmd), True) then
    {$ENDIF Windows}
        raise ExcelError.CreateFmt(msgCmdAcceptErr, [Cmd]);
    end;
{$IFDEF Windows}
  finally
    StrDispose(Buffer);
  end;
{$ENDIF Windows}
end;

procedure TCustomExcel.Poke(const Data: string);
var
  TopLeft, dummy: TExcelCell;
begin
  SwitchTopic(StripQuotation(GetRectSelection(TopLeft, dummy)));

  with TopLeft do
    PokeAtSheet(CurrentSheet, Row, Col, Data);
end;

procedure TCustomExcel.PokeAtSheet(const Sheet: string; Row: TExcelRow; Col: TExcelCol; const Data: string);
{$IFDEF Windows}
var
  Buffer : PChar;
{$ENDIF Windows}
begin
  SwitchTopic(StripQuotation(Sheet));

  while FDDEClientConv.WaitStat do
    Application.ProcessMessages;

  CheckCellCharsOK;

{$IFDEF Win32}
  PokePCharAt(Row, Col, PChar(Data), 1, 1);
{$ELSE}
  Buffer := StrAlloc(Length(Data)+SizeOf(Char));
  try
    PokePCharAt(Row, Col, StrPCopy(Buffer, Data), 1, 1)
  finally
    StrDispose(Buffer);
  end;
{$ENDIF Win32}
end;

procedure TCustomExcel.PokeAt(Row: TExcelRow; Col: TExcelCol; const Data: string);
{$IFDEF Windows}
var
  Buffer : PChar;
{$ENDIF Windows}
begin
  SwitchTopic(StripQuotation(CurrentSheet));

  while FDDEClientConv.WaitStat do
    Application.ProcessMessages;

  CheckCellCharsOK;

{$IFDEF Win32}
  PokePCharAt(Row, Col, PChar(Data), 1, 1);
{$ELSE}
  Buffer := StrAlloc(Length(Data)+SizeOf(Char));
  try
    PokePCharAt(Row, Col, StrPCopy(Buffer, Data), 1, 1);
  finally
    StrDispose(Buffer);
  end;
{$ENDIF Win32}
end;

procedure TCustomExcel.PokePCharAt(Row: TExcelRow; Col: TExcelCol; const Data: PChar; NumRows, NumCols: integer);
var
  Item: string;
begin
  CheckCellCharsOK;

{
  Item := Format('%s%d%s%d:%s%d%s%d', [RowMark, Top, ColMark, Left,
                                    RowMark, Bottom, ColMark, Right]);
}
  Item := Format('%s%d%s%d:%s%d%s%d', [ FRowChar, Row, FColChar, Col,
                                        FRowChar, Row + NumRows - 1, FColChar, Col + NumCols - 1]);
  { assume that the item does change - DDEItem change causes a lot of activity }
  FDDEClientItem.DDEItem := Item;

  if not FDDEClientConv.PokeData(Item, Data) then
  begin
    while FDDEClientConv.WaitStat do { try to wait }
      Application.ProcessMessages;

    { try again }
    if not FDDEClientConv.PokeData(Item, Data) then
    begin
      raise ExcelError.CreateFmt(msgCmdAcceptErr, ['']);
    end;
  end;
end;


{$IFNDEF Win32} {$IFDEF UseGenericThunks}
{ begin generic thunking support for long filenames }
var
  id_W32GetShortPathName: longint;

  W32GetShortPathName: function(PLongPath, PShortPath: PChar; BufferSize, ID: longint): longint;

procedure InitWin32; far;
begin
  @W32GetShortPathName := @Call32;
  id_W32GetShortPathName := Declare32('GetShortPathName', 'kernel32', 'ppi');
end;


function GetShortPathName(PLongPath, PShortPath: PChar; BufferSize: longint): longint;
begin
  GetShortPathName := Strlen(PLongPath);

  if id_W32GetShortPathName >= 0 then { thunk successful? }
  begin
    GetShortPathName := W32GetShortPathName(PLongPath, PShortPath, BufferSize, id_W32GetShortPathName);
  end
  else
    StrLCopy(PShortPath, PLongPath, BufferSize);
end;


{ get short name of a filename - not available on NT 3.1 }
function GetShortFileName(PLongName: PChar): string;
begin
  Result := StrPas(PLongName);

  if Call32NTError = true then
    exit;

  Result[0] := chr( GetShortPathName(PLongName, @Result[1], SizeOf(Result)-1 ) );
end;

{$ENDIF UseGenericThunks} {$ENDIF Win32}

procedure TCustomExcel.LocateExcel;
const
  (* BufferSize = {$IFDEF Win32} 540 {$ELSE} 80 {$ENDIF Win32}; *)
  BufferSize = 540; { we are now able to deal with long filenames }
var
  Buffer : PChar;
  StringPosition : PChar;
  ReturnedData: Longint;
{$IFDEF Windows}
  ConvertedStr: PChar;
{$ENDIF Windows}
begin
  Buffer := StrAlloc(BufferSize);
  try
    { get the first entry, don't bother about the version !}
    ReturnedData := BufferSize;
    StrPCopy(Buffer, FFileExt);

    { no need to thunk here }
    RegQueryValue(hKey_Classes_Root, Buffer, Buffer, ReturnedData);
    if StrLen(Buffer) > 0 then
    begin
      StrCat(Buffer, '\shell\Open\command');
      ReturnedData := BufferSize;
      if RegQueryValue(hKey_Classes_Root, Buffer, Buffer, ReturnedData) = ERROR_SUCCESS then
      begin
        { now we have the executable associated with the .XLS file extension }

        StringPosition := StrUpper(Buffer);
        { find _last_ occurence of the executable name }

        {$IFDEF Windows}
          { please note that Str2PChar is a function }
          ConvertedStr := Str2PChar(FExecutable);
          while StrPos(StringPosition+1, ConvertedStr) <> nil do
            StringPosition := StrPos(StringPosition+1, ConvertedStr);
        {$ELSE}
          while StrPos(StringPosition+1, PChar(FExecutable)) <> nil do
            StringPosition := StrPos(StringPosition+1, PChar(FExecutable));
        {$ENDIF Windows}

        { cut off string; at the same time that removes the trailing ", if it exists }
        { StrCopy(StringPosition + Length(FExecutable), ''); -- fix and change 2.7 below }
        StringPosition[Length(FExecutable)-1] := #0;

        { bugfix 2.4 ? - may solve some problems detecting an Excel 8 installation }
        StringPosition := StrScan(Buffer, '"');
        {
        if StringPosition <> nil then
          ExeName := StrPas(Buffer + (StringPosition-Buffer) + 1)
        else
          ExeName := StrPas(Buffer);
        }
        if StringPosition <> nil then
        begin
          ReturnedData :=  StrLen(Buffer) - (StringPosition-Buffer) - 1;

          StrMove(Buffer, Buffer + (StringPosition-Buffer) + 1, ReturnedData);
          Buffer[ReturnedData] := #0;
        end;

        ExeName := StrPas(Buffer); { side-effect: .EXE is stripped (!) }

        { formerly we used this code to parse the returned string
          problems with some Excel 8.0 installation induced a change to
          the code above. Revert to this if the above code does not
          work out as expected.

        if Buffer[0] = '"' then
          ExeName := StrPas(Buffer+1)
        else
          ExeName := StrPas(Buffer);
        }

        { if it is in registry, it's quite likely that the file exists, too

          Note: writing to ExeName has the side-effect that ".EXE" is cut off;
                this is done in compliance with the Win API docs
                Because of this we need to append it here again to see whether
                the file actually exists! }
        if not FileExists(ExeName+'.EXE') then
        begin
          { OK, we have solved the problem for every combination except Delphi 1
            running on a 32bit Windows, where Office is installed in a path with
            long filenames

            We now need to test with the original buffer whether the LONG version
            exists; strategy: convert Buffer into short then again test this
          }

          {$IFNDEF Win32} {$IFDEF UseGenericThunks}
            ExeName := GetShortFileName(Buffer);
            if not FileExists( ExeName + '.EXE' ) then
          {$ENDIF UseGenericThunks} {$ENDIF Win32}
            ExeName := '';
        end;
      end;
    end;
  finally
    StrDispose(Buffer);
  end;
end;

procedure TCustomExcel.LaunchExcel;
var
  ExcelFile: TFilename;
begin
  ExcelFile := ExeName + '.EXE';

  if not FileExists(ExcelFile) then
    raise ExcelError.Create(msgCouldNotLaunch);

  if WinExec({$IFDEF Win32}PChar{$ELSE}Str2PChar{$ENDIF Win32}(ExcelFile), sw_Show) <= 31 then
  begin
  {$IFDEF Windows}
    ExcelFile := GetShortFileName(PChar(@ExcelFile[1])); { from the call to Str2PChar we know that it's #0 terminated }
    if WinExec(Str2PChar(ExcelFile), sw_Show) <= 31 then
  {$ENDIF Windows}
      raise ExcelError.Create(msgCouldNotLaunch);
  end;
end;

procedure TCustomExcel.CloseExcel;
begin
  if FConnected then
  begin
    Exec('[QUIT]'); { fix 2.6.5 + 3.0 }
    Disconnect;
  end;

  { Exec('[QUIT]'); }
end;

procedure TCustomExcel.Flush;
begin
  if Assigned(FBeginWait) then
    FBeginWait(Self);

  if Assigned(FWaiting) then
  begin
    while FDDEClientConv.WaitStat or (not Ready) do
    begin
      Application.ProcessMessages;   { Waiting for Excel }

      FWaiting(Self);
    end;
  end
  else
  begin
    while FDDEClientConv.WaitStat or (not Ready) do
      Application.ProcessMessages;   { Waiting for Excel }
  end;

  if Assigned(FEndWait) then
    FEndWait(Self);
end;

procedure TCustomExcel.WaitUntilReady;
begin
  Flush;
end;

function TCustomExcel.GetDDEClientConv: TDdeClientConv;
begin
  Result := FDDEClientConv;
end;


procedure TCustomExcel.BeginUpdate;
begin
end;


class function TCustomExcel.WriteCacheAvailable: boolean;
begin
  Result := false;
end;


procedure TCustomExcel.EndUpdate;
begin
end;


{ TExcel }

constructor TExcel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMoveActiveCell := dirDown;
  FDecimalSeparator := SysUtils.DecimalSeparator; { '.';  }
end;

procedure TExcel.SetFilter(DoFilter: boolean);
begin
  FFilterReturnedData := DoFilter;

  if not (csDesigning in ComponentState) then
    FDDEClientConv.FormatChars := DoFilter;
end;

procedure TExcel.AutoMoveActiveCell;
begin
  case FMoveActiveCell of
    dirNone:  { do nothing };
    dirUp:    begin
                Exec('[SELECT("R[-1]C")]');
              end;

    dirDown:  begin
                Exec('[SELECT("R[1]C")]');
              end;

    dirLeft:  begin
                Exec('[SELECT("RC[-1]")]');
              end;

    dirRight: begin
                Exec('[SELECT("RC[1]")]');
              end;
  end;
end;

procedure TExcel.Select(Row: TExcelRow; Col: TExcelCol);
begin
  if (Row <> 0) and (Col <> 0) then
  begin
    Exec(Format('[SELECT("R%dC%d")]', [Row, Col]));
  end;
end;

procedure TExcel.SelectRange( FromRow: TExcelRow; FromCol: TExcelCol;
                              ARowCount: TExcelRow; AColCount: TExcelCol);
begin
  if (FromRow <> 0) and (FromCol <> 0) and
     (ARowCount > 0) and (AColCount > 0) then
  begin
    Exec(Format('[SELECT("R%dC%d:R%dC%d")]', [FromRow, FromCol, FromRow + ARowCount - 1, FromCol + AColCount - 1]));
  end;
end;

procedure TExcel.SelectSheet(const ASheet: string);
begin
  { SwitchTopic(StripQuotation(ASheet)); }
  Exec(Format('[WORKBOOK.SELECT("%s")]', [StripQuotation(ASheet)])); { fix 3.0 }
end;

procedure TExcel.Move(deltaRow, deltaCol: Integer);
begin
  Exec(Format('[SELECT("R[%d]C[%d]")]', [deltaRow, deltaCol]));
end;

procedure TExcel.CachedInsert(ARow: TExcelRow; ACol: TExcelCol; const s: string);
begin
  if (ARow <= 0) or (ACol <= 0) then { invalid cell selection data? }
  begin
    { we cannot cache these commands, so execute them immediately }
    Insert(s);
  end
  else
  begin
      Exec(Format('[FORMULA(%s, "R%dC%d")]', [s, ARow, ACol]));
  end;
end;

procedure TExcel.Insert(const s: string);
begin
  Exec(Format('[FORMULA(%s)]', [s]));
  AutoMoveActiveCell;
end;

procedure TExcel.InsertAt(Row: TExcelRow; Col: TExcelCol; const s: string);
begin
  if (Row <= 0) or (Col<=0) then { invalid data? }
    Insert(s)
  else
  begin
    Exec(Format('[FORMULA(%s, "R%dC%d")]', [s, Row, Col]));
  end;
end;

procedure TExcel.PutExt(e: Extended);
var
  SepPos: Integer;
  ExtString: string[30];
begin
  Str(e:0:FDecimals, ExtString);
  { this will always return an "American" style number }
  if (FDecimalSeparator <> '.')
     then { test for country settings }
  begin
    SepPos := Pos('.', ExtString);
    if SepPos > 0 then
      ExtString[SepPos] := FDecimalSeparator;
  end;

  Insert(ExtString);
end;

procedure TExcel.PutExtAt(Row: TExcelRow; Col: TExcelCol; e: Extended);
var
  SepPos: Integer;
  ExtString: string[30];
begin
  Str(e:0:FDecimals, ExtString);
  { this will always return an "American" style number }
  if (FDecimalSeparator <> '.')
     then { test for country settings }
  begin
    SepPos := Pos('.', ExtString);
    if SepPos > 0 then
      ExtString[SepPos] := FDecimalSeparator;
  end;

  CachedInsert(Row, Col, ExtString);
end;

procedure TExcel.PutStr(const s: string);
begin
  Insert(Format('"%s"', [s]));
end;

procedure TExcel.PutStrAt(Row: TExcelRow; Col: TExcelCol; const s: string);
begin
  CachedInsert(Row, Col, Format('"%s"', [s]));
end;


procedure TCustomExcel.CheckConnection;
begin
  if not FConnected then
    raise ExcelError.Create(msgNotConnected);
end;

procedure TCustomExcel.CheckCellCharsOK;
begin
  if not CellCharsOK then
    if not GetCellChars then
      raise ExcelError.Create(msgNoRowCol);
end;

function TCustomExcel.GetCellChars: boolean;
var
  SelString: string;
  CharPos: integer;

  OldIgnore: boolean;
begin
  Result := false;

  OldIgnore := IgnoreErrors;
  try
    IgnoreErrors := true;

    SelString := GetSelection; { get the whole lot }

    if SelString = msgExcelNoReply then { only parse if Excel replied }
      raise ExcelError.Create(msgExcelNoReply);

    CharPos := RScan(SelString, '!'); { find the separator }
    if CharPos > 0 then
    begin
      { remove from the existing string }
      Delete(SelString, 1, CharPos);

      FRowChar := SelString[1]; { The first char is always the row char }

      CharPos := 2;                { Find occurence of col char }
      while (CharPos < length(SelString)) and
            (SelString[CharPos] in ['0'..'9']) do Inc(CharPos);

      FColChar := SelString[CharPos];

      Result := CellCharsOK;
    end;

  finally
    IgnoreErrors := OldIgnore;
  end;
end;

function TCustomExcel.CellCharsOK: boolean;
begin
  Result := (FRowChar <> #0) and (FColChar <> #0);
end;

procedure TCustomExcel.SetIgnoreErrors(Value: boolean);
begin
  CheckConnection;

  FIgnoreErrors := Value;
  Exec(Format('[ERROR(%d)]', [ord(not FIgnoreErrors)]));
end;

function TCustomExcel.ParseSelEntry( const Sel: string;
                                     var TopLeft, BottomRight: TExcelCell): string;

  { parse cell part into number and remove it }
  function GetNumber(var AString: string): integer;
  var
    CharPos : integer;
  begin
    CharPos := 2; { this is specialized code that knows that the first char is non-numeric }
    while (CharPos <= length(AString)) and (AString[CharPos] in ['0'..'9']) do
      inc(CharPos);

    dec(CharPos);

    { convert to number }
    Result := StrToInt(Copy(AString, 2, CharPos-1));

    { remove parsed part from string }
    Delete(AString, 1, CharPos);
  end;

var
  SeparatorPos: integer;
  CellAddress: string;

  BottomInitialized: boolean;
begin
  BottomInitialized := false;
  { TopLeft.Col := 0;  BottomRight.Col := 0; }
  { TopLeft.Row := 0;  BottomRight.Row := 0; }

  Result := Sel;
  SeparatorPos := RScan(Result, '!'); { find the separator }

  if SeparatorPos = 0 then
  begin
    Result := ''; { should not happen! - but don't raise an exception }
    exit;
  end;

  { copy the cell part into CellAddress}
  CellAddress := Copy(Result, succ(SeparatorPos), Length(Result));

  { and remove it from the existing string - return value }
  Delete(Result, SeparatorPos, Length(Result));
  Result := StripQuotation(Result);

  CheckCellCharsOK;
      
  { at this point we know the following:
      FRowChar and FColChar contain valid identifiers for an Excel row / column }


  { find the colon char (R1C10:R20C15) -> array selection; or the semicolon
     -> multiple selection (R1C10;R20C40) ==> ";" + ":'

      R1C10;R20C20   [multiple selection]

      R1C10:R20C20   [array]

      R1C10

      R1             [single row]
      C1             [single column]

  }

  { find multiple selections which we are not parsing !}
  { it is safe to use "Pos" here, as a potential semicolon in the name part will
    have been removed by now }
  SeparatorPos := Pos(';', CellAddress);
  if SeparatorPos > 0 then
    { remove the parts we are not going to parse }
    Delete(CellAddress, SeparatorPos, Length(CellAddress));


  { there must be always at least ONE valid char }
  if CellAddress[1] = FRowChar then
    TopLeft.Row := GetNumber(CellAddress)
  else
  if CellAddress[1] = FColChar then
    TopLeft.Col := GetNumber(CellAddress);

  if (length(CellAddress)>0) then { still something left ?}
    { assume that Excel does not return garbage }
    if CellAddress[1] = FRowChar then
      TopLeft.Row := GetNumber(CellAddress)
    else
    if CellAddress[1] = FColChar then
      TopLeft.Col := GetNumber(CellAddress)
    else
      raise ExcelError.Create(msgBadCellFmt);


  { at this point we have parsed the left part of an array selection, so
    that at most something like ":R1..." is left over }

  { test whether we do have an array indeed (otherwise we have a problem !) }
  if (length(CellAddress)>0) then
    if (CellAddress[1] <> ':') then
      raise ExcelError.Create(msgBadCellFmt)
    else
    begin
      if length(CellAddress) < 2 then
        raise ExcelError.Create(msgBadCellFmt);

      Delete(CellAddress, 1, 1); { remove colon }

      { what follows is effectively the same code as above, only
        with "BottomRight" instead of TopLeft
        Consider moving that into a local procedure to
        improve maintainability }

      { there must be always at least ONE valid char }
      if CellAddress[1] = FRowChar then
        BottomRight.Row := GetNumber(CellAddress)
      else
      if CellAddress[1] = FColChar then
        BottomRight.Col := GetNumber(CellAddress);

      if (length(CellAddress) > 0) then { still something left ?}
        { assume that Excel does not return garbage }
        if CellAddress[1] = FRowChar then
          BottomRight.Row := GetNumber(CellAddress)
        else
        if CellAddress[1] = FColChar then
          BottomRight.Col := GetNumber(CellAddress)
        else
          raise ExcelError.Create(msgBadCellFmt);

      BottomInitialized := true;
    end;


  { we have transferred all the text into the TopLeft + BottomRight record;
    now handle the special cases }

  if not BottomInitialized then
    BottomRight := TopLeft;
end;


function TCustomExcel.SwitchTopic(const NewTopic: string): boolean;
begin
(*
  { STH! REMOVE THIS }
  if NewTopic = '' then
  begin
    raise Exception.Create('Possible Begin/EndUpdate problem - switching to empty topic');
  end;
*)
  Result := true;

  with FDDEClientConv do
  begin
    if DDETopic <> NewTopic then
    begin
      OnOpen  := nil; { we do not want to report this particular switch }
      OnClose := nil;

      if FConnected then
        CloseLink;

      SetLink('Excel', NewTopic);

      if FConnected then
        OpenLink;

      OnOpen  := Self.OpenLink;
      OnClose := Self.ShutDown;
    end;
  end;
end;

function TCustomExcel.SwitchToSystemTopic: boolean;
begin
  Result := SwitchTopic('System');
end;

function TCustomExcel.GetRectSelection( var TopLeft, BottomRight: TExcelCell): string;
var
  DelimitPos: integer;
  CurrentSel : string;
begin
  CurrentSel := Self.Selection;
  { Parse ONLY the first item of a selection }
  DelimitPos := FindExcelColon(1, CurrentSel);
  if DelimitPos > 0 then
    Delete(CurrentSel, DelimitPos, length(CurrentSel));

  Result := ParseSelEntry(CurrentSel, TopLeft, BottomRight);
end;

procedure TCustomExcel.RetrieveSelection;
var
  DelimitPos: integer;
  CurrentSel: string;

  counter : integer;

  PAnExcelSelArray: PExcelSelectionArray;
begin
  for counter := 0 to FSelectionList.Count-1 do
    with FSelectionList do
      if Objects[counter] <> nil then
        dispose(PExcelSelectionArray(Objects[counter]));
  FSelectionList.Clear;

  CurrentSel := Self.Selection;

  DelimitPos := 1;
  repeat
    DelimitPos := FindExcelColon(DelimitPos, CurrentSel);

    new(PAnExcelSelArray);
    try
      if DelimitPos > 0 then
        counter := FSelectionList.Add(
            ParseSelEntry( Copy(CurrentSel, 1, DelimitPos-1),
                           PAnExcelSelArray^.TopLeft, PAnExcelSelArray^.BottomRight )
                                      )
      else
        counter := FSelectionList.Add(
            ParseSelEntry( CurrentSel,
                           PAnExcelSelArray^.TopLeft, PAnExcelSelArray^.BottomRight
                          ) );
    except
      on E: Exception do
      begin
        dispose(PAnExcelSelArray);
        raise;
      end;
    end;

    FSelectionList.Objects[counter] := TObject(PAnExcelSelArray);

    if DelimitPos > 0 then
      Delete(CurrentSel, 1, DelimitPos);

  until DelimitPos = 0;
end;


{$IFNDEF Win32}
type
  LPARAM = Longint;
{$ENDIF Win32}

function EnumInstanceWindows(AHandle: THandle; PInstanceCount: LPARAM): boolean;
         {$IFDEF Win32} stdcall; {$ELSE} far; {$ENDIF Win32}
type
  PLongint = ^longint;
var
  ClassName: array[0..8] of char;
begin
  if GetClassName(AHandle, ClassName, SizeOf(ClassName)) = 0 then
  {$IFDEF Win32}
    RaiseLastWin32Error;
  {$ELSE}
    raise ExcelError.Create(msgWinAPI);
  {$ENDIF Win32}

  if StrComp(ClassName, 'XLMAIN') = 0 then
    inc(PLongint(PInstanceCount)^);

  Result := PLongint(PInstanceCount)^ < 2;
end;

class function TCustomExcel.OneExcelInstance: boolean;
var
  ExcelCounter: longint;
begin
  { we are relying on the fact that the class name of Excel's top level window
    is XLMAIN. If there is more than one window with that class name *created*,
    we return false }
  ExcelCounter := 0;
  EnumWindows(@EnumInstanceWindows, LPARAM(@ExcelCounter));
  Result := ExcelCounter = 1;
end;


function TExcel.GetData: string;
var
  TopCell,
  BottomCell: TExcelCell;
begin
  GetRectSelection(TopCell, BottomCell);

  Result := GetDataAt(TopCell.Row, TopCell.Col);
end;


function TExcel.GetDataAtFileSheet(Row: TExcelRow; Col: TExcelCol; const FileSheet: string): string;
var
  CRLFPos : integer;
begin
  SwitchTopic(StripQuotation(FileSheet));

  CheckCellCharsOK;

  Result := Request(Format('%s%d%s%d', [FRowChar, Row, FColChar, Col]));

  if FStripCRLF and (Length(Result) > 1) then
  begin
    CRLFPos := length(Result)-1;
    if (Result[CRLFPos] = #13) and (Result[succ(CRLFPos)] = #10) then
      Delete(Result, CRLFPos, 2);
  end;

end;

function TExcel.GetDataAt(Row: TExcelRow; Col: TExcelCol): string;
begin
  Result := GetDataAtFileSheet(Row, Col, CurrentSheet);
end;


{ TAdvExcel }

procedure TAdvExcel.OpenMacroFile(const MacroFilename: TFileName);
var
  MFile: TFilename;
begin
  MFile := UpperCase(ExtractFileName(MacroFilename));
  if FMacro <> MFile then
  begin
    if FMacro <> '' then
      CloseMacroFile;

    Exec(Format('[OPEN("%s")]', [MacroFilename]));
    Exec('[HIDE()]');
    FMacro := MFile;
  end;
end;

procedure TAdvExcel.CloseMacroFile;
begin
  if FMacro <> '' then
  begin
    Exec(Format('[UNHIDE("%s")]', [FMacro]));
    Exec('[CLOSE(FALSE)]');
    FMacro := '';
  end;
end;

procedure TAdvExcel.RunMacro(const MacroName: string);
begin
  if FMacro = '' then
    raise ExcelError.Create(msgNoMacroFile);

  Exec(Format('[RUN("%s!%s";FALSE)]', [FMacro, MacroName]));
end;

procedure TAdvExcel.StartTable;
begin
  Exec('[APP.MINIMIZE()]');
  Exec('[NEW(1)]');
  PutStrAt(1, 1, msgTableNotReady);
end;

procedure TAdvExcel.EndTable;
begin
  PutStrAt(1, 1, '');
  Exec('[APP.RESTORE()]');
end;

procedure TAdvExcel.NewSheet(SheetType: TNewSheet; const TemplateName: string);
begin
  if SheetType = Reserved then
    raise ExcelError.Create(msgReservedType);

  if SheetType = FromTemplate then
    Exec(Format('[WORKBOOK.INSERT("%s")]', [TemplateName]))
  else
    Exec(Format('[WORKBOOK.INSERT(%d)]', [ord(SheetType)-1]));
end;

procedure TAdvExcel.NewWorkbook(SheetType: TNewSheet; const TemplateName: string);
begin
  if SheetType = FromTemplate then
    Exec(Format('[NEW("%s")]', [TemplateName]))
  else
    Exec(Format('[NEW(%d)]', [ord(SheetType)-1]));
end;

(*
procedure TAdvExcel.OpenWorkbook( const Filename: string; UpdateLinks: TExcelUpdateLinks);
begin
  OpenWorkbookEx( Filename, UpdateLinks, false, excelDefaultDelimit,
                  '', '', true, excelDefaultOrigin, #0, false,
                  false, excelRevertToSaved, true, 0);
end;

procedure TAdvExcel.OpenWorkbookEx( const Filename: string; UpdateLinks: TExcelUpdateLinks;
                          ReadOnly: boolean;
                          DelimitFormat: TExcelFileDelimiter;
                          const Password: string;
                          const EditPassword: string;
                          IgnoreReadOnlyRecommendation: boolean;
                          FileOrigin: TExcelFileOrigin;
                          CustomDelimiter: char;
                          AddToCurrentWorkbook: boolean;
                          Editable: boolean;
                          FileAccess: TExcelFileAccess;
                          NotifyUser: boolean;
                          Converter: integer);
const
  BoolName : array[boolean] of PChar = ('true', 'false');
begin
  Exec(Format('[OPEN("%s",%d,)]', [
                              Filename,
                              ord(UpdateLinks),
                              ReadOnly,
                              ord(DelimitFormat),
                              Password,
                              IgnoreReadOnlyRecommendation,
                              ord(FileOrigin),
                              CustomDelimiter,
                              AddToCurrentWorkbook,
                              Editable,
                              ord(FileAccess),
                              NotifyUser,
                              Converter
                         ]) );
end;
*)

procedure TAdvExcel.EchoOn;
begin
  Exec('[ECHO(TRUE)]');
end;

procedure TAdvExcel.EchoOff;
begin
  Exec('[ECHO(FALSE)]');
end;

procedure TAdvExcel.DisableInput;
begin
  Exec('[DISABLE.INPUT(TRUE)]');
end;

procedure TAdvExcel.EnableInput;
begin
  Exec('[DISABLE.INPUT(FALSE)]');
end;

procedure TAdvExcel.HideCurrentWindow;
begin
  Exec('[HIDE()]');
end;

procedure TAdvExcel.UnhideWindow(const AWindowName: string);
begin
  Exec( Format('[UNHIDE(%s)]', [AWindowName]) );
end;

procedure TAdvExcel.PutInt(i: Longint);
begin
  Insert(IntToStr(i));
end;

procedure TAdvExcel.PutIntAt(Row: TExcelRow; Col: TExcelCol; i: Longint);
begin
  CachedInsert(Row, Col, IntToStr(i));
end;

procedure TAdvExcel.PutDate(d: TDateTime);
begin
  PutStr(DateToStr(d));
end;

procedure TAdvExcel.PutDateAt(Row: TExcelRow; Col: TExcelCol; d: TDateTime);
begin
  PutStrAt(Row, Col, DateToStr(d));
end;

procedure TAdvExcel.PutTime(d: TDateTime);
begin
  PutStr(TimeToStr(d));
end;

procedure TAdvExcel.PutTimeAt(Row: TExcelRow; Col: TExcelCol; d: TDateTime);
begin
  PutStrAt(Row, Col, TimeToStr(d));
end;

procedure TAdvExcel.PutDateTime(d: TDateTime);
begin
  PutStr(DateTimeToStr(d));
end;

procedure TAdvExcel.PutDateTimeAt(Row: TExcelRow; Col: TExcelCol; d: TDateTime);
begin
  PutStrAt(Row, Col, DateTimeToStr(d));
end;

procedure TAdvExcel.PutData(const AnArray: array of const);
var
  i: Integer;
begin
  if (Self.MoveActiveCell = dirNone) and (High(AnArray)>0) then
    raise ExcelError.Create(msgArrayMove);

  for i:= Low(AnArray) to High(AnArray) do
  with AnArray[i] do
    case VType of
      vtExtended: PutExt(VExtended^);
      vtInteger:  PutInt(VInteger);
      vtChar:     PutStr(VChar);
      vtString:   PutStr(VString^);
      vtPChar:    PutStr(StrPas(VPChar));
    {$IFDEF Win32}
      vtAnsiString: PutStr(StrPas(VPChar));
    {$ENDIF Win32}
    else
      raise ExcelError.Create(msgNotSupported);
    end; { case }
end;

procedure TAdvExcel.PutDataAt( Row: TExcelRow; Col: TExcelCol;
                               const AnArray: array of const;
                               FillDirection: TCellDir);
var
  AutoMove: TCellDir;
begin
  Select(Row, Col);

  AutoMove := Self.MoveActiveCell;
  Self.MoveActiveCell := FillDirection;
  try
    PutData(AnArray)
  finally
    Self.MoveActiveCell := AutoMove;
  end;
end;

procedure TAdvExcel.SelectWorkBook(const WorkBook, SheetName: string);
begin
  if Length(SheetName) > 0 then
    Exec(Format('[WORKBOOK.SELECT("[%s]%s")]',
              [StripQuotation(WorkBook), StripQuotation(SheetName)]))
  else
    Exec(Format('[WORKBOOK.SELECT("[%s]")]', [StripQuotation(WorkBook)]))
end;

{ Excel 8 bug: this DDE command will NOT work }
procedure TAdvExcel.RenameSheet(const OldName, NewName: string);
begin
  Exec( Format('[WORKBOOK.NAME("%s","%s")]',
              [StripQuotation(OldName), StripQuotation(NewName)] ));
end;

{$IFNDEF Win32} {$IFDEF UseGenericThunks}{ need some code for generic thunking }
initialization
     InitWin32;
{$ENDIF UseGenericThunks} {$ENDIF Win32}

end.
