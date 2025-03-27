use BDEJEMPLO2
-- realisar un trigger que se dispare cuando se inserte un pedido y modifique el stock del producto 
-- vendido, verificar si hay suficiente stock  si no se cancela el pedido  

select * from Pedidos
go
create or alter trigger tg_pedidos_insertar
on pedidos
after insert 
as 
begin 

declare @existencia int 
declare @fab char(3)
declare @prod char(5)
declare @cantidad int 

select @fab = fab, @prod = producto, @cantidad = Cantidad
from inserted

select @existencia = stock from Productos
where Id_fab = @fab and Id_producto = @prod

if @existencia > (select cantidad from inserted)
begin 

update Productos
set Stock = Stock - @cantidad
where Id_fab = @fab and Id_producto = @prod
end 
else
begin 
raiserror('NO hay suficientes stock para el pedido', 16,1)
rollback;

end 
end

select * from Pedidos
select * from Productos
select max(Num_Pedido) from Pedidos

declare @importe money 
select @importe = (p.Cantidad * pr.Precio)
from Pedidos as p join Productos as pr on p.Fab = pr.Id_fab and p.Producto = pr.Id_producto
insert into Pedidos (Num_Pedido, Fecha_Pedido, Cliente, rep, fab, Producto, Cantidad, Importe)
values (113071, GETDATE(), 2103, 106, 'aci', '41001', 77, @importe)

select * from Productos
where Id_fab = 'aci' and Id_producto = '41001'

select * from Pedidos
where Num_Pedido = 113071


-- Crear un triguer que cada ves que se elimine un pedido se debe actualisar stock de los productos con la cantidad eliminada 

go
create or alter trigger tg_pedidos_eliminar
on pedidos
after delete 
as 
begin 

declare @existencia int 
declare @fab char(3)
declare @prod char(5)
declare @cantidad int 

select @fab = fab, @prod = producto, @cantidad = Cantidad
from deleted

select @existencia = stock from Productos
where Id_fab = @fab and Id_producto = @prod

if @existencia > (select cantidad from inserted)
begin 

update Productos
set Stock = Stock + @cantidad
where Id_fab = @fab and Id_producto = @prod
end 
else
begin 
raiserror('NO hay suficientes stock para el pedido', 16,1)
rollback;

end 
end

select * from Pedidos
select * from Productos
select max(Num_Pedido) from Pedidos

declare @importe money 
select @importe = (p.Cantidad * pr.Precio)
from Pedidos as p join Productos as pr on p.Fab = pr.Id_fab and p.Producto = pr.Id_producto
insert into Pedidos (Num_Pedido, Fecha_Pedido, Cliente, rep, fab, Producto, Cantidad, Importe)
values (113071, GETDATE(), 2103, 106, 'aci', '41001', 77, @importe)

select * from Productos
where Id_fab = 'aci' and Id_producto = '41001'

select * from Pedidos
where Num_Pedido = 113071
