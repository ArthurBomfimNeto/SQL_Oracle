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
