spool c:\argentin\envio\correccion01-2011.txt
/
UPDATE TFACT_ADICION
SET CODDESCU=53
WHERE  CODFACT IN(
SELECT CODFACTU FROM TFACTURAS F WHERE  CODCLIEN =8144 AND  F.FECHALTA BETWEEN TO_date('23/01/2011','dd/mm/yyyy') and TO_date('25/01/2011','dd/mm/yyyy'))
/
COMMIT
/
SPOOL OFF
/
quit
/