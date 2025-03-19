-- VIEWS

-- SINTAXIS 
/*create view nombreVista
as 
select columnas 
from tabla
where condicion
*/

use Northwind

GO
create view VistaCategoriasTodas 
AS
select CategoryID, CategoryName, Description, Picture from Categories

GO
alter view VistaCategoriasTodas 
AS
select CategoryID, CategoryName, Description, Picture from Categories
where CategoryName = 'Beverages'
Go

select * from VistaCategoriasTodas

-- crear una vista que permita visualisar solamente a los clientes de mexico y brazil

go 
create view VistasClientesMB
as 
select * from Customers
where Country in ('mexico', 'brazil')
go

select distinct vcmb.Country from Orders as o join VistasClientesMB as vcmb
on vcmb.CustomerID = o.CustomerID

-- crear una vista que ccontenga los datos de todas las ordenes los productos, categorias de productos, en la orden calcular el importe

create or alter view [dbo].[vistaordenescompra]
as
select o.OrderID as 'numero de orden', o.OrderDate as 'fecha de orden', o.RequiredDate as 'fecha de requisicion' 
concat(e.FirstName, '', e.LastName) as 'nombre empleado',  from 
Categories as c 
join Products as p 
on c.CategoryID = p.CategoryID
join [Order Details] as od 
on od.ProductID = p.ProductID
join Orders as o 
on od.OrderID = o.OrderID
join Customers as cu on cu.CustomerID = o.CustomerID
join Employees as e on e.EmployeeID = o.EmployeeID

select count() from VistaCategoriasTodas

-- visata horizontal 
create or alter view rh.tablarh(
id int primary key, nombre nvarchar(50))

select from CategoryID, CategoryName from Categories as c join Products as p on c.CategoryID = p.Category ID

select * from rh.viewcategoriasproductos

-- vista 


