unit graphsv3;

{ This file contains pascal declarations imported from a type library.
  This file will be written during each import or refresh of the type
  library editor.  Changes to this file will be discarded during the
  refresh process. }

{ Pinnacle-BPS Graph Control }
{ Version 1.0 }

{ Conversion log:
  Warning: 'Label' is a reserved word. _DGraph.Label changed to Label_
 }

interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, StdVCL;

const
  LIBID_GraphLib: TGUID = '{0842D103-1E19-101B-9AAF-1A1626551E7C}';

const

{ AutoInc constants. }

{ AutoIncConstants }

  gphOff = 0;
  gphOn = 1;

{ Background constants. }

{ BackgroundConstants }

  gphBlack = 0;
  gphBlue = 1;
  gphGreen = 2;
  gphCyan = 3;
  gphRed = 4;
  gphMagenta = 5;
  gphBrown = 6;
  gphLightGray = 7;
  gphDarkGray = 8;
  gphLightBlue = 9;
  gphLightGreen = 10;
  gphLightCyan = 11;
  gphLightRed = 12;
  gphLightMagenta = 13;
  gphYellow = 14;
  gphWhite = 15;

{ ColorData constants. }

{ ColorDataConstants }

//gphBlack = 0;
//gphBlue = 1;
//gphGreen = 2;
//gphCyan = 3;
//gphRed = 4;
//gphMagenta = 5;
//gphBrown = 6;
//gphLightGray = 7;
//gphDarkGray = 8;
//gphLightBlue = 9;
//gphLightGreen = 10;
//gphLightCyan = 11;
//gphLightRed = 12;
//gphLightMagenta = 13;
//gphYellow = 14;
//gphWhite = 15;

{ DataReset constants. }

{ DataResetConstants }

  gphNone = 0;
  gphGraphData = 1;
  gphColorData = 2;
  gphExtraData = 3;
  gphLabelText = 4;
  gphLegendText = 5;
  gphPatternData = 6;
  gphSymbolData = 7;
  gphXPosData = 8;
  gphAllData = 9;
  gphFontInfo = 10;

{ DrawMode constants. }

{ DrawModeConstants }

  gphNoAction = 0;
  gphClear = 1;
  gphDraw = 2;
  gphBlit = 3;
  gphCopy = 4;
  gphPrint = 5;
  gphWrite = 6;

{ DrawStyle constants. }

{ DrawStyleConstants }

  gphMonochrome = 0;
  gphColor = 1;

{ FontFamily constants. }

{ FontFamilyConstants }

  gphRoman = 0;
  gphSwiss = 1;
  gphModern = 2;

{ FontStyle constants. }

{ FontStyleConstants }

  gphDefault = 0;
  gphItalic = 1;
  gphBold = 2;
  gphBoldItalic = 3;
  gphUnderlined = 4;
  gphUnderlinedItalic = 5;
  gphUnderlinedBold = 6;
  gphUnderlinedBoldItalic = 7;

{ FontUse constants. }

{ FontUseConstants }

  gphGraphTitle = 0;
  gphOtherTitles = 1;
  gphLabels = 2;
  gphLegend = 3;
  gphAllText = 4;

{ Foreground constants. }

{ ForegroundConstants }

//gphBlack = 0;
//gphBlue = 1;
//gphGreen = 2;
//gphCyan = 3;
//gphRed = 4;
//gphMagenta = 5;
//gphBrown = 6;
//gphLightGray = 7;
//gphDarkGray = 8;
//gphLightBlue = 9;
//gphLightGreen = 10;
//gphLightCyan = 11;
//gphLightRed = 12;
//gphLightMagenta = 13;
//gphYellow = 14;
//gphWhite = 15;
  gphAutoBlackWhite = 16;

{ GraphType constants. }

{ GraphTypeConstants }

//gphNone = 0;
  gphPie2D = 1;
  gphPie3D = 2;
  gphBar2D = 3;
  gphBar3D = 4;
  gphGantt = 5;
  gphLine = 6;
  gphLogLin = 7;
  gphArea = 8;
  gphScatter = 9;
  gphPolar = 10;
  gphHLC = 11;

{ GridStyle constants. }

