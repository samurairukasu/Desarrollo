object sincronizacion_cf: Tsincronizacion_cf
  Left = 255
  Top = 245
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Sincronizaci'#243'n'
  ClientHeight = 108
  ClientWidth = 442
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
    Left = 8
    Top = 16
    Width = 421
    Height = 13
    Caption = 
      'Usted puede realizar una sincronziaci'#243'n para reparar el Controla' +
      'dor Fiscal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 16
    Top = 64
    Width = 129
    Height = 25
    Caption = 'Sincronizaci'#243'n'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 344
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BitBtn2Click
  end
  object DriverFiscal1: TDriverFiscal
    Left = 104
    Top = -64
    Width = 192
    Height = 192
    TabOrder = 2
    Visible = False
    ControlData = {00030000D8130000D8130000}
  end
end
