�
 TDATADICCIONARIO 0g
  TPF0TDataDiccionarioDataDiccionarioOldCreateOrder		OnDestroyDataDiccionarioDestroyLeftGTop� Height�Width� TClientDataSetTESTADOINSPTag
Aggregates Params ProviderNamedspTESTADOINSPLeft8Top  TClientDataSetTDATINSPEVITag
Aggregates 	FieldDefs 	IndexDefs PacketRecordsParams ProviderNamedspTDATINSPEVI	StoreDefs	LeftHTop  TDataSetProviderdspTESTADOINSPDataSetsdsTESTADOINSPOptionspoIncFieldPropspoAutoRefreshpoAllowCommandText Left8TopH  TDataSetProviderdspTDATINSPEVIDataSetsdsTDATINSPEVIOptionspoIncFieldPropspoAllowCommandText LeftHTopH  TSQLDataSetsdsTESTADOINSP
NoMetadata	GetMetadataCommandTextSELECT * FROM TESTADOINSP
ParamCheckParams Left8Topx  TSQLDataSetsdsTDATINSPEVI
NoMetadata	GetMetadataCommandTextSELECT * FROM TDATINSPEVI
ParamCheckParams LeftHTopx  TClientDataSet
QryGeneral
Aggregates Params ProviderNamedspQryGeneralLeft8Top�   TDataSetProviderdspQryGeneralDataSetsdsQryGeneralOptionspoIncFieldPropspoAllowCommandText Left8Top�   TSQLDataSetsdsQryGeneral
NoMetadata	GetMetadata
ParamCheckParams Left8Top(  TClientDataSetQryUpdateInspeccion
Aggregates Params ProviderNamedspQryUpdateInspeccionLeft� Top�   TDataSetProviderdspQryUpdateInspeccionDataSetsdsQryUpdateInspeccionOptionspoIncFieldPropspoAllowCommandText Left� Top�   TSQLDataSetsdsQryUpdateInspeccion
NoMetadata	GetMetadata
ParamCheckParams Left� Top   TClientDataSetTDATA_REGLOSCOPIOTag
Aggregates PacketRecordsParams ProviderNameDSPTDATA_REGLOSCOPIOLeft�Top�   TDataSetProviderDSPTDATA_REGLOSCOPIODataSetSDSTDATA_REGLOSCOPIOOptionspoIncFieldPropspoAllowCommandText Left�Top  TSQLDataSetSDSTDATA_REGLOSCOPIO
NoMetadata	GetMetadataCommandText*  SELECT EJERCICI, CODINSPE, LT32000,LT32100,LT32101,LT32102,LT32103,LT32104,LT32105,LT32106,LT32200,LT32201,LT32202,LT32203,LT32204,LT32205,LT32206,LT32207,LT32300,LT32301,LT32302,LT32303,LT32304,LT32400,LT32401,LT32402,LT32403,LT32404,LT32500,LT32504,LT32600,LT32990,FECHALTA FROM TDATA_REGLOSCOPIOMaxBlobSize�
ParamCheckParams Left�TopP  TClientDataSetTDATRESULTREVTag
Aggregates PacketRecordsParams ProviderNamedspTDATRESULTREVLeft� Top  TDataSetProviderdspTDATRESULTREVDataSetsdsTDATIRESULREVOptionspoIncFieldPropspoAllowCommandText Left� TopH  TSQLDataSetsdsTDATIRESULREV
NoMetadata	GetMetadataCommandTextjSELECT CODINSPE, EJERCICI,CODESTACIONSBT,CODPRUEBA, VALORMEDIDA,RESULTADO,MEDIDO FROM RESULTADO_INSPECCIONMaxBlobSize�
ParamCheckParams Left� Topx   