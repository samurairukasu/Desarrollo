object Form1: TForm1
  Left = 362
  Top = 259
  Hint = 'STOP  !!!'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 263
  ClientWidth = 522
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 431
    Top = 8
    Width = 82
    Height = 13
    Caption = 'Buscar en WS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 7
    Top = 216
    Width = 121
    Height = 42
    Caption = 'INICIAR'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 425
    Height = 209
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
  object Button1: TButton
    Left = 143
    Top = 216
    Width = 120
    Height = 42
    Caption = 'PARAR'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 272
    Top = 216
    Width = 75
    Height = 25
    Caption = 'SISTEMA'
    TabOrder = 3
    Visible = False
    OnClick = Button2Click
  end
  object BuscarPatente: TEdit
    Left = 431
    Top = 24
    Width = 81
    Height = 21
    TabOrder = 4
  end
  object Buscar: TButton
    Left = 430
    Top = 48
    Width = 81
    Height = 25
    Caption = 'Buscar'
    TabOrder = 5
    OnClick = BuscarClick
  end
  object Proc: TADOStoredProc
    Parameters = <>
    Left = 360
    Top = 8
  end
  object ADOCommand1: TADOCommand
    Parameters = <>
    Left = 392
    Top = 8
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 392
    Top = 176
  end
  object PopupMenu1: TPopupMenu
    Left = 360
    Top = 176
    object Ocultar1: TMenuItem
      Caption = 'Ocultar'
      OnClick = Ocultar1Click
    end
    object Mostrar1: TMenuItem
      Caption = 'Mostrar'
      OnClick = Mostrar1Click
    end
  end
  object RxTrayIcon1: TRxTrayIcon
    Icon.Data = {
      000001000300101000000100080068050000360000002020000001000800A808
      00009E0500003030000001000800A80E0000460E000028000000100000002000
      0000010008000000000000000000000000000000000000000000000000000000
      0000F6F7DC00C2EFBB00B5DE8B00BCC5580098D27800E1D48E00EFCF9F00BDE9
      AD0083E69B009AEEAC008FEAA5005EDB860030C659008BA31E00EC921100A4DD
      950047D37300BDF8C200B4F3B7008AE3970034C960008FA81D00E98800005E89
      0200C1B086003BB337003ACD670069DF8C00A1EAA40088E7A000CAECAA00DAC9
      6100C5A516007D93020000890000637C0600C7C7C700E9B16300B5910F0027BF
      4A003ACD680048D3740060D47800E8D77D00FFBC4400D09E0600009400000083
      0000147502007D5D3B00DB8E3000D381030024AD26001FB83B0025BD4600CCBD
      4500FFB53400F2A22C00D2AB5200B5B97A00B0AF780030751B0071592C00D282
      2A00D3710000B9860300649C0C001CA614003CA40D00ED972300ECD1B300EED1
      AF00FCE0B500F4D3AC00E3C7A1009F826300A5A5A500D2873C00C25F0000D16F
      0000DB7A00007689000070974200DBAC8700F4DCBB00FFF1D100FEECCA00FEE3
      BC00B19C8A00EBBE8700B14D0000BC590000C5630000B36B00007C8F4900E7BE
      9800E4B2890076655900B1B1B100BC651E00A8440200B450000015700C00645E
      0400A7643C00E4BB9500E0AF8800F6E4CB00877A6D00C2652300AF4B1C00A04E
      1A007C622B00A7440F00A4431200BA633C00E9BA9500A9897200D2BDA500CDBE
      B200A6693E00CC6E3700C06E4C00D16F5600CA684300B55E3C00734F3C00514D
      4B008F8F8F00E2C9AE00EAC6A400BCBCBC006A503700664C370056493F006C5D
      54007D706600CFBAAA00EED7C500FCDDB700D7B3900054545400D8C9BE00F1D4
      B400EFCFAD00DFBA9900AF9987006C6C6C00F4C69B009D847000787878000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000008E80810000000000000000000000008395968080808E9781000000
      000000008F90584A4A91929380940000005A8185868788898A8B6C8C8D8E0000
      5A797A7B7C7D7E7F808081828384005A6E6F7071727374756176775778005A64
      655B666768696A4A6B476C6D25005A5B5C5D5E305F54604A5560616263004E4F
      5051522F53544855565758590000404142434445464748494A4B4C4D00003334
      35363738393A3B3C3D3E3F250000262728292A2B2C2D2E2F303132000000001A
      1B1C1D1E1F202122232425000000001011091213141516171819000000000000
      08090A0B0C0D0E0F07000000000000000001020304050607000000000000FE3F
      0000FC010000FC000000E0000000C00000008001000000010000000100000003
      000000030000000300000007000080070000800F0000C01F0000E03F00002800
      0000200000004000000001000800000000000000000000000000000000000000
      000000000000FFFDE600FDF9DB00FFF4D100F4F8C000FDECCB00F8E9C100FEE6
      C100F6E5C800ECFBCD00ECDBC900CFF7D400DCD6D000FFF2B400FAE1BD00F6E5
      BB00FEEEAB00EAE7A100FFE59900FEDFB800FADAB200F5DEBC00F5D9B500F9D5
      AB00F2D2AE00F4CCA200EDD6B900E6CEBC00ECCCAF00EEC8A100E6C3A000F1DC
      9A00EDCE9200E8C19A00DFF1B300DCEEB700CBF5BF00CDEEAD00D5E39700DBCA
      BB00D5D98400EAA3A000EEBA9A00E8BD9500E1BF8400E5B38900C7BCB500DBB9
      9C00DDB69400D3B68D00DDAD8800C5A89100CFA48300B4F5BB00BAE59B00A4E3
      9500B7DF8C0098EBA9008ADF8B00BCBCBC00B5B5B500ACA7A300A1A1A100BD9E
      8100AC9D9300A09F9F009D9D9D009B979200978B84008D8D8D0083828200FBD7
      7D00FFC55800C0C46A00D6C65900CFC04D00E5B46F00FFBF4900D69F7C00D99F
      6900CA957300CB845C00FDB12E00FFAC1D00FFA40D00FEA10600EEA20900E49E
      3A00FB990000F8900000F4980200F18F0000F1840000EB921300E4910200E38C
      1B00EA8B0000EC840000E1820000C5B53200DE882000CB8F3400DB940200D09F
      0800D4870000CC9A1400CB880200BFCB6400AFD57A00A0C0500097D87F0090CA
      6300B7907500B5936800AF917B00A88566009280720085817D00B5B53200AF93
      0700A199080081B53400D06D5700D06F4A00C9674B00C7644400E07D1600ED7E
      0000E67C0000D0723100DB7A1200DD790100D4740000D36F0000C97B0000CF72
      0000C1681B00CC690000C8630000C4600000C05D0000B1715200807C7A009076
      5F00B1733100BC621C00A2671D00B8593200BE580000B9560000B4540E00B552
      0100B24D1F00B34C0000A55C0000A2510200AD491200AA441600AD4900009B64
      3200876335009A770B0096641A00905C2C008A5731008A4C26009A591B009D44
      0400805412008B530300A53E02008638030077E08E0062DB850073D473007FC9
      5F0058D271004FD87F0047D3740055C65A007DA818007F8E00006C8E02004CB4
      35005EA01300578C0000409E08003CD16F0030D06E0036CB630033C75B0029C8
      5F0028C5550020C5570025C14E001CBC43002FB73800398B0000328300002B89
      00001EB4320009B229000EAA1A001F9000001D82000000910000028A00000084
      00007C7C7C00747371007E7168006A6866007C7B490074554400736D3A006C6B
      0000516C27005D77020054660000437D00005F38270031721D003E6913002B6E
      08002A4812001B700B00027A0000037300000456030031080000153900001308
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
      FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE4444453DFEFEFEFEFE
      FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE1B041871D2CF44444444
      44FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE1B06132F3E3E717173
      73D044FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE1A190D1212121212
      1633D144FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE1A091A26261B
      19062FCFFEFEFEFEFEFEFEFEFEFEFEFEFEFE4242403D3D3D3DFEFEFEFEFEFEFE
      0B140DCFFEFEFEFEFEFEFEFEFEFEFE42428E9E9EA2A3D4D2CF413B3C43CF443C
      3F04153DFEFEFEFEFEFEFEFEFEFE708F80807A7A7A7A7C92A4D473302C6F8E73
      190432FEFEFEFEFEFEFEFEFE3064807C7C8C8C7C7C7B7979795020132A2C1B00
      0132FEFEFEFEFEFEFEFEFE306392929797A29F9C97817D804D201C132A4D1907
      3ECFFEFEFEFEFEFEFEFE305E979CA9A9A9A7D7A6A9895E4E312A1C161731312C
      33D0FEFEFEFEFEFEFEFE569BA9A9A99D98A8E0DD9A98904D312A1C060204151C
      2A43FEFEFEFEFEFEFE2895A99D9896948B99E2E2D996AA4F311C070704020204
      1D2DFEFEFEFEFEFEFE56A998968B8A8A89A0E1E1E1D6AA8C17071B201D15143E
      3CFEFEFEFEFEFEFE298798948A89888486C5CDCECEC5AADB2E1D1816182E8CD4
      413AFEFEFEFEFEFE2996948A8884838282CACCCDC6A09AE6E4DBD4723ED39FA4
      443AFEFEFEFEFEFE4B948A8883827E6076B8CAB5675B86A8E5E5E6E6DFD7D5A5
      453AFEFEFEFEFEFE4B8B8883826177B4B7777765575F5F69CACEE1E3E3DCD7A5
      8D3AFEFEFEFEFEFE4B8A837F69B9C97677B3555457595A5FB4CDCEE1E0DED7A5
      743AFEFEFEFEFEFE4B888261B7C8C7C3C3755151525457575FC4C5DAD6D9DDA1
      443AFEFEFEFEFEFE1F847F76C8C2C2C1BFB249474C5153575AB5C6CBE1E2E091
      403AFEFEFEFEFEFE1F827E76C2C1BDBCBABBAF464647515457B4CCCDCEE1DE8F
      3AFEFEFEFEFEFEFE1F5661B6C1BDBAB0ABACB03611464C5259B9B5C6CBE1D872
      3AFEFEFEFEFEFEFEFE1EB7C2BDBAB0370F3838080C464752575D76CDDAE1A03B
      FEFEFEFEFEFEFEFEFE1FB2C2BCB0AC3521230A0124AD4962B35D61B8CEB5703A
      FEFEFEFEFEFEFEFEFEFE0EB2BCAD39383408340336BBBD78665D6085B86426FE
      FEFEFEFEFEFEFEFEFEFEFE0E6CAE6D351023241039BABFB6595A61615626FEFE
      FEFEFEFEFEFEFEFEFEFEFEFE226D6E6B353535ABB0BABFC365605C560BFEFEFE
      FEFEFEFEFEFEFEFEFEFEFEFEFE0E256B6A6DABACB1BEC2C768512B0BFEFEFEFE
      FEFEFEFEFEFEFEFEFEFEFEFEFEFEFE2210276B6D4A6C6E481F09FEFEFEFEFEFE
      FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE0E0E050E0E0E0EFEFEFEFEFEFEFEFE
      FEFEFEFEFEFEFFFFFFFFFFFF87FFFFFF001FFFFF8007FFFFC003FFFFF003FFF0
      1FC3FF800003FF000007FC00000FF800000FF000000FF000000FE000000FE000
      001FC000000FC000000FC000000FC000000FC000000FC000000FC000000FC000
      001FC000001FE000003FE000003FF000007FF80000FFFC0001FFFE0003FFFF80
      0FFFFFE03FFF2800000030000000600000000100080000000000000000000000
      0000000000000000000000000000FCFBE900FDE0E700FEFCD100FDF6DA00FEF0
      D100F7F1DC00F6EDD800F7EAD100FEEECA00FEE8C500F5EACA00F7E4C500E4FB
      D300D4F8CE00CBCBCB00FCF3BB00FBE8BE00FEE0B500FDEBA800E8F4BA00EEE7
      A000E5EDAB00FDE08F00E1E69D00FADCB200F5DDBC00F5D8B200FED6A900F6D5
      AB00F4CEA100EFDBBD00E5D1BC00EED0AF00E9CBA800EEC9A200F8DF9F00F1C1
      9400E9C39D00D2F3B700CDE09000E4B5B900E1BD9F00E5BB9500ECB98E00E5B4
      8C00DDBEA800DFB49000DAB18600DAA88400CDA88700C5A28600B8F4B900BBE5
      9B00B5DB87009AEDAC0098E69E0095DB8400BFA99800A38F8200999999009292
      92008D8D8D008F87810085838100F8D37B00FEC96000EFC06300E1CE6B00FFC0
      4C00C9C45400E5A64F00C0A07E00DFB75800D5A35300D59F7A00D0916200C681
      5400FBB63900FEAE2200F8A11C00FFA50D00FFA10400E1A21400E89F3700F099
      1400F99C0D00FD9C0000F9950000F4930000F38A0000F4840000E49B0400E686
      1600EB8A0100EB820000E2820000D7AE2200D88F3800D4970400DB8C1900D585
      0000C6870200B5D27200B3C85D0089C25000B18D7400A1806300BE8C4D00ABB9
      3F00A4A12900B89C0900A091030093B0260085A8180082960400D97A6300D574
      5C00D3715100CB7B5B00CC6A5000EA7B0000E47F0000D4723C00DB7A2300D27F
      2600C9702000CB693A00C4603200D5781800DC7A0100D4730000C0641500CC6A
      0000C8630000C4620000C05C3C00C15C0000B07F4700BF6750008A7668009B69
      4800A56B3000B5790200B6660000BB5A3700B8542A00B4502C00B6522000B14C
      2200BC580000B6530200B24D0000AC551100A75D1F00AD5A0800A8481400A242
      1100AC470000A742000091622B00926B020092511C0091480600A23C03007BE2
      950067DE890054D981007BD4790070C860004AD5790045D476004ACF6D0050C2
      52007EBA3F0063A61B0059B3330040A71800549403003DD67B003DD06F0037CD
      67002FD06D0032C95F002EC5560029C04D001AC352001FBC430036B43200318D
      0000208100001DB6380016BA3E0019B22E000FB22A001EA0070006AC1C000BA1
      07001E8C0000009100000E8D000002890000008300007B7B7B007D6D6300706C
      6A0073665C00766F4000606E3400767E0000756511007B5035005F6A20004370
      2600567C0000642C09003C7200003E671400326F1B00286C04001B6D0E00097F
      00000E700C000E720000007C0000007400000D6E0E00036B0300145208003618
      0400073900001907000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
      FEFEFEFEFEFEFE0E3CCACACA3DFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
      FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE28190B1D1D328BCDCCCA
      3D3D3C3B3B3B3B3BFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
      FEFEFEFEFEFEFE290B04111B1D2C31476969696A8BCBCCCA3C3CFEFEFEFEFEFE
      FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE2D20080408091111
      11181B1B1D242F69CBCC3CFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
      FEFEFEFEFEFEFEFEFEFE2829211E190B0B0909090808101B2469CD3CFEFEFEFE
      FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE2828
      2828282D29251904111D693F3CFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
      FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE1F2504112ECA3CFEFEFE
      FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
      FEFEFEFEFEFEFE2D0909223F3CFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE3E3E
      8BCBCDCDCDCCCACA3C3CFEFEFEFEFE3C3B3CFEFEFEFE3C310409293C3CFEFEFE
      FEFEFEFEFEFEFEFEFEFEFE6A6A8D8383838383838398A1D2D2CCCACACACA3C47
      6ACDCC3C3C3C47190309323CFEFEFEFEFEFEFEFEFEFEFEFEFE3E8980807A7A75
      747474737374757E939CD2CDCA3A2A1D2C2F69CBCB691E03042139FEFEFEFEFE
      FEFEFEFEFEFEFE636B637B7A7777778A8A777777777474737375919B6A251A1C
      2C2B2B30210303032039FEFEFEFEFEFEFEFEFEFEFEFE39635C7E8A8787878C8C
      90908787878787777774734A251D1C182C2C2C060005032139FEFEFEFEFEFEFE
      FEFEFEFEFE31547B8790919191939FCE9994949380807D7F8776302A25221C18
      2C30300600062E8B3CFEFEFEFEFEFEFEFEFEFEFE2F557D9292949B9C9CA3A1CF
      A1A3A39C82585D5D4B302E2A25221C112A4A302E212C30CC3CFEFEFEFEFEFEFE
      FEFEFE2F4F7D949B9CA3A3A3A39EA2D4D3A29EA39D82814B302F2E2A25221C11
      1A2E3030302B2B8B3C3CFEFEFEFEFEFEFEFE2F4D7D9CA3A3A39E9E9D9D97A2D9
      D9D8A29D9D95864B302F2E2A25221C09040419222C2C2C69CA3CFEFEFEFEFEFE
      FEFE427CA3A39E9E9D979797979697DADDDDD89797979D4C302F2E2A25200404
      04040408101A1D303C3CFEFEFEFEFEFEFE4253A3A39E9D9797979696959595D7
      E0E0E0D18897D68C302F2E2A1A03040404040808080818313CFEFEFEFEFEFEFE
      FE4283A39D97979696959588888885D5DFE0E0DED195D6D230302E0B03212A21
      200908080822393CFEFEFEFEFEFEFEFE40539E9D97979695888886868584A0BD
      DFDFDFDFDF8FA2D64A2503062E251C2E22252210313AFEFEFEFEFEFEFEFEFEFE
      407D9E9796959588868584848284BDC9C9C9C9C9DFD0A2E447080B2A1C1D2A1C
      2225214BA1CA3CFEFEFEFEFEFEFEFEFE42969796958886858482828281D0C8C8
      C8C8C8C9C9D59AE4D6D28C472E2A112521296A8C9BCD3CFEFEFEFEFEFEFEFE14
      469796958886848282828181786FC6C6C6C6C6BCD06586E4E6E6E6E4E4D28C47
      47CFCECE99D23FFEFEFEFEFEFEFEFE1A61979588858482828181815F5E64BCC6
      C6C6B164787982D6E4E4E6E6E6E6E6E4D8D4CFCE9FD23FFEFEFEFEFEFEFEFE23
      7C96888584828281815E5A5A6FB1B1C2B172595D5D5F5F7982D7E2E3E5E6E6E6
      E3D4CFCF9FA13DFEFEFEFEFEFEFEFE237D958684828281795E6572B1C46E626F
      6F6F575D5D5D5D6464C5C8C8C9E0E2E5E3D9D4CF9FA13FFEFEFEFEFEFEFEFE23
      7D888482828179646FC4C272726FB0AE6E5B5758585D5D6564B1C8C9C9DFDFDF
      E2DBD9D3D1983FFEFEFEFEFEFEFEFE237D85828281795EB1C3C3AE575BAE7152
      51515656575858595965BCC8C9C9DFE0DEDBD8D4D19A3EFEFEFEFEFEFEFEFE12
      7C848281815E72C3C1C0C0BBBBAF4E4E4E4E4E50515657585D5965C7C8C9BDA0
      A0A0D1D9D3983FFEFEFEFEFEFEFEFE10618482815E6FC3C1C0BEBEBABABAAD44
      444D4D4E4E505657585965C6BCD0D5D5D7DAE2DBD3993FFEFEFEFEFEFEFEFE08
      468481795FB0C1BEBABAB8B8B8B7B767414144444D4E5056575865BCC7BCBDC9
      DFE0E0E1D18D3FFEFEFEFEFEFEFEFE14428281795DAEBFBAB8B8B7B6B6B4B6B6
      A7404041444D4E5056585965C5C6C8C9DFDFE0E2A08C3CFEFEFEFEFEFEFEFEFE
      2381815E5DAFBFB8B7B6B4B3ABB3AAB5A714164041444D4E515762B1C6C7C8C9
      C9DFE0E28E3E47FEFEFEFEFEFEFEFEFE0853815EAEBFB8B7B6B3AAA9A6A5A6A6
      A9A617164041444E50566FC4BC6FC5BDDCDFE0D77D47FEFEFEFEFEFEFEFEFEFE
      14407865BEBAB7B6B3A9A6A53434A5A5A6370F121640444D505657727265C5BD
      D5DCE0A08947FEFEFEFEFEFEFEFEFEFEFE0F6DBBBAB8B7B4AAA6A5271213A4A4
      360302121640414D4E56575D5972C6C8D5DCBD6547FEFEFEFEFEFEFEFEFEFEFE
      FE0135C1BAB7B6B3A6A5A4271226360D00000215A766414D606E62585965C5C8
      BDDF6F6BFEFEFEFEFEFEFEFEFEFEFEFEFEFE02A8BFB7B4AAA6A5A43626330C0D
      360C0237B5AB454DBBC1B05D5D5E8EC8C9D56347FEFEFEFEFEFEFEFEFEFEFEFE
      FEFEFE13ACB9B5A9A5A437363313022636260F37AAB5B7AC705B5B5D5D5F78D5
      C56247FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE1415ACAC6CA766353626260D33
      330F12A4A9B4B7B97056575D5D5F818E6249FEFEFEFEFEFEFEFEFEFEFEFEFEFE
      FEFEFEFE001452A8A638383440173326151727A5A9B4B7B8BB62575D5D818155
      49FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE0015A7A867383527403316
      27A4A5A6AAB4B7B8BB6E575D5F5D4F48FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
      FEFEFEFEFEFE140F356C3866373737373538A5A6B3B6B7BABB62595D544D2FFE
      FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE0214353845663838
      A4A7A6B2B5B7B8BFC06E4F4D421FFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
      FEFEFEFEFEFEFEFEFEFE021440666767A6B2686CADB8B8AF6C48422121FEFEFE
      FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE030F1640
      27354244444343401D1EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
      FEFEFEFEFEFEFEFEFEFEFEFEFEFE0003080A100B0B0A0600FEFEFEFEFEFEFEFE
      FEFEFEFEFEFEFEFEFEFEFEFEFEFEFFFFFF81FFFF0000FFFFFF00003F0000FFFF
      FF80000F0000FFFFFFC000070000FFFFFFF000030000FFFFFFFF00010000FFFF
      FFFFFF010000FFFFFFFFFF810000FFFF000F8F010000FFF8000000030000FFE0
      000000070000FF800000000F0000FF000000001F0000FE000000001F0000FC00
      0000001F0000F8000000000F0000F0000000000F0000F0000000000F0000E000
      0000001F0000E0000000003F0000C000000000FF0000C0000000007F0000C000
      0000007F000080000000007F000080000000007F000080000000007F00008000
      0000007F000080000000007F000080000000007F000080000000007F00008000
      0000007F000080000000007F000080000000007F0000C0000000007F0000C000
      000000FF0000C000000000FF0000E000000001FF0000E000000003FF0000F000
      000003FF0000F800000007FF0000F80000000FFF0000FC0000001FFF0000FE00
      00003FFF0000FF0000007FFF0000FFC00000FFFF0000FFF00001FFFF0000FFFC
      000FFFFF0000FFFF003FFFFF0000}
    PopupMenu = PopupMenu1
    Left = 328
    Top = 176
  end
end
