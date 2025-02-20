# inner joins
![Inner Join](../img/img_inner_join.png)
``` SQL

-- seleccionar todas las categorias y produc
use Northwind
select * from Categories inner join Products on Categories.CategoryID = Products.CategoryID;
select Categories.CategoryID, CategoryName, ProductName, UnitsInStock, UnitPrice from Categories inner join Products on Categories.CategoryID = Products.CategoryID;
select c.CategoryID, CategoryName, ProductName, UnitsInStock, UnitPrice from Categories as c inner join Products as p on c.CategoryID = p.CategoryID;
select c.CategoryID as 'CategoriaID', CategoryName as [Nombre de la Categoria], ProductName 'Nombre del producto', UnitsInStock, UnitPrice from Categories as c inner join Products as p on c.CategoryID = p.CategoryID;

--seleccionar los productos de las categorias beverages y condiments donde la existencia entre 18 y 30 
select c.CategoryID, CategoryName, ProductName, UnitsInStock, UnitPrice from Categories as c inner join Products as p on c.CategoryID = p.CategoryID where c.CategoryName in ('beverages', 'condiments') and p.UnitsInStock >=18 and p.UnitsInStock <=30

--seleccionar los productos y sus importes realisados de marzo a junio de 1996 mostrando la fecha de orden el id del producto y el importe 
select o.OrderID, o.OrderDate, od.ProductID, (od.UnitPrice * od.Quantity) as importe from Orders as o join [Order Details] as od on od.OrderID = o.OrderID where o.OrderDate between '1996-01-07' and '1996-31-10' select getdate() 

-- mostrar el importe total de ventas de la consulta anterior 
select concat('$', '', sum(od.Quantity * od.UnitPrice)) as importe from Orders as o join [Order Details] as od on od.OrderID = o.OrderID where o.OrderDate between '1996-01-07' and '1996-31-10' select getdate() 

-- consultas basicas con inner join 
-- 1 obtener los nombre de los clientes y los paises a los que se enviaron sus pedidos 
select o.CustomerID, o.ShipCountry from orders as o 
select c.CompanyName as 'Nombre del cliente', o.ShipCountry as 'Pais de envios' from Orders as o join Customers as c on c.CustomerID = o.CustomerID order by 2 desc

-- 2 obtener los productos y sus respectivos provedores 
select p.ProductName as 'Nombre producto', s.CompanyName as 'Nombre del provedor' from Products as p join Suppliers as s on p.SupplierID = s.SupplierID

-- 3 obtener los pedidos y los empleados que los gestionaron 
select o.OrderID, concat (e.Title, '-', e.FirstName, ' ', e.LastName) as 'Nombre' from Orders as o join Employees as e on o.EmployeeID = e.EmployeeID

-- 4 listar los productos junto con sus precios y la categoria a la que pertenecen 
select p.ProductName as 'Nombre del producto', p.UnitPrice as 'Precio', c.CategoryName as 'Categoria' from Products as p join Categories as c on p.CategoryID = c.CategoryID

-- 5 obtener el nombre del cliente el numero de orden y la fecha de orden 
select c.CompanyName as 'Nombre cliente', o.OrderID as 'Numero de orden', o.OrderDate as 'Fecha de orden' from Customers as c join Orders as o on c.CustomerID = o.CustomerID 

-- 6 listar las ordenes mostrando el numero de orden el nombre del producto y la cantidad que se vendio 
select OrderID as 'Numero de orden', ProductName 'Nombre del producto', Quantity as 'Cantidad vendida' from [Order Details] as o join Products as p on o.ProductID = p.ProductID order by o.Quantity desc

-- 7 obtenr los empleados y sus respectivos jefes 
select concat(e1.FirstName, ' ', e1.LastName ) as 'Nombre', concat(j1.FirstName, ' ', j1.LastName) as 'Jefe' from Employees as e1 join Employees as j1 on e1.ReportsTo = j1.EmployeeID

-- 8 listar los pedidos y el nombre de la empresa de transporte utlizada 
select o.OrderID as 'Pedido', s.CompanyName as 'Nombre de la empresa de transporte' from Orders as o join Shippers as s on o.ShipVia = s.ShipperID

-- Consultas inner join intermedias 
-- 9 obtener la cantidad total vendidos por categoria
select c.CategoryName as 'Nombre de la categoria', sum(Quantity) as 'Productos vendidos' from Categories as c join Products as p on c.CategoryID = p.CategoryID join [Order Details] as od on od.ProductID = p.ProductID group by c.CategoryName

-- 10 obtener el total de ventas por empleado 
select sum((od.Quantity * od.UnitPrice) - (od.Quantity * od.UnitPrice) * od.Discount) as Total, concat(e.LastName, ' ', FirstName) as 'Nombre empleado' 
from Orders as o join Employees as e on o.EmployeeID = e.EmployeeID join [Order Details] as od on o.OrderID = od.OrderID group by e.FirstName, e.LastName

-- 11 listar los clientes y la cantidad de pedidos que han realizado 
select c.CompanyName, count(*) as 'numero de ordenes' from Customers as c join orders as o on c.CustomerID = o.CustomerID group by c.CompanyName order by count(*) desc

-- 12 obtener los empleados que han gestionado pedidos en viados a alemania
select distinct concat(e.FirstName, ' ', e.LastName) as 'Nombre del empleado', o.ShipCountry from Employees as e join Orders as o on e.EmployeeID = o.EmployeeID where o.ShipCountry = 'germany'

-- 13 listar los productos junto con el nombre del provedor y el pais  de origen 
select p.ProductName as 'Nombre producto', s.CompanyName as 'Provedor', s.Country as 'Pais de origen' from Products as p join Suppliers as s on p.SupplierID = s.SupplierID

-- 14 obtener los pedidos agrupados por pais de envio 
select o.ShipCountry as 'Pais de envio', count(o.OrderID) as 'Numero de ordenes' from orders as o group by o.ShipCountry order by 2 desc 

-- 15 obtener los empleados y la cantidad de territorios en los que trabaja 
select concat(e.FirstName, ' ', e.LastName) as Nombre, count(et.TerritoryID) as 'Cantidad de territorios' from Employees as e join EmployeeTerritories as et on e.EmployeeID = et.EmployeeID group by e.FirstName, e.LastName

-- 16 listar las categorias y la cantidad de productos que contienen 
select c.CategoryName as 'Categoria', count(p.ProductID) as 'Cantidad dde producto' from Categories as c join Products as p on c.CategoryID = p.CategoryID group by c.CategoryName order by 2 desc 

-- 17 obtener la cantidad total de productos vendidos por provedor 
select s.CompanyName as 'Provedor', sum(od.Quantity) as 'Total de productos vendidos' from Suppliers as s join Products as p on p.SupplierID = s.SupplierID join [Order Details] as od on od.ProductID = p.ProductID group by s.CompanyName order by 2 desc

-- 18 obtener la cantidad de pedidos enviados por cada empresa de tranporte 
select count(OrderID), CompanyName from Orders as o join Shippers as s on o.ShipVia = s.ShipperID group by s.CompanyName

-- 19 ordenar los clientes que han realizado pedidos con mas de un producto 
select c.CompanyName, count( distinct ProductID) as 'Numero Productos' from Customers as c join Orders as o on c.CustomerID = o.CustomerID join [Order Details] as od on od.OrderID = o.OrderID group by c.CompanyName
order by 2 desc

-- 20 listar los empleados con la cantidad total de pedidios que han gestionado, y que clientes les han vendido, agrupandolos por nombre completo y dentro
-- de este nombre por cliente, ordenandolos por la cantidad de mayor de pedidos 

select concat(e.FirstName, LastName) as 'Nombre empleado', c.CompanyName as 'Cliente',count( distinct o.OrderID) as 'Numero de Ordenes ' 
from Employees as e join Orders as o on e.EmployeeID = o.EmployeeID join Customers as c on o.CustomerID = c.CustomerID group by e.FirstName, e.LastName, c.CompanyName
order by [Nombre empleado] asc, [Cliente]

-- consultas avansadas 

-- 21 Listar las categorias con el total de ingresos generados pos sus productos 
select c.CategoryName, sum(od.UnitPrice * od.Quantity) as 'Ingresos generados' from Categories as c join Products as p on c.CategoryID = p.CategoryID 
join [Order Details] as od on p.ProductID = od.ProductID group by c.CategoryName

select c.CategoryName, sum(od.UnitPrice * od.Quantity) as 'Ingresos generados', p.ProductName from Categories as c join Products as p on c.CategoryID = p.CategoryID 
join [Order Details] as od on p.ProductID = od.ProductID group by c.CategoryName, p.ProductName order by c.CategoryName

-- 22 listar los clientes con el total ($) gastado en pedidos 
select c.CompanyName, sum(od.Quantity * od.UnitPrice) as Total from Customers as c join Orders as o on c.CustomerID = o.CustomerID join [Order Details] as od on od.OrderID = o.OrderID group  by c.CompanyName

-- 23 Listar los pedidos realizados entre el 1 de enero de 1997 y el 30 de junio de 1997 y mostrar el total en dinero
select o.OrderDate, sum (od.Quantity * od.UnitPrice) as Total from Orders as o join [Order Details] as od on o.OrderID = od.OrderID 
where o.OrderDate between '1997-01-01' and '1997-30-06' group by o.OrderID, o.OrderDate

-- 24 listar los productos con las categorias beverages, seafood, confections 
select p.ProductName, c.CategoryName from Products as p join Categories as c on p.CategoryID = c.CategoryID where CategoryName in ('beverages', 'seafood', 'confections')

-- 25 listar los clientes ubicados en alemania y que hayan realizado pedidos antes del 1 de enero de 1997 
select c.CompanyName from Customers as c join Orders as o on c.CustomerID = o.CustomerID where Country = 'germany ' and o.OrderDate <= '1997-01-01'

-- 26 listar los clientes que an realizado pedidos con un total entre $500 y $2000
select * from Customers as c join Orders as o on c.CustomerID = o.CustomerID join [Order Details] as od on od.OrderID = o.OrderID group by c.CompanyName ```