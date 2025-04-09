use Northwind
-- 1. Mostar el total de ventas por categoria de producto ordenado de mayor a menor, poner nombre de categoria
select sum(p.UnitPrice + od.Quantity) as 'Total de ventas', c.CategoryName from Products as p join Categories as c on p.CategoryID = c.CategoryID join [Order Details] as od on p.ProductID = od.ProductID
group by c.CategoryName
order by sum(p.UnitPrice + od.Quantity) asc

-- 2. Mostrar todos los pedidos relaisados del 1 de enro de 1997 al 31 de marzo 1997 mostrando el  nombre del cliente y la orden de la compra
select o.OrderID, o.OrderDate, c.CompanyName from Orders as o join Customers as c on o.CustomerID = c.CustomerID where OrderDate >= '1997-01-01' and OrderDate <= '1997-31-03'

-- 3. Seleccionar el nombre y pais de los clientes que son de estados unidos alemania o brazil 
select CompanyName, Country from Customers where Country in ('usa', 'germany', 'brazil')

-- 4. Mostar el id del empleado el nombre de cliente como full name o nombre completo, numero de pedidos que han realisado, de los empledaso que solo an gestionado mas de 100 pedidos 
select  concat(e.LastName, ' ', e.FirstName) as 'Nombre Completo', count(o.OrderID) as 'Numero de pedidos' from Employees as e join Orders as o on e.EmployeeID = o.EmployeeID
group by  concat(e.LastName, ' ', e.FirstName)
having count(o.OrderID) > 100

-- 5. Mostar los primeros 10 productos cons descuento aplicado, mostra el nombre del peroducto precio unitario, el descunto la cantidad, precio final
select top 10 p.ProductName, p.UnitPrice, od.Discount, p.UnitsInStock, sum((p.UnitPrice * od.Quantity) - (1 - od.Discount)) as 'Precio final' from Products as p join [Order Details] as od on p.ProductID = od.ProductID
group by p.ProductName, p.UnitPrice, od.Discount, p.UnitsInStock

-- 6. Crear una vista que muestre con informacion del cliente em empleado el total del pedido inclullendo el descuento numero de orden nombre de cliente nombre del empleado completo fecha de la orden total del pedido 
go
create or alter view [dbo].[Pedidos_detalle]
as 
select c.CompanyName, concat(e.FirstName, ' ', e.LastName),  from Customers as c join Orders as o on c.CustomerID = o.CustomerID join Employees as e on o.EmployeeID = e.EmployeeID join [Order Details] as od on o.OrderID = od.OrderID

go
create or alter view [dbo].[Pedidos_detalle]
as
select o.OrderID, c.CompanyName, CONCAT(e.FirstName, ' ', e.LastName) as 'Nombre Empleado', o.OrderDate, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) as 'Total Pedido'
from Orders as o join Customers as c ON o.CustomerID = c.CustomerID join Employees as e ON o.EmployeeID = e.EmployeeID join [Order Details] od ON o.OrderID = od.OrderID
group by o.OrderID, c.CompanyName, CONCAT(e.FirstName, ' ', e.LastName), o.OrderDate

select * from Pedidos_detalle

-- 7. Realisar un store procedure que resiva id del cliente una fecha de orden y una fecha requerida y registre un 
-- nuevo pedido en la tabla orders utlilisar un bloque tru chach para capturar errorees ademas usa if para validar 
-- que la tabla cliente existe 
go
create or alter procedure spu_Incertar_pedido
@CustomerID int, @OrderDate datetime, @RequiredDate datetime, @NuevoPedido int
as begin 
if not exists (select 1 from Customers where CustomerID = @CustomerID)
begin 
print 'El cliente no existe'
return 
end 
begin try 
insert into Orders (CustomerID, OrderDate, RequiredDate)
values (@CustomerID, @OrderDate, @RequiredDate)
print 'Pedido registrado'
end try 
begin catch
print 'Error al actualisar stock'
return 
end catch
end 