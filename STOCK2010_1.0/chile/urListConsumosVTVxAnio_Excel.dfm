object ListaConsumosVTVxAnio_Excel: TListaConsumosVTVxAnio_Excel
  Left = 14
  Top = 106
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Consumos VTV x A'#241'o'
  ClientHeight = 406
  ClientWidth = 506
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
    Width = 505
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
        FieldName = 'Planta'
        Title.Alignment = taCenter
        Title.Caption = 'PLANTA'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 83
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Taller'
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
        FieldName = 'anio'
        Title.Alignment = taCenter
        Title.Caption = 'A'#241'o'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Consumidas'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 67
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Anuladas'
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
        FieldName = 'Inutilizadas'
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
        FieldName = 'Total'
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
    Left = 280
    Top = 368
  end
  object dspconsulta: TDataSetProvider
    DataSet = SQLQuery1
    Left = 344
    Top = 368
  end
  object sdsconsulta: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    ParamCheck = False
    Params = <>
    Left = 312
    Top = 368
  end
  object ExcelApplication1: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 408
    Top = 368
  end
  object ExcelWorkbook1: TExcelWorkbook
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 440
    Top = 368
  end
  object ExcelWorksheet1: TExcelWorksheet
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 472
    Top = 368
  end
  object RxMemoryData1: TRxMemoryData
    FieldDefs = <
      item
        Name = 'Planta'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'A'#241'o'
        DataType = ftInteger
      end
      item
        Name = 'Consumidas'
        DataType = ftInteger
      end
      item
        Name = 'Anuladas'
        DataType = ftInteger
      end
      item
        Name = 'Inutilizadas'
        DataType = ftInteger
      end
      item
        Name = 'Total'
        DataType = ftInteger
      end>
    Left = 376
    Top = 368
    object RxMemoryData1Planta: TStringField
      Alignment = taCenter
      FieldName = 'Planta'
      LookupDataSet = consulta
    end
    object RxMemoryData1Taller: TIntegerField
      Alignment = taCenter
      FieldName = 'Taller'
      LookupDataSet = consulta
    end
    object RxMemoryData1anio: TIntegerField
      Alignment = taCenter
      FieldName = 'anio'
      LookupDataSet = consulta
    end
    object RxMemoryData1Consumidas: TIntegerField
      Alignment = taCenter
      FieldName = 'Consumidas'
      LookupDataSet = consulta
    end
    object RxMemoryData1Anuladas: TIntegerField
      Alignment = taCenter
      FieldName = 'Anuladas'
      LookupDataSet = consulta
    end
    object RxMemoryData1Inutilizadas: TIntegerField
      Alignment = taCenter
      FieldName = 'Inutilizadas'
      LookupDataSet = consulta
    end
    object RxMemoryData1Total: TIntegerField
      Alignment = taCenter
      FieldName = 'Total'
      LookupDataSet = consulta
    end
  end
  object DataSource1: TDataSource
    DataSet = RxMemoryData1
    Left = 248
    Top = 368
  end
  object SQLQuery1: TSQLQuery
    Params = <>
    Left = 216
    Top = 368
  end
end
