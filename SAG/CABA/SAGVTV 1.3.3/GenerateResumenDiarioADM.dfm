object ResumenDiarioADM: TResumenDiarioADM
  Left = 381
  Top = 81
  Width = 833
  Height = 577
  Caption = 'Resumen Diario'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel_MP: TBevel
    Left = 16
    Top = 113
    Width = 521
    Height = 102
  end
  object BevelMP: TBevel
    Left = 8
    Top = 78
    Width = 537
    Height = 142
  end
  object Bevel_EP: TBevel
    Left = 16
    Top = 267
    Width = 521
    Height = 102
  end
  object BevelEP: TBevel
    Left = 8
    Top = 227
    Width = 537
    Height = 148
  end
  object BevelTotalGeneral: TBevel
    Left = 16
    Top = 419
    Width = 521
    Height = 97
  end
  object BevelGlobal: TBevel
    Left = 8
    Top = 381
    Width = 537
    Height = 145
  end
  object Bevel_ServiciosPendientesMP: TBevel
    Left = 552
    Top = 266
    Width = 257
    Height = 126
  end
  object Bevel_ServiciosPrestadosMP: TBevel
    Left = 552
    Top = 104
    Width = 257
    Height = 126
  end
  object Label1: TLabel
    Left = 602
    Top = 106
    Width = 40
    Height = 19
    Caption = 'Autos'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 674
    Top = 106
    Width = 44
    Height = 19
    Caption = 'Motos'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 602
    Top = 268
    Width = 40
    Height = 19
    Caption = 'Autos'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 674
    Top = 268
    Width = 44
    Height = 19
    Caption = 'Motos'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 557
    Top = 425
    Width = 247
    Height = 85
  end
  object Label5: TLabel
    Left = 599
    Top = 426
    Width = 40
    Height = 19
    Caption = 'Autos'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 671
    Top = 426
    Width = 44
    Height = 19
    Caption = 'Motos'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBServiciosPrestados: TRxDBGrid
    Tag = 2
    Left = 0
    Top = 46
    Width = 817
    Height = 493
    Align = alClient
    Color = 12123386
    Ctl3D = True
    DataSource = DSTServiciosPrestados
    FixedColor = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 91
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    FixedCols = 1
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'FECHA_FACTURA'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'COD_FACTURA'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'PAGOID'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODIGOPAGO'
        Title.Caption = 'CODIGO PAGO'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'FORMA_PAGO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ENTIDAD'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TIPO_FACTURA'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'NRO_COMPROBANTE'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CLIENTE'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IMPORTE_NETO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IVA'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IIBB'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TOTAL'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ANULADA'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ARCHIVOENVIADO'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'FECHA_TURNO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TURNO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'PATENTE'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TIPO_VEHICULO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'VERIFICO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'FECHA_INSPECCION'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'INSPECCION'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end>
  end
  object TAutosMP: TStaticText
    Left = 24
    Top = 137
    Width = 48
    Height = 23
    Caption = 'Autos:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object TMotosMP: TStaticText
    Left = 24
    Top = 185
    Width = 52
    Height = 23
    Caption = 'Motos:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object Cantidad_Autos_MP: TEdit
    Left = 80
    Top = 137
    Width = 73
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object Cantidad_Motos_MP: TEdit
    Left = 80
    Top = 185
    Width = 73
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
  object ImporteAutoMP: TLabeledEdit
    Left = 168
    Top = 137
    Width = 73
    Height = 21
    EditLabel.Width = 55
    EditLabel.Height = 19
    EditLabel.BiDiMode = bdLeftToRight
    EditLabel.Caption = 'Importe'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentBiDiMode = False
    EditLabel.ParentFont = False
    EditLabel.Layout = tlCenter
    ReadOnly = True
    TabOrder = 4
  end
  object IVAAutoMP: TLabeledEdit
    Left = 256
    Top = 137
    Width = 73
    Height = 21
    EditLabel.Width = 22
    EditLabel.Height = 19
    EditLabel.Caption = 'IVA'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    ReadOnly = True
    TabOrder = 5
  end
  object IIBBAutoMP: TLabeledEdit
    Left = 344
    Top = 137
    Width = 73
    Height = 21
    EditLabel.Width = 26
    EditLabel.Height = 19
    EditLabel.Caption = 'IIBB'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    ReadOnly = True
    TabOrder = 6
  end
  object MontoTotalAutoMP: TLabeledEdit
    Left = 432
    Top = 137
    Width = 89
    Height = 21
    EditLabel.Width = 85
    EditLabel.Height = 19
    EditLabel.Caption = 'Monto Total'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    ReadOnly = True
    TabOrder = 7
  end
  object ImporteMotoMP: TLabeledEdit
    Left = 168
    Top = 185
    Width = 73
    Height = 21
    EditLabel.Width = 55
    EditLabel.Height = 19
    EditLabel.Caption = 'Importe'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    ReadOnly = True
    TabOrder = 8
  end
  object IVAMotoMP: TLabeledEdit
    Left = 256
    Top = 185
    Width = 73
    Height = 21
    EditLabel.Width = 22
    EditLabel.Height = 19
    EditLabel.Caption = 'IVA'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 9
  end
  object IIBBMotoMP: TLabeledEdit
    Left = 344
    Top = 185
    Width = 73
    Height = 21
    EditLabel.Width = 26
    EditLabel.Height = 19
    EditLabel.Caption = 'IIBB'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    ReadOnly = True
    TabOrder = 10
  end
  object MontoTotalMotoMP: TLabeledEdit
    Left = 432
    Top = 185
    Width = 89
    Height = 21
    EditLabel.Width = 85
    EditLabel.Height = 19
    EditLabel.Caption = 'Monto Total'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    ReadOnly = True
    TabOrder = 11
  end
  object StaticText1: TStaticText
    Left = 16
    Top = 82
    Width = 117
    Height = 27
    Caption = 'Mercado Pago'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
  end
  object TAutoEP: TStaticText
    Left = 24
    Top = 291
    Width = 48
    Height = 23
    Caption = 'Autos:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
  end
  object TMotoEP: TStaticText
    Left = 24
    Top = 339
    Width = 52
    Height = 23
    Caption = 'Motos:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 14
  end
  object Cantidad_Autos_EP: TEdit
    Left = 80
    Top = 291
    Width = 73
    Height = 21
    ReadOnly = True
    TabOrder = 15
  end
  object Cantidad_Motos_EP: TEdit
    Left = 80
    Top = 339
    Width = 73
    Height = 21
    ReadOnly = True
    TabOrder = 16
  end
  object ImporteAutoEP: TLabeledEdit
    Left = 168
    Top = 291
    Width = 73
    Height = 21
    EditLabel.Width = 55
    EditLabel.Height = 19
    EditLabel.BiDiMode = bdLeftToRight
    EditLabel.Caption = 'Importe'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentBiDiMode = False
    EditLabel.ParentFont = False
    EditLabel.Layout = tlCenter
    ReadOnly = True
    TabOrder = 17
  end
  object IVAAutoEP: TLabeledEdit
    Left = 256
    Top = 291
    Width = 73
    Height = 21
    EditLabel.Width = 22
    EditLabel.Height = 19
    EditLabel.Caption = 'IVA'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    ReadOnly = True
    TabOrder = 18
  end
  object IIBBAutoEP: TLabeledEdit
    Left = 344
    Top = 291
    Width = 73
    Height = 21
    EditLabel.Width = 26
    EditLabel.Height = 19
    EditLabel.Caption = 'IIBB'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    ReadOnly = True
    TabOrder = 19
  end
  object MontoTotalAutoEP: TLabeledEdit
    Left = 432
    Top = 291
    Width = 89
    Height = 21
    EditLabel.Width = 85
    EditLabel.Height = 19
    EditLabel.Caption = 'Monto Total'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    ReadOnly = True
    TabOrder = 20
  end
  object ImporteMotoEP: TLabeledEdit
    Left = 168
    Top = 339
    Width = 73
    Height = 21
    EditLabel.Width = 55
    EditLabel.Height = 19
    EditLabel.Caption = 'Importe'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    ReadOnly = True
    TabOrder = 21
  end
  object IVAMotoEP: TLabeledEdit
    Left = 256
    Top = 339
    Width = 73
    Height = 21
    EditLabel.Width = 22
    EditLabel.Height = 19
    EditLabel.Caption = 'IVA'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 22
  end
  object IIBBMotoEP: TLabeledEdit
    Left = 344
    Top = 339
    Width = 73
    Height = 21
    EditLabel.Width = 26
    EditLabel.Height = 19
    EditLabel.Caption = 'IIBB'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    ReadOnly = True
    TabOrder = 23
  end
  object MontoTotalMotoEP: TLabeledEdit
    Left = 432
    Top = 339
    Width = 89
    Height = 21
    EditLabel.Width = 85
    EditLabel.Height = 19
    EditLabel.Caption = 'Monto Total'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    ReadOnly = True
    TabOrder = 24
  end
  object StaticText6: TStaticText
    Left = 16
    Top = 234
    Width = 51
    Height = 27
    Caption = 'Epago'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 25
  end
  object TPagos: TStaticText
    Left = 216
    Top = 49
    Width = 120
    Height = 27
    Caption = 'FACTURACION'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 26
  end
  object TServiciosPrestados: TStaticText
    Left = 588
    Top = 49
    Width = 184
    Height = 27
    Caption = 'SERVICIOS PRESTADOS'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 27
  end
  object TotalGlobal: TStaticText
    Left = 16
    Top = 387
    Width = 127
    Height = 27
    Caption = 'Total Facturado'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 28
  end
  object TAutosGlobal: TStaticText
    Left = 24
    Top = 443
    Width = 48
    Height = 23
    Caption = 'Autos:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 29
  end
  object TMotosGlobal: TStaticText
    Left = 24
    Top = 491
    Width = 52
    Height = 23
    Caption = 'Motos:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 30
  end
  object Cantidad_Autos_Global: TEdit
    Left = 80
    Top = 443
    Width = 73
    Height = 21
    ReadOnly = True
    TabOrder = 31
  end
  object Cantidad_Motos_Global: TEdit
    Left = 80
    Top = 491
    Width = 73
    Height = 21
    ReadOnly = True
    TabOrder = 32
  end
  object ImporteAutosGlobal: TLabeledEdit
    Left = 168
    Top = 443
    Width = 73
    Height = 21
    EditLabel.Width = 55
    EditLabel.Height = 19
    EditLabel.BiDiMode = bdLeftToRight
    EditLabel.Caption = 'Importe'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentBiDiMode = False
    EditLabel.ParentFont = False
    EditLabel.Layout = tlCenter
    ReadOnly = True
    TabOrder = 33
  end
  object IVAAutosGlobal: TLabeledEdit
    Left = 256
    Top = 443
    Width = 73
    Height = 21
    EditLabel.Width = 22
    EditLabel.Height = 19
    EditLabel.Caption = 'IVA'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    ReadOnly = True
    TabOrder = 34
  end
  object IIBBAutosGlobal: TLabeledEdit
    Left = 344
    Top = 443
    Width = 73
    Height = 21
    EditLabel.Width = 26
    EditLabel.Height = 19
    EditLabel.Caption = 'IIBB'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    ReadOnly = True
    TabOrder = 35
  end
  object MontoAutosGlobal: TLabeledEdit
    Left = 432
    Top = 443
    Width = 89
    Height = 21
    EditLabel.Width = 85
    EditLabel.Height = 19
    EditLabel.Caption = 'Monto Total'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    ReadOnly = True
    TabOrder = 36
  end
  object ImporteMotosGlobal: TLabeledEdit
    Left = 168
    Top = 491
    Width = 73
    Height = 21
    EditLabel.Width = 55
    EditLabel.Height = 19
    EditLabel.Caption = 'Importe'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    ReadOnly = True
    TabOrder = 37
  end
  object IVAMotosGlobal: TLabeledEdit
    Left = 256
    Top = 491
    Width = 73
    Height = 21
    EditLabel.Width = 22
    EditLabel.Height = 19
    EditLabel.Caption = 'IVA'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 38
  end
  object IIBBMotosGlobal: TLabeledEdit
    Left = 344
    Top = 491
    Width = 73
    Height = 21
    EditLabel.Width = 26
    EditLabel.Height = 19
    EditLabel.Caption = 'IIBB'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    ReadOnly = True
    TabOrder = 39
  end
  object MontoMotosGlobal: TLabeledEdit
    Left = 432
    Top = 491
    Width = 89
    Height = 21
    EditLabel.Width = 85
    EditLabel.Height = 19
    EditLabel.Caption = 'Monto Total'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Calibri'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    ReadOnly = True
    TabOrder = 40
  end
  object TServiciosPendientes: TStaticText
    Left = 588
    Top = 237
    Width = 188
    Height = 27
    Caption = 'SERVICIOS PENDIENTES'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 41
  end
  object SBarPrincipal: TSpeedBar
    Left = 0
    Top = 0
    Width = 817
    Height = 46
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    BoundLines = [blLeft, blRight]
    Options = [sbAllowDrag, sbAllowResize, sbFlatBtns, sbGrayedBtns, sbStretchBitmap]
    BtnOffsetHorz = 3
    BtnOffsetVert = 3
    BtnWidth = 40
    BtnHeight = 40
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Locked = True
    TabOrder = 42
    InternalVer = 1
    object SpeedbarSection1: TSpeedbarSection
      Caption = 'Salidas'
    end
    object SpeedbarSection2: TSpeedbarSection
      Caption = 'Busqueda'
    end
    object SpeedbarSection3: TSpeedbarSection
      Caption = 'Exit'
    end
    object BExcel: TSpeedItem
      Caption = 'Excel'
      Glyph.Data = {
        F6020000424DF602000000000000760000002800000023000000200000000100
        0400000000008002000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFF00000FFF800000000000000000000FFFFFFFFFFF0
        0000FFF8FFFFFFFFFFFFFFFFFFF0FFFFFFFFFFF00000FFF8F777777777777777
        7770FFFFFFFFFFF00000FFF8FFFFFFFFFF8000000000000000000FF00000FFF8
        F777777FFF8FFFF7FFFFFFFFFFFF0FF00000FFF8F7FFFF7F778F77F7F77F777F
        777F0FF00000FFF8F7FF7F7FFF8FFFF7FFFFFFFFFFFF0FF00000FFF8F7FFFF7F
        778F77F7F77F777F777F0FF00000FFF8F777777FFF8FFFF7FFFFFFFFFFFF0FF0
        0000FFF8FFFFFFFFFF8F77F7F77F777F777F0FF00000FFF8FFF80000008FFFF7
        FFFFFFFFFFFF0FF00000FFFCCCC8FFFFFF8F77F7F77F777F777F0FF00000FFFC
        7CC8FFFFFF8FFFF7FFFFFFFFFFFF0FF00000FFFCCCC8F77777CCCCCCCCCCCCCC
        CCCCCFF00000FFFFFFF8FFFFFFC7CCCCCCCCCCCCC777CFF00000FFFFFFF8F777
        77CCCCCCCCCCCCCCCCCCCFF00000FFFFFFF8FFFFFFFFFFFFFFFFFFF0FFFFFFF0
        0000FFFFFFF8F77777F77777F77777F0FFFFFFF00000FFFFFFF8FFFFFF00000F
        FFFFFFF0FFFFFFF00000FFF0000000000066660FF77777F0FFFFFFF00000FFF0
        8888888806EEF0FFFFFFFFF0FFFFFFF00000FFFF0E6666606EEF077FF77777F0
        FFFFFFF00000FFFFF0E66606EEF060FFFFFFFFF0FFFFFFF00000FFFFFF0E606E
        EF0000FFF77777F0FFFFFFF00000FFFFFFF006EEF0FFFFFFFFFFFFF0FFFFFFF0
        0000FFFFFFF06EEF00CCCCCCCCCCCCCCFFFFFFF00000FFFFFF06EEF0680CCCCC
        CCCC777CFFFFFFF00000FFFFF06EEF0E6680CCCCCCCCCCCCFFFFFFF00000FFFF
        06EEF0F0E6680FFFFFFFFFFFFFFFFFF00000FFF0FFFF0FFF0EEEE0FFFFFFFFFF
        FFFFFFF00000FFF00000FFFFF00000FFFFFFFFFFFFFFFFF00000}
      Hint = 'Excel|'
      Layout = blGlyphLeft
      Spacing = 1
      Left = 83
      Top = 3
      Visible = True
      OnClick = BExcelClick
      SectionName = 'Salidas'
    end
    object SBBusqueda: TSpeedItem
      Tag = 3
      Caption = 'Buscar'
      Glyph.Data = {
        32030000424D3203000000000000760000002800000022000000230000000100
        040000000000BC02000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF000000FF000000000000000000000000000FFFFF00
        0000F8888888888888888888884EEC0880FFFF000000F8F88888888888888888
        84EEEC08880FFF000000F8F777777777777777774EEECC088880FF000000F8F7
        2227777777777774EEECC07888880F000000F8F7A22777777777774EEECC0078
        88880F000000F8F7AA277777777774EEECC0887888880F000000F8F777777777
        77774EEECC07777888880F000000F8FFFFFFFFFFFFF4EEECC0FFFFFF88880F00
        0000FF8888888888884EEECC0888888888880F000000FFFF000000000000ECC0
        0000000888880F000000FFFF8800000088F70C088888888088880F000000FFFF
        0077777700788077777777880888FF000000FFF87777777777080FFFFFFFF788
        80FFFF000000FF8777778787877044444444F78880FFFF000000FF8777787878
        78704C4C4C44F78880FFFF000000F87F77778787878704C4C4C4F78880FFFF00
        0000F87F7778787878770CCC4C44F78880FFFF000000F87F7777878787870CCC
        C4C4F78880FFFF000000F87F77787878787706CCCC44F78880FFFF000000F87F
        7777878787870C6CC4C4F78880FFFF000000FF8777787878787086CCCC44F788
        80FFFF000000FF877777878787708C6CC4C4F78880FFFF000000FFF877787878
        7708C6CCCC44F78880FFFF000000FFFF88777777006C6CCCC4C4F78880FFFF00
        0000FFFF8F888884444444444444F78880FFFF000000FFFF8F77777777777777
        7777778880FFFF000000FFFF8F777777777777777777778880FFFF000000FFFF
        F8FFFFFFFFFFFFFFFFFFFF8880FFFF000000FFFFFF8777777777777777777778
        80FFFF000000FFFFFFF87777777777777777777780FFFF000000FFFFFFFF8888
        88888888888888888FFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000}
      Hint = 'Buscar'
      Spacing = 1
      Left = 219
      Top = 3
      Visible = True
      OnClick = SBBusquedaClick
      SectionName = 'Busqueda'
    end
    object SBSalir: TSpeedItem
      Caption = 'Salir'
      Glyph.Data = {
        76020000424D7602000000000000760000002800000020000000200000000100
        0400000000000002000000000000000000001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF00000000000000FFFFFFFFFFFFFF0000000000000000
        0033333333333330070000000000000000333333333333080700FFFFFFFFFFFF
        F03333333333308807FFFFFFFFFFFFFFF03333333333088807FFFFFFFFFFFFFF
        F03333333333788807FFFFFFFFFFFFFFF0A333333333788807FFFFFFFFFFFFFF
        F0AAAA333333788807FFFFFFFFFFFFFFF0AAAAAAAAAA788807FFFFFFFFFFFFFF
        F0222AAAAAAA788807FFFFFFFFFFFFFFF022222222AA788807FFFFFFFFFFFFFF
        F022222222227F8807FFFFFFFFFFFFFFF022222222227F8807FFFFFFF00FFFFF
        F055555555557F8807FFFFFFF0A0FFFFF0FFFFFF55557F8807FFFF0000220FFF
        F0FFFFFFFFF57F8807FFFF7A222220FFF0FFFFFFFFFF788807FFFF7A2222220F
        F0FFFFFFFFFF788807FFFF7AAAA220FFF0EEEEEEEEEE788807FFFF7777A20FFF
        F0FFFFFFFFFF788807FFFFFFF7A0FFFFF0EEEEEEEEFF788807FFFFFFF70FFFFF
        F0EEEEEEEEEE788807FFFFFFFFFFFFFFF0FFFFFFFEEE788807FFFFFFFFFFFFFF
        F0FFFFFEEEEE788807FFFFFFFFFFFFFFF0FFEEEEEEEE788807FFFFFFFFFFFFFF
        F0EEEEEEEEEEE78807FFFFFFFFFFFFFFF0EEEEEEEEEEEE7807FFFFFFFFFFFFFF
        F0EEEEEEEEEEEEE707FFFFFFFFFFFFFFF00000000000000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Hint = 'Salir de la Ventana'
      Spacing = 1
      Left = 739
      Top = 3
      Visible = True
      OnClick = SBSalirClick
      SectionName = 'Exit'
    end
  end
  object MP: TStaticText
    Left = 560
    Top = 125
    Width = 27
    Height = 23
    Caption = 'MP'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 43
  end
  object StaticText2: TStaticText
    Left = 565
    Top = 177
    Width = 21
    Height = 23
    Caption = 'EP'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 44
  end
  object MPAutosServPrestadosCantidad: TEdit
    Left = 592
    Top = 125
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 45
  end
  object MPMotosServPrestadosCantidad: TEdit
    Left = 664
    Top = 125
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 46
  end
  object EPAutosServPrestadosCantidad: TEdit
    Left = 592
    Top = 177
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 47
  end
  object EPMotosServPrestadosCantidad: TEdit
    Left = 664
    Top = 177
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 48
  end
  object StaticText4: TStaticText
    Left = 747
    Top = 107
    Width = 39
    Height = 23
    Caption = 'Total'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 49
  end
  object MPTotalServPrestadosCantidad: TEdit
    Left = 736
    Top = 125
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 50
  end
  object EPTotalServPrestadosCantidad: TEdit
    Left = 736
    Top = 177
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 51
  end
  object StaticText3: TStaticText
    Left = 560
    Top = 287
    Width = 27
    Height = 23
    Caption = 'MP'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 52
  end
  object StaticText5: TStaticText
    Left = 565
    Top = 338
    Width = 21
    Height = 23
    Caption = 'EP'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 53
  end
  object MPAutosServPendientesCantidad: TEdit
    Left = 592
    Top = 287
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 54
  end
  object MPMotosServPendientesCantidad: TEdit
    Left = 664
    Top = 287
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 55
  end
  object EPAutosServPendientesCantidad: TEdit
    Left = 592
    Top = 338
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 56
  end
  object EPMotosServPendientesCantidad: TEdit
    Left = 664
    Top = 338
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 57
  end
  object StaticText7: TStaticText
    Left = 749
    Top = 269
    Width = 39
    Height = 23
    Caption = 'Total'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 58
  end
  object MPTotalServPendientesCantidad: TEdit
    Left = 736
    Top = 287
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 59
  end
  object EPTotalServPendientesCantidad: TEdit
    Left = 736
    Top = 338
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 60
  end
  object EPAutosServPrestadosCash: TEdit
    Left = 592
    Top = 201
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 61
  end
  object EPMotosServPrestadosCash: TEdit
    Left = 664
    Top = 201
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 62
  end
  object EPTotalServPrestadosCash: TEdit
    Left = 736
    Top = 201
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 63
  end
  object MPAutosServPrestadosCash: TEdit
    Left = 592
    Top = 148
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 64
  end
  object MPMotosServPrestadosCash: TEdit
    Left = 664
    Top = 148
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 65
  end
  object MPTotalServPrestadosCash: TEdit
    Left = 736
    Top = 148
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 66
  end
  object StaticText8: TStaticText
    Left = 573
    Top = 148
    Width = 12
    Height = 23
    Caption = '$'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 67
  end
  object StaticText9: TStaticText
    Left = 574
    Top = 201
    Width = 12
    Height = 23
    Caption = '$'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 68
  end
  object MPAutosServPendientesCash: TEdit
    Left = 592
    Top = 311
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 69
  end
  object MPMotosServPendientesCash: TEdit
    Left = 664
    Top = 311
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 70
  end
  object MPTotalServPendientesCash: TEdit
    Left = 736
    Top = 311
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 71
  end
  object EPAutosServPendientesCash: TEdit
    Left = 592
    Top = 361
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 72
  end
  object EPMotosServPendientesCash: TEdit
    Left = 664
    Top = 361
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 73
  end
  object EPTotalServPendientesCash: TEdit
    Left = 736
    Top = 361
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 74
  end
  object StaticText10: TStaticText
    Left = 574
    Top = 311
    Width = 12
    Height = 23
    Caption = '$'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 75
  end
  object StaticText11: TStaticText
    Left = 574
    Top = 359
    Width = 12
    Height = 23
    Caption = '$'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 76
  end
  object StaticText12: TStaticText
    Left = 609
    Top = 397
    Width = 141
    Height = 27
    Caption = 'TOTAL SERVICIOS'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 77
  end
  object TTAutosServCantidad: TEdit
    Left = 589
    Top = 445
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 78
  end
  object TTMotosServCantidad: TEdit
    Left = 661
    Top = 445
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 79
  end
  object StaticText15: TStaticText
    Left = 746
    Top = 427
    Width = 39
    Height = 23
    Caption = 'Total'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 80
  end
  object TTotalServCantidad: TEdit
    Left = 733
    Top = 445
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 81
  end
  object TTAutosServCash: TEdit
    Left = 589
    Top = 469
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 82
  end
  object TTMotosServCash: TEdit
    Left = 661
    Top = 469
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 83
  end
  object TTotalServCash: TEdit
    Left = 733
    Top = 469
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 84
  end
  object StaticText16: TStaticText
    Left = 574
    Top = 469
    Width = 12
    Height = 23
    Caption = '$'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 85
  end
  object StaticText13: TStaticText
    Left = 568
    Top = 444
    Width = 20
    Height = 23
    Caption = 'TT'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 86
  end
  object Flotas: TEdit
    Left = 600
    Top = 79
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 87
  end
  object StaticText14: TStaticText
    Left = 553
    Top = 78
    Width = 48
    Height = 23
    Caption = 'Flotas:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 88
  end
  object NoFlotas: TEdit
    Left = 744
    Top = 79
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 89
  end
  object StaticText17: TStaticText
    Left = 673
    Top = 78
    Width = 72
    Height = 23
    Caption = 'No Flotas:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 90
  end
  object SQLConnection1: TSQLConnection
    Left = 592
    Top = 8
  end
  object SQLQuery1: TSQLQuery
    Params = <>
    Left = 552
    Top = 8
  end
  object DSTServiciosPrestados: TDataSource
    DataSet = QTServiciosPrestados
    Left = 513
    Top = 8
  end
  object sdsQTServiciosPrestados: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 'SELECT * FROM TTMPREPORTEADM ORDER BY FECHA_FACTURA'
    ParamCheck = False
    Params = <>
    Left = 472
    Top = 8
  end
  object dspQTServiciosPrestados: TDataSetProvider
    DataSet = sdsQTServiciosPrestados
    Options = [poIncFieldProps, poAllowCommandText]
    Left = 432
    Top = 8
  end
  object QTServiciosPrestados: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQTServiciosPrestados'
    Left = 392
    Top = 8
  end
  object OpenDialog: TOpenDialog
    Filter = 'Archivos Excel (*.xls)|*.xls|Todos los archivos|*.*'
    Left = 352
    Top = 8
  end
end
