object FrmDatosReveExterna: TFrmDatosReveExterna
  Left = 221
  Top = 272
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'DATOS DE LA VERIFICACION EXTERNA'
  ClientHeight = 319
  ClientWidth = 396
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = 0
    Top = 50
    Width = 396
    Height = 223
    Align = alTop
  end
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 396
    Height = 50
    Align = alTop
    Style = bsRaised
  end
  object Label26: TLabel
    Left = 19
    Top = 78
    Width = 226
    Height = 16
    Caption = 'N'#250'mero de Informe de la Insp.:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label33: TLabel
    Left = 19
    Top = 120
    Width = 177
    Height = 16
    Caption = 'Fecha de la Verificaci'#243'n:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label1: TLabel
    Left = 19
    Top = 198
    Width = 218
    Height = 16
    Caption = 'Resultado de la Insp. Externa:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 19
    Top = 157
    Width = 166
    Height = 16
    Caption = 'Fecha de Vencimiento:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel
    Left = 11
    Top = 16
    Width = 124
    Height = 16
    Caption = 'N'#250'mero de Zona:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel
    Left = 203
    Top = 16
    Width = 134
    Height = 16
    Caption = 'N'#250'mero de Planta:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object LOblea: TLabel
    Left = 19
    Top = 238
    Width = 130
    Height = 16
    Caption = 'N'#250'mero de Oblea:'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label6: TLabel
    Left = 279
    Top = 64
    Width = 93
    Height = 10
    Caption = #218'ltimos 6 (seis) d'#237'gitos'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object BContinuar: TBitBtn
    Left = 89
    Top = 284
    Width = 105
    Height = 28
    Hint = 
      'Continue con la siguiente operaci'#243'n,'#13#10'si introdujo una combinaci' +
      #243'n de'#13#10'formatos correcta:'#13#10'           D.N.           D.A.       ' +
      '     '#13#10'     -----------------------------------------'#13#10'      F. ' +
      'AUTOS   F. ANTIGUO   '#13#10'      F. AUTOS   VACIO            '#13#10'     ' +
      ' ----------------------------------------'#13#10'      F. MOTOS  F. AN' +
      'TIGUO   '#13#10'      F. MOTOS  VACIO            '#13#10'      -------------' +
      '---------------------------'#13#10'      VACIO         F. ANTIGUO   '
    Caption = 'Aceptar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = BContinuarClick
    Glyph.Data = {
      BE060000424DBE06000000000000360400002800000024000000120000000100
      0800000000008802000000000000000000000001000000010000000000000000
      80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
      A600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030404040406
      0303030303040404040303030303FFFFFFFF030303030303FFFFFFFF03030303
      FAFAFA0403030303030302FA040303030303F8F80303FF0303030303F8F803FF
      030303030302FA0406030303030302FA0403030303030303F803FF0303030303
      03F803FF030303030302FA02040303030306FA060603030303030303F80303FF
      03030303F803FF03030303030303FAFA040603030602FA040303030303030303
      03F803FF030303F80303FF0303030303030306FAFA04040602FA040603030303
      0303030303F80303FFFFF80303FF03030303030303030302FAFA020202040603
      03030303030303030303F80303030303FF030303030303030303030306FAFAFA
      020206040603030303030303030303F803030303FFF8FFFF0303030304040404
      0606FAFA040306FA04030303030303F8FFFFFFF8F80303FF03F803FF03030303
      06FAFA020406FA02040306FA04030303030303F8F80303FFF80303FF03F803FF
      03030303030306FA0204FAFA040402FA040303030303030303F80303FF0303FF
      FFF803FF0303030303030303FA02FAFA02FAFA0403030303030303030303F803
      030303030303FF030303030303030303030202FAFAFA04030303030303030303
      030303F80303030303FF0303030303030303030303030202FA04030303030303
      0303030303030303F8030303FF0303030303030303030303030404FA04030303
      03030303030303030303030303F803FF0303030303030303030303030306FA02
      04030303030303030303030303030303F80303FF030303030303030303030303
      0306FAFA04030303030303030303030303030303F80303FF0303030303030303
      03030303030306060603030303030303030303030303030303F8F8F803030303
      0303}
    NumGlyphs = 2
  end
  object BCancelar: TBitBtn
    Left = 201
    Top = 284
    Width = 105
    Height = 28
    Hint = 'Cancela la operaci'#243'n actual.'#13#10'Haga click para cancelar.'
    Cancel = True
    Caption = 'Cance&lar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = BCancelarClick
    Glyph.Data = {
      BE060000424DBE06000000000000360400002800000024000000120000000100
      0800000000008802000000000000000000000001000000010000000000000000
      80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
      A600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030303030303
      0303030303030303030303030303030303030303030303030303030303030303
      0303F8F80303030303030303030303030303030303FF03030303030303030303
      0303030303F90101F80303030303F9F80303030303030303F8F8FF0303030303
      03FF03030303030303F9010101F8030303F90101F8030303030303F8FF03F8FF
      030303FFF8F8FF030303030303F901010101F803F901010101F80303030303F8
      FF0303F8FF03FFF80303F8FF030303030303F901010101F80101010101F80303
      030303F8FF030303F8FFF803030303F8FF030303030303F90101010101010101
      F803030303030303F8FF030303F803030303FFF80303030303030303F9010101
      010101F8030303030303030303F8FF030303030303FFF8030303030303030303
      030101010101F80303030303030303030303F8FF0303030303F8030303030303
      0303030303F901010101F8030303030303030303030303F8FF030303F8030303
      0303030303030303F90101010101F8030303030303030303030303F803030303
      F8FF030303030303030303F9010101F8010101F803030303030303030303F803
      03030303F8FF0303030303030303F9010101F803F9010101F803030303030303
      03F8030303F8FF0303F8FF03030303030303F90101F8030303F9010101F80303
      03030303F8FF0303F803F8FF0303F8FF03030303030303F9010303030303F901
      0101030303030303F8FFFFF8030303F8FF0303F8FF0303030303030303030303
      030303F901F903030303030303F8F80303030303F8FFFFFFF803030303030303
      03030303030303030303030303030303030303030303030303F8F8F803030303
      0303030303030303030303030303030303030303030303030303030303030303
      0303}
    NumGlyphs = 2
  end
  object CBResultado: TComboBox
    Left = 244
    Top = 194
    Width = 142
    Height = 24
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 3
    OnChange = CBResultadoChange
    Items.Strings = (
      'CONDICIONAL'
      'RECHAZADO')
  end
  object DFechaVerificacion: TDateTimePicker
    Left = 272
    Top = 115
    Width = 113
    Height = 24
    Date = 0.493377152779430600
    Time = 0.493377152779430600
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object ENroInspeccion: TEdit
    Left = 272
    Top = 75
    Width = 112
    Height = 24
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    MaxLength = 6
    ParentFont = False
    TabOrder = 0
    OnKeyPress = EZonaKeyPress
  end
  object DFechaVencimiento: TDateTimePicker
    Left = 272
    Top = 154
    Width = 113
    Height = 24
    Date = 0.493377152779430600
    Time = 0.493377152779430600
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object EOblea: TMaskEdit
    Left = 244
    Top = 234
    Width = 141
    Height = 24
    BiDiMode = bdLeftToRight
    Enabled = False
    EditMask = '00\-000000;0; '
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    MaxLength = 9
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 6
  end
  object SEZona: TSpinEdit
    Left = 142
    Top = 13
    Width = 41
    Height = 26
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    MaxValue = 11
    MinValue = 1
    ParentFont = False
    TabOrder = 7
    Value = 1
  end
  object SEPlanta: TSpinEdit
    Left = 343
    Top = 13
    Width = 41
    Height = 26
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    MaxValue = 12
    MinValue = 1
    ParentFont = False
    TabOrder = 8
    Value = 1
  end
end