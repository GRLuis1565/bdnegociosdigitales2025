# MongoDB Crud
## Crear una base de datos
**Solo se crea si contiene por lo menos una coleccion**

```json
use base de datos
```

## Crear una coleccion

```use db1
db.createColeccion('Empleado')
```

## Mostrar colecciones 

```show collections
```

## Insercion de un documento 
db.Empleado.insertOne(
    {
        nombre:
        apellido:
        edad:
        ciudad:
    }
)