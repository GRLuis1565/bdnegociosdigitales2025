select * from categoria as c join producto as p on c.categoriaid = p.categoriaid

select * from categoria as c left join producto as p on c.categoriaid = p.categoriaid

select * from producto as p left join categoria as c on c.categoriaid = p.categoriaid

