object frmodificar_oblea_en_tvarios: Tfrmodificar_oblea_en_tvarios
  Left = 245
  Top = 123
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Modificar Nro de Oblea'
  ClientHeight = 184
  ClientWidth = 258
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Calibri'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 241
    Height = 113
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 104
      Height = 15
      Caption = 'NRO OBLEA ACTUAL'
    end
    object Label2: TLabel
      Left = 8
      Top = 64
      Width = 160
      Height = 15
      Caption = 'NUEVO NRO DE OBLEA NUEVO'
    end
    object Edit2: TEdit
      Left = 8
      Top = 80
      Width = 217
      Height = 23
      TabOrder = 0
      OnKeyPress = Edit2KeyPress
    end
    object Edit1: TEdit
      Left = 8
      Top = 32
      Width = 225
      Height = 23
      Enabled = False
      TabOrder = 1
      Text = 'Edit1'
    end
  end
  object BitBtn1: TBitBtn
    Left = 168
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 1
    Kind = bkCancel
  end
  object BitBtn2: TBitBtn
    Left = 24
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 2
    OnClick = BitBtn2Click
    Kind = bkOK
  end
end