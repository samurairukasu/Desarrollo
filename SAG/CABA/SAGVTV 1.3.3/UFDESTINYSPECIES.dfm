�
 TFRMMODIFICARESPDEST 0�  TPF0TfrmModificarEspDestfrmModificarEspDestLeftFTop� BorderIcons BorderStylebsDialogClientHeight� ClientWidth�Color	clBtnFaceFont.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameComic Sans MS
Font.Style 
KeyPreview	OldCreateOrder	PositionpoScreenCenter
OnKeyPressFormKeyPressOnShowFormShowPixelsPerInch`
TextHeight TBevelBevel1LeftTopWidth�Heightm  TLabellblDescripcionLeft� Top4WidthGHeightCaption   DescripciónFont.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameComic Sans MS
Font.StylefsBold 
ParentFont  TLabellblTipoVehiculoLeftTopTWidthVHeightCaptionTipo VehiculoFont.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameComic Sans MS
Font.StylefsBold 
ParentFont  TLabel
FrecuenciaLeft%Top4WidthCHeightCaption
FrecuenciaFont.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameComic Sans MS
Font.StylefsBold 
ParentFont  TLabel	lblTarifaLeft� TopWidth(HeightCaptionTarifaFont.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameComic Sans MS
Font.StylefsBold 
ParentFont  TLabellblTituloAModificarLeftTopWidthwHeightCaptionD. SERVICIOFont.CharsetANSI_CHARSET
Font.ColorclBlueFont.Height�	Font.NameComic Sans MS
Font.StylefsItalic 
ParentFont  TBitBtn
btnAceptarLeft� TopxWidthQHeightHint0   Modificar la descripción y/o tipo del vehículoCaption&AceptarParentShowHintShowHint	TabOrderOnClickbtnAceptarClick
Glyph.Data
�  �  BM�      v   (   $            h                      �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� 333333333333333333  333333333333�33333  334C3333333733333  33B$3333333s7�3333  34""C333337333333  3B""$33333s337�333  4"*""C3337�7�3333  2"��"C3337�s3333  :*3:"$3337�37�7�33  3�33�"C333s33333  3333:"$3333337�7�3  33333�"C33333333  33333:"$3333337�7�  333333�"C3333333  333333:"C3333337�  3333333�#3333333s  3333333:3333333373  333333333333333333  	NumGlyphs  TBitBtnbtnCancelarLeft� TopxWidthUHeightHintH   Anular la operación de modificar la descripción y/o tipo del vehículoCaption	&CancelarParentShowHintShowHint	TabOrderKindbkCancel  	TMaskEdit	edtTarifaLeft� TopWidth9Height
AutoSelectEditMask!9;0; 	MaxLengthParentShowHintShowHint	TabOrder OnEnteredtTarifaEnterOnExitedtTarifaExit  
TColorEditedtFrecuenciaLeftlTop0Width9Height	MaxLengthTabOrderOnExitedtDescripcionExit
OnKeyPressedtFrecuenciaKeyPress
FondoColorclGreenFondoDestacado
FondoTextoclWhite  
TColorEditedtDescripcionLeft� Top0Width� HeightTabOrderOnExitedtDescripcionExit
FondoColorclGreenFondoDestacado
FondoTextoclWhite  
TColorEditedtTipoVehiculoLeftlTopPWidthIHeightTabOrderOnExitedtDescripcionExit
FondoColorclGreenFondoDestacado
FondoTextoclWhite  TSQLDataSetsdsqryConsultasTTIPOESPVEH
NoMetadata	GetMetadataCommandText�SELECT E.TIPOVEHI,E.CODFRECU,G.DESCRIPC,E.NOMESPEC,E.TIPOESPE,G.GRUPOTIP
FROM  TGRUPOTIPOS G, TTIPOESPVEH E
WHERE E.GRUPOTIP=G.GRUPOTIP
MaxBlobSize�
ParamCheckParams Left�Top   TSQLDataSetsdsqryConsultasTTIPODESVEH
NoMetadata	GetMetadataCommandText�SELECT G.DESCRIPC,E.NOMDESTI,E.TIPODEST,G.GRUPOTIP,E.CODFRECU
FROM  TGRUPOTIPOS G, TTIPODESVEH E
WHERE E.GRUPOTIP=G.GRUPOTIP
MaxBlobSize�
ParamCheckParams Left�Top@  	TSQLQueryqryConsultasParams LeftX  TDataSetProviderdspqryConsultasTTIPOESPVEHDataSetqryConsultasTTIPOESPVEHOptionspoIncFieldPropspoAllowCommandText Left`Top   TDataSetProviderdspqryConsultasTTIPODESVEHDataSetsdsqryConsultasTTIPODESVEHOptionspoIncFieldPropspoAllowCommandText Left`Top@  TClientDataSetqryConsultasTTIPOESPVEH
Aggregates Params ProviderNamedspqryConsultasTTIPOESPVEHLeft@Top   TClientDataSetqryConsultasTTIPODESVEH
Aggregates Params ProviderNamedspqryConsultasTTIPODESVEHLeft@Top@   