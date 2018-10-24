object seleccione_fecha_turnos_por_plantilla: Tseleccione_fecha_turnos_por_plantilla
  Left = 374
  Top = 288
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Seleccione Fecha y Centro'
  ClientHeight = 170
  ClientWidth = 292
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
    Left = 8
    Top = 16
    Width = 74
    Height = 13
    Caption = 'Fecha desde'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 112
    Top = 16
    Width = 71
    Height = 13
    Caption = 'Fecha hasta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 72
    Width = 38
    Height = 13
    Caption = 'Centro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DateTimePicker1: TDateTimePicker
    Left = 8
    Top = 32
    Width = 97
    Height = 21
    Date = 41228.688251875000000000
    Time = 41228.688251875000000000
    TabOrder = 0
  end
  object DateTimePicker2: TDateTimePicker
    Left = 120
    Top = 32
    Width = 97
    Height = 21
    Date = 41228.688251875000000000
    Time = 41228.688251875000000000
    TabOrder = 1
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 88
    Width = 265
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
  end
  object BitBtn1: TBitBtn
    Left = 48
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = BitBtn1Click
  end
  object Button1: TButton
    Left = 192
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Salir'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = Button1Click
  end
  object RxMemoryData1: TRxMemoryData
    FieldDefs = <>
    Left = 248
    Top = 32
    object RxMemoryData1centro: TStringField
      FieldName = 'centro'
      Size = 10
    end
    object RxMemoryData1nombre: TStringField
      FieldName = 'nombre'
    end
    object RxMemoryData1asginado: TStringField
      FieldName = 'asginado'
    end
    object RxMemoryData1reservado: TStringField
      FieldName = 'reservado'
    end
  end
end
