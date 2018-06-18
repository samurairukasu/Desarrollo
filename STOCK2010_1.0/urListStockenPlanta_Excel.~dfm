object ListaStockEnPlanta_Excel: TListaStockEnPlanta_Excel
  Left = 639
  Top = 137
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'ListaStockEnPlanta_Excel'
  ClientHeight = 399
  ClientWidth = 367
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Planilla: TDBGrid
    Left = 0
    Top = 0
    Width = 361
    Height = 361
    DataSource = DataSource1
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Calibri'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ANIO'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IDMOVIMIENTO'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CANTIDAD'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OBLEAFIN'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OBLEAINIC'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end>
  end
  object Exportar: TButton
    Left = 8
    Top = 368
    Width = 75
    Height = 25
    Caption = 'Exportar'
    TabOrder = 1
    OnClick = ExportarClick
  end
  object Salir: TButton
    Left = 88
    Top = 368
    Width = 75
    Height = 25
    Caption = 'Salir'
    TabOrder = 2
    OnClick = SalirClick
  end
  object consulta: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspconsulta'
    Left = 136
    Top = 328
  end
  object dspconsulta: TDataSetProvider
    DataSet = SQLQuery1
    Left = 200
    Top = 328
  end
  object sdsconsulta: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    ParamCheck = False
    Params = <>
    Left = 168
    Top = 328
  end
  object ExcelApplication1: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 264
    Top = 328
  end
  object ExcelWorkbook1: TExcelWorkbook
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 296
    Top = 328
  end
  object ExcelWorksheet1: TExcelWorksheet
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 328
    Top = 328
  end
  object RxMemoryData1: TRxMemoryData
    FieldDefs = <
      item
        Name = 'RxMemoryData1ANIO'
      end
      item
        Name = 'RxMemoryData1IDMOVIMIENTO'
      end
      item
        Name = 'RxMemoryData1CANTIDAD'
      end
      item
        Name = 'RxMemoryData1OBLEAINIC'
      end
      item
        Name = 'RxMemoryData1OBLEAFIN'
      end>
    Left = 232
    Top = 328
    object RxMemoryData1ANIO: TIntegerField
      Alignment = taCenter
      FieldName = 'ANIO'
      LookupDataSet = consulta
    end
    object RxMemoryData1IDMOVIMIENTO: TIntegerField
      Alignment = taCenter
      FieldName = 'IDMOVIMIENTO'
      LookupDataSet = consulta
    end
    object RxMemoryData1CANTIDAD: TIntegerField
      Alignment = taCenter
      FieldName = 'CANTIDAD'
      LookupDataSet = consulta
    end
    object RxMemoryData1OBLEAINIC: TIntegerField
      Alignment = taCenter
      FieldName = 'OBLEAINIC'
      LookupDataSet = consulta
    end
    object RxMemoryData1OBLEAFIN: TIntegerField
      Alignment = taCenter
      FieldName = 'OBLEAFIN'
      LookupDataSet = consulta
    end
  end
  object DataSource1: TDataSource
    DataSet = RxMemoryData1
    Left = 104
    Top = 328
  end
  object SQLQuery1: TSQLQuery
    Params = <>
    Left = 72
    Top = 328
  end
end
