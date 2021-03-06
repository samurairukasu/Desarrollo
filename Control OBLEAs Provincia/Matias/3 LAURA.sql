CREATE TABLE CABA.HISTORIAL_RESULTADO_INSPECCION
(
  CODINSPE        NUMBER                        NOT NULL,
  EJERCICI        NUMBER(4)                     NOT NULL,
  CODESTACIONSBT  NUMBER(2)                     NOT NULL,
  CODPRUEBA       CHAR(10 BYTE)                 NOT NULL,
  VALORMEDIDA     VARCHAR2(30 BYTE),
  RESULTADO       NUMBER(1),
  MEDIDO          CHAR(1 BYTE)                  DEFAULT 'S'
)
TABLESPACE USER_DATA_ESTACION
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE INDEX CABA.PRK_HIST_TRESUINSP ON CABA.HISTORIAL_RESULTADO_INSPECCION
(CODINSPE, CODESTACIONSBT, CODPRUEBA)
NOLOGGING
TABLESPACE USER_DATA_ESTACION
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          12440K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;