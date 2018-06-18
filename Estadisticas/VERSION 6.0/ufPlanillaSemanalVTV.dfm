object frmPlanillaSemanalVTV: TfrmPlanillaSemanalVTV
  Left = 183
  Top = 190
  Width = 819
  Height = 686
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'frmPlanillaSemanalVTV'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 422
    Width = 810
    Height = 128
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 204
    Top = 430
    Width = 90
    Height = 13
    Caption = 'D'#237'as Transcurridos'
  end
  object Label2: TLabel
    Left = 204
    Top = 454
    Width = 73
    Height = 13
    Caption = 'D'#237'as que faltan'
  end
  object Label3: TLabel
    Left = 204
    Top = 478
    Width = 72
    Height = 13
    Caption = 'Media Diaria'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 428
    Top = 430
    Width = 96
    Height = 13
    Caption = 'Acum Semanas Ant.'
  end
  object Label5: TLabel
    Left = 428
    Top = 454
    Width = 50
    Height = 13
    Caption = 'Acum Mes'
  end
  object Label6: TLabel
    Left = 428
    Top = 478
    Width = 109
    Height = 13
    Caption = 'Previsto fin de mes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 204
    Top = 526
    Width = 63
    Height = 13
    Caption = 'Media Reves'
  end
  object Label8: TLabel
    Left = 204
    Top = 502
    Width = 80
    Height = 13
    Caption = 'Media diaria total'
  end
  object Label9: TLabel
    Left = 428
    Top = 502
    Width = 98
    Height = 13
    Caption = 'Mes A'#241'o Anterior'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 840
    Height = 47
    Align = alTop
    TabOrder = 0
    object FxPivot3: TFxPivot
      Left = 530
      Top = 0
      Width = 281
      Height = 41
      ButtonAutoSize = True
      DecisionSource = desuacum
      GroupLayout = xtHorizontal
      Groups = [xtRows, xtColumns, xtSummaries]
      ButtonSpacing = 0
      ButtonWidth = 64
      ButtonHeight = 24
      GroupSpacing = 10
      BorderWidth = 0
      BorderStyle = bsNone
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 717
    Top = 48
    Width = 91
    Height = 19
    Caption = 'Acumulados'
    TabOrder = 1
  end
  object edDiasTranscurridos: TEdit
    Left = 300
    Top = 426
    Width = 65
    Height = 21
    TabOrder = 2
  end
  object edDiasFaltan: TEdit
    Left = 300
    Top = 450
    Width = 65
    Height = 21
    TabOrder = 3
  end
  object edMediaDiaria: TEdit
    Left = 300
    Top = 474
    Width = 65
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object edAcumSemAnterior: TEdit
    Left = 540
    Top = 426
    Width = 65
    Height = 21
    TabOrder = 5
  end
  object edAcumMensual: TEdit
    Left = 540
    Top = 450
    Width = 65
    Height = 21
    TabOrder = 6
  end
  object edPrevisto: TEdit
    Left = 540
    Top = 474
    Width = 65
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object btnSalir: TBitBtn
    Left = 407
    Top = 554
    Width = 75
    Height = 58
    Caption = 'Salir'
    TabOrder = 8
    OnClick = btnSalirClick
    Glyph.Data = {
      76020000424D7602000000000000760000002800000020000000200000000100
      0400000000000002000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF00000000000000FFFFFFFFFFFFFF0000000000000000
      0033333333333330070000000000000000333333333333080700FFFFFFFFFFFF
      F03333333333308807FFFFFFFFFFFFFFF03333333333088807FFFFFFFFFFFFFF
      F03333333333788807FFFFFFFFFFFFFFF0A333333333788807FFFFFFFFFFFFFF
      F0AAAA333333788807FFFFFFFFFFFFFFF0AAAAAAAAAA788807FFFFFFFFFFFFFF
      F0222AAAAAAA788807FFFFFFFFFFFFFFF022222222AA788807FFFFFFFFFFFFFF
      F022222222227F8807FFFFFFFFFFFFFFF022222222227F8807FFFFFFF00FFFFF
      F055555555557F8807FFFFFFF0A0FFFFF0FFFFFF55557F8807FFFF0000220FFF
      F0FFFFFFFFF57F8807FFFF7A222220FFF0FFFFFFFFFF788807FFFF7A2222220F
      F0FFFFFFFFFF788807FFFF7AAAA220FFF0EEEEEEEEEE788807FFFF7777A20FFF
      F0FFFFFFFFFF788807FFFFFFF7A0FFFFF0EEEEEEEEFF788807FFFFFFF70FFFFF
      F0EEEEEEEEEE788807FFFFFFFFFFFFFFF0FFFFFFFEEE788807FFFFFFFFFFFFFF
      F0FFFFFEEEEE788807FFFFFFFFFFFFFFF0FFEEEEEEEE788807FFFFFFFFFFFFFF
      F0EEEEEEEEEEE78807FFFFFFFFFFFFFFF0EEEEEEEEEEEE7807FFFFFFFFFFFFFF
      F0EEEEEEEEEEEEE707FFFFFFFFFFFFFFF00000000000000000FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    Layout = blGlyphTop
  end
  object btnExportar: TBitBtn
    Left = 330
    Top = 554
    Width = 75
    Height = 58
    Caption = 'Exportar'
    TabOrder = 9
    OnClick = btnExportarClick
    Glyph.Data = {
      76020000424D7602000000000000760000002800000020000000200000000100
      0400000000000002000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFF77777777777777777777777777777F00000000000
      00000000000000000077F077777777777777777777777777707FF07777777708
      888888888777777770FFF07777777707777777778777777770FFF07777777707
      777777778777777770FFF07777777700000000008777777770FFF07777777777
      777777777777777770FFF07777770000000000000007777770FFF0777770FFFF
      FFFFFFFFFFF0777770FFF077770F87F7F8F8F8F8F8FF077770FFF00000F87F7F
      7888888F8F8FF00000FFF0FFFF87F7F780000088F8F8FFFFF0FFFF0F77787F78
      077777088F8F708F0FFFFF0F770887F80F888708F8F8787F0FFFFFF0F7778F78
      0F8887088F8707F0FFFFFFF0F77087F80F888708F87778F0FFFFFFFF0F770878
      0F88870887708F0FFFFFFFFF0F7700080F88870800007F0FFFFFFFFFF0F07778
      0F8887087770F0FFFFFFFFFFF0F077780F8887087770F0FFFFFFFFFFFF0F8888
      0F888708888F0FFFFFFFFFFFFF0F00000F888700000F0FFFFFFFFFFFFFF0F087
      7888887770F0FFFFFFFFFFFFFFFFFF0F888888870FFFFFFFFFFFFFFFFFFFFFF0
      F8888870FFFFFFFFFFFFFFFFFFFFFFFF0F88870FFFFFFFFFFFFFFFFFFFFFFFFF
      F0F870FFFFFFFFFFFFFFFFFFFFFFFFFFFF0F0FFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    Layout = blGlyphTop
  end
  object edAcumSemAnteriorT: TEdit
    Left = 612
    Top = 426
    Width = 65
    Height = 21
    TabOrder = 10
  end
  object edAcumMensualT: TEdit
    Left = 612
    Top = 450
    Width = 65
    Height = 21
    TabOrder = 11
  end
  object edPrevistoT: TEdit
    Left = 612
    Top = 474
    Width = 65
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
  end
  object edMediaDiariaTotal: TEdit
    Left = 300
    Top = 498
    Width = 65
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
  end
  object edMediaDiariaReves: TEdit
    Left = 300
    Top = 522
    Width = 65
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 14
  end
  object edAcumMensualAnt: TEdit
    Left = 683
    Top = 450
    Width = 65
    Height = 21
    TabOrder = 15
  end
  object edPrimAnoAnterior: TEdit
    Left = 540
    Top = 498
    Width = 65
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 16
  end
  object edTotalAnoAnterior: TEdit
    Left = 612
    Top = 498
    Width = 65
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 17
  end
  object FxPivot1: TFxPivot
    Left = 8
    Top = 0
    Width = 425
    Height = 41
    ButtonAutoSize = True
    DecisionSource = desuverific
    GroupLayout = xtHorizontal
    Groups = [xtRows, xtColumns, xtSummaries]
    ButtonSpacing = 0
    ButtonWidth = 64
    ButtonHeight = 24
    GroupSpacing = 10
    BorderWidth = 0
    BorderStyle = bsNone
    Caption = 'depiverific'
    TabOrder = 18
  end
  object degrinsp: TFxGrid
    Left = 40
    Top = 64
    Width = 320
    Height = 321
    DefaultColWidth = 100
    DefaultRowHeight = 20
    CaptionColor = clActiveCaption
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clCaptionText
    CaptionFont.Height = -11
    CaptionFont.Name = 'MS Sans Serif'
    CaptionFont.Style = []
    DataColor = clInfoBk
    DataSumColor = clNone
    DataFont.Charset = DEFAULT_CHARSET
    DataFont.Color = clWindowText
    DataFont.Height = -11
    DataFont.Name = 'MS Sans Serif'
    DataFont.Style = []
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    LabelColor = clBtnFace
    LabelSumColor = clInactiveCaption
    LabelSumFont.Charset = DEFAULT_CHARSET
    LabelSumFont.Color = clWindowText
    LabelSumFont.Height = -11
    LabelSumFont.Name = 'MS Sans Serif'
    LabelSumFont.Style = []
    DecisionSource = desuverific
    Dimensions = <>
    Totals = False
    ShowCubeEditor = False
    Color = clBtnFace
    GridLineWidth = 1
    GridLineColor = clWindowText
    TabOrder = 19
  end
  object degracum: TFxGrid
    Left = 520
    Top = 88
    Width = 320
    Height = 313
    DefaultColWidth = 100
    DefaultRowHeight = 20
    CaptionColor = clActiveCaption
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clCaptionText
    CaptionFont.Height = -11
    CaptionFont.Name = 'MS Sans Serif'
    CaptionFont.Style = []
    DataColor = clInfoBk
    DataSumColor = clNone
    DataFont.Charset = DEFAULT_CHARSET
    DataFont.Color = clWindowText
    DataFont.Height = -11
    DataFont.Name = 'MS Sans Serif'
    DataFont.Style = []
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    LabelColor = clBtnFace
    LabelSumColor = clInactiveCaption
    LabelSumFont.Charset = DEFAULT_CHARSET
    LabelSumFont.Color = clWindowText
    LabelSumFont.Height = -11
    LabelSumFont.Name = 'MS Sans Serif'
    LabelSumFont.Style = []
    DecisionSource = desuacum
    Dimensions = <>
    Totals = False
    ShowCubeEditor = False
    Color = clBtnFace
    GridLineWidth = 1
    GridLineColor = clWindowText
    TabOrder = 20
  end
  object OpenDialog: TOpenDialog
    Left = 512
    Top = 176
  end
  object sdsverif: TSQLDataSet
    CommandText = 
      'SELECT ZONA, PLANTA, FECHA, SUM( CANTINSP ), SUM( CANTTOTAL ), S' +
      'UM( PPIVOT ) FROM INFORME_INSPVTV GROUP BY ZONA, PLANTA, FECHA'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLConnection1
    Left = 64
    Top = 548
  end
  object cdsverifc: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dsdverific'
    Left = 128
    Top = 548
  end
  object dsdverific: TDataSetProvider
    DataSet = sdsverif
    Options = [poIncFieldProps, poAllowCommandText]
    Left = 96
    Top = 548
  end
  object decuinsp: TFxCube
    DataSet = sdsverif
    DimensionMap = <
      item
        Active = False
        Caption = 'ZONA'
        FieldName = 'ZONA'
        Name = 'dmNombrePlanta'
        Params = 0
        ValueCount = 1
      end
      item
        Active = False
        Caption = 'PLANTA'
        FieldName = 'PLANTA'
        Name = 'dmAtenciones'
        Params = 0
        ValueCount = 7
      end
      item
        Active = False
        Caption = 'FECHA'
        FieldName = 'FECHA'
        Params = 0
        StartDate = 38353.000000000000000000
        ValueCount = 1
      end
      item
        Active = False
        Caption = '1'#186' Inspecc'
        DimensionType = dimSum
        FieldName = 'SUM(CANTINSP)'
        Name = 'dmCantAprob'
        Params = 0
        ValueCount = 0
      end
      item
        Active = False
        Caption = 'TOTAL'
        DimensionType = dimSum
        FieldName = 'SUM(CANTTOTAL)'
        Name = 'dmCantRechas'
        Params = 0
        ValueCount = 0
      end
      item
        Active = False
        Caption = 'SUPER'
        DimensionType = dimSum
        FieldName = 'SUM(PPIVOT)'
        Name = 'dmImporte'
        Params = 0
        ValueCount = 0
      end>
    MaxDimensions = 3
    MaxSummaries = 3
    MaxCells = 20000
    ShowProgressDialog = True
    Left = 168
    Top = 548
  end
  object desuverific: TFxSource
    ControlType = xtCheck
    DecisionCube = decuinsp
    Left = 200
    Top = 548
    DimensionCount = 3
    SummaryCount = 2
    CurrentSummary = 1
    SparseRows = False
    SparseCols = False
    DimensionInfo = (
      1
      1
      1
      1
      -1
      'dmAtenciones'
      1
      0
      1
      0
      -1
      'dmNombrePlanta'
      2
      0
      1
      0
      -1
      'dmFecha')
  end
  object desuacum: TFxSource
    ControlType = xtCheck
    DecisionCube = decuacu
    Left = 192
    Top = 580
    DimensionCount = 2
    SummaryCount = 3
    CurrentSummary = 0
    SparseRows = False
    SparseCols = False
    DimensionInfo = (
      1
      0
      1
      0
      -1
      'dplanta'
      1
      1
      1
      1
      -1
      'dmaten')
  end
  object cdsacum: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspacum'
    Left = 120
    Top = 588
  end
  object sdsacum: TSQLDataSet
    CommandText = 
      'SELECT ZONA, PLANTA, SUM( RECHAZADAS ), SUM( APTAS ), SUM( PPIVO' +
      'T ) FROM RESUMEN_INSPVTV GROUP BY ZONA, PLANTA'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLConnection1
    Left = 56
    Top = 580
  end
  object decuacu: TFxCube
    DataSet = cdsacum
    DimensionMap = <
      item
        Active = False
        Caption = 'ZONA'
        FieldName = 'ZONA'
        Name = 'dplanta'
        Params = 0
        ValueCount = 3
        Visible = False
      end
      item
        Active = False
        Caption = 'PLANTA'
        FieldName = 'PLANTA'
        Name = 'dmaten'
        Params = 0
        ValueCount = 7
        Visible = False
      end
      item
        Active = False
        Caption = 'Verific'
        DimensionType = dimSum
        FieldName = 'SUM(APTAS)'
        Name = 'dmaprob'
        Params = 0
        ValueCount = 0
      end
      item
        Active = False
        Caption = 'Reves'
        DimensionType = dimSum
        FieldName = 'SUM(RECHAZADAS)'
        Name = 'dmrechazadas'
        Params = 0
        ValueCount = 0
      end
      item
        Active = False
        Caption = 'Super'
        DimensionType = dimSum
        FieldName = 'SUM(PPIVOT)'
        Name = 'dmimporte'
        Params = 0
        ValueCount = 0
      end>
    MaxDimensions = 15
    MaxSummaries = 15
    ShowProgressDialog = True
    Left = 160
    Top = 588
  end
  object dspacum: TDataSetProvider
    DataSet = sdsacum
    Options = [poIncFieldProps, poAllowCommandText]
    Left = 88
    Top = 583
  end
  object SQLConnection1: TSQLConnection
    ConnectionName = 'OracleConnection'
    DriverName = 'Oracle'
    GetDriverFunc = 'getSQLDriverORACLE'
    LibraryName = 'dbexpora.dll'
    Params.Strings = (
      'DriverName=Oracle'
      'Database=APPLUSBD.VTV'
      'USER_NAME=AGEVA'
      'Password=ISO9001'
      'RowsetSize=20'
      'BlobSize=-1'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'Oracle TransIsolation=ReadCommited'
      'OS Authentication=False'
      'Multiple Transaction=False'
      'Trim Char=False')
    VendorLib = 'oci.dll'
    Left = 272
    Top = 568
  end
end
