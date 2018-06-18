--Corrige fecha en ageva tabla obleas, si actualiza registros, existen diferencias.
--Controlar luego desde la aplicacion de obleas las diferencias y controlar con la el control 2
ALTER SESSION SET nls_date_format = 'dd/mm/yyyy'
/
UPDATE VTV_OBLEAS
SET fechcons=fechINUT
WHERE fechcons IS NULL 
AND fechINUT BETWEEN TO_DATE('01/05/2018','dd/mm/yyyy') 
AND TO_DATE('01/06/2018','dd/mm/yyyy')
/
COMMIT;