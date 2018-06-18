object frmMovInformes: TfrmMovInformes
  Left = 395
  Top = 150
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Movimiento de Informes de Inspecci'#243'n'
  ClientHeight = 358
  ClientWidth = 383
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  DesignSize = (
    383
    358)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 199
    Top = 28
    Width = 81
    Height = 13
    Caption = 'Fecha Entrega'
  end
  object Label3: TLabel
    Left = 33
    Top = 96
    Width = 102
    Height = 13
    Caption = 'N'#186' Informe Inicial'
  end
  object Label4: TLabel
    Left = 161
    Top = 96
    Width = 51
    Height = 13
    Caption = 'Cantidad'
  end
  object Label5: TLabel
    Left = 241
    Top = 96
    Width = 92
    Height = 13
    Caption = 'N'#186' Informe final'
  end
  object Label6: TLabel
    Left = 16
    Top = 182
    Width = 38
    Height = 13
    Caption = 'Origen'
  end
  object Label7: TLabel
    Left = 16
    Top = 214
    Width = 43
    Height = 13
    Caption = 'Destino'
  end
  object Bevel1: TBevel
    Left = 0
    Top = 270
    Width = 386
    Height = 2
    Anchors = [akLeft, akTop, akRight]
  end
  object Label9: TLabel
    Left = 47
    Top = 28
    Width = 85
    Height = 13
    Caption = 'Fecha Solicitud'
  end
  object Label10: TLabel
    Left = 16
    Top = 244
    Width = 37
    Height = 13
    Caption = 'Motivo'
  end
  object Label11: TLabel
    Left = 8
    Top = 275
    Width = 82
    Height = 13
    Caption = 'Preparado por'
  end
  object Label12: TLabel
    Left = 200
    Top = 275
    Width = 84
    Height = 13
    Caption = 'Autorizado por'
  end
  object Label8: TLabel
    Left = 8
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
    Left = 8
    Top = 76
    Width = 49
    Height = 13
    Caption = 'Informes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label17: TLabel
    Left = 8
    Top = 157
    Width = 65
    Height = 13
    Caption = 'Movimiento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel4: TBevel
    Left = -367
    Top = 0
    Width = 250
    Height = 383
    Align = alCustom
  end
  object Bevel5: TBevel
    Left = 0
    Top = 319
    Width = 386
    Height = 2
    Anchors = [akLeft, akTop, akRight]
  end
  object Bevel2: TBevel
    Left = -2
    Top = 148
    Width = 386
    Height = 2
    Anchors = [akLeft, akTop, akRight]
  end
  object Bevel3: TBevel
    Left = -3
    Top = 71
    Width = 386
    Height = 2
    Anchors = [akLeft, akTop, akRight]
  end
  object btnSalir: TBitBtn
    Left = 237
    Top = 326
    Width = 85
    Height = 25
    Caption = 'Salir'
    TabOrder = 12
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
  object edinformeinicial: TDBEdit
    Left = 33
    Top = 112
    Width = 103
    Height = 21
    DataField = 'INFORMEINICIAL'
    DataSource = srcMovimiento
    MaxLength = 9
    TabOrder = 2
    OnExit = edCantidadExit
  end
  object edCantidad: TDBEdit
    Left = 161
    Top = 112
    Width = 57
    Height = 21
    DataField = 'CANTIDAD'
    DataSource = srcMovimiento
    MaxLength = 8
    TabOrder = 3
    OnExit = edCantidadExit
  end
  object edinformefinal: TDBEdit
    Left = 241
    Top = 112
    Width = 90
    Height = 21
    DataField = 'INFORMEFINAL'
    DataSource = srcMovimiento
    Enabled = False
    MaxLength = 9
    TabOrder = 4
  end
  object edFecha: TDBDateEdit
    Left = 199
    Top = 44
    Width = 121
    Height = 21
    DataField = 'FECHA'
    DataSource = srcMovimiento
    NumGlyphs = 2
    TabOrder = 1
  end
  object lcbOrigen: TRxDBLookupCombo
    Left = 64
    Top = 180
    Width = 273
    Height = 21
    DropDownCount = 8
    DataField = 'IDORIGEN'
    DataSource = srcMovimiento
    LookupField = 'IDPLANTA'
    LookupDisplay = 'NOMBRE'
    LookupSource = srcOrigen
    TabOrder = 5
    OnCloseUp = lcbOrigenCloseUp
  end
  object lcbDestino: TRxDBLookupCombo
    Left = 64
    Top = 209
    Width = 273
    Height = 21
    DropDownCount = 8
    DataField = 'IDDESTINO'
    DataSource = srcMovimiento
    LookupField = 'IDPLANTA'
    LookupDisplay = 'NOMBRE'
    LookupSource = srcPlanta
    TabOrder = 6
    OnCloseUp = lcbDestinoCloseUp
  end
  object btnAceptar: TBitBtn
    Left = 61
    Top = 326
    Width = 85
    Height = 25
    Caption = 'Aceptar'
    Default = True
    TabOrder = 10
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
    Left = 149
    Top = 326
    Width = 85
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 11
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
    Left = 47
    Top = 44
    Width = 121
    Height = 21
    DataField = 'FECHSOLI'
    DataSource = srcMovimiento
    NumGlyphs = 2
    TabOrder = 0
  end
  object edMotivo: TDBEdit
    Left = 64
    Top = 240
    Width = 271
    Height = 21
    CharCase = ecUpperCase
    DataField = 'MOTIVO'
    DataSource = srcMovimiento
    MaxLength = 20
    TabOrder = 7
  end
  object lcbPrepara: TRxDBLookupCombo
    Left = 8
    Top = 291
    Width = 177
    Height = 21
    DropDownCount = 8
    DataField = 'IDPREPARA'
    DataSource = srcMovimiento
    ListStyle = lsDelimited
    LookupField = 'IDPERSONAL'
    LookupDisplay = 'NOMBRE;APELLIDO'
    LookupDisplayIndex = 1
    LookupSource = srcPrepara
    TabOrder = 8
    OnCloseUp = lcbPreparaCloseUp
  end
  object lcbAutoriza: TRxDBLookupCombo
    Left = 200
    Top = 291
    Width = 177
    Height = 21
    DropDownCount = 8
    DataField = 'IDAUTORIZA'
    DataSource = srcMovimiento
    ListStyle = lsDelimited
    LookupField = 'IDPERSONAL'
    LookupDisplay = 'NOMBRE;APELLIDO'
    LookupDisplayIndex = 1
    LookupSource = srcAutoriza
    TabOrder = 9
    OnCloseUp = lcbAutorizaCloseUp
  end
  object srcOrigen: TDataSource
    Left = 184
    Top = 146
  end
  object srcPlanta: TDataSource
    Left = 120
    Top = 146
  end
  object srcMovimiento: TDataSource
    Left = 216
    Top = 146
  end
  object srcPrepara: TDataSource
    Left = 88
    Top = 146
  end
  object srcAutoriza: TDataSource
    Left = 152
    Top = 146
  end
  object PopupMenu1: TPopupMenu
    Left = 144
    Top = 24
  end
end
