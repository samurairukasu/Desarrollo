--Control Global Obleas Por Planta
--DATOS CD VS VTV OBLEAS
Select 
T1.PLANTA, 
T1.Fecha, 
T1.Obleas as OB_VTV, 
T2.Obleas AS OB_CD, 
T2.Anuladas, T2.Inutilizadas, 
(T1.Obleas-T2.Obleas) as Diff 

FROM

(SELECT (P.IDZONA||P.NROPLANTA) AS PLANTA, TO_CHAR(fechcons,'DD/MM/YYYY') FECHA, COUNT(*) AS Obleas
  FROM VTV_OBLEAS INNER JOIN PLANTAS P ON VTV_OBLEAS.IDPLANTA = P.IDPLANTA
 WHERE fechcons BETWEEN '01/05/2018' AND '31/05/2018'
   --AND (P.IDZONA||P.NROPLANTA) = 21
GROUP BY (P.IDZONA||P.NROPLANTA), fechcons) T1 --ORDER BY 1;

INNER JOIN 

(SELECT (c.zona||c.planta) AS PLANTA, TO_CHAR(c.fecha,'dd/mm/yyyy') Fecha, 
(c.CANTAPRR+c.CANTAPRV+c.CANTANULADAS+c.CANTINUTIL) Obleas, 
 c.CANTANULADAS Anuladas, 
 c.CANTINUTIL Inutilizadas
  FROM VTV_DATOS_CD c 
 WHERE c.FECHA BETWEEN '01/05/2018' AND '31/05/2018'
   --AND (c.zona||c.planta) = 21
   ) T2
   
ON T1.Fecha = T2.Fecha  
WHERE T1.PLANTA = T2.PLANTA 
   
ORDER BY T1.PLANTA, T1.fecha asc;

--Cuando la diferencia entre datos del cd vs vtv oblea es mayor en el cd suele darse porque se importo 2 veces la misma oblea,
--es decir, una oblea que se consumio y que luego se anulo.
--Cuando la diferencia entre datos del cd vs vtv oblea es mayor en vtv suele darse porque falto sumar una consumida en el cd.

--Reviso el dia con la diferencia.
SELECT VTV.*
FROM VTV_OBLEAS VTV INNER JOIN PLANTAS P ON VTV.IDPLANTA = P.IDPLANTA
WHERE fechcons BETWEEN '08/03/2018' AND '08/03/2018' 
AND (P.IDZONA||P.NROPLANTA) = 21  
--AND estado = 'K'

SELECT VTV.*
FROM VTV_OBLEAS VTV INNER JOIN PLANTAS P ON VTV.IDPLANTA = P.IDPLANTA
WHERE VTV.numero BETWEEN 90783287-1 AND 90784100+1
AND (P.IDZONA||P.NROPLANTA) = 63 
order by VTV.numero