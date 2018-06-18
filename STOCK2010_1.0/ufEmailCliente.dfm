object frmEmailCliente: TfrmEmailCliente
  Left = 377
  Top = 155
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Datos Clientes'
  ClientHeight = 442
  ClientWidth = 482
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
    482
    442)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 30
    Height = 13
    Caption = 'Fecha'
  end
  object LbTipo: TLabel
    Left = 152
    Top = 16
    Width = 21
    Height = 13
    Caption = 'Tipo'
  end
  object Label3: TLabel
    Left = 216
    Top = 16
    Width = 45
    Height = 13
    Caption = 'N'#186'  Inicial'
  end
  object Label4: TLabel
    Left = 312
    Top = 16
    Width = 42
    Height = 13
    Caption = 'Cantidad'
  end
  object Label5: TLabel
    Left = 376
    Top = 16
    Width = 37
    Height = 13
    Caption = 'N'#186'  final'
  end
  object Label6: TLabel
    Left = 24
    Top = 64
    Width = 49
    Height = 13
    Caption = 'Proveedor'
  end
  object Label7: TLabel
    Left = 216
    Top = 64
    Width = 42
    Height = 13
    Caption = 'Dep'#243'sito'
  end
  object Label8: TLabel
    Left = 24
    Top = 112
    Width = 78
    Height = 13
    Caption = 'N'#186' Comprobante'
  end
  object Bevel1: TBevel
    Left = -8
    Top = 387
    Width = 482
    Height = 2
    Anchors = [akLeft, akTop, akRight]
  end
  object btnSalir: TBitBtn
    Left = 273
    Top = 402
    Width = 75
    Height = 25
    Caption = 'Salir'
    TabOrder = 10
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
  object lcbProveedor: TRxDBLookupCombo
    Left = 24
    Top = 80
    Width = 177
    Height = 21
    DropDownCount = 8
    LookupField = 'IDPROVEEDOR'
    LookupDisplay = 'RSOCIAL'
    LookupSource = srcProveedor
    TabOrder = 5
    OnCloseUp = lcbProveedorCloseUp
  end
  object lcbDeposito: TRxDBLookupCombo
    Left = 216
    Top = 80
    Width = 249
    Height = 21
    DropDownCount = 8
    LookupField = 'IDPLANTA'
    LookupDisplay = 'NOMBRE'
    LookupSource = srcPlanta
    TabOrder = 6
    OnCloseUp = lcbDepositoCloseUp
  end
  object btnAceptar: TBitBtn
    Left = 119
    Top = 402
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 8
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
    Left = 196
    Top = 402
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 9
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
  object cbtipo: TComboBox
    Left = 150
    Top = 32
    Width = 60
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 1
    Text = 'C'
    Items.Strings = (
      'C'
      'I')
  end
  object edFecha: TDateEdit
    Left = 25
    Top = 33
    Width = 121
    Height = 21
    Hint = 
      'Pinche sobre el calendario para introducir la fecha inicial|Fech' +
      'a de comienzo de la b'#250'squeda. Formato: dd/mm/yyyy'
    ButtonHint = 'Pulsar Para Desplegar Calendario'
    CalendarHints.Strings = (
      'A'#241'o Atr'#225's'
      'Mes Atr'#225's'
      'Mes Adelante'
      'A'#241'o Adelante')
    CheckOnExit = True
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object edNroInicial: TEdit
    Left = 216
    Top = 32
    Width = 73
    Height = 21
    TabOrder = 2
  end
  object edcantidad: TEdit
    Left = 304
    Top = 32
    Width = 57
    Height = 21
    TabOrder = 3
    OnExit = edCantidadExit
  end
  object ednrofinal: TEdit
    Left = 376
    Top = 32
    Width = 89
    Height = 21
    TabOrder = 4
  end
  object ednrocomprobante: TEdit
    Left = 24
    Top = 128
    Width = 121
    Height = 21
    TabOrder = 7
  end
  object srcProveedor: TDataSource
    Left = 448
    Top = 400
  end
  object srcPlanta: TDataSource
    Left = 416
    Top = 400
  end
  object srcMovimiento: TDataSource
    Left = 384
    Top = 400
  end
  object srcMovimiento_informe: TDataSource
    Left = 352
    Top = 400
  end
end
