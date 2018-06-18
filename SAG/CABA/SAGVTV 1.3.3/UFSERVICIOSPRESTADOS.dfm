object FServiciosPrestados: TFServiciosPrestados
  Left = 248
  Top = 111
  Width = 1159
  Height = 603
  Caption = 'Servicios Prestados'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBServiciosPrestados: TRxDBGrid
    Tag = 2
    Left = 0
    Top = 46
    Width = 1143
    Height = 519
    Align = alClient
    Color = 12123386
    Ctl3D = True
    DataSource = DSTServiciosPrestados
    FixedColor = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    FixedCols = 1
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'FECHA_FACTURA'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'COD_FACTURA'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'PAGOID'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODIGOPAGO'
        Title.Caption = 'CODIGO PAGO'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'FORMA_PAGO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ENTIDAD'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TIPO_FACTURA'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'NRO_COMPROBANTE'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CLIENTE'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IMPORTE_NETO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IVA'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IIBB'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TOTAL'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ANULADA'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ARCHIVOENVIADO'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'FECHA_TURNO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TURNO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'PATENTE'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TIPO_VEHICULO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'VERIFICO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'FECHA_INSPECCION'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'INSPECCION'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end>
  end
  object SBarPrincipal: TSpeedBar
    Left = 0
    Top = 0
    Width = 1143
    Height = 46
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    BoundLines = [blLeft, blRight]
    Options = [sbAllowDrag, sbAllowResize, sbFlatBtns, sbGrayedBtns, sbStretchBitmap]
    BtnOffsetHorz = 3
    BtnOffsetVert = 3
    BtnWidth = 40
    BtnHeight = 40
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Locked = True
    TabOrder = 1
    InternalVer = 1
    object SpeedbarSection1: TSpeedbarSection
      Caption = 'Salidas'
    end
    object SpeedbarSection2: TSpeedbarSection
      Caption = 'Busqueda'
    end
    object SpeedbarSection3: TSpeedbarSection
      Caption = 'Exit'
    end
    object BExcel: TSpeedItem
      Caption = 'Excel'
      Glyph.Data = {
        F6020000424DF602000000000000760000002800000023000000200000000100
        0400000000008002000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFF00000FFF800000000000000000000FFFFFFFFFFF0
        0000FFF8FFFFFFFFFFFFFFFFFFF0FFFFFFFFFFF00000FFF8F777777777777777
        7770FFFFFFFFFFF00000FFF8FFFFFFFFFF8000000000000000000FF00000FFF8
        F777777FFF8FFFF7FFFFFFFFFFFF0FF00000FFF8F7FFFF7F778F77F7F77F777F
        777F0FF00000FFF8F7FF7F7FFF8FFFF7FFFFFFFFFFFF0FF00000FFF8F7FFFF7F
        778F77F7F77F777F777F0FF00000FFF8F777777FFF8FFFF7FFFFFFFFFFFF0FF0
        0000FFF8FFFFFFFFFF8F77F7F77F777F777F0FF00000FFF8FFF80000008FFFF7
        FFFFFFFFFFFF0FF00000FFFCCCC8FFFFFF8F77F7F77F777F777F0FF00000FFFC
        7CC8FFFFFF8FFFF7FFFFFFFFFFFF0FF00000FFFCCCC8F77777CCCCCCCCCCCCCC
        CCCCCFF00000FFFFFFF8FFFFFFC7CCCCCCCCCCCCC777CFF00000FFFFFFF8F777
        77CCCCCCCCCCCCCCCCCCCFF00000FFFFFFF8FFFFFFFFFFFFFFFFFFF0FFFFFFF0
        0000FFFFFFF8F77777F77777F77777F0FFFFFFF00000FFFFFFF8FFFFFF00000F
        FFFFFFF0FFFFFFF00000FFF0000000000066660FF77777F0FFFFFFF00000FFF0
        8888888806EEF0FFFFFFFFF0FFFFFFF00000FFFF0E6666606EEF077FF77777F0
        FFFFFFF00000FFFFF0E66606EEF060FFFFFFFFF0FFFFFFF00000FFFFFF0E606E
        EF0000FFF77777F0FFFFFFF00000FFFFFFF006EEF0FFFFFFFFFFFFF0FFFFFFF0
        0000FFFFFFF06EEF00CCCCCCCCCCCCCCFFFFFFF00000FFFFFF06EEF0680CCCCC
        CCCC777CFFFFFFF00000FFFFF06EEF0E6680CCCCCCCCCCCCFFFFFFF00000FFFF
        06EEF0F0E6680FFFFFFFFFFFFFFFFFF00000FFF0FFFF0FFF0EEEE0FFFFFFFFFF
        FFFFFFF00000FFF00000FFFFF00000FFFFFFFFFFFFFFFFF00000}
      Hint = 'Excel|'
      Layout = blGlyphLeft
      Spacing = 1
      Left = 83
      Top = 3
      Visible = True
      OnClick = BExcelClick
      SectionName = 'Salidas'
    end
    object SBBusqueda: TSpeedItem
      Tag = 3
      Caption = 'Buscar'
      Glyph.Data = {
        32030000424D3203000000000000760000002800000022000000230000000100
        040000000000BC02000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF000000FF000000000000000000000000000FFFFF00
        0000F8888888888888888888884EEC0880FFFF000000F8F88888888888888888
        84EEEC08880FFF000000F8F777777777777777774EEECC088880FF000000F8F7
        2227777777777774EEECC07888880F000000F8F7A22777777777774EEECC0078
        88880F000000F8F7AA277777777774EEECC0887888880F000000F8F777777777
        77774EEECC07777888880F000000F8FFFFFFFFFFFFF4EEECC0FFFFFF88880F00
        0000FF8888888888884EEECC0888888888880F000000FFFF000000000000ECC0
        0000000888880F000000FFFF8800000088F70C088888888088880F000000FFFF
        0077777700788077777777880888FF000000FFF87777777777080FFFFFFFF788
        80FFFF000000FF8777778787877044444444F78880FFFF000000FF8777787878
        78704C4C4C44F78880FFFF000000F87F77778787878704C4C4C4F78880FFFF00
        0000F87F7778787878770CCC4C44F78880FFFF000000F87F7777878787870CCC
        C4C4F78880FFFF000000F87F77787878787706CCCC44F78880FFFF000000F87F
        7777878787870C6CC4C4F78880FFFF000000FF8777787878787086CCCC44F788
        80FFFF000000FF877777878787708C6CC4C4F78880FFFF000000FFF877787878
        7708C6CCCC44F78880FFFF000000FFFF88777777006C6CCCC4C4F78880FFFF00
        0000FFFF8F888884444444444444F78880FFFF000000FFFF8F77777777777777
        7777778880FFFF000000FFFF8F777777777777777777778880FFFF000000FFFF
        F8FFFFFFFFFFFFFFFFFFFF8880FFFF000000FFFFFF8777777777777777777778
        80FFFF000000FFFFFFF87777777777777777777780FFFF000000FFFFFFFF8888
        88888888888888888FFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000}
      Hint = 'Buscar'
      Spacing = 1
      Left = 219
      Top = 3
      Visible = True
      OnClick = SBBusquedaClick
      SectionName = 'Busqueda'
    end
    object SBSalir: TSpeedItem
      Caption = 'Salir'
      Glyph.Data = {
        76020000424D7602000000000000760000002800000020000000200000000100
        0400000000000002000000000000000000001000000010000000000000000000
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
      Hint = 'Salir de la Ventana'
      Spacing = 1
      Left = 739
      Top = 3
      Visible = True
      OnClick = SBSalirClick
      SectionName = 'Exit'
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'Archivos Excel (*.xls)|*.xls|Todos los archivos|*.*'
    Left = 8
    Top = 488
  end
  object DSTServiciosPrestados: TDataSource
    DataSet = QTServiciosPrestados
    Left = 169
    Top = 488
  end
  object QTServiciosPrestados: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQTServiciosPrestados'
    Left = 48
    Top = 488
  end
  object dspQTServiciosPrestados: TDataSetProvider
    DataSet = sdsQTServiciosPrestados
    Options = [poIncFieldProps, poAllowCommandText]
    Left = 88
    Top = 488
  end
  object sdsQTServiciosPrestados: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 'SELECT * FROM TTMPREPORTEADM ORDER BY FECHA_FACTURA'
    ParamCheck = False
    Params = <>
    Left = 128
    Top = 488
  end
  object SQLQuery1: TSQLQuery
    Params = <>
    Left = 208
    Top = 488
  end
  object SQLConnection1: TSQLConnection
    Left = 248
    Top = 488
  end
end
