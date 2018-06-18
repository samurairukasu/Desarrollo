CREATE OR REPLACE PROCEDURE CABA.completar_TEMP_DATINSPECC (
   pinspe      IN VARCHAR2,
   pejercici   IN VARCHAR2,
   tipo IN VARCHAR2,
   vehiculo IN VARCHAR2)
IS
   existe     INTEGER;
   varQuery   VARCHAR2 (1000);
   varSet1    VARCHAR2 (10);
   varSet2    VARCHAR2 (10);
   varSet3    VARCHAR2 (10);
   varSet4    VARCHAR2 (10);
   varSet5    VARCHAR2 (10);
   varSet6    VARCHAR2 (10);
   inspePRA    VARCHAR2 (10);

   CURSOR defectos (
      codinspeccion IN VARCHAR2,ejerci in varchar2)
   IS
      SELECT CD.nombre, valormedida
        FROM RESULTADO_INSPECCION RI
             INNER JOIN
             TCAMPOXDEFECTO CD
                ON REPLACE (RI.codprueba, ' ', '') =
                      REPLACE (CD.codprueba, ' ', '')
       WHERE RI.CODINSPE = codinspeccion AND EJERCICI= ejerci 
       AND CD.nombre IS NOT NULL;

BEGIN
   --DELETE FROM TEMP_DATINSPECC;

   SELECT COUNT (*)
     INTO existe
     FROM TEMP_DATINSPECC
    WHERE codinspe = pinspe AND EJERCICI = pejercici;

   IF existe = 0
   THEN
      INSERT INTO TEMP_DATINSPECC (CODINSPE, EJERCICI)
           VALUES (pinspe, pejercici);
   END IF;

   IF TIPO='E' THEN
    select max(codinspe) into inspePRA from
     tinspeccion where codvehic=vehiculo and (resultad='R' or resultad='C') and inspfina='S'; 
   
    FOR c_defecto IN defectos (inspePRA,pejercici)
    LOOP
      varQuery :=
            'UPDATE TEMP_DATINSPECC set '
         || c_defecto.nombre
         || '=to_number(REPLACE ('''||c_defecto.valormedida||''', '','', ''.''))'
         || ' where codinspe='
         || pinspe
         || ' AND EJERCICI='
         || pejercici; 

      EXECUTE IMMEDIATE varQuery;
    END LOOP;
   END IF;

   FOR c_defecto IN defectos (pinspe,pejercici)
   LOOP
      varQuery :=
            'UPDATE TEMP_DATINSPECC set '
         || c_defecto.nombre
         || '=to_number(REPLACE ('''||c_defecto.valormedida||''', '','', ''.''))'
         || ' where codinspe='
         || pinspe
         || ' AND EJERCICI='
         || pejercici; 
      EXECUTE IMMEDIATE varQuery;
   END LOOP;

   SELECT numlins1,
          numlins2,
          numlins3,
          numrevs1,
          numrevs2,
          numrevs3
     INTO varSet1,
          varSet2,
          varSet3,
          varSet4,
          varSet5,
          varSet6
     FROM tinspeccion
    WHERE codinspe = pinspe AND ejercici = pejercici;

   UPDATE TEMP_DATINSPECC
      SET numlinz1 = varSet1,
          numlinz2 = varSet2,
          numlinz3 = varSet3,
          numrevz1 = varSet4,
          numrevz2 = varSet5,
          numrevz3 = varSet6
    WHERE codinspe = pinspe AND ejercici = pejercici;

   -- select LT32200 into varSet from TDATA_REGLOSCOPIO where codinspe=pinspe;
   -- UPDATE TEMP_DATINSPECC set LUCES=varSet where codinspe=pinspe;

   --UPDATE TEMP_DATINSPECC set DESE1EJE=abs(EFAMRUD1-EFAMRUI1) where codinspe=pinspe;
   --UPDATE TEMP_DATINSPECC set DESE2EJE=abs(EFAMRUD2-EFAMRUI2) where codinspe=pinspe;


   COMMIT;
   
EXCEPTION 
        WHEN OTHERS 
        THEN dbms_output.put_line(SQLCODE);   
   
END;
/