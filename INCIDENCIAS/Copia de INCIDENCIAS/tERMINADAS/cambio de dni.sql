CAMBIo de dni
/
SELECT COUNT(*)  FROM tclientes  WHERE dni=?nueva dni
/
IF COUNT =0 THEN

UPDATE tclientes
SET dni= ?nuevadni
WHERE dni=?viejadni

END IF 






