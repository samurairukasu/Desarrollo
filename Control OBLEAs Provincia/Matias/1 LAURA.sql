CREATE INDEX CABA.TINSPECCION_VEHIC ON CABA.TINSPECCION
(INSPFINA, RESULTAD, CODVEHIC)
NOLOGGING
TABLESPACE INDX_CABA
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
