go 
create or alter view [dbo].[VistaInformacionVentas]
as 
select OrderID as 'Numero de orden', ShippedDate as 'Fecha de oreden', concat(e.FirstName, '' ,e.LastName) as 'Nombre empleado', CustomerID as 'Cliente' from orders as c join Employees as e on c.EmployeeID = e.EmployeeID
go

select * from VistaInformacionVentas

go 
create or alter view [dbo].[VistaInformacionProductos]
as 
select p.ProductName as 'Nombre del Producto', p.UnitPrice as 'Precio del producto' from Products as p join Categories as c on p.CategoryID = c.CategoryID
go

-- Store Procedure
go 
create or alter procedure sp_ActualizarPrecioProducto
@productid int, @nprecio money
as 
begin 
if not exists (select 1 from Products where ProductID = @productid )
begin 
print 'el producto no existe'
return
end
update Products
set UnitPrice = @nprecio
where ProductID = @productid
print 'Precio actualisado'
end;

exec sp_ActualizarPrecioProducto @productid = 5, @nprecio = 25.99;
--------------------------------------------------------------------------
go 
create or alter procedure sp_actualisar_precio_pedido2
@ProductID int, @NuevoPrecio money, @discontinued bit, @cantidad int
as 
begin 
-- Verificar si el producto existe 
if not exists (select 1 from Products where ProductID = @ProductID)
begin
print 'El producto no existe'
return 
end 

if @cantidad <= 0 
begin 
print 'La cantidad no puede ser 0 o negativa'
return 
end 
begin try 
-- Actualisar el precio y l acantidad del producto 
update Products
set UnitPrice = @NuevoPrecio, 
Discontinued = @discontinued, 
UnitsInStock = UnitsInStock - @cantidad
where ProductID = @ProductID;

print 'Producto actualizado correctamente'
end try
begin catch
print 'Error al actualizar datos'
return;
end catch
end;

exec sp_actualisar_precio_pedido2
    @ProductID = 1,         -- ID del producto a actualizar
    @NuevoPrecio = 20.50,   -- Nuevo precio del producto
    @discontinued = 0,      -- Indica si el producto está descontinuado (0 = No, 1 = Sí)
    @cantidad = 5;          -- Cantidad a restar del inventario

	-------------------------------------------------------------------------------------------------------------------------------
	-- 2 Store procedure  
	-- Aumenta el stock disponible de un producto.
	go 
	create or alter procedure sp_agregar_stock_producto
	@ProductID int, @CantidadAgregada smallint
	as 
	begin 
	-- Validacion de Existencia 
	if not exists (select 1 from Products where ProductID = @ProductID)
	begin 
	print 'El producto no existe'
	return
	end
	-- Validacion de cantidad positiva 
	if @CantidadAgregada <=0 
	begin 
	print 'La cantidad a agregar debe de ser mayor a 0'
	return 
	end 
	begin try 
	-- Actualisar stock
	update Products
	set UnitsInStock = UnitsInStock + @CantidadAgregada
	where ProductID = @ProductID
	print 'Stock actualisado'
	end try 
	begin catch
	print 'Error al actualisar stock'
	return 
	end catch
	end 

	select * from Products

	EXEC sp_agregar_stock_producto @ProductID = 1, @CantidadAgregada = 10

	-- 3 store procedure
	-- Cambia la categoría de un producto si la nueva categoría existe.
	go 
	create or alter procedure sp_cambiar_categoria_producto
	@ProductID int, @NuevaCategoriaID int
	as 
	begin 
	if not exists (select 1 from Products where ProductID = @ProductID)
	begin 
	print 'El producto no existe'
	return 
	end 
	if not exists (select 1 from Products where CategoryID = @NuevaCategoriaID)
	begin 
	print 'La categoria no existe'
	return 
	end 
	begin try 
	update Products
	set CategoryID = @NuevaCategoriaID
	where ProductID = @ProductID
	print 'categoria de producto actualisado correctamente'
	end try 
	begin catch
	print 'Error al actualiar categoria'
	return
	end catch
	end 

	select * from Products
	exec sp_cambiar_categoria_producto @ProductID = 3, @NuevaCategoriaID = 3;

	-- 4 store procedure 
	-- Actualiza el teléfono y país de un proveedor.
	go 
	create or alter procedure sp_actualizar_datos_proveedor
	@SupplierID int, @NuevoTelefono nvarchar(24), @NuevoPais nvarchar(15)
	as begin 
	if not exists (select 1 from Suppliers where SupplierID = @SupplierID)
	begin 
	print 'El provedor no existe'
	return
	end 
	if len (@NuevoTelefono) = 0 OR LEN(@NuevoPais) = 0
	begin
	print 'El telefono y el pais no pueden estar vacios'
	return 
	end
	begin try 
	update Suppliers
	set Phone = @NuevoTelefono, Country = @NuevoPais
	where SupplierID = @SupplierID
	print 'Telefono y pais del provedor actualisado correctamente'
	end try 
	begin catch
	print 'Error al actualiar datos del provedor'
	return 
	end catch 
	end 

	select * from Suppliers
	EXEC sp_actualizar_datos_proveedor @SupplierID = 5, @NuevoTelefono = '123-456-7890', @NuevoPais = 'México';






