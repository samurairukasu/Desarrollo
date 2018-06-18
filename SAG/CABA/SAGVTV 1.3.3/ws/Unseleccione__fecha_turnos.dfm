object seleccione__fecha_turnos: Tseleccione__fecha_turnos
  Left = 405
  Top = 216
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Fecha'
  ClientHeight = 111
  ClientWidth = 201
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
  object DateTimePicker1: TDateTimePicker
    Left = 8
    Top = 16
    Width = 186
    Height = 23
    Date = 42520.665479479170000000
    Time = 42520.665479479170000000
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 120
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Salir'
    TabOrder = 2
    OnClick = BitBtn2Click
  end
end
