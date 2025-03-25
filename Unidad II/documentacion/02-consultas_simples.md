# Ejercicios de consultas simples 
```sql
-- Lenguaje SQL LMD (insert, update, delete, select, - CRUD)
-- Consultas Simples 

use Northwind

-- Mostrar todos los clientes, provedores, categorias, productos, ordenes, detalle de la orden, empleados con las con las columnas de datos de la empresa 
select * from Customers;
select * from Employees;
select * from Orders;
select * from Suppliers;
select * from Products;
select * from Shippers;
select * from Categories;
select * from [Order Details];

-- Proyeccion 
select ProductID, ProductName, UnitPrice, UnitsInStock from Products;

-- Mostrar el numero del empleado, primer nombre, cargo, ciudad, pais

select EmployeeID, FirstName, Title, City, Country from Employees;

-- Alias de columna
-- En base a la consulta anterior visualisar el employeeid como numero empleado, firstname como primer nombre, title como cargo, city como ciudad, country como pais

select EmployeeID as [Numero Empleado], FirstName as PrimerNombre, Title 'Cargo', City as Ciudad, Country as Pais from Employees

-- Campos calculados 
-- Seleccionar el importe de los productos vendididos en una orden 
select *,(UnitPrice * Quantity) as Importe from [Order Details]

-- Seleccionar las fechas de orden ano mes y dia, el cliente que lo ordeno y el empleado que lo realizo
select OrderDate as Fecha, year(OrderDate) as Ano, month(OrderDate) as Mes, day(OrderDate) as Dia, CustomerID, EmployeeID from Orders

-- Filas duplicadas (Distinct)
select * from Customers;

-- Mostrar los paises en donde se tienen clientes
select distinct Country as Pais from Customers
order by Country

-- Clausula where 
-- Operadores relacionales (<, >, <=, >=, != o <>)
select * from Customers
-- Seleccionar el cliente BOLID
select CustomerID as Clienteid, CompanyName as NombreEmpresa, City as Ciudad, Country as Pais from Customers where CustomerID = 'BOLID';

-- Seleccionar los clientes mostrando identificador, nombre de la empresa, contacto, ciudad, pais de alemania
select CustomerID as Clienteid, CompanyName as 'Nombre de la Empresa', Phone as Contacto, City as Ciudad, Country as Pais from Customers where Country = 'germany'

-- Seleccionar todos los clientes que no sean de alemania 
select CustomerID as Clienteid, CompanyName as 'Nombre de la Empresa', Phone as Contacto, City as Ciudad, Country as Pais from Customers where Country != 'germany'

-- Seleccionar todos los productos mostrando su nombre de producto, categoria, existencia, precio, solamente si su precio es mayor 100 y su costo de inventario
select ProductName as 'Nombre del Producto', CategoryID as Categoria, UnitsInStock as Existencia, UnitPrice as Precio, (UnitPrice * UnitsInStock) as 'Costo de Inventario' from Products where UnitPrice > 100

-- Seleccionar ordenes de compra mostrando la fecha de orden, entrega, envio, cliente al que se vendio de 1996
select OrderDate as 'Fecha de Orden', RequiredDate as Entrega, ShippedDate as Envio, CustomerID  from Orders where year(OrderDate) = 1996
select * from Orders

-- mostrar todas las ordenes de compra donde la cantidad de productos comprados sea mayor a 5 
select Quantity as Ordenes from [Order Details] where Quantity >= 40;

-- mostarr el nomre completo del empleado su numero de empleado fecha de nacimimiento la ciudad y fecha de contratacion y 
-- esta deben de ser de aquellos que fueron contratados despues de 1993, los resultados en sus encabesados deben de mostrarlos en espa�ol
select LastName as Apellido, FirstName as Nombre, EmployeeID as 'ID empelado', BirthDate 'Fecha de nacimiento', City as Ciudad, HireDate as 'Fecha de contratacion' from Employees where year(HireDate) >1993
select (FirstName + '' + LastName) as 'Nombre completo', EmployeeID as 'ID empelado', BirthDate 'Fecha de nacimiento', City as Ciudad, HireDate as 'Fecha de contratacion' from Employees where year(HireDate) >1993
select CONCAT(LastName, '',FirstName, ' - ', Title) as [Nombre Completo], EmployeeID as 'ID empelado', BirthDate 'Fecha de nacimiento', City as Ciudad, HireDate as 'Fecha de contratacion' from Employees where year(HireDate) >1993

-- Mostrar los empleados que no son dirijidos por el jefe fuller Andrew
select (FirstName + '' + LastName) as 'Nombre completo', EmployeeID as 'ID empelado' from Employees where ReportsTo != 2

-- seleccionar todos los empleados que no tienen jefe 
select * from Employees where ReportsTo is null

--operadores logicos (or, and, not)
-- seleccionar los productos que tengan un precio de entre 10 y 50 
select ProductName as 'Nombre del producto', UnitPrice as Precio, UnitsInStock as Existencia from Products where UnitPrice >=10 and UnitPrice <=50

-- Mostrar todos los pedidos relisados por clientes que no son enviados a alemania 
select * from Orders where ShipCountry != 'Germany'
select * from Orders where not ShipCountry != 'Germany'

-- seleccionar clientes de mexico o usa 

select * from Customers where Country = 'mexico' or Country = 'usa' 

-- seleccionar empelados que nacieron entre 1955 y 1958 y que viven en londres 
select * from Employees where year(BirthDate) >= 1955 and year(BirthDate) <= 1958 and City = 'London'

-- Seleccionar los pedidos con flete de peso (freight) mayor a 100 y enviados a francio o espana 
select OrderID, OrderDate, ShipCountry, Freight  from Orders where Freight > 100 and (ShipCountry = 'france' or ShipCountry = 'spain')

-- seleccionar las primeras cinco ordenes de compra 
select top 5 * from Orders

-- seleccionar los productos con precio entre $10 y $50, que no esten descontinuados y tengan mas de 20 unidades en stock
select * from Products where UnitPrice >= 10 and UnitPrice <=50 and Discontinued = 0 and UnitsInStock > 20

-- pedidos enviados a francia o alemania pero con un flete menor a 50 
select * from Orders where (ShipCountry = 'france' or ShipCountry = 'germany') and Freight < 50

-- clientes que no sean de mexico o usa y que tengan fax registrado 
select Country, City, Fax, CompanyName from Customers where (Country != 'Mexico' and Country != 'usa') and Fax is not null

-- pedidos con flete mayor a 100 enviados a brasil o venezuela, pero no enviados por el transportista 1
select Freight, ShipCountry, ShipName from Orders where Freight > 100  and ShipCountry = 'brazil' or ShipCountry = 'venezuela' and ShipName = 'vins et alcools Chevalier'

-- selecionar empleados que no viven en londres o seattle y que fueron contratados despues de 1995
select CONCAT(FirstName, '', LastName) as [Nombre completo], HireDate, City, Country from Employees where (City != 'london' and City != 'seattle' and YEAR(HireDate) >= 1992)

-- CLAUSULA IN (OR)
-- seleccionar los productos con categoria 1,3 o 5
select ProductName, CategoryID, UnitPrice from Products where CategoryID = 1 or CategoryID = 3 or CategoryID = 5
select ProductName, CategoryID, UnitPrice from Products where CategoryID in (1,3,5)

-- seleccionar todas las ordenes de la region RJ, Tachira y que no tengan region asignada 
select OrderID, OrderDate, ShipRegion from Orders where ShipRegion in ('rj', 't�chira') or ShipRegion is null

-- seleccionar las ordenes que tengan cantidades de 12, 9 y 40 y descuento de 0.15 o 0.5
select * from [Order Details] where Quantity in (12,9,40) and Discount in (0.15, 0.5)

-- CLAUSULA BETWEEN (siempre van en el where) 
-- between valorinicial and valorfinal 
-- mostrar los productos con precio entre 10 y 50 
select * from Products where UnitPrice >= 10 and UnitPrice <= 50;

select * from Products where UnitPrice between 10 and 50

-- seleccionar todos los pedidos relaisados entre el 1 de enero y el 30 de junio de 1997

select * from Orders where OrderDate >= '1997-01-01' and OrderDate <= '1997-30-06'

select * from Orders where OrderDate between '1997-01-01' and '1997-30-06'

-- seleccionar todos los empeados contratados entre 1990 y 1995 que trabajan en londres 
select * from Employees where year(HireDate) >= 1992 and year(HireDate) <= 1994 and City = 'london'

select * from Employees where year(HireDate) between 1992 and 1994 and City = 'london'

-- pedidos con flete (freigh) entre 50 y 200 enviados a alemania y fracia 

select OrderID as 'Numero de orden', OrderDate as 'Fecha de orden', RequiredDate as 'Fecha de entrega', Freight as 'Peso', ShipCountry as 'Pais de entrega' from Orders where Freight >= 50 and Freight <= 200 and ShipCountry in ('germany', 'france')

select OrderID as 'Numero de orden', OrderDate as 'Fecha de orden', RequiredDate as 'Fecha de entrega', Freight as 'Peso', ShipCountry as 'Pais de entrega'  from Orders where Freight between 50 and 200 and ShipCountry in ('germany', 'france')

-- seleccionar todos los productos que tengan precio entre 5 y 20 dolares o que sean de la categoria 1,2 o 3
select UnitPrice, CategoryID from Products where UnitPrice >= 5 and UnitPrice <= 20 or CategoryID in (1,2,3)
select UnitPrice, CategoryID from Products where UnitPrice  between 5 and 20 or CategoryID in (1,2,3)

-- empleados con numero de trabajador entre 3 y 7 que no trabajan en londres ni seattle 

select EmployeeID, concat(FirstName, '' ,LastName) as 'Nombre completo', City from Employees where EmployeeID >= 1 and EmployeeID <= 7 and City != 'london' and City != 'seattle' 
select EmployeeID, concat(FirstName, '' ,LastName) as 'Nombre completo', City from Employees where EmployeeID between 1 and 7 and City != 'london' and City != 'seattle' 

-- TAREA 
-- Productos categoria 1,3 o 5 
select * from Products where CategoryID = 1 or CategoryID = 3 or CategoryID = 5 

-- Clientes de M�xico, Brasil o Argentina
 select * from Customers where Country = 'mexico' or Country = 'brazil' or Country = 'argentina'

 -- Pedidos enviados por los transportistas 1, 2 o 3 y con flete mayor a 50
 select * from Orders where ShipVia in (1,2,3) and Freight > 50

 -- Empleados que trabajan en Londres, Seattle o Buenos Aires
 select * from Employees where City in ('london', 'seattle', 'buenos aires')

 -- Pedidos de clientes en Francia o Alemania, pero con un flete menor a 100
select * from Orders where ShipCountry in ('france', 'germany') and Freight < 100

-- Productos con categor�a 2, 4 o 6 y que NO est�n descontinuados
select * from Products where CategoryID in (2,4,6) and Discontinued = 0

-- Clientes que NO son de Alemania, Reino Unido ni Canad�
select * from Customers where Country != 'germany' and Country != 'uk' and Country != 'canada'

-- Pedidos enviados por transportistas 2 o 3, pero que NO sean a USA ni Canad�
select * from Orders where ShipVia in (2,3) and ShipCountry != 'usa' and ShipCountry != 'canada'

-- Empleados que trabajan en 'London' o 'Seattle' y fueron contratados despu�s de 1995
select * from Employees where City in ('london', 'seattle') and year(HireDate) > 1995 

-- Productos de categor�as 1, 3 o 5 con stock mayor a 50 y que NO est�n descontinuados
select * from Products where CategoryID in (1,3,5) and UnitsInStock > 50 and Discontinued = 0

-- clausula like, patrones:
-- 1) %  representa cero o mas caracteres en el patron de busqueda 
-- 2) _  representa exactamente un caracter en el patron de busqueda 
-- 3) [] se utilisa para definir un conjunto de caracteres buscando cualquiera de ellos en la posicion especifica 
-- 4) [^] se utilisa para buscar caracteres que no estan dentro del conjunto espesifico 

-- buscar los productos que comiensan con cha
select * from Products where ProductName like 'cha%'
select * from Products where ProductName like 'cha%' and UnitPrice = 18

-- buscar todos los productos que terminen con e 
select * from Products where ProductName like '%e'

-- seleccionar todos los clientes cuyo nombre de empresa contiene la palabra "co" en cualquier parte
select * from Customers where CompanyName like '%co%'

-- seleccionar los empleados cuyo nombre comiense con a y tenga exactamente 5 caracteres
select FirstName,LastName from Employees where FirstName like 'a_____%'

-- seleccionar los productos que comiensen con a o b 
select * from Products where ProductName like '[abc]%'
select * from Products where ProductName like '[a-m]%'

-- seleccionar todos los productos que no comiensen con a o b 
select * from Products where ProductName like '[^ab]%'

--selecionar todos los productos donde el nombre comience con a pero no e 
select * from Products where ProductName like 'a[^e]%' 

-- Clausula order by 
select ProductID, ProductName, UnitPrice, UnitsInStock from Products order by UnitPrice desc

select ProductID, ProductName, UnitPrice, UnitsInStock from Products order by 3 desc

select ProductID, ProductName, UnitPrice as 'precio', UnitsInStock from Products order by 'precio' desc

-- seleccionar los clientes ordenados por el pais y dentro por ciudad 
select CustomerID, Country, City from Customers order by Country, City
select CustomerID, Country, City, Region from Customers where Country in ('brazil', 'germany') and Region is not null order by Country, City desc

```