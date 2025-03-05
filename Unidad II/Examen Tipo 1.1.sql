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
