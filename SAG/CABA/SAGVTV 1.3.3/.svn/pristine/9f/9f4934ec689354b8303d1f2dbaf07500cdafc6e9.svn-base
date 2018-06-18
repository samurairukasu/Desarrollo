object FRMSCANEOCERTIFICADO: TFRMSCANEOCERTIFICADO
  Left = 325
  Top = 237
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 357
  ClientWidth = 378
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 24
    Top = 280
    Width = 334
    Height = 15
    Caption = 'Cuando termine de scanear los certificado presione continuar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 0
    Top = 276
    Width = 20
    Height = 26
    Caption = '>>'
    Font.Charset = ANSI_CHARSET
    Font.Color = clYellow
    Font.Height = -21
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 89
    Height = 23
    Caption = 'CANTIDAD '
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 378
    Height = 41
    Align = alTop
    Color = clOlive
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 315
      Height = 23
      Caption = 'SCANEAR LOS CERTIFICADOS IMPRESOS'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
  end
  object Edit1: TEdit
    Left = 8
    Top = 96
    Width = 361
    Height = 44
    Hint = 'SCANEE LOS CERTIFICADOS'
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Text = '100001'
    OnKeyPress = Edit1KeyPress
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 312
    Width = 121
    Height = 33
    Hint = 'AL PRESIONAR CONTINUAR SE FINALIZARA LA INSPECCION'
    Caption = 'Continuar >> (Ctrl+C)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 144
    Width = 361
    Height = 120
    Hint = 'PRESIONE BOTON DERECHO DEL MOUSE PARA ACCEDER A LAS OPCIONES'
    Color = clInfoBk
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'hoja'
        Title.Alignment = taCenter
        Title.Caption = 'Nro Hoja'
        Title.Color = clOlive
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clMaroon
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 142
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'certificado'
        Title.Alignment = taCenter
        Title.Caption = 'Nro Certificado'
        Title.Color = clOlive
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clMaroon
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 109
        Visible = True
      end>
  end
  object BitBtn2: TBitBtn
    Left = 240
    Top = 312
    Width = 97
    Height = 33
    Hint = 
      'AL PRESIONAR CANCELAR SE CANCEL'#193' LA IMPRESION DE CERTIFICADO Y O' +
      'BLEA'
    Caption = 'Cancelar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = BitBtn2Click
  end
  object DataSource1: TDataSource
    DataSet = RxMemoryData1
    Left = 72
    Top = 168
  end
  object RxMemoryData1: TRxMemoryData
    FieldDefs = <>
    Left = 144
    Top = 168
    object RxMemoryData1hoja: TIntegerField
      FieldName = 'hoja'
    end
    object RxMemoryData1certificado: TStringField
      FieldName = 'certificado'
    end
  end
  object MainMenu1: TMainMenu
    Left = 152
    Top = 304
    object continuar1: TMenuItem
      Caption = 'continuar'
      ShortCut = 16451
      Visible = False
      OnClick = continuar1Click
    end
  end
  object sHintManager1: TsHintManager
    HintKind.Style = hsComics
    HintKind.GradientData = 
      '167827;6865090;24;2;0;6865090;6865090;24;2;0;6865090;15400959;24' +
      ';2;0;15400959;6865090;24;2;0;6865090;6865090;0;2;0'
    HintKind.GradientPercent = 100
    HintKind.Bevel = 1
    HintKind.Color = 11992314
    HintKind.ColorBorderTop = clWhite
    HintKind.ColorBorderBottom = clOlive
    HintKind.Transparency = 10
    HintKind.ShadowBlur = 5
    HintKind.ShadowEnabled = True
    HintKind.ShadowOffset = 6
    HintKind.ShadowTransparency = 50
    HintKind.MarginH = 6
    HintKind.MarginV = 3
    HintKind.MaxWidth = 240
    HintKind.Font.Charset = ANSI_CHARSET
    HintKind.Font.Color = clBlack
    HintKind.Font.Height = -12
    HintKind.Font.Name = 'Calibri'
    HintKind.Font.Style = [fsBold]
    Predefinitions = shCustom
    SkinSection = 'HINT'
    Left = 216
    Top = 64
  end
end
