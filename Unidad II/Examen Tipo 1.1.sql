use BDEJEMPLO2

-- 1
select c.Num_Cli as 'Numero cliente', c.Empresa, c.Limite_Credito, r.Num_Empl, r.Nombre as 'Numero respresentante' from Clientes as c 
join Representantes as r on c.Rep_Cli = r.Num_Empl where c.Limite_Credito > 5000
-- 2 
select * from Pedidos as p join Clientes as c on p.Cliente = c.Num_Cli where (p.Cantidad > 100) or p.Importe > 5000

-- 3
select o.Oficina ,  o.Region, o.Ciudad, r.Nombre from Oficinas as o join Representantes as r on o.Jef = r.Num_Empl 
where o.Region = 'este' or o.Region = 'oeste'

-- 4
select * from Clientes as c join Representantes as r on c.Rep_Cli = r.Num_Empl 

-- 5
select * from Clientes as c join Representantes as r on c.Rep_Cli = r.Num_Empl order by 2 desc

-- 6 
select c.Empresa, r.Nombre, p.Cantidad from Clientes as c join Pedidos as p on c.Num_Cli = p.Cliente join Representantes as r on p.Rep = r.Num_Empl where Cantidad > 3

--7 
select * from Representantes as r join Oficinas as o on r.Oficina_Rep = o.Oficina

-- 8 
select * from Oficinas as o join Representantes as r on o.Jef = r.Num_Empl

-- 9 
select * from Productos

-- 10 
select * from Clientes as c join Representantes as r on c.Rep_Cli = r.Num_Empl join Oficinas as o on r.Num_Empl = o.Jef 
join Pedidos as p on c.Num_Cli = p.Cliente where Cantidad > 3

----------------------------------------------------------------------------------------------------------------------------------
-- Practica examen 1.1 _ 1

-- 1. Clientes con límite de crédito mayor a 7000 y sus representantes

select c.Num_Cli, c.Limite_Credito, r.Nombre from Clientes as c join Representantes as r on c.Rep_Cli = r.Jefe where Limite_Credito >7000

-- 2. Pedidos con cantidad entre 50 y 200 o importe entre 3000 y 8000, con detalles del cliente

select p.Num_Pedido, p.Cantidad, p.Importe, c.Num_Cli, c.Empresa from Pedidos as p join Clientes as c on p.Cliente = c.Num_Cli where (p.Cantidad >= 50 and Cantidad <= 200) or (Importe >= 3000 and Importe <=8000) 
select p.Num_Pedido, p.Cantidad, p.Importe, c.Num_Cli, c.Empresa from Pedidos as p join Clientes as c on p.Cliente = c.Num_Cli where (p.Cantidad between 50 and 200) or (p.Importe between 3000 and 8000)

-- 3. Oficinas en la región 'Norte' o 'Sur', con detalles del jefe (ciudad y nombre)

select o.Oficina, o.Region, o.Jef, r.Nombre , o.Ciudad, r.Puesto from Oficinas as o join Representantes as r on o.Jef = r.Jefe where Region = 'Norte' or Region = 'Este'

-- 4. Clientes en ciudades como 'Sevilla', 'Valencia', 'Toledo', con detalles de su representante

select * from Clientes as c join Representantes as r on c.Rep_Cli = r.Jefe

-- 5. Pedidos con fecha en los últimos 30 días y que tengan un importe mayor a 4000

select * from Pedidos where  Fecha_Pedido >= dateadd(day, -30, getdate()) and Importe > 4000
-----------------------------------------------------------------------------------------------------------------------------------------

-- Practica examen 1.1 _ 2

-- 1. Clientes con límite de crédito mayor a 6000 y sus representantes
select c.Num_Cli, c.Limite_Credito, r.Num_Empl,r.Nombre from Clientes as c join Representantes as r on c.Rep_Cli = r.Jefe where c.Limite_Credito > 6000

-- 2. Pedidos con cantidad mayor a 15 o importe mayor a 7000, con detalles del cliente
select p.Num_Pedido, p.Cliente, p.Cantidad, p.Importe, c.Empresa from Pedidos as p join Clientes as c on p.Cliente = c.Num_Cli where p.Cantidad > 150 or p.Importe >7000

-- 3. Oficinas en las regiones 'Norte' o 'Oeste', con detalles del jefe (ciudad y nombre del jefe)
select o.Oficina, o.Region, r.Nombre, o.Ciudad from Oficinas as o join Representantes as r on o.Oficina = r.Oficina_Rep where Region = 'Norte' or Region = 'Oeste'

-- 4. Clientes en ciudades 'Navarra', 'Leon', 'Almeria', con detalles de su representante
select * from Clientes as c join Representantes as r on c.Rep_Cli = r.Num_Empl join Oficinas as o on r.Oficina_Rep = o.Oficina
where o.Ciudad in ('Navarra', 'Leon', 'Almeria')

-- 5. Clientes ordenados por límite de crédito en orden descendente con detalles de representante
select * from Clientes as c join Representantes as r on c.Rep_Cli = r.Num_Empl order by c.Limite_Credito desc

-- 6. Clientes con más de 3 pedidos, incluyendo detalles del representante y nombre del cliente
select c.Num_Cli, c.Empresa, r.Nombre, count(p.Num_Pedido) as 'Total de pedidos' from Pedidos as p join Representantes as r on p.Rep = r.Num_Empl join Clientes as c on p.Cliente = c.Num_Cli
group by c.Num_Cli, c.Empresa, r.Nombre
having count(p.Num_Pedido) > 3

-- 7. Representantes con ventas totales mayores a 15000, con detalles de oficina 
select r.Nombre, o.Oficina, sum(Importe) as 'Ventas totales' from Representantes as r join Oficinas as o on r.Num_Empl = o.Jef join Pedidos as p on r.Num_Empl = p.Rep
group by r.Nombre, o.Oficina
having sum(Importe) >15000

-- 8. Oficinas con más de 1 representantes por región
select o.Region, r.Nombre, count(o.Jef) as 'Total de representantes' from Oficinas as o join Representantes as r on o.Jef = r.Num_Empl
group by o.Region, r.Nombre
having count(o.Jef) > 1

-- 9. Productos con stock menor a 40, con detalles del fabricante
select Id_fab, Id_producto, sum(Stock) from Productos 
group by Id_fab, Id_producto
having sum(Stock) < 40

-- 10. Clientes con más de 3 pedidos, con detalles del representante y oficina
select c.Num_Cli, r.Nombre, o.Oficina, count(p.Num_Pedido) as 'Numero de pedidos' from Clientes as c join Pedidos as p on c.Num_Cli = p.Cliente join Representantes as r on p.Rep = r.Num_Empl join Oficinas as o on r.Num_Empl = o.Jef
group by c.Num_Cli, r.Nombre, o.Oficina
having count(p.Num_Pedido) > 3

