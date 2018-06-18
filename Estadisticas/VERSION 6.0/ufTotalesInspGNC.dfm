object frmTotalesInspGNC: TfrmTotalesInspGNC
  Left = 205
  Top = 119
  Width = 819
  Height = 591
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'frmTotalesInspGNC'
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 794
    Height = 47
    Align = alTop
    TabOrder = 0
    object depiinsp: TDecisionPivot
      Left = 2
      Top = 2
      Width = 330
      Height = 42
      ButtonAutoSize = True
      DecisionSource = desuinsp
      GroupLayout = xtHorizontal
      Groups = [xtRows, xtColumns, xtSummaries]
      ButtonSpacing = 3
      ButtonWidth = 64
      ButtonHeight = 24
      GroupSpacing = 10
      BorderWidth = 3
      BorderStyle = bsNone
      TabOrder = 0
    end
  end
  object degrinsp: TDecisionGrid
    Left = 0
    Top = 46
    Width = 716
    Height = 375
    Options = [cgGridLines, cgPivotable]
    DefaultColWidth = 90
    DefaultRowHeight = 20
    CaptionColor = clActiveCaption
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clCaptionText
    CaptionFont.Height = -11
    CaptionFont.Name = 'Default'
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
    LabelFont.Name = 'Default'
    LabelFont.Style = []
    LabelColor = clBtnFace
    LabelSumColor = clTeal
    DecisionSource = desuinsp
    Dimensions = <
      item
        FieldName = 'ZONA'
        Color = clNone
        Alignment = taCenter
        Subtotals = True
      end
      item
        FieldName = 'PLANTA'
        Color = clNone
        Alignment = taCenter
        Subtotals = True
      end
      item
        FieldName = 'FECHA'
        Color = clNone
        Alignment = taCenter
        Subtotals = True
      end
      item
        FieldName = 'Aptas'
        Color = clNone
        Alignment = taCenter
        Subtotals = True
      end
      item
        FieldName = 'Total'
        Color = clNone
        Alignment = taCenter
        Subtotals = True
      end
      item
        FieldName = 'SUPER'
        Color = clNone
        Alignment = taCenter
        Subtotals = True
      end>
    Totals = True
    ShowCubeEditor = False
    Color = clBtnFace
    GridLineWidth = 1
    GridLineColor = clBlack
    TabOrder = 1
  end
  object btnSalir: TBitBtn
    Left = 407
    Top = 503
    Width = 75
    Height = 58
    Caption = 'Salir'
    TabOrder = 2
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
    Top = 503
    Width = 75
    Height = 58
    Caption = 'Exportar'
    TabOrder = 3
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
  object decuinsp: TDecisionCube
    DataSet = dequinsp
    DimensionMap = <
      item
        ActiveFlag = diAsNeeded
        FieldType = ftFloat
        Fieldname = 'ZONA'
        BaseName = 'TTMP_RECHAZOS_INSPGNC.ZONA'
        Name = 'ZONA'
        DerivedFrom = -1
        DimensionType = dimDimension
        BinType = binNone
        ValueCount = 0
        Active = True
      end
      item
        ActiveFlag = diAsNeeded
        FieldType = ftFloat
        Fieldname = 'PLANTA'
        BaseName = 'TTMP_RECHAZOS_INSPGNC.PLANTA'
        Name = 'PLANTA'
        DerivedFrom = -1
        DimensionType = dimDimension
        BinType = binNone
        ValueCount = 0
        Active = True
      end
      item
        ActiveFlag = diAsNeeded
        FieldType = ftString
        Fieldname = 'MES'
        BaseName = 'TTMP_RECHAZOS_INSPGNC.MES'
        Name = 'MES'
        DerivedFrom = -1
        DimensionType = dimDimension
        BinType = binNone
        ValueCount = 0
        Active = True
      end
      item
        ActiveFlag = diAsNeeded
        FieldType = ftFloat
        Fieldname = 'SUM(RECHAZADAS)'
        BaseName = 'TTMP_RECHAZOS_INSPGNC.RECHAZADAS'
        Name = 'Rech.'
        DerivedFrom = -1
        DimensionType = dimSum
        BinType = binNone
        ValueCount = -1
        Active = True
      end
      item
        ActiveFlag = diAsNeeded
        FieldType = ftFloat
        Fieldname = 'SUM(APTAS)'
        BaseName = 'TTMP_RECHAZOS_INSPGNC.APTAS'
        Name = 'Aptas'
        DerivedFrom = -1
        DimensionType = dimSum
        BinType = binNone
        ValueCount = -1
        Active = True
      end
      item
        ActiveFlag = diAsNeeded
        FieldType = ftFloat
        Fieldname = 'SUM(PPIVOT)'
        BaseName = 'TTMP_RECHAZOS_INSPGNC.PPIVOT'
        Name = 'SUPER'
        DerivedFrom = -1
        DimensionType = dimSum
        BinType = binNone
        ValueCount = -1
        Active = True
      end>
    ShowProgressDialog = True
    MaxDimensions = 10
    MaxSummaries = 10
    MaxCells = 1000000
    Left = 603
    Top = 504
  end
  object dequinsp: TDecisionQuery
    AutoRefresh = True
    DatabaseName = 'AliasVTV'
    SQL.Strings = (
      
        'SELECT ZONA, PLANTA, MES, SUM( RECHAZADAS ), SUM( APTAS ), SUM( ' +
        'PPIVOT )'
      'FROM TTMP_RECHAZOS_INSPGNC'
      'GROUP BY ZONA, PLANTA, MES')
    Left = 574
    Top = 504
  end
  object desuinsp: TDecisionSource
    DecisionCube = decuinsp
    ControlType = xtCheck
    SparseRows = False
    SparseCols = False
    Left = 631
    Top = 504
    DimensionCount = 3
    SummaryCount = 3
    CurrentSummary = 0
    SparseRows = False
    SparseCols = False
    DimensionInfo = (
      1
      0
      1
      0
      0
      1
      1
      1
      1
      -1
      2
      0
      1
      0
      0)
  end
  object OpenDialog: TOpenDialog
    Left = 512
    Top = 176
  end
end
