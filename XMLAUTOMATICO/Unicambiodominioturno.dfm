object cambiodominioturno: Tcambiodominioturno
  Left = 722
  Top = 93
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cambio de Dominio de Turno'
  ClientHeight = 275
  ClientWidth = 453
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Calibri'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 14
  object GroupBox1: TGroupBox
    Left = 16
    Top = 8
    Width = 425
    Height = 193
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 53
      Height = 15
      Caption = 'ID TURNO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 176
      Top = 16
      Width = 92
      Height = 15
      Caption = 'PATENTE ACTUAL'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 112
      Width = 87
      Height = 15
      Caption = 'PATENTE NUEVA'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 16
      Top = 32
      Width = 121
      Height = 22
      Enabled = False
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 176
      Top = 32
      Width = 233
      Height = 34
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object Edit3: TEdit
      Left = 16
      Top = 128
      Width = 225
      Height = 37
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object BitBtn1: TBitBtn
    Left = 352
    Top = 224
    Width = 75
    Height = 25
    Caption = 'CANCELAR'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 32
    Top = 224
    Width = 121
    Height = 25
    Caption = 'CAMBIAR DOMINIO'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BitBtn2Click
  end
end
