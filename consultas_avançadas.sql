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

--===================== CONEXÂO A BASE DE DADOS LOJA -===========================

INSERT INTO tb_estagiarios 
VALUES (SELECT id_empregado, id_departamento, nome , 'Y'
        FROM tb_empregado
        WHERE id_empregado < 130)