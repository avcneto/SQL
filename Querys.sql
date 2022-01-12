-- 1 mostre o titulo e o nome do genero de todas as series?
select
	a.name,
    b.title
    
from genres as a
left join series as b on b.genre_id = a.id;

-- 2 mostre o titulo dos episodios,  os nomes e sobrenomes dos atores que atuam em cada um deles.

select 
	a.title,
    c.first_name,
    c.last_name
from episodes as a
left join actor_episode as b on b.episode_id = a.id
left join actors as c on c.id = b.actor_id;

-- 3 mostre o titulo de todas as series e o numero total de temporadas que cada um delas possui.

select 
	a.title,
   sum(b.number) as total_temporada 
from series as a
join seasons as b on b.serie_id = a.id
group by 1;

-- 4 mostre o nome de todos os generos e o numero de filmes de ca um, desde que seja maior ou igual a 3

select 
	a.name,
    count(title) as total_filmes
from genres as a 
left join movies as b on b.genre_id = a.id
group by 1
having total_filmes >= 3;

-- mostre apenas o nome e o sobrenome dos atores que atuam em todos os filmes guerra nas estrelas 
-- e que estes não se repitam.

select 
	a.first_name,
    a.last_name
    
from actors as a 
join movies as b on b.id = a.id
where upper(b.title) like upper('%guerra nas estrelas%');

-- 2 adicione um filme a tabela de filmes
insert into movies values (40,'2021-12-16 00:00:00',null,'homem-aranha: sem volta para casa',9.8,3,'2010-10-04 00:00:00',120,5);
update movies set title='naruto' where title = 'homem-aranha: sem volta para casa';

-- adicione um genero a tabela de generos 
insert into genres values (13,'2022-01-01 00:00:00',null,'anime',1,1);

-- associe o filme ex2. ao genero criado no ex3 
update movies set genre_id = 13 where id = 40;

-- modifique a tabela de atores para que pelo menos um ator tenha como favorito o filme adicionado no ex 2

update actors set favorite_movie_id = 40 where id = 45;

-- crie uma copia temporaria da tabela de filmes 

create temporary table if not exists movies_temp as (
select 
	* 
from movies
);

select * from movies_temp;

-- elimine desta tabela temporaria todos os filmes que ganharam menos de 5 premios
delete from movies_temp where awards > 5;

-- obter a lista de todos os generos que possuem pelo menos um filme
select 
	a.name,
    count(title) as total_filmes
from genres as a 
left join movies as b on b.genre_id = a.id
group by 1
having total_filmes > 0 ;

-- obter lista de atores cujo filme favorito ganhou mais de 3 premios
select 
	a.first_name,
    b.awards
    
from actors as a 
join movies as b on b.id = a.id
where awards > 3;

-- use o plano de excecução para analisar as consultas ex6 e ex7 
explain  select * from movies;

-- criar indice na tabela filmes;
alter table movies add index `title_index` (title);

-- verificar se o indice foi criado
show index from movies;