{ GridStyleConstants }

//gphNone = 0;
  gphHorizontal = 1;
  gphVertical = 2;
  gphBoth = 3;

{ IndexStyle constants. }

{ IndexStyleConstants }

  gphStandard = 0;
  gphEnhanced = 1;

{ Labels constants. }

{ LabelsConstants }

//gphOff = 0;
//gphOn = 1;
  gphXAxisLabelsOnly = 2;
  gphYAxisLabelsOnly = 3;

{ LegendStyle constants. }

{ LegendStyleConstants }

//gphMonochrome = 0;
//gphColor = 1;

{ LineStats constants. }

{ LineStatsConstants }

//gphNone = 0;
  gphMean = 1;
  gphMinmax = 2;
  gphMeanMinmax = 3;
  gphStddev = 4;
  gphStddevMean = 5;
  gphStddevMinmax = 6;
  gphStddevMinmaxMean = 7;
  gphBestfit = 8;
  gphBestfitMean = 9;
  gphBestfitMinmax = 10;
  gphBestfitMinmaxMean = 11;
  gphBestfitStddev = 12;
  gphBestfitStddevMean = 13;
  gphBestfitStddevMinmax = 14;
  gphAll = 15;

{ Palette constants. }

{ PaletteConstants }

//gphDefault = 0;
  gphPastel = 1;
  gphGrayscale = 2;

{ PatternLines constants. }

{ PatternedLinesConstants }

  gphPatternOff = 0;
  gphPatternOn = 1;

{ PrintSyle constants. }

{ PrintStyleConstants }

//gphMonochrome = 0;
//gphColor = 1;
  gphMonochromeWithBorder = 2;
  gphColorWithBorder = 3;

{ RandomData constants. }

{ RandomDataConstants }

//gphOff = 0;
//gphOn = 1;

{ SymbolData constants. }

{ SymbolDataConstants }

  gphCrossPlus = 0;
  gphCrossTimes = 1;
  gphTriangleUp = 2;
  gphSolidTriangleUp = 3;
  gphTriangleDown = 4;
  gphSolidTriangleDown = 5;
  gphSquare = 6;
  gphSolidSquare = 7;
  gphDiamond = 8;
  gphSolidDiamond = 9;

{ ThickLines constants. }

{ ThickLinesConstants }

  gphLinesOff = 0;
  gphLinesOn = 1;

{ Ticks constants. }

{ TicksConstants }

  gphTicksOff = 0;
  gphTicksOn = 1;
  gphXAxisTicksOnly = 2;
  gphYAxisTicksOnly = 3;

{ YAxisPos constants. }

{ YAxisPosConstants }

//gphDefault = 0;
  gphAlignLeft = 1;
  gphAlignRight = 2;

{ YAxisStyle constants. }

{ YAxisStyleConstants }

//gphDefault = 0;
  gphVariableOrigin = 1;
  gphUserDefined = 2;

{ BorderStyle constants. }

{ BorderStyleConstants }

//gphNone = 0;
  gphFixedSingle = 1;

const

{ Component class GUIDs }
  Class_Graph: TGUID = '{0842D100-1E19-101B-9AAF-1A1626551E7C}';

type

{ Forward declarations }
{ Forward declarations: Interfaces }
  _DGraph = dispinterface;
  _DGraphEvents = dispinterface;

{ Forward declarations: CoClasses }
  Graph = _DGraph;

