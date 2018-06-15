object selecciona_plantilla: Tselecciona_plantilla
  Left = 557
  Top = 278
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Seleccione Plantilla'
  ClientHeight = 392
  ClientWidth = 761
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 737
    Height = 217
    Caption = 'Plantillas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 8
      Top = 24
      Width = 713
      Height = 177
      DataSource = modulo.dt_sql_copia
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      OnCellClick = DBGrid1CellClick
      OnKeyPress = DBGrid1KeyPress
      OnKeyUp = DBGrid1KeyUp
      Columns = <
        item
          Expanded = False
          FieldName = 'desde'
          Title.Caption = 'Fecha Inicio'
          Width = 92
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'hasta'
          Title.Caption = 'Fecha Fin'
          Width = 84
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'hora_inicio'
          Title.Caption = 'Hora Inicio'
          Width = 91
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'hora_fin'
          Title.Caption = 'Hora Fin'
          Width = 83
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'hora_i_desca'
          Title.Caption = 'Hora Inicio Descanso'
          Width = 132
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'hora_f_desca'
          Title.Caption = 'Hora Fin Descanso'
          Width = 129
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'numero'
          Title.Caption = 'Id'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'tp'
          Title.Caption = 'Tipo'
          Visible = True
        end>
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 232
    Width = 737
    Height = 105
    Caption = 'Detalle Plantilla'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object DBGrid2: TDBGrid
      Left = 8
      Top = 16
      Width = 721
      Height = 73
      DataSource = modulo.dt_canti_copia
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      Columns = <
        item
          Expanded = False
          FieldName = 'D0600'
          Title.Caption = '6:00'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D0615'
          Title.Caption = '6:15'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D0630'
          Title.Caption = '6:30'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D0645'
          Title.Caption = '6:45'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D0700'
          Title.Caption = '7:00'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D0715'
          Title.Caption = '7:15'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D0730'
          Title.Caption = '7:30'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D0745'
          Title.Caption = '7:45'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D0800'
          Title.Caption = '8:00'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D0815'
          Title.Caption = '8:15'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D0830'
          Title.Caption = '8:30'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D0845'
          Title.Caption = '8:45'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D0900'
          Title.Caption = '9:00'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D0915'
          Title.Caption = '9:15'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D0930'
          Title.Caption = '9:30'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D0945'
          Title.Caption = '9:45'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1000'
          Title.Caption = '10:00'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1015'
          Title.Caption = '10:15'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1030'
          Title.Caption = '10:30'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1045'
          Title.Caption = '10:45'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1100'
          Title.Caption = '11:00'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1115'
          Title.Caption = '11:15'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1130'
          Title.Caption = '11:30'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1145'
          Title.Caption = '11:45'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1200'
          Title.Caption = '12:00'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1215'
          Title.Caption = '12:15'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1230'
          Title.Caption = '12:30'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1245'
          Title.Caption = '12:45'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1300'
          Title.Caption = '13:00'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1315'
          Title.Caption = '13:15'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1330'
          Title.Caption = '13:30'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1345'
          Title.Caption = '13:15'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1400'
          Title.Caption = '14:00'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1415'
          Title.Caption = '14:15'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1430'
          Title.Caption = '14:30'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1445'
          Title.Caption = '14:45'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1500'
          Title.Caption = '15:00'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1515'
          Title.Caption = '15:15'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1530'
          Title.Caption = '15:30'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1545'
          Title.Caption = '15:45'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1600'
          Title.Caption = '16:00'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1615'
          Title.Caption = '16:15'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1630'
          Title.Caption = '16:30'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1645'
          Title.Caption = '16:45'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1700'
          Title.Caption = '17:00'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1715'
          Title.Caption = '17:15'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1730'
          Title.Caption = '17:30'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1745'
          Title.Caption = '17:45'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1800'
          Title.Caption = '18:00'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1815'
          Title.Caption = '18:15'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1830'
          Title.Caption = '18:30'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1845'
          Title.Caption = '18:45'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1900'
          Title.Caption = '19:00'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1915'
          Title.Caption = '19:15'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1930'
          Title.Caption = '19:30'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D1945'
          Title.Caption = '19:45'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D2000'
          Title.Caption = '20:00'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D2015'
          Title.Caption = '20:15'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D2030'
          Title.Caption = '20:30'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D2045'
          Title.Caption = '20:45'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D2100'
          Title.Caption = '21:00'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D2115'
          Title.Caption = '21:15'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D2130'
          Title.Caption = '21:30'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D2145'
          Title.Caption = '21:45'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D2200'
          Title.Caption = '22:00'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D2215'
          Title.Caption = '22:15'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D2230'
          Title.Caption = '22:30'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D2245'
          Title.Caption = '22:45'
          Visible = True
        end>
    end
  end
  object BitBtn1: TBitBtn
    Left = 624
    Top = 352
    Width = 75
    Height = 25
    Caption = 'Salir'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BitBtn1Click
    Glyph.Data = {
      26040000424D2604000000000000360000002800000012000000120000000100
      180000000000F0030000C40E0000C40E00000000000000000000008080008080
      0080800080800080800080800080800080800080800080800080800080800080
      8000808000808000808000808000808000000080800080800080808080808080
      8000808000808000808000808000808000808000808000808000808000808000
      808000808000808000000080800080800000FF00008000008080808000808000
      80800080800080800080800000FF808080008080008080008080008080008080
      00000080800080800000FF000080000080000080808080008080008080008080
      0000FF0000800000808080800080800080800080800080800000008080008080
      0000FF0000800000800000800000808080800080800000FF0000800000800000
      8000008080808000808000808000808000000080800080800080800000FF0000
      8000008000008000008080808000008000008000008000008000008080808000
      808000808000808000000080800080800080800080800000FF00008000008000
      0080000080000080000080000080000080808080008080008080008080008080
      00000080800080800080800080800080800000FF000080000080000080000080
      0000800000808080800080800080800080800080800080800000008080008080
      0080800080800080800080800000800000800000800000800000808080800080
      8000808000808000808000808000808000000080800080800080800080800080
      800080800000FF00008000008000008000008080808000808000808000808000
      808000808000808000000080800080800080800080800080800000FF00008000
      0080000080000080000080808080008080008080008080008080008080008080
      00000080800080800080800080800000FF000080000080000080808080000080
      0000800000808080800080800080800080800080800080800000008080008080
      0080800000FF0000800000800000808080800080800000FF0000800000800000
      8080808000808000808000808000808000000080800080800080800000FF0000
      800000808080800080800080800080800000FF00008000008000008080808000
      808000808000808000000080800080800080800080800000FF00008000808000
      80800080800080800080800000FF000080000080000080008080008080008080
      0000008080008080008080008080008080008080008080008080008080008080
      0080800080800000FF0000800000FF0080800080800080800000008080008080
      0080800080800080800080800080800080800080800080800080800080800080
      8000808000808000808000808000808000000080800080800080800080800080
      8000808000808000808000808000808000808000808000808000808000808000
      80800080800080800000}
  end
  object BitBtn2: TBitBtn
    Left = 248
    Top = 352
    Width = 153
    Height = 25
    Caption = 'Aceptar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = BitBtn2Click
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000000000000000000000000000000000000000FF0000FF
      0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
      FF0000FF0000FF0000FF0000FF84B684086D0810751018751818751818791810
      7910107D10087D08087D08007D000079000071007BB27B0000FF0000FF108210
      188E18299229299229299629299629299A29219E2118A21810A61008A608009E
      00009200006D000000FF0000FF188E18299629319E31399E39399E3939A239A5
      D7A5FFFFFF21AE2118B21810B21008AE08009E000079000000FF0000FF219221
      399E3942A2424AA64A42A64242A642FFFFFFFFFFFFFFFFFF21B62118B61808B2
      0808A208007D000000FF0000FF29962942A2424AA64A4AA64A4AA64A42A64242
      AA42FFFFFFFFFFFFFFFFFF18B21810AE1008A2080882080000FF0000FF319A31
      4AA64A52AA5252AA524AAA4A4AA64A42AA4239AA39FFFFFFFFFFFFFFFFFF18AE
      1818A2181082100000FF0000FF399E3952AA52FFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF189E181882180000FF0000FF42A242
      5AAE5AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FF219A21187D180000FF0000FF4AA64A63B26363AE635AAA5A52A6524AA24A39
      9E39319E31FFFFFFFFFFFFFFFFFF219A21299629217D210000FF0000FF52AA52
      6BB66B6BB66B5AAE5A52AA524AA24A429E42FFFFFFFFFFFFFFFFFF299629299A
      29299629217D210000FF0000FF5AAE5A7BBE7B73BA7363B2635AAA5A52A652FF
      FFFFFFFFFFFFFFFF319A31319A31319A31299629217D210000FF0000FF6BB66B
      8CC78C84C3846BB66B63B26363AE63B5DBB5FFFFFF4AA64A4AA64A42A242399E
      393196311879180000FF0000FF73BA739CCF9C8CC78C7BBE7B73BA736BB66B63
      B26363B2635AAE5A52AA524AA64A42A2422996291875180000FF0000FFB5DBB5
      73BA7363B2635AAE5A52AA524AA64A4AA64A4AA64A42A24239A239399E39319A
      31218E218CBA8C0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
      00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF}
  end
end
