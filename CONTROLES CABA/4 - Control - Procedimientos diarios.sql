-- Ejecutar luego de haber realizado los controles 1 al 3 --

--Estos procedimientos deben ser ejecutados todos los dias. Esto se debe a que el WS descarga despues de las
--18.30hs todos los pagos nuevamente del dia y si hubiere algun pago en que exista turno con inspeccion para
--el mismo dia y no estaba el pago disponible para facturar cuando el WS verifico por fecha de novedad
--los pagos disponibles para descargar, la inspeccion del turno con el pagoid asociado faltante 
--no tendrá el codfactu correspondiente.

--Inserta el codfactu faltante en la Inspeccion
BEGIN CABA.CORRIGECODFACTUTINSPECCION; COMMIT; END;

--Corrige el el campo facturado del turno si el pagoid 
--esta facturado y el estado facturado del turno 
--es = a 'N'
BEGIN CABA.CORRIGETURNONOFACTURADO; COMMIT; END;