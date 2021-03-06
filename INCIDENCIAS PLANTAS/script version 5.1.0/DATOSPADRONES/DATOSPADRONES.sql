CREATE USER DATOSPADRONES
  IDENTIFIED BY VALUES '02LUSABAQUI03'
  DEFAULT TABLESPACE USER_DATA_ESTACION
  TEMPORARY TABLESPACE TEMP_DATA
  PROFILE DEFAULT
  ACCOUNT UNLOCK;
  GRANT ESTACION TO DATOSPADRONES;
  ALTER USER DATOSPADRONES DEFAULT ROLE ALL;

GRANT UNLIMITED TABLESPACE TO DATOSPADRONES;
ALTER USER "DATOSPADRONES" IDENTIFIED BY "02LUSABAQUI03"
/
GRANT DELETE, INSERT, SELECT, UPDATE ON  datospadrones.TPADRON_RET_PERC TO CISA;

-- GRANT EXECUTE ON  SYS.DBMS_ALERT TO DATOSPADRONES;
-- GRANT SELECT ON  SYS.V_$SESSION TO CISA;