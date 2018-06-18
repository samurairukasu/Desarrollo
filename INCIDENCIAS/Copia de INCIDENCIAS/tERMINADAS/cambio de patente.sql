CAMBIo de patente 
/
SELECT COUNT(*)  FROM tvehiculos  WHERE patenten= ?nueva patente
/
IF COUNT =0 THEN
UPDATE tvehiculos
SET  patenten= ?nueva patente
WHERE patenten=?vieja patente
END IF 

IF COUNT > 0 THEN

SELECT codvehic  AS xxcodvehic FROM tvehiculos  WHERE patenten= ?nueva patente
/

UPDATE tinspeccion
SET  codvehic=xxcodvehic
WHERE codinspe=?codinspe
/
END IF 




