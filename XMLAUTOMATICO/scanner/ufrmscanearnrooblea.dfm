object frmscanearnrooblea: Tfrmscanearnrooblea
  Left = 338
  Top = 152
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 182
  ClientWidth = 356
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 104
    Width = 214
    Height = 15
    Caption = 'PRESIONAR  CTRL + C PARA CONTINUAR'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 356
    Height = 41
    Align = alTop
    Color = clOlive
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 202
      Height = 19
      Caption = 'SCANEAR NUMERO DE OBLEA'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
  end
  object Edit1: TEdit
    Left = 8
    Top = 48
    Width = 337
    Height = 44
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = '2016210000100253691'
    OnKeyPress = Edit1KeyPress
  end
  object BitBtn1: TBitBtn
    Left = 128
    Top = 128
    Width = 97
    Height = 33
    Caption = 'Confirmar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object Edit2: TEdit
    Left = 8
    Top = 128
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'Edit2'
    Visible = False
  end
  object BitBtn2: TBitBtn
    Left = 272
    Top = 128
    Width = 75
    Height = 33
    Caption = 'Cancelar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = BitBtn2Click
  end
end
