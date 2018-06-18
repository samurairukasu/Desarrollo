--Previamente hay que descargar el listado de pagos de Epago desde la pagina.

--Correr en VS
select pagoid, codigopago, 'VS' AS Planta from tdetallespago
where codigopago in (select numero from ttmp_controlpagos);

--Correr en SM
select pagoid,codigopago, 'SM' As Planta from tdetallespago
where codigopago in (select numero from ttmp_controlpagos);