{ Forward declarations: Enums }
  AutoIncConstants = TOleEnum;
  BackgroundConstants = TOleEnum;
  ColorDataConstants = TOleEnum;
  DataResetConstants = TOleEnum;
  DrawModeConstants = TOleEnum;
  DrawStyleConstants = TOleEnum;
  FontFamilyConstants = TOleEnum;
  FontStyleConstants = TOleEnum;
  FontUseConstants = TOleEnum;
  ForegroundConstants = TOleEnum;
  GraphTypeConstants = TOleEnum;
  GridStyleConstants = TOleEnum;
  IndexStyleConstants = TOleEnum;
  LabelsConstants = TOleEnum;
  LegendStyleConstants = TOleEnum;
  LineStatsConstants = TOleEnum;
  PaletteConstants = TOleEnum;
  PatternedLinesConstants = TOleEnum;
  PrintStyleConstants = TOleEnum;
  RandomDataConstants = TOleEnum;
  SymbolDataConstants = TOleEnum;
  ThickLinesConstants = TOleEnum;
  TicksConstants = TOleEnum;
  YAxisPosConstants = TOleEnum;
  YAxisStyleConstants = TOleEnum;
  BorderStyleConstants = TOleEnum;

  _DGraph = dispinterface
    ['{0842D101-1E19-101B-9AAF-1A1626551E7C}']
    property AutoInc: AutoIncConstants dispid 1;
    property Background: BackgroundConstants dispid 2;
    property BottomTitle: WideString dispid 3;
    property ColorData: ColorDataConstants dispid 4;
    property CtlVersion: WideString dispid 5;
    property DataReset: DataResetConstants dispid 6;
    property DrawMode: DrawModeConstants dispid 7;
    property DrawStyle: DrawStyleConstants dispid 8;
    property ExtraData: Smallint dispid 9;
    property FontFamily: FontFamilyConstants dispid 10;
    property FontSize: Smallint dispid 11;
    property FontStyle: FontStyleConstants dispid 12;
    property FontUse: FontUseConstants dispid 13;
    property Foreground: ForegroundConstants dispid 14;
    property GraphCaption: WideString dispid 15;
    property GraphData: Single dispid 16;
    property GraphStyle: Smallint dispid 17;
    property GraphTitle: WideString dispid 18;
    property GraphType: GraphTypeConstants dispid 19;
    property GridStyle: GridStyleConstants dispid 20;
    property ImageFile: WideString dispid 21;
    property IndexStyle: IndexStyleConstants dispid 22;
    property LabelEvery: Smallint dispid 23;
    property Labels: LabelsConstants dispid 24;
    property LabelText: WideString dispid 25;
    property LeftTitle: WideString dispid 26;
    property LegendStyle: LegendStyleConstants dispid 27;
    property LegendText: WideString dispid 28;
    property LineStats: LineStatsConstants dispid 29;
    property NumPoints: Smallint dispid 30;
    property NumSets: Smallint dispid 31;
    property Palette: PaletteConstants dispid 32;
    property PatternData: Smallint dispid 33;
    property PatternedLines: PatternedLinesConstants dispid 34;
    property Picture: IPictureDisp dispid 35;
    property PrintStyle: PrintStyleConstants dispid 36;
    property QuickData: WideString dispid 37;
    property RandomData: RandomDataConstants dispid 38;
    property SeeThru: Smallint dispid 39;
    property SymbolData: SymbolDataConstants dispid 40;
    property ThickLines: ThickLinesConstants dispid 41;
    property ThisPoint: Smallint dispid 42;
    property ThisSet: Smallint dispid 43;
    property TickEvery: Smallint dispid 44;
    property Ticks: TicksConstants dispid 45;
    property XPosData: Single dispid 46;
    property YAxisMax: Single dispid 47;
    property YAxisMin: Single dispid 48;
    property YAxisPos: YAxisPosConstants dispid 49;
    property YAxisStyle: YAxisStyleConstants dispid 50;
    property YAxisTicks: Smallint dispid 51;
    property Enabled: WordBool dispid -514;
    property BorderStyle: BorderStyleConstants dispid -504;
    property hWnd: OLE_HANDLE dispid -515;
    property _QuickData: WideString dispid 0;
    property Color[index: Smallint]: Smallint dispid 52;
    property Data[index: Smallint]: Single dispid 53;
    property Extra[index: Smallint]: Smallint dispid 54;
    property FFamily[index: Smallint]: Smallint dispid 55;
    property FSize[index: Smallint]: Smallint dispid 56;
    property FStyle[index: Smallint]: Smallint dispid 57;
    property Label_[index: Smallint]: WideString dispid 58;
    property Legend[index: Smallint]: WideString dispid 59;
    property Pattern[index: Smallint]: Smallint dispid 60;
    property Symbol[index: Smallint]: Smallint dispid 61;
    property XPos[index: Smallint]: Single dispid 62;
    procedure Refresh; dispid -550;
    procedure AboutBox; dispid -552;
  end;

  _DGraphEvents = dispinterface
    ['{0842D102-1E19-101B-9AAF-1A1626551E7C}']
    procedure Click; dispid -600;
    procedure DblClick; dispid -601;
    procedure KeyDown(var KeyCode: Smallint; Shift: Smallint); dispid -602;
    procedure KeyPress(var KeyAscii: Smallint); dispid -603;
    procedure KeyUp(var KeyCode: Smallint; Shift: Smallint); dispid -604;
    procedure MouseDown(Button, Shift: Smallint; X: OLE_XPOS_PIXELS; Y: OLE_YPOS_PIXELS); dispid -605;
    procedure MouseMove(Button, Shift: Smallint; X: OLE_XPOS_PIXELS; Y: OLE_YPOS_PIXELS); dispid -606;
    procedure MouseUp(Button, Shift: Smallint; X: OLE_XPOS_PIXELS; Y: OLE_YPOS_PIXELS); dispid -607;
  end;

