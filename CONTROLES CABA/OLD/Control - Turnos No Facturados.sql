select 
tdat.fechaturno, tdat.dvdomino, tdat.turnoid, 
tdat.pagoidverificacion, tdat.facturado, tdat.reviso,
tdat.codinspe, tins.INSPFINA, TINS.TIPO, tdet.archivoenviado  
from tdatosturno tdat inner join tdetallespago tdet on tdat.pagoidverificacion = tdet.pagoid
inner join tinspeccion tins on tins.codinspe = tdat.codinspe
where tdet.facturado = 'S'
and (TINS.INSPFINA = 'S' and TINS.TIPO = 'A')
and (tdat.facturado = 'N'
and tdat.codinspe is not null
and tdat.tipoinspe = 'P'
and tdat.tipoturno <> 'EX')
UNION
select 
tdat.fechaturno, tdat.dvdomino, tdat.turnoid, 
tdat.pagoidverificacion, tdat.facturado, tdat.reviso,
tdat.codinspe, tins.INSPFINA, TINS.TIPO, tdet.archivoenviado  
from tdatosturnohistorial tdat 
inner join tdetallespago tdet on tdat.pagoidverificacion = tdet.pagoid
inner join tinspeccion tins on tins.codinspe = tdat.codinspe
where tdet.facturado = 'S'
AND tdat.facturado NOT IN ('E','O')
and (TINS.INSPFINA = 'S' and TINS.TIPO = 'A')
and (tdat.facturado = 'N'
and tdat.codinspe is not null
and tdat.tipoinspe = 'P'
and tdat.tipoturno <> 'EX')
order by fechaturno, dvdomino;

BEGIN CABA.CORRIGETURNONOFACTURADO; COMMIT; END;

--select * from tdetallespago where pagoid = 261260;
--select * from tfacturas where idpago = 261260;
--select * from tdatosturnohistorial where pagoidverificacion = 261260