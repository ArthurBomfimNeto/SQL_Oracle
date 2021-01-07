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
