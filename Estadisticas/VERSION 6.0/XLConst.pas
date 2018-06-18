unit XLConst;

interface

const
{ XlSheetType }
  xlChart = -4109;
  xlDialogSheet = -4116;
  xlExcel4IntlMacroSheet = 4;
  xlExcel4MacroSheet = 3;
  xlWorksheet = -4167;

{ XlWBATemplate }
  xlWBATChart = -4109;
  xlWBATExcel4IntlMacroSheet = 4;
  xlWBATExcel4MacroSheet = 3;
  xlWBATWorksheet = -4167;

{ XlPattern }

  xlPatternAutomatic = -4105;
  xlPatternChecker = 9;
  xlPatternCrissCross = 16;
  xlPatternDown = -4121;
  xlPatternGray16 = 17;
  xlPatternGray25 = -4124;
  xlPatternGray50 = -4125;
  xlPatternGray75 = -4126;
  xlPatternGray8 = 18;
  xlPatternGrid = 15;
  xlPatternHorizontal = -4128;
  xlPatternLightDown = 13;
  xlPatternLightHorizontal = 11;
  xlPatternLightUp = 14;
  xlPatternLightVertical = 12;
  xlPatternNone = -4142;
  xlPatternSemiGray75 = 10;
  xlPatternSolid = 1;
  xlPatternUp = -4162;
  xlPatternVertical = -4166;

  { XlBordersIndex }

  xlInsideHorizontal = 12;
  xlInsideVertical = 11;
  xlDiagonalDown = 5;
  xlDiagonalUp = 6;
  xlEdgeBottom = 9;
  xlEdgeLeft = 7;
  xlEdgeRight = 10;
  xlEdgeTop = 8;

{ XlLineStyle }

  xlContinuous = 1;
  xlDash = -4115;
  xlDashDot = 4;
  xlDashDotDot = 5;
  xlDot = -4118;
  xlDouble = -4119;
  xlSlantDashDot = 13;
  xlLineStyleNone = -4142;

  { XlChartType }

  xlColumnClustered = 51;
  xlColumnStacked = 52;
  xlColumnStacked100 = 53;
  xl3DColumnClustered = 54;
  xl3DColumnStacked = 55;
  xl3DColumnStacked100 = 56;
  xlBarClustered = 57;
  xlBarStacked = 58;
  xlBarStacked100 = 59;
  xl3DBarClustered = 60;
  xl3DBarStacked = 61;
  xl3DBarStacked100 = 62;
  xlLineStacked = 63;
  xlLineStacked100 = 64;
  xlLineMarkers = 65;
  xlLineMarkersStacked = 66;
  xlLineMarkersStacked100 = 67;
  xlPieOfPie = 68;
  xlPieExploded = 69;
  xl3DPieExploded = 70;
  xlBarOfPie = 71;
  xlXYScatterSmooth = 72;
  xlXYScatterSmoothNoMarkers = 73;
  xlXYScatterLines = 74;
  xlXYScatterLinesNoMarkers = 75;
  xlAreaStacked = 76;
  xlAreaStacked100 = 77;
  xl3DAreaStacked = 78;
  xl3DAreaStacked100 = 79;
  xlDoughnutExploded = 80;
  xlRadarMarkers = 81;
  xlRadarFilled = 82;
  xlSurface = 83;
  xlSurfaceWireframe = 84;
  xlSurfaceTopView = 85;
  xlSurfaceTopViewWireframe = 86;
  xlBubble = 15;
  xlBubble3DEffect = 87;
  xlStockHLC = 88;
  xlStockOHLC = 89;
  xlStockVHLC = 90;
  xlStockVOHLC = 91;
  xlCylinderColClustered = 92;
  xlCylinderColStacked = 93;
  xlCylinderColStacked100 = 94;
  xlCylinderBarClustered = 95;
  xlCylinderBarStacked = 96;
  xlCylinderBarStacked100 = 97;
  xlCylinderCol = 98;
  xlConeColClustered = 99;
  xlConeColStacked = 100;
  xlConeColStacked100 = 101;
  xlConeBarClustered = 102;
  xlConeBarStacked = 103;
  xlConeBarStacked100 = 104;
  xlConeCol = 105;
  xlPyramidColClustered = 106;
  xlPyramidColStacked = 107;
  xlPyramidColStacked100 = 108;
  xlPyramidBarClustered = 109;
  xlPyramidBarStacked = 110;
  xlPyramidBarStacked100 = 111;
  xlPyramidCol = 112;
  xl3DColumn = -4100;
  xlLine = 4;
  xl3DLine = -4101;
  xl3DPie = -4102;
  xlPie = 5;
  xlXYScatter = -4169;
  xl3DArea = -4098;
  xlArea = 1;
  xlDoughnut = -4120;
  xlRadar = -4151;


