--Reviso la cantidad de pagos descargados por el WS de Epago en la base.
--En base a las cantidades observadas, determinar si se debe descargar
--los pagos acreditados en ciertos dias nuevamente.
select distinct count(codigopago) cantidad, fechapago from TEpago 
where TEpago.fechaacreditacion between to_date('01/02/2018','dd/mm/yyyy') and to_date('31/12/2018','dd/mm/yyyy')
and TEpago.estadoacreditacion = 'A'
group by fechapago
order by 2 desc; 