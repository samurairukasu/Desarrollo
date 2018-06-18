object frmturnos: Tfrmturnos
  Left = 274
  Top = 7
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Turnos'
  ClientHeight = 683
  ClientWidth = 963
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 963
    Height = 41
    Align = alTop
    Color = clInfoBk
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 11
      Width = 68
      Height = 15
      Caption = 'TURNOS DEL'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 234
      Top = 11
      Width = 61
      Height = 15
      Caption = 'CANTIDAD:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 338
      Top = 11
      Width = 43
      Height = 15
      Caption = 'REVIS'#211':'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 434
      Top = 11
      Width = 59
      Height = 15
      Caption = 'AUSENTES:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 672
      Top = 8
      Width = 127
      Height = 23
      Caption = 'PROCESANDO...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BitBtn8: TBitBtn
      Left = 568
      Top = 8
      Width = 75
      Height = 25
      Caption = 'ACTUALIZAR'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = -12
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn8Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 48
    Width = 945
    Height = 529
    Color = clInfoBk
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    PopupMenu = PopupMenu1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'ES'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Caption = 'TIPO'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'modo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Caption = 'MODO'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'hora'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'HORA'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'patente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'PATENTE'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'resultado'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Caption = 'RESULTADO'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'estado'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'ESTADO'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'titular'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'TITULAR'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'telefono'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'TELEFONO'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'turnoid'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'TURNOID'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'reviso'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'REVISO'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'INFOME'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'INFORMADO'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MOTIVO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'codinspe'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'anio'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'tipoisnpe'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Caption = 'Tipo Inspe'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ESTADODES'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'estadid'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -12
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Visible = False
      end>
  end
  object BitBtn1: TBitBtn
    Left = 864
    Top = 600
    Width = 75
    Height = 25
    Caption = 'Salir'
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 8
    Top = 592
    Width = 113
    Height = 33
    Caption = 'Informar Ausentes'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = BitBtn2Click
  end
  object BitBtn3: TBitBtn
    Left = 128
    Top = 592
    Width = 113
    Height = 33
    Caption = 'Turno Reverificaci'#243'n'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = BitBtn3Click
  end
  object Memo1: TMemo
    Left = 368
    Top = 112
    Width = 353
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 5
    Visible = False
  end
  object Memo2: TMemo
    Left = 376
    Top = 240
    Width = 353
    Height = 89
    Lines.Strings = (
      'Memo2')
    TabOrder = 6
    Visible = False
  end
  object BitBtn4: TBitBtn
    Left = 248
    Top = 592
    Width = 57
    Height = 33
    Caption = 'Informar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = BitBtn4Click
  end
  object BitBtn5: TBitBtn
    Left = 368
    Top = 592
    Width = 153
    Height = 33
    Caption = 'Generar Factura Electr'#243'nica'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    Visible = False
    OnClick = BitBtn5Click
  end
  object DateTimePicker1: TDateTimePicker
    Left = 520
    Top = 600
    Width = 97
    Height = 22
    Date = 42614.509099513890000000
    Time = 42614.509099513890000000
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object BitBtn6: TBitBtn
    Left = 622
    Top = 598
    Width = 75
    Height = 25
    Caption = 'Buscar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    OnClick = BitBtn6Click
  end
  object BitBtn7: TBitBtn
    Left = 720
    Top = 600
    Width = 105
    Height = 25
    Caption = 'Imprimir Listado'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    OnClick = BitBtn7Click
  end
  object BitBtn9: TBitBtn
    Left = 312
    Top = 593
    Width = 81
    Height = 30
    Caption = 'Informar Todos'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    OnClick = BitBtn9Click
  end
  object Edit1: TEdit
    Left = 16
    Top = 648
    Width = 121
    Height = 21
    TabOrder = 13
    Text = 'Edit1'
  end
  object BitBtn10: TBitBtn
    Left = 144
    Top = 648
    Width = 105
    Height = 25
    Caption = 'Infor por idturno'
    TabOrder = 14
    OnClick = BitBtn10Click
  end
  object BitBtn11: TBitBtn
    Left = 264
    Top = 648
    Width = 75
    Height = 25
    Caption = 'Ausente'
    TabOrder = 15
    OnClick = BitBtn11Click
  end
  object DataSource1: TDataSource
    DataSet = RxMemoryData1
    Left = 224
    Top = 192
  end
  object RxMemoryData1: TRxMemoryData
    FieldDefs = <>
    Left = 336
    Top = 144
    object RxMemoryData1turnoid: TIntegerField
      FieldName = 'turnoid'
    end
    object RxMemoryData1hora: TStringField
      FieldName = 'hora'
      Size = 12
    end
    object RxMemoryData1patente: TStringField
      DisplayWidth = 25
      FieldName = 'patente'
      Size = 25
    end
    object RxMemoryData1estado: TStringField
      FieldName = 'estado'
      Size = 15
    end
    object RxMemoryData1titular: TStringField
      FieldName = 'titular'
      Size = 40
    end
    object RxMemoryData1telefono: TStringField
      FieldName = 'telefono'
    end
    object RxMemoryData1reviso: TStringField
      FieldName = 'reviso'
    end
    object RxMemoryData1INFOME: TStringField
      FieldName = 'INFOME'
      Size = 2
    end
    object RxMemoryData1MOTIVO: TStringField
      FieldName = 'MOTIVO'
      Size = 300
    end
    object RxMemoryData1codinspe: TIntegerField
      FieldName = 'codinspe'
    end
    object RxMemoryData1anio: TIntegerField
      FieldName = 'anio'
    end
    object RxMemoryData1resultado: TStringField
      FieldName = 'resultado'
      Size = 2
    end
    object RxMemoryData1modo: TStringField
      FieldName = 'modo'
      Size = 2
    end
    object RxMemoryData1marca: TStringField
      FieldName = 'marca'
      Size = 50
    end
    object RxMemoryData1modelo: TStringField
      FieldName = 'modelo'
      Size = 80
    end
    object RxMemoryData1tipoisnpe: TStringField
      FieldName = 'tipoisnpe'
      Size = 2
    end
    object RxMemoryData1ESTADODES: TStringField
      FieldName = 'ESTADODES'
    end
    object RxMemoryData1ausentes: TStringField
      FieldName = 'ausentes'
      Size = 2
    end
    object RxMemoryData1estadid: TStringField
      FieldName = 'estadid'
      Size = 3
    end
    object RxMemoryData1ES: TStringField
      FieldName = 'ES'
      Size = 15
    end
  end
  object XMLDocument1: TXMLDocument
    Left = 104
    Top = 96
    DOMVendorDesc = 'MSXML'
  end
  object XMLDocument2: TXMLDocument
    ParseOptions = [poValidateOnParse]
    Left = 80
    Top = 256
    DOMVendorDesc = 'MSXML'
  end
  object PopupMenu1: TPopupMenu
    Left = 272
    Top = 344
    object CambiodeDominiodelTurno1: TMenuItem
      Caption = 'Cambio de Dominio del Turno'
      OnClick = CambiodeDominiodelTurno1Click
    end
    object SolicitarTurnoReverificacion1: TMenuItem
      Caption = 'Solicitar Turno Reverificacion'
    end
  end
end
