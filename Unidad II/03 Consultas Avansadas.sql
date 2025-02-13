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
