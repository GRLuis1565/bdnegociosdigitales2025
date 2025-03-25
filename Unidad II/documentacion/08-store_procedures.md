# Ejercicios store procedures sql 
```sql
-- Crear un store procedure para seleccionar todos los clientes 
go
create or alter procedure spu_mostrar_clientes
as begin 
select * from Customers
end
Go

-- ejucutar un store en transact 
exec spu_mostrar_clientes

-- crear un sp que muestre los clientes por pais 
-- parametros de entrada 
go 
create or alter proc spu_custumersporpais
-- paramtros de entrada
@pais nvarchar(15), 
@pais2 nvarchar(15)
as begin 
select * from Customers where Country in( @pais, @pais2);
end;
-- ejucuta un store procedure
declare @p1 nvarchar(15) = 'spain';
declare @p2 nvarchar(15) = 'germany';
exec spu_custumersporpais @p1,@p2;

-- generar un reporte que permita visualsar los datos de compra de un determindo cliente, en un rango de fechas
-- mostrando el monto total de compras por producto, mediante un sp 

go
create or alter proc spu_informe_ventas_clientes 
-- parametros 
@nombre nvarchar (40) = 'Berglunds snabbkop',
@fechainicial DateTime,
@fechafinal DateTime
as
begin
select [nombre producto], sum (importe) as [monto total]
from vistaordenescompra 
where [Nombre del cliente] = @nombre
and [fecha de orden] between @fechainicial and @fechafinal
group by [nombre producto]
end;
go 


select * from Customers
select * from Orders
exec spu_informe_ventas_clientes
                             'Berglunds snabbkop',
							 '1996-02-02', '1997-01-01'
							 
exec spu_informe_ventas_clientes @fechainicial = '1996-07-04', @fechafinal = ''

--ejecucion de un store con parametros de entrada
exec spu_informe_ventas_clientes
                             'Berglunds snabbkop',
							 '1996-02-02', '1997-01-01'
								
--ejecucion de un store procedure con paramaetros en diferentes posicion
exec spu_informe_ventas_clientes @fechafinal = '1997-01-01', @nombre = 'Berglunds snabbkop', @fechainicial = '1996-02-02';

--ejecucion de un store procedure con parametros de entrada con un campo que tiene un valor por default 
exec spu_informe_ventas_clientes @fechainicial = '1996-07-04', @fechafinal = '1997-01-01'

-- store procedure con parametro de salida 
go
create or alter proc spu_obtener_numero_clientes 
@customerid nchar(5), -- parametro de entrada
@totalCustomers int output -- Parametro de salida 
as 
begin
select @totalCustomers = count(*) from customers
where CustomerID = @customerid;
end;
go

declare @numero as int;
exec spu_obtener_numero_clientes @customerid = 'ANATR', @totalCustomers = @numero output;
print @numero;
go

-- crear un store procedure que permita saber si un alumno aprobo o reprobo 
create or alter proc spu_comparar_calificacion 
@calif decimal(10,2) -- Parametro de entrada
as 
begin
	if @calif >= 0 and @calif <=10
	begin
		if @calif >= 8
	print 'La calificasion es aprovatoria'
	else 
	print 'La calificasion es reprobatoria'
	end
	else
	print 'Calificasion no valida'
	end
go 

exec spu_comparar_calificacion @calif = 11

-- Crear un sp que permita verificar si un cliente existe antes de devolver su informacion 
go 
create or alter proc spu_obtener_clientesi_exite
@numerocliente nchar(5)
as 
begin 
if exists (select 1 from Customers where CustomerID = @numeroCliente)
select * from Customers where CustomerID = @numerocliente;
else 
print 'El cliente no existe'
end
go 

select * from Customers
select 1 from Customers where CustomerID = 'arout'

exec spu_obtener_clientesi_exite @numerocliente = 'arout'

-- Crear un sp que permita insertar un cliente, pero se debe verificar primero que no exista 
select * from Customers
go
create or alter procedure spu_agregar_cliente
@id nchar(5),
@nombre nvarchar(40),
@city nvarchar(15) = 'San Miguel'
as
begin
if exists (select 1 from Customers where CustomerID = @id)
begin
print ('El cliente ya existe')
return 1
end
insert into Customers(CustomerID, companyname)
values(@id, @nombre);
print('Cliente insertado exitosamente')
return 0;
end
go

exec spu_agregar_cliente 'ALFKI', 'Patito de hule'
exec spu_agregar_cliente 'ALFKC', 'Patito de hule'

go 
create or alter procedure spu_agregar_cliente_try_catch
@id nchar(5),
@nombre nvarchar(40),
@city nvarchar(15) = 'San Miguel'
as
begin
begin try 
insert into Customers(CustomerID, companyname)
values(@id, @nombre);
print('Cliente insertado exitosamente')
end try 
begin catch
print ('El cliente ya existe')
end catch
end
go
exec spu_agregar_cliente 'ALFKD', 'Muneca vieja'

-- manejo de ciclos en stores 
-- imprimir el numero de veces que indique el usuario

create or alter procedure spu_imprimir 
@numero int 
as 
begin 
if @numero<=0 
begin
print ('El numero no puede ser 0 o negativo')
return 
end
declare @i int 
SET @i = 1 
while(@i<=@numero)
begin
print concat('Numero', @i)
set @i = @i + 1
end
end 
go
exec spu_imprimir 10 




```