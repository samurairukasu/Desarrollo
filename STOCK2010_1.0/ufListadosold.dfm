object frmListados: TfrmListados
  Left = 387
  Top = 180
  BorderStyle = bsDialog
  Caption = 'Listados Obleas'
  ClientHeight = 343
  ClientWidth = 320
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
  OnKeyPress = FormKeyPress
  DesignSize = (
    320
    343)
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Tag = 5
    Left = 33
    Top = 22
    Width = 88
    Height = 13
    Caption = 'N'#186' Movimeinto:'
    Visible = False
  end
  object Label4: TLabel
    Tag = 6
    Left = 33
    Top = 22
    Width = 40
    Height = 13
    Caption = 'Planta:'
    Visible = False
  end
  object Bevel2: TBevel
    Left = 16
    Top = 8
    Width = 289
    Height = 42
    Shape = bsFrame
  end
  object Bevel1: TBevel
    Left = 0
    Top = 305
    Width = 320
    Height = 2
    Anchors = [akLeft, akTop, akRight]
  end
  object Label1: TLabel
    Tag = 4
    Left = 33
    Top = 22
    Width = 40
    Height = 13
    Caption = 'Planta:'
    Visible = False
  end
  object Label2: TLabel
    Tag = 2
    Left = 33
    Top = 22
    Width = 55
    Height = 13
    Caption = 'Empresa:'
    Visible = False
  end
  object lcbPlanta: TRxDBLookupCombo
    Tag = 4
    Left = 91
    Top = 19
    Width = 193
    Height = 21
    DropDownCount = 8
    LookupField = 'IDPLANTA'
    LookupDisplay = 'NOMBRE'
    LookupSource = srcPlantas
    TabOrder = 5
    Visible = False
    OnCloseUp = lcbPlantaCloseUp
  end
  object rgListados: TRadioGroup
    Left = 16
    Top = 58
    Width = 289
    Height = 233
    Caption = 'Seleccione el listado: '
    Items.Strings = (
      'Entrada de Obleas Global'
      'Entrada de Obleas por Empresa'
      'Recepci'#243'n de Obleas Global'
      'Recepci'#243'n de Obleas por Planta'
      'Reimpresi'#243'n de Entrega de Obleas'
      'Stock de Obleas por Planta'
      'Consumo de Obleas'
      'Env'#237'os de CD GNC'
      'Stock de Obleas Global'
      'Env'#237'o de Obleas Global'
      'Env'#237'o de Obleas por Planta')
    TabOrder = 0
    OnClick = rgListadosClick
  end
  object btnAceptar: TBitBtn
    Left = 85
    Top = 315
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 1
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
  object btnSalir: TBitBtn
    Left = 161
    Top = 315
    Width = 75
    Height = 25
    Caption = 'Salir'
    TabOrder = 2
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
  object edNumeros: TEdit
    Tag = 5
    Left = 123
    Top = 19
    Width = 65
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 3
    Visible = False
    OnKeyPress = edNumerosKeyPress
  end
  object lcbEmpresa: TRxDBLookupCombo
    Tag = 2
    Left = 91
    Top = 19
    Width = 193
    Height = 21
    DropDownCount = 8
    LookupField = 'IDEMPRESA'
    LookupDisplay = 'DESCRIPCION'
    LookupSource = srcEmpresas
    TabOrder = 4
    Visible = False
    OnCloseUp = lcbEmpresaCloseUp
  end
  object lcbPlanta2: TRxDBLookupCombo
    Tag = 6
    Left = 91
    Top = 19
    Width = 193
    Height = 21
    DropDownCount = 8
    LookupField = 'IDPLANTA'
    LookupDisplay = 'NOMBRE'
    LookupSource = srcPlantas
    TabOrder = 6
    Visible = False
    OnCloseUp = lcbPlanta2CloseUp
  end
  object srcEmpresas: TDataSource
    Left = 291
    Top = 3
  end
  object srcPlantas: TDataSource
    Left = 259
    Top = 3
  end
end