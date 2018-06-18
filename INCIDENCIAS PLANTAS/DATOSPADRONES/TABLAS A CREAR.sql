
CREATE TABLE VEHICULOS_TOTALES_Z2
(
  PATENTE_ORIGINAL         VARCHAR2(8 BYTE),
  PATENTE_ACTUAL           VARCHAR2(6 BYTE),
  FECHA_ALTA_N             VARCHAR2(8 BYTE),
  MODELO                   VARCHAR2(4 BYTE),
  COD_TIPO_VEHICULO        VARCHAR2(2 BYTE),
  CODIGO_MARCA             VARCHAR2(7 BYTE),
  DESCRIPCION_MODELO       VARCHAR2(60 BYTE),
  DESCRIPCION_FABRICACION  VARCHAR2(60 BYTE),
  MARCA_MOTOR              VARCHAR2(12 BYTE),
  NRO_MOTOR                VARCHAR2(17 BYTE),
  TIPO_DOCUMENTO           VARCHAR2(1 BYTE),
  NRO_DOCUMENTO            VARCHAR2(9 BYTE),
  PROPIETARIO              VARCHAR2(30 BYTE),
  CODIGO_POSTAL            VARCHAR2(4 BYTE),
  LOCALIDAD                VARCHAR2(17 BYTE),
  DOM_CALLE                VARCHAR2(30 BYTE),
  DOM_NUMERO               VARCHAR2(5 BYTE),
  DOM_PISO                 VARCHAR2(2 BYTE),
  DOM_DEPTO                VARCHAR2(3 BYTE),
  CODIGO_PARTIDO_VEHICULO  VARCHAR2(3 BYTE),
  PESO                     VARCHAR2(5 BYTE),
  FECHA_INSPCRIP_INICIAL   VARCHAR2(8 BYTE)
)
/
CREATE TABLE TPADRON_RET_PERC
(
  FECHVIGDESDE     DATE,
  FECHVIGHASTA     DATE,
  NROCUIT          NUMBER(11),
  ALICUOTA_PERCEP  NUMBER(3,2)
)
/
CREATE INDEX IND_TPADRON_CUIT ON TPADRON_RET_PERC
(NROCUIT)
/
CREATE INDEX VEHIC_TOTAL_PATENTE ON VEHICULOS_TOTALES_Z2
(PATENTE_ACTUAL)
/
CREATE INDEX VEHIC_TOTAL_MOTOR ON VEHICULOS_TOTALES_Z2
(NRO_MOTOR)
/

CREATE OR REPLACE FUNCTION Buscaporcpadron (acode IN NUMBER)
   RETURN NUMBER
IS
   acuota                      NUMBER (3,2);
   noencuentracuit   CONSTANT NUMBER (2)    := -1;
   doc                        VARCHAR2 (11);
   existe                     NUMBER (1);
BEGIN
   SELECT DECODE (INSTR (t.cuit_cli, '-'),
                  1, REPLACE (t.cuit_cli, '-', ''),
                  2, REPLACE (t.cuit_cli, '-', ''),
                  3, REPLACE (t.cuit_cli, '-', ''),
                  t.cuit_cli
                 )
     INTO doc
     FROM TCLIENTES t
    WHERE codclien = acode;

   SELECT COUNT (*)
     INTO existe
     FROM datospadrones.TPADRON_RET_PERC
    WHERE nrocuit = doc;

   IF existe > 0
   THEN
      --
      SELECT NVL (alicuota_percep, noencuentracuit)
        INTO acuota
        FROM TPADRON_RET_PERC
       WHERE nrocuit = TO_NUMBER (doc);
   END IF;

   RETURN (acuota);
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      RETURN (noencuentracuit);
   WHEN OTHERS
   THEN
      RETURN (noencuentracuit);
END;
/

