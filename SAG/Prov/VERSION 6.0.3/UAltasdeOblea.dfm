object FrmAltaObleas: TFrmAltaObleas
  Left = 361
  Top = 290
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = ' Men'#250' de Alta de Obleas'
  ClientHeight = 289
  ClientWidth = 401
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Grupo: TGroupBox
    Left = 0
    Top = 0
    Width = 401
    Height = 289
    Align = alClient
    Caption = ' Ingrese los datos para dar de alta un rango de Nuevas Obleas '
    TabOrder = 0
    object Label1: TLabel
      Left = 39
      Top = 33
      Width = 25
      Height = 13
      Caption = 'A'#209'O'
    end
    object Label2: TLabel
      Left = 139
      Top = 34
      Width = 126
      Height = 13
      Alignment = taCenter
      Caption = 'N'#186' DE OBLEA INICIAL'
    end
    object Label3: TLabel
      Left = 144
      Top = 195
      Width = 113
      Height = 13
      Alignment = taCenter
      Caption = 'N'#186' DE OBLEA FINAL'
    end
    object Label4: TLabel
      Left = 291
      Top = 34
      Width = 63
      Height = 13
      Caption = 'CANTIDAD'
    end
    object Sh_Oblea: TShape
      Left = 106
      Top = 85
      Width = 160
      Height = 106
      Brush.Style = bsClear
    end
    object Shape2: TShape
      Left = 266
      Top = 85
      Width = 28
      Height = 106
      Brush.Color = clBlack
    end
    object Label6: TLabel
      Left = 116
      Top = 91
      Width = 140
      Height = 22
      Alignment = taCenter
      Caption = 'REPUBLICA ARGENTINA'#13#10'PROVINCIA DE BUENOS AIRES'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 117
      Top = 116
      Width = 142
      Height = 20
      Caption = 'MINISTERIO DE INFRAESTRUCTURA,'#13#10'VIVIENDA Y SERVICIOS PUBLICOS'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -8
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape1: TShape
      Left = 218
      Top = 142
      Width = 41
      Height = 41
      Brush.Style = bsClear
    end
    object Label5: TLabel
      Left = 112
      Top = 156
      Width = 60
      Height = 30
      Caption = 'Consejo Federal'#13#10'de Seguridad Vial'#13#10'RTO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -8
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Image1: TImage
      Left = 189
      Top = 144
      Width = 25
      Height = 36
      AutoSize = True
      Picture.Data = {
        0954474946496D616765BA03000047494638396119002400F7D7000000003300
        00660000990000CC0000FF0000003300333300663300993300CC3300FF330000
        6600336600666600996600CC6600FF6600009900339900669900999900CC9900
        FF990000CC0033CC0066CC0099CC00CCCC00FFCC0000FF0033FF0066FF0099FF
        00CCFF00FFFF00000033330033660033990033CC0033FF003300333333333366
        3333993333CC3333FF3333006633336633666633996633CC6633FF6633009933
        339933669933999933CC9933FF993300CC3333CC3366CC3399CC33CCCC33FFCC
        3300FF3333FF3366FF3399FF33CCFF33FFFF33000066330066660066990066CC
        0066FF0066003366333366663366993366CC3366FF3366006666336666666666
        996666CC6666FF6666009966339966669966999966CC9966FF996600CC6633CC
        6666CC6699CC66CCCC66FFCC6600FF6633FF6666FF6699FF66CCFF66FFFF6600
        0099330099660099990099CC0099FF0099003399333399663399993399CC3399
        FF3399006699336699666699996699CC6699FF66990099993399996699999999
        99CC9999FF999900CC9933CC9966CC9999CC99CCCC99FFCC9900FF9933FF9966
        FF9999FF99CCFF99FFFF990000CC3300CC6600CC9900CCCC00CCFF00CC0033CC
        3333CC6633CC9933CCCC33CCFF33CC0066CC3366CC6666CC9966CCCC66CCFF66
        CC0099CC3399CC6699CC9999CCCC99CCFF99CC00CCCC33CCCC66CCCC99CCCCCC
        CCCCFFCCCC00FFCC33FFCC66FFCC99FFCCCCFFCCFFFFCC0000FF3300FF6600FF
        9900FFCC00FFFF00FF0033FF3333FF6633FF9933FFCC33FFFF33FF0066FF3366
        FF6666FF9966FFCC66FFFF66FF0099FF3399FF6699FF9999FFCC99FFFF99FF00
        CCFF33CCFF66CCFF99CCFFCCCCFFFFCCFF00FFFF33FFFF66FFFF99FFFFCCFFFF
        FFFFFFFFFFFF0000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000000000000021F9040500
        00D7002C000000001900240000089700B1091C48101BAB6B05132A1CC88A55A0
        40AC164A14E8F0A1C58313095EB3C8D122C2841F056EEC4832624192283B9A24
        98B225C4842E5D86C416D3E5CA9A3605E2944973674A843E519A0C5A52275195
        238F72ACA8F462D3A54F3D467D197568D39B4D435E6549B4E1C99D0D670E140A
        11A258852A332EEC78566DCF872BDD72852B17A6C5BA765FE29D1B682FDFB66E
        AF398CBB3720003B}
      Transparent = True
    end
    object LAnio: TLabel
      Left = 273
      Top = 90
      Width = 12
      Height = 96
      Caption = '2 0 0 7'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object EAnio: TEdit
      Left = 37
      Top = 49
      Width = 81
      Height = 26
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      MaxLength = 4
      ParentFont = False
      TabOrder = 0
      OnExit = EAnioExit
      OnKeyPress = EAnioKeyPress
    end
    object MEObleaFin: TMaskEdit
      Left = 125
      Top = 210
      Width = 151
      Height = 26
      Enabled = False
      EditMask = '00\-000000;0; '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      MaxLength = 9
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      OnKeyPress = EAnioKeyPress
    end
    object BtnGenerar: TBitBtn
      Left = 8
      Top = 249
      Width = 385
      Height = 33
      Caption = '&GENERAR OBLEAS'
      TabOrder = 4
      OnClick = BtnGenerarClick
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF423031B5
        9A9CBDA6A5BDA2A5BDA2A5BD9E9CBD9E9CB59A9CB59A9CB59694B59694B59294
        B58E8CB58E8CAD8A8CA5797B181010FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF4A3C39E7DFDEF7EFEFE7D7D6EFE7E7FFFFFFFFFBFFEFEBEFFFF7F7FF
        F7F7FFF7F7FFF7F7FFF3F7F7F3F7DECBC6D6BEBD211410FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF4A3C39E7CFC6EFA229EFB208DEA67BEFEBEFEFB6
        94DE9E6BDECFCEF7F3F7FFF7F7F7F3F7F7F3F7F7F3F7DEC3BDD6C3C6211410FF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF0800004A4142E7C7B5F7C308FFCF00
        EF9A08DEA284EFB208FFD700DE9231E7D3D6F7F3F7F7F3F7F7F3F7F7EFEFEFE3
        DED6C3C6211818FF00FFFF00FFFF00FFFF00FFFF00FF633C108449105A3831D6
        9A5AFFC300FF9600FF9600FFD700FFDF00FFB600FF9600D69673EFEBEFF7F3F7
        F7EFEFF7EFEFDEC7C6D6C3C6211818FF00FFFF00FFFF00FFFF00FF4A3010F7B6
        10FFC700EFA610FFCF00FFC700FF9600FF9600FFA600FFAA00FF9600F78A00DE
        8621DEBEB5EFE7E7F7EFEFF7EBEFDEC7C6D6C3C6211818FF00FFFF00FFFF00FF
        FF00FF845118FFB600FF9E00FFAA00FFAE00FF9A00FF9600FF9600FF9600FF96
        00FF9600FFA600FFBA00E78A21E7D7D6F7EBEFF7EBEFEFDFDED6C3C6211818FF
        00FFFF00FFFF00FFFF00FF392008F79A10FF9E00FF9E00FF9E00FF9E08FFB242
        FFCB84FFD394FFC35AFFA610FF9E00FFA200F78600E7CFC6F7EBEFF7EBEFDEC7
        C6DEC3C6211818FF00FFFF00FF7B7D7B4A2C10734518F79210FFA200FFA600FF
        A621F7D7B5FFF7F7FFF7F7F7F3F7F7F3E7FFD75AFFAA08FF9E00E79652F7E3DE
        F7EBEFF7E7E7DECFCEDEC3C6211C18FF00FFFF00FF948E84F78E21FF7D00FF86
        00FFAE00F7A610F7DBC6FFFFFFFFFBFFFFF3F7F7F3F7FFEFCEFFE75AFFBA21EF
        9208D6B6ADEFE7E7F7E7E7F7E7E7E7DBD6D6C3C6211C18FF00FFFF00FF9C968C
        FF9218FF9E00FFAE00FFB600CE8E52EFE7E7FFFFFFFFFFFFFFFFFFFFF7F7F7E3
        84FFDF52FFBE21FFAE00E79652F7E7E7F7E7E7EFE7E7DECBC6DEC3C6211C18FF
        00FFFF00FF948E84F7A621FFC300FFC300F7B208845D4AEFE7E7FFFFFFFFFFFF
        F7F7F7EFD394EFC34AF7C34AFFBA08F7A210EFC3ADF7E7E7EFE7E7EFE3E7E7D3
        D6DEC3C6291C18FF00FFFF00FFFF00FF946D31F7A639FFBA00F7B608BD8242D6
        C3B5E7DBD6E7CBADE7AE63E7A639E7A642F7BA29EFA652F7EBE7F7EBEFEFE7E7
        EFE3E7EFE3E7E7D3D6DEC3C6291C18FF00FFFF00FFFF00FF292010FF8618FFAA
        00FFCF00DE8A21D68631D68631D68631D68631DE8E31F7B621FFC708E7BA9CF7
        F3F7F7EFEFF7E7E7EFE3E7EFDFDEDECFCEDEC7C6292021FF00FFFF00FFFF00FF
        181408FFB229FFD700FFD708FFCF00E79A18DE8221DE8621EFA221F7BE18F7BA
        42F7B242F7E7DEF7F3F7F7EFEFF7EBEFEFE3E7EFDFDEE7DBD6DEC7C6292021FF
        00FFFF00FFFF00FFFF00FF735929BD9631B58239FFBE00FFDF00FFD310FFD708
        FFDB00F7CB9CFFFFFFFFF7F7FFF7F7F7F3F7DECFCED6BEBDCEBABDCEBABDCEB6
        B5C6AAAD292021FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF634921F7C321FF
        CB52FFEFDEF7CF84F7D394FFF7F7FFFFFFFFFBFFFFF7F7F7F3F7D6C3C6F7F3F7
        F7F3F7F7EFEFDECFCE846D6BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF635D52F7EBE7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFF7F7F7
        F3F7D6C7C6FFFFFFFFFBFFEFDFDE8C797B000400FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF5A5552F7EFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFBFFFFF7F7F7F3F7D6C7C6FFFBFFEFDFDE948684080400FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5A595AF7EFEFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFBFFFFF7F7F7F3F7D6CBCEEFE3E79C8A8C080808FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5A595AEF
        EFEFFFFBFFFFFBFFFFFBFFFFFBFFFFFBFFF7F7F7F7F3F7F7EFEFD6C7C6A59294
        080808FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF313031848284848284848284847D7B847D7B84797B7B797B7B75737B
        7573736D6B080C08FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    end
    object MEObleaIni: TMaskEdit
      Left = 125
      Top = 50
      Width = 151
      Height = 26
      EditMask = '00\-000000;0; '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      MaxLength = 9
      ParentFont = False
      TabOrder = 1
      OnExit = MEObleaIniExit
      OnKeyPress = EAnioKeyPress
    end
    object ECantidad: TEdit
      Left = 282
      Top = 50
      Width = 83
      Height = 26
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      MaxLength = 4
      ParentFont = False
      TabOrder = 2
      OnExit = ECantidadExit
      OnKeyPress = EAnioKeyPress
    end
  end
end
