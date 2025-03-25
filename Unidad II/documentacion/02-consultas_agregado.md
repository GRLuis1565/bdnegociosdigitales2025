# Ejercicios consultas agregado

```sql
-- consultas de agregado 
-- nota: solo devuelven un solo registro sum, avg, count, count(*), max y min

use Northwind

-- cuantos clientes tengo 
select count(*) as 'Numero de clientes' from Customers 

-- cuantas regiones hay 
select count (*) from Customers where region is null

select count(distinct region) from Customers where region is not null

select count(*) from Orders
select count (ShipRegion) from Orders

-- selecciona el precio mas bajo de los productos 
select min(UnitPrice), max(UnitPrice) from Products

-- seleccionar cuantos pedidos existen 
select count(*) as 'Numero de pedidos' from Orders 

-- calcula el total de dinero vendido 
select sum(UnitPrice * Quantity) as 'Total' from [Order Details]
select sum(UnitPrice * Quantity-(UnitPrice * Quantity * Discount)) as 'Total con descuento' from [Order Details]

-- calcula el total de unidades en stock de todos los productos
select sum(UnitsInStock) as 'Total de stock' from Products

-- seleccionar el total del dinero que se gano en el ultimo trimestre de 1996 


-- order by 
-- seleccionar el numero de productos por categoria 
select CategoryID, count(*) from Products group by CategoryID

select Categories.CategoryName, count(*) from Categories inner join Products as p on Categories.CategoryID = p.CategoryID group by Categories.CategoryName

-- calcular el precio promedio de los productos por cada categoria 
select categoryid, avg(UnitPrice) as 'Precio promedio' from Products group by CategoryID

-- seleccionar el numero de pedidos realisados por cada empleado por el ultimo trimistre de 1996
select employeeid, count(*) from Orders group by EmployeeID
select employeeid, count(*) from Orders where OrderDate between '1996-01-10' and '1996-31-12' group by EmployeeID

-- seleccionar la suma total de unidades vendidas por cada producto 
select ProductID, sum(Quantity) from [Order Details] group by ProductID
select top 5 ProductID, sum(Quantity) as 'Numero de productos vendidos' from [Order Details] group by ProductID order by 2 desc
select OrderID ,ProductID, sum(Quantity) as 'Numero de productos vendidos' from [Order Details] group by OrderID ,ProductID order by 2 desc

-- seleccionar numero de productos por categoria pero solo aquellos que tengan mas de 10 productos 
-- paso 1 
select CategoryID from Products

--select distinct CategoryID from Products

-- paso 2
select CategoryID, UnitsInStock from Products where CategoryID in (2,4,8) order by CategoryID 
-- paso 3
select CategoryID, sum(UnitsInStock) from Products where CategoryID in (2,4,8) group by CategoryID order by CategoryID 
-- paso 4 
select CategoryID, sum(UnitsInStock) from Products where CategoryID in (2,4,8) group by CategoryID having count(*)>10 order by CategoryID 

--listar las ordenes agrupadas por empleado, pero que solo muestre aquellos que hayan gestionado mas de 10 pedidos 
select employeeid, count(*) from Orders group by EmployeeID having count(*)>10

```
