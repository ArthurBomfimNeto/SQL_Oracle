------------- CONSULTAS AVANÇADAS ---------------------

CREATE TABLE tb_estagiarios(
  id_empregado       INTEGER,
  id_departamento    INTEGER,
  nm_produto         VARCHAR2(30) NOT NULL,
  disponivel         CHAR(1),
  PRIMARY KEY (id_empregado),
  FOREIGN KEY (id_departamento)
   REFERENCES tb_departamento(id_departamento)
);

ALTER TABLE tb_estagiarios
RENAME COLUMN nm_produto TO nome;


INSERT INTO tb_estagiarios(id_empregado, id_departamento,nome, disponivel)
VALUES (206, 110, 'William', 'Y');


INSERT INTO tb_estagiarios(id_empregado, id_departamento , nome, disponivel)
VALUES (205, 110, 'Shelley', 'Y');


INSERT INTO tb_estagiarios(id_empregado, id_departamento, nome, disponivel)
VALUES (203, NULL, 'Susan', 'N');

INSERT INTO tb_estagiarios
VALUES(202, 20, 'Pat', 'N');

INSERT INTO tb_estagiarios
VALUES(201, 20, 'Michael', 'Y');

COMMIT;


----============== CONEXÂO A BASE DE DADOS RH ====================
--========== UNION ALL 

-- recupera todas as linhas recuperadas pelas consultas incluindo as duplicadas 

SELECT id_empregado,id_departamento, nome
FROM tb_empregado
UNION ALL
SELECT id_empregado, id_departamento, nome
FROM tb_estagiarios;

--========= UNION ============

--Recupera apenas as linhas não duplicadas 

SELECT id_empregado, id_departamento, nome
FROM tb_empregado 
UNION
SELECT id_empregado, id_departamento, nome
FROM tb_estagiarios;

--============= INTERSECT =============

-- Retorna apenas as linhas que contam nas duas consultas 

SELECT id_empregado, id_departamento, nome
FROM tb_empregado
INTERSECT 
SELECT id_empregado, id_departamento, nome
FROM tb_estagiarios;

--============= MINUS ===========

--Recupera as linhas restantes, quando as linhas recuperadas pela segunda consultasao subtraidas  da primeira 
--retorna apenas os diferente 

SELECT id_empregado, id_departamento, nome
FROM tb_empregado
MINUS
SELECT id_empregado, id_departamento, nome
FROM tb_estagiarios;

--=============== CRIAÇÂO DA TABELA para combinar operações de conjunto  
CREATE TABLE tb_alteracoes_empregado (
id_empregado     integer,
id_departamento  integer,
nome             varchar2(50),
sobrenome        varchar2(50),
salario          number(8,2),
primary key(id_empregado),
foreign key(id_departamento)
references tb_departamento (id_departamento));


INSERT INTO tb_alteracoes_empregado
VALUES (206, 110, 'William','Gilzinho', 9000 );

INSERT INTO tb_alteracoes_empregado
VALUES (205, 110, 'Shelley Higgins','Neto', 11000 );

INSERT INTO tb_alteracoes_empregado
VALUES (203, 20, 'SUZANA','Marvis', 9000 );

INSERT INTO tb_alteracoes_empregado
VALUES (124, 50, 'Kevin','Ferreira', 5800 );

INSERT INTO tb_alteracoes_empregado
VALUES (114, 30, 'Denis','Raphaely', 11000 );

INSERT INTO tb_alteracoes_empregado
VALUES (118, 30, 'Guy','Haimundo', 2600 );

COMMIT;

--COMBINADO OS OPERADORES DE CONJUNTO REALIZANDO PRIMEIRO A UNIAO DEPOIS A INTERSECÇÂO 

(SELECT id_empregado, id_departamento, nome
FROM tb_empregado
UNION
SELECT id_empregado, id_departamento, nome
FROM tb_estagiarios)
INTERSECT
SELECT id_empregado, id_departamento, nome
FROM tb_alteracoes_empregado;

