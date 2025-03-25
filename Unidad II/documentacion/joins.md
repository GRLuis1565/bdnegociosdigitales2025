# Ejercicios left join, right join, full join y cross join 

```sql
-- left join, right join, full join y cross join 
select * from Categories as c join Products as p on c.CategoryID = p.CategoryID where c.CategoryName = 'fast food'

select * from Categories

select c.CategoryName, c.CategoryID, p.CategoryID, p.ProductName from Categories as c left join Products as p on c.CategoryID = p.CategoryID

select * from Products

insert into Products (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
values ('Burger sabrosa', 1, 9, 'xyz', 68.7, 45, 12, 2 ,0)

insert into Products (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
values ('Guaracha sabrosa', 1, null, 'xyz', 68.7, 45, 12, 2 ,0)

-- listar los empleados y pedidos que han gestionado incluyendo los empleados que no han echo pedidos 
select * from Employees

select * from  Products as p left join Categories as c on p.CategoryID = c.CategoryID
```