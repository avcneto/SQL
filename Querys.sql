-- 1 MOSTRE O TITULO E O NOME DO GENERO DE TODAS AS SERIES?
SELECT
	a.name,
    b.title
    
FROM genres AS a
LEFT JOIN series AS b ON b.genre_id = a.id;

-- 2 MOSTRE O TITULO DOS EPISODIOS,  OS NOMES E SOBRENOMES DOS ATORES QUE ATUAM EM CADA UM DELES.

SELECT 
	a.title,
    c.first_name,
    c.last_name
FROM episodes AS a
LEFT JOIN actor_episode AS b ON b.episode_id = a.id
LEFT JOIN actors AS c ON c.id = b.actor_id;

-- 3 MOSTRE O TITULO DE TODAS AS SERIES E O NUMERO TOTAL DE TEMPORADAS QUE CADA UM DELAS POSSUI.

SELECT 
	a.title,
   SUM(b.number) AS total_temporada 
FROM series AS a
JOIN seasons AS b ON b.serie_id = a.id
GROUP BY 1;

-- 4 MOSTRE O NOME DE TODOS OS GENEROS E O NUMERO DE FILMES DE CA UM, DESDE QUE SEJA MAIOR OU IGUAL A 3

SELECT 
	a.name,
    COUNT(title) AS total_filmes
FROM genres AS a 
LEFT JOIN movies AS b ON b.genre_id = a.id
GROUP BY 1
HAVING total_filmes >= 3;

-- MOSTRE APENAS O NOME E O SOBRENOME DOS ATORES QUE ATUAM EM TODOS OS FILMES GUERRA NAS ESTRELAS 
-- E QUE ESTES NÃO SE REPITAM.

sELECT 
	a.First_name,
    a.Last_name
    
fROM actors aS a 
jOIN movies aS b oN b.Id = a.Id
wHERE uPPER(B.Title) lIKE uPPER('%Guerra nas Estrelas%');

sELECT * fROM actors;
sELECT * fROM movies;
sELECT * fROM seasons;