{ Pinnacle-BPS Graph Control }

  TGraph = class(TOleControl)
  private
    FIntf: _DGraph;
    function Get_hWnd: OLE_HANDLE;
    procedure Set_hWnd(var Value: OLE_HANDLE);
    function Get_Color(index: Smallint): Smallint;
    procedure Set_Color(index: Smallint; Value: Smallint);
    function Get_Data(index: Smallint): Single;
    procedure Set_Data(index: Smallint; Value: Single);
    function Get_Extra(index: Smallint): Smallint;
    procedure Set_Extra(index: Smallint; Value: Smallint);
    function Get_FFamily(index: Smallint): Smallint;
    procedure Set_FFamily(index: Smallint; Value: Smallint);
    function Get_FSize(index: Smallint): Smallint;
    procedure Set_FSize(index: Smallint; Value: Smallint);
    function Get_FStyle(index: Smallint): Smallint;
    procedure Set_FStyle(index: Smallint; Value: Smallint);
    function Get_Label_(index: Smallint): WideString;
    procedure Set_Label_(index: Smallint; const Value: WideString);
    function Get_Legend(index: Smallint): WideString;
    procedure Set_Legend(index: Smallint; const Value: WideString);
    function Get_Pattern(index: Smallint): Smallint;
    procedure Set_Pattern(index: Smallint; Value: Smallint);
    function Get_Symbol(index: Smallint): Smallint;
    procedure Set_Symbol(index: Smallint; Value: Smallint);
    function Get_XPos(index: Smallint): Single;
    procedure Set_XPos(index: Smallint; Value: Single);
  protected
    procedure InitControlData; override;
    procedure InitControlInterface(const Obj: IUnknown); override;
  public
    procedure Refresh;
    procedure AboutBox;
    property ControlInterface: _DGraph read FIntf;
    property Picture: TPicture index 35 read GetTPictureProp write SetTPictureProp;
    property QuickData: WideString index 37 read GetWideStringProp write SetWideStringProp;
    property SeeThru: Smallint index 39 read GetSmallintProp write SetSmallintProp;
    property _QuickData: WideString index 0 read GetWideStringProp write SetWideStringProp;
    property Color[index: Smallint]: Smallint read Get_Color write Set_Color;
    property Data[index: Smallint]: Single read Get_Data write Set_Data;
    property Extra[index: Smallint]: Smallint read Get_Extra write Set_Extra;
    property FFamily[index: Smallint]: Smallint read Get_FFamily write Set_FFamily;
    property FSize[index: Smallint]: Smallint read Get_FSize write Set_FSize;
    property FStyle[index: Smallint]: Smallint read Get_FStyle write Set_FStyle;
    property Label_[index: Smallint]: WideString read Get_Label_ write Set_Label_;
    property Legend[index: Smallint]: WideString read Get_Legend write Set_Legend;
    property Pattern[index: Smallint]: Smallint read Get_Pattern write Set_Pattern;
    property Symbol[index: Smallint]: Smallint read Get_Symbol write Set_Symbol;
    property XPos[index: Smallint]: Single read Get_XPos write Set_XPos;
  published
    property TabStop;
    property Align;
    property DragCursor;
    property DragMode;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property Visible;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDrag;
    property OnMouseUp;
    property OnMouseMove;
    property OnMouseDown;
    property OnKeyUp;
    property OnKeyPress;
    property OnKeyDown;
    property OnDblClick;
    property OnClick;
    property AutoInc: AutoIncConstants index 1 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Background: BackgroundConstants index 2 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property BottomTitle: WideString index 3 read GetWideStringProp write SetWideStringProp stored False;
    property ColorData: ColorDataConstants index 4 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property CtlVersion: WideString index 5 read GetWideStringProp write SetWideStringProp stored False;
    property DataReset: DataResetConstants index 6 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property DrawMode: DrawModeConstants index 7 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property DrawStyle: DrawStyleConstants index 8 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property ExtraData: Smallint index 9 read GetSmallintProp write SetSmallintProp stored False;
    property FontFamily: FontFamilyConstants index 10 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property FontSize: Smallint index 11 read GetSmallintProp write SetSmallintProp stored False;
    property FontStyle: FontStyleConstants index 12 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property FontUse: FontUseConstants index 13 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Foreground: ForegroundConstants index 14 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property GraphCaption: WideString index 15 read GetWideStringProp write SetWideStringProp stored False;
    property GraphData: Single index 16 read GetSingleProp write SetSingleProp stored False;
    property GraphStyle: Smallint index 17 read GetSmallintProp write SetSmallintProp stored False;
    property GraphTitle: WideString index 18 read GetWideStringProp write SetWideStringProp stored False;
    property GraphType: GraphTypeConstants index 19 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property GridStyle: GridStyleConstants index 20 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property ImageFile: WideString index 21 read GetWideStringProp write SetWideStringProp stored False;
    property IndexStyle: IndexStyleConstants index 22 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property LabelEvery: Smallint index 23 read GetSmallintProp write SetSmallintProp stored False;
    property Labels: LabelsConstants index 24 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property LabelText: WideString index 25 read GetWideStringProp write SetWideStringProp stored False;
    property LeftTitle: WideString index 26 read GetWideStringProp write SetWideStringProp stored False;
    property LegendStyle: LegendStyleConstants index 27 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property LegendText: WideString index 28 read GetWideStringProp write SetWideStringProp stored False;
    property LineStats: LineStatsConstants index 29 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property NumPoints: Smallint index 30 read GetSmallintProp write SetSmallintProp stored False;
    property NumSets: Smallint index 31 read GetSmallintProp write SetSmallintProp stored False;
    property Palette: PaletteConstants index 32 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property PatternData: Smallint index 33 read GetSmallintProp write SetSmallintProp stored False;
    property PatternedLines: PatternedLinesConstants index 34 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property PrintStyle: PrintStyleConstants index 36 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property RandomData: RandomDataConstants index 38 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property SymbolData: SymbolDataConstants index 40 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property ThickLines: ThickLinesConstants index 41 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property ThisPoint: Smallint index 42 read GetSmallintProp write SetSmallintProp stored False;
    property ThisSet: Smallint index 43 read GetSmallintProp write SetSmallintProp stored False;
    property TickEvery: Smallint index 44 read GetSmallintProp write SetSmallintProp stored False;
    property Ticks: TicksConstants index 45 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property XPosData: Single index 46 read GetSingleProp write SetSingleProp stored False;
    property YAxisMax: Single index 47 read GetSingleProp write SetSingleProp stored False;
    property YAxisMin: Single index 48 read GetSingleProp write SetSingleProp stored False;
    property YAxisPos: YAxisPosConstants index 49 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property YAxisStyle: YAxisStyleConstants index 50 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property YAxisTicks: Smallint index 51 read GetSmallintProp write SetSmallintProp stored False;
    property Enabled: WordBool index -514 read GetWordBoolProp write SetWordBoolProp stored False;
    property BorderStyle: BorderStyleConstants index -504 read GetTOleEnumProp write SetTOleEnumProp stored False;
