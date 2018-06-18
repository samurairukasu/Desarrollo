object frmPlanillaSemanal: TfrmPlanillaSemanal
  Left = 0
  Top = 67
  Width = 1024
  Height = 671
  VertScrollBar.Position = 106
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'frmPlanillaSemanal'
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
    Left = -96
    Top = 484
    Width = 1009
    Height = 155
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 204
    Top = 324
    Width = 90
    Height = 13
    Caption = 'D'#237'as Transcurridos'
  end
  object Label2: TLabel
    Left = 204
    Top = 348
    Width = 73
    Height = 13
    Caption = 'D'#237'as que faltan'
  end
  object Label3: TLabel
    Left = 204
    Top = 372
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
    Top = 324
    Width = 96
    Height = 13
    Caption = 'Acum Semanas Ant.'
  end
  object Label5: TLabel
    Left = 428
    Top = 348
    Width = 50
    Height = 13
    Caption = 'Acum Mes'
  end
  object Label6: TLabel
    Left = 428
    Top = 396
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
    Top = 420
    Width = 63
    Height = 13
    Caption = 'Media Reves'
  end
  object Label8: TLabel
    Left = 204
    Top = 396
    Width = 80
    Height = 13
    Caption = 'Media diaria total'
  end
  object Label9: TLabel
    Left = 428
    Top = 420
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
  object Label10: TLabel
    Left = 204
    Top = 444
    Width = 76
    Height = 13
    Caption = 'Media en Pesos'
  end
  object Label11: TLabel
    Left = 428
    Top = 444
    Width = 85
    Height = 13
    Caption = 'Previsto en Pesos'
  end
  object Label12: TLabel
    Left = 428
    Top = 372
    Width = 74
    Height = 13
    Caption = 'Acum en Pesos'
  end
  object Panel1: TPanel
    Left = 0
    Top = -106
    Width = 1009
    Height = 47
    Align = alTop
    TabOrder = 0
    object FxPivot3: TFxPivot
      Left = 728
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
    Left = 917
    Top = -58
    Width = 91
    Height = 19
    Caption = 'Acumulados'
    TabOrder = 1
  end
  object edDiasTranscurridos: TEdit
    Left = 300
    Top = 320
    Width = 65
    Height = 21
    TabOrder = 2
  end
  object edDiasFaltan: TEdit
    Left = 300
    Top = 344
    Width = 65
    Height = 21
    TabOrder = 3
  end
  object edMediaDiaria: TEdit
    Left = 300
    Top = 368
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
    Top = 320
    Width = 65
    Height = 21
    TabOrder = 5
  end
  object edAcumMensual: TEdit
    Left = 540
    Top = 344
    Width = 65
    Height = 21
    TabOrder = 6
  end
  object edPrevisto: TEdit
    Left = 540
    Top = 392
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
    Top = 480
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
    Top = 480
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
    Top = 320
    Width = 65
    Height = 21
    TabOrder = 10
  end
  object edAcumMensualT: TEdit
    Left = 612
    Top = 344
    Width = 65
    Height = 21
    TabOrder = 11
  end
  object edPrevistoT: TEdit
    Left = 612
    Top = 392
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
    Top = 392
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
    Top = 416
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
    Top = 344
    Width = 65
    Height = 21
    TabOrder = 15
  end
  object edPrimAnoAnterior: TEdit
    Left = 540
    Top = 416
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
    Top = 416
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
  object degriverific: TFxGrid
    Left = 0
    Top = -58
    Width = 721
    Height = 369
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
    TabOrder = 18
  end
  object FxPivot1: TFxPivot
    Left = 8
    Top = -106
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
    TabOrder = 19
  end
  object degriacum: TFxGrid
    Left = 728
    Top = -42
    Width = 281
    Height = 353
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
    DecisionSource = desuacum
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
    TabOrder = 20
  end
  object edMediaDiariaPesos: TEdit
    Left = 300
    Top = 440
    Width = 85
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 21
  end
  object edPrevistoPesos: TEdit
    Left = 540
    Top = 440
    Width = 141
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 22
  end
  object edAcumMensualenPesos: TEdit
    Left = 540
    Top = 368
    Width = 65
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 23
  end
  object OpenDialog: TOpenDialog
    Left = 760
    Top = 448
  end
  object sdsverif: TSQLDataSet
    CommandText = 
      'SELECT ZONA, PLANTA, FECHA, SUM( CANTINSP ), SUM( CANTTOTAL ), S' +
      'UM( PPIVOT ) FROM INFORME_INSPVTV GROUP BY ZONA, PLANTA, FECHA'
    MaxBlobSize = -1
    Params = <>
    Left = 104
    Top = 600
  end
  object cdsverifc: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dsdverific'
    Left = 168
    Top = 600
  end
  object dsdverific: TDataSetProvider
    DataSet = sdsverif
    Options = [poIncFieldProps, poAllowCommandText]
    Left = 136
    Top = 600
  end
  object decuverific: TFxCube
    DataSet = sdsverif
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
    Top = 600
  end
  object desuverific: TFxSource
    ControlType = xtCheck
    DecisionCube = decuverific
    Left = 240
    Top = 600
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
    DecisionCube = decuacum
    Left = 704
    Top = 600
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
    Left = 632
    Top = 600
  end
  object dspacum: TDataSetProvider
    DataSet = sdsacum
    Options = [poIncFieldProps, poAllowCommandText]
    Left = 600
    Top = 600
  end
  object sdsacum: TSQLDataSet
    CommandText = 
      'SELECT ZONA, PLANTA, SUM( RECHAZADAS ), SUM( APTAS ), SUM( PPIVO' +
      'T ) FROM RESUMEN_INSPVTV GROUP BY ZONA, PLANTA'
    MaxBlobSize = -1
    Params = <>
    Left = 568
    Top = 600
  end
  object decuacum: TFxCube
    DataSet = cdsacum
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
    Left = 672
    Top = 600
  end
end
