# MongoDB Crud
## Crear una base de datos
**Solo se crea si contiene por lo menos una coleccion**

```json
use base de datos
```

## Crear una coleccion

```json
use db1
db.createColeccion('Empleado')
```

## Mostrar colecciones 

```json
show collections
```

## Insercion de un documento 
db.Empleado.insertOne(
    {
        nombre:'Soyla'
        apellido:'Vaca'
        edad:
        ciudad:
    }
)

# Insercion de un documento mas complejo con array 
```json
db.empleado.insertOne({
    nombre:'Ivan',
    apellido:'Baltazar',
    apellido2:'Rodrigres',
    aficiones:['Cerveza', 'Canabis', 'Crico']
})

```

**Eliminar una collecion**
```json
db.coleccion.drop()
```
__Ejemplo__
```json
db.empleado.drop()
```

## Insercion de documentos mas complejos con anidados, arrays y ID

```json
db.alumnos.insertOne(
{
    nombre:'Luis',
    apellido:'Herreara',
    apellido2:'Gallardo',
    edad:41,
    estudios:[
        'Ingenieria en sistemas computacionales',
        'Maestria en tecnologias dde la informacion'
    ],
    experiencia:{
        lenguaje: 'sql',
        sbg: 'sqlServer',
        anios_expericia: 20
    }
})

```

```json
db.alumnos.insertOne({
    _id:3,
    nombre: 'Sergio',
    apellido: 'Ramos',
    equipo: 'Monterrey',
    aficiones:['Dinero', 'Hombres', 'Fiesta'],
    talentos:{
        futbol: true,
        banarse: false
    }
})
```
## Insertar multiples documentos ##
```json
db.alumnos.insertMany(
[
    {
        _id: 12,
        nombre: 'Oswaldo', 
        apellido:'Venavides',
        edad: 20,
        descripcion:'Es un quejumbroso'
    }, 

    {
        nombre: 'Maritza',
        apellido: 'Repollo',
        edad: 20,
        habilidades:['Ser vibora', 'Ilusionar', 'Caguamear'],
        direccion:{
            calle: 'del infieno',
            numero: 666
        },
        esposos:[
            {
                nombre: 'joshua',
                edad:20,
                persion: -34,
                hijos:['Ivan', 'Jose']
            },
            {
                nombre:'Leo',
                edad: 15,
                pension: 70,
                complaciente: true
            }
        ]
    }
])
```

# Busquedas, condiciones simples de igualdad Metodo find()

1. Seleccionar todos los documntos de la collecion libros

```json
db.libros.find({})
```

2. Seleccionar todos los documnetos que sean de la editorial biblio
```json
db.libros.find({editorial: 'Biblio'})
```

3. Mostrar todos los doccumentos que el precio sea 25 
```json
db.libros.find({precio : 25})
```

4. Seleccionar todos los documentos donde el titulo sea 'json para todos'
```json
db.libros.find({titulo : 'JSON para todos'})
```

## Operadores de comparacion

