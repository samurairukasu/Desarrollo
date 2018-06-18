object ANIOMES: TANIOMES
  Left = 638
  Top = 220
  Width = 311
  Height = 181
  Caption = 'ANIOMES'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 275
    Height = 65
  end
  object Label1: TLabel
    Left = 19
    Top = 17
    Width = 63
    Height = 13
    Caption = 'Fecha &Inicial:'
  end
  object lblHasta: TLabel
    Left = 153
    Top = 18
    Width = 58
    Height = 13
    Caption = 'Fecha &Final:'
  end
  object btnAceptar: TBitBtn
    Left = 57
    Top = 84
    Width = 81
    Height = 25
    Hint = 
      'Llevar a cabo la b'#250'squeda se'#241'alada|Selecciona un rango de valore' +
      's entre las fechas seleccionadas'
    Caption = '&Aceptar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000010000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333377F3333333333000033334224333333333333
      337337F3333333330000333422224333333333333733337F3333333300003342
      222224333333333373333337F3333333000034222A22224333333337F337F333
      7F33333300003222A3A2224333333337F3737F337F33333300003A2A333A2224
      33333337F73337F337F33333000033A33333A222433333337333337F337F3333
      0000333333333A222433333333333337F337F33300003333333333A222433333
      333333337F337F33000033333333333A222433333333333337F337F300003333
      33333333A222433333333333337F337F00003333333333333A22433333333333
      3337F37F000033333333333333A223333333333333337F730000333333333333
      333A333333333333333337330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object btnCancelar: TBitBtn
    Left = 153
    Top = 84
    Width = 85
    Height = 25
    Hint = 
      'Cancela la b'#250'squeda|NO selecciona un rango de valores entre las ' +
      'fechas seleccionadas'
    Caption = '&Cancelar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Kind = bkCancel
  end
end
