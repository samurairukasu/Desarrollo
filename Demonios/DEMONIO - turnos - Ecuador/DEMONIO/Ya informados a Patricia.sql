SELECT 
re.importado
,re.informado
,re.numero AS IDPAGO
,re.patente 
,re.fecha AS FECHATURNO 
,re.hora AS HORATURNO 
,dcob.valor AS IMPORTE 
,re.codestado AS ESTADO 
,dre.tipo_espe AS TIPOESPE
,tt.NOMESPEC 
--,dre.tipo_vehiculo AS tipo_vehiculo
,re.nombre 
,re.apellido 

FROM reserva re inner join detalles_reserva dre 
on re.numero = dre.nro_reserva 
inner join detalles_cobros dcob 
on dcob.contrapartida = re.numero 
left join TTIPOESPVEH tt on tt.tipoespe = dre.tipo_espe
WHERE re.codestado not like '-%' 
AND re.IMPORTADO ='N' 
AND RE.CODESTADO <> 2     
and re.numero not in (1206,1205,1203,1202,1201,1200) /*ya informados a patricia*/               
ORDER BY 3 desc;

--(1206,1205,1203,1202,1201,1200)