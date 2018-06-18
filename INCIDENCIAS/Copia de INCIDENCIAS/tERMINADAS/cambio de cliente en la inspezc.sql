CAMBIo de cliente en la inspec
/
SELECT COUNT(*)  FROM tclientes  WHERE dni=? dni
/
IF COUNT >0 THEN
SELECT codclien  AS xxcodclien FROM tclientes  WHERE dni=? dni

UPDATE tinspeccion i
SET  i.CODCLCON= xxcodclien , i.CODCLPRO= xxcodclien ,  i.CODCLten= xxcodclien
WHERE codinspe= ?codinspe
/
UPDATE tfacturas 
SET codclien=xxcodclien
WHERE codfactu= ( SELECT codfactu FROM  tinspeccion WHERE codclien=?codinspe )
/

END IF 






