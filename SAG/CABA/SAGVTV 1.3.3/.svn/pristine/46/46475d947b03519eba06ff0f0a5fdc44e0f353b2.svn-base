object frminformacionpago: Tfrminformacionpago
  Left = 301
  Top = 114
  Width = 936
  Height = 561
  Caption = 'Informaci'#243'n de Pagos'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 55
    Height = 19
    Caption = 'Facturas'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
  end
  object TotalNotasCredito: TLabel
    Left = 16
    Top = 48
    Width = 93
    Height = 19
    Caption = 'Notas  Credito'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 201
    Height = 65
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 80
    Width = 913
    Height = 393
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'fecha'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Fecha'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cliente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Title.Caption = 'Cliente'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 204
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'tipocomprobanteafip'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Tipo Comprobante'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nrocomprobante'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Nro Comprobante'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'dominio'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Dominio'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'idpago'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'External Reference'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 104
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'importetotal'
        Title.Alignment = taCenter
        Title.Caption = 'Importe Total'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 76
        Visible = True
      end>
  end
  object ExportarExcel: TButton
    Left = 8
    Top = 488
    Width = 113
    Height = 25
    Caption = 'Exportar a Excel'
    TabOrder = 1
    OnClick = ExportarExcelClick
  end
  object BitBtn1: TBitBtn
    Left = 128
    Top = 488
    Width = 75
    Height = 25
    Caption = 'Salir'
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object CantiadadFact: TEdit
    Left = 120
    Top = 16
    Width = 81
    Height = 21
    TabOrder = 3
    OnChange = CantiadadFactChange
  end
  object CantidadNC: TEdit
    Left = 120
    Top = 48
    Width = 81
    Height = 21
    TabOrder = 4
    OnChange = CantidadNCChange
  end
  object DataSource1: TDataSource
    DataSet = RxMemoryData1
    Left = 656
    Top = 480
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 688
    Top = 480
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = SQLDataSet1
    Left = 752
    Top = 480
  end
  object SQLDataSet1: TSQLDataSet
    Params = <>
    Left = 720
    Top = 480
  end
  object RxMemoryData1: TRxMemoryData
    FieldDefs = <>
    Left = 784
    Top = 480
    object RxMemoryData1fecha: TStringField
      FieldName = 'fecha'
    end
    object RxMemoryData1nrocomprobante: TStringField
      FieldName = 'nrocomprobante'
      Size = 25
    end
    object RxMemoryData1dominio: TStringField
      FieldName = 'dominio'
    end
    object RxMemoryData1idpago: TIntegerField
      FieldName = 'idpago'
    end
    object RxMemoryData1tipocomprobanteafip: TStringField
      FieldName = 'tipocomprobanteafip'
      Size = 4
    end
    object RxMemoryData1cliente: TStringField
      FieldName = 'cliente'
    end
    object RxMemoryData1importetotal: TIntegerField
      FieldName = 'importetotal'
    end
  end
  object ExcelApplication1: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 816
    Top = 480
  end
  object ExcelWorkbook1: TExcelWorkbook
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 848
    Top = 480
  end
  object ExcelWorksheet1: TExcelWorksheet
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 880
    Top = 480
  end
end
