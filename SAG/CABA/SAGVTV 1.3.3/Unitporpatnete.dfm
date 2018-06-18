object descargar_por_patente: Tdescargar_por_patente
  Left = 192
  Top = 152
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Descargar por Patentes'
  ClientHeight = 171
  ClientWidth = 334
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
    Left = 8
    Top = 8
    Width = 313
    Height = 145
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 43
      Height = 14
      Caption = 'PATENTE'
    end
    object Label2: TLabel
      Left = 168
      Top = 16
      Width = 49
      Height = 14
      Caption = 'TURNOID'
    end
    object Edit1: TEdit
      Left = 16
      Top = 32
      Width = 145
      Height = 31
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 168
      Top = 32
      Width = 121
      Height = 31
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object BitBtn1: TBitBtn
      Left = 24
      Top = 96
      Width = 75
      Height = 25
      Caption = 'Descargar'
      TabOrder = 2
    end
    object BitBtn2: TBitBtn
      Left = 224
      Top = 96
      Width = 75
      Height = 25
      Caption = 'Salir'
      TabOrder = 3
      OnClick = BitBtn2Click
    end
  end
end
