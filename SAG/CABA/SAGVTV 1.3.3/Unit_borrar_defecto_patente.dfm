object borrar_defecto_patente: Tborrar_defecto_patente
  Left = 353
  Top = 188
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Borrar Defecto'
  ClientHeight = 365
  ClientWidth = 535
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Calibri'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Label5: TLabel
    Left = 16
    Top = 224
    Width = 222
    Height = 29
    Caption = 'CADENA DEL DEFECTO'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -24
    Font.Name = 'Calibri'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 513
    Height = 89
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 43
      Height = 14
      Caption = 'PATENTE'
    end
    object Label2: TLabel
      Left = 200
      Top = 16
      Width = 89
      Height = 14
      Caption = 'TIPO INSPECCION'
    end
    object Edit1: TEdit
      Left = 16
      Top = 32
      Width = 177
      Height = 41
      Hint = 'INGRESE LA PATENTE DEL VEHICULO'
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object BitBtn1: TBitBtn
      Left = 416
      Top = 40
      Width = 75
      Height = 33
      Caption = 'BUSCAR'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn1Click
    end
    object ComboBox1: TComboBox
      Left = 198
      Top = 32
      Width = 201
      Height = 41
      Hint = 'SELECCIONE EL TIPO DE INSPECCION'
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Calibri'
      Font.Style = []
      ItemHeight = 33
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Items.Strings = (
        'PERIODICA'
        'REVERIFICACION')
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 96
    Width = 513
    Height = 105
    TabOrder = 1
    object Label3: TLabel
      Left = 8
      Top = 59
      Width = 52
      Height = 14
      Caption = 'VEHICULO'
    end
    object Label4: TLabel
      Left = 8
      Top = 16
      Width = 62
      Height = 14
      Caption = 'INSPECCION'
    end
    object Edit2: TEdit
      Left = 8
      Top = 75
      Width = 489
      Height = 22
      ReadOnly = True
      TabOrder = 0
    end
    object Edit3: TEdit
      Left = 8
      Top = 32
      Width = 121
      Height = 22
      ReadOnly = True
      TabOrder = 1
    end
  end
  object BitBtn2: TBitBtn
    Left = 264
    Top = 224
    Width = 129
    Height = 73
    Caption = 'BORRAR DEFECTO'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BitBtn2Click
  end
  object Edit4: TEdit
    Left = 16
    Top = 256
    Width = 225
    Height = 37
    Hint = 'INGRESE LA CADENA DEL DEFECTO A BORRAR DE LA INSPECCION'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Text = 'Edit4'
  end
  object BitBtn3: TBitBtn
    Left = 440
    Top = 320
    Width = 75
    Height = 25
    Caption = 'SALIR'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = BitBtn3Click
  end
  object sHintManager1: TsHintManager
    HintKind.Style = hsComics
    HintKind.Radius = 21
    HintKind.ExOffset = 24
    HintKind.GradientData = '16753188;16777215;99;0;0;16777215;16777215;0;0;0'
    HintKind.GradientPercent = 100
    HintKind.Bevel = 1
    HintKind.Color = 16757839
    HintKind.ColorBorderTop = 4194304
    HintKind.ColorBorderBottom = 4194304
    HintKind.Transparency = 8
    HintKind.ShadowBlur = 10
    HintKind.ShadowEnabled = True
    HintKind.ShadowOffset = 7
    HintKind.ShadowTransparency = 28
    HintKind.MarginV = 7
    HintKind.MaxWidth = 180
    HintKind.Font.Charset = ANSI_CHARSET
    HintKind.Font.Color = clBlack
    HintKind.Font.Height = -12
    HintKind.Font.Name = 'Calibri'
    HintKind.Font.Style = [fsBold]
    Predefinitions = shCustom
    SkinSection = 'HINT'
    Left = 480
    Top = 256
  end
end
