select distinct 
to_char(fechaturno,'dd/mm/yyyy')fechaturno,
turnoid, 
pagoidverificacion,
tipoturno, 
dvdomino,
codvehic,
codclien,
ausente, 
facturado,
reviso,
codinspe,
tipoinspe
from tdatosturnohistorial 
where pagoidverificacion not in (select idpago from tfacturas)
and facturado <> 'O'
and tipoturno <> 'EX'
and tipoinspe = 'P'