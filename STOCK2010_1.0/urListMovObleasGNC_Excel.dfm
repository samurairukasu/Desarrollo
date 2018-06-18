object ListaMovObleasGNCGlobal_Excel: TListaMovObleasGNCGlobal_Excel
  Left = 500
  Top = 145
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Movimiento Obleas Global'
  ClientHeight = 418
  ClientWidth = 626
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
  object Exportar: TButton
    Left = 8
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Exportar'
    TabOrder = 0
    OnClick = ExportarClick
  end
  object Planilla: TDBGrid
    Left = 0
    Top = 0
    Width = 625
    Height = 377
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'FECHA'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
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
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 69
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMPLANTA'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
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
        FieldName = 'CODTALLER'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
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
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
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
        FieldName = 'ANIO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'A'#209'O'
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
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
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
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end>
  end
  object Salir: TButton
    Left = 88
    Top = 384
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
    Left = 400
    Top = 384
  end
  object dspconsulta: TDataSetProvider
    DataSet = SQLQuery1
    Left = 464
    Top = 384
  end
  object sdsconsulta: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    ParamCheck = False
    Params = <>
    Left = 432
    Top = 384
  end
  object ExcelApplication1: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 528
    Top = 384
  end
  object ExcelWorkbook1: TExcelWorkbook
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 560
    Top = 384
  end
  object ExcelWorksheet1: TExcelWorksheet
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 592
    Top = 384
  end
  object RxMemoryData1: TRxMemoryData
    FieldDefs = <
      item
        Name = 'RxMemoryData1Fecha'
      end
      item
        Name = 'RxMemoryData1IDMovimiento'
      end
      item
        Name = 'RxMemoryData1NomPlanta'
      end
      item
        Name = 'RxMemoryData1CodTaller'
      end
      item
        Name = 'RxMemoryData1Cantidad'
      end
      item
        Name = 'RxMemoryData1Anio'
      end
      item
        Name = 'RxMemoryData1ObleaInic'
      end
      item
        Name = 'RxMemoryData1ObleaFin'
      end>
    Left = 496
    Top = 384
    object RxMemoryData1FECHA: TDateField
      Alignment = taCenter
      FieldName = 'FECHA'
    end
    object RxMemoryData1IDMovimiento: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'ID MOVIMIENTO'
      FieldName = 'IDMOVIMIENTO'
      LookupDataSet = consulta
    end
    object RxMemoryData1NomPlanta: TStringField
      Alignment = taCenter
      DisplayLabel = 'NOMBRE PLANTA'
      FieldName = 'NOMPLANTA'
      LookupDataSet = consulta
    end
    object RxMemoryData1CodTaller: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'COD. TALLER'
      FieldName = 'CODTALLER'
      LookupDataSet = consulta
    end
    object RxMemoryData1Cantidad: TIntegerField
      Alignment = taCenter
      FieldName = 'CANTIDAD'
      LookupDataSet = consulta
    end
    object RxMemoryData1Anio: TIntegerField
      Alignment = taCenter
      FieldName = 'ANIO'
      LookupDataSet = consulta
    end
    object RxMemoryData1ObleaInic: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'OBLEA INICIAL'
      FieldName = 'OBLEAINIC'
      LookupDataSet = consulta
    end
    object RxMemoryData1ObleaFin: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'OBLEA FIN'
      FieldName = 'OBLEAFIN'
      LookupDataSet = consulta
    end
  end
  object DataSource1: TDataSource
    DataSet = RxMemoryData1
    Left = 368
    Top = 384
  end
  object SQLQuery1: TSQLQuery
    Params = <>
    Left = 336
    Top = 384
  end
end