//    property hWnd: OLE_HANDLE read Get_hWnd write Set_hWnd stored False;
  end;

procedure Register;

implementation

uses ComObj;

procedure TGraph.InitControlData;
const
  CTPictureIDs: array [0..0] of Integer = (
    $00000023);
  CControlData: TControlData = (
    ClassID: '{0842D100-1E19-101B-9AAF-1A1626551E7C}';
    EventIID: '{0842D102-1E19-101B-9AAF-1A1626551E7C}';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil;
    Flags: $00000008;
    Version: 300;
    FontCount: 0;
    FontIDs: nil;
    PictureCount: 1;
    PictureIDs: @CTPictureIDs);
begin
  ControlData := @CControlData;
end;

procedure TGraph.InitControlInterface(const Obj: IUnknown);
begin
  FIntf := Obj as _DGraph;
end;

procedure TGraph.Refresh;
begin
  ControlInterface.Refresh;
end;

procedure TGraph.AboutBox;
begin
  ControlInterface.AboutBox;
end;

function TGraph.Get_hWnd: OLE_HANDLE;
begin
  Result := ControlInterface.hWnd;
end;

procedure TGraph.Set_hWnd(var Value: OLE_HANDLE);
begin
  ControlInterface.hWnd := Value;
end;

function TGraph.Get_Color(index: Smallint): Smallint;
begin
  Result := ControlInterface.Color[index];
