--Controlamos que no exista saltos en la numeracion de la facturacion.
--EXEC CONTROLARNROFACT2;
--SELECT * FROM RESPUESTANUMFACTU;

-------
-------

--Controlamos la cantidad de facturas x dia
select to_char(fechalta,'dd/mm') FECHA, count(*) Cantidad
from tfacturas where fechalta between to_date('01/02/2018','dd/mm/yyyy') 
and to_date('28/02/2018','dd/mm/yyyy')+1 
group by to_char(fechalta,'dd/mm');

--Controlamos la cantidad de notas de credito x dia
select to_char(TCON.FECHALTA,'dd/mm') FECHA, count(*) Cantidad 
from tcontrafact tcon inner join tfacturas tfac on tcon.codcofac = tfac.codcofac
where tcon.fechalta between to_date('01/02/2018','dd/mm/yyyy') 
and to_date('28/02/2018','dd/mm/yyyy')+1 
group by to_char(tcon.fechalta,'dd/mm');

-------
-------

--Revisamos que exista la ruta del PDF de la factura en "archivoenviado" x dia
SELECT DISTINCT
TFACTURAS.fechalta as FechaAltaFactura,
TFACTURAS.IDPAGO,
TFACTURAS.numfactu,
TDETALLESPAGO.iddetallespago,
(TDETALLESPAGO.TIPOCOMPROBANTEAFIP || '-' || TDETALLESPAGO.NRO_COMPROBANTE) NRO_FACTURA,
TDETALLESPAGO.CAE,
TDETALLESPAGO.archivoenviado,
TDETALLESPAGO.INFORMADA

from TDETALLESPAGO inner join TFACTURAS
  on TDETALLESPAGO.iddetallespago = TFACTURAS.iddetallespago
where TFACTURAS.fechalta between to_date ('11/01/2018', 'dd/mm/yyyy') 
  and to_date ('11/01/2018','dd/mm/yyyy')+1
  and TDETALLESPAGO.facturado = 'S'
--and archivoenviado is null
Order by 3;