object FrmAltaCertificados: TFrmAltaCertificados
  Left = 637
  Top = 236
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = ' Men'#250' de Alta de Certificados'
  ClientHeight = 207
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
    Height = 207
    Align = alClient
    Caption = 
      ' Ingrese los datos para dar de alta un rango de Nuevos Certifica' +
      'dos'
    TabOrder = 0
    object Label2: TLabel
      Left = 51
      Top = 34
      Width = 170
      Height = 13
      Alignment = taCenter
      Caption = 'N'#186' DE CERTIFICADO INICIAL'
    end
    object Label3: TLabel
      Left = 120
      Top = 107
      Width = 157
      Height = 13
      Alignment = taCenter
      Caption = 'N'#186' DE CERTIFICADO FINAL'
    end
    object Label4: TLabel
      Left = 251
      Top = 34
      Width = 63
      Height = 13
      Caption = 'CANTIDAD'
    end
    object MEObleaFin: TMaskEdit
      Left = 125
      Top = 122
      Width = 149
      Height = 26
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      OnKeyPress = EAnioKeyPress
    end
    object BtnGenerar: TBitBtn
      Left = 16
      Top = 161
      Width = 385
      Height = 33
      Caption = '&GENERAR CERTIFICADOS'
      TabOrder = 3
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
      Left = 61
      Top = 50
      Width = 149
      Height = 26
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnExit = MEObleaIniExit
      OnKeyPress = EAnioKeyPress
    end
    object ECantidad: TEdit
      Left = 242
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
      TabOrder = 1
      OnExit = ECantidadExit
      OnKeyPress = EAnioKeyPress
    end
  end
end