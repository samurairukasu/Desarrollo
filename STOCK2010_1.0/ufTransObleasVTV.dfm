object frmTransObleasVTV: TfrmTransObleasVTV
  Left = 247
  Top = 156
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Transferencia de Obleas VTV entre Zonas'
  ClientHeight = 344
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  DesignSize = (
    418
    344)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 176
    Top = 28
    Width = 70
    Height = 13
    Caption = 'Fecha Entrega'
  end
  object Label2: TLabel
    Left = 48
    Top = 96
    Width = 19
    Height = 13
    Caption = 'A'#241'o'
  end
  object Label3: TLabel
    Left = 112
    Top = 96
    Width = 73
    Height = 13
    Caption = 'N'#186' Oblea Inicial'
  end
  object Label4: TLabel
    Left = 208
    Top = 96
    Width = 42
    Height = 13
    Caption = 'Cantidad'
  end
  object Label5: TLabel
    Left = 272
    Top = 96
    Width = 65
    Height = 13
    Caption = 'N'#186' Oblea final'
  end
  object Label6: TLabel
    Left = 48
    Top = 172
    Width = 31
    Height = 13
    Caption = 'Origen'
  end
  object Label7: TLabel
    Left = 48
    Top = 212
    Width = 36
    Height = 13
    Caption = 'Destino'
  end
  object Bevel1: TBevel
    Left = 0
    Top = 294
    Width = 418
    Height = 2
    Anchors = [akLeft, akTop, akRight]
  end
  object Label9: TLabel
    Left = 48
    Top = 28
    Width = 73
    Height = 13
    Caption = 'Fecha Solicitud'
  end
  object Label10: TLabel
    Left = 48
    Top = 251
    Width = 32
    Height = 13
    Caption = 'Motivo'
  end
  object Label8: TLabel
    Left = 24
    Top = 8
    Width = 42
    Height = 13
    Caption = 'Fechas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label16: TLabel
    Left = 24
    Top = 76
    Width = 40
    Height = 13
    Caption = 'Obleas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label17: TLabel
    Left = 24
    Top = 152
    Width = 79
    Height = 13
    Caption = 'Transferencia'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel2: TBevel
    Left = 24
    Top = 22
    Width = 250
    Height = 2
  end
  object Bevel3: TBevel
    Left = 24
    Top = 90
    Width = 250
    Height = 2
  end
  object Bevel4: TBevel
    Left = 24
    Top = 166
    Width = 250
    Height = 2
  end
  object btnSalir: TBitBtn
    Left = 249
    Top = 309
    Width = 75
    Height = 25
    Caption = 'Salir'
    TabOrder = 11
    OnClick = btnSalirClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
      03333377777777777F333301BBBBBBBB033333773F3333337F3333011BBBBBBB
      0333337F73F333337F33330111BBBBBB0333337F373F33337F333301110BBBBB
      0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
      0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
      0333337F337F33337F333301110BBBBB0333337F337FF3337F33330111B0BBBB
      0333337F337733337F333301110BBBBB0333337F337F33337F333301110BBBBB
      0333337F3F7F33337F333301E10BBBBB0333337F7F7F33337F333301EE0BBBBB
      0333337F777FFFFF7F3333000000000003333377777777777333}
    NumGlyphs = 2
  end
  object edObleaInicial: TDBEdit
    Left = 112
    Top = 112
    Width = 90
    Height = 21
    DataField = 'OBLEAINICIAL'
    DataSource = srcMovimiento
    MaxLength = 9
    TabOrder = 3
    OnExit = edCantidadExit
  end
  object edAno: TDBEdit
    Left = 48
    Top = 112
    Width = 57
    Height = 21
    DataField = 'ANO'
    DataSource = srcMovimiento
    MaxLength = 4
    TabOrder = 2
  end
  object edCantidad: TDBEdit
    Left = 208
    Top = 112
    Width = 57
    Height = 21
    DataField = 'CANTIDAD'
    DataSource = srcMovimiento
    MaxLength = 8
    TabOrder = 4
    OnExit = edCantidadExit
  end
  object edObleaFinal: TDBEdit
    Left = 272
    Top = 112
    Width = 90
    Height = 21
    DataField = 'OBLEAFINAL'
    DataSource = srcMovimiento
    Enabled = False
    MaxLength = 9
    TabOrder = 5
  end
  object edFecha: TDBDateEdit
    Left = 176
    Top = 44
    Width = 121
    Height = 21
    DataField = 'FECHA'
    DataSource = srcMovimiento
    NumGlyphs = 2
    TabOrder = 1
  end
  object lcbOrigen: TRxDBLookupCombo
    Left = 48
    Top = 188
    Width = 337
    Height = 21
    DropDownCount = 8
    DataField = 'IDORIGEN'
    DataSource = srcMovimiento
    LookupField = 'IDPLANTA'
    LookupDisplay = 'NOMBRE'
    LookupSource = srcOrigen
    TabOrder = 6
    OnCloseUp = lcbOrigenCloseUp
  end
  object lcbDestino: TRxDBLookupCombo
    Left = 48
    Top = 228
    Width = 337
    Height = 21
    DropDownCount = 8
    DataField = 'IDDESTINO'
    DataSource = srcMovimiento
    LookupField = 'IDPLANTA'
    LookupDisplay = 'NOMBRE'
    LookupSource = srcPlanta
    TabOrder = 7
    OnCloseUp = lcbDestinoCloseUp
  end
  object btnAceptar: TBitBtn
    Left = 95
    Top = 309
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 9
    OnClick = btnAceptarClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      555555555555555555555555555555555555555555FF55555555555559055555
      55555555577FF5555555555599905555555555557777F5555555555599905555
      555555557777FF5555555559999905555555555777777F555555559999990555
      5555557777777FF5555557990599905555555777757777F55555790555599055
      55557775555777FF5555555555599905555555555557777F5555555555559905
      555555555555777FF5555555555559905555555555555777FF55555555555579
      05555555555555777FF5555555555557905555555555555777FF555555555555
      5990555555555555577755555555555555555555555555555555}
    NumGlyphs = 2
  end
  object btnCancelar: TBitBtn
    Left = 172
    Top = 309
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 10
    OnClick = btnCancelarClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
      3333333777333777FF3333993333339993333377FF3333377FF3399993333339
      993337777FF3333377F3393999333333993337F777FF333337FF993399933333
      399377F3777FF333377F993339993333399377F33777FF33377F993333999333
      399377F333777FF3377F993333399933399377F3333777FF377F993333339993
      399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
      99333773FF3333777733339993333339933333773FFFFFF77333333999999999
      3333333777333777333333333999993333333333377777333333}
    NumGlyphs = 2
  end
  object edFechsoli: TDBDateEdit
    Left = 48
    Top = 44
    Width = 121
    Height = 21
    DataField = 'FECHSOLI'
    DataSource = srcMovimiento
    NumGlyphs = 2
    TabOrder = 0
  end
  object edMotivo: TDBEdit
    Left = 48
    Top = 267
    Width = 337
    Height = 21
    CharCase = ecUpperCase
    DataField = 'MOTIVO'
    DataSource = srcMovimiento
    MaxLength = 20
    TabOrder = 8
  end
  object srcOrigen: TDataSource
    Left = 48
    Top = 307
  end
  object srcPlanta: TDataSource
    Left = 72
    Top = 307
  end
  object srcMovimiento: TDataSource
    Left = 96
    Top = 307
  end
end
