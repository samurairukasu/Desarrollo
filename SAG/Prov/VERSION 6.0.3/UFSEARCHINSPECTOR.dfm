�
 TFRMBUSQUEDAINSPECTOR 0�  TPF0TfrmBusquedaInspectorfrmBusquedaInspectorLeft_Top� BorderIconsbiSystemMenu BorderStylebsDialogCaption   Búsqueda InspectorClientHeight�ClientWidthjColor	clBtnFaceFont.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameVerdana
Font.Style 
KeyPreview	OldCreateOrder	PositionpoScreenCenterOnCreate
FormCreate
OnKeyPressFormKeyPressPixelsPerInch`
TextHeight TBevelBevel1LeftTopWidthfHeightg  TLabellblNumeroInspectorLeftTopWidth� HeightCaptionNombre del Inspector: Font.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameVerdana
Font.Style 
ParentFont  TBevelBevel2LeftTop%Width\Height>  TLabellblPasswordLeft� Top+WidthDHeightCaption
&Password:EnabledFont.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameVerdana
Font.Style 
ParentFont  TLabellblPassword2Left�Top+WidthHeightCaption&Verificar Password:EnabledFont.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameVerdana
Font.Style 
ParentFont  TLabelLabel1LeftPTopWidth=HeightCaption
Apellido: Font.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameVerdana
Font.Style 
ParentFont  TBitBtn
btnAceptarLeft(Top�Width� HeightHint)   Lleva a cabo la búsqueda de un inspectorCaption
&ModificarParentShowHintShowHint	TabOrder	OnClickbtnAceptarClick
Glyph.Data
�  �  BM�      v   (   $            h                      �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� 333333333333333333  333333333333�33333  334C3333333733333  33B$3333333s7�3333  34""C333337333333  3B""$33333s337�333  4"*""C3337�7�3333  2"��"C3337�s3333  :*3:"$3337�37�7�33  3�33�"C333s33333  3333:"$3333337�7�3  33333�"C33333333  33333:"$3333337�7�  333333�"C3333333  333333:"C3333337�  3333333�#3333333s  3333333:3333333373  333333333333333333  	NumGlyphs  TBitBtnbtnCancelarLeft�Top�WidthzHeightHintB   Sale de la ventana donde se realizan las búsquedas de inspectoresCancel	Caption&SalirParentShowHintShowHint	TabOrder
OnClickbtnCancelarClick
Glyph.Data
�  �  BM�      v   (   $            h                       �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� 333333333333333333  33�33333333?333333  39�33�3333��33?33  3939�338�3?��3  39��338�8��3�3  33�338�3��38�  339�333�3833�3  333�33338�33?�3  3331�33333�33833  3339�333338�3�33  333��33333833�33  33933333�33�33  33����333838�8�3  33�39333�3��3�3  33933�333��38�8�  33333393338�33���  3333333333333338�3  333333333333333333  	NumGlyphs  TDBGridDBGridLeftTopmWidthgHeight?ColorclWhiteCtl3D	
DataSourceDataSource1Font.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameVerdana
Font.Style OptionsdgTitles
dgColLines
dgRowLinesdgTabsdgRowSelectdgConfirmDeletedgCancelOnExit ParentCtl3D
ParentFontTabOrderTitleFont.CharsetANSI_CHARSETTitleFont.ColorclBlackTitleFont.Height�TitleFont.NameVerdanaTitleFont.Style OnDrawColumnCellDBGridDrawColumnCellColumns	AlignmenttaCenterExpanded	FieldNameNUMREVISTitle.AlignmenttaCenterTitle.CaptionIDWidthVisible	 Expanded	FieldNameNOMREVISTitle.CaptionNOMBREWidth� Visible	 Expanded	FieldName	APPEREVISTitle.CaptionAPELLIDOWidth� Visible	 	AlignmenttaCenterExpanded	FieldNameACTIVOTitle.AlignmenttaCenterWidth<Visible	 	AlignmenttaCenterExpanded	FieldNameFECHALTATitle.AlignmenttaCenterTitle.CaptionFECHA DE ALTAWidth� Visible	    TDBEditDBNombreLeft� TopWidth� HeightCharCaseecUpperCaseCtl3D		DataFieldNOMREVIS
DataSourceDataSource1Font.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameVerdana
Font.Style ParentCtl3D
ParentFontTabOrder   TBitBtnBitBtn1Left� Top�Width� HeightHint)   Lleva a cabo la búsqueda de un inspectorCaption&Imprimir listadoParentShowHintShowHint	TabOrderOnClickBitBtn1Click  	TCheckBox	CheckBox1LeftTop+Width� HeightCaption   Modificar constraseña:TabOrderOnClickCheckBox1Click  TDBEditDBClave1LeftFTop+Width4HeightCtl3D		DataFieldPALCLAVE
DataSourceDataSource1EnabledFont.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameVerdana
Font.Style 	MaxLengthParentCtl3D
ParentFontPasswordChar*TabOrder  TEditDBClave2Left'Top+Width4HeightCtl3D	EnabledFont.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameVerdana
Font.Style 	MaxLengthParentCtl3D
ParentFontPasswordChar*TabOrderOnChangeDBClave2Change  TDBEdit
DBAPELLIDOLeft�TopWidth� HeightCharCaseecUpperCaseCtl3D		DataField	APPEREVIS
DataSourceDataSource1Font.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameVerdana
Font.Style ParentCtl3D
ParentFontTabOrder  	TCheckBoxCbInspectorActivoLeftTopKWidth� HeightCaptionInspector ActivoTabOrder  	TCheckBoxCBSuperUserLeft� TopKWidthtHeightCaptionSuper-UsuarioTabOrder  TDataSourceDataSource1DataSetsdsInspectorLeft`Top�   TSimpleDataSetsdsInspector
Aggregates DataSet.DataSourceDataSource1DataSet.MaxBlobSize�DataSet.Params Params 	AfterPostsdsInspectorAfterPostBeforeScrollsdsInspectorBeforeScrollAfterScrollsdsInspectorBeforeScrollLeft`Top  	TSQLQueryqryConsultasParams Left Top�   TApplicationEventsApplicationEvents	OnMessageApplicationEventsMessageLeft0Top�   