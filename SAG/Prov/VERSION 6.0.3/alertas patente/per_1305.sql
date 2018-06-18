spool c:\argentin\envio\per_1305.txt
/	

CREATE TABLE CISA.PATENTE_EN_ALERTA
(
  FECHALTA        DATE,
  CODVEHIC        NUMBER(8),
  PATENTEN        VARCHAR2(7 BYTE),
  FECHABAJA       DATE,
  IDUSUARIO_ALTA  NUMBER(3),
  IDUSUARIO_BAJA  NUMBER(3),
  MOTIVO          VARCHAR2(250 BYTE)
)
/
Insert into TSERVIC
   (IDSERVICIO, NOMBRE, FECHALTA)
 Values
   (110, 'ABM Alertas', sysdate);
COMMIT
/
Insert into TSERVGRP
   (IDSERVICIO, IDGRUPO, FECHALTA)
 Values
   (110, 6, sysdate);
   Insert into TSERVGRP
   (IDSERVICIO, IDGRUPO, FECHALTA)
 Values
   (110, 3, sysdate);
COMMIT
/
SPOOL OFF
/
quit
/

