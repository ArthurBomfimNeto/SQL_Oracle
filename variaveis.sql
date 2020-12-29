--------------------- Variaveis -----------

describe tb_funcao;

--Variaveis temporarias e identificada pelo uso do E comercial "&"

-- buscas todos os campos de acordo com a base de salario passada na variavel 
select * 
from tb_funcao 
where base_salario > &_id_funcao;


-- Busca o campo passado na variavel 
select &_select
from tb_empregado ;

-- usando variaveis para colunas tabelas e id

select &_v_coluna
from &_v_tabela 
where &_v_coluna = &_id;

-- Utilizando dois && evita a repetiçao de determinada variavel 

select nm_departamento, &_v_nm_departamento, &&_v_id_departamento
from tb_departamento 
where &&_v_id_departamento between 30 and 50;

-- DEFINE define a variavel antes mesmo de chamala 

DEFINE v_id = 300 

select nome, id_empregado 
from tb_empregado 
where &v_id = all(100,200,288);

-- ACEEPT define a varivel com nome, tipo, formato, hide(oculto ou nao), prompt

ACCEPT v_id NUMBER FORMAT 99 PROMPT 'Entre com ID';

-- UNDEFINE remove a variavel; 

DEFINE v_id_dept = 10;

select d.nm_departamento, e.nome, e.salario 
from tb_empregado e 
inner join tb_departamento d using(id_departamento)
where id_departamento = &v_id_dept;

UNDEFINE v_id_dept;


-- CRIAR UM SCRIPT PARA RELATORIOS ROBUSTOS 

-- criado script Script_1.sql

--invocando script: 

@ \home\oracle\Script_1.sql

@ \home\oracle\Script_2.sql

@ \home\oracle\Script_3.sql

-- Passando como paremtro o conteudo da variavel 

@ \home\oracle\Script_4.sql 10; -- retorno o departamento com id 10

@ \home\oracle\Script_5.sql 180 4000;

    