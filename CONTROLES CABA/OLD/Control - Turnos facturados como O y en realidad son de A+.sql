select 
tdat.turnoid, tdat.fechaturno, tdat.dvdomino, 
tdat.codinspe, tdat.ausente, tdat.facturado, 
tdat.reviso, tdat.tipoinspe, tins.tipo, 
TINS.INSPFINA, TINS.codfactu
from tdatosturnohistorial tdat
inner join tinspeccion tins on tdat.codinspe = tins.codinspe 
where facturado = 'O'
and fechaturno >= TO_DATE ('01/01/2018','DD/MM/YYYY')
and tdat.codinspe is not null
and codfactu is not null;