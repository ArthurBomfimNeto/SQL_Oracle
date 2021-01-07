-============================= FUNÇOES AGREGADAS =================================


----AVG(x) retorna a media os salarioa

SELECT TRUNC(AVG(salario),2)
FROM tb_empregado;

--media dos salarios com 200 reais a mais em cada truncado par duas casa decimais
SELECT TRUNC(AVG(salario + 200),2)
FROM tb_empregado;


--remove valores identicos da coluna e faz a media 
SELECT round(AVG(distinct salario),2)
FROM tb_empregado;


---COUNT(x)

--conta os salrios duplicados fazendo media e soma dos mesmos 
SELECT salario, count(salario), avg(salario), sum(salario)
FROM tb_empregado
group by salario;

-- conta o numero de linhas da tabela
SELECT count(ROWNUM), count(*)
FROM tb_empregado
 
 
 -- MAX e MIN retorna o maior e menor em numero a ordem alfabetica em string e datas por tempo e ano 
 
 --Numero  retorna o maior e menor salario 
 SELECT MAX(salario), MIN(salario)
 FROM tb_empregado;
 
 -- retorna maior e menor salario do empregado e seus respectivos nomes 
 SELECT nome, salario 
 FROM tb_empregado
 where salario =(select MAX(salario) from tb_empregado) or salario = (select MIN(salario) from tb_empregado);
 
 
 --STRING retorna baseado ao alfabeto da primeira a ultima letra do mesmos
 SELECT MAX(nome), MIN(nome)
 FROM tb_empregado;
 
 
 --DATA maior e menor data de acordo com o ano 
 SELECT MAX(data_admissao) as "maior data", MIN(data_admissao) as "menor data"
 FROM tb_empregado


--Obtem o desvio padrao 
select stddev(salario)
from tb_empregado;

--SUM(x) soma de todos os valores

SELECT salario, count(salario), sum(salario)
FROM tb_empregado;

--VARIANCE(x)

SELECT VARIANCE(salario)
FROM tb_empregado;

-======================= AGRUPANDO LINHAS ========================

--GROUP BY agrupa as linhas identicas. 
--agrupando os nomes identicos e fazendo a contagem dos memso 
SELECT nome, count(nome)
FROM tb_empregado
GROUP BY nome;


--Agrupa duas colunas mas nesse caso n~ao tira nenhum proveito 
SELECT id_departamento, id_gerente
FROM tb_departamento 
GROUP BY id_departamento, id_gerente

--Agrupa colunas e faz sua contagem

SELECT id_localizacao, count(ROWID)
FROM tb_departamento
GROUP BY id_localizacao;

-- Agrupando salarios iguais e fazendo media soma e variance dos mesmos

SELECT salario, AVG(salario) media, SUM(salario) soma, VARIANCE(salario)
FROM tb_empregado
GROUP BY salario;

--[ERRO] nao se pode utilizar uma funçao agregada para limitar uma clausula WHERE 
--                           [ERRO]
SELECT id_localizacao, avg(id_localizacao)
FROM tb_departamento
WHERE avg(id_localizacao) > 50
GROUP BY id_localizacao;

--HAVING utilizar o mesmo para fazer filtros com o uso do GROUP BY

SELECT id_localizacao, avg(id_localizacao), SUM(id_localizacao)
FROM tb_departamento
GROUP BY id_localizacao
HAVING SUM(id_localizacao) > 50.00;


-- Utilizando WHERE e HAVING no mesmo script

SELECT id_departamento, salario, sum(salario)
FROM tb_empregado
WHERE id_departamento = 50
GROUP BY id_departamento, salario
HAVING avg(salario) = salario
order by 2;
