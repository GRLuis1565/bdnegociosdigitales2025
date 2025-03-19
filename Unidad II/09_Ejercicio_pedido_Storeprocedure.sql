-- Realisar un pedido 
-- validar que el pediod no exista 
-- validar que el cliente exista, que el empleado y producto exista 
-- Validar que la cantidad a vender tengo suficiente stock 
-- insertar el pedido y calcular el immporte (multiplicando el precio del producto * la cantidad vendida)
-- actualizar el stock del producto(restando el stock menos la cantidad vendida)
go 
create or alter procedure spu_realisar_pedido
@numPedido int, @cliente int, @repre int, @fab char(3), @producto char(5), @cantidad int
as 
begin 
if exists (select 1 from Pedidos where Num_Pedido = @numPedido)
begin
print 'El pedido ya existe'
return
end
if not exists (select 1 from Clientes where Num_Cli = @cliente) and
	not exists (select 1 from Representantes where Num_Empl = @repre) and
	not exists (select 1 from Productos where Id_fab = @fab and Id_producto = @producto)
begin 
print 'Los datos no son validos'
return
end 

if @cantidad <=0 
begin
print 'La cantidad no puede ser negativa'
return
end 

declare @stockValido int 
select @stockValido = Stock from Productos where Id_fab = @fab and Id_producto = @producto

if @cantidad > @stockValido
begin
print 'No hay suficiente stock'
return
end
declare @precio money
declare @importe money
select @precio = Precio from Productos where Id_fab = @fab and Id_producto = @producto
set @importe = @cantidad * @precio
insert into Pedidos 
values (@numPedido, getDate(), @cliente ,@repre, @fab, @producto, @cantidad, @importe)
end

exec spu_realisar_pedido @numPedido = 113070, @cliente = 2117, @repre = 106, @fab = 'REI', @producto = '2A44L', @cantidad = 20

select * from Pedidos
select * from Representantes

--------------------------------------------------------------------------------------------------------------------------------------------------
go
create or alter procedure spu_realizar_pedido
@numPedido int, @cliente int,
@repre int, @fab char(3),
@producto char(5), @cantidad int 
as
begin
    if exists (select 1 from Pedidos where Num_Pedido = @numPedido)
	begin 
	print 'el pedido ya existe'
	return
end

 if not exists (select 1 from Clientes where Num_Cli = @cliente) and
    not exists (select 1 from Representantes where Num_Empl = @repre) and 
	not exists (select 1 from Productos where ID_fab = @fab and Id_producto =@producto)
	
	begin
	  print 'los datos no son validos'
	  return
	end

	if @cantidad<= 0
	 begin
	 print 'la cantidad no puede ser 0 o negativo'
	end 

	declare @stockValido int 
	select @stockValido stock from Productos where Id_fab = @fab and Id_producto =@producto

	if @cantidad > @stockValido
	begin
	   print 'no hay suficiente stock'
	   return
	end
	declare @precio money
	declare @importe money

	select @precio=precio from Productos where Id_fab = @fab and Id_producto = @producto
	set @importe = @cantidad + @precio

	begin try 

	-- se inserto un pedido
	insert into Pedidos
	values (@numPedido, getDate(),@cliente,@repre,@fab,@producto,@cantidad,@importe);
	
	update Productos 
	set Stock = Stock - @cantidad
	where Id_fab = @fab and Id_producto = @producto;

	end try
	begin catch 
	print 'error al actualizar datos'
	return;
	end catch

end;
exec spu_realizar_pedido @numPedido = 113070, @cliente =2117,
@repre=111, @fab = 'REI',
@producto = '2A44L', @cantidad =20

exec spu_realizar_pedido @numPedido = 113070, @cliente =2117,
@repre=101, @fab = 'ACI',
@producto = '4100x', @cantidad =20


if not exists (select 1 from Clientes where Num_Cli =2000)
print ('OK')

select * from Productos
where Id_fab = 'ACI' and Id_producto = '4100x'