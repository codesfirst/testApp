use TestDB;
SELECT * FROM persona;

-- ¿Cuántas personas hasta los 20 años están interesados en música rock?
-- Select * from persona where musica = 'Rock' and (edad between 0 and 20); -- Test
Select COUNT(id) from persona where musica = 'Rock' and (edad between 0 and 20); -- Correct

-- Mostrar el desglose por preferencia musical para el grupo de personas de edad entre 0 y 20. (Número de Personas, Preferencia Musical)
Select  COUNT(id) as "Numero de personas" , musica as "Preferencia Musical" from persona where edad between 0 and 20 group by musica order by musica;

-- Mostrar el desglose anterior por porcentaje (Número de personas, Preferencia Musical, Porcentaje)
-- select count(id) from persona where edad between 0 and 20;
Select  COUNT(id) as "Numero de personas" , 
	musica as "Preferencia Musical", 
	concat( 
		round(
			(Count(id) / (select count(id) from persona where edad between 0 and 20) * 100),2)
		) as porcentaje from persona where edad between 0 and 20 group by musica order by musica;
        
        
-- Mostrar el mismo desglose para el rango de edad entre 20 y 50 años.
Select  COUNT(id) as "Numero de personas" , 
	musica as "Preferencia Musical", 
	concat( 
		round(
			(Count(id) / (select count(id) from persona where edad between 20 and 50) * 100),2)
		) as porcentaje from persona where edad between 20 and 50 group by musica order by musica;

-- Mostrar el número de mujeres de más de 60 años, que escuchan Música Country ('C &W')
-- select * from persona where genero = 'F' and edad > 60 and musica = 'C & W';
select COUNT(id) from persona where genero = 'F' and edad > 60 and musica = 'C & W';

-- Desglose gusto artístico para la selección anterior (Número de personas, arte)
select COUNT(id) as 'Numero de Personas', arte from persona where genero = 'F' and edad > 60 and musica = 'C & W' group by arte;

-- Desglose mujeres y hombres que escuchan Jazz y Rock.(Debe mostrar el detalle de por columnas separadas)(genero, total_rock, total_jazz)
select genero as gen, 
	(select count(id) from persona where musica = 'Rock' and genero = gen) as "Total Rock", 
	(select count(id) from persona where musica = 'Jazz' and genero = gen) as "Total Jazz"  
	from persona where musica between 'Jazz' and 'Rock' group by genero order by genero;
    