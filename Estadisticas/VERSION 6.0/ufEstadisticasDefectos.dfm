object frmEstadisticasDefectos: TfrmEstadisticasDefectos
  Left = 103
  Top = 169
  Width = 819
  Height = 604
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Porcentaje de Defectos'
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
  object Label1: TLabel
    Left = 157
    Top = 61
    Width = 155
    Height = 13
    Caption = 'CANTIDAD DE INSPECCIONES'
  end
  object Label2: TLabel
    Left = 16
    Top = 168
    Width = 57
    Height = 13
    Caption = 'DEFECTOS'
  end
  object Label3: TLabel
    Left = 40
    Top = 88
    Width = 32
    Height = 13
    Caption = 'Label3'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 811
    Height = 47
    Align = alTop
    TabOrder = 0
    object FxPivot1: TFxPivot
      Left = 8
      Top = 0
      Width = 345
      Height = 41
      ButtonAutoSize = True
      DecisionSource = desudefe
      GroupLayout = xtHorizontal
      Groups = [xtRows, xtColumns, xtSummaries]
      ButtonSpacing = 0
      ButtonWidth = 64
      ButtonHeight = 24
      GroupSpacing = 10
      BorderWidth = 0
      BorderStyle = bsNone
      Caption = 'depiinsp'
      TabOrder = 0
    end
    object FxPivot2: TFxPivot
      Left = 376
      Top = -2
      Width = 353
      Height = 41
      ButtonAutoSize = True
      DecisionSource = desuincr
      GroupLayout = xtHorizontal
      Groups = [xtRows, xtColumns, xtSummaries]
      ButtonSpacing = 0
      ButtonWidth = 64
      ButtonHeight = 24
      GroupSpacing = 10
      BorderWidth = 0
      BorderStyle = bsNone
      Caption = 'depiincr'
      TabOrder = 1
    end
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
    TabOrder = 1
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
  object degrdefe: TFxGrid
    Left = 16
    Top = 184
    Width = 721
    Height = 273
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
    DecisionSource = desudefe
    Dimensions = <
      item
        FieldName = 'Atencion'
        Color = clNone
        Alignment = taLeftJustify
        Subtotals = True
        Width = 80
      end
      item
        FieldName = 'Planta'
        Color = clNone
        Alignment = taLeftJustify
        Subtotals = True
        Width = 80
      end
      item
        FieldName = 'Fecha'
        Color = clNone
        Alignment = taLeftJustify
        Subtotals = True
        Width = 80
      end
      item
        FieldName = 'Aprob'
        Color = clNone
        Alignment = taLeftJustify
        Subtotals = True
        Width = 80
      end
      item
        FieldName = 'Rechas'
        Color = clNone
        Alignment = taLeftJustify
        Subtotals = True
        Width = 80
      end>
    Totals = True
    ShowCubeEditor = False
    Color = clBtnFace
    GridLineWidth = 1
    GridLineColor = clWindowText
    TabOrder = 3
  end
  object degrincr: TFxGrid
    Left = 82
    Top = 80
    Width = 679
    Height = 97
    Options = [cgGridLines, cgPivotable]
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
    DecisionSource = desuincr
    Dimensions = <
      item
        FieldName = 'Planta'
        Color = clNone
        Alignment = taLeftJustify
        Subtotals = True
        Width = 80
      end
      item
        FieldName = 'atenciones'
        Color = clNone
        Alignment = taLeftJustify
        Subtotals = True
        Width = 80
      end
      item
        FieldName = 'Rechazadas'
        Color = clNone
        Alignment = taLeftJustify
        Subtotals = True
        Width = 80
      end
      item
        FieldName = 'Aprobadas'
        Color = clNone
        Alignment = taLeftJustify
        Subtotals = True
        Width = 80
      end
      item
        FieldName = 'Importe'
        Color = clNone
        Alignment = taLeftJustify
        Subtotals = True
        Width = 80
      end>
    Totals = True
    ShowCubeEditor = False
    Color = clBtnFace
    GridLineWidth = 1
    GridLineColor = clWindowText
    TabOrder = 4
  end
  object OpenDialog: TOpenDialog
    Left = 512
    Top = 176
  end
  object sdsdefe: TSQLDataSet
    CommandText = 
      'SELECT NROSUCUR||NOMBREPLANTA AS NROSUCUR, NOMBREATENCIONES AS N' +
      'OMBREATENCIONES,FEC_REVISION,sum(CANTAPROB),sum(CANTRECHAZ),SUM(' +
      'VALOR_TOTAL) FROM TTMPREPORTESEMANAL GROUP BY NROSUCUR,NOMBREPLA' +
      'NTA,COD_ATENCIONES,NOMBREATENCIONES,FEC_REVISION'
    MaxBlobSize = -1
    Params = <>
    Left = 104
    Top = 528
  end
  object dspdefe: TDataSetProvider
    DataSet = sdsdefe
    Options = [poIncFieldProps, poAllowCommandText]
    Left = 136
    Top = 528
  end
  object cdsdefe: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspdefe'
    Left = 168
    Top = 528
  end
  object decudefe: TFxCube
    DataSet = sdsdefe
    DimensionMap = <
      item
        Active = False
        Caption = 'Planta'
        FieldName = 'NROSUCUR'
        Name = 'dmNombrePlanta'
        Params = 0
        ValueCount = 1
      end
      item
        Active = False
        Caption = 'Atencion'
        FieldName = 'NOMBREATENCIONES'
        Name = 'dmAtenciones'
        Params = 0
        ValueCount = 7
      end
      item
        Active = False
        Caption = 'Fecha'
        FieldName = 'FEC_REVISION'
        Params = 0
        StartDate = 38353.000000000000000000
        ValueCount = 1
      end
      item
        Active = False
        Caption = 'Aprob'
        DimensionType = dimSum
        FieldName = 'SUM(CANTAPROB)'
        Name = 'dmCantAprob'
        Params = 0
        ValueCount = 0
      end
      item
        Active = False
        Caption = 'Rechas'
        DimensionType = dimSum
        FieldName = 'SUM(CANTRECHAZ)'
        Name = 'dmCantRechas'
        Params = 0
        ValueCount = 0
      end
      item
        Active = False
        Caption = 'Importe'
        DimensionType = dimSum
        FieldName = 'SUM(VALOR_TOTAL)'
        Name = 'dmImporte'
        Params = 0
        ValueCount = 0
      end>
    MaxDimensions = 10
    ShowProgressDialog = True
    Left = 208
    Top = 528
  end
  object desudefe: TFxSource
    ControlType = xtCheck
    DecisionCube = decudefe
    Left = 240
    Top = 528
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
  object sdsincr: TSQLDataSet
    CommandText = 
      'SELECT  NROSUCUR , NOMBREATENCIONES AS NOMBREATENCIONES,SUM(RECH' +
      'AZADAS),SUM(APROBADAS),sum(VALORTOTAL),SUM(PPIVOT) FROM RESUMEN_' +
      'REVISIONES GROUP BY NROSUCUR,COD_ATENCIONES,NOMBREATENCIONES '
    MaxBlobSize = -1
    Params = <>
    Left = 552
    Top = 528
  end
  object dspincr: TDataSetProvider
    DataSet = sdsincr
    Options = [poIncFieldProps, poAllowCommandText]
    Left = 584
    Top = 528
  end
  object cdsincr: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspincr'
    Left = 616
    Top = 528
  end
  object decuincr: TFxCube
    DataSet = cdsincr
    DimensionMap = <
      item
        Active = False
        Caption = 'Planta'
        FieldName = 'NROSUCUR'
        Name = 'dplanta'
        Params = 0
        ValueCount = 3
        Visible = False
      end
      item
        Active = False
        Caption = 'atenciones'
        FieldName = 'NOMBREATENCIONES'
        Name = 'dmaten'
        Params = 0
        ValueCount = 7
        Visible = False
      end
      item
        Active = False
        Caption = 'Rechazadas'
        DimensionType = dimSum
        FieldName = 'SUM(RECHAZADAS)'
        Name = 'dmrechazadas'
        Params = 0
        ValueCount = 0
      end
      item
        Active = False
        Caption = 'Aprobadas'
        DimensionType = dimSum
        FieldName = 'SUM(APROBADAS)'
        Name = 'dmaprob'
        Params = 0
        ValueCount = 0
      end
      item
        Active = False
        Caption = 'Importe'
        DimensionType = dimSum
        FieldName = 'SUM(VALORTOTAL)'
        Name = 'dmimporte'
        Params = 0
        ValueCount = 0
      end>
    MaxDimensions = 15
    MaxSummaries = 15
    ShowProgressDialog = True
    Left = 656
    Top = 528
  end
  object desuincr: TFxSource
    ControlType = xtCheck
    DecisionCube = decuincr
    Left = 688
    Top = 528
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
end
