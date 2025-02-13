-- seleccionar todas las categorias y productos 
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
