object cambio_de_pantentes: Tcambio_de_pantentes
  Left = 483
  Top = 247
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cambios de Patentes'
  ClientHeight = 285
  ClientWidth = 294
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
  object SpeedButton1: TSpeedButton
    Left = 72
    Top = 232
    Width = 153
    Height = 33
    Caption = 'Aplicar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000000000000000000000000000000000000000FF0000FF
      0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
      FF0000FF0000FF0000FF0000FF84B684086D0810751018751818751818791810
      7910107D10087D08087D08007D000079000071007BB27B0000FF0000FF108210
      188E18299229299229299629299629299A29219E2118A21810A61008A608009E
      00009200006D000000FF0000FF188E18299629319E31399E39399E3939A239A5
      D7A5FFFFFF21AE2118B21810B21008AE08009E000079000000FF0000FF219221
      399E3942A2424AA64A42A64242A642FFFFFFFFFFFFFFFFFF21B62118B61808B2
      0808A208007D000000FF0000FF29962942A2424AA64A4AA64A4AA64A42A64242
      AA42FFFFFFFFFFFFFFFFFF18B21810AE1008A2080882080000FF0000FF319A31
      4AA64A52AA5252AA524AAA4A4AA64A42AA4239AA39FFFFFFFFFFFFFFFFFF18AE
      1818A2181082100000FF0000FF399E3952AA52FFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF189E181882180000FF0000FF42A242
      5AAE5AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FF219A21187D180000FF0000FF4AA64A63B26363AE635AAA5A52A6524AA24A39
      9E39319E31FFFFFFFFFFFFFFFFFF219A21299629217D210000FF0000FF52AA52
      6BB66B6BB66B5AAE5A52AA524AA24A429E42FFFFFFFFFFFFFFFFFF299629299A
      29299629217D210000FF0000FF5AAE5A7BBE7B73BA7363B2635AAA5A52A652FF
      FFFFFFFFFFFFFFFF319A31319A31319A31299629217D210000FF0000FF6BB66B
      8CC78C84C3846BB66B63B26363AE63B5DBB5FFFFFF4AA64A4AA64A42A242399E
      393196311879180000FF0000FF73BA739CCF9C8CC78C7BBE7B73BA736BB66B63
      B26363B2635AAE5A52AA524AA64A42A2422996291875180000FF0000FFB5DBB5
      73BA7363B2635AAE5A52AA524AA64A4AA64A4AA64A42A24239A239399E39319A
      31218E218CBA8C0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
      00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF}
    ParentFont = False
    OnClick = SpeedButton1Click
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 8
    Width = 265
    Height = 73
    Caption = 'Ingresar Patente Actual'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Edit1: TEdit
      Left = 8
      Top = 24
      Width = 249
      Height = 32
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 16
    Top = 80
    Width = 265
    Height = 73
    Caption = 'Ingresar Patente Nueva'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Edit2: TEdit
      Left = 8
      Top = 24
      Width = 249
      Height = 32
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 16
    Top = 152
    Width = 265
    Height = 73
    Caption = 'Ingresar Cod. Inspecci'#243'n'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Edit3: TEdit
      Left = 8
      Top = 24
      Width = 249
      Height = 32
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
end
