select to_char (i.fechalta,'dd/mm/yyyy'), count(*) 
from tinspeccion i, tfacturas f 
where i.fechalta between to_date ('01/05/2018','dd/mm/yyyy')
and to_date ('31/05/2018','dd/mm/yyyy')+1
and numoblea is not null and f.error ='N'
and inspfina = 'S' and i.codfactu=f.codfactu and F.CODCOFAC is null
group by to_char (i.fechalta,'dd/mm/yyyy');

select NUMOBLEA
from tinspeccion i, tfacturas f 
where i.fechalta between to_date ('03/05/2018','dd/mm/yyyy')
and to_date ('03/05/2018','dd/mm/yyyy')+1
and numoblea is not null and f.error ='N'
and inspfina = 'S' and i.codfactu=f.codfactu and F.CODCOFAC is null;

select count(*)--to_char (i.fechalta,'dd/mm/yyyy'), count(*) 
from tinspeccion i, tfacturas f 
where i.fechalta between to_date ('01/05/2018','dd/mm/yyyy')
and to_date ('31/05/2018','dd/mm/yyyy')+1
and numoblea is not null and f.error ='N'
--and fecvenci <to_date ('31--/12/2018','dd/mm/yyyy')
and inspfina = 'S' and i.codfactu=f.codfactu and F.CODCOFAC is null;

select * from tinspeccion where numoblea = 90007953;

select * from t_ervtv_anulac where numoblea = '85925347';

select * from t_ervtv_inutiliz 
where fecha between to_date ('01/05/2018','dd/mm/yyyy')
and to_date ('31/05/2018','dd/mm/yyyy')+1
order by 2 desc