{ Various Constants }
  xlAll = -4104;
  xlAutomatic = -4105;
  xlBoth = 1;
  xlCenter = -4108;
  xlChecker = 9;
  xlCircle = 8;
  xlCorner = 2;
  xlCrissCross = 16;
  xlCross = 4;
  xlDiamond = 2;
  xlDistributed = -4117;
  xlDoubleAccounting = 5;
  xlFixedValue = 1;
  xlFormats = -4122;
  xlGray16 = 17;
  xlGray8 = 18;
  xlGrid = 15;
  xlHigh = -4127;
  xlInside = 2;
  xlJustify = -4130;
  xlLightDown = 13;
  xlLightHorizontal = 11;
  xlLightUp = 14;
  xlLightVertical = 12;
  xlLow = -4134;
  xlManual = -4135;
  xlMinusValues = 3;
  xlModule = -4141;
  xlNextToAxis = 4;
  xlNone = -4142;
  xlNotes = -4144;
  xlOff = -4146;
  xlOn = 1;
  xlPercent = 2;
  xlPlus = 9;
  xlPlusValues = 2;
  xlSemiGray75 = 10;
  xlShowLabel = 4;
  xlShowLabelAndPercent = 5;
  xlShowPercent = 3;
  xlShowValue = 2;
  xlSimple = -4154;
  xlSingle = 2;
  xlSingleAccounting = 4;
  xlSolid = 1;
  xlSquare = 1;
  xlStar = 5;
  xlStError = 4;
  xlToolbarButton = 2;
  xlTriangle = 3;
  xlGray25 = -4124;
  xlGray50 = -4125;
  xlGray75 = -4126;
  xlBottom = -4107;
  xlLeft = -4131;
  xlRight = -4152;
  xlTop = -4160;
  xl3DBar = -4099;
  xl3DSurface = -4103;
  xlBar = 2;
  xlColumn = 3;
  xlCombination = -4111;
  xlCustom = -4114;
  xlDefaultAutoFormat = -1;
  xlMaximum = 2;
  xlMinimum = 4;
  xlOpaque = 3;
  xlTransparent = 2;
  xlBidi = -5000;
  xlLatin = -5001;
  xlContext = -5002;
  xlLTR = -5003;
  xlRTL = -5004;
  xlVisualCursor = 2;
  xlLogicalCursor = 1;
  xlSystem = 1;
  xlPartial = 3;
  xlHindiNumerals = 3;
  xlBidiCalendar = 3;
  xlGregorian = 2;
  xlComplete = 4;
  xlScale = 3;
  xlClosed = 3;
  xlColor1 = 7;
  xlColor2 = 8;
  xlColor3 = 9;
  xlConstants = 2;
  xlContents = 2;
  xlBelow = 1;
  xlCascade = 7;
  xlCenterAcrossSelection = 7;
  xlChart4 = 2;
  xlChartSeries = 17;
  xlChartShort = 6;
  xlChartTitles = 18;
  xlClassic1 = 1;
  xlClassic2 = 2;
  xlClassic3 = 3;
  xl3DEffects1 = 13;
  xl3DEffects2 = 14;
  xlAbove = 0;
  xlAccounting1 = 4;
  xlAccounting2 = 5;
  xlAccounting3 = 6;
  xlAccounting4 = 17;
  xlAdd = 2;
  xlDebugCodePane = 13;
  xlDesktop = 9;
  xlDirect = 1;
  xlDivide = 5;
  xlDoubleClosed = 5;
  xlDoubleOpen = 4;
  xlDoubleQuote = 1;
  xlEntireChart = 20;
  xlExcelMenus = 1;
  xlExtended = 3;
  xlFill = 5;
  xlFirst = 0;
  xlFloating = 5;
  xlFormula = 5;
  xlGeneral = 1;
  xlGridline = 22;
  xlIcons = 1;
  xlImmediatePane = 12;
  xlInteger = 2;
  xlLast = 1;
  xlLastCell = 11;
  xlList1 = 10;
  xlList2 = 11;
  xlList3 = 12;
  xlLocalFormat1 = 15;
  xlLocalFormat2 = 16;
  xlLong = 3;
  xlLotusHelp = 2;
  xlMacrosheetCell = 7;
  xlMixed = 2;
  xlMultiply = 4;
  xlNarrow = 1;
  xlNoDocuments = 3;
  xlOpen = 2;
  xlOutside = 3;
  xlReference = 4;
  xlSemiautomatic = 2;
  xlShort = 1;
  xlSingleQuote = 2;
  xlStrict = 2;
  xlSubtract = 3;
  xlTextBox = 16;
  xlTiled = 1;
  xlTitleBar = 8;
  xlToolbar = 1;
  xlVisible = 12;
  xlWatchPane = 11;
  xlWide = 3;
  xlWorkbookTab = 6;
  xlWorksheet4 = 1;
  xlWorksheetCell = 3;
  xlWorksheetShort = 5;
  xlAllExceptBorders = 6;
  xlLeftToRight = 2;
  xlTopToBottom = 1;
  xlVeryHidden = 2;
  xlDrawingObject = 14;

implementation

end.