--REALIZANDO PRIMEIRO A INTERSECÇÂO DEPOIS A UNIAO


SELECT id_empregado, id_departamento, nome
FROM tb_empregado
UNION
(SELECT id_empregado, id_departamento, nome
FROM tb_estagiarios
INTERSECT
SELECT id_empregado, id_departamento, nome
FROM tb_alteracoes_empregado);

---========== TRANSLATE(x, da_string, para_string) -=============

-- encontra a string correposndente e substitui pela ultima

SELECT TRANSLATE('ARTHUR BOMFIM',
                 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
                  'EFGHIJKLMNOPQRSTUVWXYZABCD')
FROM dual;         

SELECT TRANSLATE (nome,
        'ABCDEFGIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzw',
         'EFGHIJKLMNOPQRSTUVWXYZABCDefghijklmnopqrstuvwxyzabcd')
FROM tb_empregado; 

--Pega os numero 12345 e converte 5 em 6, 4 em 7, 3 em 8, 2 em 9, 1 em 0

SELECT TRANSLATE(12345,
                 54321,
                 67890)
FROM dual;   

--=========== DECODE(valor, valor_pesquisa, resultado, valor_padrão) ===========

-- se o promeiro for igual a segundo retorna o terceiro se não retoena o quarto 
SELECT DECODE(1,1,2,3)
FROM dual;

-- Como primeiro e diferente do segundo retornou o quarto. 
SELECT DECODE(1,2,2,3)
FROM dual;


-- Verifica e o estagirio esta disponivel e retorna a mensgame equivalente

SELECT id_empregado, disponivel, DECODE(disponivel, 'Y', 'Estagiario disponivel', 'NÂO DISPONIVEL')
FROM tb_estagiarios;

SELECT id_empregado, DECODE(id_empregado,
                             206, 'WILIAM',
                             205, 'SHELEY',
                             202, 'PAT',
                             201, 'MICHAEL','ERRerroO')
FROM tb_estagiarios; 

--===CASE()
             
       
 SELECT id_empregado, id_departamento,
         CASE id_empregado
             WHEN 206 THEN 'WILIAM'
             WHEN 205 THEN 'SHELEY'
             WHEN 202 THEN 'PAT'
             WHEN 201 THEN 'MICHAEL'
             ELSE 'ERRerroO'
         END    
FROM tb_estagiarios; 

-- CASE de FORMA DIFERENTE 
SELECT id_empregado, id_departamento,
   CASE 
      WHEN id_empregado = 206 THEN 'WILIAM'
      WHEN id_empregado = 205 THEN 'SHEYLEY'
      WHEN id_empregado = 202 THEN 'PAT'
      WHEN id_empregado = 201 THEN 'MICHEL'
      ELSE 'Faill'
   END
FROM tb_estagiarios;   
             
       
       
       
SELECT id_empregado, nome, salario, 
        CASE 
           WHEN salario > 12000 THEN 'RICO'
           WHEN (salario > 3000 AND salario < 12000) THEN 'MEDIO'
           ELSE 'POBRE'
        END
FROM tb_empregado;   

--=============== Consultas HIERAQUICAS =============

-- MESMO RESULTADO DE FORMA DIFERENTE
SELECT e.id_empregado, e.id_gerente, e.nome || ' trabalha para ' || nvl(g.nome, 'Os acionistas')
FROM tb_empregado e
LEFT OUTER JOIN tb_empregado g ON (g.id_empregado = e.id_gerente)
ORDER BY 1;


--SEM UTILIZAÇÂO DO LEVEL apenas descobrindo os gerente e seus respectivos funcionarios 

SELECT id_empregado, id_gerente, nome,sobrenome
FROM tb_empregado
START WITH id_empregado =100
CONNECT BY PRIOR id_empregado = id_gerente
ORDER BY 1;

--UTILIZANDO O LEVEL 

SELECT LEVEL, id_empregado, id_gerente, nome, sobrenome 
FROM tb_empregado
START WITH id_empregado = 100
CONNECT BY PRIOR id_empregado = id_gerente
ORDER BY LEVEL;