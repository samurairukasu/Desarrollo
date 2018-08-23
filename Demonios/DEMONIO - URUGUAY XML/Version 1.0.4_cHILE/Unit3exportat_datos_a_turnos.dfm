object exportat_datos_a_turnos: Texportat_datos_a_turnos
  Left = 410
  Top = 208
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Exportat Datos'
  ClientHeight = 192
  ClientWidth = 290
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 44
    Height = 19
    Caption = 'Planta'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 72
    Width = 41
    Height = 19
    Caption = 'Desde'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 152
    Top = 72
    Width = 38
    Height = 19
    Caption = 'Hasta'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 32
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 200
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Cerrar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = BitBtn2Click
  end
  object DateTimePicker1: TDateTimePicker
    Left = 16
    Top = 96
    Width = 105
    Height = 21
    Date = 43021.432046770830000000
    Time = 43021.432046770830000000
    TabOrder = 2
  end
  object DateTimePicker2: TDateTimePicker
    Left = 152
    Top = 96
    Width = 105
    Height = 21
    Date = 43021.432074236110000000
    Time = 43021.432074236110000000
    TabOrder = 3
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 16
    Top = 32
    Width = 265
    Height = 21
    KeyField = 'centro'
    ListField = 'nombre'
    ListSource = DataSource1
    TabOrder = 4
  end
  object SQLQuery1: TSQLQuery
    Params = <>
    Left = 136
  end
  object DataSource1: TDataSource
    DataSet = modulo.query_exportar1
    Left = 120
    Top = 24
  end
end
