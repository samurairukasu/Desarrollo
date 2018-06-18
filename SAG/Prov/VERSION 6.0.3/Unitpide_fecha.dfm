object pide_fecha: Tpide_fecha
  Left = 245
  Top = 116
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Fechas'
  ClientHeight = 107
  ClientWidth = 264
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Calibri'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 33
    Height = 15
    Caption = 'Desde'
  end
  object Label2: TLabel
    Left = 144
    Top = 8
    Width = 32
    Height = 15
    Caption = 'Hasta'
  end
  object DateTimePicker1: TDateTimePicker
    Left = 16
    Top = 24
    Width = 105
    Height = 23
    Date = 42213.655396215280000000
    Time = 42213.655396215280000000
    TabOrder = 0
  end
  object DateTimePicker2: TDateTimePicker
    Left = 144
    Top = 24
    Width = 105
    Height = 23
    Date = 42213.655475277780000000
    Time = 42213.655475277780000000
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 168
    Top = 64
    Width = 81
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 2
    OnClick = BitBtn1Click
    Kind = bkCancel
  end
  object BitBtn2: TBitBtn
    Left = 24
    Top = 64
    Width = 81
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 3
    OnClick = BitBtn2Click
    Kind = bkOK
  end
end
