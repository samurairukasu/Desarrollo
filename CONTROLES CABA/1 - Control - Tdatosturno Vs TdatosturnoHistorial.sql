--Controlar que los turnos de la tabla TDATOSTURNOS se hayan pasado
--a la tabla TDATOSTURNOSHISTORIAL. Se comparan las cantidades de 
--turnos de ambas tablas.
select Fechaturno, count(*) Cantidad, 'TdatosTurno' Tabla 
  from tdatosturno 
 where fechaturno between sysdate-7 and sysdate
GROUP BY Fechaturno 
UNION
select Fechaturno, count(*) Cantidad, 'TdatosTurnoHistorial' Tabla 
  from tdatosturnohistorial 
 where fechaturno between sysdate-7 and sysdate
GROUP BY Fechaturno;
