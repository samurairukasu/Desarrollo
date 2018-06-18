--Controlar que todos pagoidverificacion (pagos) asociados a los turnos con inspecciones Obligatorias
--que no pertenecen a Excentos, se encuentren descargados en Tdetallespago
select fechaturno, turnoid, dvdomino, pagoidverificacion, ausente, facturado, reviso
from cabasm.tdatosturnohistorial
where fechaturno >= to_date('01/01/2017','dd/mm/yyyy')
  AND fechaturno <= to_date('24/10/2017','dd/mm/yyyy')
  and (tipoinspe = 'P' and tipoturno <> 'EX')
  and facturado not in ('O','R','E')
  and pagoidverificacion not in (select pagoid from cabasm.tdetallespago);
  
--Controlar que todos pagoidverificacion (pagos) asociados a los turnos con inspecciones Obligatorias
--que no pertenecen a Excentos, se encuentren descargados en Tdetallespago
select fechaturno, turnoid, dvdomino, pagoidverificacion, ausente, facturado, reviso
from cabavs.tdatosturnohistorial
where fechaturno >= to_date('01/01/2017','dd/mm/yyyy')
  AND fechaturno <= to_date('24/10/2017','dd/mm/yyyy')
  and (tipoinspe = 'P' and tipoturno <> 'EX')
  and facturado not in ('O','R','E')
  and pagoidverificacion not in (select pagoid from cabavs.tdetallespago)
  order by 1;