�
 TDATOSIMPRESION 0T  TPF0TDatosImpresionDatosImpresionOldCreateOrder		OnDestroyDatosImpresionDestroyLeftTop� HeightWidth� TClientDataSetQryPrimerPreparadoTTRABAIMPRETag
Aggregates PacketRecordsParams ProviderName dspQryPrimerPreparadoTTRABAIMPRELeftPTop  TDataSetProvider dspQryPrimerPreparadoTTRABAIMPREDataSet sdsQryPrimerPreparadoTTRABAIMPREOptionspoIncFieldPropspoAllowCommandText LeftPTop(  TSQLDataSet sdsQryPrimerPreparadoTTRABAIMPRE
NoMetadata	GetMetadataCommandTextqSELECT CODTRABA, TIPOTRAB, EJERCICI, CODINSPE, PATENTE
FROM TTRABAIMPRE
WHERE ESTADO = 3
ORDER BY FECHALTA ASCMaxBlobSize�
ParamCheckParams LeftPTop@  TClientDataSetQryPrimerTrabajoTTRABAIMPRETag
Aggregates PacketRecordsParams ProviderNamedspQryPrimerTrabajoTTRABAIMPRELeft� Top  TDataSetProviderdspQryPrimerTrabajoTTRABAIMPREDataSetsdsQryPrimerTrabajoTTRABAIMPREOptionspoIncFieldPropspoAllowCommandText Left� Top(  TSQLDataSetsdsQryPrimerTrabajoTTRABAIMPRE
NoMetadata	GetMetadataCommandTextTSELECT CODTRABA, TIPOTRAB
FROM TTRABAIMPRE
WHERE ESTADO = 1
ORDER BY FECHALTA ASCMaxBlobSize�
ParamCheckParams Left� Top@  TClientDataSetQryTrabajosListosTTRABAIMPRETag
Aggregates PacketRecordsParamsDataTypeftStringNameUnTipoTrabajo	ParamType	ptUnknownValueA DataTypeftStringNameUnCodigoTrabajo	ParamType	ptUnknownValue1  ProviderNamedspQryTrabajosListosTTRABAIMPRELeft�Top  TDataSetProviderdspQryTrabajosListosTTRABAIMPREDataSetsdsQryTrabajosListosTTRABAIMPREOptionspoIncFieldPropspoAllowCommandText Left�Top(  TSQLDataSetsdsQryTrabajosListosTTRABAIMPRE
NoMetadata	GetMetadataCommandText�SELECT CODTRABA
FROM TTRABAIMPRE
WHERE
  ESTADO IN (2, 3, 4) AND
  TIPOTRAB =:UnTipoTrabajo AND
  CODTRABA <> :UnCodigoTrabajo
MaxBlobSize�ParamsDataTypeftStringNameUnTipoTrabajo	ParamType	ptUnknownValueA DataTypeftStringNameUnCodigoTrabajo	ParamType	ptUnknownValue1  Left�Top@  TClientDataSetQryLockTTRABAIMPRETag
Aggregates PacketRecordsParamsDataTypeftStringNameUnCodigoTrabajo	ParamType	ptUnknownValue0  ProviderNamedespQryLockTTRABAIMPRELeft(Top  TDataSetProviderdespQryLockTTRABAIMPREDataSetsdsQryLockTTRABAIMPREOptionspoIncFieldPropspoAllowCommandText Left(Top(  TSQLDataSetsdsQryLockTTRABAIMPRE
NoMetadata	GetMetadataCommandTextvSELECT ESTADO
FROM TTRABAIMPRE
WHERE
  CODTRABA =:UnCodigoTrabajo AND
  ESTADO <> 5
FOR UPDATE OF ESTADO NOWAIT
MaxBlobSize�
ParamCheckParamsDataTypeftStringNameUnCodigoTrabajo	ParamType	ptUnknownValue0  Left(Top@  TClientDataSetQryDeleteTTRABAIMPRETag
Aggregates PacketRecordsParams ProviderNamedspQryDeleteTTRABAIMPRELeft@Top�   TDataSetProviderdspQryDeleteTTRABAIMPREDataSetsdsQryDeleteTTRABAIMPREOptionspoIncFieldPropspoAllowCommandText Left@Top�   TSQLDataSetsdsQryDeleteTTRABAIMPRE
NoMetadata	GetMetadataCommandText;DELETE FROM TTRABAIMPRE
WHERE CODTRABA =:UnCodigoTrabajo
MaxBlobSize�
ParamCheckParams Left@Top�   TClientDataSetQryUpdateTTRABAIMPRETag
Aggregates PacketRecordsParamsDataTypeftStringNameUnNuevoEstado	ParamType	ptUnknownValue0 DataTypeftStringNameUnCodigoTrabajo	ParamType	ptUnknownValue0  ProviderNamedspQryUpdateTTRABAIMPRELeft� Top�   TDataSetProviderdspQryUpdateTTRABAIMPREDataSetsdsQryUpdateTTRABAIMPREOptionspoIncFieldPropspoAllowCommandText Left� Top�   TSQLDataSetsdsQryUpdateTTRABAIMPRE
NoMetadata	GetMetadataCommandTextRUPDATE TTRABAIMPRE
SET ESTADO =:UnNuevoEstado
WHERE CODTRABA =:UnCodigoTrabajo
MaxBlobSize�
ParamCheckParamsDataTypeftStringNameUnNuevoEstado	ParamType	ptUnknownValue0 DataTypeftStringNameUnCodigoTrabajo	ParamType	ptUnknownValue0  Left� Top�   TClientDataSetQryPonerUltimoTTRABAIMPRETag
Aggregates PacketRecordsParams ProviderNamedspQryPonerUltimoTTRABAIMPRELeft�Top�   TDataSetProviderdspQryPonerUltimoTTRABAIMPREDataSetdsdQryPonerUltimoTTRABAIMPREOptionspoIncFieldPropspoAllowCommandText Left�Top�   TSQLDataSetdsdQryPonerUltimoTTRABAIMPRE
NoMetadata	GetMetadataCommandTextNUPDATE TTRABAIMPRE
SET FECHALTA = SYSDATE
WHERE CODTRABA =:UnCodigoTrabajo
MaxBlobSize�
ParamCheckParams Left�Top�   TClientDataSetQrySolicitudesEnTTRABAIMPRETag
Aggregates PacketRecordsParams ProviderNamedspQrySolicitudesEnTTRABAIMPREOnCalcFields%QrySolicitudesEnTTRABAIMPRECalcFieldsLeft0Top�  TStringField&QrySolicitudesEnTTRABAIMPREMiSolicitud	FieldKindfkCalculated	FieldNameMiSolicitudSize2
Calculated	  TStringField#QrySolicitudesEnTTRABAIMPREMiEstado	FieldKindfkCalculated	FieldNameMiEstadoSize2
Calculated	  TStringField"QrySolicitudesEnTTRABAIMPREPATENTE	FieldNamePATENTERequired	Size
  TStringField#QrySolicitudesEnTTRABAIMPRETIPOTRAB	FieldNameTIPOTRABRequired	Size  TStringField!QrySolicitudesEnTTRABAIMPREESTADO	FieldNameESTADOSize(  TStringField#QrySolicitudesEnTTRABAIMPREFECHALTA	FieldNameFECHALTASize   TDataSetProviderdspQrySolicitudesEnTTRABAIMPREDataSetsdsQrySolicitudesEnTTRABAIMPREOptionspoIncFieldPropspoAllowCommandText Left0Top�   TSQLDataSetsdsQrySolicitudesEnTTRABAIMPRE
NoMetadata	GetMetadataCommandText�SELECT TO_CHAR(CODTRABA) CODTRABA,  PATENTE, TO_CHAR(ESTADO) ESTADO, TIPOTRAB, TO_CHAR(FECHALTA, 'HH24:MI:SS') FECHALTA
FROM  TTRABAIMPRE 
WHERE ESTADO <> 5
ORDER BY  PATENTE, FECHALTA
MaxBlobSize�
ParamCheckParams Left0Top�   TDataSourceDSTTRABAIMPREDataSetQrySolicitudesEnTTRABAIMPRELeftpTop�    