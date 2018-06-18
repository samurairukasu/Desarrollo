CREATE TABLE TINSPECCIONEXTERNA
(
  EJERCICI      NUMBER(4),
  CODINSPE      NUMBER(6),
  CODVEHIC      NUMBER(8)                       NOT NULL,
  FECHALTA      DATE                            NOT NULL,
  RESULTAD      VARCHAR2(1 BYTE)                NOT NULL,
  FECHAVERI     DATE                            NOT NULL,
  FECVENCI      DATE,
  ZONA          NUMBER(2)                       NOT NULL,
  PLANTA        NUMBER(2)                       NOT NULL,
  NUMOBLEA      VARCHAR2(9 BYTE),
  NRO_INSP_ANT  VARCHAR2(8 BYTE)
)
CREATE TABLE TCONTROLINSP
(
  MATRICUL  VARCHAR2(10 BYTE)                   NOT NULL,
  ESTADO    VARCHAR2(1 BYTE)                    NOT NULL,
  USUARIO   VARCHAR2(15 BYTE)
)