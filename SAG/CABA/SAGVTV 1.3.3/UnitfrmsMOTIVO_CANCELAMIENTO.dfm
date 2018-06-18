object frmsMOTIVO_CANCELAMIENTO: TfrmsMOTIVO_CANCELAMIENTO
  Left = 245
  Top = 144
  BorderStyle = bsSingle
  Caption = 'MOTIVO DE CANCELAMIENTO'
  ClientHeight = 107
  ClientWidth = 426
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
  object ComboBox1: TComboBox
    Left = 8
    Top = 16
    Width = 409
    Height = 31
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Calibri'
    Font.Style = []
    ItemHeight = 23
    ParentFont = False
    TabOrder = 0
    Items.Strings = (
      'CERTIFICADO ROTO'
      'CERTIFICADO MANCHADO'
      'CERTIFICADO MAL IMPRESO'
      'PROBLEMAS CON IMPRESORA'
      'CERTIFICADO  MAL PUESTO EN BANDEJA'
      'OTRO')
  end
  object BitBtn1: TBitBtn
    Left = 176
    Top = 64
    Width = 75
    Height = 25
    Caption = 'ACEPTAR'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
end
