�
 TFRMREIMPRESIONNC 0C  TPF0TfrmReimpresionNCfrmReimpresionNCLeft�Top�BorderIcons BorderStylebsDialogCaption   Reimpresión Notas CréditoClientHeight� ClientWidthCColor	clBtnFaceFont.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameComic Sans MS
Font.Style 
KeyPreview	OldCreateOrder	PositionpoScreenCenterScaledOnCloseQueryFormCloseQueryOnCreate
FormCreate	OnDestroyFormDestroy
OnKeyPressFormKeyPressOnShowFormShowPixelsPerInch`
TextHeight TBevelBevel1LeftTopWidth5Heighti  TLabellblMatriculaLeftTopLWidthFHeightCaption   &Inspección:  TLabellblNumFacturaLeftTop0WidthGHeightCaption   &Nº Factura:  TLabellblTipoLeft� Top,WidthHeightCaption&Tipo:  	TCheckBoxchkbxNumFacturaLeftTopWidth� HeightCaption   Búsqueda por Nº de FacturaChecked	ParentShowHintShowHint	State	cbCheckedTabOrder OnClickchkbxNumFacturaClick  TEditedtInspeccionLeftdTopHWidth� HeightHint]   Introduzca el número de inspección cuya factura desee reimprimir
Formato: aazzzzppppnnnnnnCharCaseecUpperCaseFont.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameComic Sans MS
Font.StylefsBold 	MaxLength
ParentFontParentShowHintShowHint	TabOrderOnEnteredtNumFacturaEnterOnExitedtNumFacturaExit  TEditedtNumFacturaLeftdTop(WidthuHeightHintM   Introduzca el número de factura que desee reimprimir
Formato: 0009-99999999CharCaseecUpperCaseFont.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameComic Sans MS
Font.StylefsBold 	MaxLength
ParentFontParentShowHintShowHint	TabOrderOnEnteredtNumFacturaEnterOnExitedtNumFacturaExit
OnKeyPressedtNumFacturaKeyPress  TBitBtn
btnAceptarLeftKTopyWidthQHeightHint8   Reimprimir la factura seleccionada como nota de créditoCaption&AceptarParentShowHintShowHint	TabOrderOnClickbtnAceptarClick
Glyph.Data
�  �  BM�      v   (   $            h                      �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� 333333333333333333  333333333333�33333  334C3333333733333  33B$3333333s7�3333  34""C333337333333  3B""$33333s337�333  4"*""C3337�7�3333  2"��"C3337�s3333  :*3:"$3337�37�7�33  3�33�"C333s33333  3333:"$3333337�7�3  33333�"C33333333  33333:"$3333337�7�  333333�"C3333333  333333:"C3333337�  3333333�#3333333s  3333333:3333333373  333333333333333333  	NumGlyphs  TBitBtnbtnCancelarLeft� TopyWidthQHeightHint9   Anular la operación de reimpresión de notas de créditoCaption	&CancelarParentShowHintShowHint	TabOrderKindbkCancel  	TComboBox	CmbBxTipoLeft Top(Width1HeightHintb   Señale el tipo de la factura a reimprimir (A o B)
Si es un ticket no fiscal seleccione el tipo NStylecsDropDownListFont.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameComic Sans MS
Font.StylefsBold 
ItemHeight
ParentFontParentShowHintShowHint	TabOrderOnEnteredtNumFacturaEnterOnExitedtNumFacturaExit	OnKeyDownCmbBxTipoKeyDownItems.StringsABN   TRadioGrouprgtipoLeft TopCWidth:Height(Ctl3D	Font.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameComic Sans MS
Font.Style 	ItemIndexItems.StringsGNCVTV ParentCtl3D
ParentFontTabOrder  	TSQLQueryqryConsultasParams LeftTopp   