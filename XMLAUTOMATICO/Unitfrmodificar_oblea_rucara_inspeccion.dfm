object frmodificar_oblea_rucara_inspeccionunit: Tfrmodificar_oblea_rucara_inspeccionunit
  Left = 247
  Top = 124
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Modificar Nro de Oblea'
  ClientHeight = 207
  ClientWidth = 480
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
  object BitBtn1: TBitBtn
    Left = 328
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 0
    Kind = bkCancel
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 457
    Height = 73
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 93
      Height = 15
      Caption = 'NRO INSPECCION'
    end
    object Label2: TLabel
      Left = 240
      Top = 16
      Width = 44
      Height = 15
      Caption = 'PATENTE'
    end
    object Label3: TLabel
      Left = 336
      Top = 16
      Width = 77
      Height = 15
      Caption = 'OBLEA ACTUAL'
    end
    object Edit1: TEdit
      Left = 8
      Top = 32
      Width = 121
      Height = 23
      TabOrder = 0
      OnKeyPress = Edit1KeyPress
    end
    object BitBtn2: TBitBtn
      Left = 136
      Top = 30
      Width = 75
      Height = 25
      Caption = 'Buscar'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object Edit2: TEdit
      Left = 240
      Top = 32
      Width = 89
      Height = 23
      Enabled = False
      TabOrder = 2
    end
    object Edit4: TEdit
      Left = 336
      Top = 32
      Width = 97
      Height = 23
      Enabled = False
      TabOrder = 3
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 88
    Width = 185
    Height = 57
    Caption = 'NRO OBLEA NUEVO'
    TabOrder = 2
    object Edit3: TEdit
      Left = 8
      Top = 24
      Width = 161
      Height = 23
      TabOrder = 0
    end
  end
  object BitBtn3: TBitBtn
    Left = 144
    Top = 160
    Width = 97
    Height = 25
    Caption = 'Modificar'
    TabOrder = 3
    OnClick = BitBtn3Click
    Kind = bkOK
  end
end
