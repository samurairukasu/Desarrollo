object frmConfigurarRuta: TfrmConfigurarRuta
  Left = 447
  Top = 285
  BorderStyle = bsSingle
  Caption = 'Configurar la ruta de destino de los archivos'
  ClientHeight = 375
  ClientWidth = 338
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 7
    Top = 8
    Width = 274
    Height = 26
    Caption = 
      'Por favor, seleccione la ruta de destino para los'#13#10'archivos pdfs' +
      '.'
  end
  object BtnGuardar: TBitBtn
    Left = 91
    Top = 328
    Width = 75
    Height = 25
    Caption = '&Guardar'
    TabOrder = 1
    OnClick = BtnGuardarClick
  end
  object BtnCancelar: TBitBtn
    Left = 171
    Top = 328
    Width = 75
    Height = 25
    Caption = '&Cancelar'
    ModalResult = 2
    TabOrder = 2
  end
  object SCBx: TShellComboBox
    Left = 5
    Top = 40
    Width = 329
    Height = 22
    Root = 'C:\'
    ShellListView = SLV
    UseShellImages = True
    DropDownCount = 8
    TabOrder = 0
  end
  object SLV: TShellListView
    Left = 5
    Top = 64
    Width = 328
    Height = 259
    ObjectTypes = [otFolders, otNonFolders]
    Root = 'C:\'
    ShellComboBox = SCBx
    Sorted = True
    ReadOnly = False
    HideSelection = False
    TabOrder = 3
    ViewStyle = vsReport
  end
  object Barra: TStatusBar
    Left = 0
    Top = 356
    Width = 338
    Height = 19
    Panels = <
      item
        Text = ' Ruta actual:'
        Width = 70
      end
      item
        Width = 50
      end>
  end
end
