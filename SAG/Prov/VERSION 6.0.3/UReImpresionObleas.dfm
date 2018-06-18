object FrmReImpresionObleas: TFrmReImpresionObleas
  Left = 545
  Top = 264
  BorderStyle = bsSingle
  Caption = 'Reimpresion de Informes de Obleas'
  ClientHeight = 135
  ClientWidth = 149
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 149
    Height = 135
    Align = alClient
  end
  object RBAnuladas: TRadioButton
    Left = 11
    Top = 12
    Width = 132
    Height = 17
    Caption = 'Obleas Anuladas'
    Checked = True
    TabOrder = 0
    TabStop = True
  end
  object RBInutiliz: TRadioButton
    Left = 11
    Top = 36
    Width = 132
    Height = 17
    Caption = 'Obleas Inutilizadas'
    TabOrder = 1
  end
  object BitBtn2: TBitBtn
    Left = 12
    Top = 71
    Width = 124
    Height = 25
    Caption = 'Todas las Plantas'
    TabOrder = 2
    OnClick = BitBtn2Click
  end
  object BitBtn3: TBitBtn
    Left = 12
    Top = 99
    Width = 124
    Height = 25
    Caption = 'Salir'
    TabOrder = 3
    OnClick = BitBtn3Click
  end
end
