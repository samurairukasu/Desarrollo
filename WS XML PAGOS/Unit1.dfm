object Form1: TForm1
  Left = 115
  Top = 179
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'WebServices Versi'#243'n: 3.0.2 '
  ClientHeight = 709
  ClientWidth = 878
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 16
    Top = 464
    Width = 399
    Height = 26
    Caption = 'SERVICIO DE FACTURA ELECTRONICA OFFLINE'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -21
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 432
    Top = 504
    Width = 42
    Height = 13
    Caption = '09:00:00'
  end
  object Label6: TLabel
    Left = 504
    Top = 504
    Width = 42
    Height = 13
    Caption = '21:00:00'
  end
  object Label7: TLabel
    Left = 64
    Top = 568
    Width = 83
    Height = 13
    Caption = 'Nro Comprobante'
  end
  object Label8: TLabel
    Left = 192
    Top = 568
    Width = 53
    Height = 13
    Caption = 'Tipo comp.'
  end
  object Button5: TButton
    Left = 345
    Top = 326
    Width = 75
    Height = 25
    Caption = '1'
    TabOrder = 0
    Visible = False
    OnClick = Button5Click
  end
  object Memo1: TMemo
    Left = 1
    Top = 7
    Width = 680
    Height = 305
    Color = clBlack
    Font.Charset = ANSI_CHARSET
    Font.Color = clLime
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
  end
  object Button8: TButton
    Left = 392
    Top = 320
    Width = 75
    Height = 25
    Caption = 'Button8'
    TabOrder = 2
    Visible = False
    OnClick = Button8Click
  end
  object Button11: TButton
    Left = 428
    Top = 326
    Width = 97
    Height = 25
    Caption = 'text'
    TabOrder = 3
    Visible = False
    OnClick = Button11Click
  end
  object BitBtn1: TBitBtn
    Left = 688
    Top = 14
    Width = 145
    Height = 33
    Caption = 'INICIAR'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 688
    Top = 54
    Width = 145
    Height = 33
    Caption = 'PARAR'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = BitBtn2Click
  end
  object BitBtn3: TBitBtn
    Left = 688
    Top = 94
    Width = 145
    Height = 33
    Caption = 'DESCARGAR  POR LOTE'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = BitBtn3Click
  end
  object BitBtn4: TBitBtn
    Left = 688
    Top = 134
    Width = 145
    Height = 33
    Caption = 'POR FECHA TURNO HOY'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = BitBtn4Click
  end
  object BitBtn5: TBitBtn
    Left = 752
    Top = 672
    Width = 113
    Height = 33
    Caption = 'CERRAR'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    OnClick = BitBtn5Click
  end
  object BitBtn6: TBitBtn
    Left = 688
    Top = 203
    Width = 145
    Height = 25
    Caption = 'PROXIMOS NRO'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = BitBtn6Click
  end
  object BitBtn7: TBitBtn
    Left = 688
    Top = 172
    Width = 145
    Height = 25
    Caption = 'Arregla codcliente=0'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    OnClick = BitBtn7Click
  end
  object BitBtn8: TBitBtn
    Left = 688
    Top = 360
    Width = 169
    Height = 25
    Caption = 'Obtener los no facturados del dia'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    OnClick = BitBtn8Click
  end
  object BitBtn10: TBitBtn
    Left = 688
    Top = 328
    Width = 169
    Height = 25
    Caption = 'Obtener todos los no facturados'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    OnClick = BitBtn10Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 320
    Width = 313
    Height = 129
    Caption = 'DESCARGAR TURNO POR PATENTE'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    object Label2: TLabel
      Left = 8
      Top = 16
      Width = 43
      Height = 14
      Caption = 'PATENTE'
    end
    object Label3: TLabel
      Left = 136
      Top = 16
      Width = 48
      Height = 14
      Caption = 'TURNOID'
    end
    object Edit2: TEdit
      Left = 8
      Top = 32
      Width = 121
      Height = 37
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'EDIT2'
    end
    object Edit3: TEdit
      Left = 136
      Top = 32
      Width = 169
      Height = 37
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'Edit3'
    end
    object BitBtn11: TBitBtn
      Left = 96
      Top = 88
      Width = 75
      Height = 25
      Caption = 'DESCARGAR'
      TabOrder = 2
      OnClick = BitBtn11Click
    end
  end
  object BitBtn12: TBitBtn
    Left = 368
    Top = 424
    Width = 145
    Height = 25
    Caption = 'TEST PAGOS'
    TabOrder = 14
    Visible = False
    OnClick = BitBtn12Click
  end
  object Button2: TButton
    Left = 352
    Top = 384
    Width = 75
    Height = 25
    Caption = 'flota'
    TabOrder = 15
    Visible = False
    OnClick = Button2Click
  end
  object BitBtn13: TBitBtn
    Left = 264
    Top = 584
    Width = 169
    Height = 25
    Caption = 'Generar PDF'
    TabOrder = 16
    OnClick = BitBtn13Click
  end
  object DateTimePicker1: TDateTimePicker
    Left = 440
    Top = 392
    Width = 89
    Height = 21
    Date = 42768.454210752320000000
    Time = 42768.454210752320000000
    TabOrder = 17
    Visible = False
  end
  object Button1: TButton
    Left = 608
    Top = 432
    Width = 75
    Height = 25
    Caption = 'FERIADOS'
    TabOrder = 18
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 16
    Top = 496
    Width = 145
    Height = 25
    Caption = 'informar factura'
    TabOrder = 19
    OnClick = Button3Click
  end
  object Edit4: TEdit
    Left = 537
    Top = 436
    Width = 65
    Height = 21
    TabOrder = 20
    Text = 'Edit4'
  end
  object Memo2: TMemo
    Left = 160
    Top = -32
    Width = 353
    Height = 201
    Lines.Strings = (
      'Memo2')
    TabOrder = 21
    Visible = False
  end
  object Memo3: TMemo
    Left = 240
    Top = 120
    Width = 361
    Height = 201
    Lines.Strings = (
      'Memo3')
    TabOrder = 22
    Visible = False
  end
  object DateTimePicker2: TDateTimePicker
    Left = 336
    Top = 520
    Width = 89
    Height = 21
    Date = 42797.647107523150000000
    Time = 42797.647107523150000000
    TabOrder = 23
  end
  object Edit5: TEdit
    Left = 424
    Top = 520
    Width = 81
    Height = 21
    TabOrder = 24
  end
  object BitBtn14: TBitBtn
    Left = 584
    Top = 512
    Width = 105
    Height = 25
    Caption = 'Descargar Pagos'
    TabOrder = 25
    OnClick = BitBtn14Click
  end
  object Edit6: TEdit
    Left = 504
    Top = 520
    Width = 81
    Height = 21
    TabOrder = 26
  end
  object Edit7: TEdit
    Left = 64
    Top = 584
    Width = 121
    Height = 21
    TabOrder = 27
  end
  object ComboBox1: TComboBox
    Left = 192
    Top = 584
    Width = 73
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 28
    Items.Strings = (
      'FA'
      'FB'
      'CA'
      'CB')
  end
  object BitBtn15: TBitBtn
    Left = 16
    Top = 536
    Width = 161
    Height = 25
    Caption = 'Renviar mail'
    TabOrder = 29
    OnClick = BitBtn15Click
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 624
    Width = 425
    Height = 73
    TabOrder = 30
    object Label9: TLabel
      Left = 8
      Top = 16
      Width = 125
      Height = 13
      Caption = 'EXTERNAL REFERENCE'
    end
    object Edit8: TEdit
      Left = 8
      Top = 32
      Width = 169
      Height = 27
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object BitBtn16: TBitBtn
      Left = 184
      Top = 32
      Width = 75
      Height = 25
      Caption = 'BAJAR'
      TabOrder = 1
      OnClick = BitBtn16Click
    end
    object Button4: TButton
      Left = 280
      Top = 32
      Width = 75
      Height = 25
      Caption = 'excel'
      TabOrder = 2
      OnClick = Button4Click
    end
  end
  object Button7: TButton
    Left = 704
    Top = 424
    Width = 129
    Height = 25
    Caption = 'Actualizar turnos=0'
    TabOrder = 31
    OnClick = Button7Click
  end
  object Button6: TButton
    Left = 696
    Top = 392
    Width = 153
    Height = 25
    Caption = 'Pone Facturado el turno'
    TabOrder = 32
    OnClick = Button6Click
  end
  object BitBtn17: TBitBtn
    Left = 704
    Top = 456
    Width = 129
    Height = 25
    Caption = 'LIMPIAR DIRECTORIO'
    TabOrder = 33
    OnClick = BitBtn17Click
  end
  object BitBtn18: TBitBtn
    Left = 704
    Top = 488
    Width = 137
    Height = 25
    Caption = 'Consultar'
    TabOrder = 34
    OnClick = BitBtn18Click
  end
  object BitBtn19: TBitBtn
    Left = 632
    Top = 560
    Width = 233
    Height = 25
    Caption = 'GENERAR TODOS LOS PDF FALTANTES'
    TabOrder = 35
    OnClick = BitBtn19Click
  end
  object Button9: TButton
    Left = 712
    Top = 528
    Width = 137
    Height = 25
    Caption = 'descarga dia completo'
    TabOrder = 36
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 664
    Top = 600
    Width = 185
    Height = 25
    Caption = 'FACTURAR TODOS LOS PAGOS'
    TabOrder = 37
    OnClick = Button10Click
  end
  object BitBtn21: TBitBtn
    Left = 456
    Top = 664
    Width = 241
    Height = 25
    Caption = 'INFORMAR TODOS LOS NO INFORMADOS'
    TabOrder = 38
    OnClick = BitBtn21Click
  end
  object DateTimePicker3: TDateTimePicker
    Left = 472
    Top = 640
    Width = 186
    Height = 21
    Date = 43012.377786805550000000
    Time = 43012.377786805550000000
    TabOrder = 39
  end
  object BitBtn22: TBitBtn
    Left = 664
    Top = 640
    Width = 169
    Height = 25
    Caption = 'Descargar turnos por fecha'
    TabOrder = 40
    OnClick = BitBtn22Click
  end
  object BitBtn9: TBitBtn
    Left = 688
    Top = 248
    Width = 145
    Height = 25
    Caption = 'Procesar XML'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 41
    OnClick = BitBtn9Click
  end
  object TIMENOVEDAD: TTimer
    Enabled = False
    OnTimer = TIMENOVEDADTimer
    Left = 272
    Top = 40
  end
  object OpenDialog1: TOpenDialog
    Left = 41
    Top = 223
  end
  object timepagos: TTimer
    Enabled = False
    OnTimer = timepagosTimer
    Left = 360
    Top = 368
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3600000
    OnTimer = Timer1Timer
    Left = 160
    Top = 472
  end
  object Timer2: TTimer
    Left = 56
    Top = 88
  end
  object enviarmail: TTimer
    Enabled = False
    Interval = 72000
    OnTimer = enviarmailTimer
    Left = 464
    Top = 576
  end
  object Excel: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 528
    Top = 552
  end
  object Timer3: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = Timer3Timer
    Left = 608
    Top = 592
  end
  object Cliente: TIdUDPClient
    Port = 0
    Left = 720
    Top = 496
  end
  object HTTPRIO1: THTTPRIO
    WSDLLocation = 'https://sandbox.epagos.com.ar/wsdl/index.php?wsdl'#39
    Service = 'EPagos'
    Port = 'EPagosPort'
    HTTPWebNode.Agent = 'Borland SOAP 1.2'
    HTTPWebNode.UseUTF8InHeader = False
    HTTPWebNode.InvokeOptions = [soIgnoreInvalidCerts, soAutoCheckAccessPointViaUDDI]
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soCacheMimeResponse, soUTF8EncodeXML]
    Left = 568
    Top = 552
  end
  object OpenDialog2: TOpenDialog
    Filter = 'XML|*.xml'
    Left = 848
    Top = 248
  end
end
