object tarj_nc_cf: Ttarj_nc_cf
  Left = 654
  Top = 249
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Cancelaci'#243'n Tarjeta'
  ClientHeight = 336
  ClientWidth = 374
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BbNroFactura: TBevel
    Left = 0
    Top = 24
    Width = 370
    Height = 263
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 9
    Top = 78
    Width = 53
    Height = 14
    Caption = 'Tarjeta:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 9
    Top = 112
    Width = 129
    Height = 14
    Caption = 'Numero de Tarjeta:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 9
    Top = 146
    Width = 86
    Height = 14
    Caption = 'Vencimiento:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 9
    Top = 180
    Width = 88
    Height = 14
    Caption = 'Cant. Cuotas:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 9
    Top = 214
    Width = 136
    Height = 14
    Caption = 'C'#243'digo Autorizaci'#243'n:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 74
    Top = 255
    Width = 159
    Height = 23
    Caption = 'Importe Total: $'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object lblCantidadAPagar: TLabel
    Left = 237
    Top = 255
    Width = 70
    Height = 22
    AutoSize = False
    Caption = '000,00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 0
    Top = 216
    Width = 369
    Height = 26
    Shape = bsBottomLine
  end
  object LblNumeroFactura: TLabel
    Left = 89
    Top = 35
    Width = 177
    Height = 18
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblfactura: TLabel
    Left = 9
    Top = 35
    Width = 73
    Height = 18
    Caption = 'Factura:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel2: TBevel
    Left = 1
    Top = 36
    Width = 369
    Height = 26
    Shape = bsBottomLine
  end
  object CBTarjeta: TRxDBLookupCombo
    Tag = 1
    Left = 151
    Top = 75
    Width = 187
    Height = 23
    Hint = 'Tipo del veh'#237'culo en cuanto al destino de servicio'
    DropDownCount = 10
    DataField = 'TIPODEST'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    LookupField = 'CODTARJET'
    LookupDisplay = 'NOMTARJET'
    LookupSource = DSToTTarjetas
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object ednumtarjeta: TEdit
    Left = 152
    Top = 110
    Width = 211
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    MaxLength = 16
    ParentFont = False
    TabOrder = 1
  end
  object edfecven: TDateEdit
    Left = 152
    Top = 144
    Width = 121
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
  end
  object edcantcuotas: TRxSpinEdit
    Left = 151
    Top = 177
    Width = 57
    Height = 21
    MaxValue = 99.000000000000000000
    MinValue = 1.000000000000000000
    Value = 1.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    MaxLength = 2
    ParentFont = False
    TabOrder = 3
  end
  object BContinuar: TBitBtn
    Left = 83
    Top = 295
    Width = 99
    Height = 28
    Hint = 
      'Continuar con la siguiente operaci'#243'n.'#13#10'Haga click para continuar' +
      #39'.'
    Caption = '&Continuar'
    Font.Charset = DEFAULT_CHARSET
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
    Left = 187
    Top = 295
    Width = 99
    Height = 28
    Hint = 'Cancela la operaci'#243'n actual.'#13#10'Haga click para cancelar.'
    Caption = 'Cance&lar'
    Font.Charset = DEFAULT_CHARSET
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
  object Panel15: TPanel
    Left = 1
    Top = 0
    Width = 368
    Height = 24
    Align = alCustom
    BevelOuter = bvLowered
    Caption = 'Datos de la Tarjeta de Cr'#233'dito'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object Image1: TImage
      Left = 2
      Top = 1
      Width = 36
      Height = 22
      Enabled = False
      Picture.Data = {
        07544269746D6170B6060000424DB60600000000000036040000280000002000
        0000140000000100080000000000800200000000000000000000000100000001
        000000000000000080000080000000808000800000008000800080800000C0C0
        C000C0DCC000F0CAA60004040400080808000C0C0C0011111100161616001C1C
        1C002222220029292900555555004D4D4D004242420039393900807CFF005050
        FF009300D600FFECCC00C6D6EF00D6E7E70090A9AD0000003300000066000000
        99000000CC00003300000033330000336600003399000033CC000033FF000066
        00000066330000666600006699000066CC000066FF0000990000009933000099
        6600009999000099CC000099FF0000CC000000CC330000CC660000CC990000CC
        CC0000CCFF0000FF660000FF990000FFCC003300000033003300330066003300
        99003300CC003300FF00333300003333330033336600333399003333CC003333
        FF00336600003366330033666600336699003366CC003366FF00339900003399
        330033996600339999003399CC003399FF0033CC000033CC330033CC660033CC
        990033CCCC0033CCFF0033FF330033FF660033FF990033FFCC0033FFFF006600
        00006600330066006600660099006600CC006600FF0066330000663333006633
        6600663399006633CC006633FF00666600006666330066666600666699006666
        CC00669900006699330066996600669999006699CC006699FF0066CC000066CC
        330066CC990066CCCC0066CCFF0066FF000066FF330066FF990066FFCC00CC00
        FF00FF00CC009999000099339900990099009900CC0099000000993333009900
        66009933CC009900FF00996600009966330099336600996699009966CC009933
        FF009999330099996600999999009999CC009999FF0099CC000099CC330066CC
        660099CC990099CCCC0099CCFF0099FF000099FF330099CC660099FF990099FF
        CC0099FFFF00CC00000099003300CC006600CC009900CC00CC0099330000CC33
        3300CC336600CC339900CC33CC00CC33FF00CC660000CC66330099666600CC66
        9900CC66CC009966FF00CC990000CC993300CC996600CC999900CC99CC00CC99
        FF00CCCC0000CCCC3300CCCC6600CCCC9900CCCCCC00CCCCFF00CCFF0000CCFF
        330099FF6600CCFF9900CCFFCC00CCFFFF00CC003300FF006600FF009900CC33
        0000FF333300FF336600FF339900FF33CC00FF33FF00FF660000FF663300CC66
        6600FF669900FF66CC00CC66FF00FF990000FF993300FF996600FF999900FF99
        CC00FF99FF00FFCC0000FFCC3300FFCC6600FFCC9900FFCCCC00FFCCFF00FFFF
        3300CCFF6600FFFF9900FFFFCC006666FF0066FF660066FFFF00FF666600FF66
        FF00FFFF66002100A5005F5F5F00777777008686860096969600CBCBCB00B2B2
        B200D7D7D700DDDDDD00E3E3E300EAEAEA00F1F1F100F8F8F800F0FBFF00A4A0
        A000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00070707070707070707070707070707070707070707070707070707070707
        070707F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F901
        010707F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F901
        010707F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9
        F90707F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9
        F907FF0707070707070707070707070707070707070707070707070707070707
        0707FFFFFFFF070707070707070707070707F807FF0707FFFF070707070707FF
        FFFFFF07FF0707FF07000007070400070400000000F80007070700F807FFFF07
        0707FF0707070707070000F8070700F8070707070004000000000007FF070707
        0707FF07FF070707F800F80007070000070707000006070007F800F807070707
        0707FFFF07070707F80007F800070000070700000407070600F80007FF070707
        0707FF07FF070707F800070700F80700F8F800F8070707070000000707070707
        0707FFFF0707070704000707F800070000070000F80407070700000707070707
        0707FF0707070707F8F8070707F80707F80707040004070707F8F80707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070000000000000000000000000000000000000000000000000000000000
        0007070000000000000000000000000000000000000000000000000000000000
        0007070000000000000000000000000000000000000000000000000000000000
        0007070000000000000000000000000000000000000000000000000000000000
        0007070707070707070707070707070707070707070707070707070707070707
        0707}
      Stretch = True
      Transparent = True
    end
  end
  object edCodAuto: TEdit
    Left = 151
    Top = 211
    Width = 212
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    MaxLength = 20
    ParentFont = False
    TabOrder = 7
    OnKeyPress = edCodAutoKeyPress
  end
  object DSToTTarjetas: TDataSource
    Left = 24
    Top = 280
  end
  object datos_tarjeta: TRxMemoryData
    FieldDefs = <>
    Left = 264
    Top = 176
    object datos_tarjetatarjeta: TStringField
      FieldName = 'tarjeta'
      Size = 40
    end
    object datos_tarjetanumero: TStringField
      FieldName = 'numero'
      Size = 40
    end
    object datos_tarjetavencimiento: TStringField
      FieldName = 'vencimiento'
    end
    object datos_tarjetacuotas: TStringField
      FieldName = 'cuotas'
      Size = 10
    end
    object datos_tarjetacodigo: TStringField
      FieldName = 'codigo'
    end
    object datos_tarjetausa: TIntegerField
      FieldName = 'usa'
    end
    object datos_tarjetacodtarjeta: TStringField
      FieldName = 'codtarjeta'
      Size = 10
    end
  end
end
