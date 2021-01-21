======================= SUBCONSULTAS ================================


--========= DE UMA UNICA LINHA ========

-- aquela que retorna 0 ou uma linha para instruçao SQL externa 

-- Pode ser inserida em uma clausula WHERE HAVING ou FROM de uma instruçao SELECT 

--WHERE
SELECT id_empregado, nome, sobrenome, salario
FROM tb_empregado
WHERE id_empregado = (SELECT id_empregado 
                      FROM tb_empregado
                      WHERE nome = 'Arthur');
                      
--Utilizado o operador de = mas pode ser usado tambem(<>, <, >, <= e >=)

-- usando subconsulta para filtrar os salrios que s~ao maior que a media deles mesmos da tb_empregado

SELECT e.nome, e.salario, f.ds_funcao
FROM tb_empregado e
INNER JOIN tb_funcao f using(id_funcao)
WHERE salario > (SELECT avg(salario) 
                 FROM tb_empregado)
ORDER BY 2 desc;


--Identificou o preço medio dos salarios do funcionariros que trabalhao na mesma funcao;
SELECT id_funcao, avg(salario)
FROM tb_empregado
GROUP BY id_funcao;

-- HAVING
-- Filtra onde a media de salario deve ser menor que a m'axima das medias 
SELECT id_funcao, avg(salario)
FROM tb_empregado
GROUP BY id_funcao
HAVING avg(salario) < (SELECT MAX(AVG(salario))
                       FROM tb_empregado
                       GROUP BY id_funcao)
ORDER BY 2 desc; 

--FROM INLINE
--Nao pode ter order by na subconsulta

SELECT id_departamento 
FROM (SELECT id_departamento
      FROM tb_departamento 
      WHERE id_departamento < 30);

-- A consulta externa recupera  nome e id do departamento, j'a a consulta interna retorno o numero de empregados que nele contem      
SELECT d.nm_departamento,d.id_departamento, empregado.count
FROM tb_departamento d, (SELECT id_departamento, count(id_departamento) count
                         FROM tb_empregado
                         GROUP BY id_departamento) empregado
WHERE d.id_departamento = empregado.id_departamento
ORDER BY 1 desc;


--Mesmo resultado sem subconsulta
SELECT d.nm_departamento, e.id_departamento, count(e.id_departamento)
FROM tb_departamento d
INNER JOIN tb_empregado e on(e.id_departamento = d.id_departamento)
GROUP BY e.id_departamento , d.nm_departamento
ORDER BY 1 desc;


--Usando subconsulta no FROM para contar o numero de empregados que possuem cada funcao 
SELECT  empregado.id_funcao,f.ds_funcao, empregado.CONTADOR
FROM tb_funcao f , (SELECT id_funcao, count(id_funcao) CONTADOR
                  FROM tb_empregado
                  GROUP BY id_funcao) empregado
WHERE f.id_funcao = empregado.id_funcao;   