[Operadores de comparacion](https://www.mongodb.com/docs/manual/reference/operator/query/)

![Operadores de comparacion](./img/operadores-Relacionales.png)

1. Mostrar todos los documentos donde el precio sea mayor a 25 
```json
db.libros.find({precio: {$gt:25}})
```
2. Mostrar los documetos donde le precio sea 25 
```json
db.libros.find({precio: {$eq:25}})
```
3. Mostrar los documentos culla cantidad sea menor a 5 
```json
db.libros.find({cantidad: {$lt:5}})
```
4. Mostrar los documentos que pertenecen a la editorial biblio o planeta 
```json
db.libros.find({ editorial: { $in: ['Biblio', 'Planeta' ] } })
```

5. Mostrar todos los documentos de libros que cuesten 20 o 25 
```json
db.libros.find(
    { precio: { $in: [20, 25] } })
```

6. Recuperar todos los documentos que no cuesten 20 0 25 
```json
db.libros.find ({ precio: { $nin: [20, 25] } })
```

**Instruccion findOne**

7. Recuperar solo una fila (Devuelve el primer elemento que cumpla la condicion)
```json
db.libros.find(
    { precio: { $in: [20, 25] } })
```

## Operadores logicos 
[Operadores logicos](https://www.mongodb.com/docs/manual/reference/operator/query-logical/)

### Operador AND 
- Dos posibles opciones 
1. La forma simple mediante conciones separadas por comas 
- db.libros.find({condicion1, condicion2...}) Cons esto asume que es una and 
1.Usando el operador and 
```json
{ $and: [ { <expression1> }, { <expression2> } , ... , { <expressionN> } ] }
- db.libros.find({$and:[{condicion1}, {condicon2}]})
```
1. Mostrar todos aquellos libros que cuesten mas de 25 y cuya cantidad sea inferior a 15 
```json
db.libros.find(
    {precio:{&gt:25}, 
    cantidad:{$lt:15}
    }
    )

db.libros.find(
    $and:[
        {precio:{$gt:25}}, 
        {cantidad:{$lt:15}}, 
    ]
)
```

### Operador OR

- Mostrar todos aquellos libros que cuesten mas de 25 o cuya cantidad sea inferior a 15 

```json
{ $or: [ { <expression1> }, { <expression2> }, ... , { <expressionN> } ] }
```

```json
db.libros.find(
 {
   $or:[
    {
       precio: {$gt:25}
    },
    {
      cantidad:{$lt:15}
    }
      
  ]
 }
)
```

### Ejemplo con and y or combinados 

- Mostrar los libros de la editorial biblio con precio mayor a 40 o libros de la editorial planeta con precio mayor a 30 

```json
db.libros.find(
  {
    $and: [
      {$or :[{ editorial: 'Biblio'}, {precio: {$gt:30}}]},
      {$or: [{editorial: {$eq:'Planeta'}},{precio:{$gt:20}}]}
    ]
  }
)
```

### Proyeccion (ver ciertas columnas)
**Sintaxis**
db.collecion.find(filtro, columnas)

1. Seleccionar todos los libros solo mostrando el titulo 
```json
db.libros.find({}, {titulo:1})

db.libros.find({}, {titulo:1, _id:0})

db.getCollection('libros').find(
  { editorial: 'Planeta' },
  { _id: 0, titulo: 1, editorial: 1, precio: 1 }
);
```
## Operador exist (Permite saber si un campo se encuentra o no en un documento)
[Operador exist](https://www.mongodb.com/docs/manual/reference/operator/query/type/)
```json
{ field: { $exists: <boolean> } }
```
```json
db.libros.find({editorial:{$exists:true}})
```
```json
db.libros.insertOne(
    {
        _id:10,
        titulo: 'Mongo en Negocios Digitales',
        editorial:'Terra',
        precio: 125
    }
)
```
- Buscar todos los documentos que no tengan cantidad

```json
db.libros.find({
    cantidad:{exists:false}
})
```

## Operador type (Permite solicitar a MONGODB si un cmapo correcponde a un tipo)
[Operador type](https://www.mongodb.com/docs/manual/reference/operator/query/type/)

```json
db.libros.find({precio:{type:16}})
```
- Mostrar todos los documentos donde el precio sea de tipo double o entero o qualquir otro tipo de dato 
```json

db.libros.find({
    precio:{$type:"int"}
})
```
```json
db.libros.insertMany([
    {
        _id:12,
        titulo:'IA',
        editorial:'Terra', 
        precio:125,
        cantidad:20
    },
    {
        _id:13,
        titulo:'Pyton para todos',
        editorial:'2001', 
        precio:200,
        cantidad:30
    }
])
```

-- Seleccionar todos los documentos de libros donde la editorial sean strings
```json
db.libros.find({
    editorial:{$type:2}

})
```json
db.libros.find({
    editorial:{$type:16}

})
```
# Modificando documentos
## Comandos importantes 
1. UpdateOne - Modifica un solo documento
2. UpdateMany - Modificar multiples documentos 
3. ReplaceONe - sustituir el contenido completo de un docuemnto

Tiene el siguinte formato 

```json 
db.collection.updateOne(
{
    {filtro}
    {operador:}
})
```
[Operadores Update](https://www.mongodb.com/docs/manual/reference/operator/update/)

**Operador SET**

1. Modificar un docuemnto 
```json
db.libros.updateOne({titulo:'Python para todos'},
{
    $set:{titulo:'Java para todos'}
})
```
-- Modificar el documento con id 10 estableciendo el precio en 100 y la cantidad en 50
```json
db.libros.updateOne({_id:10},
{
    $set:{titulo:'Java para todos', precio:100, cantidad:50}
})
```
-- Utilizando el updateMany, modificar todos los libros donde el precio sea mayor a 100 y cambiarlo por 150
```json
db.libros.updateMany({precio:{$gt:100}},
{
    $set:{precio:150}
}
)
```
## Operadores $inc y $mul

--Incrementar todos los precios de los libros en 5 
```json
db.libros.updateMany({editorial:'Terra'}, {$inc:{precio:5}})
```

-- Multiplicar todos los libros donde la cantidad sea mayor a 20 en su cantidad por 2 $mul 
```json
db.libros.updateMany({cantidad:{$gt:20}},{$mul:{cantidad:2}})
```
-- Actualisar todos los libros multiplicando por 2 la cantidad y el precio de todos aquellos libros donde el precio sea mayor a 20 
```json
db.libros.updateMany({precio:{$gt:20}},{$mul:{cantidad:2, precio:2}})
```
## Reemplasar documentos (replaceOne)
-- Actualizar todo el docuemnto del id2 por el titulo de la tierra a la luna, autor jilio verne, editorial terra, precio 100

```json
db.libros.replaceOne({_id:2},{
    titulo:'De la tierra a la luna',
    autor:'Julio verne',
    editorial:'Terra',
    precio:100
})
```
## Borrador dde documentos
1. deleteOne -> Elimina un solo documento
2. deleteMany -> Elimina multiples documentos 

-- Eliminar el documento con el id 2 

```json 
db.libros.deleteOne({_id:2})
```

-- Eliminar todos los libros donde la cantidad es mayor a 150
```json 
db.libros.deleteMany({cantidad:{$gt:150}})
```

## Expreciones regulares

-- Seleccionar todos los libros que contengan un a t miniscula 

```json
db.libros.find({titulo:/t/})
```

-- Seleccionar todos los libros que en el titulo contengan la palabra json
```json
db.libros.find({titulo:/json/})
```

-- Seleccionar todos los libros que en titulo terminen con tos
```json
db.libros.find({titulo:/tos$/})
```

-- Seleccionar todos los libros que en titulo comiensen con j 
```json
db.libros.find({titulo:/^J/})
```
## Operador $regex
[Operador Regex](https://www.mongodb.com/docs/manual/reference/operator/query/regex/)

-- Seleccionar los libros que contengan la palbra "para" en el titulo
```json
db.libros.find({titulo:{$regex:'para'}})

db.libros.find({titulo:{$regex:/para/}})
```
-- Seleccionar todos los titulos que contengan la palabra json 
```json
db.libros.find({titulo:{$regex:'JSON'}})
db.libros.find({titulo:{$regex:/JSON/}})
```
- Distinguir entre mayusculas y minsculas 
```json
db.libros.find({titulo:{$regex:/json/i}})
db.libros.find({titulo:{$regex:/json/, $options:'i'}})
```
-- seleccionar todos los documentos de libros donde el titulo comiense con j y no distinga entre mayusculas y minisculas
```json
db.libros.find({titulo:{$regex:/^j/, $options:'i'}})
```
-- seleccionar todos los documentos de libros donde el titulo termine con "es" y no distinga entre mayusculas y minisculas
```json
db.libros.find({titulo:{$regex:/es$/, $options:'i'}})
```

## Otros metodos sort (ordenar documentos)
-- Ordnar los libros de manera asendente por el precio 
```json
db.libros.find({},{_id:0, titulo:1, precio:1}).sort({precio:1})
```
-- Ordnar los libros de manera desendente por el precio 
```json
db.libros.find({},{_id:0, titulo:1, precio:1}).sort({precio:-1})
```
-- Ordenar los libros de manera asendente por la editorial y de manera desendente por el precio mostrando el titulo el precio y la editorial 
```json
db.libros.find({},{_id:0, editorial:1, precio:1}).sort({editorial:1 ,precio:-1})
```

## Otros metodos skip, limit, size
```json
db.libros.find({}).size()

db.libros.find({titulo:{$regex:/^j/, $options:'i'}}).size()
```
-- Buscar todos los libros pero mostrando los primeros dos 
```json
db.libros.find({}).limit(2)
```
```json
db.libros.find({}).skip(2)
```
# Borrar colleciones y base de datos
```json
db.libros.drop()
db.dropDatabase()
```


