object frestablecerconexion: Tfrestablecerconexion
  Left = 458
  Top = 285
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Establecer Conexi'#243'n a Chile'
  ClientHeight = 95
  ClientWidth = 290
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 56
    Width = 61
    Height = 13
    Caption = 'Conectado...'
  end
  object BitBtn1: TBitBtn
    Left = 16
    Top = 16
    Width = 113
    Height = 33
    Caption = 'Conectar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = BitBtn1Click
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000FF00FF008080
      8000C0C0C00000000000FFFFFF000080000000FF00000080800000FFFF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
      0000000000333300000033333384733333332222227773222222000000023000
      0000000000033000000003333333333333001244444444442130121111111111
      2113122222222222211312222222222561131444444444444113012222222222
      2213001111111111111000000000000000000000000000000000}
  end
  object BitBtn2: TBitBtn
    Left = 160
    Top = 16
    Width = 113
    Height = 33
    Caption = 'Desconectar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BitBtn2Click
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000FF00FF008080
      8000C0C0C00000000000FFFFFF00008000000000FF00C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000006600660
      0000000000666600000000000006600000003333336666333333222226621662
      2222000000023000000000000003300000000333333333333300124444444444
      2130121111111111211312222222222221131222222222252113144444444444
      4113012222222222221300111111111111100000000000000000}
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 72
    Width = 289
    Height = 17
    TabOrder = 2
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 136
    Top = 8
  end
end
