object reimprimir_factura: Treimprimir_factura
  Left = 316
  Top = 127
  BorderStyle = bsSingle
  Caption = 'Reimprimir Facturas'
  ClientHeight = 465
  ClientWidth = 720
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 720
    Height = 65
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 43
      Height = 14
      Caption = 'PATENTE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 8
      Top = 24
      Width = 201
      Height = 34
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object BitBtn1: TBitBtn
      Left = 216
      Top = 23
      Width = 75
      Height = 33
      Caption = 'Buscar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn1Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 3
    Top = 64
    Width = 713
    Height = 345
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
        FieldName = 'fecha'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'FECHA FACTURA'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'idturno'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'TURNOID'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'tipocomprobante'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'TIPO COMPROBANTE'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 143
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'nrocomprobante'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'NRO COMPROBANTE'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 186
        Visible = True
      end>
  end
  object BitBtn2: TBitBtn
    Left = 624
    Top = 424
    Width = 75
    Height = 25
    Caption = 'Salir'
    TabOrder = 2
    OnClick = BitBtn2Click
  end
  object BitBtn3: TBitBtn
    Left = 16
    Top = 424
    Width = 97
    Height = 25
    Caption = 'IMPRIMIR'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = BitBtn3Click
  end
  object DataSource1: TDataSource
    DataSet = RxMemoryData1
    Left = 224
    Top = 152
  end
  object SQLQuery1: TSQLQuery
    Params = <>
    Left = 408
    Top = 32
  end
  object RxMemoryData1: TRxMemoryData
    FieldDefs = <>
    Left = 336
    Top = 176
    object RxMemoryData1idturno: TIntegerField
      FieldName = 'idturno'
    end
    object RxMemoryData1fecha: TStringField
      FieldName = 'fecha'
    end
    object RxMemoryData1tipocomprobante: TStringField
      FieldName = 'tipocomprobante'
      Size = 4
    end
    object RxMemoryData1nrocomprobante: TStringField
      FieldName = 'nrocomprobante'
      Size = 15
    end
  end
end
