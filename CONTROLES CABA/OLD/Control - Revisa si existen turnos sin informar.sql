select 'tdatosturno' as Tabla, fechaturno, COUNT(turnoid) Cantidad
from tdatosturno tdat LEFT JOIN tinspeccion tins
on tdat.codinspe = tins.codinspe
where (informadows = 'NO' OR estadoid = 5)
and fechaturno >= SYSDATE-2--to_date('20/12/2017','dd/mm/yyyy')
group by fechaturno 
UNION
select 'tdatosturnohistorial' as Tabla, fechaturno, COUNT(turnoid) Cantidad
from tdatosturnohistorial tdat LEFT JOIN tinspeccion tins
on tdat.codinspe = tins.codinspe
where (informadows = 'NO' OR estadoid = 5)
and fechaturno >= SYSDATE-2--to_date('20/12/2017','dd/mm/yyyy')
group by fechaturno

select fechaturno, turnoid, dvdomino, tdat.codinspe, numoblea, informadows, motivo, estadoid, estadodesc
from tdatosturno tdat LEFT JOIN tinspeccion tins
on tdat.codinspe = tins.codinspe
where (informadows = 'NO' OR estadoid = 5)
and fechaturno >= to_date('20/12/2017','dd/mm/yyyy')