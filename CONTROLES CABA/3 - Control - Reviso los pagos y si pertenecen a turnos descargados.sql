--Reviso la cantidad de pagos descargados NO facturados.
select count(*) from tdetallespago where facturado = 'N';

--Reviso la reserva de los los pagos descargados NO facturados
--si la reserva tiene "EsReve" y/o "EsReveDia" = 'S' y no esta
--Facturado el pago, hay que cambiar los registros de "EsReve" y/o "EsReveDia" a 'N'.
select * from tdatreserva where iddetallespago in (
select iddetallespago from tdetallespago where facturado = 'N');

--Reviso si los pagos no facturados tienen el turno descargado.
select * from tdatosturnohistorial where pagoidverificacion in (
select pagoid from tdetallespago where facturado = 'N' and estadoacreditacion = 'A')
and tipoinspe = 'P'
order by 3;

--Reviso cual fue la ultima factura realizada y en que horario.
--La fechalta deberia ser durante u posterior a las 23hs del dia
--anterior. Esto sirve para controlar si el WS descargo el resto
--de los pagos del dia y los facturo. Si la fecha de la ultima 
--factura es muy anterior a las 23hs, el WS no descargo ni facturo
--el ultimo tramo del dia.
select codfactu, fechalta from tfacturas order by 1 desc;

--Reviso cantidad de vehiculos en linea de inspeccion.
--Si existen pocos vehiculos en linea de inspeccion (menos de 10)
--aprovechar a facturar pagos pendientes.
select * from testadoinsp;