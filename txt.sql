go 
create or alter view [dbo].[VistaInformacionVentas]
as 
select OrderID as 'Numero de orden', ShippedDate as 'Fecha de oreden', concat(e.FirstName, '' ,e.LastName) as 'Nombre empleado', CustomerID as 'Cliente' from orders as c join Employees as e on c.EmployeeID = e.EmployeeID
go

select * from VistaInformacionVentas

go create or alter view [dbo].[VistaInformacionProductos]
as 
select p.ProductName as 'Nombre del Producto', p.UnitPrice as 'Precio del producto' from Products as p join Categories as c on p.CategoryID = c.CategoryID
go

-- Store Procedure
go 
create or alter procedure sp_ActualizarPrecioProducto
@productid int, @nprecio money
as 
begin 
if exists (select 1 from Products where producid = @productid )

begin 
	print 'el producto ya existe'
	return
end


