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
WHERE f.id_funcao = empregado.id_funcao;   ~


--================== SUBCONSULTAS DE VARIAS LINHAS =====================

-- E utilizado para consultas de diversas linhas os operadores IN ANY ALL para tratamentos

SELECT id_departamento, nm_departamento
FROM tb_departamento
WHERE id_departamento IN (10,30,40);


-- Verifica se ha na listas da subconsultas id iguais, pois a mesma retorno so empregados que começam com a letra A
SELECT id_empregado, nome
FROM tb_empregado 
WHERE id_empregado IN (SELECT id_empregado 
                       FROM tb_empregado
                       WHERE nome like 'A%');


-- Usando o NOT IN para voltar os ids que n~ao estao presente na lista da sunconsulta. 

-- retorna as localizacao que n~ao contem nenhum departamento 

SELECT id_localizacao, endereco 
FROM tb_localizacao
WHERE id_localizacao NOT IN (SELECT id_localizacao
                             FROM tb_departamento);
                             
                             
describe tb_historico_funcao; 

describe tb_empregado;


SELECT nome, sobrenome
FROM tb_empregado 
WHERE data_admissao > ANY (SELECT data_termino
                           FROM tb_historico_funcao);
 
 
SELECT id_departamento, nm_departamento
FROM tb_departamento 
WHERE id_departamento NOT IN (SELECT nvl(id_departamento, '120')
                              FROM tb_empregado)
ORDER BY 1     

SELECT id_empregado, nome, salario, nm_departamento
FROm tb_empregado e
INNER JOIN tb_departamento d ON (e.id_departamento = d.id_departamento)
WHERE (nvl(d.id_departamento,'0'),salario) IN (SELECT nvl(id_departamento, '0'), MIN(salario)
                                    FROM tb_empregado
                                    GROUP BY id_departamento);


--================== SUBCONSULTAS CORRELACIONADAS ================================

SELECT id_empregado, nome, salario 
FROM tb_empregado externa
WHERE salario > (SELECT avg(salario)
                 FROM tb_empregado interna
                 WHERE externa.id_departamento = interna.id_departamento)
                 
    
    
--============= EXISTS e NOT EXISTS ====================

-- verirfica se a condição da subconsulta é verdadeira ou falso se V retorna se F não retorna 
--retorna todos funcionarios que gerenciam outros funcionarios
SELECT id_empregado,nome, sobrenome
FROM tb_empregado externa
WHERE EXISTS (SELECT 1
              FROM tb_empregado interna
              WHERE externa.id_gerente = interna.id_empregado);
              
-- Retorna o funcionario que não gerenciado por ninguém              
SELECT id_empregado,nome, sobrenome
FROM tb_empregado externa
WHERE NOT EXISTS (SELECT 1
                  FROM tb_empregado interna
                  WHERE externa.id_gerente= interna.id_empregado);
 
 --Retorna as localizações que contem departamentos              
SELECT id_localizacao  
FROM tb_localizacao externa
WHERE EXISTS (SELECT 1
              FROM tb_departamento interna
              WHERE externa.id_localizacao = interna.id_localizacao);
-- Retorna Localizaçoes que não contem departamentos               
SELECT id_localizacao  
FROM tb_localizacao externa
WHERE NOT EXISTS (SELECT 1
              FROM tb_departamento interna
              WHERE externa.id_localizacao = interna.id_localizacao);

