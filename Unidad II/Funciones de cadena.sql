-- Funciones de cadena, fecha, instrucciones de colores

-- Funciones de cadena
-- las funciones de cadena perimten manipular tipos de datos como varchar nvarchar char nchar

-- Funcion Len -> deculve la longitud de una cadena
-- declaracion de una variable 

DECLARE @Numero int; 
SET @Numero = 10;
print @Numero

DECLARE @Texto varchar(50) = 'Hola mundo'

-- Len quiero obtener el tamano de la cadena almacenada en texto en la variable 'texto'

select len(@Texto) as 'Longitud' 
select CompanyName, len(CompanyName) from Customers

-- Funcion left 
-- Extrae un numero espesifico de caracteres desde el inicio de la cadena 
select LEFT(@Texto, 4) as inicio

-- Right extrae un determinado numero de caracteres del final de la cadena 
select RIGHT(@Texto, 4) as final

-- substring extrae una parte de la cadena
select SUBSTRING(@Texto,6,10)

-- replace remplasa un asub cadena por otra
select REPLACE(@Texto,'mundo','amigo')

-- charindex
select CHARINDEX('mundo', @Texto)

-- upper comvierte una cadena en mausculas 
select UPPER(@Texto) as Mayuscylas

select CONCAT(
LEFT (@Texto, 5),
UPPER(SUBSTRING(@Texto, 6, 10)), RIGHT (@Texto,1)) as TextoN


--trim -> quita espacios en blanco de una cadena
select trim('   test     ') as result;

declare @texto2 varchar(50) = '            hola, mundo!             ';
select trim (@texto2) as result;


select companyname, len(CompanyName) as 'numero de caracteres',
left (CompanyName,4) as inicio,
right (CompanyName,6) as final,
SUBSTRING (CompanyName,7,4) as 'subcadena'
from Customers

select CompanyName, len(CompanyName) as 'Numero de caracteres', LEFT(CompanyName, 4) as Inicio, 
RIGHT(CompanyName, 4), SUBSTRING(CompanyName,1,5) as Final from Customers
