select pro.Descripcion, pro.Precio, pro.Id_fab, p.Fab, pro.Id_producto, p.Producto from Pedidos as p join Productos as pro on p.Fab = pro.Id_fab 
and p.Producto = pro.Id_producto

