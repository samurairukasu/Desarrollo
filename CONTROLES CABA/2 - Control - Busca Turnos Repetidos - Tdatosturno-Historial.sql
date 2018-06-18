--Controlo si existen turnos repetidos en tdatosturnohistorial
select distinct turnoid, codinspe, count(turnoid) TurnoRepetido from tdatosturnohistorial
where fechaturno between to_date('01/01/2018','dd/mm/yyyy') and to_date('31/12/2018','dd/mm/yyyy')+1
group by turnoid, codinspe
having count(turnoid) > 1
order by 1 desc;
