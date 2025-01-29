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
-- esta deben de ser de aquellos que fueron contratados despues de 1993, los resultados en sus encabesados deben de mostrarlos en español
select LastName as Apellido, FirstName as Nombre, EmployeeID as 'ID empelado', BirthDate 'Fecha de nacimiento', City as Ciudad, HireDate as 'Fecha de contratacion' from Employees where year(HireDate) >1993
select (FirstName + '' + LastName) as 'Nombre completo', EmployeeID as 'ID empelado', BirthDate 'Fecha de nacimiento', City as Ciudad, HireDate as 'Fecha de contratacion' from Employees where year(HireDate) >1993
select CONCAT(LastName, '',FirstName, ' - ', Title) as [Nombre Completo], EmployeeID as 'ID empelado', BirthDate 'Fecha de nacimiento', City as Ciudad, HireDate as 'Fecha de contratacion' from Employees where year(HireDate) >1993

-- Mostrar los empleados que no son dirijidos por el jefe fuller Andrew
select (FirstName + '' + LastName) as 'Nombre completo', EmployeeID as 'ID empelado' from Employees where ReportsTo != 2

-- seleccionar todos los empleados que no tienen jefe 
select * from Employees where ReportsTo is null