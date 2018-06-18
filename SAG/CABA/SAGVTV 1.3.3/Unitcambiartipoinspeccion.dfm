object cambiartipoinspeccion: Tcambiartipoinspeccion
  Left = 193
  Top = 272
  BorderStyle = bsSingle
  Caption = 'Cambiar Tipo Inspecci'#243'n'
  ClientHeight = 268
  ClientWidth = 456
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PrintScale = poPrintToFit
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 0
    Width = 425
    Height = 177
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
      Left = 200
      Top = 104
      Width = 159
      Height = 15
      Caption = 'TIPO INSPECCION A CAMBIAR'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 16
      Top = 104
      Width = 117
      Height = 13
      Caption = 'TIPO INSPECCION ACTUAL'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 16
      Top = 32
      Width = 121
      Height = 34
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 176
      Top = 32
      Width = 233
      Height = 34
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object ComboBox1: TComboBox
      Left = 200
      Top = 120
      Width = 177
      Height = 34
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Calibri'
      Font.Style = []
      ItemHeight = 26
      ParentFont = False
      TabOrder = 2
      Items.Strings = (
        'PERIODICA'
        'REVERIFICACION')
    end
    object Edit3: TEdit
      Left = 16
      Top = 120
      Width = 137
      Height = 34
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = 'Edit3'
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
    Caption = 'CAMBIAR'
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
