object borrar_turno: Tborrar_turno
  Left = 192
  Top = 114
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Borrar Turnos'
  ClientHeight = 190
  ClientWidth = 308
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 289
    Height = 126
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 78
      Height = 13
      Caption = 'Ingresar Patente'
    end
    object Label2: TLabel
      Left = 8
      Top = 80
      Width = 138
      Height = 13
      Caption = 'Seleccione la fecha del turno'
    end
    object Edit1: TEdit
      Left = 8
      Top = 32
      Width = 273
      Height = 37
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'EDIT1'
    end
    object DateTimePicker1: TDateTimePicker
      Left = 8
      Top = 96
      Width = 186
      Height = 21
      Date = 41184.612858020830000000
      Time = 41184.612858020830000000
      TabOrder = 1
    end
  end
  object BitBtn1: TBitBtn
    Left = 56
    Top = 152
    Width = 105
    Height = 25
    Caption = 'Aceptar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 200
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BitBtn2Click
  end
end
