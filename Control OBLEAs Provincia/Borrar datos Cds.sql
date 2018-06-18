/*
UPDATE VTV_OBLEAS v SET  
FECHCONS = NULL,
ESTADO = 'S',
EJERCICI = NULL,
FECHINUT = NULL,
CODINSPE = NULL
WHERE v.FECHCONS BETWEEN TO_DATE('01/06/2018','dd/mm/yyyy') AND TO_DATE('01/06/2018','dd/mm/yyyy')
AND IDPLANTA = 16;


DELETE FROM vtv_datos_cd c
WHERE c.FECHA BETWEEN  TO_DATE('01/06/2018','dd/mm/yyyy') AND TO_DATE('01/06/2018','dd/mm/yyyy')
AND PLANTA=6
AND ZONA=6

COMMIT;
*/
SELECT (IDZONA||NROPLANTA) PLANTA, nombre, idplanta
FROM PLANTAS
WHERE (IDZONA||NROPLANTA) IN 
(21,22,23,24,25,26,27,28,
 61,62,63,64,65,66,67,68,
 71,72,73,75)
order by 1;