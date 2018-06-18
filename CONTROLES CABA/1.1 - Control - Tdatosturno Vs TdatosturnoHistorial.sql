--Si hay turnos que no se hayan pasado la TDATOSTURNOSHISTORIAL
--se deben insertar en dicha tabla.

--insert into tdatosturnohistorial --Descomentar para realizar el insert.
select tdat.* 
  from tdatosturno tdat 
 where fechaturno between to_date('05/04/2018','dd/mm/yyyy') --cambio la fecha por la que se debe insertar
   and to_date('05/04/2018','dd/mm/yyyy'); --cambio la fecha por la que se debe insertar