end;

procedure TGraph.Set_Color(index: Smallint; Value: Smallint);
begin
  ControlInterface.Color[index] := Value;
end;

function TGraph.Get_Data(index: Smallint): Single;
begin
  Result := ControlInterface.Data[index];
end;

procedure TGraph.Set_Data(index: Smallint; Value: Single);
begin
  ControlInterface.Data[index] := Value;
end;

function TGraph.Get_Extra(index: Smallint): Smallint;
begin
  Result := ControlInterface.Extra[index];
end;

procedure TGraph.Set_Extra(index: Smallint; Value: Smallint);
begin
  ControlInterface.Extra[index] := Value;
end;

function TGraph.Get_FFamily(index: Smallint): Smallint;
begin
  Result := ControlInterface.FFamily[index];
end;

procedure TGraph.Set_FFamily(index: Smallint; Value: Smallint);
begin
  ControlInterface.FFamily[index] := Value;
end;

function TGraph.Get_FSize(index: Smallint): Smallint;
begin
  Result := ControlInterface.FSize[index];
end;

procedure TGraph.Set_FSize(index: Smallint; Value: Smallint);
begin
  ControlInterface.FSize[index] := Value;
end;

function TGraph.Get_FStyle(index: Smallint): Smallint;
begin
  Result := ControlInterface.FStyle[index];
end;

procedure TGraph.Set_FStyle(index: Smallint; Value: Smallint);
begin
  ControlInterface.FStyle[index] := Value;
end;

function TGraph.Get_Label_(index: Smallint): WideString;
begin
  Result := ControlInterface.Label_[index];
end;

procedure TGraph.Set_Label_(index: Smallint; const Value: WideString);
begin
  ControlInterface.Label_[index] := Value;
end;

function TGraph.Get_Legend(index: Smallint): WideString;
begin
  Result := ControlInterface.Legend[index];
end;

procedure TGraph.Set_Legend(index: Smallint; const Value: WideString);
begin
  ControlInterface.Legend[index] := Value;
end;

function TGraph.Get_Pattern(index: Smallint): Smallint;
begin
  Result := ControlInterface.Pattern[index];
end;

procedure TGraph.Set_Pattern(index: Smallint; Value: Smallint);
begin
  ControlInterface.Pattern[index] := Value;
end;

function TGraph.Get_Symbol(index: Smallint): Smallint;
begin
  Result := ControlInterface.Symbol[index];
end;

procedure TGraph.Set_Symbol(index: Smallint; Value: Smallint);
begin
  ControlInterface.Symbol[index] := Value;
end;

function TGraph.Get_XPos(index: Smallint): Single;
begin
  Result := ControlInterface.XPos[index];
end;

procedure TGraph.Set_XPos(index: Smallint; Value: Single);
begin
  ControlInterface.XPos[index] := Value;
end;


procedure Register;
begin
  RegisterComponents('ActiveX', [TGraph]);
end;

end.
